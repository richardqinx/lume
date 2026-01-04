// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (C) 2026 Richard QIn
 */

#pragma once
#include "common/types.h"

// SBI Extension IDs
#define SBI_EID_SRST 0x53525354

// SBI Function IDs for SRST
#define SBI_FID_SRST_RESET 0

// Reset Types
#define SBI_SRST_TYPE_SHUTDOWN 0
#define SBI_SRST_TYPE_COLD_REBOOT 1
#define SBI_SRST_TYPE_WARM_REBOOT 2

// Reset Reasons
#define SBI_SRST_REASON_NONE 0
#define SBI_SRST_REASON_SYSTEM_FAILURE 1

namespace SBI
{
    void set_timer(uint64 stime_value);
    void sbi_shutdown();
    void sbi_reboot();
} // namespace SBI
