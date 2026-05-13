/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * plic.cc — Platform-Level Interrupt Controller (RISC-V)
 *
 * QEMU virt platform PLIC:
 *   Base PA: 0x0C000000
 *   Size:    0x04000000 (64MB)
 *
 * Register layout (per RISC-V PLIC spec):
 *   0x000000: Priority registers (source 0..1023, 4 bytes each)
 *   0x001000: Pending bits (source 0..1023, bit per source)
 *   0x002000: Enable bits per context
 *   0x200000: Threshold + claim/complete per context
 *
 * Context mapping for QEMU virt:
 *   Context 2*hartid + 1 = S-mode context for hart N
 *
 * Reference: docs/specs/trap.md §5.1
 */

#include <arch/config.h>
#include <arch/cpu.h>
#include <lume/addr.h>
#include <lume/config.h>
#include <lume/fdt.h>
#include <lume/driver.h>
#include <lume/irq.h>
#include <lume/types.h>
#include <lume/vmm.h>

/* PLIC virtual base (after MMIO mapping) */
static uint64 plic_va;

/* PLIC register offsets */
static constexpr uint64 PLIC_PRIORITY_BASE = 0x000000;
static constexpr uint64 PLIC_PENDING_BASE = 0x001000;
static constexpr uint64 PLIC_ENABLE_BASE = 0x002000;
static constexpr uint64 PLIC_THRESHOLD_BASE = 0x200000;
static constexpr uint64 PLIC_CLAIM_BASE = 0x200004;

/* Each context's enable/threshold/claim region is 0x80 bytes apart for enable,
 * and 0x1000 bytes apart for threshold/claim. */
static constexpr uint64 PLIC_ENABLE_STRIDE = 0x80;
static constexpr uint64 PLIC_CONTEXT_STRIDE = 0x1000;

/* Dynamic S-mode context mapping */
static uint32 g_s_context[kMaxCpus];

static inline uint64 s_context(uint64 hart_id) {
  if (hart_id < kMaxCpus)
    return g_s_context[hart_id];
  return 2 * hart_id + 1; /* safe fallback */
}

static bool str_equals_plic(const char *a, const char *b) {
  if (!a || !b)
    return false;
  while (*a && *a == *b) {
    a++;
    b++;
  }
  return *a == *b;
}

/* Read a 32-bit MMIO register */
static inline uint32 plic_read32(uint64 offset) {
  return *reinterpret_cast<volatile uint32 *>(plic_va + offset);
}

/* Write a 32-bit MMIO register */
static inline void plic_write32(uint64 offset, uint32 val) {
  *reinterpret_cast<volatile uint32 *>(plic_va + offset) = val;
}

/* ========================================================================
 * Public API
 * ======================================================================== */

