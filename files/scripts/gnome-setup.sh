#!/usr/bin/env bash

systemctl enable gdm.service
systemctl set-default graphical.target
