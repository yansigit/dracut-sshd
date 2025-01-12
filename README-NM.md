This file explains how to enable the NetworkManager module for dracut-sshd.

To use NetworkManager instead of networkd, follow these steps:

1.  Copy the `46sshd-networkmanager` subdirectory to the Dracut module directory:

    ```bash
    cp -ri 46sshd-networkmanager /usr/lib/dracut/modules.d
    ```

2.  Create a NetworkManager configuration file, for example at `/etc/NetworkManager/system-connections/dracut-nm-wired.nmconnection`:

    ```
    [connection]
    id=wired
    interface-name=eth0
    type=ethernet
    autoconnect=true

    [ipv4]
    method=auto

    [ipv6]
    method=ignore
    ```

    Adjust the `interface-name` if necessary.

3.  Enable the NetworkManager dracut module by creating a configuration file, for example `/etc/dracut.conf.d/90-networkmanager.conf` with the following content:

    ```
    # cat /etc/dracut.conf.d/90-networkmanager.conf
    force_drivers+=" "
    add_dracutmodules+=" network-manager "
    ```

4.  Regenerate the initramfs:

    ```bash
    dracut -f -v
    ```

This will enable NetworkManager in the initramfs, allowing you to connect to the system remotely during early boot.