
build/user/initcode.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <_start>:
.section .text
.global _start

_start:
    li a0, 0
   0:	4501                	li	a0,0
    li a1, 0
   2:	4581                	li	a1,0

    call main
   4:	57a000ef          	jal	57e <main>

    call exit
   8:	706000ef          	jal	70e <exit>

   c:	a001                	j	c <_start+0xc>

000000000000000e <_Z6strlenPKc>:
#include "common/fcntl.h"

int strlen(const char *s)
{
    int n = 0;
    while (s[n])
   e:	00054783          	lbu	a5,0(a0)
  12:	cf81                	beqz	a5,2a <_Z6strlenPKc+0x1c>
  14:	0505                	addi	a0,a0,1
  16:	87aa                	mv	a5,a0
  18:	0007c703          	lbu	a4,0(a5)
  1c:	86be                	mv	a3,a5
  1e:	0785                	addi	a5,a5,1
  20:	ff65                	bnez	a4,18 <_Z6strlenPKc+0xa>
        n++;
  22:	40a6853b          	subw	a0,a3,a0
  26:	2505                	addiw	a0,a0,1
  28:	8082                	ret
    int n = 0;
  2a:	4501                	li	a0,0
    return n;
}
  2c:	8082                	ret

000000000000002e <_Z5printPKc>:
    while (s[n])
  2e:	00054783          	lbu	a5,0(a0)

