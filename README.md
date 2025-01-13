This file explains how to enable the NetworkManager module for dracut-sshd.

To use NetworkManager instead of networkd, follow these steps:

1. Install `sudo dnf install dracut-network`

2. execute `usermod -p '*' root` on root user

3.  Copy the `46sshd` and `99sshd-networkmanager` subdirectories to the Dracut module directory:

    ```bash
    sudo cp -r 46sshd /usr/lib/dracut/modules.d
    sudo cp -r 99sshd-networkmanager /usr/lib/dracut/modules.d
    ```

4.  Create an authorized keys file at `/root/.ssh/authorized_keys`. This file should contain the public keys that you want to use to connect to the system during early boot. For example:

    ```
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1... user@example.com
    ```

<!-- 5. Modify grub config and add `rd.neednet=1` to `GRUB_CMDLINE_LINUX`.
`ip=dhcp` also can be used optionally.
    ```
    sudo nano /etc/default/grub
    sudo dnf install grub2 grub2-tools
    sudo grub2-mkconfig -o /boot/grub2/grub.cfg
    ``` -->

5.  Regenerate the initramfs:

    ```bash
    sudo dracut -f -v
    ```

This will enable NetworkManager in the initramfs, allowing you to connect to the system remotely during early boot.