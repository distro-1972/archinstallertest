#!/bin/bash
## test
loadkeys en
device="/dev/sda"
boot="/dev/sda1"
swap="/dev/sda2"
main="/dev/sda3"
echo "Done."
echo "Creating new partitions..."
echo " "
echo "Creating /dev/sda1, 512MiB, EFI Boot partition."
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${TGTDEV}
  o # clear the in memory partition table
  n # new partition
  p # primary partition
  1 # partition number 1
    # default - start at beginning of disk 
  +512M # 100 MB boot parttion
  a
EOF

echo "-----------------------------------------------------"
echo "Finished creating partitions!"
clear
echo "Formatting partitions..."
echo " "