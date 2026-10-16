#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

DISK=alpine.qcow2
ISO=alpine-standard-3.24.2-x86_64.iso
RAM=1024

# Disk sirf pehli baar banegi, existing data safe rahega
[ -f "$DISK" ] || qemu-img create -f qcow2 "$DISK" 4G

# KVM available ho toh use karo, warna software emulation
KVM=""
[ -w /dev/kvm ] && KVM="-enable-kvm"

# Host :2222 -> guest :22 (sync.sh / ssh -p 2222)
NIC="-nic user,hostfwd=tcp::2222-:22"

# Laptop screen — decorations / bars ke liye margin chhodo
host_wh() {
  local geo=
  if command -v xrandr >/dev/null 2>&1; then
    geo=$(xrandr 2>/dev/null | awk '/connected primary/{print $4; exit} / connected /{print $3; exit}')
  fi
  if [[ "$geo" =~ ([0-9]+)x([0-9]+) ]]; then
    echo "${BASH_REMATCH[1]} ${BASH_REMATCH[2]}"
    return
  fi
  echo "1366 768"
}
read -r HOST_W HOST_H <<<"$(host_wh)"

# Margin: Hyprland bar + QEMU title/menu + borders (text cut na ho)
MARGIN_X=64
MARGIN_Y=140
GW=$(( HOST_W - MARGIN_X ))
GH=$(( HOST_H - MARGIN_Y ))
# Hard cap — chhote laptops pe safe
[ "$GW" -gt 1152 ] && GW=1152
[ "$GH" -gt 648 ] && GH=648
GW=$(( GW - GW % 8 ))
GH=$(( GH - GH % 8 ))
[ "$GW" -lt 800 ] && GW=800
[ "$GH" -lt 480 ] && GH=480

VIDEO=(
  -device virtio-vga,xres="$GW",yres="$GH",edid=on
  -display gtk,zoom-to-fit=on,show-menubar=off
)

echo "QEMU display: ${GW}x${GH} (host ${HOST_W}x${HOST_H})"

# Hyprland: window ko screen ke andar force-fit karo (xres guest ignore kare to bhi)
fit_hypr_window() {
  command -v hyprctl >/dev/null 2>&1 || return 0
  local i addr
  for i in 1 2 3 4 5 6 7 8 9 10; do
    sleep 0.5
    addr=$(hyprctl clients -j 2>/dev/null \
      | python3 -c '
import json,sys
try:
  clients=json.load(sys.stdin)
except Exception:
  sys.exit(0)
for c in clients:
  cname=(c.get("class") or "")+(c.get("title") or "")
  if "qemu" in cname.lower() or "QEMU" in (c.get("title") or ""):
    print(c.get("address",""))
    break
' 2>/dev/null || true)
    if [ -n "$addr" ]; then
      hyprctl dispatch resizewindowpixel exact "$GW" "$GH",address:"$addr" >/dev/null 2>&1 || true
      hyprctl dispatch movewindowpixel exact 24 48,address:"$addr" >/dev/null 2>&1 || true
      return 0
    fi
  done
}

fit_hypr_window &
FIT_PID=$!

cleanup() { kill "$FIT_PID" 2>/dev/null || true; }
trap cleanup EXIT

if [ "$1" = "install" ]; then
  qemu-system-x86_64 $KVM -m $RAM \
    -cdrom "$ISO" \
    -drive file="$DISK",format=qcow2 \
    -boot d $NIC "${VIDEO[@]}"
else
  qemu-system-x86_64 $KVM -m $RAM \
    -drive file="$DISK",format=qcow2 \
    -boot c $NIC "${VIDEO[@]}"
fi
