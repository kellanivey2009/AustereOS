#!/usr/bin/env bash

sudo systemctl -f enable gdm && sudo systemctl set-default graphical.target && sudo systemctl start gdm
