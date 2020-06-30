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
fdisk -u /dev/sda <<EOF
n
p
1
+512M
w
EOF
echo "-----------------------------------------------------"
echo "Finished creating partitions!"
clear
echo "Formatting partitions..."
echo " "