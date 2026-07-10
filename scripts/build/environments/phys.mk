# SPDX-License-Identifier: GPL-2.0-or-later

# Early physical-address execution environment. It deliberately has no heap,
# exceptions, RTTI, thread-safe statics, or PIE/GOT assumptions.
PHYS_CFLAGS := $(WARNINGS) -Os -g -ffreestanding -nostdlib \
               -fno-pie -fno-stack-protector $(TOOLCHAIN_CFLAGS) \
               $(KCPPFLAGS) $(INCLUDES) -I$(BUILD)/generated
PHYS_CXXFLAGS := $(PHYS_CFLAGS) $(TOOLCHAIN_CXXFLAGS) -std=c++23 \
                 -fno-exceptions -fno-rtti -fno-use-cxa-atexit \
                 -fno-threadsafe-statics
PHYS_ASFLAGS := $(PHYS_CFLAGS)

