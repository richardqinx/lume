
build/user/echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/user.h"
#include "ulib/stdio.h"
#include "ulib/string.h"

int main(int argc, char* argv[])
{
       0:	7179                	addi	sp,sp,-48
       2:	f406                	sd	ra,40(sp)
    int i;

    for (i = 1; i < argc; i++)
       4:	4785                	li	a5,1
       6:	06a7d463          	bge	a5,a0,6e <main+0x6e>
       a:	e84a                	sd	s2,16(sp)
       c:	ffe5091b          	addiw	s2,a0,-2
      10:	02091793          	slli	a5,s2,0x20
      14:	01d7d913          	srli	s2,a5,0x1d
      18:	01058793          	addi	a5,a1,16
      1c:	f022                	sd	s0,32(sp)
      1e:	e44e                	sd	s3,8(sp)
      20:	ec26                	sd	s1,24(sp)
      22:	00858413          	addi	s0,a1,8
      26:	993e                	add	s2,s2,a5
    {
        write(1, argv[i], strlen(argv[i]));
        if (i + 1 < argc)
        {
            write(1, " ", 1);
      28:	00005997          	auipc	s3,0x5
      2c:	fb898993          	addi	s3,s3,-72 # 4fe0 <_GLOBAL__sub_I__ZSt3cin+0x32>
      30:	a019                	j	36 <main+0x36>
      32:	07c000ef          	jal	ae <write>
        write(1, argv[i], strlen(argv[i]));
      36:	6004                	ld	s1,0(s0)
        if (i + 1 < argc)
      38:	0421                	addi	s0,s0,8
        write(1, argv[i], strlen(argv[i]));
      3a:	8526                	mv	a0,s1
      3c:	2f3040ef          	jal	4b2e <strlen>
      40:	0005061b          	sext.w	a2,a0
      44:	85a6                	mv	a1,s1
      46:	4505                	li	a0,1
      48:	066000ef          	jal	ae <write>
            write(1, " ", 1);
      4c:	4605                	li	a2,1
      4e:	85ce                	mv	a1,s3
      50:	4505                	li	a0,1
        if (i + 1 < argc)
      52:	ff2410e3          	bne	s0,s2,32 <main+0x32>
        }
        else
        {
            write(1, "\n", 1);
      56:	4605                	li	a2,1
      58:	00005597          	auipc	a1,0x5
      5c:	f9058593          	addi	a1,a1,-112 # 4fe8 <_GLOBAL__sub_I__ZSt3cin+0x3a>
      60:	4505                	li	a0,1
      62:	04c000ef          	jal	ae <write>
      66:	7402                	ld	s0,32(sp)
      68:	64e2                	ld	s1,24(sp)
      6a:	6942                	ld	s2,16(sp)
      6c:	69a2                	ld	s3,8(sp)
        }
    }
    exit(0);
      6e:	4501                	li	a0,0
      70:	35c040ef          	jal	43cc <exit>
      74:	70a2                	ld	ra,40(sp)
      76:	4501                	li	a0,0
      78:	6145                	addi	sp,sp,48
      7a:	8082                	ret

000000000000007c <_start>:
.global _start

_start:


    call main
      7c:	f85ff0ef          	jal	0 <main>

    call exit
      80:	34c040ef          	jal	43cc <exit>

      84:	a001                	j	84 <_start+0x8>

0000000000000086 <sys_exit>:
    name: \
        li a7, SYS_ ## sysname; \
        ecall; \
        ret

SYSCALL_NAME(sys_exit, exit) 
      86:	488d                	li	a7,3
      88:	00000073          	ecall
      8c:	8082                	ret

000000000000008e <fork>:

SYSCALL(fork)
      8e:	4889                	li	a7,2
      90:	00000073          	ecall
      94:	8082                	ret

0000000000000096 <wait>:
SYSCALL(wait)
      96:	4891                	li	a7,4
      98:	00000073          	ecall
      9c:	8082                	ret

000000000000009e <pipe>:
SYSCALL(pipe)
      9e:	4895                	li	a7,5
      a0:	00000073          	ecall
      a4:	8082                	ret

00000000000000a6 <read>:
SYSCALL(read)
      a6:	4899                	li	a7,6
      a8:	00000073          	ecall
      ac:	8082                	ret

00000000000000ae <write>:
SYSCALL(write)
      ae:	48c5                	li	a7,17
      b0:	00000073          	ecall
      b4:	8082                	ret

00000000000000b6 <close>:
SYSCALL(close)
      b6:	48d9                	li	a7,22
      b8:	00000073          	ecall
      bc:	8082                	ret

00000000000000be <kill>:
SYSCALL(kill)
      be:	489d                	li	a7,7
      c0:	00000073          	ecall
      c4:	8082                	ret

00000000000000c6 <exec>:
SYSCALL(exec)
      c6:	48a1                	li	a7,8
      c8:	00000073          	ecall
      cc:	8082                	ret

00000000000000ce <open>:
SYSCALL(open)
      ce:	48c1                	li	a7,16
      d0:	00000073          	ecall
      d4:	8082                	ret

00000000000000d6 <mknod>:
SYSCALL(mknod)
      d6:	48c9                	li	a7,18
      d8:	00000073          	ecall
      dc:	8082                	ret

00000000000000de <unlink>:
SYSCALL(unlink)
      de:	48cd                	li	a7,19
      e0:	00000073          	ecall
      e4:	8082                	ret

00000000000000e6 <fstat>:
SYSCALL(fstat)
      e6:	48a5                	li	a7,9
      e8:	00000073          	ecall
      ec:	8082                	ret

00000000000000ee <link>:
SYSCALL(link)
      ee:	48d1                	li	a7,20
      f0:	00000073          	ecall
      f4:	8082                	ret

00000000000000f6 <mkdir>:
SYSCALL(mkdir)
      f6:	48d5                	li	a7,21
      f8:	00000073          	ecall
      fc:	8082                	ret

00000000000000fe <chdir>:
SYSCALL(chdir)
      fe:	48a9                	li	a7,10
     100:	00000073          	ecall
     104:	8082                	ret

0000000000000106 <dup>:
SYSCALL(dup)
     106:	48ad                	li	a7,11
     108:	00000073          	ecall
     10c:	8082                	ret

000000000000010e <getpid>:
SYSCALL(getpid)
     10e:	48b1                	li	a7,12
     110:	00000073          	ecall
     114:	8082                	ret

0000000000000116 <sbrk>:
SYSCALL(sbrk)
     116:	48b5                	li	a7,13
     118:	00000073          	ecall
     11c:	8082                	ret

000000000000011e <sleep>:
SYSCALL(sleep)
     11e:	48b9                	li	a7,14
     120:	00000073          	ecall
     124:	8082                	ret

0000000000000126 <uptime>:
SYSCALL(uptime)
     126:	48bd                	li	a7,15
     128:	00000073          	ecall
     12c:	8082                	ret

000000000000012e <putc>:
SYSCALL(putc)
     12e:	4885                	li	a7,1
     130:	00000073          	ecall
     134:	8082                	ret

0000000000000136 <disk_test>:
SYSCALL(disk_test)
     136:	48dd                	li	a7,23
     138:	00000073          	ecall
     13c:	8082                	ret

000000000000013e <lseek>:
SYSCALL(lseek)
     13e:	48e1                	li	a7,24
     140:	00000073          	ecall
     144:	8082                	ret

0000000000000146 <shutdown>:
     146:	48e5                	li	a7,25
     148:	00000073          	ecall
     14c:	8082                	ret

000000000000014e <stbsp__clamp_callback>:
     14e:	45dc                	lw	a5,12(a1)
     150:	4598                	lw	a4,8(a1)
     152:	9fb1                	addw	a5,a5,a2
     154:	c5dc                	sw	a5,12(a1)
     156:	0007069b          	sext.w	a3,a4
     15a:	00e65463          	bge	a2,a4,162 <stbsp__clamp_callback+0x14>
     15e:	0006069b          	sext.w	a3,a2
     162:	c685                	beqz	a3,18a <stbsp__clamp_callback+0x3c>
     164:	619c                	ld	a5,0(a1)
     166:	00a78e63          	beq	a5,a0,182 <stbsp__clamp_callback+0x34>
     16a:	00d50633          	add	a2,a0,a3
     16e:	00054703          	lbu	a4,0(a0)
     172:	0505                	addi	a0,a0,1
     174:	0785                	addi	a5,a5,1
     176:	fee78fa3          	sb	a4,-1(a5)
     17a:	fec56ae3          	bltu	a0,a2,16e <stbsp__clamp_callback+0x20>
     17e:	6188                	ld	a0,0(a1)
     180:	4598                	lw	a4,8(a1)
     182:	9f15                	subw	a4,a4,a3
     184:	9536                	add	a0,a0,a3
     186:	e188                	sd	a0,0(a1)
     188:	c598                	sw	a4,8(a1)
     18a:	1ff00793          	li	a5,511
     18e:	00e7d463          	bge	a5,a4,196 <stbsp__clamp_callback+0x48>
     192:	6188                	ld	a0,0(a1)
     194:	8082                	ret
     196:	01058513          	addi	a0,a1,16
     19a:	8082                	ret

000000000000019c <stbsp__count_clamp_callback>:
     19c:	45dc                	lw	a5,12(a1)
     19e:	01058513          	addi	a0,a1,16
     1a2:	9fb1                	addw	a5,a5,a2
     1a4:	c5dc                	sw	a5,12(a1)
     1a6:	8082                	ret

00000000000001a8 <stbsp__real_to_str>:
     1a8:	e20508d3          	fmv.x.d	a7,fa0
     1ac:	82aa                	mv	t0,a0
     1ae:	4348d813          	srai	a6,a7,0x34
     1b2:	8ec6                	mv	t4,a7
     1b4:	7ff87813          	andi	a6,a6,2047
     1b8:	8346                	mv	t1,a7
     1ba:	03f8d513          	srli	a0,a7,0x3f
     1be:	0008d663          	bgez	a7,1ca <stbsp__real_to_str+0x22>
     1c2:	22a517d3          	fneg.d	fa5,fa0
     1c6:	e20788d3          	fmv.x.d	a7,fa5
     1ca:	7ff00e13          	li	t3,2047
     1ce:	35c80663          	beq	a6,t3,51a <stbsp__real_to_str+0x372>
     1d2:	1101                	addi	sp,sp,-32
     1d4:	14080363          	beqz	a6,31a <stbsp__real_to_str+0x172>
     1d8:	c018081b          	addiw	a6,a6,-1023
     1dc:	ec22                	sd	s0,24(sp)
     1de:	02081313          	slli	t1,a6,0x20
     1e2:	66034d63          	bltz	t1,85c <stbsp__real_to_str+0x6b4>
     1e6:	4d100313          	li	t1,1233
     1ea:	0303033b          	mulw	t1,t1,a6
     1ee:	4849                	li	a6,18
     1f0:	40c3531b          	sraiw	t1,t1,0xc
     1f4:	0013039b          	addiw	t2,t1,1
     1f8:	4078083b          	subw	a6,a6,t2
     1fc:	4359                	li	t1,22
     1fe:	17036163          	bltu	t1,a6,360 <stbsp__real_to_str+0x1b8>
     202:	00005317          	auipc	t1,0x5
     206:	12630313          	addi	t1,t1,294 # 5328 <stbsp__bot>
     20a:	080e                	slli	a6,a6,0x3
     20c:	981a                	add	a6,a6,t1
     20e:	00083e03          	ld	t3,0(a6)
     212:	00083607          	fld	fa2,0(a6)
     216:	f20887d3          	fmv.d.x	fa5,a7
     21a:	f8000837          	lui	a6,0xf8000
     21e:	01187333          	and	t1,a6,a7
     222:	01c87833          	and	a6,a6,t3
     226:	12f676d3          	fmul.d	fa3,fa2,fa5
     22a:	f20807d3          	fmv.d.x	fa5,a6
     22e:	f2030753          	fmv.d.x	fa4,t1
     232:	f20305d3          	fmv.d.x	fa1,t1
     236:	0af67653          	fsub.d	fa2,fa2,fa5
     23a:	f20887d3          	fmv.d.x	fa5,a7
     23e:	0ae7f753          	fsub.d	fa4,fa5,fa4
     242:	f20807d3          	fmv.d.x	fa5,a6
     246:	6ab7f7c7          	fmsub.d	fa5,fa5,fa1,fa3
     24a:	7ab677c3          	fmadd.d	fa5,fa2,fa1,fa5
     24e:	f20805d3          	fmv.d.x	fa1,a6
     252:	7ab777c3          	fmadd.d	fa5,fa4,fa1,fa5
     256:	7ac77743          	fmadd.d	fa4,fa4,fa2,fa5
     25a:	02d777d3          	fadd.d	fa5,fa4,fa3
     25e:	3782e837          	lui	a6,0x3782e
     262:	acf80813          	addi	a6,a6,-1329 # 3782dacf <_ZSt4cerr+0x37826317>
     266:	0832                	slli	a6,a6,0xc
     268:	9d980813          	addi	a6,a6,-1575
     26c:	084a                	slli	a6,a6,0x12
     26e:	187d                	addi	a6,a6,-1
     270:	c22798d3          	fcvt.l.d	a7,fa5,rtz
     274:	0ad7f6d3          	fsub.d	fa3,fa5,fa3
     278:	00070e1b          	sext.w	t3,a4
     27c:	d228f653          	fcvt.d.l	fa2,a7
     280:	0ac7f5d3          	fsub.d	fa1,fa5,fa2
     284:	0ad77753          	fsub.d	fa4,fa4,fa3
     288:	0af5f6d3          	fsub.d	fa3,fa1,fa5
     28c:	0ad5f553          	fsub.d	fa0,fa1,fa3
     290:	02d67653          	fadd.d	fa2,fa2,fa3
     294:	0aa7f7d3          	fsub.d	fa5,fa5,fa0
     298:	0ac7f7d3          	fsub.d	fa5,fa5,fa2
     29c:	02b7f7d3          	fadd.d	fa5,fa5,fa1
     2a0:	02e7f7d3          	fadd.d	fa5,fa5,fa4
     2a4:	c2279fd3          	fcvt.l.d	t6,fa5,rtz
     2a8:	9fc6                	add	t6,t6,a7
     2aa:	19f87063          	bgeu	a6,t6,42a <stbsp__real_to_str+0x282>
     2ae:	2385                	addiw	t2,t2,1
     2b0:	300e4363          	bltz	t3,5b6 <stbsp__real_to_str+0x40e>
     2b4:	00e3833b          	addw	t1,t2,a4
     2b8:	475d                	li	a4,23
     2ba:	30677663          	bgeu	a4,t1,5c6 <stbsp__real_to_str+0x41e>
     2be:	577d                	li	a4,-1
     2c0:	9301                	srli	a4,a4,0x20
     2c2:	43f75863          	bge	a4,t6,6f2 <stbsp__real_to_str+0x54a>
     2c6:	07d00313          	li	t1,125
     2ca:	877e                	mv	a4,t6
     2cc:	4e01                	li	t3,0
     2ce:	3e800813          	li	a6,1000
     2d2:	130e                	slli	t1,t1,0x23
     2d4:	a039                	j	2e2 <stbsp__real_to_str+0x13a>
     2d6:	030747b3          	div	a5,a4,a6
     2da:	4e05                	li	t3,1
     2dc:	40674c63          	blt	a4,t1,6f4 <stbsp__real_to_str+0x54c>
     2e0:	873e                	mv	a4,a5
     2e2:	030768b3          	rem	a7,a4,a6
     2e6:	fe0888e3          	beqz	a7,2d6 <stbsp__real_to_str+0x12e>
     2ea:	400e0163          	beqz	t3,6ec <stbsp__real_to_str+0x544>
     2ee:	8fbe                	mv	t6,a5
     2f0:	05f5e7b7          	lui	a5,0x5f5e
     2f4:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f56947>
     2f8:	04060413          	addi	s0,a2,64
     2fc:	03860613          	addi	a2,a2,56
     300:	15f7c863          	blt	a5,t6,450 <stbsp__real_to_str+0x2a8>
     304:	000f871b          	sext.w	a4,t6
     308:	20070463          	beqz	a4,510 <stbsp__real_to_str+0x368>
     30c:	4f01                	li	t5,0
     30e:	4f81                	li	t6,0
     310:	00006e97          	auipc	t4,0x6
     314:	5b0e8e93          	addi	t4,t4,1456 # 68c0 <stbsp__digitpair>
     318:	aaa9                	j	472 <stbsp__real_to_str+0x2ca>
     31a:	0306                	slli	t1,t1,0x1
     31c:	3e030e63          	beqz	t1,718 <stbsp__real_to_str+0x570>
     320:	4305                	li	t1,1
     322:	ec22                	sd	s0,24(sp)
     324:	00ce9e13          	slli	t3,t4,0xc
     328:	134e                	slli	t1,t1,0x33
     32a:	520e4063          	bltz	t3,84a <stbsp__real_to_str+0x6a2>
     32e:	40135313          	srai	t1,t1,0x1
     332:	01d37e33          	and	t3,t1,t4
     336:	8f42                	mv	t5,a6
     338:	387d                	addiw	a6,a6,-1
     33a:	fe0e0ae3          	beqz	t3,32e <stbsp__real_to_str+0x186>
     33e:	26900313          	li	t1,617
     342:	c00f081b          	addiw	a6,t5,-1024
     346:	0268083b          	mulw	a6,a6,t1
     34a:	41f8531b          	sraiw	t1,a6,0x1f
     34e:	0153531b          	srliw	t1,t1,0x15
     352:	0103033b          	addw	t1,t1,a6
     356:	40b3539b          	sraiw	t2,t1,0xb
     35a:	4849                	li	a6,18
     35c:	4078083b          	subw	a6,a6,t2
     360:	41f8531b          	sraiw	t1,a6,0x1f
     364:	00684eb3          	xor	t4,a6,t1
     368:	406e8f3b          	subw	t5,t4,t1
     36c:	2c900313          	li	t1,713
     370:	03e3033b          	mulw	t1,t1,t5
     374:	4e35                	li	t3,13
     376:	8efa                	mv	t4,t5
     378:	40e35f9b          	sraiw	t6,t1,0xe
     37c:	837e                	mv	t1,t6
     37e:	23fe4363          	blt	t3,t6,5a4 <stbsp__real_to_str+0x3fc>
     382:	5e25                	li	t3,-23
     384:	026e0e3b          	mulw	t3,t3,t1
     388:	01de0ebb          	addw	t4,t3,t4
     38c:	22084f63          	bltz	a6,5ca <stbsp__real_to_str+0x422>
     390:	f2000753          	fmv.d.x	fa4,zero
     394:	00005e17          	auipc	t3,0x5
     398:	f94e0e13          	addi	t3,t3,-108 # 5328 <stbsp__bot>
     39c:	380e9e63          	bnez	t4,738 <stbsp__real_to_str+0x590>
     3a0:	f20887d3          	fmv.d.x	fa5,a7
     3a4:	fff30f1b          	addiw	t5,t1,-1
     3a8:	0f0e                	slli	t5,t5,0x3
     3aa:	02f777d3          	fadd.d	fa5,fa4,fa5
     3ae:	030e                	slli	t1,t1,0x3
     3b0:	9f72                	add	t5,t5,t3
     3b2:	9e1a                	add	t3,t3,t1
     3b4:	2e0e3e03          	ld	t3,736(t3)
     3b8:	2e8f3587          	fld	fa1,744(t5)
     3bc:	f8000837          	lui	a6,0xf8000
     3c0:	e2078ed3          	fmv.x.d	t4,fa5
     3c4:	12b7f6d3          	fmul.d	fa3,fa5,fa1
     3c8:	f2088653          	fmv.d.x	fa2,a7
     3cc:	01d87333          	and	t1,a6,t4
     3d0:	01c87833          	and	a6,a6,t3
     3d4:	f20807d3          	fmv.d.x	fa5,a6
     3d8:	f2030053          	fmv.d.x	ft0,t1
     3dc:	0af5f553          	fsub.d	fa0,fa1,fa5
     3e0:	f20e87d3          	fmv.d.x	fa5,t4
     3e4:	0ac7f0d3          	fsub.d	ft1,fa5,fa2
     3e8:	f20807d3          	fmv.d.x	fa5,a6
     3ec:	f2030653          	fmv.d.x	fa2,t1
     3f0:	6ac7f647          	fmsub.d	fa2,fa5,fa2,fa3
     3f4:	f20e87d3          	fmv.d.x	fa5,t4
     3f8:	0a177753          	fsub.d	fa4,fa4,ft1
     3fc:	f20300d3          	fmv.d.x	ft1,t1
     400:	0a07f7d3          	fsub.d	fa5,fa5,ft0
     404:	350f3007          	fld	ft0,848(t5)
     408:	62157643          	fmadd.d	fa2,fa0,ft1,fa2
     40c:	12b77753          	fmul.d	fa4,fa4,fa1
     410:	f20805d3          	fmv.d.x	fa1,a6
     414:	62b7f643          	fmadd.d	fa2,fa5,fa1,fa2
     418:	f20e85d3          	fmv.d.x	fa1,t4
     41c:	7205f743          	fmadd.d	fa4,fa1,ft0,fa4
     420:	62a7f7c3          	fmadd.d	fa5,fa5,fa0,fa2
     424:	02e7f753          	fadd.d	fa4,fa5,fa4
     428:	bd0d                	j	25a <stbsp__real_to_str+0xb2>
     42a:	00e3833b          	addw	t1,t2,a4
     42e:	2a0e4663          	bltz	t3,6da <stbsp__real_to_str+0x532>
     432:	475d                	li	a4,23
     434:	10677663          	bgeu	a4,t1,540 <stbsp__real_to_str+0x398>
     438:	e80f93e3          	bnez	t6,2be <stbsp__real_to_str+0x116>
     43c:	05f5e7b7          	lui	a5,0x5f5e
     440:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f56947>
     444:	04060413          	addi	s0,a2,64
     448:	03860613          	addi	a2,a2,56
     44c:	ebf7dce3          	bge	a5,t6,304 <stbsp__real_to_str+0x15c>
     450:	4f01                	li	t5,0
     452:	00006e97          	auipc	t4,0x6
     456:	46ee8e93          	addi	t4,t4,1134 # 68c0 <stbsp__digitpair>
     45a:	05f5e7b7          	lui	a5,0x5f5e
     45e:	10078793          	addi	a5,a5,256 # 5f5e100 <_ZSt4cerr+0x5f56948>
     462:	02ffe833          	rem	a6,t6,a5
     466:	02ffcfb3          	div	t6,t6,a5
     46a:	0008071b          	sext.w	a4,a6
     46e:	0a080463          	beqz	a6,516 <stbsp__real_to_str+0x36e>
     472:	8822                	mv	a6,s0
     474:	06400893          	li	a7,100
     478:	06300e13          	li	t3,99
     47c:	1879                	addi	a6,a6,-2 # fffffffff7fffffe <_ZSt4cerr+0xfffffffff7ff8846>
     47e:	0007031b          	sext.w	t1,a4
     482:	031777bb          	remuw	a5,a4,a7
     486:	2785                	addiw	a5,a5,1
     488:	0017979b          	slliw	a5,a5,0x1
     48c:	1782                	slli	a5,a5,0x20
     48e:	9381                	srli	a5,a5,0x20
     490:	97f6                	add	a5,a5,t4
     492:	0007d783          	lhu	a5,0(a5)
     496:	0317573b          	divuw	a4,a4,a7
     49a:	00f81023          	sh	a5,0(a6)
     49e:	fc6e6fe3          	bltu	t3,t1,47c <stbsp__real_to_str+0x2d4>
     4a2:	008f0f3b          	addw	t5,t5,s0
     4a6:	410f0f3b          	subw	t5,t5,a6
     4aa:	020f8f63          	beqz	t6,4e8 <stbsp__real_to_str+0x340>
     4ae:	87c2                	mv	a5,a6
     4b0:	03000713          	li	a4,48
     4b4:	04c80c63          	beq	a6,a2,50c <stbsp__real_to_str+0x364>
     4b8:	17fd                	addi	a5,a5,-1
     4ba:	00e78023          	sb	a4,0(a5)
     4be:	fec79de3          	bne	a5,a2,4b8 <stbsp__real_to_str+0x310>
     4c2:	408807b3          	sub	a5,a6,s0
     4c6:	00ff07bb          	addw	a5,t5,a5
     4ca:	1461                	addi	s0,s0,-8
     4cc:	00878f1b          	addiw	t5,a5,8
     4d0:	05f5e7b7          	lui	a5,0x5f5e
     4d4:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f56947>
     4d8:	ff840613          	addi	a2,s0,-8
     4dc:	f7f7cfe3          	blt	a5,t6,45a <stbsp__real_to_str+0x2b2>
     4e0:	000f871b          	sext.w	a4,t6
     4e4:	4f81                	li	t6,0
     4e6:	b771                	j	472 <stbsp__real_to_str+0x2ca>
     4e8:	020f0563          	beqz	t5,512 <stbsp__real_to_str+0x36a>
     4ec:	00084703          	lbu	a4,0(a6)
     4f0:	03000793          	li	a5,48
     4f4:	22f70f63          	beq	a4,a5,732 <stbsp__real_to_str+0x58a>
     4f8:	2f01                	sext.w	t5,t5
     4fa:	0076a023          	sw	t2,0(a3)
     4fe:	6462                	ld	s0,24(sp)
     500:	0102b023          	sd	a6,0(t0)
     504:	01e5a023          	sw	t5,0(a1)
     508:	6105                	addi	sp,sp,32
     50a:	8082                	ret
     50c:	8442                	mv	s0,a6
     50e:	b7c9                	j	4d0 <stbsp__real_to_str+0x328>
     510:	8822                	mv	a6,s0
     512:	4f01                	li	t5,0
     514:	b7dd                	j	4fa <stbsp__real_to_str+0x352>
     516:	8822                	mv	a6,s0
     518:	bf59                	j	4ae <stbsp__real_to_str+0x306>
     51a:	0eb2                	slli	t4,t4,0xc
     51c:	00005797          	auipc	a5,0x5
     520:	adc78793          	addi	a5,a5,-1316 # 4ff8 <_GLOBAL__sub_I__ZSt3cin+0x4a>
     524:	000e8663          	beqz	t4,530 <stbsp__real_to_str+0x388>
     528:	00005797          	auipc	a5,0x5
     52c:	ac878793          	addi	a5,a5,-1336 # 4ff0 <_GLOBAL__sub_I__ZSt3cin+0x42>
     530:	00f2b023          	sd	a5,0(t0)
     534:	679d                	lui	a5,0x7
     536:	c29c                	sw	a5,0(a3)
     538:	4f0d                	li	t5,3
     53a:	01e5a023          	sw	t5,0(a1)
     53e:	8082                	ret
     540:	3b9ad737          	lui	a4,0x3b9ad
     544:	9ff70713          	addi	a4,a4,-1537 # 3b9ac9ff <_ZSt4cerr+0x3b9a5247>
     548:	07f76f63          	bltu	a4,t6,5c6 <stbsp__real_to_str+0x41e>
     54c:	4805                	li	a6,1
     54e:	02081713          	slli	a4,a6,0x20
     552:	01d75893          	srli	a7,a4,0x1d
     556:	00005717          	auipc	a4,0x5
     55a:	18a70713          	addi	a4,a4,394 # 56e0 <stbsp__powten>
     55e:	9746                	add	a4,a4,a7
     560:	4e51                	li	t3,20
     562:	a021                	j	56a <stbsp__real_to_str+0x3c2>
     564:	2805                	addiw	a6,a6,1
     566:	edc809e3          	beq	a6,t3,438 <stbsp__real_to_str+0x290>
     56a:	00073883          	ld	a7,0(a4)
     56e:	0721                	addi	a4,a4,8
     570:	ff1ffae3          	bgeu	t6,a7,564 <stbsp__real_to_str+0x3bc>
     574:	ed0372e3          	bgeu	t1,a6,438 <stbsp__real_to_str+0x290>
     578:	4068083b          	subw	a6,a6,t1
     57c:	475d                	li	a4,23
     57e:	eb076de3          	bltu	a4,a6,438 <stbsp__real_to_str+0x290>
     582:	080e                	slli	a6,a6,0x3
     584:	00005717          	auipc	a4,0x5
     588:	da470713          	addi	a4,a4,-604 # 5328 <stbsp__bot>
     58c:	9742                	add	a4,a4,a6
     58e:	3b873803          	ld	a6,952(a4)
     592:	00185713          	srli	a4,a6,0x1
     596:	977e                	add	a4,a4,t6
     598:	01176363          	bltu	a4,a7,59e <stbsp__real_to_str+0x3f6>
     59c:	2385                	addiw	t2,t2,1
     59e:	03075fb3          	divu	t6,a4,a6
     5a2:	bd59                	j	438 <stbsp__real_to_str+0x290>
     5a4:	4335                	li	t1,13
     5a6:	5e25                	li	t3,-23
     5a8:	026e0e3b          	mulw	t3,t3,t1
     5ac:	01de0ebb          	addw	t4,t3,t4
     5b0:	de0850e3          	bgez	a6,390 <stbsp__real_to_str+0x1e8>
     5b4:	a819                	j	5ca <stbsp__real_to_str+0x422>
     5b6:	02571313          	slli	t1,a4,0x25
     5ba:	02535313          	srli	t1,t1,0x25
     5be:	0305                	addi	t1,t1,1
     5c0:	475d                	li	a4,23
     5c2:	ce676ee3          	bltu	a4,t1,2be <stbsp__real_to_str+0x116>
     5c6:	4829                	li	a6,10
     5c8:	b759                	j	54e <stbsp__real_to_str+0x3a6>
     5ca:	260e8663          	beqz	t4,836 <stbsp__real_to_str+0x68e>
     5ce:	00231e13          	slli	t3,t1,0x2
     5d2:	41c30e33          	sub	t3,t1,t3
     5d6:	0e0e                	slli	t3,t3,0x3
     5d8:	9e1a                	add	t3,t3,t1
     5da:	fffe881b          	addiw	a6,t4,-1
     5de:	9e7a                	add	t3,t3,t5
     5e0:	00005e97          	auipc	t4,0x5
     5e4:	d48e8e93          	addi	t4,t4,-696 # 5328 <stbsp__bot>
     5e8:	0e0e                	slli	t3,t3,0x3
     5ea:	080e                	slli	a6,a6,0x3
     5ec:	9876                	add	a6,a6,t4
     5ee:	9ef2                	add	t4,t4,t3
     5f0:	0b883607          	fld	fa2,184(a6)
     5f4:	f20887d3          	fmv.d.x	fa5,a7
     5f8:	0b0ebf03          	ld	t5,176(t4)
     5fc:	f8000e37          	lui	t3,0xf8000
     600:	011e7eb3          	and	t4,t3,a7
     604:	12f676d3          	fmul.d	fa3,fa2,fa5
     608:	01ee7e33          	and	t3,t3,t5
     60c:	f20e07d3          	fmv.d.x	fa5,t3
     610:	f20e0753          	fmv.d.x	fa4,t3
     614:	f20e8553          	fmv.d.x	fa0,t4
     618:	0af67653          	fsub.d	fa2,fa2,fa5
     61c:	f20e87d3          	fmv.d.x	fa5,t4
     620:	f20e85d3          	fmv.d.x	fa1,t4
     624:	6ae7f7c7          	fmsub.d	fa5,fa5,fa4,fa3
     628:	f2088753          	fmv.d.x	fa4,a7
     62c:	0ab775d3          	fsub.d	fa1,fa4,fa1
     630:	16883707          	fld	fa4,360(a6)
     634:	7aa677c3          	fmadd.d	fa5,fa2,fa0,fa5
     638:	f20e0553          	fmv.d.x	fa0,t3
     63c:	7aa5f7c3          	fmadd.d	fa5,fa1,fa0,fa5
     640:	7ac5f5c3          	fmadd.d	fa1,fa1,fa2,fa5
     644:	f20887d3          	fmv.d.x	fa5,a7
     648:	5af77743          	fmadd.d	fa4,fa4,fa5,fa1
     64c:	c00f87e3          	beqz	t6,25a <stbsp__real_to_str+0xb2>
     650:	02d777d3          	fadd.d	fa5,fa4,fa3
     654:	fff3089b          	addiw	a7,t1,-1
     658:	00005817          	auipc	a6,0x5
     65c:	cd080813          	addi	a6,a6,-816 # 5328 <stbsp__bot>
     660:	030e                	slli	t1,t1,0x3
     662:	088e                	slli	a7,a7,0x3
     664:	98c2                	add	a7,a7,a6
     666:	981a                	add	a6,a6,t1
     668:	e2078e53          	fmv.x.d	t3,fa5
     66c:	21083e83          	ld	t4,528(a6)
     670:	f8000837          	lui	a6,0xf8000
     674:	2188b507          	fld	fa0,536(a7)
     678:	01c87333          	and	t1,a6,t3
     67c:	01d87833          	and	a6,a6,t4
     680:	f2080653          	fmv.d.x	fa2,a6
     684:	12f577d3          	fmul.d	fa5,fa0,fa5
     688:	2808b587          	fld	fa1,640(a7)
     68c:	0ac57053          	fsub.d	ft0,fa0,fa2
     690:	f20e0653          	fmv.d.x	fa2,t3
     694:	0ad67153          	fsub.d	ft2,fa2,fa3
     698:	f20806d3          	fmv.d.x	fa3,a6
     69c:	f2030653          	fmv.d.x	fa2,t1
     6a0:	7ac6f0c7          	fmsub.d	ft1,fa3,fa2,fa5
     6a4:	f20e06d3          	fmv.d.x	fa3,t3
     6a8:	0ac6f653          	fsub.d	fa2,fa3,fa2
     6ac:	22f786d3          	fmv.d	fa3,fa5
     6b0:	0a2777d3          	fsub.d	fa5,fa4,ft2
     6b4:	f2030753          	fmv.d.x	fa4,t1
     6b8:	0ae07743          	fmadd.d	fa4,ft0,fa4,ft1
     6bc:	12a7f7d3          	fmul.d	fa5,fa5,fa0
     6c0:	f2080553          	fmv.d.x	fa0,a6
     6c4:	72a67743          	fmadd.d	fa4,fa2,fa0,fa4
     6c8:	f20e0553          	fmv.d.x	fa0,t3
     6cc:	7aa5f7c3          	fmadd.d	fa5,fa1,fa0,fa5
     6d0:	72067643          	fmadd.d	fa2,fa2,ft0,fa4
     6d4:	02f67753          	fadd.d	fa4,fa2,fa5
     6d8:	b649                	j	25a <stbsp__real_to_str+0xb2>
     6da:	02571313          	slli	t1,a4,0x25
     6de:	02535313          	srli	t1,t1,0x25
     6e2:	0305                	addi	t1,t1,1
     6e4:	475d                	li	a4,23
     6e6:	d46769e3          	bltu	a4,t1,438 <stbsp__real_to_str+0x290>
     6ea:	bd99                	j	540 <stbsp__real_to_str+0x398>
     6ec:	87fe                	mv	a5,t6
     6ee:	8fbe                	mv	t6,a5
     6f0:	b101                	j	2f0 <stbsp__real_to_str+0x148>
     6f2:	87fe                	mv	a5,t6
     6f4:	3e800713          	li	a4,1000
     6f8:	02e7f73b          	remuw	a4,a5,a4
     6fc:	2781                	sext.w	a5,a5
     6fe:	eb01                	bnez	a4,70e <stbsp__real_to_str+0x566>
     700:	3e800813          	li	a6,1000
     704:	0307d7bb          	divuw	a5,a5,a6
     708:	0307f73b          	remuw	a4,a5,a6
     70c:	df65                	beqz	a4,704 <stbsp__real_to_str+0x55c>
     70e:	02079f93          	slli	t6,a5,0x20
     712:	020fdf93          	srli	t6,t6,0x20
     716:	b31d                	j	43c <stbsp__real_to_str+0x294>
     718:	4785                	li	a5,1
     71a:	c29c                	sw	a5,0(a3)
     71c:	00c2b023          	sd	a2,0(t0)
     720:	03000793          	li	a5,48
     724:	00f60023          	sb	a5,0(a2)
     728:	4f05                	li	t5,1
     72a:	01e5a023          	sw	t5,0(a1)
     72e:	6105                	addi	sp,sp,32
     730:	8082                	ret
     732:	0805                	addi	a6,a6,1 # fffffffff8000001 <_ZSt4cerr+0xfffffffff7ff8849>
     734:	3f7d                	addiw	t5,t5,-1
     736:	b3d1                	j	4fa <stbsp__real_to_str+0x352>
     738:	e826                	sd	s1,16(sp)
     73a:	e44a                	sd	s2,8(sp)
     73c:	4859                	li	a6,22
     73e:	8976                	mv	s2,t4
     740:	11d84363          	blt	a6,t4,846 <stbsp__real_to_str+0x69e>
     744:	0009049b          	sext.w	s1,s2
     748:	00005e17          	auipc	t3,0x5
     74c:	be0e0e13          	addi	t3,t3,-1056 # 5328 <stbsp__bot>
     750:	00349813          	slli	a6,s1,0x3
     754:	9872                	add	a6,a6,t3
     756:	00083687          	fld	fa3,0(a6)
     75a:	00083803          	ld	a6,0(a6)
     75e:	f20887d3          	fmv.d.x	fa5,a7
     762:	f8000fb7          	lui	t6,0xf8000
     766:	010ff833          	and	a6,t6,a6
     76a:	12f6f553          	fmul.d	fa0,fa3,fa5
     76e:	f20807d3          	fmv.d.x	fa5,a6
     772:	011ff433          	and	s0,t6,a7
     776:	f2040753          	fmv.d.x	fa4,s0
     77a:	0af6f6d3          	fsub.d	fa3,fa3,fa5
     77e:	f20887d3          	fmv.d.x	fa5,a7
     782:	f2080653          	fmv.d.x	fa2,a6
     786:	412e8ebb          	subw	t4,t4,s2
     78a:	0ae7f753          	fsub.d	fa4,fa5,fa4
     78e:	f20407d3          	fmv.d.x	fa5,s0
     792:	e20508d3          	fmv.x.d	a7,fa0
     796:	52c7f7c7          	fmsub.d	fa5,fa5,fa2,fa0
     79a:	f2040653          	fmv.d.x	fa2,s0
     79e:	7ac6f7c3          	fmadd.d	fa5,fa3,fa2,fa5
     7a2:	f2080653          	fmv.d.x	fa2,a6
     7a6:	7ac777c3          	fmadd.d	fa5,fa4,fa2,fa5
     7aa:	7ad77743          	fmadd.d	fa4,fa4,fa3,fa5
     7ae:	080e8963          	beqz	t4,840 <stbsp__real_to_str+0x698>
     7b2:	02e577d3          	fadd.d	fa5,fa0,fa4
     7b6:	0e8e                	slli	t4,t4,0x3
     7b8:	01de0833          	add	a6,t3,t4
     7bc:	00083587          	fld	fa1,0(a6)
     7c0:	00231893          	slli	a7,t1,0x2
     7c4:	411308b3          	sub	a7,t1,a7
     7c8:	00389813          	slli	a6,a7,0x3
     7cc:	e2078453          	fmv.x.d	s0,fa5
     7d0:	12f5f7d3          	fmul.d	fa5,fa1,fa5
     7d4:	981a                	add	a6,a6,t1
     7d6:	987a                	add	a6,a6,t5
     7d8:	40980833          	sub	a6,a6,s1
     7dc:	080e                	slli	a6,a6,0x3
     7de:	9872                	add	a6,a6,t3
     7e0:	00083e83          	ld	t4,0(a6)
     7e4:	008ff833          	and	a6,t6,s0
     7e8:	e20788d3          	fmv.x.d	a7,fa5
     7ec:	f20806d3          	fmv.d.x	fa3,a6
     7f0:	f20407d3          	fmv.d.x	fa5,s0
     7f4:	01dfffb3          	and	t6,t6,t4
     7f8:	f20880d3          	fmv.d.x	ft1,a7
     7fc:	0ad7f653          	fsub.d	fa2,fa5,fa3
     800:	f20f87d3          	fmv.d.x	fa5,t6
     804:	64c2                	ld	s1,16(sp)
     806:	6922                	ld	s2,8(sp)
     808:	0af5f053          	fsub.d	ft0,fa1,fa5
     80c:	0ad7f6c7          	fmsub.d	fa3,fa5,fa3,ft1
     810:	f20407d3          	fmv.d.x	fa5,s0
     814:	0aa7f7d3          	fsub.d	fa5,fa5,fa0
     818:	f2080553          	fmv.d.x	fa0,a6
     81c:	6aa076c3          	fmadd.d	fa3,ft0,fa0,fa3
     820:	0af77753          	fsub.d	fa4,fa4,fa5
     824:	f20f87d3          	fmv.d.x	fa5,t6
     828:	6af677c3          	fmadd.d	fa5,fa2,fa5,fa3
     82c:	7a067643          	fmadd.d	fa2,fa2,ft0,fa5
     830:	62e5f743          	fmadd.d	fa4,fa1,fa4,fa2
     834:	b6b5                	j	3a0 <stbsp__real_to_str+0x1f8>
     836:	f20886d3          	fmv.d.x	fa3,a7
     83a:	f2000753          	fmv.d.x	fa4,zero
     83e:	b539                	j	64c <stbsp__real_to_str+0x4a4>
     840:	64c2                	ld	s1,16(sp)
     842:	6922                	ld	s2,8(sp)
     844:	beb1                	j	3a0 <stbsp__real_to_str+0x1f8>
     846:	4959                	li	s2,22
     848:	bdf5                	j	744 <stbsp__real_to_str+0x59c>
     84a:	e826                	sd	s1,16(sp)
     84c:	e44a                	sd	s2,8(sp)
     84e:	ecc00393          	li	t2,-308
     852:	4eed                	li	t4,27
     854:	4335                	li	t1,13
     856:	14600f13          	li	t5,326
     85a:	b5cd                	j	73c <stbsp__real_to_str+0x594>
     85c:	26900313          	li	t1,617
     860:	0303083b          	mulw	a6,t1,a6
     864:	41f8531b          	sraiw	t1,a6,0x1f
     868:	0153531b          	srliw	t1,t1,0x15
     86c:	0103033b          	addw	t1,t1,a6
     870:	40b3539b          	sraiw	t2,t1,0xb
     874:	4849                	li	a6,18
     876:	4078083b          	subw	a6,a6,t2
     87a:	b249                	j	1fc <stbsp__real_to_str+0x54>

000000000000087c <_in_char.part.0>:
static int _in_char(_InContext *ctx)
     87c:	87aa                	mv	a5,a0
    if (ctx->fd == -1)
     87e:	4508                	lw	a0,8(a0)
     880:	577d                	li	a4,-1
     882:	00e51d63          	bne	a0,a4,89c <_in_char.part.0+0x20>
        if (ctx->buf[ctx->pos] == '\0')
     886:	6b94                	ld	a3,16(a5)
     888:	6398                	ld	a4,0(a5)
     88a:	9736                	add	a4,a4,a3
     88c:	00074603          	lbu	a2,0(a4)
     890:	c60d                	beqz	a2,8ba <_in_char.part.0+0x3e>
        return (unsigned char)ctx->buf[ctx->pos++];
     892:	0685                	addi	a3,a3,1
     894:	eb94                	sd	a3,16(a5)
     896:	00074503          	lbu	a0,0(a4)
     89a:	8082                	ret
static int _in_char(_InContext *ctx)
     89c:	1101                	addi	sp,sp,-32
    if (read(ctx->fd, &c, 1) == 1)
     89e:	4605                	li	a2,1
     8a0:	00f10593          	addi	a1,sp,15
static int _in_char(_InContext *ctx)
     8a4:	ec06                	sd	ra,24(sp)
    if (read(ctx->fd, &c, 1) == 1)
     8a6:	801ff0ef          	jal	a6 <read>
     8aa:	4785                	li	a5,1
     8ac:	00f51963          	bne	a0,a5,8be <_in_char.part.0+0x42>
        return (unsigned char)c;
     8b0:	00f14503          	lbu	a0,15(sp)
}
     8b4:	60e2                	ld	ra,24(sp)
     8b6:	6105                	addi	sp,sp,32
     8b8:	8082                	ret
            return -1;
     8ba:	557d                	li	a0,-1
}
     8bc:	8082                	ret
            return -1;
     8be:	557d                	li	a0,-1
     8c0:	bfd5                	j	8b4 <_in_char.part.0+0x38>

00000000000008c2 <_skip_space>:
{
     8c2:	7139                	addi	sp,sp,-64
     8c4:	f822                	sd	s0,48(sp)
     8c6:	f426                	sd	s1,40(sp)
     8c8:	f04a                	sd	s2,32(sp)
     8ca:	ec4e                	sd	s3,24(sp)
     8cc:	e852                	sd	s4,16(sp)
     8ce:	fc06                	sd	ra,56(sp)
     8d0:	842a                	mv	s0,a0
        ctx->ungotten = -1;
     8d2:	54fd                	li	s1,-1
    if (read(ctx->fd, &c, 1) == 1)
     8d4:	00f10a13          	addi	s4,sp,15
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     8d8:	02000913          	li	s2,32
     8dc:	4991                	li	s3,4
    if (ctx->ungotten >= 0)
     8de:	4c1c                	lw	a5,24(s0)
     8e0:	0407d163          	bgez	a5,922 <_skip_space+0x60>
    if (ctx->fd == -1)
     8e4:	4408                	lw	a0,8(s0)
    if (read(ctx->fd, &c, 1) == 1)
     8e6:	4605                	li	a2,1
     8e8:	85d2                	mv	a1,s4
    if (ctx->fd == -1)
     8ea:	02951e63          	bne	a0,s1,926 <_skip_space+0x64>
        if (ctx->buf[ctx->pos] == '\0')
     8ee:	6818                	ld	a4,16(s0)
     8f0:	601c                	ld	a5,0(s0)
        return (unsigned char)ctx->buf[ctx->pos++];
     8f2:	00170693          	addi	a3,a4,1
        if (ctx->buf[ctx->pos] == '\0')
     8f6:	97ba                	add	a5,a5,a4
     8f8:	0007c703          	lbu	a4,0(a5) # 7000 <_stdout+0x220>
     8fc:	cb19                	beqz	a4,912 <_skip_space+0x50>
        return (unsigned char)ctx->buf[ctx->pos++];
     8fe:	e814                	sd	a3,16(s0)
     900:	0007c783          	lbu	a5,0(a5)
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     904:	ff77871b          	addiw	a4,a5,-9
     908:	fd278be3          	beq	a5,s2,8de <_skip_space+0x1c>
     90c:	fce9f9e3          	bgeu	s3,a4,8de <_skip_space+0x1c>
        ctx->ungotten = c;
     910:	cc1c                	sw	a5,24(s0)
}
     912:	70e2                	ld	ra,56(sp)
     914:	7442                	ld	s0,48(sp)
     916:	74a2                	ld	s1,40(sp)
     918:	7902                	ld	s2,32(sp)
     91a:	69e2                	ld	s3,24(sp)
     91c:	6a42                	ld	s4,16(sp)
     91e:	6121                	addi	sp,sp,64
     920:	8082                	ret
        ctx->ungotten = -1;
     922:	cc04                	sw	s1,24(s0)
        return c;
     924:	b7c5                	j	904 <_skip_space+0x42>
    if (read(ctx->fd, &c, 1) == 1)
     926:	f80ff0ef          	jal	a6 <read>
     92a:	4785                	li	a5,1
     92c:	fef513e3          	bne	a0,a5,912 <_skip_space+0x50>
        return (unsigned char)c;
     930:	00f14783          	lbu	a5,15(sp)
     934:	bfc1                	j	904 <_skip_space+0x42>

0000000000000936 <_vscanf_core.constprop.0>:
static int _vscanf_core(_InContext *ctx, const char *format, va_list ap)
     936:	7155                	addi	sp,sp,-208
     938:	e586                	sd	ra,200(sp)
     93a:	e95a                	sd	s6,144(sp)
    while (*p)
     93c:	0005c783          	lbu	a5,0(a1)
static int _vscanf_core(_InContext *ctx, const char *format, va_list ap)
     940:	e432                	sd	a2,8(sp)
    while (*p)
     942:	68078b63          	beqz	a5,fd8 <_vscanf_core.constprop.0+0x6a2>
     946:	e1a2                	sd	s0,192(sp)
     948:	fd26                	sd	s1,184(sp)
     94a:	f152                	sd	s4,160(sp)
     94c:	ed56                	sd	s5,152(sp)
     94e:	f4ee                	sd	s11,104(sp)
     950:	842e                	mv	s0,a1
     952:	8daa                	mv	s11,a0
    int assigned = 0;
     954:	4b01                	li	s6,0
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     956:	02000493          	li	s1,32
     95a:	4a91                	li	s5,4
        if (*p != '%')
     95c:	02500a13          	li	s4,37
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     960:	04978763          	beq	a5,s1,9ae <_vscanf_core.constprop.0+0x78>
     964:	ff77869b          	addiw	a3,a5,-9
     968:	0ff6f693          	zext.b	a3,a3
     96c:	04daf163          	bgeu	s5,a3,9ae <_vscanf_core.constprop.0+0x78>
        if (*p != '%')
     970:	07478d63          	beq	a5,s4,9ea <_vscanf_core.constprop.0+0xb4>
            _skip_space(ctx);
     974:	856e                	mv	a0,s11
     976:	f4dff0ef          	jal	8c2 <_skip_space>
    if (ctx->ungotten >= 0)
     97a:	018da503          	lw	a0,24(s11)
     97e:	04055a63          	bgez	a0,9d2 <_vscanf_core.constprop.0+0x9c>
     982:	856e                	mv	a0,s11
     984:	ef9ff0ef          	jal	87c <_in_char.part.0>
            if (c != *p)
     988:	00044783          	lbu	a5,0(s0)
     98c:	04a78a63          	beq	a5,a0,9e0 <_vscanf_core.constprop.0+0xaa>
    if (c != -1)
     990:	57fd                	li	a5,-1
     992:	00f50463          	beq	a0,a5,99a <_vscanf_core.constprop.0+0x64>
        ctx->ungotten = c;
     996:	00adac23          	sw	a0,24(s11)
     99a:	640e                	ld	s0,192(sp)
     99c:	74ea                	ld	s1,184(sp)
     99e:	7a0a                	ld	s4,160(sp)
     9a0:	6aea                	ld	s5,152(sp)
     9a2:	7da6                	ld	s11,104(sp)
}
     9a4:	60ae                	ld	ra,200(sp)
     9a6:	855a                	mv	a0,s6
     9a8:	6b4a                	ld	s6,144(sp)
     9aa:	6169                	addi	sp,sp,208
     9ac:	8082                	ret
            _skip_space(ctx);
     9ae:	856e                	mv	a0,s11
     9b0:	f13ff0ef          	jal	8c2 <_skip_space>
            while (isspace(*p))
     9b4:	00044783          	lbu	a5,0(s0)
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     9b8:	4611                	li	a2,4
     9ba:	ff77869b          	addiw	a3,a5,-9
     9be:	0ff6f693          	zext.b	a3,a3
     9c2:	00978663          	beq	a5,s1,9ce <_vscanf_core.constprop.0+0x98>
     9c6:	00d67463          	bgeu	a2,a3,9ce <_vscanf_core.constprop.0+0x98>
    while (*p)
     9ca:	fbd9                	bnez	a5,960 <_vscanf_core.constprop.0+0x2a>
     9cc:	b7f9                	j	99a <_vscanf_core.constprop.0+0x64>
                p++;
     9ce:	0405                	addi	s0,s0,1
     9d0:	b7d5                	j	9b4 <_vscanf_core.constprop.0+0x7e>
        ctx->ungotten = -1;
     9d2:	57fd                	li	a5,-1
     9d4:	00fdac23          	sw	a5,24(s11)
            if (c != *p)
     9d8:	00044783          	lbu	a5,0(s0)
     9dc:	faa79ae3          	bne	a5,a0,990 <_vscanf_core.constprop.0+0x5a>
    while (*p)
     9e0:	00144783          	lbu	a5,1(s0)
            p++;
     9e4:	0405                	addi	s0,s0,1
    while (*p)
     9e6:	ffad                	bnez	a5,960 <_vscanf_core.constprop.0+0x2a>
     9e8:	bf4d                	j	99a <_vscanf_core.constprop.0+0x64>
     9ea:	f94a                	sd	s2,176(sp)
     9ec:	f54e                	sd	s3,168(sp)
     9ee:	e55e                	sd	s7,136(sp)
     9f0:	e162                	sd	s8,128(sp)
        if (*p == '*')
     9f2:	00144583          	lbu	a1,1(s0)
     9f6:	02a00793          	li	a5,42
     9fa:	22f58d63          	beq	a1,a5,c34 <_vscanf_core.constprop.0+0x2fe>
        p++;
     9fe:	0405                	addi	s0,s0,1
        int suppress = 0;
     a00:	4981                	li	s3,0
        while (*p >= '0' && *p <= '9')
     a02:	fd05861b          	addiw	a2,a1,-48
     a06:	0ff67693          	zext.b	a3,a2
     a0a:	47a5                	li	a5,9
     a0c:	36d7e763          	bltu	a5,a3,d7a <_vscanf_core.constprop.0+0x444>
     a10:	4781                	li	a5,0
     a12:	4825                	li	a6,9
     a14:	a019                	j	a1a <_vscanf_core.constprop.0+0xe4>
            width = width * 10 + (*p - '0');
     a16:	0016979b          	slliw	a5,a3,0x1
        while (*p >= '0' && *p <= '9')
     a1a:	00144583          	lbu	a1,1(s0)
            width = width * 10 + (*p - '0');
     a1e:	00f6093b          	addw	s2,a2,a5
     a22:	0029169b          	slliw	a3,s2,0x2
        while (*p >= '0' && *p <= '9')
     a26:	fd05861b          	addiw	a2,a1,-48
     a2a:	0ff67513          	zext.b	a0,a2
            width = width * 10 + (*p - '0');
     a2e:	012686bb          	addw	a3,a3,s2
            p++;
     a32:	0405                	addi	s0,s0,1
        while (*p >= '0' && *p <= '9')
     a34:	fea871e3          	bgeu	a6,a0,a16 <_vscanf_core.constprop.0+0xe0>
        if (*p == 'l')
     a38:	06c00693          	li	a3,108
            p++;
     a3c:	00140b93          	addi	s7,s0,1
        if (*p == 'l')
     a40:	1ed58f63          	beq	a1,a3,c3e <_vscanf_core.constprop.0+0x308>
        else if (*p == 'h')
     a44:	06800693          	li	a3,104
     a48:	2ad58863          	beq	a1,a3,cf8 <_vscanf_core.constprop.0+0x3c2>
        char spec = *p++;
     a4c:	00044c03          	lbu	s8,0(s0)
     a50:	8ba2                	mv	s7,s0
        int len_mod = 0;
     a52:	ec02                	sd	zero,24(sp)
        char spec = *p++;
     a54:	06300693          	li	a3,99
     a58:	001b8413          	addi	s0,s7,1
        if (!spec)
     a5c:	2adc0863          	beq	s8,a3,d0c <_vscanf_core.constprop.0+0x3d6>
     a60:	1f86fc63          	bgeu	a3,s8,c58 <_vscanf_core.constprop.0+0x322>
     a64:	f9cc069b          	addiw	a3,s8,-100
     a68:	0ff6f693          	zext.b	a3,a3
     a6c:	4651                	li	a2,20
     a6e:	0cd66e63          	bltu	a2,a3,b4a <_vscanf_core.constprop.0+0x214>
     a72:	00120637          	lui	a2,0x120
     a76:	4585                	li	a1,1
     a78:	00d595b3          	sll	a1,a1,a3
     a7c:	02160613          	addi	a2,a2,33 # 120021 <_ZSt4cerr+0x118869>
     a80:	8e6d                	and	a2,a2,a1
     a82:	ee69                	bnez	a2,b5c <_vscanf_core.constprop.0+0x226>
     a84:	89b9                	andi	a1,a1,14
     a86:	1e059263          	bnez	a1,c6a <_vscanf_core.constprop.0+0x334>
     a8a:	463d                	li	a2,15
     a8c:	0ac69f63          	bne	a3,a2,b4a <_vscanf_core.constprop.0+0x214>
            _skip_space(ctx);
     a90:	856e                	mv	a0,s11
     a92:	e31ff0ef          	jal	8c2 <_skip_space>
            char *buf = suppress ? NULL : va_arg(ap, char *);
     a96:	ec02                	sd	zero,24(sp)
     a98:	00099763          	bnez	s3,aa6 <_vscanf_core.constprop.0+0x170>
     a9c:	67a2                	ld	a5,8(sp)
     a9e:	6398                	ld	a4,0(a5)
     aa0:	07a1                	addi	a5,a5,8
     aa2:	e43e                	sd	a5,8(sp)
     aa4:	ec3a                	sd	a4,24(sp)
    if (ctx->ungotten >= 0)
     aa6:	018da503          	lw	a0,24(s11)
     aaa:	2e055b63          	bgez	a0,da0 <_vscanf_core.constprop.0+0x46a>
     aae:	856e                	mv	a0,s11
     ab0:	dcdff0ef          	jal	87c <_in_char.part.0>
            while (c != -1 && !isspace(c))
     ab4:	56fd                	li	a3,-1
     ab6:	6ad50363          	beq	a0,a3,115c <_vscanf_core.constprop.0+0x826>
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     aba:	02000693          	li	a3,32
     abe:	3ed50963          	beq	a0,a3,eb0 <_vscanf_core.constprop.0+0x57a>
     ac2:	46a5                	li	a3,9
     ac4:	3ed50663          	beq	a0,a3,eb0 <_vscanf_core.constprop.0+0x57a>
     ac8:	46a9                	li	a3,10
     aca:	3ed50363          	beq	a0,a3,eb0 <_vscanf_core.constprop.0+0x57a>
     ace:	46ad                	li	a3,11
     ad0:	3ed50063          	beq	a0,a3,eb0 <_vscanf_core.constprop.0+0x57a>
     ad4:	46b1                	li	a3,12
     ad6:	3cd50d63          	beq	a0,a3,eb0 <_vscanf_core.constprop.0+0x57a>
     ada:	46b5                	li	a3,13
     adc:	3cd50a63          	beq	a0,a3,eb0 <_vscanf_core.constprop.0+0x57a>
     ae0:	67e2                	ld	a5,24(sp)
     ae2:	fce6                	sd	s9,120(sp)
     ae4:	f8ea                	sd	s10,112(sp)
     ae6:	e83e                	sd	a5,16(sp)
     ae8:	4d01                	li	s10,0
            while (c != -1 && !isspace(c))
     aea:	5c7d                	li	s8,-1
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     aec:	02000c93          	li	s9,32
                if (width > 0 && i >= width)
     af0:	01205463          	blez	s2,af8 <_vscanf_core.constprop.0+0x1c2>
     af4:	052d5563          	bge	s10,s2,b3e <_vscanf_core.constprop.0+0x208>
                if (!suppress)
     af8:	00099563          	bnez	s3,b02 <_vscanf_core.constprop.0+0x1cc>
                    buf[i] = (char)c;
     afc:	67c2                	ld	a5,16(sp)
     afe:	00a78023          	sb	a0,0(a5)
    if (ctx->ungotten >= 0)
     b02:	018da503          	lw	a0,24(s11)
                i++;
     b06:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
     b08:	30055963          	bgez	a0,e1a <_vscanf_core.constprop.0+0x4e4>
     b0c:	856e                	mv	a0,s11
     b0e:	d6fff0ef          	jal	87c <_in_char.part.0>
            while (c != -1 && !isspace(c))
     b12:	27850663          	beq	a0,s8,d7e <_vscanf_core.constprop.0+0x448>
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     b16:	03950463          	beq	a0,s9,b3e <_vscanf_core.constprop.0+0x208>
     b1a:	47a5                	li	a5,9
     b1c:	02f50163          	beq	a0,a5,b3e <_vscanf_core.constprop.0+0x208>
     b20:	47a9                	li	a5,10
     b22:	00f50e63          	beq	a0,a5,b3e <_vscanf_core.constprop.0+0x208>
     b26:	47ad                	li	a5,11
     b28:	00f50b63          	beq	a0,a5,b3e <_vscanf_core.constprop.0+0x208>
     b2c:	47b1                	li	a5,12
     b2e:	00f50863          	beq	a0,a5,b3e <_vscanf_core.constprop.0+0x208>
     b32:	67c2                	ld	a5,16(sp)
     b34:	0785                	addi	a5,a5,1
     b36:	e83e                	sd	a5,16(sp)
     b38:	47b5                	li	a5,13
     b3a:	faf51be3          	bne	a0,a5,af0 <_vscanf_core.constprop.0+0x1ba>
            if (!suppress)
     b3e:	64098a63          	beqz	s3,1192 <_vscanf_core.constprop.0+0x85c>
     b42:	7ce6                	ld	s9,120(sp)
     b44:	7d46                	ld	s10,112(sp)
        ctx->ungotten = c;
     b46:	00adac23          	sw	a0,24(s11)
    while (*p)
     b4a:	001bc783          	lbu	a5,1(s7)
     b4e:	794a                	ld	s2,176(sp)
     b50:	79aa                	ld	s3,168(sp)
     b52:	6baa                	ld	s7,136(sp)
     b54:	6c0a                	ld	s8,128(sp)
     b56:	e00795e3          	bnez	a5,960 <_vscanf_core.constprop.0+0x2a>
     b5a:	b581                	j	99a <_vscanf_core.constprop.0+0x64>
            _skip_space(ctx);
     b5c:	856e                	mv	a0,s11
     b5e:	f8ea                	sd	s10,112(sp)
     b60:	d63ff0ef          	jal	8c2 <_skip_space>
    if (ctx->ungotten >= 0)
     b64:	018da503          	lw	a0,24(s11)
     b68:	24055063          	bgez	a0,da8 <_vscanf_core.constprop.0+0x472>
     b6c:	856e                	mv	a0,s11
     b6e:	d0fff0ef          	jal	87c <_in_char.part.0>
            if (c == '-' || c == '+')
     b72:	fd55069b          	addiw	a3,a0,-43
     b76:	9af5                	andi	a3,a3,-3
     b78:	2681                	sext.w	a3,a3
            int i = 0, c = _in_char(ctx);
     b7a:	4d01                	li	s10,0
            if (c == '-' || c == '+')
     b7c:	3e068863          	beqz	a3,f6c <_vscanf_core.constprop.0+0x636>
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
     b80:	07800693          	li	a3,120
     b84:	4641                	li	a2,16
     b86:	00dc0863          	beq	s8,a3,b96 <_vscanf_core.constprop.0+0x260>
     b8a:	06900693          	li	a3,105
     b8e:	4629                	li	a2,10
     b90:	00dc1363          	bne	s8,a3,b96 <_vscanf_core.constprop.0+0x260>
     b94:	4601                	li	a2,0
            while (c != -1 && i < 63)
     b96:	56fd                	li	a3,-1
     b98:	5cd50863          	beq	a0,a3,1168 <_vscanf_core.constprop.0+0x832>
     b9c:	fce6                	sd	s9,120(sp)
     b9e:	02010893          	addi	a7,sp,32
     ba2:	01a88c33          	add	s8,a7,s10
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     ba6:	4cc1                	li	s9,16
                int digit = (c >= '0' && c <= '9');
     ba8:	fd05069b          	addiw	a3,a0,-48
     bac:	0005031b          	sext.w	t1,a0
     bb0:	00a6b593          	sltiu	a1,a3,10
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     bb4:	27960a63          	beq	a2,s9,e28 <_vscanf_core.constprop.0+0x4f2>
     bb8:	2a060d63          	beqz	a2,e72 <_vscanf_core.constprop.0+0x53c>
                int x = (c == 'x' || c == 'X');
     bbc:	07800793          	li	a5,120
     bc0:	2ef50363          	beq	a0,a5,ea6 <_vscanf_core.constprop.0+0x570>
     bc4:	fa850693          	addi	a3,a0,-88
     bc8:	0016b693          	seqz	a3,a3
     bcc:	4301                	li	t1,0
                if (width > 0 && i >= width)
     bce:	01205463          	blez	s2,bd6 <_vscanf_core.constprop.0+0x2a0>
     bd2:	032d5a63          	bge	s10,s2,c06 <_vscanf_core.constprop.0+0x2d0>
                if (digit || hex || x)
     bd6:	0066e6b3          	or	a3,a3,t1
     bda:	8ecd                	or	a3,a3,a1
     bdc:	c68d                	beqz	a3,c06 <_vscanf_core.constprop.0+0x2d0>
                    num_buf[i++] = (char)c;
     bde:	00ac0023          	sb	a0,0(s8)
    if (ctx->ungotten >= 0)
     be2:	018da503          	lw	a0,24(s11)
                    num_buf[i++] = (char)c;
     be6:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
     be8:	22055c63          	bgez	a0,e20 <_vscanf_core.constprop.0+0x4ea>
     bec:	856e                	mv	a0,s11
     bee:	e832                	sd	a2,16(sp)
     bf0:	c8dff0ef          	jal	87c <_in_char.part.0>
            while (c != -1 && i < 63)
     bf4:	57fd                	li	a5,-1
     bf6:	6642                	ld	a2,16(sp)
     bf8:	3cf50263          	beq	a0,a5,fbc <_vscanf_core.constprop.0+0x686>
     bfc:	03f00693          	li	a3,63
     c00:	0c05                	addi	s8,s8,1
     c02:	fadd13e3          	bne	s10,a3,ba8 <_vscanf_core.constprop.0+0x272>
            num_buf[i] = '\0';
     c06:	040d0793          	addi	a5,s10,64
     c0a:	1018                	addi	a4,sp,32
     c0c:	97ba                	add	a5,a5,a4
     c0e:	fc078023          	sb	zero,-64(a5)
        ctx->ungotten = c;
     c12:	00adac23          	sw	a0,24(s11)
     c16:	7ce6                	ld	s9,120(sp)
            if (i == 0)
     c18:	1e0d0663          	beqz	s10,e04 <_vscanf_core.constprop.0+0x4ce>
            if (!suppress)
     c1c:	36098363          	beqz	s3,f82 <_vscanf_core.constprop.0+0x64c>
    while (*p)
     c20:	001bc783          	lbu	a5,1(s7)
        {
     c24:	794a                	ld	s2,176(sp)
     c26:	79aa                	ld	s3,168(sp)
     c28:	6baa                	ld	s7,136(sp)
     c2a:	6c0a                	ld	s8,128(sp)
     c2c:	7d46                	ld	s10,112(sp)
    while (*p)
     c2e:	d20799e3          	bnez	a5,960 <_vscanf_core.constprop.0+0x2a>
     c32:	b3a5                	j	99a <_vscanf_core.constprop.0+0x64>
        while (*p >= '0' && *p <= '9')
     c34:	00244583          	lbu	a1,2(s0)
            suppress = 1;
     c38:	4985                	li	s3,1
            p++;
     c3a:	0409                	addi	s0,s0,2
     c3c:	b3d9                	j	a02 <_vscanf_core.constprop.0+0xcc>
            if (*p == 'l')
     c3e:	00144c03          	lbu	s8,1(s0)
            len_mod = 1;
     c42:	4785                	li	a5,1
     c44:	ec3e                	sd	a5,24(sp)
            if (*p == 'l')
     c46:	e0bc17e3          	bne	s8,a1,a54 <_vscanf_core.constprop.0+0x11e>
                len_mod = 2;
     c4a:	4789                	li	a5,2
        char spec = *p++;
     c4c:	00244c03          	lbu	s8,2(s0)
                p++;
     c50:	00240b93          	addi	s7,s0,2
                len_mod = 2;
     c54:	ec3e                	sd	a5,24(sp)
     c56:	bbfd                	j	a54 <_vscanf_core.constprop.0+0x11e>
     c58:	100c0763          	beqz	s8,d66 <_vscanf_core.constprop.0+0x430>
     c5c:	fbbc079b          	addiw	a5,s8,-69
     c60:	0ff7f793          	zext.b	a5,a5
     c64:	4689                	li	a3,2
     c66:	eef6e2e3          	bltu	a3,a5,b4a <_vscanf_core.constprop.0+0x214>
            _skip_space(ctx);
     c6a:	856e                	mv	a0,s11
     c6c:	f8ea                	sd	s10,112(sp)
     c6e:	c55ff0ef          	jal	8c2 <_skip_space>
    if (ctx->ungotten >= 0)
     c72:	018da783          	lw	a5,24(s11)
     c76:	1207dd63          	bgez	a5,db0 <_vscanf_core.constprop.0+0x47a>
     c7a:	856e                	mv	a0,s11
     c7c:	c01ff0ef          	jal	87c <_in_char.part.0>
            if (c == '-' || c == '+')
     c80:	fd55069b          	addiw	a3,a0,-43
     c84:	ffd6f613          	andi	a2,a3,-3
     c88:	2601                	sext.w	a2,a2
     c8a:	87aa                	mv	a5,a0
     c8c:	12060c63          	beqz	a2,dc4 <_vscanf_core.constprop.0+0x48e>
            while (c != -1 && i < 63)
     c90:	567d                	li	a2,-1
     c92:	16c50963          	beq	a0,a2,e04 <_vscanf_core.constprop.0+0x4ce>
     c96:	fce6                	sd	s9,120(sp)
            int i = 0, c = _in_char(ctx);
     c98:	4d01                	li	s10,0
     c9a:	80000937          	lui	s2,0x80000
     c9e:	197d                	addi	s2,s2,-1 # ffffffff7fffffff <_ZSt4cerr+0xffffffff7fff8847>
     ca0:	0932                	slli	s2,s2,0xc
     ca2:	80194913          	xori	s2,s2,-2047
     ca6:	093e                	slli	s2,s2,0xf
     ca8:	02010813          	addi	a6,sp,32
     cac:	01a80cb3          	add	s9,a6,s10
     cb0:	03a00c13          	li	s8,58
     cb4:	1935                	addi	s2,s2,-19
     cb6:	a831                	j	cd2 <_vscanf_core.constprop.0+0x39c>
     cb8:	bc5ff0ef          	jal	87c <_in_char.part.0>
            while (c != -1 && i < 63)
     cbc:	577d                	li	a4,-1
     cbe:	87aa                	mv	a5,a0
     cc0:	2ee50563          	beq	a0,a4,faa <_vscanf_core.constprop.0+0x674>
     cc4:	03f00713          	li	a4,63
     cc8:	0c85                	addi	s9,s9,1
     cca:	1eed0e63          	beq	s10,a4,ec6 <_vscanf_core.constprop.0+0x590>
     cce:	fd57869b          	addiw	a3,a5,-43
        int c = ctx->ungotten;
     cd2:	00d95633          	srl	a2,s2,a3
     cd6:	856e                	mv	a0,s11
     cd8:	8a05                	andi	a2,a2,1
     cda:	1edc6663          	bltu	s8,a3,ec6 <_vscanf_core.constprop.0+0x590>
     cde:	1e060463          	beqz	a2,ec6 <_vscanf_core.constprop.0+0x590>
                    num_buf[i++] = (char)c;
     ce2:	00fc8023          	sb	a5,0(s9)
    if (ctx->ungotten >= 0)
     ce6:	018da783          	lw	a5,24(s11)
                    num_buf[i++] = (char)c;
     cea:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
     cec:	fc07c6e3          	bltz	a5,cb8 <_vscanf_core.constprop.0+0x382>
        ctx->ungotten = -1;
     cf0:	577d                	li	a4,-1
     cf2:	00edac23          	sw	a4,24(s11)
            while (c != -1 && i < 63)
     cf6:	b7f9                	j	cc4 <_vscanf_core.constprop.0+0x38e>
            if (*p == 'h')
     cf8:	00144c03          	lbu	s8,1(s0)
        int len_mod = 0;
     cfc:	ec02                	sd	zero,24(sp)
            if (*p == 'h')
     cfe:	d4bc1be3          	bne	s8,a1,a54 <_vscanf_core.constprop.0+0x11e>
        char spec = *p++;
     d02:	00244c03          	lbu	s8,2(s0)
                p++;
     d06:	00240b93          	addi	s7,s0,2
     d0a:	b3a9                	j	a54 <_vscanf_core.constprop.0+0x11e>
     d0c:	fce6                	sd	s9,120(sp)
     d0e:	f8ea                	sd	s10,112(sp)
            int count = (width > 0) ? width : 1;
     d10:	00090c1b          	sext.w	s8,s2
     d14:	0d205a63          	blez	s2,de8 <_vscanf_core.constprop.0+0x4b2>
            char *buf = suppress ? NULL : va_arg(ap, char *);
     d18:	4d01                	li	s10,0
     d1a:	06098d63          	beqz	s3,d94 <_vscanf_core.constprop.0+0x45e>
            for (int i = 0; i < count; i++)
     d1e:	9c6a                	add	s8,s8,s10
                if (c == -1)
     d20:	5cfd                	li	s9,-1
    if (ctx->ungotten >= 0)
     d22:	018da783          	lw	a5,24(s11)
        ctx->ungotten = -1;
     d26:	856e                	mv	a0,s11
    if (ctx->ungotten >= 0)
     d28:	0207dc63          	bgez	a5,d60 <_vscanf_core.constprop.0+0x42a>
     d2c:	b51ff0ef          	jal	87c <_in_char.part.0>
     d30:	87aa                	mv	a5,a0
                if (c == -1)
     d32:	0b950d63          	beq	a0,s9,dec <_vscanf_core.constprop.0+0x4b6>
                if (!suppress)
     d36:	00099463          	bnez	s3,d3e <_vscanf_core.constprop.0+0x408>
                    buf[i] = (char)c;
     d3a:	00fd0023          	sb	a5,0(s10)
            for (int i = 0; i < count; i++)
     d3e:	0d05                	addi	s10,s10,1
     d40:	ffac11e3          	bne	s8,s10,d22 <_vscanf_core.constprop.0+0x3ec>
    while (*p)
     d44:	001bc783          	lbu	a5,1(s7)
            if (!suppress)
     d48:	00099363          	bnez	s3,d4e <_vscanf_core.constprop.0+0x418>
                assigned++;
     d4c:	2b05                	addiw	s6,s6,1
     d4e:	794a                	ld	s2,176(sp)
     d50:	79aa                	ld	s3,168(sp)
     d52:	6baa                	ld	s7,136(sp)
     d54:	6c0a                	ld	s8,128(sp)
     d56:	7ce6                	ld	s9,120(sp)
     d58:	7d46                	ld	s10,112(sp)
    while (*p)
     d5a:	c00793e3          	bnez	a5,960 <_vscanf_core.constprop.0+0x2a>
     d5e:	b935                	j	99a <_vscanf_core.constprop.0+0x64>
        ctx->ungotten = -1;
     d60:	019dac23          	sw	s9,24(s11)
                if (c == -1)
     d64:	bfc9                	j	d36 <_vscanf_core.constprop.0+0x400>
     d66:	640e                	ld	s0,192(sp)
     d68:	74ea                	ld	s1,184(sp)
     d6a:	794a                	ld	s2,176(sp)
     d6c:	79aa                	ld	s3,168(sp)
     d6e:	7a0a                	ld	s4,160(sp)
     d70:	6aea                	ld	s5,152(sp)
     d72:	6baa                	ld	s7,136(sp)
     d74:	6c0a                	ld	s8,128(sp)
     d76:	7da6                	ld	s11,104(sp)
     d78:	b135                	j	9a4 <_vscanf_core.constprop.0+0x6e>
        int width = -1;
     d7a:	597d                	li	s2,-1
     d7c:	b975                	j	a38 <_vscanf_core.constprop.0+0x102>
            if (!suppress)
     d7e:	3c099c63          	bnez	s3,1156 <_vscanf_core.constprop.0+0x820>
                buf[i] = '\0';
     d82:	67e2                	ld	a5,24(sp)
     d84:	01a786b3          	add	a3,a5,s10
     d88:	00068023          	sb	zero,0(a3)
    while (*p)
     d8c:	001bc783          	lbu	a5,1(s7)
                assigned++;
     d90:	2b05                	addiw	s6,s6,1
     d92:	bf75                	j	d4e <_vscanf_core.constprop.0+0x418>
            char *buf = suppress ? NULL : va_arg(ap, char *);
     d94:	67a2                	ld	a5,8(sp)
     d96:	0007bd03          	ld	s10,0(a5)
     d9a:	07a1                	addi	a5,a5,8
     d9c:	e43e                	sd	a5,8(sp)
     d9e:	b741                	j	d1e <_vscanf_core.constprop.0+0x3e8>
        ctx->ungotten = -1;
     da0:	56fd                	li	a3,-1
     da2:	00ddac23          	sw	a3,24(s11)
            while (c != -1 && !isspace(c))
     da6:	bb11                	j	aba <_vscanf_core.constprop.0+0x184>
        ctx->ungotten = -1;
     da8:	56fd                	li	a3,-1
     daa:	00ddac23          	sw	a3,24(s11)
        return c;
     dae:	b3d1                	j	b72 <_vscanf_core.constprop.0+0x23c>
            if (c == '-' || c == '+')
     db0:	fd57869b          	addiw	a3,a5,-43
     db4:	ffd6f613          	andi	a2,a3,-3
        ctx->ungotten = -1;
     db8:	55fd                	li	a1,-1
     dba:	00bdac23          	sw	a1,24(s11)
            if (c == '-' || c == '+')
     dbe:	2601                	sext.w	a2,a2
     dc0:	ec061be3          	bnez	a2,c96 <_vscanf_core.constprop.0+0x360>
                num_buf[i++] = (char)c;
     dc4:	02f10023          	sb	a5,32(sp)
    if (ctx->ungotten >= 0)
     dc8:	018da783          	lw	a5,24(s11)
     dcc:	2207da63          	bgez	a5,1000 <_vscanf_core.constprop.0+0x6ca>
     dd0:	856e                	mv	a0,s11
     dd2:	aabff0ef          	jal	87c <_in_char.part.0>
            while (c != -1 && i < 63)
     dd6:	567d                	li	a2,-1
     dd8:	87aa                	mv	a5,a0
                num_buf[i++] = (char)c;
     dda:	4d05                	li	s10,1
     ddc:	fd55069b          	addiw	a3,a0,-43
            while (c != -1 && i < 63)
     de0:	3ac50163          	beq	a0,a2,1182 <_vscanf_core.constprop.0+0x84c>
     de4:	fce6                	sd	s9,120(sp)
     de6:	bd55                	j	c9a <_vscanf_core.constprop.0+0x364>
            int count = (width > 0) ? width : 1;
     de8:	4c05                	li	s8,1
     dea:	b73d                	j	d18 <_vscanf_core.constprop.0+0x3e2>
     dec:	640e                	ld	s0,192(sp)
     dee:	74ea                	ld	s1,184(sp)
     df0:	794a                	ld	s2,176(sp)
     df2:	79aa                	ld	s3,168(sp)
     df4:	7a0a                	ld	s4,160(sp)
     df6:	6aea                	ld	s5,152(sp)
     df8:	6baa                	ld	s7,136(sp)
     dfa:	6c0a                	ld	s8,128(sp)
     dfc:	7ce6                	ld	s9,120(sp)
     dfe:	7d46                	ld	s10,112(sp)
     e00:	7da6                	ld	s11,104(sp)
     e02:	b64d                	j	9a4 <_vscanf_core.constprop.0+0x6e>
     e04:	640e                	ld	s0,192(sp)
     e06:	74ea                	ld	s1,184(sp)
     e08:	794a                	ld	s2,176(sp)
     e0a:	79aa                	ld	s3,168(sp)
     e0c:	7a0a                	ld	s4,160(sp)
     e0e:	6aea                	ld	s5,152(sp)
     e10:	6baa                	ld	s7,136(sp)
     e12:	6c0a                	ld	s8,128(sp)
     e14:	7d46                	ld	s10,112(sp)
     e16:	7da6                	ld	s11,104(sp)
     e18:	b671                	j	9a4 <_vscanf_core.constprop.0+0x6e>
        ctx->ungotten = -1;
     e1a:	018dac23          	sw	s8,24(s11)
            while (c != -1 && !isspace(c))
     e1e:	b9e5                	j	b16 <_vscanf_core.constprop.0+0x1e0>
        ctx->ungotten = -1;
     e20:	57fd                	li	a5,-1
     e22:	00fdac23          	sw	a5,24(s11)
            while (c != -1 && i < 63)
     e26:	bbd9                	j	bfc <_vscanf_core.constprop.0+0x2c6>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     e28:	f9f3069b          	addiw	a3,t1,-97
     e2c:	4795                	li	a5,5
     e2e:	06d7f263          	bgeu	a5,a3,e92 <_vscanf_core.constprop.0+0x55c>
     e32:	fbf3031b          	addiw	t1,t1,-65
     e36:	4795                	li	a5,5
     e38:	0467fd63          	bgeu	a5,t1,e92 <_vscanf_core.constprop.0+0x55c>
                int x = (c == 'x' || c == 'X');
     e3c:	07800693          	li	a3,120
     e40:	18d50763          	beq	a0,a3,fce <_vscanf_core.constprop.0+0x698>
     e44:	fa850693          	addi	a3,a0,-88
     e48:	0016b693          	seqz	a3,a3
                if (base == 0 && i == 1 && num_buf[0] == '0' && x)
     e4c:	4301                	li	t1,0
     e4e:	32061663          	bnez	a2,117a <_vscanf_core.constprop.0+0x844>
     e52:	4785                	li	a5,1
     e54:	4601                	li	a2,0
     e56:	d6fd1ce3          	bne	s10,a5,bce <_vscanf_core.constprop.0+0x298>
     e5a:	02014e03          	lbu	t3,32(sp)
     e5e:	03000793          	li	a5,48
     e62:	d6fe16e3          	bne	t3,a5,bce <_vscanf_core.constprop.0+0x298>
     e66:	d60684e3          	beqz	a3,bce <_vscanf_core.constprop.0+0x298>
                    base = 16;
     e6a:	4641                	li	a2,16
                if (width > 0 && i >= width)
     e6c:	d7a919e3          	bne	s2,s10,bde <_vscanf_core.constprop.0+0x2a8>
     e70:	bb59                	j	c06 <_vscanf_core.constprop.0+0x2d0>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     e72:	f9f3069b          	addiw	a3,t1,-97
     e76:	4795                	li	a5,5
     e78:	02d7f263          	bgeu	a5,a3,e9c <_vscanf_core.constprop.0+0x566>
     e7c:	fbf3031b          	addiw	t1,t1,-65
     e80:	0467f063          	bgeu	a5,t1,ec0 <_vscanf_core.constprop.0+0x58a>
                int x = (c == 'x' || c == 'X');
     e84:	07800693          	li	a3,120
     e88:	fad51ee3          	bne	a0,a3,e44 <_vscanf_core.constprop.0+0x50e>
     e8c:	4301                	li	t1,0
     e8e:	4685                	li	a3,1
     e90:	b7c9                	j	e52 <_vscanf_core.constprop.0+0x51c>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     e92:	4305                	li	t1,1
                int x = (c == 'x' || c == 'X');
     e94:	4681                	li	a3,0
                if (width > 0 && i >= width)
     e96:	d3204ee3          	bgtz	s2,bd2 <_vscanf_core.constprop.0+0x29c>
     e9a:	bb35                	j	bd6 <_vscanf_core.constprop.0+0x2a0>
                int x = (c == 'x' || c == 'X');
     e9c:	4681                	li	a3,0
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     e9e:	4305                	li	t1,1
                if (width > 0 && i >= width)
     ea0:	d32049e3          	bgtz	s2,bd2 <_vscanf_core.constprop.0+0x29c>
     ea4:	bb0d                	j	bd6 <_vscanf_core.constprop.0+0x2a0>
     ea6:	4301                	li	t1,0
                int x = (c == 'x' || c == 'X');
     ea8:	4685                	li	a3,1
                if (width > 0 && i >= width)
     eaa:	d32044e3          	bgtz	s2,bd2 <_vscanf_core.constprop.0+0x29c>
     eae:	bb05                	j	bde <_vscanf_core.constprop.0+0x2a8>
            if (!suppress)
     eb0:	c8099be3          	bnez	s3,b46 <_vscanf_core.constprop.0+0x210>
                buf[i] = '\0';
     eb4:	67e2                	ld	a5,24(sp)
     eb6:	00078023          	sb	zero,0(a5)
        ctx->ungotten = c;
     eba:	00adac23          	sw	a0,24(s11)
            if (i > 0 && !suppress)
     ebe:	b171                	j	b4a <_vscanf_core.constprop.0+0x214>
                int x = (c == 'x' || c == 'X');
     ec0:	4681                	li	a3,0
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     ec2:	4305                	li	t1,1
     ec4:	b779                	j	e52 <_vscanf_core.constprop.0+0x51c>
            num_buf[i] = '\0';
     ec6:	040d0713          	addi	a4,s10,64
     eca:	1014                	addi	a3,sp,32
     ecc:	96ba                	add	a3,a3,a4
     ece:	fc068023          	sb	zero,-64(a3)
        ctx->ungotten = c;
     ed2:	00fdac23          	sw	a5,24(s11)
            if (i == 0)
     ed6:	f00d0be3          	beqz	s10,dec <_vscanf_core.constprop.0+0x4b6>
     eda:	7ce6                	ld	s9,120(sp)
            if (!suppress)
     edc:	d40992e3          	bnez	s3,c20 <_vscanf_core.constprop.0+0x2ea>
    if (*str == '-')
     ee0:	02014603          	lbu	a2,32(sp)
     ee4:	02d00793          	li	a5,45
     ee8:	1af60963          	beq	a2,a5,109a <_vscanf_core.constprop.0+0x764>
    else if (*str == '+')
     eec:	02b00793          	li	a5,43
     ef0:	20f60a63          	beq	a2,a5,1104 <_vscanf_core.constprop.0+0x7ce>
     ef4:	00005797          	auipc	a5,0x5
     ef8:	8a47b587          	fld	fa1,-1884(a5) # 5798 <STDIN_FD+0x10>
     efc:	101c                	addi	a5,sp,32
    while (*str >= '0' && *str <= '9')
     efe:	fd06069b          	addiw	a3,a2,-48
     f02:	0ff6f513          	zext.b	a0,a3
     f06:	45a5                	li	a1,9
     f08:	f20007d3          	fmv.d.x	fa5,zero
     f0c:	02a5e463          	bltu	a1,a0,f34 <_vscanf_core.constprop.0+0x5fe>
     f10:	00005717          	auipc	a4,0x5
     f14:	89073707          	fld	fa4,-1904(a4) # 57a0 <STDIN_FD+0x18>
     f18:	4525                	li	a0,9
     f1a:	0017c603          	lbu	a2,1(a5)
        val = val * 10.0 + (*str - '0');
     f1e:	d20686d3          	fcvt.d.w	fa3,a3
        str++;
     f22:	0785                	addi	a5,a5,1
    while (*str >= '0' && *str <= '9')
     f24:	fd06069b          	addiw	a3,a2,-48
     f28:	0ff6f593          	zext.b	a1,a3
        val = val * 10.0 + (*str - '0');
     f2c:	6ae7f7c3          	fmadd.d	fa5,fa5,fa4,fa3
    while (*str >= '0' && *str <= '9')
     f30:	feb575e3          	bgeu	a0,a1,f1a <_vscanf_core.constprop.0+0x5e4>
    if (*str == '.')
     f34:	02e00693          	li	a3,46
     f38:	16d60a63          	beq	a2,a3,10ac <_vscanf_core.constprop.0+0x776>
    if (*str == 'e' || *str == 'E')
     f3c:	0007c683          	lbu	a3,0(a5)
     f40:	0df6f693          	andi	a3,a3,223
     f44:	04500613          	li	a2,69
     f48:	0cc68463          	beq	a3,a2,1010 <_vscanf_core.constprop.0+0x6da>
                    *va_arg(ap, double *) = val;
     f4c:	6722                	ld	a4,8(sp)
                if (len_mod == 1)
     f4e:	4685                	li	a3,1
    return sign * val;
     f50:	12b7f7d3          	fmul.d	fa5,fa5,fa1
                    *va_arg(ap, double *) = val;
     f54:	631c                	ld	a5,0(a4)
                    *va_arg(ap, int64 *) = val;
     f56:	0721                	addi	a4,a4,8
     f58:	e43a                	sd	a4,8(sp)
                if (len_mod == 1)
     f5a:	6762                	ld	a4,24(sp)
     f5c:	18d70b63          	beq	a4,a3,10f2 <_vscanf_core.constprop.0+0x7bc>
                    *va_arg(ap, float *) = (float)val;
     f60:	4017f7d3          	fcvt.s.d	fa5,fa5
                assigned++;
     f64:	2b05                	addiw	s6,s6,1
                    *va_arg(ap, float *) = (float)val;
     f66:	00f7a027          	fsw	fa5,0(a5)
     f6a:	b95d                	j	c20 <_vscanf_core.constprop.0+0x2ea>
                num_buf[i++] = (char)c;
     f6c:	02a10023          	sb	a0,32(sp)
    if (ctx->ungotten >= 0)
     f70:	018da503          	lw	a0,24(s11)
     f74:	06055463          	bgez	a0,fdc <_vscanf_core.constprop.0+0x6a6>
     f78:	856e                	mv	a0,s11
     f7a:	903ff0ef          	jal	87c <_in_char.part.0>
                num_buf[i++] = (char)c;
     f7e:	4d05                	li	s10,1
     f80:	b101                	j	b80 <_vscanf_core.constprop.0+0x24a>
                int64 val = strtoll(num_buf, NULL, base);
     f82:	4581                	li	a1,0
     f84:	1008                	addi	a0,sp,32
     f86:	696030ef          	jal	461c <strtoll>
                    *va_arg(ap, int64 *) = val;
     f8a:	67a2                	ld	a5,8(sp)
                if (len_mod == 2)
     f8c:	6762                	ld	a4,24(sp)
     f8e:	4689                	li	a3,2
                    *va_arg(ap, int64 *) = val;
     f90:	07a1                	addi	a5,a5,8
                if (len_mod == 2)
     f92:	16d70363          	beq	a4,a3,10f8 <_vscanf_core.constprop.0+0x7c2>
                    *va_arg(ap, int64 *) = val;
     f96:	6722                	ld	a4,8(sp)
                else if (len_mod == 1)
     f98:	4605                	li	a2,1
                    *va_arg(ap, int64 *) = val;
     f9a:	6314                	ld	a3,0(a4)
                else if (len_mod == 1)
     f9c:	6762                	ld	a4,24(sp)
     f9e:	16c70163          	beq	a4,a2,1100 <_vscanf_core.constprop.0+0x7ca>
                    *va_arg(ap, int *) = (int)val;
     fa2:	c288                	sw	a0,0(a3)
                assigned++;
     fa4:	2b05                	addiw	s6,s6,1
     fa6:	e43e                	sd	a5,8(sp)
     fa8:	b9a5                	j	c20 <_vscanf_core.constprop.0+0x2ea>
            num_buf[i] = '\0';
     faa:	040d0793          	addi	a5,s10,64
     fae:	1018                	addi	a4,sp,32
     fb0:	00e785b3          	add	a1,a5,a4
     fb4:	fc058023          	sb	zero,-64(a1)
            if (i == 0)
     fb8:	7ce6                	ld	s9,120(sp)
     fba:	b70d                	j	edc <_vscanf_core.constprop.0+0x5a6>
            num_buf[i] = '\0';
     fbc:	040d0793          	addi	a5,s10,64
     fc0:	1018                	addi	a4,sp,32
     fc2:	00e78833          	add	a6,a5,a4
     fc6:	fc080023          	sb	zero,-64(a6)
            if (i == 0)
     fca:	7ce6                	ld	s9,120(sp)
     fcc:	b981                	j	c1c <_vscanf_core.constprop.0+0x2e6>
                int x = (c == 'x' || c == 'X');
     fce:	4301                	li	t1,0
     fd0:	4685                	li	a3,1
                if (width > 0 && i >= width)
     fd2:	c12040e3          	bgtz	s2,bd2 <_vscanf_core.constprop.0+0x29c>
     fd6:	b101                	j	bd6 <_vscanf_core.constprop.0+0x2a0>
    int assigned = 0;
     fd8:	4b01                	li	s6,0
     fda:	b2e9                	j	9a4 <_vscanf_core.constprop.0+0x6e>
        ctx->ungotten = -1;
     fdc:	56fd                	li	a3,-1
     fde:	fce6                	sd	s9,120(sp)
     fe0:	00ddac23          	sw	a3,24(s11)
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
     fe4:	07800693          	li	a3,120
     fe8:	4641                	li	a2,16
                num_buf[i++] = (char)c;
     fea:	4d05                	li	s10,1
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
     fec:	badc09e3          	beq	s8,a3,b9e <_vscanf_core.constprop.0+0x268>
     ff0:	06900693          	li	a3,105
     ff4:	4629                	li	a2,10
                num_buf[i++] = (char)c;
     ff6:	4d05                	li	s10,1
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
     ff8:	badc13e3          	bne	s8,a3,b9e <_vscanf_core.constprop.0+0x268>
     ffc:	4601                	li	a2,0
     ffe:	b645                	j	b9e <_vscanf_core.constprop.0+0x268>
        ctx->ungotten = -1;
    1000:	56fd                	li	a3,-1
    1002:	fce6                	sd	s9,120(sp)
    1004:	00ddac23          	sw	a3,24(s11)
                num_buf[i++] = (char)c;
    1008:	4d05                	li	s10,1
    100a:	fd57869b          	addiw	a3,a5,-43
    100e:	b171                	j	c9a <_vscanf_core.constprop.0+0x364>
        if (*str == '-')
    1010:	0017c583          	lbu	a1,1(a5)
    1014:	02d00693          	li	a3,45
    1018:	0ed58f63          	beq	a1,a3,1116 <_vscanf_core.constprop.0+0x7e0>
        else if (*str == '+')
    101c:	02b00693          	li	a3,43
    1020:	10d58e63          	beq	a1,a3,113c <_vscanf_core.constprop.0+0x806>
        while (*str >= '0' && *str <= '9')
    1024:	fd05861b          	addiw	a2,a1,-48
    1028:	0ff67513          	zext.b	a0,a2
    102c:	45a5                	li	a1,9
        str++;
    102e:	00178693          	addi	a3,a5,1
        int esign = 1;
    1032:	4805                	li	a6,1
        while (*str >= '0' && *str <= '9')
    1034:	04a5ec63          	bltu	a1,a0,108c <_vscanf_core.constprop.0+0x756>
    1038:	4525                	li	a0,9
    103a:	0016c583          	lbu	a1,1(a3)
            eval = eval * 10 + (*str - '0');
    103e:	0029979b          	slliw	a5,s3,0x2
    1042:	013787bb          	addw	a5,a5,s3
    1046:	0017979b          	slliw	a5,a5,0x1
    104a:	00f609bb          	addw	s3,a2,a5
        while (*str >= '0' && *str <= '9')
    104e:	fd05861b          	addiw	a2,a1,-48
    1052:	0ff67593          	zext.b	a1,a2
            str++;
    1056:	0685                	addi	a3,a3,1
        while (*str >= '0' && *str <= '9')
    1058:	feb571e3          	bgeu	a0,a1,103a <_vscanf_core.constprop.0+0x704>
        while (eval--)
    105c:	fff9879b          	addiw	a5,s3,-1
    1060:	12098463          	beqz	s3,1188 <_vscanf_core.constprop.0+0x852>
        double p = 1.0;
    1064:	00004717          	auipc	a4,0x4
    1068:	73473687          	fld	fa3,1844(a4) # 5798 <STDIN_FD+0x10>
    106c:	00004717          	auipc	a4,0x4
    1070:	73473707          	fld	fa4,1844(a4) # 57a0 <STDIN_FD+0x18>
        while (eval--)
    1074:	56fd                	li	a3,-1
    1076:	37fd                	addiw	a5,a5,-1
            p *= 10.0;
    1078:	12e6f6d3          	fmul.d	fa3,fa3,fa4
        while (eval--)
    107c:	fed79de3          	bne	a5,a3,1076 <_vscanf_core.constprop.0+0x740>
        if (esign == 1)
    1080:	4785                	li	a5,1
    1082:	00f80963          	beq	a6,a5,1094 <_vscanf_core.constprop.0+0x75e>
            val /= p;
    1086:	1ad7f7d3          	fdiv.d	fa5,fa5,fa3
    108a:	b5c9                	j	f4c <_vscanf_core.constprop.0+0x616>
        double p = 1.0;
    108c:	00004797          	auipc	a5,0x4
    1090:	70c7b687          	fld	fa3,1804(a5) # 5798 <STDIN_FD+0x10>
            val *= p;
    1094:	12d7f7d3          	fmul.d	fa5,fa5,fa3
    1098:	bd55                	j	f4c <_vscanf_core.constprop.0+0x616>
    while (*str >= '0' && *str <= '9')
    109a:	00004797          	auipc	a5,0x4
    109e:	6f67b587          	fld	fa1,1782(a5) # 5790 <STDIN_FD+0x8>
    10a2:	02114603          	lbu	a2,33(sp)
        str++;
    10a6:	02110793          	addi	a5,sp,33
    10aa:	bd91                	j	efe <_vscanf_core.constprop.0+0x5c8>
        while (*str >= '0' && *str <= '9')
    10ac:	0017c683          	lbu	a3,1(a5)
    10b0:	45a5                	li	a1,9
        str++;
    10b2:	0785                	addi	a5,a5,1
        while (*str >= '0' && *str <= '9')
    10b4:	fd06861b          	addiw	a2,a3,-48
    10b8:	0ff67513          	zext.b	a0,a2
    10bc:	e8a5e2e3          	bltu	a1,a0,f40 <_vscanf_core.constprop.0+0x60a>
        double div = 10.0;
    10c0:	00004717          	auipc	a4,0x4
    10c4:	6e073707          	fld	fa4,1760(a4) # 57a0 <STDIN_FD+0x18>
    10c8:	22e70653          	fmv.d	fa2,fa4
        while (*str >= '0' && *str <= '9')
    10cc:	4525                	li	a0,9
            val += (*str - '0') / div;
    10ce:	d20606d3          	fcvt.d.w	fa3,a2
        while (*str >= '0' && *str <= '9')
    10d2:	0017c683          	lbu	a3,1(a5)
            str++;
    10d6:	0785                	addi	a5,a5,1
            val += (*str - '0') / div;
    10d8:	1ac6f6d3          	fdiv.d	fa3,fa3,fa2
        while (*str >= '0' && *str <= '9')
    10dc:	fd06861b          	addiw	a2,a3,-48
    10e0:	0ff67593          	zext.b	a1,a2
            div *= 10.0;
    10e4:	12e67653          	fmul.d	fa2,fa2,fa4
            val += (*str - '0') / div;
    10e8:	02d7f7d3          	fadd.d	fa5,fa5,fa3
        while (*str >= '0' && *str <= '9')
    10ec:	feb571e3          	bgeu	a0,a1,10ce <_vscanf_core.constprop.0+0x798>
    10f0:	bd81                	j	f40 <_vscanf_core.constprop.0+0x60a>
                    *va_arg(ap, double *) = val;
    10f2:	a39c                	fsd	fa5,0(a5)
                assigned++;
    10f4:	2b05                	addiw	s6,s6,1
    10f6:	b62d                	j	c20 <_vscanf_core.constprop.0+0x2ea>
                    *va_arg(ap, int64 *) = val;
    10f8:	6722                	ld	a4,8(sp)
    10fa:	6314                	ld	a3,0(a4)
    10fc:	e288                	sd	a0,0(a3)
    10fe:	b55d                	j	fa4 <_vscanf_core.constprop.0+0x66e>
                    *va_arg(ap, long *) = (long)val;
    1100:	e288                	sd	a0,0(a3)
    1102:	b54d                	j	fa4 <_vscanf_core.constprop.0+0x66e>
    while (*str >= '0' && *str <= '9')
    1104:	00004797          	auipc	a5,0x4
    1108:	6947b587          	fld	fa1,1684(a5) # 5798 <STDIN_FD+0x10>
    110c:	02114603          	lbu	a2,33(sp)
        str++;
    1110:	02110793          	addi	a5,sp,33
    1114:	b3ed                	j	efe <_vscanf_core.constprop.0+0x5c8>
        while (*str >= '0' && *str <= '9')
    1116:	0027c583          	lbu	a1,2(a5)
            str++;
    111a:	00278693          	addi	a3,a5,2
        while (*str >= '0' && *str <= '9')
    111e:	4525                	li	a0,9
    1120:	fd05861b          	addiw	a2,a1,-48
    1124:	0ff67793          	zext.b	a5,a2
            esign = -1;
    1128:	587d                	li	a6,-1
        while (*str >= '0' && *str <= '9')
    112a:	f0f577e3          	bgeu	a0,a5,1038 <_vscanf_core.constprop.0+0x702>
        double p = 1.0;
    112e:	00004797          	auipc	a5,0x4
    1132:	66a7b687          	fld	fa3,1642(a5) # 5798 <STDIN_FD+0x10>
            val /= p;
    1136:	1ad7f7d3          	fdiv.d	fa5,fa5,fa3
    113a:	bd09                	j	f4c <_vscanf_core.constprop.0+0x616>
        while (*str >= '0' && *str <= '9')
    113c:	0027c583          	lbu	a1,2(a5)
            str++;
    1140:	00278693          	addi	a3,a5,2
        while (*str >= '0' && *str <= '9')
    1144:	4525                	li	a0,9
    1146:	fd05861b          	addiw	a2,a1,-48
    114a:	0ff67793          	zext.b	a5,a2
    114e:	f2f56fe3          	bltu	a0,a5,108c <_vscanf_core.constprop.0+0x756>
        int esign = 1;
    1152:	4805                	li	a6,1
    1154:	b5d5                	j	1038 <_vscanf_core.constprop.0+0x702>
    while (*p)
    1156:	001bc783          	lbu	a5,1(s7)
    115a:	bed5                	j	d4e <_vscanf_core.constprop.0+0x418>
            if (!suppress)
    115c:	9e0997e3          	bnez	s3,b4a <_vscanf_core.constprop.0+0x214>
                buf[i] = '\0';
    1160:	67e2                	ld	a5,24(sp)
    1162:	00078023          	sb	zero,0(a5)
    1166:	b2d5                	j	b4a <_vscanf_core.constprop.0+0x214>
            num_buf[i] = '\0';
    1168:	040d0793          	addi	a5,s10,64
    116c:	1018                	addi	a4,sp,32
    116e:	97ba                	add	a5,a5,a4
    1170:	fc078023          	sb	zero,-64(a5)
            if (i == 0)
    1174:	aa0d14e3          	bnez	s10,c1c <_vscanf_core.constprop.0+0x2e6>
    1178:	b171                	j	e04 <_vscanf_core.constprop.0+0x4ce>
    117a:	4641                	li	a2,16
                if (width > 0 && i >= width)
    117c:	a5204be3          	bgtz	s2,bd2 <_vscanf_core.constprop.0+0x29c>
    1180:	bc99                	j	bd6 <_vscanf_core.constprop.0+0x2a0>
            num_buf[i] = '\0';
    1182:	020100a3          	sb	zero,33(sp)
            if (i == 0)
    1186:	bb99                	j	edc <_vscanf_core.constprop.0+0x5a6>
        double p = 1.0;
    1188:	00004797          	auipc	a5,0x4
    118c:	6107b687          	fld	fa3,1552(a5) # 5798 <STDIN_FD+0x10>
    1190:	bdc5                	j	1080 <_vscanf_core.constprop.0+0x74a>
                buf[i] = '\0';
    1192:	67e2                	ld	a5,24(sp)
    1194:	01a786b3          	add	a3,a5,s10
    1198:	00068023          	sb	zero,0(a3)
        ctx->ungotten = c;
    119c:	00adac23          	sw	a0,24(s11)
    while (*p)
    11a0:	001bc783          	lbu	a5,1(s7)
    11a4:	b6f5                	j	d90 <_vscanf_core.constprop.0+0x45a>

00000000000011a6 <_out_char>:
{
    11a6:	7179                	addi	sp,sp,-48
    11a8:	ec26                	sd	s1,24(sp)
    if (ctx->stream)
    11aa:	6d04                	ld	s1,24(a0)
{
    11ac:	f022                	sd	s0,32(sp)
    11ae:	f406                	sd	ra,40(sp)
    11b0:	842a                	mv	s0,a0
    11b2:	872e                	mv	a4,a1
    if (ctx->stream)
    11b4:	c0a1                	beqz	s1,11f4 <_out_char+0x4e>
    11b6:	e84a                	sd	s2,16(sp)
    if (stream->buf_mode == 2)
    11b8:	41c4a903          	lw	s2,1052(s1)
    11bc:	4789                	li	a5,2
    11be:	04f90d63          	beq	s2,a5,1218 <_out_char+0x72>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    11c2:	4104a783          	lw	a5,1040(s1)
    if (stream->buf_write_pos >= BUFSIZ)
    11c6:	3ff00693          	li	a3,1023
    stream->buffer[stream->buf_write_pos++] = (char)c;
    11ca:	0017861b          	addiw	a2,a5,1
    11ce:	40c4a823          	sw	a2,1040(s1)
    11d2:	97a6                	add	a5,a5,s1
    11d4:	00b78823          	sb	a1,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    11d8:	08c6c063          	blt	a3,a2,1258 <_out_char+0xb2>
    else if (stream->buf_mode == 1 && c == '\n')
    11dc:	4785                	li	a5,1
    11de:	04f90a63          	beq	s2,a5,1232 <_out_char+0x8c>
        ctx->written++;
    11e2:	681c                	ld	a5,16(s0)
    11e4:	6942                	ld	s2,16(sp)
}
    11e6:	70a2                	ld	ra,40(sp)
        ctx->written++;
    11e8:	0785                	addi	a5,a5,1
    11ea:	e81c                	sd	a5,16(s0)
}
    11ec:	7402                	ld	s0,32(sp)
    11ee:	64e2                	ld	s1,24(sp)
    11f0:	6145                	addi	sp,sp,48
    11f2:	8082                	ret
        if (ctx->limit > 0 && ctx->written < ctx->limit - 1)
    11f4:	6514                	ld	a3,8(a0)
    11f6:	691c                	ld	a5,16(a0)
    11f8:	ca89                	beqz	a3,120a <_out_char+0x64>
    11fa:	16fd                	addi	a3,a3,-1
    11fc:	00d7f763          	bgeu	a5,a3,120a <_out_char+0x64>
            ctx->buf[ctx->written] = c;
    1200:	6114                	ld	a3,0(a0)
    1202:	97b6                	add	a5,a5,a3
    1204:	00b78023          	sb	a1,0(a5)
        ctx->written++;
    1208:	691c                	ld	a5,16(a0)
    120a:	0785                	addi	a5,a5,1
}
    120c:	70a2                	ld	ra,40(sp)
        ctx->written++;
    120e:	e81c                	sd	a5,16(s0)
}
    1210:	7402                	ld	s0,32(sp)
    1212:	64e2                	ld	s1,24(sp)
    1214:	6145                	addi	sp,sp,48
    1216:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    1218:	4088                	lw	a0,0(s1)
    121a:	4605                	li	a2,1
    121c:	00f10593          	addi	a1,sp,15
        char ch = (char)c;
    1220:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    1224:	e8bfe0ef          	jal	ae <write>
    1228:	4785                	li	a5,1
    122a:	faf50ce3          	beq	a0,a5,11e2 <_out_char+0x3c>
            stream->error = 1;
    122e:	c49c                	sw	a5,8(s1)
            return EOF;
    1230:	bf4d                	j	11e2 <_out_char+0x3c>
    else if (stream->buf_mode == 1 && c == '\n')
    1232:	47a9                	li	a5,10
    1234:	faf597e3          	bne	a1,a5,11e2 <_out_char+0x3c>
    if (stream->buf_write_pos > 0)
    1238:	fac055e3          	blez	a2,11e2 <_out_char+0x3c>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    123c:	4088                	lw	a0,0(s1)
    123e:	01048593          	addi	a1,s1,16
    1242:	e6dfe0ef          	jal	ae <write>
        if (ret < stream->buf_write_pos)
    1246:	4104a783          	lw	a5,1040(s1)
    124a:	02f55063          	bge	a0,a5,126a <_out_char+0xc4>
            stream->error = 1;
    124e:	0124a423          	sw	s2,8(s1)
            stream->buf_write_pos = 0;
    1252:	4004a823          	sw	zero,1040(s1)
            return EOF;
    1256:	b771                	j	11e2 <_out_char+0x3c>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    1258:	4088                	lw	a0,0(s1)
    125a:	01048593          	addi	a1,s1,16
    125e:	e51fe0ef          	jal	ae <write>
        if (ret < stream->buf_write_pos)
    1262:	4104a783          	lw	a5,1040(s1)
    1266:	00f54563          	blt	a0,a5,1270 <_out_char+0xca>
        stream->buf_write_pos = 0;
    126a:	4004a823          	sw	zero,1040(s1)
    126e:	bf95                	j	11e2 <_out_char+0x3c>
            stream->error = 1;
    1270:	4785                	li	a5,1
    1272:	c49c                	sw	a5,8(s1)
            stream->buf_write_pos = 0;
    1274:	4004a823          	sw	zero,1040(s1)
            return EOF;
    1278:	b7ad                	j	11e2 <_out_char+0x3c>

000000000000127a <stbsp_set_separators>:
   "75767778798081828384858687888990919293949596979899"
};

STBSP__PUBLICDEF void STB_SPRINTF_DECORATE(set_separators)(char pcomma, char pperiod)
{
   stbsp__period = pperiod;
    127a:	00005797          	auipc	a5,0x5
    127e:	64678793          	addi	a5,a5,1606 # 68c0 <stbsp__digitpair>
    1282:	0cb78623          	sb	a1,204(a5)
   stbsp__comma = pcomma;
    1286:	0ca786a3          	sb	a0,205(a5)
}
    128a:	8082                	ret

000000000000128c <stbsp_vsprintfcb>:

   return (stbsp__uint32)(sn - s);
}

STBSP__PUBLICDEF int STB_SPRINTF_DECORATE(vsprintfcb)(STBSP_SPRINTFCB *callback, void *user, char *buf, char const *fmt, va_list va)
{
    128c:	d1010113          	addi	sp,sp,-752
            // Check if the next 4 bytes contain %(0x25) or end of string.
            // Using the 'hasless' trick:
            // https://graphics.stanford.edu/~seander/bithacks.html#HasLessInWord
            stbsp__uint32 v, c;
            v = *(stbsp__uint32 *)f;
            c = (~v) & 0x80808080;
    1290:	808087b7          	lui	a5,0x80808
            if (((v ^ 0x25252525) - 0x01010101) & c)
    1294:	252523b7          	lui	t2,0x25252
    1298:	52538393          	addi	t2,t2,1317 # 25252525 <_ZSt4cerr+0x2524ad6d>
{
    129c:	29913c23          	sd	s9,664(sp)
    12a0:	29b13423          	sd	s11,648(sp)
   int tlen = 0;
    12a4:	4c81                	li	s9,0
            if (((v ^ 0x25252525) - 0x01010101) & c)
    12a6:	feff0db7          	lui	s11,0xfeff0
            c = (~v) & 0x80808080;
    12aa:	08078793          	addi	a5,a5,128 # ffffffff80808080 <_ZSt4cerr+0xffffffff808008c8>
{
    12ae:	2e813023          	sd	s0,736(sp)
    12b2:	2c913c23          	sd	s1,728(sp)
    12b6:	2d213823          	sd	s2,720(sp)
    12ba:	2d313423          	sd	s3,712(sp)
    12be:	2b713423          	sd	s7,680(sp)
    12c2:	2b813023          	sd	s8,672(sp)
    12c6:	29a13823          	sd	s10,656(sp)
    12ca:	2e113423          	sd	ra,744(sp)
    12ce:	8d66                	mv	s10,s9
    12d0:	8432                	mv	s0,a2
    12d2:	8c9e                	mv	s9,t2
    12d4:	89aa                	mv	s3,a0
    12d6:	e42e                	sd	a1,8(sp)
    12d8:	84b6                	mv	s1,a3
    12da:	8bba                	mv	s7,a4
    12dc:	fc02                	sd	zero,56(sp)
   for (;;) {
    12de:	8932                	mv	s2,a2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    12e0:	effd8d9b          	addiw	s11,s11,-257 # fffffffffefefeff <_ZSt4cerr+0xfffffffffefe8747>
               goto schk1;
            if ((v - 0x01010101) & c)
               goto schk2;
            if (callback)
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    12e4:	20000c13          	li	s8,512
    12e8:	83be                	mv	t2,a5
         while (((stbsp__uintptr)f) & 3) {
    12ea:	0034f793          	andi	a5,s1,3
    12ee:	c7a9                	beqz	a5,1338 <stbsp_vsprintfcb+0xac>
            if (f[0] == '%')
    12f0:	0004c783          	lbu	a5,0(s1)
    12f4:	02500713          	li	a4,37
    12f8:	0ee78263          	beq	a5,a4,13dc <stbsp_vsprintfcb+0x150>
            if (f[0] == 0)
    12fc:	cbd9                	beqz	a5,1392 <stbsp_vsprintfcb+0x106>
            stbsp__chk_cb_buf(1);
    12fe:	02098663          	beqz	s3,132a <stbsp_vsprintfcb+0x9e>
    1302:	4124063b          	subw	a2,s0,s2
    1306:	1fe00713          	li	a4,510
    130a:	02c75063          	bge	a4,a2,132a <stbsp_vsprintfcb+0x9e>
    130e:	65a2                	ld	a1,8(sp)
    1310:	854a                	mv	a0,s2
    1312:	e81e                	sd	t2,16(sp)
    1314:	00cd0d3b          	addw	s10,s10,a2
    1318:	9982                	jalr	s3
    131a:	892a                	mv	s2,a0
    131c:	e119                	bnez	a0,1322 <stbsp_vsprintfcb+0x96>
    131e:	0200106f          	j	233e <stbsp_vsprintfcb+0x10b2>
            *bf++ = f[0];
    1322:	0004c783          	lbu	a5,0(s1)
            stbsp__chk_cb_buf(1);
    1326:	63c2                	ld	t2,16(sp)
    1328:	842a                	mv	s0,a0
            ++f;
    132a:	0485                	addi	s1,s1,1
            *bf++ = f[0];
    132c:	00f40023          	sb	a5,0(s0)
         while (((stbsp__uintptr)f) & 3) {
    1330:	0034f793          	andi	a5,s1,3
            *bf++ = f[0];
    1334:	0405                	addi	s0,s0,1
         while (((stbsp__uintptr)f) & 3) {
    1336:	ffcd                	bnez	a5,12f0 <stbsp_vsprintfcb+0x64>
            v = *(stbsp__uint32 *)f;
    1338:	4094                	lw	a3,0(s1)
            c = (~v) & 0x80808080;
    133a:	fff6c793          	not	a5,a3
            if (((v ^ 0x25252525) - 0x01010101) & c)
    133e:	0196c733          	xor	a4,a3,s9
            c = (~v) & 0x80808080;
    1342:	0077f7b3          	and	a5,a5,t2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    1346:	01b7073b          	addw	a4,a4,s11
    134a:	8f7d                	and	a4,a4,a5
    134c:	2701                	sext.w	a4,a4
    134e:	f34d                	bnez	a4,12f0 <stbsp_vsprintfcb+0x64>
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    1350:	460d                	li	a2,3
    1352:	a805                	j	1382 <stbsp_vsprintfcb+0xf6>
            if (callback)
    1354:	00098863          	beqz	s3,1364 <stbsp_vsprintfcb+0xd8>
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    1358:	412407b3          	sub	a5,s0,s2
    135c:	40fc07bb          	subw	a5,s8,a5
    1360:	f8f658e3          	bge	a2,a5,12f0 <stbsp_vsprintfcb+0x64>
                    bf[2] = f[2];
                    bf[3] = f[3];
                } else
            #endif
            {
                *(stbsp__uint32 *)bf = v;
    1364:	c014                	sw	a3,0(s0)
            v = *(stbsp__uint32 *)f;
    1366:	40d4                	lw	a3,4(s1)
            }
            bf += 4;
    1368:	0411                	addi	s0,s0,4
            f += 4;
    136a:	0491                	addi	s1,s1,4
            c = (~v) & 0x80808080;
    136c:	fff6c793          	not	a5,a3
            if (((v ^ 0x25252525) - 0x01010101) & c)
    1370:	0196c733          	xor	a4,a3,s9
            c = (~v) & 0x80808080;
    1374:	0077f7b3          	and	a5,a5,t2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    1378:	01b7073b          	addw	a4,a4,s11
    137c:	8f7d                	and	a4,a4,a5
    137e:	2701                	sext.w	a4,a4
    1380:	fb25                	bnez	a4,12f0 <stbsp_vsprintfcb+0x64>
            if ((v - 0x01010101) & c)
    1382:	01b6873b          	addw	a4,a3,s11
    1386:	8ff9                	and	a5,a5,a4
    1388:	2781                	sext.w	a5,a5
    138a:	d7e9                	beqz	a5,1354 <stbsp_vsprintfcb+0xc8>
            if (f[0] == 0)
    138c:	0004c783          	lbu	a5,0(s1)
    1390:	f7bd                	bnez	a5,12fe <stbsp_vsprintfcb+0x72>
endfmt:

   if (!callback)
      *bf = 0;
   else
      stbsp__flush_cb();
    1392:	8cea                	mv	s9,s10
    1394:	412404bb          	subw	s1,s0,s2
   if (!callback)
    1398:	70098563          	beqz	s3,1aa2 <stbsp_vsprintfcb+0x816>
      stbsp__flush_cb();
    139c:	00905663          	blez	s1,13a8 <stbsp_vsprintfcb+0x11c>
    13a0:	65a2                	ld	a1,8(sp)
    13a2:	8626                	mv	a2,s1
    13a4:	854a                	mv	a0,s2
    13a6:	9982                	jalr	s3
    13a8:	009c8cbb          	addw	s9,s9,s1

done:
   return tlen + (int)(bf - buf);
}
    13ac:	2e813083          	ld	ra,744(sp)
    13b0:	2e013403          	ld	s0,736(sp)
    13b4:	2d813483          	ld	s1,728(sp)
    13b8:	2d013903          	ld	s2,720(sp)
    13bc:	2c813983          	ld	s3,712(sp)
    13c0:	2a813b83          	ld	s7,680(sp)
    13c4:	2a013c03          	ld	s8,672(sp)
    13c8:	29013d03          	ld	s10,656(sp)
    13cc:	28813d83          	ld	s11,648(sp)
    13d0:	8566                	mv	a0,s9
    13d2:	29813c83          	ld	s9,664(sp)
    13d6:	2f010113          	addi	sp,sp,752
    13da:	8082                	ret
    13dc:	2d413023          	sd	s4,704(sp)
    13e0:	2b513c23          	sd	s5,696(sp)
    13e4:	2b613823          	sd	s6,688(sp)
      tz = 0;
    13e8:	00248693          	addi	a3,s1,2
      fl = 0;
    13ec:	4e01                	li	t3,0
         switch (f[0]) {
    13ee:	03f00593          	li	a1,63
    13f2:	00004617          	auipc	a2,0x4
    13f6:	cc660613          	addi	a2,a2,-826 # 50b8 <_GLOBAL__sub_I__ZSt3cin+0x10a>
    13fa:	fff6c783          	lbu	a5,-1(a3)
    13fe:	fff68493          	addi	s1,a3,-1
    1402:	fe07871b          	addiw	a4,a5,-32
    1406:	0ff77713          	zext.b	a4,a4
    140a:	00e5ec63          	bltu	a1,a4,1422 <stbsp_vsprintfcb+0x196>
    140e:	070a                	slli	a4,a4,0x2
    1410:	9732                	add	a4,a4,a2
    1412:	4318                	lw	a4,0(a4)
    1414:	9732                	add	a4,a4,a2
    1416:	8702                	jr	a4
      if (f[0] == '*') {
    1418:	0014c783          	lbu	a5,1(s1)
            fl |= STBSP__LEADINGZERO;
    141c:	010e6e13          	ori	t3,t3,16
            ++f;
    1420:	0485                	addi	s1,s1,1
      if (f[0] == '*') {
    1422:	02a00713          	li	a4,42
    1426:	0ce79163          	bne	a5,a4,14e8 <stbsp_vsprintfcb+0x25c>
         fw = va_arg(va, stbsp__uint32);
    142a:	000bab03          	lw	s6,0(s7)
         while ((f[0] >= '0') && (f[0] <= '9')) {
    142e:	0014c783          	lbu	a5,1(s1)
         fw = va_arg(va, stbsp__uint32);
    1432:	0ba1                	addi	s7,s7,8
         ++f;
    1434:	0485                	addi	s1,s1,1
      if (f[0] == '.') {
    1436:	02e00713          	li	a4,46
      pr = -1;
    143a:	58fd                	li	a7,-1
      if (f[0] == '.') {
    143c:	0ee78663          	beq	a5,a4,1528 <stbsp_vsprintfcb+0x29c>
      switch (f[0]) {
    1440:	04900713          	li	a4,73
    1444:	10e78263          	beq	a5,a4,1548 <stbsp_vsprintfcb+0x2bc>
    1448:	f987871b          	addiw	a4,a5,-104
    144c:	0ff77713          	zext.b	a4,a4
    1450:	46c9                	li	a3,18
    1452:	02e6e063          	bltu	a3,a4,1472 <stbsp_vsprintfcb+0x1e6>
    1456:	00004697          	auipc	a3,0x4
    145a:	d6268693          	addi	a3,a3,-670 # 51b8 <_GLOBAL__sub_I__ZSt3cin+0x20a>
    145e:	070a                	slli	a4,a4,0x2
    1460:	9736                	add	a4,a4,a3
    1462:	4318                	lw	a4,0(a4)
    1464:	9736                	add	a4,a4,a3
    1466:	8702                	jr	a4
         if (f[0] == 'h')
    1468:	0014c783          	lbu	a5,1(s1)
         fl |= (sizeof(ptrdiff_t) == 8) ? STBSP__INTMAX : 0;
    146c:	020e6e13          	ori	t3,t3,32
         ++f;
    1470:	0485                	addi	s1,s1,1
      switch (f[0]) {
    1472:	fbf7871b          	addiw	a4,a5,-65
    1476:	0ff77713          	zext.b	a4,a4
    147a:	03700693          	li	a3,55
    147e:	0ee6ea63          	bltu	a3,a4,1572 <stbsp_vsprintfcb+0x2e6>
    1482:	00004697          	auipc	a3,0x4
    1486:	d8268693          	addi	a3,a3,-638 # 5204 <_GLOBAL__sub_I__ZSt3cin+0x256>
    148a:	070a                	slli	a4,a4,0x2
    148c:	9736                	add	a4,a4,a3
    148e:	4318                	lw	a4,0(a4)
    1490:	9736                	add	a4,a4,a3
    1492:	8702                	jr	a4
            fl |= STBSP__METRIC_NOSPACE;
    1494:	400e6e13          	ori	t3,t3,1024
            continue;
    1498:	0685                	addi	a3,a3,1
    149a:	b785                	j	13fa <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEFTJUST;
    149c:	001e6e13          	ori	t3,t3,1
            continue;
    14a0:	0685                	addi	a3,a3,1
    14a2:	bfa1                	j	13fa <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADINGPLUS;
    14a4:	002e6e13          	ori	t3,t3,2
            continue;
    14a8:	0685                	addi	a3,a3,1
    14aa:	bf81                	j	13fa <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__TRIPLET_COMMA;
    14ac:	040e6e13          	ori	t3,t3,64
            continue;
    14b0:	0685                	addi	a3,a3,1
    14b2:	b7a1                	j	13fa <stbsp_vsprintfcb+0x16e>
            if (fl & STBSP__METRIC_SUFFIX) {
    14b4:	100e7793          	andi	a5,t3,256
    14b8:	8772                	mv	a4,t3
    14ba:	56078363          	beqz	a5,1a20 <stbsp_vsprintfcb+0x794>
               if (fl & STBSP__METRIC_1024) {
    14be:	6785                	lui	a5,0x1
    14c0:	034e1513          	slli	a0,t3,0x34
    14c4:	80078793          	addi	a5,a5,-2048 # 800 <stbsp__real_to_str+0x658>
    14c8:	5c055863          	bgez	a0,1a98 <stbsp_vsprintfcb+0x80c>
                  fl |= STBSP__METRIC_JEDEC;
    14cc:	6785                	lui	a5,0x1
    14ce:	8f5d                	or	a4,a4,a5
    14d0:	00070e1b          	sext.w	t3,a4
    14d4:	0685                	addi	a3,a3,1
    14d6:	b715                	j	13fa <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADING_0X;
    14d8:	008e6e13          	ori	t3,t3,8
            continue;
    14dc:	0685                	addi	a3,a3,1
    14de:	bf31                	j	13fa <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADINGSPACE;
    14e0:	004e6e13          	ori	t3,t3,4
            continue;
    14e4:	0685                	addi	a3,a3,1
    14e6:	bf11                	j	13fa <stbsp_vsprintfcb+0x16e>
         while ((f[0] >= '0') && (f[0] <= '9')) {
    14e8:	fd07871b          	addiw	a4,a5,-48 # fd0 <_vscanf_core.constprop.0+0x69a>
    14ec:	0ff77713          	zext.b	a4,a4
    14f0:	4625                	li	a2,9
      fw = 0;
    14f2:	4b01                	li	s6,0
         while ((f[0] >= '0') && (f[0] <= '9')) {
    14f4:	46a5                	li	a3,9
    14f6:	f4e660e3          	bltu	a2,a4,1436 <stbsp_vsprintfcb+0x1aa>
            fw = fw * 10 + f[0] - '0';
    14fa:	002b171b          	slliw	a4,s6,0x2
    14fe:	0167073b          	addw	a4,a4,s6
    1502:	0017171b          	slliw	a4,a4,0x1
            f++;
    1506:	0485                	addi	s1,s1,1
            fw = fw * 10 + f[0] - '0';
    1508:	9f3d                	addw	a4,a4,a5
         while ((f[0] >= '0') && (f[0] <= '9')) {
    150a:	0004c783          	lbu	a5,0(s1)
            fw = fw * 10 + f[0] - '0';
    150e:	fd070b1b          	addiw	s6,a4,-48
         while ((f[0] >= '0') && (f[0] <= '9')) {
    1512:	fd07871b          	addiw	a4,a5,-48
    1516:	0ff77713          	zext.b	a4,a4
    151a:	fee6f0e3          	bgeu	a3,a4,14fa <stbsp_vsprintfcb+0x26e>
      if (f[0] == '.') {
    151e:	02e00713          	li	a4,46
      pr = -1;
    1522:	58fd                	li	a7,-1
      if (f[0] == '.') {
    1524:	f0e79ee3          	bne	a5,a4,1440 <stbsp_vsprintfcb+0x1b4>
         if (f[0] == '*') {
    1528:	0014c783          	lbu	a5,1(s1)
    152c:	02a00713          	li	a4,42
    1530:	52e79763          	bne	a5,a4,1a5e <stbsp_vsprintfcb+0x7d2>
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1534:	0024c783          	lbu	a5,2(s1)
      switch (f[0]) {
    1538:	04900713          	li	a4,73
            pr = va_arg(va, stbsp__uint32);
    153c:	000ba883          	lw	a7,0(s7)
            ++f;
    1540:	0489                	addi	s1,s1,2
            pr = va_arg(va, stbsp__uint32);
    1542:	0ba1                	addi	s7,s7,8
      switch (f[0]) {
    1544:	f0e792e3          	bne	a5,a4,1448 <stbsp_vsprintfcb+0x1bc>
         if ((f[1] == '6') && (f[2] == '4')) {
    1548:	0014c783          	lbu	a5,1(s1)
    154c:	03600713          	li	a4,54
    1550:	00e79463          	bne	a5,a4,1558 <stbsp_vsprintfcb+0x2cc>
    1554:	1e60106f          	j	273a <stbsp_vsprintfcb+0x14ae>
         } else if ((f[1] == '3') && (f[2] == '2')) {
    1558:	03300713          	li	a4,51
    155c:	6ae796e3          	bne	a5,a4,2408 <stbsp_vsprintfcb+0x117c>
    1560:	0024c683          	lbu	a3,2(s1)
    1564:	03200713          	li	a4,50
    1568:	00e69463          	bne	a3,a4,1570 <stbsp_vsprintfcb+0x2e4>
    156c:	0ae0106f          	j	261a <stbsp_vsprintfcb+0x138e>
            ++f;
    1570:	0485                	addi	s1,s1,1
         *s = f[0];
    1572:	26f10fa3          	sb	a5,639(sp)
         l = 1;
    1576:	4785                	li	a5,1
    1578:	d0be                	sw	a5,96(sp)
         lead[0] = 0;
    157a:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    157e:	06010823          	sb	zero,112(sp)
         dp = 0;
    1582:	d282                	sw	zero,100(sp)
    1584:	e0de                	sd	s7,64(sp)
    1586:	4701                	li	a4,0
    1588:	4301                	li	t1,0
    158a:	4f81                	li	t6,0
    158c:	4685                	li	a3,1
    158e:	4a01                	li	s4,0
         cs = 0;
    1590:	4281                	li	t0,0
         s = num + STBSP__NUMSZ - 1;
    1592:	27f10a93          	addi	s5,sp,639
         fw = fl = 0;
    1596:	4e01                	li	t3,0
      tz = 0;
    1598:	4881                	li	a7,0
            if (fl & STBSP__LEADINGZERO) // if leading zeros, everything is in pr
    159a:	010e7793          	andi	a5,t3,16
    159e:	40078ee3          	beqz	a5,21ba <stbsp_vsprintfcb+0xf2e>
               pr = (fw > pr) ? fw : pr;
    15a2:	87ba                	mv	a5,a4
    15a4:	00675363          	bge	a4,t1,15aa <stbsp_vsprintfcb+0x31e>
    15a8:	879a                	mv	a5,t1
    15aa:	0007871b          	sext.w	a4,a5
               fw = 0;
    15ae:	4301                	li	t1,0
         if (fw + pr) {
    15b0:	62070563          	beqz	a4,1bda <stbsp_vsprintfcb+0x94e>
            sn = lead + 1;
    15b4:	06910793          	addi	a5,sp,105
    15b8:	fcbe                	sd	a5,120(sp)
            while (lead[0]) {
    15ba:	0a0a0863          	beqz	s4,166a <stbsp_vsprintfcb+0x3de>
               stbsp__cb_buf_clamp(i, lead[0]);
    15be:	f026                	sd	s1,32(sp)
    15c0:	f436                	sd	a3,40(sp)
    15c2:	854a                	mv	a0,s2
    15c4:	86d2                	mv	a3,s4
    15c6:	84ce                	mv	s1,s3
               stbsp__chk_cb_buf(1);
    15c8:	1fe00b93          	li	s7,510
               stbsp__cb_buf_clamp(i, lead[0]);
    15cc:	89be                	mv	s3,a5
    15ce:	20000b13          	li	s6,512
    15d2:	87a2                	mv	a5,s0
    15d4:	e846                	sd	a7,16(sp)
    15d6:	846a                	mv	s0,s10
    15d8:	ec7e                	sd	t6,24(sp)
    15da:	8d6e                	mv	s10,s11
    15dc:	f872                	sd	t3,48(sp)
    15de:	8de6                	mv	s11,s9
    15e0:	8a3a                	mv	s4,a4
    15e2:	e496                	sd	t0,72(sp)
    15e4:	891a                	mv	s2,t1
    15e6:	8c9e                	mv	s9,t2
    15e8:	0006871b          	sext.w	a4,a3
    15ec:	2e0482e3          	beqz	s1,20d0 <stbsp_vsprintfcb+0xe44>
    15f0:	40a7863b          	subw	a2,a5,a0
    15f4:	40cb083b          	subw	a6,s6,a2
    15f8:	85c2                	mv	a1,a6
    15fa:	01075363          	bge	a4,a6,1600 <stbsp_vsprintfcb+0x374>
    15fe:	85ba                	mv	a1,a4
               lead[0] -= (char)i;
    1600:	9e8d                	subw	a3,a3,a1
               stbsp__cb_buf_clamp(i, lead[0]);
    1602:	0005871b          	sext.w	a4,a1
               lead[0] -= (char)i;
    1606:	06d10423          	sb	a3,104(sp)
               while (i) {
    160a:	c70d                	beqz	a4,1634 <stbsp_vsprintfcb+0x3a8>
    160c:	7866                	ld	a6,120(sp)
    160e:	02071593          	slli	a1,a4,0x20
    1612:	9181                	srli	a1,a1,0x20
    1614:	00b78633          	add	a2,a5,a1
    1618:	8742                	mv	a4,a6
                  *bf++ = *sn++;
    161a:	00074683          	lbu	a3,0(a4)
    161e:	0785                	addi	a5,a5,1
               while (i) {
    1620:	0705                	addi	a4,a4,1
                  *bf++ = *sn++;
    1622:	fed78fa3          	sb	a3,-1(a5)
               while (i) {
    1626:	fec79ae3          	bne	a5,a2,161a <stbsp_vsprintfcb+0x38e>
    162a:	982e                	add	a6,a6,a1
    162c:	fcc2                	sd	a6,120(sp)
               stbsp__chk_cb_buf(1);
    162e:	c899                	beqz	s1,1644 <stbsp_vsprintfcb+0x3b8>
    1630:	40a7863b          	subw	a2,a5,a0
    1634:	00cbd863          	bge	s7,a2,1644 <stbsp_vsprintfcb+0x3b8>
    1638:	65a2                	ld	a1,8(sp)
    163a:	9c31                	addw	s0,s0,a2
    163c:	9482                	jalr	s1
    163e:	34050ee3          	beqz	a0,219a <stbsp_vsprintfcb+0xf0e>
    1642:	87aa                	mv	a5,a0
            while (lead[0]) {
    1644:	06814683          	lbu	a3,104(sp)
    1648:	f2c5                	bnez	a3,15e8 <stbsp_vsprintfcb+0x35c>
    164a:	83e6                	mv	t2,s9
    164c:	68c2                	ld	a7,16(sp)
    164e:	8cee                	mv	s9,s11
    1650:	6fe2                	ld	t6,24(sp)
    1652:	8dea                	mv	s11,s10
    1654:	76a2                	ld	a3,40(sp)
    1656:	8d22                	mv	s10,s0
    1658:	7e42                	ld	t3,48(sp)
    165a:	843e                	mv	s0,a5
    165c:	62a6                	ld	t0,72(sp)
    165e:	87ce                	mv	a5,s3
    1660:	89a6                	mv	s3,s1
    1662:	7482                	ld	s1,32(sp)
    1664:	834a                	mv	t1,s2
    1666:	8752                	mv	a4,s4
    1668:	892a                	mv	s2,a0
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    166a:	040e7b13          	andi	s6,t3,64
            c = cs >> 24;
    166e:	0182d61b          	srliw	a2,t0,0x18
    1672:	0182db9b          	srliw	s7,t0,0x18
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    1676:	4a01                	li	s4,0
    1678:	000b0e63          	beqz	s6,1694 <stbsp_vsprintfcb+0x408>
            cs &= 0xffffff;
    167c:	02829a13          	slli	s4,t0,0x28
    1680:	028a5a13          	srli	s4,s4,0x28
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    1684:	00ea0a3b          	addw	s4,s4,a4
    1688:	0016059b          	addiw	a1,a2,1
    168c:	02ba7a3b          	remuw	s4,s4,a1
    1690:	41460a3b          	subw	s4,a2,s4
            while (pr > 0) {
    1694:	0ce05763          	blez	a4,1762 <stbsp_vsprintfcb+0x4d6>
                     *(stbsp__uint32 *)bf = 0x30303030;
    1698:	30303837          	lui	a6,0x30303
    169c:	03080813          	addi	a6,a6,48 # 30303030 <_ZSt4cerr+0x302fb878>
    16a0:	f026                	sd	s1,32(sp)
    16a2:	854a                	mv	a0,s2
    16a4:	84da                	mv	s1,s6
    16a6:	895e                	mv	s2,s7
    16a8:	e4d6                	sd	s5,72(sp)
    16aa:	8b4e                	mv	s6,s3
    16ac:	8aea                	mv	s5,s10
               stbsp__chk_cb_buf(1);
    16ae:	1fe00293          	li	t0,510
    16b2:	8d6e                	mv	s10,s11
                     *bf++ = stbsp__comma;
    16b4:	00005f17          	auipc	t5,0x5
    16b8:	20cf0f13          	addi	t5,t5,524 # 68c0 <stbsp__digitpair>
    16bc:	8de6                	mv	s11,s9
                     *bf++ = '0';
    16be:	03000e93          	li	t4,48
    16c2:	e846                	sd	a7,16(sp)
    16c4:	ec7e                	sd	t6,24(sp)
    16c6:	f436                	sd	a3,40(sp)
    16c8:	f872                	sd	t3,48(sp)
    16ca:	e89a                	sd	t1,80(sp)
    16cc:	89ba                	mv	s3,a4
    16ce:	ecbe                	sd	a5,88(sp)
    16d0:	8bc2                	mv	s7,a6
    16d2:	8c9e                	mv	s9,t2
               stbsp__cb_buf_clamp(i, pr);
    16d4:	240b0ee3          	beqz	s6,2130 <stbsp_vsprintfcb+0xea4>
    16d8:	40a407b3          	sub	a5,s0,a0
    16dc:	40fc063b          	subw	a2,s8,a5
    16e0:	87b2                	mv	a5,a2
    16e2:	00c9d363          	bge	s3,a2,16e8 <stbsp_vsprintfcb+0x45c>
    16e6:	87ce                	mv	a5,s3
    16e8:	0007859b          	sext.w	a1,a5
               pr -= i;
    16ec:	40f989bb          	subw	s3,s3,a5
               if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    16f0:	32048c63          	beqz	s1,1a28 <stbsp_vsprintfcb+0x79c>
               while (i) {
    16f4:	34058a63          	beqz	a1,1a48 <stbsp_vsprintfcb+0x7bc>
    16f8:	1582                	slli	a1,a1,0x20
                     *bf++ = stbsp__comma;
    16fa:	0cdf4603          	lbu	a2,205(t5)
    16fe:	9181                	srli	a1,a1,0x20
    1700:	95a2                	add	a1,a1,s0
    1702:	0405                	addi	s0,s0,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (cs++ == c)) {
    1704:	c481                	beqz	s1,170c <stbsp_vsprintfcb+0x480>
    1706:	1d4901e3          	beq	s2,s4,20c8 <stbsp_vsprintfcb+0xe3c>
    170a:	2a05                	addiw	s4,s4,1
                     *bf++ = '0';
    170c:	03000793          	li	a5,48
    1710:	fef40fa3          	sb	a5,-1(s0)
               while (i) {
    1714:	fe8597e3          	bne	a1,s0,1702 <stbsp_vsprintfcb+0x476>
               stbsp__chk_cb_buf(1);
    1718:	320b0b63          	beqz	s6,1a4e <stbsp_vsprintfcb+0x7c2>
    171c:	40a5863b          	subw	a2,a1,a0
    1720:	32c2d763          	bge	t0,a2,1a4e <stbsp_vsprintfcb+0x7c2>
    1724:	65a2                	ld	a1,8(sp)
    1726:	01560abb          	addw	s5,a2,s5
    172a:	9b02                	jalr	s6
    172c:	3a050ce3          	beqz	a0,22e4 <stbsp_vsprintfcb+0x1058>
    1730:	842a                	mv	s0,a0
    1732:	1fe00293          	li	t0,510
    1736:	00005f17          	auipc	t5,0x5
    173a:	18af0f13          	addi	t5,t5,394 # 68c0 <stbsp__digitpair>
    173e:	03000e93          	li	t4,48
            while (pr > 0) {
    1742:	f93049e3          	bgtz	s3,16d4 <stbsp_vsprintfcb+0x448>
         while (lead[0]) {
    1746:	83e6                	mv	t2,s9
    1748:	68c2                	ld	a7,16(sp)
    174a:	8cee                	mv	s9,s11
    174c:	6fe2                	ld	t6,24(sp)
    174e:	8dea                	mv	s11,s10
    1750:	7482                	ld	s1,32(sp)
    1752:	8d56                	mv	s10,s5
    1754:	76a2                	ld	a3,40(sp)
    1756:	7e42                	ld	t3,48(sp)
    1758:	6346                	ld	t1,80(sp)
    175a:	67e6                	ld	a5,88(sp)
    175c:	6aa6                	ld	s5,72(sp)
    175e:	892a                	mv	s2,a0
    1760:	89da                	mv	s3,s6
    1762:	06814a03          	lbu	s4,104(sp)
         sn = lead + 1;
    1766:	fcbe                	sd	a5,120(sp)
         while (lead[0]) {
    1768:	0a0a0263          	beqz	s4,180c <stbsp_vsprintfcb+0x580>
            stbsp__cb_buf_clamp(i, lead[0]);
    176c:	ec26                	sd	s1,24(sp)
    176e:	f036                	sd	a3,32(sp)
    1770:	854a                	mv	a0,s2
    1772:	86d2                	mv	a3,s4
    1774:	84ce                	mv	s1,s3
    1776:	87a2                	mv	a5,s0
            stbsp__chk_cb_buf(1);
    1778:	1fe00b93          	li	s7,510
            stbsp__cb_buf_clamp(i, lead[0]);
    177c:	846a                	mv	s0,s10
    177e:	20000b13          	li	s6,512
    1782:	8d6e                	mv	s10,s11
    1784:	e846                	sd	a7,16(sp)
    1786:	8de6                	mv	s11,s9
    1788:	8a7e                	mv	s4,t6
    178a:	8972                	mv	s2,t3
    178c:	899a                	mv	s3,t1
    178e:	8c9e                	mv	s9,t2
    1790:	0006871b          	sext.w	a4,a3
    1794:	140482e3          	beqz	s1,20d8 <stbsp_vsprintfcb+0xe4c>
    1798:	40a7863b          	subw	a2,a5,a0
    179c:	40cb083b          	subw	a6,s6,a2
    17a0:	85c2                	mv	a1,a6
    17a2:	01075363          	bge	a4,a6,17a8 <stbsp_vsprintfcb+0x51c>
    17a6:	85ba                	mv	a1,a4
            lead[0] -= (char)i;
    17a8:	9e8d                	subw	a3,a3,a1
            stbsp__cb_buf_clamp(i, lead[0]);
    17aa:	0005871b          	sext.w	a4,a1
            lead[0] -= (char)i;
    17ae:	06d10423          	sb	a3,104(sp)
            while (i) {
    17b2:	c70d                	beqz	a4,17dc <stbsp_vsprintfcb+0x550>
    17b4:	7866                	ld	a6,120(sp)
    17b6:	02071593          	slli	a1,a4,0x20
    17ba:	9181                	srli	a1,a1,0x20
    17bc:	00b78633          	add	a2,a5,a1
    17c0:	8742                	mv	a4,a6
               *bf++ = *sn++;
    17c2:	00074683          	lbu	a3,0(a4)
    17c6:	0785                	addi	a5,a5,1
            while (i) {
    17c8:	0705                	addi	a4,a4,1
               *bf++ = *sn++;
    17ca:	fed78fa3          	sb	a3,-1(a5)
            while (i) {
    17ce:	fec79ae3          	bne	a5,a2,17c2 <stbsp_vsprintfcb+0x536>
    17d2:	982e                	add	a6,a6,a1
    17d4:	fcc2                	sd	a6,120(sp)
            stbsp__chk_cb_buf(1);
    17d6:	c899                	beqz	s1,17ec <stbsp_vsprintfcb+0x560>
    17d8:	40a7863b          	subw	a2,a5,a0
    17dc:	00cbd863          	bge	s7,a2,17ec <stbsp_vsprintfcb+0x560>
    17e0:	65a2                	ld	a1,8(sp)
    17e2:	9c31                	addw	s0,s0,a2
    17e4:	9482                	jalr	s1
    17e6:	1a050ae3          	beqz	a0,219a <stbsp_vsprintfcb+0xf0e>
    17ea:	87aa                	mv	a5,a0
         while (lead[0]) {
    17ec:	06814683          	lbu	a3,104(sp)
    17f0:	f2c5                	bnez	a3,1790 <stbsp_vsprintfcb+0x504>
    17f2:	834e                	mv	t1,s3
    17f4:	68c2                	ld	a7,16(sp)
    17f6:	89a6                	mv	s3,s1
    17f8:	7682                	ld	a3,32(sp)
    17fa:	64e2                	ld	s1,24(sp)
    17fc:	8e4a                	mv	t3,s2
    17fe:	83e6                	mv	t2,s9
    1800:	8fd2                	mv	t6,s4
    1802:	8cee                	mv	s9,s11
    1804:	892a                	mv	s2,a0
    1806:	8dea                	mv	s11,s10
    1808:	8d22                	mv	s10,s0
    180a:	843e                	mv	s0,a5
         while (n) {
    180c:	c6f9                	beqz	a3,18da <stbsp_vsprintfcb+0x64e>
            STBSP__UNALIGNED(while (i >= 4) {
    180e:	ec26                	sd	s1,24(sp)
    1810:	854a                	mv	a0,s2
    1812:	84d6                	mv	s1,s5
    1814:	896a                	mv	s2,s10
    1816:	87a2                	mv	a5,s0
    1818:	8d6e                	mv	s10,s11
            stbsp__chk_cb_buf(1);
    181a:	1fe00b93          	li	s7,510
            STBSP__UNALIGNED(while (i >= 4) {
    181e:	8de6                	mv	s11,s9
            stbsp__cb_buf_clamp(i, n);
    1820:	20000b13          	li	s6,512
            STBSP__UNALIGNED(while (i >= 4) {
    1824:	4a0d                	li	s4,3
    1826:	e87e                	sd	t6,16(sp)
    1828:	f072                	sd	t3,32(sp)
    182a:	8ac6                	mv	s5,a7
    182c:	f41a                	sd	t1,40(sp)
    182e:	8436                	mv	s0,a3
    1830:	8c9e                	mv	s9,t2
            stbsp__cb_buf_clamp(i, n);
    1832:	0004071b          	sext.w	a4,s0
    1836:	100982e3          	beqz	s3,213a <stbsp_vsprintfcb+0xeae>
    183a:	40a78633          	sub	a2,a5,a0
    183e:	40cb05bb          	subw	a1,s6,a2
    1842:	862e                	mv	a2,a1
    1844:	00b75363          	bge	a4,a1,184a <stbsp_vsprintfcb+0x5be>
    1848:	863a                	mv	a2,a4
    184a:	0006071b          	sext.w	a4,a2
            n -= i;
    184e:	9c11                	subw	s0,s0,a2
            STBSP__UNALIGNED(while (i >= 4) {
    1850:	14ea50e3          	bge	s4,a4,2190 <stbsp_vsprintfcb+0xf04>
    1854:	ffc70f1b          	addiw	t5,a4,-4
    1858:	002f5e9b          	srliw	t4,t5,0x2
    185c:	001e8e1b          	addiw	t3,t4,1
    1860:	0e0a                	slli	t3,t3,0x2
    1862:	01c785b3          	add	a1,a5,t3
    1866:	8626                	mv	a2,s1
    1868:	4218                	lw	a4,0(a2)
    186a:	0791                	addi	a5,a5,4
    186c:	0611                	addi	a2,a2,4
    186e:	2701                	sext.w	a4,a4
    1870:	fee7ae23          	sw	a4,-4(a5)
    1874:	feb79ae3          	bne	a5,a1,1868 <stbsp_vsprintfcb+0x5dc>
    1878:	002e9e9b          	slliw	t4,t4,0x2
    187c:	41df073b          	subw	a4,t5,t4
            while (i) {
    1880:	94f2                	add	s1,s1,t3
    1882:	c31d                	beqz	a4,18a8 <stbsp_vsprintfcb+0x61c>
    1884:	8626                	mv	a2,s1
    1886:	87ae                	mv	a5,a1
    1888:	00e58f3b          	addw	t5,a1,a4
               *bf++ = *s++;
    188c:	00064e83          	lbu	t4,0(a2)
    1890:	0785                	addi	a5,a5,1
            while (i) {
    1892:	00078e1b          	sext.w	t3,a5
               *bf++ = *s++;
    1896:	ffd78fa3          	sb	t4,-1(a5)
    189a:	0605                	addi	a2,a2,1
            while (i) {
    189c:	ffcf18e3          	bne	t5,t3,188c <stbsp_vsprintfcb+0x600>
    18a0:	1702                	slli	a4,a4,0x20
    18a2:	9301                	srli	a4,a4,0x20
    18a4:	95ba                	add	a1,a1,a4
    18a6:	94ba                	add	s1,s1,a4
            stbsp__chk_cb_buf(1);
    18a8:	1a098763          	beqz	s3,1a56 <stbsp_vsprintfcb+0x7ca>
    18ac:	40a5863b          	subw	a2,a1,a0
    18b0:	1acbd363          	bge	s7,a2,1a56 <stbsp_vsprintfcb+0x7ca>
    18b4:	65a2                	ld	a1,8(sp)
    18b6:	0126093b          	addw	s2,a2,s2
    18ba:	9982                	jalr	s3
    18bc:	20050be3          	beqz	a0,22d2 <stbsp_vsprintfcb+0x1046>
    18c0:	87aa                	mv	a5,a0
         while (n) {
    18c2:	f825                	bnez	s0,1832 <stbsp_vsprintfcb+0x5a6>
    18c4:	6fc2                	ld	t6,16(sp)
    18c6:	64e2                	ld	s1,24(sp)
    18c8:	7e02                	ld	t3,32(sp)
    18ca:	7322                	ld	t1,40(sp)
    18cc:	83e6                	mv	t2,s9
    18ce:	88d6                	mv	a7,s5
    18d0:	8cee                	mv	s9,s11
    18d2:	843e                	mv	s0,a5
    18d4:	8dea                	mv	s11,s10
    18d6:	8d4a                	mv	s10,s2
    18d8:	892a                	mv	s2,a0
         while (tz) {
    18da:	08088863          	beqz	a7,196a <stbsp_vsprintfcb+0x6de>
               *(stbsp__uint32 *)bf = 0x30303030;
    18de:	30303b37          	lui	s6,0x30303
               *bf++ = '0';
    18e2:	03000a13          	li	s4,48
            while (i >= 4) {
    18e6:	4a8d                	li	s5,3
            stbsp__chk_cb_buf(1);
    18e8:	1fe00693          	li	a3,510
               *(stbsp__uint32 *)bf = 0x30303030;
    18ec:	030b0b13          	addi	s6,s6,48 # 30303030 <_ZSt4cerr+0x302fb878>
            stbsp__cb_buf_clamp(i, tz);
    18f0:	20000b93          	li	s7,512
    18f4:	040989e3          	beqz	s3,2146 <stbsp_vsprintfcb+0xeba>
    18f8:	41240633          	sub	a2,s0,s2
    18fc:	40cb87bb          	subw	a5,s7,a2
    1900:	873e                	mv	a4,a5
    1902:	00f8d363          	bge	a7,a5,1908 <stbsp_vsprintfcb+0x67c>
    1906:	8746                	mv	a4,a7
    1908:	0007079b          	sext.w	a5,a4
            tz -= i;
    190c:	40e888bb          	subw	a7,a7,a4
            while (i) {
    1910:	08078ee3          	beqz	a5,21ac <stbsp_vsprintfcb+0xf20>
               if ((((stbsp__uintptr)bf) & 3) == 0)
    1914:	00347713          	andi	a4,s0,3
    1918:	e719                	bnez	a4,1926 <stbsp_vsprintfcb+0x69a>
    191a:	0390006f          	j	2152 <stbsp_vsprintfcb+0xec6>
    191e:	00347713          	andi	a4,s0,3
    1922:	7a070f63          	beqz	a4,20e0 <stbsp_vsprintfcb+0xe54>
               *bf++ = '0';
    1926:	01440023          	sb	s4,0(s0)
               --i;
    192a:	37fd                	addiw	a5,a5,-1
               *bf++ = '0';
    192c:	0405                	addi	s0,s0,1
            while (i) {
    192e:	fbe5                	bnez	a5,191e <stbsp_vsprintfcb+0x692>
            stbsp__chk_cb_buf(1);
    1930:	02098b63          	beqz	s3,1966 <stbsp_vsprintfcb+0x6da>
    1934:	4124063b          	subw	a2,s0,s2
    1938:	02c6d763          	bge	a3,a2,1966 <stbsp_vsprintfcb+0x6da>
    193c:	65a2                	ld	a1,8(sp)
    193e:	854a                	mv	a0,s2
    1940:	f81e                	sd	t2,48(sp)
    1942:	f41a                	sd	t1,40(sp)
    1944:	f072                	sd	t3,32(sp)
    1946:	ec7e                	sd	t6,24(sp)
    1948:	e846                	sd	a7,16(sp)
    194a:	00cd0d3b          	addw	s10,s10,a2
    194e:	9982                	jalr	s3
    1950:	892a                	mv	s2,a0
    1952:	1a0502e3          	beqz	a0,22f6 <stbsp_vsprintfcb+0x106a>
    1956:	73c2                	ld	t2,48(sp)
    1958:	7322                	ld	t1,40(sp)
    195a:	7e02                	ld	t3,32(sp)
    195c:	6fe2                	ld	t6,24(sp)
    195e:	68c2                	ld	a7,16(sp)
    1960:	842a                	mv	s0,a0
    1962:	1fe00693          	li	a3,510
         while (tz) {
    1966:	f80897e3          	bnez	a7,18f4 <stbsp_vsprintfcb+0x668>
         sn = tail + 1;
    196a:	07110793          	addi	a5,sp,113
    196e:	fcbe                	sd	a5,120(sp)
         while (tail[0]) {
    1970:	080f8763          	beqz	t6,19fe <stbsp_vsprintfcb+0x772>
            stbsp__cb_buf_clamp(i, tail[0]);
    1974:	854a                	mv	a0,s2
    1976:	8b6a                	mv	s6,s10
            stbsp__chk_cb_buf(1);
    1978:	1fe00a93          	li	s5,510
            stbsp__cb_buf_clamp(i, tail[0]);
    197c:	8d4e                	mv	s10,s3
    197e:	20000a13          	li	s4,512
    1982:	8bf2                	mv	s7,t3
    1984:	891a                	mv	s2,t1
    1986:	899e                	mv	s3,t2
    1988:	000f879b          	sext.w	a5,t6
    198c:	7c0d0863          	beqz	s10,215c <stbsp_vsprintfcb+0xed0>
    1990:	40a4063b          	subw	a2,s0,a0
    1994:	40ca06bb          	subw	a3,s4,a2
    1998:	8736                	mv	a4,a3
    199a:	00d7d363          	bge	a5,a3,19a0 <stbsp_vsprintfcb+0x714>
    199e:	873e                	mv	a4,a5
            tail[0] -= (char)i;
    19a0:	40ef8fbb          	subw	t6,t6,a4
            stbsp__cb_buf_clamp(i, tail[0]);
    19a4:	0007079b          	sext.w	a5,a4
            tail[0] -= (char)i;
    19a8:	07f10823          	sb	t6,112(sp)
            while (i) {
    19ac:	c795                	beqz	a5,19d8 <stbsp_vsprintfcb+0x74c>
    19ae:	75e6                	ld	a1,120(sp)
    19b0:	02079613          	slli	a2,a5,0x20
    19b4:	9201                	srli	a2,a2,0x20
    19b6:	00c406b3          	add	a3,s0,a2
    19ba:	87ae                	mv	a5,a1
               *bf++ = *sn++;
    19bc:	0007c703          	lbu	a4,0(a5)
    19c0:	0405                	addi	s0,s0,1
            while (i) {
    19c2:	0785                	addi	a5,a5,1
               *bf++ = *sn++;
    19c4:	fee40fa3          	sb	a4,-1(s0)
            while (i) {
    19c8:	fed41ae3          	bne	s0,a3,19bc <stbsp_vsprintfcb+0x730>
    19cc:	95b2                	add	a1,a1,a2
    19ce:	fcae                	sd	a1,120(sp)
            stbsp__chk_cb_buf(1);
    19d0:	000d0d63          	beqz	s10,19ea <stbsp_vsprintfcb+0x75e>
    19d4:	40a4063b          	subw	a2,s0,a0
    19d8:	00cad963          	bge	s5,a2,19ea <stbsp_vsprintfcb+0x75e>
    19dc:	65a2                	ld	a1,8(sp)
    19de:	00cb0b3b          	addw	s6,s6,a2
    19e2:	9d02                	jalr	s10
    19e4:	200509e3          	beqz	a0,23f6 <stbsp_vsprintfcb+0x116a>
    19e8:	842a                	mv	s0,a0
         while (tail[0]) {
    19ea:	07014f83          	lbu	t6,112(sp)
    19ee:	f80f9de3          	bnez	t6,1988 <stbsp_vsprintfcb+0x6fc>
    19f2:	834a                	mv	t1,s2
    19f4:	83ce                	mv	t2,s3
    19f6:	8e5e                	mv	t3,s7
    19f8:	89ea                	mv	s3,s10
    19fa:	892a                	mv	s2,a0
    19fc:	8d5a                	mv	s10,s6
         if (fl & STBSP__LEFTJUST)
    19fe:	001e7e13          	andi	t3,t3,1
    1a02:	000e0663          	beqz	t3,1a0e <stbsp_vsprintfcb+0x782>
            if (fw > 0) {
    1a06:	00605463          	blez	t1,1a0e <stbsp_vsprintfcb+0x782>
    1a0a:	0300106f          	j	2a3a <stbsp_vsprintfcb+0x17ae>
   for (;;) {
    1a0e:	6b86                	ld	s7,64(sp)
    1a10:	2c013a03          	ld	s4,704(sp)
    1a14:	2b813a83          	ld	s5,696(sp)
    1a18:	2b013b03          	ld	s6,688(sp)
      ++f;
    1a1c:	0485                	addi	s1,s1,1
   for (;;) {
    1a1e:	b0f1                	j	12ea <stbsp_vsprintfcb+0x5e>
               fl |= STBSP__METRIC_SUFFIX;
    1a20:	100e6e13          	ori	t3,t3,256
            continue;
    1a24:	0685                	addi	a3,a3,1
    1a26:	bad1                	j	13fa <stbsp_vsprintfcb+0x16e>
                  while (i) {
    1a28:	0e0580e3          	beqz	a1,2308 <stbsp_vsprintfcb+0x107c>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    1a2c:	00347793          	andi	a5,s0,3
    1a30:	e799                	bnez	a5,1a3e <stbsp_vsprintfcb+0x7b2>
    1a32:	0dd0006f          	j	230e <stbsp_vsprintfcb+0x1082>
    1a36:	00347793          	andi	a5,s0,3
    1a3a:	72078463          	beqz	a5,2162 <stbsp_vsprintfcb+0xed6>
                     *bf++ = '0';
    1a3e:	01d40023          	sb	t4,0(s0)
                     --i;
    1a42:	35fd                	addiw	a1,a1,-1
                     *bf++ = '0';
    1a44:	0405                	addi	s0,s0,1
                  while (i) {
    1a46:	f9e5                	bnez	a1,1a36 <stbsp_vsprintfcb+0x7aa>
               while (i) {
    1a48:	85a2                	mv	a1,s0
               stbsp__chk_cb_buf(1);
    1a4a:	cc0b19e3          	bnez	s6,171c <stbsp_vsprintfcb+0x490>
    1a4e:	842e                	mv	s0,a1
            while (pr > 0) {
    1a50:	c93042e3          	bgtz	s3,16d4 <stbsp_vsprintfcb+0x448>
    1a54:	b9cd                	j	1746 <stbsp_vsprintfcb+0x4ba>
            while (i) {
    1a56:	87ae                	mv	a5,a1
         while (n) {
    1a58:	dc041de3          	bnez	s0,1832 <stbsp_vsprintfcb+0x5a6>
    1a5c:	b5a5                	j	18c4 <stbsp_vsprintfcb+0x638>
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1a5e:	fd07871b          	addiw	a4,a5,-48
    1a62:	0ff77713          	zext.b	a4,a4
    1a66:	4625                	li	a2,9
         ++f;
    1a68:	0485                	addi	s1,s1,1
            pr = 0;
    1a6a:	4881                	li	a7,0
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1a6c:	46a5                	li	a3,9
    1a6e:	9ce669e3          	bltu	a2,a4,1440 <stbsp_vsprintfcb+0x1b4>
               pr = pr * 10 + f[0] - '0';
    1a72:	0028971b          	slliw	a4,a7,0x2
    1a76:	0117073b          	addw	a4,a4,a7
    1a7a:	0017171b          	slliw	a4,a4,0x1
               f++;
    1a7e:	0485                	addi	s1,s1,1
               pr = pr * 10 + f[0] - '0';
    1a80:	9f3d                	addw	a4,a4,a5
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1a82:	0004c783          	lbu	a5,0(s1)
               pr = pr * 10 + f[0] - '0';
    1a86:	fd07089b          	addiw	a7,a4,-48
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1a8a:	fd07871b          	addiw	a4,a5,-48
    1a8e:	0ff77713          	zext.b	a4,a4
    1a92:	fee6f0e3          	bgeu	a3,a4,1a72 <stbsp_vsprintfcb+0x7e6>
    1a96:	b26d                	j	1440 <stbsp_vsprintfcb+0x1b4>
                  fl |= STBSP__METRIC_1024;
    1a98:	8f5d                	or	a4,a4,a5
    1a9a:	00070e1b          	sext.w	t3,a4
    1a9e:	0685                	addi	a3,a3,1
    1aa0:	baa9                	j	13fa <stbsp_vsprintfcb+0x16e>
      *bf = 0;
    1aa2:	00040023          	sb	zero,0(s0)
    1aa6:	b209                	j	13a8 <stbsp_vsprintfcb+0x11c>
         if (f[0] == 'l') {
    1aa8:	0014c783          	lbu	a5,1(s1)
    1aac:	06c00713          	li	a4,108
         fl |= ((sizeof(long) == 8) ? STBSP__INTMAX : 0);
    1ab0:	020e6e13          	ori	t3,t3,32
         if (f[0] == 'l') {
    1ab4:	00e78c63          	beq	a5,a4,1acc <stbsp_vsprintfcb+0x840>
            ++f;
    1ab8:	0485                	addi	s1,s1,1
    1aba:	ba65                	j	1472 <stbsp_vsprintfcb+0x1e6>
         if (f[0] == 'h')
    1abc:	0014c783          	lbu	a5,1(s1)
    1ac0:	06800713          	li	a4,104
         fl |= STBSP__HALFWIDTH;
    1ac4:	200e6e13          	ori	t3,t3,512
         if (f[0] == 'h')
    1ac8:	fee798e3          	bne	a5,a4,1ab8 <stbsp_vsprintfcb+0x82c>
         if ((f[1] == '6') && (f[2] == '4')) {
    1acc:	0024c783          	lbu	a5,2(s1)
            ++f;
    1ad0:	0489                	addi	s1,s1,2
    1ad2:	b245                	j	1472 <stbsp_vsprintfcb+0x1e6>
         s = va_arg(va, char *);
    1ad4:	008b8713          	addi	a4,s7,8
    1ad8:	e0ba                	sd	a4,64(sp)
         if (fl & STBSP__INTMAX) {
    1ada:	020e7693          	andi	a3,t3,32
    1ade:	8772                	mv	a4,t3
    1ae0:	24069ee3          	bnez	a3,253c <stbsp_vsprintfcb+0x12b0>
            stbsp__int32 i = va_arg(va, stbsp__int32);
    1ae4:	000ba683          	lw	a3,0(s7)
            if ((f[0] != 'u') && (i < 0)) {
    1ae8:	07500613          	li	a2,117
            n64 = (stbsp__uint32)i;
    1aec:	02069f13          	slli	t5,a3,0x20
    1af0:	020f5f13          	srli	t5,t5,0x20
            if ((f[0] != 'u') && (i < 0)) {
    1af4:	00c78a63          	beq	a5,a2,1b08 <stbsp_vsprintfcb+0x87c>
    1af8:	0006d863          	bgez	a3,1b08 <stbsp_vsprintfcb+0x87c>
               fl |= STBSP__NEGATIVE;
    1afc:	08076713          	ori	a4,a4,128
               n64 = (stbsp__uint32)-i;
    1b00:	40d00f3b          	negw	t5,a3
               fl |= STBSP__NEGATIVE;
    1b04:	00070e1b          	sext.w	t3,a4
         if (fl & STBSP__METRIC_SUFFIX) {
    1b08:	100e7693          	andi	a3,t3,256
    1b0c:	5c0683e3          	beqz	a3,28d2 <stbsp_vsprintfcb+0x1646>
            if (n64 < 1024)
    1b10:	3ff00793          	li	a5,1023
    1b14:	01e7e463          	bltu	a5,t5,1b1c <stbsp_vsprintfcb+0x890>
    1b18:	0ea0106f          	j	2c02 <stbsp_vsprintfcb+0x1976>
            else if (pr == -1)
    1b1c:	57fd                	li	a5,-1
    1b1e:	30f887e3          	beq	a7,a5,262c <stbsp_vsprintfcb+0x13a0>
            fv = (double)(stbsp__int64)n64;
    1b22:	d22f7553          	fcvt.d.l	fa0,t5
            if (fl & STBSP__METRIC_1024)
    1b26:	034e1793          	slli	a5,t3,0x34
    1b2a:	0007c463          	bltz	a5,1b32 <stbsp_vsprintfcb+0x8a6>
    1b2e:	2300106f          	j	2d5e <stbsp_vsprintfcb+0x1ad2>
               divisor = 1024.0;
    1b32:	00004797          	auipc	a5,0x4
    1b36:	c767b787          	fld	fa5,-906(a5) # 57a8 <STDIN_FD+0x20>
               if ((fv < divisor) && (fv > -divisor))
    1b3a:	22f79753          	fneg.d	fa4,fa5
               fl += 0x1000000;
    1b3e:	010006b7          	lui	a3,0x1000
            while (fl < 0x4000000) {
    1b42:	04000737          	lui	a4,0x4000
               if ((fv < divisor) && (fv > -divisor))
    1b46:	a2f517d3          	flt.d	a5,fa0,fa5
    1b4a:	c789                	beqz	a5,1b54 <stbsp_vsprintfcb+0x8c8>
    1b4c:	a2a717d3          	flt.d	a5,fa4,fa0
    1b50:	3e079863          	bnez	a5,1f40 <stbsp_vsprintfcb+0xcb4>
               fl += 0x1000000;
    1b54:	01c68e3b          	addw	t3,a3,t3
               fv /= divisor;
    1b58:	1af57553          	fdiv.d	fa0,fa0,fa5
            while (fl < 0x4000000) {
    1b5c:	feee65e3          	bltu	t3,a4,1b46 <stbsp_vsprintfcb+0x8ba>
    1b60:	a6c5                	j	1f40 <stbsp_vsprintfcb+0xcb4>
         h = (f[0] == 'X') ? hexu : hex;
    1b62:	05800693          	li	a3,88
         if (fl & STBSP__INTMAX) {
    1b66:	020e7713          	andi	a4,t3,32
         h = (f[0] == 'X') ? hexu : hex;
    1b6a:	00005817          	auipc	a6,0x5
    1b6e:	e3e80813          	addi	a6,a6,-450 # 69a8 <hex.0>
    1b72:	00d79663          	bne	a5,a3,1b7e <stbsp_vsprintfcb+0x8f2>
    1b76:	00005817          	auipc	a6,0x5
    1b7a:	e1a80813          	addi	a6,a6,-486 # 6990 <hexu.1>
         l = (4 << 4) | (4 << 8);
    1b7e:	44000793          	li	a5,1088
    1b82:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__LEADING_0X) {
    1b84:	008e7793          	andi	a5,t3,8
    1b88:	7a079263          	bnez	a5,232c <stbsp_vsprintfcb+0x10a0>
         lead[0] = 0;
    1b8c:	06010423          	sb	zero,104(sp)
         s = va_arg(va, char *);
    1b90:	008b8793          	addi	a5,s7,8
    1b94:	e0be                	sd	a5,64(sp)
         if (fl & STBSP__INTMAX)
    1b96:	72070b63          	beqz	a4,22cc <stbsp_vsprintfcb+0x1040>
            n64 = va_arg(va, stbsp__uint64);
    1b9a:	000bb683          	ld	a3,0(s7)
         dp = 0;
    1b9e:	d282                	sw	zero,100(sp)
         tail[0] = 0;
    1ba0:	06010823          	sb	zero,112(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    1ba4:	001e7513          	andi	a0,t3,1
         if (n64 == 0) {
    1ba8:	380694e3          	bnez	a3,2730 <stbsp_vsprintfcb+0x14a4>
            lead[0] = 0;
    1bac:	06010423          	sb	zero,104(sp)
            if (pr == 0) {
    1bb0:	78089a63          	bnez	a7,2344 <stbsp_vsprintfcb+0x10b8>
         if (fw < (stbsp__int32)n)
    1bb4:	fffb4313          	not	t1,s6
    1bb8:	43f35313          	srai	t1,t1,0x3f
               l = 0;
    1bbc:	d082                	sw	zero,96(sp)
         if (fw < (stbsp__int32)n)
    1bbe:	01637333          	and	t1,t1,s6
               goto scopy;
    1bc2:	4701                	li	a4,0
    1bc4:	4f81                	li	t6,0
    1bc6:	4a01                	li	s4,0
               cs = 0;
    1bc8:	4281                	li	t0,0
         s = num + STBSP__NUMSZ;
    1bca:	28010a93          	addi	s5,sp,640
         if ((fl & STBSP__LEFTJUST) == 0) {
    1bce:	9c0506e3          	beqz	a0,159a <stbsp_vsprintfcb+0x30e>
         if (fw + pr) {
    1bd2:	00e307bb          	addw	a5,t1,a4
    1bd6:	9c079fe3          	bnez	a5,15b4 <stbsp_vsprintfcb+0x328>
    1bda:	06910793          	addi	a5,sp,105
    1bde:	b661                	j	1766 <stbsp_vsprintfcb+0x4da>
         h = (f[0] == 'E') ? hexu : hex;
    1be0:	04500713          	li	a4,69
    1be4:	00005317          	auipc	t1,0x5
    1be8:	dc430313          	addi	t1,t1,-572 # 69a8 <hex.0>
    1bec:	1ce78ae3          	beq	a5,a4,25c0 <stbsp_vsprintfcb+0x1334>
         fv = va_arg(va, double);
    1bf0:	008b8713          	addi	a4,s7,8
         if (pr == -1)
    1bf4:	57fd                	li	a5,-1
         fv = va_arg(va, double);
    1bf6:	e0ba                	sd	a4,64(sp)
    1bf8:	000bb507          	fld	fa0,0(s7)
         if (pr == -1)
    1bfc:	1af88ce3          	beq	a7,a5,25b4 <stbsp_vsprintfcb+0x1328>
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr | 0x80000000))
    1c00:	80000737          	lui	a4,0x80000
    1c04:	00e8e733          	or	a4,a7,a4
    1c08:	2701                	sext.w	a4,a4
    1c0a:	10d4                	addi	a3,sp,100
    1c0c:	0110                	addi	a2,sp,128
    1c0e:	108c                	addi	a1,sp,96
    1c10:	18a8                	addi	a0,sp,120
    1c12:	f41e                	sd	t2,40(sp)
    1c14:	f01a                	sd	t1,32(sp)
    1c16:	ec72                	sd	t3,24(sp)
    1c18:	e846                	sd	a7,16(sp)
    1c1a:	d8efe0ef          	jal	1a8 <stbsp__real_to_str>
    1c1e:	68c2                	ld	a7,16(sp)
    1c20:	6e62                	ld	t3,24(sp)
    1c22:	7302                	ld	t1,32(sp)
    1c24:	73a2                	ld	t2,40(sp)
         if (dp == STBSP__SPECIAL) {
    1c26:	5796                	lw	a5,100(sp)
            s = (char *)sn;
    1c28:	7ae6                	ld	s5,120(sp)
         if ((l - 1) > (stbsp__uint32)pr)
    1c2a:	5686                	lw	a3,96(sp)
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr | 0x80000000))
    1c2c:	3c0511e3          	bnez	a0,27ee <stbsp_vsprintfcb+0x1562>
         tail[0] = 0;
    1c30:	06010823          	sb	zero,112(sp)
   sign[0] = 0;
    1c34:	06010423          	sb	zero,104(sp)
   } else if (fl & STBSP__LEADINGSPACE) {
    1c38:	004e7713          	andi	a4,t3,4
    1c3c:	6a070ee3          	beqz	a4,2af8 <stbsp_vsprintfcb+0x186c>
      sign[0] = 1;
    1c40:	6709                	lui	a4,0x2
    1c42:	0705                	addi	a4,a4,1 # 2001 <stbsp_vsprintfcb+0xd75>
    1c44:	06e11423          	sh	a4,104(sp)
         if (dp == STBSP__SPECIAL) {
    1c48:	671d                	lui	a4,0x7
    1c4a:	1ee794e3          	bne	a5,a4,2632 <stbsp_vsprintfcb+0x13a6>
         if (pr < (stbsp__int32)l)
    1c4e:	0006879b          	sext.w	a5,a3
         n = pr + lead[0] + tail[0] + tz;
    1c52:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    1c56:	fff7c793          	not	a5,a5
         n = pr + lead[0] + tail[0] + tz;
    1c5a:	07014f83          	lbu	t6,112(sp)
         if (pr < (stbsp__int32)l)
    1c5e:	97fd                	srai	a5,a5,0x3f
    1c60:	8ff5                	and	a5,a5,a3
         n = pr + lead[0] + tail[0] + tz;
    1c62:	00fa073b          	addw	a4,s4,a5
    1c66:	01f7063b          	addw	a2,a4,t6
    1c6a:	8732                	mv	a4,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    1c6c:	001e7513          	andi	a0,t3,1
         if (pr < (stbsp__int32)l)
    1c70:	2781                	sext.w	a5,a5
         if (fw < (stbsp__int32)n)
    1c72:	835a                	mv	t1,s6
    1c74:	00cb5363          	bge	s6,a2,1c7a <stbsp_vsprintfcb+0x9ee>
    1c78:	8332                	mv	t1,a2
         fw -= n;
    1c7a:	40e3033b          	subw	t1,t1,a4
            cs = 0;
    1c7e:	4281                	li	t0,0
         pr -= l;
    1c80:	40d7873b          	subw	a4,a5,a3
      tz = 0;
    1c84:	4881                	li	a7,0
            goto scopy;
    1c86:	b7a1                	j	1bce <stbsp_vsprintfcb+0x942>
         h = (f[0] == 'G') ? hexu : hex;
    1c88:	04700713          	li	a4,71
    1c8c:	00005317          	auipc	t1,0x5
    1c90:	d1c30313          	addi	t1,t1,-740 # 69a8 <hex.0>
    1c94:	14e783e3          	beq	a5,a4,25da <stbsp_vsprintfcb+0x134e>
         fv = va_arg(va, double);
    1c98:	008b8713          	addi	a4,s7,8
         if (pr == -1)
    1c9c:	57fd                	li	a5,-1
         fv = va_arg(va, double);
    1c9e:	e0ba                	sd	a4,64(sp)
    1ca0:	000bb507          	fld	fa0,0(s7)
         if (pr == -1)
    1ca4:	12f884e3          	beq	a7,a5,25cc <stbsp_vsprintfcb+0x1340>
         else if (pr == 0)
    1ca8:	6e0887e3          	beqz	a7,2b96 <stbsp_vsprintfcb+0x190a>
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, (pr - 1) | 0x80000000))
    1cac:	fff8871b          	addiw	a4,a7,-1
    1cb0:	800007b7          	lui	a5,0x80000
    1cb4:	8f5d                	or	a4,a4,a5
    1cb6:	2701                	sext.w	a4,a4
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    1cb8:	00088a9b          	sext.w	s5,a7
    1cbc:	8a46                	mv	s4,a7
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, (pr - 1) | 0x80000000))
    1cbe:	10d4                	addi	a3,sp,100
    1cc0:	0110                	addi	a2,sp,128
    1cc2:	108c                	addi	a1,sp,96
    1cc4:	18a8                	addi	a0,sp,120
    1cc6:	f01e                	sd	t2,32(sp)
    1cc8:	ec1a                	sd	t1,24(sp)
    1cca:	e872                	sd	t3,16(sp)
    1ccc:	cdcfe0ef          	jal	1a8 <stbsp__real_to_str>
    1cd0:	6e42                	ld	t3,16(sp)
    1cd2:	6362                	ld	t1,24(sp)
    1cd4:	7382                	ld	t2,32(sp)
    1cd6:	4281                	li	t0,0
    1cd8:	c509                	beqz	a0,1ce2 <stbsp_vsprintfcb+0xa56>
            fl |= STBSP__NEGATIVE;
    1cda:	080e6e13          	ori	t3,t3,128
    1cde:	08000293          	li	t0,128
         if (l > (stbsp__uint32)pr)
    1ce2:	5806                	lw	a6,96(sp)
    1ce4:	010af463          	bgeu	s5,a6,1cec <stbsp_vsprintfcb+0xa60>
            l = pr;
    1ce8:	d0d6                	sw	s5,96(sp)
    1cea:	8856                	mv	a6,s5
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    1cec:	4705                	li	a4,1
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    1cee:	5796                	lw	a5,100(sp)
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    1cf0:	01076463          	bltu	a4,a6,1cf8 <stbsp_vsprintfcb+0xa6c>
    1cf4:	1800106f          	j	2e74 <stbsp_vsprintfcb+0x1be8>
    1cf8:	7be6                	ld	s7,120(sp)
    1cfa:	fff8071b          	addiw	a4,a6,-1
    1cfe:	1702                	slli	a4,a4,0x20
    1d00:	9301                	srli	a4,a4,0x20
    1d02:	001a0e9b          	addiw	t4,s4,1
    1d06:	75e2                	ld	a1,56(sp)
    1d08:	8ade                	mv	s5,s7
    1d0a:	975e                	add	a4,a4,s7
    1d0c:	410e8ebb          	subw	t4,t4,a6
    1d10:	88d2                	mv	a7,s4
    1d12:	86c2                	mv	a3,a6
    1d14:	4f01                	li	t5,0
    1d16:	03000f93          	li	t6,48
    1d1a:	e842                	sd	a6,16(sp)
    1d1c:	a809                	j	1d2e <stbsp_vsprintfcb+0xaa2>
            --pr;
    1d1e:	38fd                	addiw	a7,a7,-1
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    1d20:	211e80e3          	beq	t4,a7,2720 <stbsp_vsprintfcb+0x1494>
    1d24:	177d                	addi	a4,a4,-1 # 6fff <_stdout+0x21f>
    1d26:	4f05                	li	t5,1
    1d28:	1e088ce3          	beqz	a7,2720 <stbsp_vsprintfcb+0x1494>
            --l;
    1d2c:	85b6                	mv	a1,a3
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    1d2e:	00074803          	lbu	a6,0(a4)
    1d32:	fff6861b          	addiw	a2,a3,-1 # ffffff <_ZSt4cerr+0xff8847>
    1d36:	0006851b          	sext.w	a0,a3
    1d3a:	2581                	sext.w	a1,a1
    1d3c:	0006069b          	sext.w	a3,a2
    1d40:	fdf80fe3          	beq	a6,t6,1d1e <stbsp_vsprintfcb+0xa92>
    1d44:	6842                	ld	a6,16(sp)
    1d46:	fc2e                	sd	a1,56(sp)
    1d48:	86c2                	mv	a3,a6
    1d4a:	000f0463          	beqz	t5,1d52 <stbsp_vsprintfcb+0xac6>
    1d4e:	d0ae                	sw	a1,96(sp)
    1d50:	86ae                	mv	a3,a1
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    1d52:	5775                	li	a4,-3
    1d54:	08e7cee3          	blt	a5,a4,25f0 <stbsp_vsprintfcb+0x1364>
    1d58:	08fa4be3          	blt	s4,a5,25ee <stbsp_vsprintfcb+0x1362>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    1d5c:	0005071b          	sext.w	a4,a0
         if (dp > 0) {
    1d60:	7ef057e3          	blez	a5,2d4e <stbsp_vsprintfcb+0x1ac2>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    1d64:	4881                	li	a7,0
    1d66:	00e7d463          	bge	a5,a4,1d6e <stbsp_vsprintfcb+0xae2>
    1d6a:	40f508bb          	subw	a7,a0,a5
         tail[0] = 0;
    1d6e:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    1d72:	20029463          	bnez	t0,1f7a <stbsp_vsprintfcb+0xcee>
   } else if (fl & STBSP__LEADINGSPACE) {
    1d76:	004e7713          	andi	a4,t3,4
    1d7a:	000715e3          	bnez	a4,2584 <stbsp_vsprintfcb+0x12f8>
   } else if (fl & STBSP__LEADINGPLUS) {
    1d7e:	002e7713          	andi	a4,t3,2
    1d82:	660719e3          	bnez	a4,2bf4 <stbsp_vsprintfcb+0x1968>
   sign[0] = 0;
    1d86:	06010423          	sb	zero,104(sp)
    1d8a:	aaed                	j	1f84 <stbsp_vsprintfcb+0xcf8>
         h = (f[0] == 'A') ? hexu : hex;
    1d8c:	04100713          	li	a4,65
    1d90:	00005597          	auipc	a1,0x5
    1d94:	c1858593          	addi	a1,a1,-1000 # 69a8 <hex.0>
    1d98:	00e783e3          	beq	a5,a4,259e <stbsp_vsprintfcb+0x1312>
         fv = va_arg(va, double);
    1d9c:	008b8693          	addi	a3,s7,8
         if (pr == -1)
    1da0:	577d                	li	a4,-1
         fv = va_arg(va, double);
    1da2:	e0b6                	sd	a3,64(sp)
    1da4:	000bb783          	ld	a5,0(s7)
         if (pr == -1)
    1da8:	7ee88963          	beq	a7,a4,259a <stbsp_vsprintfcb+0x130e>
   d = value;

   STBSP__COPYFP(b, d);

   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    1dac:	4347d613          	srai	a2,a5,0x34
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    1db0:	00c79513          	slli	a0,a5,0xc
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    1db4:	7ff67613          	andi	a2,a2,2047
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    1db8:	8131                	srli	a0,a0,0xc
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    1dba:	c016061b          	addiw	a2,a2,-1023
         if (stbsp__real_to_parts((stbsp__int64 *)&n64, &dp, fv))
    1dbe:	7a07c863          	bltz	a5,256e <stbsp_vsprintfcb+0x12e2>
   } else if (fl & STBSP__LEADINGSPACE) {
    1dc2:	004e7793          	andi	a5,t3,4
    1dc6:	60078ee3          	beqz	a5,2be2 <stbsp_vsprintfcb+0x1956>
    1dca:	6789                	lui	a5,0x2
    1dcc:	2785                	addiw	a5,a5,1 # 2001 <stbsp_vsprintfcb+0xd75>
      sign[0] = 1;
    1dce:	06f11423          	sh	a5,104(sp)
    1dd2:	468d                	li	a3,3
    1dd4:	4a0d                	li	s4,3
    1dd6:	4809                	li	a6,2
            n64 |= (((stbsp__uint64)1) << 52);
    1dd8:	4705                	li	a4,1
    1dda:	1752                	slli	a4,a4,0x34
         if (dp == -1023)
    1ddc:	c0100793          	li	a5,-1023
            n64 |= (((stbsp__uint64)1) << 52);
    1de0:	8f49                	or	a4,a4,a0
         if (dp == -1023)
    1de2:	5cf600e3          	beq	a2,a5,2ba2 <stbsp_vsprintfcb+0x1916>
         if (pr < 15)
    1de6:	4539                	li	a0,14
         n64 <<= (64 - 56);
    1de8:	00871793          	slli	a5,a4,0x8
         if (pr < 15)
    1dec:	251546e3          	blt	a0,a7,2838 <stbsp_vsprintfcb+0x15ac>
            n64 += ((((stbsp__uint64)8) << 56) >> (pr * 4));
    1df0:	4705                	li	a4,1
    1df2:	0028951b          	slliw	a0,a7,0x2
    1df6:	176e                	slli	a4,a4,0x3b
    1df8:	00a75733          	srl	a4,a4,a0
    1dfc:	973e                	add	a4,a4,a5
         *s++ = h[(n64 >> 60) & 15];
    1dfe:	03c75793          	srli	a5,a4,0x3c
    1e02:	97ae                	add	a5,a5,a1
    1e04:	0007c503          	lbu	a0,0(a5)
         lead[1 + lead[0]] = '0';
    1e08:	22080793          	addi	a5,a6,544
    1e0c:	06010813          	addi	a6,sp,96
    1e10:	97c2                	add	a5,a5,a6
    1e12:	03000813          	li	a6,48
    1e16:	df078423          	sb	a6,-536(a5)
         lead[2 + lead[0]] = 'x';
    1e1a:	22068793          	addi	a5,a3,544
    1e1e:	1094                	addi	a3,sp,96
    1e20:	96be                	add	a3,a3,a5
    1e22:	07800793          	li	a5,120
    1e26:	def68423          	sb	a5,-536(a3)
         lead[0] += 2;
    1e2a:	07410423          	sb	s4,104(sp)
         *s++ = h[(n64 >> 60) & 15];
    1e2e:	0ca10023          	sb	a0,192(sp)
         if (pr)
    1e32:	740893e3          	bnez	a7,2d78 <stbsp_vsprintfcb+0x1aec>
         sn = s;
    1e36:	0c110793          	addi	a5,sp,193
    1e3a:	fcbe                	sd	a5,120(sp)
    1e3c:	4701                	li	a4,0
    1e3e:	4501                	li	a0,0
    1e40:	4305                	li	t1,1
    1e42:	4685                	li	a3,1
         tail[1] = h[17];
    1e44:	0115c583          	lbu	a1,17(a1)
            tail[2] = '+';
    1e48:	02b00793          	li	a5,43
         tail[1] = h[17];
    1e4c:	06b108a3          	sb	a1,113(sp)
         if (dp < 0) {
    1e50:	00065663          	bgez	a2,1e5c <stbsp_vsprintfcb+0xbd0>
            dp = -dp;
    1e54:	40c0063b          	negw	a2,a2
            tail[2] = '-';
    1e58:	02d00793          	li	a5,45
            tail[n] = '0' + dp % 10;
    1e5c:	4829                	li	a6,10
    1e5e:	030665bb          	remw	a1,a2,a6
    1e62:	06f10923          	sb	a5,114(sp)
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    1e66:	3e700e93          	li	t4,999
            tail[n] = '0' + dp % 10;
    1e6a:	0305859b          	addiw	a1,a1,48
    1e6e:	0ff5f593          	zext.b	a1,a1
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    1e72:	18cec3e3          	blt	t4,a2,27f8 <stbsp_vsprintfcb+0x156c>
    1e76:	06300e93          	li	t4,99
    1e7a:	54cec1e3          	blt	t4,a2,2bbc <stbsp_vsprintfcb+0x1930>
    1e7e:	4ea5                	li	t4,9
    1e80:	72ced6e3          	bge	t4,a2,2dac <stbsp_vsprintfcb+0x1b20>
            dp /= 10;
    1e84:	030647bb          	divw	a5,a2,a6
         tail[0] = (char)n;
    1e88:	4611                	li	a2,4
    1e8a:	06c10823          	sb	a2,112(sp)
            tail[n] = '0' + dp % 10;
    1e8e:	06b10a23          	sb	a1,116(sp)
    1e92:	4811                	li	a6,4
    1e94:	4f91                	li	t6,4
    1e96:	0307879b          	addiw	a5,a5,48
    1e9a:	06f109a3          	sb	a5,115(sp)
         n = pr + lead[0] + tail[0] + tz;
    1e9e:	006a07bb          	addw	a5,s4,t1
    1ea2:	010787bb          	addw	a5,a5,a6
    1ea6:	0117863b          	addw	a2,a5,a7
         dp = (int)(s - sn);
    1eaa:	d2aa                	sw	a0,100(sp)
         l = (int)(s - (num + 64));
    1eac:	d0b6                	sw	a3,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    1eae:	87b2                	mv	a5,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    1eb0:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    1eb4:	835a                	mv	t1,s6
    1eb6:	00cb5363          	bge	s6,a2,1ebc <stbsp_vsprintfcb+0xc30>
    1eba:	8332                	mv	t1,a2
         cs = 1 + (3 << 24);
    1ebc:	030002b7          	lui	t0,0x3000
         fw -= n;
    1ec0:	40f3033b          	subw	t1,t1,a5
         cs = 1 + (3 << 24);
    1ec4:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff8849>
         s = num + 64;
    1ec6:	0c010a93          	addi	s5,sp,192
         goto scopy;
    1eca:	b311                	j	1bce <stbsp_vsprintfcb+0x942>
         h = (f[0] == 'B') ? hexu : hex;
    1ecc:	04200713          	li	a4,66
    1ed0:	00005817          	auipc	a6,0x5
    1ed4:	ad880813          	addi	a6,a6,-1320 # 69a8 <hex.0>
    1ed8:	6ce78963          	beq	a5,a4,25aa <stbsp_vsprintfcb+0x131e>
         if (fl & STBSP__LEADING_0X) {
    1edc:	008e7793          	andi	a5,t3,8
    1ee0:	66079e63          	bnez	a5,255c <stbsp_vsprintfcb+0x12d0>
         lead[0] = 0;
    1ee4:	06010423          	sb	zero,104(sp)
         l = (8 << 4) | (1 << 8);
    1ee8:	18000793          	li	a5,384
    1eec:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__INTMAX) {
    1eee:	020e7713          	andi	a4,t3,32
         goto radixnum;
    1ef2:	b979                	j	1b90 <stbsp_vsprintfcb+0x904>
         *s = (char)va_arg(va, int);
    1ef4:	000ba783          	lw	a5,0(s7)
         l = 1;
    1ef8:	4705                	li	a4,1
    1efa:	d0ba                	sw	a4,96(sp)
         *s = (char)va_arg(va, int);
    1efc:	26f10fa3          	sb	a5,639(sp)
    1f00:	008b8793          	addi	a5,s7,8
         lead[0] = 0;
    1f04:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    1f08:	06010823          	sb	zero,112(sp)
         dp = 0;
    1f0c:	d282                	sw	zero,100(sp)
         *s = (char)va_arg(va, int);
    1f0e:	e0be                	sd	a5,64(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    1f10:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    1f14:	835a                	mv	t1,s6
    1f16:	69605063          	blez	s6,2596 <stbsp_vsprintfcb+0x130a>
         fw -= n;
    1f1a:	337d                	addiw	t1,t1,-1
         goto scopy;
    1f1c:	4701                	li	a4,0
    1f1e:	4f81                	li	t6,0
    1f20:	4685                	li	a3,1
    1f22:	4a01                	li	s4,0
         cs = 0;
    1f24:	4281                	li	t0,0
         s = num + STBSP__NUMSZ - 1;
    1f26:	27f10a93          	addi	s5,sp,639
      tz = 0;
    1f2a:	4881                	li	a7,0
         goto scopy;
    1f2c:	b14d                	j	1bce <stbsp_vsprintfcb+0x942>
         fv = va_arg(va, double);
    1f2e:	008b8713          	addi	a4,s7,8
         if (fl & STBSP__METRIC_SUFFIX) {
    1f32:	100e7793          	andi	a5,t3,256
         fv = va_arg(va, double);
    1f36:	e0ba                	sd	a4,64(sp)
    1f38:	000bb507          	fld	fa0,0(s7)
         if (fl & STBSP__METRIC_SUFFIX) {
    1f3c:	be0795e3          	bnez	a5,1b26 <stbsp_vsprintfcb+0x89a>
         if (pr == -1)
    1f40:	57fd                	li	a5,-1
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    1f42:	0008871b          	sext.w	a4,a7
         if (pr == -1)
    1f46:	00f89463          	bne	a7,a5,1f4e <stbsp_vsprintfcb+0xcc2>
    1f4a:	4719                	li	a4,6
            pr = 6; // default is 6
    1f4c:	4899                	li	a7,6
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    1f4e:	10d4                	addi	a3,sp,100
    1f50:	0110                	addi	a2,sp,128
    1f52:	108c                	addi	a1,sp,96
    1f54:	18a8                	addi	a0,sp,120
    1f56:	f01e                	sd	t2,32(sp)
    1f58:	ec72                	sd	t3,24(sp)
    1f5a:	e846                	sd	a7,16(sp)
    1f5c:	a4cfe0ef          	jal	1a8 <stbsp__real_to_str>
    1f60:	6e62                	ld	t3,24(sp)
    1f62:	68c2                	ld	a7,16(sp)
    1f64:	7382                	ld	t2,32(sp)
         if (dp == STBSP__SPECIAL) {
    1f66:	5796                	lw	a5,100(sp)
            if ((stbsp__int32)(l + n) > pr)
    1f68:	5686                	lw	a3,96(sp)
   if (fl & STBSP__NEGATIVE) {
    1f6a:	080e7293          	andi	t0,t3,128
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    1f6e:	e00500e3          	beqz	a0,1d6e <stbsp_vsprintfcb+0xae2>
            fl |= STBSP__NEGATIVE;
    1f72:	080e6e13          	ori	t3,t3,128
         tail[0] = 0;
    1f76:	06010823          	sb	zero,112(sp)
      sign[0] = 1;
    1f7a:	670d                	lui	a4,0x3
    1f7c:	d0170713          	addi	a4,a4,-767 # 2d01 <stbsp_vsprintfcb+0x1a75>
    1f80:	06e11423          	sh	a4,104(sp)
         if (dp == STBSP__SPECIAL) {
    1f84:	671d                	lui	a4,0x7
    1f86:	7ce78963          	beq	a5,a4,2758 <stbsp_vsprintfcb+0x14cc>
         if (dp <= 0) {
    1f8a:	46f05fe3          	blez	a5,2c08 <stbsp_vsprintfcb+0x197c>
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((600 - (stbsp__uint32)dp) % 3) : 0;
    1f8e:	040e7313          	andi	t1,t3,64
    1f92:	00078e9b          	sext.w	t4,a5
    1f96:	4581                	li	a1,0
    1f98:	00030963          	beqz	t1,1faa <stbsp_vsprintfcb+0xd1e>
    1f9c:	25800593          	li	a1,600
    1fa0:	41d585bb          	subw	a1,a1,t4
    1fa4:	470d                	li	a4,3
    1fa6:	02e5f5bb          	remuw	a1,a1,a4
                     *s++ = stbsp__comma;
    1faa:	00005a17          	auipc	s4,0x5
    1fae:	916a0a13          	addi	s4,s4,-1770 # 68c0 <stbsp__digitpair>
            s = (char *)sn;
    1fb2:	7f66                	ld	t5,120(sp)
                     *s++ = stbsp__comma;
    1fb4:	0cda4283          	lbu	t0,205(s4)
         s = num + 64;
    1fb8:	0c010a93          	addi	s5,sp,192
            if ((stbsp__uint32)dp >= l) {
    1fbc:	44defb63          	bgeu	t4,a3,2412 <stbsp_vsprintfcb+0x1186>
               n = 0;
    1fc0:	4501                	li	a0,0
         s = num + 64;
    1fc2:	8756                	mv	a4,s5
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    1fc4:	4b91                	li	s7,4
    1fc6:	a015                	j	1fea <stbsp_vsprintfcb+0xd5e>
    1fc8:	8642                	mv	a2,a6
    1fca:	883a                	mv	a6,a4
    1fcc:	8732                	mv	a4,a2
                     *s++ = sn[n];
    1fce:	02051613          	slli	a2,a0,0x20
    1fd2:	9201                	srli	a2,a2,0x20
    1fd4:	967a                	add	a2,a2,t5
    1fd6:	00064f83          	lbu	t6,0(a2)
                     ++n;
    1fda:	0015061b          	addiw	a2,a0,1
    1fde:	0006051b          	sext.w	a0,a2
                     *s++ = sn[n];
    1fe2:	fff70fa3          	sb	t6,-1(a4) # 6fff <_stdout+0x21f>
                     if (n >= (stbsp__uint32)dp)
    1fe6:	7bd57563          	bgeu	a0,t4,2790 <stbsp_vsprintfcb+0x1504>
                     *s++ = stbsp__comma;
    1fea:	00170813          	addi	a6,a4,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    1fee:	fc030de3          	beqz	t1,1fc8 <stbsp_vsprintfcb+0xd3c>
    1ff2:	2585                	addiw	a1,a1,1
    1ff4:	fd759ae3          	bne	a1,s7,1fc8 <stbsp_vsprintfcb+0xd3c>
                     *s++ = stbsp__comma;
    1ff8:	fe580fa3          	sb	t0,-1(a6)
    1ffc:	0709                	addi	a4,a4,2
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    1ffe:	4585                	li	a1,1
    2000:	b7f9                	j	1fce <stbsp_vsprintfcb+0xd42>
         *d = tlen + (int)(bf - buf);
    2002:	000bb703          	ld	a4,0(s7)
    2006:	412407b3          	sub	a5,s0,s2
    200a:	01a787bb          	addw	a5,a5,s10
         int *d = va_arg(va, int *);
    200e:	008b8693          	addi	a3,s7,8
    2012:	e0b6                	sd	a3,64(sp)
         *d = tlen + (int)(bf - buf);
    2014:	c31c                	sw	a5,0(a4)
      } break;
    2016:	bae5                	j	1a0e <stbsp_vsprintfcb+0x782>
         if (fl & STBSP__LEADING_0X) {
    2018:	008e7793          	andi	a5,t3,8
    201c:	50079b63          	bnez	a5,2532 <stbsp_vsprintfcb+0x12a6>
         lead[0] = 0;
    2020:	06010423          	sb	zero,104(sp)
         l = (3 << 4) | (3 << 8);
    2024:	33000793          	li	a5,816
    2028:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__INTMAX) {
    202a:	020e7713          	andi	a4,t3,32
         h = hexu;
    202e:	00005817          	auipc	a6,0x5
    2032:	96280813          	addi	a6,a6,-1694 # 6990 <hexu.1>
         goto radixnum;
    2036:	bea9                	j	1b90 <stbsp_vsprintfcb+0x904>
         fl &= ~STBSP__LEADINGZERO; // 'p' only prints the pointer with zeros
    2038:	fefe7e13          	andi	t3,t3,-17
    203c:	020e6e13          	ori	t3,t3,32
    2040:	02000713          	li	a4,32
         pr = sizeof(void *) * 2;
    2044:	48c1                	li	a7,16
         h = (f[0] == 'X') ? hexu : hex;
    2046:	00005817          	auipc	a6,0x5
    204a:	96280813          	addi	a6,a6,-1694 # 69a8 <hex.0>
    204e:	be05                	j	1b7e <stbsp_vsprintfcb+0x8f2>
         s = va_arg(va, char *);
    2050:	000bba83          	ld	s5,0(s7)
    2054:	008b8793          	addi	a5,s7,8
    2058:	e0be                	sd	a5,64(sp)
         if (s == 0)
    205a:	360a8ee3          	beqz	s5,2bd6 <stbsp_vsprintfcb+0x194a>
      if (((stbsp__uintptr)sn & 3) == 0)
    205e:	003af793          	andi	a5,s5,3
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    2062:	5208c663          	bltz	a7,258e <stbsp_vsprintfcb+0x1302>
    2066:	0008869b          	sext.w	a3,a7
      if (((stbsp__uintptr)sn & 3) == 0)
    206a:	2a0782e3          	beqz	a5,2b0e <stbsp_vsprintfcb+0x1882>
      if (!limit || *sn == 0)
    206e:	5a068b63          	beqz	a3,2624 <stbsp_vsprintfcb+0x1398>
      if (((stbsp__uintptr)sn & 3) == 0)
    2072:	87d6                	mv	a5,s5
    2074:	a801                	j	2084 <stbsp_vsprintfcb+0xdf8>
      ++sn;
    2076:	0785                	addi	a5,a5,1
      if (((stbsp__uintptr)sn & 3) == 0)
    2078:	0037f713          	andi	a4,a5,3
      --limit;
    207c:	36fd                	addiw	a3,a3,-1
      if (((stbsp__uintptr)sn & 3) == 0)
    207e:	280709e3          	beqz	a4,2b10 <stbsp_vsprintfcb+0x1884>
      if (!limit || *sn == 0)
    2082:	c681                	beqz	a3,208a <stbsp_vsprintfcb+0xdfe>
    2084:	0007c703          	lbu	a4,0(a5)
    2088:	f77d                	bnez	a4,2076 <stbsp_vsprintfcb+0xdea>
         return (stbsp__uint32)(sn - s);
    208a:	415787b3          	sub	a5,a5,s5
    208e:	0007869b          	sext.w	a3,a5
         if (pr < (stbsp__int32)l)
    2092:	fff6c713          	not	a4,a3
    2096:	977d                	srai	a4,a4,0x3f
    2098:	8f7d                	and	a4,a4,a5
    209a:	0007079b          	sext.w	a5,a4
         n = pr + lead[0] + tail[0] + tz;
    209e:	863e                	mv	a2,a5
         pr -= l;
    20a0:	9f15                	subw	a4,a4,a3
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    20a2:	d0b6                	sw	a3,96(sp)
         lead[0] = 0;
    20a4:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    20a8:	06010823          	sb	zero,112(sp)
         dp = 0;
    20ac:	d282                	sw	zero,100(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    20ae:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    20b2:	835a                	mv	t1,s6
    20b4:	00fb5363          	bge	s6,a5,20ba <stbsp_vsprintfcb+0xe2e>
    20b8:	833e                	mv	t1,a5
         fw -= n;
    20ba:	40c3033b          	subw	t1,t1,a2
         goto scopy;
    20be:	4f81                	li	t6,0
    20c0:	4a01                	li	s4,0
         cs = 0;
    20c2:	4281                	li	t0,0
      tz = 0;
    20c4:	4881                	li	a7,0
         goto scopy;
    20c6:	b621                	j	1bce <stbsp_vsprintfcb+0x942>
                     *bf++ = stbsp__comma;
    20c8:	87b2                	mv	a5,a2
                     cs = 0;
    20ca:	4a01                	li	s4,0
    20cc:	e44ff06f          	j	1710 <stbsp_vsprintfcb+0x484>
               lead[0] -= (char)i;
    20d0:	06010423          	sb	zero,104(sp)
               while (i) {
    20d4:	d38ff06f          	j	160c <stbsp_vsprintfcb+0x380>
            lead[0] -= (char)i;
    20d8:	06010423          	sb	zero,104(sp)
            while (i) {
    20dc:	ed8ff06f          	j	17b4 <stbsp_vsprintfcb+0x528>
            while (i >= 4) {
    20e0:	06fadc63          	bge	s5,a5,2158 <stbsp_vsprintfcb+0xecc>
            tz -= i;
    20e4:	8722                	mv	a4,s0
    20e6:	0007851b          	sext.w	a0,a5
            while (i >= 4) {
    20ea:	008785bb          	addw	a1,a5,s0
               *(stbsp__uint32 *)bf = 0x30303030;
    20ee:	01672023          	sw	s6,0(a4)
               bf += 4;
    20f2:	0711                	addi	a4,a4,4
            while (i >= 4) {
    20f4:	40e5863b          	subw	a2,a1,a4
    20f8:	fecacbe3          	blt	s5,a2,20ee <stbsp_vsprintfcb+0xe62>
    20fc:	ffc5061b          	addiw	a2,a0,-4
    2100:	0026561b          	srliw	a2,a2,0x2
    2104:	0016071b          	addiw	a4,a2,1
    2108:	37f1                	addiw	a5,a5,-4
    210a:	0026161b          	slliw	a2,a2,0x2
    210e:	070a                	slli	a4,a4,0x2
    2110:	9722                	add	a4,a4,s0
    2112:	9f91                	subw	a5,a5,a2
            while (i) {
    2114:	843a                	mv	s0,a4
    2116:	80078de3          	beqz	a5,1930 <stbsp_vsprintfcb+0x6a4>
    211a:	1782                	slli	a5,a5,0x20
    211c:	9381                	srli	a5,a5,0x20
    211e:	00f70433          	add	s0,a4,a5
               *bf++ = '0';
    2122:	0705                	addi	a4,a4,1
    2124:	ff470fa3          	sb	s4,-1(a4)
            while (i) {
    2128:	fe871de3          	bne	a4,s0,2122 <stbsp_vsprintfcb+0xe96>
    212c:	805ff06f          	j	1930 <stbsp_vsprintfcb+0x6a4>
               stbsp__cb_buf_clamp(i, pr);
    2130:	85ce                	mv	a1,s3
               if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    2132:	4981                	li	s3,0
    2134:	dc049263          	bnez	s1,16f8 <stbsp_vsprintfcb+0x46c>
    2138:	b8d5                	j	1a2c <stbsp_vsprintfcb+0x7a0>
            STBSP__UNALIGNED(while (i >= 4) {
    213a:	4401                	li	s0,0
    213c:	85be                	mv	a1,a5
    213e:	f0ea4b63          	blt	s4,a4,1854 <stbsp_vsprintfcb+0x5c8>
    2142:	f42ff06f          	j	1884 <stbsp_vsprintfcb+0x5f8>
               if ((((stbsp__uintptr)bf) & 3) == 0)
    2146:	00347713          	andi	a4,s0,3
            stbsp__cb_buf_clamp(i, tz);
    214a:	87c6                	mv	a5,a7
            tz -= i;
    214c:	4881                	li	a7,0
               if ((((stbsp__uintptr)bf) & 3) == 0)
    214e:	fc071c63          	bnez	a4,1926 <stbsp_vsprintfcb+0x69a>
            while (i >= 4) {
    2152:	470d                	li	a4,3
    2154:	f8f748e3          	blt	a4,a5,20e4 <stbsp_vsprintfcb+0xe58>
    2158:	8722                	mv	a4,s0
    215a:	b7c1                	j	211a <stbsp_vsprintfcb+0xe8e>
            tail[0] -= (char)i;
    215c:	06010823          	sb	zero,112(sp)
            while (i) {
    2160:	b0b9                	j	19ae <stbsp_vsprintfcb+0x722>
                  while (i >= 4) {
    2162:	478d                	li	a5,3
    2164:	8622                	mv	a2,s0
    2166:	d8b7d963          	bge	a5,a1,16f8 <stbsp_vsprintfcb+0x46c>
    216a:	ffc5839b          	addiw	t2,a1,-4
    216e:	0023d79b          	srliw	a5,t2,0x2
    2172:	0017859b          	addiw	a1,a5,1
    2176:	058a                	slli	a1,a1,0x2
    2178:	942e                	add	s0,s0,a1
                     *(stbsp__uint32 *)bf = 0x30303030;
    217a:	01762023          	sw	s7,0(a2)
                     bf += 4;
    217e:	0611                	addi	a2,a2,4
                  while (i >= 4) {
    2180:	fe861de3          	bne	a2,s0,217a <stbsp_vsprintfcb+0xeee>
    2184:	0027979b          	slliw	a5,a5,0x2
    2188:	40f385bb          	subw	a1,t2,a5
    218c:	d68ff06f          	j	16f4 <stbsp_vsprintfcb+0x468>
            while (i) {
    2190:	85be                	mv	a1,a5
    2192:	ee071963          	bnez	a4,1884 <stbsp_vsprintfcb+0x5f8>
    2196:	f16ff06f          	j	18ac <stbsp_vsprintfcb+0x620>
    219a:	2c013a03          	ld	s4,704(sp)
    219e:	2b813a83          	ld	s5,696(sp)
    21a2:	2b013b03          	ld	s6,688(sp)
    21a6:	8ca2                	mv	s9,s0
    21a8:	a04ff06f          	j	13ac <stbsp_vsprintfcb+0x120>
            stbsp__chk_cb_buf(1);
    21ac:	2601                	sext.w	a2,a2
    21ae:	1fe00793          	li	a5,510
    21b2:	f8c7c563          	blt	a5,a2,193c <stbsp_vsprintfcb+0x6b0>
    21b6:	f3eff06f          	j	18f4 <stbsp_vsprintfcb+0x668>
               fl &= ~STBSP__TRIPLET_COMMA; // if no leading zeros, then no commas
    21ba:	fbfe7e13          	andi	t3,t3,-65
         if (fw + pr) {
    21be:	006707bb          	addw	a5,a4,t1
               fl &= ~STBSP__TRIPLET_COMMA; // if no leading zeros, then no commas
    21c2:	2e01                	sext.w	t3,t3
         if (fw + pr) {
    21c4:	a0078be3          	beqz	a5,1bda <stbsp_vsprintfcb+0x94e>
               while (fw > 0) {
    21c8:	be605663          	blez	t1,15b4 <stbsp_vsprintfcb+0x328>
                     *(stbsp__uint32 *)bf = 0x20202020;
    21cc:	20202837          	lui	a6,0x20202
                  stbsp__cb_buf_clamp(i, fw);
    21d0:	854a                	mv	a0,s2
    21d2:	894e                	mv	s2,s3
    21d4:	69a2                	ld	s3,8(sp)
                     *(stbsp__uint32 *)bf = 0x20202020;
    21d6:	02080813          	addi	a6,a6,32 # 20202020 <_ZSt4cerr+0x201fa868>
                  stbsp__cb_buf_clamp(i, fw);
    21da:	ec52                	sd	s4,24(sp)
    21dc:	f426                	sd	s1,40(sp)
    21de:	87a2                	mv	a5,s0
    21e0:	84ea                	mv	s1,s10
                  stbsp__chk_cb_buf(1);
    21e2:	1fe00f13          	li	t5,510
                  stbsp__cb_buf_clamp(i, fw);
    21e6:	8d6e                	mv	s10,s11
                     *bf++ = ' ';
    21e8:	02000b13          	li	s6,32
                  stbsp__cb_buf_clamp(i, fw);
    21ec:	8de6                	mv	s11,s9
                  while (i >= 4) {
    21ee:	4b8d                	li	s7,3
                  stbsp__cb_buf_clamp(i, fw);
    21f0:	20000e93          	li	t4,512
    21f4:	e846                	sd	a7,16(sp)
    21f6:	f07e                	sd	t6,32(sp)
    21f8:	f836                	sd	a3,48(sp)
    21fa:	e4f2                	sd	t3,72(sp)
    21fc:	e8ba                	sd	a4,80(sp)
    21fe:	ec96                	sd	t0,88(sp)
    2200:	841a                	mv	s0,t1
    2202:	8a42                	mv	s4,a6
    2204:	8c9e                	mv	s9,t2
    2206:	0c090063          	beqz	s2,22c6 <stbsp_vsprintfcb+0x103a>
    220a:	40a78633          	sub	a2,a5,a0
    220e:	40ce873b          	subw	a4,t4,a2
    2212:	86ba                	mv	a3,a4
    2214:	00e45363          	bge	s0,a4,221a <stbsp_vsprintfcb+0xf8e>
    2218:	86a2                	mv	a3,s0
    221a:	0006871b          	sext.w	a4,a3
                  fw -= i;
    221e:	9c15                	subw	s0,s0,a3
                  while (i) {
    2220:	e719                	bnez	a4,222e <stbsp_vsprintfcb+0xfa2>
    2222:	a095                	j	2286 <stbsp_vsprintfcb+0xffa>
                     *bf++ = ' ';
    2224:	01678023          	sb	s6,0(a5)
                     --i;
    2228:	377d                	addiw	a4,a4,-1
                     *bf++ = ' ';
    222a:	0785                	addi	a5,a5,1
                  while (i) {
    222c:	cb29                	beqz	a4,227e <stbsp_vsprintfcb+0xff2>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    222e:	0037f693          	andi	a3,a5,3
    2232:	faed                	bnez	a3,2224 <stbsp_vsprintfcb+0xf98>
                  while (i >= 4) {
    2234:	86be                	mv	a3,a5
    2236:	00070f9b          	sext.w	t6,a4
    223a:	00f705bb          	addw	a1,a4,a5
    223e:	02ebd763          	bge	s7,a4,226c <stbsp_vsprintfcb+0xfe0>
                     *(stbsp__uint32 *)bf = 0x20202020;
    2242:	0146a023          	sw	s4,0(a3)
                     bf += 4;
    2246:	0691                	addi	a3,a3,4
                  while (i >= 4) {
    2248:	40d5863b          	subw	a2,a1,a3
    224c:	fecbcbe3          	blt	s7,a2,2242 <stbsp_vsprintfcb+0xfb6>
    2250:	ffcf861b          	addiw	a2,t6,-4 # fffffffff7fffffc <_ZSt4cerr+0xfffffffff7ff8844>
    2254:	0026561b          	srliw	a2,a2,0x2
    2258:	0016069b          	addiw	a3,a2,1
    225c:	3771                	addiw	a4,a4,-4
    225e:	0026161b          	slliw	a2,a2,0x2
    2262:	068a                	slli	a3,a3,0x2
    2264:	96be                	add	a3,a3,a5
    2266:	9f11                	subw	a4,a4,a2
                  while (i) {
    2268:	87b6                	mv	a5,a3
    226a:	cb11                	beqz	a4,227e <stbsp_vsprintfcb+0xff2>
    226c:	1702                	slli	a4,a4,0x20
    226e:	9301                	srli	a4,a4,0x20
    2270:	00e687b3          	add	a5,a3,a4
                     *bf++ = ' ';
    2274:	0685                	addi	a3,a3,1
    2276:	ff668fa3          	sb	s6,-1(a3)
                  while (i) {
    227a:	fef69de3          	bne	a3,a5,2274 <stbsp_vsprintfcb+0xfe8>
                  stbsp__chk_cb_buf(1);
    227e:	40a78633          	sub	a2,a5,a0
    2282:	00090e63          	beqz	s2,229e <stbsp_vsprintfcb+0x1012>
    2286:	2601                	sext.w	a2,a2
    2288:	00cf5b63          	bge	t5,a2,229e <stbsp_vsprintfcb+0x1012>
    228c:	85ce                	mv	a1,s3
    228e:	9cb1                	addw	s1,s1,a2
    2290:	9902                	jalr	s2
    2292:	c541                	beqz	a0,231a <stbsp_vsprintfcb+0x108e>
    2294:	87aa                	mv	a5,a0
    2296:	20000e93          	li	t4,512
    229a:	1fe00f13          	li	t5,510
               while (fw > 0) {
    229e:	f68044e3          	bgtz	s0,2206 <stbsp_vsprintfcb+0xf7a>
    22a2:	8322                	mv	t1,s0
    22a4:	89ca                	mv	s3,s2
    22a6:	83e6                	mv	t2,s9
    22a8:	68c2                	ld	a7,16(sp)
    22aa:	8cee                	mv	s9,s11
    22ac:	6a62                	ld	s4,24(sp)
    22ae:	8dea                	mv	s11,s10
    22b0:	7f82                	ld	t6,32(sp)
    22b2:	8d26                	mv	s10,s1
    22b4:	76c2                	ld	a3,48(sp)
    22b6:	6e26                	ld	t3,72(sp)
    22b8:	6746                	ld	a4,80(sp)
    22ba:	62e6                	ld	t0,88(sp)
    22bc:	74a2                	ld	s1,40(sp)
    22be:	892a                	mv	s2,a0
    22c0:	843e                	mv	s0,a5
    22c2:	af2ff06f          	j	15b4 <stbsp_vsprintfcb+0x328>
                  stbsp__cb_buf_clamp(i, fw);
    22c6:	8722                	mv	a4,s0
    22c8:	4401                	li	s0,0
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    22ca:	b795                	j	222e <stbsp_vsprintfcb+0xfa2>
            n64 = va_arg(va, stbsp__uint32);
    22cc:	000be683          	lwu	a3,0(s7)
    22d0:	b0f9                	j	1b9e <stbsp_vsprintfcb+0x912>
    22d2:	2c013a03          	ld	s4,704(sp)
    22d6:	2b813a83          	ld	s5,696(sp)
    22da:	2b013b03          	ld	s6,688(sp)
    22de:	8cca                	mv	s9,s2
    22e0:	8ccff06f          	j	13ac <stbsp_vsprintfcb+0x120>
    22e4:	8cd6                	mv	s9,s5
    22e6:	2c013a03          	ld	s4,704(sp)
    22ea:	2b813a83          	ld	s5,696(sp)
    22ee:	2b013b03          	ld	s6,688(sp)
    22f2:	8baff06f          	j	13ac <stbsp_vsprintfcb+0x120>
    22f6:	2c013a03          	ld	s4,704(sp)
    22fa:	2b813a83          	ld	s5,696(sp)
    22fe:	2b013b03          	ld	s6,688(sp)
    2302:	8cea                	mv	s9,s10
    2304:	8a8ff06f          	j	13ac <stbsp_vsprintfcb+0x120>
                  while (i) {
    2308:	85a2                	mv	a1,s0
    230a:	c12ff06f          	j	171c <stbsp_vsprintfcb+0x490>
                  while (i >= 4) {
    230e:	478d                	li	a5,3
    2310:	8622                	mv	a2,s0
    2312:	e4b7cce3          	blt	a5,a1,216a <stbsp_vsprintfcb+0xede>
    2316:	be2ff06f          	j	16f8 <stbsp_vsprintfcb+0x46c>
    231a:	2c013a03          	ld	s4,704(sp)
    231e:	2b813a83          	ld	s5,696(sp)
    2322:	2b013b03          	ld	s6,688(sp)
    2326:	8ca6                	mv	s9,s1
    2328:	884ff06f          	j	13ac <stbsp_vsprintfcb+0x120>
            lead[2] = h[16];
    232c:	01084683          	lbu	a3,16(a6)
            lead[0] = 2;
    2330:	678d                	lui	a5,0x3
    2332:	0789                	addi	a5,a5,2 # 3002 <sprintf+0x3e>
    2334:	06f11423          	sh	a5,104(sp)
            lead[2] = h[16];
    2338:	06d10523          	sb	a3,106(sp)
    233c:	b891                	j	1b90 <stbsp_vsprintfcb+0x904>
    233e:	8cea                	mv	s9,s10
    2340:	86cff06f          	j	13ac <stbsp_vsprintfcb+0x120>
    2344:	4f81                	li	t6,0
    2346:	4a01                	li	s4,0
    2348:	5586                	lw	a1,96(sp)
                  *--s = stbsp__comma;
    234a:	00004f17          	auipc	t5,0x4
    234e:	643f4f03          	lbu	t5,1603(t5) # 698d <stbsp__comma>
    2352:	0510                	addi	a2,sp,640
    2354:	0085d71b          	srliw	a4,a1,0x8
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    2358:	4305                	li	t1,1
            if (fl & STBSP__TRIPLET_COMMA) {
    235a:	040e7e93          	andi	t4,t3,64
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    235e:	0007029b          	sext.w	t0,a4
    2362:	005317bb          	sllw	a5,t1,t0
    2366:	37fd                	addiw	a5,a5,-1
    2368:	8ff5                	and	a5,a5,a3
    236a:	97c2                	add	a5,a5,a6
    236c:	0007c783          	lbu	a5,0(a5)
            n64 >>= (l >> 8);
    2370:	0056d6b3          	srl	a3,a3,t0
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    2374:	fff60a93          	addi	s5,a2,-1
    2378:	fef60fa3          	sb	a5,-1(a2)
            if (!((n64) || ((stbsp__int32)((num + STBSP__NUMSZ) - s) < pr)))
    237c:	e691                	bnez	a3,2388 <stbsp_vsprintfcb+0x10fc>
    237e:	051c                	addi	a5,sp,640
    2380:	415787bb          	subw	a5,a5,s5
    2384:	0317dd63          	bge	a5,a7,23be <stbsp_vsprintfcb+0x1132>
            if (fl & STBSP__TRIPLET_COMMA) {
    2388:	020e8963          	beqz	t4,23ba <stbsp_vsprintfcb+0x112e>
               ++l;
    238c:	0015879b          	addiw	a5,a1,1
               if ((l & 15) == ((l >> 4) & 15)) {
    2390:	0047d29b          	srliw	t0,a5,0x4
    2394:	00f2c2b3          	xor	t0,t0,a5
    2398:	00f2f293          	andi	t0,t0,15
               ++l;
    239c:	0007859b          	sext.w	a1,a5
               if ((l & 15) == ((l >> 4) & 15)) {
    23a0:	0087d71b          	srliw	a4,a5,0x8
    23a4:	00029b63          	bnez	t0,23ba <stbsp_vsprintfcb+0x112e>
                  l &= ~15;
    23a8:	9bc1                	andi	a5,a5,-16
    23aa:	0007859b          	sext.w	a1,a5
                  *--s = stbsp__comma;
    23ae:	ffe60a93          	addi	s5,a2,-2
    23b2:	ffe60f23          	sb	t5,-2(a2)
    23b6:	0087d71b          	srliw	a4,a5,0x8
    23ba:	8656                	mv	a2,s5
    23bc:	b74d                	j	235e <stbsp_vsprintfcb+0x10d2>
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    23be:	0045d29b          	srliw	t0,a1,0x4
    23c2:	0f0006b7          	lui	a3,0xf000
         if (pr < (stbsp__int32)l)
    23c6:	0007871b          	sext.w	a4,a5
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    23ca:	0182929b          	slliw	t0,t0,0x18
    23ce:	00d2f2b3          	and	t0,t0,a3
         n = pr + lead[0] + tail[0] + tz;
    23d2:	00ef863b          	addw	a2,t6,a4
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    23d6:	d0be                	sw	a5,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    23d8:	8fb2                	mv	t6,a2
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    23da:	86be                	mv	a3,a5
    23dc:	00f282bb          	addw	t0,t0,a5
         if (fw < (stbsp__int32)n)
    23e0:	835a                	mv	t1,s6
    23e2:	00cb5363          	bge	s6,a2,23e8 <stbsp_vsprintfcb+0x115c>
    23e6:	8332                	mv	t1,a2
         fw -= n;
    23e8:	41f3033b          	subw	t1,t1,t6
         pr -= l;
    23ec:	9f1d                	subw	a4,a4,a5
         goto scopy;
    23ee:	4f81                	li	t6,0
      tz = 0;
    23f0:	4881                	li	a7,0
         goto scopy;
    23f2:	fdcff06f          	j	1bce <stbsp_vsprintfcb+0x942>
    23f6:	8cda                	mv	s9,s6
    23f8:	2c013a03          	ld	s4,704(sp)
    23fc:	2b813a83          	ld	s5,696(sp)
    2400:	2b013b03          	ld	s6,688(sp)
    2404:	fa9fe06f          	j	13ac <stbsp_vsprintfcb+0x120>
            fl |= ((sizeof(void *) == 8) ? STBSP__INTMAX : 0);
    2408:	020e6e13          	ori	t3,t3,32
            ++f;
    240c:	0485                	addi	s1,s1,1
    240e:	864ff06f          	j	1472 <stbsp_vsprintfcb+0x1e6>
               n = 0;
    2412:	4601                	li	a2,0
         s = num + 64;
    2414:	8756                	mv	a4,s5
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2416:	4511                	li	a0,4
                     *s++ = stbsp__comma;
    2418:	00170793          	addi	a5,a4,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    241c:	00030563          	beqz	t1,2426 <stbsp_vsprintfcb+0x119a>
    2420:	2585                	addiw	a1,a1,1
    2422:	10a58363          	beq	a1,a0,2528 <stbsp_vsprintfcb+0x129c>
    2426:	873e                	mv	a4,a5
                     *s++ = sn[n];
    2428:	02061793          	slli	a5,a2,0x20
    242c:	9381                	srli	a5,a5,0x20
    242e:	97fa                	add	a5,a5,t5
    2430:	0007c803          	lbu	a6,0(a5)
                     ++n;
    2434:	2605                	addiw	a2,a2,1
                     *s++ = sn[n];
    2436:	ff070fa3          	sb	a6,-1(a4)
                     if (n >= l)
    243a:	fcd66fe3          	bltu	a2,a3,2418 <stbsp_vsprintfcb+0x118c>
               if (n < (stbsp__uint32)dp) {
    243e:	0bd663e3          	bltu	a2,t4,2ce4 <stbsp_vsprintfcb+0x1a58>
               cs = (int)(s - (num + 64)) + (3 << 24); // cs is how many tens
    2442:	415707b3          	sub	a5,a4,s5
    2446:	030002b7          	lui	t0,0x3000
    244a:	00f282bb          	addw	t0,t0,a5
               if (pr) {
    244e:	00088a63          	beqz	a7,2462 <stbsp_vsprintfcb+0x11d6>
                  *s++ = stbsp__period;
    2452:	0cca4683          	lbu	a3,204(s4)
    2456:	00170793          	addi	a5,a4,1
         l = (stbsp__uint32)(s - (num + 64));
    245a:	415787b3          	sub	a5,a5,s5
                  *s++ = stbsp__period;
    245e:	00d70023          	sb	a3,0(a4)
         if (fl & STBSP__METRIC_SUFFIX) {
    2462:	100e7713          	andi	a4,t3,256
    2466:	86f2                	mv	a3,t3
    2468:	2c070163          	beqz	a4,272a <stbsp_vsprintfcb+0x149e>
            if (fl & STBSP__METRIC_NOSPACE)
    246c:	40ae5f9b          	sraiw	t6,t3,0xa
    2470:	001fcf93          	xori	t6,t6,1
    2474:	001fff93          	andi	t6,t6,1
            tail[1] = ' ';
    2478:	02000713          	li	a4,32
    247c:	06e108a3          	sb	a4,113(sp)
            tail[0] = idx;
    2480:	07f10823          	sb	t6,112(sp)
               if (fl >> 24) { // SI kilo is 'k', JEDEC and SI kibits are 'K'.
    2484:	018e561b          	srliw	a2,t3,0x18
    2488:	018e571b          	srliw	a4,t3,0x18
         n = pr + lead[0] + tail[0] + tz;
    248c:	000f859b          	sext.w	a1,t6
               if (fl >> 24) { // SI kilo is 'k', JEDEC and SI kibits are 'K'.
    2490:	c225                	beqz	a2,24f0 <stbsp_vsprintfcb+0x1264>
                  if (fl & STBSP__METRIC_1024)
    2492:	001f859b          	addiw	a1,t6,1
    2496:	0ff5f613          	zext.b	a2,a1
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    249a:	1702                	slli	a4,a4,0x20
                  if (fl & STBSP__METRIC_1024)
    249c:	03469513          	slli	a0,a3,0x34
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    24a0:	85b2                	mv	a1,a2
    24a2:	9301                	srli	a4,a4,0x20
                  if (fl & STBSP__METRIC_1024)
    24a4:	06055ee3          	bgez	a0,2d20 <stbsp_vsprintfcb+0x1a94>
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    24a8:	00003517          	auipc	a0,0x3
    24ac:	b6050513          	addi	a0,a0,-1184 # 5008 <_GLOBAL__sub_I__ZSt3cin+0x5a>
    24b0:	972a                	add	a4,a4,a0
    24b2:	00074503          	lbu	a0,0(a4)
                  if (fl & STBSP__METRIC_1024 && !(fl & STBSP__METRIC_JEDEC)) {
    24b6:	6709                	lui	a4,0x2
    24b8:	80070713          	addi	a4,a4,-2048 # 1800 <stbsp_vsprintfcb+0x574>
    24bc:	8f75                	and	a4,a4,a3
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    24be:	06010813          	addi	a6,sp,96
    24c2:	22060693          	addi	a3,a2,544
    24c6:	96c2                	add	a3,a3,a6
    24c8:	dea68823          	sb	a0,-528(a3) # efffdf0 <_ZSt4cerr+0xeff8638>
                  if (fl & STBSP__METRIC_1024 && !(fl & STBSP__METRIC_JEDEC)) {
    24cc:	8007071b          	addiw	a4,a4,-2048
    24d0:	060715e3          	bnez	a4,2d3a <stbsp_vsprintfcb+0x1aae>
                     tail[idx + 1] = 'i';
    24d4:	2f89                	addiw	t6,t6,2
    24d6:	0ffff593          	zext.b	a1,t6
    24da:	1094                	addi	a3,sp,96
    24dc:	22058713          	addi	a4,a1,544
    24e0:	9736                	add	a4,a4,a3
    24e2:	06900693          	li	a3,105
    24e6:	8fae                	mv	t6,a1
    24e8:	ded70823          	sb	a3,-528(a4)
                  tail[0] = idx;
    24ec:	07f10823          	sb	t6,112(sp)
         l = (stbsp__uint32)(s - (num + 64));
    24f0:	0007869b          	sext.w	a3,a5
         n = pr + lead[0] + tail[0] + tz;
    24f4:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    24f8:	fff6c713          	not	a4,a3
    24fc:	977d                	srai	a4,a4,0x3f
    24fe:	8ff9                	and	a5,a5,a4
         n = pr + lead[0] + tail[0] + tz;
    2500:	00fa073b          	addw	a4,s4,a5
    2504:	9f2d                	addw	a4,a4,a1
    2506:	0117063b          	addw	a2,a4,a7
         l = (stbsp__uint32)(s - (num + 64));
    250a:	d0b6                	sw	a3,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    250c:	8732                	mv	a4,a2
         if (pr < (stbsp__int32)l)
    250e:	2781                	sext.w	a5,a5
         if ((fl & STBSP__LEFTJUST) == 0) {
    2510:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    2514:	835a                	mv	t1,s6
    2516:	00cb5363          	bge	s6,a2,251c <stbsp_vsprintfcb+0x1290>
    251a:	8332                	mv	t1,a2
         fw -= n;
    251c:	40e3033b          	subw	t1,t1,a4
         pr -= l;
    2520:	40d7873b          	subw	a4,a5,a3
         goto scopy;
    2524:	eaaff06f          	j	1bce <stbsp_vsprintfcb+0x942>
                     *s++ = stbsp__comma;
    2528:	fe578fa3          	sb	t0,-1(a5)
    252c:	0709                	addi	a4,a4,2
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    252e:	4585                	li	a1,1
    2530:	bde5                	j	2428 <stbsp_vsprintfcb+0x119c>
            lead[0] = 1;
    2532:	678d                	lui	a5,0x3
    2534:	0785                	addi	a5,a5,1 # 3001 <sprintf+0x3d>
    2536:	06f11423          	sh	a5,104(sp)
    253a:	b4ed                	j	2024 <stbsp_vsprintfcb+0xd98>
            if ((f[0] != 'u') && (i64 < 0)) {
    253c:	07500693          	li	a3,117
            stbsp__int64 i64 = va_arg(va, stbsp__int64);
    2540:	000bbf03          	ld	t5,0(s7)
            if ((f[0] != 'u') && (i64 < 0)) {
    2544:	dcd78263          	beq	a5,a3,1b08 <stbsp_vsprintfcb+0x87c>
    2548:	dc0f5063          	bgez	t5,1b08 <stbsp_vsprintfcb+0x87c>
               fl |= STBSP__NEGATIVE;
    254c:	08076713          	ori	a4,a4,128
               n64 = (stbsp__uint64)-i64;
    2550:	41e00f33          	neg	t5,t5
               fl |= STBSP__NEGATIVE;
    2554:	00070e1b          	sext.w	t3,a4
    2558:	db0ff06f          	j	1b08 <stbsp_vsprintfcb+0x87c>
            lead[2] = h[0xb];
    255c:	00b84703          	lbu	a4,11(a6)
            lead[0] = 2;
    2560:	678d                	lui	a5,0x3
    2562:	0789                	addi	a5,a5,2 # 3002 <sprintf+0x3e>
    2564:	06f11423          	sh	a5,104(sp)
            lead[2] = h[0xb];
    2568:	06e10523          	sb	a4,106(sp)
    256c:	bab5                	j	1ee8 <stbsp_vsprintfcb+0xc5c>
      sign[0] = 1;
    256e:	678d                	lui	a5,0x3
    2570:	d0178793          	addi	a5,a5,-767 # 2d01 <stbsp_vsprintfcb+0x1a75>
            fl |= STBSP__NEGATIVE;
    2574:	080e6e13          	ori	t3,t3,128
      sign[0] = 1;
    2578:	06f11423          	sh	a5,104(sp)
    257c:	468d                	li	a3,3
    257e:	4a0d                	li	s4,3
    2580:	4809                	li	a6,2
    2582:	b899                	j	1dd8 <stbsp_vsprintfcb+0xb4c>
      sign[0] = 1;
    2584:	6709                	lui	a4,0x2
    2586:	0705                	addi	a4,a4,1 # 2001 <stbsp_vsprintfcb+0xd75>
    2588:	06e11423          	sh	a4,104(sp)
    258c:	bae5                	j	1f84 <stbsp_vsprintfcb+0xcf8>
      if (((stbsp__uintptr)sn & 3) == 0)
    258e:	0e0780e3          	beqz	a5,2e6e <stbsp_vsprintfcb+0x1be2>
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    2592:	56fd                	li	a3,-1
    2594:	bcf9                	j	2072 <stbsp_vsprintfcb+0xde6>
         if (fw < (stbsp__int32)n)
    2596:	4305                	li	t1,1
    2598:	b249                	j	1f1a <stbsp_vsprintfcb+0xc8e>
            pr = 6; // default is 6
    259a:	4899                	li	a7,6
    259c:	b801                	j	1dac <stbsp_vsprintfcb+0xb20>
         h = (f[0] == 'A') ? hexu : hex;
    259e:	00004597          	auipc	a1,0x4
    25a2:	3f258593          	addi	a1,a1,1010 # 6990 <hexu.1>
    25a6:	ff6ff06f          	j	1d9c <stbsp_vsprintfcb+0xb10>
         h = (f[0] == 'B') ? hexu : hex;
    25aa:	00004817          	auipc	a6,0x4
    25ae:	3e680813          	addi	a6,a6,998 # 6990 <hexu.1>
    25b2:	b22d                	j	1edc <stbsp_vsprintfcb+0xc50>
    25b4:	80000737          	lui	a4,0x80000
    25b8:	0719                	addi	a4,a4,6 # ffffffff80000006 <_ZSt4cerr+0xffffffff7fff884e>
            pr = 6; // default is 6
    25ba:	4899                	li	a7,6
    25bc:	e4eff06f          	j	1c0a <stbsp_vsprintfcb+0x97e>
         h = (f[0] == 'E') ? hexu : hex;
    25c0:	00004317          	auipc	t1,0x4
    25c4:	3d030313          	addi	t1,t1,976 # 6990 <hexu.1>
    25c8:	e28ff06f          	j	1bf0 <stbsp_vsprintfcb+0x964>
    25cc:	80000737          	lui	a4,0x80000
    25d0:	4a99                	li	s5,6
    25d2:	0715                	addi	a4,a4,5 # ffffffff80000005 <_ZSt4cerr+0xffffffff7fff884d>
            pr = 6;
    25d4:	4a19                	li	s4,6
    25d6:	ee8ff06f          	j	1cbe <stbsp_vsprintfcb+0xa32>
         h = (f[0] == 'G') ? hexu : hex;
    25da:	00004317          	auipc	t1,0x4
    25de:	3b630313          	addi	t1,t1,950 # 6990 <hexu.1>
    25e2:	eb6ff06f          	j	1c98 <stbsp_vsprintfcb+0xa0c>
    25e6:	7be6                	ld	s7,120(sp)
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    25e8:	86c2                	mv	a3,a6
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    25ea:	8542                	mv	a0,a6
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    25ec:	88d2                	mv	a7,s4
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    25ee:	8ade                	mv	s5,s7
            if (pr > (stbsp__int32)l)
    25f0:	0005071b          	sext.w	a4,a0
    25f4:	01175f63          	bge	a4,a7,2612 <stbsp_vsprintfcb+0x1386>
               pr = l - 1;
    25f8:	fff5089b          	addiw	a7,a0,-1
         tail[0] = 0;
    25fc:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    2600:	70028c63          	beqz	t0,2d18 <stbsp_vsprintfcb+0x1a8c>
      sign[0] = 1;
    2604:	670d                	lui	a4,0x3
    2606:	d0170713          	addi	a4,a4,-767 # 2d01 <stbsp_vsprintfcb+0x1a75>
    260a:	06e11423          	sh	a4,104(sp)
    260e:	e3aff06f          	j	1c48 <stbsp_vsprintfcb+0x9bc>
            else if (pr)
    2612:	fe0885e3          	beqz	a7,25fc <stbsp_vsprintfcb+0x1370>
               --pr; // when using %e, there is one digit before the decimal
    2616:	38fd                	addiw	a7,a7,-1
    2618:	b7d5                	j	25fc <stbsp_vsprintfcb+0x1370>
      switch (f[0]) {
    261a:	0034c783          	lbu	a5,3(s1)
            f += 3;
    261e:	048d                	addi	s1,s1,3
    2620:	e53fe06f          	j	1472 <stbsp_vsprintfcb+0x1e6>
      if (!limit || *sn == 0)
    2624:	4601                	li	a2,0
    2626:	4701                	li	a4,0
    2628:	4781                	li	a5,0
         return (stbsp__uint32)(sn - s);
    262a:	bca5                	j	20a2 <stbsp_vsprintfcb+0xe16>
               pr = 1;
    262c:	4885                	li	a7,1
    262e:	cf4ff06f          	j	1b22 <stbsp_vsprintfcb+0x896>
         *s++ = sn[0];
    2632:	000ac703          	lbu	a4,0(s5)
    2636:	0ce10023          	sb	a4,192(sp)
         if (pr)
    263a:	54088563          	beqz	a7,2b84 <stbsp_vsprintfcb+0x18f8>
            *s++ = stbsp__period;
    263e:	00004617          	auipc	a2,0x4
    2642:	34e64603          	lbu	a2,846(a2) # 698c <stbsp__period>
         if ((l - 1) > (stbsp__uint32)pr)
    2646:	fff6871b          	addiw	a4,a3,-1
            *s++ = stbsp__period;
    264a:	0cc100a3          	sb	a2,193(sp)
         if ((l - 1) > (stbsp__uint32)pr)
    264e:	0008851b          	sext.w	a0,a7
    2652:	0007061b          	sext.w	a2,a4
    2656:	52c57163          	bgeu	a0,a2,2b78 <stbsp_vsprintfcb+0x18ec>
            l = pr + 1;
    265a:	0018869b          	addiw	a3,a7,1
         for (n = 1; n < l; n++)
    265e:	8746                	mv	a4,a7
    2660:	02071613          	slli	a2,a4,0x20
    2664:	9201                	srli	a2,a2,0x20
    2666:	0c210713          	addi	a4,sp,194
    266a:	0a85                	addi	s5,s5,1
    266c:	963a                	add	a2,a2,a4
            *s++ = sn[n];
    266e:	000ac583          	lbu	a1,0(s5)
    2672:	0705                	addi	a4,a4,1
         for (n = 1; n < l; n++)
    2674:	0a85                	addi	s5,s5,1
            *s++ = sn[n];
    2676:	feb70fa3          	sb	a1,-1(a4)
         for (n = 1; n < l; n++)
    267a:	fec71ae3          	bne	a4,a2,266e <stbsp_vsprintfcb+0x13e2>
         tail[1] = h[0xe];
    267e:	00e34803          	lbu	a6,14(t1)
         dp -= 1;
    2682:	fff7871b          	addiw	a4,a5,-1
            tail[2] = '+';
    2686:	02b00593          	li	a1,43
         tail[1] = h[0xe];
    268a:	070108a3          	sb	a6,113(sp)
         if (dp < 0) {
    268e:	00075663          	bgez	a4,269a <stbsp_vsprintfcb+0x140e>
            dp = -dp;
    2692:	4705                	li	a4,1
    2694:	9f1d                	subw	a4,a4,a5
            tail[2] = '-';
    2696:	02d00593          	li	a1,45
    269a:	06b10923          	sb	a1,114(sp)
         n = (dp >= 100) ? 5 : 4;
    269e:	06300793          	li	a5,99
    26a2:	4ee7d663          	bge	a5,a4,2b8e <stbsp_vsprintfcb+0x1902>
    26a6:	4595                	li	a1,5
    26a8:	4f95                	li	t6,5
    26aa:	4e95                	li	t4,5
            tail[n] = '0' + dp % 10;
    26ac:	47a9                	li	a5,10
            dp /= 10;
    26ae:	02f7433b          	divw	t1,a4,a5
            --n;
    26b2:	fffe8f1b          	addiw	t5,t4,-1
            tail[n] = '0' + dp % 10;
    26b6:	020f1293          	slli	t0,t5,0x20
    26ba:	220e8813          	addi	a6,t4,544
    26be:	06010893          	addi	a7,sp,96
    26c2:	0202d293          	srli	t0,t0,0x20
    26c6:	01180eb3          	add	t4,a6,a7
    26ca:	22028813          	addi	a6,t0,544 # 3000220 <_ZSt4cerr+0x2ff8a68>
    26ce:	011802b3          	add	t0,a6,a7
         tail[0] = (char)n;
    26d2:	07f10823          	sb	t6,112(sp)
            if (n <= 3)
    26d6:	4a0d                	li	s4,3
            tail[n] = '0' + dp % 10;
    26d8:	02f7673b          	remw	a4,a4,a5
            dp /= 10;
    26dc:	0003081b          	sext.w	a6,t1
            tail[n] = '0' + dp % 10;
    26e0:	02f36abb          	remw	s5,t1,a5
    26e4:	0307071b          	addiw	a4,a4,48
    26e8:	deee8823          	sb	a4,-528(t4)
    26ec:	030a871b          	addiw	a4,s5,48
    26f0:	dee28823          	sb	a4,-528(t0)
            if (n <= 3)
    26f4:	014f0a63          	beq	t5,s4,2708 <stbsp_vsprintfcb+0x147c>
            dp /= 10;
    26f8:	02f3483b          	divw	a6,t1,a5
            tail[n] = '0' + dp % 10;
    26fc:	02f867bb          	remw	a5,a6,a5
    2700:	0307879b          	addiw	a5,a5,48
    2704:	06f109a3          	sb	a5,115(sp)
         tz = pr - (l - 1);
    2708:	2505                	addiw	a0,a0,1
         l = (stbsp__uint32)(s - (num + 64));
    270a:	0c010a93          	addi	s5,sp,192
         cs = 1 + (3 << 24); // how many tens
    270e:	030002b7          	lui	t0,0x3000
         tz = pr - (l - 1);
    2712:	40d508bb          	subw	a7,a0,a3
    2716:	d2c2                	sw	a6,100(sp)
         l = (stbsp__uint32)(s - (num + 64));
    2718:	415607b3          	sub	a5,a2,s5
         cs = 1 + (3 << 24); // how many tens
    271c:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff8849>
    271e:	bbc9                	j	24f0 <stbsp_vsprintfcb+0x1264>
    2720:	fc2e                	sd	a1,56(sp)
    2722:	d0b2                	sw	a2,96(sp)
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2724:	8536                	mv	a0,a3
    2726:	e2cff06f          	j	1d52 <stbsp_vsprintfcb+0xac6>
      flt_lead:
    272a:	4581                	li	a1,0
    272c:	4f81                	li	t6,0
    272e:	b3c9                	j	24f0 <stbsp_vsprintfcb+0x1264>
         n = pr + lead[0] + tail[0] + tz;
    2730:	06814a03          	lbu	s4,104(sp)
    2734:	000a0f9b          	sext.w	t6,s4
    2738:	b901                	j	2348 <stbsp_vsprintfcb+0x10bc>
         if ((f[1] == '6') && (f[2] == '4')) {
    273a:	0024c683          	lbu	a3,2(s1)
    273e:	03400713          	li	a4,52
    2742:	00e68463          	beq	a3,a4,274a <stbsp_vsprintfcb+0x14be>
    2746:	e2bfe06f          	j	1570 <stbsp_vsprintfcb+0x2e4>
      switch (f[0]) {
    274a:	0034c783          	lbu	a5,3(s1)
         fl |= ((sizeof(long) == 8) ? STBSP__INTMAX : 0);
    274e:	020e6e13          	ori	t3,t3,32
            f += 3;
    2752:	048d                	addi	s1,s1,3
    2754:	d1ffe06f          	j	1472 <stbsp_vsprintfcb+0x1e6>
         if (pr < (stbsp__int32)l)
    2758:	0006879b          	sext.w	a5,a3
         n = pr + lead[0] + tail[0] + tz;
    275c:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    2760:	fff7c793          	not	a5,a5
    2764:	97fd                	srai	a5,a5,0x3f
    2766:	8ff5                	and	a5,a5,a3
         n = pr + lead[0] + tail[0] + tz;
    2768:	00fa063b          	addw	a2,s4,a5
            s = (char *)sn;
    276c:	7ae6                	ld	s5,120(sp)
         n = pr + lead[0] + tail[0] + tz;
    276e:	8732                	mv	a4,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    2770:	001e7513          	andi	a0,t3,1
         if (pr < (stbsp__int32)l)
    2774:	2781                	sext.w	a5,a5
         if (fw < (stbsp__int32)n)
    2776:	835a                	mv	t1,s6
    2778:	00cb5363          	bge	s6,a2,277e <stbsp_vsprintfcb+0x14f2>
    277c:	8332                	mv	t1,a2
         fw -= n;
    277e:	40e3033b          	subw	t1,t1,a4
            goto scopy;
    2782:	4f81                	li	t6,0
         pr -= l;
    2784:	40d7873b          	subw	a4,a5,a3
            cs = 0;
    2788:	4281                	li	t0,0
      tz = 0;
    278a:	4881                	li	a7,0
            goto scopy;
    278c:	c42ff06f          	j	1bce <stbsp_vsprintfcb+0x942>
               cs = (int)(s - (num + 64)) + (3 << 24); // cs is how many tens
    2790:	415705b3          	sub	a1,a4,s5
    2794:	030002b7          	lui	t0,0x3000
    2798:	00b282bb          	addw	t0,t0,a1
               l = pr - n;
    279c:	0008859b          	sext.w	a1,a7
               if (pr)
    27a0:	42088763          	beqz	a7,2bce <stbsp_vsprintfcb+0x1942>
                  *s++ = stbsp__period;
    27a4:	0cca4f83          	lbu	t6,204(s4)
               if ((l - dp) > (stbsp__uint32)pr)
    27a8:	41d6833b          	subw	t1,a3,t4
                  *s++ = stbsp__period;
    27ac:	00280713          	addi	a4,a6,2
    27b0:	01f800a3          	sb	t6,1(a6)
               if ((l - dp) > (stbsp__uint32)pr)
    27b4:	4065ed63          	bltu	a1,t1,2bce <stbsp_vsprintfcb+0x1942>
               while (n < l) {
    27b8:	5ed57863          	bgeu	a0,a3,2da8 <stbsp_vsprintfcb+0x1b1c>
    27bc:	40c687bb          	subw	a5,a3,a2
    27c0:	37fd                	addiw	a5,a5,-1
    27c2:	1782                	slli	a5,a5,0x20
    27c4:	9381                	srli	a5,a5,0x20
    27c6:	1602                	slli	a2,a2,0x20
    27c8:	9201                	srli	a2,a2,0x20
    27ca:	0785                	addi	a5,a5,1
    27cc:	967a                	add	a2,a2,t5
    27ce:	97ba                	add	a5,a5,a4
                  *s++ = sn[n];
    27d0:	00064503          	lbu	a0,0(a2)
    27d4:	0705                	addi	a4,a4,1
               while (n < l) {
    27d6:	0605                	addi	a2,a2,1
                  *s++ = sn[n];
    27d8:	fea70fa3          	sb	a0,-1(a4)
               while (n < l) {
    27dc:	fef71ae3          	bne	a4,a5,27d0 <stbsp_vsprintfcb+0x1544>
               tz = pr - (l - dp);
    27e0:	01d585bb          	addw	a1,a1,t4
    27e4:	40d588bb          	subw	a7,a1,a3
         l = (stbsp__uint32)(s - (num + 64));
    27e8:	415787b3          	sub	a5,a5,s5
    27ec:	b99d                	j	2462 <stbsp_vsprintfcb+0x11d6>
            fl |= STBSP__NEGATIVE;
    27ee:	080e6e13          	ori	t3,t3,128
         tail[0] = 0;
    27f2:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    27f6:	b539                	j	2604 <stbsp_vsprintfcb+0x1378>
         tail[0] = (char)n;
    27f8:	4799                	li	a5,6
            tail[n] = '0' + dp % 10;
    27fa:	06b10b23          	sb	a1,118(sp)
         tail[0] = (char)n;
    27fe:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    2802:	4819                	li	a6,6
    2804:	4f99                	li	t6,6
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    2806:	4599                	li	a1,6
            dp /= 10;
    2808:	4f29                	li	t5,10
            if (n <= 3)
    280a:	428d                	li	t0,3
    280c:	87b2                	mv	a5,a2
            dp /= 10;
    280e:	03e7c7bb          	divw	a5,a5,t5
            --n;
    2812:	35fd                	addiw	a1,a1,-1
            tail[n] = '0' + dp % 10;
    2814:	02059613          	slli	a2,a1,0x20
    2818:	9201                	srli	a2,a2,0x20
    281a:	06010e93          	addi	t4,sp,96
    281e:	22060613          	addi	a2,a2,544
    2822:	9676                	add	a2,a2,t4
    2824:	03e7eebb          	remw	t4,a5,t5
    2828:	030e8e9b          	addiw	t4,t4,48
    282c:	dfd60823          	sb	t4,-528(a2)
            if (n <= 3)
    2830:	fc559fe3          	bne	a1,t0,280e <stbsp_vsprintfcb+0x1582>
    2834:	e6aff06f          	j	1e9e <stbsp_vsprintfcb+0xc12>
         *s++ = h[(n64 >> 60) & 15];
    2838:	93f1                	srli	a5,a5,0x3c
    283a:	97ae                	add	a5,a5,a1
    283c:	0007c303          	lbu	t1,0(a5)
         lead[1 + lead[0]] = '0';
    2840:	1088                	addi	a0,sp,96
    2842:	22080793          	addi	a5,a6,544
    2846:	97aa                	add	a5,a5,a0
    2848:	03000513          	li	a0,48
    284c:	dea78423          	sb	a0,-536(a5)
         lead[2 + lead[0]] = 'x';
    2850:	22068793          	addi	a5,a3,544
    2854:	1094                	addi	a3,sp,96
    2856:	96be                	add	a3,a3,a5
            *s++ = stbsp__period;
    2858:	00004517          	auipc	a0,0x4
    285c:	13454503          	lbu	a0,308(a0) # 698c <stbsp__period>
         lead[2 + lead[0]] = 'x';
    2860:	07800813          	li	a6,120
         sn = s;
    2864:	0c210793          	addi	a5,sp,194
         lead[2 + lead[0]] = 'x';
    2868:	df068423          	sb	a6,-536(a3)
            *s++ = stbsp__period;
    286c:	0ca100a3          	sb	a0,193(sp)
         lead[0] += 2;
    2870:	07410423          	sb	s4,104(sp)
         *s++ = h[(n64 >> 60) & 15];
    2874:	0c610023          	sb	t1,192(sp)
         n64 <<= 4;
    2878:	0732                	slli	a4,a4,0xc
         sn = s;
    287a:	fcbe                	sd	a5,120(sp)
         n = pr;
    287c:	0008869b          	sext.w	a3,a7
         while (n--) {
    2880:	4831                	li	a6,12
         if (n > 13)
    2882:	4535                	li	a0,13
            tz = pr - n;
    2884:	40a688bb          	subw	a7,a3,a0
         while (n--) {
    2888:	02081313          	slli	t1,a6,0x20
    288c:	02035313          	srli	t1,t1,0x20
    2890:	22030693          	addi	a3,t1,544
    2894:	1088                	addi	a0,sp,96
    2896:	9536                	add	a0,a0,a3
    2898:	e4350513          	addi	a0,a0,-445
            *s++ = h[(n64 >> 60) & 15];
    289c:	03c75693          	srli	a3,a4,0x3c
    28a0:	96ae                	add	a3,a3,a1
    28a2:	0006c683          	lbu	a3,0(a3)
    28a6:	0785                	addi	a5,a5,1
            n64 <<= 4;
    28a8:	0712                	slli	a4,a4,0x4
            *s++ = h[(n64 >> 60) & 15];
    28aa:	fed78fa3          	sb	a3,-1(a5)
         while (n--) {
    28ae:	fea797e3          	bne	a5,a0,289c <stbsp_vsprintfcb+0x1610>
         l = (int)(s - (num + 64));
    28b2:	280d                	addiw	a6,a6,3
    28b4:	0008069b          	sext.w	a3,a6
         if (pr < (stbsp__int32)l)
    28b8:	fff6c713          	not	a4,a3
    28bc:	977d                	srai	a4,a4,0x3f
    28be:	00e87733          	and	a4,a6,a4
         dp = (int)(s - sn);
    28c2:	0013051b          	addiw	a0,t1,1
         if (pr < (stbsp__int32)l)
    28c6:	0007031b          	sext.w	t1,a4
         pr -= l;
    28ca:	4107073b          	subw	a4,a4,a6
    28ce:	d76ff06f          	j	1e44 <stbsp_vsprintfcb+0xbb8>
                  *--s = stbsp__comma;
    28d2:	00004a17          	auipc	s4,0x4
    28d6:	feea0a13          	addi	s4,s4,-18 # 68c0 <stbsp__digitpair>
            if (n64 >= 100000000) {
    28da:	05f5e7b7          	lui	a5,0x5f5e
    28de:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f56947>
               n = (stbsp__uint32)(n64 % 100000000);
    28e2:	05f5e637          	lui	a2,0x5f5e
                  *--s = stbsp__comma;
    28e6:	0cda4b83          	lbu	s7,205(s4)
            if (n64 >= 100000000) {
    28ea:	e83e                	sd	a5,16(sp)
               n = (stbsp__uint32)(n64 % 100000000);
    28ec:	10060793          	addi	a5,a2,256 # 5f5e100 <_ZSt4cerr+0x5f56948>
         l = 0;
    28f0:	d082                	sw	zero,96(sp)
            if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    28f2:	040e7813          	andi	a6,t3,64
    28f6:	4701                	li	a4,0
    28f8:	4281                	li	t0,0
         s = num + STBSP__NUMSZ;
    28fa:	28010a93          	addi	s5,sp,640
               n = (stbsp__uint32)(n64 % 100000000);
    28fe:	ec3e                	sd	a5,24(sp)
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    2900:	430d                	li	t1,3
                  n /= 10;
    2902:	45a9                	li	a1,10
            while (n) {
    2904:	4ea5                	li	t4,9
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    2906:	06400f93          	li	t6,100
            if (n64 >= 100000000) {
    290a:	67c2                	ld	a5,16(sp)
            char *o = s - 8;
    290c:	ff8a8513          	addi	a0,s5,-8
            if (n64 >= 100000000) {
    2910:	0fe7f763          	bgeu	a5,t5,29fe <stbsp_vsprintfcb+0x1772>
               n = (stbsp__uint32)(n64 % 100000000);
    2914:	6662                	ld	a2,24(sp)
    2916:	02cf77b3          	remu	a5,t5,a2
               n64 /= 100000000;
    291a:	02cf5f33          	divu	t5,t5,a2
            if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    291e:	0e080463          	beqz	a6,2a06 <stbsp_vsprintfcb+0x177a>
            while (n) {
    2922:	cb85                	beqz	a5,2952 <stbsp_vsprintfcb+0x16c6>
                  *--s = stbsp__comma;
    2924:	1afd                	addi	s5,s5,-1
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    2926:	00671763          	bne	a4,t1,2934 <stbsp_vsprintfcb+0x16a8>
                  --o;
    292a:	017a8023          	sb	s7,0(s5)
    292e:	157d                	addi	a0,a0,-1
                  *--s = stbsp__comma;
    2930:	1afd                	addi	s5,s5,-1
                  l = 0;
    2932:	4701                	li	a4,0
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    2934:	2705                	addiw	a4,a4,1
                  *--s = (char)(n % 10) + '0';
    2936:	02b7f63b          	remuw	a2,a5,a1
    293a:	0306061b          	addiw	a2,a2,48
    293e:	00ca8023          	sb	a2,0(s5)
                  n /= 10;
    2942:	02b7d63b          	divuw	a2,a5,a1
            while (n) {
    2946:	00fef563          	bgeu	t4,a5,2950 <stbsp_vsprintfcb+0x16c4>
                  *--s = stbsp__comma;
    294a:	1afd                	addi	s5,s5,-1
    294c:	87b2                	mv	a5,a2
    294e:	bfe1                	j	2926 <stbsp_vsprintfcb+0x169a>
            while (n) {
    2950:	4285                	li	t0,1
            if (n64 == 0) {
    2952:	020f0063          	beqz	t5,2972 <stbsp_vsprintfcb+0x16e6>
            while (s != o)
    2956:	fb550ae3          	beq	a0,s5,290a <stbsp_vsprintfcb+0x167e>
                  *--s = stbsp__comma;
    295a:	1afd                	addi	s5,s5,-1
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    295c:	00080663          	beqz	a6,2968 <stbsp_vsprintfcb+0x16dc>
    2960:	08670863          	beq	a4,t1,29f0 <stbsp_vsprintfcb+0x1764>
    2964:	2705                	addiw	a4,a4,1
    2966:	4285                	li	t0,1
                  *--s = '0';
    2968:	03000793          	li	a5,48
    296c:	00fa8023          	sb	a5,0(s5)
    2970:	b7dd                	j	2956 <stbsp_vsprintfcb+0x16ca>
    2972:	00028363          	beqz	t0,2978 <stbsp_vsprintfcb+0x16ec>
    2976:	d0ba                	sw	a4,96(sp)
               if ((s[0] == '0') && (s != (num + STBSP__NUMSZ)))
    2978:	000ac703          	lbu	a4,0(s5)
    297c:	03000793          	li	a5,48
    2980:	34f70b63          	beq	a4,a5,2cd6 <stbsp_vsprintfcb+0x1a4a>
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    2984:	051c                	addi	a5,sp,640
    2986:	415786bb          	subw	a3,a5,s5
         tail[0] = 0;
    298a:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    298e:	080e7713          	andi	a4,t3,128
    2992:	87f2                	mv	a5,t3
    2994:	32070863          	beqz	a4,2cc4 <stbsp_vsprintfcb+0x1a38>
    2998:	678d                	lui	a5,0x3
    299a:	d017879b          	addiw	a5,a5,-767 # 2d01 <stbsp_vsprintfcb+0x1a75>
      sign[0] = 1;
    299e:	06f11423          	sh	a5,104(sp)
    29a2:	4705                	li	a4,1
    29a4:	4a05                	li	s4,1
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    29a6:	d0b6                	sw	a3,96(sp)
         if (l == 0) {
    29a8:	30068163          	beqz	a3,2caa <stbsp_vsprintfcb+0x1a1e>
         cs = l + (3 << 24);
    29ac:	030002b7          	lui	t0,0x3000
    29b0:	00d282bb          	addw	t0,t0,a3
         if (pr < (stbsp__int32)l)
    29b4:	0006861b          	sext.w	a2,a3
         if (pr < 0)
    29b8:	fff8c793          	not	a5,a7
    29bc:	97fd                	srai	a5,a5,0x3f
         if (pr < (stbsp__int32)l)
    29be:	00f8f7b3          	and	a5,a7,a5
    29c2:	0007859b          	sext.w	a1,a5
    29c6:	00c5d363          	bge	a1,a2,29cc <stbsp_vsprintfcb+0x1740>
    29ca:	87b2                	mv	a5,a2
         n = pr + lead[0] + tail[0] + tz;
    29cc:	00f7063b          	addw	a2,a4,a5
    29d0:	8732                	mv	a4,a2
         if (pr < (stbsp__int32)l)
    29d2:	2781                	sext.w	a5,a5
         if ((fl & STBSP__LEFTJUST) == 0) {
    29d4:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    29d8:	835a                	mv	t1,s6
    29da:	00cb5363          	bge	s6,a2,29e0 <stbsp_vsprintfcb+0x1754>
    29de:	8332                	mv	t1,a2
         fw -= n;
    29e0:	40e3033b          	subw	t1,t1,a4
      scopy:
    29e4:	4f81                	li	t6,0
         pr -= l;
    29e6:	40d7873b          	subw	a4,a5,a3
      tz = 0;
    29ea:	4881                	li	a7,0
      scopy:
    29ec:	9e2ff06f          	j	1bce <stbsp_vsprintfcb+0x942>
                  *--s = stbsp__comma;
    29f0:	87de                	mv	a5,s7
                  --o;
    29f2:	157d                	addi	a0,a0,-1
                  l = 0;
    29f4:	4701                	li	a4,0
                  --o;
    29f6:	4285                	li	t0,1
    29f8:	00fa8023          	sb	a5,0(s5)
    29fc:	bfa9                	j	2956 <stbsp_vsprintfcb+0x16ca>
               n = (stbsp__uint32)n64;
    29fe:	000f079b          	sext.w	a5,t5
               n64 = 0;
    2a02:	4f01                	li	t5,0
    2a04:	bf29                	j	291e <stbsp_vsprintfcb+0x1692>
    2a06:	f046                	sd	a7,32(sp)
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    2a08:	03f7f63b          	remuw	a2,a5,t6
                  s -= 2;
    2a0c:	1af9                	addi	s5,s5,-2
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    2a0e:	0007889b          	sext.w	a7,a5
    2a12:	2605                	addiw	a2,a2,1
    2a14:	0016161b          	slliw	a2,a2,0x1
    2a18:	1602                	slli	a2,a2,0x20
    2a1a:	9201                	srli	a2,a2,0x20
    2a1c:	9652                	add	a2,a2,s4
    2a1e:	00065603          	lhu	a2,0(a2)
                  n /= 100;
    2a22:	03f7d7bb          	divuw	a5,a5,t6
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    2a26:	00ca9023          	sh	a2,0(s5)
               } while (n);
    2a2a:	06300613          	li	a2,99
    2a2e:	fd166de3          	bltu	a2,a7,2a08 <stbsp_vsprintfcb+0x177c>
    2a32:	7882                	ld	a7,32(sp)
            if (n64 == 0) {
    2a34:	f20f11e3          	bnez	t5,2956 <stbsp_vsprintfcb+0x16ca>
    2a38:	bf2d                	j	2972 <stbsp_vsprintfcb+0x16e6>
                     *(stbsp__uint32 *)bf = 0x20202020;
    2a3a:	20202b37          	lui	s6,0x20202
                  stbsp__cb_buf_clamp(i, fw);
    2a3e:	854a                	mv	a0,s2
                     *bf++ = ' ';
    2a40:	02000a93          	li	s5,32
                     *(stbsp__uint32 *)bf = 0x20202020;
    2a44:	020b0b13          	addi	s6,s6,32 # 20202020 <_ZSt4cerr+0x201fa868>
                  stbsp__chk_cb_buf(1);
    2a48:	1fe00a13          	li	s4,510
                  stbsp__cb_buf_clamp(i, fw);
    2a4c:	20000b93          	li	s7,512
    2a50:	891a                	mv	s2,t1
    2a52:	0a098063          	beqz	s3,2af2 <stbsp_vsprintfcb+0x1866>
    2a56:	40a40633          	sub	a2,s0,a0
    2a5a:	40cb87bb          	subw	a5,s7,a2
    2a5e:	873e                	mv	a4,a5
    2a60:	00f95363          	bge	s2,a5,2a66 <stbsp_vsprintfcb+0x17da>
    2a64:	874a                	mv	a4,s2
    2a66:	0007079b          	sext.w	a5,a4
                  fw -= i;
    2a6a:	40e9093b          	subw	s2,s2,a4
                  while (i) {
    2a6e:	e799                	bnez	a5,2a7c <stbsp_vsprintfcb+0x17f0>
    2a70:	a281                	j	2bb0 <stbsp_vsprintfcb+0x1924>
                     *bf++ = ' ';
    2a72:	01540023          	sb	s5,0(s0)
                     --i;
    2a76:	37fd                	addiw	a5,a5,-1
                     *bf++ = ' ';
    2a78:	0405                	addi	s0,s0,1
                  while (i) {
    2a7a:	cba1                	beqz	a5,2aca <stbsp_vsprintfcb+0x183e>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    2a7c:	00347713          	andi	a4,s0,3
    2a80:	fb6d                	bnez	a4,2a72 <stbsp_vsprintfcb+0x17e6>
                  while (i >= 4) {
    2a82:	470d                	li	a4,3
    2a84:	40f75363          	bge	a4,a5,2e8a <stbsp_vsprintfcb+0x1bfe>
    2a88:	ffc7869b          	addiw	a3,a5,-4
    2a8c:	0026d79b          	srliw	a5,a3,0x2
    2a90:	0017871b          	addiw	a4,a5,1
    2a94:	070a                	slli	a4,a4,0x2
    2a96:	9722                	add	a4,a4,s0
                     *(stbsp__uint32 *)bf = 0x20202020;
    2a98:	01642023          	sw	s6,0(s0)
                     bf += 4;
    2a9c:	0411                	addi	s0,s0,4
                  while (i >= 4) {
    2a9e:	fee41de3          	bne	s0,a4,2a98 <stbsp_vsprintfcb+0x180c>
    2aa2:	0027979b          	slliw	a5,a5,0x2
    2aa6:	40f687bb          	subw	a5,a3,a5
                  while (i--)
    2aaa:	fff7869b          	addiw	a3,a5,-1
    2aae:	cf91                	beqz	a5,2aca <stbsp_vsprintfcb+0x183e>
    2ab0:	9fa1                	addw	a5,a5,s0
                     *bf++ = ' ';
    2ab2:	0705                	addi	a4,a4,1
                  while (i--)
    2ab4:	0007061b          	sext.w	a2,a4
                     *bf++ = ' ';
    2ab8:	ff570fa3          	sb	s5,-1(a4)
                  while (i--)
    2abc:	fec79be3          	bne	a5,a2,2ab2 <stbsp_vsprintfcb+0x1826>
    2ac0:	2685                	addiw	a3,a3,1
    2ac2:	02069793          	slli	a5,a3,0x20
    2ac6:	9381                	srli	a5,a5,0x20
    2ac8:	943e                	add	s0,s0,a5
                  stbsp__chk_cb_buf(1);
    2aca:	00098f63          	beqz	s3,2ae8 <stbsp_vsprintfcb+0x185c>
    2ace:	40a4063b          	subw	a2,s0,a0
    2ad2:	00ca5b63          	bge	s4,a2,2ae8 <stbsp_vsprintfcb+0x185c>
    2ad6:	65a2                	ld	a1,8(sp)
    2ad8:	e81e                	sd	t2,16(sp)
    2ada:	00cd0d3b          	addw	s10,s10,a2
    2ade:	9982                	jalr	s3
    2ae0:	80050be3          	beqz	a0,22f6 <stbsp_vsprintfcb+0x106a>
    2ae4:	63c2                	ld	t2,16(sp)
    2ae6:	842a                	mv	s0,a0
               while (fw) {
    2ae8:	f60915e3          	bnez	s2,2a52 <stbsp_vsprintfcb+0x17c6>
    2aec:	892a                	mv	s2,a0
    2aee:	f21fe06f          	j	1a0e <stbsp_vsprintfcb+0x782>
                  stbsp__cb_buf_clamp(i, fw);
    2af2:	87ca                	mv	a5,s2
                  fw -= i;
    2af4:	4901                	li	s2,0
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    2af6:	b759                	j	2a7c <stbsp_vsprintfcb+0x17f0>
   } else if (fl & STBSP__LEADINGPLUS) {
    2af8:	002e7713          	andi	a4,t3,2
    2afc:	94070663          	beqz	a4,1c48 <stbsp_vsprintfcb+0x9bc>
      sign[0] = 1;
    2b00:	670d                	lui	a4,0x3
    2b02:	b0170713          	addi	a4,a4,-1279 # 2b01 <stbsp_vsprintfcb+0x1875>
    2b06:	06e11423          	sh	a4,104(sp)
    2b0a:	93eff06f          	j	1c48 <stbsp_vsprintfcb+0x9bc>
      if (((stbsp__uintptr)sn & 3) == 0)
    2b0e:	87d6                	mv	a5,s5
   while (limit >= 4) {
    2b10:	470d                	li	a4,3
    2b12:	22d77763          	bgeu	a4,a3,2d40 <stbsp_vsprintfcb+0x1ab4>
      if ((v - 0x01010101) & (~v) & 0x80808080UL)
    2b16:	feff05b7          	lui	a1,0xfeff0
    2b1a:	80808637          	lui	a2,0x80808
    2b1e:	eff5859b          	addiw	a1,a1,-257 # fffffffffefefeff <_ZSt4cerr+0xfffffffffefe8747>
    2b22:	08060613          	addi	a2,a2,128 # ffffffff80808080 <_ZSt4cerr+0xffffffff808008c8>
   while (limit >= 4) {
    2b26:	480d                	li	a6,3
    2b28:	a029                	j	2b32 <stbsp_vsprintfcb+0x18a6>
      limit -= 4;
    2b2a:	36f1                	addiw	a3,a3,-4
      sn += 4;
    2b2c:	0791                	addi	a5,a5,4
   while (limit >= 4) {
    2b2e:	20d87963          	bgeu	a6,a3,2d40 <stbsp_vsprintfcb+0x1ab4>
      stbsp__uint32 v = *(stbsp__uint32 *)sn;
    2b32:	4398                	lw	a4,0(a5)
      if ((v - 0x01010101) & (~v) & 0x80808080UL)
    2b34:	00b7053b          	addw	a0,a4,a1
    2b38:	fff74713          	not	a4,a4
    2b3c:	8f69                	and	a4,a4,a0
    2b3e:	8f71                	and	a4,a4,a2
    2b40:	2701                	sext.w	a4,a4
    2b42:	d765                	beqz	a4,2b2a <stbsp_vsprintfcb+0x189e>
    2b44:	02069713          	slli	a4,a3,0x20
    2b48:	9301                	srli	a4,a4,0x20
    2b4a:	973e                	add	a4,a4,a5
    2b4c:	a021                	j	2b54 <stbsp_vsprintfcb+0x18c8>
      ++sn;
    2b4e:	0785                	addi	a5,a5,1
   while (limit && *sn) {
    2b50:	00e78663          	beq	a5,a4,2b5c <stbsp_vsprintfcb+0x18d0>
    2b54:	0007c683          	lbu	a3,0(a5)
    2b58:	fafd                	bnez	a3,2b4e <stbsp_vsprintfcb+0x18c2>
    2b5a:	873e                	mv	a4,a5
   return (stbsp__uint32)(sn - s);
    2b5c:	41570733          	sub	a4,a4,s5
    2b60:	0007069b          	sext.w	a3,a4
         if (pr < (stbsp__int32)l)
    2b64:	fff6c793          	not	a5,a3
    2b68:	97fd                	srai	a5,a5,0x3f
    2b6a:	8f7d                	and	a4,a4,a5
    2b6c:	0007079b          	sext.w	a5,a4
         n = pr + lead[0] + tail[0] + tz;
    2b70:	863e                	mv	a2,a5
         pr -= l;
    2b72:	9f15                	subw	a4,a4,a3
   return (stbsp__uint32)(sn - s);
    2b74:	d2eff06f          	j	20a2 <stbsp_vsprintfcb+0xe16>
         for (n = 1; n < l; n++)
    2b78:	4605                	li	a2,1
    2b7a:	aed663e3          	bltu	a2,a3,2660 <stbsp_vsprintfcb+0x13d4>
    2b7e:	0c210613          	addi	a2,sp,194
    2b82:	bcf5                	j	267e <stbsp_vsprintfcb+0x13f2>
            l = pr + 1;
    2b84:	4685                	li	a3,1
         if ((l - 1) > (stbsp__uint32)pr)
    2b86:	4501                	li	a0,0
         *s++ = sn[0];
    2b88:	0c110613          	addi	a2,sp,193
    2b8c:	bccd                	j	267e <stbsp_vsprintfcb+0x13f2>
    2b8e:	4591                	li	a1,4
    2b90:	4f91                	li	t6,4
         n = (dp >= 100) ? 5 : 4;
    2b92:	4e91                	li	t4,4
    2b94:	be21                	j	26ac <stbsp_vsprintfcb+0x1420>
    2b96:	4a85                	li	s5,1
    2b98:	80000737          	lui	a4,0x80000
            pr = 1; // default is 6
    2b9c:	4a05                	li	s4,1
    2b9e:	920ff06f          	j	1cbe <stbsp_vsprintfcb+0xa32>
            dp = (n64) ? -1022 : 0;
    2ba2:	4601                	li	a2,0
    2ba4:	c119                	beqz	a0,2baa <stbsp_vsprintfcb+0x191e>
    2ba6:	c0200613          	li	a2,-1022
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    2baa:	872a                	mv	a4,a0
    2bac:	a3aff06f          	j	1de6 <stbsp_vsprintfcb+0xb5a>
                  stbsp__chk_cb_buf(1);
    2bb0:	2601                	sext.w	a2,a2
    2bb2:	1fe00793          	li	a5,510
    2bb6:	f2c7c0e3          	blt	a5,a2,2ad6 <stbsp_vsprintfcb+0x184a>
    2bba:	bd61                	j	2a52 <stbsp_vsprintfcb+0x17c6>
         tail[0] = (char)n;
    2bbc:	4795                	li	a5,5
            tail[n] = '0' + dp % 10;
    2bbe:	06b10aa3          	sb	a1,117(sp)
         tail[0] = (char)n;
    2bc2:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    2bc6:	4815                	li	a6,5
    2bc8:	4f95                	li	t6,5
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    2bca:	4595                	li	a1,5
    2bcc:	b935                	j	2808 <stbsp_vsprintfcb+0x157c>
                  l = pr + dp;
    2bce:	011786bb          	addw	a3,a5,a7
    2bd2:	d0b6                	sw	a3,96(sp)
    2bd4:	b6d5                	j	27b8 <stbsp_vsprintfcb+0x152c>
            s = (char *)"null";
    2bd6:	00002a97          	auipc	s5,0x2
    2bda:	42aa8a93          	addi	s5,s5,1066 # 5000 <_GLOBAL__sub_I__ZSt3cin+0x52>
    2bde:	c80ff06f          	j	205e <stbsp_vsprintfcb+0xdd2>
   } else if (fl & STBSP__LEADINGPLUS) {
    2be2:	002e7793          	andi	a5,t3,2
    2be6:	1c079c63          	bnez	a5,2dbe <stbsp_vsprintfcb+0x1b32>
   sign[0] = 0;
    2bea:	4689                	li	a3,2
    2bec:	4a09                	li	s4,2
    2bee:	4805                	li	a6,1
    2bf0:	9e8ff06f          	j	1dd8 <stbsp_vsprintfcb+0xb4c>
      sign[0] = 1;
    2bf4:	670d                	lui	a4,0x3
    2bf6:	b0170713          	addi	a4,a4,-1279 # 2b01 <stbsp_vsprintfcb+0x1875>
    2bfa:	06e11423          	sh	a4,104(sp)
    2bfe:	b86ff06f          	j	1f84 <stbsp_vsprintfcb+0xcf8>
               pr = 0;
    2c02:	4881                	li	a7,0
    2c04:	f1ffe06f          	j	1b22 <stbsp_vsprintfcb+0x896>
            *s++ = '0';
    2c08:	03000713          	li	a4,48
    2c0c:	0ce10023          	sb	a4,192(sp)
            if (pr)
    2c10:	1a088c63          	beqz	a7,2dc8 <stbsp_vsprintfcb+0x1b3c>
               *s++ = stbsp__period;
    2c14:	00004717          	auipc	a4,0x4
    2c18:	d7874703          	lbu	a4,-648(a4) # 698c <stbsp__period>
            n = -dp;
    2c1c:	40f007bb          	negw	a5,a5
               *s++ = stbsp__period;
    2c20:	0ce100a3          	sb	a4,193(sp)
            if ((stbsp__int32)n > pr)
    2c24:	0007871b          	sext.w	a4,a5
    2c28:	00e8d363          	bge	a7,a4,2c2e <stbsp_vsprintfcb+0x19a2>
    2c2c:	87c6                	mv	a5,a7
    2c2e:	0007871b          	sext.w	a4,a5
            if ((stbsp__int32)(l + n) > pr)
    2c32:	00d7833b          	addw	t1,a5,a3
    2c36:	883a                	mv	a6,a4
            while (i) {
    2c38:	0c210793          	addi	a5,sp,194
               *s++ = '0';
    2c3c:	03000513          	li	a0,48
            while (i) {
    2c40:	e711                	bnez	a4,2c4c <stbsp_vsprintfcb+0x19c0>
    2c42:	a271                	j	2dce <stbsp_vsprintfcb+0x1b42>
               if ((((stbsp__uintptr)s) & 3) == 0)
    2c44:	0037f613          	andi	a2,a5,3
    2c48:	18060563          	beqz	a2,2dd2 <stbsp_vsprintfcb+0x1b46>
               *s++ = '0';
    2c4c:	85ba                	mv	a1,a4
    2c4e:	00a78023          	sb	a0,0(a5)
               --i;
    2c52:	377d                	addiw	a4,a4,-1
               *s++ = '0';
    2c54:	0785                	addi	a5,a5,1
            while (i) {
    2c56:	f77d                	bnez	a4,2c44 <stbsp_vsprintfcb+0x19b8>
            if ((stbsp__int32)(l + n) > pr)
    2c58:	0003071b          	sext.w	a4,t1
    2c5c:	4108863b          	subw	a2,a7,a6
    2c60:	00e8d563          	bge	a7,a4,2c6a <stbsp_vsprintfcb+0x19de>
               l = pr - n;
    2c64:	0006069b          	sext.w	a3,a2
    2c68:	d0b2                	sw	a2,96(sp)
            while (i) {
    2c6a:	c68d                	beqz	a3,2c94 <stbsp_vsprintfcb+0x1a08>
    2c6c:	7566                	ld	a0,120(sp)
    2c6e:	02069813          	slli	a6,a3,0x20
    2c72:	02085813          	srli	a6,a6,0x20
    2c76:	01078eb3          	add	t4,a5,a6
    2c7a:	85aa                	mv	a1,a0
    2c7c:	873e                	mv	a4,a5
               *s++ = *sn++;
    2c7e:	0005c883          	lbu	a7,0(a1)
    2c82:	0705                	addi	a4,a4,1
            while (i) {
    2c84:	0585                	addi	a1,a1,1
               *s++ = *sn++;
    2c86:	ff170fa3          	sb	a7,-1(a4)
            while (i) {
    2c8a:	ffd71ae3          	bne	a4,t4,2c7e <stbsp_vsprintfcb+0x19f2>
    2c8e:	9542                	add	a0,a0,a6
    2c90:	97c2                	add	a5,a5,a6
    2c92:	fcaa                	sd	a0,120(sp)
         l = (stbsp__uint32)(s - (num + 64));
    2c94:	0c010a93          	addi	s5,sp,192
            cs = 1 + (3 << 24); // how many tens did we write (for commas below)
    2c98:	030002b7          	lui	t0,0x3000
            tz = pr - (n + l);
    2c9c:	40d608bb          	subw	a7,a2,a3
         l = (stbsp__uint32)(s - (num + 64));
    2ca0:	415787b3          	sub	a5,a5,s5
            cs = 1 + (3 << 24); // how many tens did we write (for commas below)
    2ca4:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff8849>
    2ca6:	fbcff06f          	j	2462 <stbsp_vsprintfcb+0x11d6>
            *--s = '0';
    2caa:	03000793          	li	a5,48
    2cae:	fefa8fa3          	sb	a5,-1(s5)
            l = 1;
    2cb2:	030002b7          	lui	t0,0x3000
    2cb6:	4785                	li	a5,1
    2cb8:	d0be                	sw	a5,96(sp)
            *--s = '0';
    2cba:	1afd                	addi	s5,s5,-1
            l = 1;
    2cbc:	4605                	li	a2,1
    2cbe:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff8849>
    2cc0:	4685                	li	a3,1
    2cc2:	b9dd                	j	29b8 <stbsp_vsprintfcb+0x172c>
   } else if (fl & STBSP__LEADINGSPACE) {
    2cc4:	004e7713          	andi	a4,t3,4
    2cc8:	e74d                	bnez	a4,2d72 <stbsp_vsprintfcb+0x1ae6>
   } else if (fl & STBSP__LEADINGPLUS) {
    2cca:	8b89                	andi	a5,a5,2
    2ccc:	efd9                	bnez	a5,2d6a <stbsp_vsprintfcb+0x1ade>
   sign[0] = 0;
    2cce:	06010423          	sb	zero,104(sp)
    2cd2:	4a01                	li	s4,0
    2cd4:	b9c9                	j	29a6 <stbsp_vsprintfcb+0x171a>
               if ((s[0] == '0') && (s != (num + STBSP__NUMSZ)))
    2cd6:	051c                	addi	a5,sp,640
    2cd8:	cafa89e3          	beq	s5,a5,298a <stbsp_vsprintfcb+0x16fe>
                  ++s;
    2cdc:	0a85                	addi	s5,s5,1
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    2cde:	415786bb          	subw	a3,a5,s5
    2ce2:	b165                	j	298a <stbsp_vsprintfcb+0x16fe>
                  n = dp - n;
    2ce4:	40ce87bb          	subw	a5,t4,a2
                  if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    2ce8:	12030e63          	beqz	t1,2e24 <stbsp_vsprintfcb+0x1b98>
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2cec:	4511                	li	a0,4
    2cee:	03000613          	li	a2,48
                        *s++ = stbsp__comma;
    2cf2:	00170693          	addi	a3,a4,1
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2cf6:	00030563          	beqz	t1,2d00 <stbsp_vsprintfcb+0x1a74>
    2cfa:	2585                	addiw	a1,a1,1
    2cfc:	00a58963          	beq	a1,a0,2d0e <stbsp_vsprintfcb+0x1a82>
    2d00:	8736                	mv	a4,a3
                        --n;
    2d02:	37fd                	addiw	a5,a5,-1
    2d04:	fec70fa3          	sb	a2,-1(a4)
                  while (n) {
    2d08:	f7ed                	bnez	a5,2cf2 <stbsp_vsprintfcb+0x1a66>
    2d0a:	f38ff06f          	j	2442 <stbsp_vsprintfcb+0x11b6>
    2d0e:	fe568fa3          	sb	t0,-1(a3)
                        *s++ = stbsp__comma;
    2d12:	0709                	addi	a4,a4,2
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2d14:	4585                	li	a1,1
    2d16:	b7f5                	j	2d02 <stbsp_vsprintfcb+0x1a76>
   sign[0] = 0;
    2d18:	06010423          	sb	zero,104(sp)
    2d1c:	f1dfe06f          	j	1c38 <stbsp_vsprintfcb+0x9ac>
                     tail[idx + 1] = "_kMGT"[fl >> 24];
    2d20:	00002697          	auipc	a3,0x2
    2d24:	2f068693          	addi	a3,a3,752 # 5010 <_GLOBAL__sub_I__ZSt3cin+0x62>
    2d28:	9736                	add	a4,a4,a3
    2d2a:	00074683          	lbu	a3,0(a4)
    2d2e:	1088                	addi	a0,sp,96
    2d30:	22060713          	addi	a4,a2,544
    2d34:	972a                	add	a4,a4,a0
    2d36:	ded70823          	sb	a3,-528(a4)
                  idx++;
    2d3a:	8fb2                	mv	t6,a2
    2d3c:	fb0ff06f          	j	24ec <stbsp_vsprintfcb+0x1260>
   while (limit && *sn) {
    2d40:	e00692e3          	bnez	a3,2b44 <stbsp_vsprintfcb+0x18b8>
    2d44:	bd19                	j	2b5a <stbsp_vsprintfcb+0x18ce>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    2d46:	0008071b          	sext.w	a4,a6
    2d4a:	86c2                	mv	a3,a6
    2d4c:	88d2                	mv	a7,s4
            pr = -dp + ((pr > (stbsp__int32)l) ? (stbsp__int32) l : pr);
    2d4e:	863a                	mv	a2,a4
    2d50:	00e8d363          	bge	a7,a4,2d56 <stbsp_vsprintfcb+0x1aca>
    2d54:	8646                	mv	a2,a7
    2d56:	40f608bb          	subw	a7,a2,a5
    2d5a:	814ff06f          	j	1d6e <stbsp_vsprintfcb+0xae2>
            divisor = 1000.0f;
    2d5e:	00003797          	auipc	a5,0x3
    2d62:	a527b787          	fld	fa5,-1454(a5) # 57b0 <STDIN_FD+0x28>
    2d66:	dd5fe06f          	j	1b3a <stbsp_vsprintfcb+0x8ae>
    2d6a:	678d                	lui	a5,0x3
    2d6c:	b017879b          	addiw	a5,a5,-1279 # 2b01 <stbsp_vsprintfcb+0x1875>
    2d70:	b13d                	j	299e <stbsp_vsprintfcb+0x1712>
    2d72:	6789                	lui	a5,0x2
    2d74:	2785                	addiw	a5,a5,1 # 2001 <stbsp_vsprintfcb+0xd75>
    2d76:	b125                	j	299e <stbsp_vsprintfcb+0x1712>
            *s++ = stbsp__period;
    2d78:	00004517          	auipc	a0,0x4
    2d7c:	c1454503          	lbu	a0,-1004(a0) # 698c <stbsp__period>
         sn = s;
    2d80:	0c210793          	addi	a5,sp,194
         n = pr;
    2d84:	0008869b          	sext.w	a3,a7
            *s++ = stbsp__period;
    2d88:	0ca100a3          	sb	a0,193(sp)
         sn = s;
    2d8c:	fcbe                	sd	a5,120(sp)
         if (n > 13)
    2d8e:	4535                	li	a0,13
         n64 <<= 4;
    2d90:	0712                	slli	a4,a4,0x4
         if (n > 13)
    2d92:	8836                	mv	a6,a3
    2d94:	00d57363          	bgeu	a0,a3,2d9a <stbsp_vsprintfcb+0x1b0e>
    2d98:	4835                	li	a6,13
    2d9a:	0008051b          	sext.w	a0,a6
         while (n--) {
    2d9e:	387d                	addiw	a6,a6,-1
         if (pr > (stbsp__int32)n)
    2da0:	af1542e3          	blt	a0,a7,2884 <stbsp_vsprintfcb+0x15f8>
      tz = 0;
    2da4:	4881                	li	a7,0
    2da6:	b4cd                	j	2888 <stbsp_vsprintfcb+0x15fc>
               while (n < l) {
    2da8:	87ba                	mv	a5,a4
    2daa:	bc1d                	j	27e0 <stbsp_vsprintfcb+0x1554>
         tail[0] = (char)n;
    2dac:	478d                	li	a5,3
    2dae:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    2db2:	06b109a3          	sb	a1,115(sp)
    2db6:	480d                	li	a6,3
    2db8:	4f8d                	li	t6,3
    2dba:	8e4ff06f          	j	1e9e <stbsp_vsprintfcb+0xc12>
    2dbe:	678d                	lui	a5,0x3
    2dc0:	b017879b          	addiw	a5,a5,-1279 # 2b01 <stbsp_vsprintfcb+0x1875>
    2dc4:	80aff06f          	j	1dce <stbsp_vsprintfcb+0xb42>
            if (pr)
    2dc8:	8336                	mv	t1,a3
            *s++ = '0';
    2dca:	0c110793          	addi	a5,sp,193
            while (i) {
    2dce:	4801                	li	a6,0
    2dd0:	b561                	j	2c58 <stbsp_vsprintfcb+0x19cc>
            while (i >= 4) {
    2dd2:	460d                	li	a2,3
    2dd4:	04e65663          	bge	a2,a4,2e20 <stbsp_vsprintfcb+0x1b94>
    2dd8:	ffb5871b          	addiw	a4,a1,-5
    2ddc:	0027559b          	srliw	a1,a4,0x2
    2de0:	0015861b          	addiw	a2,a1,1
    2de4:	060a                	slli	a2,a2,0x2
               *(stbsp__uint32 *)s = 0x30303030;
    2de6:	30303537          	lui	a0,0x30303
    2dea:	963e                	add	a2,a2,a5
    2dec:	03050513          	addi	a0,a0,48 # 30303030 <_ZSt4cerr+0x302fb878>
    2df0:	c388                	sw	a0,0(a5)
               s += 4;
    2df2:	0791                	addi	a5,a5,4
            while (i >= 4) {
    2df4:	fef61ee3          	bne	a2,a5,2df0 <stbsp_vsprintfcb+0x1b64>
    2df8:	0025959b          	slliw	a1,a1,0x2
    2dfc:	9f0d                	subw	a4,a4,a1
            while (i) {
    2dfe:	e4070de3          	beqz	a4,2c58 <stbsp_vsprintfcb+0x19cc>
               *s++ = '0';
    2e02:	03000513          	li	a0,48
            while (i) {
    2e06:	00f705bb          	addw	a1,a4,a5
               *s++ = '0';
    2e0a:	0605                	addi	a2,a2,1
            while (i) {
    2e0c:	00060e9b          	sext.w	t4,a2
               *s++ = '0';
    2e10:	fea60fa3          	sb	a0,-1(a2)
            while (i) {
    2e14:	ffd59be3          	bne	a1,t4,2e0a <stbsp_vsprintfcb+0x1b7e>
    2e18:	1702                	slli	a4,a4,0x20
    2e1a:	9301                	srli	a4,a4,0x20
    2e1c:	97ba                	add	a5,a5,a4
    2e1e:	bd2d                	j	2c58 <stbsp_vsprintfcb+0x19cc>
            while (i >= 4) {
    2e20:	863e                	mv	a2,a5
    2e22:	b7c5                	j	2e02 <stbsp_vsprintfcb+0x1b76>
                        if ((((stbsp__uintptr)s) & 3) == 0)
    2e24:	00377693          	andi	a3,a4,3
    2e28:	ce81                	beqz	a3,2e40 <stbsp_vsprintfcb+0x1bb4>
                        *s++ = '0';
    2e2a:	03000693          	li	a3,48
    2e2e:	00d70023          	sb	a3,0(a4)
                        --n;
    2e32:	37fd                	addiw	a5,a5,-1
                        *s++ = '0';
    2e34:	0705                	addi	a4,a4,1
                     while (n) {
    2e36:	e0078663          	beqz	a5,2442 <stbsp_vsprintfcb+0x11b6>
                        if ((((stbsp__uintptr)s) & 3) == 0)
    2e3a:	00377613          	andi	a2,a4,3
    2e3e:	fa65                	bnez	a2,2e2e <stbsp_vsprintfcb+0x1ba2>
                     while (n >= 4) {
    2e40:	468d                	li	a3,3
    2e42:	eaf6f5e3          	bgeu	a3,a5,2cec <stbsp_vsprintfcb+0x1a60>
    2e46:	ffc7869b          	addiw	a3,a5,-4
    2e4a:	0026d69b          	srliw	a3,a3,0x2
    2e4e:	2685                	addiw	a3,a3,1
    2e50:	068a                	slli	a3,a3,0x2
                        *(stbsp__uint32 *)s = 0x30303030;
    2e52:	30303637          	lui	a2,0x30303
    2e56:	96ba                	add	a3,a3,a4
    2e58:	03060613          	addi	a2,a2,48 # 30303030 <_ZSt4cerr+0x302fb878>
    2e5c:	c310                	sw	a2,0(a4)
                        s += 4;
    2e5e:	0711                	addi	a4,a4,4
                     while (n >= 4) {
    2e60:	fed71ee3          	bne	a4,a3,2e5c <stbsp_vsprintfcb+0x1bd0>
    2e64:	8b8d                	andi	a5,a5,3
                  while (n) {
    2e66:	e80793e3          	bnez	a5,2cec <stbsp_vsprintfcb+0x1a60>
    2e6a:	dd8ff06f          	j	2442 <stbsp_vsprintfcb+0x11b6>
      if (((stbsp__uintptr)sn & 3) == 0)
    2e6e:	87d6                	mv	a5,s5
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    2e70:	56fd                	li	a3,-1
    2e72:	b155                	j	2b16 <stbsp_vsprintfcb+0x188a>
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    2e74:	5775                	li	a4,-3
    2e76:	00e7ce63          	blt	a5,a4,2e92 <stbsp_vsprintfcb+0x1c06>
    2e7a:	f6fa4663          	blt	s4,a5,25e6 <stbsp_vsprintfcb+0x135a>
         if (dp > 0) {
    2e7e:	ecf054e3          	blez	a5,2d46 <stbsp_vsprintfcb+0x1aba>
    2e82:	86c2                	mv	a3,a6
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    2e84:	4881                	li	a7,0
    2e86:	ee9fe06f          	j	1d6e <stbsp_vsprintfcb+0xae2>
                  while (i--)
    2e8a:	fff7869b          	addiw	a3,a5,-1
    2e8e:	8722                	mv	a4,s0
    2e90:	b105                	j	2ab0 <stbsp_vsprintfcb+0x1824>
            if (pr > (stbsp__int32)l)
    2e92:	0008071b          	sext.w	a4,a6
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2e96:	7ae6                	ld	s5,120(sp)
            if (pr > (stbsp__int32)l)
    2e98:	86c2                	mv	a3,a6
    2e9a:	88d2                	mv	a7,s4
    2e9c:	f7475d63          	bge	a4,s4,2616 <stbsp_vsprintfcb+0x138a>
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2ea0:	8542                	mv	a0,a6
    2ea2:	f56ff06f          	j	25f8 <stbsp_vsprintfcb+0x136c>

0000000000002ea6 <stbsp_sprintf>:
{
    2ea6:	715d                	addi	sp,sp,-80
   va_start(va, fmt);
    2ea8:	02010313          	addi	t1,sp,32
{
    2eac:	f032                	sd	a2,32(sp)
    2eae:	f436                	sd	a3,40(sp)
    2eb0:	f83a                	sd	a4,48(sp)
   result = STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    2eb2:	86ae                	mv	a3,a1
    2eb4:	862a                	mv	a2,a0
    2eb6:	871a                	mv	a4,t1
    2eb8:	4581                	li	a1,0
    2eba:	4501                	li	a0,0
{
    2ebc:	ec06                	sd	ra,24(sp)
    2ebe:	fc3e                	sd	a5,56(sp)
    2ec0:	e0c2                	sd	a6,64(sp)
    2ec2:	e4c6                	sd	a7,72(sp)
   va_start(va, fmt);
    2ec4:	e41a                	sd	t1,8(sp)
   result = STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    2ec6:	bc6fe0ef          	jal	128c <stbsp_vsprintfcb>
}
    2eca:	60e2                	ld	ra,24(sp)
    2ecc:	6161                	addi	sp,sp,80
    2ece:	8082                	ret

0000000000002ed0 <stbsp_vsnprintf>:
{
    2ed0:	dd010113          	addi	sp,sp,-560
    2ed4:	22813023          	sd	s0,544(sp)
    2ed8:	20913c23          	sd	s1,536(sp)
    2edc:	22113423          	sd	ra,552(sp)
    2ee0:	84ae                	mv	s1,a1
    2ee2:	842a                	mv	s0,a0
    2ee4:	88b2                	mv	a7,a2
    2ee6:	8736                	mv	a4,a3
   if ( (count == 0) && !buf )
    2ee8:	e591                	bnez	a1,2ef4 <stbsp_vsnprintf+0x24>
    2eea:	c141                	beqz	a0,2f6a <stbsp_vsnprintf+0x9a>
      c.buf = buf;
    2eec:	e02a                	sd	a0,0(sp)
      c.count = count;
    2eee:	e402                	sd	zero,8(sp)
   return (c->count >= STB_SPRINTF_MIN) ? c->buf : c->tmp; // go direct into buffer if you can
    2ef0:	0810                	addi	a2,sp,16
    2ef2:	a089                	j	2f34 <stbsp_vsnprintf+0x64>
   if (len > c->count)
    2ef4:	0015a593          	slti	a1,a1,1
    2ef8:	40b005bb          	negw	a1,a1
    2efc:	8de5                	and	a1,a1,s1
      c.buf = buf;
    2efe:	e02a                	sd	a0,0(sp)
      c.count = count;
    2f00:	c426                	sw	s1,8(sp)
      c.length = 0;
    2f02:	c602                	sw	zero,12(sp)
   if (len > c->count)
    2f04:	2581                	sext.w	a1,a1
   if (len) {
    2f06:	0804d663          	bgez	s1,2f92 <stbsp_vsnprintf+0xc2>
         s = buf;
    2f0a:	4781                	li	a5,0
      if (buf != c->buf) {
    2f0c:	c911                	beqz	a0,2f20 <stbsp_vsnprintf+0x50>
            *d++ = *s++;
    2f0e:	0007c803          	lbu	a6,0(a5)
    2f12:	0785                	addi	a5,a5,1
    2f14:	00f40533          	add	a0,s0,a5
    2f18:	ff050fa3          	sb	a6,-1(a0)
         } while (s < se);
    2f1c:	feb7e9e3          	bltu	a5,a1,2f0e <stbsp_vsnprintf+0x3e>
      c->count -= len;
    2f20:	40b486bb          	subw	a3,s1,a1
      c->buf += len;
    2f24:	95a2                	add	a1,a1,s0
    2f26:	e02e                	sd	a1,0(sp)
      c->count -= len;
    2f28:	c436                	sw	a3,8(sp)
   return (c->count >= STB_SPRINTF_MIN) ? c->buf : c->tmp; // go direct into buffer if you can
    2f2a:	1ff00793          	li	a5,511
    2f2e:	fcd7d1e3          	bge	a5,a3,2ef0 <stbsp_vsnprintf+0x20>
    2f32:	6602                	ld	a2,0(sp)
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__clamp_callback, &c, stbsp__clamp_callback(0,&c,0), fmt, va );
    2f34:	86c6                	mv	a3,a7
    2f36:	858a                	mv	a1,sp
    2f38:	ffffd517          	auipc	a0,0xffffd
    2f3c:	21650513          	addi	a0,a0,534 # 14e <stbsp__clamp_callback>
    2f40:	b4cfe0ef          	jal	128c <stbsp_vsprintfcb>
      l = (int)( c.buf - buf );
    2f44:	6782                	ld	a5,0(sp)
    2f46:	9f81                	subw	a5,a5,s0
      if ( l >= count ) // should never be greater, only equal (or less) than count
    2f48:	0097c463          	blt	a5,s1,2f50 <stbsp_vsnprintf+0x80>
         l = count - 1;
    2f4c:	fff4879b          	addiw	a5,s1,-1
      buf[l] = 0;
    2f50:	943e                	add	s0,s0,a5
    2f52:	00040023          	sb	zero,0(s0)
}
    2f56:	22813083          	ld	ra,552(sp)
    2f5a:	22013403          	ld	s0,544(sp)
    2f5e:	4532                	lw	a0,12(sp)
    2f60:	21813483          	ld	s1,536(sp)
    2f64:	23010113          	addi	sp,sp,560
    2f68:	8082                	ret
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__count_clamp_callback, &c, c.tmp, fmt, va );
    2f6a:	86b2                	mv	a3,a2
    2f6c:	858a                	mv	a1,sp
    2f6e:	0810                	addi	a2,sp,16
    2f70:	ffffd517          	auipc	a0,0xffffd
    2f74:	22c50513          	addi	a0,a0,556 # 19c <stbsp__count_clamp_callback>
      c.length = 0;
    2f78:	c602                	sw	zero,12(sp)
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__count_clamp_callback, &c, c.tmp, fmt, va );
    2f7a:	b12fe0ef          	jal	128c <stbsp_vsprintfcb>
}
    2f7e:	22813083          	ld	ra,552(sp)
    2f82:	22013403          	ld	s0,544(sp)
    2f86:	4532                	lw	a0,12(sp)
    2f88:	21813483          	ld	s1,536(sp)
    2f8c:	23010113          	addi	sp,sp,560
    2f90:	8082                	ret
    2f92:	86a6                	mv	a3,s1
    2f94:	bf59                	j	2f2a <stbsp_vsnprintf+0x5a>

0000000000002f96 <stbsp_snprintf>:
{
    2f96:	715d                	addi	sp,sp,-80
   va_start(va, fmt);
    2f98:	02810313          	addi	t1,sp,40
{
    2f9c:	f436                	sd	a3,40(sp)
   result = STB_SPRINTF_DECORATE(vsnprintf)(buf, count, fmt, va);
    2f9e:	869a                	mv	a3,t1
{
    2fa0:	ec06                	sd	ra,24(sp)
    2fa2:	f83a                	sd	a4,48(sp)
    2fa4:	fc3e                	sd	a5,56(sp)
    2fa6:	e0c2                	sd	a6,64(sp)
    2fa8:	e4c6                	sd	a7,72(sp)
   va_start(va, fmt);
    2faa:	e41a                	sd	t1,8(sp)
   result = STB_SPRINTF_DECORATE(vsnprintf)(buf, count, fmt, va);
    2fac:	f25ff0ef          	jal	2ed0 <stbsp_vsnprintf>
}
    2fb0:	60e2                	ld	ra,24(sp)
    2fb2:	6161                	addi	sp,sp,80
    2fb4:	8082                	ret

0000000000002fb6 <stbsp_vsprintf>:
{
    2fb6:	86ae                	mv	a3,a1
    2fb8:	8732                	mv	a4,a2
   return STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    2fba:	4581                	li	a1,0
    2fbc:	862a                	mv	a2,a0
    2fbe:	4501                	li	a0,0
    2fc0:	accfe06f          	j	128c <stbsp_vsprintfcb>

0000000000002fc4 <sprintf>:
{
    2fc4:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    2fc6:	05010313          	addi	t1,sp,80
{
    2fca:	e0a2                	sd	s0,64(sp)
    2fcc:	fc26                	sd	s1,56(sp)
    2fce:	842a                	mv	s0,a0
    2fd0:	e8b2                	sd	a2,80(sp)
    _vprintf_core(&ctx, format, ap);
    2fd2:	0808                	addi	a0,sp,16
    ctx.limit = size;
    2fd4:	54fd                	li	s1,-1
    _vprintf_core(&ctx, format, ap);
    2fd6:	861a                	mv	a2,t1
{
    2fd8:	e486                	sd	ra,72(sp)
    2fda:	ecb6                	sd	a3,88(sp)
    2fdc:	f0ba                	sd	a4,96(sp)
    2fde:	f4be                	sd	a5,104(sp)
    2fe0:	f8c2                	sd	a6,112(sp)
    2fe2:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    2fe4:	e41a                	sd	t1,8(sp)
    ctx.buf = str;
    2fe6:	e822                	sd	s0,16(sp)
    ctx.limit = size;
    2fe8:	ec26                	sd	s1,24(sp)
    ctx.written = 0;
    2fea:	f002                	sd	zero,32(sp)
    ctx.stream = NULL;
    2fec:	f402                	sd	zero,40(sp)
    _vprintf_core(&ctx, format, ap);
    2fee:	02c000ef          	jal	301a <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    2ff2:	7502                	ld	a0,32(sp)
    2ff4:	00950b63          	beq	a0,s1,300a <sprintf+0x46>
            str[ctx.written] = '\0';
    2ff8:	942a                	add	s0,s0,a0
    2ffa:	00040023          	sb	zero,0(s0)
}
    2ffe:	60a6                	ld	ra,72(sp)
    3000:	6406                	ld	s0,64(sp)
    3002:	74e2                	ld	s1,56(sp)
    3004:	2501                	sext.w	a0,a0
    3006:	6109                	addi	sp,sp,128
    3008:	8082                	ret
            str[size - 1] = '\0';
    300a:	fe040f23          	sb	zero,-2(s0)
}
    300e:	60a6                	ld	ra,72(sp)
    3010:	6406                	ld	s0,64(sp)
    3012:	74e2                	ld	s1,56(sp)
    3014:	2501                	sext.w	a0,a0
    3016:	6109                	addi	sp,sp,128
    3018:	8082                	ret

000000000000301a <_vprintf_core.constprop.0.isra.0>:
static int _vprintf_core(_OutContext *ctx, const char *format, va_list ap)
    301a:	7129                	addi	sp,sp,-320
    301c:	edee                	sd	s11,216(sp)
    301e:	fe06                	sd	ra,312(sp)
    3020:	8dae                	mv	s11,a1
    while (*p)
    3022:	0005c583          	lbu	a1,0(a1)
    3026:	cde9                	beqz	a1,3100 <_vprintf_core.constprop.0.isra.0+0xe6>
    3028:	f626                	sd	s1,296(sp)
    302a:	f24a                	sd	s2,288(sp)
    302c:	ee4e                	sd	s3,280(sp)
    302e:	e656                	sd	s5,264(sp)
    3030:	f9e2                	sd	s8,240(sp)
    3032:	fa22                	sd	s0,304(sp)
    3034:	ea52                	sd	s4,272(sp)
    3036:	e25a                	sd	s6,256(sp)
    3038:	fdde                	sd	s7,248(sp)
    303a:	f5e6                	sd	s9,232(sp)
    303c:	f1ea                	sd	s10,224(sp)
    303e:	84aa                	mv	s1,a0
    3040:	8c32                	mv	s8,a2
        if (*p != '%')
    3042:	02500a93          	li	s5,37
    3046:	49c1                	li	s3,16
    3048:	00002917          	auipc	s2,0x2
    304c:	29c90913          	addi	s2,s2,668 # 52e4 <_GLOBAL__sub_I__ZSt3cin+0x336>
    3050:	a039                	j	305e <_vprintf_core.constprop.0.isra.0+0x44>
                _out_char(ctx, spec);
    3052:	8526                	mv	a0,s1
    3054:	952fe0ef          	jal	11a6 <_out_char>
    while (*p)
    3058:	000dc583          	lbu	a1,0(s11)
    305c:	c5d9                	beqz	a1,30ea <_vprintf_core.constprop.0.isra.0+0xd0>
            _out_char(ctx, *p++);
    305e:	0d85                	addi	s11,s11,1
        if (*p != '%')
    3060:	ff5599e3          	bne	a1,s5,3052 <_vprintf_core.constprop.0.isra.0+0x38>
        int flag_left = 0, flag_zero = 0, flag_plus = 0, flag_space = 0, flag_hash = 0;
    3064:	4501                	li	a0,0
    3066:	4881                	li	a7,0
    3068:	4581                	li	a1,0
    306a:	4b01                	li	s6,0
    306c:	4a01                	li	s4,0
            if (*p == '-')
    306e:	000dcc83          	lbu	s9,0(s11)
    3072:	fe0c871b          	addiw	a4,s9,-32
    3076:	0ff77713          	zext.b	a4,a4
    307a:	00e9e763          	bltu	s3,a4,3088 <_vprintf_core.constprop.0.isra.0+0x6e>
    307e:	070a                	slli	a4,a4,0x2
    3080:	974a                	add	a4,a4,s2
    3082:	4318                	lw	a4,0(a4)
    3084:	974a                	add	a4,a4,s2
    3086:	8702                	jr	a4
        if (*p == '*')
    3088:	02a00793          	li	a5,42
    308c:	16fc9c63          	bne	s9,a5,3204 <_vprintf_core.constprop.0.isra.0+0x1ea>
            width = va_arg(ap, int);
    3090:	000c2403          	lw	s0,0(s8)
    3094:	0c21                	addi	s8,s8,8
            if (width < 0)
    3096:	00045563          	bgez	s0,30a0 <_vprintf_core.constprop.0.isra.0+0x86>
                width = -width;
    309a:	4080043b          	negw	s0,s0
                flag_left = 1;
    309e:	4a05                	li	s4,1
            while (*p >= '0' && *p <= '9')
    30a0:	001dcc83          	lbu	s9,1(s11)
            p++;
    30a4:	0d85                	addi	s11,s11,1
        if (*p == '.')
    30a6:	02e00793          	li	a5,46
        int precision = -1;
    30aa:	5bfd                	li	s7,-1
        if (*p == '.')
    30ac:	18fc8a63          	beq	s9,a5,3240 <_vprintf_core.constprop.0.isra.0+0x226>
        if (*p == 'l')
    30b0:	06c00693          	li	a3,108
    30b4:	8666                	mv	a2,s9
    30b6:	1adc8663          	beq	s9,a3,3262 <_vprintf_core.constprop.0.isra.0+0x248>
        else if (*p == 'z')
    30ba:	07a00693          	li	a3,122
            p++;
    30be:	0d85                	addi	s11,s11,1
        else if (*p == 'z')
    30c0:	24dc8163          	beq	s9,a3,3302 <_vprintf_core.constprop.0.isra.0+0x2e8>
        if (!spec)
    30c4:	06400693          	li	a3,100
    30c8:	4adc8163          	beq	s9,a3,356a <_vprintf_core.constprop.0.isra.0+0x550>
    30cc:	06400693          	li	a3,100
        int len_mod = 0;
    30d0:	4e81                	li	t4,0
    30d2:	1b96e663          	bltu	a3,s9,327e <_vprintf_core.constprop.0.isra.0+0x264>
    30d6:	04700693          	li	a3,71
    30da:	2796e463          	bltu	a3,s9,3342 <_vprintf_core.constprop.0.isra.0+0x328>
    30de:	04400693          	li	a3,68
    30e2:	0596e363          	bltu	a3,s9,3128 <_vprintf_core.constprop.0.isra.0+0x10e>
    30e6:	240c9363          	bnez	s9,332c <_vprintf_core.constprop.0.isra.0+0x312>
    30ea:	7452                	ld	s0,304(sp)
    30ec:	74b2                	ld	s1,296(sp)
    30ee:	7912                	ld	s2,288(sp)
    30f0:	69f2                	ld	s3,280(sp)
    30f2:	6a52                	ld	s4,272(sp)
    30f4:	6ab2                	ld	s5,264(sp)
    30f6:	6b12                	ld	s6,256(sp)
    30f8:	7bee                	ld	s7,248(sp)
    30fa:	7c4e                	ld	s8,240(sp)
    30fc:	7cae                	ld	s9,232(sp)
    30fe:	7d0e                	ld	s10,224(sp)
}
    3100:	70f2                	ld	ra,312(sp)
    3102:	6dee                	ld	s11,216(sp)
    3104:	6131                	addi	sp,sp,320
    3106:	8082                	ret
            if (*p == '-')
    3108:	4585                	li	a1,1
            p++;
    310a:	0d85                	addi	s11,s11,1
            if (*p == '-')
    310c:	b78d                	j	306e <_vprintf_core.constprop.0.isra.0+0x54>
    310e:	4505                	li	a0,1
            p++;
    3110:	0d85                	addi	s11,s11,1
        while (1)
    3112:	bfb1                	j	306e <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    3114:	4885                	li	a7,1
            p++;
    3116:	0d85                	addi	s11,s11,1
        while (1)
    3118:	bf99                	j	306e <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    311a:	4b05                	li	s6,1
            p++;
    311c:	0d85                	addi	s11,s11,1
        while (1)
    311e:	bf81                	j	306e <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    3120:	4a05                	li	s4,1
            p++;
    3122:	0d85                	addi	s11,s11,1
        while (1)
    3124:	b7a9                	j	306e <_vprintf_core.constprop.0.isra.0+0x54>
        char spec = *p++;
    3126:	8dbe                	mv	s11,a5
            fmt_tmp[f_idx++] = '%';
    3128:	02500693          	li	a3,37
    312c:	02d10823          	sb	a3,48(sp)
    3130:	4d05                	li	s10,1
            if (flag_left)
    3132:	000a0763          	beqz	s4,3140 <_vprintf_core.constprop.0.isra.0+0x126>
                fmt_tmp[f_idx++] = '-';
    3136:	02d00693          	li	a3,45
    313a:	02d108a3          	sb	a3,49(sp)
    313e:	4d09                	li	s10,2
            if (flag_zero)
    3140:	000b0c63          	beqz	s6,3158 <_vprintf_core.constprop.0.isra.0+0x13e>
                fmt_tmp[f_idx++] = '0';
    3144:	0c0d0793          	addi	a5,s10,192
    3148:	0818                	addi	a4,sp,16
    314a:	00e786b3          	add	a3,a5,a4
    314e:	03000613          	li	a2,48
    3152:	f6c68023          	sb	a2,-160(a3)
    3156:	2d05                	addiw	s10,s10,1
            if (flag_plus)
    3158:	c999                	beqz	a1,316e <_vprintf_core.constprop.0.isra.0+0x154>
                fmt_tmp[f_idx++] = '+';
    315a:	0c0d0793          	addi	a5,s10,192
    315e:	0818                	addi	a4,sp,16
    3160:	00e786b3          	add	a3,a5,a4
    3164:	02b00613          	li	a2,43
    3168:	f6c68023          	sb	a2,-160(a3)
    316c:	2d05                	addiw	s10,s10,1
            if (flag_space)
    316e:	00088c63          	beqz	a7,3186 <_vprintf_core.constprop.0.isra.0+0x16c>
                fmt_tmp[f_idx++] = ' ';
    3172:	0c0d0793          	addi	a5,s10,192
    3176:	0818                	addi	a4,sp,16
    3178:	00e786b3          	add	a3,a5,a4
    317c:	02000613          	li	a2,32
    3180:	f6c68023          	sb	a2,-160(a3)
    3184:	2d05                	addiw	s10,s10,1
            if (flag_hash)
    3186:	c919                	beqz	a0,319c <_vprintf_core.constprop.0.isra.0+0x182>
                fmt_tmp[f_idx++] = '#';
    3188:	0c0d0793          	addi	a5,s10,192
    318c:	0818                	addi	a4,sp,16
    318e:	00e786b3          	add	a3,a5,a4
    3192:	02300613          	li	a2,35
    3196:	f6c68023          	sb	a2,-160(a3)
    319a:	2d05                	addiw	s10,s10,1
            if (width > 0)
    319c:	03010a13          	addi	s4,sp,48
    31a0:	28804563          	bgtz	s0,342a <_vprintf_core.constprop.0.isra.0+0x410>
            if (precision >= 0)
    31a4:	260bd763          	bgez	s7,3412 <_vprintf_core.constprop.0.isra.0+0x3f8>
            fmt_tmp[f_idx++] = spec;
    31a8:	0c0d0793          	addi	a5,s10,192
    31ac:	0818                	addi	a4,sp,16
    31ae:	00e78633          	add	a2,a5,a4
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    31b2:	000c3683          	ld	a3,0(s8)
            fmt_tmp[f_idx] = '\0';
    31b6:	001d071b          	addiw	a4,s10,1
    31ba:	0c070793          	addi	a5,a4,192
    31be:	0818                	addi	a4,sp,16
            fmt_tmp[f_idx++] = spec;
    31c0:	f7960023          	sb	s9,-160(a2)
            fmt_tmp[f_idx] = '\0';
    31c4:	973e                	add	a4,a4,a5
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    31c6:	08000593          	li	a1,128
    31ca:	8652                	mv	a2,s4
    31cc:	0888                	addi	a0,sp,80
            fmt_tmp[f_idx] = '\0';
    31ce:	f6070023          	sb	zero,-160(a4)
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    31d2:	dc5ff0ef          	jal	2f96 <stbsp_snprintf>
            for (int i = 0; f_buf[i] != '\0'; i++)
    31d6:	05014583          	lbu	a1,80(sp)
            double f_val = va_arg(ap, double);
    31da:	0c21                	addi	s8,s8,8
            for (int i = 0; f_buf[i] != '\0'; i++)
    31dc:	05110413          	addi	s0,sp,81
    31e0:	e6058ce3          	beqz	a1,3058 <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, f_buf[i]);
    31e4:	8526                	mv	a0,s1
    31e6:	fc1fd0ef          	jal	11a6 <_out_char>
            for (int i = 0; f_buf[i] != '\0'; i++)
    31ea:	00044583          	lbu	a1,0(s0)
    31ee:	0405                	addi	s0,s0,1
    31f0:	e60584e3          	beqz	a1,3058 <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, f_buf[i]);
    31f4:	8526                	mv	a0,s1
    31f6:	fb1fd0ef          	jal	11a6 <_out_char>
            for (int i = 0; f_buf[i] != '\0'; i++)
    31fa:	00044583          	lbu	a1,0(s0)
    31fe:	0405                	addi	s0,s0,1
    3200:	f1f5                	bnez	a1,31e4 <_vprintf_core.constprop.0.isra.0+0x1ca>
    3202:	bd99                	j	3058 <_vprintf_core.constprop.0.isra.0+0x3e>
            while (*p >= '0' && *p <= '9')
    3204:	fd0c869b          	addiw	a3,s9,-48
    3208:	0ff6f313          	zext.b	t1,a3
    320c:	4725                	li	a4,9
        int width = 0;
    320e:	4401                	li	s0,0
            while (*p >= '0' && *p <= '9')
    3210:	4625                	li	a2,9
    3212:	e8676ae3          	bltu	a4,t1,30a6 <_vprintf_core.constprop.0.isra.0+0x8c>
    3216:	001dcc83          	lbu	s9,1(s11)
                width = width * 10 + (*p - '0');
    321a:	0024171b          	slliw	a4,s0,0x2
    321e:	9f21                	addw	a4,a4,s0
    3220:	0017171b          	slliw	a4,a4,0x1
    3224:	00e6843b          	addw	s0,a3,a4
            while (*p >= '0' && *p <= '9')
    3228:	fd0c869b          	addiw	a3,s9,-48
    322c:	0ff6f713          	zext.b	a4,a3
                p++;
    3230:	0d85                	addi	s11,s11,1
            while (*p >= '0' && *p <= '9')
    3232:	fee672e3          	bgeu	a2,a4,3216 <_vprintf_core.constprop.0.isra.0+0x1fc>
        if (*p == '.')
    3236:	02e00793          	li	a5,46
        int precision = -1;
    323a:	5bfd                	li	s7,-1
        if (*p == '.')
    323c:	e6fc9ae3          	bne	s9,a5,30b0 <_vprintf_core.constprop.0.isra.0+0x96>
            if (*p == '*')
    3240:	001dcc83          	lbu	s9,1(s11)
    3244:	02a00793          	li	a5,42
    3248:	16fc9f63          	bne	s9,a5,33c6 <_vprintf_core.constprop.0.isra.0+0x3ac>
                while (*p >= '0' && *p <= '9')
    324c:	002dcc83          	lbu	s9,2(s11)
        if (*p == 'l')
    3250:	06c00693          	li	a3,108
                precision = va_arg(ap, int);
    3254:	000c2b83          	lw	s7,0(s8)
                p++;
    3258:	0d89                	addi	s11,s11,2
                precision = va_arg(ap, int);
    325a:	0c21                	addi	s8,s8,8
        if (*p == 'l')
    325c:	8666                	mv	a2,s9
    325e:	e4dc9ee3          	bne	s9,a3,30ba <_vprintf_core.constprop.0.isra.0+0xa0>
            if (*p == 'l')
    3262:	001dcc83          	lbu	s9,1(s11)
    3266:	08cc8d63          	beq	s9,a2,3300 <_vprintf_core.constprop.0.isra.0+0x2e6>
        char spec = *p++;
    326a:	06400693          	li	a3,100
    326e:	0d89                	addi	s11,s11,2
        if (!spec)
    3270:	4cdc8c63          	beq	s9,a3,3748 <_vprintf_core.constprop.0.isra.0+0x72e>
    3274:	06400693          	li	a3,100
            len_mod = 1;
    3278:	4e85                	li	t4,1
    327a:	e596fee3          	bgeu	a3,s9,30d6 <_vprintf_core.constprop.0.isra.0+0xbc>
    327e:	f9bc869b          	addiw	a3,s9,-101
    3282:	0ff6f693          	zext.b	a3,a3
    3286:	464d                	li	a2,19
    3288:	12d66863          	bltu	a2,a3,33b8 <_vprintf_core.constprop.0.isra.0+0x39e>
    328c:	4e05                	li	t3,1
    328e:	00091637          	lui	a2,0x91
    3292:	00de1333          	sll	t1,t3,a3
    3296:	81060613          	addi	a2,a2,-2032 # 90810 <_ZSt4cerr+0x89058>
    329a:	00c37633          	and	a2,t1,a2
    329e:	1a061463          	bnez	a2,3446 <_vprintf_core.constprop.0.isra.0+0x42c>
    32a2:	00737313          	andi	t1,t1,7
    32a6:	e80311e3          	bnez	t1,3128 <_vprintf_core.constprop.0.isra.0+0x10e>
    32aa:	4639                	li	a2,14
    32ac:	10c69663          	bne	a3,a2,33b8 <_vprintf_core.constprop.0.isra.0+0x39e>
            const char *s = va_arg(ap, char *);
    32b0:	000c3c83          	ld	s9,0(s8)
            if (!s)
    32b4:	420c8863          	beqz	s9,36e4 <_vprintf_core.constprop.0.isra.0+0x6ca>
            while (*tmp && (precision < 0 || len < precision))
    32b8:	000cc683          	lbu	a3,0(s9)
    32bc:	38068863          	beqz	a3,364c <_vprintf_core.constprop.0.isra.0+0x632>
            const char *tmp = s;
    32c0:	8666                	mv	a2,s9
            int len = 0;
    32c2:	4681                	li	a3,0
            while (*tmp && (precision < 0 || len < precision))
    32c4:	00db8863          	beq	s7,a3,32d4 <_vprintf_core.constprop.0.isra.0+0x2ba>
    32c8:	00164583          	lbu	a1,1(a2)
                len++;
    32cc:	2685                	addiw	a3,a3,1
                tmp++;
    32ce:	0605                	addi	a2,a2,1
            while (*tmp && (precision < 0 || len < precision))
    32d0:	f9f5                	bnez	a1,32c4 <_vprintf_core.constprop.0.isra.0+0x2aa>
    32d2:	8bb6                	mv	s7,a3
            int padding = (width > len) ? width - len : 0;
    32d4:	268bc563          	blt	s7,s0,353e <_vprintf_core.constprop.0.isra.0+0x524>
            for (int i = 0; i < len; i++)
    32d8:	4401                	li	s0,0
    32da:	020b8163          	beqz	s7,32fc <_vprintf_core.constprop.0.isra.0+0x2e2>
    32de:	4d01                	li	s10,0
                _out_char(ctx, s[i]);
    32e0:	01ac86b3          	add	a3,s9,s10
    32e4:	0006c583          	lbu	a1,0(a3)
    32e8:	8526                	mv	a0,s1
            for (int i = 0; i < len; i++)
    32ea:	0d05                	addi	s10,s10,1
                _out_char(ctx, s[i]);
    32ec:	ebbfd0ef          	jal	11a6 <_out_char>
            for (int i = 0; i < len; i++)
    32f0:	000d069b          	sext.w	a3,s10
    32f4:	ff76c6e3          	blt	a3,s7,32e0 <_vprintf_core.constprop.0.isra.0+0x2c6>
            if (flag_left)
    32f8:	260a1463          	bnez	s4,3560 <_vprintf_core.constprop.0.isra.0+0x546>
            const char *s = va_arg(ap, char *);
    32fc:	0c21                	addi	s8,s8,8
    32fe:	bba9                	j	3058 <_vprintf_core.constprop.0.isra.0+0x3e>
                p++;
    3300:	0d89                	addi	s11,s11,2
        char spec = *p++;
    3302:	000dcc83          	lbu	s9,0(s11)
    3306:	06400693          	li	a3,100
    330a:	001d8793          	addi	a5,s11,1
        if (!spec)
    330e:	3edc8063          	beq	s9,a3,36ee <_vprintf_core.constprop.0.isra.0+0x6d4>
    3312:	0796ea63          	bltu	a3,s9,3386 <_vprintf_core.constprop.0.isra.0+0x36c>
    3316:	04700693          	li	a3,71
    331a:	0f96e263          	bltu	a3,s9,33fe <_vprintf_core.constprop.0.isra.0+0x3e4>
    331e:	04400693          	li	a3,68
    3322:	e196e2e3          	bltu	a3,s9,3126 <_vprintf_core.constprop.0.isra.0+0x10c>
    3326:	dc0c82e3          	beqz	s9,30ea <_vprintf_core.constprop.0.isra.0+0xd0>
        char spec = *p++;
    332a:	8dbe                	mv	s11,a5
            _out_char(ctx, '%');
    332c:	02500593          	li	a1,37
    3330:	8526                	mv	a0,s1
    3332:	e75fd0ef          	jal	11a6 <_out_char>
            if (spec != '%')
    3336:	02500713          	li	a4,37
    333a:	d0ec8fe3          	beq	s9,a4,3058 <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, spec);
    333e:	85e6                	mv	a1,s9
    3340:	bb09                	j	3052 <_vprintf_core.constprop.0.isra.0+0x38>
    3342:	05800693          	li	a3,88
    3346:	2edc8263          	beq	s9,a3,362a <_vprintf_core.constprop.0.isra.0+0x610>
    334a:	06300713          	li	a4,99
    334e:	06ec9563          	bne	s9,a4,33b8 <_vprintf_core.constprop.0.isra.0+0x39e>
            char c = (char)va_arg(ap, int);
    3352:	000c4c83          	lbu	s9,0(s8)
            int padding = (width > 1) ? width - 1 : 0;
    3356:	8722                	mv	a4,s0
    3358:	00804363          	bgtz	s0,335e <_vprintf_core.constprop.0.isra.0+0x344>
    335c:	4705                	li	a4,1
    335e:	fff7041b          	addiw	s0,a4,-1
            if (!flag_left)
    3362:	3c0a0463          	beqz	s4,372a <_vprintf_core.constprop.0.isra.0+0x710>
            _out_char(ctx, c);
    3366:	85e6                	mv	a1,s9
    3368:	8526                	mv	a0,s1
    336a:	e3dfd0ef          	jal	11a6 <_out_char>
                for (int i = 0; i < padding; i++)
    336e:	4a01                	li	s4,0
    3370:	d451                	beqz	s0,32fc <_vprintf_core.constprop.0.isra.0+0x2e2>
                    _out_char(ctx, ' ');
    3372:	02000593          	li	a1,32
    3376:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    3378:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    337a:	e2dfd0ef          	jal	11a6 <_out_char>
                for (int i = 0; i < padding; i++)
    337e:	ff441ae3          	bne	s0,s4,3372 <_vprintf_core.constprop.0.isra.0+0x358>
            const char *s = va_arg(ap, char *);
    3382:	0c21                	addi	s8,s8,8
    3384:	b9d1                	j	3058 <_vprintf_core.constprop.0.isra.0+0x3e>
    3386:	f9bc861b          	addiw	a2,s9,-101
    338a:	0ff67613          	zext.b	a2,a2
    338e:	46cd                	li	a3,19
    3390:	40c6e963          	bltu	a3,a2,37a2 <_vprintf_core.constprop.0.isra.0+0x788>
    3394:	00091337          	lui	t1,0x91
    3398:	4685                	li	a3,1
    339a:	00c696b3          	sll	a3,a3,a2
    339e:	81030313          	addi	t1,t1,-2032 # 90810 <_ZSt4cerr+0x89058>
    33a2:	0066f333          	and	t1,a3,t1
    33a6:	34031c63          	bnez	t1,36fe <_vprintf_core.constprop.0.isra.0+0x6e4>
    33aa:	8a9d                	andi	a3,a3,7
    33ac:	d6069de3          	bnez	a3,3126 <_vprintf_core.constprop.0.isra.0+0x10c>
    33b0:	46b9                	li	a3,14
        char spec = *p++;
    33b2:	8dbe                	mv	s11,a5
    33b4:	eed60ee3          	beq	a2,a3,32b0 <_vprintf_core.constprop.0.isra.0+0x296>
            _out_char(ctx, '%');
    33b8:	02500593          	li	a1,37
    33bc:	8526                	mv	a0,s1
    33be:	de9fd0ef          	jal	11a6 <_out_char>
                _out_char(ctx, spec);
    33c2:	85e6                	mv	a1,s9
    33c4:	b179                	j	3052 <_vprintf_core.constprop.0.isra.0+0x38>
                while (*p >= '0' && *p <= '9')
    33c6:	fd0c869b          	addiw	a3,s9,-48
    33ca:	0ff6fe13          	zext.b	t3,a3
    33ce:	4625                	li	a2,9
            p++;
    33d0:	0d85                	addi	s11,s11,1
                precision = 0;
    33d2:	4b81                	li	s7,0
                while (*p >= '0' && *p <= '9')
    33d4:	4325                	li	t1,9
    33d6:	cdc66de3          	bltu	a2,t3,30b0 <_vprintf_core.constprop.0.isra.0+0x96>
                    precision = precision * 10 + (*p - '0');
    33da:	002b961b          	slliw	a2,s7,0x2
                while (*p >= '0' && *p <= '9')
    33de:	001dcc83          	lbu	s9,1(s11)
                    precision = precision * 10 + (*p - '0');
    33e2:	0176073b          	addw	a4,a2,s7
    33e6:	0017171b          	slliw	a4,a4,0x1
    33ea:	00e68bbb          	addw	s7,a3,a4
                while (*p >= '0' && *p <= '9')
    33ee:	fd0c869b          	addiw	a3,s9,-48
    33f2:	0ff6f613          	zext.b	a2,a3
                    p++;
    33f6:	0d85                	addi	s11,s11,1
                while (*p >= '0' && *p <= '9')
    33f8:	fec371e3          	bgeu	t1,a2,33da <_vprintf_core.constprop.0.isra.0+0x3c0>
    33fc:	b955                	j	30b0 <_vprintf_core.constprop.0.isra.0+0x96>
    33fe:	05800693          	li	a3,88
    3402:	3cdc8d63          	beq	s9,a3,37dc <_vprintf_core.constprop.0.isra.0+0x7c2>
    3406:	06300713          	li	a4,99
        char spec = *p++;
    340a:	8dbe                	mv	s11,a5
    340c:	f4ec83e3          	beq	s9,a4,3352 <_vprintf_core.constprop.0.isra.0+0x338>
    3410:	b765                	j	33b8 <_vprintf_core.constprop.0.isra.0+0x39e>
                f_idx += sprintf(&fmt_tmp[f_idx], ".%d", precision);
    3412:	01aa0533          	add	a0,s4,s10
    3416:	865e                	mv	a2,s7
    3418:	00002597          	auipc	a1,0x2
    341c:	c5058593          	addi	a1,a1,-944 # 5068 <_GLOBAL__sub_I__ZSt3cin+0xba>
    3420:	ba5ff0ef          	jal	2fc4 <sprintf>
    3424:	00ad0d3b          	addw	s10,s10,a0
    3428:	b341                	j	31a8 <_vprintf_core.constprop.0.isra.0+0x18e>
                f_idx += sprintf(&fmt_tmp[f_idx], "%d", width);
    342a:	01aa0533          	add	a0,s4,s10
    342e:	8622                	mv	a2,s0
    3430:	00002597          	auipc	a1,0x2
    3434:	c3058593          	addi	a1,a1,-976 # 5060 <_GLOBAL__sub_I__ZSt3cin+0xb2>
    3438:	b8dff0ef          	jal	2fc4 <sprintf>
    343c:	00ad0d3b          	addw	s10,s10,a0
            if (precision >= 0)
    3440:	d60bc4e3          	bltz	s7,31a8 <_vprintf_core.constprop.0.isra.0+0x18e>
    3444:	b7f9                	j	3412 <_vprintf_core.constprop.0.isra.0+0x3f8>
            int is_signed = (spec == 'd' || spec == 'i');
    3446:	06900693          	li	a3,105
    344a:	10dc8e63          	beq	s9,a3,3566 <_vprintf_core.constprop.0.isra.0+0x54c>
                val = (uint64)va_arg(ap, void *);
    344e:	008c0793          	addi	a5,s8,8
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3452:	07800693          	li	a3,120
                val = (uint64)va_arg(ap, void *);
    3456:	e43e                	sd	a5,8(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3458:	38dc9d63          	bne	s9,a3,37f2 <_vprintf_core.constprop.0.isra.0+0x7d8>
            else if (len_mod == 1)
    345c:	33ce8963          	beq	t4,t3,378e <_vprintf_core.constprop.0.isra.0+0x774>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    3460:	000c6e03          	lwu	t3,0(s8)
    3464:	85f6                	mv	a1,t4
    3466:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3468:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    346a:	00002f97          	auipc	t6,0x2
    346e:	bc6f8f93          	addi	t6,t6,-1082 # 5030 <_GLOBAL__sub_I__ZSt3cin+0x82>
    if (val == 0)
    3472:	120e0363          	beqz	t3,3598 <_vprintf_core.constprop.0.isra.0+0x57e>
    3476:	01010293          	addi	t0,sp,16
                    sign_char = '-';
    347a:	8616                	mv	a2,t0
    347c:	86f2                	mv	a3,t3
        buf[i++] = digits[val % base];
    347e:	0266f8b3          	remu	a7,a3,t1
    3482:	8f32                	mv	t5,a2
    while (val != 0)
    3484:	0605                	addi	a2,a2,1
    3486:	8eb6                	mv	t4,a3
        buf[i++] = digits[val % base];
    3488:	98fe                	add	a7,a7,t6
    348a:	0008c883          	lbu	a7,0(a7)
        val /= base;
    348e:	0266d6b3          	divu	a3,a3,t1
        buf[i++] = digits[val % base];
    3492:	ff160fa3          	sb	a7,-1(a2)
    while (val != 0)
    3496:	fe6ef4e3          	bgeu	t4,t1,347e <_vprintf_core.constprop.0.isra.0+0x464>
        buf[i++] = digits[val % base];
    349a:	405f0f3b          	subw	t5,t5,t0
    349e:	2f05                	addiw	t5,t5,1
            if (precision >= 0)
    34a0:	100bc363          	bltz	s7,35a6 <_vprintf_core.constprop.0.isra.0+0x58c>
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    34a4:	1d7f4d63          	blt	t5,s7,367e <_vprintf_core.constprop.0.isra.0+0x664>
            if (precision == 0 && val == 0)
    34a8:	340b9163          	bnez	s7,37ea <_vprintf_core.constprop.0.isra.0+0x7d0>
    34ac:	200e0763          	beqz	t3,36ba <_vprintf_core.constprop.0.isra.0+0x6a0>
            for (int i = digit_len - 1; i >= 0; i--)
    34b0:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    34b4:	07000693          	li	a3,112
            for (int i = digit_len - 1; i >= 0; i--)
    34b8:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    34ba:	28dc8e63          	beq	s9,a3,3756 <_vprintf_core.constprop.0.isra.0+0x73c>
    34be:	2a051663          	bnez	a0,376a <_vprintf_core.constprop.0.isra.0+0x750>
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    34c2:	00bf05bb          	addw	a1,t5,a1
    34c6:	8d52                	mv	s10,s4
    34c8:	4b01                	li	s6,0
            char *prefix_str = NULL;
    34ca:	4c81                	li	s9,0
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    34cc:	1085d263          	bge	a1,s0,35d0 <_vprintf_core.constprop.0.isra.0+0x5b6>
    34d0:	9c0d                	subw	s0,s0,a1
            if (!flag_left && !flag_zero)
    34d2:	100d0a63          	beqz	s10,35e6 <_vprintf_core.constprop.0.isra.0+0x5cc>
            if (sign_char)
    34d6:	6782                	ld	a5,0(sp)
    34d8:	10079263          	bnez	a5,35dc <_vprintf_core.constprop.0.isra.0+0x5c2>
            if (prefix_str)
    34dc:	000c8c63          	beqz	s9,34f4 <_vprintf_core.constprop.0.isra.0+0x4da>
                _out_char(ctx, prefix_str[0]);
    34e0:	000cc583          	lbu	a1,0(s9)
    34e4:	8526                	mv	a0,s1
    34e6:	cc1fd0ef          	jal	11a6 <_out_char>
                _out_char(ctx, prefix_str[1]);
    34ea:	001cc583          	lbu	a1,1(s9)
    34ee:	8526                	mv	a0,s1
    34f0:	cb7fd0ef          	jal	11a6 <_out_char>
            int total_zeros = prec_zeros + ((flag_zero && !flag_left) ? padding : 0);
    34f4:	180b0263          	beqz	s6,3678 <_vprintf_core.constprop.0.isra.0+0x65e>
    34f8:	100a1863          	bnez	s4,3608 <_vprintf_core.constprop.0.isra.0+0x5ee>
    34fc:	008b8bbb          	addw	s7,s7,s0
            for (int i = 0; i < total_zeros; i++)
    3500:	2a0b8363          	beqz	s7,37a6 <_vprintf_core.constprop.0.isra.0+0x78c>
    3504:	4c81                	li	s9,0
                _out_char(ctx, '0');
    3506:	03000593          	li	a1,48
    350a:	8526                	mv	a0,s1
            for (int i = 0; i < total_zeros; i++)
    350c:	2c85                	addiw	s9,s9,1
                _out_char(ctx, '0');
    350e:	c99fd0ef          	jal	11a6 <_out_char>
            for (int i = 0; i < total_zeros; i++)
    3512:	ff7c9ae3          	bne	s9,s7,3506 <_vprintf_core.constprop.0.isra.0+0x4ec>
            for (int i = digit_len - 1; i >= 0; i--)
    3516:	57fd                	li	a5,-1
    3518:	00fc0f63          	beq	s8,a5,3536 <_vprintf_core.constprop.0.isra.0+0x51c>
    351c:	01010c93          	addi	s9,sp,16
    3520:	9ce2                	add	s9,s9,s8
    3522:	00f10c13          	addi	s8,sp,15
                _out_char(ctx, num_buf[i]);
    3526:	000cc583          	lbu	a1,0(s9)
    352a:	8526                	mv	a0,s1
            for (int i = digit_len - 1; i >= 0; i--)
    352c:	1cfd                	addi	s9,s9,-1
                _out_char(ctx, num_buf[i]);
    352e:	c79fd0ef          	jal	11a6 <_out_char>
            for (int i = digit_len - 1; i >= 0; i--)
    3532:	ff9c1ae3          	bne	s8,s9,3526 <_vprintf_core.constprop.0.isra.0+0x50c>
            if (flag_left)
    3536:	0c0a1e63          	bnez	s4,3612 <_vprintf_core.constprop.0.isra.0+0x5f8>
        char spec = *p++;
    353a:	6c22                	ld	s8,8(sp)
    353c:	be31                	j	3058 <_vprintf_core.constprop.0.isra.0+0x3e>
            int padding = (width > len) ? width - len : 0;
    353e:	4174043b          	subw	s0,s0,s7
            if (!flag_left)
    3542:	100a0a63          	beqz	s4,3656 <_vprintf_core.constprop.0.isra.0+0x63c>
            for (int i = 0; i < len; i++)
    3546:	d80b9ce3          	bnez	s7,32de <_vprintf_core.constprop.0.isra.0+0x2c4>
                for (int i = 0; i < padding; i++)
    354a:	4a01                	li	s4,0
                    _out_char(ctx, ' ');
    354c:	02000593          	li	a1,32
    3550:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    3552:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    3554:	c53fd0ef          	jal	11a6 <_out_char>
                for (int i = 0; i < padding; i++)
    3558:	ff441ae3          	bne	s0,s4,354c <_vprintf_core.constprop.0.isra.0+0x532>
            const char *s = va_arg(ap, char *);
    355c:	0c21                	addi	s8,s8,8
    355e:	bced                	j	3058 <_vprintf_core.constprop.0.isra.0+0x3e>
                for (int i = 0; i < padding; i++)
    3560:	f46d                	bnez	s0,354a <_vprintf_core.constprop.0.isra.0+0x530>
            const char *s = va_arg(ap, char *);
    3562:	0c21                	addi	s8,s8,8
    3564:	bcd5                	j	3058 <_vprintf_core.constprop.0.isra.0+0x3e>
            else if (len_mod == 1)
    3566:	1fce8163          	beq	t4,t3,3748 <_vprintf_core.constprop.0.isra.0+0x72e>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    356a:	000c2e03          	lw	t3,0(s8)
    356e:	008c0793          	addi	a5,s8,8
    3572:	e43e                	sd	a5,8(sp)
                int64 sval = (int64)val;
    3574:	86f2                	mv	a3,t3
                if (sval < 0)
    3576:	1406cb63          	bltz	a3,36cc <_vprintf_core.constprop.0.isra.0+0x6b2>
                    sign_char = '+';
    357a:	02b00793          	li	a5,43
    357e:	e03e                	sd	a5,0(sp)
                else if (flag_plus)
    3580:	e589                	bnez	a1,358a <_vprintf_core.constprop.0.isra.0+0x570>
                else if (flag_space)
    3582:	00589793          	slli	a5,a7,0x5
    3586:	e03e                	sd	a5,0(sp)
    3588:	85c6                	mv	a1,a7
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    358a:	4329                	li	t1,10
    358c:	00002f97          	auipc	t6,0x2
    3590:	aa4f8f93          	addi	t6,t6,-1372 # 5030 <_GLOBAL__sub_I__ZSt3cin+0x82>
    if (val == 0)
    3594:	ee0e11e3          	bnez	t3,3476 <_vprintf_core.constprop.0.isra.0+0x45c>
        buf[i++] = '0';
    3598:	03000693          	li	a3,48
    359c:	00d10823          	sb	a3,16(sp)
        return i;
    35a0:	4f05                	li	t5,1
            if (precision >= 0)
    35a2:	f00bd1e3          	bgez	s7,34a4 <_vprintf_core.constprop.0.isra.0+0x48a>
            for (int i = digit_len - 1; i >= 0; i--)
    35a6:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    35aa:	07000893          	li	a7,112
            if (!flag_left && !flag_zero)
    35ae:	016a6d33          	or	s10,s4,s6
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    35b2:	4b81                	li	s7,0
            for (int i = digit_len - 1; i >= 0; i--)
    35b4:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    35b6:	0d1c9f63          	bne	s9,a7,3694 <_vprintf_core.constprop.0.isra.0+0x67a>
                prefix_str = (spec == 'X') ? "0X" : "0x";
    35ba:	00002c97          	auipc	s9,0x2
    35be:	a8ec8c93          	addi	s9,s9,-1394 # 5048 <_GLOBAL__sub_I__ZSt3cin+0x9a>
                prefix_len += 2;
    35c2:	2589                	addiw	a1,a1,2
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    35c4:	017585bb          	addw	a1,a1,s7
    35c8:	01e585bb          	addw	a1,a1,t5
    35cc:	f085c2e3          	blt	a1,s0,34d0 <_vprintf_core.constprop.0.isra.0+0x4b6>
            if (!flag_left && !flag_zero)
    35d0:	080d0f63          	beqz	s10,366e <_vprintf_core.constprop.0.isra.0+0x654>
            if (sign_char)
    35d4:	6782                	ld	a5,0(sp)
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    35d6:	4401                	li	s0,0
            if (sign_char)
    35d8:	f00782e3          	beqz	a5,34dc <_vprintf_core.constprop.0.isra.0+0x4c2>
                _out_char(ctx, sign_char);
    35dc:	6582                	ld	a1,0(sp)
    35de:	8526                	mv	a0,s1
    35e0:	bc7fd0ef          	jal	11a6 <_out_char>
    35e4:	bde5                	j	34dc <_vprintf_core.constprop.0.isra.0+0x4c2>
                    _out_char(ctx, ' ');
    35e6:	02000593          	li	a1,32
    35ea:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    35ec:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    35ee:	bb9fd0ef          	jal	11a6 <_out_char>
                for (int i = 0; i < padding; i++)
    35f2:	efa402e3          	beq	s0,s10,34d6 <_vprintf_core.constprop.0.isra.0+0x4bc>
                    _out_char(ctx, ' ');
    35f6:	02000593          	li	a1,32
    35fa:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    35fc:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    35fe:	ba9fd0ef          	jal	11a6 <_out_char>
                for (int i = 0; i < padding; i++)
    3602:	ffa412e3          	bne	s0,s10,35e6 <_vprintf_core.constprop.0.isra.0+0x5cc>
    3606:	bdc1                	j	34d6 <_vprintf_core.constprop.0.isra.0+0x4bc>
            for (int i = 0; i < total_zeros; i++)
    3608:	ee0b9ee3          	bnez	s7,3504 <_vprintf_core.constprop.0.isra.0+0x4ea>
            for (int i = digit_len - 1; i >= 0; i--)
    360c:	577d                	li	a4,-1
    360e:	f0ec17e3          	bne	s8,a4,351c <_vprintf_core.constprop.0.isra.0+0x502>
                for (int i = 0; i < padding; i++)
    3612:	d405                	beqz	s0,353a <_vprintf_core.constprop.0.isra.0+0x520>
    3614:	4a01                	li	s4,0
                    _out_char(ctx, ' ');
    3616:	02000593          	li	a1,32
    361a:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    361c:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    361e:	b89fd0ef          	jal	11a6 <_out_char>
                for (int i = 0; i < padding; i++)
    3622:	fe8a1ae3          	bne	s4,s0,3616 <_vprintf_core.constprop.0.isra.0+0x5fc>
        char spec = *p++;
    3626:	6c22                	ld	s8,8(sp)
    3628:	bc05                	j	3058 <_vprintf_core.constprop.0.isra.0+0x3e>
                val = (uint64)va_arg(ap, void *);
    362a:	008c0793          	addi	a5,s8,8
    362e:	e43e                	sd	a5,8(sp)
            else if (len_mod == 1)
    3630:	180e9163          	bnez	t4,37b2 <_vprintf_core.constprop.0.isra.0+0x798>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    3634:	000c6e03          	lwu	t3,0(s8)
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    3638:	4581                	li	a1,0
    363a:	05800c93          	li	s9,88
    363e:	e002                	sd	zero,0(sp)
    3640:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    3642:	00002f97          	auipc	t6,0x2
    3646:	9d6f8f93          	addi	t6,t6,-1578 # 5018 <_GLOBAL__sub_I__ZSt3cin+0x6a>
    364a:	b525                	j	3472 <_vprintf_core.constprop.0.isra.0+0x458>
            int padding = (width > len) ? width - len : 0;
    364c:	ca8058e3          	blez	s0,32fc <_vprintf_core.constprop.0.isra.0+0x2e2>
            if (!flag_left)
    3650:	ee0a1de3          	bnez	s4,354a <_vprintf_core.constprop.0.isra.0+0x530>
            int len = 0;
    3654:	4b81                	li	s7,0
                for (int i = 0; i < padding; i++)
    3656:	4d01                	li	s10,0
                    _out_char(ctx, ' ');
    3658:	02000593          	li	a1,32
    365c:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    365e:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    3660:	b47fd0ef          	jal	11a6 <_out_char>
                for (int i = 0; i < padding; i++)
    3664:	fe8d1ae3          	bne	s10,s0,3658 <_vprintf_core.constprop.0.isra.0+0x63e>
            for (int i = 0; i < len; i++)
    3668:	c60b9be3          	bnez	s7,32de <_vprintf_core.constprop.0.isra.0+0x2c4>
    366c:	b941                	j	32fc <_vprintf_core.constprop.0.isra.0+0x2e2>
            if (sign_char)
    366e:	6782                	ld	a5,0(sp)
    3670:	4401                	li	s0,0
    3672:	f7ad                	bnez	a5,35dc <_vprintf_core.constprop.0.isra.0+0x5c2>
            if (prefix_str)
    3674:	e60c96e3          	bnez	s9,34e0 <_vprintf_core.constprop.0.isra.0+0x4c6>
            for (int i = 0; i < total_zeros; i++)
    3678:	e80b96e3          	bnez	s7,3504 <_vprintf_core.constprop.0.isra.0+0x4ea>
    367c:	bd69                	j	3516 <_vprintf_core.constprop.0.isra.0+0x4fc>
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    367e:	41eb8bbb          	subw	s7,s7,t5
    3682:	8d52                	mv	s10,s4
    3684:	4b01                	li	s6,0
            for (int i = digit_len - 1; i >= 0; i--)
    3686:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    368a:	07000893          	li	a7,112
            for (int i = digit_len - 1; i >= 0; i--)
    368e:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    3690:	f31c85e3          	beq	s9,a7,35ba <_vprintf_core.constprop.0.isra.0+0x5a0>
    3694:	cd09                	beqz	a0,36ae <_vprintf_core.constprop.0.isra.0+0x694>
    3696:	000e0c63          	beqz	t3,36ae <_vprintf_core.constprop.0.isra.0+0x694>
    369a:	07800513          	li	a0,120
            for (int i = digit_len - 1; i >= 0; i--)
    369e:	00060c1b          	sext.w	s8,a2
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    36a2:	f0ac8ce3          	beq	s9,a0,35ba <_vprintf_core.constprop.0.isra.0+0x5a0>
    36a6:	05800613          	li	a2,88
    36aa:	12cc8463          	beq	s9,a2,37d2 <_vprintf_core.constprop.0.isra.0+0x7b8>
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    36ae:	00bb85bb          	addw	a1,s7,a1
    36b2:	01e585bb          	addw	a1,a1,t5
            char *prefix_str = NULL;
    36b6:	4c81                	li	s9,0
    36b8:	bd11                	j	34cc <_vprintf_core.constprop.0.isra.0+0x4b2>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    36ba:	07000693          	li	a3,112
    36be:	8d52                	mv	s10,s4
    36c0:	4b01                	li	s6,0
    36c2:	08dc8d63          	beq	s9,a3,375c <_vprintf_core.constprop.0.isra.0+0x742>
    36c6:	5c7d                	li	s8,-1
            char *prefix_str = NULL;
    36c8:	4c81                	li	s9,0
    36ca:	b509                	j	34cc <_vprintf_core.constprop.0.isra.0+0x4b2>
                    sign_char = '-';
    36cc:	02d00793          	li	a5,45
                    val = (uint64)(-sval);
    36d0:	40d00e33          	neg	t3,a3
    36d4:	4585                	li	a1,1
    36d6:	4329                	li	t1,10
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    36d8:	00002f97          	auipc	t6,0x2
    36dc:	958f8f93          	addi	t6,t6,-1704 # 5030 <_GLOBAL__sub_I__ZSt3cin+0x82>
                    sign_char = '-';
    36e0:	e03e                	sd	a5,0(sp)
    36e2:	bb51                	j	3476 <_vprintf_core.constprop.0.isra.0+0x45c>
                s = "(null)";
    36e4:	00002c97          	auipc	s9,0x2
    36e8:	974c8c93          	addi	s9,s9,-1676 # 5058 <_GLOBAL__sub_I__ZSt3cin+0xaa>
    36ec:	bed1                	j	32c0 <_vprintf_core.constprop.0.isra.0+0x2a6>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    36ee:	000c3683          	ld	a3,0(s8)
    36f2:	008c0713          	addi	a4,s8,8
    36f6:	e43a                	sd	a4,8(sp)
    36f8:	8dbe                	mv	s11,a5
    36fa:	8e36                	mv	t3,a3
            if (is_signed)
    36fc:	bdad                	j	3576 <_vprintf_core.constprop.0.isra.0+0x55c>
            int is_signed = (spec == 'd' || spec == 'i');
    36fe:	06900693          	li	a3,105
    3702:	fedc86e3          	beq	s9,a3,36ee <_vprintf_core.constprop.0.isra.0+0x6d4>
                val = (uint64)va_arg(ap, void *);
    3706:	008c0713          	addi	a4,s8,8
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    370a:	07800693          	li	a3,120
                val = (uint64)va_arg(ap, void *);
    370e:	e43a                	sd	a4,8(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3710:	06dc9063          	bne	s9,a3,3770 <_vprintf_core.constprop.0.isra.0+0x756>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    3714:	000c3e03          	ld	t3,0(s8)
    3718:	8dbe                	mv	s11,a5
    371a:	4581                	li	a1,0
    371c:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    371e:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    3720:	00002f97          	auipc	t6,0x2
    3724:	910f8f93          	addi	t6,t6,-1776 # 5030 <_GLOBAL__sub_I__ZSt3cin+0x82>
    3728:	b3a9                	j	3472 <_vprintf_core.constprop.0.isra.0+0x458>
                for (int i = 0; i < padding; i++)
    372a:	c809                	beqz	s0,373c <_vprintf_core.constprop.0.isra.0+0x722>
                    _out_char(ctx, ' ');
    372c:	02000593          	li	a1,32
    3730:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    3732:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    3734:	a73fd0ef          	jal	11a6 <_out_char>
                for (int i = 0; i < padding; i++)
    3738:	ff441ae3          	bne	s0,s4,372c <_vprintf_core.constprop.0.isra.0+0x712>
            _out_char(ctx, c);
    373c:	85e6                	mv	a1,s9
    373e:	8526                	mv	a0,s1
    3740:	a67fd0ef          	jal	11a6 <_out_char>
            const char *s = va_arg(ap, char *);
    3744:	0c21                	addi	s8,s8,8
    3746:	ba09                	j	3058 <_vprintf_core.constprop.0.isra.0+0x3e>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    3748:	000c3683          	ld	a3,0(s8)
    374c:	008c0793          	addi	a5,s8,8
    3750:	e43e                	sd	a5,8(sp)
    3752:	8e36                	mv	t3,a3
            if (is_signed)
    3754:	b50d                	j	3576 <_vprintf_core.constprop.0.isra.0+0x55c>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    3756:	8d52                	mv	s10,s4
    3758:	4b01                	li	s6,0
    375a:	b585                	j	35ba <_vprintf_core.constprop.0.isra.0+0x5a0>
                digit_len = 0;
    375c:	4f01                	li	t5,0
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    375e:	5c7d                	li	s8,-1
                prefix_str = (spec == 'X') ? "0X" : "0x";
    3760:	00002c97          	auipc	s9,0x2
    3764:	8e8c8c93          	addi	s9,s9,-1816 # 5048 <_GLOBAL__sub_I__ZSt3cin+0x9a>
    3768:	bda9                	j	35c2 <_vprintf_core.constprop.0.isra.0+0x5a8>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    376a:	8d52                	mv	s10,s4
    376c:	4b01                	li	s6,0
    376e:	b735                	j	369a <_vprintf_core.constprop.0.isra.0+0x680>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3770:	07000693          	li	a3,112
    3774:	04dc8263          	beq	s9,a3,37b8 <_vprintf_core.constprop.0.isra.0+0x79e>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    3778:	000c3e03          	ld	t3,0(s8)
    377c:	8dbe                	mv	s11,a5
    377e:	4581                	li	a1,0
    3780:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3782:	4329                	li	t1,10
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    3784:	00002f97          	auipc	t6,0x2
    3788:	8acf8f93          	addi	t6,t6,-1876 # 5030 <_GLOBAL__sub_I__ZSt3cin+0x82>
    378c:	b1dd                	j	3472 <_vprintf_core.constprop.0.isra.0+0x458>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    378e:	000c3e03          	ld	t3,0(s8)
    3792:	4581                	li	a1,0
    3794:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3796:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    3798:	00002f97          	auipc	t6,0x2
    379c:	898f8f93          	addi	t6,t6,-1896 # 5030 <_GLOBAL__sub_I__ZSt3cin+0x82>
    37a0:	b9c9                	j	3472 <_vprintf_core.constprop.0.isra.0+0x458>
        char spec = *p++;
    37a2:	8dbe                	mv	s11,a5
    37a4:	b911                	j	33b8 <_vprintf_core.constprop.0.isra.0+0x39e>
            for (int i = digit_len - 1; i >= 0; i--)
    37a6:	577d                	li	a4,-1
    37a8:	4401                	li	s0,0
    37aa:	d6ec19e3          	bne	s8,a4,351c <_vprintf_core.constprop.0.isra.0+0x502>
        char spec = *p++;
    37ae:	6c22                	ld	s8,8(sp)
    37b0:	b065                	j	3058 <_vprintf_core.constprop.0.isra.0+0x3e>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    37b2:	000c3e03          	ld	t3,0(s8)
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    37b6:	b549                	j	3638 <_vprintf_core.constprop.0.isra.0+0x61e>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    37b8:	8dbe                	mv	s11,a5
                val = (uint64)va_arg(ap, void *);
    37ba:	000c3e03          	ld	t3,0(s8)
    37be:	4581                	li	a1,0
    37c0:	07000c93          	li	s9,112
    37c4:	e002                	sd	zero,0(sp)
    37c6:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    37c8:	00002f97          	auipc	t6,0x2
    37cc:	868f8f93          	addi	t6,t6,-1944 # 5030 <_GLOBAL__sub_I__ZSt3cin+0x82>
    37d0:	b14d                	j	3472 <_vprintf_core.constprop.0.isra.0+0x458>
                prefix_str = (spec == 'X') ? "0X" : "0x";
    37d2:	00002c97          	auipc	s9,0x2
    37d6:	87ec8c93          	addi	s9,s9,-1922 # 5050 <_GLOBAL__sub_I__ZSt3cin+0xa2>
    37da:	b3e5                	j	35c2 <_vprintf_core.constprop.0.isra.0+0x5a8>
                val = (uint64)va_arg(ap, void *);
    37dc:	008c0713          	addi	a4,s8,8
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    37e0:	000c3e03          	ld	t3,0(s8)
                val = (uint64)va_arg(ap, void *);
    37e4:	e43a                	sd	a4,8(sp)
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    37e6:	8dbe                	mv	s11,a5
    37e8:	bd81                	j	3638 <_vprintf_core.constprop.0.isra.0+0x61e>
    37ea:	8d52                	mv	s10,s4
    37ec:	4b01                	li	s6,0
    37ee:	4b81                	li	s7,0
    37f0:	bd59                	j	3686 <_vprintf_core.constprop.0.isra.0+0x66c>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    37f2:	07000693          	li	a3,112
    37f6:	fcdc82e3          	beq	s9,a3,37ba <_vprintf_core.constprop.0.isra.0+0x7a0>
            else if (len_mod == 1)
    37fa:	01ce8c63          	beq	t4,t3,3812 <_vprintf_core.constprop.0.isra.0+0x7f8>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    37fe:	000c6e03          	lwu	t3,0(s8)
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    3802:	4581                	li	a1,0
    3804:	e002                	sd	zero,0(sp)
    3806:	4329                	li	t1,10
    3808:	00002f97          	auipc	t6,0x2
    380c:	828f8f93          	addi	t6,t6,-2008 # 5030 <_GLOBAL__sub_I__ZSt3cin+0x82>
    3810:	b18d                	j	3472 <_vprintf_core.constprop.0.isra.0+0x458>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    3812:	000c3e03          	ld	t3,0(s8)
            if (is_signed)
    3816:	b7f5                	j	3802 <_vprintf_core.constprop.0.isra.0+0x7e8>

0000000000003818 <vsnprintf>:
{
    3818:	7139                	addi	sp,sp,-64
    381a:	f822                	sd	s0,48(sp)
    381c:	f426                	sd	s1,40(sp)
    381e:	842e                	mv	s0,a1
    3820:	84aa                	mv	s1,a0
    3822:	85b2                	mv	a1,a2
    _vprintf_core(&ctx, format, ap);
    3824:	850a                	mv	a0,sp
    3826:	8636                	mv	a2,a3
{
    3828:	fc06                	sd	ra,56(sp)
    ctx.buf = str;
    382a:	e026                	sd	s1,0(sp)
    ctx.limit = size;
    382c:	e422                	sd	s0,8(sp)
    ctx.written = 0;
    382e:	e802                	sd	zero,16(sp)
    ctx.stream = NULL;
    3830:	ec02                	sd	zero,24(sp)
    _vprintf_core(&ctx, format, ap);
    3832:	fe8ff0ef          	jal	301a <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    3836:	6542                	ld	a0,16(sp)
    if (size > 0)
    3838:	c411                	beqz	s0,3844 <vsnprintf+0x2c>
        if (ctx.written < size)
    383a:	00857b63          	bgeu	a0,s0,3850 <vsnprintf+0x38>
            str[ctx.written] = '\0';
    383e:	94aa                	add	s1,s1,a0
    3840:	00048023          	sb	zero,0(s1)
}
    3844:	70e2                	ld	ra,56(sp)
    3846:	7442                	ld	s0,48(sp)
    3848:	74a2                	ld	s1,40(sp)
    384a:	2501                	sext.w	a0,a0
    384c:	6121                	addi	sp,sp,64
    384e:	8082                	ret
            str[size - 1] = '\0';
    3850:	94a2                	add	s1,s1,s0
    3852:	fe048fa3          	sb	zero,-1(s1)
}
    3856:	70e2                	ld	ra,56(sp)
    3858:	7442                	ld	s0,48(sp)
    385a:	74a2                	ld	s1,40(sp)
    385c:	2501                	sext.w	a0,a0
    385e:	6121                	addi	sp,sp,64
    3860:	8082                	ret

0000000000003862 <snprintf>:
{
    3862:	7119                	addi	sp,sp,-128
    3864:	e0a2                	sd	s0,64(sp)
    3866:	fc26                	sd	s1,56(sp)
    3868:	842e                	mv	s0,a1
    386a:	84aa                	mv	s1,a0
    386c:	85b2                	mv	a1,a2
    _vprintf_core(&ctx, format, ap);
    386e:	0808                	addi	a0,sp,16
    va_start(ap, format);
    3870:	08b0                	addi	a2,sp,88
{
    3872:	e486                	sd	ra,72(sp)
    3874:	ecb6                	sd	a3,88(sp)
    3876:	f0ba                	sd	a4,96(sp)
    3878:	f4be                	sd	a5,104(sp)
    387a:	f8c2                	sd	a6,112(sp)
    387c:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    387e:	e432                	sd	a2,8(sp)
    ctx.buf = str;
    3880:	e826                	sd	s1,16(sp)
    ctx.limit = size;
    3882:	ec22                	sd	s0,24(sp)
    ctx.written = 0;
    3884:	f002                	sd	zero,32(sp)
    ctx.stream = NULL;
    3886:	f402                	sd	zero,40(sp)
    _vprintf_core(&ctx, format, ap);
    3888:	f92ff0ef          	jal	301a <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    388c:	7502                	ld	a0,32(sp)
    if (size > 0)
    388e:	c411                	beqz	s0,389a <snprintf+0x38>
        if (ctx.written < size)
    3890:	00857b63          	bgeu	a0,s0,38a6 <snprintf+0x44>
            str[ctx.written] = '\0';
    3894:	94aa                	add	s1,s1,a0
    3896:	00048023          	sb	zero,0(s1)
}
    389a:	60a6                	ld	ra,72(sp)
    389c:	6406                	ld	s0,64(sp)
    389e:	74e2                	ld	s1,56(sp)
    38a0:	2501                	sext.w	a0,a0
    38a2:	6109                	addi	sp,sp,128
    38a4:	8082                	ret
            str[size - 1] = '\0';
    38a6:	94a2                	add	s1,s1,s0
    38a8:	fe048fa3          	sb	zero,-1(s1)
}
    38ac:	60a6                	ld	ra,72(sp)
    38ae:	6406                	ld	s0,64(sp)
    38b0:	74e2                	ld	s1,56(sp)
    38b2:	2501                	sext.w	a0,a0
    38b4:	6109                	addi	sp,sp,128
    38b6:	8082                	ret

00000000000038b8 <printf>:
{
    38b8:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    38ba:	04810313          	addi	t1,sp,72
{
    38be:	e4ae                	sd	a1,72(sp)
    38c0:	e8b2                	sd	a2,80(sp)
    38c2:	f4be                	sd	a5,104(sp)
    _vprintf_core(&ctx, format, ap);
    38c4:	85aa                	mv	a1,a0
    ctx.stream = stdout;
    38c6:	00004797          	auipc	a5,0x4
    38ca:	d5a7b783          	ld	a5,-678(a5) # 7620 <stdout>
    _vprintf_core(&ctx, format, ap);
    38ce:	0808                	addi	a0,sp,16
    38d0:	861a                	mv	a2,t1
{
    38d2:	fc06                	sd	ra,56(sp)
    38d4:	ecb6                	sd	a3,88(sp)
    38d6:	f0ba                	sd	a4,96(sp)
    38d8:	f8c2                	sd	a6,112(sp)
    38da:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    38dc:	e41a                	sd	t1,8(sp)
    ctx.buf = NULL;
    38de:	e802                	sd	zero,16(sp)
    ctx.limit = 0;
    38e0:	ec02                	sd	zero,24(sp)
    ctx.written = 0;
    38e2:	f002                	sd	zero,32(sp)
    ctx.stream = stdout;
    38e4:	f43e                	sd	a5,40(sp)
    _vprintf_core(&ctx, format, ap);
    38e6:	f34ff0ef          	jal	301a <_vprintf_core.constprop.0.isra.0>
}
    38ea:	70e2                	ld	ra,56(sp)
    38ec:	5502                	lw	a0,32(sp)
    38ee:	6109                	addi	sp,sp,128
    38f0:	8082                	ret

00000000000038f2 <sscanf>:
{
    38f2:	7159                	addi	sp,sp,-112
    va_start(ap, format);
    38f4:	04010e13          	addi	t3,sp,64
{
    38f8:	8eaa                	mv	t4,a0
    ctx.fd = -1;
    38fa:	537d                	li	t1,-1
{
    38fc:	e0b2                	sd	a2,64(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    38fe:	0808                	addi	a0,sp,16
    3900:	8672                	mv	a2,t3
{
    3902:	fc06                	sd	ra,56(sp)
    3904:	e4b6                	sd	a3,72(sp)
    3906:	e8ba                	sd	a4,80(sp)
    3908:	ecbe                	sd	a5,88(sp)
    390a:	f0c2                	sd	a6,96(sp)
    390c:	f4c6                	sd	a7,104(sp)
    va_start(ap, format);
    390e:	e472                	sd	t3,8(sp)
    ctx.buf = str;
    3910:	e876                	sd	t4,16(sp)
    ctx.fd = -1;
    3912:	cc1a                	sw	t1,24(sp)
    ctx.pos = 0;
    3914:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    3916:	d41a                	sw	t1,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    3918:	81efd0ef          	jal	936 <_vscanf_core.constprop.0>
}
    391c:	70e2                	ld	ra,56(sp)
    391e:	6165                	addi	sp,sp,112
    3920:	8082                	ret

0000000000003922 <scanf>:
{
    3922:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    3924:	04810313          	addi	t1,sp,72
{
    3928:	e4ae                	sd	a1,72(sp)
    392a:	e8b2                	sd	a2,80(sp)
    392c:	f4be                	sd	a5,104(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    392e:	85aa                	mv	a1,a0
    ctx.ungotten = -1;
    3930:	57fd                	li	a5,-1
    int ret = _vscanf_core(&ctx, format, ap);
    3932:	0808                	addi	a0,sp,16
    3934:	861a                	mv	a2,t1
{
    3936:	fc06                	sd	ra,56(sp)
    3938:	ecb6                	sd	a3,88(sp)
    393a:	f0ba                	sd	a4,96(sp)
    393c:	f8c2                	sd	a6,112(sp)
    393e:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    3940:	e41a                	sd	t1,8(sp)
    ctx.buf = NULL;
    3942:	e802                	sd	zero,16(sp)
    ctx.fd = STDIN_FD;
    3944:	cc02                	sw	zero,24(sp)
    ctx.pos = 0;
    3946:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    3948:	d43e                	sw	a5,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    394a:	fedfc0ef          	jal	936 <_vscanf_core.constprop.0>
}
    394e:	70e2                	ld	ra,56(sp)
    3950:	6109                	addi	sp,sp,128
    3952:	8082                	ret

0000000000003954 <fopen>:
{
    3954:	1101                	addi	sp,sp,-32
    3956:	e426                	sd	s1,8(sp)
    3958:	84ae                	mv	s1,a1
    395a:	e04a                	sd	s2,0(sp)
    if (strcmp(mode, "r") == 0)
    395c:	00001597          	auipc	a1,0x1
    3960:	71458593          	addi	a1,a1,1812 # 5070 <_GLOBAL__sub_I__ZSt3cin+0xc2>
{
    3964:	892a                	mv	s2,a0
    if (strcmp(mode, "r") == 0)
    3966:	8526                	mv	a0,s1
{
    3968:	e822                	sd	s0,16(sp)
    396a:	ec06                	sd	ra,24(sp)
    if (strcmp(mode, "r") == 0)
    396c:	298010ef          	jal	4c04 <strcmp>
    3970:	842a                	mv	s0,a0
    3972:	c919                	beqz	a0,3988 <fopen+0x34>
    else if (strcmp(mode, "w") == 0)
    3974:	00001597          	auipc	a1,0x1
    3978:	70458593          	addi	a1,a1,1796 # 5078 <_GLOBAL__sub_I__ZSt3cin+0xca>
    397c:	8526                	mv	a0,s1
    397e:	286010ef          	jal	4c04 <strcmp>
        flags = O_WRONLY | O_CREAT | O_TRUNC;
    3982:	24100413          	li	s0,577
    else if (strcmp(mode, "w") == 0)
    3986:	ed39                	bnez	a0,39e4 <fopen+0x90>
    int64 fd = open(filename, flags);
    3988:	85a2                	mv	a1,s0
    398a:	854a                	mv	a0,s2
    398c:	f42fc0ef          	jal	ce <open>
    3990:	84aa                	mv	s1,a0
    if (fd < 0)
    3992:	06054c63          	bltz	a0,3a0a <fopen+0xb6>
    FILE *f = (FILE *)malloc(sizeof(FILE));
    3996:	42000513          	li	a0,1056
    399a:	2f3000ef          	jal	448c <malloc>
    399e:	892a                	mv	s2,a0
    if (!f)
    39a0:	c53d                	beqz	a0,3a0e <fopen+0xba>
    memset(f, 0, sizeof(FILE));
    39a2:	42000613          	li	a2,1056
    39a6:	4581                	li	a1,0
    39a8:	0ee010ef          	jal	4a96 <memset>
    if (fd == 1)
    39ac:	4785                	li	a5,1
    f->fd = (int)fd;
    39ae:	00992023          	sw	s1,0(s2)
    f->flags = flags;
    39b2:	00892223          	sw	s0,4(s2)
    if (fd == 1)
    39b6:	00f48e63          	beq	s1,a5,39d2 <fopen+0x7e>
    else if (fd == 2)
    39ba:	4789                	li	a5,2
    39bc:	00f48b63          	beq	s1,a5,39d2 <fopen+0x7e>
        f->buf_mode = 0;
    39c0:	40092e23          	sw	zero,1052(s2)
}
    39c4:	60e2                	ld	ra,24(sp)
    39c6:	6442                	ld	s0,16(sp)
    39c8:	64a2                	ld	s1,8(sp)
    39ca:	854a                	mv	a0,s2
    39cc:	6902                	ld	s2,0(sp)
    39ce:	6105                	addi	sp,sp,32
    39d0:	8082                	ret
    39d2:	60e2                	ld	ra,24(sp)
    39d4:	6442                	ld	s0,16(sp)
        f->buf_mode = 2;
    39d6:	40992e23          	sw	s1,1052(s2)
}
    39da:	854a                	mv	a0,s2
    39dc:	64a2                	ld	s1,8(sp)
    39de:	6902                	ld	s2,0(sp)
    39e0:	6105                	addi	sp,sp,32
    39e2:	8082                	ret
    else if (strcmp(mode, "a") == 0)
    39e4:	00001597          	auipc	a1,0x1
    39e8:	69c58593          	addi	a1,a1,1692 # 5080 <_GLOBAL__sub_I__ZSt3cin+0xd2>
    39ec:	8526                	mv	a0,s1
    39ee:	216010ef          	jal	4c04 <strcmp>
        flags = O_WRONLY | O_CREAT | O_APPEND;
    39f2:	44100413          	li	s0,1089
    else if (strcmp(mode, "a") == 0)
    39f6:	d949                	beqz	a0,3988 <fopen+0x34>
    else if (strcmp(mode, "r+") == 0)
    39f8:	00001597          	auipc	a1,0x1
    39fc:	69058593          	addi	a1,a1,1680 # 5088 <_GLOBAL__sub_I__ZSt3cin+0xda>
    3a00:	8526                	mv	a0,s1
    3a02:	202010ef          	jal	4c04 <strcmp>
        flags = O_RDWR;
    3a06:	4409                	li	s0,2
    else if (strcmp(mode, "r+") == 0)
    3a08:	d141                	beqz	a0,3988 <fopen+0x34>
        return NULL;
    3a0a:	4901                	li	s2,0
    3a0c:	bf65                	j	39c4 <fopen+0x70>
        close(fd);
    3a0e:	8526                	mv	a0,s1
    3a10:	ea6fc0ef          	jal	b6 <close>
        return NULL;
    3a14:	4901                	li	s2,0
    3a16:	b77d                	j	39c4 <fopen+0x70>

0000000000003a18 <fclose>:
    if (!stream)
    3a18:	cd29                	beqz	a0,3a72 <fclose+0x5a>
    if (stream->buf_write_pos > 0)
    3a1a:	41052603          	lw	a2,1040(a0)
{
    3a1e:	1141                	addi	sp,sp,-16
    3a20:	e022                	sd	s0,0(sp)
    3a22:	e406                	sd	ra,8(sp)
    3a24:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    3a26:	02c04a63          	bgtz	a2,3a5a <fclose+0x42>
    if (stream != stdin && stream != stdout && stream != stderr)
    3a2a:	00004797          	auipc	a5,0x4
    3a2e:	bf678793          	addi	a5,a5,-1034 # 7620 <stdout>
    3a32:	6798                	ld	a4,8(a5)
    3a34:	00870e63          	beq	a4,s0,3a50 <fclose+0x38>
    3a38:	6398                	ld	a4,0(a5)
    3a3a:	00870b63          	beq	a4,s0,3a50 <fclose+0x38>
    3a3e:	6b9c                	ld	a5,16(a5)
    3a40:	00878863          	beq	a5,s0,3a50 <fclose+0x38>
        close(stream->fd);
    3a44:	4008                	lw	a0,0(s0)
    3a46:	e70fc0ef          	jal	b6 <close>
        free(stream);
    3a4a:	8522                	mv	a0,s0
    3a4c:	1cb000ef          	jal	4416 <free>
}
    3a50:	60a2                	ld	ra,8(sp)
    3a52:	6402                	ld	s0,0(sp)
    return 0;
    3a54:	4501                	li	a0,0
}
    3a56:	0141                	addi	sp,sp,16
    3a58:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3a5a:	4108                	lw	a0,0(a0)
    3a5c:	01040593          	addi	a1,s0,16
    3a60:	e4efc0ef          	jal	ae <write>
        if (ret < stream->buf_write_pos)
    3a64:	41042783          	lw	a5,1040(s0)
    3a68:	00f54763          	blt	a0,a5,3a76 <fclose+0x5e>
        stream->buf_write_pos = 0;
    3a6c:	40042823          	sw	zero,1040(s0)
    3a70:	bf6d                	j	3a2a <fclose+0x12>
        return -1;
    3a72:	557d                	li	a0,-1
}
    3a74:	8082                	ret
            stream->error = 1;
    3a76:	4785                	li	a5,1
    3a78:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3a7a:	40042823          	sw	zero,1040(s0)
            return EOF;
    3a7e:	b775                	j	3a2a <fclose+0x12>

0000000000003a80 <fflush>:
    if (!stream)
    3a80:	c121                	beqz	a0,3ac0 <fflush+0x40>
    if (stream->buf_write_pos > 0)
    3a82:	41052603          	lw	a2,1040(a0)
{
    3a86:	1141                	addi	sp,sp,-16
    3a88:	e022                	sd	s0,0(sp)
    3a8a:	e406                	sd	ra,8(sp)
    3a8c:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    3a8e:	00c04763          	bgtz	a2,3a9c <fflush+0x1c>
    return 0;
    3a92:	4501                	li	a0,0
}
    3a94:	60a2                	ld	ra,8(sp)
    3a96:	6402                	ld	s0,0(sp)
    3a98:	0141                	addi	sp,sp,16
    3a9a:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3a9c:	4108                	lw	a0,0(a0)
    3a9e:	01040593          	addi	a1,s0,16
    3aa2:	e0cfc0ef          	jal	ae <write>
        if (ret < stream->buf_write_pos)
    3aa6:	41042783          	lw	a5,1040(s0)
    3aaa:	00f54563          	blt	a0,a5,3ab4 <fflush+0x34>
        stream->buf_write_pos = 0;
    3aae:	40042823          	sw	zero,1040(s0)
    3ab2:	b7c5                	j	3a92 <fflush+0x12>
            stream->error = 1;
    3ab4:	4785                	li	a5,1
    3ab6:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3ab8:	40042823          	sw	zero,1040(s0)
        return EOF;
    3abc:	557d                	li	a0,-1
    3abe:	bfd9                	j	3a94 <fflush+0x14>
    3ac0:	557d                	li	a0,-1
}
    3ac2:	8082                	ret

0000000000003ac4 <fprintf>:
{
    3ac4:	7159                	addi	sp,sp,-112
    3ac6:	fc06                	sd	ra,56(sp)
    3ac8:	e0b2                	sd	a2,64(sp)
    3aca:	e4b6                	sd	a3,72(sp)
    3acc:	e8ba                	sd	a4,80(sp)
    3ace:	ecbe                	sd	a5,88(sp)
    3ad0:	f0c2                	sd	a6,96(sp)
    3ad2:	f4c6                	sd	a7,104(sp)
    if (!stream)
    3ad4:	cd19                	beqz	a0,3af2 <fprintf+0x2e>
    va_start(ap, format);
    3ad6:	832a                	mv	t1,a0
    3ad8:	0090                	addi	a2,sp,64
    _vprintf_core(&ctx, format, ap);
    3ada:	0808                	addi	a0,sp,16
    va_start(ap, format);
    3adc:	e432                	sd	a2,8(sp)
    ctx.buf = NULL;
    3ade:	e802                	sd	zero,16(sp)
    ctx.limit = 0;
    3ae0:	ec02                	sd	zero,24(sp)
    ctx.written = 0;
    3ae2:	f002                	sd	zero,32(sp)
    ctx.stream  = stream;
    3ae4:	f41a                	sd	t1,40(sp)
    _vprintf_core(&ctx, format, ap);
    3ae6:	d34ff0ef          	jal	301a <_vprintf_core.constprop.0.isra.0>
    return (int)ctx.written;
    3aea:	5502                	lw	a0,32(sp)
}
    3aec:	70e2                	ld	ra,56(sp)
    3aee:	6165                	addi	sp,sp,112
    3af0:	8082                	ret
        return -1;
    3af2:	557d                	li	a0,-1
    3af4:	bfe5                	j	3aec <fprintf+0x28>

0000000000003af6 <fscanf>:
{
    3af6:	7159                	addi	sp,sp,-112
    3af8:	fc06                	sd	ra,56(sp)
    3afa:	e0b2                	sd	a2,64(sp)
    3afc:	e4b6                	sd	a3,72(sp)
    3afe:	e8ba                	sd	a4,80(sp)
    3b00:	ecbe                	sd	a5,88(sp)
    3b02:	f0c2                	sd	a6,96(sp)
    3b04:	f4c6                	sd	a7,104(sp)
    if (!stream)
    3b06:	cd19                	beqz	a0,3b24 <fscanf+0x2e>
    ctx.fd = stream->fd;
    3b08:	411c                	lw	a5,0(a0)
    va_start(ap, format);
    3b0a:	0090                	addi	a2,sp,64
    int ret = _vscanf_core(&ctx, format, ap);
    3b0c:	0808                	addi	a0,sp,16
    ctx.fd = stream->fd;
    3b0e:	cc3e                	sw	a5,24(sp)
    ctx.ungotten = -1;
    3b10:	57fd                	li	a5,-1
    va_start(ap, format);
    3b12:	e432                	sd	a2,8(sp)
    ctx.buf = NULL;
    3b14:	e802                	sd	zero,16(sp)
    ctx.pos = 0;
    3b16:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    3b18:	d43e                	sw	a5,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    3b1a:	e1dfc0ef          	jal	936 <_vscanf_core.constprop.0>
}
    3b1e:	70e2                	ld	ra,56(sp)
    3b20:	6165                	addi	sp,sp,112
    3b22:	8082                	ret
        return -1;
    3b24:	557d                	li	a0,-1
    3b26:	bfe5                	j	3b1e <fscanf+0x28>

0000000000003b28 <fputc>:
    if (!stream)
    3b28:	c1e1                	beqz	a1,3be8 <fputc+0xc0>
{
    3b2a:	7179                	addi	sp,sp,-48
    3b2c:	e84a                	sd	s2,16(sp)
    if (stream->buf_mode == 2)
    3b2e:	41c5a903          	lw	s2,1052(a1)
{
    3b32:	f022                	sd	s0,32(sp)
    3b34:	ec26                	sd	s1,24(sp)
    3b36:	f406                	sd	ra,40(sp)
    if (stream->buf_mode == 2)
    3b38:	4789                	li	a5,2
    3b3a:	842e                	mv	s0,a1
    3b3c:	84aa                	mv	s1,a0
        char ch = (char)c;
    3b3e:	0ff57713          	zext.b	a4,a0
    if (stream->buf_mode == 2)
    3b42:	02f90963          	beq	s2,a5,3b74 <fputc+0x4c>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    3b46:	4105a783          	lw	a5,1040(a1)
    if (stream->buf_write_pos >= BUFSIZ)
    3b4a:	3ff00693          	li	a3,1023
    stream->buffer[stream->buf_write_pos++] = (char)c;
    3b4e:	0017861b          	addiw	a2,a5,1
    3b52:	40c5a823          	sw	a2,1040(a1)
    3b56:	97ae                	add	a5,a5,a1
    3b58:	00e78823          	sb	a4,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    3b5c:	06c6c463          	blt	a3,a2,3bc4 <fputc+0x9c>
    else if (stream->buf_mode == 1 && c == '\n')
    3b60:	4785                	li	a5,1
    3b62:	02f90e63          	beq	s2,a5,3b9e <fputc+0x76>
    return c;
    3b66:	8526                	mv	a0,s1
}
    3b68:	70a2                	ld	ra,40(sp)
    3b6a:	7402                	ld	s0,32(sp)
    3b6c:	64e2                	ld	s1,24(sp)
    3b6e:	6942                	ld	s2,16(sp)
    3b70:	6145                	addi	sp,sp,48
    3b72:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    3b74:	4188                	lw	a0,0(a1)
    3b76:	4605                	li	a2,1
    3b78:	00f10593          	addi	a1,sp,15
        char ch = (char)c;
    3b7c:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    3b80:	d2efc0ef          	jal	ae <write>
    3b84:	872a                	mv	a4,a0
    3b86:	4785                	li	a5,1
        return c;
    3b88:	8526                	mv	a0,s1
        if (write(stream->fd, &ch, 1) != 1)
    3b8a:	fcf70fe3          	beq	a4,a5,3b68 <fputc+0x40>
}
    3b8e:	70a2                	ld	ra,40(sp)
            stream->error = 1;
    3b90:	c41c                	sw	a5,8(s0)
}
    3b92:	7402                	ld	s0,32(sp)
    3b94:	64e2                	ld	s1,24(sp)
    3b96:	6942                	ld	s2,16(sp)
            return EOF;
    3b98:	557d                	li	a0,-1
}
    3b9a:	6145                	addi	sp,sp,48
    3b9c:	8082                	ret
    else if (stream->buf_mode == 1 && c == '\n')
    3b9e:	47a9                	li	a5,10
    3ba0:	fcf513e3          	bne	a0,a5,3b66 <fputc+0x3e>
    if (stream->buf_write_pos > 0)
    3ba4:	fcc051e3          	blez	a2,3b66 <fputc+0x3e>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3ba8:	4188                	lw	a0,0(a1)
    3baa:	05c1                	addi	a1,a1,16
    3bac:	d02fc0ef          	jal	ae <write>
        if (ret < stream->buf_write_pos)
    3bb0:	41042783          	lw	a5,1040(s0)
    3bb4:	02f55063          	bge	a0,a5,3bd4 <fputc+0xac>
            stream->error = 1;
    3bb8:	01242423          	sw	s2,8(s0)
            stream->buf_write_pos = 0;
    3bbc:	40042823          	sw	zero,1040(s0)
    return c;
    3bc0:	8526                	mv	a0,s1
    3bc2:	b75d                	j	3b68 <fputc+0x40>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3bc4:	4188                	lw	a0,0(a1)
    3bc6:	05c1                	addi	a1,a1,16
    3bc8:	ce6fc0ef          	jal	ae <write>
        if (ret < stream->buf_write_pos)
    3bcc:	41042783          	lw	a5,1040(s0)
    3bd0:	00f54663          	blt	a0,a5,3bdc <fputc+0xb4>
        stream->buf_write_pos = 0;
    3bd4:	40042823          	sw	zero,1040(s0)
    return c;
    3bd8:	8526                	mv	a0,s1
    3bda:	b779                	j	3b68 <fputc+0x40>
            stream->error = 1;
    3bdc:	4785                	li	a5,1
    3bde:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3be0:	40042823          	sw	zero,1040(s0)
    return c;
    3be4:	8526                	mv	a0,s1
    3be6:	b749                	j	3b68 <fputc+0x40>
        return EOF;
    3be8:	557d                	li	a0,-1
}
    3bea:	8082                	ret

0000000000003bec <fputs>:
    if (!stream)
    3bec:	c1ed                	beqz	a1,3cce <fputs+0xe2>
{
    3bee:	711d                	addi	sp,sp,-96
    3bf0:	e4a6                	sd	s1,72(sp)
    3bf2:	ec86                	sd	ra,88(sp)
    while (*s)
    3bf4:	00054703          	lbu	a4,0(a0)
    3bf8:	84aa                	mv	s1,a0
    3bfa:	cf25                	beqz	a4,3c72 <fputs+0x86>
    3bfc:	e8a2                	sd	s0,80(sp)
    3bfe:	e0ca                	sd	s2,64(sp)
    3c00:	fc4e                	sd	s3,56(sp)
    3c02:	f852                	sd	s4,48(sp)
    3c04:	f456                	sd	s5,40(sp)
    3c06:	f05a                	sd	s6,32(sp)
    3c08:	ec5e                	sd	s7,24(sp)
    3c0a:	842e                	mv	s0,a1
    if (stream->buf_mode == 2)
    3c0c:	4909                	li	s2,2
    if (stream->buf_write_pos >= BUFSIZ)
    3c0e:	3ff00b13          	li	s6,1023
    else if (stream->buf_mode == 1 && c == '\n')
    3c12:	4985                	li	s3,1
    3c14:	4a29                	li	s4,10
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3c16:	01058a93          	addi	s5,a1,16
        if (write(stream->fd, &ch, 1) != 1)
    3c1a:	00f10b93          	addi	s7,sp,15
    3c1e:	a031                	j	3c2a <fputs+0x3e>
    else if (stream->buf_mode == 1 && c == '\n')
    3c20:	09368563          	beq	a3,s3,3caa <fputs+0xbe>
    while (*s)
    3c24:	0004c703          	lbu	a4,0(s1)
    3c28:	cf15                	beqz	a4,3c64 <fputs+0x78>
    if (stream->buf_mode == 2)
    3c2a:	41c42683          	lw	a3,1052(s0)
        if (fputc(*s++, stream) == EOF)
    3c2e:	0485                	addi	s1,s1,1
    if (stream->buf_mode == 2)
    3c30:	05268663          	beq	a3,s2,3c7c <fputs+0x90>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    3c34:	41042783          	lw	a5,1040(s0)
    3c38:	0017861b          	addiw	a2,a5,1
    3c3c:	40c42823          	sw	a2,1040(s0)
    3c40:	97a2                	add	a5,a5,s0
    3c42:	00e78823          	sb	a4,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    3c46:	fccb5de3          	bge	s6,a2,3c20 <fputs+0x34>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3c4a:	4008                	lw	a0,0(s0)
    3c4c:	85d6                	mv	a1,s5
    3c4e:	c60fc0ef          	jal	ae <write>
        if (ret < stream->buf_write_pos)
    3c52:	41042783          	lw	a5,1040(s0)
    3c56:	06f54763          	blt	a0,a5,3cc4 <fputs+0xd8>
        stream->buf_write_pos = 0;
    3c5a:	40042823          	sw	zero,1040(s0)
    while (*s)
    3c5e:	0004c703          	lbu	a4,0(s1)
    3c62:	f761                	bnez	a4,3c2a <fputs+0x3e>
    3c64:	6446                	ld	s0,80(sp)
    3c66:	6906                	ld	s2,64(sp)
    3c68:	79e2                	ld	s3,56(sp)
    3c6a:	7a42                	ld	s4,48(sp)
    3c6c:	7aa2                	ld	s5,40(sp)
    3c6e:	7b02                	ld	s6,32(sp)
    3c70:	6be2                	ld	s7,24(sp)
}
    3c72:	60e6                	ld	ra,88(sp)
    3c74:	64a6                	ld	s1,72(sp)
    return 0;
    3c76:	4501                	li	a0,0
}
    3c78:	6125                	addi	sp,sp,96
    3c7a:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    3c7c:	4008                	lw	a0,0(s0)
    3c7e:	4605                	li	a2,1
    3c80:	85de                	mv	a1,s7
        char ch = (char)c;
    3c82:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    3c86:	c28fc0ef          	jal	ae <write>
    3c8a:	f9350de3          	beq	a0,s3,3c24 <fputs+0x38>
            stream->error = 1;
    3c8e:	01342423          	sw	s3,8(s0)
}
    3c92:	60e6                	ld	ra,88(sp)
    3c94:	6446                	ld	s0,80(sp)
    3c96:	6906                	ld	s2,64(sp)
    3c98:	79e2                	ld	s3,56(sp)
    3c9a:	7a42                	ld	s4,48(sp)
    3c9c:	7aa2                	ld	s5,40(sp)
    3c9e:	7b02                	ld	s6,32(sp)
    3ca0:	6be2                	ld	s7,24(sp)
    3ca2:	64a6                	ld	s1,72(sp)
        return -1;
    3ca4:	557d                	li	a0,-1
}
    3ca6:	6125                	addi	sp,sp,96
    3ca8:	8082                	ret
    else if (stream->buf_mode == 1 && c == '\n')
    3caa:	f7471de3          	bne	a4,s4,3c24 <fputs+0x38>
    if (stream->buf_write_pos > 0)
    3cae:	f6c05be3          	blez	a2,3c24 <fputs+0x38>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3cb2:	4008                	lw	a0,0(s0)
    3cb4:	01040593          	addi	a1,s0,16
    3cb8:	bf6fc0ef          	jal	ae <write>
        if (ret < stream->buf_write_pos)
    3cbc:	41042783          	lw	a5,1040(s0)
    3cc0:	f8f55de3          	bge	a0,a5,3c5a <fputs+0x6e>
            stream->error = 1;
    3cc4:	4785                	li	a5,1
    3cc6:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3cc8:	40042823          	sw	zero,1040(s0)
            return EOF;
    3ccc:	bfa1                	j	3c24 <fputs+0x38>
        return -1;
    3cce:	557d                	li	a0,-1
}
    3cd0:	8082                	ret

0000000000003cd2 <fgetc>:
    if (!stream)
    3cd2:	c949                	beqz	a0,3d64 <fgetc+0x92>
    if (stream->buf_write_pos > 0)
    3cd4:	41052603          	lw	a2,1040(a0)
{
    3cd8:	1141                	addi	sp,sp,-16
    3cda:	e022                	sd	s0,0(sp)
    3cdc:	e406                	sd	ra,8(sp)
    3cde:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    3ce0:	04c04863          	bgtz	a2,3d30 <fgetc+0x5e>
    if (stream->buf_read_pos < stream->buf_read_cnt)
    3ce4:	41442783          	lw	a5,1044(s0)
    3ce8:	41842703          	lw	a4,1048(s0)
    3cec:	00e7dd63          	bge	a5,a4,3d06 <fgetc+0x34>
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3cf0:	0017871b          	addiw	a4,a5,1
    3cf4:	40e42a23          	sw	a4,1044(s0)
    3cf8:	943e                	add	s0,s0,a5
    3cfa:	01044503          	lbu	a0,16(s0)
}
    3cfe:	60a2                	ld	ra,8(sp)
    3d00:	6402                	ld	s0,0(sp)
    3d02:	0141                	addi	sp,sp,16
    3d04:	8082                	ret
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3d06:	4008                	lw	a0,0(s0)
    3d08:	40000613          	li	a2,1024
    3d0c:	01040593          	addi	a1,s0,16
    3d10:	b96fc0ef          	jal	a6 <read>
    3d14:	87aa                	mv	a5,a0
    if (ret <= 0)
    3d16:	02a05e63          	blez	a0,3d52 <fgetc+0x80>
    stream->buf_read_cnt = (int)ret;
    3d1a:	40f42c23          	sw	a5,1048(s0)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3d1e:	4785                	li	a5,1
    3d20:	01044503          	lbu	a0,16(s0)
}
    3d24:	60a2                	ld	ra,8(sp)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3d26:	40f42a23          	sw	a5,1044(s0)
}
    3d2a:	6402                	ld	s0,0(sp)
    3d2c:	0141                	addi	sp,sp,16
    3d2e:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3d30:	4108                	lw	a0,0(a0)
    3d32:	01040593          	addi	a1,s0,16
    3d36:	b78fc0ef          	jal	ae <write>
        if (ret < stream->buf_write_pos)
    3d3a:	41042783          	lw	a5,1040(s0)
    3d3e:	00f54563          	blt	a0,a5,3d48 <fgetc+0x76>
        stream->buf_write_pos = 0;
    3d42:	40042823          	sw	zero,1040(s0)
    3d46:	bf79                	j	3ce4 <fgetc+0x12>
            stream->error = 1;
    3d48:	4785                	li	a5,1
    3d4a:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3d4c:	40042823          	sw	zero,1040(s0)
            return EOF;
    3d50:	bf51                	j	3ce4 <fgetc+0x12>
        if (ret == 0)
    3d52:	e509                	bnez	a0,3d5c <fgetc+0x8a>
            stream->eof = 1;
    3d54:	4785                	li	a5,1
    3d56:	c45c                	sw	a5,12(s0)
        return EOF;
    3d58:	557d                	li	a0,-1
    3d5a:	b755                	j	3cfe <fgetc+0x2c>
            stream->error = 1;
    3d5c:	4785                	li	a5,1
    3d5e:	c41c                	sw	a5,8(s0)
        return EOF;
    3d60:	557d                	li	a0,-1
    3d62:	bf71                	j	3cfe <fgetc+0x2c>
    3d64:	557d                	li	a0,-1
}
    3d66:	8082                	ret

0000000000003d68 <fgets>:
    if (!stream || n <= 0)
    3d68:	ce5d                	beqz	a2,3e26 <fgets+0xbe>
    3d6a:	0ab05e63          	blez	a1,3e26 <fgets+0xbe>
{
    3d6e:	715d                	addi	sp,sp,-80
    3d70:	e0a2                	sd	s0,64(sp)
    3d72:	fc26                	sd	s1,56(sp)
    3d74:	f84a                	sd	s2,48(sp)
    3d76:	f44e                	sd	s3,40(sp)
    3d78:	f052                	sd	s4,32(sp)
    3d7a:	ec56                	sd	s5,24(sp)
    3d7c:	e85a                	sd	s6,16(sp)
    3d7e:	e45e                	sd	s7,8(sp)
    3d80:	e486                	sd	ra,72(sp)
    3d82:	8432                	mv	s0,a2
    3d84:	8aaa                	mv	s5,a0
    3d86:	892a                	mv	s2,a0
    3d88:	fff58b9b          	addiw	s7,a1,-1
    int i = 0, c;
    3d8c:	4481                	li	s1,0
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3d8e:	01060993          	addi	s3,a2,16
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3d92:	4b05                	li	s6,1
        if (c == '\n')
    3d94:	4a29                	li	s4,10
    while (i < n - 1)
    3d96:	05748163          	beq	s1,s7,3dd8 <fgets+0x70>
    if (stream->buf_write_pos > 0)
    3d9a:	41042603          	lw	a2,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3d9e:	85ce                	mv	a1,s3
    if (stream->buf_write_pos > 0)
    3da0:	06c04963          	bgtz	a2,3e12 <fgets+0xaa>
    if (stream->buf_read_pos < stream->buf_read_cnt)
    3da4:	41442783          	lw	a5,1044(s0)
    3da8:	41842703          	lw	a4,1048(s0)
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3dac:	40000613          	li	a2,1024
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3db0:	0017851b          	addiw	a0,a5,1
    3db4:	00f406b3          	add	a3,s0,a5
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3db8:	85ce                	mv	a1,s3
    if (stream->buf_read_pos < stream->buf_read_cnt)
    3dba:	02e7de63          	bge	a5,a4,3df6 <fgets+0x8e>
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3dbe:	40a42a23          	sw	a0,1044(s0)
    3dc2:	0106c783          	lbu	a5,16(a3)
    3dc6:	0007871b          	sext.w	a4,a5
        str[i++] = (char)c;
    3dca:	00f90023          	sb	a5,0(s2)
    3dce:	2485                	addiw	s1,s1,1
        if (c == '\n')
    3dd0:	0905                	addi	s2,s2,1
    3dd2:	fd4712e3          	bne	a4,s4,3d96 <fgets+0x2e>
        str[i++] = (char)c;
    3dd6:	8ba6                	mv	s7,s1
    str[i] = '\0';
    3dd8:	9bd6                	add	s7,s7,s5
    3dda:	000b8023          	sb	zero,0(s7)
    return str;
    3dde:	8556                	mv	a0,s5
}
    3de0:	60a6                	ld	ra,72(sp)
    3de2:	6406                	ld	s0,64(sp)
    3de4:	74e2                	ld	s1,56(sp)
    3de6:	7942                	ld	s2,48(sp)
    3de8:	79a2                	ld	s3,40(sp)
    3dea:	7a02                	ld	s4,32(sp)
    3dec:	6ae2                	ld	s5,24(sp)
    3dee:	6b42                	ld	s6,16(sp)
    3df0:	6ba2                	ld	s7,8(sp)
    3df2:	6161                	addi	sp,sp,80
    3df4:	8082                	ret
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3df6:	4008                	lw	a0,0(s0)
    3df8:	aaefc0ef          	jal	a6 <read>
    if (ret <= 0)
    3dfc:	02a05c63          	blez	a0,3e34 <fgets+0xcc>
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3e00:	01044783          	lbu	a5,16(s0)
    stream->buf_read_cnt = (int)ret;
    3e04:	40a42c23          	sw	a0,1048(s0)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3e08:	41642a23          	sw	s6,1044(s0)
    3e0c:	0007871b          	sext.w	a4,a5
        if (c == -1)
    3e10:	bf6d                	j	3dca <fgets+0x62>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3e12:	4008                	lw	a0,0(s0)
    3e14:	a9afc0ef          	jal	ae <write>
        if (ret < stream->buf_write_pos)
    3e18:	41042783          	lw	a5,1040(s0)
    3e1c:	00f54763          	blt	a0,a5,3e2a <fgets+0xc2>
        stream->buf_write_pos = 0;
    3e20:	40042823          	sw	zero,1040(s0)
    3e24:	b741                	j	3da4 <fgets+0x3c>
        return NULL;
    3e26:	4501                	li	a0,0
}
    3e28:	8082                	ret
            stream->error = 1;
    3e2a:	4785                	li	a5,1
    3e2c:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3e2e:	40042823          	sw	zero,1040(s0)
            return EOF;
    3e32:	bf8d                	j	3da4 <fgets+0x3c>
            stream->eof = 1;
    3e34:	4785                	li	a5,1
        if (ret == 0)
    3e36:	e509                	bnez	a0,3e40 <fgets+0xd8>
            stream->eof = 1;
    3e38:	c45c                	sw	a5,12(s0)
            if (i == 0)
    3e3a:	fcd1                	bnez	s1,3dd6 <fgets+0x6e>
        return NULL;
    3e3c:	4501                	li	a0,0
    3e3e:	b74d                	j	3de0 <fgets+0x78>
            stream->error = 1;
    3e40:	c41c                	sw	a5,8(s0)
        if (c == -1)
    3e42:	bfe5                	j	3e3a <fgets+0xd2>

0000000000003e44 <fread>:
{
    3e44:	715d                	addi	sp,sp,-80
    3e46:	e486                	sd	ra,72(sp)
    3e48:	f44e                	sd	s3,40(sp)
    if (!stream || size == 0 || nmemb == 0)
    3e4a:	0e068963          	beqz	a3,3f3c <fread+0xf8>
    3e4e:	ec56                	sd	s5,24(sp)
        return 0;
    3e50:	4981                	li	s3,0
    3e52:	8aae                	mv	s5,a1
    if (!stream || size == 0 || nmemb == 0)
    3e54:	c9bd                	beqz	a1,3eca <fread+0x86>
    3e56:	ca35                	beqz	a2,3eca <fread+0x86>
    if (stream->buf_write_pos > 0)
    3e58:	4106a783          	lw	a5,1040(a3)
    3e5c:	e0a2                	sd	s0,64(sp)
    3e5e:	f052                	sd	s4,32(sp)
    uint64 total_bytes = size * nmemb;
    3e60:	02c589b3          	mul	s3,a1,a2
    3e64:	8436                	mv	s0,a3
    3e66:	8a2a                	mv	s4,a0
    if (stream->buf_write_pos > 0)
    3e68:	0af04d63          	bgtz	a5,3f22 <fread+0xde>
    while (bytes_read < total_bytes)
    3e6c:	04098d63          	beqz	s3,3ec6 <fread+0x82>
    3e70:	fc26                	sd	s1,56(sp)
    3e72:	e85a                	sd	s6,16(sp)
    3e74:	e45e                	sd	s7,8(sp)
    3e76:	f84a                	sd	s2,48(sp)
    3e78:	4481                	li	s1,0
            if (remaining >= BUFSIZ)
    3e7a:	3ff00b13          	li	s6,1023
                int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3e7e:	01040b93          	addi	s7,s0,16
        if (stream->buf_read_pos < stream->buf_read_cnt)
    3e82:	41442703          	lw	a4,1044(s0)
    3e86:	41842783          	lw	a5,1048(s0)
            uint64 remaining = total_bytes - bytes_read;
    3e8a:	40998633          	sub	a2,s3,s1
        if (stream->buf_read_pos < stream->buf_read_cnt)
    3e8e:	06f74463          	blt	a4,a5,3ef6 <fread+0xb2>
                int64 ret = read(stream->fd, dst + bytes_read, remaining);
    3e92:	4008                	lw	a0,0(s0)
    3e94:	009a05b3          	add	a1,s4,s1
            if (remaining >= BUFSIZ)
    3e98:	02cb7f63          	bgeu	s6,a2,3ed6 <fread+0x92>
                int64 ret = read(stream->fd, dst + bytes_read, remaining);
    3e9c:	a0afc0ef          	jal	a6 <read>
                if (ret <= 0)
    3ea0:	0aa05463          	blez	a0,3f48 <fread+0x104>
                bytes_read += ret;
    3ea4:	94aa                	add	s1,s1,a0
    while (bytes_read < total_bytes)
    3ea6:	fd34eee3          	bltu	s1,s3,3e82 <fread+0x3e>
    return bytes_read / size;
    3eaa:	0354d9b3          	divu	s3,s1,s5
    3eae:	6406                	ld	s0,64(sp)
}
    3eb0:	60a6                	ld	ra,72(sp)
    return bytes_read / size;
    3eb2:	74e2                	ld	s1,56(sp)
    3eb4:	7942                	ld	s2,48(sp)
    3eb6:	7a02                	ld	s4,32(sp)
    3eb8:	6ae2                	ld	s5,24(sp)
    3eba:	6b42                	ld	s6,16(sp)
    3ebc:	6ba2                	ld	s7,8(sp)
}
    3ebe:	854e                	mv	a0,s3
    3ec0:	79a2                	ld	s3,40(sp)
    3ec2:	6161                	addi	sp,sp,80
    3ec4:	8082                	ret
    3ec6:	6406                	ld	s0,64(sp)
    3ec8:	7a02                	ld	s4,32(sp)
    3eca:	60a6                	ld	ra,72(sp)
    3ecc:	6ae2                	ld	s5,24(sp)
    3ece:	854e                	mv	a0,s3
    3ed0:	79a2                	ld	s3,40(sp)
    3ed2:	6161                	addi	sp,sp,80
    3ed4:	8082                	ret
                stream->buf_read_pos = 0;
    3ed6:	40042a23          	sw	zero,1044(s0)
                stream->buf_read_cnt = 0;
    3eda:	40042c23          	sw	zero,1048(s0)
                int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3ede:	40000613          	li	a2,1024
    3ee2:	85de                	mv	a1,s7
    3ee4:	9c2fc0ef          	jal	a6 <read>
                if (ret <= 0)
    3ee8:	06a05063          	blez	a0,3f48 <fread+0x104>
                stream->buf_read_cnt = (int)ret;
    3eec:	40a42c23          	sw	a0,1048(s0)
    while (bytes_read < total_bytes)
    3ef0:	f934e9e3          	bltu	s1,s3,3e82 <fread+0x3e>
    3ef4:	bf5d                	j	3eaa <fread+0x66>
            uint64 available = stream->buf_read_cnt - stream->buf_read_pos;
    3ef6:	40e7893b          	subw	s2,a5,a4
            memcpy(dst + bytes_read, stream->buffer + stream->buf_read_pos, to_copy);
    3efa:	00eb85b3          	add	a1,s7,a4
    3efe:	009a0533          	add	a0,s4,s1
            uint64 to_copy = (available < remaining) ? available : remaining;
    3f02:	01267363          	bgeu	a2,s2,3f08 <fread+0xc4>
    3f06:	8932                	mv	s2,a2
            memcpy(dst + bytes_read, stream->buffer + stream->buf_read_pos, to_copy);
    3f08:	864a                	mv	a2,s2
    3f0a:	3e1000ef          	jal	4aea <memcpy>
            stream->buf_read_pos += to_copy;
    3f0e:	41442783          	lw	a5,1044(s0)
            bytes_read += to_copy;
    3f12:	94ca                	add	s1,s1,s2
            stream->buf_read_pos += to_copy;
    3f14:	012787bb          	addw	a5,a5,s2
    3f18:	40f42a23          	sw	a5,1044(s0)
    while (bytes_read < total_bytes)
    3f1c:	f734e3e3          	bltu	s1,s3,3e82 <fread+0x3e>
    3f20:	b769                	j	3eaa <fread+0x66>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3f22:	4288                	lw	a0,0(a3)
    3f24:	863e                	mv	a2,a5
    3f26:	01068593          	addi	a1,a3,16
    3f2a:	984fc0ef          	jal	ae <write>
        if (ret < stream->buf_write_pos)
    3f2e:	41042783          	lw	a5,1040(s0)
    3f32:	02f54163          	blt	a0,a5,3f54 <fread+0x110>
        stream->buf_write_pos = 0;
    3f36:	40042823          	sw	zero,1040(s0)
    3f3a:	bf0d                	j	3e6c <fread+0x28>
}
    3f3c:	60a6                	ld	ra,72(sp)
        return 0;
    3f3e:	4981                	li	s3,0
}
    3f40:	854e                	mv	a0,s3
    3f42:	79a2                	ld	s3,40(sp)
    3f44:	6161                	addi	sp,sp,80
    3f46:	8082                	ret
                        stream->eof = 1;
    3f48:	4785                	li	a5,1
                    if (ret == 0)
    3f4a:	e119                	bnez	a0,3f50 <fread+0x10c>
                        stream->eof = 1;
    3f4c:	c45c                	sw	a5,12(s0)
    3f4e:	bfb1                	j	3eaa <fread+0x66>
                        stream->error = 1;
    3f50:	c41c                	sw	a5,8(s0)
                    return bytes_read / size;
    3f52:	bfa1                	j	3eaa <fread+0x66>
            stream->error = 1;
    3f54:	4785                	li	a5,1
    3f56:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3f58:	40042823          	sw	zero,1040(s0)
            return EOF;
    3f5c:	bf01                	j	3e6c <fread+0x28>

0000000000003f5e <fwrite>:
{
    3f5e:	711d                	addi	sp,sp,-96
    3f60:	ec86                	sd	ra,88(sp)
    3f62:	e0ca                	sd	s2,64(sp)
    if (!stream || !ptr || size == 0 || nmemb == 0)
    3f64:	10068063          	beqz	a3,4064 <fwrite+0x106>
    3f68:	f456                	sd	s5,40(sp)
    3f6a:	8aaa                	mv	s5,a0
    3f6c:	10050263          	beqz	a0,4070 <fwrite+0x112>
    3f70:	f05a                	sd	s6,32(sp)
        return 0;
    3f72:	4901                	li	s2,0
    3f74:	8b2e                	mv	s6,a1
    if (!stream || !ptr || size == 0 || nmemb == 0)
    3f76:	c1d9                	beqz	a1,3ffc <fwrite+0x9e>
    3f78:	c251                	beqz	a2,3ffc <fwrite+0x9e>
    if (stream->buf_mode == 2)
    3f7a:	41c6a703          	lw	a4,1052(a3)
    3f7e:	e8a2                	sd	s0,80(sp)
    3f80:	4789                	li	a5,2
    uint64 total_bytes = size * nmemb;
    3f82:	02c58933          	mul	s2,a1,a2
    if (stream->buf_mode == 2)
    3f86:	8436                	mv	s0,a3
    3f88:	0ef70b63          	beq	a4,a5,407e <fwrite+0x120>
    3f8c:	fc4e                	sd	s3,56(sp)
    3f8e:	ec5e                	sd	s7,24(sp)
    3f90:	e862                	sd	s8,16(sp)
    uint64 bytes_written = 0;
    3f92:	4981                	li	s3,0
    3f94:	01068b93          	addi	s7,a3,16
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    3f98:	40000c13          	li	s8,1024
    while (bytes_written < total_bytes)
    3f9c:	12090263          	beqz	s2,40c0 <fwrite+0x162>
    3fa0:	e4a6                	sd	s1,72(sp)
    3fa2:	f852                	sd	s4,48(sp)
    3fa4:	e466                	sd	s9,8(sp)
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    3fa6:	41042783          	lw	a5,1040(s0)
        uint64 remaining = total_bytes - bytes_written;
    3faa:	41390cb3          	sub	s9,s2,s3
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, remaining);
    3fae:	013a85b3          	add	a1,s5,s3
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    3fb2:	40fc0a3b          	subw	s4,s8,a5
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, space_left);
    3fb6:	00fb8533          	add	a0,s7,a5
    3fba:	8652                	mv	a2,s4
        if (remaining <= space_left)
    3fbc:	059a6763          	bltu	s4,s9,400a <fwrite+0xac>
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, remaining);
    3fc0:	8666                	mv	a2,s9
    3fc2:	329000ef          	jal	4aea <memcpy>
            stream->buf_write_pos += remaining;
    3fc6:	41042783          	lw	a5,1040(s0)
            if (stream->buf_write_pos == BUFSIZ)
    3fca:	40000713          	li	a4,1024
            stream->buf_write_pos += remaining;
    3fce:	019786bb          	addw	a3,a5,s9
    3fd2:	40d42823          	sw	a3,1040(s0)
            if (stream->buf_write_pos == BUFSIZ)
    3fd6:	06e68a63          	beq	a3,a4,404a <fwrite+0xec>
    return bytes_written / size;
    3fda:	03695933          	divu	s2,s2,s6
    3fde:	6446                	ld	s0,80(sp)
    3fe0:	64a6                	ld	s1,72(sp)
    3fe2:	79e2                	ld	s3,56(sp)
    3fe4:	7a42                	ld	s4,48(sp)
    3fe6:	7aa2                	ld	s5,40(sp)
    3fe8:	7b02                	ld	s6,32(sp)
    3fea:	6be2                	ld	s7,24(sp)
    3fec:	6c42                	ld	s8,16(sp)
    3fee:	6ca2                	ld	s9,8(sp)
}
    3ff0:	60e6                	ld	ra,88(sp)
    3ff2:	854a                	mv	a0,s2
    3ff4:	6906                	ld	s2,64(sp)
    3ff6:	6125                	addi	sp,sp,96
    3ff8:	8082                	ret
    3ffa:	6446                	ld	s0,80(sp)
    3ffc:	60e6                	ld	ra,88(sp)
    3ffe:	7aa2                	ld	s5,40(sp)
    4000:	7b02                	ld	s6,32(sp)
    4002:	854a                	mv	a0,s2
    4004:	6906                	ld	s2,64(sp)
    4006:	6125                	addi	sp,sp,96
    4008:	8082                	ret
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, space_left);
    400a:	2e1000ef          	jal	4aea <memcpy>
            stream->buf_write_pos += space_left;
    400e:	41042783          	lw	a5,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4012:	85de                	mv	a1,s7
            bytes_written += space_left;
    4014:	99d2                	add	s3,s3,s4
            stream->buf_write_pos += space_left;
    4016:	00fa04bb          	addw	s1,s4,a5
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    401a:	02049613          	slli	a2,s1,0x20
            stream->buf_write_pos += space_left;
    401e:	40942823          	sw	s1,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4022:	9201                	srli	a2,a2,0x20
    if (stream->buf_write_pos > 0)
    4024:	00904763          	bgtz	s1,4032 <fwrite+0xd4>
    while (bytes_written < total_bytes)
    4028:	f729efe3          	bltu	s3,s2,3fa6 <fwrite+0x48>
    return bytes_written / size;
    402c:	0369d933          	divu	s2,s3,s6
    4030:	b77d                	j	3fde <fwrite+0x80>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4032:	4008                	lw	a0,0(s0)
    4034:	87afc0ef          	jal	ae <write>
        if (ret < stream->buf_write_pos)
    4038:	41042783          	lw	a5,1040(s0)
    403c:	08f54963          	blt	a0,a5,40ce <fwrite+0x170>
        stream->buf_write_pos = 0;
    4040:	40042823          	sw	zero,1040(s0)
    while (bytes_written < total_bytes)
    4044:	f729e1e3          	bltu	s3,s2,3fa6 <fwrite+0x48>
    4048:	b7d5                	j	402c <fwrite+0xce>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    404a:	4008                	lw	a0,0(s0)
    404c:	40000613          	li	a2,1024
    4050:	85de                	mv	a1,s7
    4052:	85cfc0ef          	jal	ae <write>
        if (ret < stream->buf_write_pos)
    4056:	41042783          	lw	a5,1040(s0)
    405a:	08f54163          	blt	a0,a5,40dc <fwrite+0x17e>
        stream->buf_write_pos = 0;
    405e:	40042823          	sw	zero,1040(s0)
    4062:	bfa5                	j	3fda <fwrite+0x7c>
}
    4064:	60e6                	ld	ra,88(sp)
        return 0;
    4066:	4901                	li	s2,0
}
    4068:	854a                	mv	a0,s2
    406a:	6906                	ld	s2,64(sp)
    406c:	6125                	addi	sp,sp,96
    406e:	8082                	ret
    4070:	60e6                	ld	ra,88(sp)
        return 0;
    4072:	4901                	li	s2,0
    4074:	7aa2                	ld	s5,40(sp)
}
    4076:	854a                	mv	a0,s2
    4078:	6906                	ld	s2,64(sp)
    407a:	6125                	addi	sp,sp,96
    407c:	8082                	ret
        while (bytes_written < total_bytes)
    407e:	f6090ee3          	beqz	s2,3ffa <fwrite+0x9c>
    4082:	e4a6                	sd	s1,72(sp)
    uint64 bytes_written = 0;
    4084:	4481                	li	s1,0
    4086:	a021                	j	408e <fwrite+0x130>
            bytes_written += ret;
    4088:	94aa                	add	s1,s1,a0
        while (bytes_written < total_bytes)
    408a:	0324f463          	bgeu	s1,s2,40b2 <fwrite+0x154>
            int64 ret = write(stream->fd, src + bytes_written, total_bytes - bytes_written);
    408e:	4008                	lw	a0,0(s0)
    4090:	40990633          	sub	a2,s2,s1
    4094:	009a85b3          	add	a1,s5,s1
    4098:	816fc0ef          	jal	ae <write>
            if (ret <= 0)
    409c:	fea046e3          	bgtz	a0,4088 <fwrite+0x12a>
                stream->error = 1;
    40a0:	4785                	li	a5,1
        return bytes_written / size;
    40a2:	0364d933          	divu	s2,s1,s6
                stream->error = 1;
    40a6:	c41c                	sw	a5,8(s0)
                break;
    40a8:	64a6                	ld	s1,72(sp)
    40aa:	6446                	ld	s0,80(sp)
    40ac:	7aa2                	ld	s5,40(sp)
    40ae:	7b02                	ld	s6,32(sp)
    40b0:	b781                	j	3ff0 <fwrite+0x92>
        return bytes_written / size;
    40b2:	0364d933          	divu	s2,s1,s6
    40b6:	6446                	ld	s0,80(sp)
    40b8:	64a6                	ld	s1,72(sp)
    40ba:	7aa2                	ld	s5,40(sp)
    40bc:	7b02                	ld	s6,32(sp)
    40be:	bf0d                	j	3ff0 <fwrite+0x92>
    40c0:	6446                	ld	s0,80(sp)
    40c2:	79e2                	ld	s3,56(sp)
    40c4:	7aa2                	ld	s5,40(sp)
    40c6:	7b02                	ld	s6,32(sp)
    40c8:	6be2                	ld	s7,24(sp)
    40ca:	6c42                	ld	s8,16(sp)
    40cc:	b715                	j	3ff0 <fwrite+0x92>
            stream->error = 1;
    40ce:	4785                	li	a5,1
    40d0:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    40d2:	40042823          	sw	zero,1040(s0)
    while (bytes_written < total_bytes)
    40d6:	ed29e8e3          	bltu	s3,s2,3fa6 <fwrite+0x48>
    40da:	bf89                	j	402c <fwrite+0xce>
            stream->error = 1;
    40dc:	4785                	li	a5,1
    40de:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    40e0:	40042823          	sw	zero,1040(s0)
            return EOF;
    40e4:	bddd                	j	3fda <fwrite+0x7c>

00000000000040e6 <fseek>:
    if (!stream)
    40e6:	c925                	beqz	a0,4156 <fseek+0x70>
{
    40e8:	1101                	addi	sp,sp,-32
    40ea:	e04a                	sd	s2,0(sp)
    40ec:	8932                	mv	s2,a2
    if (stream->buf_write_pos > 0)
    40ee:	41052603          	lw	a2,1040(a0)
{
    40f2:	e822                	sd	s0,16(sp)
    40f4:	e426                	sd	s1,8(sp)
    40f6:	ec06                	sd	ra,24(sp)
    40f8:	842a                	mv	s0,a0
    40fa:	84ae                	mv	s1,a1
    if (stream->buf_write_pos > 0)
    40fc:	02c04863          	bgtz	a2,412c <fseek+0x46>
    if (lseek(stream->fd, offset, whence) < 0)
    4100:	4008                	lw	a0,0(s0)
    stream->buf_read_pos = 0;
    4102:	40042a23          	sw	zero,1044(s0)
    stream->buf_read_cnt = 0;
    4106:	40042c23          	sw	zero,1048(s0)
    stream->eof = 0;
    410a:	00042623          	sw	zero,12(s0)
    if (lseek(stream->fd, offset, whence) < 0)
    410e:	864a                	mv	a2,s2
    4110:	0004859b          	sext.w	a1,s1
    4114:	82afc0ef          	jal	13e <lseek>
    4118:	87aa                	mv	a5,a0
    return 0;
    411a:	4501                	li	a0,0
    if (lseek(stream->fd, offset, whence) < 0)
    411c:	0207c463          	bltz	a5,4144 <fseek+0x5e>
}
    4120:	60e2                	ld	ra,24(sp)
    4122:	6442                	ld	s0,16(sp)
    4124:	64a2                	ld	s1,8(sp)
    4126:	6902                	ld	s2,0(sp)
    4128:	6105                	addi	sp,sp,32
    412a:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    412c:	4108                	lw	a0,0(a0)
    412e:	01040593          	addi	a1,s0,16
    4132:	f7dfb0ef          	jal	ae <write>
        if (ret < stream->buf_write_pos)
    4136:	41042783          	lw	a5,1040(s0)
    413a:	00f54963          	blt	a0,a5,414c <fseek+0x66>
        stream->buf_write_pos = 0;
    413e:	40042823          	sw	zero,1040(s0)
    4142:	bf7d                	j	4100 <fseek+0x1a>
        stream->error = 1;
    4144:	4785                	li	a5,1
    4146:	c41c                	sw	a5,8(s0)
        return -1;
    4148:	557d                	li	a0,-1
    414a:	bfd9                	j	4120 <fseek+0x3a>
            stream->error = 1;
    414c:	4785                	li	a5,1
    414e:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4150:	40042823          	sw	zero,1040(s0)
            return EOF;
    4154:	b775                	j	4100 <fseek+0x1a>
        return -1;
    4156:	557d                	li	a0,-1
}
    4158:	8082                	ret

000000000000415a <ftell>:
    if (!stream)
    415a:	c505                	beqz	a0,4182 <ftell+0x28>
{
    415c:	1141                	addi	sp,sp,-16
    415e:	e022                	sd	s0,0(sp)
    4160:	842a                	mv	s0,a0
    int64 ret = lseek(stream->fd, 0, SEEK_CUR);
    4162:	4108                	lw	a0,0(a0)
    4164:	4605                	li	a2,1
    4166:	4581                	li	a1,0
{
    4168:	e406                	sd	ra,8(sp)
    int64 ret = lseek(stream->fd, 0, SEEK_CUR);
    416a:	fd5fb0ef          	jal	13e <lseek>
    if (ret < 0)
    416e:	00054663          	bltz	a0,417a <ftell+0x20>
}
    4172:	60a2                	ld	ra,8(sp)
    4174:	6402                	ld	s0,0(sp)
    4176:	0141                	addi	sp,sp,16
    4178:	8082                	ret
        stream->error = 1;
    417a:	4785                	li	a5,1
    417c:	c41c                	sw	a5,8(s0)
        return -1L;
    417e:	557d                	li	a0,-1
    4180:	bfcd                	j	4172 <ftell+0x18>
    4182:	557d                	li	a0,-1
}
    4184:	8082                	ret

0000000000004186 <rewind>:
    if (stream)
    4186:	c915                	beqz	a0,41ba <rewind+0x34>
    if (stream->buf_write_pos > 0)
    4188:	41052603          	lw	a2,1040(a0)
{
    418c:	1141                	addi	sp,sp,-16
    418e:	e022                	sd	s0,0(sp)
    4190:	e406                	sd	ra,8(sp)
    4192:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    4194:	02c04463          	bgtz	a2,41bc <rewind+0x36>
    if (lseek(stream->fd, offset, whence) < 0)
    4198:	4008                	lw	a0,0(s0)
    stream->buf_read_pos = 0;
    419a:	40042a23          	sw	zero,1044(s0)
    stream->buf_read_cnt = 0;
    419e:	40042c23          	sw	zero,1048(s0)
    stream->eof = 0;
    41a2:	00042623          	sw	zero,12(s0)
    if (lseek(stream->fd, offset, whence) < 0)
    41a6:	4601                	li	a2,0
    41a8:	4581                	li	a1,0
    41aa:	f95fb0ef          	jal	13e <lseek>
}
    41ae:	60a2                	ld	ra,8(sp)
        stream->error = 0;
    41b0:	00042423          	sw	zero,8(s0)
}
    41b4:	6402                	ld	s0,0(sp)
    41b6:	0141                	addi	sp,sp,16
    41b8:	8082                	ret
    41ba:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    41bc:	4108                	lw	a0,0(a0)
    41be:	01040593          	addi	a1,s0,16
    41c2:	eedfb0ef          	jal	ae <write>
        if (ret < stream->buf_write_pos)
    41c6:	41042783          	lw	a5,1040(s0)
    41ca:	00f54563          	blt	a0,a5,41d4 <rewind+0x4e>
        stream->buf_write_pos = 0;
    41ce:	40042823          	sw	zero,1040(s0)
    41d2:	b7d9                	j	4198 <rewind+0x12>
            stream->error = 1;
    41d4:	4785                	li	a5,1
    41d6:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    41d8:	40042823          	sw	zero,1040(s0)
            return EOF;
    41dc:	bf75                	j	4198 <rewind+0x12>

00000000000041de <feof>:
    return (stream) ? stream->eof : 1;
    41de:	c119                	beqz	a0,41e4 <feof+0x6>
    41e0:	4548                	lw	a0,12(a0)
    41e2:	8082                	ret
    41e4:	4505                	li	a0,1
}
    41e6:	8082                	ret

00000000000041e8 <ferror>:
     return (stream) ? stream->error : 1;
    41e8:	c119                	beqz	a0,41ee <ferror+0x6>
    41ea:	4508                	lw	a0,8(a0)
    41ec:	8082                	ret
    41ee:	4505                	li	a0,1
}
    41f0:	8082                	ret

00000000000041f2 <clearerr>:
    if (stream)
    41f2:	c509                	beqz	a0,41fc <clearerr+0xa>
        stream->error = 0;
    41f4:	00052423          	sw	zero,8(a0)
        stream->eof = 0;
    41f8:	00052623          	sw	zero,12(a0)
}
    41fc:	8082                	ret

00000000000041fe <ungetc>:
    if (!stream || c == EOF)
    41fe:	c19d                	beqz	a1,4224 <ungetc+0x26>
    4200:	57fd                	li	a5,-1
    4202:	02f50163          	beq	a0,a5,4224 <ungetc+0x26>
    if (stream->buf_read_pos > 0)
    4206:	4145a783          	lw	a5,1044(a1)
    420a:	00f05d63          	blez	a5,4224 <ungetc+0x26>
        stream->buf_read_pos--;
    420e:	fff7871b          	addiw	a4,a5,-1
    4212:	40e5aa23          	sw	a4,1044(a1)
        stream->buffer[stream->buf_read_pos] = (char)c;
    4216:	00e587b3          	add	a5,a1,a4
    421a:	00a78823          	sb	a0,16(a5)
        stream->eof = 0;
    421e:	0005a623          	sw	zero,12(a1)
        return c;
    4222:	8082                	ret
        return EOF;
    4224:	557d                	li	a0,-1
    4226:	8082                	ret

0000000000004228 <strtoull.part.0>:
    return new_ptr;
}

/* String Conversion*/

unsigned long long strtoull(const char *nptr, char **endptr, int base)
    4228:	1141                	addi	sp,sp,-16
    422a:	e422                	sd	s0,8(sp)
    422c:	8eaa                	mv	t4,a0
{
    const char *s = nptr;
    422e:	88aa                	mv	a7,a0
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    static inline int islower(int c) { return c >= 'a' && c <= 'z'; }
    static inline int isupper(int c) { return c >= 'A' && c <= 'Z'; }
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    static inline int isalnum(int c) { return isalpha(c) || isdigit(c); }
    static inline int isspace(int c) { return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r'; }
    4230:	02000313          	li	t1,32
    4234:	4e11                	li	t3,4
        return 0;
    }

    do
    {
        c = *s++;
    4236:	0008c783          	lbu	a5,0(a7)
    423a:	00188813          	addi	a6,a7,1
    423e:	ff77871b          	addiw	a4,a5,-9
    4242:	0ff77693          	zext.b	a3,a4
    4246:	0007871b          	sext.w	a4,a5
    424a:	04678363          	beq	a5,t1,4290 <strtoull.part.0+0x68>
    424e:	04de7163          	bgeu	t3,a3,4290 <strtoull.part.0+0x68>
    } while (isspace(c));

    if (c == '-')
    4252:	02d00793          	li	a5,45
    4256:	0ef70863          	beq	a4,a5,4346 <strtoull.part.0+0x11e>
    {
        neg = 1;
        c = *s++;
    }
    else if (c == '+')
    425a:	02b00793          	li	a5,43
    int neg = 0, any, cutlim;
    425e:	4381                	li	t2,0
    else if (c == '+')
    4260:	08f70c63          	beq	a4,a5,42f8 <strtoull.part.0+0xd0>
    {
        c = *s++;
    }

    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    4264:	ea05                	bnez	a2,4294 <strtoull.part.0+0x6c>
    4266:	03000793          	li	a5,48
    426a:	0ef70463          	beq	a4,a5,4352 <strtoull.part.0+0x12a>
    426e:	00ccd8b7          	lui	a7,0xccd
    4272:	ccd88893          	addi	a7,a7,-819 # cccccd <_ZSt4cerr+0xcc5515>
    4276:	08b2                	slli	a7,a7,0xc
    4278:	ccd88893          	addi	a7,a7,-819
    427c:	08b2                	slli	a7,a7,0xc
    427e:	ccd88893          	addi	a7,a7,-819
    4282:	08b6                	slli	a7,a7,0xd
    4284:	4415                	li	s0,5
    4286:	99988893          	addi	a7,a7,-1639
    428a:	42a9                	li	t0,10
        c = s[1];
        s += 2;
        base = 16;
    }
    if (base == 0)
        base = (c == '0' ? 8 : 10);
    428c:	4629                	li	a2,10
    428e:	a829                	j	42a8 <strtoull.part.0+0x80>
unsigned long long strtoull(const char *nptr, char **endptr, int base)
    4290:	88c2                	mv	a7,a6
    4292:	b755                	j	4236 <strtoull.part.0+0xe>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    4294:	47c1                	li	a5,16
    4296:	0cf60d63          	beq	a2,a5,4370 <strtoull.part.0+0x148>

    cutoff = ULLONG_MAX / (unsigned long long)base;
    429a:	58fd                	li	a7,-1
    cutlim = ULLONG_MAX % (unsigned long long)base;
    429c:	02c8f433          	remu	s0,a7,a2
    cutoff = ULLONG_MAX / (unsigned long long)base;
    42a0:	82b2                	mv	t0,a2
    42a2:	02c8d8b3          	divu	a7,a7,a2
    cutlim = ULLONG_MAX % (unsigned long long)base;
    42a6:	2401                	sext.w	s0,s0

    for (acc = 0, any = 0;; c = *s++)
    42a8:	4301                	li	t1,0
    42aa:	4501                	li	a0,0
    {
        if (isdigit(c))
    42ac:	4e25                	li	t3,9
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    42ae:	4fe5                	li	t6,25
            break;

        if (c >= base)
            break;

        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    42b0:	5f7d                	li	t5,-1
        if (isdigit(c))
    42b2:	fd07079b          	addiw	a5,a4,-48
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    42b6:	0007069b          	sext.w	a3,a4
    42ba:	00fe7e63          	bgeu	t3,a5,42d6 <strtoull.part.0+0xae>
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    42be:	f9f6879b          	addiw	a5,a3,-97
    42c2:	04fff063          	bgeu	t6,a5,4302 <strtoull.part.0+0xda>
    42c6:	fbf6869b          	addiw	a3,a3,-65
    42ca:	04dfe163          	bltu	t6,a3,430c <strtoull.part.0+0xe4>
            c -= isupper(c) ? 'A' - 10 : 'a' - 10;
    42ce:	03700793          	li	a5,55
    42d2:	40f707bb          	subw	a5,a4,a5
        if (c >= base)
    42d6:	02c7db63          	bge	a5,a2,430c <strtoull.part.0+0xe4>
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    42da:	01e30b63          	beq	t1,t5,42f0 <strtoull.part.0+0xc8>
            any = -1;
    42de:	537d                	li	t1,-1
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    42e0:	00a8e863          	bltu	a7,a0,42f0 <strtoull.part.0+0xc8>
    42e4:	05150e63          	beq	a0,a7,4340 <strtoull.part.0+0x118>
        else
        {
            any = 1;
    42e8:	4305                	li	t1,1
            acc *= base;
    42ea:	02550533          	mul	a0,a0,t0
            acc += c;
    42ee:	953e                	add	a0,a0,a5
    for (acc = 0, any = 0;; c = *s++)
    42f0:	0805                	addi	a6,a6,1
    42f2:	fff84703          	lbu	a4,-1(a6)
        if (isdigit(c))
    42f6:	bf75                	j	42b2 <strtoull.part.0+0x8a>
        c = *s++;
    42f8:	00084703          	lbu	a4,0(a6)
    42fc:	00288813          	addi	a6,a7,2
    4300:	b795                	j	4264 <strtoull.part.0+0x3c>
            c -= isupper(c) ? 'A' - 10 : 'a' - 10;
    4302:	05700793          	li	a5,87
    4306:	40f707bb          	subw	a5,a4,a5
    430a:	b7f1                	j	42d6 <strtoull.part.0+0xae>
        }
    }

    if (any < 0)
    430c:	57fd                	li	a5,-1
    430e:	00f30e63          	beq	t1,a5,432a <strtoull.part.0+0x102>
    {
        acc = ULLONG_MAX;
        errno = ERANGE;
    }
    else if (neg)
    4312:	00038463          	beqz	t2,431a <strtoull.part.0+0xf2>
        acc = -acc;
    4316:	40a00533          	neg	a0,a0

    if (endptr != 0)
    431a:	c589                	beqz	a1,4324 <strtoull.part.0+0xfc>
        *endptr = (char *)(any ? s - 1 : nptr);
    431c:	00031f63          	bnez	t1,433a <strtoull.part.0+0x112>
    4320:	01d5b023          	sd	t4,0(a1)

    return acc;
}
    4324:	6422                	ld	s0,8(sp)
    4326:	0141                	addi	sp,sp,16
    4328:	8082                	ret
        errno = ERANGE;
    432a:	02200793          	li	a5,34
    432e:	00003717          	auipc	a4,0x3
    4332:	34f72923          	sw	a5,850(a4) # 7680 <errno>
        acc = ULLONG_MAX;
    4336:	557d                	li	a0,-1
    if (endptr != 0)
    4338:	d5f5                	beqz	a1,4324 <strtoull.part.0+0xfc>
        *endptr = (char *)(any ? s - 1 : nptr);
    433a:	fff80e93          	addi	t4,a6,-1
    433e:	b7cd                	j	4320 <strtoull.part.0+0xf8>
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    4340:	faf448e3          	blt	s0,a5,42f0 <strtoull.part.0+0xc8>
    4344:	b755                	j	42e8 <strtoull.part.0+0xc0>
        c = *s++;
    4346:	00084703          	lbu	a4,0(a6)
        neg = 1;
    434a:	4385                	li	t2,1
        c = *s++;
    434c:	00288813          	addi	a6,a7,2
    4350:	bf11                	j	4264 <strtoull.part.0+0x3c>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    4352:	00084783          	lbu	a5,0(a6)
    4356:	05800693          	li	a3,88
    435a:	0df7f793          	andi	a5,a5,223
    435e:	02d78b63          	beq	a5,a3,4394 <strtoull.part.0+0x16c>
    4362:	58fd                	li	a7,-1
    4364:	441d                	li	s0,7
    4366:	0038d893          	srli	a7,a7,0x3
    436a:	42a1                	li	t0,8
        base = (c == '0' ? 8 : 10);
    436c:	4621                	li	a2,8
    436e:	bf2d                	j	42a8 <strtoull.part.0+0x80>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    4370:	03000793          	li	a5,48
    4374:	00f70863          	beq	a4,a5,4384 <strtoull.part.0+0x15c>
    4378:	58fd                	li	a7,-1
    437a:	443d                	li	s0,15
    437c:	0048d893          	srli	a7,a7,0x4
    4380:	42c1                	li	t0,16
    4382:	b71d                	j	42a8 <strtoull.part.0+0x80>
    4384:	00084783          	lbu	a5,0(a6)
    4388:	05800693          	li	a3,88
    438c:	0df7f793          	andi	a5,a5,223
    4390:	fed794e3          	bne	a5,a3,4378 <strtoull.part.0+0x150>
        s += 2;
    4394:	58fd                	li	a7,-1
        c = s[1];
    4396:	00184703          	lbu	a4,1(a6)
        s += 2;
    439a:	443d                	li	s0,15
    439c:	0809                	addi	a6,a6,2
    439e:	0048d893          	srli	a7,a7,0x4
    43a2:	42c1                	li	t0,16
        base = 16;
    43a4:	4641                	li	a2,16
    43a6:	b709                	j	42a8 <strtoull.part.0+0x80>

00000000000043a8 <atexit>:
    if (__atexit_func_count >= ATEXIT_MAX)
    43a8:	00003717          	auipc	a4,0x3
    43ac:	2d870713          	addi	a4,a4,728 # 7680 <errno>
    43b0:	435c                	lw	a5,4(a4)
    43b2:	46fd                	li	a3,31
    43b4:	00f6ca63          	blt	a3,a5,43c8 <atexit+0x20>
    __atexit_funcs[__atexit_func_count++] = function;
    43b8:	00379693          	slli	a3,a5,0x3
    43bc:	96ba                	add	a3,a3,a4
    43be:	2785                	addiw	a5,a5,1
    43c0:	e688                	sd	a0,8(a3)
    43c2:	c35c                	sw	a5,4(a4)
    return 0;
    43c4:	4501                	li	a0,0
    43c6:	8082                	ret
        return -1;
    43c8:	557d                	li	a0,-1
}
    43ca:	8082                	ret

00000000000043cc <exit>:
{
    43cc:	1101                	addi	sp,sp,-32
    43ce:	e822                	sd	s0,16(sp)
    while (__atexit_func_count > 0)
    43d0:	00003417          	auipc	s0,0x3
    43d4:	2b040413          	addi	s0,s0,688 # 7680 <errno>
    43d8:	405c                	lw	a5,4(s0)
{
    43da:	e426                	sd	s1,8(sp)
    43dc:	ec06                	sd	ra,24(sp)
    43de:	84aa                	mv	s1,a0
    while (__atexit_func_count > 0)
    43e0:	00f05d63          	blez	a5,43fa <exit+0x2e>
        (__atexit_funcs[--__atexit_func_count])();
    43e4:	fff7871b          	addiw	a4,a5,-1
    43e8:	87ba                	mv	a5,a4
    43ea:	070e                	slli	a4,a4,0x3
    43ec:	9722                	add	a4,a4,s0
    43ee:	6718                	ld	a4,8(a4)
    43f0:	c05c                	sw	a5,4(s0)
    43f2:	9702                	jalr	a4
    while (__atexit_func_count > 0)
    43f4:	405c                	lw	a5,4(s0)
    43f6:	fef047e3          	bgtz	a5,43e4 <exit+0x18>
    sys_exit(status);
    43fa:	8526                	mv	a0,s1
    43fc:	c8bfb0ef          	jal	86 <sys_exit>
    while (1)
    4400:	a001                	j	4400 <exit+0x34>

0000000000004402 <abort>:
{
    4402:	1141                	addi	sp,sp,-16
    exit(127);
    4404:	07f00513          	li	a0,127
{
    4408:	e406                	sd	ra,8(sp)
    exit(127);
    440a:	fc3ff0ef          	jal	43cc <exit>

000000000000440e <getenv>:
}
    440e:	4501                	li	a0,0
    4410:	8082                	ret

0000000000004412 <system>:
}
    4412:	557d                	li	a0,-1
    4414:	8082                	ret

0000000000004416 <free>:
    if (!ptr)
    4416:	c121                	beqz	a0,4456 <free+0x40>
    for (p = freep; !(bp > p && bp < p->next); p = p->next)
    4418:	00003617          	auipc	a2,0x3
    441c:	26860613          	addi	a2,a2,616 # 7680 <errno>
    4420:	10863783          	ld	a5,264(a2)
    bp = (header_t *)ptr - 1;
    4424:	ff050693          	addi	a3,a0,-16
        if (p >= p->next && (bp > p || bp < p->next))
    4428:	6798                	ld	a4,8(a5)
    for (p = freep; !(bp > p && bp < p->next); p = p->next)
    442a:	02d7f763          	bgeu	a5,a3,4458 <free+0x42>
    442e:	00e6e463          	bltu	a3,a4,4436 <free+0x20>
        if (p >= p->next && (bp > p || bp < p->next))
    4432:	02e7e763          	bltu	a5,a4,4460 <free+0x4a>
    if ((char *)bp + bp->size == (char *)p->next)
    4436:	ff053583          	ld	a1,-16(a0)
    443a:	00b68833          	add	a6,a3,a1
    443e:	03070363          	beq	a4,a6,4464 <free+0x4e>
    if ((char *)p + p->size == (char *)bp)
    4442:	638c                	ld	a1,0(a5)
    4444:	fee53c23          	sd	a4,-8(a0)
    4448:	00b78833          	add	a6,a5,a1
    444c:	03068963          	beq	a3,a6,447e <free+0x68>
    4450:	e794                	sd	a3,8(a5)
    freep = p;
    4452:	10f63423          	sd	a5,264(a2)
}
    4456:	8082                	ret
        if (p >= p->next && (bp > p || bp < p->next))
    4458:	00e7e463          	bltu	a5,a4,4460 <free+0x4a>
    445c:	fce6ede3          	bltu	a3,a4,4436 <free+0x20>
{
    4460:	87ba                	mv	a5,a4
    4462:	b7d9                	j	4428 <free+0x12>
        bp->size += p->next->size;
    4464:	00073803          	ld	a6,0(a4)
        bp->next = p->next->next;
    4468:	6718                	ld	a4,8(a4)
        bp->size += p->next->size;
    446a:	95c2                	add	a1,a1,a6
    446c:	feb53823          	sd	a1,-16(a0)
    if ((char *)p + p->size == (char *)bp)
    4470:	638c                	ld	a1,0(a5)
    4472:	fee53c23          	sd	a4,-8(a0)
    4476:	00b78833          	add	a6,a5,a1
    447a:	fd069be3          	bne	a3,a6,4450 <free+0x3a>
        p->size += bp->size;
    447e:	ff053503          	ld	a0,-16(a0)
        p->next = bp->next;
    4482:	86ba                	mv	a3,a4
        p->size += bp->size;
    4484:	00b50733          	add	a4,a0,a1
    4488:	e398                	sd	a4,0(a5)
        p->next = bp->next;
    448a:	b7d9                	j	4450 <free+0x3a>

000000000000448c <malloc>:
    if (size == 0)
    448c:	c169                	beqz	a0,454e <malloc+0xc2>
{
    448e:	7179                	addi	sp,sp,-48
    4490:	ec26                	sd	s1,24(sp)
    if ((prevp = freep) == NULL)
    4492:	00003497          	auipc	s1,0x3
    4496:	1ee48493          	addi	s1,s1,494 # 7680 <errno>
    449a:	1084b783          	ld	a5,264(s1)
{
    449e:	f022                	sd	s0,32(sp)
    size = ALIGN(size + sizeof(header_t));
    44a0:	057d                	addi	a0,a0,31
{
    44a2:	f406                	sd	ra,40(sp)
    size = ALIGN(size + sizeof(header_t));
    44a4:	ff057413          	andi	s0,a0,-16
    if ((prevp = freep) == NULL)
    44a8:	c3d1                	beqz	a5,452c <malloc+0xa0>
    for (p = prevp->next;; prevp = p, p = p->next)
    44aa:	6788                	ld	a0,8(a5)
        if (p->size >= size)
    44ac:	6118                	ld	a4,0(a0)
    44ae:	06877163          	bgeu	a4,s0,4510 <malloc+0x84>
    44b2:	e44e                	sd	s3,8(sp)
    44b4:	e052                	sd	s4,0(sp)
    44b6:	e84a                	sd	s2,16(sp)
    if (nu < 4096)
    44b8:	6a05                	lui	s4,0x1
    if (cp == (void *)-1)
    44ba:	59fd                	li	s3,-1
    44bc:	a029                	j	44c6 <malloc+0x3a>
    for (p = prevp->next;; prevp = p, p = p->next)
    44be:	6788                	ld	a0,8(a5)
        if (p->size >= size)
    44c0:	6118                	ld	a4,0(a0)
    44c2:	04877463          	bgeu	a4,s0,450a <malloc+0x7e>
        if (p == freep)
    44c6:	1084b703          	ld	a4,264(s1)
    44ca:	87aa                	mv	a5,a0
    44cc:	fee519e3          	bne	a0,a4,44be <malloc+0x32>
    if (nu < 4096)
    44d0:	8922                	mv	s2,s0
    44d2:	01447363          	bgeu	s0,s4,44d8 <malloc+0x4c>
    44d6:	6905                	lui	s2,0x1
    cp = (char *)sbrk(nu);
    44d8:	854a                	mv	a0,s2
    44da:	c3dfb0ef          	jal	116 <sbrk>
    44de:	87aa                	mv	a5,a0
    free((void *)(up + 1));
    44e0:	0541                	addi	a0,a0,16
    if (cp == (void *)-1)
    44e2:	01378963          	beq	a5,s3,44f4 <malloc+0x68>
    up->size = nu;
    44e6:	0127b023          	sd	s2,0(a5)
    free((void *)(up + 1));
    44ea:	f2dff0ef          	jal	4416 <free>
    return freep;
    44ee:	1084b783          	ld	a5,264(s1)
            if ((p = morecore(size)) == NULL)
    44f2:	f7f1                	bnez	a5,44be <malloc+0x32>
}
    44f4:	70a2                	ld	ra,40(sp)
    44f6:	7402                	ld	s0,32(sp)
                errno = ENOMEM;
    44f8:	47b1                	li	a5,12
    44fa:	c09c                	sw	a5,0(s1)
                return NULL;
    44fc:	6942                	ld	s2,16(sp)
    44fe:	69a2                	ld	s3,8(sp)
    4500:	6a02                	ld	s4,0(sp)
}
    4502:	64e2                	ld	s1,24(sp)
        return NULL;
    4504:	4501                	li	a0,0
}
    4506:	6145                	addi	sp,sp,48
    4508:	8082                	ret
    450a:	6942                	ld	s2,16(sp)
    450c:	69a2                	ld	s3,8(sp)
    450e:	6a02                	ld	s4,0(sp)
            if (p->size == size)
    4510:	02e40c63          	beq	s0,a4,4548 <malloc+0xbc>
                p->size -= size;
    4514:	8f01                	sub	a4,a4,s0
    4516:	e118                	sd	a4,0(a0)
                p = (header_t *)((char *)p + p->size);
    4518:	953a                	add	a0,a0,a4
                p->size = size;
    451a:	e100                	sd	s0,0(a0)
}
    451c:	70a2                	ld	ra,40(sp)
    451e:	7402                	ld	s0,32(sp)
            freep = prevp;
    4520:	10f4b423          	sd	a5,264(s1)
            return (void *)(p + 1);
    4524:	0541                	addi	a0,a0,16
}
    4526:	64e2                	ld	s1,24(sp)
    4528:	6145                	addi	sp,sp,48
    452a:	8082                	ret
        base.next = freep = prevp = &base;
    452c:	00003517          	auipc	a0,0x3
    4530:	26450513          	addi	a0,a0,612 # 7790 <base>
    4534:	10a4b423          	sd	a0,264(s1)
    4538:	10a4bc23          	sd	a0,280(s1)
        base.size = 0;
    453c:	00003797          	auipc	a5,0x3
    4540:	2407ba23          	sd	zero,596(a5) # 7790 <base>
        if (p->size >= size)
    4544:	f43d                	bnez	s0,44b2 <malloc+0x26>
        base.next = freep = prevp = &base;
    4546:	87aa                	mv	a5,a0
                prevp->next = p->next;
    4548:	6518                	ld	a4,8(a0)
    454a:	e798                	sd	a4,8(a5)
    454c:	bfc1                	j	451c <malloc+0x90>
        return NULL;
    454e:	4501                	li	a0,0
}
    4550:	8082                	ret

0000000000004552 <calloc>:
    if (__builtin_mul_overflow(nmemb, size, &total))
    4552:	02b537b3          	mulhu	a5,a0,a1
{
    4556:	1101                	addi	sp,sp,-32
    4558:	e822                	sd	s0,16(sp)
    455a:	ec06                	sd	ra,24(sp)
    455c:	e426                	sd	s1,8(sp)
    if (__builtin_mul_overflow(nmemb, size, &total))
    455e:	02b50433          	mul	s0,a0,a1
    4562:	e385                	bnez	a5,4582 <calloc+0x30>
    void *p = malloc(total);
    4564:	8522                	mv	a0,s0
    4566:	f27ff0ef          	jal	448c <malloc>
    456a:	84aa                	mv	s1,a0
    if (p)
    456c:	c509                	beqz	a0,4576 <calloc+0x24>
        memset(p, 0, total);
    456e:	8622                	mv	a2,s0
    4570:	4581                	li	a1,0
    4572:	524000ef          	jal	4a96 <memset>
}
    4576:	60e2                	ld	ra,24(sp)
    4578:	6442                	ld	s0,16(sp)
    457a:	8526                	mv	a0,s1
    457c:	64a2                	ld	s1,8(sp)
    457e:	6105                	addi	sp,sp,32
    4580:	8082                	ret
    4582:	60e2                	ld	ra,24(sp)
    4584:	6442                	ld	s0,16(sp)
        errno = ENOMEM;
    4586:	47b1                	li	a5,12
        return NULL;
    4588:	4481                	li	s1,0
        errno = ENOMEM;
    458a:	00003717          	auipc	a4,0x3
    458e:	0ef72b23          	sw	a5,246(a4) # 7680 <errno>
}
    4592:	8526                	mv	a0,s1
    4594:	64a2                	ld	s1,8(sp)
    4596:	6105                	addi	sp,sp,32
    4598:	8082                	ret

000000000000459a <realloc>:
    if (!ptr)
    459a:	c929                	beqz	a0,45ec <realloc+0x52>
{
    459c:	1101                	addi	sp,sp,-32
    459e:	ec06                	sd	ra,24(sp)
    45a0:	e426                	sd	s1,8(sp)
    if (size == 0)
    45a2:	c5b9                	beqz	a1,45f0 <realloc+0x56>
    if (bp->size >= new_size)
    45a4:	ff053703          	ld	a4,-16(a0)
    size_t new_size = ALIGN(size + sizeof(header_t));
    45a8:	01f58793          	addi	a5,a1,31
    45ac:	e822                	sd	s0,16(sp)
    45ae:	9bc1                	andi	a5,a5,-16
    45b0:	842a                	mv	s0,a0
        return ptr;
    45b2:	84aa                	mv	s1,a0
    if (bp->size >= new_size)
    45b4:	00f76863          	bltu	a4,a5,45c4 <realloc+0x2a>
    45b8:	6442                	ld	s0,16(sp)
}
    45ba:	60e2                	ld	ra,24(sp)
    45bc:	8526                	mv	a0,s1
    45be:	64a2                	ld	s1,8(sp)
    45c0:	6105                	addi	sp,sp,32
    45c2:	8082                	ret
    void *new_ptr = malloc(size);
    45c4:	852e                	mv	a0,a1
    45c6:	ec7ff0ef          	jal	448c <malloc>
    45ca:	84aa                	mv	s1,a0
    if (!new_ptr)
    45cc:	d575                	beqz	a0,45b8 <realloc+0x1e>
    memcpy(new_ptr, ptr, bp->size - sizeof(header_t));
    45ce:	ff043603          	ld	a2,-16(s0)
    45d2:	85a2                	mv	a1,s0
    45d4:	1641                	addi	a2,a2,-16
    45d6:	514000ef          	jal	4aea <memcpy>
    free(ptr);
    45da:	8522                	mv	a0,s0
    45dc:	e3bff0ef          	jal	4416 <free>
}
    45e0:	60e2                	ld	ra,24(sp)
    free(ptr);
    45e2:	6442                	ld	s0,16(sp)
}
    45e4:	8526                	mv	a0,s1
    45e6:	64a2                	ld	s1,8(sp)
    45e8:	6105                	addi	sp,sp,32
    45ea:	8082                	ret
        return malloc(size);
    45ec:	852e                	mv	a0,a1
    45ee:	bd79                	j	448c <malloc>
        free(ptr);
    45f0:	e27ff0ef          	jal	4416 <free>
        return NULL;
    45f4:	4481                	li	s1,0
    45f6:	b7d1                	j	45ba <realloc+0x20>

00000000000045f8 <strtoull>:
    if (base < 0 || base == 1 || base > 36)
    45f8:	02400813          	li	a6,36
{
    45fc:	86aa                	mv	a3,a0
    45fe:	872e                	mv	a4,a1
    if (base < 0 || base == 1 || base > 36)
    4600:	00c86663          	bltu	a6,a2,460c <strtoull+0x14>
    4604:	4805                	li	a6,1
    4606:	01060363          	beq	a2,a6,460c <strtoull+0x14>
    460a:	b939                	j	4228 <strtoull.part.0>
        if (endptr)
    460c:	c311                	beqz	a4,4610 <strtoull+0x18>
            *endptr = (char *)nptr;
    460e:	e314                	sd	a3,0(a4)
        errno = 0; /* EINVAL */
    4610:	00003797          	auipc	a5,0x3
    4614:	0607a823          	sw	zero,112(a5) # 7680 <errno>
}
    4618:	4501                	li	a0,0
    461a:	8082                	ret

000000000000461c <strtoll>:

long long strtoll(const char *nptr, char **endptr, int base)
{
    461c:	1141                	addi	sp,sp,-16
    461e:	e406                	sd	ra,8(sp)
    4620:	e022                	sd	s0,0(sp)
    const char *s = nptr;
    4622:	86aa                	mv	a3,a0
    static inline int isspace(int c) { return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r'; }
    4624:	02000813          	li	a6,32
    4628:	4891                	li	a7,4
    unsigned long long acc;
    int c, neg = 0;

    do
    {
        c = *s++;
    462a:	0006c783          	lbu	a5,0(a3)
    462e:	0685                	addi	a3,a3,1
    4630:	ff77871b          	addiw	a4,a5,-9
    4634:	0ff77713          	zext.b	a4,a4
    4638:	0007841b          	sext.w	s0,a5
    463c:	ff0787e3          	beq	a5,a6,462a <strtoll+0xe>
    4640:	fee8f5e3          	bgeu	a7,a4,462a <strtoll+0xe>
    if (base < 0 || base == 1 || base > 36)
    4644:	02400793          	li	a5,36
    4648:	02c7ec63          	bltu	a5,a2,4680 <strtoll+0x64>
    464c:	4785                	li	a5,1
    464e:	02f60963          	beq	a2,a5,4680 <strtoll+0x64>
    4652:	bd7ff0ef          	jal	4228 <strtoull.part.0>
    if (c == '-')
        neg = 1;

    acc = strtoull(nptr, endptr, base);

    if (errno == ERANGE && acc == ULLONG_MAX)
    4656:	00003797          	auipc	a5,0x3
    465a:	02a78793          	addi	a5,a5,42 # 7680 <errno>
    465e:	4394                	lw	a3,0(a5)
    4660:	02200713          	li	a4,34
    4664:	04e68363          	beq	a3,a4,46aa <strtoll+0x8e>
        return neg ? LLONG_MIN : LLONG_MAX;

    if (!neg && acc > (unsigned long long)LLONG_MAX)
    4668:	02d00713          	li	a4,45
    466c:	02e40563          	beq	s0,a4,4696 <strtoll+0x7a>
    4670:	00055f63          	bgez	a0,468e <strtoll+0x72>
    {
        errno = ERANGE;
    4674:	02200713          	li	a4,34
    4678:	c398                	sw	a4,0(a5)
        return neg ? LLONG_MIN : LLONG_MAX;
    467a:	557d                	li	a0,-1
    467c:	8105                	srli	a0,a0,0x1
    467e:	a801                	j	468e <strtoll+0x72>
        if (endptr)
    4680:	c191                	beqz	a1,4684 <strtoll+0x68>
            *endptr = (char *)nptr;
    4682:	e188                	sd	a0,0(a1)
        errno = 0; /* EINVAL */
    4684:	00003797          	auipc	a5,0x3
    4688:	fe07ae23          	sw	zero,-4(a5) # 7680 <errno>
    {
        errno = ERANGE;
        return LLONG_MIN;
    }

    return neg ? -(long long)acc : (long long)acc;
    468c:	4501                	li	a0,0
}
    468e:	60a2                	ld	ra,8(sp)
    4690:	6402                	ld	s0,0(sp)
    4692:	0141                	addi	sp,sp,16
    4694:	8082                	ret
    if (neg && acc > (unsigned long long)LLONG_MAX + 1)
    4696:	577d                	li	a4,-1
    4698:	177e                	slli	a4,a4,0x3f
    469a:	02a76263          	bltu	a4,a0,46be <strtoll+0xa2>
}
    469e:	60a2                	ld	ra,8(sp)
    46a0:	6402                	ld	s0,0(sp)
    return neg ? -(long long)acc : (long long)acc;
    46a2:	40a00533          	neg	a0,a0
}
    46a6:	0141                	addi	sp,sp,16
    46a8:	8082                	ret
    if (errno == ERANGE && acc == ULLONG_MAX)
    46aa:	577d                	li	a4,-1
    46ac:	fae51ee3          	bne	a0,a4,4668 <strtoll+0x4c>
        return neg ? LLONG_MIN : LLONG_MAX;
    46b0:	02d00793          	li	a5,45
    46b4:	fcf413e3          	bne	s0,a5,467a <strtoll+0x5e>
        return LLONG_MIN;
    46b8:	557d                	li	a0,-1
    46ba:	157e                	slli	a0,a0,0x3f
    46bc:	bfc9                	j	468e <strtoll+0x72>
        errno = ERANGE;
    46be:	02200713          	li	a4,34
    46c2:	c398                	sw	a4,0(a5)
        return LLONG_MIN;
    46c4:	bfd5                	j	46b8 <strtoll+0x9c>

00000000000046c6 <strtoul>:
    if (base < 0 || base == 1 || base > 36)
    46c6:	02400813          	li	a6,36

unsigned long strtoul(const char *nptr, char **endptr, int base)
{
    46ca:	86aa                	mv	a3,a0
    46cc:	872e                	mv	a4,a1
    if (base < 0 || base == 1 || base > 36)
    46ce:	00c86663          	bltu	a6,a2,46da <strtoul+0x14>
    46d2:	4805                	li	a6,1
    46d4:	01060363          	beq	a2,a6,46da <strtoul+0x14>
    46d8:	be81                	j	4228 <strtoull.part.0>
        if (endptr)
    46da:	c311                	beqz	a4,46de <strtoul+0x18>
            *endptr = (char *)nptr;
    46dc:	e314                	sd	a3,0(a4)
        errno = 0; /* EINVAL */
    46de:	00003797          	auipc	a5,0x3
    46e2:	fa07a123          	sw	zero,-94(a5) # 7680 <errno>
    {
        errno = ERANGE;
        return ULONG_MAX;
    }
    return (unsigned long)ret;
}
    46e6:	4501                	li	a0,0
    46e8:	8082                	ret

00000000000046ea <strtol>:

long strtol(const char *nptr, char **endptr, int base)
{
    long long ret = strtoll(nptr, endptr, base);
    46ea:	bf0d                	j	461c <strtoll>

00000000000046ec <atoi>:
        return LONG_MIN;
    }
    return (long)ret;
}

int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    46ec:	1141                	addi	sp,sp,-16
    long long ret = strtoll(nptr, endptr, base);
    46ee:	4629                	li	a2,10
    46f0:	4581                	li	a1,0
int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    46f2:	e406                	sd	ra,8(sp)
    long long ret = strtoll(nptr, endptr, base);
    46f4:	f29ff0ef          	jal	461c <strtoll>
int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    46f8:	60a2                	ld	ra,8(sp)
    46fa:	2501                	sext.w	a0,a0
    46fc:	0141                	addi	sp,sp,16
    46fe:	8082                	ret

0000000000004700 <atol>:
    long long ret = strtoll(nptr, endptr, base);
    4700:	4629                	li	a2,10
    4702:	4581                	li	a1,0
    4704:	bf21                	j	461c <strtoll>

0000000000004706 <atoll>:
long atol(const char *nptr) { return strtol(nptr, NULL, 10); }
long long atoll(const char *nptr) { return strtoll(nptr, NULL, 10); }
    4706:	4629                	li	a2,10
    4708:	4581                	li	a1,0
    470a:	bf09                	j	461c <strtoll>

000000000000470c <strtod>:
    470c:	02000693          	li	a3,32
    4710:	4611                	li	a2,4
{
    double val = 0.0;
    int sign = 1;
    const char *s = nptr;

    while (isspace(*s))
    4712:	00054783          	lbu	a5,0(a0)
    4716:	ff77871b          	addiw	a4,a5,-9
    471a:	0ff77713          	zext.b	a4,a4
    471e:	06d78263          	beq	a5,a3,4782 <strtod+0x76>
    4722:	06e67063          	bgeu	a2,a4,4782 <strtod+0x76>
        s++;
    if (*s == '-')
    4726:	02d00713          	li	a4,45
    472a:	08e78e63          	beq	a5,a4,47c6 <strtod+0xba>
    {
        sign = -1;
        s++;
    }
    else if (*s == '+')
    472e:	02b00713          	li	a4,43
    4732:	0ae78263          	beq	a5,a4,47d6 <strtod+0xca>
    4736:	00001717          	auipc	a4,0x1
    473a:	06273507          	fld	fa0,98(a4) # 5798 <STDIN_FD+0x10>
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    473e:	fd07861b          	addiw	a2,a5,-48
        s++;

    while (isdigit(*s))
    4742:	46a5                	li	a3,9
    4744:	f20007d3          	fmv.d.x	fa5,zero
    4748:	8732                	mv	a4,a2
    474a:	02c6e363          	bltu	a3,a2,4770 <strtod+0x64>
    474e:	00001797          	auipc	a5,0x1
    4752:	0527b687          	fld	fa3,82(a5) # 57a0 <STDIN_FD+0x18>
    4756:	4625                	li	a2,9
    4758:	00154783          	lbu	a5,1(a0)
    {
        val = val * 10.0 + (*s - '0');
    475c:	d2070753          	fcvt.d.w	fa4,a4
        s++;
    4760:	0505                	addi	a0,a0,1
    4762:	fd07869b          	addiw	a3,a5,-48
        val = val * 10.0 + (*s - '0');
    4766:	72d7f7c3          	fmadd.d	fa5,fa5,fa3,fa4
    476a:	8736                	mv	a4,a3
    while (isdigit(*s))
    476c:	fed676e3          	bgeu	a2,a3,4758 <strtod+0x4c>
    }
    if (*s == '.')
    4770:	02e00713          	li	a4,46
    4774:	00e78963          	beq	a5,a4,4786 <strtod+0x7a>
            val += (*s - '0') * factor;
            s++;
        }
    }

    if (endptr)
    4778:	c191                	beqz	a1,477c <strtod+0x70>
        *endptr = (char *)s;
    477a:	e188                	sd	a0,0(a1)
    return val * sign;
}
    477c:	12a7f553          	fmul.d	fa0,fa5,fa0
    4780:	8082                	ret
        s++;
    4782:	0505                	addi	a0,a0,1
    4784:	b779                	j	4712 <strtod+0x6>
        while (isdigit(*s))
    4786:	00154703          	lbu	a4,1(a0)
    478a:	46a5                	li	a3,9
        s++;
    478c:	0505                	addi	a0,a0,1
    478e:	fd07071b          	addiw	a4,a4,-48
    4792:	87ba                	mv	a5,a4
        while (isdigit(*s))
    4794:	fee6e2e3          	bltu	a3,a4,4778 <strtod+0x6c>
        double factor = 1.0;
    4798:	00001717          	auipc	a4,0x1
    479c:	00073707          	fld	fa4,0(a4) # 5798 <STDIN_FD+0x10>
    47a0:	00001717          	auipc	a4,0x1
    47a4:	01873607          	fld	fa2,24(a4) # 57b8 <STDIN_FD+0x30>
            factor *= 0.1;
    47a8:	12c77753          	fmul.d	fa4,fa4,fa2
        while (isdigit(*s))
    47ac:	00154703          	lbu	a4,1(a0)
            val += (*s - '0') * factor;
    47b0:	d20786d3          	fcvt.d.w	fa3,a5
            s++;
    47b4:	0505                	addi	a0,a0,1
    47b6:	fd07071b          	addiw	a4,a4,-48
    47ba:	87ba                	mv	a5,a4
            val += (*s - '0') * factor;
    47bc:	7ae6f7c3          	fmadd.d	fa5,fa3,fa4,fa5
        while (isdigit(*s))
    47c0:	fee6f4e3          	bgeu	a3,a4,47a8 <strtod+0x9c>
    47c4:	bf55                	j	4778 <strtod+0x6c>
    while (isdigit(*s))
    47c6:	00154783          	lbu	a5,1(a0)
    47ca:	00001717          	auipc	a4,0x1
    47ce:	fc673507          	fld	fa0,-58(a4) # 5790 <STDIN_FD+0x8>
        s++;
    47d2:	0505                	addi	a0,a0,1
    47d4:	b7ad                	j	473e <strtod+0x32>
    while (isdigit(*s))
    47d6:	00154783          	lbu	a5,1(a0)
    47da:	00001717          	auipc	a4,0x1
    47de:	fbe73507          	fld	fa0,-66(a4) # 5798 <STDIN_FD+0x10>
        s++;
    47e2:	0505                	addi	a0,a0,1
    47e4:	bfa9                	j	473e <strtod+0x32>

00000000000047e6 <atof>:

double atof(const char *nptr) { return strtod(nptr, NULL); }
    47e6:	4581                	li	a1,0
    47e8:	b715                	j	470c <strtod>

00000000000047ea <strtof>:
float strtof(const char *nptr, char **endptr) { return (float)strtod(nptr, endptr); }
    47ea:	1141                	addi	sp,sp,-16
    47ec:	e406                	sd	ra,8(sp)
    47ee:	f1fff0ef          	jal	470c <strtod>
    47f2:	60a2                	ld	ra,8(sp)
    47f4:	40157553          	fcvt.s.d	fa0,fa0
    47f8:	0141                	addi	sp,sp,16
    47fa:	8082                	ret

00000000000047fc <qsort>:
    }
}

void qsort(void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *))
{
    if (nmemb < 2 || size == 0)
    47fc:	4785                	li	a5,1
    47fe:	0cb7fd63          	bgeu	a5,a1,48d8 <qsort+0xdc>
{
    4802:	715d                	addi	sp,sp,-80
    4804:	f44e                	sd	s3,40(sp)
    4806:	e486                	sd	ra,72(sp)
    4808:	89b2                	mv	s3,a2
    if (nmemb < 2 || size == 0)
    480a:	c279                	beqz	a2,48d0 <qsort+0xd4>
    480c:	e85a                	sd	s6,16(sp)
    480e:	8b2e                	mv	s6,a1
        return;

    char *base_ptr = (char *)base;
    char *pivot = base_ptr + (nmemb - 1) * size;
    4810:	1b7d                	addi	s6,s6,-1
    4812:	fc26                	sd	s1,56(sp)
    4814:	033b04b3          	mul	s1,s6,s3
    4818:	ec56                	sd	s5,24(sp)
    481a:	8aaa                	mv	s5,a0
    481c:	f052                	sd	s4,32(sp)
    481e:	e45e                	sd	s7,8(sp)
    4820:	e0a2                	sd	s0,64(sp)
    4822:	f84a                	sd	s2,48(sp)
    4824:	8a36                	mv	s4,a3
    if (nmemb < 2 || size == 0)
    4826:	4b85                	li	s7,1
    char *pivot = base_ptr + (nmemb - 1) * size;
    4828:	94d6                	add	s1,s1,s5
    char *i = base_ptr;
    char *j = base_ptr;

    /* Partition */
    for (; j < pivot; j += size)
    482a:	069af763          	bgeu	s5,s1,4898 <qsort+0x9c>
    char *j = base_ptr;
    482e:	8956                	mv	s2,s5
    char *i = base_ptr;
    4830:	8456                	mv	s0,s5
    4832:	a021                	j	483a <qsort+0x3e>
    for (; j < pivot; j += size)
    4834:	994e                	add	s2,s2,s3
    4836:	00997f63          	bgeu	s2,s1,4854 <qsort+0x58>
    {
        if (compar(j, pivot) < 0)
    483a:	85a6                	mv	a1,s1
    483c:	854a                	mv	a0,s2
    483e:	9a02                	jalr	s4
    4840:	fe055ae3          	bgez	a0,4834 <qsort+0x38>
        {
            if (i != j)
    4844:	05241d63          	bne	s0,s2,489e <qsort+0xa2>
    4848:	01390633          	add	a2,s2,s3
                swap_bytes(i, j, size);
            i += size;
    484c:	8432                	mv	s0,a2
    for (; j < pivot; j += size)
    484e:	994e                	add	s2,s2,s3
    4850:	fe9965e3          	bltu	s2,s1,483a <qsort+0x3e>
        }
    }
    swap_bytes(i, pivot, size);

    /* Recurse */
    size_t left_count = (i - base_ptr) / size;
    4854:	415405b3          	sub	a1,s0,s5
    4858:	0335d5b3          	divu	a1,a1,s3
    qsort(base, left_count, size, compar);
    qsort(i + size, nmemb - left_count - 1, size, compar);
    485c:	40bb0b33          	sub	s6,s6,a1
    while (size--)
    4860:	013406b3          	add	a3,s0,s3
        *a++ = *b;
    4864:	0004c703          	lbu	a4,0(s1)
        temp = *a;
    4868:	00044783          	lbu	a5,0(s0)
        *b++ = temp;
    486c:	0485                	addi	s1,s1,1
        *a++ = *b;
    486e:	0405                	addi	s0,s0,1
    4870:	fee40fa3          	sb	a4,-1(s0)
        *b++ = temp;
    4874:	fef48fa3          	sb	a5,-1(s1)
    while (size--)
    4878:	fed416e3          	bne	s0,a3,4864 <qsort+0x68>
    qsort(base, left_count, size, compar);
    487c:	86d2                	mv	a3,s4
    487e:	864e                	mv	a2,s3
    4880:	8556                	mv	a0,s5
    4882:	f7bff0ef          	jal	47fc <qsort>
    if (nmemb < 2 || size == 0)
    4886:	036bfe63          	bgeu	s7,s6,48c2 <qsort+0xc6>
    char *pivot = base_ptr + (nmemb - 1) * size;
    488a:	1b7d                	addi	s6,s6,-1
    488c:	033b04b3          	mul	s1,s6,s3
    4890:	8aa2                	mv	s5,s0
    4892:	94d6                	add	s1,s1,s5
    for (; j < pivot; j += size)
    4894:	f89aede3          	bltu	s5,s1,482e <qsort+0x32>
    char *i = base_ptr;
    4898:	8456                	mv	s0,s5
    for (; j < pivot; j += size)
    489a:	4581                	li	a1,0
    489c:	b7d1                	j	4860 <qsort+0x64>
    489e:	01340633          	add	a2,s0,s3
            if (i != j)
    48a2:	874a                	mv	a4,s2
    48a4:	87a2                	mv	a5,s0
        *a++ = *b;
    48a6:	00074683          	lbu	a3,0(a4)
        temp = *a;
    48aa:	0007c803          	lbu	a6,0(a5)
        *b++ = temp;
    48ae:	0705                	addi	a4,a4,1
        *a++ = *b;
    48b0:	0785                	addi	a5,a5,1
    48b2:	fed78fa3          	sb	a3,-1(a5)
        *b++ = temp;
    48b6:	ff070fa3          	sb	a6,-1(a4)
    while (size--)
    48ba:	fec796e3          	bne	a5,a2,48a6 <qsort+0xaa>
            i += size;
    48be:	8432                	mv	s0,a2
    48c0:	b779                	j	484e <qsort+0x52>
    48c2:	6406                	ld	s0,64(sp)
    48c4:	74e2                	ld	s1,56(sp)
    48c6:	7942                	ld	s2,48(sp)
    48c8:	7a02                	ld	s4,32(sp)
    48ca:	6ae2                	ld	s5,24(sp)
    48cc:	6b42                	ld	s6,16(sp)
    48ce:	6ba2                	ld	s7,8(sp)
}
    48d0:	60a6                	ld	ra,72(sp)
    48d2:	79a2                	ld	s3,40(sp)
    48d4:	6161                	addi	sp,sp,80
    48d6:	8082                	ret
    48d8:	8082                	ret

00000000000048da <bsearch>:

void *bsearch(const void *key, const void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *))
{
    48da:	715d                	addi	sp,sp,-80
    48dc:	e486                	sd	ra,72(sp)
    48de:	fc26                	sd	s1,56(sp)
    size_t l = 0, u = nmemb;
    while (l < u)
    48e0:	c629                	beqz	a2,492a <bsearch+0x50>
    48e2:	f84a                	sd	s2,48(sp)
    48e4:	f44e                	sd	s3,40(sp)
    48e6:	f052                	sd	s4,32(sp)
    48e8:	ec56                	sd	s5,24(sp)
    48ea:	e85a                	sd	s6,16(sp)
    48ec:	e45e                	sd	s7,8(sp)
    48ee:	e0a2                	sd	s0,64(sp)
    48f0:	8932                	mv	s2,a2
    48f2:	8a2a                	mv	s4,a0
    48f4:	8aae                	mv	s5,a1
    48f6:	8b36                	mv	s6,a3
    48f8:	8bba                	mv	s7,a4
    size_t l = 0, u = nmemb;
    48fa:	4981                	li	s3,0
    {
        size_t idx = (l + u) / 2;
    48fc:	01298433          	add	s0,s3,s2
    4900:	8005                	srli	s0,s0,0x1
        const void *p = (void *)((const char *)base + (idx * size));
    4902:	036404b3          	mul	s1,s0,s6
        int cmp = compar(key, p);
    4906:	8552                	mv	a0,s4
        const void *p = (void *)((const char *)base + (idx * size));
    4908:	94d6                	add	s1,s1,s5
        int cmp = compar(key, p);
    490a:	85a6                	mv	a1,s1
    490c:	9b82                	jalr	s7
        if (cmp < 0)
    490e:	02054463          	bltz	a0,4936 <bsearch+0x5c>
            u = idx;
        else if (cmp > 0)
    4912:	c515                	beqz	a0,493e <bsearch+0x64>
            l = idx + 1;
    4914:	00140993          	addi	s3,s0,1
    while (l < u)
    4918:	ff29e2e3          	bltu	s3,s2,48fc <bsearch+0x22>
    491c:	6406                	ld	s0,64(sp)
    491e:	7942                	ld	s2,48(sp)
    4920:	79a2                	ld	s3,40(sp)
    4922:	7a02                	ld	s4,32(sp)
    4924:	6ae2                	ld	s5,24(sp)
    4926:	6b42                	ld	s6,16(sp)
    4928:	6ba2                	ld	s7,8(sp)
        else
            return (void *)p;
    }
    return NULL;
}
    492a:	60a6                	ld	ra,72(sp)
    return NULL;
    492c:	4481                	li	s1,0
}
    492e:	8526                	mv	a0,s1
    4930:	74e2                	ld	s1,56(sp)
    4932:	6161                	addi	sp,sp,80
    4934:	8082                	ret
            u = idx;
    4936:	8922                	mv	s2,s0
    while (l < u)
    4938:	fd29e2e3          	bltu	s3,s2,48fc <bsearch+0x22>
    493c:	b7c5                	j	491c <bsearch+0x42>
    493e:	6406                	ld	s0,64(sp)
}
    4940:	60a6                	ld	ra,72(sp)
    4942:	7942                	ld	s2,48(sp)
    4944:	79a2                	ld	s3,40(sp)
    4946:	7a02                	ld	s4,32(sp)
    4948:	6ae2                	ld	s5,24(sp)
    494a:	6b42                	ld	s6,16(sp)
    494c:	6ba2                	ld	s7,8(sp)
    494e:	8526                	mv	a0,s1
    4950:	74e2                	ld	s1,56(sp)
    4952:	6161                	addi	sp,sp,80
    4954:	8082                	ret

0000000000004956 <abs>:

/* Math & Mics */

int abs(int j) { return (j < 0) ? -j : j; }
    4956:	41f5579b          	sraiw	a5,a0,0x1f
    495a:	8d3d                	xor	a0,a0,a5
    495c:	9d1d                	subw	a0,a0,a5
    495e:	8082                	ret

0000000000004960 <labs>:
long labs(long j) { return (j < 0) ? -j : j; }
    4960:	43f55793          	srai	a5,a0,0x3f
    4964:	8d3d                	xor	a0,a0,a5
    4966:	8d1d                	sub	a0,a0,a5
    4968:	8082                	ret

000000000000496a <llabs>:
long long llabs(long long j) { return (j < 0) ? -j : j; }
    496a:	43f55793          	srai	a5,a0,0x3f
    496e:	8d3d                	xor	a0,a0,a5
    4970:	8d1d                	sub	a0,a0,a5
    4972:	8082                	ret

0000000000004974 <div>:

div_t div(int numer, int denom)
{
    div_t res = {numer / denom, numer % denom};
    4974:	02b547bb          	divw	a5,a0,a1
{
    4978:	1141                	addi	sp,sp,-16
    return res;
}
    497a:	0141                	addi	sp,sp,16
    div_t res = {numer / denom, numer % denom};
    497c:	02b5653b          	remw	a0,a0,a1
    return res;
    4980:	1782                	slli	a5,a5,0x20
    4982:	9381                	srli	a5,a5,0x20
    4984:	1502                	slli	a0,a0,0x20
}
    4986:	8d5d                	or	a0,a0,a5
    4988:	8082                	ret

000000000000498a <ldiv>:
ldiv_t ldiv(long numer, long denom)
{
    498a:	1141                	addi	sp,sp,-16
    498c:	87aa                	mv	a5,a0
    ldiv_t res = {numer / denom, numer % denom};
    return res;
}
    498e:	02b54533          	div	a0,a0,a1
    4992:	0141                	addi	sp,sp,16
    4994:	02b7e5b3          	rem	a1,a5,a1
    4998:	8082                	ret

000000000000499a <lldiv>:
lldiv_t lldiv(long long numer, long long denom)
{
    499a:	1141                	addi	sp,sp,-16
    499c:	87aa                	mv	a5,a0
    lldiv_t res = {numer / denom, numer % denom};
    return res;
}
    499e:	02b54533          	div	a0,a0,a1
    49a2:	0141                	addi	sp,sp,16
    49a4:	02b7e5b3          	rem	a1,a5,a1
    49a8:	8082                	ret

00000000000049aa <rand>:

static unsigned long next = 1;
int rand(void)
{
    next = next * 1103515245 + 12345;
    49aa:	00003697          	auipc	a3,0x3
    49ae:	c8e68693          	addi	a3,a3,-882 # 7638 <next>
    49b2:	629c                	ld	a5,0(a3)
    49b4:	41c65737          	lui	a4,0x41c65
    49b8:	e6d70713          	addi	a4,a4,-403 # 41c64e6d <_ZSt4cerr+0x41c5d6b5>
    49bc:	02e787b3          	mul	a5,a5,a4
    49c0:	670d                	lui	a4,0x3
    49c2:	03970713          	addi	a4,a4,57 # 3039 <_vprintf_core.constprop.0.isra.0+0x1f>
    49c6:	97ba                	add	a5,a5,a4
    return (unsigned int)(next / 65536) % 32768;
    49c8:	02179513          	slli	a0,a5,0x21
    next = next * 1103515245 + 12345;
    49cc:	e29c                	sd	a5,0(a3)
}
    49ce:	9145                	srli	a0,a0,0x31
    49d0:	8082                	ret

00000000000049d2 <srand>:
void srand(unsigned int seed) { next = seed; }
    49d2:	1502                	slli	a0,a0,0x20
    49d4:	9101                	srli	a0,a0,0x20
    49d6:	00003797          	auipc	a5,0x3
    49da:	c6a7b123          	sd	a0,-926(a5) # 7638 <next>
    49de:	8082                	ret

00000000000049e0 <mblen>:

/* Stub */
int mblen(const char *s, size_t n) { return (s && *s && n) ? 1 : 0; }
    49e0:	c901                	beqz	a0,49f0 <mblen+0x10>
    49e2:	00054783          	lbu	a5,0(a0)
    49e6:	4501                	li	a0,0
    49e8:	c789                	beqz	a5,49f2 <mblen+0x12>
    49ea:	00b03533          	snez	a0,a1
    49ee:	8082                	ret
    49f0:	4501                	li	a0,0
    49f2:	8082                	ret

00000000000049f4 <mbtowc>:
int mbtowc(wchar_t *pwc, const char *s, size_t n)
{
    49f4:	87aa                	mv	a5,a0
    if (!s)
    49f6:	cd81                	beqz	a1,4a0e <mbtowc+0x1a>
        return 0;
    if (n == 0)
        return -1;
    49f8:	557d                	li	a0,-1
    if (n == 0)
    49fa:	ca19                	beqz	a2,4a10 <mbtowc+0x1c>
    if (pwc)
    49fc:	c781                	beqz	a5,4a04 <mbtowc+0x10>
        *pwc = (wchar_t)*s;
    49fe:	0005c703          	lbu	a4,0(a1)
    4a02:	c398                	sw	a4,0(a5)
    return (*s != 0);
    4a04:	0005c503          	lbu	a0,0(a1)
    4a08:	00a03533          	snez	a0,a0
    4a0c:	8082                	ret
        return 0;
    4a0e:	4501                	li	a0,0
}
    4a10:	8082                	ret

0000000000004a12 <wctomb>:
int wctomb(char *s, wchar_t wchar)
{
    if (!s)
    4a12:	c509                	beqz	a0,4a1c <wctomb+0xa>
        return 0;
    *s = (char)wchar;
    4a14:	00b50023          	sb	a1,0(a0)
    return 1;
    4a18:	4505                	li	a0,1
    4a1a:	8082                	ret
        return 0;
    4a1c:	4501                	li	a0,0
}
    4a1e:	8082                	ret

0000000000004a20 <mbstowcs>:
size_t mbstowcs(wchar_t *dest, const char *src, size_t n)
{
    size_t i = 0;
    while (src[i] && i < n)
    4a20:	0005c703          	lbu	a4,0(a1)
    4a24:	cb0d                	beqz	a4,4a56 <mbstowcs+0x36>
    4a26:	ca15                	beqz	a2,4a5a <mbstowcs+0x3a>
    4a28:	86aa                	mv	a3,a0
    size_t i = 0;
    4a2a:	4781                	li	a5,0
    4a2c:	a019                	j	4a32 <mbstowcs+0x12>
    while (src[i] && i < n)
    4a2e:	02f60263          	beq	a2,a5,4a52 <mbstowcs+0x32>
    {
        dest[i] = (wchar_t)src[i];
        i++;
    4a32:	0785                	addi	a5,a5,1
        dest[i] = (wchar_t)src[i];
    4a34:	c298                	sw	a4,0(a3)
    while (src[i] && i < n)
    4a36:	00f58733          	add	a4,a1,a5
    4a3a:	00074703          	lbu	a4,0(a4)
    4a3e:	0691                	addi	a3,a3,4
    4a40:	f77d                	bnez	a4,4a2e <mbstowcs+0xe>
    }
    if (i < n)
    4a42:	00c7f763          	bgeu	a5,a2,4a50 <mbstowcs+0x30>
        dest[i] = 0;
    4a46:	00279713          	slli	a4,a5,0x2
    4a4a:	953a                	add	a0,a0,a4
    4a4c:	00052023          	sw	zero,0(a0)
    size_t i = 0;
    4a50:	863e                	mv	a2,a5
    4a52:	8532                	mv	a0,a2
    4a54:	8082                	ret
    4a56:	4781                	li	a5,0
    4a58:	b7ed                	j	4a42 <mbstowcs+0x22>
    4a5a:	4501                	li	a0,0
    return i;
}
    4a5c:	8082                	ret

0000000000004a5e <wcstombs>:
size_t wcstombs(char *dest, const wchar_t *src, size_t n)
{
    size_t i = 0;
    while (src[i] && i < n)
    4a5e:	4198                	lw	a4,0(a1)
    4a60:	c71d                	beqz	a4,4a8e <wcstombs+0x30>
    4a62:	ca05                	beqz	a2,4a92 <wcstombs+0x34>
    4a64:	0591                	addi	a1,a1,4
    size_t i = 0;
    4a66:	4781                	li	a5,0
    4a68:	a019                	j	4a6e <wcstombs+0x10>
    while (src[i] && i < n)
    4a6a:	02f60063          	beq	a2,a5,4a8a <wcstombs+0x2c>
    {
        dest[i] = (char)src[i];
    4a6e:	00f506b3          	add	a3,a0,a5
    4a72:	00e68023          	sb	a4,0(a3)
    while (src[i] && i < n)
    4a76:	4198                	lw	a4,0(a1)
        i++;
    4a78:	0785                	addi	a5,a5,1
    while (src[i] && i < n)
    4a7a:	0591                	addi	a1,a1,4
    4a7c:	f77d                	bnez	a4,4a6a <wcstombs+0xc>
    }
    if (i < n)
    4a7e:	00c7f563          	bgeu	a5,a2,4a88 <wcstombs+0x2a>
        dest[i] = 0;
    4a82:	953e                	add	a0,a0,a5
    4a84:	00050023          	sb	zero,0(a0)
    size_t i = 0;
    4a88:	863e                	mv	a2,a5
    4a8a:	8532                	mv	a0,a2
    4a8c:	8082                	ret
    4a8e:	4781                	li	a5,0
    4a90:	b7fd                	j	4a7e <wcstombs+0x20>
    4a92:	4501                	li	a0,0
    return i;
    4a94:	8082                	ret

0000000000004a96 <memset>:

void *memset(void *dst, int c, size_t n)
{
    char *cdst = (char *)dst;
    for (size_t i = 0; i < n; i++)
        cdst[i] = (char)c;
    4a96:	0ff5f593          	zext.b	a1,a1
    4a9a:	87aa                	mv	a5,a0
    4a9c:	00a60733          	add	a4,a2,a0
    for (size_t i = 0; i < n; i++)
    4aa0:	c611                	beqz	a2,4aac <memset+0x16>
        cdst[i] = (char)c;
    4aa2:	00b78023          	sb	a1,0(a5)
    for (size_t i = 0; i < n; i++)
    4aa6:	0785                	addi	a5,a5,1
    4aa8:	fee79de3          	bne	a5,a4,4aa2 <memset+0xc>
    return dst;
}
    4aac:	8082                	ret

0000000000004aae <memmove>:

void *memmove(void *vdst, const void *vsrc, size_t n)
{
    char *dst = (char *)vdst;
    const char *src = (const char *)vsrc;
    if (dst == src)
    4aae:	02b50d63          	beq	a0,a1,4ae8 <memmove+0x3a>
        return vdst;

    if (src > dst)
    4ab2:	00b57e63          	bgeu	a0,a1,4ace <memmove+0x20>
    {
        while (n--)
    4ab6:	ca0d                	beqz	a2,4ae8 <memmove+0x3a>
    4ab8:	962a                	add	a2,a2,a0
    char *dst = (char *)vdst;
    4aba:	87aa                	mv	a5,a0
            *dst++ = *src++;
    4abc:	0005c703          	lbu	a4,0(a1)
    4ac0:	0785                	addi	a5,a5,1
    4ac2:	0585                	addi	a1,a1,1
    4ac4:	fee78fa3          	sb	a4,-1(a5)
        while (n--)
    4ac8:	fec79ae3          	bne	a5,a2,4abc <memmove+0xe>
    4acc:	8082                	ret
    }
    else
    {
        dst += n;
    4ace:	00c50733          	add	a4,a0,a2
        src += n;
    4ad2:	00c587b3          	add	a5,a1,a2
        while (n-- > 0)
    4ad6:	ca09                	beqz	a2,4ae8 <memmove+0x3a>
            *--dst = *--src;
    4ad8:	fff7c683          	lbu	a3,-1(a5)
    4adc:	17fd                	addi	a5,a5,-1
    4ade:	177d                	addi	a4,a4,-1
    4ae0:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
    4ae4:	fef59ae3          	bne	a1,a5,4ad8 <memmove+0x2a>
    }
    return vdst;
}
    4ae8:	8082                	ret

0000000000004aea <memcpy>:

void *memcpy(void *vdst, const void *vsrc, size_t n)
{
    return memmove(vdst, vsrc, n);
    4aea:	b7d1                	j	4aae <memmove>

0000000000004aec <memcmp>:

int memcmp(const void *s1, const void *s2, size_t n)
{
    const unsigned char *p1 = (const unsigned char *)s1;
    const unsigned char *p2 = (const unsigned char *)s2;
    while (n--)
    4aec:	c205                	beqz	a2,4b0c <memcmp+0x20>
    4aee:	962a                	add	a2,a2,a0
    4af0:	a019                	j	4af6 <memcmp+0xa>
    4af2:	00c50d63          	beq	a0,a2,4b0c <memcmp+0x20>
    {
        if (*p1 != *p2)
    4af6:	00054783          	lbu	a5,0(a0)
    4afa:	0005c703          	lbu	a4,0(a1)
            return *p1 - *p2;
        p1++;
    4afe:	0505                	addi	a0,a0,1
        p2++;
    4b00:	0585                	addi	a1,a1,1
        if (*p1 != *p2)
    4b02:	fee788e3          	beq	a5,a4,4af2 <memcmp+0x6>
            return *p1 - *p2;
    4b06:	40e7853b          	subw	a0,a5,a4
    4b0a:	8082                	ret
    }
    return 0;
    4b0c:	4501                	li	a0,0
}
    4b0e:	8082                	ret

0000000000004b10 <memchr>:

void *memchr(const void *s, int c, size_t n)
{
    const unsigned char *p = (const unsigned char *)s;
    while (n--)
    4b10:	ce09                	beqz	a2,4b2a <memchr+0x1a>
    {
        if (*p == (unsigned char)c)
    4b12:	0ff5f593          	zext.b	a1,a1
    4b16:	962a                	add	a2,a2,a0
    4b18:	a021                	j	4b20 <memchr+0x10>
            return (void *)p;
        p++;
    4b1a:	0505                	addi	a0,a0,1
    while (n--)
    4b1c:	00a60763          	beq	a2,a0,4b2a <memchr+0x1a>
        if (*p == (unsigned char)c)
    4b20:	00054783          	lbu	a5,0(a0)
    4b24:	feb79be3          	bne	a5,a1,4b1a <memchr+0xa>
    }
    return NULL;
}
    4b28:	8082                	ret
    return NULL;
    4b2a:	4501                	li	a0,0
}
    4b2c:	8082                	ret

0000000000004b2e <strlen>:
/* String Manipulation Functions  */

size_t strlen(const char *s)
{
    const char *p = s;
    while (*p)
    4b2e:	00054783          	lbu	a5,0(a0)
    4b32:	cb89                	beqz	a5,4b44 <strlen+0x16>
    const char *p = s;
    4b34:	87aa                	mv	a5,a0
    while (*p)
    4b36:	0017c703          	lbu	a4,1(a5)
        p++;
    4b3a:	0785                	addi	a5,a5,1
    while (*p)
    4b3c:	ff6d                	bnez	a4,4b36 <strlen+0x8>
    return (size_t)(p - s);
    4b3e:	40a78533          	sub	a0,a5,a0
    4b42:	8082                	ret
    while (*p)
    4b44:	4501                	li	a0,0
}
    4b46:	8082                	ret

0000000000004b48 <strcpy>:

char *strcpy(char *dst, const char *src)
{
    char *os = dst;
    while ((*dst++ = *src++) != 0)
    4b48:	87aa                	mv	a5,a0
    4b4a:	0005c703          	lbu	a4,0(a1)
    4b4e:	0785                	addi	a5,a5,1
    4b50:	0585                	addi	a1,a1,1
    4b52:	fee78fa3          	sb	a4,-1(a5)
    4b56:	fb75                	bnez	a4,4b4a <strcpy+0x2>
        ;
    return os;
}
    4b58:	8082                	ret

0000000000004b5a <strncpy>:
char *strncpy(char *dst, const char *src, size_t n)
{
    char *os = dst;
    size_t i;

    for (i = 0; i < n && src[i] != '\0'; i++)
    4b5a:	4781                	li	a5,0
    4b5c:	e619                	bnez	a2,4b6a <strncpy+0x10>
    4b5e:	8082                	ret
        dst[i] = src[i];
    4b60:	00e68023          	sb	a4,0(a3)
    for (i = 0; i < n && src[i] != '\0'; i++)
    4b64:	0785                	addi	a5,a5,1
    4b66:	02f60263          	beq	a2,a5,4b8a <strncpy+0x30>
    4b6a:	00f58733          	add	a4,a1,a5
    4b6e:	00074703          	lbu	a4,0(a4)
        dst[i] = src[i];
    4b72:	00f506b3          	add	a3,a0,a5
    for (i = 0; i < n && src[i] != '\0'; i++)
    4b76:	f76d                	bnez	a4,4b60 <strncpy+0x6>

    for (; i < n; i++)
    4b78:	00c7f963          	bgeu	a5,a2,4b8a <strncpy+0x30>
    4b7c:	87b6                	mv	a5,a3
    4b7e:	962a                	add	a2,a2,a0
        dst[i] = '\0';
    4b80:	00078023          	sb	zero,0(a5)
    for (; i < n; i++)
    4b84:	0785                	addi	a5,a5,1
    4b86:	fec79de3          	bne	a5,a2,4b80 <strncpy+0x26>

    return os;
}
    4b8a:	8082                	ret

0000000000004b8c <strcat>:

char *strcat(char *dst, const char *src)
{
    char *os = dst;
    while (*dst)
    4b8c:	00054783          	lbu	a5,0(a0)
    4b90:	cf91                	beqz	a5,4bac <strcat+0x20>
    4b92:	87aa                	mv	a5,a0
    4b94:	0017c703          	lbu	a4,1(a5)
        dst++;
    4b98:	0785                	addi	a5,a5,1
    while (*dst)
    4b9a:	ff6d                	bnez	a4,4b94 <strcat+0x8>
    while ((*dst++ = *src++) != 0)
    4b9c:	0005c703          	lbu	a4,0(a1)
    4ba0:	0785                	addi	a5,a5,1
    4ba2:	0585                	addi	a1,a1,1
    4ba4:	fee78fa3          	sb	a4,-1(a5)
    4ba8:	fb75                	bnez	a4,4b9c <strcat+0x10>
        ;
    return os;
}
    4baa:	8082                	ret
    while ((*dst++ = *src++) != 0)
    4bac:	0005c703          	lbu	a4,0(a1)
    while (*dst)
    4bb0:	87aa                	mv	a5,a0
    while ((*dst++ = *src++) != 0)
    4bb2:	0785                	addi	a5,a5,1
    4bb4:	fee78fa3          	sb	a4,-1(a5)
    4bb8:	0585                	addi	a1,a1,1
    4bba:	f36d                	bnez	a4,4b9c <strcat+0x10>
    4bbc:	8082                	ret

0000000000004bbe <strncat>:
    while (*p)
    4bbe:	00054783          	lbu	a5,0(a0)
    const char *p = s;
    4bc2:	872a                	mv	a4,a0
    while (*p)
    4bc4:	c789                	beqz	a5,4bce <strncat+0x10>
    4bc6:	00174783          	lbu	a5,1(a4)
        p++;
    4bca:	0705                	addi	a4,a4,1
    while (*p)
    4bcc:	ffed                	bnez	a5,4bc6 <strncat+0x8>
    size_t dest_len = strlen(dst);
    size_t i;

    dst += dest_len;

    for (i = 0; i < n && src[i] != '\0'; i++)
    4bce:	86ba                	mv	a3,a4
    4bd0:	4781                	li	a5,0
    4bd2:	88ba                	mv	a7,a4
    4bd4:	ea01                	bnez	a2,4be4 <strncat+0x26>
    4bd6:	a839                	j	4bf4 <strncat+0x36>
        dst[i] = src[i];
    4bd8:	01068023          	sb	a6,0(a3)
    for (i = 0; i < n && src[i] != '\0'; i++)
    4bdc:	00188693          	addi	a3,a7,1
    4be0:	00f60d63          	beq	a2,a5,4bfa <strncat+0x3c>
    4be4:	00f58833          	add	a6,a1,a5
    4be8:	00084803          	lbu	a6,0(a6)
    4bec:	0785                	addi	a5,a5,1
        dst[i] = src[i];
    4bee:	88b6                	mv	a7,a3
    for (i = 0; i < n && src[i] != '\0'; i++)
    4bf0:	fe0814e3          	bnez	a6,4bd8 <strncat+0x1a>

    dst[i] = '\0';
    4bf4:	00088023          	sb	zero,0(a7)

    return os;
}
    4bf8:	8082                	ret
    dst[i] = '\0';
    4bfa:	00c708b3          	add	a7,a4,a2
    4bfe:	00088023          	sb	zero,0(a7)
}
    4c02:	8082                	ret

0000000000004c04 <strcmp>:

int strcmp(const char *p, const char *q)
{
    while (*p && *p == *q)
    4c04:	00054783          	lbu	a5,0(a0)
    4c08:	e791                	bnez	a5,4c14 <strcmp+0x10>
    4c0a:	a02d                	j	4c34 <strcmp+0x30>
    4c0c:	00054783          	lbu	a5,0(a0)
    4c10:	cf89                	beqz	a5,4c2a <strcmp+0x26>
    4c12:	85b6                	mv	a1,a3
    4c14:	0005c703          	lbu	a4,0(a1)
    {
        p++;
    4c18:	0505                	addi	a0,a0,1
        q++;
    4c1a:	00158693          	addi	a3,a1,1
    while (*p && *p == *q)
    4c1e:	fef707e3          	beq	a4,a5,4c0c <strcmp+0x8>
    }
    return (int)((unsigned char)*p - (unsigned char)*q);
    4c22:	0007851b          	sext.w	a0,a5
}
    4c26:	9d19                	subw	a0,a0,a4
    4c28:	8082                	ret
    return (int)((unsigned char)*p - (unsigned char)*q);
    4c2a:	0015c703          	lbu	a4,1(a1)
    4c2e:	4501                	li	a0,0
}
    4c30:	9d19                	subw	a0,a0,a4
    4c32:	8082                	ret
    return (int)((unsigned char)*p - (unsigned char)*q);
    4c34:	0005c703          	lbu	a4,0(a1)
    4c38:	4501                	li	a0,0
    4c3a:	b7f5                	j	4c26 <strcmp+0x22>

0000000000004c3c <strncmp>:

int strncmp(const char *s1, const char *s2, size_t n)
{
    if (n == 0)
    4c3c:	ca0d                	beqz	a2,4c6e <strncmp+0x32>
        return 0;

    while (n-- > 0 && *s1 && *s1 == *s2)
    4c3e:	00054783          	lbu	a5,0(a0)
    4c42:	167d                	addi	a2,a2,-1
    4c44:	00c506b3          	add	a3,a0,a2
    4c48:	eb89                	bnez	a5,4c5a <strncmp+0x1e>
    4c4a:	a80d                	j	4c7c <strncmp+0x40>
    {
        if (n == 0 || *s1 == '\0')
    4c4c:	00d50d63          	beq	a0,a3,4c66 <strncmp+0x2a>
    while (n-- > 0 && *s1 && *s1 == *s2)
    4c50:	00154783          	lbu	a5,1(a0)
            break;
        s1++;
    4c54:	0505                	addi	a0,a0,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    4c56:	cf91                	beqz	a5,4c72 <strncmp+0x36>
    4c58:	85b2                	mv	a1,a2
    4c5a:	0005c703          	lbu	a4,0(a1)
        s2++;
    4c5e:	00158613          	addi	a2,a1,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    4c62:	fef705e3          	beq	a4,a5,4c4c <strncmp+0x10>
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    4c66:	0007851b          	sext.w	a0,a5
    4c6a:	9d19                	subw	a0,a0,a4
    4c6c:	8082                	ret
        return 0;
    4c6e:	4501                	li	a0,0
}
    4c70:	8082                	ret
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    4c72:	0015c703          	lbu	a4,1(a1)
    4c76:	4501                	li	a0,0
    4c78:	9d19                	subw	a0,a0,a4
    4c7a:	8082                	ret
    4c7c:	0005c703          	lbu	a4,0(a1)
    4c80:	4501                	li	a0,0
    4c82:	b7e5                	j	4c6a <strncmp+0x2e>

0000000000004c84 <strchr>:

char *strchr(const char *s, int c)
{
    while (*s != (char)c)
    4c84:	0ff5f593          	zext.b	a1,a1
    4c88:	a019                	j	4c8e <strchr+0xa>
    {
        if (!*s++)
    4c8a:	0505                	addi	a0,a0,1
    4c8c:	c791                	beqz	a5,4c98 <strchr+0x14>
    while (*s != (char)c)
    4c8e:	00054783          	lbu	a5,0(a0)
    4c92:	feb79ce3          	bne	a5,a1,4c8a <strchr+0x6>
    4c96:	8082                	ret
            return NULL;
    4c98:	4501                	li	a0,0
    }
    return (char *)s;
}
    4c9a:	8082                	ret

0000000000004c9c <strrchr>:

char *strrchr(const char *s, int c)
{
    4c9c:	87aa                	mv	a5,a0
    const char *last = NULL;
    do
    {
        if (*s == (char)c)
    4c9e:	0ff5f593          	zext.b	a1,a1
    const char *last = NULL;
    4ca2:	4501                	li	a0,0
        if (*s == (char)c)
    4ca4:	0007c703          	lbu	a4,0(a5)
    4ca8:	00e59363          	bne	a1,a4,4cae <strrchr+0x12>
            last = s;
    4cac:	853e                	mv	a0,a5
    } while (*s++);
    4cae:	0785                	addi	a5,a5,1
    4cb0:	fb75                	bnez	a4,4ca4 <strrchr+0x8>

    return (char *)last;
}
    4cb2:	8082                	ret

0000000000004cb4 <strstr>:
    while (*p)
    4cb4:	0005c883          	lbu	a7,0(a1)
    4cb8:	04088a63          	beqz	a7,4d0c <strstr+0x58>
    const char *p = s;
    4cbc:	87ae                	mv	a5,a1
    while (*p)
    4cbe:	0017c703          	lbu	a4,1(a5)
        p++;
    4cc2:	0785                	addi	a5,a5,1
    while (*p)
    4cc4:	ff6d                	bnez	a4,4cbe <strstr+0xa>
    return (size_t)(p - s);
    4cc6:	40b78833          	sub	a6,a5,a1


char *strstr(const char *haystack, const char *needle)
{
    size_t n_len = strlen(needle);
    if (n_len == 0)
    4cca:	04b78163          	beq	a5,a1,4d0c <strstr+0x58>
        return (char *)haystack;

    for (; *haystack; haystack++)
    4cce:	00054783          	lbu	a5,0(a0)
    4cd2:	cf85                	beqz	a5,4d0a <strstr+0x56>
    4cd4:	187d                	addi	a6,a6,-1
    4cd6:	982a                	add	a6,a6,a0
    {
        if (*haystack != *needle)
    4cd8:	02f89463          	bne	a7,a5,4d00 <strstr+0x4c>
    while (n-- > 0 && *s1 && *s1 == *s2)
    4cdc:	00054703          	lbu	a4,0(a0)
    4ce0:	8646                	mv	a2,a7
    4ce2:	86ae                	mv	a3,a1
    4ce4:	87aa                	mv	a5,a0
    4ce6:	eb11                	bnez	a4,4cfa <strstr+0x46>
    4ce8:	a821                	j	4d00 <strstr+0x4c>
        if (n == 0 || *s1 == '\0')
    4cea:	03078163          	beq	a5,a6,4d0c <strstr+0x58>
    while (n-- > 0 && *s1 && *s1 == *s2)
    4cee:	0017c703          	lbu	a4,1(a5)
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    4cf2:	0006c603          	lbu	a2,0(a3)
        s1++;
    4cf6:	0785                	addi	a5,a5,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    4cf8:	cb19                	beqz	a4,4d0e <strstr+0x5a>
        s2++;
    4cfa:	0685                	addi	a3,a3,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    4cfc:	fee607e3          	beq	a2,a4,4cea <strstr+0x36>
    for (; *haystack; haystack++)
    4d00:	00154783          	lbu	a5,1(a0)
    4d04:	0805                	addi	a6,a6,1
    4d06:	0505                	addi	a0,a0,1
    4d08:	fbe1                	bnez	a5,4cd8 <strstr+0x24>
            continue;

        if (strncmp(haystack, needle, n_len) == 0)
            return (char *)haystack;
    }
    return NULL;
    4d0a:	4501                	li	a0,0
}
    4d0c:	8082                	ret
        if (strncmp(haystack, needle, n_len) == 0)
    4d0e:	de7d                	beqz	a2,4d0c <strstr+0x58>
    for (; *haystack; haystack++)
    4d10:	00154783          	lbu	a5,1(a0)
    4d14:	0805                	addi	a6,a6,1
    4d16:	0505                	addi	a0,a0,1
    4d18:	f3e1                	bnez	a5,4cd8 <strstr+0x24>
    4d1a:	bfc5                	j	4d0a <strstr+0x56>

0000000000004d1c <strdup>:

char *strdup(const char *s)
{
    4d1c:	1101                	addi	sp,sp,-32
    4d1e:	e426                	sd	s1,8(sp)
    4d20:	ec06                	sd	ra,24(sp)
    4d22:	e822                	sd	s0,16(sp)
    while (*p)
    4d24:	00054783          	lbu	a5,0(a0)
{
    4d28:	84aa                	mv	s1,a0
    while (*p)
    4d2a:	cb8d                	beqz	a5,4d5c <strdup+0x40>
    const char *p = s;
    4d2c:	862a                	mv	a2,a0
    while (*p)
    4d2e:	00164783          	lbu	a5,1(a2)
        p++;
    4d32:	0605                	addi	a2,a2,1
    while (*p)
    4d34:	ffed                	bnez	a5,4d2e <strdup+0x12>
    return (size_t)(p - s);
    4d36:	8e05                	sub	a2,a2,s1
    size_t len = strlen(s) + 1;
    4d38:	00160413          	addi	s0,a2,1
    char *new_str = (char *)malloc(len);
    4d3c:	8522                	mv	a0,s0
    4d3e:	f4eff0ef          	jal	448c <malloc>
    if (new_str == NULL)
    4d42:	c901                	beqz	a0,4d52 <strdup+0x36>
    return memmove(vdst, vsrc, n);
    4d44:	8622                	mv	a2,s0
        return NULL;

    return (char *)memcpy(new_str, s, len);
}
    4d46:	6442                	ld	s0,16(sp)
    4d48:	60e2                	ld	ra,24(sp)
    return memmove(vdst, vsrc, n);
    4d4a:	85a6                	mv	a1,s1
}
    4d4c:	64a2                	ld	s1,8(sp)
    4d4e:	6105                	addi	sp,sp,32
    return memmove(vdst, vsrc, n);
    4d50:	bbb9                	j	4aae <memmove>
}
    4d52:	60e2                	ld	ra,24(sp)
    4d54:	6442                	ld	s0,16(sp)
    4d56:	64a2                	ld	s1,8(sp)
    4d58:	6105                	addi	sp,sp,32
    4d5a:	8082                	ret
    while (*p)
    4d5c:	4405                	li	s0,1
    4d5e:	bff9                	j	4d3c <strdup+0x20>

0000000000004d60 <strlcpy>:
    4d60:	0005c783          	lbu	a5,0(a1)

size_t strlcpy(char *dst, const char *src, size_t size)
{
    4d64:	1101                	addi	sp,sp,-32
    4d66:	ec06                	sd	ra,24(sp)
    4d68:	e822                	sd	s0,16(sp)
    4d6a:	86b2                	mv	a3,a2
    while (*p)
    4d6c:	cf8d                	beqz	a5,4da6 <strlcpy+0x46>
    const char *p = s;
    4d6e:	87ae                	mv	a5,a1
    while (*p)
    4d70:	0017c703          	lbu	a4,1(a5)
        p++;
    4d74:	0785                	addi	a5,a5,1
    while (*p)
    4d76:	ff6d                	bnez	a4,4d70 <strlcpy+0x10>
    return (size_t)(p - s);
    4d78:	40b78433          	sub	s0,a5,a1
    size_t src_len = strlen(src);

    if (size > 0)
    4d7c:	c285                	beqz	a3,4d9c <strlcpy+0x3c>
    4d7e:	e426                	sd	s1,8(sp)
    {
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    4d80:	fff68613          	addi	a2,a3,-1
        memcpy(dst, src, copy_len);
        dst[copy_len] = '\0';
    4d84:	00c504b3          	add	s1,a0,a2
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    4d88:	00d47563          	bgeu	s0,a3,4d92 <strlcpy+0x32>
        dst[copy_len] = '\0';
    4d8c:	008504b3          	add	s1,a0,s0
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    4d90:	8622                	mv	a2,s0
    return memmove(vdst, vsrc, n);
    4d92:	d1dff0ef          	jal	4aae <memmove>
        dst[copy_len] = '\0';
    4d96:	00048023          	sb	zero,0(s1)
    }

    return src_len;
    4d9a:	64a2                	ld	s1,8(sp)
}
    4d9c:	60e2                	ld	ra,24(sp)
    4d9e:	8522                	mv	a0,s0
    4da0:	6442                	ld	s0,16(sp)
    4da2:	6105                	addi	sp,sp,32
    4da4:	8082                	ret
    if (size > 0)
    4da6:	e219                	bnez	a2,4dac <strlcpy+0x4c>
    return (size_t)(p - s);
    4da8:	4401                	li	s0,0
    4daa:	bfcd                	j	4d9c <strlcpy+0x3c>
    4dac:	e426                	sd	s1,8(sp)
    4dae:	4401                	li	s0,0
    if (size > 0)
    4db0:	84aa                	mv	s1,a0
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    4db2:	4601                	li	a2,0
    4db4:	bff9                	j	4d92 <strlcpy+0x32>

0000000000004db6 <strlcat>:
    while (*p)
    4db6:	0005c783          	lbu	a5,0(a1)

size_t strlcat(char *dst, const char *src, size_t size)
{
    4dba:	7179                	addi	sp,sp,-48
    4dbc:	e84a                	sd	s2,16(sp)
    4dbe:	f406                	sd	ra,40(sp)
    4dc0:	f022                	sd	s0,32(sp)
    4dc2:	ec26                	sd	s1,24(sp)
    4dc4:	892a                	mv	s2,a0
    while (*p)
    4dc6:	c7b5                	beqz	a5,4e32 <strlcat+0x7c>
    const char *p = s;
    4dc8:	87ae                	mv	a5,a1
    while (*p)
    4dca:	0017c703          	lbu	a4,1(a5)
        p++;
    4dce:	0785                	addi	a5,a5,1
    while (*p)
    4dd0:	ff6d                	bnez	a4,4dca <strlcat+0x14>
    return (size_t)(p - s);
    4dd2:	40b784b3          	sub	s1,a5,a1
    size_t dst_len = 0;
    4dd6:	4401                	li	s0,0
    size_t src_len = strlen(src);

    while (dst_len < size && dst[dst_len] != '\0')
    4dd8:	e609                	bnez	a2,4de2 <strlcat+0x2c>
    4dda:	a0a1                	j	4e22 <strlcat+0x6c>
        dst_len++;
    4ddc:	0405                	addi	s0,s0,1
    while (dst_len < size && dst[dst_len] != '\0')
    4dde:	04860263          	beq	a2,s0,4e22 <strlcat+0x6c>
    4de2:	00890533          	add	a0,s2,s0
    4de6:	00054783          	lbu	a5,0(a0)
    4dea:	fbed                	bnez	a5,4ddc <strlcat+0x26>

    if (dst_len == size)
    4dec:	02860b63          	beq	a2,s0,4e22 <strlcat+0x6c>
    4df0:	e44e                	sd	s3,8(sp)
        return size + src_len;

    size_t space_left = size - dst_len;
    4df2:	408607b3          	sub	a5,a2,s0
    size_t copy_len = (src_len >= space_left) ? space_left - 1 : src_len;
    4df6:	89a6                	mv	s3,s1
    4df8:	02f4f263          	bgeu	s1,a5,4e1c <strlcat+0x66>

    memcpy(dst + dst_len, src, copy_len);
    dst[dst_len + copy_len] = '\0';
    4dfc:	994e                	add	s2,s2,s3
    4dfe:	9922                	add	s2,s2,s0
    return memmove(vdst, vsrc, n);
    4e00:	864e                	mv	a2,s3
    4e02:	cadff0ef          	jal	4aae <memmove>
    dst[dst_len + copy_len] = '\0';
    4e06:	00090023          	sb	zero,0(s2) # 1000 <_vscanf_core.constprop.0+0x6ca>

    return dst_len + src_len;
    4e0a:	00940533          	add	a0,s0,s1
}
    4e0e:	70a2                	ld	ra,40(sp)
    4e10:	7402                	ld	s0,32(sp)
    return dst_len + src_len;
    4e12:	69a2                	ld	s3,8(sp)
}
    4e14:	64e2                	ld	s1,24(sp)
    4e16:	6942                	ld	s2,16(sp)
    4e18:	6145                	addi	sp,sp,48
    4e1a:	8082                	ret
    size_t copy_len = (src_len >= space_left) ? space_left - 1 : src_len;
    4e1c:	fff78993          	addi	s3,a5,-1
    4e20:	bff1                	j	4dfc <strlcat+0x46>
}
    4e22:	70a2                	ld	ra,40(sp)
    4e24:	7402                	ld	s0,32(sp)
    4e26:	6942                	ld	s2,16(sp)
        return size + src_len;
    4e28:	00960533          	add	a0,a2,s1
}
    4e2c:	64e2                	ld	s1,24(sp)
    4e2e:	6145                	addi	sp,sp,48
    4e30:	8082                	ret
    while (*p)
    4e32:	4481                	li	s1,0
    4e34:	b74d                	j	4dd6 <strlcat+0x20>

0000000000004e36 <strspn>:
size_t strspn(const char *s, const char *accept)
{
    const char *p = s;
    const char *a;

    while (*p)
    4e36:	00054683          	lbu	a3,0(a0)
    4e3a:	c695                	beqz	a3,4e66 <strspn+0x30>
    {
        for (a = accept; *a; a++)
    4e3c:	0005c803          	lbu	a6,0(a1)
    4e40:	862a                	mv	a2,a0
    4e42:	00080f63          	beqz	a6,4e60 <strspn+0x2a>
    4e46:	87ae                	mv	a5,a1
    4e48:	8742                	mv	a4,a6
    4e4a:	a021                	j	4e52 <strspn+0x1c>
    4e4c:	0007c703          	lbu	a4,0(a5)
    4e50:	cb01                	beqz	a4,4e60 <strspn+0x2a>
    4e52:	0785                	addi	a5,a5,1
        {
            if (*p == *a)
    4e54:	fee69ce3          	bne	a3,a4,4e4c <strspn+0x16>
    while (*p)
    4e58:	00164683          	lbu	a3,1(a2)
                break;
        }
        if (*a == '\0')
            return (size_t)(p - s);
        p++;
    4e5c:	0605                	addi	a2,a2,1
    while (*p)
    4e5e:	f6e5                	bnez	a3,4e46 <strspn+0x10>
    }
    return (size_t)(p - s);
    4e60:	40a60533          	sub	a0,a2,a0
    4e64:	8082                	ret
    while (*p)
    4e66:	4501                	li	a0,0
}
    4e68:	8082                	ret

0000000000004e6a <strcspn>:
size_t strcspn(const char *s, const char *reject)
{
    const char *p = s;
    const char *r;

    while (*p)
    4e6a:	00054683          	lbu	a3,0(a0)
    4e6e:	ce85                	beqz	a3,4ea6 <strcspn+0x3c>
    {
        for (r = reject; *r; r++)
    4e70:	0005c803          	lbu	a6,0(a1)
    const char *p = s;
    4e74:	862a                	mv	a2,a0
        for (r = reject; *r; r++)
    4e76:	02080363          	beqz	a6,4e9c <strcspn+0x32>
    4e7a:	87ae                	mv	a5,a1
    4e7c:	8742                	mv	a4,a6
    4e7e:	a021                	j	4e86 <strcspn+0x1c>
    4e80:	0007c703          	lbu	a4,0(a5)
    4e84:	c719                	beqz	a4,4e92 <strcspn+0x28>
    4e86:	0785                	addi	a5,a5,1
        {
            if (*p == *r)
    4e88:	fed71ce3          	bne	a4,a3,4e80 <strcspn+0x16>
                return (size_t)(p - s);
        }
        p++;
    }
    return (size_t)(p - s);
    4e8c:	40a60533          	sub	a0,a2,a0
    4e90:	8082                	ret
    while (*p)
    4e92:	00164683          	lbu	a3,1(a2)
        p++;
    4e96:	0605                	addi	a2,a2,1
    while (*p)
    4e98:	f2ed                	bnez	a3,4e7a <strcspn+0x10>
    4e9a:	bfcd                	j	4e8c <strcspn+0x22>
    4e9c:	00164683          	lbu	a3,1(a2)
        p++;
    4ea0:	0605                	addi	a2,a2,1
    while (*p)
    4ea2:	feed                	bnez	a3,4e9c <strcspn+0x32>
    4ea4:	b7e5                	j	4e8c <strcspn+0x22>
    4ea6:	4501                	li	a0,0
}
    4ea8:	8082                	ret

0000000000004eaa <strpbrk>:

char *strpbrk(const char *s, const char *accept)
{
    const char *a;
    while (*s)
    4eaa:	00054683          	lbu	a3,0(a0)
    4eae:	c295                	beqz	a3,4ed2 <strpbrk+0x28>
    {
        for (a = accept; *a; a++)
    4eb0:	0005c603          	lbu	a2,0(a1)
    4eb4:	c20d                	beqz	a2,4ed6 <strpbrk+0x2c>
    4eb6:	87ae                	mv	a5,a1
    4eb8:	8732                	mv	a4,a2
    4eba:	a021                	j	4ec2 <strpbrk+0x18>
    4ebc:	0007c703          	lbu	a4,0(a5)
    4ec0:	c709                	beqz	a4,4eca <strpbrk+0x20>
    4ec2:	0785                	addi	a5,a5,1
        {
            if (*s == *a)
    4ec4:	fed71ce3          	bne	a4,a3,4ebc <strpbrk+0x12>
                return (char *)s;
        }
        s++;
    }
    return NULL;
}
    4ec8:	8082                	ret
    while (*s)
    4eca:	00154683          	lbu	a3,1(a0)
        s++;
    4ece:	0505                	addi	a0,a0,1
    while (*s)
    4ed0:	f2fd                	bnez	a3,4eb6 <strpbrk+0xc>
    return NULL;
    4ed2:	4501                	li	a0,0
}
    4ed4:	8082                	ret
    while (*s)
    4ed6:	00154683          	lbu	a3,1(a0)
        s++;
    4eda:	0505                	addi	a0,a0,1
    while (*s)
    4edc:	feed                	bnez	a3,4ed6 <strpbrk+0x2c>
    4ede:	bfd5                	j	4ed2 <strpbrk+0x28>

0000000000004ee0 <strtok>:
char *strtok(char *str, const char *delim)
{
    static char *olds;
    char *token;

    if (str == NULL)
    4ee0:	00003897          	auipc	a7,0x3
    4ee4:	8c088893          	addi	a7,a7,-1856 # 77a0 <olds.0>
    4ee8:	cd25                	beqz	a0,4f60 <strtok+0x80>
    while (*p)
    4eea:	00054683          	lbu	a3,0(a0)
    4eee:	c295                	beqz	a3,4f12 <strtok+0x32>
        for (a = accept; *a; a++)
    4ef0:	0005c803          	lbu	a6,0(a1)
    4ef4:	02080463          	beqz	a6,4f1c <strtok+0x3c>
    4ef8:	87ae                	mv	a5,a1
    4efa:	8742                	mv	a4,a6
    4efc:	a021                	j	4f04 <strtok+0x24>
    4efe:	0007c703          	lbu	a4,0(a5)
    4f02:	cf09                	beqz	a4,4f1c <strtok+0x3c>
    4f04:	0785                	addi	a5,a5,1
            if (*p == *a)
    4f06:	fee69ce3          	bne	a3,a4,4efe <strtok+0x1e>
    while (*p)
    4f0a:	00154683          	lbu	a3,1(a0)
        p++;
    4f0e:	0505                	addi	a0,a0,1
    while (*p)
    4f10:	f6e5                	bnez	a3,4ef8 <strtok+0x18>
    4f12:	87aa                	mv	a5,a0
        str = olds;

    str += strspn(str, delim);
    if (*str == '\0')
    {
        olds = str;
    4f14:	00f8b023          	sd	a5,0(a7)
        return NULL;
    4f18:	4501                	li	a0,0
        *str = '\0';
        olds = str + 1;
    }

    return token;
}
    4f1a:	8082                	ret
    if (*str == '\0')
    4f1c:	00054603          	lbu	a2,0(a0)
    4f20:	da6d                	beqz	a2,4f12 <strtok+0x32>
    4f22:	86aa                	mv	a3,a0
        for (a = accept; *a; a++)
    4f24:	04080163          	beqz	a6,4f66 <strtok+0x86>
    4f28:	8742                	mv	a4,a6
    4f2a:	87ae                	mv	a5,a1
    4f2c:	a021                	j	4f34 <strtok+0x54>
    4f2e:	0007c703          	lbu	a4,0(a5)
    4f32:	cb19                	beqz	a4,4f48 <strtok+0x68>
    4f34:	0785                	addi	a5,a5,1
            if (*s == *a)
    4f36:	fee61ce3          	bne	a2,a4,4f2e <strtok+0x4e>
        olds = str + 1;
    4f3a:	00168793          	addi	a5,a3,1
        *str = '\0';
    4f3e:	00068023          	sb	zero,0(a3)
        olds = str;
    4f42:	00f8b023          	sd	a5,0(a7)
}
    4f46:	8082                	ret
    while (*s)
    4f48:	0016c603          	lbu	a2,1(a3)
        s++;
    4f4c:	0685                	addi	a3,a3,1
    while (*s)
    4f4e:	fe69                	bnez	a2,4f28 <strtok+0x48>
    4f50:	87aa                	mv	a5,a0
    while (*s != (char)c)
    4f52:	0017c703          	lbu	a4,1(a5)
        if (!*s++)
    4f56:	0785                	addi	a5,a5,1
    while (*s != (char)c)
    4f58:	ff6d                	bnez	a4,4f52 <strtok+0x72>
        olds = str;
    4f5a:	00f8b023          	sd	a5,0(a7)
}
    4f5e:	8082                	ret
        str = olds;
    4f60:	0008b503          	ld	a0,0(a7)
    4f64:	b759                	j	4eea <strtok+0xa>
    while (*s)
    4f66:	0016c603          	lbu	a2,1(a3)
        s++;
    4f6a:	0685                	addi	a3,a3,1
    while (*s)
    4f6c:	fe6d                	bnez	a2,4f66 <strtok+0x86>
    4f6e:	b7cd                	j	4f50 <strtok+0x70>

0000000000004f70 <strerror>:

char *strerror(int errnum)
{
    4f70:	87aa                	mv	a5,a0
    
    switch (errnum)
    4f72:	cd09                	beqz	a0,4f8c <strerror+0x1c>
    4f74:	4731                	li	a4,12
    4f76:	00000517          	auipc	a0,0x0
    4f7a:	12250513          	addi	a0,a0,290 # 5098 <_GLOBAL__sub_I__ZSt3cin+0xea>
    4f7e:	00e78b63          	beq	a5,a4,4f94 <strerror+0x24>
        return "Success";
    // case EINVAL: return "Invalid argument";
    case ENOMEM: return "Out of memory";
    
    default:
        return "Unknown error";
    4f82:	00000517          	auipc	a0,0x0
    4f86:	12650513          	addi	a0,a0,294 # 50a8 <_GLOBAL__sub_I__ZSt3cin+0xfa>
    4f8a:	8082                	ret
        return "Success";
    4f8c:	00000517          	auipc	a0,0x0
    4f90:	10450513          	addi	a0,a0,260 # 5090 <_GLOBAL__sub_I__ZSt3cin+0xe2>
    }
    4f94:	8082                	ret

0000000000004f96 <_Znwm>:
#include "ulib/stdlib.h"

void *operator new(unsigned long n)
{
    return malloc(n);
    4f96:	cf6ff06f          	j	448c <malloc>

0000000000004f9a <_Znam>:
}

void *operator new[](unsigned long n)
    4f9a:	cf2ff06f          	j	448c <malloc>

0000000000004f9e <_ZdlPv>:
    return malloc(n);
}

void operator delete(void *p)
{
    free(p);
    4f9e:	c78ff06f          	j	4416 <free>

0000000000004fa2 <_ZdaPv>:
}

void operator delete[](void *p)
    4fa2:	c74ff06f          	j	4416 <free>

0000000000004fa6 <_ZdlPvm>:
    free(p);
}

void operator delete(void *p, unsigned long)
{
    free(p);
    4fa6:	c70ff06f          	j	4416 <free>

0000000000004faa <_ZdaPvm>:
}

void operator delete[](void *p, unsigned long)
    4faa:	c6cff06f          	j	4416 <free>

0000000000004fae <_GLOBAL__sub_I__ZSt3cin>:
#include "ulib/iostream"

namespace std
{
    istream cin(stdin);
    4fae:	00002797          	auipc	a5,0x2
    4fb2:	6a27b783          	ld	a5,1698(a5) # 7650 <_GLOBAL_OFFSET_TABLE_+0x10>
    4fb6:	6390                	ld	a2,0(a5)
    ostream cout(stdout);
    4fb8:	00002797          	auipc	a5,0x2
    4fbc:	6907b783          	ld	a5,1680(a5) # 7648 <_GLOBAL_OFFSET_TABLE_+0x8>
    4fc0:	6394                	ld	a3,0(a5)
    ostream cerr(stderr);
    4fc2:	00002797          	auipc	a5,0x2
    4fc6:	6967b783          	ld	a5,1686(a5) # 7658 <_GLOBAL_OFFSET_TABLE_+0x18>
    4fca:	6398                	ld	a4,0(a5)

    class istream{
    private:
        FILE* _stream;
    public:
        istream(FILE *f) : _stream(f) {}
    4fcc:	00002797          	auipc	a5,0x2
    4fd0:	7dc78793          	addi	a5,a5,2012 # 77a8 <_ZSt3cin>
    4fd4:	e390                	sd	a2,0(a5)
        ostream(FILE* f) : _stream(f) {}
    4fd6:	e794                	sd	a3,8(a5)
    4fd8:	eb98                	sd	a4,16(a5)
} // namespace std
    4fda:	8082                	ret
