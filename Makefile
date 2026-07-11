# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026 Richard Qin
#
# LumeOS Kernel Makefile (Non-Recursive)
#
# Usage:
#   make          - Build kernel ELF
#   make run      - Run in QEMU
#   make debug    - Run in QEMU with GDB server
#   make clean    - Clean build artifacts
#   make fmt      - Format all source files
#   make disasm   - Generate disassembly listing
#
# Reference: docs/specs/00_conventions.md §7

# ============================================================
# Build Configuration
# ============================================================
O ?= build
BUILD := $(patsubst %/,%,$(O))

# Make sure `make` with no arguments builds the kernel image, not the
# first rule encountered during makefile parsing.
.DEFAULT_GOAL := all

# Load command helpers before Kconfig and target evaluation.
include scripts/Kbuild.include

# Load the O=-scoped configuration and derive compiler definitions.
include scripts/Kconfig.mk

ARCH    ?= $(CONFIG_ARCH)
PLATFORM ?= qemu-virt
BUILD_VARIANT ?= debug

ifneq ($(filter $(BUILD_VARIANT),debug release),$(BUILD_VARIANT))
$(error unsupported BUILD_VARIANT '$(BUILD_VARIANT)' (expected debug or release))
endif

# Toolchain selection needs the configured architecture but must precede flag
# and module evaluation.
include scripts/build/toolchain.mk

# Two boot products — same pair as Linux RISC-V's arch/riscv/boot/Makefile
# (vmlinux + Image), but named LumeOS-style:
#   VMLUME -> build/vmlume.elf : ELF with .symtab/PT_DYNAMIC/.rela.dyn
#   IMAGE  -> build/vmlume.bin : raw binary (objcopy -O binary)
VMLUME := $(BUILD)/vmlume.elf
IMAGE  := $(BUILD)/vmlume.bin

# Initramfs paths
INITRAMFS_DIR   := $(BUILD)/initramfs
INITRAMFS_CPIO  := $(BUILD)/initramfs.cpio
INITRAMFS_OBJ   := $(BUILD)/initramfs.o
INITRAMFS_ASM   := usr/initramfs.S
USR_INIT_ELF    := $(BUILD)/usr/init
# Relocations: linker emits .rela.dyn under -shared -Bsymbolic; boot
# code in arch/riscv/mm/init.cc::relocate_kernel walks it at startup.
LDS_SRC := arch/$(ARCH)/kernel/lumeos.lds.S
LINKER_SCRIPT := $(BUILD)/lumeos.lds
PYTHON ?= python3

# Objcopy output formats for binary-to-ELF relocation blob
OBJCOPY_ELF_riscv := elf64-littleriscv
OBJCOPY_ELF_aarch64 := elf64-littleaarch64
OBJCOPY_ELF_x86_64 := elf64-x86-64
OBJCOPY_ELF := $(OBJCOPY_ELF_$(ARCH))

OBJCOPY_BINARCH_riscv := riscv
OBJCOPY_BINARCH_aarch64 := aarch64
OBJCOPY_BINARCH_x86_64 := i386:x86-64
OBJCOPY_BINARCH := $(OBJCOPY_BINARCH_$(ARCH))

# Common include roots. Environment-specific flags are defined after target
# usage requirements have been collected.
INCLUDES := -Iinclude -I.

# ============================================================
# Declarative Target Graph
# ============================================================
include scripts/build/targets.mk
include Build.mk
$(eval $(call validate-targets))

KERNEL_ROOT := kernel/image
KERNEL_TARGETS := $(sort $(call target-closure,$(KERNEL_ROOT)))
KERNEL_LINK_TARGET_ORDER := $(call unique-words,$(call target-link-order,$(KERNEL_ROOT)))
KERNEL_SOURCE_KINDS := object-library source-set static-library whole-archive kernel-test
KERNEL_SOURCE_TARGETS := $(foreach target,$(KERNEL_TARGETS),\
    $(if $(filter $(KERNEL_SOURCE_KINDS),$(target.$(target).kind)),$(target)))
KERNEL_SOURCES := $(sort $(foreach target,$(KERNEL_SOURCE_TARGETS),\
    $(target.$(target).sources)))

SRCS_CC := $(filter %.cc,$(KERNEL_SOURCES))
SRCS_C  := $(filter %.c,$(KERNEL_SOURCES))
SRCS_S  := $(filter %.S,$(KERNEL_SOURCES))
SRCS_s  := $(filter %.s,$(KERNEL_SOURCES))

