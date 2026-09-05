#!/bin/bash
# Build UOA.mod from ~/git/UniverseOfArlandia/src and deploy it to this
# nwserver instance (the one docker-compose here actually runs - port 6041,
# NWN_MODULE=UOA in config/nwserver.env). Run from anywhere; paths below are
# absolute. Supersedes the old bare `pullNewModule.sh` cp.
#
# Usage: ./build_deploy.sh [--no-restart] [--full-resync] [--add-new-areas]
#   --no-restart   Build and deploy the .mod but don't restart nwserver
#                  (stage a build without disrupting players currently on).
#   --add-new-areas  Ship areas from src/are,git,gic that do NOT yet exist in
#                  the .mod, and append them to module.ifo's area list.
#                  ADDITIVE ONLY - an area already in the .mod is never
#                  overwritten, so this cannot revert live-only area state,
#                  which is the specific risk SKIP_GFF_DIRS guards against.
#                  Off by default; the guard stays intact for every other run.
#   --full-resync  Force a one-time full GFF resync of the safe resource
#                  categories (see SAFE_GFF_DIRS below) from src/, ignoring
#                  the last-deploy-commit tracking. Slower; normally only
#                  needed if you suspect the deployed .mod's blueprints/
#                  dialogs have drifted from src/ (they shouldn't, since this
#                  script keeps them in lockstep every run).
#
# --- Version control note ---
# This file is the tracked copy. The one that actually runs today still lives
# at ~/uoa/build_deploy.sh, OUTSIDE this repo, and the two will drift unless
# one is made canonical - either point ~/uoa/build_deploy.sh at this file with
# a symlink, or run this copy directly.
#
# Paths below (REPO_DIR, SERVER_HOME, TOOLS, BASE_SCRIPTS, ...) are still
# absolute and machine-specific. They are meant to become parameters - derive
# REPO_DIR from the script's own location and take the server/modules target
# from an env var or a config file - so this runs from inside any checkout to
# a designated server directory. Not done yet; deliberately left as-is so this
# tracked copy is byte-identical to the script that is known to work.
#
# --- Why this script exists (lessons learned building UOA.mod by hand) ---
#
# 1. CEP include trap: nwnsc aborts the ENTIRE batch (exit 255) the instant it
#    hits a file it can't resolve an #include for, silently skipping every
#    alphabetically-later script. `.build/cep-includes` only has 3 CEP files
#    with a fixed unterminated-comment bug (zep_inc_1st_rp/constant/phenos);
#    other CEP includes (e.g. zep_inc_main, needed by lamp.nss) only exist in
#    CEP_FALLBACK below. Without it, a previously-deployed UOA.mod was found
#    silently missing ~106 compiled scripts (area_enter, mod_load, wear,
#    transitions, ...) - this script always includes the fallback and hard-
#    fails (does not deploy) if the compile step errors, so that can't recur.
#
# 2. `src/ifo/module.ifo.json` and the area GFFs (`src/are`, `src/git`,
#    `src/gic`) are known to drift from the live deployed .mod (e.g. a stale
#    Mod_Area_list). Regenerating them wholesale from src/ (what `nasher pack`
#    / the old repo build.sh do) would silently revert live-only area state.
#    This script NEVER touches those four - see SKIP_GFF_DIRS below - and
#    just warns if it sees pending changes there, for you to handle by hand
#    (extract the live GFF, patch the single field, convert back).
#
# 3. Everything else under src/ (dlg, utc, uti, utp, ... - standalone,
#    independently-tagged resources with no aggregate-drift risk) is synced
#    incrementally: only files that changed since the last successful deploy
#    (tracked in STATE_FILE) are converted and overlaid, so a resource that
#    was only ever hand-patched directly in a past live .mod isn't silently
#    clobbered by an unrelated build.

set -euo pipefail

REPO_DIR="/home/qlippoth/git/UniverseOfArlandia"
UOA_DIR="/home/qlippoth/uoa"
MODULE_NAME="UOA"

TOOLS="/home/qlippoth/git/nwn-tools/linux"
GEN_SHIMS="/home/qlippoth/git/nwn-tools/gen_include_shims.sh"
BASE_SCRIPTS="/home/qlippoth/git/uoaNasherReuse/nwn-base-scripts"
CEP_FIXED="$REPO_DIR/.build/cep-includes"
CEP_FALLBACK="/home/qlippoth/git/erithornsmight/temp0"
SHIMS="$REPO_DIR/.build/include-shims"

STATE_FILE="$UOA_DIR/.last_deploy_commit"
LIVE_MOD="$UOA_DIR/server/modules/$MODULE_NAME.mod"
REPO_MOD="$REPO_DIR/.build/modules/$MODULE_NAME.mod"
BACKUP_DIR="$UOA_DIR/server/modules/backups"