void print(const char *s)
{
  32:	85aa                	mv	a1,a0
    while (s[n])
  34:	cf91                	beqz	a5,50 <_Z5printPKc+0x22>
  36:	00150693          	addi	a3,a0,1
  3a:	87b6                	mv	a5,a3
  3c:	0007c703          	lbu	a4,0(a5)
  40:	863e                	mv	a2,a5
  42:	0785                	addi	a5,a5,1
  44:	ff65                	bnez	a4,3c <_Z5printPKc+0xe>
        n++;
  46:	9e15                	subw	a2,a2,a3
  48:	2605                	addiw	a2,a2,1
    write(1, s, strlen(s));
  4a:	4505                	li	a0,1
  4c:	6e20006f          	j	72e <write>
    int n = 0;
  50:	4601                	li	a2,0
    write(1, s, strlen(s));
  52:	4505                	li	a0,1
  54:	ade9                	j	72e <write>

0000000000000056 <_Z9print_inti>:
void print_int(int n)
{
    char buf[16];
    int i = 0;
    int neg = 0;
    if (n == 0)
  56:	c149                	beqz	a0,d8 <_Z9print_inti+0x82>
{
  58:	7179                	addi	sp,sp,-48
  5a:	f406                	sd	ra,40(sp)
  5c:	f022                	sd	s0,32(sp)
  5e:	ec26                	sd	s1,24(sp)
    int neg = 0;
  60:	4801                	li	a6,0
    {
        write(1, "0", 1);
        return;
    }
    if (n < 0)
  62:	04054c63          	bltz	a0,ba <_Z9print_inti+0x64>
  66:	840a                	mv	s0,sp
    {
        neg = 1;
  68:	86a2                	mv	a3,s0
  6a:	4701                	li	a4,0
        n = -n;
    }
    while (n > 0)
    {
        buf[i++] = (n % 10) + '0';
  6c:	4629                	li	a2,10
  6e:	02c567bb          	remw	a5,a0,a2
    while (n > 0)
  72:	0685                	addi	a3,a3,1
  74:	85ba                	mv	a1,a4
        buf[i++] = (n % 10) + '0';
  76:	2705                	addiw	a4,a4,1
        n /= 10;
  78:	02c5453b          	divw	a0,a0,a2
        buf[i++] = (n % 10) + '0';
  7c:	0307879b          	addiw	a5,a5,48
  80:	fef68fa3          	sb	a5,-1(a3)
    while (n > 0)
  84:	f56d                	bnez	a0,6e <_Z9print_inti+0x18>
    }
    if (neg)
  86:	02081e63          	bnez	a6,c2 <_Z9print_inti+0x6c>
  8a:	fff7079b          	addiw	a5,a4,-1
  8e:	ffe40493          	addi	s1,s0,-2
  92:	1782                	slli	a5,a5,0x20
  94:	fff70693          	addi	a3,a4,-1
  98:	94ba                	add	s1,s1,a4
  9a:	9381                	srli	a5,a5,0x20
  9c:	9436                	add	s0,s0,a3
  9e:	8c9d                	sub	s1,s1,a5
        buf[i++] = '-';
    while (i > 0)
        write(1, &buf[--i], 1);
  a0:	85a2                	mv	a1,s0
  a2:	4605                	li	a2,1
  a4:	4505                	li	a0,1
    while (i > 0)
  a6:	147d                	addi	s0,s0,-1
        write(1, &buf[--i], 1);
  a8:	686000ef          	jal	72e <write>
    while (i > 0)
  ac:	fe849ae3          	bne	s1,s0,a0 <_Z9print_inti+0x4a>
}
  b0:	70a2                	ld	ra,40(sp)
  b2:	7402                	ld	s0,32(sp)
  b4:	64e2                	ld	s1,24(sp)
  b6:	6145                	addi	sp,sp,48
  b8:	8082                	ret
        n = -n;
  ba:	40a0053b          	negw	a0,a0
        neg = 1;
  be:	4805                	li	a6,1
  c0:	b75d                	j	66 <_Z9print_inti+0x10>
        buf[i++] = '-';
  c2:	01070793          	addi	a5,a4,16
  c6:	00278733          	add	a4,a5,sp
  ca:	02d00793          	li	a5,45
  ce:	fef70823          	sb	a5,-16(a4)
  d2:	0025871b          	addiw	a4,a1,2
  d6:	bf55                	j	8a <_Z9print_inti+0x34>
        write(1, "0", 1);
  d8:	4605                	li	a2,1
  da:	00000597          	auipc	a1,0x0
  de:	6e658593          	addi	a1,a1,1766 # 7c0 <disk_test+0xa>
  e2:	4505                	li	a0,1
  e4:	a5a9                	j	72e <write>

00000000000000e6 <_Z9print_hexy>:

void print_hex(uint64 n)
{
    char buf[16];
    char digits[] = "0123456789ABCDEF";
  e6:	00000797          	auipc	a5,0x0
  ea:	6ea78793          	addi	a5,a5,1770 # 7d0 <disk_test+0x1a>
  ee:	6394                	ld	a3,0(a5)
  f0:	6798                	ld	a4,8(a5)
  f2:	0107c783          	lbu	a5,16(a5)
{
  f6:	715d                	addi	sp,sp,-80
  f8:	fc26                	sd	s1,56(sp)
    write(1, "0x", 2);
  fa:	4609                	li	a2,2
{
  fc:	84aa                	mv	s1,a0
    write(1, "0x", 2);
  fe:	00000597          	auipc	a1,0x0
 102:	6ca58593          	addi	a1,a1,1738 # 7c8 <disk_test+0x12>
 106:	4505                	li	a0,1
{
 108:	e486                	sd	ra,72(sp)
    char digits[] = "0123456789ABCDEF";
 10a:	ec36                	sd	a3,24(sp)
 10c:	f03a                	sd	a4,32(sp)
 10e:	02f10423          	sb	a5,40(sp)
    write(1, "0x", 2);
 112:	61c000ef          	jal	72e <write>
    if (n == 0)
 116:	cca1                	beqz	s1,16e <_Z9print_hexy+0x88>
 118:	e0a2                	sd	s0,64(sp)
 11a:	0020                	addi	s0,sp,8
 11c:	87a2                	mv	a5,s0
        return;
    }
    int i = 0;
    while (n > 0)
    {
        buf[i++] = digits[n % 16];
 11e:	00f4f713          	andi	a4,s1,15
 122:	03070713          	addi	a4,a4,48
 126:	970a                	add	a4,a4,sp
 128:	fe874683          	lbu	a3,-24(a4)
        n /= 16;
 12c:	8091                	srli	s1,s1,0x4
 12e:	873e                	mv	a4,a5
        buf[i++] = digits[n % 16];
 130:	00d78023          	sb	a3,0(a5)
    while (n > 0)
 134:	0785                	addi	a5,a5,1
 136:	f4e5                	bnez	s1,11e <_Z9print_hexy+0x38>
 138:	9f01                	subw	a4,a4,s0
 13a:	0017079b          	addiw	a5,a4,1
 13e:	fff7871b          	addiw	a4,a5,-1
 142:	ffe40493          	addi	s1,s0,-2
 146:	1702                	slli	a4,a4,0x20
 148:	fff78693          	addi	a3,a5,-1
 14c:	94be                	add	s1,s1,a5
 14e:	9301                	srli	a4,a4,0x20
 150:	9436                	add	s0,s0,a3
 152:	8c99                	sub	s1,s1,a4
    }
    while (i > 0)
        write(1, &buf[--i], 1);
 154:	85a2                	mv	a1,s0
 156:	4605                	li	a2,1
 158:	4505                	li	a0,1
    while (i > 0)
 15a:	147d                	addi	s0,s0,-1
        write(1, &buf[--i], 1);
 15c:	5d2000ef          	jal	72e <write>
    while (i > 0)
 160:	fe941ae3          	bne	s0,s1,154 <_Z9print_hexy+0x6e>
 164:	6406                	ld	s0,64(sp)
}
 166:	60a6                	ld	ra,72(sp)
 168:	74e2                	ld	s1,56(sp)
 16a:	6161                	addi	sp,sp,80
 16c:	8082                	ret
 16e:	60a6                	ld	ra,72(sp)
 170:	74e2                	ld	s1,56(sp)
        write(1, "0", 1);
 172:	4605                	li	a2,1
 174:	00000597          	auipc	a1,0x0
 178:	64c58593          	addi	a1,a1,1612 # 7c0 <disk_test+0xa>
 17c:	4505                	li	a0,1
}
 17e:	6161                	addi	sp,sp,80
        write(1, "0", 1);
 180:	a37d                	j	72e <write>

0000000000000182 <_Z13test_syscallsv>:

void test_syscalls()
{
 182:	1101                	addi	sp,sp,-32
 184:	00000697          	auipc	a3,0x0
 188:	66468693          	addi	a3,a3,1636 # 7e8 <disk_test+0x32>
 18c:	ec06                	sd	ra,24(sp)
 18e:	e822                	sd	s0,16(sp)
 190:	e426                	sd	s1,8(sp)
 192:	87b6                	mv	a5,a3
    while (s[n])
 194:	0017c703          	lbu	a4,1(a5)
 198:	863e                	mv	a2,a5
 19a:	0785                	addi	a5,a5,1
 19c:	ff65                	bnez	a4,194 <_Z13test_syscallsv+0x12>
        n++;
 19e:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 1a0:	2605                	addiw	a2,a2,1
 1a2:	00000597          	auipc	a1,0x0
 1a6:	64658593          	addi	a1,a1,1606 # 7e8 <disk_test+0x32>
 1aa:	4505                	li	a0,1
 1ac:	582000ef          	jal	72e <write>
    while (s[n])
 1b0:	00000697          	auipc	a3,0x0
 1b4:	66868693          	addi	a3,a3,1640 # 818 <disk_test+0x62>
    write(1, s, strlen(s));
 1b8:	87b6                	mv	a5,a3
    while (s[n])
 1ba:	0017c703          	lbu	a4,1(a5)
 1be:	863e                	mv	a2,a5
 1c0:	0785                	addi	a5,a5,1
 1c2:	ff65                	bnez	a4,1ba <_Z13test_syscallsv+0x38>
        n++;
 1c4:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 1c6:	2605                	addiw	a2,a2,1
 1c8:	00000597          	auipc	a1,0x0
 1cc:	65058593          	addi	a1,a1,1616 # 818 <disk_test+0x62>
 1d0:	4505                	li	a0,1
 1d2:	55c000ef          	jal	72e <write>
    print("\n=== [Test] Starting System Call Check ===\n");

    print("[1/4] Checking getpid()... ");
    int my_pid = getpid();
 1d6:	5b8000ef          	jal	78e <getpid>
 1da:	842a                	mv	s0,a0
    if (my_pid > 0)
 1dc:	2aa05463          	blez	a0,484 <_Z13test_syscallsv+0x302>
 1e0:	00000697          	auipc	a3,0x0
 1e4:	65868693          	addi	a3,a3,1624 # 838 <disk_test+0x82>
 1e8:	87b6                	mv	a5,a3
    while (s[n])
 1ea:	0017c703          	lbu	a4,1(a5)
 1ee:	863e                	mv	a2,a5
 1f0:	0785                	addi	a5,a5,1
 1f2:	ff65                	bnez	a4,1ea <_Z13test_syscallsv+0x68>
        n++;
 1f4:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 1f6:	2605                	addiw	a2,a2,1
 1f8:	00000597          	auipc	a1,0x0
 1fc:	64058593          	addi	a1,a1,1600 # 838 <disk_test+0x82>
 200:	4505                	li	a0,1
 202:	52c000ef          	jal	72e <write>
    {
        print("PASS (PID=");
        print_int(my_pid);
 206:	8522                	mv	a0,s0
 208:	e4fff0ef          	jal	56 <_Z9print_inti>
    while (s[n])
 20c:	00000697          	auipc	a3,0x0
 210:	63c68693          	addi	a3,a3,1596 # 848 <disk_test+0x92>
        print_int(my_pid);
 214:	87b6                	mv	a5,a3
    while (s[n])
 216:	0017c703          	lbu	a4,1(a5)
 21a:	863e                	mv	a2,a5
 21c:	0785                	addi	a5,a5,1
 21e:	ff65                	bnez	a4,216 <_Z13test_syscallsv+0x94>
        n++;
 220:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 222:	2605                	addiw	a2,a2,1
 224:	00000597          	auipc	a1,0x0
 228:	62458593          	addi	a1,a1,1572 # 848 <disk_test+0x92>
 22c:	4505                	li	a0,1
 22e:	500000ef          	jal	72e <write>
    while (s[n])
 232:	00000697          	auipc	a3,0x0
 236:	63668693          	addi	a3,a3,1590 # 868 <disk_test+0xb2>
    if (my_pid > 0)
 23a:	87b6                	mv	a5,a3
    while (s[n])
 23c:	0017c703          	lbu	a4,1(a5)
 240:	863e                	mv	a2,a5
 242:	0785                	addi	a5,a5,1
 244:	ff65                	bnez	a4,23c <_Z13test_syscallsv+0xba>
        n++;
 246:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 248:	2605                	addiw	a2,a2,1
 24a:	00000597          	auipc	a1,0x0
 24e:	61e58593          	addi	a1,a1,1566 # 868 <disk_test+0xb2>
 252:	4505                	li	a0,1
 254:	4da000ef          	jal	72e <write>
    {
        print("FAIL (Invalid PID)\n");
    }

    print("[2/4] Checking sbrk() heap allocation... ");
    char *p = sbrk(4096);
 258:	6505                	lui	a0,0x1
 25a:	53c000ef          	jal	796 <sbrk>
    if (p == (char *)-1)
 25e:	57fd                	li	a5,-1
    char *p = sbrk(4096);
 260:	84aa                	mv	s1,a0
    if (p == (char *)-1)
 262:	24f50563          	beq	a0,a5,4ac <_Z13test_syscallsv+0x32a>
    {
        print("FAIL (sbrk returned error)\n");
    }
    else
    {
        p[0] = 'A';
 266:	04100793          	li	a5,65
 26a:	00f50023          	sb	a5,0(a0) # 1000 <disk_test+0x84a>
        p[4095] = 'Z';
 26e:	6785                	lui	a5,0x1
 270:	97aa                	add	a5,a5,a0
 272:	00000697          	auipc	a3,0x0
 276:	64668693          	addi	a3,a3,1606 # 8b8 <disk_test+0x102>
 27a:	05a00713          	li	a4,90
 27e:	fee78fa3          	sb	a4,-1(a5) # fff <disk_test+0x849>
 282:	87b6                	mv	a5,a3
    while (s[n])
 284:	0017c703          	lbu	a4,1(a5)
 288:	863e                	mv	a2,a5
 28a:	0785                	addi	a5,a5,1
 28c:	ff65                	bnez	a4,284 <_Z13test_syscallsv+0x102>
        n++;
 28e:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 290:	2605                	addiw	a2,a2,1
 292:	00000597          	auipc	a1,0x0
 296:	62658593          	addi	a1,a1,1574 # 8b8 <disk_test+0x102>
 29a:	4505                	li	a0,1
 29c:	492000ef          	jal	72e <write>
        if (p[0] == 'A' && p[4095] == 'Z')
        {
            print("PASS (Allocated at ");
            print_hex((uint64)p);
 2a0:	8526                	mv	a0,s1
 2a2:	e45ff0ef          	jal	e6 <_Z9print_hexy>
    while (s[n])
 2a6:	00000697          	auipc	a3,0x0
 2aa:	5a268693          	addi	a3,a3,1442 # 848 <disk_test+0x92>
            print_hex((uint64)p);
 2ae:	87b6                	mv	a5,a3
    while (s[n])
 2b0:	0017c703          	lbu	a4,1(a5)
 2b4:	863e                	mv	a2,a5
 2b6:	0785                	addi	a5,a5,1
 2b8:	ff65                	bnez	a4,2b0 <_Z13test_syscallsv+0x12e>
        n++;
 2ba:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 2bc:	2605                	addiw	a2,a2,1
 2be:	00000597          	auipc	a1,0x0
 2c2:	58a58593          	addi	a1,a1,1418 # 848 <disk_test+0x92>
 2c6:	4505                	li	a0,1
 2c8:	466000ef          	jal	72e <write>
    while (s[n])
 2cc:	00000697          	auipc	a3,0x0
 2d0:	60468693          	addi	a3,a3,1540 # 8d0 <disk_test+0x11a>
            print_hex((uint64)p);
 2d4:	87b6                	mv	a5,a3
    while (s[n])
 2d6:	0017c703          	lbu	a4,1(a5)
 2da:	863e                	mv	a2,a5
 2dc:	0785                	addi	a5,a5,1
 2de:	ff65                	bnez	a4,2d6 <_Z13test_syscallsv+0x154>
        n++;
 2e0:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 2e2:	2605                	addiw	a2,a2,1
 2e4:	00000597          	auipc	a1,0x0
 2e8:	5ec58593          	addi	a1,a1,1516 # 8d0 <disk_test+0x11a>
 2ec:	4505                	li	a0,1
 2ee:	440000ef          	jal	72e <write>
            print("FAIL (Memory read/write check failed)\n");
        }
    }

    print("[3/4] Checking fork() and wait()...\n");
    int pid = fork();
 2f2:	414000ef          	jal	706 <fork>
 2f6:	84aa                	mv	s1,a0

    if (pid < 0)
 2f8:	1c054e63          	bltz	a0,4d4 <_Z13test_syscallsv+0x352>
    {
        print("      FAIL: fork error\n");
    }
    else if (pid == 0)
 2fc:	e179                	bnez	a0,3c2 <_Z13test_syscallsv+0x240>
    {
        int child_pid = getpid();
 2fe:	490000ef          	jal	78e <getpid>
 302:	84aa                	mv	s1,a0
        if (child_pid == my_pid)
 304:	24a40563          	beq	s0,a0,54e <_Z13test_syscallsv+0x3cc>
    while (s[n])
 308:	00000697          	auipc	a3,0x0
 30c:	63868693          	addi	a3,a3,1592 # 940 <disk_test+0x18a>
        if (child_pid == my_pid)
 310:	87b6                	mv	a5,a3
    while (s[n])
 312:	0017c703          	lbu	a4,1(a5)
 316:	863e                	mv	a2,a5
 318:	0785                	addi	a5,a5,1
 31a:	ff65                	bnez	a4,312 <_Z13test_syscallsv+0x190>
        n++;
 31c:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 31e:	2605                	addiw	a2,a2,1
 320:	00000597          	auipc	a1,0x0
 324:	62058593          	addi	a1,a1,1568 # 940 <disk_test+0x18a>
 328:	4505                	li	a0,1
 32a:	404000ef          	jal	72e <write>
        {
            print("      FAIL: Child has same PID as parent\n");
            exit(1);
        }
        print("      [Child] I am alive. PID=");
        print_int(child_pid);
 32e:	8526                	mv	a0,s1
 330:	d27ff0ef          	jal	56 <_Z9print_inti>
    write(1, s, strlen(s));
 334:	4605                	li	a2,1
 336:	00000597          	auipc	a1,0x0
 33a:	62a58593          	addi	a1,a1,1578 # 960 <disk_test+0x1aa>
 33e:	4505                	li	a0,1
 340:	3ee000ef          	jal	72e <write>
    while (s[n])
 344:	00000697          	auipc	a3,0x0
 348:	62468693          	addi	a3,a3,1572 # 968 <disk_test+0x1b2>
    write(1, s, strlen(s));
 34c:	87b6                	mv	a5,a3
    while (s[n])
 34e:	0017c703          	lbu	a4,1(a5)
 352:	863e                	mv	a2,a5
 354:	0785                	addi	a5,a5,1
 356:	ff65                	bnez	a4,34e <_Z13test_syscallsv+0x1cc>
        n++;
 358:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 35a:	2605                	addiw	a2,a2,1
 35c:	00000597          	auipc	a1,0x0
 360:	60c58593          	addi	a1,a1,1548 # 968 <disk_test+0x1b2>
 364:	4505                	li	a0,1
 366:	3c8000ef          	jal	72e <write>
        print("\n");
        print("      [Child] Exiting now.\n");
        exit(0);
 36a:	4501                	li	a0,0
 36c:	3a2000ef          	jal	70e <exit>
    while (s[n])
 370:	00000697          	auipc	a3,0x0
 374:	6c868693          	addi	a3,a3,1736 # a38 <disk_test+0x282>
            print("PASS (Fork/Wait cycle)\n");
        }
        else
        {
            print("FAIL (Wait returned ");
            print_int(waited_pid);
 378:	87b6                	mv	a5,a3
    while (s[n])
 37a:	0017c703          	lbu	a4,1(a5)
 37e:	863e                	mv	a2,a5
 380:	0785                	addi	a5,a5,1
 382:	ff65                	bnez	a4,37a <_Z13test_syscallsv+0x1f8>
        n++;
 384:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 386:	2605                	addiw	a2,a2,1
 388:	00000597          	auipc	a1,0x0
 38c:	6b058593          	addi	a1,a1,1712 # a38 <disk_test+0x282>
 390:	4505                	li	a0,1
 392:	39c000ef          	jal	72e <write>
    while (s[n])
 396:	00000697          	auipc	a3,0x0
 39a:	6d268693          	addi	a3,a3,1746 # a68 <disk_test+0x2b2>
    write(1, s, strlen(s));
 39e:	87b6                	mv	a5,a3
    while (s[n])
 3a0:	0017c703          	lbu	a4,1(a5)
 3a4:	863e                	mv	a2,a5
 3a6:	0785                	addi	a5,a5,1
 3a8:	ff65                	bnez	a4,3a0 <_Z13test_syscallsv+0x21e>
    }

    print("[4/4] Checking write()... PASS (Self-evident)\n");

    print("=== [Test] All Tests Finished ===\n");
}
 3aa:	6442                	ld	s0,16(sp)
 3ac:	60e2                	ld	ra,24(sp)
 3ae:	64a2                	ld	s1,8(sp)
        n++;
 3b0:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 3b2:	2605                	addiw	a2,a2,1
 3b4:	00000597          	auipc	a1,0x0
 3b8:	6b458593          	addi	a1,a1,1716 # a68 <disk_test+0x2b2>
 3bc:	4505                	li	a0,1
}
 3be:	6105                	addi	sp,sp,32
    write(1, s, strlen(s));
 3c0:	a6bd                	j	72e <write>
 3c2:	00000697          	auipc	a3,0x0
 3c6:	5c668693          	addi	a3,a3,1478 # 988 <disk_test+0x1d2>
    else if (pid == 0)
 3ca:	87b6                	mv	a5,a3
    while (s[n])
 3cc:	0017c703          	lbu	a4,1(a5)
 3d0:	863e                	mv	a2,a5
 3d2:	0785                	addi	a5,a5,1
 3d4:	ff65                	bnez	a4,3cc <_Z13test_syscallsv+0x24a>
        n++;
 3d6:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 3d8:	2605                	addiw	a2,a2,1
 3da:	00000597          	auipc	a1,0x0
 3de:	5ae58593          	addi	a1,a1,1454 # 988 <disk_test+0x1d2>
 3e2:	4505                	li	a0,1
 3e4:	34a000ef          	jal	72e <write>
        print_int(pid);
 3e8:	8526                	mv	a0,s1
 3ea:	c6dff0ef          	jal	56 <_Z9print_inti>
    write(1, s, strlen(s));
 3ee:	4605                	li	a2,1
 3f0:	00000597          	auipc	a1,0x0
 3f4:	57058593          	addi	a1,a1,1392 # 960 <disk_test+0x1aa>
 3f8:	4505                	li	a0,1
 3fa:	334000ef          	jal	72e <write>
    while (s[n])
 3fe:	00000697          	auipc	a3,0x0
 402:	5b268693          	addi	a3,a3,1458 # 9b0 <disk_test+0x1fa>
    write(1, s, strlen(s));
 406:	87b6                	mv	a5,a3
    while (s[n])
 408:	0017c703          	lbu	a4,1(a5)
 40c:	863e                	mv	a2,a5
 40e:	0785                	addi	a5,a5,1
 410:	ff65                	bnez	a4,408 <_Z13test_syscallsv+0x286>
        n++;
 412:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 414:	2605                	addiw	a2,a2,1
 416:	00000597          	auipc	a1,0x0
 41a:	59a58593          	addi	a1,a1,1434 # 9b0 <disk_test+0x1fa>
 41e:	4505                	li	a0,1
 420:	30e000ef          	jal	72e <write>
        int waited_pid = wait(0);
 424:	4501                	li	a0,0
 426:	2f0000ef          	jal	716 <wait>
 42a:	00000697          	auipc	a3,0x0
 42e:	5f668693          	addi	a3,a3,1526 # a20 <disk_test+0x26a>
 432:	842a                	mv	s0,a0
        if (waited_pid == pid)
 434:	87b6                	mv	a5,a3
 436:	0ca48363          	beq	s1,a0,4fc <_Z13test_syscallsv+0x37a>
    while (s[n])
 43a:	0017c703          	lbu	a4,1(a5)
 43e:	863e                	mv	a2,a5
 440:	0785                	addi	a5,a5,1
 442:	ff65                	bnez	a4,43a <_Z13test_syscallsv+0x2b8>
        n++;
 444:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 446:	2605                	addiw	a2,a2,1
 448:	00000597          	auipc	a1,0x0
 44c:	5d858593          	addi	a1,a1,1496 # a20 <disk_test+0x26a>
 450:	4505                	li	a0,1
 452:	2dc000ef          	jal	72e <write>
            print_int(waited_pid);
 456:	8522                	mv	a0,s0
 458:	bffff0ef          	jal	56 <_Z9print_inti>
    while (s[n])
 45c:	00000697          	auipc	a3,0x0
 460:	3ec68693          	addi	a3,a3,1004 # 848 <disk_test+0x92>
            print_int(waited_pid);
 464:	87b6                	mv	a5,a3
    while (s[n])
 466:	0017c703          	lbu	a4,1(a5)
 46a:	863e                	mv	a2,a5
 46c:	0785                	addi	a5,a5,1
 46e:	ff65                	bnez	a4,466 <_Z13test_syscallsv+0x2e4>
        n++;
 470:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 472:	2605                	addiw	a2,a2,1
 474:	00000597          	auipc	a1,0x0
 478:	3d458593          	addi	a1,a1,980 # 848 <disk_test+0x92>
 47c:	4505                	li	a0,1
 47e:	2b0000ef          	jal	72e <write>
}
 482:	b5fd                	j	370 <_Z13test_syscallsv+0x1ee>
 484:	00000697          	auipc	a3,0x0
 488:	3cc68693          	addi	a3,a3,972 # 850 <disk_test+0x9a>
    if (my_pid > 0)
 48c:	87b6                	mv	a5,a3
    while (s[n])
 48e:	0017c703          	lbu	a4,1(a5)
 492:	863e                	mv	a2,a5
 494:	0785                	addi	a5,a5,1
 496:	ff65                	bnez	a4,48e <_Z13test_syscallsv+0x30c>
        n++;
 498:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 49a:	2605                	addiw	a2,a2,1
 49c:	00000597          	auipc	a1,0x0
 4a0:	3b458593          	addi	a1,a1,948 # 850 <disk_test+0x9a>
 4a4:	4505                	li	a0,1
 4a6:	288000ef          	jal	72e <write>
}
 4aa:	b361                	j	232 <_Z13test_syscallsv+0xb0>
 4ac:	00000697          	auipc	a3,0x0
 4b0:	3ec68693          	addi	a3,a3,1004 # 898 <disk_test+0xe2>
    if (p == (char *)-1)
 4b4:	87b6                	mv	a5,a3
    while (s[n])
 4b6:	0017c703          	lbu	a4,1(a5)
 4ba:	863e                	mv	a2,a5
 4bc:	0785                	addi	a5,a5,1
 4be:	ff65                	bnez	a4,4b6 <_Z13test_syscallsv+0x334>
        n++;
 4c0:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 4c2:	2605                	addiw	a2,a2,1
 4c4:	00000597          	auipc	a1,0x0
 4c8:	3d458593          	addi	a1,a1,980 # 898 <disk_test+0xe2>
 4cc:	4505                	li	a0,1
 4ce:	260000ef          	jal	72e <write>
}
 4d2:	bbed                	j	2cc <_Z13test_syscallsv+0x14a>
 4d4:	00000697          	auipc	a3,0x0
 4d8:	42468693          	addi	a3,a3,1060 # 8f8 <disk_test+0x142>
    if (pid < 0)
 4dc:	87b6                	mv	a5,a3
    while (s[n])
 4de:	0017c703          	lbu	a4,1(a5)
 4e2:	863e                	mv	a2,a5
 4e4:	0785                	addi	a5,a5,1
 4e6:	ff65                	bnez	a4,4de <_Z13test_syscallsv+0x35c>
        n++;
 4e8:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 4ea:	2605                	addiw	a2,a2,1
 4ec:	00000597          	auipc	a1,0x0
 4f0:	40c58593          	addi	a1,a1,1036 # 8f8 <disk_test+0x142>
 4f4:	4505                	li	a0,1
 4f6:	238000ef          	jal	72e <write>
}
 4fa:	bd9d                	j	370 <_Z13test_syscallsv+0x1ee>
 4fc:	00000617          	auipc	a2,0x0
 500:	4dc60613          	addi	a2,a2,1244 # 9d8 <disk_test+0x222>
        if (waited_pid == pid)
 504:	87b2                	mv	a5,a2
    while (s[n])
 506:	0017c703          	lbu	a4,1(a5)
 50a:	86be                	mv	a3,a5
 50c:	0785                	addi	a5,a5,1
 50e:	ff65                	bnez	a4,506 <_Z13test_syscallsv+0x384>
        n++;
 510:	40c6863b          	subw	a2,a3,a2
    write(1, s, strlen(s));
 514:	2605                	addiw	a2,a2,1
 516:	00000597          	auipc	a1,0x0
 51a:	4c258593          	addi	a1,a1,1218 # 9d8 <disk_test+0x222>
 51e:	4505                	li	a0,1
 520:	20e000ef          	jal	72e <write>
    while (s[n])
 524:	00000617          	auipc	a2,0x0
 528:	4e460613          	addi	a2,a2,1252 # a08 <disk_test+0x252>
    write(1, s, strlen(s));
 52c:	87b2                	mv	a5,a2
    while (s[n])
 52e:	0017c703          	lbu	a4,1(a5)
 532:	86be                	mv	a3,a5
 534:	0785                	addi	a5,a5,1
 536:	ff65                	bnez	a4,52e <_Z13test_syscallsv+0x3ac>
        n++;
 538:	40c6863b          	subw	a2,a3,a2
    write(1, s, strlen(s));
 53c:	2605                	addiw	a2,a2,1
 53e:	00000597          	auipc	a1,0x0
 542:	4ca58593          	addi	a1,a1,1226 # a08 <disk_test+0x252>
 546:	4505                	li	a0,1
 548:	1e6000ef          	jal	72e <write>
}
 54c:	b515                	j	370 <_Z13test_syscallsv+0x1ee>
 54e:	00000617          	auipc	a2,0x0
 552:	3c260613          	addi	a2,a2,962 # 910 <disk_test+0x15a>
        if (child_pid == my_pid)
 556:	87b2                	mv	a5,a2
    while (s[n])
 558:	0017c703          	lbu	a4,1(a5)
 55c:	86be                	mv	a3,a5
 55e:	0785                	addi	a5,a5,1
 560:	ff65                	bnez	a4,558 <_Z13test_syscallsv+0x3d6>
        n++;
 562:	40c6863b          	subw	a2,a3,a2
    write(1, s, strlen(s));
 566:	2605                	addiw	a2,a2,1
 568:	00000597          	auipc	a1,0x0
 56c:	3a858593          	addi	a1,a1,936 # 910 <disk_test+0x15a>
 570:	4505                	li	a0,1
 572:	1bc000ef          	jal	72e <write>
            exit(1);
 576:	4505                	li	a0,1
 578:	196000ef          	jal	70e <exit>
 57c:	b371                	j	308 <_Z13test_syscallsv+0x186>

