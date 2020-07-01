#!/bin/bash
arch-chroot /mnt useradd -mU -s /usr/bin/bash -G wheel,uucp,video,audio,storage,games,input "$user"
arch-chroot /mnt chsh -s /usr/bin/bash

echo "$user:$password" | chpasswd --root /mnt
echo "root:$password" | chpasswd --root /mnt