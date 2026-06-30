#!/bin/bash
# Build UOA.mod from src/ source tree.
# Tools are taken from the shared ../nwn-tools/ sibling directory.
# NWN base scripts are read from ../DwarfStory/nwn-base-scripts/.
# ZEP includes are read from ../../isladora3/GER_Isladora261ee/src/nss/.
# Output: .build/modules/UOA_<hash>.mod  (also deployed to uoa/server/modules/ as UOA.mod).

set -e
cd "$(dirname "$0")"

TOOLS="/home/qlippoth/git/nwn-tools/linux"
BASE_SCRIPTS="/home/qlippoth/git/DwarfStory/nwn-base-scripts"
ZEP_SCRIPTS="/home/qlippoth/isladora3/GER_Isladora261ee/src/nss"
SERVER_MODULES="$(dirname "$0")/uoa/server/modules"

mkdir -p .build/modules

# Regenerate case-correcting include shims (nwnsc is case-sensitive on Linux).
"$TOOLS/../gen_include_shims.sh" ".build/include-shims" "src/nss" "$BASE_SCRIPTS"

"$TOOLS/nasher/nasher" pack \
  --erfUtil:"$TOOLS/neverwinter/nwn_erf" \
  --gffUtil:"$TOOLS/neverwinter/nwn_gff" \
  --tlkUtil:"$TOOLS/neverwinter/nwn_tlk" \
  --nssCompiler:"$TOOLS/nwnsc/nwnsc" \
  --nssFlags:"-oe -i .build/include-shims -i $BASE_SCRIPTS -i src/nss -i $ZEP_SCRIPTS" \
  --yes

HASH=$(git rev-parse --short=6 HEAD 2>/dev/null || echo "unknown")
cp .build/modules/UOA.mod ".build/modules/UOA_${HASH}.mod"
cp ".build/modules/UOA_${HASH}.mod" "$SERVER_MODULES/UOA_${HASH}.mod"
cp .build/modules/UOA.mod "$SERVER_MODULES/UOA.mod"
echo "Built:    .build/modules/UOA_${HASH}.mod"
echo "Deployed: $SERVER_MODULES/UOA.mod  (and UOA_${HASH}.mod)"
(cd "$(dirname "$0")/uoa" && docker-compose restart nwserver)
echo "Server restarted."
