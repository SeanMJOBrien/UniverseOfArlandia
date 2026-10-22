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

# --- readme, then the ERF
cp "$PKG/README.txt" "$WORK/stage/lang_readme.txt"
rm -f "$WORK"/stage/*.json
ERF="$OUT/uoa_language_system_nwscript.erf"
rm -f "$ERF"
(cd "$WORK/stage" && "$TOOLS/neverwinter/nwn_erf" -c -f "$ERF" -e ERF *.nss *.ncs *.uti *.utp *.utc *.dlg lang_readme.txt)
python3 "$PKG/make_manual.py" "$OUT/uoa_language_system_manual.html"
echo "Built $ERF ($(ls "$WORK/stage" | wc -l) resources)"
rm -rf "$WORK"
