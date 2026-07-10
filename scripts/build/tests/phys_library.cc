// SPDX-License-Identifier: GPL-2.0-or-later

extern "C" unsigned long LumePhysBuildSmoke(unsigned long value) {
  return value ^ 0x4c554d45UL;
}
