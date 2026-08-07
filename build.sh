#!/bin/bash
# Build UOA.mod from src/ source tree.
# Tools are taken from the shared ../nwn-tools/ sibling directory.
# NWN base scripts are read from ../DwarfStory/nwn-base-scripts/.
# ZEP includes are read from ../../isladora3/GER_Isladora261ee/src/nss/.
# Output: .build/modules/UOA_<hash>.mod  (also deployed to uoa/server/modules/ as UOA.mod).

set -e
cd "$(dirname "$0")"

PROJECT="$(pwd)"
TOOLS="/home/qlippoth/git/nwn-tools/linux"
BASE_SCRIPTS="/home/qlippoth/git/DwarfStory/nwn-base-scripts"
ZEP_SCRIPTS="/home/qlippoth/isladora3/GER_Isladora261ee/src/nss"
SERVER_MODULES="uoa/server/modules"

mkdir -p .build/modules

# Regenerate case-correcting include shims (nwnsc is case-sensitive on Linux).
"$TOOLS/../gen_include_shims.sh" ".build/include-shims" "src/nss" "$BASE_SCRIPTS"

# Every -i path below MUST be absolute. nasher copies the source tree into
# .nasher/cache/mod/ and runs nwnsc from THERE, not from the project root - so
# relative include paths ("-i .build/include-shims", "-i src/nss") silently
# resolve to nothing. Scripts whose includes all happen to live in the flat
# cache dir still compile, which is why this stayed hidden; anything needing a
# base-game include (NW_I0_GENERIC & co, reachable only via the case-shim dir)
# fails with NSC1085. nasher then packs anyway, producing a .mod that is simply
# MISSING those .ncs files - i.e. a silently broken module rather than a failed
# build. The `set -e` above does not catch it either, since nasher exits 0.
"$TOOLS/nasher/nasher" pack \
  --erfUtil:"$TOOLS/neverwinter/nwn_erf" \
  --gffUtil:"$TOOLS/neverwinter/nwn_gff" \
  --tlkUtil:"$TOOLS/neverwinter/nwn_tlk" \
  --nssCompiler:"$TOOLS/nwnsc/nwnsc" \
  --nssFlags:"-oe -i $PROJECT/.build/include-shims -i $BASE_SCRIPTS -i $PROJECT/src/nss -i $ZEP_SCRIPTS" \
  --yes 2>&1 | tee /tmp/uoa-build.log

# Fail loudly instead of deploying a module with missing .ncs files. Matches
# real errors only - nwnsc emits plenty of harmless NSC6023 warnings from the
# stock base scripts, so don't key off the NSCnnnn code alone.
if grep -qE "^Error:|Errors encountered during compilation|matching \.ncs files" /tmp/uoa-build.log; then
  echo "BUILD FAILED: script compilation errors (see above) - NOT deploying." >&2
  exit 1
fi

HASH=$(git rev-parse --short=6 HEAD 2>/dev/null || echo "unknown")
cp .build/modules/UOA.mod ".build/modules/UOA_${HASH}.mod"
cp ".build/modules/UOA_${HASH}.mod" "$SERVER_MODULES/UOA_${HASH}.mod"
cp .build/modules/UOA.mod "$SERVER_MODULES/UOA.mod"
echo "Built:    .build/modules/UOA_${HASH}.mod"
echo "Deployed: $SERVER_MODULES/UOA.mod  (and UOA_${HASH}.mod)"
(cd uoa && docker-compose restart nwserver) && echo "Server restarted." || echo "Server not running (start it with: cd uoa && docker-compose up -d)"
