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
BUILD   := build

# Make sure `make` with no arguments builds the kernel image, not the
# first rule encountered during makefile parsing.  scripts/Kconfig.mk
# (included next) defines `defconfig:` at the top of its rule list,
# which would otherwise become the default goal and silently overwrite
# .config from arch/$(ARCH)/defconfig.
.DEFAULT_GOAL := all

# Load Kbuild helpers (Q, $(call cmd,...), quiet_cmd_* / cmd_* templates,
# kbuild-objs translator).  Must come before Kconfig.mk so subsequent
# rules can use $(call cmd,...) immediately.
include scripts/Kbuild.include

# Load Kconfig infrastructure (reads .config, sets KCPPFLAGS)
include scripts/Kconfig.mk

ARCH    ?= $(CONFIG_ARCH)

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
USR_INIT_ELF    := $(BUILD)/usr/init
# Relocations: linker emits .rela.dyn under -shared -Bsymbolic; boot
# code in arch/riscv/mm/init.cc::relocate_kernel walks it at startup.
LDS_SRC := arch/$(ARCH)/kernel/lumeos.lds.S
LINKER_SCRIPT := $(BUILD)/lumeos.lds
PYTHON ?= python3

# ============================================================
# Toolchain Detection
# ============================================================
ifndef TOOLCHAIN_PREFIX
ifeq ($(ARCH),riscv)
    # Prefer the linux-gnu toolchain — it supports -shared / -pie which
    # are required to emit .rela.dyn (Linux RISC-V kernel uses the same).
    # The bare-metal `riscv64-unknown-elf-` is kept only as a last-resort
    # fallback; with that one, `-shared` fails ("not supported") and the
    # kernel can't relocate at runtime.
    TOOLCHAIN_PREFIX := $(shell \
        if command -v riscv64-unknown-linux-gnu-g++ >/dev/null 2>&1; then \
            echo riscv64-unknown-linux-gnu-; \
        elif command -v riscv64-linux-gnu-g++ >/dev/null 2>&1; then \
            echo riscv64-linux-gnu-; \
        else \
            echo riscv64-unknown-linux-gnu-; \
        fi)
else ifeq ($(ARCH),aarch64)
    TOOLCHAIN_PREFIX := aarch64-linux-gnu-
else ifeq ($(ARCH),x86_64)
    TOOLCHAIN_PREFIX := x86_64-linux-gnu-
endif
endif

CC      := $(TOOLCHAIN_PREFIX)gcc
CXX     := $(TOOLCHAIN_PREFIX)g++
LD      := $(TOOLCHAIN_PREFIX)ld
OBJCOPY := $(TOOLCHAIN_PREFIX)objcopy
OBJDUMP := $(TOOLCHAIN_PREFIX)objdump
# Objcopy output formats for binary-to-ELF relocation blob
OBJCOPY_ELF_riscv := elf64-littleriscv
OBJCOPY_ELF_aarch64 := elf64-littleaarch64
OBJCOPY_ELF_x86_64 := elf64-x86-64
OBJCOPY_ELF := $(OBJCOPY_ELF_$(ARCH))

OBJCOPY_BINARCH_riscv := riscv
OBJCOPY_BINARCH_aarch64 := aarch64
OBJCOPY_BINARCH_x86_64 := i386:x86-64
OBJCOPY_BINARCH := $(OBJCOPY_BINARCH_$(ARCH))

# Common flags (base, before module includes)
WARNINGS := -Wall -Wextra -Wno-unused-parameter
INCLUDES := -Iinclude -I.

# ============================================================
# Source Collection (Non-Recursive Module Fragments)
# Module .mk files may append to SRCS_CC, SRCS_S, INCLUDES
# ============================================================
SRCS_CC :=
SRCS_C  :=
SRCS_S  :=
SRCS_s  :=

-include arch/$(ARCH)/module.mk
include kernel/module.mk
include mm/module.mk
include fs/module.mk
include drivers/base/module.mk
include drivers/module.mk
include drivers/tty/module.mk
include fdt/module.mk
include lib/module.mk
include test/module.mk

# Compiler flags (defined AFTER includes so INCLUDES is complete)
CFLAGS   := $(WARNINGS) -O2 -g \
            -ffreestanding -nostdlib \
            -mcmodel=medany \
            -fPIE \
            -MMD -MP \
            $(KCPPFLAGS) \
            $(INCLUDES) \
            -I$(BUILD)/generated

