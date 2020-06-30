## test

loadkeys us
device = "/dev/sda"
boot = "/dev/sda1"
swap = "/dev/sda2"
main = "/dev/sda3"


echo "Deleting all partitions..."
rm -rf
echo "Done."

echo "Creating new partitions..."
echo " "
echo "Creating /dev/sda1, 512MiB, EFI Boot partition."
parted --script "$device" -- mklabel gpt \
  mkpart ESP fat32 1Mib 129MiB \
  set 1 boot on \
  echo "Creating /dev/sda2, Linux Swap partition."
  mkpart primary linux-swap 129MiB ${swap_end} \
  echo "Creating /dev/sda3, Linux ext4 partition. This is the main partition where the OS will be."
  mkpart primary ext4 ${swap_end} 100%
echo "-----------------------------------------------------"
echo "Finished creating partitions!"
sleep 2
clear
echo "Formatting partitions..."
echo " "
echo "Formatting /dev/sda1 to Fat32..."
mkfs.vfat -F32 "$boot"
echo "Formatting /dev/sda2 to Swap..."
mkswap "$swap"
swapon "$swap"
echo "Formatting /dev/sda3 to ext4..."
mkfs.ext4 "$main"
