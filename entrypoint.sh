#!/usr/bin/env bash

set -e
set -o pipefail

log() { echo "$(date --rfc-3339=ns) $1"; }

if test -z "$FTB_PACK"; then
  log "no pack id defined, missing env var: FTB_PACK"
  exit 1
fi

curl --location --silent https://api.modpacks.ch/public/modpack/"$FTB_PACK" | jq '. | {id, name, updated}'
curl --location --silent https://api.modpacks.ch/public/modpack/"$FTB_PACK"/0/server/linux --output /opt/setup/serverinstall
chmod +x /opt/setup/serverinstall

cd /opt/server
if [[ $(find . -type f | wc -l) -lt 1 ]]; then
  log "installing server"
  /opt/setup/serverinstall "$FTB_PACK" "$FTB_PACK_VER" --auto --path .
  echo "eula=$MC_EULA" >eula.txt
fi

log "starting server"
./start.sh
