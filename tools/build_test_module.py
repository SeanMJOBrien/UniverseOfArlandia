#!/usr/bin/env python3
"""Builds export/uoa_language_test.mod: a 3x3 City Exterior cobble area with the
language system, test NPCs and a chest holding every book.

Needs export/uoa_language_system_nwscript.erf (tools/build_language_erf.sh) and
the template module made by the nwn-mcp create_module tool:
    ~/nwn-data/user/modules/uoa_language_test.mod  (with the area 'langtest')
Run from the repo root. Writes export/uoa_language_test.mod.
"""
import copy, json, pathlib, shutil, subprocess, sys, tempfile

ROOT = pathlib.Path(__file__).resolve().parent.parent
NWN = pathlib.Path("/home/qlippoth/git/nwn-tools/linux")
GFF, ERF, NWNSC = NWN / "neverwinter/nwn_gff", NWN / "neverwinter/nwn_erf", NWN / "nwnsc/nwnsc"
BASE = pathlib.Path("/home/qlippoth/git/uoaNasherReuse/nwn-base-scripts")
TEMPLATE = pathlib.Path.home() / "nwn-data/user/modules/uoa_language_test.mod"
PKG = ROOT / "export/uoa_language_system_nwscript.erf"
OUT = ROOT / "export/uoa_language_test.mod"

def s(k, v): return {"type": k, "value": v}
def loc(t): return s("cexolocstring", {"0": t})
def run(*a, **kw): subprocess.run([str(x) for x in a], check=True, **kw)

def to_gff(data, path):
    tmp = path.with_suffix(path.suffix + ".json")
    tmp.write_text(json.dumps(data))
    run(GFF, "-i", tmp, "-o", path)
    tmp.unlink()

def from_gff(path):
    tmp = path.with_suffix(path.suffix + ".json")
    run(GFF, "-i", path, "-o", tmp, "-k", "json", "-p")
    data = json.loads(tmp.read_text()); tmp.unlink()
    return data

def var(name, kind, value):
    t = {"int": (1, "int"), "string": (3, "cexostring")}[kind]
    return {"__struct_id": 0, "Name": s("cexostring", name), "Type": s("dword", t[0]), "Value": s(t[1], value)}

# --- dialogs -------------------------------------------------------------
def link(index, script="", params=None):
    d = {"__struct_id": 0, "Active": s("resref", script), "Index": s("dword", index), "IsChild": s("byte", 0)}
    if params:
        d["ConditionParams"] = s("list", [{"__struct_id": 0, "Key": s("cexostring", k), "Value": s("cexostring", str(v))} for k, v in params.items()])
    return d

def node(text, links, key, script="", params=None):
    d = {"__struct_id": 0, "Animation": s("dword", 0), "AnimLoop": s("byte", 1), "Comment": s("cexostring", ""),
         "Delay": s("dword", 4294967295), key: s("list", links), "Quest": s("cexostring", ""),
         "Script": s("resref", script), "Sound": s("resref", ""), "Text": loc(text)}
    if params:
        d["ActionParams"] = s("list", [{"__struct_id": 0, "Key": s("cexostring", k), "Value": s("cexostring", str(v))} for k, v in params.items()])
    return d

def dialog(entries, replies, starting):
    for i, e in enumerate(entries): e["__struct_id"] = i
    for i, r in enumerate(replies): r["__struct_id"] = i
    return {"__data_type": "DLG ", "DelayEntry": s("dword", 0), "DelayReply": s("dword", 0),
            "EndConverAbort": s("resref", ""), "EndConversation": s("resref", ""),
            "EntryList": s("list", entries), "NumWords": s("dword", 0), "PreventZoomIn": s("byte", 0),
            "ReplyList": s("list", replies), "StartingList": s("list", starting)}

