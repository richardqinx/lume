# SPDX-License-Identifier: GPL-2.0-or-later

HOSTCC ?= cc
HOSTCXX ?= c++
HOSTAR ?= ar
HOSTCFLAGS ?= -O2 -g -Wall -Wextra
HOSTCXXFLAGS ?= $(HOSTCFLAGS) -std=c++23

