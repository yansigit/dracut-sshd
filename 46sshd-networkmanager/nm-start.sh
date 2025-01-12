#!/usr/bin/env bash

modprobe dm-crypt

# Start NetworkManager
systemctl start NetworkManager.service