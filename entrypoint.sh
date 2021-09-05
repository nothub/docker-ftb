#!/usr/bin/env bash

set -e

echo FTB_PACK="$FTB_PACK"
echo FTB_PACK_VER="$FTB_PACK_VER"
echo JVM_MEMORY="$JVM_MEMORY"

cd /opt/server

if [[ $(find . -type f | wc -l) -lt 1 ]]; then
  echo "INSTALLING SERVER"
  /opt/setup/serverinstall_"$FTB_PACK"_"$FTB_PACK_VER" --auto --noscript --path .
  echo "eula=$MC_EULA" >eula.txt
fi

echo "STARTING SERVER"
java \
  -XX:+UseG1GC \
  -XX:+UnlockExperimentalVMOptions \
  -Xms"$JVM_MEMORY" \
  -Xmx"$JVM_MEMORY" \
  -jar \
  forge-1.12.2-14.23.5.2847-universal.jar \
  nogui
