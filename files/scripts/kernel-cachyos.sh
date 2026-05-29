#!/bin/bash
set -euo pipefail

# Helper: only echo package name if it's installed
pkg_if_installed() {
  rpm -q "$1" &>/dev/null && echo "$1" || true
}

# kmod-nvidia is installed with a versioned name like kmod-nvidia-7.0.9-205.fc44.x86_64
# so we query by prefix instead
KMOD_NVIDIA=$(rpm -qa 'kmod-nvidia*' | head -1)
if [ -n "$KMOD_NVIDIA" ]; then
  echo "Found kmod-nvidia package: $KMOD_NVIDIA"
  KMOD_NVIDIA_ARG="$KMOD_NVIDIA"
else
  echo "No kmod-nvidia package found"
  KMOD_NVIDIA_ARG=""
fi

EXTRA_REMOVES=$(
  pkg_if_installed akmod-nvidia
  pkg_if_installed kernel-uki-virt
  pkg_if_installed kernel-devel-matched
  pkg_if_installed zram-generator-defaults
  [ -n "$KMOD_NVIDIA_ARG" ] && echo "$KMOD_NVIDIA_ARG" || true
)

echo "Extra packages to remove: $EXTRA_REMOVES"

rpm-ostree override remove \
  kernel \
  kernel-core \
  kernel-modules \
  kernel-modules-core \
  kernel-modules-extra \
  $EXTRA_REMOVES \
  --install kernel-cachyos \
  --install cachyos-settings \
  --install cachyos-ksm-settings \
  --install scx-scheds
