# rt-thread-vmm-builder
The builder generates a couples of files listed in the following:
  * Linux kernel image (zImage) with applying two VMM patches
  * Initramfs image file (out/rootfs.cpio.gz)
    - The root file system built by Buildroot
    - A kernel moudule (/root/rtvmm.ko)
    - A RT-Thread image file (/vmm/rtthread.bin)
    

# Platform Support
  * Realview Platform Baseboard A8
  * Beaglebone Black

# Prerequisites
The building environment is based on Ubuntu 14.04.2 LTS (x86_64).

* Required Pacakges:
``` 
    sudo apt-get install build-essential git zlib1g-dev libsdl1.2-dev libglib2.0-dev "automake*" "autoconf*" libtool libpixman-1-dev
    sudo apt-get install lib32gcc1 lib32ncurses5
    sudo apt-get install gcc-arm-none-eabi libnewlib-arm-none-eabi qemu-system-arm
```

# Build Instruction
  * Compile the kernel linux-3.8.13 with two VMM patches, RT-thread and the rtvmm driver.
```
    make
```
  * Execute the following command to launch qemu emulator. Key combination for Linux console and RT-Thread console are listed as follows:
    - Linux console: Ctrl+Alt+F3
    - RT-Thread console: Ctrl+Alt+F4
```
    make qemu
```
  * Press Ctrl+Alt+F3 to enter Linux console mode. Excute the following command to launch RT-Thread VM.
```
    insmod /root/rtvmm.ko
```

# Reference
[Official RT-Thread GIT Repository](https://github.com/RT-Thread/rt-thread)
