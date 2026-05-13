# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026 Richard Qin
#
# scripts/Kconfig.mk — Kernel Configuration Infrastructure
#
# This file is the heart of the LumeOS build-time configuration system.
# It mirrors the role of Linux's Kconfig + auto.conf pipeline:
#
#   1.  Developer edits  `.config`  (or copies from arch/$(ARCH)/defconfig)
#   2.  This file reads `.config`, applies defaults for anything missing,
#       validates constraints, and exports two things:
#       a) KCPPFLAGS — a set of -DCONFIG_xxx=value flags for the compiler
#       b) $(BUILD)/generated/autoconf.h — the same values as C #defines
#
# Design Principles (matching Linux conventions):
#   - Every CONFIG_ symbol has a default defined HERE, so a bare `make`
#     with no .config still builds a sane kernel.
#   - Boolean options use 'y' / 'n'.  Numeric options are plain integers.
#   - The generated autoconf.h uses the exact same names so that
#     `#ifdef CONFIG_DEBUG` works identically in Makefile and C.
# ======================================================================

# ------------------------------------------------------------------
# §1  Read user configuration (if it exists)
# ------------------------------------------------------------------
-include .config

# ------------------------------------------------------------------
# §2  Provide defaults for every CONFIG_ symbol
#
#     ?= means "set only if not already set (by .config or CLI)".
#     This is the single source of truth for default values.
# ------------------------------------------------------------------

# --- Platform -------------------------------------------------------
CONFIG_ARCH             ?= riscv

# --- CPU / SMP ------------------------------------------------------
CONFIG_NR_CPUS          ?= 8

# --- Scheduler ------------------------------------------------------
CONFIG_HZ               ?= 100
CONFIG_NR_PRIORITIES    ?= 32

# --- Memory Management ----------------------------------------------
CONFIG_PAGE_SIZE        ?= 4096
CONFIG_MAX_ORDER        ?= 11
CONFIG_KERNEL_STACK_SIZE ?= 8192

# --- Security / Hardening -------------------------------------------
CONFIG_KASLR            ?= y
CONFIG_KASLR_POLICY_ID  ?= 0
CONFIG_KASLR_LOG_LEVEL  ?= 1
CONFIG_STACK_CANARY     ?= y
CONFIG_KERNEL_COMPRESSED ?= y

# --- Debug -----------------------------------------------------------
CONFIG_DEBUG            ?= y
CONFIG_DEBUG_LOCKS      ?= y
CONFIG_SELFTEST         ?= y
CONFIG_KLOG             ?= y

# ------------------------------------------------------------------
# §3  Derived constants (computed from CONFIG_ symbols)
#
#     These follow Linux's pattern of expressing dependent values
#     so that C code never has to do its own derivation at runtime.
# ------------------------------------------------------------------

# Default priority = middle of the range
CONFIG_DEFAULT_PRIORITY  = $(shell echo $$(( $(CONFIG_NR_PRIORITIES) / 2 )))

# Idle priority = lowest = NR_PRIORITIES - 1
CONFIG_IDLE_PRIORITY     = $(shell echo $$(( $(CONFIG_NR_PRIORITIES) - 1 )))

# Default time slice in ticks: 100ms worth of ticks
# (same as Linux CFS's sysctl_sched_min_granularity default)
CONFIG_DEFAULT_TIMESLICE = $(shell echo $$(( $(CONFIG_HZ) / 10 )))

# ------------------------------------------------------------------
# §4  Export to C/C++ via -D flags
#
#     KCPPFLAGS is appended to CFLAGS/CXXFLAGS in the main Makefile.
#     Every CONFIG_xxx=<value> becomes  -DCONFIG_xxx=<value>.
#     Boolean 'y' options become -DCONFIG_xxx=1.
# ------------------------------------------------------------------
KCPPFLAGS :=

# Numeric options — pass through as-is
KCPPFLAGS += -DCONFIG_NR_CPUS=$(CONFIG_NR_CPUS)
KCPPFLAGS += -DCONFIG_HZ=$(CONFIG_HZ)
KCPPFLAGS += -DCONFIG_NR_PRIORITIES=$(CONFIG_NR_PRIORITIES)
KCPPFLAGS += -DCONFIG_DEFAULT_PRIORITY=$(CONFIG_DEFAULT_PRIORITY)
KCPPFLAGS += -DCONFIG_IDLE_PRIORITY=$(CONFIG_IDLE_PRIORITY)
KCPPFLAGS += -DCONFIG_DEFAULT_TIMESLICE=$(CONFIG_DEFAULT_TIMESLICE)
KCPPFLAGS += -DCONFIG_PAGE_SIZE=$(CONFIG_PAGE_SIZE)
KCPPFLAGS += -DCONFIG_MAX_ORDER=$(CONFIG_MAX_ORDER)
KCPPFLAGS += -DCONFIG_KERNEL_STACK_SIZE=$(CONFIG_KERNEL_STACK_SIZE)

