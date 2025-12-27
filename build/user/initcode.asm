
build/user/initcode.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <_start>:
#include "user/user.h"

int main();

extern "C" void _start()
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
    exit(main());
   4:	004000ef          	jal	8 <main>

0000000000000008 <main>:
}

int main()
{
   8:	1141                	addi	sp,sp,-16
   a:	e406                	sd	ra,8(sp)
    int pid = fork();
   c:	060000ef          	jal	6c <fork>

    if (pid < 0)
  10:	00054f63          	bltz	a0,2e <main+0x26>
    {
        write(1, "Fork failed\n", 12);
        exit(1);
    }

    if (pid == 0)
  14:	e905                	bnez	a0,44 <main+0x3c>
    {
        write(1, "Hello from Child!\n", 18);
  16:	4649                	li	a2,18
  18:	00000597          	auipc	a1,0x0
  1c:	12058593          	addi	a1,a1,288 # 138 <putc+0x24>
  20:	4505                	li	a0,1
  22:	072000ef          	jal	94 <write>
        exit(0);
  26:	4501                	li	a0,0
  28:	04c000ef          	jal	74 <exit>
        write(1, "Parent waiting...\n", 18);
        wait(0);
        write(1, "Parent: Child exited.\n", 22);
    }

    while (1);
  2c:	a001                	j	2c <main+0x24>
        write(1, "Fork failed\n", 12);
  2e:	4631                	li	a2,12
  30:	00000597          	auipc	a1,0x0
  34:	0f058593          	addi	a1,a1,240 # 120 <putc+0xc>
  38:	4505                	li	a0,1
  3a:	05a000ef          	jal	94 <write>
        exit(1);
  3e:	4505                	li	a0,1
  40:	034000ef          	jal	74 <exit>
        write(1, "Parent waiting...\n", 18);
  44:	4649                	li	a2,18
  46:	00000597          	auipc	a1,0x0
  4a:	10a58593          	addi	a1,a1,266 # 150 <putc+0x3c>
  4e:	4505                	li	a0,1
  50:	044000ef          	jal	94 <write>
        wait(0);
  54:	4501                	li	a0,0
  56:	026000ef          	jal	7c <wait>
        write(1, "Parent: Child exited.\n", 22);
  5a:	4659                	li	a2,22
  5c:	00000597          	auipc	a1,0x0
  60:	10c58593          	addi	a1,a1,268 # 168 <putc+0x54>
  64:	4505                	li	a0,1
  66:	02e000ef          	jal	94 <write>
  6a:	b7c9                	j	2c <main+0x24>

000000000000006c <fork>:
    name: \
        li a7, SYS_ ## name; \
        ecall; \
        ret

SYSCALL(fork)
  6c:	4889                	li	a7,2
  6e:	00000073          	ecall
  72:	8082                	ret

0000000000000074 <exit>:
SYSCALL(exit)
  74:	488d                	li	a7,3
  76:	00000073          	ecall
  7a:	8082                	ret

000000000000007c <wait>:
SYSCALL(wait)
  7c:	4891                	li	a7,4
  7e:	00000073          	ecall
  82:	8082                	ret

0000000000000084 <pipe>:
SYSCALL(pipe)
  84:	4895                	li	a7,5
  86:	00000073          	ecall
  8a:	8082                	ret

000000000000008c <read>:
SYSCALL(read)
  8c:	4899                	li	a7,6
  8e:	00000073          	ecall
  92:	8082                	ret

0000000000000094 <write>:
SYSCALL(write)
  94:	48c5                	li	a7,17
  96:	00000073          	ecall
  9a:	8082                	ret

000000000000009c <close>:
SYSCALL(close)
  9c:	48d9                	li	a7,22
  9e:	00000073          	ecall
  a2:	8082                	ret

00000000000000a4 <kill>:
SYSCALL(kill)
  a4:	489d                	li	a7,7
  a6:	00000073          	ecall
  aa:	8082                	ret

00000000000000ac <exec>:
SYSCALL(exec)
  ac:	48a1                	li	a7,8
  ae:	00000073          	ecall
  b2:	8082                	ret

00000000000000b4 <open>:
SYSCALL(open)
  b4:	48c1                	li	a7,16
  b6:	00000073          	ecall
  ba:	8082                	ret

00000000000000bc <mknod>:
SYSCALL(mknod)
  bc:	48c9                	li	a7,18
  be:	00000073          	ecall
  c2:	8082                	ret

00000000000000c4 <unlink>:
SYSCALL(unlink)
  c4:	48cd                	li	a7,19
  c6:	00000073          	ecall
  ca:	8082                	ret

00000000000000cc <fstat>:
SYSCALL(fstat)
  cc:	48a5                	li	a7,9
  ce:	00000073          	ecall
  d2:	8082                	ret

00000000000000d4 <link>:
SYSCALL(link)
  d4:	48d1                	li	a7,20
  d6:	00000073          	ecall
  da:	8082                	ret

00000000000000dc <mkdir>:
SYSCALL(mkdir)
  dc:	48d5                	li	a7,21
  de:	00000073          	ecall
  e2:	8082                	ret

00000000000000e4 <chdir>:
SYSCALL(chdir)
  e4:	48a9                	li	a7,10
  e6:	00000073          	ecall
  ea:	8082                	ret

00000000000000ec <dup>:
SYSCALL(dup)
  ec:	48ad                	li	a7,11
  ee:	00000073          	ecall
  f2:	8082                	ret

00000000000000f4 <getpid>:
SYSCALL(getpid)
  f4:	48b1                	li	a7,12
  f6:	00000073          	ecall
  fa:	8082                	ret

00000000000000fc <sbrk>:
SYSCALL(sbrk)
  fc:	48b5                	li	a7,13
  fe:	00000073          	ecall
 102:	8082                	ret

0000000000000104 <sleep>:
SYSCALL(sleep)
 104:	48b9                	li	a7,14
 106:	00000073          	ecall
 10a:	8082                	ret

000000000000010c <uptime>:
SYSCALL(uptime)
 10c:	48bd                	li	a7,15
 10e:	00000073          	ecall
 112:	8082                	ret

0000000000000114 <putc>:
 114:	4885                	li	a7,1
 116:	00000073          	ecall
 11a:	8082                	ret
