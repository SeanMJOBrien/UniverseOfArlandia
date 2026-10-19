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