# GFF resource categories safe to auto-overlay from src/ (independent,
# individually-tagged resources - no aggregate/arealist drift risk).
SAFE_GFF_DIRS="dlg fac itp jrl utc utd uti utm utp uts utt utw"
# NEVER auto-overlay these - see reason #2 above. Only warned about.
SKIP_GFF_DIRS="ifo are git gic"

NO_RESTART=0
FULL_RESYNC=0
ADD_NEW_AREAS=0
for arg in "$@"; do
    case "$arg" in
        --no-restart) NO_RESTART=1 ;;
        --full-resync) FULL_RESYNC=1 ;;
        --add-new-areas) ADD_NEW_AREAS=1 ;;
        *) echo "Unknown option: $arg" >&2; exit 1 ;;
    esac
done

NWNSC="$TOOLS/nwnsc/nwnsc"
ERF="$TOOLS/neverwinter/nwn_erf"
GFF="$TOOLS/neverwinter/nwn_gff"

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT
CURRENT="$WORK/current"
NCS_OUT="$WORK/ncs"
mkdir -p "$CURRENT" "$NCS_OUT"

echo "==> Compiling src/nss (full recompile - cheap, and the only way to be"
echo "    sure a shared #include change reaches every consumer)"
"$GEN_SHIMS" "$SHIMS" "$REPO_DIR/src/nss" "$BASE_SCRIPTS"
COMPILE_LOG="$WORK/compile.log"
set +e
(cd "$REPO_DIR/src/nss" && "$NWNSC" \
    -i . -i "$SHIMS" -i "$BASE_SCRIPTS" -i "$CEP_FIXED" -i "$CEP_FALLBACK" \
    -b "$NCS_OUT" *.nss) > "$COMPILE_LOG" 2>&1
COMPILE_RC=$?
set -e
if [ "$COMPILE_RC" -ne 0 ] || grep -q "Error:" "$COMPILE_LOG"; then
    echo "!! Compile FAILED (exit $COMPILE_RC) - not touching the live deploy." >&2
    tail -n 40 "$COMPILE_LOG" >&2
    exit 1
fi
NCS_COUNT=$(ls "$NCS_OUT"/*.ncs 2>/dev/null | wc -l)
echo "    Compiled $NCS_COUNT scripts clean (known-good baseline: ~555)."

echo "==> Extracting current build base ($([ -f "$REPO_MOD" ] && echo "$REPO_MOD" || echo "$LIVE_MOD"))"
BASE_MOD="$REPO_MOD"
[ -f "$BASE_MOD" ] || BASE_MOD="$LIVE_MOD"
if [ ! -f "$BASE_MOD" ]; then
    echo "!! No existing .mod found at either $REPO_MOD or $LIVE_MOD - nothing to build onto." >&2
    exit 1
fi
(cd "$CURRENT" && "$ERF" -x -f "$BASE_MOD" >/dev/null)

echo "==> Overlaying compiled scripts + source"
cp -f "$NCS_OUT"/*.ncs "$CURRENT"/
cp -f "$REPO_DIR/src/nss"/*.nss "$CURRENT"/

echo "==> Syncing changed GFF resources"
cd "$REPO_DIR"
if [ "$FULL_RESYNC" -eq 1 ]; then
    echo "    --full-resync requested: treating all safe-category src/ files as changed."
    LAST_COMMIT="4b825dc642cb6eb9a060e54bf8d69288fbee4904"   # git empty-tree hash
elif [ -f "$STATE_FILE" ]; then
    LAST_COMMIT="$(cat "$STATE_FILE")"
else
    echo "    No prior deploy state ($STATE_FILE) - baselining at current HEAD"
    echo "    without a resource resync. Use --full-resync if you believe the"
    echo "    live .mod's blueprints/dialogs are already stale vs src/."
    LAST_COMMIT="HEAD"
fi

CHANGED_SRC_FILES="$( { git diff --name-only "$LAST_COMMIT" -- src/ 2>/dev/null; \
                        git diff --name-only HEAD -- src/ 2>/dev/null; \
                        git ls-files --others --exclude-standard -- src/ 2>/dev/null; \
                      } | sort -u )"

GFF_SYNCED=0
while IFS= read -r f; do
    [ -z "$f" ] && continue
    case "$f" in
        */*.json) : ;;
        *) continue ;;   # not a GFF-JSON source file, ignore
    esac
    dir="$(echo "$f" | cut -d/ -f2)"   # src/<dir>/<name>.<ext>.json
    for skip in $SKIP_GFF_DIRS; do
        if [ "$dir" = "$skip" ]; then
            echo "    !! $f changed but src/$skip/ is never auto-synced (known drift risk)."
            echo "       Handle it by hand - see reason #2 in this script's header."
            continue 2
        fi
    done
    for safe in $SAFE_GFF_DIRS; do
        if [ "$dir" = "$safe" ]; then
            outname="$(basename "${f%.json}")"
            "$GFF" -i "$f" -o "$CURRENT/$outname"
            GFF_SYNCED=$((GFF_SYNCED+1))
            continue 2
        fi
    done