# Only public usage requirements propagate. Private include paths and flags are
# attached to the objects belonging to the declaring target below.
INCLUDES += $(addprefix -I,$(call target-public-includes,$(KERNEL_ROOT)))
INCLUDES += $(foreach dir,$(call target-public-after-includes,$(KERNEL_ROOT)),-idirafter $(dir))

include scripts/build/environments/kernel.mk
include scripts/build/environments/phys.mk

# ============================================================
# Object File Computation
# ============================================================
# A source may be compiled by multiple targets/environments. Object identity
# therefore includes both the logical target and source path.
source-object = $(BUILD)/obj/$(call target-key,$(1))/$(basename $(2)).o
define apply-target-usage
target.$(1).objects := $$(foreach src,$$(target.$(1).sources),$$(call source-object,$(1),$$(src)))
$$(target.$(1).objects): PRIVATE_INCLUDES := \
    $$(addprefix -I,$$(call target-compile-includes,$(1))) \
    $$(foreach dir,$$(call target-compile-after-includes,$(1)),-idirafter $$(dir))
$$(target.$(1).objects): PRIVATE_DEFINES := $$(addprefix -D,$$(call target-compile-defines,$(1)))
$$(target.$(1).objects): PRIVATE_CFLAGS := $$(target.$(1).cflags)
$$(target.$(1).objects): PRIVATE_CXXFLAGS := $$(target.$(1).cxxflags)
$$(target.$(1).objects): PRIVATE_ASFLAGS := $$(target.$(1).asflags)
endef
$(foreach target,$(KERNEL_SOURCE_TARGETS),$(eval $(call apply-target-usage,$(target))))

define apply-source-identity
$(call source-object,$(1),$(2)): PRIVATE_SOURCE := $(2)
endef
$(foreach target,$(KERNEL_SOURCE_TARGETS),$(foreach src,$(target.$(target).sources),\
    $(eval $(call apply-source-identity,$(target),$(src)))))

OBJS := $(foreach target,$(KERNEL_SOURCE_TARGETS),$(target.$(target).objects))
DEPS := $(OBJS:.o=.d)

# libfdt is freestanding but intentionally does not use the libc-shim include
# overlay used by the imported string implementation.
$(target.lib/libfdt.objects): CFLAGS_LIBC = $(CFLAGS) -std=gnu23

KERNEL_STATIC_TARGETS := $(foreach target,$(KERNEL_SOURCE_TARGETS),\
    $(if $(filter static-library,$(target.$(target).kind)),$(target)))
KERNEL_WHOLE_TARGETS := $(foreach target,$(KERNEL_SOURCE_TARGETS),\
    $(if $(filter whole-archive,$(target.$(target).kind)),$(target)))
KERNEL_OBJECT_TARGETS := $(filter-out $(KERNEL_STATIC_TARGETS) $(KERNEL_WHOLE_TARGETS),\
    $(KERNEL_SOURCE_TARGETS))

define define-archive
target.$(1).archive := $(BUILD)/lib/$(call target-key,$(1)).a
$$(target.$(1).archive): PRIVATE_ARCHIVE_OBJECTS := $$(target.$(1).objects)
$$(target.$(1).archive): $$(target.$(1).objects) FORCE
	$$(Q)mkdir -p $$(dir $$@)
	$$(call if_changed,archive)
endef
$(foreach target,$(KERNEL_STATIC_TARGETS) $(KERNEL_WHOLE_TARGETS),\
    $(eval $(call define-archive,$(target))))

KERNEL_LINK_OBJECTS := $(foreach target,$(KERNEL_LINK_TARGET_ORDER),\
    $(if $(filter $(target),$(KERNEL_OBJECT_TARGETS)),$(target.$(target).objects)))
KERNEL_LINK_ARCHIVES := $(foreach target,$(KERNEL_LINK_TARGET_ORDER),\
    $(if $(filter $(target),$(KERNEL_STATIC_TARGETS)),$(target.$(target).archive)))
KERNEL_LINK_WHOLE := $(foreach target,$(KERNEL_LINK_TARGET_ORDER),\
    $(if $(filter $(target),$(KERNEL_WHOLE_TARGETS)),$(target.$(target).archive)))
KERNEL_LINK_INPUTS := $(KERNEL_LINK_OBJECTS) $(KERNEL_LINK_ARCHIVES) \
    $(if $(KERNEL_LINK_WHOLE),--whole-archive $(KERNEL_LINK_WHOLE) --no-whole-archive)