# Boolean options — translate 'y' → 1
ifeq ($(CONFIG_KASLR),y)
KCPPFLAGS += -DCONFIG_KASLR=1
endif
KCPPFLAGS += -DCONFIG_KASLR_POLICY_ID=$(CONFIG_KASLR_POLICY_ID)
KCPPFLAGS += -DCONFIG_KASLR_LOG_LEVEL=$(CONFIG_KASLR_LOG_LEVEL)
ifeq ($(CONFIG_STACK_CANARY),y)
KCPPFLAGS += -DCONFIG_STACK_CANARY=1
endif
ifeq ($(CONFIG_DEBUG),y)
KCPPFLAGS += -DCONFIG_DEBUG=1
endif
ifeq ($(CONFIG_DEBUG_LOCKS),y)
KCPPFLAGS += -DCONFIG_DEBUG_LOCKS=1
endif
ifeq ($(CONFIG_SELFTEST),y)
KCPPFLAGS += -DCONFIG_SELFTEST=1
endif
ifeq ($(CONFIG_KLOG),y)
KCPPFLAGS += -DCONFIG_KLOG=1
endif
ifeq ($(CONFIG_KERNEL_COMPRESSED),y)
KCPPFLAGS += -DCONFIG_KERNEL_COMPRESSED=1
endif

# ------------------------------------------------------------------
# §5  Generate autoconf.h  (analogous to Linux's include/generated/autoconf.h)
#
#     This header is auto-generated at build time so that C code can
#     #include <generated/autoconf.h> and see CONFIG_xxx macros without
#     relying on -D flags alone.  This is important for IDE integration.
# ------------------------------------------------------------------
AUTOCONF_H := $(BUILD)/generated/autoconf.h

define generate-autoconf
	@mkdir -p $(dir $(AUTOCONF_H))
	@echo "  GEN     $(AUTOCONF_H)"
	@echo "/* AUTO-GENERATED — DO NOT EDIT */"            >  $(AUTOCONF_H)
	@echo "/* Generated by scripts/Kconfig.mk */"          >> $(AUTOCONF_H)
	@echo "#pragma once"                                    >> $(AUTOCONF_H)
	@echo ""                                                >> $(AUTOCONF_H)
	@echo "/* Platform */"                                  >> $(AUTOCONF_H)
	@echo "#define CONFIG_NR_CPUS          $(CONFIG_NR_CPUS)"           >> $(AUTOCONF_H)
	@echo ""                                                >> $(AUTOCONF_H)
	@echo "/* Scheduler */"                                 >> $(AUTOCONF_H)
	@echo "#define CONFIG_HZ               $(CONFIG_HZ)"               >> $(AUTOCONF_H)
	@echo "#define CONFIG_NR_PRIORITIES    $(CONFIG_NR_PRIORITIES)"     >> $(AUTOCONF_H)
	@echo "#define CONFIG_DEFAULT_PRIORITY $(CONFIG_DEFAULT_PRIORITY)"  >> $(AUTOCONF_H)
	@echo "#define CONFIG_IDLE_PRIORITY    $(CONFIG_IDLE_PRIORITY)"     >> $(AUTOCONF_H)
	@echo "#define CONFIG_DEFAULT_TIMESLICE $(CONFIG_DEFAULT_TIMESLICE)" >> $(AUTOCONF_H)
	@echo ""                                                >> $(AUTOCONF_H)
	@echo "/* Memory Management */"                         >> $(AUTOCONF_H)
	@echo "#define CONFIG_PAGE_SIZE        $(CONFIG_PAGE_SIZE)"         >> $(AUTOCONF_H)
	@echo "#define CONFIG_MAX_ORDER        $(CONFIG_MAX_ORDER)"         >> $(AUTOCONF_H)
	@echo "#define CONFIG_KERNEL_STACK_SIZE $(CONFIG_KERNEL_STACK_SIZE)" >> $(AUTOCONF_H)
	@echo ""                                                >> $(AUTOCONF_H)
	@echo "/* Security */"                                  >> $(AUTOCONF_H)
	$(if $(filter y,$(CONFIG_KASLR)),       @echo "#define CONFIG_KASLR           1"  >> $(AUTOCONF_H))
	@echo "#define CONFIG_KASLR_POLICY_ID  $(CONFIG_KASLR_POLICY_ID)"  >> $(AUTOCONF_H)
	@echo "#define CONFIG_KASLR_LOG_LEVEL  $(CONFIG_KASLR_LOG_LEVEL)"  >> $(AUTOCONF_H)
	$(if $(filter y,$(CONFIG_STACK_CANARY)), @echo "#define CONFIG_STACK_CANARY    1"  >> $(AUTOCONF_H))
	@echo ""                                                >> $(AUTOCONF_H)
	@echo "/* Debug */"                                     >> $(AUTOCONF_H)
	$(if $(filter y,$(CONFIG_DEBUG)),        @echo "#define CONFIG_DEBUG           1"  >> $(AUTOCONF_H))
	$(if $(filter y,$(CONFIG_DEBUG_LOCKS)),  @echo "#define CONFIG_DEBUG_LOCKS     1"  >> $(AUTOCONF_H))
	$(if $(filter y,$(CONFIG_SELFTEST)),     @echo "#define CONFIG_SELFTEST        1"  >> $(AUTOCONF_H))
	$(if $(filter y,$(CONFIG_KLOG)),         @echo "#define CONFIG_KLOG            1"  >> $(AUTOCONF_H))
	$(if $(filter y,$(CONFIG_KERNEL_COMPRESSED)), @echo "#define CONFIG_KERNEL_COMPRESSED 1"  >> $(AUTOCONF_H))
