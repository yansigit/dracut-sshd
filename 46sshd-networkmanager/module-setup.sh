#!/bin/bash

# depends on the network-manager module
dracut_need_modules+=" network-manager "

# called by dracut
depends() {
    return 0
}

# called by dracut
install() {
    inst_hook pre-trigger 00 "$moddir/nm-start.sh"
    inst_simple "$moddir/dracut-nm-wired.nmconnection" "/etc/NetworkManager/system-connections/"
}