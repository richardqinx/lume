
build/user/initcode.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "ulib/stdlib.h"
#include "ulib/string.h"
#include "user/user.h"

int main()
{
       0:	715d                	addi	sp,sp,-80
    char *argv[] = {(char *)"sh", 0};
       2:	00005797          	auipc	a5,0x5
       6:	00e78793          	addi	a5,a5,14 # 5010 <_GLOBAL__sub_I__ZSt3cin+0x30>

    printf("[Init] Starting Lume OS Shell...\n");
       a:	00005517          	auipc	a0,0x5
       e:	00e50513          	addi	a0,a0,14 # 5018 <_GLOBAL__sub_I__ZSt3cin+0x38>
{
      12:	fc26                	sd	s1,56(sp)
      14:	f84a                	sd	s2,48(sp)
      16:	f44e                	sd	s3,40(sp)
      18:	f052                	sd	s4,32(sp)
      1a:	e486                	sd	ra,72(sp)
      1c:	e0a2                	sd	s0,64(sp)
    char *argv[] = {(char *)"sh", 0};
      1e:	e83e                	sd	a5,16(sp)
      20:	ec02                	sd	zero,24(sp)
    printf("[Init] Starting Lume OS Shell...\n");
      22:	0024                	addi	s1,sp,8
      24:	0c7030ef          	jal	38ea <printf>
        int pid = fork();
        // printf("fork suceess, pid=%i\n", pid);
        
        if (pid < 0)
        {
            printf("[Init] fork failed!\n");
      28:	00005a17          	auipc	s4,0x5
      2c:	018a0a13          	addi	s4,s4,24 # 5040 <_GLOBAL__sub_I__ZSt3cin+0x60>
                    printf("Shell Exit");
                    break;
                }
                if (wpid < 0)
                {
                    printf("[Init] wait error or no child\n");
      30:	00005997          	auipc	s3,0x5
      34:	05098993          	addi	s3,s3,80 # 5080 <_GLOBAL__sub_I__ZSt3cin+0xa0>
                    printf("Shell Exit");
      38:	00005917          	auipc	s2,0x5
      3c:	03890913          	addi	s2,s2,56 # 5070 <_GLOBAL__sub_I__ZSt3cin+0x90>
        int pid = fork();
      40:	088000ef          	jal	c8 <fork>
      44:	842a                	mv	s0,a0
        if (pid < 0)
      46:	02054363          	bltz	a0,6c <main+0x6c>
        if (pid == 0)
      4a:	e501                	bnez	a0,52 <main+0x52>
      4c:	a81d                	j	82 <main+0x82>
                if (wpid < 0)
      4e:	02054663          	bltz	a0,7a <main+0x7a>
                wpid = wait((uint64)&status);
      52:	8526                	mv	a0,s1
      54:	07c000ef          	jal	d0 <wait>
                if (wpid == pid)
      58:	fea41be3          	bne	s0,a0,4e <main+0x4e>
                    printf("Shell Exit");
      5c:	854a                	mv	a0,s2
      5e:	08d030ef          	jal	38ea <printf>
        int pid = fork();
      62:	066000ef          	jal	c8 <fork>
      66:	842a                	mv	s0,a0
        if (pid < 0)
      68:	fe0551e3          	bgez	a0,4a <main+0x4a>
            printf("[Init] fork failed!\n");
      6c:	8552                	mv	a0,s4
      6e:	07d030ef          	jal	38ea <printf>
            exit(1);
      72:	4505                	li	a0,1
      74:	38a040ef          	jal	43fe <exit>
        if (pid == 0)
      78:	bfe9                	j	52 <main+0x52>
                    printf("[Init] wait error or no child\n");
      7a:	854e                	mv	a0,s3
      7c:	06f030ef          	jal	38ea <printf>

                    break;
                }
            }
        }
    }
      80:	b7c1                	j	40 <main+0x40>
            char sh_path[] = "/sh";
      82:	006877b7          	lui	a5,0x687
      86:	32f78793          	addi	a5,a5,815 # 68732f <_ZSt4cerr+0x67fac7>
            exec(sh_path, argv);
      8a:	080c                	addi	a1,sp,16
      8c:	8526                	mv	a0,s1
            char sh_path[] = "/sh";
      8e:	c43e                	sw	a5,8(sp)
            exec(sh_path, argv);
      90:	070000ef          	jal	100 <exec>
            printf("[Init] exec sh failed\n");
      94:	00005517          	auipc	a0,0x5
      98:	fc450513          	addi	a0,a0,-60 # 5058 <_GLOBAL__sub_I__ZSt3cin+0x78>
      9c:	04f030ef          	jal	38ea <printf>
    return 0;
      a0:	60a6                	ld	ra,72(sp)
      a2:	6406                	ld	s0,64(sp)
      a4:	74e2                	ld	s1,56(sp)
      a6:	7942                	ld	s2,48(sp)
      a8:	79a2                	ld	s3,40(sp)
      aa:	7a02                	ld	s4,32(sp)
      ac:	4501                	li	a0,0
      ae:	6161                	addi	sp,sp,80
      b0:	8082                	ret

00000000000000b2 <_start>:
.section .text
.global _start

_start:
    li a0, 0
      b2:	4501                	li	a0,0
    li a1, 0
      b4:	4581                	li	a1,0

    call main
      b6:	f4bff0ef          	jal	0 <main>

    call exit
      ba:	344040ef          	jal	43fe <exit>

      be:	a001                	j	be <_start+0xc>

00000000000000c0 <sys_exit>:
    name: \
        li a7, SYS_ ## sysname; \
        ecall; \
        ret

SYSCALL_NAME(sys_exit, exit) 
      c0:	488d                	li	a7,3
      c2:	00000073          	ecall
      c6:	8082                	ret

00000000000000c8 <fork>:

SYSCALL(fork)
      c8:	4889                	li	a7,2
      ca:	00000073          	ecall
      ce:	8082                	ret

00000000000000d0 <wait>:
SYSCALL(wait)
      d0:	4891                	li	a7,4
      d2:	00000073          	ecall
      d6:	8082                	ret

00000000000000d8 <pipe>:
SYSCALL(pipe)
      d8:	4895                	li	a7,5
      da:	00000073          	ecall
      de:	8082                	ret

00000000000000e0 <read>:
SYSCALL(read)
      e0:	4899                	li	a7,6
      e2:	00000073          	ecall
      e6:	8082                	ret

00000000000000e8 <write>:
SYSCALL(write)
      e8:	48c5                	li	a7,17
      ea:	00000073          	ecall
      ee:	8082                	ret

00000000000000f0 <close>:
SYSCALL(close)
      f0:	48d9                	li	a7,22
      f2:	00000073          	ecall
      f6:	8082                	ret

00000000000000f8 <kill>:
SYSCALL(kill)
      f8:	489d                	li	a7,7
      fa:	00000073          	ecall
      fe:	8082                	ret

0000000000000100 <exec>:
SYSCALL(exec)
     100:	48a1                	li	a7,8
     102:	00000073          	ecall
     106:	8082                	ret

0000000000000108 <open>:
SYSCALL(open)
     108:	48c1                	li	a7,16
     10a:	00000073          	ecall
     10e:	8082                	ret

0000000000000110 <mknod>:
SYSCALL(mknod)
     110:	48c9                	li	a7,18
     112:	00000073          	ecall
     116:	8082                	ret

0000000000000118 <unlink>:
SYSCALL(unlink)
     118:	48cd                	li	a7,19
     11a:	00000073          	ecall
     11e:	8082                	ret

0000000000000120 <fstat>:
SYSCALL(fstat)
     120:	48a5                	li	a7,9
     122:	00000073          	ecall
     126:	8082                	ret

0000000000000128 <link>:
SYSCALL(link)
     128:	48d1                	li	a7,20
     12a:	00000073          	ecall
     12e:	8082                	ret

0000000000000130 <mkdir>:
SYSCALL(mkdir)
     130:	48d5                	li	a7,21
     132:	00000073          	ecall
     136:	8082                	ret

0000000000000138 <chdir>:
SYSCALL(chdir)
     138:	48a9                	li	a7,10
     13a:	00000073          	ecall
     13e:	8082                	ret

0000000000000140 <dup>:
SYSCALL(dup)
     140:	48ad                	li	a7,11
     142:	00000073          	ecall
     146:	8082                	ret

0000000000000148 <getpid>:
SYSCALL(getpid)
     148:	48b1                	li	a7,12
     14a:	00000073          	ecall
     14e:	8082                	ret

0000000000000150 <sbrk>:
SYSCALL(sbrk)
     150:	48b5                	li	a7,13
     152:	00000073          	ecall
     156:	8082                	ret

0000000000000158 <sleep>:
SYSCALL(sleep)
     158:	48b9                	li	a7,14
     15a:	00000073          	ecall
     15e:	8082                	ret

0000000000000160 <uptime>:
SYSCALL(uptime)
     160:	48bd                	li	a7,15
     162:	00000073          	ecall
     166:	8082                	ret

0000000000000168 <putc>:
SYSCALL(putc)
     168:	4885                	li	a7,1
     16a:	00000073          	ecall
     16e:	8082                	ret

0000000000000170 <disk_test>:
SYSCALL(disk_test)
     170:	48dd                	li	a7,23
     172:	00000073          	ecall
     176:	8082                	ret

0000000000000178 <lseek>:
     178:	48e1                	li	a7,24
     17a:	00000073          	ecall
     17e:	8082                	ret

0000000000000180 <stbsp__clamp_callback>:
     180:	45dc                	lw	a5,12(a1)
     182:	4598                	lw	a4,8(a1)
     184:	9fb1                	addw	a5,a5,a2
     186:	c5dc                	sw	a5,12(a1)
     188:	0007069b          	sext.w	a3,a4
     18c:	00e65463          	bge	a2,a4,194 <stbsp__clamp_callback+0x14>
     190:	0006069b          	sext.w	a3,a2
     194:	c685                	beqz	a3,1bc <stbsp__clamp_callback+0x3c>
     196:	619c                	ld	a5,0(a1)
     198:	00a78e63          	beq	a5,a0,1b4 <stbsp__clamp_callback+0x34>
     19c:	00d50633          	add	a2,a0,a3
     1a0:	00054703          	lbu	a4,0(a0)
     1a4:	0505                	addi	a0,a0,1
     1a6:	0785                	addi	a5,a5,1
     1a8:	fee78fa3          	sb	a4,-1(a5)
     1ac:	fec56ae3          	bltu	a0,a2,1a0 <stbsp__clamp_callback+0x20>
     1b0:	6188                	ld	a0,0(a1)
     1b2:	4598                	lw	a4,8(a1)
     1b4:	9f15                	subw	a4,a4,a3
     1b6:	9536                	add	a0,a0,a3
     1b8:	e188                	sd	a0,0(a1)
     1ba:	c598                	sw	a4,8(a1)
     1bc:	1ff00793          	li	a5,511
     1c0:	00e7d463          	bge	a5,a4,1c8 <stbsp__clamp_callback+0x48>
     1c4:	6188                	ld	a0,0(a1)
     1c6:	8082                	ret
     1c8:	01058513          	addi	a0,a1,16
     1cc:	8082                	ret

00000000000001ce <stbsp__count_clamp_callback>:
     1ce:	45dc                	lw	a5,12(a1)
     1d0:	01058513          	addi	a0,a1,16
     1d4:	9fb1                	addw	a5,a5,a2
     1d6:	c5dc                	sw	a5,12(a1)
     1d8:	8082                	ret

00000000000001da <stbsp__real_to_str>:
     1da:	e20508d3          	fmv.x.d	a7,fa0
     1de:	82aa                	mv	t0,a0
     1e0:	4348d813          	srai	a6,a7,0x34
     1e4:	8ec6                	mv	t4,a7
     1e6:	7ff87813          	andi	a6,a6,2047
     1ea:	8346                	mv	t1,a7
     1ec:	03f8d513          	srli	a0,a7,0x3f
     1f0:	0008d663          	bgez	a7,1fc <stbsp__real_to_str+0x22>
     1f4:	22a517d3          	fneg.d	fa5,fa0
     1f8:	e20788d3          	fmv.x.d	a7,fa5
     1fc:	7ff00e13          	li	t3,2047
     200:	35c80663          	beq	a6,t3,54c <stbsp__real_to_str+0x372>
     204:	1101                	addi	sp,sp,-32
     206:	14080363          	beqz	a6,34c <stbsp__real_to_str+0x172>
     20a:	c018081b          	addiw	a6,a6,-1023
     20e:	ec22                	sd	s0,24(sp)
     210:	02081313          	slli	t1,a6,0x20
     214:	66034d63          	bltz	t1,88e <stbsp__real_to_str+0x6b4>
     218:	4d100313          	li	t1,1233
     21c:	0303033b          	mulw	t1,t1,a6
     220:	4849                	li	a6,18
     222:	40c3531b          	sraiw	t1,t1,0xc
     226:	0013039b          	addiw	t2,t1,1
     22a:	4078083b          	subw	a6,a6,t2
     22e:	4359                	li	t1,22
     230:	17036163          	bltu	t1,a6,392 <stbsp__real_to_str+0x1b8>
     234:	00005317          	auipc	t1,0x5
     238:	1a430313          	addi	t1,t1,420 # 53d8 <stbsp__bot>
     23c:	080e                	slli	a6,a6,0x3
     23e:	981a                	add	a6,a6,t1
     240:	00083e03          	ld	t3,0(a6)
     244:	00083607          	fld	fa2,0(a6)
     248:	f20887d3          	fmv.d.x	fa5,a7
     24c:	f8000837          	lui	a6,0xf8000
     250:	01187333          	and	t1,a6,a7
     254:	01c87833          	and	a6,a6,t3
     258:	12f676d3          	fmul.d	fa3,fa2,fa5
     25c:	f20807d3          	fmv.d.x	fa5,a6
     260:	f2030753          	fmv.d.x	fa4,t1
     264:	f20305d3          	fmv.d.x	fa1,t1
     268:	0af67653          	fsub.d	fa2,fa2,fa5
     26c:	f20887d3          	fmv.d.x	fa5,a7
     270:	0ae7f753          	fsub.d	fa4,fa5,fa4
     274:	f20807d3          	fmv.d.x	fa5,a6
     278:	6ab7f7c7          	fmsub.d	fa5,fa5,fa1,fa3
     27c:	7ab677c3          	fmadd.d	fa5,fa2,fa1,fa5
     280:	f20805d3          	fmv.d.x	fa1,a6
     284:	7ab777c3          	fmadd.d	fa5,fa4,fa1,fa5
     288:	7ac77743          	fmadd.d	fa4,fa4,fa2,fa5
     28c:	02d777d3          	fadd.d	fa5,fa4,fa3
     290:	3782e837          	lui	a6,0x3782e
     294:	acf80813          	addi	a6,a6,-1329 # 3782dacf <_ZSt4cerr+0x37826267>
     298:	0832                	slli	a6,a6,0xc
     29a:	9d980813          	addi	a6,a6,-1575
     29e:	084a                	slli	a6,a6,0x12
     2a0:	187d                	addi	a6,a6,-1
     2a2:	c22798d3          	fcvt.l.d	a7,fa5,rtz
     2a6:	0ad7f6d3          	fsub.d	fa3,fa5,fa3
     2aa:	00070e1b          	sext.w	t3,a4
     2ae:	d228f653          	fcvt.d.l	fa2,a7
     2b2:	0ac7f5d3          	fsub.d	fa1,fa5,fa2
     2b6:	0ad77753          	fsub.d	fa4,fa4,fa3
     2ba:	0af5f6d3          	fsub.d	fa3,fa1,fa5
     2be:	0ad5f553          	fsub.d	fa0,fa1,fa3
     2c2:	02d67653          	fadd.d	fa2,fa2,fa3
     2c6:	0aa7f7d3          	fsub.d	fa5,fa5,fa0
     2ca:	0ac7f7d3          	fsub.d	fa5,fa5,fa2
     2ce:	02b7f7d3          	fadd.d	fa5,fa5,fa1
     2d2:	02e7f7d3          	fadd.d	fa5,fa5,fa4
     2d6:	c2279fd3          	fcvt.l.d	t6,fa5,rtz
     2da:	9fc6                	add	t6,t6,a7
     2dc:	19f87063          	bgeu	a6,t6,45c <stbsp__real_to_str+0x282>
     2e0:	2385                	addiw	t2,t2,1
     2e2:	300e4363          	bltz	t3,5e8 <stbsp__real_to_str+0x40e>
     2e6:	00e3833b          	addw	t1,t2,a4
     2ea:	475d                	li	a4,23
     2ec:	30677663          	bgeu	a4,t1,5f8 <stbsp__real_to_str+0x41e>
     2f0:	577d                	li	a4,-1
     2f2:	9301                	srli	a4,a4,0x20
     2f4:	43f75863          	bge	a4,t6,724 <stbsp__real_to_str+0x54a>
     2f8:	07d00313          	li	t1,125
     2fc:	877e                	mv	a4,t6
     2fe:	4e01                	li	t3,0
     300:	3e800813          	li	a6,1000
     304:	130e                	slli	t1,t1,0x23
     306:	a039                	j	314 <stbsp__real_to_str+0x13a>
     308:	030747b3          	div	a5,a4,a6
     30c:	4e05                	li	t3,1
     30e:	40674c63          	blt	a4,t1,726 <stbsp__real_to_str+0x54c>
     312:	873e                	mv	a4,a5
     314:	030768b3          	rem	a7,a4,a6
     318:	fe0888e3          	beqz	a7,308 <stbsp__real_to_str+0x12e>
     31c:	400e0163          	beqz	t3,71e <stbsp__real_to_str+0x544>
     320:	8fbe                	mv	t6,a5
     322:	05f5e7b7          	lui	a5,0x5f5e
     326:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f56897>
     32a:	04060413          	addi	s0,a2,64
     32e:	03860613          	addi	a2,a2,56
     332:	15f7c863          	blt	a5,t6,482 <stbsp__real_to_str+0x2a8>
     336:	000f871b          	sext.w	a4,t6
     33a:	20070463          	beqz	a4,542 <stbsp__real_to_str+0x368>
     33e:	4f01                	li	t5,0
     340:	4f81                	li	t6,0
     342:	00006e97          	auipc	t4,0x6
     346:	62ee8e93          	addi	t4,t4,1582 # 6970 <stbsp__digitpair>
     34a:	aaa9                	j	4a4 <stbsp__real_to_str+0x2ca>
     34c:	0306                	slli	t1,t1,0x1
     34e:	3e030e63          	beqz	t1,74a <stbsp__real_to_str+0x570>
     352:	4305                	li	t1,1
     354:	ec22                	sd	s0,24(sp)
     356:	00ce9e13          	slli	t3,t4,0xc
     35a:	134e                	slli	t1,t1,0x33
     35c:	520e4063          	bltz	t3,87c <stbsp__real_to_str+0x6a2>
     360:	40135313          	srai	t1,t1,0x1
     364:	01d37e33          	and	t3,t1,t4
     368:	8f42                	mv	t5,a6
     36a:	387d                	addiw	a6,a6,-1
     36c:	fe0e0ae3          	beqz	t3,360 <stbsp__real_to_str+0x186>
     370:	26900313          	li	t1,617
     374:	c00f081b          	addiw	a6,t5,-1024
     378:	0268083b          	mulw	a6,a6,t1
     37c:	41f8531b          	sraiw	t1,a6,0x1f
     380:	0153531b          	srliw	t1,t1,0x15
     384:	0103033b          	addw	t1,t1,a6
     388:	40b3539b          	sraiw	t2,t1,0xb
     38c:	4849                	li	a6,18
     38e:	4078083b          	subw	a6,a6,t2
     392:	41f8531b          	sraiw	t1,a6,0x1f
     396:	00684eb3          	xor	t4,a6,t1
     39a:	406e8f3b          	subw	t5,t4,t1
     39e:	2c900313          	li	t1,713
     3a2:	03e3033b          	mulw	t1,t1,t5
     3a6:	4e35                	li	t3,13
     3a8:	8efa                	mv	t4,t5
     3aa:	40e35f9b          	sraiw	t6,t1,0xe
     3ae:	837e                	mv	t1,t6
     3b0:	23fe4363          	blt	t3,t6,5d6 <stbsp__real_to_str+0x3fc>
     3b4:	5e25                	li	t3,-23
     3b6:	026e0e3b          	mulw	t3,t3,t1
     3ba:	01de0ebb          	addw	t4,t3,t4
     3be:	22084f63          	bltz	a6,5fc <stbsp__real_to_str+0x422>
     3c2:	f2000753          	fmv.d.x	fa4,zero
     3c6:	00005e17          	auipc	t3,0x5
     3ca:	012e0e13          	addi	t3,t3,18 # 53d8 <stbsp__bot>
     3ce:	380e9e63          	bnez	t4,76a <stbsp__real_to_str+0x590>
     3d2:	f20887d3          	fmv.d.x	fa5,a7
     3d6:	fff30f1b          	addiw	t5,t1,-1
     3da:	0f0e                	slli	t5,t5,0x3
     3dc:	02f777d3          	fadd.d	fa5,fa4,fa5
     3e0:	030e                	slli	t1,t1,0x3
     3e2:	9f72                	add	t5,t5,t3
     3e4:	9e1a                	add	t3,t3,t1
     3e6:	2e0e3e03          	ld	t3,736(t3)
     3ea:	2e8f3587          	fld	fa1,744(t5)
     3ee:	f8000837          	lui	a6,0xf8000
     3f2:	e2078ed3          	fmv.x.d	t4,fa5
     3f6:	12b7f6d3          	fmul.d	fa3,fa5,fa1
     3fa:	f2088653          	fmv.d.x	fa2,a7
     3fe:	01d87333          	and	t1,a6,t4
     402:	01c87833          	and	a6,a6,t3
     406:	f20807d3          	fmv.d.x	fa5,a6
     40a:	f2030053          	fmv.d.x	ft0,t1
     40e:	0af5f553          	fsub.d	fa0,fa1,fa5
     412:	f20e87d3          	fmv.d.x	fa5,t4
     416:	0ac7f0d3          	fsub.d	ft1,fa5,fa2
     41a:	f20807d3          	fmv.d.x	fa5,a6
     41e:	f2030653          	fmv.d.x	fa2,t1
     422:	6ac7f647          	fmsub.d	fa2,fa5,fa2,fa3
     426:	f20e87d3          	fmv.d.x	fa5,t4
     42a:	0a177753          	fsub.d	fa4,fa4,ft1
     42e:	f20300d3          	fmv.d.x	ft1,t1
     432:	0a07f7d3          	fsub.d	fa5,fa5,ft0
     436:	350f3007          	fld	ft0,848(t5)
     43a:	62157643          	fmadd.d	fa2,fa0,ft1,fa2
     43e:	12b77753          	fmul.d	fa4,fa4,fa1
     442:	f20805d3          	fmv.d.x	fa1,a6
     446:	62b7f643          	fmadd.d	fa2,fa5,fa1,fa2
     44a:	f20e85d3          	fmv.d.x	fa1,t4
     44e:	7205f743          	fmadd.d	fa4,fa1,ft0,fa4
     452:	62a7f7c3          	fmadd.d	fa5,fa5,fa0,fa2
     456:	02e7f753          	fadd.d	fa4,fa5,fa4
     45a:	bd0d                	j	28c <stbsp__real_to_str+0xb2>
     45c:	00e3833b          	addw	t1,t2,a4
     460:	2a0e4663          	bltz	t3,70c <stbsp__real_to_str+0x532>
     464:	475d                	li	a4,23
     466:	10677663          	bgeu	a4,t1,572 <stbsp__real_to_str+0x398>
     46a:	e80f93e3          	bnez	t6,2f0 <stbsp__real_to_str+0x116>
     46e:	05f5e7b7          	lui	a5,0x5f5e
     472:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f56897>
     476:	04060413          	addi	s0,a2,64
     47a:	03860613          	addi	a2,a2,56
     47e:	ebf7dce3          	bge	a5,t6,336 <stbsp__real_to_str+0x15c>
     482:	4f01                	li	t5,0
     484:	00006e97          	auipc	t4,0x6
     488:	4ece8e93          	addi	t4,t4,1260 # 6970 <stbsp__digitpair>
     48c:	05f5e7b7          	lui	a5,0x5f5e
     490:	10078793          	addi	a5,a5,256 # 5f5e100 <_ZSt4cerr+0x5f56898>
     494:	02ffe833          	rem	a6,t6,a5
     498:	02ffcfb3          	div	t6,t6,a5
     49c:	0008071b          	sext.w	a4,a6
     4a0:	0a080463          	beqz	a6,548 <stbsp__real_to_str+0x36e>
     4a4:	8822                	mv	a6,s0
     4a6:	06400893          	li	a7,100
     4aa:	06300e13          	li	t3,99
     4ae:	1879                	addi	a6,a6,-2 # fffffffff7fffffe <_ZSt4cerr+0xfffffffff7ff8796>
     4b0:	0007031b          	sext.w	t1,a4
     4b4:	031777bb          	remuw	a5,a4,a7
     4b8:	2785                	addiw	a5,a5,1
     4ba:	0017979b          	slliw	a5,a5,0x1
     4be:	1782                	slli	a5,a5,0x20
     4c0:	9381                	srli	a5,a5,0x20
     4c2:	97f6                	add	a5,a5,t4
     4c4:	0007d783          	lhu	a5,0(a5)
     4c8:	0317573b          	divuw	a4,a4,a7
     4cc:	00f81023          	sh	a5,0(a6)
     4d0:	fc6e6fe3          	bltu	t3,t1,4ae <stbsp__real_to_str+0x2d4>
     4d4:	008f0f3b          	addw	t5,t5,s0
     4d8:	410f0f3b          	subw	t5,t5,a6
     4dc:	020f8f63          	beqz	t6,51a <stbsp__real_to_str+0x340>
     4e0:	87c2                	mv	a5,a6
     4e2:	03000713          	li	a4,48
     4e6:	04c80c63          	beq	a6,a2,53e <stbsp__real_to_str+0x364>
     4ea:	17fd                	addi	a5,a5,-1
     4ec:	00e78023          	sb	a4,0(a5)
     4f0:	fec79de3          	bne	a5,a2,4ea <stbsp__real_to_str+0x310>
     4f4:	408807b3          	sub	a5,a6,s0
     4f8:	00ff07bb          	addw	a5,t5,a5
     4fc:	1461                	addi	s0,s0,-8
     4fe:	00878f1b          	addiw	t5,a5,8
     502:	05f5e7b7          	lui	a5,0x5f5e
     506:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f56897>
     50a:	ff840613          	addi	a2,s0,-8
     50e:	f7f7cfe3          	blt	a5,t6,48c <stbsp__real_to_str+0x2b2>
     512:	000f871b          	sext.w	a4,t6
     516:	4f81                	li	t6,0
     518:	b771                	j	4a4 <stbsp__real_to_str+0x2ca>
     51a:	020f0563          	beqz	t5,544 <stbsp__real_to_str+0x36a>
     51e:	00084703          	lbu	a4,0(a6)
     522:	03000793          	li	a5,48
     526:	22f70f63          	beq	a4,a5,764 <stbsp__real_to_str+0x58a>
     52a:	2f01                	sext.w	t5,t5
     52c:	0076a023          	sw	t2,0(a3)
     530:	6462                	ld	s0,24(sp)
     532:	0102b023          	sd	a6,0(t0)
     536:	01e5a023          	sw	t5,0(a1)
     53a:	6105                	addi	sp,sp,32
     53c:	8082                	ret
     53e:	8442                	mv	s0,a6
     540:	b7c9                	j	502 <stbsp__real_to_str+0x328>
     542:	8822                	mv	a6,s0
     544:	4f01                	li	t5,0
     546:	b7dd                	j	52c <stbsp__real_to_str+0x352>
     548:	8822                	mv	a6,s0
     54a:	bf59                	j	4e0 <stbsp__real_to_str+0x306>
     54c:	0eb2                	slli	t4,t4,0xc
     54e:	00005797          	auipc	a5,0x5
     552:	b5a78793          	addi	a5,a5,-1190 # 50a8 <_GLOBAL__sub_I__ZSt3cin+0xc8>
     556:	000e8663          	beqz	t4,562 <stbsp__real_to_str+0x388>
     55a:	00005797          	auipc	a5,0x5
     55e:	b4678793          	addi	a5,a5,-1210 # 50a0 <_GLOBAL__sub_I__ZSt3cin+0xc0>
     562:	00f2b023          	sd	a5,0(t0)
     566:	679d                	lui	a5,0x7
     568:	c29c                	sw	a5,0(a3)
     56a:	4f0d                	li	t5,3
     56c:	01e5a023          	sw	t5,0(a1)
     570:	8082                	ret
     572:	3b9ad737          	lui	a4,0x3b9ad
     576:	9ff70713          	addi	a4,a4,-1537 # 3b9ac9ff <_ZSt4cerr+0x3b9a5197>
     57a:	07f76f63          	bltu	a4,t6,5f8 <stbsp__real_to_str+0x41e>
     57e:	4805                	li	a6,1
     580:	02081713          	slli	a4,a6,0x20
     584:	01d75893          	srli	a7,a4,0x1d
     588:	00005717          	auipc	a4,0x5
     58c:	20870713          	addi	a4,a4,520 # 5790 <stbsp__powten>
     590:	9746                	add	a4,a4,a7
     592:	4e51                	li	t3,20
     594:	a021                	j	59c <stbsp__real_to_str+0x3c2>
     596:	2805                	addiw	a6,a6,1
     598:	edc809e3          	beq	a6,t3,46a <stbsp__real_to_str+0x290>
     59c:	00073883          	ld	a7,0(a4)
     5a0:	0721                	addi	a4,a4,8
     5a2:	ff1ffae3          	bgeu	t6,a7,596 <stbsp__real_to_str+0x3bc>
     5a6:	ed0372e3          	bgeu	t1,a6,46a <stbsp__real_to_str+0x290>
     5aa:	4068083b          	subw	a6,a6,t1
     5ae:	475d                	li	a4,23
     5b0:	eb076de3          	bltu	a4,a6,46a <stbsp__real_to_str+0x290>
     5b4:	080e                	slli	a6,a6,0x3
     5b6:	00005717          	auipc	a4,0x5
     5ba:	e2270713          	addi	a4,a4,-478 # 53d8 <stbsp__bot>
     5be:	9742                	add	a4,a4,a6
     5c0:	3b873803          	ld	a6,952(a4)
     5c4:	00185713          	srli	a4,a6,0x1
     5c8:	977e                	add	a4,a4,t6
     5ca:	01176363          	bltu	a4,a7,5d0 <stbsp__real_to_str+0x3f6>
     5ce:	2385                	addiw	t2,t2,1
     5d0:	03075fb3          	divu	t6,a4,a6
     5d4:	bd59                	j	46a <stbsp__real_to_str+0x290>
     5d6:	4335                	li	t1,13
     5d8:	5e25                	li	t3,-23
     5da:	026e0e3b          	mulw	t3,t3,t1
     5de:	01de0ebb          	addw	t4,t3,t4
     5e2:	de0850e3          	bgez	a6,3c2 <stbsp__real_to_str+0x1e8>
     5e6:	a819                	j	5fc <stbsp__real_to_str+0x422>
     5e8:	02571313          	slli	t1,a4,0x25
     5ec:	02535313          	srli	t1,t1,0x25
     5f0:	0305                	addi	t1,t1,1
     5f2:	475d                	li	a4,23
     5f4:	ce676ee3          	bltu	a4,t1,2f0 <stbsp__real_to_str+0x116>
     5f8:	4829                	li	a6,10
     5fa:	b759                	j	580 <stbsp__real_to_str+0x3a6>
     5fc:	260e8663          	beqz	t4,868 <stbsp__real_to_str+0x68e>
     600:	00231e13          	slli	t3,t1,0x2
     604:	41c30e33          	sub	t3,t1,t3
     608:	0e0e                	slli	t3,t3,0x3
     60a:	9e1a                	add	t3,t3,t1
     60c:	fffe881b          	addiw	a6,t4,-1
     610:	9e7a                	add	t3,t3,t5
     612:	00005e97          	auipc	t4,0x5
     616:	dc6e8e93          	addi	t4,t4,-570 # 53d8 <stbsp__bot>
     61a:	0e0e                	slli	t3,t3,0x3
     61c:	080e                	slli	a6,a6,0x3
     61e:	9876                	add	a6,a6,t4
     620:	9ef2                	add	t4,t4,t3
     622:	0b883607          	fld	fa2,184(a6)
     626:	f20887d3          	fmv.d.x	fa5,a7
     62a:	0b0ebf03          	ld	t5,176(t4)
     62e:	f8000e37          	lui	t3,0xf8000
     632:	011e7eb3          	and	t4,t3,a7
     636:	12f676d3          	fmul.d	fa3,fa2,fa5
     63a:	01ee7e33          	and	t3,t3,t5
     63e:	f20e07d3          	fmv.d.x	fa5,t3
     642:	f20e0753          	fmv.d.x	fa4,t3
     646:	f20e8553          	fmv.d.x	fa0,t4
     64a:	0af67653          	fsub.d	fa2,fa2,fa5
     64e:	f20e87d3          	fmv.d.x	fa5,t4
     652:	f20e85d3          	fmv.d.x	fa1,t4
     656:	6ae7f7c7          	fmsub.d	fa5,fa5,fa4,fa3
     65a:	f2088753          	fmv.d.x	fa4,a7
     65e:	0ab775d3          	fsub.d	fa1,fa4,fa1
     662:	16883707          	fld	fa4,360(a6)
     666:	7aa677c3          	fmadd.d	fa5,fa2,fa0,fa5
     66a:	f20e0553          	fmv.d.x	fa0,t3
     66e:	7aa5f7c3          	fmadd.d	fa5,fa1,fa0,fa5
     672:	7ac5f5c3          	fmadd.d	fa1,fa1,fa2,fa5
     676:	f20887d3          	fmv.d.x	fa5,a7
     67a:	5af77743          	fmadd.d	fa4,fa4,fa5,fa1
     67e:	c00f87e3          	beqz	t6,28c <stbsp__real_to_str+0xb2>
     682:	02d777d3          	fadd.d	fa5,fa4,fa3
     686:	fff3089b          	addiw	a7,t1,-1
     68a:	00005817          	auipc	a6,0x5
     68e:	d4e80813          	addi	a6,a6,-690 # 53d8 <stbsp__bot>
     692:	030e                	slli	t1,t1,0x3
     694:	088e                	slli	a7,a7,0x3
     696:	98c2                	add	a7,a7,a6
     698:	981a                	add	a6,a6,t1
     69a:	e2078e53          	fmv.x.d	t3,fa5
     69e:	21083e83          	ld	t4,528(a6)
     6a2:	f8000837          	lui	a6,0xf8000
     6a6:	2188b507          	fld	fa0,536(a7)
     6aa:	01c87333          	and	t1,a6,t3
     6ae:	01d87833          	and	a6,a6,t4
     6b2:	f2080653          	fmv.d.x	fa2,a6
     6b6:	12f577d3          	fmul.d	fa5,fa0,fa5
     6ba:	2808b587          	fld	fa1,640(a7)
     6be:	0ac57053          	fsub.d	ft0,fa0,fa2
     6c2:	f20e0653          	fmv.d.x	fa2,t3
     6c6:	0ad67153          	fsub.d	ft2,fa2,fa3
     6ca:	f20806d3          	fmv.d.x	fa3,a6
     6ce:	f2030653          	fmv.d.x	fa2,t1
     6d2:	7ac6f0c7          	fmsub.d	ft1,fa3,fa2,fa5
     6d6:	f20e06d3          	fmv.d.x	fa3,t3
     6da:	0ac6f653          	fsub.d	fa2,fa3,fa2
     6de:	22f786d3          	fmv.d	fa3,fa5
     6e2:	0a2777d3          	fsub.d	fa5,fa4,ft2
     6e6:	f2030753          	fmv.d.x	fa4,t1
     6ea:	0ae07743          	fmadd.d	fa4,ft0,fa4,ft1
     6ee:	12a7f7d3          	fmul.d	fa5,fa5,fa0
     6f2:	f2080553          	fmv.d.x	fa0,a6
     6f6:	72a67743          	fmadd.d	fa4,fa2,fa0,fa4
     6fa:	f20e0553          	fmv.d.x	fa0,t3
     6fe:	7aa5f7c3          	fmadd.d	fa5,fa1,fa0,fa5
     702:	72067643          	fmadd.d	fa2,fa2,ft0,fa4
     706:	02f67753          	fadd.d	fa4,fa2,fa5
     70a:	b649                	j	28c <stbsp__real_to_str+0xb2>
     70c:	02571313          	slli	t1,a4,0x25
     710:	02535313          	srli	t1,t1,0x25
     714:	0305                	addi	t1,t1,1
     716:	475d                	li	a4,23
     718:	d46769e3          	bltu	a4,t1,46a <stbsp__real_to_str+0x290>
     71c:	bd99                	j	572 <stbsp__real_to_str+0x398>
     71e:	87fe                	mv	a5,t6
     720:	8fbe                	mv	t6,a5
     722:	b101                	j	322 <stbsp__real_to_str+0x148>
     724:	87fe                	mv	a5,t6
     726:	3e800713          	li	a4,1000
     72a:	02e7f73b          	remuw	a4,a5,a4
     72e:	2781                	sext.w	a5,a5
     730:	eb01                	bnez	a4,740 <stbsp__real_to_str+0x566>
     732:	3e800813          	li	a6,1000
     736:	0307d7bb          	divuw	a5,a5,a6
     73a:	0307f73b          	remuw	a4,a5,a6
     73e:	df65                	beqz	a4,736 <stbsp__real_to_str+0x55c>
     740:	02079f93          	slli	t6,a5,0x20
     744:	020fdf93          	srli	t6,t6,0x20
     748:	b31d                	j	46e <stbsp__real_to_str+0x294>
     74a:	4785                	li	a5,1
     74c:	c29c                	sw	a5,0(a3)
     74e:	00c2b023          	sd	a2,0(t0)
     752:	03000793          	li	a5,48
     756:	00f60023          	sb	a5,0(a2)
     75a:	4f05                	li	t5,1
     75c:	01e5a023          	sw	t5,0(a1)
     760:	6105                	addi	sp,sp,32
     762:	8082                	ret
     764:	0805                	addi	a6,a6,1 # fffffffff8000001 <_ZSt4cerr+0xfffffffff7ff8799>
     766:	3f7d                	addiw	t5,t5,-1
     768:	b3d1                	j	52c <stbsp__real_to_str+0x352>
     76a:	e826                	sd	s1,16(sp)
     76c:	e44a                	sd	s2,8(sp)
     76e:	4859                	li	a6,22
     770:	8976                	mv	s2,t4
     772:	11d84363          	blt	a6,t4,878 <stbsp__real_to_str+0x69e>
     776:	0009049b          	sext.w	s1,s2
     77a:	00005e17          	auipc	t3,0x5
     77e:	c5ee0e13          	addi	t3,t3,-930 # 53d8 <stbsp__bot>
     782:	00349813          	slli	a6,s1,0x3
     786:	9872                	add	a6,a6,t3
     788:	00083687          	fld	fa3,0(a6)
     78c:	00083803          	ld	a6,0(a6)
     790:	f20887d3          	fmv.d.x	fa5,a7
     794:	f8000fb7          	lui	t6,0xf8000
     798:	010ff833          	and	a6,t6,a6
     79c:	12f6f553          	fmul.d	fa0,fa3,fa5
     7a0:	f20807d3          	fmv.d.x	fa5,a6
     7a4:	011ff433          	and	s0,t6,a7
     7a8:	f2040753          	fmv.d.x	fa4,s0
     7ac:	0af6f6d3          	fsub.d	fa3,fa3,fa5
     7b0:	f20887d3          	fmv.d.x	fa5,a7
     7b4:	f2080653          	fmv.d.x	fa2,a6
     7b8:	412e8ebb          	subw	t4,t4,s2
     7bc:	0ae7f753          	fsub.d	fa4,fa5,fa4
     7c0:	f20407d3          	fmv.d.x	fa5,s0
     7c4:	e20508d3          	fmv.x.d	a7,fa0
     7c8:	52c7f7c7          	fmsub.d	fa5,fa5,fa2,fa0
     7cc:	f2040653          	fmv.d.x	fa2,s0
     7d0:	7ac6f7c3          	fmadd.d	fa5,fa3,fa2,fa5
     7d4:	f2080653          	fmv.d.x	fa2,a6
     7d8:	7ac777c3          	fmadd.d	fa5,fa4,fa2,fa5
     7dc:	7ad77743          	fmadd.d	fa4,fa4,fa3,fa5
     7e0:	080e8963          	beqz	t4,872 <stbsp__real_to_str+0x698>
     7e4:	02e577d3          	fadd.d	fa5,fa0,fa4
     7e8:	0e8e                	slli	t4,t4,0x3
     7ea:	01de0833          	add	a6,t3,t4
     7ee:	00083587          	fld	fa1,0(a6)
     7f2:	00231893          	slli	a7,t1,0x2
     7f6:	411308b3          	sub	a7,t1,a7
     7fa:	00389813          	slli	a6,a7,0x3
     7fe:	e2078453          	fmv.x.d	s0,fa5
     802:	12f5f7d3          	fmul.d	fa5,fa1,fa5
     806:	981a                	add	a6,a6,t1
     808:	987a                	add	a6,a6,t5
     80a:	40980833          	sub	a6,a6,s1
     80e:	080e                	slli	a6,a6,0x3
     810:	9872                	add	a6,a6,t3
     812:	00083e83          	ld	t4,0(a6)
     816:	008ff833          	and	a6,t6,s0
     81a:	e20788d3          	fmv.x.d	a7,fa5
     81e:	f20806d3          	fmv.d.x	fa3,a6
     822:	f20407d3          	fmv.d.x	fa5,s0
     826:	01dfffb3          	and	t6,t6,t4
     82a:	f20880d3          	fmv.d.x	ft1,a7
     82e:	0ad7f653          	fsub.d	fa2,fa5,fa3
     832:	f20f87d3          	fmv.d.x	fa5,t6
     836:	64c2                	ld	s1,16(sp)
     838:	6922                	ld	s2,8(sp)
     83a:	0af5f053          	fsub.d	ft0,fa1,fa5
     83e:	0ad7f6c7          	fmsub.d	fa3,fa5,fa3,ft1
     842:	f20407d3          	fmv.d.x	fa5,s0
     846:	0aa7f7d3          	fsub.d	fa5,fa5,fa0
     84a:	f2080553          	fmv.d.x	fa0,a6
     84e:	6aa076c3          	fmadd.d	fa3,ft0,fa0,fa3
     852:	0af77753          	fsub.d	fa4,fa4,fa5
     856:	f20f87d3          	fmv.d.x	fa5,t6
     85a:	6af677c3          	fmadd.d	fa5,fa2,fa5,fa3
     85e:	7a067643          	fmadd.d	fa2,fa2,ft0,fa5
     862:	62e5f743          	fmadd.d	fa4,fa1,fa4,fa2
     866:	b6b5                	j	3d2 <stbsp__real_to_str+0x1f8>
     868:	f20886d3          	fmv.d.x	fa3,a7
     86c:	f2000753          	fmv.d.x	fa4,zero
     870:	b539                	j	67e <stbsp__real_to_str+0x4a4>
     872:	64c2                	ld	s1,16(sp)
     874:	6922                	ld	s2,8(sp)
     876:	beb1                	j	3d2 <stbsp__real_to_str+0x1f8>
     878:	4959                	li	s2,22
     87a:	bdf5                	j	776 <stbsp__real_to_str+0x59c>
     87c:	e826                	sd	s1,16(sp)
     87e:	e44a                	sd	s2,8(sp)
     880:	ecc00393          	li	t2,-308
     884:	4eed                	li	t4,27
     886:	4335                	li	t1,13
     888:	14600f13          	li	t5,326
     88c:	b5cd                	j	76e <stbsp__real_to_str+0x594>
     88e:	26900313          	li	t1,617
     892:	0303083b          	mulw	a6,t1,a6
     896:	41f8531b          	sraiw	t1,a6,0x1f
     89a:	0153531b          	srliw	t1,t1,0x15
     89e:	0103033b          	addw	t1,t1,a6
     8a2:	40b3539b          	sraiw	t2,t1,0xb
     8a6:	4849                	li	a6,18
     8a8:	4078083b          	subw	a6,a6,t2
     8ac:	b249                	j	22e <stbsp__real_to_str+0x54>

00000000000008ae <_in_char.part.0>:
static int _in_char(_InContext *ctx)
     8ae:	87aa                	mv	a5,a0
    if (ctx->fd == -1)
     8b0:	4508                	lw	a0,8(a0)
     8b2:	577d                	li	a4,-1
     8b4:	00e51d63          	bne	a0,a4,8ce <_in_char.part.0+0x20>
        if (ctx->buf[ctx->pos] == '\0')
     8b8:	6b94                	ld	a3,16(a5)
     8ba:	6398                	ld	a4,0(a5)
     8bc:	9736                	add	a4,a4,a3
     8be:	00074603          	lbu	a2,0(a4)
     8c2:	c60d                	beqz	a2,8ec <_in_char.part.0+0x3e>
        return (unsigned char)ctx->buf[ctx->pos++];
     8c4:	0685                	addi	a3,a3,1
     8c6:	eb94                	sd	a3,16(a5)
     8c8:	00074503          	lbu	a0,0(a4)
     8cc:	8082                	ret
static int _in_char(_InContext *ctx)
     8ce:	1101                	addi	sp,sp,-32
    if (read(ctx->fd, &c, 1) == 1)
     8d0:	4605                	li	a2,1
     8d2:	00f10593          	addi	a1,sp,15
static int _in_char(_InContext *ctx)
     8d6:	ec06                	sd	ra,24(sp)
    if (read(ctx->fd, &c, 1) == 1)
     8d8:	809ff0ef          	jal	e0 <read>
     8dc:	4785                	li	a5,1
     8de:	00f51963          	bne	a0,a5,8f0 <_in_char.part.0+0x42>
        return (unsigned char)c;
     8e2:	00f14503          	lbu	a0,15(sp)
}
     8e6:	60e2                	ld	ra,24(sp)
     8e8:	6105                	addi	sp,sp,32
     8ea:	8082                	ret
            return -1;
     8ec:	557d                	li	a0,-1
}
     8ee:	8082                	ret
            return -1;
     8f0:	557d                	li	a0,-1
     8f2:	bfd5                	j	8e6 <_in_char.part.0+0x38>

00000000000008f4 <_skip_space>:
{
     8f4:	7139                	addi	sp,sp,-64
     8f6:	f822                	sd	s0,48(sp)
     8f8:	f426                	sd	s1,40(sp)
     8fa:	f04a                	sd	s2,32(sp)
     8fc:	ec4e                	sd	s3,24(sp)
     8fe:	e852                	sd	s4,16(sp)
     900:	fc06                	sd	ra,56(sp)
     902:	842a                	mv	s0,a0
        ctx->ungotten = -1;
     904:	54fd                	li	s1,-1
    if (read(ctx->fd, &c, 1) == 1)
     906:	00f10a13          	addi	s4,sp,15
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     90a:	02000913          	li	s2,32
     90e:	4991                	li	s3,4
    if (ctx->ungotten >= 0)
     910:	4c1c                	lw	a5,24(s0)
     912:	0407d163          	bgez	a5,954 <_skip_space+0x60>
    if (ctx->fd == -1)
     916:	4408                	lw	a0,8(s0)
    if (read(ctx->fd, &c, 1) == 1)
     918:	4605                	li	a2,1
     91a:	85d2                	mv	a1,s4
    if (ctx->fd == -1)
     91c:	02951e63          	bne	a0,s1,958 <_skip_space+0x64>
        if (ctx->buf[ctx->pos] == '\0')
     920:	6818                	ld	a4,16(s0)
     922:	601c                	ld	a5,0(s0)
        return (unsigned char)ctx->buf[ctx->pos++];
     924:	00170693          	addi	a3,a4,1
        if (ctx->buf[ctx->pos] == '\0')
     928:	97ba                	add	a5,a5,a4
     92a:	0007c703          	lbu	a4,0(a5) # 7000 <_stdout+0x170>
     92e:	cb19                	beqz	a4,944 <_skip_space+0x50>
        return (unsigned char)ctx->buf[ctx->pos++];
     930:	e814                	sd	a3,16(s0)
     932:	0007c783          	lbu	a5,0(a5)
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     936:	ff77871b          	addiw	a4,a5,-9
     93a:	fd278be3          	beq	a5,s2,910 <_skip_space+0x1c>
     93e:	fce9f9e3          	bgeu	s3,a4,910 <_skip_space+0x1c>
        ctx->ungotten = c;
     942:	cc1c                	sw	a5,24(s0)
}
     944:	70e2                	ld	ra,56(sp)
     946:	7442                	ld	s0,48(sp)
     948:	74a2                	ld	s1,40(sp)
     94a:	7902                	ld	s2,32(sp)
     94c:	69e2                	ld	s3,24(sp)
     94e:	6a42                	ld	s4,16(sp)
     950:	6121                	addi	sp,sp,64
     952:	8082                	ret
        ctx->ungotten = -1;
     954:	cc04                	sw	s1,24(s0)
        return c;
     956:	b7c5                	j	936 <_skip_space+0x42>
    if (read(ctx->fd, &c, 1) == 1)
     958:	f88ff0ef          	jal	e0 <read>
     95c:	4785                	li	a5,1
     95e:	fef513e3          	bne	a0,a5,944 <_skip_space+0x50>
        return (unsigned char)c;
     962:	00f14783          	lbu	a5,15(sp)
     966:	bfc1                	j	936 <_skip_space+0x42>

0000000000000968 <_vscanf_core.constprop.0>:
static int _vscanf_core(_InContext *ctx, const char *format, va_list ap)
     968:	7155                	addi	sp,sp,-208
     96a:	e586                	sd	ra,200(sp)
     96c:	e95a                	sd	s6,144(sp)
    while (*p)
     96e:	0005c783          	lbu	a5,0(a1)
static int _vscanf_core(_InContext *ctx, const char *format, va_list ap)
     972:	e432                	sd	a2,8(sp)
    while (*p)
     974:	68078b63          	beqz	a5,100a <_vscanf_core.constprop.0+0x6a2>
     978:	e1a2                	sd	s0,192(sp)
     97a:	fd26                	sd	s1,184(sp)
     97c:	f152                	sd	s4,160(sp)
     97e:	ed56                	sd	s5,152(sp)
     980:	f4ee                	sd	s11,104(sp)
     982:	842e                	mv	s0,a1
     984:	8daa                	mv	s11,a0
    int assigned = 0;
     986:	4b01                	li	s6,0
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     988:	02000493          	li	s1,32
     98c:	4a91                	li	s5,4
        if (*p != '%')
     98e:	02500a13          	li	s4,37
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     992:	04978763          	beq	a5,s1,9e0 <_vscanf_core.constprop.0+0x78>
     996:	ff77869b          	addiw	a3,a5,-9
     99a:	0ff6f693          	zext.b	a3,a3
     99e:	04daf163          	bgeu	s5,a3,9e0 <_vscanf_core.constprop.0+0x78>
        if (*p != '%')
     9a2:	07478d63          	beq	a5,s4,a1c <_vscanf_core.constprop.0+0xb4>
            _skip_space(ctx);
     9a6:	856e                	mv	a0,s11
     9a8:	f4dff0ef          	jal	8f4 <_skip_space>
    if (ctx->ungotten >= 0)
     9ac:	018da503          	lw	a0,24(s11)
     9b0:	04055a63          	bgez	a0,a04 <_vscanf_core.constprop.0+0x9c>
     9b4:	856e                	mv	a0,s11
     9b6:	ef9ff0ef          	jal	8ae <_in_char.part.0>
            if (c != *p)
     9ba:	00044783          	lbu	a5,0(s0)
     9be:	04a78a63          	beq	a5,a0,a12 <_vscanf_core.constprop.0+0xaa>
    if (c != -1)
     9c2:	57fd                	li	a5,-1
     9c4:	00f50463          	beq	a0,a5,9cc <_vscanf_core.constprop.0+0x64>
        ctx->ungotten = c;
     9c8:	00adac23          	sw	a0,24(s11)
     9cc:	640e                	ld	s0,192(sp)
     9ce:	74ea                	ld	s1,184(sp)
     9d0:	7a0a                	ld	s4,160(sp)
     9d2:	6aea                	ld	s5,152(sp)
     9d4:	7da6                	ld	s11,104(sp)
}
     9d6:	60ae                	ld	ra,200(sp)
     9d8:	855a                	mv	a0,s6
     9da:	6b4a                	ld	s6,144(sp)
     9dc:	6169                	addi	sp,sp,208
     9de:	8082                	ret
            _skip_space(ctx);
     9e0:	856e                	mv	a0,s11
     9e2:	f13ff0ef          	jal	8f4 <_skip_space>
            while (isspace(*p))
     9e6:	00044783          	lbu	a5,0(s0)
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     9ea:	4611                	li	a2,4
     9ec:	ff77869b          	addiw	a3,a5,-9
     9f0:	0ff6f693          	zext.b	a3,a3
     9f4:	00978663          	beq	a5,s1,a00 <_vscanf_core.constprop.0+0x98>
     9f8:	00d67463          	bgeu	a2,a3,a00 <_vscanf_core.constprop.0+0x98>
    while (*p)
     9fc:	fbd9                	bnez	a5,992 <_vscanf_core.constprop.0+0x2a>
     9fe:	b7f9                	j	9cc <_vscanf_core.constprop.0+0x64>
                p++;
     a00:	0405                	addi	s0,s0,1
     a02:	b7d5                	j	9e6 <_vscanf_core.constprop.0+0x7e>
        ctx->ungotten = -1;
     a04:	57fd                	li	a5,-1
     a06:	00fdac23          	sw	a5,24(s11)
            if (c != *p)
     a0a:	00044783          	lbu	a5,0(s0)
     a0e:	faa79ae3          	bne	a5,a0,9c2 <_vscanf_core.constprop.0+0x5a>
    while (*p)
     a12:	00144783          	lbu	a5,1(s0)
            p++;
     a16:	0405                	addi	s0,s0,1
    while (*p)
     a18:	ffad                	bnez	a5,992 <_vscanf_core.constprop.0+0x2a>
     a1a:	bf4d                	j	9cc <_vscanf_core.constprop.0+0x64>
     a1c:	f94a                	sd	s2,176(sp)
     a1e:	f54e                	sd	s3,168(sp)
     a20:	e55e                	sd	s7,136(sp)
     a22:	e162                	sd	s8,128(sp)
        if (*p == '*')
     a24:	00144583          	lbu	a1,1(s0)
     a28:	02a00793          	li	a5,42
     a2c:	22f58d63          	beq	a1,a5,c66 <_vscanf_core.constprop.0+0x2fe>
        p++;
     a30:	0405                	addi	s0,s0,1
        int suppress = 0;
     a32:	4981                	li	s3,0
        while (*p >= '0' && *p <= '9')
     a34:	fd05861b          	addiw	a2,a1,-48
     a38:	0ff67693          	zext.b	a3,a2
     a3c:	47a5                	li	a5,9
     a3e:	36d7e763          	bltu	a5,a3,dac <_vscanf_core.constprop.0+0x444>
     a42:	4781                	li	a5,0
     a44:	4825                	li	a6,9
     a46:	a019                	j	a4c <_vscanf_core.constprop.0+0xe4>
            width = width * 10 + (*p - '0');
     a48:	0016979b          	slliw	a5,a3,0x1
        while (*p >= '0' && *p <= '9')
     a4c:	00144583          	lbu	a1,1(s0)
            width = width * 10 + (*p - '0');
     a50:	00f6093b          	addw	s2,a2,a5
     a54:	0029169b          	slliw	a3,s2,0x2
        while (*p >= '0' && *p <= '9')
     a58:	fd05861b          	addiw	a2,a1,-48
     a5c:	0ff67513          	zext.b	a0,a2
            width = width * 10 + (*p - '0');
     a60:	012686bb          	addw	a3,a3,s2
            p++;
     a64:	0405                	addi	s0,s0,1
        while (*p >= '0' && *p <= '9')
     a66:	fea871e3          	bgeu	a6,a0,a48 <_vscanf_core.constprop.0+0xe0>
        if (*p == 'l')
     a6a:	06c00693          	li	a3,108
            p++;
     a6e:	00140b93          	addi	s7,s0,1
        if (*p == 'l')
     a72:	1ed58f63          	beq	a1,a3,c70 <_vscanf_core.constprop.0+0x308>
        else if (*p == 'h')
     a76:	06800693          	li	a3,104
     a7a:	2ad58863          	beq	a1,a3,d2a <_vscanf_core.constprop.0+0x3c2>
        char spec = *p++;
     a7e:	00044c03          	lbu	s8,0(s0)
     a82:	8ba2                	mv	s7,s0
        int len_mod = 0;
     a84:	ec02                	sd	zero,24(sp)
        char spec = *p++;
     a86:	06300693          	li	a3,99
     a8a:	001b8413          	addi	s0,s7,1
        if (!spec)
     a8e:	2adc0863          	beq	s8,a3,d3e <_vscanf_core.constprop.0+0x3d6>
     a92:	1f86fc63          	bgeu	a3,s8,c8a <_vscanf_core.constprop.0+0x322>
     a96:	f9cc069b          	addiw	a3,s8,-100
     a9a:	0ff6f693          	zext.b	a3,a3
     a9e:	4651                	li	a2,20
     aa0:	0cd66e63          	bltu	a2,a3,b7c <_vscanf_core.constprop.0+0x214>
     aa4:	00120637          	lui	a2,0x120
     aa8:	4585                	li	a1,1
     aaa:	00d595b3          	sll	a1,a1,a3
     aae:	02160613          	addi	a2,a2,33 # 120021 <_ZSt4cerr+0x1187b9>
     ab2:	8e6d                	and	a2,a2,a1
     ab4:	ee69                	bnez	a2,b8e <_vscanf_core.constprop.0+0x226>
     ab6:	89b9                	andi	a1,a1,14
     ab8:	1e059263          	bnez	a1,c9c <_vscanf_core.constprop.0+0x334>
     abc:	463d                	li	a2,15
     abe:	0ac69f63          	bne	a3,a2,b7c <_vscanf_core.constprop.0+0x214>
            _skip_space(ctx);
     ac2:	856e                	mv	a0,s11
     ac4:	e31ff0ef          	jal	8f4 <_skip_space>
            char *buf = suppress ? NULL : va_arg(ap, char *);
     ac8:	ec02                	sd	zero,24(sp)
     aca:	00099763          	bnez	s3,ad8 <_vscanf_core.constprop.0+0x170>
     ace:	67a2                	ld	a5,8(sp)
     ad0:	6398                	ld	a4,0(a5)
     ad2:	07a1                	addi	a5,a5,8
     ad4:	e43e                	sd	a5,8(sp)
     ad6:	ec3a                	sd	a4,24(sp)
    if (ctx->ungotten >= 0)
     ad8:	018da503          	lw	a0,24(s11)
     adc:	2e055b63          	bgez	a0,dd2 <_vscanf_core.constprop.0+0x46a>
     ae0:	856e                	mv	a0,s11
     ae2:	dcdff0ef          	jal	8ae <_in_char.part.0>
            while (c != -1 && !isspace(c))
     ae6:	56fd                	li	a3,-1
     ae8:	6ad50363          	beq	a0,a3,118e <_vscanf_core.constprop.0+0x826>
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     aec:	02000693          	li	a3,32
     af0:	3ed50963          	beq	a0,a3,ee2 <_vscanf_core.constprop.0+0x57a>
     af4:	46a5                	li	a3,9
     af6:	3ed50663          	beq	a0,a3,ee2 <_vscanf_core.constprop.0+0x57a>
     afa:	46a9                	li	a3,10
     afc:	3ed50363          	beq	a0,a3,ee2 <_vscanf_core.constprop.0+0x57a>
     b00:	46ad                	li	a3,11
     b02:	3ed50063          	beq	a0,a3,ee2 <_vscanf_core.constprop.0+0x57a>
     b06:	46b1                	li	a3,12
     b08:	3cd50d63          	beq	a0,a3,ee2 <_vscanf_core.constprop.0+0x57a>
     b0c:	46b5                	li	a3,13
     b0e:	3cd50a63          	beq	a0,a3,ee2 <_vscanf_core.constprop.0+0x57a>
     b12:	67e2                	ld	a5,24(sp)
     b14:	fce6                	sd	s9,120(sp)
     b16:	f8ea                	sd	s10,112(sp)
     b18:	e83e                	sd	a5,16(sp)
     b1a:	4d01                	li	s10,0
            while (c != -1 && !isspace(c))
     b1c:	5c7d                	li	s8,-1
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     b1e:	02000c93          	li	s9,32
                if (width > 0 && i >= width)
     b22:	01205463          	blez	s2,b2a <_vscanf_core.constprop.0+0x1c2>
     b26:	052d5563          	bge	s10,s2,b70 <_vscanf_core.constprop.0+0x208>
                if (!suppress)
     b2a:	00099563          	bnez	s3,b34 <_vscanf_core.constprop.0+0x1cc>
                    buf[i] = (char)c;
     b2e:	67c2                	ld	a5,16(sp)
     b30:	00a78023          	sb	a0,0(a5)
    if (ctx->ungotten >= 0)
     b34:	018da503          	lw	a0,24(s11)
                i++;
     b38:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
     b3a:	30055963          	bgez	a0,e4c <_vscanf_core.constprop.0+0x4e4>
     b3e:	856e                	mv	a0,s11
     b40:	d6fff0ef          	jal	8ae <_in_char.part.0>
            while (c != -1 && !isspace(c))
     b44:	27850663          	beq	a0,s8,db0 <_vscanf_core.constprop.0+0x448>
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     b48:	03950463          	beq	a0,s9,b70 <_vscanf_core.constprop.0+0x208>
     b4c:	47a5                	li	a5,9
     b4e:	02f50163          	beq	a0,a5,b70 <_vscanf_core.constprop.0+0x208>
     b52:	47a9                	li	a5,10
     b54:	00f50e63          	beq	a0,a5,b70 <_vscanf_core.constprop.0+0x208>
     b58:	47ad                	li	a5,11
     b5a:	00f50b63          	beq	a0,a5,b70 <_vscanf_core.constprop.0+0x208>
     b5e:	47b1                	li	a5,12
     b60:	00f50863          	beq	a0,a5,b70 <_vscanf_core.constprop.0+0x208>
     b64:	67c2                	ld	a5,16(sp)
     b66:	0785                	addi	a5,a5,1
     b68:	e83e                	sd	a5,16(sp)
     b6a:	47b5                	li	a5,13
     b6c:	faf51be3          	bne	a0,a5,b22 <_vscanf_core.constprop.0+0x1ba>
            if (!suppress)
     b70:	64098a63          	beqz	s3,11c4 <_vscanf_core.constprop.0+0x85c>
     b74:	7ce6                	ld	s9,120(sp)
     b76:	7d46                	ld	s10,112(sp)
        ctx->ungotten = c;
     b78:	00adac23          	sw	a0,24(s11)
    while (*p)
     b7c:	001bc783          	lbu	a5,1(s7)
     b80:	794a                	ld	s2,176(sp)
     b82:	79aa                	ld	s3,168(sp)
     b84:	6baa                	ld	s7,136(sp)
     b86:	6c0a                	ld	s8,128(sp)
     b88:	e00795e3          	bnez	a5,992 <_vscanf_core.constprop.0+0x2a>
     b8c:	b581                	j	9cc <_vscanf_core.constprop.0+0x64>
            _skip_space(ctx);
     b8e:	856e                	mv	a0,s11
     b90:	f8ea                	sd	s10,112(sp)
     b92:	d63ff0ef          	jal	8f4 <_skip_space>
    if (ctx->ungotten >= 0)
     b96:	018da503          	lw	a0,24(s11)
     b9a:	24055063          	bgez	a0,dda <_vscanf_core.constprop.0+0x472>
     b9e:	856e                	mv	a0,s11
     ba0:	d0fff0ef          	jal	8ae <_in_char.part.0>
            if (c == '-' || c == '+')
     ba4:	fd55069b          	addiw	a3,a0,-43
     ba8:	9af5                	andi	a3,a3,-3
     baa:	2681                	sext.w	a3,a3
            int i = 0, c = _in_char(ctx);
     bac:	4d01                	li	s10,0
            if (c == '-' || c == '+')
     bae:	3e068863          	beqz	a3,f9e <_vscanf_core.constprop.0+0x636>
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
     bb2:	07800693          	li	a3,120
     bb6:	4641                	li	a2,16
     bb8:	00dc0863          	beq	s8,a3,bc8 <_vscanf_core.constprop.0+0x260>
     bbc:	06900693          	li	a3,105
     bc0:	4629                	li	a2,10
     bc2:	00dc1363          	bne	s8,a3,bc8 <_vscanf_core.constprop.0+0x260>
     bc6:	4601                	li	a2,0
            while (c != -1 && i < 63)
     bc8:	56fd                	li	a3,-1
     bca:	5cd50863          	beq	a0,a3,119a <_vscanf_core.constprop.0+0x832>
     bce:	fce6                	sd	s9,120(sp)
     bd0:	02010893          	addi	a7,sp,32
     bd4:	01a88c33          	add	s8,a7,s10
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     bd8:	4cc1                	li	s9,16
                int digit = (c >= '0' && c <= '9');
     bda:	fd05069b          	addiw	a3,a0,-48
     bde:	0005031b          	sext.w	t1,a0
     be2:	00a6b593          	sltiu	a1,a3,10
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     be6:	27960a63          	beq	a2,s9,e5a <_vscanf_core.constprop.0+0x4f2>
     bea:	2a060d63          	beqz	a2,ea4 <_vscanf_core.constprop.0+0x53c>
                int x = (c == 'x' || c == 'X');
     bee:	07800793          	li	a5,120
     bf2:	2ef50363          	beq	a0,a5,ed8 <_vscanf_core.constprop.0+0x570>
     bf6:	fa850693          	addi	a3,a0,-88
     bfa:	0016b693          	seqz	a3,a3
     bfe:	4301                	li	t1,0
                if (width > 0 && i >= width)
     c00:	01205463          	blez	s2,c08 <_vscanf_core.constprop.0+0x2a0>
     c04:	032d5a63          	bge	s10,s2,c38 <_vscanf_core.constprop.0+0x2d0>
                if (digit || hex || x)
     c08:	0066e6b3          	or	a3,a3,t1
     c0c:	8ecd                	or	a3,a3,a1
     c0e:	c68d                	beqz	a3,c38 <_vscanf_core.constprop.0+0x2d0>
                    num_buf[i++] = (char)c;
     c10:	00ac0023          	sb	a0,0(s8)
    if (ctx->ungotten >= 0)
     c14:	018da503          	lw	a0,24(s11)
                    num_buf[i++] = (char)c;
     c18:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
     c1a:	22055c63          	bgez	a0,e52 <_vscanf_core.constprop.0+0x4ea>
     c1e:	856e                	mv	a0,s11
     c20:	e832                	sd	a2,16(sp)
     c22:	c8dff0ef          	jal	8ae <_in_char.part.0>
            while (c != -1 && i < 63)
     c26:	57fd                	li	a5,-1
     c28:	6642                	ld	a2,16(sp)
     c2a:	3cf50263          	beq	a0,a5,fee <_vscanf_core.constprop.0+0x686>
     c2e:	03f00693          	li	a3,63
     c32:	0c05                	addi	s8,s8,1
     c34:	fadd13e3          	bne	s10,a3,bda <_vscanf_core.constprop.0+0x272>
            num_buf[i] = '\0';
     c38:	040d0793          	addi	a5,s10,64
     c3c:	1018                	addi	a4,sp,32
     c3e:	97ba                	add	a5,a5,a4
     c40:	fc078023          	sb	zero,-64(a5)
        ctx->ungotten = c;
     c44:	00adac23          	sw	a0,24(s11)
     c48:	7ce6                	ld	s9,120(sp)
            if (i == 0)
     c4a:	1e0d0663          	beqz	s10,e36 <_vscanf_core.constprop.0+0x4ce>
            if (!suppress)
     c4e:	36098363          	beqz	s3,fb4 <_vscanf_core.constprop.0+0x64c>
    while (*p)
     c52:	001bc783          	lbu	a5,1(s7)
        {
     c56:	794a                	ld	s2,176(sp)
     c58:	79aa                	ld	s3,168(sp)
     c5a:	6baa                	ld	s7,136(sp)
     c5c:	6c0a                	ld	s8,128(sp)
     c5e:	7d46                	ld	s10,112(sp)
    while (*p)
     c60:	d20799e3          	bnez	a5,992 <_vscanf_core.constprop.0+0x2a>
     c64:	b3a5                	j	9cc <_vscanf_core.constprop.0+0x64>
        while (*p >= '0' && *p <= '9')
     c66:	00244583          	lbu	a1,2(s0)
            suppress = 1;
     c6a:	4985                	li	s3,1
            p++;
     c6c:	0409                	addi	s0,s0,2
     c6e:	b3d9                	j	a34 <_vscanf_core.constprop.0+0xcc>
            if (*p == 'l')
     c70:	00144c03          	lbu	s8,1(s0)
            len_mod = 1;
     c74:	4785                	li	a5,1
     c76:	ec3e                	sd	a5,24(sp)
            if (*p == 'l')
     c78:	e0bc17e3          	bne	s8,a1,a86 <_vscanf_core.constprop.0+0x11e>
                len_mod = 2;
     c7c:	4789                	li	a5,2
        char spec = *p++;
     c7e:	00244c03          	lbu	s8,2(s0)
                p++;
     c82:	00240b93          	addi	s7,s0,2
                len_mod = 2;
     c86:	ec3e                	sd	a5,24(sp)
     c88:	bbfd                	j	a86 <_vscanf_core.constprop.0+0x11e>
     c8a:	100c0763          	beqz	s8,d98 <_vscanf_core.constprop.0+0x430>
     c8e:	fbbc079b          	addiw	a5,s8,-69
     c92:	0ff7f793          	zext.b	a5,a5
     c96:	4689                	li	a3,2
     c98:	eef6e2e3          	bltu	a3,a5,b7c <_vscanf_core.constprop.0+0x214>
            _skip_space(ctx);
     c9c:	856e                	mv	a0,s11
     c9e:	f8ea                	sd	s10,112(sp)
     ca0:	c55ff0ef          	jal	8f4 <_skip_space>
    if (ctx->ungotten >= 0)
     ca4:	018da783          	lw	a5,24(s11)
     ca8:	1207dd63          	bgez	a5,de2 <_vscanf_core.constprop.0+0x47a>
     cac:	856e                	mv	a0,s11
     cae:	c01ff0ef          	jal	8ae <_in_char.part.0>
            if (c == '-' || c == '+')
     cb2:	fd55069b          	addiw	a3,a0,-43
     cb6:	ffd6f613          	andi	a2,a3,-3
     cba:	2601                	sext.w	a2,a2
     cbc:	87aa                	mv	a5,a0
     cbe:	12060c63          	beqz	a2,df6 <_vscanf_core.constprop.0+0x48e>
            while (c != -1 && i < 63)
     cc2:	567d                	li	a2,-1
     cc4:	16c50963          	beq	a0,a2,e36 <_vscanf_core.constprop.0+0x4ce>
     cc8:	fce6                	sd	s9,120(sp)
            int i = 0, c = _in_char(ctx);
     cca:	4d01                	li	s10,0
     ccc:	80000937          	lui	s2,0x80000
     cd0:	197d                	addi	s2,s2,-1 # ffffffff7fffffff <_ZSt4cerr+0xffffffff7fff8797>
     cd2:	0932                	slli	s2,s2,0xc
     cd4:	80194913          	xori	s2,s2,-2047
     cd8:	093e                	slli	s2,s2,0xf
     cda:	02010813          	addi	a6,sp,32
     cde:	01a80cb3          	add	s9,a6,s10
     ce2:	03a00c13          	li	s8,58
     ce6:	1935                	addi	s2,s2,-19
     ce8:	a831                	j	d04 <_vscanf_core.constprop.0+0x39c>
     cea:	bc5ff0ef          	jal	8ae <_in_char.part.0>
            while (c != -1 && i < 63)
     cee:	577d                	li	a4,-1
     cf0:	87aa                	mv	a5,a0
     cf2:	2ee50563          	beq	a0,a4,fdc <_vscanf_core.constprop.0+0x674>
     cf6:	03f00713          	li	a4,63
     cfa:	0c85                	addi	s9,s9,1
     cfc:	1eed0e63          	beq	s10,a4,ef8 <_vscanf_core.constprop.0+0x590>
     d00:	fd57869b          	addiw	a3,a5,-43
        int c = ctx->ungotten;
     d04:	00d95633          	srl	a2,s2,a3
     d08:	856e                	mv	a0,s11
     d0a:	8a05                	andi	a2,a2,1
     d0c:	1edc6663          	bltu	s8,a3,ef8 <_vscanf_core.constprop.0+0x590>
     d10:	1e060463          	beqz	a2,ef8 <_vscanf_core.constprop.0+0x590>
                    num_buf[i++] = (char)c;
     d14:	00fc8023          	sb	a5,0(s9)
    if (ctx->ungotten >= 0)
     d18:	018da783          	lw	a5,24(s11)
                    num_buf[i++] = (char)c;
     d1c:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
     d1e:	fc07c6e3          	bltz	a5,cea <_vscanf_core.constprop.0+0x382>
        ctx->ungotten = -1;
     d22:	577d                	li	a4,-1
     d24:	00edac23          	sw	a4,24(s11)
            while (c != -1 && i < 63)
     d28:	b7f9                	j	cf6 <_vscanf_core.constprop.0+0x38e>
            if (*p == 'h')
     d2a:	00144c03          	lbu	s8,1(s0)
        int len_mod = 0;
     d2e:	ec02                	sd	zero,24(sp)
            if (*p == 'h')
     d30:	d4bc1be3          	bne	s8,a1,a86 <_vscanf_core.constprop.0+0x11e>
        char spec = *p++;
     d34:	00244c03          	lbu	s8,2(s0)
                p++;
     d38:	00240b93          	addi	s7,s0,2
     d3c:	b3a9                	j	a86 <_vscanf_core.constprop.0+0x11e>
     d3e:	fce6                	sd	s9,120(sp)
     d40:	f8ea                	sd	s10,112(sp)
            int count = (width > 0) ? width : 1;
     d42:	00090c1b          	sext.w	s8,s2
     d46:	0d205a63          	blez	s2,e1a <_vscanf_core.constprop.0+0x4b2>
            char *buf = suppress ? NULL : va_arg(ap, char *);
     d4a:	4d01                	li	s10,0
     d4c:	06098d63          	beqz	s3,dc6 <_vscanf_core.constprop.0+0x45e>
            for (int i = 0; i < count; i++)
     d50:	9c6a                	add	s8,s8,s10
                if (c == -1)
     d52:	5cfd                	li	s9,-1
    if (ctx->ungotten >= 0)
     d54:	018da783          	lw	a5,24(s11)
        ctx->ungotten = -1;
     d58:	856e                	mv	a0,s11
    if (ctx->ungotten >= 0)
     d5a:	0207dc63          	bgez	a5,d92 <_vscanf_core.constprop.0+0x42a>
     d5e:	b51ff0ef          	jal	8ae <_in_char.part.0>
     d62:	87aa                	mv	a5,a0
                if (c == -1)
     d64:	0b950d63          	beq	a0,s9,e1e <_vscanf_core.constprop.0+0x4b6>
                if (!suppress)
     d68:	00099463          	bnez	s3,d70 <_vscanf_core.constprop.0+0x408>
                    buf[i] = (char)c;
     d6c:	00fd0023          	sb	a5,0(s10)
            for (int i = 0; i < count; i++)
     d70:	0d05                	addi	s10,s10,1
     d72:	ffac11e3          	bne	s8,s10,d54 <_vscanf_core.constprop.0+0x3ec>
    while (*p)
     d76:	001bc783          	lbu	a5,1(s7)
            if (!suppress)
     d7a:	00099363          	bnez	s3,d80 <_vscanf_core.constprop.0+0x418>
                assigned++;
     d7e:	2b05                	addiw	s6,s6,1
     d80:	794a                	ld	s2,176(sp)
     d82:	79aa                	ld	s3,168(sp)
     d84:	6baa                	ld	s7,136(sp)
     d86:	6c0a                	ld	s8,128(sp)
     d88:	7ce6                	ld	s9,120(sp)
     d8a:	7d46                	ld	s10,112(sp)
    while (*p)
     d8c:	c00793e3          	bnez	a5,992 <_vscanf_core.constprop.0+0x2a>
     d90:	b935                	j	9cc <_vscanf_core.constprop.0+0x64>
        ctx->ungotten = -1;
     d92:	019dac23          	sw	s9,24(s11)
                if (c == -1)
     d96:	bfc9                	j	d68 <_vscanf_core.constprop.0+0x400>
     d98:	640e                	ld	s0,192(sp)
     d9a:	74ea                	ld	s1,184(sp)
     d9c:	794a                	ld	s2,176(sp)
     d9e:	79aa                	ld	s3,168(sp)
     da0:	7a0a                	ld	s4,160(sp)
     da2:	6aea                	ld	s5,152(sp)
     da4:	6baa                	ld	s7,136(sp)
     da6:	6c0a                	ld	s8,128(sp)
     da8:	7da6                	ld	s11,104(sp)
     daa:	b135                	j	9d6 <_vscanf_core.constprop.0+0x6e>
        int width = -1;
     dac:	597d                	li	s2,-1
     dae:	b975                	j	a6a <_vscanf_core.constprop.0+0x102>
            if (!suppress)
     db0:	3c099c63          	bnez	s3,1188 <_vscanf_core.constprop.0+0x820>
                buf[i] = '\0';
     db4:	67e2                	ld	a5,24(sp)
     db6:	01a786b3          	add	a3,a5,s10
     dba:	00068023          	sb	zero,0(a3)
    while (*p)
     dbe:	001bc783          	lbu	a5,1(s7)
                assigned++;
     dc2:	2b05                	addiw	s6,s6,1
     dc4:	bf75                	j	d80 <_vscanf_core.constprop.0+0x418>
            char *buf = suppress ? NULL : va_arg(ap, char *);
     dc6:	67a2                	ld	a5,8(sp)
     dc8:	0007bd03          	ld	s10,0(a5)
     dcc:	07a1                	addi	a5,a5,8
     dce:	e43e                	sd	a5,8(sp)
     dd0:	b741                	j	d50 <_vscanf_core.constprop.0+0x3e8>
        ctx->ungotten = -1;
     dd2:	56fd                	li	a3,-1
     dd4:	00ddac23          	sw	a3,24(s11)
            while (c != -1 && !isspace(c))
     dd8:	bb11                	j	aec <_vscanf_core.constprop.0+0x184>
        ctx->ungotten = -1;
     dda:	56fd                	li	a3,-1
     ddc:	00ddac23          	sw	a3,24(s11)
        return c;
     de0:	b3d1                	j	ba4 <_vscanf_core.constprop.0+0x23c>
            if (c == '-' || c == '+')
     de2:	fd57869b          	addiw	a3,a5,-43
     de6:	ffd6f613          	andi	a2,a3,-3
        ctx->ungotten = -1;
     dea:	55fd                	li	a1,-1
     dec:	00bdac23          	sw	a1,24(s11)
            if (c == '-' || c == '+')
     df0:	2601                	sext.w	a2,a2
     df2:	ec061be3          	bnez	a2,cc8 <_vscanf_core.constprop.0+0x360>
                num_buf[i++] = (char)c;
     df6:	02f10023          	sb	a5,32(sp)
    if (ctx->ungotten >= 0)
     dfa:	018da783          	lw	a5,24(s11)
     dfe:	2207da63          	bgez	a5,1032 <_vscanf_core.constprop.0+0x6ca>
     e02:	856e                	mv	a0,s11
     e04:	aabff0ef          	jal	8ae <_in_char.part.0>
            while (c != -1 && i < 63)
     e08:	567d                	li	a2,-1
     e0a:	87aa                	mv	a5,a0
                num_buf[i++] = (char)c;
     e0c:	4d05                	li	s10,1
     e0e:	fd55069b          	addiw	a3,a0,-43
            while (c != -1 && i < 63)
     e12:	3ac50163          	beq	a0,a2,11b4 <_vscanf_core.constprop.0+0x84c>
     e16:	fce6                	sd	s9,120(sp)
     e18:	bd55                	j	ccc <_vscanf_core.constprop.0+0x364>
            int count = (width > 0) ? width : 1;
     e1a:	4c05                	li	s8,1
     e1c:	b73d                	j	d4a <_vscanf_core.constprop.0+0x3e2>
     e1e:	640e                	ld	s0,192(sp)
     e20:	74ea                	ld	s1,184(sp)
     e22:	794a                	ld	s2,176(sp)
     e24:	79aa                	ld	s3,168(sp)
     e26:	7a0a                	ld	s4,160(sp)
     e28:	6aea                	ld	s5,152(sp)
     e2a:	6baa                	ld	s7,136(sp)
     e2c:	6c0a                	ld	s8,128(sp)
     e2e:	7ce6                	ld	s9,120(sp)
     e30:	7d46                	ld	s10,112(sp)
     e32:	7da6                	ld	s11,104(sp)
     e34:	b64d                	j	9d6 <_vscanf_core.constprop.0+0x6e>
     e36:	640e                	ld	s0,192(sp)
     e38:	74ea                	ld	s1,184(sp)
     e3a:	794a                	ld	s2,176(sp)
     e3c:	79aa                	ld	s3,168(sp)
     e3e:	7a0a                	ld	s4,160(sp)
     e40:	6aea                	ld	s5,152(sp)
     e42:	6baa                	ld	s7,136(sp)
     e44:	6c0a                	ld	s8,128(sp)
     e46:	7d46                	ld	s10,112(sp)
     e48:	7da6                	ld	s11,104(sp)
     e4a:	b671                	j	9d6 <_vscanf_core.constprop.0+0x6e>
        ctx->ungotten = -1;
     e4c:	018dac23          	sw	s8,24(s11)
            while (c != -1 && !isspace(c))
     e50:	b9e5                	j	b48 <_vscanf_core.constprop.0+0x1e0>
        ctx->ungotten = -1;
     e52:	57fd                	li	a5,-1
     e54:	00fdac23          	sw	a5,24(s11)
            while (c != -1 && i < 63)
     e58:	bbd9                	j	c2e <_vscanf_core.constprop.0+0x2c6>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     e5a:	f9f3069b          	addiw	a3,t1,-97
     e5e:	4795                	li	a5,5
     e60:	06d7f263          	bgeu	a5,a3,ec4 <_vscanf_core.constprop.0+0x55c>
     e64:	fbf3031b          	addiw	t1,t1,-65
     e68:	4795                	li	a5,5
     e6a:	0467fd63          	bgeu	a5,t1,ec4 <_vscanf_core.constprop.0+0x55c>
                int x = (c == 'x' || c == 'X');
     e6e:	07800693          	li	a3,120
     e72:	18d50763          	beq	a0,a3,1000 <_vscanf_core.constprop.0+0x698>
     e76:	fa850693          	addi	a3,a0,-88
     e7a:	0016b693          	seqz	a3,a3
                if (base == 0 && i == 1 && num_buf[0] == '0' && x)
     e7e:	4301                	li	t1,0
     e80:	32061663          	bnez	a2,11ac <_vscanf_core.constprop.0+0x844>
     e84:	4785                	li	a5,1
     e86:	4601                	li	a2,0
     e88:	d6fd1ce3          	bne	s10,a5,c00 <_vscanf_core.constprop.0+0x298>
     e8c:	02014e03          	lbu	t3,32(sp)
     e90:	03000793          	li	a5,48
     e94:	d6fe16e3          	bne	t3,a5,c00 <_vscanf_core.constprop.0+0x298>
     e98:	d60684e3          	beqz	a3,c00 <_vscanf_core.constprop.0+0x298>
                    base = 16;
     e9c:	4641                	li	a2,16
                if (width > 0 && i >= width)
     e9e:	d7a919e3          	bne	s2,s10,c10 <_vscanf_core.constprop.0+0x2a8>
     ea2:	bb59                	j	c38 <_vscanf_core.constprop.0+0x2d0>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     ea4:	f9f3069b          	addiw	a3,t1,-97
     ea8:	4795                	li	a5,5
     eaa:	02d7f263          	bgeu	a5,a3,ece <_vscanf_core.constprop.0+0x566>
     eae:	fbf3031b          	addiw	t1,t1,-65
     eb2:	0467f063          	bgeu	a5,t1,ef2 <_vscanf_core.constprop.0+0x58a>
                int x = (c == 'x' || c == 'X');
     eb6:	07800693          	li	a3,120
     eba:	fad51ee3          	bne	a0,a3,e76 <_vscanf_core.constprop.0+0x50e>
     ebe:	4301                	li	t1,0
     ec0:	4685                	li	a3,1
     ec2:	b7c9                	j	e84 <_vscanf_core.constprop.0+0x51c>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     ec4:	4305                	li	t1,1
                int x = (c == 'x' || c == 'X');
     ec6:	4681                	li	a3,0
                if (width > 0 && i >= width)
     ec8:	d3204ee3          	bgtz	s2,c04 <_vscanf_core.constprop.0+0x29c>
     ecc:	bb35                	j	c08 <_vscanf_core.constprop.0+0x2a0>
                int x = (c == 'x' || c == 'X');
     ece:	4681                	li	a3,0
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     ed0:	4305                	li	t1,1
                if (width > 0 && i >= width)
     ed2:	d32049e3          	bgtz	s2,c04 <_vscanf_core.constprop.0+0x29c>
     ed6:	bb0d                	j	c08 <_vscanf_core.constprop.0+0x2a0>
     ed8:	4301                	li	t1,0
                int x = (c == 'x' || c == 'X');
     eda:	4685                	li	a3,1
                if (width > 0 && i >= width)
     edc:	d32044e3          	bgtz	s2,c04 <_vscanf_core.constprop.0+0x29c>
     ee0:	bb05                	j	c10 <_vscanf_core.constprop.0+0x2a8>
            if (!suppress)
     ee2:	c8099be3          	bnez	s3,b78 <_vscanf_core.constprop.0+0x210>
                buf[i] = '\0';
     ee6:	67e2                	ld	a5,24(sp)
     ee8:	00078023          	sb	zero,0(a5)
        ctx->ungotten = c;
     eec:	00adac23          	sw	a0,24(s11)
            if (i > 0 && !suppress)
     ef0:	b171                	j	b7c <_vscanf_core.constprop.0+0x214>
                int x = (c == 'x' || c == 'X');
     ef2:	4681                	li	a3,0
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     ef4:	4305                	li	t1,1
     ef6:	b779                	j	e84 <_vscanf_core.constprop.0+0x51c>
            num_buf[i] = '\0';
     ef8:	040d0713          	addi	a4,s10,64
     efc:	1014                	addi	a3,sp,32
     efe:	96ba                	add	a3,a3,a4
     f00:	fc068023          	sb	zero,-64(a3)
        ctx->ungotten = c;
     f04:	00fdac23          	sw	a5,24(s11)
            if (i == 0)
     f08:	f00d0be3          	beqz	s10,e1e <_vscanf_core.constprop.0+0x4b6>
     f0c:	7ce6                	ld	s9,120(sp)
            if (!suppress)
     f0e:	d40992e3          	bnez	s3,c52 <_vscanf_core.constprop.0+0x2ea>
    if (*str == '-')
     f12:	02014603          	lbu	a2,32(sp)
     f16:	02d00793          	li	a5,45
     f1a:	1af60963          	beq	a2,a5,10cc <_vscanf_core.constprop.0+0x764>
    else if (*str == '+')
     f1e:	02b00793          	li	a5,43
     f22:	20f60a63          	beq	a2,a5,1136 <_vscanf_core.constprop.0+0x7ce>
     f26:	00005797          	auipc	a5,0x5
     f2a:	9227b587          	fld	fa1,-1758(a5) # 5848 <STDIN_FD+0x10>
     f2e:	101c                	addi	a5,sp,32
    while (*str >= '0' && *str <= '9')
     f30:	fd06069b          	addiw	a3,a2,-48
     f34:	0ff6f513          	zext.b	a0,a3
     f38:	45a5                	li	a1,9
     f3a:	f20007d3          	fmv.d.x	fa5,zero
     f3e:	02a5e463          	bltu	a1,a0,f66 <_vscanf_core.constprop.0+0x5fe>
     f42:	00005717          	auipc	a4,0x5
     f46:	90e73707          	fld	fa4,-1778(a4) # 5850 <STDIN_FD+0x18>
     f4a:	4525                	li	a0,9
     f4c:	0017c603          	lbu	a2,1(a5)
        val = val * 10.0 + (*str - '0');
     f50:	d20686d3          	fcvt.d.w	fa3,a3
        str++;
     f54:	0785                	addi	a5,a5,1
    while (*str >= '0' && *str <= '9')
     f56:	fd06069b          	addiw	a3,a2,-48
     f5a:	0ff6f593          	zext.b	a1,a3
        val = val * 10.0 + (*str - '0');
     f5e:	6ae7f7c3          	fmadd.d	fa5,fa5,fa4,fa3
    while (*str >= '0' && *str <= '9')
     f62:	feb575e3          	bgeu	a0,a1,f4c <_vscanf_core.constprop.0+0x5e4>
    if (*str == '.')
     f66:	02e00693          	li	a3,46
     f6a:	16d60a63          	beq	a2,a3,10de <_vscanf_core.constprop.0+0x776>
    if (*str == 'e' || *str == 'E')
     f6e:	0007c683          	lbu	a3,0(a5)
     f72:	0df6f693          	andi	a3,a3,223
     f76:	04500613          	li	a2,69
     f7a:	0cc68463          	beq	a3,a2,1042 <_vscanf_core.constprop.0+0x6da>
                    *va_arg(ap, double *) = val;
     f7e:	6722                	ld	a4,8(sp)
                if (len_mod == 1)
     f80:	4685                	li	a3,1
    return sign * val;
     f82:	12b7f7d3          	fmul.d	fa5,fa5,fa1
                    *va_arg(ap, double *) = val;
     f86:	631c                	ld	a5,0(a4)
                    *va_arg(ap, int64 *) = val;
     f88:	0721                	addi	a4,a4,8
     f8a:	e43a                	sd	a4,8(sp)
                if (len_mod == 1)
     f8c:	6762                	ld	a4,24(sp)
     f8e:	18d70b63          	beq	a4,a3,1124 <_vscanf_core.constprop.0+0x7bc>
                    *va_arg(ap, float *) = (float)val;
     f92:	4017f7d3          	fcvt.s.d	fa5,fa5
                assigned++;
     f96:	2b05                	addiw	s6,s6,1
                    *va_arg(ap, float *) = (float)val;
     f98:	00f7a027          	fsw	fa5,0(a5)
     f9c:	b95d                	j	c52 <_vscanf_core.constprop.0+0x2ea>
                num_buf[i++] = (char)c;
     f9e:	02a10023          	sb	a0,32(sp)
    if (ctx->ungotten >= 0)
     fa2:	018da503          	lw	a0,24(s11)
     fa6:	06055463          	bgez	a0,100e <_vscanf_core.constprop.0+0x6a6>
     faa:	856e                	mv	a0,s11
     fac:	903ff0ef          	jal	8ae <_in_char.part.0>
                num_buf[i++] = (char)c;
     fb0:	4d05                	li	s10,1
     fb2:	b101                	j	bb2 <_vscanf_core.constprop.0+0x24a>
                int64 val = strtoll(num_buf, NULL, base);
     fb4:	4581                	li	a1,0
     fb6:	1008                	addi	a0,sp,32
     fb8:	696030ef          	jal	464e <strtoll>
                    *va_arg(ap, int64 *) = val;
     fbc:	67a2                	ld	a5,8(sp)
                if (len_mod == 2)
     fbe:	6762                	ld	a4,24(sp)
     fc0:	4689                	li	a3,2
                    *va_arg(ap, int64 *) = val;
     fc2:	07a1                	addi	a5,a5,8
                if (len_mod == 2)
     fc4:	16d70363          	beq	a4,a3,112a <_vscanf_core.constprop.0+0x7c2>
                    *va_arg(ap, int64 *) = val;
     fc8:	6722                	ld	a4,8(sp)
                else if (len_mod == 1)
     fca:	4605                	li	a2,1
                    *va_arg(ap, int64 *) = val;
     fcc:	6314                	ld	a3,0(a4)
                else if (len_mod == 1)
     fce:	6762                	ld	a4,24(sp)
     fd0:	16c70163          	beq	a4,a2,1132 <_vscanf_core.constprop.0+0x7ca>
                    *va_arg(ap, int *) = (int)val;
     fd4:	c288                	sw	a0,0(a3)
                assigned++;
     fd6:	2b05                	addiw	s6,s6,1
     fd8:	e43e                	sd	a5,8(sp)
     fda:	b9a5                	j	c52 <_vscanf_core.constprop.0+0x2ea>
            num_buf[i] = '\0';
     fdc:	040d0793          	addi	a5,s10,64
     fe0:	1018                	addi	a4,sp,32
     fe2:	00e785b3          	add	a1,a5,a4
     fe6:	fc058023          	sb	zero,-64(a1)
            if (i == 0)
     fea:	7ce6                	ld	s9,120(sp)
     fec:	b70d                	j	f0e <_vscanf_core.constprop.0+0x5a6>
            num_buf[i] = '\0';
     fee:	040d0793          	addi	a5,s10,64
     ff2:	1018                	addi	a4,sp,32
     ff4:	00e78833          	add	a6,a5,a4
     ff8:	fc080023          	sb	zero,-64(a6)
            if (i == 0)
     ffc:	7ce6                	ld	s9,120(sp)
     ffe:	b981                	j	c4e <_vscanf_core.constprop.0+0x2e6>
                int x = (c == 'x' || c == 'X');
    1000:	4301                	li	t1,0
    1002:	4685                	li	a3,1
                if (width > 0 && i >= width)
    1004:	c12040e3          	bgtz	s2,c04 <_vscanf_core.constprop.0+0x29c>
    1008:	b101                	j	c08 <_vscanf_core.constprop.0+0x2a0>
    int assigned = 0;
    100a:	4b01                	li	s6,0
    100c:	b2e9                	j	9d6 <_vscanf_core.constprop.0+0x6e>
        ctx->ungotten = -1;
    100e:	56fd                	li	a3,-1
    1010:	fce6                	sd	s9,120(sp)
    1012:	00ddac23          	sw	a3,24(s11)
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
    1016:	07800693          	li	a3,120
    101a:	4641                	li	a2,16
                num_buf[i++] = (char)c;
    101c:	4d05                	li	s10,1
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
    101e:	badc09e3          	beq	s8,a3,bd0 <_vscanf_core.constprop.0+0x268>
    1022:	06900693          	li	a3,105
    1026:	4629                	li	a2,10
                num_buf[i++] = (char)c;
    1028:	4d05                	li	s10,1
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
    102a:	badc13e3          	bne	s8,a3,bd0 <_vscanf_core.constprop.0+0x268>
    102e:	4601                	li	a2,0
    1030:	b645                	j	bd0 <_vscanf_core.constprop.0+0x268>
        ctx->ungotten = -1;
    1032:	56fd                	li	a3,-1
    1034:	fce6                	sd	s9,120(sp)
    1036:	00ddac23          	sw	a3,24(s11)
                num_buf[i++] = (char)c;
    103a:	4d05                	li	s10,1
    103c:	fd57869b          	addiw	a3,a5,-43
    1040:	b171                	j	ccc <_vscanf_core.constprop.0+0x364>
        if (*str == '-')
    1042:	0017c583          	lbu	a1,1(a5)
    1046:	02d00693          	li	a3,45
    104a:	0ed58f63          	beq	a1,a3,1148 <_vscanf_core.constprop.0+0x7e0>
        else if (*str == '+')
    104e:	02b00693          	li	a3,43
    1052:	10d58e63          	beq	a1,a3,116e <_vscanf_core.constprop.0+0x806>
        while (*str >= '0' && *str <= '9')
    1056:	fd05861b          	addiw	a2,a1,-48
    105a:	0ff67513          	zext.b	a0,a2
    105e:	45a5                	li	a1,9
        str++;
    1060:	00178693          	addi	a3,a5,1
        int esign = 1;
    1064:	4805                	li	a6,1
        while (*str >= '0' && *str <= '9')
    1066:	04a5ec63          	bltu	a1,a0,10be <_vscanf_core.constprop.0+0x756>
    106a:	4525                	li	a0,9
    106c:	0016c583          	lbu	a1,1(a3)
            eval = eval * 10 + (*str - '0');
    1070:	0029979b          	slliw	a5,s3,0x2
    1074:	013787bb          	addw	a5,a5,s3
    1078:	0017979b          	slliw	a5,a5,0x1
    107c:	00f609bb          	addw	s3,a2,a5
        while (*str >= '0' && *str <= '9')
    1080:	fd05861b          	addiw	a2,a1,-48
    1084:	0ff67593          	zext.b	a1,a2
            str++;
    1088:	0685                	addi	a3,a3,1
        while (*str >= '0' && *str <= '9')
    108a:	feb571e3          	bgeu	a0,a1,106c <_vscanf_core.constprop.0+0x704>
        while (eval--)
    108e:	fff9879b          	addiw	a5,s3,-1
    1092:	12098463          	beqz	s3,11ba <_vscanf_core.constprop.0+0x852>
        double p = 1.0;
    1096:	00004717          	auipc	a4,0x4
    109a:	7b273687          	fld	fa3,1970(a4) # 5848 <STDIN_FD+0x10>
    109e:	00004717          	auipc	a4,0x4
    10a2:	7b273707          	fld	fa4,1970(a4) # 5850 <STDIN_FD+0x18>
        while (eval--)
    10a6:	56fd                	li	a3,-1
    10a8:	37fd                	addiw	a5,a5,-1
            p *= 10.0;
    10aa:	12e6f6d3          	fmul.d	fa3,fa3,fa4
        while (eval--)
    10ae:	fed79de3          	bne	a5,a3,10a8 <_vscanf_core.constprop.0+0x740>
        if (esign == 1)
    10b2:	4785                	li	a5,1
    10b4:	00f80963          	beq	a6,a5,10c6 <_vscanf_core.constprop.0+0x75e>
            val /= p;
    10b8:	1ad7f7d3          	fdiv.d	fa5,fa5,fa3
    10bc:	b5c9                	j	f7e <_vscanf_core.constprop.0+0x616>
        double p = 1.0;
    10be:	00004797          	auipc	a5,0x4
    10c2:	78a7b687          	fld	fa3,1930(a5) # 5848 <STDIN_FD+0x10>
            val *= p;
    10c6:	12d7f7d3          	fmul.d	fa5,fa5,fa3
    10ca:	bd55                	j	f7e <_vscanf_core.constprop.0+0x616>
    while (*str >= '0' && *str <= '9')
    10cc:	00004797          	auipc	a5,0x4
    10d0:	7747b587          	fld	fa1,1908(a5) # 5840 <STDIN_FD+0x8>
    10d4:	02114603          	lbu	a2,33(sp)
        str++;
    10d8:	02110793          	addi	a5,sp,33
    10dc:	bd91                	j	f30 <_vscanf_core.constprop.0+0x5c8>
        while (*str >= '0' && *str <= '9')
    10de:	0017c683          	lbu	a3,1(a5)
    10e2:	45a5                	li	a1,9
        str++;
    10e4:	0785                	addi	a5,a5,1
        while (*str >= '0' && *str <= '9')
    10e6:	fd06861b          	addiw	a2,a3,-48
    10ea:	0ff67513          	zext.b	a0,a2
    10ee:	e8a5e2e3          	bltu	a1,a0,f72 <_vscanf_core.constprop.0+0x60a>
        double div = 10.0;
    10f2:	00004717          	auipc	a4,0x4
    10f6:	75e73707          	fld	fa4,1886(a4) # 5850 <STDIN_FD+0x18>
    10fa:	22e70653          	fmv.d	fa2,fa4
        while (*str >= '0' && *str <= '9')
    10fe:	4525                	li	a0,9
            val += (*str - '0') / div;
    1100:	d20606d3          	fcvt.d.w	fa3,a2
        while (*str >= '0' && *str <= '9')
    1104:	0017c683          	lbu	a3,1(a5)
            str++;
    1108:	0785                	addi	a5,a5,1
            val += (*str - '0') / div;
    110a:	1ac6f6d3          	fdiv.d	fa3,fa3,fa2
        while (*str >= '0' && *str <= '9')
    110e:	fd06861b          	addiw	a2,a3,-48
    1112:	0ff67593          	zext.b	a1,a2
            div *= 10.0;
    1116:	12e67653          	fmul.d	fa2,fa2,fa4
            val += (*str - '0') / div;
    111a:	02d7f7d3          	fadd.d	fa5,fa5,fa3
        while (*str >= '0' && *str <= '9')
    111e:	feb571e3          	bgeu	a0,a1,1100 <_vscanf_core.constprop.0+0x798>
    1122:	bd81                	j	f72 <_vscanf_core.constprop.0+0x60a>
                    *va_arg(ap, double *) = val;
    1124:	a39c                	fsd	fa5,0(a5)
                assigned++;
    1126:	2b05                	addiw	s6,s6,1
    1128:	b62d                	j	c52 <_vscanf_core.constprop.0+0x2ea>
                    *va_arg(ap, int64 *) = val;
    112a:	6722                	ld	a4,8(sp)
    112c:	6314                	ld	a3,0(a4)
    112e:	e288                	sd	a0,0(a3)
    1130:	b55d                	j	fd6 <_vscanf_core.constprop.0+0x66e>
                    *va_arg(ap, long *) = (long)val;
    1132:	e288                	sd	a0,0(a3)
    1134:	b54d                	j	fd6 <_vscanf_core.constprop.0+0x66e>
    while (*str >= '0' && *str <= '9')
    1136:	00004797          	auipc	a5,0x4
    113a:	7127b587          	fld	fa1,1810(a5) # 5848 <STDIN_FD+0x10>
    113e:	02114603          	lbu	a2,33(sp)
        str++;
    1142:	02110793          	addi	a5,sp,33
    1146:	b3ed                	j	f30 <_vscanf_core.constprop.0+0x5c8>
        while (*str >= '0' && *str <= '9')
    1148:	0027c583          	lbu	a1,2(a5)
            str++;
    114c:	00278693          	addi	a3,a5,2
        while (*str >= '0' && *str <= '9')
    1150:	4525                	li	a0,9
    1152:	fd05861b          	addiw	a2,a1,-48
    1156:	0ff67793          	zext.b	a5,a2
            esign = -1;
    115a:	587d                	li	a6,-1
        while (*str >= '0' && *str <= '9')
    115c:	f0f577e3          	bgeu	a0,a5,106a <_vscanf_core.constprop.0+0x702>
        double p = 1.0;
    1160:	00004797          	auipc	a5,0x4
    1164:	6e87b687          	fld	fa3,1768(a5) # 5848 <STDIN_FD+0x10>
            val /= p;
    1168:	1ad7f7d3          	fdiv.d	fa5,fa5,fa3
    116c:	bd09                	j	f7e <_vscanf_core.constprop.0+0x616>
        while (*str >= '0' && *str <= '9')
    116e:	0027c583          	lbu	a1,2(a5)
            str++;
    1172:	00278693          	addi	a3,a5,2
        while (*str >= '0' && *str <= '9')
    1176:	4525                	li	a0,9
    1178:	fd05861b          	addiw	a2,a1,-48
    117c:	0ff67793          	zext.b	a5,a2
    1180:	f2f56fe3          	bltu	a0,a5,10be <_vscanf_core.constprop.0+0x756>
        int esign = 1;
    1184:	4805                	li	a6,1
    1186:	b5d5                	j	106a <_vscanf_core.constprop.0+0x702>
    while (*p)
    1188:	001bc783          	lbu	a5,1(s7)
    118c:	bed5                	j	d80 <_vscanf_core.constprop.0+0x418>
            if (!suppress)
    118e:	9e0997e3          	bnez	s3,b7c <_vscanf_core.constprop.0+0x214>
                buf[i] = '\0';
    1192:	67e2                	ld	a5,24(sp)
    1194:	00078023          	sb	zero,0(a5)
    1198:	b2d5                	j	b7c <_vscanf_core.constprop.0+0x214>
            num_buf[i] = '\0';
    119a:	040d0793          	addi	a5,s10,64
    119e:	1018                	addi	a4,sp,32
    11a0:	97ba                	add	a5,a5,a4
    11a2:	fc078023          	sb	zero,-64(a5)
            if (i == 0)
    11a6:	aa0d14e3          	bnez	s10,c4e <_vscanf_core.constprop.0+0x2e6>
    11aa:	b171                	j	e36 <_vscanf_core.constprop.0+0x4ce>
    11ac:	4641                	li	a2,16
                if (width > 0 && i >= width)
    11ae:	a5204be3          	bgtz	s2,c04 <_vscanf_core.constprop.0+0x29c>
    11b2:	bc99                	j	c08 <_vscanf_core.constprop.0+0x2a0>
            num_buf[i] = '\0';
    11b4:	020100a3          	sb	zero,33(sp)
            if (i == 0)
    11b8:	bb99                	j	f0e <_vscanf_core.constprop.0+0x5a6>
        double p = 1.0;
    11ba:	00004797          	auipc	a5,0x4
    11be:	68e7b687          	fld	fa3,1678(a5) # 5848 <STDIN_FD+0x10>
    11c2:	bdc5                	j	10b2 <_vscanf_core.constprop.0+0x74a>
                buf[i] = '\0';
    11c4:	67e2                	ld	a5,24(sp)
    11c6:	01a786b3          	add	a3,a5,s10
    11ca:	00068023          	sb	zero,0(a3)
        ctx->ungotten = c;
    11ce:	00adac23          	sw	a0,24(s11)
    while (*p)
    11d2:	001bc783          	lbu	a5,1(s7)
    11d6:	b6f5                	j	dc2 <_vscanf_core.constprop.0+0x45a>

00000000000011d8 <_out_char>:
{
    11d8:	7179                	addi	sp,sp,-48
    11da:	ec26                	sd	s1,24(sp)
    if (ctx->stream)
    11dc:	6d04                	ld	s1,24(a0)
{
    11de:	f022                	sd	s0,32(sp)
    11e0:	f406                	sd	ra,40(sp)
    11e2:	842a                	mv	s0,a0
    11e4:	872e                	mv	a4,a1
    if (ctx->stream)
    11e6:	c0a1                	beqz	s1,1226 <_out_char+0x4e>
    11e8:	e84a                	sd	s2,16(sp)
    if (stream->buf_mode == 2)
    11ea:	41c4a903          	lw	s2,1052(s1)
    11ee:	4789                	li	a5,2
    11f0:	04f90d63          	beq	s2,a5,124a <_out_char+0x72>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    11f4:	4104a783          	lw	a5,1040(s1)
    if (stream->buf_write_pos >= BUFSIZ)
    11f8:	3ff00693          	li	a3,1023
    stream->buffer[stream->buf_write_pos++] = (char)c;
    11fc:	0017861b          	addiw	a2,a5,1
    1200:	40c4a823          	sw	a2,1040(s1)
    1204:	97a6                	add	a5,a5,s1
    1206:	00b78823          	sb	a1,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    120a:	08c6c063          	blt	a3,a2,128a <_out_char+0xb2>
    else if (stream->buf_mode == 1 && c == '\n')
    120e:	4785                	li	a5,1
    1210:	04f90a63          	beq	s2,a5,1264 <_out_char+0x8c>
        ctx->written++;
    1214:	681c                	ld	a5,16(s0)
    1216:	6942                	ld	s2,16(sp)
}
    1218:	70a2                	ld	ra,40(sp)
        ctx->written++;
    121a:	0785                	addi	a5,a5,1
    121c:	e81c                	sd	a5,16(s0)
}
    121e:	7402                	ld	s0,32(sp)
    1220:	64e2                	ld	s1,24(sp)
    1222:	6145                	addi	sp,sp,48
    1224:	8082                	ret
        if (ctx->limit > 0 && ctx->written < ctx->limit - 1)
    1226:	6514                	ld	a3,8(a0)
    1228:	691c                	ld	a5,16(a0)
    122a:	ca89                	beqz	a3,123c <_out_char+0x64>
    122c:	16fd                	addi	a3,a3,-1
    122e:	00d7f763          	bgeu	a5,a3,123c <_out_char+0x64>
            ctx->buf[ctx->written] = c;
    1232:	6114                	ld	a3,0(a0)
    1234:	97b6                	add	a5,a5,a3
    1236:	00b78023          	sb	a1,0(a5)
        ctx->written++;
    123a:	691c                	ld	a5,16(a0)
    123c:	0785                	addi	a5,a5,1
}
    123e:	70a2                	ld	ra,40(sp)
        ctx->written++;
    1240:	e81c                	sd	a5,16(s0)
}
    1242:	7402                	ld	s0,32(sp)
    1244:	64e2                	ld	s1,24(sp)
    1246:	6145                	addi	sp,sp,48
    1248:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    124a:	4088                	lw	a0,0(s1)
    124c:	4605                	li	a2,1
    124e:	00f10593          	addi	a1,sp,15
        char ch = (char)c;
    1252:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    1256:	e93fe0ef          	jal	e8 <write>
    125a:	4785                	li	a5,1
    125c:	faf50ce3          	beq	a0,a5,1214 <_out_char+0x3c>
            stream->error = 1;
    1260:	c49c                	sw	a5,8(s1)
            return EOF;
    1262:	bf4d                	j	1214 <_out_char+0x3c>
    else if (stream->buf_mode == 1 && c == '\n')
    1264:	47a9                	li	a5,10
    1266:	faf597e3          	bne	a1,a5,1214 <_out_char+0x3c>
    if (stream->buf_write_pos > 0)
    126a:	fac055e3          	blez	a2,1214 <_out_char+0x3c>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    126e:	4088                	lw	a0,0(s1)
    1270:	01048593          	addi	a1,s1,16
    1274:	e75fe0ef          	jal	e8 <write>
        if (ret < stream->buf_write_pos)
    1278:	4104a783          	lw	a5,1040(s1)
    127c:	02f55063          	bge	a0,a5,129c <_out_char+0xc4>
            stream->error = 1;
    1280:	0124a423          	sw	s2,8(s1)
            stream->buf_write_pos = 0;
    1284:	4004a823          	sw	zero,1040(s1)
            return EOF;
    1288:	b771                	j	1214 <_out_char+0x3c>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    128a:	4088                	lw	a0,0(s1)
    128c:	01048593          	addi	a1,s1,16
    1290:	e59fe0ef          	jal	e8 <write>
        if (ret < stream->buf_write_pos)
    1294:	4104a783          	lw	a5,1040(s1)
    1298:	00f54563          	blt	a0,a5,12a2 <_out_char+0xca>
        stream->buf_write_pos = 0;
    129c:	4004a823          	sw	zero,1040(s1)
    12a0:	bf95                	j	1214 <_out_char+0x3c>
            stream->error = 1;
    12a2:	4785                	li	a5,1
    12a4:	c49c                	sw	a5,8(s1)
            stream->buf_write_pos = 0;
    12a6:	4004a823          	sw	zero,1040(s1)
            return EOF;
    12aa:	b7ad                	j	1214 <_out_char+0x3c>

00000000000012ac <stbsp_set_separators>:
   "75767778798081828384858687888990919293949596979899"
};

STBSP__PUBLICDEF void STB_SPRINTF_DECORATE(set_separators)(char pcomma, char pperiod)
{
   stbsp__period = pperiod;
    12ac:	00005797          	auipc	a5,0x5
    12b0:	6c478793          	addi	a5,a5,1732 # 6970 <stbsp__digitpair>
    12b4:	0cb78623          	sb	a1,204(a5)
   stbsp__comma = pcomma;
    12b8:	0ca786a3          	sb	a0,205(a5)
}
    12bc:	8082                	ret

00000000000012be <stbsp_vsprintfcb>:

   return (stbsp__uint32)(sn - s);
}

STBSP__PUBLICDEF int STB_SPRINTF_DECORATE(vsprintfcb)(STBSP_SPRINTFCB *callback, void *user, char *buf, char const *fmt, va_list va)
{
    12be:	d1010113          	addi	sp,sp,-752
            // Check if the next 4 bytes contain %(0x25) or end of string.
            // Using the 'hasless' trick:
            // https://graphics.stanford.edu/~seander/bithacks.html#HasLessInWord
            stbsp__uint32 v, c;
            v = *(stbsp__uint32 *)f;
            c = (~v) & 0x80808080;
    12c2:	808087b7          	lui	a5,0x80808
            if (((v ^ 0x25252525) - 0x01010101) & c)
    12c6:	252523b7          	lui	t2,0x25252
    12ca:	52538393          	addi	t2,t2,1317 # 25252525 <_ZSt4cerr+0x2524acbd>
{
    12ce:	29913c23          	sd	s9,664(sp)
    12d2:	29b13423          	sd	s11,648(sp)
   int tlen = 0;
    12d6:	4c81                	li	s9,0
            if (((v ^ 0x25252525) - 0x01010101) & c)
    12d8:	feff0db7          	lui	s11,0xfeff0
            c = (~v) & 0x80808080;
    12dc:	08078793          	addi	a5,a5,128 # ffffffff80808080 <_ZSt4cerr+0xffffffff80800818>
{
    12e0:	2e813023          	sd	s0,736(sp)
    12e4:	2c913c23          	sd	s1,728(sp)
    12e8:	2d213823          	sd	s2,720(sp)
    12ec:	2d313423          	sd	s3,712(sp)
    12f0:	2b713423          	sd	s7,680(sp)
    12f4:	2b813023          	sd	s8,672(sp)
    12f8:	29a13823          	sd	s10,656(sp)
    12fc:	2e113423          	sd	ra,744(sp)
    1300:	8d66                	mv	s10,s9
    1302:	8432                	mv	s0,a2
    1304:	8c9e                	mv	s9,t2
    1306:	89aa                	mv	s3,a0
    1308:	e42e                	sd	a1,8(sp)
    130a:	84b6                	mv	s1,a3
    130c:	8bba                	mv	s7,a4
    130e:	fc02                	sd	zero,56(sp)
   for (;;) {
    1310:	8932                	mv	s2,a2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    1312:	effd8d9b          	addiw	s11,s11,-257 # fffffffffefefeff <_ZSt4cerr+0xfffffffffefe8697>
               goto schk1;
            if ((v - 0x01010101) & c)
               goto schk2;
            if (callback)
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    1316:	20000c13          	li	s8,512
    131a:	83be                	mv	t2,a5
         while (((stbsp__uintptr)f) & 3) {
    131c:	0034f793          	andi	a5,s1,3
    1320:	c7a9                	beqz	a5,136a <stbsp_vsprintfcb+0xac>
            if (f[0] == '%')
    1322:	0004c783          	lbu	a5,0(s1)
    1326:	02500713          	li	a4,37
    132a:	0ee78263          	beq	a5,a4,140e <stbsp_vsprintfcb+0x150>
            if (f[0] == 0)
    132e:	cbd9                	beqz	a5,13c4 <stbsp_vsprintfcb+0x106>
            stbsp__chk_cb_buf(1);
    1330:	02098663          	beqz	s3,135c <stbsp_vsprintfcb+0x9e>
    1334:	4124063b          	subw	a2,s0,s2
    1338:	1fe00713          	li	a4,510
    133c:	02c75063          	bge	a4,a2,135c <stbsp_vsprintfcb+0x9e>
    1340:	65a2                	ld	a1,8(sp)
    1342:	854a                	mv	a0,s2
    1344:	e81e                	sd	t2,16(sp)
    1346:	00cd0d3b          	addw	s10,s10,a2
    134a:	9982                	jalr	s3
    134c:	892a                	mv	s2,a0
    134e:	e119                	bnez	a0,1354 <stbsp_vsprintfcb+0x96>
    1350:	0200106f          	j	2370 <stbsp_vsprintfcb+0x10b2>
            *bf++ = f[0];
    1354:	0004c783          	lbu	a5,0(s1)
            stbsp__chk_cb_buf(1);
    1358:	63c2                	ld	t2,16(sp)
    135a:	842a                	mv	s0,a0
            ++f;
    135c:	0485                	addi	s1,s1,1
            *bf++ = f[0];
    135e:	00f40023          	sb	a5,0(s0)
         while (((stbsp__uintptr)f) & 3) {
    1362:	0034f793          	andi	a5,s1,3
            *bf++ = f[0];
    1366:	0405                	addi	s0,s0,1
         while (((stbsp__uintptr)f) & 3) {
    1368:	ffcd                	bnez	a5,1322 <stbsp_vsprintfcb+0x64>
            v = *(stbsp__uint32 *)f;
    136a:	4094                	lw	a3,0(s1)
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
    1380:	f34d                	bnez	a4,1322 <stbsp_vsprintfcb+0x64>
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    1382:	460d                	li	a2,3
    1384:	a805                	j	13b4 <stbsp_vsprintfcb+0xf6>
            if (callback)
    1386:	00098863          	beqz	s3,1396 <stbsp_vsprintfcb+0xd8>
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    138a:	412407b3          	sub	a5,s0,s2
    138e:	40fc07bb          	subw	a5,s8,a5
    1392:	f8f658e3          	bge	a2,a5,1322 <stbsp_vsprintfcb+0x64>
                    bf[2] = f[2];
                    bf[3] = f[3];
                } else
            #endif
            {
                *(stbsp__uint32 *)bf = v;
    1396:	c014                	sw	a3,0(s0)
            v = *(stbsp__uint32 *)f;
    1398:	40d4                	lw	a3,4(s1)
            }
            bf += 4;
    139a:	0411                	addi	s0,s0,4
            f += 4;
    139c:	0491                	addi	s1,s1,4
            c = (~v) & 0x80808080;
    139e:	fff6c793          	not	a5,a3
            if (((v ^ 0x25252525) - 0x01010101) & c)
    13a2:	0196c733          	xor	a4,a3,s9
            c = (~v) & 0x80808080;
    13a6:	0077f7b3          	and	a5,a5,t2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    13aa:	01b7073b          	addw	a4,a4,s11
    13ae:	8f7d                	and	a4,a4,a5
    13b0:	2701                	sext.w	a4,a4
    13b2:	fb25                	bnez	a4,1322 <stbsp_vsprintfcb+0x64>
            if ((v - 0x01010101) & c)
    13b4:	01b6873b          	addw	a4,a3,s11
    13b8:	8ff9                	and	a5,a5,a4
    13ba:	2781                	sext.w	a5,a5
    13bc:	d7e9                	beqz	a5,1386 <stbsp_vsprintfcb+0xc8>
            if (f[0] == 0)
    13be:	0004c783          	lbu	a5,0(s1)
    13c2:	f7bd                	bnez	a5,1330 <stbsp_vsprintfcb+0x72>
endfmt:

   if (!callback)
      *bf = 0;
   else
      stbsp__flush_cb();
    13c4:	8cea                	mv	s9,s10
    13c6:	412404bb          	subw	s1,s0,s2
   if (!callback)
    13ca:	70098563          	beqz	s3,1ad4 <stbsp_vsprintfcb+0x816>
      stbsp__flush_cb();
    13ce:	00905663          	blez	s1,13da <stbsp_vsprintfcb+0x11c>
    13d2:	65a2                	ld	a1,8(sp)
    13d4:	8626                	mv	a2,s1
    13d6:	854a                	mv	a0,s2
    13d8:	9982                	jalr	s3
    13da:	009c8cbb          	addw	s9,s9,s1

done:
   return tlen + (int)(bf - buf);
}
    13de:	2e813083          	ld	ra,744(sp)
    13e2:	2e013403          	ld	s0,736(sp)
    13e6:	2d813483          	ld	s1,728(sp)
    13ea:	2d013903          	ld	s2,720(sp)
    13ee:	2c813983          	ld	s3,712(sp)
    13f2:	2a813b83          	ld	s7,680(sp)
    13f6:	2a013c03          	ld	s8,672(sp)
    13fa:	29013d03          	ld	s10,656(sp)
    13fe:	28813d83          	ld	s11,648(sp)
    1402:	8566                	mv	a0,s9
    1404:	29813c83          	ld	s9,664(sp)
    1408:	2f010113          	addi	sp,sp,752
    140c:	8082                	ret
    140e:	2d413023          	sd	s4,704(sp)
    1412:	2b513c23          	sd	s5,696(sp)
    1416:	2b613823          	sd	s6,688(sp)
      tz = 0;
    141a:	00248693          	addi	a3,s1,2
      fl = 0;
    141e:	4e01                	li	t3,0
         switch (f[0]) {
    1420:	03f00593          	li	a1,63
    1424:	00004617          	auipc	a2,0x4
    1428:	d4460613          	addi	a2,a2,-700 # 5168 <_GLOBAL__sub_I__ZSt3cin+0x188>
    142c:	fff6c783          	lbu	a5,-1(a3)
    1430:	fff68493          	addi	s1,a3,-1
    1434:	fe07871b          	addiw	a4,a5,-32
    1438:	0ff77713          	zext.b	a4,a4
    143c:	00e5ec63          	bltu	a1,a4,1454 <stbsp_vsprintfcb+0x196>
    1440:	070a                	slli	a4,a4,0x2
    1442:	9732                	add	a4,a4,a2
    1444:	4318                	lw	a4,0(a4)
    1446:	9732                	add	a4,a4,a2
    1448:	8702                	jr	a4
      if (f[0] == '*') {
    144a:	0014c783          	lbu	a5,1(s1)
            fl |= STBSP__LEADINGZERO;
    144e:	010e6e13          	ori	t3,t3,16
            ++f;
    1452:	0485                	addi	s1,s1,1
      if (f[0] == '*') {
    1454:	02a00713          	li	a4,42
    1458:	0ce79163          	bne	a5,a4,151a <stbsp_vsprintfcb+0x25c>
         fw = va_arg(va, stbsp__uint32);
    145c:	000bab03          	lw	s6,0(s7)
         while ((f[0] >= '0') && (f[0] <= '9')) {
    1460:	0014c783          	lbu	a5,1(s1)
         fw = va_arg(va, stbsp__uint32);
    1464:	0ba1                	addi	s7,s7,8
         ++f;
    1466:	0485                	addi	s1,s1,1
      if (f[0] == '.') {
    1468:	02e00713          	li	a4,46
      pr = -1;
    146c:	58fd                	li	a7,-1
      if (f[0] == '.') {
    146e:	0ee78663          	beq	a5,a4,155a <stbsp_vsprintfcb+0x29c>
      switch (f[0]) {
    1472:	04900713          	li	a4,73
    1476:	10e78263          	beq	a5,a4,157a <stbsp_vsprintfcb+0x2bc>
    147a:	f987871b          	addiw	a4,a5,-104
    147e:	0ff77713          	zext.b	a4,a4
    1482:	46c9                	li	a3,18
    1484:	02e6e063          	bltu	a3,a4,14a4 <stbsp_vsprintfcb+0x1e6>
    1488:	00004697          	auipc	a3,0x4
    148c:	de068693          	addi	a3,a3,-544 # 5268 <_GLOBAL__sub_I__ZSt3cin+0x288>
    1490:	070a                	slli	a4,a4,0x2
    1492:	9736                	add	a4,a4,a3
    1494:	4318                	lw	a4,0(a4)
    1496:	9736                	add	a4,a4,a3
    1498:	8702                	jr	a4
         if (f[0] == 'h')
    149a:	0014c783          	lbu	a5,1(s1)
         fl |= (sizeof(ptrdiff_t) == 8) ? STBSP__INTMAX : 0;
    149e:	020e6e13          	ori	t3,t3,32
         ++f;
    14a2:	0485                	addi	s1,s1,1
      switch (f[0]) {
    14a4:	fbf7871b          	addiw	a4,a5,-65
    14a8:	0ff77713          	zext.b	a4,a4
    14ac:	03700693          	li	a3,55
    14b0:	0ee6ea63          	bltu	a3,a4,15a4 <stbsp_vsprintfcb+0x2e6>
    14b4:	00004697          	auipc	a3,0x4
    14b8:	e0068693          	addi	a3,a3,-512 # 52b4 <_GLOBAL__sub_I__ZSt3cin+0x2d4>
    14bc:	070a                	slli	a4,a4,0x2
    14be:	9736                	add	a4,a4,a3
    14c0:	4318                	lw	a4,0(a4)
    14c2:	9736                	add	a4,a4,a3
    14c4:	8702                	jr	a4
            fl |= STBSP__METRIC_NOSPACE;
    14c6:	400e6e13          	ori	t3,t3,1024
            continue;
    14ca:	0685                	addi	a3,a3,1
    14cc:	b785                	j	142c <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEFTJUST;
    14ce:	001e6e13          	ori	t3,t3,1
            continue;
    14d2:	0685                	addi	a3,a3,1
    14d4:	bfa1                	j	142c <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADINGPLUS;
    14d6:	002e6e13          	ori	t3,t3,2
            continue;
    14da:	0685                	addi	a3,a3,1
    14dc:	bf81                	j	142c <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__TRIPLET_COMMA;
    14de:	040e6e13          	ori	t3,t3,64
            continue;
    14e2:	0685                	addi	a3,a3,1
    14e4:	b7a1                	j	142c <stbsp_vsprintfcb+0x16e>
            if (fl & STBSP__METRIC_SUFFIX) {
    14e6:	100e7793          	andi	a5,t3,256
    14ea:	8772                	mv	a4,t3
    14ec:	56078363          	beqz	a5,1a52 <stbsp_vsprintfcb+0x794>
               if (fl & STBSP__METRIC_1024) {
    14f0:	6785                	lui	a5,0x1
    14f2:	034e1513          	slli	a0,t3,0x34
    14f6:	80078793          	addi	a5,a5,-2048 # 800 <stbsp__real_to_str+0x626>
    14fa:	5c055863          	bgez	a0,1aca <stbsp_vsprintfcb+0x80c>
                  fl |= STBSP__METRIC_JEDEC;
    14fe:	6785                	lui	a5,0x1
    1500:	8f5d                	or	a4,a4,a5
    1502:	00070e1b          	sext.w	t3,a4
    1506:	0685                	addi	a3,a3,1
    1508:	b715                	j	142c <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADING_0X;
    150a:	008e6e13          	ori	t3,t3,8
            continue;
    150e:	0685                	addi	a3,a3,1
    1510:	bf31                	j	142c <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADINGSPACE;
    1512:	004e6e13          	ori	t3,t3,4
            continue;
    1516:	0685                	addi	a3,a3,1
    1518:	bf11                	j	142c <stbsp_vsprintfcb+0x16e>
         while ((f[0] >= '0') && (f[0] <= '9')) {
    151a:	fd07871b          	addiw	a4,a5,-48 # fd0 <_vscanf_core.constprop.0+0x668>
    151e:	0ff77713          	zext.b	a4,a4
    1522:	4625                	li	a2,9
      fw = 0;
    1524:	4b01                	li	s6,0
         while ((f[0] >= '0') && (f[0] <= '9')) {
    1526:	46a5                	li	a3,9
    1528:	f4e660e3          	bltu	a2,a4,1468 <stbsp_vsprintfcb+0x1aa>
            fw = fw * 10 + f[0] - '0';
    152c:	002b171b          	slliw	a4,s6,0x2
    1530:	0167073b          	addw	a4,a4,s6
    1534:	0017171b          	slliw	a4,a4,0x1
            f++;
    1538:	0485                	addi	s1,s1,1
            fw = fw * 10 + f[0] - '0';
    153a:	9f3d                	addw	a4,a4,a5
         while ((f[0] >= '0') && (f[0] <= '9')) {
    153c:	0004c783          	lbu	a5,0(s1)
            fw = fw * 10 + f[0] - '0';
    1540:	fd070b1b          	addiw	s6,a4,-48
         while ((f[0] >= '0') && (f[0] <= '9')) {
    1544:	fd07871b          	addiw	a4,a5,-48
    1548:	0ff77713          	zext.b	a4,a4
    154c:	fee6f0e3          	bgeu	a3,a4,152c <stbsp_vsprintfcb+0x26e>
      if (f[0] == '.') {
    1550:	02e00713          	li	a4,46
      pr = -1;
    1554:	58fd                	li	a7,-1
      if (f[0] == '.') {
    1556:	f0e79ee3          	bne	a5,a4,1472 <stbsp_vsprintfcb+0x1b4>
         if (f[0] == '*') {
    155a:	0014c783          	lbu	a5,1(s1)
    155e:	02a00713          	li	a4,42
    1562:	52e79763          	bne	a5,a4,1a90 <stbsp_vsprintfcb+0x7d2>
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1566:	0024c783          	lbu	a5,2(s1)
      switch (f[0]) {
    156a:	04900713          	li	a4,73
            pr = va_arg(va, stbsp__uint32);
    156e:	000ba883          	lw	a7,0(s7)
            ++f;
    1572:	0489                	addi	s1,s1,2
            pr = va_arg(va, stbsp__uint32);
    1574:	0ba1                	addi	s7,s7,8
      switch (f[0]) {
    1576:	f0e792e3          	bne	a5,a4,147a <stbsp_vsprintfcb+0x1bc>
         if ((f[1] == '6') && (f[2] == '4')) {
    157a:	0014c783          	lbu	a5,1(s1)
    157e:	03600713          	li	a4,54
    1582:	00e79463          	bne	a5,a4,158a <stbsp_vsprintfcb+0x2cc>
    1586:	1e60106f          	j	276c <stbsp_vsprintfcb+0x14ae>
         } else if ((f[1] == '3') && (f[2] == '2')) {
    158a:	03300713          	li	a4,51
    158e:	6ae796e3          	bne	a5,a4,243a <stbsp_vsprintfcb+0x117c>
    1592:	0024c683          	lbu	a3,2(s1)
    1596:	03200713          	li	a4,50
    159a:	00e69463          	bne	a3,a4,15a2 <stbsp_vsprintfcb+0x2e4>
    159e:	0ae0106f          	j	264c <stbsp_vsprintfcb+0x138e>
            ++f;
    15a2:	0485                	addi	s1,s1,1
         *s = f[0];
    15a4:	26f10fa3          	sb	a5,639(sp)
         l = 1;
    15a8:	4785                	li	a5,1
    15aa:	d0be                	sw	a5,96(sp)
         lead[0] = 0;
    15ac:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    15b0:	06010823          	sb	zero,112(sp)
         dp = 0;
    15b4:	d282                	sw	zero,100(sp)
    15b6:	e0de                	sd	s7,64(sp)
    15b8:	4701                	li	a4,0
    15ba:	4301                	li	t1,0
    15bc:	4f81                	li	t6,0
    15be:	4685                	li	a3,1
    15c0:	4a01                	li	s4,0
         cs = 0;
    15c2:	4281                	li	t0,0
         s = num + STBSP__NUMSZ - 1;
    15c4:	27f10a93          	addi	s5,sp,639
         fw = fl = 0;
    15c8:	4e01                	li	t3,0
      tz = 0;
    15ca:	4881                	li	a7,0
            if (fl & STBSP__LEADINGZERO) // if leading zeros, everything is in pr
    15cc:	010e7793          	andi	a5,t3,16
    15d0:	40078ee3          	beqz	a5,21ec <stbsp_vsprintfcb+0xf2e>
               pr = (fw > pr) ? fw : pr;
    15d4:	87ba                	mv	a5,a4
    15d6:	00675363          	bge	a4,t1,15dc <stbsp_vsprintfcb+0x31e>
    15da:	879a                	mv	a5,t1
    15dc:	0007871b          	sext.w	a4,a5
               fw = 0;
    15e0:	4301                	li	t1,0
         if (fw + pr) {
    15e2:	62070563          	beqz	a4,1c0c <stbsp_vsprintfcb+0x94e>
            sn = lead + 1;
    15e6:	06910793          	addi	a5,sp,105
    15ea:	fcbe                	sd	a5,120(sp)
            while (lead[0]) {
    15ec:	0a0a0863          	beqz	s4,169c <stbsp_vsprintfcb+0x3de>
               stbsp__cb_buf_clamp(i, lead[0]);
    15f0:	f026                	sd	s1,32(sp)
    15f2:	f436                	sd	a3,40(sp)
    15f4:	854a                	mv	a0,s2
    15f6:	86d2                	mv	a3,s4
    15f8:	84ce                	mv	s1,s3
               stbsp__chk_cb_buf(1);
    15fa:	1fe00b93          	li	s7,510
               stbsp__cb_buf_clamp(i, lead[0]);
    15fe:	89be                	mv	s3,a5
    1600:	20000b13          	li	s6,512
    1604:	87a2                	mv	a5,s0
    1606:	e846                	sd	a7,16(sp)
    1608:	846a                	mv	s0,s10
    160a:	ec7e                	sd	t6,24(sp)
    160c:	8d6e                	mv	s10,s11
    160e:	f872                	sd	t3,48(sp)
    1610:	8de6                	mv	s11,s9
    1612:	8a3a                	mv	s4,a4
    1614:	e496                	sd	t0,72(sp)
    1616:	891a                	mv	s2,t1
    1618:	8c9e                	mv	s9,t2
    161a:	0006871b          	sext.w	a4,a3
    161e:	2e0482e3          	beqz	s1,2102 <stbsp_vsprintfcb+0xe44>
    1622:	40a7863b          	subw	a2,a5,a0
    1626:	40cb083b          	subw	a6,s6,a2
    162a:	85c2                	mv	a1,a6
    162c:	01075363          	bge	a4,a6,1632 <stbsp_vsprintfcb+0x374>
    1630:	85ba                	mv	a1,a4
               lead[0] -= (char)i;
    1632:	9e8d                	subw	a3,a3,a1
               stbsp__cb_buf_clamp(i, lead[0]);
    1634:	0005871b          	sext.w	a4,a1
               lead[0] -= (char)i;
    1638:	06d10423          	sb	a3,104(sp)
               while (i) {
    163c:	c70d                	beqz	a4,1666 <stbsp_vsprintfcb+0x3a8>
    163e:	7866                	ld	a6,120(sp)
    1640:	02071593          	slli	a1,a4,0x20
    1644:	9181                	srli	a1,a1,0x20
    1646:	00b78633          	add	a2,a5,a1
    164a:	8742                	mv	a4,a6
                  *bf++ = *sn++;
    164c:	00074683          	lbu	a3,0(a4)
    1650:	0785                	addi	a5,a5,1
               while (i) {
    1652:	0705                	addi	a4,a4,1
                  *bf++ = *sn++;
    1654:	fed78fa3          	sb	a3,-1(a5)
               while (i) {
    1658:	fec79ae3          	bne	a5,a2,164c <stbsp_vsprintfcb+0x38e>
    165c:	982e                	add	a6,a6,a1
    165e:	fcc2                	sd	a6,120(sp)
               stbsp__chk_cb_buf(1);
    1660:	c899                	beqz	s1,1676 <stbsp_vsprintfcb+0x3b8>
    1662:	40a7863b          	subw	a2,a5,a0
    1666:	00cbd863          	bge	s7,a2,1676 <stbsp_vsprintfcb+0x3b8>
    166a:	65a2                	ld	a1,8(sp)
    166c:	9c31                	addw	s0,s0,a2
    166e:	9482                	jalr	s1
    1670:	34050ee3          	beqz	a0,21cc <stbsp_vsprintfcb+0xf0e>
    1674:	87aa                	mv	a5,a0
            while (lead[0]) {
    1676:	06814683          	lbu	a3,104(sp)
    167a:	f2c5                	bnez	a3,161a <stbsp_vsprintfcb+0x35c>
    167c:	83e6                	mv	t2,s9
    167e:	68c2                	ld	a7,16(sp)
    1680:	8cee                	mv	s9,s11
    1682:	6fe2                	ld	t6,24(sp)
    1684:	8dea                	mv	s11,s10
    1686:	76a2                	ld	a3,40(sp)
    1688:	8d22                	mv	s10,s0
    168a:	7e42                	ld	t3,48(sp)
    168c:	843e                	mv	s0,a5
    168e:	62a6                	ld	t0,72(sp)
    1690:	87ce                	mv	a5,s3
    1692:	89a6                	mv	s3,s1
    1694:	7482                	ld	s1,32(sp)
    1696:	834a                	mv	t1,s2
    1698:	8752                	mv	a4,s4
    169a:	892a                	mv	s2,a0
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    169c:	040e7b13          	andi	s6,t3,64
            c = cs >> 24;
    16a0:	0182d61b          	srliw	a2,t0,0x18
    16a4:	0182db9b          	srliw	s7,t0,0x18
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    16a8:	4a01                	li	s4,0
    16aa:	000b0e63          	beqz	s6,16c6 <stbsp_vsprintfcb+0x408>
            cs &= 0xffffff;
    16ae:	02829a13          	slli	s4,t0,0x28
    16b2:	028a5a13          	srli	s4,s4,0x28
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    16b6:	00ea0a3b          	addw	s4,s4,a4
    16ba:	0016059b          	addiw	a1,a2,1
    16be:	02ba7a3b          	remuw	s4,s4,a1
    16c2:	41460a3b          	subw	s4,a2,s4
            while (pr > 0) {
    16c6:	0ce05763          	blez	a4,1794 <stbsp_vsprintfcb+0x4d6>
                     *(stbsp__uint32 *)bf = 0x30303030;
    16ca:	30303837          	lui	a6,0x30303
    16ce:	03080813          	addi	a6,a6,48 # 30303030 <_ZSt4cerr+0x302fb7c8>
    16d2:	f026                	sd	s1,32(sp)
    16d4:	854a                	mv	a0,s2
    16d6:	84da                	mv	s1,s6
    16d8:	895e                	mv	s2,s7
    16da:	e4d6                	sd	s5,72(sp)
    16dc:	8b4e                	mv	s6,s3
    16de:	8aea                	mv	s5,s10
               stbsp__chk_cb_buf(1);
    16e0:	1fe00293          	li	t0,510
    16e4:	8d6e                	mv	s10,s11
                     *bf++ = stbsp__comma;
    16e6:	00005f17          	auipc	t5,0x5
    16ea:	28af0f13          	addi	t5,t5,650 # 6970 <stbsp__digitpair>
    16ee:	8de6                	mv	s11,s9
                     *bf++ = '0';
    16f0:	03000e93          	li	t4,48
    16f4:	e846                	sd	a7,16(sp)
    16f6:	ec7e                	sd	t6,24(sp)
    16f8:	f436                	sd	a3,40(sp)
    16fa:	f872                	sd	t3,48(sp)
    16fc:	e89a                	sd	t1,80(sp)
    16fe:	89ba                	mv	s3,a4
    1700:	ecbe                	sd	a5,88(sp)
    1702:	8bc2                	mv	s7,a6
    1704:	8c9e                	mv	s9,t2
               stbsp__cb_buf_clamp(i, pr);
    1706:	240b0ee3          	beqz	s6,2162 <stbsp_vsprintfcb+0xea4>
    170a:	40a407b3          	sub	a5,s0,a0
    170e:	40fc063b          	subw	a2,s8,a5
    1712:	87b2                	mv	a5,a2
    1714:	00c9d363          	bge	s3,a2,171a <stbsp_vsprintfcb+0x45c>
    1718:	87ce                	mv	a5,s3
    171a:	0007859b          	sext.w	a1,a5
               pr -= i;
    171e:	40f989bb          	subw	s3,s3,a5
               if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    1722:	32048c63          	beqz	s1,1a5a <stbsp_vsprintfcb+0x79c>
               while (i) {
    1726:	34058a63          	beqz	a1,1a7a <stbsp_vsprintfcb+0x7bc>
    172a:	1582                	slli	a1,a1,0x20
                     *bf++ = stbsp__comma;
    172c:	0cdf4603          	lbu	a2,205(t5)
    1730:	9181                	srli	a1,a1,0x20
    1732:	95a2                	add	a1,a1,s0
    1734:	0405                	addi	s0,s0,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (cs++ == c)) {
    1736:	c481                	beqz	s1,173e <stbsp_vsprintfcb+0x480>
    1738:	1d4901e3          	beq	s2,s4,20fa <stbsp_vsprintfcb+0xe3c>
    173c:	2a05                	addiw	s4,s4,1
                     *bf++ = '0';
    173e:	03000793          	li	a5,48
    1742:	fef40fa3          	sb	a5,-1(s0)
               while (i) {
    1746:	fe8597e3          	bne	a1,s0,1734 <stbsp_vsprintfcb+0x476>
               stbsp__chk_cb_buf(1);
    174a:	320b0b63          	beqz	s6,1a80 <stbsp_vsprintfcb+0x7c2>
    174e:	40a5863b          	subw	a2,a1,a0
    1752:	32c2d763          	bge	t0,a2,1a80 <stbsp_vsprintfcb+0x7c2>
    1756:	65a2                	ld	a1,8(sp)
    1758:	01560abb          	addw	s5,a2,s5
    175c:	9b02                	jalr	s6
    175e:	3a050ce3          	beqz	a0,2316 <stbsp_vsprintfcb+0x1058>
    1762:	842a                	mv	s0,a0
    1764:	1fe00293          	li	t0,510
    1768:	00005f17          	auipc	t5,0x5
    176c:	208f0f13          	addi	t5,t5,520 # 6970 <stbsp__digitpair>
    1770:	03000e93          	li	t4,48
            while (pr > 0) {
    1774:	f93049e3          	bgtz	s3,1706 <stbsp_vsprintfcb+0x448>
         while (lead[0]) {
    1778:	83e6                	mv	t2,s9
    177a:	68c2                	ld	a7,16(sp)
    177c:	8cee                	mv	s9,s11
    177e:	6fe2                	ld	t6,24(sp)
    1780:	8dea                	mv	s11,s10
    1782:	7482                	ld	s1,32(sp)
    1784:	8d56                	mv	s10,s5
    1786:	76a2                	ld	a3,40(sp)
    1788:	7e42                	ld	t3,48(sp)
    178a:	6346                	ld	t1,80(sp)
    178c:	67e6                	ld	a5,88(sp)
    178e:	6aa6                	ld	s5,72(sp)
    1790:	892a                	mv	s2,a0
    1792:	89da                	mv	s3,s6
    1794:	06814a03          	lbu	s4,104(sp)
         sn = lead + 1;
    1798:	fcbe                	sd	a5,120(sp)
         while (lead[0]) {
    179a:	0a0a0263          	beqz	s4,183e <stbsp_vsprintfcb+0x580>
            stbsp__cb_buf_clamp(i, lead[0]);
    179e:	ec26                	sd	s1,24(sp)
    17a0:	f036                	sd	a3,32(sp)
    17a2:	854a                	mv	a0,s2
    17a4:	86d2                	mv	a3,s4
    17a6:	84ce                	mv	s1,s3
    17a8:	87a2                	mv	a5,s0
            stbsp__chk_cb_buf(1);
    17aa:	1fe00b93          	li	s7,510
            stbsp__cb_buf_clamp(i, lead[0]);
    17ae:	846a                	mv	s0,s10
    17b0:	20000b13          	li	s6,512
    17b4:	8d6e                	mv	s10,s11
    17b6:	e846                	sd	a7,16(sp)
    17b8:	8de6                	mv	s11,s9
    17ba:	8a7e                	mv	s4,t6
    17bc:	8972                	mv	s2,t3
    17be:	899a                	mv	s3,t1
    17c0:	8c9e                	mv	s9,t2
    17c2:	0006871b          	sext.w	a4,a3
    17c6:	140482e3          	beqz	s1,210a <stbsp_vsprintfcb+0xe4c>
    17ca:	40a7863b          	subw	a2,a5,a0
    17ce:	40cb083b          	subw	a6,s6,a2
    17d2:	85c2                	mv	a1,a6
    17d4:	01075363          	bge	a4,a6,17da <stbsp_vsprintfcb+0x51c>
    17d8:	85ba                	mv	a1,a4
            lead[0] -= (char)i;
    17da:	9e8d                	subw	a3,a3,a1
            stbsp__cb_buf_clamp(i, lead[0]);
    17dc:	0005871b          	sext.w	a4,a1
            lead[0] -= (char)i;
    17e0:	06d10423          	sb	a3,104(sp)
            while (i) {
    17e4:	c70d                	beqz	a4,180e <stbsp_vsprintfcb+0x550>
    17e6:	7866                	ld	a6,120(sp)
    17e8:	02071593          	slli	a1,a4,0x20
    17ec:	9181                	srli	a1,a1,0x20
    17ee:	00b78633          	add	a2,a5,a1
    17f2:	8742                	mv	a4,a6
               *bf++ = *sn++;
    17f4:	00074683          	lbu	a3,0(a4)
    17f8:	0785                	addi	a5,a5,1
            while (i) {
    17fa:	0705                	addi	a4,a4,1
               *bf++ = *sn++;
    17fc:	fed78fa3          	sb	a3,-1(a5)
            while (i) {
    1800:	fec79ae3          	bne	a5,a2,17f4 <stbsp_vsprintfcb+0x536>
    1804:	982e                	add	a6,a6,a1
    1806:	fcc2                	sd	a6,120(sp)
            stbsp__chk_cb_buf(1);
    1808:	c899                	beqz	s1,181e <stbsp_vsprintfcb+0x560>
    180a:	40a7863b          	subw	a2,a5,a0
    180e:	00cbd863          	bge	s7,a2,181e <stbsp_vsprintfcb+0x560>
    1812:	65a2                	ld	a1,8(sp)
    1814:	9c31                	addw	s0,s0,a2
    1816:	9482                	jalr	s1
    1818:	1a050ae3          	beqz	a0,21cc <stbsp_vsprintfcb+0xf0e>
    181c:	87aa                	mv	a5,a0
         while (lead[0]) {
    181e:	06814683          	lbu	a3,104(sp)
    1822:	f2c5                	bnez	a3,17c2 <stbsp_vsprintfcb+0x504>
    1824:	834e                	mv	t1,s3
    1826:	68c2                	ld	a7,16(sp)
    1828:	89a6                	mv	s3,s1
    182a:	7682                	ld	a3,32(sp)
    182c:	64e2                	ld	s1,24(sp)
    182e:	8e4a                	mv	t3,s2
    1830:	83e6                	mv	t2,s9
    1832:	8fd2                	mv	t6,s4
    1834:	8cee                	mv	s9,s11
    1836:	892a                	mv	s2,a0
    1838:	8dea                	mv	s11,s10
    183a:	8d22                	mv	s10,s0
    183c:	843e                	mv	s0,a5
         while (n) {
    183e:	c6f9                	beqz	a3,190c <stbsp_vsprintfcb+0x64e>
            STBSP__UNALIGNED(while (i >= 4) {
    1840:	ec26                	sd	s1,24(sp)
    1842:	854a                	mv	a0,s2
    1844:	84d6                	mv	s1,s5
    1846:	896a                	mv	s2,s10
    1848:	87a2                	mv	a5,s0
    184a:	8d6e                	mv	s10,s11
            stbsp__chk_cb_buf(1);
    184c:	1fe00b93          	li	s7,510
            STBSP__UNALIGNED(while (i >= 4) {
    1850:	8de6                	mv	s11,s9
            stbsp__cb_buf_clamp(i, n);
    1852:	20000b13          	li	s6,512
            STBSP__UNALIGNED(while (i >= 4) {
    1856:	4a0d                	li	s4,3
    1858:	e87e                	sd	t6,16(sp)
    185a:	f072                	sd	t3,32(sp)
    185c:	8ac6                	mv	s5,a7
    185e:	f41a                	sd	t1,40(sp)
    1860:	8436                	mv	s0,a3
    1862:	8c9e                	mv	s9,t2
            stbsp__cb_buf_clamp(i, n);
    1864:	0004071b          	sext.w	a4,s0
    1868:	100982e3          	beqz	s3,216c <stbsp_vsprintfcb+0xeae>
    186c:	40a78633          	sub	a2,a5,a0
    1870:	40cb05bb          	subw	a1,s6,a2
    1874:	862e                	mv	a2,a1
    1876:	00b75363          	bge	a4,a1,187c <stbsp_vsprintfcb+0x5be>
    187a:	863a                	mv	a2,a4
    187c:	0006071b          	sext.w	a4,a2
            n -= i;
    1880:	9c11                	subw	s0,s0,a2
            STBSP__UNALIGNED(while (i >= 4) {
    1882:	14ea50e3          	bge	s4,a4,21c2 <stbsp_vsprintfcb+0xf04>
    1886:	ffc70f1b          	addiw	t5,a4,-4
    188a:	002f5e9b          	srliw	t4,t5,0x2
    188e:	001e8e1b          	addiw	t3,t4,1
    1892:	0e0a                	slli	t3,t3,0x2
    1894:	01c785b3          	add	a1,a5,t3
    1898:	8626                	mv	a2,s1
    189a:	4218                	lw	a4,0(a2)
    189c:	0791                	addi	a5,a5,4
    189e:	0611                	addi	a2,a2,4
    18a0:	2701                	sext.w	a4,a4
    18a2:	fee7ae23          	sw	a4,-4(a5)
    18a6:	feb79ae3          	bne	a5,a1,189a <stbsp_vsprintfcb+0x5dc>
    18aa:	002e9e9b          	slliw	t4,t4,0x2
    18ae:	41df073b          	subw	a4,t5,t4
            while (i) {
    18b2:	94f2                	add	s1,s1,t3
    18b4:	c31d                	beqz	a4,18da <stbsp_vsprintfcb+0x61c>
    18b6:	8626                	mv	a2,s1
    18b8:	87ae                	mv	a5,a1
    18ba:	00e58f3b          	addw	t5,a1,a4
               *bf++ = *s++;
    18be:	00064e83          	lbu	t4,0(a2)
    18c2:	0785                	addi	a5,a5,1
            while (i) {
    18c4:	00078e1b          	sext.w	t3,a5
               *bf++ = *s++;
    18c8:	ffd78fa3          	sb	t4,-1(a5)
    18cc:	0605                	addi	a2,a2,1
            while (i) {
    18ce:	ffcf18e3          	bne	t5,t3,18be <stbsp_vsprintfcb+0x600>
    18d2:	1702                	slli	a4,a4,0x20
    18d4:	9301                	srli	a4,a4,0x20
    18d6:	95ba                	add	a1,a1,a4
    18d8:	94ba                	add	s1,s1,a4
            stbsp__chk_cb_buf(1);
    18da:	1a098763          	beqz	s3,1a88 <stbsp_vsprintfcb+0x7ca>
    18de:	40a5863b          	subw	a2,a1,a0
    18e2:	1acbd363          	bge	s7,a2,1a88 <stbsp_vsprintfcb+0x7ca>
    18e6:	65a2                	ld	a1,8(sp)
    18e8:	0126093b          	addw	s2,a2,s2
    18ec:	9982                	jalr	s3
    18ee:	20050be3          	beqz	a0,2304 <stbsp_vsprintfcb+0x1046>
    18f2:	87aa                	mv	a5,a0
         while (n) {
    18f4:	f825                	bnez	s0,1864 <stbsp_vsprintfcb+0x5a6>
    18f6:	6fc2                	ld	t6,16(sp)
    18f8:	64e2                	ld	s1,24(sp)
    18fa:	7e02                	ld	t3,32(sp)
    18fc:	7322                	ld	t1,40(sp)
    18fe:	83e6                	mv	t2,s9
    1900:	88d6                	mv	a7,s5
    1902:	8cee                	mv	s9,s11
    1904:	843e                	mv	s0,a5
    1906:	8dea                	mv	s11,s10
    1908:	8d4a                	mv	s10,s2
    190a:	892a                	mv	s2,a0
         while (tz) {
    190c:	08088863          	beqz	a7,199c <stbsp_vsprintfcb+0x6de>
               *(stbsp__uint32 *)bf = 0x30303030;
    1910:	30303b37          	lui	s6,0x30303
               *bf++ = '0';
    1914:	03000a13          	li	s4,48
            while (i >= 4) {
    1918:	4a8d                	li	s5,3
            stbsp__chk_cb_buf(1);
    191a:	1fe00693          	li	a3,510
               *(stbsp__uint32 *)bf = 0x30303030;
    191e:	030b0b13          	addi	s6,s6,48 # 30303030 <_ZSt4cerr+0x302fb7c8>
            stbsp__cb_buf_clamp(i, tz);
    1922:	20000b93          	li	s7,512
    1926:	040989e3          	beqz	s3,2178 <stbsp_vsprintfcb+0xeba>
    192a:	41240633          	sub	a2,s0,s2
    192e:	40cb87bb          	subw	a5,s7,a2
    1932:	873e                	mv	a4,a5
    1934:	00f8d363          	bge	a7,a5,193a <stbsp_vsprintfcb+0x67c>
    1938:	8746                	mv	a4,a7
    193a:	0007079b          	sext.w	a5,a4
            tz -= i;
    193e:	40e888bb          	subw	a7,a7,a4
            while (i) {
    1942:	08078ee3          	beqz	a5,21de <stbsp_vsprintfcb+0xf20>
               if ((((stbsp__uintptr)bf) & 3) == 0)
    1946:	00347713          	andi	a4,s0,3
    194a:	e719                	bnez	a4,1958 <stbsp_vsprintfcb+0x69a>
    194c:	0390006f          	j	2184 <stbsp_vsprintfcb+0xec6>
    1950:	00347713          	andi	a4,s0,3
    1954:	7a070f63          	beqz	a4,2112 <stbsp_vsprintfcb+0xe54>
               *bf++ = '0';
    1958:	01440023          	sb	s4,0(s0)
               --i;
    195c:	37fd                	addiw	a5,a5,-1
               *bf++ = '0';
    195e:	0405                	addi	s0,s0,1
            while (i) {
    1960:	fbe5                	bnez	a5,1950 <stbsp_vsprintfcb+0x692>
            stbsp__chk_cb_buf(1);
    1962:	02098b63          	beqz	s3,1998 <stbsp_vsprintfcb+0x6da>
    1966:	4124063b          	subw	a2,s0,s2
    196a:	02c6d763          	bge	a3,a2,1998 <stbsp_vsprintfcb+0x6da>
    196e:	65a2                	ld	a1,8(sp)
    1970:	854a                	mv	a0,s2
    1972:	f81e                	sd	t2,48(sp)
    1974:	f41a                	sd	t1,40(sp)
    1976:	f072                	sd	t3,32(sp)
    1978:	ec7e                	sd	t6,24(sp)
    197a:	e846                	sd	a7,16(sp)
    197c:	00cd0d3b          	addw	s10,s10,a2
    1980:	9982                	jalr	s3
    1982:	892a                	mv	s2,a0
    1984:	1a0502e3          	beqz	a0,2328 <stbsp_vsprintfcb+0x106a>
    1988:	73c2                	ld	t2,48(sp)
    198a:	7322                	ld	t1,40(sp)
    198c:	7e02                	ld	t3,32(sp)
    198e:	6fe2                	ld	t6,24(sp)
    1990:	68c2                	ld	a7,16(sp)
    1992:	842a                	mv	s0,a0
    1994:	1fe00693          	li	a3,510
         while (tz) {
    1998:	f80897e3          	bnez	a7,1926 <stbsp_vsprintfcb+0x668>
         sn = tail + 1;
    199c:	07110793          	addi	a5,sp,113
    19a0:	fcbe                	sd	a5,120(sp)
         while (tail[0]) {
    19a2:	080f8763          	beqz	t6,1a30 <stbsp_vsprintfcb+0x772>
            stbsp__cb_buf_clamp(i, tail[0]);
    19a6:	854a                	mv	a0,s2
    19a8:	8b6a                	mv	s6,s10
            stbsp__chk_cb_buf(1);
    19aa:	1fe00a93          	li	s5,510
            stbsp__cb_buf_clamp(i, tail[0]);
    19ae:	8d4e                	mv	s10,s3
    19b0:	20000a13          	li	s4,512
    19b4:	8bf2                	mv	s7,t3
    19b6:	891a                	mv	s2,t1
    19b8:	899e                	mv	s3,t2
    19ba:	000f879b          	sext.w	a5,t6
    19be:	7c0d0863          	beqz	s10,218e <stbsp_vsprintfcb+0xed0>
    19c2:	40a4063b          	subw	a2,s0,a0
    19c6:	40ca06bb          	subw	a3,s4,a2
    19ca:	8736                	mv	a4,a3
    19cc:	00d7d363          	bge	a5,a3,19d2 <stbsp_vsprintfcb+0x714>
    19d0:	873e                	mv	a4,a5
            tail[0] -= (char)i;
    19d2:	40ef8fbb          	subw	t6,t6,a4
            stbsp__cb_buf_clamp(i, tail[0]);
    19d6:	0007079b          	sext.w	a5,a4
            tail[0] -= (char)i;
    19da:	07f10823          	sb	t6,112(sp)
            while (i) {
    19de:	c795                	beqz	a5,1a0a <stbsp_vsprintfcb+0x74c>
    19e0:	75e6                	ld	a1,120(sp)
    19e2:	02079613          	slli	a2,a5,0x20
    19e6:	9201                	srli	a2,a2,0x20
    19e8:	00c406b3          	add	a3,s0,a2
    19ec:	87ae                	mv	a5,a1
               *bf++ = *sn++;
    19ee:	0007c703          	lbu	a4,0(a5)
    19f2:	0405                	addi	s0,s0,1
            while (i) {
    19f4:	0785                	addi	a5,a5,1
               *bf++ = *sn++;
    19f6:	fee40fa3          	sb	a4,-1(s0)
            while (i) {
    19fa:	fed41ae3          	bne	s0,a3,19ee <stbsp_vsprintfcb+0x730>
    19fe:	95b2                	add	a1,a1,a2
    1a00:	fcae                	sd	a1,120(sp)
            stbsp__chk_cb_buf(1);
    1a02:	000d0d63          	beqz	s10,1a1c <stbsp_vsprintfcb+0x75e>
    1a06:	40a4063b          	subw	a2,s0,a0
    1a0a:	00cad963          	bge	s5,a2,1a1c <stbsp_vsprintfcb+0x75e>
    1a0e:	65a2                	ld	a1,8(sp)
    1a10:	00cb0b3b          	addw	s6,s6,a2
    1a14:	9d02                	jalr	s10
    1a16:	200509e3          	beqz	a0,2428 <stbsp_vsprintfcb+0x116a>
    1a1a:	842a                	mv	s0,a0
         while (tail[0]) {
    1a1c:	07014f83          	lbu	t6,112(sp)
    1a20:	f80f9de3          	bnez	t6,19ba <stbsp_vsprintfcb+0x6fc>
    1a24:	834a                	mv	t1,s2
    1a26:	83ce                	mv	t2,s3
    1a28:	8e5e                	mv	t3,s7
    1a2a:	89ea                	mv	s3,s10
    1a2c:	892a                	mv	s2,a0
    1a2e:	8d5a                	mv	s10,s6
         if (fl & STBSP__LEFTJUST)
    1a30:	001e7e13          	andi	t3,t3,1
    1a34:	000e0663          	beqz	t3,1a40 <stbsp_vsprintfcb+0x782>
            if (fw > 0) {
    1a38:	00605463          	blez	t1,1a40 <stbsp_vsprintfcb+0x782>
    1a3c:	0300106f          	j	2a6c <stbsp_vsprintfcb+0x17ae>
   for (;;) {
    1a40:	6b86                	ld	s7,64(sp)
    1a42:	2c013a03          	ld	s4,704(sp)
    1a46:	2b813a83          	ld	s5,696(sp)
    1a4a:	2b013b03          	ld	s6,688(sp)
      ++f;
    1a4e:	0485                	addi	s1,s1,1
   for (;;) {
    1a50:	b0f1                	j	131c <stbsp_vsprintfcb+0x5e>
               fl |= STBSP__METRIC_SUFFIX;
    1a52:	100e6e13          	ori	t3,t3,256
            continue;
    1a56:	0685                	addi	a3,a3,1
    1a58:	bad1                	j	142c <stbsp_vsprintfcb+0x16e>
                  while (i) {
    1a5a:	0e0580e3          	beqz	a1,233a <stbsp_vsprintfcb+0x107c>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    1a5e:	00347793          	andi	a5,s0,3
    1a62:	e799                	bnez	a5,1a70 <stbsp_vsprintfcb+0x7b2>
    1a64:	0dd0006f          	j	2340 <stbsp_vsprintfcb+0x1082>
    1a68:	00347793          	andi	a5,s0,3
    1a6c:	72078463          	beqz	a5,2194 <stbsp_vsprintfcb+0xed6>
                     *bf++ = '0';
    1a70:	01d40023          	sb	t4,0(s0)
                     --i;
    1a74:	35fd                	addiw	a1,a1,-1
                     *bf++ = '0';
    1a76:	0405                	addi	s0,s0,1
                  while (i) {
    1a78:	f9e5                	bnez	a1,1a68 <stbsp_vsprintfcb+0x7aa>
               while (i) {
    1a7a:	85a2                	mv	a1,s0
               stbsp__chk_cb_buf(1);
    1a7c:	cc0b19e3          	bnez	s6,174e <stbsp_vsprintfcb+0x490>
    1a80:	842e                	mv	s0,a1
            while (pr > 0) {
    1a82:	c93042e3          	bgtz	s3,1706 <stbsp_vsprintfcb+0x448>
    1a86:	b9cd                	j	1778 <stbsp_vsprintfcb+0x4ba>
            while (i) {
    1a88:	87ae                	mv	a5,a1
         while (n) {
    1a8a:	dc041de3          	bnez	s0,1864 <stbsp_vsprintfcb+0x5a6>
    1a8e:	b5a5                	j	18f6 <stbsp_vsprintfcb+0x638>
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1a90:	fd07871b          	addiw	a4,a5,-48
    1a94:	0ff77713          	zext.b	a4,a4
    1a98:	4625                	li	a2,9
         ++f;
    1a9a:	0485                	addi	s1,s1,1
            pr = 0;
    1a9c:	4881                	li	a7,0
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1a9e:	46a5                	li	a3,9
    1aa0:	9ce669e3          	bltu	a2,a4,1472 <stbsp_vsprintfcb+0x1b4>
               pr = pr * 10 + f[0] - '0';
    1aa4:	0028971b          	slliw	a4,a7,0x2
    1aa8:	0117073b          	addw	a4,a4,a7
    1aac:	0017171b          	slliw	a4,a4,0x1
               f++;
    1ab0:	0485                	addi	s1,s1,1
               pr = pr * 10 + f[0] - '0';
    1ab2:	9f3d                	addw	a4,a4,a5
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1ab4:	0004c783          	lbu	a5,0(s1)
               pr = pr * 10 + f[0] - '0';
    1ab8:	fd07089b          	addiw	a7,a4,-48
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1abc:	fd07871b          	addiw	a4,a5,-48
    1ac0:	0ff77713          	zext.b	a4,a4
    1ac4:	fee6f0e3          	bgeu	a3,a4,1aa4 <stbsp_vsprintfcb+0x7e6>
    1ac8:	b26d                	j	1472 <stbsp_vsprintfcb+0x1b4>
                  fl |= STBSP__METRIC_1024;
    1aca:	8f5d                	or	a4,a4,a5
    1acc:	00070e1b          	sext.w	t3,a4
    1ad0:	0685                	addi	a3,a3,1
    1ad2:	baa9                	j	142c <stbsp_vsprintfcb+0x16e>
      *bf = 0;
    1ad4:	00040023          	sb	zero,0(s0)
    1ad8:	b209                	j	13da <stbsp_vsprintfcb+0x11c>
         if (f[0] == 'l') {
    1ada:	0014c783          	lbu	a5,1(s1)
    1ade:	06c00713          	li	a4,108
         fl |= ((sizeof(long) == 8) ? STBSP__INTMAX : 0);
    1ae2:	020e6e13          	ori	t3,t3,32
         if (f[0] == 'l') {
    1ae6:	00e78c63          	beq	a5,a4,1afe <stbsp_vsprintfcb+0x840>
            ++f;
    1aea:	0485                	addi	s1,s1,1
    1aec:	ba65                	j	14a4 <stbsp_vsprintfcb+0x1e6>
         if (f[0] == 'h')
    1aee:	0014c783          	lbu	a5,1(s1)
    1af2:	06800713          	li	a4,104
         fl |= STBSP__HALFWIDTH;
    1af6:	200e6e13          	ori	t3,t3,512
         if (f[0] == 'h')
    1afa:	fee798e3          	bne	a5,a4,1aea <stbsp_vsprintfcb+0x82c>
         if ((f[1] == '6') && (f[2] == '4')) {
    1afe:	0024c783          	lbu	a5,2(s1)
            ++f;
    1b02:	0489                	addi	s1,s1,2
    1b04:	b245                	j	14a4 <stbsp_vsprintfcb+0x1e6>
         s = va_arg(va, char *);
    1b06:	008b8713          	addi	a4,s7,8
    1b0a:	e0ba                	sd	a4,64(sp)
         if (fl & STBSP__INTMAX) {
    1b0c:	020e7693          	andi	a3,t3,32
    1b10:	8772                	mv	a4,t3
    1b12:	24069ee3          	bnez	a3,256e <stbsp_vsprintfcb+0x12b0>
            stbsp__int32 i = va_arg(va, stbsp__int32);
    1b16:	000ba683          	lw	a3,0(s7)
            if ((f[0] != 'u') && (i < 0)) {
    1b1a:	07500613          	li	a2,117
            n64 = (stbsp__uint32)i;
    1b1e:	02069f13          	slli	t5,a3,0x20
    1b22:	020f5f13          	srli	t5,t5,0x20
            if ((f[0] != 'u') && (i < 0)) {
    1b26:	00c78a63          	beq	a5,a2,1b3a <stbsp_vsprintfcb+0x87c>
    1b2a:	0006d863          	bgez	a3,1b3a <stbsp_vsprintfcb+0x87c>
               fl |= STBSP__NEGATIVE;
    1b2e:	08076713          	ori	a4,a4,128
               n64 = (stbsp__uint32)-i;
    1b32:	40d00f3b          	negw	t5,a3
               fl |= STBSP__NEGATIVE;
    1b36:	00070e1b          	sext.w	t3,a4
         if (fl & STBSP__METRIC_SUFFIX) {
    1b3a:	100e7693          	andi	a3,t3,256
    1b3e:	5c0683e3          	beqz	a3,2904 <stbsp_vsprintfcb+0x1646>
            if (n64 < 1024)
    1b42:	3ff00793          	li	a5,1023
    1b46:	01e7e463          	bltu	a5,t5,1b4e <stbsp_vsprintfcb+0x890>
    1b4a:	0ea0106f          	j	2c34 <stbsp_vsprintfcb+0x1976>
            else if (pr == -1)
    1b4e:	57fd                	li	a5,-1
    1b50:	30f887e3          	beq	a7,a5,265e <stbsp_vsprintfcb+0x13a0>
            fv = (double)(stbsp__int64)n64;
    1b54:	d22f7553          	fcvt.d.l	fa0,t5
            if (fl & STBSP__METRIC_1024)
    1b58:	034e1793          	slli	a5,t3,0x34
    1b5c:	0007c463          	bltz	a5,1b64 <stbsp_vsprintfcb+0x8a6>
    1b60:	2300106f          	j	2d90 <stbsp_vsprintfcb+0x1ad2>
               divisor = 1024.0;
    1b64:	00004797          	auipc	a5,0x4
    1b68:	cf47b787          	fld	fa5,-780(a5) # 5858 <STDIN_FD+0x20>
               if ((fv < divisor) && (fv > -divisor))
    1b6c:	22f79753          	fneg.d	fa4,fa5
               fl += 0x1000000;
    1b70:	010006b7          	lui	a3,0x1000
            while (fl < 0x4000000) {
    1b74:	04000737          	lui	a4,0x4000
               if ((fv < divisor) && (fv > -divisor))
    1b78:	a2f517d3          	flt.d	a5,fa0,fa5
    1b7c:	c789                	beqz	a5,1b86 <stbsp_vsprintfcb+0x8c8>
    1b7e:	a2a717d3          	flt.d	a5,fa4,fa0
    1b82:	3e079863          	bnez	a5,1f72 <stbsp_vsprintfcb+0xcb4>
               fl += 0x1000000;
    1b86:	01c68e3b          	addw	t3,a3,t3
               fv /= divisor;
    1b8a:	1af57553          	fdiv.d	fa0,fa0,fa5
            while (fl < 0x4000000) {
    1b8e:	feee65e3          	bltu	t3,a4,1b78 <stbsp_vsprintfcb+0x8ba>
    1b92:	a6c5                	j	1f72 <stbsp_vsprintfcb+0xcb4>
         h = (f[0] == 'X') ? hexu : hex;
    1b94:	05800693          	li	a3,88
         if (fl & STBSP__INTMAX) {
    1b98:	020e7713          	andi	a4,t3,32
         h = (f[0] == 'X') ? hexu : hex;
    1b9c:	00005817          	auipc	a6,0x5
    1ba0:	ebc80813          	addi	a6,a6,-324 # 6a58 <hex.0>
    1ba4:	00d79663          	bne	a5,a3,1bb0 <stbsp_vsprintfcb+0x8f2>
    1ba8:	00005817          	auipc	a6,0x5
    1bac:	e9880813          	addi	a6,a6,-360 # 6a40 <hexu.1>
         l = (4 << 4) | (4 << 8);
    1bb0:	44000793          	li	a5,1088
    1bb4:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__LEADING_0X) {
    1bb6:	008e7793          	andi	a5,t3,8
    1bba:	7a079263          	bnez	a5,235e <stbsp_vsprintfcb+0x10a0>
         lead[0] = 0;
    1bbe:	06010423          	sb	zero,104(sp)
         s = va_arg(va, char *);
    1bc2:	008b8793          	addi	a5,s7,8
    1bc6:	e0be                	sd	a5,64(sp)
         if (fl & STBSP__INTMAX)
    1bc8:	72070b63          	beqz	a4,22fe <stbsp_vsprintfcb+0x1040>
            n64 = va_arg(va, stbsp__uint64);
    1bcc:	000bb683          	ld	a3,0(s7)
         dp = 0;
    1bd0:	d282                	sw	zero,100(sp)
         tail[0] = 0;
    1bd2:	06010823          	sb	zero,112(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    1bd6:	001e7513          	andi	a0,t3,1
         if (n64 == 0) {
    1bda:	380694e3          	bnez	a3,2762 <stbsp_vsprintfcb+0x14a4>
            lead[0] = 0;
    1bde:	06010423          	sb	zero,104(sp)
            if (pr == 0) {
    1be2:	78089a63          	bnez	a7,2376 <stbsp_vsprintfcb+0x10b8>
         if (fw < (stbsp__int32)n)
    1be6:	fffb4313          	not	t1,s6
    1bea:	43f35313          	srai	t1,t1,0x3f
               l = 0;
    1bee:	d082                	sw	zero,96(sp)
         if (fw < (stbsp__int32)n)
    1bf0:	01637333          	and	t1,t1,s6
               goto scopy;
    1bf4:	4701                	li	a4,0
    1bf6:	4f81                	li	t6,0
    1bf8:	4a01                	li	s4,0
               cs = 0;
    1bfa:	4281                	li	t0,0
         s = num + STBSP__NUMSZ;
    1bfc:	28010a93          	addi	s5,sp,640
         if ((fl & STBSP__LEFTJUST) == 0) {
    1c00:	9c0506e3          	beqz	a0,15cc <stbsp_vsprintfcb+0x30e>
         if (fw + pr) {
    1c04:	00e307bb          	addw	a5,t1,a4
    1c08:	9c079fe3          	bnez	a5,15e6 <stbsp_vsprintfcb+0x328>
    1c0c:	06910793          	addi	a5,sp,105
    1c10:	b661                	j	1798 <stbsp_vsprintfcb+0x4da>
         h = (f[0] == 'E') ? hexu : hex;
    1c12:	04500713          	li	a4,69
    1c16:	00005317          	auipc	t1,0x5
    1c1a:	e4230313          	addi	t1,t1,-446 # 6a58 <hex.0>
    1c1e:	1ce78ae3          	beq	a5,a4,25f2 <stbsp_vsprintfcb+0x1334>
         fv = va_arg(va, double);
    1c22:	008b8713          	addi	a4,s7,8
         if (pr == -1)
    1c26:	57fd                	li	a5,-1
         fv = va_arg(va, double);
    1c28:	e0ba                	sd	a4,64(sp)
    1c2a:	000bb507          	fld	fa0,0(s7)
         if (pr == -1)
    1c2e:	1af88ce3          	beq	a7,a5,25e6 <stbsp_vsprintfcb+0x1328>
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr | 0x80000000))
    1c32:	80000737          	lui	a4,0x80000
    1c36:	00e8e733          	or	a4,a7,a4
    1c3a:	2701                	sext.w	a4,a4
    1c3c:	10d4                	addi	a3,sp,100
    1c3e:	0110                	addi	a2,sp,128
    1c40:	108c                	addi	a1,sp,96
    1c42:	18a8                	addi	a0,sp,120
    1c44:	f41e                	sd	t2,40(sp)
    1c46:	f01a                	sd	t1,32(sp)
    1c48:	ec72                	sd	t3,24(sp)
    1c4a:	e846                	sd	a7,16(sp)
    1c4c:	d8efe0ef          	jal	1da <stbsp__real_to_str>
    1c50:	68c2                	ld	a7,16(sp)
    1c52:	6e62                	ld	t3,24(sp)
    1c54:	7302                	ld	t1,32(sp)
    1c56:	73a2                	ld	t2,40(sp)
         if (dp == STBSP__SPECIAL) {
    1c58:	5796                	lw	a5,100(sp)
            s = (char *)sn;
    1c5a:	7ae6                	ld	s5,120(sp)
         if ((l - 1) > (stbsp__uint32)pr)
    1c5c:	5686                	lw	a3,96(sp)
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr | 0x80000000))
    1c5e:	3c0511e3          	bnez	a0,2820 <stbsp_vsprintfcb+0x1562>
         tail[0] = 0;
    1c62:	06010823          	sb	zero,112(sp)
   sign[0] = 0;
    1c66:	06010423          	sb	zero,104(sp)
   } else if (fl & STBSP__LEADINGSPACE) {
    1c6a:	004e7713          	andi	a4,t3,4
    1c6e:	6a070ee3          	beqz	a4,2b2a <stbsp_vsprintfcb+0x186c>
      sign[0] = 1;
    1c72:	6709                	lui	a4,0x2
    1c74:	0705                	addi	a4,a4,1 # 2001 <stbsp_vsprintfcb+0xd43>
    1c76:	06e11423          	sh	a4,104(sp)
         if (dp == STBSP__SPECIAL) {
    1c7a:	671d                	lui	a4,0x7
    1c7c:	1ee794e3          	bne	a5,a4,2664 <stbsp_vsprintfcb+0x13a6>
         if (pr < (stbsp__int32)l)
    1c80:	0006879b          	sext.w	a5,a3
         n = pr + lead[0] + tail[0] + tz;
    1c84:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    1c88:	fff7c793          	not	a5,a5
         n = pr + lead[0] + tail[0] + tz;
    1c8c:	07014f83          	lbu	t6,112(sp)
         if (pr < (stbsp__int32)l)
    1c90:	97fd                	srai	a5,a5,0x3f
    1c92:	8ff5                	and	a5,a5,a3
         n = pr + lead[0] + tail[0] + tz;
    1c94:	00fa073b          	addw	a4,s4,a5
    1c98:	01f7063b          	addw	a2,a4,t6
    1c9c:	8732                	mv	a4,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    1c9e:	001e7513          	andi	a0,t3,1
         if (pr < (stbsp__int32)l)
    1ca2:	2781                	sext.w	a5,a5
         if (fw < (stbsp__int32)n)
    1ca4:	835a                	mv	t1,s6
    1ca6:	00cb5363          	bge	s6,a2,1cac <stbsp_vsprintfcb+0x9ee>
    1caa:	8332                	mv	t1,a2
         fw -= n;
    1cac:	40e3033b          	subw	t1,t1,a4
            cs = 0;
    1cb0:	4281                	li	t0,0
         pr -= l;
    1cb2:	40d7873b          	subw	a4,a5,a3
      tz = 0;
    1cb6:	4881                	li	a7,0
            goto scopy;
    1cb8:	b7a1                	j	1c00 <stbsp_vsprintfcb+0x942>
         h = (f[0] == 'G') ? hexu : hex;
    1cba:	04700713          	li	a4,71
    1cbe:	00005317          	auipc	t1,0x5
    1cc2:	d9a30313          	addi	t1,t1,-614 # 6a58 <hex.0>
    1cc6:	14e783e3          	beq	a5,a4,260c <stbsp_vsprintfcb+0x134e>
         fv = va_arg(va, double);
    1cca:	008b8713          	addi	a4,s7,8
         if (pr == -1)
    1cce:	57fd                	li	a5,-1
         fv = va_arg(va, double);
    1cd0:	e0ba                	sd	a4,64(sp)
    1cd2:	000bb507          	fld	fa0,0(s7)
         if (pr == -1)
    1cd6:	12f884e3          	beq	a7,a5,25fe <stbsp_vsprintfcb+0x1340>
         else if (pr == 0)
    1cda:	6e0887e3          	beqz	a7,2bc8 <stbsp_vsprintfcb+0x190a>
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, (pr - 1) | 0x80000000))
    1cde:	fff8871b          	addiw	a4,a7,-1
    1ce2:	800007b7          	lui	a5,0x80000
    1ce6:	8f5d                	or	a4,a4,a5
    1ce8:	2701                	sext.w	a4,a4
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    1cea:	00088a9b          	sext.w	s5,a7
    1cee:	8a46                	mv	s4,a7
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, (pr - 1) | 0x80000000))
    1cf0:	10d4                	addi	a3,sp,100
    1cf2:	0110                	addi	a2,sp,128
    1cf4:	108c                	addi	a1,sp,96
    1cf6:	18a8                	addi	a0,sp,120
    1cf8:	f01e                	sd	t2,32(sp)
    1cfa:	ec1a                	sd	t1,24(sp)
    1cfc:	e872                	sd	t3,16(sp)
    1cfe:	cdcfe0ef          	jal	1da <stbsp__real_to_str>
    1d02:	6e42                	ld	t3,16(sp)
    1d04:	6362                	ld	t1,24(sp)
    1d06:	7382                	ld	t2,32(sp)
    1d08:	4281                	li	t0,0
    1d0a:	c509                	beqz	a0,1d14 <stbsp_vsprintfcb+0xa56>
            fl |= STBSP__NEGATIVE;
    1d0c:	080e6e13          	ori	t3,t3,128
    1d10:	08000293          	li	t0,128
         if (l > (stbsp__uint32)pr)
    1d14:	5806                	lw	a6,96(sp)
    1d16:	010af463          	bgeu	s5,a6,1d1e <stbsp_vsprintfcb+0xa60>
            l = pr;
    1d1a:	d0d6                	sw	s5,96(sp)
    1d1c:	8856                	mv	a6,s5
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    1d1e:	4705                	li	a4,1
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    1d20:	5796                	lw	a5,100(sp)
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    1d22:	01076463          	bltu	a4,a6,1d2a <stbsp_vsprintfcb+0xa6c>
    1d26:	1800106f          	j	2ea6 <stbsp_vsprintfcb+0x1be8>
    1d2a:	7be6                	ld	s7,120(sp)
    1d2c:	fff8071b          	addiw	a4,a6,-1
    1d30:	1702                	slli	a4,a4,0x20
    1d32:	9301                	srli	a4,a4,0x20
    1d34:	001a0e9b          	addiw	t4,s4,1
    1d38:	75e2                	ld	a1,56(sp)
    1d3a:	8ade                	mv	s5,s7
    1d3c:	975e                	add	a4,a4,s7
    1d3e:	410e8ebb          	subw	t4,t4,a6
    1d42:	88d2                	mv	a7,s4
    1d44:	86c2                	mv	a3,a6
    1d46:	4f01                	li	t5,0
    1d48:	03000f93          	li	t6,48
    1d4c:	e842                	sd	a6,16(sp)
    1d4e:	a809                	j	1d60 <stbsp_vsprintfcb+0xaa2>
            --pr;
    1d50:	38fd                	addiw	a7,a7,-1
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    1d52:	211e80e3          	beq	t4,a7,2752 <stbsp_vsprintfcb+0x1494>
    1d56:	177d                	addi	a4,a4,-1 # 6fff <_stdout+0x16f>
    1d58:	4f05                	li	t5,1
    1d5a:	1e088ce3          	beqz	a7,2752 <stbsp_vsprintfcb+0x1494>
            --l;
    1d5e:	85b6                	mv	a1,a3
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    1d60:	00074803          	lbu	a6,0(a4)
    1d64:	fff6861b          	addiw	a2,a3,-1 # ffffff <_ZSt4cerr+0xff8797>
    1d68:	0006851b          	sext.w	a0,a3
    1d6c:	2581                	sext.w	a1,a1
    1d6e:	0006069b          	sext.w	a3,a2
    1d72:	fdf80fe3          	beq	a6,t6,1d50 <stbsp_vsprintfcb+0xa92>
    1d76:	6842                	ld	a6,16(sp)
    1d78:	fc2e                	sd	a1,56(sp)
    1d7a:	86c2                	mv	a3,a6
    1d7c:	000f0463          	beqz	t5,1d84 <stbsp_vsprintfcb+0xac6>
    1d80:	d0ae                	sw	a1,96(sp)
    1d82:	86ae                	mv	a3,a1
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    1d84:	5775                	li	a4,-3
    1d86:	08e7cee3          	blt	a5,a4,2622 <stbsp_vsprintfcb+0x1364>
    1d8a:	08fa4be3          	blt	s4,a5,2620 <stbsp_vsprintfcb+0x1362>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    1d8e:	0005071b          	sext.w	a4,a0
         if (dp > 0) {
    1d92:	7ef057e3          	blez	a5,2d80 <stbsp_vsprintfcb+0x1ac2>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    1d96:	4881                	li	a7,0
    1d98:	00e7d463          	bge	a5,a4,1da0 <stbsp_vsprintfcb+0xae2>
    1d9c:	40f508bb          	subw	a7,a0,a5
         tail[0] = 0;
    1da0:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    1da4:	20029463          	bnez	t0,1fac <stbsp_vsprintfcb+0xcee>
   } else if (fl & STBSP__LEADINGSPACE) {
    1da8:	004e7713          	andi	a4,t3,4
    1dac:	000715e3          	bnez	a4,25b6 <stbsp_vsprintfcb+0x12f8>
   } else if (fl & STBSP__LEADINGPLUS) {
    1db0:	002e7713          	andi	a4,t3,2
    1db4:	660719e3          	bnez	a4,2c26 <stbsp_vsprintfcb+0x1968>
   sign[0] = 0;
    1db8:	06010423          	sb	zero,104(sp)
    1dbc:	aaed                	j	1fb6 <stbsp_vsprintfcb+0xcf8>
         h = (f[0] == 'A') ? hexu : hex;
    1dbe:	04100713          	li	a4,65
    1dc2:	00005597          	auipc	a1,0x5
    1dc6:	c9658593          	addi	a1,a1,-874 # 6a58 <hex.0>
    1dca:	00e783e3          	beq	a5,a4,25d0 <stbsp_vsprintfcb+0x1312>
         fv = va_arg(va, double);
    1dce:	008b8693          	addi	a3,s7,8
         if (pr == -1)
    1dd2:	577d                	li	a4,-1
         fv = va_arg(va, double);
    1dd4:	e0b6                	sd	a3,64(sp)
    1dd6:	000bb783          	ld	a5,0(s7)
         if (pr == -1)
    1dda:	7ee88963          	beq	a7,a4,25cc <stbsp_vsprintfcb+0x130e>
   d = value;

   STBSP__COPYFP(b, d);

   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    1dde:	4347d613          	srai	a2,a5,0x34
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    1de2:	00c79513          	slli	a0,a5,0xc
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    1de6:	7ff67613          	andi	a2,a2,2047
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    1dea:	8131                	srli	a0,a0,0xc
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    1dec:	c016061b          	addiw	a2,a2,-1023
         if (stbsp__real_to_parts((stbsp__int64 *)&n64, &dp, fv))
    1df0:	7a07c863          	bltz	a5,25a0 <stbsp_vsprintfcb+0x12e2>
   } else if (fl & STBSP__LEADINGSPACE) {
    1df4:	004e7793          	andi	a5,t3,4
    1df8:	60078ee3          	beqz	a5,2c14 <stbsp_vsprintfcb+0x1956>
    1dfc:	6789                	lui	a5,0x2
    1dfe:	2785                	addiw	a5,a5,1 # 2001 <stbsp_vsprintfcb+0xd43>
      sign[0] = 1;
    1e00:	06f11423          	sh	a5,104(sp)
    1e04:	468d                	li	a3,3
    1e06:	4a0d                	li	s4,3
    1e08:	4809                	li	a6,2
            n64 |= (((stbsp__uint64)1) << 52);
    1e0a:	4705                	li	a4,1
    1e0c:	1752                	slli	a4,a4,0x34
         if (dp == -1023)
    1e0e:	c0100793          	li	a5,-1023
            n64 |= (((stbsp__uint64)1) << 52);
    1e12:	8f49                	or	a4,a4,a0
         if (dp == -1023)
    1e14:	5cf600e3          	beq	a2,a5,2bd4 <stbsp_vsprintfcb+0x1916>
         if (pr < 15)
    1e18:	4539                	li	a0,14
         n64 <<= (64 - 56);
    1e1a:	00871793          	slli	a5,a4,0x8
         if (pr < 15)
    1e1e:	251546e3          	blt	a0,a7,286a <stbsp_vsprintfcb+0x15ac>
            n64 += ((((stbsp__uint64)8) << 56) >> (pr * 4));
    1e22:	4705                	li	a4,1
    1e24:	0028951b          	slliw	a0,a7,0x2
    1e28:	176e                	slli	a4,a4,0x3b
    1e2a:	00a75733          	srl	a4,a4,a0
    1e2e:	973e                	add	a4,a4,a5
         *s++ = h[(n64 >> 60) & 15];
    1e30:	03c75793          	srli	a5,a4,0x3c
    1e34:	97ae                	add	a5,a5,a1
    1e36:	0007c503          	lbu	a0,0(a5)
         lead[1 + lead[0]] = '0';
    1e3a:	22080793          	addi	a5,a6,544
    1e3e:	06010813          	addi	a6,sp,96
    1e42:	97c2                	add	a5,a5,a6
    1e44:	03000813          	li	a6,48
    1e48:	df078423          	sb	a6,-536(a5)
         lead[2 + lead[0]] = 'x';
    1e4c:	22068793          	addi	a5,a3,544
    1e50:	1094                	addi	a3,sp,96
    1e52:	96be                	add	a3,a3,a5
    1e54:	07800793          	li	a5,120
    1e58:	def68423          	sb	a5,-536(a3)
         lead[0] += 2;
    1e5c:	07410423          	sb	s4,104(sp)
         *s++ = h[(n64 >> 60) & 15];
    1e60:	0ca10023          	sb	a0,192(sp)
         if (pr)
    1e64:	740893e3          	bnez	a7,2daa <stbsp_vsprintfcb+0x1aec>
         sn = s;
    1e68:	0c110793          	addi	a5,sp,193
    1e6c:	fcbe                	sd	a5,120(sp)
    1e6e:	4701                	li	a4,0
    1e70:	4501                	li	a0,0
    1e72:	4305                	li	t1,1
    1e74:	4685                	li	a3,1
         tail[1] = h[17];
    1e76:	0115c583          	lbu	a1,17(a1)
            tail[2] = '+';
    1e7a:	02b00793          	li	a5,43
         tail[1] = h[17];
    1e7e:	06b108a3          	sb	a1,113(sp)
         if (dp < 0) {
    1e82:	00065663          	bgez	a2,1e8e <stbsp_vsprintfcb+0xbd0>
            dp = -dp;
    1e86:	40c0063b          	negw	a2,a2
            tail[2] = '-';
    1e8a:	02d00793          	li	a5,45
            tail[n] = '0' + dp % 10;
    1e8e:	4829                	li	a6,10
    1e90:	030665bb          	remw	a1,a2,a6
    1e94:	06f10923          	sb	a5,114(sp)
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    1e98:	3e700e93          	li	t4,999
            tail[n] = '0' + dp % 10;
    1e9c:	0305859b          	addiw	a1,a1,48
    1ea0:	0ff5f593          	zext.b	a1,a1
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    1ea4:	18cec3e3          	blt	t4,a2,282a <stbsp_vsprintfcb+0x156c>
    1ea8:	06300e93          	li	t4,99
    1eac:	54cec1e3          	blt	t4,a2,2bee <stbsp_vsprintfcb+0x1930>
    1eb0:	4ea5                	li	t4,9
    1eb2:	72ced6e3          	bge	t4,a2,2dde <stbsp_vsprintfcb+0x1b20>
            dp /= 10;
    1eb6:	030647bb          	divw	a5,a2,a6
         tail[0] = (char)n;
    1eba:	4611                	li	a2,4
    1ebc:	06c10823          	sb	a2,112(sp)
            tail[n] = '0' + dp % 10;
    1ec0:	06b10a23          	sb	a1,116(sp)
    1ec4:	4811                	li	a6,4
    1ec6:	4f91                	li	t6,4
    1ec8:	0307879b          	addiw	a5,a5,48
    1ecc:	06f109a3          	sb	a5,115(sp)
         n = pr + lead[0] + tail[0] + tz;
    1ed0:	006a07bb          	addw	a5,s4,t1
    1ed4:	010787bb          	addw	a5,a5,a6
    1ed8:	0117863b          	addw	a2,a5,a7
         dp = (int)(s - sn);
    1edc:	d2aa                	sw	a0,100(sp)
         l = (int)(s - (num + 64));
    1ede:	d0b6                	sw	a3,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    1ee0:	87b2                	mv	a5,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    1ee2:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    1ee6:	835a                	mv	t1,s6
    1ee8:	00cb5363          	bge	s6,a2,1eee <stbsp_vsprintfcb+0xc30>
    1eec:	8332                	mv	t1,a2
         cs = 1 + (3 << 24);
    1eee:	030002b7          	lui	t0,0x3000
         fw -= n;
    1ef2:	40f3033b          	subw	t1,t1,a5
         cs = 1 + (3 << 24);
    1ef6:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff8799>
         s = num + 64;
    1ef8:	0c010a93          	addi	s5,sp,192
         goto scopy;
    1efc:	b311                	j	1c00 <stbsp_vsprintfcb+0x942>
         h = (f[0] == 'B') ? hexu : hex;
    1efe:	04200713          	li	a4,66
    1f02:	00005817          	auipc	a6,0x5
    1f06:	b5680813          	addi	a6,a6,-1194 # 6a58 <hex.0>
    1f0a:	6ce78963          	beq	a5,a4,25dc <stbsp_vsprintfcb+0x131e>
         if (fl & STBSP__LEADING_0X) {
    1f0e:	008e7793          	andi	a5,t3,8
    1f12:	66079e63          	bnez	a5,258e <stbsp_vsprintfcb+0x12d0>
         lead[0] = 0;
    1f16:	06010423          	sb	zero,104(sp)
         l = (8 << 4) | (1 << 8);
    1f1a:	18000793          	li	a5,384
    1f1e:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__INTMAX) {
    1f20:	020e7713          	andi	a4,t3,32
         goto radixnum;
    1f24:	b979                	j	1bc2 <stbsp_vsprintfcb+0x904>
         *s = (char)va_arg(va, int);
    1f26:	000ba783          	lw	a5,0(s7)
         l = 1;
    1f2a:	4705                	li	a4,1
    1f2c:	d0ba                	sw	a4,96(sp)
         *s = (char)va_arg(va, int);
    1f2e:	26f10fa3          	sb	a5,639(sp)
    1f32:	008b8793          	addi	a5,s7,8
         lead[0] = 0;
    1f36:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    1f3a:	06010823          	sb	zero,112(sp)
         dp = 0;
    1f3e:	d282                	sw	zero,100(sp)
         *s = (char)va_arg(va, int);
    1f40:	e0be                	sd	a5,64(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    1f42:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    1f46:	835a                	mv	t1,s6
    1f48:	69605063          	blez	s6,25c8 <stbsp_vsprintfcb+0x130a>
         fw -= n;
    1f4c:	337d                	addiw	t1,t1,-1
         goto scopy;
    1f4e:	4701                	li	a4,0
    1f50:	4f81                	li	t6,0
    1f52:	4685                	li	a3,1
    1f54:	4a01                	li	s4,0
         cs = 0;
    1f56:	4281                	li	t0,0
         s = num + STBSP__NUMSZ - 1;
    1f58:	27f10a93          	addi	s5,sp,639
      tz = 0;
    1f5c:	4881                	li	a7,0
         goto scopy;
    1f5e:	b14d                	j	1c00 <stbsp_vsprintfcb+0x942>
         fv = va_arg(va, double);
    1f60:	008b8713          	addi	a4,s7,8
         if (fl & STBSP__METRIC_SUFFIX) {
    1f64:	100e7793          	andi	a5,t3,256
         fv = va_arg(va, double);
    1f68:	e0ba                	sd	a4,64(sp)
    1f6a:	000bb507          	fld	fa0,0(s7)
         if (fl & STBSP__METRIC_SUFFIX) {
    1f6e:	be0795e3          	bnez	a5,1b58 <stbsp_vsprintfcb+0x89a>
         if (pr == -1)
    1f72:	57fd                	li	a5,-1
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    1f74:	0008871b          	sext.w	a4,a7
         if (pr == -1)
    1f78:	00f89463          	bne	a7,a5,1f80 <stbsp_vsprintfcb+0xcc2>
    1f7c:	4719                	li	a4,6
            pr = 6; // default is 6
    1f7e:	4899                	li	a7,6
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    1f80:	10d4                	addi	a3,sp,100
    1f82:	0110                	addi	a2,sp,128
    1f84:	108c                	addi	a1,sp,96
    1f86:	18a8                	addi	a0,sp,120
    1f88:	f01e                	sd	t2,32(sp)
    1f8a:	ec72                	sd	t3,24(sp)
    1f8c:	e846                	sd	a7,16(sp)
    1f8e:	a4cfe0ef          	jal	1da <stbsp__real_to_str>
    1f92:	6e62                	ld	t3,24(sp)
    1f94:	68c2                	ld	a7,16(sp)
    1f96:	7382                	ld	t2,32(sp)
         if (dp == STBSP__SPECIAL) {
    1f98:	5796                	lw	a5,100(sp)
            if ((stbsp__int32)(l + n) > pr)
    1f9a:	5686                	lw	a3,96(sp)
   if (fl & STBSP__NEGATIVE) {
    1f9c:	080e7293          	andi	t0,t3,128
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    1fa0:	e00500e3          	beqz	a0,1da0 <stbsp_vsprintfcb+0xae2>
            fl |= STBSP__NEGATIVE;
    1fa4:	080e6e13          	ori	t3,t3,128
         tail[0] = 0;
    1fa8:	06010823          	sb	zero,112(sp)
      sign[0] = 1;
    1fac:	670d                	lui	a4,0x3
    1fae:	d0170713          	addi	a4,a4,-767 # 2d01 <stbsp_vsprintfcb+0x1a43>
    1fb2:	06e11423          	sh	a4,104(sp)
         if (dp == STBSP__SPECIAL) {
    1fb6:	671d                	lui	a4,0x7
    1fb8:	7ce78963          	beq	a5,a4,278a <stbsp_vsprintfcb+0x14cc>
         if (dp <= 0) {
    1fbc:	46f05fe3          	blez	a5,2c3a <stbsp_vsprintfcb+0x197c>
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((600 - (stbsp__uint32)dp) % 3) : 0;
    1fc0:	040e7313          	andi	t1,t3,64
    1fc4:	00078e9b          	sext.w	t4,a5
    1fc8:	4581                	li	a1,0
    1fca:	00030963          	beqz	t1,1fdc <stbsp_vsprintfcb+0xd1e>
    1fce:	25800593          	li	a1,600
    1fd2:	41d585bb          	subw	a1,a1,t4
    1fd6:	470d                	li	a4,3
    1fd8:	02e5f5bb          	remuw	a1,a1,a4
                     *s++ = stbsp__comma;
    1fdc:	00005a17          	auipc	s4,0x5
    1fe0:	994a0a13          	addi	s4,s4,-1644 # 6970 <stbsp__digitpair>
            s = (char *)sn;
    1fe4:	7f66                	ld	t5,120(sp)
                     *s++ = stbsp__comma;
    1fe6:	0cda4283          	lbu	t0,205(s4)
         s = num + 64;
    1fea:	0c010a93          	addi	s5,sp,192
            if ((stbsp__uint32)dp >= l) {
    1fee:	44defb63          	bgeu	t4,a3,2444 <stbsp_vsprintfcb+0x1186>
               n = 0;
    1ff2:	4501                	li	a0,0
         s = num + 64;
    1ff4:	8756                	mv	a4,s5
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    1ff6:	4b91                	li	s7,4
    1ff8:	a015                	j	201c <stbsp_vsprintfcb+0xd5e>
    1ffa:	8642                	mv	a2,a6
    1ffc:	883a                	mv	a6,a4
    1ffe:	8732                	mv	a4,a2
                     *s++ = sn[n];
    2000:	02051613          	slli	a2,a0,0x20
    2004:	9201                	srli	a2,a2,0x20
    2006:	967a                	add	a2,a2,t5
    2008:	00064f83          	lbu	t6,0(a2)
                     ++n;
    200c:	0015061b          	addiw	a2,a0,1
    2010:	0006051b          	sext.w	a0,a2
                     *s++ = sn[n];
    2014:	fff70fa3          	sb	t6,-1(a4) # 6fff <_stdout+0x16f>
                     if (n >= (stbsp__uint32)dp)
    2018:	7bd57563          	bgeu	a0,t4,27c2 <stbsp_vsprintfcb+0x1504>
                     *s++ = stbsp__comma;
    201c:	00170813          	addi	a6,a4,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2020:	fc030de3          	beqz	t1,1ffa <stbsp_vsprintfcb+0xd3c>
    2024:	2585                	addiw	a1,a1,1
    2026:	fd759ae3          	bne	a1,s7,1ffa <stbsp_vsprintfcb+0xd3c>
                     *s++ = stbsp__comma;
    202a:	fe580fa3          	sb	t0,-1(a6)
    202e:	0709                	addi	a4,a4,2
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2030:	4585                	li	a1,1
    2032:	b7f9                	j	2000 <stbsp_vsprintfcb+0xd42>
         *d = tlen + (int)(bf - buf);
    2034:	000bb703          	ld	a4,0(s7)
    2038:	412407b3          	sub	a5,s0,s2
    203c:	01a787bb          	addw	a5,a5,s10
         int *d = va_arg(va, int *);
    2040:	008b8693          	addi	a3,s7,8
    2044:	e0b6                	sd	a3,64(sp)
         *d = tlen + (int)(bf - buf);
    2046:	c31c                	sw	a5,0(a4)
      } break;
    2048:	bae5                	j	1a40 <stbsp_vsprintfcb+0x782>
         if (fl & STBSP__LEADING_0X) {
    204a:	008e7793          	andi	a5,t3,8
    204e:	50079b63          	bnez	a5,2564 <stbsp_vsprintfcb+0x12a6>
         lead[0] = 0;
    2052:	06010423          	sb	zero,104(sp)
         l = (3 << 4) | (3 << 8);
    2056:	33000793          	li	a5,816
    205a:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__INTMAX) {
    205c:	020e7713          	andi	a4,t3,32
         h = hexu;
    2060:	00005817          	auipc	a6,0x5
    2064:	9e080813          	addi	a6,a6,-1568 # 6a40 <hexu.1>
         goto radixnum;
    2068:	bea9                	j	1bc2 <stbsp_vsprintfcb+0x904>
         fl &= ~STBSP__LEADINGZERO; // 'p' only prints the pointer with zeros
    206a:	fefe7e13          	andi	t3,t3,-17
    206e:	020e6e13          	ori	t3,t3,32
    2072:	02000713          	li	a4,32
         pr = sizeof(void *) * 2;
    2076:	48c1                	li	a7,16
         h = (f[0] == 'X') ? hexu : hex;
    2078:	00005817          	auipc	a6,0x5
    207c:	9e080813          	addi	a6,a6,-1568 # 6a58 <hex.0>
    2080:	be05                	j	1bb0 <stbsp_vsprintfcb+0x8f2>
         s = va_arg(va, char *);
    2082:	000bba83          	ld	s5,0(s7)
    2086:	008b8793          	addi	a5,s7,8
    208a:	e0be                	sd	a5,64(sp)
         if (s == 0)
    208c:	360a8ee3          	beqz	s5,2c08 <stbsp_vsprintfcb+0x194a>
      if (((stbsp__uintptr)sn & 3) == 0)
    2090:	003af793          	andi	a5,s5,3
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    2094:	5208c663          	bltz	a7,25c0 <stbsp_vsprintfcb+0x1302>
    2098:	0008869b          	sext.w	a3,a7
      if (((stbsp__uintptr)sn & 3) == 0)
    209c:	2a0782e3          	beqz	a5,2b40 <stbsp_vsprintfcb+0x1882>
      if (!limit || *sn == 0)
    20a0:	5a068b63          	beqz	a3,2656 <stbsp_vsprintfcb+0x1398>
      if (((stbsp__uintptr)sn & 3) == 0)
    20a4:	87d6                	mv	a5,s5
    20a6:	a801                	j	20b6 <stbsp_vsprintfcb+0xdf8>
      ++sn;
    20a8:	0785                	addi	a5,a5,1
      if (((stbsp__uintptr)sn & 3) == 0)
    20aa:	0037f713          	andi	a4,a5,3
      --limit;
    20ae:	36fd                	addiw	a3,a3,-1
      if (((stbsp__uintptr)sn & 3) == 0)
    20b0:	280709e3          	beqz	a4,2b42 <stbsp_vsprintfcb+0x1884>
      if (!limit || *sn == 0)
    20b4:	c681                	beqz	a3,20bc <stbsp_vsprintfcb+0xdfe>
    20b6:	0007c703          	lbu	a4,0(a5)
    20ba:	f77d                	bnez	a4,20a8 <stbsp_vsprintfcb+0xdea>
         return (stbsp__uint32)(sn - s);
    20bc:	415787b3          	sub	a5,a5,s5
    20c0:	0007869b          	sext.w	a3,a5
         if (pr < (stbsp__int32)l)
    20c4:	fff6c713          	not	a4,a3
    20c8:	977d                	srai	a4,a4,0x3f
    20ca:	8f7d                	and	a4,a4,a5
    20cc:	0007079b          	sext.w	a5,a4
         n = pr + lead[0] + tail[0] + tz;
    20d0:	863e                	mv	a2,a5
         pr -= l;
    20d2:	9f15                	subw	a4,a4,a3
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    20d4:	d0b6                	sw	a3,96(sp)
         lead[0] = 0;
    20d6:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    20da:	06010823          	sb	zero,112(sp)
         dp = 0;
    20de:	d282                	sw	zero,100(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    20e0:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    20e4:	835a                	mv	t1,s6
    20e6:	00fb5363          	bge	s6,a5,20ec <stbsp_vsprintfcb+0xe2e>
    20ea:	833e                	mv	t1,a5
         fw -= n;
    20ec:	40c3033b          	subw	t1,t1,a2
         goto scopy;
    20f0:	4f81                	li	t6,0
    20f2:	4a01                	li	s4,0
         cs = 0;
    20f4:	4281                	li	t0,0
      tz = 0;
    20f6:	4881                	li	a7,0
         goto scopy;
    20f8:	b621                	j	1c00 <stbsp_vsprintfcb+0x942>
                     *bf++ = stbsp__comma;
    20fa:	87b2                	mv	a5,a2
                     cs = 0;
    20fc:	4a01                	li	s4,0
    20fe:	e44ff06f          	j	1742 <stbsp_vsprintfcb+0x484>
               lead[0] -= (char)i;
    2102:	06010423          	sb	zero,104(sp)
               while (i) {
    2106:	d38ff06f          	j	163e <stbsp_vsprintfcb+0x380>
            lead[0] -= (char)i;
    210a:	06010423          	sb	zero,104(sp)
            while (i) {
    210e:	ed8ff06f          	j	17e6 <stbsp_vsprintfcb+0x528>
            while (i >= 4) {
    2112:	06fadc63          	bge	s5,a5,218a <stbsp_vsprintfcb+0xecc>
            tz -= i;
    2116:	8722                	mv	a4,s0
    2118:	0007851b          	sext.w	a0,a5
            while (i >= 4) {
    211c:	008785bb          	addw	a1,a5,s0
               *(stbsp__uint32 *)bf = 0x30303030;
    2120:	01672023          	sw	s6,0(a4)
               bf += 4;
    2124:	0711                	addi	a4,a4,4
            while (i >= 4) {
    2126:	40e5863b          	subw	a2,a1,a4
    212a:	fecacbe3          	blt	s5,a2,2120 <stbsp_vsprintfcb+0xe62>
    212e:	ffc5061b          	addiw	a2,a0,-4
    2132:	0026561b          	srliw	a2,a2,0x2
    2136:	0016071b          	addiw	a4,a2,1
    213a:	37f1                	addiw	a5,a5,-4
    213c:	0026161b          	slliw	a2,a2,0x2
    2140:	070a                	slli	a4,a4,0x2
    2142:	9722                	add	a4,a4,s0
    2144:	9f91                	subw	a5,a5,a2
            while (i) {
    2146:	843a                	mv	s0,a4
    2148:	80078de3          	beqz	a5,1962 <stbsp_vsprintfcb+0x6a4>
    214c:	1782                	slli	a5,a5,0x20
    214e:	9381                	srli	a5,a5,0x20
    2150:	00f70433          	add	s0,a4,a5
               *bf++ = '0';
    2154:	0705                	addi	a4,a4,1
    2156:	ff470fa3          	sb	s4,-1(a4)
            while (i) {
    215a:	fe871de3          	bne	a4,s0,2154 <stbsp_vsprintfcb+0xe96>
    215e:	805ff06f          	j	1962 <stbsp_vsprintfcb+0x6a4>
               stbsp__cb_buf_clamp(i, pr);
    2162:	85ce                	mv	a1,s3
               if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    2164:	4981                	li	s3,0
    2166:	dc049263          	bnez	s1,172a <stbsp_vsprintfcb+0x46c>
    216a:	b8d5                	j	1a5e <stbsp_vsprintfcb+0x7a0>
            STBSP__UNALIGNED(while (i >= 4) {
    216c:	4401                	li	s0,0
    216e:	85be                	mv	a1,a5
    2170:	f0ea4b63          	blt	s4,a4,1886 <stbsp_vsprintfcb+0x5c8>
    2174:	f42ff06f          	j	18b6 <stbsp_vsprintfcb+0x5f8>
               if ((((stbsp__uintptr)bf) & 3) == 0)
    2178:	00347713          	andi	a4,s0,3
            stbsp__cb_buf_clamp(i, tz);
    217c:	87c6                	mv	a5,a7
            tz -= i;
    217e:	4881                	li	a7,0
               if ((((stbsp__uintptr)bf) & 3) == 0)
    2180:	fc071c63          	bnez	a4,1958 <stbsp_vsprintfcb+0x69a>
            while (i >= 4) {
    2184:	470d                	li	a4,3
    2186:	f8f748e3          	blt	a4,a5,2116 <stbsp_vsprintfcb+0xe58>
    218a:	8722                	mv	a4,s0
    218c:	b7c1                	j	214c <stbsp_vsprintfcb+0xe8e>
            tail[0] -= (char)i;
    218e:	06010823          	sb	zero,112(sp)
            while (i) {
    2192:	b0b9                	j	19e0 <stbsp_vsprintfcb+0x722>
                  while (i >= 4) {
    2194:	478d                	li	a5,3
    2196:	8622                	mv	a2,s0
    2198:	d8b7d963          	bge	a5,a1,172a <stbsp_vsprintfcb+0x46c>
    219c:	ffc5839b          	addiw	t2,a1,-4
    21a0:	0023d79b          	srliw	a5,t2,0x2
    21a4:	0017859b          	addiw	a1,a5,1
    21a8:	058a                	slli	a1,a1,0x2
    21aa:	942e                	add	s0,s0,a1
                     *(stbsp__uint32 *)bf = 0x30303030;
    21ac:	01762023          	sw	s7,0(a2)
                     bf += 4;
    21b0:	0611                	addi	a2,a2,4
                  while (i >= 4) {
    21b2:	fe861de3          	bne	a2,s0,21ac <stbsp_vsprintfcb+0xeee>
    21b6:	0027979b          	slliw	a5,a5,0x2
    21ba:	40f385bb          	subw	a1,t2,a5
    21be:	d68ff06f          	j	1726 <stbsp_vsprintfcb+0x468>
            while (i) {
    21c2:	85be                	mv	a1,a5
    21c4:	ee071963          	bnez	a4,18b6 <stbsp_vsprintfcb+0x5f8>
    21c8:	f16ff06f          	j	18de <stbsp_vsprintfcb+0x620>
    21cc:	2c013a03          	ld	s4,704(sp)
    21d0:	2b813a83          	ld	s5,696(sp)
    21d4:	2b013b03          	ld	s6,688(sp)
    21d8:	8ca2                	mv	s9,s0
    21da:	a04ff06f          	j	13de <stbsp_vsprintfcb+0x120>
            stbsp__chk_cb_buf(1);
    21de:	2601                	sext.w	a2,a2
    21e0:	1fe00793          	li	a5,510
    21e4:	f8c7c563          	blt	a5,a2,196e <stbsp_vsprintfcb+0x6b0>
    21e8:	f3eff06f          	j	1926 <stbsp_vsprintfcb+0x668>
               fl &= ~STBSP__TRIPLET_COMMA; // if no leading zeros, then no commas
    21ec:	fbfe7e13          	andi	t3,t3,-65
         if (fw + pr) {
    21f0:	006707bb          	addw	a5,a4,t1
               fl &= ~STBSP__TRIPLET_COMMA; // if no leading zeros, then no commas
    21f4:	2e01                	sext.w	t3,t3
         if (fw + pr) {
    21f6:	a0078be3          	beqz	a5,1c0c <stbsp_vsprintfcb+0x94e>
               while (fw > 0) {
    21fa:	be605663          	blez	t1,15e6 <stbsp_vsprintfcb+0x328>
                     *(stbsp__uint32 *)bf = 0x20202020;
    21fe:	20202837          	lui	a6,0x20202
                  stbsp__cb_buf_clamp(i, fw);
    2202:	854a                	mv	a0,s2
    2204:	894e                	mv	s2,s3
    2206:	69a2                	ld	s3,8(sp)
                     *(stbsp__uint32 *)bf = 0x20202020;
    2208:	02080813          	addi	a6,a6,32 # 20202020 <_ZSt4cerr+0x201fa7b8>
                  stbsp__cb_buf_clamp(i, fw);
    220c:	ec52                	sd	s4,24(sp)
    220e:	f426                	sd	s1,40(sp)
    2210:	87a2                	mv	a5,s0
    2212:	84ea                	mv	s1,s10
                  stbsp__chk_cb_buf(1);
    2214:	1fe00f13          	li	t5,510
                  stbsp__cb_buf_clamp(i, fw);
    2218:	8d6e                	mv	s10,s11
                     *bf++ = ' ';
    221a:	02000b13          	li	s6,32
                  stbsp__cb_buf_clamp(i, fw);
    221e:	8de6                	mv	s11,s9
                  while (i >= 4) {
    2220:	4b8d                	li	s7,3
                  stbsp__cb_buf_clamp(i, fw);
    2222:	20000e93          	li	t4,512
    2226:	e846                	sd	a7,16(sp)
    2228:	f07e                	sd	t6,32(sp)
    222a:	f836                	sd	a3,48(sp)
    222c:	e4f2                	sd	t3,72(sp)
    222e:	e8ba                	sd	a4,80(sp)
    2230:	ec96                	sd	t0,88(sp)
    2232:	841a                	mv	s0,t1
    2234:	8a42                	mv	s4,a6
    2236:	8c9e                	mv	s9,t2
    2238:	0c090063          	beqz	s2,22f8 <stbsp_vsprintfcb+0x103a>
    223c:	40a78633          	sub	a2,a5,a0
    2240:	40ce873b          	subw	a4,t4,a2
    2244:	86ba                	mv	a3,a4
    2246:	00e45363          	bge	s0,a4,224c <stbsp_vsprintfcb+0xf8e>
    224a:	86a2                	mv	a3,s0
    224c:	0006871b          	sext.w	a4,a3
                  fw -= i;
    2250:	9c15                	subw	s0,s0,a3
                  while (i) {
    2252:	e719                	bnez	a4,2260 <stbsp_vsprintfcb+0xfa2>
    2254:	a095                	j	22b8 <stbsp_vsprintfcb+0xffa>
                     *bf++ = ' ';
    2256:	01678023          	sb	s6,0(a5)
                     --i;
    225a:	377d                	addiw	a4,a4,-1
                     *bf++ = ' ';
    225c:	0785                	addi	a5,a5,1
                  while (i) {
    225e:	cb29                	beqz	a4,22b0 <stbsp_vsprintfcb+0xff2>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    2260:	0037f693          	andi	a3,a5,3
    2264:	faed                	bnez	a3,2256 <stbsp_vsprintfcb+0xf98>
                  while (i >= 4) {
    2266:	86be                	mv	a3,a5
    2268:	00070f9b          	sext.w	t6,a4
    226c:	00f705bb          	addw	a1,a4,a5
    2270:	02ebd763          	bge	s7,a4,229e <stbsp_vsprintfcb+0xfe0>
                     *(stbsp__uint32 *)bf = 0x20202020;
    2274:	0146a023          	sw	s4,0(a3)
                     bf += 4;
    2278:	0691                	addi	a3,a3,4
                  while (i >= 4) {
    227a:	40d5863b          	subw	a2,a1,a3
    227e:	fecbcbe3          	blt	s7,a2,2274 <stbsp_vsprintfcb+0xfb6>
    2282:	ffcf861b          	addiw	a2,t6,-4 # fffffffff7fffffc <_ZSt4cerr+0xfffffffff7ff8794>
    2286:	0026561b          	srliw	a2,a2,0x2
    228a:	0016069b          	addiw	a3,a2,1
    228e:	3771                	addiw	a4,a4,-4
    2290:	0026161b          	slliw	a2,a2,0x2
    2294:	068a                	slli	a3,a3,0x2
    2296:	96be                	add	a3,a3,a5
    2298:	9f11                	subw	a4,a4,a2
                  while (i) {
    229a:	87b6                	mv	a5,a3
    229c:	cb11                	beqz	a4,22b0 <stbsp_vsprintfcb+0xff2>
    229e:	1702                	slli	a4,a4,0x20
    22a0:	9301                	srli	a4,a4,0x20
    22a2:	00e687b3          	add	a5,a3,a4
                     *bf++ = ' ';
    22a6:	0685                	addi	a3,a3,1
    22a8:	ff668fa3          	sb	s6,-1(a3)
                  while (i) {
    22ac:	fef69de3          	bne	a3,a5,22a6 <stbsp_vsprintfcb+0xfe8>
                  stbsp__chk_cb_buf(1);
    22b0:	40a78633          	sub	a2,a5,a0
    22b4:	00090e63          	beqz	s2,22d0 <stbsp_vsprintfcb+0x1012>
    22b8:	2601                	sext.w	a2,a2
    22ba:	00cf5b63          	bge	t5,a2,22d0 <stbsp_vsprintfcb+0x1012>
    22be:	85ce                	mv	a1,s3
    22c0:	9cb1                	addw	s1,s1,a2
    22c2:	9902                	jalr	s2
    22c4:	c541                	beqz	a0,234c <stbsp_vsprintfcb+0x108e>
    22c6:	87aa                	mv	a5,a0
    22c8:	20000e93          	li	t4,512
    22cc:	1fe00f13          	li	t5,510
               while (fw > 0) {
    22d0:	f68044e3          	bgtz	s0,2238 <stbsp_vsprintfcb+0xf7a>
    22d4:	8322                	mv	t1,s0
    22d6:	89ca                	mv	s3,s2
    22d8:	83e6                	mv	t2,s9
    22da:	68c2                	ld	a7,16(sp)
    22dc:	8cee                	mv	s9,s11
    22de:	6a62                	ld	s4,24(sp)
    22e0:	8dea                	mv	s11,s10
    22e2:	7f82                	ld	t6,32(sp)
    22e4:	8d26                	mv	s10,s1
    22e6:	76c2                	ld	a3,48(sp)
    22e8:	6e26                	ld	t3,72(sp)
    22ea:	6746                	ld	a4,80(sp)
    22ec:	62e6                	ld	t0,88(sp)
    22ee:	74a2                	ld	s1,40(sp)
    22f0:	892a                	mv	s2,a0
    22f2:	843e                	mv	s0,a5
    22f4:	af2ff06f          	j	15e6 <stbsp_vsprintfcb+0x328>
                  stbsp__cb_buf_clamp(i, fw);
    22f8:	8722                	mv	a4,s0
    22fa:	4401                	li	s0,0
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    22fc:	b795                	j	2260 <stbsp_vsprintfcb+0xfa2>
            n64 = va_arg(va, stbsp__uint32);
    22fe:	000be683          	lwu	a3,0(s7)
    2302:	b0f9                	j	1bd0 <stbsp_vsprintfcb+0x912>
    2304:	2c013a03          	ld	s4,704(sp)
    2308:	2b813a83          	ld	s5,696(sp)
    230c:	2b013b03          	ld	s6,688(sp)
    2310:	8cca                	mv	s9,s2
    2312:	8ccff06f          	j	13de <stbsp_vsprintfcb+0x120>
    2316:	8cd6                	mv	s9,s5
    2318:	2c013a03          	ld	s4,704(sp)
    231c:	2b813a83          	ld	s5,696(sp)
    2320:	2b013b03          	ld	s6,688(sp)
    2324:	8baff06f          	j	13de <stbsp_vsprintfcb+0x120>
    2328:	2c013a03          	ld	s4,704(sp)
    232c:	2b813a83          	ld	s5,696(sp)
    2330:	2b013b03          	ld	s6,688(sp)
    2334:	8cea                	mv	s9,s10
    2336:	8a8ff06f          	j	13de <stbsp_vsprintfcb+0x120>
                  while (i) {
    233a:	85a2                	mv	a1,s0
    233c:	c12ff06f          	j	174e <stbsp_vsprintfcb+0x490>
                  while (i >= 4) {
    2340:	478d                	li	a5,3
    2342:	8622                	mv	a2,s0
    2344:	e4b7cce3          	blt	a5,a1,219c <stbsp_vsprintfcb+0xede>
    2348:	be2ff06f          	j	172a <stbsp_vsprintfcb+0x46c>
    234c:	2c013a03          	ld	s4,704(sp)
    2350:	2b813a83          	ld	s5,696(sp)
    2354:	2b013b03          	ld	s6,688(sp)
    2358:	8ca6                	mv	s9,s1
    235a:	884ff06f          	j	13de <stbsp_vsprintfcb+0x120>
            lead[2] = h[16];
    235e:	01084683          	lbu	a3,16(a6)
            lead[0] = 2;
    2362:	678d                	lui	a5,0x3
    2364:	0789                	addi	a5,a5,2 # 3002 <sprintf+0xc>
    2366:	06f11423          	sh	a5,104(sp)
            lead[2] = h[16];
    236a:	06d10523          	sb	a3,106(sp)
    236e:	b891                	j	1bc2 <stbsp_vsprintfcb+0x904>
    2370:	8cea                	mv	s9,s10
    2372:	86cff06f          	j	13de <stbsp_vsprintfcb+0x120>
    2376:	4f81                	li	t6,0
    2378:	4a01                	li	s4,0
    237a:	5586                	lw	a1,96(sp)
                  *--s = stbsp__comma;
    237c:	00004f17          	auipc	t5,0x4
    2380:	6c1f4f03          	lbu	t5,1729(t5) # 6a3d <stbsp__comma>
    2384:	0510                	addi	a2,sp,640
    2386:	0085d71b          	srliw	a4,a1,0x8
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    238a:	4305                	li	t1,1
            if (fl & STBSP__TRIPLET_COMMA) {
    238c:	040e7e93          	andi	t4,t3,64
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    2390:	0007029b          	sext.w	t0,a4
    2394:	005317bb          	sllw	a5,t1,t0
    2398:	37fd                	addiw	a5,a5,-1
    239a:	8ff5                	and	a5,a5,a3
    239c:	97c2                	add	a5,a5,a6
    239e:	0007c783          	lbu	a5,0(a5)
            n64 >>= (l >> 8);
    23a2:	0056d6b3          	srl	a3,a3,t0
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    23a6:	fff60a93          	addi	s5,a2,-1
    23aa:	fef60fa3          	sb	a5,-1(a2)
            if (!((n64) || ((stbsp__int32)((num + STBSP__NUMSZ) - s) < pr)))
    23ae:	e691                	bnez	a3,23ba <stbsp_vsprintfcb+0x10fc>
    23b0:	051c                	addi	a5,sp,640
    23b2:	415787bb          	subw	a5,a5,s5
    23b6:	0317dd63          	bge	a5,a7,23f0 <stbsp_vsprintfcb+0x1132>
            if (fl & STBSP__TRIPLET_COMMA) {
    23ba:	020e8963          	beqz	t4,23ec <stbsp_vsprintfcb+0x112e>
               ++l;
    23be:	0015879b          	addiw	a5,a1,1
               if ((l & 15) == ((l >> 4) & 15)) {
    23c2:	0047d29b          	srliw	t0,a5,0x4
    23c6:	00f2c2b3          	xor	t0,t0,a5
    23ca:	00f2f293          	andi	t0,t0,15
               ++l;
    23ce:	0007859b          	sext.w	a1,a5
               if ((l & 15) == ((l >> 4) & 15)) {
    23d2:	0087d71b          	srliw	a4,a5,0x8
    23d6:	00029b63          	bnez	t0,23ec <stbsp_vsprintfcb+0x112e>
                  l &= ~15;
    23da:	9bc1                	andi	a5,a5,-16
    23dc:	0007859b          	sext.w	a1,a5
                  *--s = stbsp__comma;
    23e0:	ffe60a93          	addi	s5,a2,-2
    23e4:	ffe60f23          	sb	t5,-2(a2)
    23e8:	0087d71b          	srliw	a4,a5,0x8
    23ec:	8656                	mv	a2,s5
    23ee:	b74d                	j	2390 <stbsp_vsprintfcb+0x10d2>
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    23f0:	0045d29b          	srliw	t0,a1,0x4
    23f4:	0f0006b7          	lui	a3,0xf000
         if (pr < (stbsp__int32)l)
    23f8:	0007871b          	sext.w	a4,a5
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    23fc:	0182929b          	slliw	t0,t0,0x18
    2400:	00d2f2b3          	and	t0,t0,a3
         n = pr + lead[0] + tail[0] + tz;
    2404:	00ef863b          	addw	a2,t6,a4
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    2408:	d0be                	sw	a5,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    240a:	8fb2                	mv	t6,a2
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    240c:	86be                	mv	a3,a5
    240e:	00f282bb          	addw	t0,t0,a5
         if (fw < (stbsp__int32)n)
    2412:	835a                	mv	t1,s6
    2414:	00cb5363          	bge	s6,a2,241a <stbsp_vsprintfcb+0x115c>
    2418:	8332                	mv	t1,a2
         fw -= n;
    241a:	41f3033b          	subw	t1,t1,t6
         pr -= l;
    241e:	9f1d                	subw	a4,a4,a5
         goto scopy;
    2420:	4f81                	li	t6,0
      tz = 0;
    2422:	4881                	li	a7,0
         goto scopy;
    2424:	fdcff06f          	j	1c00 <stbsp_vsprintfcb+0x942>
    2428:	8cda                	mv	s9,s6
    242a:	2c013a03          	ld	s4,704(sp)
    242e:	2b813a83          	ld	s5,696(sp)
    2432:	2b013b03          	ld	s6,688(sp)
    2436:	fa9fe06f          	j	13de <stbsp_vsprintfcb+0x120>
            fl |= ((sizeof(void *) == 8) ? STBSP__INTMAX : 0);
    243a:	020e6e13          	ori	t3,t3,32
            ++f;
    243e:	0485                	addi	s1,s1,1
    2440:	864ff06f          	j	14a4 <stbsp_vsprintfcb+0x1e6>
               n = 0;
    2444:	4601                	li	a2,0
         s = num + 64;
    2446:	8756                	mv	a4,s5
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2448:	4511                	li	a0,4
                     *s++ = stbsp__comma;
    244a:	00170793          	addi	a5,a4,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    244e:	00030563          	beqz	t1,2458 <stbsp_vsprintfcb+0x119a>
    2452:	2585                	addiw	a1,a1,1
    2454:	10a58363          	beq	a1,a0,255a <stbsp_vsprintfcb+0x129c>
    2458:	873e                	mv	a4,a5
                     *s++ = sn[n];
    245a:	02061793          	slli	a5,a2,0x20
    245e:	9381                	srli	a5,a5,0x20
    2460:	97fa                	add	a5,a5,t5
    2462:	0007c803          	lbu	a6,0(a5)
                     ++n;
    2466:	2605                	addiw	a2,a2,1
                     *s++ = sn[n];
    2468:	ff070fa3          	sb	a6,-1(a4)
                     if (n >= l)
    246c:	fcd66fe3          	bltu	a2,a3,244a <stbsp_vsprintfcb+0x118c>
               if (n < (stbsp__uint32)dp) {
    2470:	0bd663e3          	bltu	a2,t4,2d16 <stbsp_vsprintfcb+0x1a58>
               cs = (int)(s - (num + 64)) + (3 << 24); // cs is how many tens
    2474:	415707b3          	sub	a5,a4,s5
    2478:	030002b7          	lui	t0,0x3000
    247c:	00f282bb          	addw	t0,t0,a5
               if (pr) {
    2480:	00088a63          	beqz	a7,2494 <stbsp_vsprintfcb+0x11d6>
                  *s++ = stbsp__period;
    2484:	0cca4683          	lbu	a3,204(s4)
    2488:	00170793          	addi	a5,a4,1
         l = (stbsp__uint32)(s - (num + 64));
    248c:	415787b3          	sub	a5,a5,s5
                  *s++ = stbsp__period;
    2490:	00d70023          	sb	a3,0(a4)
         if (fl & STBSP__METRIC_SUFFIX) {
    2494:	100e7713          	andi	a4,t3,256
    2498:	86f2                	mv	a3,t3
    249a:	2c070163          	beqz	a4,275c <stbsp_vsprintfcb+0x149e>
            if (fl & STBSP__METRIC_NOSPACE)
    249e:	40ae5f9b          	sraiw	t6,t3,0xa
    24a2:	001fcf93          	xori	t6,t6,1
    24a6:	001fff93          	andi	t6,t6,1
            tail[1] = ' ';
    24aa:	02000713          	li	a4,32
    24ae:	06e108a3          	sb	a4,113(sp)
            tail[0] = idx;
    24b2:	07f10823          	sb	t6,112(sp)
               if (fl >> 24) { // SI kilo is 'k', JEDEC and SI kibits are 'K'.
    24b6:	018e561b          	srliw	a2,t3,0x18
    24ba:	018e571b          	srliw	a4,t3,0x18
         n = pr + lead[0] + tail[0] + tz;
    24be:	000f859b          	sext.w	a1,t6
               if (fl >> 24) { // SI kilo is 'k', JEDEC and SI kibits are 'K'.
    24c2:	c225                	beqz	a2,2522 <stbsp_vsprintfcb+0x1264>
                  if (fl & STBSP__METRIC_1024)
    24c4:	001f859b          	addiw	a1,t6,1
    24c8:	0ff5f613          	zext.b	a2,a1
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    24cc:	1702                	slli	a4,a4,0x20
                  if (fl & STBSP__METRIC_1024)
    24ce:	03469513          	slli	a0,a3,0x34
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    24d2:	85b2                	mv	a1,a2
    24d4:	9301                	srli	a4,a4,0x20
                  if (fl & STBSP__METRIC_1024)
    24d6:	06055ee3          	bgez	a0,2d52 <stbsp_vsprintfcb+0x1a94>
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    24da:	00003517          	auipc	a0,0x3
    24de:	bde50513          	addi	a0,a0,-1058 # 50b8 <_GLOBAL__sub_I__ZSt3cin+0xd8>
    24e2:	972a                	add	a4,a4,a0
    24e4:	00074503          	lbu	a0,0(a4)
                  if (fl & STBSP__METRIC_1024 && !(fl & STBSP__METRIC_JEDEC)) {
    24e8:	6709                	lui	a4,0x2
    24ea:	80070713          	addi	a4,a4,-2048 # 1800 <stbsp_vsprintfcb+0x542>
    24ee:	8f75                	and	a4,a4,a3
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    24f0:	06010813          	addi	a6,sp,96
    24f4:	22060693          	addi	a3,a2,544
    24f8:	96c2                	add	a3,a3,a6
    24fa:	dea68823          	sb	a0,-528(a3) # efffdf0 <_ZSt4cerr+0xeff8588>
                  if (fl & STBSP__METRIC_1024 && !(fl & STBSP__METRIC_JEDEC)) {
    24fe:	8007071b          	addiw	a4,a4,-2048
    2502:	060715e3          	bnez	a4,2d6c <stbsp_vsprintfcb+0x1aae>
                     tail[idx + 1] = 'i';
    2506:	2f89                	addiw	t6,t6,2
    2508:	0ffff593          	zext.b	a1,t6
    250c:	1094                	addi	a3,sp,96
    250e:	22058713          	addi	a4,a1,544
    2512:	9736                	add	a4,a4,a3
    2514:	06900693          	li	a3,105
    2518:	8fae                	mv	t6,a1
    251a:	ded70823          	sb	a3,-528(a4)
                  tail[0] = idx;
    251e:	07f10823          	sb	t6,112(sp)
         l = (stbsp__uint32)(s - (num + 64));
    2522:	0007869b          	sext.w	a3,a5
         n = pr + lead[0] + tail[0] + tz;
    2526:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    252a:	fff6c713          	not	a4,a3
    252e:	977d                	srai	a4,a4,0x3f
    2530:	8ff9                	and	a5,a5,a4
         n = pr + lead[0] + tail[0] + tz;
    2532:	00fa073b          	addw	a4,s4,a5
    2536:	9f2d                	addw	a4,a4,a1
    2538:	0117063b          	addw	a2,a4,a7
         l = (stbsp__uint32)(s - (num + 64));
    253c:	d0b6                	sw	a3,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    253e:	8732                	mv	a4,a2
         if (pr < (stbsp__int32)l)
    2540:	2781                	sext.w	a5,a5
         if ((fl & STBSP__LEFTJUST) == 0) {
    2542:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    2546:	835a                	mv	t1,s6
    2548:	00cb5363          	bge	s6,a2,254e <stbsp_vsprintfcb+0x1290>
    254c:	8332                	mv	t1,a2
         fw -= n;
    254e:	40e3033b          	subw	t1,t1,a4
         pr -= l;
    2552:	40d7873b          	subw	a4,a5,a3
         goto scopy;
    2556:	eaaff06f          	j	1c00 <stbsp_vsprintfcb+0x942>
                     *s++ = stbsp__comma;
    255a:	fe578fa3          	sb	t0,-1(a5)
    255e:	0709                	addi	a4,a4,2
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2560:	4585                	li	a1,1
    2562:	bde5                	j	245a <stbsp_vsprintfcb+0x119c>
            lead[0] = 1;
    2564:	678d                	lui	a5,0x3
    2566:	0785                	addi	a5,a5,1 # 3001 <sprintf+0xb>
    2568:	06f11423          	sh	a5,104(sp)
    256c:	b4ed                	j	2056 <stbsp_vsprintfcb+0xd98>
            if ((f[0] != 'u') && (i64 < 0)) {
    256e:	07500693          	li	a3,117
            stbsp__int64 i64 = va_arg(va, stbsp__int64);
    2572:	000bbf03          	ld	t5,0(s7)
            if ((f[0] != 'u') && (i64 < 0)) {
    2576:	dcd78263          	beq	a5,a3,1b3a <stbsp_vsprintfcb+0x87c>
    257a:	dc0f5063          	bgez	t5,1b3a <stbsp_vsprintfcb+0x87c>
               fl |= STBSP__NEGATIVE;
    257e:	08076713          	ori	a4,a4,128
               n64 = (stbsp__uint64)-i64;
    2582:	41e00f33          	neg	t5,t5
               fl |= STBSP__NEGATIVE;
    2586:	00070e1b          	sext.w	t3,a4
    258a:	db0ff06f          	j	1b3a <stbsp_vsprintfcb+0x87c>
            lead[2] = h[0xb];
    258e:	00b84703          	lbu	a4,11(a6)
            lead[0] = 2;
    2592:	678d                	lui	a5,0x3
    2594:	0789                	addi	a5,a5,2 # 3002 <sprintf+0xc>
    2596:	06f11423          	sh	a5,104(sp)
            lead[2] = h[0xb];
    259a:	06e10523          	sb	a4,106(sp)
    259e:	bab5                	j	1f1a <stbsp_vsprintfcb+0xc5c>
      sign[0] = 1;
    25a0:	678d                	lui	a5,0x3
    25a2:	d0178793          	addi	a5,a5,-767 # 2d01 <stbsp_vsprintfcb+0x1a43>
            fl |= STBSP__NEGATIVE;
    25a6:	080e6e13          	ori	t3,t3,128
      sign[0] = 1;
    25aa:	06f11423          	sh	a5,104(sp)
    25ae:	468d                	li	a3,3
    25b0:	4a0d                	li	s4,3
    25b2:	4809                	li	a6,2
    25b4:	b899                	j	1e0a <stbsp_vsprintfcb+0xb4c>
      sign[0] = 1;
    25b6:	6709                	lui	a4,0x2
    25b8:	0705                	addi	a4,a4,1 # 2001 <stbsp_vsprintfcb+0xd43>
    25ba:	06e11423          	sh	a4,104(sp)
    25be:	bae5                	j	1fb6 <stbsp_vsprintfcb+0xcf8>
      if (((stbsp__uintptr)sn & 3) == 0)
    25c0:	0e0780e3          	beqz	a5,2ea0 <stbsp_vsprintfcb+0x1be2>
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    25c4:	56fd                	li	a3,-1
    25c6:	bcf9                	j	20a4 <stbsp_vsprintfcb+0xde6>
         if (fw < (stbsp__int32)n)
    25c8:	4305                	li	t1,1
    25ca:	b249                	j	1f4c <stbsp_vsprintfcb+0xc8e>
            pr = 6; // default is 6
    25cc:	4899                	li	a7,6
    25ce:	b801                	j	1dde <stbsp_vsprintfcb+0xb20>
         h = (f[0] == 'A') ? hexu : hex;
    25d0:	00004597          	auipc	a1,0x4
    25d4:	47058593          	addi	a1,a1,1136 # 6a40 <hexu.1>
    25d8:	ff6ff06f          	j	1dce <stbsp_vsprintfcb+0xb10>
         h = (f[0] == 'B') ? hexu : hex;
    25dc:	00004817          	auipc	a6,0x4
    25e0:	46480813          	addi	a6,a6,1124 # 6a40 <hexu.1>
    25e4:	b22d                	j	1f0e <stbsp_vsprintfcb+0xc50>
    25e6:	80000737          	lui	a4,0x80000
    25ea:	0719                	addi	a4,a4,6 # ffffffff80000006 <_ZSt4cerr+0xffffffff7fff879e>
            pr = 6; // default is 6
    25ec:	4899                	li	a7,6
    25ee:	e4eff06f          	j	1c3c <stbsp_vsprintfcb+0x97e>
         h = (f[0] == 'E') ? hexu : hex;
    25f2:	00004317          	auipc	t1,0x4
    25f6:	44e30313          	addi	t1,t1,1102 # 6a40 <hexu.1>
    25fa:	e28ff06f          	j	1c22 <stbsp_vsprintfcb+0x964>
    25fe:	80000737          	lui	a4,0x80000
    2602:	4a99                	li	s5,6
    2604:	0715                	addi	a4,a4,5 # ffffffff80000005 <_ZSt4cerr+0xffffffff7fff879d>
            pr = 6;
    2606:	4a19                	li	s4,6
    2608:	ee8ff06f          	j	1cf0 <stbsp_vsprintfcb+0xa32>
         h = (f[0] == 'G') ? hexu : hex;
    260c:	00004317          	auipc	t1,0x4
    2610:	43430313          	addi	t1,t1,1076 # 6a40 <hexu.1>
    2614:	eb6ff06f          	j	1cca <stbsp_vsprintfcb+0xa0c>
    2618:	7be6                	ld	s7,120(sp)
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    261a:	86c2                	mv	a3,a6
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    261c:	8542                	mv	a0,a6
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    261e:	88d2                	mv	a7,s4
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2620:	8ade                	mv	s5,s7
            if (pr > (stbsp__int32)l)
    2622:	0005071b          	sext.w	a4,a0
    2626:	01175f63          	bge	a4,a7,2644 <stbsp_vsprintfcb+0x1386>
               pr = l - 1;
    262a:	fff5089b          	addiw	a7,a0,-1
         tail[0] = 0;
    262e:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    2632:	70028c63          	beqz	t0,2d4a <stbsp_vsprintfcb+0x1a8c>
      sign[0] = 1;
    2636:	670d                	lui	a4,0x3
    2638:	d0170713          	addi	a4,a4,-767 # 2d01 <stbsp_vsprintfcb+0x1a43>
    263c:	06e11423          	sh	a4,104(sp)
    2640:	e3aff06f          	j	1c7a <stbsp_vsprintfcb+0x9bc>
            else if (pr)
    2644:	fe0885e3          	beqz	a7,262e <stbsp_vsprintfcb+0x1370>
               --pr; // when using %e, there is one digit before the decimal
    2648:	38fd                	addiw	a7,a7,-1
    264a:	b7d5                	j	262e <stbsp_vsprintfcb+0x1370>
      switch (f[0]) {
    264c:	0034c783          	lbu	a5,3(s1)
            f += 3;
    2650:	048d                	addi	s1,s1,3
    2652:	e53fe06f          	j	14a4 <stbsp_vsprintfcb+0x1e6>
      if (!limit || *sn == 0)
    2656:	4601                	li	a2,0
    2658:	4701                	li	a4,0
    265a:	4781                	li	a5,0
         return (stbsp__uint32)(sn - s);
    265c:	bca5                	j	20d4 <stbsp_vsprintfcb+0xe16>
               pr = 1;
    265e:	4885                	li	a7,1
    2660:	cf4ff06f          	j	1b54 <stbsp_vsprintfcb+0x896>
         *s++ = sn[0];
    2664:	000ac703          	lbu	a4,0(s5)
    2668:	0ce10023          	sb	a4,192(sp)
         if (pr)
    266c:	54088563          	beqz	a7,2bb6 <stbsp_vsprintfcb+0x18f8>
            *s++ = stbsp__period;
    2670:	00004617          	auipc	a2,0x4
    2674:	3cc64603          	lbu	a2,972(a2) # 6a3c <stbsp__period>
         if ((l - 1) > (stbsp__uint32)pr)
    2678:	fff6871b          	addiw	a4,a3,-1
            *s++ = stbsp__period;
    267c:	0cc100a3          	sb	a2,193(sp)
         if ((l - 1) > (stbsp__uint32)pr)
    2680:	0008851b          	sext.w	a0,a7
    2684:	0007061b          	sext.w	a2,a4
    2688:	52c57163          	bgeu	a0,a2,2baa <stbsp_vsprintfcb+0x18ec>
            l = pr + 1;
    268c:	0018869b          	addiw	a3,a7,1
         for (n = 1; n < l; n++)
    2690:	8746                	mv	a4,a7
    2692:	02071613          	slli	a2,a4,0x20
    2696:	9201                	srli	a2,a2,0x20
    2698:	0c210713          	addi	a4,sp,194
    269c:	0a85                	addi	s5,s5,1
    269e:	963a                	add	a2,a2,a4
            *s++ = sn[n];
    26a0:	000ac583          	lbu	a1,0(s5)
    26a4:	0705                	addi	a4,a4,1
         for (n = 1; n < l; n++)
    26a6:	0a85                	addi	s5,s5,1
            *s++ = sn[n];
    26a8:	feb70fa3          	sb	a1,-1(a4)
         for (n = 1; n < l; n++)
    26ac:	fec71ae3          	bne	a4,a2,26a0 <stbsp_vsprintfcb+0x13e2>
         tail[1] = h[0xe];
    26b0:	00e34803          	lbu	a6,14(t1)
         dp -= 1;
    26b4:	fff7871b          	addiw	a4,a5,-1
            tail[2] = '+';
    26b8:	02b00593          	li	a1,43
         tail[1] = h[0xe];
    26bc:	070108a3          	sb	a6,113(sp)
         if (dp < 0) {
    26c0:	00075663          	bgez	a4,26cc <stbsp_vsprintfcb+0x140e>
            dp = -dp;
    26c4:	4705                	li	a4,1
    26c6:	9f1d                	subw	a4,a4,a5
            tail[2] = '-';
    26c8:	02d00593          	li	a1,45
    26cc:	06b10923          	sb	a1,114(sp)
         n = (dp >= 100) ? 5 : 4;
    26d0:	06300793          	li	a5,99
    26d4:	4ee7d663          	bge	a5,a4,2bc0 <stbsp_vsprintfcb+0x1902>
    26d8:	4595                	li	a1,5
    26da:	4f95                	li	t6,5
    26dc:	4e95                	li	t4,5
            tail[n] = '0' + dp % 10;
    26de:	47a9                	li	a5,10
            dp /= 10;
    26e0:	02f7433b          	divw	t1,a4,a5
            --n;
    26e4:	fffe8f1b          	addiw	t5,t4,-1
            tail[n] = '0' + dp % 10;
    26e8:	020f1293          	slli	t0,t5,0x20
    26ec:	220e8813          	addi	a6,t4,544
    26f0:	06010893          	addi	a7,sp,96
    26f4:	0202d293          	srli	t0,t0,0x20
    26f8:	01180eb3          	add	t4,a6,a7
    26fc:	22028813          	addi	a6,t0,544 # 3000220 <_ZSt4cerr+0x2ff89b8>
    2700:	011802b3          	add	t0,a6,a7
         tail[0] = (char)n;
    2704:	07f10823          	sb	t6,112(sp)
            if (n <= 3)
    2708:	4a0d                	li	s4,3
            tail[n] = '0' + dp % 10;
    270a:	02f7673b          	remw	a4,a4,a5
            dp /= 10;
    270e:	0003081b          	sext.w	a6,t1
            tail[n] = '0' + dp % 10;
    2712:	02f36abb          	remw	s5,t1,a5
    2716:	0307071b          	addiw	a4,a4,48
    271a:	deee8823          	sb	a4,-528(t4)
    271e:	030a871b          	addiw	a4,s5,48
    2722:	dee28823          	sb	a4,-528(t0)
            if (n <= 3)
    2726:	014f0a63          	beq	t5,s4,273a <stbsp_vsprintfcb+0x147c>
            dp /= 10;
    272a:	02f3483b          	divw	a6,t1,a5
            tail[n] = '0' + dp % 10;
    272e:	02f867bb          	remw	a5,a6,a5
    2732:	0307879b          	addiw	a5,a5,48
    2736:	06f109a3          	sb	a5,115(sp)
         tz = pr - (l - 1);
    273a:	2505                	addiw	a0,a0,1
         l = (stbsp__uint32)(s - (num + 64));
    273c:	0c010a93          	addi	s5,sp,192
         cs = 1 + (3 << 24); // how many tens
    2740:	030002b7          	lui	t0,0x3000
         tz = pr - (l - 1);
    2744:	40d508bb          	subw	a7,a0,a3
    2748:	d2c2                	sw	a6,100(sp)
         l = (stbsp__uint32)(s - (num + 64));
    274a:	415607b3          	sub	a5,a2,s5
         cs = 1 + (3 << 24); // how many tens
    274e:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff8799>
    2750:	bbc9                	j	2522 <stbsp_vsprintfcb+0x1264>
    2752:	fc2e                	sd	a1,56(sp)
    2754:	d0b2                	sw	a2,96(sp)
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2756:	8536                	mv	a0,a3
    2758:	e2cff06f          	j	1d84 <stbsp_vsprintfcb+0xac6>
      flt_lead:
    275c:	4581                	li	a1,0
    275e:	4f81                	li	t6,0
    2760:	b3c9                	j	2522 <stbsp_vsprintfcb+0x1264>
         n = pr + lead[0] + tail[0] + tz;
    2762:	06814a03          	lbu	s4,104(sp)
    2766:	000a0f9b          	sext.w	t6,s4
    276a:	b901                	j	237a <stbsp_vsprintfcb+0x10bc>
         if ((f[1] == '6') && (f[2] == '4')) {
    276c:	0024c683          	lbu	a3,2(s1)
    2770:	03400713          	li	a4,52
    2774:	00e68463          	beq	a3,a4,277c <stbsp_vsprintfcb+0x14be>
    2778:	e2bfe06f          	j	15a2 <stbsp_vsprintfcb+0x2e4>
      switch (f[0]) {
    277c:	0034c783          	lbu	a5,3(s1)
         fl |= ((sizeof(long) == 8) ? STBSP__INTMAX : 0);
    2780:	020e6e13          	ori	t3,t3,32
            f += 3;
    2784:	048d                	addi	s1,s1,3
    2786:	d1ffe06f          	j	14a4 <stbsp_vsprintfcb+0x1e6>
         if (pr < (stbsp__int32)l)
    278a:	0006879b          	sext.w	a5,a3
         n = pr + lead[0] + tail[0] + tz;
    278e:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    2792:	fff7c793          	not	a5,a5
    2796:	97fd                	srai	a5,a5,0x3f
    2798:	8ff5                	and	a5,a5,a3
         n = pr + lead[0] + tail[0] + tz;
    279a:	00fa063b          	addw	a2,s4,a5
            s = (char *)sn;
    279e:	7ae6                	ld	s5,120(sp)
         n = pr + lead[0] + tail[0] + tz;
    27a0:	8732                	mv	a4,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    27a2:	001e7513          	andi	a0,t3,1
         if (pr < (stbsp__int32)l)
    27a6:	2781                	sext.w	a5,a5
         if (fw < (stbsp__int32)n)
    27a8:	835a                	mv	t1,s6
    27aa:	00cb5363          	bge	s6,a2,27b0 <stbsp_vsprintfcb+0x14f2>
    27ae:	8332                	mv	t1,a2
         fw -= n;
    27b0:	40e3033b          	subw	t1,t1,a4
            goto scopy;
    27b4:	4f81                	li	t6,0
         pr -= l;
    27b6:	40d7873b          	subw	a4,a5,a3
            cs = 0;
    27ba:	4281                	li	t0,0
      tz = 0;
    27bc:	4881                	li	a7,0
            goto scopy;
    27be:	c42ff06f          	j	1c00 <stbsp_vsprintfcb+0x942>
               cs = (int)(s - (num + 64)) + (3 << 24); // cs is how many tens
    27c2:	415705b3          	sub	a1,a4,s5
    27c6:	030002b7          	lui	t0,0x3000
    27ca:	00b282bb          	addw	t0,t0,a1
               l = pr - n;
    27ce:	0008859b          	sext.w	a1,a7
               if (pr)
    27d2:	42088763          	beqz	a7,2c00 <stbsp_vsprintfcb+0x1942>
                  *s++ = stbsp__period;
    27d6:	0cca4f83          	lbu	t6,204(s4)
               if ((l - dp) > (stbsp__uint32)pr)
    27da:	41d6833b          	subw	t1,a3,t4
                  *s++ = stbsp__period;
    27de:	00280713          	addi	a4,a6,2
    27e2:	01f800a3          	sb	t6,1(a6)
               if ((l - dp) > (stbsp__uint32)pr)
    27e6:	4065ed63          	bltu	a1,t1,2c00 <stbsp_vsprintfcb+0x1942>
               while (n < l) {
    27ea:	5ed57863          	bgeu	a0,a3,2dda <stbsp_vsprintfcb+0x1b1c>
    27ee:	40c687bb          	subw	a5,a3,a2
    27f2:	37fd                	addiw	a5,a5,-1
    27f4:	1782                	slli	a5,a5,0x20
    27f6:	9381                	srli	a5,a5,0x20
    27f8:	1602                	slli	a2,a2,0x20
    27fa:	9201                	srli	a2,a2,0x20
    27fc:	0785                	addi	a5,a5,1
    27fe:	967a                	add	a2,a2,t5
    2800:	97ba                	add	a5,a5,a4
                  *s++ = sn[n];
    2802:	00064503          	lbu	a0,0(a2)
    2806:	0705                	addi	a4,a4,1
               while (n < l) {
    2808:	0605                	addi	a2,a2,1
                  *s++ = sn[n];
    280a:	fea70fa3          	sb	a0,-1(a4)
               while (n < l) {
    280e:	fef71ae3          	bne	a4,a5,2802 <stbsp_vsprintfcb+0x1544>
               tz = pr - (l - dp);
    2812:	01d585bb          	addw	a1,a1,t4
    2816:	40d588bb          	subw	a7,a1,a3
         l = (stbsp__uint32)(s - (num + 64));
    281a:	415787b3          	sub	a5,a5,s5
    281e:	b99d                	j	2494 <stbsp_vsprintfcb+0x11d6>
            fl |= STBSP__NEGATIVE;
    2820:	080e6e13          	ori	t3,t3,128
         tail[0] = 0;
    2824:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    2828:	b539                	j	2636 <stbsp_vsprintfcb+0x1378>
         tail[0] = (char)n;
    282a:	4799                	li	a5,6
            tail[n] = '0' + dp % 10;
    282c:	06b10b23          	sb	a1,118(sp)
         tail[0] = (char)n;
    2830:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    2834:	4819                	li	a6,6
    2836:	4f99                	li	t6,6
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    2838:	4599                	li	a1,6
            dp /= 10;
    283a:	4f29                	li	t5,10
            if (n <= 3)
    283c:	428d                	li	t0,3
    283e:	87b2                	mv	a5,a2
            dp /= 10;
    2840:	03e7c7bb          	divw	a5,a5,t5
            --n;
    2844:	35fd                	addiw	a1,a1,-1
            tail[n] = '0' + dp % 10;
    2846:	02059613          	slli	a2,a1,0x20
    284a:	9201                	srli	a2,a2,0x20
    284c:	06010e93          	addi	t4,sp,96
    2850:	22060613          	addi	a2,a2,544
    2854:	9676                	add	a2,a2,t4
    2856:	03e7eebb          	remw	t4,a5,t5
    285a:	030e8e9b          	addiw	t4,t4,48
    285e:	dfd60823          	sb	t4,-528(a2)
            if (n <= 3)
    2862:	fc559fe3          	bne	a1,t0,2840 <stbsp_vsprintfcb+0x1582>
    2866:	e6aff06f          	j	1ed0 <stbsp_vsprintfcb+0xc12>
         *s++ = h[(n64 >> 60) & 15];
    286a:	93f1                	srli	a5,a5,0x3c
    286c:	97ae                	add	a5,a5,a1
    286e:	0007c303          	lbu	t1,0(a5)
         lead[1 + lead[0]] = '0';
    2872:	1088                	addi	a0,sp,96
    2874:	22080793          	addi	a5,a6,544
    2878:	97aa                	add	a5,a5,a0
    287a:	03000513          	li	a0,48
    287e:	dea78423          	sb	a0,-536(a5)
         lead[2 + lead[0]] = 'x';
    2882:	22068793          	addi	a5,a3,544
    2886:	1094                	addi	a3,sp,96
    2888:	96be                	add	a3,a3,a5
            *s++ = stbsp__period;
    288a:	00004517          	auipc	a0,0x4
    288e:	1b254503          	lbu	a0,434(a0) # 6a3c <stbsp__period>
         lead[2 + lead[0]] = 'x';
    2892:	07800813          	li	a6,120
         sn = s;
    2896:	0c210793          	addi	a5,sp,194
         lead[2 + lead[0]] = 'x';
    289a:	df068423          	sb	a6,-536(a3)
            *s++ = stbsp__period;
    289e:	0ca100a3          	sb	a0,193(sp)
         lead[0] += 2;
    28a2:	07410423          	sb	s4,104(sp)
         *s++ = h[(n64 >> 60) & 15];
    28a6:	0c610023          	sb	t1,192(sp)
         n64 <<= 4;
    28aa:	0732                	slli	a4,a4,0xc
         sn = s;
    28ac:	fcbe                	sd	a5,120(sp)
         n = pr;
    28ae:	0008869b          	sext.w	a3,a7
         while (n--) {
    28b2:	4831                	li	a6,12
         if (n > 13)
    28b4:	4535                	li	a0,13
            tz = pr - n;
    28b6:	40a688bb          	subw	a7,a3,a0
         while (n--) {
    28ba:	02081313          	slli	t1,a6,0x20
    28be:	02035313          	srli	t1,t1,0x20
    28c2:	22030693          	addi	a3,t1,544
    28c6:	1088                	addi	a0,sp,96
    28c8:	9536                	add	a0,a0,a3
    28ca:	e4350513          	addi	a0,a0,-445
            *s++ = h[(n64 >> 60) & 15];
    28ce:	03c75693          	srli	a3,a4,0x3c
    28d2:	96ae                	add	a3,a3,a1
    28d4:	0006c683          	lbu	a3,0(a3)
    28d8:	0785                	addi	a5,a5,1
            n64 <<= 4;
    28da:	0712                	slli	a4,a4,0x4
            *s++ = h[(n64 >> 60) & 15];
    28dc:	fed78fa3          	sb	a3,-1(a5)
         while (n--) {
    28e0:	fea797e3          	bne	a5,a0,28ce <stbsp_vsprintfcb+0x1610>
         l = (int)(s - (num + 64));
    28e4:	280d                	addiw	a6,a6,3
    28e6:	0008069b          	sext.w	a3,a6
         if (pr < (stbsp__int32)l)
    28ea:	fff6c713          	not	a4,a3
    28ee:	977d                	srai	a4,a4,0x3f
    28f0:	00e87733          	and	a4,a6,a4
         dp = (int)(s - sn);
    28f4:	0013051b          	addiw	a0,t1,1
         if (pr < (stbsp__int32)l)
    28f8:	0007031b          	sext.w	t1,a4
         pr -= l;
    28fc:	4107073b          	subw	a4,a4,a6
    2900:	d76ff06f          	j	1e76 <stbsp_vsprintfcb+0xbb8>
                  *--s = stbsp__comma;
    2904:	00004a17          	auipc	s4,0x4
    2908:	06ca0a13          	addi	s4,s4,108 # 6970 <stbsp__digitpair>
            if (n64 >= 100000000) {
    290c:	05f5e7b7          	lui	a5,0x5f5e
    2910:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f56897>
               n = (stbsp__uint32)(n64 % 100000000);
    2914:	05f5e637          	lui	a2,0x5f5e
                  *--s = stbsp__comma;
    2918:	0cda4b83          	lbu	s7,205(s4)
            if (n64 >= 100000000) {
    291c:	e83e                	sd	a5,16(sp)
               n = (stbsp__uint32)(n64 % 100000000);
    291e:	10060793          	addi	a5,a2,256 # 5f5e100 <_ZSt4cerr+0x5f56898>
         l = 0;
    2922:	d082                	sw	zero,96(sp)
            if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    2924:	040e7813          	andi	a6,t3,64
    2928:	4701                	li	a4,0
    292a:	4281                	li	t0,0
         s = num + STBSP__NUMSZ;
    292c:	28010a93          	addi	s5,sp,640
               n = (stbsp__uint32)(n64 % 100000000);
    2930:	ec3e                	sd	a5,24(sp)
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    2932:	430d                	li	t1,3
                  n /= 10;
    2934:	45a9                	li	a1,10
            while (n) {
    2936:	4ea5                	li	t4,9
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    2938:	06400f93          	li	t6,100
            if (n64 >= 100000000) {
    293c:	67c2                	ld	a5,16(sp)
            char *o = s - 8;
    293e:	ff8a8513          	addi	a0,s5,-8
            if (n64 >= 100000000) {
    2942:	0fe7f763          	bgeu	a5,t5,2a30 <stbsp_vsprintfcb+0x1772>
               n = (stbsp__uint32)(n64 % 100000000);
    2946:	6662                	ld	a2,24(sp)
    2948:	02cf77b3          	remu	a5,t5,a2
               n64 /= 100000000;
    294c:	02cf5f33          	divu	t5,t5,a2
            if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    2950:	0e080463          	beqz	a6,2a38 <stbsp_vsprintfcb+0x177a>
            while (n) {
    2954:	cb85                	beqz	a5,2984 <stbsp_vsprintfcb+0x16c6>
                  *--s = stbsp__comma;
    2956:	1afd                	addi	s5,s5,-1
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    2958:	00671763          	bne	a4,t1,2966 <stbsp_vsprintfcb+0x16a8>
                  --o;
    295c:	017a8023          	sb	s7,0(s5)
    2960:	157d                	addi	a0,a0,-1
                  *--s = stbsp__comma;
    2962:	1afd                	addi	s5,s5,-1
                  l = 0;
    2964:	4701                	li	a4,0
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    2966:	2705                	addiw	a4,a4,1
                  *--s = (char)(n % 10) + '0';
    2968:	02b7f63b          	remuw	a2,a5,a1
    296c:	0306061b          	addiw	a2,a2,48
    2970:	00ca8023          	sb	a2,0(s5)
                  n /= 10;
    2974:	02b7d63b          	divuw	a2,a5,a1
            while (n) {
    2978:	00fef563          	bgeu	t4,a5,2982 <stbsp_vsprintfcb+0x16c4>
                  *--s = stbsp__comma;
    297c:	1afd                	addi	s5,s5,-1
    297e:	87b2                	mv	a5,a2
    2980:	bfe1                	j	2958 <stbsp_vsprintfcb+0x169a>
            while (n) {
    2982:	4285                	li	t0,1
            if (n64 == 0) {
    2984:	020f0063          	beqz	t5,29a4 <stbsp_vsprintfcb+0x16e6>
            while (s != o)
    2988:	fb550ae3          	beq	a0,s5,293c <stbsp_vsprintfcb+0x167e>
                  *--s = stbsp__comma;
    298c:	1afd                	addi	s5,s5,-1
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    298e:	00080663          	beqz	a6,299a <stbsp_vsprintfcb+0x16dc>
    2992:	08670863          	beq	a4,t1,2a22 <stbsp_vsprintfcb+0x1764>
    2996:	2705                	addiw	a4,a4,1
    2998:	4285                	li	t0,1
                  *--s = '0';
    299a:	03000793          	li	a5,48
    299e:	00fa8023          	sb	a5,0(s5)
    29a2:	b7dd                	j	2988 <stbsp_vsprintfcb+0x16ca>
    29a4:	00028363          	beqz	t0,29aa <stbsp_vsprintfcb+0x16ec>
    29a8:	d0ba                	sw	a4,96(sp)
               if ((s[0] == '0') && (s != (num + STBSP__NUMSZ)))
    29aa:	000ac703          	lbu	a4,0(s5)
    29ae:	03000793          	li	a5,48
    29b2:	34f70b63          	beq	a4,a5,2d08 <stbsp_vsprintfcb+0x1a4a>
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    29b6:	051c                	addi	a5,sp,640
    29b8:	415786bb          	subw	a3,a5,s5
         tail[0] = 0;
    29bc:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    29c0:	080e7713          	andi	a4,t3,128
    29c4:	87f2                	mv	a5,t3
    29c6:	32070863          	beqz	a4,2cf6 <stbsp_vsprintfcb+0x1a38>
    29ca:	678d                	lui	a5,0x3
    29cc:	d017879b          	addiw	a5,a5,-767 # 2d01 <stbsp_vsprintfcb+0x1a43>
      sign[0] = 1;
    29d0:	06f11423          	sh	a5,104(sp)
    29d4:	4705                	li	a4,1
    29d6:	4a05                	li	s4,1
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    29d8:	d0b6                	sw	a3,96(sp)
         if (l == 0) {
    29da:	30068163          	beqz	a3,2cdc <stbsp_vsprintfcb+0x1a1e>
         cs = l + (3 << 24);
    29de:	030002b7          	lui	t0,0x3000
    29e2:	00d282bb          	addw	t0,t0,a3
         if (pr < (stbsp__int32)l)
    29e6:	0006861b          	sext.w	a2,a3
         if (pr < 0)
    29ea:	fff8c793          	not	a5,a7
    29ee:	97fd                	srai	a5,a5,0x3f
         if (pr < (stbsp__int32)l)
    29f0:	00f8f7b3          	and	a5,a7,a5
    29f4:	0007859b          	sext.w	a1,a5
    29f8:	00c5d363          	bge	a1,a2,29fe <stbsp_vsprintfcb+0x1740>
    29fc:	87b2                	mv	a5,a2
         n = pr + lead[0] + tail[0] + tz;
    29fe:	00f7063b          	addw	a2,a4,a5
    2a02:	8732                	mv	a4,a2
         if (pr < (stbsp__int32)l)
    2a04:	2781                	sext.w	a5,a5
         if ((fl & STBSP__LEFTJUST) == 0) {
    2a06:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    2a0a:	835a                	mv	t1,s6
    2a0c:	00cb5363          	bge	s6,a2,2a12 <stbsp_vsprintfcb+0x1754>
    2a10:	8332                	mv	t1,a2
         fw -= n;
    2a12:	40e3033b          	subw	t1,t1,a4
      scopy:
    2a16:	4f81                	li	t6,0
         pr -= l;
    2a18:	40d7873b          	subw	a4,a5,a3
      tz = 0;
    2a1c:	4881                	li	a7,0
      scopy:
    2a1e:	9e2ff06f          	j	1c00 <stbsp_vsprintfcb+0x942>
                  *--s = stbsp__comma;
    2a22:	87de                	mv	a5,s7
                  --o;
    2a24:	157d                	addi	a0,a0,-1
                  l = 0;
    2a26:	4701                	li	a4,0
                  --o;
    2a28:	4285                	li	t0,1
    2a2a:	00fa8023          	sb	a5,0(s5)
    2a2e:	bfa9                	j	2988 <stbsp_vsprintfcb+0x16ca>
               n = (stbsp__uint32)n64;
    2a30:	000f079b          	sext.w	a5,t5
               n64 = 0;
    2a34:	4f01                	li	t5,0
    2a36:	bf29                	j	2950 <stbsp_vsprintfcb+0x1692>
    2a38:	f046                	sd	a7,32(sp)
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    2a3a:	03f7f63b          	remuw	a2,a5,t6
                  s -= 2;
    2a3e:	1af9                	addi	s5,s5,-2
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    2a40:	0007889b          	sext.w	a7,a5
    2a44:	2605                	addiw	a2,a2,1
    2a46:	0016161b          	slliw	a2,a2,0x1
    2a4a:	1602                	slli	a2,a2,0x20
    2a4c:	9201                	srli	a2,a2,0x20
    2a4e:	9652                	add	a2,a2,s4
    2a50:	00065603          	lhu	a2,0(a2)
                  n /= 100;
    2a54:	03f7d7bb          	divuw	a5,a5,t6
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    2a58:	00ca9023          	sh	a2,0(s5)
               } while (n);
    2a5c:	06300613          	li	a2,99
    2a60:	fd166de3          	bltu	a2,a7,2a3a <stbsp_vsprintfcb+0x177c>
    2a64:	7882                	ld	a7,32(sp)
            if (n64 == 0) {
    2a66:	f20f11e3          	bnez	t5,2988 <stbsp_vsprintfcb+0x16ca>
    2a6a:	bf2d                	j	29a4 <stbsp_vsprintfcb+0x16e6>
                     *(stbsp__uint32 *)bf = 0x20202020;
    2a6c:	20202b37          	lui	s6,0x20202
                  stbsp__cb_buf_clamp(i, fw);
    2a70:	854a                	mv	a0,s2
                     *bf++ = ' ';
    2a72:	02000a93          	li	s5,32
                     *(stbsp__uint32 *)bf = 0x20202020;
    2a76:	020b0b13          	addi	s6,s6,32 # 20202020 <_ZSt4cerr+0x201fa7b8>
                  stbsp__chk_cb_buf(1);
    2a7a:	1fe00a13          	li	s4,510
                  stbsp__cb_buf_clamp(i, fw);
    2a7e:	20000b93          	li	s7,512
    2a82:	891a                	mv	s2,t1
    2a84:	0a098063          	beqz	s3,2b24 <stbsp_vsprintfcb+0x1866>
    2a88:	40a40633          	sub	a2,s0,a0
    2a8c:	40cb87bb          	subw	a5,s7,a2
    2a90:	873e                	mv	a4,a5
    2a92:	00f95363          	bge	s2,a5,2a98 <stbsp_vsprintfcb+0x17da>
    2a96:	874a                	mv	a4,s2
    2a98:	0007079b          	sext.w	a5,a4
                  fw -= i;
    2a9c:	40e9093b          	subw	s2,s2,a4
                  while (i) {
    2aa0:	e799                	bnez	a5,2aae <stbsp_vsprintfcb+0x17f0>
    2aa2:	a281                	j	2be2 <stbsp_vsprintfcb+0x1924>
                     *bf++ = ' ';
    2aa4:	01540023          	sb	s5,0(s0)
                     --i;
    2aa8:	37fd                	addiw	a5,a5,-1
                     *bf++ = ' ';
    2aaa:	0405                	addi	s0,s0,1
                  while (i) {
    2aac:	cba1                	beqz	a5,2afc <stbsp_vsprintfcb+0x183e>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    2aae:	00347713          	andi	a4,s0,3
    2ab2:	fb6d                	bnez	a4,2aa4 <stbsp_vsprintfcb+0x17e6>
                  while (i >= 4) {
    2ab4:	470d                	li	a4,3
    2ab6:	40f75363          	bge	a4,a5,2ebc <stbsp_vsprintfcb+0x1bfe>
    2aba:	ffc7869b          	addiw	a3,a5,-4
    2abe:	0026d79b          	srliw	a5,a3,0x2
    2ac2:	0017871b          	addiw	a4,a5,1
    2ac6:	070a                	slli	a4,a4,0x2
    2ac8:	9722                	add	a4,a4,s0
                     *(stbsp__uint32 *)bf = 0x20202020;
    2aca:	01642023          	sw	s6,0(s0)
                     bf += 4;
    2ace:	0411                	addi	s0,s0,4
                  while (i >= 4) {
    2ad0:	fee41de3          	bne	s0,a4,2aca <stbsp_vsprintfcb+0x180c>
    2ad4:	0027979b          	slliw	a5,a5,0x2
    2ad8:	40f687bb          	subw	a5,a3,a5
                  while (i--)
    2adc:	fff7869b          	addiw	a3,a5,-1
    2ae0:	cf91                	beqz	a5,2afc <stbsp_vsprintfcb+0x183e>
    2ae2:	9fa1                	addw	a5,a5,s0
                     *bf++ = ' ';
    2ae4:	0705                	addi	a4,a4,1
                  while (i--)
    2ae6:	0007061b          	sext.w	a2,a4
                     *bf++ = ' ';
    2aea:	ff570fa3          	sb	s5,-1(a4)
                  while (i--)
    2aee:	fec79be3          	bne	a5,a2,2ae4 <stbsp_vsprintfcb+0x1826>
    2af2:	2685                	addiw	a3,a3,1
    2af4:	02069793          	slli	a5,a3,0x20
    2af8:	9381                	srli	a5,a5,0x20
    2afa:	943e                	add	s0,s0,a5
                  stbsp__chk_cb_buf(1);
    2afc:	00098f63          	beqz	s3,2b1a <stbsp_vsprintfcb+0x185c>
    2b00:	40a4063b          	subw	a2,s0,a0
    2b04:	00ca5b63          	bge	s4,a2,2b1a <stbsp_vsprintfcb+0x185c>
    2b08:	65a2                	ld	a1,8(sp)
    2b0a:	e81e                	sd	t2,16(sp)
    2b0c:	00cd0d3b          	addw	s10,s10,a2
    2b10:	9982                	jalr	s3
    2b12:	80050be3          	beqz	a0,2328 <stbsp_vsprintfcb+0x106a>
    2b16:	63c2                	ld	t2,16(sp)
    2b18:	842a                	mv	s0,a0
               while (fw) {
    2b1a:	f60915e3          	bnez	s2,2a84 <stbsp_vsprintfcb+0x17c6>
    2b1e:	892a                	mv	s2,a0
    2b20:	f21fe06f          	j	1a40 <stbsp_vsprintfcb+0x782>
                  stbsp__cb_buf_clamp(i, fw);
    2b24:	87ca                	mv	a5,s2
                  fw -= i;
    2b26:	4901                	li	s2,0
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    2b28:	b759                	j	2aae <stbsp_vsprintfcb+0x17f0>
   } else if (fl & STBSP__LEADINGPLUS) {
    2b2a:	002e7713          	andi	a4,t3,2
    2b2e:	94070663          	beqz	a4,1c7a <stbsp_vsprintfcb+0x9bc>
      sign[0] = 1;
    2b32:	670d                	lui	a4,0x3
    2b34:	b0170713          	addi	a4,a4,-1279 # 2b01 <stbsp_vsprintfcb+0x1843>
    2b38:	06e11423          	sh	a4,104(sp)
    2b3c:	93eff06f          	j	1c7a <stbsp_vsprintfcb+0x9bc>
      if (((stbsp__uintptr)sn & 3) == 0)
    2b40:	87d6                	mv	a5,s5
   while (limit >= 4) {
    2b42:	470d                	li	a4,3
    2b44:	22d77763          	bgeu	a4,a3,2d72 <stbsp_vsprintfcb+0x1ab4>
      if ((v - 0x01010101) & (~v) & 0x80808080UL)
    2b48:	feff05b7          	lui	a1,0xfeff0
    2b4c:	80808637          	lui	a2,0x80808
    2b50:	eff5859b          	addiw	a1,a1,-257 # fffffffffefefeff <_ZSt4cerr+0xfffffffffefe8697>
    2b54:	08060613          	addi	a2,a2,128 # ffffffff80808080 <_ZSt4cerr+0xffffffff80800818>
   while (limit >= 4) {
    2b58:	480d                	li	a6,3
    2b5a:	a029                	j	2b64 <stbsp_vsprintfcb+0x18a6>
      limit -= 4;
    2b5c:	36f1                	addiw	a3,a3,-4
      sn += 4;
    2b5e:	0791                	addi	a5,a5,4
   while (limit >= 4) {
    2b60:	20d87963          	bgeu	a6,a3,2d72 <stbsp_vsprintfcb+0x1ab4>
      stbsp__uint32 v = *(stbsp__uint32 *)sn;
    2b64:	4398                	lw	a4,0(a5)
      if ((v - 0x01010101) & (~v) & 0x80808080UL)
    2b66:	00b7053b          	addw	a0,a4,a1
    2b6a:	fff74713          	not	a4,a4
    2b6e:	8f69                	and	a4,a4,a0
    2b70:	8f71                	and	a4,a4,a2
    2b72:	2701                	sext.w	a4,a4
    2b74:	d765                	beqz	a4,2b5c <stbsp_vsprintfcb+0x189e>
    2b76:	02069713          	slli	a4,a3,0x20
    2b7a:	9301                	srli	a4,a4,0x20
    2b7c:	973e                	add	a4,a4,a5
    2b7e:	a021                	j	2b86 <stbsp_vsprintfcb+0x18c8>
      ++sn;
    2b80:	0785                	addi	a5,a5,1
   while (limit && *sn) {
    2b82:	00e78663          	beq	a5,a4,2b8e <stbsp_vsprintfcb+0x18d0>
    2b86:	0007c683          	lbu	a3,0(a5)
    2b8a:	fafd                	bnez	a3,2b80 <stbsp_vsprintfcb+0x18c2>
    2b8c:	873e                	mv	a4,a5
   return (stbsp__uint32)(sn - s);
    2b8e:	41570733          	sub	a4,a4,s5
    2b92:	0007069b          	sext.w	a3,a4
         if (pr < (stbsp__int32)l)
    2b96:	fff6c793          	not	a5,a3
    2b9a:	97fd                	srai	a5,a5,0x3f
    2b9c:	8f7d                	and	a4,a4,a5
    2b9e:	0007079b          	sext.w	a5,a4
         n = pr + lead[0] + tail[0] + tz;
    2ba2:	863e                	mv	a2,a5
         pr -= l;
    2ba4:	9f15                	subw	a4,a4,a3
   return (stbsp__uint32)(sn - s);
    2ba6:	d2eff06f          	j	20d4 <stbsp_vsprintfcb+0xe16>
         for (n = 1; n < l; n++)
    2baa:	4605                	li	a2,1
    2bac:	aed663e3          	bltu	a2,a3,2692 <stbsp_vsprintfcb+0x13d4>
    2bb0:	0c210613          	addi	a2,sp,194
    2bb4:	bcf5                	j	26b0 <stbsp_vsprintfcb+0x13f2>
            l = pr + 1;
    2bb6:	4685                	li	a3,1
         if ((l - 1) > (stbsp__uint32)pr)
    2bb8:	4501                	li	a0,0
         *s++ = sn[0];
    2bba:	0c110613          	addi	a2,sp,193
    2bbe:	bccd                	j	26b0 <stbsp_vsprintfcb+0x13f2>
    2bc0:	4591                	li	a1,4
    2bc2:	4f91                	li	t6,4
         n = (dp >= 100) ? 5 : 4;
    2bc4:	4e91                	li	t4,4
    2bc6:	be21                	j	26de <stbsp_vsprintfcb+0x1420>
    2bc8:	4a85                	li	s5,1
    2bca:	80000737          	lui	a4,0x80000
            pr = 1; // default is 6
    2bce:	4a05                	li	s4,1
    2bd0:	920ff06f          	j	1cf0 <stbsp_vsprintfcb+0xa32>
            dp = (n64) ? -1022 : 0;
    2bd4:	4601                	li	a2,0
    2bd6:	c119                	beqz	a0,2bdc <stbsp_vsprintfcb+0x191e>
    2bd8:	c0200613          	li	a2,-1022
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    2bdc:	872a                	mv	a4,a0
    2bde:	a3aff06f          	j	1e18 <stbsp_vsprintfcb+0xb5a>
                  stbsp__chk_cb_buf(1);
    2be2:	2601                	sext.w	a2,a2
    2be4:	1fe00793          	li	a5,510
    2be8:	f2c7c0e3          	blt	a5,a2,2b08 <stbsp_vsprintfcb+0x184a>
    2bec:	bd61                	j	2a84 <stbsp_vsprintfcb+0x17c6>
         tail[0] = (char)n;
    2bee:	4795                	li	a5,5
            tail[n] = '0' + dp % 10;
    2bf0:	06b10aa3          	sb	a1,117(sp)
         tail[0] = (char)n;
    2bf4:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    2bf8:	4815                	li	a6,5
    2bfa:	4f95                	li	t6,5
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    2bfc:	4595                	li	a1,5
    2bfe:	b935                	j	283a <stbsp_vsprintfcb+0x157c>
                  l = pr + dp;
    2c00:	011786bb          	addw	a3,a5,a7
    2c04:	d0b6                	sw	a3,96(sp)
    2c06:	b6d5                	j	27ea <stbsp_vsprintfcb+0x152c>
            s = (char *)"null";
    2c08:	00002a97          	auipc	s5,0x2
    2c0c:	4a8a8a93          	addi	s5,s5,1192 # 50b0 <_GLOBAL__sub_I__ZSt3cin+0xd0>
    2c10:	c80ff06f          	j	2090 <stbsp_vsprintfcb+0xdd2>
   } else if (fl & STBSP__LEADINGPLUS) {
    2c14:	002e7793          	andi	a5,t3,2
    2c18:	1c079c63          	bnez	a5,2df0 <stbsp_vsprintfcb+0x1b32>
   sign[0] = 0;
    2c1c:	4689                	li	a3,2
    2c1e:	4a09                	li	s4,2
    2c20:	4805                	li	a6,1
    2c22:	9e8ff06f          	j	1e0a <stbsp_vsprintfcb+0xb4c>
      sign[0] = 1;
    2c26:	670d                	lui	a4,0x3
    2c28:	b0170713          	addi	a4,a4,-1279 # 2b01 <stbsp_vsprintfcb+0x1843>
    2c2c:	06e11423          	sh	a4,104(sp)
    2c30:	b86ff06f          	j	1fb6 <stbsp_vsprintfcb+0xcf8>
               pr = 0;
    2c34:	4881                	li	a7,0
    2c36:	f1ffe06f          	j	1b54 <stbsp_vsprintfcb+0x896>
            *s++ = '0';
    2c3a:	03000713          	li	a4,48
    2c3e:	0ce10023          	sb	a4,192(sp)
            if (pr)
    2c42:	1a088c63          	beqz	a7,2dfa <stbsp_vsprintfcb+0x1b3c>
               *s++ = stbsp__period;
    2c46:	00004717          	auipc	a4,0x4
    2c4a:	df674703          	lbu	a4,-522(a4) # 6a3c <stbsp__period>
            n = -dp;
    2c4e:	40f007bb          	negw	a5,a5
               *s++ = stbsp__period;
    2c52:	0ce100a3          	sb	a4,193(sp)
            if ((stbsp__int32)n > pr)
    2c56:	0007871b          	sext.w	a4,a5
    2c5a:	00e8d363          	bge	a7,a4,2c60 <stbsp_vsprintfcb+0x19a2>
    2c5e:	87c6                	mv	a5,a7
    2c60:	0007871b          	sext.w	a4,a5
            if ((stbsp__int32)(l + n) > pr)
    2c64:	00d7833b          	addw	t1,a5,a3
    2c68:	883a                	mv	a6,a4
            while (i) {
    2c6a:	0c210793          	addi	a5,sp,194
               *s++ = '0';
    2c6e:	03000513          	li	a0,48
            while (i) {
    2c72:	e711                	bnez	a4,2c7e <stbsp_vsprintfcb+0x19c0>
    2c74:	a271                	j	2e00 <stbsp_vsprintfcb+0x1b42>
               if ((((stbsp__uintptr)s) & 3) == 0)
    2c76:	0037f613          	andi	a2,a5,3
    2c7a:	18060563          	beqz	a2,2e04 <stbsp_vsprintfcb+0x1b46>
               *s++ = '0';
    2c7e:	85ba                	mv	a1,a4
    2c80:	00a78023          	sb	a0,0(a5)
               --i;
    2c84:	377d                	addiw	a4,a4,-1
               *s++ = '0';
    2c86:	0785                	addi	a5,a5,1
            while (i) {
    2c88:	f77d                	bnez	a4,2c76 <stbsp_vsprintfcb+0x19b8>
            if ((stbsp__int32)(l + n) > pr)
    2c8a:	0003071b          	sext.w	a4,t1
    2c8e:	4108863b          	subw	a2,a7,a6
    2c92:	00e8d563          	bge	a7,a4,2c9c <stbsp_vsprintfcb+0x19de>
               l = pr - n;
    2c96:	0006069b          	sext.w	a3,a2
    2c9a:	d0b2                	sw	a2,96(sp)
            while (i) {
    2c9c:	c68d                	beqz	a3,2cc6 <stbsp_vsprintfcb+0x1a08>
    2c9e:	7566                	ld	a0,120(sp)
    2ca0:	02069813          	slli	a6,a3,0x20
    2ca4:	02085813          	srli	a6,a6,0x20
    2ca8:	01078eb3          	add	t4,a5,a6
    2cac:	85aa                	mv	a1,a0
    2cae:	873e                	mv	a4,a5
               *s++ = *sn++;
    2cb0:	0005c883          	lbu	a7,0(a1)
    2cb4:	0705                	addi	a4,a4,1
            while (i) {
    2cb6:	0585                	addi	a1,a1,1
               *s++ = *sn++;
    2cb8:	ff170fa3          	sb	a7,-1(a4)
            while (i) {
    2cbc:	ffd71ae3          	bne	a4,t4,2cb0 <stbsp_vsprintfcb+0x19f2>
    2cc0:	9542                	add	a0,a0,a6
    2cc2:	97c2                	add	a5,a5,a6
    2cc4:	fcaa                	sd	a0,120(sp)
         l = (stbsp__uint32)(s - (num + 64));
    2cc6:	0c010a93          	addi	s5,sp,192
            cs = 1 + (3 << 24); // how many tens did we write (for commas below)
    2cca:	030002b7          	lui	t0,0x3000
            tz = pr - (n + l);
    2cce:	40d608bb          	subw	a7,a2,a3
         l = (stbsp__uint32)(s - (num + 64));
    2cd2:	415787b3          	sub	a5,a5,s5
            cs = 1 + (3 << 24); // how many tens did we write (for commas below)
    2cd6:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff8799>
    2cd8:	fbcff06f          	j	2494 <stbsp_vsprintfcb+0x11d6>
            *--s = '0';
    2cdc:	03000793          	li	a5,48
    2ce0:	fefa8fa3          	sb	a5,-1(s5)
            l = 1;
    2ce4:	030002b7          	lui	t0,0x3000
    2ce8:	4785                	li	a5,1
    2cea:	d0be                	sw	a5,96(sp)
            *--s = '0';
    2cec:	1afd                	addi	s5,s5,-1
            l = 1;
    2cee:	4605                	li	a2,1
    2cf0:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff8799>
    2cf2:	4685                	li	a3,1
    2cf4:	b9dd                	j	29ea <stbsp_vsprintfcb+0x172c>
   } else if (fl & STBSP__LEADINGSPACE) {
    2cf6:	004e7713          	andi	a4,t3,4
    2cfa:	e74d                	bnez	a4,2da4 <stbsp_vsprintfcb+0x1ae6>
   } else if (fl & STBSP__LEADINGPLUS) {
    2cfc:	8b89                	andi	a5,a5,2
    2cfe:	efd9                	bnez	a5,2d9c <stbsp_vsprintfcb+0x1ade>
   sign[0] = 0;
    2d00:	06010423          	sb	zero,104(sp)
    2d04:	4a01                	li	s4,0
    2d06:	b9c9                	j	29d8 <stbsp_vsprintfcb+0x171a>
               if ((s[0] == '0') && (s != (num + STBSP__NUMSZ)))
    2d08:	051c                	addi	a5,sp,640
    2d0a:	cafa89e3          	beq	s5,a5,29bc <stbsp_vsprintfcb+0x16fe>
                  ++s;
    2d0e:	0a85                	addi	s5,s5,1
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    2d10:	415786bb          	subw	a3,a5,s5
    2d14:	b165                	j	29bc <stbsp_vsprintfcb+0x16fe>
                  n = dp - n;
    2d16:	40ce87bb          	subw	a5,t4,a2
                  if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    2d1a:	12030e63          	beqz	t1,2e56 <stbsp_vsprintfcb+0x1b98>
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2d1e:	4511                	li	a0,4
    2d20:	03000613          	li	a2,48
                        *s++ = stbsp__comma;
    2d24:	00170693          	addi	a3,a4,1
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2d28:	00030563          	beqz	t1,2d32 <stbsp_vsprintfcb+0x1a74>
    2d2c:	2585                	addiw	a1,a1,1
    2d2e:	00a58963          	beq	a1,a0,2d40 <stbsp_vsprintfcb+0x1a82>
    2d32:	8736                	mv	a4,a3
                        --n;
    2d34:	37fd                	addiw	a5,a5,-1
    2d36:	fec70fa3          	sb	a2,-1(a4)
                  while (n) {
    2d3a:	f7ed                	bnez	a5,2d24 <stbsp_vsprintfcb+0x1a66>
    2d3c:	f38ff06f          	j	2474 <stbsp_vsprintfcb+0x11b6>
    2d40:	fe568fa3          	sb	t0,-1(a3)
                        *s++ = stbsp__comma;
    2d44:	0709                	addi	a4,a4,2
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2d46:	4585                	li	a1,1
    2d48:	b7f5                	j	2d34 <stbsp_vsprintfcb+0x1a76>
   sign[0] = 0;
    2d4a:	06010423          	sb	zero,104(sp)
    2d4e:	f1dfe06f          	j	1c6a <stbsp_vsprintfcb+0x9ac>
                     tail[idx + 1] = "_kMGT"[fl >> 24];
    2d52:	00002697          	auipc	a3,0x2
    2d56:	36e68693          	addi	a3,a3,878 # 50c0 <_GLOBAL__sub_I__ZSt3cin+0xe0>
    2d5a:	9736                	add	a4,a4,a3
    2d5c:	00074683          	lbu	a3,0(a4)
    2d60:	1088                	addi	a0,sp,96
    2d62:	22060713          	addi	a4,a2,544
    2d66:	972a                	add	a4,a4,a0
    2d68:	ded70823          	sb	a3,-528(a4)
                  idx++;
    2d6c:	8fb2                	mv	t6,a2
    2d6e:	fb0ff06f          	j	251e <stbsp_vsprintfcb+0x1260>
   while (limit && *sn) {
    2d72:	e00692e3          	bnez	a3,2b76 <stbsp_vsprintfcb+0x18b8>
    2d76:	bd19                	j	2b8c <stbsp_vsprintfcb+0x18ce>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    2d78:	0008071b          	sext.w	a4,a6
    2d7c:	86c2                	mv	a3,a6
    2d7e:	88d2                	mv	a7,s4
            pr = -dp + ((pr > (stbsp__int32)l) ? (stbsp__int32) l : pr);
    2d80:	863a                	mv	a2,a4
    2d82:	00e8d363          	bge	a7,a4,2d88 <stbsp_vsprintfcb+0x1aca>
    2d86:	8646                	mv	a2,a7
    2d88:	40f608bb          	subw	a7,a2,a5
    2d8c:	814ff06f          	j	1da0 <stbsp_vsprintfcb+0xae2>
            divisor = 1000.0f;
    2d90:	00003797          	auipc	a5,0x3
    2d94:	ad07b787          	fld	fa5,-1328(a5) # 5860 <STDIN_FD+0x28>
    2d98:	dd5fe06f          	j	1b6c <stbsp_vsprintfcb+0x8ae>
    2d9c:	678d                	lui	a5,0x3
    2d9e:	b017879b          	addiw	a5,a5,-1279 # 2b01 <stbsp_vsprintfcb+0x1843>
    2da2:	b13d                	j	29d0 <stbsp_vsprintfcb+0x1712>
    2da4:	6789                	lui	a5,0x2
    2da6:	2785                	addiw	a5,a5,1 # 2001 <stbsp_vsprintfcb+0xd43>
    2da8:	b125                	j	29d0 <stbsp_vsprintfcb+0x1712>
            *s++ = stbsp__period;
    2daa:	00004517          	auipc	a0,0x4
    2dae:	c9254503          	lbu	a0,-878(a0) # 6a3c <stbsp__period>
         sn = s;
    2db2:	0c210793          	addi	a5,sp,194
         n = pr;
    2db6:	0008869b          	sext.w	a3,a7
            *s++ = stbsp__period;
    2dba:	0ca100a3          	sb	a0,193(sp)
         sn = s;
    2dbe:	fcbe                	sd	a5,120(sp)
         if (n > 13)
    2dc0:	4535                	li	a0,13
         n64 <<= 4;
    2dc2:	0712                	slli	a4,a4,0x4
         if (n > 13)
    2dc4:	8836                	mv	a6,a3
    2dc6:	00d57363          	bgeu	a0,a3,2dcc <stbsp_vsprintfcb+0x1b0e>
    2dca:	4835                	li	a6,13
    2dcc:	0008051b          	sext.w	a0,a6
         while (n--) {
    2dd0:	387d                	addiw	a6,a6,-1
         if (pr > (stbsp__int32)n)
    2dd2:	af1542e3          	blt	a0,a7,28b6 <stbsp_vsprintfcb+0x15f8>
      tz = 0;
    2dd6:	4881                	li	a7,0
    2dd8:	b4cd                	j	28ba <stbsp_vsprintfcb+0x15fc>
               while (n < l) {
    2dda:	87ba                	mv	a5,a4
    2ddc:	bc1d                	j	2812 <stbsp_vsprintfcb+0x1554>
         tail[0] = (char)n;
    2dde:	478d                	li	a5,3
    2de0:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    2de4:	06b109a3          	sb	a1,115(sp)
    2de8:	480d                	li	a6,3
    2dea:	4f8d                	li	t6,3
    2dec:	8e4ff06f          	j	1ed0 <stbsp_vsprintfcb+0xc12>
    2df0:	678d                	lui	a5,0x3
    2df2:	b017879b          	addiw	a5,a5,-1279 # 2b01 <stbsp_vsprintfcb+0x1843>
    2df6:	80aff06f          	j	1e00 <stbsp_vsprintfcb+0xb42>
            if (pr)
    2dfa:	8336                	mv	t1,a3
            *s++ = '0';
    2dfc:	0c110793          	addi	a5,sp,193
            while (i) {
    2e00:	4801                	li	a6,0
    2e02:	b561                	j	2c8a <stbsp_vsprintfcb+0x19cc>
            while (i >= 4) {
    2e04:	460d                	li	a2,3
    2e06:	04e65663          	bge	a2,a4,2e52 <stbsp_vsprintfcb+0x1b94>
    2e0a:	ffb5871b          	addiw	a4,a1,-5
    2e0e:	0027559b          	srliw	a1,a4,0x2
    2e12:	0015861b          	addiw	a2,a1,1
    2e16:	060a                	slli	a2,a2,0x2
               *(stbsp__uint32 *)s = 0x30303030;
    2e18:	30303537          	lui	a0,0x30303
    2e1c:	963e                	add	a2,a2,a5
    2e1e:	03050513          	addi	a0,a0,48 # 30303030 <_ZSt4cerr+0x302fb7c8>
    2e22:	c388                	sw	a0,0(a5)
               s += 4;
    2e24:	0791                	addi	a5,a5,4
            while (i >= 4) {
    2e26:	fef61ee3          	bne	a2,a5,2e22 <stbsp_vsprintfcb+0x1b64>
    2e2a:	0025959b          	slliw	a1,a1,0x2
    2e2e:	9f0d                	subw	a4,a4,a1
            while (i) {
    2e30:	e4070de3          	beqz	a4,2c8a <stbsp_vsprintfcb+0x19cc>
               *s++ = '0';
    2e34:	03000513          	li	a0,48
            while (i) {
    2e38:	00f705bb          	addw	a1,a4,a5
               *s++ = '0';
    2e3c:	0605                	addi	a2,a2,1
            while (i) {
    2e3e:	00060e9b          	sext.w	t4,a2
               *s++ = '0';
    2e42:	fea60fa3          	sb	a0,-1(a2)
            while (i) {
    2e46:	ffd59be3          	bne	a1,t4,2e3c <stbsp_vsprintfcb+0x1b7e>
    2e4a:	1702                	slli	a4,a4,0x20
    2e4c:	9301                	srli	a4,a4,0x20
    2e4e:	97ba                	add	a5,a5,a4
    2e50:	bd2d                	j	2c8a <stbsp_vsprintfcb+0x19cc>
            while (i >= 4) {
    2e52:	863e                	mv	a2,a5
    2e54:	b7c5                	j	2e34 <stbsp_vsprintfcb+0x1b76>
                        if ((((stbsp__uintptr)s) & 3) == 0)
    2e56:	00377693          	andi	a3,a4,3
    2e5a:	ce81                	beqz	a3,2e72 <stbsp_vsprintfcb+0x1bb4>
                        *s++ = '0';
    2e5c:	03000693          	li	a3,48
    2e60:	00d70023          	sb	a3,0(a4)
                        --n;
    2e64:	37fd                	addiw	a5,a5,-1
                        *s++ = '0';
    2e66:	0705                	addi	a4,a4,1
                     while (n) {
    2e68:	e0078663          	beqz	a5,2474 <stbsp_vsprintfcb+0x11b6>
                        if ((((stbsp__uintptr)s) & 3) == 0)
    2e6c:	00377613          	andi	a2,a4,3
    2e70:	fa65                	bnez	a2,2e60 <stbsp_vsprintfcb+0x1ba2>
                     while (n >= 4) {
    2e72:	468d                	li	a3,3
    2e74:	eaf6f5e3          	bgeu	a3,a5,2d1e <stbsp_vsprintfcb+0x1a60>
    2e78:	ffc7869b          	addiw	a3,a5,-4
    2e7c:	0026d69b          	srliw	a3,a3,0x2
    2e80:	2685                	addiw	a3,a3,1
    2e82:	068a                	slli	a3,a3,0x2
                        *(stbsp__uint32 *)s = 0x30303030;
    2e84:	30303637          	lui	a2,0x30303
    2e88:	96ba                	add	a3,a3,a4
    2e8a:	03060613          	addi	a2,a2,48 # 30303030 <_ZSt4cerr+0x302fb7c8>
    2e8e:	c310                	sw	a2,0(a4)
                        s += 4;
    2e90:	0711                	addi	a4,a4,4
                     while (n >= 4) {
    2e92:	fed71ee3          	bne	a4,a3,2e8e <stbsp_vsprintfcb+0x1bd0>
    2e96:	8b8d                	andi	a5,a5,3
                  while (n) {
    2e98:	e80793e3          	bnez	a5,2d1e <stbsp_vsprintfcb+0x1a60>
    2e9c:	dd8ff06f          	j	2474 <stbsp_vsprintfcb+0x11b6>
      if (((stbsp__uintptr)sn & 3) == 0)
    2ea0:	87d6                	mv	a5,s5
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    2ea2:	56fd                	li	a3,-1
    2ea4:	b155                	j	2b48 <stbsp_vsprintfcb+0x188a>
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    2ea6:	5775                	li	a4,-3
    2ea8:	00e7ce63          	blt	a5,a4,2ec4 <stbsp_vsprintfcb+0x1c06>
    2eac:	f6fa4663          	blt	s4,a5,2618 <stbsp_vsprintfcb+0x135a>
         if (dp > 0) {
    2eb0:	ecf054e3          	blez	a5,2d78 <stbsp_vsprintfcb+0x1aba>
    2eb4:	86c2                	mv	a3,a6
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    2eb6:	4881                	li	a7,0
    2eb8:	ee9fe06f          	j	1da0 <stbsp_vsprintfcb+0xae2>
                  while (i--)
    2ebc:	fff7869b          	addiw	a3,a5,-1
    2ec0:	8722                	mv	a4,s0
    2ec2:	b105                	j	2ae2 <stbsp_vsprintfcb+0x1824>
            if (pr > (stbsp__int32)l)
    2ec4:	0008071b          	sext.w	a4,a6
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2ec8:	7ae6                	ld	s5,120(sp)
            if (pr > (stbsp__int32)l)
    2eca:	86c2                	mv	a3,a6
    2ecc:	88d2                	mv	a7,s4
    2ece:	f7475d63          	bge	a4,s4,2648 <stbsp_vsprintfcb+0x138a>
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2ed2:	8542                	mv	a0,a6
    2ed4:	f56ff06f          	j	262a <stbsp_vsprintfcb+0x136c>

0000000000002ed8 <stbsp_sprintf>:
{
    2ed8:	715d                	addi	sp,sp,-80
   va_start(va, fmt);
    2eda:	02010313          	addi	t1,sp,32
{
    2ede:	f032                	sd	a2,32(sp)
    2ee0:	f436                	sd	a3,40(sp)
    2ee2:	f83a                	sd	a4,48(sp)
   result = STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    2ee4:	86ae                	mv	a3,a1
    2ee6:	862a                	mv	a2,a0
    2ee8:	871a                	mv	a4,t1
    2eea:	4581                	li	a1,0
    2eec:	4501                	li	a0,0
{
    2eee:	ec06                	sd	ra,24(sp)
    2ef0:	fc3e                	sd	a5,56(sp)
    2ef2:	e0c2                	sd	a6,64(sp)
    2ef4:	e4c6                	sd	a7,72(sp)
   va_start(va, fmt);
    2ef6:	e41a                	sd	t1,8(sp)
   result = STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    2ef8:	bc6fe0ef          	jal	12be <stbsp_vsprintfcb>
}
    2efc:	60e2                	ld	ra,24(sp)
    2efe:	6161                	addi	sp,sp,80
    2f00:	8082                	ret

0000000000002f02 <stbsp_vsnprintf>:
{
    2f02:	dd010113          	addi	sp,sp,-560
    2f06:	22813023          	sd	s0,544(sp)
    2f0a:	20913c23          	sd	s1,536(sp)
    2f0e:	22113423          	sd	ra,552(sp)
    2f12:	84ae                	mv	s1,a1
    2f14:	842a                	mv	s0,a0
    2f16:	88b2                	mv	a7,a2
    2f18:	8736                	mv	a4,a3
   if ( (count == 0) && !buf )
    2f1a:	e591                	bnez	a1,2f26 <stbsp_vsnprintf+0x24>
    2f1c:	c141                	beqz	a0,2f9c <stbsp_vsnprintf+0x9a>
      c.buf = buf;
    2f1e:	e02a                	sd	a0,0(sp)
      c.count = count;
    2f20:	e402                	sd	zero,8(sp)
   return (c->count >= STB_SPRINTF_MIN) ? c->buf : c->tmp; // go direct into buffer if you can
    2f22:	0810                	addi	a2,sp,16
    2f24:	a089                	j	2f66 <stbsp_vsnprintf+0x64>
   if (len > c->count)
    2f26:	0015a593          	slti	a1,a1,1
    2f2a:	40b005bb          	negw	a1,a1
    2f2e:	8de5                	and	a1,a1,s1
      c.buf = buf;
    2f30:	e02a                	sd	a0,0(sp)
      c.count = count;
    2f32:	c426                	sw	s1,8(sp)
      c.length = 0;
    2f34:	c602                	sw	zero,12(sp)
   if (len > c->count)
    2f36:	2581                	sext.w	a1,a1
   if (len) {
    2f38:	0804d663          	bgez	s1,2fc4 <stbsp_vsnprintf+0xc2>
         s = buf;
    2f3c:	4781                	li	a5,0
      if (buf != c->buf) {
    2f3e:	c911                	beqz	a0,2f52 <stbsp_vsnprintf+0x50>
            *d++ = *s++;
    2f40:	0007c803          	lbu	a6,0(a5)
    2f44:	0785                	addi	a5,a5,1
    2f46:	00f40533          	add	a0,s0,a5
    2f4a:	ff050fa3          	sb	a6,-1(a0)
         } while (s < se);
    2f4e:	feb7e9e3          	bltu	a5,a1,2f40 <stbsp_vsnprintf+0x3e>
      c->count -= len;
    2f52:	40b486bb          	subw	a3,s1,a1
      c->buf += len;
    2f56:	95a2                	add	a1,a1,s0
    2f58:	e02e                	sd	a1,0(sp)
      c->count -= len;
    2f5a:	c436                	sw	a3,8(sp)
   return (c->count >= STB_SPRINTF_MIN) ? c->buf : c->tmp; // go direct into buffer if you can
    2f5c:	1ff00793          	li	a5,511
    2f60:	fcd7d1e3          	bge	a5,a3,2f22 <stbsp_vsnprintf+0x20>
    2f64:	6602                	ld	a2,0(sp)
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__clamp_callback, &c, stbsp__clamp_callback(0,&c,0), fmt, va );
    2f66:	86c6                	mv	a3,a7
    2f68:	858a                	mv	a1,sp
    2f6a:	ffffd517          	auipc	a0,0xffffd
    2f6e:	21650513          	addi	a0,a0,534 # 180 <stbsp__clamp_callback>
    2f72:	b4cfe0ef          	jal	12be <stbsp_vsprintfcb>
      l = (int)( c.buf - buf );
    2f76:	6782                	ld	a5,0(sp)
    2f78:	9f81                	subw	a5,a5,s0
      if ( l >= count ) // should never be greater, only equal (or less) than count
    2f7a:	0097c463          	blt	a5,s1,2f82 <stbsp_vsnprintf+0x80>
         l = count - 1;
    2f7e:	fff4879b          	addiw	a5,s1,-1
      buf[l] = 0;
    2f82:	943e                	add	s0,s0,a5
    2f84:	00040023          	sb	zero,0(s0)
}
    2f88:	22813083          	ld	ra,552(sp)
    2f8c:	22013403          	ld	s0,544(sp)
    2f90:	4532                	lw	a0,12(sp)
    2f92:	21813483          	ld	s1,536(sp)
    2f96:	23010113          	addi	sp,sp,560
    2f9a:	8082                	ret
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__count_clamp_callback, &c, c.tmp, fmt, va );
    2f9c:	86b2                	mv	a3,a2
    2f9e:	858a                	mv	a1,sp
    2fa0:	0810                	addi	a2,sp,16
    2fa2:	ffffd517          	auipc	a0,0xffffd
    2fa6:	22c50513          	addi	a0,a0,556 # 1ce <stbsp__count_clamp_callback>
      c.length = 0;
    2faa:	c602                	sw	zero,12(sp)
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__count_clamp_callback, &c, c.tmp, fmt, va );
    2fac:	b12fe0ef          	jal	12be <stbsp_vsprintfcb>
}
    2fb0:	22813083          	ld	ra,552(sp)
    2fb4:	22013403          	ld	s0,544(sp)
    2fb8:	4532                	lw	a0,12(sp)
    2fba:	21813483          	ld	s1,536(sp)
    2fbe:	23010113          	addi	sp,sp,560
    2fc2:	8082                	ret
    2fc4:	86a6                	mv	a3,s1
    2fc6:	bf59                	j	2f5c <stbsp_vsnprintf+0x5a>

0000000000002fc8 <stbsp_snprintf>:
{
    2fc8:	715d                	addi	sp,sp,-80
   va_start(va, fmt);
    2fca:	02810313          	addi	t1,sp,40
{
    2fce:	f436                	sd	a3,40(sp)
   result = STB_SPRINTF_DECORATE(vsnprintf)(buf, count, fmt, va);
    2fd0:	869a                	mv	a3,t1
{
    2fd2:	ec06                	sd	ra,24(sp)
    2fd4:	f83a                	sd	a4,48(sp)
    2fd6:	fc3e                	sd	a5,56(sp)
    2fd8:	e0c2                	sd	a6,64(sp)
    2fda:	e4c6                	sd	a7,72(sp)
   va_start(va, fmt);
    2fdc:	e41a                	sd	t1,8(sp)
   result = STB_SPRINTF_DECORATE(vsnprintf)(buf, count, fmt, va);
    2fde:	f25ff0ef          	jal	2f02 <stbsp_vsnprintf>
}
    2fe2:	60e2                	ld	ra,24(sp)
    2fe4:	6161                	addi	sp,sp,80
    2fe6:	8082                	ret

0000000000002fe8 <stbsp_vsprintf>:
{
    2fe8:	86ae                	mv	a3,a1
    2fea:	8732                	mv	a4,a2
   return STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    2fec:	4581                	li	a1,0
    2fee:	862a                	mv	a2,a0
    2ff0:	4501                	li	a0,0
    2ff2:	accfe06f          	j	12be <stbsp_vsprintfcb>

0000000000002ff6 <sprintf>:
{
    2ff6:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    2ff8:	05010313          	addi	t1,sp,80
{
    2ffc:	e0a2                	sd	s0,64(sp)
    2ffe:	fc26                	sd	s1,56(sp)
    3000:	842a                	mv	s0,a0
    3002:	e8b2                	sd	a2,80(sp)
    _vprintf_core(&ctx, format, ap);
    3004:	0808                	addi	a0,sp,16
    ctx.limit = size;
    3006:	54fd                	li	s1,-1
    _vprintf_core(&ctx, format, ap);
    3008:	861a                	mv	a2,t1
{
    300a:	e486                	sd	ra,72(sp)
    300c:	ecb6                	sd	a3,88(sp)
    300e:	f0ba                	sd	a4,96(sp)
    3010:	f4be                	sd	a5,104(sp)
    3012:	f8c2                	sd	a6,112(sp)
    3014:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    3016:	e41a                	sd	t1,8(sp)
    ctx.buf = str;
    3018:	e822                	sd	s0,16(sp)
    ctx.limit = size;
    301a:	ec26                	sd	s1,24(sp)
    ctx.written = 0;
    301c:	f002                	sd	zero,32(sp)
    ctx.stream = NULL;
    301e:	f402                	sd	zero,40(sp)
    _vprintf_core(&ctx, format, ap);
    3020:	02c000ef          	jal	304c <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    3024:	7502                	ld	a0,32(sp)
    3026:	00950b63          	beq	a0,s1,303c <sprintf+0x46>
            str[ctx.written] = '\0';
    302a:	942a                	add	s0,s0,a0
    302c:	00040023          	sb	zero,0(s0)
}
    3030:	60a6                	ld	ra,72(sp)
    3032:	6406                	ld	s0,64(sp)
    3034:	74e2                	ld	s1,56(sp)
    3036:	2501                	sext.w	a0,a0
    3038:	6109                	addi	sp,sp,128
    303a:	8082                	ret
            str[size - 1] = '\0';
    303c:	fe040f23          	sb	zero,-2(s0)
}
    3040:	60a6                	ld	ra,72(sp)
    3042:	6406                	ld	s0,64(sp)
    3044:	74e2                	ld	s1,56(sp)
    3046:	2501                	sext.w	a0,a0
    3048:	6109                	addi	sp,sp,128
    304a:	8082                	ret

000000000000304c <_vprintf_core.constprop.0.isra.0>:
static int _vprintf_core(_OutContext *ctx, const char *format, va_list ap)
    304c:	7129                	addi	sp,sp,-320
    304e:	edee                	sd	s11,216(sp)
    3050:	fe06                	sd	ra,312(sp)
    3052:	8dae                	mv	s11,a1
    while (*p)
    3054:	0005c583          	lbu	a1,0(a1)
    3058:	cde9                	beqz	a1,3132 <_vprintf_core.constprop.0.isra.0+0xe6>
    305a:	f626                	sd	s1,296(sp)
    305c:	f24a                	sd	s2,288(sp)
    305e:	ee4e                	sd	s3,280(sp)
    3060:	e656                	sd	s5,264(sp)
    3062:	f9e2                	sd	s8,240(sp)
    3064:	fa22                	sd	s0,304(sp)
    3066:	ea52                	sd	s4,272(sp)
    3068:	e25a                	sd	s6,256(sp)
    306a:	fdde                	sd	s7,248(sp)
    306c:	f5e6                	sd	s9,232(sp)
    306e:	f1ea                	sd	s10,224(sp)
    3070:	84aa                	mv	s1,a0
    3072:	8c32                	mv	s8,a2
        if (*p != '%')
    3074:	02500a93          	li	s5,37
    3078:	49c1                	li	s3,16
    307a:	00002917          	auipc	s2,0x2
    307e:	31a90913          	addi	s2,s2,794 # 5394 <_GLOBAL__sub_I__ZSt3cin+0x3b4>
    3082:	a039                	j	3090 <_vprintf_core.constprop.0.isra.0+0x44>
                _out_char(ctx, spec);
    3084:	8526                	mv	a0,s1
    3086:	952fe0ef          	jal	11d8 <_out_char>
    while (*p)
    308a:	000dc583          	lbu	a1,0(s11)
    308e:	c5d9                	beqz	a1,311c <_vprintf_core.constprop.0.isra.0+0xd0>
            _out_char(ctx, *p++);
    3090:	0d85                	addi	s11,s11,1
        if (*p != '%')
    3092:	ff5599e3          	bne	a1,s5,3084 <_vprintf_core.constprop.0.isra.0+0x38>
        int flag_left = 0, flag_zero = 0, flag_plus = 0, flag_space = 0, flag_hash = 0;
    3096:	4501                	li	a0,0
    3098:	4881                	li	a7,0
    309a:	4581                	li	a1,0
    309c:	4b01                	li	s6,0
    309e:	4a01                	li	s4,0
            if (*p == '-')
    30a0:	000dcc83          	lbu	s9,0(s11)
    30a4:	fe0c871b          	addiw	a4,s9,-32
    30a8:	0ff77713          	zext.b	a4,a4
    30ac:	00e9e763          	bltu	s3,a4,30ba <_vprintf_core.constprop.0.isra.0+0x6e>
    30b0:	070a                	slli	a4,a4,0x2
    30b2:	974a                	add	a4,a4,s2
    30b4:	4318                	lw	a4,0(a4)
    30b6:	974a                	add	a4,a4,s2
    30b8:	8702                	jr	a4
        if (*p == '*')
    30ba:	02a00793          	li	a5,42
    30be:	16fc9c63          	bne	s9,a5,3236 <_vprintf_core.constprop.0.isra.0+0x1ea>
            width = va_arg(ap, int);
    30c2:	000c2403          	lw	s0,0(s8)
    30c6:	0c21                	addi	s8,s8,8
            if (width < 0)
    30c8:	00045563          	bgez	s0,30d2 <_vprintf_core.constprop.0.isra.0+0x86>
                width = -width;
    30cc:	4080043b          	negw	s0,s0
                flag_left = 1;
    30d0:	4a05                	li	s4,1
            while (*p >= '0' && *p <= '9')
    30d2:	001dcc83          	lbu	s9,1(s11)
            p++;
    30d6:	0d85                	addi	s11,s11,1
        if (*p == '.')
    30d8:	02e00793          	li	a5,46
        int precision = -1;
    30dc:	5bfd                	li	s7,-1
        if (*p == '.')
    30de:	18fc8a63          	beq	s9,a5,3272 <_vprintf_core.constprop.0.isra.0+0x226>
        if (*p == 'l')
    30e2:	06c00693          	li	a3,108
    30e6:	8666                	mv	a2,s9
    30e8:	1adc8663          	beq	s9,a3,3294 <_vprintf_core.constprop.0.isra.0+0x248>
        else if (*p == 'z')
    30ec:	07a00693          	li	a3,122
            p++;
    30f0:	0d85                	addi	s11,s11,1
        else if (*p == 'z')
    30f2:	24dc8163          	beq	s9,a3,3334 <_vprintf_core.constprop.0.isra.0+0x2e8>
        if (!spec)
    30f6:	06400693          	li	a3,100
    30fa:	4adc8163          	beq	s9,a3,359c <_vprintf_core.constprop.0.isra.0+0x550>
    30fe:	06400693          	li	a3,100
        int len_mod = 0;
    3102:	4e81                	li	t4,0
    3104:	1b96e663          	bltu	a3,s9,32b0 <_vprintf_core.constprop.0.isra.0+0x264>
    3108:	04700693          	li	a3,71
    310c:	2796e463          	bltu	a3,s9,3374 <_vprintf_core.constprop.0.isra.0+0x328>
    3110:	04400693          	li	a3,68
    3114:	0596e363          	bltu	a3,s9,315a <_vprintf_core.constprop.0.isra.0+0x10e>
    3118:	240c9363          	bnez	s9,335e <_vprintf_core.constprop.0.isra.0+0x312>
    311c:	7452                	ld	s0,304(sp)
    311e:	74b2                	ld	s1,296(sp)
    3120:	7912                	ld	s2,288(sp)
    3122:	69f2                	ld	s3,280(sp)
    3124:	6a52                	ld	s4,272(sp)
    3126:	6ab2                	ld	s5,264(sp)
    3128:	6b12                	ld	s6,256(sp)
    312a:	7bee                	ld	s7,248(sp)
    312c:	7c4e                	ld	s8,240(sp)
    312e:	7cae                	ld	s9,232(sp)
    3130:	7d0e                	ld	s10,224(sp)
}
    3132:	70f2                	ld	ra,312(sp)
    3134:	6dee                	ld	s11,216(sp)
    3136:	6131                	addi	sp,sp,320
    3138:	8082                	ret
            if (*p == '-')
    313a:	4585                	li	a1,1
            p++;
    313c:	0d85                	addi	s11,s11,1
            if (*p == '-')
    313e:	b78d                	j	30a0 <_vprintf_core.constprop.0.isra.0+0x54>
    3140:	4505                	li	a0,1
            p++;
    3142:	0d85                	addi	s11,s11,1
        while (1)
    3144:	bfb1                	j	30a0 <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    3146:	4885                	li	a7,1
            p++;
    3148:	0d85                	addi	s11,s11,1
        while (1)
    314a:	bf99                	j	30a0 <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    314c:	4b05                	li	s6,1
            p++;
    314e:	0d85                	addi	s11,s11,1
        while (1)
    3150:	bf81                	j	30a0 <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    3152:	4a05                	li	s4,1
            p++;
    3154:	0d85                	addi	s11,s11,1
        while (1)
    3156:	b7a9                	j	30a0 <_vprintf_core.constprop.0.isra.0+0x54>
        char spec = *p++;
    3158:	8dbe                	mv	s11,a5
            fmt_tmp[f_idx++] = '%';
    315a:	02500693          	li	a3,37
    315e:	02d10823          	sb	a3,48(sp)
    3162:	4d05                	li	s10,1
            if (flag_left)
    3164:	000a0763          	beqz	s4,3172 <_vprintf_core.constprop.0.isra.0+0x126>
                fmt_tmp[f_idx++] = '-';
    3168:	02d00693          	li	a3,45
    316c:	02d108a3          	sb	a3,49(sp)
    3170:	4d09                	li	s10,2
            if (flag_zero)
    3172:	000b0c63          	beqz	s6,318a <_vprintf_core.constprop.0.isra.0+0x13e>
                fmt_tmp[f_idx++] = '0';
    3176:	0c0d0793          	addi	a5,s10,192
    317a:	0818                	addi	a4,sp,16
    317c:	00e786b3          	add	a3,a5,a4
    3180:	03000613          	li	a2,48
    3184:	f6c68023          	sb	a2,-160(a3)
    3188:	2d05                	addiw	s10,s10,1
            if (flag_plus)
    318a:	c999                	beqz	a1,31a0 <_vprintf_core.constprop.0.isra.0+0x154>
                fmt_tmp[f_idx++] = '+';
    318c:	0c0d0793          	addi	a5,s10,192
    3190:	0818                	addi	a4,sp,16
    3192:	00e786b3          	add	a3,a5,a4
    3196:	02b00613          	li	a2,43
    319a:	f6c68023          	sb	a2,-160(a3)
    319e:	2d05                	addiw	s10,s10,1
            if (flag_space)
    31a0:	00088c63          	beqz	a7,31b8 <_vprintf_core.constprop.0.isra.0+0x16c>
                fmt_tmp[f_idx++] = ' ';
    31a4:	0c0d0793          	addi	a5,s10,192
    31a8:	0818                	addi	a4,sp,16
    31aa:	00e786b3          	add	a3,a5,a4
    31ae:	02000613          	li	a2,32
    31b2:	f6c68023          	sb	a2,-160(a3)
    31b6:	2d05                	addiw	s10,s10,1
            if (flag_hash)
    31b8:	c919                	beqz	a0,31ce <_vprintf_core.constprop.0.isra.0+0x182>
                fmt_tmp[f_idx++] = '#';
    31ba:	0c0d0793          	addi	a5,s10,192
    31be:	0818                	addi	a4,sp,16
    31c0:	00e786b3          	add	a3,a5,a4
    31c4:	02300613          	li	a2,35
    31c8:	f6c68023          	sb	a2,-160(a3)
    31cc:	2d05                	addiw	s10,s10,1
            if (width > 0)
    31ce:	03010a13          	addi	s4,sp,48
    31d2:	28804563          	bgtz	s0,345c <_vprintf_core.constprop.0.isra.0+0x410>
            if (precision >= 0)
    31d6:	260bd763          	bgez	s7,3444 <_vprintf_core.constprop.0.isra.0+0x3f8>
            fmt_tmp[f_idx++] = spec;
    31da:	0c0d0793          	addi	a5,s10,192
    31de:	0818                	addi	a4,sp,16
    31e0:	00e78633          	add	a2,a5,a4
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    31e4:	000c3683          	ld	a3,0(s8)
            fmt_tmp[f_idx] = '\0';
    31e8:	001d071b          	addiw	a4,s10,1
    31ec:	0c070793          	addi	a5,a4,192
    31f0:	0818                	addi	a4,sp,16
            fmt_tmp[f_idx++] = spec;
    31f2:	f7960023          	sb	s9,-160(a2)
            fmt_tmp[f_idx] = '\0';
    31f6:	973e                	add	a4,a4,a5
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    31f8:	08000593          	li	a1,128
    31fc:	8652                	mv	a2,s4
    31fe:	0888                	addi	a0,sp,80
            fmt_tmp[f_idx] = '\0';
    3200:	f6070023          	sb	zero,-160(a4)
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    3204:	dc5ff0ef          	jal	2fc8 <stbsp_snprintf>
            for (int i = 0; f_buf[i] != '\0'; i++)
    3208:	05014583          	lbu	a1,80(sp)
            double f_val = va_arg(ap, double);
    320c:	0c21                	addi	s8,s8,8
            for (int i = 0; f_buf[i] != '\0'; i++)
    320e:	05110413          	addi	s0,sp,81
    3212:	e6058ce3          	beqz	a1,308a <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, f_buf[i]);
    3216:	8526                	mv	a0,s1
    3218:	fc1fd0ef          	jal	11d8 <_out_char>
            for (int i = 0; f_buf[i] != '\0'; i++)
    321c:	00044583          	lbu	a1,0(s0)
    3220:	0405                	addi	s0,s0,1
    3222:	e60584e3          	beqz	a1,308a <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, f_buf[i]);
    3226:	8526                	mv	a0,s1
    3228:	fb1fd0ef          	jal	11d8 <_out_char>
            for (int i = 0; f_buf[i] != '\0'; i++)
    322c:	00044583          	lbu	a1,0(s0)
    3230:	0405                	addi	s0,s0,1
    3232:	f1f5                	bnez	a1,3216 <_vprintf_core.constprop.0.isra.0+0x1ca>
    3234:	bd99                	j	308a <_vprintf_core.constprop.0.isra.0+0x3e>
            while (*p >= '0' && *p <= '9')
    3236:	fd0c869b          	addiw	a3,s9,-48
    323a:	0ff6f313          	zext.b	t1,a3
    323e:	4725                	li	a4,9
        int width = 0;
    3240:	4401                	li	s0,0
            while (*p >= '0' && *p <= '9')
    3242:	4625                	li	a2,9
    3244:	e8676ae3          	bltu	a4,t1,30d8 <_vprintf_core.constprop.0.isra.0+0x8c>
    3248:	001dcc83          	lbu	s9,1(s11)
                width = width * 10 + (*p - '0');
    324c:	0024171b          	slliw	a4,s0,0x2
    3250:	9f21                	addw	a4,a4,s0
    3252:	0017171b          	slliw	a4,a4,0x1
    3256:	00e6843b          	addw	s0,a3,a4
            while (*p >= '0' && *p <= '9')
    325a:	fd0c869b          	addiw	a3,s9,-48
    325e:	0ff6f713          	zext.b	a4,a3
                p++;
    3262:	0d85                	addi	s11,s11,1
            while (*p >= '0' && *p <= '9')
    3264:	fee672e3          	bgeu	a2,a4,3248 <_vprintf_core.constprop.0.isra.0+0x1fc>
        if (*p == '.')
    3268:	02e00793          	li	a5,46
        int precision = -1;
    326c:	5bfd                	li	s7,-1
        if (*p == '.')
    326e:	e6fc9ae3          	bne	s9,a5,30e2 <_vprintf_core.constprop.0.isra.0+0x96>
            if (*p == '*')
    3272:	001dcc83          	lbu	s9,1(s11)
    3276:	02a00793          	li	a5,42
    327a:	16fc9f63          	bne	s9,a5,33f8 <_vprintf_core.constprop.0.isra.0+0x3ac>
                while (*p >= '0' && *p <= '9')
    327e:	002dcc83          	lbu	s9,2(s11)
        if (*p == 'l')
    3282:	06c00693          	li	a3,108
                precision = va_arg(ap, int);
    3286:	000c2b83          	lw	s7,0(s8)
                p++;
    328a:	0d89                	addi	s11,s11,2
                precision = va_arg(ap, int);
    328c:	0c21                	addi	s8,s8,8
        if (*p == 'l')
    328e:	8666                	mv	a2,s9
    3290:	e4dc9ee3          	bne	s9,a3,30ec <_vprintf_core.constprop.0.isra.0+0xa0>
            if (*p == 'l')
    3294:	001dcc83          	lbu	s9,1(s11)
    3298:	08cc8d63          	beq	s9,a2,3332 <_vprintf_core.constprop.0.isra.0+0x2e6>
        char spec = *p++;
    329c:	06400693          	li	a3,100
    32a0:	0d89                	addi	s11,s11,2
        if (!spec)
    32a2:	4cdc8c63          	beq	s9,a3,377a <_vprintf_core.constprop.0.isra.0+0x72e>
    32a6:	06400693          	li	a3,100
            len_mod = 1;
    32aa:	4e85                	li	t4,1
    32ac:	e596fee3          	bgeu	a3,s9,3108 <_vprintf_core.constprop.0.isra.0+0xbc>
    32b0:	f9bc869b          	addiw	a3,s9,-101
    32b4:	0ff6f693          	zext.b	a3,a3
    32b8:	464d                	li	a2,19
    32ba:	12d66863          	bltu	a2,a3,33ea <_vprintf_core.constprop.0.isra.0+0x39e>
    32be:	4e05                	li	t3,1
    32c0:	00091637          	lui	a2,0x91
    32c4:	00de1333          	sll	t1,t3,a3
    32c8:	81060613          	addi	a2,a2,-2032 # 90810 <_ZSt4cerr+0x88fa8>
    32cc:	00c37633          	and	a2,t1,a2
    32d0:	1a061463          	bnez	a2,3478 <_vprintf_core.constprop.0.isra.0+0x42c>
    32d4:	00737313          	andi	t1,t1,7
    32d8:	e80311e3          	bnez	t1,315a <_vprintf_core.constprop.0.isra.0+0x10e>
    32dc:	4639                	li	a2,14
    32de:	10c69663          	bne	a3,a2,33ea <_vprintf_core.constprop.0.isra.0+0x39e>
            const char *s = va_arg(ap, char *);
    32e2:	000c3c83          	ld	s9,0(s8)
            if (!s)
    32e6:	420c8863          	beqz	s9,3716 <_vprintf_core.constprop.0.isra.0+0x6ca>
            while (*tmp && (precision < 0 || len < precision))
    32ea:	000cc683          	lbu	a3,0(s9)
    32ee:	38068863          	beqz	a3,367e <_vprintf_core.constprop.0.isra.0+0x632>
            const char *tmp = s;
    32f2:	8666                	mv	a2,s9
            int len = 0;
    32f4:	4681                	li	a3,0
            while (*tmp && (precision < 0 || len < precision))
    32f6:	00db8863          	beq	s7,a3,3306 <_vprintf_core.constprop.0.isra.0+0x2ba>
    32fa:	00164583          	lbu	a1,1(a2)
                len++;
    32fe:	2685                	addiw	a3,a3,1
                tmp++;
    3300:	0605                	addi	a2,a2,1
            while (*tmp && (precision < 0 || len < precision))
    3302:	f9f5                	bnez	a1,32f6 <_vprintf_core.constprop.0.isra.0+0x2aa>
    3304:	8bb6                	mv	s7,a3
            int padding = (width > len) ? width - len : 0;
    3306:	268bc563          	blt	s7,s0,3570 <_vprintf_core.constprop.0.isra.0+0x524>
            for (int i = 0; i < len; i++)
    330a:	4401                	li	s0,0
    330c:	020b8163          	beqz	s7,332e <_vprintf_core.constprop.0.isra.0+0x2e2>
    3310:	4d01                	li	s10,0
                _out_char(ctx, s[i]);
    3312:	01ac86b3          	add	a3,s9,s10
    3316:	0006c583          	lbu	a1,0(a3)
    331a:	8526                	mv	a0,s1
            for (int i = 0; i < len; i++)
    331c:	0d05                	addi	s10,s10,1
                _out_char(ctx, s[i]);
    331e:	ebbfd0ef          	jal	11d8 <_out_char>
            for (int i = 0; i < len; i++)
    3322:	000d069b          	sext.w	a3,s10
    3326:	ff76c6e3          	blt	a3,s7,3312 <_vprintf_core.constprop.0.isra.0+0x2c6>
            if (flag_left)
    332a:	260a1463          	bnez	s4,3592 <_vprintf_core.constprop.0.isra.0+0x546>
            const char *s = va_arg(ap, char *);
    332e:	0c21                	addi	s8,s8,8
    3330:	bba9                	j	308a <_vprintf_core.constprop.0.isra.0+0x3e>
                p++;
    3332:	0d89                	addi	s11,s11,2
        char spec = *p++;
    3334:	000dcc83          	lbu	s9,0(s11)
    3338:	06400693          	li	a3,100
    333c:	001d8793          	addi	a5,s11,1
        if (!spec)
    3340:	3edc8063          	beq	s9,a3,3720 <_vprintf_core.constprop.0.isra.0+0x6d4>
    3344:	0796ea63          	bltu	a3,s9,33b8 <_vprintf_core.constprop.0.isra.0+0x36c>
    3348:	04700693          	li	a3,71
    334c:	0f96e263          	bltu	a3,s9,3430 <_vprintf_core.constprop.0.isra.0+0x3e4>
    3350:	04400693          	li	a3,68
    3354:	e196e2e3          	bltu	a3,s9,3158 <_vprintf_core.constprop.0.isra.0+0x10c>
    3358:	dc0c82e3          	beqz	s9,311c <_vprintf_core.constprop.0.isra.0+0xd0>
        char spec = *p++;
    335c:	8dbe                	mv	s11,a5
            _out_char(ctx, '%');
    335e:	02500593          	li	a1,37
    3362:	8526                	mv	a0,s1
    3364:	e75fd0ef          	jal	11d8 <_out_char>
            if (spec != '%')
    3368:	02500713          	li	a4,37
    336c:	d0ec8fe3          	beq	s9,a4,308a <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, spec);
    3370:	85e6                	mv	a1,s9
    3372:	bb09                	j	3084 <_vprintf_core.constprop.0.isra.0+0x38>
    3374:	05800693          	li	a3,88
    3378:	2edc8263          	beq	s9,a3,365c <_vprintf_core.constprop.0.isra.0+0x610>
    337c:	06300713          	li	a4,99
    3380:	06ec9563          	bne	s9,a4,33ea <_vprintf_core.constprop.0.isra.0+0x39e>
            char c = (char)va_arg(ap, int);
    3384:	000c4c83          	lbu	s9,0(s8)
            int padding = (width > 1) ? width - 1 : 0;
    3388:	8722                	mv	a4,s0
    338a:	00804363          	bgtz	s0,3390 <_vprintf_core.constprop.0.isra.0+0x344>
    338e:	4705                	li	a4,1
    3390:	fff7041b          	addiw	s0,a4,-1
            if (!flag_left)
    3394:	3c0a0463          	beqz	s4,375c <_vprintf_core.constprop.0.isra.0+0x710>
            _out_char(ctx, c);
    3398:	85e6                	mv	a1,s9
    339a:	8526                	mv	a0,s1
    339c:	e3dfd0ef          	jal	11d8 <_out_char>
                for (int i = 0; i < padding; i++)
    33a0:	4a01                	li	s4,0
    33a2:	d451                	beqz	s0,332e <_vprintf_core.constprop.0.isra.0+0x2e2>
                    _out_char(ctx, ' ');
    33a4:	02000593          	li	a1,32
    33a8:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    33aa:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    33ac:	e2dfd0ef          	jal	11d8 <_out_char>
                for (int i = 0; i < padding; i++)
    33b0:	ff441ae3          	bne	s0,s4,33a4 <_vprintf_core.constprop.0.isra.0+0x358>
            const char *s = va_arg(ap, char *);
    33b4:	0c21                	addi	s8,s8,8
    33b6:	b9d1                	j	308a <_vprintf_core.constprop.0.isra.0+0x3e>
    33b8:	f9bc861b          	addiw	a2,s9,-101
    33bc:	0ff67613          	zext.b	a2,a2
    33c0:	46cd                	li	a3,19
    33c2:	40c6e963          	bltu	a3,a2,37d4 <_vprintf_core.constprop.0.isra.0+0x788>
    33c6:	00091337          	lui	t1,0x91
    33ca:	4685                	li	a3,1
    33cc:	00c696b3          	sll	a3,a3,a2
    33d0:	81030313          	addi	t1,t1,-2032 # 90810 <_ZSt4cerr+0x88fa8>
    33d4:	0066f333          	and	t1,a3,t1
    33d8:	34031c63          	bnez	t1,3730 <_vprintf_core.constprop.0.isra.0+0x6e4>
    33dc:	8a9d                	andi	a3,a3,7
    33de:	d6069de3          	bnez	a3,3158 <_vprintf_core.constprop.0.isra.0+0x10c>
    33e2:	46b9                	li	a3,14
        char spec = *p++;
    33e4:	8dbe                	mv	s11,a5
    33e6:	eed60ee3          	beq	a2,a3,32e2 <_vprintf_core.constprop.0.isra.0+0x296>
            _out_char(ctx, '%');
    33ea:	02500593          	li	a1,37
    33ee:	8526                	mv	a0,s1
    33f0:	de9fd0ef          	jal	11d8 <_out_char>
                _out_char(ctx, spec);
    33f4:	85e6                	mv	a1,s9
    33f6:	b179                	j	3084 <_vprintf_core.constprop.0.isra.0+0x38>
                while (*p >= '0' && *p <= '9')
    33f8:	fd0c869b          	addiw	a3,s9,-48
    33fc:	0ff6fe13          	zext.b	t3,a3
    3400:	4625                	li	a2,9
            p++;
    3402:	0d85                	addi	s11,s11,1
                precision = 0;
    3404:	4b81                	li	s7,0
                while (*p >= '0' && *p <= '9')
    3406:	4325                	li	t1,9
    3408:	cdc66de3          	bltu	a2,t3,30e2 <_vprintf_core.constprop.0.isra.0+0x96>
                    precision = precision * 10 + (*p - '0');
    340c:	002b961b          	slliw	a2,s7,0x2
                while (*p >= '0' && *p <= '9')
    3410:	001dcc83          	lbu	s9,1(s11)
                    precision = precision * 10 + (*p - '0');
    3414:	0176073b          	addw	a4,a2,s7
    3418:	0017171b          	slliw	a4,a4,0x1
    341c:	00e68bbb          	addw	s7,a3,a4
                while (*p >= '0' && *p <= '9')
    3420:	fd0c869b          	addiw	a3,s9,-48
    3424:	0ff6f613          	zext.b	a2,a3
                    p++;
    3428:	0d85                	addi	s11,s11,1
                while (*p >= '0' && *p <= '9')
    342a:	fec371e3          	bgeu	t1,a2,340c <_vprintf_core.constprop.0.isra.0+0x3c0>
    342e:	b955                	j	30e2 <_vprintf_core.constprop.0.isra.0+0x96>
    3430:	05800693          	li	a3,88
    3434:	3cdc8d63          	beq	s9,a3,380e <_vprintf_core.constprop.0.isra.0+0x7c2>
    3438:	06300713          	li	a4,99
        char spec = *p++;
    343c:	8dbe                	mv	s11,a5
    343e:	f4ec83e3          	beq	s9,a4,3384 <_vprintf_core.constprop.0.isra.0+0x338>
    3442:	b765                	j	33ea <_vprintf_core.constprop.0.isra.0+0x39e>
                f_idx += sprintf(&fmt_tmp[f_idx], ".%d", precision);
    3444:	01aa0533          	add	a0,s4,s10
    3448:	865e                	mv	a2,s7
    344a:	00002597          	auipc	a1,0x2
    344e:	cce58593          	addi	a1,a1,-818 # 5118 <_GLOBAL__sub_I__ZSt3cin+0x138>
    3452:	ba5ff0ef          	jal	2ff6 <sprintf>
    3456:	00ad0d3b          	addw	s10,s10,a0
    345a:	b341                	j	31da <_vprintf_core.constprop.0.isra.0+0x18e>
                f_idx += sprintf(&fmt_tmp[f_idx], "%d", width);
    345c:	01aa0533          	add	a0,s4,s10
    3460:	8622                	mv	a2,s0
    3462:	00002597          	auipc	a1,0x2
    3466:	cae58593          	addi	a1,a1,-850 # 5110 <_GLOBAL__sub_I__ZSt3cin+0x130>
    346a:	b8dff0ef          	jal	2ff6 <sprintf>
    346e:	00ad0d3b          	addw	s10,s10,a0
            if (precision >= 0)
    3472:	d60bc4e3          	bltz	s7,31da <_vprintf_core.constprop.0.isra.0+0x18e>
    3476:	b7f9                	j	3444 <_vprintf_core.constprop.0.isra.0+0x3f8>
            int is_signed = (spec == 'd' || spec == 'i');
    3478:	06900693          	li	a3,105
    347c:	10dc8e63          	beq	s9,a3,3598 <_vprintf_core.constprop.0.isra.0+0x54c>
                val = (uint64)va_arg(ap, void *);
    3480:	008c0793          	addi	a5,s8,8
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3484:	07800693          	li	a3,120
                val = (uint64)va_arg(ap, void *);
    3488:	e43e                	sd	a5,8(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    348a:	38dc9d63          	bne	s9,a3,3824 <_vprintf_core.constprop.0.isra.0+0x7d8>
            else if (len_mod == 1)
    348e:	33ce8963          	beq	t4,t3,37c0 <_vprintf_core.constprop.0.isra.0+0x774>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    3492:	000c6e03          	lwu	t3,0(s8)
    3496:	85f6                	mv	a1,t4
    3498:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    349a:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    349c:	00002f97          	auipc	t6,0x2
    34a0:	c44f8f93          	addi	t6,t6,-956 # 50e0 <_GLOBAL__sub_I__ZSt3cin+0x100>
    if (val == 0)
    34a4:	120e0363          	beqz	t3,35ca <_vprintf_core.constprop.0.isra.0+0x57e>
    34a8:	01010293          	addi	t0,sp,16
                    sign_char = '-';
    34ac:	8616                	mv	a2,t0
    34ae:	86f2                	mv	a3,t3
        buf[i++] = digits[val % base];
    34b0:	0266f8b3          	remu	a7,a3,t1
    34b4:	8f32                	mv	t5,a2
    while (val != 0)
    34b6:	0605                	addi	a2,a2,1
    34b8:	8eb6                	mv	t4,a3
        buf[i++] = digits[val % base];
    34ba:	98fe                	add	a7,a7,t6
    34bc:	0008c883          	lbu	a7,0(a7)
        val /= base;
    34c0:	0266d6b3          	divu	a3,a3,t1
        buf[i++] = digits[val % base];
    34c4:	ff160fa3          	sb	a7,-1(a2)
    while (val != 0)
    34c8:	fe6ef4e3          	bgeu	t4,t1,34b0 <_vprintf_core.constprop.0.isra.0+0x464>
        buf[i++] = digits[val % base];
    34cc:	405f0f3b          	subw	t5,t5,t0
    34d0:	2f05                	addiw	t5,t5,1
            if (precision >= 0)
    34d2:	100bc363          	bltz	s7,35d8 <_vprintf_core.constprop.0.isra.0+0x58c>
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    34d6:	1d7f4d63          	blt	t5,s7,36b0 <_vprintf_core.constprop.0.isra.0+0x664>
            if (precision == 0 && val == 0)
    34da:	340b9163          	bnez	s7,381c <_vprintf_core.constprop.0.isra.0+0x7d0>
    34de:	200e0763          	beqz	t3,36ec <_vprintf_core.constprop.0.isra.0+0x6a0>
            for (int i = digit_len - 1; i >= 0; i--)
    34e2:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    34e6:	07000693          	li	a3,112
            for (int i = digit_len - 1; i >= 0; i--)
    34ea:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    34ec:	28dc8e63          	beq	s9,a3,3788 <_vprintf_core.constprop.0.isra.0+0x73c>
    34f0:	2a051663          	bnez	a0,379c <_vprintf_core.constprop.0.isra.0+0x750>
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    34f4:	00bf05bb          	addw	a1,t5,a1
    34f8:	8d52                	mv	s10,s4
    34fa:	4b01                	li	s6,0
            char *prefix_str = NULL;
    34fc:	4c81                	li	s9,0
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    34fe:	1085d263          	bge	a1,s0,3602 <_vprintf_core.constprop.0.isra.0+0x5b6>
    3502:	9c0d                	subw	s0,s0,a1
            if (!flag_left && !flag_zero)
    3504:	100d0a63          	beqz	s10,3618 <_vprintf_core.constprop.0.isra.0+0x5cc>
            if (sign_char)
    3508:	6782                	ld	a5,0(sp)
    350a:	10079263          	bnez	a5,360e <_vprintf_core.constprop.0.isra.0+0x5c2>
            if (prefix_str)
    350e:	000c8c63          	beqz	s9,3526 <_vprintf_core.constprop.0.isra.0+0x4da>
                _out_char(ctx, prefix_str[0]);
    3512:	000cc583          	lbu	a1,0(s9)
    3516:	8526                	mv	a0,s1
    3518:	cc1fd0ef          	jal	11d8 <_out_char>
                _out_char(ctx, prefix_str[1]);
    351c:	001cc583          	lbu	a1,1(s9)
    3520:	8526                	mv	a0,s1
    3522:	cb7fd0ef          	jal	11d8 <_out_char>
            int total_zeros = prec_zeros + ((flag_zero && !flag_left) ? padding : 0);
    3526:	180b0263          	beqz	s6,36aa <_vprintf_core.constprop.0.isra.0+0x65e>
    352a:	100a1863          	bnez	s4,363a <_vprintf_core.constprop.0.isra.0+0x5ee>
    352e:	008b8bbb          	addw	s7,s7,s0
            for (int i = 0; i < total_zeros; i++)
    3532:	2a0b8363          	beqz	s7,37d8 <_vprintf_core.constprop.0.isra.0+0x78c>
    3536:	4c81                	li	s9,0
                _out_char(ctx, '0');
    3538:	03000593          	li	a1,48
    353c:	8526                	mv	a0,s1
            for (int i = 0; i < total_zeros; i++)
    353e:	2c85                	addiw	s9,s9,1
                _out_char(ctx, '0');
    3540:	c99fd0ef          	jal	11d8 <_out_char>
            for (int i = 0; i < total_zeros; i++)
    3544:	ff7c9ae3          	bne	s9,s7,3538 <_vprintf_core.constprop.0.isra.0+0x4ec>
            for (int i = digit_len - 1; i >= 0; i--)
    3548:	57fd                	li	a5,-1
    354a:	00fc0f63          	beq	s8,a5,3568 <_vprintf_core.constprop.0.isra.0+0x51c>
    354e:	01010c93          	addi	s9,sp,16
    3552:	9ce2                	add	s9,s9,s8
    3554:	00f10c13          	addi	s8,sp,15
                _out_char(ctx, num_buf[i]);
    3558:	000cc583          	lbu	a1,0(s9)
    355c:	8526                	mv	a0,s1
            for (int i = digit_len - 1; i >= 0; i--)
    355e:	1cfd                	addi	s9,s9,-1
                _out_char(ctx, num_buf[i]);
    3560:	c79fd0ef          	jal	11d8 <_out_char>
            for (int i = digit_len - 1; i >= 0; i--)
    3564:	ff9c1ae3          	bne	s8,s9,3558 <_vprintf_core.constprop.0.isra.0+0x50c>
            if (flag_left)
    3568:	0c0a1e63          	bnez	s4,3644 <_vprintf_core.constprop.0.isra.0+0x5f8>
        char spec = *p++;
    356c:	6c22                	ld	s8,8(sp)
    356e:	be31                	j	308a <_vprintf_core.constprop.0.isra.0+0x3e>
            int padding = (width > len) ? width - len : 0;
    3570:	4174043b          	subw	s0,s0,s7
            if (!flag_left)
    3574:	100a0a63          	beqz	s4,3688 <_vprintf_core.constprop.0.isra.0+0x63c>
            for (int i = 0; i < len; i++)
    3578:	d80b9ce3          	bnez	s7,3310 <_vprintf_core.constprop.0.isra.0+0x2c4>
                for (int i = 0; i < padding; i++)
    357c:	4a01                	li	s4,0
                    _out_char(ctx, ' ');
    357e:	02000593          	li	a1,32
    3582:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    3584:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    3586:	c53fd0ef          	jal	11d8 <_out_char>
                for (int i = 0; i < padding; i++)
    358a:	ff441ae3          	bne	s0,s4,357e <_vprintf_core.constprop.0.isra.0+0x532>
            const char *s = va_arg(ap, char *);
    358e:	0c21                	addi	s8,s8,8
    3590:	bced                	j	308a <_vprintf_core.constprop.0.isra.0+0x3e>
                for (int i = 0; i < padding; i++)
    3592:	f46d                	bnez	s0,357c <_vprintf_core.constprop.0.isra.0+0x530>
            const char *s = va_arg(ap, char *);
    3594:	0c21                	addi	s8,s8,8
    3596:	bcd5                	j	308a <_vprintf_core.constprop.0.isra.0+0x3e>
            else if (len_mod == 1)
    3598:	1fce8163          	beq	t4,t3,377a <_vprintf_core.constprop.0.isra.0+0x72e>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    359c:	000c2e03          	lw	t3,0(s8)
    35a0:	008c0793          	addi	a5,s8,8
    35a4:	e43e                	sd	a5,8(sp)
                int64 sval = (int64)val;
    35a6:	86f2                	mv	a3,t3
                if (sval < 0)
    35a8:	1406cb63          	bltz	a3,36fe <_vprintf_core.constprop.0.isra.0+0x6b2>
                    sign_char = '+';
    35ac:	02b00793          	li	a5,43
    35b0:	e03e                	sd	a5,0(sp)
                else if (flag_plus)
    35b2:	e589                	bnez	a1,35bc <_vprintf_core.constprop.0.isra.0+0x570>
                else if (flag_space)
    35b4:	00589793          	slli	a5,a7,0x5
    35b8:	e03e                	sd	a5,0(sp)
    35ba:	85c6                	mv	a1,a7
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    35bc:	4329                	li	t1,10
    35be:	00002f97          	auipc	t6,0x2
    35c2:	b22f8f93          	addi	t6,t6,-1246 # 50e0 <_GLOBAL__sub_I__ZSt3cin+0x100>
    if (val == 0)
    35c6:	ee0e11e3          	bnez	t3,34a8 <_vprintf_core.constprop.0.isra.0+0x45c>
        buf[i++] = '0';
    35ca:	03000693          	li	a3,48
    35ce:	00d10823          	sb	a3,16(sp)
        return i;
    35d2:	4f05                	li	t5,1
            if (precision >= 0)
    35d4:	f00bd1e3          	bgez	s7,34d6 <_vprintf_core.constprop.0.isra.0+0x48a>
            for (int i = digit_len - 1; i >= 0; i--)
    35d8:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    35dc:	07000893          	li	a7,112
            if (!flag_left && !flag_zero)
    35e0:	016a6d33          	or	s10,s4,s6
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    35e4:	4b81                	li	s7,0
            for (int i = digit_len - 1; i >= 0; i--)
    35e6:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    35e8:	0d1c9f63          	bne	s9,a7,36c6 <_vprintf_core.constprop.0.isra.0+0x67a>
                prefix_str = (spec == 'X') ? "0X" : "0x";
    35ec:	00002c97          	auipc	s9,0x2
    35f0:	b0cc8c93          	addi	s9,s9,-1268 # 50f8 <_GLOBAL__sub_I__ZSt3cin+0x118>
                prefix_len += 2;
    35f4:	2589                	addiw	a1,a1,2
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    35f6:	017585bb          	addw	a1,a1,s7
    35fa:	01e585bb          	addw	a1,a1,t5
    35fe:	f085c2e3          	blt	a1,s0,3502 <_vprintf_core.constprop.0.isra.0+0x4b6>
            if (!flag_left && !flag_zero)
    3602:	080d0f63          	beqz	s10,36a0 <_vprintf_core.constprop.0.isra.0+0x654>
            if (sign_char)
    3606:	6782                	ld	a5,0(sp)
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    3608:	4401                	li	s0,0
            if (sign_char)
    360a:	f00782e3          	beqz	a5,350e <_vprintf_core.constprop.0.isra.0+0x4c2>
                _out_char(ctx, sign_char);
    360e:	6582                	ld	a1,0(sp)
    3610:	8526                	mv	a0,s1
    3612:	bc7fd0ef          	jal	11d8 <_out_char>
    3616:	bde5                	j	350e <_vprintf_core.constprop.0.isra.0+0x4c2>
                    _out_char(ctx, ' ');
    3618:	02000593          	li	a1,32
    361c:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    361e:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    3620:	bb9fd0ef          	jal	11d8 <_out_char>
                for (int i = 0; i < padding; i++)
    3624:	efa402e3          	beq	s0,s10,3508 <_vprintf_core.constprop.0.isra.0+0x4bc>
                    _out_char(ctx, ' ');
    3628:	02000593          	li	a1,32
    362c:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    362e:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    3630:	ba9fd0ef          	jal	11d8 <_out_char>
                for (int i = 0; i < padding; i++)
    3634:	ffa412e3          	bne	s0,s10,3618 <_vprintf_core.constprop.0.isra.0+0x5cc>
    3638:	bdc1                	j	3508 <_vprintf_core.constprop.0.isra.0+0x4bc>
            for (int i = 0; i < total_zeros; i++)
    363a:	ee0b9ee3          	bnez	s7,3536 <_vprintf_core.constprop.0.isra.0+0x4ea>
            for (int i = digit_len - 1; i >= 0; i--)
    363e:	577d                	li	a4,-1
    3640:	f0ec17e3          	bne	s8,a4,354e <_vprintf_core.constprop.0.isra.0+0x502>
                for (int i = 0; i < padding; i++)
    3644:	d405                	beqz	s0,356c <_vprintf_core.constprop.0.isra.0+0x520>
    3646:	4a01                	li	s4,0
                    _out_char(ctx, ' ');
    3648:	02000593          	li	a1,32
    364c:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    364e:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    3650:	b89fd0ef          	jal	11d8 <_out_char>
                for (int i = 0; i < padding; i++)
    3654:	fe8a1ae3          	bne	s4,s0,3648 <_vprintf_core.constprop.0.isra.0+0x5fc>
        char spec = *p++;
    3658:	6c22                	ld	s8,8(sp)
    365a:	bc05                	j	308a <_vprintf_core.constprop.0.isra.0+0x3e>
                val = (uint64)va_arg(ap, void *);
    365c:	008c0793          	addi	a5,s8,8
    3660:	e43e                	sd	a5,8(sp)
            else if (len_mod == 1)
    3662:	180e9163          	bnez	t4,37e4 <_vprintf_core.constprop.0.isra.0+0x798>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    3666:	000c6e03          	lwu	t3,0(s8)
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    366a:	4581                	li	a1,0
    366c:	05800c93          	li	s9,88
    3670:	e002                	sd	zero,0(sp)
    3672:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    3674:	00002f97          	auipc	t6,0x2
    3678:	a54f8f93          	addi	t6,t6,-1452 # 50c8 <_GLOBAL__sub_I__ZSt3cin+0xe8>
    367c:	b525                	j	34a4 <_vprintf_core.constprop.0.isra.0+0x458>
            int padding = (width > len) ? width - len : 0;
    367e:	ca8058e3          	blez	s0,332e <_vprintf_core.constprop.0.isra.0+0x2e2>
            if (!flag_left)
    3682:	ee0a1de3          	bnez	s4,357c <_vprintf_core.constprop.0.isra.0+0x530>
            int len = 0;
    3686:	4b81                	li	s7,0
                for (int i = 0; i < padding; i++)
    3688:	4d01                	li	s10,0
                    _out_char(ctx, ' ');
    368a:	02000593          	li	a1,32
    368e:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    3690:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    3692:	b47fd0ef          	jal	11d8 <_out_char>
                for (int i = 0; i < padding; i++)
    3696:	fe8d1ae3          	bne	s10,s0,368a <_vprintf_core.constprop.0.isra.0+0x63e>
            for (int i = 0; i < len; i++)
    369a:	c60b9be3          	bnez	s7,3310 <_vprintf_core.constprop.0.isra.0+0x2c4>
    369e:	b941                	j	332e <_vprintf_core.constprop.0.isra.0+0x2e2>
            if (sign_char)
    36a0:	6782                	ld	a5,0(sp)
    36a2:	4401                	li	s0,0
    36a4:	f7ad                	bnez	a5,360e <_vprintf_core.constprop.0.isra.0+0x5c2>
            if (prefix_str)
    36a6:	e60c96e3          	bnez	s9,3512 <_vprintf_core.constprop.0.isra.0+0x4c6>
            for (int i = 0; i < total_zeros; i++)
    36aa:	e80b96e3          	bnez	s7,3536 <_vprintf_core.constprop.0.isra.0+0x4ea>
    36ae:	bd69                	j	3548 <_vprintf_core.constprop.0.isra.0+0x4fc>
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    36b0:	41eb8bbb          	subw	s7,s7,t5
    36b4:	8d52                	mv	s10,s4
    36b6:	4b01                	li	s6,0
            for (int i = digit_len - 1; i >= 0; i--)
    36b8:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    36bc:	07000893          	li	a7,112
            for (int i = digit_len - 1; i >= 0; i--)
    36c0:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    36c2:	f31c85e3          	beq	s9,a7,35ec <_vprintf_core.constprop.0.isra.0+0x5a0>
    36c6:	cd09                	beqz	a0,36e0 <_vprintf_core.constprop.0.isra.0+0x694>
    36c8:	000e0c63          	beqz	t3,36e0 <_vprintf_core.constprop.0.isra.0+0x694>
    36cc:	07800513          	li	a0,120
            for (int i = digit_len - 1; i >= 0; i--)
    36d0:	00060c1b          	sext.w	s8,a2
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    36d4:	f0ac8ce3          	beq	s9,a0,35ec <_vprintf_core.constprop.0.isra.0+0x5a0>
    36d8:	05800613          	li	a2,88
    36dc:	12cc8463          	beq	s9,a2,3804 <_vprintf_core.constprop.0.isra.0+0x7b8>
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    36e0:	00bb85bb          	addw	a1,s7,a1
    36e4:	01e585bb          	addw	a1,a1,t5
            char *prefix_str = NULL;
    36e8:	4c81                	li	s9,0
    36ea:	bd11                	j	34fe <_vprintf_core.constprop.0.isra.0+0x4b2>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    36ec:	07000693          	li	a3,112
    36f0:	8d52                	mv	s10,s4
    36f2:	4b01                	li	s6,0
    36f4:	08dc8d63          	beq	s9,a3,378e <_vprintf_core.constprop.0.isra.0+0x742>
    36f8:	5c7d                	li	s8,-1
            char *prefix_str = NULL;
    36fa:	4c81                	li	s9,0
    36fc:	b509                	j	34fe <_vprintf_core.constprop.0.isra.0+0x4b2>
                    sign_char = '-';
    36fe:	02d00793          	li	a5,45
                    val = (uint64)(-sval);
    3702:	40d00e33          	neg	t3,a3
    3706:	4585                	li	a1,1
    3708:	4329                	li	t1,10
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    370a:	00002f97          	auipc	t6,0x2
    370e:	9d6f8f93          	addi	t6,t6,-1578 # 50e0 <_GLOBAL__sub_I__ZSt3cin+0x100>
                    sign_char = '-';
    3712:	e03e                	sd	a5,0(sp)
    3714:	bb51                	j	34a8 <_vprintf_core.constprop.0.isra.0+0x45c>
                s = "(null)";
    3716:	00002c97          	auipc	s9,0x2
    371a:	9f2c8c93          	addi	s9,s9,-1550 # 5108 <_GLOBAL__sub_I__ZSt3cin+0x128>
    371e:	bed1                	j	32f2 <_vprintf_core.constprop.0.isra.0+0x2a6>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    3720:	000c3683          	ld	a3,0(s8)
    3724:	008c0713          	addi	a4,s8,8
    3728:	e43a                	sd	a4,8(sp)
    372a:	8dbe                	mv	s11,a5
    372c:	8e36                	mv	t3,a3
            if (is_signed)
    372e:	bdad                	j	35a8 <_vprintf_core.constprop.0.isra.0+0x55c>
            int is_signed = (spec == 'd' || spec == 'i');
    3730:	06900693          	li	a3,105
    3734:	fedc86e3          	beq	s9,a3,3720 <_vprintf_core.constprop.0.isra.0+0x6d4>
                val = (uint64)va_arg(ap, void *);
    3738:	008c0713          	addi	a4,s8,8
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    373c:	07800693          	li	a3,120
                val = (uint64)va_arg(ap, void *);
    3740:	e43a                	sd	a4,8(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3742:	06dc9063          	bne	s9,a3,37a2 <_vprintf_core.constprop.0.isra.0+0x756>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    3746:	000c3e03          	ld	t3,0(s8)
    374a:	8dbe                	mv	s11,a5
    374c:	4581                	li	a1,0
    374e:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3750:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    3752:	00002f97          	auipc	t6,0x2
    3756:	98ef8f93          	addi	t6,t6,-1650 # 50e0 <_GLOBAL__sub_I__ZSt3cin+0x100>
    375a:	b3a9                	j	34a4 <_vprintf_core.constprop.0.isra.0+0x458>
                for (int i = 0; i < padding; i++)
    375c:	c809                	beqz	s0,376e <_vprintf_core.constprop.0.isra.0+0x722>
                    _out_char(ctx, ' ');
    375e:	02000593          	li	a1,32
    3762:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    3764:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    3766:	a73fd0ef          	jal	11d8 <_out_char>
                for (int i = 0; i < padding; i++)
    376a:	ff441ae3          	bne	s0,s4,375e <_vprintf_core.constprop.0.isra.0+0x712>
            _out_char(ctx, c);
    376e:	85e6                	mv	a1,s9
    3770:	8526                	mv	a0,s1
    3772:	a67fd0ef          	jal	11d8 <_out_char>
            const char *s = va_arg(ap, char *);
    3776:	0c21                	addi	s8,s8,8
    3778:	ba09                	j	308a <_vprintf_core.constprop.0.isra.0+0x3e>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    377a:	000c3683          	ld	a3,0(s8)
    377e:	008c0793          	addi	a5,s8,8
    3782:	e43e                	sd	a5,8(sp)
    3784:	8e36                	mv	t3,a3
            if (is_signed)
    3786:	b50d                	j	35a8 <_vprintf_core.constprop.0.isra.0+0x55c>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    3788:	8d52                	mv	s10,s4
    378a:	4b01                	li	s6,0
    378c:	b585                	j	35ec <_vprintf_core.constprop.0.isra.0+0x5a0>
                digit_len = 0;
    378e:	4f01                	li	t5,0
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    3790:	5c7d                	li	s8,-1
                prefix_str = (spec == 'X') ? "0X" : "0x";
    3792:	00002c97          	auipc	s9,0x2
    3796:	966c8c93          	addi	s9,s9,-1690 # 50f8 <_GLOBAL__sub_I__ZSt3cin+0x118>
    379a:	bda9                	j	35f4 <_vprintf_core.constprop.0.isra.0+0x5a8>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    379c:	8d52                	mv	s10,s4
    379e:	4b01                	li	s6,0
    37a0:	b735                	j	36cc <_vprintf_core.constprop.0.isra.0+0x680>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    37a2:	07000693          	li	a3,112
    37a6:	04dc8263          	beq	s9,a3,37ea <_vprintf_core.constprop.0.isra.0+0x79e>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    37aa:	000c3e03          	ld	t3,0(s8)
    37ae:	8dbe                	mv	s11,a5
    37b0:	4581                	li	a1,0
    37b2:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    37b4:	4329                	li	t1,10
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    37b6:	00002f97          	auipc	t6,0x2
    37ba:	92af8f93          	addi	t6,t6,-1750 # 50e0 <_GLOBAL__sub_I__ZSt3cin+0x100>
    37be:	b1dd                	j	34a4 <_vprintf_core.constprop.0.isra.0+0x458>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    37c0:	000c3e03          	ld	t3,0(s8)
    37c4:	4581                	li	a1,0
    37c6:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    37c8:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    37ca:	00002f97          	auipc	t6,0x2
    37ce:	916f8f93          	addi	t6,t6,-1770 # 50e0 <_GLOBAL__sub_I__ZSt3cin+0x100>
    37d2:	b9c9                	j	34a4 <_vprintf_core.constprop.0.isra.0+0x458>
        char spec = *p++;
    37d4:	8dbe                	mv	s11,a5
    37d6:	b911                	j	33ea <_vprintf_core.constprop.0.isra.0+0x39e>
            for (int i = digit_len - 1; i >= 0; i--)
    37d8:	577d                	li	a4,-1
    37da:	4401                	li	s0,0
    37dc:	d6ec19e3          	bne	s8,a4,354e <_vprintf_core.constprop.0.isra.0+0x502>
        char spec = *p++;
    37e0:	6c22                	ld	s8,8(sp)
    37e2:	b065                	j	308a <_vprintf_core.constprop.0.isra.0+0x3e>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    37e4:	000c3e03          	ld	t3,0(s8)
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    37e8:	b549                	j	366a <_vprintf_core.constprop.0.isra.0+0x61e>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    37ea:	8dbe                	mv	s11,a5
                val = (uint64)va_arg(ap, void *);
    37ec:	000c3e03          	ld	t3,0(s8)
    37f0:	4581                	li	a1,0
    37f2:	07000c93          	li	s9,112
    37f6:	e002                	sd	zero,0(sp)
    37f8:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    37fa:	00002f97          	auipc	t6,0x2
    37fe:	8e6f8f93          	addi	t6,t6,-1818 # 50e0 <_GLOBAL__sub_I__ZSt3cin+0x100>
    3802:	b14d                	j	34a4 <_vprintf_core.constprop.0.isra.0+0x458>
                prefix_str = (spec == 'X') ? "0X" : "0x";
    3804:	00002c97          	auipc	s9,0x2
    3808:	8fcc8c93          	addi	s9,s9,-1796 # 5100 <_GLOBAL__sub_I__ZSt3cin+0x120>
    380c:	b3e5                	j	35f4 <_vprintf_core.constprop.0.isra.0+0x5a8>
                val = (uint64)va_arg(ap, void *);
    380e:	008c0713          	addi	a4,s8,8
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    3812:	000c3e03          	ld	t3,0(s8)
                val = (uint64)va_arg(ap, void *);
    3816:	e43a                	sd	a4,8(sp)
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    3818:	8dbe                	mv	s11,a5
    381a:	bd81                	j	366a <_vprintf_core.constprop.0.isra.0+0x61e>
    381c:	8d52                	mv	s10,s4
    381e:	4b01                	li	s6,0
    3820:	4b81                	li	s7,0
    3822:	bd59                	j	36b8 <_vprintf_core.constprop.0.isra.0+0x66c>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3824:	07000693          	li	a3,112
    3828:	fcdc82e3          	beq	s9,a3,37ec <_vprintf_core.constprop.0.isra.0+0x7a0>
            else if (len_mod == 1)
    382c:	01ce8c63          	beq	t4,t3,3844 <_vprintf_core.constprop.0.isra.0+0x7f8>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    3830:	000c6e03          	lwu	t3,0(s8)
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    3834:	4581                	li	a1,0
    3836:	e002                	sd	zero,0(sp)
    3838:	4329                	li	t1,10
    383a:	00002f97          	auipc	t6,0x2
    383e:	8a6f8f93          	addi	t6,t6,-1882 # 50e0 <_GLOBAL__sub_I__ZSt3cin+0x100>
    3842:	b18d                	j	34a4 <_vprintf_core.constprop.0.isra.0+0x458>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    3844:	000c3e03          	ld	t3,0(s8)
            if (is_signed)
    3848:	b7f5                	j	3834 <_vprintf_core.constprop.0.isra.0+0x7e8>

000000000000384a <vsnprintf>:
{
    384a:	7139                	addi	sp,sp,-64
    384c:	f822                	sd	s0,48(sp)
    384e:	f426                	sd	s1,40(sp)
    3850:	842e                	mv	s0,a1
    3852:	84aa                	mv	s1,a0
    3854:	85b2                	mv	a1,a2
    _vprintf_core(&ctx, format, ap);
    3856:	850a                	mv	a0,sp
    3858:	8636                	mv	a2,a3
{
    385a:	fc06                	sd	ra,56(sp)
    ctx.buf = str;
    385c:	e026                	sd	s1,0(sp)
    ctx.limit = size;
    385e:	e422                	sd	s0,8(sp)
    ctx.written = 0;
    3860:	e802                	sd	zero,16(sp)
    ctx.stream = NULL;
    3862:	ec02                	sd	zero,24(sp)
    _vprintf_core(&ctx, format, ap);
    3864:	fe8ff0ef          	jal	304c <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    3868:	6542                	ld	a0,16(sp)
    if (size > 0)
    386a:	c411                	beqz	s0,3876 <vsnprintf+0x2c>
        if (ctx.written < size)
    386c:	00857b63          	bgeu	a0,s0,3882 <vsnprintf+0x38>
            str[ctx.written] = '\0';
    3870:	94aa                	add	s1,s1,a0
    3872:	00048023          	sb	zero,0(s1)
}
    3876:	70e2                	ld	ra,56(sp)
    3878:	7442                	ld	s0,48(sp)
    387a:	74a2                	ld	s1,40(sp)
    387c:	2501                	sext.w	a0,a0
    387e:	6121                	addi	sp,sp,64
    3880:	8082                	ret
            str[size - 1] = '\0';
    3882:	94a2                	add	s1,s1,s0
    3884:	fe048fa3          	sb	zero,-1(s1)
}
    3888:	70e2                	ld	ra,56(sp)
    388a:	7442                	ld	s0,48(sp)
    388c:	74a2                	ld	s1,40(sp)
    388e:	2501                	sext.w	a0,a0
    3890:	6121                	addi	sp,sp,64
    3892:	8082                	ret

0000000000003894 <snprintf>:
{
    3894:	7119                	addi	sp,sp,-128
    3896:	e0a2                	sd	s0,64(sp)
    3898:	fc26                	sd	s1,56(sp)
    389a:	842e                	mv	s0,a1
    389c:	84aa                	mv	s1,a0
    389e:	85b2                	mv	a1,a2
    _vprintf_core(&ctx, format, ap);
    38a0:	0808                	addi	a0,sp,16
    va_start(ap, format);
    38a2:	08b0                	addi	a2,sp,88
{
    38a4:	e486                	sd	ra,72(sp)
    38a6:	ecb6                	sd	a3,88(sp)
    38a8:	f0ba                	sd	a4,96(sp)
    38aa:	f4be                	sd	a5,104(sp)
    38ac:	f8c2                	sd	a6,112(sp)
    38ae:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    38b0:	e432                	sd	a2,8(sp)
    ctx.buf = str;
    38b2:	e826                	sd	s1,16(sp)
    ctx.limit = size;
    38b4:	ec22                	sd	s0,24(sp)
    ctx.written = 0;
    38b6:	f002                	sd	zero,32(sp)
    ctx.stream = NULL;
    38b8:	f402                	sd	zero,40(sp)
    _vprintf_core(&ctx, format, ap);
    38ba:	f92ff0ef          	jal	304c <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    38be:	7502                	ld	a0,32(sp)
    if (size > 0)
    38c0:	c411                	beqz	s0,38cc <snprintf+0x38>
        if (ctx.written < size)
    38c2:	00857b63          	bgeu	a0,s0,38d8 <snprintf+0x44>
            str[ctx.written] = '\0';
    38c6:	94aa                	add	s1,s1,a0
    38c8:	00048023          	sb	zero,0(s1)
}
    38cc:	60a6                	ld	ra,72(sp)
    38ce:	6406                	ld	s0,64(sp)
    38d0:	74e2                	ld	s1,56(sp)
    38d2:	2501                	sext.w	a0,a0
    38d4:	6109                	addi	sp,sp,128
    38d6:	8082                	ret
            str[size - 1] = '\0';
    38d8:	94a2                	add	s1,s1,s0
    38da:	fe048fa3          	sb	zero,-1(s1)
}
    38de:	60a6                	ld	ra,72(sp)
    38e0:	6406                	ld	s0,64(sp)
    38e2:	74e2                	ld	s1,56(sp)
    38e4:	2501                	sext.w	a0,a0
    38e6:	6109                	addi	sp,sp,128
    38e8:	8082                	ret

00000000000038ea <printf>:
{
    38ea:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    38ec:	04810313          	addi	t1,sp,72
{
    38f0:	e4ae                	sd	a1,72(sp)
    38f2:	e8b2                	sd	a2,80(sp)
    38f4:	f4be                	sd	a5,104(sp)
    _vprintf_core(&ctx, format, ap);
    38f6:	85aa                	mv	a1,a0
    ctx.stream = stdout;
    38f8:	00004797          	auipc	a5,0x4
    38fc:	dd87b783          	ld	a5,-552(a5) # 76d0 <stdout>
    _vprintf_core(&ctx, format, ap);
    3900:	0808                	addi	a0,sp,16
    3902:	861a                	mv	a2,t1
{
    3904:	fc06                	sd	ra,56(sp)
    3906:	ecb6                	sd	a3,88(sp)
    3908:	f0ba                	sd	a4,96(sp)
    390a:	f8c2                	sd	a6,112(sp)
    390c:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    390e:	e41a                	sd	t1,8(sp)
    ctx.buf = NULL;
    3910:	e802                	sd	zero,16(sp)
    ctx.limit = 0;
    3912:	ec02                	sd	zero,24(sp)
    ctx.written = 0;
    3914:	f002                	sd	zero,32(sp)
    ctx.stream = stdout;
    3916:	f43e                	sd	a5,40(sp)
    _vprintf_core(&ctx, format, ap);
    3918:	f34ff0ef          	jal	304c <_vprintf_core.constprop.0.isra.0>
}
    391c:	70e2                	ld	ra,56(sp)
    391e:	5502                	lw	a0,32(sp)
    3920:	6109                	addi	sp,sp,128
    3922:	8082                	ret

0000000000003924 <sscanf>:
{
    3924:	7159                	addi	sp,sp,-112
    va_start(ap, format);
    3926:	04010e13          	addi	t3,sp,64
{
    392a:	8eaa                	mv	t4,a0
    ctx.fd = -1;
    392c:	537d                	li	t1,-1
{
    392e:	e0b2                	sd	a2,64(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    3930:	0808                	addi	a0,sp,16
    3932:	8672                	mv	a2,t3
{
    3934:	fc06                	sd	ra,56(sp)
    3936:	e4b6                	sd	a3,72(sp)
    3938:	e8ba                	sd	a4,80(sp)
    393a:	ecbe                	sd	a5,88(sp)
    393c:	f0c2                	sd	a6,96(sp)
    393e:	f4c6                	sd	a7,104(sp)
    va_start(ap, format);
    3940:	e472                	sd	t3,8(sp)
    ctx.buf = str;
    3942:	e876                	sd	t4,16(sp)
    ctx.fd = -1;
    3944:	cc1a                	sw	t1,24(sp)
    ctx.pos = 0;
    3946:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    3948:	d41a                	sw	t1,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    394a:	81efd0ef          	jal	968 <_vscanf_core.constprop.0>
}
    394e:	70e2                	ld	ra,56(sp)
    3950:	6165                	addi	sp,sp,112
    3952:	8082                	ret

0000000000003954 <scanf>:
{
    3954:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    3956:	04810313          	addi	t1,sp,72
{
    395a:	e4ae                	sd	a1,72(sp)
    395c:	e8b2                	sd	a2,80(sp)
    395e:	f4be                	sd	a5,104(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    3960:	85aa                	mv	a1,a0
    ctx.ungotten = -1;
    3962:	57fd                	li	a5,-1
    int ret = _vscanf_core(&ctx, format, ap);
    3964:	0808                	addi	a0,sp,16
    3966:	861a                	mv	a2,t1
{
    3968:	fc06                	sd	ra,56(sp)
    396a:	ecb6                	sd	a3,88(sp)
    396c:	f0ba                	sd	a4,96(sp)
    396e:	f8c2                	sd	a6,112(sp)
    3970:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    3972:	e41a                	sd	t1,8(sp)
    ctx.buf = NULL;
    3974:	e802                	sd	zero,16(sp)
    ctx.fd = STDIN_FD;
    3976:	cc02                	sw	zero,24(sp)
    ctx.pos = 0;
    3978:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    397a:	d43e                	sw	a5,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    397c:	fedfc0ef          	jal	968 <_vscanf_core.constprop.0>
}
    3980:	70e2                	ld	ra,56(sp)
    3982:	6109                	addi	sp,sp,128
    3984:	8082                	ret

0000000000003986 <fopen>:
{
    3986:	1101                	addi	sp,sp,-32
    3988:	e426                	sd	s1,8(sp)
    398a:	84ae                	mv	s1,a1
    398c:	e04a                	sd	s2,0(sp)
    if (strcmp(mode, "r") == 0)
    398e:	00001597          	auipc	a1,0x1
    3992:	79258593          	addi	a1,a1,1938 # 5120 <_GLOBAL__sub_I__ZSt3cin+0x140>
{
    3996:	892a                	mv	s2,a0
    if (strcmp(mode, "r") == 0)
    3998:	8526                	mv	a0,s1
{
    399a:	e822                	sd	s0,16(sp)
    399c:	ec06                	sd	ra,24(sp)
    if (strcmp(mode, "r") == 0)
    399e:	298010ef          	jal	4c36 <strcmp>
    39a2:	842a                	mv	s0,a0
    39a4:	c919                	beqz	a0,39ba <fopen+0x34>
    else if (strcmp(mode, "w") == 0)
    39a6:	00001597          	auipc	a1,0x1
    39aa:	78258593          	addi	a1,a1,1922 # 5128 <_GLOBAL__sub_I__ZSt3cin+0x148>
    39ae:	8526                	mv	a0,s1
    39b0:	286010ef          	jal	4c36 <strcmp>
        flags = O_WRONLY | O_CREAT | O_TRUNC;
    39b4:	24100413          	li	s0,577
    else if (strcmp(mode, "w") == 0)
    39b8:	ed39                	bnez	a0,3a16 <fopen+0x90>
    int64 fd = open(filename, flags);
    39ba:	85a2                	mv	a1,s0
    39bc:	854a                	mv	a0,s2
    39be:	f4afc0ef          	jal	108 <open>
    39c2:	84aa                	mv	s1,a0
    if (fd < 0)
    39c4:	06054c63          	bltz	a0,3a3c <fopen+0xb6>
    FILE *f = (FILE *)malloc(sizeof(FILE));
    39c8:	42000513          	li	a0,1056
    39cc:	2f3000ef          	jal	44be <malloc>
    39d0:	892a                	mv	s2,a0
    if (!f)
    39d2:	c53d                	beqz	a0,3a40 <fopen+0xba>
    memset(f, 0, sizeof(FILE));
    39d4:	42000613          	li	a2,1056
    39d8:	4581                	li	a1,0
    39da:	0ee010ef          	jal	4ac8 <memset>
    if (fd == 1)
    39de:	4785                	li	a5,1
    f->fd = (int)fd;
    39e0:	00992023          	sw	s1,0(s2)
    f->flags = flags;
    39e4:	00892223          	sw	s0,4(s2)
    if (fd == 1)
    39e8:	00f48e63          	beq	s1,a5,3a04 <fopen+0x7e>
    else if (fd == 2)
    39ec:	4789                	li	a5,2
    39ee:	00f48b63          	beq	s1,a5,3a04 <fopen+0x7e>
        f->buf_mode = 0;
    39f2:	40092e23          	sw	zero,1052(s2)
}
    39f6:	60e2                	ld	ra,24(sp)
    39f8:	6442                	ld	s0,16(sp)
    39fa:	64a2                	ld	s1,8(sp)
    39fc:	854a                	mv	a0,s2
    39fe:	6902                	ld	s2,0(sp)
    3a00:	6105                	addi	sp,sp,32
    3a02:	8082                	ret
    3a04:	60e2                	ld	ra,24(sp)
    3a06:	6442                	ld	s0,16(sp)
        f->buf_mode = 2;
    3a08:	40992e23          	sw	s1,1052(s2)
}
    3a0c:	854a                	mv	a0,s2
    3a0e:	64a2                	ld	s1,8(sp)
    3a10:	6902                	ld	s2,0(sp)
    3a12:	6105                	addi	sp,sp,32
    3a14:	8082                	ret
    else if (strcmp(mode, "a") == 0)
    3a16:	00001597          	auipc	a1,0x1
    3a1a:	71a58593          	addi	a1,a1,1818 # 5130 <_GLOBAL__sub_I__ZSt3cin+0x150>
    3a1e:	8526                	mv	a0,s1
    3a20:	216010ef          	jal	4c36 <strcmp>
        flags = O_WRONLY | O_CREAT | O_APPEND;
    3a24:	44100413          	li	s0,1089
    else if (strcmp(mode, "a") == 0)
    3a28:	d949                	beqz	a0,39ba <fopen+0x34>
    else if (strcmp(mode, "r+") == 0)
    3a2a:	00001597          	auipc	a1,0x1
    3a2e:	70e58593          	addi	a1,a1,1806 # 5138 <_GLOBAL__sub_I__ZSt3cin+0x158>
    3a32:	8526                	mv	a0,s1
    3a34:	202010ef          	jal	4c36 <strcmp>
        flags = O_RDWR;
    3a38:	4409                	li	s0,2
    else if (strcmp(mode, "r+") == 0)
    3a3a:	d141                	beqz	a0,39ba <fopen+0x34>
        return NULL;
    3a3c:	4901                	li	s2,0
    3a3e:	bf65                	j	39f6 <fopen+0x70>
        close(fd);
    3a40:	8526                	mv	a0,s1
    3a42:	eaefc0ef          	jal	f0 <close>
        return NULL;
    3a46:	4901                	li	s2,0
    3a48:	b77d                	j	39f6 <fopen+0x70>

0000000000003a4a <fclose>:
    if (!stream)
    3a4a:	cd29                	beqz	a0,3aa4 <fclose+0x5a>
    if (stream->buf_write_pos > 0)
    3a4c:	41052603          	lw	a2,1040(a0)
{
    3a50:	1141                	addi	sp,sp,-16
    3a52:	e022                	sd	s0,0(sp)
    3a54:	e406                	sd	ra,8(sp)
    3a56:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    3a58:	02c04a63          	bgtz	a2,3a8c <fclose+0x42>
    if (stream != stdin && stream != stdout && stream != stderr)
    3a5c:	00004797          	auipc	a5,0x4
    3a60:	c7478793          	addi	a5,a5,-908 # 76d0 <stdout>
    3a64:	6798                	ld	a4,8(a5)
    3a66:	00870e63          	beq	a4,s0,3a82 <fclose+0x38>
    3a6a:	6398                	ld	a4,0(a5)
    3a6c:	00870b63          	beq	a4,s0,3a82 <fclose+0x38>
    3a70:	6b9c                	ld	a5,16(a5)
    3a72:	00878863          	beq	a5,s0,3a82 <fclose+0x38>
        close(stream->fd);
    3a76:	4008                	lw	a0,0(s0)
    3a78:	e78fc0ef          	jal	f0 <close>
        free(stream);
    3a7c:	8522                	mv	a0,s0
    3a7e:	1cb000ef          	jal	4448 <free>
}
    3a82:	60a2                	ld	ra,8(sp)
    3a84:	6402                	ld	s0,0(sp)
    return 0;
    3a86:	4501                	li	a0,0
}
    3a88:	0141                	addi	sp,sp,16
    3a8a:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3a8c:	4108                	lw	a0,0(a0)
    3a8e:	01040593          	addi	a1,s0,16
    3a92:	e56fc0ef          	jal	e8 <write>
        if (ret < stream->buf_write_pos)
    3a96:	41042783          	lw	a5,1040(s0)
    3a9a:	00f54763          	blt	a0,a5,3aa8 <fclose+0x5e>
        stream->buf_write_pos = 0;
    3a9e:	40042823          	sw	zero,1040(s0)
    3aa2:	bf6d                	j	3a5c <fclose+0x12>
        return -1;
    3aa4:	557d                	li	a0,-1
}
    3aa6:	8082                	ret
            stream->error = 1;
    3aa8:	4785                	li	a5,1
    3aaa:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3aac:	40042823          	sw	zero,1040(s0)
            return EOF;
    3ab0:	b775                	j	3a5c <fclose+0x12>

0000000000003ab2 <fflush>:
    if (!stream)
    3ab2:	c121                	beqz	a0,3af2 <fflush+0x40>
    if (stream->buf_write_pos > 0)
    3ab4:	41052603          	lw	a2,1040(a0)
{
    3ab8:	1141                	addi	sp,sp,-16
    3aba:	e022                	sd	s0,0(sp)
    3abc:	e406                	sd	ra,8(sp)
    3abe:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    3ac0:	00c04763          	bgtz	a2,3ace <fflush+0x1c>
    return 0;
    3ac4:	4501                	li	a0,0
}
    3ac6:	60a2                	ld	ra,8(sp)
    3ac8:	6402                	ld	s0,0(sp)
    3aca:	0141                	addi	sp,sp,16
    3acc:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3ace:	4108                	lw	a0,0(a0)
    3ad0:	01040593          	addi	a1,s0,16
    3ad4:	e14fc0ef          	jal	e8 <write>
        if (ret < stream->buf_write_pos)
    3ad8:	41042783          	lw	a5,1040(s0)
    3adc:	00f54563          	blt	a0,a5,3ae6 <fflush+0x34>
        stream->buf_write_pos = 0;
    3ae0:	40042823          	sw	zero,1040(s0)
    3ae4:	b7c5                	j	3ac4 <fflush+0x12>
            stream->error = 1;
    3ae6:	4785                	li	a5,1
    3ae8:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3aea:	40042823          	sw	zero,1040(s0)
        return EOF;
    3aee:	557d                	li	a0,-1
    3af0:	bfd9                	j	3ac6 <fflush+0x14>
    3af2:	557d                	li	a0,-1
}
    3af4:	8082                	ret

0000000000003af6 <fprintf>:
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
    3b06:	cd19                	beqz	a0,3b24 <fprintf+0x2e>
    va_start(ap, format);
    3b08:	832a                	mv	t1,a0
    3b0a:	0090                	addi	a2,sp,64
    _vprintf_core(&ctx, format, ap);
    3b0c:	0808                	addi	a0,sp,16
    va_start(ap, format);
    3b0e:	e432                	sd	a2,8(sp)
    ctx.buf = NULL;
    3b10:	e802                	sd	zero,16(sp)
    ctx.limit = 0;
    3b12:	ec02                	sd	zero,24(sp)
    ctx.written = 0;
    3b14:	f002                	sd	zero,32(sp)
    ctx.stream  = stream;
    3b16:	f41a                	sd	t1,40(sp)
    _vprintf_core(&ctx, format, ap);
    3b18:	d34ff0ef          	jal	304c <_vprintf_core.constprop.0.isra.0>
    return (int)ctx.written;
    3b1c:	5502                	lw	a0,32(sp)
}
    3b1e:	70e2                	ld	ra,56(sp)
    3b20:	6165                	addi	sp,sp,112
    3b22:	8082                	ret
        return -1;
    3b24:	557d                	li	a0,-1
    3b26:	bfe5                	j	3b1e <fprintf+0x28>

0000000000003b28 <fscanf>:
{
    3b28:	7159                	addi	sp,sp,-112
    3b2a:	fc06                	sd	ra,56(sp)
    3b2c:	e0b2                	sd	a2,64(sp)
    3b2e:	e4b6                	sd	a3,72(sp)
    3b30:	e8ba                	sd	a4,80(sp)
    3b32:	ecbe                	sd	a5,88(sp)
    3b34:	f0c2                	sd	a6,96(sp)
    3b36:	f4c6                	sd	a7,104(sp)
    if (!stream)
    3b38:	cd19                	beqz	a0,3b56 <fscanf+0x2e>
    ctx.fd = stream->fd;
    3b3a:	411c                	lw	a5,0(a0)
    va_start(ap, format);
    3b3c:	0090                	addi	a2,sp,64
    int ret = _vscanf_core(&ctx, format, ap);
    3b3e:	0808                	addi	a0,sp,16
    ctx.fd = stream->fd;
    3b40:	cc3e                	sw	a5,24(sp)
    ctx.ungotten = -1;
    3b42:	57fd                	li	a5,-1
    va_start(ap, format);
    3b44:	e432                	sd	a2,8(sp)
    ctx.buf = NULL;
    3b46:	e802                	sd	zero,16(sp)
    ctx.pos = 0;
    3b48:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    3b4a:	d43e                	sw	a5,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    3b4c:	e1dfc0ef          	jal	968 <_vscanf_core.constprop.0>
}
    3b50:	70e2                	ld	ra,56(sp)
    3b52:	6165                	addi	sp,sp,112
    3b54:	8082                	ret
        return -1;
    3b56:	557d                	li	a0,-1
    3b58:	bfe5                	j	3b50 <fscanf+0x28>

0000000000003b5a <fputc>:
    if (!stream)
    3b5a:	c1e1                	beqz	a1,3c1a <fputc+0xc0>
{
    3b5c:	7179                	addi	sp,sp,-48
    3b5e:	e84a                	sd	s2,16(sp)
    if (stream->buf_mode == 2)
    3b60:	41c5a903          	lw	s2,1052(a1)
{
    3b64:	f022                	sd	s0,32(sp)
    3b66:	ec26                	sd	s1,24(sp)
    3b68:	f406                	sd	ra,40(sp)
    if (stream->buf_mode == 2)
    3b6a:	4789                	li	a5,2
    3b6c:	842e                	mv	s0,a1
    3b6e:	84aa                	mv	s1,a0
        char ch = (char)c;
    3b70:	0ff57713          	zext.b	a4,a0
    if (stream->buf_mode == 2)
    3b74:	02f90963          	beq	s2,a5,3ba6 <fputc+0x4c>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    3b78:	4105a783          	lw	a5,1040(a1)
    if (stream->buf_write_pos >= BUFSIZ)
    3b7c:	3ff00693          	li	a3,1023
    stream->buffer[stream->buf_write_pos++] = (char)c;
    3b80:	0017861b          	addiw	a2,a5,1
    3b84:	40c5a823          	sw	a2,1040(a1)
    3b88:	97ae                	add	a5,a5,a1
    3b8a:	00e78823          	sb	a4,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    3b8e:	06c6c463          	blt	a3,a2,3bf6 <fputc+0x9c>
    else if (stream->buf_mode == 1 && c == '\n')
    3b92:	4785                	li	a5,1
    3b94:	02f90e63          	beq	s2,a5,3bd0 <fputc+0x76>
    return c;
    3b98:	8526                	mv	a0,s1
}
    3b9a:	70a2                	ld	ra,40(sp)
    3b9c:	7402                	ld	s0,32(sp)
    3b9e:	64e2                	ld	s1,24(sp)
    3ba0:	6942                	ld	s2,16(sp)
    3ba2:	6145                	addi	sp,sp,48
    3ba4:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    3ba6:	4188                	lw	a0,0(a1)
    3ba8:	4605                	li	a2,1
    3baa:	00f10593          	addi	a1,sp,15
        char ch = (char)c;
    3bae:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    3bb2:	d36fc0ef          	jal	e8 <write>
    3bb6:	872a                	mv	a4,a0
    3bb8:	4785                	li	a5,1
        return c;
    3bba:	8526                	mv	a0,s1
        if (write(stream->fd, &ch, 1) != 1)
    3bbc:	fcf70fe3          	beq	a4,a5,3b9a <fputc+0x40>
}
    3bc0:	70a2                	ld	ra,40(sp)
            stream->error = 1;
    3bc2:	c41c                	sw	a5,8(s0)
}
    3bc4:	7402                	ld	s0,32(sp)
    3bc6:	64e2                	ld	s1,24(sp)
    3bc8:	6942                	ld	s2,16(sp)
            return EOF;
    3bca:	557d                	li	a0,-1
}
    3bcc:	6145                	addi	sp,sp,48
    3bce:	8082                	ret
    else if (stream->buf_mode == 1 && c == '\n')
    3bd0:	47a9                	li	a5,10
    3bd2:	fcf513e3          	bne	a0,a5,3b98 <fputc+0x3e>
    if (stream->buf_write_pos > 0)
    3bd6:	fcc051e3          	blez	a2,3b98 <fputc+0x3e>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3bda:	4188                	lw	a0,0(a1)
    3bdc:	05c1                	addi	a1,a1,16
    3bde:	d0afc0ef          	jal	e8 <write>
        if (ret < stream->buf_write_pos)
    3be2:	41042783          	lw	a5,1040(s0)
    3be6:	02f55063          	bge	a0,a5,3c06 <fputc+0xac>
            stream->error = 1;
    3bea:	01242423          	sw	s2,8(s0)
            stream->buf_write_pos = 0;
    3bee:	40042823          	sw	zero,1040(s0)
    return c;
    3bf2:	8526                	mv	a0,s1
    3bf4:	b75d                	j	3b9a <fputc+0x40>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3bf6:	4188                	lw	a0,0(a1)
    3bf8:	05c1                	addi	a1,a1,16
    3bfa:	ceefc0ef          	jal	e8 <write>
        if (ret < stream->buf_write_pos)
    3bfe:	41042783          	lw	a5,1040(s0)
    3c02:	00f54663          	blt	a0,a5,3c0e <fputc+0xb4>
        stream->buf_write_pos = 0;
    3c06:	40042823          	sw	zero,1040(s0)
    return c;
    3c0a:	8526                	mv	a0,s1
    3c0c:	b779                	j	3b9a <fputc+0x40>
            stream->error = 1;
    3c0e:	4785                	li	a5,1
    3c10:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3c12:	40042823          	sw	zero,1040(s0)
    return c;
    3c16:	8526                	mv	a0,s1
    3c18:	b749                	j	3b9a <fputc+0x40>
        return EOF;
    3c1a:	557d                	li	a0,-1
}
    3c1c:	8082                	ret

0000000000003c1e <fputs>:
    if (!stream)
    3c1e:	c1ed                	beqz	a1,3d00 <fputs+0xe2>
{
    3c20:	711d                	addi	sp,sp,-96
    3c22:	e4a6                	sd	s1,72(sp)
    3c24:	ec86                	sd	ra,88(sp)
    while (*s)
    3c26:	00054703          	lbu	a4,0(a0)
    3c2a:	84aa                	mv	s1,a0
    3c2c:	cf25                	beqz	a4,3ca4 <fputs+0x86>
    3c2e:	e8a2                	sd	s0,80(sp)
    3c30:	e0ca                	sd	s2,64(sp)
    3c32:	fc4e                	sd	s3,56(sp)
    3c34:	f852                	sd	s4,48(sp)
    3c36:	f456                	sd	s5,40(sp)
    3c38:	f05a                	sd	s6,32(sp)
    3c3a:	ec5e                	sd	s7,24(sp)
    3c3c:	842e                	mv	s0,a1
    if (stream->buf_mode == 2)
    3c3e:	4909                	li	s2,2
    if (stream->buf_write_pos >= BUFSIZ)
    3c40:	3ff00b13          	li	s6,1023
    else if (stream->buf_mode == 1 && c == '\n')
    3c44:	4985                	li	s3,1
    3c46:	4a29                	li	s4,10
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3c48:	01058a93          	addi	s5,a1,16
        if (write(stream->fd, &ch, 1) != 1)
    3c4c:	00f10b93          	addi	s7,sp,15
    3c50:	a031                	j	3c5c <fputs+0x3e>
    else if (stream->buf_mode == 1 && c == '\n')
    3c52:	09368563          	beq	a3,s3,3cdc <fputs+0xbe>
    while (*s)
    3c56:	0004c703          	lbu	a4,0(s1)
    3c5a:	cf15                	beqz	a4,3c96 <fputs+0x78>
    if (stream->buf_mode == 2)
    3c5c:	41c42683          	lw	a3,1052(s0)
        if (fputc(*s++, stream) == EOF)
    3c60:	0485                	addi	s1,s1,1
    if (stream->buf_mode == 2)
    3c62:	05268663          	beq	a3,s2,3cae <fputs+0x90>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    3c66:	41042783          	lw	a5,1040(s0)
    3c6a:	0017861b          	addiw	a2,a5,1
    3c6e:	40c42823          	sw	a2,1040(s0)
    3c72:	97a2                	add	a5,a5,s0
    3c74:	00e78823          	sb	a4,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    3c78:	fccb5de3          	bge	s6,a2,3c52 <fputs+0x34>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3c7c:	4008                	lw	a0,0(s0)
    3c7e:	85d6                	mv	a1,s5
    3c80:	c68fc0ef          	jal	e8 <write>
        if (ret < stream->buf_write_pos)
    3c84:	41042783          	lw	a5,1040(s0)
    3c88:	06f54763          	blt	a0,a5,3cf6 <fputs+0xd8>
        stream->buf_write_pos = 0;
    3c8c:	40042823          	sw	zero,1040(s0)
    while (*s)
    3c90:	0004c703          	lbu	a4,0(s1)
    3c94:	f761                	bnez	a4,3c5c <fputs+0x3e>
    3c96:	6446                	ld	s0,80(sp)
    3c98:	6906                	ld	s2,64(sp)
    3c9a:	79e2                	ld	s3,56(sp)
    3c9c:	7a42                	ld	s4,48(sp)
    3c9e:	7aa2                	ld	s5,40(sp)
    3ca0:	7b02                	ld	s6,32(sp)
    3ca2:	6be2                	ld	s7,24(sp)
}
    3ca4:	60e6                	ld	ra,88(sp)
    3ca6:	64a6                	ld	s1,72(sp)
    return 0;
    3ca8:	4501                	li	a0,0
}
    3caa:	6125                	addi	sp,sp,96
    3cac:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    3cae:	4008                	lw	a0,0(s0)
    3cb0:	4605                	li	a2,1
    3cb2:	85de                	mv	a1,s7
        char ch = (char)c;
    3cb4:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    3cb8:	c30fc0ef          	jal	e8 <write>
    3cbc:	f9350de3          	beq	a0,s3,3c56 <fputs+0x38>
            stream->error = 1;
    3cc0:	01342423          	sw	s3,8(s0)
}
    3cc4:	60e6                	ld	ra,88(sp)
    3cc6:	6446                	ld	s0,80(sp)
    3cc8:	6906                	ld	s2,64(sp)
    3cca:	79e2                	ld	s3,56(sp)
    3ccc:	7a42                	ld	s4,48(sp)
    3cce:	7aa2                	ld	s5,40(sp)
    3cd0:	7b02                	ld	s6,32(sp)
    3cd2:	6be2                	ld	s7,24(sp)
    3cd4:	64a6                	ld	s1,72(sp)
        return -1;
    3cd6:	557d                	li	a0,-1
}
    3cd8:	6125                	addi	sp,sp,96
    3cda:	8082                	ret
    else if (stream->buf_mode == 1 && c == '\n')
    3cdc:	f7471de3          	bne	a4,s4,3c56 <fputs+0x38>
    if (stream->buf_write_pos > 0)
    3ce0:	f6c05be3          	blez	a2,3c56 <fputs+0x38>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3ce4:	4008                	lw	a0,0(s0)
    3ce6:	01040593          	addi	a1,s0,16
    3cea:	bfefc0ef          	jal	e8 <write>
        if (ret < stream->buf_write_pos)
    3cee:	41042783          	lw	a5,1040(s0)
    3cf2:	f8f55de3          	bge	a0,a5,3c8c <fputs+0x6e>
            stream->error = 1;
    3cf6:	4785                	li	a5,1
    3cf8:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3cfa:	40042823          	sw	zero,1040(s0)
            return EOF;
    3cfe:	bfa1                	j	3c56 <fputs+0x38>
        return -1;
    3d00:	557d                	li	a0,-1
}
    3d02:	8082                	ret

0000000000003d04 <fgetc>:
    if (!stream)
    3d04:	c949                	beqz	a0,3d96 <fgetc+0x92>
    if (stream->buf_write_pos > 0)
    3d06:	41052603          	lw	a2,1040(a0)
{
    3d0a:	1141                	addi	sp,sp,-16
    3d0c:	e022                	sd	s0,0(sp)
    3d0e:	e406                	sd	ra,8(sp)
    3d10:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    3d12:	04c04863          	bgtz	a2,3d62 <fgetc+0x5e>
    if (stream->buf_read_pos < stream->buf_read_cnt)
    3d16:	41442783          	lw	a5,1044(s0)
    3d1a:	41842703          	lw	a4,1048(s0)
    3d1e:	00e7dd63          	bge	a5,a4,3d38 <fgetc+0x34>
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3d22:	0017871b          	addiw	a4,a5,1
    3d26:	40e42a23          	sw	a4,1044(s0)
    3d2a:	943e                	add	s0,s0,a5
    3d2c:	01044503          	lbu	a0,16(s0)
}
    3d30:	60a2                	ld	ra,8(sp)
    3d32:	6402                	ld	s0,0(sp)
    3d34:	0141                	addi	sp,sp,16
    3d36:	8082                	ret
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3d38:	4008                	lw	a0,0(s0)
    3d3a:	40000613          	li	a2,1024
    3d3e:	01040593          	addi	a1,s0,16
    3d42:	b9efc0ef          	jal	e0 <read>
    3d46:	87aa                	mv	a5,a0
    if (ret <= 0)
    3d48:	02a05e63          	blez	a0,3d84 <fgetc+0x80>
    stream->buf_read_cnt = (int)ret;
    3d4c:	40f42c23          	sw	a5,1048(s0)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3d50:	4785                	li	a5,1
    3d52:	01044503          	lbu	a0,16(s0)
}
    3d56:	60a2                	ld	ra,8(sp)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3d58:	40f42a23          	sw	a5,1044(s0)
}
    3d5c:	6402                	ld	s0,0(sp)
    3d5e:	0141                	addi	sp,sp,16
    3d60:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3d62:	4108                	lw	a0,0(a0)
    3d64:	01040593          	addi	a1,s0,16
    3d68:	b80fc0ef          	jal	e8 <write>
        if (ret < stream->buf_write_pos)
    3d6c:	41042783          	lw	a5,1040(s0)
    3d70:	00f54563          	blt	a0,a5,3d7a <fgetc+0x76>
        stream->buf_write_pos = 0;
    3d74:	40042823          	sw	zero,1040(s0)
    3d78:	bf79                	j	3d16 <fgetc+0x12>
            stream->error = 1;
    3d7a:	4785                	li	a5,1
    3d7c:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3d7e:	40042823          	sw	zero,1040(s0)
            return EOF;
    3d82:	bf51                	j	3d16 <fgetc+0x12>
        if (ret == 0)
    3d84:	e509                	bnez	a0,3d8e <fgetc+0x8a>
            stream->eof = 1;
    3d86:	4785                	li	a5,1
    3d88:	c45c                	sw	a5,12(s0)
        return EOF;
    3d8a:	557d                	li	a0,-1
    3d8c:	b755                	j	3d30 <fgetc+0x2c>
            stream->error = 1;
    3d8e:	4785                	li	a5,1
    3d90:	c41c                	sw	a5,8(s0)
        return EOF;
    3d92:	557d                	li	a0,-1
    3d94:	bf71                	j	3d30 <fgetc+0x2c>
    3d96:	557d                	li	a0,-1
}
    3d98:	8082                	ret

0000000000003d9a <fgets>:
    if (!stream || n <= 0)
    3d9a:	ce5d                	beqz	a2,3e58 <fgets+0xbe>
    3d9c:	0ab05e63          	blez	a1,3e58 <fgets+0xbe>
{
    3da0:	715d                	addi	sp,sp,-80
    3da2:	e0a2                	sd	s0,64(sp)
    3da4:	fc26                	sd	s1,56(sp)
    3da6:	f84a                	sd	s2,48(sp)
    3da8:	f44e                	sd	s3,40(sp)
    3daa:	f052                	sd	s4,32(sp)
    3dac:	ec56                	sd	s5,24(sp)
    3dae:	e85a                	sd	s6,16(sp)
    3db0:	e45e                	sd	s7,8(sp)
    3db2:	e486                	sd	ra,72(sp)
    3db4:	8432                	mv	s0,a2
    3db6:	8aaa                	mv	s5,a0
    3db8:	892a                	mv	s2,a0
    3dba:	fff58b9b          	addiw	s7,a1,-1
    int i = 0, c;
    3dbe:	4481                	li	s1,0
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3dc0:	01060993          	addi	s3,a2,16
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3dc4:	4b05                	li	s6,1
        if (c == '\n')
    3dc6:	4a29                	li	s4,10
    while (i < n - 1)
    3dc8:	05748163          	beq	s1,s7,3e0a <fgets+0x70>
    if (stream->buf_write_pos > 0)
    3dcc:	41042603          	lw	a2,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3dd0:	85ce                	mv	a1,s3
    if (stream->buf_write_pos > 0)
    3dd2:	06c04963          	bgtz	a2,3e44 <fgets+0xaa>
    if (stream->buf_read_pos < stream->buf_read_cnt)
    3dd6:	41442783          	lw	a5,1044(s0)
    3dda:	41842703          	lw	a4,1048(s0)
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3dde:	40000613          	li	a2,1024
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3de2:	0017851b          	addiw	a0,a5,1
    3de6:	00f406b3          	add	a3,s0,a5
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3dea:	85ce                	mv	a1,s3
    if (stream->buf_read_pos < stream->buf_read_cnt)
    3dec:	02e7de63          	bge	a5,a4,3e28 <fgets+0x8e>
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3df0:	40a42a23          	sw	a0,1044(s0)
    3df4:	0106c783          	lbu	a5,16(a3)
    3df8:	0007871b          	sext.w	a4,a5
        str[i++] = (char)c;
    3dfc:	00f90023          	sb	a5,0(s2)
    3e00:	2485                	addiw	s1,s1,1
        if (c == '\n')
    3e02:	0905                	addi	s2,s2,1
    3e04:	fd4712e3          	bne	a4,s4,3dc8 <fgets+0x2e>
        str[i++] = (char)c;
    3e08:	8ba6                	mv	s7,s1
    str[i] = '\0';
    3e0a:	9bd6                	add	s7,s7,s5
    3e0c:	000b8023          	sb	zero,0(s7)
    return str;
    3e10:	8556                	mv	a0,s5
}
    3e12:	60a6                	ld	ra,72(sp)
    3e14:	6406                	ld	s0,64(sp)
    3e16:	74e2                	ld	s1,56(sp)
    3e18:	7942                	ld	s2,48(sp)
    3e1a:	79a2                	ld	s3,40(sp)
    3e1c:	7a02                	ld	s4,32(sp)
    3e1e:	6ae2                	ld	s5,24(sp)
    3e20:	6b42                	ld	s6,16(sp)
    3e22:	6ba2                	ld	s7,8(sp)
    3e24:	6161                	addi	sp,sp,80
    3e26:	8082                	ret
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3e28:	4008                	lw	a0,0(s0)
    3e2a:	ab6fc0ef          	jal	e0 <read>
    if (ret <= 0)
    3e2e:	02a05c63          	blez	a0,3e66 <fgets+0xcc>
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3e32:	01044783          	lbu	a5,16(s0)
    stream->buf_read_cnt = (int)ret;
    3e36:	40a42c23          	sw	a0,1048(s0)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3e3a:	41642a23          	sw	s6,1044(s0)
    3e3e:	0007871b          	sext.w	a4,a5
        if (c == -1)
    3e42:	bf6d                	j	3dfc <fgets+0x62>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3e44:	4008                	lw	a0,0(s0)
    3e46:	aa2fc0ef          	jal	e8 <write>
        if (ret < stream->buf_write_pos)
    3e4a:	41042783          	lw	a5,1040(s0)
    3e4e:	00f54763          	blt	a0,a5,3e5c <fgets+0xc2>
        stream->buf_write_pos = 0;
    3e52:	40042823          	sw	zero,1040(s0)
    3e56:	b741                	j	3dd6 <fgets+0x3c>
        return NULL;
    3e58:	4501                	li	a0,0
}
    3e5a:	8082                	ret
            stream->error = 1;
    3e5c:	4785                	li	a5,1
    3e5e:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3e60:	40042823          	sw	zero,1040(s0)
            return EOF;
    3e64:	bf8d                	j	3dd6 <fgets+0x3c>
            stream->eof = 1;
    3e66:	4785                	li	a5,1
        if (ret == 0)
    3e68:	e509                	bnez	a0,3e72 <fgets+0xd8>
            stream->eof = 1;
    3e6a:	c45c                	sw	a5,12(s0)
            if (i == 0)
    3e6c:	fcd1                	bnez	s1,3e08 <fgets+0x6e>
        return NULL;
    3e6e:	4501                	li	a0,0
    3e70:	b74d                	j	3e12 <fgets+0x78>
            stream->error = 1;
    3e72:	c41c                	sw	a5,8(s0)
        if (c == -1)
    3e74:	bfe5                	j	3e6c <fgets+0xd2>

0000000000003e76 <fread>:
{
    3e76:	715d                	addi	sp,sp,-80
    3e78:	e486                	sd	ra,72(sp)
    3e7a:	f44e                	sd	s3,40(sp)
    if (!stream || size == 0 || nmemb == 0)
    3e7c:	0e068963          	beqz	a3,3f6e <fread+0xf8>
    3e80:	ec56                	sd	s5,24(sp)
        return 0;
    3e82:	4981                	li	s3,0
    3e84:	8aae                	mv	s5,a1
    if (!stream || size == 0 || nmemb == 0)
    3e86:	c9bd                	beqz	a1,3efc <fread+0x86>
    3e88:	ca35                	beqz	a2,3efc <fread+0x86>
    if (stream->buf_write_pos > 0)
    3e8a:	4106a783          	lw	a5,1040(a3)
    3e8e:	e0a2                	sd	s0,64(sp)
    3e90:	f052                	sd	s4,32(sp)
    uint64 total_bytes = size * nmemb;
    3e92:	02c589b3          	mul	s3,a1,a2
    3e96:	8436                	mv	s0,a3
    3e98:	8a2a                	mv	s4,a0
    if (stream->buf_write_pos > 0)
    3e9a:	0af04d63          	bgtz	a5,3f54 <fread+0xde>
    while (bytes_read < total_bytes)
    3e9e:	04098d63          	beqz	s3,3ef8 <fread+0x82>
    3ea2:	fc26                	sd	s1,56(sp)
    3ea4:	e85a                	sd	s6,16(sp)
    3ea6:	e45e                	sd	s7,8(sp)
    3ea8:	f84a                	sd	s2,48(sp)
    3eaa:	4481                	li	s1,0
            if (remaining >= BUFSIZ)
    3eac:	3ff00b13          	li	s6,1023
                int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3eb0:	01040b93          	addi	s7,s0,16
        if (stream->buf_read_pos < stream->buf_read_cnt)
    3eb4:	41442703          	lw	a4,1044(s0)
    3eb8:	41842783          	lw	a5,1048(s0)
            uint64 remaining = total_bytes - bytes_read;
    3ebc:	40998633          	sub	a2,s3,s1
        if (stream->buf_read_pos < stream->buf_read_cnt)
    3ec0:	06f74463          	blt	a4,a5,3f28 <fread+0xb2>
                int64 ret = read(stream->fd, dst + bytes_read, remaining);
    3ec4:	4008                	lw	a0,0(s0)
    3ec6:	009a05b3          	add	a1,s4,s1
            if (remaining >= BUFSIZ)
    3eca:	02cb7f63          	bgeu	s6,a2,3f08 <fread+0x92>
                int64 ret = read(stream->fd, dst + bytes_read, remaining);
    3ece:	a12fc0ef          	jal	e0 <read>
                if (ret <= 0)
    3ed2:	0aa05463          	blez	a0,3f7a <fread+0x104>
                bytes_read += ret;
    3ed6:	94aa                	add	s1,s1,a0
    while (bytes_read < total_bytes)
    3ed8:	fd34eee3          	bltu	s1,s3,3eb4 <fread+0x3e>
    return bytes_read / size;
    3edc:	0354d9b3          	divu	s3,s1,s5
    3ee0:	6406                	ld	s0,64(sp)
}
    3ee2:	60a6                	ld	ra,72(sp)
    return bytes_read / size;
    3ee4:	74e2                	ld	s1,56(sp)
    3ee6:	7942                	ld	s2,48(sp)
    3ee8:	7a02                	ld	s4,32(sp)
    3eea:	6ae2                	ld	s5,24(sp)
    3eec:	6b42                	ld	s6,16(sp)
    3eee:	6ba2                	ld	s7,8(sp)
}
    3ef0:	854e                	mv	a0,s3
    3ef2:	79a2                	ld	s3,40(sp)
    3ef4:	6161                	addi	sp,sp,80
    3ef6:	8082                	ret
    3ef8:	6406                	ld	s0,64(sp)
    3efa:	7a02                	ld	s4,32(sp)
    3efc:	60a6                	ld	ra,72(sp)
    3efe:	6ae2                	ld	s5,24(sp)
    3f00:	854e                	mv	a0,s3
    3f02:	79a2                	ld	s3,40(sp)
    3f04:	6161                	addi	sp,sp,80
    3f06:	8082                	ret
                stream->buf_read_pos = 0;
    3f08:	40042a23          	sw	zero,1044(s0)
                stream->buf_read_cnt = 0;
    3f0c:	40042c23          	sw	zero,1048(s0)
                int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3f10:	40000613          	li	a2,1024
    3f14:	85de                	mv	a1,s7
    3f16:	9cafc0ef          	jal	e0 <read>
                if (ret <= 0)
    3f1a:	06a05063          	blez	a0,3f7a <fread+0x104>
                stream->buf_read_cnt = (int)ret;
    3f1e:	40a42c23          	sw	a0,1048(s0)
    while (bytes_read < total_bytes)
    3f22:	f934e9e3          	bltu	s1,s3,3eb4 <fread+0x3e>
    3f26:	bf5d                	j	3edc <fread+0x66>
            uint64 available = stream->buf_read_cnt - stream->buf_read_pos;
    3f28:	40e7893b          	subw	s2,a5,a4
            memcpy(dst + bytes_read, stream->buffer + stream->buf_read_pos, to_copy);
    3f2c:	00eb85b3          	add	a1,s7,a4
    3f30:	009a0533          	add	a0,s4,s1
            uint64 to_copy = (available < remaining) ? available : remaining;
    3f34:	01267363          	bgeu	a2,s2,3f3a <fread+0xc4>
    3f38:	8932                	mv	s2,a2
            memcpy(dst + bytes_read, stream->buffer + stream->buf_read_pos, to_copy);
    3f3a:	864a                	mv	a2,s2
    3f3c:	3e1000ef          	jal	4b1c <memcpy>
            stream->buf_read_pos += to_copy;
    3f40:	41442783          	lw	a5,1044(s0)
            bytes_read += to_copy;
    3f44:	94ca                	add	s1,s1,s2
            stream->buf_read_pos += to_copy;
    3f46:	012787bb          	addw	a5,a5,s2
    3f4a:	40f42a23          	sw	a5,1044(s0)
    while (bytes_read < total_bytes)
    3f4e:	f734e3e3          	bltu	s1,s3,3eb4 <fread+0x3e>
    3f52:	b769                	j	3edc <fread+0x66>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3f54:	4288                	lw	a0,0(a3)
    3f56:	863e                	mv	a2,a5
    3f58:	01068593          	addi	a1,a3,16
    3f5c:	98cfc0ef          	jal	e8 <write>
        if (ret < stream->buf_write_pos)
    3f60:	41042783          	lw	a5,1040(s0)
    3f64:	02f54163          	blt	a0,a5,3f86 <fread+0x110>
        stream->buf_write_pos = 0;
    3f68:	40042823          	sw	zero,1040(s0)
    3f6c:	bf0d                	j	3e9e <fread+0x28>
}
    3f6e:	60a6                	ld	ra,72(sp)
        return 0;
    3f70:	4981                	li	s3,0
}
    3f72:	854e                	mv	a0,s3
    3f74:	79a2                	ld	s3,40(sp)
    3f76:	6161                	addi	sp,sp,80
    3f78:	8082                	ret
                        stream->eof = 1;
    3f7a:	4785                	li	a5,1
                    if (ret == 0)
    3f7c:	e119                	bnez	a0,3f82 <fread+0x10c>
                        stream->eof = 1;
    3f7e:	c45c                	sw	a5,12(s0)
    3f80:	bfb1                	j	3edc <fread+0x66>
                        stream->error = 1;
    3f82:	c41c                	sw	a5,8(s0)
                    return bytes_read / size;
    3f84:	bfa1                	j	3edc <fread+0x66>
            stream->error = 1;
    3f86:	4785                	li	a5,1
    3f88:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3f8a:	40042823          	sw	zero,1040(s0)
            return EOF;
    3f8e:	bf01                	j	3e9e <fread+0x28>

0000000000003f90 <fwrite>:
{
    3f90:	711d                	addi	sp,sp,-96
    3f92:	ec86                	sd	ra,88(sp)
    3f94:	e0ca                	sd	s2,64(sp)
    if (!stream || !ptr || size == 0 || nmemb == 0)
    3f96:	10068063          	beqz	a3,4096 <fwrite+0x106>
    3f9a:	f456                	sd	s5,40(sp)
    3f9c:	8aaa                	mv	s5,a0
    3f9e:	10050263          	beqz	a0,40a2 <fwrite+0x112>
    3fa2:	f05a                	sd	s6,32(sp)
        return 0;
    3fa4:	4901                	li	s2,0
    3fa6:	8b2e                	mv	s6,a1
    if (!stream || !ptr || size == 0 || nmemb == 0)
    3fa8:	c1d9                	beqz	a1,402e <fwrite+0x9e>
    3faa:	c251                	beqz	a2,402e <fwrite+0x9e>
    if (stream->buf_mode == 2)
    3fac:	41c6a703          	lw	a4,1052(a3)
    3fb0:	e8a2                	sd	s0,80(sp)
    3fb2:	4789                	li	a5,2
    uint64 total_bytes = size * nmemb;
    3fb4:	02c58933          	mul	s2,a1,a2
    if (stream->buf_mode == 2)
    3fb8:	8436                	mv	s0,a3
    3fba:	0ef70b63          	beq	a4,a5,40b0 <fwrite+0x120>
    3fbe:	fc4e                	sd	s3,56(sp)
    3fc0:	ec5e                	sd	s7,24(sp)
    3fc2:	e862                	sd	s8,16(sp)
    uint64 bytes_written = 0;
    3fc4:	4981                	li	s3,0
    3fc6:	01068b93          	addi	s7,a3,16
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    3fca:	40000c13          	li	s8,1024
    while (bytes_written < total_bytes)
    3fce:	12090263          	beqz	s2,40f2 <fwrite+0x162>
    3fd2:	e4a6                	sd	s1,72(sp)
    3fd4:	f852                	sd	s4,48(sp)
    3fd6:	e466                	sd	s9,8(sp)
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    3fd8:	41042783          	lw	a5,1040(s0)
        uint64 remaining = total_bytes - bytes_written;
    3fdc:	41390cb3          	sub	s9,s2,s3
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, remaining);
    3fe0:	013a85b3          	add	a1,s5,s3
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    3fe4:	40fc0a3b          	subw	s4,s8,a5
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, space_left);
    3fe8:	00fb8533          	add	a0,s7,a5
    3fec:	8652                	mv	a2,s4
        if (remaining <= space_left)
    3fee:	059a6763          	bltu	s4,s9,403c <fwrite+0xac>
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, remaining);
    3ff2:	8666                	mv	a2,s9
    3ff4:	329000ef          	jal	4b1c <memcpy>
            stream->buf_write_pos += remaining;
    3ff8:	41042783          	lw	a5,1040(s0)
            if (stream->buf_write_pos == BUFSIZ)
    3ffc:	40000713          	li	a4,1024
            stream->buf_write_pos += remaining;
    4000:	019786bb          	addw	a3,a5,s9
    4004:	40d42823          	sw	a3,1040(s0)
            if (stream->buf_write_pos == BUFSIZ)
    4008:	06e68a63          	beq	a3,a4,407c <fwrite+0xec>
    return bytes_written / size;
    400c:	03695933          	divu	s2,s2,s6
    4010:	6446                	ld	s0,80(sp)
    4012:	64a6                	ld	s1,72(sp)
    4014:	79e2                	ld	s3,56(sp)
    4016:	7a42                	ld	s4,48(sp)
    4018:	7aa2                	ld	s5,40(sp)
    401a:	7b02                	ld	s6,32(sp)
    401c:	6be2                	ld	s7,24(sp)
    401e:	6c42                	ld	s8,16(sp)
    4020:	6ca2                	ld	s9,8(sp)
}
    4022:	60e6                	ld	ra,88(sp)
    4024:	854a                	mv	a0,s2
    4026:	6906                	ld	s2,64(sp)
    4028:	6125                	addi	sp,sp,96
    402a:	8082                	ret
    402c:	6446                	ld	s0,80(sp)
    402e:	60e6                	ld	ra,88(sp)
    4030:	7aa2                	ld	s5,40(sp)
    4032:	7b02                	ld	s6,32(sp)
    4034:	854a                	mv	a0,s2
    4036:	6906                	ld	s2,64(sp)
    4038:	6125                	addi	sp,sp,96
    403a:	8082                	ret
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, space_left);
    403c:	2e1000ef          	jal	4b1c <memcpy>
            stream->buf_write_pos += space_left;
    4040:	41042783          	lw	a5,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4044:	85de                	mv	a1,s7
            bytes_written += space_left;
    4046:	99d2                	add	s3,s3,s4
            stream->buf_write_pos += space_left;
    4048:	00fa04bb          	addw	s1,s4,a5
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    404c:	02049613          	slli	a2,s1,0x20
            stream->buf_write_pos += space_left;
    4050:	40942823          	sw	s1,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4054:	9201                	srli	a2,a2,0x20
    if (stream->buf_write_pos > 0)
    4056:	00904763          	bgtz	s1,4064 <fwrite+0xd4>
    while (bytes_written < total_bytes)
    405a:	f729efe3          	bltu	s3,s2,3fd8 <fwrite+0x48>
    return bytes_written / size;
    405e:	0369d933          	divu	s2,s3,s6
    4062:	b77d                	j	4010 <fwrite+0x80>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4064:	4008                	lw	a0,0(s0)
    4066:	882fc0ef          	jal	e8 <write>
        if (ret < stream->buf_write_pos)
    406a:	41042783          	lw	a5,1040(s0)
    406e:	08f54963          	blt	a0,a5,4100 <fwrite+0x170>
        stream->buf_write_pos = 0;
    4072:	40042823          	sw	zero,1040(s0)
    while (bytes_written < total_bytes)
    4076:	f729e1e3          	bltu	s3,s2,3fd8 <fwrite+0x48>
    407a:	b7d5                	j	405e <fwrite+0xce>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    407c:	4008                	lw	a0,0(s0)
    407e:	40000613          	li	a2,1024
    4082:	85de                	mv	a1,s7
    4084:	864fc0ef          	jal	e8 <write>
        if (ret < stream->buf_write_pos)
    4088:	41042783          	lw	a5,1040(s0)
    408c:	08f54163          	blt	a0,a5,410e <fwrite+0x17e>
        stream->buf_write_pos = 0;
    4090:	40042823          	sw	zero,1040(s0)
    4094:	bfa5                	j	400c <fwrite+0x7c>
}
    4096:	60e6                	ld	ra,88(sp)
        return 0;
    4098:	4901                	li	s2,0
}
    409a:	854a                	mv	a0,s2
    409c:	6906                	ld	s2,64(sp)
    409e:	6125                	addi	sp,sp,96
    40a0:	8082                	ret
    40a2:	60e6                	ld	ra,88(sp)
        return 0;
    40a4:	4901                	li	s2,0
    40a6:	7aa2                	ld	s5,40(sp)
}
    40a8:	854a                	mv	a0,s2
    40aa:	6906                	ld	s2,64(sp)
    40ac:	6125                	addi	sp,sp,96
    40ae:	8082                	ret
        while (bytes_written < total_bytes)
    40b0:	f6090ee3          	beqz	s2,402c <fwrite+0x9c>
    40b4:	e4a6                	sd	s1,72(sp)
    uint64 bytes_written = 0;
    40b6:	4481                	li	s1,0
    40b8:	a021                	j	40c0 <fwrite+0x130>
            bytes_written += ret;
    40ba:	94aa                	add	s1,s1,a0
        while (bytes_written < total_bytes)
    40bc:	0324f463          	bgeu	s1,s2,40e4 <fwrite+0x154>
            int64 ret = write(stream->fd, src + bytes_written, total_bytes - bytes_written);
    40c0:	4008                	lw	a0,0(s0)
    40c2:	40990633          	sub	a2,s2,s1
    40c6:	009a85b3          	add	a1,s5,s1
    40ca:	81efc0ef          	jal	e8 <write>
            if (ret <= 0)
    40ce:	fea046e3          	bgtz	a0,40ba <fwrite+0x12a>
                stream->error = 1;
    40d2:	4785                	li	a5,1
        return bytes_written / size;
    40d4:	0364d933          	divu	s2,s1,s6
                stream->error = 1;
    40d8:	c41c                	sw	a5,8(s0)
                break;
    40da:	64a6                	ld	s1,72(sp)
    40dc:	6446                	ld	s0,80(sp)
    40de:	7aa2                	ld	s5,40(sp)
    40e0:	7b02                	ld	s6,32(sp)
    40e2:	b781                	j	4022 <fwrite+0x92>
        return bytes_written / size;
    40e4:	0364d933          	divu	s2,s1,s6
    40e8:	6446                	ld	s0,80(sp)
    40ea:	64a6                	ld	s1,72(sp)
    40ec:	7aa2                	ld	s5,40(sp)
    40ee:	7b02                	ld	s6,32(sp)
    40f0:	bf0d                	j	4022 <fwrite+0x92>
    40f2:	6446                	ld	s0,80(sp)
    40f4:	79e2                	ld	s3,56(sp)
    40f6:	7aa2                	ld	s5,40(sp)
    40f8:	7b02                	ld	s6,32(sp)
    40fa:	6be2                	ld	s7,24(sp)
    40fc:	6c42                	ld	s8,16(sp)
    40fe:	b715                	j	4022 <fwrite+0x92>
            stream->error = 1;
    4100:	4785                	li	a5,1
    4102:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4104:	40042823          	sw	zero,1040(s0)
    while (bytes_written < total_bytes)
    4108:	ed29e8e3          	bltu	s3,s2,3fd8 <fwrite+0x48>
    410c:	bf89                	j	405e <fwrite+0xce>
            stream->error = 1;
    410e:	4785                	li	a5,1
    4110:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4112:	40042823          	sw	zero,1040(s0)
            return EOF;
    4116:	bddd                	j	400c <fwrite+0x7c>

0000000000004118 <fseek>:
    if (!stream)
    4118:	c925                	beqz	a0,4188 <fseek+0x70>
{
    411a:	1101                	addi	sp,sp,-32
    411c:	e04a                	sd	s2,0(sp)
    411e:	8932                	mv	s2,a2
    if (stream->buf_write_pos > 0)
    4120:	41052603          	lw	a2,1040(a0)
{
    4124:	e822                	sd	s0,16(sp)
    4126:	e426                	sd	s1,8(sp)
    4128:	ec06                	sd	ra,24(sp)
    412a:	842a                	mv	s0,a0
    412c:	84ae                	mv	s1,a1
    if (stream->buf_write_pos > 0)
    412e:	02c04863          	bgtz	a2,415e <fseek+0x46>
    if (lseek(stream->fd, offset, whence) < 0)
    4132:	4008                	lw	a0,0(s0)
    stream->buf_read_pos = 0;
    4134:	40042a23          	sw	zero,1044(s0)
    stream->buf_read_cnt = 0;
    4138:	40042c23          	sw	zero,1048(s0)
    stream->eof = 0;
    413c:	00042623          	sw	zero,12(s0)
    if (lseek(stream->fd, offset, whence) < 0)
    4140:	864a                	mv	a2,s2
    4142:	0004859b          	sext.w	a1,s1
    4146:	832fc0ef          	jal	178 <lseek>
    414a:	87aa                	mv	a5,a0
    return 0;
    414c:	4501                	li	a0,0
    if (lseek(stream->fd, offset, whence) < 0)
    414e:	0207c463          	bltz	a5,4176 <fseek+0x5e>
}
    4152:	60e2                	ld	ra,24(sp)
    4154:	6442                	ld	s0,16(sp)
    4156:	64a2                	ld	s1,8(sp)
    4158:	6902                	ld	s2,0(sp)
    415a:	6105                	addi	sp,sp,32
    415c:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    415e:	4108                	lw	a0,0(a0)
    4160:	01040593          	addi	a1,s0,16
    4164:	f85fb0ef          	jal	e8 <write>
        if (ret < stream->buf_write_pos)
    4168:	41042783          	lw	a5,1040(s0)
    416c:	00f54963          	blt	a0,a5,417e <fseek+0x66>
        stream->buf_write_pos = 0;
    4170:	40042823          	sw	zero,1040(s0)
    4174:	bf7d                	j	4132 <fseek+0x1a>
        stream->error = 1;
    4176:	4785                	li	a5,1
    4178:	c41c                	sw	a5,8(s0)
        return -1;
    417a:	557d                	li	a0,-1
    417c:	bfd9                	j	4152 <fseek+0x3a>
            stream->error = 1;
    417e:	4785                	li	a5,1
    4180:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4182:	40042823          	sw	zero,1040(s0)
            return EOF;
    4186:	b775                	j	4132 <fseek+0x1a>
        return -1;
    4188:	557d                	li	a0,-1
}
    418a:	8082                	ret

000000000000418c <ftell>:
    if (!stream)
    418c:	c505                	beqz	a0,41b4 <ftell+0x28>
{
    418e:	1141                	addi	sp,sp,-16
    4190:	e022                	sd	s0,0(sp)
    4192:	842a                	mv	s0,a0
    int64 ret = lseek(stream->fd, 0, SEEK_CUR);
    4194:	4108                	lw	a0,0(a0)
    4196:	4605                	li	a2,1
    4198:	4581                	li	a1,0
{
    419a:	e406                	sd	ra,8(sp)
    int64 ret = lseek(stream->fd, 0, SEEK_CUR);
    419c:	fddfb0ef          	jal	178 <lseek>
    if (ret < 0)
    41a0:	00054663          	bltz	a0,41ac <ftell+0x20>
}
    41a4:	60a2                	ld	ra,8(sp)
    41a6:	6402                	ld	s0,0(sp)
    41a8:	0141                	addi	sp,sp,16
    41aa:	8082                	ret
        stream->error = 1;
    41ac:	4785                	li	a5,1
    41ae:	c41c                	sw	a5,8(s0)
        return -1L;
    41b0:	557d                	li	a0,-1
    41b2:	bfcd                	j	41a4 <ftell+0x18>
    41b4:	557d                	li	a0,-1
}
    41b6:	8082                	ret

00000000000041b8 <rewind>:
    if (stream)
    41b8:	c915                	beqz	a0,41ec <rewind+0x34>
    if (stream->buf_write_pos > 0)
    41ba:	41052603          	lw	a2,1040(a0)
{
    41be:	1141                	addi	sp,sp,-16
    41c0:	e022                	sd	s0,0(sp)
    41c2:	e406                	sd	ra,8(sp)
    41c4:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    41c6:	02c04463          	bgtz	a2,41ee <rewind+0x36>
    if (lseek(stream->fd, offset, whence) < 0)
    41ca:	4008                	lw	a0,0(s0)
    stream->buf_read_pos = 0;
    41cc:	40042a23          	sw	zero,1044(s0)
    stream->buf_read_cnt = 0;
    41d0:	40042c23          	sw	zero,1048(s0)
    stream->eof = 0;
    41d4:	00042623          	sw	zero,12(s0)
    if (lseek(stream->fd, offset, whence) < 0)
    41d8:	4601                	li	a2,0
    41da:	4581                	li	a1,0
    41dc:	f9dfb0ef          	jal	178 <lseek>
}
    41e0:	60a2                	ld	ra,8(sp)
        stream->error = 0;
    41e2:	00042423          	sw	zero,8(s0)
}
    41e6:	6402                	ld	s0,0(sp)
    41e8:	0141                	addi	sp,sp,16
    41ea:	8082                	ret
    41ec:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    41ee:	4108                	lw	a0,0(a0)
    41f0:	01040593          	addi	a1,s0,16
    41f4:	ef5fb0ef          	jal	e8 <write>
        if (ret < stream->buf_write_pos)
    41f8:	41042783          	lw	a5,1040(s0)
    41fc:	00f54563          	blt	a0,a5,4206 <rewind+0x4e>
        stream->buf_write_pos = 0;
    4200:	40042823          	sw	zero,1040(s0)
    4204:	b7d9                	j	41ca <rewind+0x12>
            stream->error = 1;
    4206:	4785                	li	a5,1
    4208:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    420a:	40042823          	sw	zero,1040(s0)
            return EOF;
    420e:	bf75                	j	41ca <rewind+0x12>

0000000000004210 <feof>:
    return (stream) ? stream->eof : 1;
    4210:	c119                	beqz	a0,4216 <feof+0x6>
    4212:	4548                	lw	a0,12(a0)
    4214:	8082                	ret
    4216:	4505                	li	a0,1
}
    4218:	8082                	ret

000000000000421a <ferror>:
     return (stream) ? stream->error : 1;
    421a:	c119                	beqz	a0,4220 <ferror+0x6>
    421c:	4508                	lw	a0,8(a0)
    421e:	8082                	ret
    4220:	4505                	li	a0,1
}
    4222:	8082                	ret

0000000000004224 <clearerr>:
    if (stream)
    4224:	c509                	beqz	a0,422e <clearerr+0xa>
        stream->error = 0;
    4226:	00052423          	sw	zero,8(a0)
        stream->eof = 0;
    422a:	00052623          	sw	zero,12(a0)
}
    422e:	8082                	ret

0000000000004230 <ungetc>:
    if (!stream || c == EOF)
    4230:	c19d                	beqz	a1,4256 <ungetc+0x26>
    4232:	57fd                	li	a5,-1
    4234:	02f50163          	beq	a0,a5,4256 <ungetc+0x26>
    if (stream->buf_read_pos > 0)
    4238:	4145a783          	lw	a5,1044(a1)
    423c:	00f05d63          	blez	a5,4256 <ungetc+0x26>
        stream->buf_read_pos--;
    4240:	fff7871b          	addiw	a4,a5,-1
    4244:	40e5aa23          	sw	a4,1044(a1)
        stream->buffer[stream->buf_read_pos] = (char)c;
    4248:	00e587b3          	add	a5,a1,a4
    424c:	00a78823          	sb	a0,16(a5)
        stream->eof = 0;
    4250:	0005a623          	sw	zero,12(a1)
        return c;
    4254:	8082                	ret
        return EOF;
    4256:	557d                	li	a0,-1
    4258:	8082                	ret

000000000000425a <strtoull.part.0>:
    return new_ptr;
}

/* String Conversion*/

unsigned long long strtoull(const char *nptr, char **endptr, int base)
    425a:	1141                	addi	sp,sp,-16
    425c:	e422                	sd	s0,8(sp)
    425e:	8eaa                	mv	t4,a0
{
    const char *s = nptr;
    4260:	88aa                	mv	a7,a0
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    static inline int islower(int c) { return c >= 'a' && c <= 'z'; }
    static inline int isupper(int c) { return c >= 'A' && c <= 'Z'; }
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    static inline int isalnum(int c) { return isalpha(c) || isdigit(c); }
    static inline int isspace(int c) { return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r'; }
    4262:	02000313          	li	t1,32
    4266:	4e11                	li	t3,4
        return 0;
    }

    do
    {
        c = *s++;
    4268:	0008c783          	lbu	a5,0(a7)
    426c:	00188813          	addi	a6,a7,1
    4270:	ff77871b          	addiw	a4,a5,-9
    4274:	0ff77693          	zext.b	a3,a4
    4278:	0007871b          	sext.w	a4,a5
    427c:	04678363          	beq	a5,t1,42c2 <strtoull.part.0+0x68>
    4280:	04de7163          	bgeu	t3,a3,42c2 <strtoull.part.0+0x68>
    } while (isspace(c));

    if (c == '-')
    4284:	02d00793          	li	a5,45
    4288:	0ef70863          	beq	a4,a5,4378 <strtoull.part.0+0x11e>
    {
        neg = 1;
        c = *s++;
    }
    else if (c == '+')
    428c:	02b00793          	li	a5,43
    int neg = 0, any, cutlim;
    4290:	4381                	li	t2,0
    else if (c == '+')
    4292:	08f70c63          	beq	a4,a5,432a <strtoull.part.0+0xd0>
    {
        c = *s++;
    }

    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    4296:	ea05                	bnez	a2,42c6 <strtoull.part.0+0x6c>
    4298:	03000793          	li	a5,48
    429c:	0ef70463          	beq	a4,a5,4384 <strtoull.part.0+0x12a>
    42a0:	00ccd8b7          	lui	a7,0xccd
    42a4:	ccd88893          	addi	a7,a7,-819 # cccccd <_ZSt4cerr+0xcc5465>
    42a8:	08b2                	slli	a7,a7,0xc
    42aa:	ccd88893          	addi	a7,a7,-819
    42ae:	08b2                	slli	a7,a7,0xc
    42b0:	ccd88893          	addi	a7,a7,-819
    42b4:	08b6                	slli	a7,a7,0xd
    42b6:	4415                	li	s0,5
    42b8:	99988893          	addi	a7,a7,-1639
    42bc:	42a9                	li	t0,10
        c = s[1];
        s += 2;
        base = 16;
    }
    if (base == 0)
        base = (c == '0' ? 8 : 10);
    42be:	4629                	li	a2,10
    42c0:	a829                	j	42da <strtoull.part.0+0x80>
unsigned long long strtoull(const char *nptr, char **endptr, int base)
    42c2:	88c2                	mv	a7,a6
    42c4:	b755                	j	4268 <strtoull.part.0+0xe>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    42c6:	47c1                	li	a5,16
    42c8:	0cf60d63          	beq	a2,a5,43a2 <strtoull.part.0+0x148>

    cutoff = ULLONG_MAX / (unsigned long long)base;
    42cc:	58fd                	li	a7,-1
    cutlim = ULLONG_MAX % (unsigned long long)base;
    42ce:	02c8f433          	remu	s0,a7,a2
    cutoff = ULLONG_MAX / (unsigned long long)base;
    42d2:	82b2                	mv	t0,a2
    42d4:	02c8d8b3          	divu	a7,a7,a2
    cutlim = ULLONG_MAX % (unsigned long long)base;
    42d8:	2401                	sext.w	s0,s0

    for (acc = 0, any = 0;; c = *s++)
    42da:	4301                	li	t1,0
    42dc:	4501                	li	a0,0
    {
        if (isdigit(c))
    42de:	4e25                	li	t3,9
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    42e0:	4fe5                	li	t6,25
            break;

        if (c >= base)
            break;

        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    42e2:	5f7d                	li	t5,-1
        if (isdigit(c))
    42e4:	fd07079b          	addiw	a5,a4,-48
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    42e8:	0007069b          	sext.w	a3,a4
    42ec:	00fe7e63          	bgeu	t3,a5,4308 <strtoull.part.0+0xae>
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    42f0:	f9f6879b          	addiw	a5,a3,-97
    42f4:	04fff063          	bgeu	t6,a5,4334 <strtoull.part.0+0xda>
    42f8:	fbf6869b          	addiw	a3,a3,-65
    42fc:	04dfe163          	bltu	t6,a3,433e <strtoull.part.0+0xe4>
            c -= isupper(c) ? 'A' - 10 : 'a' - 10;
    4300:	03700793          	li	a5,55
    4304:	40f707bb          	subw	a5,a4,a5
        if (c >= base)
    4308:	02c7db63          	bge	a5,a2,433e <strtoull.part.0+0xe4>
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    430c:	01e30b63          	beq	t1,t5,4322 <strtoull.part.0+0xc8>
            any = -1;
    4310:	537d                	li	t1,-1
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    4312:	00a8e863          	bltu	a7,a0,4322 <strtoull.part.0+0xc8>
    4316:	05150e63          	beq	a0,a7,4372 <strtoull.part.0+0x118>
        else
        {
            any = 1;
    431a:	4305                	li	t1,1
            acc *= base;
    431c:	02550533          	mul	a0,a0,t0
            acc += c;
    4320:	953e                	add	a0,a0,a5
    for (acc = 0, any = 0;; c = *s++)
    4322:	0805                	addi	a6,a6,1
    4324:	fff84703          	lbu	a4,-1(a6)
        if (isdigit(c))
    4328:	bf75                	j	42e4 <strtoull.part.0+0x8a>
        c = *s++;
    432a:	00084703          	lbu	a4,0(a6)
    432e:	00288813          	addi	a6,a7,2
    4332:	b795                	j	4296 <strtoull.part.0+0x3c>
            c -= isupper(c) ? 'A' - 10 : 'a' - 10;
    4334:	05700793          	li	a5,87
    4338:	40f707bb          	subw	a5,a4,a5
    433c:	b7f1                	j	4308 <strtoull.part.0+0xae>
        }
    }

    if (any < 0)
    433e:	57fd                	li	a5,-1
    4340:	00f30e63          	beq	t1,a5,435c <strtoull.part.0+0x102>
    {
        acc = ULLONG_MAX;
        errno = ERANGE;
    }
    else if (neg)
    4344:	00038463          	beqz	t2,434c <strtoull.part.0+0xf2>
        acc = -acc;
    4348:	40a00533          	neg	a0,a0

    if (endptr != 0)
    434c:	c589                	beqz	a1,4356 <strtoull.part.0+0xfc>
        *endptr = (char *)(any ? s - 1 : nptr);
    434e:	00031f63          	bnez	t1,436c <strtoull.part.0+0x112>
    4352:	01d5b023          	sd	t4,0(a1)

    return acc;
}
    4356:	6422                	ld	s0,8(sp)
    4358:	0141                	addi	sp,sp,16
    435a:	8082                	ret
        errno = ERANGE;
    435c:	02200793          	li	a5,34
    4360:	00003717          	auipc	a4,0x3
    4364:	3cf72823          	sw	a5,976(a4) # 7730 <errno>
        acc = ULLONG_MAX;
    4368:	557d                	li	a0,-1
    if (endptr != 0)
    436a:	d5f5                	beqz	a1,4356 <strtoull.part.0+0xfc>
        *endptr = (char *)(any ? s - 1 : nptr);
    436c:	fff80e93          	addi	t4,a6,-1
    4370:	b7cd                	j	4352 <strtoull.part.0+0xf8>
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    4372:	faf448e3          	blt	s0,a5,4322 <strtoull.part.0+0xc8>
    4376:	b755                	j	431a <strtoull.part.0+0xc0>
        c = *s++;
    4378:	00084703          	lbu	a4,0(a6)
        neg = 1;
    437c:	4385                	li	t2,1
        c = *s++;
    437e:	00288813          	addi	a6,a7,2
    4382:	bf11                	j	4296 <strtoull.part.0+0x3c>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    4384:	00084783          	lbu	a5,0(a6)
    4388:	05800693          	li	a3,88
    438c:	0df7f793          	andi	a5,a5,223
    4390:	02d78b63          	beq	a5,a3,43c6 <strtoull.part.0+0x16c>
    4394:	58fd                	li	a7,-1
    4396:	441d                	li	s0,7
    4398:	0038d893          	srli	a7,a7,0x3
    439c:	42a1                	li	t0,8
        base = (c == '0' ? 8 : 10);
    439e:	4621                	li	a2,8
    43a0:	bf2d                	j	42da <strtoull.part.0+0x80>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    43a2:	03000793          	li	a5,48
    43a6:	00f70863          	beq	a4,a5,43b6 <strtoull.part.0+0x15c>
    43aa:	58fd                	li	a7,-1
    43ac:	443d                	li	s0,15
    43ae:	0048d893          	srli	a7,a7,0x4
    43b2:	42c1                	li	t0,16
    43b4:	b71d                	j	42da <strtoull.part.0+0x80>
    43b6:	00084783          	lbu	a5,0(a6)
    43ba:	05800693          	li	a3,88
    43be:	0df7f793          	andi	a5,a5,223
    43c2:	fed794e3          	bne	a5,a3,43aa <strtoull.part.0+0x150>
        s += 2;
    43c6:	58fd                	li	a7,-1
        c = s[1];
    43c8:	00184703          	lbu	a4,1(a6)
        s += 2;
    43cc:	443d                	li	s0,15
    43ce:	0809                	addi	a6,a6,2
    43d0:	0048d893          	srli	a7,a7,0x4
    43d4:	42c1                	li	t0,16
        base = 16;
    43d6:	4641                	li	a2,16
    43d8:	b709                	j	42da <strtoull.part.0+0x80>

00000000000043da <atexit>:
    if (__atexit_func_count >= ATEXIT_MAX)
    43da:	00003717          	auipc	a4,0x3
    43de:	35670713          	addi	a4,a4,854 # 7730 <errno>
    43e2:	435c                	lw	a5,4(a4)
    43e4:	46fd                	li	a3,31
    43e6:	00f6ca63          	blt	a3,a5,43fa <atexit+0x20>
    __atexit_funcs[__atexit_func_count++] = function;
    43ea:	00379693          	slli	a3,a5,0x3
    43ee:	96ba                	add	a3,a3,a4
    43f0:	2785                	addiw	a5,a5,1
    43f2:	e688                	sd	a0,8(a3)
    43f4:	c35c                	sw	a5,4(a4)
    return 0;
    43f6:	4501                	li	a0,0
    43f8:	8082                	ret
        return -1;
    43fa:	557d                	li	a0,-1
}
    43fc:	8082                	ret

00000000000043fe <exit>:
{
    43fe:	1101                	addi	sp,sp,-32
    4400:	e822                	sd	s0,16(sp)
    while (__atexit_func_count > 0)
    4402:	00003417          	auipc	s0,0x3
    4406:	32e40413          	addi	s0,s0,814 # 7730 <errno>
    440a:	405c                	lw	a5,4(s0)
{
    440c:	e426                	sd	s1,8(sp)
    440e:	ec06                	sd	ra,24(sp)
    4410:	84aa                	mv	s1,a0
    while (__atexit_func_count > 0)
    4412:	00f05d63          	blez	a5,442c <exit+0x2e>
        (__atexit_funcs[--__atexit_func_count])();
    4416:	fff7871b          	addiw	a4,a5,-1
    441a:	87ba                	mv	a5,a4
    441c:	070e                	slli	a4,a4,0x3
    441e:	9722                	add	a4,a4,s0
    4420:	6718                	ld	a4,8(a4)
    4422:	c05c                	sw	a5,4(s0)
    4424:	9702                	jalr	a4
    while (__atexit_func_count > 0)
    4426:	405c                	lw	a5,4(s0)
    4428:	fef047e3          	bgtz	a5,4416 <exit+0x18>
    sys_exit(status);
    442c:	8526                	mv	a0,s1
    442e:	c93fb0ef          	jal	c0 <sys_exit>
    while (1)
    4432:	a001                	j	4432 <exit+0x34>

0000000000004434 <abort>:
{
    4434:	1141                	addi	sp,sp,-16
    exit(127);
    4436:	07f00513          	li	a0,127
{
    443a:	e406                	sd	ra,8(sp)
    exit(127);
    443c:	fc3ff0ef          	jal	43fe <exit>

0000000000004440 <getenv>:
}
    4440:	4501                	li	a0,0
    4442:	8082                	ret

0000000000004444 <system>:
}
    4444:	557d                	li	a0,-1
    4446:	8082                	ret

0000000000004448 <free>:
    if (!ptr)
    4448:	c121                	beqz	a0,4488 <free+0x40>
    for (p = freep; !(bp > p && bp < p->next); p = p->next)
    444a:	00003617          	auipc	a2,0x3
    444e:	2e660613          	addi	a2,a2,742 # 7730 <errno>
    4452:	10863783          	ld	a5,264(a2)
    bp = (header_t *)ptr - 1;
    4456:	ff050693          	addi	a3,a0,-16
        if (p >= p->next && (bp > p || bp < p->next))
    445a:	6798                	ld	a4,8(a5)
    for (p = freep; !(bp > p && bp < p->next); p = p->next)
    445c:	02d7f763          	bgeu	a5,a3,448a <free+0x42>
    4460:	00e6e463          	bltu	a3,a4,4468 <free+0x20>
        if (p >= p->next && (bp > p || bp < p->next))
    4464:	02e7e763          	bltu	a5,a4,4492 <free+0x4a>
    if ((char *)bp + bp->size == (char *)p->next)
    4468:	ff053583          	ld	a1,-16(a0)
    446c:	00b68833          	add	a6,a3,a1
    4470:	03070363          	beq	a4,a6,4496 <free+0x4e>
    if ((char *)p + p->size == (char *)bp)
    4474:	638c                	ld	a1,0(a5)
    4476:	fee53c23          	sd	a4,-8(a0)
    447a:	00b78833          	add	a6,a5,a1
    447e:	03068963          	beq	a3,a6,44b0 <free+0x68>
    4482:	e794                	sd	a3,8(a5)
    freep = p;
    4484:	10f63423          	sd	a5,264(a2)
}
    4488:	8082                	ret
        if (p >= p->next && (bp > p || bp < p->next))
    448a:	00e7e463          	bltu	a5,a4,4492 <free+0x4a>
    448e:	fce6ede3          	bltu	a3,a4,4468 <free+0x20>
{
    4492:	87ba                	mv	a5,a4
    4494:	b7d9                	j	445a <free+0x12>
        bp->size += p->next->size;
    4496:	00073803          	ld	a6,0(a4)
        bp->next = p->next->next;
    449a:	6718                	ld	a4,8(a4)
        bp->size += p->next->size;
    449c:	95c2                	add	a1,a1,a6
    449e:	feb53823          	sd	a1,-16(a0)
    if ((char *)p + p->size == (char *)bp)
    44a2:	638c                	ld	a1,0(a5)
    44a4:	fee53c23          	sd	a4,-8(a0)
    44a8:	00b78833          	add	a6,a5,a1
    44ac:	fd069be3          	bne	a3,a6,4482 <free+0x3a>
        p->size += bp->size;
    44b0:	ff053503          	ld	a0,-16(a0)
        p->next = bp->next;
    44b4:	86ba                	mv	a3,a4
        p->size += bp->size;
    44b6:	00b50733          	add	a4,a0,a1
    44ba:	e398                	sd	a4,0(a5)
        p->next = bp->next;
    44bc:	b7d9                	j	4482 <free+0x3a>

00000000000044be <malloc>:
    if (size == 0)
    44be:	c169                	beqz	a0,4580 <malloc+0xc2>
{
    44c0:	7179                	addi	sp,sp,-48
    44c2:	ec26                	sd	s1,24(sp)
    if ((prevp = freep) == NULL)
    44c4:	00003497          	auipc	s1,0x3
    44c8:	26c48493          	addi	s1,s1,620 # 7730 <errno>
    44cc:	1084b783          	ld	a5,264(s1)
{
    44d0:	f022                	sd	s0,32(sp)
    size = ALIGN(size + sizeof(header_t));
    44d2:	057d                	addi	a0,a0,31
{
    44d4:	f406                	sd	ra,40(sp)
    size = ALIGN(size + sizeof(header_t));
    44d6:	ff057413          	andi	s0,a0,-16
    if ((prevp = freep) == NULL)
    44da:	c3d1                	beqz	a5,455e <malloc+0xa0>
    for (p = prevp->next;; prevp = p, p = p->next)
    44dc:	6788                	ld	a0,8(a5)
        if (p->size >= size)
    44de:	6118                	ld	a4,0(a0)
    44e0:	06877163          	bgeu	a4,s0,4542 <malloc+0x84>
    44e4:	e44e                	sd	s3,8(sp)
    44e6:	e052                	sd	s4,0(sp)
    44e8:	e84a                	sd	s2,16(sp)
    if (nu < 4096)
    44ea:	6a05                	lui	s4,0x1
    if (cp == (void *)-1)
    44ec:	59fd                	li	s3,-1
    44ee:	a029                	j	44f8 <malloc+0x3a>
    for (p = prevp->next;; prevp = p, p = p->next)
    44f0:	6788                	ld	a0,8(a5)
        if (p->size >= size)
    44f2:	6118                	ld	a4,0(a0)
    44f4:	04877463          	bgeu	a4,s0,453c <malloc+0x7e>
        if (p == freep)
    44f8:	1084b703          	ld	a4,264(s1)
    44fc:	87aa                	mv	a5,a0
    44fe:	fee519e3          	bne	a0,a4,44f0 <malloc+0x32>
    if (nu < 4096)
    4502:	8922                	mv	s2,s0
    4504:	01447363          	bgeu	s0,s4,450a <malloc+0x4c>
    4508:	6905                	lui	s2,0x1
    cp = (char *)sbrk(nu);
    450a:	854a                	mv	a0,s2
    450c:	c45fb0ef          	jal	150 <sbrk>
    4510:	87aa                	mv	a5,a0
    free((void *)(up + 1));
    4512:	0541                	addi	a0,a0,16
    if (cp == (void *)-1)
    4514:	01378963          	beq	a5,s3,4526 <malloc+0x68>
    up->size = nu;
    4518:	0127b023          	sd	s2,0(a5)
    free((void *)(up + 1));
    451c:	f2dff0ef          	jal	4448 <free>
    return freep;
    4520:	1084b783          	ld	a5,264(s1)
            if ((p = morecore(size)) == NULL)
    4524:	f7f1                	bnez	a5,44f0 <malloc+0x32>
}
    4526:	70a2                	ld	ra,40(sp)
    4528:	7402                	ld	s0,32(sp)
                errno = ENOMEM;
    452a:	47b1                	li	a5,12
    452c:	c09c                	sw	a5,0(s1)
                return NULL;
    452e:	6942                	ld	s2,16(sp)
    4530:	69a2                	ld	s3,8(sp)
    4532:	6a02                	ld	s4,0(sp)
}
    4534:	64e2                	ld	s1,24(sp)
        return NULL;
    4536:	4501                	li	a0,0
}
    4538:	6145                	addi	sp,sp,48
    453a:	8082                	ret
    453c:	6942                	ld	s2,16(sp)
    453e:	69a2                	ld	s3,8(sp)
    4540:	6a02                	ld	s4,0(sp)
            if (p->size == size)
    4542:	02e40c63          	beq	s0,a4,457a <malloc+0xbc>
                p->size -= size;
    4546:	8f01                	sub	a4,a4,s0
    4548:	e118                	sd	a4,0(a0)
                p = (header_t *)((char *)p + p->size);
    454a:	953a                	add	a0,a0,a4
                p->size = size;
    454c:	e100                	sd	s0,0(a0)
}
    454e:	70a2                	ld	ra,40(sp)
    4550:	7402                	ld	s0,32(sp)
            freep = prevp;
    4552:	10f4b423          	sd	a5,264(s1)
            return (void *)(p + 1);
    4556:	0541                	addi	a0,a0,16
}
    4558:	64e2                	ld	s1,24(sp)
    455a:	6145                	addi	sp,sp,48
    455c:	8082                	ret
        base.next = freep = prevp = &base;
    455e:	00003517          	auipc	a0,0x3
    4562:	2e250513          	addi	a0,a0,738 # 7840 <base>
    4566:	10a4b423          	sd	a0,264(s1)
    456a:	10a4bc23          	sd	a0,280(s1)
        base.size = 0;
    456e:	00003797          	auipc	a5,0x3
    4572:	2c07b923          	sd	zero,722(a5) # 7840 <base>
        if (p->size >= size)
    4576:	f43d                	bnez	s0,44e4 <malloc+0x26>
        base.next = freep = prevp = &base;
    4578:	87aa                	mv	a5,a0
                prevp->next = p->next;
    457a:	6518                	ld	a4,8(a0)
    457c:	e798                	sd	a4,8(a5)
    457e:	bfc1                	j	454e <malloc+0x90>
        return NULL;
    4580:	4501                	li	a0,0
}
    4582:	8082                	ret

0000000000004584 <calloc>:
    if (__builtin_mul_overflow(nmemb, size, &total))
    4584:	02b537b3          	mulhu	a5,a0,a1
{
    4588:	1101                	addi	sp,sp,-32
    458a:	e822                	sd	s0,16(sp)
    458c:	ec06                	sd	ra,24(sp)
    458e:	e426                	sd	s1,8(sp)
    if (__builtin_mul_overflow(nmemb, size, &total))
    4590:	02b50433          	mul	s0,a0,a1
    4594:	e385                	bnez	a5,45b4 <calloc+0x30>
    void *p = malloc(total);
    4596:	8522                	mv	a0,s0
    4598:	f27ff0ef          	jal	44be <malloc>
    459c:	84aa                	mv	s1,a0
    if (p)
    459e:	c509                	beqz	a0,45a8 <calloc+0x24>
        memset(p, 0, total);
    45a0:	8622                	mv	a2,s0
    45a2:	4581                	li	a1,0
    45a4:	524000ef          	jal	4ac8 <memset>
}
    45a8:	60e2                	ld	ra,24(sp)
    45aa:	6442                	ld	s0,16(sp)
    45ac:	8526                	mv	a0,s1
    45ae:	64a2                	ld	s1,8(sp)
    45b0:	6105                	addi	sp,sp,32
    45b2:	8082                	ret
    45b4:	60e2                	ld	ra,24(sp)
    45b6:	6442                	ld	s0,16(sp)
        errno = ENOMEM;
    45b8:	47b1                	li	a5,12
        return NULL;
    45ba:	4481                	li	s1,0
        errno = ENOMEM;
    45bc:	00003717          	auipc	a4,0x3
    45c0:	16f72a23          	sw	a5,372(a4) # 7730 <errno>
}
    45c4:	8526                	mv	a0,s1
    45c6:	64a2                	ld	s1,8(sp)
    45c8:	6105                	addi	sp,sp,32
    45ca:	8082                	ret

00000000000045cc <realloc>:
    if (!ptr)
    45cc:	c929                	beqz	a0,461e <realloc+0x52>
{
    45ce:	1101                	addi	sp,sp,-32
    45d0:	ec06                	sd	ra,24(sp)
    45d2:	e426                	sd	s1,8(sp)
    if (size == 0)
    45d4:	c5b9                	beqz	a1,4622 <realloc+0x56>
    if (bp->size >= new_size)
    45d6:	ff053703          	ld	a4,-16(a0)
    size_t new_size = ALIGN(size + sizeof(header_t));
    45da:	01f58793          	addi	a5,a1,31
    45de:	e822                	sd	s0,16(sp)
    45e0:	9bc1                	andi	a5,a5,-16
    45e2:	842a                	mv	s0,a0
        return ptr;
    45e4:	84aa                	mv	s1,a0
    if (bp->size >= new_size)
    45e6:	00f76863          	bltu	a4,a5,45f6 <realloc+0x2a>
    45ea:	6442                	ld	s0,16(sp)
}
    45ec:	60e2                	ld	ra,24(sp)
    45ee:	8526                	mv	a0,s1
    45f0:	64a2                	ld	s1,8(sp)
    45f2:	6105                	addi	sp,sp,32
    45f4:	8082                	ret
    void *new_ptr = malloc(size);
    45f6:	852e                	mv	a0,a1
    45f8:	ec7ff0ef          	jal	44be <malloc>
    45fc:	84aa                	mv	s1,a0
    if (!new_ptr)
    45fe:	d575                	beqz	a0,45ea <realloc+0x1e>
    memcpy(new_ptr, ptr, bp->size - sizeof(header_t));
    4600:	ff043603          	ld	a2,-16(s0)
    4604:	85a2                	mv	a1,s0
    4606:	1641                	addi	a2,a2,-16
    4608:	514000ef          	jal	4b1c <memcpy>
    free(ptr);
    460c:	8522                	mv	a0,s0
    460e:	e3bff0ef          	jal	4448 <free>
}
    4612:	60e2                	ld	ra,24(sp)
    free(ptr);
    4614:	6442                	ld	s0,16(sp)
}
    4616:	8526                	mv	a0,s1
    4618:	64a2                	ld	s1,8(sp)
    461a:	6105                	addi	sp,sp,32
    461c:	8082                	ret
        return malloc(size);
    461e:	852e                	mv	a0,a1
    4620:	bd79                	j	44be <malloc>
        free(ptr);
    4622:	e27ff0ef          	jal	4448 <free>
        return NULL;
    4626:	4481                	li	s1,0
    4628:	b7d1                	j	45ec <realloc+0x20>

000000000000462a <strtoull>:
    if (base < 0 || base == 1 || base > 36)
    462a:	02400813          	li	a6,36
{
    462e:	86aa                	mv	a3,a0
    4630:	872e                	mv	a4,a1
    if (base < 0 || base == 1 || base > 36)
    4632:	00c86663          	bltu	a6,a2,463e <strtoull+0x14>
    4636:	4805                	li	a6,1
    4638:	01060363          	beq	a2,a6,463e <strtoull+0x14>
    463c:	b939                	j	425a <strtoull.part.0>
        if (endptr)
    463e:	c311                	beqz	a4,4642 <strtoull+0x18>
            *endptr = (char *)nptr;
    4640:	e314                	sd	a3,0(a4)
        errno = 0; /* EINVAL */
    4642:	00003797          	auipc	a5,0x3
    4646:	0e07a723          	sw	zero,238(a5) # 7730 <errno>
}
    464a:	4501                	li	a0,0
    464c:	8082                	ret

000000000000464e <strtoll>:

long long strtoll(const char *nptr, char **endptr, int base)
{
    464e:	1141                	addi	sp,sp,-16
    4650:	e406                	sd	ra,8(sp)
    4652:	e022                	sd	s0,0(sp)
    const char *s = nptr;
    4654:	86aa                	mv	a3,a0
    static inline int isspace(int c) { return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r'; }
    4656:	02000813          	li	a6,32
    465a:	4891                	li	a7,4
    unsigned long long acc;
    int c, neg = 0;

    do
    {
        c = *s++;
    465c:	0006c783          	lbu	a5,0(a3)
    4660:	0685                	addi	a3,a3,1
    4662:	ff77871b          	addiw	a4,a5,-9
    4666:	0ff77713          	zext.b	a4,a4
    466a:	0007841b          	sext.w	s0,a5
    466e:	ff0787e3          	beq	a5,a6,465c <strtoll+0xe>
    4672:	fee8f5e3          	bgeu	a7,a4,465c <strtoll+0xe>
    if (base < 0 || base == 1 || base > 36)
    4676:	02400793          	li	a5,36
    467a:	02c7ec63          	bltu	a5,a2,46b2 <strtoll+0x64>
    467e:	4785                	li	a5,1
    4680:	02f60963          	beq	a2,a5,46b2 <strtoll+0x64>
    4684:	bd7ff0ef          	jal	425a <strtoull.part.0>
    if (c == '-')
        neg = 1;

    acc = strtoull(nptr, endptr, base);

    if (errno == ERANGE && acc == ULLONG_MAX)
    4688:	00003797          	auipc	a5,0x3
    468c:	0a878793          	addi	a5,a5,168 # 7730 <errno>
    4690:	4394                	lw	a3,0(a5)
    4692:	02200713          	li	a4,34
    4696:	04e68363          	beq	a3,a4,46dc <strtoll+0x8e>
        return neg ? LLONG_MIN : LLONG_MAX;

    if (!neg && acc > (unsigned long long)LLONG_MAX)
    469a:	02d00713          	li	a4,45
    469e:	02e40563          	beq	s0,a4,46c8 <strtoll+0x7a>
    46a2:	00055f63          	bgez	a0,46c0 <strtoll+0x72>
    {
        errno = ERANGE;
    46a6:	02200713          	li	a4,34
    46aa:	c398                	sw	a4,0(a5)
        return neg ? LLONG_MIN : LLONG_MAX;
    46ac:	557d                	li	a0,-1
    46ae:	8105                	srli	a0,a0,0x1
    46b0:	a801                	j	46c0 <strtoll+0x72>
        if (endptr)
    46b2:	c191                	beqz	a1,46b6 <strtoll+0x68>
            *endptr = (char *)nptr;
    46b4:	e188                	sd	a0,0(a1)
        errno = 0; /* EINVAL */
    46b6:	00003797          	auipc	a5,0x3
    46ba:	0607ad23          	sw	zero,122(a5) # 7730 <errno>
    {
        errno = ERANGE;
        return LLONG_MIN;
    }

    return neg ? -(long long)acc : (long long)acc;
    46be:	4501                	li	a0,0
}
    46c0:	60a2                	ld	ra,8(sp)
    46c2:	6402                	ld	s0,0(sp)
    46c4:	0141                	addi	sp,sp,16
    46c6:	8082                	ret
    if (neg && acc > (unsigned long long)LLONG_MAX + 1)
    46c8:	577d                	li	a4,-1
    46ca:	177e                	slli	a4,a4,0x3f
    46cc:	02a76263          	bltu	a4,a0,46f0 <strtoll+0xa2>
}
    46d0:	60a2                	ld	ra,8(sp)
    46d2:	6402                	ld	s0,0(sp)
    return neg ? -(long long)acc : (long long)acc;
    46d4:	40a00533          	neg	a0,a0
}
    46d8:	0141                	addi	sp,sp,16
    46da:	8082                	ret
    if (errno == ERANGE && acc == ULLONG_MAX)
    46dc:	577d                	li	a4,-1
    46de:	fae51ee3          	bne	a0,a4,469a <strtoll+0x4c>
        return neg ? LLONG_MIN : LLONG_MAX;
    46e2:	02d00793          	li	a5,45
    46e6:	fcf413e3          	bne	s0,a5,46ac <strtoll+0x5e>
        return LLONG_MIN;
    46ea:	557d                	li	a0,-1
    46ec:	157e                	slli	a0,a0,0x3f
    46ee:	bfc9                	j	46c0 <strtoll+0x72>
        errno = ERANGE;
    46f0:	02200713          	li	a4,34
    46f4:	c398                	sw	a4,0(a5)
        return LLONG_MIN;
    46f6:	bfd5                	j	46ea <strtoll+0x9c>

00000000000046f8 <strtoul>:
    if (base < 0 || base == 1 || base > 36)
    46f8:	02400813          	li	a6,36

unsigned long strtoul(const char *nptr, char **endptr, int base)
{
    46fc:	86aa                	mv	a3,a0
    46fe:	872e                	mv	a4,a1
    if (base < 0 || base == 1 || base > 36)
    4700:	00c86663          	bltu	a6,a2,470c <strtoul+0x14>
    4704:	4805                	li	a6,1
    4706:	01060363          	beq	a2,a6,470c <strtoul+0x14>
    470a:	be81                	j	425a <strtoull.part.0>
        if (endptr)
    470c:	c311                	beqz	a4,4710 <strtoul+0x18>
            *endptr = (char *)nptr;
    470e:	e314                	sd	a3,0(a4)
        errno = 0; /* EINVAL */
    4710:	00003797          	auipc	a5,0x3
    4714:	0207a023          	sw	zero,32(a5) # 7730 <errno>
    {
        errno = ERANGE;
        return ULONG_MAX;
    }
    return (unsigned long)ret;
}
    4718:	4501                	li	a0,0
    471a:	8082                	ret

000000000000471c <strtol>:

long strtol(const char *nptr, char **endptr, int base)
{
    long long ret = strtoll(nptr, endptr, base);
    471c:	bf0d                	j	464e <strtoll>

000000000000471e <atoi>:
        return LONG_MIN;
    }
    return (long)ret;
}

int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    471e:	1141                	addi	sp,sp,-16
    long long ret = strtoll(nptr, endptr, base);
    4720:	4629                	li	a2,10
    4722:	4581                	li	a1,0
int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    4724:	e406                	sd	ra,8(sp)
    long long ret = strtoll(nptr, endptr, base);
    4726:	f29ff0ef          	jal	464e <strtoll>
int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    472a:	60a2                	ld	ra,8(sp)
    472c:	2501                	sext.w	a0,a0
    472e:	0141                	addi	sp,sp,16
    4730:	8082                	ret

0000000000004732 <atol>:
    long long ret = strtoll(nptr, endptr, base);
    4732:	4629                	li	a2,10
    4734:	4581                	li	a1,0
    4736:	bf21                	j	464e <strtoll>

0000000000004738 <atoll>:
long atol(const char *nptr) { return strtol(nptr, NULL, 10); }
long long atoll(const char *nptr) { return strtoll(nptr, NULL, 10); }
    4738:	4629                	li	a2,10
    473a:	4581                	li	a1,0
    473c:	bf09                	j	464e <strtoll>

000000000000473e <strtod>:
    473e:	02000693          	li	a3,32
    4742:	4611                	li	a2,4
{
    double val = 0.0;
    int sign = 1;
    const char *s = nptr;

    while (isspace(*s))
    4744:	00054783          	lbu	a5,0(a0)
    4748:	ff77871b          	addiw	a4,a5,-9
    474c:	0ff77713          	zext.b	a4,a4
    4750:	06d78263          	beq	a5,a3,47b4 <strtod+0x76>
    4754:	06e67063          	bgeu	a2,a4,47b4 <strtod+0x76>
        s++;
    if (*s == '-')
    4758:	02d00713          	li	a4,45
    475c:	08e78e63          	beq	a5,a4,47f8 <strtod+0xba>
    {
        sign = -1;
        s++;
    }
    else if (*s == '+')
    4760:	02b00713          	li	a4,43
    4764:	0ae78263          	beq	a5,a4,4808 <strtod+0xca>
    4768:	00001717          	auipc	a4,0x1
    476c:	0e073507          	fld	fa0,224(a4) # 5848 <STDIN_FD+0x10>
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    4770:	fd07861b          	addiw	a2,a5,-48
        s++;

    while (isdigit(*s))
    4774:	46a5                	li	a3,9
    4776:	f20007d3          	fmv.d.x	fa5,zero
    477a:	8732                	mv	a4,a2
    477c:	02c6e363          	bltu	a3,a2,47a2 <strtod+0x64>
    4780:	00001797          	auipc	a5,0x1
    4784:	0d07b687          	fld	fa3,208(a5) # 5850 <STDIN_FD+0x18>
    4788:	4625                	li	a2,9
    478a:	00154783          	lbu	a5,1(a0)
    {
        val = val * 10.0 + (*s - '0');
    478e:	d2070753          	fcvt.d.w	fa4,a4
        s++;
    4792:	0505                	addi	a0,a0,1
    4794:	fd07869b          	addiw	a3,a5,-48
        val = val * 10.0 + (*s - '0');
    4798:	72d7f7c3          	fmadd.d	fa5,fa5,fa3,fa4
    479c:	8736                	mv	a4,a3
    while (isdigit(*s))
    479e:	fed676e3          	bgeu	a2,a3,478a <strtod+0x4c>
    }
    if (*s == '.')
    47a2:	02e00713          	li	a4,46
    47a6:	00e78963          	beq	a5,a4,47b8 <strtod+0x7a>
            val += (*s - '0') * factor;
            s++;
        }
    }

    if (endptr)
    47aa:	c191                	beqz	a1,47ae <strtod+0x70>
        *endptr = (char *)s;
    47ac:	e188                	sd	a0,0(a1)
    return val * sign;
}
    47ae:	12a7f553          	fmul.d	fa0,fa5,fa0
    47b2:	8082                	ret
        s++;
    47b4:	0505                	addi	a0,a0,1
    47b6:	b779                	j	4744 <strtod+0x6>
        while (isdigit(*s))
    47b8:	00154703          	lbu	a4,1(a0)
    47bc:	46a5                	li	a3,9
        s++;
    47be:	0505                	addi	a0,a0,1
    47c0:	fd07071b          	addiw	a4,a4,-48
    47c4:	87ba                	mv	a5,a4
        while (isdigit(*s))
    47c6:	fee6e2e3          	bltu	a3,a4,47aa <strtod+0x6c>
        double factor = 1.0;
    47ca:	00001717          	auipc	a4,0x1
    47ce:	07e73707          	fld	fa4,126(a4) # 5848 <STDIN_FD+0x10>
    47d2:	00001717          	auipc	a4,0x1
    47d6:	09673607          	fld	fa2,150(a4) # 5868 <STDIN_FD+0x30>
            factor *= 0.1;
    47da:	12c77753          	fmul.d	fa4,fa4,fa2
        while (isdigit(*s))
    47de:	00154703          	lbu	a4,1(a0)
            val += (*s - '0') * factor;
    47e2:	d20786d3          	fcvt.d.w	fa3,a5
            s++;
    47e6:	0505                	addi	a0,a0,1
    47e8:	fd07071b          	addiw	a4,a4,-48
    47ec:	87ba                	mv	a5,a4
            val += (*s - '0') * factor;
    47ee:	7ae6f7c3          	fmadd.d	fa5,fa3,fa4,fa5
        while (isdigit(*s))
    47f2:	fee6f4e3          	bgeu	a3,a4,47da <strtod+0x9c>
    47f6:	bf55                	j	47aa <strtod+0x6c>
    while (isdigit(*s))
    47f8:	00154783          	lbu	a5,1(a0)
    47fc:	00001717          	auipc	a4,0x1
    4800:	04473507          	fld	fa0,68(a4) # 5840 <STDIN_FD+0x8>
        s++;
    4804:	0505                	addi	a0,a0,1
    4806:	b7ad                	j	4770 <strtod+0x32>
    while (isdigit(*s))
    4808:	00154783          	lbu	a5,1(a0)
    480c:	00001717          	auipc	a4,0x1
    4810:	03c73507          	fld	fa0,60(a4) # 5848 <STDIN_FD+0x10>
        s++;
    4814:	0505                	addi	a0,a0,1
    4816:	bfa9                	j	4770 <strtod+0x32>

0000000000004818 <atof>:

double atof(const char *nptr) { return strtod(nptr, NULL); }
    4818:	4581                	li	a1,0
    481a:	b715                	j	473e <strtod>

000000000000481c <strtof>:
float strtof(const char *nptr, char **endptr) { return (float)strtod(nptr, endptr); }
    481c:	1141                	addi	sp,sp,-16
    481e:	e406                	sd	ra,8(sp)
    4820:	f1fff0ef          	jal	473e <strtod>
    4824:	60a2                	ld	ra,8(sp)
    4826:	40157553          	fcvt.s.d	fa0,fa0
    482a:	0141                	addi	sp,sp,16
    482c:	8082                	ret

000000000000482e <qsort>:
    }
}

void qsort(void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *))
{
    if (nmemb < 2 || size == 0)
    482e:	4785                	li	a5,1
    4830:	0cb7fd63          	bgeu	a5,a1,490a <qsort+0xdc>
{
    4834:	715d                	addi	sp,sp,-80
    4836:	f44e                	sd	s3,40(sp)
    4838:	e486                	sd	ra,72(sp)
    483a:	89b2                	mv	s3,a2
    if (nmemb < 2 || size == 0)
    483c:	c279                	beqz	a2,4902 <qsort+0xd4>
    483e:	e85a                	sd	s6,16(sp)
    4840:	8b2e                	mv	s6,a1
        return;

    char *base_ptr = (char *)base;
    char *pivot = base_ptr + (nmemb - 1) * size;
    4842:	1b7d                	addi	s6,s6,-1
    4844:	fc26                	sd	s1,56(sp)
    4846:	033b04b3          	mul	s1,s6,s3
    484a:	ec56                	sd	s5,24(sp)
    484c:	8aaa                	mv	s5,a0
    484e:	f052                	sd	s4,32(sp)
    4850:	e45e                	sd	s7,8(sp)
    4852:	e0a2                	sd	s0,64(sp)
    4854:	f84a                	sd	s2,48(sp)
    4856:	8a36                	mv	s4,a3
    if (nmemb < 2 || size == 0)
    4858:	4b85                	li	s7,1
    char *pivot = base_ptr + (nmemb - 1) * size;
    485a:	94d6                	add	s1,s1,s5
    char *i = base_ptr;
    char *j = base_ptr;

    /* Partition */
    for (; j < pivot; j += size)
    485c:	069af763          	bgeu	s5,s1,48ca <qsort+0x9c>
    char *j = base_ptr;
    4860:	8956                	mv	s2,s5
    char *i = base_ptr;
    4862:	8456                	mv	s0,s5
    4864:	a021                	j	486c <qsort+0x3e>
    for (; j < pivot; j += size)
    4866:	994e                	add	s2,s2,s3
    4868:	00997f63          	bgeu	s2,s1,4886 <qsort+0x58>
    {
        if (compar(j, pivot) < 0)
    486c:	85a6                	mv	a1,s1
    486e:	854a                	mv	a0,s2
    4870:	9a02                	jalr	s4
    4872:	fe055ae3          	bgez	a0,4866 <qsort+0x38>
        {
            if (i != j)
    4876:	05241d63          	bne	s0,s2,48d0 <qsort+0xa2>
    487a:	01390633          	add	a2,s2,s3
                swap_bytes(i, j, size);
            i += size;
    487e:	8432                	mv	s0,a2
    for (; j < pivot; j += size)
    4880:	994e                	add	s2,s2,s3
    4882:	fe9965e3          	bltu	s2,s1,486c <qsort+0x3e>
        }
    }
    swap_bytes(i, pivot, size);

    /* Recurse */
    size_t left_count = (i - base_ptr) / size;
    4886:	415405b3          	sub	a1,s0,s5
    488a:	0335d5b3          	divu	a1,a1,s3
    qsort(base, left_count, size, compar);
    qsort(i + size, nmemb - left_count - 1, size, compar);
    488e:	40bb0b33          	sub	s6,s6,a1
    while (size--)
    4892:	013406b3          	add	a3,s0,s3
        *a++ = *b;
    4896:	0004c703          	lbu	a4,0(s1)
        temp = *a;
    489a:	00044783          	lbu	a5,0(s0)
        *b++ = temp;
    489e:	0485                	addi	s1,s1,1
        *a++ = *b;
    48a0:	0405                	addi	s0,s0,1
    48a2:	fee40fa3          	sb	a4,-1(s0)
        *b++ = temp;
    48a6:	fef48fa3          	sb	a5,-1(s1)
    while (size--)
    48aa:	fed416e3          	bne	s0,a3,4896 <qsort+0x68>
    qsort(base, left_count, size, compar);
    48ae:	86d2                	mv	a3,s4
    48b0:	864e                	mv	a2,s3
    48b2:	8556                	mv	a0,s5
    48b4:	f7bff0ef          	jal	482e <qsort>
    if (nmemb < 2 || size == 0)
    48b8:	036bfe63          	bgeu	s7,s6,48f4 <qsort+0xc6>
    char *pivot = base_ptr + (nmemb - 1) * size;
    48bc:	1b7d                	addi	s6,s6,-1
    48be:	033b04b3          	mul	s1,s6,s3
    48c2:	8aa2                	mv	s5,s0
    48c4:	94d6                	add	s1,s1,s5
    for (; j < pivot; j += size)
    48c6:	f89aede3          	bltu	s5,s1,4860 <qsort+0x32>
    char *i = base_ptr;
    48ca:	8456                	mv	s0,s5
    for (; j < pivot; j += size)
    48cc:	4581                	li	a1,0
    48ce:	b7d1                	j	4892 <qsort+0x64>
    48d0:	01340633          	add	a2,s0,s3
            if (i != j)
    48d4:	874a                	mv	a4,s2
    48d6:	87a2                	mv	a5,s0
        *a++ = *b;
    48d8:	00074683          	lbu	a3,0(a4)
        temp = *a;
    48dc:	0007c803          	lbu	a6,0(a5)
        *b++ = temp;
    48e0:	0705                	addi	a4,a4,1
        *a++ = *b;
    48e2:	0785                	addi	a5,a5,1
    48e4:	fed78fa3          	sb	a3,-1(a5)
        *b++ = temp;
    48e8:	ff070fa3          	sb	a6,-1(a4)
    while (size--)
    48ec:	fec796e3          	bne	a5,a2,48d8 <qsort+0xaa>
            i += size;
    48f0:	8432                	mv	s0,a2
    48f2:	b779                	j	4880 <qsort+0x52>
    48f4:	6406                	ld	s0,64(sp)
    48f6:	74e2                	ld	s1,56(sp)
    48f8:	7942                	ld	s2,48(sp)
    48fa:	7a02                	ld	s4,32(sp)
    48fc:	6ae2                	ld	s5,24(sp)
    48fe:	6b42                	ld	s6,16(sp)
    4900:	6ba2                	ld	s7,8(sp)
}
    4902:	60a6                	ld	ra,72(sp)
    4904:	79a2                	ld	s3,40(sp)
    4906:	6161                	addi	sp,sp,80
    4908:	8082                	ret
    490a:	8082                	ret

000000000000490c <bsearch>:

void *bsearch(const void *key, const void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *))
{
    490c:	715d                	addi	sp,sp,-80
    490e:	e486                	sd	ra,72(sp)
    4910:	fc26                	sd	s1,56(sp)
    size_t l = 0, u = nmemb;
    while (l < u)
    4912:	c629                	beqz	a2,495c <bsearch+0x50>
    4914:	f84a                	sd	s2,48(sp)
    4916:	f44e                	sd	s3,40(sp)
    4918:	f052                	sd	s4,32(sp)
    491a:	ec56                	sd	s5,24(sp)
    491c:	e85a                	sd	s6,16(sp)
    491e:	e45e                	sd	s7,8(sp)
    4920:	e0a2                	sd	s0,64(sp)
    4922:	8932                	mv	s2,a2
    4924:	8a2a                	mv	s4,a0
    4926:	8aae                	mv	s5,a1
    4928:	8b36                	mv	s6,a3
    492a:	8bba                	mv	s7,a4
    size_t l = 0, u = nmemb;
    492c:	4981                	li	s3,0
    {
        size_t idx = (l + u) / 2;
    492e:	01298433          	add	s0,s3,s2
    4932:	8005                	srli	s0,s0,0x1
        const void *p = (void *)((const char *)base + (idx * size));
    4934:	036404b3          	mul	s1,s0,s6
        int cmp = compar(key, p);
    4938:	8552                	mv	a0,s4
        const void *p = (void *)((const char *)base + (idx * size));
    493a:	94d6                	add	s1,s1,s5
        int cmp = compar(key, p);
    493c:	85a6                	mv	a1,s1
    493e:	9b82                	jalr	s7
        if (cmp < 0)
    4940:	02054463          	bltz	a0,4968 <bsearch+0x5c>
            u = idx;
        else if (cmp > 0)
    4944:	c515                	beqz	a0,4970 <bsearch+0x64>
            l = idx + 1;
    4946:	00140993          	addi	s3,s0,1
    while (l < u)
    494a:	ff29e2e3          	bltu	s3,s2,492e <bsearch+0x22>
    494e:	6406                	ld	s0,64(sp)
    4950:	7942                	ld	s2,48(sp)
    4952:	79a2                	ld	s3,40(sp)
    4954:	7a02                	ld	s4,32(sp)
    4956:	6ae2                	ld	s5,24(sp)
    4958:	6b42                	ld	s6,16(sp)
    495a:	6ba2                	ld	s7,8(sp)
        else
            return (void *)p;
    }
    return NULL;
}
    495c:	60a6                	ld	ra,72(sp)
    return NULL;
    495e:	4481                	li	s1,0
}
    4960:	8526                	mv	a0,s1
    4962:	74e2                	ld	s1,56(sp)
    4964:	6161                	addi	sp,sp,80
    4966:	8082                	ret
            u = idx;
    4968:	8922                	mv	s2,s0
    while (l < u)
    496a:	fd29e2e3          	bltu	s3,s2,492e <bsearch+0x22>
    496e:	b7c5                	j	494e <bsearch+0x42>
    4970:	6406                	ld	s0,64(sp)
}
    4972:	60a6                	ld	ra,72(sp)
    4974:	7942                	ld	s2,48(sp)
    4976:	79a2                	ld	s3,40(sp)
    4978:	7a02                	ld	s4,32(sp)
    497a:	6ae2                	ld	s5,24(sp)
    497c:	6b42                	ld	s6,16(sp)
    497e:	6ba2                	ld	s7,8(sp)
    4980:	8526                	mv	a0,s1
    4982:	74e2                	ld	s1,56(sp)
    4984:	6161                	addi	sp,sp,80
    4986:	8082                	ret

0000000000004988 <abs>:

/* Math & Mics */

int abs(int j) { return (j < 0) ? -j : j; }
    4988:	41f5579b          	sraiw	a5,a0,0x1f
    498c:	8d3d                	xor	a0,a0,a5
    498e:	9d1d                	subw	a0,a0,a5
    4990:	8082                	ret

0000000000004992 <labs>:
long labs(long j) { return (j < 0) ? -j : j; }
    4992:	43f55793          	srai	a5,a0,0x3f
    4996:	8d3d                	xor	a0,a0,a5
    4998:	8d1d                	sub	a0,a0,a5
    499a:	8082                	ret

000000000000499c <llabs>:
long long llabs(long long j) { return (j < 0) ? -j : j; }
    499c:	43f55793          	srai	a5,a0,0x3f
    49a0:	8d3d                	xor	a0,a0,a5
    49a2:	8d1d                	sub	a0,a0,a5
    49a4:	8082                	ret

00000000000049a6 <div>:

div_t div(int numer, int denom)
{
    div_t res = {numer / denom, numer % denom};
    49a6:	02b547bb          	divw	a5,a0,a1
{
    49aa:	1141                	addi	sp,sp,-16
    return res;
}
    49ac:	0141                	addi	sp,sp,16
    div_t res = {numer / denom, numer % denom};
    49ae:	02b5653b          	remw	a0,a0,a1
    return res;
    49b2:	1782                	slli	a5,a5,0x20
    49b4:	9381                	srli	a5,a5,0x20
    49b6:	1502                	slli	a0,a0,0x20
}
    49b8:	8d5d                	or	a0,a0,a5
    49ba:	8082                	ret

00000000000049bc <ldiv>:
ldiv_t ldiv(long numer, long denom)
{
    49bc:	1141                	addi	sp,sp,-16
    49be:	87aa                	mv	a5,a0
    ldiv_t res = {numer / denom, numer % denom};
    return res;
}
    49c0:	02b54533          	div	a0,a0,a1
    49c4:	0141                	addi	sp,sp,16
    49c6:	02b7e5b3          	rem	a1,a5,a1
    49ca:	8082                	ret

00000000000049cc <lldiv>:
lldiv_t lldiv(long long numer, long long denom)
{
    49cc:	1141                	addi	sp,sp,-16
    49ce:	87aa                	mv	a5,a0
    lldiv_t res = {numer / denom, numer % denom};
    return res;
}
    49d0:	02b54533          	div	a0,a0,a1
    49d4:	0141                	addi	sp,sp,16
    49d6:	02b7e5b3          	rem	a1,a5,a1
    49da:	8082                	ret

00000000000049dc <rand>:

static unsigned long next = 1;
int rand(void)
{
    next = next * 1103515245 + 12345;
    49dc:	00003697          	auipc	a3,0x3
    49e0:	d0c68693          	addi	a3,a3,-756 # 76e8 <next>
    49e4:	629c                	ld	a5,0(a3)
    49e6:	41c65737          	lui	a4,0x41c65
    49ea:	e6d70713          	addi	a4,a4,-403 # 41c64e6d <_ZSt4cerr+0x41c5d605>
    49ee:	02e787b3          	mul	a5,a5,a4
    49f2:	670d                	lui	a4,0x3
    49f4:	03970713          	addi	a4,a4,57 # 3039 <sprintf+0x43>
    49f8:	97ba                	add	a5,a5,a4
    return (unsigned int)(next / 65536) % 32768;
    49fa:	02179513          	slli	a0,a5,0x21
    next = next * 1103515245 + 12345;
    49fe:	e29c                	sd	a5,0(a3)
}
    4a00:	9145                	srli	a0,a0,0x31
    4a02:	8082                	ret

0000000000004a04 <srand>:
void srand(unsigned int seed) { next = seed; }
    4a04:	1502                	slli	a0,a0,0x20
    4a06:	9101                	srli	a0,a0,0x20
    4a08:	00003797          	auipc	a5,0x3
    4a0c:	cea7b023          	sd	a0,-800(a5) # 76e8 <next>
    4a10:	8082                	ret

0000000000004a12 <mblen>:

/* Stub */
int mblen(const char *s, size_t n) { return (s && *s && n) ? 1 : 0; }
    4a12:	c901                	beqz	a0,4a22 <mblen+0x10>
    4a14:	00054783          	lbu	a5,0(a0)
    4a18:	4501                	li	a0,0
    4a1a:	c789                	beqz	a5,4a24 <mblen+0x12>
    4a1c:	00b03533          	snez	a0,a1
    4a20:	8082                	ret
    4a22:	4501                	li	a0,0
    4a24:	8082                	ret

0000000000004a26 <mbtowc>:
int mbtowc(wchar_t *pwc, const char *s, size_t n)
{
    4a26:	87aa                	mv	a5,a0
    if (!s)
    4a28:	cd81                	beqz	a1,4a40 <mbtowc+0x1a>
        return 0;
    if (n == 0)
        return -1;
    4a2a:	557d                	li	a0,-1
    if (n == 0)
    4a2c:	ca19                	beqz	a2,4a42 <mbtowc+0x1c>
    if (pwc)
    4a2e:	c781                	beqz	a5,4a36 <mbtowc+0x10>
        *pwc = (wchar_t)*s;
    4a30:	0005c703          	lbu	a4,0(a1)
    4a34:	c398                	sw	a4,0(a5)
    return (*s != 0);
    4a36:	0005c503          	lbu	a0,0(a1)
    4a3a:	00a03533          	snez	a0,a0
    4a3e:	8082                	ret
        return 0;
    4a40:	4501                	li	a0,0
}
    4a42:	8082                	ret

0000000000004a44 <wctomb>:
int wctomb(char *s, wchar_t wchar)
{
    if (!s)
    4a44:	c509                	beqz	a0,4a4e <wctomb+0xa>
        return 0;
    *s = (char)wchar;
    4a46:	00b50023          	sb	a1,0(a0)
    return 1;
    4a4a:	4505                	li	a0,1
    4a4c:	8082                	ret
        return 0;
    4a4e:	4501                	li	a0,0
}
    4a50:	8082                	ret

0000000000004a52 <mbstowcs>:
size_t mbstowcs(wchar_t *dest, const char *src, size_t n)
{
    size_t i = 0;
    while (src[i] && i < n)
    4a52:	0005c703          	lbu	a4,0(a1)
    4a56:	cb0d                	beqz	a4,4a88 <mbstowcs+0x36>
    4a58:	ca15                	beqz	a2,4a8c <mbstowcs+0x3a>
    4a5a:	86aa                	mv	a3,a0
    size_t i = 0;
    4a5c:	4781                	li	a5,0
    4a5e:	a019                	j	4a64 <mbstowcs+0x12>
    while (src[i] && i < n)
    4a60:	02f60263          	beq	a2,a5,4a84 <mbstowcs+0x32>
    {
        dest[i] = (wchar_t)src[i];
        i++;
    4a64:	0785                	addi	a5,a5,1
        dest[i] = (wchar_t)src[i];
    4a66:	c298                	sw	a4,0(a3)
    while (src[i] && i < n)
    4a68:	00f58733          	add	a4,a1,a5
    4a6c:	00074703          	lbu	a4,0(a4)
    4a70:	0691                	addi	a3,a3,4
    4a72:	f77d                	bnez	a4,4a60 <mbstowcs+0xe>
    }
    if (i < n)
    4a74:	00c7f763          	bgeu	a5,a2,4a82 <mbstowcs+0x30>
        dest[i] = 0;
    4a78:	00279713          	slli	a4,a5,0x2
    4a7c:	953a                	add	a0,a0,a4
    4a7e:	00052023          	sw	zero,0(a0)
    size_t i = 0;
    4a82:	863e                	mv	a2,a5
    4a84:	8532                	mv	a0,a2
    4a86:	8082                	ret
    4a88:	4781                	li	a5,0
    4a8a:	b7ed                	j	4a74 <mbstowcs+0x22>
    4a8c:	4501                	li	a0,0
    return i;
}
    4a8e:	8082                	ret

0000000000004a90 <wcstombs>:
size_t wcstombs(char *dest, const wchar_t *src, size_t n)
{
    size_t i = 0;
    while (src[i] && i < n)
    4a90:	4198                	lw	a4,0(a1)
    4a92:	c71d                	beqz	a4,4ac0 <wcstombs+0x30>
    4a94:	ca05                	beqz	a2,4ac4 <wcstombs+0x34>
    4a96:	0591                	addi	a1,a1,4
    size_t i = 0;
    4a98:	4781                	li	a5,0
    4a9a:	a019                	j	4aa0 <wcstombs+0x10>
    while (src[i] && i < n)
    4a9c:	02f60063          	beq	a2,a5,4abc <wcstombs+0x2c>
    {
        dest[i] = (char)src[i];
    4aa0:	00f506b3          	add	a3,a0,a5
    4aa4:	00e68023          	sb	a4,0(a3)
    while (src[i] && i < n)
    4aa8:	4198                	lw	a4,0(a1)
        i++;
    4aaa:	0785                	addi	a5,a5,1
    while (src[i] && i < n)
    4aac:	0591                	addi	a1,a1,4
    4aae:	f77d                	bnez	a4,4a9c <wcstombs+0xc>
    }
    if (i < n)
    4ab0:	00c7f563          	bgeu	a5,a2,4aba <wcstombs+0x2a>
        dest[i] = 0;
    4ab4:	953e                	add	a0,a0,a5
    4ab6:	00050023          	sb	zero,0(a0)
    size_t i = 0;
    4aba:	863e                	mv	a2,a5
    4abc:	8532                	mv	a0,a2
    4abe:	8082                	ret
    4ac0:	4781                	li	a5,0
    4ac2:	b7fd                	j	4ab0 <wcstombs+0x20>
    4ac4:	4501                	li	a0,0
    return i;
    4ac6:	8082                	ret

0000000000004ac8 <memset>:

void *memset(void *dst, int c, size_t n)
{
    char *cdst = (char *)dst;
    for (size_t i = 0; i < n; i++)
        cdst[i] = (char)c;
    4ac8:	0ff5f593          	zext.b	a1,a1
    4acc:	87aa                	mv	a5,a0
    4ace:	00a60733          	add	a4,a2,a0
    for (size_t i = 0; i < n; i++)
    4ad2:	c611                	beqz	a2,4ade <memset+0x16>
        cdst[i] = (char)c;
    4ad4:	00b78023          	sb	a1,0(a5)
    for (size_t i = 0; i < n; i++)
    4ad8:	0785                	addi	a5,a5,1
    4ada:	fee79de3          	bne	a5,a4,4ad4 <memset+0xc>
    return dst;
}
    4ade:	8082                	ret

0000000000004ae0 <memmove>:

void *memmove(void *vdst, const void *vsrc, size_t n)
{
    char *dst = (char *)vdst;
    const char *src = (const char *)vsrc;
    if (dst == src)
    4ae0:	02b50d63          	beq	a0,a1,4b1a <memmove+0x3a>
        return vdst;

    if (src > dst)
    4ae4:	00b57e63          	bgeu	a0,a1,4b00 <memmove+0x20>
    {
        while (n--)
    4ae8:	ca0d                	beqz	a2,4b1a <memmove+0x3a>
    4aea:	962a                	add	a2,a2,a0
    char *dst = (char *)vdst;
    4aec:	87aa                	mv	a5,a0
            *dst++ = *src++;
    4aee:	0005c703          	lbu	a4,0(a1)
    4af2:	0785                	addi	a5,a5,1
    4af4:	0585                	addi	a1,a1,1
    4af6:	fee78fa3          	sb	a4,-1(a5)
        while (n--)
    4afa:	fec79ae3          	bne	a5,a2,4aee <memmove+0xe>
    4afe:	8082                	ret
    }
    else
    {
        dst += n;
    4b00:	00c50733          	add	a4,a0,a2
        src += n;
    4b04:	00c587b3          	add	a5,a1,a2
        while (n-- > 0)
    4b08:	ca09                	beqz	a2,4b1a <memmove+0x3a>
            *--dst = *--src;
    4b0a:	fff7c683          	lbu	a3,-1(a5)
    4b0e:	17fd                	addi	a5,a5,-1
    4b10:	177d                	addi	a4,a4,-1
    4b12:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
    4b16:	fef59ae3          	bne	a1,a5,4b0a <memmove+0x2a>
    }
    return vdst;
}
    4b1a:	8082                	ret

0000000000004b1c <memcpy>:

void *memcpy(void *vdst, const void *vsrc, size_t n)
{
    return memmove(vdst, vsrc, n);
    4b1c:	b7d1                	j	4ae0 <memmove>

0000000000004b1e <memcmp>:

int memcmp(const void *s1, const void *s2, size_t n)
{
    const unsigned char *p1 = (const unsigned char *)s1;
    const unsigned char *p2 = (const unsigned char *)s2;
    while (n--)
    4b1e:	c205                	beqz	a2,4b3e <memcmp+0x20>
    4b20:	962a                	add	a2,a2,a0
    4b22:	a019                	j	4b28 <memcmp+0xa>
    4b24:	00c50d63          	beq	a0,a2,4b3e <memcmp+0x20>
    {
        if (*p1 != *p2)
    4b28:	00054783          	lbu	a5,0(a0)
    4b2c:	0005c703          	lbu	a4,0(a1)
            return *p1 - *p2;
        p1++;
    4b30:	0505                	addi	a0,a0,1
        p2++;
    4b32:	0585                	addi	a1,a1,1
        if (*p1 != *p2)
    4b34:	fee788e3          	beq	a5,a4,4b24 <memcmp+0x6>
            return *p1 - *p2;
    4b38:	40e7853b          	subw	a0,a5,a4
    4b3c:	8082                	ret
    }
    return 0;
    4b3e:	4501                	li	a0,0
}
    4b40:	8082                	ret

0000000000004b42 <memchr>:

void *memchr(const void *s, int c, size_t n)
{
    const unsigned char *p = (const unsigned char *)s;
    while (n--)
    4b42:	ce09                	beqz	a2,4b5c <memchr+0x1a>
    {
        if (*p == (unsigned char)c)
    4b44:	0ff5f593          	zext.b	a1,a1
    4b48:	962a                	add	a2,a2,a0
    4b4a:	a021                	j	4b52 <memchr+0x10>
            return (void *)p;
        p++;
    4b4c:	0505                	addi	a0,a0,1
    while (n--)
    4b4e:	00a60763          	beq	a2,a0,4b5c <memchr+0x1a>
        if (*p == (unsigned char)c)
    4b52:	00054783          	lbu	a5,0(a0)
    4b56:	feb79be3          	bne	a5,a1,4b4c <memchr+0xa>
    }
    return NULL;
}
    4b5a:	8082                	ret
    return NULL;
    4b5c:	4501                	li	a0,0
}
    4b5e:	8082                	ret

0000000000004b60 <strlen>:
/* String Manipulation Functions  */

size_t strlen(const char *s)
{
    const char *p = s;
    while (*p)
    4b60:	00054783          	lbu	a5,0(a0)
    4b64:	cb89                	beqz	a5,4b76 <strlen+0x16>
    const char *p = s;
    4b66:	87aa                	mv	a5,a0
    while (*p)
    4b68:	0017c703          	lbu	a4,1(a5)
        p++;
    4b6c:	0785                	addi	a5,a5,1
    while (*p)
    4b6e:	ff6d                	bnez	a4,4b68 <strlen+0x8>
    return (size_t)(p - s);
    4b70:	40a78533          	sub	a0,a5,a0
    4b74:	8082                	ret
    while (*p)
    4b76:	4501                	li	a0,0
}
    4b78:	8082                	ret

0000000000004b7a <strcpy>:

char *strcpy(char *dst, const char *src)
{
    char *os = dst;
    while ((*dst++ = *src++) != 0)
    4b7a:	87aa                	mv	a5,a0
    4b7c:	0005c703          	lbu	a4,0(a1)
    4b80:	0785                	addi	a5,a5,1
    4b82:	0585                	addi	a1,a1,1
    4b84:	fee78fa3          	sb	a4,-1(a5)
    4b88:	fb75                	bnez	a4,4b7c <strcpy+0x2>
        ;
    return os;
}
    4b8a:	8082                	ret

0000000000004b8c <strncpy>:
char *strncpy(char *dst, const char *src, size_t n)
{
    char *os = dst;
    size_t i;

    for (i = 0; i < n && src[i] != '\0'; i++)
    4b8c:	4781                	li	a5,0
    4b8e:	e619                	bnez	a2,4b9c <strncpy+0x10>
    4b90:	8082                	ret
        dst[i] = src[i];
    4b92:	00e68023          	sb	a4,0(a3)
    for (i = 0; i < n && src[i] != '\0'; i++)
    4b96:	0785                	addi	a5,a5,1
    4b98:	02f60263          	beq	a2,a5,4bbc <strncpy+0x30>
    4b9c:	00f58733          	add	a4,a1,a5
    4ba0:	00074703          	lbu	a4,0(a4)
        dst[i] = src[i];
    4ba4:	00f506b3          	add	a3,a0,a5
    for (i = 0; i < n && src[i] != '\0'; i++)
    4ba8:	f76d                	bnez	a4,4b92 <strncpy+0x6>

    for (; i < n; i++)
    4baa:	00c7f963          	bgeu	a5,a2,4bbc <strncpy+0x30>
    4bae:	87b6                	mv	a5,a3
    4bb0:	962a                	add	a2,a2,a0
        dst[i] = '\0';
    4bb2:	00078023          	sb	zero,0(a5)
    for (; i < n; i++)
    4bb6:	0785                	addi	a5,a5,1
    4bb8:	fec79de3          	bne	a5,a2,4bb2 <strncpy+0x26>

    return os;
}
    4bbc:	8082                	ret

0000000000004bbe <strcat>:

char *strcat(char *dst, const char *src)
{
    char *os = dst;
    while (*dst)
    4bbe:	00054783          	lbu	a5,0(a0)
    4bc2:	cf91                	beqz	a5,4bde <strcat+0x20>
    4bc4:	87aa                	mv	a5,a0
    4bc6:	0017c703          	lbu	a4,1(a5)
        dst++;
    4bca:	0785                	addi	a5,a5,1
    while (*dst)
    4bcc:	ff6d                	bnez	a4,4bc6 <strcat+0x8>
    while ((*dst++ = *src++) != 0)
    4bce:	0005c703          	lbu	a4,0(a1)
    4bd2:	0785                	addi	a5,a5,1
    4bd4:	0585                	addi	a1,a1,1
    4bd6:	fee78fa3          	sb	a4,-1(a5)
    4bda:	fb75                	bnez	a4,4bce <strcat+0x10>
        ;
    return os;
}
    4bdc:	8082                	ret
    while ((*dst++ = *src++) != 0)
    4bde:	0005c703          	lbu	a4,0(a1)
    while (*dst)
    4be2:	87aa                	mv	a5,a0
    while ((*dst++ = *src++) != 0)
    4be4:	0785                	addi	a5,a5,1
    4be6:	fee78fa3          	sb	a4,-1(a5)
    4bea:	0585                	addi	a1,a1,1
    4bec:	f36d                	bnez	a4,4bce <strcat+0x10>
    4bee:	8082                	ret

0000000000004bf0 <strncat>:
    while (*p)
    4bf0:	00054783          	lbu	a5,0(a0)
    const char *p = s;
    4bf4:	872a                	mv	a4,a0
    while (*p)
    4bf6:	c789                	beqz	a5,4c00 <strncat+0x10>
    4bf8:	00174783          	lbu	a5,1(a4)
        p++;
    4bfc:	0705                	addi	a4,a4,1
    while (*p)
    4bfe:	ffed                	bnez	a5,4bf8 <strncat+0x8>
    size_t dest_len = strlen(dst);
    size_t i;

    dst += dest_len;

    for (i = 0; i < n && src[i] != '\0'; i++)
    4c00:	86ba                	mv	a3,a4
    4c02:	4781                	li	a5,0
    4c04:	88ba                	mv	a7,a4
    4c06:	ea01                	bnez	a2,4c16 <strncat+0x26>
    4c08:	a839                	j	4c26 <strncat+0x36>
        dst[i] = src[i];
    4c0a:	01068023          	sb	a6,0(a3)
    for (i = 0; i < n && src[i] != '\0'; i++)
    4c0e:	00188693          	addi	a3,a7,1
    4c12:	00f60d63          	beq	a2,a5,4c2c <strncat+0x3c>
    4c16:	00f58833          	add	a6,a1,a5
    4c1a:	00084803          	lbu	a6,0(a6)
    4c1e:	0785                	addi	a5,a5,1
        dst[i] = src[i];
    4c20:	88b6                	mv	a7,a3
    for (i = 0; i < n && src[i] != '\0'; i++)
    4c22:	fe0814e3          	bnez	a6,4c0a <strncat+0x1a>

    dst[i] = '\0';
    4c26:	00088023          	sb	zero,0(a7)

    return os;
}
    4c2a:	8082                	ret
    dst[i] = '\0';
    4c2c:	00c708b3          	add	a7,a4,a2
    4c30:	00088023          	sb	zero,0(a7)
}
    4c34:	8082                	ret

0000000000004c36 <strcmp>:

int strcmp(const char *p, const char *q)
{
    while (*p && *p == *q)
    4c36:	00054783          	lbu	a5,0(a0)
    4c3a:	e791                	bnez	a5,4c46 <strcmp+0x10>
    4c3c:	a02d                	j	4c66 <strcmp+0x30>
    4c3e:	00054783          	lbu	a5,0(a0)
    4c42:	cf89                	beqz	a5,4c5c <strcmp+0x26>
    4c44:	85b6                	mv	a1,a3
    4c46:	0005c703          	lbu	a4,0(a1)
    {
        p++;
    4c4a:	0505                	addi	a0,a0,1
        q++;
    4c4c:	00158693          	addi	a3,a1,1
    while (*p && *p == *q)
    4c50:	fef707e3          	beq	a4,a5,4c3e <strcmp+0x8>
    }
    return (int)((unsigned char)*p - (unsigned char)*q);
    4c54:	0007851b          	sext.w	a0,a5
}
    4c58:	9d19                	subw	a0,a0,a4
    4c5a:	8082                	ret
    return (int)((unsigned char)*p - (unsigned char)*q);
    4c5c:	0015c703          	lbu	a4,1(a1)
    4c60:	4501                	li	a0,0
}
    4c62:	9d19                	subw	a0,a0,a4
    4c64:	8082                	ret
    return (int)((unsigned char)*p - (unsigned char)*q);
    4c66:	0005c703          	lbu	a4,0(a1)
    4c6a:	4501                	li	a0,0
    4c6c:	b7f5                	j	4c58 <strcmp+0x22>

0000000000004c6e <strncmp>:

int strncmp(const char *s1, const char *s2, size_t n)
{
    if (n == 0)
    4c6e:	ca0d                	beqz	a2,4ca0 <strncmp+0x32>
        return 0;

    while (n-- > 0 && *s1 && *s1 == *s2)
    4c70:	00054783          	lbu	a5,0(a0)
    4c74:	167d                	addi	a2,a2,-1
    4c76:	00c506b3          	add	a3,a0,a2
    4c7a:	eb89                	bnez	a5,4c8c <strncmp+0x1e>
    4c7c:	a80d                	j	4cae <strncmp+0x40>
    {
        if (n == 0 || *s1 == '\0')
    4c7e:	00d50d63          	beq	a0,a3,4c98 <strncmp+0x2a>
    while (n-- > 0 && *s1 && *s1 == *s2)
    4c82:	00154783          	lbu	a5,1(a0)
            break;
        s1++;
    4c86:	0505                	addi	a0,a0,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    4c88:	cf91                	beqz	a5,4ca4 <strncmp+0x36>
    4c8a:	85b2                	mv	a1,a2
    4c8c:	0005c703          	lbu	a4,0(a1)
        s2++;
    4c90:	00158613          	addi	a2,a1,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    4c94:	fef705e3          	beq	a4,a5,4c7e <strncmp+0x10>
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    4c98:	0007851b          	sext.w	a0,a5
    4c9c:	9d19                	subw	a0,a0,a4
    4c9e:	8082                	ret
        return 0;
    4ca0:	4501                	li	a0,0
}
    4ca2:	8082                	ret
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    4ca4:	0015c703          	lbu	a4,1(a1)
    4ca8:	4501                	li	a0,0
    4caa:	9d19                	subw	a0,a0,a4
    4cac:	8082                	ret
    4cae:	0005c703          	lbu	a4,0(a1)
    4cb2:	4501                	li	a0,0
    4cb4:	b7e5                	j	4c9c <strncmp+0x2e>

0000000000004cb6 <strchr>:

char *strchr(const char *s, int c)
{
    while (*s != (char)c)
    4cb6:	0ff5f593          	zext.b	a1,a1
    4cba:	a019                	j	4cc0 <strchr+0xa>
    {
        if (!*s++)
    4cbc:	0505                	addi	a0,a0,1
    4cbe:	c791                	beqz	a5,4cca <strchr+0x14>
    while (*s != (char)c)
    4cc0:	00054783          	lbu	a5,0(a0)
    4cc4:	feb79ce3          	bne	a5,a1,4cbc <strchr+0x6>
    4cc8:	8082                	ret
            return NULL;
    4cca:	4501                	li	a0,0
    }
    return (char *)s;
}
    4ccc:	8082                	ret

0000000000004cce <strrchr>:

char *strrchr(const char *s, int c)
{
    4cce:	87aa                	mv	a5,a0
    const char *last = NULL;
    do
    {
        if (*s == (char)c)
    4cd0:	0ff5f593          	zext.b	a1,a1
    const char *last = NULL;
    4cd4:	4501                	li	a0,0
        if (*s == (char)c)
    4cd6:	0007c703          	lbu	a4,0(a5)
    4cda:	00e59363          	bne	a1,a4,4ce0 <strrchr+0x12>
            last = s;
    4cde:	853e                	mv	a0,a5
    } while (*s++);
    4ce0:	0785                	addi	a5,a5,1
    4ce2:	fb75                	bnez	a4,4cd6 <strrchr+0x8>

    return (char *)last;
}
    4ce4:	8082                	ret

0000000000004ce6 <strstr>:
    while (*p)
    4ce6:	0005c883          	lbu	a7,0(a1)
    4cea:	04088a63          	beqz	a7,4d3e <strstr+0x58>
    const char *p = s;
    4cee:	87ae                	mv	a5,a1
    while (*p)
    4cf0:	0017c703          	lbu	a4,1(a5)
        p++;
    4cf4:	0785                	addi	a5,a5,1
    while (*p)
    4cf6:	ff6d                	bnez	a4,4cf0 <strstr+0xa>
    return (size_t)(p - s);
    4cf8:	40b78833          	sub	a6,a5,a1


char *strstr(const char *haystack, const char *needle)
{
    size_t n_len = strlen(needle);
    if (n_len == 0)
    4cfc:	04b78163          	beq	a5,a1,4d3e <strstr+0x58>
        return (char *)haystack;

    for (; *haystack; haystack++)
    4d00:	00054783          	lbu	a5,0(a0)
    4d04:	cf85                	beqz	a5,4d3c <strstr+0x56>
    4d06:	187d                	addi	a6,a6,-1
    4d08:	982a                	add	a6,a6,a0
    {
        if (*haystack != *needle)
    4d0a:	02f89463          	bne	a7,a5,4d32 <strstr+0x4c>
    while (n-- > 0 && *s1 && *s1 == *s2)
    4d0e:	00054703          	lbu	a4,0(a0)
    4d12:	8646                	mv	a2,a7
    4d14:	86ae                	mv	a3,a1
    4d16:	87aa                	mv	a5,a0
    4d18:	eb11                	bnez	a4,4d2c <strstr+0x46>
    4d1a:	a821                	j	4d32 <strstr+0x4c>
        if (n == 0 || *s1 == '\0')
    4d1c:	03078163          	beq	a5,a6,4d3e <strstr+0x58>
    while (n-- > 0 && *s1 && *s1 == *s2)
    4d20:	0017c703          	lbu	a4,1(a5)
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    4d24:	0006c603          	lbu	a2,0(a3)
        s1++;
    4d28:	0785                	addi	a5,a5,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    4d2a:	cb19                	beqz	a4,4d40 <strstr+0x5a>
        s2++;
    4d2c:	0685                	addi	a3,a3,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    4d2e:	fee607e3          	beq	a2,a4,4d1c <strstr+0x36>
    for (; *haystack; haystack++)
    4d32:	00154783          	lbu	a5,1(a0)
    4d36:	0805                	addi	a6,a6,1
    4d38:	0505                	addi	a0,a0,1
    4d3a:	fbe1                	bnez	a5,4d0a <strstr+0x24>
            continue;

        if (strncmp(haystack, needle, n_len) == 0)
            return (char *)haystack;
    }
    return NULL;
    4d3c:	4501                	li	a0,0
}
    4d3e:	8082                	ret
        if (strncmp(haystack, needle, n_len) == 0)
    4d40:	de7d                	beqz	a2,4d3e <strstr+0x58>
    for (; *haystack; haystack++)
    4d42:	00154783          	lbu	a5,1(a0)
    4d46:	0805                	addi	a6,a6,1
    4d48:	0505                	addi	a0,a0,1
    4d4a:	f3e1                	bnez	a5,4d0a <strstr+0x24>
    4d4c:	bfc5                	j	4d3c <strstr+0x56>

0000000000004d4e <strdup>:

char *strdup(const char *s)
{
    4d4e:	1101                	addi	sp,sp,-32
    4d50:	e426                	sd	s1,8(sp)
    4d52:	ec06                	sd	ra,24(sp)
    4d54:	e822                	sd	s0,16(sp)
    while (*p)
    4d56:	00054783          	lbu	a5,0(a0)
{
    4d5a:	84aa                	mv	s1,a0
    while (*p)
    4d5c:	cb8d                	beqz	a5,4d8e <strdup+0x40>
    const char *p = s;
    4d5e:	862a                	mv	a2,a0
    while (*p)
    4d60:	00164783          	lbu	a5,1(a2)
        p++;
    4d64:	0605                	addi	a2,a2,1
    while (*p)
    4d66:	ffed                	bnez	a5,4d60 <strdup+0x12>
    return (size_t)(p - s);
    4d68:	8e05                	sub	a2,a2,s1
    size_t len = strlen(s) + 1;
    4d6a:	00160413          	addi	s0,a2,1
    char *new_str = (char *)malloc(len);
    4d6e:	8522                	mv	a0,s0
    4d70:	f4eff0ef          	jal	44be <malloc>
    if (new_str == NULL)
    4d74:	c901                	beqz	a0,4d84 <strdup+0x36>
    return memmove(vdst, vsrc, n);
    4d76:	8622                	mv	a2,s0
        return NULL;

    return (char *)memcpy(new_str, s, len);
}
    4d78:	6442                	ld	s0,16(sp)
    4d7a:	60e2                	ld	ra,24(sp)
    return memmove(vdst, vsrc, n);
    4d7c:	85a6                	mv	a1,s1
}
    4d7e:	64a2                	ld	s1,8(sp)
    4d80:	6105                	addi	sp,sp,32
    return memmove(vdst, vsrc, n);
    4d82:	bbb9                	j	4ae0 <memmove>
}
    4d84:	60e2                	ld	ra,24(sp)
    4d86:	6442                	ld	s0,16(sp)
    4d88:	64a2                	ld	s1,8(sp)
    4d8a:	6105                	addi	sp,sp,32
    4d8c:	8082                	ret
    while (*p)
    4d8e:	4405                	li	s0,1
    4d90:	bff9                	j	4d6e <strdup+0x20>

0000000000004d92 <strlcpy>:
    4d92:	0005c783          	lbu	a5,0(a1)

size_t strlcpy(char *dst, const char *src, size_t size)
{
    4d96:	1101                	addi	sp,sp,-32
    4d98:	ec06                	sd	ra,24(sp)
    4d9a:	e822                	sd	s0,16(sp)
    4d9c:	86b2                	mv	a3,a2
    while (*p)
    4d9e:	cf8d                	beqz	a5,4dd8 <strlcpy+0x46>
    const char *p = s;
    4da0:	87ae                	mv	a5,a1
    while (*p)
    4da2:	0017c703          	lbu	a4,1(a5)
        p++;
    4da6:	0785                	addi	a5,a5,1
    while (*p)
    4da8:	ff6d                	bnez	a4,4da2 <strlcpy+0x10>
    return (size_t)(p - s);
    4daa:	40b78433          	sub	s0,a5,a1
    size_t src_len = strlen(src);

    if (size > 0)
    4dae:	c285                	beqz	a3,4dce <strlcpy+0x3c>
    4db0:	e426                	sd	s1,8(sp)
    {
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    4db2:	fff68613          	addi	a2,a3,-1
        memcpy(dst, src, copy_len);
        dst[copy_len] = '\0';
    4db6:	00c504b3          	add	s1,a0,a2
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    4dba:	00d47563          	bgeu	s0,a3,4dc4 <strlcpy+0x32>
        dst[copy_len] = '\0';
    4dbe:	008504b3          	add	s1,a0,s0
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    4dc2:	8622                	mv	a2,s0
    return memmove(vdst, vsrc, n);
    4dc4:	d1dff0ef          	jal	4ae0 <memmove>
        dst[copy_len] = '\0';
    4dc8:	00048023          	sb	zero,0(s1)
    }

    return src_len;
    4dcc:	64a2                	ld	s1,8(sp)
}
    4dce:	60e2                	ld	ra,24(sp)
    4dd0:	8522                	mv	a0,s0
    4dd2:	6442                	ld	s0,16(sp)
    4dd4:	6105                	addi	sp,sp,32
    4dd6:	8082                	ret
    if (size > 0)
    4dd8:	e219                	bnez	a2,4dde <strlcpy+0x4c>
    return (size_t)(p - s);
    4dda:	4401                	li	s0,0
    4ddc:	bfcd                	j	4dce <strlcpy+0x3c>
    4dde:	e426                	sd	s1,8(sp)
    4de0:	4401                	li	s0,0
    if (size > 0)
    4de2:	84aa                	mv	s1,a0
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    4de4:	4601                	li	a2,0
    4de6:	bff9                	j	4dc4 <strlcpy+0x32>

0000000000004de8 <strlcat>:
    while (*p)
    4de8:	0005c783          	lbu	a5,0(a1)

size_t strlcat(char *dst, const char *src, size_t size)
{
    4dec:	7179                	addi	sp,sp,-48
    4dee:	e84a                	sd	s2,16(sp)
    4df0:	f406                	sd	ra,40(sp)
    4df2:	f022                	sd	s0,32(sp)
    4df4:	ec26                	sd	s1,24(sp)
    4df6:	892a                	mv	s2,a0
    while (*p)
    4df8:	c7b5                	beqz	a5,4e64 <strlcat+0x7c>
    const char *p = s;
    4dfa:	87ae                	mv	a5,a1
    while (*p)
    4dfc:	0017c703          	lbu	a4,1(a5)
        p++;
    4e00:	0785                	addi	a5,a5,1
    while (*p)
    4e02:	ff6d                	bnez	a4,4dfc <strlcat+0x14>
    return (size_t)(p - s);
    4e04:	40b784b3          	sub	s1,a5,a1
    size_t dst_len = 0;
    4e08:	4401                	li	s0,0
    size_t src_len = strlen(src);

    while (dst_len < size && dst[dst_len] != '\0')
    4e0a:	e609                	bnez	a2,4e14 <strlcat+0x2c>
    4e0c:	a0a1                	j	4e54 <strlcat+0x6c>
        dst_len++;
    4e0e:	0405                	addi	s0,s0,1
    while (dst_len < size && dst[dst_len] != '\0')
    4e10:	04860263          	beq	a2,s0,4e54 <strlcat+0x6c>
    4e14:	00890533          	add	a0,s2,s0
    4e18:	00054783          	lbu	a5,0(a0)
    4e1c:	fbed                	bnez	a5,4e0e <strlcat+0x26>

    if (dst_len == size)
    4e1e:	02860b63          	beq	a2,s0,4e54 <strlcat+0x6c>
    4e22:	e44e                	sd	s3,8(sp)
        return size + src_len;

    size_t space_left = size - dst_len;
    4e24:	408607b3          	sub	a5,a2,s0
    size_t copy_len = (src_len >= space_left) ? space_left - 1 : src_len;
    4e28:	89a6                	mv	s3,s1
    4e2a:	02f4f263          	bgeu	s1,a5,4e4e <strlcat+0x66>

    memcpy(dst + dst_len, src, copy_len);
    dst[dst_len + copy_len] = '\0';
    4e2e:	994e                	add	s2,s2,s3
    4e30:	9922                	add	s2,s2,s0
    return memmove(vdst, vsrc, n);
    4e32:	864e                	mv	a2,s3
    4e34:	cadff0ef          	jal	4ae0 <memmove>
    dst[dst_len + copy_len] = '\0';
    4e38:	00090023          	sb	zero,0(s2) # 1000 <_vscanf_core.constprop.0+0x698>

    return dst_len + src_len;
    4e3c:	00940533          	add	a0,s0,s1
}
    4e40:	70a2                	ld	ra,40(sp)
    4e42:	7402                	ld	s0,32(sp)
    return dst_len + src_len;
    4e44:	69a2                	ld	s3,8(sp)
}
    4e46:	64e2                	ld	s1,24(sp)
    4e48:	6942                	ld	s2,16(sp)
    4e4a:	6145                	addi	sp,sp,48
    4e4c:	8082                	ret
    size_t copy_len = (src_len >= space_left) ? space_left - 1 : src_len;
    4e4e:	fff78993          	addi	s3,a5,-1
    4e52:	bff1                	j	4e2e <strlcat+0x46>
}
    4e54:	70a2                	ld	ra,40(sp)
    4e56:	7402                	ld	s0,32(sp)
    4e58:	6942                	ld	s2,16(sp)
        return size + src_len;
    4e5a:	00960533          	add	a0,a2,s1
}
    4e5e:	64e2                	ld	s1,24(sp)
    4e60:	6145                	addi	sp,sp,48
    4e62:	8082                	ret
    while (*p)
    4e64:	4481                	li	s1,0
    4e66:	b74d                	j	4e08 <strlcat+0x20>

0000000000004e68 <strspn>:
size_t strspn(const char *s, const char *accept)
{
    const char *p = s;
    const char *a;

    while (*p)
    4e68:	00054683          	lbu	a3,0(a0)
    4e6c:	c695                	beqz	a3,4e98 <strspn+0x30>
    {
        for (a = accept; *a; a++)
    4e6e:	0005c803          	lbu	a6,0(a1)
    4e72:	862a                	mv	a2,a0
    4e74:	00080f63          	beqz	a6,4e92 <strspn+0x2a>
    4e78:	87ae                	mv	a5,a1
    4e7a:	8742                	mv	a4,a6
    4e7c:	a021                	j	4e84 <strspn+0x1c>
    4e7e:	0007c703          	lbu	a4,0(a5)
    4e82:	cb01                	beqz	a4,4e92 <strspn+0x2a>
    4e84:	0785                	addi	a5,a5,1
        {
            if (*p == *a)
    4e86:	fee69ce3          	bne	a3,a4,4e7e <strspn+0x16>
    while (*p)
    4e8a:	00164683          	lbu	a3,1(a2)
                break;
        }
        if (*a == '\0')
            return (size_t)(p - s);
        p++;
    4e8e:	0605                	addi	a2,a2,1
    while (*p)
    4e90:	f6e5                	bnez	a3,4e78 <strspn+0x10>
    }
    return (size_t)(p - s);
    4e92:	40a60533          	sub	a0,a2,a0
    4e96:	8082                	ret
    while (*p)
    4e98:	4501                	li	a0,0
}
    4e9a:	8082                	ret

0000000000004e9c <strcspn>:
size_t strcspn(const char *s, const char *reject)
{
    const char *p = s;
    const char *r;

    while (*p)
    4e9c:	00054683          	lbu	a3,0(a0)
    4ea0:	ce85                	beqz	a3,4ed8 <strcspn+0x3c>
    {
        for (r = reject; *r; r++)
    4ea2:	0005c803          	lbu	a6,0(a1)
    const char *p = s;
    4ea6:	862a                	mv	a2,a0
        for (r = reject; *r; r++)
    4ea8:	02080363          	beqz	a6,4ece <strcspn+0x32>
    4eac:	87ae                	mv	a5,a1
    4eae:	8742                	mv	a4,a6
    4eb0:	a021                	j	4eb8 <strcspn+0x1c>
    4eb2:	0007c703          	lbu	a4,0(a5)
    4eb6:	c719                	beqz	a4,4ec4 <strcspn+0x28>
    4eb8:	0785                	addi	a5,a5,1
        {
            if (*p == *r)
    4eba:	fed71ce3          	bne	a4,a3,4eb2 <strcspn+0x16>
                return (size_t)(p - s);
        }
        p++;
    }
    return (size_t)(p - s);
    4ebe:	40a60533          	sub	a0,a2,a0
    4ec2:	8082                	ret
    while (*p)
    4ec4:	00164683          	lbu	a3,1(a2)
        p++;
    4ec8:	0605                	addi	a2,a2,1
    while (*p)
    4eca:	f2ed                	bnez	a3,4eac <strcspn+0x10>
    4ecc:	bfcd                	j	4ebe <strcspn+0x22>
    4ece:	00164683          	lbu	a3,1(a2)
        p++;
    4ed2:	0605                	addi	a2,a2,1
    while (*p)
    4ed4:	feed                	bnez	a3,4ece <strcspn+0x32>
    4ed6:	b7e5                	j	4ebe <strcspn+0x22>
    4ed8:	4501                	li	a0,0
}
    4eda:	8082                	ret

0000000000004edc <strpbrk>:

char *strpbrk(const char *s, const char *accept)
{
    const char *a;
    while (*s)
    4edc:	00054683          	lbu	a3,0(a0)
    4ee0:	c295                	beqz	a3,4f04 <strpbrk+0x28>
    {
        for (a = accept; *a; a++)
    4ee2:	0005c603          	lbu	a2,0(a1)
    4ee6:	c20d                	beqz	a2,4f08 <strpbrk+0x2c>
    4ee8:	87ae                	mv	a5,a1
    4eea:	8732                	mv	a4,a2
    4eec:	a021                	j	4ef4 <strpbrk+0x18>
    4eee:	0007c703          	lbu	a4,0(a5)
    4ef2:	c709                	beqz	a4,4efc <strpbrk+0x20>
    4ef4:	0785                	addi	a5,a5,1
        {
            if (*s == *a)
    4ef6:	fed71ce3          	bne	a4,a3,4eee <strpbrk+0x12>
                return (char *)s;
        }
        s++;
    }
    return NULL;
}
    4efa:	8082                	ret
    while (*s)
    4efc:	00154683          	lbu	a3,1(a0)
        s++;
    4f00:	0505                	addi	a0,a0,1
    while (*s)
    4f02:	f2fd                	bnez	a3,4ee8 <strpbrk+0xc>
    return NULL;
    4f04:	4501                	li	a0,0
}
    4f06:	8082                	ret
    while (*s)
    4f08:	00154683          	lbu	a3,1(a0)
        s++;
    4f0c:	0505                	addi	a0,a0,1
    while (*s)
    4f0e:	feed                	bnez	a3,4f08 <strpbrk+0x2c>
    4f10:	bfd5                	j	4f04 <strpbrk+0x28>

0000000000004f12 <strtok>:
char *strtok(char *str, const char *delim)
{
    static char *olds;
    char *token;

    if (str == NULL)
    4f12:	00003897          	auipc	a7,0x3
    4f16:	93e88893          	addi	a7,a7,-1730 # 7850 <olds.0>
    4f1a:	cd25                	beqz	a0,4f92 <strtok+0x80>
    while (*p)
    4f1c:	00054683          	lbu	a3,0(a0)
    4f20:	c295                	beqz	a3,4f44 <strtok+0x32>
        for (a = accept; *a; a++)
    4f22:	0005c803          	lbu	a6,0(a1)
    4f26:	02080463          	beqz	a6,4f4e <strtok+0x3c>
    4f2a:	87ae                	mv	a5,a1
    4f2c:	8742                	mv	a4,a6
    4f2e:	a021                	j	4f36 <strtok+0x24>
    4f30:	0007c703          	lbu	a4,0(a5)
    4f34:	cf09                	beqz	a4,4f4e <strtok+0x3c>
    4f36:	0785                	addi	a5,a5,1
            if (*p == *a)
    4f38:	fee69ce3          	bne	a3,a4,4f30 <strtok+0x1e>
    while (*p)
    4f3c:	00154683          	lbu	a3,1(a0)
        p++;
    4f40:	0505                	addi	a0,a0,1
    while (*p)
    4f42:	f6e5                	bnez	a3,4f2a <strtok+0x18>
    4f44:	87aa                	mv	a5,a0
        str = olds;

    str += strspn(str, delim);
    if (*str == '\0')
    {
        olds = str;
    4f46:	00f8b023          	sd	a5,0(a7)
        return NULL;
    4f4a:	4501                	li	a0,0
        *str = '\0';
        olds = str + 1;
    }

    return token;
}
    4f4c:	8082                	ret
    if (*str == '\0')
    4f4e:	00054603          	lbu	a2,0(a0)
    4f52:	da6d                	beqz	a2,4f44 <strtok+0x32>
    4f54:	86aa                	mv	a3,a0
        for (a = accept; *a; a++)
    4f56:	04080163          	beqz	a6,4f98 <strtok+0x86>
    4f5a:	8742                	mv	a4,a6
    4f5c:	87ae                	mv	a5,a1
    4f5e:	a021                	j	4f66 <strtok+0x54>
    4f60:	0007c703          	lbu	a4,0(a5)
    4f64:	cb19                	beqz	a4,4f7a <strtok+0x68>
    4f66:	0785                	addi	a5,a5,1
            if (*s == *a)
    4f68:	fee61ce3          	bne	a2,a4,4f60 <strtok+0x4e>
        olds = str + 1;
    4f6c:	00168793          	addi	a5,a3,1
        *str = '\0';
    4f70:	00068023          	sb	zero,0(a3)
        olds = str;
    4f74:	00f8b023          	sd	a5,0(a7)
}
    4f78:	8082                	ret
    while (*s)
    4f7a:	0016c603          	lbu	a2,1(a3)
        s++;
    4f7e:	0685                	addi	a3,a3,1
    while (*s)
    4f80:	fe69                	bnez	a2,4f5a <strtok+0x48>
    4f82:	87aa                	mv	a5,a0
    while (*s != (char)c)
    4f84:	0017c703          	lbu	a4,1(a5)
        if (!*s++)
    4f88:	0785                	addi	a5,a5,1
    while (*s != (char)c)
    4f8a:	ff6d                	bnez	a4,4f84 <strtok+0x72>
        olds = str;
    4f8c:	00f8b023          	sd	a5,0(a7)
}
    4f90:	8082                	ret
        str = olds;
    4f92:	0008b503          	ld	a0,0(a7)
    4f96:	b759                	j	4f1c <strtok+0xa>
    while (*s)
    4f98:	0016c603          	lbu	a2,1(a3)
        s++;
    4f9c:	0685                	addi	a3,a3,1
    while (*s)
    4f9e:	fe6d                	bnez	a2,4f98 <strtok+0x86>
    4fa0:	b7cd                	j	4f82 <strtok+0x70>

0000000000004fa2 <strerror>:

char *strerror(int errnum)
{
    4fa2:	87aa                	mv	a5,a0
    
    switch (errnum)
    4fa4:	cd09                	beqz	a0,4fbe <strerror+0x1c>
    4fa6:	4731                	li	a4,12
    4fa8:	00000517          	auipc	a0,0x0
    4fac:	1a050513          	addi	a0,a0,416 # 5148 <_GLOBAL__sub_I__ZSt3cin+0x168>
    4fb0:	00e78b63          	beq	a5,a4,4fc6 <strerror+0x24>
        return "Success";
    // case EINVAL: return "Invalid argument";
    case ENOMEM: return "Out of memory";
    
    default:
        return "Unknown error";
    4fb4:	00000517          	auipc	a0,0x0
    4fb8:	1a450513          	addi	a0,a0,420 # 5158 <_GLOBAL__sub_I__ZSt3cin+0x178>
    4fbc:	8082                	ret
        return "Success";
    4fbe:	00000517          	auipc	a0,0x0
    4fc2:	18250513          	addi	a0,a0,386 # 5140 <_GLOBAL__sub_I__ZSt3cin+0x160>
    }
    4fc6:	8082                	ret

0000000000004fc8 <_Znwm>:
#include "ulib/stdlib.h"

void *operator new(unsigned long n)
{
    return malloc(n);
    4fc8:	cf6ff06f          	j	44be <malloc>

0000000000004fcc <_Znam>:
}

void *operator new[](unsigned long n)
    4fcc:	cf2ff06f          	j	44be <malloc>

0000000000004fd0 <_ZdlPv>:
    return malloc(n);
}

void operator delete(void *p)
{
    free(p);
    4fd0:	c78ff06f          	j	4448 <free>

0000000000004fd4 <_ZdaPv>:
}

void operator delete[](void *p)
    4fd4:	c74ff06f          	j	4448 <free>

0000000000004fd8 <_ZdlPvm>:
    free(p);
}

void operator delete(void *p, unsigned long)
{
    free(p);
    4fd8:	c70ff06f          	j	4448 <free>

0000000000004fdc <_ZdaPvm>:
}

void operator delete[](void *p, unsigned long)
    4fdc:	c6cff06f          	j	4448 <free>

0000000000004fe0 <_GLOBAL__sub_I__ZSt3cin>:
#include "ulib/iostream"

namespace std
{
    istream cin(stdin);
    4fe0:	00002797          	auipc	a5,0x2
    4fe4:	7207b783          	ld	a5,1824(a5) # 7700 <_GLOBAL_OFFSET_TABLE_+0x10>
    4fe8:	6390                	ld	a2,0(a5)
    ostream cout(stdout);
    4fea:	00002797          	auipc	a5,0x2
    4fee:	70e7b783          	ld	a5,1806(a5) # 76f8 <_GLOBAL_OFFSET_TABLE_+0x8>
    4ff2:	6394                	ld	a3,0(a5)
    ostream cerr(stderr);
    4ff4:	00002797          	auipc	a5,0x2
    4ff8:	7147b783          	ld	a5,1812(a5) # 7708 <_GLOBAL_OFFSET_TABLE_+0x18>
    4ffc:	6398                	ld	a4,0(a5)

    class istream{
    private:
        FILE* _stream;
    public:
        istream(FILE *f) : _stream(f) {}
    4ffe:	00003797          	auipc	a5,0x3
    5002:	85a78793          	addi	a5,a5,-1958 # 7858 <_ZSt3cin>
    5006:	e390                	sd	a2,0(a5)
        ostream(FILE* f) : _stream(f) {}
    5008:	e794                	sd	a3,8(a5)
    500a:	eb98                	sd	a4,16(a5)
} // namespace std
    500c:	8082                	ret
