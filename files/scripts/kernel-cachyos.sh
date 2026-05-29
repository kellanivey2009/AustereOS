#!/bin/bash
set -euo pipefail

# Find out exactly what kernel packages are installed
INSTALLED=$(rpm -qa | grep '^kernel' | awk -F'-[0-9]' '{print $1}' | sort -u)
echo "Installed kernel packages: $INSTALLED"

# Remove only what's actually present, install cachyos kernel + addons
rpm-ostree override remove \
  kernel \
  kernel-core \
  kernel-modules \
  kernel-modules-core \
  kernel-modules-extra \
  $(rpm -q kernel-devel-matched &>/dev/null && echo kernel-devel-matched) \
  $(rpm -q kernel-devel &>/dev/null && echo kernel-devel) \
  --install kernel-cachyos \
  --install cachyos-settings \
  --install cachyos-ksm-settings \
  --install scx-scheds
