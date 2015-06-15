target_bsp := realview-a8
rtt_bsp := $(rtt_dir)/bsp/$(target_bsp)
rtt_bin := $(rtt_bsp)/rtthread.bin
rtt_linux_vmm := $(rtt_bsp)/linux_vmm

build-rtt:
	cd $(rtt_bsp) && scons