static void plic_probe(DeviceNode* node) {
  uint64 plic_pa = 0;

  /* Initialize default fallback mapping */
  for (uint32 i = 0; i < kMaxCpus; i++) {
    g_s_context[i] = 2 * i + 1;
  }

  /* Dynamically discover PLIC base address and context mapping from FDT */
  if (node) {
    plic_pa = node->get_prop_u64("reg", plic_pa);

    /* Build phandle to hart_id map */
    struct PhandleMap {
      uint32 phandle;
      uint32 hart_id;
    } pmap[kMaxCpus];
    int num_cpus = 0;

    DeviceNode *cpus_node = fdt_get_node_by_path("/cpus");
    if (cpus_node) {
      list_node *cur = cpus_node->children_list_head();
      list_node *end = cpus_node->children_list_sentinel();
      while (cur != end && num_cpus < kMaxCpus) {
        DeviceNode *cpu =
            list_entry<DeviceNode, &DeviceNode::sibling_link_>(cur);
        cur = cur->next;

        const char *type = cpu->get_prop_string("device_type");
        if (type && str_equals_plic(type, "cpu")) {
          uint32 hart_id = cpu->get_prop_u32("reg");
          DeviceNode *intc = cpu->find_child("interrupt-controller");
          if (intc) {
            uint32 phandle = intc->get_prop_u32("phandle");
            if (phandle == 0)
              phandle = intc->get_prop_u32("linux,phandle");
            if (phandle != 0) {
              pmap[num_cpus].phandle = phandle;
              pmap[num_cpus].hart_id = hart_id;
              num_cpus++;
            }
          }
        }
      }
    }

    /* Parse interrupts-extended */
    const FdtProperty *ie_prop = node->get_prop("interrupts-extended");
    if (ie_prop && ie_prop->len > 0) {
      uint32 len = ie_prop->len;
      const uint8 *val = static_cast<const uint8 *>(ie_prop->value);
      int context_idx = 0;
      /* Each entry is 2 cells (8 bytes): [phandle, interrupt_type] */
      for (uint32 i = 0; i + 7 < len; i += 8) {
        uint32 phandle = (uint32(val[i]) << 24) | (uint32(val[i + 1]) << 16) |
                         (uint32(val[i + 2]) << 8) | val[i + 3];
        uint32 irq_type = (uint32(val[i + 4]) << 24) |
                          (uint32(val[i + 5]) << 16) |
                          (uint32(val[i + 6]) << 8) | val[i + 7];

        if (irq_type == 9) { /* IRQ_S_EXTERNAL */
          for (int h = 0; h < num_cpus; h++) {
            if (pmap[h].phandle == phandle) {
              if (pmap[h].hart_id < kMaxCpus) {
                g_s_context[pmap[h].hart_id] = context_idx;
              }
              break;
            }
          }
        }
        context_idx++;
      }
    }
  }

  if (plic_pa == 0) return;

  /* Map PLIC MMIO */
  vmm_map_kernel_mmio(plic_pa, 0x4000000);
  plic_va = pa_to_va(phys_addr(plic_pa)).raw;

  uint64 ctx = s_context(0); /* BSP = hart 0 */

  /* Set priority for all sources to 1 (minimum non-zero = enabled) */
  for (uint32 irq = 1; irq < IrqManager::kMaxIrqs; irq++) {
    plic_write32(PLIC_PRIORITY_BASE + irq * 4, 1);
  }

  /* Set threshold to 0 for BSP context (accept all priorities > 0) */
  plic_write32(PLIC_THRESHOLD_BASE + ctx * PLIC_CONTEXT_STRIDE, 0);
}

static void plic_init_ap() {
  uint64 ctx = s_context(arch::cpu::id());

  /* Set threshold to 0 for this AP's context */
  plic_write32(PLIC_THRESHOLD_BASE + ctx * PLIC_CONTEXT_STRIDE, 0);
}

static void plic_enable(uint32 irq) {
  if (irq == 0 || irq >= IrqManager::kMaxIrqs) {
    return;
  }

  uint64 ctx = s_context(arch::cpu::id());
  uint64 offset = PLIC_ENABLE_BASE + ctx * PLIC_ENABLE_STRIDE;
  uint32 word_index = irq / 32;
  uint32 bit_index = irq % 32;

  uint32 val = plic_read32(offset + word_index * 4);
  val |= (1U << bit_index);
  plic_write32(offset + word_index * 4, val);
}

static void plic_disable(uint32 irq) {
  if (irq == 0 || irq >= IrqManager::kMaxIrqs) {
    return;
  }

  uint64 ctx = s_context(arch::cpu::id());
  uint64 offset = PLIC_ENABLE_BASE + ctx * PLIC_ENABLE_STRIDE;
  uint32 word_index = irq / 32;
  uint32 bit_index = irq % 32;

  uint32 val = plic_read32(offset + word_index * 4);
  val &= ~(1U << bit_index);
  plic_write32(offset + word_index * 4, val);
}

static void plic_set_priority(uint32 irq, uint32 priority) {
  if (irq == 0 || irq >= IrqManager::kMaxIrqs)
    return;
  plic_write32(PLIC_PRIORITY_BASE + (irq * 4), priority);
}

static uint32 plic_claim() {
  uint64 ctx = s_context(arch::cpu::id());
  return plic_read32(PLIC_CLAIM_BASE + ctx * PLIC_CONTEXT_STRIDE);
}

static void plic_complete(uint32 irq) {
  uint64 ctx = s_context(arch::cpu::id());
  plic_write32(PLIC_CLAIM_BASE + ctx * PLIC_CONTEXT_STRIDE, irq);
}

static const IrqChip plic_chip = {
    "riscv,plic0",
    plic_claim,
    plic_complete,
    plic_init_ap,
    plic_enable,
    plic_disable,
    plic_set_priority
};

static void plic_probe_wrapper(DeviceNode* node) {
    plic_probe(node);
    g_irq_manager.set_chip(&plic_chip);
}

REGISTER_DRIVER("riscv,plic0", plic_probe_wrapper);
