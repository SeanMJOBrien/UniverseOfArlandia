#!/usr/bin/env python3
"""Builds export/uoa_ship_test.mod: a single-player test module for the ship combat
prototype (docs/SHIP_COMBAT_PROTOTYPE.md).

Needs the template module made with the nwn-mcp create_module / create_area tools:
    ~/nwn-data/user/modules/uoa_ship_test.mod  (area 'shiptest', ttr01, shore along the south)
and the scripts in tools/ship_test. Base game only: no haks. Run from the repo root.
Writes export/uoa_ship_test.mod.
"""
import copy, json, math, pathlib, shutil, subprocess, tempfile

ROOT = pathlib.Path(__file__).resolve().parent.parent
NWN = pathlib.Path("/home/qlippoth/git/nwn-tools/linux")
GFF, ERF, NWNSC = NWN / "neverwinter/nwn_gff", NWN / "neverwinter/nwn_erf", NWN / "nwnsc/nwnsc"
BASE = pathlib.Path("/home/qlippoth/git/uoaNasherReuse/nwn-base-scripts")
TEMPLATE = pathlib.Path.home() / "nwn-data/user/modules/uoa_ship_test.mod"
SCRIPTS = ROOT / "tools/ship_test"
OUT = ROOT / "export/uoa_ship_test.mod"
AREA = "shiptest"

# Placeable appearances (placeables.2da rows): the three "Ship - Tiny" models and the gong.
SHIPS = [  # tag index, name, appearance, cell x, cell y, heading (0 east, 90 degree steps counter-clockwise)
    (1, "Gull", 15322, 10, 6, 2),
    (2, "Skiff", 15323, 4, 15, 6),
    (3, "Reaver", 15324, 16, 14, 4),
]
GONG_APPEARANCE = 67
CELL = 5.0

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

def link(index, script=""):
    return {"__struct_id": 0, "Active": s("resref", script), "Index": s("dword", index), "IsChild": s("byte", 0)}

def node(text, links, key, script=""):
    return {"__struct_id": 0, "Animation": s("dword", 0), "AnimLoop": s("byte", 1), "Comment": s("cexostring", ""),
            "Delay": s("dword", 4294967295), key: s("list", links), "Quest": s("cexostring", ""),
            "Script": s("resref", script), "Sound": s("resref", ""), "Text": loc(text)}

def dialog(entries, replies, starting):
    for i, e in enumerate(entries): e["__struct_id"] = i
    for i, r in enumerate(replies): r["__struct_id"] = i
    return {"__data_type": "DLG ", "DelayEntry": s("dword", 0), "DelayReply": s("dword", 0),
            "EndConverAbort": s("resref", ""), "EndConversation": s("resref", ""),
            "EntryList": s("list", entries), "NumWords": s("dword", 0), "PreventZoomIn": s("byte", 0),
            "ReplyList": s("list", replies), "StartingList": s("list", starting)}

def pilot_dialog():
    entries = [node("I have steered boats since I could walk. Want me at the helm?", [link(0), link(1), link(2)], "RepliesList"),
               node("Aye. Tell me where to go once the bell rings.", [link(0), link(1), link(2)], "RepliesList"),
               node("I will wait here.", [link(0), link(1), link(2)], "RepliesList")]
    replies = [node("Join me.", [link(1)], "EntriesList", "act_ship_hire"),
               node("Wait here.", [link(2)], "EntriesList", "act_ship_dismiss"),
               node("Farewell.", [], "EntriesList")]
    return dialog(entries, replies, [link(0)])

def placeable(base, tag, name, appearance, desc, useable=False, onused="", comment=""):
    p = copy.deepcopy(base)
    p.pop("ItemList", None)
    p["Tag"], p["TemplateResRef"] = s("cexostring", tag), s("resref", tag)
    p["LocName"], p["Description"] = loc(name), loc(desc)
    p["Appearance"] = s("dword", appearance)
    p["Comment"] = s("cexostring", comment)
    p["Useable"], p["HasInventory"], p["Static"], p["Plot"] = s("byte", int(useable)), s("byte", 0), s("byte", 0), s("byte", 1)
    p["OnUsed"], p["OnClosed"], p["OnOpen"] = s("resref", onused), s("resref", ""), s("resref", "")
    return p

def creature(base, resref, first, last, race, appearance, convo):
    c = copy.deepcopy(base)
    c["Equip_ItemList"] = s("list", [])
    c["Tag"], c["TemplateResRef"] = s("cexostring", resref), s("resref", resref)
    c["FirstName"], c["LastName"] = loc(first), loc(last)
    c["Race"], c["Appearance_Type"] = s("byte", race), s("word", appearance)
    c["Conversation"] = s("resref", convo)
    c["VarTable"] = s("list", [])
    c["Plot"] = s("byte", 0)
    c["ClassList"] = s("list", [{"__struct_id": 2, "Class": s("int", 4), "ClassLevel": s("short", 3)}])
    c["HitPoints"] = c["CurrentHitPoints"] = c["MaxHitPoints"] = s("short", 30)
    hs = json.loads((ROOT / "src/utc/hench000.utc.json").read_text())
    for k, v in hs.items():
        if k.startswith("Script"): c[k] = v
    return c

