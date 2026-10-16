#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
ssh -p 2222 ratx86@localhost 'mkdir -p ~/projects/ratwm'
rsync -az --delete --exclude build --exclude .git \
  -e "ssh -p 2222" ./ ratx86@localhost:~/projects/ratwm/
ssh -p 2222 ratx86@localhost \
  'cd ~/projects/ratwm && cmake -S . -B build -G Ninja >/dev/null && cmake --build build'
