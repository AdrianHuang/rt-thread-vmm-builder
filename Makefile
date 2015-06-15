root_dir := $(shell pwd)

include configs/sources

include mk/defs.mak

kernel_target := $(target_out)/kernel/arch/arm/boot/zImage
rootfs_target := $(target_out)/rootfs.cpio.gz
qemu_target_arch := realview-pb-a8

# toolchain configurations
CROSS_COMPILE ?= arm-none-eabi-

.PHONY: all prepare kernel rootfs
all: prepare stamp-kernel stamp-rtt stamp-rootfs

prepare:

include mk/download.mak

# Linux kernel
stamp-kernel:
	$(MAKE) build-kernel
	touch $@
include mk/kernel.mak
clean-kernel:
	rm -rf $(target_out_kernel) stamp-kernel

# RT-Thread
stamp-rtt:
	$(MAKE) build-rtt
	touch $@
include mk/rtt.mak
clean-rtt:
	cd $(rtt_bsp) && scons -c
	rm -f $(rtt_bin) stamp-rtt

# Root file system
stamp-rootfs: stamp-kernel stamp-rtt
	$(MAKE) build-rootfs
	touch $@
include mk/rootfs.mak
clean-rootfs:
	make -C $(target_out_kernel) M=$(rtt_linux_vmm) \
		ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) clean
	sudo rm -rf $(target_out_rootfs) $(rootfs_target) stamp-rootfs

.PHONY += clean
clean: clean-rtt clean-rootfs clean-kernel
	sudo rm -rf $(target_out)

.PHONY += distclean
distclean: clean
	sudo rm -rf $(kernel_dir) $(rtt_dir)

.PHONY += qemu
qemu: all
	qemu-system-arm -M $(qemu_target_arch) -kernel $(kernel_target) \
		 -initrd $(rootfs_target) -serial vc -serial vc