def tester_dialog():
    """Same menu as Gruk's (tools/gruk_dialog.py) with a neutral greeting."""
    src = json.loads((ROOT / "src/dlg/lang_demo.dlg.json").read_text())
    greet = "Greetings, <race> traveller. I can speak any tongue you like. Pick one and I will say something."
    for st in src["StartingList"]["value"]:
        for p in st["ConditionParams"]["value"]:
            if p["Key"]["value"] == "text": p["Value"]["value"] = greet
    for e in src["EntryList"]["value"]:
        pass
    for r in src["ReplyList"]["value"]:
        if "Farewell" in r["Text"]["value"]["0"]: r["Text"]["value"]["0"] = "Farewell."
    for st in [src["StartingList"]["value"][0]] + [l for r in src["ReplyList"]["value"] for l in r["EntriesList"]["value"]]:
        for p in st.get("ConditionParams", s("list", []))["value"]:
            if p["Key"]["value"] == "text":
                p["Value"]["value"] = p["Value"]["value"].replace("Gruk say:", "I say:")
    return src

def hire_dialog():
    entries = [node("Aye, I know a few tongues. Want me along to translate?", [link(0), link(1), link(2)], "RepliesList"),
               node("Lead on. I will interpret what I can.", [link(0), link(1), link(2)], "RepliesList"),
               node("I will wait here.", [link(0), link(1), link(2)], "RepliesList")]
    replies = [node("Join me.", [link(1)], "EntriesList", "act_lang_hire"),
               node("Wait here.", [link(2)], "EntriesList", "act_lang_dismiss"),
               node("Farewell.", [], "EntriesList")]
    return dialog(entries, replies, [link(0)])

# --- creatures -----------------------------------------------------------
def creature(base, resref, first, last, race, appearance, convo, variables, hench=False, desc=""):
    c = copy.deepcopy(base)
    c["Equip_ItemList"] = s("list", [])
    c["Tag"], c["TemplateResRef"] = s("cexostring", resref), s("resref", resref)
    c["FirstName"], c["LastName"] = loc(first), loc(last)
    c["Race"], c["Appearance_Type"] = s("byte", race), s("word", appearance)
    c["Conversation"] = s("resref", convo)
    c["VarTable"] = s("list", variables)
    c["Comment"] = s("cexostring", desc)
    if hench:
        c["Plot"] = s("byte", 0)
        c["ClassList"] = s("list", [{"__struct_id": 2, "Class": s("int", 4), "ClassLevel": s("short", 3)}])
        c["HitPoints"] = c["CurrentHitPoints"] = c["MaxHitPoints"] = s("short", 30)
        hs = json.loads((ROOT / "src/utc/hench000.utc.json").read_text())
        for k, v in hs.items():
            if k.startswith("Script"): c[k] = v
    return c

def instance(blueprint, x, y, z, ox, oy, struct_id):
    d = copy.deepcopy(blueprint)
    d.pop("__data_type", None)
    d["__struct_id"] = struct_id
    return d

