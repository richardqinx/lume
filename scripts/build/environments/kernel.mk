# SPDX-License-Identifier: GPL-2.0-or-later

WARNINGS ?= -Wall -Wextra -Wno-unused-parameter

ifeq ($(BUILD_VARIANT),release)
KERNEL_OPT_FLAGS := -O2 -g0 -DNDEBUG
else
KERNEL_OPT_FLAGS := -O2 -g
endif

CFLAGS := $(WARNINGS) $(KERNEL_OPT_FLAGS) \
          -ffreestanding -nostdlib \
          -mcmodel=medany -fPIE -MMD -MP \
          $(TOOLCHAIN_CFLAGS) $(KCPPFLAGS) $(INCLUDES) \
          -I$(BUILD)/generated

CFLAGS_LIBC := $(CFLAGS) -std=gnu23 -Iinclude/libc-shim \
               -Wno-parentheses -Wno-sign-compare

CXXFLAGS := $(CFLAGS) $(TOOLCHAIN_CXXFLAGS) -std=c++23 \
            -fno-exceptions -fno-rtti -fno-use-cxa-atexit \
            -fno-threadsafe-statics

# Pre-MMU assembly must never use GOT-indirect addressing.
ASFLAGS := $(filter-out -fPIE,$(CFLAGS)) -fno-pie

LDFLAGS := -nostdlib -shared -Bsymbolic -z notext -z norelro \
           --no-dynamic-linker
