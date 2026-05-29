#!/bin/bash
set -euo pipefail

# Helper: only echo package name if it's installed
pkg_if_installed() {
  rpm -q "$1" &>/dev/null && echo "$1" || true
}

EXTRA_REMOVES=$(
  pkg_if_installed kmod-nvidia
  pkg_if_installed akmod-nvidia
  pkg_if_installed kernel-devel-matched
  pkg_if_installed zram-generator-defaults
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