def main():
    work = pathlib.Path(tempfile.mkdtemp())
    res = work / "res"; res.mkdir()
    run(ERF, "-x", "-f", TEMPLATE, cwd=res)
    pkg = work / "pkg"; pkg.mkdir()
    run(ERF, "-x", "-f", PKG, cwd=pkg)

    # language system: everything in the package, its palettes replace the template's
    for f in pkg.iterdir():
        if f.name == "lang_readme.txt": continue
        shutil.copy(f, res / f.name)

    # test scripts
    for n in ("act_lang_hire", "act_lang_dismiss"):
        shutil.copy(ROOT / f"tools/language_test/{n}.nss", res / f"{n}.nss")
        shutil.copy(ROOT / f"tools/language_test/{n}.nss", work / f"{n}.nss")
        run(NWNSC, "-i", ".", "-i", BASE, "-b", res, f"{n}.nss", cwd=work)

    # blueprints
    goblin = json.loads((ROOT / "src/utc/lang_goblin.utc.json").read_text())
    thorin = creature(goblin, "lang_thorin", "Thorin", "the Dwarf (trainer)", 0, 0, "lang_tester",
                      [var("lang_trainer", "int", 1)], desc="Dwarf language tester. lang_trainer = 1: gives exposure in PC-only mode.")
    elara = creature(goblin, "lang_elara", "Elara", "the Elf", 1, 1, "lang_tester", [],
                     desc="Elf language tester. An ordinary NPC (no lang_trainer).")
    boddy = creature(goblin, "lang_boddy", "Boddyknock", "the Interpreter", 0, 0, "lang_hire",
                     [var("lang_known", "string", ",6:6,1:3,7:6,")], hench=True,
                     desc="Dwarf henchman. Dwarven 6 (racial), Goblin 6, Elven 3, Draconic 6 (lang_known).")
    gruk = copy.deepcopy(goblin); gruk["Equip_ItemList"] = s("list", [])
    for name, c in (("lang_thorin", thorin), ("lang_elara", elara), ("lang_boddy", boddy)):
        to_gff({"__data_type": "UTC ", **{k: v for k, v in c.items() if k != "__data_type"}}, res / f"{name}.utc")
    to_gff(gruk, res / "lang_goblin.utc")
    to_gff(tester_dialog(), res / "lang_tester.dlg")
    to_gff(hire_dialog(), res / "lang_hire.dlg")

    shelf = json.loads((ROOT / "src/utp/lang_bookshelf.utp.json").read_text())
    chest = copy.deepcopy(shelf)
    chest["Appearance"] = s("dword", 7)
    chest["Tag"], chest["TemplateResRef"] = s("cexostring", "lang_chest"), s("resref", "lang_chest")
    chest["LocName"] = loc("Book Chest")
    chest["Description"] = loc("Every language book, six volumes each. Take a volume and activate it to study. Closing the chest restocks it.")
    chest["Comment"] = s("cexostring", "Contains one of each lang_book_* item; lang_shelf_fill restocks it.")
    to_gff({"__data_type": "UTP ", **{k: v for k, v in chest.items() if k != "__data_type"}}, res / "lang_chest.utp")

    # the area
    git = from_gff(res / "langtest.git")
    creatures, placeables = [], []
    def put_creature(bp, x, y, ox, oy):
        d = instance(bp, x, y, 0.0, ox, oy, 4)
        d["XPosition"], d["YPosition"], d["ZPosition"] = s("float", x), s("float", y), s("float", 0.0)
        d["XOrientation"], d["YOrientation"] = s("float", ox), s("float", oy)
        creatures.append(d)
    put_creature(gruk, 8.0, 20.0, 0.0, -1.0)
    put_creature(thorin, 22.0, 20.0, 0.0, -1.0)
    put_creature(elara, 15.0, 15.0, 0.0, -1.0)
    put_creature(boddy, 15.0, 9.0, 0.0, -1.0)
    c = instance(chest, 15.0, 26.0, 0.0, 0, 0, 9)
    c["X"], c["Y"], c["Z"], c["Bearing"] = s("float", 15.0), s("float", 26.0), s("float", 0.0), s("float", 3.14159)
    placeables.append(c)
    git["Creature List"] = s("list", creatures)
    git["Placeable List"] = s("list", placeables)
    to_gff(git, res / "langtest.git")

    # the module
    ifo = from_gff(res / "module.ifo")
    ifo["Mod_Area_list"] = s("list", [{"__struct_id": 6, "Area_Name": s("resref", "langtest")}])
    ifo["Mod_Entry_Area"] = s("resref", "langtest")
    ifo["Mod_Entry_X"], ifo["Mod_Entry_Y"], ifo["Mod_Entry_Z"] = s("float", 15.0), s("float", 4.0), s("float", 0.0)
    ifo["Mod_Entry_Dir_X"], ifo["Mod_Entry_Dir_Y"] = s("float", 0.0), s("float", 1.0)
    ifo["Mod_OnPlrChat"] = s("resref", "lang_on_chat")
    ifo["Mod_OnActvtItem"] = s("resref", "lang_on_act")
    ifo["Mod_OnClientEntr"] = s("resref", "lang_on_enter")
    ifo["Mod_Description"] = loc("Single-player test module for the language system. See docs/LANGUAGE_TEST_MODULE.md.")
    settings = [("lang_exp_on", 1), ("lang_exp_unit", 2), ("lang_exp_cooldown", 2),
                ("lang_interp_on", 1), ("lang_tutor_on", 1)]
    ifo["VarTable"] = s("list", [var(k, "int", v) for k, v in settings])
    to_gff(ifo, res / "module.ifo")
    for ext in ("are", "gic", "git"):
        (res / f"_start.{ext}").unlink(missing_ok=True)

    OUT.unlink(missing_ok=True)
    files = sorted(p.name for p in res.iterdir())
    run(ERF, "-c", "-f", OUT, "-e", "MOD", *files, cwd=res)
    print("Built", OUT, len(files), "resources")
    shutil.rmtree(work)

main()
