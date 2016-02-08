# Get the rootfs.tar on cdtx@192.168.0.1 through sftp
# sftp cdtx@192.168.0.1
if [ ! -e rootfs.tar ]; then
    echo 'rootfs.tar not found'
    exit 1
fi
if [ ! -e initramfs.cpio.gz ]; then
    echo 'initramfs.cpio.gz not found'
    exit 1
fi

umount /dev/hda1 2>/dev/null
umount /dev/hda2 2>/dev/null
umount /dev/hda3 2>/dev/null

echo 'Create partitions'
parted -s /dev/hda rm 1
parted -s /dev/hda rm 2

# /boot (ext4, 20M)
echo 'Format partition 1'
parted -s -a cylinder /dev/hda mkpart primary ext4 0 50
parted -s /dev/hda set 1 boot on
mkfs.ext4 /dev/hda1

# root (/) (ext4, 500M)
echo 'Format partition 2'
parted -s -a cylinder -- /dev/hda mkpart primary ext4 51 500
mkfs.ext4 /dev/hda2

# Create directories and mount partitions
echo 'Mount partitions'
mkdir /tmp/x /tmp/y
mount /dev/hda1 /tmp/x
mount /dev/hda2 /tmp/y

# Copy the kernel image and initramfs into the root partition
echo 'Copy the kernel image and initramfs into the root partition'
cp /boot/bzImage /tmp/x
cp /boot/initramfs.cpio.gz /tmp/x

# And the bootloader config files
cp /boot/vesamenu.c32 /tmp/x
cp /boot/extlinux.conf /tmp/x

# Extract the rootfs into the second partition
echo 'Extract the rootfs into the second partition'
tar -C /tmp/y -xf /boot/rootfs.tar

# Make the disque bootable
echo 'Make the disque bootable'
dd if=/usr/syslinux/mbr/mbr.bin of=/dev/hda

/usr/syslinux/extlinux/extlinux --install /tmp/x
