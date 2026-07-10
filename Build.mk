# SPDX-License-Identifier: GPL-2.0-or-later

# Explicit directory traversal, following the Kbuild model. New directories do
# not enter a build merely because a file appeared in the source tree.
include arch/$(ARCH)/Build.mk
include kernel/Build.mk
include mm/Build.mk
include fs/Build.mk
include drivers/Build.mk
include fdt/Build.mk
include lib/Build.mk
include test/Build.mk
include usr/Build.mk
include scripts/build/Build.mk

# The image root is an interface target: it carries the complete dependency
# set but contributes no sources of its own.
targets += generated/autoconf generated/asm-offsets generated/linker-script \
           generated/initramfs-cpio blob/initramfs kernel/image
target.generated/autoconf.kind := generated
target.generated/autoconf.outputs := $(BUILD)/generated/autoconf.h
target.generated/autoconf.inputs := scripts/Kconfig.mk $(KCONFIG_CONFIG)
target.generated/autoconf.action := autoconf

target.generated/asm-offsets.kind := generated
target.generated/asm-offsets.outputs := $(BUILD)/generated/asm-offsets.h
target.generated/asm-offsets.inputs := arch/$(ARCH)/kernel/asm-offsets.c \
    scripts/extract-asm-offsets.sed
target.generated/asm-offsets.generated-deps := generated/autoconf
target.generated/asm-offsets.action := asm-offsets

target.generated/linker-script.kind := generated
target.generated/linker-script.outputs := $(BUILD)/lumeos.lds
target.generated/linker-script.inputs := arch/$(ARCH)/kernel/lumeos.lds.S \
    include/lume/lumeos.lds.h
target.generated/linker-script.action := linker-script

target.generated/initramfs-cpio.kind := generated
target.generated/initramfs-cpio.outputs := $(BUILD)/initramfs.cpio
target.generated/initramfs-cpio.inputs := $(CONFIG_INITRAMFS_SOURCE) \
    scripts/gen_initramfs.sh
target.generated/initramfs-cpio.tool-deps := host/gen_init_cpio
target.generated/initramfs-cpio.action := initramfs

target.blob/initramfs.kind := binary-blob
target.blob/initramfs.outputs := $(BUILD)/initramfs.o
target.blob/initramfs.inputs := usr/initramfs.S
target.blob/initramfs.generated-deps := generated/initramfs-cpio

target.kernel/image.kind := product
target.kernel/image.deps := \
    arch/$(ARCH) kernel/core mm/core fs/core drivers/core fdt/core lib/core \
    $(if $(filter y,$(CONFIG_SELFTEST)),test/kernel)
target.kernel/image.generated-deps := \
    generated/autoconf generated/asm-offsets generated/linker-script \
    blob/initramfs
target.kernel/image.outputs := $(VMLUME) $(IMAGE)
