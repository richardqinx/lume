
build/user/initcode.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <_Z6strlenPKc>:
#include "user/user.h"

int strlen(const char *s)
{
    int n = 0;
    while (s[n])
   0:	00054783          	lbu	a5,0(a0)
   4:	cf81                	beqz	a5,1c <_Z6strlenPKc+0x1c>
   6:	0505                	addi	a0,a0,1
   8:	87aa                	mv	a5,a0
   a:	0007c703          	lbu	a4,0(a5)
   e:	86be                	mv	a3,a5
  10:	0785                	addi	a5,a5,1
  12:	ff65                	bnez	a4,a <_Z6strlenPKc+0xa>
        n++;
  14:	40a6853b          	subw	a0,a3,a0
  18:	2505                	addiw	a0,a0,1
  1a:	8082                	ret
    int n = 0;
  1c:	4501                	li	a0,0
    return n;
}
  1e:	8082                	ret

0000000000000020 <_Z5printPKc>:
    while (s[n])
  20:	00054783          	lbu	a5,0(a0)

void print(const char *s)
{
  24:	85aa                	mv	a1,a0
    while (s[n])
  26:	cf89                	beqz	a5,40 <_Z5printPKc+0x20>
  28:	00150693          	addi	a3,a0,1
  2c:	87b6                	mv	a5,a3
  2e:	0007c703          	lbu	a4,0(a5)
  32:	863e                	mv	a2,a5
  34:	0785                	addi	a5,a5,1
  36:	ff65                	bnez	a4,2e <_Z5printPKc+0xe>
        n++;
  38:	9e15                	subw	a2,a2,a3
  3a:	2605                	addiw	a2,a2,1
    write(1, s, strlen(s));
  3c:	4505                	li	a0,1
  3e:	a491                	j	282 <write>
    int n = 0;
  40:	4601                	li	a2,0
    write(1, s, strlen(s));
  42:	4505                	li	a0,1
  44:	ac3d                	j	282 <write>

0000000000000046 <_Z9print_inti>:

void print_int(int val)
{
    char buf[16];
    int i = 0;
    if (val == 0)
  46:	c159                	beqz	a0,cc <_Z9print_inti+0x86>
{
  48:	7139                	addi	sp,sp,-64
  4a:	f822                	sd	s0,48(sp)
  4c:	fc06                	sd	ra,56(sp)
  4e:	f426                	sd	s1,40(sp)
  50:	f04a                	sd	s2,32(sp)
  52:	842a                	mv	s0,a0
    {
        print("0");
        return;
    }
    if (val < 0)
  54:	06054163          	bltz	a0,b6 <_Z9print_inti+0x70>
  58:	081c                	addi	a5,sp,16
{
  5a:	873e                	mv	a4,a5
        print("-");
        val = -val;
    }
    while (val > 0)
    {
        buf[i++] = (val % 10) + '0';
  5c:	4629                	li	a2,10
  5e:	02c466bb          	remw	a3,s0,a2
  62:	85ba                	mv	a1,a4
    while (val > 0)
  64:	0705                	addi	a4,a4,1
        val /= 10;
  66:	02c4443b          	divw	s0,s0,a2
        buf[i++] = (val % 10) + '0';
  6a:	0306869b          	addiw	a3,a3,48
  6e:	fed70fa3          	sb	a3,-1(a4)
    while (val > 0)
  72:	f475                	bnez	s0,5e <_Z9print_inti+0x18>
  74:	9d9d                	subw	a1,a1,a5
  76:	0015871b          	addiw	a4,a1,1
  7a:	fff7059b          	addiw	a1,a4,-1
  7e:	fff78493          	addi	s1,a5,-1
  82:	1582                	slli	a1,a1,0x20
  84:	94ba                	add	s1,s1,a4
  86:	9181                	srli	a1,a1,0x20
  88:	00e78433          	add	s0,a5,a4
  8c:	8c8d                	sub	s1,s1,a1
  8e:	00f10913          	addi	s2,sp,15
    }
    while (i > 0)
    {
        char c = buf[--i];
  92:	fff44783          	lbu	a5,-1(s0)
        write(1, &c, 1);
  96:	4605                	li	a2,1
  98:	85ca                	mv	a1,s2
  9a:	4505                	li	a0,1
    while (i > 0)
  9c:	147d                	addi	s0,s0,-1
        char c = buf[--i];
  9e:	00f107a3          	sb	a5,15(sp)
        write(1, &c, 1);
  a2:	1e0000ef          	jal	282 <write>
    while (i > 0)
  a6:	fe9416e3          	bne	s0,s1,92 <_Z9print_inti+0x4c>
    }
}
  aa:	70e2                	ld	ra,56(sp)
  ac:	7442                	ld	s0,48(sp)
  ae:	74a2                	ld	s1,40(sp)
  b0:	7902                	ld	s2,32(sp)
  b2:	6121                	addi	sp,sp,64
  b4:	8082                	ret
    write(1, s, strlen(s));
  b6:	4605                	li	a2,1
  b8:	00000597          	auipc	a1,0x0
  bc:	26058593          	addi	a1,a1,608 # 318 <putc+0x16>
  c0:	4505                	li	a0,1
  c2:	1c0000ef          	jal	282 <write>
        val = -val;
  c6:	4080043b          	negw	s0,s0
    while (val > 0)
  ca:	b779                	j	58 <_Z9print_inti+0x12>
    write(1, s, strlen(s));
  cc:	4605                	li	a2,1
  ce:	00000597          	auipc	a1,0x0
  d2:	24258593          	addi	a1,a1,578 # 310 <putc+0xe>
  d6:	4505                	li	a0,1
  d8:	a26d                	j	282 <write>

00000000000000da <_Z4passv>:
    while (s[n])
  da:	00000697          	auipc	a3,0x0
  de:	24668693          	addi	a3,a3,582 # 320 <putc+0x1e>

void pass() { print(" -> [PASS]\n"); }
  e2:	87b6                	mv	a5,a3
    while (s[n])
  e4:	0017c703          	lbu	a4,1(a5)
  e8:	863e                	mv	a2,a5
  ea:	0785                	addi	a5,a5,1
  ec:	ff65                	bnez	a4,e4 <_Z4passv+0xa>
        n++;
  ee:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
  f0:	2605                	addiw	a2,a2,1
  f2:	00000597          	auipc	a1,0x0
  f6:	22e58593          	addi	a1,a1,558 # 320 <putc+0x1e>
  fa:	4505                	li	a0,1
  fc:	a259                	j	282 <write>

00000000000000fe <_Z4failv>:
void fail()
{
  fe:	1141                	addi	sp,sp,-16
 100:	00000697          	auipc	a3,0x0
 104:	23068693          	addi	a3,a3,560 # 330 <putc+0x2e>
 108:	e406                	sd	ra,8(sp)
 10a:	87b6                	mv	a5,a3
    while (s[n])
 10c:	0017c703          	lbu	a4,1(a5)
 110:	863e                	mv	a2,a5
 112:	0785                	addi	a5,a5,1
 114:	ff65                	bnez	a4,10c <_Z4failv+0xe>
        n++;
 116:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 118:	2605                	addiw	a2,a2,1
 11a:	00000597          	auipc	a1,0x0
 11e:	21658593          	addi	a1,a1,534 # 330 <putc+0x2e>
 122:	4505                	li	a0,1
 124:	15e000ef          	jal	282 <write>
    print(" -> [FAIL]\n");
    exit(1);
}
 128:	60a2                	ld	ra,8(sp)
    exit(1);
 12a:	4505                	li	a0,1
}
 12c:	0141                	addi	sp,sp,16
    exit(1);
 12e:	aa15                	j	262 <exit>

0000000000000130 <main>:

int main()
{
 130:	1141                	addi	sp,sp,-16
    print("\n=== Lume OS Full Validation ===\n");
 132:	00000517          	auipc	a0,0x0
 136:	20e50513          	addi	a0,a0,526 # 340 <putc+0x3e>
{
 13a:	e406                	sd	ra,8(sp)
 13c:	e022                	sd	s0,0(sp)
    print("\n=== Lume OS Full Validation ===\n");
 13e:	ee3ff0ef          	jal	20 <_Z5printPKc>

    print("[TEST 1] Write\n");
 142:	00000517          	auipc	a0,0x0
 146:	22650513          	addi	a0,a0,550 # 368 <putc+0x66>
 14a:	ed7ff0ef          	jal	20 <_Z5printPKc>
    print("  System call write is working.");
 14e:	00000517          	auipc	a0,0x0
 152:	22a50513          	addi	a0,a0,554 # 378 <putc+0x76>
 156:	ecbff0ef          	jal	20 <_Z5printPKc>
void pass() { print(" -> [PASS]\n"); }
 15a:	00000517          	auipc	a0,0x0
 15e:	1c650513          	addi	a0,a0,454 # 320 <putc+0x1e>
 162:	ebfff0ef          	jal	20 <_Z5printPKc>
    pass();

    print("[TEST 2] GetPID\n");
 166:	00000517          	auipc	a0,0x0
 16a:	23250513          	addi	a0,a0,562 # 398 <putc+0x96>
 16e:	eb3ff0ef          	jal	20 <_Z5printPKc>
    int parent_pid = getpid();
 172:	170000ef          	jal	2e2 <getpid>
 176:	842a                	mv	s0,a0
    print("  Parent PID: ");
 178:	00000517          	auipc	a0,0x0
 17c:	23850513          	addi	a0,a0,568 # 3b0 <putc+0xae>
 180:	ea1ff0ef          	jal	20 <_Z5printPKc>
    print_int(parent_pid);
 184:	8522                	mv	a0,s0
 186:	ec1ff0ef          	jal	46 <_Z9print_inti>
    if (parent_pid > 0)
 18a:	0c805563          	blez	s0,254 <main+0x124>
void pass() { print(" -> [PASS]\n"); }
 18e:	00000517          	auipc	a0,0x0
 192:	19250513          	addi	a0,a0,402 # 320 <putc+0x1e>
 196:	e8bff0ef          	jal	20 <_Z5printPKc>
        pass();
    else
        fail();

    print("[TEST 3] Fork, Wait & COW\n");
 19a:	00000517          	auipc	a0,0x0
 19e:	22650513          	addi	a0,a0,550 # 3c0 <putc+0xbe>
 1a2:	e7fff0ef          	jal	20 <_Z5printPKc>
    int val = 100;
    int pid = fork();
 1a6:	0b4000ef          	jal	25a <fork>

    if (pid < 0)
 1aa:	04054363          	bltz	a0,1f0 <main+0xc0>
    {
        print("  Fork Failed\n");
        fail();
    }

    if (pid == 0)
 1ae:	e929                	bnez	a0,200 <main+0xd0>
    {
        print("  [Child] PID: ");
 1b0:	00000517          	auipc	a0,0x0
 1b4:	24050513          	addi	a0,a0,576 # 3f0 <putc+0xee>
 1b8:	e69ff0ef          	jal	20 <_Z5printPKc>
        print_int(getpid());
 1bc:	126000ef          	jal	2e2 <getpid>
 1c0:	e87ff0ef          	jal	46 <_Z9print_inti>
        print("\n");
 1c4:	00000517          	auipc	a0,0x0
 1c8:	23c50513          	addi	a0,a0,572 # 400 <putc+0xfe>
 1cc:	e55ff0ef          	jal	20 <_Z5printPKc>
            print("  [Child] Data corruption!\n");
            exit(1);
        }

        val = 200;
        print("  [Child] Modified val to 200. Exiting.\n");
 1d0:	00000517          	auipc	a0,0x0
 1d4:	23850513          	addi	a0,a0,568 # 408 <putc+0x106>
 1d8:	e49ff0ef          	jal	20 <_Z5printPKc>
        exit(0);
 1dc:	4501                	li	a0,0
 1de:	084000ef          	jal	262 <exit>
            print_int(val);
            fail();
        }
    }

    print("\n=== All Tests Passed ===\n");
 1e2:	00000517          	auipc	a0,0x0
 1e6:	2ce50513          	addi	a0,a0,718 # 4b0 <putc+0x1ae>
 1ea:	e37ff0ef          	jal	20 <_Z5printPKc>
    while (1)
 1ee:	a001                	j	1ee <main+0xbe>
        print("  Fork Failed\n");
 1f0:	00000517          	auipc	a0,0x0
 1f4:	1f050513          	addi	a0,a0,496 # 3e0 <putc+0xde>
 1f8:	e29ff0ef          	jal	20 <_Z5printPKc>
        fail();
 1fc:	f03ff0ef          	jal	fe <_Z4failv>
        print("  [Parent] Waiting for child...\n");
 200:	00000517          	auipc	a0,0x0
 204:	23850513          	addi	a0,a0,568 # 438 <putc+0x136>
 208:	e19ff0ef          	jal	20 <_Z5printPKc>
        int child_pid = wait(0);
 20c:	4501                	li	a0,0
 20e:	05c000ef          	jal	26a <wait>
 212:	842a                	mv	s0,a0
        print("  [Parent] Child ");
 214:	00000517          	auipc	a0,0x0
 218:	24c50513          	addi	a0,a0,588 # 460 <putc+0x15e>
 21c:	e05ff0ef          	jal	20 <_Z5printPKc>
        print_int(child_pid);
 220:	8522                	mv	a0,s0
 222:	e25ff0ef          	jal	46 <_Z9print_inti>
        print(" exited.\n");
 226:	00000517          	auipc	a0,0x0
 22a:	25250513          	addi	a0,a0,594 # 478 <putc+0x176>
 22e:	df3ff0ef          	jal	20 <_Z5printPKc>
        print("  [Parent] Check val (Expect 100): ");
 232:	00000517          	auipc	a0,0x0
 236:	25650513          	addi	a0,a0,598 # 488 <putc+0x186>
 23a:	de7ff0ef          	jal	20 <_Z5printPKc>
        print_int(val);
 23e:	06400513          	li	a0,100
 242:	e05ff0ef          	jal	46 <_Z9print_inti>
void pass() { print(" -> [PASS]\n"); }
 246:	00000517          	auipc	a0,0x0
 24a:	0da50513          	addi	a0,a0,218 # 320 <putc+0x1e>
 24e:	dd3ff0ef          	jal	20 <_Z5printPKc>
 252:	bf41                	j	1e2 <main+0xb2>
        fail();
 254:	eabff0ef          	jal	fe <_Z4failv>
 258:	b789                	j	19a <main+0x6a>

000000000000025a <fork>:
    name: \
        li a7, SYS_ ## name; \
        ecall; \
        ret

SYSCALL(fork)
 25a:	4889                	li	a7,2
 25c:	00000073          	ecall
 260:	8082                	ret

0000000000000262 <exit>:
SYSCALL(exit)
 262:	488d                	li	a7,3
 264:	00000073          	ecall
 268:	8082                	ret

000000000000026a <wait>:
SYSCALL(wait)
 26a:	4891                	li	a7,4
 26c:	00000073          	ecall
 270:	8082                	ret

0000000000000272 <pipe>:
SYSCALL(pipe)
 272:	4895                	li	a7,5
 274:	00000073          	ecall
 278:	8082                	ret

000000000000027a <read>:
SYSCALL(read)
 27a:	4899                	li	a7,6
 27c:	00000073          	ecall
 280:	8082                	ret

0000000000000282 <write>:
SYSCALL(write)
 282:	48c5                	li	a7,17
 284:	00000073          	ecall
 288:	8082                	ret

000000000000028a <close>:
SYSCALL(close)
 28a:	48d9                	li	a7,22
 28c:	00000073          	ecall
 290:	8082                	ret

0000000000000292 <kill>:
SYSCALL(kill)
 292:	489d                	li	a7,7
 294:	00000073          	ecall
 298:	8082                	ret

000000000000029a <exec>:
SYSCALL(exec)
 29a:	48a1                	li	a7,8
 29c:	00000073          	ecall
 2a0:	8082                	ret

00000000000002a2 <open>:
SYSCALL(open)
 2a2:	48c1                	li	a7,16
 2a4:	00000073          	ecall
 2a8:	8082                	ret

00000000000002aa <mknod>:
SYSCALL(mknod)
 2aa:	48c9                	li	a7,18
 2ac:	00000073          	ecall
 2b0:	8082                	ret

00000000000002b2 <unlink>:
SYSCALL(unlink)
 2b2:	48cd                	li	a7,19
 2b4:	00000073          	ecall
 2b8:	8082                	ret

00000000000002ba <fstat>:
SYSCALL(fstat)
 2ba:	48a5                	li	a7,9
 2bc:	00000073          	ecall
 2c0:	8082                	ret

00000000000002c2 <link>:
SYSCALL(link)
 2c2:	48d1                	li	a7,20
 2c4:	00000073          	ecall
 2c8:	8082                	ret

00000000000002ca <mkdir>:
SYSCALL(mkdir)
 2ca:	48d5                	li	a7,21
 2cc:	00000073          	ecall
 2d0:	8082                	ret

00000000000002d2 <chdir>:
SYSCALL(chdir)
 2d2:	48a9                	li	a7,10
 2d4:	00000073          	ecall
 2d8:	8082                	ret

00000000000002da <dup>:
SYSCALL(dup)
 2da:	48ad                	li	a7,11
 2dc:	00000073          	ecall
 2e0:	8082                	ret

00000000000002e2 <getpid>:
SYSCALL(getpid)
 2e2:	48b1                	li	a7,12
 2e4:	00000073          	ecall
 2e8:	8082                	ret

00000000000002ea <sbrk>:
SYSCALL(sbrk)
 2ea:	48b5                	li	a7,13
 2ec:	00000073          	ecall
 2f0:	8082                	ret

00000000000002f2 <sleep>:
SYSCALL(sleep)
 2f2:	48b9                	li	a7,14
 2f4:	00000073          	ecall
 2f8:	8082                	ret

00000000000002fa <uptime>:
SYSCALL(uptime)
 2fa:	48bd                	li	a7,15
 2fc:	00000073          	ecall
 300:	8082                	ret

0000000000000302 <putc>:
 302:	4885                	li	a7,1
 304:	00000073          	ecall
 308:	8082                	ret
