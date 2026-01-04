
build/user/init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "ulib/string.h"
#include "user/user.h"
#include "drivers/uart_color.h"

int main()
{
       0:	715d                	addi	sp,sp,-80
    char *argv[] = {(char *)"sh", 0};
       2:	00005797          	auipc	a5,0x5
       6:	01e78793          	addi	a5,a5,30 # 5020 <_GLOBAL__sub_I__ZSt3cin+0x30>

    printf(ANSI_BLUE"\n[Init] Starting Lume OS Shell..."ANSI_RESET);
       a:	00005517          	auipc	a0,0x5
       e:	01e50513          	addi	a0,a0,30 # 5028 <_GLOBAL__sub_I__ZSt3cin+0x38>
{
      12:	e486                	sd	ra,72(sp)
      14:	fc26                	sd	s1,56(sp)
      16:	f84a                	sd	s2,48(sp)
      18:	f44e                	sd	s3,40(sp)
      1a:	f052                	sd	s4,32(sp)
    char *argv[] = {(char *)"sh", 0};
      1c:	e83e                	sd	a5,16(sp)
{
      1e:	e0a2                	sd	s0,64(sp)
    char *argv[] = {(char *)"sh", 0};
      20:	ec02                	sd	zero,24(sp)
    printf(ANSI_BLUE"\n[Init] Starting Lume OS Shell..."ANSI_RESET);
      22:	0d9030ef          	jal	38fa <printf>
    printf("\n");
      26:	00005517          	auipc	a0,0x5
      2a:	03250513          	addi	a0,a0,50 # 5058 <_GLOBAL__sub_I__ZSt3cin+0x68>
      2e:	0cd030ef          	jal	38fa <printf>
      32:	0024                	addi	s1,sp,8
        int pid = fork();
        // printf("fork suceess, pid=%i\n", pid);
        
        if (pid < 0)
        {
            printf("[Init] fork failed!\n");
      34:	00005a17          	auipc	s4,0x5
      38:	02ca0a13          	addi	s4,s4,44 # 5060 <_GLOBAL__sub_I__ZSt3cin+0x70>
                    printf("Shell Exit");
                    break;
                }
                if (wpid < 0)
                {
                    printf("[Init] wait error or no child\n");
      3c:	00005997          	auipc	s3,0x5
      40:	06498993          	addi	s3,s3,100 # 50a0 <_GLOBAL__sub_I__ZSt3cin+0xb0>
                    printf("Shell Exit");
      44:	00005917          	auipc	s2,0x5
      48:	04c90913          	addi	s2,s2,76 # 5090 <_GLOBAL__sub_I__ZSt3cin+0xa0>
        int pid = fork();
      4c:	084000ef          	jal	d0 <fork>
      50:	842a                	mv	s0,a0
        if (pid < 0)
      52:	02054363          	bltz	a0,78 <main+0x78>
        if (pid == 0)
      56:	e501                	bnez	a0,5e <main+0x5e>
      58:	a81d                	j	8e <main+0x8e>
                if (wpid < 0)
      5a:	02054663          	bltz	a0,86 <main+0x86>
                wpid = wait((uint64)&status);
      5e:	8526                	mv	a0,s1
      60:	078000ef          	jal	d8 <wait>
                if (wpid == pid)
      64:	fea41be3          	bne	s0,a0,5a <main+0x5a>
                    printf("Shell Exit");
      68:	854a                	mv	a0,s2
      6a:	091030ef          	jal	38fa <printf>
        int pid = fork();
      6e:	062000ef          	jal	d0 <fork>
      72:	842a                	mv	s0,a0
        if (pid < 0)
      74:	fe0551e3          	bgez	a0,56 <main+0x56>
            printf("[Init] fork failed!\n");
      78:	8552                	mv	a0,s4
      7a:	081030ef          	jal	38fa <printf>
            exit(1);
      7e:	4505                	li	a0,1
      80:	38e040ef          	jal	440e <exit>
        if (pid == 0)
      84:	bfe9                	j	5e <main+0x5e>
                    printf("[Init] wait error or no child\n");
      86:	854e                	mv	a0,s3
      88:	073030ef          	jal	38fa <printf>

                    break;
                }
            }
        }
    }
      8c:	b7c1                	j	4c <main+0x4c>
            char sh_path[] = "/sh";
      8e:	006877b7          	lui	a5,0x687
      92:	32f78793          	addi	a5,a5,815 # 68732f <_ZSt4cerr+0x67faa7>
            exec(sh_path, argv);
      96:	080c                	addi	a1,sp,16
      98:	8526                	mv	a0,s1
            char sh_path[] = "/sh";
      9a:	c43e                	sw	a5,8(sp)
            exec(sh_path, argv);
      9c:	06c000ef          	jal	108 <exec>
            printf("[Init] exec sh failed\n");
      a0:	00005517          	auipc	a0,0x5
      a4:	fd850513          	addi	a0,a0,-40 # 5078 <_GLOBAL__sub_I__ZSt3cin+0x88>
      a8:	053030ef          	jal	38fa <printf>
    return 0;
      ac:	60a6                	ld	ra,72(sp)
      ae:	6406                	ld	s0,64(sp)
      b0:	74e2                	ld	s1,56(sp)
      b2:	7942                	ld	s2,48(sp)
      b4:	79a2                	ld	s3,40(sp)
      b6:	7a02                	ld	s4,32(sp)
      b8:	4501                	li	a0,0
      ba:	6161                	addi	sp,sp,80
      bc:	8082                	ret

00000000000000be <_start>:
.global _start

_start:


    call main
      be:	f43ff0ef          	jal	0 <main>

    call exit
      c2:	34c040ef          	jal	440e <exit>

      c6:	a001                	j	c6 <_start+0x8>

00000000000000c8 <sys_exit>:
    name: \
        li a7, SYS_ ## sysname; \
        ecall; \
        ret

SYSCALL_NAME(sys_exit, exit) 
      c8:	488d                	li	a7,3
      ca:	00000073          	ecall
      ce:	8082                	ret

00000000000000d0 <fork>:

SYSCALL(fork)
      d0:	4889                	li	a7,2
      d2:	00000073          	ecall
      d6:	8082                	ret

00000000000000d8 <wait>:
SYSCALL(wait)
      d8:	4891                	li	a7,4
      da:	00000073          	ecall
      de:	8082                	ret

00000000000000e0 <pipe>:
SYSCALL(pipe)
      e0:	4895                	li	a7,5
      e2:	00000073          	ecall
      e6:	8082                	ret

00000000000000e8 <read>:
SYSCALL(read)
      e8:	4899                	li	a7,6
      ea:	00000073          	ecall
      ee:	8082                	ret

00000000000000f0 <write>:
SYSCALL(write)
      f0:	48c5                	li	a7,17
      f2:	00000073          	ecall
      f6:	8082                	ret

00000000000000f8 <close>:
SYSCALL(close)
      f8:	48d9                	li	a7,22
      fa:	00000073          	ecall
      fe:	8082                	ret

0000000000000100 <kill>:
SYSCALL(kill)
     100:	489d                	li	a7,7
     102:	00000073          	ecall
     106:	8082                	ret

0000000000000108 <exec>:
SYSCALL(exec)
     108:	48a1                	li	a7,8
     10a:	00000073          	ecall
     10e:	8082                	ret

0000000000000110 <open>:
SYSCALL(open)
     110:	48c1                	li	a7,16
     112:	00000073          	ecall
     116:	8082                	ret

0000000000000118 <mknod>:
SYSCALL(mknod)
     118:	48c9                	li	a7,18
     11a:	00000073          	ecall
     11e:	8082                	ret

0000000000000120 <unlink>:
SYSCALL(unlink)
     120:	48cd                	li	a7,19
     122:	00000073          	ecall
     126:	8082                	ret

0000000000000128 <fstat>:
SYSCALL(fstat)
     128:	48a5                	li	a7,9
     12a:	00000073          	ecall
     12e:	8082                	ret

0000000000000130 <link>:
SYSCALL(link)
     130:	48d1                	li	a7,20
     132:	00000073          	ecall
     136:	8082                	ret

0000000000000138 <mkdir>:
SYSCALL(mkdir)
     138:	48d5                	li	a7,21
     13a:	00000073          	ecall
     13e:	8082                	ret

0000000000000140 <chdir>:
SYSCALL(chdir)
     140:	48a9                	li	a7,10
     142:	00000073          	ecall
     146:	8082                	ret

0000000000000148 <dup>:
SYSCALL(dup)
     148:	48ad                	li	a7,11
     14a:	00000073          	ecall
     14e:	8082                	ret

0000000000000150 <getpid>:
SYSCALL(getpid)
     150:	48b1                	li	a7,12
     152:	00000073          	ecall
     156:	8082                	ret

0000000000000158 <sbrk>:
SYSCALL(sbrk)
     158:	48b5                	li	a7,13
     15a:	00000073          	ecall
     15e:	8082                	ret

0000000000000160 <sleep>:
SYSCALL(sleep)
     160:	48b9                	li	a7,14
     162:	00000073          	ecall
     166:	8082                	ret

0000000000000168 <uptime>:
SYSCALL(uptime)
     168:	48bd                	li	a7,15
     16a:	00000073          	ecall
     16e:	8082                	ret

0000000000000170 <putc>:
SYSCALL(putc)
     170:	4885                	li	a7,1
     172:	00000073          	ecall
     176:	8082                	ret

0000000000000178 <disk_test>:
SYSCALL(disk_test)
     178:	48dd                	li	a7,23
     17a:	00000073          	ecall
     17e:	8082                	ret

0000000000000180 <lseek>:
SYSCALL(lseek)
     180:	48e1                	li	a7,24
     182:	00000073          	ecall
     186:	8082                	ret

0000000000000188 <shutdown>:
     188:	48e5                	li	a7,25
     18a:	00000073          	ecall
     18e:	8082                	ret

0000000000000190 <stbsp__clamp_callback>:
     190:	45dc                	lw	a5,12(a1)
     192:	4598                	lw	a4,8(a1)
     194:	9fb1                	addw	a5,a5,a2
     196:	c5dc                	sw	a5,12(a1)
     198:	0007069b          	sext.w	a3,a4
     19c:	00e65463          	bge	a2,a4,1a4 <stbsp__clamp_callback+0x14>
     1a0:	0006069b          	sext.w	a3,a2
     1a4:	c685                	beqz	a3,1cc <stbsp__clamp_callback+0x3c>
     1a6:	619c                	ld	a5,0(a1)
     1a8:	00a78e63          	beq	a5,a0,1c4 <stbsp__clamp_callback+0x34>
     1ac:	00d50633          	add	a2,a0,a3
     1b0:	00054703          	lbu	a4,0(a0)
     1b4:	0505                	addi	a0,a0,1
     1b6:	0785                	addi	a5,a5,1
     1b8:	fee78fa3          	sb	a4,-1(a5)
     1bc:	fec56ae3          	bltu	a0,a2,1b0 <stbsp__clamp_callback+0x20>
     1c0:	6188                	ld	a0,0(a1)
     1c2:	4598                	lw	a4,8(a1)
     1c4:	9f15                	subw	a4,a4,a3
     1c6:	9536                	add	a0,a0,a3
     1c8:	e188                	sd	a0,0(a1)
     1ca:	c598                	sw	a4,8(a1)
     1cc:	1ff00793          	li	a5,511
     1d0:	00e7d463          	bge	a5,a4,1d8 <stbsp__clamp_callback+0x48>
     1d4:	6188                	ld	a0,0(a1)
     1d6:	8082                	ret
     1d8:	01058513          	addi	a0,a1,16
     1dc:	8082                	ret

00000000000001de <stbsp__count_clamp_callback>:
     1de:	45dc                	lw	a5,12(a1)
     1e0:	01058513          	addi	a0,a1,16
     1e4:	9fb1                	addw	a5,a5,a2
     1e6:	c5dc                	sw	a5,12(a1)
     1e8:	8082                	ret

00000000000001ea <stbsp__real_to_str>:
     1ea:	e20508d3          	fmv.x.d	a7,fa0
     1ee:	82aa                	mv	t0,a0
     1f0:	4348d813          	srai	a6,a7,0x34
     1f4:	8ec6                	mv	t4,a7
     1f6:	7ff87813          	andi	a6,a6,2047
     1fa:	8346                	mv	t1,a7
     1fc:	03f8d513          	srli	a0,a7,0x3f
     200:	0008d663          	bgez	a7,20c <stbsp__real_to_str+0x22>
     204:	22a517d3          	fneg.d	fa5,fa0
     208:	e20788d3          	fmv.x.d	a7,fa5
     20c:	7ff00e13          	li	t3,2047
     210:	35c80663          	beq	a6,t3,55c <stbsp__real_to_str+0x372>
     214:	1101                	addi	sp,sp,-32
     216:	14080363          	beqz	a6,35c <stbsp__real_to_str+0x172>
     21a:	c018081b          	addiw	a6,a6,-1023
     21e:	ec22                	sd	s0,24(sp)
     220:	02081313          	slli	t1,a6,0x20
     224:	66034d63          	bltz	t1,89e <stbsp__real_to_str+0x6b4>
     228:	4d100313          	li	t1,1233
     22c:	0303033b          	mulw	t1,t1,a6
     230:	4849                	li	a6,18
     232:	40c3531b          	sraiw	t1,t1,0xc
     236:	0013039b          	addiw	t2,t1,1
     23a:	4078083b          	subw	a6,a6,t2
     23e:	4359                	li	t1,22
     240:	17036163          	bltu	t1,a6,3a2 <stbsp__real_to_str+0x1b8>
     244:	00005317          	auipc	t1,0x5
     248:	1b430313          	addi	t1,t1,436 # 53f8 <stbsp__bot>
     24c:	080e                	slli	a6,a6,0x3
     24e:	981a                	add	a6,a6,t1
     250:	00083e03          	ld	t3,0(a6)
     254:	00083607          	fld	fa2,0(a6)
     258:	f20887d3          	fmv.d.x	fa5,a7
     25c:	f8000837          	lui	a6,0xf8000
     260:	01187333          	and	t1,a6,a7
     264:	01c87833          	and	a6,a6,t3
     268:	12f676d3          	fmul.d	fa3,fa2,fa5
     26c:	f20807d3          	fmv.d.x	fa5,a6
     270:	f2030753          	fmv.d.x	fa4,t1
     274:	f20305d3          	fmv.d.x	fa1,t1
     278:	0af67653          	fsub.d	fa2,fa2,fa5
     27c:	f20887d3          	fmv.d.x	fa5,a7
     280:	0ae7f753          	fsub.d	fa4,fa5,fa4
     284:	f20807d3          	fmv.d.x	fa5,a6
     288:	6ab7f7c7          	fmsub.d	fa5,fa5,fa1,fa3
     28c:	7ab677c3          	fmadd.d	fa5,fa2,fa1,fa5
     290:	f20805d3          	fmv.d.x	fa1,a6
     294:	7ab777c3          	fmadd.d	fa5,fa4,fa1,fa5
     298:	7ac77743          	fmadd.d	fa4,fa4,fa2,fa5
     29c:	02d777d3          	fadd.d	fa5,fa4,fa3
     2a0:	3782e837          	lui	a6,0x3782e
     2a4:	acf80813          	addi	a6,a6,-1329 # 3782dacf <_ZSt4cerr+0x37826247>
     2a8:	0832                	slli	a6,a6,0xc
     2aa:	9d980813          	addi	a6,a6,-1575
     2ae:	084a                	slli	a6,a6,0x12
     2b0:	187d                	addi	a6,a6,-1
     2b2:	c22798d3          	fcvt.l.d	a7,fa5,rtz
     2b6:	0ad7f6d3          	fsub.d	fa3,fa5,fa3
     2ba:	00070e1b          	sext.w	t3,a4
     2be:	d228f653          	fcvt.d.l	fa2,a7
     2c2:	0ac7f5d3          	fsub.d	fa1,fa5,fa2
     2c6:	0ad77753          	fsub.d	fa4,fa4,fa3
     2ca:	0af5f6d3          	fsub.d	fa3,fa1,fa5
     2ce:	0ad5f553          	fsub.d	fa0,fa1,fa3
     2d2:	02d67653          	fadd.d	fa2,fa2,fa3
     2d6:	0aa7f7d3          	fsub.d	fa5,fa5,fa0
     2da:	0ac7f7d3          	fsub.d	fa5,fa5,fa2
     2de:	02b7f7d3          	fadd.d	fa5,fa5,fa1
     2e2:	02e7f7d3          	fadd.d	fa5,fa5,fa4
     2e6:	c2279fd3          	fcvt.l.d	t6,fa5,rtz
     2ea:	9fc6                	add	t6,t6,a7
     2ec:	19f87063          	bgeu	a6,t6,46c <stbsp__real_to_str+0x282>
     2f0:	2385                	addiw	t2,t2,1
     2f2:	300e4363          	bltz	t3,5f8 <stbsp__real_to_str+0x40e>
     2f6:	00e3833b          	addw	t1,t2,a4
     2fa:	475d                	li	a4,23
     2fc:	30677663          	bgeu	a4,t1,608 <stbsp__real_to_str+0x41e>
     300:	577d                	li	a4,-1
     302:	9301                	srli	a4,a4,0x20
     304:	43f75863          	bge	a4,t6,734 <stbsp__real_to_str+0x54a>
     308:	07d00313          	li	t1,125
     30c:	877e                	mv	a4,t6
     30e:	4e01                	li	t3,0
     310:	3e800813          	li	a6,1000
     314:	130e                	slli	t1,t1,0x23
     316:	a039                	j	324 <stbsp__real_to_str+0x13a>
     318:	030747b3          	div	a5,a4,a6
     31c:	4e05                	li	t3,1
     31e:	40674c63          	blt	a4,t1,736 <stbsp__real_to_str+0x54c>
     322:	873e                	mv	a4,a5
     324:	030768b3          	rem	a7,a4,a6
     328:	fe0888e3          	beqz	a7,318 <stbsp__real_to_str+0x12e>
     32c:	400e0163          	beqz	t3,72e <stbsp__real_to_str+0x544>
     330:	8fbe                	mv	t6,a5
     332:	05f5e7b7          	lui	a5,0x5f5e
     336:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f56877>
     33a:	04060413          	addi	s0,a2,64
     33e:	03860613          	addi	a2,a2,56
     342:	15f7c863          	blt	a5,t6,492 <stbsp__real_to_str+0x2a8>
     346:	000f871b          	sext.w	a4,t6
     34a:	20070463          	beqz	a4,552 <stbsp__real_to_str+0x368>
     34e:	4f01                	li	t5,0
     350:	4f81                	li	t6,0
     352:	00006e97          	auipc	t4,0x6
     356:	63ee8e93          	addi	t4,t4,1598 # 6990 <stbsp__digitpair>
     35a:	aaa9                	j	4b4 <stbsp__real_to_str+0x2ca>
     35c:	0306                	slli	t1,t1,0x1
     35e:	3e030e63          	beqz	t1,75a <stbsp__real_to_str+0x570>
     362:	4305                	li	t1,1
     364:	ec22                	sd	s0,24(sp)
     366:	00ce9e13          	slli	t3,t4,0xc
     36a:	134e                	slli	t1,t1,0x33
     36c:	520e4063          	bltz	t3,88c <stbsp__real_to_str+0x6a2>
     370:	40135313          	srai	t1,t1,0x1
     374:	01d37e33          	and	t3,t1,t4
     378:	8f42                	mv	t5,a6
     37a:	387d                	addiw	a6,a6,-1
     37c:	fe0e0ae3          	beqz	t3,370 <stbsp__real_to_str+0x186>
     380:	26900313          	li	t1,617
     384:	c00f081b          	addiw	a6,t5,-1024
     388:	0268083b          	mulw	a6,a6,t1
     38c:	41f8531b          	sraiw	t1,a6,0x1f
     390:	0153531b          	srliw	t1,t1,0x15
     394:	0103033b          	addw	t1,t1,a6
     398:	40b3539b          	sraiw	t2,t1,0xb
     39c:	4849                	li	a6,18
     39e:	4078083b          	subw	a6,a6,t2
     3a2:	41f8531b          	sraiw	t1,a6,0x1f
     3a6:	00684eb3          	xor	t4,a6,t1
     3aa:	406e8f3b          	subw	t5,t4,t1
     3ae:	2c900313          	li	t1,713
     3b2:	03e3033b          	mulw	t1,t1,t5
     3b6:	4e35                	li	t3,13
     3b8:	8efa                	mv	t4,t5
     3ba:	40e35f9b          	sraiw	t6,t1,0xe
     3be:	837e                	mv	t1,t6
     3c0:	23fe4363          	blt	t3,t6,5e6 <stbsp__real_to_str+0x3fc>
     3c4:	5e25                	li	t3,-23
     3c6:	026e0e3b          	mulw	t3,t3,t1
     3ca:	01de0ebb          	addw	t4,t3,t4
     3ce:	22084f63          	bltz	a6,60c <stbsp__real_to_str+0x422>
     3d2:	f2000753          	fmv.d.x	fa4,zero
     3d6:	00005e17          	auipc	t3,0x5
     3da:	022e0e13          	addi	t3,t3,34 # 53f8 <stbsp__bot>
     3de:	380e9e63          	bnez	t4,77a <stbsp__real_to_str+0x590>
     3e2:	f20887d3          	fmv.d.x	fa5,a7
     3e6:	fff30f1b          	addiw	t5,t1,-1
     3ea:	0f0e                	slli	t5,t5,0x3
     3ec:	02f777d3          	fadd.d	fa5,fa4,fa5
     3f0:	030e                	slli	t1,t1,0x3
     3f2:	9f72                	add	t5,t5,t3
     3f4:	9e1a                	add	t3,t3,t1
     3f6:	2e0e3e03          	ld	t3,736(t3)
     3fa:	2e8f3587          	fld	fa1,744(t5)
     3fe:	f8000837          	lui	a6,0xf8000
     402:	e2078ed3          	fmv.x.d	t4,fa5
     406:	12b7f6d3          	fmul.d	fa3,fa5,fa1
     40a:	f2088653          	fmv.d.x	fa2,a7
     40e:	01d87333          	and	t1,a6,t4
     412:	01c87833          	and	a6,a6,t3
     416:	f20807d3          	fmv.d.x	fa5,a6
     41a:	f2030053          	fmv.d.x	ft0,t1
     41e:	0af5f553          	fsub.d	fa0,fa1,fa5
     422:	f20e87d3          	fmv.d.x	fa5,t4
     426:	0ac7f0d3          	fsub.d	ft1,fa5,fa2
     42a:	f20807d3          	fmv.d.x	fa5,a6
     42e:	f2030653          	fmv.d.x	fa2,t1
     432:	6ac7f647          	fmsub.d	fa2,fa5,fa2,fa3
     436:	f20e87d3          	fmv.d.x	fa5,t4
     43a:	0a177753          	fsub.d	fa4,fa4,ft1
     43e:	f20300d3          	fmv.d.x	ft1,t1
     442:	0a07f7d3          	fsub.d	fa5,fa5,ft0
     446:	350f3007          	fld	ft0,848(t5)
     44a:	62157643          	fmadd.d	fa2,fa0,ft1,fa2
     44e:	12b77753          	fmul.d	fa4,fa4,fa1
     452:	f20805d3          	fmv.d.x	fa1,a6
     456:	62b7f643          	fmadd.d	fa2,fa5,fa1,fa2
     45a:	f20e85d3          	fmv.d.x	fa1,t4
     45e:	7205f743          	fmadd.d	fa4,fa1,ft0,fa4
     462:	62a7f7c3          	fmadd.d	fa5,fa5,fa0,fa2
     466:	02e7f753          	fadd.d	fa4,fa5,fa4
     46a:	bd0d                	j	29c <stbsp__real_to_str+0xb2>
     46c:	00e3833b          	addw	t1,t2,a4
     470:	2a0e4663          	bltz	t3,71c <stbsp__real_to_str+0x532>
     474:	475d                	li	a4,23
     476:	10677663          	bgeu	a4,t1,582 <stbsp__real_to_str+0x398>
     47a:	e80f93e3          	bnez	t6,300 <stbsp__real_to_str+0x116>
     47e:	05f5e7b7          	lui	a5,0x5f5e
     482:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f56877>
     486:	04060413          	addi	s0,a2,64
     48a:	03860613          	addi	a2,a2,56
     48e:	ebf7dce3          	bge	a5,t6,346 <stbsp__real_to_str+0x15c>
     492:	4f01                	li	t5,0
     494:	00006e97          	auipc	t4,0x6
     498:	4fce8e93          	addi	t4,t4,1276 # 6990 <stbsp__digitpair>
     49c:	05f5e7b7          	lui	a5,0x5f5e
     4a0:	10078793          	addi	a5,a5,256 # 5f5e100 <_ZSt4cerr+0x5f56878>
     4a4:	02ffe833          	rem	a6,t6,a5
     4a8:	02ffcfb3          	div	t6,t6,a5
     4ac:	0008071b          	sext.w	a4,a6
     4b0:	0a080463          	beqz	a6,558 <stbsp__real_to_str+0x36e>
     4b4:	8822                	mv	a6,s0
     4b6:	06400893          	li	a7,100
     4ba:	06300e13          	li	t3,99
     4be:	1879                	addi	a6,a6,-2 # fffffffff7fffffe <_ZSt4cerr+0xfffffffff7ff8776>
     4c0:	0007031b          	sext.w	t1,a4
     4c4:	031777bb          	remuw	a5,a4,a7
     4c8:	2785                	addiw	a5,a5,1
     4ca:	0017979b          	slliw	a5,a5,0x1
     4ce:	1782                	slli	a5,a5,0x20
     4d0:	9381                	srli	a5,a5,0x20
     4d2:	97f6                	add	a5,a5,t4
     4d4:	0007d783          	lhu	a5,0(a5)
     4d8:	0317573b          	divuw	a4,a4,a7
     4dc:	00f81023          	sh	a5,0(a6)
     4e0:	fc6e6fe3          	bltu	t3,t1,4be <stbsp__real_to_str+0x2d4>
     4e4:	008f0f3b          	addw	t5,t5,s0
     4e8:	410f0f3b          	subw	t5,t5,a6
     4ec:	020f8f63          	beqz	t6,52a <stbsp__real_to_str+0x340>
     4f0:	87c2                	mv	a5,a6
     4f2:	03000713          	li	a4,48
     4f6:	04c80c63          	beq	a6,a2,54e <stbsp__real_to_str+0x364>
     4fa:	17fd                	addi	a5,a5,-1
     4fc:	00e78023          	sb	a4,0(a5)
     500:	fec79de3          	bne	a5,a2,4fa <stbsp__real_to_str+0x310>
     504:	408807b3          	sub	a5,a6,s0
     508:	00ff07bb          	addw	a5,t5,a5
     50c:	1461                	addi	s0,s0,-8
     50e:	00878f1b          	addiw	t5,a5,8
     512:	05f5e7b7          	lui	a5,0x5f5e
     516:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f56877>
     51a:	ff840613          	addi	a2,s0,-8
     51e:	f7f7cfe3          	blt	a5,t6,49c <stbsp__real_to_str+0x2b2>
     522:	000f871b          	sext.w	a4,t6
     526:	4f81                	li	t6,0
     528:	b771                	j	4b4 <stbsp__real_to_str+0x2ca>
     52a:	020f0563          	beqz	t5,554 <stbsp__real_to_str+0x36a>
     52e:	00084703          	lbu	a4,0(a6)
     532:	03000793          	li	a5,48
     536:	22f70f63          	beq	a4,a5,774 <stbsp__real_to_str+0x58a>
     53a:	2f01                	sext.w	t5,t5
     53c:	0076a023          	sw	t2,0(a3)
     540:	6462                	ld	s0,24(sp)
     542:	0102b023          	sd	a6,0(t0)
     546:	01e5a023          	sw	t5,0(a1)
     54a:	6105                	addi	sp,sp,32
     54c:	8082                	ret
     54e:	8442                	mv	s0,a6
     550:	b7c9                	j	512 <stbsp__real_to_str+0x328>
     552:	8822                	mv	a6,s0
     554:	4f01                	li	t5,0
     556:	b7dd                	j	53c <stbsp__real_to_str+0x352>
     558:	8822                	mv	a6,s0
     55a:	bf59                	j	4f0 <stbsp__real_to_str+0x306>
     55c:	0eb2                	slli	t4,t4,0xc
     55e:	00005797          	auipc	a5,0x5
     562:	b6a78793          	addi	a5,a5,-1174 # 50c8 <_GLOBAL__sub_I__ZSt3cin+0xd8>
     566:	000e8663          	beqz	t4,572 <stbsp__real_to_str+0x388>
     56a:	00005797          	auipc	a5,0x5
     56e:	b5678793          	addi	a5,a5,-1194 # 50c0 <_GLOBAL__sub_I__ZSt3cin+0xd0>
     572:	00f2b023          	sd	a5,0(t0)
     576:	679d                	lui	a5,0x7
     578:	c29c                	sw	a5,0(a3)
     57a:	4f0d                	li	t5,3
     57c:	01e5a023          	sw	t5,0(a1)
     580:	8082                	ret
     582:	3b9ad737          	lui	a4,0x3b9ad
     586:	9ff70713          	addi	a4,a4,-1537 # 3b9ac9ff <_ZSt4cerr+0x3b9a5177>
     58a:	07f76f63          	bltu	a4,t6,608 <stbsp__real_to_str+0x41e>
     58e:	4805                	li	a6,1
     590:	02081713          	slli	a4,a6,0x20
     594:	01d75893          	srli	a7,a4,0x1d
     598:	00005717          	auipc	a4,0x5
     59c:	21870713          	addi	a4,a4,536 # 57b0 <stbsp__powten>
     5a0:	9746                	add	a4,a4,a7
     5a2:	4e51                	li	t3,20
     5a4:	a021                	j	5ac <stbsp__real_to_str+0x3c2>
     5a6:	2805                	addiw	a6,a6,1
     5a8:	edc809e3          	beq	a6,t3,47a <stbsp__real_to_str+0x290>
     5ac:	00073883          	ld	a7,0(a4)
     5b0:	0721                	addi	a4,a4,8
     5b2:	ff1ffae3          	bgeu	t6,a7,5a6 <stbsp__real_to_str+0x3bc>
     5b6:	ed0372e3          	bgeu	t1,a6,47a <stbsp__real_to_str+0x290>
     5ba:	4068083b          	subw	a6,a6,t1
     5be:	475d                	li	a4,23
     5c0:	eb076de3          	bltu	a4,a6,47a <stbsp__real_to_str+0x290>
     5c4:	080e                	slli	a6,a6,0x3
     5c6:	00005717          	auipc	a4,0x5
     5ca:	e3270713          	addi	a4,a4,-462 # 53f8 <stbsp__bot>
     5ce:	9742                	add	a4,a4,a6
     5d0:	3b873803          	ld	a6,952(a4)
     5d4:	00185713          	srli	a4,a6,0x1
     5d8:	977e                	add	a4,a4,t6
     5da:	01176363          	bltu	a4,a7,5e0 <stbsp__real_to_str+0x3f6>
     5de:	2385                	addiw	t2,t2,1
     5e0:	03075fb3          	divu	t6,a4,a6
     5e4:	bd59                	j	47a <stbsp__real_to_str+0x290>
     5e6:	4335                	li	t1,13
     5e8:	5e25                	li	t3,-23
     5ea:	026e0e3b          	mulw	t3,t3,t1
     5ee:	01de0ebb          	addw	t4,t3,t4
     5f2:	de0850e3          	bgez	a6,3d2 <stbsp__real_to_str+0x1e8>
     5f6:	a819                	j	60c <stbsp__real_to_str+0x422>
     5f8:	02571313          	slli	t1,a4,0x25
     5fc:	02535313          	srli	t1,t1,0x25
     600:	0305                	addi	t1,t1,1
     602:	475d                	li	a4,23
     604:	ce676ee3          	bltu	a4,t1,300 <stbsp__real_to_str+0x116>
     608:	4829                	li	a6,10
     60a:	b759                	j	590 <stbsp__real_to_str+0x3a6>
     60c:	260e8663          	beqz	t4,878 <stbsp__real_to_str+0x68e>
     610:	00231e13          	slli	t3,t1,0x2
     614:	41c30e33          	sub	t3,t1,t3
     618:	0e0e                	slli	t3,t3,0x3
     61a:	9e1a                	add	t3,t3,t1
     61c:	fffe881b          	addiw	a6,t4,-1
     620:	9e7a                	add	t3,t3,t5
     622:	00005e97          	auipc	t4,0x5
     626:	dd6e8e93          	addi	t4,t4,-554 # 53f8 <stbsp__bot>
     62a:	0e0e                	slli	t3,t3,0x3
     62c:	080e                	slli	a6,a6,0x3
     62e:	9876                	add	a6,a6,t4
     630:	9ef2                	add	t4,t4,t3
     632:	0b883607          	fld	fa2,184(a6)
     636:	f20887d3          	fmv.d.x	fa5,a7
     63a:	0b0ebf03          	ld	t5,176(t4)
     63e:	f8000e37          	lui	t3,0xf8000
     642:	011e7eb3          	and	t4,t3,a7
     646:	12f676d3          	fmul.d	fa3,fa2,fa5
     64a:	01ee7e33          	and	t3,t3,t5
     64e:	f20e07d3          	fmv.d.x	fa5,t3
     652:	f20e0753          	fmv.d.x	fa4,t3
     656:	f20e8553          	fmv.d.x	fa0,t4
     65a:	0af67653          	fsub.d	fa2,fa2,fa5
     65e:	f20e87d3          	fmv.d.x	fa5,t4
     662:	f20e85d3          	fmv.d.x	fa1,t4
     666:	6ae7f7c7          	fmsub.d	fa5,fa5,fa4,fa3
     66a:	f2088753          	fmv.d.x	fa4,a7
     66e:	0ab775d3          	fsub.d	fa1,fa4,fa1
     672:	16883707          	fld	fa4,360(a6)
     676:	7aa677c3          	fmadd.d	fa5,fa2,fa0,fa5
     67a:	f20e0553          	fmv.d.x	fa0,t3
     67e:	7aa5f7c3          	fmadd.d	fa5,fa1,fa0,fa5
     682:	7ac5f5c3          	fmadd.d	fa1,fa1,fa2,fa5
     686:	f20887d3          	fmv.d.x	fa5,a7
     68a:	5af77743          	fmadd.d	fa4,fa4,fa5,fa1
     68e:	c00f87e3          	beqz	t6,29c <stbsp__real_to_str+0xb2>
     692:	02d777d3          	fadd.d	fa5,fa4,fa3
     696:	fff3089b          	addiw	a7,t1,-1
     69a:	00005817          	auipc	a6,0x5
     69e:	d5e80813          	addi	a6,a6,-674 # 53f8 <stbsp__bot>
     6a2:	030e                	slli	t1,t1,0x3
     6a4:	088e                	slli	a7,a7,0x3
     6a6:	98c2                	add	a7,a7,a6
     6a8:	981a                	add	a6,a6,t1
     6aa:	e2078e53          	fmv.x.d	t3,fa5
     6ae:	21083e83          	ld	t4,528(a6)
     6b2:	f8000837          	lui	a6,0xf8000
     6b6:	2188b507          	fld	fa0,536(a7)
     6ba:	01c87333          	and	t1,a6,t3
     6be:	01d87833          	and	a6,a6,t4
     6c2:	f2080653          	fmv.d.x	fa2,a6
     6c6:	12f577d3          	fmul.d	fa5,fa0,fa5
     6ca:	2808b587          	fld	fa1,640(a7)
     6ce:	0ac57053          	fsub.d	ft0,fa0,fa2
     6d2:	f20e0653          	fmv.d.x	fa2,t3
     6d6:	0ad67153          	fsub.d	ft2,fa2,fa3
     6da:	f20806d3          	fmv.d.x	fa3,a6
     6de:	f2030653          	fmv.d.x	fa2,t1
     6e2:	7ac6f0c7          	fmsub.d	ft1,fa3,fa2,fa5
     6e6:	f20e06d3          	fmv.d.x	fa3,t3
     6ea:	0ac6f653          	fsub.d	fa2,fa3,fa2
     6ee:	22f786d3          	fmv.d	fa3,fa5
     6f2:	0a2777d3          	fsub.d	fa5,fa4,ft2
     6f6:	f2030753          	fmv.d.x	fa4,t1
     6fa:	0ae07743          	fmadd.d	fa4,ft0,fa4,ft1
     6fe:	12a7f7d3          	fmul.d	fa5,fa5,fa0
     702:	f2080553          	fmv.d.x	fa0,a6
     706:	72a67743          	fmadd.d	fa4,fa2,fa0,fa4
     70a:	f20e0553          	fmv.d.x	fa0,t3
     70e:	7aa5f7c3          	fmadd.d	fa5,fa1,fa0,fa5
     712:	72067643          	fmadd.d	fa2,fa2,ft0,fa4
     716:	02f67753          	fadd.d	fa4,fa2,fa5
     71a:	b649                	j	29c <stbsp__real_to_str+0xb2>
     71c:	02571313          	slli	t1,a4,0x25
     720:	02535313          	srli	t1,t1,0x25
     724:	0305                	addi	t1,t1,1
     726:	475d                	li	a4,23
     728:	d46769e3          	bltu	a4,t1,47a <stbsp__real_to_str+0x290>
     72c:	bd99                	j	582 <stbsp__real_to_str+0x398>
     72e:	87fe                	mv	a5,t6
     730:	8fbe                	mv	t6,a5
     732:	b101                	j	332 <stbsp__real_to_str+0x148>
     734:	87fe                	mv	a5,t6
     736:	3e800713          	li	a4,1000
     73a:	02e7f73b          	remuw	a4,a5,a4
     73e:	2781                	sext.w	a5,a5
     740:	eb01                	bnez	a4,750 <stbsp__real_to_str+0x566>
     742:	3e800813          	li	a6,1000
     746:	0307d7bb          	divuw	a5,a5,a6
     74a:	0307f73b          	remuw	a4,a5,a6
     74e:	df65                	beqz	a4,746 <stbsp__real_to_str+0x55c>
     750:	02079f93          	slli	t6,a5,0x20
     754:	020fdf93          	srli	t6,t6,0x20
     758:	b31d                	j	47e <stbsp__real_to_str+0x294>
     75a:	4785                	li	a5,1
     75c:	c29c                	sw	a5,0(a3)
     75e:	00c2b023          	sd	a2,0(t0)
     762:	03000793          	li	a5,48
     766:	00f60023          	sb	a5,0(a2)
     76a:	4f05                	li	t5,1
     76c:	01e5a023          	sw	t5,0(a1)
     770:	6105                	addi	sp,sp,32
     772:	8082                	ret
     774:	0805                	addi	a6,a6,1 # fffffffff8000001 <_ZSt4cerr+0xfffffffff7ff8779>
     776:	3f7d                	addiw	t5,t5,-1
     778:	b3d1                	j	53c <stbsp__real_to_str+0x352>
     77a:	e826                	sd	s1,16(sp)
     77c:	e44a                	sd	s2,8(sp)
     77e:	4859                	li	a6,22
     780:	8976                	mv	s2,t4
     782:	11d84363          	blt	a6,t4,888 <stbsp__real_to_str+0x69e>
     786:	0009049b          	sext.w	s1,s2
     78a:	00005e17          	auipc	t3,0x5
     78e:	c6ee0e13          	addi	t3,t3,-914 # 53f8 <stbsp__bot>
     792:	00349813          	slli	a6,s1,0x3
     796:	9872                	add	a6,a6,t3
     798:	00083687          	fld	fa3,0(a6)
     79c:	00083803          	ld	a6,0(a6)
     7a0:	f20887d3          	fmv.d.x	fa5,a7
     7a4:	f8000fb7          	lui	t6,0xf8000
     7a8:	010ff833          	and	a6,t6,a6
     7ac:	12f6f553          	fmul.d	fa0,fa3,fa5
     7b0:	f20807d3          	fmv.d.x	fa5,a6
     7b4:	011ff433          	and	s0,t6,a7
     7b8:	f2040753          	fmv.d.x	fa4,s0
     7bc:	0af6f6d3          	fsub.d	fa3,fa3,fa5
     7c0:	f20887d3          	fmv.d.x	fa5,a7
     7c4:	f2080653          	fmv.d.x	fa2,a6
     7c8:	412e8ebb          	subw	t4,t4,s2
     7cc:	0ae7f753          	fsub.d	fa4,fa5,fa4
     7d0:	f20407d3          	fmv.d.x	fa5,s0
     7d4:	e20508d3          	fmv.x.d	a7,fa0
     7d8:	52c7f7c7          	fmsub.d	fa5,fa5,fa2,fa0
     7dc:	f2040653          	fmv.d.x	fa2,s0
     7e0:	7ac6f7c3          	fmadd.d	fa5,fa3,fa2,fa5
     7e4:	f2080653          	fmv.d.x	fa2,a6
     7e8:	7ac777c3          	fmadd.d	fa5,fa4,fa2,fa5
     7ec:	7ad77743          	fmadd.d	fa4,fa4,fa3,fa5
     7f0:	080e8963          	beqz	t4,882 <stbsp__real_to_str+0x698>
     7f4:	02e577d3          	fadd.d	fa5,fa0,fa4
     7f8:	0e8e                	slli	t4,t4,0x3
     7fa:	01de0833          	add	a6,t3,t4
     7fe:	00083587          	fld	fa1,0(a6)
     802:	00231893          	slli	a7,t1,0x2
     806:	411308b3          	sub	a7,t1,a7
     80a:	00389813          	slli	a6,a7,0x3
     80e:	e2078453          	fmv.x.d	s0,fa5
     812:	12f5f7d3          	fmul.d	fa5,fa1,fa5
     816:	981a                	add	a6,a6,t1
     818:	987a                	add	a6,a6,t5
     81a:	40980833          	sub	a6,a6,s1
     81e:	080e                	slli	a6,a6,0x3
     820:	9872                	add	a6,a6,t3
     822:	00083e83          	ld	t4,0(a6)
     826:	008ff833          	and	a6,t6,s0
     82a:	e20788d3          	fmv.x.d	a7,fa5
     82e:	f20806d3          	fmv.d.x	fa3,a6
     832:	f20407d3          	fmv.d.x	fa5,s0
     836:	01dfffb3          	and	t6,t6,t4
     83a:	f20880d3          	fmv.d.x	ft1,a7
     83e:	0ad7f653          	fsub.d	fa2,fa5,fa3
     842:	f20f87d3          	fmv.d.x	fa5,t6
     846:	64c2                	ld	s1,16(sp)
     848:	6922                	ld	s2,8(sp)
     84a:	0af5f053          	fsub.d	ft0,fa1,fa5
     84e:	0ad7f6c7          	fmsub.d	fa3,fa5,fa3,ft1
     852:	f20407d3          	fmv.d.x	fa5,s0
     856:	0aa7f7d3          	fsub.d	fa5,fa5,fa0
     85a:	f2080553          	fmv.d.x	fa0,a6
     85e:	6aa076c3          	fmadd.d	fa3,ft0,fa0,fa3
     862:	0af77753          	fsub.d	fa4,fa4,fa5
     866:	f20f87d3          	fmv.d.x	fa5,t6
     86a:	6af677c3          	fmadd.d	fa5,fa2,fa5,fa3
     86e:	7a067643          	fmadd.d	fa2,fa2,ft0,fa5
     872:	62e5f743          	fmadd.d	fa4,fa1,fa4,fa2
     876:	b6b5                	j	3e2 <stbsp__real_to_str+0x1f8>
     878:	f20886d3          	fmv.d.x	fa3,a7
     87c:	f2000753          	fmv.d.x	fa4,zero
     880:	b539                	j	68e <stbsp__real_to_str+0x4a4>
     882:	64c2                	ld	s1,16(sp)
     884:	6922                	ld	s2,8(sp)
     886:	beb1                	j	3e2 <stbsp__real_to_str+0x1f8>
     888:	4959                	li	s2,22
     88a:	bdf5                	j	786 <stbsp__real_to_str+0x59c>
     88c:	e826                	sd	s1,16(sp)
     88e:	e44a                	sd	s2,8(sp)
     890:	ecc00393          	li	t2,-308
     894:	4eed                	li	t4,27
     896:	4335                	li	t1,13
     898:	14600f13          	li	t5,326
     89c:	b5cd                	j	77e <stbsp__real_to_str+0x594>
     89e:	26900313          	li	t1,617
     8a2:	0303083b          	mulw	a6,t1,a6
     8a6:	41f8531b          	sraiw	t1,a6,0x1f
     8aa:	0153531b          	srliw	t1,t1,0x15
     8ae:	0103033b          	addw	t1,t1,a6
     8b2:	40b3539b          	sraiw	t2,t1,0xb
     8b6:	4849                	li	a6,18
     8b8:	4078083b          	subw	a6,a6,t2
     8bc:	b249                	j	23e <stbsp__real_to_str+0x54>

00000000000008be <_in_char.part.0>:
static int _in_char(_InContext *ctx)
     8be:	87aa                	mv	a5,a0
    if (ctx->fd == -1)
     8c0:	4508                	lw	a0,8(a0)
     8c2:	577d                	li	a4,-1
     8c4:	00e51d63          	bne	a0,a4,8de <_in_char.part.0+0x20>
        if (ctx->buf[ctx->pos] == '\0')
     8c8:	6b94                	ld	a3,16(a5)
     8ca:	6398                	ld	a4,0(a5)
     8cc:	9736                	add	a4,a4,a3
     8ce:	00074603          	lbu	a2,0(a4)
     8d2:	c60d                	beqz	a2,8fc <_in_char.part.0+0x3e>
        return (unsigned char)ctx->buf[ctx->pos++];
     8d4:	0685                	addi	a3,a3,1
     8d6:	eb94                	sd	a3,16(a5)
     8d8:	00074503          	lbu	a0,0(a4)
     8dc:	8082                	ret
static int _in_char(_InContext *ctx)
     8de:	1101                	addi	sp,sp,-32
    if (read(ctx->fd, &c, 1) == 1)
     8e0:	4605                	li	a2,1
     8e2:	00f10593          	addi	a1,sp,15
static int _in_char(_InContext *ctx)
     8e6:	ec06                	sd	ra,24(sp)
    if (read(ctx->fd, &c, 1) == 1)
     8e8:	801ff0ef          	jal	e8 <read>
     8ec:	4785                	li	a5,1
     8ee:	00f51963          	bne	a0,a5,900 <_in_char.part.0+0x42>
        return (unsigned char)c;
     8f2:	00f14503          	lbu	a0,15(sp)
}
     8f6:	60e2                	ld	ra,24(sp)
     8f8:	6105                	addi	sp,sp,32
     8fa:	8082                	ret
            return -1;
     8fc:	557d                	li	a0,-1
}
     8fe:	8082                	ret
            return -1;
     900:	557d                	li	a0,-1
     902:	bfd5                	j	8f6 <_in_char.part.0+0x38>

0000000000000904 <_skip_space>:
{
     904:	7139                	addi	sp,sp,-64
     906:	f822                	sd	s0,48(sp)
     908:	f426                	sd	s1,40(sp)
     90a:	f04a                	sd	s2,32(sp)
     90c:	ec4e                	sd	s3,24(sp)
     90e:	e852                	sd	s4,16(sp)
     910:	fc06                	sd	ra,56(sp)
     912:	842a                	mv	s0,a0
        ctx->ungotten = -1;
     914:	54fd                	li	s1,-1
    if (read(ctx->fd, &c, 1) == 1)
     916:	00f10a13          	addi	s4,sp,15
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     91a:	02000913          	li	s2,32
     91e:	4991                	li	s3,4
    if (ctx->ungotten >= 0)
     920:	4c1c                	lw	a5,24(s0)
     922:	0407d163          	bgez	a5,964 <_skip_space+0x60>
    if (ctx->fd == -1)
     926:	4408                	lw	a0,8(s0)
    if (read(ctx->fd, &c, 1) == 1)
     928:	4605                	li	a2,1
     92a:	85d2                	mv	a1,s4
    if (ctx->fd == -1)
     92c:	02951e63          	bne	a0,s1,968 <_skip_space+0x64>
        if (ctx->buf[ctx->pos] == '\0')
     930:	6818                	ld	a4,16(s0)
     932:	601c                	ld	a5,0(s0)
        return (unsigned char)ctx->buf[ctx->pos++];
     934:	00170693          	addi	a3,a4,1
        if (ctx->buf[ctx->pos] == '\0')
     938:	97ba                	add	a5,a5,a4
     93a:	0007c703          	lbu	a4,0(a5) # 7000 <_stdout+0x150>
     93e:	cb19                	beqz	a4,954 <_skip_space+0x50>
        return (unsigned char)ctx->buf[ctx->pos++];
     940:	e814                	sd	a3,16(s0)
     942:	0007c783          	lbu	a5,0(a5)
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     946:	ff77871b          	addiw	a4,a5,-9
     94a:	fd278be3          	beq	a5,s2,920 <_skip_space+0x1c>
     94e:	fce9f9e3          	bgeu	s3,a4,920 <_skip_space+0x1c>
        ctx->ungotten = c;
     952:	cc1c                	sw	a5,24(s0)
}
     954:	70e2                	ld	ra,56(sp)
     956:	7442                	ld	s0,48(sp)
     958:	74a2                	ld	s1,40(sp)
     95a:	7902                	ld	s2,32(sp)
     95c:	69e2                	ld	s3,24(sp)
     95e:	6a42                	ld	s4,16(sp)
     960:	6121                	addi	sp,sp,64
     962:	8082                	ret
        ctx->ungotten = -1;
     964:	cc04                	sw	s1,24(s0)
        return c;
     966:	b7c5                	j	946 <_skip_space+0x42>
    if (read(ctx->fd, &c, 1) == 1)
     968:	f80ff0ef          	jal	e8 <read>
     96c:	4785                	li	a5,1
     96e:	fef513e3          	bne	a0,a5,954 <_skip_space+0x50>
        return (unsigned char)c;
     972:	00f14783          	lbu	a5,15(sp)
     976:	bfc1                	j	946 <_skip_space+0x42>

0000000000000978 <_vscanf_core.constprop.0>:
static int _vscanf_core(_InContext *ctx, const char *format, va_list ap)
     978:	7155                	addi	sp,sp,-208
     97a:	e586                	sd	ra,200(sp)
     97c:	e95a                	sd	s6,144(sp)
    while (*p)
     97e:	0005c783          	lbu	a5,0(a1)
static int _vscanf_core(_InContext *ctx, const char *format, va_list ap)
     982:	e432                	sd	a2,8(sp)
    while (*p)
     984:	68078b63          	beqz	a5,101a <_vscanf_core.constprop.0+0x6a2>
     988:	e1a2                	sd	s0,192(sp)
     98a:	fd26                	sd	s1,184(sp)
     98c:	f152                	sd	s4,160(sp)
     98e:	ed56                	sd	s5,152(sp)
     990:	f4ee                	sd	s11,104(sp)
     992:	842e                	mv	s0,a1
     994:	8daa                	mv	s11,a0
    int assigned = 0;
     996:	4b01                	li	s6,0
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     998:	02000493          	li	s1,32
     99c:	4a91                	li	s5,4
        if (*p != '%')
     99e:	02500a13          	li	s4,37
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     9a2:	04978763          	beq	a5,s1,9f0 <_vscanf_core.constprop.0+0x78>
     9a6:	ff77869b          	addiw	a3,a5,-9
     9aa:	0ff6f693          	zext.b	a3,a3
     9ae:	04daf163          	bgeu	s5,a3,9f0 <_vscanf_core.constprop.0+0x78>
        if (*p != '%')
     9b2:	07478d63          	beq	a5,s4,a2c <_vscanf_core.constprop.0+0xb4>
            _skip_space(ctx);
     9b6:	856e                	mv	a0,s11
     9b8:	f4dff0ef          	jal	904 <_skip_space>
    if (ctx->ungotten >= 0)
     9bc:	018da503          	lw	a0,24(s11)
     9c0:	04055a63          	bgez	a0,a14 <_vscanf_core.constprop.0+0x9c>
     9c4:	856e                	mv	a0,s11
     9c6:	ef9ff0ef          	jal	8be <_in_char.part.0>
            if (c != *p)
     9ca:	00044783          	lbu	a5,0(s0)
     9ce:	04a78a63          	beq	a5,a0,a22 <_vscanf_core.constprop.0+0xaa>
    if (c != -1)
     9d2:	57fd                	li	a5,-1
     9d4:	00f50463          	beq	a0,a5,9dc <_vscanf_core.constprop.0+0x64>
        ctx->ungotten = c;
     9d8:	00adac23          	sw	a0,24(s11)
     9dc:	640e                	ld	s0,192(sp)
     9de:	74ea                	ld	s1,184(sp)
     9e0:	7a0a                	ld	s4,160(sp)
     9e2:	6aea                	ld	s5,152(sp)
     9e4:	7da6                	ld	s11,104(sp)
}
     9e6:	60ae                	ld	ra,200(sp)
     9e8:	855a                	mv	a0,s6
     9ea:	6b4a                	ld	s6,144(sp)
     9ec:	6169                	addi	sp,sp,208
     9ee:	8082                	ret
            _skip_space(ctx);
     9f0:	856e                	mv	a0,s11
     9f2:	f13ff0ef          	jal	904 <_skip_space>
            while (isspace(*p))
     9f6:	00044783          	lbu	a5,0(s0)
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     9fa:	4611                	li	a2,4
     9fc:	ff77869b          	addiw	a3,a5,-9
     a00:	0ff6f693          	zext.b	a3,a3
     a04:	00978663          	beq	a5,s1,a10 <_vscanf_core.constprop.0+0x98>
     a08:	00d67463          	bgeu	a2,a3,a10 <_vscanf_core.constprop.0+0x98>
    while (*p)
     a0c:	fbd9                	bnez	a5,9a2 <_vscanf_core.constprop.0+0x2a>
     a0e:	b7f9                	j	9dc <_vscanf_core.constprop.0+0x64>
                p++;
     a10:	0405                	addi	s0,s0,1
     a12:	b7d5                	j	9f6 <_vscanf_core.constprop.0+0x7e>
        ctx->ungotten = -1;
     a14:	57fd                	li	a5,-1
     a16:	00fdac23          	sw	a5,24(s11)
            if (c != *p)
     a1a:	00044783          	lbu	a5,0(s0)
     a1e:	faa79ae3          	bne	a5,a0,9d2 <_vscanf_core.constprop.0+0x5a>
    while (*p)
     a22:	00144783          	lbu	a5,1(s0)
            p++;
     a26:	0405                	addi	s0,s0,1
    while (*p)
     a28:	ffad                	bnez	a5,9a2 <_vscanf_core.constprop.0+0x2a>
     a2a:	bf4d                	j	9dc <_vscanf_core.constprop.0+0x64>
     a2c:	f94a                	sd	s2,176(sp)
     a2e:	f54e                	sd	s3,168(sp)
     a30:	e55e                	sd	s7,136(sp)
     a32:	e162                	sd	s8,128(sp)
        if (*p == '*')
     a34:	00144583          	lbu	a1,1(s0)
     a38:	02a00793          	li	a5,42
     a3c:	22f58d63          	beq	a1,a5,c76 <_vscanf_core.constprop.0+0x2fe>
        p++;
     a40:	0405                	addi	s0,s0,1
        int suppress = 0;
     a42:	4981                	li	s3,0
        while (*p >= '0' && *p <= '9')
     a44:	fd05861b          	addiw	a2,a1,-48
     a48:	0ff67693          	zext.b	a3,a2
     a4c:	47a5                	li	a5,9
     a4e:	36d7e763          	bltu	a5,a3,dbc <_vscanf_core.constprop.0+0x444>
     a52:	4781                	li	a5,0
     a54:	4825                	li	a6,9
     a56:	a019                	j	a5c <_vscanf_core.constprop.0+0xe4>
            width = width * 10 + (*p - '0');
     a58:	0016979b          	slliw	a5,a3,0x1
        while (*p >= '0' && *p <= '9')
     a5c:	00144583          	lbu	a1,1(s0)
            width = width * 10 + (*p - '0');
     a60:	00f6093b          	addw	s2,a2,a5
     a64:	0029169b          	slliw	a3,s2,0x2
        while (*p >= '0' && *p <= '9')
     a68:	fd05861b          	addiw	a2,a1,-48
     a6c:	0ff67513          	zext.b	a0,a2
            width = width * 10 + (*p - '0');
     a70:	012686bb          	addw	a3,a3,s2
            p++;
     a74:	0405                	addi	s0,s0,1
        while (*p >= '0' && *p <= '9')
     a76:	fea871e3          	bgeu	a6,a0,a58 <_vscanf_core.constprop.0+0xe0>
        if (*p == 'l')
     a7a:	06c00693          	li	a3,108
            p++;
     a7e:	00140b93          	addi	s7,s0,1
        if (*p == 'l')
     a82:	1ed58f63          	beq	a1,a3,c80 <_vscanf_core.constprop.0+0x308>
        else if (*p == 'h')
     a86:	06800693          	li	a3,104
     a8a:	2ad58863          	beq	a1,a3,d3a <_vscanf_core.constprop.0+0x3c2>
        char spec = *p++;
     a8e:	00044c03          	lbu	s8,0(s0)
     a92:	8ba2                	mv	s7,s0
        int len_mod = 0;
     a94:	ec02                	sd	zero,24(sp)
        char spec = *p++;
     a96:	06300693          	li	a3,99
     a9a:	001b8413          	addi	s0,s7,1
        if (!spec)
     a9e:	2adc0863          	beq	s8,a3,d4e <_vscanf_core.constprop.0+0x3d6>
     aa2:	1f86fc63          	bgeu	a3,s8,c9a <_vscanf_core.constprop.0+0x322>
     aa6:	f9cc069b          	addiw	a3,s8,-100
     aaa:	0ff6f693          	zext.b	a3,a3
     aae:	4651                	li	a2,20
     ab0:	0cd66e63          	bltu	a2,a3,b8c <_vscanf_core.constprop.0+0x214>
     ab4:	00120637          	lui	a2,0x120
     ab8:	4585                	li	a1,1
     aba:	00d595b3          	sll	a1,a1,a3
     abe:	02160613          	addi	a2,a2,33 # 120021 <_ZSt4cerr+0x118799>
     ac2:	8e6d                	and	a2,a2,a1
     ac4:	ee69                	bnez	a2,b9e <_vscanf_core.constprop.0+0x226>
     ac6:	89b9                	andi	a1,a1,14
     ac8:	1e059263          	bnez	a1,cac <_vscanf_core.constprop.0+0x334>
     acc:	463d                	li	a2,15
     ace:	0ac69f63          	bne	a3,a2,b8c <_vscanf_core.constprop.0+0x214>
            _skip_space(ctx);
     ad2:	856e                	mv	a0,s11
     ad4:	e31ff0ef          	jal	904 <_skip_space>
            char *buf = suppress ? NULL : va_arg(ap, char *);
     ad8:	ec02                	sd	zero,24(sp)
     ada:	00099763          	bnez	s3,ae8 <_vscanf_core.constprop.0+0x170>
     ade:	67a2                	ld	a5,8(sp)
     ae0:	6398                	ld	a4,0(a5)
     ae2:	07a1                	addi	a5,a5,8
     ae4:	e43e                	sd	a5,8(sp)
     ae6:	ec3a                	sd	a4,24(sp)
    if (ctx->ungotten >= 0)
     ae8:	018da503          	lw	a0,24(s11)
     aec:	2e055b63          	bgez	a0,de2 <_vscanf_core.constprop.0+0x46a>
     af0:	856e                	mv	a0,s11
     af2:	dcdff0ef          	jal	8be <_in_char.part.0>
            while (c != -1 && !isspace(c))
     af6:	56fd                	li	a3,-1
     af8:	6ad50363          	beq	a0,a3,119e <_vscanf_core.constprop.0+0x826>
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     afc:	02000693          	li	a3,32
     b00:	3ed50963          	beq	a0,a3,ef2 <_vscanf_core.constprop.0+0x57a>
     b04:	46a5                	li	a3,9
     b06:	3ed50663          	beq	a0,a3,ef2 <_vscanf_core.constprop.0+0x57a>
     b0a:	46a9                	li	a3,10
     b0c:	3ed50363          	beq	a0,a3,ef2 <_vscanf_core.constprop.0+0x57a>
     b10:	46ad                	li	a3,11
     b12:	3ed50063          	beq	a0,a3,ef2 <_vscanf_core.constprop.0+0x57a>
     b16:	46b1                	li	a3,12
     b18:	3cd50d63          	beq	a0,a3,ef2 <_vscanf_core.constprop.0+0x57a>
     b1c:	46b5                	li	a3,13
     b1e:	3cd50a63          	beq	a0,a3,ef2 <_vscanf_core.constprop.0+0x57a>
     b22:	67e2                	ld	a5,24(sp)
     b24:	fce6                	sd	s9,120(sp)
     b26:	f8ea                	sd	s10,112(sp)
     b28:	e83e                	sd	a5,16(sp)
     b2a:	4d01                	li	s10,0
            while (c != -1 && !isspace(c))
     b2c:	5c7d                	li	s8,-1
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     b2e:	02000c93          	li	s9,32
                if (width > 0 && i >= width)
     b32:	01205463          	blez	s2,b3a <_vscanf_core.constprop.0+0x1c2>
     b36:	052d5563          	bge	s10,s2,b80 <_vscanf_core.constprop.0+0x208>
                if (!suppress)
     b3a:	00099563          	bnez	s3,b44 <_vscanf_core.constprop.0+0x1cc>
                    buf[i] = (char)c;
     b3e:	67c2                	ld	a5,16(sp)
     b40:	00a78023          	sb	a0,0(a5)
    if (ctx->ungotten >= 0)
     b44:	018da503          	lw	a0,24(s11)
                i++;
     b48:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
     b4a:	30055963          	bgez	a0,e5c <_vscanf_core.constprop.0+0x4e4>
     b4e:	856e                	mv	a0,s11
     b50:	d6fff0ef          	jal	8be <_in_char.part.0>
            while (c != -1 && !isspace(c))
     b54:	27850663          	beq	a0,s8,dc0 <_vscanf_core.constprop.0+0x448>
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     b58:	03950463          	beq	a0,s9,b80 <_vscanf_core.constprop.0+0x208>
     b5c:	47a5                	li	a5,9
     b5e:	02f50163          	beq	a0,a5,b80 <_vscanf_core.constprop.0+0x208>
     b62:	47a9                	li	a5,10
     b64:	00f50e63          	beq	a0,a5,b80 <_vscanf_core.constprop.0+0x208>
     b68:	47ad                	li	a5,11
     b6a:	00f50b63          	beq	a0,a5,b80 <_vscanf_core.constprop.0+0x208>
     b6e:	47b1                	li	a5,12
     b70:	00f50863          	beq	a0,a5,b80 <_vscanf_core.constprop.0+0x208>
     b74:	67c2                	ld	a5,16(sp)
     b76:	0785                	addi	a5,a5,1
     b78:	e83e                	sd	a5,16(sp)
     b7a:	47b5                	li	a5,13
     b7c:	faf51be3          	bne	a0,a5,b32 <_vscanf_core.constprop.0+0x1ba>
            if (!suppress)
     b80:	64098a63          	beqz	s3,11d4 <_vscanf_core.constprop.0+0x85c>
     b84:	7ce6                	ld	s9,120(sp)
     b86:	7d46                	ld	s10,112(sp)
        ctx->ungotten = c;
     b88:	00adac23          	sw	a0,24(s11)
    while (*p)
     b8c:	001bc783          	lbu	a5,1(s7)
     b90:	794a                	ld	s2,176(sp)
     b92:	79aa                	ld	s3,168(sp)
     b94:	6baa                	ld	s7,136(sp)
     b96:	6c0a                	ld	s8,128(sp)
     b98:	e00795e3          	bnez	a5,9a2 <_vscanf_core.constprop.0+0x2a>
     b9c:	b581                	j	9dc <_vscanf_core.constprop.0+0x64>
            _skip_space(ctx);
     b9e:	856e                	mv	a0,s11
     ba0:	f8ea                	sd	s10,112(sp)
     ba2:	d63ff0ef          	jal	904 <_skip_space>
    if (ctx->ungotten >= 0)
     ba6:	018da503          	lw	a0,24(s11)
     baa:	24055063          	bgez	a0,dea <_vscanf_core.constprop.0+0x472>
     bae:	856e                	mv	a0,s11
     bb0:	d0fff0ef          	jal	8be <_in_char.part.0>
            if (c == '-' || c == '+')
     bb4:	fd55069b          	addiw	a3,a0,-43
     bb8:	9af5                	andi	a3,a3,-3
     bba:	2681                	sext.w	a3,a3
            int i = 0, c = _in_char(ctx);
     bbc:	4d01                	li	s10,0
            if (c == '-' || c == '+')
     bbe:	3e068863          	beqz	a3,fae <_vscanf_core.constprop.0+0x636>
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
     bc2:	07800693          	li	a3,120
     bc6:	4641                	li	a2,16
     bc8:	00dc0863          	beq	s8,a3,bd8 <_vscanf_core.constprop.0+0x260>
     bcc:	06900693          	li	a3,105
     bd0:	4629                	li	a2,10
     bd2:	00dc1363          	bne	s8,a3,bd8 <_vscanf_core.constprop.0+0x260>
     bd6:	4601                	li	a2,0
            while (c != -1 && i < 63)
     bd8:	56fd                	li	a3,-1
     bda:	5cd50863          	beq	a0,a3,11aa <_vscanf_core.constprop.0+0x832>
     bde:	fce6                	sd	s9,120(sp)
     be0:	02010893          	addi	a7,sp,32
     be4:	01a88c33          	add	s8,a7,s10
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     be8:	4cc1                	li	s9,16
                int digit = (c >= '0' && c <= '9');
     bea:	fd05069b          	addiw	a3,a0,-48
     bee:	0005031b          	sext.w	t1,a0
     bf2:	00a6b593          	sltiu	a1,a3,10
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     bf6:	27960a63          	beq	a2,s9,e6a <_vscanf_core.constprop.0+0x4f2>
     bfa:	2a060d63          	beqz	a2,eb4 <_vscanf_core.constprop.0+0x53c>
                int x = (c == 'x' || c == 'X');
     bfe:	07800793          	li	a5,120
     c02:	2ef50363          	beq	a0,a5,ee8 <_vscanf_core.constprop.0+0x570>
     c06:	fa850693          	addi	a3,a0,-88
     c0a:	0016b693          	seqz	a3,a3
     c0e:	4301                	li	t1,0
                if (width > 0 && i >= width)
     c10:	01205463          	blez	s2,c18 <_vscanf_core.constprop.0+0x2a0>
     c14:	032d5a63          	bge	s10,s2,c48 <_vscanf_core.constprop.0+0x2d0>
                if (digit || hex || x)
     c18:	0066e6b3          	or	a3,a3,t1
     c1c:	8ecd                	or	a3,a3,a1
     c1e:	c68d                	beqz	a3,c48 <_vscanf_core.constprop.0+0x2d0>
                    num_buf[i++] = (char)c;
     c20:	00ac0023          	sb	a0,0(s8)
    if (ctx->ungotten >= 0)
     c24:	018da503          	lw	a0,24(s11)
                    num_buf[i++] = (char)c;
     c28:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
     c2a:	22055c63          	bgez	a0,e62 <_vscanf_core.constprop.0+0x4ea>
     c2e:	856e                	mv	a0,s11
     c30:	e832                	sd	a2,16(sp)
     c32:	c8dff0ef          	jal	8be <_in_char.part.0>
            while (c != -1 && i < 63)
     c36:	57fd                	li	a5,-1
     c38:	6642                	ld	a2,16(sp)
     c3a:	3cf50263          	beq	a0,a5,ffe <_vscanf_core.constprop.0+0x686>
     c3e:	03f00693          	li	a3,63
     c42:	0c05                	addi	s8,s8,1
     c44:	fadd13e3          	bne	s10,a3,bea <_vscanf_core.constprop.0+0x272>
            num_buf[i] = '\0';
     c48:	040d0793          	addi	a5,s10,64
     c4c:	1018                	addi	a4,sp,32
     c4e:	97ba                	add	a5,a5,a4
     c50:	fc078023          	sb	zero,-64(a5)
        ctx->ungotten = c;
     c54:	00adac23          	sw	a0,24(s11)
     c58:	7ce6                	ld	s9,120(sp)
            if (i == 0)
     c5a:	1e0d0663          	beqz	s10,e46 <_vscanf_core.constprop.0+0x4ce>
            if (!suppress)
     c5e:	36098363          	beqz	s3,fc4 <_vscanf_core.constprop.0+0x64c>
    while (*p)
     c62:	001bc783          	lbu	a5,1(s7)
        {
     c66:	794a                	ld	s2,176(sp)
     c68:	79aa                	ld	s3,168(sp)
     c6a:	6baa                	ld	s7,136(sp)
     c6c:	6c0a                	ld	s8,128(sp)
     c6e:	7d46                	ld	s10,112(sp)
    while (*p)
     c70:	d20799e3          	bnez	a5,9a2 <_vscanf_core.constprop.0+0x2a>
     c74:	b3a5                	j	9dc <_vscanf_core.constprop.0+0x64>
        while (*p >= '0' && *p <= '9')
     c76:	00244583          	lbu	a1,2(s0)
            suppress = 1;
     c7a:	4985                	li	s3,1
            p++;
     c7c:	0409                	addi	s0,s0,2
     c7e:	b3d9                	j	a44 <_vscanf_core.constprop.0+0xcc>
            if (*p == 'l')
     c80:	00144c03          	lbu	s8,1(s0)
            len_mod = 1;
     c84:	4785                	li	a5,1
     c86:	ec3e                	sd	a5,24(sp)
            if (*p == 'l')
     c88:	e0bc17e3          	bne	s8,a1,a96 <_vscanf_core.constprop.0+0x11e>
                len_mod = 2;
     c8c:	4789                	li	a5,2
        char spec = *p++;
     c8e:	00244c03          	lbu	s8,2(s0)
                p++;
     c92:	00240b93          	addi	s7,s0,2
                len_mod = 2;
     c96:	ec3e                	sd	a5,24(sp)
     c98:	bbfd                	j	a96 <_vscanf_core.constprop.0+0x11e>
     c9a:	100c0763          	beqz	s8,da8 <_vscanf_core.constprop.0+0x430>
     c9e:	fbbc079b          	addiw	a5,s8,-69
     ca2:	0ff7f793          	zext.b	a5,a5
     ca6:	4689                	li	a3,2
     ca8:	eef6e2e3          	bltu	a3,a5,b8c <_vscanf_core.constprop.0+0x214>
            _skip_space(ctx);
     cac:	856e                	mv	a0,s11
     cae:	f8ea                	sd	s10,112(sp)
     cb0:	c55ff0ef          	jal	904 <_skip_space>
    if (ctx->ungotten >= 0)
     cb4:	018da783          	lw	a5,24(s11)
     cb8:	1207dd63          	bgez	a5,df2 <_vscanf_core.constprop.0+0x47a>
     cbc:	856e                	mv	a0,s11
     cbe:	c01ff0ef          	jal	8be <_in_char.part.0>
            if (c == '-' || c == '+')
     cc2:	fd55069b          	addiw	a3,a0,-43
     cc6:	ffd6f613          	andi	a2,a3,-3
     cca:	2601                	sext.w	a2,a2
     ccc:	87aa                	mv	a5,a0
     cce:	12060c63          	beqz	a2,e06 <_vscanf_core.constprop.0+0x48e>
            while (c != -1 && i < 63)
     cd2:	567d                	li	a2,-1
     cd4:	16c50963          	beq	a0,a2,e46 <_vscanf_core.constprop.0+0x4ce>
     cd8:	fce6                	sd	s9,120(sp)
            int i = 0, c = _in_char(ctx);
     cda:	4d01                	li	s10,0
     cdc:	80000937          	lui	s2,0x80000
     ce0:	197d                	addi	s2,s2,-1 # ffffffff7fffffff <_ZSt4cerr+0xffffffff7fff8777>
     ce2:	0932                	slli	s2,s2,0xc
     ce4:	80194913          	xori	s2,s2,-2047
     ce8:	093e                	slli	s2,s2,0xf
     cea:	02010813          	addi	a6,sp,32
     cee:	01a80cb3          	add	s9,a6,s10
     cf2:	03a00c13          	li	s8,58
     cf6:	1935                	addi	s2,s2,-19
     cf8:	a831                	j	d14 <_vscanf_core.constprop.0+0x39c>
     cfa:	bc5ff0ef          	jal	8be <_in_char.part.0>
            while (c != -1 && i < 63)
     cfe:	577d                	li	a4,-1
     d00:	87aa                	mv	a5,a0
     d02:	2ee50563          	beq	a0,a4,fec <_vscanf_core.constprop.0+0x674>
     d06:	03f00713          	li	a4,63
     d0a:	0c85                	addi	s9,s9,1
     d0c:	1eed0e63          	beq	s10,a4,f08 <_vscanf_core.constprop.0+0x590>
     d10:	fd57869b          	addiw	a3,a5,-43
        int c = ctx->ungotten;
     d14:	00d95633          	srl	a2,s2,a3
     d18:	856e                	mv	a0,s11
     d1a:	8a05                	andi	a2,a2,1
     d1c:	1edc6663          	bltu	s8,a3,f08 <_vscanf_core.constprop.0+0x590>
     d20:	1e060463          	beqz	a2,f08 <_vscanf_core.constprop.0+0x590>
                    num_buf[i++] = (char)c;
     d24:	00fc8023          	sb	a5,0(s9)
    if (ctx->ungotten >= 0)
     d28:	018da783          	lw	a5,24(s11)
                    num_buf[i++] = (char)c;
     d2c:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
     d2e:	fc07c6e3          	bltz	a5,cfa <_vscanf_core.constprop.0+0x382>
        ctx->ungotten = -1;
     d32:	577d                	li	a4,-1
     d34:	00edac23          	sw	a4,24(s11)
            while (c != -1 && i < 63)
     d38:	b7f9                	j	d06 <_vscanf_core.constprop.0+0x38e>
            if (*p == 'h')
     d3a:	00144c03          	lbu	s8,1(s0)
        int len_mod = 0;
     d3e:	ec02                	sd	zero,24(sp)
            if (*p == 'h')
     d40:	d4bc1be3          	bne	s8,a1,a96 <_vscanf_core.constprop.0+0x11e>
        char spec = *p++;
     d44:	00244c03          	lbu	s8,2(s0)
                p++;
     d48:	00240b93          	addi	s7,s0,2
     d4c:	b3a9                	j	a96 <_vscanf_core.constprop.0+0x11e>
     d4e:	fce6                	sd	s9,120(sp)
     d50:	f8ea                	sd	s10,112(sp)
            int count = (width > 0) ? width : 1;
     d52:	00090c1b          	sext.w	s8,s2
     d56:	0d205a63          	blez	s2,e2a <_vscanf_core.constprop.0+0x4b2>
            char *buf = suppress ? NULL : va_arg(ap, char *);
     d5a:	4d01                	li	s10,0
     d5c:	06098d63          	beqz	s3,dd6 <_vscanf_core.constprop.0+0x45e>
            for (int i = 0; i < count; i++)
     d60:	9c6a                	add	s8,s8,s10
                if (c == -1)
     d62:	5cfd                	li	s9,-1
    if (ctx->ungotten >= 0)
     d64:	018da783          	lw	a5,24(s11)
        ctx->ungotten = -1;
     d68:	856e                	mv	a0,s11
    if (ctx->ungotten >= 0)
     d6a:	0207dc63          	bgez	a5,da2 <_vscanf_core.constprop.0+0x42a>
     d6e:	b51ff0ef          	jal	8be <_in_char.part.0>
     d72:	87aa                	mv	a5,a0
                if (c == -1)
     d74:	0b950d63          	beq	a0,s9,e2e <_vscanf_core.constprop.0+0x4b6>
                if (!suppress)
     d78:	00099463          	bnez	s3,d80 <_vscanf_core.constprop.0+0x408>
                    buf[i] = (char)c;
     d7c:	00fd0023          	sb	a5,0(s10)
            for (int i = 0; i < count; i++)
     d80:	0d05                	addi	s10,s10,1
     d82:	ffac11e3          	bne	s8,s10,d64 <_vscanf_core.constprop.0+0x3ec>
    while (*p)
     d86:	001bc783          	lbu	a5,1(s7)
            if (!suppress)
     d8a:	00099363          	bnez	s3,d90 <_vscanf_core.constprop.0+0x418>
                assigned++;
     d8e:	2b05                	addiw	s6,s6,1
     d90:	794a                	ld	s2,176(sp)
     d92:	79aa                	ld	s3,168(sp)
     d94:	6baa                	ld	s7,136(sp)
     d96:	6c0a                	ld	s8,128(sp)
     d98:	7ce6                	ld	s9,120(sp)
     d9a:	7d46                	ld	s10,112(sp)
    while (*p)
     d9c:	c00793e3          	bnez	a5,9a2 <_vscanf_core.constprop.0+0x2a>
     da0:	b935                	j	9dc <_vscanf_core.constprop.0+0x64>
        ctx->ungotten = -1;
     da2:	019dac23          	sw	s9,24(s11)
                if (c == -1)
     da6:	bfc9                	j	d78 <_vscanf_core.constprop.0+0x400>
     da8:	640e                	ld	s0,192(sp)
     daa:	74ea                	ld	s1,184(sp)
     dac:	794a                	ld	s2,176(sp)
     dae:	79aa                	ld	s3,168(sp)
     db0:	7a0a                	ld	s4,160(sp)
     db2:	6aea                	ld	s5,152(sp)
     db4:	6baa                	ld	s7,136(sp)
     db6:	6c0a                	ld	s8,128(sp)
     db8:	7da6                	ld	s11,104(sp)
     dba:	b135                	j	9e6 <_vscanf_core.constprop.0+0x6e>
        int width = -1;
     dbc:	597d                	li	s2,-1
     dbe:	b975                	j	a7a <_vscanf_core.constprop.0+0x102>
            if (!suppress)
     dc0:	3c099c63          	bnez	s3,1198 <_vscanf_core.constprop.0+0x820>
                buf[i] = '\0';
     dc4:	67e2                	ld	a5,24(sp)
     dc6:	01a786b3          	add	a3,a5,s10
     dca:	00068023          	sb	zero,0(a3)
    while (*p)
     dce:	001bc783          	lbu	a5,1(s7)
                assigned++;
     dd2:	2b05                	addiw	s6,s6,1
     dd4:	bf75                	j	d90 <_vscanf_core.constprop.0+0x418>
            char *buf = suppress ? NULL : va_arg(ap, char *);
     dd6:	67a2                	ld	a5,8(sp)
     dd8:	0007bd03          	ld	s10,0(a5)
     ddc:	07a1                	addi	a5,a5,8
     dde:	e43e                	sd	a5,8(sp)
     de0:	b741                	j	d60 <_vscanf_core.constprop.0+0x3e8>
        ctx->ungotten = -1;
     de2:	56fd                	li	a3,-1
     de4:	00ddac23          	sw	a3,24(s11)
            while (c != -1 && !isspace(c))
     de8:	bb11                	j	afc <_vscanf_core.constprop.0+0x184>
        ctx->ungotten = -1;
     dea:	56fd                	li	a3,-1
     dec:	00ddac23          	sw	a3,24(s11)
        return c;
     df0:	b3d1                	j	bb4 <_vscanf_core.constprop.0+0x23c>
            if (c == '-' || c == '+')
     df2:	fd57869b          	addiw	a3,a5,-43
     df6:	ffd6f613          	andi	a2,a3,-3
        ctx->ungotten = -1;
     dfa:	55fd                	li	a1,-1
     dfc:	00bdac23          	sw	a1,24(s11)
            if (c == '-' || c == '+')
     e00:	2601                	sext.w	a2,a2
     e02:	ec061be3          	bnez	a2,cd8 <_vscanf_core.constprop.0+0x360>
                num_buf[i++] = (char)c;
     e06:	02f10023          	sb	a5,32(sp)
    if (ctx->ungotten >= 0)
     e0a:	018da783          	lw	a5,24(s11)
     e0e:	2207da63          	bgez	a5,1042 <_vscanf_core.constprop.0+0x6ca>
     e12:	856e                	mv	a0,s11
     e14:	aabff0ef          	jal	8be <_in_char.part.0>
            while (c != -1 && i < 63)
     e18:	567d                	li	a2,-1
     e1a:	87aa                	mv	a5,a0
                num_buf[i++] = (char)c;
     e1c:	4d05                	li	s10,1
     e1e:	fd55069b          	addiw	a3,a0,-43
            while (c != -1 && i < 63)
     e22:	3ac50163          	beq	a0,a2,11c4 <_vscanf_core.constprop.0+0x84c>
     e26:	fce6                	sd	s9,120(sp)
     e28:	bd55                	j	cdc <_vscanf_core.constprop.0+0x364>
            int count = (width > 0) ? width : 1;
     e2a:	4c05                	li	s8,1
     e2c:	b73d                	j	d5a <_vscanf_core.constprop.0+0x3e2>
     e2e:	640e                	ld	s0,192(sp)
     e30:	74ea                	ld	s1,184(sp)
     e32:	794a                	ld	s2,176(sp)
     e34:	79aa                	ld	s3,168(sp)
     e36:	7a0a                	ld	s4,160(sp)
     e38:	6aea                	ld	s5,152(sp)
     e3a:	6baa                	ld	s7,136(sp)
     e3c:	6c0a                	ld	s8,128(sp)
     e3e:	7ce6                	ld	s9,120(sp)
     e40:	7d46                	ld	s10,112(sp)
     e42:	7da6                	ld	s11,104(sp)
     e44:	b64d                	j	9e6 <_vscanf_core.constprop.0+0x6e>
     e46:	640e                	ld	s0,192(sp)
     e48:	74ea                	ld	s1,184(sp)
     e4a:	794a                	ld	s2,176(sp)
     e4c:	79aa                	ld	s3,168(sp)
     e4e:	7a0a                	ld	s4,160(sp)
     e50:	6aea                	ld	s5,152(sp)
     e52:	6baa                	ld	s7,136(sp)
     e54:	6c0a                	ld	s8,128(sp)
     e56:	7d46                	ld	s10,112(sp)
     e58:	7da6                	ld	s11,104(sp)
     e5a:	b671                	j	9e6 <_vscanf_core.constprop.0+0x6e>
        ctx->ungotten = -1;
     e5c:	018dac23          	sw	s8,24(s11)
            while (c != -1 && !isspace(c))
     e60:	b9e5                	j	b58 <_vscanf_core.constprop.0+0x1e0>
        ctx->ungotten = -1;
     e62:	57fd                	li	a5,-1
     e64:	00fdac23          	sw	a5,24(s11)
            while (c != -1 && i < 63)
     e68:	bbd9                	j	c3e <_vscanf_core.constprop.0+0x2c6>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     e6a:	f9f3069b          	addiw	a3,t1,-97
     e6e:	4795                	li	a5,5
     e70:	06d7f263          	bgeu	a5,a3,ed4 <_vscanf_core.constprop.0+0x55c>
     e74:	fbf3031b          	addiw	t1,t1,-65
     e78:	4795                	li	a5,5
     e7a:	0467fd63          	bgeu	a5,t1,ed4 <_vscanf_core.constprop.0+0x55c>
                int x = (c == 'x' || c == 'X');
     e7e:	07800693          	li	a3,120
     e82:	18d50763          	beq	a0,a3,1010 <_vscanf_core.constprop.0+0x698>
     e86:	fa850693          	addi	a3,a0,-88
     e8a:	0016b693          	seqz	a3,a3
                if (base == 0 && i == 1 && num_buf[0] == '0' && x)
     e8e:	4301                	li	t1,0
     e90:	32061663          	bnez	a2,11bc <_vscanf_core.constprop.0+0x844>
     e94:	4785                	li	a5,1
     e96:	4601                	li	a2,0
     e98:	d6fd1ce3          	bne	s10,a5,c10 <_vscanf_core.constprop.0+0x298>
     e9c:	02014e03          	lbu	t3,32(sp)
     ea0:	03000793          	li	a5,48
     ea4:	d6fe16e3          	bne	t3,a5,c10 <_vscanf_core.constprop.0+0x298>
     ea8:	d60684e3          	beqz	a3,c10 <_vscanf_core.constprop.0+0x298>
                    base = 16;
     eac:	4641                	li	a2,16
                if (width > 0 && i >= width)
     eae:	d7a919e3          	bne	s2,s10,c20 <_vscanf_core.constprop.0+0x2a8>
     eb2:	bb59                	j	c48 <_vscanf_core.constprop.0+0x2d0>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     eb4:	f9f3069b          	addiw	a3,t1,-97
     eb8:	4795                	li	a5,5
     eba:	02d7f263          	bgeu	a5,a3,ede <_vscanf_core.constprop.0+0x566>
     ebe:	fbf3031b          	addiw	t1,t1,-65
     ec2:	0467f063          	bgeu	a5,t1,f02 <_vscanf_core.constprop.0+0x58a>
                int x = (c == 'x' || c == 'X');
     ec6:	07800693          	li	a3,120
     eca:	fad51ee3          	bne	a0,a3,e86 <_vscanf_core.constprop.0+0x50e>
     ece:	4301                	li	t1,0
     ed0:	4685                	li	a3,1
     ed2:	b7c9                	j	e94 <_vscanf_core.constprop.0+0x51c>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     ed4:	4305                	li	t1,1
                int x = (c == 'x' || c == 'X');
     ed6:	4681                	li	a3,0
                if (width > 0 && i >= width)
     ed8:	d3204ee3          	bgtz	s2,c14 <_vscanf_core.constprop.0+0x29c>
     edc:	bb35                	j	c18 <_vscanf_core.constprop.0+0x2a0>
                int x = (c == 'x' || c == 'X');
     ede:	4681                	li	a3,0
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     ee0:	4305                	li	t1,1
                if (width > 0 && i >= width)
     ee2:	d32049e3          	bgtz	s2,c14 <_vscanf_core.constprop.0+0x29c>
     ee6:	bb0d                	j	c18 <_vscanf_core.constprop.0+0x2a0>
     ee8:	4301                	li	t1,0
                int x = (c == 'x' || c == 'X');
     eea:	4685                	li	a3,1
                if (width > 0 && i >= width)
     eec:	d32044e3          	bgtz	s2,c14 <_vscanf_core.constprop.0+0x29c>
     ef0:	bb05                	j	c20 <_vscanf_core.constprop.0+0x2a8>
            if (!suppress)
     ef2:	c8099be3          	bnez	s3,b88 <_vscanf_core.constprop.0+0x210>
                buf[i] = '\0';
     ef6:	67e2                	ld	a5,24(sp)
     ef8:	00078023          	sb	zero,0(a5)
        ctx->ungotten = c;
     efc:	00adac23          	sw	a0,24(s11)
            if (i > 0 && !suppress)
     f00:	b171                	j	b8c <_vscanf_core.constprop.0+0x214>
                int x = (c == 'x' || c == 'X');
     f02:	4681                	li	a3,0
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     f04:	4305                	li	t1,1
     f06:	b779                	j	e94 <_vscanf_core.constprop.0+0x51c>
            num_buf[i] = '\0';
     f08:	040d0713          	addi	a4,s10,64
     f0c:	1014                	addi	a3,sp,32
     f0e:	96ba                	add	a3,a3,a4
     f10:	fc068023          	sb	zero,-64(a3)
        ctx->ungotten = c;
     f14:	00fdac23          	sw	a5,24(s11)
            if (i == 0)
     f18:	f00d0be3          	beqz	s10,e2e <_vscanf_core.constprop.0+0x4b6>
     f1c:	7ce6                	ld	s9,120(sp)
            if (!suppress)
     f1e:	d40992e3          	bnez	s3,c62 <_vscanf_core.constprop.0+0x2ea>
    if (*str == '-')
     f22:	02014603          	lbu	a2,32(sp)
     f26:	02d00793          	li	a5,45
     f2a:	1af60963          	beq	a2,a5,10dc <_vscanf_core.constprop.0+0x764>
    else if (*str == '+')
     f2e:	02b00793          	li	a5,43
     f32:	20f60a63          	beq	a2,a5,1146 <_vscanf_core.constprop.0+0x7ce>
     f36:	00005797          	auipc	a5,0x5
     f3a:	9327b587          	fld	fa1,-1742(a5) # 5868 <STDIN_FD+0x10>
     f3e:	101c                	addi	a5,sp,32
    while (*str >= '0' && *str <= '9')
     f40:	fd06069b          	addiw	a3,a2,-48
     f44:	0ff6f513          	zext.b	a0,a3
     f48:	45a5                	li	a1,9
     f4a:	f20007d3          	fmv.d.x	fa5,zero
     f4e:	02a5e463          	bltu	a1,a0,f76 <_vscanf_core.constprop.0+0x5fe>
     f52:	00005717          	auipc	a4,0x5
     f56:	91e73707          	fld	fa4,-1762(a4) # 5870 <STDIN_FD+0x18>
     f5a:	4525                	li	a0,9
     f5c:	0017c603          	lbu	a2,1(a5)
        val = val * 10.0 + (*str - '0');
     f60:	d20686d3          	fcvt.d.w	fa3,a3
        str++;
     f64:	0785                	addi	a5,a5,1
    while (*str >= '0' && *str <= '9')
     f66:	fd06069b          	addiw	a3,a2,-48
     f6a:	0ff6f593          	zext.b	a1,a3
        val = val * 10.0 + (*str - '0');
     f6e:	6ae7f7c3          	fmadd.d	fa5,fa5,fa4,fa3
    while (*str >= '0' && *str <= '9')
     f72:	feb575e3          	bgeu	a0,a1,f5c <_vscanf_core.constprop.0+0x5e4>
    if (*str == '.')
     f76:	02e00693          	li	a3,46
     f7a:	16d60a63          	beq	a2,a3,10ee <_vscanf_core.constprop.0+0x776>
    if (*str == 'e' || *str == 'E')
     f7e:	0007c683          	lbu	a3,0(a5)
     f82:	0df6f693          	andi	a3,a3,223
     f86:	04500613          	li	a2,69
     f8a:	0cc68463          	beq	a3,a2,1052 <_vscanf_core.constprop.0+0x6da>
                    *va_arg(ap, double *) = val;
     f8e:	6722                	ld	a4,8(sp)
                if (len_mod == 1)
     f90:	4685                	li	a3,1
    return sign * val;
     f92:	12b7f7d3          	fmul.d	fa5,fa5,fa1
                    *va_arg(ap, double *) = val;
     f96:	631c                	ld	a5,0(a4)
                    *va_arg(ap, int64 *) = val;
     f98:	0721                	addi	a4,a4,8
     f9a:	e43a                	sd	a4,8(sp)
                if (len_mod == 1)
     f9c:	6762                	ld	a4,24(sp)
     f9e:	18d70b63          	beq	a4,a3,1134 <_vscanf_core.constprop.0+0x7bc>
                    *va_arg(ap, float *) = (float)val;
     fa2:	4017f7d3          	fcvt.s.d	fa5,fa5
                assigned++;
     fa6:	2b05                	addiw	s6,s6,1
                    *va_arg(ap, float *) = (float)val;
     fa8:	00f7a027          	fsw	fa5,0(a5)
     fac:	b95d                	j	c62 <_vscanf_core.constprop.0+0x2ea>
                num_buf[i++] = (char)c;
     fae:	02a10023          	sb	a0,32(sp)
    if (ctx->ungotten >= 0)
     fb2:	018da503          	lw	a0,24(s11)
     fb6:	06055463          	bgez	a0,101e <_vscanf_core.constprop.0+0x6a6>
     fba:	856e                	mv	a0,s11
     fbc:	903ff0ef          	jal	8be <_in_char.part.0>
                num_buf[i++] = (char)c;
     fc0:	4d05                	li	s10,1
     fc2:	b101                	j	bc2 <_vscanf_core.constprop.0+0x24a>
                int64 val = strtoll(num_buf, NULL, base);
     fc4:	4581                	li	a1,0
     fc6:	1008                	addi	a0,sp,32
     fc8:	696030ef          	jal	465e <strtoll>
                    *va_arg(ap, int64 *) = val;
     fcc:	67a2                	ld	a5,8(sp)
                if (len_mod == 2)
     fce:	6762                	ld	a4,24(sp)
     fd0:	4689                	li	a3,2
                    *va_arg(ap, int64 *) = val;
     fd2:	07a1                	addi	a5,a5,8
                if (len_mod == 2)
     fd4:	16d70363          	beq	a4,a3,113a <_vscanf_core.constprop.0+0x7c2>
                    *va_arg(ap, int64 *) = val;
     fd8:	6722                	ld	a4,8(sp)
                else if (len_mod == 1)
     fda:	4605                	li	a2,1
                    *va_arg(ap, int64 *) = val;
     fdc:	6314                	ld	a3,0(a4)
                else if (len_mod == 1)
     fde:	6762                	ld	a4,24(sp)
     fe0:	16c70163          	beq	a4,a2,1142 <_vscanf_core.constprop.0+0x7ca>
                    *va_arg(ap, int *) = (int)val;
     fe4:	c288                	sw	a0,0(a3)
                assigned++;
     fe6:	2b05                	addiw	s6,s6,1
     fe8:	e43e                	sd	a5,8(sp)
     fea:	b9a5                	j	c62 <_vscanf_core.constprop.0+0x2ea>
            num_buf[i] = '\0';
     fec:	040d0793          	addi	a5,s10,64
     ff0:	1018                	addi	a4,sp,32
     ff2:	00e785b3          	add	a1,a5,a4
     ff6:	fc058023          	sb	zero,-64(a1)
            if (i == 0)
     ffa:	7ce6                	ld	s9,120(sp)
     ffc:	b70d                	j	f1e <_vscanf_core.constprop.0+0x5a6>
            num_buf[i] = '\0';
     ffe:	040d0793          	addi	a5,s10,64
    1002:	1018                	addi	a4,sp,32
    1004:	00e78833          	add	a6,a5,a4
    1008:	fc080023          	sb	zero,-64(a6)
            if (i == 0)
    100c:	7ce6                	ld	s9,120(sp)
    100e:	b981                	j	c5e <_vscanf_core.constprop.0+0x2e6>
                int x = (c == 'x' || c == 'X');
    1010:	4301                	li	t1,0
    1012:	4685                	li	a3,1
                if (width > 0 && i >= width)
    1014:	c12040e3          	bgtz	s2,c14 <_vscanf_core.constprop.0+0x29c>
    1018:	b101                	j	c18 <_vscanf_core.constprop.0+0x2a0>
    int assigned = 0;
    101a:	4b01                	li	s6,0
    101c:	b2e9                	j	9e6 <_vscanf_core.constprop.0+0x6e>
        ctx->ungotten = -1;
    101e:	56fd                	li	a3,-1
    1020:	fce6                	sd	s9,120(sp)
    1022:	00ddac23          	sw	a3,24(s11)
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
    1026:	07800693          	li	a3,120
    102a:	4641                	li	a2,16
                num_buf[i++] = (char)c;
    102c:	4d05                	li	s10,1
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
    102e:	badc09e3          	beq	s8,a3,be0 <_vscanf_core.constprop.0+0x268>
    1032:	06900693          	li	a3,105
    1036:	4629                	li	a2,10
                num_buf[i++] = (char)c;
    1038:	4d05                	li	s10,1
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
    103a:	badc13e3          	bne	s8,a3,be0 <_vscanf_core.constprop.0+0x268>
    103e:	4601                	li	a2,0
    1040:	b645                	j	be0 <_vscanf_core.constprop.0+0x268>
        ctx->ungotten = -1;
    1042:	56fd                	li	a3,-1
    1044:	fce6                	sd	s9,120(sp)
    1046:	00ddac23          	sw	a3,24(s11)
                num_buf[i++] = (char)c;
    104a:	4d05                	li	s10,1
    104c:	fd57869b          	addiw	a3,a5,-43
    1050:	b171                	j	cdc <_vscanf_core.constprop.0+0x364>
        if (*str == '-')
    1052:	0017c583          	lbu	a1,1(a5)
    1056:	02d00693          	li	a3,45
    105a:	0ed58f63          	beq	a1,a3,1158 <_vscanf_core.constprop.0+0x7e0>
        else if (*str == '+')
    105e:	02b00693          	li	a3,43
    1062:	10d58e63          	beq	a1,a3,117e <_vscanf_core.constprop.0+0x806>
        while (*str >= '0' && *str <= '9')
    1066:	fd05861b          	addiw	a2,a1,-48
    106a:	0ff67513          	zext.b	a0,a2
    106e:	45a5                	li	a1,9
        str++;
    1070:	00178693          	addi	a3,a5,1
        int esign = 1;
    1074:	4805                	li	a6,1
        while (*str >= '0' && *str <= '9')
    1076:	04a5ec63          	bltu	a1,a0,10ce <_vscanf_core.constprop.0+0x756>
    107a:	4525                	li	a0,9
    107c:	0016c583          	lbu	a1,1(a3)
            eval = eval * 10 + (*str - '0');
    1080:	0029979b          	slliw	a5,s3,0x2
    1084:	013787bb          	addw	a5,a5,s3
    1088:	0017979b          	slliw	a5,a5,0x1
    108c:	00f609bb          	addw	s3,a2,a5
        while (*str >= '0' && *str <= '9')
    1090:	fd05861b          	addiw	a2,a1,-48
    1094:	0ff67593          	zext.b	a1,a2
            str++;
    1098:	0685                	addi	a3,a3,1
        while (*str >= '0' && *str <= '9')
    109a:	feb571e3          	bgeu	a0,a1,107c <_vscanf_core.constprop.0+0x704>
        while (eval--)
    109e:	fff9879b          	addiw	a5,s3,-1
    10a2:	12098463          	beqz	s3,11ca <_vscanf_core.constprop.0+0x852>
        double p = 1.0;
    10a6:	00004717          	auipc	a4,0x4
    10aa:	7c273687          	fld	fa3,1986(a4) # 5868 <STDIN_FD+0x10>
    10ae:	00004717          	auipc	a4,0x4
    10b2:	7c273707          	fld	fa4,1986(a4) # 5870 <STDIN_FD+0x18>
        while (eval--)
    10b6:	56fd                	li	a3,-1
    10b8:	37fd                	addiw	a5,a5,-1
            p *= 10.0;
    10ba:	12e6f6d3          	fmul.d	fa3,fa3,fa4
        while (eval--)
    10be:	fed79de3          	bne	a5,a3,10b8 <_vscanf_core.constprop.0+0x740>
        if (esign == 1)
    10c2:	4785                	li	a5,1
    10c4:	00f80963          	beq	a6,a5,10d6 <_vscanf_core.constprop.0+0x75e>
            val /= p;
    10c8:	1ad7f7d3          	fdiv.d	fa5,fa5,fa3
    10cc:	b5c9                	j	f8e <_vscanf_core.constprop.0+0x616>
        double p = 1.0;
    10ce:	00004797          	auipc	a5,0x4
    10d2:	79a7b687          	fld	fa3,1946(a5) # 5868 <STDIN_FD+0x10>
            val *= p;
    10d6:	12d7f7d3          	fmul.d	fa5,fa5,fa3
    10da:	bd55                	j	f8e <_vscanf_core.constprop.0+0x616>
    while (*str >= '0' && *str <= '9')
    10dc:	00004797          	auipc	a5,0x4
    10e0:	7847b587          	fld	fa1,1924(a5) # 5860 <STDIN_FD+0x8>
    10e4:	02114603          	lbu	a2,33(sp)
        str++;
    10e8:	02110793          	addi	a5,sp,33
    10ec:	bd91                	j	f40 <_vscanf_core.constprop.0+0x5c8>
        while (*str >= '0' && *str <= '9')
    10ee:	0017c683          	lbu	a3,1(a5)
    10f2:	45a5                	li	a1,9
        str++;
    10f4:	0785                	addi	a5,a5,1
        while (*str >= '0' && *str <= '9')
    10f6:	fd06861b          	addiw	a2,a3,-48
    10fa:	0ff67513          	zext.b	a0,a2
    10fe:	e8a5e2e3          	bltu	a1,a0,f82 <_vscanf_core.constprop.0+0x60a>
        double div = 10.0;
    1102:	00004717          	auipc	a4,0x4
    1106:	76e73707          	fld	fa4,1902(a4) # 5870 <STDIN_FD+0x18>
    110a:	22e70653          	fmv.d	fa2,fa4
        while (*str >= '0' && *str <= '9')
    110e:	4525                	li	a0,9
            val += (*str - '0') / div;
    1110:	d20606d3          	fcvt.d.w	fa3,a2
        while (*str >= '0' && *str <= '9')
    1114:	0017c683          	lbu	a3,1(a5)
            str++;
    1118:	0785                	addi	a5,a5,1
            val += (*str - '0') / div;
    111a:	1ac6f6d3          	fdiv.d	fa3,fa3,fa2
        while (*str >= '0' && *str <= '9')
    111e:	fd06861b          	addiw	a2,a3,-48
    1122:	0ff67593          	zext.b	a1,a2
            div *= 10.0;
    1126:	12e67653          	fmul.d	fa2,fa2,fa4
            val += (*str - '0') / div;
    112a:	02d7f7d3          	fadd.d	fa5,fa5,fa3
        while (*str >= '0' && *str <= '9')
    112e:	feb571e3          	bgeu	a0,a1,1110 <_vscanf_core.constprop.0+0x798>
    1132:	bd81                	j	f82 <_vscanf_core.constprop.0+0x60a>
                    *va_arg(ap, double *) = val;
    1134:	a39c                	fsd	fa5,0(a5)
                assigned++;
    1136:	2b05                	addiw	s6,s6,1
    1138:	b62d                	j	c62 <_vscanf_core.constprop.0+0x2ea>
                    *va_arg(ap, int64 *) = val;
    113a:	6722                	ld	a4,8(sp)
    113c:	6314                	ld	a3,0(a4)
    113e:	e288                	sd	a0,0(a3)
    1140:	b55d                	j	fe6 <_vscanf_core.constprop.0+0x66e>
                    *va_arg(ap, long *) = (long)val;
    1142:	e288                	sd	a0,0(a3)
    1144:	b54d                	j	fe6 <_vscanf_core.constprop.0+0x66e>
    while (*str >= '0' && *str <= '9')
    1146:	00004797          	auipc	a5,0x4
    114a:	7227b587          	fld	fa1,1826(a5) # 5868 <STDIN_FD+0x10>
    114e:	02114603          	lbu	a2,33(sp)
        str++;
    1152:	02110793          	addi	a5,sp,33
    1156:	b3ed                	j	f40 <_vscanf_core.constprop.0+0x5c8>
        while (*str >= '0' && *str <= '9')
    1158:	0027c583          	lbu	a1,2(a5)
            str++;
    115c:	00278693          	addi	a3,a5,2
        while (*str >= '0' && *str <= '9')
    1160:	4525                	li	a0,9
    1162:	fd05861b          	addiw	a2,a1,-48
    1166:	0ff67793          	zext.b	a5,a2
            esign = -1;
    116a:	587d                	li	a6,-1
        while (*str >= '0' && *str <= '9')
    116c:	f0f577e3          	bgeu	a0,a5,107a <_vscanf_core.constprop.0+0x702>
        double p = 1.0;
    1170:	00004797          	auipc	a5,0x4
    1174:	6f87b687          	fld	fa3,1784(a5) # 5868 <STDIN_FD+0x10>
            val /= p;
    1178:	1ad7f7d3          	fdiv.d	fa5,fa5,fa3
    117c:	bd09                	j	f8e <_vscanf_core.constprop.0+0x616>
        while (*str >= '0' && *str <= '9')
    117e:	0027c583          	lbu	a1,2(a5)
            str++;
    1182:	00278693          	addi	a3,a5,2
        while (*str >= '0' && *str <= '9')
    1186:	4525                	li	a0,9
    1188:	fd05861b          	addiw	a2,a1,-48
    118c:	0ff67793          	zext.b	a5,a2
    1190:	f2f56fe3          	bltu	a0,a5,10ce <_vscanf_core.constprop.0+0x756>
        int esign = 1;
    1194:	4805                	li	a6,1
    1196:	b5d5                	j	107a <_vscanf_core.constprop.0+0x702>
    while (*p)
    1198:	001bc783          	lbu	a5,1(s7)
    119c:	bed5                	j	d90 <_vscanf_core.constprop.0+0x418>
            if (!suppress)
    119e:	9e0997e3          	bnez	s3,b8c <_vscanf_core.constprop.0+0x214>
                buf[i] = '\0';
    11a2:	67e2                	ld	a5,24(sp)
    11a4:	00078023          	sb	zero,0(a5)
    11a8:	b2d5                	j	b8c <_vscanf_core.constprop.0+0x214>
            num_buf[i] = '\0';
    11aa:	040d0793          	addi	a5,s10,64
    11ae:	1018                	addi	a4,sp,32
    11b0:	97ba                	add	a5,a5,a4
    11b2:	fc078023          	sb	zero,-64(a5)
            if (i == 0)
    11b6:	aa0d14e3          	bnez	s10,c5e <_vscanf_core.constprop.0+0x2e6>
    11ba:	b171                	j	e46 <_vscanf_core.constprop.0+0x4ce>
    11bc:	4641                	li	a2,16
                if (width > 0 && i >= width)
    11be:	a5204be3          	bgtz	s2,c14 <_vscanf_core.constprop.0+0x29c>
    11c2:	bc99                	j	c18 <_vscanf_core.constprop.0+0x2a0>
            num_buf[i] = '\0';
    11c4:	020100a3          	sb	zero,33(sp)
            if (i == 0)
    11c8:	bb99                	j	f1e <_vscanf_core.constprop.0+0x5a6>
        double p = 1.0;
    11ca:	00004797          	auipc	a5,0x4
    11ce:	69e7b687          	fld	fa3,1694(a5) # 5868 <STDIN_FD+0x10>
    11d2:	bdc5                	j	10c2 <_vscanf_core.constprop.0+0x74a>
                buf[i] = '\0';
    11d4:	67e2                	ld	a5,24(sp)
    11d6:	01a786b3          	add	a3,a5,s10
    11da:	00068023          	sb	zero,0(a3)
        ctx->ungotten = c;
    11de:	00adac23          	sw	a0,24(s11)
    while (*p)
    11e2:	001bc783          	lbu	a5,1(s7)
    11e6:	b6f5                	j	dd2 <_vscanf_core.constprop.0+0x45a>

00000000000011e8 <_out_char>:
{
    11e8:	7179                	addi	sp,sp,-48
    11ea:	ec26                	sd	s1,24(sp)
    if (ctx->stream)
    11ec:	6d04                	ld	s1,24(a0)
{
    11ee:	f022                	sd	s0,32(sp)
    11f0:	f406                	sd	ra,40(sp)
    11f2:	842a                	mv	s0,a0
    11f4:	872e                	mv	a4,a1
    if (ctx->stream)
    11f6:	c0a1                	beqz	s1,1236 <_out_char+0x4e>
    11f8:	e84a                	sd	s2,16(sp)
    if (stream->buf_mode == 2)
    11fa:	41c4a903          	lw	s2,1052(s1)
    11fe:	4789                	li	a5,2
    1200:	04f90d63          	beq	s2,a5,125a <_out_char+0x72>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    1204:	4104a783          	lw	a5,1040(s1)
    if (stream->buf_write_pos >= BUFSIZ)
    1208:	3ff00693          	li	a3,1023
    stream->buffer[stream->buf_write_pos++] = (char)c;
    120c:	0017861b          	addiw	a2,a5,1
    1210:	40c4a823          	sw	a2,1040(s1)
    1214:	97a6                	add	a5,a5,s1
    1216:	00b78823          	sb	a1,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    121a:	08c6c063          	blt	a3,a2,129a <_out_char+0xb2>
    else if (stream->buf_mode == 1 && c == '\n')
    121e:	4785                	li	a5,1
    1220:	04f90a63          	beq	s2,a5,1274 <_out_char+0x8c>
        ctx->written++;
    1224:	681c                	ld	a5,16(s0)
    1226:	6942                	ld	s2,16(sp)
}
    1228:	70a2                	ld	ra,40(sp)
        ctx->written++;
    122a:	0785                	addi	a5,a5,1
    122c:	e81c                	sd	a5,16(s0)
}
    122e:	7402                	ld	s0,32(sp)
    1230:	64e2                	ld	s1,24(sp)
    1232:	6145                	addi	sp,sp,48
    1234:	8082                	ret
        if (ctx->limit > 0 && ctx->written < ctx->limit - 1)
    1236:	6514                	ld	a3,8(a0)
    1238:	691c                	ld	a5,16(a0)
    123a:	ca89                	beqz	a3,124c <_out_char+0x64>
    123c:	16fd                	addi	a3,a3,-1
    123e:	00d7f763          	bgeu	a5,a3,124c <_out_char+0x64>
            ctx->buf[ctx->written] = c;
    1242:	6114                	ld	a3,0(a0)
    1244:	97b6                	add	a5,a5,a3
    1246:	00b78023          	sb	a1,0(a5)
        ctx->written++;
    124a:	691c                	ld	a5,16(a0)
    124c:	0785                	addi	a5,a5,1
}
    124e:	70a2                	ld	ra,40(sp)
        ctx->written++;
    1250:	e81c                	sd	a5,16(s0)
}
    1252:	7402                	ld	s0,32(sp)
    1254:	64e2                	ld	s1,24(sp)
    1256:	6145                	addi	sp,sp,48
    1258:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    125a:	4088                	lw	a0,0(s1)
    125c:	4605                	li	a2,1
    125e:	00f10593          	addi	a1,sp,15
        char ch = (char)c;
    1262:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    1266:	e8bfe0ef          	jal	f0 <write>
    126a:	4785                	li	a5,1
    126c:	faf50ce3          	beq	a0,a5,1224 <_out_char+0x3c>
            stream->error = 1;
    1270:	c49c                	sw	a5,8(s1)
            return EOF;
    1272:	bf4d                	j	1224 <_out_char+0x3c>
    else if (stream->buf_mode == 1 && c == '\n')
    1274:	47a9                	li	a5,10
    1276:	faf597e3          	bne	a1,a5,1224 <_out_char+0x3c>
    if (stream->buf_write_pos > 0)
    127a:	fac055e3          	blez	a2,1224 <_out_char+0x3c>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    127e:	4088                	lw	a0,0(s1)
    1280:	01048593          	addi	a1,s1,16
    1284:	e6dfe0ef          	jal	f0 <write>
        if (ret < stream->buf_write_pos)
    1288:	4104a783          	lw	a5,1040(s1)
    128c:	02f55063          	bge	a0,a5,12ac <_out_char+0xc4>
            stream->error = 1;
    1290:	0124a423          	sw	s2,8(s1)
            stream->buf_write_pos = 0;
    1294:	4004a823          	sw	zero,1040(s1)
            return EOF;
    1298:	b771                	j	1224 <_out_char+0x3c>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    129a:	4088                	lw	a0,0(s1)
    129c:	01048593          	addi	a1,s1,16
    12a0:	e51fe0ef          	jal	f0 <write>
        if (ret < stream->buf_write_pos)
    12a4:	4104a783          	lw	a5,1040(s1)
    12a8:	00f54563          	blt	a0,a5,12b2 <_out_char+0xca>
        stream->buf_write_pos = 0;
    12ac:	4004a823          	sw	zero,1040(s1)
    12b0:	bf95                	j	1224 <_out_char+0x3c>
            stream->error = 1;
    12b2:	4785                	li	a5,1
    12b4:	c49c                	sw	a5,8(s1)
            stream->buf_write_pos = 0;
    12b6:	4004a823          	sw	zero,1040(s1)
            return EOF;
    12ba:	b7ad                	j	1224 <_out_char+0x3c>

00000000000012bc <stbsp_set_separators>:
   "75767778798081828384858687888990919293949596979899"
};

STBSP__PUBLICDEF void STB_SPRINTF_DECORATE(set_separators)(char pcomma, char pperiod)
{
   stbsp__period = pperiod;
    12bc:	00005797          	auipc	a5,0x5
    12c0:	6d478793          	addi	a5,a5,1748 # 6990 <stbsp__digitpair>
    12c4:	0cb78623          	sb	a1,204(a5)
   stbsp__comma = pcomma;
    12c8:	0ca786a3          	sb	a0,205(a5)
}
    12cc:	8082                	ret

00000000000012ce <stbsp_vsprintfcb>:

   return (stbsp__uint32)(sn - s);
}

STBSP__PUBLICDEF int STB_SPRINTF_DECORATE(vsprintfcb)(STBSP_SPRINTFCB *callback, void *user, char *buf, char const *fmt, va_list va)
{
    12ce:	d1010113          	addi	sp,sp,-752
            // Check if the next 4 bytes contain %(0x25) or end of string.
            // Using the 'hasless' trick:
            // https://graphics.stanford.edu/~seander/bithacks.html#HasLessInWord
            stbsp__uint32 v, c;
            v = *(stbsp__uint32 *)f;
            c = (~v) & 0x80808080;
    12d2:	808087b7          	lui	a5,0x80808
            if (((v ^ 0x25252525) - 0x01010101) & c)
    12d6:	252523b7          	lui	t2,0x25252
    12da:	52538393          	addi	t2,t2,1317 # 25252525 <_ZSt4cerr+0x2524ac9d>
{
    12de:	29913c23          	sd	s9,664(sp)
    12e2:	29b13423          	sd	s11,648(sp)
   int tlen = 0;
    12e6:	4c81                	li	s9,0
            if (((v ^ 0x25252525) - 0x01010101) & c)
    12e8:	feff0db7          	lui	s11,0xfeff0
            c = (~v) & 0x80808080;
    12ec:	08078793          	addi	a5,a5,128 # ffffffff80808080 <_ZSt4cerr+0xffffffff808007f8>
{
    12f0:	2e813023          	sd	s0,736(sp)
    12f4:	2c913c23          	sd	s1,728(sp)
    12f8:	2d213823          	sd	s2,720(sp)
    12fc:	2d313423          	sd	s3,712(sp)
    1300:	2b713423          	sd	s7,680(sp)
    1304:	2b813023          	sd	s8,672(sp)
    1308:	29a13823          	sd	s10,656(sp)
    130c:	2e113423          	sd	ra,744(sp)
    1310:	8d66                	mv	s10,s9
    1312:	8432                	mv	s0,a2
    1314:	8c9e                	mv	s9,t2
    1316:	89aa                	mv	s3,a0
    1318:	e42e                	sd	a1,8(sp)
    131a:	84b6                	mv	s1,a3
    131c:	8bba                	mv	s7,a4
    131e:	fc02                	sd	zero,56(sp)
   for (;;) {
    1320:	8932                	mv	s2,a2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    1322:	effd8d9b          	addiw	s11,s11,-257 # fffffffffefefeff <_ZSt4cerr+0xfffffffffefe8677>
               goto schk1;
            if ((v - 0x01010101) & c)
               goto schk2;
            if (callback)
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    1326:	20000c13          	li	s8,512
    132a:	83be                	mv	t2,a5
         while (((stbsp__uintptr)f) & 3) {
    132c:	0034f793          	andi	a5,s1,3
    1330:	c7a9                	beqz	a5,137a <stbsp_vsprintfcb+0xac>
            if (f[0] == '%')
    1332:	0004c783          	lbu	a5,0(s1)
    1336:	02500713          	li	a4,37
    133a:	0ee78263          	beq	a5,a4,141e <stbsp_vsprintfcb+0x150>
            if (f[0] == 0)
    133e:	cbd9                	beqz	a5,13d4 <stbsp_vsprintfcb+0x106>
            stbsp__chk_cb_buf(1);
    1340:	02098663          	beqz	s3,136c <stbsp_vsprintfcb+0x9e>
    1344:	4124063b          	subw	a2,s0,s2
    1348:	1fe00713          	li	a4,510
    134c:	02c75063          	bge	a4,a2,136c <stbsp_vsprintfcb+0x9e>
    1350:	65a2                	ld	a1,8(sp)
    1352:	854a                	mv	a0,s2
    1354:	e81e                	sd	t2,16(sp)
    1356:	00cd0d3b          	addw	s10,s10,a2
    135a:	9982                	jalr	s3
    135c:	892a                	mv	s2,a0
    135e:	e119                	bnez	a0,1364 <stbsp_vsprintfcb+0x96>
    1360:	0200106f          	j	2380 <stbsp_vsprintfcb+0x10b2>
            *bf++ = f[0];
    1364:	0004c783          	lbu	a5,0(s1)
            stbsp__chk_cb_buf(1);
    1368:	63c2                	ld	t2,16(sp)
    136a:	842a                	mv	s0,a0
            ++f;
    136c:	0485                	addi	s1,s1,1
            *bf++ = f[0];
    136e:	00f40023          	sb	a5,0(s0)
         while (((stbsp__uintptr)f) & 3) {
    1372:	0034f793          	andi	a5,s1,3
            *bf++ = f[0];
    1376:	0405                	addi	s0,s0,1
         while (((stbsp__uintptr)f) & 3) {
    1378:	ffcd                	bnez	a5,1332 <stbsp_vsprintfcb+0x64>
            v = *(stbsp__uint32 *)f;
    137a:	4094                	lw	a3,0(s1)
            c = (~v) & 0x80808080;
    137c:	fff6c793          	not	a5,a3
            if (((v ^ 0x25252525) - 0x01010101) & c)
    1380:	0196c733          	xor	a4,a3,s9
            c = (~v) & 0x80808080;
    1384:	0077f7b3          	and	a5,a5,t2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    1388:	01b7073b          	addw	a4,a4,s11
    138c:	8f7d                	and	a4,a4,a5
    138e:	2701                	sext.w	a4,a4
    1390:	f34d                	bnez	a4,1332 <stbsp_vsprintfcb+0x64>
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    1392:	460d                	li	a2,3
    1394:	a805                	j	13c4 <stbsp_vsprintfcb+0xf6>
            if (callback)
    1396:	00098863          	beqz	s3,13a6 <stbsp_vsprintfcb+0xd8>
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    139a:	412407b3          	sub	a5,s0,s2
    139e:	40fc07bb          	subw	a5,s8,a5
    13a2:	f8f658e3          	bge	a2,a5,1332 <stbsp_vsprintfcb+0x64>
                    bf[2] = f[2];
                    bf[3] = f[3];
                } else
            #endif
            {
                *(stbsp__uint32 *)bf = v;
    13a6:	c014                	sw	a3,0(s0)
            v = *(stbsp__uint32 *)f;
    13a8:	40d4                	lw	a3,4(s1)
            }
            bf += 4;
    13aa:	0411                	addi	s0,s0,4
            f += 4;
    13ac:	0491                	addi	s1,s1,4
            c = (~v) & 0x80808080;
    13ae:	fff6c793          	not	a5,a3
            if (((v ^ 0x25252525) - 0x01010101) & c)
    13b2:	0196c733          	xor	a4,a3,s9
            c = (~v) & 0x80808080;
    13b6:	0077f7b3          	and	a5,a5,t2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    13ba:	01b7073b          	addw	a4,a4,s11
    13be:	8f7d                	and	a4,a4,a5
    13c0:	2701                	sext.w	a4,a4
    13c2:	fb25                	bnez	a4,1332 <stbsp_vsprintfcb+0x64>
            if ((v - 0x01010101) & c)
    13c4:	01b6873b          	addw	a4,a3,s11
    13c8:	8ff9                	and	a5,a5,a4
    13ca:	2781                	sext.w	a5,a5
    13cc:	d7e9                	beqz	a5,1396 <stbsp_vsprintfcb+0xc8>
            if (f[0] == 0)
    13ce:	0004c783          	lbu	a5,0(s1)
    13d2:	f7bd                	bnez	a5,1340 <stbsp_vsprintfcb+0x72>
endfmt:

   if (!callback)
      *bf = 0;
   else
      stbsp__flush_cb();
    13d4:	8cea                	mv	s9,s10
    13d6:	412404bb          	subw	s1,s0,s2
   if (!callback)
    13da:	70098563          	beqz	s3,1ae4 <stbsp_vsprintfcb+0x816>
      stbsp__flush_cb();
    13de:	00905663          	blez	s1,13ea <stbsp_vsprintfcb+0x11c>
    13e2:	65a2                	ld	a1,8(sp)
    13e4:	8626                	mv	a2,s1
    13e6:	854a                	mv	a0,s2
    13e8:	9982                	jalr	s3
    13ea:	009c8cbb          	addw	s9,s9,s1

done:
   return tlen + (int)(bf - buf);
}
    13ee:	2e813083          	ld	ra,744(sp)
    13f2:	2e013403          	ld	s0,736(sp)
    13f6:	2d813483          	ld	s1,728(sp)
    13fa:	2d013903          	ld	s2,720(sp)
    13fe:	2c813983          	ld	s3,712(sp)
    1402:	2a813b83          	ld	s7,680(sp)
    1406:	2a013c03          	ld	s8,672(sp)
    140a:	29013d03          	ld	s10,656(sp)
    140e:	28813d83          	ld	s11,648(sp)
    1412:	8566                	mv	a0,s9
    1414:	29813c83          	ld	s9,664(sp)
    1418:	2f010113          	addi	sp,sp,752
    141c:	8082                	ret
    141e:	2d413023          	sd	s4,704(sp)
    1422:	2b513c23          	sd	s5,696(sp)
    1426:	2b613823          	sd	s6,688(sp)
      tz = 0;
    142a:	00248693          	addi	a3,s1,2
      fl = 0;
    142e:	4e01                	li	t3,0
         switch (f[0]) {
    1430:	03f00593          	li	a1,63
    1434:	00004617          	auipc	a2,0x4
    1438:	d5460613          	addi	a2,a2,-684 # 5188 <_GLOBAL__sub_I__ZSt3cin+0x198>
    143c:	fff6c783          	lbu	a5,-1(a3)
    1440:	fff68493          	addi	s1,a3,-1
    1444:	fe07871b          	addiw	a4,a5,-32
    1448:	0ff77713          	zext.b	a4,a4
    144c:	00e5ec63          	bltu	a1,a4,1464 <stbsp_vsprintfcb+0x196>
    1450:	070a                	slli	a4,a4,0x2
    1452:	9732                	add	a4,a4,a2
    1454:	4318                	lw	a4,0(a4)
    1456:	9732                	add	a4,a4,a2
    1458:	8702                	jr	a4
      if (f[0] == '*') {
    145a:	0014c783          	lbu	a5,1(s1)
            fl |= STBSP__LEADINGZERO;
    145e:	010e6e13          	ori	t3,t3,16
            ++f;
    1462:	0485                	addi	s1,s1,1
      if (f[0] == '*') {
    1464:	02a00713          	li	a4,42
    1468:	0ce79163          	bne	a5,a4,152a <stbsp_vsprintfcb+0x25c>
         fw = va_arg(va, stbsp__uint32);
    146c:	000bab03          	lw	s6,0(s7)
         while ((f[0] >= '0') && (f[0] <= '9')) {
    1470:	0014c783          	lbu	a5,1(s1)
         fw = va_arg(va, stbsp__uint32);
    1474:	0ba1                	addi	s7,s7,8
         ++f;
    1476:	0485                	addi	s1,s1,1
      if (f[0] == '.') {
    1478:	02e00713          	li	a4,46
      pr = -1;
    147c:	58fd                	li	a7,-1
      if (f[0] == '.') {
    147e:	0ee78663          	beq	a5,a4,156a <stbsp_vsprintfcb+0x29c>
      switch (f[0]) {
    1482:	04900713          	li	a4,73
    1486:	10e78263          	beq	a5,a4,158a <stbsp_vsprintfcb+0x2bc>
    148a:	f987871b          	addiw	a4,a5,-104
    148e:	0ff77713          	zext.b	a4,a4
    1492:	46c9                	li	a3,18
    1494:	02e6e063          	bltu	a3,a4,14b4 <stbsp_vsprintfcb+0x1e6>
    1498:	00004697          	auipc	a3,0x4
    149c:	df068693          	addi	a3,a3,-528 # 5288 <_GLOBAL__sub_I__ZSt3cin+0x298>
    14a0:	070a                	slli	a4,a4,0x2
    14a2:	9736                	add	a4,a4,a3
    14a4:	4318                	lw	a4,0(a4)
    14a6:	9736                	add	a4,a4,a3
    14a8:	8702                	jr	a4
         if (f[0] == 'h')
    14aa:	0014c783          	lbu	a5,1(s1)
         fl |= (sizeof(ptrdiff_t) == 8) ? STBSP__INTMAX : 0;
    14ae:	020e6e13          	ori	t3,t3,32
         ++f;
    14b2:	0485                	addi	s1,s1,1
      switch (f[0]) {
    14b4:	fbf7871b          	addiw	a4,a5,-65
    14b8:	0ff77713          	zext.b	a4,a4
    14bc:	03700693          	li	a3,55
    14c0:	0ee6ea63          	bltu	a3,a4,15b4 <stbsp_vsprintfcb+0x2e6>
    14c4:	00004697          	auipc	a3,0x4
    14c8:	e1068693          	addi	a3,a3,-496 # 52d4 <_GLOBAL__sub_I__ZSt3cin+0x2e4>
    14cc:	070a                	slli	a4,a4,0x2
    14ce:	9736                	add	a4,a4,a3
    14d0:	4318                	lw	a4,0(a4)
    14d2:	9736                	add	a4,a4,a3
    14d4:	8702                	jr	a4
            fl |= STBSP__METRIC_NOSPACE;
    14d6:	400e6e13          	ori	t3,t3,1024
            continue;
    14da:	0685                	addi	a3,a3,1
    14dc:	b785                	j	143c <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEFTJUST;
    14de:	001e6e13          	ori	t3,t3,1
            continue;
    14e2:	0685                	addi	a3,a3,1
    14e4:	bfa1                	j	143c <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADINGPLUS;
    14e6:	002e6e13          	ori	t3,t3,2
            continue;
    14ea:	0685                	addi	a3,a3,1
    14ec:	bf81                	j	143c <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__TRIPLET_COMMA;
    14ee:	040e6e13          	ori	t3,t3,64
            continue;
    14f2:	0685                	addi	a3,a3,1
    14f4:	b7a1                	j	143c <stbsp_vsprintfcb+0x16e>
            if (fl & STBSP__METRIC_SUFFIX) {
    14f6:	100e7793          	andi	a5,t3,256
    14fa:	8772                	mv	a4,t3
    14fc:	56078363          	beqz	a5,1a62 <stbsp_vsprintfcb+0x794>
               if (fl & STBSP__METRIC_1024) {
    1500:	6785                	lui	a5,0x1
    1502:	034e1513          	slli	a0,t3,0x34
    1506:	80078793          	addi	a5,a5,-2048 # 800 <stbsp__real_to_str+0x616>
    150a:	5c055863          	bgez	a0,1ada <stbsp_vsprintfcb+0x80c>
                  fl |= STBSP__METRIC_JEDEC;
    150e:	6785                	lui	a5,0x1
    1510:	8f5d                	or	a4,a4,a5
    1512:	00070e1b          	sext.w	t3,a4
    1516:	0685                	addi	a3,a3,1
    1518:	b715                	j	143c <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADING_0X;
    151a:	008e6e13          	ori	t3,t3,8
            continue;
    151e:	0685                	addi	a3,a3,1
    1520:	bf31                	j	143c <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADINGSPACE;
    1522:	004e6e13          	ori	t3,t3,4
            continue;
    1526:	0685                	addi	a3,a3,1
    1528:	bf11                	j	143c <stbsp_vsprintfcb+0x16e>
         while ((f[0] >= '0') && (f[0] <= '9')) {
    152a:	fd07871b          	addiw	a4,a5,-48 # fd0 <_vscanf_core.constprop.0+0x658>
    152e:	0ff77713          	zext.b	a4,a4
    1532:	4625                	li	a2,9
      fw = 0;
    1534:	4b01                	li	s6,0
         while ((f[0] >= '0') && (f[0] <= '9')) {
    1536:	46a5                	li	a3,9
    1538:	f4e660e3          	bltu	a2,a4,1478 <stbsp_vsprintfcb+0x1aa>
            fw = fw * 10 + f[0] - '0';
    153c:	002b171b          	slliw	a4,s6,0x2
    1540:	0167073b          	addw	a4,a4,s6
    1544:	0017171b          	slliw	a4,a4,0x1
            f++;
    1548:	0485                	addi	s1,s1,1
            fw = fw * 10 + f[0] - '0';
    154a:	9f3d                	addw	a4,a4,a5
         while ((f[0] >= '0') && (f[0] <= '9')) {
    154c:	0004c783          	lbu	a5,0(s1)
            fw = fw * 10 + f[0] - '0';
    1550:	fd070b1b          	addiw	s6,a4,-48
         while ((f[0] >= '0') && (f[0] <= '9')) {
    1554:	fd07871b          	addiw	a4,a5,-48
    1558:	0ff77713          	zext.b	a4,a4
    155c:	fee6f0e3          	bgeu	a3,a4,153c <stbsp_vsprintfcb+0x26e>
      if (f[0] == '.') {
    1560:	02e00713          	li	a4,46
      pr = -1;
    1564:	58fd                	li	a7,-1
      if (f[0] == '.') {
    1566:	f0e79ee3          	bne	a5,a4,1482 <stbsp_vsprintfcb+0x1b4>
         if (f[0] == '*') {
    156a:	0014c783          	lbu	a5,1(s1)
    156e:	02a00713          	li	a4,42
    1572:	52e79763          	bne	a5,a4,1aa0 <stbsp_vsprintfcb+0x7d2>
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1576:	0024c783          	lbu	a5,2(s1)
      switch (f[0]) {
    157a:	04900713          	li	a4,73
            pr = va_arg(va, stbsp__uint32);
    157e:	000ba883          	lw	a7,0(s7)
            ++f;
    1582:	0489                	addi	s1,s1,2
            pr = va_arg(va, stbsp__uint32);
    1584:	0ba1                	addi	s7,s7,8
      switch (f[0]) {
    1586:	f0e792e3          	bne	a5,a4,148a <stbsp_vsprintfcb+0x1bc>
         if ((f[1] == '6') && (f[2] == '4')) {
    158a:	0014c783          	lbu	a5,1(s1)
    158e:	03600713          	li	a4,54
    1592:	00e79463          	bne	a5,a4,159a <stbsp_vsprintfcb+0x2cc>
    1596:	1e60106f          	j	277c <stbsp_vsprintfcb+0x14ae>
         } else if ((f[1] == '3') && (f[2] == '2')) {
    159a:	03300713          	li	a4,51
    159e:	6ae796e3          	bne	a5,a4,244a <stbsp_vsprintfcb+0x117c>
    15a2:	0024c683          	lbu	a3,2(s1)
    15a6:	03200713          	li	a4,50
    15aa:	00e69463          	bne	a3,a4,15b2 <stbsp_vsprintfcb+0x2e4>
    15ae:	0ae0106f          	j	265c <stbsp_vsprintfcb+0x138e>
            ++f;
    15b2:	0485                	addi	s1,s1,1
         *s = f[0];
    15b4:	26f10fa3          	sb	a5,639(sp)
         l = 1;
    15b8:	4785                	li	a5,1
    15ba:	d0be                	sw	a5,96(sp)
         lead[0] = 0;
    15bc:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    15c0:	06010823          	sb	zero,112(sp)
         dp = 0;
    15c4:	d282                	sw	zero,100(sp)
    15c6:	e0de                	sd	s7,64(sp)
    15c8:	4701                	li	a4,0
    15ca:	4301                	li	t1,0
    15cc:	4f81                	li	t6,0
    15ce:	4685                	li	a3,1
    15d0:	4a01                	li	s4,0
         cs = 0;
    15d2:	4281                	li	t0,0
         s = num + STBSP__NUMSZ - 1;
    15d4:	27f10a93          	addi	s5,sp,639
         fw = fl = 0;
    15d8:	4e01                	li	t3,0
      tz = 0;
    15da:	4881                	li	a7,0
            if (fl & STBSP__LEADINGZERO) // if leading zeros, everything is in pr
    15dc:	010e7793          	andi	a5,t3,16
    15e0:	40078ee3          	beqz	a5,21fc <stbsp_vsprintfcb+0xf2e>
               pr = (fw > pr) ? fw : pr;
    15e4:	87ba                	mv	a5,a4
    15e6:	00675363          	bge	a4,t1,15ec <stbsp_vsprintfcb+0x31e>
    15ea:	879a                	mv	a5,t1
    15ec:	0007871b          	sext.w	a4,a5
               fw = 0;
    15f0:	4301                	li	t1,0
         if (fw + pr) {
    15f2:	62070563          	beqz	a4,1c1c <stbsp_vsprintfcb+0x94e>
            sn = lead + 1;
    15f6:	06910793          	addi	a5,sp,105
    15fa:	fcbe                	sd	a5,120(sp)
            while (lead[0]) {
    15fc:	0a0a0863          	beqz	s4,16ac <stbsp_vsprintfcb+0x3de>
               stbsp__cb_buf_clamp(i, lead[0]);
    1600:	f026                	sd	s1,32(sp)
    1602:	f436                	sd	a3,40(sp)
    1604:	854a                	mv	a0,s2
    1606:	86d2                	mv	a3,s4
    1608:	84ce                	mv	s1,s3
               stbsp__chk_cb_buf(1);
    160a:	1fe00b93          	li	s7,510
               stbsp__cb_buf_clamp(i, lead[0]);
    160e:	89be                	mv	s3,a5
    1610:	20000b13          	li	s6,512
    1614:	87a2                	mv	a5,s0
    1616:	e846                	sd	a7,16(sp)
    1618:	846a                	mv	s0,s10
    161a:	ec7e                	sd	t6,24(sp)
    161c:	8d6e                	mv	s10,s11
    161e:	f872                	sd	t3,48(sp)
    1620:	8de6                	mv	s11,s9
    1622:	8a3a                	mv	s4,a4
    1624:	e496                	sd	t0,72(sp)
    1626:	891a                	mv	s2,t1
    1628:	8c9e                	mv	s9,t2
    162a:	0006871b          	sext.w	a4,a3
    162e:	2e0482e3          	beqz	s1,2112 <stbsp_vsprintfcb+0xe44>
    1632:	40a7863b          	subw	a2,a5,a0
    1636:	40cb083b          	subw	a6,s6,a2
    163a:	85c2                	mv	a1,a6
    163c:	01075363          	bge	a4,a6,1642 <stbsp_vsprintfcb+0x374>
    1640:	85ba                	mv	a1,a4
               lead[0] -= (char)i;
    1642:	9e8d                	subw	a3,a3,a1
               stbsp__cb_buf_clamp(i, lead[0]);
    1644:	0005871b          	sext.w	a4,a1
               lead[0] -= (char)i;
    1648:	06d10423          	sb	a3,104(sp)
               while (i) {
    164c:	c70d                	beqz	a4,1676 <stbsp_vsprintfcb+0x3a8>
    164e:	7866                	ld	a6,120(sp)
    1650:	02071593          	slli	a1,a4,0x20
    1654:	9181                	srli	a1,a1,0x20
    1656:	00b78633          	add	a2,a5,a1
    165a:	8742                	mv	a4,a6
                  *bf++ = *sn++;
    165c:	00074683          	lbu	a3,0(a4)
    1660:	0785                	addi	a5,a5,1
               while (i) {
    1662:	0705                	addi	a4,a4,1
                  *bf++ = *sn++;
    1664:	fed78fa3          	sb	a3,-1(a5)
               while (i) {
    1668:	fec79ae3          	bne	a5,a2,165c <stbsp_vsprintfcb+0x38e>
    166c:	982e                	add	a6,a6,a1
    166e:	fcc2                	sd	a6,120(sp)
               stbsp__chk_cb_buf(1);
    1670:	c899                	beqz	s1,1686 <stbsp_vsprintfcb+0x3b8>
    1672:	40a7863b          	subw	a2,a5,a0
    1676:	00cbd863          	bge	s7,a2,1686 <stbsp_vsprintfcb+0x3b8>
    167a:	65a2                	ld	a1,8(sp)
    167c:	9c31                	addw	s0,s0,a2
    167e:	9482                	jalr	s1
    1680:	34050ee3          	beqz	a0,21dc <stbsp_vsprintfcb+0xf0e>
    1684:	87aa                	mv	a5,a0
            while (lead[0]) {
    1686:	06814683          	lbu	a3,104(sp)
    168a:	f2c5                	bnez	a3,162a <stbsp_vsprintfcb+0x35c>
    168c:	83e6                	mv	t2,s9
    168e:	68c2                	ld	a7,16(sp)
    1690:	8cee                	mv	s9,s11
    1692:	6fe2                	ld	t6,24(sp)
    1694:	8dea                	mv	s11,s10
    1696:	76a2                	ld	a3,40(sp)
    1698:	8d22                	mv	s10,s0
    169a:	7e42                	ld	t3,48(sp)
    169c:	843e                	mv	s0,a5
    169e:	62a6                	ld	t0,72(sp)
    16a0:	87ce                	mv	a5,s3
    16a2:	89a6                	mv	s3,s1
    16a4:	7482                	ld	s1,32(sp)
    16a6:	834a                	mv	t1,s2
    16a8:	8752                	mv	a4,s4
    16aa:	892a                	mv	s2,a0
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    16ac:	040e7b13          	andi	s6,t3,64
            c = cs >> 24;
    16b0:	0182d61b          	srliw	a2,t0,0x18
    16b4:	0182db9b          	srliw	s7,t0,0x18
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    16b8:	4a01                	li	s4,0
    16ba:	000b0e63          	beqz	s6,16d6 <stbsp_vsprintfcb+0x408>
            cs &= 0xffffff;
    16be:	02829a13          	slli	s4,t0,0x28
    16c2:	028a5a13          	srli	s4,s4,0x28
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    16c6:	00ea0a3b          	addw	s4,s4,a4
    16ca:	0016059b          	addiw	a1,a2,1
    16ce:	02ba7a3b          	remuw	s4,s4,a1
    16d2:	41460a3b          	subw	s4,a2,s4
            while (pr > 0) {
    16d6:	0ce05763          	blez	a4,17a4 <stbsp_vsprintfcb+0x4d6>
                     *(stbsp__uint32 *)bf = 0x30303030;
    16da:	30303837          	lui	a6,0x30303
    16de:	03080813          	addi	a6,a6,48 # 30303030 <_ZSt4cerr+0x302fb7a8>
    16e2:	f026                	sd	s1,32(sp)
    16e4:	854a                	mv	a0,s2
    16e6:	84da                	mv	s1,s6
    16e8:	895e                	mv	s2,s7
    16ea:	e4d6                	sd	s5,72(sp)
    16ec:	8b4e                	mv	s6,s3
    16ee:	8aea                	mv	s5,s10
               stbsp__chk_cb_buf(1);
    16f0:	1fe00293          	li	t0,510
    16f4:	8d6e                	mv	s10,s11
                     *bf++ = stbsp__comma;
    16f6:	00005f17          	auipc	t5,0x5
    16fa:	29af0f13          	addi	t5,t5,666 # 6990 <stbsp__digitpair>
    16fe:	8de6                	mv	s11,s9
                     *bf++ = '0';
    1700:	03000e93          	li	t4,48
    1704:	e846                	sd	a7,16(sp)
    1706:	ec7e                	sd	t6,24(sp)
    1708:	f436                	sd	a3,40(sp)
    170a:	f872                	sd	t3,48(sp)
    170c:	e89a                	sd	t1,80(sp)
    170e:	89ba                	mv	s3,a4
    1710:	ecbe                	sd	a5,88(sp)
    1712:	8bc2                	mv	s7,a6
    1714:	8c9e                	mv	s9,t2
               stbsp__cb_buf_clamp(i, pr);
    1716:	240b0ee3          	beqz	s6,2172 <stbsp_vsprintfcb+0xea4>
    171a:	40a407b3          	sub	a5,s0,a0
    171e:	40fc063b          	subw	a2,s8,a5
    1722:	87b2                	mv	a5,a2
    1724:	00c9d363          	bge	s3,a2,172a <stbsp_vsprintfcb+0x45c>
    1728:	87ce                	mv	a5,s3
    172a:	0007859b          	sext.w	a1,a5
               pr -= i;
    172e:	40f989bb          	subw	s3,s3,a5
               if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    1732:	32048c63          	beqz	s1,1a6a <stbsp_vsprintfcb+0x79c>
               while (i) {
    1736:	34058a63          	beqz	a1,1a8a <stbsp_vsprintfcb+0x7bc>
    173a:	1582                	slli	a1,a1,0x20
                     *bf++ = stbsp__comma;
    173c:	0cdf4603          	lbu	a2,205(t5)
    1740:	9181                	srli	a1,a1,0x20
    1742:	95a2                	add	a1,a1,s0
    1744:	0405                	addi	s0,s0,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (cs++ == c)) {
    1746:	c481                	beqz	s1,174e <stbsp_vsprintfcb+0x480>
    1748:	1d4901e3          	beq	s2,s4,210a <stbsp_vsprintfcb+0xe3c>
    174c:	2a05                	addiw	s4,s4,1
                     *bf++ = '0';
    174e:	03000793          	li	a5,48
    1752:	fef40fa3          	sb	a5,-1(s0)
               while (i) {
    1756:	fe8597e3          	bne	a1,s0,1744 <stbsp_vsprintfcb+0x476>
               stbsp__chk_cb_buf(1);
    175a:	320b0b63          	beqz	s6,1a90 <stbsp_vsprintfcb+0x7c2>
    175e:	40a5863b          	subw	a2,a1,a0
    1762:	32c2d763          	bge	t0,a2,1a90 <stbsp_vsprintfcb+0x7c2>
    1766:	65a2                	ld	a1,8(sp)
    1768:	01560abb          	addw	s5,a2,s5
    176c:	9b02                	jalr	s6
    176e:	3a050ce3          	beqz	a0,2326 <stbsp_vsprintfcb+0x1058>
    1772:	842a                	mv	s0,a0
    1774:	1fe00293          	li	t0,510
    1778:	00005f17          	auipc	t5,0x5
    177c:	218f0f13          	addi	t5,t5,536 # 6990 <stbsp__digitpair>
    1780:	03000e93          	li	t4,48
            while (pr > 0) {
    1784:	f93049e3          	bgtz	s3,1716 <stbsp_vsprintfcb+0x448>
         while (lead[0]) {
    1788:	83e6                	mv	t2,s9
    178a:	68c2                	ld	a7,16(sp)
    178c:	8cee                	mv	s9,s11
    178e:	6fe2                	ld	t6,24(sp)
    1790:	8dea                	mv	s11,s10
    1792:	7482                	ld	s1,32(sp)
    1794:	8d56                	mv	s10,s5
    1796:	76a2                	ld	a3,40(sp)
    1798:	7e42                	ld	t3,48(sp)
    179a:	6346                	ld	t1,80(sp)
    179c:	67e6                	ld	a5,88(sp)
    179e:	6aa6                	ld	s5,72(sp)
    17a0:	892a                	mv	s2,a0
    17a2:	89da                	mv	s3,s6
    17a4:	06814a03          	lbu	s4,104(sp)
         sn = lead + 1;
    17a8:	fcbe                	sd	a5,120(sp)
         while (lead[0]) {
    17aa:	0a0a0263          	beqz	s4,184e <stbsp_vsprintfcb+0x580>
            stbsp__cb_buf_clamp(i, lead[0]);
    17ae:	ec26                	sd	s1,24(sp)
    17b0:	f036                	sd	a3,32(sp)
    17b2:	854a                	mv	a0,s2
    17b4:	86d2                	mv	a3,s4
    17b6:	84ce                	mv	s1,s3
    17b8:	87a2                	mv	a5,s0
            stbsp__chk_cb_buf(1);
    17ba:	1fe00b93          	li	s7,510
            stbsp__cb_buf_clamp(i, lead[0]);
    17be:	846a                	mv	s0,s10
    17c0:	20000b13          	li	s6,512
    17c4:	8d6e                	mv	s10,s11
    17c6:	e846                	sd	a7,16(sp)
    17c8:	8de6                	mv	s11,s9
    17ca:	8a7e                	mv	s4,t6
    17cc:	8972                	mv	s2,t3
    17ce:	899a                	mv	s3,t1
    17d0:	8c9e                	mv	s9,t2
    17d2:	0006871b          	sext.w	a4,a3
    17d6:	140482e3          	beqz	s1,211a <stbsp_vsprintfcb+0xe4c>
    17da:	40a7863b          	subw	a2,a5,a0
    17de:	40cb083b          	subw	a6,s6,a2
    17e2:	85c2                	mv	a1,a6
    17e4:	01075363          	bge	a4,a6,17ea <stbsp_vsprintfcb+0x51c>
    17e8:	85ba                	mv	a1,a4
            lead[0] -= (char)i;
    17ea:	9e8d                	subw	a3,a3,a1
            stbsp__cb_buf_clamp(i, lead[0]);
    17ec:	0005871b          	sext.w	a4,a1
            lead[0] -= (char)i;
    17f0:	06d10423          	sb	a3,104(sp)
            while (i) {
    17f4:	c70d                	beqz	a4,181e <stbsp_vsprintfcb+0x550>
    17f6:	7866                	ld	a6,120(sp)
    17f8:	02071593          	slli	a1,a4,0x20
    17fc:	9181                	srli	a1,a1,0x20
    17fe:	00b78633          	add	a2,a5,a1
    1802:	8742                	mv	a4,a6
               *bf++ = *sn++;
    1804:	00074683          	lbu	a3,0(a4)
    1808:	0785                	addi	a5,a5,1
            while (i) {
    180a:	0705                	addi	a4,a4,1
               *bf++ = *sn++;
    180c:	fed78fa3          	sb	a3,-1(a5)
            while (i) {
    1810:	fec79ae3          	bne	a5,a2,1804 <stbsp_vsprintfcb+0x536>
    1814:	982e                	add	a6,a6,a1
    1816:	fcc2                	sd	a6,120(sp)
            stbsp__chk_cb_buf(1);
    1818:	c899                	beqz	s1,182e <stbsp_vsprintfcb+0x560>
    181a:	40a7863b          	subw	a2,a5,a0
    181e:	00cbd863          	bge	s7,a2,182e <stbsp_vsprintfcb+0x560>
    1822:	65a2                	ld	a1,8(sp)
    1824:	9c31                	addw	s0,s0,a2
    1826:	9482                	jalr	s1
    1828:	1a050ae3          	beqz	a0,21dc <stbsp_vsprintfcb+0xf0e>
    182c:	87aa                	mv	a5,a0
         while (lead[0]) {
    182e:	06814683          	lbu	a3,104(sp)
    1832:	f2c5                	bnez	a3,17d2 <stbsp_vsprintfcb+0x504>
    1834:	834e                	mv	t1,s3
    1836:	68c2                	ld	a7,16(sp)
    1838:	89a6                	mv	s3,s1
    183a:	7682                	ld	a3,32(sp)
    183c:	64e2                	ld	s1,24(sp)
    183e:	8e4a                	mv	t3,s2
    1840:	83e6                	mv	t2,s9
    1842:	8fd2                	mv	t6,s4
    1844:	8cee                	mv	s9,s11
    1846:	892a                	mv	s2,a0
    1848:	8dea                	mv	s11,s10
    184a:	8d22                	mv	s10,s0
    184c:	843e                	mv	s0,a5
         while (n) {
    184e:	c6f9                	beqz	a3,191c <stbsp_vsprintfcb+0x64e>
            STBSP__UNALIGNED(while (i >= 4) {
    1850:	ec26                	sd	s1,24(sp)
    1852:	854a                	mv	a0,s2
    1854:	84d6                	mv	s1,s5
    1856:	896a                	mv	s2,s10
    1858:	87a2                	mv	a5,s0
    185a:	8d6e                	mv	s10,s11
            stbsp__chk_cb_buf(1);
    185c:	1fe00b93          	li	s7,510
            STBSP__UNALIGNED(while (i >= 4) {
    1860:	8de6                	mv	s11,s9
            stbsp__cb_buf_clamp(i, n);
    1862:	20000b13          	li	s6,512
            STBSP__UNALIGNED(while (i >= 4) {
    1866:	4a0d                	li	s4,3
    1868:	e87e                	sd	t6,16(sp)
    186a:	f072                	sd	t3,32(sp)
    186c:	8ac6                	mv	s5,a7
    186e:	f41a                	sd	t1,40(sp)
    1870:	8436                	mv	s0,a3
    1872:	8c9e                	mv	s9,t2
            stbsp__cb_buf_clamp(i, n);
    1874:	0004071b          	sext.w	a4,s0
    1878:	100982e3          	beqz	s3,217c <stbsp_vsprintfcb+0xeae>
    187c:	40a78633          	sub	a2,a5,a0
    1880:	40cb05bb          	subw	a1,s6,a2
    1884:	862e                	mv	a2,a1
    1886:	00b75363          	bge	a4,a1,188c <stbsp_vsprintfcb+0x5be>
    188a:	863a                	mv	a2,a4
    188c:	0006071b          	sext.w	a4,a2
            n -= i;
    1890:	9c11                	subw	s0,s0,a2
            STBSP__UNALIGNED(while (i >= 4) {
    1892:	14ea50e3          	bge	s4,a4,21d2 <stbsp_vsprintfcb+0xf04>
    1896:	ffc70f1b          	addiw	t5,a4,-4
    189a:	002f5e9b          	srliw	t4,t5,0x2
    189e:	001e8e1b          	addiw	t3,t4,1
    18a2:	0e0a                	slli	t3,t3,0x2
    18a4:	01c785b3          	add	a1,a5,t3
    18a8:	8626                	mv	a2,s1
    18aa:	4218                	lw	a4,0(a2)
    18ac:	0791                	addi	a5,a5,4
    18ae:	0611                	addi	a2,a2,4
    18b0:	2701                	sext.w	a4,a4
    18b2:	fee7ae23          	sw	a4,-4(a5)
    18b6:	feb79ae3          	bne	a5,a1,18aa <stbsp_vsprintfcb+0x5dc>
    18ba:	002e9e9b          	slliw	t4,t4,0x2
    18be:	41df073b          	subw	a4,t5,t4
            while (i) {
    18c2:	94f2                	add	s1,s1,t3
    18c4:	c31d                	beqz	a4,18ea <stbsp_vsprintfcb+0x61c>
    18c6:	8626                	mv	a2,s1
    18c8:	87ae                	mv	a5,a1
    18ca:	00e58f3b          	addw	t5,a1,a4
               *bf++ = *s++;
    18ce:	00064e83          	lbu	t4,0(a2)
    18d2:	0785                	addi	a5,a5,1
            while (i) {
    18d4:	00078e1b          	sext.w	t3,a5
               *bf++ = *s++;
    18d8:	ffd78fa3          	sb	t4,-1(a5)
    18dc:	0605                	addi	a2,a2,1
            while (i) {
    18de:	ffcf18e3          	bne	t5,t3,18ce <stbsp_vsprintfcb+0x600>
    18e2:	1702                	slli	a4,a4,0x20
    18e4:	9301                	srli	a4,a4,0x20
    18e6:	95ba                	add	a1,a1,a4
    18e8:	94ba                	add	s1,s1,a4
            stbsp__chk_cb_buf(1);
    18ea:	1a098763          	beqz	s3,1a98 <stbsp_vsprintfcb+0x7ca>
    18ee:	40a5863b          	subw	a2,a1,a0
    18f2:	1acbd363          	bge	s7,a2,1a98 <stbsp_vsprintfcb+0x7ca>
    18f6:	65a2                	ld	a1,8(sp)
    18f8:	0126093b          	addw	s2,a2,s2
    18fc:	9982                	jalr	s3
    18fe:	20050be3          	beqz	a0,2314 <stbsp_vsprintfcb+0x1046>
    1902:	87aa                	mv	a5,a0
         while (n) {
    1904:	f825                	bnez	s0,1874 <stbsp_vsprintfcb+0x5a6>
    1906:	6fc2                	ld	t6,16(sp)
    1908:	64e2                	ld	s1,24(sp)
    190a:	7e02                	ld	t3,32(sp)
    190c:	7322                	ld	t1,40(sp)
    190e:	83e6                	mv	t2,s9
    1910:	88d6                	mv	a7,s5
    1912:	8cee                	mv	s9,s11
    1914:	843e                	mv	s0,a5
    1916:	8dea                	mv	s11,s10
    1918:	8d4a                	mv	s10,s2
    191a:	892a                	mv	s2,a0
         while (tz) {
    191c:	08088863          	beqz	a7,19ac <stbsp_vsprintfcb+0x6de>
               *(stbsp__uint32 *)bf = 0x30303030;
    1920:	30303b37          	lui	s6,0x30303
               *bf++ = '0';
    1924:	03000a13          	li	s4,48
            while (i >= 4) {
    1928:	4a8d                	li	s5,3
            stbsp__chk_cb_buf(1);
    192a:	1fe00693          	li	a3,510
               *(stbsp__uint32 *)bf = 0x30303030;
    192e:	030b0b13          	addi	s6,s6,48 # 30303030 <_ZSt4cerr+0x302fb7a8>
            stbsp__cb_buf_clamp(i, tz);
    1932:	20000b93          	li	s7,512
    1936:	040989e3          	beqz	s3,2188 <stbsp_vsprintfcb+0xeba>
    193a:	41240633          	sub	a2,s0,s2
    193e:	40cb87bb          	subw	a5,s7,a2
    1942:	873e                	mv	a4,a5
    1944:	00f8d363          	bge	a7,a5,194a <stbsp_vsprintfcb+0x67c>
    1948:	8746                	mv	a4,a7
    194a:	0007079b          	sext.w	a5,a4
            tz -= i;
    194e:	40e888bb          	subw	a7,a7,a4
            while (i) {
    1952:	08078ee3          	beqz	a5,21ee <stbsp_vsprintfcb+0xf20>
               if ((((stbsp__uintptr)bf) & 3) == 0)
    1956:	00347713          	andi	a4,s0,3
    195a:	e719                	bnez	a4,1968 <stbsp_vsprintfcb+0x69a>
    195c:	0390006f          	j	2194 <stbsp_vsprintfcb+0xec6>
    1960:	00347713          	andi	a4,s0,3
    1964:	7a070f63          	beqz	a4,2122 <stbsp_vsprintfcb+0xe54>
               *bf++ = '0';
    1968:	01440023          	sb	s4,0(s0)
               --i;
    196c:	37fd                	addiw	a5,a5,-1
               *bf++ = '0';
    196e:	0405                	addi	s0,s0,1
            while (i) {
    1970:	fbe5                	bnez	a5,1960 <stbsp_vsprintfcb+0x692>
            stbsp__chk_cb_buf(1);
    1972:	02098b63          	beqz	s3,19a8 <stbsp_vsprintfcb+0x6da>
    1976:	4124063b          	subw	a2,s0,s2
    197a:	02c6d763          	bge	a3,a2,19a8 <stbsp_vsprintfcb+0x6da>
    197e:	65a2                	ld	a1,8(sp)
    1980:	854a                	mv	a0,s2
    1982:	f81e                	sd	t2,48(sp)
    1984:	f41a                	sd	t1,40(sp)
    1986:	f072                	sd	t3,32(sp)
    1988:	ec7e                	sd	t6,24(sp)
    198a:	e846                	sd	a7,16(sp)
    198c:	00cd0d3b          	addw	s10,s10,a2
    1990:	9982                	jalr	s3
    1992:	892a                	mv	s2,a0
    1994:	1a0502e3          	beqz	a0,2338 <stbsp_vsprintfcb+0x106a>
    1998:	73c2                	ld	t2,48(sp)
    199a:	7322                	ld	t1,40(sp)
    199c:	7e02                	ld	t3,32(sp)
    199e:	6fe2                	ld	t6,24(sp)
    19a0:	68c2                	ld	a7,16(sp)
    19a2:	842a                	mv	s0,a0
    19a4:	1fe00693          	li	a3,510
         while (tz) {
    19a8:	f80897e3          	bnez	a7,1936 <stbsp_vsprintfcb+0x668>
         sn = tail + 1;
    19ac:	07110793          	addi	a5,sp,113
    19b0:	fcbe                	sd	a5,120(sp)
         while (tail[0]) {
    19b2:	080f8763          	beqz	t6,1a40 <stbsp_vsprintfcb+0x772>
            stbsp__cb_buf_clamp(i, tail[0]);
    19b6:	854a                	mv	a0,s2
    19b8:	8b6a                	mv	s6,s10
            stbsp__chk_cb_buf(1);
    19ba:	1fe00a93          	li	s5,510
            stbsp__cb_buf_clamp(i, tail[0]);
    19be:	8d4e                	mv	s10,s3
    19c0:	20000a13          	li	s4,512
    19c4:	8bf2                	mv	s7,t3
    19c6:	891a                	mv	s2,t1
    19c8:	899e                	mv	s3,t2
    19ca:	000f879b          	sext.w	a5,t6
    19ce:	7c0d0863          	beqz	s10,219e <stbsp_vsprintfcb+0xed0>
    19d2:	40a4063b          	subw	a2,s0,a0
    19d6:	40ca06bb          	subw	a3,s4,a2
    19da:	8736                	mv	a4,a3
    19dc:	00d7d363          	bge	a5,a3,19e2 <stbsp_vsprintfcb+0x714>
    19e0:	873e                	mv	a4,a5
            tail[0] -= (char)i;
    19e2:	40ef8fbb          	subw	t6,t6,a4
            stbsp__cb_buf_clamp(i, tail[0]);
    19e6:	0007079b          	sext.w	a5,a4
            tail[0] -= (char)i;
    19ea:	07f10823          	sb	t6,112(sp)
            while (i) {
    19ee:	c795                	beqz	a5,1a1a <stbsp_vsprintfcb+0x74c>
    19f0:	75e6                	ld	a1,120(sp)
    19f2:	02079613          	slli	a2,a5,0x20
    19f6:	9201                	srli	a2,a2,0x20
    19f8:	00c406b3          	add	a3,s0,a2
    19fc:	87ae                	mv	a5,a1
               *bf++ = *sn++;
    19fe:	0007c703          	lbu	a4,0(a5)
    1a02:	0405                	addi	s0,s0,1
            while (i) {
    1a04:	0785                	addi	a5,a5,1
               *bf++ = *sn++;
    1a06:	fee40fa3          	sb	a4,-1(s0)
            while (i) {
    1a0a:	fed41ae3          	bne	s0,a3,19fe <stbsp_vsprintfcb+0x730>
    1a0e:	95b2                	add	a1,a1,a2
    1a10:	fcae                	sd	a1,120(sp)
            stbsp__chk_cb_buf(1);
    1a12:	000d0d63          	beqz	s10,1a2c <stbsp_vsprintfcb+0x75e>
    1a16:	40a4063b          	subw	a2,s0,a0
    1a1a:	00cad963          	bge	s5,a2,1a2c <stbsp_vsprintfcb+0x75e>
    1a1e:	65a2                	ld	a1,8(sp)
    1a20:	00cb0b3b          	addw	s6,s6,a2
    1a24:	9d02                	jalr	s10
    1a26:	200509e3          	beqz	a0,2438 <stbsp_vsprintfcb+0x116a>
    1a2a:	842a                	mv	s0,a0
         while (tail[0]) {
    1a2c:	07014f83          	lbu	t6,112(sp)
    1a30:	f80f9de3          	bnez	t6,19ca <stbsp_vsprintfcb+0x6fc>
    1a34:	834a                	mv	t1,s2
    1a36:	83ce                	mv	t2,s3
    1a38:	8e5e                	mv	t3,s7
    1a3a:	89ea                	mv	s3,s10
    1a3c:	892a                	mv	s2,a0
    1a3e:	8d5a                	mv	s10,s6
         if (fl & STBSP__LEFTJUST)
    1a40:	001e7e13          	andi	t3,t3,1
    1a44:	000e0663          	beqz	t3,1a50 <stbsp_vsprintfcb+0x782>
            if (fw > 0) {
    1a48:	00605463          	blez	t1,1a50 <stbsp_vsprintfcb+0x782>
    1a4c:	0300106f          	j	2a7c <stbsp_vsprintfcb+0x17ae>
   for (;;) {
    1a50:	6b86                	ld	s7,64(sp)
    1a52:	2c013a03          	ld	s4,704(sp)
    1a56:	2b813a83          	ld	s5,696(sp)
    1a5a:	2b013b03          	ld	s6,688(sp)
      ++f;
    1a5e:	0485                	addi	s1,s1,1
   for (;;) {
    1a60:	b0f1                	j	132c <stbsp_vsprintfcb+0x5e>
               fl |= STBSP__METRIC_SUFFIX;
    1a62:	100e6e13          	ori	t3,t3,256
            continue;
    1a66:	0685                	addi	a3,a3,1
    1a68:	bad1                	j	143c <stbsp_vsprintfcb+0x16e>
                  while (i) {
    1a6a:	0e0580e3          	beqz	a1,234a <stbsp_vsprintfcb+0x107c>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    1a6e:	00347793          	andi	a5,s0,3
    1a72:	e799                	bnez	a5,1a80 <stbsp_vsprintfcb+0x7b2>
    1a74:	0dd0006f          	j	2350 <stbsp_vsprintfcb+0x1082>
    1a78:	00347793          	andi	a5,s0,3
    1a7c:	72078463          	beqz	a5,21a4 <stbsp_vsprintfcb+0xed6>
                     *bf++ = '0';
    1a80:	01d40023          	sb	t4,0(s0)
                     --i;
    1a84:	35fd                	addiw	a1,a1,-1
                     *bf++ = '0';
    1a86:	0405                	addi	s0,s0,1
                  while (i) {
    1a88:	f9e5                	bnez	a1,1a78 <stbsp_vsprintfcb+0x7aa>
               while (i) {
    1a8a:	85a2                	mv	a1,s0
               stbsp__chk_cb_buf(1);
    1a8c:	cc0b19e3          	bnez	s6,175e <stbsp_vsprintfcb+0x490>
    1a90:	842e                	mv	s0,a1
            while (pr > 0) {
    1a92:	c93042e3          	bgtz	s3,1716 <stbsp_vsprintfcb+0x448>
    1a96:	b9cd                	j	1788 <stbsp_vsprintfcb+0x4ba>
            while (i) {
    1a98:	87ae                	mv	a5,a1
         while (n) {
    1a9a:	dc041de3          	bnez	s0,1874 <stbsp_vsprintfcb+0x5a6>
    1a9e:	b5a5                	j	1906 <stbsp_vsprintfcb+0x638>
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1aa0:	fd07871b          	addiw	a4,a5,-48
    1aa4:	0ff77713          	zext.b	a4,a4
    1aa8:	4625                	li	a2,9
         ++f;
    1aaa:	0485                	addi	s1,s1,1
            pr = 0;
    1aac:	4881                	li	a7,0
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1aae:	46a5                	li	a3,9
    1ab0:	9ce669e3          	bltu	a2,a4,1482 <stbsp_vsprintfcb+0x1b4>
               pr = pr * 10 + f[0] - '0';
    1ab4:	0028971b          	slliw	a4,a7,0x2
    1ab8:	0117073b          	addw	a4,a4,a7
    1abc:	0017171b          	slliw	a4,a4,0x1
               f++;
    1ac0:	0485                	addi	s1,s1,1
               pr = pr * 10 + f[0] - '0';
    1ac2:	9f3d                	addw	a4,a4,a5
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1ac4:	0004c783          	lbu	a5,0(s1)
               pr = pr * 10 + f[0] - '0';
    1ac8:	fd07089b          	addiw	a7,a4,-48
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1acc:	fd07871b          	addiw	a4,a5,-48
    1ad0:	0ff77713          	zext.b	a4,a4
    1ad4:	fee6f0e3          	bgeu	a3,a4,1ab4 <stbsp_vsprintfcb+0x7e6>
    1ad8:	b26d                	j	1482 <stbsp_vsprintfcb+0x1b4>
                  fl |= STBSP__METRIC_1024;
    1ada:	8f5d                	or	a4,a4,a5
    1adc:	00070e1b          	sext.w	t3,a4
    1ae0:	0685                	addi	a3,a3,1
    1ae2:	baa9                	j	143c <stbsp_vsprintfcb+0x16e>
      *bf = 0;
    1ae4:	00040023          	sb	zero,0(s0)
    1ae8:	b209                	j	13ea <stbsp_vsprintfcb+0x11c>
         if (f[0] == 'l') {
    1aea:	0014c783          	lbu	a5,1(s1)
    1aee:	06c00713          	li	a4,108
         fl |= ((sizeof(long) == 8) ? STBSP__INTMAX : 0);
    1af2:	020e6e13          	ori	t3,t3,32
         if (f[0] == 'l') {
    1af6:	00e78c63          	beq	a5,a4,1b0e <stbsp_vsprintfcb+0x840>
            ++f;
    1afa:	0485                	addi	s1,s1,1
    1afc:	ba65                	j	14b4 <stbsp_vsprintfcb+0x1e6>
         if (f[0] == 'h')
    1afe:	0014c783          	lbu	a5,1(s1)
    1b02:	06800713          	li	a4,104
         fl |= STBSP__HALFWIDTH;
    1b06:	200e6e13          	ori	t3,t3,512
         if (f[0] == 'h')
    1b0a:	fee798e3          	bne	a5,a4,1afa <stbsp_vsprintfcb+0x82c>
         if ((f[1] == '6') && (f[2] == '4')) {
    1b0e:	0024c783          	lbu	a5,2(s1)
            ++f;
    1b12:	0489                	addi	s1,s1,2
    1b14:	b245                	j	14b4 <stbsp_vsprintfcb+0x1e6>
         s = va_arg(va, char *);
    1b16:	008b8713          	addi	a4,s7,8
    1b1a:	e0ba                	sd	a4,64(sp)
         if (fl & STBSP__INTMAX) {
    1b1c:	020e7693          	andi	a3,t3,32
    1b20:	8772                	mv	a4,t3
    1b22:	24069ee3          	bnez	a3,257e <stbsp_vsprintfcb+0x12b0>
            stbsp__int32 i = va_arg(va, stbsp__int32);
    1b26:	000ba683          	lw	a3,0(s7)
            if ((f[0] != 'u') && (i < 0)) {
    1b2a:	07500613          	li	a2,117
            n64 = (stbsp__uint32)i;
    1b2e:	02069f13          	slli	t5,a3,0x20
    1b32:	020f5f13          	srli	t5,t5,0x20
            if ((f[0] != 'u') && (i < 0)) {
    1b36:	00c78a63          	beq	a5,a2,1b4a <stbsp_vsprintfcb+0x87c>
    1b3a:	0006d863          	bgez	a3,1b4a <stbsp_vsprintfcb+0x87c>
               fl |= STBSP__NEGATIVE;
    1b3e:	08076713          	ori	a4,a4,128
               n64 = (stbsp__uint32)-i;
    1b42:	40d00f3b          	negw	t5,a3
               fl |= STBSP__NEGATIVE;
    1b46:	00070e1b          	sext.w	t3,a4
         if (fl & STBSP__METRIC_SUFFIX) {
    1b4a:	100e7693          	andi	a3,t3,256
    1b4e:	5c0683e3          	beqz	a3,2914 <stbsp_vsprintfcb+0x1646>
            if (n64 < 1024)
    1b52:	3ff00793          	li	a5,1023
    1b56:	01e7e463          	bltu	a5,t5,1b5e <stbsp_vsprintfcb+0x890>
    1b5a:	0ea0106f          	j	2c44 <stbsp_vsprintfcb+0x1976>
            else if (pr == -1)
    1b5e:	57fd                	li	a5,-1
    1b60:	30f887e3          	beq	a7,a5,266e <stbsp_vsprintfcb+0x13a0>
            fv = (double)(stbsp__int64)n64;
    1b64:	d22f7553          	fcvt.d.l	fa0,t5
            if (fl & STBSP__METRIC_1024)
    1b68:	034e1793          	slli	a5,t3,0x34
    1b6c:	0007c463          	bltz	a5,1b74 <stbsp_vsprintfcb+0x8a6>
    1b70:	2300106f          	j	2da0 <stbsp_vsprintfcb+0x1ad2>
               divisor = 1024.0;
    1b74:	00004797          	auipc	a5,0x4
    1b78:	d047b787          	fld	fa5,-764(a5) # 5878 <STDIN_FD+0x20>
               if ((fv < divisor) && (fv > -divisor))
    1b7c:	22f79753          	fneg.d	fa4,fa5
               fl += 0x1000000;
    1b80:	010006b7          	lui	a3,0x1000
            while (fl < 0x4000000) {
    1b84:	04000737          	lui	a4,0x4000
               if ((fv < divisor) && (fv > -divisor))
    1b88:	a2f517d3          	flt.d	a5,fa0,fa5
    1b8c:	c789                	beqz	a5,1b96 <stbsp_vsprintfcb+0x8c8>
    1b8e:	a2a717d3          	flt.d	a5,fa4,fa0
    1b92:	3e079863          	bnez	a5,1f82 <stbsp_vsprintfcb+0xcb4>
               fl += 0x1000000;
    1b96:	01c68e3b          	addw	t3,a3,t3
               fv /= divisor;
    1b9a:	1af57553          	fdiv.d	fa0,fa0,fa5
            while (fl < 0x4000000) {
    1b9e:	feee65e3          	bltu	t3,a4,1b88 <stbsp_vsprintfcb+0x8ba>
    1ba2:	a6c5                	j	1f82 <stbsp_vsprintfcb+0xcb4>
         h = (f[0] == 'X') ? hexu : hex;
    1ba4:	05800693          	li	a3,88
         if (fl & STBSP__INTMAX) {
    1ba8:	020e7713          	andi	a4,t3,32
         h = (f[0] == 'X') ? hexu : hex;
    1bac:	00005817          	auipc	a6,0x5
    1bb0:	ecc80813          	addi	a6,a6,-308 # 6a78 <hex.0>
    1bb4:	00d79663          	bne	a5,a3,1bc0 <stbsp_vsprintfcb+0x8f2>
    1bb8:	00005817          	auipc	a6,0x5
    1bbc:	ea880813          	addi	a6,a6,-344 # 6a60 <hexu.1>
         l = (4 << 4) | (4 << 8);
    1bc0:	44000793          	li	a5,1088
    1bc4:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__LEADING_0X) {
    1bc6:	008e7793          	andi	a5,t3,8
    1bca:	7a079263          	bnez	a5,236e <stbsp_vsprintfcb+0x10a0>
         lead[0] = 0;
    1bce:	06010423          	sb	zero,104(sp)
         s = va_arg(va, char *);
    1bd2:	008b8793          	addi	a5,s7,8
    1bd6:	e0be                	sd	a5,64(sp)
         if (fl & STBSP__INTMAX)
    1bd8:	72070b63          	beqz	a4,230e <stbsp_vsprintfcb+0x1040>
            n64 = va_arg(va, stbsp__uint64);
    1bdc:	000bb683          	ld	a3,0(s7)
         dp = 0;
    1be0:	d282                	sw	zero,100(sp)
         tail[0] = 0;
    1be2:	06010823          	sb	zero,112(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    1be6:	001e7513          	andi	a0,t3,1
         if (n64 == 0) {
    1bea:	380694e3          	bnez	a3,2772 <stbsp_vsprintfcb+0x14a4>
            lead[0] = 0;
    1bee:	06010423          	sb	zero,104(sp)
            if (pr == 0) {
    1bf2:	78089a63          	bnez	a7,2386 <stbsp_vsprintfcb+0x10b8>
         if (fw < (stbsp__int32)n)
    1bf6:	fffb4313          	not	t1,s6
    1bfa:	43f35313          	srai	t1,t1,0x3f
               l = 0;
    1bfe:	d082                	sw	zero,96(sp)
         if (fw < (stbsp__int32)n)
    1c00:	01637333          	and	t1,t1,s6
               goto scopy;
    1c04:	4701                	li	a4,0
    1c06:	4f81                	li	t6,0
    1c08:	4a01                	li	s4,0
               cs = 0;
    1c0a:	4281                	li	t0,0
         s = num + STBSP__NUMSZ;
    1c0c:	28010a93          	addi	s5,sp,640
         if ((fl & STBSP__LEFTJUST) == 0) {
    1c10:	9c0506e3          	beqz	a0,15dc <stbsp_vsprintfcb+0x30e>
         if (fw + pr) {
    1c14:	00e307bb          	addw	a5,t1,a4
    1c18:	9c079fe3          	bnez	a5,15f6 <stbsp_vsprintfcb+0x328>
    1c1c:	06910793          	addi	a5,sp,105
    1c20:	b661                	j	17a8 <stbsp_vsprintfcb+0x4da>
         h = (f[0] == 'E') ? hexu : hex;
    1c22:	04500713          	li	a4,69
    1c26:	00005317          	auipc	t1,0x5
    1c2a:	e5230313          	addi	t1,t1,-430 # 6a78 <hex.0>
    1c2e:	1ce78ae3          	beq	a5,a4,2602 <stbsp_vsprintfcb+0x1334>
         fv = va_arg(va, double);
    1c32:	008b8713          	addi	a4,s7,8
         if (pr == -1)
    1c36:	57fd                	li	a5,-1
         fv = va_arg(va, double);
    1c38:	e0ba                	sd	a4,64(sp)
    1c3a:	000bb507          	fld	fa0,0(s7)
         if (pr == -1)
    1c3e:	1af88ce3          	beq	a7,a5,25f6 <stbsp_vsprintfcb+0x1328>
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr | 0x80000000))
    1c42:	80000737          	lui	a4,0x80000
    1c46:	00e8e733          	or	a4,a7,a4
    1c4a:	2701                	sext.w	a4,a4
    1c4c:	10d4                	addi	a3,sp,100
    1c4e:	0110                	addi	a2,sp,128
    1c50:	108c                	addi	a1,sp,96
    1c52:	18a8                	addi	a0,sp,120
    1c54:	f41e                	sd	t2,40(sp)
    1c56:	f01a                	sd	t1,32(sp)
    1c58:	ec72                	sd	t3,24(sp)
    1c5a:	e846                	sd	a7,16(sp)
    1c5c:	d8efe0ef          	jal	1ea <stbsp__real_to_str>
    1c60:	68c2                	ld	a7,16(sp)
    1c62:	6e62                	ld	t3,24(sp)
    1c64:	7302                	ld	t1,32(sp)
    1c66:	73a2                	ld	t2,40(sp)
         if (dp == STBSP__SPECIAL) {
    1c68:	5796                	lw	a5,100(sp)
            s = (char *)sn;
    1c6a:	7ae6                	ld	s5,120(sp)
         if ((l - 1) > (stbsp__uint32)pr)
    1c6c:	5686                	lw	a3,96(sp)
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr | 0x80000000))
    1c6e:	3c0511e3          	bnez	a0,2830 <stbsp_vsprintfcb+0x1562>
         tail[0] = 0;
    1c72:	06010823          	sb	zero,112(sp)
   sign[0] = 0;
    1c76:	06010423          	sb	zero,104(sp)
   } else if (fl & STBSP__LEADINGSPACE) {
    1c7a:	004e7713          	andi	a4,t3,4
    1c7e:	6a070ee3          	beqz	a4,2b3a <stbsp_vsprintfcb+0x186c>
      sign[0] = 1;
    1c82:	6709                	lui	a4,0x2
    1c84:	0705                	addi	a4,a4,1 # 2001 <stbsp_vsprintfcb+0xd33>
    1c86:	06e11423          	sh	a4,104(sp)
         if (dp == STBSP__SPECIAL) {
    1c8a:	671d                	lui	a4,0x7
    1c8c:	1ee794e3          	bne	a5,a4,2674 <stbsp_vsprintfcb+0x13a6>
         if (pr < (stbsp__int32)l)
    1c90:	0006879b          	sext.w	a5,a3
         n = pr + lead[0] + tail[0] + tz;
    1c94:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    1c98:	fff7c793          	not	a5,a5
         n = pr + lead[0] + tail[0] + tz;
    1c9c:	07014f83          	lbu	t6,112(sp)
         if (pr < (stbsp__int32)l)
    1ca0:	97fd                	srai	a5,a5,0x3f
    1ca2:	8ff5                	and	a5,a5,a3
         n = pr + lead[0] + tail[0] + tz;
    1ca4:	00fa073b          	addw	a4,s4,a5
    1ca8:	01f7063b          	addw	a2,a4,t6
    1cac:	8732                	mv	a4,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    1cae:	001e7513          	andi	a0,t3,1
         if (pr < (stbsp__int32)l)
    1cb2:	2781                	sext.w	a5,a5
         if (fw < (stbsp__int32)n)
    1cb4:	835a                	mv	t1,s6
    1cb6:	00cb5363          	bge	s6,a2,1cbc <stbsp_vsprintfcb+0x9ee>
    1cba:	8332                	mv	t1,a2
         fw -= n;
    1cbc:	40e3033b          	subw	t1,t1,a4
            cs = 0;
    1cc0:	4281                	li	t0,0
         pr -= l;
    1cc2:	40d7873b          	subw	a4,a5,a3
      tz = 0;
    1cc6:	4881                	li	a7,0
            goto scopy;
    1cc8:	b7a1                	j	1c10 <stbsp_vsprintfcb+0x942>
         h = (f[0] == 'G') ? hexu : hex;
    1cca:	04700713          	li	a4,71
    1cce:	00005317          	auipc	t1,0x5
    1cd2:	daa30313          	addi	t1,t1,-598 # 6a78 <hex.0>
    1cd6:	14e783e3          	beq	a5,a4,261c <stbsp_vsprintfcb+0x134e>
         fv = va_arg(va, double);
    1cda:	008b8713          	addi	a4,s7,8
         if (pr == -1)
    1cde:	57fd                	li	a5,-1
         fv = va_arg(va, double);
    1ce0:	e0ba                	sd	a4,64(sp)
    1ce2:	000bb507          	fld	fa0,0(s7)
         if (pr == -1)
    1ce6:	12f884e3          	beq	a7,a5,260e <stbsp_vsprintfcb+0x1340>
         else if (pr == 0)
    1cea:	6e0887e3          	beqz	a7,2bd8 <stbsp_vsprintfcb+0x190a>
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, (pr - 1) | 0x80000000))
    1cee:	fff8871b          	addiw	a4,a7,-1
    1cf2:	800007b7          	lui	a5,0x80000
    1cf6:	8f5d                	or	a4,a4,a5
    1cf8:	2701                	sext.w	a4,a4
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    1cfa:	00088a9b          	sext.w	s5,a7
    1cfe:	8a46                	mv	s4,a7
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, (pr - 1) | 0x80000000))
    1d00:	10d4                	addi	a3,sp,100
    1d02:	0110                	addi	a2,sp,128
    1d04:	108c                	addi	a1,sp,96
    1d06:	18a8                	addi	a0,sp,120
    1d08:	f01e                	sd	t2,32(sp)
    1d0a:	ec1a                	sd	t1,24(sp)
    1d0c:	e872                	sd	t3,16(sp)
    1d0e:	cdcfe0ef          	jal	1ea <stbsp__real_to_str>
    1d12:	6e42                	ld	t3,16(sp)
    1d14:	6362                	ld	t1,24(sp)
    1d16:	7382                	ld	t2,32(sp)
    1d18:	4281                	li	t0,0
    1d1a:	c509                	beqz	a0,1d24 <stbsp_vsprintfcb+0xa56>
            fl |= STBSP__NEGATIVE;
    1d1c:	080e6e13          	ori	t3,t3,128
    1d20:	08000293          	li	t0,128
         if (l > (stbsp__uint32)pr)
    1d24:	5806                	lw	a6,96(sp)
    1d26:	010af463          	bgeu	s5,a6,1d2e <stbsp_vsprintfcb+0xa60>
            l = pr;
    1d2a:	d0d6                	sw	s5,96(sp)
    1d2c:	8856                	mv	a6,s5
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    1d2e:	4705                	li	a4,1
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    1d30:	5796                	lw	a5,100(sp)
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    1d32:	01076463          	bltu	a4,a6,1d3a <stbsp_vsprintfcb+0xa6c>
    1d36:	1800106f          	j	2eb6 <stbsp_vsprintfcb+0x1be8>
    1d3a:	7be6                	ld	s7,120(sp)
    1d3c:	fff8071b          	addiw	a4,a6,-1
    1d40:	1702                	slli	a4,a4,0x20
    1d42:	9301                	srli	a4,a4,0x20
    1d44:	001a0e9b          	addiw	t4,s4,1
    1d48:	75e2                	ld	a1,56(sp)
    1d4a:	8ade                	mv	s5,s7
    1d4c:	975e                	add	a4,a4,s7
    1d4e:	410e8ebb          	subw	t4,t4,a6
    1d52:	88d2                	mv	a7,s4
    1d54:	86c2                	mv	a3,a6
    1d56:	4f01                	li	t5,0
    1d58:	03000f93          	li	t6,48
    1d5c:	e842                	sd	a6,16(sp)
    1d5e:	a809                	j	1d70 <stbsp_vsprintfcb+0xaa2>
            --pr;
    1d60:	38fd                	addiw	a7,a7,-1
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    1d62:	211e80e3          	beq	t4,a7,2762 <stbsp_vsprintfcb+0x1494>
    1d66:	177d                	addi	a4,a4,-1 # 6fff <_stdout+0x14f>
    1d68:	4f05                	li	t5,1
    1d6a:	1e088ce3          	beqz	a7,2762 <stbsp_vsprintfcb+0x1494>
            --l;
    1d6e:	85b6                	mv	a1,a3
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    1d70:	00074803          	lbu	a6,0(a4)
    1d74:	fff6861b          	addiw	a2,a3,-1 # ffffff <_ZSt4cerr+0xff8777>
    1d78:	0006851b          	sext.w	a0,a3
    1d7c:	2581                	sext.w	a1,a1
    1d7e:	0006069b          	sext.w	a3,a2
    1d82:	fdf80fe3          	beq	a6,t6,1d60 <stbsp_vsprintfcb+0xa92>
    1d86:	6842                	ld	a6,16(sp)
    1d88:	fc2e                	sd	a1,56(sp)
    1d8a:	86c2                	mv	a3,a6
    1d8c:	000f0463          	beqz	t5,1d94 <stbsp_vsprintfcb+0xac6>
    1d90:	d0ae                	sw	a1,96(sp)
    1d92:	86ae                	mv	a3,a1
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    1d94:	5775                	li	a4,-3
    1d96:	08e7cee3          	blt	a5,a4,2632 <stbsp_vsprintfcb+0x1364>
    1d9a:	08fa4be3          	blt	s4,a5,2630 <stbsp_vsprintfcb+0x1362>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    1d9e:	0005071b          	sext.w	a4,a0
         if (dp > 0) {
    1da2:	7ef057e3          	blez	a5,2d90 <stbsp_vsprintfcb+0x1ac2>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    1da6:	4881                	li	a7,0
    1da8:	00e7d463          	bge	a5,a4,1db0 <stbsp_vsprintfcb+0xae2>
    1dac:	40f508bb          	subw	a7,a0,a5
         tail[0] = 0;
    1db0:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    1db4:	20029463          	bnez	t0,1fbc <stbsp_vsprintfcb+0xcee>
   } else if (fl & STBSP__LEADINGSPACE) {
    1db8:	004e7713          	andi	a4,t3,4
    1dbc:	000715e3          	bnez	a4,25c6 <stbsp_vsprintfcb+0x12f8>
   } else if (fl & STBSP__LEADINGPLUS) {
    1dc0:	002e7713          	andi	a4,t3,2
    1dc4:	660719e3          	bnez	a4,2c36 <stbsp_vsprintfcb+0x1968>
   sign[0] = 0;
    1dc8:	06010423          	sb	zero,104(sp)
    1dcc:	aaed                	j	1fc6 <stbsp_vsprintfcb+0xcf8>
         h = (f[0] == 'A') ? hexu : hex;
    1dce:	04100713          	li	a4,65
    1dd2:	00005597          	auipc	a1,0x5
    1dd6:	ca658593          	addi	a1,a1,-858 # 6a78 <hex.0>
    1dda:	00e783e3          	beq	a5,a4,25e0 <stbsp_vsprintfcb+0x1312>
         fv = va_arg(va, double);
    1dde:	008b8693          	addi	a3,s7,8
         if (pr == -1)
    1de2:	577d                	li	a4,-1
         fv = va_arg(va, double);
    1de4:	e0b6                	sd	a3,64(sp)
    1de6:	000bb783          	ld	a5,0(s7)
         if (pr == -1)
    1dea:	7ee88963          	beq	a7,a4,25dc <stbsp_vsprintfcb+0x130e>
   d = value;

   STBSP__COPYFP(b, d);

   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    1dee:	4347d613          	srai	a2,a5,0x34
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    1df2:	00c79513          	slli	a0,a5,0xc
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    1df6:	7ff67613          	andi	a2,a2,2047
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    1dfa:	8131                	srli	a0,a0,0xc
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    1dfc:	c016061b          	addiw	a2,a2,-1023
         if (stbsp__real_to_parts((stbsp__int64 *)&n64, &dp, fv))
    1e00:	7a07c863          	bltz	a5,25b0 <stbsp_vsprintfcb+0x12e2>
   } else if (fl & STBSP__LEADINGSPACE) {
    1e04:	004e7793          	andi	a5,t3,4
    1e08:	60078ee3          	beqz	a5,2c24 <stbsp_vsprintfcb+0x1956>
    1e0c:	6789                	lui	a5,0x2
    1e0e:	2785                	addiw	a5,a5,1 # 2001 <stbsp_vsprintfcb+0xd33>
      sign[0] = 1;
    1e10:	06f11423          	sh	a5,104(sp)
    1e14:	468d                	li	a3,3
    1e16:	4a0d                	li	s4,3
    1e18:	4809                	li	a6,2
            n64 |= (((stbsp__uint64)1) << 52);
    1e1a:	4705                	li	a4,1
    1e1c:	1752                	slli	a4,a4,0x34
         if (dp == -1023)
    1e1e:	c0100793          	li	a5,-1023
            n64 |= (((stbsp__uint64)1) << 52);
    1e22:	8f49                	or	a4,a4,a0
         if (dp == -1023)
    1e24:	5cf600e3          	beq	a2,a5,2be4 <stbsp_vsprintfcb+0x1916>
         if (pr < 15)
    1e28:	4539                	li	a0,14
         n64 <<= (64 - 56);
    1e2a:	00871793          	slli	a5,a4,0x8
         if (pr < 15)
    1e2e:	251546e3          	blt	a0,a7,287a <stbsp_vsprintfcb+0x15ac>
            n64 += ((((stbsp__uint64)8) << 56) >> (pr * 4));
    1e32:	4705                	li	a4,1
    1e34:	0028951b          	slliw	a0,a7,0x2
    1e38:	176e                	slli	a4,a4,0x3b
    1e3a:	00a75733          	srl	a4,a4,a0
    1e3e:	973e                	add	a4,a4,a5
         *s++ = h[(n64 >> 60) & 15];
    1e40:	03c75793          	srli	a5,a4,0x3c
    1e44:	97ae                	add	a5,a5,a1
    1e46:	0007c503          	lbu	a0,0(a5)
         lead[1 + lead[0]] = '0';
    1e4a:	22080793          	addi	a5,a6,544
    1e4e:	06010813          	addi	a6,sp,96
    1e52:	97c2                	add	a5,a5,a6
    1e54:	03000813          	li	a6,48
    1e58:	df078423          	sb	a6,-536(a5)
         lead[2 + lead[0]] = 'x';
    1e5c:	22068793          	addi	a5,a3,544
    1e60:	1094                	addi	a3,sp,96
    1e62:	96be                	add	a3,a3,a5
    1e64:	07800793          	li	a5,120
    1e68:	def68423          	sb	a5,-536(a3)
         lead[0] += 2;
    1e6c:	07410423          	sb	s4,104(sp)
         *s++ = h[(n64 >> 60) & 15];
    1e70:	0ca10023          	sb	a0,192(sp)
         if (pr)
    1e74:	740893e3          	bnez	a7,2dba <stbsp_vsprintfcb+0x1aec>
         sn = s;
    1e78:	0c110793          	addi	a5,sp,193
    1e7c:	fcbe                	sd	a5,120(sp)
    1e7e:	4701                	li	a4,0
    1e80:	4501                	li	a0,0
    1e82:	4305                	li	t1,1
    1e84:	4685                	li	a3,1
         tail[1] = h[17];
    1e86:	0115c583          	lbu	a1,17(a1)
            tail[2] = '+';
    1e8a:	02b00793          	li	a5,43
         tail[1] = h[17];
    1e8e:	06b108a3          	sb	a1,113(sp)
         if (dp < 0) {
    1e92:	00065663          	bgez	a2,1e9e <stbsp_vsprintfcb+0xbd0>
            dp = -dp;
    1e96:	40c0063b          	negw	a2,a2
            tail[2] = '-';
    1e9a:	02d00793          	li	a5,45
            tail[n] = '0' + dp % 10;
    1e9e:	4829                	li	a6,10
    1ea0:	030665bb          	remw	a1,a2,a6
    1ea4:	06f10923          	sb	a5,114(sp)
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    1ea8:	3e700e93          	li	t4,999
            tail[n] = '0' + dp % 10;
    1eac:	0305859b          	addiw	a1,a1,48
    1eb0:	0ff5f593          	zext.b	a1,a1
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    1eb4:	18cec3e3          	blt	t4,a2,283a <stbsp_vsprintfcb+0x156c>
    1eb8:	06300e93          	li	t4,99
    1ebc:	54cec1e3          	blt	t4,a2,2bfe <stbsp_vsprintfcb+0x1930>
    1ec0:	4ea5                	li	t4,9
    1ec2:	72ced6e3          	bge	t4,a2,2dee <stbsp_vsprintfcb+0x1b20>
            dp /= 10;
    1ec6:	030647bb          	divw	a5,a2,a6
         tail[0] = (char)n;
    1eca:	4611                	li	a2,4
    1ecc:	06c10823          	sb	a2,112(sp)
            tail[n] = '0' + dp % 10;
    1ed0:	06b10a23          	sb	a1,116(sp)
    1ed4:	4811                	li	a6,4
    1ed6:	4f91                	li	t6,4
    1ed8:	0307879b          	addiw	a5,a5,48
    1edc:	06f109a3          	sb	a5,115(sp)
         n = pr + lead[0] + tail[0] + tz;
    1ee0:	006a07bb          	addw	a5,s4,t1
    1ee4:	010787bb          	addw	a5,a5,a6
    1ee8:	0117863b          	addw	a2,a5,a7
         dp = (int)(s - sn);
    1eec:	d2aa                	sw	a0,100(sp)
         l = (int)(s - (num + 64));
    1eee:	d0b6                	sw	a3,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    1ef0:	87b2                	mv	a5,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    1ef2:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    1ef6:	835a                	mv	t1,s6
    1ef8:	00cb5363          	bge	s6,a2,1efe <stbsp_vsprintfcb+0xc30>
    1efc:	8332                	mv	t1,a2
         cs = 1 + (3 << 24);
    1efe:	030002b7          	lui	t0,0x3000
         fw -= n;
    1f02:	40f3033b          	subw	t1,t1,a5
         cs = 1 + (3 << 24);
    1f06:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff8779>
         s = num + 64;
    1f08:	0c010a93          	addi	s5,sp,192
         goto scopy;
    1f0c:	b311                	j	1c10 <stbsp_vsprintfcb+0x942>
         h = (f[0] == 'B') ? hexu : hex;
    1f0e:	04200713          	li	a4,66
    1f12:	00005817          	auipc	a6,0x5
    1f16:	b6680813          	addi	a6,a6,-1178 # 6a78 <hex.0>
    1f1a:	6ce78963          	beq	a5,a4,25ec <stbsp_vsprintfcb+0x131e>
         if (fl & STBSP__LEADING_0X) {
    1f1e:	008e7793          	andi	a5,t3,8
    1f22:	66079e63          	bnez	a5,259e <stbsp_vsprintfcb+0x12d0>
         lead[0] = 0;
    1f26:	06010423          	sb	zero,104(sp)
         l = (8 << 4) | (1 << 8);
    1f2a:	18000793          	li	a5,384
    1f2e:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__INTMAX) {
    1f30:	020e7713          	andi	a4,t3,32
         goto radixnum;
    1f34:	b979                	j	1bd2 <stbsp_vsprintfcb+0x904>
         *s = (char)va_arg(va, int);
    1f36:	000ba783          	lw	a5,0(s7)
         l = 1;
    1f3a:	4705                	li	a4,1
    1f3c:	d0ba                	sw	a4,96(sp)
         *s = (char)va_arg(va, int);
    1f3e:	26f10fa3          	sb	a5,639(sp)
    1f42:	008b8793          	addi	a5,s7,8
         lead[0] = 0;
    1f46:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    1f4a:	06010823          	sb	zero,112(sp)
         dp = 0;
    1f4e:	d282                	sw	zero,100(sp)
         *s = (char)va_arg(va, int);
    1f50:	e0be                	sd	a5,64(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    1f52:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    1f56:	835a                	mv	t1,s6
    1f58:	69605063          	blez	s6,25d8 <stbsp_vsprintfcb+0x130a>
         fw -= n;
    1f5c:	337d                	addiw	t1,t1,-1
         goto scopy;
    1f5e:	4701                	li	a4,0
    1f60:	4f81                	li	t6,0
    1f62:	4685                	li	a3,1
    1f64:	4a01                	li	s4,0
         cs = 0;
    1f66:	4281                	li	t0,0
         s = num + STBSP__NUMSZ - 1;
    1f68:	27f10a93          	addi	s5,sp,639
      tz = 0;
    1f6c:	4881                	li	a7,0
         goto scopy;
    1f6e:	b14d                	j	1c10 <stbsp_vsprintfcb+0x942>
         fv = va_arg(va, double);
    1f70:	008b8713          	addi	a4,s7,8
         if (fl & STBSP__METRIC_SUFFIX) {
    1f74:	100e7793          	andi	a5,t3,256
         fv = va_arg(va, double);
    1f78:	e0ba                	sd	a4,64(sp)
    1f7a:	000bb507          	fld	fa0,0(s7)
         if (fl & STBSP__METRIC_SUFFIX) {
    1f7e:	be0795e3          	bnez	a5,1b68 <stbsp_vsprintfcb+0x89a>
         if (pr == -1)
    1f82:	57fd                	li	a5,-1
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    1f84:	0008871b          	sext.w	a4,a7
         if (pr == -1)
    1f88:	00f89463          	bne	a7,a5,1f90 <stbsp_vsprintfcb+0xcc2>
    1f8c:	4719                	li	a4,6
            pr = 6; // default is 6
    1f8e:	4899                	li	a7,6
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    1f90:	10d4                	addi	a3,sp,100
    1f92:	0110                	addi	a2,sp,128
    1f94:	108c                	addi	a1,sp,96
    1f96:	18a8                	addi	a0,sp,120
    1f98:	f01e                	sd	t2,32(sp)
    1f9a:	ec72                	sd	t3,24(sp)
    1f9c:	e846                	sd	a7,16(sp)
    1f9e:	a4cfe0ef          	jal	1ea <stbsp__real_to_str>
    1fa2:	6e62                	ld	t3,24(sp)
    1fa4:	68c2                	ld	a7,16(sp)
    1fa6:	7382                	ld	t2,32(sp)
         if (dp == STBSP__SPECIAL) {
    1fa8:	5796                	lw	a5,100(sp)
            if ((stbsp__int32)(l + n) > pr)
    1faa:	5686                	lw	a3,96(sp)
   if (fl & STBSP__NEGATIVE) {
    1fac:	080e7293          	andi	t0,t3,128
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    1fb0:	e00500e3          	beqz	a0,1db0 <stbsp_vsprintfcb+0xae2>
            fl |= STBSP__NEGATIVE;
    1fb4:	080e6e13          	ori	t3,t3,128
         tail[0] = 0;
    1fb8:	06010823          	sb	zero,112(sp)
      sign[0] = 1;
    1fbc:	670d                	lui	a4,0x3
    1fbe:	d0170713          	addi	a4,a4,-767 # 2d01 <stbsp_vsprintfcb+0x1a33>
    1fc2:	06e11423          	sh	a4,104(sp)
         if (dp == STBSP__SPECIAL) {
    1fc6:	671d                	lui	a4,0x7
    1fc8:	7ce78963          	beq	a5,a4,279a <stbsp_vsprintfcb+0x14cc>
         if (dp <= 0) {
    1fcc:	46f05fe3          	blez	a5,2c4a <stbsp_vsprintfcb+0x197c>
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((600 - (stbsp__uint32)dp) % 3) : 0;
    1fd0:	040e7313          	andi	t1,t3,64
    1fd4:	00078e9b          	sext.w	t4,a5
    1fd8:	4581                	li	a1,0
    1fda:	00030963          	beqz	t1,1fec <stbsp_vsprintfcb+0xd1e>
    1fde:	25800593          	li	a1,600
    1fe2:	41d585bb          	subw	a1,a1,t4
    1fe6:	470d                	li	a4,3
    1fe8:	02e5f5bb          	remuw	a1,a1,a4
                     *s++ = stbsp__comma;
    1fec:	00005a17          	auipc	s4,0x5
    1ff0:	9a4a0a13          	addi	s4,s4,-1628 # 6990 <stbsp__digitpair>
            s = (char *)sn;
    1ff4:	7f66                	ld	t5,120(sp)
                     *s++ = stbsp__comma;
    1ff6:	0cda4283          	lbu	t0,205(s4)
         s = num + 64;
    1ffa:	0c010a93          	addi	s5,sp,192
            if ((stbsp__uint32)dp >= l) {
    1ffe:	44defb63          	bgeu	t4,a3,2454 <stbsp_vsprintfcb+0x1186>
               n = 0;
    2002:	4501                	li	a0,0
         s = num + 64;
    2004:	8756                	mv	a4,s5
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2006:	4b91                	li	s7,4
    2008:	a015                	j	202c <stbsp_vsprintfcb+0xd5e>
    200a:	8642                	mv	a2,a6
    200c:	883a                	mv	a6,a4
    200e:	8732                	mv	a4,a2
                     *s++ = sn[n];
    2010:	02051613          	slli	a2,a0,0x20
    2014:	9201                	srli	a2,a2,0x20
    2016:	967a                	add	a2,a2,t5
    2018:	00064f83          	lbu	t6,0(a2)
                     ++n;
    201c:	0015061b          	addiw	a2,a0,1
    2020:	0006051b          	sext.w	a0,a2
                     *s++ = sn[n];
    2024:	fff70fa3          	sb	t6,-1(a4) # 6fff <_stdout+0x14f>
                     if (n >= (stbsp__uint32)dp)
    2028:	7bd57563          	bgeu	a0,t4,27d2 <stbsp_vsprintfcb+0x1504>
                     *s++ = stbsp__comma;
    202c:	00170813          	addi	a6,a4,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2030:	fc030de3          	beqz	t1,200a <stbsp_vsprintfcb+0xd3c>
    2034:	2585                	addiw	a1,a1,1
    2036:	fd759ae3          	bne	a1,s7,200a <stbsp_vsprintfcb+0xd3c>
                     *s++ = stbsp__comma;
    203a:	fe580fa3          	sb	t0,-1(a6)
    203e:	0709                	addi	a4,a4,2
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2040:	4585                	li	a1,1
    2042:	b7f9                	j	2010 <stbsp_vsprintfcb+0xd42>
         *d = tlen + (int)(bf - buf);
    2044:	000bb703          	ld	a4,0(s7)
    2048:	412407b3          	sub	a5,s0,s2
    204c:	01a787bb          	addw	a5,a5,s10
         int *d = va_arg(va, int *);
    2050:	008b8693          	addi	a3,s7,8
    2054:	e0b6                	sd	a3,64(sp)
         *d = tlen + (int)(bf - buf);
    2056:	c31c                	sw	a5,0(a4)
      } break;
    2058:	bae5                	j	1a50 <stbsp_vsprintfcb+0x782>
         if (fl & STBSP__LEADING_0X) {
    205a:	008e7793          	andi	a5,t3,8
    205e:	50079b63          	bnez	a5,2574 <stbsp_vsprintfcb+0x12a6>
         lead[0] = 0;
    2062:	06010423          	sb	zero,104(sp)
         l = (3 << 4) | (3 << 8);
    2066:	33000793          	li	a5,816
    206a:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__INTMAX) {
    206c:	020e7713          	andi	a4,t3,32
         h = hexu;
    2070:	00005817          	auipc	a6,0x5
    2074:	9f080813          	addi	a6,a6,-1552 # 6a60 <hexu.1>
         goto radixnum;
    2078:	bea9                	j	1bd2 <stbsp_vsprintfcb+0x904>
         fl &= ~STBSP__LEADINGZERO; // 'p' only prints the pointer with zeros
    207a:	fefe7e13          	andi	t3,t3,-17
    207e:	020e6e13          	ori	t3,t3,32
    2082:	02000713          	li	a4,32
         pr = sizeof(void *) * 2;
    2086:	48c1                	li	a7,16
         h = (f[0] == 'X') ? hexu : hex;
    2088:	00005817          	auipc	a6,0x5
    208c:	9f080813          	addi	a6,a6,-1552 # 6a78 <hex.0>
    2090:	be05                	j	1bc0 <stbsp_vsprintfcb+0x8f2>
         s = va_arg(va, char *);
    2092:	000bba83          	ld	s5,0(s7)
    2096:	008b8793          	addi	a5,s7,8
    209a:	e0be                	sd	a5,64(sp)
         if (s == 0)
    209c:	360a8ee3          	beqz	s5,2c18 <stbsp_vsprintfcb+0x194a>
      if (((stbsp__uintptr)sn & 3) == 0)
    20a0:	003af793          	andi	a5,s5,3
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    20a4:	5208c663          	bltz	a7,25d0 <stbsp_vsprintfcb+0x1302>
    20a8:	0008869b          	sext.w	a3,a7
      if (((stbsp__uintptr)sn & 3) == 0)
    20ac:	2a0782e3          	beqz	a5,2b50 <stbsp_vsprintfcb+0x1882>
      if (!limit || *sn == 0)
    20b0:	5a068b63          	beqz	a3,2666 <stbsp_vsprintfcb+0x1398>
      if (((stbsp__uintptr)sn & 3) == 0)
    20b4:	87d6                	mv	a5,s5
    20b6:	a801                	j	20c6 <stbsp_vsprintfcb+0xdf8>
      ++sn;
    20b8:	0785                	addi	a5,a5,1
      if (((stbsp__uintptr)sn & 3) == 0)
    20ba:	0037f713          	andi	a4,a5,3
      --limit;
    20be:	36fd                	addiw	a3,a3,-1
      if (((stbsp__uintptr)sn & 3) == 0)
    20c0:	280709e3          	beqz	a4,2b52 <stbsp_vsprintfcb+0x1884>
      if (!limit || *sn == 0)
    20c4:	c681                	beqz	a3,20cc <stbsp_vsprintfcb+0xdfe>
    20c6:	0007c703          	lbu	a4,0(a5)
    20ca:	f77d                	bnez	a4,20b8 <stbsp_vsprintfcb+0xdea>
         return (stbsp__uint32)(sn - s);
    20cc:	415787b3          	sub	a5,a5,s5
    20d0:	0007869b          	sext.w	a3,a5
         if (pr < (stbsp__int32)l)
    20d4:	fff6c713          	not	a4,a3
    20d8:	977d                	srai	a4,a4,0x3f
    20da:	8f7d                	and	a4,a4,a5
    20dc:	0007079b          	sext.w	a5,a4
         n = pr + lead[0] + tail[0] + tz;
    20e0:	863e                	mv	a2,a5
         pr -= l;
    20e2:	9f15                	subw	a4,a4,a3
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    20e4:	d0b6                	sw	a3,96(sp)
         lead[0] = 0;
    20e6:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    20ea:	06010823          	sb	zero,112(sp)
         dp = 0;
    20ee:	d282                	sw	zero,100(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    20f0:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    20f4:	835a                	mv	t1,s6
    20f6:	00fb5363          	bge	s6,a5,20fc <stbsp_vsprintfcb+0xe2e>
    20fa:	833e                	mv	t1,a5
         fw -= n;
    20fc:	40c3033b          	subw	t1,t1,a2
         goto scopy;
    2100:	4f81                	li	t6,0
    2102:	4a01                	li	s4,0
         cs = 0;
    2104:	4281                	li	t0,0
      tz = 0;
    2106:	4881                	li	a7,0
         goto scopy;
    2108:	b621                	j	1c10 <stbsp_vsprintfcb+0x942>
                     *bf++ = stbsp__comma;
    210a:	87b2                	mv	a5,a2
                     cs = 0;
    210c:	4a01                	li	s4,0
    210e:	e44ff06f          	j	1752 <stbsp_vsprintfcb+0x484>
               lead[0] -= (char)i;
    2112:	06010423          	sb	zero,104(sp)
               while (i) {
    2116:	d38ff06f          	j	164e <stbsp_vsprintfcb+0x380>
            lead[0] -= (char)i;
    211a:	06010423          	sb	zero,104(sp)
            while (i) {
    211e:	ed8ff06f          	j	17f6 <stbsp_vsprintfcb+0x528>
            while (i >= 4) {
    2122:	06fadc63          	bge	s5,a5,219a <stbsp_vsprintfcb+0xecc>
            tz -= i;
    2126:	8722                	mv	a4,s0
    2128:	0007851b          	sext.w	a0,a5
            while (i >= 4) {
    212c:	008785bb          	addw	a1,a5,s0
               *(stbsp__uint32 *)bf = 0x30303030;
    2130:	01672023          	sw	s6,0(a4)
               bf += 4;
    2134:	0711                	addi	a4,a4,4
            while (i >= 4) {
    2136:	40e5863b          	subw	a2,a1,a4
    213a:	fecacbe3          	blt	s5,a2,2130 <stbsp_vsprintfcb+0xe62>
    213e:	ffc5061b          	addiw	a2,a0,-4
    2142:	0026561b          	srliw	a2,a2,0x2
    2146:	0016071b          	addiw	a4,a2,1
    214a:	37f1                	addiw	a5,a5,-4
    214c:	0026161b          	slliw	a2,a2,0x2
    2150:	070a                	slli	a4,a4,0x2
    2152:	9722                	add	a4,a4,s0
    2154:	9f91                	subw	a5,a5,a2
            while (i) {
    2156:	843a                	mv	s0,a4
    2158:	80078de3          	beqz	a5,1972 <stbsp_vsprintfcb+0x6a4>
    215c:	1782                	slli	a5,a5,0x20
    215e:	9381                	srli	a5,a5,0x20
    2160:	00f70433          	add	s0,a4,a5
               *bf++ = '0';
    2164:	0705                	addi	a4,a4,1
    2166:	ff470fa3          	sb	s4,-1(a4)
            while (i) {
    216a:	fe871de3          	bne	a4,s0,2164 <stbsp_vsprintfcb+0xe96>
    216e:	805ff06f          	j	1972 <stbsp_vsprintfcb+0x6a4>
               stbsp__cb_buf_clamp(i, pr);
    2172:	85ce                	mv	a1,s3
               if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    2174:	4981                	li	s3,0
    2176:	dc049263          	bnez	s1,173a <stbsp_vsprintfcb+0x46c>
    217a:	b8d5                	j	1a6e <stbsp_vsprintfcb+0x7a0>
            STBSP__UNALIGNED(while (i >= 4) {
    217c:	4401                	li	s0,0
    217e:	85be                	mv	a1,a5
    2180:	f0ea4b63          	blt	s4,a4,1896 <stbsp_vsprintfcb+0x5c8>
    2184:	f42ff06f          	j	18c6 <stbsp_vsprintfcb+0x5f8>
               if ((((stbsp__uintptr)bf) & 3) == 0)
    2188:	00347713          	andi	a4,s0,3
            stbsp__cb_buf_clamp(i, tz);
    218c:	87c6                	mv	a5,a7
            tz -= i;
    218e:	4881                	li	a7,0
               if ((((stbsp__uintptr)bf) & 3) == 0)
    2190:	fc071c63          	bnez	a4,1968 <stbsp_vsprintfcb+0x69a>
            while (i >= 4) {
    2194:	470d                	li	a4,3
    2196:	f8f748e3          	blt	a4,a5,2126 <stbsp_vsprintfcb+0xe58>
    219a:	8722                	mv	a4,s0
    219c:	b7c1                	j	215c <stbsp_vsprintfcb+0xe8e>
            tail[0] -= (char)i;
    219e:	06010823          	sb	zero,112(sp)
            while (i) {
    21a2:	b0b9                	j	19f0 <stbsp_vsprintfcb+0x722>
                  while (i >= 4) {
    21a4:	478d                	li	a5,3
    21a6:	8622                	mv	a2,s0
    21a8:	d8b7d963          	bge	a5,a1,173a <stbsp_vsprintfcb+0x46c>
    21ac:	ffc5839b          	addiw	t2,a1,-4
    21b0:	0023d79b          	srliw	a5,t2,0x2
    21b4:	0017859b          	addiw	a1,a5,1
    21b8:	058a                	slli	a1,a1,0x2
    21ba:	942e                	add	s0,s0,a1
                     *(stbsp__uint32 *)bf = 0x30303030;
    21bc:	01762023          	sw	s7,0(a2)
                     bf += 4;
    21c0:	0611                	addi	a2,a2,4
                  while (i >= 4) {
    21c2:	fe861de3          	bne	a2,s0,21bc <stbsp_vsprintfcb+0xeee>
    21c6:	0027979b          	slliw	a5,a5,0x2
    21ca:	40f385bb          	subw	a1,t2,a5
    21ce:	d68ff06f          	j	1736 <stbsp_vsprintfcb+0x468>
            while (i) {
    21d2:	85be                	mv	a1,a5
    21d4:	ee071963          	bnez	a4,18c6 <stbsp_vsprintfcb+0x5f8>
    21d8:	f16ff06f          	j	18ee <stbsp_vsprintfcb+0x620>
    21dc:	2c013a03          	ld	s4,704(sp)
    21e0:	2b813a83          	ld	s5,696(sp)
    21e4:	2b013b03          	ld	s6,688(sp)
    21e8:	8ca2                	mv	s9,s0
    21ea:	a04ff06f          	j	13ee <stbsp_vsprintfcb+0x120>
            stbsp__chk_cb_buf(1);
    21ee:	2601                	sext.w	a2,a2
    21f0:	1fe00793          	li	a5,510
    21f4:	f8c7c563          	blt	a5,a2,197e <stbsp_vsprintfcb+0x6b0>
    21f8:	f3eff06f          	j	1936 <stbsp_vsprintfcb+0x668>
               fl &= ~STBSP__TRIPLET_COMMA; // if no leading zeros, then no commas
    21fc:	fbfe7e13          	andi	t3,t3,-65
         if (fw + pr) {
    2200:	006707bb          	addw	a5,a4,t1
               fl &= ~STBSP__TRIPLET_COMMA; // if no leading zeros, then no commas
    2204:	2e01                	sext.w	t3,t3
         if (fw + pr) {
    2206:	a0078be3          	beqz	a5,1c1c <stbsp_vsprintfcb+0x94e>
               while (fw > 0) {
    220a:	be605663          	blez	t1,15f6 <stbsp_vsprintfcb+0x328>
                     *(stbsp__uint32 *)bf = 0x20202020;
    220e:	20202837          	lui	a6,0x20202
                  stbsp__cb_buf_clamp(i, fw);
    2212:	854a                	mv	a0,s2
    2214:	894e                	mv	s2,s3
    2216:	69a2                	ld	s3,8(sp)
                     *(stbsp__uint32 *)bf = 0x20202020;
    2218:	02080813          	addi	a6,a6,32 # 20202020 <_ZSt4cerr+0x201fa798>
                  stbsp__cb_buf_clamp(i, fw);
    221c:	ec52                	sd	s4,24(sp)
    221e:	f426                	sd	s1,40(sp)
    2220:	87a2                	mv	a5,s0
    2222:	84ea                	mv	s1,s10
                  stbsp__chk_cb_buf(1);
    2224:	1fe00f13          	li	t5,510
                  stbsp__cb_buf_clamp(i, fw);
    2228:	8d6e                	mv	s10,s11
                     *bf++ = ' ';
    222a:	02000b13          	li	s6,32
                  stbsp__cb_buf_clamp(i, fw);
    222e:	8de6                	mv	s11,s9
                  while (i >= 4) {
    2230:	4b8d                	li	s7,3
                  stbsp__cb_buf_clamp(i, fw);
    2232:	20000e93          	li	t4,512
    2236:	e846                	sd	a7,16(sp)
    2238:	f07e                	sd	t6,32(sp)
    223a:	f836                	sd	a3,48(sp)
    223c:	e4f2                	sd	t3,72(sp)
    223e:	e8ba                	sd	a4,80(sp)
    2240:	ec96                	sd	t0,88(sp)
    2242:	841a                	mv	s0,t1
    2244:	8a42                	mv	s4,a6
    2246:	8c9e                	mv	s9,t2
    2248:	0c090063          	beqz	s2,2308 <stbsp_vsprintfcb+0x103a>
    224c:	40a78633          	sub	a2,a5,a0
    2250:	40ce873b          	subw	a4,t4,a2
    2254:	86ba                	mv	a3,a4
    2256:	00e45363          	bge	s0,a4,225c <stbsp_vsprintfcb+0xf8e>
    225a:	86a2                	mv	a3,s0
    225c:	0006871b          	sext.w	a4,a3
                  fw -= i;
    2260:	9c15                	subw	s0,s0,a3
                  while (i) {
    2262:	e719                	bnez	a4,2270 <stbsp_vsprintfcb+0xfa2>
    2264:	a095                	j	22c8 <stbsp_vsprintfcb+0xffa>
                     *bf++ = ' ';
    2266:	01678023          	sb	s6,0(a5)
                     --i;
    226a:	377d                	addiw	a4,a4,-1
                     *bf++ = ' ';
    226c:	0785                	addi	a5,a5,1
                  while (i) {
    226e:	cb29                	beqz	a4,22c0 <stbsp_vsprintfcb+0xff2>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    2270:	0037f693          	andi	a3,a5,3
    2274:	faed                	bnez	a3,2266 <stbsp_vsprintfcb+0xf98>
                  while (i >= 4) {
    2276:	86be                	mv	a3,a5
    2278:	00070f9b          	sext.w	t6,a4
    227c:	00f705bb          	addw	a1,a4,a5
    2280:	02ebd763          	bge	s7,a4,22ae <stbsp_vsprintfcb+0xfe0>
                     *(stbsp__uint32 *)bf = 0x20202020;
    2284:	0146a023          	sw	s4,0(a3)
                     bf += 4;
    2288:	0691                	addi	a3,a3,4
                  while (i >= 4) {
    228a:	40d5863b          	subw	a2,a1,a3
    228e:	fecbcbe3          	blt	s7,a2,2284 <stbsp_vsprintfcb+0xfb6>
    2292:	ffcf861b          	addiw	a2,t6,-4 # fffffffff7fffffc <_ZSt4cerr+0xfffffffff7ff8774>
    2296:	0026561b          	srliw	a2,a2,0x2
    229a:	0016069b          	addiw	a3,a2,1
    229e:	3771                	addiw	a4,a4,-4
    22a0:	0026161b          	slliw	a2,a2,0x2
    22a4:	068a                	slli	a3,a3,0x2
    22a6:	96be                	add	a3,a3,a5
    22a8:	9f11                	subw	a4,a4,a2
                  while (i) {
    22aa:	87b6                	mv	a5,a3
    22ac:	cb11                	beqz	a4,22c0 <stbsp_vsprintfcb+0xff2>
    22ae:	1702                	slli	a4,a4,0x20
    22b0:	9301                	srli	a4,a4,0x20
    22b2:	00e687b3          	add	a5,a3,a4
                     *bf++ = ' ';
    22b6:	0685                	addi	a3,a3,1
    22b8:	ff668fa3          	sb	s6,-1(a3)
                  while (i) {
    22bc:	fef69de3          	bne	a3,a5,22b6 <stbsp_vsprintfcb+0xfe8>
                  stbsp__chk_cb_buf(1);
    22c0:	40a78633          	sub	a2,a5,a0
    22c4:	00090e63          	beqz	s2,22e0 <stbsp_vsprintfcb+0x1012>
    22c8:	2601                	sext.w	a2,a2
    22ca:	00cf5b63          	bge	t5,a2,22e0 <stbsp_vsprintfcb+0x1012>
    22ce:	85ce                	mv	a1,s3
    22d0:	9cb1                	addw	s1,s1,a2
    22d2:	9902                	jalr	s2
    22d4:	c541                	beqz	a0,235c <stbsp_vsprintfcb+0x108e>
    22d6:	87aa                	mv	a5,a0
    22d8:	20000e93          	li	t4,512
    22dc:	1fe00f13          	li	t5,510
               while (fw > 0) {
    22e0:	f68044e3          	bgtz	s0,2248 <stbsp_vsprintfcb+0xf7a>
    22e4:	8322                	mv	t1,s0
    22e6:	89ca                	mv	s3,s2
    22e8:	83e6                	mv	t2,s9
    22ea:	68c2                	ld	a7,16(sp)
    22ec:	8cee                	mv	s9,s11
    22ee:	6a62                	ld	s4,24(sp)
    22f0:	8dea                	mv	s11,s10
    22f2:	7f82                	ld	t6,32(sp)
    22f4:	8d26                	mv	s10,s1
    22f6:	76c2                	ld	a3,48(sp)
    22f8:	6e26                	ld	t3,72(sp)
    22fa:	6746                	ld	a4,80(sp)
    22fc:	62e6                	ld	t0,88(sp)
    22fe:	74a2                	ld	s1,40(sp)
    2300:	892a                	mv	s2,a0
    2302:	843e                	mv	s0,a5
    2304:	af2ff06f          	j	15f6 <stbsp_vsprintfcb+0x328>
                  stbsp__cb_buf_clamp(i, fw);
    2308:	8722                	mv	a4,s0
    230a:	4401                	li	s0,0
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    230c:	b795                	j	2270 <stbsp_vsprintfcb+0xfa2>
            n64 = va_arg(va, stbsp__uint32);
    230e:	000be683          	lwu	a3,0(s7)
    2312:	b0f9                	j	1be0 <stbsp_vsprintfcb+0x912>
    2314:	2c013a03          	ld	s4,704(sp)
    2318:	2b813a83          	ld	s5,696(sp)
    231c:	2b013b03          	ld	s6,688(sp)
    2320:	8cca                	mv	s9,s2
    2322:	8ccff06f          	j	13ee <stbsp_vsprintfcb+0x120>
    2326:	8cd6                	mv	s9,s5
    2328:	2c013a03          	ld	s4,704(sp)
    232c:	2b813a83          	ld	s5,696(sp)
    2330:	2b013b03          	ld	s6,688(sp)
    2334:	8baff06f          	j	13ee <stbsp_vsprintfcb+0x120>
    2338:	2c013a03          	ld	s4,704(sp)
    233c:	2b813a83          	ld	s5,696(sp)
    2340:	2b013b03          	ld	s6,688(sp)
    2344:	8cea                	mv	s9,s10
    2346:	8a8ff06f          	j	13ee <stbsp_vsprintfcb+0x120>
                  while (i) {
    234a:	85a2                	mv	a1,s0
    234c:	c12ff06f          	j	175e <stbsp_vsprintfcb+0x490>
                  while (i >= 4) {
    2350:	478d                	li	a5,3
    2352:	8622                	mv	a2,s0
    2354:	e4b7cce3          	blt	a5,a1,21ac <stbsp_vsprintfcb+0xede>
    2358:	be2ff06f          	j	173a <stbsp_vsprintfcb+0x46c>
    235c:	2c013a03          	ld	s4,704(sp)
    2360:	2b813a83          	ld	s5,696(sp)
    2364:	2b013b03          	ld	s6,688(sp)
    2368:	8ca6                	mv	s9,s1
    236a:	884ff06f          	j	13ee <stbsp_vsprintfcb+0x120>
            lead[2] = h[16];
    236e:	01084683          	lbu	a3,16(a6)
            lead[0] = 2;
    2372:	678d                	lui	a5,0x3
    2374:	0789                	addi	a5,a5,2 # 3002 <stbsp_vsprintf+0xa>
    2376:	06f11423          	sh	a5,104(sp)
            lead[2] = h[16];
    237a:	06d10523          	sb	a3,106(sp)
    237e:	b891                	j	1bd2 <stbsp_vsprintfcb+0x904>
    2380:	8cea                	mv	s9,s10
    2382:	86cff06f          	j	13ee <stbsp_vsprintfcb+0x120>
    2386:	4f81                	li	t6,0
    2388:	4a01                	li	s4,0
    238a:	5586                	lw	a1,96(sp)
                  *--s = stbsp__comma;
    238c:	00004f17          	auipc	t5,0x4
    2390:	6d1f4f03          	lbu	t5,1745(t5) # 6a5d <stbsp__comma>
    2394:	0510                	addi	a2,sp,640
    2396:	0085d71b          	srliw	a4,a1,0x8
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    239a:	4305                	li	t1,1
            if (fl & STBSP__TRIPLET_COMMA) {
    239c:	040e7e93          	andi	t4,t3,64
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    23a0:	0007029b          	sext.w	t0,a4
    23a4:	005317bb          	sllw	a5,t1,t0
    23a8:	37fd                	addiw	a5,a5,-1
    23aa:	8ff5                	and	a5,a5,a3
    23ac:	97c2                	add	a5,a5,a6
    23ae:	0007c783          	lbu	a5,0(a5)
            n64 >>= (l >> 8);
    23b2:	0056d6b3          	srl	a3,a3,t0
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    23b6:	fff60a93          	addi	s5,a2,-1
    23ba:	fef60fa3          	sb	a5,-1(a2)
            if (!((n64) || ((stbsp__int32)((num + STBSP__NUMSZ) - s) < pr)))
    23be:	e691                	bnez	a3,23ca <stbsp_vsprintfcb+0x10fc>
    23c0:	051c                	addi	a5,sp,640
    23c2:	415787bb          	subw	a5,a5,s5
    23c6:	0317dd63          	bge	a5,a7,2400 <stbsp_vsprintfcb+0x1132>
            if (fl & STBSP__TRIPLET_COMMA) {
    23ca:	020e8963          	beqz	t4,23fc <stbsp_vsprintfcb+0x112e>
               ++l;
    23ce:	0015879b          	addiw	a5,a1,1
               if ((l & 15) == ((l >> 4) & 15)) {
    23d2:	0047d29b          	srliw	t0,a5,0x4
    23d6:	00f2c2b3          	xor	t0,t0,a5
    23da:	00f2f293          	andi	t0,t0,15
               ++l;
    23de:	0007859b          	sext.w	a1,a5
               if ((l & 15) == ((l >> 4) & 15)) {
    23e2:	0087d71b          	srliw	a4,a5,0x8
    23e6:	00029b63          	bnez	t0,23fc <stbsp_vsprintfcb+0x112e>
                  l &= ~15;
    23ea:	9bc1                	andi	a5,a5,-16
    23ec:	0007859b          	sext.w	a1,a5
                  *--s = stbsp__comma;
    23f0:	ffe60a93          	addi	s5,a2,-2
    23f4:	ffe60f23          	sb	t5,-2(a2)
    23f8:	0087d71b          	srliw	a4,a5,0x8
    23fc:	8656                	mv	a2,s5
    23fe:	b74d                	j	23a0 <stbsp_vsprintfcb+0x10d2>
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    2400:	0045d29b          	srliw	t0,a1,0x4
    2404:	0f0006b7          	lui	a3,0xf000
         if (pr < (stbsp__int32)l)
    2408:	0007871b          	sext.w	a4,a5
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    240c:	0182929b          	slliw	t0,t0,0x18
    2410:	00d2f2b3          	and	t0,t0,a3
         n = pr + lead[0] + tail[0] + tz;
    2414:	00ef863b          	addw	a2,t6,a4
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    2418:	d0be                	sw	a5,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    241a:	8fb2                	mv	t6,a2
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    241c:	86be                	mv	a3,a5
    241e:	00f282bb          	addw	t0,t0,a5
         if (fw < (stbsp__int32)n)
    2422:	835a                	mv	t1,s6
    2424:	00cb5363          	bge	s6,a2,242a <stbsp_vsprintfcb+0x115c>
    2428:	8332                	mv	t1,a2
         fw -= n;
    242a:	41f3033b          	subw	t1,t1,t6
         pr -= l;
    242e:	9f1d                	subw	a4,a4,a5
         goto scopy;
    2430:	4f81                	li	t6,0
      tz = 0;
    2432:	4881                	li	a7,0
         goto scopy;
    2434:	fdcff06f          	j	1c10 <stbsp_vsprintfcb+0x942>
    2438:	8cda                	mv	s9,s6
    243a:	2c013a03          	ld	s4,704(sp)
    243e:	2b813a83          	ld	s5,696(sp)
    2442:	2b013b03          	ld	s6,688(sp)
    2446:	fa9fe06f          	j	13ee <stbsp_vsprintfcb+0x120>
            fl |= ((sizeof(void *) == 8) ? STBSP__INTMAX : 0);
    244a:	020e6e13          	ori	t3,t3,32
            ++f;
    244e:	0485                	addi	s1,s1,1
    2450:	864ff06f          	j	14b4 <stbsp_vsprintfcb+0x1e6>
               n = 0;
    2454:	4601                	li	a2,0
         s = num + 64;
    2456:	8756                	mv	a4,s5
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2458:	4511                	li	a0,4
                     *s++ = stbsp__comma;
    245a:	00170793          	addi	a5,a4,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    245e:	00030563          	beqz	t1,2468 <stbsp_vsprintfcb+0x119a>
    2462:	2585                	addiw	a1,a1,1
    2464:	10a58363          	beq	a1,a0,256a <stbsp_vsprintfcb+0x129c>
    2468:	873e                	mv	a4,a5
                     *s++ = sn[n];
    246a:	02061793          	slli	a5,a2,0x20
    246e:	9381                	srli	a5,a5,0x20
    2470:	97fa                	add	a5,a5,t5
    2472:	0007c803          	lbu	a6,0(a5)
                     ++n;
    2476:	2605                	addiw	a2,a2,1
                     *s++ = sn[n];
    2478:	ff070fa3          	sb	a6,-1(a4)
                     if (n >= l)
    247c:	fcd66fe3          	bltu	a2,a3,245a <stbsp_vsprintfcb+0x118c>
               if (n < (stbsp__uint32)dp) {
    2480:	0bd663e3          	bltu	a2,t4,2d26 <stbsp_vsprintfcb+0x1a58>
               cs = (int)(s - (num + 64)) + (3 << 24); // cs is how many tens
    2484:	415707b3          	sub	a5,a4,s5
    2488:	030002b7          	lui	t0,0x3000
    248c:	00f282bb          	addw	t0,t0,a5
               if (pr) {
    2490:	00088a63          	beqz	a7,24a4 <stbsp_vsprintfcb+0x11d6>
                  *s++ = stbsp__period;
    2494:	0cca4683          	lbu	a3,204(s4)
    2498:	00170793          	addi	a5,a4,1
         l = (stbsp__uint32)(s - (num + 64));
    249c:	415787b3          	sub	a5,a5,s5
                  *s++ = stbsp__period;
    24a0:	00d70023          	sb	a3,0(a4)
         if (fl & STBSP__METRIC_SUFFIX) {
    24a4:	100e7713          	andi	a4,t3,256
    24a8:	86f2                	mv	a3,t3
    24aa:	2c070163          	beqz	a4,276c <stbsp_vsprintfcb+0x149e>
            if (fl & STBSP__METRIC_NOSPACE)
    24ae:	40ae5f9b          	sraiw	t6,t3,0xa
    24b2:	001fcf93          	xori	t6,t6,1
    24b6:	001fff93          	andi	t6,t6,1
            tail[1] = ' ';
    24ba:	02000713          	li	a4,32
    24be:	06e108a3          	sb	a4,113(sp)
            tail[0] = idx;
    24c2:	07f10823          	sb	t6,112(sp)
               if (fl >> 24) { // SI kilo is 'k', JEDEC and SI kibits are 'K'.
    24c6:	018e561b          	srliw	a2,t3,0x18
    24ca:	018e571b          	srliw	a4,t3,0x18
         n = pr + lead[0] + tail[0] + tz;
    24ce:	000f859b          	sext.w	a1,t6
               if (fl >> 24) { // SI kilo is 'k', JEDEC and SI kibits are 'K'.
    24d2:	c225                	beqz	a2,2532 <stbsp_vsprintfcb+0x1264>
                  if (fl & STBSP__METRIC_1024)
    24d4:	001f859b          	addiw	a1,t6,1
    24d8:	0ff5f613          	zext.b	a2,a1
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    24dc:	1702                	slli	a4,a4,0x20
                  if (fl & STBSP__METRIC_1024)
    24de:	03469513          	slli	a0,a3,0x34
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    24e2:	85b2                	mv	a1,a2
    24e4:	9301                	srli	a4,a4,0x20
                  if (fl & STBSP__METRIC_1024)
    24e6:	06055ee3          	bgez	a0,2d62 <stbsp_vsprintfcb+0x1a94>
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    24ea:	00003517          	auipc	a0,0x3
    24ee:	bee50513          	addi	a0,a0,-1042 # 50d8 <_GLOBAL__sub_I__ZSt3cin+0xe8>
    24f2:	972a                	add	a4,a4,a0
    24f4:	00074503          	lbu	a0,0(a4)
                  if (fl & STBSP__METRIC_1024 && !(fl & STBSP__METRIC_JEDEC)) {
    24f8:	6709                	lui	a4,0x2
    24fa:	80070713          	addi	a4,a4,-2048 # 1800 <stbsp_vsprintfcb+0x532>
    24fe:	8f75                	and	a4,a4,a3
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    2500:	06010813          	addi	a6,sp,96
    2504:	22060693          	addi	a3,a2,544
    2508:	96c2                	add	a3,a3,a6
    250a:	dea68823          	sb	a0,-528(a3) # efffdf0 <_ZSt4cerr+0xeff8568>
                  if (fl & STBSP__METRIC_1024 && !(fl & STBSP__METRIC_JEDEC)) {
    250e:	8007071b          	addiw	a4,a4,-2048
    2512:	060715e3          	bnez	a4,2d7c <stbsp_vsprintfcb+0x1aae>
                     tail[idx + 1] = 'i';
    2516:	2f89                	addiw	t6,t6,2
    2518:	0ffff593          	zext.b	a1,t6
    251c:	1094                	addi	a3,sp,96
    251e:	22058713          	addi	a4,a1,544
    2522:	9736                	add	a4,a4,a3
    2524:	06900693          	li	a3,105
    2528:	8fae                	mv	t6,a1
    252a:	ded70823          	sb	a3,-528(a4)
                  tail[0] = idx;
    252e:	07f10823          	sb	t6,112(sp)
         l = (stbsp__uint32)(s - (num + 64));
    2532:	0007869b          	sext.w	a3,a5
         n = pr + lead[0] + tail[0] + tz;
    2536:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    253a:	fff6c713          	not	a4,a3
    253e:	977d                	srai	a4,a4,0x3f
    2540:	8ff9                	and	a5,a5,a4
         n = pr + lead[0] + tail[0] + tz;
    2542:	00fa073b          	addw	a4,s4,a5
    2546:	9f2d                	addw	a4,a4,a1
    2548:	0117063b          	addw	a2,a4,a7
         l = (stbsp__uint32)(s - (num + 64));
    254c:	d0b6                	sw	a3,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    254e:	8732                	mv	a4,a2
         if (pr < (stbsp__int32)l)
    2550:	2781                	sext.w	a5,a5
         if ((fl & STBSP__LEFTJUST) == 0) {
    2552:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    2556:	835a                	mv	t1,s6
    2558:	00cb5363          	bge	s6,a2,255e <stbsp_vsprintfcb+0x1290>
    255c:	8332                	mv	t1,a2
         fw -= n;
    255e:	40e3033b          	subw	t1,t1,a4
         pr -= l;
    2562:	40d7873b          	subw	a4,a5,a3
         goto scopy;
    2566:	eaaff06f          	j	1c10 <stbsp_vsprintfcb+0x942>
                     *s++ = stbsp__comma;
    256a:	fe578fa3          	sb	t0,-1(a5)
    256e:	0709                	addi	a4,a4,2
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2570:	4585                	li	a1,1
    2572:	bde5                	j	246a <stbsp_vsprintfcb+0x119c>
            lead[0] = 1;
    2574:	678d                	lui	a5,0x3
    2576:	0785                	addi	a5,a5,1 # 3001 <stbsp_vsprintf+0x9>
    2578:	06f11423          	sh	a5,104(sp)
    257c:	b4ed                	j	2066 <stbsp_vsprintfcb+0xd98>
            if ((f[0] != 'u') && (i64 < 0)) {
    257e:	07500693          	li	a3,117
            stbsp__int64 i64 = va_arg(va, stbsp__int64);
    2582:	000bbf03          	ld	t5,0(s7)
            if ((f[0] != 'u') && (i64 < 0)) {
    2586:	dcd78263          	beq	a5,a3,1b4a <stbsp_vsprintfcb+0x87c>
    258a:	dc0f5063          	bgez	t5,1b4a <stbsp_vsprintfcb+0x87c>
               fl |= STBSP__NEGATIVE;
    258e:	08076713          	ori	a4,a4,128
               n64 = (stbsp__uint64)-i64;
    2592:	41e00f33          	neg	t5,t5
               fl |= STBSP__NEGATIVE;
    2596:	00070e1b          	sext.w	t3,a4
    259a:	db0ff06f          	j	1b4a <stbsp_vsprintfcb+0x87c>
            lead[2] = h[0xb];
    259e:	00b84703          	lbu	a4,11(a6)
            lead[0] = 2;
    25a2:	678d                	lui	a5,0x3
    25a4:	0789                	addi	a5,a5,2 # 3002 <stbsp_vsprintf+0xa>
    25a6:	06f11423          	sh	a5,104(sp)
            lead[2] = h[0xb];
    25aa:	06e10523          	sb	a4,106(sp)
    25ae:	bab5                	j	1f2a <stbsp_vsprintfcb+0xc5c>
      sign[0] = 1;
    25b0:	678d                	lui	a5,0x3
    25b2:	d0178793          	addi	a5,a5,-767 # 2d01 <stbsp_vsprintfcb+0x1a33>
            fl |= STBSP__NEGATIVE;
    25b6:	080e6e13          	ori	t3,t3,128
      sign[0] = 1;
    25ba:	06f11423          	sh	a5,104(sp)
    25be:	468d                	li	a3,3
    25c0:	4a0d                	li	s4,3
    25c2:	4809                	li	a6,2
    25c4:	b899                	j	1e1a <stbsp_vsprintfcb+0xb4c>
      sign[0] = 1;
    25c6:	6709                	lui	a4,0x2
    25c8:	0705                	addi	a4,a4,1 # 2001 <stbsp_vsprintfcb+0xd33>
    25ca:	06e11423          	sh	a4,104(sp)
    25ce:	bae5                	j	1fc6 <stbsp_vsprintfcb+0xcf8>
      if (((stbsp__uintptr)sn & 3) == 0)
    25d0:	0e0780e3          	beqz	a5,2eb0 <stbsp_vsprintfcb+0x1be2>
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    25d4:	56fd                	li	a3,-1
    25d6:	bcf9                	j	20b4 <stbsp_vsprintfcb+0xde6>
         if (fw < (stbsp__int32)n)
    25d8:	4305                	li	t1,1
    25da:	b249                	j	1f5c <stbsp_vsprintfcb+0xc8e>
            pr = 6; // default is 6
    25dc:	4899                	li	a7,6
    25de:	b801                	j	1dee <stbsp_vsprintfcb+0xb20>
         h = (f[0] == 'A') ? hexu : hex;
    25e0:	00004597          	auipc	a1,0x4
    25e4:	48058593          	addi	a1,a1,1152 # 6a60 <hexu.1>
    25e8:	ff6ff06f          	j	1dde <stbsp_vsprintfcb+0xb10>
         h = (f[0] == 'B') ? hexu : hex;
    25ec:	00004817          	auipc	a6,0x4
    25f0:	47480813          	addi	a6,a6,1140 # 6a60 <hexu.1>
    25f4:	b22d                	j	1f1e <stbsp_vsprintfcb+0xc50>
    25f6:	80000737          	lui	a4,0x80000
    25fa:	0719                	addi	a4,a4,6 # ffffffff80000006 <_ZSt4cerr+0xffffffff7fff877e>
            pr = 6; // default is 6
    25fc:	4899                	li	a7,6
    25fe:	e4eff06f          	j	1c4c <stbsp_vsprintfcb+0x97e>
         h = (f[0] == 'E') ? hexu : hex;
    2602:	00004317          	auipc	t1,0x4
    2606:	45e30313          	addi	t1,t1,1118 # 6a60 <hexu.1>
    260a:	e28ff06f          	j	1c32 <stbsp_vsprintfcb+0x964>
    260e:	80000737          	lui	a4,0x80000
    2612:	4a99                	li	s5,6
    2614:	0715                	addi	a4,a4,5 # ffffffff80000005 <_ZSt4cerr+0xffffffff7fff877d>
            pr = 6;
    2616:	4a19                	li	s4,6
    2618:	ee8ff06f          	j	1d00 <stbsp_vsprintfcb+0xa32>
         h = (f[0] == 'G') ? hexu : hex;
    261c:	00004317          	auipc	t1,0x4
    2620:	44430313          	addi	t1,t1,1092 # 6a60 <hexu.1>
    2624:	eb6ff06f          	j	1cda <stbsp_vsprintfcb+0xa0c>
    2628:	7be6                	ld	s7,120(sp)
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    262a:	86c2                	mv	a3,a6
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    262c:	8542                	mv	a0,a6
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    262e:	88d2                	mv	a7,s4
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2630:	8ade                	mv	s5,s7
            if (pr > (stbsp__int32)l)
    2632:	0005071b          	sext.w	a4,a0
    2636:	01175f63          	bge	a4,a7,2654 <stbsp_vsprintfcb+0x1386>
               pr = l - 1;
    263a:	fff5089b          	addiw	a7,a0,-1
         tail[0] = 0;
    263e:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    2642:	70028c63          	beqz	t0,2d5a <stbsp_vsprintfcb+0x1a8c>
      sign[0] = 1;
    2646:	670d                	lui	a4,0x3
    2648:	d0170713          	addi	a4,a4,-767 # 2d01 <stbsp_vsprintfcb+0x1a33>
    264c:	06e11423          	sh	a4,104(sp)
    2650:	e3aff06f          	j	1c8a <stbsp_vsprintfcb+0x9bc>
            else if (pr)
    2654:	fe0885e3          	beqz	a7,263e <stbsp_vsprintfcb+0x1370>
               --pr; // when using %e, there is one digit before the decimal
    2658:	38fd                	addiw	a7,a7,-1
    265a:	b7d5                	j	263e <stbsp_vsprintfcb+0x1370>
      switch (f[0]) {
    265c:	0034c783          	lbu	a5,3(s1)
            f += 3;
    2660:	048d                	addi	s1,s1,3
    2662:	e53fe06f          	j	14b4 <stbsp_vsprintfcb+0x1e6>
      if (!limit || *sn == 0)
    2666:	4601                	li	a2,0
    2668:	4701                	li	a4,0
    266a:	4781                	li	a5,0
         return (stbsp__uint32)(sn - s);
    266c:	bca5                	j	20e4 <stbsp_vsprintfcb+0xe16>
               pr = 1;
    266e:	4885                	li	a7,1
    2670:	cf4ff06f          	j	1b64 <stbsp_vsprintfcb+0x896>
         *s++ = sn[0];
    2674:	000ac703          	lbu	a4,0(s5)
    2678:	0ce10023          	sb	a4,192(sp)
         if (pr)
    267c:	54088563          	beqz	a7,2bc6 <stbsp_vsprintfcb+0x18f8>
            *s++ = stbsp__period;
    2680:	00004617          	auipc	a2,0x4
    2684:	3dc64603          	lbu	a2,988(a2) # 6a5c <stbsp__period>
         if ((l - 1) > (stbsp__uint32)pr)
    2688:	fff6871b          	addiw	a4,a3,-1
            *s++ = stbsp__period;
    268c:	0cc100a3          	sb	a2,193(sp)
         if ((l - 1) > (stbsp__uint32)pr)
    2690:	0008851b          	sext.w	a0,a7
    2694:	0007061b          	sext.w	a2,a4
    2698:	52c57163          	bgeu	a0,a2,2bba <stbsp_vsprintfcb+0x18ec>
            l = pr + 1;
    269c:	0018869b          	addiw	a3,a7,1
         for (n = 1; n < l; n++)
    26a0:	8746                	mv	a4,a7
    26a2:	02071613          	slli	a2,a4,0x20
    26a6:	9201                	srli	a2,a2,0x20
    26a8:	0c210713          	addi	a4,sp,194
    26ac:	0a85                	addi	s5,s5,1
    26ae:	963a                	add	a2,a2,a4
            *s++ = sn[n];
    26b0:	000ac583          	lbu	a1,0(s5)
    26b4:	0705                	addi	a4,a4,1
         for (n = 1; n < l; n++)
    26b6:	0a85                	addi	s5,s5,1
            *s++ = sn[n];
    26b8:	feb70fa3          	sb	a1,-1(a4)
         for (n = 1; n < l; n++)
    26bc:	fec71ae3          	bne	a4,a2,26b0 <stbsp_vsprintfcb+0x13e2>
         tail[1] = h[0xe];
    26c0:	00e34803          	lbu	a6,14(t1)
         dp -= 1;
    26c4:	fff7871b          	addiw	a4,a5,-1
            tail[2] = '+';
    26c8:	02b00593          	li	a1,43
         tail[1] = h[0xe];
    26cc:	070108a3          	sb	a6,113(sp)
         if (dp < 0) {
    26d0:	00075663          	bgez	a4,26dc <stbsp_vsprintfcb+0x140e>
            dp = -dp;
    26d4:	4705                	li	a4,1
    26d6:	9f1d                	subw	a4,a4,a5
            tail[2] = '-';
    26d8:	02d00593          	li	a1,45
    26dc:	06b10923          	sb	a1,114(sp)
         n = (dp >= 100) ? 5 : 4;
    26e0:	06300793          	li	a5,99
    26e4:	4ee7d663          	bge	a5,a4,2bd0 <stbsp_vsprintfcb+0x1902>
    26e8:	4595                	li	a1,5
    26ea:	4f95                	li	t6,5
    26ec:	4e95                	li	t4,5
            tail[n] = '0' + dp % 10;
    26ee:	47a9                	li	a5,10
            dp /= 10;
    26f0:	02f7433b          	divw	t1,a4,a5
            --n;
    26f4:	fffe8f1b          	addiw	t5,t4,-1
            tail[n] = '0' + dp % 10;
    26f8:	020f1293          	slli	t0,t5,0x20
    26fc:	220e8813          	addi	a6,t4,544
    2700:	06010893          	addi	a7,sp,96
    2704:	0202d293          	srli	t0,t0,0x20
    2708:	01180eb3          	add	t4,a6,a7
    270c:	22028813          	addi	a6,t0,544 # 3000220 <_ZSt4cerr+0x2ff8998>
    2710:	011802b3          	add	t0,a6,a7
         tail[0] = (char)n;
    2714:	07f10823          	sb	t6,112(sp)
            if (n <= 3)
    2718:	4a0d                	li	s4,3
            tail[n] = '0' + dp % 10;
    271a:	02f7673b          	remw	a4,a4,a5
            dp /= 10;
    271e:	0003081b          	sext.w	a6,t1
            tail[n] = '0' + dp % 10;
    2722:	02f36abb          	remw	s5,t1,a5
    2726:	0307071b          	addiw	a4,a4,48
    272a:	deee8823          	sb	a4,-528(t4)
    272e:	030a871b          	addiw	a4,s5,48
    2732:	dee28823          	sb	a4,-528(t0)
            if (n <= 3)
    2736:	014f0a63          	beq	t5,s4,274a <stbsp_vsprintfcb+0x147c>
            dp /= 10;
    273a:	02f3483b          	divw	a6,t1,a5
            tail[n] = '0' + dp % 10;
    273e:	02f867bb          	remw	a5,a6,a5
    2742:	0307879b          	addiw	a5,a5,48
    2746:	06f109a3          	sb	a5,115(sp)
         tz = pr - (l - 1);
    274a:	2505                	addiw	a0,a0,1
         l = (stbsp__uint32)(s - (num + 64));
    274c:	0c010a93          	addi	s5,sp,192
         cs = 1 + (3 << 24); // how many tens
    2750:	030002b7          	lui	t0,0x3000
         tz = pr - (l - 1);
    2754:	40d508bb          	subw	a7,a0,a3
    2758:	d2c2                	sw	a6,100(sp)
         l = (stbsp__uint32)(s - (num + 64));
    275a:	415607b3          	sub	a5,a2,s5
         cs = 1 + (3 << 24); // how many tens
    275e:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff8779>
    2760:	bbc9                	j	2532 <stbsp_vsprintfcb+0x1264>
    2762:	fc2e                	sd	a1,56(sp)
    2764:	d0b2                	sw	a2,96(sp)
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2766:	8536                	mv	a0,a3
    2768:	e2cff06f          	j	1d94 <stbsp_vsprintfcb+0xac6>
      flt_lead:
    276c:	4581                	li	a1,0
    276e:	4f81                	li	t6,0
    2770:	b3c9                	j	2532 <stbsp_vsprintfcb+0x1264>
         n = pr + lead[0] + tail[0] + tz;
    2772:	06814a03          	lbu	s4,104(sp)
    2776:	000a0f9b          	sext.w	t6,s4
    277a:	b901                	j	238a <stbsp_vsprintfcb+0x10bc>
         if ((f[1] == '6') && (f[2] == '4')) {
    277c:	0024c683          	lbu	a3,2(s1)
    2780:	03400713          	li	a4,52
    2784:	00e68463          	beq	a3,a4,278c <stbsp_vsprintfcb+0x14be>
    2788:	e2bfe06f          	j	15b2 <stbsp_vsprintfcb+0x2e4>
      switch (f[0]) {
    278c:	0034c783          	lbu	a5,3(s1)
         fl |= ((sizeof(long) == 8) ? STBSP__INTMAX : 0);
    2790:	020e6e13          	ori	t3,t3,32
            f += 3;
    2794:	048d                	addi	s1,s1,3
    2796:	d1ffe06f          	j	14b4 <stbsp_vsprintfcb+0x1e6>
         if (pr < (stbsp__int32)l)
    279a:	0006879b          	sext.w	a5,a3
         n = pr + lead[0] + tail[0] + tz;
    279e:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    27a2:	fff7c793          	not	a5,a5
    27a6:	97fd                	srai	a5,a5,0x3f
    27a8:	8ff5                	and	a5,a5,a3
         n = pr + lead[0] + tail[0] + tz;
    27aa:	00fa063b          	addw	a2,s4,a5
            s = (char *)sn;
    27ae:	7ae6                	ld	s5,120(sp)
         n = pr + lead[0] + tail[0] + tz;
    27b0:	8732                	mv	a4,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    27b2:	001e7513          	andi	a0,t3,1
         if (pr < (stbsp__int32)l)
    27b6:	2781                	sext.w	a5,a5
         if (fw < (stbsp__int32)n)
    27b8:	835a                	mv	t1,s6
    27ba:	00cb5363          	bge	s6,a2,27c0 <stbsp_vsprintfcb+0x14f2>
    27be:	8332                	mv	t1,a2
         fw -= n;
    27c0:	40e3033b          	subw	t1,t1,a4
            goto scopy;
    27c4:	4f81                	li	t6,0
         pr -= l;
    27c6:	40d7873b          	subw	a4,a5,a3
            cs = 0;
    27ca:	4281                	li	t0,0
      tz = 0;
    27cc:	4881                	li	a7,0
            goto scopy;
    27ce:	c42ff06f          	j	1c10 <stbsp_vsprintfcb+0x942>
               cs = (int)(s - (num + 64)) + (3 << 24); // cs is how many tens
    27d2:	415705b3          	sub	a1,a4,s5
    27d6:	030002b7          	lui	t0,0x3000
    27da:	00b282bb          	addw	t0,t0,a1
               l = pr - n;
    27de:	0008859b          	sext.w	a1,a7
               if (pr)
    27e2:	42088763          	beqz	a7,2c10 <stbsp_vsprintfcb+0x1942>
                  *s++ = stbsp__period;
    27e6:	0cca4f83          	lbu	t6,204(s4)
               if ((l - dp) > (stbsp__uint32)pr)
    27ea:	41d6833b          	subw	t1,a3,t4
                  *s++ = stbsp__period;
    27ee:	00280713          	addi	a4,a6,2
    27f2:	01f800a3          	sb	t6,1(a6)
               if ((l - dp) > (stbsp__uint32)pr)
    27f6:	4065ed63          	bltu	a1,t1,2c10 <stbsp_vsprintfcb+0x1942>
               while (n < l) {
    27fa:	5ed57863          	bgeu	a0,a3,2dea <stbsp_vsprintfcb+0x1b1c>
    27fe:	40c687bb          	subw	a5,a3,a2
    2802:	37fd                	addiw	a5,a5,-1
    2804:	1782                	slli	a5,a5,0x20
    2806:	9381                	srli	a5,a5,0x20
    2808:	1602                	slli	a2,a2,0x20
    280a:	9201                	srli	a2,a2,0x20
    280c:	0785                	addi	a5,a5,1
    280e:	967a                	add	a2,a2,t5
    2810:	97ba                	add	a5,a5,a4
                  *s++ = sn[n];
    2812:	00064503          	lbu	a0,0(a2)
    2816:	0705                	addi	a4,a4,1
               while (n < l) {
    2818:	0605                	addi	a2,a2,1
                  *s++ = sn[n];
    281a:	fea70fa3          	sb	a0,-1(a4)
               while (n < l) {
    281e:	fef71ae3          	bne	a4,a5,2812 <stbsp_vsprintfcb+0x1544>
               tz = pr - (l - dp);
    2822:	01d585bb          	addw	a1,a1,t4
    2826:	40d588bb          	subw	a7,a1,a3
         l = (stbsp__uint32)(s - (num + 64));
    282a:	415787b3          	sub	a5,a5,s5
    282e:	b99d                	j	24a4 <stbsp_vsprintfcb+0x11d6>
            fl |= STBSP__NEGATIVE;
    2830:	080e6e13          	ori	t3,t3,128
         tail[0] = 0;
    2834:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    2838:	b539                	j	2646 <stbsp_vsprintfcb+0x1378>
         tail[0] = (char)n;
    283a:	4799                	li	a5,6
            tail[n] = '0' + dp % 10;
    283c:	06b10b23          	sb	a1,118(sp)
         tail[0] = (char)n;
    2840:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    2844:	4819                	li	a6,6
    2846:	4f99                	li	t6,6
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    2848:	4599                	li	a1,6
            dp /= 10;
    284a:	4f29                	li	t5,10
            if (n <= 3)
    284c:	428d                	li	t0,3
    284e:	87b2                	mv	a5,a2
            dp /= 10;
    2850:	03e7c7bb          	divw	a5,a5,t5
            --n;
    2854:	35fd                	addiw	a1,a1,-1
            tail[n] = '0' + dp % 10;
    2856:	02059613          	slli	a2,a1,0x20
    285a:	9201                	srli	a2,a2,0x20
    285c:	06010e93          	addi	t4,sp,96
    2860:	22060613          	addi	a2,a2,544
    2864:	9676                	add	a2,a2,t4
    2866:	03e7eebb          	remw	t4,a5,t5
    286a:	030e8e9b          	addiw	t4,t4,48
    286e:	dfd60823          	sb	t4,-528(a2)
            if (n <= 3)
    2872:	fc559fe3          	bne	a1,t0,2850 <stbsp_vsprintfcb+0x1582>
    2876:	e6aff06f          	j	1ee0 <stbsp_vsprintfcb+0xc12>
         *s++ = h[(n64 >> 60) & 15];
    287a:	93f1                	srli	a5,a5,0x3c
    287c:	97ae                	add	a5,a5,a1
    287e:	0007c303          	lbu	t1,0(a5)
         lead[1 + lead[0]] = '0';
    2882:	1088                	addi	a0,sp,96
    2884:	22080793          	addi	a5,a6,544
    2888:	97aa                	add	a5,a5,a0
    288a:	03000513          	li	a0,48
    288e:	dea78423          	sb	a0,-536(a5)
         lead[2 + lead[0]] = 'x';
    2892:	22068793          	addi	a5,a3,544
    2896:	1094                	addi	a3,sp,96
    2898:	96be                	add	a3,a3,a5
            *s++ = stbsp__period;
    289a:	00004517          	auipc	a0,0x4
    289e:	1c254503          	lbu	a0,450(a0) # 6a5c <stbsp__period>
         lead[2 + lead[0]] = 'x';
    28a2:	07800813          	li	a6,120
         sn = s;
    28a6:	0c210793          	addi	a5,sp,194
         lead[2 + lead[0]] = 'x';
    28aa:	df068423          	sb	a6,-536(a3)
            *s++ = stbsp__period;
    28ae:	0ca100a3          	sb	a0,193(sp)
         lead[0] += 2;
    28b2:	07410423          	sb	s4,104(sp)
         *s++ = h[(n64 >> 60) & 15];
    28b6:	0c610023          	sb	t1,192(sp)
         n64 <<= 4;
    28ba:	0732                	slli	a4,a4,0xc
         sn = s;
    28bc:	fcbe                	sd	a5,120(sp)
         n = pr;
    28be:	0008869b          	sext.w	a3,a7
         while (n--) {
    28c2:	4831                	li	a6,12
         if (n > 13)
    28c4:	4535                	li	a0,13
            tz = pr - n;
    28c6:	40a688bb          	subw	a7,a3,a0
         while (n--) {
    28ca:	02081313          	slli	t1,a6,0x20
    28ce:	02035313          	srli	t1,t1,0x20
    28d2:	22030693          	addi	a3,t1,544
    28d6:	1088                	addi	a0,sp,96
    28d8:	9536                	add	a0,a0,a3
    28da:	e4350513          	addi	a0,a0,-445
            *s++ = h[(n64 >> 60) & 15];
    28de:	03c75693          	srli	a3,a4,0x3c
    28e2:	96ae                	add	a3,a3,a1
    28e4:	0006c683          	lbu	a3,0(a3)
    28e8:	0785                	addi	a5,a5,1
            n64 <<= 4;
    28ea:	0712                	slli	a4,a4,0x4
            *s++ = h[(n64 >> 60) & 15];
    28ec:	fed78fa3          	sb	a3,-1(a5)
         while (n--) {
    28f0:	fea797e3          	bne	a5,a0,28de <stbsp_vsprintfcb+0x1610>
         l = (int)(s - (num + 64));
    28f4:	280d                	addiw	a6,a6,3
    28f6:	0008069b          	sext.w	a3,a6
         if (pr < (stbsp__int32)l)
    28fa:	fff6c713          	not	a4,a3
    28fe:	977d                	srai	a4,a4,0x3f
    2900:	00e87733          	and	a4,a6,a4
         dp = (int)(s - sn);
    2904:	0013051b          	addiw	a0,t1,1
         if (pr < (stbsp__int32)l)
    2908:	0007031b          	sext.w	t1,a4
         pr -= l;
    290c:	4107073b          	subw	a4,a4,a6
    2910:	d76ff06f          	j	1e86 <stbsp_vsprintfcb+0xbb8>
                  *--s = stbsp__comma;
    2914:	00004a17          	auipc	s4,0x4
    2918:	07ca0a13          	addi	s4,s4,124 # 6990 <stbsp__digitpair>
            if (n64 >= 100000000) {
    291c:	05f5e7b7          	lui	a5,0x5f5e
    2920:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f56877>
               n = (stbsp__uint32)(n64 % 100000000);
    2924:	05f5e637          	lui	a2,0x5f5e
                  *--s = stbsp__comma;
    2928:	0cda4b83          	lbu	s7,205(s4)
            if (n64 >= 100000000) {
    292c:	e83e                	sd	a5,16(sp)
               n = (stbsp__uint32)(n64 % 100000000);
    292e:	10060793          	addi	a5,a2,256 # 5f5e100 <_ZSt4cerr+0x5f56878>
         l = 0;
    2932:	d082                	sw	zero,96(sp)
            if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    2934:	040e7813          	andi	a6,t3,64
    2938:	4701                	li	a4,0
    293a:	4281                	li	t0,0
         s = num + STBSP__NUMSZ;
    293c:	28010a93          	addi	s5,sp,640
               n = (stbsp__uint32)(n64 % 100000000);
    2940:	ec3e                	sd	a5,24(sp)
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    2942:	430d                	li	t1,3
                  n /= 10;
    2944:	45a9                	li	a1,10
            while (n) {
    2946:	4ea5                	li	t4,9
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    2948:	06400f93          	li	t6,100
            if (n64 >= 100000000) {
    294c:	67c2                	ld	a5,16(sp)
            char *o = s - 8;
    294e:	ff8a8513          	addi	a0,s5,-8
            if (n64 >= 100000000) {
    2952:	0fe7f763          	bgeu	a5,t5,2a40 <stbsp_vsprintfcb+0x1772>
               n = (stbsp__uint32)(n64 % 100000000);
    2956:	6662                	ld	a2,24(sp)
    2958:	02cf77b3          	remu	a5,t5,a2
               n64 /= 100000000;
    295c:	02cf5f33          	divu	t5,t5,a2
            if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    2960:	0e080463          	beqz	a6,2a48 <stbsp_vsprintfcb+0x177a>
            while (n) {
    2964:	cb85                	beqz	a5,2994 <stbsp_vsprintfcb+0x16c6>
                  *--s = stbsp__comma;
    2966:	1afd                	addi	s5,s5,-1
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    2968:	00671763          	bne	a4,t1,2976 <stbsp_vsprintfcb+0x16a8>
                  --o;
    296c:	017a8023          	sb	s7,0(s5)
    2970:	157d                	addi	a0,a0,-1
                  *--s = stbsp__comma;
    2972:	1afd                	addi	s5,s5,-1
                  l = 0;
    2974:	4701                	li	a4,0
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    2976:	2705                	addiw	a4,a4,1
                  *--s = (char)(n % 10) + '0';
    2978:	02b7f63b          	remuw	a2,a5,a1
    297c:	0306061b          	addiw	a2,a2,48
    2980:	00ca8023          	sb	a2,0(s5)
                  n /= 10;
    2984:	02b7d63b          	divuw	a2,a5,a1
            while (n) {
    2988:	00fef563          	bgeu	t4,a5,2992 <stbsp_vsprintfcb+0x16c4>
                  *--s = stbsp__comma;
    298c:	1afd                	addi	s5,s5,-1
    298e:	87b2                	mv	a5,a2
    2990:	bfe1                	j	2968 <stbsp_vsprintfcb+0x169a>
            while (n) {
    2992:	4285                	li	t0,1
            if (n64 == 0) {
    2994:	020f0063          	beqz	t5,29b4 <stbsp_vsprintfcb+0x16e6>
            while (s != o)
    2998:	fb550ae3          	beq	a0,s5,294c <stbsp_vsprintfcb+0x167e>
                  *--s = stbsp__comma;
    299c:	1afd                	addi	s5,s5,-1
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    299e:	00080663          	beqz	a6,29aa <stbsp_vsprintfcb+0x16dc>
    29a2:	08670863          	beq	a4,t1,2a32 <stbsp_vsprintfcb+0x1764>
    29a6:	2705                	addiw	a4,a4,1
    29a8:	4285                	li	t0,1
                  *--s = '0';
    29aa:	03000793          	li	a5,48
    29ae:	00fa8023          	sb	a5,0(s5)
    29b2:	b7dd                	j	2998 <stbsp_vsprintfcb+0x16ca>
    29b4:	00028363          	beqz	t0,29ba <stbsp_vsprintfcb+0x16ec>
    29b8:	d0ba                	sw	a4,96(sp)
               if ((s[0] == '0') && (s != (num + STBSP__NUMSZ)))
    29ba:	000ac703          	lbu	a4,0(s5)
    29be:	03000793          	li	a5,48
    29c2:	34f70b63          	beq	a4,a5,2d18 <stbsp_vsprintfcb+0x1a4a>
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    29c6:	051c                	addi	a5,sp,640
    29c8:	415786bb          	subw	a3,a5,s5
         tail[0] = 0;
    29cc:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    29d0:	080e7713          	andi	a4,t3,128
    29d4:	87f2                	mv	a5,t3
    29d6:	32070863          	beqz	a4,2d06 <stbsp_vsprintfcb+0x1a38>
    29da:	678d                	lui	a5,0x3
    29dc:	d017879b          	addiw	a5,a5,-767 # 2d01 <stbsp_vsprintfcb+0x1a33>
      sign[0] = 1;
    29e0:	06f11423          	sh	a5,104(sp)
    29e4:	4705                	li	a4,1
    29e6:	4a05                	li	s4,1
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    29e8:	d0b6                	sw	a3,96(sp)
         if (l == 0) {
    29ea:	30068163          	beqz	a3,2cec <stbsp_vsprintfcb+0x1a1e>
         cs = l + (3 << 24);
    29ee:	030002b7          	lui	t0,0x3000
    29f2:	00d282bb          	addw	t0,t0,a3
         if (pr < (stbsp__int32)l)
    29f6:	0006861b          	sext.w	a2,a3
         if (pr < 0)
    29fa:	fff8c793          	not	a5,a7
    29fe:	97fd                	srai	a5,a5,0x3f
         if (pr < (stbsp__int32)l)
    2a00:	00f8f7b3          	and	a5,a7,a5
    2a04:	0007859b          	sext.w	a1,a5
    2a08:	00c5d363          	bge	a1,a2,2a0e <stbsp_vsprintfcb+0x1740>
    2a0c:	87b2                	mv	a5,a2
         n = pr + lead[0] + tail[0] + tz;
    2a0e:	00f7063b          	addw	a2,a4,a5
    2a12:	8732                	mv	a4,a2
         if (pr < (stbsp__int32)l)
    2a14:	2781                	sext.w	a5,a5
         if ((fl & STBSP__LEFTJUST) == 0) {
    2a16:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    2a1a:	835a                	mv	t1,s6
    2a1c:	00cb5363          	bge	s6,a2,2a22 <stbsp_vsprintfcb+0x1754>
    2a20:	8332                	mv	t1,a2
         fw -= n;
    2a22:	40e3033b          	subw	t1,t1,a4
      scopy:
    2a26:	4f81                	li	t6,0
         pr -= l;
    2a28:	40d7873b          	subw	a4,a5,a3
      tz = 0;
    2a2c:	4881                	li	a7,0
      scopy:
    2a2e:	9e2ff06f          	j	1c10 <stbsp_vsprintfcb+0x942>
                  *--s = stbsp__comma;
    2a32:	87de                	mv	a5,s7
                  --o;
    2a34:	157d                	addi	a0,a0,-1
                  l = 0;
    2a36:	4701                	li	a4,0
                  --o;
    2a38:	4285                	li	t0,1
    2a3a:	00fa8023          	sb	a5,0(s5)
    2a3e:	bfa9                	j	2998 <stbsp_vsprintfcb+0x16ca>
               n = (stbsp__uint32)n64;
    2a40:	000f079b          	sext.w	a5,t5
               n64 = 0;
    2a44:	4f01                	li	t5,0
    2a46:	bf29                	j	2960 <stbsp_vsprintfcb+0x1692>
    2a48:	f046                	sd	a7,32(sp)
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    2a4a:	03f7f63b          	remuw	a2,a5,t6
                  s -= 2;
    2a4e:	1af9                	addi	s5,s5,-2
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    2a50:	0007889b          	sext.w	a7,a5
    2a54:	2605                	addiw	a2,a2,1
    2a56:	0016161b          	slliw	a2,a2,0x1
    2a5a:	1602                	slli	a2,a2,0x20
    2a5c:	9201                	srli	a2,a2,0x20
    2a5e:	9652                	add	a2,a2,s4
    2a60:	00065603          	lhu	a2,0(a2)
                  n /= 100;
    2a64:	03f7d7bb          	divuw	a5,a5,t6
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    2a68:	00ca9023          	sh	a2,0(s5)
               } while (n);
    2a6c:	06300613          	li	a2,99
    2a70:	fd166de3          	bltu	a2,a7,2a4a <stbsp_vsprintfcb+0x177c>
    2a74:	7882                	ld	a7,32(sp)
            if (n64 == 0) {
    2a76:	f20f11e3          	bnez	t5,2998 <stbsp_vsprintfcb+0x16ca>
    2a7a:	bf2d                	j	29b4 <stbsp_vsprintfcb+0x16e6>
                     *(stbsp__uint32 *)bf = 0x20202020;
    2a7c:	20202b37          	lui	s6,0x20202
                  stbsp__cb_buf_clamp(i, fw);
    2a80:	854a                	mv	a0,s2
                     *bf++ = ' ';
    2a82:	02000a93          	li	s5,32
                     *(stbsp__uint32 *)bf = 0x20202020;
    2a86:	020b0b13          	addi	s6,s6,32 # 20202020 <_ZSt4cerr+0x201fa798>
                  stbsp__chk_cb_buf(1);
    2a8a:	1fe00a13          	li	s4,510
                  stbsp__cb_buf_clamp(i, fw);
    2a8e:	20000b93          	li	s7,512
    2a92:	891a                	mv	s2,t1
    2a94:	0a098063          	beqz	s3,2b34 <stbsp_vsprintfcb+0x1866>
    2a98:	40a40633          	sub	a2,s0,a0
    2a9c:	40cb87bb          	subw	a5,s7,a2
    2aa0:	873e                	mv	a4,a5
    2aa2:	00f95363          	bge	s2,a5,2aa8 <stbsp_vsprintfcb+0x17da>
    2aa6:	874a                	mv	a4,s2
    2aa8:	0007079b          	sext.w	a5,a4
                  fw -= i;
    2aac:	40e9093b          	subw	s2,s2,a4
                  while (i) {
    2ab0:	e799                	bnez	a5,2abe <stbsp_vsprintfcb+0x17f0>
    2ab2:	a281                	j	2bf2 <stbsp_vsprintfcb+0x1924>
                     *bf++ = ' ';
    2ab4:	01540023          	sb	s5,0(s0)
                     --i;
    2ab8:	37fd                	addiw	a5,a5,-1
                     *bf++ = ' ';
    2aba:	0405                	addi	s0,s0,1
                  while (i) {
    2abc:	cba1                	beqz	a5,2b0c <stbsp_vsprintfcb+0x183e>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    2abe:	00347713          	andi	a4,s0,3
    2ac2:	fb6d                	bnez	a4,2ab4 <stbsp_vsprintfcb+0x17e6>
                  while (i >= 4) {
    2ac4:	470d                	li	a4,3
    2ac6:	40f75363          	bge	a4,a5,2ecc <stbsp_vsprintfcb+0x1bfe>
    2aca:	ffc7869b          	addiw	a3,a5,-4
    2ace:	0026d79b          	srliw	a5,a3,0x2
    2ad2:	0017871b          	addiw	a4,a5,1
    2ad6:	070a                	slli	a4,a4,0x2
    2ad8:	9722                	add	a4,a4,s0
                     *(stbsp__uint32 *)bf = 0x20202020;
    2ada:	01642023          	sw	s6,0(s0)
                     bf += 4;
    2ade:	0411                	addi	s0,s0,4
                  while (i >= 4) {
    2ae0:	fee41de3          	bne	s0,a4,2ada <stbsp_vsprintfcb+0x180c>
    2ae4:	0027979b          	slliw	a5,a5,0x2
    2ae8:	40f687bb          	subw	a5,a3,a5
                  while (i--)
    2aec:	fff7869b          	addiw	a3,a5,-1
    2af0:	cf91                	beqz	a5,2b0c <stbsp_vsprintfcb+0x183e>
    2af2:	9fa1                	addw	a5,a5,s0
                     *bf++ = ' ';
    2af4:	0705                	addi	a4,a4,1
                  while (i--)
    2af6:	0007061b          	sext.w	a2,a4
                     *bf++ = ' ';
    2afa:	ff570fa3          	sb	s5,-1(a4)
                  while (i--)
    2afe:	fec79be3          	bne	a5,a2,2af4 <stbsp_vsprintfcb+0x1826>
    2b02:	2685                	addiw	a3,a3,1
    2b04:	02069793          	slli	a5,a3,0x20
    2b08:	9381                	srli	a5,a5,0x20
    2b0a:	943e                	add	s0,s0,a5
                  stbsp__chk_cb_buf(1);
    2b0c:	00098f63          	beqz	s3,2b2a <stbsp_vsprintfcb+0x185c>
    2b10:	40a4063b          	subw	a2,s0,a0
    2b14:	00ca5b63          	bge	s4,a2,2b2a <stbsp_vsprintfcb+0x185c>
    2b18:	65a2                	ld	a1,8(sp)
    2b1a:	e81e                	sd	t2,16(sp)
    2b1c:	00cd0d3b          	addw	s10,s10,a2
    2b20:	9982                	jalr	s3
    2b22:	80050be3          	beqz	a0,2338 <stbsp_vsprintfcb+0x106a>
    2b26:	63c2                	ld	t2,16(sp)
    2b28:	842a                	mv	s0,a0
               while (fw) {
    2b2a:	f60915e3          	bnez	s2,2a94 <stbsp_vsprintfcb+0x17c6>
    2b2e:	892a                	mv	s2,a0
    2b30:	f21fe06f          	j	1a50 <stbsp_vsprintfcb+0x782>
                  stbsp__cb_buf_clamp(i, fw);
    2b34:	87ca                	mv	a5,s2
                  fw -= i;
    2b36:	4901                	li	s2,0
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    2b38:	b759                	j	2abe <stbsp_vsprintfcb+0x17f0>
   } else if (fl & STBSP__LEADINGPLUS) {
    2b3a:	002e7713          	andi	a4,t3,2
    2b3e:	94070663          	beqz	a4,1c8a <stbsp_vsprintfcb+0x9bc>
      sign[0] = 1;
    2b42:	670d                	lui	a4,0x3
    2b44:	b0170713          	addi	a4,a4,-1279 # 2b01 <stbsp_vsprintfcb+0x1833>
    2b48:	06e11423          	sh	a4,104(sp)
    2b4c:	93eff06f          	j	1c8a <stbsp_vsprintfcb+0x9bc>
      if (((stbsp__uintptr)sn & 3) == 0)
    2b50:	87d6                	mv	a5,s5
   while (limit >= 4) {
    2b52:	470d                	li	a4,3
    2b54:	22d77763          	bgeu	a4,a3,2d82 <stbsp_vsprintfcb+0x1ab4>
      if ((v - 0x01010101) & (~v) & 0x80808080UL)
    2b58:	feff05b7          	lui	a1,0xfeff0
    2b5c:	80808637          	lui	a2,0x80808
    2b60:	eff5859b          	addiw	a1,a1,-257 # fffffffffefefeff <_ZSt4cerr+0xfffffffffefe8677>
    2b64:	08060613          	addi	a2,a2,128 # ffffffff80808080 <_ZSt4cerr+0xffffffff808007f8>
   while (limit >= 4) {
    2b68:	480d                	li	a6,3
    2b6a:	a029                	j	2b74 <stbsp_vsprintfcb+0x18a6>
      limit -= 4;
    2b6c:	36f1                	addiw	a3,a3,-4
      sn += 4;
    2b6e:	0791                	addi	a5,a5,4
   while (limit >= 4) {
    2b70:	20d87963          	bgeu	a6,a3,2d82 <stbsp_vsprintfcb+0x1ab4>
      stbsp__uint32 v = *(stbsp__uint32 *)sn;
    2b74:	4398                	lw	a4,0(a5)
      if ((v - 0x01010101) & (~v) & 0x80808080UL)
    2b76:	00b7053b          	addw	a0,a4,a1
    2b7a:	fff74713          	not	a4,a4
    2b7e:	8f69                	and	a4,a4,a0
    2b80:	8f71                	and	a4,a4,a2
    2b82:	2701                	sext.w	a4,a4
    2b84:	d765                	beqz	a4,2b6c <stbsp_vsprintfcb+0x189e>
    2b86:	02069713          	slli	a4,a3,0x20
    2b8a:	9301                	srli	a4,a4,0x20
    2b8c:	973e                	add	a4,a4,a5
    2b8e:	a021                	j	2b96 <stbsp_vsprintfcb+0x18c8>
      ++sn;
    2b90:	0785                	addi	a5,a5,1
   while (limit && *sn) {
    2b92:	00e78663          	beq	a5,a4,2b9e <stbsp_vsprintfcb+0x18d0>
    2b96:	0007c683          	lbu	a3,0(a5)
    2b9a:	fafd                	bnez	a3,2b90 <stbsp_vsprintfcb+0x18c2>
    2b9c:	873e                	mv	a4,a5
   return (stbsp__uint32)(sn - s);
    2b9e:	41570733          	sub	a4,a4,s5
    2ba2:	0007069b          	sext.w	a3,a4
         if (pr < (stbsp__int32)l)
    2ba6:	fff6c793          	not	a5,a3
    2baa:	97fd                	srai	a5,a5,0x3f
    2bac:	8f7d                	and	a4,a4,a5
    2bae:	0007079b          	sext.w	a5,a4
         n = pr + lead[0] + tail[0] + tz;
    2bb2:	863e                	mv	a2,a5
         pr -= l;
    2bb4:	9f15                	subw	a4,a4,a3
   return (stbsp__uint32)(sn - s);
    2bb6:	d2eff06f          	j	20e4 <stbsp_vsprintfcb+0xe16>
         for (n = 1; n < l; n++)
    2bba:	4605                	li	a2,1
    2bbc:	aed663e3          	bltu	a2,a3,26a2 <stbsp_vsprintfcb+0x13d4>
    2bc0:	0c210613          	addi	a2,sp,194
    2bc4:	bcf5                	j	26c0 <stbsp_vsprintfcb+0x13f2>
            l = pr + 1;
    2bc6:	4685                	li	a3,1
         if ((l - 1) > (stbsp__uint32)pr)
    2bc8:	4501                	li	a0,0
         *s++ = sn[0];
    2bca:	0c110613          	addi	a2,sp,193
    2bce:	bccd                	j	26c0 <stbsp_vsprintfcb+0x13f2>
    2bd0:	4591                	li	a1,4
    2bd2:	4f91                	li	t6,4
         n = (dp >= 100) ? 5 : 4;
    2bd4:	4e91                	li	t4,4
    2bd6:	be21                	j	26ee <stbsp_vsprintfcb+0x1420>
    2bd8:	4a85                	li	s5,1
    2bda:	80000737          	lui	a4,0x80000
            pr = 1; // default is 6
    2bde:	4a05                	li	s4,1
    2be0:	920ff06f          	j	1d00 <stbsp_vsprintfcb+0xa32>
            dp = (n64) ? -1022 : 0;
    2be4:	4601                	li	a2,0
    2be6:	c119                	beqz	a0,2bec <stbsp_vsprintfcb+0x191e>
    2be8:	c0200613          	li	a2,-1022
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    2bec:	872a                	mv	a4,a0
    2bee:	a3aff06f          	j	1e28 <stbsp_vsprintfcb+0xb5a>
                  stbsp__chk_cb_buf(1);
    2bf2:	2601                	sext.w	a2,a2
    2bf4:	1fe00793          	li	a5,510
    2bf8:	f2c7c0e3          	blt	a5,a2,2b18 <stbsp_vsprintfcb+0x184a>
    2bfc:	bd61                	j	2a94 <stbsp_vsprintfcb+0x17c6>
         tail[0] = (char)n;
    2bfe:	4795                	li	a5,5
            tail[n] = '0' + dp % 10;
    2c00:	06b10aa3          	sb	a1,117(sp)
         tail[0] = (char)n;
    2c04:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    2c08:	4815                	li	a6,5
    2c0a:	4f95                	li	t6,5
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    2c0c:	4595                	li	a1,5
    2c0e:	b935                	j	284a <stbsp_vsprintfcb+0x157c>
                  l = pr + dp;
    2c10:	011786bb          	addw	a3,a5,a7
    2c14:	d0b6                	sw	a3,96(sp)
    2c16:	b6d5                	j	27fa <stbsp_vsprintfcb+0x152c>
            s = (char *)"null";
    2c18:	00002a97          	auipc	s5,0x2
    2c1c:	4b8a8a93          	addi	s5,s5,1208 # 50d0 <_GLOBAL__sub_I__ZSt3cin+0xe0>
    2c20:	c80ff06f          	j	20a0 <stbsp_vsprintfcb+0xdd2>
   } else if (fl & STBSP__LEADINGPLUS) {
    2c24:	002e7793          	andi	a5,t3,2
    2c28:	1c079c63          	bnez	a5,2e00 <stbsp_vsprintfcb+0x1b32>
   sign[0] = 0;
    2c2c:	4689                	li	a3,2
    2c2e:	4a09                	li	s4,2
    2c30:	4805                	li	a6,1
    2c32:	9e8ff06f          	j	1e1a <stbsp_vsprintfcb+0xb4c>
      sign[0] = 1;
    2c36:	670d                	lui	a4,0x3
    2c38:	b0170713          	addi	a4,a4,-1279 # 2b01 <stbsp_vsprintfcb+0x1833>
    2c3c:	06e11423          	sh	a4,104(sp)
    2c40:	b86ff06f          	j	1fc6 <stbsp_vsprintfcb+0xcf8>
               pr = 0;
    2c44:	4881                	li	a7,0
    2c46:	f1ffe06f          	j	1b64 <stbsp_vsprintfcb+0x896>
            *s++ = '0';
    2c4a:	03000713          	li	a4,48
    2c4e:	0ce10023          	sb	a4,192(sp)
            if (pr)
    2c52:	1a088c63          	beqz	a7,2e0a <stbsp_vsprintfcb+0x1b3c>
               *s++ = stbsp__period;
    2c56:	00004717          	auipc	a4,0x4
    2c5a:	e0674703          	lbu	a4,-506(a4) # 6a5c <stbsp__period>
            n = -dp;
    2c5e:	40f007bb          	negw	a5,a5
               *s++ = stbsp__period;
    2c62:	0ce100a3          	sb	a4,193(sp)
            if ((stbsp__int32)n > pr)
    2c66:	0007871b          	sext.w	a4,a5
    2c6a:	00e8d363          	bge	a7,a4,2c70 <stbsp_vsprintfcb+0x19a2>
    2c6e:	87c6                	mv	a5,a7
    2c70:	0007871b          	sext.w	a4,a5
            if ((stbsp__int32)(l + n) > pr)
    2c74:	00d7833b          	addw	t1,a5,a3
    2c78:	883a                	mv	a6,a4
            while (i) {
    2c7a:	0c210793          	addi	a5,sp,194
               *s++ = '0';
    2c7e:	03000513          	li	a0,48
            while (i) {
    2c82:	e711                	bnez	a4,2c8e <stbsp_vsprintfcb+0x19c0>
    2c84:	a271                	j	2e10 <stbsp_vsprintfcb+0x1b42>
               if ((((stbsp__uintptr)s) & 3) == 0)
    2c86:	0037f613          	andi	a2,a5,3
    2c8a:	18060563          	beqz	a2,2e14 <stbsp_vsprintfcb+0x1b46>
               *s++ = '0';
    2c8e:	85ba                	mv	a1,a4
    2c90:	00a78023          	sb	a0,0(a5)
               --i;
    2c94:	377d                	addiw	a4,a4,-1
               *s++ = '0';
    2c96:	0785                	addi	a5,a5,1
            while (i) {
    2c98:	f77d                	bnez	a4,2c86 <stbsp_vsprintfcb+0x19b8>
            if ((stbsp__int32)(l + n) > pr)
    2c9a:	0003071b          	sext.w	a4,t1
    2c9e:	4108863b          	subw	a2,a7,a6
    2ca2:	00e8d563          	bge	a7,a4,2cac <stbsp_vsprintfcb+0x19de>
               l = pr - n;
    2ca6:	0006069b          	sext.w	a3,a2
    2caa:	d0b2                	sw	a2,96(sp)
            while (i) {
    2cac:	c68d                	beqz	a3,2cd6 <stbsp_vsprintfcb+0x1a08>
    2cae:	7566                	ld	a0,120(sp)
    2cb0:	02069813          	slli	a6,a3,0x20
    2cb4:	02085813          	srli	a6,a6,0x20
    2cb8:	01078eb3          	add	t4,a5,a6
    2cbc:	85aa                	mv	a1,a0
    2cbe:	873e                	mv	a4,a5
               *s++ = *sn++;
    2cc0:	0005c883          	lbu	a7,0(a1)
    2cc4:	0705                	addi	a4,a4,1
            while (i) {
    2cc6:	0585                	addi	a1,a1,1
               *s++ = *sn++;
    2cc8:	ff170fa3          	sb	a7,-1(a4)
            while (i) {
    2ccc:	ffd71ae3          	bne	a4,t4,2cc0 <stbsp_vsprintfcb+0x19f2>
    2cd0:	9542                	add	a0,a0,a6
    2cd2:	97c2                	add	a5,a5,a6
    2cd4:	fcaa                	sd	a0,120(sp)
         l = (stbsp__uint32)(s - (num + 64));
    2cd6:	0c010a93          	addi	s5,sp,192
            cs = 1 + (3 << 24); // how many tens did we write (for commas below)
    2cda:	030002b7          	lui	t0,0x3000
            tz = pr - (n + l);
    2cde:	40d608bb          	subw	a7,a2,a3
         l = (stbsp__uint32)(s - (num + 64));
    2ce2:	415787b3          	sub	a5,a5,s5
            cs = 1 + (3 << 24); // how many tens did we write (for commas below)
    2ce6:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff8779>
    2ce8:	fbcff06f          	j	24a4 <stbsp_vsprintfcb+0x11d6>
            *--s = '0';
    2cec:	03000793          	li	a5,48
    2cf0:	fefa8fa3          	sb	a5,-1(s5)
            l = 1;
    2cf4:	030002b7          	lui	t0,0x3000
    2cf8:	4785                	li	a5,1
    2cfa:	d0be                	sw	a5,96(sp)
            *--s = '0';
    2cfc:	1afd                	addi	s5,s5,-1
            l = 1;
    2cfe:	4605                	li	a2,1
    2d00:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff8779>
    2d02:	4685                	li	a3,1
    2d04:	b9dd                	j	29fa <stbsp_vsprintfcb+0x172c>
   } else if (fl & STBSP__LEADINGSPACE) {
    2d06:	004e7713          	andi	a4,t3,4
    2d0a:	e74d                	bnez	a4,2db4 <stbsp_vsprintfcb+0x1ae6>
   } else if (fl & STBSP__LEADINGPLUS) {
    2d0c:	8b89                	andi	a5,a5,2
    2d0e:	efd9                	bnez	a5,2dac <stbsp_vsprintfcb+0x1ade>
   sign[0] = 0;
    2d10:	06010423          	sb	zero,104(sp)
    2d14:	4a01                	li	s4,0
    2d16:	b9c9                	j	29e8 <stbsp_vsprintfcb+0x171a>
               if ((s[0] == '0') && (s != (num + STBSP__NUMSZ)))
    2d18:	051c                	addi	a5,sp,640
    2d1a:	cafa89e3          	beq	s5,a5,29cc <stbsp_vsprintfcb+0x16fe>
                  ++s;
    2d1e:	0a85                	addi	s5,s5,1
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    2d20:	415786bb          	subw	a3,a5,s5
    2d24:	b165                	j	29cc <stbsp_vsprintfcb+0x16fe>
                  n = dp - n;
    2d26:	40ce87bb          	subw	a5,t4,a2
                  if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    2d2a:	12030e63          	beqz	t1,2e66 <stbsp_vsprintfcb+0x1b98>
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2d2e:	4511                	li	a0,4
    2d30:	03000613          	li	a2,48
                        *s++ = stbsp__comma;
    2d34:	00170693          	addi	a3,a4,1
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2d38:	00030563          	beqz	t1,2d42 <stbsp_vsprintfcb+0x1a74>
    2d3c:	2585                	addiw	a1,a1,1
    2d3e:	00a58963          	beq	a1,a0,2d50 <stbsp_vsprintfcb+0x1a82>
    2d42:	8736                	mv	a4,a3
                        --n;
    2d44:	37fd                	addiw	a5,a5,-1
    2d46:	fec70fa3          	sb	a2,-1(a4)
                  while (n) {
    2d4a:	f7ed                	bnez	a5,2d34 <stbsp_vsprintfcb+0x1a66>
    2d4c:	f38ff06f          	j	2484 <stbsp_vsprintfcb+0x11b6>
    2d50:	fe568fa3          	sb	t0,-1(a3)
                        *s++ = stbsp__comma;
    2d54:	0709                	addi	a4,a4,2
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2d56:	4585                	li	a1,1
    2d58:	b7f5                	j	2d44 <stbsp_vsprintfcb+0x1a76>
   sign[0] = 0;
    2d5a:	06010423          	sb	zero,104(sp)
    2d5e:	f1dfe06f          	j	1c7a <stbsp_vsprintfcb+0x9ac>
                     tail[idx + 1] = "_kMGT"[fl >> 24];
    2d62:	00002697          	auipc	a3,0x2
    2d66:	37e68693          	addi	a3,a3,894 # 50e0 <_GLOBAL__sub_I__ZSt3cin+0xf0>
    2d6a:	9736                	add	a4,a4,a3
    2d6c:	00074683          	lbu	a3,0(a4)
    2d70:	1088                	addi	a0,sp,96
    2d72:	22060713          	addi	a4,a2,544
    2d76:	972a                	add	a4,a4,a0
    2d78:	ded70823          	sb	a3,-528(a4)
                  idx++;
    2d7c:	8fb2                	mv	t6,a2
    2d7e:	fb0ff06f          	j	252e <stbsp_vsprintfcb+0x1260>
   while (limit && *sn) {
    2d82:	e00692e3          	bnez	a3,2b86 <stbsp_vsprintfcb+0x18b8>
    2d86:	bd19                	j	2b9c <stbsp_vsprintfcb+0x18ce>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    2d88:	0008071b          	sext.w	a4,a6
    2d8c:	86c2                	mv	a3,a6
    2d8e:	88d2                	mv	a7,s4
            pr = -dp + ((pr > (stbsp__int32)l) ? (stbsp__int32) l : pr);
    2d90:	863a                	mv	a2,a4
    2d92:	00e8d363          	bge	a7,a4,2d98 <stbsp_vsprintfcb+0x1aca>
    2d96:	8646                	mv	a2,a7
    2d98:	40f608bb          	subw	a7,a2,a5
    2d9c:	814ff06f          	j	1db0 <stbsp_vsprintfcb+0xae2>
            divisor = 1000.0f;
    2da0:	00003797          	auipc	a5,0x3
    2da4:	ae07b787          	fld	fa5,-1312(a5) # 5880 <STDIN_FD+0x28>
    2da8:	dd5fe06f          	j	1b7c <stbsp_vsprintfcb+0x8ae>
    2dac:	678d                	lui	a5,0x3
    2dae:	b017879b          	addiw	a5,a5,-1279 # 2b01 <stbsp_vsprintfcb+0x1833>
    2db2:	b13d                	j	29e0 <stbsp_vsprintfcb+0x1712>
    2db4:	6789                	lui	a5,0x2
    2db6:	2785                	addiw	a5,a5,1 # 2001 <stbsp_vsprintfcb+0xd33>
    2db8:	b125                	j	29e0 <stbsp_vsprintfcb+0x1712>
            *s++ = stbsp__period;
    2dba:	00004517          	auipc	a0,0x4
    2dbe:	ca254503          	lbu	a0,-862(a0) # 6a5c <stbsp__period>
         sn = s;
    2dc2:	0c210793          	addi	a5,sp,194
         n = pr;
    2dc6:	0008869b          	sext.w	a3,a7
            *s++ = stbsp__period;
    2dca:	0ca100a3          	sb	a0,193(sp)
         sn = s;
    2dce:	fcbe                	sd	a5,120(sp)
         if (n > 13)
    2dd0:	4535                	li	a0,13
         n64 <<= 4;
    2dd2:	0712                	slli	a4,a4,0x4
         if (n > 13)
    2dd4:	8836                	mv	a6,a3
    2dd6:	00d57363          	bgeu	a0,a3,2ddc <stbsp_vsprintfcb+0x1b0e>
    2dda:	4835                	li	a6,13
    2ddc:	0008051b          	sext.w	a0,a6
         while (n--) {
    2de0:	387d                	addiw	a6,a6,-1
         if (pr > (stbsp__int32)n)
    2de2:	af1542e3          	blt	a0,a7,28c6 <stbsp_vsprintfcb+0x15f8>
      tz = 0;
    2de6:	4881                	li	a7,0
    2de8:	b4cd                	j	28ca <stbsp_vsprintfcb+0x15fc>
               while (n < l) {
    2dea:	87ba                	mv	a5,a4
    2dec:	bc1d                	j	2822 <stbsp_vsprintfcb+0x1554>
         tail[0] = (char)n;
    2dee:	478d                	li	a5,3
    2df0:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    2df4:	06b109a3          	sb	a1,115(sp)
    2df8:	480d                	li	a6,3
    2dfa:	4f8d                	li	t6,3
    2dfc:	8e4ff06f          	j	1ee0 <stbsp_vsprintfcb+0xc12>
    2e00:	678d                	lui	a5,0x3
    2e02:	b017879b          	addiw	a5,a5,-1279 # 2b01 <stbsp_vsprintfcb+0x1833>
    2e06:	80aff06f          	j	1e10 <stbsp_vsprintfcb+0xb42>
            if (pr)
    2e0a:	8336                	mv	t1,a3
            *s++ = '0';
    2e0c:	0c110793          	addi	a5,sp,193
            while (i) {
    2e10:	4801                	li	a6,0
    2e12:	b561                	j	2c9a <stbsp_vsprintfcb+0x19cc>
            while (i >= 4) {
    2e14:	460d                	li	a2,3
    2e16:	04e65663          	bge	a2,a4,2e62 <stbsp_vsprintfcb+0x1b94>
    2e1a:	ffb5871b          	addiw	a4,a1,-5
    2e1e:	0027559b          	srliw	a1,a4,0x2
    2e22:	0015861b          	addiw	a2,a1,1
    2e26:	060a                	slli	a2,a2,0x2
               *(stbsp__uint32 *)s = 0x30303030;
    2e28:	30303537          	lui	a0,0x30303
    2e2c:	963e                	add	a2,a2,a5
    2e2e:	03050513          	addi	a0,a0,48 # 30303030 <_ZSt4cerr+0x302fb7a8>
    2e32:	c388                	sw	a0,0(a5)
               s += 4;
    2e34:	0791                	addi	a5,a5,4
            while (i >= 4) {
    2e36:	fef61ee3          	bne	a2,a5,2e32 <stbsp_vsprintfcb+0x1b64>
    2e3a:	0025959b          	slliw	a1,a1,0x2
    2e3e:	9f0d                	subw	a4,a4,a1
            while (i) {
    2e40:	e4070de3          	beqz	a4,2c9a <stbsp_vsprintfcb+0x19cc>
               *s++ = '0';
    2e44:	03000513          	li	a0,48
            while (i) {
    2e48:	00f705bb          	addw	a1,a4,a5
               *s++ = '0';
    2e4c:	0605                	addi	a2,a2,1
            while (i) {
    2e4e:	00060e9b          	sext.w	t4,a2
               *s++ = '0';
    2e52:	fea60fa3          	sb	a0,-1(a2)
            while (i) {
    2e56:	ffd59be3          	bne	a1,t4,2e4c <stbsp_vsprintfcb+0x1b7e>
    2e5a:	1702                	slli	a4,a4,0x20
    2e5c:	9301                	srli	a4,a4,0x20
    2e5e:	97ba                	add	a5,a5,a4
    2e60:	bd2d                	j	2c9a <stbsp_vsprintfcb+0x19cc>
            while (i >= 4) {
    2e62:	863e                	mv	a2,a5
    2e64:	b7c5                	j	2e44 <stbsp_vsprintfcb+0x1b76>
                        if ((((stbsp__uintptr)s) & 3) == 0)
    2e66:	00377693          	andi	a3,a4,3
    2e6a:	ce81                	beqz	a3,2e82 <stbsp_vsprintfcb+0x1bb4>
                        *s++ = '0';
    2e6c:	03000693          	li	a3,48
    2e70:	00d70023          	sb	a3,0(a4)
                        --n;
    2e74:	37fd                	addiw	a5,a5,-1
                        *s++ = '0';
    2e76:	0705                	addi	a4,a4,1
                     while (n) {
    2e78:	e0078663          	beqz	a5,2484 <stbsp_vsprintfcb+0x11b6>
                        if ((((stbsp__uintptr)s) & 3) == 0)
    2e7c:	00377613          	andi	a2,a4,3
    2e80:	fa65                	bnez	a2,2e70 <stbsp_vsprintfcb+0x1ba2>
                     while (n >= 4) {
    2e82:	468d                	li	a3,3
    2e84:	eaf6f5e3          	bgeu	a3,a5,2d2e <stbsp_vsprintfcb+0x1a60>
    2e88:	ffc7869b          	addiw	a3,a5,-4
    2e8c:	0026d69b          	srliw	a3,a3,0x2
    2e90:	2685                	addiw	a3,a3,1
    2e92:	068a                	slli	a3,a3,0x2
                        *(stbsp__uint32 *)s = 0x30303030;
    2e94:	30303637          	lui	a2,0x30303
    2e98:	96ba                	add	a3,a3,a4
    2e9a:	03060613          	addi	a2,a2,48 # 30303030 <_ZSt4cerr+0x302fb7a8>
    2e9e:	c310                	sw	a2,0(a4)
                        s += 4;
    2ea0:	0711                	addi	a4,a4,4
                     while (n >= 4) {
    2ea2:	fed71ee3          	bne	a4,a3,2e9e <stbsp_vsprintfcb+0x1bd0>
    2ea6:	8b8d                	andi	a5,a5,3
                  while (n) {
    2ea8:	e80793e3          	bnez	a5,2d2e <stbsp_vsprintfcb+0x1a60>
    2eac:	dd8ff06f          	j	2484 <stbsp_vsprintfcb+0x11b6>
      if (((stbsp__uintptr)sn & 3) == 0)
    2eb0:	87d6                	mv	a5,s5
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    2eb2:	56fd                	li	a3,-1
    2eb4:	b155                	j	2b58 <stbsp_vsprintfcb+0x188a>
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    2eb6:	5775                	li	a4,-3
    2eb8:	00e7ce63          	blt	a5,a4,2ed4 <stbsp_vsprintfcb+0x1c06>
    2ebc:	f6fa4663          	blt	s4,a5,2628 <stbsp_vsprintfcb+0x135a>
         if (dp > 0) {
    2ec0:	ecf054e3          	blez	a5,2d88 <stbsp_vsprintfcb+0x1aba>
    2ec4:	86c2                	mv	a3,a6
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    2ec6:	4881                	li	a7,0
    2ec8:	ee9fe06f          	j	1db0 <stbsp_vsprintfcb+0xae2>
                  while (i--)
    2ecc:	fff7869b          	addiw	a3,a5,-1
    2ed0:	8722                	mv	a4,s0
    2ed2:	b105                	j	2af2 <stbsp_vsprintfcb+0x1824>
            if (pr > (stbsp__int32)l)
    2ed4:	0008071b          	sext.w	a4,a6
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2ed8:	7ae6                	ld	s5,120(sp)
            if (pr > (stbsp__int32)l)
    2eda:	86c2                	mv	a3,a6
    2edc:	88d2                	mv	a7,s4
    2ede:	f7475d63          	bge	a4,s4,2658 <stbsp_vsprintfcb+0x138a>
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2ee2:	8542                	mv	a0,a6
    2ee4:	f56ff06f          	j	263a <stbsp_vsprintfcb+0x136c>

0000000000002ee8 <stbsp_sprintf>:
{
    2ee8:	715d                	addi	sp,sp,-80
   va_start(va, fmt);
    2eea:	02010313          	addi	t1,sp,32
{
    2eee:	f032                	sd	a2,32(sp)
    2ef0:	f436                	sd	a3,40(sp)
    2ef2:	f83a                	sd	a4,48(sp)
   result = STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    2ef4:	86ae                	mv	a3,a1
    2ef6:	862a                	mv	a2,a0
    2ef8:	871a                	mv	a4,t1
    2efa:	4581                	li	a1,0
    2efc:	4501                	li	a0,0
{
    2efe:	ec06                	sd	ra,24(sp)
    2f00:	fc3e                	sd	a5,56(sp)
    2f02:	e0c2                	sd	a6,64(sp)
    2f04:	e4c6                	sd	a7,72(sp)
   va_start(va, fmt);
    2f06:	e41a                	sd	t1,8(sp)
   result = STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    2f08:	bc6fe0ef          	jal	12ce <stbsp_vsprintfcb>
}
    2f0c:	60e2                	ld	ra,24(sp)
    2f0e:	6161                	addi	sp,sp,80
    2f10:	8082                	ret

0000000000002f12 <stbsp_vsnprintf>:
{
    2f12:	dd010113          	addi	sp,sp,-560
    2f16:	22813023          	sd	s0,544(sp)
    2f1a:	20913c23          	sd	s1,536(sp)
    2f1e:	22113423          	sd	ra,552(sp)
    2f22:	84ae                	mv	s1,a1
    2f24:	842a                	mv	s0,a0
    2f26:	88b2                	mv	a7,a2
    2f28:	8736                	mv	a4,a3
   if ( (count == 0) && !buf )
    2f2a:	e591                	bnez	a1,2f36 <stbsp_vsnprintf+0x24>
    2f2c:	c141                	beqz	a0,2fac <stbsp_vsnprintf+0x9a>
      c.buf = buf;
    2f2e:	e02a                	sd	a0,0(sp)
      c.count = count;
    2f30:	e402                	sd	zero,8(sp)
   return (c->count >= STB_SPRINTF_MIN) ? c->buf : c->tmp; // go direct into buffer if you can
    2f32:	0810                	addi	a2,sp,16
    2f34:	a089                	j	2f76 <stbsp_vsnprintf+0x64>
   if (len > c->count)
    2f36:	0015a593          	slti	a1,a1,1
    2f3a:	40b005bb          	negw	a1,a1
    2f3e:	8de5                	and	a1,a1,s1
      c.buf = buf;
    2f40:	e02a                	sd	a0,0(sp)
      c.count = count;
    2f42:	c426                	sw	s1,8(sp)
      c.length = 0;
    2f44:	c602                	sw	zero,12(sp)
   if (len > c->count)
    2f46:	2581                	sext.w	a1,a1
   if (len) {
    2f48:	0804d663          	bgez	s1,2fd4 <stbsp_vsnprintf+0xc2>
         s = buf;
    2f4c:	4781                	li	a5,0
      if (buf != c->buf) {
    2f4e:	c911                	beqz	a0,2f62 <stbsp_vsnprintf+0x50>
            *d++ = *s++;
    2f50:	0007c803          	lbu	a6,0(a5)
    2f54:	0785                	addi	a5,a5,1
    2f56:	00f40533          	add	a0,s0,a5
    2f5a:	ff050fa3          	sb	a6,-1(a0)
         } while (s < se);
    2f5e:	feb7e9e3          	bltu	a5,a1,2f50 <stbsp_vsnprintf+0x3e>
      c->count -= len;
    2f62:	40b486bb          	subw	a3,s1,a1
      c->buf += len;
    2f66:	95a2                	add	a1,a1,s0
    2f68:	e02e                	sd	a1,0(sp)
      c->count -= len;
    2f6a:	c436                	sw	a3,8(sp)
   return (c->count >= STB_SPRINTF_MIN) ? c->buf : c->tmp; // go direct into buffer if you can
    2f6c:	1ff00793          	li	a5,511
    2f70:	fcd7d1e3          	bge	a5,a3,2f32 <stbsp_vsnprintf+0x20>
    2f74:	6602                	ld	a2,0(sp)
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__clamp_callback, &c, stbsp__clamp_callback(0,&c,0), fmt, va );
    2f76:	86c6                	mv	a3,a7
    2f78:	858a                	mv	a1,sp
    2f7a:	ffffd517          	auipc	a0,0xffffd
    2f7e:	21650513          	addi	a0,a0,534 # 190 <stbsp__clamp_callback>
    2f82:	b4cfe0ef          	jal	12ce <stbsp_vsprintfcb>
      l = (int)( c.buf - buf );
    2f86:	6782                	ld	a5,0(sp)
    2f88:	9f81                	subw	a5,a5,s0
      if ( l >= count ) // should never be greater, only equal (or less) than count
    2f8a:	0097c463          	blt	a5,s1,2f92 <stbsp_vsnprintf+0x80>
         l = count - 1;
    2f8e:	fff4879b          	addiw	a5,s1,-1
      buf[l] = 0;
    2f92:	943e                	add	s0,s0,a5
    2f94:	00040023          	sb	zero,0(s0)
}
    2f98:	22813083          	ld	ra,552(sp)
    2f9c:	22013403          	ld	s0,544(sp)
    2fa0:	4532                	lw	a0,12(sp)
    2fa2:	21813483          	ld	s1,536(sp)
    2fa6:	23010113          	addi	sp,sp,560
    2faa:	8082                	ret
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__count_clamp_callback, &c, c.tmp, fmt, va );
    2fac:	86b2                	mv	a3,a2
    2fae:	858a                	mv	a1,sp
    2fb0:	0810                	addi	a2,sp,16
    2fb2:	ffffd517          	auipc	a0,0xffffd
    2fb6:	22c50513          	addi	a0,a0,556 # 1de <stbsp__count_clamp_callback>
      c.length = 0;
    2fba:	c602                	sw	zero,12(sp)
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__count_clamp_callback, &c, c.tmp, fmt, va );
    2fbc:	b12fe0ef          	jal	12ce <stbsp_vsprintfcb>
}
    2fc0:	22813083          	ld	ra,552(sp)
    2fc4:	22013403          	ld	s0,544(sp)
    2fc8:	4532                	lw	a0,12(sp)
    2fca:	21813483          	ld	s1,536(sp)
    2fce:	23010113          	addi	sp,sp,560
    2fd2:	8082                	ret
    2fd4:	86a6                	mv	a3,s1
    2fd6:	bf59                	j	2f6c <stbsp_vsnprintf+0x5a>

0000000000002fd8 <stbsp_snprintf>:
{
    2fd8:	715d                	addi	sp,sp,-80
   va_start(va, fmt);
    2fda:	02810313          	addi	t1,sp,40
{
    2fde:	f436                	sd	a3,40(sp)
   result = STB_SPRINTF_DECORATE(vsnprintf)(buf, count, fmt, va);
    2fe0:	869a                	mv	a3,t1
{
    2fe2:	ec06                	sd	ra,24(sp)
    2fe4:	f83a                	sd	a4,48(sp)
    2fe6:	fc3e                	sd	a5,56(sp)
    2fe8:	e0c2                	sd	a6,64(sp)
    2fea:	e4c6                	sd	a7,72(sp)
   va_start(va, fmt);
    2fec:	e41a                	sd	t1,8(sp)
   result = STB_SPRINTF_DECORATE(vsnprintf)(buf, count, fmt, va);
    2fee:	f25ff0ef          	jal	2f12 <stbsp_vsnprintf>
}
    2ff2:	60e2                	ld	ra,24(sp)
    2ff4:	6161                	addi	sp,sp,80
    2ff6:	8082                	ret

0000000000002ff8 <stbsp_vsprintf>:
{
    2ff8:	86ae                	mv	a3,a1
    2ffa:	8732                	mv	a4,a2
   return STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    2ffc:	4581                	li	a1,0
    2ffe:	862a                	mv	a2,a0
    3000:	4501                	li	a0,0
    3002:	accfe06f          	j	12ce <stbsp_vsprintfcb>

0000000000003006 <sprintf>:
{
    3006:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    3008:	05010313          	addi	t1,sp,80
{
    300c:	e0a2                	sd	s0,64(sp)
    300e:	fc26                	sd	s1,56(sp)
    3010:	842a                	mv	s0,a0
    3012:	e8b2                	sd	a2,80(sp)
    _vprintf_core(&ctx, format, ap);
    3014:	0808                	addi	a0,sp,16
    ctx.limit = size;
    3016:	54fd                	li	s1,-1
    _vprintf_core(&ctx, format, ap);
    3018:	861a                	mv	a2,t1
{
    301a:	e486                	sd	ra,72(sp)
    301c:	ecb6                	sd	a3,88(sp)
    301e:	f0ba                	sd	a4,96(sp)
    3020:	f4be                	sd	a5,104(sp)
    3022:	f8c2                	sd	a6,112(sp)
    3024:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    3026:	e41a                	sd	t1,8(sp)
    ctx.buf = str;
    3028:	e822                	sd	s0,16(sp)
    ctx.limit = size;
    302a:	ec26                	sd	s1,24(sp)
    ctx.written = 0;
    302c:	f002                	sd	zero,32(sp)
    ctx.stream = NULL;
    302e:	f402                	sd	zero,40(sp)
    _vprintf_core(&ctx, format, ap);
    3030:	02c000ef          	jal	305c <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    3034:	7502                	ld	a0,32(sp)
    3036:	00950b63          	beq	a0,s1,304c <sprintf+0x46>
            str[ctx.written] = '\0';
    303a:	942a                	add	s0,s0,a0
    303c:	00040023          	sb	zero,0(s0)
}
    3040:	60a6                	ld	ra,72(sp)
    3042:	6406                	ld	s0,64(sp)
    3044:	74e2                	ld	s1,56(sp)
    3046:	2501                	sext.w	a0,a0
    3048:	6109                	addi	sp,sp,128
    304a:	8082                	ret
            str[size - 1] = '\0';
    304c:	fe040f23          	sb	zero,-2(s0)
}
    3050:	60a6                	ld	ra,72(sp)
    3052:	6406                	ld	s0,64(sp)
    3054:	74e2                	ld	s1,56(sp)
    3056:	2501                	sext.w	a0,a0
    3058:	6109                	addi	sp,sp,128
    305a:	8082                	ret

000000000000305c <_vprintf_core.constprop.0.isra.0>:
static int _vprintf_core(_OutContext *ctx, const char *format, va_list ap)
    305c:	7129                	addi	sp,sp,-320
    305e:	edee                	sd	s11,216(sp)
    3060:	fe06                	sd	ra,312(sp)
    3062:	8dae                	mv	s11,a1
    while (*p)
    3064:	0005c583          	lbu	a1,0(a1)
    3068:	cde9                	beqz	a1,3142 <_vprintf_core.constprop.0.isra.0+0xe6>
    306a:	f626                	sd	s1,296(sp)
    306c:	f24a                	sd	s2,288(sp)
    306e:	ee4e                	sd	s3,280(sp)
    3070:	e656                	sd	s5,264(sp)
    3072:	f9e2                	sd	s8,240(sp)
    3074:	fa22                	sd	s0,304(sp)
    3076:	ea52                	sd	s4,272(sp)
    3078:	e25a                	sd	s6,256(sp)
    307a:	fdde                	sd	s7,248(sp)
    307c:	f5e6                	sd	s9,232(sp)
    307e:	f1ea                	sd	s10,224(sp)
    3080:	84aa                	mv	s1,a0
    3082:	8c32                	mv	s8,a2
        if (*p != '%')
    3084:	02500a93          	li	s5,37
    3088:	49c1                	li	s3,16
    308a:	00002917          	auipc	s2,0x2
    308e:	32a90913          	addi	s2,s2,810 # 53b4 <_GLOBAL__sub_I__ZSt3cin+0x3c4>
    3092:	a039                	j	30a0 <_vprintf_core.constprop.0.isra.0+0x44>
                _out_char(ctx, spec);
    3094:	8526                	mv	a0,s1
    3096:	952fe0ef          	jal	11e8 <_out_char>
    while (*p)
    309a:	000dc583          	lbu	a1,0(s11)
    309e:	c5d9                	beqz	a1,312c <_vprintf_core.constprop.0.isra.0+0xd0>
            _out_char(ctx, *p++);
    30a0:	0d85                	addi	s11,s11,1
        if (*p != '%')
    30a2:	ff5599e3          	bne	a1,s5,3094 <_vprintf_core.constprop.0.isra.0+0x38>
        int flag_left = 0, flag_zero = 0, flag_plus = 0, flag_space = 0, flag_hash = 0;
    30a6:	4501                	li	a0,0
    30a8:	4881                	li	a7,0
    30aa:	4581                	li	a1,0
    30ac:	4b01                	li	s6,0
    30ae:	4a01                	li	s4,0
            if (*p == '-')
    30b0:	000dcc83          	lbu	s9,0(s11)
    30b4:	fe0c871b          	addiw	a4,s9,-32
    30b8:	0ff77713          	zext.b	a4,a4
    30bc:	00e9e763          	bltu	s3,a4,30ca <_vprintf_core.constprop.0.isra.0+0x6e>
    30c0:	070a                	slli	a4,a4,0x2
    30c2:	974a                	add	a4,a4,s2
    30c4:	4318                	lw	a4,0(a4)
    30c6:	974a                	add	a4,a4,s2
    30c8:	8702                	jr	a4
        if (*p == '*')
    30ca:	02a00793          	li	a5,42
    30ce:	16fc9c63          	bne	s9,a5,3246 <_vprintf_core.constprop.0.isra.0+0x1ea>
            width = va_arg(ap, int);
    30d2:	000c2403          	lw	s0,0(s8)
    30d6:	0c21                	addi	s8,s8,8
            if (width < 0)
    30d8:	00045563          	bgez	s0,30e2 <_vprintf_core.constprop.0.isra.0+0x86>
                width = -width;
    30dc:	4080043b          	negw	s0,s0
                flag_left = 1;
    30e0:	4a05                	li	s4,1
            while (*p >= '0' && *p <= '9')
    30e2:	001dcc83          	lbu	s9,1(s11)
            p++;
    30e6:	0d85                	addi	s11,s11,1
        if (*p == '.')
    30e8:	02e00793          	li	a5,46
        int precision = -1;
    30ec:	5bfd                	li	s7,-1
        if (*p == '.')
    30ee:	18fc8a63          	beq	s9,a5,3282 <_vprintf_core.constprop.0.isra.0+0x226>
        if (*p == 'l')
    30f2:	06c00693          	li	a3,108
    30f6:	8666                	mv	a2,s9
    30f8:	1adc8663          	beq	s9,a3,32a4 <_vprintf_core.constprop.0.isra.0+0x248>
        else if (*p == 'z')
    30fc:	07a00693          	li	a3,122
            p++;
    3100:	0d85                	addi	s11,s11,1
        else if (*p == 'z')
    3102:	24dc8163          	beq	s9,a3,3344 <_vprintf_core.constprop.0.isra.0+0x2e8>
        if (!spec)
    3106:	06400693          	li	a3,100
    310a:	4adc8163          	beq	s9,a3,35ac <_vprintf_core.constprop.0.isra.0+0x550>
    310e:	06400693          	li	a3,100
        int len_mod = 0;
    3112:	4e81                	li	t4,0
    3114:	1b96e663          	bltu	a3,s9,32c0 <_vprintf_core.constprop.0.isra.0+0x264>
    3118:	04700693          	li	a3,71
    311c:	2796e463          	bltu	a3,s9,3384 <_vprintf_core.constprop.0.isra.0+0x328>
    3120:	04400693          	li	a3,68
    3124:	0596e363          	bltu	a3,s9,316a <_vprintf_core.constprop.0.isra.0+0x10e>
    3128:	240c9363          	bnez	s9,336e <_vprintf_core.constprop.0.isra.0+0x312>
    312c:	7452                	ld	s0,304(sp)
    312e:	74b2                	ld	s1,296(sp)
    3130:	7912                	ld	s2,288(sp)
    3132:	69f2                	ld	s3,280(sp)
    3134:	6a52                	ld	s4,272(sp)
    3136:	6ab2                	ld	s5,264(sp)
    3138:	6b12                	ld	s6,256(sp)
    313a:	7bee                	ld	s7,248(sp)
    313c:	7c4e                	ld	s8,240(sp)
    313e:	7cae                	ld	s9,232(sp)
    3140:	7d0e                	ld	s10,224(sp)
}
    3142:	70f2                	ld	ra,312(sp)
    3144:	6dee                	ld	s11,216(sp)
    3146:	6131                	addi	sp,sp,320
    3148:	8082                	ret
            if (*p == '-')
    314a:	4585                	li	a1,1
            p++;
    314c:	0d85                	addi	s11,s11,1
            if (*p == '-')
    314e:	b78d                	j	30b0 <_vprintf_core.constprop.0.isra.0+0x54>
    3150:	4505                	li	a0,1
            p++;
    3152:	0d85                	addi	s11,s11,1
        while (1)
    3154:	bfb1                	j	30b0 <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    3156:	4885                	li	a7,1
            p++;
    3158:	0d85                	addi	s11,s11,1
        while (1)
    315a:	bf99                	j	30b0 <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    315c:	4b05                	li	s6,1
            p++;
    315e:	0d85                	addi	s11,s11,1
        while (1)
    3160:	bf81                	j	30b0 <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    3162:	4a05                	li	s4,1
            p++;
    3164:	0d85                	addi	s11,s11,1
        while (1)
    3166:	b7a9                	j	30b0 <_vprintf_core.constprop.0.isra.0+0x54>
        char spec = *p++;
    3168:	8dbe                	mv	s11,a5
            fmt_tmp[f_idx++] = '%';
    316a:	02500693          	li	a3,37
    316e:	02d10823          	sb	a3,48(sp)
    3172:	4d05                	li	s10,1
            if (flag_left)
    3174:	000a0763          	beqz	s4,3182 <_vprintf_core.constprop.0.isra.0+0x126>
                fmt_tmp[f_idx++] = '-';
    3178:	02d00693          	li	a3,45
    317c:	02d108a3          	sb	a3,49(sp)
    3180:	4d09                	li	s10,2
            if (flag_zero)
    3182:	000b0c63          	beqz	s6,319a <_vprintf_core.constprop.0.isra.0+0x13e>
                fmt_tmp[f_idx++] = '0';
    3186:	0c0d0793          	addi	a5,s10,192
    318a:	0818                	addi	a4,sp,16
    318c:	00e786b3          	add	a3,a5,a4
    3190:	03000613          	li	a2,48
    3194:	f6c68023          	sb	a2,-160(a3)
    3198:	2d05                	addiw	s10,s10,1
            if (flag_plus)
    319a:	c999                	beqz	a1,31b0 <_vprintf_core.constprop.0.isra.0+0x154>
                fmt_tmp[f_idx++] = '+';
    319c:	0c0d0793          	addi	a5,s10,192
    31a0:	0818                	addi	a4,sp,16
    31a2:	00e786b3          	add	a3,a5,a4
    31a6:	02b00613          	li	a2,43
    31aa:	f6c68023          	sb	a2,-160(a3)
    31ae:	2d05                	addiw	s10,s10,1
            if (flag_space)
    31b0:	00088c63          	beqz	a7,31c8 <_vprintf_core.constprop.0.isra.0+0x16c>
                fmt_tmp[f_idx++] = ' ';
    31b4:	0c0d0793          	addi	a5,s10,192
    31b8:	0818                	addi	a4,sp,16
    31ba:	00e786b3          	add	a3,a5,a4
    31be:	02000613          	li	a2,32
    31c2:	f6c68023          	sb	a2,-160(a3)
    31c6:	2d05                	addiw	s10,s10,1
            if (flag_hash)
    31c8:	c919                	beqz	a0,31de <_vprintf_core.constprop.0.isra.0+0x182>
                fmt_tmp[f_idx++] = '#';
    31ca:	0c0d0793          	addi	a5,s10,192
    31ce:	0818                	addi	a4,sp,16
    31d0:	00e786b3          	add	a3,a5,a4
    31d4:	02300613          	li	a2,35
    31d8:	f6c68023          	sb	a2,-160(a3)
    31dc:	2d05                	addiw	s10,s10,1
            if (width > 0)
    31de:	03010a13          	addi	s4,sp,48
    31e2:	28804563          	bgtz	s0,346c <_vprintf_core.constprop.0.isra.0+0x410>
            if (precision >= 0)
    31e6:	260bd763          	bgez	s7,3454 <_vprintf_core.constprop.0.isra.0+0x3f8>
            fmt_tmp[f_idx++] = spec;
    31ea:	0c0d0793          	addi	a5,s10,192
    31ee:	0818                	addi	a4,sp,16
    31f0:	00e78633          	add	a2,a5,a4
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    31f4:	000c3683          	ld	a3,0(s8)
            fmt_tmp[f_idx] = '\0';
    31f8:	001d071b          	addiw	a4,s10,1
    31fc:	0c070793          	addi	a5,a4,192
    3200:	0818                	addi	a4,sp,16
            fmt_tmp[f_idx++] = spec;
    3202:	f7960023          	sb	s9,-160(a2)
            fmt_tmp[f_idx] = '\0';
    3206:	973e                	add	a4,a4,a5
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    3208:	08000593          	li	a1,128
    320c:	8652                	mv	a2,s4
    320e:	0888                	addi	a0,sp,80
            fmt_tmp[f_idx] = '\0';
    3210:	f6070023          	sb	zero,-160(a4)
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    3214:	dc5ff0ef          	jal	2fd8 <stbsp_snprintf>
            for (int i = 0; f_buf[i] != '\0'; i++)
    3218:	05014583          	lbu	a1,80(sp)
            double f_val = va_arg(ap, double);
    321c:	0c21                	addi	s8,s8,8
            for (int i = 0; f_buf[i] != '\0'; i++)
    321e:	05110413          	addi	s0,sp,81
    3222:	e6058ce3          	beqz	a1,309a <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, f_buf[i]);
    3226:	8526                	mv	a0,s1
    3228:	fc1fd0ef          	jal	11e8 <_out_char>
            for (int i = 0; f_buf[i] != '\0'; i++)
    322c:	00044583          	lbu	a1,0(s0)
    3230:	0405                	addi	s0,s0,1
    3232:	e60584e3          	beqz	a1,309a <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, f_buf[i]);
    3236:	8526                	mv	a0,s1
    3238:	fb1fd0ef          	jal	11e8 <_out_char>
            for (int i = 0; f_buf[i] != '\0'; i++)
    323c:	00044583          	lbu	a1,0(s0)
    3240:	0405                	addi	s0,s0,1
    3242:	f1f5                	bnez	a1,3226 <_vprintf_core.constprop.0.isra.0+0x1ca>
    3244:	bd99                	j	309a <_vprintf_core.constprop.0.isra.0+0x3e>
            while (*p >= '0' && *p <= '9')
    3246:	fd0c869b          	addiw	a3,s9,-48
    324a:	0ff6f313          	zext.b	t1,a3
    324e:	4725                	li	a4,9
        int width = 0;
    3250:	4401                	li	s0,0
            while (*p >= '0' && *p <= '9')
    3252:	4625                	li	a2,9
    3254:	e8676ae3          	bltu	a4,t1,30e8 <_vprintf_core.constprop.0.isra.0+0x8c>
    3258:	001dcc83          	lbu	s9,1(s11)
                width = width * 10 + (*p - '0');
    325c:	0024171b          	slliw	a4,s0,0x2
    3260:	9f21                	addw	a4,a4,s0
    3262:	0017171b          	slliw	a4,a4,0x1
    3266:	00e6843b          	addw	s0,a3,a4
            while (*p >= '0' && *p <= '9')
    326a:	fd0c869b          	addiw	a3,s9,-48
    326e:	0ff6f713          	zext.b	a4,a3
                p++;
    3272:	0d85                	addi	s11,s11,1
            while (*p >= '0' && *p <= '9')
    3274:	fee672e3          	bgeu	a2,a4,3258 <_vprintf_core.constprop.0.isra.0+0x1fc>
        if (*p == '.')
    3278:	02e00793          	li	a5,46
        int precision = -1;
    327c:	5bfd                	li	s7,-1
        if (*p == '.')
    327e:	e6fc9ae3          	bne	s9,a5,30f2 <_vprintf_core.constprop.0.isra.0+0x96>
            if (*p == '*')
    3282:	001dcc83          	lbu	s9,1(s11)
    3286:	02a00793          	li	a5,42
    328a:	16fc9f63          	bne	s9,a5,3408 <_vprintf_core.constprop.0.isra.0+0x3ac>
                while (*p >= '0' && *p <= '9')
    328e:	002dcc83          	lbu	s9,2(s11)
        if (*p == 'l')
    3292:	06c00693          	li	a3,108
                precision = va_arg(ap, int);
    3296:	000c2b83          	lw	s7,0(s8)
                p++;
    329a:	0d89                	addi	s11,s11,2
                precision = va_arg(ap, int);
    329c:	0c21                	addi	s8,s8,8
        if (*p == 'l')
    329e:	8666                	mv	a2,s9
    32a0:	e4dc9ee3          	bne	s9,a3,30fc <_vprintf_core.constprop.0.isra.0+0xa0>
            if (*p == 'l')
    32a4:	001dcc83          	lbu	s9,1(s11)
    32a8:	08cc8d63          	beq	s9,a2,3342 <_vprintf_core.constprop.0.isra.0+0x2e6>
        char spec = *p++;
    32ac:	06400693          	li	a3,100
    32b0:	0d89                	addi	s11,s11,2
        if (!spec)
    32b2:	4cdc8c63          	beq	s9,a3,378a <_vprintf_core.constprop.0.isra.0+0x72e>
    32b6:	06400693          	li	a3,100
            len_mod = 1;
    32ba:	4e85                	li	t4,1
    32bc:	e596fee3          	bgeu	a3,s9,3118 <_vprintf_core.constprop.0.isra.0+0xbc>
    32c0:	f9bc869b          	addiw	a3,s9,-101
    32c4:	0ff6f693          	zext.b	a3,a3
    32c8:	464d                	li	a2,19
    32ca:	12d66863          	bltu	a2,a3,33fa <_vprintf_core.constprop.0.isra.0+0x39e>
    32ce:	4e05                	li	t3,1
    32d0:	00091637          	lui	a2,0x91
    32d4:	00de1333          	sll	t1,t3,a3
    32d8:	81060613          	addi	a2,a2,-2032 # 90810 <_ZSt4cerr+0x88f88>
    32dc:	00c37633          	and	a2,t1,a2
    32e0:	1a061463          	bnez	a2,3488 <_vprintf_core.constprop.0.isra.0+0x42c>
    32e4:	00737313          	andi	t1,t1,7
    32e8:	e80311e3          	bnez	t1,316a <_vprintf_core.constprop.0.isra.0+0x10e>
    32ec:	4639                	li	a2,14
    32ee:	10c69663          	bne	a3,a2,33fa <_vprintf_core.constprop.0.isra.0+0x39e>
            const char *s = va_arg(ap, char *);
    32f2:	000c3c83          	ld	s9,0(s8)
            if (!s)
    32f6:	420c8863          	beqz	s9,3726 <_vprintf_core.constprop.0.isra.0+0x6ca>
            while (*tmp && (precision < 0 || len < precision))
    32fa:	000cc683          	lbu	a3,0(s9)
    32fe:	38068863          	beqz	a3,368e <_vprintf_core.constprop.0.isra.0+0x632>
            const char *tmp = s;
    3302:	8666                	mv	a2,s9
            int len = 0;
    3304:	4681                	li	a3,0
            while (*tmp && (precision < 0 || len < precision))
    3306:	00db8863          	beq	s7,a3,3316 <_vprintf_core.constprop.0.isra.0+0x2ba>
    330a:	00164583          	lbu	a1,1(a2)
                len++;
    330e:	2685                	addiw	a3,a3,1
                tmp++;
    3310:	0605                	addi	a2,a2,1
            while (*tmp && (precision < 0 || len < precision))
    3312:	f9f5                	bnez	a1,3306 <_vprintf_core.constprop.0.isra.0+0x2aa>
    3314:	8bb6                	mv	s7,a3
            int padding = (width > len) ? width - len : 0;
    3316:	268bc563          	blt	s7,s0,3580 <_vprintf_core.constprop.0.isra.0+0x524>
            for (int i = 0; i < len; i++)
    331a:	4401                	li	s0,0
    331c:	020b8163          	beqz	s7,333e <_vprintf_core.constprop.0.isra.0+0x2e2>
    3320:	4d01                	li	s10,0
                _out_char(ctx, s[i]);
    3322:	01ac86b3          	add	a3,s9,s10
    3326:	0006c583          	lbu	a1,0(a3)
    332a:	8526                	mv	a0,s1
            for (int i = 0; i < len; i++)
    332c:	0d05                	addi	s10,s10,1
                _out_char(ctx, s[i]);
    332e:	ebbfd0ef          	jal	11e8 <_out_char>
            for (int i = 0; i < len; i++)
    3332:	000d069b          	sext.w	a3,s10
    3336:	ff76c6e3          	blt	a3,s7,3322 <_vprintf_core.constprop.0.isra.0+0x2c6>
            if (flag_left)
    333a:	260a1463          	bnez	s4,35a2 <_vprintf_core.constprop.0.isra.0+0x546>
            const char *s = va_arg(ap, char *);
    333e:	0c21                	addi	s8,s8,8
    3340:	bba9                	j	309a <_vprintf_core.constprop.0.isra.0+0x3e>
                p++;
    3342:	0d89                	addi	s11,s11,2
        char spec = *p++;
    3344:	000dcc83          	lbu	s9,0(s11)
    3348:	06400693          	li	a3,100
    334c:	001d8793          	addi	a5,s11,1
        if (!spec)
    3350:	3edc8063          	beq	s9,a3,3730 <_vprintf_core.constprop.0.isra.0+0x6d4>
    3354:	0796ea63          	bltu	a3,s9,33c8 <_vprintf_core.constprop.0.isra.0+0x36c>
    3358:	04700693          	li	a3,71
    335c:	0f96e263          	bltu	a3,s9,3440 <_vprintf_core.constprop.0.isra.0+0x3e4>
    3360:	04400693          	li	a3,68
    3364:	e196e2e3          	bltu	a3,s9,3168 <_vprintf_core.constprop.0.isra.0+0x10c>
    3368:	dc0c82e3          	beqz	s9,312c <_vprintf_core.constprop.0.isra.0+0xd0>
        char spec = *p++;
    336c:	8dbe                	mv	s11,a5
            _out_char(ctx, '%');
    336e:	02500593          	li	a1,37
    3372:	8526                	mv	a0,s1
    3374:	e75fd0ef          	jal	11e8 <_out_char>
            if (spec != '%')
    3378:	02500713          	li	a4,37
    337c:	d0ec8fe3          	beq	s9,a4,309a <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, spec);
    3380:	85e6                	mv	a1,s9
    3382:	bb09                	j	3094 <_vprintf_core.constprop.0.isra.0+0x38>
    3384:	05800693          	li	a3,88
    3388:	2edc8263          	beq	s9,a3,366c <_vprintf_core.constprop.0.isra.0+0x610>
    338c:	06300713          	li	a4,99
    3390:	06ec9563          	bne	s9,a4,33fa <_vprintf_core.constprop.0.isra.0+0x39e>
            char c = (char)va_arg(ap, int);
    3394:	000c4c83          	lbu	s9,0(s8)
            int padding = (width > 1) ? width - 1 : 0;
    3398:	8722                	mv	a4,s0
    339a:	00804363          	bgtz	s0,33a0 <_vprintf_core.constprop.0.isra.0+0x344>
    339e:	4705                	li	a4,1
    33a0:	fff7041b          	addiw	s0,a4,-1
            if (!flag_left)
    33a4:	3c0a0463          	beqz	s4,376c <_vprintf_core.constprop.0.isra.0+0x710>
            _out_char(ctx, c);
    33a8:	85e6                	mv	a1,s9
    33aa:	8526                	mv	a0,s1
    33ac:	e3dfd0ef          	jal	11e8 <_out_char>
                for (int i = 0; i < padding; i++)
    33b0:	4a01                	li	s4,0
    33b2:	d451                	beqz	s0,333e <_vprintf_core.constprop.0.isra.0+0x2e2>
                    _out_char(ctx, ' ');
    33b4:	02000593          	li	a1,32
    33b8:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    33ba:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    33bc:	e2dfd0ef          	jal	11e8 <_out_char>
                for (int i = 0; i < padding; i++)
    33c0:	ff441ae3          	bne	s0,s4,33b4 <_vprintf_core.constprop.0.isra.0+0x358>
            const char *s = va_arg(ap, char *);
    33c4:	0c21                	addi	s8,s8,8
    33c6:	b9d1                	j	309a <_vprintf_core.constprop.0.isra.0+0x3e>
    33c8:	f9bc861b          	addiw	a2,s9,-101
    33cc:	0ff67613          	zext.b	a2,a2
    33d0:	46cd                	li	a3,19
    33d2:	40c6e963          	bltu	a3,a2,37e4 <_vprintf_core.constprop.0.isra.0+0x788>
    33d6:	00091337          	lui	t1,0x91
    33da:	4685                	li	a3,1
    33dc:	00c696b3          	sll	a3,a3,a2
    33e0:	81030313          	addi	t1,t1,-2032 # 90810 <_ZSt4cerr+0x88f88>
    33e4:	0066f333          	and	t1,a3,t1
    33e8:	34031c63          	bnez	t1,3740 <_vprintf_core.constprop.0.isra.0+0x6e4>
    33ec:	8a9d                	andi	a3,a3,7
    33ee:	d6069de3          	bnez	a3,3168 <_vprintf_core.constprop.0.isra.0+0x10c>
    33f2:	46b9                	li	a3,14
        char spec = *p++;
    33f4:	8dbe                	mv	s11,a5
    33f6:	eed60ee3          	beq	a2,a3,32f2 <_vprintf_core.constprop.0.isra.0+0x296>
            _out_char(ctx, '%');
    33fa:	02500593          	li	a1,37
    33fe:	8526                	mv	a0,s1
    3400:	de9fd0ef          	jal	11e8 <_out_char>
                _out_char(ctx, spec);
    3404:	85e6                	mv	a1,s9
    3406:	b179                	j	3094 <_vprintf_core.constprop.0.isra.0+0x38>
                while (*p >= '0' && *p <= '9')
    3408:	fd0c869b          	addiw	a3,s9,-48
    340c:	0ff6fe13          	zext.b	t3,a3
    3410:	4625                	li	a2,9
            p++;
    3412:	0d85                	addi	s11,s11,1
                precision = 0;
    3414:	4b81                	li	s7,0
                while (*p >= '0' && *p <= '9')
    3416:	4325                	li	t1,9
    3418:	cdc66de3          	bltu	a2,t3,30f2 <_vprintf_core.constprop.0.isra.0+0x96>
                    precision = precision * 10 + (*p - '0');
    341c:	002b961b          	slliw	a2,s7,0x2
                while (*p >= '0' && *p <= '9')
    3420:	001dcc83          	lbu	s9,1(s11)
                    precision = precision * 10 + (*p - '0');
    3424:	0176073b          	addw	a4,a2,s7
    3428:	0017171b          	slliw	a4,a4,0x1
    342c:	00e68bbb          	addw	s7,a3,a4
                while (*p >= '0' && *p <= '9')
    3430:	fd0c869b          	addiw	a3,s9,-48
    3434:	0ff6f613          	zext.b	a2,a3
                    p++;
    3438:	0d85                	addi	s11,s11,1
                while (*p >= '0' && *p <= '9')
    343a:	fec371e3          	bgeu	t1,a2,341c <_vprintf_core.constprop.0.isra.0+0x3c0>
    343e:	b955                	j	30f2 <_vprintf_core.constprop.0.isra.0+0x96>
    3440:	05800693          	li	a3,88
    3444:	3cdc8d63          	beq	s9,a3,381e <_vprintf_core.constprop.0.isra.0+0x7c2>
    3448:	06300713          	li	a4,99
        char spec = *p++;
    344c:	8dbe                	mv	s11,a5
    344e:	f4ec83e3          	beq	s9,a4,3394 <_vprintf_core.constprop.0.isra.0+0x338>
    3452:	b765                	j	33fa <_vprintf_core.constprop.0.isra.0+0x39e>
                f_idx += sprintf(&fmt_tmp[f_idx], ".%d", precision);
    3454:	01aa0533          	add	a0,s4,s10
    3458:	865e                	mv	a2,s7
    345a:	00002597          	auipc	a1,0x2
    345e:	cde58593          	addi	a1,a1,-802 # 5138 <_GLOBAL__sub_I__ZSt3cin+0x148>
    3462:	ba5ff0ef          	jal	3006 <sprintf>
    3466:	00ad0d3b          	addw	s10,s10,a0
    346a:	b341                	j	31ea <_vprintf_core.constprop.0.isra.0+0x18e>
                f_idx += sprintf(&fmt_tmp[f_idx], "%d", width);
    346c:	01aa0533          	add	a0,s4,s10
    3470:	8622                	mv	a2,s0
    3472:	00002597          	auipc	a1,0x2
    3476:	cbe58593          	addi	a1,a1,-834 # 5130 <_GLOBAL__sub_I__ZSt3cin+0x140>
    347a:	b8dff0ef          	jal	3006 <sprintf>
    347e:	00ad0d3b          	addw	s10,s10,a0
            if (precision >= 0)
    3482:	d60bc4e3          	bltz	s7,31ea <_vprintf_core.constprop.0.isra.0+0x18e>
    3486:	b7f9                	j	3454 <_vprintf_core.constprop.0.isra.0+0x3f8>
            int is_signed = (spec == 'd' || spec == 'i');
    3488:	06900693          	li	a3,105
    348c:	10dc8e63          	beq	s9,a3,35a8 <_vprintf_core.constprop.0.isra.0+0x54c>
                val = (uint64)va_arg(ap, void *);
    3490:	008c0793          	addi	a5,s8,8
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3494:	07800693          	li	a3,120
                val = (uint64)va_arg(ap, void *);
    3498:	e43e                	sd	a5,8(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    349a:	38dc9d63          	bne	s9,a3,3834 <_vprintf_core.constprop.0.isra.0+0x7d8>
            else if (len_mod == 1)
    349e:	33ce8963          	beq	t4,t3,37d0 <_vprintf_core.constprop.0.isra.0+0x774>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    34a2:	000c6e03          	lwu	t3,0(s8)
    34a6:	85f6                	mv	a1,t4
    34a8:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    34aa:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    34ac:	00002f97          	auipc	t6,0x2
    34b0:	c54f8f93          	addi	t6,t6,-940 # 5100 <_GLOBAL__sub_I__ZSt3cin+0x110>
    if (val == 0)
    34b4:	120e0363          	beqz	t3,35da <_vprintf_core.constprop.0.isra.0+0x57e>
    34b8:	01010293          	addi	t0,sp,16
                    sign_char = '-';
    34bc:	8616                	mv	a2,t0
    34be:	86f2                	mv	a3,t3
        buf[i++] = digits[val % base];
    34c0:	0266f8b3          	remu	a7,a3,t1
    34c4:	8f32                	mv	t5,a2
    while (val != 0)
    34c6:	0605                	addi	a2,a2,1
    34c8:	8eb6                	mv	t4,a3
        buf[i++] = digits[val % base];
    34ca:	98fe                	add	a7,a7,t6
    34cc:	0008c883          	lbu	a7,0(a7)
        val /= base;
    34d0:	0266d6b3          	divu	a3,a3,t1
        buf[i++] = digits[val % base];
    34d4:	ff160fa3          	sb	a7,-1(a2)
    while (val != 0)
    34d8:	fe6ef4e3          	bgeu	t4,t1,34c0 <_vprintf_core.constprop.0.isra.0+0x464>
        buf[i++] = digits[val % base];
    34dc:	405f0f3b          	subw	t5,t5,t0
    34e0:	2f05                	addiw	t5,t5,1
            if (precision >= 0)
    34e2:	100bc363          	bltz	s7,35e8 <_vprintf_core.constprop.0.isra.0+0x58c>
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    34e6:	1d7f4d63          	blt	t5,s7,36c0 <_vprintf_core.constprop.0.isra.0+0x664>
            if (precision == 0 && val == 0)
    34ea:	340b9163          	bnez	s7,382c <_vprintf_core.constprop.0.isra.0+0x7d0>
    34ee:	200e0763          	beqz	t3,36fc <_vprintf_core.constprop.0.isra.0+0x6a0>
            for (int i = digit_len - 1; i >= 0; i--)
    34f2:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    34f6:	07000693          	li	a3,112
            for (int i = digit_len - 1; i >= 0; i--)
    34fa:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    34fc:	28dc8e63          	beq	s9,a3,3798 <_vprintf_core.constprop.0.isra.0+0x73c>
    3500:	2a051663          	bnez	a0,37ac <_vprintf_core.constprop.0.isra.0+0x750>
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    3504:	00bf05bb          	addw	a1,t5,a1
    3508:	8d52                	mv	s10,s4
    350a:	4b01                	li	s6,0
            char *prefix_str = NULL;
    350c:	4c81                	li	s9,0
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    350e:	1085d263          	bge	a1,s0,3612 <_vprintf_core.constprop.0.isra.0+0x5b6>
    3512:	9c0d                	subw	s0,s0,a1
            if (!flag_left && !flag_zero)
    3514:	100d0a63          	beqz	s10,3628 <_vprintf_core.constprop.0.isra.0+0x5cc>
            if (sign_char)
    3518:	6782                	ld	a5,0(sp)
    351a:	10079263          	bnez	a5,361e <_vprintf_core.constprop.0.isra.0+0x5c2>
            if (prefix_str)
    351e:	000c8c63          	beqz	s9,3536 <_vprintf_core.constprop.0.isra.0+0x4da>
                _out_char(ctx, prefix_str[0]);
    3522:	000cc583          	lbu	a1,0(s9)
    3526:	8526                	mv	a0,s1
    3528:	cc1fd0ef          	jal	11e8 <_out_char>
                _out_char(ctx, prefix_str[1]);
    352c:	001cc583          	lbu	a1,1(s9)
    3530:	8526                	mv	a0,s1
    3532:	cb7fd0ef          	jal	11e8 <_out_char>
            int total_zeros = prec_zeros + ((flag_zero && !flag_left) ? padding : 0);
    3536:	180b0263          	beqz	s6,36ba <_vprintf_core.constprop.0.isra.0+0x65e>
    353a:	100a1863          	bnez	s4,364a <_vprintf_core.constprop.0.isra.0+0x5ee>
    353e:	008b8bbb          	addw	s7,s7,s0
            for (int i = 0; i < total_zeros; i++)
    3542:	2a0b8363          	beqz	s7,37e8 <_vprintf_core.constprop.0.isra.0+0x78c>
    3546:	4c81                	li	s9,0
                _out_char(ctx, '0');
    3548:	03000593          	li	a1,48
    354c:	8526                	mv	a0,s1
            for (int i = 0; i < total_zeros; i++)
    354e:	2c85                	addiw	s9,s9,1
                _out_char(ctx, '0');
    3550:	c99fd0ef          	jal	11e8 <_out_char>
            for (int i = 0; i < total_zeros; i++)
    3554:	ff7c9ae3          	bne	s9,s7,3548 <_vprintf_core.constprop.0.isra.0+0x4ec>
            for (int i = digit_len - 1; i >= 0; i--)
    3558:	57fd                	li	a5,-1
    355a:	00fc0f63          	beq	s8,a5,3578 <_vprintf_core.constprop.0.isra.0+0x51c>
    355e:	01010c93          	addi	s9,sp,16
    3562:	9ce2                	add	s9,s9,s8
    3564:	00f10c13          	addi	s8,sp,15
                _out_char(ctx, num_buf[i]);
    3568:	000cc583          	lbu	a1,0(s9)
    356c:	8526                	mv	a0,s1
            for (int i = digit_len - 1; i >= 0; i--)
    356e:	1cfd                	addi	s9,s9,-1
                _out_char(ctx, num_buf[i]);
    3570:	c79fd0ef          	jal	11e8 <_out_char>
            for (int i = digit_len - 1; i >= 0; i--)
    3574:	ff9c1ae3          	bne	s8,s9,3568 <_vprintf_core.constprop.0.isra.0+0x50c>
            if (flag_left)
    3578:	0c0a1e63          	bnez	s4,3654 <_vprintf_core.constprop.0.isra.0+0x5f8>
        char spec = *p++;
    357c:	6c22                	ld	s8,8(sp)
    357e:	be31                	j	309a <_vprintf_core.constprop.0.isra.0+0x3e>
            int padding = (width > len) ? width - len : 0;
    3580:	4174043b          	subw	s0,s0,s7
            if (!flag_left)
    3584:	100a0a63          	beqz	s4,3698 <_vprintf_core.constprop.0.isra.0+0x63c>
            for (int i = 0; i < len; i++)
    3588:	d80b9ce3          	bnez	s7,3320 <_vprintf_core.constprop.0.isra.0+0x2c4>
                for (int i = 0; i < padding; i++)
    358c:	4a01                	li	s4,0
                    _out_char(ctx, ' ');
    358e:	02000593          	li	a1,32
    3592:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    3594:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    3596:	c53fd0ef          	jal	11e8 <_out_char>
                for (int i = 0; i < padding; i++)
    359a:	ff441ae3          	bne	s0,s4,358e <_vprintf_core.constprop.0.isra.0+0x532>
            const char *s = va_arg(ap, char *);
    359e:	0c21                	addi	s8,s8,8
    35a0:	bced                	j	309a <_vprintf_core.constprop.0.isra.0+0x3e>
                for (int i = 0; i < padding; i++)
    35a2:	f46d                	bnez	s0,358c <_vprintf_core.constprop.0.isra.0+0x530>
            const char *s = va_arg(ap, char *);
    35a4:	0c21                	addi	s8,s8,8
    35a6:	bcd5                	j	309a <_vprintf_core.constprop.0.isra.0+0x3e>
            else if (len_mod == 1)
    35a8:	1fce8163          	beq	t4,t3,378a <_vprintf_core.constprop.0.isra.0+0x72e>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    35ac:	000c2e03          	lw	t3,0(s8)
    35b0:	008c0793          	addi	a5,s8,8
    35b4:	e43e                	sd	a5,8(sp)
                int64 sval = (int64)val;
    35b6:	86f2                	mv	a3,t3
                if (sval < 0)
    35b8:	1406cb63          	bltz	a3,370e <_vprintf_core.constprop.0.isra.0+0x6b2>
                    sign_char = '+';
    35bc:	02b00793          	li	a5,43
    35c0:	e03e                	sd	a5,0(sp)
                else if (flag_plus)
    35c2:	e589                	bnez	a1,35cc <_vprintf_core.constprop.0.isra.0+0x570>
                else if (flag_space)
    35c4:	00589793          	slli	a5,a7,0x5
    35c8:	e03e                	sd	a5,0(sp)
    35ca:	85c6                	mv	a1,a7
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    35cc:	4329                	li	t1,10
    35ce:	00002f97          	auipc	t6,0x2
    35d2:	b32f8f93          	addi	t6,t6,-1230 # 5100 <_GLOBAL__sub_I__ZSt3cin+0x110>
    if (val == 0)
    35d6:	ee0e11e3          	bnez	t3,34b8 <_vprintf_core.constprop.0.isra.0+0x45c>
        buf[i++] = '0';
    35da:	03000693          	li	a3,48
    35de:	00d10823          	sb	a3,16(sp)
        return i;
    35e2:	4f05                	li	t5,1
            if (precision >= 0)
    35e4:	f00bd1e3          	bgez	s7,34e6 <_vprintf_core.constprop.0.isra.0+0x48a>
            for (int i = digit_len - 1; i >= 0; i--)
    35e8:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    35ec:	07000893          	li	a7,112
            if (!flag_left && !flag_zero)
    35f0:	016a6d33          	or	s10,s4,s6
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    35f4:	4b81                	li	s7,0
            for (int i = digit_len - 1; i >= 0; i--)
    35f6:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    35f8:	0d1c9f63          	bne	s9,a7,36d6 <_vprintf_core.constprop.0.isra.0+0x67a>
                prefix_str = (spec == 'X') ? "0X" : "0x";
    35fc:	00002c97          	auipc	s9,0x2
    3600:	b1cc8c93          	addi	s9,s9,-1252 # 5118 <_GLOBAL__sub_I__ZSt3cin+0x128>
                prefix_len += 2;
    3604:	2589                	addiw	a1,a1,2
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    3606:	017585bb          	addw	a1,a1,s7
    360a:	01e585bb          	addw	a1,a1,t5
    360e:	f085c2e3          	blt	a1,s0,3512 <_vprintf_core.constprop.0.isra.0+0x4b6>
            if (!flag_left && !flag_zero)
    3612:	080d0f63          	beqz	s10,36b0 <_vprintf_core.constprop.0.isra.0+0x654>
            if (sign_char)
    3616:	6782                	ld	a5,0(sp)
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    3618:	4401                	li	s0,0
            if (sign_char)
    361a:	f00782e3          	beqz	a5,351e <_vprintf_core.constprop.0.isra.0+0x4c2>
                _out_char(ctx, sign_char);
    361e:	6582                	ld	a1,0(sp)
    3620:	8526                	mv	a0,s1
    3622:	bc7fd0ef          	jal	11e8 <_out_char>
    3626:	bde5                	j	351e <_vprintf_core.constprop.0.isra.0+0x4c2>
                    _out_char(ctx, ' ');
    3628:	02000593          	li	a1,32
    362c:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    362e:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    3630:	bb9fd0ef          	jal	11e8 <_out_char>
                for (int i = 0; i < padding; i++)
    3634:	efa402e3          	beq	s0,s10,3518 <_vprintf_core.constprop.0.isra.0+0x4bc>
                    _out_char(ctx, ' ');
    3638:	02000593          	li	a1,32
    363c:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    363e:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    3640:	ba9fd0ef          	jal	11e8 <_out_char>
                for (int i = 0; i < padding; i++)
    3644:	ffa412e3          	bne	s0,s10,3628 <_vprintf_core.constprop.0.isra.0+0x5cc>
    3648:	bdc1                	j	3518 <_vprintf_core.constprop.0.isra.0+0x4bc>
            for (int i = 0; i < total_zeros; i++)
    364a:	ee0b9ee3          	bnez	s7,3546 <_vprintf_core.constprop.0.isra.0+0x4ea>
            for (int i = digit_len - 1; i >= 0; i--)
    364e:	577d                	li	a4,-1
    3650:	f0ec17e3          	bne	s8,a4,355e <_vprintf_core.constprop.0.isra.0+0x502>
                for (int i = 0; i < padding; i++)
    3654:	d405                	beqz	s0,357c <_vprintf_core.constprop.0.isra.0+0x520>
    3656:	4a01                	li	s4,0
                    _out_char(ctx, ' ');
    3658:	02000593          	li	a1,32
    365c:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    365e:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    3660:	b89fd0ef          	jal	11e8 <_out_char>
                for (int i = 0; i < padding; i++)
    3664:	fe8a1ae3          	bne	s4,s0,3658 <_vprintf_core.constprop.0.isra.0+0x5fc>
        char spec = *p++;
    3668:	6c22                	ld	s8,8(sp)
    366a:	bc05                	j	309a <_vprintf_core.constprop.0.isra.0+0x3e>
                val = (uint64)va_arg(ap, void *);
    366c:	008c0793          	addi	a5,s8,8
    3670:	e43e                	sd	a5,8(sp)
            else if (len_mod == 1)
    3672:	180e9163          	bnez	t4,37f4 <_vprintf_core.constprop.0.isra.0+0x798>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    3676:	000c6e03          	lwu	t3,0(s8)
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    367a:	4581                	li	a1,0
    367c:	05800c93          	li	s9,88
    3680:	e002                	sd	zero,0(sp)
    3682:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    3684:	00002f97          	auipc	t6,0x2
    3688:	a64f8f93          	addi	t6,t6,-1436 # 50e8 <_GLOBAL__sub_I__ZSt3cin+0xf8>
    368c:	b525                	j	34b4 <_vprintf_core.constprop.0.isra.0+0x458>
            int padding = (width > len) ? width - len : 0;
    368e:	ca8058e3          	blez	s0,333e <_vprintf_core.constprop.0.isra.0+0x2e2>
            if (!flag_left)
    3692:	ee0a1de3          	bnez	s4,358c <_vprintf_core.constprop.0.isra.0+0x530>
            int len = 0;
    3696:	4b81                	li	s7,0
                for (int i = 0; i < padding; i++)
    3698:	4d01                	li	s10,0
                    _out_char(ctx, ' ');
    369a:	02000593          	li	a1,32
    369e:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    36a0:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    36a2:	b47fd0ef          	jal	11e8 <_out_char>
                for (int i = 0; i < padding; i++)
    36a6:	fe8d1ae3          	bne	s10,s0,369a <_vprintf_core.constprop.0.isra.0+0x63e>
            for (int i = 0; i < len; i++)
    36aa:	c60b9be3          	bnez	s7,3320 <_vprintf_core.constprop.0.isra.0+0x2c4>
    36ae:	b941                	j	333e <_vprintf_core.constprop.0.isra.0+0x2e2>
            if (sign_char)
    36b0:	6782                	ld	a5,0(sp)
    36b2:	4401                	li	s0,0
    36b4:	f7ad                	bnez	a5,361e <_vprintf_core.constprop.0.isra.0+0x5c2>
            if (prefix_str)
    36b6:	e60c96e3          	bnez	s9,3522 <_vprintf_core.constprop.0.isra.0+0x4c6>
            for (int i = 0; i < total_zeros; i++)
    36ba:	e80b96e3          	bnez	s7,3546 <_vprintf_core.constprop.0.isra.0+0x4ea>
    36be:	bd69                	j	3558 <_vprintf_core.constprop.0.isra.0+0x4fc>
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    36c0:	41eb8bbb          	subw	s7,s7,t5
    36c4:	8d52                	mv	s10,s4
    36c6:	4b01                	li	s6,0
            for (int i = digit_len - 1; i >= 0; i--)
    36c8:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    36cc:	07000893          	li	a7,112
            for (int i = digit_len - 1; i >= 0; i--)
    36d0:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    36d2:	f31c85e3          	beq	s9,a7,35fc <_vprintf_core.constprop.0.isra.0+0x5a0>
    36d6:	cd09                	beqz	a0,36f0 <_vprintf_core.constprop.0.isra.0+0x694>
    36d8:	000e0c63          	beqz	t3,36f0 <_vprintf_core.constprop.0.isra.0+0x694>
    36dc:	07800513          	li	a0,120
            for (int i = digit_len - 1; i >= 0; i--)
    36e0:	00060c1b          	sext.w	s8,a2
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    36e4:	f0ac8ce3          	beq	s9,a0,35fc <_vprintf_core.constprop.0.isra.0+0x5a0>
    36e8:	05800613          	li	a2,88
    36ec:	12cc8463          	beq	s9,a2,3814 <_vprintf_core.constprop.0.isra.0+0x7b8>
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    36f0:	00bb85bb          	addw	a1,s7,a1
    36f4:	01e585bb          	addw	a1,a1,t5
            char *prefix_str = NULL;
    36f8:	4c81                	li	s9,0
    36fa:	bd11                	j	350e <_vprintf_core.constprop.0.isra.0+0x4b2>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    36fc:	07000693          	li	a3,112
    3700:	8d52                	mv	s10,s4
    3702:	4b01                	li	s6,0
    3704:	08dc8d63          	beq	s9,a3,379e <_vprintf_core.constprop.0.isra.0+0x742>
    3708:	5c7d                	li	s8,-1
            char *prefix_str = NULL;
    370a:	4c81                	li	s9,0
    370c:	b509                	j	350e <_vprintf_core.constprop.0.isra.0+0x4b2>
                    sign_char = '-';
    370e:	02d00793          	li	a5,45
                    val = (uint64)(-sval);
    3712:	40d00e33          	neg	t3,a3
    3716:	4585                	li	a1,1
    3718:	4329                	li	t1,10
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    371a:	00002f97          	auipc	t6,0x2
    371e:	9e6f8f93          	addi	t6,t6,-1562 # 5100 <_GLOBAL__sub_I__ZSt3cin+0x110>
                    sign_char = '-';
    3722:	e03e                	sd	a5,0(sp)
    3724:	bb51                	j	34b8 <_vprintf_core.constprop.0.isra.0+0x45c>
                s = "(null)";
    3726:	00002c97          	auipc	s9,0x2
    372a:	a02c8c93          	addi	s9,s9,-1534 # 5128 <_GLOBAL__sub_I__ZSt3cin+0x138>
    372e:	bed1                	j	3302 <_vprintf_core.constprop.0.isra.0+0x2a6>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    3730:	000c3683          	ld	a3,0(s8)
    3734:	008c0713          	addi	a4,s8,8
    3738:	e43a                	sd	a4,8(sp)
    373a:	8dbe                	mv	s11,a5
    373c:	8e36                	mv	t3,a3
            if (is_signed)
    373e:	bdad                	j	35b8 <_vprintf_core.constprop.0.isra.0+0x55c>
            int is_signed = (spec == 'd' || spec == 'i');
    3740:	06900693          	li	a3,105
    3744:	fedc86e3          	beq	s9,a3,3730 <_vprintf_core.constprop.0.isra.0+0x6d4>
                val = (uint64)va_arg(ap, void *);
    3748:	008c0713          	addi	a4,s8,8
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    374c:	07800693          	li	a3,120
                val = (uint64)va_arg(ap, void *);
    3750:	e43a                	sd	a4,8(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3752:	06dc9063          	bne	s9,a3,37b2 <_vprintf_core.constprop.0.isra.0+0x756>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    3756:	000c3e03          	ld	t3,0(s8)
    375a:	8dbe                	mv	s11,a5
    375c:	4581                	li	a1,0
    375e:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3760:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    3762:	00002f97          	auipc	t6,0x2
    3766:	99ef8f93          	addi	t6,t6,-1634 # 5100 <_GLOBAL__sub_I__ZSt3cin+0x110>
    376a:	b3a9                	j	34b4 <_vprintf_core.constprop.0.isra.0+0x458>
                for (int i = 0; i < padding; i++)
    376c:	c809                	beqz	s0,377e <_vprintf_core.constprop.0.isra.0+0x722>
                    _out_char(ctx, ' ');
    376e:	02000593          	li	a1,32
    3772:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    3774:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    3776:	a73fd0ef          	jal	11e8 <_out_char>
                for (int i = 0; i < padding; i++)
    377a:	ff441ae3          	bne	s0,s4,376e <_vprintf_core.constprop.0.isra.0+0x712>
            _out_char(ctx, c);
    377e:	85e6                	mv	a1,s9
    3780:	8526                	mv	a0,s1
    3782:	a67fd0ef          	jal	11e8 <_out_char>
            const char *s = va_arg(ap, char *);
    3786:	0c21                	addi	s8,s8,8
    3788:	ba09                	j	309a <_vprintf_core.constprop.0.isra.0+0x3e>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    378a:	000c3683          	ld	a3,0(s8)
    378e:	008c0793          	addi	a5,s8,8
    3792:	e43e                	sd	a5,8(sp)
    3794:	8e36                	mv	t3,a3
            if (is_signed)
    3796:	b50d                	j	35b8 <_vprintf_core.constprop.0.isra.0+0x55c>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    3798:	8d52                	mv	s10,s4
    379a:	4b01                	li	s6,0
    379c:	b585                	j	35fc <_vprintf_core.constprop.0.isra.0+0x5a0>
                digit_len = 0;
    379e:	4f01                	li	t5,0
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    37a0:	5c7d                	li	s8,-1
                prefix_str = (spec == 'X') ? "0X" : "0x";
    37a2:	00002c97          	auipc	s9,0x2
    37a6:	976c8c93          	addi	s9,s9,-1674 # 5118 <_GLOBAL__sub_I__ZSt3cin+0x128>
    37aa:	bda9                	j	3604 <_vprintf_core.constprop.0.isra.0+0x5a8>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    37ac:	8d52                	mv	s10,s4
    37ae:	4b01                	li	s6,0
    37b0:	b735                	j	36dc <_vprintf_core.constprop.0.isra.0+0x680>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    37b2:	07000693          	li	a3,112
    37b6:	04dc8263          	beq	s9,a3,37fa <_vprintf_core.constprop.0.isra.0+0x79e>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    37ba:	000c3e03          	ld	t3,0(s8)
    37be:	8dbe                	mv	s11,a5
    37c0:	4581                	li	a1,0
    37c2:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    37c4:	4329                	li	t1,10
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    37c6:	00002f97          	auipc	t6,0x2
    37ca:	93af8f93          	addi	t6,t6,-1734 # 5100 <_GLOBAL__sub_I__ZSt3cin+0x110>
    37ce:	b1dd                	j	34b4 <_vprintf_core.constprop.0.isra.0+0x458>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    37d0:	000c3e03          	ld	t3,0(s8)
    37d4:	4581                	li	a1,0
    37d6:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    37d8:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    37da:	00002f97          	auipc	t6,0x2
    37de:	926f8f93          	addi	t6,t6,-1754 # 5100 <_GLOBAL__sub_I__ZSt3cin+0x110>
    37e2:	b9c9                	j	34b4 <_vprintf_core.constprop.0.isra.0+0x458>
        char spec = *p++;
    37e4:	8dbe                	mv	s11,a5
    37e6:	b911                	j	33fa <_vprintf_core.constprop.0.isra.0+0x39e>
            for (int i = digit_len - 1; i >= 0; i--)
    37e8:	577d                	li	a4,-1
    37ea:	4401                	li	s0,0
    37ec:	d6ec19e3          	bne	s8,a4,355e <_vprintf_core.constprop.0.isra.0+0x502>
        char spec = *p++;
    37f0:	6c22                	ld	s8,8(sp)
    37f2:	b065                	j	309a <_vprintf_core.constprop.0.isra.0+0x3e>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    37f4:	000c3e03          	ld	t3,0(s8)
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    37f8:	b549                	j	367a <_vprintf_core.constprop.0.isra.0+0x61e>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    37fa:	8dbe                	mv	s11,a5
                val = (uint64)va_arg(ap, void *);
    37fc:	000c3e03          	ld	t3,0(s8)
    3800:	4581                	li	a1,0
    3802:	07000c93          	li	s9,112
    3806:	e002                	sd	zero,0(sp)
    3808:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    380a:	00002f97          	auipc	t6,0x2
    380e:	8f6f8f93          	addi	t6,t6,-1802 # 5100 <_GLOBAL__sub_I__ZSt3cin+0x110>
    3812:	b14d                	j	34b4 <_vprintf_core.constprop.0.isra.0+0x458>
                prefix_str = (spec == 'X') ? "0X" : "0x";
    3814:	00002c97          	auipc	s9,0x2
    3818:	90cc8c93          	addi	s9,s9,-1780 # 5120 <_GLOBAL__sub_I__ZSt3cin+0x130>
    381c:	b3e5                	j	3604 <_vprintf_core.constprop.0.isra.0+0x5a8>
                val = (uint64)va_arg(ap, void *);
    381e:	008c0713          	addi	a4,s8,8
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    3822:	000c3e03          	ld	t3,0(s8)
                val = (uint64)va_arg(ap, void *);
    3826:	e43a                	sd	a4,8(sp)
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    3828:	8dbe                	mv	s11,a5
    382a:	bd81                	j	367a <_vprintf_core.constprop.0.isra.0+0x61e>
    382c:	8d52                	mv	s10,s4
    382e:	4b01                	li	s6,0
    3830:	4b81                	li	s7,0
    3832:	bd59                	j	36c8 <_vprintf_core.constprop.0.isra.0+0x66c>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3834:	07000693          	li	a3,112
    3838:	fcdc82e3          	beq	s9,a3,37fc <_vprintf_core.constprop.0.isra.0+0x7a0>
            else if (len_mod == 1)
    383c:	01ce8c63          	beq	t4,t3,3854 <_vprintf_core.constprop.0.isra.0+0x7f8>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    3840:	000c6e03          	lwu	t3,0(s8)
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    3844:	4581                	li	a1,0
    3846:	e002                	sd	zero,0(sp)
    3848:	4329                	li	t1,10
    384a:	00002f97          	auipc	t6,0x2
    384e:	8b6f8f93          	addi	t6,t6,-1866 # 5100 <_GLOBAL__sub_I__ZSt3cin+0x110>
    3852:	b18d                	j	34b4 <_vprintf_core.constprop.0.isra.0+0x458>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    3854:	000c3e03          	ld	t3,0(s8)
            if (is_signed)
    3858:	b7f5                	j	3844 <_vprintf_core.constprop.0.isra.0+0x7e8>

000000000000385a <vsnprintf>:
{
    385a:	7139                	addi	sp,sp,-64
    385c:	f822                	sd	s0,48(sp)
    385e:	f426                	sd	s1,40(sp)
    3860:	842e                	mv	s0,a1
    3862:	84aa                	mv	s1,a0
    3864:	85b2                	mv	a1,a2
    _vprintf_core(&ctx, format, ap);
    3866:	850a                	mv	a0,sp
    3868:	8636                	mv	a2,a3
{
    386a:	fc06                	sd	ra,56(sp)
    ctx.buf = str;
    386c:	e026                	sd	s1,0(sp)
    ctx.limit = size;
    386e:	e422                	sd	s0,8(sp)
    ctx.written = 0;
    3870:	e802                	sd	zero,16(sp)
    ctx.stream = NULL;
    3872:	ec02                	sd	zero,24(sp)
    _vprintf_core(&ctx, format, ap);
    3874:	fe8ff0ef          	jal	305c <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    3878:	6542                	ld	a0,16(sp)
    if (size > 0)
    387a:	c411                	beqz	s0,3886 <vsnprintf+0x2c>
        if (ctx.written < size)
    387c:	00857b63          	bgeu	a0,s0,3892 <vsnprintf+0x38>
            str[ctx.written] = '\0';
    3880:	94aa                	add	s1,s1,a0
    3882:	00048023          	sb	zero,0(s1)
}
    3886:	70e2                	ld	ra,56(sp)
    3888:	7442                	ld	s0,48(sp)
    388a:	74a2                	ld	s1,40(sp)
    388c:	2501                	sext.w	a0,a0
    388e:	6121                	addi	sp,sp,64
    3890:	8082                	ret
            str[size - 1] = '\0';
    3892:	94a2                	add	s1,s1,s0
    3894:	fe048fa3          	sb	zero,-1(s1)
}
    3898:	70e2                	ld	ra,56(sp)
    389a:	7442                	ld	s0,48(sp)
    389c:	74a2                	ld	s1,40(sp)
    389e:	2501                	sext.w	a0,a0
    38a0:	6121                	addi	sp,sp,64
    38a2:	8082                	ret

00000000000038a4 <snprintf>:
{
    38a4:	7119                	addi	sp,sp,-128
    38a6:	e0a2                	sd	s0,64(sp)
    38a8:	fc26                	sd	s1,56(sp)
    38aa:	842e                	mv	s0,a1
    38ac:	84aa                	mv	s1,a0
    38ae:	85b2                	mv	a1,a2
    _vprintf_core(&ctx, format, ap);
    38b0:	0808                	addi	a0,sp,16
    va_start(ap, format);
    38b2:	08b0                	addi	a2,sp,88
{
    38b4:	e486                	sd	ra,72(sp)
    38b6:	ecb6                	sd	a3,88(sp)
    38b8:	f0ba                	sd	a4,96(sp)
    38ba:	f4be                	sd	a5,104(sp)
    38bc:	f8c2                	sd	a6,112(sp)
    38be:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    38c0:	e432                	sd	a2,8(sp)
    ctx.buf = str;
    38c2:	e826                	sd	s1,16(sp)
    ctx.limit = size;
    38c4:	ec22                	sd	s0,24(sp)
    ctx.written = 0;
    38c6:	f002                	sd	zero,32(sp)
    ctx.stream = NULL;
    38c8:	f402                	sd	zero,40(sp)
    _vprintf_core(&ctx, format, ap);
    38ca:	f92ff0ef          	jal	305c <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    38ce:	7502                	ld	a0,32(sp)
    if (size > 0)
    38d0:	c411                	beqz	s0,38dc <snprintf+0x38>
        if (ctx.written < size)
    38d2:	00857b63          	bgeu	a0,s0,38e8 <snprintf+0x44>
            str[ctx.written] = '\0';
    38d6:	94aa                	add	s1,s1,a0
    38d8:	00048023          	sb	zero,0(s1)
}
    38dc:	60a6                	ld	ra,72(sp)
    38de:	6406                	ld	s0,64(sp)
    38e0:	74e2                	ld	s1,56(sp)
    38e2:	2501                	sext.w	a0,a0
    38e4:	6109                	addi	sp,sp,128
    38e6:	8082                	ret
            str[size - 1] = '\0';
    38e8:	94a2                	add	s1,s1,s0
    38ea:	fe048fa3          	sb	zero,-1(s1)
}
    38ee:	60a6                	ld	ra,72(sp)
    38f0:	6406                	ld	s0,64(sp)
    38f2:	74e2                	ld	s1,56(sp)
    38f4:	2501                	sext.w	a0,a0
    38f6:	6109                	addi	sp,sp,128
    38f8:	8082                	ret

00000000000038fa <printf>:
{
    38fa:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    38fc:	04810313          	addi	t1,sp,72
{
    3900:	e4ae                	sd	a1,72(sp)
    3902:	e8b2                	sd	a2,80(sp)
    3904:	f4be                	sd	a5,104(sp)
    _vprintf_core(&ctx, format, ap);
    3906:	85aa                	mv	a1,a0
    ctx.stream = stdout;
    3908:	00004797          	auipc	a5,0x4
    390c:	de87b783          	ld	a5,-536(a5) # 76f0 <stdout>
    _vprintf_core(&ctx, format, ap);
    3910:	0808                	addi	a0,sp,16
    3912:	861a                	mv	a2,t1
{
    3914:	fc06                	sd	ra,56(sp)
    3916:	ecb6                	sd	a3,88(sp)
    3918:	f0ba                	sd	a4,96(sp)
    391a:	f8c2                	sd	a6,112(sp)
    391c:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    391e:	e41a                	sd	t1,8(sp)
    ctx.buf = NULL;
    3920:	e802                	sd	zero,16(sp)
    ctx.limit = 0;
    3922:	ec02                	sd	zero,24(sp)
    ctx.written = 0;
    3924:	f002                	sd	zero,32(sp)
    ctx.stream = stdout;
    3926:	f43e                	sd	a5,40(sp)
    _vprintf_core(&ctx, format, ap);
    3928:	f34ff0ef          	jal	305c <_vprintf_core.constprop.0.isra.0>
}
    392c:	70e2                	ld	ra,56(sp)
    392e:	5502                	lw	a0,32(sp)
    3930:	6109                	addi	sp,sp,128
    3932:	8082                	ret

0000000000003934 <sscanf>:
{
    3934:	7159                	addi	sp,sp,-112
    va_start(ap, format);
    3936:	04010e13          	addi	t3,sp,64
{
    393a:	8eaa                	mv	t4,a0
    ctx.fd = -1;
    393c:	537d                	li	t1,-1
{
    393e:	e0b2                	sd	a2,64(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    3940:	0808                	addi	a0,sp,16
    3942:	8672                	mv	a2,t3
{
    3944:	fc06                	sd	ra,56(sp)
    3946:	e4b6                	sd	a3,72(sp)
    3948:	e8ba                	sd	a4,80(sp)
    394a:	ecbe                	sd	a5,88(sp)
    394c:	f0c2                	sd	a6,96(sp)
    394e:	f4c6                	sd	a7,104(sp)
    va_start(ap, format);
    3950:	e472                	sd	t3,8(sp)
    ctx.buf = str;
    3952:	e876                	sd	t4,16(sp)
    ctx.fd = -1;
    3954:	cc1a                	sw	t1,24(sp)
    ctx.pos = 0;
    3956:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    3958:	d41a                	sw	t1,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    395a:	81efd0ef          	jal	978 <_vscanf_core.constprop.0>
}
    395e:	70e2                	ld	ra,56(sp)
    3960:	6165                	addi	sp,sp,112
    3962:	8082                	ret

0000000000003964 <scanf>:
{
    3964:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    3966:	04810313          	addi	t1,sp,72
{
    396a:	e4ae                	sd	a1,72(sp)
    396c:	e8b2                	sd	a2,80(sp)
    396e:	f4be                	sd	a5,104(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    3970:	85aa                	mv	a1,a0
    ctx.ungotten = -1;
    3972:	57fd                	li	a5,-1
    int ret = _vscanf_core(&ctx, format, ap);
    3974:	0808                	addi	a0,sp,16
    3976:	861a                	mv	a2,t1
{
    3978:	fc06                	sd	ra,56(sp)
    397a:	ecb6                	sd	a3,88(sp)
    397c:	f0ba                	sd	a4,96(sp)
    397e:	f8c2                	sd	a6,112(sp)
    3980:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    3982:	e41a                	sd	t1,8(sp)
    ctx.buf = NULL;
    3984:	e802                	sd	zero,16(sp)
    ctx.fd = STDIN_FD;
    3986:	cc02                	sw	zero,24(sp)
    ctx.pos = 0;
    3988:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    398a:	d43e                	sw	a5,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    398c:	fedfc0ef          	jal	978 <_vscanf_core.constprop.0>
}
    3990:	70e2                	ld	ra,56(sp)
    3992:	6109                	addi	sp,sp,128
    3994:	8082                	ret

0000000000003996 <fopen>:
{
    3996:	1101                	addi	sp,sp,-32
    3998:	e426                	sd	s1,8(sp)
    399a:	84ae                	mv	s1,a1
    399c:	e04a                	sd	s2,0(sp)
    if (strcmp(mode, "r") == 0)
    399e:	00001597          	auipc	a1,0x1
    39a2:	7a258593          	addi	a1,a1,1954 # 5140 <_GLOBAL__sub_I__ZSt3cin+0x150>
{
    39a6:	892a                	mv	s2,a0
    if (strcmp(mode, "r") == 0)
    39a8:	8526                	mv	a0,s1
{
    39aa:	e822                	sd	s0,16(sp)
    39ac:	ec06                	sd	ra,24(sp)
    if (strcmp(mode, "r") == 0)
    39ae:	298010ef          	jal	4c46 <strcmp>
    39b2:	842a                	mv	s0,a0
    39b4:	c919                	beqz	a0,39ca <fopen+0x34>
    else if (strcmp(mode, "w") == 0)
    39b6:	00001597          	auipc	a1,0x1
    39ba:	79258593          	addi	a1,a1,1938 # 5148 <_GLOBAL__sub_I__ZSt3cin+0x158>
    39be:	8526                	mv	a0,s1
    39c0:	286010ef          	jal	4c46 <strcmp>
        flags = O_WRONLY | O_CREAT | O_TRUNC;
    39c4:	24100413          	li	s0,577
    else if (strcmp(mode, "w") == 0)
    39c8:	ed39                	bnez	a0,3a26 <fopen+0x90>
    int64 fd = open(filename, flags);
    39ca:	85a2                	mv	a1,s0
    39cc:	854a                	mv	a0,s2
    39ce:	f42fc0ef          	jal	110 <open>
    39d2:	84aa                	mv	s1,a0
    if (fd < 0)
    39d4:	06054c63          	bltz	a0,3a4c <fopen+0xb6>
    FILE *f = (FILE *)malloc(sizeof(FILE));
    39d8:	42000513          	li	a0,1056
    39dc:	2f3000ef          	jal	44ce <malloc>
    39e0:	892a                	mv	s2,a0
    if (!f)
    39e2:	c53d                	beqz	a0,3a50 <fopen+0xba>
    memset(f, 0, sizeof(FILE));
    39e4:	42000613          	li	a2,1056
    39e8:	4581                	li	a1,0
    39ea:	0ee010ef          	jal	4ad8 <memset>
    if (fd == 1)
    39ee:	4785                	li	a5,1
    f->fd = (int)fd;
    39f0:	00992023          	sw	s1,0(s2)
    f->flags = flags;
    39f4:	00892223          	sw	s0,4(s2)
    if (fd == 1)
    39f8:	00f48e63          	beq	s1,a5,3a14 <fopen+0x7e>
    else if (fd == 2)
    39fc:	4789                	li	a5,2
    39fe:	00f48b63          	beq	s1,a5,3a14 <fopen+0x7e>
        f->buf_mode = 0;
    3a02:	40092e23          	sw	zero,1052(s2)
}
    3a06:	60e2                	ld	ra,24(sp)
    3a08:	6442                	ld	s0,16(sp)
    3a0a:	64a2                	ld	s1,8(sp)
    3a0c:	854a                	mv	a0,s2
    3a0e:	6902                	ld	s2,0(sp)
    3a10:	6105                	addi	sp,sp,32
    3a12:	8082                	ret
    3a14:	60e2                	ld	ra,24(sp)
    3a16:	6442                	ld	s0,16(sp)
        f->buf_mode = 2;
    3a18:	40992e23          	sw	s1,1052(s2)
}
    3a1c:	854a                	mv	a0,s2
    3a1e:	64a2                	ld	s1,8(sp)
    3a20:	6902                	ld	s2,0(sp)
    3a22:	6105                	addi	sp,sp,32
    3a24:	8082                	ret
    else if (strcmp(mode, "a") == 0)
    3a26:	00001597          	auipc	a1,0x1
    3a2a:	72a58593          	addi	a1,a1,1834 # 5150 <_GLOBAL__sub_I__ZSt3cin+0x160>
    3a2e:	8526                	mv	a0,s1
    3a30:	216010ef          	jal	4c46 <strcmp>
        flags = O_WRONLY | O_CREAT | O_APPEND;
    3a34:	44100413          	li	s0,1089
    else if (strcmp(mode, "a") == 0)
    3a38:	d949                	beqz	a0,39ca <fopen+0x34>
    else if (strcmp(mode, "r+") == 0)
    3a3a:	00001597          	auipc	a1,0x1
    3a3e:	71e58593          	addi	a1,a1,1822 # 5158 <_GLOBAL__sub_I__ZSt3cin+0x168>
    3a42:	8526                	mv	a0,s1
    3a44:	202010ef          	jal	4c46 <strcmp>
        flags = O_RDWR;
    3a48:	4409                	li	s0,2
    else if (strcmp(mode, "r+") == 0)
    3a4a:	d141                	beqz	a0,39ca <fopen+0x34>
        return NULL;
    3a4c:	4901                	li	s2,0
    3a4e:	bf65                	j	3a06 <fopen+0x70>
        close(fd);
    3a50:	8526                	mv	a0,s1
    3a52:	ea6fc0ef          	jal	f8 <close>
        return NULL;
    3a56:	4901                	li	s2,0
    3a58:	b77d                	j	3a06 <fopen+0x70>

0000000000003a5a <fclose>:
    if (!stream)
    3a5a:	cd29                	beqz	a0,3ab4 <fclose+0x5a>
    if (stream->buf_write_pos > 0)
    3a5c:	41052603          	lw	a2,1040(a0)
{
    3a60:	1141                	addi	sp,sp,-16
    3a62:	e022                	sd	s0,0(sp)
    3a64:	e406                	sd	ra,8(sp)
    3a66:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    3a68:	02c04a63          	bgtz	a2,3a9c <fclose+0x42>
    if (stream != stdin && stream != stdout && stream != stderr)
    3a6c:	00004797          	auipc	a5,0x4
    3a70:	c8478793          	addi	a5,a5,-892 # 76f0 <stdout>
    3a74:	6798                	ld	a4,8(a5)
    3a76:	00870e63          	beq	a4,s0,3a92 <fclose+0x38>
    3a7a:	6398                	ld	a4,0(a5)
    3a7c:	00870b63          	beq	a4,s0,3a92 <fclose+0x38>
    3a80:	6b9c                	ld	a5,16(a5)
    3a82:	00878863          	beq	a5,s0,3a92 <fclose+0x38>
        close(stream->fd);
    3a86:	4008                	lw	a0,0(s0)
    3a88:	e70fc0ef          	jal	f8 <close>
        free(stream);
    3a8c:	8522                	mv	a0,s0
    3a8e:	1cb000ef          	jal	4458 <free>
}
    3a92:	60a2                	ld	ra,8(sp)
    3a94:	6402                	ld	s0,0(sp)
    return 0;
    3a96:	4501                	li	a0,0
}
    3a98:	0141                	addi	sp,sp,16
    3a9a:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3a9c:	4108                	lw	a0,0(a0)
    3a9e:	01040593          	addi	a1,s0,16
    3aa2:	e4efc0ef          	jal	f0 <write>
        if (ret < stream->buf_write_pos)
    3aa6:	41042783          	lw	a5,1040(s0)
    3aaa:	00f54763          	blt	a0,a5,3ab8 <fclose+0x5e>
        stream->buf_write_pos = 0;
    3aae:	40042823          	sw	zero,1040(s0)
    3ab2:	bf6d                	j	3a6c <fclose+0x12>
        return -1;
    3ab4:	557d                	li	a0,-1
}
    3ab6:	8082                	ret
            stream->error = 1;
    3ab8:	4785                	li	a5,1
    3aba:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3abc:	40042823          	sw	zero,1040(s0)
            return EOF;
    3ac0:	b775                	j	3a6c <fclose+0x12>

0000000000003ac2 <fflush>:
    if (!stream)
    3ac2:	c121                	beqz	a0,3b02 <fflush+0x40>
    if (stream->buf_write_pos > 0)
    3ac4:	41052603          	lw	a2,1040(a0)
{
    3ac8:	1141                	addi	sp,sp,-16
    3aca:	e022                	sd	s0,0(sp)
    3acc:	e406                	sd	ra,8(sp)
    3ace:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    3ad0:	00c04763          	bgtz	a2,3ade <fflush+0x1c>
    return 0;
    3ad4:	4501                	li	a0,0
}
    3ad6:	60a2                	ld	ra,8(sp)
    3ad8:	6402                	ld	s0,0(sp)
    3ada:	0141                	addi	sp,sp,16
    3adc:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3ade:	4108                	lw	a0,0(a0)
    3ae0:	01040593          	addi	a1,s0,16
    3ae4:	e0cfc0ef          	jal	f0 <write>
        if (ret < stream->buf_write_pos)
    3ae8:	41042783          	lw	a5,1040(s0)
    3aec:	00f54563          	blt	a0,a5,3af6 <fflush+0x34>
        stream->buf_write_pos = 0;
    3af0:	40042823          	sw	zero,1040(s0)
    3af4:	b7c5                	j	3ad4 <fflush+0x12>
            stream->error = 1;
    3af6:	4785                	li	a5,1
    3af8:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3afa:	40042823          	sw	zero,1040(s0)
        return EOF;
    3afe:	557d                	li	a0,-1
    3b00:	bfd9                	j	3ad6 <fflush+0x14>
    3b02:	557d                	li	a0,-1
}
    3b04:	8082                	ret

0000000000003b06 <fprintf>:
{
    3b06:	7159                	addi	sp,sp,-112
    3b08:	fc06                	sd	ra,56(sp)
    3b0a:	e0b2                	sd	a2,64(sp)
    3b0c:	e4b6                	sd	a3,72(sp)
    3b0e:	e8ba                	sd	a4,80(sp)
    3b10:	ecbe                	sd	a5,88(sp)
    3b12:	f0c2                	sd	a6,96(sp)
    3b14:	f4c6                	sd	a7,104(sp)
    if (!stream)
    3b16:	cd19                	beqz	a0,3b34 <fprintf+0x2e>
    va_start(ap, format);
    3b18:	832a                	mv	t1,a0
    3b1a:	0090                	addi	a2,sp,64
    _vprintf_core(&ctx, format, ap);
    3b1c:	0808                	addi	a0,sp,16
    va_start(ap, format);
    3b1e:	e432                	sd	a2,8(sp)
    ctx.buf = NULL;
    3b20:	e802                	sd	zero,16(sp)
    ctx.limit = 0;
    3b22:	ec02                	sd	zero,24(sp)
    ctx.written = 0;
    3b24:	f002                	sd	zero,32(sp)
    ctx.stream  = stream;
    3b26:	f41a                	sd	t1,40(sp)
    _vprintf_core(&ctx, format, ap);
    3b28:	d34ff0ef          	jal	305c <_vprintf_core.constprop.0.isra.0>
    return (int)ctx.written;
    3b2c:	5502                	lw	a0,32(sp)
}
    3b2e:	70e2                	ld	ra,56(sp)
    3b30:	6165                	addi	sp,sp,112
    3b32:	8082                	ret
        return -1;
    3b34:	557d                	li	a0,-1
    3b36:	bfe5                	j	3b2e <fprintf+0x28>

0000000000003b38 <fscanf>:
{
    3b38:	7159                	addi	sp,sp,-112
    3b3a:	fc06                	sd	ra,56(sp)
    3b3c:	e0b2                	sd	a2,64(sp)
    3b3e:	e4b6                	sd	a3,72(sp)
    3b40:	e8ba                	sd	a4,80(sp)
    3b42:	ecbe                	sd	a5,88(sp)
    3b44:	f0c2                	sd	a6,96(sp)
    3b46:	f4c6                	sd	a7,104(sp)
    if (!stream)
    3b48:	cd19                	beqz	a0,3b66 <fscanf+0x2e>
    ctx.fd = stream->fd;
    3b4a:	411c                	lw	a5,0(a0)
    va_start(ap, format);
    3b4c:	0090                	addi	a2,sp,64
    int ret = _vscanf_core(&ctx, format, ap);
    3b4e:	0808                	addi	a0,sp,16
    ctx.fd = stream->fd;
    3b50:	cc3e                	sw	a5,24(sp)
    ctx.ungotten = -1;
    3b52:	57fd                	li	a5,-1
    va_start(ap, format);
    3b54:	e432                	sd	a2,8(sp)
    ctx.buf = NULL;
    3b56:	e802                	sd	zero,16(sp)
    ctx.pos = 0;
    3b58:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    3b5a:	d43e                	sw	a5,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    3b5c:	e1dfc0ef          	jal	978 <_vscanf_core.constprop.0>
}
    3b60:	70e2                	ld	ra,56(sp)
    3b62:	6165                	addi	sp,sp,112
    3b64:	8082                	ret
        return -1;
    3b66:	557d                	li	a0,-1
    3b68:	bfe5                	j	3b60 <fscanf+0x28>

0000000000003b6a <fputc>:
    if (!stream)
    3b6a:	c1e1                	beqz	a1,3c2a <fputc+0xc0>
{
    3b6c:	7179                	addi	sp,sp,-48
    3b6e:	e84a                	sd	s2,16(sp)
    if (stream->buf_mode == 2)
    3b70:	41c5a903          	lw	s2,1052(a1)
{
    3b74:	f022                	sd	s0,32(sp)
    3b76:	ec26                	sd	s1,24(sp)
    3b78:	f406                	sd	ra,40(sp)
    if (stream->buf_mode == 2)
    3b7a:	4789                	li	a5,2
    3b7c:	842e                	mv	s0,a1
    3b7e:	84aa                	mv	s1,a0
        char ch = (char)c;
    3b80:	0ff57713          	zext.b	a4,a0
    if (stream->buf_mode == 2)
    3b84:	02f90963          	beq	s2,a5,3bb6 <fputc+0x4c>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    3b88:	4105a783          	lw	a5,1040(a1)
    if (stream->buf_write_pos >= BUFSIZ)
    3b8c:	3ff00693          	li	a3,1023
    stream->buffer[stream->buf_write_pos++] = (char)c;
    3b90:	0017861b          	addiw	a2,a5,1
    3b94:	40c5a823          	sw	a2,1040(a1)
    3b98:	97ae                	add	a5,a5,a1
    3b9a:	00e78823          	sb	a4,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    3b9e:	06c6c463          	blt	a3,a2,3c06 <fputc+0x9c>
    else if (stream->buf_mode == 1 && c == '\n')
    3ba2:	4785                	li	a5,1
    3ba4:	02f90e63          	beq	s2,a5,3be0 <fputc+0x76>
    return c;
    3ba8:	8526                	mv	a0,s1
}
    3baa:	70a2                	ld	ra,40(sp)
    3bac:	7402                	ld	s0,32(sp)
    3bae:	64e2                	ld	s1,24(sp)
    3bb0:	6942                	ld	s2,16(sp)
    3bb2:	6145                	addi	sp,sp,48
    3bb4:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    3bb6:	4188                	lw	a0,0(a1)
    3bb8:	4605                	li	a2,1
    3bba:	00f10593          	addi	a1,sp,15
        char ch = (char)c;
    3bbe:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    3bc2:	d2efc0ef          	jal	f0 <write>
    3bc6:	872a                	mv	a4,a0
    3bc8:	4785                	li	a5,1
        return c;
    3bca:	8526                	mv	a0,s1
        if (write(stream->fd, &ch, 1) != 1)
    3bcc:	fcf70fe3          	beq	a4,a5,3baa <fputc+0x40>
}
    3bd0:	70a2                	ld	ra,40(sp)
            stream->error = 1;
    3bd2:	c41c                	sw	a5,8(s0)
}
    3bd4:	7402                	ld	s0,32(sp)
    3bd6:	64e2                	ld	s1,24(sp)
    3bd8:	6942                	ld	s2,16(sp)
            return EOF;
    3bda:	557d                	li	a0,-1
}
    3bdc:	6145                	addi	sp,sp,48
    3bde:	8082                	ret
    else if (stream->buf_mode == 1 && c == '\n')
    3be0:	47a9                	li	a5,10
    3be2:	fcf513e3          	bne	a0,a5,3ba8 <fputc+0x3e>
    if (stream->buf_write_pos > 0)
    3be6:	fcc051e3          	blez	a2,3ba8 <fputc+0x3e>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3bea:	4188                	lw	a0,0(a1)
    3bec:	05c1                	addi	a1,a1,16
    3bee:	d02fc0ef          	jal	f0 <write>
        if (ret < stream->buf_write_pos)
    3bf2:	41042783          	lw	a5,1040(s0)
    3bf6:	02f55063          	bge	a0,a5,3c16 <fputc+0xac>
            stream->error = 1;
    3bfa:	01242423          	sw	s2,8(s0)
            stream->buf_write_pos = 0;
    3bfe:	40042823          	sw	zero,1040(s0)
    return c;
    3c02:	8526                	mv	a0,s1
    3c04:	b75d                	j	3baa <fputc+0x40>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3c06:	4188                	lw	a0,0(a1)
    3c08:	05c1                	addi	a1,a1,16
    3c0a:	ce6fc0ef          	jal	f0 <write>
        if (ret < stream->buf_write_pos)
    3c0e:	41042783          	lw	a5,1040(s0)
    3c12:	00f54663          	blt	a0,a5,3c1e <fputc+0xb4>
        stream->buf_write_pos = 0;
    3c16:	40042823          	sw	zero,1040(s0)
    return c;
    3c1a:	8526                	mv	a0,s1
    3c1c:	b779                	j	3baa <fputc+0x40>
            stream->error = 1;
    3c1e:	4785                	li	a5,1
    3c20:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3c22:	40042823          	sw	zero,1040(s0)
    return c;
    3c26:	8526                	mv	a0,s1
    3c28:	b749                	j	3baa <fputc+0x40>
        return EOF;
    3c2a:	557d                	li	a0,-1
}
    3c2c:	8082                	ret

0000000000003c2e <fputs>:
    if (!stream)
    3c2e:	c1ed                	beqz	a1,3d10 <fputs+0xe2>
{
    3c30:	711d                	addi	sp,sp,-96
    3c32:	e4a6                	sd	s1,72(sp)
    3c34:	ec86                	sd	ra,88(sp)
    while (*s)
    3c36:	00054703          	lbu	a4,0(a0)
    3c3a:	84aa                	mv	s1,a0
    3c3c:	cf25                	beqz	a4,3cb4 <fputs+0x86>
    3c3e:	e8a2                	sd	s0,80(sp)
    3c40:	e0ca                	sd	s2,64(sp)
    3c42:	fc4e                	sd	s3,56(sp)
    3c44:	f852                	sd	s4,48(sp)
    3c46:	f456                	sd	s5,40(sp)
    3c48:	f05a                	sd	s6,32(sp)
    3c4a:	ec5e                	sd	s7,24(sp)
    3c4c:	842e                	mv	s0,a1
    if (stream->buf_mode == 2)
    3c4e:	4909                	li	s2,2
    if (stream->buf_write_pos >= BUFSIZ)
    3c50:	3ff00b13          	li	s6,1023
    else if (stream->buf_mode == 1 && c == '\n')
    3c54:	4985                	li	s3,1
    3c56:	4a29                	li	s4,10
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3c58:	01058a93          	addi	s5,a1,16
        if (write(stream->fd, &ch, 1) != 1)
    3c5c:	00f10b93          	addi	s7,sp,15
    3c60:	a031                	j	3c6c <fputs+0x3e>
    else if (stream->buf_mode == 1 && c == '\n')
    3c62:	09368563          	beq	a3,s3,3cec <fputs+0xbe>
    while (*s)
    3c66:	0004c703          	lbu	a4,0(s1)
    3c6a:	cf15                	beqz	a4,3ca6 <fputs+0x78>
    if (stream->buf_mode == 2)
    3c6c:	41c42683          	lw	a3,1052(s0)
        if (fputc(*s++, stream) == EOF)
    3c70:	0485                	addi	s1,s1,1
    if (stream->buf_mode == 2)
    3c72:	05268663          	beq	a3,s2,3cbe <fputs+0x90>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    3c76:	41042783          	lw	a5,1040(s0)
    3c7a:	0017861b          	addiw	a2,a5,1
    3c7e:	40c42823          	sw	a2,1040(s0)
    3c82:	97a2                	add	a5,a5,s0
    3c84:	00e78823          	sb	a4,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    3c88:	fccb5de3          	bge	s6,a2,3c62 <fputs+0x34>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3c8c:	4008                	lw	a0,0(s0)
    3c8e:	85d6                	mv	a1,s5
    3c90:	c60fc0ef          	jal	f0 <write>
        if (ret < stream->buf_write_pos)
    3c94:	41042783          	lw	a5,1040(s0)
    3c98:	06f54763          	blt	a0,a5,3d06 <fputs+0xd8>
        stream->buf_write_pos = 0;
    3c9c:	40042823          	sw	zero,1040(s0)
    while (*s)
    3ca0:	0004c703          	lbu	a4,0(s1)
    3ca4:	f761                	bnez	a4,3c6c <fputs+0x3e>
    3ca6:	6446                	ld	s0,80(sp)
    3ca8:	6906                	ld	s2,64(sp)
    3caa:	79e2                	ld	s3,56(sp)
    3cac:	7a42                	ld	s4,48(sp)
    3cae:	7aa2                	ld	s5,40(sp)
    3cb0:	7b02                	ld	s6,32(sp)
    3cb2:	6be2                	ld	s7,24(sp)
}
    3cb4:	60e6                	ld	ra,88(sp)
    3cb6:	64a6                	ld	s1,72(sp)
    return 0;
    3cb8:	4501                	li	a0,0
}
    3cba:	6125                	addi	sp,sp,96
    3cbc:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    3cbe:	4008                	lw	a0,0(s0)
    3cc0:	4605                	li	a2,1
    3cc2:	85de                	mv	a1,s7
        char ch = (char)c;
    3cc4:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    3cc8:	c28fc0ef          	jal	f0 <write>
    3ccc:	f9350de3          	beq	a0,s3,3c66 <fputs+0x38>
            stream->error = 1;
    3cd0:	01342423          	sw	s3,8(s0)
}
    3cd4:	60e6                	ld	ra,88(sp)
    3cd6:	6446                	ld	s0,80(sp)
    3cd8:	6906                	ld	s2,64(sp)
    3cda:	79e2                	ld	s3,56(sp)
    3cdc:	7a42                	ld	s4,48(sp)
    3cde:	7aa2                	ld	s5,40(sp)
    3ce0:	7b02                	ld	s6,32(sp)
    3ce2:	6be2                	ld	s7,24(sp)
    3ce4:	64a6                	ld	s1,72(sp)
        return -1;
    3ce6:	557d                	li	a0,-1
}
    3ce8:	6125                	addi	sp,sp,96
    3cea:	8082                	ret
    else if (stream->buf_mode == 1 && c == '\n')
    3cec:	f7471de3          	bne	a4,s4,3c66 <fputs+0x38>
    if (stream->buf_write_pos > 0)
    3cf0:	f6c05be3          	blez	a2,3c66 <fputs+0x38>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3cf4:	4008                	lw	a0,0(s0)
    3cf6:	01040593          	addi	a1,s0,16
    3cfa:	bf6fc0ef          	jal	f0 <write>
        if (ret < stream->buf_write_pos)
    3cfe:	41042783          	lw	a5,1040(s0)
    3d02:	f8f55de3          	bge	a0,a5,3c9c <fputs+0x6e>
            stream->error = 1;
    3d06:	4785                	li	a5,1
    3d08:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3d0a:	40042823          	sw	zero,1040(s0)
            return EOF;
    3d0e:	bfa1                	j	3c66 <fputs+0x38>
        return -1;
    3d10:	557d                	li	a0,-1
}
    3d12:	8082                	ret

0000000000003d14 <fgetc>:
    if (!stream)
    3d14:	c949                	beqz	a0,3da6 <fgetc+0x92>
    if (stream->buf_write_pos > 0)
    3d16:	41052603          	lw	a2,1040(a0)
{
    3d1a:	1141                	addi	sp,sp,-16
    3d1c:	e022                	sd	s0,0(sp)
    3d1e:	e406                	sd	ra,8(sp)
    3d20:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    3d22:	04c04863          	bgtz	a2,3d72 <fgetc+0x5e>
    if (stream->buf_read_pos < stream->buf_read_cnt)
    3d26:	41442783          	lw	a5,1044(s0)
    3d2a:	41842703          	lw	a4,1048(s0)
    3d2e:	00e7dd63          	bge	a5,a4,3d48 <fgetc+0x34>
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3d32:	0017871b          	addiw	a4,a5,1
    3d36:	40e42a23          	sw	a4,1044(s0)
    3d3a:	943e                	add	s0,s0,a5
    3d3c:	01044503          	lbu	a0,16(s0)
}
    3d40:	60a2                	ld	ra,8(sp)
    3d42:	6402                	ld	s0,0(sp)
    3d44:	0141                	addi	sp,sp,16
    3d46:	8082                	ret
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3d48:	4008                	lw	a0,0(s0)
    3d4a:	40000613          	li	a2,1024
    3d4e:	01040593          	addi	a1,s0,16
    3d52:	b96fc0ef          	jal	e8 <read>
    3d56:	87aa                	mv	a5,a0
    if (ret <= 0)
    3d58:	02a05e63          	blez	a0,3d94 <fgetc+0x80>
    stream->buf_read_cnt = (int)ret;
    3d5c:	40f42c23          	sw	a5,1048(s0)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3d60:	4785                	li	a5,1
    3d62:	01044503          	lbu	a0,16(s0)
}
    3d66:	60a2                	ld	ra,8(sp)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3d68:	40f42a23          	sw	a5,1044(s0)
}
    3d6c:	6402                	ld	s0,0(sp)
    3d6e:	0141                	addi	sp,sp,16
    3d70:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3d72:	4108                	lw	a0,0(a0)
    3d74:	01040593          	addi	a1,s0,16
    3d78:	b78fc0ef          	jal	f0 <write>
        if (ret < stream->buf_write_pos)
    3d7c:	41042783          	lw	a5,1040(s0)
    3d80:	00f54563          	blt	a0,a5,3d8a <fgetc+0x76>
        stream->buf_write_pos = 0;
    3d84:	40042823          	sw	zero,1040(s0)
    3d88:	bf79                	j	3d26 <fgetc+0x12>
            stream->error = 1;
    3d8a:	4785                	li	a5,1
    3d8c:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3d8e:	40042823          	sw	zero,1040(s0)
            return EOF;
    3d92:	bf51                	j	3d26 <fgetc+0x12>
        if (ret == 0)
    3d94:	e509                	bnez	a0,3d9e <fgetc+0x8a>
            stream->eof = 1;
    3d96:	4785                	li	a5,1
    3d98:	c45c                	sw	a5,12(s0)
        return EOF;
    3d9a:	557d                	li	a0,-1
    3d9c:	b755                	j	3d40 <fgetc+0x2c>
            stream->error = 1;
    3d9e:	4785                	li	a5,1
    3da0:	c41c                	sw	a5,8(s0)
        return EOF;
    3da2:	557d                	li	a0,-1
    3da4:	bf71                	j	3d40 <fgetc+0x2c>
    3da6:	557d                	li	a0,-1
}
    3da8:	8082                	ret

0000000000003daa <fgets>:
    if (!stream || n <= 0)
    3daa:	ce5d                	beqz	a2,3e68 <fgets+0xbe>
    3dac:	0ab05e63          	blez	a1,3e68 <fgets+0xbe>
{
    3db0:	715d                	addi	sp,sp,-80
    3db2:	e0a2                	sd	s0,64(sp)
    3db4:	fc26                	sd	s1,56(sp)
    3db6:	f84a                	sd	s2,48(sp)
    3db8:	f44e                	sd	s3,40(sp)
    3dba:	f052                	sd	s4,32(sp)
    3dbc:	ec56                	sd	s5,24(sp)
    3dbe:	e85a                	sd	s6,16(sp)
    3dc0:	e45e                	sd	s7,8(sp)
    3dc2:	e486                	sd	ra,72(sp)
    3dc4:	8432                	mv	s0,a2
    3dc6:	8aaa                	mv	s5,a0
    3dc8:	892a                	mv	s2,a0
    3dca:	fff58b9b          	addiw	s7,a1,-1
    int i = 0, c;
    3dce:	4481                	li	s1,0
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3dd0:	01060993          	addi	s3,a2,16
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3dd4:	4b05                	li	s6,1
        if (c == '\n')
    3dd6:	4a29                	li	s4,10
    while (i < n - 1)
    3dd8:	05748163          	beq	s1,s7,3e1a <fgets+0x70>
    if (stream->buf_write_pos > 0)
    3ddc:	41042603          	lw	a2,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3de0:	85ce                	mv	a1,s3
    if (stream->buf_write_pos > 0)
    3de2:	06c04963          	bgtz	a2,3e54 <fgets+0xaa>
    if (stream->buf_read_pos < stream->buf_read_cnt)
    3de6:	41442783          	lw	a5,1044(s0)
    3dea:	41842703          	lw	a4,1048(s0)
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3dee:	40000613          	li	a2,1024
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3df2:	0017851b          	addiw	a0,a5,1
    3df6:	00f406b3          	add	a3,s0,a5
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3dfa:	85ce                	mv	a1,s3
    if (stream->buf_read_pos < stream->buf_read_cnt)
    3dfc:	02e7de63          	bge	a5,a4,3e38 <fgets+0x8e>
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3e00:	40a42a23          	sw	a0,1044(s0)
    3e04:	0106c783          	lbu	a5,16(a3)
    3e08:	0007871b          	sext.w	a4,a5
        str[i++] = (char)c;
    3e0c:	00f90023          	sb	a5,0(s2)
    3e10:	2485                	addiw	s1,s1,1
        if (c == '\n')
    3e12:	0905                	addi	s2,s2,1
    3e14:	fd4712e3          	bne	a4,s4,3dd8 <fgets+0x2e>
        str[i++] = (char)c;
    3e18:	8ba6                	mv	s7,s1
    str[i] = '\0';
    3e1a:	9bd6                	add	s7,s7,s5
    3e1c:	000b8023          	sb	zero,0(s7)
    return str;
    3e20:	8556                	mv	a0,s5
}
    3e22:	60a6                	ld	ra,72(sp)
    3e24:	6406                	ld	s0,64(sp)
    3e26:	74e2                	ld	s1,56(sp)
    3e28:	7942                	ld	s2,48(sp)
    3e2a:	79a2                	ld	s3,40(sp)
    3e2c:	7a02                	ld	s4,32(sp)
    3e2e:	6ae2                	ld	s5,24(sp)
    3e30:	6b42                	ld	s6,16(sp)
    3e32:	6ba2                	ld	s7,8(sp)
    3e34:	6161                	addi	sp,sp,80
    3e36:	8082                	ret
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3e38:	4008                	lw	a0,0(s0)
    3e3a:	aaefc0ef          	jal	e8 <read>
    if (ret <= 0)
    3e3e:	02a05c63          	blez	a0,3e76 <fgets+0xcc>
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3e42:	01044783          	lbu	a5,16(s0)
    stream->buf_read_cnt = (int)ret;
    3e46:	40a42c23          	sw	a0,1048(s0)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3e4a:	41642a23          	sw	s6,1044(s0)
    3e4e:	0007871b          	sext.w	a4,a5
        if (c == -1)
    3e52:	bf6d                	j	3e0c <fgets+0x62>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3e54:	4008                	lw	a0,0(s0)
    3e56:	a9afc0ef          	jal	f0 <write>
        if (ret < stream->buf_write_pos)
    3e5a:	41042783          	lw	a5,1040(s0)
    3e5e:	00f54763          	blt	a0,a5,3e6c <fgets+0xc2>
        stream->buf_write_pos = 0;
    3e62:	40042823          	sw	zero,1040(s0)
    3e66:	b741                	j	3de6 <fgets+0x3c>
        return NULL;
    3e68:	4501                	li	a0,0
}
    3e6a:	8082                	ret
            stream->error = 1;
    3e6c:	4785                	li	a5,1
    3e6e:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3e70:	40042823          	sw	zero,1040(s0)
            return EOF;
    3e74:	bf8d                	j	3de6 <fgets+0x3c>
            stream->eof = 1;
    3e76:	4785                	li	a5,1
        if (ret == 0)
    3e78:	e509                	bnez	a0,3e82 <fgets+0xd8>
            stream->eof = 1;
    3e7a:	c45c                	sw	a5,12(s0)
            if (i == 0)
    3e7c:	fcd1                	bnez	s1,3e18 <fgets+0x6e>
        return NULL;
    3e7e:	4501                	li	a0,0
    3e80:	b74d                	j	3e22 <fgets+0x78>
            stream->error = 1;
    3e82:	c41c                	sw	a5,8(s0)
        if (c == -1)
    3e84:	bfe5                	j	3e7c <fgets+0xd2>

0000000000003e86 <fread>:
{
    3e86:	715d                	addi	sp,sp,-80
    3e88:	e486                	sd	ra,72(sp)
    3e8a:	f44e                	sd	s3,40(sp)
    if (!stream || size == 0 || nmemb == 0)
    3e8c:	0e068963          	beqz	a3,3f7e <fread+0xf8>
    3e90:	ec56                	sd	s5,24(sp)
        return 0;
    3e92:	4981                	li	s3,0
    3e94:	8aae                	mv	s5,a1
    if (!stream || size == 0 || nmemb == 0)
    3e96:	c9bd                	beqz	a1,3f0c <fread+0x86>
    3e98:	ca35                	beqz	a2,3f0c <fread+0x86>
    if (stream->buf_write_pos > 0)
    3e9a:	4106a783          	lw	a5,1040(a3)
    3e9e:	e0a2                	sd	s0,64(sp)
    3ea0:	f052                	sd	s4,32(sp)
    uint64 total_bytes = size * nmemb;
    3ea2:	02c589b3          	mul	s3,a1,a2
    3ea6:	8436                	mv	s0,a3
    3ea8:	8a2a                	mv	s4,a0
    if (stream->buf_write_pos > 0)
    3eaa:	0af04d63          	bgtz	a5,3f64 <fread+0xde>
    while (bytes_read < total_bytes)
    3eae:	04098d63          	beqz	s3,3f08 <fread+0x82>
    3eb2:	fc26                	sd	s1,56(sp)
    3eb4:	e85a                	sd	s6,16(sp)
    3eb6:	e45e                	sd	s7,8(sp)
    3eb8:	f84a                	sd	s2,48(sp)
    3eba:	4481                	li	s1,0
            if (remaining >= BUFSIZ)
    3ebc:	3ff00b13          	li	s6,1023
                int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3ec0:	01040b93          	addi	s7,s0,16
        if (stream->buf_read_pos < stream->buf_read_cnt)
    3ec4:	41442703          	lw	a4,1044(s0)
    3ec8:	41842783          	lw	a5,1048(s0)
            uint64 remaining = total_bytes - bytes_read;
    3ecc:	40998633          	sub	a2,s3,s1
        if (stream->buf_read_pos < stream->buf_read_cnt)
    3ed0:	06f74463          	blt	a4,a5,3f38 <fread+0xb2>
                int64 ret = read(stream->fd, dst + bytes_read, remaining);
    3ed4:	4008                	lw	a0,0(s0)
    3ed6:	009a05b3          	add	a1,s4,s1
            if (remaining >= BUFSIZ)
    3eda:	02cb7f63          	bgeu	s6,a2,3f18 <fread+0x92>
                int64 ret = read(stream->fd, dst + bytes_read, remaining);
    3ede:	a0afc0ef          	jal	e8 <read>
                if (ret <= 0)
    3ee2:	0aa05463          	blez	a0,3f8a <fread+0x104>
                bytes_read += ret;
    3ee6:	94aa                	add	s1,s1,a0
    while (bytes_read < total_bytes)
    3ee8:	fd34eee3          	bltu	s1,s3,3ec4 <fread+0x3e>
    return bytes_read / size;
    3eec:	0354d9b3          	divu	s3,s1,s5
    3ef0:	6406                	ld	s0,64(sp)
}
    3ef2:	60a6                	ld	ra,72(sp)
    return bytes_read / size;
    3ef4:	74e2                	ld	s1,56(sp)
    3ef6:	7942                	ld	s2,48(sp)
    3ef8:	7a02                	ld	s4,32(sp)
    3efa:	6ae2                	ld	s5,24(sp)
    3efc:	6b42                	ld	s6,16(sp)
    3efe:	6ba2                	ld	s7,8(sp)
}
    3f00:	854e                	mv	a0,s3
    3f02:	79a2                	ld	s3,40(sp)
    3f04:	6161                	addi	sp,sp,80
    3f06:	8082                	ret
    3f08:	6406                	ld	s0,64(sp)
    3f0a:	7a02                	ld	s4,32(sp)
    3f0c:	60a6                	ld	ra,72(sp)
    3f0e:	6ae2                	ld	s5,24(sp)
    3f10:	854e                	mv	a0,s3
    3f12:	79a2                	ld	s3,40(sp)
    3f14:	6161                	addi	sp,sp,80
    3f16:	8082                	ret
                stream->buf_read_pos = 0;
    3f18:	40042a23          	sw	zero,1044(s0)
                stream->buf_read_cnt = 0;
    3f1c:	40042c23          	sw	zero,1048(s0)
                int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3f20:	40000613          	li	a2,1024
    3f24:	85de                	mv	a1,s7
    3f26:	9c2fc0ef          	jal	e8 <read>
                if (ret <= 0)
    3f2a:	06a05063          	blez	a0,3f8a <fread+0x104>
                stream->buf_read_cnt = (int)ret;
    3f2e:	40a42c23          	sw	a0,1048(s0)
    while (bytes_read < total_bytes)
    3f32:	f934e9e3          	bltu	s1,s3,3ec4 <fread+0x3e>
    3f36:	bf5d                	j	3eec <fread+0x66>
            uint64 available = stream->buf_read_cnt - stream->buf_read_pos;
    3f38:	40e7893b          	subw	s2,a5,a4
            memcpy(dst + bytes_read, stream->buffer + stream->buf_read_pos, to_copy);
    3f3c:	00eb85b3          	add	a1,s7,a4
    3f40:	009a0533          	add	a0,s4,s1
            uint64 to_copy = (available < remaining) ? available : remaining;
    3f44:	01267363          	bgeu	a2,s2,3f4a <fread+0xc4>
    3f48:	8932                	mv	s2,a2
            memcpy(dst + bytes_read, stream->buffer + stream->buf_read_pos, to_copy);
    3f4a:	864a                	mv	a2,s2
    3f4c:	3e1000ef          	jal	4b2c <memcpy>
            stream->buf_read_pos += to_copy;
    3f50:	41442783          	lw	a5,1044(s0)
            bytes_read += to_copy;
    3f54:	94ca                	add	s1,s1,s2
            stream->buf_read_pos += to_copy;
    3f56:	012787bb          	addw	a5,a5,s2
    3f5a:	40f42a23          	sw	a5,1044(s0)
    while (bytes_read < total_bytes)
    3f5e:	f734e3e3          	bltu	s1,s3,3ec4 <fread+0x3e>
    3f62:	b769                	j	3eec <fread+0x66>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3f64:	4288                	lw	a0,0(a3)
    3f66:	863e                	mv	a2,a5
    3f68:	01068593          	addi	a1,a3,16
    3f6c:	984fc0ef          	jal	f0 <write>
        if (ret < stream->buf_write_pos)
    3f70:	41042783          	lw	a5,1040(s0)
    3f74:	02f54163          	blt	a0,a5,3f96 <fread+0x110>
        stream->buf_write_pos = 0;
    3f78:	40042823          	sw	zero,1040(s0)
    3f7c:	bf0d                	j	3eae <fread+0x28>
}
    3f7e:	60a6                	ld	ra,72(sp)
        return 0;
    3f80:	4981                	li	s3,0
}
    3f82:	854e                	mv	a0,s3
    3f84:	79a2                	ld	s3,40(sp)
    3f86:	6161                	addi	sp,sp,80
    3f88:	8082                	ret
                        stream->eof = 1;
    3f8a:	4785                	li	a5,1
                    if (ret == 0)
    3f8c:	e119                	bnez	a0,3f92 <fread+0x10c>
                        stream->eof = 1;
    3f8e:	c45c                	sw	a5,12(s0)
    3f90:	bfb1                	j	3eec <fread+0x66>
                        stream->error = 1;
    3f92:	c41c                	sw	a5,8(s0)
                    return bytes_read / size;
    3f94:	bfa1                	j	3eec <fread+0x66>
            stream->error = 1;
    3f96:	4785                	li	a5,1
    3f98:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3f9a:	40042823          	sw	zero,1040(s0)
            return EOF;
    3f9e:	bf01                	j	3eae <fread+0x28>

0000000000003fa0 <fwrite>:
{
    3fa0:	711d                	addi	sp,sp,-96
    3fa2:	ec86                	sd	ra,88(sp)
    3fa4:	e0ca                	sd	s2,64(sp)
    if (!stream || !ptr || size == 0 || nmemb == 0)
    3fa6:	10068063          	beqz	a3,40a6 <fwrite+0x106>
    3faa:	f456                	sd	s5,40(sp)
    3fac:	8aaa                	mv	s5,a0
    3fae:	10050263          	beqz	a0,40b2 <fwrite+0x112>
    3fb2:	f05a                	sd	s6,32(sp)
        return 0;
    3fb4:	4901                	li	s2,0
    3fb6:	8b2e                	mv	s6,a1
    if (!stream || !ptr || size == 0 || nmemb == 0)
    3fb8:	c1d9                	beqz	a1,403e <fwrite+0x9e>
    3fba:	c251                	beqz	a2,403e <fwrite+0x9e>
    if (stream->buf_mode == 2)
    3fbc:	41c6a703          	lw	a4,1052(a3)
    3fc0:	e8a2                	sd	s0,80(sp)
    3fc2:	4789                	li	a5,2
    uint64 total_bytes = size * nmemb;
    3fc4:	02c58933          	mul	s2,a1,a2
    if (stream->buf_mode == 2)
    3fc8:	8436                	mv	s0,a3
    3fca:	0ef70b63          	beq	a4,a5,40c0 <fwrite+0x120>
    3fce:	fc4e                	sd	s3,56(sp)
    3fd0:	ec5e                	sd	s7,24(sp)
    3fd2:	e862                	sd	s8,16(sp)
    uint64 bytes_written = 0;
    3fd4:	4981                	li	s3,0
    3fd6:	01068b93          	addi	s7,a3,16
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    3fda:	40000c13          	li	s8,1024
    while (bytes_written < total_bytes)
    3fde:	12090263          	beqz	s2,4102 <fwrite+0x162>
    3fe2:	e4a6                	sd	s1,72(sp)
    3fe4:	f852                	sd	s4,48(sp)
    3fe6:	e466                	sd	s9,8(sp)
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    3fe8:	41042783          	lw	a5,1040(s0)
        uint64 remaining = total_bytes - bytes_written;
    3fec:	41390cb3          	sub	s9,s2,s3
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, remaining);
    3ff0:	013a85b3          	add	a1,s5,s3
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    3ff4:	40fc0a3b          	subw	s4,s8,a5
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, space_left);
    3ff8:	00fb8533          	add	a0,s7,a5
    3ffc:	8652                	mv	a2,s4
        if (remaining <= space_left)
    3ffe:	059a6763          	bltu	s4,s9,404c <fwrite+0xac>
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, remaining);
    4002:	8666                	mv	a2,s9
    4004:	329000ef          	jal	4b2c <memcpy>
            stream->buf_write_pos += remaining;
    4008:	41042783          	lw	a5,1040(s0)
            if (stream->buf_write_pos == BUFSIZ)
    400c:	40000713          	li	a4,1024
            stream->buf_write_pos += remaining;
    4010:	019786bb          	addw	a3,a5,s9
    4014:	40d42823          	sw	a3,1040(s0)
            if (stream->buf_write_pos == BUFSIZ)
    4018:	06e68a63          	beq	a3,a4,408c <fwrite+0xec>
    return bytes_written / size;
    401c:	03695933          	divu	s2,s2,s6
    4020:	6446                	ld	s0,80(sp)
    4022:	64a6                	ld	s1,72(sp)
    4024:	79e2                	ld	s3,56(sp)
    4026:	7a42                	ld	s4,48(sp)
    4028:	7aa2                	ld	s5,40(sp)
    402a:	7b02                	ld	s6,32(sp)
    402c:	6be2                	ld	s7,24(sp)
    402e:	6c42                	ld	s8,16(sp)
    4030:	6ca2                	ld	s9,8(sp)
}
    4032:	60e6                	ld	ra,88(sp)
    4034:	854a                	mv	a0,s2
    4036:	6906                	ld	s2,64(sp)
    4038:	6125                	addi	sp,sp,96
    403a:	8082                	ret
    403c:	6446                	ld	s0,80(sp)
    403e:	60e6                	ld	ra,88(sp)
    4040:	7aa2                	ld	s5,40(sp)
    4042:	7b02                	ld	s6,32(sp)
    4044:	854a                	mv	a0,s2
    4046:	6906                	ld	s2,64(sp)
    4048:	6125                	addi	sp,sp,96
    404a:	8082                	ret
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, space_left);
    404c:	2e1000ef          	jal	4b2c <memcpy>
            stream->buf_write_pos += space_left;
    4050:	41042783          	lw	a5,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4054:	85de                	mv	a1,s7
            bytes_written += space_left;
    4056:	99d2                	add	s3,s3,s4
            stream->buf_write_pos += space_left;
    4058:	00fa04bb          	addw	s1,s4,a5
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    405c:	02049613          	slli	a2,s1,0x20
            stream->buf_write_pos += space_left;
    4060:	40942823          	sw	s1,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4064:	9201                	srli	a2,a2,0x20
    if (stream->buf_write_pos > 0)
    4066:	00904763          	bgtz	s1,4074 <fwrite+0xd4>
    while (bytes_written < total_bytes)
    406a:	f729efe3          	bltu	s3,s2,3fe8 <fwrite+0x48>
    return bytes_written / size;
    406e:	0369d933          	divu	s2,s3,s6
    4072:	b77d                	j	4020 <fwrite+0x80>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4074:	4008                	lw	a0,0(s0)
    4076:	87afc0ef          	jal	f0 <write>
        if (ret < stream->buf_write_pos)
    407a:	41042783          	lw	a5,1040(s0)
    407e:	08f54963          	blt	a0,a5,4110 <fwrite+0x170>
        stream->buf_write_pos = 0;
    4082:	40042823          	sw	zero,1040(s0)
    while (bytes_written < total_bytes)
    4086:	f729e1e3          	bltu	s3,s2,3fe8 <fwrite+0x48>
    408a:	b7d5                	j	406e <fwrite+0xce>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    408c:	4008                	lw	a0,0(s0)
    408e:	40000613          	li	a2,1024
    4092:	85de                	mv	a1,s7
    4094:	85cfc0ef          	jal	f0 <write>
        if (ret < stream->buf_write_pos)
    4098:	41042783          	lw	a5,1040(s0)
    409c:	08f54163          	blt	a0,a5,411e <fwrite+0x17e>
        stream->buf_write_pos = 0;
    40a0:	40042823          	sw	zero,1040(s0)
    40a4:	bfa5                	j	401c <fwrite+0x7c>
}
    40a6:	60e6                	ld	ra,88(sp)
        return 0;
    40a8:	4901                	li	s2,0
}
    40aa:	854a                	mv	a0,s2
    40ac:	6906                	ld	s2,64(sp)
    40ae:	6125                	addi	sp,sp,96
    40b0:	8082                	ret
    40b2:	60e6                	ld	ra,88(sp)
        return 0;
    40b4:	4901                	li	s2,0
    40b6:	7aa2                	ld	s5,40(sp)
}
    40b8:	854a                	mv	a0,s2
    40ba:	6906                	ld	s2,64(sp)
    40bc:	6125                	addi	sp,sp,96
    40be:	8082                	ret
        while (bytes_written < total_bytes)
    40c0:	f6090ee3          	beqz	s2,403c <fwrite+0x9c>
    40c4:	e4a6                	sd	s1,72(sp)
    uint64 bytes_written = 0;
    40c6:	4481                	li	s1,0
    40c8:	a021                	j	40d0 <fwrite+0x130>
            bytes_written += ret;
    40ca:	94aa                	add	s1,s1,a0
        while (bytes_written < total_bytes)
    40cc:	0324f463          	bgeu	s1,s2,40f4 <fwrite+0x154>
            int64 ret = write(stream->fd, src + bytes_written, total_bytes - bytes_written);
    40d0:	4008                	lw	a0,0(s0)
    40d2:	40990633          	sub	a2,s2,s1
    40d6:	009a85b3          	add	a1,s5,s1
    40da:	816fc0ef          	jal	f0 <write>
            if (ret <= 0)
    40de:	fea046e3          	bgtz	a0,40ca <fwrite+0x12a>
                stream->error = 1;
    40e2:	4785                	li	a5,1
        return bytes_written / size;
    40e4:	0364d933          	divu	s2,s1,s6
                stream->error = 1;
    40e8:	c41c                	sw	a5,8(s0)
                break;
    40ea:	64a6                	ld	s1,72(sp)
    40ec:	6446                	ld	s0,80(sp)
    40ee:	7aa2                	ld	s5,40(sp)
    40f0:	7b02                	ld	s6,32(sp)
    40f2:	b781                	j	4032 <fwrite+0x92>
        return bytes_written / size;
    40f4:	0364d933          	divu	s2,s1,s6
    40f8:	6446                	ld	s0,80(sp)
    40fa:	64a6                	ld	s1,72(sp)
    40fc:	7aa2                	ld	s5,40(sp)
    40fe:	7b02                	ld	s6,32(sp)
    4100:	bf0d                	j	4032 <fwrite+0x92>
    4102:	6446                	ld	s0,80(sp)
    4104:	79e2                	ld	s3,56(sp)
    4106:	7aa2                	ld	s5,40(sp)
    4108:	7b02                	ld	s6,32(sp)
    410a:	6be2                	ld	s7,24(sp)
    410c:	6c42                	ld	s8,16(sp)
    410e:	b715                	j	4032 <fwrite+0x92>
            stream->error = 1;
    4110:	4785                	li	a5,1
    4112:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4114:	40042823          	sw	zero,1040(s0)
    while (bytes_written < total_bytes)
    4118:	ed29e8e3          	bltu	s3,s2,3fe8 <fwrite+0x48>
    411c:	bf89                	j	406e <fwrite+0xce>
            stream->error = 1;
    411e:	4785                	li	a5,1
    4120:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4122:	40042823          	sw	zero,1040(s0)
            return EOF;
    4126:	bddd                	j	401c <fwrite+0x7c>

0000000000004128 <fseek>:
    if (!stream)
    4128:	c925                	beqz	a0,4198 <fseek+0x70>
{
    412a:	1101                	addi	sp,sp,-32
    412c:	e04a                	sd	s2,0(sp)
    412e:	8932                	mv	s2,a2
    if (stream->buf_write_pos > 0)
    4130:	41052603          	lw	a2,1040(a0)
{
    4134:	e822                	sd	s0,16(sp)
    4136:	e426                	sd	s1,8(sp)
    4138:	ec06                	sd	ra,24(sp)
    413a:	842a                	mv	s0,a0
    413c:	84ae                	mv	s1,a1
    if (stream->buf_write_pos > 0)
    413e:	02c04863          	bgtz	a2,416e <fseek+0x46>
    if (lseek(stream->fd, offset, whence) < 0)
    4142:	4008                	lw	a0,0(s0)
    stream->buf_read_pos = 0;
    4144:	40042a23          	sw	zero,1044(s0)
    stream->buf_read_cnt = 0;
    4148:	40042c23          	sw	zero,1048(s0)
    stream->eof = 0;
    414c:	00042623          	sw	zero,12(s0)
    if (lseek(stream->fd, offset, whence) < 0)
    4150:	864a                	mv	a2,s2
    4152:	0004859b          	sext.w	a1,s1
    4156:	82afc0ef          	jal	180 <lseek>
    415a:	87aa                	mv	a5,a0
    return 0;
    415c:	4501                	li	a0,0
    if (lseek(stream->fd, offset, whence) < 0)
    415e:	0207c463          	bltz	a5,4186 <fseek+0x5e>
}
    4162:	60e2                	ld	ra,24(sp)
    4164:	6442                	ld	s0,16(sp)
    4166:	64a2                	ld	s1,8(sp)
    4168:	6902                	ld	s2,0(sp)
    416a:	6105                	addi	sp,sp,32
    416c:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    416e:	4108                	lw	a0,0(a0)
    4170:	01040593          	addi	a1,s0,16
    4174:	f7dfb0ef          	jal	f0 <write>
        if (ret < stream->buf_write_pos)
    4178:	41042783          	lw	a5,1040(s0)
    417c:	00f54963          	blt	a0,a5,418e <fseek+0x66>
        stream->buf_write_pos = 0;
    4180:	40042823          	sw	zero,1040(s0)
    4184:	bf7d                	j	4142 <fseek+0x1a>
        stream->error = 1;
    4186:	4785                	li	a5,1
    4188:	c41c                	sw	a5,8(s0)
        return -1;
    418a:	557d                	li	a0,-1
    418c:	bfd9                	j	4162 <fseek+0x3a>
            stream->error = 1;
    418e:	4785                	li	a5,1
    4190:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4192:	40042823          	sw	zero,1040(s0)
            return EOF;
    4196:	b775                	j	4142 <fseek+0x1a>
        return -1;
    4198:	557d                	li	a0,-1
}
    419a:	8082                	ret

000000000000419c <ftell>:
    if (!stream)
    419c:	c505                	beqz	a0,41c4 <ftell+0x28>
{
    419e:	1141                	addi	sp,sp,-16
    41a0:	e022                	sd	s0,0(sp)
    41a2:	842a                	mv	s0,a0
    int64 ret = lseek(stream->fd, 0, SEEK_CUR);
    41a4:	4108                	lw	a0,0(a0)
    41a6:	4605                	li	a2,1
    41a8:	4581                	li	a1,0
{
    41aa:	e406                	sd	ra,8(sp)
    int64 ret = lseek(stream->fd, 0, SEEK_CUR);
    41ac:	fd5fb0ef          	jal	180 <lseek>
    if (ret < 0)
    41b0:	00054663          	bltz	a0,41bc <ftell+0x20>
}
    41b4:	60a2                	ld	ra,8(sp)
    41b6:	6402                	ld	s0,0(sp)
    41b8:	0141                	addi	sp,sp,16
    41ba:	8082                	ret
        stream->error = 1;
    41bc:	4785                	li	a5,1
    41be:	c41c                	sw	a5,8(s0)
        return -1L;
    41c0:	557d                	li	a0,-1
    41c2:	bfcd                	j	41b4 <ftell+0x18>
    41c4:	557d                	li	a0,-1
}
    41c6:	8082                	ret

00000000000041c8 <rewind>:
    if (stream)
    41c8:	c915                	beqz	a0,41fc <rewind+0x34>
    if (stream->buf_write_pos > 0)
    41ca:	41052603          	lw	a2,1040(a0)
{
    41ce:	1141                	addi	sp,sp,-16
    41d0:	e022                	sd	s0,0(sp)
    41d2:	e406                	sd	ra,8(sp)
    41d4:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    41d6:	02c04463          	bgtz	a2,41fe <rewind+0x36>
    if (lseek(stream->fd, offset, whence) < 0)
    41da:	4008                	lw	a0,0(s0)
    stream->buf_read_pos = 0;
    41dc:	40042a23          	sw	zero,1044(s0)
    stream->buf_read_cnt = 0;
    41e0:	40042c23          	sw	zero,1048(s0)
    stream->eof = 0;
    41e4:	00042623          	sw	zero,12(s0)
    if (lseek(stream->fd, offset, whence) < 0)
    41e8:	4601                	li	a2,0
    41ea:	4581                	li	a1,0
    41ec:	f95fb0ef          	jal	180 <lseek>
}
    41f0:	60a2                	ld	ra,8(sp)
        stream->error = 0;
    41f2:	00042423          	sw	zero,8(s0)
}
    41f6:	6402                	ld	s0,0(sp)
    41f8:	0141                	addi	sp,sp,16
    41fa:	8082                	ret
    41fc:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    41fe:	4108                	lw	a0,0(a0)
    4200:	01040593          	addi	a1,s0,16
    4204:	eedfb0ef          	jal	f0 <write>
        if (ret < stream->buf_write_pos)
    4208:	41042783          	lw	a5,1040(s0)
    420c:	00f54563          	blt	a0,a5,4216 <rewind+0x4e>
        stream->buf_write_pos = 0;
    4210:	40042823          	sw	zero,1040(s0)
    4214:	b7d9                	j	41da <rewind+0x12>
            stream->error = 1;
    4216:	4785                	li	a5,1
    4218:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    421a:	40042823          	sw	zero,1040(s0)
            return EOF;
    421e:	bf75                	j	41da <rewind+0x12>

0000000000004220 <feof>:
    return (stream) ? stream->eof : 1;
    4220:	c119                	beqz	a0,4226 <feof+0x6>
    4222:	4548                	lw	a0,12(a0)
    4224:	8082                	ret
    4226:	4505                	li	a0,1
}
    4228:	8082                	ret

000000000000422a <ferror>:
     return (stream) ? stream->error : 1;
    422a:	c119                	beqz	a0,4230 <ferror+0x6>
    422c:	4508                	lw	a0,8(a0)
    422e:	8082                	ret
    4230:	4505                	li	a0,1
}
    4232:	8082                	ret

0000000000004234 <clearerr>:
    if (stream)
    4234:	c509                	beqz	a0,423e <clearerr+0xa>
        stream->error = 0;
    4236:	00052423          	sw	zero,8(a0)
        stream->eof = 0;
    423a:	00052623          	sw	zero,12(a0)
}
    423e:	8082                	ret

0000000000004240 <ungetc>:
    if (!stream || c == EOF)
    4240:	c19d                	beqz	a1,4266 <ungetc+0x26>
    4242:	57fd                	li	a5,-1
    4244:	02f50163          	beq	a0,a5,4266 <ungetc+0x26>
    if (stream->buf_read_pos > 0)
    4248:	4145a783          	lw	a5,1044(a1)
    424c:	00f05d63          	blez	a5,4266 <ungetc+0x26>
        stream->buf_read_pos--;
    4250:	fff7871b          	addiw	a4,a5,-1
    4254:	40e5aa23          	sw	a4,1044(a1)
        stream->buffer[stream->buf_read_pos] = (char)c;
    4258:	00e587b3          	add	a5,a1,a4
    425c:	00a78823          	sb	a0,16(a5)
        stream->eof = 0;
    4260:	0005a623          	sw	zero,12(a1)
        return c;
    4264:	8082                	ret
        return EOF;
    4266:	557d                	li	a0,-1
    4268:	8082                	ret

000000000000426a <strtoull.part.0>:
    return new_ptr;
}

/* String Conversion*/

unsigned long long strtoull(const char *nptr, char **endptr, int base)
    426a:	1141                	addi	sp,sp,-16
    426c:	e422                	sd	s0,8(sp)
    426e:	8eaa                	mv	t4,a0
{
    const char *s = nptr;
    4270:	88aa                	mv	a7,a0
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    static inline int islower(int c) { return c >= 'a' && c <= 'z'; }
    static inline int isupper(int c) { return c >= 'A' && c <= 'Z'; }
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    static inline int isalnum(int c) { return isalpha(c) || isdigit(c); }
    static inline int isspace(int c) { return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r'; }
    4272:	02000313          	li	t1,32
    4276:	4e11                	li	t3,4
        return 0;
    }

    do
    {
        c = *s++;
    4278:	0008c783          	lbu	a5,0(a7)
    427c:	00188813          	addi	a6,a7,1
    4280:	ff77871b          	addiw	a4,a5,-9
    4284:	0ff77693          	zext.b	a3,a4
    4288:	0007871b          	sext.w	a4,a5
    428c:	04678363          	beq	a5,t1,42d2 <strtoull.part.0+0x68>
    4290:	04de7163          	bgeu	t3,a3,42d2 <strtoull.part.0+0x68>
    } while (isspace(c));

    if (c == '-')
    4294:	02d00793          	li	a5,45
    4298:	0ef70863          	beq	a4,a5,4388 <strtoull.part.0+0x11e>
    {
        neg = 1;
        c = *s++;
    }
    else if (c == '+')
    429c:	02b00793          	li	a5,43
    int neg = 0, any, cutlim;
    42a0:	4381                	li	t2,0
    else if (c == '+')
    42a2:	08f70c63          	beq	a4,a5,433a <strtoull.part.0+0xd0>
    {
        c = *s++;
    }

    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    42a6:	ea05                	bnez	a2,42d6 <strtoull.part.0+0x6c>
    42a8:	03000793          	li	a5,48
    42ac:	0ef70463          	beq	a4,a5,4394 <strtoull.part.0+0x12a>
    42b0:	00ccd8b7          	lui	a7,0xccd
    42b4:	ccd88893          	addi	a7,a7,-819 # cccccd <_ZSt4cerr+0xcc5445>
    42b8:	08b2                	slli	a7,a7,0xc
    42ba:	ccd88893          	addi	a7,a7,-819
    42be:	08b2                	slli	a7,a7,0xc
    42c0:	ccd88893          	addi	a7,a7,-819
    42c4:	08b6                	slli	a7,a7,0xd
    42c6:	4415                	li	s0,5
    42c8:	99988893          	addi	a7,a7,-1639
    42cc:	42a9                	li	t0,10
        c = s[1];
        s += 2;
        base = 16;
    }
    if (base == 0)
        base = (c == '0' ? 8 : 10);
    42ce:	4629                	li	a2,10
    42d0:	a829                	j	42ea <strtoull.part.0+0x80>
unsigned long long strtoull(const char *nptr, char **endptr, int base)
    42d2:	88c2                	mv	a7,a6
    42d4:	b755                	j	4278 <strtoull.part.0+0xe>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    42d6:	47c1                	li	a5,16
    42d8:	0cf60d63          	beq	a2,a5,43b2 <strtoull.part.0+0x148>

    cutoff = ULLONG_MAX / (unsigned long long)base;
    42dc:	58fd                	li	a7,-1
    cutlim = ULLONG_MAX % (unsigned long long)base;
    42de:	02c8f433          	remu	s0,a7,a2
    cutoff = ULLONG_MAX / (unsigned long long)base;
    42e2:	82b2                	mv	t0,a2
    42e4:	02c8d8b3          	divu	a7,a7,a2
    cutlim = ULLONG_MAX % (unsigned long long)base;
    42e8:	2401                	sext.w	s0,s0

    for (acc = 0, any = 0;; c = *s++)
    42ea:	4301                	li	t1,0
    42ec:	4501                	li	a0,0
    {
        if (isdigit(c))
    42ee:	4e25                	li	t3,9
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    42f0:	4fe5                	li	t6,25
            break;

        if (c >= base)
            break;

        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    42f2:	5f7d                	li	t5,-1
        if (isdigit(c))
    42f4:	fd07079b          	addiw	a5,a4,-48
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    42f8:	0007069b          	sext.w	a3,a4
    42fc:	00fe7e63          	bgeu	t3,a5,4318 <strtoull.part.0+0xae>
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    4300:	f9f6879b          	addiw	a5,a3,-97
    4304:	04fff063          	bgeu	t6,a5,4344 <strtoull.part.0+0xda>
    4308:	fbf6869b          	addiw	a3,a3,-65
    430c:	04dfe163          	bltu	t6,a3,434e <strtoull.part.0+0xe4>
            c -= isupper(c) ? 'A' - 10 : 'a' - 10;
    4310:	03700793          	li	a5,55
    4314:	40f707bb          	subw	a5,a4,a5
        if (c >= base)
    4318:	02c7db63          	bge	a5,a2,434e <strtoull.part.0+0xe4>
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    431c:	01e30b63          	beq	t1,t5,4332 <strtoull.part.0+0xc8>
            any = -1;
    4320:	537d                	li	t1,-1
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    4322:	00a8e863          	bltu	a7,a0,4332 <strtoull.part.0+0xc8>
    4326:	05150e63          	beq	a0,a7,4382 <strtoull.part.0+0x118>
        else
        {
            any = 1;
    432a:	4305                	li	t1,1
            acc *= base;
    432c:	02550533          	mul	a0,a0,t0
            acc += c;
    4330:	953e                	add	a0,a0,a5
    for (acc = 0, any = 0;; c = *s++)
    4332:	0805                	addi	a6,a6,1
    4334:	fff84703          	lbu	a4,-1(a6)
        if (isdigit(c))
    4338:	bf75                	j	42f4 <strtoull.part.0+0x8a>
        c = *s++;
    433a:	00084703          	lbu	a4,0(a6)
    433e:	00288813          	addi	a6,a7,2
    4342:	b795                	j	42a6 <strtoull.part.0+0x3c>
            c -= isupper(c) ? 'A' - 10 : 'a' - 10;
    4344:	05700793          	li	a5,87
    4348:	40f707bb          	subw	a5,a4,a5
    434c:	b7f1                	j	4318 <strtoull.part.0+0xae>
        }
    }

    if (any < 0)
    434e:	57fd                	li	a5,-1
    4350:	00f30e63          	beq	t1,a5,436c <strtoull.part.0+0x102>
    {
        acc = ULLONG_MAX;
        errno = ERANGE;
    }
    else if (neg)
    4354:	00038463          	beqz	t2,435c <strtoull.part.0+0xf2>
        acc = -acc;
    4358:	40a00533          	neg	a0,a0

    if (endptr != 0)
    435c:	c589                	beqz	a1,4366 <strtoull.part.0+0xfc>
        *endptr = (char *)(any ? s - 1 : nptr);
    435e:	00031f63          	bnez	t1,437c <strtoull.part.0+0x112>
    4362:	01d5b023          	sd	t4,0(a1)

    return acc;
}
    4366:	6422                	ld	s0,8(sp)
    4368:	0141                	addi	sp,sp,16
    436a:	8082                	ret
        errno = ERANGE;
    436c:	02200793          	li	a5,34
    4370:	00003717          	auipc	a4,0x3
    4374:	3ef72023          	sw	a5,992(a4) # 7750 <errno>
        acc = ULLONG_MAX;
    4378:	557d                	li	a0,-1
    if (endptr != 0)
    437a:	d5f5                	beqz	a1,4366 <strtoull.part.0+0xfc>
        *endptr = (char *)(any ? s - 1 : nptr);
    437c:	fff80e93          	addi	t4,a6,-1
    4380:	b7cd                	j	4362 <strtoull.part.0+0xf8>
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    4382:	faf448e3          	blt	s0,a5,4332 <strtoull.part.0+0xc8>
    4386:	b755                	j	432a <strtoull.part.0+0xc0>
        c = *s++;
    4388:	00084703          	lbu	a4,0(a6)
        neg = 1;
    438c:	4385                	li	t2,1
        c = *s++;
    438e:	00288813          	addi	a6,a7,2
    4392:	bf11                	j	42a6 <strtoull.part.0+0x3c>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    4394:	00084783          	lbu	a5,0(a6)
    4398:	05800693          	li	a3,88
    439c:	0df7f793          	andi	a5,a5,223
    43a0:	02d78b63          	beq	a5,a3,43d6 <strtoull.part.0+0x16c>
    43a4:	58fd                	li	a7,-1
    43a6:	441d                	li	s0,7
    43a8:	0038d893          	srli	a7,a7,0x3
    43ac:	42a1                	li	t0,8
        base = (c == '0' ? 8 : 10);
    43ae:	4621                	li	a2,8
    43b0:	bf2d                	j	42ea <strtoull.part.0+0x80>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    43b2:	03000793          	li	a5,48
    43b6:	00f70863          	beq	a4,a5,43c6 <strtoull.part.0+0x15c>
    43ba:	58fd                	li	a7,-1
    43bc:	443d                	li	s0,15
    43be:	0048d893          	srli	a7,a7,0x4
    43c2:	42c1                	li	t0,16
    43c4:	b71d                	j	42ea <strtoull.part.0+0x80>
    43c6:	00084783          	lbu	a5,0(a6)
    43ca:	05800693          	li	a3,88
    43ce:	0df7f793          	andi	a5,a5,223
    43d2:	fed794e3          	bne	a5,a3,43ba <strtoull.part.0+0x150>
        s += 2;
    43d6:	58fd                	li	a7,-1
        c = s[1];
    43d8:	00184703          	lbu	a4,1(a6)
        s += 2;
    43dc:	443d                	li	s0,15
    43de:	0809                	addi	a6,a6,2
    43e0:	0048d893          	srli	a7,a7,0x4
    43e4:	42c1                	li	t0,16
        base = 16;
    43e6:	4641                	li	a2,16
    43e8:	b709                	j	42ea <strtoull.part.0+0x80>

00000000000043ea <atexit>:
    if (__atexit_func_count >= ATEXIT_MAX)
    43ea:	00003717          	auipc	a4,0x3
    43ee:	36670713          	addi	a4,a4,870 # 7750 <errno>
    43f2:	435c                	lw	a5,4(a4)
    43f4:	46fd                	li	a3,31
    43f6:	00f6ca63          	blt	a3,a5,440a <atexit+0x20>
    __atexit_funcs[__atexit_func_count++] = function;
    43fa:	00379693          	slli	a3,a5,0x3
    43fe:	96ba                	add	a3,a3,a4
    4400:	2785                	addiw	a5,a5,1
    4402:	e688                	sd	a0,8(a3)
    4404:	c35c                	sw	a5,4(a4)
    return 0;
    4406:	4501                	li	a0,0
    4408:	8082                	ret
        return -1;
    440a:	557d                	li	a0,-1
}
    440c:	8082                	ret

000000000000440e <exit>:
{
    440e:	1101                	addi	sp,sp,-32
    4410:	e822                	sd	s0,16(sp)
    while (__atexit_func_count > 0)
    4412:	00003417          	auipc	s0,0x3
    4416:	33e40413          	addi	s0,s0,830 # 7750 <errno>
    441a:	405c                	lw	a5,4(s0)
{
    441c:	e426                	sd	s1,8(sp)
    441e:	ec06                	sd	ra,24(sp)
    4420:	84aa                	mv	s1,a0
    while (__atexit_func_count > 0)
    4422:	00f05d63          	blez	a5,443c <exit+0x2e>
        (__atexit_funcs[--__atexit_func_count])();
    4426:	fff7871b          	addiw	a4,a5,-1
    442a:	87ba                	mv	a5,a4
    442c:	070e                	slli	a4,a4,0x3
    442e:	9722                	add	a4,a4,s0
    4430:	6718                	ld	a4,8(a4)
    4432:	c05c                	sw	a5,4(s0)
    4434:	9702                	jalr	a4
    while (__atexit_func_count > 0)
    4436:	405c                	lw	a5,4(s0)
    4438:	fef047e3          	bgtz	a5,4426 <exit+0x18>
    sys_exit(status);
    443c:	8526                	mv	a0,s1
    443e:	c8bfb0ef          	jal	c8 <sys_exit>
    while (1)
    4442:	a001                	j	4442 <exit+0x34>

0000000000004444 <abort>:
{
    4444:	1141                	addi	sp,sp,-16
    exit(127);
    4446:	07f00513          	li	a0,127
{
    444a:	e406                	sd	ra,8(sp)
    exit(127);
    444c:	fc3ff0ef          	jal	440e <exit>

0000000000004450 <getenv>:
}
    4450:	4501                	li	a0,0
    4452:	8082                	ret

0000000000004454 <system>:
}
    4454:	557d                	li	a0,-1
    4456:	8082                	ret

0000000000004458 <free>:
    if (!ptr)
    4458:	c121                	beqz	a0,4498 <free+0x40>
    for (p = freep; !(bp > p && bp < p->next); p = p->next)
    445a:	00003617          	auipc	a2,0x3
    445e:	2f660613          	addi	a2,a2,758 # 7750 <errno>
    4462:	10863783          	ld	a5,264(a2)
    bp = (header_t *)ptr - 1;
    4466:	ff050693          	addi	a3,a0,-16
        if (p >= p->next && (bp > p || bp < p->next))
    446a:	6798                	ld	a4,8(a5)
    for (p = freep; !(bp > p && bp < p->next); p = p->next)
    446c:	02d7f763          	bgeu	a5,a3,449a <free+0x42>
    4470:	00e6e463          	bltu	a3,a4,4478 <free+0x20>
        if (p >= p->next && (bp > p || bp < p->next))
    4474:	02e7e763          	bltu	a5,a4,44a2 <free+0x4a>
    if ((char *)bp + bp->size == (char *)p->next)
    4478:	ff053583          	ld	a1,-16(a0)
    447c:	00b68833          	add	a6,a3,a1
    4480:	03070363          	beq	a4,a6,44a6 <free+0x4e>
    if ((char *)p + p->size == (char *)bp)
    4484:	638c                	ld	a1,0(a5)
    4486:	fee53c23          	sd	a4,-8(a0)
    448a:	00b78833          	add	a6,a5,a1
    448e:	03068963          	beq	a3,a6,44c0 <free+0x68>
    4492:	e794                	sd	a3,8(a5)
    freep = p;
    4494:	10f63423          	sd	a5,264(a2)
}
    4498:	8082                	ret
        if (p >= p->next && (bp > p || bp < p->next))
    449a:	00e7e463          	bltu	a5,a4,44a2 <free+0x4a>
    449e:	fce6ede3          	bltu	a3,a4,4478 <free+0x20>
{
    44a2:	87ba                	mv	a5,a4
    44a4:	b7d9                	j	446a <free+0x12>
        bp->size += p->next->size;
    44a6:	00073803          	ld	a6,0(a4)
        bp->next = p->next->next;
    44aa:	6718                	ld	a4,8(a4)
        bp->size += p->next->size;
    44ac:	95c2                	add	a1,a1,a6
    44ae:	feb53823          	sd	a1,-16(a0)
    if ((char *)p + p->size == (char *)bp)
    44b2:	638c                	ld	a1,0(a5)
    44b4:	fee53c23          	sd	a4,-8(a0)
    44b8:	00b78833          	add	a6,a5,a1
    44bc:	fd069be3          	bne	a3,a6,4492 <free+0x3a>
        p->size += bp->size;
    44c0:	ff053503          	ld	a0,-16(a0)
        p->next = bp->next;
    44c4:	86ba                	mv	a3,a4
        p->size += bp->size;
    44c6:	00b50733          	add	a4,a0,a1
    44ca:	e398                	sd	a4,0(a5)
        p->next = bp->next;
    44cc:	b7d9                	j	4492 <free+0x3a>

00000000000044ce <malloc>:
    if (size == 0)
    44ce:	c169                	beqz	a0,4590 <malloc+0xc2>
{
    44d0:	7179                	addi	sp,sp,-48
    44d2:	ec26                	sd	s1,24(sp)
    if ((prevp = freep) == NULL)
    44d4:	00003497          	auipc	s1,0x3
    44d8:	27c48493          	addi	s1,s1,636 # 7750 <errno>
    44dc:	1084b783          	ld	a5,264(s1)
{
    44e0:	f022                	sd	s0,32(sp)
    size = ALIGN(size + sizeof(header_t));
    44e2:	057d                	addi	a0,a0,31
{
    44e4:	f406                	sd	ra,40(sp)
    size = ALIGN(size + sizeof(header_t));
    44e6:	ff057413          	andi	s0,a0,-16
    if ((prevp = freep) == NULL)
    44ea:	c3d1                	beqz	a5,456e <malloc+0xa0>
    for (p = prevp->next;; prevp = p, p = p->next)
    44ec:	6788                	ld	a0,8(a5)
        if (p->size >= size)
    44ee:	6118                	ld	a4,0(a0)
    44f0:	06877163          	bgeu	a4,s0,4552 <malloc+0x84>
    44f4:	e44e                	sd	s3,8(sp)
    44f6:	e052                	sd	s4,0(sp)
    44f8:	e84a                	sd	s2,16(sp)
    if (nu < 4096)
    44fa:	6a05                	lui	s4,0x1
    if (cp == (void *)-1)
    44fc:	59fd                	li	s3,-1
    44fe:	a029                	j	4508 <malloc+0x3a>
    for (p = prevp->next;; prevp = p, p = p->next)
    4500:	6788                	ld	a0,8(a5)
        if (p->size >= size)
    4502:	6118                	ld	a4,0(a0)
    4504:	04877463          	bgeu	a4,s0,454c <malloc+0x7e>
        if (p == freep)
    4508:	1084b703          	ld	a4,264(s1)
    450c:	87aa                	mv	a5,a0
    450e:	fee519e3          	bne	a0,a4,4500 <malloc+0x32>
    if (nu < 4096)
    4512:	8922                	mv	s2,s0
    4514:	01447363          	bgeu	s0,s4,451a <malloc+0x4c>
    4518:	6905                	lui	s2,0x1
    cp = (char *)sbrk(nu);
    451a:	854a                	mv	a0,s2
    451c:	c3dfb0ef          	jal	158 <sbrk>
    4520:	87aa                	mv	a5,a0
    free((void *)(up + 1));
    4522:	0541                	addi	a0,a0,16
    if (cp == (void *)-1)
    4524:	01378963          	beq	a5,s3,4536 <malloc+0x68>
    up->size = nu;
    4528:	0127b023          	sd	s2,0(a5)
    free((void *)(up + 1));
    452c:	f2dff0ef          	jal	4458 <free>
    return freep;
    4530:	1084b783          	ld	a5,264(s1)
            if ((p = morecore(size)) == NULL)
    4534:	f7f1                	bnez	a5,4500 <malloc+0x32>
}
    4536:	70a2                	ld	ra,40(sp)
    4538:	7402                	ld	s0,32(sp)
                errno = ENOMEM;
    453a:	47b1                	li	a5,12
    453c:	c09c                	sw	a5,0(s1)
                return NULL;
    453e:	6942                	ld	s2,16(sp)
    4540:	69a2                	ld	s3,8(sp)
    4542:	6a02                	ld	s4,0(sp)
}
    4544:	64e2                	ld	s1,24(sp)
        return NULL;
    4546:	4501                	li	a0,0
}
    4548:	6145                	addi	sp,sp,48
    454a:	8082                	ret
    454c:	6942                	ld	s2,16(sp)
    454e:	69a2                	ld	s3,8(sp)
    4550:	6a02                	ld	s4,0(sp)
            if (p->size == size)
    4552:	02e40c63          	beq	s0,a4,458a <malloc+0xbc>
                p->size -= size;
    4556:	8f01                	sub	a4,a4,s0
    4558:	e118                	sd	a4,0(a0)
                p = (header_t *)((char *)p + p->size);
    455a:	953a                	add	a0,a0,a4
                p->size = size;
    455c:	e100                	sd	s0,0(a0)
}
    455e:	70a2                	ld	ra,40(sp)
    4560:	7402                	ld	s0,32(sp)
            freep = prevp;
    4562:	10f4b423          	sd	a5,264(s1)
            return (void *)(p + 1);
    4566:	0541                	addi	a0,a0,16
}
    4568:	64e2                	ld	s1,24(sp)
    456a:	6145                	addi	sp,sp,48
    456c:	8082                	ret
        base.next = freep = prevp = &base;
    456e:	00003517          	auipc	a0,0x3
    4572:	2f250513          	addi	a0,a0,754 # 7860 <base>
    4576:	10a4b423          	sd	a0,264(s1)
    457a:	10a4bc23          	sd	a0,280(s1)
        base.size = 0;
    457e:	00003797          	auipc	a5,0x3
    4582:	2e07b123          	sd	zero,738(a5) # 7860 <base>
        if (p->size >= size)
    4586:	f43d                	bnez	s0,44f4 <malloc+0x26>
        base.next = freep = prevp = &base;
    4588:	87aa                	mv	a5,a0
                prevp->next = p->next;
    458a:	6518                	ld	a4,8(a0)
    458c:	e798                	sd	a4,8(a5)
    458e:	bfc1                	j	455e <malloc+0x90>
        return NULL;
    4590:	4501                	li	a0,0
}
    4592:	8082                	ret

0000000000004594 <calloc>:
    if (__builtin_mul_overflow(nmemb, size, &total))
    4594:	02b537b3          	mulhu	a5,a0,a1
{
    4598:	1101                	addi	sp,sp,-32
    459a:	e822                	sd	s0,16(sp)
    459c:	ec06                	sd	ra,24(sp)
    459e:	e426                	sd	s1,8(sp)
    if (__builtin_mul_overflow(nmemb, size, &total))
    45a0:	02b50433          	mul	s0,a0,a1
    45a4:	e385                	bnez	a5,45c4 <calloc+0x30>
    void *p = malloc(total);
    45a6:	8522                	mv	a0,s0
    45a8:	f27ff0ef          	jal	44ce <malloc>
    45ac:	84aa                	mv	s1,a0
    if (p)
    45ae:	c509                	beqz	a0,45b8 <calloc+0x24>
        memset(p, 0, total);
    45b0:	8622                	mv	a2,s0
    45b2:	4581                	li	a1,0
    45b4:	524000ef          	jal	4ad8 <memset>
}
    45b8:	60e2                	ld	ra,24(sp)
    45ba:	6442                	ld	s0,16(sp)
    45bc:	8526                	mv	a0,s1
    45be:	64a2                	ld	s1,8(sp)
    45c0:	6105                	addi	sp,sp,32
    45c2:	8082                	ret
    45c4:	60e2                	ld	ra,24(sp)
    45c6:	6442                	ld	s0,16(sp)
        errno = ENOMEM;
    45c8:	47b1                	li	a5,12
        return NULL;
    45ca:	4481                	li	s1,0
        errno = ENOMEM;
    45cc:	00003717          	auipc	a4,0x3
    45d0:	18f72223          	sw	a5,388(a4) # 7750 <errno>
}
    45d4:	8526                	mv	a0,s1
    45d6:	64a2                	ld	s1,8(sp)
    45d8:	6105                	addi	sp,sp,32
    45da:	8082                	ret

00000000000045dc <realloc>:
    if (!ptr)
    45dc:	c929                	beqz	a0,462e <realloc+0x52>
{
    45de:	1101                	addi	sp,sp,-32
    45e0:	ec06                	sd	ra,24(sp)
    45e2:	e426                	sd	s1,8(sp)
    if (size == 0)
    45e4:	c5b9                	beqz	a1,4632 <realloc+0x56>
    if (bp->size >= new_size)
    45e6:	ff053703          	ld	a4,-16(a0)
    size_t new_size = ALIGN(size + sizeof(header_t));
    45ea:	01f58793          	addi	a5,a1,31
    45ee:	e822                	sd	s0,16(sp)
    45f0:	9bc1                	andi	a5,a5,-16
    45f2:	842a                	mv	s0,a0
        return ptr;
    45f4:	84aa                	mv	s1,a0
    if (bp->size >= new_size)
    45f6:	00f76863          	bltu	a4,a5,4606 <realloc+0x2a>
    45fa:	6442                	ld	s0,16(sp)
}
    45fc:	60e2                	ld	ra,24(sp)
    45fe:	8526                	mv	a0,s1
    4600:	64a2                	ld	s1,8(sp)
    4602:	6105                	addi	sp,sp,32
    4604:	8082                	ret
    void *new_ptr = malloc(size);
    4606:	852e                	mv	a0,a1
    4608:	ec7ff0ef          	jal	44ce <malloc>
    460c:	84aa                	mv	s1,a0
    if (!new_ptr)
    460e:	d575                	beqz	a0,45fa <realloc+0x1e>
    memcpy(new_ptr, ptr, bp->size - sizeof(header_t));
    4610:	ff043603          	ld	a2,-16(s0)
    4614:	85a2                	mv	a1,s0
    4616:	1641                	addi	a2,a2,-16
    4618:	514000ef          	jal	4b2c <memcpy>
    free(ptr);
    461c:	8522                	mv	a0,s0
    461e:	e3bff0ef          	jal	4458 <free>
}
    4622:	60e2                	ld	ra,24(sp)
    free(ptr);
    4624:	6442                	ld	s0,16(sp)
}
    4626:	8526                	mv	a0,s1
    4628:	64a2                	ld	s1,8(sp)
    462a:	6105                	addi	sp,sp,32
    462c:	8082                	ret
        return malloc(size);
    462e:	852e                	mv	a0,a1
    4630:	bd79                	j	44ce <malloc>
        free(ptr);
    4632:	e27ff0ef          	jal	4458 <free>
        return NULL;
    4636:	4481                	li	s1,0
    4638:	b7d1                	j	45fc <realloc+0x20>

000000000000463a <strtoull>:
    if (base < 0 || base == 1 || base > 36)
    463a:	02400813          	li	a6,36
{
    463e:	86aa                	mv	a3,a0
    4640:	872e                	mv	a4,a1
    if (base < 0 || base == 1 || base > 36)
    4642:	00c86663          	bltu	a6,a2,464e <strtoull+0x14>
    4646:	4805                	li	a6,1
    4648:	01060363          	beq	a2,a6,464e <strtoull+0x14>
    464c:	b939                	j	426a <strtoull.part.0>
        if (endptr)
    464e:	c311                	beqz	a4,4652 <strtoull+0x18>
            *endptr = (char *)nptr;
    4650:	e314                	sd	a3,0(a4)
        errno = 0; /* EINVAL */
    4652:	00003797          	auipc	a5,0x3
    4656:	0e07af23          	sw	zero,254(a5) # 7750 <errno>
}
    465a:	4501                	li	a0,0
    465c:	8082                	ret

000000000000465e <strtoll>:

long long strtoll(const char *nptr, char **endptr, int base)
{
    465e:	1141                	addi	sp,sp,-16
    4660:	e406                	sd	ra,8(sp)
    4662:	e022                	sd	s0,0(sp)
    const char *s = nptr;
    4664:	86aa                	mv	a3,a0
    static inline int isspace(int c) { return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r'; }
    4666:	02000813          	li	a6,32
    466a:	4891                	li	a7,4
    unsigned long long acc;
    int c, neg = 0;

    do
    {
        c = *s++;
    466c:	0006c783          	lbu	a5,0(a3)
    4670:	0685                	addi	a3,a3,1
    4672:	ff77871b          	addiw	a4,a5,-9
    4676:	0ff77713          	zext.b	a4,a4
    467a:	0007841b          	sext.w	s0,a5
    467e:	ff0787e3          	beq	a5,a6,466c <strtoll+0xe>
    4682:	fee8f5e3          	bgeu	a7,a4,466c <strtoll+0xe>
    if (base < 0 || base == 1 || base > 36)
    4686:	02400793          	li	a5,36
    468a:	02c7ec63          	bltu	a5,a2,46c2 <strtoll+0x64>
    468e:	4785                	li	a5,1
    4690:	02f60963          	beq	a2,a5,46c2 <strtoll+0x64>
    4694:	bd7ff0ef          	jal	426a <strtoull.part.0>
    if (c == '-')
        neg = 1;

    acc = strtoull(nptr, endptr, base);

    if (errno == ERANGE && acc == ULLONG_MAX)
    4698:	00003797          	auipc	a5,0x3
    469c:	0b878793          	addi	a5,a5,184 # 7750 <errno>
    46a0:	4394                	lw	a3,0(a5)
    46a2:	02200713          	li	a4,34
    46a6:	04e68363          	beq	a3,a4,46ec <strtoll+0x8e>
        return neg ? LLONG_MIN : LLONG_MAX;

    if (!neg && acc > (unsigned long long)LLONG_MAX)
    46aa:	02d00713          	li	a4,45
    46ae:	02e40563          	beq	s0,a4,46d8 <strtoll+0x7a>
    46b2:	00055f63          	bgez	a0,46d0 <strtoll+0x72>
    {
        errno = ERANGE;
    46b6:	02200713          	li	a4,34
    46ba:	c398                	sw	a4,0(a5)
        return neg ? LLONG_MIN : LLONG_MAX;
    46bc:	557d                	li	a0,-1
    46be:	8105                	srli	a0,a0,0x1
    46c0:	a801                	j	46d0 <strtoll+0x72>
        if (endptr)
    46c2:	c191                	beqz	a1,46c6 <strtoll+0x68>
            *endptr = (char *)nptr;
    46c4:	e188                	sd	a0,0(a1)
        errno = 0; /* EINVAL */
    46c6:	00003797          	auipc	a5,0x3
    46ca:	0807a523          	sw	zero,138(a5) # 7750 <errno>
    {
        errno = ERANGE;
        return LLONG_MIN;
    }

    return neg ? -(long long)acc : (long long)acc;
    46ce:	4501                	li	a0,0
}
    46d0:	60a2                	ld	ra,8(sp)
    46d2:	6402                	ld	s0,0(sp)
    46d4:	0141                	addi	sp,sp,16
    46d6:	8082                	ret
    if (neg && acc > (unsigned long long)LLONG_MAX + 1)
    46d8:	577d                	li	a4,-1
    46da:	177e                	slli	a4,a4,0x3f
    46dc:	02a76263          	bltu	a4,a0,4700 <strtoll+0xa2>
}
    46e0:	60a2                	ld	ra,8(sp)
    46e2:	6402                	ld	s0,0(sp)
    return neg ? -(long long)acc : (long long)acc;
    46e4:	40a00533          	neg	a0,a0
}
    46e8:	0141                	addi	sp,sp,16
    46ea:	8082                	ret
    if (errno == ERANGE && acc == ULLONG_MAX)
    46ec:	577d                	li	a4,-1
    46ee:	fae51ee3          	bne	a0,a4,46aa <strtoll+0x4c>
        return neg ? LLONG_MIN : LLONG_MAX;
    46f2:	02d00793          	li	a5,45
    46f6:	fcf413e3          	bne	s0,a5,46bc <strtoll+0x5e>
        return LLONG_MIN;
    46fa:	557d                	li	a0,-1
    46fc:	157e                	slli	a0,a0,0x3f
    46fe:	bfc9                	j	46d0 <strtoll+0x72>
        errno = ERANGE;
    4700:	02200713          	li	a4,34
    4704:	c398                	sw	a4,0(a5)
        return LLONG_MIN;
    4706:	bfd5                	j	46fa <strtoll+0x9c>

0000000000004708 <strtoul>:
    if (base < 0 || base == 1 || base > 36)
    4708:	02400813          	li	a6,36

unsigned long strtoul(const char *nptr, char **endptr, int base)
{
    470c:	86aa                	mv	a3,a0
    470e:	872e                	mv	a4,a1
    if (base < 0 || base == 1 || base > 36)
    4710:	00c86663          	bltu	a6,a2,471c <strtoul+0x14>
    4714:	4805                	li	a6,1
    4716:	01060363          	beq	a2,a6,471c <strtoul+0x14>
    471a:	be81                	j	426a <strtoull.part.0>
        if (endptr)
    471c:	c311                	beqz	a4,4720 <strtoul+0x18>
            *endptr = (char *)nptr;
    471e:	e314                	sd	a3,0(a4)
        errno = 0; /* EINVAL */
    4720:	00003797          	auipc	a5,0x3
    4724:	0207a823          	sw	zero,48(a5) # 7750 <errno>
    {
        errno = ERANGE;
        return ULONG_MAX;
    }
    return (unsigned long)ret;
}
    4728:	4501                	li	a0,0
    472a:	8082                	ret

000000000000472c <strtol>:

long strtol(const char *nptr, char **endptr, int base)
{
    long long ret = strtoll(nptr, endptr, base);
    472c:	bf0d                	j	465e <strtoll>

000000000000472e <atoi>:
        return LONG_MIN;
    }
    return (long)ret;
}

int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    472e:	1141                	addi	sp,sp,-16
    long long ret = strtoll(nptr, endptr, base);
    4730:	4629                	li	a2,10
    4732:	4581                	li	a1,0
int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    4734:	e406                	sd	ra,8(sp)
    long long ret = strtoll(nptr, endptr, base);
    4736:	f29ff0ef          	jal	465e <strtoll>
int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    473a:	60a2                	ld	ra,8(sp)
    473c:	2501                	sext.w	a0,a0
    473e:	0141                	addi	sp,sp,16
    4740:	8082                	ret

0000000000004742 <atol>:
    long long ret = strtoll(nptr, endptr, base);
    4742:	4629                	li	a2,10
    4744:	4581                	li	a1,0
    4746:	bf21                	j	465e <strtoll>

0000000000004748 <atoll>:
long atol(const char *nptr) { return strtol(nptr, NULL, 10); }
long long atoll(const char *nptr) { return strtoll(nptr, NULL, 10); }
    4748:	4629                	li	a2,10
    474a:	4581                	li	a1,0
    474c:	bf09                	j	465e <strtoll>

000000000000474e <strtod>:
    474e:	02000693          	li	a3,32
    4752:	4611                	li	a2,4
{
    double val = 0.0;
    int sign = 1;
    const char *s = nptr;

    while (isspace(*s))
    4754:	00054783          	lbu	a5,0(a0)
    4758:	ff77871b          	addiw	a4,a5,-9
    475c:	0ff77713          	zext.b	a4,a4
    4760:	06d78263          	beq	a5,a3,47c4 <strtod+0x76>
    4764:	06e67063          	bgeu	a2,a4,47c4 <strtod+0x76>
        s++;
    if (*s == '-')
    4768:	02d00713          	li	a4,45
    476c:	08e78e63          	beq	a5,a4,4808 <strtod+0xba>
    {
        sign = -1;
        s++;
    }
    else if (*s == '+')
    4770:	02b00713          	li	a4,43
    4774:	0ae78263          	beq	a5,a4,4818 <strtod+0xca>
    4778:	00001717          	auipc	a4,0x1
    477c:	0f073507          	fld	fa0,240(a4) # 5868 <STDIN_FD+0x10>
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    4780:	fd07861b          	addiw	a2,a5,-48
        s++;

    while (isdigit(*s))
    4784:	46a5                	li	a3,9
    4786:	f20007d3          	fmv.d.x	fa5,zero
    478a:	8732                	mv	a4,a2
    478c:	02c6e363          	bltu	a3,a2,47b2 <strtod+0x64>
    4790:	00001797          	auipc	a5,0x1
    4794:	0e07b687          	fld	fa3,224(a5) # 5870 <STDIN_FD+0x18>
    4798:	4625                	li	a2,9
    479a:	00154783          	lbu	a5,1(a0)
    {
        val = val * 10.0 + (*s - '0');
    479e:	d2070753          	fcvt.d.w	fa4,a4
        s++;
    47a2:	0505                	addi	a0,a0,1
    47a4:	fd07869b          	addiw	a3,a5,-48
        val = val * 10.0 + (*s - '0');
    47a8:	72d7f7c3          	fmadd.d	fa5,fa5,fa3,fa4
    47ac:	8736                	mv	a4,a3
    while (isdigit(*s))
    47ae:	fed676e3          	bgeu	a2,a3,479a <strtod+0x4c>
    }
    if (*s == '.')
    47b2:	02e00713          	li	a4,46
    47b6:	00e78963          	beq	a5,a4,47c8 <strtod+0x7a>
            val += (*s - '0') * factor;
            s++;
        }
    }

    if (endptr)
    47ba:	c191                	beqz	a1,47be <strtod+0x70>
        *endptr = (char *)s;
    47bc:	e188                	sd	a0,0(a1)
    return val * sign;
}
    47be:	12a7f553          	fmul.d	fa0,fa5,fa0
    47c2:	8082                	ret
        s++;
    47c4:	0505                	addi	a0,a0,1
    47c6:	b779                	j	4754 <strtod+0x6>
        while (isdigit(*s))
    47c8:	00154703          	lbu	a4,1(a0)
    47cc:	46a5                	li	a3,9
        s++;
    47ce:	0505                	addi	a0,a0,1
    47d0:	fd07071b          	addiw	a4,a4,-48
    47d4:	87ba                	mv	a5,a4
        while (isdigit(*s))
    47d6:	fee6e2e3          	bltu	a3,a4,47ba <strtod+0x6c>
        double factor = 1.0;
    47da:	00001717          	auipc	a4,0x1
    47de:	08e73707          	fld	fa4,142(a4) # 5868 <STDIN_FD+0x10>
    47e2:	00001717          	auipc	a4,0x1
    47e6:	0a673607          	fld	fa2,166(a4) # 5888 <STDIN_FD+0x30>
            factor *= 0.1;
    47ea:	12c77753          	fmul.d	fa4,fa4,fa2
        while (isdigit(*s))
    47ee:	00154703          	lbu	a4,1(a0)
            val += (*s - '0') * factor;
    47f2:	d20786d3          	fcvt.d.w	fa3,a5
            s++;
    47f6:	0505                	addi	a0,a0,1
    47f8:	fd07071b          	addiw	a4,a4,-48
    47fc:	87ba                	mv	a5,a4
            val += (*s - '0') * factor;
    47fe:	7ae6f7c3          	fmadd.d	fa5,fa3,fa4,fa5
        while (isdigit(*s))
    4802:	fee6f4e3          	bgeu	a3,a4,47ea <strtod+0x9c>
    4806:	bf55                	j	47ba <strtod+0x6c>
    while (isdigit(*s))
    4808:	00154783          	lbu	a5,1(a0)
    480c:	00001717          	auipc	a4,0x1
    4810:	05473507          	fld	fa0,84(a4) # 5860 <STDIN_FD+0x8>
        s++;
    4814:	0505                	addi	a0,a0,1
    4816:	b7ad                	j	4780 <strtod+0x32>
    while (isdigit(*s))
    4818:	00154783          	lbu	a5,1(a0)
    481c:	00001717          	auipc	a4,0x1
    4820:	04c73507          	fld	fa0,76(a4) # 5868 <STDIN_FD+0x10>
        s++;
    4824:	0505                	addi	a0,a0,1
    4826:	bfa9                	j	4780 <strtod+0x32>

0000000000004828 <atof>:

double atof(const char *nptr) { return strtod(nptr, NULL); }
    4828:	4581                	li	a1,0
    482a:	b715                	j	474e <strtod>

000000000000482c <strtof>:
float strtof(const char *nptr, char **endptr) { return (float)strtod(nptr, endptr); }
    482c:	1141                	addi	sp,sp,-16
    482e:	e406                	sd	ra,8(sp)
    4830:	f1fff0ef          	jal	474e <strtod>
    4834:	60a2                	ld	ra,8(sp)
    4836:	40157553          	fcvt.s.d	fa0,fa0
    483a:	0141                	addi	sp,sp,16
    483c:	8082                	ret

000000000000483e <qsort>:
    }
}

void qsort(void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *))
{
    if (nmemb < 2 || size == 0)
    483e:	4785                	li	a5,1
    4840:	0cb7fd63          	bgeu	a5,a1,491a <qsort+0xdc>
{
    4844:	715d                	addi	sp,sp,-80
    4846:	f44e                	sd	s3,40(sp)
    4848:	e486                	sd	ra,72(sp)
    484a:	89b2                	mv	s3,a2
    if (nmemb < 2 || size == 0)
    484c:	c279                	beqz	a2,4912 <qsort+0xd4>
    484e:	e85a                	sd	s6,16(sp)
    4850:	8b2e                	mv	s6,a1
        return;

    char *base_ptr = (char *)base;
    char *pivot = base_ptr + (nmemb - 1) * size;
    4852:	1b7d                	addi	s6,s6,-1
    4854:	fc26                	sd	s1,56(sp)
    4856:	033b04b3          	mul	s1,s6,s3
    485a:	ec56                	sd	s5,24(sp)
    485c:	8aaa                	mv	s5,a0
    485e:	f052                	sd	s4,32(sp)
    4860:	e45e                	sd	s7,8(sp)
    4862:	e0a2                	sd	s0,64(sp)
    4864:	f84a                	sd	s2,48(sp)
    4866:	8a36                	mv	s4,a3
    if (nmemb < 2 || size == 0)
    4868:	4b85                	li	s7,1
    char *pivot = base_ptr + (nmemb - 1) * size;
    486a:	94d6                	add	s1,s1,s5
    char *i = base_ptr;
    char *j = base_ptr;

    /* Partition */
    for (; j < pivot; j += size)
    486c:	069af763          	bgeu	s5,s1,48da <qsort+0x9c>
    char *j = base_ptr;
    4870:	8956                	mv	s2,s5
    char *i = base_ptr;
    4872:	8456                	mv	s0,s5
    4874:	a021                	j	487c <qsort+0x3e>
    for (; j < pivot; j += size)
    4876:	994e                	add	s2,s2,s3
    4878:	00997f63          	bgeu	s2,s1,4896 <qsort+0x58>
    {
        if (compar(j, pivot) < 0)
    487c:	85a6                	mv	a1,s1
    487e:	854a                	mv	a0,s2
    4880:	9a02                	jalr	s4
    4882:	fe055ae3          	bgez	a0,4876 <qsort+0x38>
        {
            if (i != j)
    4886:	05241d63          	bne	s0,s2,48e0 <qsort+0xa2>
    488a:	01390633          	add	a2,s2,s3
                swap_bytes(i, j, size);
            i += size;
    488e:	8432                	mv	s0,a2
    for (; j < pivot; j += size)
    4890:	994e                	add	s2,s2,s3
    4892:	fe9965e3          	bltu	s2,s1,487c <qsort+0x3e>
        }
    }
    swap_bytes(i, pivot, size);

    /* Recurse */
    size_t left_count = (i - base_ptr) / size;
    4896:	415405b3          	sub	a1,s0,s5
    489a:	0335d5b3          	divu	a1,a1,s3
    qsort(base, left_count, size, compar);
    qsort(i + size, nmemb - left_count - 1, size, compar);
    489e:	40bb0b33          	sub	s6,s6,a1
    while (size--)
    48a2:	013406b3          	add	a3,s0,s3
        *a++ = *b;
    48a6:	0004c703          	lbu	a4,0(s1)
        temp = *a;
    48aa:	00044783          	lbu	a5,0(s0)
        *b++ = temp;
    48ae:	0485                	addi	s1,s1,1
        *a++ = *b;
    48b0:	0405                	addi	s0,s0,1
    48b2:	fee40fa3          	sb	a4,-1(s0)
        *b++ = temp;
    48b6:	fef48fa3          	sb	a5,-1(s1)
    while (size--)
    48ba:	fed416e3          	bne	s0,a3,48a6 <qsort+0x68>
    qsort(base, left_count, size, compar);
    48be:	86d2                	mv	a3,s4
    48c0:	864e                	mv	a2,s3
    48c2:	8556                	mv	a0,s5
    48c4:	f7bff0ef          	jal	483e <qsort>
    if (nmemb < 2 || size == 0)
    48c8:	036bfe63          	bgeu	s7,s6,4904 <qsort+0xc6>
    char *pivot = base_ptr + (nmemb - 1) * size;
    48cc:	1b7d                	addi	s6,s6,-1
    48ce:	033b04b3          	mul	s1,s6,s3
    48d2:	8aa2                	mv	s5,s0
    48d4:	94d6                	add	s1,s1,s5
    for (; j < pivot; j += size)
    48d6:	f89aede3          	bltu	s5,s1,4870 <qsort+0x32>
    char *i = base_ptr;
    48da:	8456                	mv	s0,s5
    for (; j < pivot; j += size)
    48dc:	4581                	li	a1,0
    48de:	b7d1                	j	48a2 <qsort+0x64>
    48e0:	01340633          	add	a2,s0,s3
            if (i != j)
    48e4:	874a                	mv	a4,s2
    48e6:	87a2                	mv	a5,s0
        *a++ = *b;
    48e8:	00074683          	lbu	a3,0(a4)
        temp = *a;
    48ec:	0007c803          	lbu	a6,0(a5)
        *b++ = temp;
    48f0:	0705                	addi	a4,a4,1
        *a++ = *b;
    48f2:	0785                	addi	a5,a5,1
    48f4:	fed78fa3          	sb	a3,-1(a5)
        *b++ = temp;
    48f8:	ff070fa3          	sb	a6,-1(a4)
    while (size--)
    48fc:	fec796e3          	bne	a5,a2,48e8 <qsort+0xaa>
            i += size;
    4900:	8432                	mv	s0,a2
    4902:	b779                	j	4890 <qsort+0x52>
    4904:	6406                	ld	s0,64(sp)
    4906:	74e2                	ld	s1,56(sp)
    4908:	7942                	ld	s2,48(sp)
    490a:	7a02                	ld	s4,32(sp)
    490c:	6ae2                	ld	s5,24(sp)
    490e:	6b42                	ld	s6,16(sp)
    4910:	6ba2                	ld	s7,8(sp)
}
    4912:	60a6                	ld	ra,72(sp)
    4914:	79a2                	ld	s3,40(sp)
    4916:	6161                	addi	sp,sp,80
    4918:	8082                	ret
    491a:	8082                	ret

000000000000491c <bsearch>:

void *bsearch(const void *key, const void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *))
{
    491c:	715d                	addi	sp,sp,-80
    491e:	e486                	sd	ra,72(sp)
    4920:	fc26                	sd	s1,56(sp)
    size_t l = 0, u = nmemb;
    while (l < u)
    4922:	c629                	beqz	a2,496c <bsearch+0x50>
    4924:	f84a                	sd	s2,48(sp)
    4926:	f44e                	sd	s3,40(sp)
    4928:	f052                	sd	s4,32(sp)
    492a:	ec56                	sd	s5,24(sp)
    492c:	e85a                	sd	s6,16(sp)
    492e:	e45e                	sd	s7,8(sp)
    4930:	e0a2                	sd	s0,64(sp)
    4932:	8932                	mv	s2,a2
    4934:	8a2a                	mv	s4,a0
    4936:	8aae                	mv	s5,a1
    4938:	8b36                	mv	s6,a3
    493a:	8bba                	mv	s7,a4
    size_t l = 0, u = nmemb;
    493c:	4981                	li	s3,0
    {
        size_t idx = (l + u) / 2;
    493e:	01298433          	add	s0,s3,s2
    4942:	8005                	srli	s0,s0,0x1
        const void *p = (void *)((const char *)base + (idx * size));
    4944:	036404b3          	mul	s1,s0,s6
        int cmp = compar(key, p);
    4948:	8552                	mv	a0,s4
        const void *p = (void *)((const char *)base + (idx * size));
    494a:	94d6                	add	s1,s1,s5
        int cmp = compar(key, p);
    494c:	85a6                	mv	a1,s1
    494e:	9b82                	jalr	s7
        if (cmp < 0)
    4950:	02054463          	bltz	a0,4978 <bsearch+0x5c>
            u = idx;
        else if (cmp > 0)
    4954:	c515                	beqz	a0,4980 <bsearch+0x64>
            l = idx + 1;
    4956:	00140993          	addi	s3,s0,1
    while (l < u)
    495a:	ff29e2e3          	bltu	s3,s2,493e <bsearch+0x22>
    495e:	6406                	ld	s0,64(sp)
    4960:	7942                	ld	s2,48(sp)
    4962:	79a2                	ld	s3,40(sp)
    4964:	7a02                	ld	s4,32(sp)
    4966:	6ae2                	ld	s5,24(sp)
    4968:	6b42                	ld	s6,16(sp)
    496a:	6ba2                	ld	s7,8(sp)
        else
            return (void *)p;
    }
    return NULL;
}
    496c:	60a6                	ld	ra,72(sp)
    return NULL;
    496e:	4481                	li	s1,0
}
    4970:	8526                	mv	a0,s1
    4972:	74e2                	ld	s1,56(sp)
    4974:	6161                	addi	sp,sp,80
    4976:	8082                	ret
            u = idx;
    4978:	8922                	mv	s2,s0
    while (l < u)
    497a:	fd29e2e3          	bltu	s3,s2,493e <bsearch+0x22>
    497e:	b7c5                	j	495e <bsearch+0x42>
    4980:	6406                	ld	s0,64(sp)
}
    4982:	60a6                	ld	ra,72(sp)
    4984:	7942                	ld	s2,48(sp)
    4986:	79a2                	ld	s3,40(sp)
    4988:	7a02                	ld	s4,32(sp)
    498a:	6ae2                	ld	s5,24(sp)
    498c:	6b42                	ld	s6,16(sp)
    498e:	6ba2                	ld	s7,8(sp)
    4990:	8526                	mv	a0,s1
    4992:	74e2                	ld	s1,56(sp)
    4994:	6161                	addi	sp,sp,80
    4996:	8082                	ret

0000000000004998 <abs>:

/* Math & Mics */

int abs(int j) { return (j < 0) ? -j : j; }
    4998:	41f5579b          	sraiw	a5,a0,0x1f
    499c:	8d3d                	xor	a0,a0,a5
    499e:	9d1d                	subw	a0,a0,a5
    49a0:	8082                	ret

00000000000049a2 <labs>:
long labs(long j) { return (j < 0) ? -j : j; }
    49a2:	43f55793          	srai	a5,a0,0x3f
    49a6:	8d3d                	xor	a0,a0,a5
    49a8:	8d1d                	sub	a0,a0,a5
    49aa:	8082                	ret

00000000000049ac <llabs>:
long long llabs(long long j) { return (j < 0) ? -j : j; }
    49ac:	43f55793          	srai	a5,a0,0x3f
    49b0:	8d3d                	xor	a0,a0,a5
    49b2:	8d1d                	sub	a0,a0,a5
    49b4:	8082                	ret

00000000000049b6 <div>:

div_t div(int numer, int denom)
{
    div_t res = {numer / denom, numer % denom};
    49b6:	02b547bb          	divw	a5,a0,a1
{
    49ba:	1141                	addi	sp,sp,-16
    return res;
}
    49bc:	0141                	addi	sp,sp,16
    div_t res = {numer / denom, numer % denom};
    49be:	02b5653b          	remw	a0,a0,a1
    return res;
    49c2:	1782                	slli	a5,a5,0x20
    49c4:	9381                	srli	a5,a5,0x20
    49c6:	1502                	slli	a0,a0,0x20
}
    49c8:	8d5d                	or	a0,a0,a5
    49ca:	8082                	ret

00000000000049cc <ldiv>:
ldiv_t ldiv(long numer, long denom)
{
    49cc:	1141                	addi	sp,sp,-16
    49ce:	87aa                	mv	a5,a0
    ldiv_t res = {numer / denom, numer % denom};
    return res;
}
    49d0:	02b54533          	div	a0,a0,a1
    49d4:	0141                	addi	sp,sp,16
    49d6:	02b7e5b3          	rem	a1,a5,a1
    49da:	8082                	ret

00000000000049dc <lldiv>:
lldiv_t lldiv(long long numer, long long denom)
{
    49dc:	1141                	addi	sp,sp,-16
    49de:	87aa                	mv	a5,a0
    lldiv_t res = {numer / denom, numer % denom};
    return res;
}
    49e0:	02b54533          	div	a0,a0,a1
    49e4:	0141                	addi	sp,sp,16
    49e6:	02b7e5b3          	rem	a1,a5,a1
    49ea:	8082                	ret

00000000000049ec <rand>:

static unsigned long next = 1;
int rand(void)
{
    next = next * 1103515245 + 12345;
    49ec:	00003697          	auipc	a3,0x3
    49f0:	d1c68693          	addi	a3,a3,-740 # 7708 <next>
    49f4:	629c                	ld	a5,0(a3)
    49f6:	41c65737          	lui	a4,0x41c65
    49fa:	e6d70713          	addi	a4,a4,-403 # 41c64e6d <_ZSt4cerr+0x41c5d5e5>
    49fe:	02e787b3          	mul	a5,a5,a4
    4a02:	670d                	lui	a4,0x3
    4a04:	03970713          	addi	a4,a4,57 # 3039 <sprintf+0x33>
    4a08:	97ba                	add	a5,a5,a4
    return (unsigned int)(next / 65536) % 32768;
    4a0a:	02179513          	slli	a0,a5,0x21
    next = next * 1103515245 + 12345;
    4a0e:	e29c                	sd	a5,0(a3)
}
    4a10:	9145                	srli	a0,a0,0x31
    4a12:	8082                	ret

0000000000004a14 <srand>:
void srand(unsigned int seed) { next = seed; }
    4a14:	1502                	slli	a0,a0,0x20
    4a16:	9101                	srli	a0,a0,0x20
    4a18:	00003797          	auipc	a5,0x3
    4a1c:	cea7b823          	sd	a0,-784(a5) # 7708 <next>
    4a20:	8082                	ret

0000000000004a22 <mblen>:

/* Stub */
int mblen(const char *s, size_t n) { return (s && *s && n) ? 1 : 0; }
    4a22:	c901                	beqz	a0,4a32 <mblen+0x10>
    4a24:	00054783          	lbu	a5,0(a0)
    4a28:	4501                	li	a0,0
    4a2a:	c789                	beqz	a5,4a34 <mblen+0x12>
    4a2c:	00b03533          	snez	a0,a1
    4a30:	8082                	ret
    4a32:	4501                	li	a0,0
    4a34:	8082                	ret

0000000000004a36 <mbtowc>:
int mbtowc(wchar_t *pwc, const char *s, size_t n)
{
    4a36:	87aa                	mv	a5,a0
    if (!s)
    4a38:	cd81                	beqz	a1,4a50 <mbtowc+0x1a>
        return 0;
    if (n == 0)
        return -1;
    4a3a:	557d                	li	a0,-1
    if (n == 0)
    4a3c:	ca19                	beqz	a2,4a52 <mbtowc+0x1c>
    if (pwc)
    4a3e:	c781                	beqz	a5,4a46 <mbtowc+0x10>
        *pwc = (wchar_t)*s;
    4a40:	0005c703          	lbu	a4,0(a1)
    4a44:	c398                	sw	a4,0(a5)
    return (*s != 0);
    4a46:	0005c503          	lbu	a0,0(a1)
    4a4a:	00a03533          	snez	a0,a0
    4a4e:	8082                	ret
        return 0;
    4a50:	4501                	li	a0,0
}
    4a52:	8082                	ret

0000000000004a54 <wctomb>:
int wctomb(char *s, wchar_t wchar)
{
    if (!s)
    4a54:	c509                	beqz	a0,4a5e <wctomb+0xa>
        return 0;
    *s = (char)wchar;
    4a56:	00b50023          	sb	a1,0(a0)
    return 1;
    4a5a:	4505                	li	a0,1
    4a5c:	8082                	ret
        return 0;
    4a5e:	4501                	li	a0,0
}
    4a60:	8082                	ret

0000000000004a62 <mbstowcs>:
size_t mbstowcs(wchar_t *dest, const char *src, size_t n)
{
    size_t i = 0;
    while (src[i] && i < n)
    4a62:	0005c703          	lbu	a4,0(a1)
    4a66:	cb0d                	beqz	a4,4a98 <mbstowcs+0x36>
    4a68:	ca15                	beqz	a2,4a9c <mbstowcs+0x3a>
    4a6a:	86aa                	mv	a3,a0
    size_t i = 0;
    4a6c:	4781                	li	a5,0
    4a6e:	a019                	j	4a74 <mbstowcs+0x12>
    while (src[i] && i < n)
    4a70:	02f60263          	beq	a2,a5,4a94 <mbstowcs+0x32>
    {
        dest[i] = (wchar_t)src[i];
        i++;
    4a74:	0785                	addi	a5,a5,1
        dest[i] = (wchar_t)src[i];
    4a76:	c298                	sw	a4,0(a3)
    while (src[i] && i < n)
    4a78:	00f58733          	add	a4,a1,a5
    4a7c:	00074703          	lbu	a4,0(a4)
    4a80:	0691                	addi	a3,a3,4
    4a82:	f77d                	bnez	a4,4a70 <mbstowcs+0xe>
    }
    if (i < n)
    4a84:	00c7f763          	bgeu	a5,a2,4a92 <mbstowcs+0x30>
        dest[i] = 0;
    4a88:	00279713          	slli	a4,a5,0x2
    4a8c:	953a                	add	a0,a0,a4
    4a8e:	00052023          	sw	zero,0(a0)
    size_t i = 0;
    4a92:	863e                	mv	a2,a5
    4a94:	8532                	mv	a0,a2
    4a96:	8082                	ret
    4a98:	4781                	li	a5,0
    4a9a:	b7ed                	j	4a84 <mbstowcs+0x22>
    4a9c:	4501                	li	a0,0
    return i;
}
    4a9e:	8082                	ret

0000000000004aa0 <wcstombs>:
size_t wcstombs(char *dest, const wchar_t *src, size_t n)
{
    size_t i = 0;
    while (src[i] && i < n)
    4aa0:	4198                	lw	a4,0(a1)
    4aa2:	c71d                	beqz	a4,4ad0 <wcstombs+0x30>
    4aa4:	ca05                	beqz	a2,4ad4 <wcstombs+0x34>
    4aa6:	0591                	addi	a1,a1,4
    size_t i = 0;
    4aa8:	4781                	li	a5,0
    4aaa:	a019                	j	4ab0 <wcstombs+0x10>
    while (src[i] && i < n)
    4aac:	02f60063          	beq	a2,a5,4acc <wcstombs+0x2c>
    {
        dest[i] = (char)src[i];
    4ab0:	00f506b3          	add	a3,a0,a5
    4ab4:	00e68023          	sb	a4,0(a3)
    while (src[i] && i < n)
    4ab8:	4198                	lw	a4,0(a1)
        i++;
    4aba:	0785                	addi	a5,a5,1
    while (src[i] && i < n)
    4abc:	0591                	addi	a1,a1,4
    4abe:	f77d                	bnez	a4,4aac <wcstombs+0xc>
    }
    if (i < n)
    4ac0:	00c7f563          	bgeu	a5,a2,4aca <wcstombs+0x2a>
        dest[i] = 0;
    4ac4:	953e                	add	a0,a0,a5
    4ac6:	00050023          	sb	zero,0(a0)
    size_t i = 0;
    4aca:	863e                	mv	a2,a5
    4acc:	8532                	mv	a0,a2
    4ace:	8082                	ret
    4ad0:	4781                	li	a5,0
    4ad2:	b7fd                	j	4ac0 <wcstombs+0x20>
    4ad4:	4501                	li	a0,0
    return i;
    4ad6:	8082                	ret

0000000000004ad8 <memset>:

void *memset(void *dst, int c, size_t n)
{
    char *cdst = (char *)dst;
    for (size_t i = 0; i < n; i++)
        cdst[i] = (char)c;
    4ad8:	0ff5f593          	zext.b	a1,a1
    4adc:	87aa                	mv	a5,a0
    4ade:	00a60733          	add	a4,a2,a0
    for (size_t i = 0; i < n; i++)
    4ae2:	c611                	beqz	a2,4aee <memset+0x16>
        cdst[i] = (char)c;
    4ae4:	00b78023          	sb	a1,0(a5)
    for (size_t i = 0; i < n; i++)
    4ae8:	0785                	addi	a5,a5,1
    4aea:	fee79de3          	bne	a5,a4,4ae4 <memset+0xc>
    return dst;
}
    4aee:	8082                	ret

0000000000004af0 <memmove>:

void *memmove(void *vdst, const void *vsrc, size_t n)
{
    char *dst = (char *)vdst;
    const char *src = (const char *)vsrc;
    if (dst == src)
    4af0:	02b50d63          	beq	a0,a1,4b2a <memmove+0x3a>
        return vdst;

    if (src > dst)
    4af4:	00b57e63          	bgeu	a0,a1,4b10 <memmove+0x20>
    {
        while (n--)
    4af8:	ca0d                	beqz	a2,4b2a <memmove+0x3a>
    4afa:	962a                	add	a2,a2,a0
    char *dst = (char *)vdst;
    4afc:	87aa                	mv	a5,a0
            *dst++ = *src++;
    4afe:	0005c703          	lbu	a4,0(a1)
    4b02:	0785                	addi	a5,a5,1
    4b04:	0585                	addi	a1,a1,1
    4b06:	fee78fa3          	sb	a4,-1(a5)
        while (n--)
    4b0a:	fec79ae3          	bne	a5,a2,4afe <memmove+0xe>
    4b0e:	8082                	ret
    }
    else
    {
        dst += n;
    4b10:	00c50733          	add	a4,a0,a2
        src += n;
    4b14:	00c587b3          	add	a5,a1,a2
        while (n-- > 0)
    4b18:	ca09                	beqz	a2,4b2a <memmove+0x3a>
            *--dst = *--src;
    4b1a:	fff7c683          	lbu	a3,-1(a5)
    4b1e:	17fd                	addi	a5,a5,-1
    4b20:	177d                	addi	a4,a4,-1
    4b22:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
    4b26:	fef59ae3          	bne	a1,a5,4b1a <memmove+0x2a>
    }
    return vdst;
}
    4b2a:	8082                	ret

0000000000004b2c <memcpy>:

void *memcpy(void *vdst, const void *vsrc, size_t n)
{
    return memmove(vdst, vsrc, n);
    4b2c:	b7d1                	j	4af0 <memmove>

0000000000004b2e <memcmp>:

int memcmp(const void *s1, const void *s2, size_t n)
{
    const unsigned char *p1 = (const unsigned char *)s1;
    const unsigned char *p2 = (const unsigned char *)s2;
    while (n--)
    4b2e:	c205                	beqz	a2,4b4e <memcmp+0x20>
    4b30:	962a                	add	a2,a2,a0
    4b32:	a019                	j	4b38 <memcmp+0xa>
    4b34:	00c50d63          	beq	a0,a2,4b4e <memcmp+0x20>
    {
        if (*p1 != *p2)
    4b38:	00054783          	lbu	a5,0(a0)
    4b3c:	0005c703          	lbu	a4,0(a1)
            return *p1 - *p2;
        p1++;
    4b40:	0505                	addi	a0,a0,1
        p2++;
    4b42:	0585                	addi	a1,a1,1
        if (*p1 != *p2)
    4b44:	fee788e3          	beq	a5,a4,4b34 <memcmp+0x6>
            return *p1 - *p2;
    4b48:	40e7853b          	subw	a0,a5,a4
    4b4c:	8082                	ret
    }
    return 0;
    4b4e:	4501                	li	a0,0
}
    4b50:	8082                	ret

0000000000004b52 <memchr>:

void *memchr(const void *s, int c, size_t n)
{
    const unsigned char *p = (const unsigned char *)s;
    while (n--)
    4b52:	ce09                	beqz	a2,4b6c <memchr+0x1a>
    {
        if (*p == (unsigned char)c)
    4b54:	0ff5f593          	zext.b	a1,a1
    4b58:	962a                	add	a2,a2,a0
    4b5a:	a021                	j	4b62 <memchr+0x10>
            return (void *)p;
        p++;
    4b5c:	0505                	addi	a0,a0,1
    while (n--)
    4b5e:	00a60763          	beq	a2,a0,4b6c <memchr+0x1a>
        if (*p == (unsigned char)c)
    4b62:	00054783          	lbu	a5,0(a0)
    4b66:	feb79be3          	bne	a5,a1,4b5c <memchr+0xa>
    }
    return NULL;
}
    4b6a:	8082                	ret
    return NULL;
    4b6c:	4501                	li	a0,0
}
    4b6e:	8082                	ret

0000000000004b70 <strlen>:
/* String Manipulation Functions  */

size_t strlen(const char *s)
{
    const char *p = s;
    while (*p)
    4b70:	00054783          	lbu	a5,0(a0)
    4b74:	cb89                	beqz	a5,4b86 <strlen+0x16>
    const char *p = s;
    4b76:	87aa                	mv	a5,a0
    while (*p)
    4b78:	0017c703          	lbu	a4,1(a5)
        p++;
    4b7c:	0785                	addi	a5,a5,1
    while (*p)
    4b7e:	ff6d                	bnez	a4,4b78 <strlen+0x8>
    return (size_t)(p - s);
    4b80:	40a78533          	sub	a0,a5,a0
    4b84:	8082                	ret
    while (*p)
    4b86:	4501                	li	a0,0
}
    4b88:	8082                	ret

0000000000004b8a <strcpy>:

char *strcpy(char *dst, const char *src)
{
    char *os = dst;
    while ((*dst++ = *src++) != 0)
    4b8a:	87aa                	mv	a5,a0
    4b8c:	0005c703          	lbu	a4,0(a1)
    4b90:	0785                	addi	a5,a5,1
    4b92:	0585                	addi	a1,a1,1
    4b94:	fee78fa3          	sb	a4,-1(a5)
    4b98:	fb75                	bnez	a4,4b8c <strcpy+0x2>
        ;
    return os;
}
    4b9a:	8082                	ret

0000000000004b9c <strncpy>:
char *strncpy(char *dst, const char *src, size_t n)
{
    char *os = dst;
    size_t i;

    for (i = 0; i < n && src[i] != '\0'; i++)
    4b9c:	4781                	li	a5,0
    4b9e:	e619                	bnez	a2,4bac <strncpy+0x10>
    4ba0:	8082                	ret
        dst[i] = src[i];
    4ba2:	00e68023          	sb	a4,0(a3)
    for (i = 0; i < n && src[i] != '\0'; i++)
    4ba6:	0785                	addi	a5,a5,1
    4ba8:	02f60263          	beq	a2,a5,4bcc <strncpy+0x30>
    4bac:	00f58733          	add	a4,a1,a5
    4bb0:	00074703          	lbu	a4,0(a4)
        dst[i] = src[i];
    4bb4:	00f506b3          	add	a3,a0,a5
    for (i = 0; i < n && src[i] != '\0'; i++)
    4bb8:	f76d                	bnez	a4,4ba2 <strncpy+0x6>

    for (; i < n; i++)
    4bba:	00c7f963          	bgeu	a5,a2,4bcc <strncpy+0x30>
    4bbe:	87b6                	mv	a5,a3
    4bc0:	962a                	add	a2,a2,a0
        dst[i] = '\0';
    4bc2:	00078023          	sb	zero,0(a5)
    for (; i < n; i++)
    4bc6:	0785                	addi	a5,a5,1
    4bc8:	fec79de3          	bne	a5,a2,4bc2 <strncpy+0x26>

    return os;
}
    4bcc:	8082                	ret

0000000000004bce <strcat>:

char *strcat(char *dst, const char *src)
{
    char *os = dst;
    while (*dst)
    4bce:	00054783          	lbu	a5,0(a0)
    4bd2:	cf91                	beqz	a5,4bee <strcat+0x20>
    4bd4:	87aa                	mv	a5,a0
    4bd6:	0017c703          	lbu	a4,1(a5)
        dst++;
    4bda:	0785                	addi	a5,a5,1
    while (*dst)
    4bdc:	ff6d                	bnez	a4,4bd6 <strcat+0x8>
    while ((*dst++ = *src++) != 0)
    4bde:	0005c703          	lbu	a4,0(a1)
    4be2:	0785                	addi	a5,a5,1
    4be4:	0585                	addi	a1,a1,1
    4be6:	fee78fa3          	sb	a4,-1(a5)
    4bea:	fb75                	bnez	a4,4bde <strcat+0x10>
        ;
    return os;
}
    4bec:	8082                	ret
    while ((*dst++ = *src++) != 0)
    4bee:	0005c703          	lbu	a4,0(a1)
    while (*dst)
    4bf2:	87aa                	mv	a5,a0
    while ((*dst++ = *src++) != 0)
    4bf4:	0785                	addi	a5,a5,1
    4bf6:	fee78fa3          	sb	a4,-1(a5)
    4bfa:	0585                	addi	a1,a1,1
    4bfc:	f36d                	bnez	a4,4bde <strcat+0x10>
    4bfe:	8082                	ret

0000000000004c00 <strncat>:
    while (*p)
    4c00:	00054783          	lbu	a5,0(a0)
    const char *p = s;
    4c04:	872a                	mv	a4,a0
    while (*p)
    4c06:	c789                	beqz	a5,4c10 <strncat+0x10>
    4c08:	00174783          	lbu	a5,1(a4)
        p++;
    4c0c:	0705                	addi	a4,a4,1
    while (*p)
    4c0e:	ffed                	bnez	a5,4c08 <strncat+0x8>
    size_t dest_len = strlen(dst);
    size_t i;

    dst += dest_len;

    for (i = 0; i < n && src[i] != '\0'; i++)
    4c10:	86ba                	mv	a3,a4
    4c12:	4781                	li	a5,0
    4c14:	88ba                	mv	a7,a4
    4c16:	ea01                	bnez	a2,4c26 <strncat+0x26>
    4c18:	a839                	j	4c36 <strncat+0x36>
        dst[i] = src[i];
    4c1a:	01068023          	sb	a6,0(a3)
    for (i = 0; i < n && src[i] != '\0'; i++)
    4c1e:	00188693          	addi	a3,a7,1
    4c22:	00f60d63          	beq	a2,a5,4c3c <strncat+0x3c>
    4c26:	00f58833          	add	a6,a1,a5
    4c2a:	00084803          	lbu	a6,0(a6)
    4c2e:	0785                	addi	a5,a5,1
        dst[i] = src[i];
    4c30:	88b6                	mv	a7,a3
    for (i = 0; i < n && src[i] != '\0'; i++)
    4c32:	fe0814e3          	bnez	a6,4c1a <strncat+0x1a>

    dst[i] = '\0';
    4c36:	00088023          	sb	zero,0(a7)

    return os;
}
    4c3a:	8082                	ret
    dst[i] = '\0';
    4c3c:	00c708b3          	add	a7,a4,a2
    4c40:	00088023          	sb	zero,0(a7)
}
    4c44:	8082                	ret

0000000000004c46 <strcmp>:

int strcmp(const char *p, const char *q)
{
    while (*p && *p == *q)
    4c46:	00054783          	lbu	a5,0(a0)
    4c4a:	e791                	bnez	a5,4c56 <strcmp+0x10>
    4c4c:	a02d                	j	4c76 <strcmp+0x30>
    4c4e:	00054783          	lbu	a5,0(a0)
    4c52:	cf89                	beqz	a5,4c6c <strcmp+0x26>
    4c54:	85b6                	mv	a1,a3
    4c56:	0005c703          	lbu	a4,0(a1)
    {
        p++;
    4c5a:	0505                	addi	a0,a0,1
        q++;
    4c5c:	00158693          	addi	a3,a1,1
    while (*p && *p == *q)
    4c60:	fef707e3          	beq	a4,a5,4c4e <strcmp+0x8>
    }
    return (int)((unsigned char)*p - (unsigned char)*q);
    4c64:	0007851b          	sext.w	a0,a5
}
    4c68:	9d19                	subw	a0,a0,a4
    4c6a:	8082                	ret
    return (int)((unsigned char)*p - (unsigned char)*q);
    4c6c:	0015c703          	lbu	a4,1(a1)
    4c70:	4501                	li	a0,0
}
    4c72:	9d19                	subw	a0,a0,a4
    4c74:	8082                	ret
    return (int)((unsigned char)*p - (unsigned char)*q);
    4c76:	0005c703          	lbu	a4,0(a1)
    4c7a:	4501                	li	a0,0
    4c7c:	b7f5                	j	4c68 <strcmp+0x22>

0000000000004c7e <strncmp>:

int strncmp(const char *s1, const char *s2, size_t n)
{
    if (n == 0)
    4c7e:	ca0d                	beqz	a2,4cb0 <strncmp+0x32>
        return 0;

    while (n-- > 0 && *s1 && *s1 == *s2)
    4c80:	00054783          	lbu	a5,0(a0)
    4c84:	167d                	addi	a2,a2,-1
    4c86:	00c506b3          	add	a3,a0,a2
    4c8a:	eb89                	bnez	a5,4c9c <strncmp+0x1e>
    4c8c:	a80d                	j	4cbe <strncmp+0x40>
    {
        if (n == 0 || *s1 == '\0')
    4c8e:	00d50d63          	beq	a0,a3,4ca8 <strncmp+0x2a>
    while (n-- > 0 && *s1 && *s1 == *s2)
    4c92:	00154783          	lbu	a5,1(a0)
            break;
        s1++;
    4c96:	0505                	addi	a0,a0,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    4c98:	cf91                	beqz	a5,4cb4 <strncmp+0x36>
    4c9a:	85b2                	mv	a1,a2
    4c9c:	0005c703          	lbu	a4,0(a1)
        s2++;
    4ca0:	00158613          	addi	a2,a1,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    4ca4:	fef705e3          	beq	a4,a5,4c8e <strncmp+0x10>
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    4ca8:	0007851b          	sext.w	a0,a5
    4cac:	9d19                	subw	a0,a0,a4
    4cae:	8082                	ret
        return 0;
    4cb0:	4501                	li	a0,0
}
    4cb2:	8082                	ret
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    4cb4:	0015c703          	lbu	a4,1(a1)
    4cb8:	4501                	li	a0,0
    4cba:	9d19                	subw	a0,a0,a4
    4cbc:	8082                	ret
    4cbe:	0005c703          	lbu	a4,0(a1)
    4cc2:	4501                	li	a0,0
    4cc4:	b7e5                	j	4cac <strncmp+0x2e>

0000000000004cc6 <strchr>:

char *strchr(const char *s, int c)
{
    while (*s != (char)c)
    4cc6:	0ff5f593          	zext.b	a1,a1
    4cca:	a019                	j	4cd0 <strchr+0xa>
    {
        if (!*s++)
    4ccc:	0505                	addi	a0,a0,1
    4cce:	c791                	beqz	a5,4cda <strchr+0x14>
    while (*s != (char)c)
    4cd0:	00054783          	lbu	a5,0(a0)
    4cd4:	feb79ce3          	bne	a5,a1,4ccc <strchr+0x6>
    4cd8:	8082                	ret
            return NULL;
    4cda:	4501                	li	a0,0
    }
    return (char *)s;
}
    4cdc:	8082                	ret

0000000000004cde <strrchr>:

char *strrchr(const char *s, int c)
{
    4cde:	87aa                	mv	a5,a0
    const char *last = NULL;
    do
    {
        if (*s == (char)c)
    4ce0:	0ff5f593          	zext.b	a1,a1
    const char *last = NULL;
    4ce4:	4501                	li	a0,0
        if (*s == (char)c)
    4ce6:	0007c703          	lbu	a4,0(a5)
    4cea:	00e59363          	bne	a1,a4,4cf0 <strrchr+0x12>
            last = s;
    4cee:	853e                	mv	a0,a5
    } while (*s++);
    4cf0:	0785                	addi	a5,a5,1
    4cf2:	fb75                	bnez	a4,4ce6 <strrchr+0x8>

    return (char *)last;
}
    4cf4:	8082                	ret

0000000000004cf6 <strstr>:
    while (*p)
    4cf6:	0005c883          	lbu	a7,0(a1)
    4cfa:	04088a63          	beqz	a7,4d4e <strstr+0x58>
    const char *p = s;
    4cfe:	87ae                	mv	a5,a1
    while (*p)
    4d00:	0017c703          	lbu	a4,1(a5)
        p++;
    4d04:	0785                	addi	a5,a5,1
    while (*p)
    4d06:	ff6d                	bnez	a4,4d00 <strstr+0xa>
    return (size_t)(p - s);
    4d08:	40b78833          	sub	a6,a5,a1


char *strstr(const char *haystack, const char *needle)
{
    size_t n_len = strlen(needle);
    if (n_len == 0)
    4d0c:	04b78163          	beq	a5,a1,4d4e <strstr+0x58>
        return (char *)haystack;

    for (; *haystack; haystack++)
    4d10:	00054783          	lbu	a5,0(a0)
    4d14:	cf85                	beqz	a5,4d4c <strstr+0x56>
    4d16:	187d                	addi	a6,a6,-1
    4d18:	982a                	add	a6,a6,a0
    {
        if (*haystack != *needle)
    4d1a:	02f89463          	bne	a7,a5,4d42 <strstr+0x4c>
    while (n-- > 0 && *s1 && *s1 == *s2)
    4d1e:	00054703          	lbu	a4,0(a0)
    4d22:	8646                	mv	a2,a7
    4d24:	86ae                	mv	a3,a1
    4d26:	87aa                	mv	a5,a0
    4d28:	eb11                	bnez	a4,4d3c <strstr+0x46>
    4d2a:	a821                	j	4d42 <strstr+0x4c>
        if (n == 0 || *s1 == '\0')
    4d2c:	03078163          	beq	a5,a6,4d4e <strstr+0x58>
    while (n-- > 0 && *s1 && *s1 == *s2)
    4d30:	0017c703          	lbu	a4,1(a5)
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    4d34:	0006c603          	lbu	a2,0(a3)
        s1++;
    4d38:	0785                	addi	a5,a5,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    4d3a:	cb19                	beqz	a4,4d50 <strstr+0x5a>
        s2++;
    4d3c:	0685                	addi	a3,a3,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    4d3e:	fee607e3          	beq	a2,a4,4d2c <strstr+0x36>
    for (; *haystack; haystack++)
    4d42:	00154783          	lbu	a5,1(a0)
    4d46:	0805                	addi	a6,a6,1
    4d48:	0505                	addi	a0,a0,1
    4d4a:	fbe1                	bnez	a5,4d1a <strstr+0x24>
            continue;

        if (strncmp(haystack, needle, n_len) == 0)
            return (char *)haystack;
    }
    return NULL;
    4d4c:	4501                	li	a0,0
}
    4d4e:	8082                	ret
        if (strncmp(haystack, needle, n_len) == 0)
    4d50:	de7d                	beqz	a2,4d4e <strstr+0x58>
    for (; *haystack; haystack++)
    4d52:	00154783          	lbu	a5,1(a0)
    4d56:	0805                	addi	a6,a6,1
    4d58:	0505                	addi	a0,a0,1
    4d5a:	f3e1                	bnez	a5,4d1a <strstr+0x24>
    4d5c:	bfc5                	j	4d4c <strstr+0x56>

0000000000004d5e <strdup>:

char *strdup(const char *s)
{
    4d5e:	1101                	addi	sp,sp,-32
    4d60:	e426                	sd	s1,8(sp)
    4d62:	ec06                	sd	ra,24(sp)
    4d64:	e822                	sd	s0,16(sp)
    while (*p)
    4d66:	00054783          	lbu	a5,0(a0)
{
    4d6a:	84aa                	mv	s1,a0
    while (*p)
    4d6c:	cb8d                	beqz	a5,4d9e <strdup+0x40>
    const char *p = s;
    4d6e:	862a                	mv	a2,a0
    while (*p)
    4d70:	00164783          	lbu	a5,1(a2)
        p++;
    4d74:	0605                	addi	a2,a2,1
    while (*p)
    4d76:	ffed                	bnez	a5,4d70 <strdup+0x12>
    return (size_t)(p - s);
    4d78:	8e05                	sub	a2,a2,s1
    size_t len = strlen(s) + 1;
    4d7a:	00160413          	addi	s0,a2,1
    char *new_str = (char *)malloc(len);
    4d7e:	8522                	mv	a0,s0
    4d80:	f4eff0ef          	jal	44ce <malloc>
    if (new_str == NULL)
    4d84:	c901                	beqz	a0,4d94 <strdup+0x36>
    return memmove(vdst, vsrc, n);
    4d86:	8622                	mv	a2,s0
        return NULL;

    return (char *)memcpy(new_str, s, len);
}
    4d88:	6442                	ld	s0,16(sp)
    4d8a:	60e2                	ld	ra,24(sp)
    return memmove(vdst, vsrc, n);
    4d8c:	85a6                	mv	a1,s1
}
    4d8e:	64a2                	ld	s1,8(sp)
    4d90:	6105                	addi	sp,sp,32
    return memmove(vdst, vsrc, n);
    4d92:	bbb9                	j	4af0 <memmove>
}
    4d94:	60e2                	ld	ra,24(sp)
    4d96:	6442                	ld	s0,16(sp)
    4d98:	64a2                	ld	s1,8(sp)
    4d9a:	6105                	addi	sp,sp,32
    4d9c:	8082                	ret
    while (*p)
    4d9e:	4405                	li	s0,1
    4da0:	bff9                	j	4d7e <strdup+0x20>

0000000000004da2 <strlcpy>:
    4da2:	0005c783          	lbu	a5,0(a1)

size_t strlcpy(char *dst, const char *src, size_t size)
{
    4da6:	1101                	addi	sp,sp,-32
    4da8:	ec06                	sd	ra,24(sp)
    4daa:	e822                	sd	s0,16(sp)
    4dac:	86b2                	mv	a3,a2
    while (*p)
    4dae:	cf8d                	beqz	a5,4de8 <strlcpy+0x46>
    const char *p = s;
    4db0:	87ae                	mv	a5,a1
    while (*p)
    4db2:	0017c703          	lbu	a4,1(a5)
        p++;
    4db6:	0785                	addi	a5,a5,1
    while (*p)
    4db8:	ff6d                	bnez	a4,4db2 <strlcpy+0x10>
    return (size_t)(p - s);
    4dba:	40b78433          	sub	s0,a5,a1
    size_t src_len = strlen(src);

    if (size > 0)
    4dbe:	c285                	beqz	a3,4dde <strlcpy+0x3c>
    4dc0:	e426                	sd	s1,8(sp)
    {
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    4dc2:	fff68613          	addi	a2,a3,-1
        memcpy(dst, src, copy_len);
        dst[copy_len] = '\0';
    4dc6:	00c504b3          	add	s1,a0,a2
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    4dca:	00d47563          	bgeu	s0,a3,4dd4 <strlcpy+0x32>
        dst[copy_len] = '\0';
    4dce:	008504b3          	add	s1,a0,s0
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    4dd2:	8622                	mv	a2,s0
    return memmove(vdst, vsrc, n);
    4dd4:	d1dff0ef          	jal	4af0 <memmove>
        dst[copy_len] = '\0';
    4dd8:	00048023          	sb	zero,0(s1)
    }

    return src_len;
    4ddc:	64a2                	ld	s1,8(sp)
}
    4dde:	60e2                	ld	ra,24(sp)
    4de0:	8522                	mv	a0,s0
    4de2:	6442                	ld	s0,16(sp)
    4de4:	6105                	addi	sp,sp,32
    4de6:	8082                	ret
    if (size > 0)
    4de8:	e219                	bnez	a2,4dee <strlcpy+0x4c>
    return (size_t)(p - s);
    4dea:	4401                	li	s0,0
    4dec:	bfcd                	j	4dde <strlcpy+0x3c>
    4dee:	e426                	sd	s1,8(sp)
    4df0:	4401                	li	s0,0
    if (size > 0)
    4df2:	84aa                	mv	s1,a0
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    4df4:	4601                	li	a2,0
    4df6:	bff9                	j	4dd4 <strlcpy+0x32>

0000000000004df8 <strlcat>:
    while (*p)
    4df8:	0005c783          	lbu	a5,0(a1)

size_t strlcat(char *dst, const char *src, size_t size)
{
    4dfc:	7179                	addi	sp,sp,-48
    4dfe:	e84a                	sd	s2,16(sp)
    4e00:	f406                	sd	ra,40(sp)
    4e02:	f022                	sd	s0,32(sp)
    4e04:	ec26                	sd	s1,24(sp)
    4e06:	892a                	mv	s2,a0
    while (*p)
    4e08:	c7b5                	beqz	a5,4e74 <strlcat+0x7c>
    const char *p = s;
    4e0a:	87ae                	mv	a5,a1
    while (*p)
    4e0c:	0017c703          	lbu	a4,1(a5)
        p++;
    4e10:	0785                	addi	a5,a5,1
    while (*p)
    4e12:	ff6d                	bnez	a4,4e0c <strlcat+0x14>
    return (size_t)(p - s);
    4e14:	40b784b3          	sub	s1,a5,a1
    size_t dst_len = 0;
    4e18:	4401                	li	s0,0
    size_t src_len = strlen(src);

    while (dst_len < size && dst[dst_len] != '\0')
    4e1a:	e609                	bnez	a2,4e24 <strlcat+0x2c>
    4e1c:	a0a1                	j	4e64 <strlcat+0x6c>
        dst_len++;
    4e1e:	0405                	addi	s0,s0,1
    while (dst_len < size && dst[dst_len] != '\0')
    4e20:	04860263          	beq	a2,s0,4e64 <strlcat+0x6c>
    4e24:	00890533          	add	a0,s2,s0
    4e28:	00054783          	lbu	a5,0(a0)
    4e2c:	fbed                	bnez	a5,4e1e <strlcat+0x26>

    if (dst_len == size)
    4e2e:	02860b63          	beq	a2,s0,4e64 <strlcat+0x6c>
    4e32:	e44e                	sd	s3,8(sp)
        return size + src_len;

    size_t space_left = size - dst_len;
    4e34:	408607b3          	sub	a5,a2,s0
    size_t copy_len = (src_len >= space_left) ? space_left - 1 : src_len;
    4e38:	89a6                	mv	s3,s1
    4e3a:	02f4f263          	bgeu	s1,a5,4e5e <strlcat+0x66>

    memcpy(dst + dst_len, src, copy_len);
    dst[dst_len + copy_len] = '\0';
    4e3e:	994e                	add	s2,s2,s3
    4e40:	9922                	add	s2,s2,s0
    return memmove(vdst, vsrc, n);
    4e42:	864e                	mv	a2,s3
    4e44:	cadff0ef          	jal	4af0 <memmove>
    dst[dst_len + copy_len] = '\0';
    4e48:	00090023          	sb	zero,0(s2) # 1000 <_vscanf_core.constprop.0+0x688>

    return dst_len + src_len;
    4e4c:	00940533          	add	a0,s0,s1
}
    4e50:	70a2                	ld	ra,40(sp)
    4e52:	7402                	ld	s0,32(sp)
    return dst_len + src_len;
    4e54:	69a2                	ld	s3,8(sp)
}
    4e56:	64e2                	ld	s1,24(sp)
    4e58:	6942                	ld	s2,16(sp)
    4e5a:	6145                	addi	sp,sp,48
    4e5c:	8082                	ret
    size_t copy_len = (src_len >= space_left) ? space_left - 1 : src_len;
    4e5e:	fff78993          	addi	s3,a5,-1
    4e62:	bff1                	j	4e3e <strlcat+0x46>
}
    4e64:	70a2                	ld	ra,40(sp)
    4e66:	7402                	ld	s0,32(sp)
    4e68:	6942                	ld	s2,16(sp)
        return size + src_len;
    4e6a:	00960533          	add	a0,a2,s1
}
    4e6e:	64e2                	ld	s1,24(sp)
    4e70:	6145                	addi	sp,sp,48
    4e72:	8082                	ret
    while (*p)
    4e74:	4481                	li	s1,0
    4e76:	b74d                	j	4e18 <strlcat+0x20>

0000000000004e78 <strspn>:
size_t strspn(const char *s, const char *accept)
{
    const char *p = s;
    const char *a;

    while (*p)
    4e78:	00054683          	lbu	a3,0(a0)
    4e7c:	c695                	beqz	a3,4ea8 <strspn+0x30>
    {
        for (a = accept; *a; a++)
    4e7e:	0005c803          	lbu	a6,0(a1)
    4e82:	862a                	mv	a2,a0
    4e84:	00080f63          	beqz	a6,4ea2 <strspn+0x2a>
    4e88:	87ae                	mv	a5,a1
    4e8a:	8742                	mv	a4,a6
    4e8c:	a021                	j	4e94 <strspn+0x1c>
    4e8e:	0007c703          	lbu	a4,0(a5)
    4e92:	cb01                	beqz	a4,4ea2 <strspn+0x2a>
    4e94:	0785                	addi	a5,a5,1
        {
            if (*p == *a)
    4e96:	fee69ce3          	bne	a3,a4,4e8e <strspn+0x16>
    while (*p)
    4e9a:	00164683          	lbu	a3,1(a2)
                break;
        }
        if (*a == '\0')
            return (size_t)(p - s);
        p++;
    4e9e:	0605                	addi	a2,a2,1
    while (*p)
    4ea0:	f6e5                	bnez	a3,4e88 <strspn+0x10>
    }
    return (size_t)(p - s);
    4ea2:	40a60533          	sub	a0,a2,a0
    4ea6:	8082                	ret
    while (*p)
    4ea8:	4501                	li	a0,0
}
    4eaa:	8082                	ret

0000000000004eac <strcspn>:
size_t strcspn(const char *s, const char *reject)
{
    const char *p = s;
    const char *r;

    while (*p)
    4eac:	00054683          	lbu	a3,0(a0)
    4eb0:	ce85                	beqz	a3,4ee8 <strcspn+0x3c>
    {
        for (r = reject; *r; r++)
    4eb2:	0005c803          	lbu	a6,0(a1)
    const char *p = s;
    4eb6:	862a                	mv	a2,a0
        for (r = reject; *r; r++)
    4eb8:	02080363          	beqz	a6,4ede <strcspn+0x32>
    4ebc:	87ae                	mv	a5,a1
    4ebe:	8742                	mv	a4,a6
    4ec0:	a021                	j	4ec8 <strcspn+0x1c>
    4ec2:	0007c703          	lbu	a4,0(a5)
    4ec6:	c719                	beqz	a4,4ed4 <strcspn+0x28>
    4ec8:	0785                	addi	a5,a5,1
        {
            if (*p == *r)
    4eca:	fed71ce3          	bne	a4,a3,4ec2 <strcspn+0x16>
                return (size_t)(p - s);
        }
        p++;
    }
    return (size_t)(p - s);
    4ece:	40a60533          	sub	a0,a2,a0
    4ed2:	8082                	ret
    while (*p)
    4ed4:	00164683          	lbu	a3,1(a2)
        p++;
    4ed8:	0605                	addi	a2,a2,1
    while (*p)
    4eda:	f2ed                	bnez	a3,4ebc <strcspn+0x10>
    4edc:	bfcd                	j	4ece <strcspn+0x22>
    4ede:	00164683          	lbu	a3,1(a2)
        p++;
    4ee2:	0605                	addi	a2,a2,1
    while (*p)
    4ee4:	feed                	bnez	a3,4ede <strcspn+0x32>
    4ee6:	b7e5                	j	4ece <strcspn+0x22>
    4ee8:	4501                	li	a0,0
}
    4eea:	8082                	ret

0000000000004eec <strpbrk>:

char *strpbrk(const char *s, const char *accept)
{
    const char *a;
    while (*s)
    4eec:	00054683          	lbu	a3,0(a0)
    4ef0:	c295                	beqz	a3,4f14 <strpbrk+0x28>
    {
        for (a = accept; *a; a++)
    4ef2:	0005c603          	lbu	a2,0(a1)
    4ef6:	c20d                	beqz	a2,4f18 <strpbrk+0x2c>
    4ef8:	87ae                	mv	a5,a1
    4efa:	8732                	mv	a4,a2
    4efc:	a021                	j	4f04 <strpbrk+0x18>
    4efe:	0007c703          	lbu	a4,0(a5)
    4f02:	c709                	beqz	a4,4f0c <strpbrk+0x20>
    4f04:	0785                	addi	a5,a5,1
        {
            if (*s == *a)
    4f06:	fed71ce3          	bne	a4,a3,4efe <strpbrk+0x12>
                return (char *)s;
        }
        s++;
    }
    return NULL;
}
    4f0a:	8082                	ret
    while (*s)
    4f0c:	00154683          	lbu	a3,1(a0)
        s++;
    4f10:	0505                	addi	a0,a0,1
    while (*s)
    4f12:	f2fd                	bnez	a3,4ef8 <strpbrk+0xc>
    return NULL;
    4f14:	4501                	li	a0,0
}
    4f16:	8082                	ret
    while (*s)
    4f18:	00154683          	lbu	a3,1(a0)
        s++;
    4f1c:	0505                	addi	a0,a0,1
    while (*s)
    4f1e:	feed                	bnez	a3,4f18 <strpbrk+0x2c>
    4f20:	bfd5                	j	4f14 <strpbrk+0x28>

0000000000004f22 <strtok>:
char *strtok(char *str, const char *delim)
{
    static char *olds;
    char *token;

    if (str == NULL)
    4f22:	00003897          	auipc	a7,0x3
    4f26:	94e88893          	addi	a7,a7,-1714 # 7870 <olds.0>
    4f2a:	cd25                	beqz	a0,4fa2 <strtok+0x80>
    while (*p)
    4f2c:	00054683          	lbu	a3,0(a0)
    4f30:	c295                	beqz	a3,4f54 <strtok+0x32>
        for (a = accept; *a; a++)
    4f32:	0005c803          	lbu	a6,0(a1)
    4f36:	02080463          	beqz	a6,4f5e <strtok+0x3c>
    4f3a:	87ae                	mv	a5,a1
    4f3c:	8742                	mv	a4,a6
    4f3e:	a021                	j	4f46 <strtok+0x24>
    4f40:	0007c703          	lbu	a4,0(a5)
    4f44:	cf09                	beqz	a4,4f5e <strtok+0x3c>
    4f46:	0785                	addi	a5,a5,1
            if (*p == *a)
    4f48:	fee69ce3          	bne	a3,a4,4f40 <strtok+0x1e>
    while (*p)
    4f4c:	00154683          	lbu	a3,1(a0)
        p++;
    4f50:	0505                	addi	a0,a0,1
    while (*p)
    4f52:	f6e5                	bnez	a3,4f3a <strtok+0x18>
    4f54:	87aa                	mv	a5,a0
        str = olds;

    str += strspn(str, delim);
    if (*str == '\0')
    {
        olds = str;
    4f56:	00f8b023          	sd	a5,0(a7)
        return NULL;
    4f5a:	4501                	li	a0,0
        *str = '\0';
        olds = str + 1;
    }

    return token;
}
    4f5c:	8082                	ret
    if (*str == '\0')
    4f5e:	00054603          	lbu	a2,0(a0)
    4f62:	da6d                	beqz	a2,4f54 <strtok+0x32>
    4f64:	86aa                	mv	a3,a0
        for (a = accept; *a; a++)
    4f66:	04080163          	beqz	a6,4fa8 <strtok+0x86>
    4f6a:	8742                	mv	a4,a6
    4f6c:	87ae                	mv	a5,a1
    4f6e:	a021                	j	4f76 <strtok+0x54>
    4f70:	0007c703          	lbu	a4,0(a5)
    4f74:	cb19                	beqz	a4,4f8a <strtok+0x68>
    4f76:	0785                	addi	a5,a5,1
            if (*s == *a)
    4f78:	fee61ce3          	bne	a2,a4,4f70 <strtok+0x4e>
        olds = str + 1;
    4f7c:	00168793          	addi	a5,a3,1
        *str = '\0';
    4f80:	00068023          	sb	zero,0(a3)
        olds = str;
    4f84:	00f8b023          	sd	a5,0(a7)
}
    4f88:	8082                	ret
    while (*s)
    4f8a:	0016c603          	lbu	a2,1(a3)
        s++;
    4f8e:	0685                	addi	a3,a3,1
    while (*s)
    4f90:	fe69                	bnez	a2,4f6a <strtok+0x48>
    4f92:	87aa                	mv	a5,a0
    while (*s != (char)c)
    4f94:	0017c703          	lbu	a4,1(a5)
        if (!*s++)
    4f98:	0785                	addi	a5,a5,1
    while (*s != (char)c)
    4f9a:	ff6d                	bnez	a4,4f94 <strtok+0x72>
        olds = str;
    4f9c:	00f8b023          	sd	a5,0(a7)
}
    4fa0:	8082                	ret
        str = olds;
    4fa2:	0008b503          	ld	a0,0(a7)
    4fa6:	b759                	j	4f2c <strtok+0xa>
    while (*s)
    4fa8:	0016c603          	lbu	a2,1(a3)
        s++;
    4fac:	0685                	addi	a3,a3,1
    while (*s)
    4fae:	fe6d                	bnez	a2,4fa8 <strtok+0x86>
    4fb0:	b7cd                	j	4f92 <strtok+0x70>

0000000000004fb2 <strerror>:

char *strerror(int errnum)
{
    4fb2:	87aa                	mv	a5,a0
    
    switch (errnum)
    4fb4:	cd09                	beqz	a0,4fce <strerror+0x1c>
    4fb6:	4731                	li	a4,12
    4fb8:	00000517          	auipc	a0,0x0
    4fbc:	1b050513          	addi	a0,a0,432 # 5168 <_GLOBAL__sub_I__ZSt3cin+0x178>
    4fc0:	00e78b63          	beq	a5,a4,4fd6 <strerror+0x24>
        return "Success";
    // case EINVAL: return "Invalid argument";
    case ENOMEM: return "Out of memory";
    
    default:
        return "Unknown error";
    4fc4:	00000517          	auipc	a0,0x0
    4fc8:	1b450513          	addi	a0,a0,436 # 5178 <_GLOBAL__sub_I__ZSt3cin+0x188>
    4fcc:	8082                	ret
        return "Success";
    4fce:	00000517          	auipc	a0,0x0
    4fd2:	19250513          	addi	a0,a0,402 # 5160 <_GLOBAL__sub_I__ZSt3cin+0x170>
    }
    4fd6:	8082                	ret

0000000000004fd8 <_Znwm>:
#include "ulib/stdlib.h"

void *operator new(unsigned long n)
{
    return malloc(n);
    4fd8:	cf6ff06f          	j	44ce <malloc>

0000000000004fdc <_Znam>:
}

void *operator new[](unsigned long n)
    4fdc:	cf2ff06f          	j	44ce <malloc>

0000000000004fe0 <_ZdlPv>:
    return malloc(n);
}

void operator delete(void *p)
{
    free(p);
    4fe0:	c78ff06f          	j	4458 <free>

0000000000004fe4 <_ZdaPv>:
}

void operator delete[](void *p)
    4fe4:	c74ff06f          	j	4458 <free>

0000000000004fe8 <_ZdlPvm>:
    free(p);
}

void operator delete(void *p, unsigned long)
{
    free(p);
    4fe8:	c70ff06f          	j	4458 <free>

0000000000004fec <_ZdaPvm>:
}

void operator delete[](void *p, unsigned long)
    4fec:	c6cff06f          	j	4458 <free>

0000000000004ff0 <_GLOBAL__sub_I__ZSt3cin>:
#include "ulib/iostream"

namespace std
{
    istream cin(stdin);
    4ff0:	00002797          	auipc	a5,0x2
    4ff4:	7307b783          	ld	a5,1840(a5) # 7720 <_GLOBAL_OFFSET_TABLE_+0x10>
    4ff8:	6390                	ld	a2,0(a5)
    ostream cout(stdout);
    4ffa:	00002797          	auipc	a5,0x2
    4ffe:	71e7b783          	ld	a5,1822(a5) # 7718 <_GLOBAL_OFFSET_TABLE_+0x8>
    5002:	6394                	ld	a3,0(a5)
    ostream cerr(stderr);
    5004:	00002797          	auipc	a5,0x2
    5008:	7247b783          	ld	a5,1828(a5) # 7728 <_GLOBAL_OFFSET_TABLE_+0x18>
    500c:	6398                	ld	a4,0(a5)

    class istream{
    private:
        FILE* _stream;
    public:
        istream(FILE *f) : _stream(f) {}
    500e:	00003797          	auipc	a5,0x3
    5012:	86a78793          	addi	a5,a5,-1942 # 7878 <_ZSt3cin>
    5016:	e390                	sd	a2,0(a5)
        ostream(FILE* f) : _stream(f) {}
    5018:	e794                	sd	a3,8(a5)
    501a:	eb98                	sd	a4,16(a5)
} // namespace std
    501c:	8082                	ret
