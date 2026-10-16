#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

HOST=ratx86@localhost
CTRL=/tmp/ssh-ratwm-%r@%h:%p
SSH=(ssh -p 2222 -o ControlMaster=auto -o ControlPath="$CTRL" -o ControlPersist=60)

cleanup() { ssh -p 2222 -o ControlPath="$CTRL" -O exit "$HOST" 2>/dev/null || true; }
trap cleanup EXIT

# Ek baar password — baaki connections reuse hongi
"${SSH[@]}" -o ControlMaster=yes -fN "$HOST"

rsync -az --delete --exclude build --exclude .git \
  -e "${SSH[*]}" ./ "$HOST:~/projects/ratwm/"

"${SSH[@]}" "$HOST" '
  set -e
  cd ~/projects/ratwm/backend && cmake -S . -B build -G Ninja >/dev/null && cmake --build build
  cd ~/projects/ratwm/ui      && cmake -S . -B build -G Ninja >/dev/null && cmake --build build
'
