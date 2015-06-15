#!/bin/bash

BSP=realview-pb-a8

LINUX_IMAGE=../out/kernel/arch/arm/boot/zImage
INITRD=../out/rootfs.cpio.gz

if [ $# != 1 ]
then
	echo -e "$0 pts_number"
	exit 1
fi

qemu-system-arm -nographic -M $BSP -kernel $LINUX_IMAGE -initrd $INITRD -chardev tty,id=pts$1,path=/dev/pts/$1
#qemu-system-arm -nographic -M BSP -kernel $LINUX_IMAGE -initrd $INITRD -serial file:boot.log