# ============================================================
# Build Rules
# ============================================================
.PHONY: all clean run debug fmt disasm defconfig savedefconfig showconfig \
        help info check-toolchain check-image targets target-info \
        host-libraries host-tests kernel-tests compile_commands \
        phys-libraries toolchain-probe graph FORCE

FORCE:

all: $(VMLUME) $(IMAGE) check-image

check-image: $(VMLUME)
	@RE=$(READELF); NM=$(NM); \
	  scripts/build/check-kernel-elf.sh $(VMLUME) "$$RE" "$$NM" $(ARCH)

# Generate autoconf.h before any compilation
$(AUTOCONF_H): scripts/Kconfig.mk $(wildcard $(KCONFIG_CONFIG)) \
               scripts/build/generate-autoconf.sh FORCE
	$(Q)mkdir -p $(dir $@)
	$(call if_changed,autoconf)

# ============================================================
# Generated header: asm-offsets.h
#
# Linux-style trick (mirrors include/linux/kbuild.h + arch/*/kernel/
# asm-offsets.c + scripts/Makefile.build): compile asm-offsets.c to
# assembly, scrape the magic `->SYM val` markers produced by the
# DEFINE/OFFSET inline-asm macros, rewrite them into `#define`
# directives via sed.  head.S and friends then `#include
# <generated/asm-offsets.h>` to access struct field offsets without
# having to hand-maintain them — re-order a struct field, the
# generated constant follows.
# ============================================================
ASM_OFFSETS_C   := arch/$(ARCH)/kernel/asm-offsets.c
ASM_OFFSETS_S   := $(BUILD)/arch/$(ARCH)/kernel/asm-offsets.s
ASM_OFFSETS_H   := $(BUILD)/generated/asm-offsets.h
ASM_OFFSETS_SED := scripts/extract-asm-offsets.sed

# Compile asm-offsets.c to *.s only — we never want the .o linked in.
$(ASM_OFFSETS_S): PRIVATE_SOURCE := $(ASM_OFFSETS_C)
$(ASM_OFFSETS_S): $(ASM_OFFSETS_C) $(AUTOCONF_H) FORCE
	$(Q)mkdir -p $(dir $@)
	$(call if_changed,cc_s_c)

# Rewrite ->NAME markers into #define lines.  Header guard hand-rolled
# at the top, sed body in the middle, closing #endif at the bottom.
$(ASM_OFFSETS_H): $(ASM_OFFSETS_S) $(ASM_OFFSETS_SED) \
                  scripts/build/generate-asm-offsets.sh FORCE
	$(Q)mkdir -p $(dir $@)
	$(call if_changed,gen_asm_offsets)

# All objects depend on autoconf.h and asm-offsets.h
$(OBJS): $(AUTOCONF_H) $(ASM_OFFSETS_H) FORCE

# ============================================================
# Generic %.pi.o post-processing rule
#
# Mirrors arch/riscv/kernel/pi/Makefile §26-30 in Linux:
#
#   $(obj)/%.pi.o: OBJCOPYFLAGS := --prefix-symbols=__pi_
#                                  --remove-section=.note.gnu.property
#                                  --prefix-alloc-sections=.init.pi
#   $(obj)/%.pi.o: $(obj)/%.o FORCE
#       $(call if_changed,objcopy)
#
# Purpose: take a regular .o produced by the normal compile rule and
# rewrite it so the early position-independent code can coexist with
# the rest of the kernel without symbol clashes:
#
#   --prefix-symbols=__pi_       Every global symbol becomes __pi_<name>.
#                                head.S calls them as __pi_fdt_path_offset
#                                etc., keeping the pre-MMU namespace
#                                cleanly isolated.
#
#   --prefix-alloc-sections=.init.pi
#                                All SHF_ALLOC sections get re-prefixed
#                                so they land in .init.pi in vmlinux.lds.S,
#                                which positions them where the boot
#                                loader has already mapped memory.
#
#   --remove-section=.note.gnu.property
#                                Discarded because post-rename it can
#                                confuse the linker about ELF features.
#
# Generic pattern (`$(BUILD)/%.pi.o`) so any subdir's source can opt in
# by listing a `.pi.o` target in its SRCS.  The companion compile-side
# CFLAGS overrides (replacing -fPIE with -fpie, adding -Os, etc.) are
# expected to come from the subdir's own .mk fragment via target-
# specific CFLAGS_LIBC / CXXFLAGS overrides.
# ============================================================
$(BUILD)/%.pi.o: OBJCOPYFLAGS := --prefix-symbols=__pi_ \
                                 --remove-section=.note.gnu.property \
                                 --prefix-alloc-sections=.init.pi

