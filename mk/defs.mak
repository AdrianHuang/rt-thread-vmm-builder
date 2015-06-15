kernel_dir := $(root_dir)/$(kernel_version)
rtt_dir := $(root_dir)/$(rtt_folder)
patch_dir := $(rtt_dir)/components/vmm/linux_patch-v3.8
rootfs_file := $(root_dir)/rootfs/rootfs.cpio.gz
vmm_dir := arch/arm/vmm

patch1 := $(patch_dir)/0001-RTT-VMM-implement-dual-system-running-on-realview-pb.patch
patch2 := $(patch_dir)/0002-arm-gic-correct-the-cpu-map-on-gic_raise_softirq-for.patch

kernel_config := kernel_realview_pb_a8_config

target_out := $(root_dir)/out

TARGETS := $(kernel_target) $(rootfs_target)

target_out_kernel := $(target_out)/kernel
target_out_rootfs := $(target_out)/rootfs
