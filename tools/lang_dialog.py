#!/usr/bin/env python3
"""Make NPC dialog lines language-aware (the dmfi_lang_dialog system).

For each chosen NPC line (an "entry" of a .dlg.json) this replaces the node
text with a custom token, <CUSTOM60000> and up, and puts the cond_lang_line
condition script on every link into that node, with the original English text
and the token number as script parameters. In game cond_lang_line fills the
token per player: the real text for fluent speakers, a partial version for
partial speakers, and scrambled text for everyone else, in the NPC's language
(local int npc_language on the NPC, or its racial language).

A link that already has a condition script cannot take a second one. An entry
with any such link is skipped and reported; call LangDialogLine() from that
condition script by hand instead (see dmfi_lang_dialog.nss).

Usage:
  tools/lang_dialog.py src/dlg/foo.dlg.json                 all NPC lines
  tools/lang_dialog.py src/dlg/foo.dlg.json --entries 0,3   only these entries
  tools/lang_dialog.py src/dlg/foo.dlg.json --dry-run       report only
  tools/lang_dialog.py src/dlg/foo.dlg.json --maxlevel 4    read the lines at level 4 at most
  tools/lang_dialog.py src/dlg/foo.dlg.json --dialect old_dwarven   name the dialect (henchmen who studied it read higher)
  tools/lang_dialog.py src/dlg/foo.dlg.json --language 4    give the lines a language (id)
"""
import argparse
import json
import re
import sys

TOKEN_BASE = 60000
CONDITION = "cond_lang_line"


def text_of(node):
    values = node["Text"]["value"]
    return values.get("0", next(iter(values.values()), ""))


def param(key, value):
    return {
        "__struct_id": 0,
        "Key": {"type": "cexostring", "value": key},
        "Value": {"type": "cexostring", "value": value},
    }


def links_to(dlg, index):
    """Every link struct that points at entry `index`."""
    links = [l for l in dlg["StartingList"]["value"] if l["Index"]["value"] == index]
    for reply in dlg["ReplyList"]["value"]:
        links += [l for l in reply["EntriesList"]["value"] if l["Index"]["value"] == index]
    return links


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("dlg", help="a .dlg.json file (nwn_gff JSON)")
    ap.add_argument("--entries", help="comma list of entry indexes (default: all)")
    ap.add_argument("--token-base", type=int, default=TOKEN_BASE)
    ap.add_argument("--maxlevel", type=int, choices=range(1, 6), help="limit the level a reader reads the lines at (1-5)")
    ap.add_argument("--language", type=int, help="language id for the lines, in place of the speaker's")
    ap.add_argument("--dialect", help="dialect name; a henchman with lang_dialect_<name> reads the lines at that level")
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()

    with open(args.dlg, encoding="utf-8") as fh:
        dlg = json.load(fh)
    entries = dlg["EntryList"]["value"]
    wanted = range(len(entries)) if not args.entries else [int(x) for x in args.entries.split(",")]

    used = [int(m) for m in re.findall(r"<CUSTOM(\d+)>", json.dumps(dlg))]
    token = max([args.token_base - 1] + [t for t in used if t >= args.token_base]) + 1

    changed = 0
    for index in wanted:
        entry = entries[index]
        english = text_of(entry)
        if not english.strip() or "<CUSTOM" in english:
            print(f"entry {index}: skipped (empty or already tokenised)")
            continue
        links = links_to(dlg, index)
        busy = [l for l in links if l["Active"]["value"]]
        if not links:
            print(f"entry {index}: skipped (nothing links to it)")
            continue
        if busy:
            names = ", ".join(sorted({l["Active"]["value"] for l in busy}))
            print(f"entry {index}: skipped, a link already has a condition script ({names})")
            continue

        print(f"entry {index}: <CUSTOM{token}> {english[:50]!r}")
        if not args.dry_run:
            for key in entry["Text"]["value"]:
                entry["Text"]["value"][key] = f"<CUSTOM{token}>"
            for link in links:
                link["Active"]["value"] = CONDITION
                params = [param("token", str(token)), param("text", english)]
                if args.maxlevel:
                    params.append(param("maxlevel", str(args.maxlevel)))
                if args.dialect:
                    params.append(param("dialect", args.dialect))
                if args.language:
                    params.append(param("language", str(args.language)))
                link["ConditionParams"] = {"type": "list", "value": params}
        token += 1
        changed += 1

    if changed and not args.dry_run:
        with open(args.dlg, "w", encoding="utf-8") as fh:
            json.dump(dlg, fh, indent=2, ensure_ascii=False)
            fh.write("\n")
    print(f"{changed} entr{'y' if changed == 1 else 'ies'} {'would be ' if args.dry_run else ''}converted")
    return 0


if __name__ == "__main__":
    sys.exit(main())
