/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

#pragma once

/*
 * IRQ Manager — Dynamic Interrupt Dispatch
 *
 * Drivers register ISR callbacks at init time via register_handler().
 * The MI trap layer calls dispatch() when an external interrupt arrives.
 * dispatch() runs in interrupt context — handlers must be short and
 * non-blocking.
 *
 * Lock contract:
 *   - lock_ protects register/unregister (cold path).
 *   - dispatch() is lock-free: handler pointers are published with RELEASE
 *     semantics and read with ACQUIRE in dispatch().
 *   - Handlers must not acquire VmSpace::lock or sleep.
 *
 * Reference: docs/specs/trap.md §3.3
 */

#include <lume/atomic.h>
#include <lume/types.h>

/* IRQ handler callback signature */
using IrqHandler = void (*)(uint32 irq, void *arg);

/* Abstract Interrupt Controller Interface */
struct IrqChip {
  const char* name;
  uint32 (*claim)();
  void (*complete)(uint32 irq);
  void (*init_ap)();
  void (*enable)(uint32 irq);
  void (*disable)(uint32 irq);
  void (*set_priority)(uint32 irq, uint32 priority);
};

class IrqManager {
public:
  void init();

  /* Register an ISR for the given IRQ number.
   * Returns 0 on success, -EINVAL if irq out of range, -EBUSY if already
   * registered. */
  int register_handler(uint32 irq, IrqHandler handler, void *arg);

  /* Unregister the ISR for the given IRQ number. */
  void unregister_handler(uint32 irq);

  /* Dispatch an interrupt to the registered handler.
   * Called from MI trap layer in interrupt context. Lock-free. */
  void dispatch(uint32 irq);

  /* Set the active interrupt controller chip */
  void set_chip(const IrqChip* chip);
  const IrqChip* get_chip() const { return chip_; }

  /* Architecture-independent claim and complete for the active IRQ chip */
  uint32 claim() const;
  void complete(uint32 irq) const;
  void init_ap() const;
  void enable(uint32 irq) const;
  void disable(uint32 irq) const;
  void set_priority(uint32 irq, uint32 priority) const;

  /* Check if a handler is registered for the given IRQ. */
  bool has_handler(uint32 irq) const;

  static constexpr uint32 kMaxIrqs = 64;

private:
  struct IrqEntry {
    lume::atomic<uint64> handler_ptr; // Stored as uint64 for atomic access
    void *arg = nullptr;
  };

  const IrqChip* chip_ = nullptr;
  IrqEntry entries_[kMaxIrqs];
};

/* Global IRQ manager singleton */
extern IrqManager g_irq_manager;
