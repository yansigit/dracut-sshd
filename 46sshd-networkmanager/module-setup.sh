#!/usr/bin/env bash

# depends on the network-manager module
depends_on network-manager

check() {
    return 0
}

depends() {
    return 0
}

install() {
    inst_hookpre "initqueue" 00 "$moddir/nm-start.sh"
    inst_simple "$moddir/nm-wired.conf" "/etc/NetworkManager/system-connections/"
}