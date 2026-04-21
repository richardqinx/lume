# lib/module.mk
SRCS_CC += lib/panic.cc
SRCS_CC += lib/cxx_abi.cc
SRCS_CC += lib/rbtree.cc

# ============================================================
# musl string library (cross-platform with arch asm overrides)
# ============================================================

# Map LumeOS ARCH to musl string arch directory
# riscv has no musl asm optimizations → pure C fallback
MUSL_STRING_ARCH_riscv  :=
MUSL_STRING_ARCH_x86_64 := x86_64
MUSL_STRING_ARCH_i386   := i386
MUSL_STRING_ARCH_aarch64:= aarch64
MUSL_STRING_ARCH_arm    := arm

MUSL_STRING_ARCH := $(MUSL_STRING_ARCH_$(ARCH))

# Collect arch-specific asm sources (if any for this arch)
MUSL_ASM_SRCS :=
ifneq ($(MUSL_STRING_ARCH),)
    MUSL_ASM_SRCS += $(wildcard lib/string/$(MUSL_STRING_ARCH)/*.S) \
                     $(wildcard lib/string/$(MUSL_STRING_ARCH)/*.s)
endif

# Derive which C files are overridden by asm (strip path+ext to get base name)
MUSL_ASM_BASENAMES := $(sort $(basename $(notdir $(MUSL_ASM_SRCS))))

# All C sources, then filter out those with asm replacements
MUSL_ALL_C := $(wildcard lib/string/*.c)
MUSL_EXCLUDED_C := $(foreach name,$(MUSL_ASM_BASENAMES),lib/string/$(name).c)
MUSL_C_SRCS := $(filter-out $(MUSL_EXCLUDED_C),$(MUSL_ALL_C))

SRCS_C += $(MUSL_C_SRCS)
SRCS_S += $(filter %.S,$(MUSL_ASM_SRCS))
SRCS_s += $(filter %.s,$(MUSL_ASM_SRCS))
