#!/bin/bash
# This module adds cryptsetup, fdisk, and lsblk to the initramfs

check() {
    return 0
}

depends() {
    echo "crypt"
}

install() {
    # Add cryptsetup, fdisk, and lsblk to the initramfs
    inst_multiple cryptsetup fdisk lsblk
}