endef

# ------------------------------------------------------------------
# §6  Utility targets
# ------------------------------------------------------------------

# 'make defconfig' — reset .config to the arch default
.PHONY: defconfig savedefconfig showconfig

defconfig:
	@echo "  DEFCFG  arch/$(CONFIG_ARCH)/defconfig → .config"
	@cp arch/$(CONFIG_ARCH)/defconfig .config

# 'make savedefconfig' — save current effective config
savedefconfig:
	@echo "  SAVE    .config"
	@echo "# LumeOS Kernel Configuration (saved $$(date +%Y-%m-%d))" > .config
	@echo "CONFIG_ARCH             = $(CONFIG_ARCH)"             >> .config
	@echo "CONFIG_NR_CPUS          = $(CONFIG_NR_CPUS)"          >> .config
	@echo "CONFIG_HZ               = $(CONFIG_HZ)"               >> .config
	@echo "CONFIG_NR_PRIORITIES    = $(CONFIG_NR_PRIORITIES)"     >> .config
	@echo "CONFIG_PAGE_SIZE        = $(CONFIG_PAGE_SIZE)"         >> .config
	@echo "CONFIG_MAX_ORDER        = $(CONFIG_MAX_ORDER)"         >> .config
	@echo "CONFIG_KERNEL_STACK_SIZE = $(CONFIG_KERNEL_STACK_SIZE)" >> .config
	@echo "CONFIG_KASLR            = $(CONFIG_KASLR)"             >> .config
	@echo "CONFIG_KASLR_POLICY_ID  = $(CONFIG_KASLR_POLICY_ID)"   >> .config
	@echo "CONFIG_KASLR_LOG_LEVEL  = $(CONFIG_KASLR_LOG_LEVEL)"   >> .config
	@echo "CONFIG_STACK_CANARY     = $(CONFIG_STACK_CANARY)"      >> .config
	@echo "CONFIG_DEBUG            = $(CONFIG_DEBUG)"              >> .config
	@echo "CONFIG_DEBUG_LOCKS      = $(CONFIG_DEBUG_LOCKS)"        >> .config
	@echo "CONFIG_SELFTEST         = $(CONFIG_SELFTEST)"           >> .config
	@echo "CONFIG_KLOG             = $(CONFIG_KLOG)"               >> .config
	@echo "CONFIG_KERNEL_COMPRESSED = $(CONFIG_KERNEL_COMPRESSED)" >> .config

# 'make showconfig' — print effective configuration
showconfig:
	@echo "========================================"
	@echo "  LumeOS Effective Configuration"
	@echo "========================================"
	@echo "  ARCH              = $(CONFIG_ARCH)"
	@echo "  NR_CPUS           = $(CONFIG_NR_CPUS)"
	@echo "  HZ                = $(CONFIG_HZ)"
	@echo "  NR_PRIORITIES     = $(CONFIG_NR_PRIORITIES)"
	@echo "  DEFAULT_PRIORITY  = $(CONFIG_DEFAULT_PRIORITY)"
	@echo "  IDLE_PRIORITY     = $(CONFIG_IDLE_PRIORITY)"
	@echo "  DEFAULT_TIMESLICE = $(CONFIG_DEFAULT_TIMESLICE)"
	@echo "  PAGE_SIZE         = $(CONFIG_PAGE_SIZE)"
	@echo "  MAX_ORDER         = $(CONFIG_MAX_ORDER)"
	@echo "  KERNEL_STACK_SIZE = $(CONFIG_KERNEL_STACK_SIZE)"
	@echo "  KASLR             = $(CONFIG_KASLR)"
	@echo "  KASLR_POLICY_ID   = $(CONFIG_KASLR_POLICY_ID)"
	@echo "  KASLR_LOG_LEVEL   = $(CONFIG_KASLR_LOG_LEVEL)"
	@echo "  STACK_CANARY      = $(CONFIG_STACK_CANARY)"
	@echo "  DEBUG             = $(CONFIG_DEBUG)"
	@echo "  DEBUG_LOCKS       = $(CONFIG_DEBUG_LOCKS)"
	@echo "  SELFTEST          = $(CONFIG_SELFTEST)"
	@echo "  KLOG              = $(CONFIG_KLOG)"
	@echo "  KERNEL_COMPRESSED = $(CONFIG_KERNEL_COMPRESSED)"
	@echo "========================================"
