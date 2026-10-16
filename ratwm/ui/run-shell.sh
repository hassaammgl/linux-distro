#!/bin/sh
export XDG_RUNTIME_DIR=/tmp/xdg-$(id -u)
export QT_QPA_PLATFORM=wayland
export WAYLAND_DISPLAY=wayland-rat
exec ./build/rat-shell