000000000000057e <main>:


int main()
{
 57e:	7119                	addi	sp,sp,-128
    print("\n[Lume Shell] Init process started.\n");
 580:	00000517          	auipc	a0,0x0
 584:	51050513          	addi	a0,a0,1296 # a90 <disk_test+0x2da>
{
 588:	fc86                	sd	ra,120(sp)
 58a:	f8a2                	sd	s0,112(sp)
 58c:	f4a6                	sd	s1,104(sp)
 58e:	f0ca                	sd	s2,96(sp)
 590:	ecce                	sd	s3,88(sp)
 592:	e8d2                	sd	s4,80(sp)
 594:	e4d6                	sd	s5,72(sp)
 596:	e0da                	sd	s6,64(sp)
    print("\n[Lume Shell] Init process started.\n");
 598:	a97ff0ef          	jal	2e <_Z5printPKc>
    print("[Test] Opening test.txt...\n");
 59c:	00000517          	auipc	a0,0x0
 5a0:	51c50513          	addi	a0,a0,1308 # ab8 <disk_test+0x302>
 5a4:	a8bff0ef          	jal	2e <_Z5printPKc>
    int fd = open("test.txt", O_RDONLY);
 5a8:	4581                	li	a1,0
 5aa:	00000517          	auipc	a0,0x0
 5ae:	52e50513          	addi	a0,a0,1326 # ad8 <disk_test+0x322>
 5b2:	19c000ef          	jal	74e <open>
    if (fd < 0)
 5b6:	14054063          	bltz	a0,6f6 <main+0x178>
 5ba:	84aa                	mv	s1,a0
    {
        print("[Test] Open failed (Is test.txt in fs.img?)\n");
    }
    else
    {
        print("[Test] Open success! fd=");
 5bc:	00000517          	auipc	a0,0x0
 5c0:	55c50513          	addi	a0,a0,1372 # b18 <disk_test+0x362>
 5c4:	a6bff0ef          	jal	2e <_Z5printPKc>
        print_int(fd);
 5c8:	8526                	mv	a0,s1
 5ca:	a8dff0ef          	jal	56 <_Z9print_inti>
        print("\n");
 5ce:	00000517          	auipc	a0,0x0
 5d2:	39250513          	addi	a0,a0,914 # 960 <disk_test+0x1aa>
 5d6:	a59ff0ef          	jal	2e <_Z5printPKc>

        char buf[64];
        int n = read(fd, buf, 63);
 5da:	840a                	mv	s0,sp
 5dc:	03f00613          	li	a2,63
 5e0:	85a2                	mv	a1,s0
 5e2:	8526                	mv	a0,s1
 5e4:	142000ef          	jal	726 <read>
 5e8:	892a                	mv	s2,a0
        if (n > 0)
 5ea:	0ca05663          	blez	a0,6b6 <main+0x138>
        {
            buf[n] = 0;
 5ee:	04050793          	addi	a5,a0,64
 5f2:	00278933          	add	s2,a5,sp
            print("[Test] Read content:\n---\n");
 5f6:	00000517          	auipc	a0,0x0
 5fa:	54250513          	addi	a0,a0,1346 # b38 <disk_test+0x382>
            buf[n] = 0;
 5fe:	fc090023          	sb	zero,-64(s2)
            print("[Test] Read content:\n---\n");
 602:	a2dff0ef          	jal	2e <_Z5printPKc>
            print(buf);
 606:	8522                	mv	a0,s0
 608:	a27ff0ef          	jal	2e <_Z5printPKc>
            print("\n---\n");
 60c:	00000517          	auipc	a0,0x0
 610:	54c50513          	addi	a0,a0,1356 # b58 <disk_test+0x3a2>
 614:	a1bff0ef          	jal	2e <_Z5printPKc>
        {
            print("[Test] Read returned ");
            print_int(n);
            print("\n");
        }
        close(fd);
 618:	8526                	mv	a0,s1
 61a:	11c000ef          	jal	736 <close>
        print("[Test] File closed.\n");
 61e:	00000517          	auipc	a0,0x0
 622:	55a50513          	addi	a0,a0,1370 # b78 <disk_test+0x3c2>
 626:	a09ff0ef          	jal	2e <_Z5printPKc>
    }

    

    print("Commands:\n");
 62a:	00000517          	auipc	a0,0x0
 62e:	56650513          	addi	a0,a0,1382 # b90 <disk_test+0x3da>
 632:	9fdff0ef          	jal	2e <_Z5printPKc>
    print("  s: Run System Call Tests (fork, wait, mm)\n");
 636:	00000517          	auipc	a0,0x0
 63a:	56a50513          	addi	a0,a0,1386 # ba0 <disk_test+0x3ea>
 63e:	9f1ff0ef          	jal	2e <_Z5printPKc>
    print("  t: Run Disk Driver Test (VirtIO)\n");
 642:	00000517          	auipc	a0,0x0
 646:	58e50513          	addi	a0,a0,1422 # bd0 <disk_test+0x41a>
 64a:	00000b17          	auipc	s6,0x0
 64e:	5b6b0b13          	addi	s6,s6,1462 # c00 <disk_test+0x44a>
        n++;
 652:	4a85                	li	s5,1
    print("  t: Run Disk Driver Test (VirtIO)\n");
 654:	9dbff0ef          	jal	2e <_Z5printPKc>

    while (1)
    {
        char buf[16];
        write(1, "$ ", 2);
 658:	00000497          	auipc	s1,0x0
 65c:	5a048493          	addi	s1,s1,1440 # bf8 <disk_test+0x442>

        int n = read(0, buf, sizeof(buf));
        if (n <= 0)
            continue;

        if (buf[0] == 's')
 660:	07300913          	li	s2,115
        {
            test_syscalls();
        }
        else if (buf[0] == 't')
 664:	07400993          	li	s3,116
                disk_test();
                exit(0);
            }
            wait(0);
        }
        else if (buf[0] != '\n')
 668:	4a29                	li	s4,10
        n++;
 66a:	416a8abb          	subw	s5,s5,s6
        write(1, "$ ", 2);
 66e:	4609                	li	a2,2
 670:	85a6                	mv	a1,s1
 672:	4505                	li	a0,1
 674:	0ba000ef          	jal	72e <write>
        int n = read(0, buf, sizeof(buf));
 678:	4641                	li	a2,16
 67a:	85a2                	mv	a1,s0
 67c:	4501                	li	a0,0
 67e:	0a8000ef          	jal	726 <read>
        if (n <= 0)
 682:	fea056e3          	blez	a0,66e <main+0xf0>
        if (buf[0] == 's')
 686:	00014783          	lbu	a5,0(sp)
 68a:	05278663          	beq	a5,s2,6d6 <main+0x158>
        else if (buf[0] == 't')
 68e:	05378763          	beq	a5,s3,6dc <main+0x15e>
        else if (buf[0] != '\n')
 692:	fd478ee3          	beq	a5,s4,66e <main+0xf0>
 696:	00000797          	auipc	a5,0x0
 69a:	56a78793          	addi	a5,a5,1386 # c00 <disk_test+0x44a>
    while (s[n])
 69e:	0017c703          	lbu	a4,1(a5)
 6a2:	863e                	mv	a2,a5
 6a4:	0785                	addi	a5,a5,1
 6a6:	ff65                	bnez	a4,69e <main+0x120>
    write(1, s, strlen(s));
 6a8:	00ca863b          	addw	a2,s5,a2
 6ac:	85da                	mv	a1,s6
 6ae:	4505                	li	a0,1
 6b0:	07e000ef          	jal	72e <write>
}
 6b4:	bf6d                	j	66e <main+0xf0>
            print("[Test] Read returned ");
 6b6:	00000517          	auipc	a0,0x0
 6ba:	4aa50513          	addi	a0,a0,1194 # b60 <disk_test+0x3aa>
 6be:	971ff0ef          	jal	2e <_Z5printPKc>
            print_int(n);
 6c2:	854a                	mv	a0,s2
 6c4:	993ff0ef          	jal	56 <_Z9print_inti>
            print("\n");
 6c8:	00000517          	auipc	a0,0x0
 6cc:	29850513          	addi	a0,a0,664 # 960 <disk_test+0x1aa>
 6d0:	95fff0ef          	jal	2e <_Z5printPKc>
 6d4:	b791                	j	618 <main+0x9a>
            test_syscalls();
 6d6:	aadff0ef          	jal	182 <_Z13test_syscallsv>
 6da:	bf51                	j	66e <main+0xf0>
            if (fork() == 0)
 6dc:	02a000ef          	jal	706 <fork>
 6e0:	c509                	beqz	a0,6ea <main+0x16c>
            wait(0);
 6e2:	4501                	li	a0,0
 6e4:	032000ef          	jal	716 <wait>
 6e8:	b759                	j	66e <main+0xf0>
                disk_test();
 6ea:	0cc000ef          	jal	7b6 <disk_test>
                exit(0);
 6ee:	4501                	li	a0,0
 6f0:	01e000ef          	jal	70e <exit>
 6f4:	b7fd                	j	6e2 <main+0x164>
        print("[Test] Open failed (Is test.txt in fs.img?)\n");
 6f6:	00000517          	auipc	a0,0x0
 6fa:	3f250513          	addi	a0,a0,1010 # ae8 <disk_test+0x332>
 6fe:	931ff0ef          	jal	2e <_Z5printPKc>
 702:	840a                	mv	s0,sp
 704:	b71d                	j	62a <main+0xac>

0000000000000706 <fork>:
    name: \
        li a7, SYS_ ## name; \
        ecall; \
        ret

SYSCALL(fork)
 706:	4889                	li	a7,2
 708:	00000073          	ecall
 70c:	8082                	ret

000000000000070e <exit>:
SYSCALL(exit)
 70e:	488d                	li	a7,3
 710:	00000073          	ecall
 714:	8082                	ret

0000000000000716 <wait>:
SYSCALL(wait)
 716:	4891                	li	a7,4
 718:	00000073          	ecall
 71c:	8082                	ret

000000000000071e <pipe>:
SYSCALL(pipe)
 71e:	4895                	li	a7,5
 720:	00000073          	ecall
 724:	8082                	ret

0000000000000726 <read>:
SYSCALL(read)
 726:	4899                	li	a7,6
 728:	00000073          	ecall
 72c:	8082                	ret

000000000000072e <write>:
SYSCALL(write)
 72e:	48c5                	li	a7,17
 730:	00000073          	ecall
 734:	8082                	ret

0000000000000736 <close>:
SYSCALL(close)
 736:	48d9                	li	a7,22
 738:	00000073          	ecall
 73c:	8082                	ret

000000000000073e <kill>:
SYSCALL(kill)
 73e:	489d                	li	a7,7
 740:	00000073          	ecall
 744:	8082                	ret

0000000000000746 <exec>:
SYSCALL(exec)
 746:	48a1                	li	a7,8
 748:	00000073          	ecall
 74c:	8082                	ret

000000000000074e <open>:
SYSCALL(open)
 74e:	48c1                	li	a7,16
 750:	00000073          	ecall
 754:	8082                	ret

0000000000000756 <mknod>:
SYSCALL(mknod)
 756:	48c9                	li	a7,18
 758:	00000073          	ecall
 75c:	8082                	ret

000000000000075e <unlink>:
SYSCALL(unlink)
 75e:	48cd                	li	a7,19
 760:	00000073          	ecall
 764:	8082                	ret

0000000000000766 <fstat>:
SYSCALL(fstat)
 766:	48a5                	li	a7,9
 768:	00000073          	ecall
 76c:	8082                	ret

000000000000076e <link>:
SYSCALL(link)
 76e:	48d1                	li	a7,20
 770:	00000073          	ecall
 774:	8082                	ret

0000000000000776 <mkdir>:
SYSCALL(mkdir)
 776:	48d5                	li	a7,21
 778:	00000073          	ecall
 77c:	8082                	ret

000000000000077e <chdir>:
SYSCALL(chdir)
 77e:	48a9                	li	a7,10
 780:	00000073          	ecall
 784:	8082                	ret

0000000000000786 <dup>:
SYSCALL(dup)
 786:	48ad                	li	a7,11
 788:	00000073          	ecall
 78c:	8082                	ret

000000000000078e <getpid>:
SYSCALL(getpid)
 78e:	48b1                	li	a7,12
 790:	00000073          	ecall
 794:	8082                	ret

0000000000000796 <sbrk>:
SYSCALL(sbrk)
 796:	48b5                	li	a7,13
 798:	00000073          	ecall
 79c:	8082                	ret

000000000000079e <sleep>:
SYSCALL(sleep)
 79e:	48b9                	li	a7,14
 7a0:	00000073          	ecall
 7a4:	8082                	ret

00000000000007a6 <uptime>:
SYSCALL(uptime)
 7a6:	48bd                	li	a7,15
 7a8:	00000073          	ecall
 7ac:	8082                	ret

00000000000007ae <putc>:
SYSCALL(putc)
 7ae:	4885                	li	a7,1
 7b0:	00000073          	ecall
 7b4:	8082                	ret

00000000000007b6 <disk_test>:
 7b6:	48dd                	li	a7,23
 7b8:	00000073          	ecall
 7bc:	8082                	ret
