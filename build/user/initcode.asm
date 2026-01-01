
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
   4:	578000ef          	jal	57c <main>

    call exit
   8:	648000ef          	jal	650 <exit>

   c:	a001                	j	c <_start+0xc>

000000000000000e <_Z6strlenPKc>:
// =============================================================

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
  34:	cf89                	beqz	a5,4e <_Z5printPKc+0x20>
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
  4c:	a515                	j	670 <write>
    int n = 0;
  4e:	4601                	li	a2,0
    write(1, s, strlen(s));
  50:	4505                	li	a0,1
  52:	ad39                	j	670 <write>

0000000000000054 <_Z9print_inti>:
void print_int(int n)
{
    char buf[16];
    int i = 0;
    int neg = 0;
    if (n == 0)
  54:	c149                	beqz	a0,d6 <_Z9print_inti+0x82>
{
  56:	7179                	addi	sp,sp,-48
  58:	f406                	sd	ra,40(sp)
  5a:	f022                	sd	s0,32(sp)
  5c:	ec26                	sd	s1,24(sp)
    int neg = 0;
  5e:	4801                	li	a6,0
    {
        write(1, "0", 1);
        return;
    }
    if (n < 0)
  60:	04054c63          	bltz	a0,b8 <_Z9print_inti+0x64>
  64:	840a                	mv	s0,sp
    {
        neg = 1;
  66:	86a2                	mv	a3,s0
  68:	4701                	li	a4,0
        n = -n;
    }
    while (n > 0)
    {
        buf[i++] = (n % 10) + '0';
  6a:	4629                	li	a2,10
  6c:	02c567bb          	remw	a5,a0,a2
    while (n > 0)
  70:	0685                	addi	a3,a3,1
  72:	85ba                	mv	a1,a4
        buf[i++] = (n % 10) + '0';
  74:	2705                	addiw	a4,a4,1
        n /= 10;
  76:	02c5453b          	divw	a0,a0,a2
        buf[i++] = (n % 10) + '0';
  7a:	0307879b          	addiw	a5,a5,48
  7e:	fef68fa3          	sb	a5,-1(a3)
    while (n > 0)
  82:	f56d                	bnez	a0,6c <_Z9print_inti+0x18>
    }
    if (neg)
  84:	02081e63          	bnez	a6,c0 <_Z9print_inti+0x6c>
  88:	fff7079b          	addiw	a5,a4,-1
  8c:	ffe40493          	addi	s1,s0,-2
  90:	1782                	slli	a5,a5,0x20
  92:	fff70693          	addi	a3,a4,-1
  96:	94ba                	add	s1,s1,a4
  98:	9381                	srli	a5,a5,0x20
  9a:	9436                	add	s0,s0,a3
  9c:	8c9d                	sub	s1,s1,a5
        buf[i++] = '-';
    while (i > 0)
        write(1, &buf[--i], 1);
  9e:	85a2                	mv	a1,s0
  a0:	4605                	li	a2,1
  a2:	4505                	li	a0,1
    while (i > 0)
  a4:	147d                	addi	s0,s0,-1
        write(1, &buf[--i], 1);
  a6:	5ca000ef          	jal	670 <write>
    while (i > 0)
  aa:	fe849ae3          	bne	s1,s0,9e <_Z9print_inti+0x4a>
}
  ae:	70a2                	ld	ra,40(sp)
  b0:	7402                	ld	s0,32(sp)
  b2:	64e2                	ld	s1,24(sp)
  b4:	6145                	addi	sp,sp,48
  b6:	8082                	ret
        n = -n;
  b8:	40a0053b          	negw	a0,a0
        neg = 1;
  bc:	4805                	li	a6,1
  be:	b75d                	j	64 <_Z9print_inti+0x10>
        buf[i++] = '-';
  c0:	01070793          	addi	a5,a4,16
  c4:	00278733          	add	a4,a5,sp
  c8:	02d00793          	li	a5,45
  cc:	fef70823          	sb	a5,-16(a4)
  d0:	0025871b          	addiw	a4,a1,2
  d4:	bf55                	j	88 <_Z9print_inti+0x34>
        write(1, "0", 1);
  d6:	4605                	li	a2,1
  d8:	00000597          	auipc	a1,0x0
  dc:	62858593          	addi	a1,a1,1576 # 700 <disk_test+0x8>
  e0:	4505                	li	a0,1
  e2:	a379                	j	670 <write>

00000000000000e4 <_Z9print_hexy>:

void print_hex(uint64 n)
{
    char buf[16];
    char digits[] = "0123456789ABCDEF";
  e4:	00000797          	auipc	a5,0x0
  e8:	62c78793          	addi	a5,a5,1580 # 710 <disk_test+0x18>
  ec:	6394                	ld	a3,0(a5)
  ee:	6798                	ld	a4,8(a5)
  f0:	0107c783          	lbu	a5,16(a5)
{
  f4:	715d                	addi	sp,sp,-80
  f6:	fc26                	sd	s1,56(sp)
    write(1, "0x", 2);
  f8:	4609                	li	a2,2
{
  fa:	84aa                	mv	s1,a0
    write(1, "0x", 2);
  fc:	00000597          	auipc	a1,0x0
 100:	60c58593          	addi	a1,a1,1548 # 708 <disk_test+0x10>
 104:	4505                	li	a0,1
{
 106:	e486                	sd	ra,72(sp)
    char digits[] = "0123456789ABCDEF";
 108:	ec36                	sd	a3,24(sp)
 10a:	f03a                	sd	a4,32(sp)
 10c:	02f10423          	sb	a5,40(sp)
    write(1, "0x", 2);
 110:	560000ef          	jal	670 <write>
    if (n == 0)
 114:	cca1                	beqz	s1,16c <_Z9print_hexy+0x88>
 116:	e0a2                	sd	s0,64(sp)
 118:	0020                	addi	s0,sp,8
 11a:	87a2                	mv	a5,s0
        return;
    }
    int i = 0;
    while (n > 0)
    {
        buf[i++] = digits[n % 16];
 11c:	00f4f713          	andi	a4,s1,15
 120:	03070713          	addi	a4,a4,48
 124:	970a                	add	a4,a4,sp
 126:	fe874683          	lbu	a3,-24(a4)
        n /= 16;
 12a:	8091                	srli	s1,s1,0x4
 12c:	873e                	mv	a4,a5
        buf[i++] = digits[n % 16];
 12e:	00d78023          	sb	a3,0(a5)
    while (n > 0)
 132:	0785                	addi	a5,a5,1
 134:	f4e5                	bnez	s1,11c <_Z9print_hexy+0x38>
 136:	9f01                	subw	a4,a4,s0
 138:	0017079b          	addiw	a5,a4,1
 13c:	fff7871b          	addiw	a4,a5,-1
 140:	ffe40493          	addi	s1,s0,-2
 144:	1702                	slli	a4,a4,0x20
 146:	fff78693          	addi	a3,a5,-1
 14a:	94be                	add	s1,s1,a5
 14c:	9301                	srli	a4,a4,0x20
 14e:	9436                	add	s0,s0,a3
 150:	8c99                	sub	s1,s1,a4
    }
    while (i > 0)
        write(1, &buf[--i], 1);
 152:	85a2                	mv	a1,s0
 154:	4605                	li	a2,1
 156:	4505                	li	a0,1
    while (i > 0)
 158:	147d                	addi	s0,s0,-1
        write(1, &buf[--i], 1);
 15a:	516000ef          	jal	670 <write>
    while (i > 0)
 15e:	fe941ae3          	bne	s0,s1,152 <_Z9print_hexy+0x6e>
 162:	6406                	ld	s0,64(sp)
}
 164:	60a6                	ld	ra,72(sp)
 166:	74e2                	ld	s1,56(sp)
 168:	6161                	addi	sp,sp,80
 16a:	8082                	ret
 16c:	60a6                	ld	ra,72(sp)
 16e:	74e2                	ld	s1,56(sp)
        write(1, "0", 1);
 170:	4605                	li	a2,1
 172:	00000597          	auipc	a1,0x0
 176:	58e58593          	addi	a1,a1,1422 # 700 <disk_test+0x8>
 17a:	4505                	li	a0,1
}
 17c:	6161                	addi	sp,sp,80
        write(1, "0", 1);
 17e:	a9cd                	j	670 <write>

0000000000000180 <_Z13test_syscallsv>:
// =============================================================
// 系统调用测试套件
// =============================================================

void test_syscalls()
{
 180:	1101                	addi	sp,sp,-32
 182:	00000697          	auipc	a3,0x0
 186:	5a668693          	addi	a3,a3,1446 # 728 <disk_test+0x30>
 18a:	ec06                	sd	ra,24(sp)
 18c:	e822                	sd	s0,16(sp)
 18e:	e426                	sd	s1,8(sp)
 190:	87b6                	mv	a5,a3
    while (s[n])
 192:	0017c703          	lbu	a4,1(a5)
 196:	863e                	mv	a2,a5
 198:	0785                	addi	a5,a5,1
 19a:	ff65                	bnez	a4,192 <_Z13test_syscallsv+0x12>
        n++;
 19c:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 19e:	2605                	addiw	a2,a2,1
 1a0:	00000597          	auipc	a1,0x0
 1a4:	58858593          	addi	a1,a1,1416 # 728 <disk_test+0x30>
 1a8:	4505                	li	a0,1
 1aa:	4c6000ef          	jal	670 <write>
    while (s[n])
 1ae:	00000697          	auipc	a3,0x0
 1b2:	5aa68693          	addi	a3,a3,1450 # 758 <disk_test+0x60>
    write(1, s, strlen(s));
 1b6:	87b6                	mv	a5,a3
    while (s[n])
 1b8:	0017c703          	lbu	a4,1(a5)
 1bc:	863e                	mv	a2,a5
 1be:	0785                	addi	a5,a5,1
 1c0:	ff65                	bnez	a4,1b8 <_Z13test_syscallsv+0x38>
        n++;
 1c2:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 1c4:	2605                	addiw	a2,a2,1
 1c6:	00000597          	auipc	a1,0x0
 1ca:	59258593          	addi	a1,a1,1426 # 758 <disk_test+0x60>
 1ce:	4505                	li	a0,1
 1d0:	4a0000ef          	jal	670 <write>
    print("\n=== [Test] Starting System Call Check ===\n");

    // 1. 测试 getpid
    print("[1/4] Checking getpid()... ");
    int my_pid = getpid();
 1d4:	4fc000ef          	jal	6d0 <getpid>
 1d8:	842a                	mv	s0,a0
    if (my_pid > 0)
 1da:	2aa05463          	blez	a0,482 <_Z13test_syscallsv+0x302>
 1de:	00000697          	auipc	a3,0x0
 1e2:	59a68693          	addi	a3,a3,1434 # 778 <disk_test+0x80>
 1e6:	87b6                	mv	a5,a3
    while (s[n])
 1e8:	0017c703          	lbu	a4,1(a5)
 1ec:	863e                	mv	a2,a5
 1ee:	0785                	addi	a5,a5,1
 1f0:	ff65                	bnez	a4,1e8 <_Z13test_syscallsv+0x68>
        n++;
 1f2:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 1f4:	2605                	addiw	a2,a2,1
 1f6:	00000597          	auipc	a1,0x0
 1fa:	58258593          	addi	a1,a1,1410 # 778 <disk_test+0x80>
 1fe:	4505                	li	a0,1
 200:	470000ef          	jal	670 <write>
    {
        print("PASS (PID=");
        print_int(my_pid);
 204:	8522                	mv	a0,s0
 206:	e4fff0ef          	jal	54 <_Z9print_inti>
    while (s[n])
 20a:	00000697          	auipc	a3,0x0
 20e:	57e68693          	addi	a3,a3,1406 # 788 <disk_test+0x90>
        print_int(my_pid);
 212:	87b6                	mv	a5,a3
    while (s[n])
 214:	0017c703          	lbu	a4,1(a5)
 218:	863e                	mv	a2,a5
 21a:	0785                	addi	a5,a5,1
 21c:	ff65                	bnez	a4,214 <_Z13test_syscallsv+0x94>
        n++;
 21e:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 220:	2605                	addiw	a2,a2,1
 222:	00000597          	auipc	a1,0x0
 226:	56658593          	addi	a1,a1,1382 # 788 <disk_test+0x90>
 22a:	4505                	li	a0,1
 22c:	444000ef          	jal	670 <write>
    while (s[n])
 230:	00000697          	auipc	a3,0x0
 234:	57868693          	addi	a3,a3,1400 # 7a8 <disk_test+0xb0>
    if (my_pid > 0)
 238:	87b6                	mv	a5,a3
    while (s[n])
 23a:	0017c703          	lbu	a4,1(a5)
 23e:	863e                	mv	a2,a5
 240:	0785                	addi	a5,a5,1
 242:	ff65                	bnez	a4,23a <_Z13test_syscallsv+0xba>
        n++;
 244:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 246:	2605                	addiw	a2,a2,1
 248:	00000597          	auipc	a1,0x0
 24c:	56058593          	addi	a1,a1,1376 # 7a8 <disk_test+0xb0>
 250:	4505                	li	a0,1
 252:	41e000ef          	jal	670 <write>
        print("FAIL (Invalid PID)\n");
    }

    // 2. 测试 sbrk (内存分配)
    print("[2/4] Checking sbrk() heap allocation... ");
    char *p = sbrk(4096); // 分配 4KB
 256:	6505                	lui	a0,0x1
 258:	480000ef          	jal	6d8 <sbrk>
    if (p == (char *)-1)
 25c:	57fd                	li	a5,-1
    char *p = sbrk(4096); // 分配 4KB
 25e:	84aa                	mv	s1,a0
    if (p == (char *)-1)
 260:	24f50563          	beq	a0,a5,4aa <_Z13test_syscallsv+0x32a>
        print("FAIL (sbrk returned error)\n");
    }
    else
    {
        // 写入测试，确保映射了物理页
        p[0] = 'A';
 264:	04100793          	li	a5,65
 268:	00f50023          	sb	a5,0(a0) # 1000 <disk_test+0x908>
        p[4095] = 'Z';
 26c:	6785                	lui	a5,0x1
 26e:	97aa                	add	a5,a5,a0
 270:	00000697          	auipc	a3,0x0
 274:	58868693          	addi	a3,a3,1416 # 7f8 <disk_test+0x100>
 278:	05a00713          	li	a4,90
 27c:	fee78fa3          	sb	a4,-1(a5) # fff <disk_test+0x907>
 280:	87b6                	mv	a5,a3
    while (s[n])
 282:	0017c703          	lbu	a4,1(a5)
 286:	863e                	mv	a2,a5
 288:	0785                	addi	a5,a5,1
 28a:	ff65                	bnez	a4,282 <_Z13test_syscallsv+0x102>
        n++;
 28c:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 28e:	2605                	addiw	a2,a2,1
 290:	00000597          	auipc	a1,0x0
 294:	56858593          	addi	a1,a1,1384 # 7f8 <disk_test+0x100>
 298:	4505                	li	a0,1
 29a:	3d6000ef          	jal	670 <write>
        if (p[0] == 'A' && p[4095] == 'Z')
        {
            print("PASS (Allocated at ");
            print_hex((uint64)p);
 29e:	8526                	mv	a0,s1
 2a0:	e45ff0ef          	jal	e4 <_Z9print_hexy>
    while (s[n])
 2a4:	00000697          	auipc	a3,0x0
 2a8:	4e468693          	addi	a3,a3,1252 # 788 <disk_test+0x90>
            print_hex((uint64)p);
 2ac:	87b6                	mv	a5,a3
    while (s[n])
 2ae:	0017c703          	lbu	a4,1(a5)
 2b2:	863e                	mv	a2,a5
 2b4:	0785                	addi	a5,a5,1
 2b6:	ff65                	bnez	a4,2ae <_Z13test_syscallsv+0x12e>
        n++;
 2b8:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 2ba:	2605                	addiw	a2,a2,1
 2bc:	00000597          	auipc	a1,0x0
 2c0:	4cc58593          	addi	a1,a1,1228 # 788 <disk_test+0x90>
 2c4:	4505                	li	a0,1
 2c6:	3aa000ef          	jal	670 <write>
    while (s[n])
 2ca:	00000697          	auipc	a3,0x0
 2ce:	54668693          	addi	a3,a3,1350 # 810 <disk_test+0x118>
            print_hex((uint64)p);
 2d2:	87b6                	mv	a5,a3
    while (s[n])
 2d4:	0017c703          	lbu	a4,1(a5)
 2d8:	863e                	mv	a2,a5
 2da:	0785                	addi	a5,a5,1
 2dc:	ff65                	bnez	a4,2d4 <_Z13test_syscallsv+0x154>
        n++;
 2de:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 2e0:	2605                	addiw	a2,a2,1
 2e2:	00000597          	auipc	a1,0x0
 2e6:	52e58593          	addi	a1,a1,1326 # 810 <disk_test+0x118>
 2ea:	4505                	li	a0,1
 2ec:	384000ef          	jal	670 <write>
        }
    }

    // 3. 测试 fork 和 wait
    print("[3/4] Checking fork() and wait()...\n");
    int pid = fork();
 2f0:	358000ef          	jal	648 <fork>
 2f4:	84aa                	mv	s1,a0

    if (pid < 0)
 2f6:	1c054e63          	bltz	a0,4d2 <_Z13test_syscallsv+0x352>
    {
        print("      FAIL: fork error\n");
    }
    else if (pid == 0)
 2fa:	e179                	bnez	a0,3c0 <_Z13test_syscallsv+0x240>
    {
        // --- 子进程 ---
        int child_pid = getpid();
 2fc:	3d4000ef          	jal	6d0 <getpid>
 300:	84aa                	mv	s1,a0
        if (child_pid == my_pid)
 302:	24a40563          	beq	s0,a0,54c <_Z13test_syscallsv+0x3cc>
    while (s[n])
 306:	00000697          	auipc	a3,0x0
 30a:	57a68693          	addi	a3,a3,1402 # 880 <disk_test+0x188>
        if (child_pid == my_pid)
 30e:	87b6                	mv	a5,a3
    while (s[n])
 310:	0017c703          	lbu	a4,1(a5)
 314:	863e                	mv	a2,a5
 316:	0785                	addi	a5,a5,1
 318:	ff65                	bnez	a4,310 <_Z13test_syscallsv+0x190>
        n++;
 31a:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 31c:	2605                	addiw	a2,a2,1
 31e:	00000597          	auipc	a1,0x0
 322:	56258593          	addi	a1,a1,1378 # 880 <disk_test+0x188>
 326:	4505                	li	a0,1
 328:	348000ef          	jal	670 <write>
        {
            print("      FAIL: Child has same PID as parent\n");
            exit(1);
        }
        print("      [Child] I am alive. PID=");
        print_int(child_pid);
 32c:	8526                	mv	a0,s1
 32e:	d27ff0ef          	jal	54 <_Z9print_inti>
    write(1, s, strlen(s));
 332:	4605                	li	a2,1
 334:	00000597          	auipc	a1,0x0
 338:	56c58593          	addi	a1,a1,1388 # 8a0 <disk_test+0x1a8>
 33c:	4505                	li	a0,1
 33e:	332000ef          	jal	670 <write>
    while (s[n])
 342:	00000697          	auipc	a3,0x0
 346:	56668693          	addi	a3,a3,1382 # 8a8 <disk_test+0x1b0>
    write(1, s, strlen(s));
 34a:	87b6                	mv	a5,a3
    while (s[n])
 34c:	0017c703          	lbu	a4,1(a5)
 350:	863e                	mv	a2,a5
 352:	0785                	addi	a5,a5,1
 354:	ff65                	bnez	a4,34c <_Z13test_syscallsv+0x1cc>
        n++;
 356:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 358:	2605                	addiw	a2,a2,1
 35a:	00000597          	auipc	a1,0x0
 35e:	54e58593          	addi	a1,a1,1358 # 8a8 <disk_test+0x1b0>
 362:	4505                	li	a0,1
 364:	30c000ef          	jal	670 <write>
        print("\n");
        print("      [Child] Exiting now.\n");
        exit(0);
 368:	4501                	li	a0,0
 36a:	2e6000ef          	jal	650 <exit>
    while (s[n])
 36e:	00000697          	auipc	a3,0x0
 372:	60a68693          	addi	a3,a3,1546 # 978 <disk_test+0x280>
            print("PASS (Fork/Wait cycle)\n");
        }
        else
        {
            print("FAIL (Wait returned ");
            print_int(waited_pid);
 376:	87b6                	mv	a5,a3
    while (s[n])
 378:	0017c703          	lbu	a4,1(a5)
 37c:	863e                	mv	a2,a5
 37e:	0785                	addi	a5,a5,1
 380:	ff65                	bnez	a4,378 <_Z13test_syscallsv+0x1f8>
        n++;
 382:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 384:	2605                	addiw	a2,a2,1
 386:	00000597          	auipc	a1,0x0
 38a:	5f258593          	addi	a1,a1,1522 # 978 <disk_test+0x280>
 38e:	4505                	li	a0,1
 390:	2e0000ef          	jal	670 <write>
    while (s[n])
 394:	00000697          	auipc	a3,0x0
 398:	61468693          	addi	a3,a3,1556 # 9a8 <disk_test+0x2b0>
    write(1, s, strlen(s));
 39c:	87b6                	mv	a5,a3
    while (s[n])
 39e:	0017c703          	lbu	a4,1(a5)
 3a2:	863e                	mv	a2,a5
 3a4:	0785                	addi	a5,a5,1
 3a6:	ff65                	bnez	a4,39e <_Z13test_syscallsv+0x21e>

    // 4. 测试 write (如果是能看到这些输出，说明 write 已经正常了)
    print("[4/4] Checking write()... PASS (Self-evident)\n");

    print("=== [Test] All Tests Finished ===\n");
}
 3a8:	6442                	ld	s0,16(sp)
 3aa:	60e2                	ld	ra,24(sp)
 3ac:	64a2                	ld	s1,8(sp)
        n++;
 3ae:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 3b0:	2605                	addiw	a2,a2,1
 3b2:	00000597          	auipc	a1,0x0
 3b6:	5f658593          	addi	a1,a1,1526 # 9a8 <disk_test+0x2b0>
 3ba:	4505                	li	a0,1
}
 3bc:	6105                	addi	sp,sp,32
    write(1, s, strlen(s));
 3be:	ac4d                	j	670 <write>
 3c0:	00000697          	auipc	a3,0x0
 3c4:	50868693          	addi	a3,a3,1288 # 8c8 <disk_test+0x1d0>
    else if (pid == 0)
 3c8:	87b6                	mv	a5,a3
    while (s[n])
 3ca:	0017c703          	lbu	a4,1(a5)
 3ce:	863e                	mv	a2,a5
 3d0:	0785                	addi	a5,a5,1
 3d2:	ff65                	bnez	a4,3ca <_Z13test_syscallsv+0x24a>
        n++;
 3d4:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 3d6:	2605                	addiw	a2,a2,1
 3d8:	00000597          	auipc	a1,0x0
 3dc:	4f058593          	addi	a1,a1,1264 # 8c8 <disk_test+0x1d0>
 3e0:	4505                	li	a0,1
 3e2:	28e000ef          	jal	670 <write>
        print_int(pid);
 3e6:	8526                	mv	a0,s1
 3e8:	c6dff0ef          	jal	54 <_Z9print_inti>
    write(1, s, strlen(s));
 3ec:	4605                	li	a2,1
 3ee:	00000597          	auipc	a1,0x0
 3f2:	4b258593          	addi	a1,a1,1202 # 8a0 <disk_test+0x1a8>
 3f6:	4505                	li	a0,1
 3f8:	278000ef          	jal	670 <write>
    while (s[n])
 3fc:	00000697          	auipc	a3,0x0
 400:	4f468693          	addi	a3,a3,1268 # 8f0 <disk_test+0x1f8>
    write(1, s, strlen(s));
 404:	87b6                	mv	a5,a3
    while (s[n])
 406:	0017c703          	lbu	a4,1(a5)
 40a:	863e                	mv	a2,a5
 40c:	0785                	addi	a5,a5,1
 40e:	ff65                	bnez	a4,406 <_Z13test_syscallsv+0x286>
        n++;
 410:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 412:	2605                	addiw	a2,a2,1
 414:	00000597          	auipc	a1,0x0
 418:	4dc58593          	addi	a1,a1,1244 # 8f0 <disk_test+0x1f8>
 41c:	4505                	li	a0,1
 41e:	252000ef          	jal	670 <write>
        int waited_pid = wait(0);
 422:	4501                	li	a0,0
 424:	234000ef          	jal	658 <wait>
 428:	00000697          	auipc	a3,0x0
 42c:	53868693          	addi	a3,a3,1336 # 960 <disk_test+0x268>
 430:	842a                	mv	s0,a0
        if (waited_pid == pid)
 432:	87b6                	mv	a5,a3
 434:	0ca48363          	beq	s1,a0,4fa <_Z13test_syscallsv+0x37a>
    while (s[n])
 438:	0017c703          	lbu	a4,1(a5)
 43c:	863e                	mv	a2,a5
 43e:	0785                	addi	a5,a5,1
 440:	ff65                	bnez	a4,438 <_Z13test_syscallsv+0x2b8>
        n++;
 442:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 444:	2605                	addiw	a2,a2,1
 446:	00000597          	auipc	a1,0x0
 44a:	51a58593          	addi	a1,a1,1306 # 960 <disk_test+0x268>
 44e:	4505                	li	a0,1
 450:	220000ef          	jal	670 <write>
            print_int(waited_pid);
 454:	8522                	mv	a0,s0
 456:	bffff0ef          	jal	54 <_Z9print_inti>
    while (s[n])
 45a:	00000697          	auipc	a3,0x0
 45e:	32e68693          	addi	a3,a3,814 # 788 <disk_test+0x90>
            print_int(waited_pid);
 462:	87b6                	mv	a5,a3
    while (s[n])
 464:	0017c703          	lbu	a4,1(a5)
 468:	863e                	mv	a2,a5
 46a:	0785                	addi	a5,a5,1
 46c:	ff65                	bnez	a4,464 <_Z13test_syscallsv+0x2e4>
        n++;
 46e:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 470:	2605                	addiw	a2,a2,1
 472:	00000597          	auipc	a1,0x0
 476:	31658593          	addi	a1,a1,790 # 788 <disk_test+0x90>
 47a:	4505                	li	a0,1
 47c:	1f4000ef          	jal	670 <write>
}
 480:	b5fd                	j	36e <_Z13test_syscallsv+0x1ee>
 482:	00000697          	auipc	a3,0x0
 486:	30e68693          	addi	a3,a3,782 # 790 <disk_test+0x98>
    if (my_pid > 0)
 48a:	87b6                	mv	a5,a3
    while (s[n])
 48c:	0017c703          	lbu	a4,1(a5)
 490:	863e                	mv	a2,a5
 492:	0785                	addi	a5,a5,1
 494:	ff65                	bnez	a4,48c <_Z13test_syscallsv+0x30c>
        n++;
 496:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 498:	2605                	addiw	a2,a2,1
 49a:	00000597          	auipc	a1,0x0
 49e:	2f658593          	addi	a1,a1,758 # 790 <disk_test+0x98>
 4a2:	4505                	li	a0,1
 4a4:	1cc000ef          	jal	670 <write>
}
 4a8:	b361                	j	230 <_Z13test_syscallsv+0xb0>
 4aa:	00000697          	auipc	a3,0x0
 4ae:	32e68693          	addi	a3,a3,814 # 7d8 <disk_test+0xe0>
    if (p == (char *)-1)
 4b2:	87b6                	mv	a5,a3
    while (s[n])
 4b4:	0017c703          	lbu	a4,1(a5)
 4b8:	863e                	mv	a2,a5
 4ba:	0785                	addi	a5,a5,1
 4bc:	ff65                	bnez	a4,4b4 <_Z13test_syscallsv+0x334>
        n++;
 4be:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 4c0:	2605                	addiw	a2,a2,1
 4c2:	00000597          	auipc	a1,0x0
 4c6:	31658593          	addi	a1,a1,790 # 7d8 <disk_test+0xe0>
 4ca:	4505                	li	a0,1
 4cc:	1a4000ef          	jal	670 <write>
}
 4d0:	bbed                	j	2ca <_Z13test_syscallsv+0x14a>
 4d2:	00000697          	auipc	a3,0x0
 4d6:	36668693          	addi	a3,a3,870 # 838 <disk_test+0x140>
    if (pid < 0)
 4da:	87b6                	mv	a5,a3
    while (s[n])
 4dc:	0017c703          	lbu	a4,1(a5)
 4e0:	863e                	mv	a2,a5
 4e2:	0785                	addi	a5,a5,1
 4e4:	ff65                	bnez	a4,4dc <_Z13test_syscallsv+0x35c>
        n++;
 4e6:	9e15                	subw	a2,a2,a3
    write(1, s, strlen(s));
 4e8:	2605                	addiw	a2,a2,1
 4ea:	00000597          	auipc	a1,0x0
 4ee:	34e58593          	addi	a1,a1,846 # 838 <disk_test+0x140>
 4f2:	4505                	li	a0,1
 4f4:	17c000ef          	jal	670 <write>
}
 4f8:	bd9d                	j	36e <_Z13test_syscallsv+0x1ee>
 4fa:	00000617          	auipc	a2,0x0
 4fe:	41e60613          	addi	a2,a2,1054 # 918 <disk_test+0x220>
        if (waited_pid == pid)
 502:	87b2                	mv	a5,a2
    while (s[n])
 504:	0017c703          	lbu	a4,1(a5)
 508:	86be                	mv	a3,a5
 50a:	0785                	addi	a5,a5,1
 50c:	ff65                	bnez	a4,504 <_Z13test_syscallsv+0x384>
        n++;
 50e:	40c6863b          	subw	a2,a3,a2
    write(1, s, strlen(s));
 512:	2605                	addiw	a2,a2,1
 514:	00000597          	auipc	a1,0x0
 518:	40458593          	addi	a1,a1,1028 # 918 <disk_test+0x220>
 51c:	4505                	li	a0,1
 51e:	152000ef          	jal	670 <write>
    while (s[n])
 522:	00000617          	auipc	a2,0x0
 526:	42660613          	addi	a2,a2,1062 # 948 <disk_test+0x250>
    write(1, s, strlen(s));
 52a:	87b2                	mv	a5,a2
    while (s[n])
 52c:	0017c703          	lbu	a4,1(a5)
 530:	86be                	mv	a3,a5
 532:	0785                	addi	a5,a5,1
 534:	ff65                	bnez	a4,52c <_Z13test_syscallsv+0x3ac>
        n++;
 536:	40c6863b          	subw	a2,a3,a2
    write(1, s, strlen(s));
 53a:	2605                	addiw	a2,a2,1
 53c:	00000597          	auipc	a1,0x0
 540:	40c58593          	addi	a1,a1,1036 # 948 <disk_test+0x250>
 544:	4505                	li	a0,1
 546:	12a000ef          	jal	670 <write>
}
 54a:	b515                	j	36e <_Z13test_syscallsv+0x1ee>
 54c:	00000617          	auipc	a2,0x0
 550:	30460613          	addi	a2,a2,772 # 850 <disk_test+0x158>
        if (child_pid == my_pid)
 554:	87b2                	mv	a5,a2
    while (s[n])
 556:	0017c703          	lbu	a4,1(a5)
 55a:	86be                	mv	a3,a5
 55c:	0785                	addi	a5,a5,1
 55e:	ff65                	bnez	a4,556 <_Z13test_syscallsv+0x3d6>
        n++;
 560:	40c6863b          	subw	a2,a3,a2
    write(1, s, strlen(s));
 564:	2605                	addiw	a2,a2,1
 566:	00000597          	auipc	a1,0x0
 56a:	2ea58593          	addi	a1,a1,746 # 850 <disk_test+0x158>
 56e:	4505                	li	a0,1
 570:	100000ef          	jal	670 <write>
            exit(1);
 574:	4505                	li	a0,1
 576:	0da000ef          	jal	650 <exit>
 57a:	b371                	j	306 <_Z13test_syscallsv+0x186>

