/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#include <arch/extable.h>
#include <lume/types.h>

extern struct ExceptionTableEntry __extable_start[];
extern struct ExceptionTableEntry __extable_end[];

static void swap_extable_entries(struct ExceptionTableEntry *a, struct ExceptionTableEntry *b) {
    uint64 a_insn = reinterpret_cast<uint64>(&a->insn) + a->insn;
    uint64 a_fixup = reinterpret_cast<uint64>(&a->fixup) + a->fixup;
    uint64 b_insn = reinterpret_cast<uint64>(&b->insn) + b->insn;
    uint64 b_fixup = reinterpret_cast<uint64>(&b->fixup) + b->fixup;

    a->insn = static_cast<int32>(b_insn - reinterpret_cast<uint64>(&a->insn));
    a->fixup = static_cast<int32>(b_fixup - reinterpret_cast<uint64>(&a->fixup));
    b->insn = static_cast<int32>(a_insn - reinterpret_cast<uint64>(&b->insn));
    b->fixup = static_cast<int32>(a_fixup - reinterpret_cast<uint64>(&b->fixup));
}

static void sort_extable(size_t left, size_t right) {
    if (left >= right) return;

    size_t mid_idx = left + (right - left) / 2;
    struct ExceptionTableEntry *pivot = &__extable_start[mid_idx];
    uint64 pivot_val = reinterpret_cast<uint64>(&pivot->insn) + pivot->insn;

    size_t i = left;
    size_t j = right;

    while (i <= j) {
        while ((reinterpret_cast<uint64>(&__extable_start[i].insn) + __extable_start[i].insn) < pivot_val) {
            i++;
        }
        while ((reinterpret_cast<uint64>(&__extable_start[j].insn) + __extable_start[j].insn) > pivot_val) {
            if (j == 0) {
                break;
            }
            j--;
        }
        if (i <= j) {
            swap_extable_entries(&__extable_start[i], &__extable_start[j]);
            i++;
            if (j == 0) {
                break;
            }
            j--;
        }
    }

    if (j > left) {
        sort_extable(left, j);
    }
    if (i < right) {
        sort_extable(i, right);
    }
}

void extable_init() {
    size_t count = __extable_end - __extable_start;
    if (count <= 1) return;
    sort_extable(0, count - 1);
}

uint64 search_extable(uint64 pc) {
    size_t count = __extable_end - __extable_start;
    if (count == 0) return 0;

    size_t left = 0;
    size_t right = count - 1;

    /* Binary search */
    while (left <= right) {
        size_t mid = left + (right - left) / 2;
        const struct ExceptionTableEntry *entry = &__extable_start[mid];
        uint64 mid_pc = reinterpret_cast<uint64>(&entry->insn) + entry->insn;

        if (mid_pc == pc) {
            return reinterpret_cast<uint64>(&entry->fixup) + entry->fixup;
        }

        if (mid_pc < pc) {
            left = mid + 1;
        } else {
            if (mid == 0) break;
            right = mid - 1;
        }
    }

    return 0;
}
