
all:
	# find . | grep -v Makefile | cpio -H newc -o  > ../initramfs.cpio
	find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../initramfs.cpio.gz
	# cat ../initramfs.cpio | gzip > ../initramfs.igz

clean:
	rm ../initramfs.cpio.gz 