$(BUILD)/%.pi.o: $(BUILD)/%.o
	$(call cmd,objcopy)

# Preprocess linker script template (.lds.S → .lds)
$(LINKER_SCRIPT): PRIVATE_SOURCE := $(LDS_SRC)
$(LINKER_SCRIPT): $(LDS_SRC) include/lume/lumeos.lds.h FORCE
	$(Q)mkdir -p $(dir $@)
	$(call if_changed,linker_script)

# ============================================================
# Initramfs: pack a root filesystem into a newc cpio.
#
# Pipeline mirrors Linux's Kbuild:
#   usr/gen_init_cpio          — host C tool, produces cpio bytes
#   scripts/gen_initramfs.sh   — wrapper that prepares the listing,
#                                handles directories vs. listing files,
#                                applies uid/gid remap, then invokes the
#                                host tool.
# Sourced from $(CONFIG_INITRAMFS_SOURCE) — see scripts/Kconfig.mk.
# ============================================================

# Host compiler environment is distinct from the cross kernel environment.
include scripts/build/environments/host.mk

# Host tools are registered targets and use the host compiler environment.
HOST_TOOL_TARGETS := $(foreach target,$(targets),\
    $(if $(filter host-tool,$(target.$(target).kind)),$(target)))
HOST_LIBRARY_TARGETS := $(foreach target,$(targets),\
    $(if $(filter host-library,$(target.$(target).kind)),$(target)))
HOST_TEST_TARGETS := $(foreach target,$(targets),\
    $(if $(filter host-test,$(target.$(target).kind)),$(target)))
PHYS_LIBRARY_TARGETS := $(foreach target,$(targets),\
    $(if $(filter phys-library,$(target.$(target).kind)),$(target)))
define define-host-tool
target.$(1).output := $(BUILD)/host/$(call target-key,$(1))
$$(target.$(1).output): PRIVATE_HOST_SOURCE := $$(firstword $$(target.$(1).sources))
$$(target.$(1).output): PRIVATE_HOST_CFLAGS := $$(target.$(1).host-cflags)
$$(target.$(1).output): $$(target.$(1).sources) FORCE
	$$(Q)mkdir -p $$(dir $$@)
	$$(call if_changed,host_tool)
endef
$(foreach target,$(HOST_TOOL_TARGETS),$(eval $(call define-host-tool,$(target))))

host-source-object = $(BUILD)/host/obj/$(call target-key,$(1))/$(basename $(2)).o
define define-host-source
$(call host-source-object,$(1),$(2)): PRIVATE_SOURCE := $(2)
$(call host-source-object,$(1),$(2)): $(2) FORCE
	$$(Q)mkdir -p $$(dir $$@)
	$$(call if_changed,$(if $(filter %.cc,$(2)),host_cxx_o_cc,host_cc_o_c))
endef
define define-host-library
target.$(1).objects := $$(foreach src,$$(target.$(1).sources),$$(call host-source-object,$(1),$$(src)))
target.$(1).archive := $(BUILD)/host/lib/$(call target-key,$(1)).a
$$(foreach src,$$(target.$(1).sources),$$(eval $$(call define-host-source,$(1),$$(src))))
$$(target.$(1).archive): PRIVATE_ARCHIVE_OBJECTS := $$(target.$(1).objects)
$$(target.$(1).archive): $$(target.$(1).objects) FORCE
	$$(Q)mkdir -p $$(dir $$@)
	$$(call if_changed,host_archive)
endef
$(foreach target,$(HOST_LIBRARY_TARGETS),$(eval $(call define-host-library,$(target))))
HOST_DEPS := $(foreach target,$(HOST_LIBRARY_TARGETS),$(target.$(target).objects:.o=.d))

