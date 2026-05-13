# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026 Richard Qin
#
# Drivers module

SRCS_CC += drivers/uart.cc
SRCS_CC += drivers/driver.cc

ifeq ($(ARCH),riscv)
SRCS_CC += drivers/plic.cc
endif
