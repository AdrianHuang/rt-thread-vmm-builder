# downloads and temporary output directory
$(shell mkdir -p $(target_out))

# Check cross compiler
filesystem_path := $(shell which ${CROSS_COMPILE}gcc 2>/dev/null)
ifeq ($(strip $(filesystem_path)),)                                                                                         
$(error No ARM toolchain found)
endif

# Check kernel
filesystem_path := $(shell ls $(kernel_dir) 2>/dev/null)
ifeq ($(strip $(filesystem_path)),)
$(info *** Fetching linux-3.8 source ***)
$(info $(shell ${FETCH_CMD_kernel}))
endif

# Check rt-thread
filesystem_path := $(shell ls $(rtt_dir) 2>/dev/null)
ifeq ($(strip $(filesystem_path)),)
$(info *** Fetching rt-thread-for-vmm ***)
$(info $(shell ${FETCH_CMD_rtt}))
endif

