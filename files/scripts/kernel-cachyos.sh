#!/bin/bash
set -euo pipefail

echo "Installed kernel packages:"
rpm -qa | grep '^kernel' | awk -F'-[0-9]' '{print $1}' | sort -u

rpm-ostree override remove \
  kernel \
  kernel-core \
  kernel-modules \
  kernel-modules-core \
  kernel-modules-extra \
  kmod-nvidia \
  zram-generator-defaults \
  --install kernel-cachyos \
  --install cachyos-settings \
  --install cachyos-ksm-settings \
  --install scx-scheds
