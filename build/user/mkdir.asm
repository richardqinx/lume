
build/user/mkdir:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "ulib/stdio.h"
#include "user/user.h"

int main(int argc, char* argv[])
{
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
    if (argc < 2)
       4:	4785                	li	a5,1
       6:	04a7de63          	bge	a5,a0,62 <main+0x62>
    {
        printf("Usage: mkdir <dirname> ...\n");
        exit(1);
    }

    for (int i = 1; i < argc; i++)
       a:	e426                	sd	s1,8(sp)
       c:	ffe5049b          	addiw	s1,a0,-2
      10:	02049793          	slli	a5,s1,0x20
      14:	01d7d493          	srli	s1,a5,0x1d
      18:	01058793          	addi	a5,a1,16
      1c:	e822                	sd	s0,16(sp)
      1e:	e04a                	sd	s2,0(sp)
      20:	00858413          	addi	s0,a1,8
      24:	94be                	add	s1,s1,a5
    {
        if (mkdir(argv[i]) < 0)
        {
            printf("mkdir: cannot create directory '%s'\n", argv[i]);
      26:	00005917          	auipc	s2,0x5
      2a:	fda90913          	addi	s2,s2,-38 # 5000 <_GLOBAL__sub_I__ZSt3cin+0x58>
      2e:	a021                	j	36 <main+0x36>
    for (int i = 1; i < argc; i++)
      30:	0421                	addi	s0,s0,8
      32:	00940e63          	beq	s0,s1,4e <main+0x4e>
        if (mkdir(argv[i]) < 0)
      36:	6008                	ld	a0,0(s0)
      38:	0b8000ef          	jal	f0 <mkdir>
      3c:	fe055ae3          	bgez	a0,30 <main+0x30>
            printf("mkdir: cannot create directory '%s'\n", argv[i]);
      40:	600c                	ld	a1,0(s0)
      42:	854a                	mv	a0,s2
    for (int i = 1; i < argc; i++)
      44:	0421                	addi	s0,s0,8
            printf("mkdir: cannot create directory '%s'\n", argv[i]);
      46:	06d030ef          	jal	38b2 <printf>
    for (int i = 1; i < argc; i++)
      4a:	fe9416e3          	bne	s0,s1,36 <main+0x36>
      4e:	6442                	ld	s0,16(sp)
      50:	64a2                	ld	s1,8(sp)
      52:	6902                	ld	s2,0(sp)
        }
    }

    exit(0);
      54:	4501                	li	a0,0
      56:	370040ef          	jal	43c6 <exit>
      5a:	60e2                	ld	ra,24(sp)
      5c:	4501                	li	a0,0
      5e:	6105                	addi	sp,sp,32
      60:	8082                	ret
        printf("Usage: mkdir <dirname> ...\n");
      62:	00005517          	auipc	a0,0x5
      66:	f7e50513          	addi	a0,a0,-130 # 4fe0 <_GLOBAL__sub_I__ZSt3cin+0x38>
      6a:	049030ef          	jal	38b2 <printf>
        exit(1);
      6e:	4505                	li	a0,1
      70:	356040ef          	jal	43c6 <exit>
    for (int i = 1; i < argc; i++)
      74:	b7c5                	j	54 <main+0x54>

0000000000000076 <_start>:
.global _start

_start:


    call main
      76:	f8bff0ef          	jal	0 <main>

    call exit
      7a:	34c040ef          	jal	43c6 <exit>

      7e:	a001                	j	7e <_start+0x8>

0000000000000080 <sys_exit>:
    name: \
        li a7, SYS_ ## sysname; \
        ecall; \
        ret

SYSCALL_NAME(sys_exit, exit) 
      80:	488d                	li	a7,3
      82:	00000073          	ecall
      86:	8082                	ret

0000000000000088 <fork>:

SYSCALL(fork)
      88:	4889                	li	a7,2
      8a:	00000073          	ecall
      8e:	8082                	ret

0000000000000090 <wait>:
SYSCALL(wait)
      90:	4891                	li	a7,4
      92:	00000073          	ecall
      96:	8082                	ret

0000000000000098 <pipe>:
SYSCALL(pipe)
      98:	4895                	li	a7,5
      9a:	00000073          	ecall
      9e:	8082                	ret

00000000000000a0 <read>:
SYSCALL(read)
      a0:	4899                	li	a7,6
      a2:	00000073          	ecall
      a6:	8082                	ret

00000000000000a8 <write>:
SYSCALL(write)
      a8:	48c5                	li	a7,17
      aa:	00000073          	ecall
      ae:	8082                	ret

00000000000000b0 <close>:
SYSCALL(close)
      b0:	48d9                	li	a7,22
      b2:	00000073          	ecall
      b6:	8082                	ret

00000000000000b8 <kill>:
SYSCALL(kill)
      b8:	489d                	li	a7,7
      ba:	00000073          	ecall
      be:	8082                	ret

00000000000000c0 <exec>:
SYSCALL(exec)
      c0:	48a1                	li	a7,8
      c2:	00000073          	ecall
      c6:	8082                	ret

00000000000000c8 <open>:
SYSCALL(open)
      c8:	48c1                	li	a7,16
      ca:	00000073          	ecall
      ce:	8082                	ret

00000000000000d0 <mknod>:
SYSCALL(mknod)
      d0:	48c9                	li	a7,18
      d2:	00000073          	ecall
      d6:	8082                	ret

00000000000000d8 <unlink>:
SYSCALL(unlink)
      d8:	48cd                	li	a7,19
      da:	00000073          	ecall
      de:	8082                	ret

00000000000000e0 <fstat>:
SYSCALL(fstat)
      e0:	48a5                	li	a7,9
      e2:	00000073          	ecall
      e6:	8082                	ret

00000000000000e8 <link>:
SYSCALL(link)
      e8:	48d1                	li	a7,20
      ea:	00000073          	ecall
      ee:	8082                	ret

00000000000000f0 <mkdir>:
SYSCALL(mkdir)
      f0:	48d5                	li	a7,21
      f2:	00000073          	ecall
      f6:	8082                	ret

00000000000000f8 <chdir>:
SYSCALL(chdir)
      f8:	48a9                	li	a7,10
      fa:	00000073          	ecall
      fe:	8082                	ret

0000000000000100 <dup>:
SYSCALL(dup)
     100:	48ad                	li	a7,11
     102:	00000073          	ecall
     106:	8082                	ret

0000000000000108 <getpid>:
SYSCALL(getpid)
     108:	48b1                	li	a7,12
     10a:	00000073          	ecall
     10e:	8082                	ret

0000000000000110 <sbrk>:
SYSCALL(sbrk)
     110:	48b5                	li	a7,13
     112:	00000073          	ecall
     116:	8082                	ret

0000000000000118 <sleep>:
SYSCALL(sleep)
     118:	48b9                	li	a7,14
     11a:	00000073          	ecall
     11e:	8082                	ret

0000000000000120 <uptime>:
SYSCALL(uptime)
     120:	48bd                	li	a7,15
     122:	00000073          	ecall
     126:	8082                	ret

0000000000000128 <putc>:
SYSCALL(putc)
     128:	4885                	li	a7,1
     12a:	00000073          	ecall
     12e:	8082                	ret

0000000000000130 <disk_test>:
SYSCALL(disk_test)
     130:	48dd                	li	a7,23
     132:	00000073          	ecall
     136:	8082                	ret

0000000000000138 <lseek>:
SYSCALL(lseek)
     138:	48e1                	li	a7,24
     13a:	00000073          	ecall
     13e:	8082                	ret

0000000000000140 <shutdown>:
     140:	48e5                	li	a7,25
     142:	00000073          	ecall
     146:	8082                	ret

0000000000000148 <stbsp__clamp_callback>:
     148:	45dc                	lw	a5,12(a1)
     14a:	4598                	lw	a4,8(a1)
     14c:	9fb1                	addw	a5,a5,a2
     14e:	c5dc                	sw	a5,12(a1)
     150:	0007069b          	sext.w	a3,a4
     154:	00e65463          	bge	a2,a4,15c <stbsp__clamp_callback+0x14>
     158:	0006069b          	sext.w	a3,a2
     15c:	c685                	beqz	a3,184 <stbsp__clamp_callback+0x3c>
     15e:	619c                	ld	a5,0(a1)
     160:	00a78e63          	beq	a5,a0,17c <stbsp__clamp_callback+0x34>
     164:	00d50633          	add	a2,a0,a3
     168:	00054703          	lbu	a4,0(a0)
     16c:	0505                	addi	a0,a0,1
     16e:	0785                	addi	a5,a5,1
     170:	fee78fa3          	sb	a4,-1(a5)
     174:	fec56ae3          	bltu	a0,a2,168 <stbsp__clamp_callback+0x20>
     178:	6188                	ld	a0,0(a1)
     17a:	4598                	lw	a4,8(a1)
     17c:	9f15                	subw	a4,a4,a3
     17e:	9536                	add	a0,a0,a3
     180:	e188                	sd	a0,0(a1)
     182:	c598                	sw	a4,8(a1)
     184:	1ff00793          	li	a5,511
     188:	00e7d463          	bge	a5,a4,190 <stbsp__clamp_callback+0x48>
     18c:	6188                	ld	a0,0(a1)
     18e:	8082                	ret
     190:	01058513          	addi	a0,a1,16
     194:	8082                	ret

0000000000000196 <stbsp__count_clamp_callback>:
     196:	45dc                	lw	a5,12(a1)
     198:	01058513          	addi	a0,a1,16
     19c:	9fb1                	addw	a5,a5,a2
     19e:	c5dc                	sw	a5,12(a1)
     1a0:	8082                	ret

00000000000001a2 <stbsp__real_to_str>:
     1a2:	e20508d3          	fmv.x.d	a7,fa0
     1a6:	82aa                	mv	t0,a0
     1a8:	4348d813          	srai	a6,a7,0x34
     1ac:	8ec6                	mv	t4,a7
     1ae:	7ff87813          	andi	a6,a6,2047
     1b2:	8346                	mv	t1,a7
     1b4:	03f8d513          	srli	a0,a7,0x3f
     1b8:	0008d663          	bgez	a7,1c4 <stbsp__real_to_str+0x22>
     1bc:	22a517d3          	fneg.d	fa5,fa0
     1c0:	e20788d3          	fmv.x.d	a7,fa5
     1c4:	7ff00e13          	li	t3,2047
     1c8:	35c80663          	beq	a6,t3,514 <stbsp__real_to_str+0x372>
     1cc:	1101                	addi	sp,sp,-32
     1ce:	14080363          	beqz	a6,314 <stbsp__real_to_str+0x172>
     1d2:	c018081b          	addiw	a6,a6,-1023
     1d6:	ec22                	sd	s0,24(sp)
     1d8:	02081313          	slli	t1,a6,0x20
     1dc:	66034d63          	bltz	t1,856 <stbsp__real_to_str+0x6b4>
     1e0:	4d100313          	li	t1,1233
     1e4:	0303033b          	mulw	t1,t1,a6
     1e8:	4849                	li	a6,18
     1ea:	40c3531b          	sraiw	t1,t1,0xc
     1ee:	0013039b          	addiw	t2,t1,1
     1f2:	4078083b          	subw	a6,a6,t2
     1f6:	4359                	li	t1,22
     1f8:	17036163          	bltu	t1,a6,35a <stbsp__real_to_str+0x1b8>
     1fc:	00005317          	auipc	t1,0x5
     200:	16430313          	addi	t1,t1,356 # 5360 <stbsp__bot>
     204:	080e                	slli	a6,a6,0x3
     206:	981a                	add	a6,a6,t1
     208:	00083e03          	ld	t3,0(a6)
     20c:	00083607          	fld	fa2,0(a6)
     210:	f20887d3          	fmv.d.x	fa5,a7
     214:	f8000837          	lui	a6,0xf8000
     218:	01187333          	and	t1,a6,a7
     21c:	01c87833          	and	a6,a6,t3
     220:	12f676d3          	fmul.d	fa3,fa2,fa5
     224:	f20807d3          	fmv.d.x	fa5,a6
     228:	f2030753          	fmv.d.x	fa4,t1
     22c:	f20305d3          	fmv.d.x	fa1,t1
     230:	0af67653          	fsub.d	fa2,fa2,fa5
     234:	f20887d3          	fmv.d.x	fa5,a7
     238:	0ae7f753          	fsub.d	fa4,fa5,fa4
     23c:	f20807d3          	fmv.d.x	fa5,a6
     240:	6ab7f7c7          	fmsub.d	fa5,fa5,fa1,fa3
     244:	7ab677c3          	fmadd.d	fa5,fa2,fa1,fa5
     248:	f20805d3          	fmv.d.x	fa1,a6
     24c:	7ab777c3          	fmadd.d	fa5,fa4,fa1,fa5
     250:	7ac77743          	fmadd.d	fa4,fa4,fa2,fa5
     254:	02d777d3          	fadd.d	fa5,fa4,fa3
     258:	3782e837          	lui	a6,0x3782e
     25c:	acf80813          	addi	a6,a6,-1329 # 3782dacf <_ZSt4cerr+0x378262d7>
     260:	0832                	slli	a6,a6,0xc
     262:	9d980813          	addi	a6,a6,-1575
     266:	084a                	slli	a6,a6,0x12
     268:	187d                	addi	a6,a6,-1
     26a:	c22798d3          	fcvt.l.d	a7,fa5,rtz
     26e:	0ad7f6d3          	fsub.d	fa3,fa5,fa3
     272:	00070e1b          	sext.w	t3,a4
     276:	d228f653          	fcvt.d.l	fa2,a7
     27a:	0ac7f5d3          	fsub.d	fa1,fa5,fa2
     27e:	0ad77753          	fsub.d	fa4,fa4,fa3
     282:	0af5f6d3          	fsub.d	fa3,fa1,fa5
     286:	0ad5f553          	fsub.d	fa0,fa1,fa3
     28a:	02d67653          	fadd.d	fa2,fa2,fa3
     28e:	0aa7f7d3          	fsub.d	fa5,fa5,fa0
     292:	0ac7f7d3          	fsub.d	fa5,fa5,fa2
     296:	02b7f7d3          	fadd.d	fa5,fa5,fa1
     29a:	02e7f7d3          	fadd.d	fa5,fa5,fa4
     29e:	c2279fd3          	fcvt.l.d	t6,fa5,rtz
     2a2:	9fc6                	add	t6,t6,a7
     2a4:	19f87063          	bgeu	a6,t6,424 <stbsp__real_to_str+0x282>
     2a8:	2385                	addiw	t2,t2,1
     2aa:	300e4363          	bltz	t3,5b0 <stbsp__real_to_str+0x40e>
     2ae:	00e3833b          	addw	t1,t2,a4
     2b2:	475d                	li	a4,23
     2b4:	30677663          	bgeu	a4,t1,5c0 <stbsp__real_to_str+0x41e>
     2b8:	577d                	li	a4,-1
     2ba:	9301                	srli	a4,a4,0x20
     2bc:	43f75863          	bge	a4,t6,6ec <stbsp__real_to_str+0x54a>
     2c0:	07d00313          	li	t1,125
     2c4:	877e                	mv	a4,t6
     2c6:	4e01                	li	t3,0
     2c8:	3e800813          	li	a6,1000
     2cc:	130e                	slli	t1,t1,0x23
     2ce:	a039                	j	2dc <stbsp__real_to_str+0x13a>
     2d0:	030747b3          	div	a5,a4,a6
     2d4:	4e05                	li	t3,1
     2d6:	40674c63          	blt	a4,t1,6ee <stbsp__real_to_str+0x54c>
     2da:	873e                	mv	a4,a5
     2dc:	030768b3          	rem	a7,a4,a6
     2e0:	fe0888e3          	beqz	a7,2d0 <stbsp__real_to_str+0x12e>
     2e4:	400e0163          	beqz	t3,6e6 <stbsp__real_to_str+0x544>
     2e8:	8fbe                	mv	t6,a5
     2ea:	05f5e7b7          	lui	a5,0x5f5e
     2ee:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f56907>
     2f2:	04060413          	addi	s0,a2,64
     2f6:	03860613          	addi	a2,a2,56
     2fa:	15f7c863          	blt	a5,t6,44a <stbsp__real_to_str+0x2a8>
     2fe:	000f871b          	sext.w	a4,t6
     302:	20070463          	beqz	a4,50a <stbsp__real_to_str+0x368>
     306:	4f01                	li	t5,0
     308:	4f81                	li	t6,0
     30a:	00006e97          	auipc	t4,0x6
     30e:	5f6e8e93          	addi	t4,t4,1526 # 6900 <stbsp__digitpair>
     312:	aaa9                	j	46c <stbsp__real_to_str+0x2ca>
     314:	0306                	slli	t1,t1,0x1
     316:	3e030e63          	beqz	t1,712 <stbsp__real_to_str+0x570>
     31a:	4305                	li	t1,1
     31c:	ec22                	sd	s0,24(sp)
     31e:	00ce9e13          	slli	t3,t4,0xc
     322:	134e                	slli	t1,t1,0x33
     324:	520e4063          	bltz	t3,844 <stbsp__real_to_str+0x6a2>
     328:	40135313          	srai	t1,t1,0x1
     32c:	01d37e33          	and	t3,t1,t4
     330:	8f42                	mv	t5,a6
     332:	387d                	addiw	a6,a6,-1
     334:	fe0e0ae3          	beqz	t3,328 <stbsp__real_to_str+0x186>
     338:	26900313          	li	t1,617
     33c:	c00f081b          	addiw	a6,t5,-1024
     340:	0268083b          	mulw	a6,a6,t1
     344:	41f8531b          	sraiw	t1,a6,0x1f
     348:	0153531b          	srliw	t1,t1,0x15
     34c:	0103033b          	addw	t1,t1,a6
     350:	40b3539b          	sraiw	t2,t1,0xb
     354:	4849                	li	a6,18
     356:	4078083b          	subw	a6,a6,t2
     35a:	41f8531b          	sraiw	t1,a6,0x1f
     35e:	00684eb3          	xor	t4,a6,t1
     362:	406e8f3b          	subw	t5,t4,t1
     366:	2c900313          	li	t1,713
     36a:	03e3033b          	mulw	t1,t1,t5
     36e:	4e35                	li	t3,13
     370:	8efa                	mv	t4,t5
     372:	40e35f9b          	sraiw	t6,t1,0xe
     376:	837e                	mv	t1,t6
     378:	23fe4363          	blt	t3,t6,59e <stbsp__real_to_str+0x3fc>
     37c:	5e25                	li	t3,-23
     37e:	026e0e3b          	mulw	t3,t3,t1
     382:	01de0ebb          	addw	t4,t3,t4
     386:	22084f63          	bltz	a6,5c4 <stbsp__real_to_str+0x422>
     38a:	f2000753          	fmv.d.x	fa4,zero
     38e:	00005e17          	auipc	t3,0x5
     392:	fd2e0e13          	addi	t3,t3,-46 # 5360 <stbsp__bot>
     396:	380e9e63          	bnez	t4,732 <stbsp__real_to_str+0x590>
     39a:	f20887d3          	fmv.d.x	fa5,a7
     39e:	fff30f1b          	addiw	t5,t1,-1
     3a2:	0f0e                	slli	t5,t5,0x3
     3a4:	02f777d3          	fadd.d	fa5,fa4,fa5
     3a8:	030e                	slli	t1,t1,0x3
     3aa:	9f72                	add	t5,t5,t3
     3ac:	9e1a                	add	t3,t3,t1
     3ae:	2e0e3e03          	ld	t3,736(t3)
     3b2:	2e8f3587          	fld	fa1,744(t5)
     3b6:	f8000837          	lui	a6,0xf8000
     3ba:	e2078ed3          	fmv.x.d	t4,fa5
     3be:	12b7f6d3          	fmul.d	fa3,fa5,fa1
     3c2:	f2088653          	fmv.d.x	fa2,a7
     3c6:	01d87333          	and	t1,a6,t4
     3ca:	01c87833          	and	a6,a6,t3
     3ce:	f20807d3          	fmv.d.x	fa5,a6
     3d2:	f2030053          	fmv.d.x	ft0,t1
     3d6:	0af5f553          	fsub.d	fa0,fa1,fa5
     3da:	f20e87d3          	fmv.d.x	fa5,t4
     3de:	0ac7f0d3          	fsub.d	ft1,fa5,fa2
     3e2:	f20807d3          	fmv.d.x	fa5,a6
     3e6:	f2030653          	fmv.d.x	fa2,t1
     3ea:	6ac7f647          	fmsub.d	fa2,fa5,fa2,fa3
     3ee:	f20e87d3          	fmv.d.x	fa5,t4
     3f2:	0a177753          	fsub.d	fa4,fa4,ft1
     3f6:	f20300d3          	fmv.d.x	ft1,t1
     3fa:	0a07f7d3          	fsub.d	fa5,fa5,ft0
     3fe:	350f3007          	fld	ft0,848(t5)
     402:	62157643          	fmadd.d	fa2,fa0,ft1,fa2
     406:	12b77753          	fmul.d	fa4,fa4,fa1
     40a:	f20805d3          	fmv.d.x	fa1,a6
     40e:	62b7f643          	fmadd.d	fa2,fa5,fa1,fa2
     412:	f20e85d3          	fmv.d.x	fa1,t4
     416:	7205f743          	fmadd.d	fa4,fa1,ft0,fa4
     41a:	62a7f7c3          	fmadd.d	fa5,fa5,fa0,fa2
     41e:	02e7f753          	fadd.d	fa4,fa5,fa4
     422:	bd0d                	j	254 <stbsp__real_to_str+0xb2>
     424:	00e3833b          	addw	t1,t2,a4
     428:	2a0e4663          	bltz	t3,6d4 <stbsp__real_to_str+0x532>
     42c:	475d                	li	a4,23
     42e:	10677663          	bgeu	a4,t1,53a <stbsp__real_to_str+0x398>
     432:	e80f93e3          	bnez	t6,2b8 <stbsp__real_to_str+0x116>
     436:	05f5e7b7          	lui	a5,0x5f5e
     43a:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f56907>
     43e:	04060413          	addi	s0,a2,64
     442:	03860613          	addi	a2,a2,56
     446:	ebf7dce3          	bge	a5,t6,2fe <stbsp__real_to_str+0x15c>
     44a:	4f01                	li	t5,0
     44c:	00006e97          	auipc	t4,0x6
     450:	4b4e8e93          	addi	t4,t4,1204 # 6900 <stbsp__digitpair>
     454:	05f5e7b7          	lui	a5,0x5f5e
     458:	10078793          	addi	a5,a5,256 # 5f5e100 <_ZSt4cerr+0x5f56908>
     45c:	02ffe833          	rem	a6,t6,a5
     460:	02ffcfb3          	div	t6,t6,a5
     464:	0008071b          	sext.w	a4,a6
     468:	0a080463          	beqz	a6,510 <stbsp__real_to_str+0x36e>
     46c:	8822                	mv	a6,s0
     46e:	06400893          	li	a7,100
     472:	06300e13          	li	t3,99
     476:	1879                	addi	a6,a6,-2 # fffffffff7fffffe <_ZSt4cerr+0xfffffffff7ff8806>
     478:	0007031b          	sext.w	t1,a4
     47c:	031777bb          	remuw	a5,a4,a7
     480:	2785                	addiw	a5,a5,1
     482:	0017979b          	slliw	a5,a5,0x1
     486:	1782                	slli	a5,a5,0x20
     488:	9381                	srli	a5,a5,0x20
     48a:	97f6                	add	a5,a5,t4
     48c:	0007d783          	lhu	a5,0(a5)
     490:	0317573b          	divuw	a4,a4,a7
     494:	00f81023          	sh	a5,0(a6)
     498:	fc6e6fe3          	bltu	t3,t1,476 <stbsp__real_to_str+0x2d4>
     49c:	008f0f3b          	addw	t5,t5,s0
     4a0:	410f0f3b          	subw	t5,t5,a6
     4a4:	020f8f63          	beqz	t6,4e2 <stbsp__real_to_str+0x340>
     4a8:	87c2                	mv	a5,a6
     4aa:	03000713          	li	a4,48
     4ae:	04c80c63          	beq	a6,a2,506 <stbsp__real_to_str+0x364>
     4b2:	17fd                	addi	a5,a5,-1
     4b4:	00e78023          	sb	a4,0(a5)
     4b8:	fec79de3          	bne	a5,a2,4b2 <stbsp__real_to_str+0x310>
     4bc:	408807b3          	sub	a5,a6,s0
     4c0:	00ff07bb          	addw	a5,t5,a5
     4c4:	1461                	addi	s0,s0,-8
     4c6:	00878f1b          	addiw	t5,a5,8
     4ca:	05f5e7b7          	lui	a5,0x5f5e
     4ce:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f56907>
     4d2:	ff840613          	addi	a2,s0,-8
     4d6:	f7f7cfe3          	blt	a5,t6,454 <stbsp__real_to_str+0x2b2>
     4da:	000f871b          	sext.w	a4,t6
     4de:	4f81                	li	t6,0
     4e0:	b771                	j	46c <stbsp__real_to_str+0x2ca>
     4e2:	020f0563          	beqz	t5,50c <stbsp__real_to_str+0x36a>
     4e6:	00084703          	lbu	a4,0(a6)
     4ea:	03000793          	li	a5,48
     4ee:	22f70f63          	beq	a4,a5,72c <stbsp__real_to_str+0x58a>
     4f2:	2f01                	sext.w	t5,t5
     4f4:	0076a023          	sw	t2,0(a3)
     4f8:	6462                	ld	s0,24(sp)
     4fa:	0102b023          	sd	a6,0(t0)
     4fe:	01e5a023          	sw	t5,0(a1)
     502:	6105                	addi	sp,sp,32
     504:	8082                	ret
     506:	8442                	mv	s0,a6
     508:	b7c9                	j	4ca <stbsp__real_to_str+0x328>
     50a:	8822                	mv	a6,s0
     50c:	4f01                	li	t5,0
     50e:	b7dd                	j	4f4 <stbsp__real_to_str+0x352>
     510:	8822                	mv	a6,s0
     512:	bf59                	j	4a8 <stbsp__real_to_str+0x306>
     514:	0eb2                	slli	t4,t4,0xc
     516:	00005797          	auipc	a5,0x5
     51a:	b1a78793          	addi	a5,a5,-1254 # 5030 <_GLOBAL__sub_I__ZSt3cin+0x88>
     51e:	000e8663          	beqz	t4,52a <stbsp__real_to_str+0x388>
     522:	00005797          	auipc	a5,0x5
     526:	b0678793          	addi	a5,a5,-1274 # 5028 <_GLOBAL__sub_I__ZSt3cin+0x80>
     52a:	00f2b023          	sd	a5,0(t0)
     52e:	679d                	lui	a5,0x7
     530:	c29c                	sw	a5,0(a3)
     532:	4f0d                	li	t5,3
     534:	01e5a023          	sw	t5,0(a1)
     538:	8082                	ret
     53a:	3b9ad737          	lui	a4,0x3b9ad
     53e:	9ff70713          	addi	a4,a4,-1537 # 3b9ac9ff <_ZSt4cerr+0x3b9a5207>
     542:	07f76f63          	bltu	a4,t6,5c0 <stbsp__real_to_str+0x41e>
     546:	4805                	li	a6,1
     548:	02081713          	slli	a4,a6,0x20
     54c:	01d75893          	srli	a7,a4,0x1d
     550:	00005717          	auipc	a4,0x5
     554:	1c870713          	addi	a4,a4,456 # 5718 <stbsp__powten>
     558:	9746                	add	a4,a4,a7
     55a:	4e51                	li	t3,20
     55c:	a021                	j	564 <stbsp__real_to_str+0x3c2>
     55e:	2805                	addiw	a6,a6,1
     560:	edc809e3          	beq	a6,t3,432 <stbsp__real_to_str+0x290>
     564:	00073883          	ld	a7,0(a4)
     568:	0721                	addi	a4,a4,8
     56a:	ff1ffae3          	bgeu	t6,a7,55e <stbsp__real_to_str+0x3bc>
     56e:	ed0372e3          	bgeu	t1,a6,432 <stbsp__real_to_str+0x290>
     572:	4068083b          	subw	a6,a6,t1
     576:	475d                	li	a4,23
     578:	eb076de3          	bltu	a4,a6,432 <stbsp__real_to_str+0x290>
     57c:	080e                	slli	a6,a6,0x3
     57e:	00005717          	auipc	a4,0x5
     582:	de270713          	addi	a4,a4,-542 # 5360 <stbsp__bot>
     586:	9742                	add	a4,a4,a6
     588:	3b873803          	ld	a6,952(a4)
     58c:	00185713          	srli	a4,a6,0x1
     590:	977e                	add	a4,a4,t6
     592:	01176363          	bltu	a4,a7,598 <stbsp__real_to_str+0x3f6>
     596:	2385                	addiw	t2,t2,1
     598:	03075fb3          	divu	t6,a4,a6
     59c:	bd59                	j	432 <stbsp__real_to_str+0x290>
     59e:	4335                	li	t1,13
     5a0:	5e25                	li	t3,-23
     5a2:	026e0e3b          	mulw	t3,t3,t1
     5a6:	01de0ebb          	addw	t4,t3,t4
     5aa:	de0850e3          	bgez	a6,38a <stbsp__real_to_str+0x1e8>
     5ae:	a819                	j	5c4 <stbsp__real_to_str+0x422>
     5b0:	02571313          	slli	t1,a4,0x25
     5b4:	02535313          	srli	t1,t1,0x25
     5b8:	0305                	addi	t1,t1,1
     5ba:	475d                	li	a4,23
     5bc:	ce676ee3          	bltu	a4,t1,2b8 <stbsp__real_to_str+0x116>
     5c0:	4829                	li	a6,10
     5c2:	b759                	j	548 <stbsp__real_to_str+0x3a6>
     5c4:	260e8663          	beqz	t4,830 <stbsp__real_to_str+0x68e>
     5c8:	00231e13          	slli	t3,t1,0x2
     5cc:	41c30e33          	sub	t3,t1,t3
     5d0:	0e0e                	slli	t3,t3,0x3
     5d2:	9e1a                	add	t3,t3,t1
     5d4:	fffe881b          	addiw	a6,t4,-1
     5d8:	9e7a                	add	t3,t3,t5
     5da:	00005e97          	auipc	t4,0x5
     5de:	d86e8e93          	addi	t4,t4,-634 # 5360 <stbsp__bot>
     5e2:	0e0e                	slli	t3,t3,0x3
     5e4:	080e                	slli	a6,a6,0x3
     5e6:	9876                	add	a6,a6,t4
     5e8:	9ef2                	add	t4,t4,t3
     5ea:	0b883607          	fld	fa2,184(a6)
     5ee:	f20887d3          	fmv.d.x	fa5,a7
     5f2:	0b0ebf03          	ld	t5,176(t4)
     5f6:	f8000e37          	lui	t3,0xf8000
     5fa:	011e7eb3          	and	t4,t3,a7
     5fe:	12f676d3          	fmul.d	fa3,fa2,fa5
     602:	01ee7e33          	and	t3,t3,t5
     606:	f20e07d3          	fmv.d.x	fa5,t3
     60a:	f20e0753          	fmv.d.x	fa4,t3
     60e:	f20e8553          	fmv.d.x	fa0,t4
     612:	0af67653          	fsub.d	fa2,fa2,fa5
     616:	f20e87d3          	fmv.d.x	fa5,t4
     61a:	f20e85d3          	fmv.d.x	fa1,t4
     61e:	6ae7f7c7          	fmsub.d	fa5,fa5,fa4,fa3
     622:	f2088753          	fmv.d.x	fa4,a7
     626:	0ab775d3          	fsub.d	fa1,fa4,fa1
     62a:	16883707          	fld	fa4,360(a6)
     62e:	7aa677c3          	fmadd.d	fa5,fa2,fa0,fa5
     632:	f20e0553          	fmv.d.x	fa0,t3
     636:	7aa5f7c3          	fmadd.d	fa5,fa1,fa0,fa5
     63a:	7ac5f5c3          	fmadd.d	fa1,fa1,fa2,fa5
     63e:	f20887d3          	fmv.d.x	fa5,a7
     642:	5af77743          	fmadd.d	fa4,fa4,fa5,fa1
     646:	c00f87e3          	beqz	t6,254 <stbsp__real_to_str+0xb2>
     64a:	02d777d3          	fadd.d	fa5,fa4,fa3
     64e:	fff3089b          	addiw	a7,t1,-1
     652:	00005817          	auipc	a6,0x5
     656:	d0e80813          	addi	a6,a6,-754 # 5360 <stbsp__bot>
     65a:	030e                	slli	t1,t1,0x3
     65c:	088e                	slli	a7,a7,0x3
     65e:	98c2                	add	a7,a7,a6
     660:	981a                	add	a6,a6,t1
     662:	e2078e53          	fmv.x.d	t3,fa5
     666:	21083e83          	ld	t4,528(a6)
     66a:	f8000837          	lui	a6,0xf8000
     66e:	2188b507          	fld	fa0,536(a7)
     672:	01c87333          	and	t1,a6,t3
     676:	01d87833          	and	a6,a6,t4
     67a:	f2080653          	fmv.d.x	fa2,a6
     67e:	12f577d3          	fmul.d	fa5,fa0,fa5
     682:	2808b587          	fld	fa1,640(a7)
     686:	0ac57053          	fsub.d	ft0,fa0,fa2
     68a:	f20e0653          	fmv.d.x	fa2,t3
     68e:	0ad67153          	fsub.d	ft2,fa2,fa3
     692:	f20806d3          	fmv.d.x	fa3,a6
     696:	f2030653          	fmv.d.x	fa2,t1
     69a:	7ac6f0c7          	fmsub.d	ft1,fa3,fa2,fa5
     69e:	f20e06d3          	fmv.d.x	fa3,t3
     6a2:	0ac6f653          	fsub.d	fa2,fa3,fa2
     6a6:	22f786d3          	fmv.d	fa3,fa5
     6aa:	0a2777d3          	fsub.d	fa5,fa4,ft2
     6ae:	f2030753          	fmv.d.x	fa4,t1
     6b2:	0ae07743          	fmadd.d	fa4,ft0,fa4,ft1
     6b6:	12a7f7d3          	fmul.d	fa5,fa5,fa0
     6ba:	f2080553          	fmv.d.x	fa0,a6
     6be:	72a67743          	fmadd.d	fa4,fa2,fa0,fa4
     6c2:	f20e0553          	fmv.d.x	fa0,t3
     6c6:	7aa5f7c3          	fmadd.d	fa5,fa1,fa0,fa5
     6ca:	72067643          	fmadd.d	fa2,fa2,ft0,fa4
     6ce:	02f67753          	fadd.d	fa4,fa2,fa5
     6d2:	b649                	j	254 <stbsp__real_to_str+0xb2>
     6d4:	02571313          	slli	t1,a4,0x25
     6d8:	02535313          	srli	t1,t1,0x25
     6dc:	0305                	addi	t1,t1,1
     6de:	475d                	li	a4,23
     6e0:	d46769e3          	bltu	a4,t1,432 <stbsp__real_to_str+0x290>
     6e4:	bd99                	j	53a <stbsp__real_to_str+0x398>
     6e6:	87fe                	mv	a5,t6
     6e8:	8fbe                	mv	t6,a5
     6ea:	b101                	j	2ea <stbsp__real_to_str+0x148>
     6ec:	87fe                	mv	a5,t6
     6ee:	3e800713          	li	a4,1000
     6f2:	02e7f73b          	remuw	a4,a5,a4
     6f6:	2781                	sext.w	a5,a5
     6f8:	eb01                	bnez	a4,708 <stbsp__real_to_str+0x566>
     6fa:	3e800813          	li	a6,1000
     6fe:	0307d7bb          	divuw	a5,a5,a6
     702:	0307f73b          	remuw	a4,a5,a6
     706:	df65                	beqz	a4,6fe <stbsp__real_to_str+0x55c>
     708:	02079f93          	slli	t6,a5,0x20
     70c:	020fdf93          	srli	t6,t6,0x20
     710:	b31d                	j	436 <stbsp__real_to_str+0x294>
     712:	4785                	li	a5,1
     714:	c29c                	sw	a5,0(a3)
     716:	00c2b023          	sd	a2,0(t0)
     71a:	03000793          	li	a5,48
     71e:	00f60023          	sb	a5,0(a2)
     722:	4f05                	li	t5,1
     724:	01e5a023          	sw	t5,0(a1)
     728:	6105                	addi	sp,sp,32
     72a:	8082                	ret
     72c:	0805                	addi	a6,a6,1 # fffffffff8000001 <_ZSt4cerr+0xfffffffff7ff8809>
     72e:	3f7d                	addiw	t5,t5,-1
     730:	b3d1                	j	4f4 <stbsp__real_to_str+0x352>
     732:	e826                	sd	s1,16(sp)
     734:	e44a                	sd	s2,8(sp)
     736:	4859                	li	a6,22
     738:	8976                	mv	s2,t4
     73a:	11d84363          	blt	a6,t4,840 <stbsp__real_to_str+0x69e>
     73e:	0009049b          	sext.w	s1,s2
     742:	00005e17          	auipc	t3,0x5
     746:	c1ee0e13          	addi	t3,t3,-994 # 5360 <stbsp__bot>
     74a:	00349813          	slli	a6,s1,0x3
     74e:	9872                	add	a6,a6,t3
     750:	00083687          	fld	fa3,0(a6)
     754:	00083803          	ld	a6,0(a6)
     758:	f20887d3          	fmv.d.x	fa5,a7
     75c:	f8000fb7          	lui	t6,0xf8000
     760:	010ff833          	and	a6,t6,a6
     764:	12f6f553          	fmul.d	fa0,fa3,fa5
     768:	f20807d3          	fmv.d.x	fa5,a6
     76c:	011ff433          	and	s0,t6,a7
     770:	f2040753          	fmv.d.x	fa4,s0
     774:	0af6f6d3          	fsub.d	fa3,fa3,fa5
     778:	f20887d3          	fmv.d.x	fa5,a7
     77c:	f2080653          	fmv.d.x	fa2,a6
     780:	412e8ebb          	subw	t4,t4,s2
     784:	0ae7f753          	fsub.d	fa4,fa5,fa4
     788:	f20407d3          	fmv.d.x	fa5,s0
     78c:	e20508d3          	fmv.x.d	a7,fa0
     790:	52c7f7c7          	fmsub.d	fa5,fa5,fa2,fa0
     794:	f2040653          	fmv.d.x	fa2,s0
     798:	7ac6f7c3          	fmadd.d	fa5,fa3,fa2,fa5
     79c:	f2080653          	fmv.d.x	fa2,a6
     7a0:	7ac777c3          	fmadd.d	fa5,fa4,fa2,fa5
     7a4:	7ad77743          	fmadd.d	fa4,fa4,fa3,fa5
     7a8:	080e8963          	beqz	t4,83a <stbsp__real_to_str+0x698>
     7ac:	02e577d3          	fadd.d	fa5,fa0,fa4
     7b0:	0e8e                	slli	t4,t4,0x3
     7b2:	01de0833          	add	a6,t3,t4
     7b6:	00083587          	fld	fa1,0(a6)
     7ba:	00231893          	slli	a7,t1,0x2
     7be:	411308b3          	sub	a7,t1,a7
     7c2:	00389813          	slli	a6,a7,0x3
     7c6:	e2078453          	fmv.x.d	s0,fa5
     7ca:	12f5f7d3          	fmul.d	fa5,fa1,fa5
     7ce:	981a                	add	a6,a6,t1
     7d0:	987a                	add	a6,a6,t5
     7d2:	40980833          	sub	a6,a6,s1
     7d6:	080e                	slli	a6,a6,0x3
     7d8:	9872                	add	a6,a6,t3
     7da:	00083e83          	ld	t4,0(a6)
     7de:	008ff833          	and	a6,t6,s0
     7e2:	e20788d3          	fmv.x.d	a7,fa5
     7e6:	f20806d3          	fmv.d.x	fa3,a6
     7ea:	f20407d3          	fmv.d.x	fa5,s0
     7ee:	01dfffb3          	and	t6,t6,t4
     7f2:	f20880d3          	fmv.d.x	ft1,a7
     7f6:	0ad7f653          	fsub.d	fa2,fa5,fa3
     7fa:	f20f87d3          	fmv.d.x	fa5,t6
     7fe:	64c2                	ld	s1,16(sp)
     800:	6922                	ld	s2,8(sp)
     802:	0af5f053          	fsub.d	ft0,fa1,fa5
     806:	0ad7f6c7          	fmsub.d	fa3,fa5,fa3,ft1
     80a:	f20407d3          	fmv.d.x	fa5,s0
     80e:	0aa7f7d3          	fsub.d	fa5,fa5,fa0
     812:	f2080553          	fmv.d.x	fa0,a6
     816:	6aa076c3          	fmadd.d	fa3,ft0,fa0,fa3
     81a:	0af77753          	fsub.d	fa4,fa4,fa5
     81e:	f20f87d3          	fmv.d.x	fa5,t6
     822:	6af677c3          	fmadd.d	fa5,fa2,fa5,fa3
     826:	7a067643          	fmadd.d	fa2,fa2,ft0,fa5
     82a:	62e5f743          	fmadd.d	fa4,fa1,fa4,fa2
     82e:	b6b5                	j	39a <stbsp__real_to_str+0x1f8>
     830:	f20886d3          	fmv.d.x	fa3,a7
     834:	f2000753          	fmv.d.x	fa4,zero
     838:	b539                	j	646 <stbsp__real_to_str+0x4a4>
     83a:	64c2                	ld	s1,16(sp)
     83c:	6922                	ld	s2,8(sp)
     83e:	beb1                	j	39a <stbsp__real_to_str+0x1f8>
     840:	4959                	li	s2,22
     842:	bdf5                	j	73e <stbsp__real_to_str+0x59c>
     844:	e826                	sd	s1,16(sp)
     846:	e44a                	sd	s2,8(sp)
     848:	ecc00393          	li	t2,-308
     84c:	4eed                	li	t4,27
     84e:	4335                	li	t1,13
     850:	14600f13          	li	t5,326
     854:	b5cd                	j	736 <stbsp__real_to_str+0x594>
     856:	26900313          	li	t1,617
     85a:	0303083b          	mulw	a6,t1,a6
     85e:	41f8531b          	sraiw	t1,a6,0x1f
     862:	0153531b          	srliw	t1,t1,0x15
     866:	0103033b          	addw	t1,t1,a6
     86a:	40b3539b          	sraiw	t2,t1,0xb
     86e:	4849                	li	a6,18
     870:	4078083b          	subw	a6,a6,t2
     874:	b249                	j	1f6 <stbsp__real_to_str+0x54>

0000000000000876 <_in_char.part.0>:
static int _in_char(_InContext *ctx)
     876:	87aa                	mv	a5,a0
    if (ctx->fd == -1)
     878:	4508                	lw	a0,8(a0)
     87a:	577d                	li	a4,-1
     87c:	00e51d63          	bne	a0,a4,896 <_in_char.part.0+0x20>
        if (ctx->buf[ctx->pos] == '\0')
     880:	6b94                	ld	a3,16(a5)
     882:	6398                	ld	a4,0(a5)
     884:	9736                	add	a4,a4,a3
     886:	00074603          	lbu	a2,0(a4)
     88a:	c60d                	beqz	a2,8b4 <_in_char.part.0+0x3e>
        return (unsigned char)ctx->buf[ctx->pos++];
     88c:	0685                	addi	a3,a3,1
     88e:	eb94                	sd	a3,16(a5)
     890:	00074503          	lbu	a0,0(a4)
     894:	8082                	ret
static int _in_char(_InContext *ctx)
     896:	1101                	addi	sp,sp,-32
    if (read(ctx->fd, &c, 1) == 1)
     898:	4605                	li	a2,1
     89a:	00f10593          	addi	a1,sp,15
static int _in_char(_InContext *ctx)
     89e:	ec06                	sd	ra,24(sp)
    if (read(ctx->fd, &c, 1) == 1)
     8a0:	801ff0ef          	jal	a0 <read>
     8a4:	4785                	li	a5,1
     8a6:	00f51963          	bne	a0,a5,8b8 <_in_char.part.0+0x42>
        return (unsigned char)c;
     8aa:	00f14503          	lbu	a0,15(sp)
}
     8ae:	60e2                	ld	ra,24(sp)
     8b0:	6105                	addi	sp,sp,32
     8b2:	8082                	ret
            return -1;
     8b4:	557d                	li	a0,-1
}
     8b6:	8082                	ret
            return -1;
     8b8:	557d                	li	a0,-1
     8ba:	bfd5                	j	8ae <_in_char.part.0+0x38>

00000000000008bc <_skip_space>:
{
     8bc:	7139                	addi	sp,sp,-64
     8be:	f822                	sd	s0,48(sp)
     8c0:	f426                	sd	s1,40(sp)
     8c2:	f04a                	sd	s2,32(sp)
     8c4:	ec4e                	sd	s3,24(sp)
     8c6:	e852                	sd	s4,16(sp)
     8c8:	fc06                	sd	ra,56(sp)
     8ca:	842a                	mv	s0,a0
        ctx->ungotten = -1;
     8cc:	54fd                	li	s1,-1
    if (read(ctx->fd, &c, 1) == 1)
     8ce:	00f10a13          	addi	s4,sp,15
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     8d2:	02000913          	li	s2,32
     8d6:	4991                	li	s3,4
    if (ctx->ungotten >= 0)
     8d8:	4c1c                	lw	a5,24(s0)
     8da:	0407d163          	bgez	a5,91c <_skip_space+0x60>
    if (ctx->fd == -1)
     8de:	4408                	lw	a0,8(s0)
    if (read(ctx->fd, &c, 1) == 1)
     8e0:	4605                	li	a2,1
     8e2:	85d2                	mv	a1,s4
    if (ctx->fd == -1)
     8e4:	02951e63          	bne	a0,s1,920 <_skip_space+0x64>
        if (ctx->buf[ctx->pos] == '\0')
     8e8:	6818                	ld	a4,16(s0)
     8ea:	601c                	ld	a5,0(s0)
        return (unsigned char)ctx->buf[ctx->pos++];
     8ec:	00170693          	addi	a3,a4,1
        if (ctx->buf[ctx->pos] == '\0')
     8f0:	97ba                	add	a5,a5,a4
     8f2:	0007c703          	lbu	a4,0(a5) # 7000 <_stdout+0x1e0>
     8f6:	cb19                	beqz	a4,90c <_skip_space+0x50>
        return (unsigned char)ctx->buf[ctx->pos++];
     8f8:	e814                	sd	a3,16(s0)
     8fa:	0007c783          	lbu	a5,0(a5)
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     8fe:	ff77871b          	addiw	a4,a5,-9
     902:	fd278be3          	beq	a5,s2,8d8 <_skip_space+0x1c>
     906:	fce9f9e3          	bgeu	s3,a4,8d8 <_skip_space+0x1c>
        ctx->ungotten = c;
     90a:	cc1c                	sw	a5,24(s0)
}
     90c:	70e2                	ld	ra,56(sp)
     90e:	7442                	ld	s0,48(sp)
     910:	74a2                	ld	s1,40(sp)
     912:	7902                	ld	s2,32(sp)
     914:	69e2                	ld	s3,24(sp)
     916:	6a42                	ld	s4,16(sp)
     918:	6121                	addi	sp,sp,64
     91a:	8082                	ret
        ctx->ungotten = -1;
     91c:	cc04                	sw	s1,24(s0)
        return c;
     91e:	b7c5                	j	8fe <_skip_space+0x42>
    if (read(ctx->fd, &c, 1) == 1)
     920:	f80ff0ef          	jal	a0 <read>
     924:	4785                	li	a5,1
     926:	fef513e3          	bne	a0,a5,90c <_skip_space+0x50>
        return (unsigned char)c;
     92a:	00f14783          	lbu	a5,15(sp)
     92e:	bfc1                	j	8fe <_skip_space+0x42>

0000000000000930 <_vscanf_core.constprop.0>:
static int _vscanf_core(_InContext *ctx, const char *format, va_list ap)
     930:	7155                	addi	sp,sp,-208
     932:	e586                	sd	ra,200(sp)
     934:	e95a                	sd	s6,144(sp)
    while (*p)
     936:	0005c783          	lbu	a5,0(a1)
static int _vscanf_core(_InContext *ctx, const char *format, va_list ap)
     93a:	e432                	sd	a2,8(sp)
    while (*p)
     93c:	68078b63          	beqz	a5,fd2 <_vscanf_core.constprop.0+0x6a2>
     940:	e1a2                	sd	s0,192(sp)
     942:	fd26                	sd	s1,184(sp)
     944:	f152                	sd	s4,160(sp)
     946:	ed56                	sd	s5,152(sp)
     948:	f4ee                	sd	s11,104(sp)
     94a:	842e                	mv	s0,a1
     94c:	8daa                	mv	s11,a0
    int assigned = 0;
     94e:	4b01                	li	s6,0
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     950:	02000493          	li	s1,32
     954:	4a91                	li	s5,4
        if (*p != '%')
     956:	02500a13          	li	s4,37
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     95a:	04978763          	beq	a5,s1,9a8 <_vscanf_core.constprop.0+0x78>
     95e:	ff77869b          	addiw	a3,a5,-9
     962:	0ff6f693          	zext.b	a3,a3
     966:	04daf163          	bgeu	s5,a3,9a8 <_vscanf_core.constprop.0+0x78>
        if (*p != '%')
     96a:	07478d63          	beq	a5,s4,9e4 <_vscanf_core.constprop.0+0xb4>
            _skip_space(ctx);
     96e:	856e                	mv	a0,s11
     970:	f4dff0ef          	jal	8bc <_skip_space>
    if (ctx->ungotten >= 0)
     974:	018da503          	lw	a0,24(s11)
     978:	04055a63          	bgez	a0,9cc <_vscanf_core.constprop.0+0x9c>
     97c:	856e                	mv	a0,s11
     97e:	ef9ff0ef          	jal	876 <_in_char.part.0>
            if (c != *p)
     982:	00044783          	lbu	a5,0(s0)
     986:	04a78a63          	beq	a5,a0,9da <_vscanf_core.constprop.0+0xaa>
    if (c != -1)
     98a:	57fd                	li	a5,-1
     98c:	00f50463          	beq	a0,a5,994 <_vscanf_core.constprop.0+0x64>
        ctx->ungotten = c;
     990:	00adac23          	sw	a0,24(s11)
     994:	640e                	ld	s0,192(sp)
     996:	74ea                	ld	s1,184(sp)
     998:	7a0a                	ld	s4,160(sp)
     99a:	6aea                	ld	s5,152(sp)
     99c:	7da6                	ld	s11,104(sp)
}
     99e:	60ae                	ld	ra,200(sp)
     9a0:	855a                	mv	a0,s6
     9a2:	6b4a                	ld	s6,144(sp)
     9a4:	6169                	addi	sp,sp,208
     9a6:	8082                	ret
            _skip_space(ctx);
     9a8:	856e                	mv	a0,s11
     9aa:	f13ff0ef          	jal	8bc <_skip_space>
            while (isspace(*p))
     9ae:	00044783          	lbu	a5,0(s0)
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     9b2:	4611                	li	a2,4
     9b4:	ff77869b          	addiw	a3,a5,-9
     9b8:	0ff6f693          	zext.b	a3,a3
     9bc:	00978663          	beq	a5,s1,9c8 <_vscanf_core.constprop.0+0x98>
     9c0:	00d67463          	bgeu	a2,a3,9c8 <_vscanf_core.constprop.0+0x98>
    while (*p)
     9c4:	fbd9                	bnez	a5,95a <_vscanf_core.constprop.0+0x2a>
     9c6:	b7f9                	j	994 <_vscanf_core.constprop.0+0x64>
                p++;
     9c8:	0405                	addi	s0,s0,1
     9ca:	b7d5                	j	9ae <_vscanf_core.constprop.0+0x7e>
        ctx->ungotten = -1;
     9cc:	57fd                	li	a5,-1
     9ce:	00fdac23          	sw	a5,24(s11)
            if (c != *p)
     9d2:	00044783          	lbu	a5,0(s0)
     9d6:	faa79ae3          	bne	a5,a0,98a <_vscanf_core.constprop.0+0x5a>
    while (*p)
     9da:	00144783          	lbu	a5,1(s0)
            p++;
     9de:	0405                	addi	s0,s0,1
    while (*p)
     9e0:	ffad                	bnez	a5,95a <_vscanf_core.constprop.0+0x2a>
     9e2:	bf4d                	j	994 <_vscanf_core.constprop.0+0x64>
     9e4:	f94a                	sd	s2,176(sp)
     9e6:	f54e                	sd	s3,168(sp)
     9e8:	e55e                	sd	s7,136(sp)
     9ea:	e162                	sd	s8,128(sp)
        if (*p == '*')
     9ec:	00144583          	lbu	a1,1(s0)
     9f0:	02a00793          	li	a5,42
     9f4:	22f58d63          	beq	a1,a5,c2e <_vscanf_core.constprop.0+0x2fe>
        p++;
     9f8:	0405                	addi	s0,s0,1
        int suppress = 0;
     9fa:	4981                	li	s3,0
        while (*p >= '0' && *p <= '9')
     9fc:	fd05861b          	addiw	a2,a1,-48
     a00:	0ff67693          	zext.b	a3,a2
     a04:	47a5                	li	a5,9
     a06:	36d7e763          	bltu	a5,a3,d74 <_vscanf_core.constprop.0+0x444>
     a0a:	4781                	li	a5,0
     a0c:	4825                	li	a6,9
     a0e:	a019                	j	a14 <_vscanf_core.constprop.0+0xe4>
            width = width * 10 + (*p - '0');
     a10:	0016979b          	slliw	a5,a3,0x1
        while (*p >= '0' && *p <= '9')
     a14:	00144583          	lbu	a1,1(s0)
            width = width * 10 + (*p - '0');
     a18:	00f6093b          	addw	s2,a2,a5
     a1c:	0029169b          	slliw	a3,s2,0x2
        while (*p >= '0' && *p <= '9')
     a20:	fd05861b          	addiw	a2,a1,-48
     a24:	0ff67513          	zext.b	a0,a2
            width = width * 10 + (*p - '0');
     a28:	012686bb          	addw	a3,a3,s2
            p++;
     a2c:	0405                	addi	s0,s0,1
        while (*p >= '0' && *p <= '9')
     a2e:	fea871e3          	bgeu	a6,a0,a10 <_vscanf_core.constprop.0+0xe0>
        if (*p == 'l')
     a32:	06c00693          	li	a3,108
            p++;
     a36:	00140b93          	addi	s7,s0,1
        if (*p == 'l')
     a3a:	1ed58f63          	beq	a1,a3,c38 <_vscanf_core.constprop.0+0x308>
        else if (*p == 'h')
     a3e:	06800693          	li	a3,104
     a42:	2ad58863          	beq	a1,a3,cf2 <_vscanf_core.constprop.0+0x3c2>
        char spec = *p++;
     a46:	00044c03          	lbu	s8,0(s0)
     a4a:	8ba2                	mv	s7,s0
        int len_mod = 0;
     a4c:	ec02                	sd	zero,24(sp)
        char spec = *p++;
     a4e:	06300693          	li	a3,99
     a52:	001b8413          	addi	s0,s7,1
        if (!spec)
     a56:	2adc0863          	beq	s8,a3,d06 <_vscanf_core.constprop.0+0x3d6>
     a5a:	1f86fc63          	bgeu	a3,s8,c52 <_vscanf_core.constprop.0+0x322>
     a5e:	f9cc069b          	addiw	a3,s8,-100
     a62:	0ff6f693          	zext.b	a3,a3
     a66:	4651                	li	a2,20
     a68:	0cd66e63          	bltu	a2,a3,b44 <_vscanf_core.constprop.0+0x214>
     a6c:	00120637          	lui	a2,0x120
     a70:	4585                	li	a1,1
     a72:	00d595b3          	sll	a1,a1,a3
     a76:	02160613          	addi	a2,a2,33 # 120021 <_ZSt4cerr+0x118829>
     a7a:	8e6d                	and	a2,a2,a1
     a7c:	ee69                	bnez	a2,b56 <_vscanf_core.constprop.0+0x226>
     a7e:	89b9                	andi	a1,a1,14
     a80:	1e059263          	bnez	a1,c64 <_vscanf_core.constprop.0+0x334>
     a84:	463d                	li	a2,15
     a86:	0ac69f63          	bne	a3,a2,b44 <_vscanf_core.constprop.0+0x214>
            _skip_space(ctx);
     a8a:	856e                	mv	a0,s11
     a8c:	e31ff0ef          	jal	8bc <_skip_space>
            char *buf = suppress ? NULL : va_arg(ap, char *);
     a90:	ec02                	sd	zero,24(sp)
     a92:	00099763          	bnez	s3,aa0 <_vscanf_core.constprop.0+0x170>
     a96:	67a2                	ld	a5,8(sp)
     a98:	6398                	ld	a4,0(a5)
     a9a:	07a1                	addi	a5,a5,8
     a9c:	e43e                	sd	a5,8(sp)
     a9e:	ec3a                	sd	a4,24(sp)
    if (ctx->ungotten >= 0)
     aa0:	018da503          	lw	a0,24(s11)
     aa4:	2e055b63          	bgez	a0,d9a <_vscanf_core.constprop.0+0x46a>
     aa8:	856e                	mv	a0,s11
     aaa:	dcdff0ef          	jal	876 <_in_char.part.0>
            while (c != -1 && !isspace(c))
     aae:	56fd                	li	a3,-1
     ab0:	6ad50363          	beq	a0,a3,1156 <_vscanf_core.constprop.0+0x826>
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     ab4:	02000693          	li	a3,32
     ab8:	3ed50963          	beq	a0,a3,eaa <_vscanf_core.constprop.0+0x57a>
     abc:	46a5                	li	a3,9
     abe:	3ed50663          	beq	a0,a3,eaa <_vscanf_core.constprop.0+0x57a>
     ac2:	46a9                	li	a3,10
     ac4:	3ed50363          	beq	a0,a3,eaa <_vscanf_core.constprop.0+0x57a>
     ac8:	46ad                	li	a3,11
     aca:	3ed50063          	beq	a0,a3,eaa <_vscanf_core.constprop.0+0x57a>
     ace:	46b1                	li	a3,12
     ad0:	3cd50d63          	beq	a0,a3,eaa <_vscanf_core.constprop.0+0x57a>
     ad4:	46b5                	li	a3,13
     ad6:	3cd50a63          	beq	a0,a3,eaa <_vscanf_core.constprop.0+0x57a>
     ada:	67e2                	ld	a5,24(sp)
     adc:	fce6                	sd	s9,120(sp)
     ade:	f8ea                	sd	s10,112(sp)
     ae0:	e83e                	sd	a5,16(sp)
     ae2:	4d01                	li	s10,0
            while (c != -1 && !isspace(c))
     ae4:	5c7d                	li	s8,-1
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     ae6:	02000c93          	li	s9,32
                if (width > 0 && i >= width)
     aea:	01205463          	blez	s2,af2 <_vscanf_core.constprop.0+0x1c2>
     aee:	052d5563          	bge	s10,s2,b38 <_vscanf_core.constprop.0+0x208>
                if (!suppress)
     af2:	00099563          	bnez	s3,afc <_vscanf_core.constprop.0+0x1cc>
                    buf[i] = (char)c;
     af6:	67c2                	ld	a5,16(sp)
     af8:	00a78023          	sb	a0,0(a5)
    if (ctx->ungotten >= 0)
     afc:	018da503          	lw	a0,24(s11)
                i++;
     b00:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
     b02:	30055963          	bgez	a0,e14 <_vscanf_core.constprop.0+0x4e4>
     b06:	856e                	mv	a0,s11
     b08:	d6fff0ef          	jal	876 <_in_char.part.0>
            while (c != -1 && !isspace(c))
     b0c:	27850663          	beq	a0,s8,d78 <_vscanf_core.constprop.0+0x448>
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     b10:	03950463          	beq	a0,s9,b38 <_vscanf_core.constprop.0+0x208>
     b14:	47a5                	li	a5,9
     b16:	02f50163          	beq	a0,a5,b38 <_vscanf_core.constprop.0+0x208>
     b1a:	47a9                	li	a5,10
     b1c:	00f50e63          	beq	a0,a5,b38 <_vscanf_core.constprop.0+0x208>
     b20:	47ad                	li	a5,11
     b22:	00f50b63          	beq	a0,a5,b38 <_vscanf_core.constprop.0+0x208>
     b26:	47b1                	li	a5,12
     b28:	00f50863          	beq	a0,a5,b38 <_vscanf_core.constprop.0+0x208>
     b2c:	67c2                	ld	a5,16(sp)
     b2e:	0785                	addi	a5,a5,1
     b30:	e83e                	sd	a5,16(sp)
     b32:	47b5                	li	a5,13
     b34:	faf51be3          	bne	a0,a5,aea <_vscanf_core.constprop.0+0x1ba>
            if (!suppress)
     b38:	64098a63          	beqz	s3,118c <_vscanf_core.constprop.0+0x85c>
     b3c:	7ce6                	ld	s9,120(sp)
     b3e:	7d46                	ld	s10,112(sp)
        ctx->ungotten = c;
     b40:	00adac23          	sw	a0,24(s11)
    while (*p)
     b44:	001bc783          	lbu	a5,1(s7)
     b48:	794a                	ld	s2,176(sp)
     b4a:	79aa                	ld	s3,168(sp)
     b4c:	6baa                	ld	s7,136(sp)
     b4e:	6c0a                	ld	s8,128(sp)
     b50:	e00795e3          	bnez	a5,95a <_vscanf_core.constprop.0+0x2a>
     b54:	b581                	j	994 <_vscanf_core.constprop.0+0x64>
            _skip_space(ctx);
     b56:	856e                	mv	a0,s11
     b58:	f8ea                	sd	s10,112(sp)
     b5a:	d63ff0ef          	jal	8bc <_skip_space>
    if (ctx->ungotten >= 0)
     b5e:	018da503          	lw	a0,24(s11)
     b62:	24055063          	bgez	a0,da2 <_vscanf_core.constprop.0+0x472>
     b66:	856e                	mv	a0,s11
     b68:	d0fff0ef          	jal	876 <_in_char.part.0>
            if (c == '-' || c == '+')
     b6c:	fd55069b          	addiw	a3,a0,-43
     b70:	9af5                	andi	a3,a3,-3
     b72:	2681                	sext.w	a3,a3
            int i = 0, c = _in_char(ctx);
     b74:	4d01                	li	s10,0
            if (c == '-' || c == '+')
     b76:	3e068863          	beqz	a3,f66 <_vscanf_core.constprop.0+0x636>
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
     b7a:	07800693          	li	a3,120
     b7e:	4641                	li	a2,16
     b80:	00dc0863          	beq	s8,a3,b90 <_vscanf_core.constprop.0+0x260>
     b84:	06900693          	li	a3,105
     b88:	4629                	li	a2,10
     b8a:	00dc1363          	bne	s8,a3,b90 <_vscanf_core.constprop.0+0x260>
     b8e:	4601                	li	a2,0
            while (c != -1 && i < 63)
     b90:	56fd                	li	a3,-1
     b92:	5cd50863          	beq	a0,a3,1162 <_vscanf_core.constprop.0+0x832>
     b96:	fce6                	sd	s9,120(sp)
     b98:	02010893          	addi	a7,sp,32
     b9c:	01a88c33          	add	s8,a7,s10
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     ba0:	4cc1                	li	s9,16
                int digit = (c >= '0' && c <= '9');
     ba2:	fd05069b          	addiw	a3,a0,-48
     ba6:	0005031b          	sext.w	t1,a0
     baa:	00a6b593          	sltiu	a1,a3,10
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     bae:	27960a63          	beq	a2,s9,e22 <_vscanf_core.constprop.0+0x4f2>
     bb2:	2a060d63          	beqz	a2,e6c <_vscanf_core.constprop.0+0x53c>
                int x = (c == 'x' || c == 'X');
     bb6:	07800793          	li	a5,120
     bba:	2ef50363          	beq	a0,a5,ea0 <_vscanf_core.constprop.0+0x570>
     bbe:	fa850693          	addi	a3,a0,-88
     bc2:	0016b693          	seqz	a3,a3
     bc6:	4301                	li	t1,0
                if (width > 0 && i >= width)
     bc8:	01205463          	blez	s2,bd0 <_vscanf_core.constprop.0+0x2a0>
     bcc:	032d5a63          	bge	s10,s2,c00 <_vscanf_core.constprop.0+0x2d0>
                if (digit || hex || x)
     bd0:	0066e6b3          	or	a3,a3,t1
     bd4:	8ecd                	or	a3,a3,a1
     bd6:	c68d                	beqz	a3,c00 <_vscanf_core.constprop.0+0x2d0>
                    num_buf[i++] = (char)c;
     bd8:	00ac0023          	sb	a0,0(s8)
    if (ctx->ungotten >= 0)
     bdc:	018da503          	lw	a0,24(s11)
                    num_buf[i++] = (char)c;
     be0:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
     be2:	22055c63          	bgez	a0,e1a <_vscanf_core.constprop.0+0x4ea>
     be6:	856e                	mv	a0,s11
     be8:	e832                	sd	a2,16(sp)
     bea:	c8dff0ef          	jal	876 <_in_char.part.0>
            while (c != -1 && i < 63)
     bee:	57fd                	li	a5,-1
     bf0:	6642                	ld	a2,16(sp)
     bf2:	3cf50263          	beq	a0,a5,fb6 <_vscanf_core.constprop.0+0x686>
     bf6:	03f00693          	li	a3,63
     bfa:	0c05                	addi	s8,s8,1
     bfc:	fadd13e3          	bne	s10,a3,ba2 <_vscanf_core.constprop.0+0x272>
            num_buf[i] = '\0';
     c00:	040d0793          	addi	a5,s10,64
     c04:	1018                	addi	a4,sp,32
     c06:	97ba                	add	a5,a5,a4
     c08:	fc078023          	sb	zero,-64(a5)
        ctx->ungotten = c;
     c0c:	00adac23          	sw	a0,24(s11)
     c10:	7ce6                	ld	s9,120(sp)
            if (i == 0)
     c12:	1e0d0663          	beqz	s10,dfe <_vscanf_core.constprop.0+0x4ce>
            if (!suppress)
     c16:	36098363          	beqz	s3,f7c <_vscanf_core.constprop.0+0x64c>
    while (*p)
     c1a:	001bc783          	lbu	a5,1(s7)
        {
     c1e:	794a                	ld	s2,176(sp)
     c20:	79aa                	ld	s3,168(sp)
     c22:	6baa                	ld	s7,136(sp)
     c24:	6c0a                	ld	s8,128(sp)
     c26:	7d46                	ld	s10,112(sp)
    while (*p)
     c28:	d20799e3          	bnez	a5,95a <_vscanf_core.constprop.0+0x2a>
     c2c:	b3a5                	j	994 <_vscanf_core.constprop.0+0x64>
        while (*p >= '0' && *p <= '9')
     c2e:	00244583          	lbu	a1,2(s0)
            suppress = 1;
     c32:	4985                	li	s3,1
            p++;
     c34:	0409                	addi	s0,s0,2
     c36:	b3d9                	j	9fc <_vscanf_core.constprop.0+0xcc>
            if (*p == 'l')
     c38:	00144c03          	lbu	s8,1(s0)
            len_mod = 1;
     c3c:	4785                	li	a5,1
     c3e:	ec3e                	sd	a5,24(sp)
            if (*p == 'l')
     c40:	e0bc17e3          	bne	s8,a1,a4e <_vscanf_core.constprop.0+0x11e>
                len_mod = 2;
     c44:	4789                	li	a5,2
        char spec = *p++;
     c46:	00244c03          	lbu	s8,2(s0)
                p++;
     c4a:	00240b93          	addi	s7,s0,2
                len_mod = 2;
     c4e:	ec3e                	sd	a5,24(sp)
     c50:	bbfd                	j	a4e <_vscanf_core.constprop.0+0x11e>
     c52:	100c0763          	beqz	s8,d60 <_vscanf_core.constprop.0+0x430>
     c56:	fbbc079b          	addiw	a5,s8,-69
     c5a:	0ff7f793          	zext.b	a5,a5
     c5e:	4689                	li	a3,2
     c60:	eef6e2e3          	bltu	a3,a5,b44 <_vscanf_core.constprop.0+0x214>
            _skip_space(ctx);
     c64:	856e                	mv	a0,s11
     c66:	f8ea                	sd	s10,112(sp)
     c68:	c55ff0ef          	jal	8bc <_skip_space>
    if (ctx->ungotten >= 0)
     c6c:	018da783          	lw	a5,24(s11)
     c70:	1207dd63          	bgez	a5,daa <_vscanf_core.constprop.0+0x47a>
     c74:	856e                	mv	a0,s11
     c76:	c01ff0ef          	jal	876 <_in_char.part.0>
            if (c == '-' || c == '+')
     c7a:	fd55069b          	addiw	a3,a0,-43
     c7e:	ffd6f613          	andi	a2,a3,-3
     c82:	2601                	sext.w	a2,a2
     c84:	87aa                	mv	a5,a0
     c86:	12060c63          	beqz	a2,dbe <_vscanf_core.constprop.0+0x48e>
            while (c != -1 && i < 63)
     c8a:	567d                	li	a2,-1
     c8c:	16c50963          	beq	a0,a2,dfe <_vscanf_core.constprop.0+0x4ce>
     c90:	fce6                	sd	s9,120(sp)
            int i = 0, c = _in_char(ctx);
     c92:	4d01                	li	s10,0
     c94:	80000937          	lui	s2,0x80000
     c98:	197d                	addi	s2,s2,-1 # ffffffff7fffffff <_ZSt4cerr+0xffffffff7fff8807>
     c9a:	0932                	slli	s2,s2,0xc
     c9c:	80194913          	xori	s2,s2,-2047
     ca0:	093e                	slli	s2,s2,0xf
     ca2:	02010813          	addi	a6,sp,32
     ca6:	01a80cb3          	add	s9,a6,s10
     caa:	03a00c13          	li	s8,58
     cae:	1935                	addi	s2,s2,-19
     cb0:	a831                	j	ccc <_vscanf_core.constprop.0+0x39c>
     cb2:	bc5ff0ef          	jal	876 <_in_char.part.0>
            while (c != -1 && i < 63)
     cb6:	577d                	li	a4,-1
     cb8:	87aa                	mv	a5,a0
     cba:	2ee50563          	beq	a0,a4,fa4 <_vscanf_core.constprop.0+0x674>
     cbe:	03f00713          	li	a4,63
     cc2:	0c85                	addi	s9,s9,1
     cc4:	1eed0e63          	beq	s10,a4,ec0 <_vscanf_core.constprop.0+0x590>
     cc8:	fd57869b          	addiw	a3,a5,-43
        int c = ctx->ungotten;
     ccc:	00d95633          	srl	a2,s2,a3
     cd0:	856e                	mv	a0,s11
     cd2:	8a05                	andi	a2,a2,1
     cd4:	1edc6663          	bltu	s8,a3,ec0 <_vscanf_core.constprop.0+0x590>
     cd8:	1e060463          	beqz	a2,ec0 <_vscanf_core.constprop.0+0x590>
                    num_buf[i++] = (char)c;
     cdc:	00fc8023          	sb	a5,0(s9)
    if (ctx->ungotten >= 0)
     ce0:	018da783          	lw	a5,24(s11)
                    num_buf[i++] = (char)c;
     ce4:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
     ce6:	fc07c6e3          	bltz	a5,cb2 <_vscanf_core.constprop.0+0x382>
        ctx->ungotten = -1;
     cea:	577d                	li	a4,-1
     cec:	00edac23          	sw	a4,24(s11)
            while (c != -1 && i < 63)
     cf0:	b7f9                	j	cbe <_vscanf_core.constprop.0+0x38e>
            if (*p == 'h')
     cf2:	00144c03          	lbu	s8,1(s0)
        int len_mod = 0;
     cf6:	ec02                	sd	zero,24(sp)
            if (*p == 'h')
     cf8:	d4bc1be3          	bne	s8,a1,a4e <_vscanf_core.constprop.0+0x11e>
        char spec = *p++;
     cfc:	00244c03          	lbu	s8,2(s0)
                p++;
     d00:	00240b93          	addi	s7,s0,2
     d04:	b3a9                	j	a4e <_vscanf_core.constprop.0+0x11e>
     d06:	fce6                	sd	s9,120(sp)
     d08:	f8ea                	sd	s10,112(sp)
            int count = (width > 0) ? width : 1;
     d0a:	00090c1b          	sext.w	s8,s2
     d0e:	0d205a63          	blez	s2,de2 <_vscanf_core.constprop.0+0x4b2>
            char *buf = suppress ? NULL : va_arg(ap, char *);
     d12:	4d01                	li	s10,0
     d14:	06098d63          	beqz	s3,d8e <_vscanf_core.constprop.0+0x45e>
            for (int i = 0; i < count; i++)
     d18:	9c6a                	add	s8,s8,s10
                if (c == -1)
     d1a:	5cfd                	li	s9,-1
    if (ctx->ungotten >= 0)
     d1c:	018da783          	lw	a5,24(s11)
        ctx->ungotten = -1;
     d20:	856e                	mv	a0,s11
    if (ctx->ungotten >= 0)
     d22:	0207dc63          	bgez	a5,d5a <_vscanf_core.constprop.0+0x42a>
     d26:	b51ff0ef          	jal	876 <_in_char.part.0>
     d2a:	87aa                	mv	a5,a0
                if (c == -1)
     d2c:	0b950d63          	beq	a0,s9,de6 <_vscanf_core.constprop.0+0x4b6>
                if (!suppress)
     d30:	00099463          	bnez	s3,d38 <_vscanf_core.constprop.0+0x408>
                    buf[i] = (char)c;
     d34:	00fd0023          	sb	a5,0(s10)
            for (int i = 0; i < count; i++)
     d38:	0d05                	addi	s10,s10,1
     d3a:	ffac11e3          	bne	s8,s10,d1c <_vscanf_core.constprop.0+0x3ec>
    while (*p)
     d3e:	001bc783          	lbu	a5,1(s7)
            if (!suppress)
     d42:	00099363          	bnez	s3,d48 <_vscanf_core.constprop.0+0x418>
                assigned++;
     d46:	2b05                	addiw	s6,s6,1
     d48:	794a                	ld	s2,176(sp)
     d4a:	79aa                	ld	s3,168(sp)
     d4c:	6baa                	ld	s7,136(sp)
     d4e:	6c0a                	ld	s8,128(sp)
     d50:	7ce6                	ld	s9,120(sp)
     d52:	7d46                	ld	s10,112(sp)
    while (*p)
     d54:	c00793e3          	bnez	a5,95a <_vscanf_core.constprop.0+0x2a>
     d58:	b935                	j	994 <_vscanf_core.constprop.0+0x64>
        ctx->ungotten = -1;
     d5a:	019dac23          	sw	s9,24(s11)
                if (c == -1)
     d5e:	bfc9                	j	d30 <_vscanf_core.constprop.0+0x400>
     d60:	640e                	ld	s0,192(sp)
     d62:	74ea                	ld	s1,184(sp)
     d64:	794a                	ld	s2,176(sp)
     d66:	79aa                	ld	s3,168(sp)
     d68:	7a0a                	ld	s4,160(sp)
     d6a:	6aea                	ld	s5,152(sp)
     d6c:	6baa                	ld	s7,136(sp)
     d6e:	6c0a                	ld	s8,128(sp)
     d70:	7da6                	ld	s11,104(sp)
     d72:	b135                	j	99e <_vscanf_core.constprop.0+0x6e>
        int width = -1;
     d74:	597d                	li	s2,-1
     d76:	b975                	j	a32 <_vscanf_core.constprop.0+0x102>
            if (!suppress)
     d78:	3c099c63          	bnez	s3,1150 <_vscanf_core.constprop.0+0x820>
                buf[i] = '\0';
     d7c:	67e2                	ld	a5,24(sp)
     d7e:	01a786b3          	add	a3,a5,s10
     d82:	00068023          	sb	zero,0(a3)
    while (*p)
     d86:	001bc783          	lbu	a5,1(s7)
                assigned++;
     d8a:	2b05                	addiw	s6,s6,1
     d8c:	bf75                	j	d48 <_vscanf_core.constprop.0+0x418>
            char *buf = suppress ? NULL : va_arg(ap, char *);
     d8e:	67a2                	ld	a5,8(sp)
     d90:	0007bd03          	ld	s10,0(a5)
     d94:	07a1                	addi	a5,a5,8
     d96:	e43e                	sd	a5,8(sp)
     d98:	b741                	j	d18 <_vscanf_core.constprop.0+0x3e8>
        ctx->ungotten = -1;
     d9a:	56fd                	li	a3,-1
     d9c:	00ddac23          	sw	a3,24(s11)
            while (c != -1 && !isspace(c))
     da0:	bb11                	j	ab4 <_vscanf_core.constprop.0+0x184>
        ctx->ungotten = -1;
     da2:	56fd                	li	a3,-1
     da4:	00ddac23          	sw	a3,24(s11)
        return c;
     da8:	b3d1                	j	b6c <_vscanf_core.constprop.0+0x23c>
            if (c == '-' || c == '+')
     daa:	fd57869b          	addiw	a3,a5,-43
     dae:	ffd6f613          	andi	a2,a3,-3
        ctx->ungotten = -1;
     db2:	55fd                	li	a1,-1
     db4:	00bdac23          	sw	a1,24(s11)
            if (c == '-' || c == '+')
     db8:	2601                	sext.w	a2,a2
     dba:	ec061be3          	bnez	a2,c90 <_vscanf_core.constprop.0+0x360>
                num_buf[i++] = (char)c;
     dbe:	02f10023          	sb	a5,32(sp)
    if (ctx->ungotten >= 0)
     dc2:	018da783          	lw	a5,24(s11)
     dc6:	2207da63          	bgez	a5,ffa <_vscanf_core.constprop.0+0x6ca>
     dca:	856e                	mv	a0,s11
     dcc:	aabff0ef          	jal	876 <_in_char.part.0>
            while (c != -1 && i < 63)
     dd0:	567d                	li	a2,-1
     dd2:	87aa                	mv	a5,a0
                num_buf[i++] = (char)c;
     dd4:	4d05                	li	s10,1
     dd6:	fd55069b          	addiw	a3,a0,-43
            while (c != -1 && i < 63)
     dda:	3ac50163          	beq	a0,a2,117c <_vscanf_core.constprop.0+0x84c>
     dde:	fce6                	sd	s9,120(sp)
     de0:	bd55                	j	c94 <_vscanf_core.constprop.0+0x364>
            int count = (width > 0) ? width : 1;
     de2:	4c05                	li	s8,1
     de4:	b73d                	j	d12 <_vscanf_core.constprop.0+0x3e2>
     de6:	640e                	ld	s0,192(sp)
     de8:	74ea                	ld	s1,184(sp)
     dea:	794a                	ld	s2,176(sp)
     dec:	79aa                	ld	s3,168(sp)
     dee:	7a0a                	ld	s4,160(sp)
     df0:	6aea                	ld	s5,152(sp)
     df2:	6baa                	ld	s7,136(sp)
     df4:	6c0a                	ld	s8,128(sp)
     df6:	7ce6                	ld	s9,120(sp)
     df8:	7d46                	ld	s10,112(sp)
     dfa:	7da6                	ld	s11,104(sp)
     dfc:	b64d                	j	99e <_vscanf_core.constprop.0+0x6e>
     dfe:	640e                	ld	s0,192(sp)
     e00:	74ea                	ld	s1,184(sp)
     e02:	794a                	ld	s2,176(sp)
     e04:	79aa                	ld	s3,168(sp)
     e06:	7a0a                	ld	s4,160(sp)
     e08:	6aea                	ld	s5,152(sp)
     e0a:	6baa                	ld	s7,136(sp)
     e0c:	6c0a                	ld	s8,128(sp)
     e0e:	7d46                	ld	s10,112(sp)
     e10:	7da6                	ld	s11,104(sp)
     e12:	b671                	j	99e <_vscanf_core.constprop.0+0x6e>
        ctx->ungotten = -1;
     e14:	018dac23          	sw	s8,24(s11)
            while (c != -1 && !isspace(c))
     e18:	b9e5                	j	b10 <_vscanf_core.constprop.0+0x1e0>
        ctx->ungotten = -1;
     e1a:	57fd                	li	a5,-1
     e1c:	00fdac23          	sw	a5,24(s11)
            while (c != -1 && i < 63)
     e20:	bbd9                	j	bf6 <_vscanf_core.constprop.0+0x2c6>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     e22:	f9f3069b          	addiw	a3,t1,-97
     e26:	4795                	li	a5,5
     e28:	06d7f263          	bgeu	a5,a3,e8c <_vscanf_core.constprop.0+0x55c>
     e2c:	fbf3031b          	addiw	t1,t1,-65
     e30:	4795                	li	a5,5
     e32:	0467fd63          	bgeu	a5,t1,e8c <_vscanf_core.constprop.0+0x55c>
                int x = (c == 'x' || c == 'X');
     e36:	07800693          	li	a3,120
     e3a:	18d50763          	beq	a0,a3,fc8 <_vscanf_core.constprop.0+0x698>
     e3e:	fa850693          	addi	a3,a0,-88
     e42:	0016b693          	seqz	a3,a3
                if (base == 0 && i == 1 && num_buf[0] == '0' && x)
     e46:	4301                	li	t1,0
     e48:	32061663          	bnez	a2,1174 <_vscanf_core.constprop.0+0x844>
     e4c:	4785                	li	a5,1
     e4e:	4601                	li	a2,0
     e50:	d6fd1ce3          	bne	s10,a5,bc8 <_vscanf_core.constprop.0+0x298>
     e54:	02014e03          	lbu	t3,32(sp)
     e58:	03000793          	li	a5,48
     e5c:	d6fe16e3          	bne	t3,a5,bc8 <_vscanf_core.constprop.0+0x298>
     e60:	d60684e3          	beqz	a3,bc8 <_vscanf_core.constprop.0+0x298>
                    base = 16;
     e64:	4641                	li	a2,16
                if (width > 0 && i >= width)
     e66:	d7a919e3          	bne	s2,s10,bd8 <_vscanf_core.constprop.0+0x2a8>
     e6a:	bb59                	j	c00 <_vscanf_core.constprop.0+0x2d0>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     e6c:	f9f3069b          	addiw	a3,t1,-97
     e70:	4795                	li	a5,5
     e72:	02d7f263          	bgeu	a5,a3,e96 <_vscanf_core.constprop.0+0x566>
     e76:	fbf3031b          	addiw	t1,t1,-65
     e7a:	0467f063          	bgeu	a5,t1,eba <_vscanf_core.constprop.0+0x58a>
                int x = (c == 'x' || c == 'X');
     e7e:	07800693          	li	a3,120
     e82:	fad51ee3          	bne	a0,a3,e3e <_vscanf_core.constprop.0+0x50e>
     e86:	4301                	li	t1,0
     e88:	4685                	li	a3,1
     e8a:	b7c9                	j	e4c <_vscanf_core.constprop.0+0x51c>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     e8c:	4305                	li	t1,1
                int x = (c == 'x' || c == 'X');
     e8e:	4681                	li	a3,0
                if (width > 0 && i >= width)
     e90:	d3204ee3          	bgtz	s2,bcc <_vscanf_core.constprop.0+0x29c>
     e94:	bb35                	j	bd0 <_vscanf_core.constprop.0+0x2a0>
                int x = (c == 'x' || c == 'X');
     e96:	4681                	li	a3,0
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     e98:	4305                	li	t1,1
                if (width > 0 && i >= width)
     e9a:	d32049e3          	bgtz	s2,bcc <_vscanf_core.constprop.0+0x29c>
     e9e:	bb0d                	j	bd0 <_vscanf_core.constprop.0+0x2a0>
     ea0:	4301                	li	t1,0
                int x = (c == 'x' || c == 'X');
     ea2:	4685                	li	a3,1
                if (width > 0 && i >= width)
     ea4:	d32044e3          	bgtz	s2,bcc <_vscanf_core.constprop.0+0x29c>
     ea8:	bb05                	j	bd8 <_vscanf_core.constprop.0+0x2a8>
            if (!suppress)
     eaa:	c8099be3          	bnez	s3,b40 <_vscanf_core.constprop.0+0x210>
                buf[i] = '\0';
     eae:	67e2                	ld	a5,24(sp)
     eb0:	00078023          	sb	zero,0(a5)
        ctx->ungotten = c;
     eb4:	00adac23          	sw	a0,24(s11)
            if (i > 0 && !suppress)
     eb8:	b171                	j	b44 <_vscanf_core.constprop.0+0x214>
                int x = (c == 'x' || c == 'X');
     eba:	4681                	li	a3,0
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     ebc:	4305                	li	t1,1
     ebe:	b779                	j	e4c <_vscanf_core.constprop.0+0x51c>
            num_buf[i] = '\0';
     ec0:	040d0713          	addi	a4,s10,64
     ec4:	1014                	addi	a3,sp,32
     ec6:	96ba                	add	a3,a3,a4
     ec8:	fc068023          	sb	zero,-64(a3)
        ctx->ungotten = c;
     ecc:	00fdac23          	sw	a5,24(s11)
            if (i == 0)
     ed0:	f00d0be3          	beqz	s10,de6 <_vscanf_core.constprop.0+0x4b6>
     ed4:	7ce6                	ld	s9,120(sp)
            if (!suppress)
     ed6:	d40992e3          	bnez	s3,c1a <_vscanf_core.constprop.0+0x2ea>
    if (*str == '-')
     eda:	02014603          	lbu	a2,32(sp)
     ede:	02d00793          	li	a5,45
     ee2:	1af60963          	beq	a2,a5,1094 <_vscanf_core.constprop.0+0x764>
    else if (*str == '+')
     ee6:	02b00793          	li	a5,43
     eea:	20f60a63          	beq	a2,a5,10fe <_vscanf_core.constprop.0+0x7ce>
     eee:	00005797          	auipc	a5,0x5
     ef2:	8e27b587          	fld	fa1,-1822(a5) # 57d0 <STDIN_FD+0x10>
     ef6:	101c                	addi	a5,sp,32
    while (*str >= '0' && *str <= '9')
     ef8:	fd06069b          	addiw	a3,a2,-48
     efc:	0ff6f513          	zext.b	a0,a3
     f00:	45a5                	li	a1,9
     f02:	f20007d3          	fmv.d.x	fa5,zero
     f06:	02a5e463          	bltu	a1,a0,f2e <_vscanf_core.constprop.0+0x5fe>
     f0a:	00005717          	auipc	a4,0x5
     f0e:	8ce73707          	fld	fa4,-1842(a4) # 57d8 <STDIN_FD+0x18>
     f12:	4525                	li	a0,9
     f14:	0017c603          	lbu	a2,1(a5)
        val = val * 10.0 + (*str - '0');
     f18:	d20686d3          	fcvt.d.w	fa3,a3
        str++;
     f1c:	0785                	addi	a5,a5,1
    while (*str >= '0' && *str <= '9')
     f1e:	fd06069b          	addiw	a3,a2,-48
     f22:	0ff6f593          	zext.b	a1,a3
        val = val * 10.0 + (*str - '0');
     f26:	6ae7f7c3          	fmadd.d	fa5,fa5,fa4,fa3
    while (*str >= '0' && *str <= '9')
     f2a:	feb575e3          	bgeu	a0,a1,f14 <_vscanf_core.constprop.0+0x5e4>
    if (*str == '.')
     f2e:	02e00693          	li	a3,46
     f32:	16d60a63          	beq	a2,a3,10a6 <_vscanf_core.constprop.0+0x776>
    if (*str == 'e' || *str == 'E')
     f36:	0007c683          	lbu	a3,0(a5)
     f3a:	0df6f693          	andi	a3,a3,223
     f3e:	04500613          	li	a2,69
     f42:	0cc68463          	beq	a3,a2,100a <_vscanf_core.constprop.0+0x6da>
                    *va_arg(ap, double *) = val;
     f46:	6722                	ld	a4,8(sp)
                if (len_mod == 1)
     f48:	4685                	li	a3,1
    return sign * val;
     f4a:	12b7f7d3          	fmul.d	fa5,fa5,fa1
                    *va_arg(ap, double *) = val;
     f4e:	631c                	ld	a5,0(a4)
                    *va_arg(ap, int64 *) = val;
     f50:	0721                	addi	a4,a4,8
     f52:	e43a                	sd	a4,8(sp)
                if (len_mod == 1)
     f54:	6762                	ld	a4,24(sp)
     f56:	18d70b63          	beq	a4,a3,10ec <_vscanf_core.constprop.0+0x7bc>
                    *va_arg(ap, float *) = (float)val;
     f5a:	4017f7d3          	fcvt.s.d	fa5,fa5
                assigned++;
     f5e:	2b05                	addiw	s6,s6,1
                    *va_arg(ap, float *) = (float)val;
     f60:	00f7a027          	fsw	fa5,0(a5)
     f64:	b95d                	j	c1a <_vscanf_core.constprop.0+0x2ea>
                num_buf[i++] = (char)c;
     f66:	02a10023          	sb	a0,32(sp)
    if (ctx->ungotten >= 0)
     f6a:	018da503          	lw	a0,24(s11)
     f6e:	06055463          	bgez	a0,fd6 <_vscanf_core.constprop.0+0x6a6>
     f72:	856e                	mv	a0,s11
     f74:	903ff0ef          	jal	876 <_in_char.part.0>
                num_buf[i++] = (char)c;
     f78:	4d05                	li	s10,1
     f7a:	b101                	j	b7a <_vscanf_core.constprop.0+0x24a>
                int64 val = strtoll(num_buf, NULL, base);
     f7c:	4581                	li	a1,0
     f7e:	1008                	addi	a0,sp,32
     f80:	696030ef          	jal	4616 <strtoll>
                    *va_arg(ap, int64 *) = val;
     f84:	67a2                	ld	a5,8(sp)
                if (len_mod == 2)
     f86:	6762                	ld	a4,24(sp)
     f88:	4689                	li	a3,2
                    *va_arg(ap, int64 *) = val;
     f8a:	07a1                	addi	a5,a5,8
                if (len_mod == 2)
     f8c:	16d70363          	beq	a4,a3,10f2 <_vscanf_core.constprop.0+0x7c2>
                    *va_arg(ap, int64 *) = val;
     f90:	6722                	ld	a4,8(sp)
                else if (len_mod == 1)
     f92:	4605                	li	a2,1
                    *va_arg(ap, int64 *) = val;
     f94:	6314                	ld	a3,0(a4)
                else if (len_mod == 1)
     f96:	6762                	ld	a4,24(sp)
     f98:	16c70163          	beq	a4,a2,10fa <_vscanf_core.constprop.0+0x7ca>
                    *va_arg(ap, int *) = (int)val;
     f9c:	c288                	sw	a0,0(a3)
                assigned++;
     f9e:	2b05                	addiw	s6,s6,1
     fa0:	e43e                	sd	a5,8(sp)
     fa2:	b9a5                	j	c1a <_vscanf_core.constprop.0+0x2ea>
            num_buf[i] = '\0';
     fa4:	040d0793          	addi	a5,s10,64
     fa8:	1018                	addi	a4,sp,32
     faa:	00e785b3          	add	a1,a5,a4
     fae:	fc058023          	sb	zero,-64(a1)
            if (i == 0)
     fb2:	7ce6                	ld	s9,120(sp)
     fb4:	b70d                	j	ed6 <_vscanf_core.constprop.0+0x5a6>
            num_buf[i] = '\0';
     fb6:	040d0793          	addi	a5,s10,64
     fba:	1018                	addi	a4,sp,32
     fbc:	00e78833          	add	a6,a5,a4
     fc0:	fc080023          	sb	zero,-64(a6)
            if (i == 0)
     fc4:	7ce6                	ld	s9,120(sp)
     fc6:	b981                	j	c16 <_vscanf_core.constprop.0+0x2e6>
                int x = (c == 'x' || c == 'X');
     fc8:	4301                	li	t1,0
     fca:	4685                	li	a3,1
                if (width > 0 && i >= width)
     fcc:	c12040e3          	bgtz	s2,bcc <_vscanf_core.constprop.0+0x29c>
     fd0:	b101                	j	bd0 <_vscanf_core.constprop.0+0x2a0>
    int assigned = 0;
     fd2:	4b01                	li	s6,0
     fd4:	b2e9                	j	99e <_vscanf_core.constprop.0+0x6e>
        ctx->ungotten = -1;
     fd6:	56fd                	li	a3,-1
     fd8:	fce6                	sd	s9,120(sp)
     fda:	00ddac23          	sw	a3,24(s11)
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
     fde:	07800693          	li	a3,120
     fe2:	4641                	li	a2,16
                num_buf[i++] = (char)c;
     fe4:	4d05                	li	s10,1
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
     fe6:	badc09e3          	beq	s8,a3,b98 <_vscanf_core.constprop.0+0x268>
     fea:	06900693          	li	a3,105
     fee:	4629                	li	a2,10
                num_buf[i++] = (char)c;
     ff0:	4d05                	li	s10,1
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
     ff2:	badc13e3          	bne	s8,a3,b98 <_vscanf_core.constprop.0+0x268>
     ff6:	4601                	li	a2,0
     ff8:	b645                	j	b98 <_vscanf_core.constprop.0+0x268>
        ctx->ungotten = -1;
     ffa:	56fd                	li	a3,-1
     ffc:	fce6                	sd	s9,120(sp)
     ffe:	00ddac23          	sw	a3,24(s11)
                num_buf[i++] = (char)c;
    1002:	4d05                	li	s10,1
    1004:	fd57869b          	addiw	a3,a5,-43
    1008:	b171                	j	c94 <_vscanf_core.constprop.0+0x364>
        if (*str == '-')
    100a:	0017c583          	lbu	a1,1(a5)
    100e:	02d00693          	li	a3,45
    1012:	0ed58f63          	beq	a1,a3,1110 <_vscanf_core.constprop.0+0x7e0>
        else if (*str == '+')
    1016:	02b00693          	li	a3,43
    101a:	10d58e63          	beq	a1,a3,1136 <_vscanf_core.constprop.0+0x806>
        while (*str >= '0' && *str <= '9')
    101e:	fd05861b          	addiw	a2,a1,-48
    1022:	0ff67513          	zext.b	a0,a2
    1026:	45a5                	li	a1,9
        str++;
    1028:	00178693          	addi	a3,a5,1
        int esign = 1;
    102c:	4805                	li	a6,1
        while (*str >= '0' && *str <= '9')
    102e:	04a5ec63          	bltu	a1,a0,1086 <_vscanf_core.constprop.0+0x756>
    1032:	4525                	li	a0,9
    1034:	0016c583          	lbu	a1,1(a3)
            eval = eval * 10 + (*str - '0');
    1038:	0029979b          	slliw	a5,s3,0x2
    103c:	013787bb          	addw	a5,a5,s3
    1040:	0017979b          	slliw	a5,a5,0x1
    1044:	00f609bb          	addw	s3,a2,a5
        while (*str >= '0' && *str <= '9')
    1048:	fd05861b          	addiw	a2,a1,-48
    104c:	0ff67593          	zext.b	a1,a2
            str++;
    1050:	0685                	addi	a3,a3,1
        while (*str >= '0' && *str <= '9')
    1052:	feb571e3          	bgeu	a0,a1,1034 <_vscanf_core.constprop.0+0x704>
        while (eval--)
    1056:	fff9879b          	addiw	a5,s3,-1
    105a:	12098463          	beqz	s3,1182 <_vscanf_core.constprop.0+0x852>
        double p = 1.0;
    105e:	00004717          	auipc	a4,0x4
    1062:	77273687          	fld	fa3,1906(a4) # 57d0 <STDIN_FD+0x10>
    1066:	00004717          	auipc	a4,0x4
    106a:	77273707          	fld	fa4,1906(a4) # 57d8 <STDIN_FD+0x18>
        while (eval--)
    106e:	56fd                	li	a3,-1
    1070:	37fd                	addiw	a5,a5,-1
            p *= 10.0;
    1072:	12e6f6d3          	fmul.d	fa3,fa3,fa4
        while (eval--)
    1076:	fed79de3          	bne	a5,a3,1070 <_vscanf_core.constprop.0+0x740>
        if (esign == 1)
    107a:	4785                	li	a5,1
    107c:	00f80963          	beq	a6,a5,108e <_vscanf_core.constprop.0+0x75e>
            val /= p;
    1080:	1ad7f7d3          	fdiv.d	fa5,fa5,fa3
    1084:	b5c9                	j	f46 <_vscanf_core.constprop.0+0x616>
        double p = 1.0;
    1086:	00004797          	auipc	a5,0x4
    108a:	74a7b687          	fld	fa3,1866(a5) # 57d0 <STDIN_FD+0x10>
            val *= p;
    108e:	12d7f7d3          	fmul.d	fa5,fa5,fa3
    1092:	bd55                	j	f46 <_vscanf_core.constprop.0+0x616>
    while (*str >= '0' && *str <= '9')
    1094:	00004797          	auipc	a5,0x4
    1098:	7347b587          	fld	fa1,1844(a5) # 57c8 <STDIN_FD+0x8>
    109c:	02114603          	lbu	a2,33(sp)
        str++;
    10a0:	02110793          	addi	a5,sp,33
    10a4:	bd91                	j	ef8 <_vscanf_core.constprop.0+0x5c8>
        while (*str >= '0' && *str <= '9')
    10a6:	0017c683          	lbu	a3,1(a5)
    10aa:	45a5                	li	a1,9
        str++;
    10ac:	0785                	addi	a5,a5,1
        while (*str >= '0' && *str <= '9')
    10ae:	fd06861b          	addiw	a2,a3,-48
    10b2:	0ff67513          	zext.b	a0,a2
    10b6:	e8a5e2e3          	bltu	a1,a0,f3a <_vscanf_core.constprop.0+0x60a>
        double div = 10.0;
    10ba:	00004717          	auipc	a4,0x4
    10be:	71e73707          	fld	fa4,1822(a4) # 57d8 <STDIN_FD+0x18>
    10c2:	22e70653          	fmv.d	fa2,fa4
        while (*str >= '0' && *str <= '9')
    10c6:	4525                	li	a0,9
            val += (*str - '0') / div;
    10c8:	d20606d3          	fcvt.d.w	fa3,a2
        while (*str >= '0' && *str <= '9')
    10cc:	0017c683          	lbu	a3,1(a5)
            str++;
    10d0:	0785                	addi	a5,a5,1
            val += (*str - '0') / div;
    10d2:	1ac6f6d3          	fdiv.d	fa3,fa3,fa2
        while (*str >= '0' && *str <= '9')
    10d6:	fd06861b          	addiw	a2,a3,-48
    10da:	0ff67593          	zext.b	a1,a2
            div *= 10.0;
    10de:	12e67653          	fmul.d	fa2,fa2,fa4
            val += (*str - '0') / div;
    10e2:	02d7f7d3          	fadd.d	fa5,fa5,fa3
        while (*str >= '0' && *str <= '9')
    10e6:	feb571e3          	bgeu	a0,a1,10c8 <_vscanf_core.constprop.0+0x798>
    10ea:	bd81                	j	f3a <_vscanf_core.constprop.0+0x60a>
                    *va_arg(ap, double *) = val;
    10ec:	a39c                	fsd	fa5,0(a5)
                assigned++;
    10ee:	2b05                	addiw	s6,s6,1
    10f0:	b62d                	j	c1a <_vscanf_core.constprop.0+0x2ea>
                    *va_arg(ap, int64 *) = val;
    10f2:	6722                	ld	a4,8(sp)
    10f4:	6314                	ld	a3,0(a4)
    10f6:	e288                	sd	a0,0(a3)
    10f8:	b55d                	j	f9e <_vscanf_core.constprop.0+0x66e>
                    *va_arg(ap, long *) = (long)val;
    10fa:	e288                	sd	a0,0(a3)
    10fc:	b54d                	j	f9e <_vscanf_core.constprop.0+0x66e>
    while (*str >= '0' && *str <= '9')
    10fe:	00004797          	auipc	a5,0x4
    1102:	6d27b587          	fld	fa1,1746(a5) # 57d0 <STDIN_FD+0x10>
    1106:	02114603          	lbu	a2,33(sp)
        str++;
    110a:	02110793          	addi	a5,sp,33
    110e:	b3ed                	j	ef8 <_vscanf_core.constprop.0+0x5c8>
        while (*str >= '0' && *str <= '9')
    1110:	0027c583          	lbu	a1,2(a5)
            str++;
    1114:	00278693          	addi	a3,a5,2
        while (*str >= '0' && *str <= '9')
    1118:	4525                	li	a0,9
    111a:	fd05861b          	addiw	a2,a1,-48
    111e:	0ff67793          	zext.b	a5,a2
            esign = -1;
    1122:	587d                	li	a6,-1
        while (*str >= '0' && *str <= '9')
    1124:	f0f577e3          	bgeu	a0,a5,1032 <_vscanf_core.constprop.0+0x702>
        double p = 1.0;
    1128:	00004797          	auipc	a5,0x4
    112c:	6a87b687          	fld	fa3,1704(a5) # 57d0 <STDIN_FD+0x10>
            val /= p;
    1130:	1ad7f7d3          	fdiv.d	fa5,fa5,fa3
    1134:	bd09                	j	f46 <_vscanf_core.constprop.0+0x616>
        while (*str >= '0' && *str <= '9')
    1136:	0027c583          	lbu	a1,2(a5)
            str++;
    113a:	00278693          	addi	a3,a5,2
        while (*str >= '0' && *str <= '9')
    113e:	4525                	li	a0,9
    1140:	fd05861b          	addiw	a2,a1,-48
    1144:	0ff67793          	zext.b	a5,a2
    1148:	f2f56fe3          	bltu	a0,a5,1086 <_vscanf_core.constprop.0+0x756>
        int esign = 1;
    114c:	4805                	li	a6,1
    114e:	b5d5                	j	1032 <_vscanf_core.constprop.0+0x702>
    while (*p)
    1150:	001bc783          	lbu	a5,1(s7)
    1154:	bed5                	j	d48 <_vscanf_core.constprop.0+0x418>
            if (!suppress)
    1156:	9e0997e3          	bnez	s3,b44 <_vscanf_core.constprop.0+0x214>
                buf[i] = '\0';
    115a:	67e2                	ld	a5,24(sp)
    115c:	00078023          	sb	zero,0(a5)
    1160:	b2d5                	j	b44 <_vscanf_core.constprop.0+0x214>
            num_buf[i] = '\0';
    1162:	040d0793          	addi	a5,s10,64
    1166:	1018                	addi	a4,sp,32
    1168:	97ba                	add	a5,a5,a4
    116a:	fc078023          	sb	zero,-64(a5)
            if (i == 0)
    116e:	aa0d14e3          	bnez	s10,c16 <_vscanf_core.constprop.0+0x2e6>
    1172:	b171                	j	dfe <_vscanf_core.constprop.0+0x4ce>
    1174:	4641                	li	a2,16
                if (width > 0 && i >= width)
    1176:	a5204be3          	bgtz	s2,bcc <_vscanf_core.constprop.0+0x29c>
    117a:	bc99                	j	bd0 <_vscanf_core.constprop.0+0x2a0>
            num_buf[i] = '\0';
    117c:	020100a3          	sb	zero,33(sp)
            if (i == 0)
    1180:	bb99                	j	ed6 <_vscanf_core.constprop.0+0x5a6>
        double p = 1.0;
    1182:	00004797          	auipc	a5,0x4
    1186:	64e7b687          	fld	fa3,1614(a5) # 57d0 <STDIN_FD+0x10>
    118a:	bdc5                	j	107a <_vscanf_core.constprop.0+0x74a>
                buf[i] = '\0';
    118c:	67e2                	ld	a5,24(sp)
    118e:	01a786b3          	add	a3,a5,s10
    1192:	00068023          	sb	zero,0(a3)
        ctx->ungotten = c;
    1196:	00adac23          	sw	a0,24(s11)
    while (*p)
    119a:	001bc783          	lbu	a5,1(s7)
    119e:	b6f5                	j	d8a <_vscanf_core.constprop.0+0x45a>

00000000000011a0 <_out_char>:
{
    11a0:	7179                	addi	sp,sp,-48
    11a2:	ec26                	sd	s1,24(sp)
    if (ctx->stream)
    11a4:	6d04                	ld	s1,24(a0)
{
    11a6:	f022                	sd	s0,32(sp)
    11a8:	f406                	sd	ra,40(sp)
    11aa:	842a                	mv	s0,a0
    11ac:	872e                	mv	a4,a1
    if (ctx->stream)
    11ae:	c0a1                	beqz	s1,11ee <_out_char+0x4e>
    11b0:	e84a                	sd	s2,16(sp)
    if (stream->buf_mode == 2)
    11b2:	41c4a903          	lw	s2,1052(s1)
    11b6:	4789                	li	a5,2
    11b8:	04f90d63          	beq	s2,a5,1212 <_out_char+0x72>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    11bc:	4104a783          	lw	a5,1040(s1)
    if (stream->buf_write_pos >= BUFSIZ)
    11c0:	3ff00693          	li	a3,1023
    stream->buffer[stream->buf_write_pos++] = (char)c;
    11c4:	0017861b          	addiw	a2,a5,1
    11c8:	40c4a823          	sw	a2,1040(s1)
    11cc:	97a6                	add	a5,a5,s1
    11ce:	00b78823          	sb	a1,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    11d2:	08c6c063          	blt	a3,a2,1252 <_out_char+0xb2>
    else if (stream->buf_mode == 1 && c == '\n')
    11d6:	4785                	li	a5,1
    11d8:	04f90a63          	beq	s2,a5,122c <_out_char+0x8c>
        ctx->written++;
    11dc:	681c                	ld	a5,16(s0)
    11de:	6942                	ld	s2,16(sp)
}
    11e0:	70a2                	ld	ra,40(sp)
        ctx->written++;
    11e2:	0785                	addi	a5,a5,1
    11e4:	e81c                	sd	a5,16(s0)
}
    11e6:	7402                	ld	s0,32(sp)
    11e8:	64e2                	ld	s1,24(sp)
    11ea:	6145                	addi	sp,sp,48
    11ec:	8082                	ret
        if (ctx->limit > 0 && ctx->written < ctx->limit - 1)
    11ee:	6514                	ld	a3,8(a0)
    11f0:	691c                	ld	a5,16(a0)
    11f2:	ca89                	beqz	a3,1204 <_out_char+0x64>
    11f4:	16fd                	addi	a3,a3,-1
    11f6:	00d7f763          	bgeu	a5,a3,1204 <_out_char+0x64>
            ctx->buf[ctx->written] = c;
    11fa:	6114                	ld	a3,0(a0)
    11fc:	97b6                	add	a5,a5,a3
    11fe:	00b78023          	sb	a1,0(a5)
        ctx->written++;
    1202:	691c                	ld	a5,16(a0)
    1204:	0785                	addi	a5,a5,1
}
    1206:	70a2                	ld	ra,40(sp)
        ctx->written++;
    1208:	e81c                	sd	a5,16(s0)
}
    120a:	7402                	ld	s0,32(sp)
    120c:	64e2                	ld	s1,24(sp)
    120e:	6145                	addi	sp,sp,48
    1210:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    1212:	4088                	lw	a0,0(s1)
    1214:	4605                	li	a2,1
    1216:	00f10593          	addi	a1,sp,15
        char ch = (char)c;
    121a:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    121e:	e8bfe0ef          	jal	a8 <write>
    1222:	4785                	li	a5,1
    1224:	faf50ce3          	beq	a0,a5,11dc <_out_char+0x3c>
            stream->error = 1;
    1228:	c49c                	sw	a5,8(s1)
            return EOF;
    122a:	bf4d                	j	11dc <_out_char+0x3c>
    else if (stream->buf_mode == 1 && c == '\n')
    122c:	47a9                	li	a5,10
    122e:	faf597e3          	bne	a1,a5,11dc <_out_char+0x3c>
    if (stream->buf_write_pos > 0)
    1232:	fac055e3          	blez	a2,11dc <_out_char+0x3c>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    1236:	4088                	lw	a0,0(s1)
    1238:	01048593          	addi	a1,s1,16
    123c:	e6dfe0ef          	jal	a8 <write>
        if (ret < stream->buf_write_pos)
    1240:	4104a783          	lw	a5,1040(s1)
    1244:	02f55063          	bge	a0,a5,1264 <_out_char+0xc4>
            stream->error = 1;
    1248:	0124a423          	sw	s2,8(s1)
            stream->buf_write_pos = 0;
    124c:	4004a823          	sw	zero,1040(s1)
            return EOF;
    1250:	b771                	j	11dc <_out_char+0x3c>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    1252:	4088                	lw	a0,0(s1)
    1254:	01048593          	addi	a1,s1,16
    1258:	e51fe0ef          	jal	a8 <write>
        if (ret < stream->buf_write_pos)
    125c:	4104a783          	lw	a5,1040(s1)
    1260:	00f54563          	blt	a0,a5,126a <_out_char+0xca>
        stream->buf_write_pos = 0;
    1264:	4004a823          	sw	zero,1040(s1)
    1268:	bf95                	j	11dc <_out_char+0x3c>
            stream->error = 1;
    126a:	4785                	li	a5,1
    126c:	c49c                	sw	a5,8(s1)
            stream->buf_write_pos = 0;
    126e:	4004a823          	sw	zero,1040(s1)
            return EOF;
    1272:	b7ad                	j	11dc <_out_char+0x3c>

0000000000001274 <stbsp_set_separators>:
   "75767778798081828384858687888990919293949596979899"
};

STBSP__PUBLICDEF void STB_SPRINTF_DECORATE(set_separators)(char pcomma, char pperiod)
{
   stbsp__period = pperiod;
    1274:	00005797          	auipc	a5,0x5
    1278:	68c78793          	addi	a5,a5,1676 # 6900 <stbsp__digitpair>
    127c:	0cb78623          	sb	a1,204(a5)
   stbsp__comma = pcomma;
    1280:	0ca786a3          	sb	a0,205(a5)
}
    1284:	8082                	ret

0000000000001286 <stbsp_vsprintfcb>:

   return (stbsp__uint32)(sn - s);
}

STBSP__PUBLICDEF int STB_SPRINTF_DECORATE(vsprintfcb)(STBSP_SPRINTFCB *callback, void *user, char *buf, char const *fmt, va_list va)
{
    1286:	d1010113          	addi	sp,sp,-752
            // Check if the next 4 bytes contain %(0x25) or end of string.
            // Using the 'hasless' trick:
            // https://graphics.stanford.edu/~seander/bithacks.html#HasLessInWord
            stbsp__uint32 v, c;
            v = *(stbsp__uint32 *)f;
            c = (~v) & 0x80808080;
    128a:	808087b7          	lui	a5,0x80808
            if (((v ^ 0x25252525) - 0x01010101) & c)
    128e:	252523b7          	lui	t2,0x25252
    1292:	52538393          	addi	t2,t2,1317 # 25252525 <_ZSt4cerr+0x2524ad2d>
{
    1296:	29913c23          	sd	s9,664(sp)
    129a:	29b13423          	sd	s11,648(sp)
   int tlen = 0;
    129e:	4c81                	li	s9,0
            if (((v ^ 0x25252525) - 0x01010101) & c)
    12a0:	feff0db7          	lui	s11,0xfeff0
            c = (~v) & 0x80808080;
    12a4:	08078793          	addi	a5,a5,128 # ffffffff80808080 <_ZSt4cerr+0xffffffff80800888>
{
    12a8:	2e813023          	sd	s0,736(sp)
    12ac:	2c913c23          	sd	s1,728(sp)
    12b0:	2d213823          	sd	s2,720(sp)
    12b4:	2d313423          	sd	s3,712(sp)
    12b8:	2b713423          	sd	s7,680(sp)
    12bc:	2b813023          	sd	s8,672(sp)
    12c0:	29a13823          	sd	s10,656(sp)
    12c4:	2e113423          	sd	ra,744(sp)
    12c8:	8d66                	mv	s10,s9
    12ca:	8432                	mv	s0,a2
    12cc:	8c9e                	mv	s9,t2
    12ce:	89aa                	mv	s3,a0
    12d0:	e42e                	sd	a1,8(sp)
    12d2:	84b6                	mv	s1,a3
    12d4:	8bba                	mv	s7,a4
    12d6:	fc02                	sd	zero,56(sp)
   for (;;) {
    12d8:	8932                	mv	s2,a2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    12da:	effd8d9b          	addiw	s11,s11,-257 # fffffffffefefeff <_ZSt4cerr+0xfffffffffefe8707>
               goto schk1;
            if ((v - 0x01010101) & c)
               goto schk2;
            if (callback)
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    12de:	20000c13          	li	s8,512
    12e2:	83be                	mv	t2,a5
         while (((stbsp__uintptr)f) & 3) {
    12e4:	0034f793          	andi	a5,s1,3
    12e8:	c7a9                	beqz	a5,1332 <stbsp_vsprintfcb+0xac>
            if (f[0] == '%')
    12ea:	0004c783          	lbu	a5,0(s1)
    12ee:	02500713          	li	a4,37
    12f2:	0ee78263          	beq	a5,a4,13d6 <stbsp_vsprintfcb+0x150>
            if (f[0] == 0)
    12f6:	cbd9                	beqz	a5,138c <stbsp_vsprintfcb+0x106>
            stbsp__chk_cb_buf(1);
    12f8:	02098663          	beqz	s3,1324 <stbsp_vsprintfcb+0x9e>
    12fc:	4124063b          	subw	a2,s0,s2
    1300:	1fe00713          	li	a4,510
    1304:	02c75063          	bge	a4,a2,1324 <stbsp_vsprintfcb+0x9e>
    1308:	65a2                	ld	a1,8(sp)
    130a:	854a                	mv	a0,s2
    130c:	e81e                	sd	t2,16(sp)
    130e:	00cd0d3b          	addw	s10,s10,a2
    1312:	9982                	jalr	s3
    1314:	892a                	mv	s2,a0
    1316:	e119                	bnez	a0,131c <stbsp_vsprintfcb+0x96>
    1318:	0200106f          	j	2338 <stbsp_vsprintfcb+0x10b2>
            *bf++ = f[0];
    131c:	0004c783          	lbu	a5,0(s1)
            stbsp__chk_cb_buf(1);
    1320:	63c2                	ld	t2,16(sp)
    1322:	842a                	mv	s0,a0
            ++f;
    1324:	0485                	addi	s1,s1,1
            *bf++ = f[0];
    1326:	00f40023          	sb	a5,0(s0)
         while (((stbsp__uintptr)f) & 3) {
    132a:	0034f793          	andi	a5,s1,3
            *bf++ = f[0];
    132e:	0405                	addi	s0,s0,1
         while (((stbsp__uintptr)f) & 3) {
    1330:	ffcd                	bnez	a5,12ea <stbsp_vsprintfcb+0x64>
            v = *(stbsp__uint32 *)f;
    1332:	4094                	lw	a3,0(s1)
            c = (~v) & 0x80808080;
    1334:	fff6c793          	not	a5,a3
            if (((v ^ 0x25252525) - 0x01010101) & c)
    1338:	0196c733          	xor	a4,a3,s9
            c = (~v) & 0x80808080;
    133c:	0077f7b3          	and	a5,a5,t2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    1340:	01b7073b          	addw	a4,a4,s11
    1344:	8f7d                	and	a4,a4,a5
    1346:	2701                	sext.w	a4,a4
    1348:	f34d                	bnez	a4,12ea <stbsp_vsprintfcb+0x64>
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    134a:	460d                	li	a2,3
    134c:	a805                	j	137c <stbsp_vsprintfcb+0xf6>
            if (callback)
    134e:	00098863          	beqz	s3,135e <stbsp_vsprintfcb+0xd8>
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    1352:	412407b3          	sub	a5,s0,s2
    1356:	40fc07bb          	subw	a5,s8,a5
    135a:	f8f658e3          	bge	a2,a5,12ea <stbsp_vsprintfcb+0x64>
                    bf[2] = f[2];
                    bf[3] = f[3];
                } else
            #endif
            {
                *(stbsp__uint32 *)bf = v;
    135e:	c014                	sw	a3,0(s0)
            v = *(stbsp__uint32 *)f;
    1360:	40d4                	lw	a3,4(s1)
            }
            bf += 4;
    1362:	0411                	addi	s0,s0,4
            f += 4;
    1364:	0491                	addi	s1,s1,4
            c = (~v) & 0x80808080;
    1366:	fff6c793          	not	a5,a3
            if (((v ^ 0x25252525) - 0x01010101) & c)
    136a:	0196c733          	xor	a4,a3,s9
            c = (~v) & 0x80808080;
    136e:	0077f7b3          	and	a5,a5,t2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    1372:	01b7073b          	addw	a4,a4,s11
    1376:	8f7d                	and	a4,a4,a5
    1378:	2701                	sext.w	a4,a4
    137a:	fb25                	bnez	a4,12ea <stbsp_vsprintfcb+0x64>
            if ((v - 0x01010101) & c)
    137c:	01b6873b          	addw	a4,a3,s11
    1380:	8ff9                	and	a5,a5,a4
    1382:	2781                	sext.w	a5,a5
    1384:	d7e9                	beqz	a5,134e <stbsp_vsprintfcb+0xc8>
            if (f[0] == 0)
    1386:	0004c783          	lbu	a5,0(s1)
    138a:	f7bd                	bnez	a5,12f8 <stbsp_vsprintfcb+0x72>
endfmt:

   if (!callback)
      *bf = 0;
   else
      stbsp__flush_cb();
    138c:	8cea                	mv	s9,s10
    138e:	412404bb          	subw	s1,s0,s2
   if (!callback)
    1392:	70098563          	beqz	s3,1a9c <stbsp_vsprintfcb+0x816>
      stbsp__flush_cb();
    1396:	00905663          	blez	s1,13a2 <stbsp_vsprintfcb+0x11c>
    139a:	65a2                	ld	a1,8(sp)
    139c:	8626                	mv	a2,s1
    139e:	854a                	mv	a0,s2
    13a0:	9982                	jalr	s3
    13a2:	009c8cbb          	addw	s9,s9,s1

done:
   return tlen + (int)(bf - buf);
}
    13a6:	2e813083          	ld	ra,744(sp)
    13aa:	2e013403          	ld	s0,736(sp)
    13ae:	2d813483          	ld	s1,728(sp)
    13b2:	2d013903          	ld	s2,720(sp)
    13b6:	2c813983          	ld	s3,712(sp)
    13ba:	2a813b83          	ld	s7,680(sp)
    13be:	2a013c03          	ld	s8,672(sp)
    13c2:	29013d03          	ld	s10,656(sp)
    13c6:	28813d83          	ld	s11,648(sp)
    13ca:	8566                	mv	a0,s9
    13cc:	29813c83          	ld	s9,664(sp)
    13d0:	2f010113          	addi	sp,sp,752
    13d4:	8082                	ret
    13d6:	2d413023          	sd	s4,704(sp)
    13da:	2b513c23          	sd	s5,696(sp)
    13de:	2b613823          	sd	s6,688(sp)
      tz = 0;
    13e2:	00248693          	addi	a3,s1,2
      fl = 0;
    13e6:	4e01                	li	t3,0
         switch (f[0]) {
    13e8:	03f00593          	li	a1,63
    13ec:	00004617          	auipc	a2,0x4
    13f0:	d0460613          	addi	a2,a2,-764 # 50f0 <_GLOBAL__sub_I__ZSt3cin+0x148>
    13f4:	fff6c783          	lbu	a5,-1(a3)
    13f8:	fff68493          	addi	s1,a3,-1
    13fc:	fe07871b          	addiw	a4,a5,-32
    1400:	0ff77713          	zext.b	a4,a4
    1404:	00e5ec63          	bltu	a1,a4,141c <stbsp_vsprintfcb+0x196>
    1408:	070a                	slli	a4,a4,0x2
    140a:	9732                	add	a4,a4,a2
    140c:	4318                	lw	a4,0(a4)
    140e:	9732                	add	a4,a4,a2
    1410:	8702                	jr	a4
      if (f[0] == '*') {
    1412:	0014c783          	lbu	a5,1(s1)
            fl |= STBSP__LEADINGZERO;
    1416:	010e6e13          	ori	t3,t3,16
            ++f;
    141a:	0485                	addi	s1,s1,1
      if (f[0] == '*') {
    141c:	02a00713          	li	a4,42
    1420:	0ce79163          	bne	a5,a4,14e2 <stbsp_vsprintfcb+0x25c>
         fw = va_arg(va, stbsp__uint32);
    1424:	000bab03          	lw	s6,0(s7)
         while ((f[0] >= '0') && (f[0] <= '9')) {
    1428:	0014c783          	lbu	a5,1(s1)
         fw = va_arg(va, stbsp__uint32);
    142c:	0ba1                	addi	s7,s7,8
         ++f;
    142e:	0485                	addi	s1,s1,1
      if (f[0] == '.') {
    1430:	02e00713          	li	a4,46
      pr = -1;
    1434:	58fd                	li	a7,-1
      if (f[0] == '.') {
    1436:	0ee78663          	beq	a5,a4,1522 <stbsp_vsprintfcb+0x29c>
      switch (f[0]) {
    143a:	04900713          	li	a4,73
    143e:	10e78263          	beq	a5,a4,1542 <stbsp_vsprintfcb+0x2bc>
    1442:	f987871b          	addiw	a4,a5,-104
    1446:	0ff77713          	zext.b	a4,a4
    144a:	46c9                	li	a3,18
    144c:	02e6e063          	bltu	a3,a4,146c <stbsp_vsprintfcb+0x1e6>
    1450:	00004697          	auipc	a3,0x4
    1454:	da068693          	addi	a3,a3,-608 # 51f0 <_GLOBAL__sub_I__ZSt3cin+0x248>
    1458:	070a                	slli	a4,a4,0x2
    145a:	9736                	add	a4,a4,a3
    145c:	4318                	lw	a4,0(a4)
    145e:	9736                	add	a4,a4,a3
    1460:	8702                	jr	a4
         if (f[0] == 'h')
    1462:	0014c783          	lbu	a5,1(s1)
         fl |= (sizeof(ptrdiff_t) == 8) ? STBSP__INTMAX : 0;
    1466:	020e6e13          	ori	t3,t3,32
         ++f;
    146a:	0485                	addi	s1,s1,1
      switch (f[0]) {
    146c:	fbf7871b          	addiw	a4,a5,-65
    1470:	0ff77713          	zext.b	a4,a4
    1474:	03700693          	li	a3,55
    1478:	0ee6ea63          	bltu	a3,a4,156c <stbsp_vsprintfcb+0x2e6>
    147c:	00004697          	auipc	a3,0x4
    1480:	dc068693          	addi	a3,a3,-576 # 523c <_GLOBAL__sub_I__ZSt3cin+0x294>
    1484:	070a                	slli	a4,a4,0x2
    1486:	9736                	add	a4,a4,a3
    1488:	4318                	lw	a4,0(a4)
    148a:	9736                	add	a4,a4,a3
    148c:	8702                	jr	a4
            fl |= STBSP__METRIC_NOSPACE;
    148e:	400e6e13          	ori	t3,t3,1024
            continue;
    1492:	0685                	addi	a3,a3,1
    1494:	b785                	j	13f4 <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEFTJUST;
    1496:	001e6e13          	ori	t3,t3,1
            continue;
    149a:	0685                	addi	a3,a3,1
    149c:	bfa1                	j	13f4 <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADINGPLUS;
    149e:	002e6e13          	ori	t3,t3,2
            continue;
    14a2:	0685                	addi	a3,a3,1
    14a4:	bf81                	j	13f4 <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__TRIPLET_COMMA;
    14a6:	040e6e13          	ori	t3,t3,64
            continue;
    14aa:	0685                	addi	a3,a3,1
    14ac:	b7a1                	j	13f4 <stbsp_vsprintfcb+0x16e>
            if (fl & STBSP__METRIC_SUFFIX) {
    14ae:	100e7793          	andi	a5,t3,256
    14b2:	8772                	mv	a4,t3
    14b4:	56078363          	beqz	a5,1a1a <stbsp_vsprintfcb+0x794>
               if (fl & STBSP__METRIC_1024) {
    14b8:	6785                	lui	a5,0x1
    14ba:	034e1513          	slli	a0,t3,0x34
    14be:	80078793          	addi	a5,a5,-2048 # 800 <stbsp__real_to_str+0x65e>
    14c2:	5c055863          	bgez	a0,1a92 <stbsp_vsprintfcb+0x80c>
                  fl |= STBSP__METRIC_JEDEC;
    14c6:	6785                	lui	a5,0x1
    14c8:	8f5d                	or	a4,a4,a5
    14ca:	00070e1b          	sext.w	t3,a4
    14ce:	0685                	addi	a3,a3,1
    14d0:	b715                	j	13f4 <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADING_0X;
    14d2:	008e6e13          	ori	t3,t3,8
            continue;
    14d6:	0685                	addi	a3,a3,1
    14d8:	bf31                	j	13f4 <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADINGSPACE;
    14da:	004e6e13          	ori	t3,t3,4
            continue;
    14de:	0685                	addi	a3,a3,1
    14e0:	bf11                	j	13f4 <stbsp_vsprintfcb+0x16e>
         while ((f[0] >= '0') && (f[0] <= '9')) {
    14e2:	fd07871b          	addiw	a4,a5,-48 # fd0 <_vscanf_core.constprop.0+0x6a0>
    14e6:	0ff77713          	zext.b	a4,a4
    14ea:	4625                	li	a2,9
      fw = 0;
    14ec:	4b01                	li	s6,0
         while ((f[0] >= '0') && (f[0] <= '9')) {
    14ee:	46a5                	li	a3,9
    14f0:	f4e660e3          	bltu	a2,a4,1430 <stbsp_vsprintfcb+0x1aa>
            fw = fw * 10 + f[0] - '0';
    14f4:	002b171b          	slliw	a4,s6,0x2
    14f8:	0167073b          	addw	a4,a4,s6
    14fc:	0017171b          	slliw	a4,a4,0x1
            f++;
    1500:	0485                	addi	s1,s1,1
            fw = fw * 10 + f[0] - '0';
    1502:	9f3d                	addw	a4,a4,a5
         while ((f[0] >= '0') && (f[0] <= '9')) {
    1504:	0004c783          	lbu	a5,0(s1)
            fw = fw * 10 + f[0] - '0';
    1508:	fd070b1b          	addiw	s6,a4,-48
         while ((f[0] >= '0') && (f[0] <= '9')) {
    150c:	fd07871b          	addiw	a4,a5,-48
    1510:	0ff77713          	zext.b	a4,a4
    1514:	fee6f0e3          	bgeu	a3,a4,14f4 <stbsp_vsprintfcb+0x26e>
      if (f[0] == '.') {
    1518:	02e00713          	li	a4,46
      pr = -1;
    151c:	58fd                	li	a7,-1
      if (f[0] == '.') {
    151e:	f0e79ee3          	bne	a5,a4,143a <stbsp_vsprintfcb+0x1b4>
         if (f[0] == '*') {
    1522:	0014c783          	lbu	a5,1(s1)
    1526:	02a00713          	li	a4,42
    152a:	52e79763          	bne	a5,a4,1a58 <stbsp_vsprintfcb+0x7d2>
            while ((f[0] >= '0') && (f[0] <= '9')) {
    152e:	0024c783          	lbu	a5,2(s1)
      switch (f[0]) {
    1532:	04900713          	li	a4,73
            pr = va_arg(va, stbsp__uint32);
    1536:	000ba883          	lw	a7,0(s7)
            ++f;
    153a:	0489                	addi	s1,s1,2
            pr = va_arg(va, stbsp__uint32);
    153c:	0ba1                	addi	s7,s7,8
      switch (f[0]) {
    153e:	f0e792e3          	bne	a5,a4,1442 <stbsp_vsprintfcb+0x1bc>
         if ((f[1] == '6') && (f[2] == '4')) {
    1542:	0014c783          	lbu	a5,1(s1)
    1546:	03600713          	li	a4,54
    154a:	00e79463          	bne	a5,a4,1552 <stbsp_vsprintfcb+0x2cc>
    154e:	1e60106f          	j	2734 <stbsp_vsprintfcb+0x14ae>
         } else if ((f[1] == '3') && (f[2] == '2')) {
    1552:	03300713          	li	a4,51
    1556:	6ae796e3          	bne	a5,a4,2402 <stbsp_vsprintfcb+0x117c>
    155a:	0024c683          	lbu	a3,2(s1)
    155e:	03200713          	li	a4,50
    1562:	00e69463          	bne	a3,a4,156a <stbsp_vsprintfcb+0x2e4>
    1566:	0ae0106f          	j	2614 <stbsp_vsprintfcb+0x138e>
            ++f;
    156a:	0485                	addi	s1,s1,1
         *s = f[0];
    156c:	26f10fa3          	sb	a5,639(sp)
         l = 1;
    1570:	4785                	li	a5,1
    1572:	d0be                	sw	a5,96(sp)
         lead[0] = 0;
    1574:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    1578:	06010823          	sb	zero,112(sp)
         dp = 0;
    157c:	d282                	sw	zero,100(sp)
    157e:	e0de                	sd	s7,64(sp)
    1580:	4701                	li	a4,0
    1582:	4301                	li	t1,0
    1584:	4f81                	li	t6,0
    1586:	4685                	li	a3,1
    1588:	4a01                	li	s4,0
         cs = 0;
    158a:	4281                	li	t0,0
         s = num + STBSP__NUMSZ - 1;
    158c:	27f10a93          	addi	s5,sp,639
         fw = fl = 0;
    1590:	4e01                	li	t3,0
      tz = 0;
    1592:	4881                	li	a7,0
            if (fl & STBSP__LEADINGZERO) // if leading zeros, everything is in pr
    1594:	010e7793          	andi	a5,t3,16
    1598:	40078ee3          	beqz	a5,21b4 <stbsp_vsprintfcb+0xf2e>
               pr = (fw > pr) ? fw : pr;
    159c:	87ba                	mv	a5,a4
    159e:	00675363          	bge	a4,t1,15a4 <stbsp_vsprintfcb+0x31e>
    15a2:	879a                	mv	a5,t1
    15a4:	0007871b          	sext.w	a4,a5
               fw = 0;
    15a8:	4301                	li	t1,0
         if (fw + pr) {
    15aa:	62070563          	beqz	a4,1bd4 <stbsp_vsprintfcb+0x94e>
            sn = lead + 1;
    15ae:	06910793          	addi	a5,sp,105
    15b2:	fcbe                	sd	a5,120(sp)
            while (lead[0]) {
    15b4:	0a0a0863          	beqz	s4,1664 <stbsp_vsprintfcb+0x3de>
               stbsp__cb_buf_clamp(i, lead[0]);
    15b8:	f026                	sd	s1,32(sp)
    15ba:	f436                	sd	a3,40(sp)
    15bc:	854a                	mv	a0,s2
    15be:	86d2                	mv	a3,s4
    15c0:	84ce                	mv	s1,s3
               stbsp__chk_cb_buf(1);
    15c2:	1fe00b93          	li	s7,510
               stbsp__cb_buf_clamp(i, lead[0]);
    15c6:	89be                	mv	s3,a5
    15c8:	20000b13          	li	s6,512
    15cc:	87a2                	mv	a5,s0
    15ce:	e846                	sd	a7,16(sp)
    15d0:	846a                	mv	s0,s10
    15d2:	ec7e                	sd	t6,24(sp)
    15d4:	8d6e                	mv	s10,s11
    15d6:	f872                	sd	t3,48(sp)
    15d8:	8de6                	mv	s11,s9
    15da:	8a3a                	mv	s4,a4
    15dc:	e496                	sd	t0,72(sp)
    15de:	891a                	mv	s2,t1
    15e0:	8c9e                	mv	s9,t2
    15e2:	0006871b          	sext.w	a4,a3
    15e6:	2e0482e3          	beqz	s1,20ca <stbsp_vsprintfcb+0xe44>
    15ea:	40a7863b          	subw	a2,a5,a0
    15ee:	40cb083b          	subw	a6,s6,a2
    15f2:	85c2                	mv	a1,a6
    15f4:	01075363          	bge	a4,a6,15fa <stbsp_vsprintfcb+0x374>
    15f8:	85ba                	mv	a1,a4
               lead[0] -= (char)i;
    15fa:	9e8d                	subw	a3,a3,a1
               stbsp__cb_buf_clamp(i, lead[0]);
    15fc:	0005871b          	sext.w	a4,a1
               lead[0] -= (char)i;
    1600:	06d10423          	sb	a3,104(sp)
               while (i) {
    1604:	c70d                	beqz	a4,162e <stbsp_vsprintfcb+0x3a8>
    1606:	7866                	ld	a6,120(sp)
    1608:	02071593          	slli	a1,a4,0x20
    160c:	9181                	srli	a1,a1,0x20
    160e:	00b78633          	add	a2,a5,a1
    1612:	8742                	mv	a4,a6
                  *bf++ = *sn++;
    1614:	00074683          	lbu	a3,0(a4)
    1618:	0785                	addi	a5,a5,1
               while (i) {
    161a:	0705                	addi	a4,a4,1
                  *bf++ = *sn++;
    161c:	fed78fa3          	sb	a3,-1(a5)
               while (i) {
    1620:	fec79ae3          	bne	a5,a2,1614 <stbsp_vsprintfcb+0x38e>
    1624:	982e                	add	a6,a6,a1
    1626:	fcc2                	sd	a6,120(sp)
               stbsp__chk_cb_buf(1);
    1628:	c899                	beqz	s1,163e <stbsp_vsprintfcb+0x3b8>
    162a:	40a7863b          	subw	a2,a5,a0
    162e:	00cbd863          	bge	s7,a2,163e <stbsp_vsprintfcb+0x3b8>
    1632:	65a2                	ld	a1,8(sp)
    1634:	9c31                	addw	s0,s0,a2
    1636:	9482                	jalr	s1
    1638:	34050ee3          	beqz	a0,2194 <stbsp_vsprintfcb+0xf0e>
    163c:	87aa                	mv	a5,a0
            while (lead[0]) {
    163e:	06814683          	lbu	a3,104(sp)
    1642:	f2c5                	bnez	a3,15e2 <stbsp_vsprintfcb+0x35c>
    1644:	83e6                	mv	t2,s9
    1646:	68c2                	ld	a7,16(sp)
    1648:	8cee                	mv	s9,s11
    164a:	6fe2                	ld	t6,24(sp)
    164c:	8dea                	mv	s11,s10
    164e:	76a2                	ld	a3,40(sp)
    1650:	8d22                	mv	s10,s0
    1652:	7e42                	ld	t3,48(sp)
    1654:	843e                	mv	s0,a5
    1656:	62a6                	ld	t0,72(sp)
    1658:	87ce                	mv	a5,s3
    165a:	89a6                	mv	s3,s1
    165c:	7482                	ld	s1,32(sp)
    165e:	834a                	mv	t1,s2
    1660:	8752                	mv	a4,s4
    1662:	892a                	mv	s2,a0
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    1664:	040e7b13          	andi	s6,t3,64
            c = cs >> 24;
    1668:	0182d61b          	srliw	a2,t0,0x18
    166c:	0182db9b          	srliw	s7,t0,0x18
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    1670:	4a01                	li	s4,0
    1672:	000b0e63          	beqz	s6,168e <stbsp_vsprintfcb+0x408>
            cs &= 0xffffff;
    1676:	02829a13          	slli	s4,t0,0x28
    167a:	028a5a13          	srli	s4,s4,0x28
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    167e:	00ea0a3b          	addw	s4,s4,a4
    1682:	0016059b          	addiw	a1,a2,1
    1686:	02ba7a3b          	remuw	s4,s4,a1
    168a:	41460a3b          	subw	s4,a2,s4
            while (pr > 0) {
    168e:	0ce05763          	blez	a4,175c <stbsp_vsprintfcb+0x4d6>
                     *(stbsp__uint32 *)bf = 0x30303030;
    1692:	30303837          	lui	a6,0x30303
    1696:	03080813          	addi	a6,a6,48 # 30303030 <_ZSt4cerr+0x302fb838>
    169a:	f026                	sd	s1,32(sp)
    169c:	854a                	mv	a0,s2
    169e:	84da                	mv	s1,s6
    16a0:	895e                	mv	s2,s7
    16a2:	e4d6                	sd	s5,72(sp)
    16a4:	8b4e                	mv	s6,s3
    16a6:	8aea                	mv	s5,s10
               stbsp__chk_cb_buf(1);
    16a8:	1fe00293          	li	t0,510
    16ac:	8d6e                	mv	s10,s11
                     *bf++ = stbsp__comma;
    16ae:	00005f17          	auipc	t5,0x5
    16b2:	252f0f13          	addi	t5,t5,594 # 6900 <stbsp__digitpair>
    16b6:	8de6                	mv	s11,s9
                     *bf++ = '0';
    16b8:	03000e93          	li	t4,48
    16bc:	e846                	sd	a7,16(sp)
    16be:	ec7e                	sd	t6,24(sp)
    16c0:	f436                	sd	a3,40(sp)
    16c2:	f872                	sd	t3,48(sp)
    16c4:	e89a                	sd	t1,80(sp)
    16c6:	89ba                	mv	s3,a4
    16c8:	ecbe                	sd	a5,88(sp)
    16ca:	8bc2                	mv	s7,a6
    16cc:	8c9e                	mv	s9,t2
               stbsp__cb_buf_clamp(i, pr);
    16ce:	240b0ee3          	beqz	s6,212a <stbsp_vsprintfcb+0xea4>
    16d2:	40a407b3          	sub	a5,s0,a0
    16d6:	40fc063b          	subw	a2,s8,a5
    16da:	87b2                	mv	a5,a2
    16dc:	00c9d363          	bge	s3,a2,16e2 <stbsp_vsprintfcb+0x45c>
    16e0:	87ce                	mv	a5,s3
    16e2:	0007859b          	sext.w	a1,a5
               pr -= i;
    16e6:	40f989bb          	subw	s3,s3,a5
               if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    16ea:	32048c63          	beqz	s1,1a22 <stbsp_vsprintfcb+0x79c>
               while (i) {
    16ee:	34058a63          	beqz	a1,1a42 <stbsp_vsprintfcb+0x7bc>
    16f2:	1582                	slli	a1,a1,0x20
                     *bf++ = stbsp__comma;
    16f4:	0cdf4603          	lbu	a2,205(t5)
    16f8:	9181                	srli	a1,a1,0x20
    16fa:	95a2                	add	a1,a1,s0
    16fc:	0405                	addi	s0,s0,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (cs++ == c)) {
    16fe:	c481                	beqz	s1,1706 <stbsp_vsprintfcb+0x480>
    1700:	1d4901e3          	beq	s2,s4,20c2 <stbsp_vsprintfcb+0xe3c>
    1704:	2a05                	addiw	s4,s4,1
                     *bf++ = '0';
    1706:	03000793          	li	a5,48
    170a:	fef40fa3          	sb	a5,-1(s0)
               while (i) {
    170e:	fe8597e3          	bne	a1,s0,16fc <stbsp_vsprintfcb+0x476>
               stbsp__chk_cb_buf(1);
    1712:	320b0b63          	beqz	s6,1a48 <stbsp_vsprintfcb+0x7c2>
    1716:	40a5863b          	subw	a2,a1,a0
    171a:	32c2d763          	bge	t0,a2,1a48 <stbsp_vsprintfcb+0x7c2>
    171e:	65a2                	ld	a1,8(sp)
    1720:	01560abb          	addw	s5,a2,s5
    1724:	9b02                	jalr	s6
    1726:	3a050ce3          	beqz	a0,22de <stbsp_vsprintfcb+0x1058>
    172a:	842a                	mv	s0,a0
    172c:	1fe00293          	li	t0,510
    1730:	00005f17          	auipc	t5,0x5
    1734:	1d0f0f13          	addi	t5,t5,464 # 6900 <stbsp__digitpair>
    1738:	03000e93          	li	t4,48
            while (pr > 0) {
    173c:	f93049e3          	bgtz	s3,16ce <stbsp_vsprintfcb+0x448>
         while (lead[0]) {
    1740:	83e6                	mv	t2,s9
    1742:	68c2                	ld	a7,16(sp)
    1744:	8cee                	mv	s9,s11
    1746:	6fe2                	ld	t6,24(sp)
    1748:	8dea                	mv	s11,s10
    174a:	7482                	ld	s1,32(sp)
    174c:	8d56                	mv	s10,s5
    174e:	76a2                	ld	a3,40(sp)
    1750:	7e42                	ld	t3,48(sp)
    1752:	6346                	ld	t1,80(sp)
    1754:	67e6                	ld	a5,88(sp)
    1756:	6aa6                	ld	s5,72(sp)
    1758:	892a                	mv	s2,a0
    175a:	89da                	mv	s3,s6
    175c:	06814a03          	lbu	s4,104(sp)
         sn = lead + 1;
    1760:	fcbe                	sd	a5,120(sp)
         while (lead[0]) {
    1762:	0a0a0263          	beqz	s4,1806 <stbsp_vsprintfcb+0x580>
            stbsp__cb_buf_clamp(i, lead[0]);
    1766:	ec26                	sd	s1,24(sp)
    1768:	f036                	sd	a3,32(sp)
    176a:	854a                	mv	a0,s2
    176c:	86d2                	mv	a3,s4
    176e:	84ce                	mv	s1,s3
    1770:	87a2                	mv	a5,s0
            stbsp__chk_cb_buf(1);
    1772:	1fe00b93          	li	s7,510
            stbsp__cb_buf_clamp(i, lead[0]);
    1776:	846a                	mv	s0,s10
    1778:	20000b13          	li	s6,512
    177c:	8d6e                	mv	s10,s11
    177e:	e846                	sd	a7,16(sp)
    1780:	8de6                	mv	s11,s9
    1782:	8a7e                	mv	s4,t6
    1784:	8972                	mv	s2,t3
    1786:	899a                	mv	s3,t1
    1788:	8c9e                	mv	s9,t2
    178a:	0006871b          	sext.w	a4,a3
    178e:	140482e3          	beqz	s1,20d2 <stbsp_vsprintfcb+0xe4c>
    1792:	40a7863b          	subw	a2,a5,a0
    1796:	40cb083b          	subw	a6,s6,a2
    179a:	85c2                	mv	a1,a6
    179c:	01075363          	bge	a4,a6,17a2 <stbsp_vsprintfcb+0x51c>
    17a0:	85ba                	mv	a1,a4
            lead[0] -= (char)i;
    17a2:	9e8d                	subw	a3,a3,a1
            stbsp__cb_buf_clamp(i, lead[0]);
    17a4:	0005871b          	sext.w	a4,a1
            lead[0] -= (char)i;
    17a8:	06d10423          	sb	a3,104(sp)
            while (i) {
    17ac:	c70d                	beqz	a4,17d6 <stbsp_vsprintfcb+0x550>
    17ae:	7866                	ld	a6,120(sp)
    17b0:	02071593          	slli	a1,a4,0x20
    17b4:	9181                	srli	a1,a1,0x20
    17b6:	00b78633          	add	a2,a5,a1
    17ba:	8742                	mv	a4,a6
               *bf++ = *sn++;
    17bc:	00074683          	lbu	a3,0(a4)
    17c0:	0785                	addi	a5,a5,1
            while (i) {
    17c2:	0705                	addi	a4,a4,1
               *bf++ = *sn++;
    17c4:	fed78fa3          	sb	a3,-1(a5)
            while (i) {
    17c8:	fec79ae3          	bne	a5,a2,17bc <stbsp_vsprintfcb+0x536>
    17cc:	982e                	add	a6,a6,a1
    17ce:	fcc2                	sd	a6,120(sp)
            stbsp__chk_cb_buf(1);
    17d0:	c899                	beqz	s1,17e6 <stbsp_vsprintfcb+0x560>
    17d2:	40a7863b          	subw	a2,a5,a0
    17d6:	00cbd863          	bge	s7,a2,17e6 <stbsp_vsprintfcb+0x560>
    17da:	65a2                	ld	a1,8(sp)
    17dc:	9c31                	addw	s0,s0,a2
    17de:	9482                	jalr	s1
    17e0:	1a050ae3          	beqz	a0,2194 <stbsp_vsprintfcb+0xf0e>
    17e4:	87aa                	mv	a5,a0
         while (lead[0]) {
    17e6:	06814683          	lbu	a3,104(sp)
    17ea:	f2c5                	bnez	a3,178a <stbsp_vsprintfcb+0x504>
    17ec:	834e                	mv	t1,s3
    17ee:	68c2                	ld	a7,16(sp)
    17f0:	89a6                	mv	s3,s1
    17f2:	7682                	ld	a3,32(sp)
    17f4:	64e2                	ld	s1,24(sp)
    17f6:	8e4a                	mv	t3,s2
    17f8:	83e6                	mv	t2,s9
    17fa:	8fd2                	mv	t6,s4
    17fc:	8cee                	mv	s9,s11
    17fe:	892a                	mv	s2,a0
    1800:	8dea                	mv	s11,s10
    1802:	8d22                	mv	s10,s0
    1804:	843e                	mv	s0,a5
         while (n) {
    1806:	c6f9                	beqz	a3,18d4 <stbsp_vsprintfcb+0x64e>
            STBSP__UNALIGNED(while (i >= 4) {
    1808:	ec26                	sd	s1,24(sp)
    180a:	854a                	mv	a0,s2
    180c:	84d6                	mv	s1,s5
    180e:	896a                	mv	s2,s10
    1810:	87a2                	mv	a5,s0
    1812:	8d6e                	mv	s10,s11
            stbsp__chk_cb_buf(1);
    1814:	1fe00b93          	li	s7,510
            STBSP__UNALIGNED(while (i >= 4) {
    1818:	8de6                	mv	s11,s9
            stbsp__cb_buf_clamp(i, n);
    181a:	20000b13          	li	s6,512
            STBSP__UNALIGNED(while (i >= 4) {
    181e:	4a0d                	li	s4,3
    1820:	e87e                	sd	t6,16(sp)
    1822:	f072                	sd	t3,32(sp)
    1824:	8ac6                	mv	s5,a7
    1826:	f41a                	sd	t1,40(sp)
    1828:	8436                	mv	s0,a3
    182a:	8c9e                	mv	s9,t2
            stbsp__cb_buf_clamp(i, n);
    182c:	0004071b          	sext.w	a4,s0
    1830:	100982e3          	beqz	s3,2134 <stbsp_vsprintfcb+0xeae>
    1834:	40a78633          	sub	a2,a5,a0
    1838:	40cb05bb          	subw	a1,s6,a2
    183c:	862e                	mv	a2,a1
    183e:	00b75363          	bge	a4,a1,1844 <stbsp_vsprintfcb+0x5be>
    1842:	863a                	mv	a2,a4
    1844:	0006071b          	sext.w	a4,a2
            n -= i;
    1848:	9c11                	subw	s0,s0,a2
            STBSP__UNALIGNED(while (i >= 4) {
    184a:	14ea50e3          	bge	s4,a4,218a <stbsp_vsprintfcb+0xf04>
    184e:	ffc70f1b          	addiw	t5,a4,-4
    1852:	002f5e9b          	srliw	t4,t5,0x2
    1856:	001e8e1b          	addiw	t3,t4,1
    185a:	0e0a                	slli	t3,t3,0x2
    185c:	01c785b3          	add	a1,a5,t3
    1860:	8626                	mv	a2,s1
    1862:	4218                	lw	a4,0(a2)
    1864:	0791                	addi	a5,a5,4
    1866:	0611                	addi	a2,a2,4
    1868:	2701                	sext.w	a4,a4
    186a:	fee7ae23          	sw	a4,-4(a5)
    186e:	feb79ae3          	bne	a5,a1,1862 <stbsp_vsprintfcb+0x5dc>
    1872:	002e9e9b          	slliw	t4,t4,0x2
    1876:	41df073b          	subw	a4,t5,t4
            while (i) {
    187a:	94f2                	add	s1,s1,t3
    187c:	c31d                	beqz	a4,18a2 <stbsp_vsprintfcb+0x61c>
    187e:	8626                	mv	a2,s1
    1880:	87ae                	mv	a5,a1
    1882:	00e58f3b          	addw	t5,a1,a4
               *bf++ = *s++;
    1886:	00064e83          	lbu	t4,0(a2)
    188a:	0785                	addi	a5,a5,1
            while (i) {
    188c:	00078e1b          	sext.w	t3,a5
               *bf++ = *s++;
    1890:	ffd78fa3          	sb	t4,-1(a5)
    1894:	0605                	addi	a2,a2,1
            while (i) {
    1896:	ffcf18e3          	bne	t5,t3,1886 <stbsp_vsprintfcb+0x600>
    189a:	1702                	slli	a4,a4,0x20
    189c:	9301                	srli	a4,a4,0x20
    189e:	95ba                	add	a1,a1,a4
    18a0:	94ba                	add	s1,s1,a4
            stbsp__chk_cb_buf(1);
    18a2:	1a098763          	beqz	s3,1a50 <stbsp_vsprintfcb+0x7ca>
    18a6:	40a5863b          	subw	a2,a1,a0
    18aa:	1acbd363          	bge	s7,a2,1a50 <stbsp_vsprintfcb+0x7ca>
    18ae:	65a2                	ld	a1,8(sp)
    18b0:	0126093b          	addw	s2,a2,s2
    18b4:	9982                	jalr	s3
    18b6:	20050be3          	beqz	a0,22cc <stbsp_vsprintfcb+0x1046>
    18ba:	87aa                	mv	a5,a0
         while (n) {
    18bc:	f825                	bnez	s0,182c <stbsp_vsprintfcb+0x5a6>
    18be:	6fc2                	ld	t6,16(sp)
    18c0:	64e2                	ld	s1,24(sp)
    18c2:	7e02                	ld	t3,32(sp)
    18c4:	7322                	ld	t1,40(sp)
    18c6:	83e6                	mv	t2,s9
    18c8:	88d6                	mv	a7,s5
    18ca:	8cee                	mv	s9,s11
    18cc:	843e                	mv	s0,a5
    18ce:	8dea                	mv	s11,s10
    18d0:	8d4a                	mv	s10,s2
    18d2:	892a                	mv	s2,a0
         while (tz) {
    18d4:	08088863          	beqz	a7,1964 <stbsp_vsprintfcb+0x6de>
               *(stbsp__uint32 *)bf = 0x30303030;
    18d8:	30303b37          	lui	s6,0x30303
               *bf++ = '0';
    18dc:	03000a13          	li	s4,48
            while (i >= 4) {
    18e0:	4a8d                	li	s5,3
            stbsp__chk_cb_buf(1);
    18e2:	1fe00693          	li	a3,510
               *(stbsp__uint32 *)bf = 0x30303030;
    18e6:	030b0b13          	addi	s6,s6,48 # 30303030 <_ZSt4cerr+0x302fb838>
            stbsp__cb_buf_clamp(i, tz);
    18ea:	20000b93          	li	s7,512
    18ee:	040989e3          	beqz	s3,2140 <stbsp_vsprintfcb+0xeba>
    18f2:	41240633          	sub	a2,s0,s2
    18f6:	40cb87bb          	subw	a5,s7,a2
    18fa:	873e                	mv	a4,a5
    18fc:	00f8d363          	bge	a7,a5,1902 <stbsp_vsprintfcb+0x67c>
    1900:	8746                	mv	a4,a7
    1902:	0007079b          	sext.w	a5,a4
            tz -= i;
    1906:	40e888bb          	subw	a7,a7,a4
            while (i) {
    190a:	08078ee3          	beqz	a5,21a6 <stbsp_vsprintfcb+0xf20>
               if ((((stbsp__uintptr)bf) & 3) == 0)
    190e:	00347713          	andi	a4,s0,3
    1912:	e719                	bnez	a4,1920 <stbsp_vsprintfcb+0x69a>
    1914:	0390006f          	j	214c <stbsp_vsprintfcb+0xec6>
    1918:	00347713          	andi	a4,s0,3
    191c:	7a070f63          	beqz	a4,20da <stbsp_vsprintfcb+0xe54>
               *bf++ = '0';
    1920:	01440023          	sb	s4,0(s0)
               --i;
    1924:	37fd                	addiw	a5,a5,-1
               *bf++ = '0';
    1926:	0405                	addi	s0,s0,1
            while (i) {
    1928:	fbe5                	bnez	a5,1918 <stbsp_vsprintfcb+0x692>
            stbsp__chk_cb_buf(1);
    192a:	02098b63          	beqz	s3,1960 <stbsp_vsprintfcb+0x6da>
    192e:	4124063b          	subw	a2,s0,s2
    1932:	02c6d763          	bge	a3,a2,1960 <stbsp_vsprintfcb+0x6da>
    1936:	65a2                	ld	a1,8(sp)
    1938:	854a                	mv	a0,s2
    193a:	f81e                	sd	t2,48(sp)
    193c:	f41a                	sd	t1,40(sp)
    193e:	f072                	sd	t3,32(sp)
    1940:	ec7e                	sd	t6,24(sp)
    1942:	e846                	sd	a7,16(sp)
    1944:	00cd0d3b          	addw	s10,s10,a2
    1948:	9982                	jalr	s3
    194a:	892a                	mv	s2,a0
    194c:	1a0502e3          	beqz	a0,22f0 <stbsp_vsprintfcb+0x106a>
    1950:	73c2                	ld	t2,48(sp)
    1952:	7322                	ld	t1,40(sp)
    1954:	7e02                	ld	t3,32(sp)
    1956:	6fe2                	ld	t6,24(sp)
    1958:	68c2                	ld	a7,16(sp)
    195a:	842a                	mv	s0,a0
    195c:	1fe00693          	li	a3,510
         while (tz) {
    1960:	f80897e3          	bnez	a7,18ee <stbsp_vsprintfcb+0x668>
         sn = tail + 1;
    1964:	07110793          	addi	a5,sp,113
    1968:	fcbe                	sd	a5,120(sp)
         while (tail[0]) {
    196a:	080f8763          	beqz	t6,19f8 <stbsp_vsprintfcb+0x772>
            stbsp__cb_buf_clamp(i, tail[0]);
    196e:	854a                	mv	a0,s2
    1970:	8b6a                	mv	s6,s10
            stbsp__chk_cb_buf(1);
    1972:	1fe00a93          	li	s5,510
            stbsp__cb_buf_clamp(i, tail[0]);
    1976:	8d4e                	mv	s10,s3
    1978:	20000a13          	li	s4,512
    197c:	8bf2                	mv	s7,t3
    197e:	891a                	mv	s2,t1
    1980:	899e                	mv	s3,t2
    1982:	000f879b          	sext.w	a5,t6
    1986:	7c0d0863          	beqz	s10,2156 <stbsp_vsprintfcb+0xed0>
    198a:	40a4063b          	subw	a2,s0,a0
    198e:	40ca06bb          	subw	a3,s4,a2
    1992:	8736                	mv	a4,a3
    1994:	00d7d363          	bge	a5,a3,199a <stbsp_vsprintfcb+0x714>
    1998:	873e                	mv	a4,a5
            tail[0] -= (char)i;
    199a:	40ef8fbb          	subw	t6,t6,a4
            stbsp__cb_buf_clamp(i, tail[0]);
    199e:	0007079b          	sext.w	a5,a4
            tail[0] -= (char)i;
    19a2:	07f10823          	sb	t6,112(sp)
            while (i) {
    19a6:	c795                	beqz	a5,19d2 <stbsp_vsprintfcb+0x74c>
    19a8:	75e6                	ld	a1,120(sp)
    19aa:	02079613          	slli	a2,a5,0x20
    19ae:	9201                	srli	a2,a2,0x20
    19b0:	00c406b3          	add	a3,s0,a2
    19b4:	87ae                	mv	a5,a1
               *bf++ = *sn++;
    19b6:	0007c703          	lbu	a4,0(a5)
    19ba:	0405                	addi	s0,s0,1
            while (i) {
    19bc:	0785                	addi	a5,a5,1
               *bf++ = *sn++;
    19be:	fee40fa3          	sb	a4,-1(s0)
            while (i) {
    19c2:	fed41ae3          	bne	s0,a3,19b6 <stbsp_vsprintfcb+0x730>
    19c6:	95b2                	add	a1,a1,a2
    19c8:	fcae                	sd	a1,120(sp)
            stbsp__chk_cb_buf(1);
    19ca:	000d0d63          	beqz	s10,19e4 <stbsp_vsprintfcb+0x75e>
    19ce:	40a4063b          	subw	a2,s0,a0
    19d2:	00cad963          	bge	s5,a2,19e4 <stbsp_vsprintfcb+0x75e>
    19d6:	65a2                	ld	a1,8(sp)
    19d8:	00cb0b3b          	addw	s6,s6,a2
    19dc:	9d02                	jalr	s10
    19de:	200509e3          	beqz	a0,23f0 <stbsp_vsprintfcb+0x116a>
    19e2:	842a                	mv	s0,a0
         while (tail[0]) {
    19e4:	07014f83          	lbu	t6,112(sp)
    19e8:	f80f9de3          	bnez	t6,1982 <stbsp_vsprintfcb+0x6fc>
    19ec:	834a                	mv	t1,s2
    19ee:	83ce                	mv	t2,s3
    19f0:	8e5e                	mv	t3,s7
    19f2:	89ea                	mv	s3,s10
    19f4:	892a                	mv	s2,a0
    19f6:	8d5a                	mv	s10,s6
         if (fl & STBSP__LEFTJUST)
    19f8:	001e7e13          	andi	t3,t3,1
    19fc:	000e0663          	beqz	t3,1a08 <stbsp_vsprintfcb+0x782>
            if (fw > 0) {
    1a00:	00605463          	blez	t1,1a08 <stbsp_vsprintfcb+0x782>
    1a04:	0300106f          	j	2a34 <stbsp_vsprintfcb+0x17ae>
   for (;;) {
    1a08:	6b86                	ld	s7,64(sp)
    1a0a:	2c013a03          	ld	s4,704(sp)
    1a0e:	2b813a83          	ld	s5,696(sp)
    1a12:	2b013b03          	ld	s6,688(sp)
      ++f;
    1a16:	0485                	addi	s1,s1,1
   for (;;) {
    1a18:	b0f1                	j	12e4 <stbsp_vsprintfcb+0x5e>
               fl |= STBSP__METRIC_SUFFIX;
    1a1a:	100e6e13          	ori	t3,t3,256
            continue;
    1a1e:	0685                	addi	a3,a3,1
    1a20:	bad1                	j	13f4 <stbsp_vsprintfcb+0x16e>
                  while (i) {
    1a22:	0e0580e3          	beqz	a1,2302 <stbsp_vsprintfcb+0x107c>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    1a26:	00347793          	andi	a5,s0,3
    1a2a:	e799                	bnez	a5,1a38 <stbsp_vsprintfcb+0x7b2>
    1a2c:	0dd0006f          	j	2308 <stbsp_vsprintfcb+0x1082>
    1a30:	00347793          	andi	a5,s0,3
    1a34:	72078463          	beqz	a5,215c <stbsp_vsprintfcb+0xed6>
                     *bf++ = '0';
    1a38:	01d40023          	sb	t4,0(s0)
                     --i;
    1a3c:	35fd                	addiw	a1,a1,-1
                     *bf++ = '0';
    1a3e:	0405                	addi	s0,s0,1
                  while (i) {
    1a40:	f9e5                	bnez	a1,1a30 <stbsp_vsprintfcb+0x7aa>
               while (i) {
    1a42:	85a2                	mv	a1,s0
               stbsp__chk_cb_buf(1);
    1a44:	cc0b19e3          	bnez	s6,1716 <stbsp_vsprintfcb+0x490>
    1a48:	842e                	mv	s0,a1
            while (pr > 0) {
    1a4a:	c93042e3          	bgtz	s3,16ce <stbsp_vsprintfcb+0x448>
    1a4e:	b9cd                	j	1740 <stbsp_vsprintfcb+0x4ba>
            while (i) {
    1a50:	87ae                	mv	a5,a1
         while (n) {
    1a52:	dc041de3          	bnez	s0,182c <stbsp_vsprintfcb+0x5a6>
    1a56:	b5a5                	j	18be <stbsp_vsprintfcb+0x638>
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1a58:	fd07871b          	addiw	a4,a5,-48
    1a5c:	0ff77713          	zext.b	a4,a4
    1a60:	4625                	li	a2,9
         ++f;
    1a62:	0485                	addi	s1,s1,1
            pr = 0;
    1a64:	4881                	li	a7,0
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1a66:	46a5                	li	a3,9
    1a68:	9ce669e3          	bltu	a2,a4,143a <stbsp_vsprintfcb+0x1b4>
               pr = pr * 10 + f[0] - '0';
    1a6c:	0028971b          	slliw	a4,a7,0x2
    1a70:	0117073b          	addw	a4,a4,a7
    1a74:	0017171b          	slliw	a4,a4,0x1
               f++;
    1a78:	0485                	addi	s1,s1,1
               pr = pr * 10 + f[0] - '0';
    1a7a:	9f3d                	addw	a4,a4,a5
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1a7c:	0004c783          	lbu	a5,0(s1)
               pr = pr * 10 + f[0] - '0';
    1a80:	fd07089b          	addiw	a7,a4,-48
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1a84:	fd07871b          	addiw	a4,a5,-48
    1a88:	0ff77713          	zext.b	a4,a4
    1a8c:	fee6f0e3          	bgeu	a3,a4,1a6c <stbsp_vsprintfcb+0x7e6>
    1a90:	b26d                	j	143a <stbsp_vsprintfcb+0x1b4>
                  fl |= STBSP__METRIC_1024;
    1a92:	8f5d                	or	a4,a4,a5
    1a94:	00070e1b          	sext.w	t3,a4
    1a98:	0685                	addi	a3,a3,1
    1a9a:	baa9                	j	13f4 <stbsp_vsprintfcb+0x16e>
      *bf = 0;
    1a9c:	00040023          	sb	zero,0(s0)
    1aa0:	b209                	j	13a2 <stbsp_vsprintfcb+0x11c>
         if (f[0] == 'l') {
    1aa2:	0014c783          	lbu	a5,1(s1)
    1aa6:	06c00713          	li	a4,108
         fl |= ((sizeof(long) == 8) ? STBSP__INTMAX : 0);
    1aaa:	020e6e13          	ori	t3,t3,32
         if (f[0] == 'l') {
    1aae:	00e78c63          	beq	a5,a4,1ac6 <stbsp_vsprintfcb+0x840>
            ++f;
    1ab2:	0485                	addi	s1,s1,1
    1ab4:	ba65                	j	146c <stbsp_vsprintfcb+0x1e6>
         if (f[0] == 'h')
    1ab6:	0014c783          	lbu	a5,1(s1)
    1aba:	06800713          	li	a4,104
         fl |= STBSP__HALFWIDTH;
    1abe:	200e6e13          	ori	t3,t3,512
         if (f[0] == 'h')
    1ac2:	fee798e3          	bne	a5,a4,1ab2 <stbsp_vsprintfcb+0x82c>
         if ((f[1] == '6') && (f[2] == '4')) {
    1ac6:	0024c783          	lbu	a5,2(s1)
            ++f;
    1aca:	0489                	addi	s1,s1,2
    1acc:	b245                	j	146c <stbsp_vsprintfcb+0x1e6>
         s = va_arg(va, char *);
    1ace:	008b8713          	addi	a4,s7,8
    1ad2:	e0ba                	sd	a4,64(sp)
         if (fl & STBSP__INTMAX) {
    1ad4:	020e7693          	andi	a3,t3,32
    1ad8:	8772                	mv	a4,t3
    1ada:	24069ee3          	bnez	a3,2536 <stbsp_vsprintfcb+0x12b0>
            stbsp__int32 i = va_arg(va, stbsp__int32);
    1ade:	000ba683          	lw	a3,0(s7)
            if ((f[0] != 'u') && (i < 0)) {
    1ae2:	07500613          	li	a2,117
            n64 = (stbsp__uint32)i;
    1ae6:	02069f13          	slli	t5,a3,0x20
    1aea:	020f5f13          	srli	t5,t5,0x20
            if ((f[0] != 'u') && (i < 0)) {
    1aee:	00c78a63          	beq	a5,a2,1b02 <stbsp_vsprintfcb+0x87c>
    1af2:	0006d863          	bgez	a3,1b02 <stbsp_vsprintfcb+0x87c>
               fl |= STBSP__NEGATIVE;
    1af6:	08076713          	ori	a4,a4,128
               n64 = (stbsp__uint32)-i;
    1afa:	40d00f3b          	negw	t5,a3
               fl |= STBSP__NEGATIVE;
    1afe:	00070e1b          	sext.w	t3,a4
         if (fl & STBSP__METRIC_SUFFIX) {
    1b02:	100e7693          	andi	a3,t3,256
    1b06:	5c0683e3          	beqz	a3,28cc <stbsp_vsprintfcb+0x1646>
            if (n64 < 1024)
    1b0a:	3ff00793          	li	a5,1023
    1b0e:	01e7e463          	bltu	a5,t5,1b16 <stbsp_vsprintfcb+0x890>
    1b12:	0ea0106f          	j	2bfc <stbsp_vsprintfcb+0x1976>
            else if (pr == -1)
    1b16:	57fd                	li	a5,-1
    1b18:	30f887e3          	beq	a7,a5,2626 <stbsp_vsprintfcb+0x13a0>
            fv = (double)(stbsp__int64)n64;
    1b1c:	d22f7553          	fcvt.d.l	fa0,t5
            if (fl & STBSP__METRIC_1024)
    1b20:	034e1793          	slli	a5,t3,0x34
    1b24:	0007c463          	bltz	a5,1b2c <stbsp_vsprintfcb+0x8a6>
    1b28:	2300106f          	j	2d58 <stbsp_vsprintfcb+0x1ad2>
               divisor = 1024.0;
    1b2c:	00004797          	auipc	a5,0x4
    1b30:	cb47b787          	fld	fa5,-844(a5) # 57e0 <STDIN_FD+0x20>
               if ((fv < divisor) && (fv > -divisor))
    1b34:	22f79753          	fneg.d	fa4,fa5
               fl += 0x1000000;
    1b38:	010006b7          	lui	a3,0x1000
            while (fl < 0x4000000) {
    1b3c:	04000737          	lui	a4,0x4000
               if ((fv < divisor) && (fv > -divisor))
    1b40:	a2f517d3          	flt.d	a5,fa0,fa5
    1b44:	c789                	beqz	a5,1b4e <stbsp_vsprintfcb+0x8c8>
    1b46:	a2a717d3          	flt.d	a5,fa4,fa0
    1b4a:	3e079863          	bnez	a5,1f3a <stbsp_vsprintfcb+0xcb4>
               fl += 0x1000000;
    1b4e:	01c68e3b          	addw	t3,a3,t3
               fv /= divisor;
    1b52:	1af57553          	fdiv.d	fa0,fa0,fa5
            while (fl < 0x4000000) {
    1b56:	feee65e3          	bltu	t3,a4,1b40 <stbsp_vsprintfcb+0x8ba>
    1b5a:	a6c5                	j	1f3a <stbsp_vsprintfcb+0xcb4>
         h = (f[0] == 'X') ? hexu : hex;
    1b5c:	05800693          	li	a3,88
         if (fl & STBSP__INTMAX) {
    1b60:	020e7713          	andi	a4,t3,32
         h = (f[0] == 'X') ? hexu : hex;
    1b64:	00005817          	auipc	a6,0x5
    1b68:	e8480813          	addi	a6,a6,-380 # 69e8 <hex.0>
    1b6c:	00d79663          	bne	a5,a3,1b78 <stbsp_vsprintfcb+0x8f2>
    1b70:	00005817          	auipc	a6,0x5
    1b74:	e6080813          	addi	a6,a6,-416 # 69d0 <hexu.1>
         l = (4 << 4) | (4 << 8);
    1b78:	44000793          	li	a5,1088
    1b7c:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__LEADING_0X) {
    1b7e:	008e7793          	andi	a5,t3,8
    1b82:	7a079263          	bnez	a5,2326 <stbsp_vsprintfcb+0x10a0>
         lead[0] = 0;
    1b86:	06010423          	sb	zero,104(sp)
         s = va_arg(va, char *);
    1b8a:	008b8793          	addi	a5,s7,8
    1b8e:	e0be                	sd	a5,64(sp)
         if (fl & STBSP__INTMAX)
    1b90:	72070b63          	beqz	a4,22c6 <stbsp_vsprintfcb+0x1040>
            n64 = va_arg(va, stbsp__uint64);
    1b94:	000bb683          	ld	a3,0(s7)
         dp = 0;
    1b98:	d282                	sw	zero,100(sp)
         tail[0] = 0;
    1b9a:	06010823          	sb	zero,112(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    1b9e:	001e7513          	andi	a0,t3,1
         if (n64 == 0) {
    1ba2:	380694e3          	bnez	a3,272a <stbsp_vsprintfcb+0x14a4>
            lead[0] = 0;
    1ba6:	06010423          	sb	zero,104(sp)
            if (pr == 0) {
    1baa:	78089a63          	bnez	a7,233e <stbsp_vsprintfcb+0x10b8>
         if (fw < (stbsp__int32)n)
    1bae:	fffb4313          	not	t1,s6
    1bb2:	43f35313          	srai	t1,t1,0x3f
               l = 0;
    1bb6:	d082                	sw	zero,96(sp)
         if (fw < (stbsp__int32)n)
    1bb8:	01637333          	and	t1,t1,s6
               goto scopy;
    1bbc:	4701                	li	a4,0
    1bbe:	4f81                	li	t6,0
    1bc0:	4a01                	li	s4,0
               cs = 0;
    1bc2:	4281                	li	t0,0
         s = num + STBSP__NUMSZ;
    1bc4:	28010a93          	addi	s5,sp,640
         if ((fl & STBSP__LEFTJUST) == 0) {
    1bc8:	9c0506e3          	beqz	a0,1594 <stbsp_vsprintfcb+0x30e>
         if (fw + pr) {
    1bcc:	00e307bb          	addw	a5,t1,a4
    1bd0:	9c079fe3          	bnez	a5,15ae <stbsp_vsprintfcb+0x328>
    1bd4:	06910793          	addi	a5,sp,105
    1bd8:	b661                	j	1760 <stbsp_vsprintfcb+0x4da>
         h = (f[0] == 'E') ? hexu : hex;
    1bda:	04500713          	li	a4,69
    1bde:	00005317          	auipc	t1,0x5
    1be2:	e0a30313          	addi	t1,t1,-502 # 69e8 <hex.0>
    1be6:	1ce78ae3          	beq	a5,a4,25ba <stbsp_vsprintfcb+0x1334>
         fv = va_arg(va, double);
    1bea:	008b8713          	addi	a4,s7,8
         if (pr == -1)
    1bee:	57fd                	li	a5,-1
         fv = va_arg(va, double);
    1bf0:	e0ba                	sd	a4,64(sp)
    1bf2:	000bb507          	fld	fa0,0(s7)
         if (pr == -1)
    1bf6:	1af88ce3          	beq	a7,a5,25ae <stbsp_vsprintfcb+0x1328>
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr | 0x80000000))
    1bfa:	80000737          	lui	a4,0x80000
    1bfe:	00e8e733          	or	a4,a7,a4
    1c02:	2701                	sext.w	a4,a4
    1c04:	10d4                	addi	a3,sp,100
    1c06:	0110                	addi	a2,sp,128
    1c08:	108c                	addi	a1,sp,96
    1c0a:	18a8                	addi	a0,sp,120
    1c0c:	f41e                	sd	t2,40(sp)
    1c0e:	f01a                	sd	t1,32(sp)
    1c10:	ec72                	sd	t3,24(sp)
    1c12:	e846                	sd	a7,16(sp)
    1c14:	d8efe0ef          	jal	1a2 <stbsp__real_to_str>
    1c18:	68c2                	ld	a7,16(sp)
    1c1a:	6e62                	ld	t3,24(sp)
    1c1c:	7302                	ld	t1,32(sp)
    1c1e:	73a2                	ld	t2,40(sp)
         if (dp == STBSP__SPECIAL) {
    1c20:	5796                	lw	a5,100(sp)
            s = (char *)sn;
    1c22:	7ae6                	ld	s5,120(sp)
         if ((l - 1) > (stbsp__uint32)pr)
    1c24:	5686                	lw	a3,96(sp)
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr | 0x80000000))
    1c26:	3c0511e3          	bnez	a0,27e8 <stbsp_vsprintfcb+0x1562>
         tail[0] = 0;
    1c2a:	06010823          	sb	zero,112(sp)
   sign[0] = 0;
    1c2e:	06010423          	sb	zero,104(sp)
   } else if (fl & STBSP__LEADINGSPACE) {
    1c32:	004e7713          	andi	a4,t3,4
    1c36:	6a070ee3          	beqz	a4,2af2 <stbsp_vsprintfcb+0x186c>
      sign[0] = 1;
    1c3a:	6709                	lui	a4,0x2
    1c3c:	0705                	addi	a4,a4,1 # 2001 <stbsp_vsprintfcb+0xd7b>
    1c3e:	06e11423          	sh	a4,104(sp)
         if (dp == STBSP__SPECIAL) {
    1c42:	671d                	lui	a4,0x7
    1c44:	1ee794e3          	bne	a5,a4,262c <stbsp_vsprintfcb+0x13a6>
         if (pr < (stbsp__int32)l)
    1c48:	0006879b          	sext.w	a5,a3
         n = pr + lead[0] + tail[0] + tz;
    1c4c:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    1c50:	fff7c793          	not	a5,a5
         n = pr + lead[0] + tail[0] + tz;
    1c54:	07014f83          	lbu	t6,112(sp)
         if (pr < (stbsp__int32)l)
    1c58:	97fd                	srai	a5,a5,0x3f
    1c5a:	8ff5                	and	a5,a5,a3
         n = pr + lead[0] + tail[0] + tz;
    1c5c:	00fa073b          	addw	a4,s4,a5
    1c60:	01f7063b          	addw	a2,a4,t6
    1c64:	8732                	mv	a4,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    1c66:	001e7513          	andi	a0,t3,1
         if (pr < (stbsp__int32)l)
    1c6a:	2781                	sext.w	a5,a5
         if (fw < (stbsp__int32)n)
    1c6c:	835a                	mv	t1,s6
    1c6e:	00cb5363          	bge	s6,a2,1c74 <stbsp_vsprintfcb+0x9ee>
    1c72:	8332                	mv	t1,a2
         fw -= n;
    1c74:	40e3033b          	subw	t1,t1,a4
            cs = 0;
    1c78:	4281                	li	t0,0
         pr -= l;
    1c7a:	40d7873b          	subw	a4,a5,a3
      tz = 0;
    1c7e:	4881                	li	a7,0
            goto scopy;
    1c80:	b7a1                	j	1bc8 <stbsp_vsprintfcb+0x942>
         h = (f[0] == 'G') ? hexu : hex;
    1c82:	04700713          	li	a4,71
    1c86:	00005317          	auipc	t1,0x5
    1c8a:	d6230313          	addi	t1,t1,-670 # 69e8 <hex.0>
    1c8e:	14e783e3          	beq	a5,a4,25d4 <stbsp_vsprintfcb+0x134e>
         fv = va_arg(va, double);
    1c92:	008b8713          	addi	a4,s7,8
         if (pr == -1)
    1c96:	57fd                	li	a5,-1
         fv = va_arg(va, double);
    1c98:	e0ba                	sd	a4,64(sp)
    1c9a:	000bb507          	fld	fa0,0(s7)
         if (pr == -1)
    1c9e:	12f884e3          	beq	a7,a5,25c6 <stbsp_vsprintfcb+0x1340>
         else if (pr == 0)
    1ca2:	6e0887e3          	beqz	a7,2b90 <stbsp_vsprintfcb+0x190a>
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, (pr - 1) | 0x80000000))
    1ca6:	fff8871b          	addiw	a4,a7,-1
    1caa:	800007b7          	lui	a5,0x80000
    1cae:	8f5d                	or	a4,a4,a5
    1cb0:	2701                	sext.w	a4,a4
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    1cb2:	00088a9b          	sext.w	s5,a7
    1cb6:	8a46                	mv	s4,a7
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, (pr - 1) | 0x80000000))
    1cb8:	10d4                	addi	a3,sp,100
    1cba:	0110                	addi	a2,sp,128
    1cbc:	108c                	addi	a1,sp,96
    1cbe:	18a8                	addi	a0,sp,120
    1cc0:	f01e                	sd	t2,32(sp)
    1cc2:	ec1a                	sd	t1,24(sp)
    1cc4:	e872                	sd	t3,16(sp)
    1cc6:	cdcfe0ef          	jal	1a2 <stbsp__real_to_str>
    1cca:	6e42                	ld	t3,16(sp)
    1ccc:	6362                	ld	t1,24(sp)
    1cce:	7382                	ld	t2,32(sp)
    1cd0:	4281                	li	t0,0
    1cd2:	c509                	beqz	a0,1cdc <stbsp_vsprintfcb+0xa56>
            fl |= STBSP__NEGATIVE;
    1cd4:	080e6e13          	ori	t3,t3,128
    1cd8:	08000293          	li	t0,128
         if (l > (stbsp__uint32)pr)
    1cdc:	5806                	lw	a6,96(sp)
    1cde:	010af463          	bgeu	s5,a6,1ce6 <stbsp_vsprintfcb+0xa60>
            l = pr;
    1ce2:	d0d6                	sw	s5,96(sp)
    1ce4:	8856                	mv	a6,s5
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    1ce6:	4705                	li	a4,1
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    1ce8:	5796                	lw	a5,100(sp)
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    1cea:	01076463          	bltu	a4,a6,1cf2 <stbsp_vsprintfcb+0xa6c>
    1cee:	1800106f          	j	2e6e <stbsp_vsprintfcb+0x1be8>
    1cf2:	7be6                	ld	s7,120(sp)
    1cf4:	fff8071b          	addiw	a4,a6,-1
    1cf8:	1702                	slli	a4,a4,0x20
    1cfa:	9301                	srli	a4,a4,0x20
    1cfc:	001a0e9b          	addiw	t4,s4,1
    1d00:	75e2                	ld	a1,56(sp)
    1d02:	8ade                	mv	s5,s7
    1d04:	975e                	add	a4,a4,s7
    1d06:	410e8ebb          	subw	t4,t4,a6
    1d0a:	88d2                	mv	a7,s4
    1d0c:	86c2                	mv	a3,a6
    1d0e:	4f01                	li	t5,0
    1d10:	03000f93          	li	t6,48
    1d14:	e842                	sd	a6,16(sp)
    1d16:	a809                	j	1d28 <stbsp_vsprintfcb+0xaa2>
            --pr;
    1d18:	38fd                	addiw	a7,a7,-1
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    1d1a:	211e80e3          	beq	t4,a7,271a <stbsp_vsprintfcb+0x1494>
    1d1e:	177d                	addi	a4,a4,-1 # 6fff <_stdout+0x1df>
    1d20:	4f05                	li	t5,1
    1d22:	1e088ce3          	beqz	a7,271a <stbsp_vsprintfcb+0x1494>
            --l;
    1d26:	85b6                	mv	a1,a3
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    1d28:	00074803          	lbu	a6,0(a4)
    1d2c:	fff6861b          	addiw	a2,a3,-1 # ffffff <_ZSt4cerr+0xff8807>
    1d30:	0006851b          	sext.w	a0,a3
    1d34:	2581                	sext.w	a1,a1
    1d36:	0006069b          	sext.w	a3,a2
    1d3a:	fdf80fe3          	beq	a6,t6,1d18 <stbsp_vsprintfcb+0xa92>
    1d3e:	6842                	ld	a6,16(sp)
    1d40:	fc2e                	sd	a1,56(sp)
    1d42:	86c2                	mv	a3,a6
    1d44:	000f0463          	beqz	t5,1d4c <stbsp_vsprintfcb+0xac6>
    1d48:	d0ae                	sw	a1,96(sp)
    1d4a:	86ae                	mv	a3,a1
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    1d4c:	5775                	li	a4,-3
    1d4e:	08e7cee3          	blt	a5,a4,25ea <stbsp_vsprintfcb+0x1364>
    1d52:	08fa4be3          	blt	s4,a5,25e8 <stbsp_vsprintfcb+0x1362>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    1d56:	0005071b          	sext.w	a4,a0
         if (dp > 0) {
    1d5a:	7ef057e3          	blez	a5,2d48 <stbsp_vsprintfcb+0x1ac2>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    1d5e:	4881                	li	a7,0
    1d60:	00e7d463          	bge	a5,a4,1d68 <stbsp_vsprintfcb+0xae2>
    1d64:	40f508bb          	subw	a7,a0,a5
         tail[0] = 0;
    1d68:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    1d6c:	20029463          	bnez	t0,1f74 <stbsp_vsprintfcb+0xcee>
   } else if (fl & STBSP__LEADINGSPACE) {
    1d70:	004e7713          	andi	a4,t3,4
    1d74:	000715e3          	bnez	a4,257e <stbsp_vsprintfcb+0x12f8>
   } else if (fl & STBSP__LEADINGPLUS) {
    1d78:	002e7713          	andi	a4,t3,2
    1d7c:	660719e3          	bnez	a4,2bee <stbsp_vsprintfcb+0x1968>
   sign[0] = 0;
    1d80:	06010423          	sb	zero,104(sp)
    1d84:	aaed                	j	1f7e <stbsp_vsprintfcb+0xcf8>
         h = (f[0] == 'A') ? hexu : hex;
    1d86:	04100713          	li	a4,65
    1d8a:	00005597          	auipc	a1,0x5
    1d8e:	c5e58593          	addi	a1,a1,-930 # 69e8 <hex.0>
    1d92:	00e783e3          	beq	a5,a4,2598 <stbsp_vsprintfcb+0x1312>
         fv = va_arg(va, double);
    1d96:	008b8693          	addi	a3,s7,8
         if (pr == -1)
    1d9a:	577d                	li	a4,-1
         fv = va_arg(va, double);
    1d9c:	e0b6                	sd	a3,64(sp)
    1d9e:	000bb783          	ld	a5,0(s7)
         if (pr == -1)
    1da2:	7ee88963          	beq	a7,a4,2594 <stbsp_vsprintfcb+0x130e>
   d = value;

   STBSP__COPYFP(b, d);

   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    1da6:	4347d613          	srai	a2,a5,0x34
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    1daa:	00c79513          	slli	a0,a5,0xc
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    1dae:	7ff67613          	andi	a2,a2,2047
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    1db2:	8131                	srli	a0,a0,0xc
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    1db4:	c016061b          	addiw	a2,a2,-1023
         if (stbsp__real_to_parts((stbsp__int64 *)&n64, &dp, fv))
    1db8:	7a07c863          	bltz	a5,2568 <stbsp_vsprintfcb+0x12e2>
   } else if (fl & STBSP__LEADINGSPACE) {
    1dbc:	004e7793          	andi	a5,t3,4
    1dc0:	60078ee3          	beqz	a5,2bdc <stbsp_vsprintfcb+0x1956>
    1dc4:	6789                	lui	a5,0x2
    1dc6:	2785                	addiw	a5,a5,1 # 2001 <stbsp_vsprintfcb+0xd7b>
      sign[0] = 1;
    1dc8:	06f11423          	sh	a5,104(sp)
    1dcc:	468d                	li	a3,3
    1dce:	4a0d                	li	s4,3
    1dd0:	4809                	li	a6,2
            n64 |= (((stbsp__uint64)1) << 52);
    1dd2:	4705                	li	a4,1
    1dd4:	1752                	slli	a4,a4,0x34
         if (dp == -1023)
    1dd6:	c0100793          	li	a5,-1023
            n64 |= (((stbsp__uint64)1) << 52);
    1dda:	8f49                	or	a4,a4,a0
         if (dp == -1023)
    1ddc:	5cf600e3          	beq	a2,a5,2b9c <stbsp_vsprintfcb+0x1916>
         if (pr < 15)
    1de0:	4539                	li	a0,14
         n64 <<= (64 - 56);
    1de2:	00871793          	slli	a5,a4,0x8
         if (pr < 15)
    1de6:	251546e3          	blt	a0,a7,2832 <stbsp_vsprintfcb+0x15ac>
            n64 += ((((stbsp__uint64)8) << 56) >> (pr * 4));
    1dea:	4705                	li	a4,1
    1dec:	0028951b          	slliw	a0,a7,0x2
    1df0:	176e                	slli	a4,a4,0x3b
    1df2:	00a75733          	srl	a4,a4,a0
    1df6:	973e                	add	a4,a4,a5
         *s++ = h[(n64 >> 60) & 15];
    1df8:	03c75793          	srli	a5,a4,0x3c
    1dfc:	97ae                	add	a5,a5,a1
    1dfe:	0007c503          	lbu	a0,0(a5)
         lead[1 + lead[0]] = '0';
    1e02:	22080793          	addi	a5,a6,544
    1e06:	06010813          	addi	a6,sp,96
    1e0a:	97c2                	add	a5,a5,a6
    1e0c:	03000813          	li	a6,48
    1e10:	df078423          	sb	a6,-536(a5)
         lead[2 + lead[0]] = 'x';
    1e14:	22068793          	addi	a5,a3,544
    1e18:	1094                	addi	a3,sp,96
    1e1a:	96be                	add	a3,a3,a5
    1e1c:	07800793          	li	a5,120
    1e20:	def68423          	sb	a5,-536(a3)
         lead[0] += 2;
    1e24:	07410423          	sb	s4,104(sp)
         *s++ = h[(n64 >> 60) & 15];
    1e28:	0ca10023          	sb	a0,192(sp)
         if (pr)
    1e2c:	740893e3          	bnez	a7,2d72 <stbsp_vsprintfcb+0x1aec>
         sn = s;
    1e30:	0c110793          	addi	a5,sp,193
    1e34:	fcbe                	sd	a5,120(sp)
    1e36:	4701                	li	a4,0
    1e38:	4501                	li	a0,0
    1e3a:	4305                	li	t1,1
    1e3c:	4685                	li	a3,1
         tail[1] = h[17];
    1e3e:	0115c583          	lbu	a1,17(a1)
            tail[2] = '+';
    1e42:	02b00793          	li	a5,43
         tail[1] = h[17];
    1e46:	06b108a3          	sb	a1,113(sp)
         if (dp < 0) {
    1e4a:	00065663          	bgez	a2,1e56 <stbsp_vsprintfcb+0xbd0>
            dp = -dp;
    1e4e:	40c0063b          	negw	a2,a2
            tail[2] = '-';
    1e52:	02d00793          	li	a5,45
            tail[n] = '0' + dp % 10;
    1e56:	4829                	li	a6,10
    1e58:	030665bb          	remw	a1,a2,a6
    1e5c:	06f10923          	sb	a5,114(sp)
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    1e60:	3e700e93          	li	t4,999
            tail[n] = '0' + dp % 10;
    1e64:	0305859b          	addiw	a1,a1,48
    1e68:	0ff5f593          	zext.b	a1,a1
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    1e6c:	18cec3e3          	blt	t4,a2,27f2 <stbsp_vsprintfcb+0x156c>
    1e70:	06300e93          	li	t4,99
    1e74:	54cec1e3          	blt	t4,a2,2bb6 <stbsp_vsprintfcb+0x1930>
    1e78:	4ea5                	li	t4,9
    1e7a:	72ced6e3          	bge	t4,a2,2da6 <stbsp_vsprintfcb+0x1b20>
            dp /= 10;
    1e7e:	030647bb          	divw	a5,a2,a6
         tail[0] = (char)n;
    1e82:	4611                	li	a2,4
    1e84:	06c10823          	sb	a2,112(sp)
            tail[n] = '0' + dp % 10;
    1e88:	06b10a23          	sb	a1,116(sp)
    1e8c:	4811                	li	a6,4
    1e8e:	4f91                	li	t6,4
    1e90:	0307879b          	addiw	a5,a5,48
    1e94:	06f109a3          	sb	a5,115(sp)
         n = pr + lead[0] + tail[0] + tz;
    1e98:	006a07bb          	addw	a5,s4,t1
    1e9c:	010787bb          	addw	a5,a5,a6
    1ea0:	0117863b          	addw	a2,a5,a7
         dp = (int)(s - sn);
    1ea4:	d2aa                	sw	a0,100(sp)
         l = (int)(s - (num + 64));
    1ea6:	d0b6                	sw	a3,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    1ea8:	87b2                	mv	a5,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    1eaa:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    1eae:	835a                	mv	t1,s6
    1eb0:	00cb5363          	bge	s6,a2,1eb6 <stbsp_vsprintfcb+0xc30>
    1eb4:	8332                	mv	t1,a2
         cs = 1 + (3 << 24);
    1eb6:	030002b7          	lui	t0,0x3000
         fw -= n;
    1eba:	40f3033b          	subw	t1,t1,a5
         cs = 1 + (3 << 24);
    1ebe:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff8809>
         s = num + 64;
    1ec0:	0c010a93          	addi	s5,sp,192
         goto scopy;
    1ec4:	b311                	j	1bc8 <stbsp_vsprintfcb+0x942>
         h = (f[0] == 'B') ? hexu : hex;
    1ec6:	04200713          	li	a4,66
    1eca:	00005817          	auipc	a6,0x5
    1ece:	b1e80813          	addi	a6,a6,-1250 # 69e8 <hex.0>
    1ed2:	6ce78963          	beq	a5,a4,25a4 <stbsp_vsprintfcb+0x131e>
         if (fl & STBSP__LEADING_0X) {
    1ed6:	008e7793          	andi	a5,t3,8
    1eda:	66079e63          	bnez	a5,2556 <stbsp_vsprintfcb+0x12d0>
         lead[0] = 0;
    1ede:	06010423          	sb	zero,104(sp)
         l = (8 << 4) | (1 << 8);
    1ee2:	18000793          	li	a5,384
    1ee6:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__INTMAX) {
    1ee8:	020e7713          	andi	a4,t3,32
         goto radixnum;
    1eec:	b979                	j	1b8a <stbsp_vsprintfcb+0x904>
         *s = (char)va_arg(va, int);
    1eee:	000ba783          	lw	a5,0(s7)
         l = 1;
    1ef2:	4705                	li	a4,1
    1ef4:	d0ba                	sw	a4,96(sp)
         *s = (char)va_arg(va, int);
    1ef6:	26f10fa3          	sb	a5,639(sp)
    1efa:	008b8793          	addi	a5,s7,8
         lead[0] = 0;
    1efe:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    1f02:	06010823          	sb	zero,112(sp)
         dp = 0;
    1f06:	d282                	sw	zero,100(sp)
         *s = (char)va_arg(va, int);
    1f08:	e0be                	sd	a5,64(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    1f0a:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    1f0e:	835a                	mv	t1,s6
    1f10:	69605063          	blez	s6,2590 <stbsp_vsprintfcb+0x130a>
         fw -= n;
    1f14:	337d                	addiw	t1,t1,-1
         goto scopy;
    1f16:	4701                	li	a4,0
    1f18:	4f81                	li	t6,0
    1f1a:	4685                	li	a3,1
    1f1c:	4a01                	li	s4,0
         cs = 0;
    1f1e:	4281                	li	t0,0
         s = num + STBSP__NUMSZ - 1;
    1f20:	27f10a93          	addi	s5,sp,639
      tz = 0;
    1f24:	4881                	li	a7,0
         goto scopy;
    1f26:	b14d                	j	1bc8 <stbsp_vsprintfcb+0x942>
         fv = va_arg(va, double);
    1f28:	008b8713          	addi	a4,s7,8
         if (fl & STBSP__METRIC_SUFFIX) {
    1f2c:	100e7793          	andi	a5,t3,256
         fv = va_arg(va, double);
    1f30:	e0ba                	sd	a4,64(sp)
    1f32:	000bb507          	fld	fa0,0(s7)
         if (fl & STBSP__METRIC_SUFFIX) {
    1f36:	be0795e3          	bnez	a5,1b20 <stbsp_vsprintfcb+0x89a>
         if (pr == -1)
    1f3a:	57fd                	li	a5,-1
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    1f3c:	0008871b          	sext.w	a4,a7
         if (pr == -1)
    1f40:	00f89463          	bne	a7,a5,1f48 <stbsp_vsprintfcb+0xcc2>
    1f44:	4719                	li	a4,6
            pr = 6; // default is 6
    1f46:	4899                	li	a7,6
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    1f48:	10d4                	addi	a3,sp,100
    1f4a:	0110                	addi	a2,sp,128
    1f4c:	108c                	addi	a1,sp,96
    1f4e:	18a8                	addi	a0,sp,120
    1f50:	f01e                	sd	t2,32(sp)
    1f52:	ec72                	sd	t3,24(sp)
    1f54:	e846                	sd	a7,16(sp)
    1f56:	a4cfe0ef          	jal	1a2 <stbsp__real_to_str>
    1f5a:	6e62                	ld	t3,24(sp)
    1f5c:	68c2                	ld	a7,16(sp)
    1f5e:	7382                	ld	t2,32(sp)
         if (dp == STBSP__SPECIAL) {
    1f60:	5796                	lw	a5,100(sp)
            if ((stbsp__int32)(l + n) > pr)
    1f62:	5686                	lw	a3,96(sp)
   if (fl & STBSP__NEGATIVE) {
    1f64:	080e7293          	andi	t0,t3,128
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    1f68:	e00500e3          	beqz	a0,1d68 <stbsp_vsprintfcb+0xae2>
            fl |= STBSP__NEGATIVE;
    1f6c:	080e6e13          	ori	t3,t3,128
         tail[0] = 0;
    1f70:	06010823          	sb	zero,112(sp)
      sign[0] = 1;
    1f74:	670d                	lui	a4,0x3
    1f76:	d0170713          	addi	a4,a4,-767 # 2d01 <stbsp_vsprintfcb+0x1a7b>
    1f7a:	06e11423          	sh	a4,104(sp)
         if (dp == STBSP__SPECIAL) {
    1f7e:	671d                	lui	a4,0x7
    1f80:	7ce78963          	beq	a5,a4,2752 <stbsp_vsprintfcb+0x14cc>
         if (dp <= 0) {
    1f84:	46f05fe3          	blez	a5,2c02 <stbsp_vsprintfcb+0x197c>
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((600 - (stbsp__uint32)dp) % 3) : 0;
    1f88:	040e7313          	andi	t1,t3,64
    1f8c:	00078e9b          	sext.w	t4,a5
    1f90:	4581                	li	a1,0
    1f92:	00030963          	beqz	t1,1fa4 <stbsp_vsprintfcb+0xd1e>
    1f96:	25800593          	li	a1,600
    1f9a:	41d585bb          	subw	a1,a1,t4
    1f9e:	470d                	li	a4,3
    1fa0:	02e5f5bb          	remuw	a1,a1,a4
                     *s++ = stbsp__comma;
    1fa4:	00005a17          	auipc	s4,0x5
    1fa8:	95ca0a13          	addi	s4,s4,-1700 # 6900 <stbsp__digitpair>
            s = (char *)sn;
    1fac:	7f66                	ld	t5,120(sp)
                     *s++ = stbsp__comma;
    1fae:	0cda4283          	lbu	t0,205(s4)
         s = num + 64;
    1fb2:	0c010a93          	addi	s5,sp,192
            if ((stbsp__uint32)dp >= l) {
    1fb6:	44defb63          	bgeu	t4,a3,240c <stbsp_vsprintfcb+0x1186>
               n = 0;
    1fba:	4501                	li	a0,0
         s = num + 64;
    1fbc:	8756                	mv	a4,s5
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    1fbe:	4b91                	li	s7,4
    1fc0:	a015                	j	1fe4 <stbsp_vsprintfcb+0xd5e>
    1fc2:	8642                	mv	a2,a6
    1fc4:	883a                	mv	a6,a4
    1fc6:	8732                	mv	a4,a2
                     *s++ = sn[n];
    1fc8:	02051613          	slli	a2,a0,0x20
    1fcc:	9201                	srli	a2,a2,0x20
    1fce:	967a                	add	a2,a2,t5
    1fd0:	00064f83          	lbu	t6,0(a2)
                     ++n;
    1fd4:	0015061b          	addiw	a2,a0,1
    1fd8:	0006051b          	sext.w	a0,a2
                     *s++ = sn[n];
    1fdc:	fff70fa3          	sb	t6,-1(a4) # 6fff <_stdout+0x1df>
                     if (n >= (stbsp__uint32)dp)
    1fe0:	7bd57563          	bgeu	a0,t4,278a <stbsp_vsprintfcb+0x1504>
                     *s++ = stbsp__comma;
    1fe4:	00170813          	addi	a6,a4,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    1fe8:	fc030de3          	beqz	t1,1fc2 <stbsp_vsprintfcb+0xd3c>
    1fec:	2585                	addiw	a1,a1,1
    1fee:	fd759ae3          	bne	a1,s7,1fc2 <stbsp_vsprintfcb+0xd3c>
                     *s++ = stbsp__comma;
    1ff2:	fe580fa3          	sb	t0,-1(a6)
    1ff6:	0709                	addi	a4,a4,2
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    1ff8:	4585                	li	a1,1
    1ffa:	b7f9                	j	1fc8 <stbsp_vsprintfcb+0xd42>
         *d = tlen + (int)(bf - buf);
    1ffc:	000bb703          	ld	a4,0(s7)
    2000:	412407b3          	sub	a5,s0,s2
    2004:	01a787bb          	addw	a5,a5,s10
         int *d = va_arg(va, int *);
    2008:	008b8693          	addi	a3,s7,8
    200c:	e0b6                	sd	a3,64(sp)
         *d = tlen + (int)(bf - buf);
    200e:	c31c                	sw	a5,0(a4)
      } break;
    2010:	bae5                	j	1a08 <stbsp_vsprintfcb+0x782>
         if (fl & STBSP__LEADING_0X) {
    2012:	008e7793          	andi	a5,t3,8
    2016:	50079b63          	bnez	a5,252c <stbsp_vsprintfcb+0x12a6>
         lead[0] = 0;
    201a:	06010423          	sb	zero,104(sp)
         l = (3 << 4) | (3 << 8);
    201e:	33000793          	li	a5,816
    2022:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__INTMAX) {
    2024:	020e7713          	andi	a4,t3,32
         h = hexu;
    2028:	00005817          	auipc	a6,0x5
    202c:	9a880813          	addi	a6,a6,-1624 # 69d0 <hexu.1>
         goto radixnum;
    2030:	bea9                	j	1b8a <stbsp_vsprintfcb+0x904>
         fl &= ~STBSP__LEADINGZERO; // 'p' only prints the pointer with zeros
    2032:	fefe7e13          	andi	t3,t3,-17
    2036:	020e6e13          	ori	t3,t3,32
    203a:	02000713          	li	a4,32
         pr = sizeof(void *) * 2;
    203e:	48c1                	li	a7,16
         h = (f[0] == 'X') ? hexu : hex;
    2040:	00005817          	auipc	a6,0x5
    2044:	9a880813          	addi	a6,a6,-1624 # 69e8 <hex.0>
    2048:	be05                	j	1b78 <stbsp_vsprintfcb+0x8f2>
         s = va_arg(va, char *);
    204a:	000bba83          	ld	s5,0(s7)
    204e:	008b8793          	addi	a5,s7,8
    2052:	e0be                	sd	a5,64(sp)
         if (s == 0)
    2054:	360a8ee3          	beqz	s5,2bd0 <stbsp_vsprintfcb+0x194a>
      if (((stbsp__uintptr)sn & 3) == 0)
    2058:	003af793          	andi	a5,s5,3
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    205c:	5208c663          	bltz	a7,2588 <stbsp_vsprintfcb+0x1302>
    2060:	0008869b          	sext.w	a3,a7
      if (((stbsp__uintptr)sn & 3) == 0)
    2064:	2a0782e3          	beqz	a5,2b08 <stbsp_vsprintfcb+0x1882>
      if (!limit || *sn == 0)
    2068:	5a068b63          	beqz	a3,261e <stbsp_vsprintfcb+0x1398>
      if (((stbsp__uintptr)sn & 3) == 0)
    206c:	87d6                	mv	a5,s5
    206e:	a801                	j	207e <stbsp_vsprintfcb+0xdf8>
      ++sn;
    2070:	0785                	addi	a5,a5,1
      if (((stbsp__uintptr)sn & 3) == 0)
    2072:	0037f713          	andi	a4,a5,3
      --limit;
    2076:	36fd                	addiw	a3,a3,-1
      if (((stbsp__uintptr)sn & 3) == 0)
    2078:	280709e3          	beqz	a4,2b0a <stbsp_vsprintfcb+0x1884>
      if (!limit || *sn == 0)
    207c:	c681                	beqz	a3,2084 <stbsp_vsprintfcb+0xdfe>
    207e:	0007c703          	lbu	a4,0(a5)
    2082:	f77d                	bnez	a4,2070 <stbsp_vsprintfcb+0xdea>
         return (stbsp__uint32)(sn - s);
    2084:	415787b3          	sub	a5,a5,s5
    2088:	0007869b          	sext.w	a3,a5
         if (pr < (stbsp__int32)l)
    208c:	fff6c713          	not	a4,a3
    2090:	977d                	srai	a4,a4,0x3f
    2092:	8f7d                	and	a4,a4,a5
    2094:	0007079b          	sext.w	a5,a4
         n = pr + lead[0] + tail[0] + tz;
    2098:	863e                	mv	a2,a5
         pr -= l;
    209a:	9f15                	subw	a4,a4,a3
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    209c:	d0b6                	sw	a3,96(sp)
         lead[0] = 0;
    209e:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    20a2:	06010823          	sb	zero,112(sp)
         dp = 0;
    20a6:	d282                	sw	zero,100(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    20a8:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    20ac:	835a                	mv	t1,s6
    20ae:	00fb5363          	bge	s6,a5,20b4 <stbsp_vsprintfcb+0xe2e>
    20b2:	833e                	mv	t1,a5
         fw -= n;
    20b4:	40c3033b          	subw	t1,t1,a2
         goto scopy;
    20b8:	4f81                	li	t6,0
    20ba:	4a01                	li	s4,0
         cs = 0;
    20bc:	4281                	li	t0,0
      tz = 0;
    20be:	4881                	li	a7,0
         goto scopy;
    20c0:	b621                	j	1bc8 <stbsp_vsprintfcb+0x942>
                     *bf++ = stbsp__comma;
    20c2:	87b2                	mv	a5,a2
                     cs = 0;
    20c4:	4a01                	li	s4,0
    20c6:	e44ff06f          	j	170a <stbsp_vsprintfcb+0x484>
               lead[0] -= (char)i;
    20ca:	06010423          	sb	zero,104(sp)
               while (i) {
    20ce:	d38ff06f          	j	1606 <stbsp_vsprintfcb+0x380>
            lead[0] -= (char)i;
    20d2:	06010423          	sb	zero,104(sp)
            while (i) {
    20d6:	ed8ff06f          	j	17ae <stbsp_vsprintfcb+0x528>
            while (i >= 4) {
    20da:	06fadc63          	bge	s5,a5,2152 <stbsp_vsprintfcb+0xecc>
            tz -= i;
    20de:	8722                	mv	a4,s0
    20e0:	0007851b          	sext.w	a0,a5
            while (i >= 4) {
    20e4:	008785bb          	addw	a1,a5,s0
               *(stbsp__uint32 *)bf = 0x30303030;
    20e8:	01672023          	sw	s6,0(a4)
               bf += 4;
    20ec:	0711                	addi	a4,a4,4
            while (i >= 4) {
    20ee:	40e5863b          	subw	a2,a1,a4
    20f2:	fecacbe3          	blt	s5,a2,20e8 <stbsp_vsprintfcb+0xe62>
    20f6:	ffc5061b          	addiw	a2,a0,-4
    20fa:	0026561b          	srliw	a2,a2,0x2
    20fe:	0016071b          	addiw	a4,a2,1
    2102:	37f1                	addiw	a5,a5,-4
    2104:	0026161b          	slliw	a2,a2,0x2
    2108:	070a                	slli	a4,a4,0x2
    210a:	9722                	add	a4,a4,s0
    210c:	9f91                	subw	a5,a5,a2
            while (i) {
    210e:	843a                	mv	s0,a4
    2110:	80078de3          	beqz	a5,192a <stbsp_vsprintfcb+0x6a4>
    2114:	1782                	slli	a5,a5,0x20
    2116:	9381                	srli	a5,a5,0x20
    2118:	00f70433          	add	s0,a4,a5
               *bf++ = '0';
    211c:	0705                	addi	a4,a4,1
    211e:	ff470fa3          	sb	s4,-1(a4)
            while (i) {
    2122:	fe871de3          	bne	a4,s0,211c <stbsp_vsprintfcb+0xe96>
    2126:	805ff06f          	j	192a <stbsp_vsprintfcb+0x6a4>
               stbsp__cb_buf_clamp(i, pr);
    212a:	85ce                	mv	a1,s3
               if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    212c:	4981                	li	s3,0
    212e:	dc049263          	bnez	s1,16f2 <stbsp_vsprintfcb+0x46c>
    2132:	b8d5                	j	1a26 <stbsp_vsprintfcb+0x7a0>
            STBSP__UNALIGNED(while (i >= 4) {
    2134:	4401                	li	s0,0
    2136:	85be                	mv	a1,a5
    2138:	f0ea4b63          	blt	s4,a4,184e <stbsp_vsprintfcb+0x5c8>
    213c:	f42ff06f          	j	187e <stbsp_vsprintfcb+0x5f8>
               if ((((stbsp__uintptr)bf) & 3) == 0)
    2140:	00347713          	andi	a4,s0,3
            stbsp__cb_buf_clamp(i, tz);
    2144:	87c6                	mv	a5,a7
            tz -= i;
    2146:	4881                	li	a7,0
               if ((((stbsp__uintptr)bf) & 3) == 0)
    2148:	fc071c63          	bnez	a4,1920 <stbsp_vsprintfcb+0x69a>
            while (i >= 4) {
    214c:	470d                	li	a4,3
    214e:	f8f748e3          	blt	a4,a5,20de <stbsp_vsprintfcb+0xe58>
    2152:	8722                	mv	a4,s0
    2154:	b7c1                	j	2114 <stbsp_vsprintfcb+0xe8e>
            tail[0] -= (char)i;
    2156:	06010823          	sb	zero,112(sp)
            while (i) {
    215a:	b0b9                	j	19a8 <stbsp_vsprintfcb+0x722>
                  while (i >= 4) {
    215c:	478d                	li	a5,3
    215e:	8622                	mv	a2,s0
    2160:	d8b7d963          	bge	a5,a1,16f2 <stbsp_vsprintfcb+0x46c>
    2164:	ffc5839b          	addiw	t2,a1,-4
    2168:	0023d79b          	srliw	a5,t2,0x2
    216c:	0017859b          	addiw	a1,a5,1
    2170:	058a                	slli	a1,a1,0x2
    2172:	942e                	add	s0,s0,a1
                     *(stbsp__uint32 *)bf = 0x30303030;
    2174:	01762023          	sw	s7,0(a2)
                     bf += 4;
    2178:	0611                	addi	a2,a2,4
                  while (i >= 4) {
    217a:	fe861de3          	bne	a2,s0,2174 <stbsp_vsprintfcb+0xeee>
    217e:	0027979b          	slliw	a5,a5,0x2
    2182:	40f385bb          	subw	a1,t2,a5
    2186:	d68ff06f          	j	16ee <stbsp_vsprintfcb+0x468>
            while (i) {
    218a:	85be                	mv	a1,a5
    218c:	ee071963          	bnez	a4,187e <stbsp_vsprintfcb+0x5f8>
    2190:	f16ff06f          	j	18a6 <stbsp_vsprintfcb+0x620>
    2194:	2c013a03          	ld	s4,704(sp)
    2198:	2b813a83          	ld	s5,696(sp)
    219c:	2b013b03          	ld	s6,688(sp)
    21a0:	8ca2                	mv	s9,s0
    21a2:	a04ff06f          	j	13a6 <stbsp_vsprintfcb+0x120>
            stbsp__chk_cb_buf(1);
    21a6:	2601                	sext.w	a2,a2
    21a8:	1fe00793          	li	a5,510
    21ac:	f8c7c563          	blt	a5,a2,1936 <stbsp_vsprintfcb+0x6b0>
    21b0:	f3eff06f          	j	18ee <stbsp_vsprintfcb+0x668>
               fl &= ~STBSP__TRIPLET_COMMA; // if no leading zeros, then no commas
    21b4:	fbfe7e13          	andi	t3,t3,-65
         if (fw + pr) {
    21b8:	006707bb          	addw	a5,a4,t1
               fl &= ~STBSP__TRIPLET_COMMA; // if no leading zeros, then no commas
    21bc:	2e01                	sext.w	t3,t3
         if (fw + pr) {
    21be:	a0078be3          	beqz	a5,1bd4 <stbsp_vsprintfcb+0x94e>
               while (fw > 0) {
    21c2:	be605663          	blez	t1,15ae <stbsp_vsprintfcb+0x328>
                     *(stbsp__uint32 *)bf = 0x20202020;
    21c6:	20202837          	lui	a6,0x20202
                  stbsp__cb_buf_clamp(i, fw);
    21ca:	854a                	mv	a0,s2
    21cc:	894e                	mv	s2,s3
    21ce:	69a2                	ld	s3,8(sp)
                     *(stbsp__uint32 *)bf = 0x20202020;
    21d0:	02080813          	addi	a6,a6,32 # 20202020 <_ZSt4cerr+0x201fa828>
                  stbsp__cb_buf_clamp(i, fw);
    21d4:	ec52                	sd	s4,24(sp)
    21d6:	f426                	sd	s1,40(sp)
    21d8:	87a2                	mv	a5,s0
    21da:	84ea                	mv	s1,s10
                  stbsp__chk_cb_buf(1);
    21dc:	1fe00f13          	li	t5,510
                  stbsp__cb_buf_clamp(i, fw);
    21e0:	8d6e                	mv	s10,s11
                     *bf++ = ' ';
    21e2:	02000b13          	li	s6,32
                  stbsp__cb_buf_clamp(i, fw);
    21e6:	8de6                	mv	s11,s9
                  while (i >= 4) {
    21e8:	4b8d                	li	s7,3
                  stbsp__cb_buf_clamp(i, fw);
    21ea:	20000e93          	li	t4,512
    21ee:	e846                	sd	a7,16(sp)
    21f0:	f07e                	sd	t6,32(sp)
    21f2:	f836                	sd	a3,48(sp)
    21f4:	e4f2                	sd	t3,72(sp)
    21f6:	e8ba                	sd	a4,80(sp)
    21f8:	ec96                	sd	t0,88(sp)
    21fa:	841a                	mv	s0,t1
    21fc:	8a42                	mv	s4,a6
    21fe:	8c9e                	mv	s9,t2
    2200:	0c090063          	beqz	s2,22c0 <stbsp_vsprintfcb+0x103a>
    2204:	40a78633          	sub	a2,a5,a0
    2208:	40ce873b          	subw	a4,t4,a2
    220c:	86ba                	mv	a3,a4
    220e:	00e45363          	bge	s0,a4,2214 <stbsp_vsprintfcb+0xf8e>
    2212:	86a2                	mv	a3,s0
    2214:	0006871b          	sext.w	a4,a3
                  fw -= i;
    2218:	9c15                	subw	s0,s0,a3
                  while (i) {
    221a:	e719                	bnez	a4,2228 <stbsp_vsprintfcb+0xfa2>
    221c:	a095                	j	2280 <stbsp_vsprintfcb+0xffa>
                     *bf++ = ' ';
    221e:	01678023          	sb	s6,0(a5)
                     --i;
    2222:	377d                	addiw	a4,a4,-1
                     *bf++ = ' ';
    2224:	0785                	addi	a5,a5,1
                  while (i) {
    2226:	cb29                	beqz	a4,2278 <stbsp_vsprintfcb+0xff2>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    2228:	0037f693          	andi	a3,a5,3
    222c:	faed                	bnez	a3,221e <stbsp_vsprintfcb+0xf98>
                  while (i >= 4) {
    222e:	86be                	mv	a3,a5
    2230:	00070f9b          	sext.w	t6,a4
    2234:	00f705bb          	addw	a1,a4,a5
    2238:	02ebd763          	bge	s7,a4,2266 <stbsp_vsprintfcb+0xfe0>
                     *(stbsp__uint32 *)bf = 0x20202020;
    223c:	0146a023          	sw	s4,0(a3)
                     bf += 4;
    2240:	0691                	addi	a3,a3,4
                  while (i >= 4) {
    2242:	40d5863b          	subw	a2,a1,a3
    2246:	fecbcbe3          	blt	s7,a2,223c <stbsp_vsprintfcb+0xfb6>
    224a:	ffcf861b          	addiw	a2,t6,-4 # fffffffff7fffffc <_ZSt4cerr+0xfffffffff7ff8804>
    224e:	0026561b          	srliw	a2,a2,0x2
    2252:	0016069b          	addiw	a3,a2,1
    2256:	3771                	addiw	a4,a4,-4
    2258:	0026161b          	slliw	a2,a2,0x2
    225c:	068a                	slli	a3,a3,0x2
    225e:	96be                	add	a3,a3,a5
    2260:	9f11                	subw	a4,a4,a2
                  while (i) {
    2262:	87b6                	mv	a5,a3
    2264:	cb11                	beqz	a4,2278 <stbsp_vsprintfcb+0xff2>
    2266:	1702                	slli	a4,a4,0x20
    2268:	9301                	srli	a4,a4,0x20
    226a:	00e687b3          	add	a5,a3,a4
                     *bf++ = ' ';
    226e:	0685                	addi	a3,a3,1
    2270:	ff668fa3          	sb	s6,-1(a3)
                  while (i) {
    2274:	fef69de3          	bne	a3,a5,226e <stbsp_vsprintfcb+0xfe8>
                  stbsp__chk_cb_buf(1);
    2278:	40a78633          	sub	a2,a5,a0
    227c:	00090e63          	beqz	s2,2298 <stbsp_vsprintfcb+0x1012>
    2280:	2601                	sext.w	a2,a2
    2282:	00cf5b63          	bge	t5,a2,2298 <stbsp_vsprintfcb+0x1012>
    2286:	85ce                	mv	a1,s3
    2288:	9cb1                	addw	s1,s1,a2
    228a:	9902                	jalr	s2
    228c:	c541                	beqz	a0,2314 <stbsp_vsprintfcb+0x108e>
    228e:	87aa                	mv	a5,a0
    2290:	20000e93          	li	t4,512
    2294:	1fe00f13          	li	t5,510
               while (fw > 0) {
    2298:	f68044e3          	bgtz	s0,2200 <stbsp_vsprintfcb+0xf7a>
    229c:	8322                	mv	t1,s0
    229e:	89ca                	mv	s3,s2
    22a0:	83e6                	mv	t2,s9
    22a2:	68c2                	ld	a7,16(sp)
    22a4:	8cee                	mv	s9,s11
    22a6:	6a62                	ld	s4,24(sp)
    22a8:	8dea                	mv	s11,s10
    22aa:	7f82                	ld	t6,32(sp)
    22ac:	8d26                	mv	s10,s1
    22ae:	76c2                	ld	a3,48(sp)
    22b0:	6e26                	ld	t3,72(sp)
    22b2:	6746                	ld	a4,80(sp)
    22b4:	62e6                	ld	t0,88(sp)
    22b6:	74a2                	ld	s1,40(sp)
    22b8:	892a                	mv	s2,a0
    22ba:	843e                	mv	s0,a5
    22bc:	af2ff06f          	j	15ae <stbsp_vsprintfcb+0x328>
                  stbsp__cb_buf_clamp(i, fw);
    22c0:	8722                	mv	a4,s0
    22c2:	4401                	li	s0,0
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    22c4:	b795                	j	2228 <stbsp_vsprintfcb+0xfa2>
            n64 = va_arg(va, stbsp__uint32);
    22c6:	000be683          	lwu	a3,0(s7)
    22ca:	b0f9                	j	1b98 <stbsp_vsprintfcb+0x912>
    22cc:	2c013a03          	ld	s4,704(sp)
    22d0:	2b813a83          	ld	s5,696(sp)
    22d4:	2b013b03          	ld	s6,688(sp)
    22d8:	8cca                	mv	s9,s2
    22da:	8ccff06f          	j	13a6 <stbsp_vsprintfcb+0x120>
    22de:	8cd6                	mv	s9,s5
    22e0:	2c013a03          	ld	s4,704(sp)
    22e4:	2b813a83          	ld	s5,696(sp)
    22e8:	2b013b03          	ld	s6,688(sp)
    22ec:	8baff06f          	j	13a6 <stbsp_vsprintfcb+0x120>
    22f0:	2c013a03          	ld	s4,704(sp)
    22f4:	2b813a83          	ld	s5,696(sp)
    22f8:	2b013b03          	ld	s6,688(sp)
    22fc:	8cea                	mv	s9,s10
    22fe:	8a8ff06f          	j	13a6 <stbsp_vsprintfcb+0x120>
                  while (i) {
    2302:	85a2                	mv	a1,s0
    2304:	c12ff06f          	j	1716 <stbsp_vsprintfcb+0x490>
                  while (i >= 4) {
    2308:	478d                	li	a5,3
    230a:	8622                	mv	a2,s0
    230c:	e4b7cce3          	blt	a5,a1,2164 <stbsp_vsprintfcb+0xede>
    2310:	be2ff06f          	j	16f2 <stbsp_vsprintfcb+0x46c>
    2314:	2c013a03          	ld	s4,704(sp)
    2318:	2b813a83          	ld	s5,696(sp)
    231c:	2b013b03          	ld	s6,688(sp)
    2320:	8ca6                	mv	s9,s1
    2322:	884ff06f          	j	13a6 <stbsp_vsprintfcb+0x120>
            lead[2] = h[16];
    2326:	01084683          	lbu	a3,16(a6)
            lead[0] = 2;
    232a:	678d                	lui	a5,0x3
    232c:	0789                	addi	a5,a5,2 # 3002 <sprintf+0x44>
    232e:	06f11423          	sh	a5,104(sp)
            lead[2] = h[16];
    2332:	06d10523          	sb	a3,106(sp)
    2336:	b891                	j	1b8a <stbsp_vsprintfcb+0x904>
    2338:	8cea                	mv	s9,s10
    233a:	86cff06f          	j	13a6 <stbsp_vsprintfcb+0x120>
    233e:	4f81                	li	t6,0
    2340:	4a01                	li	s4,0
    2342:	5586                	lw	a1,96(sp)
                  *--s = stbsp__comma;
    2344:	00004f17          	auipc	t5,0x4
    2348:	689f4f03          	lbu	t5,1673(t5) # 69cd <stbsp__comma>
    234c:	0510                	addi	a2,sp,640
    234e:	0085d71b          	srliw	a4,a1,0x8
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    2352:	4305                	li	t1,1
            if (fl & STBSP__TRIPLET_COMMA) {
    2354:	040e7e93          	andi	t4,t3,64
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    2358:	0007029b          	sext.w	t0,a4
    235c:	005317bb          	sllw	a5,t1,t0
    2360:	37fd                	addiw	a5,a5,-1
    2362:	8ff5                	and	a5,a5,a3
    2364:	97c2                	add	a5,a5,a6
    2366:	0007c783          	lbu	a5,0(a5)
            n64 >>= (l >> 8);
    236a:	0056d6b3          	srl	a3,a3,t0
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    236e:	fff60a93          	addi	s5,a2,-1
    2372:	fef60fa3          	sb	a5,-1(a2)
            if (!((n64) || ((stbsp__int32)((num + STBSP__NUMSZ) - s) < pr)))
    2376:	e691                	bnez	a3,2382 <stbsp_vsprintfcb+0x10fc>
    2378:	051c                	addi	a5,sp,640
    237a:	415787bb          	subw	a5,a5,s5
    237e:	0317dd63          	bge	a5,a7,23b8 <stbsp_vsprintfcb+0x1132>
            if (fl & STBSP__TRIPLET_COMMA) {
    2382:	020e8963          	beqz	t4,23b4 <stbsp_vsprintfcb+0x112e>
               ++l;
    2386:	0015879b          	addiw	a5,a1,1
               if ((l & 15) == ((l >> 4) & 15)) {
    238a:	0047d29b          	srliw	t0,a5,0x4
    238e:	00f2c2b3          	xor	t0,t0,a5
    2392:	00f2f293          	andi	t0,t0,15
               ++l;
    2396:	0007859b          	sext.w	a1,a5
               if ((l & 15) == ((l >> 4) & 15)) {
    239a:	0087d71b          	srliw	a4,a5,0x8
    239e:	00029b63          	bnez	t0,23b4 <stbsp_vsprintfcb+0x112e>
                  l &= ~15;
    23a2:	9bc1                	andi	a5,a5,-16
    23a4:	0007859b          	sext.w	a1,a5
                  *--s = stbsp__comma;
    23a8:	ffe60a93          	addi	s5,a2,-2
    23ac:	ffe60f23          	sb	t5,-2(a2)
    23b0:	0087d71b          	srliw	a4,a5,0x8
    23b4:	8656                	mv	a2,s5
    23b6:	b74d                	j	2358 <stbsp_vsprintfcb+0x10d2>
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    23b8:	0045d29b          	srliw	t0,a1,0x4
    23bc:	0f0006b7          	lui	a3,0xf000
         if (pr < (stbsp__int32)l)
    23c0:	0007871b          	sext.w	a4,a5
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    23c4:	0182929b          	slliw	t0,t0,0x18
    23c8:	00d2f2b3          	and	t0,t0,a3
         n = pr + lead[0] + tail[0] + tz;
    23cc:	00ef863b          	addw	a2,t6,a4
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    23d0:	d0be                	sw	a5,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    23d2:	8fb2                	mv	t6,a2
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    23d4:	86be                	mv	a3,a5
    23d6:	00f282bb          	addw	t0,t0,a5
         if (fw < (stbsp__int32)n)
    23da:	835a                	mv	t1,s6
    23dc:	00cb5363          	bge	s6,a2,23e2 <stbsp_vsprintfcb+0x115c>
    23e0:	8332                	mv	t1,a2
         fw -= n;
    23e2:	41f3033b          	subw	t1,t1,t6
         pr -= l;
    23e6:	9f1d                	subw	a4,a4,a5
         goto scopy;
    23e8:	4f81                	li	t6,0
      tz = 0;
    23ea:	4881                	li	a7,0
         goto scopy;
    23ec:	fdcff06f          	j	1bc8 <stbsp_vsprintfcb+0x942>
    23f0:	8cda                	mv	s9,s6
    23f2:	2c013a03          	ld	s4,704(sp)
    23f6:	2b813a83          	ld	s5,696(sp)
    23fa:	2b013b03          	ld	s6,688(sp)
    23fe:	fa9fe06f          	j	13a6 <stbsp_vsprintfcb+0x120>
            fl |= ((sizeof(void *) == 8) ? STBSP__INTMAX : 0);
    2402:	020e6e13          	ori	t3,t3,32
            ++f;
    2406:	0485                	addi	s1,s1,1
    2408:	864ff06f          	j	146c <stbsp_vsprintfcb+0x1e6>
               n = 0;
    240c:	4601                	li	a2,0
         s = num + 64;
    240e:	8756                	mv	a4,s5
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2410:	4511                	li	a0,4
                     *s++ = stbsp__comma;
    2412:	00170793          	addi	a5,a4,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2416:	00030563          	beqz	t1,2420 <stbsp_vsprintfcb+0x119a>
    241a:	2585                	addiw	a1,a1,1
    241c:	10a58363          	beq	a1,a0,2522 <stbsp_vsprintfcb+0x129c>
    2420:	873e                	mv	a4,a5
                     *s++ = sn[n];
    2422:	02061793          	slli	a5,a2,0x20
    2426:	9381                	srli	a5,a5,0x20
    2428:	97fa                	add	a5,a5,t5
    242a:	0007c803          	lbu	a6,0(a5)
                     ++n;
    242e:	2605                	addiw	a2,a2,1
                     *s++ = sn[n];
    2430:	ff070fa3          	sb	a6,-1(a4)
                     if (n >= l)
    2434:	fcd66fe3          	bltu	a2,a3,2412 <stbsp_vsprintfcb+0x118c>
               if (n < (stbsp__uint32)dp) {
    2438:	0bd663e3          	bltu	a2,t4,2cde <stbsp_vsprintfcb+0x1a58>
               cs = (int)(s - (num + 64)) + (3 << 24); // cs is how many tens
    243c:	415707b3          	sub	a5,a4,s5
    2440:	030002b7          	lui	t0,0x3000
    2444:	00f282bb          	addw	t0,t0,a5
               if (pr) {
    2448:	00088a63          	beqz	a7,245c <stbsp_vsprintfcb+0x11d6>
                  *s++ = stbsp__period;
    244c:	0cca4683          	lbu	a3,204(s4)
    2450:	00170793          	addi	a5,a4,1
         l = (stbsp__uint32)(s - (num + 64));
    2454:	415787b3          	sub	a5,a5,s5
                  *s++ = stbsp__period;
    2458:	00d70023          	sb	a3,0(a4)
         if (fl & STBSP__METRIC_SUFFIX) {
    245c:	100e7713          	andi	a4,t3,256
    2460:	86f2                	mv	a3,t3
    2462:	2c070163          	beqz	a4,2724 <stbsp_vsprintfcb+0x149e>
            if (fl & STBSP__METRIC_NOSPACE)
    2466:	40ae5f9b          	sraiw	t6,t3,0xa
    246a:	001fcf93          	xori	t6,t6,1
    246e:	001fff93          	andi	t6,t6,1
            tail[1] = ' ';
    2472:	02000713          	li	a4,32
    2476:	06e108a3          	sb	a4,113(sp)
            tail[0] = idx;
    247a:	07f10823          	sb	t6,112(sp)
               if (fl >> 24) { // SI kilo is 'k', JEDEC and SI kibits are 'K'.
    247e:	018e561b          	srliw	a2,t3,0x18
    2482:	018e571b          	srliw	a4,t3,0x18
         n = pr + lead[0] + tail[0] + tz;
    2486:	000f859b          	sext.w	a1,t6
               if (fl >> 24) { // SI kilo is 'k', JEDEC and SI kibits are 'K'.
    248a:	c225                	beqz	a2,24ea <stbsp_vsprintfcb+0x1264>
                  if (fl & STBSP__METRIC_1024)
    248c:	001f859b          	addiw	a1,t6,1
    2490:	0ff5f613          	zext.b	a2,a1
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    2494:	1702                	slli	a4,a4,0x20
                  if (fl & STBSP__METRIC_1024)
    2496:	03469513          	slli	a0,a3,0x34
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    249a:	85b2                	mv	a1,a2
    249c:	9301                	srli	a4,a4,0x20
                  if (fl & STBSP__METRIC_1024)
    249e:	06055ee3          	bgez	a0,2d1a <stbsp_vsprintfcb+0x1a94>
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    24a2:	00003517          	auipc	a0,0x3
    24a6:	b9e50513          	addi	a0,a0,-1122 # 5040 <_GLOBAL__sub_I__ZSt3cin+0x98>
    24aa:	972a                	add	a4,a4,a0
    24ac:	00074503          	lbu	a0,0(a4)
                  if (fl & STBSP__METRIC_1024 && !(fl & STBSP__METRIC_JEDEC)) {
    24b0:	6709                	lui	a4,0x2
    24b2:	80070713          	addi	a4,a4,-2048 # 1800 <stbsp_vsprintfcb+0x57a>
    24b6:	8f75                	and	a4,a4,a3
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    24b8:	06010813          	addi	a6,sp,96
    24bc:	22060693          	addi	a3,a2,544
    24c0:	96c2                	add	a3,a3,a6
    24c2:	dea68823          	sb	a0,-528(a3) # efffdf0 <_ZSt4cerr+0xeff85f8>
                  if (fl & STBSP__METRIC_1024 && !(fl & STBSP__METRIC_JEDEC)) {
    24c6:	8007071b          	addiw	a4,a4,-2048
    24ca:	060715e3          	bnez	a4,2d34 <stbsp_vsprintfcb+0x1aae>
                     tail[idx + 1] = 'i';
    24ce:	2f89                	addiw	t6,t6,2
    24d0:	0ffff593          	zext.b	a1,t6
    24d4:	1094                	addi	a3,sp,96
    24d6:	22058713          	addi	a4,a1,544
    24da:	9736                	add	a4,a4,a3
    24dc:	06900693          	li	a3,105
    24e0:	8fae                	mv	t6,a1
    24e2:	ded70823          	sb	a3,-528(a4)
                  tail[0] = idx;
    24e6:	07f10823          	sb	t6,112(sp)
         l = (stbsp__uint32)(s - (num + 64));
    24ea:	0007869b          	sext.w	a3,a5
         n = pr + lead[0] + tail[0] + tz;
    24ee:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    24f2:	fff6c713          	not	a4,a3
    24f6:	977d                	srai	a4,a4,0x3f
    24f8:	8ff9                	and	a5,a5,a4
         n = pr + lead[0] + tail[0] + tz;
    24fa:	00fa073b          	addw	a4,s4,a5
    24fe:	9f2d                	addw	a4,a4,a1
    2500:	0117063b          	addw	a2,a4,a7
         l = (stbsp__uint32)(s - (num + 64));
    2504:	d0b6                	sw	a3,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    2506:	8732                	mv	a4,a2
         if (pr < (stbsp__int32)l)
    2508:	2781                	sext.w	a5,a5
         if ((fl & STBSP__LEFTJUST) == 0) {
    250a:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    250e:	835a                	mv	t1,s6
    2510:	00cb5363          	bge	s6,a2,2516 <stbsp_vsprintfcb+0x1290>
    2514:	8332                	mv	t1,a2
         fw -= n;
    2516:	40e3033b          	subw	t1,t1,a4
         pr -= l;
    251a:	40d7873b          	subw	a4,a5,a3
         goto scopy;
    251e:	eaaff06f          	j	1bc8 <stbsp_vsprintfcb+0x942>
                     *s++ = stbsp__comma;
    2522:	fe578fa3          	sb	t0,-1(a5)
    2526:	0709                	addi	a4,a4,2
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2528:	4585                	li	a1,1
    252a:	bde5                	j	2422 <stbsp_vsprintfcb+0x119c>
            lead[0] = 1;
    252c:	678d                	lui	a5,0x3
    252e:	0785                	addi	a5,a5,1 # 3001 <sprintf+0x43>
    2530:	06f11423          	sh	a5,104(sp)
    2534:	b4ed                	j	201e <stbsp_vsprintfcb+0xd98>
            if ((f[0] != 'u') && (i64 < 0)) {
    2536:	07500693          	li	a3,117
            stbsp__int64 i64 = va_arg(va, stbsp__int64);
    253a:	000bbf03          	ld	t5,0(s7)
            if ((f[0] != 'u') && (i64 < 0)) {
    253e:	dcd78263          	beq	a5,a3,1b02 <stbsp_vsprintfcb+0x87c>
    2542:	dc0f5063          	bgez	t5,1b02 <stbsp_vsprintfcb+0x87c>
               fl |= STBSP__NEGATIVE;
    2546:	08076713          	ori	a4,a4,128
               n64 = (stbsp__uint64)-i64;
    254a:	41e00f33          	neg	t5,t5
               fl |= STBSP__NEGATIVE;
    254e:	00070e1b          	sext.w	t3,a4
    2552:	db0ff06f          	j	1b02 <stbsp_vsprintfcb+0x87c>
            lead[2] = h[0xb];
    2556:	00b84703          	lbu	a4,11(a6)
            lead[0] = 2;
    255a:	678d                	lui	a5,0x3
    255c:	0789                	addi	a5,a5,2 # 3002 <sprintf+0x44>
    255e:	06f11423          	sh	a5,104(sp)
            lead[2] = h[0xb];
    2562:	06e10523          	sb	a4,106(sp)
    2566:	bab5                	j	1ee2 <stbsp_vsprintfcb+0xc5c>
      sign[0] = 1;
    2568:	678d                	lui	a5,0x3
    256a:	d0178793          	addi	a5,a5,-767 # 2d01 <stbsp_vsprintfcb+0x1a7b>
            fl |= STBSP__NEGATIVE;
    256e:	080e6e13          	ori	t3,t3,128
      sign[0] = 1;
    2572:	06f11423          	sh	a5,104(sp)
    2576:	468d                	li	a3,3
    2578:	4a0d                	li	s4,3
    257a:	4809                	li	a6,2
    257c:	b899                	j	1dd2 <stbsp_vsprintfcb+0xb4c>
      sign[0] = 1;
    257e:	6709                	lui	a4,0x2
    2580:	0705                	addi	a4,a4,1 # 2001 <stbsp_vsprintfcb+0xd7b>
    2582:	06e11423          	sh	a4,104(sp)
    2586:	bae5                	j	1f7e <stbsp_vsprintfcb+0xcf8>
      if (((stbsp__uintptr)sn & 3) == 0)
    2588:	0e0780e3          	beqz	a5,2e68 <stbsp_vsprintfcb+0x1be2>
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    258c:	56fd                	li	a3,-1
    258e:	bcf9                	j	206c <stbsp_vsprintfcb+0xde6>
         if (fw < (stbsp__int32)n)
    2590:	4305                	li	t1,1
    2592:	b249                	j	1f14 <stbsp_vsprintfcb+0xc8e>
            pr = 6; // default is 6
    2594:	4899                	li	a7,6
    2596:	b801                	j	1da6 <stbsp_vsprintfcb+0xb20>
         h = (f[0] == 'A') ? hexu : hex;
    2598:	00004597          	auipc	a1,0x4
    259c:	43858593          	addi	a1,a1,1080 # 69d0 <hexu.1>
    25a0:	ff6ff06f          	j	1d96 <stbsp_vsprintfcb+0xb10>
         h = (f[0] == 'B') ? hexu : hex;
    25a4:	00004817          	auipc	a6,0x4
    25a8:	42c80813          	addi	a6,a6,1068 # 69d0 <hexu.1>
    25ac:	b22d                	j	1ed6 <stbsp_vsprintfcb+0xc50>
    25ae:	80000737          	lui	a4,0x80000
    25b2:	0719                	addi	a4,a4,6 # ffffffff80000006 <_ZSt4cerr+0xffffffff7fff880e>
            pr = 6; // default is 6
    25b4:	4899                	li	a7,6
    25b6:	e4eff06f          	j	1c04 <stbsp_vsprintfcb+0x97e>
         h = (f[0] == 'E') ? hexu : hex;
    25ba:	00004317          	auipc	t1,0x4
    25be:	41630313          	addi	t1,t1,1046 # 69d0 <hexu.1>
    25c2:	e28ff06f          	j	1bea <stbsp_vsprintfcb+0x964>
    25c6:	80000737          	lui	a4,0x80000
    25ca:	4a99                	li	s5,6
    25cc:	0715                	addi	a4,a4,5 # ffffffff80000005 <_ZSt4cerr+0xffffffff7fff880d>
            pr = 6;
    25ce:	4a19                	li	s4,6
    25d0:	ee8ff06f          	j	1cb8 <stbsp_vsprintfcb+0xa32>
         h = (f[0] == 'G') ? hexu : hex;
    25d4:	00004317          	auipc	t1,0x4
    25d8:	3fc30313          	addi	t1,t1,1020 # 69d0 <hexu.1>
    25dc:	eb6ff06f          	j	1c92 <stbsp_vsprintfcb+0xa0c>
    25e0:	7be6                	ld	s7,120(sp)
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    25e2:	86c2                	mv	a3,a6
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    25e4:	8542                	mv	a0,a6
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    25e6:	88d2                	mv	a7,s4
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    25e8:	8ade                	mv	s5,s7
            if (pr > (stbsp__int32)l)
    25ea:	0005071b          	sext.w	a4,a0
    25ee:	01175f63          	bge	a4,a7,260c <stbsp_vsprintfcb+0x1386>
               pr = l - 1;
    25f2:	fff5089b          	addiw	a7,a0,-1
         tail[0] = 0;
    25f6:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    25fa:	70028c63          	beqz	t0,2d12 <stbsp_vsprintfcb+0x1a8c>
      sign[0] = 1;
    25fe:	670d                	lui	a4,0x3
    2600:	d0170713          	addi	a4,a4,-767 # 2d01 <stbsp_vsprintfcb+0x1a7b>
    2604:	06e11423          	sh	a4,104(sp)
    2608:	e3aff06f          	j	1c42 <stbsp_vsprintfcb+0x9bc>
            else if (pr)
    260c:	fe0885e3          	beqz	a7,25f6 <stbsp_vsprintfcb+0x1370>
               --pr; // when using %e, there is one digit before the decimal
    2610:	38fd                	addiw	a7,a7,-1
    2612:	b7d5                	j	25f6 <stbsp_vsprintfcb+0x1370>
      switch (f[0]) {
    2614:	0034c783          	lbu	a5,3(s1)
            f += 3;
    2618:	048d                	addi	s1,s1,3
    261a:	e53fe06f          	j	146c <stbsp_vsprintfcb+0x1e6>
      if (!limit || *sn == 0)
    261e:	4601                	li	a2,0
    2620:	4701                	li	a4,0
    2622:	4781                	li	a5,0
         return (stbsp__uint32)(sn - s);
    2624:	bca5                	j	209c <stbsp_vsprintfcb+0xe16>
               pr = 1;
    2626:	4885                	li	a7,1
    2628:	cf4ff06f          	j	1b1c <stbsp_vsprintfcb+0x896>
         *s++ = sn[0];
    262c:	000ac703          	lbu	a4,0(s5)
    2630:	0ce10023          	sb	a4,192(sp)
         if (pr)
    2634:	54088563          	beqz	a7,2b7e <stbsp_vsprintfcb+0x18f8>
            *s++ = stbsp__period;
    2638:	00004617          	auipc	a2,0x4
    263c:	39464603          	lbu	a2,916(a2) # 69cc <stbsp__period>
         if ((l - 1) > (stbsp__uint32)pr)
    2640:	fff6871b          	addiw	a4,a3,-1
            *s++ = stbsp__period;
    2644:	0cc100a3          	sb	a2,193(sp)
         if ((l - 1) > (stbsp__uint32)pr)
    2648:	0008851b          	sext.w	a0,a7
    264c:	0007061b          	sext.w	a2,a4
    2650:	52c57163          	bgeu	a0,a2,2b72 <stbsp_vsprintfcb+0x18ec>
            l = pr + 1;
    2654:	0018869b          	addiw	a3,a7,1
         for (n = 1; n < l; n++)
    2658:	8746                	mv	a4,a7
    265a:	02071613          	slli	a2,a4,0x20
    265e:	9201                	srli	a2,a2,0x20
    2660:	0c210713          	addi	a4,sp,194
    2664:	0a85                	addi	s5,s5,1
    2666:	963a                	add	a2,a2,a4
            *s++ = sn[n];
    2668:	000ac583          	lbu	a1,0(s5)
    266c:	0705                	addi	a4,a4,1
         for (n = 1; n < l; n++)
    266e:	0a85                	addi	s5,s5,1
            *s++ = sn[n];
    2670:	feb70fa3          	sb	a1,-1(a4)
         for (n = 1; n < l; n++)
    2674:	fec71ae3          	bne	a4,a2,2668 <stbsp_vsprintfcb+0x13e2>
         tail[1] = h[0xe];
    2678:	00e34803          	lbu	a6,14(t1)
         dp -= 1;
    267c:	fff7871b          	addiw	a4,a5,-1
            tail[2] = '+';
    2680:	02b00593          	li	a1,43
         tail[1] = h[0xe];
    2684:	070108a3          	sb	a6,113(sp)
         if (dp < 0) {
    2688:	00075663          	bgez	a4,2694 <stbsp_vsprintfcb+0x140e>
            dp = -dp;
    268c:	4705                	li	a4,1
    268e:	9f1d                	subw	a4,a4,a5
            tail[2] = '-';
    2690:	02d00593          	li	a1,45
    2694:	06b10923          	sb	a1,114(sp)
         n = (dp >= 100) ? 5 : 4;
    2698:	06300793          	li	a5,99
    269c:	4ee7d663          	bge	a5,a4,2b88 <stbsp_vsprintfcb+0x1902>
    26a0:	4595                	li	a1,5
    26a2:	4f95                	li	t6,5
    26a4:	4e95                	li	t4,5
            tail[n] = '0' + dp % 10;
    26a6:	47a9                	li	a5,10
            dp /= 10;
    26a8:	02f7433b          	divw	t1,a4,a5
            --n;
    26ac:	fffe8f1b          	addiw	t5,t4,-1
            tail[n] = '0' + dp % 10;
    26b0:	020f1293          	slli	t0,t5,0x20
    26b4:	220e8813          	addi	a6,t4,544
    26b8:	06010893          	addi	a7,sp,96
    26bc:	0202d293          	srli	t0,t0,0x20
    26c0:	01180eb3          	add	t4,a6,a7
    26c4:	22028813          	addi	a6,t0,544 # 3000220 <_ZSt4cerr+0x2ff8a28>
    26c8:	011802b3          	add	t0,a6,a7
         tail[0] = (char)n;
    26cc:	07f10823          	sb	t6,112(sp)
            if (n <= 3)
    26d0:	4a0d                	li	s4,3
            tail[n] = '0' + dp % 10;
    26d2:	02f7673b          	remw	a4,a4,a5
            dp /= 10;
    26d6:	0003081b          	sext.w	a6,t1
            tail[n] = '0' + dp % 10;
    26da:	02f36abb          	remw	s5,t1,a5
    26de:	0307071b          	addiw	a4,a4,48
    26e2:	deee8823          	sb	a4,-528(t4)
    26e6:	030a871b          	addiw	a4,s5,48
    26ea:	dee28823          	sb	a4,-528(t0)
            if (n <= 3)
    26ee:	014f0a63          	beq	t5,s4,2702 <stbsp_vsprintfcb+0x147c>
            dp /= 10;
    26f2:	02f3483b          	divw	a6,t1,a5
            tail[n] = '0' + dp % 10;
    26f6:	02f867bb          	remw	a5,a6,a5
    26fa:	0307879b          	addiw	a5,a5,48
    26fe:	06f109a3          	sb	a5,115(sp)
         tz = pr - (l - 1);
    2702:	2505                	addiw	a0,a0,1
         l = (stbsp__uint32)(s - (num + 64));
    2704:	0c010a93          	addi	s5,sp,192
         cs = 1 + (3 << 24); // how many tens
    2708:	030002b7          	lui	t0,0x3000
         tz = pr - (l - 1);
    270c:	40d508bb          	subw	a7,a0,a3
    2710:	d2c2                	sw	a6,100(sp)
         l = (stbsp__uint32)(s - (num + 64));
    2712:	415607b3          	sub	a5,a2,s5
         cs = 1 + (3 << 24); // how many tens
    2716:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff8809>
    2718:	bbc9                	j	24ea <stbsp_vsprintfcb+0x1264>
    271a:	fc2e                	sd	a1,56(sp)
    271c:	d0b2                	sw	a2,96(sp)
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    271e:	8536                	mv	a0,a3
    2720:	e2cff06f          	j	1d4c <stbsp_vsprintfcb+0xac6>
      flt_lead:
    2724:	4581                	li	a1,0
    2726:	4f81                	li	t6,0
    2728:	b3c9                	j	24ea <stbsp_vsprintfcb+0x1264>
         n = pr + lead[0] + tail[0] + tz;
    272a:	06814a03          	lbu	s4,104(sp)
    272e:	000a0f9b          	sext.w	t6,s4
    2732:	b901                	j	2342 <stbsp_vsprintfcb+0x10bc>
         if ((f[1] == '6') && (f[2] == '4')) {
    2734:	0024c683          	lbu	a3,2(s1)
    2738:	03400713          	li	a4,52
    273c:	00e68463          	beq	a3,a4,2744 <stbsp_vsprintfcb+0x14be>
    2740:	e2bfe06f          	j	156a <stbsp_vsprintfcb+0x2e4>
      switch (f[0]) {
    2744:	0034c783          	lbu	a5,3(s1)
         fl |= ((sizeof(long) == 8) ? STBSP__INTMAX : 0);
    2748:	020e6e13          	ori	t3,t3,32
            f += 3;
    274c:	048d                	addi	s1,s1,3
    274e:	d1ffe06f          	j	146c <stbsp_vsprintfcb+0x1e6>
         if (pr < (stbsp__int32)l)
    2752:	0006879b          	sext.w	a5,a3
         n = pr + lead[0] + tail[0] + tz;
    2756:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    275a:	fff7c793          	not	a5,a5
    275e:	97fd                	srai	a5,a5,0x3f
    2760:	8ff5                	and	a5,a5,a3
         n = pr + lead[0] + tail[0] + tz;
    2762:	00fa063b          	addw	a2,s4,a5
            s = (char *)sn;
    2766:	7ae6                	ld	s5,120(sp)
         n = pr + lead[0] + tail[0] + tz;
    2768:	8732                	mv	a4,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    276a:	001e7513          	andi	a0,t3,1
         if (pr < (stbsp__int32)l)
    276e:	2781                	sext.w	a5,a5
         if (fw < (stbsp__int32)n)
    2770:	835a                	mv	t1,s6
    2772:	00cb5363          	bge	s6,a2,2778 <stbsp_vsprintfcb+0x14f2>
    2776:	8332                	mv	t1,a2
         fw -= n;
    2778:	40e3033b          	subw	t1,t1,a4
            goto scopy;
    277c:	4f81                	li	t6,0
         pr -= l;
    277e:	40d7873b          	subw	a4,a5,a3
            cs = 0;
    2782:	4281                	li	t0,0
      tz = 0;
    2784:	4881                	li	a7,0
            goto scopy;
    2786:	c42ff06f          	j	1bc8 <stbsp_vsprintfcb+0x942>
               cs = (int)(s - (num + 64)) + (3 << 24); // cs is how many tens
    278a:	415705b3          	sub	a1,a4,s5
    278e:	030002b7          	lui	t0,0x3000
    2792:	00b282bb          	addw	t0,t0,a1
               l = pr - n;
    2796:	0008859b          	sext.w	a1,a7
               if (pr)
    279a:	42088763          	beqz	a7,2bc8 <stbsp_vsprintfcb+0x1942>
                  *s++ = stbsp__period;
    279e:	0cca4f83          	lbu	t6,204(s4)
               if ((l - dp) > (stbsp__uint32)pr)
    27a2:	41d6833b          	subw	t1,a3,t4
                  *s++ = stbsp__period;
    27a6:	00280713          	addi	a4,a6,2
    27aa:	01f800a3          	sb	t6,1(a6)
               if ((l - dp) > (stbsp__uint32)pr)
    27ae:	4065ed63          	bltu	a1,t1,2bc8 <stbsp_vsprintfcb+0x1942>
               while (n < l) {
    27b2:	5ed57863          	bgeu	a0,a3,2da2 <stbsp_vsprintfcb+0x1b1c>
    27b6:	40c687bb          	subw	a5,a3,a2
    27ba:	37fd                	addiw	a5,a5,-1
    27bc:	1782                	slli	a5,a5,0x20
    27be:	9381                	srli	a5,a5,0x20
    27c0:	1602                	slli	a2,a2,0x20
    27c2:	9201                	srli	a2,a2,0x20
    27c4:	0785                	addi	a5,a5,1
    27c6:	967a                	add	a2,a2,t5
    27c8:	97ba                	add	a5,a5,a4
                  *s++ = sn[n];
    27ca:	00064503          	lbu	a0,0(a2)
    27ce:	0705                	addi	a4,a4,1
               while (n < l) {
    27d0:	0605                	addi	a2,a2,1
                  *s++ = sn[n];
    27d2:	fea70fa3          	sb	a0,-1(a4)
               while (n < l) {
    27d6:	fef71ae3          	bne	a4,a5,27ca <stbsp_vsprintfcb+0x1544>
               tz = pr - (l - dp);
    27da:	01d585bb          	addw	a1,a1,t4
    27de:	40d588bb          	subw	a7,a1,a3
         l = (stbsp__uint32)(s - (num + 64));
    27e2:	415787b3          	sub	a5,a5,s5
    27e6:	b99d                	j	245c <stbsp_vsprintfcb+0x11d6>
            fl |= STBSP__NEGATIVE;
    27e8:	080e6e13          	ori	t3,t3,128
         tail[0] = 0;
    27ec:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    27f0:	b539                	j	25fe <stbsp_vsprintfcb+0x1378>
         tail[0] = (char)n;
    27f2:	4799                	li	a5,6
            tail[n] = '0' + dp % 10;
    27f4:	06b10b23          	sb	a1,118(sp)
         tail[0] = (char)n;
    27f8:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    27fc:	4819                	li	a6,6
    27fe:	4f99                	li	t6,6
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    2800:	4599                	li	a1,6
            dp /= 10;
    2802:	4f29                	li	t5,10
            if (n <= 3)
    2804:	428d                	li	t0,3
    2806:	87b2                	mv	a5,a2
            dp /= 10;
    2808:	03e7c7bb          	divw	a5,a5,t5
            --n;
    280c:	35fd                	addiw	a1,a1,-1
            tail[n] = '0' + dp % 10;
    280e:	02059613          	slli	a2,a1,0x20
    2812:	9201                	srli	a2,a2,0x20
    2814:	06010e93          	addi	t4,sp,96
    2818:	22060613          	addi	a2,a2,544
    281c:	9676                	add	a2,a2,t4
    281e:	03e7eebb          	remw	t4,a5,t5
    2822:	030e8e9b          	addiw	t4,t4,48
    2826:	dfd60823          	sb	t4,-528(a2)
            if (n <= 3)
    282a:	fc559fe3          	bne	a1,t0,2808 <stbsp_vsprintfcb+0x1582>
    282e:	e6aff06f          	j	1e98 <stbsp_vsprintfcb+0xc12>
         *s++ = h[(n64 >> 60) & 15];
    2832:	93f1                	srli	a5,a5,0x3c
    2834:	97ae                	add	a5,a5,a1
    2836:	0007c303          	lbu	t1,0(a5)
         lead[1 + lead[0]] = '0';
    283a:	1088                	addi	a0,sp,96
    283c:	22080793          	addi	a5,a6,544
    2840:	97aa                	add	a5,a5,a0
    2842:	03000513          	li	a0,48
    2846:	dea78423          	sb	a0,-536(a5)
         lead[2 + lead[0]] = 'x';
    284a:	22068793          	addi	a5,a3,544
    284e:	1094                	addi	a3,sp,96
    2850:	96be                	add	a3,a3,a5
            *s++ = stbsp__period;
    2852:	00004517          	auipc	a0,0x4
    2856:	17a54503          	lbu	a0,378(a0) # 69cc <stbsp__period>
         lead[2 + lead[0]] = 'x';
    285a:	07800813          	li	a6,120
         sn = s;
    285e:	0c210793          	addi	a5,sp,194
         lead[2 + lead[0]] = 'x';
    2862:	df068423          	sb	a6,-536(a3)
            *s++ = stbsp__period;
    2866:	0ca100a3          	sb	a0,193(sp)
         lead[0] += 2;
    286a:	07410423          	sb	s4,104(sp)
         *s++ = h[(n64 >> 60) & 15];
    286e:	0c610023          	sb	t1,192(sp)
         n64 <<= 4;
    2872:	0732                	slli	a4,a4,0xc
         sn = s;
    2874:	fcbe                	sd	a5,120(sp)
         n = pr;
    2876:	0008869b          	sext.w	a3,a7
         while (n--) {
    287a:	4831                	li	a6,12
         if (n > 13)
    287c:	4535                	li	a0,13
            tz = pr - n;
    287e:	40a688bb          	subw	a7,a3,a0
         while (n--) {
    2882:	02081313          	slli	t1,a6,0x20
    2886:	02035313          	srli	t1,t1,0x20
    288a:	22030693          	addi	a3,t1,544
    288e:	1088                	addi	a0,sp,96
    2890:	9536                	add	a0,a0,a3
    2892:	e4350513          	addi	a0,a0,-445
            *s++ = h[(n64 >> 60) & 15];
    2896:	03c75693          	srli	a3,a4,0x3c
    289a:	96ae                	add	a3,a3,a1
    289c:	0006c683          	lbu	a3,0(a3)
    28a0:	0785                	addi	a5,a5,1
            n64 <<= 4;
    28a2:	0712                	slli	a4,a4,0x4
            *s++ = h[(n64 >> 60) & 15];
    28a4:	fed78fa3          	sb	a3,-1(a5)
         while (n--) {
    28a8:	fea797e3          	bne	a5,a0,2896 <stbsp_vsprintfcb+0x1610>
         l = (int)(s - (num + 64));
    28ac:	280d                	addiw	a6,a6,3
    28ae:	0008069b          	sext.w	a3,a6
         if (pr < (stbsp__int32)l)
    28b2:	fff6c713          	not	a4,a3
    28b6:	977d                	srai	a4,a4,0x3f
    28b8:	00e87733          	and	a4,a6,a4
         dp = (int)(s - sn);
    28bc:	0013051b          	addiw	a0,t1,1
         if (pr < (stbsp__int32)l)
    28c0:	0007031b          	sext.w	t1,a4
         pr -= l;
    28c4:	4107073b          	subw	a4,a4,a6
    28c8:	d76ff06f          	j	1e3e <stbsp_vsprintfcb+0xbb8>
                  *--s = stbsp__comma;
    28cc:	00004a17          	auipc	s4,0x4
    28d0:	034a0a13          	addi	s4,s4,52 # 6900 <stbsp__digitpair>
            if (n64 >= 100000000) {
    28d4:	05f5e7b7          	lui	a5,0x5f5e
    28d8:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f56907>
               n = (stbsp__uint32)(n64 % 100000000);
    28dc:	05f5e637          	lui	a2,0x5f5e
                  *--s = stbsp__comma;
    28e0:	0cda4b83          	lbu	s7,205(s4)
            if (n64 >= 100000000) {
    28e4:	e83e                	sd	a5,16(sp)
               n = (stbsp__uint32)(n64 % 100000000);
    28e6:	10060793          	addi	a5,a2,256 # 5f5e100 <_ZSt4cerr+0x5f56908>
         l = 0;
    28ea:	d082                	sw	zero,96(sp)
            if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    28ec:	040e7813          	andi	a6,t3,64
    28f0:	4701                	li	a4,0
    28f2:	4281                	li	t0,0
         s = num + STBSP__NUMSZ;
    28f4:	28010a93          	addi	s5,sp,640
               n = (stbsp__uint32)(n64 % 100000000);
    28f8:	ec3e                	sd	a5,24(sp)
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    28fa:	430d                	li	t1,3
                  n /= 10;
    28fc:	45a9                	li	a1,10
            while (n) {
    28fe:	4ea5                	li	t4,9
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    2900:	06400f93          	li	t6,100
            if (n64 >= 100000000) {
    2904:	67c2                	ld	a5,16(sp)
            char *o = s - 8;
    2906:	ff8a8513          	addi	a0,s5,-8
            if (n64 >= 100000000) {
    290a:	0fe7f763          	bgeu	a5,t5,29f8 <stbsp_vsprintfcb+0x1772>
               n = (stbsp__uint32)(n64 % 100000000);
    290e:	6662                	ld	a2,24(sp)
    2910:	02cf77b3          	remu	a5,t5,a2
               n64 /= 100000000;
    2914:	02cf5f33          	divu	t5,t5,a2
            if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    2918:	0e080463          	beqz	a6,2a00 <stbsp_vsprintfcb+0x177a>
            while (n) {
    291c:	cb85                	beqz	a5,294c <stbsp_vsprintfcb+0x16c6>
                  *--s = stbsp__comma;
    291e:	1afd                	addi	s5,s5,-1
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    2920:	00671763          	bne	a4,t1,292e <stbsp_vsprintfcb+0x16a8>
                  --o;
    2924:	017a8023          	sb	s7,0(s5)
    2928:	157d                	addi	a0,a0,-1
                  *--s = stbsp__comma;
    292a:	1afd                	addi	s5,s5,-1
                  l = 0;
    292c:	4701                	li	a4,0
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    292e:	2705                	addiw	a4,a4,1
                  *--s = (char)(n % 10) + '0';
    2930:	02b7f63b          	remuw	a2,a5,a1
    2934:	0306061b          	addiw	a2,a2,48
    2938:	00ca8023          	sb	a2,0(s5)
                  n /= 10;
    293c:	02b7d63b          	divuw	a2,a5,a1
            while (n) {
    2940:	00fef563          	bgeu	t4,a5,294a <stbsp_vsprintfcb+0x16c4>
                  *--s = stbsp__comma;
    2944:	1afd                	addi	s5,s5,-1
    2946:	87b2                	mv	a5,a2
    2948:	bfe1                	j	2920 <stbsp_vsprintfcb+0x169a>
            while (n) {
    294a:	4285                	li	t0,1
            if (n64 == 0) {
    294c:	020f0063          	beqz	t5,296c <stbsp_vsprintfcb+0x16e6>
            while (s != o)
    2950:	fb550ae3          	beq	a0,s5,2904 <stbsp_vsprintfcb+0x167e>
                  *--s = stbsp__comma;
    2954:	1afd                	addi	s5,s5,-1
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    2956:	00080663          	beqz	a6,2962 <stbsp_vsprintfcb+0x16dc>
    295a:	08670863          	beq	a4,t1,29ea <stbsp_vsprintfcb+0x1764>
    295e:	2705                	addiw	a4,a4,1
    2960:	4285                	li	t0,1
                  *--s = '0';
    2962:	03000793          	li	a5,48
    2966:	00fa8023          	sb	a5,0(s5)
    296a:	b7dd                	j	2950 <stbsp_vsprintfcb+0x16ca>
    296c:	00028363          	beqz	t0,2972 <stbsp_vsprintfcb+0x16ec>
    2970:	d0ba                	sw	a4,96(sp)
               if ((s[0] == '0') && (s != (num + STBSP__NUMSZ)))
    2972:	000ac703          	lbu	a4,0(s5)
    2976:	03000793          	li	a5,48
    297a:	34f70b63          	beq	a4,a5,2cd0 <stbsp_vsprintfcb+0x1a4a>
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    297e:	051c                	addi	a5,sp,640
    2980:	415786bb          	subw	a3,a5,s5
         tail[0] = 0;
    2984:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    2988:	080e7713          	andi	a4,t3,128
    298c:	87f2                	mv	a5,t3
    298e:	32070863          	beqz	a4,2cbe <stbsp_vsprintfcb+0x1a38>
    2992:	678d                	lui	a5,0x3
    2994:	d017879b          	addiw	a5,a5,-767 # 2d01 <stbsp_vsprintfcb+0x1a7b>
      sign[0] = 1;
    2998:	06f11423          	sh	a5,104(sp)
    299c:	4705                	li	a4,1
    299e:	4a05                	li	s4,1
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    29a0:	d0b6                	sw	a3,96(sp)
         if (l == 0) {
    29a2:	30068163          	beqz	a3,2ca4 <stbsp_vsprintfcb+0x1a1e>
         cs = l + (3 << 24);
    29a6:	030002b7          	lui	t0,0x3000
    29aa:	00d282bb          	addw	t0,t0,a3
         if (pr < (stbsp__int32)l)
    29ae:	0006861b          	sext.w	a2,a3
         if (pr < 0)
    29b2:	fff8c793          	not	a5,a7
    29b6:	97fd                	srai	a5,a5,0x3f
         if (pr < (stbsp__int32)l)
    29b8:	00f8f7b3          	and	a5,a7,a5
    29bc:	0007859b          	sext.w	a1,a5
    29c0:	00c5d363          	bge	a1,a2,29c6 <stbsp_vsprintfcb+0x1740>
    29c4:	87b2                	mv	a5,a2
         n = pr + lead[0] + tail[0] + tz;
    29c6:	00f7063b          	addw	a2,a4,a5
    29ca:	8732                	mv	a4,a2
         if (pr < (stbsp__int32)l)
    29cc:	2781                	sext.w	a5,a5
         if ((fl & STBSP__LEFTJUST) == 0) {
    29ce:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    29d2:	835a                	mv	t1,s6
    29d4:	00cb5363          	bge	s6,a2,29da <stbsp_vsprintfcb+0x1754>
    29d8:	8332                	mv	t1,a2
         fw -= n;
    29da:	40e3033b          	subw	t1,t1,a4
      scopy:
    29de:	4f81                	li	t6,0
         pr -= l;
    29e0:	40d7873b          	subw	a4,a5,a3
      tz = 0;
    29e4:	4881                	li	a7,0
      scopy:
    29e6:	9e2ff06f          	j	1bc8 <stbsp_vsprintfcb+0x942>
                  *--s = stbsp__comma;
    29ea:	87de                	mv	a5,s7
                  --o;
    29ec:	157d                	addi	a0,a0,-1
                  l = 0;
    29ee:	4701                	li	a4,0
                  --o;
    29f0:	4285                	li	t0,1
    29f2:	00fa8023          	sb	a5,0(s5)
    29f6:	bfa9                	j	2950 <stbsp_vsprintfcb+0x16ca>
               n = (stbsp__uint32)n64;
    29f8:	000f079b          	sext.w	a5,t5
               n64 = 0;
    29fc:	4f01                	li	t5,0
    29fe:	bf29                	j	2918 <stbsp_vsprintfcb+0x1692>
    2a00:	f046                	sd	a7,32(sp)
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    2a02:	03f7f63b          	remuw	a2,a5,t6
                  s -= 2;
    2a06:	1af9                	addi	s5,s5,-2
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    2a08:	0007889b          	sext.w	a7,a5
    2a0c:	2605                	addiw	a2,a2,1
    2a0e:	0016161b          	slliw	a2,a2,0x1
    2a12:	1602                	slli	a2,a2,0x20
    2a14:	9201                	srli	a2,a2,0x20
    2a16:	9652                	add	a2,a2,s4
    2a18:	00065603          	lhu	a2,0(a2)
                  n /= 100;
    2a1c:	03f7d7bb          	divuw	a5,a5,t6
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    2a20:	00ca9023          	sh	a2,0(s5)
               } while (n);
    2a24:	06300613          	li	a2,99
    2a28:	fd166de3          	bltu	a2,a7,2a02 <stbsp_vsprintfcb+0x177c>
    2a2c:	7882                	ld	a7,32(sp)
            if (n64 == 0) {
    2a2e:	f20f11e3          	bnez	t5,2950 <stbsp_vsprintfcb+0x16ca>
    2a32:	bf2d                	j	296c <stbsp_vsprintfcb+0x16e6>
                     *(stbsp__uint32 *)bf = 0x20202020;
    2a34:	20202b37          	lui	s6,0x20202
                  stbsp__cb_buf_clamp(i, fw);
    2a38:	854a                	mv	a0,s2
                     *bf++ = ' ';
    2a3a:	02000a93          	li	s5,32
                     *(stbsp__uint32 *)bf = 0x20202020;
    2a3e:	020b0b13          	addi	s6,s6,32 # 20202020 <_ZSt4cerr+0x201fa828>
                  stbsp__chk_cb_buf(1);
    2a42:	1fe00a13          	li	s4,510
                  stbsp__cb_buf_clamp(i, fw);
    2a46:	20000b93          	li	s7,512
    2a4a:	891a                	mv	s2,t1
    2a4c:	0a098063          	beqz	s3,2aec <stbsp_vsprintfcb+0x1866>
    2a50:	40a40633          	sub	a2,s0,a0
    2a54:	40cb87bb          	subw	a5,s7,a2
    2a58:	873e                	mv	a4,a5
    2a5a:	00f95363          	bge	s2,a5,2a60 <stbsp_vsprintfcb+0x17da>
    2a5e:	874a                	mv	a4,s2
    2a60:	0007079b          	sext.w	a5,a4
                  fw -= i;
    2a64:	40e9093b          	subw	s2,s2,a4
                  while (i) {
    2a68:	e799                	bnez	a5,2a76 <stbsp_vsprintfcb+0x17f0>
    2a6a:	a281                	j	2baa <stbsp_vsprintfcb+0x1924>
                     *bf++ = ' ';
    2a6c:	01540023          	sb	s5,0(s0)
                     --i;
    2a70:	37fd                	addiw	a5,a5,-1
                     *bf++ = ' ';
    2a72:	0405                	addi	s0,s0,1
                  while (i) {
    2a74:	cba1                	beqz	a5,2ac4 <stbsp_vsprintfcb+0x183e>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    2a76:	00347713          	andi	a4,s0,3
    2a7a:	fb6d                	bnez	a4,2a6c <stbsp_vsprintfcb+0x17e6>
                  while (i >= 4) {
    2a7c:	470d                	li	a4,3
    2a7e:	40f75363          	bge	a4,a5,2e84 <stbsp_vsprintfcb+0x1bfe>
    2a82:	ffc7869b          	addiw	a3,a5,-4
    2a86:	0026d79b          	srliw	a5,a3,0x2
    2a8a:	0017871b          	addiw	a4,a5,1
    2a8e:	070a                	slli	a4,a4,0x2
    2a90:	9722                	add	a4,a4,s0
                     *(stbsp__uint32 *)bf = 0x20202020;
    2a92:	01642023          	sw	s6,0(s0)
                     bf += 4;
    2a96:	0411                	addi	s0,s0,4
                  while (i >= 4) {
    2a98:	fee41de3          	bne	s0,a4,2a92 <stbsp_vsprintfcb+0x180c>
    2a9c:	0027979b          	slliw	a5,a5,0x2
    2aa0:	40f687bb          	subw	a5,a3,a5
                  while (i--)
    2aa4:	fff7869b          	addiw	a3,a5,-1
    2aa8:	cf91                	beqz	a5,2ac4 <stbsp_vsprintfcb+0x183e>
    2aaa:	9fa1                	addw	a5,a5,s0
                     *bf++ = ' ';
    2aac:	0705                	addi	a4,a4,1
                  while (i--)
    2aae:	0007061b          	sext.w	a2,a4
                     *bf++ = ' ';
    2ab2:	ff570fa3          	sb	s5,-1(a4)
                  while (i--)
    2ab6:	fec79be3          	bne	a5,a2,2aac <stbsp_vsprintfcb+0x1826>
    2aba:	2685                	addiw	a3,a3,1
    2abc:	02069793          	slli	a5,a3,0x20
    2ac0:	9381                	srli	a5,a5,0x20
    2ac2:	943e                	add	s0,s0,a5
                  stbsp__chk_cb_buf(1);
    2ac4:	00098f63          	beqz	s3,2ae2 <stbsp_vsprintfcb+0x185c>
    2ac8:	40a4063b          	subw	a2,s0,a0
    2acc:	00ca5b63          	bge	s4,a2,2ae2 <stbsp_vsprintfcb+0x185c>
    2ad0:	65a2                	ld	a1,8(sp)
    2ad2:	e81e                	sd	t2,16(sp)
    2ad4:	00cd0d3b          	addw	s10,s10,a2
    2ad8:	9982                	jalr	s3
    2ada:	80050be3          	beqz	a0,22f0 <stbsp_vsprintfcb+0x106a>
    2ade:	63c2                	ld	t2,16(sp)
    2ae0:	842a                	mv	s0,a0
               while (fw) {
    2ae2:	f60915e3          	bnez	s2,2a4c <stbsp_vsprintfcb+0x17c6>
    2ae6:	892a                	mv	s2,a0
    2ae8:	f21fe06f          	j	1a08 <stbsp_vsprintfcb+0x782>
                  stbsp__cb_buf_clamp(i, fw);
    2aec:	87ca                	mv	a5,s2
                  fw -= i;
    2aee:	4901                	li	s2,0
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    2af0:	b759                	j	2a76 <stbsp_vsprintfcb+0x17f0>
   } else if (fl & STBSP__LEADINGPLUS) {
    2af2:	002e7713          	andi	a4,t3,2
    2af6:	94070663          	beqz	a4,1c42 <stbsp_vsprintfcb+0x9bc>
      sign[0] = 1;
    2afa:	670d                	lui	a4,0x3
    2afc:	b0170713          	addi	a4,a4,-1279 # 2b01 <stbsp_vsprintfcb+0x187b>
    2b00:	06e11423          	sh	a4,104(sp)
    2b04:	93eff06f          	j	1c42 <stbsp_vsprintfcb+0x9bc>
      if (((stbsp__uintptr)sn & 3) == 0)
    2b08:	87d6                	mv	a5,s5
   while (limit >= 4) {
    2b0a:	470d                	li	a4,3
    2b0c:	22d77763          	bgeu	a4,a3,2d3a <stbsp_vsprintfcb+0x1ab4>
      if ((v - 0x01010101) & (~v) & 0x80808080UL)
    2b10:	feff05b7          	lui	a1,0xfeff0
    2b14:	80808637          	lui	a2,0x80808
    2b18:	eff5859b          	addiw	a1,a1,-257 # fffffffffefefeff <_ZSt4cerr+0xfffffffffefe8707>
    2b1c:	08060613          	addi	a2,a2,128 # ffffffff80808080 <_ZSt4cerr+0xffffffff80800888>
   while (limit >= 4) {
    2b20:	480d                	li	a6,3
    2b22:	a029                	j	2b2c <stbsp_vsprintfcb+0x18a6>
      limit -= 4;
    2b24:	36f1                	addiw	a3,a3,-4
      sn += 4;
    2b26:	0791                	addi	a5,a5,4
   while (limit >= 4) {
    2b28:	20d87963          	bgeu	a6,a3,2d3a <stbsp_vsprintfcb+0x1ab4>
      stbsp__uint32 v = *(stbsp__uint32 *)sn;
    2b2c:	4398                	lw	a4,0(a5)
      if ((v - 0x01010101) & (~v) & 0x80808080UL)
    2b2e:	00b7053b          	addw	a0,a4,a1
    2b32:	fff74713          	not	a4,a4
    2b36:	8f69                	and	a4,a4,a0
    2b38:	8f71                	and	a4,a4,a2
    2b3a:	2701                	sext.w	a4,a4
    2b3c:	d765                	beqz	a4,2b24 <stbsp_vsprintfcb+0x189e>
    2b3e:	02069713          	slli	a4,a3,0x20
    2b42:	9301                	srli	a4,a4,0x20
    2b44:	973e                	add	a4,a4,a5
    2b46:	a021                	j	2b4e <stbsp_vsprintfcb+0x18c8>
      ++sn;
    2b48:	0785                	addi	a5,a5,1
   while (limit && *sn) {
    2b4a:	00e78663          	beq	a5,a4,2b56 <stbsp_vsprintfcb+0x18d0>
    2b4e:	0007c683          	lbu	a3,0(a5)
    2b52:	fafd                	bnez	a3,2b48 <stbsp_vsprintfcb+0x18c2>
    2b54:	873e                	mv	a4,a5
   return (stbsp__uint32)(sn - s);
    2b56:	41570733          	sub	a4,a4,s5
    2b5a:	0007069b          	sext.w	a3,a4
         if (pr < (stbsp__int32)l)
    2b5e:	fff6c793          	not	a5,a3
    2b62:	97fd                	srai	a5,a5,0x3f
    2b64:	8f7d                	and	a4,a4,a5
    2b66:	0007079b          	sext.w	a5,a4
         n = pr + lead[0] + tail[0] + tz;
    2b6a:	863e                	mv	a2,a5
         pr -= l;
    2b6c:	9f15                	subw	a4,a4,a3
   return (stbsp__uint32)(sn - s);
    2b6e:	d2eff06f          	j	209c <stbsp_vsprintfcb+0xe16>
         for (n = 1; n < l; n++)
    2b72:	4605                	li	a2,1
    2b74:	aed663e3          	bltu	a2,a3,265a <stbsp_vsprintfcb+0x13d4>
    2b78:	0c210613          	addi	a2,sp,194
    2b7c:	bcf5                	j	2678 <stbsp_vsprintfcb+0x13f2>
            l = pr + 1;
    2b7e:	4685                	li	a3,1
         if ((l - 1) > (stbsp__uint32)pr)
    2b80:	4501                	li	a0,0
         *s++ = sn[0];
    2b82:	0c110613          	addi	a2,sp,193
    2b86:	bccd                	j	2678 <stbsp_vsprintfcb+0x13f2>
    2b88:	4591                	li	a1,4
    2b8a:	4f91                	li	t6,4
         n = (dp >= 100) ? 5 : 4;
    2b8c:	4e91                	li	t4,4
    2b8e:	be21                	j	26a6 <stbsp_vsprintfcb+0x1420>
    2b90:	4a85                	li	s5,1
    2b92:	80000737          	lui	a4,0x80000
            pr = 1; // default is 6
    2b96:	4a05                	li	s4,1
    2b98:	920ff06f          	j	1cb8 <stbsp_vsprintfcb+0xa32>
            dp = (n64) ? -1022 : 0;
    2b9c:	4601                	li	a2,0
    2b9e:	c119                	beqz	a0,2ba4 <stbsp_vsprintfcb+0x191e>
    2ba0:	c0200613          	li	a2,-1022
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    2ba4:	872a                	mv	a4,a0
    2ba6:	a3aff06f          	j	1de0 <stbsp_vsprintfcb+0xb5a>
                  stbsp__chk_cb_buf(1);
    2baa:	2601                	sext.w	a2,a2
    2bac:	1fe00793          	li	a5,510
    2bb0:	f2c7c0e3          	blt	a5,a2,2ad0 <stbsp_vsprintfcb+0x184a>
    2bb4:	bd61                	j	2a4c <stbsp_vsprintfcb+0x17c6>
         tail[0] = (char)n;
    2bb6:	4795                	li	a5,5
            tail[n] = '0' + dp % 10;
    2bb8:	06b10aa3          	sb	a1,117(sp)
         tail[0] = (char)n;
    2bbc:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    2bc0:	4815                	li	a6,5
    2bc2:	4f95                	li	t6,5
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    2bc4:	4595                	li	a1,5
    2bc6:	b935                	j	2802 <stbsp_vsprintfcb+0x157c>
                  l = pr + dp;
    2bc8:	011786bb          	addw	a3,a5,a7
    2bcc:	d0b6                	sw	a3,96(sp)
    2bce:	b6d5                	j	27b2 <stbsp_vsprintfcb+0x152c>
            s = (char *)"null";
    2bd0:	00002a97          	auipc	s5,0x2
    2bd4:	468a8a93          	addi	s5,s5,1128 # 5038 <_GLOBAL__sub_I__ZSt3cin+0x90>
    2bd8:	c80ff06f          	j	2058 <stbsp_vsprintfcb+0xdd2>
   } else if (fl & STBSP__LEADINGPLUS) {
    2bdc:	002e7793          	andi	a5,t3,2
    2be0:	1c079c63          	bnez	a5,2db8 <stbsp_vsprintfcb+0x1b32>
   sign[0] = 0;
    2be4:	4689                	li	a3,2
    2be6:	4a09                	li	s4,2
    2be8:	4805                	li	a6,1
    2bea:	9e8ff06f          	j	1dd2 <stbsp_vsprintfcb+0xb4c>
      sign[0] = 1;
    2bee:	670d                	lui	a4,0x3
    2bf0:	b0170713          	addi	a4,a4,-1279 # 2b01 <stbsp_vsprintfcb+0x187b>
    2bf4:	06e11423          	sh	a4,104(sp)
    2bf8:	b86ff06f          	j	1f7e <stbsp_vsprintfcb+0xcf8>
               pr = 0;
    2bfc:	4881                	li	a7,0
    2bfe:	f1ffe06f          	j	1b1c <stbsp_vsprintfcb+0x896>
            *s++ = '0';
    2c02:	03000713          	li	a4,48
    2c06:	0ce10023          	sb	a4,192(sp)
            if (pr)
    2c0a:	1a088c63          	beqz	a7,2dc2 <stbsp_vsprintfcb+0x1b3c>
               *s++ = stbsp__period;
    2c0e:	00004717          	auipc	a4,0x4
    2c12:	dbe74703          	lbu	a4,-578(a4) # 69cc <stbsp__period>
            n = -dp;
    2c16:	40f007bb          	negw	a5,a5
               *s++ = stbsp__period;
    2c1a:	0ce100a3          	sb	a4,193(sp)
            if ((stbsp__int32)n > pr)
    2c1e:	0007871b          	sext.w	a4,a5
    2c22:	00e8d363          	bge	a7,a4,2c28 <stbsp_vsprintfcb+0x19a2>
    2c26:	87c6                	mv	a5,a7
    2c28:	0007871b          	sext.w	a4,a5
            if ((stbsp__int32)(l + n) > pr)
    2c2c:	00d7833b          	addw	t1,a5,a3
    2c30:	883a                	mv	a6,a4
            while (i) {
    2c32:	0c210793          	addi	a5,sp,194
               *s++ = '0';
    2c36:	03000513          	li	a0,48
            while (i) {
    2c3a:	e711                	bnez	a4,2c46 <stbsp_vsprintfcb+0x19c0>
    2c3c:	a271                	j	2dc8 <stbsp_vsprintfcb+0x1b42>
               if ((((stbsp__uintptr)s) & 3) == 0)
    2c3e:	0037f613          	andi	a2,a5,3
    2c42:	18060563          	beqz	a2,2dcc <stbsp_vsprintfcb+0x1b46>
               *s++ = '0';
    2c46:	85ba                	mv	a1,a4
    2c48:	00a78023          	sb	a0,0(a5)
               --i;
    2c4c:	377d                	addiw	a4,a4,-1
               *s++ = '0';
    2c4e:	0785                	addi	a5,a5,1
            while (i) {
    2c50:	f77d                	bnez	a4,2c3e <stbsp_vsprintfcb+0x19b8>
            if ((stbsp__int32)(l + n) > pr)
    2c52:	0003071b          	sext.w	a4,t1
    2c56:	4108863b          	subw	a2,a7,a6
    2c5a:	00e8d563          	bge	a7,a4,2c64 <stbsp_vsprintfcb+0x19de>
               l = pr - n;
    2c5e:	0006069b          	sext.w	a3,a2
    2c62:	d0b2                	sw	a2,96(sp)
            while (i) {
    2c64:	c68d                	beqz	a3,2c8e <stbsp_vsprintfcb+0x1a08>
    2c66:	7566                	ld	a0,120(sp)
    2c68:	02069813          	slli	a6,a3,0x20
    2c6c:	02085813          	srli	a6,a6,0x20
    2c70:	01078eb3          	add	t4,a5,a6
    2c74:	85aa                	mv	a1,a0
    2c76:	873e                	mv	a4,a5
               *s++ = *sn++;
    2c78:	0005c883          	lbu	a7,0(a1)
    2c7c:	0705                	addi	a4,a4,1
            while (i) {
    2c7e:	0585                	addi	a1,a1,1
               *s++ = *sn++;
    2c80:	ff170fa3          	sb	a7,-1(a4)
            while (i) {
    2c84:	ffd71ae3          	bne	a4,t4,2c78 <stbsp_vsprintfcb+0x19f2>
    2c88:	9542                	add	a0,a0,a6
    2c8a:	97c2                	add	a5,a5,a6
    2c8c:	fcaa                	sd	a0,120(sp)
         l = (stbsp__uint32)(s - (num + 64));
    2c8e:	0c010a93          	addi	s5,sp,192
            cs = 1 + (3 << 24); // how many tens did we write (for commas below)
    2c92:	030002b7          	lui	t0,0x3000
            tz = pr - (n + l);
    2c96:	40d608bb          	subw	a7,a2,a3
         l = (stbsp__uint32)(s - (num + 64));
    2c9a:	415787b3          	sub	a5,a5,s5
            cs = 1 + (3 << 24); // how many tens did we write (for commas below)
    2c9e:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff8809>
    2ca0:	fbcff06f          	j	245c <stbsp_vsprintfcb+0x11d6>
            *--s = '0';
    2ca4:	03000793          	li	a5,48
    2ca8:	fefa8fa3          	sb	a5,-1(s5)
            l = 1;
    2cac:	030002b7          	lui	t0,0x3000
    2cb0:	4785                	li	a5,1
    2cb2:	d0be                	sw	a5,96(sp)
            *--s = '0';
    2cb4:	1afd                	addi	s5,s5,-1
            l = 1;
    2cb6:	4605                	li	a2,1
    2cb8:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff8809>
    2cba:	4685                	li	a3,1
    2cbc:	b9dd                	j	29b2 <stbsp_vsprintfcb+0x172c>
   } else if (fl & STBSP__LEADINGSPACE) {
    2cbe:	004e7713          	andi	a4,t3,4
    2cc2:	e74d                	bnez	a4,2d6c <stbsp_vsprintfcb+0x1ae6>
   } else if (fl & STBSP__LEADINGPLUS) {
    2cc4:	8b89                	andi	a5,a5,2
    2cc6:	efd9                	bnez	a5,2d64 <stbsp_vsprintfcb+0x1ade>
   sign[0] = 0;
    2cc8:	06010423          	sb	zero,104(sp)
    2ccc:	4a01                	li	s4,0
    2cce:	b9c9                	j	29a0 <stbsp_vsprintfcb+0x171a>
               if ((s[0] == '0') && (s != (num + STBSP__NUMSZ)))
    2cd0:	051c                	addi	a5,sp,640
    2cd2:	cafa89e3          	beq	s5,a5,2984 <stbsp_vsprintfcb+0x16fe>
                  ++s;
    2cd6:	0a85                	addi	s5,s5,1
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    2cd8:	415786bb          	subw	a3,a5,s5
    2cdc:	b165                	j	2984 <stbsp_vsprintfcb+0x16fe>
                  n = dp - n;
    2cde:	40ce87bb          	subw	a5,t4,a2
                  if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    2ce2:	12030e63          	beqz	t1,2e1e <stbsp_vsprintfcb+0x1b98>
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2ce6:	4511                	li	a0,4
    2ce8:	03000613          	li	a2,48
                        *s++ = stbsp__comma;
    2cec:	00170693          	addi	a3,a4,1
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2cf0:	00030563          	beqz	t1,2cfa <stbsp_vsprintfcb+0x1a74>
    2cf4:	2585                	addiw	a1,a1,1
    2cf6:	00a58963          	beq	a1,a0,2d08 <stbsp_vsprintfcb+0x1a82>
    2cfa:	8736                	mv	a4,a3
                        --n;
    2cfc:	37fd                	addiw	a5,a5,-1
    2cfe:	fec70fa3          	sb	a2,-1(a4)
                  while (n) {
    2d02:	f7ed                	bnez	a5,2cec <stbsp_vsprintfcb+0x1a66>
    2d04:	f38ff06f          	j	243c <stbsp_vsprintfcb+0x11b6>
    2d08:	fe568fa3          	sb	t0,-1(a3)
                        *s++ = stbsp__comma;
    2d0c:	0709                	addi	a4,a4,2
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2d0e:	4585                	li	a1,1
    2d10:	b7f5                	j	2cfc <stbsp_vsprintfcb+0x1a76>
   sign[0] = 0;
    2d12:	06010423          	sb	zero,104(sp)
    2d16:	f1dfe06f          	j	1c32 <stbsp_vsprintfcb+0x9ac>
                     tail[idx + 1] = "_kMGT"[fl >> 24];
    2d1a:	00002697          	auipc	a3,0x2
    2d1e:	32e68693          	addi	a3,a3,814 # 5048 <_GLOBAL__sub_I__ZSt3cin+0xa0>
    2d22:	9736                	add	a4,a4,a3
    2d24:	00074683          	lbu	a3,0(a4)
    2d28:	1088                	addi	a0,sp,96
    2d2a:	22060713          	addi	a4,a2,544
    2d2e:	972a                	add	a4,a4,a0
    2d30:	ded70823          	sb	a3,-528(a4)
                  idx++;
    2d34:	8fb2                	mv	t6,a2
    2d36:	fb0ff06f          	j	24e6 <stbsp_vsprintfcb+0x1260>
   while (limit && *sn) {
    2d3a:	e00692e3          	bnez	a3,2b3e <stbsp_vsprintfcb+0x18b8>
    2d3e:	bd19                	j	2b54 <stbsp_vsprintfcb+0x18ce>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    2d40:	0008071b          	sext.w	a4,a6
    2d44:	86c2                	mv	a3,a6
    2d46:	88d2                	mv	a7,s4
            pr = -dp + ((pr > (stbsp__int32)l) ? (stbsp__int32) l : pr);
    2d48:	863a                	mv	a2,a4
    2d4a:	00e8d363          	bge	a7,a4,2d50 <stbsp_vsprintfcb+0x1aca>
    2d4e:	8646                	mv	a2,a7
    2d50:	40f608bb          	subw	a7,a2,a5
    2d54:	814ff06f          	j	1d68 <stbsp_vsprintfcb+0xae2>
            divisor = 1000.0f;
    2d58:	00003797          	auipc	a5,0x3
    2d5c:	a907b787          	fld	fa5,-1392(a5) # 57e8 <STDIN_FD+0x28>
    2d60:	dd5fe06f          	j	1b34 <stbsp_vsprintfcb+0x8ae>
    2d64:	678d                	lui	a5,0x3
    2d66:	b017879b          	addiw	a5,a5,-1279 # 2b01 <stbsp_vsprintfcb+0x187b>
    2d6a:	b13d                	j	2998 <stbsp_vsprintfcb+0x1712>
    2d6c:	6789                	lui	a5,0x2
    2d6e:	2785                	addiw	a5,a5,1 # 2001 <stbsp_vsprintfcb+0xd7b>
    2d70:	b125                	j	2998 <stbsp_vsprintfcb+0x1712>
            *s++ = stbsp__period;
    2d72:	00004517          	auipc	a0,0x4
    2d76:	c5a54503          	lbu	a0,-934(a0) # 69cc <stbsp__period>
         sn = s;
    2d7a:	0c210793          	addi	a5,sp,194
         n = pr;
    2d7e:	0008869b          	sext.w	a3,a7
            *s++ = stbsp__period;
    2d82:	0ca100a3          	sb	a0,193(sp)
         sn = s;
    2d86:	fcbe                	sd	a5,120(sp)
         if (n > 13)
    2d88:	4535                	li	a0,13
         n64 <<= 4;
    2d8a:	0712                	slli	a4,a4,0x4
         if (n > 13)
    2d8c:	8836                	mv	a6,a3
    2d8e:	00d57363          	bgeu	a0,a3,2d94 <stbsp_vsprintfcb+0x1b0e>
    2d92:	4835                	li	a6,13
    2d94:	0008051b          	sext.w	a0,a6
         while (n--) {
    2d98:	387d                	addiw	a6,a6,-1
         if (pr > (stbsp__int32)n)
    2d9a:	af1542e3          	blt	a0,a7,287e <stbsp_vsprintfcb+0x15f8>
      tz = 0;
    2d9e:	4881                	li	a7,0
    2da0:	b4cd                	j	2882 <stbsp_vsprintfcb+0x15fc>
               while (n < l) {
    2da2:	87ba                	mv	a5,a4
    2da4:	bc1d                	j	27da <stbsp_vsprintfcb+0x1554>
         tail[0] = (char)n;
    2da6:	478d                	li	a5,3
    2da8:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    2dac:	06b109a3          	sb	a1,115(sp)
    2db0:	480d                	li	a6,3
    2db2:	4f8d                	li	t6,3
    2db4:	8e4ff06f          	j	1e98 <stbsp_vsprintfcb+0xc12>
    2db8:	678d                	lui	a5,0x3
    2dba:	b017879b          	addiw	a5,a5,-1279 # 2b01 <stbsp_vsprintfcb+0x187b>
    2dbe:	80aff06f          	j	1dc8 <stbsp_vsprintfcb+0xb42>
            if (pr)
    2dc2:	8336                	mv	t1,a3
            *s++ = '0';
    2dc4:	0c110793          	addi	a5,sp,193
            while (i) {
    2dc8:	4801                	li	a6,0
    2dca:	b561                	j	2c52 <stbsp_vsprintfcb+0x19cc>
            while (i >= 4) {
    2dcc:	460d                	li	a2,3
    2dce:	04e65663          	bge	a2,a4,2e1a <stbsp_vsprintfcb+0x1b94>
    2dd2:	ffb5871b          	addiw	a4,a1,-5
    2dd6:	0027559b          	srliw	a1,a4,0x2
    2dda:	0015861b          	addiw	a2,a1,1
    2dde:	060a                	slli	a2,a2,0x2
               *(stbsp__uint32 *)s = 0x30303030;
    2de0:	30303537          	lui	a0,0x30303
    2de4:	963e                	add	a2,a2,a5
    2de6:	03050513          	addi	a0,a0,48 # 30303030 <_ZSt4cerr+0x302fb838>
    2dea:	c388                	sw	a0,0(a5)
               s += 4;
    2dec:	0791                	addi	a5,a5,4
            while (i >= 4) {
    2dee:	fef61ee3          	bne	a2,a5,2dea <stbsp_vsprintfcb+0x1b64>
    2df2:	0025959b          	slliw	a1,a1,0x2
    2df6:	9f0d                	subw	a4,a4,a1
            while (i) {
    2df8:	e4070de3          	beqz	a4,2c52 <stbsp_vsprintfcb+0x19cc>
               *s++ = '0';
    2dfc:	03000513          	li	a0,48
            while (i) {
    2e00:	00f705bb          	addw	a1,a4,a5
               *s++ = '0';
    2e04:	0605                	addi	a2,a2,1
            while (i) {
    2e06:	00060e9b          	sext.w	t4,a2
               *s++ = '0';
    2e0a:	fea60fa3          	sb	a0,-1(a2)
            while (i) {
    2e0e:	ffd59be3          	bne	a1,t4,2e04 <stbsp_vsprintfcb+0x1b7e>
    2e12:	1702                	slli	a4,a4,0x20
    2e14:	9301                	srli	a4,a4,0x20
    2e16:	97ba                	add	a5,a5,a4
    2e18:	bd2d                	j	2c52 <stbsp_vsprintfcb+0x19cc>
            while (i >= 4) {
    2e1a:	863e                	mv	a2,a5
    2e1c:	b7c5                	j	2dfc <stbsp_vsprintfcb+0x1b76>
                        if ((((stbsp__uintptr)s) & 3) == 0)
    2e1e:	00377693          	andi	a3,a4,3
    2e22:	ce81                	beqz	a3,2e3a <stbsp_vsprintfcb+0x1bb4>
                        *s++ = '0';
    2e24:	03000693          	li	a3,48
    2e28:	00d70023          	sb	a3,0(a4)
                        --n;
    2e2c:	37fd                	addiw	a5,a5,-1
                        *s++ = '0';
    2e2e:	0705                	addi	a4,a4,1
                     while (n) {
    2e30:	e0078663          	beqz	a5,243c <stbsp_vsprintfcb+0x11b6>
                        if ((((stbsp__uintptr)s) & 3) == 0)
    2e34:	00377613          	andi	a2,a4,3
    2e38:	fa65                	bnez	a2,2e28 <stbsp_vsprintfcb+0x1ba2>
                     while (n >= 4) {
    2e3a:	468d                	li	a3,3
    2e3c:	eaf6f5e3          	bgeu	a3,a5,2ce6 <stbsp_vsprintfcb+0x1a60>
    2e40:	ffc7869b          	addiw	a3,a5,-4
    2e44:	0026d69b          	srliw	a3,a3,0x2
    2e48:	2685                	addiw	a3,a3,1
    2e4a:	068a                	slli	a3,a3,0x2
                        *(stbsp__uint32 *)s = 0x30303030;
    2e4c:	30303637          	lui	a2,0x30303
    2e50:	96ba                	add	a3,a3,a4
    2e52:	03060613          	addi	a2,a2,48 # 30303030 <_ZSt4cerr+0x302fb838>
    2e56:	c310                	sw	a2,0(a4)
                        s += 4;
    2e58:	0711                	addi	a4,a4,4
                     while (n >= 4) {
    2e5a:	fed71ee3          	bne	a4,a3,2e56 <stbsp_vsprintfcb+0x1bd0>
    2e5e:	8b8d                	andi	a5,a5,3
                  while (n) {
    2e60:	e80793e3          	bnez	a5,2ce6 <stbsp_vsprintfcb+0x1a60>
    2e64:	dd8ff06f          	j	243c <stbsp_vsprintfcb+0x11b6>
      if (((stbsp__uintptr)sn & 3) == 0)
    2e68:	87d6                	mv	a5,s5
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    2e6a:	56fd                	li	a3,-1
    2e6c:	b155                	j	2b10 <stbsp_vsprintfcb+0x188a>
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    2e6e:	5775                	li	a4,-3
    2e70:	00e7ce63          	blt	a5,a4,2e8c <stbsp_vsprintfcb+0x1c06>
    2e74:	f6fa4663          	blt	s4,a5,25e0 <stbsp_vsprintfcb+0x135a>
         if (dp > 0) {
    2e78:	ecf054e3          	blez	a5,2d40 <stbsp_vsprintfcb+0x1aba>
    2e7c:	86c2                	mv	a3,a6
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    2e7e:	4881                	li	a7,0
    2e80:	ee9fe06f          	j	1d68 <stbsp_vsprintfcb+0xae2>
                  while (i--)
    2e84:	fff7869b          	addiw	a3,a5,-1
    2e88:	8722                	mv	a4,s0
    2e8a:	b105                	j	2aaa <stbsp_vsprintfcb+0x1824>
            if (pr > (stbsp__int32)l)
    2e8c:	0008071b          	sext.w	a4,a6
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2e90:	7ae6                	ld	s5,120(sp)
            if (pr > (stbsp__int32)l)
    2e92:	86c2                	mv	a3,a6
    2e94:	88d2                	mv	a7,s4
    2e96:	f7475d63          	bge	a4,s4,2610 <stbsp_vsprintfcb+0x138a>
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2e9a:	8542                	mv	a0,a6
    2e9c:	f56ff06f          	j	25f2 <stbsp_vsprintfcb+0x136c>

0000000000002ea0 <stbsp_sprintf>:
{
    2ea0:	715d                	addi	sp,sp,-80
   va_start(va, fmt);
    2ea2:	02010313          	addi	t1,sp,32
{
    2ea6:	f032                	sd	a2,32(sp)
    2ea8:	f436                	sd	a3,40(sp)
    2eaa:	f83a                	sd	a4,48(sp)
   result = STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    2eac:	86ae                	mv	a3,a1
    2eae:	862a                	mv	a2,a0
    2eb0:	871a                	mv	a4,t1
    2eb2:	4581                	li	a1,0
    2eb4:	4501                	li	a0,0
{
    2eb6:	ec06                	sd	ra,24(sp)
    2eb8:	fc3e                	sd	a5,56(sp)
    2eba:	e0c2                	sd	a6,64(sp)
    2ebc:	e4c6                	sd	a7,72(sp)
   va_start(va, fmt);
    2ebe:	e41a                	sd	t1,8(sp)
   result = STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    2ec0:	bc6fe0ef          	jal	1286 <stbsp_vsprintfcb>
}
    2ec4:	60e2                	ld	ra,24(sp)
    2ec6:	6161                	addi	sp,sp,80
    2ec8:	8082                	ret

0000000000002eca <stbsp_vsnprintf>:
{
    2eca:	dd010113          	addi	sp,sp,-560
    2ece:	22813023          	sd	s0,544(sp)
    2ed2:	20913c23          	sd	s1,536(sp)
    2ed6:	22113423          	sd	ra,552(sp)
    2eda:	84ae                	mv	s1,a1
    2edc:	842a                	mv	s0,a0
    2ede:	88b2                	mv	a7,a2
    2ee0:	8736                	mv	a4,a3
   if ( (count == 0) && !buf )
    2ee2:	e591                	bnez	a1,2eee <stbsp_vsnprintf+0x24>
    2ee4:	c141                	beqz	a0,2f64 <stbsp_vsnprintf+0x9a>
      c.buf = buf;
    2ee6:	e02a                	sd	a0,0(sp)
      c.count = count;
    2ee8:	e402                	sd	zero,8(sp)
   return (c->count >= STB_SPRINTF_MIN) ? c->buf : c->tmp; // go direct into buffer if you can
    2eea:	0810                	addi	a2,sp,16
    2eec:	a089                	j	2f2e <stbsp_vsnprintf+0x64>
   if (len > c->count)
    2eee:	0015a593          	slti	a1,a1,1
    2ef2:	40b005bb          	negw	a1,a1
    2ef6:	8de5                	and	a1,a1,s1
      c.buf = buf;
    2ef8:	e02a                	sd	a0,0(sp)
      c.count = count;
    2efa:	c426                	sw	s1,8(sp)
      c.length = 0;
    2efc:	c602                	sw	zero,12(sp)
   if (len > c->count)
    2efe:	2581                	sext.w	a1,a1
   if (len) {
    2f00:	0804d663          	bgez	s1,2f8c <stbsp_vsnprintf+0xc2>
         s = buf;
    2f04:	4781                	li	a5,0
      if (buf != c->buf) {
    2f06:	c911                	beqz	a0,2f1a <stbsp_vsnprintf+0x50>
            *d++ = *s++;
    2f08:	0007c803          	lbu	a6,0(a5)
    2f0c:	0785                	addi	a5,a5,1
    2f0e:	00f40533          	add	a0,s0,a5
    2f12:	ff050fa3          	sb	a6,-1(a0)
         } while (s < se);
    2f16:	feb7e9e3          	bltu	a5,a1,2f08 <stbsp_vsnprintf+0x3e>
      c->count -= len;
    2f1a:	40b486bb          	subw	a3,s1,a1
      c->buf += len;
    2f1e:	95a2                	add	a1,a1,s0
    2f20:	e02e                	sd	a1,0(sp)
      c->count -= len;
    2f22:	c436                	sw	a3,8(sp)
   return (c->count >= STB_SPRINTF_MIN) ? c->buf : c->tmp; // go direct into buffer if you can
    2f24:	1ff00793          	li	a5,511
    2f28:	fcd7d1e3          	bge	a5,a3,2eea <stbsp_vsnprintf+0x20>
    2f2c:	6602                	ld	a2,0(sp)
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__clamp_callback, &c, stbsp__clamp_callback(0,&c,0), fmt, va );
    2f2e:	86c6                	mv	a3,a7
    2f30:	858a                	mv	a1,sp
    2f32:	ffffd517          	auipc	a0,0xffffd
    2f36:	21650513          	addi	a0,a0,534 # 148 <stbsp__clamp_callback>
    2f3a:	b4cfe0ef          	jal	1286 <stbsp_vsprintfcb>
      l = (int)( c.buf - buf );
    2f3e:	6782                	ld	a5,0(sp)
    2f40:	9f81                	subw	a5,a5,s0
      if ( l >= count ) // should never be greater, only equal (or less) than count
    2f42:	0097c463          	blt	a5,s1,2f4a <stbsp_vsnprintf+0x80>
         l = count - 1;
    2f46:	fff4879b          	addiw	a5,s1,-1
      buf[l] = 0;
    2f4a:	943e                	add	s0,s0,a5
    2f4c:	00040023          	sb	zero,0(s0)
}
    2f50:	22813083          	ld	ra,552(sp)
    2f54:	22013403          	ld	s0,544(sp)
    2f58:	4532                	lw	a0,12(sp)
    2f5a:	21813483          	ld	s1,536(sp)
    2f5e:	23010113          	addi	sp,sp,560
    2f62:	8082                	ret
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__count_clamp_callback, &c, c.tmp, fmt, va );
    2f64:	86b2                	mv	a3,a2
    2f66:	858a                	mv	a1,sp
    2f68:	0810                	addi	a2,sp,16
    2f6a:	ffffd517          	auipc	a0,0xffffd
    2f6e:	22c50513          	addi	a0,a0,556 # 196 <stbsp__count_clamp_callback>
      c.length = 0;
    2f72:	c602                	sw	zero,12(sp)
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__count_clamp_callback, &c, c.tmp, fmt, va );
    2f74:	b12fe0ef          	jal	1286 <stbsp_vsprintfcb>
}
    2f78:	22813083          	ld	ra,552(sp)
    2f7c:	22013403          	ld	s0,544(sp)
    2f80:	4532                	lw	a0,12(sp)
    2f82:	21813483          	ld	s1,536(sp)
    2f86:	23010113          	addi	sp,sp,560
    2f8a:	8082                	ret
    2f8c:	86a6                	mv	a3,s1
    2f8e:	bf59                	j	2f24 <stbsp_vsnprintf+0x5a>

0000000000002f90 <stbsp_snprintf>:
{
    2f90:	715d                	addi	sp,sp,-80
   va_start(va, fmt);
    2f92:	02810313          	addi	t1,sp,40
{
    2f96:	f436                	sd	a3,40(sp)
   result = STB_SPRINTF_DECORATE(vsnprintf)(buf, count, fmt, va);
    2f98:	869a                	mv	a3,t1
{
    2f9a:	ec06                	sd	ra,24(sp)
    2f9c:	f83a                	sd	a4,48(sp)
    2f9e:	fc3e                	sd	a5,56(sp)
    2fa0:	e0c2                	sd	a6,64(sp)
    2fa2:	e4c6                	sd	a7,72(sp)
   va_start(va, fmt);
    2fa4:	e41a                	sd	t1,8(sp)
   result = STB_SPRINTF_DECORATE(vsnprintf)(buf, count, fmt, va);
    2fa6:	f25ff0ef          	jal	2eca <stbsp_vsnprintf>
}
    2faa:	60e2                	ld	ra,24(sp)
    2fac:	6161                	addi	sp,sp,80
    2fae:	8082                	ret

0000000000002fb0 <stbsp_vsprintf>:
{
    2fb0:	86ae                	mv	a3,a1
    2fb2:	8732                	mv	a4,a2
   return STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    2fb4:	4581                	li	a1,0
    2fb6:	862a                	mv	a2,a0
    2fb8:	4501                	li	a0,0
    2fba:	accfe06f          	j	1286 <stbsp_vsprintfcb>

0000000000002fbe <sprintf>:
{
    2fbe:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    2fc0:	05010313          	addi	t1,sp,80
{
    2fc4:	e0a2                	sd	s0,64(sp)
    2fc6:	fc26                	sd	s1,56(sp)
    2fc8:	842a                	mv	s0,a0
    2fca:	e8b2                	sd	a2,80(sp)
    _vprintf_core(&ctx, format, ap);
    2fcc:	0808                	addi	a0,sp,16
    ctx.limit = size;
    2fce:	54fd                	li	s1,-1
    _vprintf_core(&ctx, format, ap);
    2fd0:	861a                	mv	a2,t1
{
    2fd2:	e486                	sd	ra,72(sp)
    2fd4:	ecb6                	sd	a3,88(sp)
    2fd6:	f0ba                	sd	a4,96(sp)
    2fd8:	f4be                	sd	a5,104(sp)
    2fda:	f8c2                	sd	a6,112(sp)
    2fdc:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    2fde:	e41a                	sd	t1,8(sp)
    ctx.buf = str;
    2fe0:	e822                	sd	s0,16(sp)
    ctx.limit = size;
    2fe2:	ec26                	sd	s1,24(sp)
    ctx.written = 0;
    2fe4:	f002                	sd	zero,32(sp)
    ctx.stream = NULL;
    2fe6:	f402                	sd	zero,40(sp)
    _vprintf_core(&ctx, format, ap);
    2fe8:	02c000ef          	jal	3014 <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    2fec:	7502                	ld	a0,32(sp)
    2fee:	00950b63          	beq	a0,s1,3004 <sprintf+0x46>
            str[ctx.written] = '\0';
    2ff2:	942a                	add	s0,s0,a0
    2ff4:	00040023          	sb	zero,0(s0)
}
    2ff8:	60a6                	ld	ra,72(sp)
    2ffa:	6406                	ld	s0,64(sp)
    2ffc:	74e2                	ld	s1,56(sp)
    2ffe:	2501                	sext.w	a0,a0
    3000:	6109                	addi	sp,sp,128
    3002:	8082                	ret
            str[size - 1] = '\0';
    3004:	fe040f23          	sb	zero,-2(s0)
}
    3008:	60a6                	ld	ra,72(sp)
    300a:	6406                	ld	s0,64(sp)
    300c:	74e2                	ld	s1,56(sp)
    300e:	2501                	sext.w	a0,a0
    3010:	6109                	addi	sp,sp,128
    3012:	8082                	ret

0000000000003014 <_vprintf_core.constprop.0.isra.0>:
static int _vprintf_core(_OutContext *ctx, const char *format, va_list ap)
    3014:	7129                	addi	sp,sp,-320
    3016:	edee                	sd	s11,216(sp)
    3018:	fe06                	sd	ra,312(sp)
    301a:	8dae                	mv	s11,a1
    while (*p)
    301c:	0005c583          	lbu	a1,0(a1)
    3020:	cde9                	beqz	a1,30fa <_vprintf_core.constprop.0.isra.0+0xe6>
    3022:	f626                	sd	s1,296(sp)
    3024:	f24a                	sd	s2,288(sp)
    3026:	ee4e                	sd	s3,280(sp)
    3028:	e656                	sd	s5,264(sp)
    302a:	f9e2                	sd	s8,240(sp)
    302c:	fa22                	sd	s0,304(sp)
    302e:	ea52                	sd	s4,272(sp)
    3030:	e25a                	sd	s6,256(sp)
    3032:	fdde                	sd	s7,248(sp)
    3034:	f5e6                	sd	s9,232(sp)
    3036:	f1ea                	sd	s10,224(sp)
    3038:	84aa                	mv	s1,a0
    303a:	8c32                	mv	s8,a2
        if (*p != '%')
    303c:	02500a93          	li	s5,37
    3040:	49c1                	li	s3,16
    3042:	00002917          	auipc	s2,0x2
    3046:	2da90913          	addi	s2,s2,730 # 531c <_GLOBAL__sub_I__ZSt3cin+0x374>
    304a:	a039                	j	3058 <_vprintf_core.constprop.0.isra.0+0x44>
                _out_char(ctx, spec);
    304c:	8526                	mv	a0,s1
    304e:	952fe0ef          	jal	11a0 <_out_char>
    while (*p)
    3052:	000dc583          	lbu	a1,0(s11)
    3056:	c5d9                	beqz	a1,30e4 <_vprintf_core.constprop.0.isra.0+0xd0>
            _out_char(ctx, *p++);
    3058:	0d85                	addi	s11,s11,1
        if (*p != '%')
    305a:	ff5599e3          	bne	a1,s5,304c <_vprintf_core.constprop.0.isra.0+0x38>
        int flag_left = 0, flag_zero = 0, flag_plus = 0, flag_space = 0, flag_hash = 0;
    305e:	4501                	li	a0,0
    3060:	4881                	li	a7,0
    3062:	4581                	li	a1,0
    3064:	4b01                	li	s6,0
    3066:	4a01                	li	s4,0
            if (*p == '-')
    3068:	000dcc83          	lbu	s9,0(s11)
    306c:	fe0c871b          	addiw	a4,s9,-32
    3070:	0ff77713          	zext.b	a4,a4
    3074:	00e9e763          	bltu	s3,a4,3082 <_vprintf_core.constprop.0.isra.0+0x6e>
    3078:	070a                	slli	a4,a4,0x2
    307a:	974a                	add	a4,a4,s2
    307c:	4318                	lw	a4,0(a4)
    307e:	974a                	add	a4,a4,s2
    3080:	8702                	jr	a4
        if (*p == '*')
    3082:	02a00793          	li	a5,42
    3086:	16fc9c63          	bne	s9,a5,31fe <_vprintf_core.constprop.0.isra.0+0x1ea>
            width = va_arg(ap, int);
    308a:	000c2403          	lw	s0,0(s8)
    308e:	0c21                	addi	s8,s8,8
            if (width < 0)
    3090:	00045563          	bgez	s0,309a <_vprintf_core.constprop.0.isra.0+0x86>
                width = -width;
    3094:	4080043b          	negw	s0,s0
                flag_left = 1;
    3098:	4a05                	li	s4,1
            while (*p >= '0' && *p <= '9')
    309a:	001dcc83          	lbu	s9,1(s11)
            p++;
    309e:	0d85                	addi	s11,s11,1
        if (*p == '.')
    30a0:	02e00793          	li	a5,46
        int precision = -1;
    30a4:	5bfd                	li	s7,-1
        if (*p == '.')
    30a6:	18fc8a63          	beq	s9,a5,323a <_vprintf_core.constprop.0.isra.0+0x226>
        if (*p == 'l')
    30aa:	06c00693          	li	a3,108
    30ae:	8666                	mv	a2,s9
    30b0:	1adc8663          	beq	s9,a3,325c <_vprintf_core.constprop.0.isra.0+0x248>
        else if (*p == 'z')
    30b4:	07a00693          	li	a3,122
            p++;
    30b8:	0d85                	addi	s11,s11,1
        else if (*p == 'z')
    30ba:	24dc8163          	beq	s9,a3,32fc <_vprintf_core.constprop.0.isra.0+0x2e8>
        if (!spec)
    30be:	06400693          	li	a3,100
    30c2:	4adc8163          	beq	s9,a3,3564 <_vprintf_core.constprop.0.isra.0+0x550>
    30c6:	06400693          	li	a3,100
        int len_mod = 0;
    30ca:	4e81                	li	t4,0
    30cc:	1b96e663          	bltu	a3,s9,3278 <_vprintf_core.constprop.0.isra.0+0x264>
    30d0:	04700693          	li	a3,71
    30d4:	2796e463          	bltu	a3,s9,333c <_vprintf_core.constprop.0.isra.0+0x328>
    30d8:	04400693          	li	a3,68
    30dc:	0596e363          	bltu	a3,s9,3122 <_vprintf_core.constprop.0.isra.0+0x10e>
    30e0:	240c9363          	bnez	s9,3326 <_vprintf_core.constprop.0.isra.0+0x312>
    30e4:	7452                	ld	s0,304(sp)
    30e6:	74b2                	ld	s1,296(sp)
    30e8:	7912                	ld	s2,288(sp)
    30ea:	69f2                	ld	s3,280(sp)
    30ec:	6a52                	ld	s4,272(sp)
    30ee:	6ab2                	ld	s5,264(sp)
    30f0:	6b12                	ld	s6,256(sp)
    30f2:	7bee                	ld	s7,248(sp)
    30f4:	7c4e                	ld	s8,240(sp)
    30f6:	7cae                	ld	s9,232(sp)
    30f8:	7d0e                	ld	s10,224(sp)
}
    30fa:	70f2                	ld	ra,312(sp)
    30fc:	6dee                	ld	s11,216(sp)
    30fe:	6131                	addi	sp,sp,320
    3100:	8082                	ret
            if (*p == '-')
    3102:	4585                	li	a1,1
            p++;
    3104:	0d85                	addi	s11,s11,1
            if (*p == '-')
    3106:	b78d                	j	3068 <_vprintf_core.constprop.0.isra.0+0x54>
    3108:	4505                	li	a0,1
            p++;
    310a:	0d85                	addi	s11,s11,1
        while (1)
    310c:	bfb1                	j	3068 <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    310e:	4885                	li	a7,1
            p++;
    3110:	0d85                	addi	s11,s11,1
        while (1)
    3112:	bf99                	j	3068 <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    3114:	4b05                	li	s6,1
            p++;
    3116:	0d85                	addi	s11,s11,1
        while (1)
    3118:	bf81                	j	3068 <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    311a:	4a05                	li	s4,1
            p++;
    311c:	0d85                	addi	s11,s11,1
        while (1)
    311e:	b7a9                	j	3068 <_vprintf_core.constprop.0.isra.0+0x54>
        char spec = *p++;
    3120:	8dbe                	mv	s11,a5
            fmt_tmp[f_idx++] = '%';
    3122:	02500693          	li	a3,37
    3126:	02d10823          	sb	a3,48(sp)
    312a:	4d05                	li	s10,1
            if (flag_left)
    312c:	000a0763          	beqz	s4,313a <_vprintf_core.constprop.0.isra.0+0x126>
                fmt_tmp[f_idx++] = '-';
    3130:	02d00693          	li	a3,45
    3134:	02d108a3          	sb	a3,49(sp)
    3138:	4d09                	li	s10,2
            if (flag_zero)
    313a:	000b0c63          	beqz	s6,3152 <_vprintf_core.constprop.0.isra.0+0x13e>
                fmt_tmp[f_idx++] = '0';
    313e:	0c0d0793          	addi	a5,s10,192
    3142:	0818                	addi	a4,sp,16
    3144:	00e786b3          	add	a3,a5,a4
    3148:	03000613          	li	a2,48
    314c:	f6c68023          	sb	a2,-160(a3)
    3150:	2d05                	addiw	s10,s10,1
            if (flag_plus)
    3152:	c999                	beqz	a1,3168 <_vprintf_core.constprop.0.isra.0+0x154>
                fmt_tmp[f_idx++] = '+';
    3154:	0c0d0793          	addi	a5,s10,192
    3158:	0818                	addi	a4,sp,16
    315a:	00e786b3          	add	a3,a5,a4
    315e:	02b00613          	li	a2,43
    3162:	f6c68023          	sb	a2,-160(a3)
    3166:	2d05                	addiw	s10,s10,1
            if (flag_space)
    3168:	00088c63          	beqz	a7,3180 <_vprintf_core.constprop.0.isra.0+0x16c>
                fmt_tmp[f_idx++] = ' ';
    316c:	0c0d0793          	addi	a5,s10,192
    3170:	0818                	addi	a4,sp,16
    3172:	00e786b3          	add	a3,a5,a4
    3176:	02000613          	li	a2,32
    317a:	f6c68023          	sb	a2,-160(a3)
    317e:	2d05                	addiw	s10,s10,1
            if (flag_hash)
    3180:	c919                	beqz	a0,3196 <_vprintf_core.constprop.0.isra.0+0x182>
                fmt_tmp[f_idx++] = '#';
    3182:	0c0d0793          	addi	a5,s10,192
    3186:	0818                	addi	a4,sp,16
    3188:	00e786b3          	add	a3,a5,a4
    318c:	02300613          	li	a2,35
    3190:	f6c68023          	sb	a2,-160(a3)
    3194:	2d05                	addiw	s10,s10,1
            if (width > 0)
    3196:	03010a13          	addi	s4,sp,48
    319a:	28804563          	bgtz	s0,3424 <_vprintf_core.constprop.0.isra.0+0x410>
            if (precision >= 0)
    319e:	260bd763          	bgez	s7,340c <_vprintf_core.constprop.0.isra.0+0x3f8>
            fmt_tmp[f_idx++] = spec;
    31a2:	0c0d0793          	addi	a5,s10,192
    31a6:	0818                	addi	a4,sp,16
    31a8:	00e78633          	add	a2,a5,a4
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    31ac:	000c3683          	ld	a3,0(s8)
            fmt_tmp[f_idx] = '\0';
    31b0:	001d071b          	addiw	a4,s10,1
    31b4:	0c070793          	addi	a5,a4,192
    31b8:	0818                	addi	a4,sp,16
            fmt_tmp[f_idx++] = spec;
    31ba:	f7960023          	sb	s9,-160(a2)
            fmt_tmp[f_idx] = '\0';
    31be:	973e                	add	a4,a4,a5
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    31c0:	08000593          	li	a1,128
    31c4:	8652                	mv	a2,s4
    31c6:	0888                	addi	a0,sp,80
            fmt_tmp[f_idx] = '\0';
    31c8:	f6070023          	sb	zero,-160(a4)
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    31cc:	dc5ff0ef          	jal	2f90 <stbsp_snprintf>
            for (int i = 0; f_buf[i] != '\0'; i++)
    31d0:	05014583          	lbu	a1,80(sp)
            double f_val = va_arg(ap, double);
    31d4:	0c21                	addi	s8,s8,8
            for (int i = 0; f_buf[i] != '\0'; i++)
    31d6:	05110413          	addi	s0,sp,81
    31da:	e6058ce3          	beqz	a1,3052 <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, f_buf[i]);
    31de:	8526                	mv	a0,s1
    31e0:	fc1fd0ef          	jal	11a0 <_out_char>
            for (int i = 0; f_buf[i] != '\0'; i++)
    31e4:	00044583          	lbu	a1,0(s0)
    31e8:	0405                	addi	s0,s0,1
    31ea:	e60584e3          	beqz	a1,3052 <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, f_buf[i]);
    31ee:	8526                	mv	a0,s1
    31f0:	fb1fd0ef          	jal	11a0 <_out_char>
            for (int i = 0; f_buf[i] != '\0'; i++)
    31f4:	00044583          	lbu	a1,0(s0)
    31f8:	0405                	addi	s0,s0,1
    31fa:	f1f5                	bnez	a1,31de <_vprintf_core.constprop.0.isra.0+0x1ca>
    31fc:	bd99                	j	3052 <_vprintf_core.constprop.0.isra.0+0x3e>
            while (*p >= '0' && *p <= '9')
    31fe:	fd0c869b          	addiw	a3,s9,-48
    3202:	0ff6f313          	zext.b	t1,a3
    3206:	4725                	li	a4,9
        int width = 0;
    3208:	4401                	li	s0,0
            while (*p >= '0' && *p <= '9')
    320a:	4625                	li	a2,9
    320c:	e8676ae3          	bltu	a4,t1,30a0 <_vprintf_core.constprop.0.isra.0+0x8c>
    3210:	001dcc83          	lbu	s9,1(s11)
                width = width * 10 + (*p - '0');
    3214:	0024171b          	slliw	a4,s0,0x2
    3218:	9f21                	addw	a4,a4,s0
    321a:	0017171b          	slliw	a4,a4,0x1
    321e:	00e6843b          	addw	s0,a3,a4
            while (*p >= '0' && *p <= '9')
    3222:	fd0c869b          	addiw	a3,s9,-48
    3226:	0ff6f713          	zext.b	a4,a3
                p++;
    322a:	0d85                	addi	s11,s11,1
            while (*p >= '0' && *p <= '9')
    322c:	fee672e3          	bgeu	a2,a4,3210 <_vprintf_core.constprop.0.isra.0+0x1fc>
        if (*p == '.')
    3230:	02e00793          	li	a5,46
        int precision = -1;
    3234:	5bfd                	li	s7,-1
        if (*p == '.')
    3236:	e6fc9ae3          	bne	s9,a5,30aa <_vprintf_core.constprop.0.isra.0+0x96>
            if (*p == '*')
    323a:	001dcc83          	lbu	s9,1(s11)
    323e:	02a00793          	li	a5,42
    3242:	16fc9f63          	bne	s9,a5,33c0 <_vprintf_core.constprop.0.isra.0+0x3ac>
                while (*p >= '0' && *p <= '9')
    3246:	002dcc83          	lbu	s9,2(s11)
        if (*p == 'l')
    324a:	06c00693          	li	a3,108
                precision = va_arg(ap, int);
    324e:	000c2b83          	lw	s7,0(s8)
                p++;
    3252:	0d89                	addi	s11,s11,2
                precision = va_arg(ap, int);
    3254:	0c21                	addi	s8,s8,8
        if (*p == 'l')
    3256:	8666                	mv	a2,s9
    3258:	e4dc9ee3          	bne	s9,a3,30b4 <_vprintf_core.constprop.0.isra.0+0xa0>
            if (*p == 'l')
    325c:	001dcc83          	lbu	s9,1(s11)
    3260:	08cc8d63          	beq	s9,a2,32fa <_vprintf_core.constprop.0.isra.0+0x2e6>
        char spec = *p++;
    3264:	06400693          	li	a3,100
    3268:	0d89                	addi	s11,s11,2
        if (!spec)
    326a:	4cdc8c63          	beq	s9,a3,3742 <_vprintf_core.constprop.0.isra.0+0x72e>
    326e:	06400693          	li	a3,100
            len_mod = 1;
    3272:	4e85                	li	t4,1
    3274:	e596fee3          	bgeu	a3,s9,30d0 <_vprintf_core.constprop.0.isra.0+0xbc>
    3278:	f9bc869b          	addiw	a3,s9,-101
    327c:	0ff6f693          	zext.b	a3,a3
    3280:	464d                	li	a2,19
    3282:	12d66863          	bltu	a2,a3,33b2 <_vprintf_core.constprop.0.isra.0+0x39e>
    3286:	4e05                	li	t3,1
    3288:	00091637          	lui	a2,0x91
    328c:	00de1333          	sll	t1,t3,a3
    3290:	81060613          	addi	a2,a2,-2032 # 90810 <_ZSt4cerr+0x89018>
    3294:	00c37633          	and	a2,t1,a2
    3298:	1a061463          	bnez	a2,3440 <_vprintf_core.constprop.0.isra.0+0x42c>
    329c:	00737313          	andi	t1,t1,7
    32a0:	e80311e3          	bnez	t1,3122 <_vprintf_core.constprop.0.isra.0+0x10e>
    32a4:	4639                	li	a2,14
    32a6:	10c69663          	bne	a3,a2,33b2 <_vprintf_core.constprop.0.isra.0+0x39e>
            const char *s = va_arg(ap, char *);
    32aa:	000c3c83          	ld	s9,0(s8)
            if (!s)
    32ae:	420c8863          	beqz	s9,36de <_vprintf_core.constprop.0.isra.0+0x6ca>
            while (*tmp && (precision < 0 || len < precision))
    32b2:	000cc683          	lbu	a3,0(s9)
    32b6:	38068863          	beqz	a3,3646 <_vprintf_core.constprop.0.isra.0+0x632>
            const char *tmp = s;
    32ba:	8666                	mv	a2,s9
            int len = 0;
    32bc:	4681                	li	a3,0
            while (*tmp && (precision < 0 || len < precision))
    32be:	00db8863          	beq	s7,a3,32ce <_vprintf_core.constprop.0.isra.0+0x2ba>
    32c2:	00164583          	lbu	a1,1(a2)
                len++;
    32c6:	2685                	addiw	a3,a3,1
                tmp++;
    32c8:	0605                	addi	a2,a2,1
            while (*tmp && (precision < 0 || len < precision))
    32ca:	f9f5                	bnez	a1,32be <_vprintf_core.constprop.0.isra.0+0x2aa>
    32cc:	8bb6                	mv	s7,a3
            int padding = (width > len) ? width - len : 0;
    32ce:	268bc563          	blt	s7,s0,3538 <_vprintf_core.constprop.0.isra.0+0x524>
            for (int i = 0; i < len; i++)
    32d2:	4401                	li	s0,0
    32d4:	020b8163          	beqz	s7,32f6 <_vprintf_core.constprop.0.isra.0+0x2e2>
    32d8:	4d01                	li	s10,0
                _out_char(ctx, s[i]);
    32da:	01ac86b3          	add	a3,s9,s10
    32de:	0006c583          	lbu	a1,0(a3)
    32e2:	8526                	mv	a0,s1
            for (int i = 0; i < len; i++)
    32e4:	0d05                	addi	s10,s10,1
                _out_char(ctx, s[i]);
    32e6:	ebbfd0ef          	jal	11a0 <_out_char>
            for (int i = 0; i < len; i++)
    32ea:	000d069b          	sext.w	a3,s10
    32ee:	ff76c6e3          	blt	a3,s7,32da <_vprintf_core.constprop.0.isra.0+0x2c6>
            if (flag_left)
    32f2:	260a1463          	bnez	s4,355a <_vprintf_core.constprop.0.isra.0+0x546>
            const char *s = va_arg(ap, char *);
    32f6:	0c21                	addi	s8,s8,8
    32f8:	bba9                	j	3052 <_vprintf_core.constprop.0.isra.0+0x3e>
                p++;
    32fa:	0d89                	addi	s11,s11,2
        char spec = *p++;
    32fc:	000dcc83          	lbu	s9,0(s11)
    3300:	06400693          	li	a3,100
    3304:	001d8793          	addi	a5,s11,1
        if (!spec)
    3308:	3edc8063          	beq	s9,a3,36e8 <_vprintf_core.constprop.0.isra.0+0x6d4>
    330c:	0796ea63          	bltu	a3,s9,3380 <_vprintf_core.constprop.0.isra.0+0x36c>
    3310:	04700693          	li	a3,71
    3314:	0f96e263          	bltu	a3,s9,33f8 <_vprintf_core.constprop.0.isra.0+0x3e4>
    3318:	04400693          	li	a3,68
    331c:	e196e2e3          	bltu	a3,s9,3120 <_vprintf_core.constprop.0.isra.0+0x10c>
    3320:	dc0c82e3          	beqz	s9,30e4 <_vprintf_core.constprop.0.isra.0+0xd0>
        char spec = *p++;
    3324:	8dbe                	mv	s11,a5
            _out_char(ctx, '%');
    3326:	02500593          	li	a1,37
    332a:	8526                	mv	a0,s1
    332c:	e75fd0ef          	jal	11a0 <_out_char>
            if (spec != '%')
    3330:	02500713          	li	a4,37
    3334:	d0ec8fe3          	beq	s9,a4,3052 <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, spec);
    3338:	85e6                	mv	a1,s9
    333a:	bb09                	j	304c <_vprintf_core.constprop.0.isra.0+0x38>
    333c:	05800693          	li	a3,88
    3340:	2edc8263          	beq	s9,a3,3624 <_vprintf_core.constprop.0.isra.0+0x610>
    3344:	06300713          	li	a4,99
    3348:	06ec9563          	bne	s9,a4,33b2 <_vprintf_core.constprop.0.isra.0+0x39e>
            char c = (char)va_arg(ap, int);
    334c:	000c4c83          	lbu	s9,0(s8)
            int padding = (width > 1) ? width - 1 : 0;
    3350:	8722                	mv	a4,s0
    3352:	00804363          	bgtz	s0,3358 <_vprintf_core.constprop.0.isra.0+0x344>
    3356:	4705                	li	a4,1
    3358:	fff7041b          	addiw	s0,a4,-1
            if (!flag_left)
    335c:	3c0a0463          	beqz	s4,3724 <_vprintf_core.constprop.0.isra.0+0x710>
            _out_char(ctx, c);
    3360:	85e6                	mv	a1,s9
    3362:	8526                	mv	a0,s1
    3364:	e3dfd0ef          	jal	11a0 <_out_char>
                for (int i = 0; i < padding; i++)
    3368:	4a01                	li	s4,0
    336a:	d451                	beqz	s0,32f6 <_vprintf_core.constprop.0.isra.0+0x2e2>
                    _out_char(ctx, ' ');
    336c:	02000593          	li	a1,32
    3370:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    3372:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    3374:	e2dfd0ef          	jal	11a0 <_out_char>
                for (int i = 0; i < padding; i++)
    3378:	ff441ae3          	bne	s0,s4,336c <_vprintf_core.constprop.0.isra.0+0x358>
            const char *s = va_arg(ap, char *);
    337c:	0c21                	addi	s8,s8,8
    337e:	b9d1                	j	3052 <_vprintf_core.constprop.0.isra.0+0x3e>
    3380:	f9bc861b          	addiw	a2,s9,-101
    3384:	0ff67613          	zext.b	a2,a2
    3388:	46cd                	li	a3,19
    338a:	40c6e963          	bltu	a3,a2,379c <_vprintf_core.constprop.0.isra.0+0x788>
    338e:	00091337          	lui	t1,0x91
    3392:	4685                	li	a3,1
    3394:	00c696b3          	sll	a3,a3,a2
    3398:	81030313          	addi	t1,t1,-2032 # 90810 <_ZSt4cerr+0x89018>
    339c:	0066f333          	and	t1,a3,t1
    33a0:	34031c63          	bnez	t1,36f8 <_vprintf_core.constprop.0.isra.0+0x6e4>
    33a4:	8a9d                	andi	a3,a3,7
    33a6:	d6069de3          	bnez	a3,3120 <_vprintf_core.constprop.0.isra.0+0x10c>
    33aa:	46b9                	li	a3,14
        char spec = *p++;
    33ac:	8dbe                	mv	s11,a5
    33ae:	eed60ee3          	beq	a2,a3,32aa <_vprintf_core.constprop.0.isra.0+0x296>
            _out_char(ctx, '%');
    33b2:	02500593          	li	a1,37
    33b6:	8526                	mv	a0,s1
    33b8:	de9fd0ef          	jal	11a0 <_out_char>
                _out_char(ctx, spec);
    33bc:	85e6                	mv	a1,s9
    33be:	b179                	j	304c <_vprintf_core.constprop.0.isra.0+0x38>
                while (*p >= '0' && *p <= '9')
    33c0:	fd0c869b          	addiw	a3,s9,-48
    33c4:	0ff6fe13          	zext.b	t3,a3
    33c8:	4625                	li	a2,9
            p++;
    33ca:	0d85                	addi	s11,s11,1
                precision = 0;
    33cc:	4b81                	li	s7,0
                while (*p >= '0' && *p <= '9')
    33ce:	4325                	li	t1,9
    33d0:	cdc66de3          	bltu	a2,t3,30aa <_vprintf_core.constprop.0.isra.0+0x96>
                    precision = precision * 10 + (*p - '0');
    33d4:	002b961b          	slliw	a2,s7,0x2
                while (*p >= '0' && *p <= '9')
    33d8:	001dcc83          	lbu	s9,1(s11)
                    precision = precision * 10 + (*p - '0');
    33dc:	0176073b          	addw	a4,a2,s7
    33e0:	0017171b          	slliw	a4,a4,0x1
    33e4:	00e68bbb          	addw	s7,a3,a4
                while (*p >= '0' && *p <= '9')
    33e8:	fd0c869b          	addiw	a3,s9,-48
    33ec:	0ff6f613          	zext.b	a2,a3
                    p++;
    33f0:	0d85                	addi	s11,s11,1
                while (*p >= '0' && *p <= '9')
    33f2:	fec371e3          	bgeu	t1,a2,33d4 <_vprintf_core.constprop.0.isra.0+0x3c0>
    33f6:	b955                	j	30aa <_vprintf_core.constprop.0.isra.0+0x96>
    33f8:	05800693          	li	a3,88
    33fc:	3cdc8d63          	beq	s9,a3,37d6 <_vprintf_core.constprop.0.isra.0+0x7c2>
    3400:	06300713          	li	a4,99
        char spec = *p++;
    3404:	8dbe                	mv	s11,a5
    3406:	f4ec83e3          	beq	s9,a4,334c <_vprintf_core.constprop.0.isra.0+0x338>
    340a:	b765                	j	33b2 <_vprintf_core.constprop.0.isra.0+0x39e>
                f_idx += sprintf(&fmt_tmp[f_idx], ".%d", precision);
    340c:	01aa0533          	add	a0,s4,s10
    3410:	865e                	mv	a2,s7
    3412:	00002597          	auipc	a1,0x2
    3416:	c8e58593          	addi	a1,a1,-882 # 50a0 <_GLOBAL__sub_I__ZSt3cin+0xf8>
    341a:	ba5ff0ef          	jal	2fbe <sprintf>
    341e:	00ad0d3b          	addw	s10,s10,a0
    3422:	b341                	j	31a2 <_vprintf_core.constprop.0.isra.0+0x18e>
                f_idx += sprintf(&fmt_tmp[f_idx], "%d", width);
    3424:	01aa0533          	add	a0,s4,s10
    3428:	8622                	mv	a2,s0
    342a:	00002597          	auipc	a1,0x2
    342e:	c6e58593          	addi	a1,a1,-914 # 5098 <_GLOBAL__sub_I__ZSt3cin+0xf0>
    3432:	b8dff0ef          	jal	2fbe <sprintf>
    3436:	00ad0d3b          	addw	s10,s10,a0
            if (precision >= 0)
    343a:	d60bc4e3          	bltz	s7,31a2 <_vprintf_core.constprop.0.isra.0+0x18e>
    343e:	b7f9                	j	340c <_vprintf_core.constprop.0.isra.0+0x3f8>
            int is_signed = (spec == 'd' || spec == 'i');
    3440:	06900693          	li	a3,105
    3444:	10dc8e63          	beq	s9,a3,3560 <_vprintf_core.constprop.0.isra.0+0x54c>
                val = (uint64)va_arg(ap, void *);
    3448:	008c0793          	addi	a5,s8,8
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    344c:	07800693          	li	a3,120
                val = (uint64)va_arg(ap, void *);
    3450:	e43e                	sd	a5,8(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3452:	38dc9d63          	bne	s9,a3,37ec <_vprintf_core.constprop.0.isra.0+0x7d8>
            else if (len_mod == 1)
    3456:	33ce8963          	beq	t4,t3,3788 <_vprintf_core.constprop.0.isra.0+0x774>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    345a:	000c6e03          	lwu	t3,0(s8)
    345e:	85f6                	mv	a1,t4
    3460:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3462:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    3464:	00002f97          	auipc	t6,0x2
    3468:	c04f8f93          	addi	t6,t6,-1020 # 5068 <_GLOBAL__sub_I__ZSt3cin+0xc0>
    if (val == 0)
    346c:	120e0363          	beqz	t3,3592 <_vprintf_core.constprop.0.isra.0+0x57e>
    3470:	01010293          	addi	t0,sp,16
                    sign_char = '-';
    3474:	8616                	mv	a2,t0
    3476:	86f2                	mv	a3,t3
        buf[i++] = digits[val % base];
    3478:	0266f8b3          	remu	a7,a3,t1
    347c:	8f32                	mv	t5,a2
    while (val != 0)
    347e:	0605                	addi	a2,a2,1
    3480:	8eb6                	mv	t4,a3
        buf[i++] = digits[val % base];
    3482:	98fe                	add	a7,a7,t6
    3484:	0008c883          	lbu	a7,0(a7)
        val /= base;
    3488:	0266d6b3          	divu	a3,a3,t1
        buf[i++] = digits[val % base];
    348c:	ff160fa3          	sb	a7,-1(a2)
    while (val != 0)
    3490:	fe6ef4e3          	bgeu	t4,t1,3478 <_vprintf_core.constprop.0.isra.0+0x464>
        buf[i++] = digits[val % base];
    3494:	405f0f3b          	subw	t5,t5,t0
    3498:	2f05                	addiw	t5,t5,1
            if (precision >= 0)
    349a:	100bc363          	bltz	s7,35a0 <_vprintf_core.constprop.0.isra.0+0x58c>
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    349e:	1d7f4d63          	blt	t5,s7,3678 <_vprintf_core.constprop.0.isra.0+0x664>
            if (precision == 0 && val == 0)
    34a2:	340b9163          	bnez	s7,37e4 <_vprintf_core.constprop.0.isra.0+0x7d0>
    34a6:	200e0763          	beqz	t3,36b4 <_vprintf_core.constprop.0.isra.0+0x6a0>
            for (int i = digit_len - 1; i >= 0; i--)
    34aa:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    34ae:	07000693          	li	a3,112
            for (int i = digit_len - 1; i >= 0; i--)
    34b2:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    34b4:	28dc8e63          	beq	s9,a3,3750 <_vprintf_core.constprop.0.isra.0+0x73c>
    34b8:	2a051663          	bnez	a0,3764 <_vprintf_core.constprop.0.isra.0+0x750>
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    34bc:	00bf05bb          	addw	a1,t5,a1
    34c0:	8d52                	mv	s10,s4
    34c2:	4b01                	li	s6,0
            char *prefix_str = NULL;
    34c4:	4c81                	li	s9,0
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    34c6:	1085d263          	bge	a1,s0,35ca <_vprintf_core.constprop.0.isra.0+0x5b6>
    34ca:	9c0d                	subw	s0,s0,a1
            if (!flag_left && !flag_zero)
    34cc:	100d0a63          	beqz	s10,35e0 <_vprintf_core.constprop.0.isra.0+0x5cc>
            if (sign_char)
    34d0:	6782                	ld	a5,0(sp)
    34d2:	10079263          	bnez	a5,35d6 <_vprintf_core.constprop.0.isra.0+0x5c2>
            if (prefix_str)
    34d6:	000c8c63          	beqz	s9,34ee <_vprintf_core.constprop.0.isra.0+0x4da>
                _out_char(ctx, prefix_str[0]);
    34da:	000cc583          	lbu	a1,0(s9)
    34de:	8526                	mv	a0,s1
    34e0:	cc1fd0ef          	jal	11a0 <_out_char>
                _out_char(ctx, prefix_str[1]);
    34e4:	001cc583          	lbu	a1,1(s9)
    34e8:	8526                	mv	a0,s1
    34ea:	cb7fd0ef          	jal	11a0 <_out_char>
            int total_zeros = prec_zeros + ((flag_zero && !flag_left) ? padding : 0);
    34ee:	180b0263          	beqz	s6,3672 <_vprintf_core.constprop.0.isra.0+0x65e>
    34f2:	100a1863          	bnez	s4,3602 <_vprintf_core.constprop.0.isra.0+0x5ee>
    34f6:	008b8bbb          	addw	s7,s7,s0
            for (int i = 0; i < total_zeros; i++)
    34fa:	2a0b8363          	beqz	s7,37a0 <_vprintf_core.constprop.0.isra.0+0x78c>
    34fe:	4c81                	li	s9,0
                _out_char(ctx, '0');
    3500:	03000593          	li	a1,48
    3504:	8526                	mv	a0,s1
            for (int i = 0; i < total_zeros; i++)
    3506:	2c85                	addiw	s9,s9,1
                _out_char(ctx, '0');
    3508:	c99fd0ef          	jal	11a0 <_out_char>
            for (int i = 0; i < total_zeros; i++)
    350c:	ff7c9ae3          	bne	s9,s7,3500 <_vprintf_core.constprop.0.isra.0+0x4ec>
            for (int i = digit_len - 1; i >= 0; i--)
    3510:	57fd                	li	a5,-1
    3512:	00fc0f63          	beq	s8,a5,3530 <_vprintf_core.constprop.0.isra.0+0x51c>
    3516:	01010c93          	addi	s9,sp,16
    351a:	9ce2                	add	s9,s9,s8
    351c:	00f10c13          	addi	s8,sp,15
                _out_char(ctx, num_buf[i]);
    3520:	000cc583          	lbu	a1,0(s9)
    3524:	8526                	mv	a0,s1
            for (int i = digit_len - 1; i >= 0; i--)
    3526:	1cfd                	addi	s9,s9,-1
                _out_char(ctx, num_buf[i]);
    3528:	c79fd0ef          	jal	11a0 <_out_char>
            for (int i = digit_len - 1; i >= 0; i--)
    352c:	ff9c1ae3          	bne	s8,s9,3520 <_vprintf_core.constprop.0.isra.0+0x50c>
            if (flag_left)
    3530:	0c0a1e63          	bnez	s4,360c <_vprintf_core.constprop.0.isra.0+0x5f8>
        char spec = *p++;
    3534:	6c22                	ld	s8,8(sp)
    3536:	be31                	j	3052 <_vprintf_core.constprop.0.isra.0+0x3e>
            int padding = (width > len) ? width - len : 0;
    3538:	4174043b          	subw	s0,s0,s7
            if (!flag_left)
    353c:	100a0a63          	beqz	s4,3650 <_vprintf_core.constprop.0.isra.0+0x63c>
            for (int i = 0; i < len; i++)
    3540:	d80b9ce3          	bnez	s7,32d8 <_vprintf_core.constprop.0.isra.0+0x2c4>
                for (int i = 0; i < padding; i++)
    3544:	4a01                	li	s4,0
                    _out_char(ctx, ' ');
    3546:	02000593          	li	a1,32
    354a:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    354c:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    354e:	c53fd0ef          	jal	11a0 <_out_char>
                for (int i = 0; i < padding; i++)
    3552:	ff441ae3          	bne	s0,s4,3546 <_vprintf_core.constprop.0.isra.0+0x532>
            const char *s = va_arg(ap, char *);
    3556:	0c21                	addi	s8,s8,8
    3558:	bced                	j	3052 <_vprintf_core.constprop.0.isra.0+0x3e>
                for (int i = 0; i < padding; i++)
    355a:	f46d                	bnez	s0,3544 <_vprintf_core.constprop.0.isra.0+0x530>
            const char *s = va_arg(ap, char *);
    355c:	0c21                	addi	s8,s8,8
    355e:	bcd5                	j	3052 <_vprintf_core.constprop.0.isra.0+0x3e>
            else if (len_mod == 1)
    3560:	1fce8163          	beq	t4,t3,3742 <_vprintf_core.constprop.0.isra.0+0x72e>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    3564:	000c2e03          	lw	t3,0(s8)
    3568:	008c0793          	addi	a5,s8,8
    356c:	e43e                	sd	a5,8(sp)
                int64 sval = (int64)val;
    356e:	86f2                	mv	a3,t3
                if (sval < 0)
    3570:	1406cb63          	bltz	a3,36c6 <_vprintf_core.constprop.0.isra.0+0x6b2>
                    sign_char = '+';
    3574:	02b00793          	li	a5,43
    3578:	e03e                	sd	a5,0(sp)
                else if (flag_plus)
    357a:	e589                	bnez	a1,3584 <_vprintf_core.constprop.0.isra.0+0x570>
                else if (flag_space)
    357c:	00589793          	slli	a5,a7,0x5
    3580:	e03e                	sd	a5,0(sp)
    3582:	85c6                	mv	a1,a7
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    3584:	4329                	li	t1,10
    3586:	00002f97          	auipc	t6,0x2
    358a:	ae2f8f93          	addi	t6,t6,-1310 # 5068 <_GLOBAL__sub_I__ZSt3cin+0xc0>
    if (val == 0)
    358e:	ee0e11e3          	bnez	t3,3470 <_vprintf_core.constprop.0.isra.0+0x45c>
        buf[i++] = '0';
    3592:	03000693          	li	a3,48
    3596:	00d10823          	sb	a3,16(sp)
        return i;
    359a:	4f05                	li	t5,1
            if (precision >= 0)
    359c:	f00bd1e3          	bgez	s7,349e <_vprintf_core.constprop.0.isra.0+0x48a>
            for (int i = digit_len - 1; i >= 0; i--)
    35a0:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    35a4:	07000893          	li	a7,112
            if (!flag_left && !flag_zero)
    35a8:	016a6d33          	or	s10,s4,s6
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    35ac:	4b81                	li	s7,0
            for (int i = digit_len - 1; i >= 0; i--)
    35ae:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    35b0:	0d1c9f63          	bne	s9,a7,368e <_vprintf_core.constprop.0.isra.0+0x67a>
                prefix_str = (spec == 'X') ? "0X" : "0x";
    35b4:	00002c97          	auipc	s9,0x2
    35b8:	accc8c93          	addi	s9,s9,-1332 # 5080 <_GLOBAL__sub_I__ZSt3cin+0xd8>
                prefix_len += 2;
    35bc:	2589                	addiw	a1,a1,2
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    35be:	017585bb          	addw	a1,a1,s7
    35c2:	01e585bb          	addw	a1,a1,t5
    35c6:	f085c2e3          	blt	a1,s0,34ca <_vprintf_core.constprop.0.isra.0+0x4b6>
            if (!flag_left && !flag_zero)
    35ca:	080d0f63          	beqz	s10,3668 <_vprintf_core.constprop.0.isra.0+0x654>
            if (sign_char)
    35ce:	6782                	ld	a5,0(sp)
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    35d0:	4401                	li	s0,0
            if (sign_char)
    35d2:	f00782e3          	beqz	a5,34d6 <_vprintf_core.constprop.0.isra.0+0x4c2>
                _out_char(ctx, sign_char);
    35d6:	6582                	ld	a1,0(sp)
    35d8:	8526                	mv	a0,s1
    35da:	bc7fd0ef          	jal	11a0 <_out_char>
    35de:	bde5                	j	34d6 <_vprintf_core.constprop.0.isra.0+0x4c2>
                    _out_char(ctx, ' ');
    35e0:	02000593          	li	a1,32
    35e4:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    35e6:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    35e8:	bb9fd0ef          	jal	11a0 <_out_char>
                for (int i = 0; i < padding; i++)
    35ec:	efa402e3          	beq	s0,s10,34d0 <_vprintf_core.constprop.0.isra.0+0x4bc>
                    _out_char(ctx, ' ');
    35f0:	02000593          	li	a1,32
    35f4:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    35f6:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    35f8:	ba9fd0ef          	jal	11a0 <_out_char>
                for (int i = 0; i < padding; i++)
    35fc:	ffa412e3          	bne	s0,s10,35e0 <_vprintf_core.constprop.0.isra.0+0x5cc>
    3600:	bdc1                	j	34d0 <_vprintf_core.constprop.0.isra.0+0x4bc>
            for (int i = 0; i < total_zeros; i++)
    3602:	ee0b9ee3          	bnez	s7,34fe <_vprintf_core.constprop.0.isra.0+0x4ea>
            for (int i = digit_len - 1; i >= 0; i--)
    3606:	577d                	li	a4,-1
    3608:	f0ec17e3          	bne	s8,a4,3516 <_vprintf_core.constprop.0.isra.0+0x502>
                for (int i = 0; i < padding; i++)
    360c:	d405                	beqz	s0,3534 <_vprintf_core.constprop.0.isra.0+0x520>
    360e:	4a01                	li	s4,0
                    _out_char(ctx, ' ');
    3610:	02000593          	li	a1,32
    3614:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    3616:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    3618:	b89fd0ef          	jal	11a0 <_out_char>
                for (int i = 0; i < padding; i++)
    361c:	fe8a1ae3          	bne	s4,s0,3610 <_vprintf_core.constprop.0.isra.0+0x5fc>
        char spec = *p++;
    3620:	6c22                	ld	s8,8(sp)
    3622:	bc05                	j	3052 <_vprintf_core.constprop.0.isra.0+0x3e>
                val = (uint64)va_arg(ap, void *);
    3624:	008c0793          	addi	a5,s8,8
    3628:	e43e                	sd	a5,8(sp)
            else if (len_mod == 1)
    362a:	180e9163          	bnez	t4,37ac <_vprintf_core.constprop.0.isra.0+0x798>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    362e:	000c6e03          	lwu	t3,0(s8)
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    3632:	4581                	li	a1,0
    3634:	05800c93          	li	s9,88
    3638:	e002                	sd	zero,0(sp)
    363a:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    363c:	00002f97          	auipc	t6,0x2
    3640:	a14f8f93          	addi	t6,t6,-1516 # 5050 <_GLOBAL__sub_I__ZSt3cin+0xa8>
    3644:	b525                	j	346c <_vprintf_core.constprop.0.isra.0+0x458>
            int padding = (width > len) ? width - len : 0;
    3646:	ca8058e3          	blez	s0,32f6 <_vprintf_core.constprop.0.isra.0+0x2e2>
            if (!flag_left)
    364a:	ee0a1de3          	bnez	s4,3544 <_vprintf_core.constprop.0.isra.0+0x530>
            int len = 0;
    364e:	4b81                	li	s7,0
                for (int i = 0; i < padding; i++)
    3650:	4d01                	li	s10,0
                    _out_char(ctx, ' ');
    3652:	02000593          	li	a1,32
    3656:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    3658:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    365a:	b47fd0ef          	jal	11a0 <_out_char>
                for (int i = 0; i < padding; i++)
    365e:	fe8d1ae3          	bne	s10,s0,3652 <_vprintf_core.constprop.0.isra.0+0x63e>
            for (int i = 0; i < len; i++)
    3662:	c60b9be3          	bnez	s7,32d8 <_vprintf_core.constprop.0.isra.0+0x2c4>
    3666:	b941                	j	32f6 <_vprintf_core.constprop.0.isra.0+0x2e2>
            if (sign_char)
    3668:	6782                	ld	a5,0(sp)
    366a:	4401                	li	s0,0
    366c:	f7ad                	bnez	a5,35d6 <_vprintf_core.constprop.0.isra.0+0x5c2>
            if (prefix_str)
    366e:	e60c96e3          	bnez	s9,34da <_vprintf_core.constprop.0.isra.0+0x4c6>
            for (int i = 0; i < total_zeros; i++)
    3672:	e80b96e3          	bnez	s7,34fe <_vprintf_core.constprop.0.isra.0+0x4ea>
    3676:	bd69                	j	3510 <_vprintf_core.constprop.0.isra.0+0x4fc>
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    3678:	41eb8bbb          	subw	s7,s7,t5
    367c:	8d52                	mv	s10,s4
    367e:	4b01                	li	s6,0
            for (int i = digit_len - 1; i >= 0; i--)
    3680:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    3684:	07000893          	li	a7,112
            for (int i = digit_len - 1; i >= 0; i--)
    3688:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    368a:	f31c85e3          	beq	s9,a7,35b4 <_vprintf_core.constprop.0.isra.0+0x5a0>
    368e:	cd09                	beqz	a0,36a8 <_vprintf_core.constprop.0.isra.0+0x694>
    3690:	000e0c63          	beqz	t3,36a8 <_vprintf_core.constprop.0.isra.0+0x694>
    3694:	07800513          	li	a0,120
            for (int i = digit_len - 1; i >= 0; i--)
    3698:	00060c1b          	sext.w	s8,a2
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    369c:	f0ac8ce3          	beq	s9,a0,35b4 <_vprintf_core.constprop.0.isra.0+0x5a0>
    36a0:	05800613          	li	a2,88
    36a4:	12cc8463          	beq	s9,a2,37cc <_vprintf_core.constprop.0.isra.0+0x7b8>
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    36a8:	00bb85bb          	addw	a1,s7,a1
    36ac:	01e585bb          	addw	a1,a1,t5
            char *prefix_str = NULL;
    36b0:	4c81                	li	s9,0
    36b2:	bd11                	j	34c6 <_vprintf_core.constprop.0.isra.0+0x4b2>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    36b4:	07000693          	li	a3,112
    36b8:	8d52                	mv	s10,s4
    36ba:	4b01                	li	s6,0
    36bc:	08dc8d63          	beq	s9,a3,3756 <_vprintf_core.constprop.0.isra.0+0x742>
    36c0:	5c7d                	li	s8,-1
            char *prefix_str = NULL;
    36c2:	4c81                	li	s9,0
    36c4:	b509                	j	34c6 <_vprintf_core.constprop.0.isra.0+0x4b2>
                    sign_char = '-';
    36c6:	02d00793          	li	a5,45
                    val = (uint64)(-sval);
    36ca:	40d00e33          	neg	t3,a3
    36ce:	4585                	li	a1,1
    36d0:	4329                	li	t1,10
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    36d2:	00002f97          	auipc	t6,0x2
    36d6:	996f8f93          	addi	t6,t6,-1642 # 5068 <_GLOBAL__sub_I__ZSt3cin+0xc0>
                    sign_char = '-';
    36da:	e03e                	sd	a5,0(sp)
    36dc:	bb51                	j	3470 <_vprintf_core.constprop.0.isra.0+0x45c>
                s = "(null)";
    36de:	00002c97          	auipc	s9,0x2
    36e2:	9b2c8c93          	addi	s9,s9,-1614 # 5090 <_GLOBAL__sub_I__ZSt3cin+0xe8>
    36e6:	bed1                	j	32ba <_vprintf_core.constprop.0.isra.0+0x2a6>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    36e8:	000c3683          	ld	a3,0(s8)
    36ec:	008c0713          	addi	a4,s8,8
    36f0:	e43a                	sd	a4,8(sp)
    36f2:	8dbe                	mv	s11,a5
    36f4:	8e36                	mv	t3,a3
            if (is_signed)
    36f6:	bdad                	j	3570 <_vprintf_core.constprop.0.isra.0+0x55c>
            int is_signed = (spec == 'd' || spec == 'i');
    36f8:	06900693          	li	a3,105
    36fc:	fedc86e3          	beq	s9,a3,36e8 <_vprintf_core.constprop.0.isra.0+0x6d4>
                val = (uint64)va_arg(ap, void *);
    3700:	008c0713          	addi	a4,s8,8
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3704:	07800693          	li	a3,120
                val = (uint64)va_arg(ap, void *);
    3708:	e43a                	sd	a4,8(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    370a:	06dc9063          	bne	s9,a3,376a <_vprintf_core.constprop.0.isra.0+0x756>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    370e:	000c3e03          	ld	t3,0(s8)
    3712:	8dbe                	mv	s11,a5
    3714:	4581                	li	a1,0
    3716:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3718:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    371a:	00002f97          	auipc	t6,0x2
    371e:	94ef8f93          	addi	t6,t6,-1714 # 5068 <_GLOBAL__sub_I__ZSt3cin+0xc0>
    3722:	b3a9                	j	346c <_vprintf_core.constprop.0.isra.0+0x458>
                for (int i = 0; i < padding; i++)
    3724:	c809                	beqz	s0,3736 <_vprintf_core.constprop.0.isra.0+0x722>
                    _out_char(ctx, ' ');
    3726:	02000593          	li	a1,32
    372a:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    372c:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    372e:	a73fd0ef          	jal	11a0 <_out_char>
                for (int i = 0; i < padding; i++)
    3732:	ff441ae3          	bne	s0,s4,3726 <_vprintf_core.constprop.0.isra.0+0x712>
            _out_char(ctx, c);
    3736:	85e6                	mv	a1,s9
    3738:	8526                	mv	a0,s1
    373a:	a67fd0ef          	jal	11a0 <_out_char>
            const char *s = va_arg(ap, char *);
    373e:	0c21                	addi	s8,s8,8
    3740:	ba09                	j	3052 <_vprintf_core.constprop.0.isra.0+0x3e>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    3742:	000c3683          	ld	a3,0(s8)
    3746:	008c0793          	addi	a5,s8,8
    374a:	e43e                	sd	a5,8(sp)
    374c:	8e36                	mv	t3,a3
            if (is_signed)
    374e:	b50d                	j	3570 <_vprintf_core.constprop.0.isra.0+0x55c>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    3750:	8d52                	mv	s10,s4
    3752:	4b01                	li	s6,0
    3754:	b585                	j	35b4 <_vprintf_core.constprop.0.isra.0+0x5a0>
                digit_len = 0;
    3756:	4f01                	li	t5,0
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    3758:	5c7d                	li	s8,-1
                prefix_str = (spec == 'X') ? "0X" : "0x";
    375a:	00002c97          	auipc	s9,0x2
    375e:	926c8c93          	addi	s9,s9,-1754 # 5080 <_GLOBAL__sub_I__ZSt3cin+0xd8>
    3762:	bda9                	j	35bc <_vprintf_core.constprop.0.isra.0+0x5a8>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    3764:	8d52                	mv	s10,s4
    3766:	4b01                	li	s6,0
    3768:	b735                	j	3694 <_vprintf_core.constprop.0.isra.0+0x680>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    376a:	07000693          	li	a3,112
    376e:	04dc8263          	beq	s9,a3,37b2 <_vprintf_core.constprop.0.isra.0+0x79e>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    3772:	000c3e03          	ld	t3,0(s8)
    3776:	8dbe                	mv	s11,a5
    3778:	4581                	li	a1,0
    377a:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    377c:	4329                	li	t1,10
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    377e:	00002f97          	auipc	t6,0x2
    3782:	8eaf8f93          	addi	t6,t6,-1814 # 5068 <_GLOBAL__sub_I__ZSt3cin+0xc0>
    3786:	b1dd                	j	346c <_vprintf_core.constprop.0.isra.0+0x458>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    3788:	000c3e03          	ld	t3,0(s8)
    378c:	4581                	li	a1,0
    378e:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3790:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    3792:	00002f97          	auipc	t6,0x2
    3796:	8d6f8f93          	addi	t6,t6,-1834 # 5068 <_GLOBAL__sub_I__ZSt3cin+0xc0>
    379a:	b9c9                	j	346c <_vprintf_core.constprop.0.isra.0+0x458>
        char spec = *p++;
    379c:	8dbe                	mv	s11,a5
    379e:	b911                	j	33b2 <_vprintf_core.constprop.0.isra.0+0x39e>
            for (int i = digit_len - 1; i >= 0; i--)
    37a0:	577d                	li	a4,-1
    37a2:	4401                	li	s0,0
    37a4:	d6ec19e3          	bne	s8,a4,3516 <_vprintf_core.constprop.0.isra.0+0x502>
        char spec = *p++;
    37a8:	6c22                	ld	s8,8(sp)
    37aa:	b065                	j	3052 <_vprintf_core.constprop.0.isra.0+0x3e>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    37ac:	000c3e03          	ld	t3,0(s8)
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    37b0:	b549                	j	3632 <_vprintf_core.constprop.0.isra.0+0x61e>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    37b2:	8dbe                	mv	s11,a5
                val = (uint64)va_arg(ap, void *);
    37b4:	000c3e03          	ld	t3,0(s8)
    37b8:	4581                	li	a1,0
    37ba:	07000c93          	li	s9,112
    37be:	e002                	sd	zero,0(sp)
    37c0:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    37c2:	00002f97          	auipc	t6,0x2
    37c6:	8a6f8f93          	addi	t6,t6,-1882 # 5068 <_GLOBAL__sub_I__ZSt3cin+0xc0>
    37ca:	b14d                	j	346c <_vprintf_core.constprop.0.isra.0+0x458>
                prefix_str = (spec == 'X') ? "0X" : "0x";
    37cc:	00002c97          	auipc	s9,0x2
    37d0:	8bcc8c93          	addi	s9,s9,-1860 # 5088 <_GLOBAL__sub_I__ZSt3cin+0xe0>
    37d4:	b3e5                	j	35bc <_vprintf_core.constprop.0.isra.0+0x5a8>
                val = (uint64)va_arg(ap, void *);
    37d6:	008c0713          	addi	a4,s8,8
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    37da:	000c3e03          	ld	t3,0(s8)
                val = (uint64)va_arg(ap, void *);
    37de:	e43a                	sd	a4,8(sp)
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    37e0:	8dbe                	mv	s11,a5
    37e2:	bd81                	j	3632 <_vprintf_core.constprop.0.isra.0+0x61e>
    37e4:	8d52                	mv	s10,s4
    37e6:	4b01                	li	s6,0
    37e8:	4b81                	li	s7,0
    37ea:	bd59                	j	3680 <_vprintf_core.constprop.0.isra.0+0x66c>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    37ec:	07000693          	li	a3,112
    37f0:	fcdc82e3          	beq	s9,a3,37b4 <_vprintf_core.constprop.0.isra.0+0x7a0>
            else if (len_mod == 1)
    37f4:	01ce8c63          	beq	t4,t3,380c <_vprintf_core.constprop.0.isra.0+0x7f8>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    37f8:	000c6e03          	lwu	t3,0(s8)
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    37fc:	4581                	li	a1,0
    37fe:	e002                	sd	zero,0(sp)
    3800:	4329                	li	t1,10
    3802:	00002f97          	auipc	t6,0x2
    3806:	866f8f93          	addi	t6,t6,-1946 # 5068 <_GLOBAL__sub_I__ZSt3cin+0xc0>
    380a:	b18d                	j	346c <_vprintf_core.constprop.0.isra.0+0x458>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    380c:	000c3e03          	ld	t3,0(s8)
            if (is_signed)
    3810:	b7f5                	j	37fc <_vprintf_core.constprop.0.isra.0+0x7e8>

0000000000003812 <vsnprintf>:
{
    3812:	7139                	addi	sp,sp,-64
    3814:	f822                	sd	s0,48(sp)
    3816:	f426                	sd	s1,40(sp)
    3818:	842e                	mv	s0,a1
    381a:	84aa                	mv	s1,a0
    381c:	85b2                	mv	a1,a2
    _vprintf_core(&ctx, format, ap);
    381e:	850a                	mv	a0,sp
    3820:	8636                	mv	a2,a3
{
    3822:	fc06                	sd	ra,56(sp)
    ctx.buf = str;
    3824:	e026                	sd	s1,0(sp)
    ctx.limit = size;
    3826:	e422                	sd	s0,8(sp)
    ctx.written = 0;
    3828:	e802                	sd	zero,16(sp)
    ctx.stream = NULL;
    382a:	ec02                	sd	zero,24(sp)
    _vprintf_core(&ctx, format, ap);
    382c:	fe8ff0ef          	jal	3014 <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    3830:	6542                	ld	a0,16(sp)
    if (size > 0)
    3832:	c411                	beqz	s0,383e <vsnprintf+0x2c>
        if (ctx.written < size)
    3834:	00857b63          	bgeu	a0,s0,384a <vsnprintf+0x38>
            str[ctx.written] = '\0';
    3838:	94aa                	add	s1,s1,a0
    383a:	00048023          	sb	zero,0(s1)
}
    383e:	70e2                	ld	ra,56(sp)
    3840:	7442                	ld	s0,48(sp)
    3842:	74a2                	ld	s1,40(sp)
    3844:	2501                	sext.w	a0,a0
    3846:	6121                	addi	sp,sp,64
    3848:	8082                	ret
            str[size - 1] = '\0';
    384a:	94a2                	add	s1,s1,s0
    384c:	fe048fa3          	sb	zero,-1(s1)
}
    3850:	70e2                	ld	ra,56(sp)
    3852:	7442                	ld	s0,48(sp)
    3854:	74a2                	ld	s1,40(sp)
    3856:	2501                	sext.w	a0,a0
    3858:	6121                	addi	sp,sp,64
    385a:	8082                	ret

000000000000385c <snprintf>:
{
    385c:	7119                	addi	sp,sp,-128
    385e:	e0a2                	sd	s0,64(sp)
    3860:	fc26                	sd	s1,56(sp)
    3862:	842e                	mv	s0,a1
    3864:	84aa                	mv	s1,a0
    3866:	85b2                	mv	a1,a2
    _vprintf_core(&ctx, format, ap);
    3868:	0808                	addi	a0,sp,16
    va_start(ap, format);
    386a:	08b0                	addi	a2,sp,88
{
    386c:	e486                	sd	ra,72(sp)
    386e:	ecb6                	sd	a3,88(sp)
    3870:	f0ba                	sd	a4,96(sp)
    3872:	f4be                	sd	a5,104(sp)
    3874:	f8c2                	sd	a6,112(sp)
    3876:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    3878:	e432                	sd	a2,8(sp)
    ctx.buf = str;
    387a:	e826                	sd	s1,16(sp)
    ctx.limit = size;
    387c:	ec22                	sd	s0,24(sp)
    ctx.written = 0;
    387e:	f002                	sd	zero,32(sp)
    ctx.stream = NULL;
    3880:	f402                	sd	zero,40(sp)
    _vprintf_core(&ctx, format, ap);
    3882:	f92ff0ef          	jal	3014 <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    3886:	7502                	ld	a0,32(sp)
    if (size > 0)
    3888:	c411                	beqz	s0,3894 <snprintf+0x38>
        if (ctx.written < size)
    388a:	00857b63          	bgeu	a0,s0,38a0 <snprintf+0x44>
            str[ctx.written] = '\0';
    388e:	94aa                	add	s1,s1,a0
    3890:	00048023          	sb	zero,0(s1)
}
    3894:	60a6                	ld	ra,72(sp)
    3896:	6406                	ld	s0,64(sp)
    3898:	74e2                	ld	s1,56(sp)
    389a:	2501                	sext.w	a0,a0
    389c:	6109                	addi	sp,sp,128
    389e:	8082                	ret
            str[size - 1] = '\0';
    38a0:	94a2                	add	s1,s1,s0
    38a2:	fe048fa3          	sb	zero,-1(s1)
}
    38a6:	60a6                	ld	ra,72(sp)
    38a8:	6406                	ld	s0,64(sp)
    38aa:	74e2                	ld	s1,56(sp)
    38ac:	2501                	sext.w	a0,a0
    38ae:	6109                	addi	sp,sp,128
    38b0:	8082                	ret

00000000000038b2 <printf>:
{
    38b2:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    38b4:	04810313          	addi	t1,sp,72
{
    38b8:	e4ae                	sd	a1,72(sp)
    38ba:	e8b2                	sd	a2,80(sp)
    38bc:	f4be                	sd	a5,104(sp)
    _vprintf_core(&ctx, format, ap);
    38be:	85aa                	mv	a1,a0
    ctx.stream = stdout;
    38c0:	00004797          	auipc	a5,0x4
    38c4:	da07b783          	ld	a5,-608(a5) # 7660 <stdout>
    _vprintf_core(&ctx, format, ap);
    38c8:	0808                	addi	a0,sp,16
    38ca:	861a                	mv	a2,t1
{
    38cc:	fc06                	sd	ra,56(sp)
    38ce:	ecb6                	sd	a3,88(sp)
    38d0:	f0ba                	sd	a4,96(sp)
    38d2:	f8c2                	sd	a6,112(sp)
    38d4:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    38d6:	e41a                	sd	t1,8(sp)
    ctx.buf = NULL;
    38d8:	e802                	sd	zero,16(sp)
    ctx.limit = 0;
    38da:	ec02                	sd	zero,24(sp)
    ctx.written = 0;
    38dc:	f002                	sd	zero,32(sp)
    ctx.stream = stdout;
    38de:	f43e                	sd	a5,40(sp)
    _vprintf_core(&ctx, format, ap);
    38e0:	f34ff0ef          	jal	3014 <_vprintf_core.constprop.0.isra.0>
}
    38e4:	70e2                	ld	ra,56(sp)
    38e6:	5502                	lw	a0,32(sp)
    38e8:	6109                	addi	sp,sp,128
    38ea:	8082                	ret

00000000000038ec <sscanf>:
{
    38ec:	7159                	addi	sp,sp,-112
    va_start(ap, format);
    38ee:	04010e13          	addi	t3,sp,64
{
    38f2:	8eaa                	mv	t4,a0
    ctx.fd = -1;
    38f4:	537d                	li	t1,-1
{
    38f6:	e0b2                	sd	a2,64(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    38f8:	0808                	addi	a0,sp,16
    38fa:	8672                	mv	a2,t3
{
    38fc:	fc06                	sd	ra,56(sp)
    38fe:	e4b6                	sd	a3,72(sp)
    3900:	e8ba                	sd	a4,80(sp)
    3902:	ecbe                	sd	a5,88(sp)
    3904:	f0c2                	sd	a6,96(sp)
    3906:	f4c6                	sd	a7,104(sp)
    va_start(ap, format);
    3908:	e472                	sd	t3,8(sp)
    ctx.buf = str;
    390a:	e876                	sd	t4,16(sp)
    ctx.fd = -1;
    390c:	cc1a                	sw	t1,24(sp)
    ctx.pos = 0;
    390e:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    3910:	d41a                	sw	t1,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    3912:	81efd0ef          	jal	930 <_vscanf_core.constprop.0>
}
    3916:	70e2                	ld	ra,56(sp)
    3918:	6165                	addi	sp,sp,112
    391a:	8082                	ret

000000000000391c <scanf>:
{
    391c:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    391e:	04810313          	addi	t1,sp,72
{
    3922:	e4ae                	sd	a1,72(sp)
    3924:	e8b2                	sd	a2,80(sp)
    3926:	f4be                	sd	a5,104(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    3928:	85aa                	mv	a1,a0
    ctx.ungotten = -1;
    392a:	57fd                	li	a5,-1
    int ret = _vscanf_core(&ctx, format, ap);
    392c:	0808                	addi	a0,sp,16
    392e:	861a                	mv	a2,t1
{
    3930:	fc06                	sd	ra,56(sp)
    3932:	ecb6                	sd	a3,88(sp)
    3934:	f0ba                	sd	a4,96(sp)
    3936:	f8c2                	sd	a6,112(sp)
    3938:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    393a:	e41a                	sd	t1,8(sp)
    ctx.buf = NULL;
    393c:	e802                	sd	zero,16(sp)
    ctx.fd = STDIN_FD;
    393e:	cc02                	sw	zero,24(sp)
    ctx.pos = 0;
    3940:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    3942:	d43e                	sw	a5,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    3944:	fedfc0ef          	jal	930 <_vscanf_core.constprop.0>
}
    3948:	70e2                	ld	ra,56(sp)
    394a:	6109                	addi	sp,sp,128
    394c:	8082                	ret

000000000000394e <fopen>:
{
    394e:	1101                	addi	sp,sp,-32
    3950:	e426                	sd	s1,8(sp)
    3952:	84ae                	mv	s1,a1
    3954:	e04a                	sd	s2,0(sp)
    if (strcmp(mode, "r") == 0)
    3956:	00001597          	auipc	a1,0x1
    395a:	75258593          	addi	a1,a1,1874 # 50a8 <_GLOBAL__sub_I__ZSt3cin+0x100>
{
    395e:	892a                	mv	s2,a0
    if (strcmp(mode, "r") == 0)
    3960:	8526                	mv	a0,s1
{
    3962:	e822                	sd	s0,16(sp)
    3964:	ec06                	sd	ra,24(sp)
    if (strcmp(mode, "r") == 0)
    3966:	298010ef          	jal	4bfe <strcmp>
    396a:	842a                	mv	s0,a0
    396c:	c919                	beqz	a0,3982 <fopen+0x34>
    else if (strcmp(mode, "w") == 0)
    396e:	00001597          	auipc	a1,0x1
    3972:	74258593          	addi	a1,a1,1858 # 50b0 <_GLOBAL__sub_I__ZSt3cin+0x108>
    3976:	8526                	mv	a0,s1
    3978:	286010ef          	jal	4bfe <strcmp>
        flags = O_WRONLY | O_CREAT | O_TRUNC;
    397c:	24100413          	li	s0,577
    else if (strcmp(mode, "w") == 0)
    3980:	ed39                	bnez	a0,39de <fopen+0x90>
    int64 fd = open(filename, flags);
    3982:	85a2                	mv	a1,s0
    3984:	854a                	mv	a0,s2
    3986:	f42fc0ef          	jal	c8 <open>
    398a:	84aa                	mv	s1,a0
    if (fd < 0)
    398c:	06054c63          	bltz	a0,3a04 <fopen+0xb6>
    FILE *f = (FILE *)malloc(sizeof(FILE));
    3990:	42000513          	li	a0,1056
    3994:	2f3000ef          	jal	4486 <malloc>
    3998:	892a                	mv	s2,a0
    if (!f)
    399a:	c53d                	beqz	a0,3a08 <fopen+0xba>
    memset(f, 0, sizeof(FILE));
    399c:	42000613          	li	a2,1056
    39a0:	4581                	li	a1,0
    39a2:	0ee010ef          	jal	4a90 <memset>
    if (fd == 1)
    39a6:	4785                	li	a5,1
    f->fd = (int)fd;
    39a8:	00992023          	sw	s1,0(s2)
    f->flags = flags;
    39ac:	00892223          	sw	s0,4(s2)
    if (fd == 1)
    39b0:	00f48e63          	beq	s1,a5,39cc <fopen+0x7e>
    else if (fd == 2)
    39b4:	4789                	li	a5,2
    39b6:	00f48b63          	beq	s1,a5,39cc <fopen+0x7e>
        f->buf_mode = 0;
    39ba:	40092e23          	sw	zero,1052(s2)
}
    39be:	60e2                	ld	ra,24(sp)
    39c0:	6442                	ld	s0,16(sp)
    39c2:	64a2                	ld	s1,8(sp)
    39c4:	854a                	mv	a0,s2
    39c6:	6902                	ld	s2,0(sp)
    39c8:	6105                	addi	sp,sp,32
    39ca:	8082                	ret
    39cc:	60e2                	ld	ra,24(sp)
    39ce:	6442                	ld	s0,16(sp)
        f->buf_mode = 2;
    39d0:	40992e23          	sw	s1,1052(s2)
}
    39d4:	854a                	mv	a0,s2
    39d6:	64a2                	ld	s1,8(sp)
    39d8:	6902                	ld	s2,0(sp)
    39da:	6105                	addi	sp,sp,32
    39dc:	8082                	ret
    else if (strcmp(mode, "a") == 0)
    39de:	00001597          	auipc	a1,0x1
    39e2:	6da58593          	addi	a1,a1,1754 # 50b8 <_GLOBAL__sub_I__ZSt3cin+0x110>
    39e6:	8526                	mv	a0,s1
    39e8:	216010ef          	jal	4bfe <strcmp>
        flags = O_WRONLY | O_CREAT | O_APPEND;
    39ec:	44100413          	li	s0,1089
    else if (strcmp(mode, "a") == 0)
    39f0:	d949                	beqz	a0,3982 <fopen+0x34>
    else if (strcmp(mode, "r+") == 0)
    39f2:	00001597          	auipc	a1,0x1
    39f6:	6ce58593          	addi	a1,a1,1742 # 50c0 <_GLOBAL__sub_I__ZSt3cin+0x118>
    39fa:	8526                	mv	a0,s1
    39fc:	202010ef          	jal	4bfe <strcmp>
        flags = O_RDWR;
    3a00:	4409                	li	s0,2
    else if (strcmp(mode, "r+") == 0)
    3a02:	d141                	beqz	a0,3982 <fopen+0x34>
        return NULL;
    3a04:	4901                	li	s2,0
    3a06:	bf65                	j	39be <fopen+0x70>
        close(fd);
    3a08:	8526                	mv	a0,s1
    3a0a:	ea6fc0ef          	jal	b0 <close>
        return NULL;
    3a0e:	4901                	li	s2,0
    3a10:	b77d                	j	39be <fopen+0x70>

0000000000003a12 <fclose>:
    if (!stream)
    3a12:	cd29                	beqz	a0,3a6c <fclose+0x5a>
    if (stream->buf_write_pos > 0)
    3a14:	41052603          	lw	a2,1040(a0)
{
    3a18:	1141                	addi	sp,sp,-16
    3a1a:	e022                	sd	s0,0(sp)
    3a1c:	e406                	sd	ra,8(sp)
    3a1e:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    3a20:	02c04a63          	bgtz	a2,3a54 <fclose+0x42>
    if (stream != stdin && stream != stdout && stream != stderr)
    3a24:	00004797          	auipc	a5,0x4
    3a28:	c3c78793          	addi	a5,a5,-964 # 7660 <stdout>
    3a2c:	6798                	ld	a4,8(a5)
    3a2e:	00870e63          	beq	a4,s0,3a4a <fclose+0x38>
    3a32:	6398                	ld	a4,0(a5)
    3a34:	00870b63          	beq	a4,s0,3a4a <fclose+0x38>
    3a38:	6b9c                	ld	a5,16(a5)
    3a3a:	00878863          	beq	a5,s0,3a4a <fclose+0x38>
        close(stream->fd);
    3a3e:	4008                	lw	a0,0(s0)
    3a40:	e70fc0ef          	jal	b0 <close>
        free(stream);
    3a44:	8522                	mv	a0,s0
    3a46:	1cb000ef          	jal	4410 <free>
}
    3a4a:	60a2                	ld	ra,8(sp)
    3a4c:	6402                	ld	s0,0(sp)
    return 0;
    3a4e:	4501                	li	a0,0
}
    3a50:	0141                	addi	sp,sp,16
    3a52:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3a54:	4108                	lw	a0,0(a0)
    3a56:	01040593          	addi	a1,s0,16
    3a5a:	e4efc0ef          	jal	a8 <write>
        if (ret < stream->buf_write_pos)
    3a5e:	41042783          	lw	a5,1040(s0)
    3a62:	00f54763          	blt	a0,a5,3a70 <fclose+0x5e>
        stream->buf_write_pos = 0;
    3a66:	40042823          	sw	zero,1040(s0)
    3a6a:	bf6d                	j	3a24 <fclose+0x12>
        return -1;
    3a6c:	557d                	li	a0,-1
}
    3a6e:	8082                	ret
            stream->error = 1;
    3a70:	4785                	li	a5,1
    3a72:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3a74:	40042823          	sw	zero,1040(s0)
            return EOF;
    3a78:	b775                	j	3a24 <fclose+0x12>

0000000000003a7a <fflush>:
    if (!stream)
    3a7a:	c121                	beqz	a0,3aba <fflush+0x40>
    if (stream->buf_write_pos > 0)
    3a7c:	41052603          	lw	a2,1040(a0)
{
    3a80:	1141                	addi	sp,sp,-16
    3a82:	e022                	sd	s0,0(sp)
    3a84:	e406                	sd	ra,8(sp)
    3a86:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    3a88:	00c04763          	bgtz	a2,3a96 <fflush+0x1c>
    return 0;
    3a8c:	4501                	li	a0,0
}
    3a8e:	60a2                	ld	ra,8(sp)
    3a90:	6402                	ld	s0,0(sp)
    3a92:	0141                	addi	sp,sp,16
    3a94:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3a96:	4108                	lw	a0,0(a0)
    3a98:	01040593          	addi	a1,s0,16
    3a9c:	e0cfc0ef          	jal	a8 <write>
        if (ret < stream->buf_write_pos)
    3aa0:	41042783          	lw	a5,1040(s0)
    3aa4:	00f54563          	blt	a0,a5,3aae <fflush+0x34>
        stream->buf_write_pos = 0;
    3aa8:	40042823          	sw	zero,1040(s0)
    3aac:	b7c5                	j	3a8c <fflush+0x12>
            stream->error = 1;
    3aae:	4785                	li	a5,1
    3ab0:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3ab2:	40042823          	sw	zero,1040(s0)
        return EOF;
    3ab6:	557d                	li	a0,-1
    3ab8:	bfd9                	j	3a8e <fflush+0x14>
    3aba:	557d                	li	a0,-1
}
    3abc:	8082                	ret

0000000000003abe <fprintf>:
{
    3abe:	7159                	addi	sp,sp,-112
    3ac0:	fc06                	sd	ra,56(sp)
    3ac2:	e0b2                	sd	a2,64(sp)
    3ac4:	e4b6                	sd	a3,72(sp)
    3ac6:	e8ba                	sd	a4,80(sp)
    3ac8:	ecbe                	sd	a5,88(sp)
    3aca:	f0c2                	sd	a6,96(sp)
    3acc:	f4c6                	sd	a7,104(sp)
    if (!stream)
    3ace:	cd19                	beqz	a0,3aec <fprintf+0x2e>
    va_start(ap, format);
    3ad0:	832a                	mv	t1,a0
    3ad2:	0090                	addi	a2,sp,64
    _vprintf_core(&ctx, format, ap);
    3ad4:	0808                	addi	a0,sp,16
    va_start(ap, format);
    3ad6:	e432                	sd	a2,8(sp)
    ctx.buf = NULL;
    3ad8:	e802                	sd	zero,16(sp)
    ctx.limit = 0;
    3ada:	ec02                	sd	zero,24(sp)
    ctx.written = 0;
    3adc:	f002                	sd	zero,32(sp)
    ctx.stream  = stream;
    3ade:	f41a                	sd	t1,40(sp)
    _vprintf_core(&ctx, format, ap);
    3ae0:	d34ff0ef          	jal	3014 <_vprintf_core.constprop.0.isra.0>
    return (int)ctx.written;
    3ae4:	5502                	lw	a0,32(sp)
}
    3ae6:	70e2                	ld	ra,56(sp)
    3ae8:	6165                	addi	sp,sp,112
    3aea:	8082                	ret
        return -1;
    3aec:	557d                	li	a0,-1
    3aee:	bfe5                	j	3ae6 <fprintf+0x28>

0000000000003af0 <fscanf>:
{
    3af0:	7159                	addi	sp,sp,-112
    3af2:	fc06                	sd	ra,56(sp)
    3af4:	e0b2                	sd	a2,64(sp)
    3af6:	e4b6                	sd	a3,72(sp)
    3af8:	e8ba                	sd	a4,80(sp)
    3afa:	ecbe                	sd	a5,88(sp)
    3afc:	f0c2                	sd	a6,96(sp)
    3afe:	f4c6                	sd	a7,104(sp)
    if (!stream)
    3b00:	cd19                	beqz	a0,3b1e <fscanf+0x2e>
    ctx.fd = stream->fd;
    3b02:	411c                	lw	a5,0(a0)
    va_start(ap, format);
    3b04:	0090                	addi	a2,sp,64
    int ret = _vscanf_core(&ctx, format, ap);
    3b06:	0808                	addi	a0,sp,16
    ctx.fd = stream->fd;
    3b08:	cc3e                	sw	a5,24(sp)
    ctx.ungotten = -1;
    3b0a:	57fd                	li	a5,-1
    va_start(ap, format);
    3b0c:	e432                	sd	a2,8(sp)
    ctx.buf = NULL;
    3b0e:	e802                	sd	zero,16(sp)
    ctx.pos = 0;
    3b10:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    3b12:	d43e                	sw	a5,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    3b14:	e1dfc0ef          	jal	930 <_vscanf_core.constprop.0>
}
    3b18:	70e2                	ld	ra,56(sp)
    3b1a:	6165                	addi	sp,sp,112
    3b1c:	8082                	ret
        return -1;
    3b1e:	557d                	li	a0,-1
    3b20:	bfe5                	j	3b18 <fscanf+0x28>

0000000000003b22 <fputc>:
    if (!stream)
    3b22:	c1e1                	beqz	a1,3be2 <fputc+0xc0>
{
    3b24:	7179                	addi	sp,sp,-48
    3b26:	e84a                	sd	s2,16(sp)
    if (stream->buf_mode == 2)
    3b28:	41c5a903          	lw	s2,1052(a1)
{
    3b2c:	f022                	sd	s0,32(sp)
    3b2e:	ec26                	sd	s1,24(sp)
    3b30:	f406                	sd	ra,40(sp)
    if (stream->buf_mode == 2)
    3b32:	4789                	li	a5,2
    3b34:	842e                	mv	s0,a1
    3b36:	84aa                	mv	s1,a0
        char ch = (char)c;
    3b38:	0ff57713          	zext.b	a4,a0
    if (stream->buf_mode == 2)
    3b3c:	02f90963          	beq	s2,a5,3b6e <fputc+0x4c>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    3b40:	4105a783          	lw	a5,1040(a1)
    if (stream->buf_write_pos >= BUFSIZ)
    3b44:	3ff00693          	li	a3,1023
    stream->buffer[stream->buf_write_pos++] = (char)c;
    3b48:	0017861b          	addiw	a2,a5,1
    3b4c:	40c5a823          	sw	a2,1040(a1)
    3b50:	97ae                	add	a5,a5,a1
    3b52:	00e78823          	sb	a4,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    3b56:	06c6c463          	blt	a3,a2,3bbe <fputc+0x9c>
    else if (stream->buf_mode == 1 && c == '\n')
    3b5a:	4785                	li	a5,1
    3b5c:	02f90e63          	beq	s2,a5,3b98 <fputc+0x76>
    return c;
    3b60:	8526                	mv	a0,s1
}
    3b62:	70a2                	ld	ra,40(sp)
    3b64:	7402                	ld	s0,32(sp)
    3b66:	64e2                	ld	s1,24(sp)
    3b68:	6942                	ld	s2,16(sp)
    3b6a:	6145                	addi	sp,sp,48
    3b6c:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    3b6e:	4188                	lw	a0,0(a1)
    3b70:	4605                	li	a2,1
    3b72:	00f10593          	addi	a1,sp,15
        char ch = (char)c;
    3b76:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    3b7a:	d2efc0ef          	jal	a8 <write>
    3b7e:	872a                	mv	a4,a0
    3b80:	4785                	li	a5,1
        return c;
    3b82:	8526                	mv	a0,s1
        if (write(stream->fd, &ch, 1) != 1)
    3b84:	fcf70fe3          	beq	a4,a5,3b62 <fputc+0x40>
}
    3b88:	70a2                	ld	ra,40(sp)
            stream->error = 1;
    3b8a:	c41c                	sw	a5,8(s0)
}
    3b8c:	7402                	ld	s0,32(sp)
    3b8e:	64e2                	ld	s1,24(sp)
    3b90:	6942                	ld	s2,16(sp)
            return EOF;
    3b92:	557d                	li	a0,-1
}
    3b94:	6145                	addi	sp,sp,48
    3b96:	8082                	ret
    else if (stream->buf_mode == 1 && c == '\n')
    3b98:	47a9                	li	a5,10
    3b9a:	fcf513e3          	bne	a0,a5,3b60 <fputc+0x3e>
    if (stream->buf_write_pos > 0)
    3b9e:	fcc051e3          	blez	a2,3b60 <fputc+0x3e>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3ba2:	4188                	lw	a0,0(a1)
    3ba4:	05c1                	addi	a1,a1,16
    3ba6:	d02fc0ef          	jal	a8 <write>
        if (ret < stream->buf_write_pos)
    3baa:	41042783          	lw	a5,1040(s0)
    3bae:	02f55063          	bge	a0,a5,3bce <fputc+0xac>
            stream->error = 1;
    3bb2:	01242423          	sw	s2,8(s0)
            stream->buf_write_pos = 0;
    3bb6:	40042823          	sw	zero,1040(s0)
    return c;
    3bba:	8526                	mv	a0,s1
    3bbc:	b75d                	j	3b62 <fputc+0x40>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3bbe:	4188                	lw	a0,0(a1)
    3bc0:	05c1                	addi	a1,a1,16
    3bc2:	ce6fc0ef          	jal	a8 <write>
        if (ret < stream->buf_write_pos)
    3bc6:	41042783          	lw	a5,1040(s0)
    3bca:	00f54663          	blt	a0,a5,3bd6 <fputc+0xb4>
        stream->buf_write_pos = 0;
    3bce:	40042823          	sw	zero,1040(s0)
    return c;
    3bd2:	8526                	mv	a0,s1
    3bd4:	b779                	j	3b62 <fputc+0x40>
            stream->error = 1;
    3bd6:	4785                	li	a5,1
    3bd8:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3bda:	40042823          	sw	zero,1040(s0)
    return c;
    3bde:	8526                	mv	a0,s1
    3be0:	b749                	j	3b62 <fputc+0x40>
        return EOF;
    3be2:	557d                	li	a0,-1
}
    3be4:	8082                	ret

0000000000003be6 <fputs>:
    if (!stream)
    3be6:	c1ed                	beqz	a1,3cc8 <fputs+0xe2>
{
    3be8:	711d                	addi	sp,sp,-96
    3bea:	e4a6                	sd	s1,72(sp)
    3bec:	ec86                	sd	ra,88(sp)
    while (*s)
    3bee:	00054703          	lbu	a4,0(a0)
    3bf2:	84aa                	mv	s1,a0
    3bf4:	cf25                	beqz	a4,3c6c <fputs+0x86>
    3bf6:	e8a2                	sd	s0,80(sp)
    3bf8:	e0ca                	sd	s2,64(sp)
    3bfa:	fc4e                	sd	s3,56(sp)
    3bfc:	f852                	sd	s4,48(sp)
    3bfe:	f456                	sd	s5,40(sp)
    3c00:	f05a                	sd	s6,32(sp)
    3c02:	ec5e                	sd	s7,24(sp)
    3c04:	842e                	mv	s0,a1
    if (stream->buf_mode == 2)
    3c06:	4909                	li	s2,2
    if (stream->buf_write_pos >= BUFSIZ)
    3c08:	3ff00b13          	li	s6,1023
    else if (stream->buf_mode == 1 && c == '\n')
    3c0c:	4985                	li	s3,1
    3c0e:	4a29                	li	s4,10
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3c10:	01058a93          	addi	s5,a1,16
        if (write(stream->fd, &ch, 1) != 1)
    3c14:	00f10b93          	addi	s7,sp,15
    3c18:	a031                	j	3c24 <fputs+0x3e>
    else if (stream->buf_mode == 1 && c == '\n')
    3c1a:	09368563          	beq	a3,s3,3ca4 <fputs+0xbe>
    while (*s)
    3c1e:	0004c703          	lbu	a4,0(s1)
    3c22:	cf15                	beqz	a4,3c5e <fputs+0x78>
    if (stream->buf_mode == 2)
    3c24:	41c42683          	lw	a3,1052(s0)
        if (fputc(*s++, stream) == EOF)
    3c28:	0485                	addi	s1,s1,1
    if (stream->buf_mode == 2)
    3c2a:	05268663          	beq	a3,s2,3c76 <fputs+0x90>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    3c2e:	41042783          	lw	a5,1040(s0)
    3c32:	0017861b          	addiw	a2,a5,1
    3c36:	40c42823          	sw	a2,1040(s0)
    3c3a:	97a2                	add	a5,a5,s0
    3c3c:	00e78823          	sb	a4,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    3c40:	fccb5de3          	bge	s6,a2,3c1a <fputs+0x34>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3c44:	4008                	lw	a0,0(s0)
    3c46:	85d6                	mv	a1,s5
    3c48:	c60fc0ef          	jal	a8 <write>
        if (ret < stream->buf_write_pos)
    3c4c:	41042783          	lw	a5,1040(s0)
    3c50:	06f54763          	blt	a0,a5,3cbe <fputs+0xd8>
        stream->buf_write_pos = 0;
    3c54:	40042823          	sw	zero,1040(s0)
    while (*s)
    3c58:	0004c703          	lbu	a4,0(s1)
    3c5c:	f761                	bnez	a4,3c24 <fputs+0x3e>
    3c5e:	6446                	ld	s0,80(sp)
    3c60:	6906                	ld	s2,64(sp)
    3c62:	79e2                	ld	s3,56(sp)
    3c64:	7a42                	ld	s4,48(sp)
    3c66:	7aa2                	ld	s5,40(sp)
    3c68:	7b02                	ld	s6,32(sp)
    3c6a:	6be2                	ld	s7,24(sp)
}
    3c6c:	60e6                	ld	ra,88(sp)
    3c6e:	64a6                	ld	s1,72(sp)
    return 0;
    3c70:	4501                	li	a0,0
}
    3c72:	6125                	addi	sp,sp,96
    3c74:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    3c76:	4008                	lw	a0,0(s0)
    3c78:	4605                	li	a2,1
    3c7a:	85de                	mv	a1,s7
        char ch = (char)c;
    3c7c:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    3c80:	c28fc0ef          	jal	a8 <write>
    3c84:	f9350de3          	beq	a0,s3,3c1e <fputs+0x38>
            stream->error = 1;
    3c88:	01342423          	sw	s3,8(s0)
}
    3c8c:	60e6                	ld	ra,88(sp)
    3c8e:	6446                	ld	s0,80(sp)
    3c90:	6906                	ld	s2,64(sp)
    3c92:	79e2                	ld	s3,56(sp)
    3c94:	7a42                	ld	s4,48(sp)
    3c96:	7aa2                	ld	s5,40(sp)
    3c98:	7b02                	ld	s6,32(sp)
    3c9a:	6be2                	ld	s7,24(sp)
    3c9c:	64a6                	ld	s1,72(sp)
        return -1;
    3c9e:	557d                	li	a0,-1
}
    3ca0:	6125                	addi	sp,sp,96
    3ca2:	8082                	ret
    else if (stream->buf_mode == 1 && c == '\n')
    3ca4:	f7471de3          	bne	a4,s4,3c1e <fputs+0x38>
    if (stream->buf_write_pos > 0)
    3ca8:	f6c05be3          	blez	a2,3c1e <fputs+0x38>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3cac:	4008                	lw	a0,0(s0)
    3cae:	01040593          	addi	a1,s0,16
    3cb2:	bf6fc0ef          	jal	a8 <write>
        if (ret < stream->buf_write_pos)
    3cb6:	41042783          	lw	a5,1040(s0)
    3cba:	f8f55de3          	bge	a0,a5,3c54 <fputs+0x6e>
            stream->error = 1;
    3cbe:	4785                	li	a5,1
    3cc0:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3cc2:	40042823          	sw	zero,1040(s0)
            return EOF;
    3cc6:	bfa1                	j	3c1e <fputs+0x38>
        return -1;
    3cc8:	557d                	li	a0,-1
}
    3cca:	8082                	ret

0000000000003ccc <fgetc>:
    if (!stream)
    3ccc:	c949                	beqz	a0,3d5e <fgetc+0x92>
    if (stream->buf_write_pos > 0)
    3cce:	41052603          	lw	a2,1040(a0)
{
    3cd2:	1141                	addi	sp,sp,-16
    3cd4:	e022                	sd	s0,0(sp)
    3cd6:	e406                	sd	ra,8(sp)
    3cd8:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    3cda:	04c04863          	bgtz	a2,3d2a <fgetc+0x5e>
    if (stream->buf_read_pos < stream->buf_read_cnt)
    3cde:	41442783          	lw	a5,1044(s0)
    3ce2:	41842703          	lw	a4,1048(s0)
    3ce6:	00e7dd63          	bge	a5,a4,3d00 <fgetc+0x34>
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3cea:	0017871b          	addiw	a4,a5,1
    3cee:	40e42a23          	sw	a4,1044(s0)
    3cf2:	943e                	add	s0,s0,a5
    3cf4:	01044503          	lbu	a0,16(s0)
}
    3cf8:	60a2                	ld	ra,8(sp)
    3cfa:	6402                	ld	s0,0(sp)
    3cfc:	0141                	addi	sp,sp,16
    3cfe:	8082                	ret
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3d00:	4008                	lw	a0,0(s0)
    3d02:	40000613          	li	a2,1024
    3d06:	01040593          	addi	a1,s0,16
    3d0a:	b96fc0ef          	jal	a0 <read>
    3d0e:	87aa                	mv	a5,a0
    if (ret <= 0)
    3d10:	02a05e63          	blez	a0,3d4c <fgetc+0x80>
    stream->buf_read_cnt = (int)ret;
    3d14:	40f42c23          	sw	a5,1048(s0)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3d18:	4785                	li	a5,1
    3d1a:	01044503          	lbu	a0,16(s0)
}
    3d1e:	60a2                	ld	ra,8(sp)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3d20:	40f42a23          	sw	a5,1044(s0)
}
    3d24:	6402                	ld	s0,0(sp)
    3d26:	0141                	addi	sp,sp,16
    3d28:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3d2a:	4108                	lw	a0,0(a0)
    3d2c:	01040593          	addi	a1,s0,16
    3d30:	b78fc0ef          	jal	a8 <write>
        if (ret < stream->buf_write_pos)
    3d34:	41042783          	lw	a5,1040(s0)
    3d38:	00f54563          	blt	a0,a5,3d42 <fgetc+0x76>
        stream->buf_write_pos = 0;
    3d3c:	40042823          	sw	zero,1040(s0)
    3d40:	bf79                	j	3cde <fgetc+0x12>
            stream->error = 1;
    3d42:	4785                	li	a5,1
    3d44:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3d46:	40042823          	sw	zero,1040(s0)
            return EOF;
    3d4a:	bf51                	j	3cde <fgetc+0x12>
        if (ret == 0)
    3d4c:	e509                	bnez	a0,3d56 <fgetc+0x8a>
            stream->eof = 1;
    3d4e:	4785                	li	a5,1
    3d50:	c45c                	sw	a5,12(s0)
        return EOF;
    3d52:	557d                	li	a0,-1
    3d54:	b755                	j	3cf8 <fgetc+0x2c>
            stream->error = 1;
    3d56:	4785                	li	a5,1
    3d58:	c41c                	sw	a5,8(s0)
        return EOF;
    3d5a:	557d                	li	a0,-1
    3d5c:	bf71                	j	3cf8 <fgetc+0x2c>
    3d5e:	557d                	li	a0,-1
}
    3d60:	8082                	ret

0000000000003d62 <fgets>:
    if (!stream || n <= 0)
    3d62:	ce5d                	beqz	a2,3e20 <fgets+0xbe>
    3d64:	0ab05e63          	blez	a1,3e20 <fgets+0xbe>
{
    3d68:	715d                	addi	sp,sp,-80
    3d6a:	e0a2                	sd	s0,64(sp)
    3d6c:	fc26                	sd	s1,56(sp)
    3d6e:	f84a                	sd	s2,48(sp)
    3d70:	f44e                	sd	s3,40(sp)
    3d72:	f052                	sd	s4,32(sp)
    3d74:	ec56                	sd	s5,24(sp)
    3d76:	e85a                	sd	s6,16(sp)
    3d78:	e45e                	sd	s7,8(sp)
    3d7a:	e486                	sd	ra,72(sp)
    3d7c:	8432                	mv	s0,a2
    3d7e:	8aaa                	mv	s5,a0
    3d80:	892a                	mv	s2,a0
    3d82:	fff58b9b          	addiw	s7,a1,-1
    int i = 0, c;
    3d86:	4481                	li	s1,0
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3d88:	01060993          	addi	s3,a2,16
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3d8c:	4b05                	li	s6,1
        if (c == '\n')
    3d8e:	4a29                	li	s4,10
    while (i < n - 1)
    3d90:	05748163          	beq	s1,s7,3dd2 <fgets+0x70>
    if (stream->buf_write_pos > 0)
    3d94:	41042603          	lw	a2,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3d98:	85ce                	mv	a1,s3
    if (stream->buf_write_pos > 0)
    3d9a:	06c04963          	bgtz	a2,3e0c <fgets+0xaa>
    if (stream->buf_read_pos < stream->buf_read_cnt)
    3d9e:	41442783          	lw	a5,1044(s0)
    3da2:	41842703          	lw	a4,1048(s0)
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3da6:	40000613          	li	a2,1024
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3daa:	0017851b          	addiw	a0,a5,1
    3dae:	00f406b3          	add	a3,s0,a5
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3db2:	85ce                	mv	a1,s3
    if (stream->buf_read_pos < stream->buf_read_cnt)
    3db4:	02e7de63          	bge	a5,a4,3df0 <fgets+0x8e>
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3db8:	40a42a23          	sw	a0,1044(s0)
    3dbc:	0106c783          	lbu	a5,16(a3)
    3dc0:	0007871b          	sext.w	a4,a5
        str[i++] = (char)c;
    3dc4:	00f90023          	sb	a5,0(s2)
    3dc8:	2485                	addiw	s1,s1,1
        if (c == '\n')
    3dca:	0905                	addi	s2,s2,1
    3dcc:	fd4712e3          	bne	a4,s4,3d90 <fgets+0x2e>
        str[i++] = (char)c;
    3dd0:	8ba6                	mv	s7,s1
    str[i] = '\0';
    3dd2:	9bd6                	add	s7,s7,s5
    3dd4:	000b8023          	sb	zero,0(s7)
    return str;
    3dd8:	8556                	mv	a0,s5
}
    3dda:	60a6                	ld	ra,72(sp)
    3ddc:	6406                	ld	s0,64(sp)
    3dde:	74e2                	ld	s1,56(sp)
    3de0:	7942                	ld	s2,48(sp)
    3de2:	79a2                	ld	s3,40(sp)
    3de4:	7a02                	ld	s4,32(sp)
    3de6:	6ae2                	ld	s5,24(sp)
    3de8:	6b42                	ld	s6,16(sp)
    3dea:	6ba2                	ld	s7,8(sp)
    3dec:	6161                	addi	sp,sp,80
    3dee:	8082                	ret
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3df0:	4008                	lw	a0,0(s0)
    3df2:	aaefc0ef          	jal	a0 <read>
    if (ret <= 0)
    3df6:	02a05c63          	blez	a0,3e2e <fgets+0xcc>
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3dfa:	01044783          	lbu	a5,16(s0)
    stream->buf_read_cnt = (int)ret;
    3dfe:	40a42c23          	sw	a0,1048(s0)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3e02:	41642a23          	sw	s6,1044(s0)
    3e06:	0007871b          	sext.w	a4,a5
        if (c == -1)
    3e0a:	bf6d                	j	3dc4 <fgets+0x62>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3e0c:	4008                	lw	a0,0(s0)
    3e0e:	a9afc0ef          	jal	a8 <write>
        if (ret < stream->buf_write_pos)
    3e12:	41042783          	lw	a5,1040(s0)
    3e16:	00f54763          	blt	a0,a5,3e24 <fgets+0xc2>
        stream->buf_write_pos = 0;
    3e1a:	40042823          	sw	zero,1040(s0)
    3e1e:	b741                	j	3d9e <fgets+0x3c>
        return NULL;
    3e20:	4501                	li	a0,0
}
    3e22:	8082                	ret
            stream->error = 1;
    3e24:	4785                	li	a5,1
    3e26:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3e28:	40042823          	sw	zero,1040(s0)
            return EOF;
    3e2c:	bf8d                	j	3d9e <fgets+0x3c>
            stream->eof = 1;
    3e2e:	4785                	li	a5,1
        if (ret == 0)
    3e30:	e509                	bnez	a0,3e3a <fgets+0xd8>
            stream->eof = 1;
    3e32:	c45c                	sw	a5,12(s0)
            if (i == 0)
    3e34:	fcd1                	bnez	s1,3dd0 <fgets+0x6e>
        return NULL;
    3e36:	4501                	li	a0,0
    3e38:	b74d                	j	3dda <fgets+0x78>
            stream->error = 1;
    3e3a:	c41c                	sw	a5,8(s0)
        if (c == -1)
    3e3c:	bfe5                	j	3e34 <fgets+0xd2>

0000000000003e3e <fread>:
{
    3e3e:	715d                	addi	sp,sp,-80
    3e40:	e486                	sd	ra,72(sp)
    3e42:	f44e                	sd	s3,40(sp)
    if (!stream || size == 0 || nmemb == 0)
    3e44:	0e068963          	beqz	a3,3f36 <fread+0xf8>
    3e48:	ec56                	sd	s5,24(sp)
        return 0;
    3e4a:	4981                	li	s3,0
    3e4c:	8aae                	mv	s5,a1
    if (!stream || size == 0 || nmemb == 0)
    3e4e:	c9bd                	beqz	a1,3ec4 <fread+0x86>
    3e50:	ca35                	beqz	a2,3ec4 <fread+0x86>
    if (stream->buf_write_pos > 0)
    3e52:	4106a783          	lw	a5,1040(a3)
    3e56:	e0a2                	sd	s0,64(sp)
    3e58:	f052                	sd	s4,32(sp)
    uint64 total_bytes = size * nmemb;
    3e5a:	02c589b3          	mul	s3,a1,a2
    3e5e:	8436                	mv	s0,a3
    3e60:	8a2a                	mv	s4,a0
    if (stream->buf_write_pos > 0)
    3e62:	0af04d63          	bgtz	a5,3f1c <fread+0xde>
    while (bytes_read < total_bytes)
    3e66:	04098d63          	beqz	s3,3ec0 <fread+0x82>
    3e6a:	fc26                	sd	s1,56(sp)
    3e6c:	e85a                	sd	s6,16(sp)
    3e6e:	e45e                	sd	s7,8(sp)
    3e70:	f84a                	sd	s2,48(sp)
    3e72:	4481                	li	s1,0
            if (remaining >= BUFSIZ)
    3e74:	3ff00b13          	li	s6,1023
                int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3e78:	01040b93          	addi	s7,s0,16
        if (stream->buf_read_pos < stream->buf_read_cnt)
    3e7c:	41442703          	lw	a4,1044(s0)
    3e80:	41842783          	lw	a5,1048(s0)
            uint64 remaining = total_bytes - bytes_read;
    3e84:	40998633          	sub	a2,s3,s1
        if (stream->buf_read_pos < stream->buf_read_cnt)
    3e88:	06f74463          	blt	a4,a5,3ef0 <fread+0xb2>
                int64 ret = read(stream->fd, dst + bytes_read, remaining);
    3e8c:	4008                	lw	a0,0(s0)
    3e8e:	009a05b3          	add	a1,s4,s1
            if (remaining >= BUFSIZ)
    3e92:	02cb7f63          	bgeu	s6,a2,3ed0 <fread+0x92>
                int64 ret = read(stream->fd, dst + bytes_read, remaining);
    3e96:	a0afc0ef          	jal	a0 <read>
                if (ret <= 0)
    3e9a:	0aa05463          	blez	a0,3f42 <fread+0x104>
                bytes_read += ret;
    3e9e:	94aa                	add	s1,s1,a0
    while (bytes_read < total_bytes)
    3ea0:	fd34eee3          	bltu	s1,s3,3e7c <fread+0x3e>
    return bytes_read / size;
    3ea4:	0354d9b3          	divu	s3,s1,s5
    3ea8:	6406                	ld	s0,64(sp)
}
    3eaa:	60a6                	ld	ra,72(sp)
    return bytes_read / size;
    3eac:	74e2                	ld	s1,56(sp)
    3eae:	7942                	ld	s2,48(sp)
    3eb0:	7a02                	ld	s4,32(sp)
    3eb2:	6ae2                	ld	s5,24(sp)
    3eb4:	6b42                	ld	s6,16(sp)
    3eb6:	6ba2                	ld	s7,8(sp)
}
    3eb8:	854e                	mv	a0,s3
    3eba:	79a2                	ld	s3,40(sp)
    3ebc:	6161                	addi	sp,sp,80
    3ebe:	8082                	ret
    3ec0:	6406                	ld	s0,64(sp)
    3ec2:	7a02                	ld	s4,32(sp)
    3ec4:	60a6                	ld	ra,72(sp)
    3ec6:	6ae2                	ld	s5,24(sp)
    3ec8:	854e                	mv	a0,s3
    3eca:	79a2                	ld	s3,40(sp)
    3ecc:	6161                	addi	sp,sp,80
    3ece:	8082                	ret
                stream->buf_read_pos = 0;
    3ed0:	40042a23          	sw	zero,1044(s0)
                stream->buf_read_cnt = 0;
    3ed4:	40042c23          	sw	zero,1048(s0)
                int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3ed8:	40000613          	li	a2,1024
    3edc:	85de                	mv	a1,s7
    3ede:	9c2fc0ef          	jal	a0 <read>
                if (ret <= 0)
    3ee2:	06a05063          	blez	a0,3f42 <fread+0x104>
                stream->buf_read_cnt = (int)ret;
    3ee6:	40a42c23          	sw	a0,1048(s0)
    while (bytes_read < total_bytes)
    3eea:	f934e9e3          	bltu	s1,s3,3e7c <fread+0x3e>
    3eee:	bf5d                	j	3ea4 <fread+0x66>
            uint64 available = stream->buf_read_cnt - stream->buf_read_pos;
    3ef0:	40e7893b          	subw	s2,a5,a4
            memcpy(dst + bytes_read, stream->buffer + stream->buf_read_pos, to_copy);
    3ef4:	00eb85b3          	add	a1,s7,a4
    3ef8:	009a0533          	add	a0,s4,s1
            uint64 to_copy = (available < remaining) ? available : remaining;
    3efc:	01267363          	bgeu	a2,s2,3f02 <fread+0xc4>
    3f00:	8932                	mv	s2,a2
            memcpy(dst + bytes_read, stream->buffer + stream->buf_read_pos, to_copy);
    3f02:	864a                	mv	a2,s2
    3f04:	3e1000ef          	jal	4ae4 <memcpy>
            stream->buf_read_pos += to_copy;
    3f08:	41442783          	lw	a5,1044(s0)
            bytes_read += to_copy;
    3f0c:	94ca                	add	s1,s1,s2
            stream->buf_read_pos += to_copy;
    3f0e:	012787bb          	addw	a5,a5,s2
    3f12:	40f42a23          	sw	a5,1044(s0)
    while (bytes_read < total_bytes)
    3f16:	f734e3e3          	bltu	s1,s3,3e7c <fread+0x3e>
    3f1a:	b769                	j	3ea4 <fread+0x66>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3f1c:	4288                	lw	a0,0(a3)
    3f1e:	863e                	mv	a2,a5
    3f20:	01068593          	addi	a1,a3,16
    3f24:	984fc0ef          	jal	a8 <write>
        if (ret < stream->buf_write_pos)
    3f28:	41042783          	lw	a5,1040(s0)
    3f2c:	02f54163          	blt	a0,a5,3f4e <fread+0x110>
        stream->buf_write_pos = 0;
    3f30:	40042823          	sw	zero,1040(s0)
    3f34:	bf0d                	j	3e66 <fread+0x28>
}
    3f36:	60a6                	ld	ra,72(sp)
        return 0;
    3f38:	4981                	li	s3,0
}
    3f3a:	854e                	mv	a0,s3
    3f3c:	79a2                	ld	s3,40(sp)
    3f3e:	6161                	addi	sp,sp,80
    3f40:	8082                	ret
                        stream->eof = 1;
    3f42:	4785                	li	a5,1
                    if (ret == 0)
    3f44:	e119                	bnez	a0,3f4a <fread+0x10c>
                        stream->eof = 1;
    3f46:	c45c                	sw	a5,12(s0)
    3f48:	bfb1                	j	3ea4 <fread+0x66>
                        stream->error = 1;
    3f4a:	c41c                	sw	a5,8(s0)
                    return bytes_read / size;
    3f4c:	bfa1                	j	3ea4 <fread+0x66>
            stream->error = 1;
    3f4e:	4785                	li	a5,1
    3f50:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3f52:	40042823          	sw	zero,1040(s0)
            return EOF;
    3f56:	bf01                	j	3e66 <fread+0x28>

0000000000003f58 <fwrite>:
{
    3f58:	711d                	addi	sp,sp,-96
    3f5a:	ec86                	sd	ra,88(sp)
    3f5c:	e0ca                	sd	s2,64(sp)
    if (!stream || !ptr || size == 0 || nmemb == 0)
    3f5e:	10068063          	beqz	a3,405e <fwrite+0x106>
    3f62:	f456                	sd	s5,40(sp)
    3f64:	8aaa                	mv	s5,a0
    3f66:	10050263          	beqz	a0,406a <fwrite+0x112>
    3f6a:	f05a                	sd	s6,32(sp)
        return 0;
    3f6c:	4901                	li	s2,0
    3f6e:	8b2e                	mv	s6,a1
    if (!stream || !ptr || size == 0 || nmemb == 0)
    3f70:	c1d9                	beqz	a1,3ff6 <fwrite+0x9e>
    3f72:	c251                	beqz	a2,3ff6 <fwrite+0x9e>
    if (stream->buf_mode == 2)
    3f74:	41c6a703          	lw	a4,1052(a3)
    3f78:	e8a2                	sd	s0,80(sp)
    3f7a:	4789                	li	a5,2
    uint64 total_bytes = size * nmemb;
    3f7c:	02c58933          	mul	s2,a1,a2
    if (stream->buf_mode == 2)
    3f80:	8436                	mv	s0,a3
    3f82:	0ef70b63          	beq	a4,a5,4078 <fwrite+0x120>
    3f86:	fc4e                	sd	s3,56(sp)
    3f88:	ec5e                	sd	s7,24(sp)
    3f8a:	e862                	sd	s8,16(sp)
    uint64 bytes_written = 0;
    3f8c:	4981                	li	s3,0
    3f8e:	01068b93          	addi	s7,a3,16
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    3f92:	40000c13          	li	s8,1024
    while (bytes_written < total_bytes)
    3f96:	12090263          	beqz	s2,40ba <fwrite+0x162>
    3f9a:	e4a6                	sd	s1,72(sp)
    3f9c:	f852                	sd	s4,48(sp)
    3f9e:	e466                	sd	s9,8(sp)
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    3fa0:	41042783          	lw	a5,1040(s0)
        uint64 remaining = total_bytes - bytes_written;
    3fa4:	41390cb3          	sub	s9,s2,s3
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, remaining);
    3fa8:	013a85b3          	add	a1,s5,s3
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    3fac:	40fc0a3b          	subw	s4,s8,a5
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, space_left);
    3fb0:	00fb8533          	add	a0,s7,a5
    3fb4:	8652                	mv	a2,s4
        if (remaining <= space_left)
    3fb6:	059a6763          	bltu	s4,s9,4004 <fwrite+0xac>
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, remaining);
    3fba:	8666                	mv	a2,s9
    3fbc:	329000ef          	jal	4ae4 <memcpy>
            stream->buf_write_pos += remaining;
    3fc0:	41042783          	lw	a5,1040(s0)
            if (stream->buf_write_pos == BUFSIZ)
    3fc4:	40000713          	li	a4,1024
            stream->buf_write_pos += remaining;
    3fc8:	019786bb          	addw	a3,a5,s9
    3fcc:	40d42823          	sw	a3,1040(s0)
            if (stream->buf_write_pos == BUFSIZ)
    3fd0:	06e68a63          	beq	a3,a4,4044 <fwrite+0xec>
    return bytes_written / size;
    3fd4:	03695933          	divu	s2,s2,s6
    3fd8:	6446                	ld	s0,80(sp)
    3fda:	64a6                	ld	s1,72(sp)
    3fdc:	79e2                	ld	s3,56(sp)
    3fde:	7a42                	ld	s4,48(sp)
    3fe0:	7aa2                	ld	s5,40(sp)
    3fe2:	7b02                	ld	s6,32(sp)
    3fe4:	6be2                	ld	s7,24(sp)
    3fe6:	6c42                	ld	s8,16(sp)
    3fe8:	6ca2                	ld	s9,8(sp)
}
    3fea:	60e6                	ld	ra,88(sp)
    3fec:	854a                	mv	a0,s2
    3fee:	6906                	ld	s2,64(sp)
    3ff0:	6125                	addi	sp,sp,96
    3ff2:	8082                	ret
    3ff4:	6446                	ld	s0,80(sp)
    3ff6:	60e6                	ld	ra,88(sp)
    3ff8:	7aa2                	ld	s5,40(sp)
    3ffa:	7b02                	ld	s6,32(sp)
    3ffc:	854a                	mv	a0,s2
    3ffe:	6906                	ld	s2,64(sp)
    4000:	6125                	addi	sp,sp,96
    4002:	8082                	ret
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, space_left);
    4004:	2e1000ef          	jal	4ae4 <memcpy>
            stream->buf_write_pos += space_left;
    4008:	41042783          	lw	a5,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    400c:	85de                	mv	a1,s7
            bytes_written += space_left;
    400e:	99d2                	add	s3,s3,s4
            stream->buf_write_pos += space_left;
    4010:	00fa04bb          	addw	s1,s4,a5
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4014:	02049613          	slli	a2,s1,0x20
            stream->buf_write_pos += space_left;
    4018:	40942823          	sw	s1,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    401c:	9201                	srli	a2,a2,0x20
    if (stream->buf_write_pos > 0)
    401e:	00904763          	bgtz	s1,402c <fwrite+0xd4>
    while (bytes_written < total_bytes)
    4022:	f729efe3          	bltu	s3,s2,3fa0 <fwrite+0x48>
    return bytes_written / size;
    4026:	0369d933          	divu	s2,s3,s6
    402a:	b77d                	j	3fd8 <fwrite+0x80>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    402c:	4008                	lw	a0,0(s0)
    402e:	87afc0ef          	jal	a8 <write>
        if (ret < stream->buf_write_pos)
    4032:	41042783          	lw	a5,1040(s0)
    4036:	08f54963          	blt	a0,a5,40c8 <fwrite+0x170>
        stream->buf_write_pos = 0;
    403a:	40042823          	sw	zero,1040(s0)
    while (bytes_written < total_bytes)
    403e:	f729e1e3          	bltu	s3,s2,3fa0 <fwrite+0x48>
    4042:	b7d5                	j	4026 <fwrite+0xce>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4044:	4008                	lw	a0,0(s0)
    4046:	40000613          	li	a2,1024
    404a:	85de                	mv	a1,s7
    404c:	85cfc0ef          	jal	a8 <write>
        if (ret < stream->buf_write_pos)
    4050:	41042783          	lw	a5,1040(s0)
    4054:	08f54163          	blt	a0,a5,40d6 <fwrite+0x17e>
        stream->buf_write_pos = 0;
    4058:	40042823          	sw	zero,1040(s0)
    405c:	bfa5                	j	3fd4 <fwrite+0x7c>
}
    405e:	60e6                	ld	ra,88(sp)
        return 0;
    4060:	4901                	li	s2,0
}
    4062:	854a                	mv	a0,s2
    4064:	6906                	ld	s2,64(sp)
    4066:	6125                	addi	sp,sp,96
    4068:	8082                	ret
    406a:	60e6                	ld	ra,88(sp)
        return 0;
    406c:	4901                	li	s2,0
    406e:	7aa2                	ld	s5,40(sp)
}
    4070:	854a                	mv	a0,s2
    4072:	6906                	ld	s2,64(sp)
    4074:	6125                	addi	sp,sp,96
    4076:	8082                	ret
        while (bytes_written < total_bytes)
    4078:	f6090ee3          	beqz	s2,3ff4 <fwrite+0x9c>
    407c:	e4a6                	sd	s1,72(sp)
    uint64 bytes_written = 0;
    407e:	4481                	li	s1,0
    4080:	a021                	j	4088 <fwrite+0x130>
            bytes_written += ret;
    4082:	94aa                	add	s1,s1,a0
        while (bytes_written < total_bytes)
    4084:	0324f463          	bgeu	s1,s2,40ac <fwrite+0x154>
            int64 ret = write(stream->fd, src + bytes_written, total_bytes - bytes_written);
    4088:	4008                	lw	a0,0(s0)
    408a:	40990633          	sub	a2,s2,s1
    408e:	009a85b3          	add	a1,s5,s1
    4092:	816fc0ef          	jal	a8 <write>
            if (ret <= 0)
    4096:	fea046e3          	bgtz	a0,4082 <fwrite+0x12a>
                stream->error = 1;
    409a:	4785                	li	a5,1
        return bytes_written / size;
    409c:	0364d933          	divu	s2,s1,s6
                stream->error = 1;
    40a0:	c41c                	sw	a5,8(s0)
                break;
    40a2:	64a6                	ld	s1,72(sp)
    40a4:	6446                	ld	s0,80(sp)
    40a6:	7aa2                	ld	s5,40(sp)
    40a8:	7b02                	ld	s6,32(sp)
    40aa:	b781                	j	3fea <fwrite+0x92>
        return bytes_written / size;
    40ac:	0364d933          	divu	s2,s1,s6
    40b0:	6446                	ld	s0,80(sp)
    40b2:	64a6                	ld	s1,72(sp)
    40b4:	7aa2                	ld	s5,40(sp)
    40b6:	7b02                	ld	s6,32(sp)
    40b8:	bf0d                	j	3fea <fwrite+0x92>
    40ba:	6446                	ld	s0,80(sp)
    40bc:	79e2                	ld	s3,56(sp)
    40be:	7aa2                	ld	s5,40(sp)
    40c0:	7b02                	ld	s6,32(sp)
    40c2:	6be2                	ld	s7,24(sp)
    40c4:	6c42                	ld	s8,16(sp)
    40c6:	b715                	j	3fea <fwrite+0x92>
            stream->error = 1;
    40c8:	4785                	li	a5,1
    40ca:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    40cc:	40042823          	sw	zero,1040(s0)
    while (bytes_written < total_bytes)
    40d0:	ed29e8e3          	bltu	s3,s2,3fa0 <fwrite+0x48>
    40d4:	bf89                	j	4026 <fwrite+0xce>
            stream->error = 1;
    40d6:	4785                	li	a5,1
    40d8:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    40da:	40042823          	sw	zero,1040(s0)
            return EOF;
    40de:	bddd                	j	3fd4 <fwrite+0x7c>

00000000000040e0 <fseek>:
    if (!stream)
    40e0:	c925                	beqz	a0,4150 <fseek+0x70>
{
    40e2:	1101                	addi	sp,sp,-32
    40e4:	e04a                	sd	s2,0(sp)
    40e6:	8932                	mv	s2,a2
    if (stream->buf_write_pos > 0)
    40e8:	41052603          	lw	a2,1040(a0)
{
    40ec:	e822                	sd	s0,16(sp)
    40ee:	e426                	sd	s1,8(sp)
    40f0:	ec06                	sd	ra,24(sp)
    40f2:	842a                	mv	s0,a0
    40f4:	84ae                	mv	s1,a1
    if (stream->buf_write_pos > 0)
    40f6:	02c04863          	bgtz	a2,4126 <fseek+0x46>
    if (lseek(stream->fd, offset, whence) < 0)
    40fa:	4008                	lw	a0,0(s0)
    stream->buf_read_pos = 0;
    40fc:	40042a23          	sw	zero,1044(s0)
    stream->buf_read_cnt = 0;
    4100:	40042c23          	sw	zero,1048(s0)
    stream->eof = 0;
    4104:	00042623          	sw	zero,12(s0)
    if (lseek(stream->fd, offset, whence) < 0)
    4108:	864a                	mv	a2,s2
    410a:	0004859b          	sext.w	a1,s1
    410e:	82afc0ef          	jal	138 <lseek>
    4112:	87aa                	mv	a5,a0
    return 0;
    4114:	4501                	li	a0,0
    if (lseek(stream->fd, offset, whence) < 0)
    4116:	0207c463          	bltz	a5,413e <fseek+0x5e>
}
    411a:	60e2                	ld	ra,24(sp)
    411c:	6442                	ld	s0,16(sp)
    411e:	64a2                	ld	s1,8(sp)
    4120:	6902                	ld	s2,0(sp)
    4122:	6105                	addi	sp,sp,32
    4124:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4126:	4108                	lw	a0,0(a0)
    4128:	01040593          	addi	a1,s0,16
    412c:	f7dfb0ef          	jal	a8 <write>
        if (ret < stream->buf_write_pos)
    4130:	41042783          	lw	a5,1040(s0)
    4134:	00f54963          	blt	a0,a5,4146 <fseek+0x66>
        stream->buf_write_pos = 0;
    4138:	40042823          	sw	zero,1040(s0)
    413c:	bf7d                	j	40fa <fseek+0x1a>
        stream->error = 1;
    413e:	4785                	li	a5,1
    4140:	c41c                	sw	a5,8(s0)
        return -1;
    4142:	557d                	li	a0,-1
    4144:	bfd9                	j	411a <fseek+0x3a>
            stream->error = 1;
    4146:	4785                	li	a5,1
    4148:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    414a:	40042823          	sw	zero,1040(s0)
            return EOF;
    414e:	b775                	j	40fa <fseek+0x1a>
        return -1;
    4150:	557d                	li	a0,-1
}
    4152:	8082                	ret

0000000000004154 <ftell>:
    if (!stream)
    4154:	c505                	beqz	a0,417c <ftell+0x28>
{
    4156:	1141                	addi	sp,sp,-16
    4158:	e022                	sd	s0,0(sp)
    415a:	842a                	mv	s0,a0
    int64 ret = lseek(stream->fd, 0, SEEK_CUR);
    415c:	4108                	lw	a0,0(a0)
    415e:	4605                	li	a2,1
    4160:	4581                	li	a1,0
{
    4162:	e406                	sd	ra,8(sp)
    int64 ret = lseek(stream->fd, 0, SEEK_CUR);
    4164:	fd5fb0ef          	jal	138 <lseek>
    if (ret < 0)
    4168:	00054663          	bltz	a0,4174 <ftell+0x20>
}
    416c:	60a2                	ld	ra,8(sp)
    416e:	6402                	ld	s0,0(sp)
    4170:	0141                	addi	sp,sp,16
    4172:	8082                	ret
        stream->error = 1;
    4174:	4785                	li	a5,1
    4176:	c41c                	sw	a5,8(s0)
        return -1L;
    4178:	557d                	li	a0,-1
    417a:	bfcd                	j	416c <ftell+0x18>
    417c:	557d                	li	a0,-1
}
    417e:	8082                	ret

0000000000004180 <rewind>:
    if (stream)
    4180:	c915                	beqz	a0,41b4 <rewind+0x34>
    if (stream->buf_write_pos > 0)
    4182:	41052603          	lw	a2,1040(a0)
{
    4186:	1141                	addi	sp,sp,-16
    4188:	e022                	sd	s0,0(sp)
    418a:	e406                	sd	ra,8(sp)
    418c:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    418e:	02c04463          	bgtz	a2,41b6 <rewind+0x36>
    if (lseek(stream->fd, offset, whence) < 0)
    4192:	4008                	lw	a0,0(s0)
    stream->buf_read_pos = 0;
    4194:	40042a23          	sw	zero,1044(s0)
    stream->buf_read_cnt = 0;
    4198:	40042c23          	sw	zero,1048(s0)
    stream->eof = 0;
    419c:	00042623          	sw	zero,12(s0)
    if (lseek(stream->fd, offset, whence) < 0)
    41a0:	4601                	li	a2,0
    41a2:	4581                	li	a1,0
    41a4:	f95fb0ef          	jal	138 <lseek>
}
    41a8:	60a2                	ld	ra,8(sp)
        stream->error = 0;
    41aa:	00042423          	sw	zero,8(s0)
}
    41ae:	6402                	ld	s0,0(sp)
    41b0:	0141                	addi	sp,sp,16
    41b2:	8082                	ret
    41b4:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    41b6:	4108                	lw	a0,0(a0)
    41b8:	01040593          	addi	a1,s0,16
    41bc:	eedfb0ef          	jal	a8 <write>
        if (ret < stream->buf_write_pos)
    41c0:	41042783          	lw	a5,1040(s0)
    41c4:	00f54563          	blt	a0,a5,41ce <rewind+0x4e>
        stream->buf_write_pos = 0;
    41c8:	40042823          	sw	zero,1040(s0)
    41cc:	b7d9                	j	4192 <rewind+0x12>
            stream->error = 1;
    41ce:	4785                	li	a5,1
    41d0:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    41d2:	40042823          	sw	zero,1040(s0)
            return EOF;
    41d6:	bf75                	j	4192 <rewind+0x12>

00000000000041d8 <feof>:
    return (stream) ? stream->eof : 1;
    41d8:	c119                	beqz	a0,41de <feof+0x6>
    41da:	4548                	lw	a0,12(a0)
    41dc:	8082                	ret
    41de:	4505                	li	a0,1
}
    41e0:	8082                	ret

00000000000041e2 <ferror>:
     return (stream) ? stream->error : 1;
    41e2:	c119                	beqz	a0,41e8 <ferror+0x6>
    41e4:	4508                	lw	a0,8(a0)
    41e6:	8082                	ret
    41e8:	4505                	li	a0,1
}
    41ea:	8082                	ret

00000000000041ec <clearerr>:
    if (stream)
    41ec:	c509                	beqz	a0,41f6 <clearerr+0xa>
        stream->error = 0;
    41ee:	00052423          	sw	zero,8(a0)
        stream->eof = 0;
    41f2:	00052623          	sw	zero,12(a0)
}
    41f6:	8082                	ret

00000000000041f8 <ungetc>:
    if (!stream || c == EOF)
    41f8:	c19d                	beqz	a1,421e <ungetc+0x26>
    41fa:	57fd                	li	a5,-1
    41fc:	02f50163          	beq	a0,a5,421e <ungetc+0x26>
    if (stream->buf_read_pos > 0)
    4200:	4145a783          	lw	a5,1044(a1)
    4204:	00f05d63          	blez	a5,421e <ungetc+0x26>
        stream->buf_read_pos--;
    4208:	fff7871b          	addiw	a4,a5,-1
    420c:	40e5aa23          	sw	a4,1044(a1)
        stream->buffer[stream->buf_read_pos] = (char)c;
    4210:	00e587b3          	add	a5,a1,a4
    4214:	00a78823          	sb	a0,16(a5)
        stream->eof = 0;
    4218:	0005a623          	sw	zero,12(a1)
        return c;
    421c:	8082                	ret
        return EOF;
    421e:	557d                	li	a0,-1
    4220:	8082                	ret

0000000000004222 <strtoull.part.0>:
    return new_ptr;
}

/* String Conversion*/

unsigned long long strtoull(const char *nptr, char **endptr, int base)
    4222:	1141                	addi	sp,sp,-16
    4224:	e422                	sd	s0,8(sp)
    4226:	8eaa                	mv	t4,a0
{
    const char *s = nptr;
    4228:	88aa                	mv	a7,a0
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    static inline int islower(int c) { return c >= 'a' && c <= 'z'; }
    static inline int isupper(int c) { return c >= 'A' && c <= 'Z'; }
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    static inline int isalnum(int c) { return isalpha(c) || isdigit(c); }
    static inline int isspace(int c) { return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r'; }
    422a:	02000313          	li	t1,32
    422e:	4e11                	li	t3,4
        return 0;
    }

    do
    {
        c = *s++;
    4230:	0008c783          	lbu	a5,0(a7)
    4234:	00188813          	addi	a6,a7,1
    4238:	ff77871b          	addiw	a4,a5,-9
    423c:	0ff77693          	zext.b	a3,a4
    4240:	0007871b          	sext.w	a4,a5
    4244:	04678363          	beq	a5,t1,428a <strtoull.part.0+0x68>
    4248:	04de7163          	bgeu	t3,a3,428a <strtoull.part.0+0x68>
    } while (isspace(c));

    if (c == '-')
    424c:	02d00793          	li	a5,45
    4250:	0ef70863          	beq	a4,a5,4340 <strtoull.part.0+0x11e>
    {
        neg = 1;
        c = *s++;
    }
    else if (c == '+')
    4254:	02b00793          	li	a5,43
    int neg = 0, any, cutlim;
    4258:	4381                	li	t2,0
    else if (c == '+')
    425a:	08f70c63          	beq	a4,a5,42f2 <strtoull.part.0+0xd0>
    {
        c = *s++;
    }

    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    425e:	ea05                	bnez	a2,428e <strtoull.part.0+0x6c>
    4260:	03000793          	li	a5,48
    4264:	0ef70463          	beq	a4,a5,434c <strtoull.part.0+0x12a>
    4268:	00ccd8b7          	lui	a7,0xccd
    426c:	ccd88893          	addi	a7,a7,-819 # cccccd <_ZSt4cerr+0xcc54d5>
    4270:	08b2                	slli	a7,a7,0xc
    4272:	ccd88893          	addi	a7,a7,-819
    4276:	08b2                	slli	a7,a7,0xc
    4278:	ccd88893          	addi	a7,a7,-819
    427c:	08b6                	slli	a7,a7,0xd
    427e:	4415                	li	s0,5
    4280:	99988893          	addi	a7,a7,-1639
    4284:	42a9                	li	t0,10
        c = s[1];
        s += 2;
        base = 16;
    }
    if (base == 0)
        base = (c == '0' ? 8 : 10);
    4286:	4629                	li	a2,10
    4288:	a829                	j	42a2 <strtoull.part.0+0x80>
unsigned long long strtoull(const char *nptr, char **endptr, int base)
    428a:	88c2                	mv	a7,a6
    428c:	b755                	j	4230 <strtoull.part.0+0xe>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    428e:	47c1                	li	a5,16
    4290:	0cf60d63          	beq	a2,a5,436a <strtoull.part.0+0x148>

    cutoff = ULLONG_MAX / (unsigned long long)base;
    4294:	58fd                	li	a7,-1
    cutlim = ULLONG_MAX % (unsigned long long)base;
    4296:	02c8f433          	remu	s0,a7,a2
    cutoff = ULLONG_MAX / (unsigned long long)base;
    429a:	82b2                	mv	t0,a2
    429c:	02c8d8b3          	divu	a7,a7,a2
    cutlim = ULLONG_MAX % (unsigned long long)base;
    42a0:	2401                	sext.w	s0,s0

    for (acc = 0, any = 0;; c = *s++)
    42a2:	4301                	li	t1,0
    42a4:	4501                	li	a0,0
    {
        if (isdigit(c))
    42a6:	4e25                	li	t3,9
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    42a8:	4fe5                	li	t6,25
            break;

        if (c >= base)
            break;

        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    42aa:	5f7d                	li	t5,-1
        if (isdigit(c))
    42ac:	fd07079b          	addiw	a5,a4,-48
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    42b0:	0007069b          	sext.w	a3,a4
    42b4:	00fe7e63          	bgeu	t3,a5,42d0 <strtoull.part.0+0xae>
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    42b8:	f9f6879b          	addiw	a5,a3,-97
    42bc:	04fff063          	bgeu	t6,a5,42fc <strtoull.part.0+0xda>
    42c0:	fbf6869b          	addiw	a3,a3,-65
    42c4:	04dfe163          	bltu	t6,a3,4306 <strtoull.part.0+0xe4>
            c -= isupper(c) ? 'A' - 10 : 'a' - 10;
    42c8:	03700793          	li	a5,55
    42cc:	40f707bb          	subw	a5,a4,a5
        if (c >= base)
    42d0:	02c7db63          	bge	a5,a2,4306 <strtoull.part.0+0xe4>
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    42d4:	01e30b63          	beq	t1,t5,42ea <strtoull.part.0+0xc8>
            any = -1;
    42d8:	537d                	li	t1,-1
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    42da:	00a8e863          	bltu	a7,a0,42ea <strtoull.part.0+0xc8>
    42de:	05150e63          	beq	a0,a7,433a <strtoull.part.0+0x118>
        else
        {
            any = 1;
    42e2:	4305                	li	t1,1
            acc *= base;
    42e4:	02550533          	mul	a0,a0,t0
            acc += c;
    42e8:	953e                	add	a0,a0,a5
    for (acc = 0, any = 0;; c = *s++)
    42ea:	0805                	addi	a6,a6,1
    42ec:	fff84703          	lbu	a4,-1(a6)
        if (isdigit(c))
    42f0:	bf75                	j	42ac <strtoull.part.0+0x8a>
        c = *s++;
    42f2:	00084703          	lbu	a4,0(a6)
    42f6:	00288813          	addi	a6,a7,2
    42fa:	b795                	j	425e <strtoull.part.0+0x3c>
            c -= isupper(c) ? 'A' - 10 : 'a' - 10;
    42fc:	05700793          	li	a5,87
    4300:	40f707bb          	subw	a5,a4,a5
    4304:	b7f1                	j	42d0 <strtoull.part.0+0xae>
        }
    }

    if (any < 0)
    4306:	57fd                	li	a5,-1
    4308:	00f30e63          	beq	t1,a5,4324 <strtoull.part.0+0x102>
    {
        acc = ULLONG_MAX;
        errno = ERANGE;
    }
    else if (neg)
    430c:	00038463          	beqz	t2,4314 <strtoull.part.0+0xf2>
        acc = -acc;
    4310:	40a00533          	neg	a0,a0

    if (endptr != 0)
    4314:	c589                	beqz	a1,431e <strtoull.part.0+0xfc>
        *endptr = (char *)(any ? s - 1 : nptr);
    4316:	00031f63          	bnez	t1,4334 <strtoull.part.0+0x112>
    431a:	01d5b023          	sd	t4,0(a1)

    return acc;
}
    431e:	6422                	ld	s0,8(sp)
    4320:	0141                	addi	sp,sp,16
    4322:	8082                	ret
        errno = ERANGE;
    4324:	02200793          	li	a5,34
    4328:	00003717          	auipc	a4,0x3
    432c:	38f72c23          	sw	a5,920(a4) # 76c0 <errno>
        acc = ULLONG_MAX;
    4330:	557d                	li	a0,-1
    if (endptr != 0)
    4332:	d5f5                	beqz	a1,431e <strtoull.part.0+0xfc>
        *endptr = (char *)(any ? s - 1 : nptr);
    4334:	fff80e93          	addi	t4,a6,-1
    4338:	b7cd                	j	431a <strtoull.part.0+0xf8>
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    433a:	faf448e3          	blt	s0,a5,42ea <strtoull.part.0+0xc8>
    433e:	b755                	j	42e2 <strtoull.part.0+0xc0>
        c = *s++;
    4340:	00084703          	lbu	a4,0(a6)
        neg = 1;
    4344:	4385                	li	t2,1
        c = *s++;
    4346:	00288813          	addi	a6,a7,2
    434a:	bf11                	j	425e <strtoull.part.0+0x3c>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    434c:	00084783          	lbu	a5,0(a6)
    4350:	05800693          	li	a3,88
    4354:	0df7f793          	andi	a5,a5,223
    4358:	02d78b63          	beq	a5,a3,438e <strtoull.part.0+0x16c>
    435c:	58fd                	li	a7,-1
    435e:	441d                	li	s0,7
    4360:	0038d893          	srli	a7,a7,0x3
    4364:	42a1                	li	t0,8
        base = (c == '0' ? 8 : 10);
    4366:	4621                	li	a2,8
    4368:	bf2d                	j	42a2 <strtoull.part.0+0x80>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    436a:	03000793          	li	a5,48
    436e:	00f70863          	beq	a4,a5,437e <strtoull.part.0+0x15c>
    4372:	58fd                	li	a7,-1
    4374:	443d                	li	s0,15
    4376:	0048d893          	srli	a7,a7,0x4
    437a:	42c1                	li	t0,16
    437c:	b71d                	j	42a2 <strtoull.part.0+0x80>
    437e:	00084783          	lbu	a5,0(a6)
    4382:	05800693          	li	a3,88
    4386:	0df7f793          	andi	a5,a5,223
    438a:	fed794e3          	bne	a5,a3,4372 <strtoull.part.0+0x150>
        s += 2;
    438e:	58fd                	li	a7,-1
        c = s[1];
    4390:	00184703          	lbu	a4,1(a6)
        s += 2;
    4394:	443d                	li	s0,15
    4396:	0809                	addi	a6,a6,2
    4398:	0048d893          	srli	a7,a7,0x4
    439c:	42c1                	li	t0,16
        base = 16;
    439e:	4641                	li	a2,16
    43a0:	b709                	j	42a2 <strtoull.part.0+0x80>

00000000000043a2 <atexit>:
    if (__atexit_func_count >= ATEXIT_MAX)
    43a2:	00003717          	auipc	a4,0x3
    43a6:	31e70713          	addi	a4,a4,798 # 76c0 <errno>
    43aa:	435c                	lw	a5,4(a4)
    43ac:	46fd                	li	a3,31
    43ae:	00f6ca63          	blt	a3,a5,43c2 <atexit+0x20>
    __atexit_funcs[__atexit_func_count++] = function;
    43b2:	00379693          	slli	a3,a5,0x3
    43b6:	96ba                	add	a3,a3,a4
    43b8:	2785                	addiw	a5,a5,1
    43ba:	e688                	sd	a0,8(a3)
    43bc:	c35c                	sw	a5,4(a4)
    return 0;
    43be:	4501                	li	a0,0
    43c0:	8082                	ret
        return -1;
    43c2:	557d                	li	a0,-1
}
    43c4:	8082                	ret

00000000000043c6 <exit>:
{
    43c6:	1101                	addi	sp,sp,-32
    43c8:	e822                	sd	s0,16(sp)
    while (__atexit_func_count > 0)
    43ca:	00003417          	auipc	s0,0x3
    43ce:	2f640413          	addi	s0,s0,758 # 76c0 <errno>
    43d2:	405c                	lw	a5,4(s0)
{
    43d4:	e426                	sd	s1,8(sp)
    43d6:	ec06                	sd	ra,24(sp)
    43d8:	84aa                	mv	s1,a0
    while (__atexit_func_count > 0)
    43da:	00f05d63          	blez	a5,43f4 <exit+0x2e>
        (__atexit_funcs[--__atexit_func_count])();
    43de:	fff7871b          	addiw	a4,a5,-1
    43e2:	87ba                	mv	a5,a4
    43e4:	070e                	slli	a4,a4,0x3
    43e6:	9722                	add	a4,a4,s0
    43e8:	6718                	ld	a4,8(a4)
    43ea:	c05c                	sw	a5,4(s0)
    43ec:	9702                	jalr	a4
    while (__atexit_func_count > 0)
    43ee:	405c                	lw	a5,4(s0)
    43f0:	fef047e3          	bgtz	a5,43de <exit+0x18>
    sys_exit(status);
    43f4:	8526                	mv	a0,s1
    43f6:	c8bfb0ef          	jal	80 <sys_exit>
    while (1)
    43fa:	a001                	j	43fa <exit+0x34>

00000000000043fc <abort>:
{
    43fc:	1141                	addi	sp,sp,-16
    exit(127);
    43fe:	07f00513          	li	a0,127
{
    4402:	e406                	sd	ra,8(sp)
    exit(127);
    4404:	fc3ff0ef          	jal	43c6 <exit>

0000000000004408 <getenv>:
}
    4408:	4501                	li	a0,0
    440a:	8082                	ret

000000000000440c <system>:
}
    440c:	557d                	li	a0,-1
    440e:	8082                	ret

0000000000004410 <free>:
    if (!ptr)
    4410:	c121                	beqz	a0,4450 <free+0x40>
    for (p = freep; !(bp > p && bp < p->next); p = p->next)
    4412:	00003617          	auipc	a2,0x3
    4416:	2ae60613          	addi	a2,a2,686 # 76c0 <errno>
    441a:	10863783          	ld	a5,264(a2)
    bp = (header_t *)ptr - 1;
    441e:	ff050693          	addi	a3,a0,-16
        if (p >= p->next && (bp > p || bp < p->next))
    4422:	6798                	ld	a4,8(a5)
    for (p = freep; !(bp > p && bp < p->next); p = p->next)
    4424:	02d7f763          	bgeu	a5,a3,4452 <free+0x42>
    4428:	00e6e463          	bltu	a3,a4,4430 <free+0x20>
        if (p >= p->next && (bp > p || bp < p->next))
    442c:	02e7e763          	bltu	a5,a4,445a <free+0x4a>
    if ((char *)bp + bp->size == (char *)p->next)
    4430:	ff053583          	ld	a1,-16(a0)
    4434:	00b68833          	add	a6,a3,a1
    4438:	03070363          	beq	a4,a6,445e <free+0x4e>
    if ((char *)p + p->size == (char *)bp)
    443c:	638c                	ld	a1,0(a5)
    443e:	fee53c23          	sd	a4,-8(a0)
    4442:	00b78833          	add	a6,a5,a1
    4446:	03068963          	beq	a3,a6,4478 <free+0x68>
    444a:	e794                	sd	a3,8(a5)
    freep = p;
    444c:	10f63423          	sd	a5,264(a2)
}
    4450:	8082                	ret
        if (p >= p->next && (bp > p || bp < p->next))
    4452:	00e7e463          	bltu	a5,a4,445a <free+0x4a>
    4456:	fce6ede3          	bltu	a3,a4,4430 <free+0x20>
{
    445a:	87ba                	mv	a5,a4
    445c:	b7d9                	j	4422 <free+0x12>
        bp->size += p->next->size;
    445e:	00073803          	ld	a6,0(a4)
        bp->next = p->next->next;
    4462:	6718                	ld	a4,8(a4)
        bp->size += p->next->size;
    4464:	95c2                	add	a1,a1,a6
    4466:	feb53823          	sd	a1,-16(a0)
    if ((char *)p + p->size == (char *)bp)
    446a:	638c                	ld	a1,0(a5)
    446c:	fee53c23          	sd	a4,-8(a0)
    4470:	00b78833          	add	a6,a5,a1
    4474:	fd069be3          	bne	a3,a6,444a <free+0x3a>
        p->size += bp->size;
    4478:	ff053503          	ld	a0,-16(a0)
        p->next = bp->next;
    447c:	86ba                	mv	a3,a4
        p->size += bp->size;
    447e:	00b50733          	add	a4,a0,a1
    4482:	e398                	sd	a4,0(a5)
        p->next = bp->next;
    4484:	b7d9                	j	444a <free+0x3a>

0000000000004486 <malloc>:
    if (size == 0)
    4486:	c169                	beqz	a0,4548 <malloc+0xc2>
{
    4488:	7179                	addi	sp,sp,-48
    448a:	ec26                	sd	s1,24(sp)
    if ((prevp = freep) == NULL)
    448c:	00003497          	auipc	s1,0x3
    4490:	23448493          	addi	s1,s1,564 # 76c0 <errno>
    4494:	1084b783          	ld	a5,264(s1)
{
    4498:	f022                	sd	s0,32(sp)
    size = ALIGN(size + sizeof(header_t));
    449a:	057d                	addi	a0,a0,31
{
    449c:	f406                	sd	ra,40(sp)
    size = ALIGN(size + sizeof(header_t));
    449e:	ff057413          	andi	s0,a0,-16
    if ((prevp = freep) == NULL)
    44a2:	c3d1                	beqz	a5,4526 <malloc+0xa0>
    for (p = prevp->next;; prevp = p, p = p->next)
    44a4:	6788                	ld	a0,8(a5)
        if (p->size >= size)
    44a6:	6118                	ld	a4,0(a0)
    44a8:	06877163          	bgeu	a4,s0,450a <malloc+0x84>
    44ac:	e44e                	sd	s3,8(sp)
    44ae:	e052                	sd	s4,0(sp)
    44b0:	e84a                	sd	s2,16(sp)
    if (nu < 4096)
    44b2:	6a05                	lui	s4,0x1
    if (cp == (void *)-1)
    44b4:	59fd                	li	s3,-1
    44b6:	a029                	j	44c0 <malloc+0x3a>
    for (p = prevp->next;; prevp = p, p = p->next)
    44b8:	6788                	ld	a0,8(a5)
        if (p->size >= size)
    44ba:	6118                	ld	a4,0(a0)
    44bc:	04877463          	bgeu	a4,s0,4504 <malloc+0x7e>
        if (p == freep)
    44c0:	1084b703          	ld	a4,264(s1)
    44c4:	87aa                	mv	a5,a0
    44c6:	fee519e3          	bne	a0,a4,44b8 <malloc+0x32>
    if (nu < 4096)
    44ca:	8922                	mv	s2,s0
    44cc:	01447363          	bgeu	s0,s4,44d2 <malloc+0x4c>
    44d0:	6905                	lui	s2,0x1
    cp = (char *)sbrk(nu);
    44d2:	854a                	mv	a0,s2
    44d4:	c3dfb0ef          	jal	110 <sbrk>
    44d8:	87aa                	mv	a5,a0
    free((void *)(up + 1));
    44da:	0541                	addi	a0,a0,16
    if (cp == (void *)-1)
    44dc:	01378963          	beq	a5,s3,44ee <malloc+0x68>
    up->size = nu;
    44e0:	0127b023          	sd	s2,0(a5)
    free((void *)(up + 1));
    44e4:	f2dff0ef          	jal	4410 <free>
    return freep;
    44e8:	1084b783          	ld	a5,264(s1)
            if ((p = morecore(size)) == NULL)
    44ec:	f7f1                	bnez	a5,44b8 <malloc+0x32>
}
    44ee:	70a2                	ld	ra,40(sp)
    44f0:	7402                	ld	s0,32(sp)
                errno = ENOMEM;
    44f2:	47b1                	li	a5,12
    44f4:	c09c                	sw	a5,0(s1)
                return NULL;
    44f6:	6942                	ld	s2,16(sp)
    44f8:	69a2                	ld	s3,8(sp)
    44fa:	6a02                	ld	s4,0(sp)
}
    44fc:	64e2                	ld	s1,24(sp)
        return NULL;
    44fe:	4501                	li	a0,0
}
    4500:	6145                	addi	sp,sp,48
    4502:	8082                	ret
    4504:	6942                	ld	s2,16(sp)
    4506:	69a2                	ld	s3,8(sp)
    4508:	6a02                	ld	s4,0(sp)
            if (p->size == size)
    450a:	02e40c63          	beq	s0,a4,4542 <malloc+0xbc>
                p->size -= size;
    450e:	8f01                	sub	a4,a4,s0
    4510:	e118                	sd	a4,0(a0)
                p = (header_t *)((char *)p + p->size);
    4512:	953a                	add	a0,a0,a4
                p->size = size;
    4514:	e100                	sd	s0,0(a0)
}
    4516:	70a2                	ld	ra,40(sp)
    4518:	7402                	ld	s0,32(sp)
            freep = prevp;
    451a:	10f4b423          	sd	a5,264(s1)
            return (void *)(p + 1);
    451e:	0541                	addi	a0,a0,16
}
    4520:	64e2                	ld	s1,24(sp)
    4522:	6145                	addi	sp,sp,48
    4524:	8082                	ret
        base.next = freep = prevp = &base;
    4526:	00003517          	auipc	a0,0x3
    452a:	2aa50513          	addi	a0,a0,682 # 77d0 <base>
    452e:	10a4b423          	sd	a0,264(s1)
    4532:	10a4bc23          	sd	a0,280(s1)
        base.size = 0;
    4536:	00003797          	auipc	a5,0x3
    453a:	2807bd23          	sd	zero,666(a5) # 77d0 <base>
        if (p->size >= size)
    453e:	f43d                	bnez	s0,44ac <malloc+0x26>
        base.next = freep = prevp = &base;
    4540:	87aa                	mv	a5,a0
                prevp->next = p->next;
    4542:	6518                	ld	a4,8(a0)
    4544:	e798                	sd	a4,8(a5)
    4546:	bfc1                	j	4516 <malloc+0x90>
        return NULL;
    4548:	4501                	li	a0,0
}
    454a:	8082                	ret

000000000000454c <calloc>:
    if (__builtin_mul_overflow(nmemb, size, &total))
    454c:	02b537b3          	mulhu	a5,a0,a1
{
    4550:	1101                	addi	sp,sp,-32
    4552:	e822                	sd	s0,16(sp)
    4554:	ec06                	sd	ra,24(sp)
    4556:	e426                	sd	s1,8(sp)
    if (__builtin_mul_overflow(nmemb, size, &total))
    4558:	02b50433          	mul	s0,a0,a1
    455c:	e385                	bnez	a5,457c <calloc+0x30>
    void *p = malloc(total);
    455e:	8522                	mv	a0,s0
    4560:	f27ff0ef          	jal	4486 <malloc>
    4564:	84aa                	mv	s1,a0
    if (p)
    4566:	c509                	beqz	a0,4570 <calloc+0x24>
        memset(p, 0, total);
    4568:	8622                	mv	a2,s0
    456a:	4581                	li	a1,0
    456c:	524000ef          	jal	4a90 <memset>
}
    4570:	60e2                	ld	ra,24(sp)
    4572:	6442                	ld	s0,16(sp)
    4574:	8526                	mv	a0,s1
    4576:	64a2                	ld	s1,8(sp)
    4578:	6105                	addi	sp,sp,32
    457a:	8082                	ret
    457c:	60e2                	ld	ra,24(sp)
    457e:	6442                	ld	s0,16(sp)
        errno = ENOMEM;
    4580:	47b1                	li	a5,12
        return NULL;
    4582:	4481                	li	s1,0
        errno = ENOMEM;
    4584:	00003717          	auipc	a4,0x3
    4588:	12f72e23          	sw	a5,316(a4) # 76c0 <errno>
}
    458c:	8526                	mv	a0,s1
    458e:	64a2                	ld	s1,8(sp)
    4590:	6105                	addi	sp,sp,32
    4592:	8082                	ret

0000000000004594 <realloc>:
    if (!ptr)
    4594:	c929                	beqz	a0,45e6 <realloc+0x52>
{
    4596:	1101                	addi	sp,sp,-32
    4598:	ec06                	sd	ra,24(sp)
    459a:	e426                	sd	s1,8(sp)
    if (size == 0)
    459c:	c5b9                	beqz	a1,45ea <realloc+0x56>
    if (bp->size >= new_size)
    459e:	ff053703          	ld	a4,-16(a0)
    size_t new_size = ALIGN(size + sizeof(header_t));
    45a2:	01f58793          	addi	a5,a1,31
    45a6:	e822                	sd	s0,16(sp)
    45a8:	9bc1                	andi	a5,a5,-16
    45aa:	842a                	mv	s0,a0
        return ptr;
    45ac:	84aa                	mv	s1,a0
    if (bp->size >= new_size)
    45ae:	00f76863          	bltu	a4,a5,45be <realloc+0x2a>
    45b2:	6442                	ld	s0,16(sp)
}
    45b4:	60e2                	ld	ra,24(sp)
    45b6:	8526                	mv	a0,s1
    45b8:	64a2                	ld	s1,8(sp)
    45ba:	6105                	addi	sp,sp,32
    45bc:	8082                	ret
    void *new_ptr = malloc(size);
    45be:	852e                	mv	a0,a1
    45c0:	ec7ff0ef          	jal	4486 <malloc>
    45c4:	84aa                	mv	s1,a0
    if (!new_ptr)
    45c6:	d575                	beqz	a0,45b2 <realloc+0x1e>
    memcpy(new_ptr, ptr, bp->size - sizeof(header_t));
    45c8:	ff043603          	ld	a2,-16(s0)
    45cc:	85a2                	mv	a1,s0
    45ce:	1641                	addi	a2,a2,-16
    45d0:	514000ef          	jal	4ae4 <memcpy>
    free(ptr);
    45d4:	8522                	mv	a0,s0
    45d6:	e3bff0ef          	jal	4410 <free>
}
    45da:	60e2                	ld	ra,24(sp)
    free(ptr);
    45dc:	6442                	ld	s0,16(sp)
}
    45de:	8526                	mv	a0,s1
    45e0:	64a2                	ld	s1,8(sp)
    45e2:	6105                	addi	sp,sp,32
    45e4:	8082                	ret
        return malloc(size);
    45e6:	852e                	mv	a0,a1
    45e8:	bd79                	j	4486 <malloc>
        free(ptr);
    45ea:	e27ff0ef          	jal	4410 <free>
        return NULL;
    45ee:	4481                	li	s1,0
    45f0:	b7d1                	j	45b4 <realloc+0x20>

00000000000045f2 <strtoull>:
    if (base < 0 || base == 1 || base > 36)
    45f2:	02400813          	li	a6,36
{
    45f6:	86aa                	mv	a3,a0
    45f8:	872e                	mv	a4,a1
    if (base < 0 || base == 1 || base > 36)
    45fa:	00c86663          	bltu	a6,a2,4606 <strtoull+0x14>
    45fe:	4805                	li	a6,1
    4600:	01060363          	beq	a2,a6,4606 <strtoull+0x14>
    4604:	b939                	j	4222 <strtoull.part.0>
        if (endptr)
    4606:	c311                	beqz	a4,460a <strtoull+0x18>
            *endptr = (char *)nptr;
    4608:	e314                	sd	a3,0(a4)
        errno = 0; /* EINVAL */
    460a:	00003797          	auipc	a5,0x3
    460e:	0a07ab23          	sw	zero,182(a5) # 76c0 <errno>
}
    4612:	4501                	li	a0,0
    4614:	8082                	ret

0000000000004616 <strtoll>:

long long strtoll(const char *nptr, char **endptr, int base)
{
    4616:	1141                	addi	sp,sp,-16
    4618:	e406                	sd	ra,8(sp)
    461a:	e022                	sd	s0,0(sp)
    const char *s = nptr;
    461c:	86aa                	mv	a3,a0
    static inline int isspace(int c) { return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r'; }
    461e:	02000813          	li	a6,32
    4622:	4891                	li	a7,4
    unsigned long long acc;
    int c, neg = 0;

    do
    {
        c = *s++;
    4624:	0006c783          	lbu	a5,0(a3)
    4628:	0685                	addi	a3,a3,1
    462a:	ff77871b          	addiw	a4,a5,-9
    462e:	0ff77713          	zext.b	a4,a4
    4632:	0007841b          	sext.w	s0,a5
    4636:	ff0787e3          	beq	a5,a6,4624 <strtoll+0xe>
    463a:	fee8f5e3          	bgeu	a7,a4,4624 <strtoll+0xe>
    if (base < 0 || base == 1 || base > 36)
    463e:	02400793          	li	a5,36
    4642:	02c7ec63          	bltu	a5,a2,467a <strtoll+0x64>
    4646:	4785                	li	a5,1
    4648:	02f60963          	beq	a2,a5,467a <strtoll+0x64>
    464c:	bd7ff0ef          	jal	4222 <strtoull.part.0>
    if (c == '-')
        neg = 1;

    acc = strtoull(nptr, endptr, base);

    if (errno == ERANGE && acc == ULLONG_MAX)
    4650:	00003797          	auipc	a5,0x3
    4654:	07078793          	addi	a5,a5,112 # 76c0 <errno>
    4658:	4394                	lw	a3,0(a5)
    465a:	02200713          	li	a4,34
    465e:	04e68363          	beq	a3,a4,46a4 <strtoll+0x8e>
        return neg ? LLONG_MIN : LLONG_MAX;

    if (!neg && acc > (unsigned long long)LLONG_MAX)
    4662:	02d00713          	li	a4,45
    4666:	02e40563          	beq	s0,a4,4690 <strtoll+0x7a>
    466a:	00055f63          	bgez	a0,4688 <strtoll+0x72>
    {
        errno = ERANGE;
    466e:	02200713          	li	a4,34
    4672:	c398                	sw	a4,0(a5)
        return neg ? LLONG_MIN : LLONG_MAX;
    4674:	557d                	li	a0,-1
    4676:	8105                	srli	a0,a0,0x1
    4678:	a801                	j	4688 <strtoll+0x72>
        if (endptr)
    467a:	c191                	beqz	a1,467e <strtoll+0x68>
            *endptr = (char *)nptr;
    467c:	e188                	sd	a0,0(a1)
        errno = 0; /* EINVAL */
    467e:	00003797          	auipc	a5,0x3
    4682:	0407a123          	sw	zero,66(a5) # 76c0 <errno>
    {
        errno = ERANGE;
        return LLONG_MIN;
    }

    return neg ? -(long long)acc : (long long)acc;
    4686:	4501                	li	a0,0
}
    4688:	60a2                	ld	ra,8(sp)
    468a:	6402                	ld	s0,0(sp)
    468c:	0141                	addi	sp,sp,16
    468e:	8082                	ret
    if (neg && acc > (unsigned long long)LLONG_MAX + 1)
    4690:	577d                	li	a4,-1
    4692:	177e                	slli	a4,a4,0x3f
    4694:	02a76263          	bltu	a4,a0,46b8 <strtoll+0xa2>
}
    4698:	60a2                	ld	ra,8(sp)
    469a:	6402                	ld	s0,0(sp)
    return neg ? -(long long)acc : (long long)acc;
    469c:	40a00533          	neg	a0,a0
}
    46a0:	0141                	addi	sp,sp,16
    46a2:	8082                	ret
    if (errno == ERANGE && acc == ULLONG_MAX)
    46a4:	577d                	li	a4,-1
    46a6:	fae51ee3          	bne	a0,a4,4662 <strtoll+0x4c>
        return neg ? LLONG_MIN : LLONG_MAX;
    46aa:	02d00793          	li	a5,45
    46ae:	fcf413e3          	bne	s0,a5,4674 <strtoll+0x5e>
        return LLONG_MIN;
    46b2:	557d                	li	a0,-1
    46b4:	157e                	slli	a0,a0,0x3f
    46b6:	bfc9                	j	4688 <strtoll+0x72>
        errno = ERANGE;
    46b8:	02200713          	li	a4,34
    46bc:	c398                	sw	a4,0(a5)
        return LLONG_MIN;
    46be:	bfd5                	j	46b2 <strtoll+0x9c>

00000000000046c0 <strtoul>:
    if (base < 0 || base == 1 || base > 36)
    46c0:	02400813          	li	a6,36

unsigned long strtoul(const char *nptr, char **endptr, int base)
{
    46c4:	86aa                	mv	a3,a0
    46c6:	872e                	mv	a4,a1
    if (base < 0 || base == 1 || base > 36)
    46c8:	00c86663          	bltu	a6,a2,46d4 <strtoul+0x14>
    46cc:	4805                	li	a6,1
    46ce:	01060363          	beq	a2,a6,46d4 <strtoul+0x14>
    46d2:	be81                	j	4222 <strtoull.part.0>
        if (endptr)
    46d4:	c311                	beqz	a4,46d8 <strtoul+0x18>
            *endptr = (char *)nptr;
    46d6:	e314                	sd	a3,0(a4)
        errno = 0; /* EINVAL */
    46d8:	00003797          	auipc	a5,0x3
    46dc:	fe07a423          	sw	zero,-24(a5) # 76c0 <errno>
    {
        errno = ERANGE;
        return ULONG_MAX;
    }
    return (unsigned long)ret;
}
    46e0:	4501                	li	a0,0
    46e2:	8082                	ret

00000000000046e4 <strtol>:

long strtol(const char *nptr, char **endptr, int base)
{
    long long ret = strtoll(nptr, endptr, base);
    46e4:	bf0d                	j	4616 <strtoll>

00000000000046e6 <atoi>:
        return LONG_MIN;
    }
    return (long)ret;
}

int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    46e6:	1141                	addi	sp,sp,-16
    long long ret = strtoll(nptr, endptr, base);
    46e8:	4629                	li	a2,10
    46ea:	4581                	li	a1,0
int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    46ec:	e406                	sd	ra,8(sp)
    long long ret = strtoll(nptr, endptr, base);
    46ee:	f29ff0ef          	jal	4616 <strtoll>
int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    46f2:	60a2                	ld	ra,8(sp)
    46f4:	2501                	sext.w	a0,a0
    46f6:	0141                	addi	sp,sp,16
    46f8:	8082                	ret

00000000000046fa <atol>:
    long long ret = strtoll(nptr, endptr, base);
    46fa:	4629                	li	a2,10
    46fc:	4581                	li	a1,0
    46fe:	bf21                	j	4616 <strtoll>

0000000000004700 <atoll>:
long atol(const char *nptr) { return strtol(nptr, NULL, 10); }
long long atoll(const char *nptr) { return strtoll(nptr, NULL, 10); }
    4700:	4629                	li	a2,10
    4702:	4581                	li	a1,0
    4704:	bf09                	j	4616 <strtoll>

0000000000004706 <strtod>:
    4706:	02000693          	li	a3,32
    470a:	4611                	li	a2,4
{
    double val = 0.0;
    int sign = 1;
    const char *s = nptr;

    while (isspace(*s))
    470c:	00054783          	lbu	a5,0(a0)
    4710:	ff77871b          	addiw	a4,a5,-9
    4714:	0ff77713          	zext.b	a4,a4
    4718:	06d78263          	beq	a5,a3,477c <strtod+0x76>
    471c:	06e67063          	bgeu	a2,a4,477c <strtod+0x76>
        s++;
    if (*s == '-')
    4720:	02d00713          	li	a4,45
    4724:	08e78e63          	beq	a5,a4,47c0 <strtod+0xba>
    {
        sign = -1;
        s++;
    }
    else if (*s == '+')
    4728:	02b00713          	li	a4,43
    472c:	0ae78263          	beq	a5,a4,47d0 <strtod+0xca>
    4730:	00001717          	auipc	a4,0x1
    4734:	0a073507          	fld	fa0,160(a4) # 57d0 <STDIN_FD+0x10>
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    4738:	fd07861b          	addiw	a2,a5,-48
        s++;

    while (isdigit(*s))
    473c:	46a5                	li	a3,9
    473e:	f20007d3          	fmv.d.x	fa5,zero
    4742:	8732                	mv	a4,a2
    4744:	02c6e363          	bltu	a3,a2,476a <strtod+0x64>
    4748:	00001797          	auipc	a5,0x1
    474c:	0907b687          	fld	fa3,144(a5) # 57d8 <STDIN_FD+0x18>
    4750:	4625                	li	a2,9
    4752:	00154783          	lbu	a5,1(a0)
    {
        val = val * 10.0 + (*s - '0');
    4756:	d2070753          	fcvt.d.w	fa4,a4
        s++;
    475a:	0505                	addi	a0,a0,1
    475c:	fd07869b          	addiw	a3,a5,-48
        val = val * 10.0 + (*s - '0');
    4760:	72d7f7c3          	fmadd.d	fa5,fa5,fa3,fa4
    4764:	8736                	mv	a4,a3
    while (isdigit(*s))
    4766:	fed676e3          	bgeu	a2,a3,4752 <strtod+0x4c>
    }
    if (*s == '.')
    476a:	02e00713          	li	a4,46
    476e:	00e78963          	beq	a5,a4,4780 <strtod+0x7a>
            val += (*s - '0') * factor;
            s++;
        }
    }

    if (endptr)
    4772:	c191                	beqz	a1,4776 <strtod+0x70>
        *endptr = (char *)s;
    4774:	e188                	sd	a0,0(a1)
    return val * sign;
}
    4776:	12a7f553          	fmul.d	fa0,fa5,fa0
    477a:	8082                	ret
        s++;
    477c:	0505                	addi	a0,a0,1
    477e:	b779                	j	470c <strtod+0x6>
        while (isdigit(*s))
    4780:	00154703          	lbu	a4,1(a0)
    4784:	46a5                	li	a3,9
        s++;
    4786:	0505                	addi	a0,a0,1
    4788:	fd07071b          	addiw	a4,a4,-48
    478c:	87ba                	mv	a5,a4
        while (isdigit(*s))
    478e:	fee6e2e3          	bltu	a3,a4,4772 <strtod+0x6c>
        double factor = 1.0;
    4792:	00001717          	auipc	a4,0x1
    4796:	03e73707          	fld	fa4,62(a4) # 57d0 <STDIN_FD+0x10>
    479a:	00001717          	auipc	a4,0x1
    479e:	05673607          	fld	fa2,86(a4) # 57f0 <STDIN_FD+0x30>
            factor *= 0.1;
    47a2:	12c77753          	fmul.d	fa4,fa4,fa2
        while (isdigit(*s))
    47a6:	00154703          	lbu	a4,1(a0)
            val += (*s - '0') * factor;
    47aa:	d20786d3          	fcvt.d.w	fa3,a5
            s++;
    47ae:	0505                	addi	a0,a0,1
    47b0:	fd07071b          	addiw	a4,a4,-48
    47b4:	87ba                	mv	a5,a4
            val += (*s - '0') * factor;
    47b6:	7ae6f7c3          	fmadd.d	fa5,fa3,fa4,fa5
        while (isdigit(*s))
    47ba:	fee6f4e3          	bgeu	a3,a4,47a2 <strtod+0x9c>
    47be:	bf55                	j	4772 <strtod+0x6c>
    while (isdigit(*s))
    47c0:	00154783          	lbu	a5,1(a0)
    47c4:	00001717          	auipc	a4,0x1
    47c8:	00473507          	fld	fa0,4(a4) # 57c8 <STDIN_FD+0x8>
        s++;
    47cc:	0505                	addi	a0,a0,1
    47ce:	b7ad                	j	4738 <strtod+0x32>
    while (isdigit(*s))
    47d0:	00154783          	lbu	a5,1(a0)
    47d4:	00001717          	auipc	a4,0x1
    47d8:	ffc73507          	fld	fa0,-4(a4) # 57d0 <STDIN_FD+0x10>
        s++;
    47dc:	0505                	addi	a0,a0,1
    47de:	bfa9                	j	4738 <strtod+0x32>

00000000000047e0 <atof>:

double atof(const char *nptr) { return strtod(nptr, NULL); }
    47e0:	4581                	li	a1,0
    47e2:	b715                	j	4706 <strtod>

00000000000047e4 <strtof>:
float strtof(const char *nptr, char **endptr) { return (float)strtod(nptr, endptr); }
    47e4:	1141                	addi	sp,sp,-16
    47e6:	e406                	sd	ra,8(sp)
    47e8:	f1fff0ef          	jal	4706 <strtod>
    47ec:	60a2                	ld	ra,8(sp)
    47ee:	40157553          	fcvt.s.d	fa0,fa0
    47f2:	0141                	addi	sp,sp,16
    47f4:	8082                	ret

00000000000047f6 <qsort>:
    }
}

void qsort(void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *))
{
    if (nmemb < 2 || size == 0)
    47f6:	4785                	li	a5,1
    47f8:	0cb7fd63          	bgeu	a5,a1,48d2 <qsort+0xdc>
{
    47fc:	715d                	addi	sp,sp,-80
    47fe:	f44e                	sd	s3,40(sp)
    4800:	e486                	sd	ra,72(sp)
    4802:	89b2                	mv	s3,a2
    if (nmemb < 2 || size == 0)
    4804:	c279                	beqz	a2,48ca <qsort+0xd4>
    4806:	e85a                	sd	s6,16(sp)
    4808:	8b2e                	mv	s6,a1
        return;

    char *base_ptr = (char *)base;
    char *pivot = base_ptr + (nmemb - 1) * size;
    480a:	1b7d                	addi	s6,s6,-1
    480c:	fc26                	sd	s1,56(sp)
    480e:	033b04b3          	mul	s1,s6,s3
    4812:	ec56                	sd	s5,24(sp)
    4814:	8aaa                	mv	s5,a0
    4816:	f052                	sd	s4,32(sp)
    4818:	e45e                	sd	s7,8(sp)
    481a:	e0a2                	sd	s0,64(sp)
    481c:	f84a                	sd	s2,48(sp)
    481e:	8a36                	mv	s4,a3
    if (nmemb < 2 || size == 0)
    4820:	4b85                	li	s7,1
    char *pivot = base_ptr + (nmemb - 1) * size;
    4822:	94d6                	add	s1,s1,s5
    char *i = base_ptr;
    char *j = base_ptr;

    /* Partition */
    for (; j < pivot; j += size)
    4824:	069af763          	bgeu	s5,s1,4892 <qsort+0x9c>
    char *j = base_ptr;
    4828:	8956                	mv	s2,s5
    char *i = base_ptr;
    482a:	8456                	mv	s0,s5
    482c:	a021                	j	4834 <qsort+0x3e>
    for (; j < pivot; j += size)
    482e:	994e                	add	s2,s2,s3
    4830:	00997f63          	bgeu	s2,s1,484e <qsort+0x58>
    {
        if (compar(j, pivot) < 0)
    4834:	85a6                	mv	a1,s1
    4836:	854a                	mv	a0,s2
    4838:	9a02                	jalr	s4
    483a:	fe055ae3          	bgez	a0,482e <qsort+0x38>
        {
            if (i != j)
    483e:	05241d63          	bne	s0,s2,4898 <qsort+0xa2>
    4842:	01390633          	add	a2,s2,s3
                swap_bytes(i, j, size);
            i += size;
    4846:	8432                	mv	s0,a2
    for (; j < pivot; j += size)
    4848:	994e                	add	s2,s2,s3
    484a:	fe9965e3          	bltu	s2,s1,4834 <qsort+0x3e>
        }
    }
    swap_bytes(i, pivot, size);

    /* Recurse */
    size_t left_count = (i - base_ptr) / size;
    484e:	415405b3          	sub	a1,s0,s5
    4852:	0335d5b3          	divu	a1,a1,s3
    qsort(base, left_count, size, compar);
    qsort(i + size, nmemb - left_count - 1, size, compar);
    4856:	40bb0b33          	sub	s6,s6,a1
    while (size--)
    485a:	013406b3          	add	a3,s0,s3
        *a++ = *b;
    485e:	0004c703          	lbu	a4,0(s1)
        temp = *a;
    4862:	00044783          	lbu	a5,0(s0)
        *b++ = temp;
    4866:	0485                	addi	s1,s1,1
        *a++ = *b;
    4868:	0405                	addi	s0,s0,1
    486a:	fee40fa3          	sb	a4,-1(s0)
        *b++ = temp;
    486e:	fef48fa3          	sb	a5,-1(s1)
    while (size--)
    4872:	fed416e3          	bne	s0,a3,485e <qsort+0x68>
    qsort(base, left_count, size, compar);
    4876:	86d2                	mv	a3,s4
    4878:	864e                	mv	a2,s3
    487a:	8556                	mv	a0,s5
    487c:	f7bff0ef          	jal	47f6 <qsort>
    if (nmemb < 2 || size == 0)
    4880:	036bfe63          	bgeu	s7,s6,48bc <qsort+0xc6>
    char *pivot = base_ptr + (nmemb - 1) * size;
    4884:	1b7d                	addi	s6,s6,-1
    4886:	033b04b3          	mul	s1,s6,s3
    488a:	8aa2                	mv	s5,s0
    488c:	94d6                	add	s1,s1,s5
    for (; j < pivot; j += size)
    488e:	f89aede3          	bltu	s5,s1,4828 <qsort+0x32>
    char *i = base_ptr;
    4892:	8456                	mv	s0,s5
    for (; j < pivot; j += size)
    4894:	4581                	li	a1,0
    4896:	b7d1                	j	485a <qsort+0x64>
    4898:	01340633          	add	a2,s0,s3
            if (i != j)
    489c:	874a                	mv	a4,s2
    489e:	87a2                	mv	a5,s0
        *a++ = *b;
    48a0:	00074683          	lbu	a3,0(a4)
        temp = *a;
    48a4:	0007c803          	lbu	a6,0(a5)
        *b++ = temp;
    48a8:	0705                	addi	a4,a4,1
        *a++ = *b;
    48aa:	0785                	addi	a5,a5,1
    48ac:	fed78fa3          	sb	a3,-1(a5)
        *b++ = temp;
    48b0:	ff070fa3          	sb	a6,-1(a4)
    while (size--)
    48b4:	fec796e3          	bne	a5,a2,48a0 <qsort+0xaa>
            i += size;
    48b8:	8432                	mv	s0,a2
    48ba:	b779                	j	4848 <qsort+0x52>
    48bc:	6406                	ld	s0,64(sp)
    48be:	74e2                	ld	s1,56(sp)
    48c0:	7942                	ld	s2,48(sp)
    48c2:	7a02                	ld	s4,32(sp)
    48c4:	6ae2                	ld	s5,24(sp)
    48c6:	6b42                	ld	s6,16(sp)
    48c8:	6ba2                	ld	s7,8(sp)
}
    48ca:	60a6                	ld	ra,72(sp)
    48cc:	79a2                	ld	s3,40(sp)
    48ce:	6161                	addi	sp,sp,80
    48d0:	8082                	ret
    48d2:	8082                	ret

00000000000048d4 <bsearch>:

void *bsearch(const void *key, const void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *))
{
    48d4:	715d                	addi	sp,sp,-80
    48d6:	e486                	sd	ra,72(sp)
    48d8:	fc26                	sd	s1,56(sp)
    size_t l = 0, u = nmemb;
    while (l < u)
    48da:	c629                	beqz	a2,4924 <bsearch+0x50>
    48dc:	f84a                	sd	s2,48(sp)
    48de:	f44e                	sd	s3,40(sp)
    48e0:	f052                	sd	s4,32(sp)
    48e2:	ec56                	sd	s5,24(sp)
    48e4:	e85a                	sd	s6,16(sp)
    48e6:	e45e                	sd	s7,8(sp)
    48e8:	e0a2                	sd	s0,64(sp)
    48ea:	8932                	mv	s2,a2
    48ec:	8a2a                	mv	s4,a0
    48ee:	8aae                	mv	s5,a1
    48f0:	8b36                	mv	s6,a3
    48f2:	8bba                	mv	s7,a4
    size_t l = 0, u = nmemb;
    48f4:	4981                	li	s3,0
    {
        size_t idx = (l + u) / 2;
    48f6:	01298433          	add	s0,s3,s2
    48fa:	8005                	srli	s0,s0,0x1
        const void *p = (void *)((const char *)base + (idx * size));
    48fc:	036404b3          	mul	s1,s0,s6
        int cmp = compar(key, p);
    4900:	8552                	mv	a0,s4
        const void *p = (void *)((const char *)base + (idx * size));
    4902:	94d6                	add	s1,s1,s5
        int cmp = compar(key, p);
    4904:	85a6                	mv	a1,s1
    4906:	9b82                	jalr	s7
        if (cmp < 0)
    4908:	02054463          	bltz	a0,4930 <bsearch+0x5c>
            u = idx;
        else if (cmp > 0)
    490c:	c515                	beqz	a0,4938 <bsearch+0x64>
            l = idx + 1;
    490e:	00140993          	addi	s3,s0,1
    while (l < u)
    4912:	ff29e2e3          	bltu	s3,s2,48f6 <bsearch+0x22>
    4916:	6406                	ld	s0,64(sp)
    4918:	7942                	ld	s2,48(sp)
    491a:	79a2                	ld	s3,40(sp)
    491c:	7a02                	ld	s4,32(sp)
    491e:	6ae2                	ld	s5,24(sp)
    4920:	6b42                	ld	s6,16(sp)
    4922:	6ba2                	ld	s7,8(sp)
        else
            return (void *)p;
    }
    return NULL;
}
    4924:	60a6                	ld	ra,72(sp)
    return NULL;
    4926:	4481                	li	s1,0
}
    4928:	8526                	mv	a0,s1
    492a:	74e2                	ld	s1,56(sp)
    492c:	6161                	addi	sp,sp,80
    492e:	8082                	ret
            u = idx;
    4930:	8922                	mv	s2,s0
    while (l < u)
    4932:	fd29e2e3          	bltu	s3,s2,48f6 <bsearch+0x22>
    4936:	b7c5                	j	4916 <bsearch+0x42>
    4938:	6406                	ld	s0,64(sp)
}
    493a:	60a6                	ld	ra,72(sp)
    493c:	7942                	ld	s2,48(sp)
    493e:	79a2                	ld	s3,40(sp)
    4940:	7a02                	ld	s4,32(sp)
    4942:	6ae2                	ld	s5,24(sp)
    4944:	6b42                	ld	s6,16(sp)
    4946:	6ba2                	ld	s7,8(sp)
    4948:	8526                	mv	a0,s1
    494a:	74e2                	ld	s1,56(sp)
    494c:	6161                	addi	sp,sp,80
    494e:	8082                	ret

0000000000004950 <abs>:

/* Math & Mics */

int abs(int j) { return (j < 0) ? -j : j; }
    4950:	41f5579b          	sraiw	a5,a0,0x1f
    4954:	8d3d                	xor	a0,a0,a5
    4956:	9d1d                	subw	a0,a0,a5
    4958:	8082                	ret

000000000000495a <labs>:
long labs(long j) { return (j < 0) ? -j : j; }
    495a:	43f55793          	srai	a5,a0,0x3f
    495e:	8d3d                	xor	a0,a0,a5
    4960:	8d1d                	sub	a0,a0,a5
    4962:	8082                	ret

0000000000004964 <llabs>:
long long llabs(long long j) { return (j < 0) ? -j : j; }
    4964:	43f55793          	srai	a5,a0,0x3f
    4968:	8d3d                	xor	a0,a0,a5
    496a:	8d1d                	sub	a0,a0,a5
    496c:	8082                	ret

000000000000496e <div>:

div_t div(int numer, int denom)
{
    div_t res = {numer / denom, numer % denom};
    496e:	02b547bb          	divw	a5,a0,a1
{
    4972:	1141                	addi	sp,sp,-16
    return res;
}
    4974:	0141                	addi	sp,sp,16
    div_t res = {numer / denom, numer % denom};
    4976:	02b5653b          	remw	a0,a0,a1
    return res;
    497a:	1782                	slli	a5,a5,0x20
    497c:	9381                	srli	a5,a5,0x20
    497e:	1502                	slli	a0,a0,0x20
}
    4980:	8d5d                	or	a0,a0,a5
    4982:	8082                	ret

0000000000004984 <ldiv>:
ldiv_t ldiv(long numer, long denom)
{
    4984:	1141                	addi	sp,sp,-16
    4986:	87aa                	mv	a5,a0
    ldiv_t res = {numer / denom, numer % denom};
    return res;
}
    4988:	02b54533          	div	a0,a0,a1
    498c:	0141                	addi	sp,sp,16
    498e:	02b7e5b3          	rem	a1,a5,a1
    4992:	8082                	ret

0000000000004994 <lldiv>:
lldiv_t lldiv(long long numer, long long denom)
{
    4994:	1141                	addi	sp,sp,-16
    4996:	87aa                	mv	a5,a0
    lldiv_t res = {numer / denom, numer % denom};
    return res;
}
    4998:	02b54533          	div	a0,a0,a1
    499c:	0141                	addi	sp,sp,16
    499e:	02b7e5b3          	rem	a1,a5,a1
    49a2:	8082                	ret

00000000000049a4 <rand>:

static unsigned long next = 1;
int rand(void)
{
    next = next * 1103515245 + 12345;
    49a4:	00003697          	auipc	a3,0x3
    49a8:	cd468693          	addi	a3,a3,-812 # 7678 <next>
    49ac:	629c                	ld	a5,0(a3)
    49ae:	41c65737          	lui	a4,0x41c65
    49b2:	e6d70713          	addi	a4,a4,-403 # 41c64e6d <_ZSt4cerr+0x41c5d675>
    49b6:	02e787b3          	mul	a5,a5,a4
    49ba:	670d                	lui	a4,0x3
    49bc:	03970713          	addi	a4,a4,57 # 3039 <_vprintf_core.constprop.0.isra.0+0x25>
    49c0:	97ba                	add	a5,a5,a4
    return (unsigned int)(next / 65536) % 32768;
    49c2:	02179513          	slli	a0,a5,0x21
    next = next * 1103515245 + 12345;
    49c6:	e29c                	sd	a5,0(a3)
}
    49c8:	9145                	srli	a0,a0,0x31
    49ca:	8082                	ret

00000000000049cc <srand>:
void srand(unsigned int seed) { next = seed; }
    49cc:	1502                	slli	a0,a0,0x20
    49ce:	9101                	srli	a0,a0,0x20
    49d0:	00003797          	auipc	a5,0x3
    49d4:	caa7b423          	sd	a0,-856(a5) # 7678 <next>
    49d8:	8082                	ret

00000000000049da <mblen>:

/* Stub */
int mblen(const char *s, size_t n) { return (s && *s && n) ? 1 : 0; }
    49da:	c901                	beqz	a0,49ea <mblen+0x10>
    49dc:	00054783          	lbu	a5,0(a0)
    49e0:	4501                	li	a0,0
    49e2:	c789                	beqz	a5,49ec <mblen+0x12>
    49e4:	00b03533          	snez	a0,a1
    49e8:	8082                	ret
    49ea:	4501                	li	a0,0
    49ec:	8082                	ret

00000000000049ee <mbtowc>:
int mbtowc(wchar_t *pwc, const char *s, size_t n)
{
    49ee:	87aa                	mv	a5,a0
    if (!s)
    49f0:	cd81                	beqz	a1,4a08 <mbtowc+0x1a>
        return 0;
    if (n == 0)
        return -1;
    49f2:	557d                	li	a0,-1
    if (n == 0)
    49f4:	ca19                	beqz	a2,4a0a <mbtowc+0x1c>
    if (pwc)
    49f6:	c781                	beqz	a5,49fe <mbtowc+0x10>
        *pwc = (wchar_t)*s;
    49f8:	0005c703          	lbu	a4,0(a1)
    49fc:	c398                	sw	a4,0(a5)
    return (*s != 0);
    49fe:	0005c503          	lbu	a0,0(a1)
    4a02:	00a03533          	snez	a0,a0
    4a06:	8082                	ret
        return 0;
    4a08:	4501                	li	a0,0
}
    4a0a:	8082                	ret

0000000000004a0c <wctomb>:
int wctomb(char *s, wchar_t wchar)
{
    if (!s)
    4a0c:	c509                	beqz	a0,4a16 <wctomb+0xa>
        return 0;
    *s = (char)wchar;
    4a0e:	00b50023          	sb	a1,0(a0)
    return 1;
    4a12:	4505                	li	a0,1
    4a14:	8082                	ret
        return 0;
    4a16:	4501                	li	a0,0
}
    4a18:	8082                	ret

0000000000004a1a <mbstowcs>:
size_t mbstowcs(wchar_t *dest, const char *src, size_t n)
{
    size_t i = 0;
    while (src[i] && i < n)
    4a1a:	0005c703          	lbu	a4,0(a1)
    4a1e:	cb0d                	beqz	a4,4a50 <mbstowcs+0x36>
    4a20:	ca15                	beqz	a2,4a54 <mbstowcs+0x3a>
    4a22:	86aa                	mv	a3,a0
    size_t i = 0;
    4a24:	4781                	li	a5,0
    4a26:	a019                	j	4a2c <mbstowcs+0x12>
    while (src[i] && i < n)
    4a28:	02f60263          	beq	a2,a5,4a4c <mbstowcs+0x32>
    {
        dest[i] = (wchar_t)src[i];
        i++;
    4a2c:	0785                	addi	a5,a5,1
        dest[i] = (wchar_t)src[i];
    4a2e:	c298                	sw	a4,0(a3)
    while (src[i] && i < n)
    4a30:	00f58733          	add	a4,a1,a5
    4a34:	00074703          	lbu	a4,0(a4)
    4a38:	0691                	addi	a3,a3,4
    4a3a:	f77d                	bnez	a4,4a28 <mbstowcs+0xe>
    }
    if (i < n)
    4a3c:	00c7f763          	bgeu	a5,a2,4a4a <mbstowcs+0x30>
        dest[i] = 0;
    4a40:	00279713          	slli	a4,a5,0x2
    4a44:	953a                	add	a0,a0,a4
    4a46:	00052023          	sw	zero,0(a0)
    size_t i = 0;
    4a4a:	863e                	mv	a2,a5
    4a4c:	8532                	mv	a0,a2
    4a4e:	8082                	ret
    4a50:	4781                	li	a5,0
    4a52:	b7ed                	j	4a3c <mbstowcs+0x22>
    4a54:	4501                	li	a0,0
    return i;
}
    4a56:	8082                	ret

0000000000004a58 <wcstombs>:
size_t wcstombs(char *dest, const wchar_t *src, size_t n)
{
    size_t i = 0;
    while (src[i] && i < n)
    4a58:	4198                	lw	a4,0(a1)
    4a5a:	c71d                	beqz	a4,4a88 <wcstombs+0x30>
    4a5c:	ca05                	beqz	a2,4a8c <wcstombs+0x34>
    4a5e:	0591                	addi	a1,a1,4
    size_t i = 0;
    4a60:	4781                	li	a5,0
    4a62:	a019                	j	4a68 <wcstombs+0x10>
    while (src[i] && i < n)
    4a64:	02f60063          	beq	a2,a5,4a84 <wcstombs+0x2c>
    {
        dest[i] = (char)src[i];
    4a68:	00f506b3          	add	a3,a0,a5
    4a6c:	00e68023          	sb	a4,0(a3)
    while (src[i] && i < n)
    4a70:	4198                	lw	a4,0(a1)
        i++;
    4a72:	0785                	addi	a5,a5,1
    while (src[i] && i < n)
    4a74:	0591                	addi	a1,a1,4
    4a76:	f77d                	bnez	a4,4a64 <wcstombs+0xc>
    }
    if (i < n)
    4a78:	00c7f563          	bgeu	a5,a2,4a82 <wcstombs+0x2a>
        dest[i] = 0;
    4a7c:	953e                	add	a0,a0,a5
    4a7e:	00050023          	sb	zero,0(a0)
    size_t i = 0;
    4a82:	863e                	mv	a2,a5
    4a84:	8532                	mv	a0,a2
    4a86:	8082                	ret
    4a88:	4781                	li	a5,0
    4a8a:	b7fd                	j	4a78 <wcstombs+0x20>
    4a8c:	4501                	li	a0,0
    return i;
    4a8e:	8082                	ret

0000000000004a90 <memset>:

void *memset(void *dst, int c, size_t n)
{
    char *cdst = (char *)dst;
    for (size_t i = 0; i < n; i++)
        cdst[i] = (char)c;
    4a90:	0ff5f593          	zext.b	a1,a1
    4a94:	87aa                	mv	a5,a0
    4a96:	00a60733          	add	a4,a2,a0
    for (size_t i = 0; i < n; i++)
    4a9a:	c611                	beqz	a2,4aa6 <memset+0x16>
        cdst[i] = (char)c;
    4a9c:	00b78023          	sb	a1,0(a5)
    for (size_t i = 0; i < n; i++)
    4aa0:	0785                	addi	a5,a5,1
    4aa2:	fee79de3          	bne	a5,a4,4a9c <memset+0xc>
    return dst;
}
    4aa6:	8082                	ret

0000000000004aa8 <memmove>:

void *memmove(void *vdst, const void *vsrc, size_t n)
{
    char *dst = (char *)vdst;
    const char *src = (const char *)vsrc;
    if (dst == src)
    4aa8:	02b50d63          	beq	a0,a1,4ae2 <memmove+0x3a>
        return vdst;

    if (src > dst)
    4aac:	00b57e63          	bgeu	a0,a1,4ac8 <memmove+0x20>
    {
        while (n--)
    4ab0:	ca0d                	beqz	a2,4ae2 <memmove+0x3a>
    4ab2:	962a                	add	a2,a2,a0
    char *dst = (char *)vdst;
    4ab4:	87aa                	mv	a5,a0
            *dst++ = *src++;
    4ab6:	0005c703          	lbu	a4,0(a1)
    4aba:	0785                	addi	a5,a5,1
    4abc:	0585                	addi	a1,a1,1
    4abe:	fee78fa3          	sb	a4,-1(a5)
        while (n--)
    4ac2:	fec79ae3          	bne	a5,a2,4ab6 <memmove+0xe>
    4ac6:	8082                	ret
    }
    else
    {
        dst += n;
    4ac8:	00c50733          	add	a4,a0,a2
        src += n;
    4acc:	00c587b3          	add	a5,a1,a2
        while (n-- > 0)
    4ad0:	ca09                	beqz	a2,4ae2 <memmove+0x3a>
            *--dst = *--src;
    4ad2:	fff7c683          	lbu	a3,-1(a5)
    4ad6:	17fd                	addi	a5,a5,-1
    4ad8:	177d                	addi	a4,a4,-1
    4ada:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
    4ade:	fef59ae3          	bne	a1,a5,4ad2 <memmove+0x2a>
    }
    return vdst;
}
    4ae2:	8082                	ret

0000000000004ae4 <memcpy>:

void *memcpy(void *vdst, const void *vsrc, size_t n)
{
    return memmove(vdst, vsrc, n);
    4ae4:	b7d1                	j	4aa8 <memmove>

0000000000004ae6 <memcmp>:

int memcmp(const void *s1, const void *s2, size_t n)
{
    const unsigned char *p1 = (const unsigned char *)s1;
    const unsigned char *p2 = (const unsigned char *)s2;
    while (n--)
    4ae6:	c205                	beqz	a2,4b06 <memcmp+0x20>
    4ae8:	962a                	add	a2,a2,a0
    4aea:	a019                	j	4af0 <memcmp+0xa>
    4aec:	00c50d63          	beq	a0,a2,4b06 <memcmp+0x20>
    {
        if (*p1 != *p2)
    4af0:	00054783          	lbu	a5,0(a0)
    4af4:	0005c703          	lbu	a4,0(a1)
            return *p1 - *p2;
        p1++;
    4af8:	0505                	addi	a0,a0,1
        p2++;
    4afa:	0585                	addi	a1,a1,1
        if (*p1 != *p2)
    4afc:	fee788e3          	beq	a5,a4,4aec <memcmp+0x6>
            return *p1 - *p2;
    4b00:	40e7853b          	subw	a0,a5,a4
    4b04:	8082                	ret
    }
    return 0;
    4b06:	4501                	li	a0,0
}
    4b08:	8082                	ret

0000000000004b0a <memchr>:

void *memchr(const void *s, int c, size_t n)
{
    const unsigned char *p = (const unsigned char *)s;
    while (n--)
    4b0a:	ce09                	beqz	a2,4b24 <memchr+0x1a>
    {
        if (*p == (unsigned char)c)
    4b0c:	0ff5f593          	zext.b	a1,a1
    4b10:	962a                	add	a2,a2,a0
    4b12:	a021                	j	4b1a <memchr+0x10>
            return (void *)p;
        p++;
    4b14:	0505                	addi	a0,a0,1
    while (n--)
    4b16:	00a60763          	beq	a2,a0,4b24 <memchr+0x1a>
        if (*p == (unsigned char)c)
    4b1a:	00054783          	lbu	a5,0(a0)
    4b1e:	feb79be3          	bne	a5,a1,4b14 <memchr+0xa>
    }
    return NULL;
}
    4b22:	8082                	ret
    return NULL;
    4b24:	4501                	li	a0,0
}
    4b26:	8082                	ret

0000000000004b28 <strlen>:
/* String Manipulation Functions  */

size_t strlen(const char *s)
{
    const char *p = s;
    while (*p)
    4b28:	00054783          	lbu	a5,0(a0)
    4b2c:	cb89                	beqz	a5,4b3e <strlen+0x16>
    const char *p = s;
    4b2e:	87aa                	mv	a5,a0
    while (*p)
    4b30:	0017c703          	lbu	a4,1(a5)
        p++;
    4b34:	0785                	addi	a5,a5,1
    while (*p)
    4b36:	ff6d                	bnez	a4,4b30 <strlen+0x8>
    return (size_t)(p - s);
    4b38:	40a78533          	sub	a0,a5,a0
    4b3c:	8082                	ret
    while (*p)
    4b3e:	4501                	li	a0,0
}
    4b40:	8082                	ret

0000000000004b42 <strcpy>:

char *strcpy(char *dst, const char *src)
{
    char *os = dst;
    while ((*dst++ = *src++) != 0)
    4b42:	87aa                	mv	a5,a0
    4b44:	0005c703          	lbu	a4,0(a1)
    4b48:	0785                	addi	a5,a5,1
    4b4a:	0585                	addi	a1,a1,1
    4b4c:	fee78fa3          	sb	a4,-1(a5)
    4b50:	fb75                	bnez	a4,4b44 <strcpy+0x2>
        ;
    return os;
}
    4b52:	8082                	ret

0000000000004b54 <strncpy>:
char *strncpy(char *dst, const char *src, size_t n)
{
    char *os = dst;
    size_t i;

    for (i = 0; i < n && src[i] != '\0'; i++)
    4b54:	4781                	li	a5,0
    4b56:	e619                	bnez	a2,4b64 <strncpy+0x10>
    4b58:	8082                	ret
        dst[i] = src[i];
    4b5a:	00e68023          	sb	a4,0(a3)
    for (i = 0; i < n && src[i] != '\0'; i++)
    4b5e:	0785                	addi	a5,a5,1
    4b60:	02f60263          	beq	a2,a5,4b84 <strncpy+0x30>
    4b64:	00f58733          	add	a4,a1,a5
    4b68:	00074703          	lbu	a4,0(a4)
        dst[i] = src[i];
    4b6c:	00f506b3          	add	a3,a0,a5
    for (i = 0; i < n && src[i] != '\0'; i++)
    4b70:	f76d                	bnez	a4,4b5a <strncpy+0x6>

    for (; i < n; i++)
    4b72:	00c7f963          	bgeu	a5,a2,4b84 <strncpy+0x30>
    4b76:	87b6                	mv	a5,a3
    4b78:	962a                	add	a2,a2,a0
        dst[i] = '\0';
    4b7a:	00078023          	sb	zero,0(a5)
    for (; i < n; i++)
    4b7e:	0785                	addi	a5,a5,1
    4b80:	fec79de3          	bne	a5,a2,4b7a <strncpy+0x26>

    return os;
}
    4b84:	8082                	ret

0000000000004b86 <strcat>:

char *strcat(char *dst, const char *src)
{
    char *os = dst;
    while (*dst)
    4b86:	00054783          	lbu	a5,0(a0)
    4b8a:	cf91                	beqz	a5,4ba6 <strcat+0x20>
    4b8c:	87aa                	mv	a5,a0
    4b8e:	0017c703          	lbu	a4,1(a5)
        dst++;
    4b92:	0785                	addi	a5,a5,1
    while (*dst)
    4b94:	ff6d                	bnez	a4,4b8e <strcat+0x8>
    while ((*dst++ = *src++) != 0)
    4b96:	0005c703          	lbu	a4,0(a1)
    4b9a:	0785                	addi	a5,a5,1
    4b9c:	0585                	addi	a1,a1,1
    4b9e:	fee78fa3          	sb	a4,-1(a5)
    4ba2:	fb75                	bnez	a4,4b96 <strcat+0x10>
        ;
    return os;
}
    4ba4:	8082                	ret
    while ((*dst++ = *src++) != 0)
    4ba6:	0005c703          	lbu	a4,0(a1)
    while (*dst)
    4baa:	87aa                	mv	a5,a0
    while ((*dst++ = *src++) != 0)
    4bac:	0785                	addi	a5,a5,1
    4bae:	fee78fa3          	sb	a4,-1(a5)
    4bb2:	0585                	addi	a1,a1,1
    4bb4:	f36d                	bnez	a4,4b96 <strcat+0x10>
    4bb6:	8082                	ret

0000000000004bb8 <strncat>:
    while (*p)
    4bb8:	00054783          	lbu	a5,0(a0)
    const char *p = s;
    4bbc:	872a                	mv	a4,a0
    while (*p)
    4bbe:	c789                	beqz	a5,4bc8 <strncat+0x10>
    4bc0:	00174783          	lbu	a5,1(a4)
        p++;
    4bc4:	0705                	addi	a4,a4,1
    while (*p)
    4bc6:	ffed                	bnez	a5,4bc0 <strncat+0x8>
    size_t dest_len = strlen(dst);
    size_t i;

    dst += dest_len;

    for (i = 0; i < n && src[i] != '\0'; i++)
    4bc8:	86ba                	mv	a3,a4
    4bca:	4781                	li	a5,0
    4bcc:	88ba                	mv	a7,a4
    4bce:	ea01                	bnez	a2,4bde <strncat+0x26>
    4bd0:	a839                	j	4bee <strncat+0x36>
        dst[i] = src[i];
    4bd2:	01068023          	sb	a6,0(a3)
    for (i = 0; i < n && src[i] != '\0'; i++)
    4bd6:	00188693          	addi	a3,a7,1
    4bda:	00f60d63          	beq	a2,a5,4bf4 <strncat+0x3c>
    4bde:	00f58833          	add	a6,a1,a5
    4be2:	00084803          	lbu	a6,0(a6)
    4be6:	0785                	addi	a5,a5,1
        dst[i] = src[i];
    4be8:	88b6                	mv	a7,a3
    for (i = 0; i < n && src[i] != '\0'; i++)
    4bea:	fe0814e3          	bnez	a6,4bd2 <strncat+0x1a>

    dst[i] = '\0';
    4bee:	00088023          	sb	zero,0(a7)

    return os;
}
    4bf2:	8082                	ret
    dst[i] = '\0';
    4bf4:	00c708b3          	add	a7,a4,a2
    4bf8:	00088023          	sb	zero,0(a7)
}
    4bfc:	8082                	ret

0000000000004bfe <strcmp>:

int strcmp(const char *p, const char *q)
{
    while (*p && *p == *q)
    4bfe:	00054783          	lbu	a5,0(a0)
    4c02:	e791                	bnez	a5,4c0e <strcmp+0x10>
    4c04:	a02d                	j	4c2e <strcmp+0x30>
    4c06:	00054783          	lbu	a5,0(a0)
    4c0a:	cf89                	beqz	a5,4c24 <strcmp+0x26>
    4c0c:	85b6                	mv	a1,a3
    4c0e:	0005c703          	lbu	a4,0(a1)
    {
        p++;
    4c12:	0505                	addi	a0,a0,1
        q++;
    4c14:	00158693          	addi	a3,a1,1
    while (*p && *p == *q)
    4c18:	fef707e3          	beq	a4,a5,4c06 <strcmp+0x8>
    }
    return (int)((unsigned char)*p - (unsigned char)*q);
    4c1c:	0007851b          	sext.w	a0,a5
}
    4c20:	9d19                	subw	a0,a0,a4
    4c22:	8082                	ret
    return (int)((unsigned char)*p - (unsigned char)*q);
    4c24:	0015c703          	lbu	a4,1(a1)
    4c28:	4501                	li	a0,0
}
    4c2a:	9d19                	subw	a0,a0,a4
    4c2c:	8082                	ret
    return (int)((unsigned char)*p - (unsigned char)*q);
    4c2e:	0005c703          	lbu	a4,0(a1)
    4c32:	4501                	li	a0,0
    4c34:	b7f5                	j	4c20 <strcmp+0x22>

0000000000004c36 <strncmp>:

int strncmp(const char *s1, const char *s2, size_t n)
{
    if (n == 0)
    4c36:	ca0d                	beqz	a2,4c68 <strncmp+0x32>
        return 0;

    while (n-- > 0 && *s1 && *s1 == *s2)
    4c38:	00054783          	lbu	a5,0(a0)
    4c3c:	167d                	addi	a2,a2,-1
    4c3e:	00c506b3          	add	a3,a0,a2
    4c42:	eb89                	bnez	a5,4c54 <strncmp+0x1e>
    4c44:	a80d                	j	4c76 <strncmp+0x40>
    {
        if (n == 0 || *s1 == '\0')
    4c46:	00d50d63          	beq	a0,a3,4c60 <strncmp+0x2a>
    while (n-- > 0 && *s1 && *s1 == *s2)
    4c4a:	00154783          	lbu	a5,1(a0)
            break;
        s1++;
    4c4e:	0505                	addi	a0,a0,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    4c50:	cf91                	beqz	a5,4c6c <strncmp+0x36>
    4c52:	85b2                	mv	a1,a2
    4c54:	0005c703          	lbu	a4,0(a1)
        s2++;
    4c58:	00158613          	addi	a2,a1,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    4c5c:	fef705e3          	beq	a4,a5,4c46 <strncmp+0x10>
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    4c60:	0007851b          	sext.w	a0,a5
    4c64:	9d19                	subw	a0,a0,a4
    4c66:	8082                	ret
        return 0;
    4c68:	4501                	li	a0,0
}
    4c6a:	8082                	ret
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    4c6c:	0015c703          	lbu	a4,1(a1)
    4c70:	4501                	li	a0,0
    4c72:	9d19                	subw	a0,a0,a4
    4c74:	8082                	ret
    4c76:	0005c703          	lbu	a4,0(a1)
    4c7a:	4501                	li	a0,0
    4c7c:	b7e5                	j	4c64 <strncmp+0x2e>

0000000000004c7e <strchr>:

char *strchr(const char *s, int c)
{
    while (*s != (char)c)
    4c7e:	0ff5f593          	zext.b	a1,a1
    4c82:	a019                	j	4c88 <strchr+0xa>
    {
        if (!*s++)
    4c84:	0505                	addi	a0,a0,1
    4c86:	c791                	beqz	a5,4c92 <strchr+0x14>
    while (*s != (char)c)
    4c88:	00054783          	lbu	a5,0(a0)
    4c8c:	feb79ce3          	bne	a5,a1,4c84 <strchr+0x6>
    4c90:	8082                	ret
            return NULL;
    4c92:	4501                	li	a0,0
    }
    return (char *)s;
}
    4c94:	8082                	ret

0000000000004c96 <strrchr>:

char *strrchr(const char *s, int c)
{
    4c96:	87aa                	mv	a5,a0
    const char *last = NULL;
    do
    {
        if (*s == (char)c)
    4c98:	0ff5f593          	zext.b	a1,a1
    const char *last = NULL;
    4c9c:	4501                	li	a0,0
        if (*s == (char)c)
    4c9e:	0007c703          	lbu	a4,0(a5)
    4ca2:	00e59363          	bne	a1,a4,4ca8 <strrchr+0x12>
            last = s;
    4ca6:	853e                	mv	a0,a5
    } while (*s++);
    4ca8:	0785                	addi	a5,a5,1
    4caa:	fb75                	bnez	a4,4c9e <strrchr+0x8>

    return (char *)last;
}
    4cac:	8082                	ret

0000000000004cae <strstr>:
    while (*p)
    4cae:	0005c883          	lbu	a7,0(a1)
    4cb2:	04088a63          	beqz	a7,4d06 <strstr+0x58>
    const char *p = s;
    4cb6:	87ae                	mv	a5,a1
    while (*p)
    4cb8:	0017c703          	lbu	a4,1(a5)
        p++;
    4cbc:	0785                	addi	a5,a5,1
    while (*p)
    4cbe:	ff6d                	bnez	a4,4cb8 <strstr+0xa>
    return (size_t)(p - s);
    4cc0:	40b78833          	sub	a6,a5,a1


char *strstr(const char *haystack, const char *needle)
{
    size_t n_len = strlen(needle);
    if (n_len == 0)
    4cc4:	04b78163          	beq	a5,a1,4d06 <strstr+0x58>
        return (char *)haystack;

    for (; *haystack; haystack++)
    4cc8:	00054783          	lbu	a5,0(a0)
    4ccc:	cf85                	beqz	a5,4d04 <strstr+0x56>
    4cce:	187d                	addi	a6,a6,-1
    4cd0:	982a                	add	a6,a6,a0
    {
        if (*haystack != *needle)
    4cd2:	02f89463          	bne	a7,a5,4cfa <strstr+0x4c>
    while (n-- > 0 && *s1 && *s1 == *s2)
    4cd6:	00054703          	lbu	a4,0(a0)
    4cda:	8646                	mv	a2,a7
    4cdc:	86ae                	mv	a3,a1
    4cde:	87aa                	mv	a5,a0
    4ce0:	eb11                	bnez	a4,4cf4 <strstr+0x46>
    4ce2:	a821                	j	4cfa <strstr+0x4c>
        if (n == 0 || *s1 == '\0')
    4ce4:	03078163          	beq	a5,a6,4d06 <strstr+0x58>
    while (n-- > 0 && *s1 && *s1 == *s2)
    4ce8:	0017c703          	lbu	a4,1(a5)
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    4cec:	0006c603          	lbu	a2,0(a3)
        s1++;
    4cf0:	0785                	addi	a5,a5,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    4cf2:	cb19                	beqz	a4,4d08 <strstr+0x5a>
        s2++;
    4cf4:	0685                	addi	a3,a3,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    4cf6:	fee607e3          	beq	a2,a4,4ce4 <strstr+0x36>
    for (; *haystack; haystack++)
    4cfa:	00154783          	lbu	a5,1(a0)
    4cfe:	0805                	addi	a6,a6,1
    4d00:	0505                	addi	a0,a0,1
    4d02:	fbe1                	bnez	a5,4cd2 <strstr+0x24>
            continue;

        if (strncmp(haystack, needle, n_len) == 0)
            return (char *)haystack;
    }
    return NULL;
    4d04:	4501                	li	a0,0
}
    4d06:	8082                	ret
        if (strncmp(haystack, needle, n_len) == 0)
    4d08:	de7d                	beqz	a2,4d06 <strstr+0x58>
    for (; *haystack; haystack++)
    4d0a:	00154783          	lbu	a5,1(a0)
    4d0e:	0805                	addi	a6,a6,1
    4d10:	0505                	addi	a0,a0,1
    4d12:	f3e1                	bnez	a5,4cd2 <strstr+0x24>
    4d14:	bfc5                	j	4d04 <strstr+0x56>

0000000000004d16 <strdup>:

char *strdup(const char *s)
{
    4d16:	1101                	addi	sp,sp,-32
    4d18:	e426                	sd	s1,8(sp)
    4d1a:	ec06                	sd	ra,24(sp)
    4d1c:	e822                	sd	s0,16(sp)
    while (*p)
    4d1e:	00054783          	lbu	a5,0(a0)
{
    4d22:	84aa                	mv	s1,a0
    while (*p)
    4d24:	cb8d                	beqz	a5,4d56 <strdup+0x40>
    const char *p = s;
    4d26:	862a                	mv	a2,a0
    while (*p)
    4d28:	00164783          	lbu	a5,1(a2)
        p++;
    4d2c:	0605                	addi	a2,a2,1
    while (*p)
    4d2e:	ffed                	bnez	a5,4d28 <strdup+0x12>
    return (size_t)(p - s);
    4d30:	8e05                	sub	a2,a2,s1
    size_t len = strlen(s) + 1;
    4d32:	00160413          	addi	s0,a2,1
    char *new_str = (char *)malloc(len);
    4d36:	8522                	mv	a0,s0
    4d38:	f4eff0ef          	jal	4486 <malloc>
    if (new_str == NULL)
    4d3c:	c901                	beqz	a0,4d4c <strdup+0x36>
    return memmove(vdst, vsrc, n);
    4d3e:	8622                	mv	a2,s0
        return NULL;

    return (char *)memcpy(new_str, s, len);
}
    4d40:	6442                	ld	s0,16(sp)
    4d42:	60e2                	ld	ra,24(sp)
    return memmove(vdst, vsrc, n);
    4d44:	85a6                	mv	a1,s1
}
    4d46:	64a2                	ld	s1,8(sp)
    4d48:	6105                	addi	sp,sp,32
    return memmove(vdst, vsrc, n);
    4d4a:	bbb9                	j	4aa8 <memmove>
}
    4d4c:	60e2                	ld	ra,24(sp)
    4d4e:	6442                	ld	s0,16(sp)
    4d50:	64a2                	ld	s1,8(sp)
    4d52:	6105                	addi	sp,sp,32
    4d54:	8082                	ret
    while (*p)
    4d56:	4405                	li	s0,1
    4d58:	bff9                	j	4d36 <strdup+0x20>

0000000000004d5a <strlcpy>:
    4d5a:	0005c783          	lbu	a5,0(a1)

size_t strlcpy(char *dst, const char *src, size_t size)
{
    4d5e:	1101                	addi	sp,sp,-32
    4d60:	ec06                	sd	ra,24(sp)
    4d62:	e822                	sd	s0,16(sp)
    4d64:	86b2                	mv	a3,a2
    while (*p)
    4d66:	cf8d                	beqz	a5,4da0 <strlcpy+0x46>
    const char *p = s;
    4d68:	87ae                	mv	a5,a1
    while (*p)
    4d6a:	0017c703          	lbu	a4,1(a5)
        p++;
    4d6e:	0785                	addi	a5,a5,1
    while (*p)
    4d70:	ff6d                	bnez	a4,4d6a <strlcpy+0x10>
    return (size_t)(p - s);
    4d72:	40b78433          	sub	s0,a5,a1
    size_t src_len = strlen(src);

    if (size > 0)
    4d76:	c285                	beqz	a3,4d96 <strlcpy+0x3c>
    4d78:	e426                	sd	s1,8(sp)
    {
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    4d7a:	fff68613          	addi	a2,a3,-1
        memcpy(dst, src, copy_len);
        dst[copy_len] = '\0';
    4d7e:	00c504b3          	add	s1,a0,a2
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    4d82:	00d47563          	bgeu	s0,a3,4d8c <strlcpy+0x32>
        dst[copy_len] = '\0';
    4d86:	008504b3          	add	s1,a0,s0
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    4d8a:	8622                	mv	a2,s0
    return memmove(vdst, vsrc, n);
    4d8c:	d1dff0ef          	jal	4aa8 <memmove>
        dst[copy_len] = '\0';
    4d90:	00048023          	sb	zero,0(s1)
    }

    return src_len;
    4d94:	64a2                	ld	s1,8(sp)
}
    4d96:	60e2                	ld	ra,24(sp)
    4d98:	8522                	mv	a0,s0
    4d9a:	6442                	ld	s0,16(sp)
    4d9c:	6105                	addi	sp,sp,32
    4d9e:	8082                	ret
    if (size > 0)
    4da0:	e219                	bnez	a2,4da6 <strlcpy+0x4c>
    return (size_t)(p - s);
    4da2:	4401                	li	s0,0
    4da4:	bfcd                	j	4d96 <strlcpy+0x3c>
    4da6:	e426                	sd	s1,8(sp)
    4da8:	4401                	li	s0,0
    if (size > 0)
    4daa:	84aa                	mv	s1,a0
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    4dac:	4601                	li	a2,0
    4dae:	bff9                	j	4d8c <strlcpy+0x32>

0000000000004db0 <strlcat>:
    while (*p)
    4db0:	0005c783          	lbu	a5,0(a1)

size_t strlcat(char *dst, const char *src, size_t size)
{
    4db4:	7179                	addi	sp,sp,-48
    4db6:	e84a                	sd	s2,16(sp)
    4db8:	f406                	sd	ra,40(sp)
    4dba:	f022                	sd	s0,32(sp)
    4dbc:	ec26                	sd	s1,24(sp)
    4dbe:	892a                	mv	s2,a0
    while (*p)
    4dc0:	c7b5                	beqz	a5,4e2c <strlcat+0x7c>
    const char *p = s;
    4dc2:	87ae                	mv	a5,a1
    while (*p)
    4dc4:	0017c703          	lbu	a4,1(a5)
        p++;
    4dc8:	0785                	addi	a5,a5,1
    while (*p)
    4dca:	ff6d                	bnez	a4,4dc4 <strlcat+0x14>
    return (size_t)(p - s);
    4dcc:	40b784b3          	sub	s1,a5,a1
    size_t dst_len = 0;
    4dd0:	4401                	li	s0,0
    size_t src_len = strlen(src);

    while (dst_len < size && dst[dst_len] != '\0')
    4dd2:	e609                	bnez	a2,4ddc <strlcat+0x2c>
    4dd4:	a0a1                	j	4e1c <strlcat+0x6c>
        dst_len++;
    4dd6:	0405                	addi	s0,s0,1
    while (dst_len < size && dst[dst_len] != '\0')
    4dd8:	04860263          	beq	a2,s0,4e1c <strlcat+0x6c>
    4ddc:	00890533          	add	a0,s2,s0
    4de0:	00054783          	lbu	a5,0(a0)
    4de4:	fbed                	bnez	a5,4dd6 <strlcat+0x26>

    if (dst_len == size)
    4de6:	02860b63          	beq	a2,s0,4e1c <strlcat+0x6c>
    4dea:	e44e                	sd	s3,8(sp)
        return size + src_len;

    size_t space_left = size - dst_len;
    4dec:	408607b3          	sub	a5,a2,s0
    size_t copy_len = (src_len >= space_left) ? space_left - 1 : src_len;
    4df0:	89a6                	mv	s3,s1
    4df2:	02f4f263          	bgeu	s1,a5,4e16 <strlcat+0x66>

    memcpy(dst + dst_len, src, copy_len);
    dst[dst_len + copy_len] = '\0';
    4df6:	994e                	add	s2,s2,s3
    4df8:	9922                	add	s2,s2,s0
    return memmove(vdst, vsrc, n);
    4dfa:	864e                	mv	a2,s3
    4dfc:	cadff0ef          	jal	4aa8 <memmove>
    dst[dst_len + copy_len] = '\0';
    4e00:	00090023          	sb	zero,0(s2) # 1000 <_vscanf_core.constprop.0+0x6d0>

    return dst_len + src_len;
    4e04:	00940533          	add	a0,s0,s1
}
    4e08:	70a2                	ld	ra,40(sp)
    4e0a:	7402                	ld	s0,32(sp)
    return dst_len + src_len;
    4e0c:	69a2                	ld	s3,8(sp)
}
    4e0e:	64e2                	ld	s1,24(sp)
    4e10:	6942                	ld	s2,16(sp)
    4e12:	6145                	addi	sp,sp,48
    4e14:	8082                	ret
    size_t copy_len = (src_len >= space_left) ? space_left - 1 : src_len;
    4e16:	fff78993          	addi	s3,a5,-1
    4e1a:	bff1                	j	4df6 <strlcat+0x46>
}
    4e1c:	70a2                	ld	ra,40(sp)
    4e1e:	7402                	ld	s0,32(sp)
    4e20:	6942                	ld	s2,16(sp)
        return size + src_len;
    4e22:	00960533          	add	a0,a2,s1
}
    4e26:	64e2                	ld	s1,24(sp)
    4e28:	6145                	addi	sp,sp,48
    4e2a:	8082                	ret
    while (*p)
    4e2c:	4481                	li	s1,0
    4e2e:	b74d                	j	4dd0 <strlcat+0x20>

0000000000004e30 <strspn>:
size_t strspn(const char *s, const char *accept)
{
    const char *p = s;
    const char *a;

    while (*p)
    4e30:	00054683          	lbu	a3,0(a0)
    4e34:	c695                	beqz	a3,4e60 <strspn+0x30>
    {
        for (a = accept; *a; a++)
    4e36:	0005c803          	lbu	a6,0(a1)
    4e3a:	862a                	mv	a2,a0
    4e3c:	00080f63          	beqz	a6,4e5a <strspn+0x2a>
    4e40:	87ae                	mv	a5,a1
    4e42:	8742                	mv	a4,a6
    4e44:	a021                	j	4e4c <strspn+0x1c>
    4e46:	0007c703          	lbu	a4,0(a5)
    4e4a:	cb01                	beqz	a4,4e5a <strspn+0x2a>
    4e4c:	0785                	addi	a5,a5,1
        {
            if (*p == *a)
    4e4e:	fee69ce3          	bne	a3,a4,4e46 <strspn+0x16>
    while (*p)
    4e52:	00164683          	lbu	a3,1(a2)
                break;
        }
        if (*a == '\0')
            return (size_t)(p - s);
        p++;
    4e56:	0605                	addi	a2,a2,1
    while (*p)
    4e58:	f6e5                	bnez	a3,4e40 <strspn+0x10>
    }
    return (size_t)(p - s);
    4e5a:	40a60533          	sub	a0,a2,a0
    4e5e:	8082                	ret
    while (*p)
    4e60:	4501                	li	a0,0
}
    4e62:	8082                	ret

0000000000004e64 <strcspn>:
size_t strcspn(const char *s, const char *reject)
{
    const char *p = s;
    const char *r;

    while (*p)
    4e64:	00054683          	lbu	a3,0(a0)
    4e68:	ce85                	beqz	a3,4ea0 <strcspn+0x3c>
    {
        for (r = reject; *r; r++)
    4e6a:	0005c803          	lbu	a6,0(a1)
    const char *p = s;
    4e6e:	862a                	mv	a2,a0
        for (r = reject; *r; r++)
    4e70:	02080363          	beqz	a6,4e96 <strcspn+0x32>
    4e74:	87ae                	mv	a5,a1
    4e76:	8742                	mv	a4,a6
    4e78:	a021                	j	4e80 <strcspn+0x1c>
    4e7a:	0007c703          	lbu	a4,0(a5)
    4e7e:	c719                	beqz	a4,4e8c <strcspn+0x28>
    4e80:	0785                	addi	a5,a5,1
        {
            if (*p == *r)
    4e82:	fed71ce3          	bne	a4,a3,4e7a <strcspn+0x16>
                return (size_t)(p - s);
        }
        p++;
    }
    return (size_t)(p - s);
    4e86:	40a60533          	sub	a0,a2,a0
    4e8a:	8082                	ret
    while (*p)
    4e8c:	00164683          	lbu	a3,1(a2)
        p++;
    4e90:	0605                	addi	a2,a2,1
    while (*p)
    4e92:	f2ed                	bnez	a3,4e74 <strcspn+0x10>
    4e94:	bfcd                	j	4e86 <strcspn+0x22>
    4e96:	00164683          	lbu	a3,1(a2)
        p++;
    4e9a:	0605                	addi	a2,a2,1
    while (*p)
    4e9c:	feed                	bnez	a3,4e96 <strcspn+0x32>
    4e9e:	b7e5                	j	4e86 <strcspn+0x22>
    4ea0:	4501                	li	a0,0
}
    4ea2:	8082                	ret

0000000000004ea4 <strpbrk>:

char *strpbrk(const char *s, const char *accept)
{
    const char *a;
    while (*s)
    4ea4:	00054683          	lbu	a3,0(a0)
    4ea8:	c295                	beqz	a3,4ecc <strpbrk+0x28>
    {
        for (a = accept; *a; a++)
    4eaa:	0005c603          	lbu	a2,0(a1)
    4eae:	c20d                	beqz	a2,4ed0 <strpbrk+0x2c>
    4eb0:	87ae                	mv	a5,a1
    4eb2:	8732                	mv	a4,a2
    4eb4:	a021                	j	4ebc <strpbrk+0x18>
    4eb6:	0007c703          	lbu	a4,0(a5)
    4eba:	c709                	beqz	a4,4ec4 <strpbrk+0x20>
    4ebc:	0785                	addi	a5,a5,1
        {
            if (*s == *a)
    4ebe:	fed71ce3          	bne	a4,a3,4eb6 <strpbrk+0x12>
                return (char *)s;
        }
        s++;
    }
    return NULL;
}
    4ec2:	8082                	ret
    while (*s)
    4ec4:	00154683          	lbu	a3,1(a0)
        s++;
    4ec8:	0505                	addi	a0,a0,1
    while (*s)
    4eca:	f2fd                	bnez	a3,4eb0 <strpbrk+0xc>
    return NULL;
    4ecc:	4501                	li	a0,0
}
    4ece:	8082                	ret
    while (*s)
    4ed0:	00154683          	lbu	a3,1(a0)
        s++;
    4ed4:	0505                	addi	a0,a0,1
    while (*s)
    4ed6:	feed                	bnez	a3,4ed0 <strpbrk+0x2c>
    4ed8:	bfd5                	j	4ecc <strpbrk+0x28>

0000000000004eda <strtok>:
char *strtok(char *str, const char *delim)
{
    static char *olds;
    char *token;

    if (str == NULL)
    4eda:	00003897          	auipc	a7,0x3
    4ede:	90688893          	addi	a7,a7,-1786 # 77e0 <olds.0>
    4ee2:	cd25                	beqz	a0,4f5a <strtok+0x80>
    while (*p)
    4ee4:	00054683          	lbu	a3,0(a0)
    4ee8:	c295                	beqz	a3,4f0c <strtok+0x32>
        for (a = accept; *a; a++)
    4eea:	0005c803          	lbu	a6,0(a1)
    4eee:	02080463          	beqz	a6,4f16 <strtok+0x3c>
    4ef2:	87ae                	mv	a5,a1
    4ef4:	8742                	mv	a4,a6
    4ef6:	a021                	j	4efe <strtok+0x24>
    4ef8:	0007c703          	lbu	a4,0(a5)
    4efc:	cf09                	beqz	a4,4f16 <strtok+0x3c>
    4efe:	0785                	addi	a5,a5,1
            if (*p == *a)
    4f00:	fee69ce3          	bne	a3,a4,4ef8 <strtok+0x1e>
    while (*p)
    4f04:	00154683          	lbu	a3,1(a0)
        p++;
    4f08:	0505                	addi	a0,a0,1
    while (*p)
    4f0a:	f6e5                	bnez	a3,4ef2 <strtok+0x18>
    4f0c:	87aa                	mv	a5,a0
        str = olds;

    str += strspn(str, delim);
    if (*str == '\0')
    {
        olds = str;
    4f0e:	00f8b023          	sd	a5,0(a7)
        return NULL;
    4f12:	4501                	li	a0,0
        *str = '\0';
        olds = str + 1;
    }

    return token;
}
    4f14:	8082                	ret
    if (*str == '\0')
    4f16:	00054603          	lbu	a2,0(a0)
    4f1a:	da6d                	beqz	a2,4f0c <strtok+0x32>
    4f1c:	86aa                	mv	a3,a0
        for (a = accept; *a; a++)
    4f1e:	04080163          	beqz	a6,4f60 <strtok+0x86>
    4f22:	8742                	mv	a4,a6
    4f24:	87ae                	mv	a5,a1
    4f26:	a021                	j	4f2e <strtok+0x54>
    4f28:	0007c703          	lbu	a4,0(a5)
    4f2c:	cb19                	beqz	a4,4f42 <strtok+0x68>
    4f2e:	0785                	addi	a5,a5,1
            if (*s == *a)
    4f30:	fee61ce3          	bne	a2,a4,4f28 <strtok+0x4e>
        olds = str + 1;
    4f34:	00168793          	addi	a5,a3,1
        *str = '\0';
    4f38:	00068023          	sb	zero,0(a3)
        olds = str;
    4f3c:	00f8b023          	sd	a5,0(a7)
}
    4f40:	8082                	ret
    while (*s)
    4f42:	0016c603          	lbu	a2,1(a3)
        s++;
    4f46:	0685                	addi	a3,a3,1
    while (*s)
    4f48:	fe69                	bnez	a2,4f22 <strtok+0x48>
    4f4a:	87aa                	mv	a5,a0
    while (*s != (char)c)
    4f4c:	0017c703          	lbu	a4,1(a5)
        if (!*s++)
    4f50:	0785                	addi	a5,a5,1
    while (*s != (char)c)
    4f52:	ff6d                	bnez	a4,4f4c <strtok+0x72>
        olds = str;
    4f54:	00f8b023          	sd	a5,0(a7)
}
    4f58:	8082                	ret
        str = olds;
    4f5a:	0008b503          	ld	a0,0(a7)
    4f5e:	b759                	j	4ee4 <strtok+0xa>
    while (*s)
    4f60:	0016c603          	lbu	a2,1(a3)
        s++;
    4f64:	0685                	addi	a3,a3,1
    while (*s)
    4f66:	fe6d                	bnez	a2,4f60 <strtok+0x86>
    4f68:	b7cd                	j	4f4a <strtok+0x70>

0000000000004f6a <strerror>:

char *strerror(int errnum)
{
    4f6a:	87aa                	mv	a5,a0
    
    switch (errnum)
    4f6c:	cd09                	beqz	a0,4f86 <strerror+0x1c>
    4f6e:	4731                	li	a4,12
    4f70:	00000517          	auipc	a0,0x0
    4f74:	16050513          	addi	a0,a0,352 # 50d0 <_GLOBAL__sub_I__ZSt3cin+0x128>
    4f78:	00e78b63          	beq	a5,a4,4f8e <strerror+0x24>
        return "Success";
    // case EINVAL: return "Invalid argument";
    case ENOMEM: return "Out of memory";
    
    default:
        return "Unknown error";
    4f7c:	00000517          	auipc	a0,0x0
    4f80:	16450513          	addi	a0,a0,356 # 50e0 <_GLOBAL__sub_I__ZSt3cin+0x138>
    4f84:	8082                	ret
        return "Success";
    4f86:	00000517          	auipc	a0,0x0
    4f8a:	14250513          	addi	a0,a0,322 # 50c8 <_GLOBAL__sub_I__ZSt3cin+0x120>
    }
    4f8e:	8082                	ret

0000000000004f90 <_Znwm>:
#include "ulib/stdlib.h"

void *operator new(unsigned long n)
{
    return malloc(n);
    4f90:	cf6ff06f          	j	4486 <malloc>

0000000000004f94 <_Znam>:
}

void *operator new[](unsigned long n)
    4f94:	cf2ff06f          	j	4486 <malloc>

0000000000004f98 <_ZdlPv>:
    return malloc(n);
}

void operator delete(void *p)
{
    free(p);
    4f98:	c78ff06f          	j	4410 <free>

0000000000004f9c <_ZdaPv>:
}

void operator delete[](void *p)
    4f9c:	c74ff06f          	j	4410 <free>

0000000000004fa0 <_ZdlPvm>:
    free(p);
}

void operator delete(void *p, unsigned long)
{
    free(p);
    4fa0:	c70ff06f          	j	4410 <free>

0000000000004fa4 <_ZdaPvm>:
}

void operator delete[](void *p, unsigned long)
    4fa4:	c6cff06f          	j	4410 <free>

0000000000004fa8 <_GLOBAL__sub_I__ZSt3cin>:
#include "ulib/iostream"

namespace std
{
    istream cin(stdin);
    4fa8:	00002797          	auipc	a5,0x2
    4fac:	6e87b783          	ld	a5,1768(a5) # 7690 <_GLOBAL_OFFSET_TABLE_+0x10>
    4fb0:	6390                	ld	a2,0(a5)
    ostream cout(stdout);
    4fb2:	00002797          	auipc	a5,0x2
    4fb6:	6d67b783          	ld	a5,1750(a5) # 7688 <_GLOBAL_OFFSET_TABLE_+0x8>
    4fba:	6394                	ld	a3,0(a5)
    ostream cerr(stderr);
    4fbc:	00002797          	auipc	a5,0x2
    4fc0:	6dc7b783          	ld	a5,1756(a5) # 7698 <_GLOBAL_OFFSET_TABLE_+0x18>
    4fc4:	6398                	ld	a4,0(a5)

    class istream{
    private:
        FILE* _stream;
    public:
        istream(FILE *f) : _stream(f) {}
    4fc6:	00003797          	auipc	a5,0x3
    4fca:	82278793          	addi	a5,a5,-2014 # 77e8 <_ZSt3cin>
    4fce:	e390                	sd	a2,0(a5)
        ostream(FILE* f) : _stream(f) {}
    4fd0:	e794                	sd	a3,8(a5)
    4fd2:	eb98                	sd	a4,16(a5)
} // namespace std
    4fd4:	8082                	ret
