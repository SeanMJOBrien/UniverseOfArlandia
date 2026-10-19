#!/usr/bin/env python3
"""Generate the language book items: src/uti/lang_book_<languageId>_<volume>.uti.json.

Six volumes per learnable language (ids 1-7 and 10-13), cloned from uoabook.
Reading volume n (activate) raises fluency to n; see src/nss/dmfi_lang_book.nss.
"""
import copy, json, pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
LANGS = {1: "Elven", 2: "Gnome", 3: "Halfling", 4: "Dwarven", 5: "Orc", 6: "Goblin",
         7: "Draconic", 10: "Celestial", 11: "Abyssal", 12: "Infernal", 13: "Drow"}
TITLES = ["First Words", "Common Phrases", "Grammar", "Conversation", "Idiom and Dialect", "Mastery"]
VOLUMES = len(TITLES)
GOLD = [50, 150, 400, 900, 1800, 3500]

template = json.loads((ROOT / "src/uti/uoabook.uti.json").read_text())
for lid, lang in LANGS.items():
    for vol in range(1, VOLUMES + 1):
        resref = "lang_book_%d_%d" % (lid, vol)
        item = copy.deepcopy(template)
        name = "%s, Volume %d: %s" % (lang, vol, TITLES[vol - 1])
        text = ("A primer in %s, volume %d of %d. Activate it to study; volumes must be read in order. "
                "%s" % (lang, vol, VOLUMES,
                        "Volume 6 makes you fluent." if vol == VOLUMES else "Study volume %d next." % (vol + 1)))
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

# Bookshelf placeable stocked with every book (restocked at runtime by lang_bookshelf_fill.nss).
shelf = json.loads((ROOT / "src/utp/chest001.utp.json").read_text())
shelf["Appearance"]["value"] = 1  # Bookshelf 01
shelf["LocName"]["value"] = {"0": "Language Bookshelf"}
shelf["Description"]["value"] = {"0": "Primers in the tongues of the world, six volumes each. Take a volume and activate it to study."}
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
    shelf[slot]["value"] = "lang_bookshelf_fill"
for slot in ("OnDeath", "OnDamaged", "OnDisarm", "OnUnlock"):
    shelf[slot]["value"] = ""
shelf["Comment"]["value"] = "Contains one of each lang_book_* item; lang_bookshelf_fill restocks it."
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
