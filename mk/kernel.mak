filesystem_path := $(shell ls ${kernel_dir}/${vmm_dir} 2>/dev/null)


apply-patch: $(patch1) $(patch2)
ifeq ($(strip $(filesystem_path)),) 
	$(shell mkdir -p ${kernel_dir}/${vmm_dir})
	patch -d $(kernel_dir) -p1 < $<
endif

build-kernel: apply-patch
	$(shell mkdir -p ${target_out_kernel})
	$(shell mkdir -p ${target_out_kernel}/${vmm_dir}/realview_a8)
	$(shell mkdir -p ${target_out_kernel}/${vmm_dir}/am33xx)
	cp -f configs/$(kernel_config) $(target_out)/kernel/.config
	make -C $(kernel_dir) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) \
		O=$(target_out_kernel) oldconfig zImage
