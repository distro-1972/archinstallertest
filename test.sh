#!/bin/bash
## test
loadkeys en
device="/dev/sda"
boot="/dev/sda1"
swap="/dev/sda2"
main="/dev/sda3"
echo "Deleting all partitions..."
rm -rf
echo "Done."
echo "Creating new partitions..."
echo " "
echo "Creating /dev/sda1, 512MiB, EFI Boot partition."
fdisk -u -p /dev/sda <<EOF
n
p
1
+512M
w
EOF
echo "-----------------------------------------------------"
echo "Finished creating partitions!"
sleep 2
clear
echo "Formatting partitions..."
echo " "