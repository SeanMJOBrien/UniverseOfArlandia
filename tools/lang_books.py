#!/usr/bin/env python3
"""Generate the language book items: src/uti/lang_book_<languageId>_<volume>.uti.json.

Volumes per learnable language (ids 1-7 and 10-13), cloned from uoabook: six by default,
or the number given with --volumes. Reading a volume (activate) adds fluency points and
uses the book up; the points come from the volume number and the module setting
lang_book_volumes, or from local ints on the item (lang_book_min, lang_book_gain,
lang_book_max). See src/nss/dmfi_lang_book.nss. Set lang_book_volumes to the same number
used here, or books above it read as unreadable.
"""
import argparse, copy, json, pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
LANGS = {1: "Elven", 2: "Gnome", 3: "Halfling", 4: "Dwarven", 5: "Orc", 6: "Goblin",
         7: "Draconic", 10: "Celestial", 11: "Abyssal", 12: "Infernal", 13: "Drow"}
TITLES6 = ["First Words", "Common Phrases", "Grammar", "Conversation", "Idiom and Dialect", "Mastery"]
GOLD6 = [50, 150, 400, 900, 1800, 3500]

ap = argparse.ArgumentParser()
ap.add_argument("--volumes", type=int, default=6, help="volumes per language (default 6); also set lang_book_volumes to this")
VOLUMES = max(1, ap.parse_args().volumes)
# Six volumes keep their titles; other counts spread the titles and prices over the range.
STEP = [round(i * 5 / (VOLUMES - 1)) if VOLUMES > 1 else 5 for i in range(VOLUMES)]
TITLES = [TITLES6[i] for i in STEP]
GOLD = [GOLD6[i] for i in STEP]

template = json.loads((ROOT / "src/uti/uoabook.uti.json").read_text())
for lid, lang in LANGS.items():
    for vol in range(1, VOLUMES + 1):
        resref = "lang_book_%d_%d" % (lid, vol)
        item = copy.deepcopy(template)
        name = "%s, Volume %d: %s" % (lang, vol, TITLES[vol - 1])
        text = ("A primer in %s, volume %d of %d. Activate it to study; the book is used up. "
                "Each volume needs the fluency the one before it gives. %s"
                % (lang, vol, VOLUMES,
                   "This volume makes you fluent." if vol == VOLUMES else "Study volume %d next." % (vol + 1)))
        item["LocalizedName"]["value"] = {"0": name}
        item["Description"]["value"] = {"0": text}
        item["DescIdentified"]["value"] = {"0": text}
        item["Tag"]["value"] = resref
        item["TemplateResRef"]["value"] = resref
        item["Plot"]["value"] = 0
        item["Cursed"]["value"] = 0
        item["Cost"]["value"] = GOLD[vol - 1]
        (ROOT / "src/uti" / (resref + ".uti.json")).write_text(json.dumps(item, indent=2) + "\n")
print("wrote %d books" % (len(LANGS) * VOLUMES))

# Bookshelf placeable stocked with every book (restocked at runtime by lang_shelf_fill.nss).
shelf = json.loads((ROOT / "src/utp/chest001.utp.json").read_text())
shelf["Appearance"]["value"] = 1  # Bookshelf 01
shelf["LocName"]["value"] = {"0": "Language Bookshelf"}
shelf["Description"]["value"] = {"0": "Primers in the tongues of the world. Take a volume and activate it to study."}
shelf["Tag"]["value"] = "lang_bookshelf"
shelf["TemplateResRef"]["value"] = "lang_bookshelf"
shelf["Plot"]["value"] = 1
shelf["Static"]["value"] = 0
shelf["Useable"]["value"] = 1
shelf["HasInventory"]["value"] = 1
shelf["Lockable"]["value"] = 0
shelf["Locked"]["value"] = 0
shelf["Faction"]["value"] = 1
for slot in ("OnOpen", "OnClosed"):
    shelf[slot]["value"] = "lang_shelf_fill"
for slot in ("OnDeath", "OnDamaged", "OnDisarm", "OnUnlock"):
    shelf[slot]["value"] = ""
shelf["Comment"]["value"] = "Contains one of each lang_book_* item; lang_shelf_fill restocks it."
items = []
index = 0
for lid in LANGS:
    for vol in range(1, VOLUMES + 1):
        items.append({"__struct_id": index,
                      "InventoryRes": {"type": "resref", "value": "lang_book_%d_%d" % (lid, vol)},
                      "Repos_PosX": {"type": "word", "value": index % 8},
                      "Repos_PosY": {"type": "word", "value": index // 8}})
        index += 1
shelf["ItemList"] = {"type": "list", "value": items}
(ROOT / "src/utp/lang_bookshelf.utp.json").write_text(json.dumps(shelf, indent=2) + "\n")
print("wrote lang_bookshelf with %d books" % len(items))

import subprocess, sys
subprocess.run([sys.executable, str(ROOT / "tools/language_palette.py")], check=True)