000000000000057c <main>:
// =============================================================
// Shell 主循环
// =============================================================

int main()
{
 57c:	715d                	addi	sp,sp,-80
    print("\n[Lume Shell] Ready.\n");
 57e:	00000517          	auipc	a0,0x0
 582:	45250513          	addi	a0,a0,1106 # 9d0 <disk_test+0x2d8>
{
 586:	e486                	sd	ra,72(sp)
 588:	e0a2                	sd	s0,64(sp)
 58a:	fc26                	sd	s1,56(sp)
 58c:	f84a                	sd	s2,48(sp)
 58e:	f44e                	sd	s3,40(sp)
 590:	f052                	sd	s4,32(sp)
 592:	ec56                	sd	s5,24(sp)
 594:	e85a                	sd	s6,16(sp)
    print("\n[Lume Shell] Ready.\n");
 596:	a99ff0ef          	jal	2e <_Z5printPKc>
    print("Commands:\n");
 59a:	00000517          	auipc	a0,0x0
 59e:	44e50513          	addi	a0,a0,1102 # 9e8 <disk_test+0x2f0>
 5a2:	a8dff0ef          	jal	2e <_Z5printPKc>
    print("  s: Run System Call Tests (fork, wait, mm)\n");
 5a6:	00000517          	auipc	a0,0x0
 5aa:	45250513          	addi	a0,a0,1106 # 9f8 <disk_test+0x300>
 5ae:	a81ff0ef          	jal	2e <_Z5printPKc>
    print("  t: Run Disk Driver Test (VirtIO)\n");
 5b2:	00000517          	auipc	a0,0x0
 5b6:	47650513          	addi	a0,a0,1142 # a28 <disk_test+0x330>
 5ba:	00000b17          	auipc	s6,0x0
 5be:	49eb0b13          	addi	s6,s6,1182 # a58 <disk_test+0x360>
        n++;
 5c2:	4a85                	li	s5,1
    print("  t: Run Disk Driver Test (VirtIO)\n");
 5c4:	a6bff0ef          	jal	2e <_Z5printPKc>
 5c8:	848a                	mv	s1,sp

    while (1)
    {
        char buf[16];
        write(1, "$ ", 2);
 5ca:	00000417          	auipc	s0,0x0
 5ce:	48640413          	addi	s0,s0,1158 # a50 <disk_test+0x358>

        int n = read(0, buf, sizeof(buf));
        if (n <= 0)
            continue;

        if (buf[0] == 's')
 5d2:	07300913          	li	s2,115
        {
            test_syscalls();
        }
        else if (buf[0] == 't')
 5d6:	07400993          	li	s3,116
                disk_test();
                exit(0);
            }
            wait(0);
        }
        else if (buf[0] != '\n')
 5da:	4a29                	li	s4,10
        n++;
 5dc:	416a8abb          	subw	s5,s5,s6
        write(1, "$ ", 2);
 5e0:	4609                	li	a2,2
 5e2:	85a2                	mv	a1,s0
 5e4:	4505                	li	a0,1
 5e6:	08a000ef          	jal	670 <write>
        int n = read(0, buf, sizeof(buf));
 5ea:	4641                	li	a2,16
 5ec:	85a6                	mv	a1,s1
 5ee:	4501                	li	a0,0
 5f0:	078000ef          	jal	668 <read>
        if (n <= 0)
 5f4:	fea056e3          	blez	a0,5e0 <main+0x64>
        if (buf[0] == 's')
 5f8:	00014783          	lbu	a5,0(sp)
 5fc:	03278663          	beq	a5,s2,628 <main+0xac>
        else if (buf[0] == 't')
 600:	03378763          	beq	a5,s3,62e <main+0xb2>
        else if (buf[0] != '\n')
 604:	fd478ee3          	beq	a5,s4,5e0 <main+0x64>
 608:	00000797          	auipc	a5,0x0
 60c:	45078793          	addi	a5,a5,1104 # a58 <disk_test+0x360>
    while (s[n])
 610:	0017c703          	lbu	a4,1(a5)
 614:	863e                	mv	a2,a5
 616:	0785                	addi	a5,a5,1
 618:	ff65                	bnez	a4,610 <main+0x94>
    write(1, s, strlen(s));
 61a:	00ca863b          	addw	a2,s5,a2
 61e:	85da                	mv	a1,s6
 620:	4505                	li	a0,1
 622:	04e000ef          	jal	670 <write>
}
 626:	bf6d                	j	5e0 <main+0x64>
            test_syscalls();
 628:	b59ff0ef          	jal	180 <_Z13test_syscallsv>
 62c:	bf55                	j	5e0 <main+0x64>
            if (fork() == 0)
 62e:	01a000ef          	jal	648 <fork>
 632:	c509                	beqz	a0,63c <main+0xc0>
            wait(0);
 634:	4501                	li	a0,0
 636:	022000ef          	jal	658 <wait>
 63a:	b75d                	j	5e0 <main+0x64>
                disk_test();
 63c:	0bc000ef          	jal	6f8 <disk_test>
                exit(0);
 640:	4501                	li	a0,0
 642:	00e000ef          	jal	650 <exit>
 646:	b7fd                	j	634 <main+0xb8>

