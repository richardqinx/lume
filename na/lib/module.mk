# lib/module.mk
SRCS_CC += lib/cxx_abi.cc
SRCS_CC += lib/rbtree.cc
SRCS_CC += lib/kobject.cc
SRCS_CC += lib/kprintf.cc
SRCS_CC += lib/klog.cc
SRCS_CC += lib/random.cc
SRCS_C  += lib/printf.c

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

# ============================================================
# libfdt — kernel adapter shims around scripts/dtc/libfdt/.
#
# Each shim is two lines:
#     #include <linux/libfdt_env.h>
#     #include "../scripts/dtc/libfdt/fdt*.c"
# matching Linux lib/fdt*.c verbatim.  The compile recipe needs:
#   - <linux/libfdt_env.h>  reachable via the default -Iinclude path
#   - -I scripts/dtc/libfdt  so the upstream source's #include <libfdt.h>
#     and friends resolve to scripts/dtc/libfdt/libfdt.h
# Overriding CFLAGS_LIBC (which the %.o: %.c rule uses) avoids dragging
# in libc-shim headers — libfdt is freestanding-compatible and uses
# only the string functions forward-declared in <linux/libfdt_env.h>.
# ============================================================
LIBFDT_FILES := fdt.c fdt_ro.c fdt_wip.c fdt_rw.c fdt_sw.c \
                fdt_strerror.c fdt_empty_tree.c fdt_addresses.c
SRCS_C += $(addprefix lib/,$(LIBFDT_FILES))

# Per-target CFLAGS override: plain CFLAGS plus the upstream include dir.
# Use `=` (recursive) not `:=` because $(CFLAGS) is defined in the top
# Makefile AFTER this file is included — `:=` would expand it now (empty)
# and lose -Iinclude, breaking <linux/libfdt_env.h>.
$(addprefix $(BUILD)/lib/,$(LIBFDT_FILES:.c=.o)): CFLAGS_LIBC = \
    $(CFLAGS) -I scripts/dtc/libfdt
