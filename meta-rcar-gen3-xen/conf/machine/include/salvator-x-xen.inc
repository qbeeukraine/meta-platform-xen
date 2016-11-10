#@TYPE: Machine
#@NAME: Salvator-X wth Xen machine
#@DESCRIPTION: Machine configuration for running Salvator-X with Xen hypervisor

DEFAULTTUNE ?= "cortexa57-cortexa53"
require conf/machine/include/tune-cortexa57-cortexa53.inc
require conf/machine/include/${SOC_FAMILY}.inc

# 32BIT package install (default is disable)
# This variables can be used only in multilib.
USE_32BIT_PKGS ?= "0"
USE_32BIT_WAYLAND ?= "0"
USE_32BIT_MMP ?= "0"

MACHINE_FEATURES = ""

KERNEL_IMAGETYPE = "Image"
IMAGE_FSTYPES = "tar.bz2 ext4 cpio.gz"

SERIAL_CONSOLE = "115200 ttySC0"

# Configuration for kernel
PREFERRED_PROVIDER_virtual/kernel = "linux-renesas"

# Configuration for ARM Trusted Firmware
EXTRA_IMAGEDEPENDS += " arm-trusted-firmware optee-os"

# u-boot
PREFERRED_VERSION_u-boot = "v2015.04%"
EXTRA_IMAGEDEPENDS += " u-boot"
# H3 u-boot configure
UBOOT_MACHINE_r8a7795 = "r8a7795_salvator-x_defconfig"
# M3 u-boot configure
UBOOT_MACHINE_r8a7796 = "r8a7796_salvator-x_defconfig"

# libdrm
PREFERRED_VERSION_libdrm = "2.4.68"

#xen
PREFERRED_VERSION_xen = "4.7.0+git%"

MACHINEOVERRIDES =. "salvator-x:"
