#!/usr/bin/env bash

set -e
set -o pipefail

if test -z "$FTB_PACK"; then
  echo "no pack id defined, missing env var: FTB_PACK"
  exit 1
fi

echo "pack infos:"
curl --location https://api.modpacks.ch/public/modpack/"$FTB_PACK" | jq '. | {name, synopsis, updated, authors, installs, plays, tags, rating}'

curl --location https://api.modpacks.ch/public/modpack/0/0/server/linux --output /opt/setup/serverinstall
chmod +x /opt/setup/serverinstall

cd /opt/server
if [[ $(find . -type f | wc -l) -lt 1 ]]; then
  echo "installing server"
  /opt/setup/serverinstall "$FTB_PACK" "$FTB_PACK_VER" --auto --path .
  echo "eula=$MC_EULA" >eula.txt
fi

echo "starting server"
./start.sh
