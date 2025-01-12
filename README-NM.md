This file explains how to enable the NetworkManager module for dracut-sshd.

To use NetworkManager instead of networkd, follow these steps:

1.  Copy the `46sshd` and `46sshd-networkmanager` subdirectories to the Dracut module directory:

    ```bash
    sudo cp -r 46sshd /usr/lib/dracut/modules.d
    sudo cp -r 46sshd-networkmanager /usr/lib/dracut/modules.d
    ```

    The `46sshd` directory contains the core SSH functionality for dracut-sshd, while `46sshd-networkmanager` provides the NetworkManager integration. Both are required. The `46sshd` module does not require any modifications to work with NetworkManager.

2.  Create an authorized keys file at `/root/.ssh/dracut_authorized_keys`. This file should contain the public keys that you want to use to connect to the system during early boot. For example:

    ```
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1... user@example.com
    ```

3.  Create a NetworkManager configuration file, for example at `/etc/NetworkManager/system-connections/dracut-nm-wired.nmconnection`:

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

4.  Enable the NetworkManager dracut module by creating a configuration file, for example `/etc/dracut.conf.d/90-networkmanager.conf` with the following content:

    ```
    # cat /etc/dracut.conf.d/90-networkmanager.conf
    force_drivers+=" "
    add_dracutmodules+=" network-manager "
    ```

5.  Regenerate the initramfs:

    ```bash
    dracut -f -v
    ```

This will enable NetworkManager in the initramfs, allowing you to connect to the system remotely during early boot.