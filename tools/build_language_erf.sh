#!/bin/bash
# Builds export/uoa_language_system_nwscript.erf and the HTML manual: the
# NWScript-only (no NWNX) language system for a clean module.
# Usage: tools/build_language_erf.sh   (from anywhere)
set -euo pipefail
REPO="$(cd "$(dirname "$0")/.." && pwd)"
TOOLS="/home/qlippoth/git/nwn-tools/linux"
BASE="/home/qlippoth/git/uoaNasherReuse/nwn-base-scripts"
PKG="$REPO/tools/language_pkg"
WORK="$(mktemp -d)"
OUT="$REPO/export"
mkdir -p "$OUT" "$WORK/stage" "$WORK/shims"

SCRIPTS_INC="dmfi_lang_inc dmfi_lang_book dmfi_lang_dialog dmfi_lang_nui"
SCRIPTS_RUN="lang_nui_event lang_nui_append lang_shelf_fill cond_lang_line cond_lang_know act_lang_npc"
PKG_RUN="lang_on_chat lang_on_enter lang_on_act"

# --- scripts
for n in $SCRIPTS_INC $SCRIPTS_RUN; do cp "$REPO/src/nss/$n.nss" "$WORK/stage/"; done
for n in $PKG_RUN; do cp "$PKG/$n.nss" "$WORK/stage/"; done
"$REPO/../nwn-tools/gen_include_shims.sh" "$WORK/shims" "$WORK/stage" "$BASE" >/dev/null
mkdir -p "$WORK/ncs"
for n in $SCRIPTS_RUN $PKG_RUN; do
    (cd "$WORK/stage" && "$TOOLS/nwnsc/nwnsc" -i . -i "$WORK/shims" -i "$BASE" -b "$WORK/ncs" "$n.nss") >"$WORK/nwnsc.log" 2>&1 \
        || { cat "$WORK/nwnsc.log"; echo "compile failed: $n"; exit 1; }
done
cp "$WORK"/ncs/*.ncs "$WORK/stage/"

# --- objects and dialog (JSON -> GFF)
conv() { "$TOOLS/neverwinter/nwn_gff" -i "$1" -o "$WORK/stage/$2"; }
for f in "$REPO"/src/uti/lang_book_*.uti.json; do b=$(basename "$f" .json); conv "$f" "$b"; done
conv "$REPO/src/utp/lang_bookshelf.utp.json" lang_bookshelf.utp
conv "$REPO/src/utc/lang_goblin.utc.json" lang_goblin.utc
conv "$REPO/src/dlg/lang_demo.dlg.json" lang_demo.dlg

# --- palettes: the module palettes cut down to the language entries only
python3 - "$REPO" "$WORK" <<'PY'
import json, sys, pathlib
repo, work = pathlib.Path(sys.argv[1]), pathlib.Path(sys.argv[2])
for kind in ("item", "placeable", "creature"):
    d = json.loads((repo / "src/itp" / f"{kind}palcus.itp.json").read_text())
    def keep(lst):
        out = []
        for s in lst:
            if "LIST" in s:
                s["LIST"]["value"] = keep(s["LIST"]["value"])
                if s["LIST"]["value"]: out.append(s)
            elif s.get("RESREF", {}).get("value", "").startswith("lang_") and s["RESREF"]["value"] != "lang_demo":
                out.append(s)
        return out
    d["MAIN"]["value"] = keep(d["MAIN"]["value"])
    (work / f"{kind}palcus.itp.json").write_text(json.dumps(d))
PY
for k in item placeable creature; do conv "$WORK/${k}palcus.itp.json" "${k}palcus.itp"; done

# --- readme, then the ERF
cp "$PKG/README.txt" "$WORK/stage/lang_readme.txt"
rm -f "$WORK"/stage/*.json
ERF="$OUT/uoa_language_system_nwscript.erf"
rm -f "$ERF"
(cd "$WORK/stage" && "$TOOLS/neverwinter/nwn_erf" -c -f "$ERF" -e ERF *.nss *.ncs *.uti *.utp *.utc *.dlg *.itp lang_readme.txt)
python3 "$PKG/make_manual.py" "$OUT/uoa_language_system_manual.html"
echo "Built $ERF ($(ls "$WORK/stage" | wc -l) resources)"
rm -rf "$WORK"
