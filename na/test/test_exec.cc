/* SPDX-License-Identifier: GPL-2.0-or-later */
/* Copyright (C) 2026 Richard Qin */

/*
 * test_exec.cc — Self-tests for execve / ELF loader
 *
 * Tests the ELF validation, binary loading, and user stack construction
 * by creating synthetic ELF binaries in RamFS and invoking do_execve
 * in a controlled environment.
 *
 * We cannot test the actual user-space transition (that requires
 * sret to U-mode), but we CAN test everything up to and including
 * the trapframe setup.
 */

#include <lume/selftest.h>
#include <lume/elf.h>
#include <lume/task.h>
#include <lume/vmm.h>
#include <lume/pmm.h>
#include <lume/addr.h>
#include <lume/errno.h>
#include <lume/fdtable.h>
#include <lume/fs.h>
#include <lume/fs_struct.h>
#include <lume/dcache.h>
#include <lume/namei.h>
#include <lume/file.h>
#include <lume/mm_layout.h>
#include <arch/trapframe.h>
#include <arch/pmap.h>

/* Extern: do_execve (kernel/exec.cc) */
int do_execve(const char* pathname, const char* const* argv,
              const char* const* envp);

/* Extern: VFS file creation syscalls */
int64 sys_openat(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_write(uint64, uint64, uint64, uint64, uint64, uint64);
int64 sys_close(uint64, uint64, uint64, uint64, uint64, uint64);

/* ================================================================== */
/*  Helper: build a minimal valid RISC-V ELF64 in a buffer             */
/* ================================================================== */

struct TestElf {
    Elf64_Ehdr ehdr;
    Elf64_Phdr phdr;
    uint8      code[16];  /* Tiny "program" — just a few NOPs */
};

/*
 * Build a minimal static ELF64 for RISC-V.
 * Single PT_LOAD segment mapping the tiny code at 0x10000.
 * Entry point = 0x10000 + offsetof(code).
 */
static void build_minimal_elf(TestElf* elf)
{
    /* Zero everything */
    for (uint64 i = 0; i < sizeof(*elf); i++)
        reinterpret_cast<uint8*>(elf)[i] = 0;

    /* ELF header */
    Elf64_Ehdr* e = &elf->ehdr;
    e->e_ident[EI_MAG0]    = ELFMAG0;
    e->e_ident[EI_MAG1]    = ELFMAG1;
    e->e_ident[EI_MAG2]    = ELFMAG2;
    e->e_ident[EI_MAG3]    = ELFMAG3;
    e->e_ident[EI_CLASS]   = ELFCLASS64;
    e->e_ident[EI_DATA]    = ELFDATA2LSB;
    e->e_ident[EI_VERSION] = 1;
    e->e_type      = ET_EXEC;
    e->e_machine   = EM_RISCV;
    e->e_version   = 1;
    e->e_phoff     = sizeof(Elf64_Ehdr);
    e->e_phentsize = sizeof(Elf64_Phdr);
    e->e_phnum     = 1;
    e->e_ehsize    = sizeof(Elf64_Ehdr);

    /* Code section offset within the file */
    uint64 code_offset = sizeof(Elf64_Ehdr) + sizeof(Elf64_Phdr);

    /* Entry point = vaddr of code */
    uint64 load_vaddr = 0x10000;
    e->e_entry = load_vaddr + code_offset;

    /* Program header — single PT_LOAD covering entire file */
    Elf64_Phdr* p = &elf->phdr;
    p->p_type   = PT_LOAD;
    p->p_flags  = PF_R | PF_X;
    p->p_offset = 0;
    p->p_vaddr  = load_vaddr;
    p->p_paddr  = load_vaddr;
    p->p_filesz = sizeof(TestElf);
    p->p_memsz  = sizeof(TestElf);
    p->p_align  = 0x1000;

    /* Code: RISC-V "unimp" (all zeros = illegal instruction, but good enough for testing) */
    /* We just need the loader to succeed; we won't actually execute this. */
    elf->code[0] = 0x13;  /* nop = addi x0, x0, 0 */
    elf->code[4] = 0x13;
    elf->code[8] = 0x73;  /* ebreak */
}

/* ================================================================== */
/*  Helper: write a buffer to a file in RamFS                          */
/* ================================================================== */

static int create_test_file(const char* path, const void* data, uint64 size)
{
    /* Open with O_CREAT | O_WRONLY | O_TRUNC */
    int64 fd = sys_openat(
        static_cast<uint64>(-100),  /* AT_FDCWD */
        reinterpret_cast<uint64>(path),
        O_CREAT | O_WRONLY | O_TRUNC,
        0755, 0, 0);
    if (fd < 0) return static_cast<int>(fd);

    int64 written = sys_write(
        static_cast<uint64>(fd),
        reinterpret_cast<uint64>(data),
        size, 0, 0, 0);

    sys_close(static_cast<uint64>(fd), 0, 0, 0, 0, 0);

    if (written < 0) return static_cast<int>(written);
    if (static_cast<uint64>(written) != size) return -EIO;
    return 0;
}

/* ================================================================== */
/*  Helper: ensure current task has VFS context for file ops            */
/* ================================================================== */

struct ExecTestCtx {
    TaskControlBlock* curr;
    VmSpace*          old_mm;
    arch::TrapFrame   fake_tf;
    arch::TrapFrame*  old_tf;
    uint64            saved_satp;
};

static void exec_test_setup(ExecTestCtx* ctx)
{
    ctx->curr = current_task();

    /* Save kernel SATP so we can restore it in teardown */
    asm volatile("csrr %0, satp" : "=r"(ctx->saved_satp));

    /* Save and replace mm with a fresh one */
    ctx->old_mm = ctx->curr->mm;
    ctx->curr->mm = VmSpace::create();

    /* Set up a fake trapframe so do_execve can modify it */
    for (uint64 i = 0; i < sizeof(ctx->fake_tf); i++)
        reinterpret_cast<uint8*>(&ctx->fake_tf)[i] = 0;
    ctx->old_tf = ctx->curr->trapframe;
    ctx->curr->trapframe = &ctx->fake_tf;
}

static void exec_test_teardown(ExecTestCtx* ctx)
{
    /* Restore trapframe */
    ctx->curr->trapframe = ctx->old_tf;

    /* Destroy the test mm (may have been replaced by do_execve) */
    VmSpace* test_mm = ctx->curr->mm;
    ctx->curr->mm = ctx->old_mm;
    if (test_mm && test_mm != ctx->old_mm) {
        /* If do_execve succeeded, it activated new_mm's page table.
         * Switch back to the kernel page table before destroying. */
        asm volatile("csrw satp, %0" :: "r"(ctx->saved_satp));
        asm volatile("sfence.vma");
        test_mm->put();
    }
}

/* ================================================================== */
/*  Test cases                                                         */
/* ================================================================== */

void selftest_exec()
{
    /* ---- 1a. Non-existent path under missing directory ---- */
    st_begin("exec: missing path returns error");
    {
        const char* argv[] = { "/no_such_dir/no_file", nullptr };
        const char* envp[] = { nullptr };
        int ret = do_execve("/no_such_dir/no_file", argv, envp);
        ST_ASSERT(ret < 0);  /* -ENOENT from filename_lookup */
    }
    st_pass();

    /* ---- 1b. Directory is not executable ---- */
    st_begin("exec: directory returns -EACCES");
    {
        /* "/" exists and is a directory */
        const char* argv[] = { "/dev", nullptr };
        const char* envp[] = { nullptr };
        int ret = do_execve("/dev", argv, envp);
        ST_ASSERT_EQ(ret, -EACCES);
    }
    st_pass();

    /* ---- 2. Bad ELF magic ---- */
    st_begin("exec: bad ELF magic returns -ENOEXEC");
    {
        uint8 garbage[128];
        for (int i = 0; i < 128; i++) garbage[i] = 0xAA;
        int err = create_test_file("/test_bad_magic", garbage, 128);
        ST_ASSERT_EQ(err, 0);

        ExecTestCtx ctx;
        exec_test_setup(&ctx);

        const char* argv[] = { "/test_bad_magic", nullptr };
        const char* envp[] = { nullptr };
        int ret = do_execve("/test_bad_magic", argv, envp);
        ST_ASSERT_EQ(ret, -ENOEXEC);

        exec_test_teardown(&ctx);
    }
    st_pass();

    /* ---- 3. Wrong ELF class (32-bit) ---- */
    st_begin("exec: 32-bit ELF returns -ENOEXEC");
    {
        TestElf elf;
        build_minimal_elf(&elf);
        elf.ehdr.e_ident[EI_CLASS] = 1;  /* ELFCLASS32 */
        int err = create_test_file("/test_elf32", &elf, sizeof(elf));
        ST_ASSERT_EQ(err, 0);

        ExecTestCtx ctx;
        exec_test_setup(&ctx);

        const char* argv[] = { "/test_elf32", nullptr };
        const char* envp[] = { nullptr };
        int ret = do_execve("/test_elf32", argv, envp);
        ST_ASSERT_EQ(ret, -ENOEXEC);

        exec_test_teardown(&ctx);
    }
    st_pass();

    /* ---- 4. Wrong endianness (big-endian) ---- */
    st_begin("exec: big-endian ELF returns -ENOEXEC");
    {
        TestElf elf;
        build_minimal_elf(&elf);
        elf.ehdr.e_ident[EI_DATA] = 2;  /* ELFDATA2MSB */
        int err = create_test_file("/test_be", &elf, sizeof(elf));
        ST_ASSERT_EQ(err, 0);

        ExecTestCtx ctx;
        exec_test_setup(&ctx);

        const char* argv[] = { "/test_be", nullptr };
        const char* envp[] = { nullptr };
        int ret = do_execve("/test_be", argv, envp);
        ST_ASSERT_EQ(ret, -ENOEXEC);

        exec_test_teardown(&ctx);
    }
    st_pass();

    /* ---- 5. Wrong machine (x86_64 instead of RISC-V) ---- */
    st_begin("exec: wrong machine type returns -ENOEXEC");
    {
        TestElf elf;
        build_minimal_elf(&elf);
        elf.ehdr.e_machine = 62;  /* EM_X86_64 */
        int err = create_test_file("/test_x86", &elf, sizeof(elf));
        ST_ASSERT_EQ(err, 0);

        ExecTestCtx ctx;
        exec_test_setup(&ctx);

        const char* argv[] = { "/test_x86", nullptr };
        const char* envp[] = { nullptr };
        int ret = do_execve("/test_x86", argv, envp);
        ST_ASSERT_EQ(ret, -ENOEXEC);

        exec_test_teardown(&ctx);
    }
    st_pass();

    /* ---- 6. Truncated ELF (too small for header) ---- */
    st_begin("exec: truncated ELF returns -ENOEXEC");
    {
        /* Valid magic but file is too short for full header */
        uint8 tiny[8] = { 0x7f, 'E', 'L', 'F', 2, 1, 1, 0 };
        int err = create_test_file("/test_tiny", tiny, sizeof(tiny));
        ST_ASSERT_EQ(err, 0);

        ExecTestCtx ctx;
        exec_test_setup(&ctx);

        const char* argv[] = { "/test_tiny", nullptr };
        const char* envp[] = { nullptr };
        int ret = do_execve("/test_tiny", argv, envp);
        ST_ASSERT_EQ(ret, -ENOEXEC);

        exec_test_teardown(&ctx);
    }
    st_pass();

    /* ---- 7. Zero program headers ---- */
    st_begin("exec: zero phnum returns -ENOEXEC");
    {
        TestElf elf;
        build_minimal_elf(&elf);
        elf.ehdr.e_phnum = 0;
        int err = create_test_file("/test_nophdr", &elf, sizeof(elf));
        ST_ASSERT_EQ(err, 0);

        ExecTestCtx ctx;
        exec_test_setup(&ctx);

        const char* argv[] = { "/test_nophdr", nullptr };
        const char* envp[] = { nullptr };
        int ret = do_execve("/test_nophdr", argv, envp);
        ST_ASSERT_EQ(ret, -ENOEXEC);

        exec_test_teardown(&ctx);
    }
    st_pass();

    /* ---- 8. Valid ELF: successful load and trapframe setup ---- */
    st_begin("exec: valid ELF loads and sets up trapframe");
    {
        TestElf elf;
        build_minimal_elf(&elf);
        int err = create_test_file("/test_valid", &elf, sizeof(elf));
        ST_ASSERT_EQ(err, 0);

        ExecTestCtx ctx;
        exec_test_setup(&ctx);

        const char* argv[] = { "/test_valid", nullptr };
        const char* envp[] = { "HOME=/", nullptr };
        int ret = do_execve("/test_valid", argv, envp);
        ST_ASSERT_EQ(ret, 0);

        /* Verify trapframe was set up correctly */
        arch::TrapFrame* tf = &ctx.fake_tf;

        /* Entry point should match what we set in the ELF */
        uint64 code_offset = sizeof(Elf64_Ehdr) + sizeof(Elf64_Phdr);
        uint64 expected_entry = 0x10000 + code_offset;
        ST_ASSERT_EQ(tf->epc, expected_entry);

        /* Stack pointer should be in user space, below the stack top */
        ST_ASSERT(tf->sp > 0);
        ST_ASSERT(tf->sp < kUserStackTop);
        ST_ASSERT(tf->sp >= kUserStackBase);

        /* sstatus: SPP=0 (U-mode), SPIE=1 (interrupts enabled on sret) */
        uint64 spp_bit = (1ULL << 8);
        uint64 spie_bit = (1ULL << 5);
        ST_ASSERT_EQ(tf->sstatus & spp_bit, 0ULL);  /* Not S-mode */
        ST_ASSERT_EQ(tf->sstatus & spie_bit, spie_bit);  /* SPIE set */

        /* General registers should be zeroed */
        ST_ASSERT_EQ(tf->ra, 0ULL);
        ST_ASSERT_EQ(tf->gp, 0ULL);
        ST_ASSERT_EQ(tf->tp, 0ULL);
        for (int i = 0; i < 7; i++)
            ST_ASSERT_EQ(tf->t[i], 0ULL);
        for (int i = 0; i < 12; i++)
            ST_ASSERT_EQ(tf->s[i], 0ULL);
        for (int i = 0; i < 8; i++)
            ST_ASSERT_EQ(tf->a[i], 0ULL);

        exec_test_teardown(&ctx);
    }
    st_pass();

    /* ---- 9. Verify user stack layout (argc/argv) ---- */
    st_begin("exec: user stack has correct argc/argv layout");
    {
        TestElf elf;
        build_minimal_elf(&elf);
        int err = create_test_file("/test_stack", &elf, sizeof(elf));
        ST_ASSERT_EQ(err, 0);

        ExecTestCtx ctx;
        exec_test_setup(&ctx);

        const char* argv[] = { "/test_stack", "arg1", nullptr };
        const char* envp[] = { "A=B", nullptr };
        int ret = do_execve("/test_stack", argv, envp);
        ST_ASSERT_EQ(ret, 0);

        /* The stack was set up in the new mm.
         * Read argc from the top of the stack using pmap lookup. */
        VmSpace* mm = ctx.curr->mm;
        uint64 sp = ctx.fake_tf.sp;

        /* Look up the physical page for sp */
        uint64 pa = 0;
        bool mapped = pmap::lookup(mm->root_pa, sp & ~(kPageSize - 1), &pa);
        ST_ASSERT(mapped);

        /* Read argc (first uint64 on stack) */
        uint64 page_offset = sp & (kPageSize - 1);
        uint8* kva = reinterpret_cast<uint8*>(pa_to_va(PhysAddr{pa}).raw);
        uint64 argc = *reinterpret_cast<uint64*>(kva + page_offset);
        ST_ASSERT_EQ(argc, 2ULL);  /* "/test_stack" and "arg1" */

        exec_test_teardown(&ctx);
    }
    st_pass();

    /* ---- 10. Multiple consecutive execve replaces mm correctly ---- */
    st_begin("exec: consecutive execve replaces address space");
    {
        TestElf elf;
        build_minimal_elf(&elf);
        int err = create_test_file("/test_reexec", &elf, sizeof(elf));
        ST_ASSERT_EQ(err, 0);

        ExecTestCtx ctx;
        exec_test_setup(&ctx);

        /* First exec */
        const char* argv[] = { "/test_reexec", nullptr };
        const char* envp[] = { nullptr };
        int ret = do_execve("/test_reexec", argv, envp);
        ST_ASSERT_EQ(ret, 0);

        VmSpace* first_mm = ctx.curr->mm;
        ST_ASSERT(first_mm != nullptr);

        /* Second exec — should replace the first mm */
        ret = do_execve("/test_reexec", argv, envp);
        ST_ASSERT_EQ(ret, 0);

        /* mm should be different (new address space) */
        VmSpace* second_mm = ctx.curr->mm;
        ST_ASSERT(second_mm != nullptr);
        ST_ASSERT_NE(first_mm, second_mm);

        exec_test_teardown(&ctx);
    }
    st_pass();
}