define define-host-test
target.$(1).objects := $$(foreach src,$$(target.$(1).sources),$$(call host-source-object,$(1),$$(src)))
target.$(1).output := $(BUILD)/host/test/$(call target-key,$(1))
$$(foreach src,$$(target.$(1).sources),$$(eval $$(call define-host-source,$(1),$$(src))))
$$(target.$(1).output): PRIVATE_HOST_OBJECTS := $$(target.$(1).objects)
$$(target.$(1).output): PRIVATE_HOST_LIBS := $$(foreach dep,$$(call target-deps,$(1)),$$(target.$$(dep).archive))
$$(target.$(1).output): $$(target.$(1).objects) \
    $$(foreach dep,$$(call target-deps,$(1)),$$(target.$$(dep).archive)) FORCE
	$$(Q)mkdir -p $$(dir $$@)
	$$(call if_changed,host_link)
endef
$(foreach target,$(HOST_TEST_TARGETS),$(eval $(call define-host-test,$(target))))
HOST_TEST_DEPS := $(foreach target,$(HOST_TEST_TARGETS),$(target.$(target).objects:.o=.d))
DEPS += $(HOST_DEPS) $(HOST_TEST_DEPS)

host-libraries: $(foreach target,$(HOST_LIBRARY_TARGETS),$(target.$(target).archive))

host-tests: $(foreach target,$(HOST_TEST_TARGETS),$(target.$(target).output))
	@set -e; $(foreach target,$(HOST_TEST_TARGETS),\
		echo "  TEST    $(target)"; $(target.$(target).output);)

phys-source-object = $(BUILD)/phys/obj/$(call target-key,$(1))/$(basename $(2)).o
define define-phys-source
$(call phys-source-object,$(1),$(2)): PRIVATE_SOURCE := $(2)
$(call phys-source-object,$(1),$(2)): $(2) $(AUTOCONF_H) FORCE
	$$(Q)mkdir -p $$(dir $$@)
	$$(call if_changed,$(if $(filter %.cc,$(2)),phys_cxx_o_cc,$(if $(filter %.c,$(2)),phys_cc_o_c,phys_as_o_S)))
endef
define define-phys-library
target.$(1).objects := $$(foreach src,$$(target.$(1).sources),$$(call phys-source-object,$(1),$$(src)))
target.$(1).archive := $(BUILD)/phys/lib/$(call target-key,$(1)).a
$$(foreach src,$$(target.$(1).sources),$$(eval $$(call define-phys-source,$(1),$$(src))))
$$(target.$(1).archive): PRIVATE_ARCHIVE_OBJECTS := $$(target.$(1).objects)
$$(target.$(1).archive): $$(target.$(1).objects) FORCE
	$$(Q)mkdir -p $$(dir $$@)
	$$(call if_changed,archive)
endef
$(foreach target,$(PHYS_LIBRARY_TARGETS),$(eval $(call define-phys-library,$(target))))
PHYS_DEPS := $(foreach target,$(PHYS_LIBRARY_TARGETS),$(target.$(target).objects:.o=.d))
DEPS += $(PHYS_DEPS)

phys-libraries: $(foreach target,$(PHYS_LIBRARY_TARGETS),$(target.$(target).archive))

kernel-tests: all
	@test "$(CONFIG_SELFTEST)" = y || { \
		echo "kernel-tests requires CONFIG_SELFTEST=y in $(KCONFIG_CONFIG)"; exit 2; }

GEN_INIT_CPIO := $(target.host/gen_init_cpio.output)

INITRAMFS_SOURCE := $(CONFIG_INITRAMFS_SOURCE)

# Encode the selected source in the stamp filename. Changing the source changes
# the dependency without writing anything during Makefile parsing.
INITRAMFS_SOURCE_KEY := $(shell printf '%s' '$(INITRAMFS_SOURCE)' | cksum | cut -d' ' -f1)
INITRAMFS_SRC_STAMP := $(BUILD)/.initramfs-source-$(INITRAMFS_SOURCE_KEY)

$(INITRAMFS_SRC_STAMP):
	@mkdir -p $(dir $@)
	@touch $@

$(INITRAMFS_CPIO): $(INITRAMFS_SOURCE) $(INITRAMFS_SRC_STAMP) \
                   $(GEN_INIT_CPIO) scripts/gen_initramfs.sh \
                   scripts/build/generate-initramfs.sh FORCE
	$(Q)mkdir -p $(dir $@)
	$(call if_changed,initramfs)

$(INITRAMFS_OBJ): PRIVATE_SOURCE := $(INITRAMFS_ASM)
$(INITRAMFS_OBJ): $(INITRAMFS_CPIO) $(INITRAMFS_ASM) FORCE
	$(Q)mkdir -p $(dir $@)
	$(call if_changed,initramfs_obj)

