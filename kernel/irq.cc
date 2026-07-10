/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * IRQ Manager Implementation
 *
 * Lock-free dispatch path for interrupt context safety.
 * Registration/unregistration is protected by atomic publish.
 *
 * Reference: docs/specs/trap.md §3.3
 */

#include <lume/console.h>
#include <lume/errno.h>
#include <lume/irq.h>

/* Global singleton */
IrqManager g_irq_manager;

void IrqManager::init() {
  for (uint32 i = 0; i < kMaxIrqs; i++) {
    entries_[i].handler_ptr.store(0, __ATOMIC_RELAXED);
    entries_[i].arg = nullptr;
  }
}

int IrqManager::register_handler(uint32 irq, IrqHandler handler, void *arg) {
  if (irq >= kMaxIrqs)
    return -EINVAL;

  if (!handler)
    return -EINVAL;

  /* Check if already registered (CAS from 0 to handler) */
  uint64 expected = 0;
  uint64 desired = reinterpret_cast<uint64>(handler);

  /* Set arg first (before publishing handler) so dispatch sees valid arg */
  entries_[irq].arg = arg;

  if (!entries_[irq].handler_ptr.compare_exchange(expected, desired,
                                                  __ATOMIC_ACQ_REL)) {
    /* Already registered by someone else */
    return -EBUSY;
  }

  return 0;
}

void IrqManager::unregister_handler(uint32 irq) {
  if (irq >= kMaxIrqs)
    return;

  /* Clear handler with release semantics */
  entries_[irq].handler_ptr.store(0, __ATOMIC_RELEASE);
  entries_[irq].arg = nullptr;
}

void IrqManager::dispatch(uint32 irq) {
  if (irq >= kMaxIrqs)
    return;

  /* Load handler with acquire semantics — pairs with register's release */
  uint64 h = entries_[irq].handler_ptr.load(__ATOMIC_ACQUIRE);
  if (h == 0) {
    /* Spurious or unregistered IRQ — silently ignore */
    return;
  }

  auto handler = reinterpret_cast<IrqHandler>(h);
  handler(irq, entries_[irq].arg);
}

bool IrqManager::has_handler(uint32 irq) const {
  if (irq >= kMaxIrqs)
    return false;
  return entries_[irq].handler_ptr.load(__ATOMIC_ACQUIRE) != 0;
}

void IrqManager::set_chip(const IrqChip* chip) {
  chip_ = chip;
}

uint32 IrqManager::claim() const {
  return chip_ ? chip_->claim() : 0;
}

void IrqManager::complete(uint32 irq) const {
  if (chip_) chip_->complete(irq);
}

void IrqManager::init_ap() const {
  if (chip_ && chip_->init_ap) chip_->init_ap();
}

void IrqManager::enable(uint32 irq) const {
  if (chip_ && chip_->enable) chip_->enable(irq);
}

void IrqManager::disable(uint32 irq) const {
  if (chip_ && chip_->disable) chip_->disable(irq);
}

void IrqManager::set_priority(uint32 irq, uint32 priority) const {
  if (chip_ && chip_->set_priority) chip_->set_priority(irq, priority);
}