# -fPIE makes the compiler emit position-independent code (PC-relative
# addressing + GOT for globals), which is what `-shared` linking expects.
# Mirrors Linux's arch/riscv/Makefile under CONFIG_RELOCATABLE=y:
#   KBUILD_CFLAGS += -fPIE

# C flags for musl libc sources: add libc-shim headers first
CFLAGS_LIBC := $(CFLAGS) -Iinclude/libc-shim \
               -Wno-parentheses -Wno-sign-compare

CXXFLAGS := $(CFLAGS) \
            -std=c++17 \
            -fno-exceptions -fno-rtti -fno-use-cxa-atexit \
            -fno-threadsafe-statics

# Assembler flags MUST NOT include -fPIE.
# Linux's arch/riscv/Makefile adds -fPIE only to KBUILD_CFLAGS, NOT to
# KBUILD_AFLAGS: with -fPIE the gcc driver puts the assembler in PIC
# mode, where the `la` macro silently expands to a GOT-indirect load
# (`auipc + ld` reading a slot that holds the link-time VA).  In our
# pre-MMU boot path that VA is unmapped, so any `la sym, sym` faults
# and reboots into a `_start` loop.  Stripping -fPIE makes `la` emit
# direct PC-relative addressing (`auipc + addi`) which works at PA.
ASFLAGS  := $(filter-out -fPIE,$(CFLAGS))

# Link as a position-independent shared object so the linker emits
# `.rela.dyn` with R_RISCV_RELATIVE entries that the boot stub applies
# at load time.  Mirrors Linux's arch/riscv/Makefile §10:
#   LDFLAGS_vmlinux += -shared -Bsymbolic -z notext
# `-Bsymbolic` resolves all global refs at link time (no dynamic
# resolution); `-z notext` lets us keep relocations in code pages.
LDFLAGS  := -nostdlib -shared -Bsymbolic -z notext -z norelro --no-dynamic-linker

# ============================================================
# Object File Computation
# ============================================================
OBJS := $(patsubst %.cc,$(BUILD)/%.o,$(SRCS_CC)) \
        $(patsubst %.c,$(BUILD)/%.o,$(SRCS_C)) \
        $(patsubst %.S,$(BUILD)/%.o,$(SRCS_S)) \
        $(patsubst %.s,$(BUILD)/%.o,$(SRCS_s))

DEPS := $(OBJS:.o=.d)

# ============================================================
# Build Rules
# ============================================================
.PHONY: all clean run debug fmt disasm defconfig savedefconfig showconfig

all: $(VMLUME) $(IMAGE)

# Generate autoconf.h before any compilation
$(AUTOCONF_H): scripts/Kconfig.mk $(wildcard .config)
	$(generate-autoconf)

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
$(ASM_OFFSETS_S): $(ASM_OFFSETS_C) $(AUTOCONF_H)
	@echo "  CC -S   $<"
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS_LIBC) -S $< -o $@

# Rewrite ->NAME markers into #define lines.  Header guard hand-rolled
# at the top, sed body in the middle, closing #endif at the bottom.
$(ASM_OFFSETS_H): $(ASM_OFFSETS_S) $(ASM_OFFSETS_SED)
	@echo "  GEN     $@"
	@mkdir -p $(dir $@)
	@(echo "/* AUTO-GENERATED — DO NOT EDIT */"; \
	  echo "/* Generated from $(ASM_OFFSETS_C) by scripts/extract-asm-offsets.sed */"; \
	  echo "#ifndef _LUME_GENERATED_ASM_OFFSETS_H"; \
	  echo "#define _LUME_GENERATED_ASM_OFFSETS_H"; \
	  echo ""; \
	  sed -n -f $(ASM_OFFSETS_SED) $<; \
	  echo ""; \
	  echo "#endif /* _LUME_GENERATED_ASM_OFFSETS_H */") > $@

# All objects depend on autoconf.h and asm-offsets.h
$(OBJS): $(AUTOCONF_H) $(ASM_OFFSETS_H)

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
$(LINKER_SCRIPT): $(LDS_SRC) include/lume/lumeos.lds.h
	@echo "  LDS     $@"
	@mkdir -p $(dir $@)
	@$(CC) -E -P -x c $(INCLUDES) $< -o $@

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

# Host compiler — distinct from $(CC), which may be the cross compiler.
HOSTCC      ?= cc
HOSTCFLAGS  ?= -O2 -Wall

