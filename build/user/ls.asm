
build/user/ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <_Z8fmt_namePcPKc>:
void fmt_name(char *dst, const char *src)
{
    int i;
    char *d = dst;

    for (i = 0; i < 8; i++)
       0:	872e                	mv	a4,a1
       2:	00850613          	addi	a2,a0,8
    char *d = dst;
       6:	87aa                	mv	a5,a0
    {
        if (src[i] == ' ')
       8:	02000813          	li	a6,32
       c:	00074683          	lbu	a3,0(a4)
    for (i = 0; i < 8; i++)
      10:	0705                	addi	a4,a4,1
        if (src[i] == ' ')
      12:	07068663          	beq	a3,a6,7e <_Z8fmt_namePcPKc+0x7e>
            break;
        *d++ = src[i];
      16:	0785                	addi	a5,a5,1
      18:	fed78fa3          	sb	a3,-1(a5)
    for (i = 0; i < 8; i++)
      1c:	fec798e3          	bne	a5,a2,c <_Z8fmt_namePcPKc+0xc>
    }

    if (src[8] != ' ')
      20:	0085c703          	lbu	a4,8(a1)
      24:	02000793          	li	a5,32
      28:	02f70663          	beq	a4,a5,54 <_Z8fmt_namePcPKc+0x54>
    {
        *d++ = '.';
      2c:	02e00713          	li	a4,46
      30:	00160793          	addi	a5,a2,1
      34:	00e60023          	sb	a4,0(a2)
        for (i = 8; i < 11; i++)
      38:	05a1                	addi	a1,a1,8
      3a:	0611                	addi	a2,a2,4
        {
            if (src[i] == ' ')
      3c:	02000693          	li	a3,32
      40:	0005c703          	lbu	a4,0(a1)
        for (i = 8; i < 11; i++)
      44:	0585                	addi	a1,a1,1
            if (src[i] == ' ')
      46:	02d70e63          	beq	a4,a3,82 <_Z8fmt_namePcPKc+0x82>
                break;
            *d++ = src[i];
      4a:	0785                	addi	a5,a5,1
      4c:	fee78fa3          	sb	a4,-1(a5)
        for (i = 8; i < 11; i++)
      50:	fef618e3          	bne	a2,a5,40 <_Z8fmt_namePcPKc+0x40>
        }
    }
    *d = 0;
      54:	00060023          	sb	zero,0(a2)

    for (d = dst; *d; d++)
      58:	00054783          	lbu	a5,0(a0)
      5c:	c385                	beqz	a5,7c <_Z8fmt_namePcPKc+0x7c>
    {
        if (*d >= 'A' && *d <= 'Z')
      5e:	46e5                	li	a3,25
      60:	fbf7871b          	addiw	a4,a5,-65
      64:	0ff77713          	zext.b	a4,a4
            *d += 32;
      68:	0207879b          	addiw	a5,a5,32
        if (*d >= 'A' && *d <= 'Z')
      6c:	00e6e463          	bltu	a3,a4,74 <_Z8fmt_namePcPKc+0x74>
            *d += 32;
      70:	00f50023          	sb	a5,0(a0)
    for (d = dst; *d; d++)
      74:	00154783          	lbu	a5,1(a0)
      78:	0505                	addi	a0,a0,1
      7a:	f3fd                	bnez	a5,60 <_Z8fmt_namePcPKc+0x60>
    }
}
      7c:	8082                	ret
      7e:	863e                	mv	a2,a5
      80:	b745                	j	20 <_Z8fmt_namePcPKc+0x20>
      82:	863e                	mv	a2,a5
      84:	bfc1                	j	54 <_Z8fmt_namePcPKc+0x54>

0000000000000086 <_Z2lsPKc>:

void ls(const char *path)
{
      86:	7119                	addi	sp,sp,-128
    int fd;
    struct FAT32_DirEnt de;
    char name_buf[16];

    if ((fd = open(path, O_RDONLY)) < 0)
      88:	4581                	li	a1,0
{
      8a:	f0ca                	sd	s2,96(sp)
      8c:	fc86                	sd	ra,120(sp)
      8e:	892a                	mv	s2,a0
    if ((fd = open(path, O_RDONLY)) < 0)
      90:	156000ef          	jal	1e6 <open>
      94:	08054e63          	bltz	a0,130 <_Z2lsPKc+0xaa>
      98:	f8a2                	sd	s0,112(sp)
      9a:	f4a6                	sd	s1,104(sp)
      9c:	ecce                	sd	s3,88(sp)
      9e:	e8d2                	sd	s4,80(sp)
      a0:	e4d6                	sd	s5,72(sp)
      a2:	e0da                	sd	s6,64(sp)
      a4:	fc5e                	sd	s7,56(sp)
      a6:	84aa                	mv	s1,a0
      a8:	0800                	addi	s0,sp,16
        if (de.name[0] == 0)
        {
            break;
        }

        if ((unsigned char)de.name[0] == 0xE5)
      aa:	0e500993          	li	s3,229
        {
            continue;
        }

        if ((de.attr & ATTR_LONG_NAME) == ATTR_LONG_NAME)
      ae:	4a3d                	li	s4,15
        {
            continue;
        }

        fmt_name(name_buf, de.name);
      b0:	890a                	mv	s2,sp

        printf("%s %d\t%s\n",
      b2:	00005b17          	auipc	s6,0x5
      b6:	05eb0b13          	addi	s6,s6,94 # 5110 <_GLOBAL__sub_I__ZSt3cin+0x4a>
      ba:	00005a97          	auipc	s5,0x5
      be:	076a8a93          	addi	s5,s5,118 # 5130 <_GLOBAL__sub_I__ZSt3cin+0x6a>
      c2:	00005b97          	auipc	s7,0x5
      c6:	03eb8b93          	addi	s7,s7,62 # 5100 <_GLOBAL__sub_I__ZSt3cin+0x3a>
    while (read(fd, &de, sizeof(de)) == sizeof(de))
      ca:	85a2                	mv	a1,s0
      cc:	02000613          	li	a2,32
      d0:	8526                	mv	a0,s1
      d2:	0ec000ef          	jal	1be <read>
      d6:	872a                	mv	a4,a0
      d8:	02000793          	li	a5,32
        fmt_name(name_buf, de.name);
      dc:	85a2                	mv	a1,s0
      de:	854a                	mv	a0,s2
    while (read(fd, &de, sizeof(de)) == sizeof(de))
      e0:	02f71a63          	bne	a4,a5,114 <_Z2lsPKc+0x8e>
        if (de.name[0] == 0)
      e4:	01014783          	lbu	a5,16(sp)
      e8:	c795                	beqz	a5,114 <_Z2lsPKc+0x8e>
        if ((unsigned char)de.name[0] == 0xE5)
      ea:	ff3780e3          	beq	a5,s3,ca <_Z2lsPKc+0x44>
        if ((de.attr & ATTR_LONG_NAME) == ATTR_LONG_NAME)
      ee:	01b14783          	lbu	a5,27(sp)
      f2:	8bbd                	andi	a5,a5,15
      f4:	fd478be3          	beq	a5,s4,ca <_Z2lsPKc+0x44>
        fmt_name(name_buf, de.name);
      f8:	f09ff0ef          	jal	0 <_Z8fmt_namePcPKc>
        printf("%s %d\t%s\n",
      fc:	01b14783          	lbu	a5,27(sp)
     100:	86ca                	mv	a3,s2
     102:	8556                	mv	a0,s5
     104:	8bc1                	andi	a5,a5,16
     106:	85da                	mv	a1,s6
     108:	c391                	beqz	a5,10c <_Z2lsPKc+0x86>
     10a:	85de                	mv	a1,s7
     10c:	5632                	lw	a2,44(sp)
     10e:	0c3030ef          	jal	39d0 <printf>
     112:	bf65                	j	ca <_Z2lsPKc+0x44>
               (de.attr & ATTR_DIRECTORY) ? "<DIR>" : "     ",
               de.fileSize,
               name_buf);
    }

    close(fd);
     114:	8526                	mv	a0,s1
     116:	0b8000ef          	jal	1ce <close>
}
     11a:	70e6                	ld	ra,120(sp)
    close(fd);
     11c:	7446                	ld	s0,112(sp)
     11e:	74a6                	ld	s1,104(sp)
     120:	69e6                	ld	s3,88(sp)
     122:	6a46                	ld	s4,80(sp)
     124:	6aa6                	ld	s5,72(sp)
     126:	6b06                	ld	s6,64(sp)
     128:	7be2                	ld	s7,56(sp)
}
     12a:	7906                	ld	s2,96(sp)
     12c:	6109                	addi	sp,sp,128
     12e:	8082                	ret
     130:	70e6                	ld	ra,120(sp)
        printf("ls: cannot open %s\n", path);
     132:	85ca                	mv	a1,s2
}
     134:	7906                	ld	s2,96(sp)
        printf("ls: cannot open %s\n", path);
     136:	00005517          	auipc	a0,0x5
     13a:	fe250513          	addi	a0,a0,-30 # 5118 <_GLOBAL__sub_I__ZSt3cin+0x52>
}
     13e:	6109                	addi	sp,sp,128
        printf("ls: cannot open %s\n", path);
     140:	0910306f          	j	39d0 <printf>

0000000000000144 <main>:

int main(int argc, char *argv[])
{
     144:	1101                	addi	sp,sp,-32
     146:	ec06                	sd	ra,24(sp)
    if (argc < 2)
     148:	4785                	li	a5,1
     14a:	02a7de63          	bge	a5,a0,186 <main+0x42>
     14e:	e426                	sd	s1,8(sp)
     150:	ffe5049b          	addiw	s1,a0,-2
     154:	02049793          	slli	a5,s1,0x20
     158:	01d7d493          	srli	s1,a5,0x1d
     15c:	01058793          	addi	a5,a1,16
     160:	e822                	sd	s0,16(sp)
     162:	94be                	add	s1,s1,a5
     164:	00858413          	addi	s0,a1,8
    }
    else
    {
        for (int i = 1; i < argc; i++)
        {
            ls(argv[i]);
     168:	6008                	ld	a0,0(s0)
        for (int i = 1; i < argc; i++)
     16a:	0421                	addi	s0,s0,8
            ls(argv[i]);
     16c:	f1bff0ef          	jal	86 <_Z2lsPKc>
        for (int i = 1; i < argc; i++)
     170:	fe941ce3          	bne	s0,s1,168 <main+0x24>
     174:	6442                	ld	s0,16(sp)
     176:	64a2                	ld	s1,8(sp)
        }
    }
    exit(0);
     178:	4501                	li	a0,0
     17a:	36a040ef          	jal	44e4 <exit>
     17e:	60e2                	ld	ra,24(sp)
     180:	4501                	li	a0,0
     182:	6105                	addi	sp,sp,32
     184:	8082                	ret
        ls(".");
     186:	00005517          	auipc	a0,0x5
     18a:	fba50513          	addi	a0,a0,-70 # 5140 <_GLOBAL__sub_I__ZSt3cin+0x7a>
     18e:	ef9ff0ef          	jal	86 <_Z2lsPKc>
     192:	b7dd                	j	178 <main+0x34>

0000000000000194 <_start>:
.global _start

_start:


    call main
     194:	fb1ff0ef          	jal	144 <main>

    call exit
     198:	34c040ef          	jal	44e4 <exit>

     19c:	a001                	j	19c <_start+0x8>

000000000000019e <sys_exit>:
    name: \
        li a7, SYS_ ## sysname; \
        ecall; \
        ret

SYSCALL_NAME(sys_exit, exit) 
     19e:	488d                	li	a7,3
     1a0:	00000073          	ecall
     1a4:	8082                	ret

00000000000001a6 <fork>:

SYSCALL(fork)
     1a6:	4889                	li	a7,2
     1a8:	00000073          	ecall
     1ac:	8082                	ret

00000000000001ae <wait>:
SYSCALL(wait)
     1ae:	4891                	li	a7,4
     1b0:	00000073          	ecall
     1b4:	8082                	ret

00000000000001b6 <pipe>:
SYSCALL(pipe)
     1b6:	4895                	li	a7,5
     1b8:	00000073          	ecall
     1bc:	8082                	ret

00000000000001be <read>:
SYSCALL(read)
     1be:	4899                	li	a7,6
     1c0:	00000073          	ecall
     1c4:	8082                	ret

00000000000001c6 <write>:
SYSCALL(write)
     1c6:	48c5                	li	a7,17
     1c8:	00000073          	ecall
     1cc:	8082                	ret

00000000000001ce <close>:
SYSCALL(close)
     1ce:	48d9                	li	a7,22
     1d0:	00000073          	ecall
     1d4:	8082                	ret

00000000000001d6 <kill>:
SYSCALL(kill)
     1d6:	489d                	li	a7,7
     1d8:	00000073          	ecall
     1dc:	8082                	ret

00000000000001de <exec>:
SYSCALL(exec)
     1de:	48a1                	li	a7,8
     1e0:	00000073          	ecall
     1e4:	8082                	ret

00000000000001e6 <open>:
SYSCALL(open)
     1e6:	48c1                	li	a7,16
     1e8:	00000073          	ecall
     1ec:	8082                	ret

00000000000001ee <mknod>:
SYSCALL(mknod)
     1ee:	48c9                	li	a7,18
     1f0:	00000073          	ecall
     1f4:	8082                	ret

00000000000001f6 <unlink>:
SYSCALL(unlink)
     1f6:	48cd                	li	a7,19
     1f8:	00000073          	ecall
     1fc:	8082                	ret

00000000000001fe <fstat>:
SYSCALL(fstat)
     1fe:	48a5                	li	a7,9
     200:	00000073          	ecall
     204:	8082                	ret

0000000000000206 <link>:
SYSCALL(link)
     206:	48d1                	li	a7,20
     208:	00000073          	ecall
     20c:	8082                	ret

000000000000020e <mkdir>:
SYSCALL(mkdir)
     20e:	48d5                	li	a7,21
     210:	00000073          	ecall
     214:	8082                	ret

0000000000000216 <chdir>:
SYSCALL(chdir)
     216:	48a9                	li	a7,10
     218:	00000073          	ecall
     21c:	8082                	ret

000000000000021e <dup>:
SYSCALL(dup)
     21e:	48ad                	li	a7,11
     220:	00000073          	ecall
     224:	8082                	ret

0000000000000226 <getpid>:
SYSCALL(getpid)
     226:	48b1                	li	a7,12
     228:	00000073          	ecall
     22c:	8082                	ret

000000000000022e <sbrk>:
SYSCALL(sbrk)
     22e:	48b5                	li	a7,13
     230:	00000073          	ecall
     234:	8082                	ret

0000000000000236 <sleep>:
SYSCALL(sleep)
     236:	48b9                	li	a7,14
     238:	00000073          	ecall
     23c:	8082                	ret

000000000000023e <uptime>:
SYSCALL(uptime)
     23e:	48bd                	li	a7,15
     240:	00000073          	ecall
     244:	8082                	ret

0000000000000246 <putc>:
SYSCALL(putc)
     246:	4885                	li	a7,1
     248:	00000073          	ecall
     24c:	8082                	ret

000000000000024e <disk_test>:
SYSCALL(disk_test)
     24e:	48dd                	li	a7,23
     250:	00000073          	ecall
     254:	8082                	ret

0000000000000256 <lseek>:
SYSCALL(lseek)
     256:	48e1                	li	a7,24
     258:	00000073          	ecall
     25c:	8082                	ret

000000000000025e <shutdown>:
     25e:	48e5                	li	a7,25
     260:	00000073          	ecall
     264:	8082                	ret

0000000000000266 <stbsp__clamp_callback>:
     266:	45dc                	lw	a5,12(a1)
     268:	4598                	lw	a4,8(a1)
     26a:	9fb1                	addw	a5,a5,a2
     26c:	c5dc                	sw	a5,12(a1)
     26e:	0007069b          	sext.w	a3,a4
     272:	00e65463          	bge	a2,a4,27a <stbsp__clamp_callback+0x14>
     276:	0006069b          	sext.w	a3,a2
     27a:	c685                	beqz	a3,2a2 <stbsp__clamp_callback+0x3c>
     27c:	619c                	ld	a5,0(a1)
     27e:	00a78e63          	beq	a5,a0,29a <stbsp__clamp_callback+0x34>
     282:	00d50633          	add	a2,a0,a3
     286:	00054703          	lbu	a4,0(a0)
     28a:	0505                	addi	a0,a0,1
     28c:	0785                	addi	a5,a5,1
     28e:	fee78fa3          	sb	a4,-1(a5)
     292:	fec56ae3          	bltu	a0,a2,286 <stbsp__clamp_callback+0x20>
     296:	6188                	ld	a0,0(a1)
     298:	4598                	lw	a4,8(a1)
     29a:	9f15                	subw	a4,a4,a3
     29c:	9536                	add	a0,a0,a3
     29e:	e188                	sd	a0,0(a1)
     2a0:	c598                	sw	a4,8(a1)
     2a2:	1ff00793          	li	a5,511
     2a6:	00e7d463          	bge	a5,a4,2ae <stbsp__clamp_callback+0x48>
     2aa:	6188                	ld	a0,0(a1)
     2ac:	8082                	ret
     2ae:	01058513          	addi	a0,a1,16
     2b2:	8082                	ret

00000000000002b4 <stbsp__count_clamp_callback>:
     2b4:	45dc                	lw	a5,12(a1)
     2b6:	01058513          	addi	a0,a1,16
     2ba:	9fb1                	addw	a5,a5,a2
     2bc:	c5dc                	sw	a5,12(a1)
     2be:	8082                	ret

00000000000002c0 <stbsp__real_to_str>:
     2c0:	e20508d3          	fmv.x.d	a7,fa0
     2c4:	82aa                	mv	t0,a0
     2c6:	4348d813          	srai	a6,a7,0x34
     2ca:	8ec6                	mv	t4,a7
     2cc:	7ff87813          	andi	a6,a6,2047
     2d0:	8346                	mv	t1,a7
     2d2:	03f8d513          	srli	a0,a7,0x3f
     2d6:	0008d663          	bgez	a7,2e2 <stbsp__real_to_str+0x22>
     2da:	22a517d3          	fneg.d	fa5,fa0
     2de:	e20788d3          	fmv.x.d	a7,fa5
     2e2:	7ff00e13          	li	t3,2047
     2e6:	35c80663          	beq	a6,t3,632 <stbsp__real_to_str+0x372>
     2ea:	1101                	addi	sp,sp,-32
     2ec:	14080363          	beqz	a6,432 <stbsp__real_to_str+0x172>
     2f0:	c018081b          	addiw	a6,a6,-1023
     2f4:	ec22                	sd	s0,24(sp)
     2f6:	02081313          	slli	t1,a6,0x20
     2fa:	66034d63          	bltz	t1,974 <stbsp__real_to_str+0x6b4>
     2fe:	4d100313          	li	t1,1233
     302:	0303033b          	mulw	t1,t1,a6
     306:	4849                	li	a6,18
     308:	40c3531b          	sraiw	t1,t1,0xc
     30c:	0013039b          	addiw	t2,t1,1
     310:	4078083b          	subw	a6,a6,t2
     314:	4359                	li	t1,22
     316:	17036163          	bltu	t1,a6,478 <stbsp__real_to_str+0x1b8>
     31a:	00005317          	auipc	t1,0x5
     31e:	16630313          	addi	t1,t1,358 # 5480 <stbsp__bot>
     322:	080e                	slli	a6,a6,0x3
     324:	981a                	add	a6,a6,t1
     326:	00083e03          	ld	t3,0(a6)
     32a:	00083607          	fld	fa2,0(a6)
     32e:	f20887d3          	fmv.d.x	fa5,a7
     332:	f8000837          	lui	a6,0xf8000
     336:	01187333          	and	t1,a6,a7
     33a:	01c87833          	and	a6,a6,t3
     33e:	12f676d3          	fmul.d	fa3,fa2,fa5
     342:	f20807d3          	fmv.d.x	fa5,a6
     346:	f2030753          	fmv.d.x	fa4,t1
     34a:	f20305d3          	fmv.d.x	fa1,t1
     34e:	0af67653          	fsub.d	fa2,fa2,fa5
     352:	f20887d3          	fmv.d.x	fa5,a7
     356:	0ae7f753          	fsub.d	fa4,fa5,fa4
     35a:	f20807d3          	fmv.d.x	fa5,a6
     35e:	6ab7f7c7          	fmsub.d	fa5,fa5,fa1,fa3
     362:	7ab677c3          	fmadd.d	fa5,fa2,fa1,fa5
     366:	f20805d3          	fmv.d.x	fa1,a6
     36a:	7ab777c3          	fmadd.d	fa5,fa4,fa1,fa5
     36e:	7ac77743          	fmadd.d	fa4,fa4,fa2,fa5
     372:	02d777d3          	fadd.d	fa5,fa4,fa3
     376:	3782e837          	lui	a6,0x3782e
     37a:	acf80813          	addi	a6,a6,-1329 # 3782dacf <_ZSt4cerr+0x37826157>
     37e:	0832                	slli	a6,a6,0xc
     380:	9d980813          	addi	a6,a6,-1575
     384:	084a                	slli	a6,a6,0x12
     386:	187d                	addi	a6,a6,-1
     388:	c22798d3          	fcvt.l.d	a7,fa5,rtz
     38c:	0ad7f6d3          	fsub.d	fa3,fa5,fa3
     390:	00070e1b          	sext.w	t3,a4
     394:	d228f653          	fcvt.d.l	fa2,a7
     398:	0ac7f5d3          	fsub.d	fa1,fa5,fa2
     39c:	0ad77753          	fsub.d	fa4,fa4,fa3
     3a0:	0af5f6d3          	fsub.d	fa3,fa1,fa5
     3a4:	0ad5f553          	fsub.d	fa0,fa1,fa3
     3a8:	02d67653          	fadd.d	fa2,fa2,fa3
     3ac:	0aa7f7d3          	fsub.d	fa5,fa5,fa0
     3b0:	0ac7f7d3          	fsub.d	fa5,fa5,fa2
     3b4:	02b7f7d3          	fadd.d	fa5,fa5,fa1
     3b8:	02e7f7d3          	fadd.d	fa5,fa5,fa4
     3bc:	c2279fd3          	fcvt.l.d	t6,fa5,rtz
     3c0:	9fc6                	add	t6,t6,a7
     3c2:	19f87063          	bgeu	a6,t6,542 <stbsp__real_to_str+0x282>
     3c6:	2385                	addiw	t2,t2,1
     3c8:	300e4363          	bltz	t3,6ce <stbsp__real_to_str+0x40e>
     3cc:	00e3833b          	addw	t1,t2,a4
     3d0:	475d                	li	a4,23
     3d2:	30677663          	bgeu	a4,t1,6de <stbsp__real_to_str+0x41e>
     3d6:	577d                	li	a4,-1
     3d8:	9301                	srli	a4,a4,0x20
     3da:	43f75863          	bge	a4,t6,80a <stbsp__real_to_str+0x54a>
     3de:	07d00313          	li	t1,125
     3e2:	877e                	mv	a4,t6
     3e4:	4e01                	li	t3,0
     3e6:	3e800813          	li	a6,1000
     3ea:	130e                	slli	t1,t1,0x23
     3ec:	a039                	j	3fa <stbsp__real_to_str+0x13a>
     3ee:	030747b3          	div	a5,a4,a6
     3f2:	4e05                	li	t3,1
     3f4:	40674c63          	blt	a4,t1,80c <stbsp__real_to_str+0x54c>
     3f8:	873e                	mv	a4,a5
     3fa:	030768b3          	rem	a7,a4,a6
     3fe:	fe0888e3          	beqz	a7,3ee <stbsp__real_to_str+0x12e>
     402:	400e0163          	beqz	t3,804 <stbsp__real_to_str+0x544>
     406:	8fbe                	mv	t6,a5
     408:	05f5e7b7          	lui	a5,0x5f5e
     40c:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f56787>
     410:	04060413          	addi	s0,a2,64
     414:	03860613          	addi	a2,a2,56
     418:	15f7c863          	blt	a5,t6,568 <stbsp__real_to_str+0x2a8>
     41c:	000f871b          	sext.w	a4,t6
     420:	20070463          	beqz	a4,628 <stbsp__real_to_str+0x368>
     424:	4f01                	li	t5,0
     426:	4f81                	li	t6,0
     428:	00006e97          	auipc	t4,0x6
     42c:	658e8e93          	addi	t4,t4,1624 # 6a80 <stbsp__digitpair>
     430:	aaa9                	j	58a <stbsp__real_to_str+0x2ca>
     432:	0306                	slli	t1,t1,0x1
     434:	3e030e63          	beqz	t1,830 <stbsp__real_to_str+0x570>
     438:	4305                	li	t1,1
     43a:	ec22                	sd	s0,24(sp)
     43c:	00ce9e13          	slli	t3,t4,0xc
     440:	134e                	slli	t1,t1,0x33
     442:	520e4063          	bltz	t3,962 <stbsp__real_to_str+0x6a2>
     446:	40135313          	srai	t1,t1,0x1
     44a:	01d37e33          	and	t3,t1,t4
     44e:	8f42                	mv	t5,a6
     450:	387d                	addiw	a6,a6,-1
     452:	fe0e0ae3          	beqz	t3,446 <stbsp__real_to_str+0x186>
     456:	26900313          	li	t1,617
     45a:	c00f081b          	addiw	a6,t5,-1024
     45e:	0268083b          	mulw	a6,a6,t1
     462:	41f8531b          	sraiw	t1,a6,0x1f
     466:	0153531b          	srliw	t1,t1,0x15
     46a:	0103033b          	addw	t1,t1,a6
     46e:	40b3539b          	sraiw	t2,t1,0xb
     472:	4849                	li	a6,18
     474:	4078083b          	subw	a6,a6,t2
     478:	41f8531b          	sraiw	t1,a6,0x1f
     47c:	00684eb3          	xor	t4,a6,t1
     480:	406e8f3b          	subw	t5,t4,t1
     484:	2c900313          	li	t1,713
     488:	03e3033b          	mulw	t1,t1,t5
     48c:	4e35                	li	t3,13
     48e:	8efa                	mv	t4,t5
     490:	40e35f9b          	sraiw	t6,t1,0xe
     494:	837e                	mv	t1,t6
     496:	23fe4363          	blt	t3,t6,6bc <stbsp__real_to_str+0x3fc>
     49a:	5e25                	li	t3,-23
     49c:	026e0e3b          	mulw	t3,t3,t1
     4a0:	01de0ebb          	addw	t4,t3,t4
     4a4:	22084f63          	bltz	a6,6e2 <stbsp__real_to_str+0x422>
     4a8:	f2000753          	fmv.d.x	fa4,zero
     4ac:	00005e17          	auipc	t3,0x5
     4b0:	fd4e0e13          	addi	t3,t3,-44 # 5480 <stbsp__bot>
     4b4:	380e9e63          	bnez	t4,850 <stbsp__real_to_str+0x590>
     4b8:	f20887d3          	fmv.d.x	fa5,a7
     4bc:	fff30f1b          	addiw	t5,t1,-1
     4c0:	0f0e                	slli	t5,t5,0x3
     4c2:	02f777d3          	fadd.d	fa5,fa4,fa5
     4c6:	030e                	slli	t1,t1,0x3
     4c8:	9f72                	add	t5,t5,t3
     4ca:	9e1a                	add	t3,t3,t1
     4cc:	2e0e3e03          	ld	t3,736(t3)
     4d0:	2e8f3587          	fld	fa1,744(t5)
     4d4:	f8000837          	lui	a6,0xf8000
     4d8:	e2078ed3          	fmv.x.d	t4,fa5
     4dc:	12b7f6d3          	fmul.d	fa3,fa5,fa1
     4e0:	f2088653          	fmv.d.x	fa2,a7
     4e4:	01d87333          	and	t1,a6,t4
     4e8:	01c87833          	and	a6,a6,t3
     4ec:	f20807d3          	fmv.d.x	fa5,a6
     4f0:	f2030053          	fmv.d.x	ft0,t1
     4f4:	0af5f553          	fsub.d	fa0,fa1,fa5
     4f8:	f20e87d3          	fmv.d.x	fa5,t4
     4fc:	0ac7f0d3          	fsub.d	ft1,fa5,fa2
     500:	f20807d3          	fmv.d.x	fa5,a6
     504:	f2030653          	fmv.d.x	fa2,t1
     508:	6ac7f647          	fmsub.d	fa2,fa5,fa2,fa3
     50c:	f20e87d3          	fmv.d.x	fa5,t4
     510:	0a177753          	fsub.d	fa4,fa4,ft1
     514:	f20300d3          	fmv.d.x	ft1,t1
     518:	0a07f7d3          	fsub.d	fa5,fa5,ft0
     51c:	350f3007          	fld	ft0,848(t5)
     520:	62157643          	fmadd.d	fa2,fa0,ft1,fa2
     524:	12b77753          	fmul.d	fa4,fa4,fa1
     528:	f20805d3          	fmv.d.x	fa1,a6
     52c:	62b7f643          	fmadd.d	fa2,fa5,fa1,fa2
     530:	f20e85d3          	fmv.d.x	fa1,t4
     534:	7205f743          	fmadd.d	fa4,fa1,ft0,fa4
     538:	62a7f7c3          	fmadd.d	fa5,fa5,fa0,fa2
     53c:	02e7f753          	fadd.d	fa4,fa5,fa4
     540:	bd0d                	j	372 <stbsp__real_to_str+0xb2>
     542:	00e3833b          	addw	t1,t2,a4
     546:	2a0e4663          	bltz	t3,7f2 <stbsp__real_to_str+0x532>
     54a:	475d                	li	a4,23
     54c:	10677663          	bgeu	a4,t1,658 <stbsp__real_to_str+0x398>
     550:	e80f93e3          	bnez	t6,3d6 <stbsp__real_to_str+0x116>
     554:	05f5e7b7          	lui	a5,0x5f5e
     558:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f56787>
     55c:	04060413          	addi	s0,a2,64
     560:	03860613          	addi	a2,a2,56
     564:	ebf7dce3          	bge	a5,t6,41c <stbsp__real_to_str+0x15c>
     568:	4f01                	li	t5,0
     56a:	00006e97          	auipc	t4,0x6
     56e:	516e8e93          	addi	t4,t4,1302 # 6a80 <stbsp__digitpair>
     572:	05f5e7b7          	lui	a5,0x5f5e
     576:	10078793          	addi	a5,a5,256 # 5f5e100 <_ZSt4cerr+0x5f56788>
     57a:	02ffe833          	rem	a6,t6,a5
     57e:	02ffcfb3          	div	t6,t6,a5
     582:	0008071b          	sext.w	a4,a6
     586:	0a080463          	beqz	a6,62e <stbsp__real_to_str+0x36e>
     58a:	8822                	mv	a6,s0
     58c:	06400893          	li	a7,100
     590:	06300e13          	li	t3,99
     594:	1879                	addi	a6,a6,-2 # fffffffff7fffffe <_ZSt4cerr+0xfffffffff7ff8686>
     596:	0007031b          	sext.w	t1,a4
     59a:	031777bb          	remuw	a5,a4,a7
     59e:	2785                	addiw	a5,a5,1
     5a0:	0017979b          	slliw	a5,a5,0x1
     5a4:	1782                	slli	a5,a5,0x20
     5a6:	9381                	srli	a5,a5,0x20
     5a8:	97f6                	add	a5,a5,t4
     5aa:	0007d783          	lhu	a5,0(a5)
     5ae:	0317573b          	divuw	a4,a4,a7
     5b2:	00f81023          	sh	a5,0(a6)
     5b6:	fc6e6fe3          	bltu	t3,t1,594 <stbsp__real_to_str+0x2d4>
     5ba:	008f0f3b          	addw	t5,t5,s0
     5be:	410f0f3b          	subw	t5,t5,a6
     5c2:	020f8f63          	beqz	t6,600 <stbsp__real_to_str+0x340>
     5c6:	87c2                	mv	a5,a6
     5c8:	03000713          	li	a4,48
     5cc:	04c80c63          	beq	a6,a2,624 <stbsp__real_to_str+0x364>
     5d0:	17fd                	addi	a5,a5,-1
     5d2:	00e78023          	sb	a4,0(a5)
     5d6:	fec79de3          	bne	a5,a2,5d0 <stbsp__real_to_str+0x310>
     5da:	408807b3          	sub	a5,a6,s0
     5de:	00ff07bb          	addw	a5,t5,a5
     5e2:	1461                	addi	s0,s0,-8
     5e4:	00878f1b          	addiw	t5,a5,8
     5e8:	05f5e7b7          	lui	a5,0x5f5e
     5ec:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f56787>
     5f0:	ff840613          	addi	a2,s0,-8
     5f4:	f7f7cfe3          	blt	a5,t6,572 <stbsp__real_to_str+0x2b2>
     5f8:	000f871b          	sext.w	a4,t6
     5fc:	4f81                	li	t6,0
     5fe:	b771                	j	58a <stbsp__real_to_str+0x2ca>
     600:	020f0563          	beqz	t5,62a <stbsp__real_to_str+0x36a>
     604:	00084703          	lbu	a4,0(a6)
     608:	03000793          	li	a5,48
     60c:	22f70f63          	beq	a4,a5,84a <stbsp__real_to_str+0x58a>
     610:	2f01                	sext.w	t5,t5
     612:	0076a023          	sw	t2,0(a3)
     616:	6462                	ld	s0,24(sp)
     618:	0102b023          	sd	a6,0(t0)
     61c:	01e5a023          	sw	t5,0(a1)
     620:	6105                	addi	sp,sp,32
     622:	8082                	ret
     624:	8442                	mv	s0,a6
     626:	b7c9                	j	5e8 <stbsp__real_to_str+0x328>
     628:	8822                	mv	a6,s0
     62a:	4f01                	li	t5,0
     62c:	b7dd                	j	612 <stbsp__real_to_str+0x352>
     62e:	8822                	mv	a6,s0
     630:	bf59                	j	5c6 <stbsp__real_to_str+0x306>
     632:	0eb2                	slli	t4,t4,0xc
     634:	00005797          	auipc	a5,0x5
     638:	b1c78793          	addi	a5,a5,-1252 # 5150 <_GLOBAL__sub_I__ZSt3cin+0x8a>
     63c:	000e8663          	beqz	t4,648 <stbsp__real_to_str+0x388>
     640:	00005797          	auipc	a5,0x5
     644:	b0878793          	addi	a5,a5,-1272 # 5148 <_GLOBAL__sub_I__ZSt3cin+0x82>
     648:	00f2b023          	sd	a5,0(t0)
     64c:	679d                	lui	a5,0x7
     64e:	c29c                	sw	a5,0(a3)
     650:	4f0d                	li	t5,3
     652:	01e5a023          	sw	t5,0(a1)
     656:	8082                	ret
     658:	3b9ad737          	lui	a4,0x3b9ad
     65c:	9ff70713          	addi	a4,a4,-1537 # 3b9ac9ff <_ZSt4cerr+0x3b9a5087>
     660:	07f76f63          	bltu	a4,t6,6de <stbsp__real_to_str+0x41e>
     664:	4805                	li	a6,1
     666:	02081713          	slli	a4,a6,0x20
     66a:	01d75893          	srli	a7,a4,0x1d
     66e:	00005717          	auipc	a4,0x5
     672:	1ca70713          	addi	a4,a4,458 # 5838 <stbsp__powten>
     676:	9746                	add	a4,a4,a7
     678:	4e51                	li	t3,20
     67a:	a021                	j	682 <stbsp__real_to_str+0x3c2>
     67c:	2805                	addiw	a6,a6,1
     67e:	edc809e3          	beq	a6,t3,550 <stbsp__real_to_str+0x290>
     682:	00073883          	ld	a7,0(a4)
     686:	0721                	addi	a4,a4,8
     688:	ff1ffae3          	bgeu	t6,a7,67c <stbsp__real_to_str+0x3bc>
     68c:	ed0372e3          	bgeu	t1,a6,550 <stbsp__real_to_str+0x290>
     690:	4068083b          	subw	a6,a6,t1
     694:	475d                	li	a4,23
     696:	eb076de3          	bltu	a4,a6,550 <stbsp__real_to_str+0x290>
     69a:	080e                	slli	a6,a6,0x3
     69c:	00005717          	auipc	a4,0x5
     6a0:	de470713          	addi	a4,a4,-540 # 5480 <stbsp__bot>
     6a4:	9742                	add	a4,a4,a6
     6a6:	3b873803          	ld	a6,952(a4)
     6aa:	00185713          	srli	a4,a6,0x1
     6ae:	977e                	add	a4,a4,t6
     6b0:	01176363          	bltu	a4,a7,6b6 <stbsp__real_to_str+0x3f6>
     6b4:	2385                	addiw	t2,t2,1
     6b6:	03075fb3          	divu	t6,a4,a6
     6ba:	bd59                	j	550 <stbsp__real_to_str+0x290>
     6bc:	4335                	li	t1,13
     6be:	5e25                	li	t3,-23
     6c0:	026e0e3b          	mulw	t3,t3,t1
     6c4:	01de0ebb          	addw	t4,t3,t4
     6c8:	de0850e3          	bgez	a6,4a8 <stbsp__real_to_str+0x1e8>
     6cc:	a819                	j	6e2 <stbsp__real_to_str+0x422>
     6ce:	02571313          	slli	t1,a4,0x25
     6d2:	02535313          	srli	t1,t1,0x25
     6d6:	0305                	addi	t1,t1,1
     6d8:	475d                	li	a4,23
     6da:	ce676ee3          	bltu	a4,t1,3d6 <stbsp__real_to_str+0x116>
     6de:	4829                	li	a6,10
     6e0:	b759                	j	666 <stbsp__real_to_str+0x3a6>
     6e2:	260e8663          	beqz	t4,94e <stbsp__real_to_str+0x68e>
     6e6:	00231e13          	slli	t3,t1,0x2
     6ea:	41c30e33          	sub	t3,t1,t3
     6ee:	0e0e                	slli	t3,t3,0x3
     6f0:	9e1a                	add	t3,t3,t1
     6f2:	fffe881b          	addiw	a6,t4,-1
     6f6:	9e7a                	add	t3,t3,t5
     6f8:	00005e97          	auipc	t4,0x5
     6fc:	d88e8e93          	addi	t4,t4,-632 # 5480 <stbsp__bot>
     700:	0e0e                	slli	t3,t3,0x3
     702:	080e                	slli	a6,a6,0x3
     704:	9876                	add	a6,a6,t4
     706:	9ef2                	add	t4,t4,t3
     708:	0b883607          	fld	fa2,184(a6)
     70c:	f20887d3          	fmv.d.x	fa5,a7
     710:	0b0ebf03          	ld	t5,176(t4)
     714:	f8000e37          	lui	t3,0xf8000
     718:	011e7eb3          	and	t4,t3,a7
     71c:	12f676d3          	fmul.d	fa3,fa2,fa5
     720:	01ee7e33          	and	t3,t3,t5
     724:	f20e07d3          	fmv.d.x	fa5,t3
     728:	f20e0753          	fmv.d.x	fa4,t3
     72c:	f20e8553          	fmv.d.x	fa0,t4
     730:	0af67653          	fsub.d	fa2,fa2,fa5
     734:	f20e87d3          	fmv.d.x	fa5,t4
     738:	f20e85d3          	fmv.d.x	fa1,t4
     73c:	6ae7f7c7          	fmsub.d	fa5,fa5,fa4,fa3
     740:	f2088753          	fmv.d.x	fa4,a7
     744:	0ab775d3          	fsub.d	fa1,fa4,fa1
     748:	16883707          	fld	fa4,360(a6)
     74c:	7aa677c3          	fmadd.d	fa5,fa2,fa0,fa5
     750:	f20e0553          	fmv.d.x	fa0,t3
     754:	7aa5f7c3          	fmadd.d	fa5,fa1,fa0,fa5
     758:	7ac5f5c3          	fmadd.d	fa1,fa1,fa2,fa5
     75c:	f20887d3          	fmv.d.x	fa5,a7
     760:	5af77743          	fmadd.d	fa4,fa4,fa5,fa1
     764:	c00f87e3          	beqz	t6,372 <stbsp__real_to_str+0xb2>
     768:	02d777d3          	fadd.d	fa5,fa4,fa3
     76c:	fff3089b          	addiw	a7,t1,-1
     770:	00005817          	auipc	a6,0x5
     774:	d1080813          	addi	a6,a6,-752 # 5480 <stbsp__bot>
     778:	030e                	slli	t1,t1,0x3
     77a:	088e                	slli	a7,a7,0x3
     77c:	98c2                	add	a7,a7,a6
     77e:	981a                	add	a6,a6,t1
     780:	e2078e53          	fmv.x.d	t3,fa5
     784:	21083e83          	ld	t4,528(a6)
     788:	f8000837          	lui	a6,0xf8000
     78c:	2188b507          	fld	fa0,536(a7)
     790:	01c87333          	and	t1,a6,t3
     794:	01d87833          	and	a6,a6,t4
     798:	f2080653          	fmv.d.x	fa2,a6
     79c:	12f577d3          	fmul.d	fa5,fa0,fa5
     7a0:	2808b587          	fld	fa1,640(a7)
     7a4:	0ac57053          	fsub.d	ft0,fa0,fa2
     7a8:	f20e0653          	fmv.d.x	fa2,t3
     7ac:	0ad67153          	fsub.d	ft2,fa2,fa3
     7b0:	f20806d3          	fmv.d.x	fa3,a6
     7b4:	f2030653          	fmv.d.x	fa2,t1
     7b8:	7ac6f0c7          	fmsub.d	ft1,fa3,fa2,fa5
     7bc:	f20e06d3          	fmv.d.x	fa3,t3
     7c0:	0ac6f653          	fsub.d	fa2,fa3,fa2
     7c4:	22f786d3          	fmv.d	fa3,fa5
     7c8:	0a2777d3          	fsub.d	fa5,fa4,ft2
     7cc:	f2030753          	fmv.d.x	fa4,t1
     7d0:	0ae07743          	fmadd.d	fa4,ft0,fa4,ft1
     7d4:	12a7f7d3          	fmul.d	fa5,fa5,fa0
     7d8:	f2080553          	fmv.d.x	fa0,a6
     7dc:	72a67743          	fmadd.d	fa4,fa2,fa0,fa4
     7e0:	f20e0553          	fmv.d.x	fa0,t3
     7e4:	7aa5f7c3          	fmadd.d	fa5,fa1,fa0,fa5
     7e8:	72067643          	fmadd.d	fa2,fa2,ft0,fa4
     7ec:	02f67753          	fadd.d	fa4,fa2,fa5
     7f0:	b649                	j	372 <stbsp__real_to_str+0xb2>
     7f2:	02571313          	slli	t1,a4,0x25
     7f6:	02535313          	srli	t1,t1,0x25
     7fa:	0305                	addi	t1,t1,1
     7fc:	475d                	li	a4,23
     7fe:	d46769e3          	bltu	a4,t1,550 <stbsp__real_to_str+0x290>
     802:	bd99                	j	658 <stbsp__real_to_str+0x398>
     804:	87fe                	mv	a5,t6
     806:	8fbe                	mv	t6,a5
     808:	b101                	j	408 <stbsp__real_to_str+0x148>
     80a:	87fe                	mv	a5,t6
     80c:	3e800713          	li	a4,1000
     810:	02e7f73b          	remuw	a4,a5,a4
     814:	2781                	sext.w	a5,a5
     816:	eb01                	bnez	a4,826 <stbsp__real_to_str+0x566>
     818:	3e800813          	li	a6,1000
     81c:	0307d7bb          	divuw	a5,a5,a6
     820:	0307f73b          	remuw	a4,a5,a6
     824:	df65                	beqz	a4,81c <stbsp__real_to_str+0x55c>
     826:	02079f93          	slli	t6,a5,0x20
     82a:	020fdf93          	srli	t6,t6,0x20
     82e:	b31d                	j	554 <stbsp__real_to_str+0x294>
     830:	4785                	li	a5,1
     832:	c29c                	sw	a5,0(a3)
     834:	00c2b023          	sd	a2,0(t0)
     838:	03000793          	li	a5,48
     83c:	00f60023          	sb	a5,0(a2)
     840:	4f05                	li	t5,1
     842:	01e5a023          	sw	t5,0(a1)
     846:	6105                	addi	sp,sp,32
     848:	8082                	ret
     84a:	0805                	addi	a6,a6,1 # fffffffff8000001 <_ZSt4cerr+0xfffffffff7ff8689>
     84c:	3f7d                	addiw	t5,t5,-1
     84e:	b3d1                	j	612 <stbsp__real_to_str+0x352>
     850:	e826                	sd	s1,16(sp)
     852:	e44a                	sd	s2,8(sp)
     854:	4859                	li	a6,22
     856:	8976                	mv	s2,t4
     858:	11d84363          	blt	a6,t4,95e <stbsp__real_to_str+0x69e>
     85c:	0009049b          	sext.w	s1,s2
     860:	00005e17          	auipc	t3,0x5
     864:	c20e0e13          	addi	t3,t3,-992 # 5480 <stbsp__bot>
     868:	00349813          	slli	a6,s1,0x3
     86c:	9872                	add	a6,a6,t3
     86e:	00083687          	fld	fa3,0(a6)
     872:	00083803          	ld	a6,0(a6)
     876:	f20887d3          	fmv.d.x	fa5,a7
     87a:	f8000fb7          	lui	t6,0xf8000
     87e:	010ff833          	and	a6,t6,a6
     882:	12f6f553          	fmul.d	fa0,fa3,fa5
     886:	f20807d3          	fmv.d.x	fa5,a6
     88a:	011ff433          	and	s0,t6,a7
     88e:	f2040753          	fmv.d.x	fa4,s0
     892:	0af6f6d3          	fsub.d	fa3,fa3,fa5
     896:	f20887d3          	fmv.d.x	fa5,a7
     89a:	f2080653          	fmv.d.x	fa2,a6
     89e:	412e8ebb          	subw	t4,t4,s2
     8a2:	0ae7f753          	fsub.d	fa4,fa5,fa4
     8a6:	f20407d3          	fmv.d.x	fa5,s0
     8aa:	e20508d3          	fmv.x.d	a7,fa0
     8ae:	52c7f7c7          	fmsub.d	fa5,fa5,fa2,fa0
     8b2:	f2040653          	fmv.d.x	fa2,s0
     8b6:	7ac6f7c3          	fmadd.d	fa5,fa3,fa2,fa5
     8ba:	f2080653          	fmv.d.x	fa2,a6
     8be:	7ac777c3          	fmadd.d	fa5,fa4,fa2,fa5
     8c2:	7ad77743          	fmadd.d	fa4,fa4,fa3,fa5
     8c6:	080e8963          	beqz	t4,958 <stbsp__real_to_str+0x698>
     8ca:	02e577d3          	fadd.d	fa5,fa0,fa4
     8ce:	0e8e                	slli	t4,t4,0x3
     8d0:	01de0833          	add	a6,t3,t4
     8d4:	00083587          	fld	fa1,0(a6)
     8d8:	00231893          	slli	a7,t1,0x2
     8dc:	411308b3          	sub	a7,t1,a7
     8e0:	00389813          	slli	a6,a7,0x3
     8e4:	e2078453          	fmv.x.d	s0,fa5
     8e8:	12f5f7d3          	fmul.d	fa5,fa1,fa5
     8ec:	981a                	add	a6,a6,t1
     8ee:	987a                	add	a6,a6,t5
     8f0:	40980833          	sub	a6,a6,s1
     8f4:	080e                	slli	a6,a6,0x3
     8f6:	9872                	add	a6,a6,t3
     8f8:	00083e83          	ld	t4,0(a6)
     8fc:	008ff833          	and	a6,t6,s0
     900:	e20788d3          	fmv.x.d	a7,fa5
     904:	f20806d3          	fmv.d.x	fa3,a6
     908:	f20407d3          	fmv.d.x	fa5,s0
     90c:	01dfffb3          	and	t6,t6,t4
     910:	f20880d3          	fmv.d.x	ft1,a7
     914:	0ad7f653          	fsub.d	fa2,fa5,fa3
     918:	f20f87d3          	fmv.d.x	fa5,t6
     91c:	64c2                	ld	s1,16(sp)
     91e:	6922                	ld	s2,8(sp)
     920:	0af5f053          	fsub.d	ft0,fa1,fa5
     924:	0ad7f6c7          	fmsub.d	fa3,fa5,fa3,ft1
     928:	f20407d3          	fmv.d.x	fa5,s0
     92c:	0aa7f7d3          	fsub.d	fa5,fa5,fa0
     930:	f2080553          	fmv.d.x	fa0,a6
     934:	6aa076c3          	fmadd.d	fa3,ft0,fa0,fa3
     938:	0af77753          	fsub.d	fa4,fa4,fa5
     93c:	f20f87d3          	fmv.d.x	fa5,t6
     940:	6af677c3          	fmadd.d	fa5,fa2,fa5,fa3
     944:	7a067643          	fmadd.d	fa2,fa2,ft0,fa5
     948:	62e5f743          	fmadd.d	fa4,fa1,fa4,fa2
     94c:	b6b5                	j	4b8 <stbsp__real_to_str+0x1f8>
     94e:	f20886d3          	fmv.d.x	fa3,a7
     952:	f2000753          	fmv.d.x	fa4,zero
     956:	b539                	j	764 <stbsp__real_to_str+0x4a4>
     958:	64c2                	ld	s1,16(sp)
     95a:	6922                	ld	s2,8(sp)
     95c:	beb1                	j	4b8 <stbsp__real_to_str+0x1f8>
     95e:	4959                	li	s2,22
     960:	bdf5                	j	85c <stbsp__real_to_str+0x59c>
     962:	e826                	sd	s1,16(sp)
     964:	e44a                	sd	s2,8(sp)
     966:	ecc00393          	li	t2,-308
     96a:	4eed                	li	t4,27
     96c:	4335                	li	t1,13
     96e:	14600f13          	li	t5,326
     972:	b5cd                	j	854 <stbsp__real_to_str+0x594>
     974:	26900313          	li	t1,617
     978:	0303083b          	mulw	a6,t1,a6
     97c:	41f8531b          	sraiw	t1,a6,0x1f
     980:	0153531b          	srliw	t1,t1,0x15
     984:	0103033b          	addw	t1,t1,a6
     988:	40b3539b          	sraiw	t2,t1,0xb
     98c:	4849                	li	a6,18
     98e:	4078083b          	subw	a6,a6,t2
     992:	b249                	j	314 <stbsp__real_to_str+0x54>

0000000000000994 <_in_char.part.0>:
static int _in_char(_InContext *ctx)
     994:	87aa                	mv	a5,a0
    if (ctx->fd == -1)
     996:	4508                	lw	a0,8(a0)
     998:	577d                	li	a4,-1
     99a:	00e51d63          	bne	a0,a4,9b4 <_in_char.part.0+0x20>
        if (ctx->buf[ctx->pos] == '\0')
     99e:	6b94                	ld	a3,16(a5)
     9a0:	6398                	ld	a4,0(a5)
     9a2:	9736                	add	a4,a4,a3
     9a4:	00074603          	lbu	a2,0(a4)
     9a8:	c60d                	beqz	a2,9d2 <_in_char.part.0+0x3e>
        return (unsigned char)ctx->buf[ctx->pos++];
     9aa:	0685                	addi	a3,a3,1
     9ac:	eb94                	sd	a3,16(a5)
     9ae:	00074503          	lbu	a0,0(a4)
     9b2:	8082                	ret
static int _in_char(_InContext *ctx)
     9b4:	1101                	addi	sp,sp,-32
    if (read(ctx->fd, &c, 1) == 1)
     9b6:	4605                	li	a2,1
     9b8:	00f10593          	addi	a1,sp,15
static int _in_char(_InContext *ctx)
     9bc:	ec06                	sd	ra,24(sp)
    if (read(ctx->fd, &c, 1) == 1)
     9be:	801ff0ef          	jal	1be <read>
     9c2:	4785                	li	a5,1
     9c4:	00f51963          	bne	a0,a5,9d6 <_in_char.part.0+0x42>
        return (unsigned char)c;
     9c8:	00f14503          	lbu	a0,15(sp)
}
     9cc:	60e2                	ld	ra,24(sp)
     9ce:	6105                	addi	sp,sp,32
     9d0:	8082                	ret
            return -1;
     9d2:	557d                	li	a0,-1
}
     9d4:	8082                	ret
            return -1;
     9d6:	557d                	li	a0,-1
     9d8:	bfd5                	j	9cc <_in_char.part.0+0x38>

00000000000009da <_skip_space>:
{
     9da:	7139                	addi	sp,sp,-64
     9dc:	f822                	sd	s0,48(sp)
     9de:	f426                	sd	s1,40(sp)
     9e0:	f04a                	sd	s2,32(sp)
     9e2:	ec4e                	sd	s3,24(sp)
     9e4:	e852                	sd	s4,16(sp)
     9e6:	fc06                	sd	ra,56(sp)
     9e8:	842a                	mv	s0,a0
        ctx->ungotten = -1;
     9ea:	54fd                	li	s1,-1
    if (read(ctx->fd, &c, 1) == 1)
     9ec:	00f10a13          	addi	s4,sp,15
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     9f0:	02000913          	li	s2,32
     9f4:	4991                	li	s3,4
    if (ctx->ungotten >= 0)
     9f6:	4c1c                	lw	a5,24(s0)
     9f8:	0407d163          	bgez	a5,a3a <_skip_space+0x60>
    if (ctx->fd == -1)
     9fc:	4408                	lw	a0,8(s0)
    if (read(ctx->fd, &c, 1) == 1)
     9fe:	4605                	li	a2,1
     a00:	85d2                	mv	a1,s4
    if (ctx->fd == -1)
     a02:	02951e63          	bne	a0,s1,a3e <_skip_space+0x64>
        if (ctx->buf[ctx->pos] == '\0')
     a06:	6818                	ld	a4,16(s0)
     a08:	601c                	ld	a5,0(s0)
        return (unsigned char)ctx->buf[ctx->pos++];
     a0a:	00170693          	addi	a3,a4,1
        if (ctx->buf[ctx->pos] == '\0')
     a0e:	97ba                	add	a5,a5,a4
     a10:	0007c703          	lbu	a4,0(a5) # 7000 <_stdout+0x60>
     a14:	cb19                	beqz	a4,a2a <_skip_space+0x50>
        return (unsigned char)ctx->buf[ctx->pos++];
     a16:	e814                	sd	a3,16(s0)
     a18:	0007c783          	lbu	a5,0(a5)
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     a1c:	ff77871b          	addiw	a4,a5,-9
     a20:	fd278be3          	beq	a5,s2,9f6 <_skip_space+0x1c>
     a24:	fce9f9e3          	bgeu	s3,a4,9f6 <_skip_space+0x1c>
        ctx->ungotten = c;
     a28:	cc1c                	sw	a5,24(s0)
}
     a2a:	70e2                	ld	ra,56(sp)
     a2c:	7442                	ld	s0,48(sp)
     a2e:	74a2                	ld	s1,40(sp)
     a30:	7902                	ld	s2,32(sp)
     a32:	69e2                	ld	s3,24(sp)
     a34:	6a42                	ld	s4,16(sp)
     a36:	6121                	addi	sp,sp,64
     a38:	8082                	ret
        ctx->ungotten = -1;
     a3a:	cc04                	sw	s1,24(s0)
        return c;
     a3c:	b7c5                	j	a1c <_skip_space+0x42>
    if (read(ctx->fd, &c, 1) == 1)
     a3e:	f80ff0ef          	jal	1be <read>
     a42:	4785                	li	a5,1
     a44:	fef513e3          	bne	a0,a5,a2a <_skip_space+0x50>
        return (unsigned char)c;
     a48:	00f14783          	lbu	a5,15(sp)
     a4c:	bfc1                	j	a1c <_skip_space+0x42>

0000000000000a4e <_vscanf_core.constprop.0>:
static int _vscanf_core(_InContext *ctx, const char *format, va_list ap)
     a4e:	7155                	addi	sp,sp,-208
     a50:	e586                	sd	ra,200(sp)
     a52:	e95a                	sd	s6,144(sp)
    while (*p)
     a54:	0005c783          	lbu	a5,0(a1)
static int _vscanf_core(_InContext *ctx, const char *format, va_list ap)
     a58:	e432                	sd	a2,8(sp)
    while (*p)
     a5a:	68078b63          	beqz	a5,10f0 <_vscanf_core.constprop.0+0x6a2>
     a5e:	e1a2                	sd	s0,192(sp)
     a60:	fd26                	sd	s1,184(sp)
     a62:	f152                	sd	s4,160(sp)
     a64:	ed56                	sd	s5,152(sp)
     a66:	f4ee                	sd	s11,104(sp)
     a68:	842e                	mv	s0,a1
     a6a:	8daa                	mv	s11,a0
    int assigned = 0;
     a6c:	4b01                	li	s6,0
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     a6e:	02000493          	li	s1,32
     a72:	4a91                	li	s5,4
        if (*p != '%')
     a74:	02500a13          	li	s4,37
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     a78:	04978763          	beq	a5,s1,ac6 <_vscanf_core.constprop.0+0x78>
     a7c:	ff77869b          	addiw	a3,a5,-9
     a80:	0ff6f693          	zext.b	a3,a3
     a84:	04daf163          	bgeu	s5,a3,ac6 <_vscanf_core.constprop.0+0x78>
        if (*p != '%')
     a88:	07478d63          	beq	a5,s4,b02 <_vscanf_core.constprop.0+0xb4>
            _skip_space(ctx);
     a8c:	856e                	mv	a0,s11
     a8e:	f4dff0ef          	jal	9da <_skip_space>
    if (ctx->ungotten >= 0)
     a92:	018da503          	lw	a0,24(s11)
     a96:	04055a63          	bgez	a0,aea <_vscanf_core.constprop.0+0x9c>
     a9a:	856e                	mv	a0,s11
     a9c:	ef9ff0ef          	jal	994 <_in_char.part.0>
            if (c != *p)
     aa0:	00044783          	lbu	a5,0(s0)
     aa4:	04a78a63          	beq	a5,a0,af8 <_vscanf_core.constprop.0+0xaa>
    if (c != -1)
     aa8:	57fd                	li	a5,-1
     aaa:	00f50463          	beq	a0,a5,ab2 <_vscanf_core.constprop.0+0x64>
        ctx->ungotten = c;
     aae:	00adac23          	sw	a0,24(s11)
     ab2:	640e                	ld	s0,192(sp)
     ab4:	74ea                	ld	s1,184(sp)
     ab6:	7a0a                	ld	s4,160(sp)
     ab8:	6aea                	ld	s5,152(sp)
     aba:	7da6                	ld	s11,104(sp)
}
     abc:	60ae                	ld	ra,200(sp)
     abe:	855a                	mv	a0,s6
     ac0:	6b4a                	ld	s6,144(sp)
     ac2:	6169                	addi	sp,sp,208
     ac4:	8082                	ret
            _skip_space(ctx);
     ac6:	856e                	mv	a0,s11
     ac8:	f13ff0ef          	jal	9da <_skip_space>
            while (isspace(*p))
     acc:	00044783          	lbu	a5,0(s0)
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     ad0:	4611                	li	a2,4
     ad2:	ff77869b          	addiw	a3,a5,-9
     ad6:	0ff6f693          	zext.b	a3,a3
     ada:	00978663          	beq	a5,s1,ae6 <_vscanf_core.constprop.0+0x98>
     ade:	00d67463          	bgeu	a2,a3,ae6 <_vscanf_core.constprop.0+0x98>
    while (*p)
     ae2:	fbd9                	bnez	a5,a78 <_vscanf_core.constprop.0+0x2a>
     ae4:	b7f9                	j	ab2 <_vscanf_core.constprop.0+0x64>
                p++;
     ae6:	0405                	addi	s0,s0,1
     ae8:	b7d5                	j	acc <_vscanf_core.constprop.0+0x7e>
        ctx->ungotten = -1;
     aea:	57fd                	li	a5,-1
     aec:	00fdac23          	sw	a5,24(s11)
            if (c != *p)
     af0:	00044783          	lbu	a5,0(s0)
     af4:	faa79ae3          	bne	a5,a0,aa8 <_vscanf_core.constprop.0+0x5a>
    while (*p)
     af8:	00144783          	lbu	a5,1(s0)
            p++;
     afc:	0405                	addi	s0,s0,1
    while (*p)
     afe:	ffad                	bnez	a5,a78 <_vscanf_core.constprop.0+0x2a>
     b00:	bf4d                	j	ab2 <_vscanf_core.constprop.0+0x64>
     b02:	f94a                	sd	s2,176(sp)
     b04:	f54e                	sd	s3,168(sp)
     b06:	e55e                	sd	s7,136(sp)
     b08:	e162                	sd	s8,128(sp)
        if (*p == '*')
     b0a:	00144583          	lbu	a1,1(s0)
     b0e:	02a00793          	li	a5,42
     b12:	22f58d63          	beq	a1,a5,d4c <_vscanf_core.constprop.0+0x2fe>
        p++;
     b16:	0405                	addi	s0,s0,1
        int suppress = 0;
     b18:	4981                	li	s3,0
        while (*p >= '0' && *p <= '9')
     b1a:	fd05861b          	addiw	a2,a1,-48
     b1e:	0ff67693          	zext.b	a3,a2
     b22:	47a5                	li	a5,9
     b24:	36d7e763          	bltu	a5,a3,e92 <_vscanf_core.constprop.0+0x444>
     b28:	4781                	li	a5,0
     b2a:	4825                	li	a6,9
     b2c:	a019                	j	b32 <_vscanf_core.constprop.0+0xe4>
            width = width * 10 + (*p - '0');
     b2e:	0016979b          	slliw	a5,a3,0x1
        while (*p >= '0' && *p <= '9')
     b32:	00144583          	lbu	a1,1(s0)
            width = width * 10 + (*p - '0');
     b36:	00f6093b          	addw	s2,a2,a5
     b3a:	0029169b          	slliw	a3,s2,0x2
        while (*p >= '0' && *p <= '9')
     b3e:	fd05861b          	addiw	a2,a1,-48
     b42:	0ff67513          	zext.b	a0,a2
            width = width * 10 + (*p - '0');
     b46:	012686bb          	addw	a3,a3,s2
            p++;
     b4a:	0405                	addi	s0,s0,1
        while (*p >= '0' && *p <= '9')
     b4c:	fea871e3          	bgeu	a6,a0,b2e <_vscanf_core.constprop.0+0xe0>
        if (*p == 'l')
     b50:	06c00693          	li	a3,108
            p++;
     b54:	00140b93          	addi	s7,s0,1
        if (*p == 'l')
     b58:	1ed58f63          	beq	a1,a3,d56 <_vscanf_core.constprop.0+0x308>
        else if (*p == 'h')
     b5c:	06800693          	li	a3,104
     b60:	2ad58863          	beq	a1,a3,e10 <_vscanf_core.constprop.0+0x3c2>
        char spec = *p++;
     b64:	00044c03          	lbu	s8,0(s0)
     b68:	8ba2                	mv	s7,s0
        int len_mod = 0;
     b6a:	ec02                	sd	zero,24(sp)
        char spec = *p++;
     b6c:	06300693          	li	a3,99
     b70:	001b8413          	addi	s0,s7,1
        if (!spec)
     b74:	2adc0863          	beq	s8,a3,e24 <_vscanf_core.constprop.0+0x3d6>
     b78:	1f86fc63          	bgeu	a3,s8,d70 <_vscanf_core.constprop.0+0x322>
     b7c:	f9cc069b          	addiw	a3,s8,-100
     b80:	0ff6f693          	zext.b	a3,a3
     b84:	4651                	li	a2,20
     b86:	0cd66e63          	bltu	a2,a3,c62 <_vscanf_core.constprop.0+0x214>
     b8a:	00120637          	lui	a2,0x120
     b8e:	4585                	li	a1,1
     b90:	00d595b3          	sll	a1,a1,a3
     b94:	02160613          	addi	a2,a2,33 # 120021 <_ZSt4cerr+0x1186a9>
     b98:	8e6d                	and	a2,a2,a1
     b9a:	ee69                	bnez	a2,c74 <_vscanf_core.constprop.0+0x226>
     b9c:	89b9                	andi	a1,a1,14
     b9e:	1e059263          	bnez	a1,d82 <_vscanf_core.constprop.0+0x334>
     ba2:	463d                	li	a2,15
     ba4:	0ac69f63          	bne	a3,a2,c62 <_vscanf_core.constprop.0+0x214>
            _skip_space(ctx);
     ba8:	856e                	mv	a0,s11
     baa:	e31ff0ef          	jal	9da <_skip_space>
            char *buf = suppress ? NULL : va_arg(ap, char *);
     bae:	ec02                	sd	zero,24(sp)
     bb0:	00099763          	bnez	s3,bbe <_vscanf_core.constprop.0+0x170>
     bb4:	67a2                	ld	a5,8(sp)
     bb6:	6398                	ld	a4,0(a5)
     bb8:	07a1                	addi	a5,a5,8
     bba:	e43e                	sd	a5,8(sp)
     bbc:	ec3a                	sd	a4,24(sp)
    if (ctx->ungotten >= 0)
     bbe:	018da503          	lw	a0,24(s11)
     bc2:	2e055b63          	bgez	a0,eb8 <_vscanf_core.constprop.0+0x46a>
     bc6:	856e                	mv	a0,s11
     bc8:	dcdff0ef          	jal	994 <_in_char.part.0>
            while (c != -1 && !isspace(c))
     bcc:	56fd                	li	a3,-1
     bce:	6ad50363          	beq	a0,a3,1274 <_vscanf_core.constprop.0+0x826>
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     bd2:	02000693          	li	a3,32
     bd6:	3ed50963          	beq	a0,a3,fc8 <_vscanf_core.constprop.0+0x57a>
     bda:	46a5                	li	a3,9
     bdc:	3ed50663          	beq	a0,a3,fc8 <_vscanf_core.constprop.0+0x57a>
     be0:	46a9                	li	a3,10
     be2:	3ed50363          	beq	a0,a3,fc8 <_vscanf_core.constprop.0+0x57a>
     be6:	46ad                	li	a3,11
     be8:	3ed50063          	beq	a0,a3,fc8 <_vscanf_core.constprop.0+0x57a>
     bec:	46b1                	li	a3,12
     bee:	3cd50d63          	beq	a0,a3,fc8 <_vscanf_core.constprop.0+0x57a>
     bf2:	46b5                	li	a3,13
     bf4:	3cd50a63          	beq	a0,a3,fc8 <_vscanf_core.constprop.0+0x57a>
     bf8:	67e2                	ld	a5,24(sp)
     bfa:	fce6                	sd	s9,120(sp)
     bfc:	f8ea                	sd	s10,112(sp)
     bfe:	e83e                	sd	a5,16(sp)
     c00:	4d01                	li	s10,0
            while (c != -1 && !isspace(c))
     c02:	5c7d                	li	s8,-1
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     c04:	02000c93          	li	s9,32
                if (width > 0 && i >= width)
     c08:	01205463          	blez	s2,c10 <_vscanf_core.constprop.0+0x1c2>
     c0c:	052d5563          	bge	s10,s2,c56 <_vscanf_core.constprop.0+0x208>
                if (!suppress)
     c10:	00099563          	bnez	s3,c1a <_vscanf_core.constprop.0+0x1cc>
                    buf[i] = (char)c;
     c14:	67c2                	ld	a5,16(sp)
     c16:	00a78023          	sb	a0,0(a5)
    if (ctx->ungotten >= 0)
     c1a:	018da503          	lw	a0,24(s11)
                i++;
     c1e:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
     c20:	30055963          	bgez	a0,f32 <_vscanf_core.constprop.0+0x4e4>
     c24:	856e                	mv	a0,s11
     c26:	d6fff0ef          	jal	994 <_in_char.part.0>
            while (c != -1 && !isspace(c))
     c2a:	27850663          	beq	a0,s8,e96 <_vscanf_core.constprop.0+0x448>
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
     c2e:	03950463          	beq	a0,s9,c56 <_vscanf_core.constprop.0+0x208>
     c32:	47a5                	li	a5,9
     c34:	02f50163          	beq	a0,a5,c56 <_vscanf_core.constprop.0+0x208>
     c38:	47a9                	li	a5,10
     c3a:	00f50e63          	beq	a0,a5,c56 <_vscanf_core.constprop.0+0x208>
     c3e:	47ad                	li	a5,11
     c40:	00f50b63          	beq	a0,a5,c56 <_vscanf_core.constprop.0+0x208>
     c44:	47b1                	li	a5,12
     c46:	00f50863          	beq	a0,a5,c56 <_vscanf_core.constprop.0+0x208>
     c4a:	67c2                	ld	a5,16(sp)
     c4c:	0785                	addi	a5,a5,1
     c4e:	e83e                	sd	a5,16(sp)
     c50:	47b5                	li	a5,13
     c52:	faf51be3          	bne	a0,a5,c08 <_vscanf_core.constprop.0+0x1ba>
            if (!suppress)
     c56:	64098a63          	beqz	s3,12aa <_vscanf_core.constprop.0+0x85c>
     c5a:	7ce6                	ld	s9,120(sp)
     c5c:	7d46                	ld	s10,112(sp)
        ctx->ungotten = c;
     c5e:	00adac23          	sw	a0,24(s11)
    while (*p)
     c62:	001bc783          	lbu	a5,1(s7)
     c66:	794a                	ld	s2,176(sp)
     c68:	79aa                	ld	s3,168(sp)
     c6a:	6baa                	ld	s7,136(sp)
     c6c:	6c0a                	ld	s8,128(sp)
     c6e:	e00795e3          	bnez	a5,a78 <_vscanf_core.constprop.0+0x2a>
     c72:	b581                	j	ab2 <_vscanf_core.constprop.0+0x64>
            _skip_space(ctx);
     c74:	856e                	mv	a0,s11
     c76:	f8ea                	sd	s10,112(sp)
     c78:	d63ff0ef          	jal	9da <_skip_space>
    if (ctx->ungotten >= 0)
     c7c:	018da503          	lw	a0,24(s11)
     c80:	24055063          	bgez	a0,ec0 <_vscanf_core.constprop.0+0x472>
     c84:	856e                	mv	a0,s11
     c86:	d0fff0ef          	jal	994 <_in_char.part.0>
            if (c == '-' || c == '+')
     c8a:	fd55069b          	addiw	a3,a0,-43
     c8e:	9af5                	andi	a3,a3,-3
     c90:	2681                	sext.w	a3,a3
            int i = 0, c = _in_char(ctx);
     c92:	4d01                	li	s10,0
            if (c == '-' || c == '+')
     c94:	3e068863          	beqz	a3,1084 <_vscanf_core.constprop.0+0x636>
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
     c98:	07800693          	li	a3,120
     c9c:	4641                	li	a2,16
     c9e:	00dc0863          	beq	s8,a3,cae <_vscanf_core.constprop.0+0x260>
     ca2:	06900693          	li	a3,105
     ca6:	4629                	li	a2,10
     ca8:	00dc1363          	bne	s8,a3,cae <_vscanf_core.constprop.0+0x260>
     cac:	4601                	li	a2,0
            while (c != -1 && i < 63)
     cae:	56fd                	li	a3,-1
     cb0:	5cd50863          	beq	a0,a3,1280 <_vscanf_core.constprop.0+0x832>
     cb4:	fce6                	sd	s9,120(sp)
     cb6:	02010893          	addi	a7,sp,32
     cba:	01a88c33          	add	s8,a7,s10
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     cbe:	4cc1                	li	s9,16
                int digit = (c >= '0' && c <= '9');
     cc0:	fd05069b          	addiw	a3,a0,-48
     cc4:	0005031b          	sext.w	t1,a0
     cc8:	00a6b593          	sltiu	a1,a3,10
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     ccc:	27960a63          	beq	a2,s9,f40 <_vscanf_core.constprop.0+0x4f2>
     cd0:	2a060d63          	beqz	a2,f8a <_vscanf_core.constprop.0+0x53c>
                int x = (c == 'x' || c == 'X');
     cd4:	07800793          	li	a5,120
     cd8:	2ef50363          	beq	a0,a5,fbe <_vscanf_core.constprop.0+0x570>
     cdc:	fa850693          	addi	a3,a0,-88
     ce0:	0016b693          	seqz	a3,a3
     ce4:	4301                	li	t1,0
                if (width > 0 && i >= width)
     ce6:	01205463          	blez	s2,cee <_vscanf_core.constprop.0+0x2a0>
     cea:	032d5a63          	bge	s10,s2,d1e <_vscanf_core.constprop.0+0x2d0>
                if (digit || hex || x)
     cee:	0066e6b3          	or	a3,a3,t1
     cf2:	8ecd                	or	a3,a3,a1
     cf4:	c68d                	beqz	a3,d1e <_vscanf_core.constprop.0+0x2d0>
                    num_buf[i++] = (char)c;
     cf6:	00ac0023          	sb	a0,0(s8)
    if (ctx->ungotten >= 0)
     cfa:	018da503          	lw	a0,24(s11)
                    num_buf[i++] = (char)c;
     cfe:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
     d00:	22055c63          	bgez	a0,f38 <_vscanf_core.constprop.0+0x4ea>
     d04:	856e                	mv	a0,s11
     d06:	e832                	sd	a2,16(sp)
     d08:	c8dff0ef          	jal	994 <_in_char.part.0>
            while (c != -1 && i < 63)
     d0c:	57fd                	li	a5,-1
     d0e:	6642                	ld	a2,16(sp)
     d10:	3cf50263          	beq	a0,a5,10d4 <_vscanf_core.constprop.0+0x686>
     d14:	03f00693          	li	a3,63
     d18:	0c05                	addi	s8,s8,1
     d1a:	fadd13e3          	bne	s10,a3,cc0 <_vscanf_core.constprop.0+0x272>
            num_buf[i] = '\0';
     d1e:	040d0793          	addi	a5,s10,64
     d22:	1018                	addi	a4,sp,32
     d24:	97ba                	add	a5,a5,a4
     d26:	fc078023          	sb	zero,-64(a5)
        ctx->ungotten = c;
     d2a:	00adac23          	sw	a0,24(s11)
     d2e:	7ce6                	ld	s9,120(sp)
            if (i == 0)
     d30:	1e0d0663          	beqz	s10,f1c <_vscanf_core.constprop.0+0x4ce>
            if (!suppress)
     d34:	36098363          	beqz	s3,109a <_vscanf_core.constprop.0+0x64c>
    while (*p)
     d38:	001bc783          	lbu	a5,1(s7)
        {
     d3c:	794a                	ld	s2,176(sp)
     d3e:	79aa                	ld	s3,168(sp)
     d40:	6baa                	ld	s7,136(sp)
     d42:	6c0a                	ld	s8,128(sp)
     d44:	7d46                	ld	s10,112(sp)
    while (*p)
     d46:	d20799e3          	bnez	a5,a78 <_vscanf_core.constprop.0+0x2a>
     d4a:	b3a5                	j	ab2 <_vscanf_core.constprop.0+0x64>
        while (*p >= '0' && *p <= '9')
     d4c:	00244583          	lbu	a1,2(s0)
            suppress = 1;
     d50:	4985                	li	s3,1
            p++;
     d52:	0409                	addi	s0,s0,2
     d54:	b3d9                	j	b1a <_vscanf_core.constprop.0+0xcc>
            if (*p == 'l')
     d56:	00144c03          	lbu	s8,1(s0)
            len_mod = 1;
     d5a:	4785                	li	a5,1
     d5c:	ec3e                	sd	a5,24(sp)
            if (*p == 'l')
     d5e:	e0bc17e3          	bne	s8,a1,b6c <_vscanf_core.constprop.0+0x11e>
                len_mod = 2;
     d62:	4789                	li	a5,2
        char spec = *p++;
     d64:	00244c03          	lbu	s8,2(s0)
                p++;
     d68:	00240b93          	addi	s7,s0,2
                len_mod = 2;
     d6c:	ec3e                	sd	a5,24(sp)
     d6e:	bbfd                	j	b6c <_vscanf_core.constprop.0+0x11e>
     d70:	100c0763          	beqz	s8,e7e <_vscanf_core.constprop.0+0x430>
     d74:	fbbc079b          	addiw	a5,s8,-69
     d78:	0ff7f793          	zext.b	a5,a5
     d7c:	4689                	li	a3,2
     d7e:	eef6e2e3          	bltu	a3,a5,c62 <_vscanf_core.constprop.0+0x214>
            _skip_space(ctx);
     d82:	856e                	mv	a0,s11
     d84:	f8ea                	sd	s10,112(sp)
     d86:	c55ff0ef          	jal	9da <_skip_space>
    if (ctx->ungotten >= 0)
     d8a:	018da783          	lw	a5,24(s11)
     d8e:	1207dd63          	bgez	a5,ec8 <_vscanf_core.constprop.0+0x47a>
     d92:	856e                	mv	a0,s11
     d94:	c01ff0ef          	jal	994 <_in_char.part.0>
            if (c == '-' || c == '+')
     d98:	fd55069b          	addiw	a3,a0,-43
     d9c:	ffd6f613          	andi	a2,a3,-3
     da0:	2601                	sext.w	a2,a2
     da2:	87aa                	mv	a5,a0
     da4:	12060c63          	beqz	a2,edc <_vscanf_core.constprop.0+0x48e>
            while (c != -1 && i < 63)
     da8:	567d                	li	a2,-1
     daa:	16c50963          	beq	a0,a2,f1c <_vscanf_core.constprop.0+0x4ce>
     dae:	fce6                	sd	s9,120(sp)
            int i = 0, c = _in_char(ctx);
     db0:	4d01                	li	s10,0
     db2:	80000937          	lui	s2,0x80000
     db6:	197d                	addi	s2,s2,-1 # ffffffff7fffffff <_ZSt4cerr+0xffffffff7fff8687>
     db8:	0932                	slli	s2,s2,0xc
     dba:	80194913          	xori	s2,s2,-2047
     dbe:	093e                	slli	s2,s2,0xf
     dc0:	02010813          	addi	a6,sp,32
     dc4:	01a80cb3          	add	s9,a6,s10
     dc8:	03a00c13          	li	s8,58
     dcc:	1935                	addi	s2,s2,-19
     dce:	a831                	j	dea <_vscanf_core.constprop.0+0x39c>
     dd0:	bc5ff0ef          	jal	994 <_in_char.part.0>
            while (c != -1 && i < 63)
     dd4:	577d                	li	a4,-1
     dd6:	87aa                	mv	a5,a0
     dd8:	2ee50563          	beq	a0,a4,10c2 <_vscanf_core.constprop.0+0x674>
     ddc:	03f00713          	li	a4,63
     de0:	0c85                	addi	s9,s9,1
     de2:	1eed0e63          	beq	s10,a4,fde <_vscanf_core.constprop.0+0x590>
     de6:	fd57869b          	addiw	a3,a5,-43
        int c = ctx->ungotten;
     dea:	00d95633          	srl	a2,s2,a3
     dee:	856e                	mv	a0,s11
     df0:	8a05                	andi	a2,a2,1
     df2:	1edc6663          	bltu	s8,a3,fde <_vscanf_core.constprop.0+0x590>
     df6:	1e060463          	beqz	a2,fde <_vscanf_core.constprop.0+0x590>
                    num_buf[i++] = (char)c;
     dfa:	00fc8023          	sb	a5,0(s9)
    if (ctx->ungotten >= 0)
     dfe:	018da783          	lw	a5,24(s11)
                    num_buf[i++] = (char)c;
     e02:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
     e04:	fc07c6e3          	bltz	a5,dd0 <_vscanf_core.constprop.0+0x382>
        ctx->ungotten = -1;
     e08:	577d                	li	a4,-1
     e0a:	00edac23          	sw	a4,24(s11)
            while (c != -1 && i < 63)
     e0e:	b7f9                	j	ddc <_vscanf_core.constprop.0+0x38e>
            if (*p == 'h')
     e10:	00144c03          	lbu	s8,1(s0)
        int len_mod = 0;
     e14:	ec02                	sd	zero,24(sp)
            if (*p == 'h')
     e16:	d4bc1be3          	bne	s8,a1,b6c <_vscanf_core.constprop.0+0x11e>
        char spec = *p++;
     e1a:	00244c03          	lbu	s8,2(s0)
                p++;
     e1e:	00240b93          	addi	s7,s0,2
     e22:	b3a9                	j	b6c <_vscanf_core.constprop.0+0x11e>
     e24:	fce6                	sd	s9,120(sp)
     e26:	f8ea                	sd	s10,112(sp)
            int count = (width > 0) ? width : 1;
     e28:	00090c1b          	sext.w	s8,s2
     e2c:	0d205a63          	blez	s2,f00 <_vscanf_core.constprop.0+0x4b2>
            char *buf = suppress ? NULL : va_arg(ap, char *);
     e30:	4d01                	li	s10,0
     e32:	06098d63          	beqz	s3,eac <_vscanf_core.constprop.0+0x45e>
            for (int i = 0; i < count; i++)
     e36:	9c6a                	add	s8,s8,s10
                if (c == -1)
     e38:	5cfd                	li	s9,-1
    if (ctx->ungotten >= 0)
     e3a:	018da783          	lw	a5,24(s11)
        ctx->ungotten = -1;
     e3e:	856e                	mv	a0,s11
    if (ctx->ungotten >= 0)
     e40:	0207dc63          	bgez	a5,e78 <_vscanf_core.constprop.0+0x42a>
     e44:	b51ff0ef          	jal	994 <_in_char.part.0>
     e48:	87aa                	mv	a5,a0
                if (c == -1)
     e4a:	0b950d63          	beq	a0,s9,f04 <_vscanf_core.constprop.0+0x4b6>
                if (!suppress)
     e4e:	00099463          	bnez	s3,e56 <_vscanf_core.constprop.0+0x408>
                    buf[i] = (char)c;
     e52:	00fd0023          	sb	a5,0(s10)
            for (int i = 0; i < count; i++)
     e56:	0d05                	addi	s10,s10,1
     e58:	ffac11e3          	bne	s8,s10,e3a <_vscanf_core.constprop.0+0x3ec>
    while (*p)
     e5c:	001bc783          	lbu	a5,1(s7)
            if (!suppress)
     e60:	00099363          	bnez	s3,e66 <_vscanf_core.constprop.0+0x418>
                assigned++;
     e64:	2b05                	addiw	s6,s6,1
     e66:	794a                	ld	s2,176(sp)
     e68:	79aa                	ld	s3,168(sp)
     e6a:	6baa                	ld	s7,136(sp)
     e6c:	6c0a                	ld	s8,128(sp)
     e6e:	7ce6                	ld	s9,120(sp)
     e70:	7d46                	ld	s10,112(sp)
    while (*p)
     e72:	c00793e3          	bnez	a5,a78 <_vscanf_core.constprop.0+0x2a>
     e76:	b935                	j	ab2 <_vscanf_core.constprop.0+0x64>
        ctx->ungotten = -1;
     e78:	019dac23          	sw	s9,24(s11)
                if (c == -1)
     e7c:	bfc9                	j	e4e <_vscanf_core.constprop.0+0x400>
     e7e:	640e                	ld	s0,192(sp)
     e80:	74ea                	ld	s1,184(sp)
     e82:	794a                	ld	s2,176(sp)
     e84:	79aa                	ld	s3,168(sp)
     e86:	7a0a                	ld	s4,160(sp)
     e88:	6aea                	ld	s5,152(sp)
     e8a:	6baa                	ld	s7,136(sp)
     e8c:	6c0a                	ld	s8,128(sp)
     e8e:	7da6                	ld	s11,104(sp)
     e90:	b135                	j	abc <_vscanf_core.constprop.0+0x6e>
        int width = -1;
     e92:	597d                	li	s2,-1
     e94:	b975                	j	b50 <_vscanf_core.constprop.0+0x102>
            if (!suppress)
     e96:	3c099c63          	bnez	s3,126e <_vscanf_core.constprop.0+0x820>
                buf[i] = '\0';
     e9a:	67e2                	ld	a5,24(sp)
     e9c:	01a786b3          	add	a3,a5,s10
     ea0:	00068023          	sb	zero,0(a3)
    while (*p)
     ea4:	001bc783          	lbu	a5,1(s7)
                assigned++;
     ea8:	2b05                	addiw	s6,s6,1
     eaa:	bf75                	j	e66 <_vscanf_core.constprop.0+0x418>
            char *buf = suppress ? NULL : va_arg(ap, char *);
     eac:	67a2                	ld	a5,8(sp)
     eae:	0007bd03          	ld	s10,0(a5)
     eb2:	07a1                	addi	a5,a5,8
     eb4:	e43e                	sd	a5,8(sp)
     eb6:	b741                	j	e36 <_vscanf_core.constprop.0+0x3e8>
        ctx->ungotten = -1;
     eb8:	56fd                	li	a3,-1
     eba:	00ddac23          	sw	a3,24(s11)
            while (c != -1 && !isspace(c))
     ebe:	bb11                	j	bd2 <_vscanf_core.constprop.0+0x184>
        ctx->ungotten = -1;
     ec0:	56fd                	li	a3,-1
     ec2:	00ddac23          	sw	a3,24(s11)
        return c;
     ec6:	b3d1                	j	c8a <_vscanf_core.constprop.0+0x23c>
            if (c == '-' || c == '+')
     ec8:	fd57869b          	addiw	a3,a5,-43
     ecc:	ffd6f613          	andi	a2,a3,-3
        ctx->ungotten = -1;
     ed0:	55fd                	li	a1,-1
     ed2:	00bdac23          	sw	a1,24(s11)
            if (c == '-' || c == '+')
     ed6:	2601                	sext.w	a2,a2
     ed8:	ec061be3          	bnez	a2,dae <_vscanf_core.constprop.0+0x360>
                num_buf[i++] = (char)c;
     edc:	02f10023          	sb	a5,32(sp)
    if (ctx->ungotten >= 0)
     ee0:	018da783          	lw	a5,24(s11)
     ee4:	2207da63          	bgez	a5,1118 <_vscanf_core.constprop.0+0x6ca>
     ee8:	856e                	mv	a0,s11
     eea:	aabff0ef          	jal	994 <_in_char.part.0>
            while (c != -1 && i < 63)
     eee:	567d                	li	a2,-1
     ef0:	87aa                	mv	a5,a0
                num_buf[i++] = (char)c;
     ef2:	4d05                	li	s10,1
     ef4:	fd55069b          	addiw	a3,a0,-43
            while (c != -1 && i < 63)
     ef8:	3ac50163          	beq	a0,a2,129a <_vscanf_core.constprop.0+0x84c>
     efc:	fce6                	sd	s9,120(sp)
     efe:	bd55                	j	db2 <_vscanf_core.constprop.0+0x364>
            int count = (width > 0) ? width : 1;
     f00:	4c05                	li	s8,1
     f02:	b73d                	j	e30 <_vscanf_core.constprop.0+0x3e2>
     f04:	640e                	ld	s0,192(sp)
     f06:	74ea                	ld	s1,184(sp)
     f08:	794a                	ld	s2,176(sp)
     f0a:	79aa                	ld	s3,168(sp)
     f0c:	7a0a                	ld	s4,160(sp)
     f0e:	6aea                	ld	s5,152(sp)
     f10:	6baa                	ld	s7,136(sp)
     f12:	6c0a                	ld	s8,128(sp)
     f14:	7ce6                	ld	s9,120(sp)
     f16:	7d46                	ld	s10,112(sp)
     f18:	7da6                	ld	s11,104(sp)
     f1a:	b64d                	j	abc <_vscanf_core.constprop.0+0x6e>
     f1c:	640e                	ld	s0,192(sp)
     f1e:	74ea                	ld	s1,184(sp)
     f20:	794a                	ld	s2,176(sp)
     f22:	79aa                	ld	s3,168(sp)
     f24:	7a0a                	ld	s4,160(sp)
     f26:	6aea                	ld	s5,152(sp)
     f28:	6baa                	ld	s7,136(sp)
     f2a:	6c0a                	ld	s8,128(sp)
     f2c:	7d46                	ld	s10,112(sp)
     f2e:	7da6                	ld	s11,104(sp)
     f30:	b671                	j	abc <_vscanf_core.constprop.0+0x6e>
        ctx->ungotten = -1;
     f32:	018dac23          	sw	s8,24(s11)
            while (c != -1 && !isspace(c))
     f36:	b9e5                	j	c2e <_vscanf_core.constprop.0+0x1e0>
        ctx->ungotten = -1;
     f38:	57fd                	li	a5,-1
     f3a:	00fdac23          	sw	a5,24(s11)
            while (c != -1 && i < 63)
     f3e:	bbd9                	j	d14 <_vscanf_core.constprop.0+0x2c6>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     f40:	f9f3069b          	addiw	a3,t1,-97
     f44:	4795                	li	a5,5
     f46:	06d7f263          	bgeu	a5,a3,faa <_vscanf_core.constprop.0+0x55c>
     f4a:	fbf3031b          	addiw	t1,t1,-65
     f4e:	4795                	li	a5,5
     f50:	0467fd63          	bgeu	a5,t1,faa <_vscanf_core.constprop.0+0x55c>
                int x = (c == 'x' || c == 'X');
     f54:	07800693          	li	a3,120
     f58:	18d50763          	beq	a0,a3,10e6 <_vscanf_core.constprop.0+0x698>
     f5c:	fa850693          	addi	a3,a0,-88
     f60:	0016b693          	seqz	a3,a3
                if (base == 0 && i == 1 && num_buf[0] == '0' && x)
     f64:	4301                	li	t1,0
     f66:	32061663          	bnez	a2,1292 <_vscanf_core.constprop.0+0x844>
     f6a:	4785                	li	a5,1
     f6c:	4601                	li	a2,0
     f6e:	d6fd1ce3          	bne	s10,a5,ce6 <_vscanf_core.constprop.0+0x298>
     f72:	02014e03          	lbu	t3,32(sp)
     f76:	03000793          	li	a5,48
     f7a:	d6fe16e3          	bne	t3,a5,ce6 <_vscanf_core.constprop.0+0x298>
     f7e:	d60684e3          	beqz	a3,ce6 <_vscanf_core.constprop.0+0x298>
                    base = 16;
     f82:	4641                	li	a2,16
                if (width > 0 && i >= width)
     f84:	d7a919e3          	bne	s2,s10,cf6 <_vscanf_core.constprop.0+0x2a8>
     f88:	bb59                	j	d1e <_vscanf_core.constprop.0+0x2d0>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     f8a:	f9f3069b          	addiw	a3,t1,-97
     f8e:	4795                	li	a5,5
     f90:	02d7f263          	bgeu	a5,a3,fb4 <_vscanf_core.constprop.0+0x566>
     f94:	fbf3031b          	addiw	t1,t1,-65
     f98:	0467f063          	bgeu	a5,t1,fd8 <_vscanf_core.constprop.0+0x58a>
                int x = (c == 'x' || c == 'X');
     f9c:	07800693          	li	a3,120
     fa0:	fad51ee3          	bne	a0,a3,f5c <_vscanf_core.constprop.0+0x50e>
     fa4:	4301                	li	t1,0
     fa6:	4685                	li	a3,1
     fa8:	b7c9                	j	f6a <_vscanf_core.constprop.0+0x51c>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     faa:	4305                	li	t1,1
                int x = (c == 'x' || c == 'X');
     fac:	4681                	li	a3,0
                if (width > 0 && i >= width)
     fae:	d3204ee3          	bgtz	s2,cea <_vscanf_core.constprop.0+0x29c>
     fb2:	bb35                	j	cee <_vscanf_core.constprop.0+0x2a0>
                int x = (c == 'x' || c == 'X');
     fb4:	4681                	li	a3,0
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     fb6:	4305                	li	t1,1
                if (width > 0 && i >= width)
     fb8:	d32049e3          	bgtz	s2,cea <_vscanf_core.constprop.0+0x29c>
     fbc:	bb0d                	j	cee <_vscanf_core.constprop.0+0x2a0>
     fbe:	4301                	li	t1,0
                int x = (c == 'x' || c == 'X');
     fc0:	4685                	li	a3,1
                if (width > 0 && i >= width)
     fc2:	d32044e3          	bgtz	s2,cea <_vscanf_core.constprop.0+0x29c>
     fc6:	bb05                	j	cf6 <_vscanf_core.constprop.0+0x2a8>
            if (!suppress)
     fc8:	c8099be3          	bnez	s3,c5e <_vscanf_core.constprop.0+0x210>
                buf[i] = '\0';
     fcc:	67e2                	ld	a5,24(sp)
     fce:	00078023          	sb	zero,0(a5)
        ctx->ungotten = c;
     fd2:	00adac23          	sw	a0,24(s11)
            if (i > 0 && !suppress)
     fd6:	b171                	j	c62 <_vscanf_core.constprop.0+0x214>
                int x = (c == 'x' || c == 'X');
     fd8:	4681                	li	a3,0
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
     fda:	4305                	li	t1,1
     fdc:	b779                	j	f6a <_vscanf_core.constprop.0+0x51c>
            num_buf[i] = '\0';
     fde:	040d0713          	addi	a4,s10,64
     fe2:	1014                	addi	a3,sp,32
     fe4:	96ba                	add	a3,a3,a4
     fe6:	fc068023          	sb	zero,-64(a3)
        ctx->ungotten = c;
     fea:	00fdac23          	sw	a5,24(s11)
            if (i == 0)
     fee:	f00d0be3          	beqz	s10,f04 <_vscanf_core.constprop.0+0x4b6>
     ff2:	7ce6                	ld	s9,120(sp)
            if (!suppress)
     ff4:	d40992e3          	bnez	s3,d38 <_vscanf_core.constprop.0+0x2ea>
    if (*str == '-')
     ff8:	02014603          	lbu	a2,32(sp)
     ffc:	02d00793          	li	a5,45
    1000:	1af60963          	beq	a2,a5,11b2 <_vscanf_core.constprop.0+0x764>
    else if (*str == '+')
    1004:	02b00793          	li	a5,43
    1008:	20f60a63          	beq	a2,a5,121c <_vscanf_core.constprop.0+0x7ce>
    100c:	00005797          	auipc	a5,0x5
    1010:	8e47b587          	fld	fa1,-1820(a5) # 58f0 <STDIN_FD+0x10>
    1014:	101c                	addi	a5,sp,32
    while (*str >= '0' && *str <= '9')
    1016:	fd06069b          	addiw	a3,a2,-48
    101a:	0ff6f513          	zext.b	a0,a3
    101e:	45a5                	li	a1,9
    1020:	f20007d3          	fmv.d.x	fa5,zero
    1024:	02a5e463          	bltu	a1,a0,104c <_vscanf_core.constprop.0+0x5fe>
    1028:	00005717          	auipc	a4,0x5
    102c:	8d073707          	fld	fa4,-1840(a4) # 58f8 <STDIN_FD+0x18>
    1030:	4525                	li	a0,9
    1032:	0017c603          	lbu	a2,1(a5)
        val = val * 10.0 + (*str - '0');
    1036:	d20686d3          	fcvt.d.w	fa3,a3
        str++;
    103a:	0785                	addi	a5,a5,1
    while (*str >= '0' && *str <= '9')
    103c:	fd06069b          	addiw	a3,a2,-48
    1040:	0ff6f593          	zext.b	a1,a3
        val = val * 10.0 + (*str - '0');
    1044:	6ae7f7c3          	fmadd.d	fa5,fa5,fa4,fa3
    while (*str >= '0' && *str <= '9')
    1048:	feb575e3          	bgeu	a0,a1,1032 <_vscanf_core.constprop.0+0x5e4>
    if (*str == '.')
    104c:	02e00693          	li	a3,46
    1050:	16d60a63          	beq	a2,a3,11c4 <_vscanf_core.constprop.0+0x776>
    if (*str == 'e' || *str == 'E')
    1054:	0007c683          	lbu	a3,0(a5)
    1058:	0df6f693          	andi	a3,a3,223
    105c:	04500613          	li	a2,69
    1060:	0cc68463          	beq	a3,a2,1128 <_vscanf_core.constprop.0+0x6da>
                    *va_arg(ap, double *) = val;
    1064:	6722                	ld	a4,8(sp)
                if (len_mod == 1)
    1066:	4685                	li	a3,1
    return sign * val;
    1068:	12b7f7d3          	fmul.d	fa5,fa5,fa1
                    *va_arg(ap, double *) = val;
    106c:	631c                	ld	a5,0(a4)
                    *va_arg(ap, int64 *) = val;
    106e:	0721                	addi	a4,a4,8
    1070:	e43a                	sd	a4,8(sp)
                if (len_mod == 1)
    1072:	6762                	ld	a4,24(sp)
    1074:	18d70b63          	beq	a4,a3,120a <_vscanf_core.constprop.0+0x7bc>
                    *va_arg(ap, float *) = (float)val;
    1078:	4017f7d3          	fcvt.s.d	fa5,fa5
                assigned++;
    107c:	2b05                	addiw	s6,s6,1
                    *va_arg(ap, float *) = (float)val;
    107e:	00f7a027          	fsw	fa5,0(a5)
    1082:	b95d                	j	d38 <_vscanf_core.constprop.0+0x2ea>
                num_buf[i++] = (char)c;
    1084:	02a10023          	sb	a0,32(sp)
    if (ctx->ungotten >= 0)
    1088:	018da503          	lw	a0,24(s11)
    108c:	06055463          	bgez	a0,10f4 <_vscanf_core.constprop.0+0x6a6>
    1090:	856e                	mv	a0,s11
    1092:	903ff0ef          	jal	994 <_in_char.part.0>
                num_buf[i++] = (char)c;
    1096:	4d05                	li	s10,1
    1098:	b101                	j	c98 <_vscanf_core.constprop.0+0x24a>
                int64 val = strtoll(num_buf, NULL, base);
    109a:	4581                	li	a1,0
    109c:	1008                	addi	a0,sp,32
    109e:	696030ef          	jal	4734 <strtoll>
                    *va_arg(ap, int64 *) = val;
    10a2:	67a2                	ld	a5,8(sp)
                if (len_mod == 2)
    10a4:	6762                	ld	a4,24(sp)
    10a6:	4689                	li	a3,2
                    *va_arg(ap, int64 *) = val;
    10a8:	07a1                	addi	a5,a5,8
                if (len_mod == 2)
    10aa:	16d70363          	beq	a4,a3,1210 <_vscanf_core.constprop.0+0x7c2>
                    *va_arg(ap, int64 *) = val;
    10ae:	6722                	ld	a4,8(sp)
                else if (len_mod == 1)
    10b0:	4605                	li	a2,1
                    *va_arg(ap, int64 *) = val;
    10b2:	6314                	ld	a3,0(a4)
                else if (len_mod == 1)
    10b4:	6762                	ld	a4,24(sp)
    10b6:	16c70163          	beq	a4,a2,1218 <_vscanf_core.constprop.0+0x7ca>
                    *va_arg(ap, int *) = (int)val;
    10ba:	c288                	sw	a0,0(a3)
                assigned++;
    10bc:	2b05                	addiw	s6,s6,1
    10be:	e43e                	sd	a5,8(sp)
    10c0:	b9a5                	j	d38 <_vscanf_core.constprop.0+0x2ea>
            num_buf[i] = '\0';
    10c2:	040d0793          	addi	a5,s10,64
    10c6:	1018                	addi	a4,sp,32
    10c8:	00e785b3          	add	a1,a5,a4
    10cc:	fc058023          	sb	zero,-64(a1)
            if (i == 0)
    10d0:	7ce6                	ld	s9,120(sp)
    10d2:	b70d                	j	ff4 <_vscanf_core.constprop.0+0x5a6>
            num_buf[i] = '\0';
    10d4:	040d0793          	addi	a5,s10,64
    10d8:	1018                	addi	a4,sp,32
    10da:	00e78833          	add	a6,a5,a4
    10de:	fc080023          	sb	zero,-64(a6)
            if (i == 0)
    10e2:	7ce6                	ld	s9,120(sp)
    10e4:	b981                	j	d34 <_vscanf_core.constprop.0+0x2e6>
                int x = (c == 'x' || c == 'X');
    10e6:	4301                	li	t1,0
    10e8:	4685                	li	a3,1
                if (width > 0 && i >= width)
    10ea:	c12040e3          	bgtz	s2,cea <_vscanf_core.constprop.0+0x29c>
    10ee:	b101                	j	cee <_vscanf_core.constprop.0+0x2a0>
    int assigned = 0;
    10f0:	4b01                	li	s6,0
    10f2:	b2e9                	j	abc <_vscanf_core.constprop.0+0x6e>
        ctx->ungotten = -1;
    10f4:	56fd                	li	a3,-1
    10f6:	fce6                	sd	s9,120(sp)
    10f8:	00ddac23          	sw	a3,24(s11)
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
    10fc:	07800693          	li	a3,120
    1100:	4641                	li	a2,16
                num_buf[i++] = (char)c;
    1102:	4d05                	li	s10,1
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
    1104:	badc09e3          	beq	s8,a3,cb6 <_vscanf_core.constprop.0+0x268>
    1108:	06900693          	li	a3,105
    110c:	4629                	li	a2,10
                num_buf[i++] = (char)c;
    110e:	4d05                	li	s10,1
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
    1110:	badc13e3          	bne	s8,a3,cb6 <_vscanf_core.constprop.0+0x268>
    1114:	4601                	li	a2,0
    1116:	b645                	j	cb6 <_vscanf_core.constprop.0+0x268>
        ctx->ungotten = -1;
    1118:	56fd                	li	a3,-1
    111a:	fce6                	sd	s9,120(sp)
    111c:	00ddac23          	sw	a3,24(s11)
                num_buf[i++] = (char)c;
    1120:	4d05                	li	s10,1
    1122:	fd57869b          	addiw	a3,a5,-43
    1126:	b171                	j	db2 <_vscanf_core.constprop.0+0x364>
        if (*str == '-')
    1128:	0017c583          	lbu	a1,1(a5)
    112c:	02d00693          	li	a3,45
    1130:	0ed58f63          	beq	a1,a3,122e <_vscanf_core.constprop.0+0x7e0>
        else if (*str == '+')
    1134:	02b00693          	li	a3,43
    1138:	10d58e63          	beq	a1,a3,1254 <_vscanf_core.constprop.0+0x806>
        while (*str >= '0' && *str <= '9')
    113c:	fd05861b          	addiw	a2,a1,-48
    1140:	0ff67513          	zext.b	a0,a2
    1144:	45a5                	li	a1,9
        str++;
    1146:	00178693          	addi	a3,a5,1
        int esign = 1;
    114a:	4805                	li	a6,1
        while (*str >= '0' && *str <= '9')
    114c:	04a5ec63          	bltu	a1,a0,11a4 <_vscanf_core.constprop.0+0x756>
    1150:	4525                	li	a0,9
    1152:	0016c583          	lbu	a1,1(a3)
            eval = eval * 10 + (*str - '0');
    1156:	0029979b          	slliw	a5,s3,0x2
    115a:	013787bb          	addw	a5,a5,s3
    115e:	0017979b          	slliw	a5,a5,0x1
    1162:	00f609bb          	addw	s3,a2,a5
        while (*str >= '0' && *str <= '9')
    1166:	fd05861b          	addiw	a2,a1,-48
    116a:	0ff67593          	zext.b	a1,a2
            str++;
    116e:	0685                	addi	a3,a3,1
        while (*str >= '0' && *str <= '9')
    1170:	feb571e3          	bgeu	a0,a1,1152 <_vscanf_core.constprop.0+0x704>
        while (eval--)
    1174:	fff9879b          	addiw	a5,s3,-1
    1178:	12098463          	beqz	s3,12a0 <_vscanf_core.constprop.0+0x852>
        double p = 1.0;
    117c:	00004717          	auipc	a4,0x4
    1180:	77473687          	fld	fa3,1908(a4) # 58f0 <STDIN_FD+0x10>
    1184:	00004717          	auipc	a4,0x4
    1188:	77473707          	fld	fa4,1908(a4) # 58f8 <STDIN_FD+0x18>
        while (eval--)
    118c:	56fd                	li	a3,-1
    118e:	37fd                	addiw	a5,a5,-1
            p *= 10.0;
    1190:	12e6f6d3          	fmul.d	fa3,fa3,fa4
        while (eval--)
    1194:	fed79de3          	bne	a5,a3,118e <_vscanf_core.constprop.0+0x740>
        if (esign == 1)
    1198:	4785                	li	a5,1
    119a:	00f80963          	beq	a6,a5,11ac <_vscanf_core.constprop.0+0x75e>
            val /= p;
    119e:	1ad7f7d3          	fdiv.d	fa5,fa5,fa3
    11a2:	b5c9                	j	1064 <_vscanf_core.constprop.0+0x616>
        double p = 1.0;
    11a4:	00004797          	auipc	a5,0x4
    11a8:	74c7b687          	fld	fa3,1868(a5) # 58f0 <STDIN_FD+0x10>
            val *= p;
    11ac:	12d7f7d3          	fmul.d	fa5,fa5,fa3
    11b0:	bd55                	j	1064 <_vscanf_core.constprop.0+0x616>
    while (*str >= '0' && *str <= '9')
    11b2:	00004797          	auipc	a5,0x4
    11b6:	7367b587          	fld	fa1,1846(a5) # 58e8 <STDIN_FD+0x8>
    11ba:	02114603          	lbu	a2,33(sp)
        str++;
    11be:	02110793          	addi	a5,sp,33
    11c2:	bd91                	j	1016 <_vscanf_core.constprop.0+0x5c8>
        while (*str >= '0' && *str <= '9')
    11c4:	0017c683          	lbu	a3,1(a5)
    11c8:	45a5                	li	a1,9
        str++;
    11ca:	0785                	addi	a5,a5,1
        while (*str >= '0' && *str <= '9')
    11cc:	fd06861b          	addiw	a2,a3,-48
    11d0:	0ff67513          	zext.b	a0,a2
    11d4:	e8a5e2e3          	bltu	a1,a0,1058 <_vscanf_core.constprop.0+0x60a>
        double div = 10.0;
    11d8:	00004717          	auipc	a4,0x4
    11dc:	72073707          	fld	fa4,1824(a4) # 58f8 <STDIN_FD+0x18>
    11e0:	22e70653          	fmv.d	fa2,fa4
        while (*str >= '0' && *str <= '9')
    11e4:	4525                	li	a0,9
            val += (*str - '0') / div;
    11e6:	d20606d3          	fcvt.d.w	fa3,a2
        while (*str >= '0' && *str <= '9')
    11ea:	0017c683          	lbu	a3,1(a5)
            str++;
    11ee:	0785                	addi	a5,a5,1
            val += (*str - '0') / div;
    11f0:	1ac6f6d3          	fdiv.d	fa3,fa3,fa2
        while (*str >= '0' && *str <= '9')
    11f4:	fd06861b          	addiw	a2,a3,-48
    11f8:	0ff67593          	zext.b	a1,a2
            div *= 10.0;
    11fc:	12e67653          	fmul.d	fa2,fa2,fa4
            val += (*str - '0') / div;
    1200:	02d7f7d3          	fadd.d	fa5,fa5,fa3
        while (*str >= '0' && *str <= '9')
    1204:	feb571e3          	bgeu	a0,a1,11e6 <_vscanf_core.constprop.0+0x798>
    1208:	bd81                	j	1058 <_vscanf_core.constprop.0+0x60a>
                    *va_arg(ap, double *) = val;
    120a:	a39c                	fsd	fa5,0(a5)
                assigned++;
    120c:	2b05                	addiw	s6,s6,1
    120e:	b62d                	j	d38 <_vscanf_core.constprop.0+0x2ea>
                    *va_arg(ap, int64 *) = val;
    1210:	6722                	ld	a4,8(sp)
    1212:	6314                	ld	a3,0(a4)
    1214:	e288                	sd	a0,0(a3)
    1216:	b55d                	j	10bc <_vscanf_core.constprop.0+0x66e>
                    *va_arg(ap, long *) = (long)val;
    1218:	e288                	sd	a0,0(a3)
    121a:	b54d                	j	10bc <_vscanf_core.constprop.0+0x66e>
    while (*str >= '0' && *str <= '9')
    121c:	00004797          	auipc	a5,0x4
    1220:	6d47b587          	fld	fa1,1748(a5) # 58f0 <STDIN_FD+0x10>
    1224:	02114603          	lbu	a2,33(sp)
        str++;
    1228:	02110793          	addi	a5,sp,33
    122c:	b3ed                	j	1016 <_vscanf_core.constprop.0+0x5c8>
        while (*str >= '0' && *str <= '9')
    122e:	0027c583          	lbu	a1,2(a5)
            str++;
    1232:	00278693          	addi	a3,a5,2
        while (*str >= '0' && *str <= '9')
    1236:	4525                	li	a0,9
    1238:	fd05861b          	addiw	a2,a1,-48
    123c:	0ff67793          	zext.b	a5,a2
            esign = -1;
    1240:	587d                	li	a6,-1
        while (*str >= '0' && *str <= '9')
    1242:	f0f577e3          	bgeu	a0,a5,1150 <_vscanf_core.constprop.0+0x702>
        double p = 1.0;
    1246:	00004797          	auipc	a5,0x4
    124a:	6aa7b687          	fld	fa3,1706(a5) # 58f0 <STDIN_FD+0x10>
            val /= p;
    124e:	1ad7f7d3          	fdiv.d	fa5,fa5,fa3
    1252:	bd09                	j	1064 <_vscanf_core.constprop.0+0x616>
        while (*str >= '0' && *str <= '9')
    1254:	0027c583          	lbu	a1,2(a5)
            str++;
    1258:	00278693          	addi	a3,a5,2
        while (*str >= '0' && *str <= '9')
    125c:	4525                	li	a0,9
    125e:	fd05861b          	addiw	a2,a1,-48
    1262:	0ff67793          	zext.b	a5,a2
    1266:	f2f56fe3          	bltu	a0,a5,11a4 <_vscanf_core.constprop.0+0x756>
        int esign = 1;
    126a:	4805                	li	a6,1
    126c:	b5d5                	j	1150 <_vscanf_core.constprop.0+0x702>
    while (*p)
    126e:	001bc783          	lbu	a5,1(s7)
    1272:	bed5                	j	e66 <_vscanf_core.constprop.0+0x418>
            if (!suppress)
    1274:	9e0997e3          	bnez	s3,c62 <_vscanf_core.constprop.0+0x214>
                buf[i] = '\0';
    1278:	67e2                	ld	a5,24(sp)
    127a:	00078023          	sb	zero,0(a5)
    127e:	b2d5                	j	c62 <_vscanf_core.constprop.0+0x214>
            num_buf[i] = '\0';
    1280:	040d0793          	addi	a5,s10,64
    1284:	1018                	addi	a4,sp,32
    1286:	97ba                	add	a5,a5,a4
    1288:	fc078023          	sb	zero,-64(a5)
            if (i == 0)
    128c:	aa0d14e3          	bnez	s10,d34 <_vscanf_core.constprop.0+0x2e6>
    1290:	b171                	j	f1c <_vscanf_core.constprop.0+0x4ce>
    1292:	4641                	li	a2,16
                if (width > 0 && i >= width)
    1294:	a5204be3          	bgtz	s2,cea <_vscanf_core.constprop.0+0x29c>
    1298:	bc99                	j	cee <_vscanf_core.constprop.0+0x2a0>
            num_buf[i] = '\0';
    129a:	020100a3          	sb	zero,33(sp)
            if (i == 0)
    129e:	bb99                	j	ff4 <_vscanf_core.constprop.0+0x5a6>
        double p = 1.0;
    12a0:	00004797          	auipc	a5,0x4
    12a4:	6507b687          	fld	fa3,1616(a5) # 58f0 <STDIN_FD+0x10>
    12a8:	bdc5                	j	1198 <_vscanf_core.constprop.0+0x74a>
                buf[i] = '\0';
    12aa:	67e2                	ld	a5,24(sp)
    12ac:	01a786b3          	add	a3,a5,s10
    12b0:	00068023          	sb	zero,0(a3)
        ctx->ungotten = c;
    12b4:	00adac23          	sw	a0,24(s11)
    while (*p)
    12b8:	001bc783          	lbu	a5,1(s7)
    12bc:	b6f5                	j	ea8 <_vscanf_core.constprop.0+0x45a>

00000000000012be <_out_char>:
{
    12be:	7179                	addi	sp,sp,-48
    12c0:	ec26                	sd	s1,24(sp)
    if (ctx->stream)
    12c2:	6d04                	ld	s1,24(a0)
{
    12c4:	f022                	sd	s0,32(sp)
    12c6:	f406                	sd	ra,40(sp)
    12c8:	842a                	mv	s0,a0
    12ca:	872e                	mv	a4,a1
    if (ctx->stream)
    12cc:	c0a1                	beqz	s1,130c <_out_char+0x4e>
    12ce:	e84a                	sd	s2,16(sp)
    if (stream->buf_mode == 2)
    12d0:	41c4a903          	lw	s2,1052(s1)
    12d4:	4789                	li	a5,2
    12d6:	04f90d63          	beq	s2,a5,1330 <_out_char+0x72>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    12da:	4104a783          	lw	a5,1040(s1)
    if (stream->buf_write_pos >= BUFSIZ)
    12de:	3ff00693          	li	a3,1023
    stream->buffer[stream->buf_write_pos++] = (char)c;
    12e2:	0017861b          	addiw	a2,a5,1
    12e6:	40c4a823          	sw	a2,1040(s1)
    12ea:	97a6                	add	a5,a5,s1
    12ec:	00b78823          	sb	a1,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    12f0:	08c6c063          	blt	a3,a2,1370 <_out_char+0xb2>
    else if (stream->buf_mode == 1 && c == '\n')
    12f4:	4785                	li	a5,1
    12f6:	04f90a63          	beq	s2,a5,134a <_out_char+0x8c>
        ctx->written++;
    12fa:	681c                	ld	a5,16(s0)
    12fc:	6942                	ld	s2,16(sp)
}
    12fe:	70a2                	ld	ra,40(sp)
        ctx->written++;
    1300:	0785                	addi	a5,a5,1
    1302:	e81c                	sd	a5,16(s0)
}
    1304:	7402                	ld	s0,32(sp)
    1306:	64e2                	ld	s1,24(sp)
    1308:	6145                	addi	sp,sp,48
    130a:	8082                	ret
        if (ctx->limit > 0 && ctx->written < ctx->limit - 1)
    130c:	6514                	ld	a3,8(a0)
    130e:	691c                	ld	a5,16(a0)
    1310:	ca89                	beqz	a3,1322 <_out_char+0x64>
    1312:	16fd                	addi	a3,a3,-1
    1314:	00d7f763          	bgeu	a5,a3,1322 <_out_char+0x64>
            ctx->buf[ctx->written] = c;
    1318:	6114                	ld	a3,0(a0)
    131a:	97b6                	add	a5,a5,a3
    131c:	00b78023          	sb	a1,0(a5)
        ctx->written++;
    1320:	691c                	ld	a5,16(a0)
    1322:	0785                	addi	a5,a5,1
}
    1324:	70a2                	ld	ra,40(sp)
        ctx->written++;
    1326:	e81c                	sd	a5,16(s0)
}
    1328:	7402                	ld	s0,32(sp)
    132a:	64e2                	ld	s1,24(sp)
    132c:	6145                	addi	sp,sp,48
    132e:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    1330:	4088                	lw	a0,0(s1)
    1332:	4605                	li	a2,1
    1334:	00f10593          	addi	a1,sp,15
        char ch = (char)c;
    1338:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    133c:	e8bfe0ef          	jal	1c6 <write>
    1340:	4785                	li	a5,1
    1342:	faf50ce3          	beq	a0,a5,12fa <_out_char+0x3c>
            stream->error = 1;
    1346:	c49c                	sw	a5,8(s1)
            return EOF;
    1348:	bf4d                	j	12fa <_out_char+0x3c>
    else if (stream->buf_mode == 1 && c == '\n')
    134a:	47a9                	li	a5,10
    134c:	faf597e3          	bne	a1,a5,12fa <_out_char+0x3c>
    if (stream->buf_write_pos > 0)
    1350:	fac055e3          	blez	a2,12fa <_out_char+0x3c>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    1354:	4088                	lw	a0,0(s1)
    1356:	01048593          	addi	a1,s1,16
    135a:	e6dfe0ef          	jal	1c6 <write>
        if (ret < stream->buf_write_pos)
    135e:	4104a783          	lw	a5,1040(s1)
    1362:	02f55063          	bge	a0,a5,1382 <_out_char+0xc4>
            stream->error = 1;
    1366:	0124a423          	sw	s2,8(s1)
            stream->buf_write_pos = 0;
    136a:	4004a823          	sw	zero,1040(s1)
            return EOF;
    136e:	b771                	j	12fa <_out_char+0x3c>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    1370:	4088                	lw	a0,0(s1)
    1372:	01048593          	addi	a1,s1,16
    1376:	e51fe0ef          	jal	1c6 <write>
        if (ret < stream->buf_write_pos)
    137a:	4104a783          	lw	a5,1040(s1)
    137e:	00f54563          	blt	a0,a5,1388 <_out_char+0xca>
        stream->buf_write_pos = 0;
    1382:	4004a823          	sw	zero,1040(s1)
    1386:	bf95                	j	12fa <_out_char+0x3c>
            stream->error = 1;
    1388:	4785                	li	a5,1
    138a:	c49c                	sw	a5,8(s1)
            stream->buf_write_pos = 0;
    138c:	4004a823          	sw	zero,1040(s1)
            return EOF;
    1390:	b7ad                	j	12fa <_out_char+0x3c>

0000000000001392 <stbsp_set_separators>:
   "75767778798081828384858687888990919293949596979899"
};

STBSP__PUBLICDEF void STB_SPRINTF_DECORATE(set_separators)(char pcomma, char pperiod)
{
   stbsp__period = pperiod;
    1392:	00005797          	auipc	a5,0x5
    1396:	6ee78793          	addi	a5,a5,1774 # 6a80 <stbsp__digitpair>
    139a:	0cb78623          	sb	a1,204(a5)
   stbsp__comma = pcomma;
    139e:	0ca786a3          	sb	a0,205(a5)
}
    13a2:	8082                	ret

00000000000013a4 <stbsp_vsprintfcb>:

   return (stbsp__uint32)(sn - s);
}

STBSP__PUBLICDEF int STB_SPRINTF_DECORATE(vsprintfcb)(STBSP_SPRINTFCB *callback, void *user, char *buf, char const *fmt, va_list va)
{
    13a4:	d1010113          	addi	sp,sp,-752
            // Check if the next 4 bytes contain %(0x25) or end of string.
            // Using the 'hasless' trick:
            // https://graphics.stanford.edu/~seander/bithacks.html#HasLessInWord
            stbsp__uint32 v, c;
            v = *(stbsp__uint32 *)f;
            c = (~v) & 0x80808080;
    13a8:	808087b7          	lui	a5,0x80808
            if (((v ^ 0x25252525) - 0x01010101) & c)
    13ac:	252523b7          	lui	t2,0x25252
    13b0:	52538393          	addi	t2,t2,1317 # 25252525 <_ZSt4cerr+0x2524abad>
{
    13b4:	29913c23          	sd	s9,664(sp)
    13b8:	29b13423          	sd	s11,648(sp)
   int tlen = 0;
    13bc:	4c81                	li	s9,0
            if (((v ^ 0x25252525) - 0x01010101) & c)
    13be:	feff0db7          	lui	s11,0xfeff0
            c = (~v) & 0x80808080;
    13c2:	08078793          	addi	a5,a5,128 # ffffffff80808080 <_ZSt4cerr+0xffffffff80800708>
{
    13c6:	2e813023          	sd	s0,736(sp)
    13ca:	2c913c23          	sd	s1,728(sp)
    13ce:	2d213823          	sd	s2,720(sp)
    13d2:	2d313423          	sd	s3,712(sp)
    13d6:	2b713423          	sd	s7,680(sp)
    13da:	2b813023          	sd	s8,672(sp)
    13de:	29a13823          	sd	s10,656(sp)
    13e2:	2e113423          	sd	ra,744(sp)
    13e6:	8d66                	mv	s10,s9
    13e8:	8432                	mv	s0,a2
    13ea:	8c9e                	mv	s9,t2
    13ec:	89aa                	mv	s3,a0
    13ee:	e42e                	sd	a1,8(sp)
    13f0:	84b6                	mv	s1,a3
    13f2:	8bba                	mv	s7,a4
    13f4:	fc02                	sd	zero,56(sp)
   for (;;) {
    13f6:	8932                	mv	s2,a2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    13f8:	effd8d9b          	addiw	s11,s11,-257 # fffffffffefefeff <_ZSt4cerr+0xfffffffffefe8587>
               goto schk1;
            if ((v - 0x01010101) & c)
               goto schk2;
            if (callback)
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    13fc:	20000c13          	li	s8,512
    1400:	83be                	mv	t2,a5
         while (((stbsp__uintptr)f) & 3) {
    1402:	0034f793          	andi	a5,s1,3
    1406:	c7a9                	beqz	a5,1450 <stbsp_vsprintfcb+0xac>
            if (f[0] == '%')
    1408:	0004c783          	lbu	a5,0(s1)
    140c:	02500713          	li	a4,37
    1410:	0ee78263          	beq	a5,a4,14f4 <stbsp_vsprintfcb+0x150>
            if (f[0] == 0)
    1414:	cbd9                	beqz	a5,14aa <stbsp_vsprintfcb+0x106>
            stbsp__chk_cb_buf(1);
    1416:	02098663          	beqz	s3,1442 <stbsp_vsprintfcb+0x9e>
    141a:	4124063b          	subw	a2,s0,s2
    141e:	1fe00713          	li	a4,510
    1422:	02c75063          	bge	a4,a2,1442 <stbsp_vsprintfcb+0x9e>
    1426:	65a2                	ld	a1,8(sp)
    1428:	854a                	mv	a0,s2
    142a:	e81e                	sd	t2,16(sp)
    142c:	00cd0d3b          	addw	s10,s10,a2
    1430:	9982                	jalr	s3
    1432:	892a                	mv	s2,a0
    1434:	e119                	bnez	a0,143a <stbsp_vsprintfcb+0x96>
    1436:	0200106f          	j	2456 <stbsp_vsprintfcb+0x10b2>
            *bf++ = f[0];
    143a:	0004c783          	lbu	a5,0(s1)
            stbsp__chk_cb_buf(1);
    143e:	63c2                	ld	t2,16(sp)
    1440:	842a                	mv	s0,a0
            ++f;
    1442:	0485                	addi	s1,s1,1
            *bf++ = f[0];
    1444:	00f40023          	sb	a5,0(s0)
         while (((stbsp__uintptr)f) & 3) {
    1448:	0034f793          	andi	a5,s1,3
            *bf++ = f[0];
    144c:	0405                	addi	s0,s0,1
         while (((stbsp__uintptr)f) & 3) {
    144e:	ffcd                	bnez	a5,1408 <stbsp_vsprintfcb+0x64>
            v = *(stbsp__uint32 *)f;
    1450:	4094                	lw	a3,0(s1)
            c = (~v) & 0x80808080;
    1452:	fff6c793          	not	a5,a3
            if (((v ^ 0x25252525) - 0x01010101) & c)
    1456:	0196c733          	xor	a4,a3,s9
            c = (~v) & 0x80808080;
    145a:	0077f7b3          	and	a5,a5,t2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    145e:	01b7073b          	addw	a4,a4,s11
    1462:	8f7d                	and	a4,a4,a5
    1464:	2701                	sext.w	a4,a4
    1466:	f34d                	bnez	a4,1408 <stbsp_vsprintfcb+0x64>
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    1468:	460d                	li	a2,3
    146a:	a805                	j	149a <stbsp_vsprintfcb+0xf6>
            if (callback)
    146c:	00098863          	beqz	s3,147c <stbsp_vsprintfcb+0xd8>
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    1470:	412407b3          	sub	a5,s0,s2
    1474:	40fc07bb          	subw	a5,s8,a5
    1478:	f8f658e3          	bge	a2,a5,1408 <stbsp_vsprintfcb+0x64>
                    bf[2] = f[2];
                    bf[3] = f[3];
                } else
            #endif
            {
                *(stbsp__uint32 *)bf = v;
    147c:	c014                	sw	a3,0(s0)
            v = *(stbsp__uint32 *)f;
    147e:	40d4                	lw	a3,4(s1)
            }
            bf += 4;
    1480:	0411                	addi	s0,s0,4
            f += 4;
    1482:	0491                	addi	s1,s1,4
            c = (~v) & 0x80808080;
    1484:	fff6c793          	not	a5,a3
            if (((v ^ 0x25252525) - 0x01010101) & c)
    1488:	0196c733          	xor	a4,a3,s9
            c = (~v) & 0x80808080;
    148c:	0077f7b3          	and	a5,a5,t2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    1490:	01b7073b          	addw	a4,a4,s11
    1494:	8f7d                	and	a4,a4,a5
    1496:	2701                	sext.w	a4,a4
    1498:	fb25                	bnez	a4,1408 <stbsp_vsprintfcb+0x64>
            if ((v - 0x01010101) & c)
    149a:	01b6873b          	addw	a4,a3,s11
    149e:	8ff9                	and	a5,a5,a4
    14a0:	2781                	sext.w	a5,a5
    14a2:	d7e9                	beqz	a5,146c <stbsp_vsprintfcb+0xc8>
            if (f[0] == 0)
    14a4:	0004c783          	lbu	a5,0(s1)
    14a8:	f7bd                	bnez	a5,1416 <stbsp_vsprintfcb+0x72>
endfmt:

   if (!callback)
      *bf = 0;
   else
      stbsp__flush_cb();
    14aa:	8cea                	mv	s9,s10
    14ac:	412404bb          	subw	s1,s0,s2
   if (!callback)
    14b0:	70098563          	beqz	s3,1bba <stbsp_vsprintfcb+0x816>
      stbsp__flush_cb();
    14b4:	00905663          	blez	s1,14c0 <stbsp_vsprintfcb+0x11c>
    14b8:	65a2                	ld	a1,8(sp)
    14ba:	8626                	mv	a2,s1
    14bc:	854a                	mv	a0,s2
    14be:	9982                	jalr	s3
    14c0:	009c8cbb          	addw	s9,s9,s1

done:
   return tlen + (int)(bf - buf);
}
    14c4:	2e813083          	ld	ra,744(sp)
    14c8:	2e013403          	ld	s0,736(sp)
    14cc:	2d813483          	ld	s1,728(sp)
    14d0:	2d013903          	ld	s2,720(sp)
    14d4:	2c813983          	ld	s3,712(sp)
    14d8:	2a813b83          	ld	s7,680(sp)
    14dc:	2a013c03          	ld	s8,672(sp)
    14e0:	29013d03          	ld	s10,656(sp)
    14e4:	28813d83          	ld	s11,648(sp)
    14e8:	8566                	mv	a0,s9
    14ea:	29813c83          	ld	s9,664(sp)
    14ee:	2f010113          	addi	sp,sp,752
    14f2:	8082                	ret
    14f4:	2d413023          	sd	s4,704(sp)
    14f8:	2b513c23          	sd	s5,696(sp)
    14fc:	2b613823          	sd	s6,688(sp)
      tz = 0;
    1500:	00248693          	addi	a3,s1,2
      fl = 0;
    1504:	4e01                	li	t3,0
         switch (f[0]) {
    1506:	03f00593          	li	a1,63
    150a:	00004617          	auipc	a2,0x4
    150e:	d0660613          	addi	a2,a2,-762 # 5210 <_GLOBAL__sub_I__ZSt3cin+0x14a>
    1512:	fff6c783          	lbu	a5,-1(a3)
    1516:	fff68493          	addi	s1,a3,-1
    151a:	fe07871b          	addiw	a4,a5,-32
    151e:	0ff77713          	zext.b	a4,a4
    1522:	00e5ec63          	bltu	a1,a4,153a <stbsp_vsprintfcb+0x196>
    1526:	070a                	slli	a4,a4,0x2
    1528:	9732                	add	a4,a4,a2
    152a:	4318                	lw	a4,0(a4)
    152c:	9732                	add	a4,a4,a2
    152e:	8702                	jr	a4
      if (f[0] == '*') {
    1530:	0014c783          	lbu	a5,1(s1)
            fl |= STBSP__LEADINGZERO;
    1534:	010e6e13          	ori	t3,t3,16
            ++f;
    1538:	0485                	addi	s1,s1,1
      if (f[0] == '*') {
    153a:	02a00713          	li	a4,42
    153e:	0ce79163          	bne	a5,a4,1600 <stbsp_vsprintfcb+0x25c>
         fw = va_arg(va, stbsp__uint32);
    1542:	000bab03          	lw	s6,0(s7)
         while ((f[0] >= '0') && (f[0] <= '9')) {
    1546:	0014c783          	lbu	a5,1(s1)
         fw = va_arg(va, stbsp__uint32);
    154a:	0ba1                	addi	s7,s7,8
         ++f;
    154c:	0485                	addi	s1,s1,1
      if (f[0] == '.') {
    154e:	02e00713          	li	a4,46
      pr = -1;
    1552:	58fd                	li	a7,-1
      if (f[0] == '.') {
    1554:	0ee78663          	beq	a5,a4,1640 <stbsp_vsprintfcb+0x29c>
      switch (f[0]) {
    1558:	04900713          	li	a4,73
    155c:	10e78263          	beq	a5,a4,1660 <stbsp_vsprintfcb+0x2bc>
    1560:	f987871b          	addiw	a4,a5,-104
    1564:	0ff77713          	zext.b	a4,a4
    1568:	46c9                	li	a3,18
    156a:	02e6e063          	bltu	a3,a4,158a <stbsp_vsprintfcb+0x1e6>
    156e:	00004697          	auipc	a3,0x4
    1572:	da268693          	addi	a3,a3,-606 # 5310 <_GLOBAL__sub_I__ZSt3cin+0x24a>
    1576:	070a                	slli	a4,a4,0x2
    1578:	9736                	add	a4,a4,a3
    157a:	4318                	lw	a4,0(a4)
    157c:	9736                	add	a4,a4,a3
    157e:	8702                	jr	a4
         if (f[0] == 'h')
    1580:	0014c783          	lbu	a5,1(s1)
         fl |= (sizeof(ptrdiff_t) == 8) ? STBSP__INTMAX : 0;
    1584:	020e6e13          	ori	t3,t3,32
         ++f;
    1588:	0485                	addi	s1,s1,1
      switch (f[0]) {
    158a:	fbf7871b          	addiw	a4,a5,-65
    158e:	0ff77713          	zext.b	a4,a4
    1592:	03700693          	li	a3,55
    1596:	0ee6ea63          	bltu	a3,a4,168a <stbsp_vsprintfcb+0x2e6>
    159a:	00004697          	auipc	a3,0x4
    159e:	dc268693          	addi	a3,a3,-574 # 535c <_GLOBAL__sub_I__ZSt3cin+0x296>
    15a2:	070a                	slli	a4,a4,0x2
    15a4:	9736                	add	a4,a4,a3
    15a6:	4318                	lw	a4,0(a4)
    15a8:	9736                	add	a4,a4,a3
    15aa:	8702                	jr	a4
            fl |= STBSP__METRIC_NOSPACE;
    15ac:	400e6e13          	ori	t3,t3,1024
            continue;
    15b0:	0685                	addi	a3,a3,1
    15b2:	b785                	j	1512 <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEFTJUST;
    15b4:	001e6e13          	ori	t3,t3,1
            continue;
    15b8:	0685                	addi	a3,a3,1
    15ba:	bfa1                	j	1512 <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADINGPLUS;
    15bc:	002e6e13          	ori	t3,t3,2
            continue;
    15c0:	0685                	addi	a3,a3,1
    15c2:	bf81                	j	1512 <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__TRIPLET_COMMA;
    15c4:	040e6e13          	ori	t3,t3,64
            continue;
    15c8:	0685                	addi	a3,a3,1
    15ca:	b7a1                	j	1512 <stbsp_vsprintfcb+0x16e>
            if (fl & STBSP__METRIC_SUFFIX) {
    15cc:	100e7793          	andi	a5,t3,256
    15d0:	8772                	mv	a4,t3
    15d2:	56078363          	beqz	a5,1b38 <stbsp_vsprintfcb+0x794>
               if (fl & STBSP__METRIC_1024) {
    15d6:	6785                	lui	a5,0x1
    15d8:	034e1513          	slli	a0,t3,0x34
    15dc:	80078793          	addi	a5,a5,-2048 # 800 <stbsp__real_to_str+0x540>
    15e0:	5c055863          	bgez	a0,1bb0 <stbsp_vsprintfcb+0x80c>
                  fl |= STBSP__METRIC_JEDEC;
    15e4:	6785                	lui	a5,0x1
    15e6:	8f5d                	or	a4,a4,a5
    15e8:	00070e1b          	sext.w	t3,a4
    15ec:	0685                	addi	a3,a3,1
    15ee:	b715                	j	1512 <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADING_0X;
    15f0:	008e6e13          	ori	t3,t3,8
            continue;
    15f4:	0685                	addi	a3,a3,1
    15f6:	bf31                	j	1512 <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADINGSPACE;
    15f8:	004e6e13          	ori	t3,t3,4
            continue;
    15fc:	0685                	addi	a3,a3,1
    15fe:	bf11                	j	1512 <stbsp_vsprintfcb+0x16e>
         while ((f[0] >= '0') && (f[0] <= '9')) {
    1600:	fd07871b          	addiw	a4,a5,-48 # fd0 <_vscanf_core.constprop.0+0x582>
    1604:	0ff77713          	zext.b	a4,a4
    1608:	4625                	li	a2,9
      fw = 0;
    160a:	4b01                	li	s6,0
         while ((f[0] >= '0') && (f[0] <= '9')) {
    160c:	46a5                	li	a3,9
    160e:	f4e660e3          	bltu	a2,a4,154e <stbsp_vsprintfcb+0x1aa>
            fw = fw * 10 + f[0] - '0';
    1612:	002b171b          	slliw	a4,s6,0x2
    1616:	0167073b          	addw	a4,a4,s6
    161a:	0017171b          	slliw	a4,a4,0x1
            f++;
    161e:	0485                	addi	s1,s1,1
            fw = fw * 10 + f[0] - '0';
    1620:	9f3d                	addw	a4,a4,a5
         while ((f[0] >= '0') && (f[0] <= '9')) {
    1622:	0004c783          	lbu	a5,0(s1)
            fw = fw * 10 + f[0] - '0';
    1626:	fd070b1b          	addiw	s6,a4,-48
         while ((f[0] >= '0') && (f[0] <= '9')) {
    162a:	fd07871b          	addiw	a4,a5,-48
    162e:	0ff77713          	zext.b	a4,a4
    1632:	fee6f0e3          	bgeu	a3,a4,1612 <stbsp_vsprintfcb+0x26e>
      if (f[0] == '.') {
    1636:	02e00713          	li	a4,46
      pr = -1;
    163a:	58fd                	li	a7,-1
      if (f[0] == '.') {
    163c:	f0e79ee3          	bne	a5,a4,1558 <stbsp_vsprintfcb+0x1b4>
         if (f[0] == '*') {
    1640:	0014c783          	lbu	a5,1(s1)
    1644:	02a00713          	li	a4,42
    1648:	52e79763          	bne	a5,a4,1b76 <stbsp_vsprintfcb+0x7d2>
            while ((f[0] >= '0') && (f[0] <= '9')) {
    164c:	0024c783          	lbu	a5,2(s1)
      switch (f[0]) {
    1650:	04900713          	li	a4,73
            pr = va_arg(va, stbsp__uint32);
    1654:	000ba883          	lw	a7,0(s7)
            ++f;
    1658:	0489                	addi	s1,s1,2
            pr = va_arg(va, stbsp__uint32);
    165a:	0ba1                	addi	s7,s7,8
      switch (f[0]) {
    165c:	f0e792e3          	bne	a5,a4,1560 <stbsp_vsprintfcb+0x1bc>
         if ((f[1] == '6') && (f[2] == '4')) {
    1660:	0014c783          	lbu	a5,1(s1)
    1664:	03600713          	li	a4,54
    1668:	00e79463          	bne	a5,a4,1670 <stbsp_vsprintfcb+0x2cc>
    166c:	1e60106f          	j	2852 <stbsp_vsprintfcb+0x14ae>
         } else if ((f[1] == '3') && (f[2] == '2')) {
    1670:	03300713          	li	a4,51
    1674:	6ae796e3          	bne	a5,a4,2520 <stbsp_vsprintfcb+0x117c>
    1678:	0024c683          	lbu	a3,2(s1)
    167c:	03200713          	li	a4,50
    1680:	00e69463          	bne	a3,a4,1688 <stbsp_vsprintfcb+0x2e4>
    1684:	0ae0106f          	j	2732 <stbsp_vsprintfcb+0x138e>
            ++f;
    1688:	0485                	addi	s1,s1,1
         *s = f[0];
    168a:	26f10fa3          	sb	a5,639(sp)
         l = 1;
    168e:	4785                	li	a5,1
    1690:	d0be                	sw	a5,96(sp)
         lead[0] = 0;
    1692:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    1696:	06010823          	sb	zero,112(sp)
         dp = 0;
    169a:	d282                	sw	zero,100(sp)
    169c:	e0de                	sd	s7,64(sp)
    169e:	4701                	li	a4,0
    16a0:	4301                	li	t1,0
    16a2:	4f81                	li	t6,0
    16a4:	4685                	li	a3,1
    16a6:	4a01                	li	s4,0
         cs = 0;
    16a8:	4281                	li	t0,0
         s = num + STBSP__NUMSZ - 1;
    16aa:	27f10a93          	addi	s5,sp,639
         fw = fl = 0;
    16ae:	4e01                	li	t3,0
      tz = 0;
    16b0:	4881                	li	a7,0
            if (fl & STBSP__LEADINGZERO) // if leading zeros, everything is in pr
    16b2:	010e7793          	andi	a5,t3,16
    16b6:	40078ee3          	beqz	a5,22d2 <stbsp_vsprintfcb+0xf2e>
               pr = (fw > pr) ? fw : pr;
    16ba:	87ba                	mv	a5,a4
    16bc:	00675363          	bge	a4,t1,16c2 <stbsp_vsprintfcb+0x31e>
    16c0:	879a                	mv	a5,t1
    16c2:	0007871b          	sext.w	a4,a5
               fw = 0;
    16c6:	4301                	li	t1,0
         if (fw + pr) {
    16c8:	62070563          	beqz	a4,1cf2 <stbsp_vsprintfcb+0x94e>
            sn = lead + 1;
    16cc:	06910793          	addi	a5,sp,105
    16d0:	fcbe                	sd	a5,120(sp)
            while (lead[0]) {
    16d2:	0a0a0863          	beqz	s4,1782 <stbsp_vsprintfcb+0x3de>
               stbsp__cb_buf_clamp(i, lead[0]);
    16d6:	f026                	sd	s1,32(sp)
    16d8:	f436                	sd	a3,40(sp)
    16da:	854a                	mv	a0,s2
    16dc:	86d2                	mv	a3,s4
    16de:	84ce                	mv	s1,s3
               stbsp__chk_cb_buf(1);
    16e0:	1fe00b93          	li	s7,510
               stbsp__cb_buf_clamp(i, lead[0]);
    16e4:	89be                	mv	s3,a5
    16e6:	20000b13          	li	s6,512
    16ea:	87a2                	mv	a5,s0
    16ec:	e846                	sd	a7,16(sp)
    16ee:	846a                	mv	s0,s10
    16f0:	ec7e                	sd	t6,24(sp)
    16f2:	8d6e                	mv	s10,s11
    16f4:	f872                	sd	t3,48(sp)
    16f6:	8de6                	mv	s11,s9
    16f8:	8a3a                	mv	s4,a4
    16fa:	e496                	sd	t0,72(sp)
    16fc:	891a                	mv	s2,t1
    16fe:	8c9e                	mv	s9,t2
    1700:	0006871b          	sext.w	a4,a3
    1704:	2e0482e3          	beqz	s1,21e8 <stbsp_vsprintfcb+0xe44>
    1708:	40a7863b          	subw	a2,a5,a0
    170c:	40cb083b          	subw	a6,s6,a2
    1710:	85c2                	mv	a1,a6
    1712:	01075363          	bge	a4,a6,1718 <stbsp_vsprintfcb+0x374>
    1716:	85ba                	mv	a1,a4
               lead[0] -= (char)i;
    1718:	9e8d                	subw	a3,a3,a1
               stbsp__cb_buf_clamp(i, lead[0]);
    171a:	0005871b          	sext.w	a4,a1
               lead[0] -= (char)i;
    171e:	06d10423          	sb	a3,104(sp)
               while (i) {
    1722:	c70d                	beqz	a4,174c <stbsp_vsprintfcb+0x3a8>
    1724:	7866                	ld	a6,120(sp)
    1726:	02071593          	slli	a1,a4,0x20
    172a:	9181                	srli	a1,a1,0x20
    172c:	00b78633          	add	a2,a5,a1
    1730:	8742                	mv	a4,a6
                  *bf++ = *sn++;
    1732:	00074683          	lbu	a3,0(a4)
    1736:	0785                	addi	a5,a5,1
               while (i) {
    1738:	0705                	addi	a4,a4,1
                  *bf++ = *sn++;
    173a:	fed78fa3          	sb	a3,-1(a5)
               while (i) {
    173e:	fec79ae3          	bne	a5,a2,1732 <stbsp_vsprintfcb+0x38e>
    1742:	982e                	add	a6,a6,a1
    1744:	fcc2                	sd	a6,120(sp)
               stbsp__chk_cb_buf(1);
    1746:	c899                	beqz	s1,175c <stbsp_vsprintfcb+0x3b8>
    1748:	40a7863b          	subw	a2,a5,a0
    174c:	00cbd863          	bge	s7,a2,175c <stbsp_vsprintfcb+0x3b8>
    1750:	65a2                	ld	a1,8(sp)
    1752:	9c31                	addw	s0,s0,a2
    1754:	9482                	jalr	s1
    1756:	34050ee3          	beqz	a0,22b2 <stbsp_vsprintfcb+0xf0e>
    175a:	87aa                	mv	a5,a0
            while (lead[0]) {
    175c:	06814683          	lbu	a3,104(sp)
    1760:	f2c5                	bnez	a3,1700 <stbsp_vsprintfcb+0x35c>
    1762:	83e6                	mv	t2,s9
    1764:	68c2                	ld	a7,16(sp)
    1766:	8cee                	mv	s9,s11
    1768:	6fe2                	ld	t6,24(sp)
    176a:	8dea                	mv	s11,s10
    176c:	76a2                	ld	a3,40(sp)
    176e:	8d22                	mv	s10,s0
    1770:	7e42                	ld	t3,48(sp)
    1772:	843e                	mv	s0,a5
    1774:	62a6                	ld	t0,72(sp)
    1776:	87ce                	mv	a5,s3
    1778:	89a6                	mv	s3,s1
    177a:	7482                	ld	s1,32(sp)
    177c:	834a                	mv	t1,s2
    177e:	8752                	mv	a4,s4
    1780:	892a                	mv	s2,a0
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    1782:	040e7b13          	andi	s6,t3,64
            c = cs >> 24;
    1786:	0182d61b          	srliw	a2,t0,0x18
    178a:	0182db9b          	srliw	s7,t0,0x18
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    178e:	4a01                	li	s4,0
    1790:	000b0e63          	beqz	s6,17ac <stbsp_vsprintfcb+0x408>
            cs &= 0xffffff;
    1794:	02829a13          	slli	s4,t0,0x28
    1798:	028a5a13          	srli	s4,s4,0x28
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    179c:	00ea0a3b          	addw	s4,s4,a4
    17a0:	0016059b          	addiw	a1,a2,1
    17a4:	02ba7a3b          	remuw	s4,s4,a1
    17a8:	41460a3b          	subw	s4,a2,s4
            while (pr > 0) {
    17ac:	0ce05763          	blez	a4,187a <stbsp_vsprintfcb+0x4d6>
                     *(stbsp__uint32 *)bf = 0x30303030;
    17b0:	30303837          	lui	a6,0x30303
    17b4:	03080813          	addi	a6,a6,48 # 30303030 <_ZSt4cerr+0x302fb6b8>
    17b8:	f026                	sd	s1,32(sp)
    17ba:	854a                	mv	a0,s2
    17bc:	84da                	mv	s1,s6
    17be:	895e                	mv	s2,s7
    17c0:	e4d6                	sd	s5,72(sp)
    17c2:	8b4e                	mv	s6,s3
    17c4:	8aea                	mv	s5,s10
               stbsp__chk_cb_buf(1);
    17c6:	1fe00293          	li	t0,510
    17ca:	8d6e                	mv	s10,s11
                     *bf++ = stbsp__comma;
    17cc:	00005f17          	auipc	t5,0x5
    17d0:	2b4f0f13          	addi	t5,t5,692 # 6a80 <stbsp__digitpair>
    17d4:	8de6                	mv	s11,s9
                     *bf++ = '0';
    17d6:	03000e93          	li	t4,48
    17da:	e846                	sd	a7,16(sp)
    17dc:	ec7e                	sd	t6,24(sp)
    17de:	f436                	sd	a3,40(sp)
    17e0:	f872                	sd	t3,48(sp)
    17e2:	e89a                	sd	t1,80(sp)
    17e4:	89ba                	mv	s3,a4
    17e6:	ecbe                	sd	a5,88(sp)
    17e8:	8bc2                	mv	s7,a6
    17ea:	8c9e                	mv	s9,t2
               stbsp__cb_buf_clamp(i, pr);
    17ec:	240b0ee3          	beqz	s6,2248 <stbsp_vsprintfcb+0xea4>
    17f0:	40a407b3          	sub	a5,s0,a0
    17f4:	40fc063b          	subw	a2,s8,a5
    17f8:	87b2                	mv	a5,a2
    17fa:	00c9d363          	bge	s3,a2,1800 <stbsp_vsprintfcb+0x45c>
    17fe:	87ce                	mv	a5,s3
    1800:	0007859b          	sext.w	a1,a5
               pr -= i;
    1804:	40f989bb          	subw	s3,s3,a5
               if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    1808:	32048c63          	beqz	s1,1b40 <stbsp_vsprintfcb+0x79c>
               while (i) {
    180c:	34058a63          	beqz	a1,1b60 <stbsp_vsprintfcb+0x7bc>
    1810:	1582                	slli	a1,a1,0x20
                     *bf++ = stbsp__comma;
    1812:	0cdf4603          	lbu	a2,205(t5)
    1816:	9181                	srli	a1,a1,0x20
    1818:	95a2                	add	a1,a1,s0
    181a:	0405                	addi	s0,s0,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (cs++ == c)) {
    181c:	c481                	beqz	s1,1824 <stbsp_vsprintfcb+0x480>
    181e:	1d4901e3          	beq	s2,s4,21e0 <stbsp_vsprintfcb+0xe3c>
    1822:	2a05                	addiw	s4,s4,1
                     *bf++ = '0';
    1824:	03000793          	li	a5,48
    1828:	fef40fa3          	sb	a5,-1(s0)
               while (i) {
    182c:	fe8597e3          	bne	a1,s0,181a <stbsp_vsprintfcb+0x476>
               stbsp__chk_cb_buf(1);
    1830:	320b0b63          	beqz	s6,1b66 <stbsp_vsprintfcb+0x7c2>
    1834:	40a5863b          	subw	a2,a1,a0
    1838:	32c2d763          	bge	t0,a2,1b66 <stbsp_vsprintfcb+0x7c2>
    183c:	65a2                	ld	a1,8(sp)
    183e:	01560abb          	addw	s5,a2,s5
    1842:	9b02                	jalr	s6
    1844:	3a050ce3          	beqz	a0,23fc <stbsp_vsprintfcb+0x1058>
    1848:	842a                	mv	s0,a0
    184a:	1fe00293          	li	t0,510
    184e:	00005f17          	auipc	t5,0x5
    1852:	232f0f13          	addi	t5,t5,562 # 6a80 <stbsp__digitpair>
    1856:	03000e93          	li	t4,48
            while (pr > 0) {
    185a:	f93049e3          	bgtz	s3,17ec <stbsp_vsprintfcb+0x448>
         while (lead[0]) {
    185e:	83e6                	mv	t2,s9
    1860:	68c2                	ld	a7,16(sp)
    1862:	8cee                	mv	s9,s11
    1864:	6fe2                	ld	t6,24(sp)
    1866:	8dea                	mv	s11,s10
    1868:	7482                	ld	s1,32(sp)
    186a:	8d56                	mv	s10,s5
    186c:	76a2                	ld	a3,40(sp)
    186e:	7e42                	ld	t3,48(sp)
    1870:	6346                	ld	t1,80(sp)
    1872:	67e6                	ld	a5,88(sp)
    1874:	6aa6                	ld	s5,72(sp)
    1876:	892a                	mv	s2,a0
    1878:	89da                	mv	s3,s6
    187a:	06814a03          	lbu	s4,104(sp)
         sn = lead + 1;
    187e:	fcbe                	sd	a5,120(sp)
         while (lead[0]) {
    1880:	0a0a0263          	beqz	s4,1924 <stbsp_vsprintfcb+0x580>
            stbsp__cb_buf_clamp(i, lead[0]);
    1884:	ec26                	sd	s1,24(sp)
    1886:	f036                	sd	a3,32(sp)
    1888:	854a                	mv	a0,s2
    188a:	86d2                	mv	a3,s4
    188c:	84ce                	mv	s1,s3
    188e:	87a2                	mv	a5,s0
            stbsp__chk_cb_buf(1);
    1890:	1fe00b93          	li	s7,510
            stbsp__cb_buf_clamp(i, lead[0]);
    1894:	846a                	mv	s0,s10
    1896:	20000b13          	li	s6,512
    189a:	8d6e                	mv	s10,s11
    189c:	e846                	sd	a7,16(sp)
    189e:	8de6                	mv	s11,s9
    18a0:	8a7e                	mv	s4,t6
    18a2:	8972                	mv	s2,t3
    18a4:	899a                	mv	s3,t1
    18a6:	8c9e                	mv	s9,t2
    18a8:	0006871b          	sext.w	a4,a3
    18ac:	140482e3          	beqz	s1,21f0 <stbsp_vsprintfcb+0xe4c>
    18b0:	40a7863b          	subw	a2,a5,a0
    18b4:	40cb083b          	subw	a6,s6,a2
    18b8:	85c2                	mv	a1,a6
    18ba:	01075363          	bge	a4,a6,18c0 <stbsp_vsprintfcb+0x51c>
    18be:	85ba                	mv	a1,a4
            lead[0] -= (char)i;
    18c0:	9e8d                	subw	a3,a3,a1
            stbsp__cb_buf_clamp(i, lead[0]);
    18c2:	0005871b          	sext.w	a4,a1
            lead[0] -= (char)i;
    18c6:	06d10423          	sb	a3,104(sp)
            while (i) {
    18ca:	c70d                	beqz	a4,18f4 <stbsp_vsprintfcb+0x550>
    18cc:	7866                	ld	a6,120(sp)
    18ce:	02071593          	slli	a1,a4,0x20
    18d2:	9181                	srli	a1,a1,0x20
    18d4:	00b78633          	add	a2,a5,a1
    18d8:	8742                	mv	a4,a6
               *bf++ = *sn++;
    18da:	00074683          	lbu	a3,0(a4)
    18de:	0785                	addi	a5,a5,1
            while (i) {
    18e0:	0705                	addi	a4,a4,1
               *bf++ = *sn++;
    18e2:	fed78fa3          	sb	a3,-1(a5)
            while (i) {
    18e6:	fec79ae3          	bne	a5,a2,18da <stbsp_vsprintfcb+0x536>
    18ea:	982e                	add	a6,a6,a1
    18ec:	fcc2                	sd	a6,120(sp)
            stbsp__chk_cb_buf(1);
    18ee:	c899                	beqz	s1,1904 <stbsp_vsprintfcb+0x560>
    18f0:	40a7863b          	subw	a2,a5,a0
    18f4:	00cbd863          	bge	s7,a2,1904 <stbsp_vsprintfcb+0x560>
    18f8:	65a2                	ld	a1,8(sp)
    18fa:	9c31                	addw	s0,s0,a2
    18fc:	9482                	jalr	s1
    18fe:	1a050ae3          	beqz	a0,22b2 <stbsp_vsprintfcb+0xf0e>
    1902:	87aa                	mv	a5,a0
         while (lead[0]) {
    1904:	06814683          	lbu	a3,104(sp)
    1908:	f2c5                	bnez	a3,18a8 <stbsp_vsprintfcb+0x504>
    190a:	834e                	mv	t1,s3
    190c:	68c2                	ld	a7,16(sp)
    190e:	89a6                	mv	s3,s1
    1910:	7682                	ld	a3,32(sp)
    1912:	64e2                	ld	s1,24(sp)
    1914:	8e4a                	mv	t3,s2
    1916:	83e6                	mv	t2,s9
    1918:	8fd2                	mv	t6,s4
    191a:	8cee                	mv	s9,s11
    191c:	892a                	mv	s2,a0
    191e:	8dea                	mv	s11,s10
    1920:	8d22                	mv	s10,s0
    1922:	843e                	mv	s0,a5
         while (n) {
    1924:	c6f9                	beqz	a3,19f2 <stbsp_vsprintfcb+0x64e>
            STBSP__UNALIGNED(while (i >= 4) {
    1926:	ec26                	sd	s1,24(sp)
    1928:	854a                	mv	a0,s2
    192a:	84d6                	mv	s1,s5
    192c:	896a                	mv	s2,s10
    192e:	87a2                	mv	a5,s0
    1930:	8d6e                	mv	s10,s11
            stbsp__chk_cb_buf(1);
    1932:	1fe00b93          	li	s7,510
            STBSP__UNALIGNED(while (i >= 4) {
    1936:	8de6                	mv	s11,s9
            stbsp__cb_buf_clamp(i, n);
    1938:	20000b13          	li	s6,512
            STBSP__UNALIGNED(while (i >= 4) {
    193c:	4a0d                	li	s4,3
    193e:	e87e                	sd	t6,16(sp)
    1940:	f072                	sd	t3,32(sp)
    1942:	8ac6                	mv	s5,a7
    1944:	f41a                	sd	t1,40(sp)
    1946:	8436                	mv	s0,a3
    1948:	8c9e                	mv	s9,t2
            stbsp__cb_buf_clamp(i, n);
    194a:	0004071b          	sext.w	a4,s0
    194e:	100982e3          	beqz	s3,2252 <stbsp_vsprintfcb+0xeae>
    1952:	40a78633          	sub	a2,a5,a0
    1956:	40cb05bb          	subw	a1,s6,a2
    195a:	862e                	mv	a2,a1
    195c:	00b75363          	bge	a4,a1,1962 <stbsp_vsprintfcb+0x5be>
    1960:	863a                	mv	a2,a4
    1962:	0006071b          	sext.w	a4,a2
            n -= i;
    1966:	9c11                	subw	s0,s0,a2
            STBSP__UNALIGNED(while (i >= 4) {
    1968:	14ea50e3          	bge	s4,a4,22a8 <stbsp_vsprintfcb+0xf04>
    196c:	ffc70f1b          	addiw	t5,a4,-4
    1970:	002f5e9b          	srliw	t4,t5,0x2
    1974:	001e8e1b          	addiw	t3,t4,1
    1978:	0e0a                	slli	t3,t3,0x2
    197a:	01c785b3          	add	a1,a5,t3
    197e:	8626                	mv	a2,s1
    1980:	4218                	lw	a4,0(a2)
    1982:	0791                	addi	a5,a5,4
    1984:	0611                	addi	a2,a2,4
    1986:	2701                	sext.w	a4,a4
    1988:	fee7ae23          	sw	a4,-4(a5)
    198c:	feb79ae3          	bne	a5,a1,1980 <stbsp_vsprintfcb+0x5dc>
    1990:	002e9e9b          	slliw	t4,t4,0x2
    1994:	41df073b          	subw	a4,t5,t4
            while (i) {
    1998:	94f2                	add	s1,s1,t3
    199a:	c31d                	beqz	a4,19c0 <stbsp_vsprintfcb+0x61c>
    199c:	8626                	mv	a2,s1
    199e:	87ae                	mv	a5,a1
    19a0:	00e58f3b          	addw	t5,a1,a4
               *bf++ = *s++;
    19a4:	00064e83          	lbu	t4,0(a2)
    19a8:	0785                	addi	a5,a5,1
            while (i) {
    19aa:	00078e1b          	sext.w	t3,a5
               *bf++ = *s++;
    19ae:	ffd78fa3          	sb	t4,-1(a5)
    19b2:	0605                	addi	a2,a2,1
            while (i) {
    19b4:	ffcf18e3          	bne	t5,t3,19a4 <stbsp_vsprintfcb+0x600>
    19b8:	1702                	slli	a4,a4,0x20
    19ba:	9301                	srli	a4,a4,0x20
    19bc:	95ba                	add	a1,a1,a4
    19be:	94ba                	add	s1,s1,a4
            stbsp__chk_cb_buf(1);
    19c0:	1a098763          	beqz	s3,1b6e <stbsp_vsprintfcb+0x7ca>
    19c4:	40a5863b          	subw	a2,a1,a0
    19c8:	1acbd363          	bge	s7,a2,1b6e <stbsp_vsprintfcb+0x7ca>
    19cc:	65a2                	ld	a1,8(sp)
    19ce:	0126093b          	addw	s2,a2,s2
    19d2:	9982                	jalr	s3
    19d4:	20050be3          	beqz	a0,23ea <stbsp_vsprintfcb+0x1046>
    19d8:	87aa                	mv	a5,a0
         while (n) {
    19da:	f825                	bnez	s0,194a <stbsp_vsprintfcb+0x5a6>
    19dc:	6fc2                	ld	t6,16(sp)
    19de:	64e2                	ld	s1,24(sp)
    19e0:	7e02                	ld	t3,32(sp)
    19e2:	7322                	ld	t1,40(sp)
    19e4:	83e6                	mv	t2,s9
    19e6:	88d6                	mv	a7,s5
    19e8:	8cee                	mv	s9,s11
    19ea:	843e                	mv	s0,a5
    19ec:	8dea                	mv	s11,s10
    19ee:	8d4a                	mv	s10,s2
    19f0:	892a                	mv	s2,a0
         while (tz) {
    19f2:	08088863          	beqz	a7,1a82 <stbsp_vsprintfcb+0x6de>
               *(stbsp__uint32 *)bf = 0x30303030;
    19f6:	30303b37          	lui	s6,0x30303
               *bf++ = '0';
    19fa:	03000a13          	li	s4,48
            while (i >= 4) {
    19fe:	4a8d                	li	s5,3
            stbsp__chk_cb_buf(1);
    1a00:	1fe00693          	li	a3,510
               *(stbsp__uint32 *)bf = 0x30303030;
    1a04:	030b0b13          	addi	s6,s6,48 # 30303030 <_ZSt4cerr+0x302fb6b8>
            stbsp__cb_buf_clamp(i, tz);
    1a08:	20000b93          	li	s7,512
    1a0c:	040989e3          	beqz	s3,225e <stbsp_vsprintfcb+0xeba>
    1a10:	41240633          	sub	a2,s0,s2
    1a14:	40cb87bb          	subw	a5,s7,a2
    1a18:	873e                	mv	a4,a5
    1a1a:	00f8d363          	bge	a7,a5,1a20 <stbsp_vsprintfcb+0x67c>
    1a1e:	8746                	mv	a4,a7
    1a20:	0007079b          	sext.w	a5,a4
            tz -= i;
    1a24:	40e888bb          	subw	a7,a7,a4
            while (i) {
    1a28:	08078ee3          	beqz	a5,22c4 <stbsp_vsprintfcb+0xf20>
               if ((((stbsp__uintptr)bf) & 3) == 0)
    1a2c:	00347713          	andi	a4,s0,3
    1a30:	e719                	bnez	a4,1a3e <stbsp_vsprintfcb+0x69a>
    1a32:	0390006f          	j	226a <stbsp_vsprintfcb+0xec6>
    1a36:	00347713          	andi	a4,s0,3
    1a3a:	7a070f63          	beqz	a4,21f8 <stbsp_vsprintfcb+0xe54>
               *bf++ = '0';
    1a3e:	01440023          	sb	s4,0(s0)
               --i;
    1a42:	37fd                	addiw	a5,a5,-1
               *bf++ = '0';
    1a44:	0405                	addi	s0,s0,1
            while (i) {
    1a46:	fbe5                	bnez	a5,1a36 <stbsp_vsprintfcb+0x692>
            stbsp__chk_cb_buf(1);
    1a48:	02098b63          	beqz	s3,1a7e <stbsp_vsprintfcb+0x6da>
    1a4c:	4124063b          	subw	a2,s0,s2
    1a50:	02c6d763          	bge	a3,a2,1a7e <stbsp_vsprintfcb+0x6da>
    1a54:	65a2                	ld	a1,8(sp)
    1a56:	854a                	mv	a0,s2
    1a58:	f81e                	sd	t2,48(sp)
    1a5a:	f41a                	sd	t1,40(sp)
    1a5c:	f072                	sd	t3,32(sp)
    1a5e:	ec7e                	sd	t6,24(sp)
    1a60:	e846                	sd	a7,16(sp)
    1a62:	00cd0d3b          	addw	s10,s10,a2
    1a66:	9982                	jalr	s3
    1a68:	892a                	mv	s2,a0
    1a6a:	1a0502e3          	beqz	a0,240e <stbsp_vsprintfcb+0x106a>
    1a6e:	73c2                	ld	t2,48(sp)
    1a70:	7322                	ld	t1,40(sp)
    1a72:	7e02                	ld	t3,32(sp)
    1a74:	6fe2                	ld	t6,24(sp)
    1a76:	68c2                	ld	a7,16(sp)
    1a78:	842a                	mv	s0,a0
    1a7a:	1fe00693          	li	a3,510
         while (tz) {
    1a7e:	f80897e3          	bnez	a7,1a0c <stbsp_vsprintfcb+0x668>
         sn = tail + 1;
    1a82:	07110793          	addi	a5,sp,113
    1a86:	fcbe                	sd	a5,120(sp)
         while (tail[0]) {
    1a88:	080f8763          	beqz	t6,1b16 <stbsp_vsprintfcb+0x772>
            stbsp__cb_buf_clamp(i, tail[0]);
    1a8c:	854a                	mv	a0,s2
    1a8e:	8b6a                	mv	s6,s10
            stbsp__chk_cb_buf(1);
    1a90:	1fe00a93          	li	s5,510
            stbsp__cb_buf_clamp(i, tail[0]);
    1a94:	8d4e                	mv	s10,s3
    1a96:	20000a13          	li	s4,512
    1a9a:	8bf2                	mv	s7,t3
    1a9c:	891a                	mv	s2,t1
    1a9e:	899e                	mv	s3,t2
    1aa0:	000f879b          	sext.w	a5,t6
    1aa4:	7c0d0863          	beqz	s10,2274 <stbsp_vsprintfcb+0xed0>
    1aa8:	40a4063b          	subw	a2,s0,a0
    1aac:	40ca06bb          	subw	a3,s4,a2
    1ab0:	8736                	mv	a4,a3
    1ab2:	00d7d363          	bge	a5,a3,1ab8 <stbsp_vsprintfcb+0x714>
    1ab6:	873e                	mv	a4,a5
            tail[0] -= (char)i;
    1ab8:	40ef8fbb          	subw	t6,t6,a4
            stbsp__cb_buf_clamp(i, tail[0]);
    1abc:	0007079b          	sext.w	a5,a4
            tail[0] -= (char)i;
    1ac0:	07f10823          	sb	t6,112(sp)
            while (i) {
    1ac4:	c795                	beqz	a5,1af0 <stbsp_vsprintfcb+0x74c>
    1ac6:	75e6                	ld	a1,120(sp)
    1ac8:	02079613          	slli	a2,a5,0x20
    1acc:	9201                	srli	a2,a2,0x20
    1ace:	00c406b3          	add	a3,s0,a2
    1ad2:	87ae                	mv	a5,a1
               *bf++ = *sn++;
    1ad4:	0007c703          	lbu	a4,0(a5)
    1ad8:	0405                	addi	s0,s0,1
            while (i) {
    1ada:	0785                	addi	a5,a5,1
               *bf++ = *sn++;
    1adc:	fee40fa3          	sb	a4,-1(s0)
            while (i) {
    1ae0:	fed41ae3          	bne	s0,a3,1ad4 <stbsp_vsprintfcb+0x730>
    1ae4:	95b2                	add	a1,a1,a2
    1ae6:	fcae                	sd	a1,120(sp)
            stbsp__chk_cb_buf(1);
    1ae8:	000d0d63          	beqz	s10,1b02 <stbsp_vsprintfcb+0x75e>
    1aec:	40a4063b          	subw	a2,s0,a0
    1af0:	00cad963          	bge	s5,a2,1b02 <stbsp_vsprintfcb+0x75e>
    1af4:	65a2                	ld	a1,8(sp)
    1af6:	00cb0b3b          	addw	s6,s6,a2
    1afa:	9d02                	jalr	s10
    1afc:	200509e3          	beqz	a0,250e <stbsp_vsprintfcb+0x116a>
    1b00:	842a                	mv	s0,a0
         while (tail[0]) {
    1b02:	07014f83          	lbu	t6,112(sp)
    1b06:	f80f9de3          	bnez	t6,1aa0 <stbsp_vsprintfcb+0x6fc>
    1b0a:	834a                	mv	t1,s2
    1b0c:	83ce                	mv	t2,s3
    1b0e:	8e5e                	mv	t3,s7
    1b10:	89ea                	mv	s3,s10
    1b12:	892a                	mv	s2,a0
    1b14:	8d5a                	mv	s10,s6
         if (fl & STBSP__LEFTJUST)
    1b16:	001e7e13          	andi	t3,t3,1
    1b1a:	000e0663          	beqz	t3,1b26 <stbsp_vsprintfcb+0x782>
            if (fw > 0) {
    1b1e:	00605463          	blez	t1,1b26 <stbsp_vsprintfcb+0x782>
    1b22:	0300106f          	j	2b52 <stbsp_vsprintfcb+0x17ae>
   for (;;) {
    1b26:	6b86                	ld	s7,64(sp)
    1b28:	2c013a03          	ld	s4,704(sp)
    1b2c:	2b813a83          	ld	s5,696(sp)
    1b30:	2b013b03          	ld	s6,688(sp)
      ++f;
    1b34:	0485                	addi	s1,s1,1
   for (;;) {
    1b36:	b0f1                	j	1402 <stbsp_vsprintfcb+0x5e>
               fl |= STBSP__METRIC_SUFFIX;
    1b38:	100e6e13          	ori	t3,t3,256
            continue;
    1b3c:	0685                	addi	a3,a3,1
    1b3e:	bad1                	j	1512 <stbsp_vsprintfcb+0x16e>
                  while (i) {
    1b40:	0e0580e3          	beqz	a1,2420 <stbsp_vsprintfcb+0x107c>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    1b44:	00347793          	andi	a5,s0,3
    1b48:	e799                	bnez	a5,1b56 <stbsp_vsprintfcb+0x7b2>
    1b4a:	0dd0006f          	j	2426 <stbsp_vsprintfcb+0x1082>
    1b4e:	00347793          	andi	a5,s0,3
    1b52:	72078463          	beqz	a5,227a <stbsp_vsprintfcb+0xed6>
                     *bf++ = '0';
    1b56:	01d40023          	sb	t4,0(s0)
                     --i;
    1b5a:	35fd                	addiw	a1,a1,-1
                     *bf++ = '0';
    1b5c:	0405                	addi	s0,s0,1
                  while (i) {
    1b5e:	f9e5                	bnez	a1,1b4e <stbsp_vsprintfcb+0x7aa>
               while (i) {
    1b60:	85a2                	mv	a1,s0
               stbsp__chk_cb_buf(1);
    1b62:	cc0b19e3          	bnez	s6,1834 <stbsp_vsprintfcb+0x490>
    1b66:	842e                	mv	s0,a1
            while (pr > 0) {
    1b68:	c93042e3          	bgtz	s3,17ec <stbsp_vsprintfcb+0x448>
    1b6c:	b9cd                	j	185e <stbsp_vsprintfcb+0x4ba>
            while (i) {
    1b6e:	87ae                	mv	a5,a1
         while (n) {
    1b70:	dc041de3          	bnez	s0,194a <stbsp_vsprintfcb+0x5a6>
    1b74:	b5a5                	j	19dc <stbsp_vsprintfcb+0x638>
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1b76:	fd07871b          	addiw	a4,a5,-48
    1b7a:	0ff77713          	zext.b	a4,a4
    1b7e:	4625                	li	a2,9
         ++f;
    1b80:	0485                	addi	s1,s1,1
            pr = 0;
    1b82:	4881                	li	a7,0
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1b84:	46a5                	li	a3,9
    1b86:	9ce669e3          	bltu	a2,a4,1558 <stbsp_vsprintfcb+0x1b4>
               pr = pr * 10 + f[0] - '0';
    1b8a:	0028971b          	slliw	a4,a7,0x2
    1b8e:	0117073b          	addw	a4,a4,a7
    1b92:	0017171b          	slliw	a4,a4,0x1
               f++;
    1b96:	0485                	addi	s1,s1,1
               pr = pr * 10 + f[0] - '0';
    1b98:	9f3d                	addw	a4,a4,a5
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1b9a:	0004c783          	lbu	a5,0(s1)
               pr = pr * 10 + f[0] - '0';
    1b9e:	fd07089b          	addiw	a7,a4,-48
            while ((f[0] >= '0') && (f[0] <= '9')) {
    1ba2:	fd07871b          	addiw	a4,a5,-48
    1ba6:	0ff77713          	zext.b	a4,a4
    1baa:	fee6f0e3          	bgeu	a3,a4,1b8a <stbsp_vsprintfcb+0x7e6>
    1bae:	b26d                	j	1558 <stbsp_vsprintfcb+0x1b4>
                  fl |= STBSP__METRIC_1024;
    1bb0:	8f5d                	or	a4,a4,a5
    1bb2:	00070e1b          	sext.w	t3,a4
    1bb6:	0685                	addi	a3,a3,1
    1bb8:	baa9                	j	1512 <stbsp_vsprintfcb+0x16e>
      *bf = 0;
    1bba:	00040023          	sb	zero,0(s0)
    1bbe:	b209                	j	14c0 <stbsp_vsprintfcb+0x11c>
         if (f[0] == 'l') {
    1bc0:	0014c783          	lbu	a5,1(s1)
    1bc4:	06c00713          	li	a4,108
         fl |= ((sizeof(long) == 8) ? STBSP__INTMAX : 0);
    1bc8:	020e6e13          	ori	t3,t3,32
         if (f[0] == 'l') {
    1bcc:	00e78c63          	beq	a5,a4,1be4 <stbsp_vsprintfcb+0x840>
            ++f;
    1bd0:	0485                	addi	s1,s1,1
    1bd2:	ba65                	j	158a <stbsp_vsprintfcb+0x1e6>
         if (f[0] == 'h')
    1bd4:	0014c783          	lbu	a5,1(s1)
    1bd8:	06800713          	li	a4,104
         fl |= STBSP__HALFWIDTH;
    1bdc:	200e6e13          	ori	t3,t3,512
         if (f[0] == 'h')
    1be0:	fee798e3          	bne	a5,a4,1bd0 <stbsp_vsprintfcb+0x82c>
         if ((f[1] == '6') && (f[2] == '4')) {
    1be4:	0024c783          	lbu	a5,2(s1)
            ++f;
    1be8:	0489                	addi	s1,s1,2
    1bea:	b245                	j	158a <stbsp_vsprintfcb+0x1e6>
         s = va_arg(va, char *);
    1bec:	008b8713          	addi	a4,s7,8
    1bf0:	e0ba                	sd	a4,64(sp)
         if (fl & STBSP__INTMAX) {
    1bf2:	020e7693          	andi	a3,t3,32
    1bf6:	8772                	mv	a4,t3
    1bf8:	24069ee3          	bnez	a3,2654 <stbsp_vsprintfcb+0x12b0>
            stbsp__int32 i = va_arg(va, stbsp__int32);
    1bfc:	000ba683          	lw	a3,0(s7)
            if ((f[0] != 'u') && (i < 0)) {
    1c00:	07500613          	li	a2,117
            n64 = (stbsp__uint32)i;
    1c04:	02069f13          	slli	t5,a3,0x20
    1c08:	020f5f13          	srli	t5,t5,0x20
            if ((f[0] != 'u') && (i < 0)) {
    1c0c:	00c78a63          	beq	a5,a2,1c20 <stbsp_vsprintfcb+0x87c>
    1c10:	0006d863          	bgez	a3,1c20 <stbsp_vsprintfcb+0x87c>
               fl |= STBSP__NEGATIVE;
    1c14:	08076713          	ori	a4,a4,128
               n64 = (stbsp__uint32)-i;
    1c18:	40d00f3b          	negw	t5,a3
               fl |= STBSP__NEGATIVE;
    1c1c:	00070e1b          	sext.w	t3,a4
         if (fl & STBSP__METRIC_SUFFIX) {
    1c20:	100e7693          	andi	a3,t3,256
    1c24:	5c0683e3          	beqz	a3,29ea <stbsp_vsprintfcb+0x1646>
            if (n64 < 1024)
    1c28:	3ff00793          	li	a5,1023
    1c2c:	01e7e463          	bltu	a5,t5,1c34 <stbsp_vsprintfcb+0x890>
    1c30:	0ea0106f          	j	2d1a <stbsp_vsprintfcb+0x1976>
            else if (pr == -1)
    1c34:	57fd                	li	a5,-1
    1c36:	30f887e3          	beq	a7,a5,2744 <stbsp_vsprintfcb+0x13a0>
            fv = (double)(stbsp__int64)n64;
    1c3a:	d22f7553          	fcvt.d.l	fa0,t5
            if (fl & STBSP__METRIC_1024)
    1c3e:	034e1793          	slli	a5,t3,0x34
    1c42:	0007c463          	bltz	a5,1c4a <stbsp_vsprintfcb+0x8a6>
    1c46:	2300106f          	j	2e76 <stbsp_vsprintfcb+0x1ad2>
               divisor = 1024.0;
    1c4a:	00004797          	auipc	a5,0x4
    1c4e:	cb67b787          	fld	fa5,-842(a5) # 5900 <STDIN_FD+0x20>
               if ((fv < divisor) && (fv > -divisor))
    1c52:	22f79753          	fneg.d	fa4,fa5
               fl += 0x1000000;
    1c56:	010006b7          	lui	a3,0x1000
            while (fl < 0x4000000) {
    1c5a:	04000737          	lui	a4,0x4000
               if ((fv < divisor) && (fv > -divisor))
    1c5e:	a2f517d3          	flt.d	a5,fa0,fa5
    1c62:	c789                	beqz	a5,1c6c <stbsp_vsprintfcb+0x8c8>
    1c64:	a2a717d3          	flt.d	a5,fa4,fa0
    1c68:	3e079863          	bnez	a5,2058 <stbsp_vsprintfcb+0xcb4>
               fl += 0x1000000;
    1c6c:	01c68e3b          	addw	t3,a3,t3
               fv /= divisor;
    1c70:	1af57553          	fdiv.d	fa0,fa0,fa5
            while (fl < 0x4000000) {
    1c74:	feee65e3          	bltu	t3,a4,1c5e <stbsp_vsprintfcb+0x8ba>
    1c78:	a6c5                	j	2058 <stbsp_vsprintfcb+0xcb4>
         h = (f[0] == 'X') ? hexu : hex;
    1c7a:	05800693          	li	a3,88
         if (fl & STBSP__INTMAX) {
    1c7e:	020e7713          	andi	a4,t3,32
         h = (f[0] == 'X') ? hexu : hex;
    1c82:	00005817          	auipc	a6,0x5
    1c86:	ee680813          	addi	a6,a6,-282 # 6b68 <hex.0>
    1c8a:	00d79663          	bne	a5,a3,1c96 <stbsp_vsprintfcb+0x8f2>
    1c8e:	00005817          	auipc	a6,0x5
    1c92:	ec280813          	addi	a6,a6,-318 # 6b50 <hexu.1>
         l = (4 << 4) | (4 << 8);
    1c96:	44000793          	li	a5,1088
    1c9a:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__LEADING_0X) {
    1c9c:	008e7793          	andi	a5,t3,8
    1ca0:	7a079263          	bnez	a5,2444 <stbsp_vsprintfcb+0x10a0>
         lead[0] = 0;
    1ca4:	06010423          	sb	zero,104(sp)
         s = va_arg(va, char *);
    1ca8:	008b8793          	addi	a5,s7,8
    1cac:	e0be                	sd	a5,64(sp)
         if (fl & STBSP__INTMAX)
    1cae:	72070b63          	beqz	a4,23e4 <stbsp_vsprintfcb+0x1040>
            n64 = va_arg(va, stbsp__uint64);
    1cb2:	000bb683          	ld	a3,0(s7)
         dp = 0;
    1cb6:	d282                	sw	zero,100(sp)
         tail[0] = 0;
    1cb8:	06010823          	sb	zero,112(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    1cbc:	001e7513          	andi	a0,t3,1
         if (n64 == 0) {
    1cc0:	380694e3          	bnez	a3,2848 <stbsp_vsprintfcb+0x14a4>
            lead[0] = 0;
    1cc4:	06010423          	sb	zero,104(sp)
            if (pr == 0) {
    1cc8:	78089a63          	bnez	a7,245c <stbsp_vsprintfcb+0x10b8>
         if (fw < (stbsp__int32)n)
    1ccc:	fffb4313          	not	t1,s6
    1cd0:	43f35313          	srai	t1,t1,0x3f
               l = 0;
    1cd4:	d082                	sw	zero,96(sp)
         if (fw < (stbsp__int32)n)
    1cd6:	01637333          	and	t1,t1,s6
               goto scopy;
    1cda:	4701                	li	a4,0
    1cdc:	4f81                	li	t6,0
    1cde:	4a01                	li	s4,0
               cs = 0;
    1ce0:	4281                	li	t0,0
         s = num + STBSP__NUMSZ;
    1ce2:	28010a93          	addi	s5,sp,640
         if ((fl & STBSP__LEFTJUST) == 0) {
    1ce6:	9c0506e3          	beqz	a0,16b2 <stbsp_vsprintfcb+0x30e>
         if (fw + pr) {
    1cea:	00e307bb          	addw	a5,t1,a4
    1cee:	9c079fe3          	bnez	a5,16cc <stbsp_vsprintfcb+0x328>
    1cf2:	06910793          	addi	a5,sp,105
    1cf6:	b661                	j	187e <stbsp_vsprintfcb+0x4da>
         h = (f[0] == 'E') ? hexu : hex;
    1cf8:	04500713          	li	a4,69
    1cfc:	00005317          	auipc	t1,0x5
    1d00:	e6c30313          	addi	t1,t1,-404 # 6b68 <hex.0>
    1d04:	1ce78ae3          	beq	a5,a4,26d8 <stbsp_vsprintfcb+0x1334>
         fv = va_arg(va, double);
    1d08:	008b8713          	addi	a4,s7,8
         if (pr == -1)
    1d0c:	57fd                	li	a5,-1
         fv = va_arg(va, double);
    1d0e:	e0ba                	sd	a4,64(sp)
    1d10:	000bb507          	fld	fa0,0(s7)
         if (pr == -1)
    1d14:	1af88ce3          	beq	a7,a5,26cc <stbsp_vsprintfcb+0x1328>
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr | 0x80000000))
    1d18:	80000737          	lui	a4,0x80000
    1d1c:	00e8e733          	or	a4,a7,a4
    1d20:	2701                	sext.w	a4,a4
    1d22:	10d4                	addi	a3,sp,100
    1d24:	0110                	addi	a2,sp,128
    1d26:	108c                	addi	a1,sp,96
    1d28:	18a8                	addi	a0,sp,120
    1d2a:	f41e                	sd	t2,40(sp)
    1d2c:	f01a                	sd	t1,32(sp)
    1d2e:	ec72                	sd	t3,24(sp)
    1d30:	e846                	sd	a7,16(sp)
    1d32:	d8efe0ef          	jal	2c0 <stbsp__real_to_str>
    1d36:	68c2                	ld	a7,16(sp)
    1d38:	6e62                	ld	t3,24(sp)
    1d3a:	7302                	ld	t1,32(sp)
    1d3c:	73a2                	ld	t2,40(sp)
         if (dp == STBSP__SPECIAL) {
    1d3e:	5796                	lw	a5,100(sp)
            s = (char *)sn;
    1d40:	7ae6                	ld	s5,120(sp)
         if ((l - 1) > (stbsp__uint32)pr)
    1d42:	5686                	lw	a3,96(sp)
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr | 0x80000000))
    1d44:	3c0511e3          	bnez	a0,2906 <stbsp_vsprintfcb+0x1562>
         tail[0] = 0;
    1d48:	06010823          	sb	zero,112(sp)
   sign[0] = 0;
    1d4c:	06010423          	sb	zero,104(sp)
   } else if (fl & STBSP__LEADINGSPACE) {
    1d50:	004e7713          	andi	a4,t3,4
    1d54:	6a070ee3          	beqz	a4,2c10 <stbsp_vsprintfcb+0x186c>
      sign[0] = 1;
    1d58:	6709                	lui	a4,0x2
    1d5a:	0705                	addi	a4,a4,1 # 2001 <stbsp_vsprintfcb+0xc5d>
    1d5c:	06e11423          	sh	a4,104(sp)
         if (dp == STBSP__SPECIAL) {
    1d60:	671d                	lui	a4,0x7
    1d62:	1ee794e3          	bne	a5,a4,274a <stbsp_vsprintfcb+0x13a6>
         if (pr < (stbsp__int32)l)
    1d66:	0006879b          	sext.w	a5,a3
         n = pr + lead[0] + tail[0] + tz;
    1d6a:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    1d6e:	fff7c793          	not	a5,a5
         n = pr + lead[0] + tail[0] + tz;
    1d72:	07014f83          	lbu	t6,112(sp)
         if (pr < (stbsp__int32)l)
    1d76:	97fd                	srai	a5,a5,0x3f
    1d78:	8ff5                	and	a5,a5,a3
         n = pr + lead[0] + tail[0] + tz;
    1d7a:	00fa073b          	addw	a4,s4,a5
    1d7e:	01f7063b          	addw	a2,a4,t6
    1d82:	8732                	mv	a4,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    1d84:	001e7513          	andi	a0,t3,1
         if (pr < (stbsp__int32)l)
    1d88:	2781                	sext.w	a5,a5
         if (fw < (stbsp__int32)n)
    1d8a:	835a                	mv	t1,s6
    1d8c:	00cb5363          	bge	s6,a2,1d92 <stbsp_vsprintfcb+0x9ee>
    1d90:	8332                	mv	t1,a2
         fw -= n;
    1d92:	40e3033b          	subw	t1,t1,a4
            cs = 0;
    1d96:	4281                	li	t0,0
         pr -= l;
    1d98:	40d7873b          	subw	a4,a5,a3
      tz = 0;
    1d9c:	4881                	li	a7,0
            goto scopy;
    1d9e:	b7a1                	j	1ce6 <stbsp_vsprintfcb+0x942>
         h = (f[0] == 'G') ? hexu : hex;
    1da0:	04700713          	li	a4,71
    1da4:	00005317          	auipc	t1,0x5
    1da8:	dc430313          	addi	t1,t1,-572 # 6b68 <hex.0>
    1dac:	14e783e3          	beq	a5,a4,26f2 <stbsp_vsprintfcb+0x134e>
         fv = va_arg(va, double);
    1db0:	008b8713          	addi	a4,s7,8
         if (pr == -1)
    1db4:	57fd                	li	a5,-1
         fv = va_arg(va, double);
    1db6:	e0ba                	sd	a4,64(sp)
    1db8:	000bb507          	fld	fa0,0(s7)
         if (pr == -1)
    1dbc:	12f884e3          	beq	a7,a5,26e4 <stbsp_vsprintfcb+0x1340>
         else if (pr == 0)
    1dc0:	6e0887e3          	beqz	a7,2cae <stbsp_vsprintfcb+0x190a>
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, (pr - 1) | 0x80000000))
    1dc4:	fff8871b          	addiw	a4,a7,-1
    1dc8:	800007b7          	lui	a5,0x80000
    1dcc:	8f5d                	or	a4,a4,a5
    1dce:	2701                	sext.w	a4,a4
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    1dd0:	00088a9b          	sext.w	s5,a7
    1dd4:	8a46                	mv	s4,a7
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, (pr - 1) | 0x80000000))
    1dd6:	10d4                	addi	a3,sp,100
    1dd8:	0110                	addi	a2,sp,128
    1dda:	108c                	addi	a1,sp,96
    1ddc:	18a8                	addi	a0,sp,120
    1dde:	f01e                	sd	t2,32(sp)
    1de0:	ec1a                	sd	t1,24(sp)
    1de2:	e872                	sd	t3,16(sp)
    1de4:	cdcfe0ef          	jal	2c0 <stbsp__real_to_str>
    1de8:	6e42                	ld	t3,16(sp)
    1dea:	6362                	ld	t1,24(sp)
    1dec:	7382                	ld	t2,32(sp)
    1dee:	4281                	li	t0,0
    1df0:	c509                	beqz	a0,1dfa <stbsp_vsprintfcb+0xa56>
            fl |= STBSP__NEGATIVE;
    1df2:	080e6e13          	ori	t3,t3,128
    1df6:	08000293          	li	t0,128
         if (l > (stbsp__uint32)pr)
    1dfa:	5806                	lw	a6,96(sp)
    1dfc:	010af463          	bgeu	s5,a6,1e04 <stbsp_vsprintfcb+0xa60>
            l = pr;
    1e00:	d0d6                	sw	s5,96(sp)
    1e02:	8856                	mv	a6,s5
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    1e04:	4705                	li	a4,1
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    1e06:	5796                	lw	a5,100(sp)
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    1e08:	01076463          	bltu	a4,a6,1e10 <stbsp_vsprintfcb+0xa6c>
    1e0c:	1800106f          	j	2f8c <stbsp_vsprintfcb+0x1be8>
    1e10:	7be6                	ld	s7,120(sp)
    1e12:	fff8071b          	addiw	a4,a6,-1
    1e16:	1702                	slli	a4,a4,0x20
    1e18:	9301                	srli	a4,a4,0x20
    1e1a:	001a0e9b          	addiw	t4,s4,1
    1e1e:	75e2                	ld	a1,56(sp)
    1e20:	8ade                	mv	s5,s7
    1e22:	975e                	add	a4,a4,s7
    1e24:	410e8ebb          	subw	t4,t4,a6
    1e28:	88d2                	mv	a7,s4
    1e2a:	86c2                	mv	a3,a6
    1e2c:	4f01                	li	t5,0
    1e2e:	03000f93          	li	t6,48
    1e32:	e842                	sd	a6,16(sp)
    1e34:	a809                	j	1e46 <stbsp_vsprintfcb+0xaa2>
            --pr;
    1e36:	38fd                	addiw	a7,a7,-1
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    1e38:	211e80e3          	beq	t4,a7,2838 <stbsp_vsprintfcb+0x1494>
    1e3c:	177d                	addi	a4,a4,-1 # 6fff <_stdout+0x5f>
    1e3e:	4f05                	li	t5,1
    1e40:	1e088ce3          	beqz	a7,2838 <stbsp_vsprintfcb+0x1494>
            --l;
    1e44:	85b6                	mv	a1,a3
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    1e46:	00074803          	lbu	a6,0(a4)
    1e4a:	fff6861b          	addiw	a2,a3,-1 # ffffff <_ZSt4cerr+0xff8687>
    1e4e:	0006851b          	sext.w	a0,a3
    1e52:	2581                	sext.w	a1,a1
    1e54:	0006069b          	sext.w	a3,a2
    1e58:	fdf80fe3          	beq	a6,t6,1e36 <stbsp_vsprintfcb+0xa92>
    1e5c:	6842                	ld	a6,16(sp)
    1e5e:	fc2e                	sd	a1,56(sp)
    1e60:	86c2                	mv	a3,a6
    1e62:	000f0463          	beqz	t5,1e6a <stbsp_vsprintfcb+0xac6>
    1e66:	d0ae                	sw	a1,96(sp)
    1e68:	86ae                	mv	a3,a1
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    1e6a:	5775                	li	a4,-3
    1e6c:	08e7cee3          	blt	a5,a4,2708 <stbsp_vsprintfcb+0x1364>
    1e70:	08fa4be3          	blt	s4,a5,2706 <stbsp_vsprintfcb+0x1362>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    1e74:	0005071b          	sext.w	a4,a0
         if (dp > 0) {
    1e78:	7ef057e3          	blez	a5,2e66 <stbsp_vsprintfcb+0x1ac2>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    1e7c:	4881                	li	a7,0
    1e7e:	00e7d463          	bge	a5,a4,1e86 <stbsp_vsprintfcb+0xae2>
    1e82:	40f508bb          	subw	a7,a0,a5
         tail[0] = 0;
    1e86:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    1e8a:	20029463          	bnez	t0,2092 <stbsp_vsprintfcb+0xcee>
   } else if (fl & STBSP__LEADINGSPACE) {
    1e8e:	004e7713          	andi	a4,t3,4
    1e92:	000715e3          	bnez	a4,269c <stbsp_vsprintfcb+0x12f8>
   } else if (fl & STBSP__LEADINGPLUS) {
    1e96:	002e7713          	andi	a4,t3,2
    1e9a:	660719e3          	bnez	a4,2d0c <stbsp_vsprintfcb+0x1968>
   sign[0] = 0;
    1e9e:	06010423          	sb	zero,104(sp)
    1ea2:	aaed                	j	209c <stbsp_vsprintfcb+0xcf8>
         h = (f[0] == 'A') ? hexu : hex;
    1ea4:	04100713          	li	a4,65
    1ea8:	00005597          	auipc	a1,0x5
    1eac:	cc058593          	addi	a1,a1,-832 # 6b68 <hex.0>
    1eb0:	00e783e3          	beq	a5,a4,26b6 <stbsp_vsprintfcb+0x1312>
         fv = va_arg(va, double);
    1eb4:	008b8693          	addi	a3,s7,8
         if (pr == -1)
    1eb8:	577d                	li	a4,-1
         fv = va_arg(va, double);
    1eba:	e0b6                	sd	a3,64(sp)
    1ebc:	000bb783          	ld	a5,0(s7)
         if (pr == -1)
    1ec0:	7ee88963          	beq	a7,a4,26b2 <stbsp_vsprintfcb+0x130e>
   d = value;

   STBSP__COPYFP(b, d);

   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    1ec4:	4347d613          	srai	a2,a5,0x34
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    1ec8:	00c79513          	slli	a0,a5,0xc
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    1ecc:	7ff67613          	andi	a2,a2,2047
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    1ed0:	8131                	srli	a0,a0,0xc
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    1ed2:	c016061b          	addiw	a2,a2,-1023
         if (stbsp__real_to_parts((stbsp__int64 *)&n64, &dp, fv))
    1ed6:	7a07c863          	bltz	a5,2686 <stbsp_vsprintfcb+0x12e2>
   } else if (fl & STBSP__LEADINGSPACE) {
    1eda:	004e7793          	andi	a5,t3,4
    1ede:	60078ee3          	beqz	a5,2cfa <stbsp_vsprintfcb+0x1956>
    1ee2:	6789                	lui	a5,0x2
    1ee4:	2785                	addiw	a5,a5,1 # 2001 <stbsp_vsprintfcb+0xc5d>
      sign[0] = 1;
    1ee6:	06f11423          	sh	a5,104(sp)
    1eea:	468d                	li	a3,3
    1eec:	4a0d                	li	s4,3
    1eee:	4809                	li	a6,2
            n64 |= (((stbsp__uint64)1) << 52);
    1ef0:	4705                	li	a4,1
    1ef2:	1752                	slli	a4,a4,0x34
         if (dp == -1023)
    1ef4:	c0100793          	li	a5,-1023
            n64 |= (((stbsp__uint64)1) << 52);
    1ef8:	8f49                	or	a4,a4,a0
         if (dp == -1023)
    1efa:	5cf600e3          	beq	a2,a5,2cba <stbsp_vsprintfcb+0x1916>
         if (pr < 15)
    1efe:	4539                	li	a0,14
         n64 <<= (64 - 56);
    1f00:	00871793          	slli	a5,a4,0x8
         if (pr < 15)
    1f04:	251546e3          	blt	a0,a7,2950 <stbsp_vsprintfcb+0x15ac>
            n64 += ((((stbsp__uint64)8) << 56) >> (pr * 4));
    1f08:	4705                	li	a4,1
    1f0a:	0028951b          	slliw	a0,a7,0x2
    1f0e:	176e                	slli	a4,a4,0x3b
    1f10:	00a75733          	srl	a4,a4,a0
    1f14:	973e                	add	a4,a4,a5
         *s++ = h[(n64 >> 60) & 15];
    1f16:	03c75793          	srli	a5,a4,0x3c
    1f1a:	97ae                	add	a5,a5,a1
    1f1c:	0007c503          	lbu	a0,0(a5)
         lead[1 + lead[0]] = '0';
    1f20:	22080793          	addi	a5,a6,544
    1f24:	06010813          	addi	a6,sp,96
    1f28:	97c2                	add	a5,a5,a6
    1f2a:	03000813          	li	a6,48
    1f2e:	df078423          	sb	a6,-536(a5)
         lead[2 + lead[0]] = 'x';
    1f32:	22068793          	addi	a5,a3,544
    1f36:	1094                	addi	a3,sp,96
    1f38:	96be                	add	a3,a3,a5
    1f3a:	07800793          	li	a5,120
    1f3e:	def68423          	sb	a5,-536(a3)
         lead[0] += 2;
    1f42:	07410423          	sb	s4,104(sp)
         *s++ = h[(n64 >> 60) & 15];
    1f46:	0ca10023          	sb	a0,192(sp)
         if (pr)
    1f4a:	740893e3          	bnez	a7,2e90 <stbsp_vsprintfcb+0x1aec>
         sn = s;
    1f4e:	0c110793          	addi	a5,sp,193
    1f52:	fcbe                	sd	a5,120(sp)
    1f54:	4701                	li	a4,0
    1f56:	4501                	li	a0,0
    1f58:	4305                	li	t1,1
    1f5a:	4685                	li	a3,1
         tail[1] = h[17];
    1f5c:	0115c583          	lbu	a1,17(a1)
            tail[2] = '+';
    1f60:	02b00793          	li	a5,43
         tail[1] = h[17];
    1f64:	06b108a3          	sb	a1,113(sp)
         if (dp < 0) {
    1f68:	00065663          	bgez	a2,1f74 <stbsp_vsprintfcb+0xbd0>
            dp = -dp;
    1f6c:	40c0063b          	negw	a2,a2
            tail[2] = '-';
    1f70:	02d00793          	li	a5,45
            tail[n] = '0' + dp % 10;
    1f74:	4829                	li	a6,10
    1f76:	030665bb          	remw	a1,a2,a6
    1f7a:	06f10923          	sb	a5,114(sp)
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    1f7e:	3e700e93          	li	t4,999
            tail[n] = '0' + dp % 10;
    1f82:	0305859b          	addiw	a1,a1,48
    1f86:	0ff5f593          	zext.b	a1,a1
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    1f8a:	18cec3e3          	blt	t4,a2,2910 <stbsp_vsprintfcb+0x156c>
    1f8e:	06300e93          	li	t4,99
    1f92:	54cec1e3          	blt	t4,a2,2cd4 <stbsp_vsprintfcb+0x1930>
    1f96:	4ea5                	li	t4,9
    1f98:	72ced6e3          	bge	t4,a2,2ec4 <stbsp_vsprintfcb+0x1b20>
            dp /= 10;
    1f9c:	030647bb          	divw	a5,a2,a6
         tail[0] = (char)n;
    1fa0:	4611                	li	a2,4
    1fa2:	06c10823          	sb	a2,112(sp)
            tail[n] = '0' + dp % 10;
    1fa6:	06b10a23          	sb	a1,116(sp)
    1faa:	4811                	li	a6,4
    1fac:	4f91                	li	t6,4
    1fae:	0307879b          	addiw	a5,a5,48
    1fb2:	06f109a3          	sb	a5,115(sp)
         n = pr + lead[0] + tail[0] + tz;
    1fb6:	006a07bb          	addw	a5,s4,t1
    1fba:	010787bb          	addw	a5,a5,a6
    1fbe:	0117863b          	addw	a2,a5,a7
         dp = (int)(s - sn);
    1fc2:	d2aa                	sw	a0,100(sp)
         l = (int)(s - (num + 64));
    1fc4:	d0b6                	sw	a3,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    1fc6:	87b2                	mv	a5,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    1fc8:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    1fcc:	835a                	mv	t1,s6
    1fce:	00cb5363          	bge	s6,a2,1fd4 <stbsp_vsprintfcb+0xc30>
    1fd2:	8332                	mv	t1,a2
         cs = 1 + (3 << 24);
    1fd4:	030002b7          	lui	t0,0x3000
         fw -= n;
    1fd8:	40f3033b          	subw	t1,t1,a5
         cs = 1 + (3 << 24);
    1fdc:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff8689>
         s = num + 64;
    1fde:	0c010a93          	addi	s5,sp,192
         goto scopy;
    1fe2:	b311                	j	1ce6 <stbsp_vsprintfcb+0x942>
         h = (f[0] == 'B') ? hexu : hex;
    1fe4:	04200713          	li	a4,66
    1fe8:	00005817          	auipc	a6,0x5
    1fec:	b8080813          	addi	a6,a6,-1152 # 6b68 <hex.0>
    1ff0:	6ce78963          	beq	a5,a4,26c2 <stbsp_vsprintfcb+0x131e>
         if (fl & STBSP__LEADING_0X) {
    1ff4:	008e7793          	andi	a5,t3,8
    1ff8:	66079e63          	bnez	a5,2674 <stbsp_vsprintfcb+0x12d0>
         lead[0] = 0;
    1ffc:	06010423          	sb	zero,104(sp)
         l = (8 << 4) | (1 << 8);
    2000:	18000793          	li	a5,384
    2004:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__INTMAX) {
    2006:	020e7713          	andi	a4,t3,32
         goto radixnum;
    200a:	b979                	j	1ca8 <stbsp_vsprintfcb+0x904>
         *s = (char)va_arg(va, int);
    200c:	000ba783          	lw	a5,0(s7)
         l = 1;
    2010:	4705                	li	a4,1
    2012:	d0ba                	sw	a4,96(sp)
         *s = (char)va_arg(va, int);
    2014:	26f10fa3          	sb	a5,639(sp)
    2018:	008b8793          	addi	a5,s7,8
         lead[0] = 0;
    201c:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    2020:	06010823          	sb	zero,112(sp)
         dp = 0;
    2024:	d282                	sw	zero,100(sp)
         *s = (char)va_arg(va, int);
    2026:	e0be                	sd	a5,64(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    2028:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    202c:	835a                	mv	t1,s6
    202e:	69605063          	blez	s6,26ae <stbsp_vsprintfcb+0x130a>
         fw -= n;
    2032:	337d                	addiw	t1,t1,-1
         goto scopy;
    2034:	4701                	li	a4,0
    2036:	4f81                	li	t6,0
    2038:	4685                	li	a3,1
    203a:	4a01                	li	s4,0
         cs = 0;
    203c:	4281                	li	t0,0
         s = num + STBSP__NUMSZ - 1;
    203e:	27f10a93          	addi	s5,sp,639
      tz = 0;
    2042:	4881                	li	a7,0
         goto scopy;
    2044:	b14d                	j	1ce6 <stbsp_vsprintfcb+0x942>
         fv = va_arg(va, double);
    2046:	008b8713          	addi	a4,s7,8
         if (fl & STBSP__METRIC_SUFFIX) {
    204a:	100e7793          	andi	a5,t3,256
         fv = va_arg(va, double);
    204e:	e0ba                	sd	a4,64(sp)
    2050:	000bb507          	fld	fa0,0(s7)
         if (fl & STBSP__METRIC_SUFFIX) {
    2054:	be0795e3          	bnez	a5,1c3e <stbsp_vsprintfcb+0x89a>
         if (pr == -1)
    2058:	57fd                	li	a5,-1
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    205a:	0008871b          	sext.w	a4,a7
         if (pr == -1)
    205e:	00f89463          	bne	a7,a5,2066 <stbsp_vsprintfcb+0xcc2>
    2062:	4719                	li	a4,6
            pr = 6; // default is 6
    2064:	4899                	li	a7,6
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    2066:	10d4                	addi	a3,sp,100
    2068:	0110                	addi	a2,sp,128
    206a:	108c                	addi	a1,sp,96
    206c:	18a8                	addi	a0,sp,120
    206e:	f01e                	sd	t2,32(sp)
    2070:	ec72                	sd	t3,24(sp)
    2072:	e846                	sd	a7,16(sp)
    2074:	a4cfe0ef          	jal	2c0 <stbsp__real_to_str>
    2078:	6e62                	ld	t3,24(sp)
    207a:	68c2                	ld	a7,16(sp)
    207c:	7382                	ld	t2,32(sp)
         if (dp == STBSP__SPECIAL) {
    207e:	5796                	lw	a5,100(sp)
            if ((stbsp__int32)(l + n) > pr)
    2080:	5686                	lw	a3,96(sp)
   if (fl & STBSP__NEGATIVE) {
    2082:	080e7293          	andi	t0,t3,128
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    2086:	e00500e3          	beqz	a0,1e86 <stbsp_vsprintfcb+0xae2>
            fl |= STBSP__NEGATIVE;
    208a:	080e6e13          	ori	t3,t3,128
         tail[0] = 0;
    208e:	06010823          	sb	zero,112(sp)
      sign[0] = 1;
    2092:	670d                	lui	a4,0x3
    2094:	d0170713          	addi	a4,a4,-767 # 2d01 <stbsp_vsprintfcb+0x195d>
    2098:	06e11423          	sh	a4,104(sp)
         if (dp == STBSP__SPECIAL) {
    209c:	671d                	lui	a4,0x7
    209e:	7ce78963          	beq	a5,a4,2870 <stbsp_vsprintfcb+0x14cc>
         if (dp <= 0) {
    20a2:	46f05fe3          	blez	a5,2d20 <stbsp_vsprintfcb+0x197c>
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((600 - (stbsp__uint32)dp) % 3) : 0;
    20a6:	040e7313          	andi	t1,t3,64
    20aa:	00078e9b          	sext.w	t4,a5
    20ae:	4581                	li	a1,0
    20b0:	00030963          	beqz	t1,20c2 <stbsp_vsprintfcb+0xd1e>
    20b4:	25800593          	li	a1,600
    20b8:	41d585bb          	subw	a1,a1,t4
    20bc:	470d                	li	a4,3
    20be:	02e5f5bb          	remuw	a1,a1,a4
                     *s++ = stbsp__comma;
    20c2:	00005a17          	auipc	s4,0x5
    20c6:	9bea0a13          	addi	s4,s4,-1602 # 6a80 <stbsp__digitpair>
            s = (char *)sn;
    20ca:	7f66                	ld	t5,120(sp)
                     *s++ = stbsp__comma;
    20cc:	0cda4283          	lbu	t0,205(s4)
         s = num + 64;
    20d0:	0c010a93          	addi	s5,sp,192
            if ((stbsp__uint32)dp >= l) {
    20d4:	44defb63          	bgeu	t4,a3,252a <stbsp_vsprintfcb+0x1186>
               n = 0;
    20d8:	4501                	li	a0,0
         s = num + 64;
    20da:	8756                	mv	a4,s5
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    20dc:	4b91                	li	s7,4
    20de:	a015                	j	2102 <stbsp_vsprintfcb+0xd5e>
    20e0:	8642                	mv	a2,a6
    20e2:	883a                	mv	a6,a4
    20e4:	8732                	mv	a4,a2
                     *s++ = sn[n];
    20e6:	02051613          	slli	a2,a0,0x20
    20ea:	9201                	srli	a2,a2,0x20
    20ec:	967a                	add	a2,a2,t5
    20ee:	00064f83          	lbu	t6,0(a2)
                     ++n;
    20f2:	0015061b          	addiw	a2,a0,1
    20f6:	0006051b          	sext.w	a0,a2
                     *s++ = sn[n];
    20fa:	fff70fa3          	sb	t6,-1(a4) # 6fff <_stdout+0x5f>
                     if (n >= (stbsp__uint32)dp)
    20fe:	7bd57563          	bgeu	a0,t4,28a8 <stbsp_vsprintfcb+0x1504>
                     *s++ = stbsp__comma;
    2102:	00170813          	addi	a6,a4,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2106:	fc030de3          	beqz	t1,20e0 <stbsp_vsprintfcb+0xd3c>
    210a:	2585                	addiw	a1,a1,1
    210c:	fd759ae3          	bne	a1,s7,20e0 <stbsp_vsprintfcb+0xd3c>
                     *s++ = stbsp__comma;
    2110:	fe580fa3          	sb	t0,-1(a6)
    2114:	0709                	addi	a4,a4,2
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2116:	4585                	li	a1,1
    2118:	b7f9                	j	20e6 <stbsp_vsprintfcb+0xd42>
         *d = tlen + (int)(bf - buf);
    211a:	000bb703          	ld	a4,0(s7)
    211e:	412407b3          	sub	a5,s0,s2
    2122:	01a787bb          	addw	a5,a5,s10
         int *d = va_arg(va, int *);
    2126:	008b8693          	addi	a3,s7,8
    212a:	e0b6                	sd	a3,64(sp)
         *d = tlen + (int)(bf - buf);
    212c:	c31c                	sw	a5,0(a4)
      } break;
    212e:	bae5                	j	1b26 <stbsp_vsprintfcb+0x782>
         if (fl & STBSP__LEADING_0X) {
    2130:	008e7793          	andi	a5,t3,8
    2134:	50079b63          	bnez	a5,264a <stbsp_vsprintfcb+0x12a6>
         lead[0] = 0;
    2138:	06010423          	sb	zero,104(sp)
         l = (3 << 4) | (3 << 8);
    213c:	33000793          	li	a5,816
    2140:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__INTMAX) {
    2142:	020e7713          	andi	a4,t3,32
         h = hexu;
    2146:	00005817          	auipc	a6,0x5
    214a:	a0a80813          	addi	a6,a6,-1526 # 6b50 <hexu.1>
         goto radixnum;
    214e:	bea9                	j	1ca8 <stbsp_vsprintfcb+0x904>
         fl &= ~STBSP__LEADINGZERO; // 'p' only prints the pointer with zeros
    2150:	fefe7e13          	andi	t3,t3,-17
    2154:	020e6e13          	ori	t3,t3,32
    2158:	02000713          	li	a4,32
         pr = sizeof(void *) * 2;
    215c:	48c1                	li	a7,16
         h = (f[0] == 'X') ? hexu : hex;
    215e:	00005817          	auipc	a6,0x5
    2162:	a0a80813          	addi	a6,a6,-1526 # 6b68 <hex.0>
    2166:	be05                	j	1c96 <stbsp_vsprintfcb+0x8f2>
         s = va_arg(va, char *);
    2168:	000bba83          	ld	s5,0(s7)
    216c:	008b8793          	addi	a5,s7,8
    2170:	e0be                	sd	a5,64(sp)
         if (s == 0)
    2172:	360a8ee3          	beqz	s5,2cee <stbsp_vsprintfcb+0x194a>
      if (((stbsp__uintptr)sn & 3) == 0)
    2176:	003af793          	andi	a5,s5,3
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    217a:	5208c663          	bltz	a7,26a6 <stbsp_vsprintfcb+0x1302>
    217e:	0008869b          	sext.w	a3,a7
      if (((stbsp__uintptr)sn & 3) == 0)
    2182:	2a0782e3          	beqz	a5,2c26 <stbsp_vsprintfcb+0x1882>
      if (!limit || *sn == 0)
    2186:	5a068b63          	beqz	a3,273c <stbsp_vsprintfcb+0x1398>
      if (((stbsp__uintptr)sn & 3) == 0)
    218a:	87d6                	mv	a5,s5
    218c:	a801                	j	219c <stbsp_vsprintfcb+0xdf8>
      ++sn;
    218e:	0785                	addi	a5,a5,1
      if (((stbsp__uintptr)sn & 3) == 0)
    2190:	0037f713          	andi	a4,a5,3
      --limit;
    2194:	36fd                	addiw	a3,a3,-1
      if (((stbsp__uintptr)sn & 3) == 0)
    2196:	280709e3          	beqz	a4,2c28 <stbsp_vsprintfcb+0x1884>
      if (!limit || *sn == 0)
    219a:	c681                	beqz	a3,21a2 <stbsp_vsprintfcb+0xdfe>
    219c:	0007c703          	lbu	a4,0(a5)
    21a0:	f77d                	bnez	a4,218e <stbsp_vsprintfcb+0xdea>
         return (stbsp__uint32)(sn - s);
    21a2:	415787b3          	sub	a5,a5,s5
    21a6:	0007869b          	sext.w	a3,a5
         if (pr < (stbsp__int32)l)
    21aa:	fff6c713          	not	a4,a3
    21ae:	977d                	srai	a4,a4,0x3f
    21b0:	8f7d                	and	a4,a4,a5
    21b2:	0007079b          	sext.w	a5,a4
         n = pr + lead[0] + tail[0] + tz;
    21b6:	863e                	mv	a2,a5
         pr -= l;
    21b8:	9f15                	subw	a4,a4,a3
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    21ba:	d0b6                	sw	a3,96(sp)
         lead[0] = 0;
    21bc:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    21c0:	06010823          	sb	zero,112(sp)
         dp = 0;
    21c4:	d282                	sw	zero,100(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    21c6:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    21ca:	835a                	mv	t1,s6
    21cc:	00fb5363          	bge	s6,a5,21d2 <stbsp_vsprintfcb+0xe2e>
    21d0:	833e                	mv	t1,a5
         fw -= n;
    21d2:	40c3033b          	subw	t1,t1,a2
         goto scopy;
    21d6:	4f81                	li	t6,0
    21d8:	4a01                	li	s4,0
         cs = 0;
    21da:	4281                	li	t0,0
      tz = 0;
    21dc:	4881                	li	a7,0
         goto scopy;
    21de:	b621                	j	1ce6 <stbsp_vsprintfcb+0x942>
                     *bf++ = stbsp__comma;
    21e0:	87b2                	mv	a5,a2
                     cs = 0;
    21e2:	4a01                	li	s4,0
    21e4:	e44ff06f          	j	1828 <stbsp_vsprintfcb+0x484>
               lead[0] -= (char)i;
    21e8:	06010423          	sb	zero,104(sp)
               while (i) {
    21ec:	d38ff06f          	j	1724 <stbsp_vsprintfcb+0x380>
            lead[0] -= (char)i;
    21f0:	06010423          	sb	zero,104(sp)
            while (i) {
    21f4:	ed8ff06f          	j	18cc <stbsp_vsprintfcb+0x528>
            while (i >= 4) {
    21f8:	06fadc63          	bge	s5,a5,2270 <stbsp_vsprintfcb+0xecc>
            tz -= i;
    21fc:	8722                	mv	a4,s0
    21fe:	0007851b          	sext.w	a0,a5
            while (i >= 4) {
    2202:	008785bb          	addw	a1,a5,s0
               *(stbsp__uint32 *)bf = 0x30303030;
    2206:	01672023          	sw	s6,0(a4)
               bf += 4;
    220a:	0711                	addi	a4,a4,4
            while (i >= 4) {
    220c:	40e5863b          	subw	a2,a1,a4
    2210:	fecacbe3          	blt	s5,a2,2206 <stbsp_vsprintfcb+0xe62>
    2214:	ffc5061b          	addiw	a2,a0,-4
    2218:	0026561b          	srliw	a2,a2,0x2
    221c:	0016071b          	addiw	a4,a2,1
    2220:	37f1                	addiw	a5,a5,-4
    2222:	0026161b          	slliw	a2,a2,0x2
    2226:	070a                	slli	a4,a4,0x2
    2228:	9722                	add	a4,a4,s0
    222a:	9f91                	subw	a5,a5,a2
            while (i) {
    222c:	843a                	mv	s0,a4
    222e:	80078de3          	beqz	a5,1a48 <stbsp_vsprintfcb+0x6a4>
    2232:	1782                	slli	a5,a5,0x20
    2234:	9381                	srli	a5,a5,0x20
    2236:	00f70433          	add	s0,a4,a5
               *bf++ = '0';
    223a:	0705                	addi	a4,a4,1
    223c:	ff470fa3          	sb	s4,-1(a4)
            while (i) {
    2240:	fe871de3          	bne	a4,s0,223a <stbsp_vsprintfcb+0xe96>
    2244:	805ff06f          	j	1a48 <stbsp_vsprintfcb+0x6a4>
               stbsp__cb_buf_clamp(i, pr);
    2248:	85ce                	mv	a1,s3
               if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    224a:	4981                	li	s3,0
    224c:	dc049263          	bnez	s1,1810 <stbsp_vsprintfcb+0x46c>
    2250:	b8d5                	j	1b44 <stbsp_vsprintfcb+0x7a0>
            STBSP__UNALIGNED(while (i >= 4) {
    2252:	4401                	li	s0,0
    2254:	85be                	mv	a1,a5
    2256:	f0ea4b63          	blt	s4,a4,196c <stbsp_vsprintfcb+0x5c8>
    225a:	f42ff06f          	j	199c <stbsp_vsprintfcb+0x5f8>
               if ((((stbsp__uintptr)bf) & 3) == 0)
    225e:	00347713          	andi	a4,s0,3
            stbsp__cb_buf_clamp(i, tz);
    2262:	87c6                	mv	a5,a7
            tz -= i;
    2264:	4881                	li	a7,0
               if ((((stbsp__uintptr)bf) & 3) == 0)
    2266:	fc071c63          	bnez	a4,1a3e <stbsp_vsprintfcb+0x69a>
            while (i >= 4) {
    226a:	470d                	li	a4,3
    226c:	f8f748e3          	blt	a4,a5,21fc <stbsp_vsprintfcb+0xe58>
    2270:	8722                	mv	a4,s0
    2272:	b7c1                	j	2232 <stbsp_vsprintfcb+0xe8e>
            tail[0] -= (char)i;
    2274:	06010823          	sb	zero,112(sp)
            while (i) {
    2278:	b0b9                	j	1ac6 <stbsp_vsprintfcb+0x722>
                  while (i >= 4) {
    227a:	478d                	li	a5,3
    227c:	8622                	mv	a2,s0
    227e:	d8b7d963          	bge	a5,a1,1810 <stbsp_vsprintfcb+0x46c>
    2282:	ffc5839b          	addiw	t2,a1,-4
    2286:	0023d79b          	srliw	a5,t2,0x2
    228a:	0017859b          	addiw	a1,a5,1
    228e:	058a                	slli	a1,a1,0x2
    2290:	942e                	add	s0,s0,a1
                     *(stbsp__uint32 *)bf = 0x30303030;
    2292:	01762023          	sw	s7,0(a2)
                     bf += 4;
    2296:	0611                	addi	a2,a2,4
                  while (i >= 4) {
    2298:	fe861de3          	bne	a2,s0,2292 <stbsp_vsprintfcb+0xeee>
    229c:	0027979b          	slliw	a5,a5,0x2
    22a0:	40f385bb          	subw	a1,t2,a5
    22a4:	d68ff06f          	j	180c <stbsp_vsprintfcb+0x468>
            while (i) {
    22a8:	85be                	mv	a1,a5
    22aa:	ee071963          	bnez	a4,199c <stbsp_vsprintfcb+0x5f8>
    22ae:	f16ff06f          	j	19c4 <stbsp_vsprintfcb+0x620>
    22b2:	2c013a03          	ld	s4,704(sp)
    22b6:	2b813a83          	ld	s5,696(sp)
    22ba:	2b013b03          	ld	s6,688(sp)
    22be:	8ca2                	mv	s9,s0
    22c0:	a04ff06f          	j	14c4 <stbsp_vsprintfcb+0x120>
            stbsp__chk_cb_buf(1);
    22c4:	2601                	sext.w	a2,a2
    22c6:	1fe00793          	li	a5,510
    22ca:	f8c7c563          	blt	a5,a2,1a54 <stbsp_vsprintfcb+0x6b0>
    22ce:	f3eff06f          	j	1a0c <stbsp_vsprintfcb+0x668>
               fl &= ~STBSP__TRIPLET_COMMA; // if no leading zeros, then no commas
    22d2:	fbfe7e13          	andi	t3,t3,-65
         if (fw + pr) {
    22d6:	006707bb          	addw	a5,a4,t1
               fl &= ~STBSP__TRIPLET_COMMA; // if no leading zeros, then no commas
    22da:	2e01                	sext.w	t3,t3
         if (fw + pr) {
    22dc:	a0078be3          	beqz	a5,1cf2 <stbsp_vsprintfcb+0x94e>
               while (fw > 0) {
    22e0:	be605663          	blez	t1,16cc <stbsp_vsprintfcb+0x328>
                     *(stbsp__uint32 *)bf = 0x20202020;
    22e4:	20202837          	lui	a6,0x20202
                  stbsp__cb_buf_clamp(i, fw);
    22e8:	854a                	mv	a0,s2
    22ea:	894e                	mv	s2,s3
    22ec:	69a2                	ld	s3,8(sp)
                     *(stbsp__uint32 *)bf = 0x20202020;
    22ee:	02080813          	addi	a6,a6,32 # 20202020 <_ZSt4cerr+0x201fa6a8>
                  stbsp__cb_buf_clamp(i, fw);
    22f2:	ec52                	sd	s4,24(sp)
    22f4:	f426                	sd	s1,40(sp)
    22f6:	87a2                	mv	a5,s0
    22f8:	84ea                	mv	s1,s10
                  stbsp__chk_cb_buf(1);
    22fa:	1fe00f13          	li	t5,510
                  stbsp__cb_buf_clamp(i, fw);
    22fe:	8d6e                	mv	s10,s11
                     *bf++ = ' ';
    2300:	02000b13          	li	s6,32
                  stbsp__cb_buf_clamp(i, fw);
    2304:	8de6                	mv	s11,s9
                  while (i >= 4) {
    2306:	4b8d                	li	s7,3
                  stbsp__cb_buf_clamp(i, fw);
    2308:	20000e93          	li	t4,512
    230c:	e846                	sd	a7,16(sp)
    230e:	f07e                	sd	t6,32(sp)
    2310:	f836                	sd	a3,48(sp)
    2312:	e4f2                	sd	t3,72(sp)
    2314:	e8ba                	sd	a4,80(sp)
    2316:	ec96                	sd	t0,88(sp)
    2318:	841a                	mv	s0,t1
    231a:	8a42                	mv	s4,a6
    231c:	8c9e                	mv	s9,t2
    231e:	0c090063          	beqz	s2,23de <stbsp_vsprintfcb+0x103a>
    2322:	40a78633          	sub	a2,a5,a0
    2326:	40ce873b          	subw	a4,t4,a2
    232a:	86ba                	mv	a3,a4
    232c:	00e45363          	bge	s0,a4,2332 <stbsp_vsprintfcb+0xf8e>
    2330:	86a2                	mv	a3,s0
    2332:	0006871b          	sext.w	a4,a3
                  fw -= i;
    2336:	9c15                	subw	s0,s0,a3
                  while (i) {
    2338:	e719                	bnez	a4,2346 <stbsp_vsprintfcb+0xfa2>
    233a:	a095                	j	239e <stbsp_vsprintfcb+0xffa>
                     *bf++ = ' ';
    233c:	01678023          	sb	s6,0(a5)
                     --i;
    2340:	377d                	addiw	a4,a4,-1
                     *bf++ = ' ';
    2342:	0785                	addi	a5,a5,1
                  while (i) {
    2344:	cb29                	beqz	a4,2396 <stbsp_vsprintfcb+0xff2>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    2346:	0037f693          	andi	a3,a5,3
    234a:	faed                	bnez	a3,233c <stbsp_vsprintfcb+0xf98>
                  while (i >= 4) {
    234c:	86be                	mv	a3,a5
    234e:	00070f9b          	sext.w	t6,a4
    2352:	00f705bb          	addw	a1,a4,a5
    2356:	02ebd763          	bge	s7,a4,2384 <stbsp_vsprintfcb+0xfe0>
                     *(stbsp__uint32 *)bf = 0x20202020;
    235a:	0146a023          	sw	s4,0(a3)
                     bf += 4;
    235e:	0691                	addi	a3,a3,4
                  while (i >= 4) {
    2360:	40d5863b          	subw	a2,a1,a3
    2364:	fecbcbe3          	blt	s7,a2,235a <stbsp_vsprintfcb+0xfb6>
    2368:	ffcf861b          	addiw	a2,t6,-4 # fffffffff7fffffc <_ZSt4cerr+0xfffffffff7ff8684>
    236c:	0026561b          	srliw	a2,a2,0x2
    2370:	0016069b          	addiw	a3,a2,1
    2374:	3771                	addiw	a4,a4,-4
    2376:	0026161b          	slliw	a2,a2,0x2
    237a:	068a                	slli	a3,a3,0x2
    237c:	96be                	add	a3,a3,a5
    237e:	9f11                	subw	a4,a4,a2
                  while (i) {
    2380:	87b6                	mv	a5,a3
    2382:	cb11                	beqz	a4,2396 <stbsp_vsprintfcb+0xff2>
    2384:	1702                	slli	a4,a4,0x20
    2386:	9301                	srli	a4,a4,0x20
    2388:	00e687b3          	add	a5,a3,a4
                     *bf++ = ' ';
    238c:	0685                	addi	a3,a3,1
    238e:	ff668fa3          	sb	s6,-1(a3)
                  while (i) {
    2392:	fef69de3          	bne	a3,a5,238c <stbsp_vsprintfcb+0xfe8>
                  stbsp__chk_cb_buf(1);
    2396:	40a78633          	sub	a2,a5,a0
    239a:	00090e63          	beqz	s2,23b6 <stbsp_vsprintfcb+0x1012>
    239e:	2601                	sext.w	a2,a2
    23a0:	00cf5b63          	bge	t5,a2,23b6 <stbsp_vsprintfcb+0x1012>
    23a4:	85ce                	mv	a1,s3
    23a6:	9cb1                	addw	s1,s1,a2
    23a8:	9902                	jalr	s2
    23aa:	c541                	beqz	a0,2432 <stbsp_vsprintfcb+0x108e>
    23ac:	87aa                	mv	a5,a0
    23ae:	20000e93          	li	t4,512
    23b2:	1fe00f13          	li	t5,510
               while (fw > 0) {
    23b6:	f68044e3          	bgtz	s0,231e <stbsp_vsprintfcb+0xf7a>
    23ba:	8322                	mv	t1,s0
    23bc:	89ca                	mv	s3,s2
    23be:	83e6                	mv	t2,s9
    23c0:	68c2                	ld	a7,16(sp)
    23c2:	8cee                	mv	s9,s11
    23c4:	6a62                	ld	s4,24(sp)
    23c6:	8dea                	mv	s11,s10
    23c8:	7f82                	ld	t6,32(sp)
    23ca:	8d26                	mv	s10,s1
    23cc:	76c2                	ld	a3,48(sp)
    23ce:	6e26                	ld	t3,72(sp)
    23d0:	6746                	ld	a4,80(sp)
    23d2:	62e6                	ld	t0,88(sp)
    23d4:	74a2                	ld	s1,40(sp)
    23d6:	892a                	mv	s2,a0
    23d8:	843e                	mv	s0,a5
    23da:	af2ff06f          	j	16cc <stbsp_vsprintfcb+0x328>
                  stbsp__cb_buf_clamp(i, fw);
    23de:	8722                	mv	a4,s0
    23e0:	4401                	li	s0,0
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    23e2:	b795                	j	2346 <stbsp_vsprintfcb+0xfa2>
            n64 = va_arg(va, stbsp__uint32);
    23e4:	000be683          	lwu	a3,0(s7)
    23e8:	b0f9                	j	1cb6 <stbsp_vsprintfcb+0x912>
    23ea:	2c013a03          	ld	s4,704(sp)
    23ee:	2b813a83          	ld	s5,696(sp)
    23f2:	2b013b03          	ld	s6,688(sp)
    23f6:	8cca                	mv	s9,s2
    23f8:	8ccff06f          	j	14c4 <stbsp_vsprintfcb+0x120>
    23fc:	8cd6                	mv	s9,s5
    23fe:	2c013a03          	ld	s4,704(sp)
    2402:	2b813a83          	ld	s5,696(sp)
    2406:	2b013b03          	ld	s6,688(sp)
    240a:	8baff06f          	j	14c4 <stbsp_vsprintfcb+0x120>
    240e:	2c013a03          	ld	s4,704(sp)
    2412:	2b813a83          	ld	s5,696(sp)
    2416:	2b013b03          	ld	s6,688(sp)
    241a:	8cea                	mv	s9,s10
    241c:	8a8ff06f          	j	14c4 <stbsp_vsprintfcb+0x120>
                  while (i) {
    2420:	85a2                	mv	a1,s0
    2422:	c12ff06f          	j	1834 <stbsp_vsprintfcb+0x490>
                  while (i >= 4) {
    2426:	478d                	li	a5,3
    2428:	8622                	mv	a2,s0
    242a:	e4b7cce3          	blt	a5,a1,2282 <stbsp_vsprintfcb+0xede>
    242e:	be2ff06f          	j	1810 <stbsp_vsprintfcb+0x46c>
    2432:	2c013a03          	ld	s4,704(sp)
    2436:	2b813a83          	ld	s5,696(sp)
    243a:	2b013b03          	ld	s6,688(sp)
    243e:	8ca6                	mv	s9,s1
    2440:	884ff06f          	j	14c4 <stbsp_vsprintfcb+0x120>
            lead[2] = h[16];
    2444:	01084683          	lbu	a3,16(a6)
            lead[0] = 2;
    2448:	678d                	lui	a5,0x3
    244a:	0789                	addi	a5,a5,2 # 3002 <stbsp_vsnprintf+0x1a>
    244c:	06f11423          	sh	a5,104(sp)
            lead[2] = h[16];
    2450:	06d10523          	sb	a3,106(sp)
    2454:	b891                	j	1ca8 <stbsp_vsprintfcb+0x904>
    2456:	8cea                	mv	s9,s10
    2458:	86cff06f          	j	14c4 <stbsp_vsprintfcb+0x120>
    245c:	4f81                	li	t6,0
    245e:	4a01                	li	s4,0
    2460:	5586                	lw	a1,96(sp)
                  *--s = stbsp__comma;
    2462:	00004f17          	auipc	t5,0x4
    2466:	6ebf4f03          	lbu	t5,1771(t5) # 6b4d <stbsp__comma>
    246a:	0510                	addi	a2,sp,640
    246c:	0085d71b          	srliw	a4,a1,0x8
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    2470:	4305                	li	t1,1
            if (fl & STBSP__TRIPLET_COMMA) {
    2472:	040e7e93          	andi	t4,t3,64
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    2476:	0007029b          	sext.w	t0,a4
    247a:	005317bb          	sllw	a5,t1,t0
    247e:	37fd                	addiw	a5,a5,-1
    2480:	8ff5                	and	a5,a5,a3
    2482:	97c2                	add	a5,a5,a6
    2484:	0007c783          	lbu	a5,0(a5)
            n64 >>= (l >> 8);
    2488:	0056d6b3          	srl	a3,a3,t0
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    248c:	fff60a93          	addi	s5,a2,-1
    2490:	fef60fa3          	sb	a5,-1(a2)
            if (!((n64) || ((stbsp__int32)((num + STBSP__NUMSZ) - s) < pr)))
    2494:	e691                	bnez	a3,24a0 <stbsp_vsprintfcb+0x10fc>
    2496:	051c                	addi	a5,sp,640
    2498:	415787bb          	subw	a5,a5,s5
    249c:	0317dd63          	bge	a5,a7,24d6 <stbsp_vsprintfcb+0x1132>
            if (fl & STBSP__TRIPLET_COMMA) {
    24a0:	020e8963          	beqz	t4,24d2 <stbsp_vsprintfcb+0x112e>
               ++l;
    24a4:	0015879b          	addiw	a5,a1,1
               if ((l & 15) == ((l >> 4) & 15)) {
    24a8:	0047d29b          	srliw	t0,a5,0x4
    24ac:	00f2c2b3          	xor	t0,t0,a5
    24b0:	00f2f293          	andi	t0,t0,15
               ++l;
    24b4:	0007859b          	sext.w	a1,a5
               if ((l & 15) == ((l >> 4) & 15)) {
    24b8:	0087d71b          	srliw	a4,a5,0x8
    24bc:	00029b63          	bnez	t0,24d2 <stbsp_vsprintfcb+0x112e>
                  l &= ~15;
    24c0:	9bc1                	andi	a5,a5,-16
    24c2:	0007859b          	sext.w	a1,a5
                  *--s = stbsp__comma;
    24c6:	ffe60a93          	addi	s5,a2,-2
    24ca:	ffe60f23          	sb	t5,-2(a2)
    24ce:	0087d71b          	srliw	a4,a5,0x8
    24d2:	8656                	mv	a2,s5
    24d4:	b74d                	j	2476 <stbsp_vsprintfcb+0x10d2>
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    24d6:	0045d29b          	srliw	t0,a1,0x4
    24da:	0f0006b7          	lui	a3,0xf000
         if (pr < (stbsp__int32)l)
    24de:	0007871b          	sext.w	a4,a5
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    24e2:	0182929b          	slliw	t0,t0,0x18
    24e6:	00d2f2b3          	and	t0,t0,a3
         n = pr + lead[0] + tail[0] + tz;
    24ea:	00ef863b          	addw	a2,t6,a4
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    24ee:	d0be                	sw	a5,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    24f0:	8fb2                	mv	t6,a2
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    24f2:	86be                	mv	a3,a5
    24f4:	00f282bb          	addw	t0,t0,a5
         if (fw < (stbsp__int32)n)
    24f8:	835a                	mv	t1,s6
    24fa:	00cb5363          	bge	s6,a2,2500 <stbsp_vsprintfcb+0x115c>
    24fe:	8332                	mv	t1,a2
         fw -= n;
    2500:	41f3033b          	subw	t1,t1,t6
         pr -= l;
    2504:	9f1d                	subw	a4,a4,a5
         goto scopy;
    2506:	4f81                	li	t6,0
      tz = 0;
    2508:	4881                	li	a7,0
         goto scopy;
    250a:	fdcff06f          	j	1ce6 <stbsp_vsprintfcb+0x942>
    250e:	8cda                	mv	s9,s6
    2510:	2c013a03          	ld	s4,704(sp)
    2514:	2b813a83          	ld	s5,696(sp)
    2518:	2b013b03          	ld	s6,688(sp)
    251c:	fa9fe06f          	j	14c4 <stbsp_vsprintfcb+0x120>
            fl |= ((sizeof(void *) == 8) ? STBSP__INTMAX : 0);
    2520:	020e6e13          	ori	t3,t3,32
            ++f;
    2524:	0485                	addi	s1,s1,1
    2526:	864ff06f          	j	158a <stbsp_vsprintfcb+0x1e6>
               n = 0;
    252a:	4601                	li	a2,0
         s = num + 64;
    252c:	8756                	mv	a4,s5
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    252e:	4511                	li	a0,4
                     *s++ = stbsp__comma;
    2530:	00170793          	addi	a5,a4,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2534:	00030563          	beqz	t1,253e <stbsp_vsprintfcb+0x119a>
    2538:	2585                	addiw	a1,a1,1
    253a:	10a58363          	beq	a1,a0,2640 <stbsp_vsprintfcb+0x129c>
    253e:	873e                	mv	a4,a5
                     *s++ = sn[n];
    2540:	02061793          	slli	a5,a2,0x20
    2544:	9381                	srli	a5,a5,0x20
    2546:	97fa                	add	a5,a5,t5
    2548:	0007c803          	lbu	a6,0(a5)
                     ++n;
    254c:	2605                	addiw	a2,a2,1
                     *s++ = sn[n];
    254e:	ff070fa3          	sb	a6,-1(a4)
                     if (n >= l)
    2552:	fcd66fe3          	bltu	a2,a3,2530 <stbsp_vsprintfcb+0x118c>
               if (n < (stbsp__uint32)dp) {
    2556:	0bd663e3          	bltu	a2,t4,2dfc <stbsp_vsprintfcb+0x1a58>
               cs = (int)(s - (num + 64)) + (3 << 24); // cs is how many tens
    255a:	415707b3          	sub	a5,a4,s5
    255e:	030002b7          	lui	t0,0x3000
    2562:	00f282bb          	addw	t0,t0,a5
               if (pr) {
    2566:	00088a63          	beqz	a7,257a <stbsp_vsprintfcb+0x11d6>
                  *s++ = stbsp__period;
    256a:	0cca4683          	lbu	a3,204(s4)
    256e:	00170793          	addi	a5,a4,1
         l = (stbsp__uint32)(s - (num + 64));
    2572:	415787b3          	sub	a5,a5,s5
                  *s++ = stbsp__period;
    2576:	00d70023          	sb	a3,0(a4)
         if (fl & STBSP__METRIC_SUFFIX) {
    257a:	100e7713          	andi	a4,t3,256
    257e:	86f2                	mv	a3,t3
    2580:	2c070163          	beqz	a4,2842 <stbsp_vsprintfcb+0x149e>
            if (fl & STBSP__METRIC_NOSPACE)
    2584:	40ae5f9b          	sraiw	t6,t3,0xa
    2588:	001fcf93          	xori	t6,t6,1
    258c:	001fff93          	andi	t6,t6,1
            tail[1] = ' ';
    2590:	02000713          	li	a4,32
    2594:	06e108a3          	sb	a4,113(sp)
            tail[0] = idx;
    2598:	07f10823          	sb	t6,112(sp)
               if (fl >> 24) { // SI kilo is 'k', JEDEC and SI kibits are 'K'.
    259c:	018e561b          	srliw	a2,t3,0x18
    25a0:	018e571b          	srliw	a4,t3,0x18
         n = pr + lead[0] + tail[0] + tz;
    25a4:	000f859b          	sext.w	a1,t6
               if (fl >> 24) { // SI kilo is 'k', JEDEC and SI kibits are 'K'.
    25a8:	c225                	beqz	a2,2608 <stbsp_vsprintfcb+0x1264>
                  if (fl & STBSP__METRIC_1024)
    25aa:	001f859b          	addiw	a1,t6,1
    25ae:	0ff5f613          	zext.b	a2,a1
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    25b2:	1702                	slli	a4,a4,0x20
                  if (fl & STBSP__METRIC_1024)
    25b4:	03469513          	slli	a0,a3,0x34
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    25b8:	85b2                	mv	a1,a2
    25ba:	9301                	srli	a4,a4,0x20
                  if (fl & STBSP__METRIC_1024)
    25bc:	06055ee3          	bgez	a0,2e38 <stbsp_vsprintfcb+0x1a94>
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    25c0:	00003517          	auipc	a0,0x3
    25c4:	ba050513          	addi	a0,a0,-1120 # 5160 <_GLOBAL__sub_I__ZSt3cin+0x9a>
    25c8:	972a                	add	a4,a4,a0
    25ca:	00074503          	lbu	a0,0(a4)
                  if (fl & STBSP__METRIC_1024 && !(fl & STBSP__METRIC_JEDEC)) {
    25ce:	6709                	lui	a4,0x2
    25d0:	80070713          	addi	a4,a4,-2048 # 1800 <stbsp_vsprintfcb+0x45c>
    25d4:	8f75                	and	a4,a4,a3
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    25d6:	06010813          	addi	a6,sp,96
    25da:	22060693          	addi	a3,a2,544
    25de:	96c2                	add	a3,a3,a6
    25e0:	dea68823          	sb	a0,-528(a3) # efffdf0 <_ZSt4cerr+0xeff8478>
                  if (fl & STBSP__METRIC_1024 && !(fl & STBSP__METRIC_JEDEC)) {
    25e4:	8007071b          	addiw	a4,a4,-2048
    25e8:	060715e3          	bnez	a4,2e52 <stbsp_vsprintfcb+0x1aae>
                     tail[idx + 1] = 'i';
    25ec:	2f89                	addiw	t6,t6,2
    25ee:	0ffff593          	zext.b	a1,t6
    25f2:	1094                	addi	a3,sp,96
    25f4:	22058713          	addi	a4,a1,544
    25f8:	9736                	add	a4,a4,a3
    25fa:	06900693          	li	a3,105
    25fe:	8fae                	mv	t6,a1
    2600:	ded70823          	sb	a3,-528(a4)
                  tail[0] = idx;
    2604:	07f10823          	sb	t6,112(sp)
         l = (stbsp__uint32)(s - (num + 64));
    2608:	0007869b          	sext.w	a3,a5
         n = pr + lead[0] + tail[0] + tz;
    260c:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    2610:	fff6c713          	not	a4,a3
    2614:	977d                	srai	a4,a4,0x3f
    2616:	8ff9                	and	a5,a5,a4
         n = pr + lead[0] + tail[0] + tz;
    2618:	00fa073b          	addw	a4,s4,a5
    261c:	9f2d                	addw	a4,a4,a1
    261e:	0117063b          	addw	a2,a4,a7
         l = (stbsp__uint32)(s - (num + 64));
    2622:	d0b6                	sw	a3,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    2624:	8732                	mv	a4,a2
         if (pr < (stbsp__int32)l)
    2626:	2781                	sext.w	a5,a5
         if ((fl & STBSP__LEFTJUST) == 0) {
    2628:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    262c:	835a                	mv	t1,s6
    262e:	00cb5363          	bge	s6,a2,2634 <stbsp_vsprintfcb+0x1290>
    2632:	8332                	mv	t1,a2
         fw -= n;
    2634:	40e3033b          	subw	t1,t1,a4
         pr -= l;
    2638:	40d7873b          	subw	a4,a5,a3
         goto scopy;
    263c:	eaaff06f          	j	1ce6 <stbsp_vsprintfcb+0x942>
                     *s++ = stbsp__comma;
    2640:	fe578fa3          	sb	t0,-1(a5)
    2644:	0709                	addi	a4,a4,2
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2646:	4585                	li	a1,1
    2648:	bde5                	j	2540 <stbsp_vsprintfcb+0x119c>
            lead[0] = 1;
    264a:	678d                	lui	a5,0x3
    264c:	0785                	addi	a5,a5,1 # 3001 <stbsp_vsnprintf+0x19>
    264e:	06f11423          	sh	a5,104(sp)
    2652:	b4ed                	j	213c <stbsp_vsprintfcb+0xd98>
            if ((f[0] != 'u') && (i64 < 0)) {
    2654:	07500693          	li	a3,117
            stbsp__int64 i64 = va_arg(va, stbsp__int64);
    2658:	000bbf03          	ld	t5,0(s7)
            if ((f[0] != 'u') && (i64 < 0)) {
    265c:	dcd78263          	beq	a5,a3,1c20 <stbsp_vsprintfcb+0x87c>
    2660:	dc0f5063          	bgez	t5,1c20 <stbsp_vsprintfcb+0x87c>
               fl |= STBSP__NEGATIVE;
    2664:	08076713          	ori	a4,a4,128
               n64 = (stbsp__uint64)-i64;
    2668:	41e00f33          	neg	t5,t5
               fl |= STBSP__NEGATIVE;
    266c:	00070e1b          	sext.w	t3,a4
    2670:	db0ff06f          	j	1c20 <stbsp_vsprintfcb+0x87c>
            lead[2] = h[0xb];
    2674:	00b84703          	lbu	a4,11(a6)
            lead[0] = 2;
    2678:	678d                	lui	a5,0x3
    267a:	0789                	addi	a5,a5,2 # 3002 <stbsp_vsnprintf+0x1a>
    267c:	06f11423          	sh	a5,104(sp)
            lead[2] = h[0xb];
    2680:	06e10523          	sb	a4,106(sp)
    2684:	bab5                	j	2000 <stbsp_vsprintfcb+0xc5c>
      sign[0] = 1;
    2686:	678d                	lui	a5,0x3
    2688:	d0178793          	addi	a5,a5,-767 # 2d01 <stbsp_vsprintfcb+0x195d>
            fl |= STBSP__NEGATIVE;
    268c:	080e6e13          	ori	t3,t3,128
      sign[0] = 1;
    2690:	06f11423          	sh	a5,104(sp)
    2694:	468d                	li	a3,3
    2696:	4a0d                	li	s4,3
    2698:	4809                	li	a6,2
    269a:	b899                	j	1ef0 <stbsp_vsprintfcb+0xb4c>
      sign[0] = 1;
    269c:	6709                	lui	a4,0x2
    269e:	0705                	addi	a4,a4,1 # 2001 <stbsp_vsprintfcb+0xc5d>
    26a0:	06e11423          	sh	a4,104(sp)
    26a4:	bae5                	j	209c <stbsp_vsprintfcb+0xcf8>
      if (((stbsp__uintptr)sn & 3) == 0)
    26a6:	0e0780e3          	beqz	a5,2f86 <stbsp_vsprintfcb+0x1be2>
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    26aa:	56fd                	li	a3,-1
    26ac:	bcf9                	j	218a <stbsp_vsprintfcb+0xde6>
         if (fw < (stbsp__int32)n)
    26ae:	4305                	li	t1,1
    26b0:	b249                	j	2032 <stbsp_vsprintfcb+0xc8e>
            pr = 6; // default is 6
    26b2:	4899                	li	a7,6
    26b4:	b801                	j	1ec4 <stbsp_vsprintfcb+0xb20>
         h = (f[0] == 'A') ? hexu : hex;
    26b6:	00004597          	auipc	a1,0x4
    26ba:	49a58593          	addi	a1,a1,1178 # 6b50 <hexu.1>
    26be:	ff6ff06f          	j	1eb4 <stbsp_vsprintfcb+0xb10>
         h = (f[0] == 'B') ? hexu : hex;
    26c2:	00004817          	auipc	a6,0x4
    26c6:	48e80813          	addi	a6,a6,1166 # 6b50 <hexu.1>
    26ca:	b22d                	j	1ff4 <stbsp_vsprintfcb+0xc50>
    26cc:	80000737          	lui	a4,0x80000
    26d0:	0719                	addi	a4,a4,6 # ffffffff80000006 <_ZSt4cerr+0xffffffff7fff868e>
            pr = 6; // default is 6
    26d2:	4899                	li	a7,6
    26d4:	e4eff06f          	j	1d22 <stbsp_vsprintfcb+0x97e>
         h = (f[0] == 'E') ? hexu : hex;
    26d8:	00004317          	auipc	t1,0x4
    26dc:	47830313          	addi	t1,t1,1144 # 6b50 <hexu.1>
    26e0:	e28ff06f          	j	1d08 <stbsp_vsprintfcb+0x964>
    26e4:	80000737          	lui	a4,0x80000
    26e8:	4a99                	li	s5,6
    26ea:	0715                	addi	a4,a4,5 # ffffffff80000005 <_ZSt4cerr+0xffffffff7fff868d>
            pr = 6;
    26ec:	4a19                	li	s4,6
    26ee:	ee8ff06f          	j	1dd6 <stbsp_vsprintfcb+0xa32>
         h = (f[0] == 'G') ? hexu : hex;
    26f2:	00004317          	auipc	t1,0x4
    26f6:	45e30313          	addi	t1,t1,1118 # 6b50 <hexu.1>
    26fa:	eb6ff06f          	j	1db0 <stbsp_vsprintfcb+0xa0c>
    26fe:	7be6                	ld	s7,120(sp)
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    2700:	86c2                	mv	a3,a6
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2702:	8542                	mv	a0,a6
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    2704:	88d2                	mv	a7,s4
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2706:	8ade                	mv	s5,s7
            if (pr > (stbsp__int32)l)
    2708:	0005071b          	sext.w	a4,a0
    270c:	01175f63          	bge	a4,a7,272a <stbsp_vsprintfcb+0x1386>
               pr = l - 1;
    2710:	fff5089b          	addiw	a7,a0,-1
         tail[0] = 0;
    2714:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    2718:	70028c63          	beqz	t0,2e30 <stbsp_vsprintfcb+0x1a8c>
      sign[0] = 1;
    271c:	670d                	lui	a4,0x3
    271e:	d0170713          	addi	a4,a4,-767 # 2d01 <stbsp_vsprintfcb+0x195d>
    2722:	06e11423          	sh	a4,104(sp)
    2726:	e3aff06f          	j	1d60 <stbsp_vsprintfcb+0x9bc>
            else if (pr)
    272a:	fe0885e3          	beqz	a7,2714 <stbsp_vsprintfcb+0x1370>
               --pr; // when using %e, there is one digit before the decimal
    272e:	38fd                	addiw	a7,a7,-1
    2730:	b7d5                	j	2714 <stbsp_vsprintfcb+0x1370>
      switch (f[0]) {
    2732:	0034c783          	lbu	a5,3(s1)
            f += 3;
    2736:	048d                	addi	s1,s1,3
    2738:	e53fe06f          	j	158a <stbsp_vsprintfcb+0x1e6>
      if (!limit || *sn == 0)
    273c:	4601                	li	a2,0
    273e:	4701                	li	a4,0
    2740:	4781                	li	a5,0
         return (stbsp__uint32)(sn - s);
    2742:	bca5                	j	21ba <stbsp_vsprintfcb+0xe16>
               pr = 1;
    2744:	4885                	li	a7,1
    2746:	cf4ff06f          	j	1c3a <stbsp_vsprintfcb+0x896>
         *s++ = sn[0];
    274a:	000ac703          	lbu	a4,0(s5)
    274e:	0ce10023          	sb	a4,192(sp)
         if (pr)
    2752:	54088563          	beqz	a7,2c9c <stbsp_vsprintfcb+0x18f8>
            *s++ = stbsp__period;
    2756:	00004617          	auipc	a2,0x4
    275a:	3f664603          	lbu	a2,1014(a2) # 6b4c <stbsp__period>
         if ((l - 1) > (stbsp__uint32)pr)
    275e:	fff6871b          	addiw	a4,a3,-1
            *s++ = stbsp__period;
    2762:	0cc100a3          	sb	a2,193(sp)
         if ((l - 1) > (stbsp__uint32)pr)
    2766:	0008851b          	sext.w	a0,a7
    276a:	0007061b          	sext.w	a2,a4
    276e:	52c57163          	bgeu	a0,a2,2c90 <stbsp_vsprintfcb+0x18ec>
            l = pr + 1;
    2772:	0018869b          	addiw	a3,a7,1
         for (n = 1; n < l; n++)
    2776:	8746                	mv	a4,a7
    2778:	02071613          	slli	a2,a4,0x20
    277c:	9201                	srli	a2,a2,0x20
    277e:	0c210713          	addi	a4,sp,194
    2782:	0a85                	addi	s5,s5,1
    2784:	963a                	add	a2,a2,a4
            *s++ = sn[n];
    2786:	000ac583          	lbu	a1,0(s5)
    278a:	0705                	addi	a4,a4,1
         for (n = 1; n < l; n++)
    278c:	0a85                	addi	s5,s5,1
            *s++ = sn[n];
    278e:	feb70fa3          	sb	a1,-1(a4)
         for (n = 1; n < l; n++)
    2792:	fec71ae3          	bne	a4,a2,2786 <stbsp_vsprintfcb+0x13e2>
         tail[1] = h[0xe];
    2796:	00e34803          	lbu	a6,14(t1)
         dp -= 1;
    279a:	fff7871b          	addiw	a4,a5,-1
            tail[2] = '+';
    279e:	02b00593          	li	a1,43
         tail[1] = h[0xe];
    27a2:	070108a3          	sb	a6,113(sp)
         if (dp < 0) {
    27a6:	00075663          	bgez	a4,27b2 <stbsp_vsprintfcb+0x140e>
            dp = -dp;
    27aa:	4705                	li	a4,1
    27ac:	9f1d                	subw	a4,a4,a5
            tail[2] = '-';
    27ae:	02d00593          	li	a1,45
    27b2:	06b10923          	sb	a1,114(sp)
         n = (dp >= 100) ? 5 : 4;
    27b6:	06300793          	li	a5,99
    27ba:	4ee7d663          	bge	a5,a4,2ca6 <stbsp_vsprintfcb+0x1902>
    27be:	4595                	li	a1,5
    27c0:	4f95                	li	t6,5
    27c2:	4e95                	li	t4,5
            tail[n] = '0' + dp % 10;
    27c4:	47a9                	li	a5,10
            dp /= 10;
    27c6:	02f7433b          	divw	t1,a4,a5
            --n;
    27ca:	fffe8f1b          	addiw	t5,t4,-1
            tail[n] = '0' + dp % 10;
    27ce:	020f1293          	slli	t0,t5,0x20
    27d2:	220e8813          	addi	a6,t4,544
    27d6:	06010893          	addi	a7,sp,96
    27da:	0202d293          	srli	t0,t0,0x20
    27de:	01180eb3          	add	t4,a6,a7
    27e2:	22028813          	addi	a6,t0,544 # 3000220 <_ZSt4cerr+0x2ff88a8>
    27e6:	011802b3          	add	t0,a6,a7
         tail[0] = (char)n;
    27ea:	07f10823          	sb	t6,112(sp)
            if (n <= 3)
    27ee:	4a0d                	li	s4,3
            tail[n] = '0' + dp % 10;
    27f0:	02f7673b          	remw	a4,a4,a5
            dp /= 10;
    27f4:	0003081b          	sext.w	a6,t1
            tail[n] = '0' + dp % 10;
    27f8:	02f36abb          	remw	s5,t1,a5
    27fc:	0307071b          	addiw	a4,a4,48
    2800:	deee8823          	sb	a4,-528(t4)
    2804:	030a871b          	addiw	a4,s5,48
    2808:	dee28823          	sb	a4,-528(t0)
            if (n <= 3)
    280c:	014f0a63          	beq	t5,s4,2820 <stbsp_vsprintfcb+0x147c>
            dp /= 10;
    2810:	02f3483b          	divw	a6,t1,a5
            tail[n] = '0' + dp % 10;
    2814:	02f867bb          	remw	a5,a6,a5
    2818:	0307879b          	addiw	a5,a5,48
    281c:	06f109a3          	sb	a5,115(sp)
         tz = pr - (l - 1);
    2820:	2505                	addiw	a0,a0,1
         l = (stbsp__uint32)(s - (num + 64));
    2822:	0c010a93          	addi	s5,sp,192
         cs = 1 + (3 << 24); // how many tens
    2826:	030002b7          	lui	t0,0x3000
         tz = pr - (l - 1);
    282a:	40d508bb          	subw	a7,a0,a3
    282e:	d2c2                	sw	a6,100(sp)
         l = (stbsp__uint32)(s - (num + 64));
    2830:	415607b3          	sub	a5,a2,s5
         cs = 1 + (3 << 24); // how many tens
    2834:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff8689>
    2836:	bbc9                	j	2608 <stbsp_vsprintfcb+0x1264>
    2838:	fc2e                	sd	a1,56(sp)
    283a:	d0b2                	sw	a2,96(sp)
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    283c:	8536                	mv	a0,a3
    283e:	e2cff06f          	j	1e6a <stbsp_vsprintfcb+0xac6>
      flt_lead:
    2842:	4581                	li	a1,0
    2844:	4f81                	li	t6,0
    2846:	b3c9                	j	2608 <stbsp_vsprintfcb+0x1264>
         n = pr + lead[0] + tail[0] + tz;
    2848:	06814a03          	lbu	s4,104(sp)
    284c:	000a0f9b          	sext.w	t6,s4
    2850:	b901                	j	2460 <stbsp_vsprintfcb+0x10bc>
         if ((f[1] == '6') && (f[2] == '4')) {
    2852:	0024c683          	lbu	a3,2(s1)
    2856:	03400713          	li	a4,52
    285a:	00e68463          	beq	a3,a4,2862 <stbsp_vsprintfcb+0x14be>
    285e:	e2bfe06f          	j	1688 <stbsp_vsprintfcb+0x2e4>
      switch (f[0]) {
    2862:	0034c783          	lbu	a5,3(s1)
         fl |= ((sizeof(long) == 8) ? STBSP__INTMAX : 0);
    2866:	020e6e13          	ori	t3,t3,32
            f += 3;
    286a:	048d                	addi	s1,s1,3
    286c:	d1ffe06f          	j	158a <stbsp_vsprintfcb+0x1e6>
         if (pr < (stbsp__int32)l)
    2870:	0006879b          	sext.w	a5,a3
         n = pr + lead[0] + tail[0] + tz;
    2874:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    2878:	fff7c793          	not	a5,a5
    287c:	97fd                	srai	a5,a5,0x3f
    287e:	8ff5                	and	a5,a5,a3
         n = pr + lead[0] + tail[0] + tz;
    2880:	00fa063b          	addw	a2,s4,a5
            s = (char *)sn;
    2884:	7ae6                	ld	s5,120(sp)
         n = pr + lead[0] + tail[0] + tz;
    2886:	8732                	mv	a4,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    2888:	001e7513          	andi	a0,t3,1
         if (pr < (stbsp__int32)l)
    288c:	2781                	sext.w	a5,a5
         if (fw < (stbsp__int32)n)
    288e:	835a                	mv	t1,s6
    2890:	00cb5363          	bge	s6,a2,2896 <stbsp_vsprintfcb+0x14f2>
    2894:	8332                	mv	t1,a2
         fw -= n;
    2896:	40e3033b          	subw	t1,t1,a4
            goto scopy;
    289a:	4f81                	li	t6,0
         pr -= l;
    289c:	40d7873b          	subw	a4,a5,a3
            cs = 0;
    28a0:	4281                	li	t0,0
      tz = 0;
    28a2:	4881                	li	a7,0
            goto scopy;
    28a4:	c42ff06f          	j	1ce6 <stbsp_vsprintfcb+0x942>
               cs = (int)(s - (num + 64)) + (3 << 24); // cs is how many tens
    28a8:	415705b3          	sub	a1,a4,s5
    28ac:	030002b7          	lui	t0,0x3000
    28b0:	00b282bb          	addw	t0,t0,a1
               l = pr - n;
    28b4:	0008859b          	sext.w	a1,a7
               if (pr)
    28b8:	42088763          	beqz	a7,2ce6 <stbsp_vsprintfcb+0x1942>
                  *s++ = stbsp__period;
    28bc:	0cca4f83          	lbu	t6,204(s4)
               if ((l - dp) > (stbsp__uint32)pr)
    28c0:	41d6833b          	subw	t1,a3,t4
                  *s++ = stbsp__period;
    28c4:	00280713          	addi	a4,a6,2
    28c8:	01f800a3          	sb	t6,1(a6)
               if ((l - dp) > (stbsp__uint32)pr)
    28cc:	4065ed63          	bltu	a1,t1,2ce6 <stbsp_vsprintfcb+0x1942>
               while (n < l) {
    28d0:	5ed57863          	bgeu	a0,a3,2ec0 <stbsp_vsprintfcb+0x1b1c>
    28d4:	40c687bb          	subw	a5,a3,a2
    28d8:	37fd                	addiw	a5,a5,-1
    28da:	1782                	slli	a5,a5,0x20
    28dc:	9381                	srli	a5,a5,0x20
    28de:	1602                	slli	a2,a2,0x20
    28e0:	9201                	srli	a2,a2,0x20
    28e2:	0785                	addi	a5,a5,1
    28e4:	967a                	add	a2,a2,t5
    28e6:	97ba                	add	a5,a5,a4
                  *s++ = sn[n];
    28e8:	00064503          	lbu	a0,0(a2)
    28ec:	0705                	addi	a4,a4,1
               while (n < l) {
    28ee:	0605                	addi	a2,a2,1
                  *s++ = sn[n];
    28f0:	fea70fa3          	sb	a0,-1(a4)
               while (n < l) {
    28f4:	fef71ae3          	bne	a4,a5,28e8 <stbsp_vsprintfcb+0x1544>
               tz = pr - (l - dp);
    28f8:	01d585bb          	addw	a1,a1,t4
    28fc:	40d588bb          	subw	a7,a1,a3
         l = (stbsp__uint32)(s - (num + 64));
    2900:	415787b3          	sub	a5,a5,s5
    2904:	b99d                	j	257a <stbsp_vsprintfcb+0x11d6>
            fl |= STBSP__NEGATIVE;
    2906:	080e6e13          	ori	t3,t3,128
         tail[0] = 0;
    290a:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    290e:	b539                	j	271c <stbsp_vsprintfcb+0x1378>
         tail[0] = (char)n;
    2910:	4799                	li	a5,6
            tail[n] = '0' + dp % 10;
    2912:	06b10b23          	sb	a1,118(sp)
         tail[0] = (char)n;
    2916:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    291a:	4819                	li	a6,6
    291c:	4f99                	li	t6,6
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    291e:	4599                	li	a1,6
            dp /= 10;
    2920:	4f29                	li	t5,10
            if (n <= 3)
    2922:	428d                	li	t0,3
    2924:	87b2                	mv	a5,a2
            dp /= 10;
    2926:	03e7c7bb          	divw	a5,a5,t5
            --n;
    292a:	35fd                	addiw	a1,a1,-1
            tail[n] = '0' + dp % 10;
    292c:	02059613          	slli	a2,a1,0x20
    2930:	9201                	srli	a2,a2,0x20
    2932:	06010e93          	addi	t4,sp,96
    2936:	22060613          	addi	a2,a2,544
    293a:	9676                	add	a2,a2,t4
    293c:	03e7eebb          	remw	t4,a5,t5
    2940:	030e8e9b          	addiw	t4,t4,48
    2944:	dfd60823          	sb	t4,-528(a2)
            if (n <= 3)
    2948:	fc559fe3          	bne	a1,t0,2926 <stbsp_vsprintfcb+0x1582>
    294c:	e6aff06f          	j	1fb6 <stbsp_vsprintfcb+0xc12>
         *s++ = h[(n64 >> 60) & 15];
    2950:	93f1                	srli	a5,a5,0x3c
    2952:	97ae                	add	a5,a5,a1
    2954:	0007c303          	lbu	t1,0(a5)
         lead[1 + lead[0]] = '0';
    2958:	1088                	addi	a0,sp,96
    295a:	22080793          	addi	a5,a6,544
    295e:	97aa                	add	a5,a5,a0
    2960:	03000513          	li	a0,48
    2964:	dea78423          	sb	a0,-536(a5)
         lead[2 + lead[0]] = 'x';
    2968:	22068793          	addi	a5,a3,544
    296c:	1094                	addi	a3,sp,96
    296e:	96be                	add	a3,a3,a5
            *s++ = stbsp__period;
    2970:	00004517          	auipc	a0,0x4
    2974:	1dc54503          	lbu	a0,476(a0) # 6b4c <stbsp__period>
         lead[2 + lead[0]] = 'x';
    2978:	07800813          	li	a6,120
         sn = s;
    297c:	0c210793          	addi	a5,sp,194
         lead[2 + lead[0]] = 'x';
    2980:	df068423          	sb	a6,-536(a3)
            *s++ = stbsp__period;
    2984:	0ca100a3          	sb	a0,193(sp)
         lead[0] += 2;
    2988:	07410423          	sb	s4,104(sp)
         *s++ = h[(n64 >> 60) & 15];
    298c:	0c610023          	sb	t1,192(sp)
         n64 <<= 4;
    2990:	0732                	slli	a4,a4,0xc
         sn = s;
    2992:	fcbe                	sd	a5,120(sp)
         n = pr;
    2994:	0008869b          	sext.w	a3,a7
         while (n--) {
    2998:	4831                	li	a6,12
         if (n > 13)
    299a:	4535                	li	a0,13
            tz = pr - n;
    299c:	40a688bb          	subw	a7,a3,a0
         while (n--) {
    29a0:	02081313          	slli	t1,a6,0x20
    29a4:	02035313          	srli	t1,t1,0x20
    29a8:	22030693          	addi	a3,t1,544
    29ac:	1088                	addi	a0,sp,96
    29ae:	9536                	add	a0,a0,a3
    29b0:	e4350513          	addi	a0,a0,-445
            *s++ = h[(n64 >> 60) & 15];
    29b4:	03c75693          	srli	a3,a4,0x3c
    29b8:	96ae                	add	a3,a3,a1
    29ba:	0006c683          	lbu	a3,0(a3)
    29be:	0785                	addi	a5,a5,1
            n64 <<= 4;
    29c0:	0712                	slli	a4,a4,0x4
            *s++ = h[(n64 >> 60) & 15];
    29c2:	fed78fa3          	sb	a3,-1(a5)
         while (n--) {
    29c6:	fea797e3          	bne	a5,a0,29b4 <stbsp_vsprintfcb+0x1610>
         l = (int)(s - (num + 64));
    29ca:	280d                	addiw	a6,a6,3
    29cc:	0008069b          	sext.w	a3,a6
         if (pr < (stbsp__int32)l)
    29d0:	fff6c713          	not	a4,a3
    29d4:	977d                	srai	a4,a4,0x3f
    29d6:	00e87733          	and	a4,a6,a4
         dp = (int)(s - sn);
    29da:	0013051b          	addiw	a0,t1,1
         if (pr < (stbsp__int32)l)
    29de:	0007031b          	sext.w	t1,a4
         pr -= l;
    29e2:	4107073b          	subw	a4,a4,a6
    29e6:	d76ff06f          	j	1f5c <stbsp_vsprintfcb+0xbb8>
                  *--s = stbsp__comma;
    29ea:	00004a17          	auipc	s4,0x4
    29ee:	096a0a13          	addi	s4,s4,150 # 6a80 <stbsp__digitpair>
            if (n64 >= 100000000) {
    29f2:	05f5e7b7          	lui	a5,0x5f5e
    29f6:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f56787>
               n = (stbsp__uint32)(n64 % 100000000);
    29fa:	05f5e637          	lui	a2,0x5f5e
                  *--s = stbsp__comma;
    29fe:	0cda4b83          	lbu	s7,205(s4)
            if (n64 >= 100000000) {
    2a02:	e83e                	sd	a5,16(sp)
               n = (stbsp__uint32)(n64 % 100000000);
    2a04:	10060793          	addi	a5,a2,256 # 5f5e100 <_ZSt4cerr+0x5f56788>
         l = 0;
    2a08:	d082                	sw	zero,96(sp)
            if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    2a0a:	040e7813          	andi	a6,t3,64
    2a0e:	4701                	li	a4,0
    2a10:	4281                	li	t0,0
         s = num + STBSP__NUMSZ;
    2a12:	28010a93          	addi	s5,sp,640
               n = (stbsp__uint32)(n64 % 100000000);
    2a16:	ec3e                	sd	a5,24(sp)
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    2a18:	430d                	li	t1,3
                  n /= 10;
    2a1a:	45a9                	li	a1,10
            while (n) {
    2a1c:	4ea5                	li	t4,9
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    2a1e:	06400f93          	li	t6,100
            if (n64 >= 100000000) {
    2a22:	67c2                	ld	a5,16(sp)
            char *o = s - 8;
    2a24:	ff8a8513          	addi	a0,s5,-8
            if (n64 >= 100000000) {
    2a28:	0fe7f763          	bgeu	a5,t5,2b16 <stbsp_vsprintfcb+0x1772>
               n = (stbsp__uint32)(n64 % 100000000);
    2a2c:	6662                	ld	a2,24(sp)
    2a2e:	02cf77b3          	remu	a5,t5,a2
               n64 /= 100000000;
    2a32:	02cf5f33          	divu	t5,t5,a2
            if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    2a36:	0e080463          	beqz	a6,2b1e <stbsp_vsprintfcb+0x177a>
            while (n) {
    2a3a:	cb85                	beqz	a5,2a6a <stbsp_vsprintfcb+0x16c6>
                  *--s = stbsp__comma;
    2a3c:	1afd                	addi	s5,s5,-1
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    2a3e:	00671763          	bne	a4,t1,2a4c <stbsp_vsprintfcb+0x16a8>
                  --o;
    2a42:	017a8023          	sb	s7,0(s5)
    2a46:	157d                	addi	a0,a0,-1
                  *--s = stbsp__comma;
    2a48:	1afd                	addi	s5,s5,-1
                  l = 0;
    2a4a:	4701                	li	a4,0
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    2a4c:	2705                	addiw	a4,a4,1
                  *--s = (char)(n % 10) + '0';
    2a4e:	02b7f63b          	remuw	a2,a5,a1
    2a52:	0306061b          	addiw	a2,a2,48
    2a56:	00ca8023          	sb	a2,0(s5)
                  n /= 10;
    2a5a:	02b7d63b          	divuw	a2,a5,a1
            while (n) {
    2a5e:	00fef563          	bgeu	t4,a5,2a68 <stbsp_vsprintfcb+0x16c4>
                  *--s = stbsp__comma;
    2a62:	1afd                	addi	s5,s5,-1
    2a64:	87b2                	mv	a5,a2
    2a66:	bfe1                	j	2a3e <stbsp_vsprintfcb+0x169a>
            while (n) {
    2a68:	4285                	li	t0,1
            if (n64 == 0) {
    2a6a:	020f0063          	beqz	t5,2a8a <stbsp_vsprintfcb+0x16e6>
            while (s != o)
    2a6e:	fb550ae3          	beq	a0,s5,2a22 <stbsp_vsprintfcb+0x167e>
                  *--s = stbsp__comma;
    2a72:	1afd                	addi	s5,s5,-1
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    2a74:	00080663          	beqz	a6,2a80 <stbsp_vsprintfcb+0x16dc>
    2a78:	08670863          	beq	a4,t1,2b08 <stbsp_vsprintfcb+0x1764>
    2a7c:	2705                	addiw	a4,a4,1
    2a7e:	4285                	li	t0,1
                  *--s = '0';
    2a80:	03000793          	li	a5,48
    2a84:	00fa8023          	sb	a5,0(s5)
    2a88:	b7dd                	j	2a6e <stbsp_vsprintfcb+0x16ca>
    2a8a:	00028363          	beqz	t0,2a90 <stbsp_vsprintfcb+0x16ec>
    2a8e:	d0ba                	sw	a4,96(sp)
               if ((s[0] == '0') && (s != (num + STBSP__NUMSZ)))
    2a90:	000ac703          	lbu	a4,0(s5)
    2a94:	03000793          	li	a5,48
    2a98:	34f70b63          	beq	a4,a5,2dee <stbsp_vsprintfcb+0x1a4a>
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    2a9c:	051c                	addi	a5,sp,640
    2a9e:	415786bb          	subw	a3,a5,s5
         tail[0] = 0;
    2aa2:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    2aa6:	080e7713          	andi	a4,t3,128
    2aaa:	87f2                	mv	a5,t3
    2aac:	32070863          	beqz	a4,2ddc <stbsp_vsprintfcb+0x1a38>
    2ab0:	678d                	lui	a5,0x3
    2ab2:	d017879b          	addiw	a5,a5,-767 # 2d01 <stbsp_vsprintfcb+0x195d>
      sign[0] = 1;
    2ab6:	06f11423          	sh	a5,104(sp)
    2aba:	4705                	li	a4,1
    2abc:	4a05                	li	s4,1
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    2abe:	d0b6                	sw	a3,96(sp)
         if (l == 0) {
    2ac0:	30068163          	beqz	a3,2dc2 <stbsp_vsprintfcb+0x1a1e>
         cs = l + (3 << 24);
    2ac4:	030002b7          	lui	t0,0x3000
    2ac8:	00d282bb          	addw	t0,t0,a3
         if (pr < (stbsp__int32)l)
    2acc:	0006861b          	sext.w	a2,a3
         if (pr < 0)
    2ad0:	fff8c793          	not	a5,a7
    2ad4:	97fd                	srai	a5,a5,0x3f
         if (pr < (stbsp__int32)l)
    2ad6:	00f8f7b3          	and	a5,a7,a5
    2ada:	0007859b          	sext.w	a1,a5
    2ade:	00c5d363          	bge	a1,a2,2ae4 <stbsp_vsprintfcb+0x1740>
    2ae2:	87b2                	mv	a5,a2
         n = pr + lead[0] + tail[0] + tz;
    2ae4:	00f7063b          	addw	a2,a4,a5
    2ae8:	8732                	mv	a4,a2
         if (pr < (stbsp__int32)l)
    2aea:	2781                	sext.w	a5,a5
         if ((fl & STBSP__LEFTJUST) == 0) {
    2aec:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    2af0:	835a                	mv	t1,s6
    2af2:	00cb5363          	bge	s6,a2,2af8 <stbsp_vsprintfcb+0x1754>
    2af6:	8332                	mv	t1,a2
         fw -= n;
    2af8:	40e3033b          	subw	t1,t1,a4
      scopy:
    2afc:	4f81                	li	t6,0
         pr -= l;
    2afe:	40d7873b          	subw	a4,a5,a3
      tz = 0;
    2b02:	4881                	li	a7,0
      scopy:
    2b04:	9e2ff06f          	j	1ce6 <stbsp_vsprintfcb+0x942>
                  *--s = stbsp__comma;
    2b08:	87de                	mv	a5,s7
                  --o;
    2b0a:	157d                	addi	a0,a0,-1
                  l = 0;
    2b0c:	4701                	li	a4,0
                  --o;
    2b0e:	4285                	li	t0,1
    2b10:	00fa8023          	sb	a5,0(s5)
    2b14:	bfa9                	j	2a6e <stbsp_vsprintfcb+0x16ca>
               n = (stbsp__uint32)n64;
    2b16:	000f079b          	sext.w	a5,t5
               n64 = 0;
    2b1a:	4f01                	li	t5,0
    2b1c:	bf29                	j	2a36 <stbsp_vsprintfcb+0x1692>
    2b1e:	f046                	sd	a7,32(sp)
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    2b20:	03f7f63b          	remuw	a2,a5,t6
                  s -= 2;
    2b24:	1af9                	addi	s5,s5,-2
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    2b26:	0007889b          	sext.w	a7,a5
    2b2a:	2605                	addiw	a2,a2,1
    2b2c:	0016161b          	slliw	a2,a2,0x1
    2b30:	1602                	slli	a2,a2,0x20
    2b32:	9201                	srli	a2,a2,0x20
    2b34:	9652                	add	a2,a2,s4
    2b36:	00065603          	lhu	a2,0(a2)
                  n /= 100;
    2b3a:	03f7d7bb          	divuw	a5,a5,t6
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    2b3e:	00ca9023          	sh	a2,0(s5)
               } while (n);
    2b42:	06300613          	li	a2,99
    2b46:	fd166de3          	bltu	a2,a7,2b20 <stbsp_vsprintfcb+0x177c>
    2b4a:	7882                	ld	a7,32(sp)
            if (n64 == 0) {
    2b4c:	f20f11e3          	bnez	t5,2a6e <stbsp_vsprintfcb+0x16ca>
    2b50:	bf2d                	j	2a8a <stbsp_vsprintfcb+0x16e6>
                     *(stbsp__uint32 *)bf = 0x20202020;
    2b52:	20202b37          	lui	s6,0x20202
                  stbsp__cb_buf_clamp(i, fw);
    2b56:	854a                	mv	a0,s2
                     *bf++ = ' ';
    2b58:	02000a93          	li	s5,32
                     *(stbsp__uint32 *)bf = 0x20202020;
    2b5c:	020b0b13          	addi	s6,s6,32 # 20202020 <_ZSt4cerr+0x201fa6a8>
                  stbsp__chk_cb_buf(1);
    2b60:	1fe00a13          	li	s4,510
                  stbsp__cb_buf_clamp(i, fw);
    2b64:	20000b93          	li	s7,512
    2b68:	891a                	mv	s2,t1
    2b6a:	0a098063          	beqz	s3,2c0a <stbsp_vsprintfcb+0x1866>
    2b6e:	40a40633          	sub	a2,s0,a0
    2b72:	40cb87bb          	subw	a5,s7,a2
    2b76:	873e                	mv	a4,a5
    2b78:	00f95363          	bge	s2,a5,2b7e <stbsp_vsprintfcb+0x17da>
    2b7c:	874a                	mv	a4,s2
    2b7e:	0007079b          	sext.w	a5,a4
                  fw -= i;
    2b82:	40e9093b          	subw	s2,s2,a4
                  while (i) {
    2b86:	e799                	bnez	a5,2b94 <stbsp_vsprintfcb+0x17f0>
    2b88:	a281                	j	2cc8 <stbsp_vsprintfcb+0x1924>
                     *bf++ = ' ';
    2b8a:	01540023          	sb	s5,0(s0)
                     --i;
    2b8e:	37fd                	addiw	a5,a5,-1
                     *bf++ = ' ';
    2b90:	0405                	addi	s0,s0,1
                  while (i) {
    2b92:	cba1                	beqz	a5,2be2 <stbsp_vsprintfcb+0x183e>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    2b94:	00347713          	andi	a4,s0,3
    2b98:	fb6d                	bnez	a4,2b8a <stbsp_vsprintfcb+0x17e6>
                  while (i >= 4) {
    2b9a:	470d                	li	a4,3
    2b9c:	40f75363          	bge	a4,a5,2fa2 <stbsp_vsprintfcb+0x1bfe>
    2ba0:	ffc7869b          	addiw	a3,a5,-4
    2ba4:	0026d79b          	srliw	a5,a3,0x2
    2ba8:	0017871b          	addiw	a4,a5,1
    2bac:	070a                	slli	a4,a4,0x2
    2bae:	9722                	add	a4,a4,s0
                     *(stbsp__uint32 *)bf = 0x20202020;
    2bb0:	01642023          	sw	s6,0(s0)
                     bf += 4;
    2bb4:	0411                	addi	s0,s0,4
                  while (i >= 4) {
    2bb6:	fee41de3          	bne	s0,a4,2bb0 <stbsp_vsprintfcb+0x180c>
    2bba:	0027979b          	slliw	a5,a5,0x2
    2bbe:	40f687bb          	subw	a5,a3,a5
                  while (i--)
    2bc2:	fff7869b          	addiw	a3,a5,-1
    2bc6:	cf91                	beqz	a5,2be2 <stbsp_vsprintfcb+0x183e>
    2bc8:	9fa1                	addw	a5,a5,s0
                     *bf++ = ' ';
    2bca:	0705                	addi	a4,a4,1
                  while (i--)
    2bcc:	0007061b          	sext.w	a2,a4
                     *bf++ = ' ';
    2bd0:	ff570fa3          	sb	s5,-1(a4)
                  while (i--)
    2bd4:	fec79be3          	bne	a5,a2,2bca <stbsp_vsprintfcb+0x1826>
    2bd8:	2685                	addiw	a3,a3,1
    2bda:	02069793          	slli	a5,a3,0x20
    2bde:	9381                	srli	a5,a5,0x20
    2be0:	943e                	add	s0,s0,a5
                  stbsp__chk_cb_buf(1);
    2be2:	00098f63          	beqz	s3,2c00 <stbsp_vsprintfcb+0x185c>
    2be6:	40a4063b          	subw	a2,s0,a0
    2bea:	00ca5b63          	bge	s4,a2,2c00 <stbsp_vsprintfcb+0x185c>
    2bee:	65a2                	ld	a1,8(sp)
    2bf0:	e81e                	sd	t2,16(sp)
    2bf2:	00cd0d3b          	addw	s10,s10,a2
    2bf6:	9982                	jalr	s3
    2bf8:	80050be3          	beqz	a0,240e <stbsp_vsprintfcb+0x106a>
    2bfc:	63c2                	ld	t2,16(sp)
    2bfe:	842a                	mv	s0,a0
               while (fw) {
    2c00:	f60915e3          	bnez	s2,2b6a <stbsp_vsprintfcb+0x17c6>
    2c04:	892a                	mv	s2,a0
    2c06:	f21fe06f          	j	1b26 <stbsp_vsprintfcb+0x782>
                  stbsp__cb_buf_clamp(i, fw);
    2c0a:	87ca                	mv	a5,s2
                  fw -= i;
    2c0c:	4901                	li	s2,0
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    2c0e:	b759                	j	2b94 <stbsp_vsprintfcb+0x17f0>
   } else if (fl & STBSP__LEADINGPLUS) {
    2c10:	002e7713          	andi	a4,t3,2
    2c14:	94070663          	beqz	a4,1d60 <stbsp_vsprintfcb+0x9bc>
      sign[0] = 1;
    2c18:	670d                	lui	a4,0x3
    2c1a:	b0170713          	addi	a4,a4,-1279 # 2b01 <stbsp_vsprintfcb+0x175d>
    2c1e:	06e11423          	sh	a4,104(sp)
    2c22:	93eff06f          	j	1d60 <stbsp_vsprintfcb+0x9bc>
      if (((stbsp__uintptr)sn & 3) == 0)
    2c26:	87d6                	mv	a5,s5
   while (limit >= 4) {
    2c28:	470d                	li	a4,3
    2c2a:	22d77763          	bgeu	a4,a3,2e58 <stbsp_vsprintfcb+0x1ab4>
      if ((v - 0x01010101) & (~v) & 0x80808080UL)
    2c2e:	feff05b7          	lui	a1,0xfeff0
    2c32:	80808637          	lui	a2,0x80808
    2c36:	eff5859b          	addiw	a1,a1,-257 # fffffffffefefeff <_ZSt4cerr+0xfffffffffefe8587>
    2c3a:	08060613          	addi	a2,a2,128 # ffffffff80808080 <_ZSt4cerr+0xffffffff80800708>
   while (limit >= 4) {
    2c3e:	480d                	li	a6,3
    2c40:	a029                	j	2c4a <stbsp_vsprintfcb+0x18a6>
      limit -= 4;
    2c42:	36f1                	addiw	a3,a3,-4
      sn += 4;
    2c44:	0791                	addi	a5,a5,4
   while (limit >= 4) {
    2c46:	20d87963          	bgeu	a6,a3,2e58 <stbsp_vsprintfcb+0x1ab4>
      stbsp__uint32 v = *(stbsp__uint32 *)sn;
    2c4a:	4398                	lw	a4,0(a5)
      if ((v - 0x01010101) & (~v) & 0x80808080UL)
    2c4c:	00b7053b          	addw	a0,a4,a1
    2c50:	fff74713          	not	a4,a4
    2c54:	8f69                	and	a4,a4,a0
    2c56:	8f71                	and	a4,a4,a2
    2c58:	2701                	sext.w	a4,a4
    2c5a:	d765                	beqz	a4,2c42 <stbsp_vsprintfcb+0x189e>
    2c5c:	02069713          	slli	a4,a3,0x20
    2c60:	9301                	srli	a4,a4,0x20
    2c62:	973e                	add	a4,a4,a5
    2c64:	a021                	j	2c6c <stbsp_vsprintfcb+0x18c8>
      ++sn;
    2c66:	0785                	addi	a5,a5,1
   while (limit && *sn) {
    2c68:	00e78663          	beq	a5,a4,2c74 <stbsp_vsprintfcb+0x18d0>
    2c6c:	0007c683          	lbu	a3,0(a5)
    2c70:	fafd                	bnez	a3,2c66 <stbsp_vsprintfcb+0x18c2>
    2c72:	873e                	mv	a4,a5
   return (stbsp__uint32)(sn - s);
    2c74:	41570733          	sub	a4,a4,s5
    2c78:	0007069b          	sext.w	a3,a4
         if (pr < (stbsp__int32)l)
    2c7c:	fff6c793          	not	a5,a3
    2c80:	97fd                	srai	a5,a5,0x3f
    2c82:	8f7d                	and	a4,a4,a5
    2c84:	0007079b          	sext.w	a5,a4
         n = pr + lead[0] + tail[0] + tz;
    2c88:	863e                	mv	a2,a5
         pr -= l;
    2c8a:	9f15                	subw	a4,a4,a3
   return (stbsp__uint32)(sn - s);
    2c8c:	d2eff06f          	j	21ba <stbsp_vsprintfcb+0xe16>
         for (n = 1; n < l; n++)
    2c90:	4605                	li	a2,1
    2c92:	aed663e3          	bltu	a2,a3,2778 <stbsp_vsprintfcb+0x13d4>
    2c96:	0c210613          	addi	a2,sp,194
    2c9a:	bcf5                	j	2796 <stbsp_vsprintfcb+0x13f2>
            l = pr + 1;
    2c9c:	4685                	li	a3,1
         if ((l - 1) > (stbsp__uint32)pr)
    2c9e:	4501                	li	a0,0
         *s++ = sn[0];
    2ca0:	0c110613          	addi	a2,sp,193
    2ca4:	bccd                	j	2796 <stbsp_vsprintfcb+0x13f2>
    2ca6:	4591                	li	a1,4
    2ca8:	4f91                	li	t6,4
         n = (dp >= 100) ? 5 : 4;
    2caa:	4e91                	li	t4,4
    2cac:	be21                	j	27c4 <stbsp_vsprintfcb+0x1420>
    2cae:	4a85                	li	s5,1
    2cb0:	80000737          	lui	a4,0x80000
            pr = 1; // default is 6
    2cb4:	4a05                	li	s4,1
    2cb6:	920ff06f          	j	1dd6 <stbsp_vsprintfcb+0xa32>
            dp = (n64) ? -1022 : 0;
    2cba:	4601                	li	a2,0
    2cbc:	c119                	beqz	a0,2cc2 <stbsp_vsprintfcb+0x191e>
    2cbe:	c0200613          	li	a2,-1022
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    2cc2:	872a                	mv	a4,a0
    2cc4:	a3aff06f          	j	1efe <stbsp_vsprintfcb+0xb5a>
                  stbsp__chk_cb_buf(1);
    2cc8:	2601                	sext.w	a2,a2
    2cca:	1fe00793          	li	a5,510
    2cce:	f2c7c0e3          	blt	a5,a2,2bee <stbsp_vsprintfcb+0x184a>
    2cd2:	bd61                	j	2b6a <stbsp_vsprintfcb+0x17c6>
         tail[0] = (char)n;
    2cd4:	4795                	li	a5,5
            tail[n] = '0' + dp % 10;
    2cd6:	06b10aa3          	sb	a1,117(sp)
         tail[0] = (char)n;
    2cda:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    2cde:	4815                	li	a6,5
    2ce0:	4f95                	li	t6,5
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    2ce2:	4595                	li	a1,5
    2ce4:	b935                	j	2920 <stbsp_vsprintfcb+0x157c>
                  l = pr + dp;
    2ce6:	011786bb          	addw	a3,a5,a7
    2cea:	d0b6                	sw	a3,96(sp)
    2cec:	b6d5                	j	28d0 <stbsp_vsprintfcb+0x152c>
            s = (char *)"null";
    2cee:	00002a97          	auipc	s5,0x2
    2cf2:	46aa8a93          	addi	s5,s5,1130 # 5158 <_GLOBAL__sub_I__ZSt3cin+0x92>
    2cf6:	c80ff06f          	j	2176 <stbsp_vsprintfcb+0xdd2>
   } else if (fl & STBSP__LEADINGPLUS) {
    2cfa:	002e7793          	andi	a5,t3,2
    2cfe:	1c079c63          	bnez	a5,2ed6 <stbsp_vsprintfcb+0x1b32>
   sign[0] = 0;
    2d02:	4689                	li	a3,2
    2d04:	4a09                	li	s4,2
    2d06:	4805                	li	a6,1
    2d08:	9e8ff06f          	j	1ef0 <stbsp_vsprintfcb+0xb4c>
      sign[0] = 1;
    2d0c:	670d                	lui	a4,0x3
    2d0e:	b0170713          	addi	a4,a4,-1279 # 2b01 <stbsp_vsprintfcb+0x175d>
    2d12:	06e11423          	sh	a4,104(sp)
    2d16:	b86ff06f          	j	209c <stbsp_vsprintfcb+0xcf8>
               pr = 0;
    2d1a:	4881                	li	a7,0
    2d1c:	f1ffe06f          	j	1c3a <stbsp_vsprintfcb+0x896>
            *s++ = '0';
    2d20:	03000713          	li	a4,48
    2d24:	0ce10023          	sb	a4,192(sp)
            if (pr)
    2d28:	1a088c63          	beqz	a7,2ee0 <stbsp_vsprintfcb+0x1b3c>
               *s++ = stbsp__period;
    2d2c:	00004717          	auipc	a4,0x4
    2d30:	e2074703          	lbu	a4,-480(a4) # 6b4c <stbsp__period>
            n = -dp;
    2d34:	40f007bb          	negw	a5,a5
               *s++ = stbsp__period;
    2d38:	0ce100a3          	sb	a4,193(sp)
            if ((stbsp__int32)n > pr)
    2d3c:	0007871b          	sext.w	a4,a5
    2d40:	00e8d363          	bge	a7,a4,2d46 <stbsp_vsprintfcb+0x19a2>
    2d44:	87c6                	mv	a5,a7
    2d46:	0007871b          	sext.w	a4,a5
            if ((stbsp__int32)(l + n) > pr)
    2d4a:	00d7833b          	addw	t1,a5,a3
    2d4e:	883a                	mv	a6,a4
            while (i) {
    2d50:	0c210793          	addi	a5,sp,194
               *s++ = '0';
    2d54:	03000513          	li	a0,48
            while (i) {
    2d58:	e711                	bnez	a4,2d64 <stbsp_vsprintfcb+0x19c0>
    2d5a:	a271                	j	2ee6 <stbsp_vsprintfcb+0x1b42>
               if ((((stbsp__uintptr)s) & 3) == 0)
    2d5c:	0037f613          	andi	a2,a5,3
    2d60:	18060563          	beqz	a2,2eea <stbsp_vsprintfcb+0x1b46>
               *s++ = '0';
    2d64:	85ba                	mv	a1,a4
    2d66:	00a78023          	sb	a0,0(a5)
               --i;
    2d6a:	377d                	addiw	a4,a4,-1
               *s++ = '0';
    2d6c:	0785                	addi	a5,a5,1
            while (i) {
    2d6e:	f77d                	bnez	a4,2d5c <stbsp_vsprintfcb+0x19b8>
            if ((stbsp__int32)(l + n) > pr)
    2d70:	0003071b          	sext.w	a4,t1
    2d74:	4108863b          	subw	a2,a7,a6
    2d78:	00e8d563          	bge	a7,a4,2d82 <stbsp_vsprintfcb+0x19de>
               l = pr - n;
    2d7c:	0006069b          	sext.w	a3,a2
    2d80:	d0b2                	sw	a2,96(sp)
            while (i) {
    2d82:	c68d                	beqz	a3,2dac <stbsp_vsprintfcb+0x1a08>
    2d84:	7566                	ld	a0,120(sp)
    2d86:	02069813          	slli	a6,a3,0x20
    2d8a:	02085813          	srli	a6,a6,0x20
    2d8e:	01078eb3          	add	t4,a5,a6
    2d92:	85aa                	mv	a1,a0
    2d94:	873e                	mv	a4,a5
               *s++ = *sn++;
    2d96:	0005c883          	lbu	a7,0(a1)
    2d9a:	0705                	addi	a4,a4,1
            while (i) {
    2d9c:	0585                	addi	a1,a1,1
               *s++ = *sn++;
    2d9e:	ff170fa3          	sb	a7,-1(a4)
            while (i) {
    2da2:	ffd71ae3          	bne	a4,t4,2d96 <stbsp_vsprintfcb+0x19f2>
    2da6:	9542                	add	a0,a0,a6
    2da8:	97c2                	add	a5,a5,a6
    2daa:	fcaa                	sd	a0,120(sp)
         l = (stbsp__uint32)(s - (num + 64));
    2dac:	0c010a93          	addi	s5,sp,192
            cs = 1 + (3 << 24); // how many tens did we write (for commas below)
    2db0:	030002b7          	lui	t0,0x3000
            tz = pr - (n + l);
    2db4:	40d608bb          	subw	a7,a2,a3
         l = (stbsp__uint32)(s - (num + 64));
    2db8:	415787b3          	sub	a5,a5,s5
            cs = 1 + (3 << 24); // how many tens did we write (for commas below)
    2dbc:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff8689>
    2dbe:	fbcff06f          	j	257a <stbsp_vsprintfcb+0x11d6>
            *--s = '0';
    2dc2:	03000793          	li	a5,48
    2dc6:	fefa8fa3          	sb	a5,-1(s5)
            l = 1;
    2dca:	030002b7          	lui	t0,0x3000
    2dce:	4785                	li	a5,1
    2dd0:	d0be                	sw	a5,96(sp)
            *--s = '0';
    2dd2:	1afd                	addi	s5,s5,-1
            l = 1;
    2dd4:	4605                	li	a2,1
    2dd6:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff8689>
    2dd8:	4685                	li	a3,1
    2dda:	b9dd                	j	2ad0 <stbsp_vsprintfcb+0x172c>
   } else if (fl & STBSP__LEADINGSPACE) {
    2ddc:	004e7713          	andi	a4,t3,4
    2de0:	e74d                	bnez	a4,2e8a <stbsp_vsprintfcb+0x1ae6>
   } else if (fl & STBSP__LEADINGPLUS) {
    2de2:	8b89                	andi	a5,a5,2
    2de4:	efd9                	bnez	a5,2e82 <stbsp_vsprintfcb+0x1ade>
   sign[0] = 0;
    2de6:	06010423          	sb	zero,104(sp)
    2dea:	4a01                	li	s4,0
    2dec:	b9c9                	j	2abe <stbsp_vsprintfcb+0x171a>
               if ((s[0] == '0') && (s != (num + STBSP__NUMSZ)))
    2dee:	051c                	addi	a5,sp,640
    2df0:	cafa89e3          	beq	s5,a5,2aa2 <stbsp_vsprintfcb+0x16fe>
                  ++s;
    2df4:	0a85                	addi	s5,s5,1
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    2df6:	415786bb          	subw	a3,a5,s5
    2dfa:	b165                	j	2aa2 <stbsp_vsprintfcb+0x16fe>
                  n = dp - n;
    2dfc:	40ce87bb          	subw	a5,t4,a2
                  if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    2e00:	12030e63          	beqz	t1,2f3c <stbsp_vsprintfcb+0x1b98>
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2e04:	4511                	li	a0,4
    2e06:	03000613          	li	a2,48
                        *s++ = stbsp__comma;
    2e0a:	00170693          	addi	a3,a4,1
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2e0e:	00030563          	beqz	t1,2e18 <stbsp_vsprintfcb+0x1a74>
    2e12:	2585                	addiw	a1,a1,1
    2e14:	00a58963          	beq	a1,a0,2e26 <stbsp_vsprintfcb+0x1a82>
    2e18:	8736                	mv	a4,a3
                        --n;
    2e1a:	37fd                	addiw	a5,a5,-1
    2e1c:	fec70fa3          	sb	a2,-1(a4)
                  while (n) {
    2e20:	f7ed                	bnez	a5,2e0a <stbsp_vsprintfcb+0x1a66>
    2e22:	f38ff06f          	j	255a <stbsp_vsprintfcb+0x11b6>
    2e26:	fe568fa3          	sb	t0,-1(a3)
                        *s++ = stbsp__comma;
    2e2a:	0709                	addi	a4,a4,2
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2e2c:	4585                	li	a1,1
    2e2e:	b7f5                	j	2e1a <stbsp_vsprintfcb+0x1a76>
   sign[0] = 0;
    2e30:	06010423          	sb	zero,104(sp)
    2e34:	f1dfe06f          	j	1d50 <stbsp_vsprintfcb+0x9ac>
                     tail[idx + 1] = "_kMGT"[fl >> 24];
    2e38:	00002697          	auipc	a3,0x2
    2e3c:	33068693          	addi	a3,a3,816 # 5168 <_GLOBAL__sub_I__ZSt3cin+0xa2>
    2e40:	9736                	add	a4,a4,a3
    2e42:	00074683          	lbu	a3,0(a4)
    2e46:	1088                	addi	a0,sp,96
    2e48:	22060713          	addi	a4,a2,544
    2e4c:	972a                	add	a4,a4,a0
    2e4e:	ded70823          	sb	a3,-528(a4)
                  idx++;
    2e52:	8fb2                	mv	t6,a2
    2e54:	fb0ff06f          	j	2604 <stbsp_vsprintfcb+0x1260>
   while (limit && *sn) {
    2e58:	e00692e3          	bnez	a3,2c5c <stbsp_vsprintfcb+0x18b8>
    2e5c:	bd19                	j	2c72 <stbsp_vsprintfcb+0x18ce>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    2e5e:	0008071b          	sext.w	a4,a6
    2e62:	86c2                	mv	a3,a6
    2e64:	88d2                	mv	a7,s4
            pr = -dp + ((pr > (stbsp__int32)l) ? (stbsp__int32) l : pr);
    2e66:	863a                	mv	a2,a4
    2e68:	00e8d363          	bge	a7,a4,2e6e <stbsp_vsprintfcb+0x1aca>
    2e6c:	8646                	mv	a2,a7
    2e6e:	40f608bb          	subw	a7,a2,a5
    2e72:	814ff06f          	j	1e86 <stbsp_vsprintfcb+0xae2>
            divisor = 1000.0f;
    2e76:	00003797          	auipc	a5,0x3
    2e7a:	a927b787          	fld	fa5,-1390(a5) # 5908 <STDIN_FD+0x28>
    2e7e:	dd5fe06f          	j	1c52 <stbsp_vsprintfcb+0x8ae>
    2e82:	678d                	lui	a5,0x3
    2e84:	b017879b          	addiw	a5,a5,-1279 # 2b01 <stbsp_vsprintfcb+0x175d>
    2e88:	b13d                	j	2ab6 <stbsp_vsprintfcb+0x1712>
    2e8a:	6789                	lui	a5,0x2
    2e8c:	2785                	addiw	a5,a5,1 # 2001 <stbsp_vsprintfcb+0xc5d>
    2e8e:	b125                	j	2ab6 <stbsp_vsprintfcb+0x1712>
            *s++ = stbsp__period;
    2e90:	00004517          	auipc	a0,0x4
    2e94:	cbc54503          	lbu	a0,-836(a0) # 6b4c <stbsp__period>
         sn = s;
    2e98:	0c210793          	addi	a5,sp,194
         n = pr;
    2e9c:	0008869b          	sext.w	a3,a7
            *s++ = stbsp__period;
    2ea0:	0ca100a3          	sb	a0,193(sp)
         sn = s;
    2ea4:	fcbe                	sd	a5,120(sp)
         if (n > 13)
    2ea6:	4535                	li	a0,13
         n64 <<= 4;
    2ea8:	0712                	slli	a4,a4,0x4
         if (n > 13)
    2eaa:	8836                	mv	a6,a3
    2eac:	00d57363          	bgeu	a0,a3,2eb2 <stbsp_vsprintfcb+0x1b0e>
    2eb0:	4835                	li	a6,13
    2eb2:	0008051b          	sext.w	a0,a6
         while (n--) {
    2eb6:	387d                	addiw	a6,a6,-1
         if (pr > (stbsp__int32)n)
    2eb8:	af1542e3          	blt	a0,a7,299c <stbsp_vsprintfcb+0x15f8>
      tz = 0;
    2ebc:	4881                	li	a7,0
    2ebe:	b4cd                	j	29a0 <stbsp_vsprintfcb+0x15fc>
               while (n < l) {
    2ec0:	87ba                	mv	a5,a4
    2ec2:	bc1d                	j	28f8 <stbsp_vsprintfcb+0x1554>
         tail[0] = (char)n;
    2ec4:	478d                	li	a5,3
    2ec6:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    2eca:	06b109a3          	sb	a1,115(sp)
    2ece:	480d                	li	a6,3
    2ed0:	4f8d                	li	t6,3
    2ed2:	8e4ff06f          	j	1fb6 <stbsp_vsprintfcb+0xc12>
    2ed6:	678d                	lui	a5,0x3
    2ed8:	b017879b          	addiw	a5,a5,-1279 # 2b01 <stbsp_vsprintfcb+0x175d>
    2edc:	80aff06f          	j	1ee6 <stbsp_vsprintfcb+0xb42>
            if (pr)
    2ee0:	8336                	mv	t1,a3
            *s++ = '0';
    2ee2:	0c110793          	addi	a5,sp,193
            while (i) {
    2ee6:	4801                	li	a6,0
    2ee8:	b561                	j	2d70 <stbsp_vsprintfcb+0x19cc>
            while (i >= 4) {
    2eea:	460d                	li	a2,3
    2eec:	04e65663          	bge	a2,a4,2f38 <stbsp_vsprintfcb+0x1b94>
    2ef0:	ffb5871b          	addiw	a4,a1,-5
    2ef4:	0027559b          	srliw	a1,a4,0x2
    2ef8:	0015861b          	addiw	a2,a1,1
    2efc:	060a                	slli	a2,a2,0x2
               *(stbsp__uint32 *)s = 0x30303030;
    2efe:	30303537          	lui	a0,0x30303
    2f02:	963e                	add	a2,a2,a5
    2f04:	03050513          	addi	a0,a0,48 # 30303030 <_ZSt4cerr+0x302fb6b8>
    2f08:	c388                	sw	a0,0(a5)
               s += 4;
    2f0a:	0791                	addi	a5,a5,4
            while (i >= 4) {
    2f0c:	fef61ee3          	bne	a2,a5,2f08 <stbsp_vsprintfcb+0x1b64>
    2f10:	0025959b          	slliw	a1,a1,0x2
    2f14:	9f0d                	subw	a4,a4,a1
            while (i) {
    2f16:	e4070de3          	beqz	a4,2d70 <stbsp_vsprintfcb+0x19cc>
               *s++ = '0';
    2f1a:	03000513          	li	a0,48
            while (i) {
    2f1e:	00f705bb          	addw	a1,a4,a5
               *s++ = '0';
    2f22:	0605                	addi	a2,a2,1
            while (i) {
    2f24:	00060e9b          	sext.w	t4,a2
               *s++ = '0';
    2f28:	fea60fa3          	sb	a0,-1(a2)
            while (i) {
    2f2c:	ffd59be3          	bne	a1,t4,2f22 <stbsp_vsprintfcb+0x1b7e>
    2f30:	1702                	slli	a4,a4,0x20
    2f32:	9301                	srli	a4,a4,0x20
    2f34:	97ba                	add	a5,a5,a4
    2f36:	bd2d                	j	2d70 <stbsp_vsprintfcb+0x19cc>
            while (i >= 4) {
    2f38:	863e                	mv	a2,a5
    2f3a:	b7c5                	j	2f1a <stbsp_vsprintfcb+0x1b76>
                        if ((((stbsp__uintptr)s) & 3) == 0)
    2f3c:	00377693          	andi	a3,a4,3
    2f40:	ce81                	beqz	a3,2f58 <stbsp_vsprintfcb+0x1bb4>
                        *s++ = '0';
    2f42:	03000693          	li	a3,48
    2f46:	00d70023          	sb	a3,0(a4)
                        --n;
    2f4a:	37fd                	addiw	a5,a5,-1
                        *s++ = '0';
    2f4c:	0705                	addi	a4,a4,1
                     while (n) {
    2f4e:	e0078663          	beqz	a5,255a <stbsp_vsprintfcb+0x11b6>
                        if ((((stbsp__uintptr)s) & 3) == 0)
    2f52:	00377613          	andi	a2,a4,3
    2f56:	fa65                	bnez	a2,2f46 <stbsp_vsprintfcb+0x1ba2>
                     while (n >= 4) {
    2f58:	468d                	li	a3,3
    2f5a:	eaf6f5e3          	bgeu	a3,a5,2e04 <stbsp_vsprintfcb+0x1a60>
    2f5e:	ffc7869b          	addiw	a3,a5,-4
    2f62:	0026d69b          	srliw	a3,a3,0x2
    2f66:	2685                	addiw	a3,a3,1
    2f68:	068a                	slli	a3,a3,0x2
                        *(stbsp__uint32 *)s = 0x30303030;
    2f6a:	30303637          	lui	a2,0x30303
    2f6e:	96ba                	add	a3,a3,a4
    2f70:	03060613          	addi	a2,a2,48 # 30303030 <_ZSt4cerr+0x302fb6b8>
    2f74:	c310                	sw	a2,0(a4)
                        s += 4;
    2f76:	0711                	addi	a4,a4,4
                     while (n >= 4) {
    2f78:	fed71ee3          	bne	a4,a3,2f74 <stbsp_vsprintfcb+0x1bd0>
    2f7c:	8b8d                	andi	a5,a5,3
                  while (n) {
    2f7e:	e80793e3          	bnez	a5,2e04 <stbsp_vsprintfcb+0x1a60>
    2f82:	dd8ff06f          	j	255a <stbsp_vsprintfcb+0x11b6>
      if (((stbsp__uintptr)sn & 3) == 0)
    2f86:	87d6                	mv	a5,s5
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    2f88:	56fd                	li	a3,-1
    2f8a:	b155                	j	2c2e <stbsp_vsprintfcb+0x188a>
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    2f8c:	5775                	li	a4,-3
    2f8e:	00e7ce63          	blt	a5,a4,2faa <stbsp_vsprintfcb+0x1c06>
    2f92:	f6fa4663          	blt	s4,a5,26fe <stbsp_vsprintfcb+0x135a>
         if (dp > 0) {
    2f96:	ecf054e3          	blez	a5,2e5e <stbsp_vsprintfcb+0x1aba>
    2f9a:	86c2                	mv	a3,a6
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    2f9c:	4881                	li	a7,0
    2f9e:	ee9fe06f          	j	1e86 <stbsp_vsprintfcb+0xae2>
                  while (i--)
    2fa2:	fff7869b          	addiw	a3,a5,-1
    2fa6:	8722                	mv	a4,s0
    2fa8:	b105                	j	2bc8 <stbsp_vsprintfcb+0x1824>
            if (pr > (stbsp__int32)l)
    2faa:	0008071b          	sext.w	a4,a6
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2fae:	7ae6                	ld	s5,120(sp)
            if (pr > (stbsp__int32)l)
    2fb0:	86c2                	mv	a3,a6
    2fb2:	88d2                	mv	a7,s4
    2fb4:	f7475d63          	bge	a4,s4,272e <stbsp_vsprintfcb+0x138a>
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2fb8:	8542                	mv	a0,a6
    2fba:	f56ff06f          	j	2710 <stbsp_vsprintfcb+0x136c>

0000000000002fbe <stbsp_sprintf>:
{
    2fbe:	715d                	addi	sp,sp,-80
   va_start(va, fmt);
    2fc0:	02010313          	addi	t1,sp,32
{
    2fc4:	f032                	sd	a2,32(sp)
    2fc6:	f436                	sd	a3,40(sp)
    2fc8:	f83a                	sd	a4,48(sp)
   result = STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    2fca:	86ae                	mv	a3,a1
    2fcc:	862a                	mv	a2,a0
    2fce:	871a                	mv	a4,t1
    2fd0:	4581                	li	a1,0
    2fd2:	4501                	li	a0,0
{
    2fd4:	ec06                	sd	ra,24(sp)
    2fd6:	fc3e                	sd	a5,56(sp)
    2fd8:	e0c2                	sd	a6,64(sp)
    2fda:	e4c6                	sd	a7,72(sp)
   va_start(va, fmt);
    2fdc:	e41a                	sd	t1,8(sp)
   result = STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    2fde:	bc6fe0ef          	jal	13a4 <stbsp_vsprintfcb>
}
    2fe2:	60e2                	ld	ra,24(sp)
    2fe4:	6161                	addi	sp,sp,80
    2fe6:	8082                	ret

0000000000002fe8 <stbsp_vsnprintf>:
{
    2fe8:	dd010113          	addi	sp,sp,-560
    2fec:	22813023          	sd	s0,544(sp)
    2ff0:	20913c23          	sd	s1,536(sp)
    2ff4:	22113423          	sd	ra,552(sp)
    2ff8:	84ae                	mv	s1,a1
    2ffa:	842a                	mv	s0,a0
    2ffc:	88b2                	mv	a7,a2
    2ffe:	8736                	mv	a4,a3
   if ( (count == 0) && !buf )
    3000:	e591                	bnez	a1,300c <stbsp_vsnprintf+0x24>
    3002:	c141                	beqz	a0,3082 <stbsp_vsnprintf+0x9a>
      c.buf = buf;
    3004:	e02a                	sd	a0,0(sp)
      c.count = count;
    3006:	e402                	sd	zero,8(sp)
   return (c->count >= STB_SPRINTF_MIN) ? c->buf : c->tmp; // go direct into buffer if you can
    3008:	0810                	addi	a2,sp,16
    300a:	a089                	j	304c <stbsp_vsnprintf+0x64>
   if (len > c->count)
    300c:	0015a593          	slti	a1,a1,1
    3010:	40b005bb          	negw	a1,a1
    3014:	8de5                	and	a1,a1,s1
      c.buf = buf;
    3016:	e02a                	sd	a0,0(sp)
      c.count = count;
    3018:	c426                	sw	s1,8(sp)
      c.length = 0;
    301a:	c602                	sw	zero,12(sp)
   if (len > c->count)
    301c:	2581                	sext.w	a1,a1
   if (len) {
    301e:	0804d663          	bgez	s1,30aa <stbsp_vsnprintf+0xc2>
         s = buf;
    3022:	4781                	li	a5,0
      if (buf != c->buf) {
    3024:	c911                	beqz	a0,3038 <stbsp_vsnprintf+0x50>
            *d++ = *s++;
    3026:	0007c803          	lbu	a6,0(a5)
    302a:	0785                	addi	a5,a5,1
    302c:	00f40533          	add	a0,s0,a5
    3030:	ff050fa3          	sb	a6,-1(a0)
         } while (s < se);
    3034:	feb7e9e3          	bltu	a5,a1,3026 <stbsp_vsnprintf+0x3e>
      c->count -= len;
    3038:	40b486bb          	subw	a3,s1,a1
      c->buf += len;
    303c:	95a2                	add	a1,a1,s0
    303e:	e02e                	sd	a1,0(sp)
      c->count -= len;
    3040:	c436                	sw	a3,8(sp)
   return (c->count >= STB_SPRINTF_MIN) ? c->buf : c->tmp; // go direct into buffer if you can
    3042:	1ff00793          	li	a5,511
    3046:	fcd7d1e3          	bge	a5,a3,3008 <stbsp_vsnprintf+0x20>
    304a:	6602                	ld	a2,0(sp)
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__clamp_callback, &c, stbsp__clamp_callback(0,&c,0), fmt, va );
    304c:	86c6                	mv	a3,a7
    304e:	858a                	mv	a1,sp
    3050:	ffffd517          	auipc	a0,0xffffd
    3054:	21650513          	addi	a0,a0,534 # 266 <stbsp__clamp_callback>
    3058:	b4cfe0ef          	jal	13a4 <stbsp_vsprintfcb>
      l = (int)( c.buf - buf );
    305c:	6782                	ld	a5,0(sp)
    305e:	9f81                	subw	a5,a5,s0
      if ( l >= count ) // should never be greater, only equal (or less) than count
    3060:	0097c463          	blt	a5,s1,3068 <stbsp_vsnprintf+0x80>
         l = count - 1;
    3064:	fff4879b          	addiw	a5,s1,-1
      buf[l] = 0;
    3068:	943e                	add	s0,s0,a5
    306a:	00040023          	sb	zero,0(s0)
}
    306e:	22813083          	ld	ra,552(sp)
    3072:	22013403          	ld	s0,544(sp)
    3076:	4532                	lw	a0,12(sp)
    3078:	21813483          	ld	s1,536(sp)
    307c:	23010113          	addi	sp,sp,560
    3080:	8082                	ret
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__count_clamp_callback, &c, c.tmp, fmt, va );
    3082:	86b2                	mv	a3,a2
    3084:	858a                	mv	a1,sp
    3086:	0810                	addi	a2,sp,16
    3088:	ffffd517          	auipc	a0,0xffffd
    308c:	22c50513          	addi	a0,a0,556 # 2b4 <stbsp__count_clamp_callback>
      c.length = 0;
    3090:	c602                	sw	zero,12(sp)
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__count_clamp_callback, &c, c.tmp, fmt, va );
    3092:	b12fe0ef          	jal	13a4 <stbsp_vsprintfcb>
}
    3096:	22813083          	ld	ra,552(sp)
    309a:	22013403          	ld	s0,544(sp)
    309e:	4532                	lw	a0,12(sp)
    30a0:	21813483          	ld	s1,536(sp)
    30a4:	23010113          	addi	sp,sp,560
    30a8:	8082                	ret
    30aa:	86a6                	mv	a3,s1
    30ac:	bf59                	j	3042 <stbsp_vsnprintf+0x5a>

00000000000030ae <stbsp_snprintf>:
{
    30ae:	715d                	addi	sp,sp,-80
   va_start(va, fmt);
    30b0:	02810313          	addi	t1,sp,40
{
    30b4:	f436                	sd	a3,40(sp)
   result = STB_SPRINTF_DECORATE(vsnprintf)(buf, count, fmt, va);
    30b6:	869a                	mv	a3,t1
{
    30b8:	ec06                	sd	ra,24(sp)
    30ba:	f83a                	sd	a4,48(sp)
    30bc:	fc3e                	sd	a5,56(sp)
    30be:	e0c2                	sd	a6,64(sp)
    30c0:	e4c6                	sd	a7,72(sp)
   va_start(va, fmt);
    30c2:	e41a                	sd	t1,8(sp)
   result = STB_SPRINTF_DECORATE(vsnprintf)(buf, count, fmt, va);
    30c4:	f25ff0ef          	jal	2fe8 <stbsp_vsnprintf>
}
    30c8:	60e2                	ld	ra,24(sp)
    30ca:	6161                	addi	sp,sp,80
    30cc:	8082                	ret

00000000000030ce <stbsp_vsprintf>:
{
    30ce:	86ae                	mv	a3,a1
    30d0:	8732                	mv	a4,a2
   return STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    30d2:	4581                	li	a1,0
    30d4:	862a                	mv	a2,a0
    30d6:	4501                	li	a0,0
    30d8:	accfe06f          	j	13a4 <stbsp_vsprintfcb>

00000000000030dc <sprintf>:
{
    30dc:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    30de:	05010313          	addi	t1,sp,80
{
    30e2:	e0a2                	sd	s0,64(sp)
    30e4:	fc26                	sd	s1,56(sp)
    30e6:	842a                	mv	s0,a0
    30e8:	e8b2                	sd	a2,80(sp)
    _vprintf_core(&ctx, format, ap);
    30ea:	0808                	addi	a0,sp,16
    ctx.limit = size;
    30ec:	54fd                	li	s1,-1
    _vprintf_core(&ctx, format, ap);
    30ee:	861a                	mv	a2,t1
{
    30f0:	e486                	sd	ra,72(sp)
    30f2:	ecb6                	sd	a3,88(sp)
    30f4:	f0ba                	sd	a4,96(sp)
    30f6:	f4be                	sd	a5,104(sp)
    30f8:	f8c2                	sd	a6,112(sp)
    30fa:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    30fc:	e41a                	sd	t1,8(sp)
    ctx.buf = str;
    30fe:	e822                	sd	s0,16(sp)
    ctx.limit = size;
    3100:	ec26                	sd	s1,24(sp)
    ctx.written = 0;
    3102:	f002                	sd	zero,32(sp)
    ctx.stream = NULL;
    3104:	f402                	sd	zero,40(sp)
    _vprintf_core(&ctx, format, ap);
    3106:	02c000ef          	jal	3132 <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    310a:	7502                	ld	a0,32(sp)
    310c:	00950b63          	beq	a0,s1,3122 <sprintf+0x46>
            str[ctx.written] = '\0';
    3110:	942a                	add	s0,s0,a0
    3112:	00040023          	sb	zero,0(s0)
}
    3116:	60a6                	ld	ra,72(sp)
    3118:	6406                	ld	s0,64(sp)
    311a:	74e2                	ld	s1,56(sp)
    311c:	2501                	sext.w	a0,a0
    311e:	6109                	addi	sp,sp,128
    3120:	8082                	ret
            str[size - 1] = '\0';
    3122:	fe040f23          	sb	zero,-2(s0)
}
    3126:	60a6                	ld	ra,72(sp)
    3128:	6406                	ld	s0,64(sp)
    312a:	74e2                	ld	s1,56(sp)
    312c:	2501                	sext.w	a0,a0
    312e:	6109                	addi	sp,sp,128
    3130:	8082                	ret

0000000000003132 <_vprintf_core.constprop.0.isra.0>:
static int _vprintf_core(_OutContext *ctx, const char *format, va_list ap)
    3132:	7129                	addi	sp,sp,-320
    3134:	edee                	sd	s11,216(sp)
    3136:	fe06                	sd	ra,312(sp)
    3138:	8dae                	mv	s11,a1
    while (*p)
    313a:	0005c583          	lbu	a1,0(a1)
    313e:	cde9                	beqz	a1,3218 <_vprintf_core.constprop.0.isra.0+0xe6>
    3140:	f626                	sd	s1,296(sp)
    3142:	f24a                	sd	s2,288(sp)
    3144:	ee4e                	sd	s3,280(sp)
    3146:	e656                	sd	s5,264(sp)
    3148:	f9e2                	sd	s8,240(sp)
    314a:	fa22                	sd	s0,304(sp)
    314c:	ea52                	sd	s4,272(sp)
    314e:	e25a                	sd	s6,256(sp)
    3150:	fdde                	sd	s7,248(sp)
    3152:	f5e6                	sd	s9,232(sp)
    3154:	f1ea                	sd	s10,224(sp)
    3156:	84aa                	mv	s1,a0
    3158:	8c32                	mv	s8,a2
        if (*p != '%')
    315a:	02500a93          	li	s5,37
    315e:	49c1                	li	s3,16
    3160:	00002917          	auipc	s2,0x2
    3164:	2dc90913          	addi	s2,s2,732 # 543c <_GLOBAL__sub_I__ZSt3cin+0x376>
    3168:	a039                	j	3176 <_vprintf_core.constprop.0.isra.0+0x44>
                _out_char(ctx, spec);
    316a:	8526                	mv	a0,s1
    316c:	952fe0ef          	jal	12be <_out_char>
    while (*p)
    3170:	000dc583          	lbu	a1,0(s11)
    3174:	c5d9                	beqz	a1,3202 <_vprintf_core.constprop.0.isra.0+0xd0>
            _out_char(ctx, *p++);
    3176:	0d85                	addi	s11,s11,1
        if (*p != '%')
    3178:	ff5599e3          	bne	a1,s5,316a <_vprintf_core.constprop.0.isra.0+0x38>
        int flag_left = 0, flag_zero = 0, flag_plus = 0, flag_space = 0, flag_hash = 0;
    317c:	4501                	li	a0,0
    317e:	4881                	li	a7,0
    3180:	4581                	li	a1,0
    3182:	4b01                	li	s6,0
    3184:	4a01                	li	s4,0
            if (*p == '-')
    3186:	000dcc83          	lbu	s9,0(s11)
    318a:	fe0c871b          	addiw	a4,s9,-32
    318e:	0ff77713          	zext.b	a4,a4
    3192:	00e9e763          	bltu	s3,a4,31a0 <_vprintf_core.constprop.0.isra.0+0x6e>
    3196:	070a                	slli	a4,a4,0x2
    3198:	974a                	add	a4,a4,s2
    319a:	4318                	lw	a4,0(a4)
    319c:	974a                	add	a4,a4,s2
    319e:	8702                	jr	a4
        if (*p == '*')
    31a0:	02a00793          	li	a5,42
    31a4:	16fc9c63          	bne	s9,a5,331c <_vprintf_core.constprop.0.isra.0+0x1ea>
            width = va_arg(ap, int);
    31a8:	000c2403          	lw	s0,0(s8)
    31ac:	0c21                	addi	s8,s8,8
            if (width < 0)
    31ae:	00045563          	bgez	s0,31b8 <_vprintf_core.constprop.0.isra.0+0x86>
                width = -width;
    31b2:	4080043b          	negw	s0,s0
                flag_left = 1;
    31b6:	4a05                	li	s4,1
            while (*p >= '0' && *p <= '9')
    31b8:	001dcc83          	lbu	s9,1(s11)
            p++;
    31bc:	0d85                	addi	s11,s11,1
        if (*p == '.')
    31be:	02e00793          	li	a5,46
        int precision = -1;
    31c2:	5bfd                	li	s7,-1
        if (*p == '.')
    31c4:	18fc8a63          	beq	s9,a5,3358 <_vprintf_core.constprop.0.isra.0+0x226>
        if (*p == 'l')
    31c8:	06c00693          	li	a3,108
    31cc:	8666                	mv	a2,s9
    31ce:	1adc8663          	beq	s9,a3,337a <_vprintf_core.constprop.0.isra.0+0x248>
        else if (*p == 'z')
    31d2:	07a00693          	li	a3,122
            p++;
    31d6:	0d85                	addi	s11,s11,1
        else if (*p == 'z')
    31d8:	24dc8163          	beq	s9,a3,341a <_vprintf_core.constprop.0.isra.0+0x2e8>
        if (!spec)
    31dc:	06400693          	li	a3,100
    31e0:	4adc8163          	beq	s9,a3,3682 <_vprintf_core.constprop.0.isra.0+0x550>
    31e4:	06400693          	li	a3,100
        int len_mod = 0;
    31e8:	4e81                	li	t4,0
    31ea:	1b96e663          	bltu	a3,s9,3396 <_vprintf_core.constprop.0.isra.0+0x264>
    31ee:	04700693          	li	a3,71
    31f2:	2796e463          	bltu	a3,s9,345a <_vprintf_core.constprop.0.isra.0+0x328>
    31f6:	04400693          	li	a3,68
    31fa:	0596e363          	bltu	a3,s9,3240 <_vprintf_core.constprop.0.isra.0+0x10e>
    31fe:	240c9363          	bnez	s9,3444 <_vprintf_core.constprop.0.isra.0+0x312>
    3202:	7452                	ld	s0,304(sp)
    3204:	74b2                	ld	s1,296(sp)
    3206:	7912                	ld	s2,288(sp)
    3208:	69f2                	ld	s3,280(sp)
    320a:	6a52                	ld	s4,272(sp)
    320c:	6ab2                	ld	s5,264(sp)
    320e:	6b12                	ld	s6,256(sp)
    3210:	7bee                	ld	s7,248(sp)
    3212:	7c4e                	ld	s8,240(sp)
    3214:	7cae                	ld	s9,232(sp)
    3216:	7d0e                	ld	s10,224(sp)
}
    3218:	70f2                	ld	ra,312(sp)
    321a:	6dee                	ld	s11,216(sp)
    321c:	6131                	addi	sp,sp,320
    321e:	8082                	ret
            if (*p == '-')
    3220:	4585                	li	a1,1
            p++;
    3222:	0d85                	addi	s11,s11,1
            if (*p == '-')
    3224:	b78d                	j	3186 <_vprintf_core.constprop.0.isra.0+0x54>
    3226:	4505                	li	a0,1
            p++;
    3228:	0d85                	addi	s11,s11,1
        while (1)
    322a:	bfb1                	j	3186 <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    322c:	4885                	li	a7,1
            p++;
    322e:	0d85                	addi	s11,s11,1
        while (1)
    3230:	bf99                	j	3186 <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    3232:	4b05                	li	s6,1
            p++;
    3234:	0d85                	addi	s11,s11,1
        while (1)
    3236:	bf81                	j	3186 <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    3238:	4a05                	li	s4,1
            p++;
    323a:	0d85                	addi	s11,s11,1
        while (1)
    323c:	b7a9                	j	3186 <_vprintf_core.constprop.0.isra.0+0x54>
        char spec = *p++;
    323e:	8dbe                	mv	s11,a5
            fmt_tmp[f_idx++] = '%';
    3240:	02500693          	li	a3,37
    3244:	02d10823          	sb	a3,48(sp)
    3248:	4d05                	li	s10,1
            if (flag_left)
    324a:	000a0763          	beqz	s4,3258 <_vprintf_core.constprop.0.isra.0+0x126>
                fmt_tmp[f_idx++] = '-';
    324e:	02d00693          	li	a3,45
    3252:	02d108a3          	sb	a3,49(sp)
    3256:	4d09                	li	s10,2
            if (flag_zero)
    3258:	000b0c63          	beqz	s6,3270 <_vprintf_core.constprop.0.isra.0+0x13e>
                fmt_tmp[f_idx++] = '0';
    325c:	0c0d0793          	addi	a5,s10,192
    3260:	0818                	addi	a4,sp,16
    3262:	00e786b3          	add	a3,a5,a4
    3266:	03000613          	li	a2,48
    326a:	f6c68023          	sb	a2,-160(a3)
    326e:	2d05                	addiw	s10,s10,1
            if (flag_plus)
    3270:	c999                	beqz	a1,3286 <_vprintf_core.constprop.0.isra.0+0x154>
                fmt_tmp[f_idx++] = '+';
    3272:	0c0d0793          	addi	a5,s10,192
    3276:	0818                	addi	a4,sp,16
    3278:	00e786b3          	add	a3,a5,a4
    327c:	02b00613          	li	a2,43
    3280:	f6c68023          	sb	a2,-160(a3)
    3284:	2d05                	addiw	s10,s10,1
            if (flag_space)
    3286:	00088c63          	beqz	a7,329e <_vprintf_core.constprop.0.isra.0+0x16c>
                fmt_tmp[f_idx++] = ' ';
    328a:	0c0d0793          	addi	a5,s10,192
    328e:	0818                	addi	a4,sp,16
    3290:	00e786b3          	add	a3,a5,a4
    3294:	02000613          	li	a2,32
    3298:	f6c68023          	sb	a2,-160(a3)
    329c:	2d05                	addiw	s10,s10,1
            if (flag_hash)
    329e:	c919                	beqz	a0,32b4 <_vprintf_core.constprop.0.isra.0+0x182>
                fmt_tmp[f_idx++] = '#';
    32a0:	0c0d0793          	addi	a5,s10,192
    32a4:	0818                	addi	a4,sp,16
    32a6:	00e786b3          	add	a3,a5,a4
    32aa:	02300613          	li	a2,35
    32ae:	f6c68023          	sb	a2,-160(a3)
    32b2:	2d05                	addiw	s10,s10,1
            if (width > 0)
    32b4:	03010a13          	addi	s4,sp,48
    32b8:	28804563          	bgtz	s0,3542 <_vprintf_core.constprop.0.isra.0+0x410>
            if (precision >= 0)
    32bc:	260bd763          	bgez	s7,352a <_vprintf_core.constprop.0.isra.0+0x3f8>
            fmt_tmp[f_idx++] = spec;
    32c0:	0c0d0793          	addi	a5,s10,192
    32c4:	0818                	addi	a4,sp,16
    32c6:	00e78633          	add	a2,a5,a4
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    32ca:	000c3683          	ld	a3,0(s8)
            fmt_tmp[f_idx] = '\0';
    32ce:	001d071b          	addiw	a4,s10,1
    32d2:	0c070793          	addi	a5,a4,192
    32d6:	0818                	addi	a4,sp,16
            fmt_tmp[f_idx++] = spec;
    32d8:	f7960023          	sb	s9,-160(a2)
            fmt_tmp[f_idx] = '\0';
    32dc:	973e                	add	a4,a4,a5
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    32de:	08000593          	li	a1,128
    32e2:	8652                	mv	a2,s4
    32e4:	0888                	addi	a0,sp,80
            fmt_tmp[f_idx] = '\0';
    32e6:	f6070023          	sb	zero,-160(a4)
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    32ea:	dc5ff0ef          	jal	30ae <stbsp_snprintf>
            for (int i = 0; f_buf[i] != '\0'; i++)
    32ee:	05014583          	lbu	a1,80(sp)
            double f_val = va_arg(ap, double);
    32f2:	0c21                	addi	s8,s8,8
            for (int i = 0; f_buf[i] != '\0'; i++)
    32f4:	05110413          	addi	s0,sp,81
    32f8:	e6058ce3          	beqz	a1,3170 <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, f_buf[i]);
    32fc:	8526                	mv	a0,s1
    32fe:	fc1fd0ef          	jal	12be <_out_char>
            for (int i = 0; f_buf[i] != '\0'; i++)
    3302:	00044583          	lbu	a1,0(s0)
    3306:	0405                	addi	s0,s0,1
    3308:	e60584e3          	beqz	a1,3170 <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, f_buf[i]);
    330c:	8526                	mv	a0,s1
    330e:	fb1fd0ef          	jal	12be <_out_char>
            for (int i = 0; f_buf[i] != '\0'; i++)
    3312:	00044583          	lbu	a1,0(s0)
    3316:	0405                	addi	s0,s0,1
    3318:	f1f5                	bnez	a1,32fc <_vprintf_core.constprop.0.isra.0+0x1ca>
    331a:	bd99                	j	3170 <_vprintf_core.constprop.0.isra.0+0x3e>
            while (*p >= '0' && *p <= '9')
    331c:	fd0c869b          	addiw	a3,s9,-48
    3320:	0ff6f313          	zext.b	t1,a3
    3324:	4725                	li	a4,9
        int width = 0;
    3326:	4401                	li	s0,0
            while (*p >= '0' && *p <= '9')
    3328:	4625                	li	a2,9
    332a:	e8676ae3          	bltu	a4,t1,31be <_vprintf_core.constprop.0.isra.0+0x8c>
    332e:	001dcc83          	lbu	s9,1(s11)
                width = width * 10 + (*p - '0');
    3332:	0024171b          	slliw	a4,s0,0x2
    3336:	9f21                	addw	a4,a4,s0
    3338:	0017171b          	slliw	a4,a4,0x1
    333c:	00e6843b          	addw	s0,a3,a4
            while (*p >= '0' && *p <= '9')
    3340:	fd0c869b          	addiw	a3,s9,-48
    3344:	0ff6f713          	zext.b	a4,a3
                p++;
    3348:	0d85                	addi	s11,s11,1
            while (*p >= '0' && *p <= '9')
    334a:	fee672e3          	bgeu	a2,a4,332e <_vprintf_core.constprop.0.isra.0+0x1fc>
        if (*p == '.')
    334e:	02e00793          	li	a5,46
        int precision = -1;
    3352:	5bfd                	li	s7,-1
        if (*p == '.')
    3354:	e6fc9ae3          	bne	s9,a5,31c8 <_vprintf_core.constprop.0.isra.0+0x96>
            if (*p == '*')
    3358:	001dcc83          	lbu	s9,1(s11)
    335c:	02a00793          	li	a5,42
    3360:	16fc9f63          	bne	s9,a5,34de <_vprintf_core.constprop.0.isra.0+0x3ac>
                while (*p >= '0' && *p <= '9')
    3364:	002dcc83          	lbu	s9,2(s11)
        if (*p == 'l')
    3368:	06c00693          	li	a3,108
                precision = va_arg(ap, int);
    336c:	000c2b83          	lw	s7,0(s8)
                p++;
    3370:	0d89                	addi	s11,s11,2
                precision = va_arg(ap, int);
    3372:	0c21                	addi	s8,s8,8
        if (*p == 'l')
    3374:	8666                	mv	a2,s9
    3376:	e4dc9ee3          	bne	s9,a3,31d2 <_vprintf_core.constprop.0.isra.0+0xa0>
            if (*p == 'l')
    337a:	001dcc83          	lbu	s9,1(s11)
    337e:	08cc8d63          	beq	s9,a2,3418 <_vprintf_core.constprop.0.isra.0+0x2e6>
        char spec = *p++;
    3382:	06400693          	li	a3,100
    3386:	0d89                	addi	s11,s11,2
        if (!spec)
    3388:	4cdc8c63          	beq	s9,a3,3860 <_vprintf_core.constprop.0.isra.0+0x72e>
    338c:	06400693          	li	a3,100
            len_mod = 1;
    3390:	4e85                	li	t4,1
    3392:	e596fee3          	bgeu	a3,s9,31ee <_vprintf_core.constprop.0.isra.0+0xbc>
    3396:	f9bc869b          	addiw	a3,s9,-101
    339a:	0ff6f693          	zext.b	a3,a3
    339e:	464d                	li	a2,19
    33a0:	12d66863          	bltu	a2,a3,34d0 <_vprintf_core.constprop.0.isra.0+0x39e>
    33a4:	4e05                	li	t3,1
    33a6:	00091637          	lui	a2,0x91
    33aa:	00de1333          	sll	t1,t3,a3
    33ae:	81060613          	addi	a2,a2,-2032 # 90810 <_ZSt4cerr+0x88e98>
    33b2:	00c37633          	and	a2,t1,a2
    33b6:	1a061463          	bnez	a2,355e <_vprintf_core.constprop.0.isra.0+0x42c>
    33ba:	00737313          	andi	t1,t1,7
    33be:	e80311e3          	bnez	t1,3240 <_vprintf_core.constprop.0.isra.0+0x10e>
    33c2:	4639                	li	a2,14
    33c4:	10c69663          	bne	a3,a2,34d0 <_vprintf_core.constprop.0.isra.0+0x39e>
            const char *s = va_arg(ap, char *);
    33c8:	000c3c83          	ld	s9,0(s8)
            if (!s)
    33cc:	420c8863          	beqz	s9,37fc <_vprintf_core.constprop.0.isra.0+0x6ca>
            while (*tmp && (precision < 0 || len < precision))
    33d0:	000cc683          	lbu	a3,0(s9)
    33d4:	38068863          	beqz	a3,3764 <_vprintf_core.constprop.0.isra.0+0x632>
            const char *tmp = s;
    33d8:	8666                	mv	a2,s9
            int len = 0;
    33da:	4681                	li	a3,0
            while (*tmp && (precision < 0 || len < precision))
    33dc:	00db8863          	beq	s7,a3,33ec <_vprintf_core.constprop.0.isra.0+0x2ba>
    33e0:	00164583          	lbu	a1,1(a2)
                len++;
    33e4:	2685                	addiw	a3,a3,1
                tmp++;
    33e6:	0605                	addi	a2,a2,1
            while (*tmp && (precision < 0 || len < precision))
    33e8:	f9f5                	bnez	a1,33dc <_vprintf_core.constprop.0.isra.0+0x2aa>
    33ea:	8bb6                	mv	s7,a3
            int padding = (width > len) ? width - len : 0;
    33ec:	268bc563          	blt	s7,s0,3656 <_vprintf_core.constprop.0.isra.0+0x524>
            for (int i = 0; i < len; i++)
    33f0:	4401                	li	s0,0
    33f2:	020b8163          	beqz	s7,3414 <_vprintf_core.constprop.0.isra.0+0x2e2>
    33f6:	4d01                	li	s10,0
                _out_char(ctx, s[i]);
    33f8:	01ac86b3          	add	a3,s9,s10
    33fc:	0006c583          	lbu	a1,0(a3)
    3400:	8526                	mv	a0,s1
            for (int i = 0; i < len; i++)
    3402:	0d05                	addi	s10,s10,1
                _out_char(ctx, s[i]);
    3404:	ebbfd0ef          	jal	12be <_out_char>
            for (int i = 0; i < len; i++)
    3408:	000d069b          	sext.w	a3,s10
    340c:	ff76c6e3          	blt	a3,s7,33f8 <_vprintf_core.constprop.0.isra.0+0x2c6>
            if (flag_left)
    3410:	260a1463          	bnez	s4,3678 <_vprintf_core.constprop.0.isra.0+0x546>
            const char *s = va_arg(ap, char *);
    3414:	0c21                	addi	s8,s8,8
    3416:	bba9                	j	3170 <_vprintf_core.constprop.0.isra.0+0x3e>
                p++;
    3418:	0d89                	addi	s11,s11,2
        char spec = *p++;
    341a:	000dcc83          	lbu	s9,0(s11)
    341e:	06400693          	li	a3,100
    3422:	001d8793          	addi	a5,s11,1
        if (!spec)
    3426:	3edc8063          	beq	s9,a3,3806 <_vprintf_core.constprop.0.isra.0+0x6d4>
    342a:	0796ea63          	bltu	a3,s9,349e <_vprintf_core.constprop.0.isra.0+0x36c>
    342e:	04700693          	li	a3,71
    3432:	0f96e263          	bltu	a3,s9,3516 <_vprintf_core.constprop.0.isra.0+0x3e4>
    3436:	04400693          	li	a3,68
    343a:	e196e2e3          	bltu	a3,s9,323e <_vprintf_core.constprop.0.isra.0+0x10c>
    343e:	dc0c82e3          	beqz	s9,3202 <_vprintf_core.constprop.0.isra.0+0xd0>
        char spec = *p++;
    3442:	8dbe                	mv	s11,a5
            _out_char(ctx, '%');
    3444:	02500593          	li	a1,37
    3448:	8526                	mv	a0,s1
    344a:	e75fd0ef          	jal	12be <_out_char>
            if (spec != '%')
    344e:	02500713          	li	a4,37
    3452:	d0ec8fe3          	beq	s9,a4,3170 <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, spec);
    3456:	85e6                	mv	a1,s9
    3458:	bb09                	j	316a <_vprintf_core.constprop.0.isra.0+0x38>
    345a:	05800693          	li	a3,88
    345e:	2edc8263          	beq	s9,a3,3742 <_vprintf_core.constprop.0.isra.0+0x610>
    3462:	06300713          	li	a4,99
    3466:	06ec9563          	bne	s9,a4,34d0 <_vprintf_core.constprop.0.isra.0+0x39e>
            char c = (char)va_arg(ap, int);
    346a:	000c4c83          	lbu	s9,0(s8)
            int padding = (width > 1) ? width - 1 : 0;
    346e:	8722                	mv	a4,s0
    3470:	00804363          	bgtz	s0,3476 <_vprintf_core.constprop.0.isra.0+0x344>
    3474:	4705                	li	a4,1
    3476:	fff7041b          	addiw	s0,a4,-1
            if (!flag_left)
    347a:	3c0a0463          	beqz	s4,3842 <_vprintf_core.constprop.0.isra.0+0x710>
            _out_char(ctx, c);
    347e:	85e6                	mv	a1,s9
    3480:	8526                	mv	a0,s1
    3482:	e3dfd0ef          	jal	12be <_out_char>
                for (int i = 0; i < padding; i++)
    3486:	4a01                	li	s4,0
    3488:	d451                	beqz	s0,3414 <_vprintf_core.constprop.0.isra.0+0x2e2>
                    _out_char(ctx, ' ');
    348a:	02000593          	li	a1,32
    348e:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    3490:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    3492:	e2dfd0ef          	jal	12be <_out_char>
                for (int i = 0; i < padding; i++)
    3496:	ff441ae3          	bne	s0,s4,348a <_vprintf_core.constprop.0.isra.0+0x358>
            const char *s = va_arg(ap, char *);
    349a:	0c21                	addi	s8,s8,8
    349c:	b9d1                	j	3170 <_vprintf_core.constprop.0.isra.0+0x3e>
    349e:	f9bc861b          	addiw	a2,s9,-101
    34a2:	0ff67613          	zext.b	a2,a2
    34a6:	46cd                	li	a3,19
    34a8:	40c6e963          	bltu	a3,a2,38ba <_vprintf_core.constprop.0.isra.0+0x788>
    34ac:	00091337          	lui	t1,0x91
    34b0:	4685                	li	a3,1
    34b2:	00c696b3          	sll	a3,a3,a2
    34b6:	81030313          	addi	t1,t1,-2032 # 90810 <_ZSt4cerr+0x88e98>
    34ba:	0066f333          	and	t1,a3,t1
    34be:	34031c63          	bnez	t1,3816 <_vprintf_core.constprop.0.isra.0+0x6e4>
    34c2:	8a9d                	andi	a3,a3,7
    34c4:	d6069de3          	bnez	a3,323e <_vprintf_core.constprop.0.isra.0+0x10c>
    34c8:	46b9                	li	a3,14
        char spec = *p++;
    34ca:	8dbe                	mv	s11,a5
    34cc:	eed60ee3          	beq	a2,a3,33c8 <_vprintf_core.constprop.0.isra.0+0x296>
            _out_char(ctx, '%');
    34d0:	02500593          	li	a1,37
    34d4:	8526                	mv	a0,s1
    34d6:	de9fd0ef          	jal	12be <_out_char>
                _out_char(ctx, spec);
    34da:	85e6                	mv	a1,s9
    34dc:	b179                	j	316a <_vprintf_core.constprop.0.isra.0+0x38>
                while (*p >= '0' && *p <= '9')
    34de:	fd0c869b          	addiw	a3,s9,-48
    34e2:	0ff6fe13          	zext.b	t3,a3
    34e6:	4625                	li	a2,9
            p++;
    34e8:	0d85                	addi	s11,s11,1
                precision = 0;
    34ea:	4b81                	li	s7,0
                while (*p >= '0' && *p <= '9')
    34ec:	4325                	li	t1,9
    34ee:	cdc66de3          	bltu	a2,t3,31c8 <_vprintf_core.constprop.0.isra.0+0x96>
                    precision = precision * 10 + (*p - '0');
    34f2:	002b961b          	slliw	a2,s7,0x2
                while (*p >= '0' && *p <= '9')
    34f6:	001dcc83          	lbu	s9,1(s11)
                    precision = precision * 10 + (*p - '0');
    34fa:	0176073b          	addw	a4,a2,s7
    34fe:	0017171b          	slliw	a4,a4,0x1
    3502:	00e68bbb          	addw	s7,a3,a4
                while (*p >= '0' && *p <= '9')
    3506:	fd0c869b          	addiw	a3,s9,-48
    350a:	0ff6f613          	zext.b	a2,a3
                    p++;
    350e:	0d85                	addi	s11,s11,1
                while (*p >= '0' && *p <= '9')
    3510:	fec371e3          	bgeu	t1,a2,34f2 <_vprintf_core.constprop.0.isra.0+0x3c0>
    3514:	b955                	j	31c8 <_vprintf_core.constprop.0.isra.0+0x96>
    3516:	05800693          	li	a3,88
    351a:	3cdc8d63          	beq	s9,a3,38f4 <_vprintf_core.constprop.0.isra.0+0x7c2>
    351e:	06300713          	li	a4,99
        char spec = *p++;
    3522:	8dbe                	mv	s11,a5
    3524:	f4ec83e3          	beq	s9,a4,346a <_vprintf_core.constprop.0.isra.0+0x338>
    3528:	b765                	j	34d0 <_vprintf_core.constprop.0.isra.0+0x39e>
                f_idx += sprintf(&fmt_tmp[f_idx], ".%d", precision);
    352a:	01aa0533          	add	a0,s4,s10
    352e:	865e                	mv	a2,s7
    3530:	00002597          	auipc	a1,0x2
    3534:	c9058593          	addi	a1,a1,-880 # 51c0 <_GLOBAL__sub_I__ZSt3cin+0xfa>
    3538:	ba5ff0ef          	jal	30dc <sprintf>
    353c:	00ad0d3b          	addw	s10,s10,a0
    3540:	b341                	j	32c0 <_vprintf_core.constprop.0.isra.0+0x18e>
                f_idx += sprintf(&fmt_tmp[f_idx], "%d", width);
    3542:	01aa0533          	add	a0,s4,s10
    3546:	8622                	mv	a2,s0
    3548:	00002597          	auipc	a1,0x2
    354c:	c7058593          	addi	a1,a1,-912 # 51b8 <_GLOBAL__sub_I__ZSt3cin+0xf2>
    3550:	b8dff0ef          	jal	30dc <sprintf>
    3554:	00ad0d3b          	addw	s10,s10,a0
            if (precision >= 0)
    3558:	d60bc4e3          	bltz	s7,32c0 <_vprintf_core.constprop.0.isra.0+0x18e>
    355c:	b7f9                	j	352a <_vprintf_core.constprop.0.isra.0+0x3f8>
            int is_signed = (spec == 'd' || spec == 'i');
    355e:	06900693          	li	a3,105
    3562:	10dc8e63          	beq	s9,a3,367e <_vprintf_core.constprop.0.isra.0+0x54c>
                val = (uint64)va_arg(ap, void *);
    3566:	008c0793          	addi	a5,s8,8
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    356a:	07800693          	li	a3,120
                val = (uint64)va_arg(ap, void *);
    356e:	e43e                	sd	a5,8(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3570:	38dc9d63          	bne	s9,a3,390a <_vprintf_core.constprop.0.isra.0+0x7d8>
            else if (len_mod == 1)
    3574:	33ce8963          	beq	t4,t3,38a6 <_vprintf_core.constprop.0.isra.0+0x774>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    3578:	000c6e03          	lwu	t3,0(s8)
    357c:	85f6                	mv	a1,t4
    357e:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3580:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    3582:	00002f97          	auipc	t6,0x2
    3586:	c06f8f93          	addi	t6,t6,-1018 # 5188 <_GLOBAL__sub_I__ZSt3cin+0xc2>
    if (val == 0)
    358a:	120e0363          	beqz	t3,36b0 <_vprintf_core.constprop.0.isra.0+0x57e>
    358e:	01010293          	addi	t0,sp,16
                    sign_char = '-';
    3592:	8616                	mv	a2,t0
    3594:	86f2                	mv	a3,t3
        buf[i++] = digits[val % base];
    3596:	0266f8b3          	remu	a7,a3,t1
    359a:	8f32                	mv	t5,a2
    while (val != 0)
    359c:	0605                	addi	a2,a2,1
    359e:	8eb6                	mv	t4,a3
        buf[i++] = digits[val % base];
    35a0:	98fe                	add	a7,a7,t6
    35a2:	0008c883          	lbu	a7,0(a7)
        val /= base;
    35a6:	0266d6b3          	divu	a3,a3,t1
        buf[i++] = digits[val % base];
    35aa:	ff160fa3          	sb	a7,-1(a2)
    while (val != 0)
    35ae:	fe6ef4e3          	bgeu	t4,t1,3596 <_vprintf_core.constprop.0.isra.0+0x464>
        buf[i++] = digits[val % base];
    35b2:	405f0f3b          	subw	t5,t5,t0
    35b6:	2f05                	addiw	t5,t5,1
            if (precision >= 0)
    35b8:	100bc363          	bltz	s7,36be <_vprintf_core.constprop.0.isra.0+0x58c>
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    35bc:	1d7f4d63          	blt	t5,s7,3796 <_vprintf_core.constprop.0.isra.0+0x664>
            if (precision == 0 && val == 0)
    35c0:	340b9163          	bnez	s7,3902 <_vprintf_core.constprop.0.isra.0+0x7d0>
    35c4:	200e0763          	beqz	t3,37d2 <_vprintf_core.constprop.0.isra.0+0x6a0>
            for (int i = digit_len - 1; i >= 0; i--)
    35c8:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    35cc:	07000693          	li	a3,112
            for (int i = digit_len - 1; i >= 0; i--)
    35d0:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    35d2:	28dc8e63          	beq	s9,a3,386e <_vprintf_core.constprop.0.isra.0+0x73c>
    35d6:	2a051663          	bnez	a0,3882 <_vprintf_core.constprop.0.isra.0+0x750>
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    35da:	00bf05bb          	addw	a1,t5,a1
    35de:	8d52                	mv	s10,s4
    35e0:	4b01                	li	s6,0
            char *prefix_str = NULL;
    35e2:	4c81                	li	s9,0
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    35e4:	1085d263          	bge	a1,s0,36e8 <_vprintf_core.constprop.0.isra.0+0x5b6>
    35e8:	9c0d                	subw	s0,s0,a1
            if (!flag_left && !flag_zero)
    35ea:	100d0a63          	beqz	s10,36fe <_vprintf_core.constprop.0.isra.0+0x5cc>
            if (sign_char)
    35ee:	6782                	ld	a5,0(sp)
    35f0:	10079263          	bnez	a5,36f4 <_vprintf_core.constprop.0.isra.0+0x5c2>
            if (prefix_str)
    35f4:	000c8c63          	beqz	s9,360c <_vprintf_core.constprop.0.isra.0+0x4da>
                _out_char(ctx, prefix_str[0]);
    35f8:	000cc583          	lbu	a1,0(s9)
    35fc:	8526                	mv	a0,s1
    35fe:	cc1fd0ef          	jal	12be <_out_char>
                _out_char(ctx, prefix_str[1]);
    3602:	001cc583          	lbu	a1,1(s9)
    3606:	8526                	mv	a0,s1
    3608:	cb7fd0ef          	jal	12be <_out_char>
            int total_zeros = prec_zeros + ((flag_zero && !flag_left) ? padding : 0);
    360c:	180b0263          	beqz	s6,3790 <_vprintf_core.constprop.0.isra.0+0x65e>
    3610:	100a1863          	bnez	s4,3720 <_vprintf_core.constprop.0.isra.0+0x5ee>
    3614:	008b8bbb          	addw	s7,s7,s0
            for (int i = 0; i < total_zeros; i++)
    3618:	2a0b8363          	beqz	s7,38be <_vprintf_core.constprop.0.isra.0+0x78c>
    361c:	4c81                	li	s9,0
                _out_char(ctx, '0');
    361e:	03000593          	li	a1,48
    3622:	8526                	mv	a0,s1
            for (int i = 0; i < total_zeros; i++)
    3624:	2c85                	addiw	s9,s9,1
                _out_char(ctx, '0');
    3626:	c99fd0ef          	jal	12be <_out_char>
            for (int i = 0; i < total_zeros; i++)
    362a:	ff7c9ae3          	bne	s9,s7,361e <_vprintf_core.constprop.0.isra.0+0x4ec>
            for (int i = digit_len - 1; i >= 0; i--)
    362e:	57fd                	li	a5,-1
    3630:	00fc0f63          	beq	s8,a5,364e <_vprintf_core.constprop.0.isra.0+0x51c>
    3634:	01010c93          	addi	s9,sp,16
    3638:	9ce2                	add	s9,s9,s8
    363a:	00f10c13          	addi	s8,sp,15
                _out_char(ctx, num_buf[i]);
    363e:	000cc583          	lbu	a1,0(s9)
    3642:	8526                	mv	a0,s1
            for (int i = digit_len - 1; i >= 0; i--)
    3644:	1cfd                	addi	s9,s9,-1
                _out_char(ctx, num_buf[i]);
    3646:	c79fd0ef          	jal	12be <_out_char>
            for (int i = digit_len - 1; i >= 0; i--)
    364a:	ff9c1ae3          	bne	s8,s9,363e <_vprintf_core.constprop.0.isra.0+0x50c>
            if (flag_left)
    364e:	0c0a1e63          	bnez	s4,372a <_vprintf_core.constprop.0.isra.0+0x5f8>
        char spec = *p++;
    3652:	6c22                	ld	s8,8(sp)
    3654:	be31                	j	3170 <_vprintf_core.constprop.0.isra.0+0x3e>
            int padding = (width > len) ? width - len : 0;
    3656:	4174043b          	subw	s0,s0,s7
            if (!flag_left)
    365a:	100a0a63          	beqz	s4,376e <_vprintf_core.constprop.0.isra.0+0x63c>
            for (int i = 0; i < len; i++)
    365e:	d80b9ce3          	bnez	s7,33f6 <_vprintf_core.constprop.0.isra.0+0x2c4>
                for (int i = 0; i < padding; i++)
    3662:	4a01                	li	s4,0
                    _out_char(ctx, ' ');
    3664:	02000593          	li	a1,32
    3668:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    366a:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    366c:	c53fd0ef          	jal	12be <_out_char>
                for (int i = 0; i < padding; i++)
    3670:	ff441ae3          	bne	s0,s4,3664 <_vprintf_core.constprop.0.isra.0+0x532>
            const char *s = va_arg(ap, char *);
    3674:	0c21                	addi	s8,s8,8
    3676:	bced                	j	3170 <_vprintf_core.constprop.0.isra.0+0x3e>
                for (int i = 0; i < padding; i++)
    3678:	f46d                	bnez	s0,3662 <_vprintf_core.constprop.0.isra.0+0x530>
            const char *s = va_arg(ap, char *);
    367a:	0c21                	addi	s8,s8,8
    367c:	bcd5                	j	3170 <_vprintf_core.constprop.0.isra.0+0x3e>
            else if (len_mod == 1)
    367e:	1fce8163          	beq	t4,t3,3860 <_vprintf_core.constprop.0.isra.0+0x72e>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    3682:	000c2e03          	lw	t3,0(s8)
    3686:	008c0793          	addi	a5,s8,8
    368a:	e43e                	sd	a5,8(sp)
                int64 sval = (int64)val;
    368c:	86f2                	mv	a3,t3
                if (sval < 0)
    368e:	1406cb63          	bltz	a3,37e4 <_vprintf_core.constprop.0.isra.0+0x6b2>
                    sign_char = '+';
    3692:	02b00793          	li	a5,43
    3696:	e03e                	sd	a5,0(sp)
                else if (flag_plus)
    3698:	e589                	bnez	a1,36a2 <_vprintf_core.constprop.0.isra.0+0x570>
                else if (flag_space)
    369a:	00589793          	slli	a5,a7,0x5
    369e:	e03e                	sd	a5,0(sp)
    36a0:	85c6                	mv	a1,a7
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    36a2:	4329                	li	t1,10
    36a4:	00002f97          	auipc	t6,0x2
    36a8:	ae4f8f93          	addi	t6,t6,-1308 # 5188 <_GLOBAL__sub_I__ZSt3cin+0xc2>
    if (val == 0)
    36ac:	ee0e11e3          	bnez	t3,358e <_vprintf_core.constprop.0.isra.0+0x45c>
        buf[i++] = '0';
    36b0:	03000693          	li	a3,48
    36b4:	00d10823          	sb	a3,16(sp)
        return i;
    36b8:	4f05                	li	t5,1
            if (precision >= 0)
    36ba:	f00bd1e3          	bgez	s7,35bc <_vprintf_core.constprop.0.isra.0+0x48a>
            for (int i = digit_len - 1; i >= 0; i--)
    36be:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    36c2:	07000893          	li	a7,112
            if (!flag_left && !flag_zero)
    36c6:	016a6d33          	or	s10,s4,s6
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    36ca:	4b81                	li	s7,0
            for (int i = digit_len - 1; i >= 0; i--)
    36cc:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    36ce:	0d1c9f63          	bne	s9,a7,37ac <_vprintf_core.constprop.0.isra.0+0x67a>
                prefix_str = (spec == 'X') ? "0X" : "0x";
    36d2:	00002c97          	auipc	s9,0x2
    36d6:	acec8c93          	addi	s9,s9,-1330 # 51a0 <_GLOBAL__sub_I__ZSt3cin+0xda>
                prefix_len += 2;
    36da:	2589                	addiw	a1,a1,2
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    36dc:	017585bb          	addw	a1,a1,s7
    36e0:	01e585bb          	addw	a1,a1,t5
    36e4:	f085c2e3          	blt	a1,s0,35e8 <_vprintf_core.constprop.0.isra.0+0x4b6>
            if (!flag_left && !flag_zero)
    36e8:	080d0f63          	beqz	s10,3786 <_vprintf_core.constprop.0.isra.0+0x654>
            if (sign_char)
    36ec:	6782                	ld	a5,0(sp)
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    36ee:	4401                	li	s0,0
            if (sign_char)
    36f0:	f00782e3          	beqz	a5,35f4 <_vprintf_core.constprop.0.isra.0+0x4c2>
                _out_char(ctx, sign_char);
    36f4:	6582                	ld	a1,0(sp)
    36f6:	8526                	mv	a0,s1
    36f8:	bc7fd0ef          	jal	12be <_out_char>
    36fc:	bde5                	j	35f4 <_vprintf_core.constprop.0.isra.0+0x4c2>
                    _out_char(ctx, ' ');
    36fe:	02000593          	li	a1,32
    3702:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    3704:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    3706:	bb9fd0ef          	jal	12be <_out_char>
                for (int i = 0; i < padding; i++)
    370a:	efa402e3          	beq	s0,s10,35ee <_vprintf_core.constprop.0.isra.0+0x4bc>
                    _out_char(ctx, ' ');
    370e:	02000593          	li	a1,32
    3712:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    3714:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    3716:	ba9fd0ef          	jal	12be <_out_char>
                for (int i = 0; i < padding; i++)
    371a:	ffa412e3          	bne	s0,s10,36fe <_vprintf_core.constprop.0.isra.0+0x5cc>
    371e:	bdc1                	j	35ee <_vprintf_core.constprop.0.isra.0+0x4bc>
            for (int i = 0; i < total_zeros; i++)
    3720:	ee0b9ee3          	bnez	s7,361c <_vprintf_core.constprop.0.isra.0+0x4ea>
            for (int i = digit_len - 1; i >= 0; i--)
    3724:	577d                	li	a4,-1
    3726:	f0ec17e3          	bne	s8,a4,3634 <_vprintf_core.constprop.0.isra.0+0x502>
                for (int i = 0; i < padding; i++)
    372a:	d405                	beqz	s0,3652 <_vprintf_core.constprop.0.isra.0+0x520>
    372c:	4a01                	li	s4,0
                    _out_char(ctx, ' ');
    372e:	02000593          	li	a1,32
    3732:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    3734:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    3736:	b89fd0ef          	jal	12be <_out_char>
                for (int i = 0; i < padding; i++)
    373a:	fe8a1ae3          	bne	s4,s0,372e <_vprintf_core.constprop.0.isra.0+0x5fc>
        char spec = *p++;
    373e:	6c22                	ld	s8,8(sp)
    3740:	bc05                	j	3170 <_vprintf_core.constprop.0.isra.0+0x3e>
                val = (uint64)va_arg(ap, void *);
    3742:	008c0793          	addi	a5,s8,8
    3746:	e43e                	sd	a5,8(sp)
            else if (len_mod == 1)
    3748:	180e9163          	bnez	t4,38ca <_vprintf_core.constprop.0.isra.0+0x798>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    374c:	000c6e03          	lwu	t3,0(s8)
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    3750:	4581                	li	a1,0
    3752:	05800c93          	li	s9,88
    3756:	e002                	sd	zero,0(sp)
    3758:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    375a:	00002f97          	auipc	t6,0x2
    375e:	a16f8f93          	addi	t6,t6,-1514 # 5170 <_GLOBAL__sub_I__ZSt3cin+0xaa>
    3762:	b525                	j	358a <_vprintf_core.constprop.0.isra.0+0x458>
            int padding = (width > len) ? width - len : 0;
    3764:	ca8058e3          	blez	s0,3414 <_vprintf_core.constprop.0.isra.0+0x2e2>
            if (!flag_left)
    3768:	ee0a1de3          	bnez	s4,3662 <_vprintf_core.constprop.0.isra.0+0x530>
            int len = 0;
    376c:	4b81                	li	s7,0
                for (int i = 0; i < padding; i++)
    376e:	4d01                	li	s10,0
                    _out_char(ctx, ' ');
    3770:	02000593          	li	a1,32
    3774:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    3776:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    3778:	b47fd0ef          	jal	12be <_out_char>
                for (int i = 0; i < padding; i++)
    377c:	fe8d1ae3          	bne	s10,s0,3770 <_vprintf_core.constprop.0.isra.0+0x63e>
            for (int i = 0; i < len; i++)
    3780:	c60b9be3          	bnez	s7,33f6 <_vprintf_core.constprop.0.isra.0+0x2c4>
    3784:	b941                	j	3414 <_vprintf_core.constprop.0.isra.0+0x2e2>
            if (sign_char)
    3786:	6782                	ld	a5,0(sp)
    3788:	4401                	li	s0,0
    378a:	f7ad                	bnez	a5,36f4 <_vprintf_core.constprop.0.isra.0+0x5c2>
            if (prefix_str)
    378c:	e60c96e3          	bnez	s9,35f8 <_vprintf_core.constprop.0.isra.0+0x4c6>
            for (int i = 0; i < total_zeros; i++)
    3790:	e80b96e3          	bnez	s7,361c <_vprintf_core.constprop.0.isra.0+0x4ea>
    3794:	bd69                	j	362e <_vprintf_core.constprop.0.isra.0+0x4fc>
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    3796:	41eb8bbb          	subw	s7,s7,t5
    379a:	8d52                	mv	s10,s4
    379c:	4b01                	li	s6,0
            for (int i = digit_len - 1; i >= 0; i--)
    379e:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    37a2:	07000893          	li	a7,112
            for (int i = digit_len - 1; i >= 0; i--)
    37a6:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    37a8:	f31c85e3          	beq	s9,a7,36d2 <_vprintf_core.constprop.0.isra.0+0x5a0>
    37ac:	cd09                	beqz	a0,37c6 <_vprintf_core.constprop.0.isra.0+0x694>
    37ae:	000e0c63          	beqz	t3,37c6 <_vprintf_core.constprop.0.isra.0+0x694>
    37b2:	07800513          	li	a0,120
            for (int i = digit_len - 1; i >= 0; i--)
    37b6:	00060c1b          	sext.w	s8,a2
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    37ba:	f0ac8ce3          	beq	s9,a0,36d2 <_vprintf_core.constprop.0.isra.0+0x5a0>
    37be:	05800613          	li	a2,88
    37c2:	12cc8463          	beq	s9,a2,38ea <_vprintf_core.constprop.0.isra.0+0x7b8>
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    37c6:	00bb85bb          	addw	a1,s7,a1
    37ca:	01e585bb          	addw	a1,a1,t5
            char *prefix_str = NULL;
    37ce:	4c81                	li	s9,0
    37d0:	bd11                	j	35e4 <_vprintf_core.constprop.0.isra.0+0x4b2>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    37d2:	07000693          	li	a3,112
    37d6:	8d52                	mv	s10,s4
    37d8:	4b01                	li	s6,0
    37da:	08dc8d63          	beq	s9,a3,3874 <_vprintf_core.constprop.0.isra.0+0x742>
    37de:	5c7d                	li	s8,-1
            char *prefix_str = NULL;
    37e0:	4c81                	li	s9,0
    37e2:	b509                	j	35e4 <_vprintf_core.constprop.0.isra.0+0x4b2>
                    sign_char = '-';
    37e4:	02d00793          	li	a5,45
                    val = (uint64)(-sval);
    37e8:	40d00e33          	neg	t3,a3
    37ec:	4585                	li	a1,1
    37ee:	4329                	li	t1,10
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    37f0:	00002f97          	auipc	t6,0x2
    37f4:	998f8f93          	addi	t6,t6,-1640 # 5188 <_GLOBAL__sub_I__ZSt3cin+0xc2>
                    sign_char = '-';
    37f8:	e03e                	sd	a5,0(sp)
    37fa:	bb51                	j	358e <_vprintf_core.constprop.0.isra.0+0x45c>
                s = "(null)";
    37fc:	00002c97          	auipc	s9,0x2
    3800:	9b4c8c93          	addi	s9,s9,-1612 # 51b0 <_GLOBAL__sub_I__ZSt3cin+0xea>
    3804:	bed1                	j	33d8 <_vprintf_core.constprop.0.isra.0+0x2a6>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    3806:	000c3683          	ld	a3,0(s8)
    380a:	008c0713          	addi	a4,s8,8
    380e:	e43a                	sd	a4,8(sp)
    3810:	8dbe                	mv	s11,a5
    3812:	8e36                	mv	t3,a3
            if (is_signed)
    3814:	bdad                	j	368e <_vprintf_core.constprop.0.isra.0+0x55c>
            int is_signed = (spec == 'd' || spec == 'i');
    3816:	06900693          	li	a3,105
    381a:	fedc86e3          	beq	s9,a3,3806 <_vprintf_core.constprop.0.isra.0+0x6d4>
                val = (uint64)va_arg(ap, void *);
    381e:	008c0713          	addi	a4,s8,8
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3822:	07800693          	li	a3,120
                val = (uint64)va_arg(ap, void *);
    3826:	e43a                	sd	a4,8(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3828:	06dc9063          	bne	s9,a3,3888 <_vprintf_core.constprop.0.isra.0+0x756>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    382c:	000c3e03          	ld	t3,0(s8)
    3830:	8dbe                	mv	s11,a5
    3832:	4581                	li	a1,0
    3834:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3836:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    3838:	00002f97          	auipc	t6,0x2
    383c:	950f8f93          	addi	t6,t6,-1712 # 5188 <_GLOBAL__sub_I__ZSt3cin+0xc2>
    3840:	b3a9                	j	358a <_vprintf_core.constprop.0.isra.0+0x458>
                for (int i = 0; i < padding; i++)
    3842:	c809                	beqz	s0,3854 <_vprintf_core.constprop.0.isra.0+0x722>
                    _out_char(ctx, ' ');
    3844:	02000593          	li	a1,32
    3848:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    384a:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    384c:	a73fd0ef          	jal	12be <_out_char>
                for (int i = 0; i < padding; i++)
    3850:	ff441ae3          	bne	s0,s4,3844 <_vprintf_core.constprop.0.isra.0+0x712>
            _out_char(ctx, c);
    3854:	85e6                	mv	a1,s9
    3856:	8526                	mv	a0,s1
    3858:	a67fd0ef          	jal	12be <_out_char>
            const char *s = va_arg(ap, char *);
    385c:	0c21                	addi	s8,s8,8
    385e:	ba09                	j	3170 <_vprintf_core.constprop.0.isra.0+0x3e>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    3860:	000c3683          	ld	a3,0(s8)
    3864:	008c0793          	addi	a5,s8,8
    3868:	e43e                	sd	a5,8(sp)
    386a:	8e36                	mv	t3,a3
            if (is_signed)
    386c:	b50d                	j	368e <_vprintf_core.constprop.0.isra.0+0x55c>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    386e:	8d52                	mv	s10,s4
    3870:	4b01                	li	s6,0
    3872:	b585                	j	36d2 <_vprintf_core.constprop.0.isra.0+0x5a0>
                digit_len = 0;
    3874:	4f01                	li	t5,0
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    3876:	5c7d                	li	s8,-1
                prefix_str = (spec == 'X') ? "0X" : "0x";
    3878:	00002c97          	auipc	s9,0x2
    387c:	928c8c93          	addi	s9,s9,-1752 # 51a0 <_GLOBAL__sub_I__ZSt3cin+0xda>
    3880:	bda9                	j	36da <_vprintf_core.constprop.0.isra.0+0x5a8>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    3882:	8d52                	mv	s10,s4
    3884:	4b01                	li	s6,0
    3886:	b735                	j	37b2 <_vprintf_core.constprop.0.isra.0+0x680>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    3888:	07000693          	li	a3,112
    388c:	04dc8263          	beq	s9,a3,38d0 <_vprintf_core.constprop.0.isra.0+0x79e>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    3890:	000c3e03          	ld	t3,0(s8)
    3894:	8dbe                	mv	s11,a5
    3896:	4581                	li	a1,0
    3898:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    389a:	4329                	li	t1,10
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    389c:	00002f97          	auipc	t6,0x2
    38a0:	8ecf8f93          	addi	t6,t6,-1812 # 5188 <_GLOBAL__sub_I__ZSt3cin+0xc2>
    38a4:	b1dd                	j	358a <_vprintf_core.constprop.0.isra.0+0x458>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    38a6:	000c3e03          	ld	t3,0(s8)
    38aa:	4581                	li	a1,0
    38ac:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    38ae:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    38b0:	00002f97          	auipc	t6,0x2
    38b4:	8d8f8f93          	addi	t6,t6,-1832 # 5188 <_GLOBAL__sub_I__ZSt3cin+0xc2>
    38b8:	b9c9                	j	358a <_vprintf_core.constprop.0.isra.0+0x458>
        char spec = *p++;
    38ba:	8dbe                	mv	s11,a5
    38bc:	b911                	j	34d0 <_vprintf_core.constprop.0.isra.0+0x39e>
            for (int i = digit_len - 1; i >= 0; i--)
    38be:	577d                	li	a4,-1
    38c0:	4401                	li	s0,0
    38c2:	d6ec19e3          	bne	s8,a4,3634 <_vprintf_core.constprop.0.isra.0+0x502>
        char spec = *p++;
    38c6:	6c22                	ld	s8,8(sp)
    38c8:	b065                	j	3170 <_vprintf_core.constprop.0.isra.0+0x3e>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    38ca:	000c3e03          	ld	t3,0(s8)
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    38ce:	b549                	j	3750 <_vprintf_core.constprop.0.isra.0+0x61e>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    38d0:	8dbe                	mv	s11,a5
                val = (uint64)va_arg(ap, void *);
    38d2:	000c3e03          	ld	t3,0(s8)
    38d6:	4581                	li	a1,0
    38d8:	07000c93          	li	s9,112
    38dc:	e002                	sd	zero,0(sp)
    38de:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    38e0:	00002f97          	auipc	t6,0x2
    38e4:	8a8f8f93          	addi	t6,t6,-1880 # 5188 <_GLOBAL__sub_I__ZSt3cin+0xc2>
    38e8:	b14d                	j	358a <_vprintf_core.constprop.0.isra.0+0x458>
                prefix_str = (spec == 'X') ? "0X" : "0x";
    38ea:	00002c97          	auipc	s9,0x2
    38ee:	8bec8c93          	addi	s9,s9,-1858 # 51a8 <_GLOBAL__sub_I__ZSt3cin+0xe2>
    38f2:	b3e5                	j	36da <_vprintf_core.constprop.0.isra.0+0x5a8>
                val = (uint64)va_arg(ap, void *);
    38f4:	008c0713          	addi	a4,s8,8
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    38f8:	000c3e03          	ld	t3,0(s8)
                val = (uint64)va_arg(ap, void *);
    38fc:	e43a                	sd	a4,8(sp)
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    38fe:	8dbe                	mv	s11,a5
    3900:	bd81                	j	3750 <_vprintf_core.constprop.0.isra.0+0x61e>
    3902:	8d52                	mv	s10,s4
    3904:	4b01                	li	s6,0
    3906:	4b81                	li	s7,0
    3908:	bd59                	j	379e <_vprintf_core.constprop.0.isra.0+0x66c>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    390a:	07000693          	li	a3,112
    390e:	fcdc82e3          	beq	s9,a3,38d2 <_vprintf_core.constprop.0.isra.0+0x7a0>
            else if (len_mod == 1)
    3912:	01ce8c63          	beq	t4,t3,392a <_vprintf_core.constprop.0.isra.0+0x7f8>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    3916:	000c6e03          	lwu	t3,0(s8)
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    391a:	4581                	li	a1,0
    391c:	e002                	sd	zero,0(sp)
    391e:	4329                	li	t1,10
    3920:	00002f97          	auipc	t6,0x2
    3924:	868f8f93          	addi	t6,t6,-1944 # 5188 <_GLOBAL__sub_I__ZSt3cin+0xc2>
    3928:	b18d                	j	358a <_vprintf_core.constprop.0.isra.0+0x458>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    392a:	000c3e03          	ld	t3,0(s8)
            if (is_signed)
    392e:	b7f5                	j	391a <_vprintf_core.constprop.0.isra.0+0x7e8>

0000000000003930 <vsnprintf>:
{
    3930:	7139                	addi	sp,sp,-64
    3932:	f822                	sd	s0,48(sp)
    3934:	f426                	sd	s1,40(sp)
    3936:	842e                	mv	s0,a1
    3938:	84aa                	mv	s1,a0
    393a:	85b2                	mv	a1,a2
    _vprintf_core(&ctx, format, ap);
    393c:	850a                	mv	a0,sp
    393e:	8636                	mv	a2,a3
{
    3940:	fc06                	sd	ra,56(sp)
    ctx.buf = str;
    3942:	e026                	sd	s1,0(sp)
    ctx.limit = size;
    3944:	e422                	sd	s0,8(sp)
    ctx.written = 0;
    3946:	e802                	sd	zero,16(sp)
    ctx.stream = NULL;
    3948:	ec02                	sd	zero,24(sp)
    _vprintf_core(&ctx, format, ap);
    394a:	fe8ff0ef          	jal	3132 <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    394e:	6542                	ld	a0,16(sp)
    if (size > 0)
    3950:	c411                	beqz	s0,395c <vsnprintf+0x2c>
        if (ctx.written < size)
    3952:	00857b63          	bgeu	a0,s0,3968 <vsnprintf+0x38>
            str[ctx.written] = '\0';
    3956:	94aa                	add	s1,s1,a0
    3958:	00048023          	sb	zero,0(s1)
}
    395c:	70e2                	ld	ra,56(sp)
    395e:	7442                	ld	s0,48(sp)
    3960:	74a2                	ld	s1,40(sp)
    3962:	2501                	sext.w	a0,a0
    3964:	6121                	addi	sp,sp,64
    3966:	8082                	ret
            str[size - 1] = '\0';
    3968:	94a2                	add	s1,s1,s0
    396a:	fe048fa3          	sb	zero,-1(s1)
}
    396e:	70e2                	ld	ra,56(sp)
    3970:	7442                	ld	s0,48(sp)
    3972:	74a2                	ld	s1,40(sp)
    3974:	2501                	sext.w	a0,a0
    3976:	6121                	addi	sp,sp,64
    3978:	8082                	ret

000000000000397a <snprintf>:
{
    397a:	7119                	addi	sp,sp,-128
    397c:	e0a2                	sd	s0,64(sp)
    397e:	fc26                	sd	s1,56(sp)
    3980:	842e                	mv	s0,a1
    3982:	84aa                	mv	s1,a0
    3984:	85b2                	mv	a1,a2
    _vprintf_core(&ctx, format, ap);
    3986:	0808                	addi	a0,sp,16
    va_start(ap, format);
    3988:	08b0                	addi	a2,sp,88
{
    398a:	e486                	sd	ra,72(sp)
    398c:	ecb6                	sd	a3,88(sp)
    398e:	f0ba                	sd	a4,96(sp)
    3990:	f4be                	sd	a5,104(sp)
    3992:	f8c2                	sd	a6,112(sp)
    3994:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    3996:	e432                	sd	a2,8(sp)
    ctx.buf = str;
    3998:	e826                	sd	s1,16(sp)
    ctx.limit = size;
    399a:	ec22                	sd	s0,24(sp)
    ctx.written = 0;
    399c:	f002                	sd	zero,32(sp)
    ctx.stream = NULL;
    399e:	f402                	sd	zero,40(sp)
    _vprintf_core(&ctx, format, ap);
    39a0:	f92ff0ef          	jal	3132 <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    39a4:	7502                	ld	a0,32(sp)
    if (size > 0)
    39a6:	c411                	beqz	s0,39b2 <snprintf+0x38>
        if (ctx.written < size)
    39a8:	00857b63          	bgeu	a0,s0,39be <snprintf+0x44>
            str[ctx.written] = '\0';
    39ac:	94aa                	add	s1,s1,a0
    39ae:	00048023          	sb	zero,0(s1)
}
    39b2:	60a6                	ld	ra,72(sp)
    39b4:	6406                	ld	s0,64(sp)
    39b6:	74e2                	ld	s1,56(sp)
    39b8:	2501                	sext.w	a0,a0
    39ba:	6109                	addi	sp,sp,128
    39bc:	8082                	ret
            str[size - 1] = '\0';
    39be:	94a2                	add	s1,s1,s0
    39c0:	fe048fa3          	sb	zero,-1(s1)
}
    39c4:	60a6                	ld	ra,72(sp)
    39c6:	6406                	ld	s0,64(sp)
    39c8:	74e2                	ld	s1,56(sp)
    39ca:	2501                	sext.w	a0,a0
    39cc:	6109                	addi	sp,sp,128
    39ce:	8082                	ret

00000000000039d0 <printf>:
{
    39d0:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    39d2:	04810313          	addi	t1,sp,72
{
    39d6:	e4ae                	sd	a1,72(sp)
    39d8:	e8b2                	sd	a2,80(sp)
    39da:	f4be                	sd	a5,104(sp)
    _vprintf_core(&ctx, format, ap);
    39dc:	85aa                	mv	a1,a0
    ctx.stream = stdout;
    39de:	00004797          	auipc	a5,0x4
    39e2:	e027b783          	ld	a5,-510(a5) # 77e0 <stdout>
    _vprintf_core(&ctx, format, ap);
    39e6:	0808                	addi	a0,sp,16
    39e8:	861a                	mv	a2,t1
{
    39ea:	fc06                	sd	ra,56(sp)
    39ec:	ecb6                	sd	a3,88(sp)
    39ee:	f0ba                	sd	a4,96(sp)
    39f0:	f8c2                	sd	a6,112(sp)
    39f2:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    39f4:	e41a                	sd	t1,8(sp)
    ctx.buf = NULL;
    39f6:	e802                	sd	zero,16(sp)
    ctx.limit = 0;
    39f8:	ec02                	sd	zero,24(sp)
    ctx.written = 0;
    39fa:	f002                	sd	zero,32(sp)
    ctx.stream = stdout;
    39fc:	f43e                	sd	a5,40(sp)
    _vprintf_core(&ctx, format, ap);
    39fe:	f34ff0ef          	jal	3132 <_vprintf_core.constprop.0.isra.0>
}
    3a02:	70e2                	ld	ra,56(sp)
    3a04:	5502                	lw	a0,32(sp)
    3a06:	6109                	addi	sp,sp,128
    3a08:	8082                	ret

0000000000003a0a <sscanf>:
{
    3a0a:	7159                	addi	sp,sp,-112
    va_start(ap, format);
    3a0c:	04010e13          	addi	t3,sp,64
{
    3a10:	8eaa                	mv	t4,a0
    ctx.fd = -1;
    3a12:	537d                	li	t1,-1
{
    3a14:	e0b2                	sd	a2,64(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    3a16:	0808                	addi	a0,sp,16
    3a18:	8672                	mv	a2,t3
{
    3a1a:	fc06                	sd	ra,56(sp)
    3a1c:	e4b6                	sd	a3,72(sp)
    3a1e:	e8ba                	sd	a4,80(sp)
    3a20:	ecbe                	sd	a5,88(sp)
    3a22:	f0c2                	sd	a6,96(sp)
    3a24:	f4c6                	sd	a7,104(sp)
    va_start(ap, format);
    3a26:	e472                	sd	t3,8(sp)
    ctx.buf = str;
    3a28:	e876                	sd	t4,16(sp)
    ctx.fd = -1;
    3a2a:	cc1a                	sw	t1,24(sp)
    ctx.pos = 0;
    3a2c:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    3a2e:	d41a                	sw	t1,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    3a30:	81efd0ef          	jal	a4e <_vscanf_core.constprop.0>
}
    3a34:	70e2                	ld	ra,56(sp)
    3a36:	6165                	addi	sp,sp,112
    3a38:	8082                	ret

0000000000003a3a <scanf>:
{
    3a3a:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    3a3c:	04810313          	addi	t1,sp,72
{
    3a40:	e4ae                	sd	a1,72(sp)
    3a42:	e8b2                	sd	a2,80(sp)
    3a44:	f4be                	sd	a5,104(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    3a46:	85aa                	mv	a1,a0
    ctx.ungotten = -1;
    3a48:	57fd                	li	a5,-1
    int ret = _vscanf_core(&ctx, format, ap);
    3a4a:	0808                	addi	a0,sp,16
    3a4c:	861a                	mv	a2,t1
{
    3a4e:	fc06                	sd	ra,56(sp)
    3a50:	ecb6                	sd	a3,88(sp)
    3a52:	f0ba                	sd	a4,96(sp)
    3a54:	f8c2                	sd	a6,112(sp)
    3a56:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    3a58:	e41a                	sd	t1,8(sp)
    ctx.buf = NULL;
    3a5a:	e802                	sd	zero,16(sp)
    ctx.fd = STDIN_FD;
    3a5c:	cc02                	sw	zero,24(sp)
    ctx.pos = 0;
    3a5e:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    3a60:	d43e                	sw	a5,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    3a62:	fedfc0ef          	jal	a4e <_vscanf_core.constprop.0>
}
    3a66:	70e2                	ld	ra,56(sp)
    3a68:	6109                	addi	sp,sp,128
    3a6a:	8082                	ret

0000000000003a6c <fopen>:
{
    3a6c:	1101                	addi	sp,sp,-32
    3a6e:	e426                	sd	s1,8(sp)
    3a70:	84ae                	mv	s1,a1
    3a72:	e04a                	sd	s2,0(sp)
    if (strcmp(mode, "r") == 0)
    3a74:	00001597          	auipc	a1,0x1
    3a78:	75458593          	addi	a1,a1,1876 # 51c8 <_GLOBAL__sub_I__ZSt3cin+0x102>
{
    3a7c:	892a                	mv	s2,a0
    if (strcmp(mode, "r") == 0)
    3a7e:	8526                	mv	a0,s1
{
    3a80:	e822                	sd	s0,16(sp)
    3a82:	ec06                	sd	ra,24(sp)
    if (strcmp(mode, "r") == 0)
    3a84:	298010ef          	jal	4d1c <strcmp>
    3a88:	842a                	mv	s0,a0
    3a8a:	c919                	beqz	a0,3aa0 <fopen+0x34>
    else if (strcmp(mode, "w") == 0)
    3a8c:	00001597          	auipc	a1,0x1
    3a90:	74458593          	addi	a1,a1,1860 # 51d0 <_GLOBAL__sub_I__ZSt3cin+0x10a>
    3a94:	8526                	mv	a0,s1
    3a96:	286010ef          	jal	4d1c <strcmp>
        flags = O_WRONLY | O_CREAT | O_TRUNC;
    3a9a:	24100413          	li	s0,577
    else if (strcmp(mode, "w") == 0)
    3a9e:	ed39                	bnez	a0,3afc <fopen+0x90>
    int64 fd = open(filename, flags);
    3aa0:	85a2                	mv	a1,s0
    3aa2:	854a                	mv	a0,s2
    3aa4:	f42fc0ef          	jal	1e6 <open>
    3aa8:	84aa                	mv	s1,a0
    if (fd < 0)
    3aaa:	06054c63          	bltz	a0,3b22 <fopen+0xb6>
    FILE *f = (FILE *)malloc(sizeof(FILE));
    3aae:	42000513          	li	a0,1056
    3ab2:	2f3000ef          	jal	45a4 <malloc>
    3ab6:	892a                	mv	s2,a0
    if (!f)
    3ab8:	c53d                	beqz	a0,3b26 <fopen+0xba>
    memset(f, 0, sizeof(FILE));
    3aba:	42000613          	li	a2,1056
    3abe:	4581                	li	a1,0
    3ac0:	0ee010ef          	jal	4bae <memset>
    if (fd == 1)
    3ac4:	4785                	li	a5,1
    f->fd = (int)fd;
    3ac6:	00992023          	sw	s1,0(s2)
    f->flags = flags;
    3aca:	00892223          	sw	s0,4(s2)
    if (fd == 1)
    3ace:	00f48e63          	beq	s1,a5,3aea <fopen+0x7e>
    else if (fd == 2)
    3ad2:	4789                	li	a5,2
    3ad4:	00f48b63          	beq	s1,a5,3aea <fopen+0x7e>
        f->buf_mode = 0;
    3ad8:	40092e23          	sw	zero,1052(s2)
}
    3adc:	60e2                	ld	ra,24(sp)
    3ade:	6442                	ld	s0,16(sp)
    3ae0:	64a2                	ld	s1,8(sp)
    3ae2:	854a                	mv	a0,s2
    3ae4:	6902                	ld	s2,0(sp)
    3ae6:	6105                	addi	sp,sp,32
    3ae8:	8082                	ret
    3aea:	60e2                	ld	ra,24(sp)
    3aec:	6442                	ld	s0,16(sp)
        f->buf_mode = 2;
    3aee:	40992e23          	sw	s1,1052(s2)
}
    3af2:	854a                	mv	a0,s2
    3af4:	64a2                	ld	s1,8(sp)
    3af6:	6902                	ld	s2,0(sp)
    3af8:	6105                	addi	sp,sp,32
    3afa:	8082                	ret
    else if (strcmp(mode, "a") == 0)
    3afc:	00001597          	auipc	a1,0x1
    3b00:	6dc58593          	addi	a1,a1,1756 # 51d8 <_GLOBAL__sub_I__ZSt3cin+0x112>
    3b04:	8526                	mv	a0,s1
    3b06:	216010ef          	jal	4d1c <strcmp>
        flags = O_WRONLY | O_CREAT | O_APPEND;
    3b0a:	44100413          	li	s0,1089
    else if (strcmp(mode, "a") == 0)
    3b0e:	d949                	beqz	a0,3aa0 <fopen+0x34>
    else if (strcmp(mode, "r+") == 0)
    3b10:	00001597          	auipc	a1,0x1
    3b14:	6d058593          	addi	a1,a1,1744 # 51e0 <_GLOBAL__sub_I__ZSt3cin+0x11a>
    3b18:	8526                	mv	a0,s1
    3b1a:	202010ef          	jal	4d1c <strcmp>
        flags = O_RDWR;
    3b1e:	4409                	li	s0,2
    else if (strcmp(mode, "r+") == 0)
    3b20:	d141                	beqz	a0,3aa0 <fopen+0x34>
        return NULL;
    3b22:	4901                	li	s2,0
    3b24:	bf65                	j	3adc <fopen+0x70>
        close(fd);
    3b26:	8526                	mv	a0,s1
    3b28:	ea6fc0ef          	jal	1ce <close>
        return NULL;
    3b2c:	4901                	li	s2,0
    3b2e:	b77d                	j	3adc <fopen+0x70>

0000000000003b30 <fclose>:
    if (!stream)
    3b30:	cd29                	beqz	a0,3b8a <fclose+0x5a>
    if (stream->buf_write_pos > 0)
    3b32:	41052603          	lw	a2,1040(a0)
{
    3b36:	1141                	addi	sp,sp,-16
    3b38:	e022                	sd	s0,0(sp)
    3b3a:	e406                	sd	ra,8(sp)
    3b3c:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    3b3e:	02c04a63          	bgtz	a2,3b72 <fclose+0x42>
    if (stream != stdin && stream != stdout && stream != stderr)
    3b42:	00004797          	auipc	a5,0x4
    3b46:	c9e78793          	addi	a5,a5,-866 # 77e0 <stdout>
    3b4a:	6798                	ld	a4,8(a5)
    3b4c:	00870e63          	beq	a4,s0,3b68 <fclose+0x38>
    3b50:	6398                	ld	a4,0(a5)
    3b52:	00870b63          	beq	a4,s0,3b68 <fclose+0x38>
    3b56:	6b9c                	ld	a5,16(a5)
    3b58:	00878863          	beq	a5,s0,3b68 <fclose+0x38>
        close(stream->fd);
    3b5c:	4008                	lw	a0,0(s0)
    3b5e:	e70fc0ef          	jal	1ce <close>
        free(stream);
    3b62:	8522                	mv	a0,s0
    3b64:	1cb000ef          	jal	452e <free>
}
    3b68:	60a2                	ld	ra,8(sp)
    3b6a:	6402                	ld	s0,0(sp)
    return 0;
    3b6c:	4501                	li	a0,0
}
    3b6e:	0141                	addi	sp,sp,16
    3b70:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3b72:	4108                	lw	a0,0(a0)
    3b74:	01040593          	addi	a1,s0,16
    3b78:	e4efc0ef          	jal	1c6 <write>
        if (ret < stream->buf_write_pos)
    3b7c:	41042783          	lw	a5,1040(s0)
    3b80:	00f54763          	blt	a0,a5,3b8e <fclose+0x5e>
        stream->buf_write_pos = 0;
    3b84:	40042823          	sw	zero,1040(s0)
    3b88:	bf6d                	j	3b42 <fclose+0x12>
        return -1;
    3b8a:	557d                	li	a0,-1
}
    3b8c:	8082                	ret
            stream->error = 1;
    3b8e:	4785                	li	a5,1
    3b90:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3b92:	40042823          	sw	zero,1040(s0)
            return EOF;
    3b96:	b775                	j	3b42 <fclose+0x12>

0000000000003b98 <fflush>:
    if (!stream)
    3b98:	c121                	beqz	a0,3bd8 <fflush+0x40>
    if (stream->buf_write_pos > 0)
    3b9a:	41052603          	lw	a2,1040(a0)
{
    3b9e:	1141                	addi	sp,sp,-16
    3ba0:	e022                	sd	s0,0(sp)
    3ba2:	e406                	sd	ra,8(sp)
    3ba4:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    3ba6:	00c04763          	bgtz	a2,3bb4 <fflush+0x1c>
    return 0;
    3baa:	4501                	li	a0,0
}
    3bac:	60a2                	ld	ra,8(sp)
    3bae:	6402                	ld	s0,0(sp)
    3bb0:	0141                	addi	sp,sp,16
    3bb2:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3bb4:	4108                	lw	a0,0(a0)
    3bb6:	01040593          	addi	a1,s0,16
    3bba:	e0cfc0ef          	jal	1c6 <write>
        if (ret < stream->buf_write_pos)
    3bbe:	41042783          	lw	a5,1040(s0)
    3bc2:	00f54563          	blt	a0,a5,3bcc <fflush+0x34>
        stream->buf_write_pos = 0;
    3bc6:	40042823          	sw	zero,1040(s0)
    3bca:	b7c5                	j	3baa <fflush+0x12>
            stream->error = 1;
    3bcc:	4785                	li	a5,1
    3bce:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3bd0:	40042823          	sw	zero,1040(s0)
        return EOF;
    3bd4:	557d                	li	a0,-1
    3bd6:	bfd9                	j	3bac <fflush+0x14>
    3bd8:	557d                	li	a0,-1
}
    3bda:	8082                	ret

0000000000003bdc <fprintf>:
{
    3bdc:	7159                	addi	sp,sp,-112
    3bde:	fc06                	sd	ra,56(sp)
    3be0:	e0b2                	sd	a2,64(sp)
    3be2:	e4b6                	sd	a3,72(sp)
    3be4:	e8ba                	sd	a4,80(sp)
    3be6:	ecbe                	sd	a5,88(sp)
    3be8:	f0c2                	sd	a6,96(sp)
    3bea:	f4c6                	sd	a7,104(sp)
    if (!stream)
    3bec:	cd19                	beqz	a0,3c0a <fprintf+0x2e>
    va_start(ap, format);
    3bee:	832a                	mv	t1,a0
    3bf0:	0090                	addi	a2,sp,64
    _vprintf_core(&ctx, format, ap);
    3bf2:	0808                	addi	a0,sp,16
    va_start(ap, format);
    3bf4:	e432                	sd	a2,8(sp)
    ctx.buf = NULL;
    3bf6:	e802                	sd	zero,16(sp)
    ctx.limit = 0;
    3bf8:	ec02                	sd	zero,24(sp)
    ctx.written = 0;
    3bfa:	f002                	sd	zero,32(sp)
    ctx.stream  = stream;
    3bfc:	f41a                	sd	t1,40(sp)
    _vprintf_core(&ctx, format, ap);
    3bfe:	d34ff0ef          	jal	3132 <_vprintf_core.constprop.0.isra.0>
    return (int)ctx.written;
    3c02:	5502                	lw	a0,32(sp)
}
    3c04:	70e2                	ld	ra,56(sp)
    3c06:	6165                	addi	sp,sp,112
    3c08:	8082                	ret
        return -1;
    3c0a:	557d                	li	a0,-1
    3c0c:	bfe5                	j	3c04 <fprintf+0x28>

0000000000003c0e <fscanf>:
{
    3c0e:	7159                	addi	sp,sp,-112
    3c10:	fc06                	sd	ra,56(sp)
    3c12:	e0b2                	sd	a2,64(sp)
    3c14:	e4b6                	sd	a3,72(sp)
    3c16:	e8ba                	sd	a4,80(sp)
    3c18:	ecbe                	sd	a5,88(sp)
    3c1a:	f0c2                	sd	a6,96(sp)
    3c1c:	f4c6                	sd	a7,104(sp)
    if (!stream)
    3c1e:	cd19                	beqz	a0,3c3c <fscanf+0x2e>
    ctx.fd = stream->fd;
    3c20:	411c                	lw	a5,0(a0)
    va_start(ap, format);
    3c22:	0090                	addi	a2,sp,64
    int ret = _vscanf_core(&ctx, format, ap);
    3c24:	0808                	addi	a0,sp,16
    ctx.fd = stream->fd;
    3c26:	cc3e                	sw	a5,24(sp)
    ctx.ungotten = -1;
    3c28:	57fd                	li	a5,-1
    va_start(ap, format);
    3c2a:	e432                	sd	a2,8(sp)
    ctx.buf = NULL;
    3c2c:	e802                	sd	zero,16(sp)
    ctx.pos = 0;
    3c2e:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    3c30:	d43e                	sw	a5,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    3c32:	e1dfc0ef          	jal	a4e <_vscanf_core.constprop.0>
}
    3c36:	70e2                	ld	ra,56(sp)
    3c38:	6165                	addi	sp,sp,112
    3c3a:	8082                	ret
        return -1;
    3c3c:	557d                	li	a0,-1
    3c3e:	bfe5                	j	3c36 <fscanf+0x28>

0000000000003c40 <fputc>:
    if (!stream)
    3c40:	c1e1                	beqz	a1,3d00 <fputc+0xc0>
{
    3c42:	7179                	addi	sp,sp,-48
    3c44:	e84a                	sd	s2,16(sp)
    if (stream->buf_mode == 2)
    3c46:	41c5a903          	lw	s2,1052(a1)
{
    3c4a:	f022                	sd	s0,32(sp)
    3c4c:	ec26                	sd	s1,24(sp)
    3c4e:	f406                	sd	ra,40(sp)
    if (stream->buf_mode == 2)
    3c50:	4789                	li	a5,2
    3c52:	842e                	mv	s0,a1
    3c54:	84aa                	mv	s1,a0
        char ch = (char)c;
    3c56:	0ff57713          	zext.b	a4,a0
    if (stream->buf_mode == 2)
    3c5a:	02f90963          	beq	s2,a5,3c8c <fputc+0x4c>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    3c5e:	4105a783          	lw	a5,1040(a1)
    if (stream->buf_write_pos >= BUFSIZ)
    3c62:	3ff00693          	li	a3,1023
    stream->buffer[stream->buf_write_pos++] = (char)c;
    3c66:	0017861b          	addiw	a2,a5,1
    3c6a:	40c5a823          	sw	a2,1040(a1)
    3c6e:	97ae                	add	a5,a5,a1
    3c70:	00e78823          	sb	a4,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    3c74:	06c6c463          	blt	a3,a2,3cdc <fputc+0x9c>
    else if (stream->buf_mode == 1 && c == '\n')
    3c78:	4785                	li	a5,1
    3c7a:	02f90e63          	beq	s2,a5,3cb6 <fputc+0x76>
    return c;
    3c7e:	8526                	mv	a0,s1
}
    3c80:	70a2                	ld	ra,40(sp)
    3c82:	7402                	ld	s0,32(sp)
    3c84:	64e2                	ld	s1,24(sp)
    3c86:	6942                	ld	s2,16(sp)
    3c88:	6145                	addi	sp,sp,48
    3c8a:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    3c8c:	4188                	lw	a0,0(a1)
    3c8e:	4605                	li	a2,1
    3c90:	00f10593          	addi	a1,sp,15
        char ch = (char)c;
    3c94:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    3c98:	d2efc0ef          	jal	1c6 <write>
    3c9c:	872a                	mv	a4,a0
    3c9e:	4785                	li	a5,1
        return c;
    3ca0:	8526                	mv	a0,s1
        if (write(stream->fd, &ch, 1) != 1)
    3ca2:	fcf70fe3          	beq	a4,a5,3c80 <fputc+0x40>
}
    3ca6:	70a2                	ld	ra,40(sp)
            stream->error = 1;
    3ca8:	c41c                	sw	a5,8(s0)
}
    3caa:	7402                	ld	s0,32(sp)
    3cac:	64e2                	ld	s1,24(sp)
    3cae:	6942                	ld	s2,16(sp)
            return EOF;
    3cb0:	557d                	li	a0,-1
}
    3cb2:	6145                	addi	sp,sp,48
    3cb4:	8082                	ret
    else if (stream->buf_mode == 1 && c == '\n')
    3cb6:	47a9                	li	a5,10
    3cb8:	fcf513e3          	bne	a0,a5,3c7e <fputc+0x3e>
    if (stream->buf_write_pos > 0)
    3cbc:	fcc051e3          	blez	a2,3c7e <fputc+0x3e>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3cc0:	4188                	lw	a0,0(a1)
    3cc2:	05c1                	addi	a1,a1,16
    3cc4:	d02fc0ef          	jal	1c6 <write>
        if (ret < stream->buf_write_pos)
    3cc8:	41042783          	lw	a5,1040(s0)
    3ccc:	02f55063          	bge	a0,a5,3cec <fputc+0xac>
            stream->error = 1;
    3cd0:	01242423          	sw	s2,8(s0)
            stream->buf_write_pos = 0;
    3cd4:	40042823          	sw	zero,1040(s0)
    return c;
    3cd8:	8526                	mv	a0,s1
    3cda:	b75d                	j	3c80 <fputc+0x40>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3cdc:	4188                	lw	a0,0(a1)
    3cde:	05c1                	addi	a1,a1,16
    3ce0:	ce6fc0ef          	jal	1c6 <write>
        if (ret < stream->buf_write_pos)
    3ce4:	41042783          	lw	a5,1040(s0)
    3ce8:	00f54663          	blt	a0,a5,3cf4 <fputc+0xb4>
        stream->buf_write_pos = 0;
    3cec:	40042823          	sw	zero,1040(s0)
    return c;
    3cf0:	8526                	mv	a0,s1
    3cf2:	b779                	j	3c80 <fputc+0x40>
            stream->error = 1;
    3cf4:	4785                	li	a5,1
    3cf6:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3cf8:	40042823          	sw	zero,1040(s0)
    return c;
    3cfc:	8526                	mv	a0,s1
    3cfe:	b749                	j	3c80 <fputc+0x40>
        return EOF;
    3d00:	557d                	li	a0,-1
}
    3d02:	8082                	ret

0000000000003d04 <fputs>:
    if (!stream)
    3d04:	c1ed                	beqz	a1,3de6 <fputs+0xe2>
{
    3d06:	711d                	addi	sp,sp,-96
    3d08:	e4a6                	sd	s1,72(sp)
    3d0a:	ec86                	sd	ra,88(sp)
    while (*s)
    3d0c:	00054703          	lbu	a4,0(a0)
    3d10:	84aa                	mv	s1,a0
    3d12:	cf25                	beqz	a4,3d8a <fputs+0x86>
    3d14:	e8a2                	sd	s0,80(sp)
    3d16:	e0ca                	sd	s2,64(sp)
    3d18:	fc4e                	sd	s3,56(sp)
    3d1a:	f852                	sd	s4,48(sp)
    3d1c:	f456                	sd	s5,40(sp)
    3d1e:	f05a                	sd	s6,32(sp)
    3d20:	ec5e                	sd	s7,24(sp)
    3d22:	842e                	mv	s0,a1
    if (stream->buf_mode == 2)
    3d24:	4909                	li	s2,2
    if (stream->buf_write_pos >= BUFSIZ)
    3d26:	3ff00b13          	li	s6,1023
    else if (stream->buf_mode == 1 && c == '\n')
    3d2a:	4985                	li	s3,1
    3d2c:	4a29                	li	s4,10
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3d2e:	01058a93          	addi	s5,a1,16
        if (write(stream->fd, &ch, 1) != 1)
    3d32:	00f10b93          	addi	s7,sp,15
    3d36:	a031                	j	3d42 <fputs+0x3e>
    else if (stream->buf_mode == 1 && c == '\n')
    3d38:	09368563          	beq	a3,s3,3dc2 <fputs+0xbe>
    while (*s)
    3d3c:	0004c703          	lbu	a4,0(s1)
    3d40:	cf15                	beqz	a4,3d7c <fputs+0x78>
    if (stream->buf_mode == 2)
    3d42:	41c42683          	lw	a3,1052(s0)
        if (fputc(*s++, stream) == EOF)
    3d46:	0485                	addi	s1,s1,1
    if (stream->buf_mode == 2)
    3d48:	05268663          	beq	a3,s2,3d94 <fputs+0x90>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    3d4c:	41042783          	lw	a5,1040(s0)
    3d50:	0017861b          	addiw	a2,a5,1
    3d54:	40c42823          	sw	a2,1040(s0)
    3d58:	97a2                	add	a5,a5,s0
    3d5a:	00e78823          	sb	a4,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    3d5e:	fccb5de3          	bge	s6,a2,3d38 <fputs+0x34>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3d62:	4008                	lw	a0,0(s0)
    3d64:	85d6                	mv	a1,s5
    3d66:	c60fc0ef          	jal	1c6 <write>
        if (ret < stream->buf_write_pos)
    3d6a:	41042783          	lw	a5,1040(s0)
    3d6e:	06f54763          	blt	a0,a5,3ddc <fputs+0xd8>
        stream->buf_write_pos = 0;
    3d72:	40042823          	sw	zero,1040(s0)
    while (*s)
    3d76:	0004c703          	lbu	a4,0(s1)
    3d7a:	f761                	bnez	a4,3d42 <fputs+0x3e>
    3d7c:	6446                	ld	s0,80(sp)
    3d7e:	6906                	ld	s2,64(sp)
    3d80:	79e2                	ld	s3,56(sp)
    3d82:	7a42                	ld	s4,48(sp)
    3d84:	7aa2                	ld	s5,40(sp)
    3d86:	7b02                	ld	s6,32(sp)
    3d88:	6be2                	ld	s7,24(sp)
}
    3d8a:	60e6                	ld	ra,88(sp)
    3d8c:	64a6                	ld	s1,72(sp)
    return 0;
    3d8e:	4501                	li	a0,0
}
    3d90:	6125                	addi	sp,sp,96
    3d92:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    3d94:	4008                	lw	a0,0(s0)
    3d96:	4605                	li	a2,1
    3d98:	85de                	mv	a1,s7
        char ch = (char)c;
    3d9a:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    3d9e:	c28fc0ef          	jal	1c6 <write>
    3da2:	f9350de3          	beq	a0,s3,3d3c <fputs+0x38>
            stream->error = 1;
    3da6:	01342423          	sw	s3,8(s0)
}
    3daa:	60e6                	ld	ra,88(sp)
    3dac:	6446                	ld	s0,80(sp)
    3dae:	6906                	ld	s2,64(sp)
    3db0:	79e2                	ld	s3,56(sp)
    3db2:	7a42                	ld	s4,48(sp)
    3db4:	7aa2                	ld	s5,40(sp)
    3db6:	7b02                	ld	s6,32(sp)
    3db8:	6be2                	ld	s7,24(sp)
    3dba:	64a6                	ld	s1,72(sp)
        return -1;
    3dbc:	557d                	li	a0,-1
}
    3dbe:	6125                	addi	sp,sp,96
    3dc0:	8082                	ret
    else if (stream->buf_mode == 1 && c == '\n')
    3dc2:	f7471de3          	bne	a4,s4,3d3c <fputs+0x38>
    if (stream->buf_write_pos > 0)
    3dc6:	f6c05be3          	blez	a2,3d3c <fputs+0x38>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3dca:	4008                	lw	a0,0(s0)
    3dcc:	01040593          	addi	a1,s0,16
    3dd0:	bf6fc0ef          	jal	1c6 <write>
        if (ret < stream->buf_write_pos)
    3dd4:	41042783          	lw	a5,1040(s0)
    3dd8:	f8f55de3          	bge	a0,a5,3d72 <fputs+0x6e>
            stream->error = 1;
    3ddc:	4785                	li	a5,1
    3dde:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3de0:	40042823          	sw	zero,1040(s0)
            return EOF;
    3de4:	bfa1                	j	3d3c <fputs+0x38>
        return -1;
    3de6:	557d                	li	a0,-1
}
    3de8:	8082                	ret

0000000000003dea <fgetc>:
    if (!stream)
    3dea:	c949                	beqz	a0,3e7c <fgetc+0x92>
    if (stream->buf_write_pos > 0)
    3dec:	41052603          	lw	a2,1040(a0)
{
    3df0:	1141                	addi	sp,sp,-16
    3df2:	e022                	sd	s0,0(sp)
    3df4:	e406                	sd	ra,8(sp)
    3df6:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    3df8:	04c04863          	bgtz	a2,3e48 <fgetc+0x5e>
    if (stream->buf_read_pos < stream->buf_read_cnt)
    3dfc:	41442783          	lw	a5,1044(s0)
    3e00:	41842703          	lw	a4,1048(s0)
    3e04:	00e7dd63          	bge	a5,a4,3e1e <fgetc+0x34>
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3e08:	0017871b          	addiw	a4,a5,1
    3e0c:	40e42a23          	sw	a4,1044(s0)
    3e10:	943e                	add	s0,s0,a5
    3e12:	01044503          	lbu	a0,16(s0)
}
    3e16:	60a2                	ld	ra,8(sp)
    3e18:	6402                	ld	s0,0(sp)
    3e1a:	0141                	addi	sp,sp,16
    3e1c:	8082                	ret
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3e1e:	4008                	lw	a0,0(s0)
    3e20:	40000613          	li	a2,1024
    3e24:	01040593          	addi	a1,s0,16
    3e28:	b96fc0ef          	jal	1be <read>
    3e2c:	87aa                	mv	a5,a0
    if (ret <= 0)
    3e2e:	02a05e63          	blez	a0,3e6a <fgetc+0x80>
    stream->buf_read_cnt = (int)ret;
    3e32:	40f42c23          	sw	a5,1048(s0)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3e36:	4785                	li	a5,1
    3e38:	01044503          	lbu	a0,16(s0)
}
    3e3c:	60a2                	ld	ra,8(sp)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3e3e:	40f42a23          	sw	a5,1044(s0)
}
    3e42:	6402                	ld	s0,0(sp)
    3e44:	0141                	addi	sp,sp,16
    3e46:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3e48:	4108                	lw	a0,0(a0)
    3e4a:	01040593          	addi	a1,s0,16
    3e4e:	b78fc0ef          	jal	1c6 <write>
        if (ret < stream->buf_write_pos)
    3e52:	41042783          	lw	a5,1040(s0)
    3e56:	00f54563          	blt	a0,a5,3e60 <fgetc+0x76>
        stream->buf_write_pos = 0;
    3e5a:	40042823          	sw	zero,1040(s0)
    3e5e:	bf79                	j	3dfc <fgetc+0x12>
            stream->error = 1;
    3e60:	4785                	li	a5,1
    3e62:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3e64:	40042823          	sw	zero,1040(s0)
            return EOF;
    3e68:	bf51                	j	3dfc <fgetc+0x12>
        if (ret == 0)
    3e6a:	e509                	bnez	a0,3e74 <fgetc+0x8a>
            stream->eof = 1;
    3e6c:	4785                	li	a5,1
    3e6e:	c45c                	sw	a5,12(s0)
        return EOF;
    3e70:	557d                	li	a0,-1
    3e72:	b755                	j	3e16 <fgetc+0x2c>
            stream->error = 1;
    3e74:	4785                	li	a5,1
    3e76:	c41c                	sw	a5,8(s0)
        return EOF;
    3e78:	557d                	li	a0,-1
    3e7a:	bf71                	j	3e16 <fgetc+0x2c>
    3e7c:	557d                	li	a0,-1
}
    3e7e:	8082                	ret

0000000000003e80 <fgets>:
    if (!stream || n <= 0)
    3e80:	ce5d                	beqz	a2,3f3e <fgets+0xbe>
    3e82:	0ab05e63          	blez	a1,3f3e <fgets+0xbe>
{
    3e86:	715d                	addi	sp,sp,-80
    3e88:	e0a2                	sd	s0,64(sp)
    3e8a:	fc26                	sd	s1,56(sp)
    3e8c:	f84a                	sd	s2,48(sp)
    3e8e:	f44e                	sd	s3,40(sp)
    3e90:	f052                	sd	s4,32(sp)
    3e92:	ec56                	sd	s5,24(sp)
    3e94:	e85a                	sd	s6,16(sp)
    3e96:	e45e                	sd	s7,8(sp)
    3e98:	e486                	sd	ra,72(sp)
    3e9a:	8432                	mv	s0,a2
    3e9c:	8aaa                	mv	s5,a0
    3e9e:	892a                	mv	s2,a0
    3ea0:	fff58b9b          	addiw	s7,a1,-1
    int i = 0, c;
    3ea4:	4481                	li	s1,0
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3ea6:	01060993          	addi	s3,a2,16
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3eaa:	4b05                	li	s6,1
        if (c == '\n')
    3eac:	4a29                	li	s4,10
    while (i < n - 1)
    3eae:	05748163          	beq	s1,s7,3ef0 <fgets+0x70>
    if (stream->buf_write_pos > 0)
    3eb2:	41042603          	lw	a2,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3eb6:	85ce                	mv	a1,s3
    if (stream->buf_write_pos > 0)
    3eb8:	06c04963          	bgtz	a2,3f2a <fgets+0xaa>
    if (stream->buf_read_pos < stream->buf_read_cnt)
    3ebc:	41442783          	lw	a5,1044(s0)
    3ec0:	41842703          	lw	a4,1048(s0)
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3ec4:	40000613          	li	a2,1024
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3ec8:	0017851b          	addiw	a0,a5,1
    3ecc:	00f406b3          	add	a3,s0,a5
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3ed0:	85ce                	mv	a1,s3
    if (stream->buf_read_pos < stream->buf_read_cnt)
    3ed2:	02e7de63          	bge	a5,a4,3f0e <fgets+0x8e>
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3ed6:	40a42a23          	sw	a0,1044(s0)
    3eda:	0106c783          	lbu	a5,16(a3)
    3ede:	0007871b          	sext.w	a4,a5
        str[i++] = (char)c;
    3ee2:	00f90023          	sb	a5,0(s2)
    3ee6:	2485                	addiw	s1,s1,1
        if (c == '\n')
    3ee8:	0905                	addi	s2,s2,1
    3eea:	fd4712e3          	bne	a4,s4,3eae <fgets+0x2e>
        str[i++] = (char)c;
    3eee:	8ba6                	mv	s7,s1
    str[i] = '\0';
    3ef0:	9bd6                	add	s7,s7,s5
    3ef2:	000b8023          	sb	zero,0(s7)
    return str;
    3ef6:	8556                	mv	a0,s5
}
    3ef8:	60a6                	ld	ra,72(sp)
    3efa:	6406                	ld	s0,64(sp)
    3efc:	74e2                	ld	s1,56(sp)
    3efe:	7942                	ld	s2,48(sp)
    3f00:	79a2                	ld	s3,40(sp)
    3f02:	7a02                	ld	s4,32(sp)
    3f04:	6ae2                	ld	s5,24(sp)
    3f06:	6b42                	ld	s6,16(sp)
    3f08:	6ba2                	ld	s7,8(sp)
    3f0a:	6161                	addi	sp,sp,80
    3f0c:	8082                	ret
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3f0e:	4008                	lw	a0,0(s0)
    3f10:	aaefc0ef          	jal	1be <read>
    if (ret <= 0)
    3f14:	02a05c63          	blez	a0,3f4c <fgets+0xcc>
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3f18:	01044783          	lbu	a5,16(s0)
    stream->buf_read_cnt = (int)ret;
    3f1c:	40a42c23          	sw	a0,1048(s0)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    3f20:	41642a23          	sw	s6,1044(s0)
    3f24:	0007871b          	sext.w	a4,a5
        if (c == -1)
    3f28:	bf6d                	j	3ee2 <fgets+0x62>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    3f2a:	4008                	lw	a0,0(s0)
    3f2c:	a9afc0ef          	jal	1c6 <write>
        if (ret < stream->buf_write_pos)
    3f30:	41042783          	lw	a5,1040(s0)
    3f34:	00f54763          	blt	a0,a5,3f42 <fgets+0xc2>
        stream->buf_write_pos = 0;
    3f38:	40042823          	sw	zero,1040(s0)
    3f3c:	b741                	j	3ebc <fgets+0x3c>
        return NULL;
    3f3e:	4501                	li	a0,0
}
    3f40:	8082                	ret
            stream->error = 1;
    3f42:	4785                	li	a5,1
    3f44:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    3f46:	40042823          	sw	zero,1040(s0)
            return EOF;
    3f4a:	bf8d                	j	3ebc <fgets+0x3c>
            stream->eof = 1;
    3f4c:	4785                	li	a5,1
        if (ret == 0)
    3f4e:	e509                	bnez	a0,3f58 <fgets+0xd8>
            stream->eof = 1;
    3f50:	c45c                	sw	a5,12(s0)
            if (i == 0)
    3f52:	fcd1                	bnez	s1,3eee <fgets+0x6e>
        return NULL;
    3f54:	4501                	li	a0,0
    3f56:	b74d                	j	3ef8 <fgets+0x78>
            stream->error = 1;
    3f58:	c41c                	sw	a5,8(s0)
        if (c == -1)
    3f5a:	bfe5                	j	3f52 <fgets+0xd2>

0000000000003f5c <fread>:
{
    3f5c:	715d                	addi	sp,sp,-80
    3f5e:	e486                	sd	ra,72(sp)
    3f60:	f44e                	sd	s3,40(sp)
    if (!stream || size == 0 || nmemb == 0)
    3f62:	0e068963          	beqz	a3,4054 <fread+0xf8>
    3f66:	ec56                	sd	s5,24(sp)
        return 0;
    3f68:	4981                	li	s3,0
    3f6a:	8aae                	mv	s5,a1
    if (!stream || size == 0 || nmemb == 0)
    3f6c:	c9bd                	beqz	a1,3fe2 <fread+0x86>
    3f6e:	ca35                	beqz	a2,3fe2 <fread+0x86>
    if (stream->buf_write_pos > 0)
    3f70:	4106a783          	lw	a5,1040(a3)
    3f74:	e0a2                	sd	s0,64(sp)
    3f76:	f052                	sd	s4,32(sp)
    uint64 total_bytes = size * nmemb;
    3f78:	02c589b3          	mul	s3,a1,a2
    3f7c:	8436                	mv	s0,a3
    3f7e:	8a2a                	mv	s4,a0
    if (stream->buf_write_pos > 0)
    3f80:	0af04d63          	bgtz	a5,403a <fread+0xde>
    while (bytes_read < total_bytes)
    3f84:	04098d63          	beqz	s3,3fde <fread+0x82>
    3f88:	fc26                	sd	s1,56(sp)
    3f8a:	e85a                	sd	s6,16(sp)
    3f8c:	e45e                	sd	s7,8(sp)
    3f8e:	f84a                	sd	s2,48(sp)
    3f90:	4481                	li	s1,0
            if (remaining >= BUFSIZ)
    3f92:	3ff00b13          	li	s6,1023
                int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3f96:	01040b93          	addi	s7,s0,16
        if (stream->buf_read_pos < stream->buf_read_cnt)
    3f9a:	41442703          	lw	a4,1044(s0)
    3f9e:	41842783          	lw	a5,1048(s0)
            uint64 remaining = total_bytes - bytes_read;
    3fa2:	40998633          	sub	a2,s3,s1
        if (stream->buf_read_pos < stream->buf_read_cnt)
    3fa6:	06f74463          	blt	a4,a5,400e <fread+0xb2>
                int64 ret = read(stream->fd, dst + bytes_read, remaining);
    3faa:	4008                	lw	a0,0(s0)
    3fac:	009a05b3          	add	a1,s4,s1
            if (remaining >= BUFSIZ)
    3fb0:	02cb7f63          	bgeu	s6,a2,3fee <fread+0x92>
                int64 ret = read(stream->fd, dst + bytes_read, remaining);
    3fb4:	a0afc0ef          	jal	1be <read>
                if (ret <= 0)
    3fb8:	0aa05463          	blez	a0,4060 <fread+0x104>
                bytes_read += ret;
    3fbc:	94aa                	add	s1,s1,a0
    while (bytes_read < total_bytes)
    3fbe:	fd34eee3          	bltu	s1,s3,3f9a <fread+0x3e>
    return bytes_read / size;
    3fc2:	0354d9b3          	divu	s3,s1,s5
    3fc6:	6406                	ld	s0,64(sp)
}
    3fc8:	60a6                	ld	ra,72(sp)
    return bytes_read / size;
    3fca:	74e2                	ld	s1,56(sp)
    3fcc:	7942                	ld	s2,48(sp)
    3fce:	7a02                	ld	s4,32(sp)
    3fd0:	6ae2                	ld	s5,24(sp)
    3fd2:	6b42                	ld	s6,16(sp)
    3fd4:	6ba2                	ld	s7,8(sp)
}
    3fd6:	854e                	mv	a0,s3
    3fd8:	79a2                	ld	s3,40(sp)
    3fda:	6161                	addi	sp,sp,80
    3fdc:	8082                	ret
    3fde:	6406                	ld	s0,64(sp)
    3fe0:	7a02                	ld	s4,32(sp)
    3fe2:	60a6                	ld	ra,72(sp)
    3fe4:	6ae2                	ld	s5,24(sp)
    3fe6:	854e                	mv	a0,s3
    3fe8:	79a2                	ld	s3,40(sp)
    3fea:	6161                	addi	sp,sp,80
    3fec:	8082                	ret
                stream->buf_read_pos = 0;
    3fee:	40042a23          	sw	zero,1044(s0)
                stream->buf_read_cnt = 0;
    3ff2:	40042c23          	sw	zero,1048(s0)
                int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    3ff6:	40000613          	li	a2,1024
    3ffa:	85de                	mv	a1,s7
    3ffc:	9c2fc0ef          	jal	1be <read>
                if (ret <= 0)
    4000:	06a05063          	blez	a0,4060 <fread+0x104>
                stream->buf_read_cnt = (int)ret;
    4004:	40a42c23          	sw	a0,1048(s0)
    while (bytes_read < total_bytes)
    4008:	f934e9e3          	bltu	s1,s3,3f9a <fread+0x3e>
    400c:	bf5d                	j	3fc2 <fread+0x66>
            uint64 available = stream->buf_read_cnt - stream->buf_read_pos;
    400e:	40e7893b          	subw	s2,a5,a4
            memcpy(dst + bytes_read, stream->buffer + stream->buf_read_pos, to_copy);
    4012:	00eb85b3          	add	a1,s7,a4
    4016:	009a0533          	add	a0,s4,s1
            uint64 to_copy = (available < remaining) ? available : remaining;
    401a:	01267363          	bgeu	a2,s2,4020 <fread+0xc4>
    401e:	8932                	mv	s2,a2
            memcpy(dst + bytes_read, stream->buffer + stream->buf_read_pos, to_copy);
    4020:	864a                	mv	a2,s2
    4022:	3e1000ef          	jal	4c02 <memcpy>
            stream->buf_read_pos += to_copy;
    4026:	41442783          	lw	a5,1044(s0)
            bytes_read += to_copy;
    402a:	94ca                	add	s1,s1,s2
            stream->buf_read_pos += to_copy;
    402c:	012787bb          	addw	a5,a5,s2
    4030:	40f42a23          	sw	a5,1044(s0)
    while (bytes_read < total_bytes)
    4034:	f734e3e3          	bltu	s1,s3,3f9a <fread+0x3e>
    4038:	b769                	j	3fc2 <fread+0x66>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    403a:	4288                	lw	a0,0(a3)
    403c:	863e                	mv	a2,a5
    403e:	01068593          	addi	a1,a3,16
    4042:	984fc0ef          	jal	1c6 <write>
        if (ret < stream->buf_write_pos)
    4046:	41042783          	lw	a5,1040(s0)
    404a:	02f54163          	blt	a0,a5,406c <fread+0x110>
        stream->buf_write_pos = 0;
    404e:	40042823          	sw	zero,1040(s0)
    4052:	bf0d                	j	3f84 <fread+0x28>
}
    4054:	60a6                	ld	ra,72(sp)
        return 0;
    4056:	4981                	li	s3,0
}
    4058:	854e                	mv	a0,s3
    405a:	79a2                	ld	s3,40(sp)
    405c:	6161                	addi	sp,sp,80
    405e:	8082                	ret
                        stream->eof = 1;
    4060:	4785                	li	a5,1
                    if (ret == 0)
    4062:	e119                	bnez	a0,4068 <fread+0x10c>
                        stream->eof = 1;
    4064:	c45c                	sw	a5,12(s0)
    4066:	bfb1                	j	3fc2 <fread+0x66>
                        stream->error = 1;
    4068:	c41c                	sw	a5,8(s0)
                    return bytes_read / size;
    406a:	bfa1                	j	3fc2 <fread+0x66>
            stream->error = 1;
    406c:	4785                	li	a5,1
    406e:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4070:	40042823          	sw	zero,1040(s0)
            return EOF;
    4074:	bf01                	j	3f84 <fread+0x28>

0000000000004076 <fwrite>:
{
    4076:	711d                	addi	sp,sp,-96
    4078:	ec86                	sd	ra,88(sp)
    407a:	e0ca                	sd	s2,64(sp)
    if (!stream || !ptr || size == 0 || nmemb == 0)
    407c:	10068063          	beqz	a3,417c <fwrite+0x106>
    4080:	f456                	sd	s5,40(sp)
    4082:	8aaa                	mv	s5,a0
    4084:	10050263          	beqz	a0,4188 <fwrite+0x112>
    4088:	f05a                	sd	s6,32(sp)
        return 0;
    408a:	4901                	li	s2,0
    408c:	8b2e                	mv	s6,a1
    if (!stream || !ptr || size == 0 || nmemb == 0)
    408e:	c1d9                	beqz	a1,4114 <fwrite+0x9e>
    4090:	c251                	beqz	a2,4114 <fwrite+0x9e>
    if (stream->buf_mode == 2)
    4092:	41c6a703          	lw	a4,1052(a3)
    4096:	e8a2                	sd	s0,80(sp)
    4098:	4789                	li	a5,2
    uint64 total_bytes = size * nmemb;
    409a:	02c58933          	mul	s2,a1,a2
    if (stream->buf_mode == 2)
    409e:	8436                	mv	s0,a3
    40a0:	0ef70b63          	beq	a4,a5,4196 <fwrite+0x120>
    40a4:	fc4e                	sd	s3,56(sp)
    40a6:	ec5e                	sd	s7,24(sp)
    40a8:	e862                	sd	s8,16(sp)
    uint64 bytes_written = 0;
    40aa:	4981                	li	s3,0
    40ac:	01068b93          	addi	s7,a3,16
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    40b0:	40000c13          	li	s8,1024
    while (bytes_written < total_bytes)
    40b4:	12090263          	beqz	s2,41d8 <fwrite+0x162>
    40b8:	e4a6                	sd	s1,72(sp)
    40ba:	f852                	sd	s4,48(sp)
    40bc:	e466                	sd	s9,8(sp)
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    40be:	41042783          	lw	a5,1040(s0)
        uint64 remaining = total_bytes - bytes_written;
    40c2:	41390cb3          	sub	s9,s2,s3
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, remaining);
    40c6:	013a85b3          	add	a1,s5,s3
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    40ca:	40fc0a3b          	subw	s4,s8,a5
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, space_left);
    40ce:	00fb8533          	add	a0,s7,a5
    40d2:	8652                	mv	a2,s4
        if (remaining <= space_left)
    40d4:	059a6763          	bltu	s4,s9,4122 <fwrite+0xac>
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, remaining);
    40d8:	8666                	mv	a2,s9
    40da:	329000ef          	jal	4c02 <memcpy>
            stream->buf_write_pos += remaining;
    40de:	41042783          	lw	a5,1040(s0)
            if (stream->buf_write_pos == BUFSIZ)
    40e2:	40000713          	li	a4,1024
            stream->buf_write_pos += remaining;
    40e6:	019786bb          	addw	a3,a5,s9
    40ea:	40d42823          	sw	a3,1040(s0)
            if (stream->buf_write_pos == BUFSIZ)
    40ee:	06e68a63          	beq	a3,a4,4162 <fwrite+0xec>
    return bytes_written / size;
    40f2:	03695933          	divu	s2,s2,s6
    40f6:	6446                	ld	s0,80(sp)
    40f8:	64a6                	ld	s1,72(sp)
    40fa:	79e2                	ld	s3,56(sp)
    40fc:	7a42                	ld	s4,48(sp)
    40fe:	7aa2                	ld	s5,40(sp)
    4100:	7b02                	ld	s6,32(sp)
    4102:	6be2                	ld	s7,24(sp)
    4104:	6c42                	ld	s8,16(sp)
    4106:	6ca2                	ld	s9,8(sp)
}
    4108:	60e6                	ld	ra,88(sp)
    410a:	854a                	mv	a0,s2
    410c:	6906                	ld	s2,64(sp)
    410e:	6125                	addi	sp,sp,96
    4110:	8082                	ret
    4112:	6446                	ld	s0,80(sp)
    4114:	60e6                	ld	ra,88(sp)
    4116:	7aa2                	ld	s5,40(sp)
    4118:	7b02                	ld	s6,32(sp)
    411a:	854a                	mv	a0,s2
    411c:	6906                	ld	s2,64(sp)
    411e:	6125                	addi	sp,sp,96
    4120:	8082                	ret
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, space_left);
    4122:	2e1000ef          	jal	4c02 <memcpy>
            stream->buf_write_pos += space_left;
    4126:	41042783          	lw	a5,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    412a:	85de                	mv	a1,s7
            bytes_written += space_left;
    412c:	99d2                	add	s3,s3,s4
            stream->buf_write_pos += space_left;
    412e:	00fa04bb          	addw	s1,s4,a5
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4132:	02049613          	slli	a2,s1,0x20
            stream->buf_write_pos += space_left;
    4136:	40942823          	sw	s1,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    413a:	9201                	srli	a2,a2,0x20
    if (stream->buf_write_pos > 0)
    413c:	00904763          	bgtz	s1,414a <fwrite+0xd4>
    while (bytes_written < total_bytes)
    4140:	f729efe3          	bltu	s3,s2,40be <fwrite+0x48>
    return bytes_written / size;
    4144:	0369d933          	divu	s2,s3,s6
    4148:	b77d                	j	40f6 <fwrite+0x80>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    414a:	4008                	lw	a0,0(s0)
    414c:	87afc0ef          	jal	1c6 <write>
        if (ret < stream->buf_write_pos)
    4150:	41042783          	lw	a5,1040(s0)
    4154:	08f54963          	blt	a0,a5,41e6 <fwrite+0x170>
        stream->buf_write_pos = 0;
    4158:	40042823          	sw	zero,1040(s0)
    while (bytes_written < total_bytes)
    415c:	f729e1e3          	bltu	s3,s2,40be <fwrite+0x48>
    4160:	b7d5                	j	4144 <fwrite+0xce>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4162:	4008                	lw	a0,0(s0)
    4164:	40000613          	li	a2,1024
    4168:	85de                	mv	a1,s7
    416a:	85cfc0ef          	jal	1c6 <write>
        if (ret < stream->buf_write_pos)
    416e:	41042783          	lw	a5,1040(s0)
    4172:	08f54163          	blt	a0,a5,41f4 <fwrite+0x17e>
        stream->buf_write_pos = 0;
    4176:	40042823          	sw	zero,1040(s0)
    417a:	bfa5                	j	40f2 <fwrite+0x7c>
}
    417c:	60e6                	ld	ra,88(sp)
        return 0;
    417e:	4901                	li	s2,0
}
    4180:	854a                	mv	a0,s2
    4182:	6906                	ld	s2,64(sp)
    4184:	6125                	addi	sp,sp,96
    4186:	8082                	ret
    4188:	60e6                	ld	ra,88(sp)
        return 0;
    418a:	4901                	li	s2,0
    418c:	7aa2                	ld	s5,40(sp)
}
    418e:	854a                	mv	a0,s2
    4190:	6906                	ld	s2,64(sp)
    4192:	6125                	addi	sp,sp,96
    4194:	8082                	ret
        while (bytes_written < total_bytes)
    4196:	f6090ee3          	beqz	s2,4112 <fwrite+0x9c>
    419a:	e4a6                	sd	s1,72(sp)
    uint64 bytes_written = 0;
    419c:	4481                	li	s1,0
    419e:	a021                	j	41a6 <fwrite+0x130>
            bytes_written += ret;
    41a0:	94aa                	add	s1,s1,a0
        while (bytes_written < total_bytes)
    41a2:	0324f463          	bgeu	s1,s2,41ca <fwrite+0x154>
            int64 ret = write(stream->fd, src + bytes_written, total_bytes - bytes_written);
    41a6:	4008                	lw	a0,0(s0)
    41a8:	40990633          	sub	a2,s2,s1
    41ac:	009a85b3          	add	a1,s5,s1
    41b0:	816fc0ef          	jal	1c6 <write>
            if (ret <= 0)
    41b4:	fea046e3          	bgtz	a0,41a0 <fwrite+0x12a>
                stream->error = 1;
    41b8:	4785                	li	a5,1
        return bytes_written / size;
    41ba:	0364d933          	divu	s2,s1,s6
                stream->error = 1;
    41be:	c41c                	sw	a5,8(s0)
                break;
    41c0:	64a6                	ld	s1,72(sp)
    41c2:	6446                	ld	s0,80(sp)
    41c4:	7aa2                	ld	s5,40(sp)
    41c6:	7b02                	ld	s6,32(sp)
    41c8:	b781                	j	4108 <fwrite+0x92>
        return bytes_written / size;
    41ca:	0364d933          	divu	s2,s1,s6
    41ce:	6446                	ld	s0,80(sp)
    41d0:	64a6                	ld	s1,72(sp)
    41d2:	7aa2                	ld	s5,40(sp)
    41d4:	7b02                	ld	s6,32(sp)
    41d6:	bf0d                	j	4108 <fwrite+0x92>
    41d8:	6446                	ld	s0,80(sp)
    41da:	79e2                	ld	s3,56(sp)
    41dc:	7aa2                	ld	s5,40(sp)
    41de:	7b02                	ld	s6,32(sp)
    41e0:	6be2                	ld	s7,24(sp)
    41e2:	6c42                	ld	s8,16(sp)
    41e4:	b715                	j	4108 <fwrite+0x92>
            stream->error = 1;
    41e6:	4785                	li	a5,1
    41e8:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    41ea:	40042823          	sw	zero,1040(s0)
    while (bytes_written < total_bytes)
    41ee:	ed29e8e3          	bltu	s3,s2,40be <fwrite+0x48>
    41f2:	bf89                	j	4144 <fwrite+0xce>
            stream->error = 1;
    41f4:	4785                	li	a5,1
    41f6:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    41f8:	40042823          	sw	zero,1040(s0)
            return EOF;
    41fc:	bddd                	j	40f2 <fwrite+0x7c>

00000000000041fe <fseek>:
    if (!stream)
    41fe:	c925                	beqz	a0,426e <fseek+0x70>
{
    4200:	1101                	addi	sp,sp,-32
    4202:	e04a                	sd	s2,0(sp)
    4204:	8932                	mv	s2,a2
    if (stream->buf_write_pos > 0)
    4206:	41052603          	lw	a2,1040(a0)
{
    420a:	e822                	sd	s0,16(sp)
    420c:	e426                	sd	s1,8(sp)
    420e:	ec06                	sd	ra,24(sp)
    4210:	842a                	mv	s0,a0
    4212:	84ae                	mv	s1,a1
    if (stream->buf_write_pos > 0)
    4214:	02c04863          	bgtz	a2,4244 <fseek+0x46>
    if (lseek(stream->fd, offset, whence) < 0)
    4218:	4008                	lw	a0,0(s0)
    stream->buf_read_pos = 0;
    421a:	40042a23          	sw	zero,1044(s0)
    stream->buf_read_cnt = 0;
    421e:	40042c23          	sw	zero,1048(s0)
    stream->eof = 0;
    4222:	00042623          	sw	zero,12(s0)
    if (lseek(stream->fd, offset, whence) < 0)
    4226:	864a                	mv	a2,s2
    4228:	0004859b          	sext.w	a1,s1
    422c:	82afc0ef          	jal	256 <lseek>
    4230:	87aa                	mv	a5,a0
    return 0;
    4232:	4501                	li	a0,0
    if (lseek(stream->fd, offset, whence) < 0)
    4234:	0207c463          	bltz	a5,425c <fseek+0x5e>
}
    4238:	60e2                	ld	ra,24(sp)
    423a:	6442                	ld	s0,16(sp)
    423c:	64a2                	ld	s1,8(sp)
    423e:	6902                	ld	s2,0(sp)
    4240:	6105                	addi	sp,sp,32
    4242:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4244:	4108                	lw	a0,0(a0)
    4246:	01040593          	addi	a1,s0,16
    424a:	f7dfb0ef          	jal	1c6 <write>
        if (ret < stream->buf_write_pos)
    424e:	41042783          	lw	a5,1040(s0)
    4252:	00f54963          	blt	a0,a5,4264 <fseek+0x66>
        stream->buf_write_pos = 0;
    4256:	40042823          	sw	zero,1040(s0)
    425a:	bf7d                	j	4218 <fseek+0x1a>
        stream->error = 1;
    425c:	4785                	li	a5,1
    425e:	c41c                	sw	a5,8(s0)
        return -1;
    4260:	557d                	li	a0,-1
    4262:	bfd9                	j	4238 <fseek+0x3a>
            stream->error = 1;
    4264:	4785                	li	a5,1
    4266:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4268:	40042823          	sw	zero,1040(s0)
            return EOF;
    426c:	b775                	j	4218 <fseek+0x1a>
        return -1;
    426e:	557d                	li	a0,-1
}
    4270:	8082                	ret

0000000000004272 <ftell>:
    if (!stream)
    4272:	c505                	beqz	a0,429a <ftell+0x28>
{
    4274:	1141                	addi	sp,sp,-16
    4276:	e022                	sd	s0,0(sp)
    4278:	842a                	mv	s0,a0
    int64 ret = lseek(stream->fd, 0, SEEK_CUR);
    427a:	4108                	lw	a0,0(a0)
    427c:	4605                	li	a2,1
    427e:	4581                	li	a1,0
{
    4280:	e406                	sd	ra,8(sp)
    int64 ret = lseek(stream->fd, 0, SEEK_CUR);
    4282:	fd5fb0ef          	jal	256 <lseek>
    if (ret < 0)
    4286:	00054663          	bltz	a0,4292 <ftell+0x20>
}
    428a:	60a2                	ld	ra,8(sp)
    428c:	6402                	ld	s0,0(sp)
    428e:	0141                	addi	sp,sp,16
    4290:	8082                	ret
        stream->error = 1;
    4292:	4785                	li	a5,1
    4294:	c41c                	sw	a5,8(s0)
        return -1L;
    4296:	557d                	li	a0,-1
    4298:	bfcd                	j	428a <ftell+0x18>
    429a:	557d                	li	a0,-1
}
    429c:	8082                	ret

000000000000429e <rewind>:
    if (stream)
    429e:	c915                	beqz	a0,42d2 <rewind+0x34>
    if (stream->buf_write_pos > 0)
    42a0:	41052603          	lw	a2,1040(a0)
{
    42a4:	1141                	addi	sp,sp,-16
    42a6:	e022                	sd	s0,0(sp)
    42a8:	e406                	sd	ra,8(sp)
    42aa:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    42ac:	02c04463          	bgtz	a2,42d4 <rewind+0x36>
    if (lseek(stream->fd, offset, whence) < 0)
    42b0:	4008                	lw	a0,0(s0)
    stream->buf_read_pos = 0;
    42b2:	40042a23          	sw	zero,1044(s0)
    stream->buf_read_cnt = 0;
    42b6:	40042c23          	sw	zero,1048(s0)
    stream->eof = 0;
    42ba:	00042623          	sw	zero,12(s0)
    if (lseek(stream->fd, offset, whence) < 0)
    42be:	4601                	li	a2,0
    42c0:	4581                	li	a1,0
    42c2:	f95fb0ef          	jal	256 <lseek>
}
    42c6:	60a2                	ld	ra,8(sp)
        stream->error = 0;
    42c8:	00042423          	sw	zero,8(s0)
}
    42cc:	6402                	ld	s0,0(sp)
    42ce:	0141                	addi	sp,sp,16
    42d0:	8082                	ret
    42d2:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    42d4:	4108                	lw	a0,0(a0)
    42d6:	01040593          	addi	a1,s0,16
    42da:	eedfb0ef          	jal	1c6 <write>
        if (ret < stream->buf_write_pos)
    42de:	41042783          	lw	a5,1040(s0)
    42e2:	00f54563          	blt	a0,a5,42ec <rewind+0x4e>
        stream->buf_write_pos = 0;
    42e6:	40042823          	sw	zero,1040(s0)
    42ea:	b7d9                	j	42b0 <rewind+0x12>
            stream->error = 1;
    42ec:	4785                	li	a5,1
    42ee:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    42f0:	40042823          	sw	zero,1040(s0)
            return EOF;
    42f4:	bf75                	j	42b0 <rewind+0x12>

00000000000042f6 <feof>:
    return (stream) ? stream->eof : 1;
    42f6:	c119                	beqz	a0,42fc <feof+0x6>
    42f8:	4548                	lw	a0,12(a0)
    42fa:	8082                	ret
    42fc:	4505                	li	a0,1
}
    42fe:	8082                	ret

0000000000004300 <ferror>:
     return (stream) ? stream->error : 1;
    4300:	c119                	beqz	a0,4306 <ferror+0x6>
    4302:	4508                	lw	a0,8(a0)
    4304:	8082                	ret
    4306:	4505                	li	a0,1
}
    4308:	8082                	ret

000000000000430a <clearerr>:
    if (stream)
    430a:	c509                	beqz	a0,4314 <clearerr+0xa>
        stream->error = 0;
    430c:	00052423          	sw	zero,8(a0)
        stream->eof = 0;
    4310:	00052623          	sw	zero,12(a0)
}
    4314:	8082                	ret

0000000000004316 <ungetc>:
    if (!stream || c == EOF)
    4316:	c19d                	beqz	a1,433c <ungetc+0x26>
    4318:	57fd                	li	a5,-1
    431a:	02f50163          	beq	a0,a5,433c <ungetc+0x26>
    if (stream->buf_read_pos > 0)
    431e:	4145a783          	lw	a5,1044(a1)
    4322:	00f05d63          	blez	a5,433c <ungetc+0x26>
        stream->buf_read_pos--;
    4326:	fff7871b          	addiw	a4,a5,-1
    432a:	40e5aa23          	sw	a4,1044(a1)
        stream->buffer[stream->buf_read_pos] = (char)c;
    432e:	00e587b3          	add	a5,a1,a4
    4332:	00a78823          	sb	a0,16(a5)
        stream->eof = 0;
    4336:	0005a623          	sw	zero,12(a1)
        return c;
    433a:	8082                	ret
        return EOF;
    433c:	557d                	li	a0,-1
    433e:	8082                	ret

0000000000004340 <strtoull.part.0>:
    return new_ptr;
}

/* String Conversion*/

unsigned long long strtoull(const char *nptr, char **endptr, int base)
    4340:	1141                	addi	sp,sp,-16
    4342:	e422                	sd	s0,8(sp)
    4344:	8eaa                	mv	t4,a0
{
    const char *s = nptr;
    4346:	88aa                	mv	a7,a0
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    static inline int islower(int c) { return c >= 'a' && c <= 'z'; }
    static inline int isupper(int c) { return c >= 'A' && c <= 'Z'; }
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    static inline int isalnum(int c) { return isalpha(c) || isdigit(c); }
    static inline int isspace(int c) { return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r'; }
    4348:	02000313          	li	t1,32
    434c:	4e11                	li	t3,4
        return 0;
    }

    do
    {
        c = *s++;
    434e:	0008c783          	lbu	a5,0(a7)
    4352:	00188813          	addi	a6,a7,1
    4356:	ff77871b          	addiw	a4,a5,-9
    435a:	0ff77693          	zext.b	a3,a4
    435e:	0007871b          	sext.w	a4,a5
    4362:	04678363          	beq	a5,t1,43a8 <strtoull.part.0+0x68>
    4366:	04de7163          	bgeu	t3,a3,43a8 <strtoull.part.0+0x68>
    } while (isspace(c));

    if (c == '-')
    436a:	02d00793          	li	a5,45
    436e:	0ef70863          	beq	a4,a5,445e <strtoull.part.0+0x11e>
    {
        neg = 1;
        c = *s++;
    }
    else if (c == '+')
    4372:	02b00793          	li	a5,43
    int neg = 0, any, cutlim;
    4376:	4381                	li	t2,0
    else if (c == '+')
    4378:	08f70c63          	beq	a4,a5,4410 <strtoull.part.0+0xd0>
    {
        c = *s++;
    }

    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    437c:	ea05                	bnez	a2,43ac <strtoull.part.0+0x6c>
    437e:	03000793          	li	a5,48
    4382:	0ef70463          	beq	a4,a5,446a <strtoull.part.0+0x12a>
    4386:	00ccd8b7          	lui	a7,0xccd
    438a:	ccd88893          	addi	a7,a7,-819 # cccccd <_ZSt4cerr+0xcc5355>
    438e:	08b2                	slli	a7,a7,0xc
    4390:	ccd88893          	addi	a7,a7,-819
    4394:	08b2                	slli	a7,a7,0xc
    4396:	ccd88893          	addi	a7,a7,-819
    439a:	08b6                	slli	a7,a7,0xd
    439c:	4415                	li	s0,5
    439e:	99988893          	addi	a7,a7,-1639
    43a2:	42a9                	li	t0,10
        c = s[1];
        s += 2;
        base = 16;
    }
    if (base == 0)
        base = (c == '0' ? 8 : 10);
    43a4:	4629                	li	a2,10
    43a6:	a829                	j	43c0 <strtoull.part.0+0x80>
unsigned long long strtoull(const char *nptr, char **endptr, int base)
    43a8:	88c2                	mv	a7,a6
    43aa:	b755                	j	434e <strtoull.part.0+0xe>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    43ac:	47c1                	li	a5,16
    43ae:	0cf60d63          	beq	a2,a5,4488 <strtoull.part.0+0x148>

    cutoff = ULLONG_MAX / (unsigned long long)base;
    43b2:	58fd                	li	a7,-1
    cutlim = ULLONG_MAX % (unsigned long long)base;
    43b4:	02c8f433          	remu	s0,a7,a2
    cutoff = ULLONG_MAX / (unsigned long long)base;
    43b8:	82b2                	mv	t0,a2
    43ba:	02c8d8b3          	divu	a7,a7,a2
    cutlim = ULLONG_MAX % (unsigned long long)base;
    43be:	2401                	sext.w	s0,s0

    for (acc = 0, any = 0;; c = *s++)
    43c0:	4301                	li	t1,0
    43c2:	4501                	li	a0,0
    {
        if (isdigit(c))
    43c4:	4e25                	li	t3,9
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    43c6:	4fe5                	li	t6,25
            break;

        if (c >= base)
            break;

        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    43c8:	5f7d                	li	t5,-1
        if (isdigit(c))
    43ca:	fd07079b          	addiw	a5,a4,-48
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    43ce:	0007069b          	sext.w	a3,a4
    43d2:	00fe7e63          	bgeu	t3,a5,43ee <strtoull.part.0+0xae>
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    43d6:	f9f6879b          	addiw	a5,a3,-97
    43da:	04fff063          	bgeu	t6,a5,441a <strtoull.part.0+0xda>
    43de:	fbf6869b          	addiw	a3,a3,-65
    43e2:	04dfe163          	bltu	t6,a3,4424 <strtoull.part.0+0xe4>
            c -= isupper(c) ? 'A' - 10 : 'a' - 10;
    43e6:	03700793          	li	a5,55
    43ea:	40f707bb          	subw	a5,a4,a5
        if (c >= base)
    43ee:	02c7db63          	bge	a5,a2,4424 <strtoull.part.0+0xe4>
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    43f2:	01e30b63          	beq	t1,t5,4408 <strtoull.part.0+0xc8>
            any = -1;
    43f6:	537d                	li	t1,-1
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    43f8:	00a8e863          	bltu	a7,a0,4408 <strtoull.part.0+0xc8>
    43fc:	05150e63          	beq	a0,a7,4458 <strtoull.part.0+0x118>
        else
        {
            any = 1;
    4400:	4305                	li	t1,1
            acc *= base;
    4402:	02550533          	mul	a0,a0,t0
            acc += c;
    4406:	953e                	add	a0,a0,a5
    for (acc = 0, any = 0;; c = *s++)
    4408:	0805                	addi	a6,a6,1
    440a:	fff84703          	lbu	a4,-1(a6)
        if (isdigit(c))
    440e:	bf75                	j	43ca <strtoull.part.0+0x8a>
        c = *s++;
    4410:	00084703          	lbu	a4,0(a6)
    4414:	00288813          	addi	a6,a7,2
    4418:	b795                	j	437c <strtoull.part.0+0x3c>
            c -= isupper(c) ? 'A' - 10 : 'a' - 10;
    441a:	05700793          	li	a5,87
    441e:	40f707bb          	subw	a5,a4,a5
    4422:	b7f1                	j	43ee <strtoull.part.0+0xae>
        }
    }

    if (any < 0)
    4424:	57fd                	li	a5,-1
    4426:	00f30e63          	beq	t1,a5,4442 <strtoull.part.0+0x102>
    {
        acc = ULLONG_MAX;
        errno = ERANGE;
    }
    else if (neg)
    442a:	00038463          	beqz	t2,4432 <strtoull.part.0+0xf2>
        acc = -acc;
    442e:	40a00533          	neg	a0,a0

    if (endptr != 0)
    4432:	c589                	beqz	a1,443c <strtoull.part.0+0xfc>
        *endptr = (char *)(any ? s - 1 : nptr);
    4434:	00031f63          	bnez	t1,4452 <strtoull.part.0+0x112>
    4438:	01d5b023          	sd	t4,0(a1)

    return acc;
}
    443c:	6422                	ld	s0,8(sp)
    443e:	0141                	addi	sp,sp,16
    4440:	8082                	ret
        errno = ERANGE;
    4442:	02200793          	li	a5,34
    4446:	00003717          	auipc	a4,0x3
    444a:	3ef72d23          	sw	a5,1018(a4) # 7840 <errno>
        acc = ULLONG_MAX;
    444e:	557d                	li	a0,-1
    if (endptr != 0)
    4450:	d5f5                	beqz	a1,443c <strtoull.part.0+0xfc>
        *endptr = (char *)(any ? s - 1 : nptr);
    4452:	fff80e93          	addi	t4,a6,-1
    4456:	b7cd                	j	4438 <strtoull.part.0+0xf8>
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    4458:	faf448e3          	blt	s0,a5,4408 <strtoull.part.0+0xc8>
    445c:	b755                	j	4400 <strtoull.part.0+0xc0>
        c = *s++;
    445e:	00084703          	lbu	a4,0(a6)
        neg = 1;
    4462:	4385                	li	t2,1
        c = *s++;
    4464:	00288813          	addi	a6,a7,2
    4468:	bf11                	j	437c <strtoull.part.0+0x3c>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    446a:	00084783          	lbu	a5,0(a6)
    446e:	05800693          	li	a3,88
    4472:	0df7f793          	andi	a5,a5,223
    4476:	02d78b63          	beq	a5,a3,44ac <strtoull.part.0+0x16c>
    447a:	58fd                	li	a7,-1
    447c:	441d                	li	s0,7
    447e:	0038d893          	srli	a7,a7,0x3
    4482:	42a1                	li	t0,8
        base = (c == '0' ? 8 : 10);
    4484:	4621                	li	a2,8
    4486:	bf2d                	j	43c0 <strtoull.part.0+0x80>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    4488:	03000793          	li	a5,48
    448c:	00f70863          	beq	a4,a5,449c <strtoull.part.0+0x15c>
    4490:	58fd                	li	a7,-1
    4492:	443d                	li	s0,15
    4494:	0048d893          	srli	a7,a7,0x4
    4498:	42c1                	li	t0,16
    449a:	b71d                	j	43c0 <strtoull.part.0+0x80>
    449c:	00084783          	lbu	a5,0(a6)
    44a0:	05800693          	li	a3,88
    44a4:	0df7f793          	andi	a5,a5,223
    44a8:	fed794e3          	bne	a5,a3,4490 <strtoull.part.0+0x150>
        s += 2;
    44ac:	58fd                	li	a7,-1
        c = s[1];
    44ae:	00184703          	lbu	a4,1(a6)
        s += 2;
    44b2:	443d                	li	s0,15
    44b4:	0809                	addi	a6,a6,2
    44b6:	0048d893          	srli	a7,a7,0x4
    44ba:	42c1                	li	t0,16
        base = 16;
    44bc:	4641                	li	a2,16
    44be:	b709                	j	43c0 <strtoull.part.0+0x80>

00000000000044c0 <atexit>:
    if (__atexit_func_count >= ATEXIT_MAX)
    44c0:	00003717          	auipc	a4,0x3
    44c4:	38070713          	addi	a4,a4,896 # 7840 <errno>
    44c8:	435c                	lw	a5,4(a4)
    44ca:	46fd                	li	a3,31
    44cc:	00f6ca63          	blt	a3,a5,44e0 <atexit+0x20>
    __atexit_funcs[__atexit_func_count++] = function;
    44d0:	00379693          	slli	a3,a5,0x3
    44d4:	96ba                	add	a3,a3,a4
    44d6:	2785                	addiw	a5,a5,1
    44d8:	e688                	sd	a0,8(a3)
    44da:	c35c                	sw	a5,4(a4)
    return 0;
    44dc:	4501                	li	a0,0
    44de:	8082                	ret
        return -1;
    44e0:	557d                	li	a0,-1
}
    44e2:	8082                	ret

00000000000044e4 <exit>:
{
    44e4:	1101                	addi	sp,sp,-32
    44e6:	e822                	sd	s0,16(sp)
    while (__atexit_func_count > 0)
    44e8:	00003417          	auipc	s0,0x3
    44ec:	35840413          	addi	s0,s0,856 # 7840 <errno>
    44f0:	405c                	lw	a5,4(s0)
{
    44f2:	e426                	sd	s1,8(sp)
    44f4:	ec06                	sd	ra,24(sp)
    44f6:	84aa                	mv	s1,a0
    while (__atexit_func_count > 0)
    44f8:	00f05d63          	blez	a5,4512 <exit+0x2e>
        (__atexit_funcs[--__atexit_func_count])();
    44fc:	fff7871b          	addiw	a4,a5,-1
    4500:	87ba                	mv	a5,a4
    4502:	070e                	slli	a4,a4,0x3
    4504:	9722                	add	a4,a4,s0
    4506:	6718                	ld	a4,8(a4)
    4508:	c05c                	sw	a5,4(s0)
    450a:	9702                	jalr	a4
    while (__atexit_func_count > 0)
    450c:	405c                	lw	a5,4(s0)
    450e:	fef047e3          	bgtz	a5,44fc <exit+0x18>
    sys_exit(status);
    4512:	8526                	mv	a0,s1
    4514:	c8bfb0ef          	jal	19e <sys_exit>
    while (1)
    4518:	a001                	j	4518 <exit+0x34>

000000000000451a <abort>:
{
    451a:	1141                	addi	sp,sp,-16
    exit(127);
    451c:	07f00513          	li	a0,127
{
    4520:	e406                	sd	ra,8(sp)
    exit(127);
    4522:	fc3ff0ef          	jal	44e4 <exit>

0000000000004526 <getenv>:
}
    4526:	4501                	li	a0,0
    4528:	8082                	ret

000000000000452a <system>:
}
    452a:	557d                	li	a0,-1
    452c:	8082                	ret

000000000000452e <free>:
    if (!ptr)
    452e:	c121                	beqz	a0,456e <free+0x40>
    for (p = freep; !(bp > p && bp < p->next); p = p->next)
    4530:	00003617          	auipc	a2,0x3
    4534:	31060613          	addi	a2,a2,784 # 7840 <errno>
    4538:	10863783          	ld	a5,264(a2)
    bp = (header_t *)ptr - 1;
    453c:	ff050693          	addi	a3,a0,-16
        if (p >= p->next && (bp > p || bp < p->next))
    4540:	6798                	ld	a4,8(a5)
    for (p = freep; !(bp > p && bp < p->next); p = p->next)
    4542:	02d7f763          	bgeu	a5,a3,4570 <free+0x42>
    4546:	00e6e463          	bltu	a3,a4,454e <free+0x20>
        if (p >= p->next && (bp > p || bp < p->next))
    454a:	02e7e763          	bltu	a5,a4,4578 <free+0x4a>
    if ((char *)bp + bp->size == (char *)p->next)
    454e:	ff053583          	ld	a1,-16(a0)
    4552:	00b68833          	add	a6,a3,a1
    4556:	03070363          	beq	a4,a6,457c <free+0x4e>
    if ((char *)p + p->size == (char *)bp)
    455a:	638c                	ld	a1,0(a5)
    455c:	fee53c23          	sd	a4,-8(a0)
    4560:	00b78833          	add	a6,a5,a1
    4564:	03068963          	beq	a3,a6,4596 <free+0x68>
    4568:	e794                	sd	a3,8(a5)
    freep = p;
    456a:	10f63423          	sd	a5,264(a2)
}
    456e:	8082                	ret
        if (p >= p->next && (bp > p || bp < p->next))
    4570:	00e7e463          	bltu	a5,a4,4578 <free+0x4a>
    4574:	fce6ede3          	bltu	a3,a4,454e <free+0x20>
{
    4578:	87ba                	mv	a5,a4
    457a:	b7d9                	j	4540 <free+0x12>
        bp->size += p->next->size;
    457c:	00073803          	ld	a6,0(a4)
        bp->next = p->next->next;
    4580:	6718                	ld	a4,8(a4)
        bp->size += p->next->size;
    4582:	95c2                	add	a1,a1,a6
    4584:	feb53823          	sd	a1,-16(a0)
    if ((char *)p + p->size == (char *)bp)
    4588:	638c                	ld	a1,0(a5)
    458a:	fee53c23          	sd	a4,-8(a0)
    458e:	00b78833          	add	a6,a5,a1
    4592:	fd069be3          	bne	a3,a6,4568 <free+0x3a>
        p->size += bp->size;
    4596:	ff053503          	ld	a0,-16(a0)
        p->next = bp->next;
    459a:	86ba                	mv	a3,a4
        p->size += bp->size;
    459c:	00b50733          	add	a4,a0,a1
    45a0:	e398                	sd	a4,0(a5)
        p->next = bp->next;
    45a2:	b7d9                	j	4568 <free+0x3a>

00000000000045a4 <malloc>:
    if (size == 0)
    45a4:	c169                	beqz	a0,4666 <malloc+0xc2>
{
    45a6:	7179                	addi	sp,sp,-48
    45a8:	ec26                	sd	s1,24(sp)
    if ((prevp = freep) == NULL)
    45aa:	00003497          	auipc	s1,0x3
    45ae:	29648493          	addi	s1,s1,662 # 7840 <errno>
    45b2:	1084b783          	ld	a5,264(s1)
{
    45b6:	f022                	sd	s0,32(sp)
    size = ALIGN(size + sizeof(header_t));
    45b8:	057d                	addi	a0,a0,31
{
    45ba:	f406                	sd	ra,40(sp)
    size = ALIGN(size + sizeof(header_t));
    45bc:	ff057413          	andi	s0,a0,-16
    if ((prevp = freep) == NULL)
    45c0:	c3d1                	beqz	a5,4644 <malloc+0xa0>
    for (p = prevp->next;; prevp = p, p = p->next)
    45c2:	6788                	ld	a0,8(a5)
        if (p->size >= size)
    45c4:	6118                	ld	a4,0(a0)
    45c6:	06877163          	bgeu	a4,s0,4628 <malloc+0x84>
    45ca:	e44e                	sd	s3,8(sp)
    45cc:	e052                	sd	s4,0(sp)
    45ce:	e84a                	sd	s2,16(sp)
    if (nu < 4096)
    45d0:	6a05                	lui	s4,0x1
    if (cp == (void *)-1)
    45d2:	59fd                	li	s3,-1
    45d4:	a029                	j	45de <malloc+0x3a>
    for (p = prevp->next;; prevp = p, p = p->next)
    45d6:	6788                	ld	a0,8(a5)
        if (p->size >= size)
    45d8:	6118                	ld	a4,0(a0)
    45da:	04877463          	bgeu	a4,s0,4622 <malloc+0x7e>
        if (p == freep)
    45de:	1084b703          	ld	a4,264(s1)
    45e2:	87aa                	mv	a5,a0
    45e4:	fee519e3          	bne	a0,a4,45d6 <malloc+0x32>
    if (nu < 4096)
    45e8:	8922                	mv	s2,s0
    45ea:	01447363          	bgeu	s0,s4,45f0 <malloc+0x4c>
    45ee:	6905                	lui	s2,0x1
    cp = (char *)sbrk(nu);
    45f0:	854a                	mv	a0,s2
    45f2:	c3dfb0ef          	jal	22e <sbrk>
    45f6:	87aa                	mv	a5,a0
    free((void *)(up + 1));
    45f8:	0541                	addi	a0,a0,16
    if (cp == (void *)-1)
    45fa:	01378963          	beq	a5,s3,460c <malloc+0x68>
    up->size = nu;
    45fe:	0127b023          	sd	s2,0(a5)
    free((void *)(up + 1));
    4602:	f2dff0ef          	jal	452e <free>
    return freep;
    4606:	1084b783          	ld	a5,264(s1)
            if ((p = morecore(size)) == NULL)
    460a:	f7f1                	bnez	a5,45d6 <malloc+0x32>
}
    460c:	70a2                	ld	ra,40(sp)
    460e:	7402                	ld	s0,32(sp)
                errno = ENOMEM;
    4610:	47b1                	li	a5,12
    4612:	c09c                	sw	a5,0(s1)
                return NULL;
    4614:	6942                	ld	s2,16(sp)
    4616:	69a2                	ld	s3,8(sp)
    4618:	6a02                	ld	s4,0(sp)
}
    461a:	64e2                	ld	s1,24(sp)
        return NULL;
    461c:	4501                	li	a0,0
}
    461e:	6145                	addi	sp,sp,48
    4620:	8082                	ret
    4622:	6942                	ld	s2,16(sp)
    4624:	69a2                	ld	s3,8(sp)
    4626:	6a02                	ld	s4,0(sp)
            if (p->size == size)
    4628:	02e40c63          	beq	s0,a4,4660 <malloc+0xbc>
                p->size -= size;
    462c:	8f01                	sub	a4,a4,s0
    462e:	e118                	sd	a4,0(a0)
                p = (header_t *)((char *)p + p->size);
    4630:	953a                	add	a0,a0,a4
                p->size = size;
    4632:	e100                	sd	s0,0(a0)
}
    4634:	70a2                	ld	ra,40(sp)
    4636:	7402                	ld	s0,32(sp)
            freep = prevp;
    4638:	10f4b423          	sd	a5,264(s1)
            return (void *)(p + 1);
    463c:	0541                	addi	a0,a0,16
}
    463e:	64e2                	ld	s1,24(sp)
    4640:	6145                	addi	sp,sp,48
    4642:	8082                	ret
        base.next = freep = prevp = &base;
    4644:	00003517          	auipc	a0,0x3
    4648:	30c50513          	addi	a0,a0,780 # 7950 <base>
    464c:	10a4b423          	sd	a0,264(s1)
    4650:	10a4bc23          	sd	a0,280(s1)
        base.size = 0;
    4654:	00003797          	auipc	a5,0x3
    4658:	2e07be23          	sd	zero,764(a5) # 7950 <base>
        if (p->size >= size)
    465c:	f43d                	bnez	s0,45ca <malloc+0x26>
        base.next = freep = prevp = &base;
    465e:	87aa                	mv	a5,a0
                prevp->next = p->next;
    4660:	6518                	ld	a4,8(a0)
    4662:	e798                	sd	a4,8(a5)
    4664:	bfc1                	j	4634 <malloc+0x90>
        return NULL;
    4666:	4501                	li	a0,0
}
    4668:	8082                	ret

000000000000466a <calloc>:
    if (__builtin_mul_overflow(nmemb, size, &total))
    466a:	02b537b3          	mulhu	a5,a0,a1
{
    466e:	1101                	addi	sp,sp,-32
    4670:	e822                	sd	s0,16(sp)
    4672:	ec06                	sd	ra,24(sp)
    4674:	e426                	sd	s1,8(sp)
    if (__builtin_mul_overflow(nmemb, size, &total))
    4676:	02b50433          	mul	s0,a0,a1
    467a:	e385                	bnez	a5,469a <calloc+0x30>
    void *p = malloc(total);
    467c:	8522                	mv	a0,s0
    467e:	f27ff0ef          	jal	45a4 <malloc>
    4682:	84aa                	mv	s1,a0
    if (p)
    4684:	c509                	beqz	a0,468e <calloc+0x24>
        memset(p, 0, total);
    4686:	8622                	mv	a2,s0
    4688:	4581                	li	a1,0
    468a:	524000ef          	jal	4bae <memset>
}
    468e:	60e2                	ld	ra,24(sp)
    4690:	6442                	ld	s0,16(sp)
    4692:	8526                	mv	a0,s1
    4694:	64a2                	ld	s1,8(sp)
    4696:	6105                	addi	sp,sp,32
    4698:	8082                	ret
    469a:	60e2                	ld	ra,24(sp)
    469c:	6442                	ld	s0,16(sp)
        errno = ENOMEM;
    469e:	47b1                	li	a5,12
        return NULL;
    46a0:	4481                	li	s1,0
        errno = ENOMEM;
    46a2:	00003717          	auipc	a4,0x3
    46a6:	18f72f23          	sw	a5,414(a4) # 7840 <errno>
}
    46aa:	8526                	mv	a0,s1
    46ac:	64a2                	ld	s1,8(sp)
    46ae:	6105                	addi	sp,sp,32
    46b0:	8082                	ret

00000000000046b2 <realloc>:
    if (!ptr)
    46b2:	c929                	beqz	a0,4704 <realloc+0x52>
{
    46b4:	1101                	addi	sp,sp,-32
    46b6:	ec06                	sd	ra,24(sp)
    46b8:	e426                	sd	s1,8(sp)
    if (size == 0)
    46ba:	c5b9                	beqz	a1,4708 <realloc+0x56>
    if (bp->size >= new_size)
    46bc:	ff053703          	ld	a4,-16(a0)
    size_t new_size = ALIGN(size + sizeof(header_t));
    46c0:	01f58793          	addi	a5,a1,31
    46c4:	e822                	sd	s0,16(sp)
    46c6:	9bc1                	andi	a5,a5,-16
    46c8:	842a                	mv	s0,a0
        return ptr;
    46ca:	84aa                	mv	s1,a0
    if (bp->size >= new_size)
    46cc:	00f76863          	bltu	a4,a5,46dc <realloc+0x2a>
    46d0:	6442                	ld	s0,16(sp)
}
    46d2:	60e2                	ld	ra,24(sp)
    46d4:	8526                	mv	a0,s1
    46d6:	64a2                	ld	s1,8(sp)
    46d8:	6105                	addi	sp,sp,32
    46da:	8082                	ret
    void *new_ptr = malloc(size);
    46dc:	852e                	mv	a0,a1
    46de:	ec7ff0ef          	jal	45a4 <malloc>
    46e2:	84aa                	mv	s1,a0
    if (!new_ptr)
    46e4:	d575                	beqz	a0,46d0 <realloc+0x1e>
    memcpy(new_ptr, ptr, bp->size - sizeof(header_t));
    46e6:	ff043603          	ld	a2,-16(s0)
    46ea:	85a2                	mv	a1,s0
    46ec:	1641                	addi	a2,a2,-16
    46ee:	514000ef          	jal	4c02 <memcpy>
    free(ptr);
    46f2:	8522                	mv	a0,s0
    46f4:	e3bff0ef          	jal	452e <free>
}
    46f8:	60e2                	ld	ra,24(sp)
    free(ptr);
    46fa:	6442                	ld	s0,16(sp)
}
    46fc:	8526                	mv	a0,s1
    46fe:	64a2                	ld	s1,8(sp)
    4700:	6105                	addi	sp,sp,32
    4702:	8082                	ret
        return malloc(size);
    4704:	852e                	mv	a0,a1
    4706:	bd79                	j	45a4 <malloc>
        free(ptr);
    4708:	e27ff0ef          	jal	452e <free>
        return NULL;
    470c:	4481                	li	s1,0
    470e:	b7d1                	j	46d2 <realloc+0x20>

0000000000004710 <strtoull>:
    if (base < 0 || base == 1 || base > 36)
    4710:	02400813          	li	a6,36
{
    4714:	86aa                	mv	a3,a0
    4716:	872e                	mv	a4,a1
    if (base < 0 || base == 1 || base > 36)
    4718:	00c86663          	bltu	a6,a2,4724 <strtoull+0x14>
    471c:	4805                	li	a6,1
    471e:	01060363          	beq	a2,a6,4724 <strtoull+0x14>
    4722:	b939                	j	4340 <strtoull.part.0>
        if (endptr)
    4724:	c311                	beqz	a4,4728 <strtoull+0x18>
            *endptr = (char *)nptr;
    4726:	e314                	sd	a3,0(a4)
        errno = 0; /* EINVAL */
    4728:	00003797          	auipc	a5,0x3
    472c:	1007ac23          	sw	zero,280(a5) # 7840 <errno>
}
    4730:	4501                	li	a0,0
    4732:	8082                	ret

0000000000004734 <strtoll>:

long long strtoll(const char *nptr, char **endptr, int base)
{
    4734:	1141                	addi	sp,sp,-16
    4736:	e406                	sd	ra,8(sp)
    4738:	e022                	sd	s0,0(sp)
    const char *s = nptr;
    473a:	86aa                	mv	a3,a0
    static inline int isspace(int c) { return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r'; }
    473c:	02000813          	li	a6,32
    4740:	4891                	li	a7,4
    unsigned long long acc;
    int c, neg = 0;

    do
    {
        c = *s++;
    4742:	0006c783          	lbu	a5,0(a3)
    4746:	0685                	addi	a3,a3,1
    4748:	ff77871b          	addiw	a4,a5,-9
    474c:	0ff77713          	zext.b	a4,a4
    4750:	0007841b          	sext.w	s0,a5
    4754:	ff0787e3          	beq	a5,a6,4742 <strtoll+0xe>
    4758:	fee8f5e3          	bgeu	a7,a4,4742 <strtoll+0xe>
    if (base < 0 || base == 1 || base > 36)
    475c:	02400793          	li	a5,36
    4760:	02c7ec63          	bltu	a5,a2,4798 <strtoll+0x64>
    4764:	4785                	li	a5,1
    4766:	02f60963          	beq	a2,a5,4798 <strtoll+0x64>
    476a:	bd7ff0ef          	jal	4340 <strtoull.part.0>
    if (c == '-')
        neg = 1;

    acc = strtoull(nptr, endptr, base);

    if (errno == ERANGE && acc == ULLONG_MAX)
    476e:	00003797          	auipc	a5,0x3
    4772:	0d278793          	addi	a5,a5,210 # 7840 <errno>
    4776:	4394                	lw	a3,0(a5)
    4778:	02200713          	li	a4,34
    477c:	04e68363          	beq	a3,a4,47c2 <strtoll+0x8e>
        return neg ? LLONG_MIN : LLONG_MAX;

    if (!neg && acc > (unsigned long long)LLONG_MAX)
    4780:	02d00713          	li	a4,45
    4784:	02e40563          	beq	s0,a4,47ae <strtoll+0x7a>
    4788:	00055f63          	bgez	a0,47a6 <strtoll+0x72>
    {
        errno = ERANGE;
    478c:	02200713          	li	a4,34
    4790:	c398                	sw	a4,0(a5)
        return neg ? LLONG_MIN : LLONG_MAX;
    4792:	557d                	li	a0,-1
    4794:	8105                	srli	a0,a0,0x1
    4796:	a801                	j	47a6 <strtoll+0x72>
        if (endptr)
    4798:	c191                	beqz	a1,479c <strtoll+0x68>
            *endptr = (char *)nptr;
    479a:	e188                	sd	a0,0(a1)
        errno = 0; /* EINVAL */
    479c:	00003797          	auipc	a5,0x3
    47a0:	0a07a223          	sw	zero,164(a5) # 7840 <errno>
    {
        errno = ERANGE;
        return LLONG_MIN;
    }

    return neg ? -(long long)acc : (long long)acc;
    47a4:	4501                	li	a0,0
}
    47a6:	60a2                	ld	ra,8(sp)
    47a8:	6402                	ld	s0,0(sp)
    47aa:	0141                	addi	sp,sp,16
    47ac:	8082                	ret
    if (neg && acc > (unsigned long long)LLONG_MAX + 1)
    47ae:	577d                	li	a4,-1
    47b0:	177e                	slli	a4,a4,0x3f
    47b2:	02a76263          	bltu	a4,a0,47d6 <strtoll+0xa2>
}
    47b6:	60a2                	ld	ra,8(sp)
    47b8:	6402                	ld	s0,0(sp)
    return neg ? -(long long)acc : (long long)acc;
    47ba:	40a00533          	neg	a0,a0
}
    47be:	0141                	addi	sp,sp,16
    47c0:	8082                	ret
    if (errno == ERANGE && acc == ULLONG_MAX)
    47c2:	577d                	li	a4,-1
    47c4:	fae51ee3          	bne	a0,a4,4780 <strtoll+0x4c>
        return neg ? LLONG_MIN : LLONG_MAX;
    47c8:	02d00793          	li	a5,45
    47cc:	fcf413e3          	bne	s0,a5,4792 <strtoll+0x5e>
        return LLONG_MIN;
    47d0:	557d                	li	a0,-1
    47d2:	157e                	slli	a0,a0,0x3f
    47d4:	bfc9                	j	47a6 <strtoll+0x72>
        errno = ERANGE;
    47d6:	02200713          	li	a4,34
    47da:	c398                	sw	a4,0(a5)
        return LLONG_MIN;
    47dc:	bfd5                	j	47d0 <strtoll+0x9c>

00000000000047de <strtoul>:
    if (base < 0 || base == 1 || base > 36)
    47de:	02400813          	li	a6,36

unsigned long strtoul(const char *nptr, char **endptr, int base)
{
    47e2:	86aa                	mv	a3,a0
    47e4:	872e                	mv	a4,a1
    if (base < 0 || base == 1 || base > 36)
    47e6:	00c86663          	bltu	a6,a2,47f2 <strtoul+0x14>
    47ea:	4805                	li	a6,1
    47ec:	01060363          	beq	a2,a6,47f2 <strtoul+0x14>
    47f0:	be81                	j	4340 <strtoull.part.0>
        if (endptr)
    47f2:	c311                	beqz	a4,47f6 <strtoul+0x18>
            *endptr = (char *)nptr;
    47f4:	e314                	sd	a3,0(a4)
        errno = 0; /* EINVAL */
    47f6:	00003797          	auipc	a5,0x3
    47fa:	0407a523          	sw	zero,74(a5) # 7840 <errno>
    {
        errno = ERANGE;
        return ULONG_MAX;
    }
    return (unsigned long)ret;
}
    47fe:	4501                	li	a0,0
    4800:	8082                	ret

0000000000004802 <strtol>:

long strtol(const char *nptr, char **endptr, int base)
{
    long long ret = strtoll(nptr, endptr, base);
    4802:	bf0d                	j	4734 <strtoll>

0000000000004804 <atoi>:
        return LONG_MIN;
    }
    return (long)ret;
}

int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    4804:	1141                	addi	sp,sp,-16
    long long ret = strtoll(nptr, endptr, base);
    4806:	4629                	li	a2,10
    4808:	4581                	li	a1,0
int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    480a:	e406                	sd	ra,8(sp)
    long long ret = strtoll(nptr, endptr, base);
    480c:	f29ff0ef          	jal	4734 <strtoll>
int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    4810:	60a2                	ld	ra,8(sp)
    4812:	2501                	sext.w	a0,a0
    4814:	0141                	addi	sp,sp,16
    4816:	8082                	ret

0000000000004818 <atol>:
    long long ret = strtoll(nptr, endptr, base);
    4818:	4629                	li	a2,10
    481a:	4581                	li	a1,0
    481c:	bf21                	j	4734 <strtoll>

000000000000481e <atoll>:
long atol(const char *nptr) { return strtol(nptr, NULL, 10); }
long long atoll(const char *nptr) { return strtoll(nptr, NULL, 10); }
    481e:	4629                	li	a2,10
    4820:	4581                	li	a1,0
    4822:	bf09                	j	4734 <strtoll>

0000000000004824 <strtod>:
    4824:	02000693          	li	a3,32
    4828:	4611                	li	a2,4
{
    double val = 0.0;
    int sign = 1;
    const char *s = nptr;

    while (isspace(*s))
    482a:	00054783          	lbu	a5,0(a0)
    482e:	ff77871b          	addiw	a4,a5,-9
    4832:	0ff77713          	zext.b	a4,a4
    4836:	06d78263          	beq	a5,a3,489a <strtod+0x76>
    483a:	06e67063          	bgeu	a2,a4,489a <strtod+0x76>
        s++;
    if (*s == '-')
    483e:	02d00713          	li	a4,45
    4842:	08e78e63          	beq	a5,a4,48de <strtod+0xba>
    {
        sign = -1;
        s++;
    }
    else if (*s == '+')
    4846:	02b00713          	li	a4,43
    484a:	0ae78263          	beq	a5,a4,48ee <strtod+0xca>
    484e:	00001717          	auipc	a4,0x1
    4852:	0a273507          	fld	fa0,162(a4) # 58f0 <STDIN_FD+0x10>
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    4856:	fd07861b          	addiw	a2,a5,-48
        s++;

    while (isdigit(*s))
    485a:	46a5                	li	a3,9
    485c:	f20007d3          	fmv.d.x	fa5,zero
    4860:	8732                	mv	a4,a2
    4862:	02c6e363          	bltu	a3,a2,4888 <strtod+0x64>
    4866:	00001797          	auipc	a5,0x1
    486a:	0927b687          	fld	fa3,146(a5) # 58f8 <STDIN_FD+0x18>
    486e:	4625                	li	a2,9
    4870:	00154783          	lbu	a5,1(a0)
    {
        val = val * 10.0 + (*s - '0');
    4874:	d2070753          	fcvt.d.w	fa4,a4
        s++;
    4878:	0505                	addi	a0,a0,1
    487a:	fd07869b          	addiw	a3,a5,-48
        val = val * 10.0 + (*s - '0');
    487e:	72d7f7c3          	fmadd.d	fa5,fa5,fa3,fa4
    4882:	8736                	mv	a4,a3
    while (isdigit(*s))
    4884:	fed676e3          	bgeu	a2,a3,4870 <strtod+0x4c>
    }
    if (*s == '.')
    4888:	02e00713          	li	a4,46
    488c:	00e78963          	beq	a5,a4,489e <strtod+0x7a>
            val += (*s - '0') * factor;
            s++;
        }
    }

    if (endptr)
    4890:	c191                	beqz	a1,4894 <strtod+0x70>
        *endptr = (char *)s;
    4892:	e188                	sd	a0,0(a1)
    return val * sign;
}
    4894:	12a7f553          	fmul.d	fa0,fa5,fa0
    4898:	8082                	ret
        s++;
    489a:	0505                	addi	a0,a0,1
    489c:	b779                	j	482a <strtod+0x6>
        while (isdigit(*s))
    489e:	00154703          	lbu	a4,1(a0)
    48a2:	46a5                	li	a3,9
        s++;
    48a4:	0505                	addi	a0,a0,1
    48a6:	fd07071b          	addiw	a4,a4,-48
    48aa:	87ba                	mv	a5,a4
        while (isdigit(*s))
    48ac:	fee6e2e3          	bltu	a3,a4,4890 <strtod+0x6c>
        double factor = 1.0;
    48b0:	00001717          	auipc	a4,0x1
    48b4:	04073707          	fld	fa4,64(a4) # 58f0 <STDIN_FD+0x10>
    48b8:	00001717          	auipc	a4,0x1
    48bc:	05873607          	fld	fa2,88(a4) # 5910 <STDIN_FD+0x30>
            factor *= 0.1;
    48c0:	12c77753          	fmul.d	fa4,fa4,fa2
        while (isdigit(*s))
    48c4:	00154703          	lbu	a4,1(a0)
            val += (*s - '0') * factor;
    48c8:	d20786d3          	fcvt.d.w	fa3,a5
            s++;
    48cc:	0505                	addi	a0,a0,1
    48ce:	fd07071b          	addiw	a4,a4,-48
    48d2:	87ba                	mv	a5,a4
            val += (*s - '0') * factor;
    48d4:	7ae6f7c3          	fmadd.d	fa5,fa3,fa4,fa5
        while (isdigit(*s))
    48d8:	fee6f4e3          	bgeu	a3,a4,48c0 <strtod+0x9c>
    48dc:	bf55                	j	4890 <strtod+0x6c>
    while (isdigit(*s))
    48de:	00154783          	lbu	a5,1(a0)
    48e2:	00001717          	auipc	a4,0x1
    48e6:	00673507          	fld	fa0,6(a4) # 58e8 <STDIN_FD+0x8>
        s++;
    48ea:	0505                	addi	a0,a0,1
    48ec:	b7ad                	j	4856 <strtod+0x32>
    while (isdigit(*s))
    48ee:	00154783          	lbu	a5,1(a0)
    48f2:	00001717          	auipc	a4,0x1
    48f6:	ffe73507          	fld	fa0,-2(a4) # 58f0 <STDIN_FD+0x10>
        s++;
    48fa:	0505                	addi	a0,a0,1
    48fc:	bfa9                	j	4856 <strtod+0x32>

00000000000048fe <atof>:

double atof(const char *nptr) { return strtod(nptr, NULL); }
    48fe:	4581                	li	a1,0
    4900:	b715                	j	4824 <strtod>

0000000000004902 <strtof>:
float strtof(const char *nptr, char **endptr) { return (float)strtod(nptr, endptr); }
    4902:	1141                	addi	sp,sp,-16
    4904:	e406                	sd	ra,8(sp)
    4906:	f1fff0ef          	jal	4824 <strtod>
    490a:	60a2                	ld	ra,8(sp)
    490c:	40157553          	fcvt.s.d	fa0,fa0
    4910:	0141                	addi	sp,sp,16
    4912:	8082                	ret

0000000000004914 <qsort>:
    }
}

void qsort(void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *))
{
    if (nmemb < 2 || size == 0)
    4914:	4785                	li	a5,1
    4916:	0cb7fd63          	bgeu	a5,a1,49f0 <qsort+0xdc>
{
    491a:	715d                	addi	sp,sp,-80
    491c:	f44e                	sd	s3,40(sp)
    491e:	e486                	sd	ra,72(sp)
    4920:	89b2                	mv	s3,a2
    if (nmemb < 2 || size == 0)
    4922:	c279                	beqz	a2,49e8 <qsort+0xd4>
    4924:	e85a                	sd	s6,16(sp)
    4926:	8b2e                	mv	s6,a1
        return;

    char *base_ptr = (char *)base;
    char *pivot = base_ptr + (nmemb - 1) * size;
    4928:	1b7d                	addi	s6,s6,-1
    492a:	fc26                	sd	s1,56(sp)
    492c:	033b04b3          	mul	s1,s6,s3
    4930:	ec56                	sd	s5,24(sp)
    4932:	8aaa                	mv	s5,a0
    4934:	f052                	sd	s4,32(sp)
    4936:	e45e                	sd	s7,8(sp)
    4938:	e0a2                	sd	s0,64(sp)
    493a:	f84a                	sd	s2,48(sp)
    493c:	8a36                	mv	s4,a3
    if (nmemb < 2 || size == 0)
    493e:	4b85                	li	s7,1
    char *pivot = base_ptr + (nmemb - 1) * size;
    4940:	94d6                	add	s1,s1,s5
    char *i = base_ptr;
    char *j = base_ptr;

    /* Partition */
    for (; j < pivot; j += size)
    4942:	069af763          	bgeu	s5,s1,49b0 <qsort+0x9c>
    char *j = base_ptr;
    4946:	8956                	mv	s2,s5
    char *i = base_ptr;
    4948:	8456                	mv	s0,s5
    494a:	a021                	j	4952 <qsort+0x3e>
    for (; j < pivot; j += size)
    494c:	994e                	add	s2,s2,s3
    494e:	00997f63          	bgeu	s2,s1,496c <qsort+0x58>
    {
        if (compar(j, pivot) < 0)
    4952:	85a6                	mv	a1,s1
    4954:	854a                	mv	a0,s2
    4956:	9a02                	jalr	s4
    4958:	fe055ae3          	bgez	a0,494c <qsort+0x38>
        {
            if (i != j)
    495c:	05241d63          	bne	s0,s2,49b6 <qsort+0xa2>
    4960:	01390633          	add	a2,s2,s3
                swap_bytes(i, j, size);
            i += size;
    4964:	8432                	mv	s0,a2
    for (; j < pivot; j += size)
    4966:	994e                	add	s2,s2,s3
    4968:	fe9965e3          	bltu	s2,s1,4952 <qsort+0x3e>
        }
    }
    swap_bytes(i, pivot, size);

    /* Recurse */
    size_t left_count = (i - base_ptr) / size;
    496c:	415405b3          	sub	a1,s0,s5
    4970:	0335d5b3          	divu	a1,a1,s3
    qsort(base, left_count, size, compar);
    qsort(i + size, nmemb - left_count - 1, size, compar);
    4974:	40bb0b33          	sub	s6,s6,a1
    while (size--)
    4978:	013406b3          	add	a3,s0,s3
        *a++ = *b;
    497c:	0004c703          	lbu	a4,0(s1)
        temp = *a;
    4980:	00044783          	lbu	a5,0(s0)
        *b++ = temp;
    4984:	0485                	addi	s1,s1,1
        *a++ = *b;
    4986:	0405                	addi	s0,s0,1
    4988:	fee40fa3          	sb	a4,-1(s0)
        *b++ = temp;
    498c:	fef48fa3          	sb	a5,-1(s1)
    while (size--)
    4990:	fed416e3          	bne	s0,a3,497c <qsort+0x68>
    qsort(base, left_count, size, compar);
    4994:	86d2                	mv	a3,s4
    4996:	864e                	mv	a2,s3
    4998:	8556                	mv	a0,s5
    499a:	f7bff0ef          	jal	4914 <qsort>
    if (nmemb < 2 || size == 0)
    499e:	036bfe63          	bgeu	s7,s6,49da <qsort+0xc6>
    char *pivot = base_ptr + (nmemb - 1) * size;
    49a2:	1b7d                	addi	s6,s6,-1
    49a4:	033b04b3          	mul	s1,s6,s3
    49a8:	8aa2                	mv	s5,s0
    49aa:	94d6                	add	s1,s1,s5
    for (; j < pivot; j += size)
    49ac:	f89aede3          	bltu	s5,s1,4946 <qsort+0x32>
    char *i = base_ptr;
    49b0:	8456                	mv	s0,s5
    for (; j < pivot; j += size)
    49b2:	4581                	li	a1,0
    49b4:	b7d1                	j	4978 <qsort+0x64>
    49b6:	01340633          	add	a2,s0,s3
            if (i != j)
    49ba:	874a                	mv	a4,s2
    49bc:	87a2                	mv	a5,s0
        *a++ = *b;
    49be:	00074683          	lbu	a3,0(a4)
        temp = *a;
    49c2:	0007c803          	lbu	a6,0(a5)
        *b++ = temp;
    49c6:	0705                	addi	a4,a4,1
        *a++ = *b;
    49c8:	0785                	addi	a5,a5,1
    49ca:	fed78fa3          	sb	a3,-1(a5)
        *b++ = temp;
    49ce:	ff070fa3          	sb	a6,-1(a4)
    while (size--)
    49d2:	fec796e3          	bne	a5,a2,49be <qsort+0xaa>
            i += size;
    49d6:	8432                	mv	s0,a2
    49d8:	b779                	j	4966 <qsort+0x52>
    49da:	6406                	ld	s0,64(sp)
    49dc:	74e2                	ld	s1,56(sp)
    49de:	7942                	ld	s2,48(sp)
    49e0:	7a02                	ld	s4,32(sp)
    49e2:	6ae2                	ld	s5,24(sp)
    49e4:	6b42                	ld	s6,16(sp)
    49e6:	6ba2                	ld	s7,8(sp)
}
    49e8:	60a6                	ld	ra,72(sp)
    49ea:	79a2                	ld	s3,40(sp)
    49ec:	6161                	addi	sp,sp,80
    49ee:	8082                	ret
    49f0:	8082                	ret

00000000000049f2 <bsearch>:

void *bsearch(const void *key, const void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *))
{
    49f2:	715d                	addi	sp,sp,-80
    49f4:	e486                	sd	ra,72(sp)
    49f6:	fc26                	sd	s1,56(sp)
    size_t l = 0, u = nmemb;
    while (l < u)
    49f8:	c629                	beqz	a2,4a42 <bsearch+0x50>
    49fa:	f84a                	sd	s2,48(sp)
    49fc:	f44e                	sd	s3,40(sp)
    49fe:	f052                	sd	s4,32(sp)
    4a00:	ec56                	sd	s5,24(sp)
    4a02:	e85a                	sd	s6,16(sp)
    4a04:	e45e                	sd	s7,8(sp)
    4a06:	e0a2                	sd	s0,64(sp)
    4a08:	8932                	mv	s2,a2
    4a0a:	8a2a                	mv	s4,a0
    4a0c:	8aae                	mv	s5,a1
    4a0e:	8b36                	mv	s6,a3
    4a10:	8bba                	mv	s7,a4
    size_t l = 0, u = nmemb;
    4a12:	4981                	li	s3,0
    {
        size_t idx = (l + u) / 2;
    4a14:	01298433          	add	s0,s3,s2
    4a18:	8005                	srli	s0,s0,0x1
        const void *p = (void *)((const char *)base + (idx * size));
    4a1a:	036404b3          	mul	s1,s0,s6
        int cmp = compar(key, p);
    4a1e:	8552                	mv	a0,s4
        const void *p = (void *)((const char *)base + (idx * size));
    4a20:	94d6                	add	s1,s1,s5
        int cmp = compar(key, p);
    4a22:	85a6                	mv	a1,s1
    4a24:	9b82                	jalr	s7
        if (cmp < 0)
    4a26:	02054463          	bltz	a0,4a4e <bsearch+0x5c>
            u = idx;
        else if (cmp > 0)
    4a2a:	c515                	beqz	a0,4a56 <bsearch+0x64>
            l = idx + 1;
    4a2c:	00140993          	addi	s3,s0,1
    while (l < u)
    4a30:	ff29e2e3          	bltu	s3,s2,4a14 <bsearch+0x22>
    4a34:	6406                	ld	s0,64(sp)
    4a36:	7942                	ld	s2,48(sp)
    4a38:	79a2                	ld	s3,40(sp)
    4a3a:	7a02                	ld	s4,32(sp)
    4a3c:	6ae2                	ld	s5,24(sp)
    4a3e:	6b42                	ld	s6,16(sp)
    4a40:	6ba2                	ld	s7,8(sp)
        else
            return (void *)p;
    }
    return NULL;
}
    4a42:	60a6                	ld	ra,72(sp)
    return NULL;
    4a44:	4481                	li	s1,0
}
    4a46:	8526                	mv	a0,s1
    4a48:	74e2                	ld	s1,56(sp)
    4a4a:	6161                	addi	sp,sp,80
    4a4c:	8082                	ret
            u = idx;
    4a4e:	8922                	mv	s2,s0
    while (l < u)
    4a50:	fd29e2e3          	bltu	s3,s2,4a14 <bsearch+0x22>
    4a54:	b7c5                	j	4a34 <bsearch+0x42>
    4a56:	6406                	ld	s0,64(sp)
}
    4a58:	60a6                	ld	ra,72(sp)
    4a5a:	7942                	ld	s2,48(sp)
    4a5c:	79a2                	ld	s3,40(sp)
    4a5e:	7a02                	ld	s4,32(sp)
    4a60:	6ae2                	ld	s5,24(sp)
    4a62:	6b42                	ld	s6,16(sp)
    4a64:	6ba2                	ld	s7,8(sp)
    4a66:	8526                	mv	a0,s1
    4a68:	74e2                	ld	s1,56(sp)
    4a6a:	6161                	addi	sp,sp,80
    4a6c:	8082                	ret

0000000000004a6e <abs>:

/* Math & Mics */

int abs(int j) { return (j < 0) ? -j : j; }
    4a6e:	41f5579b          	sraiw	a5,a0,0x1f
    4a72:	8d3d                	xor	a0,a0,a5
    4a74:	9d1d                	subw	a0,a0,a5
    4a76:	8082                	ret

0000000000004a78 <labs>:
long labs(long j) { return (j < 0) ? -j : j; }
    4a78:	43f55793          	srai	a5,a0,0x3f
    4a7c:	8d3d                	xor	a0,a0,a5
    4a7e:	8d1d                	sub	a0,a0,a5
    4a80:	8082                	ret

0000000000004a82 <llabs>:
long long llabs(long long j) { return (j < 0) ? -j : j; }
    4a82:	43f55793          	srai	a5,a0,0x3f
    4a86:	8d3d                	xor	a0,a0,a5
    4a88:	8d1d                	sub	a0,a0,a5
    4a8a:	8082                	ret

0000000000004a8c <div>:

div_t div(int numer, int denom)
{
    div_t res = {numer / denom, numer % denom};
    4a8c:	02b547bb          	divw	a5,a0,a1
{
    4a90:	1141                	addi	sp,sp,-16
    return res;
}
    4a92:	0141                	addi	sp,sp,16
    div_t res = {numer / denom, numer % denom};
    4a94:	02b5653b          	remw	a0,a0,a1
    return res;
    4a98:	1782                	slli	a5,a5,0x20
    4a9a:	9381                	srli	a5,a5,0x20
    4a9c:	1502                	slli	a0,a0,0x20
}
    4a9e:	8d5d                	or	a0,a0,a5
    4aa0:	8082                	ret

0000000000004aa2 <ldiv>:
ldiv_t ldiv(long numer, long denom)
{
    4aa2:	1141                	addi	sp,sp,-16
    4aa4:	87aa                	mv	a5,a0
    ldiv_t res = {numer / denom, numer % denom};
    return res;
}
    4aa6:	02b54533          	div	a0,a0,a1
    4aaa:	0141                	addi	sp,sp,16
    4aac:	02b7e5b3          	rem	a1,a5,a1
    4ab0:	8082                	ret

0000000000004ab2 <lldiv>:
lldiv_t lldiv(long long numer, long long denom)
{
    4ab2:	1141                	addi	sp,sp,-16
    4ab4:	87aa                	mv	a5,a0
    lldiv_t res = {numer / denom, numer % denom};
    return res;
}
    4ab6:	02b54533          	div	a0,a0,a1
    4aba:	0141                	addi	sp,sp,16
    4abc:	02b7e5b3          	rem	a1,a5,a1
    4ac0:	8082                	ret

0000000000004ac2 <rand>:

static unsigned long next = 1;
int rand(void)
{
    next = next * 1103515245 + 12345;
    4ac2:	00003697          	auipc	a3,0x3
    4ac6:	d3668693          	addi	a3,a3,-714 # 77f8 <next>
    4aca:	629c                	ld	a5,0(a3)
    4acc:	41c65737          	lui	a4,0x41c65
    4ad0:	e6d70713          	addi	a4,a4,-403 # 41c64e6d <_ZSt4cerr+0x41c5d4f5>
    4ad4:	02e787b3          	mul	a5,a5,a4
    4ad8:	670d                	lui	a4,0x3
    4ada:	03970713          	addi	a4,a4,57 # 3039 <stbsp_vsnprintf+0x51>
    4ade:	97ba                	add	a5,a5,a4
    return (unsigned int)(next / 65536) % 32768;
    4ae0:	02179513          	slli	a0,a5,0x21
    next = next * 1103515245 + 12345;
    4ae4:	e29c                	sd	a5,0(a3)
}
    4ae6:	9145                	srli	a0,a0,0x31
    4ae8:	8082                	ret

0000000000004aea <srand>:
void srand(unsigned int seed) { next = seed; }
    4aea:	1502                	slli	a0,a0,0x20
    4aec:	9101                	srli	a0,a0,0x20
    4aee:	00003797          	auipc	a5,0x3
    4af2:	d0a7b523          	sd	a0,-758(a5) # 77f8 <next>
    4af6:	8082                	ret

0000000000004af8 <mblen>:

/* Stub */
int mblen(const char *s, size_t n) { return (s && *s && n) ? 1 : 0; }
    4af8:	c901                	beqz	a0,4b08 <mblen+0x10>
    4afa:	00054783          	lbu	a5,0(a0)
    4afe:	4501                	li	a0,0
    4b00:	c789                	beqz	a5,4b0a <mblen+0x12>
    4b02:	00b03533          	snez	a0,a1
    4b06:	8082                	ret
    4b08:	4501                	li	a0,0
    4b0a:	8082                	ret

0000000000004b0c <mbtowc>:
int mbtowc(wchar_t *pwc, const char *s, size_t n)
{
    4b0c:	87aa                	mv	a5,a0
    if (!s)
    4b0e:	cd81                	beqz	a1,4b26 <mbtowc+0x1a>
        return 0;
    if (n == 0)
        return -1;
    4b10:	557d                	li	a0,-1
    if (n == 0)
    4b12:	ca19                	beqz	a2,4b28 <mbtowc+0x1c>
    if (pwc)
    4b14:	c781                	beqz	a5,4b1c <mbtowc+0x10>
        *pwc = (wchar_t)*s;
    4b16:	0005c703          	lbu	a4,0(a1)
    4b1a:	c398                	sw	a4,0(a5)
    return (*s != 0);
    4b1c:	0005c503          	lbu	a0,0(a1)
    4b20:	00a03533          	snez	a0,a0
    4b24:	8082                	ret
        return 0;
    4b26:	4501                	li	a0,0
}
    4b28:	8082                	ret

0000000000004b2a <wctomb>:
int wctomb(char *s, wchar_t wchar)
{
    if (!s)
    4b2a:	c509                	beqz	a0,4b34 <wctomb+0xa>
        return 0;
    *s = (char)wchar;
    4b2c:	00b50023          	sb	a1,0(a0)
    return 1;
    4b30:	4505                	li	a0,1
    4b32:	8082                	ret
        return 0;
    4b34:	4501                	li	a0,0
}
    4b36:	8082                	ret

0000000000004b38 <mbstowcs>:
size_t mbstowcs(wchar_t *dest, const char *src, size_t n)
{
    size_t i = 0;
    while (src[i] && i < n)
    4b38:	0005c703          	lbu	a4,0(a1)
    4b3c:	cb0d                	beqz	a4,4b6e <mbstowcs+0x36>
    4b3e:	ca15                	beqz	a2,4b72 <mbstowcs+0x3a>
    4b40:	86aa                	mv	a3,a0
    size_t i = 0;
    4b42:	4781                	li	a5,0
    4b44:	a019                	j	4b4a <mbstowcs+0x12>
    while (src[i] && i < n)
    4b46:	02f60263          	beq	a2,a5,4b6a <mbstowcs+0x32>
    {
        dest[i] = (wchar_t)src[i];
        i++;
    4b4a:	0785                	addi	a5,a5,1
        dest[i] = (wchar_t)src[i];
    4b4c:	c298                	sw	a4,0(a3)
    while (src[i] && i < n)
    4b4e:	00f58733          	add	a4,a1,a5
    4b52:	00074703          	lbu	a4,0(a4)
    4b56:	0691                	addi	a3,a3,4
    4b58:	f77d                	bnez	a4,4b46 <mbstowcs+0xe>
    }
    if (i < n)
    4b5a:	00c7f763          	bgeu	a5,a2,4b68 <mbstowcs+0x30>
        dest[i] = 0;
    4b5e:	00279713          	slli	a4,a5,0x2
    4b62:	953a                	add	a0,a0,a4
    4b64:	00052023          	sw	zero,0(a0)
    size_t i = 0;
    4b68:	863e                	mv	a2,a5
    4b6a:	8532                	mv	a0,a2
    4b6c:	8082                	ret
    4b6e:	4781                	li	a5,0
    4b70:	b7ed                	j	4b5a <mbstowcs+0x22>
    4b72:	4501                	li	a0,0
    return i;
}
    4b74:	8082                	ret

0000000000004b76 <wcstombs>:
size_t wcstombs(char *dest, const wchar_t *src, size_t n)
{
    size_t i = 0;
    while (src[i] && i < n)
    4b76:	4198                	lw	a4,0(a1)
    4b78:	c71d                	beqz	a4,4ba6 <wcstombs+0x30>
    4b7a:	ca05                	beqz	a2,4baa <wcstombs+0x34>
    4b7c:	0591                	addi	a1,a1,4
    size_t i = 0;
    4b7e:	4781                	li	a5,0
    4b80:	a019                	j	4b86 <wcstombs+0x10>
    while (src[i] && i < n)
    4b82:	02f60063          	beq	a2,a5,4ba2 <wcstombs+0x2c>
    {
        dest[i] = (char)src[i];
    4b86:	00f506b3          	add	a3,a0,a5
    4b8a:	00e68023          	sb	a4,0(a3)
    while (src[i] && i < n)
    4b8e:	4198                	lw	a4,0(a1)
        i++;
    4b90:	0785                	addi	a5,a5,1
    while (src[i] && i < n)
    4b92:	0591                	addi	a1,a1,4
    4b94:	f77d                	bnez	a4,4b82 <wcstombs+0xc>
    }
    if (i < n)
    4b96:	00c7f563          	bgeu	a5,a2,4ba0 <wcstombs+0x2a>
        dest[i] = 0;
    4b9a:	953e                	add	a0,a0,a5
    4b9c:	00050023          	sb	zero,0(a0)
    size_t i = 0;
    4ba0:	863e                	mv	a2,a5
    4ba2:	8532                	mv	a0,a2
    4ba4:	8082                	ret
    4ba6:	4781                	li	a5,0
    4ba8:	b7fd                	j	4b96 <wcstombs+0x20>
    4baa:	4501                	li	a0,0
    return i;
    4bac:	8082                	ret

0000000000004bae <memset>:

void *memset(void *dst, int c, size_t n)
{
    char *cdst = (char *)dst;
    for (size_t i = 0; i < n; i++)
        cdst[i] = (char)c;
    4bae:	0ff5f593          	zext.b	a1,a1
    4bb2:	87aa                	mv	a5,a0
    4bb4:	00a60733          	add	a4,a2,a0
    for (size_t i = 0; i < n; i++)
    4bb8:	c611                	beqz	a2,4bc4 <memset+0x16>
        cdst[i] = (char)c;
    4bba:	00b78023          	sb	a1,0(a5)
    for (size_t i = 0; i < n; i++)
    4bbe:	0785                	addi	a5,a5,1
    4bc0:	fee79de3          	bne	a5,a4,4bba <memset+0xc>
    return dst;
}
    4bc4:	8082                	ret

0000000000004bc6 <memmove>:

void *memmove(void *vdst, const void *vsrc, size_t n)
{
    char *dst = (char *)vdst;
    const char *src = (const char *)vsrc;
    if (dst == src)
    4bc6:	02b50d63          	beq	a0,a1,4c00 <memmove+0x3a>
        return vdst;

    if (src > dst)
    4bca:	00b57e63          	bgeu	a0,a1,4be6 <memmove+0x20>
    {
        while (n--)
    4bce:	ca0d                	beqz	a2,4c00 <memmove+0x3a>
    4bd0:	962a                	add	a2,a2,a0
    char *dst = (char *)vdst;
    4bd2:	87aa                	mv	a5,a0
            *dst++ = *src++;
    4bd4:	0005c703          	lbu	a4,0(a1)
    4bd8:	0785                	addi	a5,a5,1
    4bda:	0585                	addi	a1,a1,1
    4bdc:	fee78fa3          	sb	a4,-1(a5)
        while (n--)
    4be0:	fec79ae3          	bne	a5,a2,4bd4 <memmove+0xe>
    4be4:	8082                	ret
    }
    else
    {
        dst += n;
    4be6:	00c50733          	add	a4,a0,a2
        src += n;
    4bea:	00c587b3          	add	a5,a1,a2
        while (n-- > 0)
    4bee:	ca09                	beqz	a2,4c00 <memmove+0x3a>
            *--dst = *--src;
    4bf0:	fff7c683          	lbu	a3,-1(a5)
    4bf4:	17fd                	addi	a5,a5,-1
    4bf6:	177d                	addi	a4,a4,-1
    4bf8:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
    4bfc:	fef59ae3          	bne	a1,a5,4bf0 <memmove+0x2a>
    }
    return vdst;
}
    4c00:	8082                	ret

0000000000004c02 <memcpy>:

void *memcpy(void *vdst, const void *vsrc, size_t n)
{
    return memmove(vdst, vsrc, n);
    4c02:	b7d1                	j	4bc6 <memmove>

0000000000004c04 <memcmp>:

int memcmp(const void *s1, const void *s2, size_t n)
{
    const unsigned char *p1 = (const unsigned char *)s1;
    const unsigned char *p2 = (const unsigned char *)s2;
    while (n--)
    4c04:	c205                	beqz	a2,4c24 <memcmp+0x20>
    4c06:	962a                	add	a2,a2,a0
    4c08:	a019                	j	4c0e <memcmp+0xa>
    4c0a:	00c50d63          	beq	a0,a2,4c24 <memcmp+0x20>
    {
        if (*p1 != *p2)
    4c0e:	00054783          	lbu	a5,0(a0)
    4c12:	0005c703          	lbu	a4,0(a1)
            return *p1 - *p2;
        p1++;
    4c16:	0505                	addi	a0,a0,1
        p2++;
    4c18:	0585                	addi	a1,a1,1
        if (*p1 != *p2)
    4c1a:	fee788e3          	beq	a5,a4,4c0a <memcmp+0x6>
            return *p1 - *p2;
    4c1e:	40e7853b          	subw	a0,a5,a4
    4c22:	8082                	ret
    }
    return 0;
    4c24:	4501                	li	a0,0
}
    4c26:	8082                	ret

0000000000004c28 <memchr>:

void *memchr(const void *s, int c, size_t n)
{
    const unsigned char *p = (const unsigned char *)s;
    while (n--)
    4c28:	ce09                	beqz	a2,4c42 <memchr+0x1a>
    {
        if (*p == (unsigned char)c)
    4c2a:	0ff5f593          	zext.b	a1,a1
    4c2e:	962a                	add	a2,a2,a0
    4c30:	a021                	j	4c38 <memchr+0x10>
            return (void *)p;
        p++;
    4c32:	0505                	addi	a0,a0,1
    while (n--)
    4c34:	00a60763          	beq	a2,a0,4c42 <memchr+0x1a>
        if (*p == (unsigned char)c)
    4c38:	00054783          	lbu	a5,0(a0)
    4c3c:	feb79be3          	bne	a5,a1,4c32 <memchr+0xa>
    }
    return NULL;
}
    4c40:	8082                	ret
    return NULL;
    4c42:	4501                	li	a0,0
}
    4c44:	8082                	ret

0000000000004c46 <strlen>:
/* String Manipulation Functions  */

size_t strlen(const char *s)
{
    const char *p = s;
    while (*p)
    4c46:	00054783          	lbu	a5,0(a0)
    4c4a:	cb89                	beqz	a5,4c5c <strlen+0x16>
    const char *p = s;
    4c4c:	87aa                	mv	a5,a0
    while (*p)
    4c4e:	0017c703          	lbu	a4,1(a5)
        p++;
    4c52:	0785                	addi	a5,a5,1
    while (*p)
    4c54:	ff6d                	bnez	a4,4c4e <strlen+0x8>
    return (size_t)(p - s);
    4c56:	40a78533          	sub	a0,a5,a0
    4c5a:	8082                	ret
    while (*p)
    4c5c:	4501                	li	a0,0
}
    4c5e:	8082                	ret

0000000000004c60 <strcpy>:

char *strcpy(char *dst, const char *src)
{
    char *os = dst;
    while ((*dst++ = *src++) != 0)
    4c60:	87aa                	mv	a5,a0
    4c62:	0005c703          	lbu	a4,0(a1)
    4c66:	0785                	addi	a5,a5,1
    4c68:	0585                	addi	a1,a1,1
    4c6a:	fee78fa3          	sb	a4,-1(a5)
    4c6e:	fb75                	bnez	a4,4c62 <strcpy+0x2>
        ;
    return os;
}
    4c70:	8082                	ret

0000000000004c72 <strncpy>:
char *strncpy(char *dst, const char *src, size_t n)
{
    char *os = dst;
    size_t i;

    for (i = 0; i < n && src[i] != '\0'; i++)
    4c72:	4781                	li	a5,0
    4c74:	e619                	bnez	a2,4c82 <strncpy+0x10>
    4c76:	8082                	ret
        dst[i] = src[i];
    4c78:	00e68023          	sb	a4,0(a3)
    for (i = 0; i < n && src[i] != '\0'; i++)
    4c7c:	0785                	addi	a5,a5,1
    4c7e:	02f60263          	beq	a2,a5,4ca2 <strncpy+0x30>
    4c82:	00f58733          	add	a4,a1,a5
    4c86:	00074703          	lbu	a4,0(a4)
        dst[i] = src[i];
    4c8a:	00f506b3          	add	a3,a0,a5
    for (i = 0; i < n && src[i] != '\0'; i++)
    4c8e:	f76d                	bnez	a4,4c78 <strncpy+0x6>

    for (; i < n; i++)
    4c90:	00c7f963          	bgeu	a5,a2,4ca2 <strncpy+0x30>
    4c94:	87b6                	mv	a5,a3
    4c96:	962a                	add	a2,a2,a0
        dst[i] = '\0';
    4c98:	00078023          	sb	zero,0(a5)
    for (; i < n; i++)
    4c9c:	0785                	addi	a5,a5,1
    4c9e:	fec79de3          	bne	a5,a2,4c98 <strncpy+0x26>

    return os;
}
    4ca2:	8082                	ret

0000000000004ca4 <strcat>:

char *strcat(char *dst, const char *src)
{
    char *os = dst;
    while (*dst)
    4ca4:	00054783          	lbu	a5,0(a0)
    4ca8:	cf91                	beqz	a5,4cc4 <strcat+0x20>
    4caa:	87aa                	mv	a5,a0
    4cac:	0017c703          	lbu	a4,1(a5)
        dst++;
    4cb0:	0785                	addi	a5,a5,1
    while (*dst)
    4cb2:	ff6d                	bnez	a4,4cac <strcat+0x8>
    while ((*dst++ = *src++) != 0)
    4cb4:	0005c703          	lbu	a4,0(a1)
    4cb8:	0785                	addi	a5,a5,1
    4cba:	0585                	addi	a1,a1,1
    4cbc:	fee78fa3          	sb	a4,-1(a5)
    4cc0:	fb75                	bnez	a4,4cb4 <strcat+0x10>
        ;
    return os;
}
    4cc2:	8082                	ret
    while ((*dst++ = *src++) != 0)
    4cc4:	0005c703          	lbu	a4,0(a1)
    while (*dst)
    4cc8:	87aa                	mv	a5,a0
    while ((*dst++ = *src++) != 0)
    4cca:	0785                	addi	a5,a5,1
    4ccc:	fee78fa3          	sb	a4,-1(a5)
    4cd0:	0585                	addi	a1,a1,1
    4cd2:	f36d                	bnez	a4,4cb4 <strcat+0x10>
    4cd4:	8082                	ret

0000000000004cd6 <strncat>:
    while (*p)
    4cd6:	00054783          	lbu	a5,0(a0)
    const char *p = s;
    4cda:	872a                	mv	a4,a0
    while (*p)
    4cdc:	c789                	beqz	a5,4ce6 <strncat+0x10>
    4cde:	00174783          	lbu	a5,1(a4)
        p++;
    4ce2:	0705                	addi	a4,a4,1
    while (*p)
    4ce4:	ffed                	bnez	a5,4cde <strncat+0x8>
    size_t dest_len = strlen(dst);
    size_t i;

    dst += dest_len;

    for (i = 0; i < n && src[i] != '\0'; i++)
    4ce6:	86ba                	mv	a3,a4
    4ce8:	4781                	li	a5,0
    4cea:	88ba                	mv	a7,a4
    4cec:	ea01                	bnez	a2,4cfc <strncat+0x26>
    4cee:	a839                	j	4d0c <strncat+0x36>
        dst[i] = src[i];
    4cf0:	01068023          	sb	a6,0(a3)
    for (i = 0; i < n && src[i] != '\0'; i++)
    4cf4:	00188693          	addi	a3,a7,1
    4cf8:	00f60d63          	beq	a2,a5,4d12 <strncat+0x3c>
    4cfc:	00f58833          	add	a6,a1,a5
    4d00:	00084803          	lbu	a6,0(a6)
    4d04:	0785                	addi	a5,a5,1
        dst[i] = src[i];
    4d06:	88b6                	mv	a7,a3
    for (i = 0; i < n && src[i] != '\0'; i++)
    4d08:	fe0814e3          	bnez	a6,4cf0 <strncat+0x1a>

    dst[i] = '\0';
    4d0c:	00088023          	sb	zero,0(a7)

    return os;
}
    4d10:	8082                	ret
    dst[i] = '\0';
    4d12:	00c708b3          	add	a7,a4,a2
    4d16:	00088023          	sb	zero,0(a7)
}
    4d1a:	8082                	ret

0000000000004d1c <strcmp>:

int strcmp(const char *p, const char *q)
{
    while (*p && *p == *q)
    4d1c:	00054783          	lbu	a5,0(a0)
    4d20:	e791                	bnez	a5,4d2c <strcmp+0x10>
    4d22:	a02d                	j	4d4c <strcmp+0x30>
    4d24:	00054783          	lbu	a5,0(a0)
    4d28:	cf89                	beqz	a5,4d42 <strcmp+0x26>
    4d2a:	85b6                	mv	a1,a3
    4d2c:	0005c703          	lbu	a4,0(a1)
    {
        p++;
    4d30:	0505                	addi	a0,a0,1
        q++;
    4d32:	00158693          	addi	a3,a1,1
    while (*p && *p == *q)
    4d36:	fef707e3          	beq	a4,a5,4d24 <strcmp+0x8>
    }
    return (int)((unsigned char)*p - (unsigned char)*q);
    4d3a:	0007851b          	sext.w	a0,a5
}
    4d3e:	9d19                	subw	a0,a0,a4
    4d40:	8082                	ret
    return (int)((unsigned char)*p - (unsigned char)*q);
    4d42:	0015c703          	lbu	a4,1(a1)
    4d46:	4501                	li	a0,0
}
    4d48:	9d19                	subw	a0,a0,a4
    4d4a:	8082                	ret
    return (int)((unsigned char)*p - (unsigned char)*q);
    4d4c:	0005c703          	lbu	a4,0(a1)
    4d50:	4501                	li	a0,0
    4d52:	b7f5                	j	4d3e <strcmp+0x22>

0000000000004d54 <strncmp>:

int strncmp(const char *s1, const char *s2, size_t n)
{
    if (n == 0)
    4d54:	ca0d                	beqz	a2,4d86 <strncmp+0x32>
        return 0;

    while (n-- > 0 && *s1 && *s1 == *s2)
    4d56:	00054783          	lbu	a5,0(a0)
    4d5a:	167d                	addi	a2,a2,-1
    4d5c:	00c506b3          	add	a3,a0,a2
    4d60:	eb89                	bnez	a5,4d72 <strncmp+0x1e>
    4d62:	a80d                	j	4d94 <strncmp+0x40>
    {
        if (n == 0 || *s1 == '\0')
    4d64:	00d50d63          	beq	a0,a3,4d7e <strncmp+0x2a>
    while (n-- > 0 && *s1 && *s1 == *s2)
    4d68:	00154783          	lbu	a5,1(a0)
            break;
        s1++;
    4d6c:	0505                	addi	a0,a0,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    4d6e:	cf91                	beqz	a5,4d8a <strncmp+0x36>
    4d70:	85b2                	mv	a1,a2
    4d72:	0005c703          	lbu	a4,0(a1)
        s2++;
    4d76:	00158613          	addi	a2,a1,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    4d7a:	fef705e3          	beq	a4,a5,4d64 <strncmp+0x10>
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    4d7e:	0007851b          	sext.w	a0,a5
    4d82:	9d19                	subw	a0,a0,a4
    4d84:	8082                	ret
        return 0;
    4d86:	4501                	li	a0,0
}
    4d88:	8082                	ret
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    4d8a:	0015c703          	lbu	a4,1(a1)
    4d8e:	4501                	li	a0,0
    4d90:	9d19                	subw	a0,a0,a4
    4d92:	8082                	ret
    4d94:	0005c703          	lbu	a4,0(a1)
    4d98:	4501                	li	a0,0
    4d9a:	b7e5                	j	4d82 <strncmp+0x2e>

0000000000004d9c <strchr>:

char *strchr(const char *s, int c)
{
    while (*s != (char)c)
    4d9c:	0ff5f593          	zext.b	a1,a1
    4da0:	a019                	j	4da6 <strchr+0xa>
    {
        if (!*s++)
    4da2:	0505                	addi	a0,a0,1
    4da4:	c791                	beqz	a5,4db0 <strchr+0x14>
    while (*s != (char)c)
    4da6:	00054783          	lbu	a5,0(a0)
    4daa:	feb79ce3          	bne	a5,a1,4da2 <strchr+0x6>
    4dae:	8082                	ret
            return NULL;
    4db0:	4501                	li	a0,0
    }
    return (char *)s;
}
    4db2:	8082                	ret

0000000000004db4 <strrchr>:

char *strrchr(const char *s, int c)
{
    4db4:	87aa                	mv	a5,a0
    const char *last = NULL;
    do
    {
        if (*s == (char)c)
    4db6:	0ff5f593          	zext.b	a1,a1
    const char *last = NULL;
    4dba:	4501                	li	a0,0
        if (*s == (char)c)
    4dbc:	0007c703          	lbu	a4,0(a5)
    4dc0:	00e59363          	bne	a1,a4,4dc6 <strrchr+0x12>
            last = s;
    4dc4:	853e                	mv	a0,a5
    } while (*s++);
    4dc6:	0785                	addi	a5,a5,1
    4dc8:	fb75                	bnez	a4,4dbc <strrchr+0x8>

    return (char *)last;
}
    4dca:	8082                	ret

0000000000004dcc <strstr>:
    while (*p)
    4dcc:	0005c883          	lbu	a7,0(a1)
    4dd0:	04088a63          	beqz	a7,4e24 <strstr+0x58>
    const char *p = s;
    4dd4:	87ae                	mv	a5,a1
    while (*p)
    4dd6:	0017c703          	lbu	a4,1(a5)
        p++;
    4dda:	0785                	addi	a5,a5,1
    while (*p)
    4ddc:	ff6d                	bnez	a4,4dd6 <strstr+0xa>
    return (size_t)(p - s);
    4dde:	40b78833          	sub	a6,a5,a1


char *strstr(const char *haystack, const char *needle)
{
    size_t n_len = strlen(needle);
    if (n_len == 0)
    4de2:	04b78163          	beq	a5,a1,4e24 <strstr+0x58>
        return (char *)haystack;

    for (; *haystack; haystack++)
    4de6:	00054783          	lbu	a5,0(a0)
    4dea:	cf85                	beqz	a5,4e22 <strstr+0x56>
    4dec:	187d                	addi	a6,a6,-1
    4dee:	982a                	add	a6,a6,a0
    {
        if (*haystack != *needle)
    4df0:	02f89463          	bne	a7,a5,4e18 <strstr+0x4c>
    while (n-- > 0 && *s1 && *s1 == *s2)
    4df4:	00054703          	lbu	a4,0(a0)
    4df8:	8646                	mv	a2,a7
    4dfa:	86ae                	mv	a3,a1
    4dfc:	87aa                	mv	a5,a0
    4dfe:	eb11                	bnez	a4,4e12 <strstr+0x46>
    4e00:	a821                	j	4e18 <strstr+0x4c>
        if (n == 0 || *s1 == '\0')
    4e02:	03078163          	beq	a5,a6,4e24 <strstr+0x58>
    while (n-- > 0 && *s1 && *s1 == *s2)
    4e06:	0017c703          	lbu	a4,1(a5)
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    4e0a:	0006c603          	lbu	a2,0(a3)
        s1++;
    4e0e:	0785                	addi	a5,a5,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    4e10:	cb19                	beqz	a4,4e26 <strstr+0x5a>
        s2++;
    4e12:	0685                	addi	a3,a3,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    4e14:	fee607e3          	beq	a2,a4,4e02 <strstr+0x36>
    for (; *haystack; haystack++)
    4e18:	00154783          	lbu	a5,1(a0)
    4e1c:	0805                	addi	a6,a6,1
    4e1e:	0505                	addi	a0,a0,1
    4e20:	fbe1                	bnez	a5,4df0 <strstr+0x24>
            continue;

        if (strncmp(haystack, needle, n_len) == 0)
            return (char *)haystack;
    }
    return NULL;
    4e22:	4501                	li	a0,0
}
    4e24:	8082                	ret
        if (strncmp(haystack, needle, n_len) == 0)
    4e26:	de7d                	beqz	a2,4e24 <strstr+0x58>
    for (; *haystack; haystack++)
    4e28:	00154783          	lbu	a5,1(a0)
    4e2c:	0805                	addi	a6,a6,1
    4e2e:	0505                	addi	a0,a0,1
    4e30:	f3e1                	bnez	a5,4df0 <strstr+0x24>
    4e32:	bfc5                	j	4e22 <strstr+0x56>

0000000000004e34 <strdup>:

char *strdup(const char *s)
{
    4e34:	1101                	addi	sp,sp,-32
    4e36:	e426                	sd	s1,8(sp)
    4e38:	ec06                	sd	ra,24(sp)
    4e3a:	e822                	sd	s0,16(sp)
    while (*p)
    4e3c:	00054783          	lbu	a5,0(a0)
{
    4e40:	84aa                	mv	s1,a0
    while (*p)
    4e42:	cb8d                	beqz	a5,4e74 <strdup+0x40>
    const char *p = s;
    4e44:	862a                	mv	a2,a0
    while (*p)
    4e46:	00164783          	lbu	a5,1(a2)
        p++;
    4e4a:	0605                	addi	a2,a2,1
    while (*p)
    4e4c:	ffed                	bnez	a5,4e46 <strdup+0x12>
    return (size_t)(p - s);
    4e4e:	8e05                	sub	a2,a2,s1
    size_t len = strlen(s) + 1;
    4e50:	00160413          	addi	s0,a2,1
    char *new_str = (char *)malloc(len);
    4e54:	8522                	mv	a0,s0
    4e56:	f4eff0ef          	jal	45a4 <malloc>
    if (new_str == NULL)
    4e5a:	c901                	beqz	a0,4e6a <strdup+0x36>
    return memmove(vdst, vsrc, n);
    4e5c:	8622                	mv	a2,s0
        return NULL;

    return (char *)memcpy(new_str, s, len);
}
    4e5e:	6442                	ld	s0,16(sp)
    4e60:	60e2                	ld	ra,24(sp)
    return memmove(vdst, vsrc, n);
    4e62:	85a6                	mv	a1,s1
}
    4e64:	64a2                	ld	s1,8(sp)
    4e66:	6105                	addi	sp,sp,32
    return memmove(vdst, vsrc, n);
    4e68:	bbb9                	j	4bc6 <memmove>
}
    4e6a:	60e2                	ld	ra,24(sp)
    4e6c:	6442                	ld	s0,16(sp)
    4e6e:	64a2                	ld	s1,8(sp)
    4e70:	6105                	addi	sp,sp,32
    4e72:	8082                	ret
    while (*p)
    4e74:	4405                	li	s0,1
    4e76:	bff9                	j	4e54 <strdup+0x20>

0000000000004e78 <strlcpy>:
    4e78:	0005c783          	lbu	a5,0(a1)

size_t strlcpy(char *dst, const char *src, size_t size)
{
    4e7c:	1101                	addi	sp,sp,-32
    4e7e:	ec06                	sd	ra,24(sp)
    4e80:	e822                	sd	s0,16(sp)
    4e82:	86b2                	mv	a3,a2
    while (*p)
    4e84:	cf8d                	beqz	a5,4ebe <strlcpy+0x46>
    const char *p = s;
    4e86:	87ae                	mv	a5,a1
    while (*p)
    4e88:	0017c703          	lbu	a4,1(a5)
        p++;
    4e8c:	0785                	addi	a5,a5,1
    while (*p)
    4e8e:	ff6d                	bnez	a4,4e88 <strlcpy+0x10>
    return (size_t)(p - s);
    4e90:	40b78433          	sub	s0,a5,a1
    size_t src_len = strlen(src);

    if (size > 0)
    4e94:	c285                	beqz	a3,4eb4 <strlcpy+0x3c>
    4e96:	e426                	sd	s1,8(sp)
    {
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    4e98:	fff68613          	addi	a2,a3,-1
        memcpy(dst, src, copy_len);
        dst[copy_len] = '\0';
    4e9c:	00c504b3          	add	s1,a0,a2
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    4ea0:	00d47563          	bgeu	s0,a3,4eaa <strlcpy+0x32>
        dst[copy_len] = '\0';
    4ea4:	008504b3          	add	s1,a0,s0
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    4ea8:	8622                	mv	a2,s0
    return memmove(vdst, vsrc, n);
    4eaa:	d1dff0ef          	jal	4bc6 <memmove>
        dst[copy_len] = '\0';
    4eae:	00048023          	sb	zero,0(s1)
    }

    return src_len;
    4eb2:	64a2                	ld	s1,8(sp)
}
    4eb4:	60e2                	ld	ra,24(sp)
    4eb6:	8522                	mv	a0,s0
    4eb8:	6442                	ld	s0,16(sp)
    4eba:	6105                	addi	sp,sp,32
    4ebc:	8082                	ret
    if (size > 0)
    4ebe:	e219                	bnez	a2,4ec4 <strlcpy+0x4c>
    return (size_t)(p - s);
    4ec0:	4401                	li	s0,0
    4ec2:	bfcd                	j	4eb4 <strlcpy+0x3c>
    4ec4:	e426                	sd	s1,8(sp)
    4ec6:	4401                	li	s0,0
    if (size > 0)
    4ec8:	84aa                	mv	s1,a0
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    4eca:	4601                	li	a2,0
    4ecc:	bff9                	j	4eaa <strlcpy+0x32>

0000000000004ece <strlcat>:
    while (*p)
    4ece:	0005c783          	lbu	a5,0(a1)

size_t strlcat(char *dst, const char *src, size_t size)
{
    4ed2:	7179                	addi	sp,sp,-48
    4ed4:	e84a                	sd	s2,16(sp)
    4ed6:	f406                	sd	ra,40(sp)
    4ed8:	f022                	sd	s0,32(sp)
    4eda:	ec26                	sd	s1,24(sp)
    4edc:	892a                	mv	s2,a0
    while (*p)
    4ede:	c7b5                	beqz	a5,4f4a <strlcat+0x7c>
    const char *p = s;
    4ee0:	87ae                	mv	a5,a1
    while (*p)
    4ee2:	0017c703          	lbu	a4,1(a5)
        p++;
    4ee6:	0785                	addi	a5,a5,1
    while (*p)
    4ee8:	ff6d                	bnez	a4,4ee2 <strlcat+0x14>
    return (size_t)(p - s);
    4eea:	40b784b3          	sub	s1,a5,a1
    size_t dst_len = 0;
    4eee:	4401                	li	s0,0
    size_t src_len = strlen(src);

    while (dst_len < size && dst[dst_len] != '\0')
    4ef0:	e609                	bnez	a2,4efa <strlcat+0x2c>
    4ef2:	a0a1                	j	4f3a <strlcat+0x6c>
        dst_len++;
    4ef4:	0405                	addi	s0,s0,1
    while (dst_len < size && dst[dst_len] != '\0')
    4ef6:	04860263          	beq	a2,s0,4f3a <strlcat+0x6c>
    4efa:	00890533          	add	a0,s2,s0
    4efe:	00054783          	lbu	a5,0(a0)
    4f02:	fbed                	bnez	a5,4ef4 <strlcat+0x26>

    if (dst_len == size)
    4f04:	02860b63          	beq	a2,s0,4f3a <strlcat+0x6c>
    4f08:	e44e                	sd	s3,8(sp)
        return size + src_len;

    size_t space_left = size - dst_len;
    4f0a:	408607b3          	sub	a5,a2,s0
    size_t copy_len = (src_len >= space_left) ? space_left - 1 : src_len;
    4f0e:	89a6                	mv	s3,s1
    4f10:	02f4f263          	bgeu	s1,a5,4f34 <strlcat+0x66>

    memcpy(dst + dst_len, src, copy_len);
    dst[dst_len + copy_len] = '\0';
    4f14:	994e                	add	s2,s2,s3
    4f16:	9922                	add	s2,s2,s0
    return memmove(vdst, vsrc, n);
    4f18:	864e                	mv	a2,s3
    4f1a:	cadff0ef          	jal	4bc6 <memmove>
    dst[dst_len + copy_len] = '\0';
    4f1e:	00090023          	sb	zero,0(s2) # 1000 <_vscanf_core.constprop.0+0x5b2>

    return dst_len + src_len;
    4f22:	00940533          	add	a0,s0,s1
}
    4f26:	70a2                	ld	ra,40(sp)
    4f28:	7402                	ld	s0,32(sp)
    return dst_len + src_len;
    4f2a:	69a2                	ld	s3,8(sp)
}
    4f2c:	64e2                	ld	s1,24(sp)
    4f2e:	6942                	ld	s2,16(sp)
    4f30:	6145                	addi	sp,sp,48
    4f32:	8082                	ret
    size_t copy_len = (src_len >= space_left) ? space_left - 1 : src_len;
    4f34:	fff78993          	addi	s3,a5,-1
    4f38:	bff1                	j	4f14 <strlcat+0x46>
}
    4f3a:	70a2                	ld	ra,40(sp)
    4f3c:	7402                	ld	s0,32(sp)
    4f3e:	6942                	ld	s2,16(sp)
        return size + src_len;
    4f40:	00960533          	add	a0,a2,s1
}
    4f44:	64e2                	ld	s1,24(sp)
    4f46:	6145                	addi	sp,sp,48
    4f48:	8082                	ret
    while (*p)
    4f4a:	4481                	li	s1,0
    4f4c:	b74d                	j	4eee <strlcat+0x20>

0000000000004f4e <strspn>:
size_t strspn(const char *s, const char *accept)
{
    const char *p = s;
    const char *a;

    while (*p)
    4f4e:	00054683          	lbu	a3,0(a0)
    4f52:	c695                	beqz	a3,4f7e <strspn+0x30>
    {
        for (a = accept; *a; a++)
    4f54:	0005c803          	lbu	a6,0(a1)
    4f58:	862a                	mv	a2,a0
    4f5a:	00080f63          	beqz	a6,4f78 <strspn+0x2a>
    4f5e:	87ae                	mv	a5,a1
    4f60:	8742                	mv	a4,a6
    4f62:	a021                	j	4f6a <strspn+0x1c>
    4f64:	0007c703          	lbu	a4,0(a5)
    4f68:	cb01                	beqz	a4,4f78 <strspn+0x2a>
    4f6a:	0785                	addi	a5,a5,1
        {
            if (*p == *a)
    4f6c:	fee69ce3          	bne	a3,a4,4f64 <strspn+0x16>
    while (*p)
    4f70:	00164683          	lbu	a3,1(a2)
                break;
        }
        if (*a == '\0')
            return (size_t)(p - s);
        p++;
    4f74:	0605                	addi	a2,a2,1
    while (*p)
    4f76:	f6e5                	bnez	a3,4f5e <strspn+0x10>
    }
    return (size_t)(p - s);
    4f78:	40a60533          	sub	a0,a2,a0
    4f7c:	8082                	ret
    while (*p)
    4f7e:	4501                	li	a0,0
}
    4f80:	8082                	ret

0000000000004f82 <strcspn>:
size_t strcspn(const char *s, const char *reject)
{
    const char *p = s;
    const char *r;

    while (*p)
    4f82:	00054683          	lbu	a3,0(a0)
    4f86:	ce85                	beqz	a3,4fbe <strcspn+0x3c>
    {
        for (r = reject; *r; r++)
    4f88:	0005c803          	lbu	a6,0(a1)
    const char *p = s;
    4f8c:	862a                	mv	a2,a0
        for (r = reject; *r; r++)
    4f8e:	02080363          	beqz	a6,4fb4 <strcspn+0x32>
    4f92:	87ae                	mv	a5,a1
    4f94:	8742                	mv	a4,a6
    4f96:	a021                	j	4f9e <strcspn+0x1c>
    4f98:	0007c703          	lbu	a4,0(a5)
    4f9c:	c719                	beqz	a4,4faa <strcspn+0x28>
    4f9e:	0785                	addi	a5,a5,1
        {
            if (*p == *r)
    4fa0:	fed71ce3          	bne	a4,a3,4f98 <strcspn+0x16>
                return (size_t)(p - s);
        }
        p++;
    }
    return (size_t)(p - s);
    4fa4:	40a60533          	sub	a0,a2,a0
    4fa8:	8082                	ret
    while (*p)
    4faa:	00164683          	lbu	a3,1(a2)
        p++;
    4fae:	0605                	addi	a2,a2,1
    while (*p)
    4fb0:	f2ed                	bnez	a3,4f92 <strcspn+0x10>
    4fb2:	bfcd                	j	4fa4 <strcspn+0x22>
    4fb4:	00164683          	lbu	a3,1(a2)
        p++;
    4fb8:	0605                	addi	a2,a2,1
    while (*p)
    4fba:	feed                	bnez	a3,4fb4 <strcspn+0x32>
    4fbc:	b7e5                	j	4fa4 <strcspn+0x22>
    4fbe:	4501                	li	a0,0
}
    4fc0:	8082                	ret

0000000000004fc2 <strpbrk>:

char *strpbrk(const char *s, const char *accept)
{
    const char *a;
    while (*s)
    4fc2:	00054683          	lbu	a3,0(a0)
    4fc6:	c295                	beqz	a3,4fea <strpbrk+0x28>
    {
        for (a = accept; *a; a++)
    4fc8:	0005c603          	lbu	a2,0(a1)
    4fcc:	c20d                	beqz	a2,4fee <strpbrk+0x2c>
    4fce:	87ae                	mv	a5,a1
    4fd0:	8732                	mv	a4,a2
    4fd2:	a021                	j	4fda <strpbrk+0x18>
    4fd4:	0007c703          	lbu	a4,0(a5)
    4fd8:	c709                	beqz	a4,4fe2 <strpbrk+0x20>
    4fda:	0785                	addi	a5,a5,1
        {
            if (*s == *a)
    4fdc:	fed71ce3          	bne	a4,a3,4fd4 <strpbrk+0x12>
                return (char *)s;
        }
        s++;
    }
    return NULL;
}
    4fe0:	8082                	ret
    while (*s)
    4fe2:	00154683          	lbu	a3,1(a0)
        s++;
    4fe6:	0505                	addi	a0,a0,1
    while (*s)
    4fe8:	f2fd                	bnez	a3,4fce <strpbrk+0xc>
    return NULL;
    4fea:	4501                	li	a0,0
}
    4fec:	8082                	ret
    while (*s)
    4fee:	00154683          	lbu	a3,1(a0)
        s++;
    4ff2:	0505                	addi	a0,a0,1
    while (*s)
    4ff4:	feed                	bnez	a3,4fee <strpbrk+0x2c>
    4ff6:	bfd5                	j	4fea <strpbrk+0x28>

0000000000004ff8 <strtok>:
char *strtok(char *str, const char *delim)
{
    static char *olds;
    char *token;

    if (str == NULL)
    4ff8:	00003897          	auipc	a7,0x3
    4ffc:	96888893          	addi	a7,a7,-1688 # 7960 <olds.0>
    5000:	cd25                	beqz	a0,5078 <strtok+0x80>
    while (*p)
    5002:	00054683          	lbu	a3,0(a0)
    5006:	c295                	beqz	a3,502a <strtok+0x32>
        for (a = accept; *a; a++)
    5008:	0005c803          	lbu	a6,0(a1)
    500c:	02080463          	beqz	a6,5034 <strtok+0x3c>
    5010:	87ae                	mv	a5,a1
    5012:	8742                	mv	a4,a6
    5014:	a021                	j	501c <strtok+0x24>
    5016:	0007c703          	lbu	a4,0(a5)
    501a:	cf09                	beqz	a4,5034 <strtok+0x3c>
    501c:	0785                	addi	a5,a5,1
            if (*p == *a)
    501e:	fee69ce3          	bne	a3,a4,5016 <strtok+0x1e>
    while (*p)
    5022:	00154683          	lbu	a3,1(a0)
        p++;
    5026:	0505                	addi	a0,a0,1
    while (*p)
    5028:	f6e5                	bnez	a3,5010 <strtok+0x18>
    502a:	87aa                	mv	a5,a0
        str = olds;

    str += strspn(str, delim);
    if (*str == '\0')
    {
        olds = str;
    502c:	00f8b023          	sd	a5,0(a7)
        return NULL;
    5030:	4501                	li	a0,0
        *str = '\0';
        olds = str + 1;
    }

    return token;
}
    5032:	8082                	ret
    if (*str == '\0')
    5034:	00054603          	lbu	a2,0(a0)
    5038:	da6d                	beqz	a2,502a <strtok+0x32>
    503a:	86aa                	mv	a3,a0
        for (a = accept; *a; a++)
    503c:	04080163          	beqz	a6,507e <strtok+0x86>
    5040:	8742                	mv	a4,a6
    5042:	87ae                	mv	a5,a1
    5044:	a021                	j	504c <strtok+0x54>
    5046:	0007c703          	lbu	a4,0(a5)
    504a:	cb19                	beqz	a4,5060 <strtok+0x68>
    504c:	0785                	addi	a5,a5,1
            if (*s == *a)
    504e:	fee61ce3          	bne	a2,a4,5046 <strtok+0x4e>
        olds = str + 1;
    5052:	00168793          	addi	a5,a3,1
        *str = '\0';
    5056:	00068023          	sb	zero,0(a3)
        olds = str;
    505a:	00f8b023          	sd	a5,0(a7)
}
    505e:	8082                	ret
    while (*s)
    5060:	0016c603          	lbu	a2,1(a3)
        s++;
    5064:	0685                	addi	a3,a3,1
    while (*s)
    5066:	fe69                	bnez	a2,5040 <strtok+0x48>
    5068:	87aa                	mv	a5,a0
    while (*s != (char)c)
    506a:	0017c703          	lbu	a4,1(a5)
        if (!*s++)
    506e:	0785                	addi	a5,a5,1
    while (*s != (char)c)
    5070:	ff6d                	bnez	a4,506a <strtok+0x72>
        olds = str;
    5072:	00f8b023          	sd	a5,0(a7)
}
    5076:	8082                	ret
        str = olds;
    5078:	0008b503          	ld	a0,0(a7)
    507c:	b759                	j	5002 <strtok+0xa>
    while (*s)
    507e:	0016c603          	lbu	a2,1(a3)
        s++;
    5082:	0685                	addi	a3,a3,1
    while (*s)
    5084:	fe6d                	bnez	a2,507e <strtok+0x86>
    5086:	b7cd                	j	5068 <strtok+0x70>

0000000000005088 <strerror>:

char *strerror(int errnum)
{
    5088:	87aa                	mv	a5,a0
    
    switch (errnum)
    508a:	cd09                	beqz	a0,50a4 <strerror+0x1c>
    508c:	4731                	li	a4,12
    508e:	00000517          	auipc	a0,0x0
    5092:	16250513          	addi	a0,a0,354 # 51f0 <_GLOBAL__sub_I__ZSt3cin+0x12a>
    5096:	00e78b63          	beq	a5,a4,50ac <strerror+0x24>
        return "Success";
    // case EINVAL: return "Invalid argument";
    case ENOMEM: return "Out of memory";
    
    default:
        return "Unknown error";
    509a:	00000517          	auipc	a0,0x0
    509e:	16650513          	addi	a0,a0,358 # 5200 <_GLOBAL__sub_I__ZSt3cin+0x13a>
    50a2:	8082                	ret
        return "Success";
    50a4:	00000517          	auipc	a0,0x0
    50a8:	14450513          	addi	a0,a0,324 # 51e8 <_GLOBAL__sub_I__ZSt3cin+0x122>
    }
    50ac:	8082                	ret

00000000000050ae <_Znwm>:
#include "ulib/stdlib.h"

void *operator new(unsigned long n)
{
    return malloc(n);
    50ae:	cf6ff06f          	j	45a4 <malloc>

00000000000050b2 <_Znam>:
}

void *operator new[](unsigned long n)
    50b2:	cf2ff06f          	j	45a4 <malloc>

00000000000050b6 <_ZdlPv>:
    return malloc(n);
}

void operator delete(void *p)
{
    free(p);
    50b6:	c78ff06f          	j	452e <free>

00000000000050ba <_ZdaPv>:
}

void operator delete[](void *p)
    50ba:	c74ff06f          	j	452e <free>

00000000000050be <_ZdlPvm>:
    free(p);
}

void operator delete(void *p, unsigned long)
{
    free(p);
    50be:	c70ff06f          	j	452e <free>

00000000000050c2 <_ZdaPvm>:
}

void operator delete[](void *p, unsigned long)
    50c2:	c6cff06f          	j	452e <free>

00000000000050c6 <_GLOBAL__sub_I__ZSt3cin>:
#include "ulib/iostream"

namespace std
{
    istream cin(stdin);
    50c6:	00002797          	auipc	a5,0x2
    50ca:	74a7b783          	ld	a5,1866(a5) # 7810 <_GLOBAL_OFFSET_TABLE_+0x10>
    50ce:	6390                	ld	a2,0(a5)
    ostream cout(stdout);
    50d0:	00002797          	auipc	a5,0x2
    50d4:	7387b783          	ld	a5,1848(a5) # 7808 <_GLOBAL_OFFSET_TABLE_+0x8>
    50d8:	6394                	ld	a3,0(a5)
    ostream cerr(stderr);
    50da:	00002797          	auipc	a5,0x2
    50de:	73e7b783          	ld	a5,1854(a5) # 7818 <_GLOBAL_OFFSET_TABLE_+0x18>
    50e2:	6398                	ld	a4,0(a5)

    class istream{
    private:
        FILE* _stream;
    public:
        istream(FILE *f) : _stream(f) {}
    50e4:	00003797          	auipc	a5,0x3
    50e8:	88478793          	addi	a5,a5,-1916 # 7968 <_ZSt3cin>
    50ec:	e390                	sd	a2,0(a5)
        ostream(FILE* f) : _stream(f) {}
    50ee:	e794                	sd	a3,8(a5)
    50f0:	eb98                	sd	a4,16(a5)
} // namespace std
    50f2:	8082                	ret