def instance(blueprint, struct_id):
    d = copy.deepcopy(blueprint)
    d.pop("__data_type", None)
    d["__struct_id"] = struct_id
    return d

def main():
    work = pathlib.Path(tempfile.mkdtemp())
    res = work / "res"; res.mkdir()
    run(ERF, "-x", "-f", TEMPLATE, cwd=res)

    # scripts: sources go in the module, the compiled ones too
    for src in sorted(SCRIPTS.glob("*.nss")):
        shutil.copy(src, work / src.name)
    for src in sorted(SCRIPTS.glob("*.nss")):
        shutil.copy(src, res / src.name)
        if src.name in ("sc_inc.nss", "sc_nui.nss"): continue
        run(NWNSC, "-i", ".", "-i", BASE, "-b", res, src.name, cwd=work)

    shelf = json.loads((ROOT / "src/utp/lang_bookshelf.utp.json").read_text())
    ships = {}
    for index, name, appearance, cx, cy, head in SHIPS:
        tag = f"sc_ship_{index}"
        ships[index] = placeable(shelf, tag, name, appearance, f"A small model ship, the {name}.", comment="Ship combat prototype: see sc_inc.nss.")
        to_gff({"__data_type": "UTP ", **{k: v for k, v in ships[index].items() if k != "__data_type"}}, res / f"{tag}.utp")
    gong = placeable(shelf, "sc_bell", "Battle Gong", GONG_APPEARANCE, "Strike the gong to start the battle.", useable=True, onused="sc_bell_use")
    to_gff({"__data_type": "UTP ", **{k: v for k, v in gong.items() if k != "__data_type"}}, res / "sc_bell.utp")

    goblin = json.loads((ROOT / "src/utc/lang_goblin.utc.json").read_text())
    garrick = creature(goblin, "sc_pilot", "Garrick", "the Pilot", 0, 0, "sc_pilot")
    to_gff({"__data_type": "UTC ", **{k: v for k, v in garrick.items() if k != "__data_type"}}, res / "sc_pilot.utc")
    to_gff(pilot_dialog(), res / "sc_pilot.dlg")

    git = from_gff(res / f"{AREA}.git")
    placeables = []
    for index, name, appearance, cx, cy, head in SHIPS:
        x, y = (cx + 0.5) * CELL, (cy + 0.5) * CELL
        p = instance(ships[index], 9)
        p["X"], p["Y"], p["Z"] = s("float", x), s("float", y), s("float", 0.0)
        p["Bearing"] = s("float", math.radians(head * 45))
        placeables.append(p)
    g = instance(gong, 9)
    g["X"], g["Y"], g["Z"] = s("float", 44.0), s("float", 8.0), s("float", 0.0)
    g["Bearing"] = s("float", math.pi / 2)
    placeables.append(g)
    creatures = []
    c = instance(garrick, 4)
    c["XPosition"], c["YPosition"], c["ZPosition"] = s("float", 56.0), s("float", 8.0), s("float", 0.0)
    c["XOrientation"], c["YOrientation"] = s("float", 0.0), s("float", 1.0)
    creatures.append(c)
    git["Creature List"] = s("list", creatures)
    git["Placeable List"] = s("list", placeables)
    to_gff(git, res / f"{AREA}.git")

    ifo = from_gff(res / "module.ifo")
    ifo["Mod_Area_list"] = s("list", [{"__struct_id": 6, "Area_Name": s("resref", AREA)}])
    ifo["Mod_Entry_Area"] = s("resref", AREA)
    ifo["Mod_Entry_X"], ifo["Mod_Entry_Y"], ifo["Mod_Entry_Z"] = s("float", 50.0), s("float", 6.0), s("float", 0.0)
    ifo["Mod_Entry_Dir_X"], ifo["Mod_Entry_Dir_Y"] = s("float", 0.0), s("float", 1.0)
    ifo["Mod_OnClientEntr"] = s("resref", "sc_on_enter")
    ifo["Mod_Description"] = loc("Single-player test module for the ship combat prototype. See docs/SHIP_COMBAT_PROTOTYPE.md.")
    # ship_scale_pct: size of the ship models on the water; ship_yaw_offset: degrees added to a ship's heading
    ifo["VarTable"] = s("list", [var("ship_scale_pct", "int", 300), var("ship_yaw_offset", "int", 0)])
    to_gff(ifo, res / "module.ifo")
    for ext in ("are", "gic", "git"):
        (res / f"_start.{ext}").unlink(missing_ok=True)

    OUT.parent.mkdir(exist_ok=True)
    OUT.unlink(missing_ok=True)
    files = sorted(p.name for p in res.iterdir())
    run(ERF, "-c", "-f", OUT, "-e", "MOD", *files, cwd=res)
    print("Built", OUT, len(files), "resources")
    shutil.rmtree(work)

main()