0000000000000648 <fork>:
    name: \
        li a7, SYS_ ## name; \
        ecall; \
        ret

SYSCALL(fork)
 648:	4889                	li	a7,2
 64a:	00000073          	ecall
 64e:	8082                	ret

0000000000000650 <exit>:
SYSCALL(exit)
 650:	488d                	li	a7,3
 652:	00000073          	ecall
 656:	8082                	ret

0000000000000658 <wait>:
SYSCALL(wait)
 658:	4891                	li	a7,4
 65a:	00000073          	ecall
 65e:	8082                	ret

0000000000000660 <pipe>:
SYSCALL(pipe)
 660:	4895                	li	a7,5
 662:	00000073          	ecall
 666:	8082                	ret

0000000000000668 <read>:
SYSCALL(read)
 668:	4899                	li	a7,6
 66a:	00000073          	ecall
 66e:	8082                	ret

0000000000000670 <write>:
SYSCALL(write)
 670:	48c5                	li	a7,17
 672:	00000073          	ecall
 676:	8082                	ret

0000000000000678 <close>:
SYSCALL(close)
 678:	48d9                	li	a7,22
 67a:	00000073          	ecall
 67e:	8082                	ret

0000000000000680 <kill>:
SYSCALL(kill)
 680:	489d                	li	a7,7
 682:	00000073          	ecall
 686:	8082                	ret

