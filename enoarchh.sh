#! /bin/bash

# This is Krushn's Arch Linux Installation Script.
# Visit krushndayshmookh.github.io/krushn-arch for instructions.

echo "Arch Installer, created by Enoki"
echo "This is based on Krushn's installer, but modified to be hands-free."

# Filesystem mount warning
echo "This script will create and format the partitions as follows:"
echo "/dev/sda1 - 512Mib, will be mounted as /boot/efi"
echo "/dev/sda2 - 8GiB, will be used as swap"
echo "/dev/sda3 - rest of space will be mounted as /"
echo "-------------------------------------------------------------"
echo "Creating partitions..."

sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${TGTDEV}
  o # clear the in memory partition table
  n # new partition
  p # primary partition
  1 # partition number 1
    # default - start at beginning of disk 
  +512M # 512 MB boot parttion
  n # new partition
  p # primary partition
  2 # partion number 2
    # default, start immediately after preceding partition
  +8G # 8 GB swap parttion
  n # new partition
  p # primary partition
  3 # partion number 3
    # default, start immediately after preceding partition
    # default, extend partition to end of disk
  a # make a partition bootable
  1 # bootable partition is partition 1 -- /dev/sda1
  p # print the in-memory partition table
  w # write the partition table
  q # and we're done
EOF

# Format the partitions
clear
echo "Formatting /dev/sda3 as ext4 (Main Partition)..."
mkfs.ext4 /dev/sda3
echo "Formatting /dev/sda1 as FAT32 (EFI Boot Partition)..."
mkfs.fat -F32 /dev/sda1

# Set up time
clear
echo "Setting Time.."
timedatectl set-ntp true

# Initate pacman keyring
pacman-key --init
pacman-key --populate archlinux
pacman-key --refresh-keys

# Mount the partitions
echo "Mounted main partition to /mnt"
mount /dev/sda3 /mnt
mkdir -pv /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
echo "Mounted boot partition to /mnt/boot/efi"
mkswap /dev/sda2
swapon /dev/sda2
echo "Set /dev/sda2 to be Swap memory."

# Install Arch Linux
echo "Starting install.."
echo "Installing Arch. This will take a bit, please wait." 
pacman -Sy
pacman -S reflector
reflector --verbose -c America -c Canada -c Mexico --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel grub

# Generate fstab
echo "Generating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab

# Copy post-install system cinfiguration script to new /root
cp -rfv post-install.sh /mnt/root
chmod a+x /mnt/root/post-install.sh

# Chroot into new system
echo "You are now inside your install of Arch! However, we are not done yet. Please run 'EnoArch_post' to complete the install."
arch-chroot /mnt /bin/bash