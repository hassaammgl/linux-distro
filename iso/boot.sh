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

if [ "$1" = "install" ]; then
  # Install mode: ISO se boot
  qemu-system-x86_64 $KVM -m $RAM \
    -cdrom "$ISO" \
    -drive file="$DISK",format=qcow2 \
    -boot d $NIC
else
  # Normal mode: sirf disk se boot (persistent)
  qemu-system-x86_64 $KVM -m $RAM \
    -drive file="$DISK",format=qcow2 \
    -boot c $NIC
fi