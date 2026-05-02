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

# Load Kconfig infrastructure (reads .config, sets KCPPFLAGS)
include scripts/Kconfig.mk

ARCH    ?= $(CONFIG_ARCH)
TARGET  := $(BUILD)/kernel.elf
IMAGE   := $(BUILD)/kernel.bin
LDS_SRC := arch/$(ARCH)/kernel/lumeos.lds.S
LINKER_SCRIPT := $(BUILD)/lumeos.lds

# ============================================================
# Toolchain Detection
# ============================================================
ifndef TOOLCHAIN_PREFIX
ifeq ($(ARCH),riscv)
    TOOLCHAIN_PREFIX := $(shell \
        if command -v riscv64-linux-gnu-gcc >/dev/null 2>&1; then \
            echo riscv64-linux-gnu-; \
        elif command -v riscv64-unknown-linux-gnu-gcc >/dev/null 2>&1; then \
            echo riscv64-unknown-linux-gnu-; \
        elif command -v riscv64-unknown-elf-gcc >/dev/null 2>&1; then \
            echo riscv64-unknown-elf-; \
        else \
            echo riscv64-linux-gnu-; \
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
# include fs/module.mk          # Phase 3
include drivers/module.mk
include fdt/module.mk
include lib/module.mk
include test/module.mk

# Compiler flags (defined AFTER includes so INCLUDES is complete)
CFLAGS   := $(WARNINGS) -O2 -g \
            -ffreestanding -nostdlib \
            -mcmodel=medany \
            -MMD -MP \
            $(KCPPFLAGS) \
            $(INCLUDES) \
            -I$(BUILD)/generated

# C flags for musl libc sources: add libc-shim headers first
CFLAGS_LIBC := $(CFLAGS) -Iinclude/libc-shim \
               -Wno-parentheses -Wno-sign-compare

CXXFLAGS := $(CFLAGS) \
            -std=c++17 \
            -fno-exceptions -fno-rtti -fno-use-cxa-atexit \
            -fno-threadsafe-statics

ASFLAGS  := $(CFLAGS)

LDFLAGS  := -nostdlib -static

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

all: $(IMAGE)

# Generate autoconf.h before any compilation
$(AUTOCONF_H): scripts/Kconfig.mk $(wildcard .config)
	$(generate-autoconf)

# All objects depend on autoconf.h
$(OBJS): $(AUTOCONF_H)

# Preprocess linker script template (.lds.S → .lds)
$(LINKER_SCRIPT): $(LDS_SRC) include/lume/lumeos.lds.h
	@echo "  LDS     $@"
	@mkdir -p $(dir $@)
	@$(CC) -E -P -x c $(INCLUDES) $< -o $@

# Link kernel ELF
$(TARGET): $(OBJS) $(LINKER_SCRIPT)
	@echo "  LD      $@"
	@mkdir -p $(dir $@)
	@$(LD) $(LDFLAGS) -T $(LINKER_SCRIPT) -o $@ $(OBJS)
	@$(TOOLCHAIN_PREFIX)size $@

# Generate flat binary for QEMU loading
$(IMAGE): $(TARGET)
	@echo "  OBJCOPY $@"
	@$(OBJCOPY) -O binary $< $@

# Compile C++ sources
$(BUILD)/%.o: %.cc
	@echo "  CXX     $<"
	@mkdir -p $(dir $@)
	@$(CXX) $(CXXFLAGS) -c $< -o $@

# Compile C sources (musl libc)
$(BUILD)/%.o: %.c
	@echo "  CC      $<"
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS_LIBC) -c $< -o $@

# Assemble (preprocessed .S)
$(BUILD)/%.o: %.S
	@echo "  AS      $<"
	@mkdir -p $(dir $@)
	@$(CC) $(ASFLAGS) -c $< -o $@

# Assemble (raw .s, no preprocessing)
$(BUILD)/%.o: %.s
	@echo "  AS      $<"
	@mkdir -p $(dir $@)
	@$(CC) $(ASFLAGS) -c $< -o $@

# Auto-dependency tracking
-include $(DEPS)

# ============================================================
# Run & Debug
# ============================================================
ifeq ($(ARCH),riscv)
QEMU := qemu-system-riscv64
QEMU_MACHINE := -machine virt -m 128M -nographic
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

run: $(IMAGE)
	@echo "  QEMU    Running..."
	$(QEMU) $(QEMU_MACHINE) $(QEMU_BIOS) -kernel $(IMAGE)

debug: $(IMAGE)
	@echo "  QEMU    Waiting for GDB on :1234..."
	$(QEMU) $(QEMU_MACHINE) $(QEMU_BIOS) -kernel $(IMAGE) -s -S

# ============================================================
# Utilities
# ============================================================
clean:
	rm -rf $(BUILD)

disasm: $(TARGET)
	@echo "  OBJDUMP $<"
	@$(OBJDUMP) -d -S $(TARGET) > $(TARGET).asm
	@echo "  Written to $(TARGET).asm"

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
