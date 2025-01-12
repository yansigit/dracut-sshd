This file explains how to enable the NetworkManager module for dracut-sshd.

To use NetworkManager instead of networkd, follow these steps:

1. Install `sudo dnf install dracut-network`

2.  Copy the `46sshd` and `46sshd-networkmanager` subdirectories to the Dracut module directory:

    ```bash
    sudo cp -r 46sshd /usr/lib/dracut/modules.d
    ```

    The `46sshd` directory contains the core SSH functionality for dracut-sshd, while `46sshd-networkmanager` provides the NetworkManager integration. Both are required. The `46sshd` module does not require any modifications to work with NetworkManager.

3.  Create an authorized keys file at `/root/.ssh/dracut_authorized_keys`. This file should contain the public keys that you want to use to connect to the system during early boot. For example:

    ```
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1... user@example.com
    ```

4. Copy paste the `90-networkmanager.conf` in example to `/etc/dracut.conf.d/90-networkmanager.conf`

5. Modify grub config and add `rd.neednet=1` to `GRUB_CMDLINE_LINUX`.
`ip=dhcp` also can be used optionally.
    ```
    sudo nano /etc/default/grub
    sudo dnf install grub2 grub2-tools
    sudo grub2-mkconfig -o /boot/grub2/grub.cfg
    ```

6.  Regenerate the initramfs:

    ```bash
    dracut -f -v
    ```

This will enable NetworkManager in the initramfs, allowing you to connect to the system remotely during early boot.