#!/bin/sh
export XDG_RUNTIME_DIR=/tmp/xdg-$(id -u)
mkdir -p -m 700 "$XDG_RUNTIME_DIR"
export QT_QPA_PLATFORM=eglfs
export QT_QPA_EGLFS_INTEGRATION=eglfs_kms
exec ./build/ratwm
