#pragma once

#include "common/types.h"

struct cpu;
struct Proc;

// Spinlock
// Features: Non-interruptible, busy-wait loop, extremely short hold time.
// Scenario: Protecting core data such as scheduler, interrupt handling, PMM, etc.
class Spinlock
{
public:
    volatile uint32 locked;     // Whether it is locked (0: unlocked, 1: locked)
    const char *name;      // Lock Name (for debugging)
    struct cpu *cpu; // The CPU holding the lock

    // Constructor
    Spinlock() : locked(0), name("uninit"), cpu(nullptr) {}

    // Initialize lock name
    void init(const char *name);

    // Acquire lock
    void acquire();

    // Release lock
    void release();

    // Check if the current CPU holds the lock
    bool holding();
};

// Mutex
// Features: Allows interruption, allows sleeping (yield CPU), can hold for a long time.
// Scenarios: File system IO, device driver waiting, long-term buffering operations.
class Mutex
{
public:
    uint32 locked;    // Whether it is locked
    const char *name; // Lock Name
    int pid;          // PID of the process holding the lock (for debugging)

    Spinlock lk; // Internal spin lock, protects the state of the Mutex itself

    void init(const char *name);
    void acquire();
    void release();
    bool holding();
};