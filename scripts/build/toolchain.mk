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
CXX_STDLIB    ?= libstdc++
CXX_ABI       ?= lume
COMPILER_RUNTIME ?= compiler-default

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
ifeq ($(CXX_STDLIB),libstdc++)
TOOLCHAIN_CXXFLAGS := -stdlib=libstdc++
else
$(error unsupported CXX_STDLIB '$(CXX_STDLIB)' for the current imported runtime)
endif
ifeq ($(LD_TYPE),lld)
LD := $(LLD)
LINKER_FAMILY := lld
else
ifneq ($(CXX_STDLIB),libstdc++)
$(error GCC configuration currently requires CXX_STDLIB=libstdc++)
endif
LD := $(CROSS_COMPILE)ld
LINKER_FAMILY := bfd
endif
else
CC  := $(CROSS_COMPILE)gcc
CXX := $(CROSS_COMPILE)g++
LD  := $(CROSS_COMPILE)ld
COMPILER_FAMILY := gcc
LINKER_FAMILY := bfd
endif

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