done <<< "$CHANGED_SRC_FILES"
echo "    Synced $GFF_SYNCED changed GFF resource(s)."

if [ "$ADD_NEW_AREAS" -eq 1 ]; then
    echo "==> Adding NEW areas from src/are,git,gic (additive only)"
    AREAS_ADDED=0
    NEW_AREA_RESREFS=""
    for adir in are git gic; do
        for f in "$REPO_DIR/src/$adir"/*.json; do
            [ -e "$f" ] || continue
            outname="$(basename "${f%.json}")"          # e.g. _homeslum_north.are
            if [ -e "$CURRENT/$outname" ]; then
                continue                                 # already in the .mod - never overwrite
            fi
            "$GFF" -i "$f" -o "$CURRENT/$outname"
            AREAS_ADDED=$((AREAS_ADDED+1))
            case "$outname" in
                *.are) NEW_AREA_RESREFS="$NEW_AREA_RESREFS ${outname%.are}" ;;
            esac
        done
    done
    echo "    Added $AREAS_ADDED new area resource(s)."

    # An area is invisible to CreateArea() and the toolset unless module.ifo
    # lists it. Patch that list in place, append-only, the way this script's
    # header prescribes for ifo edits: extract, patch one field, convert back.
    if [ -n "$NEW_AREA_RESREFS" ]; then
        "$GFF" -i "$CURRENT/module.ifo" -o "$WORK/module.ifo.json" -k json -p
        python3 - "$WORK/module.ifo.json" $NEW_AREA_RESREFS <<'PYIFO'
import json, sys
path, refs = sys.argv[1], sys.argv[2:]
d = json.load(open(path))
al = d['Mod_Area_list']['value']
have = {a['Area_Name']['value'] for a in al}
added = 0
for r in refs:
    if r in have:
        continue
    al.append({"__struct_id": 6, "Area_Name": {"type": "resref", "value": r}})
    have.add(r); added += 1
json.dump(d, open(path, 'w'), indent=2, ensure_ascii=False)
print("    module.ifo: %d area(s) appended, %d listed total." % (added, len(al)))
PYIFO
        "$GFF" -i "$WORK/module.ifo.json" -o "$CURRENT/module.ifo"
    fi
fi

echo "==> Repacking module"
NEW_MOD="$WORK/$MODULE_NAME.mod"
(cd "$CURRENT" && "$ERF" -c -f "$NEW_MOD" ./* >/dev/null)
NEW_SIZE=$(stat -c%s "$NEW_MOD")
[ "$NEW_SIZE" -gt 1000000 ] || { echo "!! Repacked .mod looks too small ($NEW_SIZE bytes) - aborting." >&2; exit 1; }

HASH=$(git -C "$REPO_DIR" rev-parse --short=6 HEAD)
if ! git -C "$REPO_DIR" diff-index --quiet HEAD -- 2>/dev/null; then HASH="${HASH}-dirty"; fi

mkdir -p "$(dirname "$REPO_MOD")" "$BACKUP_DIR"
if [ -f "$LIVE_MOD" ]; then
    cp -f "$LIVE_MOD" "$BACKUP_DIR/${MODULE_NAME}_predeploy_$(date +%Y%m%d_%H%M%S).mod"
fi

cp -f "$NEW_MOD" "$REPO_MOD"
cp -f "$NEW_MOD" "$REPO_DIR/.build/modules/${MODULE_NAME}_${HASH}.mod"
cp -f "$NEW_MOD" "$LIVE_MOD"
git -C "$REPO_DIR" rev-parse HEAD > "$STATE_FILE"

echo "==> Deployed: $LIVE_MOD ($NEW_SIZE bytes, build $HASH)"

if [ "$NO_RESTART" -eq 1 ]; then
    echo "==> --no-restart set: nwserver NOT restarted. It will pick up this"
    echo "    build the next time it (re)starts."
else
    echo "==> Restarting nwserver"
    COMPOSE=(docker-compose)
    command -v docker-compose >/dev/null 2>&1 || COMPOSE=(docker compose)
    (cd "$UOA_DIR" && "${COMPOSE[@]}" restart nwserver)
    sleep 3
    (cd "$UOA_DIR" && "${COMPOSE[@]}" ps nwserver)
fi

echo "==> Done."
