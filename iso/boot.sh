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

# Laptop screen size (bahar na jaye)
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
# ~90% of laptop screen, keep even numbers
GW=$(( HOST_W * 90 / 100 ))
GH=$(( HOST_H * 90 / 100 ))
GW=$(( GW - GW % 2 ))
GH=$(( GH - GH % 2 ))
# safety floor
[ "$GW" -lt 800 ] && GW=800
[ "$GH" -lt 600 ] && GH=600

# Guest framebuffer = laptop ke andar; zoom-to-fit extra safety
VIDEO=(
  -device virtio-vga,virtio-backend.xres="$GW",virtio-backend.yres="$GH"
  -display gtk,zoom-to-fit=on
)

echo "QEMU display: ${GW}x${GH} (host ${HOST_W}x${HOST_H})"

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
