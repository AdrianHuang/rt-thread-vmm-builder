build-rootfs: $(rootfs_target)

$(rootfs_target):
	$(shell mkdir -p ${target_out_rootfs})
	$(shell mkdir -p ${target_out_rootfs}/vmm/)
	cd $(target_out_rootfs) && (zcat $(rootfs_file) | sudo cpio -idv)
	make -C $(target_out_kernel) M=$(rtt_linux_vmm) \
		VMM_HDR_DIR=$(rtt_bsp) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE)
	sudo cp -f $(rtt_linux_vmm)/rtvmm.ko $(target_out_rootfs)/root 
	sudo cp -f $(rtt_bin) ${target_out_rootfs}/vmm/
	cd $(target_out_rootfs) && sudo sh -c 'find ./ -print | \
				cpio -H newc -o | gzip -9 > \
				$(target_out_rootfs)/../rootfs.cpio.gz'
