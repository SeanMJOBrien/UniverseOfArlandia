#!/usr/bin/env python3
"""List the language blueprints in the toolset palettes (Special > Custom 5).

Sets PaletteID 4 (Custom 5) on the language books, the bookshelf and Gruk, and
adds a palette entry for each to src/itp/{item,placeable,creature}palcus.itp.json.
Safe to re-run; tools/lang_books.py runs it after generating the books.
"""
import json, pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
SPECIAL_STRREF = 6687   # "Special"
CUSTOM5_ID = 4          # "Custom 5"

def loc_name(d):
    for key in ("LocalizedName", "LocName", "FirstName"):
        if key in d: return d[key]["value"].get("0", "")
    return d["Tag"]["value"]

def blueprints(folder, pattern):
    out = []
    for f in sorted((ROOT / "src" / folder).glob(pattern)):
        d = json.loads(f.read_text())
        d["PaletteID"] = {"type": "byte", "value": CUSTOM5_ID}
        f.write_text(json.dumps(d, indent=2) + "\n")
        if folder == "utc":
            name = loc_name(d) + " " + d.get("LastName", {}).get("value", {}).get("0", "")
        else:
            name = loc_name(d)
        out.append((name.strip(), d["TemplateResRef"]["value"]))
    return out

def add(palette, entries):
    path = ROOT / "src/itp" / (palette + "palcus.itp.json")
    d = json.loads(path.read_text())
    special = next(s for s in d["MAIN"]["value"] if s.get("STRREF", {}).get("value") == SPECIAL_STRREF)
    custom = next(c for c in special["LIST"]["value"] if c["ID"]["value"] == CUSTOM5_ID)
    leaves = custom.setdefault("LIST", {"type": "list", "value": []})["value"]
    have = {l["RESREF"]["value"] for l in leaves if "RESREF" in l}
    for name, resref in entries:
        if resref in have: continue
        leaves.append({"__struct_id": 0, "NAME": {"type": "cexostring", "value": name},
                       "RESREF": {"type": "resref", "value": resref}})
    path.write_text(json.dumps(d, indent=2) + "\n")
    print(palette, "palette:", len(entries), "language entries")

add("item", blueprints("uti", "lang_book_*.uti.json"))
add("placeable", blueprints("utp", "lang_bookshelf.utp.json"))
add("creature", blueprints("utc", "lang_goblin.utc.json"))
