#!/usr/bin/env bash

set -e

echo FTB_PACK="$FTB_PACK"
echo FTB_PACK_VER="$FTB_PACK_VER"
echo JVM_MEMORY="$JVM_MEMORY"
echo MC_EULA="$MC_EULA"

if test -z "$FTB_PACK"; then
  echo "no pack id defined, missing env var: $FTB_PACK"
  exit 1
fi

curl --location https://api.modpacks.ch/public/modpack/0/0/server/linux --output /opt/setup/serverinstall
chmod +x /opt/setup/serverinstall

cd /opt/server
if [[ $(find . -type f | wc -l) -lt 1 ]]; then
  echo "INSTALLING SERVER"
  /opt/setup/serverinstall "$FTB_PACK" "$FTB_PACK_VER" --auto --path .
  echo "eula=$MC_EULA" >eula.txt
fi

echo "STARTING SERVER"
./start.sh
