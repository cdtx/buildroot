DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -d /tmp/tftpboot ]; then
    sudo mkdir /tmp/tftpboot
fi

sudo rm -rf /tmp/tftpboot/*
# Kernel
sudo cp  $DIR/../../../output/images/bzImage /tmp/tftpboot/
# cpio fs
sudo cp  $DIR/../../../output/images/rootfs.cpio /tmp/tftpboot/
# initramfs
sudo cp  $DIR/initramfs.cpio.gz /tmp/tftpboot/

# NFS bootloader
sudo cp /usr/lib/syslinux/pxelinux.0 /tmp/tftpboot/
sudo cp /usr/lib/syslinux/menu.c32 /tmp/tftpboot/
if [ ! -d /tmp/tftpboot/pxelinux.cfg ]; then
    sudo mkdir /tmp/tftpboot/pxelinux.cfg
fi
sudo cp $DIR/pxeboot.menu.cfg /tmp/tftpboot/pxelinux.cfg/default


# sudo tar -C /srv/nfsroot/ -xf output/images/rootfs.tar
# sudo cp $DIR/../../../output/images/rootfs.tar /tmp
