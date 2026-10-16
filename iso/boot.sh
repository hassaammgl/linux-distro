#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

DISK=tc.qcow2
ISO=Core-current.iso
RAM=1024

# Disk sirf pehli baar banegi, existing data safe rahega
[ -f "$DISK" ] || qemu-img create -f qcow2 "$DISK" 4G

# KVM available ho toh use karo, warna software emulation
KVM=""
[ -w /dev/kvm ] && KVM="-enable-kvm"

if [ "$1" = "install" ]; then
  # Install mode: ISO se boot
  qemu-system-x86_64 $KVM -m $RAM \
    -cdrom "$ISO" \
    -drive file="$DISK",format=qcow2 \
    -boot d -nic user
else
  # Normal mode: sirf disk se boot (persistent)
  qemu-system-x86_64 $KVM -m $RAM \
    -drive file="$DISK",format=qcow2 \
    -boot c -nic user
fi