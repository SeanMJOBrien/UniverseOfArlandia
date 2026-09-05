#!/bin/bash
# Build UOA.mod from src/ source tree.
# Tools are taken from the shared ../nwn-tools/ sibling directory.
# NWN base scripts are read from ../DwarfStory/nwn-base-scripts/.
# ZEP includes are read from ../../isladora3/GER_Isladora261ee/src/nss/.
# Output: .build/modules/UOA_<hash>.mod  (also deployed to the live server at
# ~/uoa/server/modules/ as UOA.mod, then verified against the running server).

set -e
cd "$(dirname "$0")"

PROJECT="$(pwd)"
TOOLS="/home/qlippoth/git/nwn-tools/linux"
BASE_SCRIPTS="/home/qlippoth/git/DwarfStory/nwn-base-scripts"
ZEP_SCRIPTS="/home/qlippoth/isladora3/GER_Isladora261ee/src/nss"

# The live server lives at ~/uoa/, OUTSIDE this repo - its container bind-mounts
# ~/uoa/server at /nwn/home. The repo's own uoa/ is a working copy the server
# never reads. Deploying there instead (which this script did from a1e4659 on
# 2026-06-30 until 2026-08-16) puts the module somewhere nothing loads, while
# the restart below quietly reloads the old one: the live server ran a
# 2026-08-11 build for five days while every build reported success. Keep this
# pointed at the real server home, and let the checks after the restart prove it.
SERVER_HOME="${UOA_SERVER_HOME:-$HOME/uoa/server}"
SERVER_MODULES="$SERVER_HOME/modules"
NWSERVER_CONTAINER="${NWSERVER_CONTAINER:-uoa_nwserver_1}"

# Warn early if the running container reads somewhere else entirely - otherwise
# the only symptom is in-game behaviour that never changes.
CONTAINER_HOME="$(docker inspect -f \
  '{{range .Mounts}}{{if eq .Destination "/nwn/home"}}{{.Source}}{{end}}{{end}}' \
  "$NWSERVER_CONTAINER" 2>/dev/null || true)"
if [[ -n "$CONTAINER_HOME" && "$CONTAINER_HOME" != "$SERVER_HOME" ]]; then
  echo "WARNING: '$NWSERVER_CONTAINER' mounts $CONTAINER_HOME at /nwn/home," >&2
  echo "         but this script deploys to $SERVER_HOME." >&2
  echo "         Recreate the container (docker-compose up -d --force-recreate)" >&2
  echo "         or set UOA_SERVER_HOME=$CONTAINER_HOME." >&2
fi

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
mkdir -p "$SERVER_MODULES"
cp .build/modules/UOA.mod ".build/modules/UOA_${HASH}.mod"
cp ".build/modules/UOA_${HASH}.mod" "$SERVER_MODULES/UOA_${HASH}.mod"
cp .build/modules/UOA.mod "$SERVER_MODULES/UOA.mod"
echo "Built:    .build/modules/UOA_${HASH}.mod"
echo "Deployed: $SERVER_MODULES/UOA.mod  (and UOA_${HASH}.mod)"
(cd uoa && docker-compose restart nwserver) && echo "Server restarted." || echo "Server not running (start it with: cd uoa && docker-compose up -d)"

# Prove the running server is actually holding the module we just built, rather
# than trusting that the copy landed somewhere it reads. Silent staleness here
# is far more expensive than a failed build - it makes every later in-game test
# a test of old code.
BUILT_SUM=$(md5sum .build/modules/UOA.mod | cut -d' ' -f1)
LIVE_SUM=$(docker exec "$NWSERVER_CONTAINER" md5sum /nwn/home/modules/UOA.mod 2>/dev/null | cut -d' ' -f1 || true)
if [[ -z "$LIVE_SUM" ]]; then
  echo "WARNING: could not read /nwn/home/modules/UOA.mod from '$NWSERVER_CONTAINER' - deployment unverified." >&2
elif [[ "$LIVE_SUM" != "$BUILT_SUM" ]]; then
  echo "DEPLOY FAILED: the server's /nwn/home/modules/UOA.mod does not match this build." >&2
  echo "               built=$BUILT_SUM live=$LIVE_SUM" >&2
  echo "               The container reads a different directory than the one deployed to." >&2
  exit 1
else
  echo "Verified: server is running this build ($BUILT_SUM)."
fi