# Single-pass kernel link.  With `-shared -Bsymbolic`, the linker
# emits `.rela.dyn` containing R_RISCV_RELATIVE entries directly into
# the output ELF — no separate gen_reloc pass.
$(VMLUME): $(OBJS) $(foreach target,$(KERNEL_STATIC_TARGETS) $(KERNEL_WHOLE_TARGETS),\
                         $(target.$(target).archive)) \
           $(INITRAMFS_OBJ) $(LINKER_SCRIPT) FORCE
	$(Q)mkdir -p $(dir $@)
	$(call if_changed,link_vmlume)

# Image = raw binary, mirrors Linux's `arch/riscv/boot/Image` (objcopy
# vmlinux to raw bytes, no ELF header — what U-Boot or QEMU's `-bios`
# bare-loading would consume).  Linux always builds both vmlinux and
# Image; LumeOS follows the same convention.
$(IMAGE): $(VMLUME) FORCE
	$(call if_changed,objcopy_bin)

# Materialize one explicit action per target/source pair. This avoids accidental
# object reuse when the same source is built in more than one environment.
define define-kernel-source
$(call source-object,$(1),$(2)): $(2)
	$$(Q)mkdir -p $$(dir $$@)
	$$(call if_changed,$(if $(filter %.cc,$(2)),cxx_o_cc,$(if $(filter %.c,$(2)),cc_o_c,as_o_S)))
endef
$(foreach target,$(KERNEL_SOURCE_TARGETS),$(foreach src,$(target.$(target).sources),\
    $(eval $(call define-kernel-source,$(target),$(src)))))

# Auto-dependency tracking
-include $(DEPS)

# ============================================================
# Run & Debug
# ============================================================
ifeq ($(ARCH),riscv)
QEMU := qemu-system-riscv64
QEMU_MACHINE := -machine virt -smp 4 -m 128M -nographic
QEMU_BIOS := -bios default
else ifeq ($(ARCH),aarch64)
QEMU := qemu-system-aarch64
QEMU_MACHINE := -machine virt -cpu cortex-a53 -m 128M -nographic
QEMU_BIOS := 
else ifeq ($(ARCH),x86_64)
QEMU := qemu-system-x86_64
QEMU_MACHINE := -m 128M -nographic
QEMU_BIOS := 
endif

run: $(VMLUME) $(IMAGE)
	@echo "  QEMU    Running..."
	$(QEMU) $(QEMU_MACHINE) $(QEMU_BIOS) -kernel $(VMLUME)

debug: $(VMLUME) $(IMAGE)
	@echo "  QEMU    Waiting for GDB on :1234..."
	$(QEMU) $(QEMU_MACHINE) $(QEMU_BIOS) -kernel $(VMLUME) -s -S

# ============================================================
# Utilities
# ============================================================
clean:
	rm -rf $(BUILD)

disasm: $(VMLUME)
	@echo "  OBJDUMP $<"
	@$(OBJDUMP) -d -S $(VMLUME) > $(VMLUME).asm
	@echo "  Written to $(VMLUME).asm"

fmt:
	@echo "  FMT     Formatting source files..."
	@find . -name '*.cc' -o -name '*.h' | xargs clang-format -i 2>/dev/null || true

lint:
	@echo "  LINT    Generating compile_commands.json via bear..."
	@bear -- $(MAKE) all
	@echo "  LINT    Running clang-tidy on C++ sources..."
	@clang-tidy -p . $(SRCS_CC) || true

# Print build info (for debugging Makefile issues)
info:
	@echo "LumeOS build configuration"
	@echo "  ARCH              $(ARCH)"
	@echo "  PLATFORM          $(PLATFORM)"
	@echo "  VARIANT           $(BUILD_VARIANT)"
	@echo "  OUTPUT            $(BUILD)"
	@echo "  COMPILER          $(COMPILER_FAMILY): $(CXX)"
	@echo "  TARGET            $(TARGET_TRIPLE)"
	@echo "  GCC_TOOLCHAIN     $(GCC_TOOLCHAIN)"
	@echo "  SYSROOT           $(GCC_SYSROOT)"
	@echo "  RESOURCE HEADERS  $(COMPILER_RESOURCE_INCLUDE)"
	@echo "  LINKER            $(LINKER_FAMILY): $(LD)"
	@echo "  OBJCOPY           $(OBJCOPY)"
	@echo "  INITRAMFS         $(INITRAMFS_SOURCE)"
	@echo "  C++ STANDARD      C++23"
	@echo "  C++ LIBRARY       $(CXX_STDLIB)"
	@echo "  libc++ HEADERS    $(LIBCXX_INCLUDE)"
	@echo "  KTL CONFIG        $(KTL_INCLUDE)"
	@echo "  KERNEL LIBC       $(KERNEL_LIBC_INCLUDE)"
	@echo "  C++ ABI           $(CXX_ABI)"
	@echo "  COMPILER RUNTIME  $(COMPILER_RUNTIME)"
	@echo "  CONFIG            $(KCONFIG_CONFIG)"
	@echo "  BUILD ROOT        $(KERNEL_ROOT)"
	@echo "  TARGETS           $(words $(KERNEL_TARGETS)) selected / $(words $(targets)) registered"