# Output path matches Linux convention (usr/gen_init_cpio) so the
# verbatim copy of scripts/gen_initramfs.sh from Linux finds it via its
# hardcoded relative path when invoked from the kernel source root.
GEN_INIT_CPIO := usr/gen_init_cpio

$(GEN_INIT_CPIO): usr/gen_init_cpio.c
	@echo "  HOSTCC  $@"
	@$(HOSTCC) $(HOSTCFLAGS) -o $@ $<

INITRAMFS_SOURCE := $(CONFIG_INITRAMFS_SOURCE)

# Record the chosen source so changing CONFIG_INITRAMFS_SOURCE on the
# command line forces a rebuild — without this, `make` only compares
# file mtimes and would happily reuse a cpio packed from a different
# source as long as that other source isn't newer.  Evaluated at
# Makefile parse time so the dep edge is correct from the first rule
# check.  Mirrors the idea behind Linux's $(call if_changed,...).
INITRAMFS_SRC_STAMP := $(BUILD)/.initramfs_src.stamp
$(shell mkdir -p $(BUILD) 2>/dev/null; \
        prev=$$([ -f "$(INITRAMFS_SRC_STAMP)" ] && cat "$(INITRAMFS_SRC_STAMP)" || echo); \
        if [ "$$prev" != "$(INITRAMFS_SOURCE)" ]; then \
            printf '%s\n' "$(INITRAMFS_SOURCE)" > "$(INITRAMFS_SRC_STAMP)"; \
        fi)

$(INITRAMFS_CPIO): $(INITRAMFS_SOURCE) $(INITRAMFS_SRC_STAMP) \
                   $(GEN_INIT_CPIO) scripts/gen_initramfs.sh
	@echo "  INITRAMFS $(INITRAMFS_SOURCE)"
	@mkdir -p $(dir $@)
	@./scripts/gen_initramfs.sh -o $@ \
		-u $(CONFIG_INITRAMFS_ROOT_UID) \
		-g $(CONFIG_INITRAMFS_ROOT_GID) \
		$(INITRAMFS_SOURCE)

$(INITRAMFS_OBJ): $(INITRAMFS_CPIO)
	@echo "  OBJCOPY $@ (initramfs)"
	@$(OBJCOPY) -I binary -O $(OBJCOPY_ELF) -B $(OBJCOPY_BINARCH) \
		--rename-section .data=.init.ramfs,alloc,load,readonly,data,contents \
		$< $@

# Single-pass kernel link.  With `-shared -Bsymbolic`, the linker
# emits `.rela.dyn` containing R_RISCV_RELATIVE entries directly into
# the output ELF — no separate gen_reloc pass.
$(VMLUME): $(OBJS) $(INITRAMFS_OBJ) $(LINKER_SCRIPT)
	@echo "  LD      $@"
	@mkdir -p $(dir $@)
	@$(LD) $(LDFLAGS) -T $(LINKER_SCRIPT) -o $@ $(OBJS) $(INITRAMFS_OBJ)
	@$(TOOLCHAIN_PREFIX)size $@

# Image = raw binary, mirrors Linux's `arch/riscv/boot/Image` (objcopy
# vmlinux to raw bytes, no ELF header — what U-Boot or QEMU's `-bios`
# bare-loading would consume).  Linux always builds both vmlinux and
# Image; LumeOS follows the same convention.
$(IMAGE): $(VMLUME)
	@echo "  OBJCOPY $@"
	@$(OBJCOPY) -O binary $< $@

# Compile C++ sources.  Recipe goes through $(call cmd,...) so that
# `make V=1` echoes the full command line.  $(Q) prefix on mkdir keeps
# the directory-creation step silent in quiet mode but visible at V=1.
$(BUILD)/%.o: %.cc
	$(Q)mkdir -p $(dir $@)
	$(call cmd,cxx_o_cc)

$(BUILD)/%.o: %.c
	$(Q)mkdir -p $(dir $@)
	$(call cmd,cc_o_c)

$(BUILD)/%.o: %.S
	$(Q)mkdir -p $(dir $@)
	$(call cmd,as_o_S)

$(BUILD)/%.o: %.s
	$(Q)mkdir -p $(dir $@)
	$(call cmd,as_o_S)

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
	@echo "TOOLCHAIN_PREFIX = $(TOOLCHAIN_PREFIX)"
	@echo "SRCS_CC = $(SRCS_CC)"
	@echo "SRCS_S  = $(SRCS_S)"
	@echo "OBJS    = $(OBJS)"
	@echo "KCPPFLAGS = $(KCPPFLAGS)"
