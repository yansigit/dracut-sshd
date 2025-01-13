#!/bin/bash

# depends on the network-manager module
dracut_need_modules+=" network-manager "

# called by dracut
check() {
    require_binaries sshd || return 1
    # 0 enables by default, 255 only on request
    return 0
}

# called by dracut
depends() {
    # We depend on network-manager
    echo network-manager
}

# called by dracut
# install() {
#     inst_hook pre-trigger 00 "$moddir/nm-start.sh"
# }

# from https://github.com/wtogami/dracut-sshd
install() {
    # allow NetworkManager to auto configure "Wired connection #" DHCP connections for Ethernet interfaces
    rm -f  "$initdir/usr/lib/NetworkManager/conf.d/initrd-no-auto-default.conf"

    # tell Networkmanager to run
    echo "rd.neednet" >> "${initdir}/etc/cmdline.d/50neednet.conf"
    return 0
}