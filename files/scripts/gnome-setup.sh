#!/usr/bin/env bash

systemctl enable gdm.service
ln -sf /usr/lib/systemd/system/graphical.target /etc/systemd/system/default.target
