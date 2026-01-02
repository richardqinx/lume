#pragma once
#include "common/types.h"

struct Trapframe
{
    /* 0 */ uint64 kernel_satp;
    /* 8 */ uint64 kernel_sp;
    /* 16 */ uint64 kernel_trap;
    /* 24 */ uint64 epc;
    /* 32 */ uint64 kernel_hartid;

    /* 40 */ uint64 ra;   // x1
    /* 48 */ uint64 sp;   // x2
    /* 56 */ uint64 gp;   // x3
    /* 64 */ uint64 tp;   // x4
    /* 72 */ uint64 t0;   // x5
    /* 80 */ uint64 t1;   // x6
    /* 88 */ uint64 t2;   // x7
    /* 96 */ uint64 s0;   // x8 (Frame Pointer)
    /* 104 */ uint64 s1;  // x9
    /* 112 */ uint64 a0;  // x10
    /* 120 */ uint64 a1;  // x11
    /* 128 */ uint64 a2;  // x12
    /* 136 */ uint64 a3;  // x13
    /* 144 */ uint64 a4;  // x14
    /* 152 */ uint64 a5;  // x15
    /* 160 */ uint64 a6;  // x16
    /* 168 */ uint64 a7;  // x17
    /* 176 */ uint64 s2;  // x18
    /* 184 */ uint64 s3;  // x19
    /* 192 */ uint64 s4;  // x20
    /* 200 */ uint64 s5;  // x21
    /* 208 */ uint64 s6;  // x22
    /* 216 */ uint64 s7;  // x23
    /* 224 */ uint64 s8;  // x24
    /* 232 */ uint64 s9;  // x25
    /* 240 */ uint64 s10; // x26
    /* 248 */ uint64 s11; // x27
    /* 256 */ uint64 t3;  // x28
    /* 264 */ uint64 t4;  // x29
    /* 272 */ uint64 t5;  // x30
    /* 280 */ uint64 t6;  // x31
};

namespace Trap
{
    void init();
    void inithart();
    int devintr();
}