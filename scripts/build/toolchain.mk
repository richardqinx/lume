# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026 Richard Qin

# Toolchain selection:
#   make                         GCC + GNU ld
#   make LLVM=1                  Clang + GNU ld
#   make LLVM=1 LD_TYPE=lld      Clang + LLD

LLVM          ?= 0
LLVM_VERSION  ?= 20
LD_TYPE       ?= bfd
LLVM_BINUTILS ?= 0
CXX_STDLIB    ?= libc++
CXX_ABI       ?= lume
COMPILER_RUNTIME ?= compiler-default

# One pinned libc++ header snapshot is shared by GCC and Clang.  Platform C
# declarations and libc++ configuration come from the Zircon libc/KTL layer,
# not from a Linux or Fuchsia userland __config_site.
LIBCXX_ROOT ?= third_party/libcxx
LIBCXX_INCLUDE := $(LIBCXX_ROOT)/include/c++/v1
KTL_INCLUDE := lib/ktl/include
KTL_AFTER_INCLUDE := lib/ktl/include-after
KERNEL_LIBC_INCLUDE := lib/libc/include
KERNEL_LIBC_AFTER_INCLUDE := lib/libc/include-after

ifeq ($(wildcard $(LIBCXX_INCLUDE)/__config),)
$(error missing pinned libc++ headers under '$(LIBCXX_INCLUDE)')
endif
ifeq ($(wildcard $(KTL_INCLUDE)/__config_site),)
$(error missing KTL libc++ configuration under '$(KTL_INCLUDE)')
endif
ifneq ($(CXX_STDLIB),libc++)
$(error unsupported CXX_STDLIB '$(CXX_STDLIB)' (LumeOS uses its pinned libc++ headers))
endif

GCC_TOOLCHAIN ?=
CROSS_COMPILE ?=

ifeq ($(ARCH),riscv)
TARGET_TRIPLE := riscv64-unknown-linux-gnu
ifeq ($(strip $(GCC_TOOLCHAIN)),)
ifneq ($(wildcard /opt/riscv64-glibc/bin/riscv64-unknown-linux-gnu-g++),)
GCC_TOOLCHAIN := /opt/riscv64-glibc
endif
endif
ifeq ($(strip $(CROSS_COMPILE)),)
ifneq ($(strip $(GCC_TOOLCHAIN)),)
CROSS_COMPILE := $(GCC_TOOLCHAIN)/bin/$(TARGET_TRIPLE)-
else
CROSS_COMPILE := $(TARGET_TRIPLE)-
endif
endif
else ifeq ($(ARCH),aarch64)
TARGET_TRIPLE := aarch64-linux-gnu
else ifeq ($(ARCH),x86_64)
TARGET_TRIPLE := x86_64-linux-gnu
endif

ifeq ($(strip $(CROSS_COMPILE)),)
CROSS_COMPILE := $(TARGET_TRIPLE)-
endif
ifeq ($(strip $(GCC_TOOLCHAIN)),)
GCC_TOOLCHAIN := $(patsubst %/bin/,%, $(dir $(CROSS_COMPILE)))
endif

GCC_SYSROOT := $(strip $(shell $(CROSS_COMPILE)g++ -print-sysroot 2>/dev/null))

CLANG_SUFFIX := $(if $(LLVM_VERSION),-$(LLVM_VERSION),)
CLANG         ?= clang$(CLANG_SUFFIX)
CLANGXX       ?= clang++$(CLANG_SUFFIX)
LLD           ?= ld.lld$(CLANG_SUFFIX)

CLANG_TARGET_FLAGS := --target=$(TARGET_TRIPLE)
ifneq ($(strip $(GCC_TOOLCHAIN)),)
CLANG_TARGET_FLAGS += --gcc-toolchain=$(GCC_TOOLCHAIN)
endif
ifneq ($(strip $(GCC_SYSROOT)),)
CLANG_TARGET_FLAGS += --sysroot=$(GCC_SYSROOT)
endif

ifeq ($(LLVM),1)
CC  := $(CLANG)
CXX := $(CLANGXX)
COMPILER_FAMILY := clang
TOOLCHAIN_CFLAGS := $(CLANG_TARGET_FLAGS)
TOOLCHAIN_CXXFLAGS :=
COMPILER_RESOURCE_DIR := $(strip $(shell $(CXX) $(CLANG_TARGET_FLAGS) -print-resource-dir 2>/dev/null))
COMPILER_RESOURCE_INCLUDE := $(COMPILER_RESOURCE_DIR)/include
ifeq ($(LD_TYPE),lld)
LD := $(LLD)
LINKER_FAMILY := lld
else
LD := $(CROSS_COMPILE)ld
LINKER_FAMILY := bfd
endif

else
CC  := $(CROSS_COMPILE)gcc
CXX := $(CROSS_COMPILE)g++
LD  := $(CROSS_COMPILE)ld
COMPILER_FAMILY := gcc
LINKER_FAMILY := bfd
COMPILER_RESOURCE_INCLUDE := $(strip $(shell $(CXX) -print-file-name=include 2>/dev/null))
endif

ifeq ($(wildcard $(COMPILER_RESOURCE_INCLUDE)/stddef.h),)
$(error missing compiler resource headers under '$(COMPILER_RESOURCE_INCLUDE)')
endif

# Kernel and phys code must not observe the Linux target sysroot.  Supply only
# compiler intrinsic headers explicitly; the target graph provides the kernel
# libc and KTL layers, followed by the pinned libc++ headers for C++.
TOOLCHAIN_CFLAGS += -nostdinc -isystem $(COMPILER_RESOURCE_INCLUDE)
TOOLCHAIN_CXXFLAGS += -isystem $(LIBCXX_INCLUDE)

ifeq ($(LLVM_BINUTILS),1)
AR      := llvm-ar$(CLANG_SUFFIX)
NM      := llvm-nm$(CLANG_SUFFIX)
OBJCOPY := llvm-objcopy$(CLANG_SUFFIX)
OBJDUMP := llvm-objdump$(CLANG_SUFFIX)
READELF := llvm-readelf$(CLANG_SUFFIX)
else
AR      := $(CROSS_COMPILE)ar
NM      := $(CROSS_COMPILE)nm
OBJCOPY := $(CROSS_COMPILE)objcopy
OBJDUMP := $(CROSS_COMPILE)objdump
READELF := $(CROSS_COMPILE)readelf
endif
SIZE := $(CROSS_COMPILE)size
