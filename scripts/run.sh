#!/usr/bin/env bash
set -eo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"/..
docker version || sudo su
docker rmi --force ftb:dev
docker build . --tag ftb:dev
docker run --interactive --tty --rm --volume "$(pwd)"/data:/opt/server --env-file "$(pwd)"/.env ftb:dev
