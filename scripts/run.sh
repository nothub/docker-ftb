#!/usr/bin/env bash
set -e

# cd to project root dir
cd "$(dirname "${BASH_SOURCE[0]}")"/..

# run rootless or elevate
docker version &>/dev/null || sudo su

# cleanup
set +e
docker rm --force ftb
docker rmi --force ftb:dev
set -e

docker build . --tag ftb:dev
docker run --name ftb --rm --volume "$(pwd)"/data:/opt/server --env-file "$(pwd)"/.env.example ftb:dev