targets:
	@$(foreach target,$(targets),printf '%-24s %-16s %s\n' \
		'$(target)' '$(target.$(target).kind)' '$(target.$(target).deps)';)

target-info:
	@test -n "$(TARGET)" || { echo "usage: make target-info TARGET=<name>"; exit 2; }
	@$(if $(filter $(TARGET),$(targets)),,echo "unknown target: $(TARGET)"; exit 2;)
	@echo "Target:           $(TARGET)"
	@echo "Kind:             $(target.$(TARGET).kind)"
	@echo "Dependencies:     $(target.$(TARGET).deps)"
	@echo "Public deps:      $(target.$(TARGET).public-deps)"
	@echo "Private deps:     $(target.$(TARGET).private-deps)"
	@echo "Link deps:        $(target.$(TARGET).link-deps)"
	@echo "Tool deps:        $(target.$(TARGET).tool-deps)"
	@echo "Generated deps:   $(target.$(TARGET).generated-deps)"
	@echo "Closure:          $(sort $(call target-closure,$(TARGET)))"
	@echo "Public includes:  $(target.$(TARGET).public-includes)"
	@echo "Private includes: $(target.$(TARGET).private-includes)"
	@echo "Sources:          $(target.$(TARGET).sources)"

TARGET_GRAPH := $(BUILD)/targets.dot
graph:
	@mkdir -p $(BUILD)
	@$(file >$(TARGET_GRAPH),digraph lume_build {)
	@$(foreach target,$(targets),$(file >>$(TARGET_GRAPH),  "$(target)" [label="$(target)\n$(target.$(target).kind)"];))
	@$(foreach target,$(targets),$(foreach dep,$(call target-deps,$(target)),\
		$(file >>$(TARGET_GRAPH),  "$(target)" -> "$(dep)";)))
	@$(file >>$(TARGET_GRAPH),})
	@echo "  GRAPH   $(TARGET_GRAPH)"

COMPDB := $(BUILD)/compile_commands.json
COMPDB_INPUT := $(BUILD)/.compile_commands.tsv
compile-command = $(if $(filter %.cc,$(2)),$(CXX) $(CXXFLAGS) \
    $(addprefix -I,$(call target-compile-includes,$(1))) \
    $(foreach dir,$(call target-compile-after-includes,$(1)),-idirafter $(dir)) \
    $(addprefix -D,$(call target-compile-defines,$(1))) $(target.$(1).cxxflags),\
    $(CC) $(if $(filter %.c,$(2)),$(CFLAGS_LIBC) \
    $(addprefix -I,$(call target-compile-includes,$(1))) \
    $(foreach dir,$(call target-compile-after-includes,$(1)),-idirafter $(dir)) \
    $(addprefix -D,$(call target-compile-defines,$(1))) $(target.$(1).cflags),\
    $(ASFLAGS) $(addprefix -I,$(call target-compile-includes,$(1))) \
    $(foreach dir,$(call target-compile-after-includes,$(1)),-idirafter $(dir)) \
    $(addprefix -D,$(call target-compile-defines,$(1))) \
    $(target.$(1).asflags))) -c $(2) -o $(call source-object,$(1),$(2))

$(BUILD):
	@mkdir -p $@

$(COMPDB_INPUT): FORCE | $(BUILD)
	@$(file >$(COMPDB_INPUT))
	@$(foreach target,$(KERNEL_SOURCE_TARGETS),$(foreach src,$(target.$(target).sources),\
		$(file >>$(COMPDB_INPUT),$(src)	$(call source-object,$(target),$(src))	$(call compile-command,$(target),$(src)))))

compile_commands: $(COMPDB_INPUT)
	@$(PYTHON) scripts/build/write-compdb.py $(COMPDB_INPUT) $(COMPDB)
	@echo "  COMPDB  $(COMPDB)"