0000000000000688 <exec>:
SYSCALL(exec)
 688:	48a1                	li	a7,8
 68a:	00000073          	ecall
 68e:	8082                	ret

0000000000000690 <open>:
SYSCALL(open)
 690:	48c1                	li	a7,16
 692:	00000073          	ecall
 696:	8082                	ret

0000000000000698 <mknod>:
SYSCALL(mknod)
 698:	48c9                	li	a7,18
 69a:	00000073          	ecall
 69e:	8082                	ret

00000000000006a0 <unlink>:
SYSCALL(unlink)
 6a0:	48cd                	li	a7,19
 6a2:	00000073          	ecall
 6a6:	8082                	ret

00000000000006a8 <fstat>:
SYSCALL(fstat)
 6a8:	48a5                	li	a7,9
 6aa:	00000073          	ecall
 6ae:	8082                	ret

00000000000006b0 <link>:
SYSCALL(link)
 6b0:	48d1                	li	a7,20
 6b2:	00000073          	ecall
 6b6:	8082                	ret

00000000000006b8 <mkdir>:
SYSCALL(mkdir)
 6b8:	48d5                	li	a7,21
 6ba:	00000073          	ecall
 6be:	8082                	ret

00000000000006c0 <chdir>:
SYSCALL(chdir)
 6c0:	48a9                	li	a7,10
 6c2:	00000073          	ecall
 6c6:	8082                	ret

00000000000006c8 <dup>:
SYSCALL(dup)
 6c8:	48ad                	li	a7,11
 6ca:	00000073          	ecall
 6ce:	8082                	ret

00000000000006d0 <getpid>:
SYSCALL(getpid)
 6d0:	48b1                	li	a7,12
 6d2:	00000073          	ecall
 6d6:	8082                	ret

00000000000006d8 <sbrk>:
SYSCALL(sbrk)
 6d8:	48b5                	li	a7,13
 6da:	00000073          	ecall
 6de:	8082                	ret

00000000000006e0 <sleep>:
SYSCALL(sleep)
 6e0:	48b9                	li	a7,14
 6e2:	00000073          	ecall
 6e6:	8082                	ret

00000000000006e8 <uptime>:
SYSCALL(uptime)
 6e8:	48bd                	li	a7,15
 6ea:	00000073          	ecall
 6ee:	8082                	ret

00000000000006f0 <putc>:
SYSCALL(putc)
 6f0:	4885                	li	a7,1
 6f2:	00000073          	ecall
 6f6:	8082                	ret

00000000000006f8 <disk_test>:
 6f8:	48dd                	li	a7,23
 6fa:	00000073          	ecall
 6fe:	8082                	ret