check-toolchain:
	@command -v $(firstword $(CC)) >/dev/null || { echo "missing C compiler: $(CC)"; exit 1; }
	@command -v $(firstword $(CXX)) >/dev/null || { echo "missing C++ compiler: $(CXX)"; exit 1; }
	@command -v $(firstword $(LD)) >/dev/null || { echo "missing linker: $(LD)"; exit 1; }
	@command -v $(firstword $(OBJCOPY)) >/dev/null || { echo "missing objcopy: $(OBJCOPY)"; exit 1; }
	@$(CXX) $(TOOLCHAIN_CFLAGS) $(TOOLCHAIN_CXXFLAGS) -std=c++23 \
		-ffreestanding -fno-exceptions -fno-rtti \
		-Iinclude -I$(KTL_INCLUDE) -I$(KERNEL_LIBC_INCLUDE) \
		-idirafter $(KTL_AFTER_INCLUDE) -idirafter $(KERNEL_LIBC_AFTER_INCLUDE) \
		-fsyntax-only scripts/build/probes/libcxx.cc
	@$(CXX) $(TOOLCHAIN_CFLAGS) $(TOOLCHAIN_CXXFLAGS) -std=c++23 \
		-ffreestanding -fno-exceptions -fno-rtti \
		-Iinclude -I$(KTL_INCLUDE) -I$(KERNEL_LIBC_INCLUDE) \
		-idirafter $(KTL_AFTER_INCLUDE) -idirafter $(KERNEL_LIBC_AFTER_INCLUDE) \
		-fsyntax-only scripts/build/probes/libc_headers.cc
	@$(CC) $(TOOLCHAIN_CFLAGS) -std=gnu23 -ffreestanding \
		-Iinclude -I$(KERNEL_LIBC_INCLUDE) \
		-idirafter $(KERNEL_LIBC_AFTER_INCLUDE) \
		-fsyntax-only scripts/build/probes/libc_headers.c
	@echo "Toolchain OK: $$($(CXX) --version | head -n 1)"

TOOLCHAIN_REPORT := $(BUILD)/toolchain.report
$(TOOLCHAIN_REPORT): FORCE scripts/build/probe-toolchain.sh
	$(Q)mkdir -p $(dir $@)
	$(call if_changed,toolchain_probe)

toolchain-probe: $(TOOLCHAIN_REPORT)
	@cat $(TOOLCHAIN_REPORT)

check-toolchain: $(TOOLCHAIN_REPORT)

help:
	@echo "LumeOS build targets:"
	@echo "  all              Build vmlume.elf and vmlume.bin (default)"
	@echo "  run              Run the selected image in QEMU"
	@echo "  debug            Run QEMU with a GDB server on :1234"
	@echo "  disasm           Generate an interleaved source disassembly"
	@echo "  info             Show the effective build configuration"
	@echo "  check-toolchain  Validate compiler, linker, and C++23 support"
	@echo "  check-image      Validate ELF architecture, symbols, segments, and relocations"
	@echo "  targets          List registered build targets and dependencies"
	@echo "  target-info      Explain TARGET=<name>"
	@echo "  compile_commands Generate an O= scoped compilation database"
	@echo "  graph            Write the target dependency graph as DOT"
	@echo "  host-libraries   Build registered native static libraries"
	@echo "  host-tests       Build and run registered native tests"
	@echo "  phys-libraries   Build early physical-environment libraries"
	@echo "  kernel-tests     Build the test-enabled kernel (CONFIG_SELFTEST=y)"
	@echo "  toolchain-probe  Probe and cache required compiler capabilities"
	@echo "  clean            Remove only the selected O= output tree"
	@echo ""
	@echo "Common options:"
	@echo "  O=<dir>                 Output directory (default: build)"
	@echo "  LLVM=1                  Use Clang with GNU ld"
	@echo "  LLVM=1 LD_TYPE=lld      Use Clang with LLD"
	@echo "  LLVM_VERSION=<version>  Versioned LLVM tools (default: 20)"
	@echo "  CROSS_COMPILE=<prefix>  Override GNU cross-tool prefix"
	@echo "  GCC_TOOLCHAIN=<dir>     GCC installation used by Clang for target headers/builtins"
	@echo "  V=1                     Print full command lines"
	@echo "  CONFIG_INITRAMFS_SOURCE=<path>  Select initramfs input"
