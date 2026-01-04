
build/user/sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <_Z5panicPKc>:
constexpr int MAX_ARGS = 10;
const char *WHITESPACE = " \t\r\n\v";
const char *SYMBOLS = "<|>&;()";

void panic(const char *s)
{
       0:	1141                	addi	sp,sp,-16
       2:	85aa                	mv	a1,a0
    printf("shell panic: %s\n", s);
       4:	00006517          	auipc	a0,0x6
       8:	04450513          	addi	a0,a0,68 # 6048 <_GLOBAL__sub_I__ZSt3cin+0x58>
{
       c:	e406                	sd	ra,8(sp)
    printf("shell panic: %s\n", s);
       e:	0ed040ef          	jal	48fa <printf>
    exit(1);
}
      12:	60a2                	ld	ra,8(sp)
    exit(1);
      14:	4505                	li	a0,1
}
      16:	0141                	addi	sp,sp,16
    exit(1);
      18:	3f60506f          	j	540e <exit>

000000000000001c <_Z13fork_or_panicv>:

int fork_or_panic()
{
      1c:	1141                	addi	sp,sp,-16
      1e:	e022                	sd	s0,0(sp)
      20:	e406                	sd	ra,8(sp)
    int pid = fork();
      22:	0ae010ef          	jal	10d0 <fork>
    if (pid == -1)
      26:	57fd                	li	a5,-1
    int pid = fork();
      28:	842a                	mv	s0,a0
    if (pid == -1)
      2a:	00f50763          	beq	a0,a5,38 <_Z13fork_or_panicv+0x1c>
        panic("fork");
    return pid;
}
      2e:	60a2                	ld	ra,8(sp)
      30:	8522                	mv	a0,s0
      32:	6402                	ld	s0,0(sp)
      34:	0141                	addi	sp,sp,16
      36:	8082                	ret
    printf("shell panic: %s\n", s);
      38:	00006597          	auipc	a1,0x6
      3c:	00858593          	addi	a1,a1,8 # 6040 <_GLOBAL__sub_I__ZSt3cin+0x50>
      40:	00006517          	auipc	a0,0x6
      44:	00850513          	addi	a0,a0,8 # 6048 <_GLOBAL__sub_I__ZSt3cin+0x58>
      48:	0b3040ef          	jal	48fa <printf>
    exit(1);
      4c:	4505                	li	a0,1
      4e:	3c0050ef          	jal	540e <exit>
}
      52:	60a2                	ld	ra,8(sp)
      54:	8522                	mv	a0,s0
      56:	6402                	ld	s0,0(sp)
      58:	0141                	addi	sp,sp,16
      5a:	8082                	ret

000000000000005c <_Z6getcmdPci>:
        return cmd;
    }
};

int getcmd(char *buf, int nbuf)
{
      5c:	1101                	addi	sp,sp,-32
      5e:	e822                	sd	s0,16(sp)
      60:	e426                	sd	s1,8(sp)
      62:	842a                	mv	s0,a0
      64:	84ae                	mv	s1,a1
    write(1, "$ ", 2);
      66:	4609                	li	a2,2
      68:	00006597          	auipc	a1,0x6
      6c:	06058593          	addi	a1,a1,96 # 60c8 <_GLOBAL__sub_I__ZSt3cin+0xd8>
      70:	4505                	li	a0,1
{
      72:	ec06                	sd	ra,24(sp)
    write(1, "$ ", 2);
      74:	07c010ef          	jal	10f0 <write>
    memset(buf, 0, nbuf);
      78:	8626                	mv	a2,s1
      7a:	4581                	li	a1,0
      7c:	8522                	mv	a0,s0
      7e:	25b050ef          	jal	5ad8 <memset>

    int n = read(0, buf, nbuf - 1);
      82:	fff4861b          	addiw	a2,s1,-1
      86:	85a2                	mv	a1,s0
      88:	4501                	li	a0,0
      8a:	05e010ef          	jal	10e8 <read>

    if (n < 0)
      8e:	00054b63          	bltz	a0,a4 <_Z6getcmdPci+0x48>
        return -1;

    buf[n] = 0;
      92:	942a                	add	s0,s0,a0
      94:	00040023          	sb	zero,0(s0)
    return 0;
      98:	4501                	li	a0,0
}
      9a:	60e2                	ld	ra,24(sp)
      9c:	6442                	ld	s0,16(sp)
      9e:	64a2                	ld	s1,8(sp)
      a0:	6105                	addi	sp,sp,32
      a2:	8082                	ret
        return -1;
      a4:	557d                	li	a0,-1
      a6:	bfd5                	j	9a <_Z6getcmdPci+0x3e>

00000000000000a8 <_ZN12RedirCommandD1Ev>:
    ~RedirCommand() { delete sub_cmd; }
      a8:	87aa                	mv	a5,a0
      aa:	6508                	ld	a0,8(a0)
      ac:	00008717          	auipc	a4,0x8
      b0:	dcc70713          	addi	a4,a4,-564 # 7e78 <_ZTV12RedirCommand+0x10>
      b4:	e398                	sd	a4,0(a5)
      b6:	c501                	beqz	a0,be <_ZN12RedirCommandD1Ev+0x16>
      b8:	611c                	ld	a5,0(a0)
      ba:	679c                	ld	a5,8(a5)
      bc:	8782                	jr	a5
      be:	8082                	ret

00000000000000c0 <_ZN11PipeCommandD1Ev>:
    ~PipeCommand()
      c0:	1141                	addi	sp,sp,-16
      c2:	e022                	sd	s0,0(sp)
      c4:	842a                	mv	s0,a0
        delete left;
      c6:	6508                	ld	a0,8(a0)
    ~PipeCommand()
      c8:	e406                	sd	ra,8(sp)
    {
      ca:	00008797          	auipc	a5,0x8
      ce:	dd678793          	addi	a5,a5,-554 # 7ea0 <_ZTV11PipeCommand+0x10>
      d2:	e01c                	sd	a5,0(s0)
        delete left;
      d4:	c501                	beqz	a0,dc <_ZN11PipeCommandD1Ev+0x1c>
      d6:	611c                	ld	a5,0(a0)
      d8:	679c                	ld	a5,8(a5)
      da:	9782                	jalr	a5
        delete right;
      dc:	6808                	ld	a0,16(s0)
      de:	c519                	beqz	a0,ec <_ZN11PipeCommandD1Ev+0x2c>
      e0:	611c                	ld	a5,0(a0)
    }
      e2:	6402                	ld	s0,0(sp)
      e4:	60a2                	ld	ra,8(sp)
        delete right;
      e6:	679c                	ld	a5,8(a5)
    }
      e8:	0141                	addi	sp,sp,16
        delete right;
      ea:	8782                	jr	a5
    }
      ec:	60a2                	ld	ra,8(sp)
      ee:	6402                	ld	s0,0(sp)
      f0:	0141                	addi	sp,sp,16
      f2:	8082                	ret

00000000000000f4 <_ZN11ListCommandD1Ev>:
    ~ListCommand()
      f4:	1141                	addi	sp,sp,-16
      f6:	e022                	sd	s0,0(sp)
      f8:	842a                	mv	s0,a0
        delete left;
      fa:	6508                	ld	a0,8(a0)
    ~ListCommand()
      fc:	e406                	sd	ra,8(sp)
    {
      fe:	00008797          	auipc	a5,0x8
     102:	dca78793          	addi	a5,a5,-566 # 7ec8 <_ZTV11ListCommand+0x10>
     106:	e01c                	sd	a5,0(s0)
        delete left;
     108:	c501                	beqz	a0,110 <_ZN11ListCommandD1Ev+0x1c>
     10a:	611c                	ld	a5,0(a0)
     10c:	679c                	ld	a5,8(a5)
     10e:	9782                	jalr	a5
        delete right;
     110:	6808                	ld	a0,16(s0)
     112:	c519                	beqz	a0,120 <_ZN11ListCommandD1Ev+0x2c>
     114:	611c                	ld	a5,0(a0)
    }
     116:	6402                	ld	s0,0(sp)
     118:	60a2                	ld	ra,8(sp)
        delete right;
     11a:	679c                	ld	a5,8(a5)
    }
     11c:	0141                	addi	sp,sp,16
        delete right;
     11e:	8782                	jr	a5
    }
     120:	60a2                	ld	ra,8(sp)
     122:	6402                	ld	s0,0(sp)
     124:	0141                	addi	sp,sp,16
     126:	8082                	ret

0000000000000128 <_ZN11BackCommandD1Ev>:
    ~BackCommand() { delete sub_cmd; }
     128:	87aa                	mv	a5,a0
     12a:	6508                	ld	a0,8(a0)
     12c:	00008717          	auipc	a4,0x8
     130:	dc470713          	addi	a4,a4,-572 # 7ef0 <_ZTV11BackCommand+0x10>
     134:	e398                	sd	a4,0(a5)
     136:	c501                	beqz	a0,13e <_ZN11BackCommandD1Ev+0x16>
     138:	611c                	ld	a5,0(a0)
     13a:	679c                	ld	a5,8(a5)
     13c:	8782                	jr	a5
     13e:	8082                	ret

0000000000000140 <_ZN11ExecCommandD1Ev>:
struct ExecCommand : public Command
     140:	8082                	ret

0000000000000142 <_ZN12RedirCommand3runEv>:
    void run() override
     142:	1141                	addi	sp,sp,-16
     144:	e022                	sd	s0,0(sp)
     146:	842a                	mv	s0,a0
        close(fd);
     148:	5148                	lw	a0,36(a0)
    void run() override
     14a:	e406                	sd	ra,8(sp)
        close(fd);
     14c:	7ad000ef          	jal	10f8 <close>
        if (open(file, mode) < 0)
     150:	500c                	lw	a1,32(s0)
     152:	6808                	ld	a0,16(s0)
     154:	7bd000ef          	jal	1110 <open>
     158:	00054963          	bltz	a0,16a <_ZN12RedirCommand3runEv+0x28>
        sub_cmd->run();
     15c:	6408                	ld	a0,8(s0)
    }
     15e:	6402                	ld	s0,0(sp)
     160:	60a2                	ld	ra,8(sp)
        sub_cmd->run();
     162:	611c                	ld	a5,0(a0)
     164:	6b9c                	ld	a5,16(a5)
    }
     166:	0141                	addi	sp,sp,16
        sub_cmd->run();
     168:	8782                	jr	a5
            printf("open %s failed\n", file);
     16a:	680c                	ld	a1,16(s0)
     16c:	00006517          	auipc	a0,0x6
     170:	eb450513          	addi	a0,a0,-332 # 6020 <_GLOBAL__sub_I__ZSt3cin+0x30>
     174:	786040ef          	jal	48fa <printf>
            exit(1);
     178:	4505                	li	a0,1
     17a:	294050ef          	jal	540e <exit>
        sub_cmd->run();
     17e:	6408                	ld	a0,8(s0)
    }
     180:	6402                	ld	s0,0(sp)
     182:	60a2                	ld	ra,8(sp)
        sub_cmd->run();
     184:	611c                	ld	a5,0(a0)
     186:	6b9c                	ld	a5,16(a5)
    }
     188:	0141                	addi	sp,sp,16
        sub_cmd->run();
     18a:	8782                	jr	a5

000000000000018c <_ZN11ExecCommand3runEv>:
    void run() override
     18c:	1141                	addi	sp,sp,-16
     18e:	e022                	sd	s0,0(sp)
     190:	842a                	mv	s0,a0
        if (argv[0] == nullptr)
     192:	6508                	ld	a0,8(a0)
    void run() override
     194:	e406                	sd	ra,8(sp)
        if (argv[0] == nullptr)
     196:	c115                	beqz	a0,1ba <_ZN11ExecCommand3runEv+0x2e>
        exec(argv[0], argv);
     198:	00840593          	addi	a1,s0,8
     19c:	76d000ef          	jal	1108 <exec>
        printf("exec %s failed\n", argv[0]);
     1a0:	640c                	ld	a1,8(s0)
     1a2:	00006517          	auipc	a0,0x6
     1a6:	e8e50513          	addi	a0,a0,-370 # 6030 <_GLOBAL__sub_I__ZSt3cin+0x40>
     1aa:	750040ef          	jal	48fa <printf>
    }
     1ae:	6402                	ld	s0,0(sp)
     1b0:	60a2                	ld	ra,8(sp)
        exit(1);
     1b2:	4505                	li	a0,1
    }
     1b4:	0141                	addi	sp,sp,16
        exit(1);
     1b6:	2580506f          	j	540e <exit>
            exit(1);
     1ba:	4505                	li	a0,1
     1bc:	252050ef          	jal	540e <exit>
        exec(argv[0], argv);
     1c0:	6408                	ld	a0,8(s0)
     1c2:	bfd9                	j	198 <_ZN11ExecCommand3runEv+0xc>

00000000000001c4 <_ZN11ExecCommandD0Ev>:
struct ExecCommand : public Command
     1c4:	05800593          	li	a1,88
     1c8:	6210506f          	j	5fe8 <_ZdlPvm>

00000000000001cc <_ZN12RedirCommandD0Ev>:
    ~RedirCommand() { delete sub_cmd; }
     1cc:	1141                	addi	sp,sp,-16
     1ce:	e022                	sd	s0,0(sp)
     1d0:	842a                	mv	s0,a0
     1d2:	6508                	ld	a0,8(a0)
     1d4:	e406                	sd	ra,8(sp)
     1d6:	00008797          	auipc	a5,0x8
     1da:	ca278793          	addi	a5,a5,-862 # 7e78 <_ZTV12RedirCommand+0x10>
     1de:	e01c                	sd	a5,0(s0)
     1e0:	c501                	beqz	a0,1e8 <_ZN12RedirCommandD0Ev+0x1c>
     1e2:	611c                	ld	a5,0(a0)
     1e4:	679c                	ld	a5,8(a5)
     1e6:	9782                	jalr	a5
     1e8:	8522                	mv	a0,s0
     1ea:	6402                	ld	s0,0(sp)
     1ec:	60a2                	ld	ra,8(sp)
     1ee:	02800593          	li	a1,40
     1f2:	0141                	addi	sp,sp,16
     1f4:	5f50506f          	j	5fe8 <_ZdlPvm>

00000000000001f8 <_ZN11BackCommandD0Ev>:
    ~BackCommand() { delete sub_cmd; }
     1f8:	1141                	addi	sp,sp,-16
     1fa:	e022                	sd	s0,0(sp)
     1fc:	842a                	mv	s0,a0
     1fe:	6508                	ld	a0,8(a0)
     200:	e406                	sd	ra,8(sp)
     202:	00008797          	auipc	a5,0x8
     206:	cee78793          	addi	a5,a5,-786 # 7ef0 <_ZTV11BackCommand+0x10>
     20a:	e01c                	sd	a5,0(s0)
     20c:	c501                	beqz	a0,214 <_ZN11BackCommandD0Ev+0x1c>
     20e:	611c                	ld	a5,0(a0)
     210:	679c                	ld	a5,8(a5)
     212:	9782                	jalr	a5
     214:	8522                	mv	a0,s0
     216:	6402                	ld	s0,0(sp)
     218:	60a2                	ld	ra,8(sp)
     21a:	45c1                	li	a1,16
     21c:	0141                	addi	sp,sp,16
     21e:	5cb0506f          	j	5fe8 <_ZdlPvm>

0000000000000222 <_ZN11PipeCommandD0Ev>:
    ~PipeCommand()
     222:	1141                	addi	sp,sp,-16
     224:	e022                	sd	s0,0(sp)
     226:	842a                	mv	s0,a0
        delete left;
     228:	6508                	ld	a0,8(a0)
    ~PipeCommand()
     22a:	e406                	sd	ra,8(sp)
    {
     22c:	00008797          	auipc	a5,0x8
     230:	c7478793          	addi	a5,a5,-908 # 7ea0 <_ZTV11PipeCommand+0x10>
     234:	e01c                	sd	a5,0(s0)
        delete left;
     236:	c501                	beqz	a0,23e <_ZN11PipeCommandD0Ev+0x1c>
     238:	611c                	ld	a5,0(a0)
     23a:	679c                	ld	a5,8(a5)
     23c:	9782                	jalr	a5
        delete right;
     23e:	6808                	ld	a0,16(s0)
     240:	c501                	beqz	a0,248 <_ZN11PipeCommandD0Ev+0x26>
     242:	611c                	ld	a5,0(a0)
     244:	679c                	ld	a5,8(a5)
     246:	9782                	jalr	a5
    }
     248:	8522                	mv	a0,s0
     24a:	6402                	ld	s0,0(sp)
     24c:	60a2                	ld	ra,8(sp)
     24e:	45e1                	li	a1,24
     250:	0141                	addi	sp,sp,16
     252:	5970506f          	j	5fe8 <_ZdlPvm>

0000000000000256 <_ZN11ListCommandD0Ev>:
    ~ListCommand()
     256:	1141                	addi	sp,sp,-16
     258:	e022                	sd	s0,0(sp)
     25a:	842a                	mv	s0,a0
        delete left;
     25c:	6508                	ld	a0,8(a0)
    ~ListCommand()
     25e:	e406                	sd	ra,8(sp)
    {
     260:	00008797          	auipc	a5,0x8
     264:	c6878793          	addi	a5,a5,-920 # 7ec8 <_ZTV11ListCommand+0x10>
     268:	e01c                	sd	a5,0(s0)
        delete left;
     26a:	c501                	beqz	a0,272 <_ZN11ListCommandD0Ev+0x1c>
     26c:	611c                	ld	a5,0(a0)
     26e:	679c                	ld	a5,8(a5)
     270:	9782                	jalr	a5
        delete right;
     272:	6808                	ld	a0,16(s0)
     274:	c501                	beqz	a0,27c <_ZN11ListCommandD0Ev+0x26>
     276:	611c                	ld	a5,0(a0)
     278:	679c                	ld	a5,8(a5)
     27a:	9782                	jalr	a5
    }
     27c:	8522                	mv	a0,s0
     27e:	6402                	ld	s0,0(sp)
     280:	60a2                	ld	ra,8(sp)
     282:	45e1                	li	a1,24
     284:	0141                	addi	sp,sp,16
     286:	5630506f          	j	5fe8 <_ZdlPvm>

000000000000028a <_ZN11BackCommand3runEv>:
    void run() override
     28a:	1141                	addi	sp,sp,-16
     28c:	e022                	sd	s0,0(sp)
     28e:	e406                	sd	ra,8(sp)
     290:	842a                	mv	s0,a0
    int pid = fork();
     292:	63f000ef          	jal	10d0 <fork>
    if (pid == -1)
     296:	57fd                	li	a5,-1
     298:	00f50d63          	beq	a0,a5,2b2 <_ZN11BackCommand3runEv+0x28>
        if (fork_or_panic() == 0)
     29c:	e509                	bnez	a0,2a6 <_ZN11BackCommand3runEv+0x1c>
            sub_cmd->run();
     29e:	6408                	ld	a0,8(s0)
     2a0:	611c                	ld	a5,0(a0)
     2a2:	6b9c                	ld	a5,16(a5)
     2a4:	9782                	jalr	a5
    }
     2a6:	6402                	ld	s0,0(sp)
     2a8:	60a2                	ld	ra,8(sp)
        exit(0);
     2aa:	4501                	li	a0,0
    }
     2ac:	0141                	addi	sp,sp,16
        exit(0);
     2ae:	1600506f          	j	540e <exit>
    printf("shell panic: %s\n", s);
     2b2:	00006597          	auipc	a1,0x6
     2b6:	d8e58593          	addi	a1,a1,-626 # 6040 <_GLOBAL__sub_I__ZSt3cin+0x50>
     2ba:	00006517          	auipc	a0,0x6
     2be:	d8e50513          	addi	a0,a0,-626 # 6048 <_GLOBAL__sub_I__ZSt3cin+0x58>
     2c2:	638040ef          	jal	48fa <printf>
    exit(1);
     2c6:	4505                	li	a0,1
     2c8:	146050ef          	jal	540e <exit>
    }
     2cc:	6402                	ld	s0,0(sp)
     2ce:	60a2                	ld	ra,8(sp)
        exit(0);
     2d0:	4501                	li	a0,0
    }
     2d2:	0141                	addi	sp,sp,16
        exit(0);
     2d4:	13a0506f          	j	540e <exit>

00000000000002d8 <_ZN11ListCommand3runEv>:
    void run() override
     2d8:	1141                	addi	sp,sp,-16
     2da:	e022                	sd	s0,0(sp)
     2dc:	e406                	sd	ra,8(sp)
     2de:	842a                	mv	s0,a0
    int pid = fork();
     2e0:	5f1000ef          	jal	10d0 <fork>
    if (pid == -1)
     2e4:	57fd                	li	a5,-1
     2e6:	02f50163          	beq	a0,a5,308 <_ZN11ListCommand3runEv+0x30>
        if (fork_or_panic() == 0)
     2ea:	e509                	bnez	a0,2f4 <_ZN11ListCommand3runEv+0x1c>
            left->run();
     2ec:	6408                	ld	a0,8(s0)
     2ee:	611c                	ld	a5,0(a0)
     2f0:	6b9c                	ld	a5,16(a5)
     2f2:	9782                	jalr	a5
        wait(0);
     2f4:	4501                	li	a0,0
     2f6:	5e3000ef          	jal	10d8 <wait>
        right->run();
     2fa:	6808                	ld	a0,16(s0)
    }
     2fc:	6402                	ld	s0,0(sp)
     2fe:	60a2                	ld	ra,8(sp)
        right->run();
     300:	611c                	ld	a5,0(a0)
     302:	6b9c                	ld	a5,16(a5)
    }
     304:	0141                	addi	sp,sp,16
        right->run();
     306:	8782                	jr	a5
    printf("shell panic: %s\n", s);
     308:	00006597          	auipc	a1,0x6
     30c:	d3858593          	addi	a1,a1,-712 # 6040 <_GLOBAL__sub_I__ZSt3cin+0x50>
     310:	00006517          	auipc	a0,0x6
     314:	d3850513          	addi	a0,a0,-712 # 6048 <_GLOBAL__sub_I__ZSt3cin+0x58>
     318:	5e2040ef          	jal	48fa <printf>
    exit(1);
     31c:	4505                	li	a0,1
     31e:	0f0050ef          	jal	540e <exit>
    return pid;
     322:	bfc9                	j	2f4 <_ZN11ListCommand3runEv+0x1c>

0000000000000324 <_ZN11PipeCommand3runEv>:
    void run() override
     324:	1101                	addi	sp,sp,-32
     326:	e822                	sd	s0,16(sp)
     328:	842a                	mv	s0,a0
        if (pipe(p) < 0)
     32a:	0028                	addi	a0,sp,8
    void run() override
     32c:	ec06                	sd	ra,24(sp)
        if (pipe(p) < 0)
     32e:	5b3000ef          	jal	10e0 <pipe>
     332:	0a054463          	bltz	a0,3da <_ZN11PipeCommand3runEv+0xb6>
    int pid = fork();
     336:	59b000ef          	jal	10d0 <fork>
    if (pid == -1)
     33a:	57fd                	li	a5,-1
     33c:	0cf50163          	beq	a0,a5,3fe <_ZN11PipeCommand3runEv+0xda>
        if (fork_or_panic() == 0)
     340:	c931                	beqz	a0,394 <_ZN11PipeCommand3runEv+0x70>
    int pid = fork();
     342:	58f000ef          	jal	10d0 <fork>
    if (pid == -1)
     346:	577d                	li	a4,-1
     348:	06e50b63          	beq	a0,a4,3be <_ZN11PipeCommand3runEv+0x9a>
        if (fork_or_panic() == 0)
     34c:	c505                	beqz	a0,374 <_ZN11PipeCommand3runEv+0x50>
        close(p[0]);
     34e:	4522                	lw	a0,8(sp)
     350:	5a9000ef          	jal	10f8 <close>
        close(p[1]);
     354:	4532                	lw	a0,12(sp)
     356:	5a3000ef          	jal	10f8 <close>
        wait(0);
     35a:	4501                	li	a0,0
     35c:	57d000ef          	jal	10d8 <wait>
        wait(0);
     360:	4501                	li	a0,0
     362:	577000ef          	jal	10d8 <wait>
        exit(0);
     366:	4501                	li	a0,0
     368:	0a6050ef          	jal	540e <exit>
    }
     36c:	60e2                	ld	ra,24(sp)
     36e:	6442                	ld	s0,16(sp)
     370:	6105                	addi	sp,sp,32
     372:	8082                	ret
            close(0);  // close stdin
     374:	585000ef          	jal	10f8 <close>
            dup(p[0]); // dup read-end to stdin
     378:	4522                	lw	a0,8(sp)
     37a:	5cf000ef          	jal	1148 <dup>
            close(p[0]);
     37e:	4522                	lw	a0,8(sp)
     380:	579000ef          	jal	10f8 <close>
            close(p[1]);
     384:	4532                	lw	a0,12(sp)
     386:	573000ef          	jal	10f8 <close>
            right->run();
     38a:	6808                	ld	a0,16(s0)
     38c:	611c                	ld	a5,0(a0)
     38e:	6b9c                	ld	a5,16(a5)
     390:	9782                	jalr	a5
     392:	bf75                	j	34e <_ZN11PipeCommand3runEv+0x2a>
            close(1);  // close stdout
     394:	4505                	li	a0,1
     396:	563000ef          	jal	10f8 <close>
            dup(p[1]); // dup write-end to stdout
     39a:	4532                	lw	a0,12(sp)
     39c:	5ad000ef          	jal	1148 <dup>
            close(p[0]);
     3a0:	4522                	lw	a0,8(sp)
     3a2:	557000ef          	jal	10f8 <close>
            close(p[1]);
     3a6:	4532                	lw	a0,12(sp)
     3a8:	551000ef          	jal	10f8 <close>
            left->run();
     3ac:	6408                	ld	a0,8(s0)
     3ae:	611c                	ld	a5,0(a0)
     3b0:	6b9c                	ld	a5,16(a5)
     3b2:	9782                	jalr	a5
    int pid = fork();
     3b4:	51d000ef          	jal	10d0 <fork>
    if (pid == -1)
     3b8:	577d                	li	a4,-1
     3ba:	f8e519e3          	bne	a0,a4,34c <_ZN11PipeCommand3runEv+0x28>
    printf("shell panic: %s\n", s);
     3be:	00006597          	auipc	a1,0x6
     3c2:	c8258593          	addi	a1,a1,-894 # 6040 <_GLOBAL__sub_I__ZSt3cin+0x50>
     3c6:	00006517          	auipc	a0,0x6
     3ca:	c8250513          	addi	a0,a0,-894 # 6048 <_GLOBAL__sub_I__ZSt3cin+0x58>
     3ce:	52c040ef          	jal	48fa <printf>
    exit(1);
     3d2:	4505                	li	a0,1
     3d4:	03a050ef          	jal	540e <exit>
    return pid;
     3d8:	bf9d                	j	34e <_ZN11PipeCommand3runEv+0x2a>
    printf("shell panic: %s\n", s);
     3da:	00006597          	auipc	a1,0x6
     3de:	c8658593          	addi	a1,a1,-890 # 6060 <_GLOBAL__sub_I__ZSt3cin+0x70>
     3e2:	00006517          	auipc	a0,0x6
     3e6:	c6650513          	addi	a0,a0,-922 # 6048 <_GLOBAL__sub_I__ZSt3cin+0x58>
     3ea:	510040ef          	jal	48fa <printf>
    exit(1);
     3ee:	4505                	li	a0,1
     3f0:	01e050ef          	jal	540e <exit>
    int pid = fork();
     3f4:	4dd000ef          	jal	10d0 <fork>
    if (pid == -1)
     3f8:	57fd                	li	a5,-1
     3fa:	f4f513e3          	bne	a0,a5,340 <_ZN11PipeCommand3runEv+0x1c>
    printf("shell panic: %s\n", s);
     3fe:	00006597          	auipc	a1,0x6
     402:	c4258593          	addi	a1,a1,-958 # 6040 <_GLOBAL__sub_I__ZSt3cin+0x50>
     406:	00006517          	auipc	a0,0x6
     40a:	c4250513          	addi	a0,a0,-958 # 6048 <_GLOBAL__sub_I__ZSt3cin+0x58>
     40e:	4ec040ef          	jal	48fa <printf>
    exit(1);
     412:	4505                	li	a0,1
     414:	7fb040ef          	jal	540e <exit>
    return pid;
     418:	b72d                	j	342 <_ZN11PipeCommand3runEv+0x1e>

000000000000041a <_ZN6Parser12parse_redirsEP7CommandPPcS2_>:
        : sub_cmd(c), file(f), efile(ef), mode(m), fd(fd_in) {}
     41a:	4785                	li	a5,1
     41c:	1782                	slli	a5,a5,0x20
    static Command *parse_redirs(Command *cmd, char **ps, char *es)
     41e:	7119                	addi	sp,sp,-128
        : sub_cmd(c), file(f), efile(ef), mode(m), fd(fd_in) {}
     420:	60178793          	addi	a5,a5,1537
    static Command *parse_redirs(Command *cmd, char **ps, char *es)
     424:	f8a2                	sd	s0,112(sp)
     426:	f4a6                	sd	s1,104(sp)
     428:	e4d6                	sd	s5,72(sp)
     42a:	e0da                	sd	s6,64(sp)
     42c:	f862                	sd	s8,48(sp)
     42e:	f466                	sd	s9,40(sp)
     430:	fc86                	sd	ra,120(sp)
     432:	f0ca                	sd	s2,96(sp)
     434:	ecce                	sd	s3,88(sp)
     436:	e8d2                	sd	s4,80(sp)
     438:	fc5e                	sd	s7,56(sp)
     43a:	f06a                	sd	s10,32(sp)
     43c:	ec6e                	sd	s11,24(sp)
     43e:	8aae                	mv	s5,a1
     440:	8432                	mv	s0,a2
        while (peek(ps, es, "<>"))
     442:	8c2a                	mv	s8,a0
     444:	00008497          	auipc	s1,0x8
     448:	ac448493          	addi	s1,s1,-1340 # 7f08 <WHITESPACE>
        switch (*s)
     44c:	03c00b13          	li	s6,60
            if (get_token(ps, es, &q, &eq) != 'a')
     450:	06100c93          	li	s9,97
        : sub_cmd(c), file(f), efile(ef), mode(m), fd(fd_in) {}
     454:	e43e                	sd	a5,8(sp)
        char *s = *ps;
     456:	000ab903          	ld	s2,0(s5)
        while (s < es && strchr(WHITESPACE, *s))
     45a:	00896663          	bltu	s2,s0,466 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x4c>
     45e:	a811                	j	472 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x58>
            s++;
     460:	0905                	addi	s2,s2,1
        while (s < es && strchr(WHITESPACE, *s))
     462:	01240863          	beq	s0,s2,472 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x58>
     466:	00094583          	lbu	a1,0(s2)
     46a:	6088                	ld	a0,0(s1)
     46c:	05b050ef          	jal	5cc6 <strchr>
     470:	f965                	bnez	a0,460 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x46>
        *ps = s;
     472:	012ab023          	sd	s2,0(s5)
        return *s && strchr(toks, *s);
     476:	00094583          	lbu	a1,0(s2)
     47a:	e18d                	bnez	a1,49c <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x82>
    }
     47c:	70e6                	ld	ra,120(sp)
     47e:	7446                	ld	s0,112(sp)
     480:	74a6                	ld	s1,104(sp)
     482:	7906                	ld	s2,96(sp)
     484:	69e6                	ld	s3,88(sp)
     486:	6a46                	ld	s4,80(sp)
     488:	6aa6                	ld	s5,72(sp)
     48a:	6b06                	ld	s6,64(sp)
     48c:	7be2                	ld	s7,56(sp)
     48e:	7ca2                	ld	s9,40(sp)
     490:	7d02                	ld	s10,32(sp)
     492:	6de2                	ld	s11,24(sp)
     494:	8562                	mv	a0,s8
     496:	7c42                	ld	s8,48(sp)
     498:	6109                	addi	sp,sp,128
     49a:	8082                	ret
        return *s && strchr(toks, *s);
     49c:	00006517          	auipc	a0,0x6
     4a0:	bec50513          	addi	a0,a0,-1044 # 6088 <_GLOBAL__sub_I__ZSt3cin+0x98>
     4a4:	023050ef          	jal	5cc6 <strchr>
     4a8:	d971                	beqz	a0,47c <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x62>
        s = *ps;
     4aa:	000abd83          	ld	s11,0(s5)
        while (s < es && strchr(WHITESPACE, *s))
     4ae:	008de663          	bltu	s11,s0,4ba <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xa0>
     4b2:	a811                	j	4c6 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xac>
            s++;
     4b4:	0d85                	addi	s11,s11,1
        while (s < es && strchr(WHITESPACE, *s))
     4b6:	01b40863          	beq	s0,s11,4c6 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xac>
     4ba:	000dc583          	lbu	a1,0(s11)
     4be:	6088                	ld	a0,0(s1)
     4c0:	007050ef          	jal	5cc6 <strchr>
     4c4:	f965                	bnez	a0,4b4 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x9a>
        ret = *s;
     4c6:	000dc983          	lbu	s3,0(s11)
        switch (*s)
     4ca:	193b6e63          	bltu	s6,s3,666 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x24c>
     4ce:	03a00713          	li	a4,58
     4d2:	01376f63          	bltu	a4,s3,4f0 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xd6>
     4d6:	00098e63          	beqz	s3,4f2 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xd8>
     4da:	02600713          	li	a4,38
     4de:	00e98963          	beq	s3,a4,4f0 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xd6>
     4e2:	fd89871b          	addiw	a4,s3,-40
     4e6:	0ff77713          	zext.b	a4,a4
     4ea:	4685                	li	a3,1
     4ec:	0ce6ef63          	bltu	a3,a4,5ca <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1b0>
            s++;
     4f0:	0d85                	addi	s11,s11,1
        while (s < es && strchr(WHITESPACE, *s))
     4f2:	108df363          	bgeu	s11,s0,5f8 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1de>
     4f6:	8926                	mv	s2,s1
     4f8:	a021                	j	500 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xe6>
            s++;
     4fa:	0d85                	addi	s11,s11,1
        while (s < es && strchr(WHITESPACE, *s))
     4fc:	25b40963          	beq	s0,s11,74e <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x334>
     500:	000dc583          	lbu	a1,0(s11)
     504:	6088                	ld	a0,0(s1)
     506:	7c0050ef          	jal	5cc6 <strchr>
     50a:	f965                	bnez	a0,4fa <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xe0>
        *ps = s;
     50c:	01bab023          	sd	s11,0(s5)
        while (s < es && strchr(WHITESPACE, *s))
     510:	008de663          	bltu	s11,s0,51c <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x102>
     514:	a0e5                	j	5fc <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1e2>
            s++;
     516:	0d85                	addi	s11,s11,1
        while (s < es && strchr(WHITESPACE, *s))
     518:	01b40863          	beq	s0,s11,528 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x10e>
     51c:	000dc583          	lbu	a1,0(s11)
     520:	6088                	ld	a0,0(s1)
     522:	7a4050ef          	jal	5cc6 <strchr>
     526:	f965                	bnez	a0,516 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xfc>
        ret = *s;
     528:	000dca03          	lbu	s4,0(s11)
        switch (*s)
     52c:	154b6963          	bltu	s6,s4,67e <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x264>
     530:	03a00713          	li	a4,58
     534:	01476f63          	bltu	a4,s4,552 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x138>
     538:	0c0a0c63          	beqz	s4,610 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1f6>
     53c:	02600713          	li	a4,38
     540:	00ea0963          	beq	s4,a4,552 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x138>
     544:	fd8a071b          	addiw	a4,s4,-40
     548:	0ff77713          	zext.b	a4,a4
     54c:	4685                	li	a3,1
     54e:	18e6e163          	bltu	a3,a4,6d0 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x2b6>
        ret = *s;
     552:	8bee                	mv	s7,s11
            s++;
     554:	0d85                	addi	s11,s11,1
        ret = *s;
     556:	2a01                	sext.w	s4,s4
        while (s < es && strchr(WHITESPACE, *s))
     558:	8926                	mv	s2,s1
     55a:	0c8df063          	bgeu	s11,s0,61a <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x200>
        ret = *s;
     55e:	8d6e                	mv	s10,s11
     560:	a021                	j	568 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x14e>
            s++;
     562:	0d05                	addi	s10,s10,1
        while (s < es && strchr(WHITESPACE, *s))
     564:	008d7963          	bgeu	s10,s0,576 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x15c>
     568:	000d4583          	lbu	a1,0(s10)
     56c:	00093503          	ld	a0,0(s2)
     570:	756050ef          	jal	5cc6 <strchr>
     574:	f57d                	bnez	a0,562 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x148>
        *ps = s;
     576:	01aab023          	sd	s10,0(s5)
            if (get_token(ps, es, &q, &eq) != 'a')
     57a:	0b9a1263          	bne	s4,s9,61e <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x204>
            *eq = 0; // Null terminate filename immediately
     57e:	000d8023          	sb	zero,0(s11)
            switch (tok)
     582:	0b698f63          	beq	s3,s6,640 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x226>
     586:	03e00713          	li	a4,62
     58a:	10e98c63          	beq	s3,a4,6a2 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x288>
     58e:	02b00713          	li	a4,43
     592:	ece992e3          	bne	s3,a4,456 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x3c>
                cmd = new RedirCommand(cmd, q, eq, O_WRONLY | O_CREATE, 1); // Append not fully supported in simple OS yet?
     596:	02800513          	li	a0,40
     59a:	23f050ef          	jal	5fd8 <_Znwm>
        : sub_cmd(c), file(f), efile(ef), mode(m), fd(fd_in) {}
     59e:	4705                	li	a4,1
     5a0:	1702                	slli	a4,a4,0x20
     5a2:	20170713          	addi	a4,a4,513
     5a6:	00008797          	auipc	a5,0x8
     5aa:	8d278793          	addi	a5,a5,-1838 # 7e78 <_ZTV12RedirCommand+0x10>
     5ae:	01853423          	sd	s8,8(a0)
     5b2:	e11c                	sd	a5,0(a0)
     5b4:	01753823          	sd	s7,16(a0)
     5b8:	01b53c23          	sd	s11,24(a0)
     5bc:	f118                	sd	a4,32(a0)
                cmd = new RedirCommand(cmd, q, eq, O_WRONLY | O_CREATE, 1); // Append not fully supported in simple OS yet?
     5be:	8c2a                	mv	s8,a0
                break;
     5c0:	bd59                	j	456 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x3c>
        switch (*s)
     5c2:	07c00713          	li	a4,124
     5c6:	f2e985e3          	beq	s3,a4,4f0 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xd6>
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     5ca:	008dec63          	bltu	s11,s0,5e2 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1c8>
     5ce:	a01d                	j	5f4 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1da>
     5d0:	000dc583          	lbu	a1,0(s11)
     5d4:	6488                	ld	a0,8(s1)
     5d6:	6f0050ef          	jal	5cc6 <strchr>
     5da:	e911                	bnez	a0,5ee <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1d4>
                s++;
     5dc:	0d85                	addi	s11,s11,1
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     5de:	01b40b63          	beq	s0,s11,5f4 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1da>
     5e2:	000dc583          	lbu	a1,0(s11)
     5e6:	6088                	ld	a0,0(s1)
     5e8:	6de050ef          	jal	5cc6 <strchr>
     5ec:	d175                	beqz	a0,5d0 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1b6>
     5ee:	06100993          	li	s3,97
     5f2:	b701                	j	4f2 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xd8>
     5f4:	06100993          	li	s3,97
        *ps = s;
     5f8:	01bab023          	sd	s11,0(s5)
        ret = *s;
     5fc:	000dca03          	lbu	s4,0(s11)
        switch (*s)
     600:	114b6963          	bltu	s6,s4,712 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x2f8>
     604:	03a00713          	li	a4,58
     608:	f54765e3          	bltu	a4,s4,552 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x138>
     60c:	120a1063          	bnez	s4,72c <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x312>
        while (s < es && strchr(WHITESPACE, *s))
     610:	8bee                	mv	s7,s11
        ret = *s;
     612:	4a01                	li	s4,0
     614:	8926                	mv	s2,s1
        while (s < es && strchr(WHITESPACE, *s))
     616:	f48de4e3          	bltu	s11,s0,55e <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x144>
        *ps = s;
     61a:	01bab023          	sd	s11,0(s5)
    printf("shell panic: %s\n", s);
     61e:	00006597          	auipc	a1,0x6
     622:	a4a58593          	addi	a1,a1,-1462 # 6068 <_GLOBAL__sub_I__ZSt3cin+0x78>
     626:	00006517          	auipc	a0,0x6
     62a:	a2250513          	addi	a0,a0,-1502 # 6048 <_GLOBAL__sub_I__ZSt3cin+0x58>
     62e:	2cc040ef          	jal	48fa <printf>
    exit(1);
     632:	4505                	li	a0,1
     634:	5db040ef          	jal	540e <exit>
            *eq = 0; // Null terminate filename immediately
     638:	000d8023          	sb	zero,0(s11)
            switch (tok)
     63c:	f56995e3          	bne	s3,s6,586 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x16c>
                cmd = new RedirCommand(cmd, q, eq, O_RDONLY, 0);
     640:	02800513          	li	a0,40
     644:	195050ef          	jal	5fd8 <_Znwm>
        : sub_cmd(c), file(f), efile(ef), mode(m), fd(fd_in) {}
     648:	00008797          	auipc	a5,0x8
     64c:	83078793          	addi	a5,a5,-2000 # 7e78 <_ZTV12RedirCommand+0x10>
     650:	01853423          	sd	s8,8(a0)
     654:	e11c                	sd	a5,0(a0)
     656:	01753823          	sd	s7,16(a0)
     65a:	01b53c23          	sd	s11,24(a0)
     65e:	02053023          	sd	zero,32(a0)
                cmd = new RedirCommand(cmd, q, eq, O_RDONLY, 0);
     662:	8c2a                	mv	s8,a0
                break;
     664:	bbcd                	j	456 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x3c>
        switch (*s)
     666:	03e00713          	li	a4,62
     66a:	f4e99ce3          	bne	s3,a4,5c2 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1a8>
            if (*s == '>')
     66e:	001dc703          	lbu	a4,1(s11)
     672:	e7371fe3          	bne	a4,s3,4f0 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xd6>
                s++;
     676:	0d89                	addi	s11,s11,2
     678:	02b00993          	li	s3,43
     67c:	bd9d                	j	4f2 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xd8>
        switch (*s)
     67e:	03e00713          	li	a4,62
     682:	8bee                	mv	s7,s11
     684:	04ea1263          	bne	s4,a4,6c8 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x2ae>
            if (*s == '>')
     688:	001dc683          	lbu	a3,1(s11)
     68c:	03e00713          	li	a4,62
     690:	06e68a63          	beq	a3,a4,704 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x2ea>
            s++;
     694:	0d85                	addi	s11,s11,1
        ret = *s;
     696:	03e00a13          	li	s4,62
     69a:	8926                	mv	s2,s1
        while (s < es && strchr(WHITESPACE, *s))
     69c:	ec8de1e3          	bltu	s11,s0,55e <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x144>
     6a0:	bfad                	j	61a <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x200>
                cmd = new RedirCommand(cmd, q, eq, O_WRONLY | O_CREATE | O_TRUNC, 1);
     6a2:	02800513          	li	a0,40
     6a6:	133050ef          	jal	5fd8 <_Znwm>
        : sub_cmd(c), file(f), efile(ef), mode(m), fd(fd_in) {}
     6aa:	00007797          	auipc	a5,0x7
     6ae:	7ce78793          	addi	a5,a5,1998 # 7e78 <_ZTV12RedirCommand+0x10>
     6b2:	e11c                	sd	a5,0(a0)
     6b4:	67a2                	ld	a5,8(sp)
     6b6:	01853423          	sd	s8,8(a0)
     6ba:	01753823          	sd	s7,16(a0)
     6be:	01b53c23          	sd	s11,24(a0)
     6c2:	f11c                	sd	a5,32(a0)
                cmd = new RedirCommand(cmd, q, eq, O_WRONLY | O_CREATE | O_TRUNC, 1);
     6c4:	8c2a                	mv	s8,a0
                break;
     6c6:	bb41                	j	456 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x3c>
        switch (*s)
     6c8:	07c00713          	li	a4,124
     6cc:	e8ea03e3          	beq	s4,a4,552 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x138>
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     6d0:	048dfa63          	bgeu	s11,s0,724 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x30a>
     6d4:	8d6e                	mv	s10,s11
     6d6:	a811                	j	6ea <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x2d0>
     6d8:	000d4583          	lbu	a1,0(s10)
     6dc:	6488                	ld	a0,8(s1)
     6de:	5e8050ef          	jal	5cc6 <strchr>
     6e2:	e911                	bnez	a0,6f6 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x2dc>
                s++;
     6e4:	0d05                	addi	s10,s10,1
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     6e6:	05a40f63          	beq	s0,s10,744 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x32a>
     6ea:	000d4583          	lbu	a1,0(s10)
     6ee:	6088                	ld	a0,0(s1)
     6f0:	5d6050ef          	jal	5cc6 <strchr>
     6f4:	d175                	beqz	a0,6d8 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x2be>
        while (s < es && strchr(WHITESPACE, *s))
     6f6:	048d7763          	bgeu	s10,s0,744 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x32a>
     6fa:	8bee                	mv	s7,s11
     6fc:	06100a13          	li	s4,97
     700:	8dea                	mv	s11,s10
     702:	bdb1                	j	55e <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x144>
                s++;
     704:	0d89                	addi	s11,s11,2
                ret = '+';
     706:	02b00a13          	li	s4,43
     70a:	8926                	mv	s2,s1
        while (s < es && strchr(WHITESPACE, *s))
     70c:	e48de9e3          	bltu	s11,s0,55e <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x144>
     710:	b729                	j	61a <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x200>
        switch (*s)
     712:	03e00713          	li	a4,62
     716:	8bee                	mv	s7,s11
     718:	f6ea08e3          	beq	s4,a4,688 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x26e>
     71c:	07c00713          	li	a4,124
     720:	e2ea09e3          	beq	s4,a4,552 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x138>
        *ps = s;
     724:	01bab023          	sd	s11,0(s5)
     728:	8bee                	mv	s7,s11
     72a:	bd91                	j	57e <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x164>
        switch (*s)
     72c:	02600713          	li	a4,38
     730:	e2ea01e3          	beq	s4,a4,552 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x138>
     734:	fd8a071b          	addiw	a4,s4,-40
     738:	0ff77713          	zext.b	a4,a4
     73c:	4685                	li	a3,1
     73e:	e0e6fae3          	bgeu	a3,a4,552 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x138>
     742:	b7cd                	j	724 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x30a>
        *ps = s;
     744:	8bee                	mv	s7,s11
     746:	01aab023          	sd	s10,0(s5)
     74a:	8dea                	mv	s11,s10
     74c:	bd0d                	j	57e <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x164>
     74e:	008ab023          	sd	s0,0(s5)
        while (s < es && strchr(WHITESPACE, *s))
     752:	b56d                	j	5fc <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1e2>

0000000000000754 <_ZN6Parser10parse_pipeEPPcS0_>:
    static Command *parse_pipe(char **ps, char *es)
     754:	7119                	addi	sp,sp,-128
     756:	e8d2                	sd	s4,80(sp)
     758:	8a2a                	mv	s4,a0
        ExecCommand *cmd = new ExecCommand();
     75a:	05800513          	li	a0,88
    static Command *parse_pipe(char **ps, char *es)
     75e:	fc86                	sd	ra,120(sp)
     760:	f8a2                	sd	s0,112(sp)
     762:	f4a6                	sd	s1,104(sp)
     764:	842e                	mv	s0,a1
     766:	e4d6                	sd	s5,72(sp)
     768:	e0da                	sd	s6,64(sp)
     76a:	fc5e                	sd	s7,56(sp)
     76c:	f466                	sd	s9,40(sp)
     76e:	f06a                	sd	s10,32(sp)
     770:	f0ca                	sd	s2,96(sp)
     772:	ecce                	sd	s3,88(sp)
     774:	f862                	sd	s8,48(sp)
     776:	ec6e                	sd	s11,24(sp)
        ExecCommand *cmd = new ExecCommand();
     778:	061050ef          	jal	5fd8 <_Znwm>
     77c:	84aa                	mv	s1,a0
    {
     77e:	00007797          	auipc	a5,0x7
     782:	6d278793          	addi	a5,a5,1746 # 7e50 <_ZTV11ExecCommand+0x10>
        memset(argv, 0, sizeof(argv));
     786:	00850b93          	addi	s7,a0,8
    {
     78a:	e09c                	sd	a5,0(s1)
        ExecCommand *cmd = new ExecCommand();
     78c:	e42a                	sd	a0,8(sp)
        memset(argv, 0, sizeof(argv));
     78e:	05000613          	li	a2,80
     792:	4581                	li	a1,0
     794:	855e                	mv	a0,s7
     796:	342050ef          	jal	5ad8 <memset>
        ret = parse_redirs(ret, ps, es);
     79a:	8526                	mv	a0,s1
     79c:	8622                	mv	a2,s0
     79e:	85d2                	mv	a1,s4
     7a0:	c7bff0ef          	jal	41a <_ZN6Parser12parse_redirsEP7CommandPPcS2_>
        char *s = *ps;
     7a4:	000a3d03          	ld	s10,0(s4)
        ret = parse_redirs(ret, ps, es);
     7a8:	8aaa                	mv	s5,a0
        argc = 0;
     7aa:	4b01                	li	s6,0
        while (s < es && strchr(WHITESPACE, *s))
     7ac:	00007497          	auipc	s1,0x7
     7b0:	75c48493          	addi	s1,s1,1884 # 7f08 <WHITESPACE>
            if (*s == '>')
     7b4:	03e00c93          	li	s9,62
        while (s < es && strchr(WHITESPACE, *s))
     7b8:	0c8d7f63          	bgeu	s10,s0,896 <_ZN6Parser10parse_pipeEPPcS0_+0x142>
     7bc:	89a6                	mv	s3,s1
     7be:	a021                	j	7c6 <_ZN6Parser10parse_pipeEPPcS0_+0x72>
            s++;
     7c0:	0d05                	addi	s10,s10,1
        while (s < es && strchr(WHITESPACE, *s))
     7c2:	01a40863          	beq	s0,s10,7d2 <_ZN6Parser10parse_pipeEPPcS0_+0x7e>
     7c6:	000d4583          	lbu	a1,0(s10)
     7ca:	6088                	ld	a0,0(s1)
     7cc:	4fa050ef          	jal	5cc6 <strchr>
     7d0:	f965                	bnez	a0,7c0 <_ZN6Parser10parse_pipeEPPcS0_+0x6c>
        *ps = s;
     7d2:	01aa3023          	sd	s10,0(s4)
        return *s && strchr(toks, *s);
     7d6:	000d4583          	lbu	a1,0(s10)
     7da:	10059063          	bnez	a1,8da <_ZN6Parser10parse_pipeEPPcS0_+0x186>
        while (s < es && strchr(WHITESPACE, *s))
     7de:	008d6863          	bltu	s10,s0,7ee <_ZN6Parser10parse_pipeEPPcS0_+0x9a>
     7e2:	a6ad                	j	b4c <_ZN6Parser10parse_pipeEPPcS0_+0x3f8>
            s++;
     7e4:	0d05                	addi	s10,s10,1
        ret = *s;
     7e6:	000d4903          	lbu	s2,0(s10)
        while (s < es && strchr(WHITESPACE, *s))
     7ea:	0ba40f63          	beq	s0,s10,8a8 <_ZN6Parser10parse_pipeEPPcS0_+0x154>
     7ee:	000d4583          	lbu	a1,0(s10)
     7f2:	6088                	ld	a0,0(s1)
     7f4:	4d2050ef          	jal	5cc6 <strchr>
     7f8:	f575                	bnez	a0,7e4 <_ZN6Parser10parse_pipeEPPcS0_+0x90>
        ret = *s;
     7fa:	000d4903          	lbu	s2,0(s10)
        switch (*s)
     7fe:	08090f63          	beqz	s2,89c <_ZN6Parser10parse_pipeEPPcS0_+0x148>
     802:	1b990663          	beq	s2,s9,9ae <_ZN6Parser10parse_pipeEPPcS0_+0x25a>
     806:	2d2ceb63          	bltu	s9,s2,adc <_ZN6Parser10parse_pipeEPPcS0_+0x388>
     80a:	02900713          	li	a4,41
     80e:	29276663          	bltu	a4,s2,a9a <_ZN6Parser10parse_pipeEPPcS0_+0x346>
     812:	02700713          	li	a4,39
     816:	01276663          	bltu	a4,s2,822 <_ZN6Parser10parse_pipeEPPcS0_+0xce>
     81a:	02600713          	li	a4,38
     81e:	28e91563          	bne	s2,a4,aa8 <_ZN6Parser10parse_pipeEPPcS0_+0x354>
        ret = *s;
     822:	8c6a                	mv	s8,s10
            s++;
     824:	0d05                	addi	s10,s10,1
        ret = *s;
     826:	2901                	sext.w	s2,s2
     828:	89a6                	mv	s3,s1
        while (s < es && strchr(WHITESPACE, *s))
     82a:	168d7f63          	bgeu	s10,s0,9a8 <_ZN6Parser10parse_pipeEPPcS0_+0x254>
        ret = *s;
     82e:	8dea                	mv	s11,s10
     830:	a021                	j	838 <_ZN6Parser10parse_pipeEPPcS0_+0xe4>
            s++;
     832:	0d85                	addi	s11,s11,1
        while (s < es && strchr(WHITESPACE, *s))
     834:	008df963          	bgeu	s11,s0,846 <_ZN6Parser10parse_pipeEPPcS0_+0xf2>
     838:	000dc583          	lbu	a1,0(s11)
     83c:	0009b503          	ld	a0,0(s3)
     840:	486050ef          	jal	5cc6 <strchr>
     844:	f57d                	bnez	a0,832 <_ZN6Parser10parse_pipeEPPcS0_+0xde>
        *ps = s;
     846:	01ba3023          	sd	s11,0(s4)
            if ((tok = get_token(ps, es, &q, &eq)) == 0)
     84a:	0a090163          	beqz	s2,8ec <_ZN6Parser10parse_pipeEPPcS0_+0x198>
            if (tok != 'a')
     84e:	06100793          	li	a5,97
     852:	00f90f63          	beq	s2,a5,870 <_ZN6Parser10parse_pipeEPPcS0_+0x11c>
    printf("shell panic: %s\n", s);
     856:	00006597          	auipc	a1,0x6
     85a:	83a58593          	addi	a1,a1,-1990 # 6090 <_GLOBAL__sub_I__ZSt3cin+0xa0>
     85e:	00005517          	auipc	a0,0x5
     862:	7ea50513          	addi	a0,a0,2026 # 6048 <_GLOBAL__sub_I__ZSt3cin+0x58>
     866:	094040ef          	jal	48fa <printf>
    exit(1);
     86a:	4505                	li	a0,1
     86c:	3a3040ef          	jal	540e <exit>
            cmd->argv[argc] = q;
     870:	018bb023          	sd	s8,0(s7)
            *eq = 0; // Temp
     874:	000d0023          	sb	zero,0(s10)
            argc++;
     878:	2b05                	addiw	s6,s6,1
            if (argc >= MAX_ARGS)
     87a:	47a5                	li	a5,9
     87c:	0d67c463          	blt	a5,s6,944 <_ZN6Parser10parse_pipeEPPcS0_+0x1f0>
            ret = parse_redirs(ret, ps, es);
     880:	8556                	mv	a0,s5
     882:	8622                	mv	a2,s0
     884:	85d2                	mv	a1,s4
     886:	b95ff0ef          	jal	41a <_ZN6Parser12parse_redirsEP7CommandPPcS2_>
        char *s = *ps;
     88a:	000a3d03          	ld	s10,0(s4)
            ret = parse_redirs(ret, ps, es);
     88e:	8aaa                	mv	s5,a0
     890:	0ba1                	addi	s7,s7,8
        while (s < es && strchr(WHITESPACE, *s))
     892:	f28d65e3          	bltu	s10,s0,7bc <_ZN6Parser10parse_pipeEPPcS0_+0x68>
        return *s && strchr(toks, *s);
     896:	000d4583          	lbu	a1,0(s10)
     89a:	e1a1                	bnez	a1,8da <_ZN6Parser10parse_pipeEPPcS0_+0x186>
        while (s < es && strchr(WHITESPACE, *s))
     89c:	2a8d7863          	bgeu	s10,s0,b4c <_ZN6Parser10parse_pipeEPPcS0_+0x3f8>
     8a0:	8c6a                	mv	s8,s10
        ret = *s;
     8a2:	4901                	li	s2,0
     8a4:	89a6                	mv	s3,s1
     8a6:	b761                	j	82e <_ZN6Parser10parse_pipeEPPcS0_+0xda>
        switch (*s)
     8a8:	0f990463          	beq	s2,s9,990 <_ZN6Parser10parse_pipeEPPcS0_+0x23c>
     8ac:	0d2cea63          	bltu	s9,s2,980 <_ZN6Parser10parse_pipeEPPcS0_+0x22c>
     8b0:	02900793          	li	a5,41
     8b4:	1127ef63          	bltu	a5,s2,9d2 <_ZN6Parser10parse_pipeEPPcS0_+0x27e>
     8b8:	02700713          	li	a4,39
     8bc:	f72763e3          	bltu	a4,s2,822 <_ZN6Parser10parse_pipeEPPcS0_+0xce>
     8c0:	28090663          	beqz	s2,b4c <_ZN6Parser10parse_pipeEPPcS0_+0x3f8>
     8c4:	02600713          	li	a4,38
     8c8:	0ce91063          	bne	s2,a4,988 <_ZN6Parser10parse_pipeEPPcS0_+0x234>
        ret = *s;
     8cc:	8c6a                	mv	s8,s10
            s++;
     8ce:	0d05                	addi	s10,s10,1
        ret = *s;
     8d0:	2901                	sext.w	s2,s2
     8d2:	89a6                	mv	s3,s1
        while (s < es && strchr(WHITESPACE, *s))
     8d4:	f48d6de3          	bltu	s10,s0,82e <_ZN6Parser10parse_pipeEPPcS0_+0xda>
     8d8:	a8c1                	j	9a8 <_ZN6Parser10parse_pipeEPPcS0_+0x254>
        return *s && strchr(toks, *s);
     8da:	00005517          	auipc	a0,0x5
     8de:	7ce50513          	addi	a0,a0,1998 # 60a8 <_GLOBAL__sub_I__ZSt3cin+0xb8>
     8e2:	3e4050ef          	jal	5cc6 <strchr>
     8e6:	cd2d                	beqz	a0,960 <_ZN6Parser10parse_pipeEPPcS0_+0x20c>
        char *s = *ps;
     8e8:	000a3d83          	ld	s11,0(s4)
        cmd->argv[argc] = 0;
     8ec:	67a2                	ld	a5,8(sp)
     8ee:	0b0e                	slli	s6,s6,0x3
     8f0:	97da                	add	a5,a5,s6
     8f2:	0007b423          	sd	zero,8(a5)
        while (s < es && strchr(WHITESPACE, *s))
     8f6:	028df163          	bgeu	s11,s0,918 <_ZN6Parser10parse_pipeEPPcS0_+0x1c4>
     8fa:	00007997          	auipc	s3,0x7
     8fe:	60e98993          	addi	s3,s3,1550 # 7f08 <WHITESPACE>
     902:	a021                	j	90a <_ZN6Parser10parse_pipeEPPcS0_+0x1b6>
            s++;
     904:	0d85                	addi	s11,s11,1
        while (s < es && strchr(WHITESPACE, *s))
     906:	01b40963          	beq	s0,s11,918 <_ZN6Parser10parse_pipeEPPcS0_+0x1c4>
     90a:	000dc583          	lbu	a1,0(s11)
     90e:	0009b503          	ld	a0,0(s3)
     912:	3b4050ef          	jal	5cc6 <strchr>
     916:	f57d                	bnez	a0,904 <_ZN6Parser10parse_pipeEPPcS0_+0x1b0>
        *ps = s;
     918:	01ba3023          	sd	s11,0(s4)
        return *s && strchr(toks, *s);
     91c:	000dc583          	lbu	a1,0(s11)
     920:	e5f9                	bnez	a1,9ee <_ZN6Parser10parse_pipeEPPcS0_+0x29a>
        Command *cmd = parse_exec(ps, es);
     922:	8456                	mv	s0,s5
    }
     924:	70e6                	ld	ra,120(sp)
     926:	8522                	mv	a0,s0
     928:	7446                	ld	s0,112(sp)
     92a:	74a6                	ld	s1,104(sp)
     92c:	7906                	ld	s2,96(sp)
     92e:	69e6                	ld	s3,88(sp)
     930:	6a46                	ld	s4,80(sp)
     932:	6aa6                	ld	s5,72(sp)
     934:	6b06                	ld	s6,64(sp)
     936:	7be2                	ld	s7,56(sp)
     938:	7c42                	ld	s8,48(sp)
     93a:	7ca2                	ld	s9,40(sp)
     93c:	7d02                	ld	s10,32(sp)
     93e:	6de2                	ld	s11,24(sp)
     940:	6109                	addi	sp,sp,128
     942:	8082                	ret
    printf("shell panic: %s\n", s);
     944:	00005597          	auipc	a1,0x5
     948:	75458593          	addi	a1,a1,1876 # 6098 <_GLOBAL__sub_I__ZSt3cin+0xa8>
     94c:	00005517          	auipc	a0,0x5
     950:	6fc50513          	addi	a0,a0,1788 # 6048 <_GLOBAL__sub_I__ZSt3cin+0x58>
     954:	7a7030ef          	jal	48fa <printf>
    exit(1);
     958:	4505                	li	a0,1
     95a:	2b5040ef          	jal	540e <exit>
}
     95e:	b70d                	j	880 <_ZN6Parser10parse_pipeEPPcS0_+0x12c>
        char *s = *ps;
     960:	000a3d03          	ld	s10,0(s4)
     964:	89a6                	mv	s3,s1
        ret = *s;
     966:	000d4903          	lbu	s2,0(s10)
        while (s < es && strchr(WHITESPACE, *s))
     96a:	e88d62e3          	bltu	s10,s0,7ee <_ZN6Parser10parse_pipeEPPcS0_+0x9a>
        switch (*s)
     96e:	03c00713          	li	a4,60
     972:	1f277163          	bgeu	a4,s2,b54 <_ZN6Parser10parse_pipeEPPcS0_+0x400>
     976:	03e00713          	li	a4,62
     97a:	8c6a                	mv	s8,s10
     97c:	00e90b63          	beq	s2,a4,992 <_ZN6Parser10parse_pipeEPPcS0_+0x23e>
     980:	07c00713          	li	a4,124
     984:	e8e90fe3          	beq	s2,a4,822 <_ZN6Parser10parse_pipeEPPcS0_+0xce>
        *ps = s;
     988:	01aa3023          	sd	s10,0(s4)
     98c:	8c6a                	mv	s8,s10
     98e:	b5cd                	j	870 <_ZN6Parser10parse_pipeEPPcS0_+0x11c>
        switch (*s)
     990:	8c22                	mv	s8,s0
            if (*s == '>')
     992:	001c4783          	lbu	a5,1(s8)
     996:	03978163          	beq	a5,s9,9b8 <_ZN6Parser10parse_pipeEPPcS0_+0x264>
            s++;
     99a:	001c0d13          	addi	s10,s8,1
        ret = *s;
     99e:	03e00913          	li	s2,62
     9a2:	89a6                	mv	s3,s1
        while (s < es && strchr(WHITESPACE, *s))
     9a4:	e88d65e3          	bltu	s10,s0,82e <_ZN6Parser10parse_pipeEPPcS0_+0xda>
        *ps = s;
     9a8:	01aa3023          	sd	s10,0(s4)
            if (tok != 'a')
     9ac:	b56d                	j	856 <_ZN6Parser10parse_pipeEPPcS0_+0x102>
        switch (*s)
     9ae:	8c6a                	mv	s8,s10
            if (*s == '>')
     9b0:	001c4783          	lbu	a5,1(s8)
     9b4:	ff9793e3          	bne	a5,s9,99a <_ZN6Parser10parse_pipeEPPcS0_+0x246>
                s++;
     9b8:	002c0d13          	addi	s10,s8,2
                ret = '+';
     9bc:	02b00913          	li	s2,43
     9c0:	00007997          	auipc	s3,0x7
     9c4:	54898993          	addi	s3,s3,1352 # 7f08 <WHITESPACE>
        while (s < es && strchr(WHITESPACE, *s))
     9c8:	e68d63e3          	bltu	s10,s0,82e <_ZN6Parser10parse_pipeEPPcS0_+0xda>
        *ps = s;
     9cc:	01aa3023          	sd	s10,0(s4)
            if (tok != 'a')
     9d0:	b559                	j	856 <_ZN6Parser10parse_pipeEPPcS0_+0x102>
        switch (*s)
     9d2:	fc59071b          	addiw	a4,s2,-59
     9d6:	0ff77713          	zext.b	a4,a4
     9da:	4685                	li	a3,1
     9dc:	fae6e6e3          	bltu	a3,a4,988 <_ZN6Parser10parse_pipeEPPcS0_+0x234>
        ret = *s;
     9e0:	8c6a                	mv	s8,s10
            s++;
     9e2:	0d05                	addi	s10,s10,1
        ret = *s;
     9e4:	2901                	sext.w	s2,s2
     9e6:	89a6                	mv	s3,s1
        while (s < es && strchr(WHITESPACE, *s))
     9e8:	e48d63e3          	bltu	s10,s0,82e <_ZN6Parser10parse_pipeEPPcS0_+0xda>
     9ec:	bf75                	j	9a8 <_ZN6Parser10parse_pipeEPPcS0_+0x254>
        return *s && strchr(toks, *s);
     9ee:	00005517          	auipc	a0,0x5
     9f2:	6c250513          	addi	a0,a0,1730 # 60b0 <_GLOBAL__sub_I__ZSt3cin+0xc0>
     9f6:	2d0050ef          	jal	5cc6 <strchr>
     9fa:	d505                	beqz	a0,922 <_ZN6Parser10parse_pipeEPPcS0_+0x1ce>
        s = *ps;
     9fc:	000a3483          	ld	s1,0(s4)
        while (s < es && strchr(WHITESPACE, *s))
     a00:	0284f163          	bgeu	s1,s0,a22 <_ZN6Parser10parse_pipeEPPcS0_+0x2ce>
     a04:	00007997          	auipc	s3,0x7
     a08:	50498993          	addi	s3,s3,1284 # 7f08 <WHITESPACE>
     a0c:	a021                	j	a14 <_ZN6Parser10parse_pipeEPPcS0_+0x2c0>
            s++;
     a0e:	0485                	addi	s1,s1,1
        while (s < es && strchr(WHITESPACE, *s))
     a10:	00940963          	beq	s0,s1,a22 <_ZN6Parser10parse_pipeEPPcS0_+0x2ce>
     a14:	0004c583          	lbu	a1,0(s1)
     a18:	0009b503          	ld	a0,0(s3)
     a1c:	2aa050ef          	jal	5cc6 <strchr>
     a20:	f57d                	bnez	a0,a0e <_ZN6Parser10parse_pipeEPPcS0_+0x2ba>
        ret = *s;
     a22:	0004c783          	lbu	a5,0(s1)
        switch (*s)
     a26:	03c00713          	li	a4,60
     a2a:	0cf76963          	bltu	a4,a5,afc <_ZN6Parser10parse_pipeEPPcS0_+0x3a8>
     a2e:	03a00713          	li	a4,58
     a32:	00f76e63          	bltu	a4,a5,a4e <_ZN6Parser10parse_pipeEPPcS0_+0x2fa>
     a36:	cf89                	beqz	a5,a50 <_ZN6Parser10parse_pipeEPPcS0_+0x2fc>
     a38:	02600713          	li	a4,38
     a3c:	00e78963          	beq	a5,a4,a4e <_ZN6Parser10parse_pipeEPPcS0_+0x2fa>
     a40:	fd87879b          	addiw	a5,a5,-40
     a44:	0ff7f793          	zext.b	a5,a5
     a48:	4705                	li	a4,1
     a4a:	0cf76763          	bltu	a4,a5,b18 <_ZN6Parser10parse_pipeEPPcS0_+0x3c4>
            s++;
     a4e:	0485                	addi	s1,s1,1
        while (s < es && strchr(WHITESPACE, *s))
     a50:	00007997          	auipc	s3,0x7
     a54:	4b898993          	addi	s3,s3,1208 # 7f08 <WHITESPACE>
     a58:	0084e663          	bltu	s1,s0,a64 <_ZN6Parser10parse_pipeEPPcS0_+0x310>
     a5c:	a819                	j	a72 <_ZN6Parser10parse_pipeEPPcS0_+0x31e>
            s++;
     a5e:	0485                	addi	s1,s1,1
        while (s < es && strchr(WHITESPACE, *s))
     a60:	0e940463          	beq	s0,s1,b48 <_ZN6Parser10parse_pipeEPPcS0_+0x3f4>
     a64:	0004c583          	lbu	a1,0(s1)
     a68:	0009b503          	ld	a0,0(s3)
     a6c:	25a050ef          	jal	5cc6 <strchr>
     a70:	f57d                	bnez	a0,a5e <_ZN6Parser10parse_pipeEPPcS0_+0x30a>
        *ps = s;
     a72:	009a3023          	sd	s1,0(s4)
            cmd = new PipeCommand(cmd, parse_pipe(ps, es));
     a76:	4561                	li	a0,24
     a78:	560050ef          	jal	5fd8 <_Znwm>
     a7c:	87aa                	mv	a5,a0
     a7e:	85a2                	mv	a1,s0
     a80:	8552                	mv	a0,s4
     a82:	843e                	mv	s0,a5
     a84:	cd1ff0ef          	jal	754 <_ZN6Parser10parse_pipeEPPcS0_>
    PipeCommand(Command *l, Command *r) : left(l), right(r) {}
     a88:	00007797          	auipc	a5,0x7
     a8c:	41878793          	addi	a5,a5,1048 # 7ea0 <_ZTV11PipeCommand+0x10>
     a90:	e01c                	sd	a5,0(s0)
     a92:	01543423          	sd	s5,8(s0)
     a96:	e808                	sd	a0,16(s0)
     a98:	b571                	j	924 <_ZN6Parser10parse_pipeEPPcS0_+0x1d0>
        switch (*s)
     a9a:	fc59071b          	addiw	a4,s2,-59
     a9e:	0ff77713          	zext.b	a4,a4
     aa2:	4685                	li	a3,1
     aa4:	d6e6ffe3          	bgeu	a3,a4,822 <_ZN6Parser10parse_pipeEPPcS0_+0xce>
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     aa8:	ee8d70e3          	bgeu	s10,s0,988 <_ZN6Parser10parse_pipeEPPcS0_+0x234>
     aac:	8dea                	mv	s11,s10
     aae:	a811                	j	ac2 <_ZN6Parser10parse_pipeEPPcS0_+0x36e>
     ab0:	000dc583          	lbu	a1,0(s11)
     ab4:	6488                	ld	a0,8(s1)
     ab6:	210050ef          	jal	5cc6 <strchr>
     aba:	e911                	bnez	a0,ace <_ZN6Parser10parse_pipeEPPcS0_+0x37a>
                s++;
     abc:	0d85                	addi	s11,s11,1
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     abe:	03b40a63          	beq	s0,s11,af2 <_ZN6Parser10parse_pipeEPPcS0_+0x39e>
     ac2:	000dc583          	lbu	a1,0(s11)
     ac6:	6088                	ld	a0,0(s1)
     ac8:	1fe050ef          	jal	5cc6 <strchr>
     acc:	d175                	beqz	a0,ab0 <_ZN6Parser10parse_pipeEPPcS0_+0x35c>
        while (s < es && strchr(WHITESPACE, *s))
     ace:	8c6a                	mv	s8,s10
     ad0:	0a8df463          	bgeu	s11,s0,b78 <_ZN6Parser10parse_pipeEPPcS0_+0x424>
     ad4:	06100913          	li	s2,97
     ad8:	8d6e                	mv	s10,s11
     ada:	bb91                	j	82e <_ZN6Parser10parse_pipeEPPcS0_+0xda>
        switch (*s)
     adc:	07c00713          	li	a4,124
     ae0:	fce914e3          	bne	s2,a4,aa8 <_ZN6Parser10parse_pipeEPPcS0_+0x354>
        ret = *s;
     ae4:	8c6a                	mv	s8,s10
            s++;
     ae6:	0d05                	addi	s10,s10,1
        ret = *s;
     ae8:	2901                	sext.w	s2,s2
     aea:	89a6                	mv	s3,s1
        while (s < es && strchr(WHITESPACE, *s))
     aec:	d48d61e3          	bltu	s10,s0,82e <_ZN6Parser10parse_pipeEPPcS0_+0xda>
     af0:	bd65                	j	9a8 <_ZN6Parser10parse_pipeEPPcS0_+0x254>
        *ps = s;
     af2:	8c6a                	mv	s8,s10
     af4:	008a3023          	sd	s0,0(s4)
     af8:	8d22                	mv	s10,s0
     afa:	bb9d                	j	870 <_ZN6Parser10parse_pipeEPPcS0_+0x11c>
        switch (*s)
     afc:	03e00713          	li	a4,62
     b00:	00e79863          	bne	a5,a4,b10 <_ZN6Parser10parse_pipeEPPcS0_+0x3bc>
            if (*s == '>')
     b04:	0014c703          	lbu	a4,1(s1)
     b08:	f4f713e3          	bne	a4,a5,a4e <_ZN6Parser10parse_pipeEPPcS0_+0x2fa>
                s++;
     b0c:	0489                	addi	s1,s1,2
     b0e:	b789                	j	a50 <_ZN6Parser10parse_pipeEPPcS0_+0x2fc>
        switch (*s)
     b10:	07c00713          	li	a4,124
     b14:	f2e78de3          	beq	a5,a4,a4e <_ZN6Parser10parse_pipeEPPcS0_+0x2fa>
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     b18:	f484fde3          	bgeu	s1,s0,a72 <_ZN6Parser10parse_pipeEPPcS0_+0x31e>
     b1c:	00007997          	auipc	s3,0x7
     b20:	3ec98993          	addi	s3,s3,1004 # 7f08 <WHITESPACE>
     b24:	0004c583          	lbu	a1,0(s1)
     b28:	0009b503          	ld	a0,0(s3)
     b2c:	19a050ef          	jal	5cc6 <strchr>
     b30:	f105                	bnez	a0,a50 <_ZN6Parser10parse_pipeEPPcS0_+0x2fc>
     b32:	0004c583          	lbu	a1,0(s1)
     b36:	0089b503          	ld	a0,8(s3)
     b3a:	18c050ef          	jal	5cc6 <strchr>
     b3e:	f00519e3          	bnez	a0,a50 <_ZN6Parser10parse_pipeEPPcS0_+0x2fc>
                s++;
     b42:	0485                	addi	s1,s1,1
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     b44:	fe9410e3          	bne	s0,s1,b24 <_ZN6Parser10parse_pipeEPPcS0_+0x3d0>
     b48:	84a2                	mv	s1,s0
     b4a:	b725                	j	a72 <_ZN6Parser10parse_pipeEPPcS0_+0x31e>
        *ps = s;
     b4c:	01aa3023          	sd	s10,0(s4)
     b50:	8dea                	mv	s11,s10
     b52:	bb69                	j	8ec <_ZN6Parser10parse_pipeEPPcS0_+0x198>
        switch (*s)
     b54:	03a00713          	li	a4,58
     b58:	cd2765e3          	bltu	a4,s2,822 <_ZN6Parser10parse_pipeEPPcS0_+0xce>
     b5c:	fe0908e3          	beqz	s2,b4c <_ZN6Parser10parse_pipeEPPcS0_+0x3f8>
     b60:	02600713          	li	a4,38
     b64:	cae90fe3          	beq	s2,a4,822 <_ZN6Parser10parse_pipeEPPcS0_+0xce>
     b68:	fd89071b          	addiw	a4,s2,-40
     b6c:	0ff77713          	zext.b	a4,a4
     b70:	4685                	li	a3,1
     b72:	cae6f8e3          	bgeu	a3,a4,822 <_ZN6Parser10parse_pipeEPPcS0_+0xce>
     b76:	bd09                	j	988 <_ZN6Parser10parse_pipeEPPcS0_+0x234>
        *ps = s;
     b78:	01ba3023          	sd	s11,0(s4)
     b7c:	8d6e                	mv	s10,s11
     b7e:	06100913          	li	s2,97
     b82:	b1f1                	j	84e <_ZN6Parser10parse_pipeEPPcS0_+0xfa>

0000000000000b84 <_ZN6Parser10parse_lineEPPcS0_>:
    static Command *parse_line(char **ps, char *es)
     b84:	7159                	addi	sp,sp,-112
     b86:	eca6                	sd	s1,88(sp)
     b88:	e8ca                	sd	s2,80(sp)
     b8a:	e4ce                	sd	s3,72(sp)
     b8c:	e0d2                	sd	s4,64(sp)
     b8e:	fc56                	sd	s5,56(sp)
     b90:	f85a                	sd	s6,48(sp)
     b92:	f45e                	sd	s7,40(sp)
     b94:	f062                	sd	s8,32(sp)
     b96:	ec66                	sd	s9,24(sp)
     b98:	e86a                	sd	s10,16(sp)
     b9a:	e46e                	sd	s11,8(sp)
     b9c:	f486                	sd	ra,104(sp)
     b9e:	f0a2                	sd	s0,96(sp)
     ba0:	89aa                	mv	s3,a0
     ba2:	84ae                	mv	s1,a1
        Command *cmd = parse_pipe(ps, es);
     ba4:	bb1ff0ef          	jal	754 <_ZN6Parser10parse_pipeEPPcS0_>
     ba8:	8a2a                	mv	s4,a0
        while (peek(ps, es, "&"))
     baa:	00007917          	auipc	s2,0x7
     bae:	35e90913          	addi	s2,s2,862 # 7f08 <WHITESPACE>
        return *s && strchr(toks, *s);
     bb2:	00005c97          	auipc	s9,0x5
     bb6:	506c8c93          	addi	s9,s9,1286 # 60b8 <_GLOBAL__sub_I__ZSt3cin+0xc8>
        switch (*s)
     bba:	03c00b13          	li	s6,60
     bbe:	03e00b93          	li	s7,62
     bc2:	07c00d93          	li	s11,124
     bc6:	03a00c13          	li	s8,58
     bca:	02600d13          	li	s10,38
    BackCommand(Command *c) : sub_cmd(c) {}
     bce:	00007a97          	auipc	s5,0x7
     bd2:	322a8a93          	addi	s5,s5,802 # 7ef0 <_ZTV11BackCommand+0x10>
        char *s = *ps;
     bd6:	0009b403          	ld	s0,0(s3)
        while (s < es && strchr(WHITESPACE, *s))
     bda:	00946663          	bltu	s0,s1,be6 <_ZN6Parser10parse_lineEPPcS0_+0x62>
     bde:	a819                	j	bf4 <_ZN6Parser10parse_lineEPPcS0_+0x70>
            s++;
     be0:	0405                	addi	s0,s0,1
        while (s < es && strchr(WHITESPACE, *s))
     be2:	00848963          	beq	s1,s0,bf4 <_ZN6Parser10parse_lineEPPcS0_+0x70>
     be6:	00044583          	lbu	a1,0(s0)
     bea:	00093503          	ld	a0,0(s2)
     bee:	0d8050ef          	jal	5cc6 <strchr>
     bf2:	f57d                	bnez	a0,be0 <_ZN6Parser10parse_lineEPPcS0_+0x5c>
        *ps = s;
     bf4:	0089b023          	sd	s0,0(s3)
        return *s && strchr(toks, *s);
     bf8:	00044583          	lbu	a1,0(s0)
     bfc:	e9a9                	bnez	a1,c4e <_ZN6Parser10parse_lineEPPcS0_+0xca>
        while (s < es && strchr(WHITESPACE, *s))
     bfe:	02947163          	bgeu	s0,s1,c20 <_ZN6Parser10parse_lineEPPcS0_+0x9c>
     c02:	00007917          	auipc	s2,0x7
     c06:	30690913          	addi	s2,s2,774 # 7f08 <WHITESPACE>
     c0a:	a021                	j	c12 <_ZN6Parser10parse_lineEPPcS0_+0x8e>
            s++;
     c0c:	0405                	addi	s0,s0,1
        while (s < es && strchr(WHITESPACE, *s))
     c0e:	00848963          	beq	s1,s0,c20 <_ZN6Parser10parse_lineEPPcS0_+0x9c>
     c12:	00044583          	lbu	a1,0(s0)
     c16:	00093503          	ld	a0,0(s2)
     c1a:	0ac050ef          	jal	5cc6 <strchr>
     c1e:	f57d                	bnez	a0,c0c <_ZN6Parser10parse_lineEPPcS0_+0x88>
        *ps = s;
     c20:	0089b023          	sd	s0,0(s3)
        return *s && strchr(toks, *s);
     c24:	00044583          	lbu	a1,0(s0)
     c28:	0e059a63          	bnez	a1,d1c <_ZN6Parser10parse_lineEPPcS0_+0x198>
     c2c:	8452                	mv	s0,s4
    }
     c2e:	70a6                	ld	ra,104(sp)
     c30:	8522                	mv	a0,s0
     c32:	7406                	ld	s0,96(sp)
     c34:	64e6                	ld	s1,88(sp)
     c36:	6946                	ld	s2,80(sp)
     c38:	69a6                	ld	s3,72(sp)
     c3a:	6a06                	ld	s4,64(sp)
     c3c:	7ae2                	ld	s5,56(sp)
     c3e:	7b42                	ld	s6,48(sp)
     c40:	7ba2                	ld	s7,40(sp)
     c42:	7c02                	ld	s8,32(sp)
     c44:	6ce2                	ld	s9,24(sp)
     c46:	6d42                	ld	s10,16(sp)
     c48:	6da2                	ld	s11,8(sp)
     c4a:	6165                	addi	sp,sp,112
     c4c:	8082                	ret
        return *s && strchr(toks, *s);
     c4e:	8566                	mv	a0,s9
     c50:	076050ef          	jal	5cc6 <strchr>
        s = *ps;
     c54:	0009b403          	ld	s0,0(s3)
        return *s && strchr(toks, *s);
     c58:	d15d                	beqz	a0,bfe <_ZN6Parser10parse_lineEPPcS0_+0x7a>
        while (s < es && strchr(WHITESPACE, *s))
     c5a:	00946663          	bltu	s0,s1,c66 <_ZN6Parser10parse_lineEPPcS0_+0xe2>
     c5e:	a819                	j	c74 <_ZN6Parser10parse_lineEPPcS0_+0xf0>
            s++;
     c60:	0405                	addi	s0,s0,1
        while (s < es && strchr(WHITESPACE, *s))
     c62:	00848963          	beq	s1,s0,c74 <_ZN6Parser10parse_lineEPPcS0_+0xf0>
     c66:	00044583          	lbu	a1,0(s0)
     c6a:	00093503          	ld	a0,0(s2)
     c6e:	058050ef          	jal	5cc6 <strchr>
     c72:	f57d                	bnez	a0,c60 <_ZN6Parser10parse_lineEPPcS0_+0xdc>
        ret = *s;
     c74:	00044783          	lbu	a5,0(s0)
        switch (*s)
     c78:	08fb6a63          	bltu	s6,a5,d0c <_ZN6Parser10parse_lineEPPcS0_+0x188>
     c7c:	00fc6c63          	bltu	s8,a5,c94 <_ZN6Parser10parse_lineEPPcS0_+0x110>
     c80:	cb99                	beqz	a5,c96 <_ZN6Parser10parse_lineEPPcS0_+0x112>
     c82:	01a78963          	beq	a5,s10,c94 <_ZN6Parser10parse_lineEPPcS0_+0x110>
     c86:	fd87879b          	addiw	a5,a5,-40
     c8a:	0ff7f793          	zext.b	a5,a5
     c8e:	4705                	li	a4,1
     c90:	02f76d63          	bltu	a4,a5,cca <_ZN6Parser10parse_lineEPPcS0_+0x146>
            s++;
     c94:	0405                	addi	s0,s0,1
        while (s < es && strchr(WHITESPACE, *s))
     c96:	00946663          	bltu	s0,s1,ca2 <_ZN6Parser10parse_lineEPPcS0_+0x11e>
     c9a:	a819                	j	cb0 <_ZN6Parser10parse_lineEPPcS0_+0x12c>
            s++;
     c9c:	0405                	addi	s0,s0,1
        while (s < es && strchr(WHITESPACE, *s))
     c9e:	04848b63          	beq	s1,s0,cf4 <_ZN6Parser10parse_lineEPPcS0_+0x170>
     ca2:	00044583          	lbu	a1,0(s0)
     ca6:	00093503          	ld	a0,0(s2)
     caa:	01c050ef          	jal	5cc6 <strchr>
     cae:	f57d                	bnez	a0,c9c <_ZN6Parser10parse_lineEPPcS0_+0x118>
        *ps = s;
     cb0:	0089b023          	sd	s0,0(s3)
            cmd = new BackCommand(cmd);
     cb4:	4541                	li	a0,16
     cb6:	322050ef          	jal	5fd8 <_Znwm>
    BackCommand(Command *c) : sub_cmd(c) {}
     cba:	01453423          	sd	s4,8(a0)
     cbe:	01553023          	sd	s5,0(a0)
            cmd = new BackCommand(cmd);
     cc2:	8a2a                	mv	s4,a0
     cc4:	bf09                	j	bd6 <_ZN6Parser10parse_lineEPPcS0_+0x52>
        switch (*s)
     cc6:	fdb787e3          	beq	a5,s11,c94 <_ZN6Parser10parse_lineEPPcS0_+0x110>
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     cca:	00946d63          	bltu	s0,s1,ce4 <_ZN6Parser10parse_lineEPPcS0_+0x160>
     cce:	b7cd                	j	cb0 <_ZN6Parser10parse_lineEPPcS0_+0x12c>
     cd0:	00044583          	lbu	a1,0(s0)
     cd4:	00893503          	ld	a0,8(s2)
     cd8:	7ef040ef          	jal	5cc6 <strchr>
     cdc:	fd4d                	bnez	a0,c96 <_ZN6Parser10parse_lineEPPcS0_+0x112>
                s++;
     cde:	0405                	addi	s0,s0,1
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     ce0:	00848a63          	beq	s1,s0,cf4 <_ZN6Parser10parse_lineEPPcS0_+0x170>
     ce4:	00044583          	lbu	a1,0(s0)
     ce8:	00093503          	ld	a0,0(s2)
     cec:	7db040ef          	jal	5cc6 <strchr>
     cf0:	d165                	beqz	a0,cd0 <_ZN6Parser10parse_lineEPPcS0_+0x14c>
     cf2:	b755                	j	c96 <_ZN6Parser10parse_lineEPPcS0_+0x112>
     cf4:	8426                	mv	s0,s1
        *ps = s;
     cf6:	0089b023          	sd	s0,0(s3)
            cmd = new BackCommand(cmd);
     cfa:	4541                	li	a0,16
     cfc:	2dc050ef          	jal	5fd8 <_Znwm>
    BackCommand(Command *c) : sub_cmd(c) {}
     d00:	01453423          	sd	s4,8(a0)
     d04:	01553023          	sd	s5,0(a0)
            cmd = new BackCommand(cmd);
     d08:	8a2a                	mv	s4,a0
     d0a:	b5f1                	j	bd6 <_ZN6Parser10parse_lineEPPcS0_+0x52>
        switch (*s)
     d0c:	fb779de3          	bne	a5,s7,cc6 <_ZN6Parser10parse_lineEPPcS0_+0x142>
            if (*s == '>')
     d10:	00144783          	lbu	a5,1(s0)
     d14:	f97790e3          	bne	a5,s7,c94 <_ZN6Parser10parse_lineEPPcS0_+0x110>
                s++;
     d18:	0409                	addi	s0,s0,2
     d1a:	bfb5                	j	c96 <_ZN6Parser10parse_lineEPPcS0_+0x112>
        return *s && strchr(toks, *s);
     d1c:	00005517          	auipc	a0,0x5
     d20:	3a450513          	addi	a0,a0,932 # 60c0 <_GLOBAL__sub_I__ZSt3cin+0xd0>
     d24:	7a3040ef          	jal	5cc6 <strchr>
     d28:	f00502e3          	beqz	a0,c2c <_ZN6Parser10parse_lineEPPcS0_+0xa8>
        s = *ps;
     d2c:	0009b403          	ld	s0,0(s3)
        ret = *s;
     d30:	00044783          	lbu	a5,0(s0)
        while (s < es && strchr(WHITESPACE, *s))
     d34:	0e947863          	bgeu	s0,s1,e24 <_ZN6Parser10parse_lineEPPcS0_+0x2a0>
     d38:	00007917          	auipc	s2,0x7
     d3c:	1d090913          	addi	s2,s2,464 # 7f08 <WHITESPACE>
     d40:	a021                	j	d48 <_ZN6Parser10parse_lineEPPcS0_+0x1c4>
            s++;
     d42:	0405                	addi	s0,s0,1
        while (s < es && strchr(WHITESPACE, *s))
     d44:	00848963          	beq	s1,s0,d56 <_ZN6Parser10parse_lineEPPcS0_+0x1d2>
     d48:	00044583          	lbu	a1,0(s0)
     d4c:	00093503          	ld	a0,0(s2)
     d50:	777040ef          	jal	5cc6 <strchr>
     d54:	f57d                	bnez	a0,d42 <_ZN6Parser10parse_lineEPPcS0_+0x1be>
        ret = *s;
     d56:	00044783          	lbu	a5,0(s0)
        switch (*s)
     d5a:	02900713          	li	a4,41
     d5e:	04f76b63          	bltu	a4,a5,db4 <_ZN6Parser10parse_lineEPPcS0_+0x230>
     d62:	02700713          	li	a4,39
     d66:	08f76f63          	bltu	a4,a5,e04 <_ZN6Parser10parse_lineEPPcS0_+0x280>
     d6a:	efd9                	bnez	a5,e08 <_ZN6Parser10parse_lineEPPcS0_+0x284>
        while (s < es && strchr(WHITESPACE, *s))
     d6c:	00007917          	auipc	s2,0x7
     d70:	19c90913          	addi	s2,s2,412 # 7f08 <WHITESPACE>
     d74:	00946663          	bltu	s0,s1,d80 <_ZN6Parser10parse_lineEPPcS0_+0x1fc>
     d78:	a819                	j	d8e <_ZN6Parser10parse_lineEPPcS0_+0x20a>
            s++;
     d7a:	0405                	addi	s0,s0,1
        while (s < es && strchr(WHITESPACE, *s))
     d7c:	06848c63          	beq	s1,s0,df4 <_ZN6Parser10parse_lineEPPcS0_+0x270>
     d80:	00044583          	lbu	a1,0(s0)
     d84:	00093503          	ld	a0,0(s2)
     d88:	73f040ef          	jal	5cc6 <strchr>
     d8c:	f57d                	bnez	a0,d7a <_ZN6Parser10parse_lineEPPcS0_+0x1f6>
        *ps = s;
     d8e:	0089b023          	sd	s0,0(s3)
            cmd = new ListCommand(cmd, parse_line(ps, es));
     d92:	4561                	li	a0,24
     d94:	244050ef          	jal	5fd8 <_Znwm>
     d98:	842a                	mv	s0,a0
     d9a:	85a6                	mv	a1,s1
     d9c:	854e                	mv	a0,s3
     d9e:	de7ff0ef          	jal	b84 <_ZN6Parser10parse_lineEPPcS0_>
    ListCommand(Command *l, Command *r) : left(l), right(r) {}
     da2:	00007797          	auipc	a5,0x7
     da6:	12678793          	addi	a5,a5,294 # 7ec8 <_ZTV11ListCommand+0x10>
     daa:	e01c                	sd	a5,0(s0)
     dac:	01443423          	sd	s4,8(s0)
     db0:	e808                	sd	a0,16(s0)
     db2:	bdb5                	j	c2e <_ZN6Parser10parse_lineEPPcS0_+0xaa>
        switch (*s)
     db4:	03e00713          	li	a4,62
     db8:	04e78063          	beq	a5,a4,df8 <_ZN6Parser10parse_lineEPPcS0_+0x274>
     dbc:	04f76c63          	bltu	a4,a5,e14 <_ZN6Parser10parse_lineEPPcS0_+0x290>
     dc0:	fc57879b          	addiw	a5,a5,-59
     dc4:	0ff7f793          	zext.b	a5,a5
     dc8:	4705                	li	a4,1
     dca:	02f77d63          	bgeu	a4,a5,e04 <_ZN6Parser10parse_lineEPPcS0_+0x280>
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     dce:	fc9470e3          	bgeu	s0,s1,d8e <_ZN6Parser10parse_lineEPPcS0_+0x20a>
     dd2:	00044583          	lbu	a1,0(s0)
     dd6:	00093503          	ld	a0,0(s2)
     dda:	6ed040ef          	jal	5cc6 <strchr>
     dde:	f559                	bnez	a0,d6c <_ZN6Parser10parse_lineEPPcS0_+0x1e8>
     de0:	00044583          	lbu	a1,0(s0)
     de4:	00893503          	ld	a0,8(s2)
     de8:	6df040ef          	jal	5cc6 <strchr>
     dec:	f141                	bnez	a0,d6c <_ZN6Parser10parse_lineEPPcS0_+0x1e8>
                s++;
     dee:	0405                	addi	s0,s0,1
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     df0:	fe8491e3          	bne	s1,s0,dd2 <_ZN6Parser10parse_lineEPPcS0_+0x24e>
     df4:	8426                	mv	s0,s1
     df6:	bf61                	j	d8e <_ZN6Parser10parse_lineEPPcS0_+0x20a>
            if (*s == '>')
     df8:	00144703          	lbu	a4,1(s0)
     dfc:	03e00793          	li	a5,62
     e00:	02f70063          	beq	a4,a5,e20 <_ZN6Parser10parse_lineEPPcS0_+0x29c>
            s++;
     e04:	0405                	addi	s0,s0,1
     e06:	b79d                	j	d6c <_ZN6Parser10parse_lineEPPcS0_+0x1e8>
        switch (*s)
     e08:	02600713          	li	a4,38
     e0c:	fce791e3          	bne	a5,a4,dce <_ZN6Parser10parse_lineEPPcS0_+0x24a>
            s++;
     e10:	0405                	addi	s0,s0,1
     e12:	bfa9                	j	d6c <_ZN6Parser10parse_lineEPPcS0_+0x1e8>
        switch (*s)
     e14:	07c00713          	li	a4,124
     e18:	fae79be3          	bne	a5,a4,dce <_ZN6Parser10parse_lineEPPcS0_+0x24a>
            s++;
     e1c:	0405                	addi	s0,s0,1
     e1e:	b7b9                	j	d6c <_ZN6Parser10parse_lineEPPcS0_+0x1e8>
                s++;
     e20:	0409                	addi	s0,s0,2
     e22:	b7a9                	j	d6c <_ZN6Parser10parse_lineEPPcS0_+0x1e8>
        switch (*s)
     e24:	03c00713          	li	a4,60
     e28:	02f76463          	bltu	a4,a5,e50 <_ZN6Parser10parse_lineEPPcS0_+0x2cc>
     e2c:	03a00713          	li	a4,58
     e30:	fcf76ae3          	bltu	a4,a5,e04 <_ZN6Parser10parse_lineEPPcS0_+0x280>
     e34:	dfa9                	beqz	a5,d8e <_ZN6Parser10parse_lineEPPcS0_+0x20a>
     e36:	02600713          	li	a4,38
     e3a:	fce785e3          	beq	a5,a4,e04 <_ZN6Parser10parse_lineEPPcS0_+0x280>
     e3e:	fd87879b          	addiw	a5,a5,-40
     e42:	0ff7f793          	zext.b	a5,a5
     e46:	4705                	li	a4,1
     e48:	f4f763e3          	bltu	a4,a5,d8e <_ZN6Parser10parse_lineEPPcS0_+0x20a>
            s++;
     e4c:	0405                	addi	s0,s0,1
     e4e:	bf39                	j	d6c <_ZN6Parser10parse_lineEPPcS0_+0x1e8>
        switch (*s)
     e50:	03e00713          	li	a4,62
     e54:	fae782e3          	beq	a5,a4,df8 <_ZN6Parser10parse_lineEPPcS0_+0x274>
     e58:	07c00713          	li	a4,124
     e5c:	f2e799e3          	bne	a5,a4,d8e <_ZN6Parser10parse_lineEPPcS0_+0x20a>
     e60:	b755                	j	e04 <_ZN6Parser10parse_lineEPPcS0_+0x280>

0000000000000e62 <main>:

int main()
{
     e62:	7119                	addi	sp,sp,-128
    //         close(fd);
    //         break;
    //     }
    // }

    printf(ANSI_GREEN"\n[Lume Shell] Welcome! \n"ANSI_RESET);
     e64:	00005517          	auipc	a0,0x5
     e68:	26c50513          	addi	a0,a0,620 # 60d0 <_GLOBAL__sub_I__ZSt3cin+0xe0>
{
     e6c:	fc86                	sd	ra,120(sp)
     e6e:	f8a2                	sd	s0,112(sp)
     e70:	f4a6                	sd	s1,104(sp)
     e72:	f0ca                	sd	s2,96(sp)
     e74:	ecce                	sd	s3,88(sp)
     e76:	e8d2                	sd	s4,80(sp)
     e78:	e4d6                	sd	s5,72(sp)
     e7a:	e0da                	sd	s6,64(sp)
     e7c:	fc5e                	sd	s7,56(sp)
    printf(ANSI_GREEN"\n[Lume Shell] Welcome! \n"ANSI_RESET);
     e7e:	27d030ef          	jal	48fa <printf>
    printf(ANSI_YELLOW "[Lume Shell] Start your journey of exploration!"ANSI_RESET);
     e82:	00005517          	auipc	a0,0x5
     e86:	27650513          	addi	a0,a0,630 # 60f8 <_GLOBAL__sub_I__ZSt3cin+0x108>
     e8a:	271030ef          	jal	48fa <printf>
    printf("\n");
     e8e:	00005517          	auipc	a0,0x5
     e92:	2aa50513          	addi	a0,a0,682 # 6138 <_GLOBAL__sub_I__ZSt3cin+0x148>
     e96:	265030ef          	jal	48fa <printf>

    while (getcmd(buf, sizeof(buf)) >= 0)
     e9a:	00008417          	auipc	s0,0x8
     e9e:	e3640413          	addi	s0,s0,-458 # 8cd0 <_ZZ4mainE3buf>
    write(1, "$ ", 2);
     ea2:	00005497          	auipc	s1,0x5
     ea6:	22648493          	addi	s1,s1,550 # 60c8 <_GLOBAL__sub_I__ZSt3cin+0xd8>
    {
        int len = strlen(buf);
        if (len > 0 && buf[len - 1] == '\n')
     eaa:	4b29                	li	s6,10
            {
                printf("cannot cd %s\n", path);
            }
            continue;
        }
        if (strcmp(buf, "shutdown") == 0 || strcmp(buf, "poweroff") == 0)
     eac:	00005917          	auipc	s2,0x5
     eb0:	2bc90913          	addi	s2,s2,700 # 6168 <_GLOBAL__sub_I__ZSt3cin+0x178>
     eb4:	00005997          	auipc	s3,0x5
     eb8:	2ec98993          	addi	s3,s3,748 # 61a0 <_GLOBAL__sub_I__ZSt3cin+0x1b0>
    if (pid == -1)
     ebc:	5bfd                	li	s7,-1
        {
            printf(ANSI_BLUE"System shutting down..."ANSI_RESET);
     ebe:	00005a97          	auipc	s5,0x5
     ec2:	2baa8a93          	addi	s5,s5,698 # 6178 <_GLOBAL__sub_I__ZSt3cin+0x188>
            printf("\n");
     ec6:	00005a17          	auipc	s4,0x5
     eca:	272a0a13          	addi	s4,s4,626 # 6138 <_GLOBAL__sub_I__ZSt3cin+0x148>
    write(1, "$ ", 2);
     ece:	4609                	li	a2,2
     ed0:	85a6                	mv	a1,s1
     ed2:	4505                	li	a0,1
     ed4:	21c000ef          	jal	10f0 <write>
    memset(buf, 0, nbuf);
     ed8:	06400613          	li	a2,100
     edc:	4581                	li	a1,0
     ede:	8522                	mv	a0,s0
     ee0:	3f9040ef          	jal	5ad8 <memset>
    int n = read(0, buf, nbuf - 1);
     ee4:	06300613          	li	a2,99
     ee8:	85a2                	mv	a1,s0
     eea:	4501                	li	a0,0
     eec:	1fc000ef          	jal	10e8 <read>
    if (n < 0)
     ef0:	1a054b63          	bltz	a0,10a6 <main+0x244>
    buf[n] = 0;
     ef4:	00a407b3          	add	a5,s0,a0
     ef8:	00078023          	sb	zero,0(a5)
        int len = strlen(buf);
     efc:	8522                	mv	a0,s0
     efe:	473040ef          	jal	5b70 <strlen>
     f02:	2501                	sext.w	a0,a0
        if (len > 0 && buf[len - 1] == '\n')
     f04:	00a05a63          	blez	a0,f18 <main+0xb6>
     f08:	357d                	addiw	a0,a0,-1
     f0a:	9522                	add	a0,a0,s0
     f0c:	00054783          	lbu	a5,0(a0)
     f10:	01679463          	bne	a5,s6,f18 <main+0xb6>
            buf[len - 1] = 0;
     f14:	00050023          	sb	zero,0(a0)
        if (buf[0] == 'c' && buf[1] == 'd' && (buf[2] == ' ' || buf[2] == '\n' || buf[2] == 0))
     f18:	00044703          	lbu	a4,0(s0)
     f1c:	06300793          	li	a5,99
     f20:	00f71863          	bne	a4,a5,f30 <main+0xce>
     f24:	00144703          	lbu	a4,1(s0)
     f28:	06400793          	li	a5,100
     f2c:	02f70e63          	beq	a4,a5,f68 <main+0x106>
        if (strcmp(buf, "shutdown") == 0 || strcmp(buf, "poweroff") == 0)
     f30:	85ca                	mv	a1,s2
     f32:	8522                	mv	a0,s0
     f34:	513040ef          	jal	5c46 <strcmp>
     f38:	cd19                	beqz	a0,f56 <main+0xf4>
     f3a:	85ce                	mv	a1,s3
     f3c:	8522                	mv	a0,s0
     f3e:	509040ef          	jal	5c46 <strcmp>
     f42:	c911                	beqz	a0,f56 <main+0xf4>
    int pid = fork();
     f44:	18c000ef          	jal	10d0 <fork>
    if (pid == -1)
     f48:	0f750c63          	beq	a0,s7,1040 <main+0x1de>
            shutdown();

            continue;
        }

        if (fork_or_panic() == 0)
     f4c:	c52d                	beqz	a0,fb6 <main+0x154>
                cmd->run();
                delete cmd;
            }
            exit(0);
        }
        wait(0);
     f4e:	4501                	li	a0,0
     f50:	188000ef          	jal	10d8 <wait>
     f54:	bfad                	j	ece <main+0x6c>
            printf(ANSI_BLUE"System shutting down..."ANSI_RESET);
     f56:	8556                	mv	a0,s5
     f58:	1a3030ef          	jal	48fa <printf>
            printf("\n");
     f5c:	8552                	mv	a0,s4
     f5e:	19d030ef          	jal	48fa <printf>
            shutdown();
     f62:	226000ef          	jal	1188 <shutdown>
            continue;
     f66:	b7a5                	j	ece <main+0x6c>
        if (buf[0] == 'c' && buf[1] == 'd' && (buf[2] == ' ' || buf[2] == '\n' || buf[2] == 0))
     f68:	00244703          	lbu	a4,2(s0)
     f6c:	02000793          	li	a5,32
     f70:	fce7e0e3          	bltu	a5,a4,f30 <main+0xce>
     f74:	4785                	li	a5,1
     f76:	1782                	slli	a5,a5,0x20
     f78:	40178793          	addi	a5,a5,1025
     f7c:	00e7d7b3          	srl	a5,a5,a4
     f80:	8b85                	andi	a5,a5,1
     f82:	d7dd                	beqz	a5,f30 <main+0xce>
            if (buf[strlen(buf) - 1] == '\n')
     f84:	00008517          	auipc	a0,0x8
     f88:	d4c50513          	addi	a0,a0,-692 # 8cd0 <_ZZ4mainE3buf>
     f8c:	3e5040ef          	jal	5b70 <strlen>
     f90:	9522                	add	a0,a0,s0
     f92:	fff54703          	lbu	a4,-1(a0)
     f96:	47a9                	li	a5,10
     f98:	0ef70c63          	beq	a4,a5,1090 <main+0x22e>
            if (buf[2] == '\n' || buf[2] == 0)
     f9c:	00244783          	lbu	a5,2(s0)
     fa0:	4729                	li	a4,10
     fa2:	00e78363          	beq	a5,a4,fa8 <main+0x146>
     fa6:	e3f1                	bnez	a5,106a <main+0x208>
                printf("cd: argument missing\n");
     fa8:	00005517          	auipc	a0,0x5
     fac:	19850513          	addi	a0,a0,408 # 6140 <_GLOBAL__sub_I__ZSt3cin+0x150>
     fb0:	14b030ef          	jal	48fa <printf>
                continue;
     fb4:	bf29                	j	ece <main+0x6c>
        char *es = s + strlen(s);
     fb6:	00008517          	auipc	a0,0x8
     fba:	d1a50513          	addi	a0,a0,-742 # 8cd0 <_ZZ4mainE3buf>
     fbe:	f862                	sd	s8,48(sp)
     fc0:	f466                	sd	s9,40(sp)
     fc2:	ec6e                	sd	s11,24(sp)
     fc4:	e422                	sd	s0,8(sp)
     fc6:	3ab040ef          	jal	5b70 <strlen>
     fca:	00a40cb3          	add	s9,s0,a0
        Command *cmd = parse_line(&s, es);
     fce:	85e6                	mv	a1,s9
     fd0:	0028                	addi	a0,sp,8
     fd2:	bb3ff0ef          	jal	b84 <_ZN6Parser10parse_lineEPPcS0_>
        char *s = *ps;
     fd6:	6c22                	ld	s8,8(sp)
        Command *cmd = parse_line(&s, es);
     fd8:	8daa                	mv	s11,a0
        while (s < es && strchr(WHITESPACE, *s))
     fda:	039c7363          	bgeu	s8,s9,1000 <main+0x19e>
     fde:	f06a                	sd	s10,32(sp)
     fe0:	00007d17          	auipc	s10,0x7
     fe4:	f28d0d13          	addi	s10,s10,-216 # 7f08 <WHITESPACE>
     fe8:	a021                	j	ff0 <main+0x18e>
            s++;
     fea:	0c05                	addi	s8,s8,1
        while (s < es && strchr(WHITESPACE, *s))
     fec:	018c8963          	beq	s9,s8,ffe <main+0x19c>
     ff0:	000c4583          	lbu	a1,0(s8)
     ff4:	000d3503          	ld	a0,0(s10)
     ff8:	4cf040ef          	jal	5cc6 <strchr>
     ffc:	f57d                	bnez	a0,fea <main+0x188>
     ffe:	7d02                	ld	s10,32(sp)
        *ps = s;
    1000:	e462                	sd	s8,8(sp)
        return *s && strchr(toks, *s);
    1002:	000c4583          	lbu	a1,0(s8)
    1006:	e9b9                	bnez	a1,105c <main+0x1fa>
        if (s != es)
    1008:	65a2                	ld	a1,8(sp)
    100a:	00bc8863          	beq	s9,a1,101a <main+0x1b8>
            printf("leftovers: %s\n", s);
    100e:	00005517          	auipc	a0,0x5
    1012:	1a250513          	addi	a0,a0,418 # 61b0 <_GLOBAL__sub_I__ZSt3cin+0x1c0>
    1016:	0e5030ef          	jal	48fa <printf>
            if (cmd)
    101a:	000d8c63          	beqz	s11,1032 <main+0x1d0>
                cmd->run();
    101e:	000db783          	ld	a5,0(s11)
    1022:	856e                	mv	a0,s11
    1024:	6b9c                	ld	a5,16(a5)
    1026:	9782                	jalr	a5
                delete cmd;
    1028:	000db783          	ld	a5,0(s11)
    102c:	856e                	mv	a0,s11
    102e:	679c                	ld	a5,8(a5)
    1030:	9782                	jalr	a5
            exit(0);
    1032:	4501                	li	a0,0
    1034:	3da040ef          	jal	540e <exit>
    1038:	7c42                	ld	s8,48(sp)
    103a:	7ca2                	ld	s9,40(sp)
    103c:	6de2                	ld	s11,24(sp)
    103e:	bf01                	j	f4e <main+0xec>
    printf("shell panic: %s\n", s);
    1040:	00005597          	auipc	a1,0x5
    1044:	00058593          	mv	a1,a1
    1048:	00005517          	auipc	a0,0x5
    104c:	00050513          	mv	a0,a0
    1050:	0ab030ef          	jal	48fa <printf>
    exit(1);
    1054:	4505                	li	a0,1
    1056:	3b8040ef          	jal	540e <exit>
    return pid;
    105a:	bdd5                	j	f4e <main+0xec>
        return *s && strchr(toks, *s);
    105c:	00005517          	auipc	a0,0x5
    1060:	ffc50513          	addi	a0,a0,-4 # 6058 <_GLOBAL__sub_I__ZSt3cin+0x68>
    1064:	463040ef          	jal	5cc6 <strchr>
    1068:	b745                	j	1008 <main+0x1a6>
            if (chdir(path) < 0)
    106a:	00008517          	auipc	a0,0x8
    106e:	c6950513          	addi	a0,a0,-919 # 8cd3 <_ZZ4mainE3buf+0x3>
    1072:	0ce000ef          	jal	1140 <chdir>
    1076:	e4055ce3          	bgez	a0,ece <main+0x6c>
                printf("cannot cd %s\n", path);
    107a:	00008597          	auipc	a1,0x8
    107e:	c5958593          	addi	a1,a1,-935 # 8cd3 <_ZZ4mainE3buf+0x3>
    1082:	00005517          	auipc	a0,0x5
    1086:	0d650513          	addi	a0,a0,214 # 6158 <_GLOBAL__sub_I__ZSt3cin+0x168>
    108a:	071030ef          	jal	48fa <printf>
    108e:	b581                	j	ece <main+0x6c>
                buf[strlen(buf) - 1] = 0;
    1090:	00008517          	auipc	a0,0x8
    1094:	c4050513          	addi	a0,a0,-960 # 8cd0 <_ZZ4mainE3buf>
    1098:	2d9040ef          	jal	5b70 <strlen>
    109c:	00a407b3          	add	a5,s0,a0
    10a0:	fe078fa3          	sb	zero,-1(a5)
    10a4:	bde5                	j	f9c <main+0x13a>
    }
    return 0;
    10a6:	70e6                	ld	ra,120(sp)
    10a8:	7446                	ld	s0,112(sp)
    10aa:	74a6                	ld	s1,104(sp)
    10ac:	7906                	ld	s2,96(sp)
    10ae:	69e6                	ld	s3,88(sp)
    10b0:	6a46                	ld	s4,80(sp)
    10b2:	6aa6                	ld	s5,72(sp)
    10b4:	6b06                	ld	s6,64(sp)
    10b6:	7be2                	ld	s7,56(sp)
    10b8:	4501                	li	a0,0
    10ba:	6109                	addi	sp,sp,128
    10bc:	8082                	ret

00000000000010be <_start>:
.global _start

_start:


    call main
    10be:	da5ff0ef          	jal	e62 <main>

    call exit
    10c2:	34c040ef          	jal	540e <exit>

    10c6:	a001                	j	10c6 <_start+0x8>

00000000000010c8 <sys_exit>:
    name: \
        li a7, SYS_ ## sysname; \
        ecall; \
        ret

SYSCALL_NAME(sys_exit, exit) 
    10c8:	488d                	li	a7,3
    10ca:	00000073          	ecall
    10ce:	8082                	ret

00000000000010d0 <fork>:

SYSCALL(fork)
    10d0:	4889                	li	a7,2
    10d2:	00000073          	ecall
    10d6:	8082                	ret

00000000000010d8 <wait>:
SYSCALL(wait)
    10d8:	4891                	li	a7,4
    10da:	00000073          	ecall
    10de:	8082                	ret

00000000000010e0 <pipe>:
SYSCALL(pipe)
    10e0:	4895                	li	a7,5
    10e2:	00000073          	ecall
    10e6:	8082                	ret

00000000000010e8 <read>:
SYSCALL(read)
    10e8:	4899                	li	a7,6
    10ea:	00000073          	ecall
    10ee:	8082                	ret

00000000000010f0 <write>:
SYSCALL(write)
    10f0:	48c5                	li	a7,17
    10f2:	00000073          	ecall
    10f6:	8082                	ret

00000000000010f8 <close>:
SYSCALL(close)
    10f8:	48d9                	li	a7,22
    10fa:	00000073          	ecall
    10fe:	8082                	ret

0000000000001100 <kill>:
SYSCALL(kill)
    1100:	489d                	li	a7,7
    1102:	00000073          	ecall
    1106:	8082                	ret

0000000000001108 <exec>:
SYSCALL(exec)
    1108:	48a1                	li	a7,8
    110a:	00000073          	ecall
    110e:	8082                	ret

0000000000001110 <open>:
SYSCALL(open)
    1110:	48c1                	li	a7,16
    1112:	00000073          	ecall
    1116:	8082                	ret

0000000000001118 <mknod>:
SYSCALL(mknod)
    1118:	48c9                	li	a7,18
    111a:	00000073          	ecall
    111e:	8082                	ret

0000000000001120 <unlink>:
SYSCALL(unlink)
    1120:	48cd                	li	a7,19
    1122:	00000073          	ecall
    1126:	8082                	ret

0000000000001128 <fstat>:
SYSCALL(fstat)
    1128:	48a5                	li	a7,9
    112a:	00000073          	ecall
    112e:	8082                	ret

0000000000001130 <link>:
SYSCALL(link)
    1130:	48d1                	li	a7,20
    1132:	00000073          	ecall
    1136:	8082                	ret

0000000000001138 <mkdir>:
SYSCALL(mkdir)
    1138:	48d5                	li	a7,21
    113a:	00000073          	ecall
    113e:	8082                	ret

0000000000001140 <chdir>:
SYSCALL(chdir)
    1140:	48a9                	li	a7,10
    1142:	00000073          	ecall
    1146:	8082                	ret

0000000000001148 <dup>:
SYSCALL(dup)
    1148:	48ad                	li	a7,11
    114a:	00000073          	ecall
    114e:	8082                	ret

0000000000001150 <getpid>:
SYSCALL(getpid)
    1150:	48b1                	li	a7,12
    1152:	00000073          	ecall
    1156:	8082                	ret

0000000000001158 <sbrk>:
SYSCALL(sbrk)
    1158:	48b5                	li	a7,13
    115a:	00000073          	ecall
    115e:	8082                	ret

0000000000001160 <sleep>:
SYSCALL(sleep)
    1160:	48b9                	li	a7,14
    1162:	00000073          	ecall
    1166:	8082                	ret

0000000000001168 <uptime>:
SYSCALL(uptime)
    1168:	48bd                	li	a7,15
    116a:	00000073          	ecall
    116e:	8082                	ret

0000000000001170 <putc>:
SYSCALL(putc)
    1170:	4885                	li	a7,1
    1172:	00000073          	ecall
    1176:	8082                	ret

0000000000001178 <disk_test>:
SYSCALL(disk_test)
    1178:	48dd                	li	a7,23
    117a:	00000073          	ecall
    117e:	8082                	ret

0000000000001180 <lseek>:
SYSCALL(lseek)
    1180:	48e1                	li	a7,24
    1182:	00000073          	ecall
    1186:	8082                	ret

0000000000001188 <shutdown>:
    1188:	48e5                	li	a7,25
    118a:	00000073          	ecall
    118e:	8082                	ret

0000000000001190 <stbsp__clamp_callback>:
    1190:	45dc                	lw	a5,12(a1)
    1192:	4598                	lw	a4,8(a1)
    1194:	9fb1                	addw	a5,a5,a2
    1196:	c5dc                	sw	a5,12(a1)
    1198:	0007069b          	sext.w	a3,a4
    119c:	00e65463          	bge	a2,a4,11a4 <stbsp__clamp_callback+0x14>
    11a0:	0006069b          	sext.w	a3,a2
    11a4:	c685                	beqz	a3,11cc <stbsp__clamp_callback+0x3c>
    11a6:	619c                	ld	a5,0(a1)
    11a8:	00a78e63          	beq	a5,a0,11c4 <stbsp__clamp_callback+0x34>
    11ac:	00d50633          	add	a2,a0,a3
    11b0:	00054703          	lbu	a4,0(a0)
    11b4:	0505                	addi	a0,a0,1
    11b6:	0785                	addi	a5,a5,1
    11b8:	fee78fa3          	sb	a4,-1(a5)
    11bc:	fec56ae3          	bltu	a0,a2,11b0 <stbsp__clamp_callback+0x20>
    11c0:	6188                	ld	a0,0(a1)
    11c2:	4598                	lw	a4,8(a1)
    11c4:	9f15                	subw	a4,a4,a3
    11c6:	9536                	add	a0,a0,a3
    11c8:	e188                	sd	a0,0(a1)
    11ca:	c598                	sw	a4,8(a1)
    11cc:	1ff00793          	li	a5,511
    11d0:	00e7d463          	bge	a5,a4,11d8 <stbsp__clamp_callback+0x48>
    11d4:	6188                	ld	a0,0(a1)
    11d6:	8082                	ret
    11d8:	01058513          	addi	a0,a1,16
    11dc:	8082                	ret

00000000000011de <stbsp__count_clamp_callback>:
    11de:	45dc                	lw	a5,12(a1)
    11e0:	01058513          	addi	a0,a1,16
    11e4:	9fb1                	addw	a5,a5,a2
    11e6:	c5dc                	sw	a5,12(a1)
    11e8:	8082                	ret

00000000000011ea <stbsp__real_to_str>:
    11ea:	e20508d3          	fmv.x.d	a7,fa0
    11ee:	82aa                	mv	t0,a0
    11f0:	4348d813          	srai	a6,a7,0x34
    11f4:	8ec6                	mv	t4,a7
    11f6:	7ff87813          	andi	a6,a6,2047
    11fa:	8346                	mv	t1,a7
    11fc:	03f8d513          	srli	a0,a7,0x3f
    1200:	0008d663          	bgez	a7,120c <stbsp__real_to_str+0x22>
    1204:	22a517d3          	fneg.d	fa5,fa0
    1208:	e20788d3          	fmv.x.d	a7,fa5
    120c:	7ff00e13          	li	t3,2047
    1210:	35c80663          	beq	a6,t3,155c <stbsp__real_to_str+0x372>
    1214:	1101                	addi	sp,sp,-32
    1216:	14080363          	beqz	a6,135c <stbsp__real_to_str+0x172>
    121a:	c018081b          	addiw	a6,a6,-1023
    121e:	ec22                	sd	s0,24(sp)
    1220:	02081313          	slli	t1,a6,0x20
    1224:	66034d63          	bltz	t1,189e <stbsp__real_to_str+0x6b4>
    1228:	4d100313          	li	t1,1233
    122c:	0303033b          	mulw	t1,t1,a6
    1230:	4849                	li	a6,18
    1232:	40c3531b          	sraiw	t1,t1,0xc
    1236:	0013039b          	addiw	t2,t1,1
    123a:	4078083b          	subw	a6,a6,t2
    123e:	4359                	li	t1,22
    1240:	17036163          	bltu	t1,a6,13a2 <stbsp__real_to_str+0x1b8>
    1244:	00005317          	auipc	t1,0x5
    1248:	2c430313          	addi	t1,t1,708 # 6508 <stbsp__bot>
    124c:	080e                	slli	a6,a6,0x3
    124e:	981a                	add	a6,a6,t1
    1250:	00083e03          	ld	t3,0(a6)
    1254:	00083607          	fld	fa2,0(a6)
    1258:	f20887d3          	fmv.d.x	fa5,a7
    125c:	f8000837          	lui	a6,0xf8000
    1260:	01187333          	and	t1,a6,a7
    1264:	01c87833          	and	a6,a6,t3
    1268:	12f676d3          	fmul.d	fa3,fa2,fa5
    126c:	f20807d3          	fmv.d.x	fa5,a6
    1270:	f2030753          	fmv.d.x	fa4,t1
    1274:	f20305d3          	fmv.d.x	fa1,t1
    1278:	0af67653          	fsub.d	fa2,fa2,fa5
    127c:	f20887d3          	fmv.d.x	fa5,a7
    1280:	0ae7f753          	fsub.d	fa4,fa5,fa4
    1284:	f20807d3          	fmv.d.x	fa5,a6
    1288:	6ab7f7c7          	fmsub.d	fa5,fa5,fa1,fa3
    128c:	7ab677c3          	fmadd.d	fa5,fa2,fa1,fa5
    1290:	f20805d3          	fmv.d.x	fa1,a6
    1294:	7ab777c3          	fmadd.d	fa5,fa4,fa1,fa5
    1298:	7ac77743          	fmadd.d	fa4,fa4,fa2,fa5
    129c:	02d777d3          	fadd.d	fa5,fa4,fa3
    12a0:	3782e837          	lui	a6,0x3782e
    12a4:	acf80813          	addi	a6,a6,-1329 # 3782dacf <_ZSt4cerr+0x37824c5f>
    12a8:	0832                	slli	a6,a6,0xc
    12aa:	9d980813          	addi	a6,a6,-1575
    12ae:	084a                	slli	a6,a6,0x12
    12b0:	187d                	addi	a6,a6,-1
    12b2:	c22798d3          	fcvt.l.d	a7,fa5,rtz
    12b6:	0ad7f6d3          	fsub.d	fa3,fa5,fa3
    12ba:	00070e1b          	sext.w	t3,a4
    12be:	d228f653          	fcvt.d.l	fa2,a7
    12c2:	0ac7f5d3          	fsub.d	fa1,fa5,fa2
    12c6:	0ad77753          	fsub.d	fa4,fa4,fa3
    12ca:	0af5f6d3          	fsub.d	fa3,fa1,fa5
    12ce:	0ad5f553          	fsub.d	fa0,fa1,fa3
    12d2:	02d67653          	fadd.d	fa2,fa2,fa3
    12d6:	0aa7f7d3          	fsub.d	fa5,fa5,fa0
    12da:	0ac7f7d3          	fsub.d	fa5,fa5,fa2
    12de:	02b7f7d3          	fadd.d	fa5,fa5,fa1
    12e2:	02e7f7d3          	fadd.d	fa5,fa5,fa4
    12e6:	c2279fd3          	fcvt.l.d	t6,fa5,rtz
    12ea:	9fc6                	add	t6,t6,a7
    12ec:	19f87063          	bgeu	a6,t6,146c <stbsp__real_to_str+0x282>
    12f0:	2385                	addiw	t2,t2,1
    12f2:	300e4363          	bltz	t3,15f8 <stbsp__real_to_str+0x40e>
    12f6:	00e3833b          	addw	t1,t2,a4
    12fa:	475d                	li	a4,23
    12fc:	30677663          	bgeu	a4,t1,1608 <stbsp__real_to_str+0x41e>
    1300:	577d                	li	a4,-1
    1302:	9301                	srli	a4,a4,0x20
    1304:	43f75863          	bge	a4,t6,1734 <stbsp__real_to_str+0x54a>
    1308:	07d00313          	li	t1,125
    130c:	877e                	mv	a4,t6
    130e:	4e01                	li	t3,0
    1310:	3e800813          	li	a6,1000
    1314:	130e                	slli	t1,t1,0x23
    1316:	a039                	j	1324 <stbsp__real_to_str+0x13a>
    1318:	030747b3          	div	a5,a4,a6
    131c:	4e05                	li	t3,1
    131e:	40674c63          	blt	a4,t1,1736 <stbsp__real_to_str+0x54c>
    1322:	873e                	mv	a4,a5
    1324:	030768b3          	rem	a7,a4,a6
    1328:	fe0888e3          	beqz	a7,1318 <stbsp__real_to_str+0x12e>
    132c:	400e0163          	beqz	t3,172e <stbsp__real_to_str+0x544>
    1330:	8fbe                	mv	t6,a5
    1332:	05f5e7b7          	lui	a5,0x5f5e
    1336:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f5528f>
    133a:	04060413          	addi	s0,a2,64
    133e:	03860613          	addi	a2,a2,56
    1342:	15f7c863          	blt	a5,t6,1492 <stbsp__real_to_str+0x2a8>
    1346:	000f871b          	sext.w	a4,t6
    134a:	20070463          	beqz	a4,1552 <stbsp__real_to_str+0x368>
    134e:	4f01                	li	t5,0
    1350:	4f81                	li	t6,0
    1352:	00007e97          	auipc	t4,0x7
    1356:	bc6e8e93          	addi	t4,t4,-1082 # 7f18 <stbsp__digitpair>
    135a:	aaa9                	j	14b4 <stbsp__real_to_str+0x2ca>
    135c:	0306                	slli	t1,t1,0x1
    135e:	3e030e63          	beqz	t1,175a <stbsp__real_to_str+0x570>
    1362:	4305                	li	t1,1
    1364:	ec22                	sd	s0,24(sp)
    1366:	00ce9e13          	slli	t3,t4,0xc
    136a:	134e                	slli	t1,t1,0x33
    136c:	520e4063          	bltz	t3,188c <stbsp__real_to_str+0x6a2>
    1370:	40135313          	srai	t1,t1,0x1
    1374:	01d37e33          	and	t3,t1,t4
    1378:	8f42                	mv	t5,a6
    137a:	387d                	addiw	a6,a6,-1
    137c:	fe0e0ae3          	beqz	t3,1370 <stbsp__real_to_str+0x186>
    1380:	26900313          	li	t1,617
    1384:	c00f081b          	addiw	a6,t5,-1024
    1388:	0268083b          	mulw	a6,a6,t1
    138c:	41f8531b          	sraiw	t1,a6,0x1f
    1390:	0153531b          	srliw	t1,t1,0x15
    1394:	0103033b          	addw	t1,t1,a6
    1398:	40b3539b          	sraiw	t2,t1,0xb
    139c:	4849                	li	a6,18
    139e:	4078083b          	subw	a6,a6,t2
    13a2:	41f8531b          	sraiw	t1,a6,0x1f
    13a6:	00684eb3          	xor	t4,a6,t1
    13aa:	406e8f3b          	subw	t5,t4,t1
    13ae:	2c900313          	li	t1,713
    13b2:	03e3033b          	mulw	t1,t1,t5
    13b6:	4e35                	li	t3,13
    13b8:	8efa                	mv	t4,t5
    13ba:	40e35f9b          	sraiw	t6,t1,0xe
    13be:	837e                	mv	t1,t6
    13c0:	23fe4363          	blt	t3,t6,15e6 <stbsp__real_to_str+0x3fc>
    13c4:	5e25                	li	t3,-23
    13c6:	026e0e3b          	mulw	t3,t3,t1
    13ca:	01de0ebb          	addw	t4,t3,t4
    13ce:	22084f63          	bltz	a6,160c <stbsp__real_to_str+0x422>
    13d2:	f2000753          	fmv.d.x	fa4,zero
    13d6:	00005e17          	auipc	t3,0x5
    13da:	132e0e13          	addi	t3,t3,306 # 6508 <stbsp__bot>
    13de:	380e9e63          	bnez	t4,177a <stbsp__real_to_str+0x590>
    13e2:	f20887d3          	fmv.d.x	fa5,a7
    13e6:	fff30f1b          	addiw	t5,t1,-1
    13ea:	0f0e                	slli	t5,t5,0x3
    13ec:	02f777d3          	fadd.d	fa5,fa4,fa5
    13f0:	030e                	slli	t1,t1,0x3
    13f2:	9f72                	add	t5,t5,t3
    13f4:	9e1a                	add	t3,t3,t1
    13f6:	2e0e3e03          	ld	t3,736(t3)
    13fa:	2e8f3587          	fld	fa1,744(t5)
    13fe:	f8000837          	lui	a6,0xf8000
    1402:	e2078ed3          	fmv.x.d	t4,fa5
    1406:	12b7f6d3          	fmul.d	fa3,fa5,fa1
    140a:	f2088653          	fmv.d.x	fa2,a7
    140e:	01d87333          	and	t1,a6,t4
    1412:	01c87833          	and	a6,a6,t3
    1416:	f20807d3          	fmv.d.x	fa5,a6
    141a:	f2030053          	fmv.d.x	ft0,t1
    141e:	0af5f553          	fsub.d	fa0,fa1,fa5
    1422:	f20e87d3          	fmv.d.x	fa5,t4
    1426:	0ac7f0d3          	fsub.d	ft1,fa5,fa2
    142a:	f20807d3          	fmv.d.x	fa5,a6
    142e:	f2030653          	fmv.d.x	fa2,t1
    1432:	6ac7f647          	fmsub.d	fa2,fa5,fa2,fa3
    1436:	f20e87d3          	fmv.d.x	fa5,t4
    143a:	0a177753          	fsub.d	fa4,fa4,ft1
    143e:	f20300d3          	fmv.d.x	ft1,t1
    1442:	0a07f7d3          	fsub.d	fa5,fa5,ft0
    1446:	350f3007          	fld	ft0,848(t5)
    144a:	62157643          	fmadd.d	fa2,fa0,ft1,fa2
    144e:	12b77753          	fmul.d	fa4,fa4,fa1
    1452:	f20805d3          	fmv.d.x	fa1,a6
    1456:	62b7f643          	fmadd.d	fa2,fa5,fa1,fa2
    145a:	f20e85d3          	fmv.d.x	fa1,t4
    145e:	7205f743          	fmadd.d	fa4,fa1,ft0,fa4
    1462:	62a7f7c3          	fmadd.d	fa5,fa5,fa0,fa2
    1466:	02e7f753          	fadd.d	fa4,fa5,fa4
    146a:	bd0d                	j	129c <stbsp__real_to_str+0xb2>
    146c:	00e3833b          	addw	t1,t2,a4
    1470:	2a0e4663          	bltz	t3,171c <stbsp__real_to_str+0x532>
    1474:	475d                	li	a4,23
    1476:	10677663          	bgeu	a4,t1,1582 <stbsp__real_to_str+0x398>
    147a:	e80f93e3          	bnez	t6,1300 <stbsp__real_to_str+0x116>
    147e:	05f5e7b7          	lui	a5,0x5f5e
    1482:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f5528f>
    1486:	04060413          	addi	s0,a2,64
    148a:	03860613          	addi	a2,a2,56
    148e:	ebf7dce3          	bge	a5,t6,1346 <stbsp__real_to_str+0x15c>
    1492:	4f01                	li	t5,0
    1494:	00007e97          	auipc	t4,0x7
    1498:	a84e8e93          	addi	t4,t4,-1404 # 7f18 <stbsp__digitpair>
    149c:	05f5e7b7          	lui	a5,0x5f5e
    14a0:	10078793          	addi	a5,a5,256 # 5f5e100 <_ZSt4cerr+0x5f55290>
    14a4:	02ffe833          	rem	a6,t6,a5
    14a8:	02ffcfb3          	div	t6,t6,a5
    14ac:	0008071b          	sext.w	a4,a6
    14b0:	0a080463          	beqz	a6,1558 <stbsp__real_to_str+0x36e>
    14b4:	8822                	mv	a6,s0
    14b6:	06400893          	li	a7,100
    14ba:	06300e13          	li	t3,99
    14be:	1879                	addi	a6,a6,-2 # fffffffff7fffffe <_ZSt4cerr+0xfffffffff7ff718e>
    14c0:	0007031b          	sext.w	t1,a4
    14c4:	031777bb          	remuw	a5,a4,a7
    14c8:	2785                	addiw	a5,a5,1
    14ca:	0017979b          	slliw	a5,a5,0x1
    14ce:	1782                	slli	a5,a5,0x20
    14d0:	9381                	srli	a5,a5,0x20
    14d2:	97f6                	add	a5,a5,t4
    14d4:	0007d783          	lhu	a5,0(a5)
    14d8:	0317573b          	divuw	a4,a4,a7
    14dc:	00f81023          	sh	a5,0(a6)
    14e0:	fc6e6fe3          	bltu	t3,t1,14be <stbsp__real_to_str+0x2d4>
    14e4:	008f0f3b          	addw	t5,t5,s0
    14e8:	410f0f3b          	subw	t5,t5,a6
    14ec:	020f8f63          	beqz	t6,152a <stbsp__real_to_str+0x340>
    14f0:	87c2                	mv	a5,a6
    14f2:	03000713          	li	a4,48
    14f6:	04c80c63          	beq	a6,a2,154e <stbsp__real_to_str+0x364>
    14fa:	17fd                	addi	a5,a5,-1
    14fc:	00e78023          	sb	a4,0(a5)
    1500:	fec79de3          	bne	a5,a2,14fa <stbsp__real_to_str+0x310>
    1504:	408807b3          	sub	a5,a6,s0
    1508:	00ff07bb          	addw	a5,t5,a5
    150c:	1461                	addi	s0,s0,-8
    150e:	00878f1b          	addiw	t5,a5,8
    1512:	05f5e7b7          	lui	a5,0x5f5e
    1516:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f5528f>
    151a:	ff840613          	addi	a2,s0,-8
    151e:	f7f7cfe3          	blt	a5,t6,149c <stbsp__real_to_str+0x2b2>
    1522:	000f871b          	sext.w	a4,t6
    1526:	4f81                	li	t6,0
    1528:	b771                	j	14b4 <stbsp__real_to_str+0x2ca>
    152a:	020f0563          	beqz	t5,1554 <stbsp__real_to_str+0x36a>
    152e:	00084703          	lbu	a4,0(a6)
    1532:	03000793          	li	a5,48
    1536:	22f70f63          	beq	a4,a5,1774 <stbsp__real_to_str+0x58a>
    153a:	2f01                	sext.w	t5,t5
    153c:	0076a023          	sw	t2,0(a3)
    1540:	6462                	ld	s0,24(sp)
    1542:	0102b023          	sd	a6,0(t0)
    1546:	01e5a023          	sw	t5,0(a1)
    154a:	6105                	addi	sp,sp,32
    154c:	8082                	ret
    154e:	8442                	mv	s0,a6
    1550:	b7c9                	j	1512 <stbsp__real_to_str+0x328>
    1552:	8822                	mv	a6,s0
    1554:	4f01                	li	t5,0
    1556:	b7dd                	j	153c <stbsp__real_to_str+0x352>
    1558:	8822                	mv	a6,s0
    155a:	bf59                	j	14f0 <stbsp__real_to_str+0x306>
    155c:	0eb2                	slli	t4,t4,0xc
    155e:	00005797          	auipc	a5,0x5
    1562:	c7a78793          	addi	a5,a5,-902 # 61d8 <_GLOBAL__sub_I__ZSt3cin+0x1e8>
    1566:	000e8663          	beqz	t4,1572 <stbsp__real_to_str+0x388>
    156a:	00005797          	auipc	a5,0x5
    156e:	c6678793          	addi	a5,a5,-922 # 61d0 <_GLOBAL__sub_I__ZSt3cin+0x1e0>
    1572:	00f2b023          	sd	a5,0(t0)
    1576:	679d                	lui	a5,0x7
    1578:	c29c                	sw	a5,0(a3)
    157a:	4f0d                	li	t5,3
    157c:	01e5a023          	sw	t5,0(a1)
    1580:	8082                	ret
    1582:	3b9ad737          	lui	a4,0x3b9ad
    1586:	9ff70713          	addi	a4,a4,-1537 # 3b9ac9ff <_ZSt4cerr+0x3b9a3b8f>
    158a:	07f76f63          	bltu	a4,t6,1608 <stbsp__real_to_str+0x41e>
    158e:	4805                	li	a6,1
    1590:	02081713          	slli	a4,a6,0x20
    1594:	01d75893          	srli	a7,a4,0x1d
    1598:	00005717          	auipc	a4,0x5
    159c:	32870713          	addi	a4,a4,808 # 68c0 <stbsp__powten>
    15a0:	9746                	add	a4,a4,a7
    15a2:	4e51                	li	t3,20
    15a4:	a021                	j	15ac <stbsp__real_to_str+0x3c2>
    15a6:	2805                	addiw	a6,a6,1
    15a8:	edc809e3          	beq	a6,t3,147a <stbsp__real_to_str+0x290>
    15ac:	00073883          	ld	a7,0(a4)
    15b0:	0721                	addi	a4,a4,8
    15b2:	ff1ffae3          	bgeu	t6,a7,15a6 <stbsp__real_to_str+0x3bc>
    15b6:	ed0372e3          	bgeu	t1,a6,147a <stbsp__real_to_str+0x290>
    15ba:	4068083b          	subw	a6,a6,t1
    15be:	475d                	li	a4,23
    15c0:	eb076de3          	bltu	a4,a6,147a <stbsp__real_to_str+0x290>
    15c4:	080e                	slli	a6,a6,0x3
    15c6:	00005717          	auipc	a4,0x5
    15ca:	f4270713          	addi	a4,a4,-190 # 6508 <stbsp__bot>
    15ce:	9742                	add	a4,a4,a6
    15d0:	3b873803          	ld	a6,952(a4)
    15d4:	00185713          	srli	a4,a6,0x1
    15d8:	977e                	add	a4,a4,t6
    15da:	01176363          	bltu	a4,a7,15e0 <stbsp__real_to_str+0x3f6>
    15de:	2385                	addiw	t2,t2,1
    15e0:	03075fb3          	divu	t6,a4,a6
    15e4:	bd59                	j	147a <stbsp__real_to_str+0x290>
    15e6:	4335                	li	t1,13
    15e8:	5e25                	li	t3,-23
    15ea:	026e0e3b          	mulw	t3,t3,t1
    15ee:	01de0ebb          	addw	t4,t3,t4
    15f2:	de0850e3          	bgez	a6,13d2 <stbsp__real_to_str+0x1e8>
    15f6:	a819                	j	160c <stbsp__real_to_str+0x422>
    15f8:	02571313          	slli	t1,a4,0x25
    15fc:	02535313          	srli	t1,t1,0x25
    1600:	0305                	addi	t1,t1,1
    1602:	475d                	li	a4,23
    1604:	ce676ee3          	bltu	a4,t1,1300 <stbsp__real_to_str+0x116>
    1608:	4829                	li	a6,10
    160a:	b759                	j	1590 <stbsp__real_to_str+0x3a6>
    160c:	260e8663          	beqz	t4,1878 <stbsp__real_to_str+0x68e>
    1610:	00231e13          	slli	t3,t1,0x2
    1614:	41c30e33          	sub	t3,t1,t3
    1618:	0e0e                	slli	t3,t3,0x3
    161a:	9e1a                	add	t3,t3,t1
    161c:	fffe881b          	addiw	a6,t4,-1
    1620:	9e7a                	add	t3,t3,t5
    1622:	00005e97          	auipc	t4,0x5
    1626:	ee6e8e93          	addi	t4,t4,-282 # 6508 <stbsp__bot>
    162a:	0e0e                	slli	t3,t3,0x3
    162c:	080e                	slli	a6,a6,0x3
    162e:	9876                	add	a6,a6,t4
    1630:	9ef2                	add	t4,t4,t3
    1632:	0b883607          	fld	fa2,184(a6)
    1636:	f20887d3          	fmv.d.x	fa5,a7
    163a:	0b0ebf03          	ld	t5,176(t4)
    163e:	f8000e37          	lui	t3,0xf8000
    1642:	011e7eb3          	and	t4,t3,a7
    1646:	12f676d3          	fmul.d	fa3,fa2,fa5
    164a:	01ee7e33          	and	t3,t3,t5
    164e:	f20e07d3          	fmv.d.x	fa5,t3
    1652:	f20e0753          	fmv.d.x	fa4,t3
    1656:	f20e8553          	fmv.d.x	fa0,t4
    165a:	0af67653          	fsub.d	fa2,fa2,fa5
    165e:	f20e87d3          	fmv.d.x	fa5,t4
    1662:	f20e85d3          	fmv.d.x	fa1,t4
    1666:	6ae7f7c7          	fmsub.d	fa5,fa5,fa4,fa3
    166a:	f2088753          	fmv.d.x	fa4,a7
    166e:	0ab775d3          	fsub.d	fa1,fa4,fa1
    1672:	16883707          	fld	fa4,360(a6)
    1676:	7aa677c3          	fmadd.d	fa5,fa2,fa0,fa5
    167a:	f20e0553          	fmv.d.x	fa0,t3
    167e:	7aa5f7c3          	fmadd.d	fa5,fa1,fa0,fa5
    1682:	7ac5f5c3          	fmadd.d	fa1,fa1,fa2,fa5
    1686:	f20887d3          	fmv.d.x	fa5,a7
    168a:	5af77743          	fmadd.d	fa4,fa4,fa5,fa1
    168e:	c00f87e3          	beqz	t6,129c <stbsp__real_to_str+0xb2>
    1692:	02d777d3          	fadd.d	fa5,fa4,fa3
    1696:	fff3089b          	addiw	a7,t1,-1
    169a:	00005817          	auipc	a6,0x5
    169e:	e6e80813          	addi	a6,a6,-402 # 6508 <stbsp__bot>
    16a2:	030e                	slli	t1,t1,0x3
    16a4:	088e                	slli	a7,a7,0x3
    16a6:	98c2                	add	a7,a7,a6
    16a8:	981a                	add	a6,a6,t1
    16aa:	e2078e53          	fmv.x.d	t3,fa5
    16ae:	21083e83          	ld	t4,528(a6)
    16b2:	f8000837          	lui	a6,0xf8000
    16b6:	2188b507          	fld	fa0,536(a7)
    16ba:	01c87333          	and	t1,a6,t3
    16be:	01d87833          	and	a6,a6,t4
    16c2:	f2080653          	fmv.d.x	fa2,a6
    16c6:	12f577d3          	fmul.d	fa5,fa0,fa5
    16ca:	2808b587          	fld	fa1,640(a7)
    16ce:	0ac57053          	fsub.d	ft0,fa0,fa2
    16d2:	f20e0653          	fmv.d.x	fa2,t3
    16d6:	0ad67153          	fsub.d	ft2,fa2,fa3
    16da:	f20806d3          	fmv.d.x	fa3,a6
    16de:	f2030653          	fmv.d.x	fa2,t1
    16e2:	7ac6f0c7          	fmsub.d	ft1,fa3,fa2,fa5
    16e6:	f20e06d3          	fmv.d.x	fa3,t3
    16ea:	0ac6f653          	fsub.d	fa2,fa3,fa2
    16ee:	22f786d3          	fmv.d	fa3,fa5
    16f2:	0a2777d3          	fsub.d	fa5,fa4,ft2
    16f6:	f2030753          	fmv.d.x	fa4,t1
    16fa:	0ae07743          	fmadd.d	fa4,ft0,fa4,ft1
    16fe:	12a7f7d3          	fmul.d	fa5,fa5,fa0
    1702:	f2080553          	fmv.d.x	fa0,a6
    1706:	72a67743          	fmadd.d	fa4,fa2,fa0,fa4
    170a:	f20e0553          	fmv.d.x	fa0,t3
    170e:	7aa5f7c3          	fmadd.d	fa5,fa1,fa0,fa5
    1712:	72067643          	fmadd.d	fa2,fa2,ft0,fa4
    1716:	02f67753          	fadd.d	fa4,fa2,fa5
    171a:	b649                	j	129c <stbsp__real_to_str+0xb2>
    171c:	02571313          	slli	t1,a4,0x25
    1720:	02535313          	srli	t1,t1,0x25
    1724:	0305                	addi	t1,t1,1
    1726:	475d                	li	a4,23
    1728:	d46769e3          	bltu	a4,t1,147a <stbsp__real_to_str+0x290>
    172c:	bd99                	j	1582 <stbsp__real_to_str+0x398>
    172e:	87fe                	mv	a5,t6
    1730:	8fbe                	mv	t6,a5
    1732:	b101                	j	1332 <stbsp__real_to_str+0x148>
    1734:	87fe                	mv	a5,t6
    1736:	3e800713          	li	a4,1000
    173a:	02e7f73b          	remuw	a4,a5,a4
    173e:	2781                	sext.w	a5,a5
    1740:	eb01                	bnez	a4,1750 <stbsp__real_to_str+0x566>
    1742:	3e800813          	li	a6,1000
    1746:	0307d7bb          	divuw	a5,a5,a6
    174a:	0307f73b          	remuw	a4,a5,a6
    174e:	df65                	beqz	a4,1746 <stbsp__real_to_str+0x55c>
    1750:	02079f93          	slli	t6,a5,0x20
    1754:	020fdf93          	srli	t6,t6,0x20
    1758:	b31d                	j	147e <stbsp__real_to_str+0x294>
    175a:	4785                	li	a5,1
    175c:	c29c                	sw	a5,0(a3)
    175e:	00c2b023          	sd	a2,0(t0)
    1762:	03000793          	li	a5,48
    1766:	00f60023          	sb	a5,0(a2)
    176a:	4f05                	li	t5,1
    176c:	01e5a023          	sw	t5,0(a1)
    1770:	6105                	addi	sp,sp,32
    1772:	8082                	ret
    1774:	0805                	addi	a6,a6,1 # fffffffff8000001 <_ZSt4cerr+0xfffffffff7ff7191>
    1776:	3f7d                	addiw	t5,t5,-1
    1778:	b3d1                	j	153c <stbsp__real_to_str+0x352>
    177a:	e826                	sd	s1,16(sp)
    177c:	e44a                	sd	s2,8(sp)
    177e:	4859                	li	a6,22
    1780:	8976                	mv	s2,t4
    1782:	11d84363          	blt	a6,t4,1888 <stbsp__real_to_str+0x69e>
    1786:	0009049b          	sext.w	s1,s2
    178a:	00005e17          	auipc	t3,0x5
    178e:	d7ee0e13          	addi	t3,t3,-642 # 6508 <stbsp__bot>
    1792:	00349813          	slli	a6,s1,0x3
    1796:	9872                	add	a6,a6,t3
    1798:	00083687          	fld	fa3,0(a6)
    179c:	00083803          	ld	a6,0(a6)
    17a0:	f20887d3          	fmv.d.x	fa5,a7
    17a4:	f8000fb7          	lui	t6,0xf8000
    17a8:	010ff833          	and	a6,t6,a6
    17ac:	12f6f553          	fmul.d	fa0,fa3,fa5
    17b0:	f20807d3          	fmv.d.x	fa5,a6
    17b4:	011ff433          	and	s0,t6,a7
    17b8:	f2040753          	fmv.d.x	fa4,s0
    17bc:	0af6f6d3          	fsub.d	fa3,fa3,fa5
    17c0:	f20887d3          	fmv.d.x	fa5,a7
    17c4:	f2080653          	fmv.d.x	fa2,a6
    17c8:	412e8ebb          	subw	t4,t4,s2
    17cc:	0ae7f753          	fsub.d	fa4,fa5,fa4
    17d0:	f20407d3          	fmv.d.x	fa5,s0
    17d4:	e20508d3          	fmv.x.d	a7,fa0
    17d8:	52c7f7c7          	fmsub.d	fa5,fa5,fa2,fa0
    17dc:	f2040653          	fmv.d.x	fa2,s0
    17e0:	7ac6f7c3          	fmadd.d	fa5,fa3,fa2,fa5
    17e4:	f2080653          	fmv.d.x	fa2,a6
    17e8:	7ac777c3          	fmadd.d	fa5,fa4,fa2,fa5
    17ec:	7ad77743          	fmadd.d	fa4,fa4,fa3,fa5
    17f0:	080e8963          	beqz	t4,1882 <stbsp__real_to_str+0x698>
    17f4:	02e577d3          	fadd.d	fa5,fa0,fa4
    17f8:	0e8e                	slli	t4,t4,0x3
    17fa:	01de0833          	add	a6,t3,t4
    17fe:	00083587          	fld	fa1,0(a6)
    1802:	00231893          	slli	a7,t1,0x2
    1806:	411308b3          	sub	a7,t1,a7
    180a:	00389813          	slli	a6,a7,0x3
    180e:	e2078453          	fmv.x.d	s0,fa5
    1812:	12f5f7d3          	fmul.d	fa5,fa1,fa5
    1816:	981a                	add	a6,a6,t1
    1818:	987a                	add	a6,a6,t5
    181a:	40980833          	sub	a6,a6,s1
    181e:	080e                	slli	a6,a6,0x3
    1820:	9872                	add	a6,a6,t3
    1822:	00083e83          	ld	t4,0(a6)
    1826:	008ff833          	and	a6,t6,s0
    182a:	e20788d3          	fmv.x.d	a7,fa5
    182e:	f20806d3          	fmv.d.x	fa3,a6
    1832:	f20407d3          	fmv.d.x	fa5,s0
    1836:	01dfffb3          	and	t6,t6,t4
    183a:	f20880d3          	fmv.d.x	ft1,a7
    183e:	0ad7f653          	fsub.d	fa2,fa5,fa3
    1842:	f20f87d3          	fmv.d.x	fa5,t6
    1846:	64c2                	ld	s1,16(sp)
    1848:	6922                	ld	s2,8(sp)
    184a:	0af5f053          	fsub.d	ft0,fa1,fa5
    184e:	0ad7f6c7          	fmsub.d	fa3,fa5,fa3,ft1
    1852:	f20407d3          	fmv.d.x	fa5,s0
    1856:	0aa7f7d3          	fsub.d	fa5,fa5,fa0
    185a:	f2080553          	fmv.d.x	fa0,a6
    185e:	6aa076c3          	fmadd.d	fa3,ft0,fa0,fa3
    1862:	0af77753          	fsub.d	fa4,fa4,fa5
    1866:	f20f87d3          	fmv.d.x	fa5,t6
    186a:	6af677c3          	fmadd.d	fa5,fa2,fa5,fa3
    186e:	7a067643          	fmadd.d	fa2,fa2,ft0,fa5
    1872:	62e5f743          	fmadd.d	fa4,fa1,fa4,fa2
    1876:	b6b5                	j	13e2 <stbsp__real_to_str+0x1f8>
    1878:	f20886d3          	fmv.d.x	fa3,a7
    187c:	f2000753          	fmv.d.x	fa4,zero
    1880:	b539                	j	168e <stbsp__real_to_str+0x4a4>
    1882:	64c2                	ld	s1,16(sp)
    1884:	6922                	ld	s2,8(sp)
    1886:	beb1                	j	13e2 <stbsp__real_to_str+0x1f8>
    1888:	4959                	li	s2,22
    188a:	bdf5                	j	1786 <stbsp__real_to_str+0x59c>
    188c:	e826                	sd	s1,16(sp)
    188e:	e44a                	sd	s2,8(sp)
    1890:	ecc00393          	li	t2,-308
    1894:	4eed                	li	t4,27
    1896:	4335                	li	t1,13
    1898:	14600f13          	li	t5,326
    189c:	b5cd                	j	177e <stbsp__real_to_str+0x594>
    189e:	26900313          	li	t1,617
    18a2:	0303083b          	mulw	a6,t1,a6
    18a6:	41f8531b          	sraiw	t1,a6,0x1f
    18aa:	0153531b          	srliw	t1,t1,0x15
    18ae:	0103033b          	addw	t1,t1,a6
    18b2:	40b3539b          	sraiw	t2,t1,0xb
    18b6:	4849                	li	a6,18
    18b8:	4078083b          	subw	a6,a6,t2
    18bc:	b249                	j	123e <stbsp__real_to_str+0x54>

00000000000018be <_in_char.part.0>:
static int _in_char(_InContext *ctx)
    18be:	87aa                	mv	a5,a0
    if (ctx->fd == -1)
    18c0:	4508                	lw	a0,8(a0)
    18c2:	577d                	li	a4,-1
    18c4:	00e51d63          	bne	a0,a4,18de <_in_char.part.0+0x20>
        if (ctx->buf[ctx->pos] == '\0')
    18c8:	6b94                	ld	a3,16(a5)
    18ca:	6398                	ld	a4,0(a5)
    18cc:	9736                	add	a4,a4,a3
    18ce:	00074603          	lbu	a2,0(a4)
    18d2:	c60d                	beqz	a2,18fc <_in_char.part.0+0x3e>
        return (unsigned char)ctx->buf[ctx->pos++];
    18d4:	0685                	addi	a3,a3,1
    18d6:	eb94                	sd	a3,16(a5)
    18d8:	00074503          	lbu	a0,0(a4)
    18dc:	8082                	ret
static int _in_char(_InContext *ctx)
    18de:	1101                	addi	sp,sp,-32
    if (read(ctx->fd, &c, 1) == 1)
    18e0:	4605                	li	a2,1
    18e2:	00f10593          	addi	a1,sp,15
static int _in_char(_InContext *ctx)
    18e6:	ec06                	sd	ra,24(sp)
    if (read(ctx->fd, &c, 1) == 1)
    18e8:	801ff0ef          	jal	10e8 <read>
    18ec:	4785                	li	a5,1
    18ee:	00f51963          	bne	a0,a5,1900 <_in_char.part.0+0x42>
        return (unsigned char)c;
    18f2:	00f14503          	lbu	a0,15(sp)
}
    18f6:	60e2                	ld	ra,24(sp)
    18f8:	6105                	addi	sp,sp,32
    18fa:	8082                	ret
            return -1;
    18fc:	557d                	li	a0,-1
}
    18fe:	8082                	ret
            return -1;
    1900:	557d                	li	a0,-1
    1902:	bfd5                	j	18f6 <_in_char.part.0+0x38>

0000000000001904 <_skip_space>:
{
    1904:	7139                	addi	sp,sp,-64
    1906:	f822                	sd	s0,48(sp)
    1908:	f426                	sd	s1,40(sp)
    190a:	f04a                	sd	s2,32(sp)
    190c:	ec4e                	sd	s3,24(sp)
    190e:	e852                	sd	s4,16(sp)
    1910:	fc06                	sd	ra,56(sp)
    1912:	842a                	mv	s0,a0
        ctx->ungotten = -1;
    1914:	54fd                	li	s1,-1
    if (read(ctx->fd, &c, 1) == 1)
    1916:	00f10a13          	addi	s4,sp,15
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    191a:	02000913          	li	s2,32
    191e:	4991                	li	s3,4
    if (ctx->ungotten >= 0)
    1920:	4c1c                	lw	a5,24(s0)
    1922:	0407d163          	bgez	a5,1964 <_skip_space+0x60>
    if (ctx->fd == -1)
    1926:	4408                	lw	a0,8(s0)
    if (read(ctx->fd, &c, 1) == 1)
    1928:	4605                	li	a2,1
    192a:	85d2                	mv	a1,s4
    if (ctx->fd == -1)
    192c:	02951e63          	bne	a0,s1,1968 <_skip_space+0x64>
        if (ctx->buf[ctx->pos] == '\0')
    1930:	6818                	ld	a4,16(s0)
    1932:	601c                	ld	a5,0(s0)
        return (unsigned char)ctx->buf[ctx->pos++];
    1934:	00170693          	addi	a3,a4,1
        if (ctx->buf[ctx->pos] == '\0')
    1938:	97ba                	add	a5,a5,a4
    193a:	0007c703          	lbu	a4,0(a5) # 7000 <STDIN_FD+0x698>
    193e:	cb19                	beqz	a4,1954 <_skip_space+0x50>
        return (unsigned char)ctx->buf[ctx->pos++];
    1940:	e814                	sd	a3,16(s0)
    1942:	0007c783          	lbu	a5,0(a5)
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    1946:	ff77871b          	addiw	a4,a5,-9
    194a:	fd278be3          	beq	a5,s2,1920 <_skip_space+0x1c>
    194e:	fce9f9e3          	bgeu	s3,a4,1920 <_skip_space+0x1c>
        ctx->ungotten = c;
    1952:	cc1c                	sw	a5,24(s0)
}
    1954:	70e2                	ld	ra,56(sp)
    1956:	7442                	ld	s0,48(sp)
    1958:	74a2                	ld	s1,40(sp)
    195a:	7902                	ld	s2,32(sp)
    195c:	69e2                	ld	s3,24(sp)
    195e:	6a42                	ld	s4,16(sp)
    1960:	6121                	addi	sp,sp,64
    1962:	8082                	ret
        ctx->ungotten = -1;
    1964:	cc04                	sw	s1,24(s0)
        return c;
    1966:	b7c5                	j	1946 <_skip_space+0x42>
    if (read(ctx->fd, &c, 1) == 1)
    1968:	f80ff0ef          	jal	10e8 <read>
    196c:	4785                	li	a5,1
    196e:	fef513e3          	bne	a0,a5,1954 <_skip_space+0x50>
        return (unsigned char)c;
    1972:	00f14783          	lbu	a5,15(sp)
    1976:	bfc1                	j	1946 <_skip_space+0x42>

0000000000001978 <_vscanf_core.constprop.0>:
static int _vscanf_core(_InContext *ctx, const char *format, va_list ap)
    1978:	7155                	addi	sp,sp,-208
    197a:	e586                	sd	ra,200(sp)
    197c:	e95a                	sd	s6,144(sp)
    while (*p)
    197e:	0005c783          	lbu	a5,0(a1)
static int _vscanf_core(_InContext *ctx, const char *format, va_list ap)
    1982:	e432                	sd	a2,8(sp)
    while (*p)
    1984:	68078b63          	beqz	a5,201a <_vscanf_core.constprop.0+0x6a2>
    1988:	e1a2                	sd	s0,192(sp)
    198a:	fd26                	sd	s1,184(sp)
    198c:	f152                	sd	s4,160(sp)
    198e:	ed56                	sd	s5,152(sp)
    1990:	f4ee                	sd	s11,104(sp)
    1992:	842e                	mv	s0,a1
    1994:	8daa                	mv	s11,a0
    int assigned = 0;
    1996:	4b01                	li	s6,0
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    1998:	02000493          	li	s1,32
    199c:	4a91                	li	s5,4
        if (*p != '%')
    199e:	02500a13          	li	s4,37
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    19a2:	04978763          	beq	a5,s1,19f0 <_vscanf_core.constprop.0+0x78>
    19a6:	ff77869b          	addiw	a3,a5,-9
    19aa:	0ff6f693          	zext.b	a3,a3
    19ae:	04daf163          	bgeu	s5,a3,19f0 <_vscanf_core.constprop.0+0x78>
        if (*p != '%')
    19b2:	07478d63          	beq	a5,s4,1a2c <_vscanf_core.constprop.0+0xb4>
            _skip_space(ctx);
    19b6:	856e                	mv	a0,s11
    19b8:	f4dff0ef          	jal	1904 <_skip_space>
    if (ctx->ungotten >= 0)
    19bc:	018da503          	lw	a0,24(s11)
    19c0:	04055a63          	bgez	a0,1a14 <_vscanf_core.constprop.0+0x9c>
    19c4:	856e                	mv	a0,s11
    19c6:	ef9ff0ef          	jal	18be <_in_char.part.0>
            if (c != *p)
    19ca:	00044783          	lbu	a5,0(s0)
    19ce:	04a78a63          	beq	a5,a0,1a22 <_vscanf_core.constprop.0+0xaa>
    if (c != -1)
    19d2:	57fd                	li	a5,-1
    19d4:	00f50463          	beq	a0,a5,19dc <_vscanf_core.constprop.0+0x64>
        ctx->ungotten = c;
    19d8:	00adac23          	sw	a0,24(s11)
    19dc:	640e                	ld	s0,192(sp)
    19de:	74ea                	ld	s1,184(sp)
    19e0:	7a0a                	ld	s4,160(sp)
    19e2:	6aea                	ld	s5,152(sp)
    19e4:	7da6                	ld	s11,104(sp)
}
    19e6:	60ae                	ld	ra,200(sp)
    19e8:	855a                	mv	a0,s6
    19ea:	6b4a                	ld	s6,144(sp)
    19ec:	6169                	addi	sp,sp,208
    19ee:	8082                	ret
            _skip_space(ctx);
    19f0:	856e                	mv	a0,s11
    19f2:	f13ff0ef          	jal	1904 <_skip_space>
            while (isspace(*p))
    19f6:	00044783          	lbu	a5,0(s0)
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    19fa:	4611                	li	a2,4
    19fc:	ff77869b          	addiw	a3,a5,-9
    1a00:	0ff6f693          	zext.b	a3,a3
    1a04:	00978663          	beq	a5,s1,1a10 <_vscanf_core.constprop.0+0x98>
    1a08:	00d67463          	bgeu	a2,a3,1a10 <_vscanf_core.constprop.0+0x98>
    while (*p)
    1a0c:	fbd9                	bnez	a5,19a2 <_vscanf_core.constprop.0+0x2a>
    1a0e:	b7f9                	j	19dc <_vscanf_core.constprop.0+0x64>
                p++;
    1a10:	0405                	addi	s0,s0,1
    1a12:	b7d5                	j	19f6 <_vscanf_core.constprop.0+0x7e>
        ctx->ungotten = -1;
    1a14:	57fd                	li	a5,-1
    1a16:	00fdac23          	sw	a5,24(s11)
            if (c != *p)
    1a1a:	00044783          	lbu	a5,0(s0)
    1a1e:	faa79ae3          	bne	a5,a0,19d2 <_vscanf_core.constprop.0+0x5a>
    while (*p)
    1a22:	00144783          	lbu	a5,1(s0)
            p++;
    1a26:	0405                	addi	s0,s0,1
    while (*p)
    1a28:	ffad                	bnez	a5,19a2 <_vscanf_core.constprop.0+0x2a>
    1a2a:	bf4d                	j	19dc <_vscanf_core.constprop.0+0x64>
    1a2c:	f94a                	sd	s2,176(sp)
    1a2e:	f54e                	sd	s3,168(sp)
    1a30:	e55e                	sd	s7,136(sp)
    1a32:	e162                	sd	s8,128(sp)
        if (*p == '*')
    1a34:	00144583          	lbu	a1,1(s0)
    1a38:	02a00793          	li	a5,42
    1a3c:	22f58d63          	beq	a1,a5,1c76 <_vscanf_core.constprop.0+0x2fe>
        p++;
    1a40:	0405                	addi	s0,s0,1
        int suppress = 0;
    1a42:	4981                	li	s3,0
        while (*p >= '0' && *p <= '9')
    1a44:	fd05861b          	addiw	a2,a1,-48
    1a48:	0ff67693          	zext.b	a3,a2
    1a4c:	47a5                	li	a5,9
    1a4e:	36d7e763          	bltu	a5,a3,1dbc <_vscanf_core.constprop.0+0x444>
    1a52:	4781                	li	a5,0
    1a54:	4825                	li	a6,9
    1a56:	a019                	j	1a5c <_vscanf_core.constprop.0+0xe4>
            width = width * 10 + (*p - '0');
    1a58:	0016979b          	slliw	a5,a3,0x1
        while (*p >= '0' && *p <= '9')
    1a5c:	00144583          	lbu	a1,1(s0)
            width = width * 10 + (*p - '0');
    1a60:	00f6093b          	addw	s2,a2,a5
    1a64:	0029169b          	slliw	a3,s2,0x2
        while (*p >= '0' && *p <= '9')
    1a68:	fd05861b          	addiw	a2,a1,-48
    1a6c:	0ff67513          	zext.b	a0,a2
            width = width * 10 + (*p - '0');
    1a70:	012686bb          	addw	a3,a3,s2
            p++;
    1a74:	0405                	addi	s0,s0,1
        while (*p >= '0' && *p <= '9')
    1a76:	fea871e3          	bgeu	a6,a0,1a58 <_vscanf_core.constprop.0+0xe0>
        if (*p == 'l')
    1a7a:	06c00693          	li	a3,108
            p++;
    1a7e:	00140b93          	addi	s7,s0,1
        if (*p == 'l')
    1a82:	1ed58f63          	beq	a1,a3,1c80 <_vscanf_core.constprop.0+0x308>
        else if (*p == 'h')
    1a86:	06800693          	li	a3,104
    1a8a:	2ad58863          	beq	a1,a3,1d3a <_vscanf_core.constprop.0+0x3c2>
        char spec = *p++;
    1a8e:	00044c03          	lbu	s8,0(s0)
    1a92:	8ba2                	mv	s7,s0
        int len_mod = 0;
    1a94:	ec02                	sd	zero,24(sp)
        char spec = *p++;
    1a96:	06300693          	li	a3,99
    1a9a:	001b8413          	addi	s0,s7,1
        if (!spec)
    1a9e:	2adc0863          	beq	s8,a3,1d4e <_vscanf_core.constprop.0+0x3d6>
    1aa2:	1f86fc63          	bgeu	a3,s8,1c9a <_vscanf_core.constprop.0+0x322>
    1aa6:	f9cc069b          	addiw	a3,s8,-100
    1aaa:	0ff6f693          	zext.b	a3,a3
    1aae:	4651                	li	a2,20
    1ab0:	0cd66e63          	bltu	a2,a3,1b8c <_vscanf_core.constprop.0+0x214>
    1ab4:	00120637          	lui	a2,0x120
    1ab8:	4585                	li	a1,1
    1aba:	00d595b3          	sll	a1,a1,a3
    1abe:	02160613          	addi	a2,a2,33 # 120021 <_ZSt4cerr+0x1171b1>
    1ac2:	8e6d                	and	a2,a2,a1
    1ac4:	ee69                	bnez	a2,1b9e <_vscanf_core.constprop.0+0x226>
    1ac6:	89b9                	andi	a1,a1,14
    1ac8:	1e059263          	bnez	a1,1cac <_vscanf_core.constprop.0+0x334>
    1acc:	463d                	li	a2,15
    1ace:	0ac69f63          	bne	a3,a2,1b8c <_vscanf_core.constprop.0+0x214>
            _skip_space(ctx);
    1ad2:	856e                	mv	a0,s11
    1ad4:	e31ff0ef          	jal	1904 <_skip_space>
            char *buf = suppress ? NULL : va_arg(ap, char *);
    1ad8:	ec02                	sd	zero,24(sp)
    1ada:	00099763          	bnez	s3,1ae8 <_vscanf_core.constprop.0+0x170>
    1ade:	67a2                	ld	a5,8(sp)
    1ae0:	6398                	ld	a4,0(a5)
    1ae2:	07a1                	addi	a5,a5,8
    1ae4:	e43e                	sd	a5,8(sp)
    1ae6:	ec3a                	sd	a4,24(sp)
    if (ctx->ungotten >= 0)
    1ae8:	018da503          	lw	a0,24(s11)
    1aec:	2e055b63          	bgez	a0,1de2 <_vscanf_core.constprop.0+0x46a>
    1af0:	856e                	mv	a0,s11
    1af2:	dcdff0ef          	jal	18be <_in_char.part.0>
            while (c != -1 && !isspace(c))
    1af6:	56fd                	li	a3,-1
    1af8:	6ad50363          	beq	a0,a3,219e <_vscanf_core.constprop.0+0x826>
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    1afc:	02000693          	li	a3,32
    1b00:	3ed50963          	beq	a0,a3,1ef2 <_vscanf_core.constprop.0+0x57a>
    1b04:	46a5                	li	a3,9
    1b06:	3ed50663          	beq	a0,a3,1ef2 <_vscanf_core.constprop.0+0x57a>
    1b0a:	46a9                	li	a3,10
    1b0c:	3ed50363          	beq	a0,a3,1ef2 <_vscanf_core.constprop.0+0x57a>
    1b10:	46ad                	li	a3,11
    1b12:	3ed50063          	beq	a0,a3,1ef2 <_vscanf_core.constprop.0+0x57a>
    1b16:	46b1                	li	a3,12
    1b18:	3cd50d63          	beq	a0,a3,1ef2 <_vscanf_core.constprop.0+0x57a>
    1b1c:	46b5                	li	a3,13
    1b1e:	3cd50a63          	beq	a0,a3,1ef2 <_vscanf_core.constprop.0+0x57a>
    1b22:	67e2                	ld	a5,24(sp)
    1b24:	fce6                	sd	s9,120(sp)
    1b26:	f8ea                	sd	s10,112(sp)
    1b28:	e83e                	sd	a5,16(sp)
    1b2a:	4d01                	li	s10,0
            while (c != -1 && !isspace(c))
    1b2c:	5c7d                	li	s8,-1
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    1b2e:	02000c93          	li	s9,32
                if (width > 0 && i >= width)
    1b32:	01205463          	blez	s2,1b3a <_vscanf_core.constprop.0+0x1c2>
    1b36:	052d5563          	bge	s10,s2,1b80 <_vscanf_core.constprop.0+0x208>
                if (!suppress)
    1b3a:	00099563          	bnez	s3,1b44 <_vscanf_core.constprop.0+0x1cc>
                    buf[i] = (char)c;
    1b3e:	67c2                	ld	a5,16(sp)
    1b40:	00a78023          	sb	a0,0(a5)
    if (ctx->ungotten >= 0)
    1b44:	018da503          	lw	a0,24(s11)
                i++;
    1b48:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
    1b4a:	30055963          	bgez	a0,1e5c <_vscanf_core.constprop.0+0x4e4>
    1b4e:	856e                	mv	a0,s11
    1b50:	d6fff0ef          	jal	18be <_in_char.part.0>
            while (c != -1 && !isspace(c))
    1b54:	27850663          	beq	a0,s8,1dc0 <_vscanf_core.constprop.0+0x448>
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    1b58:	03950463          	beq	a0,s9,1b80 <_vscanf_core.constprop.0+0x208>
    1b5c:	47a5                	li	a5,9
    1b5e:	02f50163          	beq	a0,a5,1b80 <_vscanf_core.constprop.0+0x208>
    1b62:	47a9                	li	a5,10
    1b64:	00f50e63          	beq	a0,a5,1b80 <_vscanf_core.constprop.0+0x208>
    1b68:	47ad                	li	a5,11
    1b6a:	00f50b63          	beq	a0,a5,1b80 <_vscanf_core.constprop.0+0x208>
    1b6e:	47b1                	li	a5,12
    1b70:	00f50863          	beq	a0,a5,1b80 <_vscanf_core.constprop.0+0x208>
    1b74:	67c2                	ld	a5,16(sp)
    1b76:	0785                	addi	a5,a5,1
    1b78:	e83e                	sd	a5,16(sp)
    1b7a:	47b5                	li	a5,13
    1b7c:	faf51be3          	bne	a0,a5,1b32 <_vscanf_core.constprop.0+0x1ba>
            if (!suppress)
    1b80:	64098a63          	beqz	s3,21d4 <_vscanf_core.constprop.0+0x85c>
    1b84:	7ce6                	ld	s9,120(sp)
    1b86:	7d46                	ld	s10,112(sp)
        ctx->ungotten = c;
    1b88:	00adac23          	sw	a0,24(s11)
    while (*p)
    1b8c:	001bc783          	lbu	a5,1(s7)
    1b90:	794a                	ld	s2,176(sp)
    1b92:	79aa                	ld	s3,168(sp)
    1b94:	6baa                	ld	s7,136(sp)
    1b96:	6c0a                	ld	s8,128(sp)
    1b98:	e00795e3          	bnez	a5,19a2 <_vscanf_core.constprop.0+0x2a>
    1b9c:	b581                	j	19dc <_vscanf_core.constprop.0+0x64>
            _skip_space(ctx);
    1b9e:	856e                	mv	a0,s11
    1ba0:	f8ea                	sd	s10,112(sp)
    1ba2:	d63ff0ef          	jal	1904 <_skip_space>
    if (ctx->ungotten >= 0)
    1ba6:	018da503          	lw	a0,24(s11)
    1baa:	24055063          	bgez	a0,1dea <_vscanf_core.constprop.0+0x472>
    1bae:	856e                	mv	a0,s11
    1bb0:	d0fff0ef          	jal	18be <_in_char.part.0>
            if (c == '-' || c == '+')
    1bb4:	fd55069b          	addiw	a3,a0,-43
    1bb8:	9af5                	andi	a3,a3,-3
    1bba:	2681                	sext.w	a3,a3
            int i = 0, c = _in_char(ctx);
    1bbc:	4d01                	li	s10,0
            if (c == '-' || c == '+')
    1bbe:	3e068863          	beqz	a3,1fae <_vscanf_core.constprop.0+0x636>
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
    1bc2:	07800693          	li	a3,120
    1bc6:	4641                	li	a2,16
    1bc8:	00dc0863          	beq	s8,a3,1bd8 <_vscanf_core.constprop.0+0x260>
    1bcc:	06900693          	li	a3,105
    1bd0:	4629                	li	a2,10
    1bd2:	00dc1363          	bne	s8,a3,1bd8 <_vscanf_core.constprop.0+0x260>
    1bd6:	4601                	li	a2,0
            while (c != -1 && i < 63)
    1bd8:	56fd                	li	a3,-1
    1bda:	5cd50863          	beq	a0,a3,21aa <_vscanf_core.constprop.0+0x832>
    1bde:	fce6                	sd	s9,120(sp)
    1be0:	02010893          	addi	a7,sp,32
    1be4:	01a88c33          	add	s8,a7,s10
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
    1be8:	4cc1                	li	s9,16
                int digit = (c >= '0' && c <= '9');
    1bea:	fd05069b          	addiw	a3,a0,-48
    1bee:	0005031b          	sext.w	t1,a0
    1bf2:	00a6b593          	sltiu	a1,a3,10
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
    1bf6:	27960a63          	beq	a2,s9,1e6a <_vscanf_core.constprop.0+0x4f2>
    1bfa:	2a060d63          	beqz	a2,1eb4 <_vscanf_core.constprop.0+0x53c>
                int x = (c == 'x' || c == 'X');
    1bfe:	07800793          	li	a5,120
    1c02:	2ef50363          	beq	a0,a5,1ee8 <_vscanf_core.constprop.0+0x570>
    1c06:	fa850693          	addi	a3,a0,-88
    1c0a:	0016b693          	seqz	a3,a3
    1c0e:	4301                	li	t1,0
                if (width > 0 && i >= width)
    1c10:	01205463          	blez	s2,1c18 <_vscanf_core.constprop.0+0x2a0>
    1c14:	032d5a63          	bge	s10,s2,1c48 <_vscanf_core.constprop.0+0x2d0>
                if (digit || hex || x)
    1c18:	0066e6b3          	or	a3,a3,t1
    1c1c:	8ecd                	or	a3,a3,a1
    1c1e:	c68d                	beqz	a3,1c48 <_vscanf_core.constprop.0+0x2d0>
                    num_buf[i++] = (char)c;
    1c20:	00ac0023          	sb	a0,0(s8)
    if (ctx->ungotten >= 0)
    1c24:	018da503          	lw	a0,24(s11)
                    num_buf[i++] = (char)c;
    1c28:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
    1c2a:	22055c63          	bgez	a0,1e62 <_vscanf_core.constprop.0+0x4ea>
    1c2e:	856e                	mv	a0,s11
    1c30:	e832                	sd	a2,16(sp)
    1c32:	c8dff0ef          	jal	18be <_in_char.part.0>
            while (c != -1 && i < 63)
    1c36:	57fd                	li	a5,-1
    1c38:	6642                	ld	a2,16(sp)
    1c3a:	3cf50263          	beq	a0,a5,1ffe <_vscanf_core.constprop.0+0x686>
    1c3e:	03f00693          	li	a3,63
    1c42:	0c05                	addi	s8,s8,1
    1c44:	fadd13e3          	bne	s10,a3,1bea <_vscanf_core.constprop.0+0x272>
            num_buf[i] = '\0';
    1c48:	040d0793          	addi	a5,s10,64
    1c4c:	1018                	addi	a4,sp,32
    1c4e:	97ba                	add	a5,a5,a4
    1c50:	fc078023          	sb	zero,-64(a5)
        ctx->ungotten = c;
    1c54:	00adac23          	sw	a0,24(s11)
    1c58:	7ce6                	ld	s9,120(sp)
            if (i == 0)
    1c5a:	1e0d0663          	beqz	s10,1e46 <_vscanf_core.constprop.0+0x4ce>
            if (!suppress)
    1c5e:	36098363          	beqz	s3,1fc4 <_vscanf_core.constprop.0+0x64c>
    while (*p)
    1c62:	001bc783          	lbu	a5,1(s7)
        {
    1c66:	794a                	ld	s2,176(sp)
    1c68:	79aa                	ld	s3,168(sp)
    1c6a:	6baa                	ld	s7,136(sp)
    1c6c:	6c0a                	ld	s8,128(sp)
    1c6e:	7d46                	ld	s10,112(sp)
    while (*p)
    1c70:	d20799e3          	bnez	a5,19a2 <_vscanf_core.constprop.0+0x2a>
    1c74:	b3a5                	j	19dc <_vscanf_core.constprop.0+0x64>
        while (*p >= '0' && *p <= '9')
    1c76:	00244583          	lbu	a1,2(s0)
            suppress = 1;
    1c7a:	4985                	li	s3,1
            p++;
    1c7c:	0409                	addi	s0,s0,2
    1c7e:	b3d9                	j	1a44 <_vscanf_core.constprop.0+0xcc>
            if (*p == 'l')
    1c80:	00144c03          	lbu	s8,1(s0)
            len_mod = 1;
    1c84:	4785                	li	a5,1
    1c86:	ec3e                	sd	a5,24(sp)
            if (*p == 'l')
    1c88:	e0bc17e3          	bne	s8,a1,1a96 <_vscanf_core.constprop.0+0x11e>
                len_mod = 2;
    1c8c:	4789                	li	a5,2
        char spec = *p++;
    1c8e:	00244c03          	lbu	s8,2(s0)
                p++;
    1c92:	00240b93          	addi	s7,s0,2
                len_mod = 2;
    1c96:	ec3e                	sd	a5,24(sp)
    1c98:	bbfd                	j	1a96 <_vscanf_core.constprop.0+0x11e>
    1c9a:	100c0763          	beqz	s8,1da8 <_vscanf_core.constprop.0+0x430>
    1c9e:	fbbc079b          	addiw	a5,s8,-69
    1ca2:	0ff7f793          	zext.b	a5,a5
    1ca6:	4689                	li	a3,2
    1ca8:	eef6e2e3          	bltu	a3,a5,1b8c <_vscanf_core.constprop.0+0x214>
            _skip_space(ctx);
    1cac:	856e                	mv	a0,s11
    1cae:	f8ea                	sd	s10,112(sp)
    1cb0:	c55ff0ef          	jal	1904 <_skip_space>
    if (ctx->ungotten >= 0)
    1cb4:	018da783          	lw	a5,24(s11)
    1cb8:	1207dd63          	bgez	a5,1df2 <_vscanf_core.constprop.0+0x47a>
    1cbc:	856e                	mv	a0,s11
    1cbe:	c01ff0ef          	jal	18be <_in_char.part.0>
            if (c == '-' || c == '+')
    1cc2:	fd55069b          	addiw	a3,a0,-43
    1cc6:	ffd6f613          	andi	a2,a3,-3
    1cca:	2601                	sext.w	a2,a2
    1ccc:	87aa                	mv	a5,a0
    1cce:	12060c63          	beqz	a2,1e06 <_vscanf_core.constprop.0+0x48e>
            while (c != -1 && i < 63)
    1cd2:	567d                	li	a2,-1
    1cd4:	16c50963          	beq	a0,a2,1e46 <_vscanf_core.constprop.0+0x4ce>
    1cd8:	fce6                	sd	s9,120(sp)
            int i = 0, c = _in_char(ctx);
    1cda:	4d01                	li	s10,0
    1cdc:	80000937          	lui	s2,0x80000
    1ce0:	197d                	addi	s2,s2,-1 # ffffffff7fffffff <_ZSt4cerr+0xffffffff7fff718f>
    1ce2:	0932                	slli	s2,s2,0xc
    1ce4:	80194913          	xori	s2,s2,-2047
    1ce8:	093e                	slli	s2,s2,0xf
    1cea:	02010813          	addi	a6,sp,32
    1cee:	01a80cb3          	add	s9,a6,s10
    1cf2:	03a00c13          	li	s8,58
    1cf6:	1935                	addi	s2,s2,-19
    1cf8:	a831                	j	1d14 <_vscanf_core.constprop.0+0x39c>
    1cfa:	bc5ff0ef          	jal	18be <_in_char.part.0>
            while (c != -1 && i < 63)
    1cfe:	577d                	li	a4,-1
    1d00:	87aa                	mv	a5,a0
    1d02:	2ee50563          	beq	a0,a4,1fec <_vscanf_core.constprop.0+0x674>
    1d06:	03f00713          	li	a4,63
    1d0a:	0c85                	addi	s9,s9,1
    1d0c:	1eed0e63          	beq	s10,a4,1f08 <_vscanf_core.constprop.0+0x590>
    1d10:	fd57869b          	addiw	a3,a5,-43
        int c = ctx->ungotten;
    1d14:	00d95633          	srl	a2,s2,a3
    1d18:	856e                	mv	a0,s11
    1d1a:	8a05                	andi	a2,a2,1
    1d1c:	1edc6663          	bltu	s8,a3,1f08 <_vscanf_core.constprop.0+0x590>
    1d20:	1e060463          	beqz	a2,1f08 <_vscanf_core.constprop.0+0x590>
                    num_buf[i++] = (char)c;
    1d24:	00fc8023          	sb	a5,0(s9)
    if (ctx->ungotten >= 0)
    1d28:	018da783          	lw	a5,24(s11)
                    num_buf[i++] = (char)c;
    1d2c:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
    1d2e:	fc07c6e3          	bltz	a5,1cfa <_vscanf_core.constprop.0+0x382>
        ctx->ungotten = -1;
    1d32:	577d                	li	a4,-1
    1d34:	00edac23          	sw	a4,24(s11)
            while (c != -1 && i < 63)
    1d38:	b7f9                	j	1d06 <_vscanf_core.constprop.0+0x38e>
            if (*p == 'h')
    1d3a:	00144c03          	lbu	s8,1(s0)
        int len_mod = 0;
    1d3e:	ec02                	sd	zero,24(sp)
            if (*p == 'h')
    1d40:	d4bc1be3          	bne	s8,a1,1a96 <_vscanf_core.constprop.0+0x11e>
        char spec = *p++;
    1d44:	00244c03          	lbu	s8,2(s0)
                p++;
    1d48:	00240b93          	addi	s7,s0,2
    1d4c:	b3a9                	j	1a96 <_vscanf_core.constprop.0+0x11e>
    1d4e:	fce6                	sd	s9,120(sp)
    1d50:	f8ea                	sd	s10,112(sp)
            int count = (width > 0) ? width : 1;
    1d52:	00090c1b          	sext.w	s8,s2
    1d56:	0d205a63          	blez	s2,1e2a <_vscanf_core.constprop.0+0x4b2>
            char *buf = suppress ? NULL : va_arg(ap, char *);
    1d5a:	4d01                	li	s10,0
    1d5c:	06098d63          	beqz	s3,1dd6 <_vscanf_core.constprop.0+0x45e>
            for (int i = 0; i < count; i++)
    1d60:	9c6a                	add	s8,s8,s10
                if (c == -1)
    1d62:	5cfd                	li	s9,-1
    if (ctx->ungotten >= 0)
    1d64:	018da783          	lw	a5,24(s11)
        ctx->ungotten = -1;
    1d68:	856e                	mv	a0,s11
    if (ctx->ungotten >= 0)
    1d6a:	0207dc63          	bgez	a5,1da2 <_vscanf_core.constprop.0+0x42a>
    1d6e:	b51ff0ef          	jal	18be <_in_char.part.0>
    1d72:	87aa                	mv	a5,a0
                if (c == -1)
    1d74:	0b950d63          	beq	a0,s9,1e2e <_vscanf_core.constprop.0+0x4b6>
                if (!suppress)
    1d78:	00099463          	bnez	s3,1d80 <_vscanf_core.constprop.0+0x408>
                    buf[i] = (char)c;
    1d7c:	00fd0023          	sb	a5,0(s10)
            for (int i = 0; i < count; i++)
    1d80:	0d05                	addi	s10,s10,1
    1d82:	ffac11e3          	bne	s8,s10,1d64 <_vscanf_core.constprop.0+0x3ec>
    while (*p)
    1d86:	001bc783          	lbu	a5,1(s7)
            if (!suppress)
    1d8a:	00099363          	bnez	s3,1d90 <_vscanf_core.constprop.0+0x418>
                assigned++;
    1d8e:	2b05                	addiw	s6,s6,1
    1d90:	794a                	ld	s2,176(sp)
    1d92:	79aa                	ld	s3,168(sp)
    1d94:	6baa                	ld	s7,136(sp)
    1d96:	6c0a                	ld	s8,128(sp)
    1d98:	7ce6                	ld	s9,120(sp)
    1d9a:	7d46                	ld	s10,112(sp)
    while (*p)
    1d9c:	c00793e3          	bnez	a5,19a2 <_vscanf_core.constprop.0+0x2a>
    1da0:	b935                	j	19dc <_vscanf_core.constprop.0+0x64>
        ctx->ungotten = -1;
    1da2:	019dac23          	sw	s9,24(s11)
                if (c == -1)
    1da6:	bfc9                	j	1d78 <_vscanf_core.constprop.0+0x400>
    1da8:	640e                	ld	s0,192(sp)
    1daa:	74ea                	ld	s1,184(sp)
    1dac:	794a                	ld	s2,176(sp)
    1dae:	79aa                	ld	s3,168(sp)
    1db0:	7a0a                	ld	s4,160(sp)
    1db2:	6aea                	ld	s5,152(sp)
    1db4:	6baa                	ld	s7,136(sp)
    1db6:	6c0a                	ld	s8,128(sp)
    1db8:	7da6                	ld	s11,104(sp)
    1dba:	b135                	j	19e6 <_vscanf_core.constprop.0+0x6e>
        int width = -1;
    1dbc:	597d                	li	s2,-1
    1dbe:	b975                	j	1a7a <_vscanf_core.constprop.0+0x102>
            if (!suppress)
    1dc0:	3c099c63          	bnez	s3,2198 <_vscanf_core.constprop.0+0x820>
                buf[i] = '\0';
    1dc4:	67e2                	ld	a5,24(sp)
    1dc6:	01a786b3          	add	a3,a5,s10
    1dca:	00068023          	sb	zero,0(a3)
    while (*p)
    1dce:	001bc783          	lbu	a5,1(s7)
                assigned++;
    1dd2:	2b05                	addiw	s6,s6,1
    1dd4:	bf75                	j	1d90 <_vscanf_core.constprop.0+0x418>
            char *buf = suppress ? NULL : va_arg(ap, char *);
    1dd6:	67a2                	ld	a5,8(sp)
    1dd8:	0007bd03          	ld	s10,0(a5)
    1ddc:	07a1                	addi	a5,a5,8
    1dde:	e43e                	sd	a5,8(sp)
    1de0:	b741                	j	1d60 <_vscanf_core.constprop.0+0x3e8>
        ctx->ungotten = -1;
    1de2:	56fd                	li	a3,-1
    1de4:	00ddac23          	sw	a3,24(s11)
            while (c != -1 && !isspace(c))
    1de8:	bb11                	j	1afc <_vscanf_core.constprop.0+0x184>
        ctx->ungotten = -1;
    1dea:	56fd                	li	a3,-1
    1dec:	00ddac23          	sw	a3,24(s11)
        return c;
    1df0:	b3d1                	j	1bb4 <_vscanf_core.constprop.0+0x23c>
            if (c == '-' || c == '+')
    1df2:	fd57869b          	addiw	a3,a5,-43
    1df6:	ffd6f613          	andi	a2,a3,-3
        ctx->ungotten = -1;
    1dfa:	55fd                	li	a1,-1
    1dfc:	00bdac23          	sw	a1,24(s11)
            if (c == '-' || c == '+')
    1e00:	2601                	sext.w	a2,a2
    1e02:	ec061be3          	bnez	a2,1cd8 <_vscanf_core.constprop.0+0x360>
                num_buf[i++] = (char)c;
    1e06:	02f10023          	sb	a5,32(sp)
    if (ctx->ungotten >= 0)
    1e0a:	018da783          	lw	a5,24(s11)
    1e0e:	2207da63          	bgez	a5,2042 <_vscanf_core.constprop.0+0x6ca>
    1e12:	856e                	mv	a0,s11
    1e14:	aabff0ef          	jal	18be <_in_char.part.0>
            while (c != -1 && i < 63)
    1e18:	567d                	li	a2,-1
    1e1a:	87aa                	mv	a5,a0
                num_buf[i++] = (char)c;
    1e1c:	4d05                	li	s10,1
    1e1e:	fd55069b          	addiw	a3,a0,-43
            while (c != -1 && i < 63)
    1e22:	3ac50163          	beq	a0,a2,21c4 <_vscanf_core.constprop.0+0x84c>
    1e26:	fce6                	sd	s9,120(sp)
    1e28:	bd55                	j	1cdc <_vscanf_core.constprop.0+0x364>
            int count = (width > 0) ? width : 1;
    1e2a:	4c05                	li	s8,1
    1e2c:	b73d                	j	1d5a <_vscanf_core.constprop.0+0x3e2>
    1e2e:	640e                	ld	s0,192(sp)
    1e30:	74ea                	ld	s1,184(sp)
    1e32:	794a                	ld	s2,176(sp)
    1e34:	79aa                	ld	s3,168(sp)
    1e36:	7a0a                	ld	s4,160(sp)
    1e38:	6aea                	ld	s5,152(sp)
    1e3a:	6baa                	ld	s7,136(sp)
    1e3c:	6c0a                	ld	s8,128(sp)
    1e3e:	7ce6                	ld	s9,120(sp)
    1e40:	7d46                	ld	s10,112(sp)
    1e42:	7da6                	ld	s11,104(sp)
    1e44:	b64d                	j	19e6 <_vscanf_core.constprop.0+0x6e>
    1e46:	640e                	ld	s0,192(sp)
    1e48:	74ea                	ld	s1,184(sp)
    1e4a:	794a                	ld	s2,176(sp)
    1e4c:	79aa                	ld	s3,168(sp)
    1e4e:	7a0a                	ld	s4,160(sp)
    1e50:	6aea                	ld	s5,152(sp)
    1e52:	6baa                	ld	s7,136(sp)
    1e54:	6c0a                	ld	s8,128(sp)
    1e56:	7d46                	ld	s10,112(sp)
    1e58:	7da6                	ld	s11,104(sp)
    1e5a:	b671                	j	19e6 <_vscanf_core.constprop.0+0x6e>
        ctx->ungotten = -1;
    1e5c:	018dac23          	sw	s8,24(s11)
            while (c != -1 && !isspace(c))
    1e60:	b9e5                	j	1b58 <_vscanf_core.constprop.0+0x1e0>
        ctx->ungotten = -1;
    1e62:	57fd                	li	a5,-1
    1e64:	00fdac23          	sw	a5,24(s11)
            while (c != -1 && i < 63)
    1e68:	bbd9                	j	1c3e <_vscanf_core.constprop.0+0x2c6>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
    1e6a:	f9f3069b          	addiw	a3,t1,-97
    1e6e:	4795                	li	a5,5
    1e70:	06d7f263          	bgeu	a5,a3,1ed4 <_vscanf_core.constprop.0+0x55c>
    1e74:	fbf3031b          	addiw	t1,t1,-65
    1e78:	4795                	li	a5,5
    1e7a:	0467fd63          	bgeu	a5,t1,1ed4 <_vscanf_core.constprop.0+0x55c>
                int x = (c == 'x' || c == 'X');
    1e7e:	07800693          	li	a3,120
    1e82:	18d50763          	beq	a0,a3,2010 <_vscanf_core.constprop.0+0x698>
    1e86:	fa850693          	addi	a3,a0,-88
    1e8a:	0016b693          	seqz	a3,a3
                if (base == 0 && i == 1 && num_buf[0] == '0' && x)
    1e8e:	4301                	li	t1,0
    1e90:	32061663          	bnez	a2,21bc <_vscanf_core.constprop.0+0x844>
    1e94:	4785                	li	a5,1
    1e96:	4601                	li	a2,0
    1e98:	d6fd1ce3          	bne	s10,a5,1c10 <_vscanf_core.constprop.0+0x298>
    1e9c:	02014e03          	lbu	t3,32(sp)
    1ea0:	03000793          	li	a5,48
    1ea4:	d6fe16e3          	bne	t3,a5,1c10 <_vscanf_core.constprop.0+0x298>
    1ea8:	d60684e3          	beqz	a3,1c10 <_vscanf_core.constprop.0+0x298>
                    base = 16;
    1eac:	4641                	li	a2,16
                if (width > 0 && i >= width)
    1eae:	d7a919e3          	bne	s2,s10,1c20 <_vscanf_core.constprop.0+0x2a8>
    1eb2:	bb59                	j	1c48 <_vscanf_core.constprop.0+0x2d0>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
    1eb4:	f9f3069b          	addiw	a3,t1,-97
    1eb8:	4795                	li	a5,5
    1eba:	02d7f263          	bgeu	a5,a3,1ede <_vscanf_core.constprop.0+0x566>
    1ebe:	fbf3031b          	addiw	t1,t1,-65
    1ec2:	0467f063          	bgeu	a5,t1,1f02 <_vscanf_core.constprop.0+0x58a>
                int x = (c == 'x' || c == 'X');
    1ec6:	07800693          	li	a3,120
    1eca:	fad51ee3          	bne	a0,a3,1e86 <_vscanf_core.constprop.0+0x50e>
    1ece:	4301                	li	t1,0
    1ed0:	4685                	li	a3,1
    1ed2:	b7c9                	j	1e94 <_vscanf_core.constprop.0+0x51c>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
    1ed4:	4305                	li	t1,1
                int x = (c == 'x' || c == 'X');
    1ed6:	4681                	li	a3,0
                if (width > 0 && i >= width)
    1ed8:	d3204ee3          	bgtz	s2,1c14 <_vscanf_core.constprop.0+0x29c>
    1edc:	bb35                	j	1c18 <_vscanf_core.constprop.0+0x2a0>
                int x = (c == 'x' || c == 'X');
    1ede:	4681                	li	a3,0
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
    1ee0:	4305                	li	t1,1
                if (width > 0 && i >= width)
    1ee2:	d32049e3          	bgtz	s2,1c14 <_vscanf_core.constprop.0+0x29c>
    1ee6:	bb0d                	j	1c18 <_vscanf_core.constprop.0+0x2a0>
    1ee8:	4301                	li	t1,0
                int x = (c == 'x' || c == 'X');
    1eea:	4685                	li	a3,1
                if (width > 0 && i >= width)
    1eec:	d32044e3          	bgtz	s2,1c14 <_vscanf_core.constprop.0+0x29c>
    1ef0:	bb05                	j	1c20 <_vscanf_core.constprop.0+0x2a8>
            if (!suppress)
    1ef2:	c8099be3          	bnez	s3,1b88 <_vscanf_core.constprop.0+0x210>
                buf[i] = '\0';
    1ef6:	67e2                	ld	a5,24(sp)
    1ef8:	00078023          	sb	zero,0(a5)
        ctx->ungotten = c;
    1efc:	00adac23          	sw	a0,24(s11)
            if (i > 0 && !suppress)
    1f00:	b171                	j	1b8c <_vscanf_core.constprop.0+0x214>
                int x = (c == 'x' || c == 'X');
    1f02:	4681                	li	a3,0
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
    1f04:	4305                	li	t1,1
    1f06:	b779                	j	1e94 <_vscanf_core.constprop.0+0x51c>
            num_buf[i] = '\0';
    1f08:	040d0713          	addi	a4,s10,64
    1f0c:	1014                	addi	a3,sp,32
    1f0e:	96ba                	add	a3,a3,a4
    1f10:	fc068023          	sb	zero,-64(a3)
        ctx->ungotten = c;
    1f14:	00fdac23          	sw	a5,24(s11)
            if (i == 0)
    1f18:	f00d0be3          	beqz	s10,1e2e <_vscanf_core.constprop.0+0x4b6>
    1f1c:	7ce6                	ld	s9,120(sp)
            if (!suppress)
    1f1e:	d40992e3          	bnez	s3,1c62 <_vscanf_core.constprop.0+0x2ea>
    if (*str == '-')
    1f22:	02014603          	lbu	a2,32(sp)
    1f26:	02d00793          	li	a5,45
    1f2a:	1af60963          	beq	a2,a5,20dc <_vscanf_core.constprop.0+0x764>
    else if (*str == '+')
    1f2e:	02b00793          	li	a5,43
    1f32:	20f60a63          	beq	a2,a5,2146 <_vscanf_core.constprop.0+0x7ce>
    1f36:	00005797          	auipc	a5,0x5
    1f3a:	a427b587          	fld	fa1,-1470(a5) # 6978 <STDIN_FD+0x10>
    1f3e:	101c                	addi	a5,sp,32
    while (*str >= '0' && *str <= '9')
    1f40:	fd06069b          	addiw	a3,a2,-48
    1f44:	0ff6f513          	zext.b	a0,a3
    1f48:	45a5                	li	a1,9
    1f4a:	f20007d3          	fmv.d.x	fa5,zero
    1f4e:	02a5e463          	bltu	a1,a0,1f76 <_vscanf_core.constprop.0+0x5fe>
    1f52:	00005717          	auipc	a4,0x5
    1f56:	a2e73707          	fld	fa4,-1490(a4) # 6980 <STDIN_FD+0x18>
    1f5a:	4525                	li	a0,9
    1f5c:	0017c603          	lbu	a2,1(a5)
        val = val * 10.0 + (*str - '0');
    1f60:	d20686d3          	fcvt.d.w	fa3,a3
        str++;
    1f64:	0785                	addi	a5,a5,1
    while (*str >= '0' && *str <= '9')
    1f66:	fd06069b          	addiw	a3,a2,-48
    1f6a:	0ff6f593          	zext.b	a1,a3
        val = val * 10.0 + (*str - '0');
    1f6e:	6ae7f7c3          	fmadd.d	fa5,fa5,fa4,fa3
    while (*str >= '0' && *str <= '9')
    1f72:	feb575e3          	bgeu	a0,a1,1f5c <_vscanf_core.constprop.0+0x5e4>
    if (*str == '.')
    1f76:	02e00693          	li	a3,46
    1f7a:	16d60a63          	beq	a2,a3,20ee <_vscanf_core.constprop.0+0x776>
    if (*str == 'e' || *str == 'E')
    1f7e:	0007c683          	lbu	a3,0(a5)
    1f82:	0df6f693          	andi	a3,a3,223
    1f86:	04500613          	li	a2,69
    1f8a:	0cc68463          	beq	a3,a2,2052 <_vscanf_core.constprop.0+0x6da>
                    *va_arg(ap, double *) = val;
    1f8e:	6722                	ld	a4,8(sp)
                if (len_mod == 1)
    1f90:	4685                	li	a3,1
    return sign * val;
    1f92:	12b7f7d3          	fmul.d	fa5,fa5,fa1
                    *va_arg(ap, double *) = val;
    1f96:	631c                	ld	a5,0(a4)
                    *va_arg(ap, int64 *) = val;
    1f98:	0721                	addi	a4,a4,8
    1f9a:	e43a                	sd	a4,8(sp)
                if (len_mod == 1)
    1f9c:	6762                	ld	a4,24(sp)
    1f9e:	18d70b63          	beq	a4,a3,2134 <_vscanf_core.constprop.0+0x7bc>
                    *va_arg(ap, float *) = (float)val;
    1fa2:	4017f7d3          	fcvt.s.d	fa5,fa5
                assigned++;
    1fa6:	2b05                	addiw	s6,s6,1
                    *va_arg(ap, float *) = (float)val;
    1fa8:	00f7a027          	fsw	fa5,0(a5)
    1fac:	b95d                	j	1c62 <_vscanf_core.constprop.0+0x2ea>
                num_buf[i++] = (char)c;
    1fae:	02a10023          	sb	a0,32(sp)
    if (ctx->ungotten >= 0)
    1fb2:	018da503          	lw	a0,24(s11)
    1fb6:	06055463          	bgez	a0,201e <_vscanf_core.constprop.0+0x6a6>
    1fba:	856e                	mv	a0,s11
    1fbc:	903ff0ef          	jal	18be <_in_char.part.0>
                num_buf[i++] = (char)c;
    1fc0:	4d05                	li	s10,1
    1fc2:	b101                	j	1bc2 <_vscanf_core.constprop.0+0x24a>
                int64 val = strtoll(num_buf, NULL, base);
    1fc4:	4581                	li	a1,0
    1fc6:	1008                	addi	a0,sp,32
    1fc8:	696030ef          	jal	565e <strtoll>
                    *va_arg(ap, int64 *) = val;
    1fcc:	67a2                	ld	a5,8(sp)
                if (len_mod == 2)
    1fce:	6762                	ld	a4,24(sp)
    1fd0:	4689                	li	a3,2
                    *va_arg(ap, int64 *) = val;
    1fd2:	07a1                	addi	a5,a5,8
                if (len_mod == 2)
    1fd4:	16d70363          	beq	a4,a3,213a <_vscanf_core.constprop.0+0x7c2>
                    *va_arg(ap, int64 *) = val;
    1fd8:	6722                	ld	a4,8(sp)
                else if (len_mod == 1)
    1fda:	4605                	li	a2,1
                    *va_arg(ap, int64 *) = val;
    1fdc:	6314                	ld	a3,0(a4)
                else if (len_mod == 1)
    1fde:	6762                	ld	a4,24(sp)
    1fe0:	16c70163          	beq	a4,a2,2142 <_vscanf_core.constprop.0+0x7ca>
                    *va_arg(ap, int *) = (int)val;
    1fe4:	c288                	sw	a0,0(a3)
                assigned++;
    1fe6:	2b05                	addiw	s6,s6,1
    1fe8:	e43e                	sd	a5,8(sp)
    1fea:	b9a5                	j	1c62 <_vscanf_core.constprop.0+0x2ea>
            num_buf[i] = '\0';
    1fec:	040d0793          	addi	a5,s10,64
    1ff0:	1018                	addi	a4,sp,32
    1ff2:	00e785b3          	add	a1,a5,a4
    1ff6:	fc058023          	sb	zero,-64(a1)
            if (i == 0)
    1ffa:	7ce6                	ld	s9,120(sp)
    1ffc:	b70d                	j	1f1e <_vscanf_core.constprop.0+0x5a6>
            num_buf[i] = '\0';
    1ffe:	040d0793          	addi	a5,s10,64
    2002:	1018                	addi	a4,sp,32
    2004:	00e78833          	add	a6,a5,a4
    2008:	fc080023          	sb	zero,-64(a6)
            if (i == 0)
    200c:	7ce6                	ld	s9,120(sp)
    200e:	b981                	j	1c5e <_vscanf_core.constprop.0+0x2e6>
                int x = (c == 'x' || c == 'X');
    2010:	4301                	li	t1,0
    2012:	4685                	li	a3,1
                if (width > 0 && i >= width)
    2014:	c12040e3          	bgtz	s2,1c14 <_vscanf_core.constprop.0+0x29c>
    2018:	b101                	j	1c18 <_vscanf_core.constprop.0+0x2a0>
    int assigned = 0;
    201a:	4b01                	li	s6,0
    201c:	b2e9                	j	19e6 <_vscanf_core.constprop.0+0x6e>
        ctx->ungotten = -1;
    201e:	56fd                	li	a3,-1
    2020:	fce6                	sd	s9,120(sp)
    2022:	00ddac23          	sw	a3,24(s11)
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
    2026:	07800693          	li	a3,120
    202a:	4641                	li	a2,16
                num_buf[i++] = (char)c;
    202c:	4d05                	li	s10,1
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
    202e:	badc09e3          	beq	s8,a3,1be0 <_vscanf_core.constprop.0+0x268>
    2032:	06900693          	li	a3,105
    2036:	4629                	li	a2,10
                num_buf[i++] = (char)c;
    2038:	4d05                	li	s10,1
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
    203a:	badc13e3          	bne	s8,a3,1be0 <_vscanf_core.constprop.0+0x268>
    203e:	4601                	li	a2,0
    2040:	b645                	j	1be0 <_vscanf_core.constprop.0+0x268>
        ctx->ungotten = -1;
    2042:	56fd                	li	a3,-1
    2044:	fce6                	sd	s9,120(sp)
    2046:	00ddac23          	sw	a3,24(s11)
                num_buf[i++] = (char)c;
    204a:	4d05                	li	s10,1
    204c:	fd57869b          	addiw	a3,a5,-43
    2050:	b171                	j	1cdc <_vscanf_core.constprop.0+0x364>
        if (*str == '-')
    2052:	0017c583          	lbu	a1,1(a5)
    2056:	02d00693          	li	a3,45
    205a:	0ed58f63          	beq	a1,a3,2158 <_vscanf_core.constprop.0+0x7e0>
        else if (*str == '+')
    205e:	02b00693          	li	a3,43
    2062:	10d58e63          	beq	a1,a3,217e <_vscanf_core.constprop.0+0x806>
        while (*str >= '0' && *str <= '9')
    2066:	fd05861b          	addiw	a2,a1,-48
    206a:	0ff67513          	zext.b	a0,a2
    206e:	45a5                	li	a1,9
        str++;
    2070:	00178693          	addi	a3,a5,1
        int esign = 1;
    2074:	4805                	li	a6,1
        while (*str >= '0' && *str <= '9')
    2076:	04a5ec63          	bltu	a1,a0,20ce <_vscanf_core.constprop.0+0x756>
    207a:	4525                	li	a0,9
    207c:	0016c583          	lbu	a1,1(a3)
            eval = eval * 10 + (*str - '0');
    2080:	0029979b          	slliw	a5,s3,0x2
    2084:	013787bb          	addw	a5,a5,s3
    2088:	0017979b          	slliw	a5,a5,0x1
    208c:	00f609bb          	addw	s3,a2,a5
        while (*str >= '0' && *str <= '9')
    2090:	fd05861b          	addiw	a2,a1,-48
    2094:	0ff67593          	zext.b	a1,a2
            str++;
    2098:	0685                	addi	a3,a3,1
        while (*str >= '0' && *str <= '9')
    209a:	feb571e3          	bgeu	a0,a1,207c <_vscanf_core.constprop.0+0x704>
        while (eval--)
    209e:	fff9879b          	addiw	a5,s3,-1
    20a2:	12098463          	beqz	s3,21ca <_vscanf_core.constprop.0+0x852>
        double p = 1.0;
    20a6:	00005717          	auipc	a4,0x5
    20aa:	8d273687          	fld	fa3,-1838(a4) # 6978 <STDIN_FD+0x10>
    20ae:	00005717          	auipc	a4,0x5
    20b2:	8d273707          	fld	fa4,-1838(a4) # 6980 <STDIN_FD+0x18>
        while (eval--)
    20b6:	56fd                	li	a3,-1
    20b8:	37fd                	addiw	a5,a5,-1
            p *= 10.0;
    20ba:	12e6f6d3          	fmul.d	fa3,fa3,fa4
        while (eval--)
    20be:	fed79de3          	bne	a5,a3,20b8 <_vscanf_core.constprop.0+0x740>
        if (esign == 1)
    20c2:	4785                	li	a5,1
    20c4:	00f80963          	beq	a6,a5,20d6 <_vscanf_core.constprop.0+0x75e>
            val /= p;
    20c8:	1ad7f7d3          	fdiv.d	fa5,fa5,fa3
    20cc:	b5c9                	j	1f8e <_vscanf_core.constprop.0+0x616>
        double p = 1.0;
    20ce:	00005797          	auipc	a5,0x5
    20d2:	8aa7b687          	fld	fa3,-1878(a5) # 6978 <STDIN_FD+0x10>
            val *= p;
    20d6:	12d7f7d3          	fmul.d	fa5,fa5,fa3
    20da:	bd55                	j	1f8e <_vscanf_core.constprop.0+0x616>
    while (*str >= '0' && *str <= '9')
    20dc:	00005797          	auipc	a5,0x5
    20e0:	8947b587          	fld	fa1,-1900(a5) # 6970 <STDIN_FD+0x8>
    20e4:	02114603          	lbu	a2,33(sp)
        str++;
    20e8:	02110793          	addi	a5,sp,33
    20ec:	bd91                	j	1f40 <_vscanf_core.constprop.0+0x5c8>
        while (*str >= '0' && *str <= '9')
    20ee:	0017c683          	lbu	a3,1(a5)
    20f2:	45a5                	li	a1,9
        str++;
    20f4:	0785                	addi	a5,a5,1
        while (*str >= '0' && *str <= '9')
    20f6:	fd06861b          	addiw	a2,a3,-48
    20fa:	0ff67513          	zext.b	a0,a2
    20fe:	e8a5e2e3          	bltu	a1,a0,1f82 <_vscanf_core.constprop.0+0x60a>
        double div = 10.0;
    2102:	00005717          	auipc	a4,0x5
    2106:	87e73707          	fld	fa4,-1922(a4) # 6980 <STDIN_FD+0x18>
    210a:	22e70653          	fmv.d	fa2,fa4
        while (*str >= '0' && *str <= '9')
    210e:	4525                	li	a0,9
            val += (*str - '0') / div;
    2110:	d20606d3          	fcvt.d.w	fa3,a2
        while (*str >= '0' && *str <= '9')
    2114:	0017c683          	lbu	a3,1(a5)
            str++;
    2118:	0785                	addi	a5,a5,1
            val += (*str - '0') / div;
    211a:	1ac6f6d3          	fdiv.d	fa3,fa3,fa2
        while (*str >= '0' && *str <= '9')
    211e:	fd06861b          	addiw	a2,a3,-48
    2122:	0ff67593          	zext.b	a1,a2
            div *= 10.0;
    2126:	12e67653          	fmul.d	fa2,fa2,fa4
            val += (*str - '0') / div;
    212a:	02d7f7d3          	fadd.d	fa5,fa5,fa3
        while (*str >= '0' && *str <= '9')
    212e:	feb571e3          	bgeu	a0,a1,2110 <_vscanf_core.constprop.0+0x798>
    2132:	bd81                	j	1f82 <_vscanf_core.constprop.0+0x60a>
                    *va_arg(ap, double *) = val;
    2134:	a39c                	fsd	fa5,0(a5)
                assigned++;
    2136:	2b05                	addiw	s6,s6,1
    2138:	b62d                	j	1c62 <_vscanf_core.constprop.0+0x2ea>
                    *va_arg(ap, int64 *) = val;
    213a:	6722                	ld	a4,8(sp)
    213c:	6314                	ld	a3,0(a4)
    213e:	e288                	sd	a0,0(a3)
    2140:	b55d                	j	1fe6 <_vscanf_core.constprop.0+0x66e>
                    *va_arg(ap, long *) = (long)val;
    2142:	e288                	sd	a0,0(a3)
    2144:	b54d                	j	1fe6 <_vscanf_core.constprop.0+0x66e>
    while (*str >= '0' && *str <= '9')
    2146:	00005797          	auipc	a5,0x5
    214a:	8327b587          	fld	fa1,-1998(a5) # 6978 <STDIN_FD+0x10>
    214e:	02114603          	lbu	a2,33(sp)
        str++;
    2152:	02110793          	addi	a5,sp,33
    2156:	b3ed                	j	1f40 <_vscanf_core.constprop.0+0x5c8>
        while (*str >= '0' && *str <= '9')
    2158:	0027c583          	lbu	a1,2(a5)
            str++;
    215c:	00278693          	addi	a3,a5,2
        while (*str >= '0' && *str <= '9')
    2160:	4525                	li	a0,9
    2162:	fd05861b          	addiw	a2,a1,-48
    2166:	0ff67793          	zext.b	a5,a2
            esign = -1;
    216a:	587d                	li	a6,-1
        while (*str >= '0' && *str <= '9')
    216c:	f0f577e3          	bgeu	a0,a5,207a <_vscanf_core.constprop.0+0x702>
        double p = 1.0;
    2170:	00005797          	auipc	a5,0x5
    2174:	8087b687          	fld	fa3,-2040(a5) # 6978 <STDIN_FD+0x10>
            val /= p;
    2178:	1ad7f7d3          	fdiv.d	fa5,fa5,fa3
    217c:	bd09                	j	1f8e <_vscanf_core.constprop.0+0x616>
        while (*str >= '0' && *str <= '9')
    217e:	0027c583          	lbu	a1,2(a5)
            str++;
    2182:	00278693          	addi	a3,a5,2
        while (*str >= '0' && *str <= '9')
    2186:	4525                	li	a0,9
    2188:	fd05861b          	addiw	a2,a1,-48
    218c:	0ff67793          	zext.b	a5,a2
    2190:	f2f56fe3          	bltu	a0,a5,20ce <_vscanf_core.constprop.0+0x756>
        int esign = 1;
    2194:	4805                	li	a6,1
    2196:	b5d5                	j	207a <_vscanf_core.constprop.0+0x702>
    while (*p)
    2198:	001bc783          	lbu	a5,1(s7)
    219c:	bed5                	j	1d90 <_vscanf_core.constprop.0+0x418>
            if (!suppress)
    219e:	9e0997e3          	bnez	s3,1b8c <_vscanf_core.constprop.0+0x214>
                buf[i] = '\0';
    21a2:	67e2                	ld	a5,24(sp)
    21a4:	00078023          	sb	zero,0(a5)
    21a8:	b2d5                	j	1b8c <_vscanf_core.constprop.0+0x214>
            num_buf[i] = '\0';
    21aa:	040d0793          	addi	a5,s10,64
    21ae:	1018                	addi	a4,sp,32
    21b0:	97ba                	add	a5,a5,a4
    21b2:	fc078023          	sb	zero,-64(a5)
            if (i == 0)
    21b6:	aa0d14e3          	bnez	s10,1c5e <_vscanf_core.constprop.0+0x2e6>
    21ba:	b171                	j	1e46 <_vscanf_core.constprop.0+0x4ce>
    21bc:	4641                	li	a2,16
                if (width > 0 && i >= width)
    21be:	a5204be3          	bgtz	s2,1c14 <_vscanf_core.constprop.0+0x29c>
    21c2:	bc99                	j	1c18 <_vscanf_core.constprop.0+0x2a0>
            num_buf[i] = '\0';
    21c4:	020100a3          	sb	zero,33(sp)
            if (i == 0)
    21c8:	bb99                	j	1f1e <_vscanf_core.constprop.0+0x5a6>
        double p = 1.0;
    21ca:	00004797          	auipc	a5,0x4
    21ce:	7ae7b687          	fld	fa3,1966(a5) # 6978 <STDIN_FD+0x10>
    21d2:	bdc5                	j	20c2 <_vscanf_core.constprop.0+0x74a>
                buf[i] = '\0';
    21d4:	67e2                	ld	a5,24(sp)
    21d6:	01a786b3          	add	a3,a5,s10
    21da:	00068023          	sb	zero,0(a3)
        ctx->ungotten = c;
    21de:	00adac23          	sw	a0,24(s11)
    while (*p)
    21e2:	001bc783          	lbu	a5,1(s7)
    21e6:	b6f5                	j	1dd2 <_vscanf_core.constprop.0+0x45a>

00000000000021e8 <_out_char>:
{
    21e8:	7179                	addi	sp,sp,-48
    21ea:	ec26                	sd	s1,24(sp)
    if (ctx->stream)
    21ec:	6d04                	ld	s1,24(a0)
{
    21ee:	f022                	sd	s0,32(sp)
    21f0:	f406                	sd	ra,40(sp)
    21f2:	842a                	mv	s0,a0
    21f4:	872e                	mv	a4,a1
    if (ctx->stream)
    21f6:	c0a1                	beqz	s1,2236 <_out_char+0x4e>
    21f8:	e84a                	sd	s2,16(sp)
    if (stream->buf_mode == 2)
    21fa:	41c4a903          	lw	s2,1052(s1)
    21fe:	4789                	li	a5,2
    2200:	04f90d63          	beq	s2,a5,225a <_out_char+0x72>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    2204:	4104a783          	lw	a5,1040(s1)
    if (stream->buf_write_pos >= BUFSIZ)
    2208:	3ff00693          	li	a3,1023
    stream->buffer[stream->buf_write_pos++] = (char)c;
    220c:	0017861b          	addiw	a2,a5,1
    2210:	40c4a823          	sw	a2,1040(s1)
    2214:	97a6                	add	a5,a5,s1
    2216:	00b78823          	sb	a1,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    221a:	08c6c063          	blt	a3,a2,229a <_out_char+0xb2>
    else if (stream->buf_mode == 1 && c == '\n')
    221e:	4785                	li	a5,1
    2220:	04f90a63          	beq	s2,a5,2274 <_out_char+0x8c>
        ctx->written++;
    2224:	681c                	ld	a5,16(s0)
    2226:	6942                	ld	s2,16(sp)
}
    2228:	70a2                	ld	ra,40(sp)
        ctx->written++;
    222a:	0785                	addi	a5,a5,1
    222c:	e81c                	sd	a5,16(s0)
}
    222e:	7402                	ld	s0,32(sp)
    2230:	64e2                	ld	s1,24(sp)
    2232:	6145                	addi	sp,sp,48
    2234:	8082                	ret
        if (ctx->limit > 0 && ctx->written < ctx->limit - 1)
    2236:	6514                	ld	a3,8(a0)
    2238:	691c                	ld	a5,16(a0)
    223a:	ca89                	beqz	a3,224c <_out_char+0x64>
    223c:	16fd                	addi	a3,a3,-1
    223e:	00d7f763          	bgeu	a5,a3,224c <_out_char+0x64>
            ctx->buf[ctx->written] = c;
    2242:	6114                	ld	a3,0(a0)
    2244:	97b6                	add	a5,a5,a3
    2246:	00b78023          	sb	a1,0(a5)
        ctx->written++;
    224a:	691c                	ld	a5,16(a0)
    224c:	0785                	addi	a5,a5,1
}
    224e:	70a2                	ld	ra,40(sp)
        ctx->written++;
    2250:	e81c                	sd	a5,16(s0)
}
    2252:	7402                	ld	s0,32(sp)
    2254:	64e2                	ld	s1,24(sp)
    2256:	6145                	addi	sp,sp,48
    2258:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    225a:	4088                	lw	a0,0(s1)
    225c:	4605                	li	a2,1
    225e:	00f10593          	addi	a1,sp,15
        char ch = (char)c;
    2262:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    2266:	e8bfe0ef          	jal	10f0 <write>
    226a:	4785                	li	a5,1
    226c:	faf50ce3          	beq	a0,a5,2224 <_out_char+0x3c>
            stream->error = 1;
    2270:	c49c                	sw	a5,8(s1)
            return EOF;
    2272:	bf4d                	j	2224 <_out_char+0x3c>
    else if (stream->buf_mode == 1 && c == '\n')
    2274:	47a9                	li	a5,10
    2276:	faf597e3          	bne	a1,a5,2224 <_out_char+0x3c>
    if (stream->buf_write_pos > 0)
    227a:	fac055e3          	blez	a2,2224 <_out_char+0x3c>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    227e:	4088                	lw	a0,0(s1)
    2280:	01048593          	addi	a1,s1,16
    2284:	e6dfe0ef          	jal	10f0 <write>
        if (ret < stream->buf_write_pos)
    2288:	4104a783          	lw	a5,1040(s1)
    228c:	02f55063          	bge	a0,a5,22ac <_out_char+0xc4>
            stream->error = 1;
    2290:	0124a423          	sw	s2,8(s1)
            stream->buf_write_pos = 0;
    2294:	4004a823          	sw	zero,1040(s1)
            return EOF;
    2298:	b771                	j	2224 <_out_char+0x3c>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    229a:	4088                	lw	a0,0(s1)
    229c:	01048593          	addi	a1,s1,16
    22a0:	e51fe0ef          	jal	10f0 <write>
        if (ret < stream->buf_write_pos)
    22a4:	4104a783          	lw	a5,1040(s1)
    22a8:	00f54563          	blt	a0,a5,22b2 <_out_char+0xca>
        stream->buf_write_pos = 0;
    22ac:	4004a823          	sw	zero,1040(s1)
    22b0:	bf95                	j	2224 <_out_char+0x3c>
            stream->error = 1;
    22b2:	4785                	li	a5,1
    22b4:	c49c                	sw	a5,8(s1)
            stream->buf_write_pos = 0;
    22b6:	4004a823          	sw	zero,1040(s1)
            return EOF;
    22ba:	b7ad                	j	2224 <_out_char+0x3c>

00000000000022bc <stbsp_set_separators>:
   "75767778798081828384858687888990919293949596979899"
};

STBSP__PUBLICDEF void STB_SPRINTF_DECORATE(set_separators)(char pcomma, char pperiod)
{
   stbsp__period = pperiod;
    22bc:	00006797          	auipc	a5,0x6
    22c0:	c5c78793          	addi	a5,a5,-932 # 7f18 <stbsp__digitpair>
    22c4:	0cb78623          	sb	a1,204(a5)
   stbsp__comma = pcomma;
    22c8:	0ca786a3          	sb	a0,205(a5)
}
    22cc:	8082                	ret

00000000000022ce <stbsp_vsprintfcb>:

   return (stbsp__uint32)(sn - s);
}

STBSP__PUBLICDEF int STB_SPRINTF_DECORATE(vsprintfcb)(STBSP_SPRINTFCB *callback, void *user, char *buf, char const *fmt, va_list va)
{
    22ce:	d1010113          	addi	sp,sp,-752
            // Check if the next 4 bytes contain %(0x25) or end of string.
            // Using the 'hasless' trick:
            // https://graphics.stanford.edu/~seander/bithacks.html#HasLessInWord
            stbsp__uint32 v, c;
            v = *(stbsp__uint32 *)f;
            c = (~v) & 0x80808080;
    22d2:	808087b7          	lui	a5,0x80808
            if (((v ^ 0x25252525) - 0x01010101) & c)
    22d6:	252523b7          	lui	t2,0x25252
    22da:	52538393          	addi	t2,t2,1317 # 25252525 <_ZSt4cerr+0x252496b5>
{
    22de:	29913c23          	sd	s9,664(sp)
    22e2:	29b13423          	sd	s11,648(sp)
   int tlen = 0;
    22e6:	4c81                	li	s9,0
            if (((v ^ 0x25252525) - 0x01010101) & c)
    22e8:	feff0db7          	lui	s11,0xfeff0
            c = (~v) & 0x80808080;
    22ec:	08078793          	addi	a5,a5,128 # ffffffff80808080 <_ZSt4cerr+0xffffffff807ff210>
{
    22f0:	2e813023          	sd	s0,736(sp)
    22f4:	2c913c23          	sd	s1,728(sp)
    22f8:	2d213823          	sd	s2,720(sp)
    22fc:	2d313423          	sd	s3,712(sp)
    2300:	2b713423          	sd	s7,680(sp)
    2304:	2b813023          	sd	s8,672(sp)
    2308:	29a13823          	sd	s10,656(sp)
    230c:	2e113423          	sd	ra,744(sp)
    2310:	8d66                	mv	s10,s9
    2312:	8432                	mv	s0,a2
    2314:	8c9e                	mv	s9,t2
    2316:	89aa                	mv	s3,a0
    2318:	e42e                	sd	a1,8(sp)
    231a:	84b6                	mv	s1,a3
    231c:	8bba                	mv	s7,a4
    231e:	fc02                	sd	zero,56(sp)
   for (;;) {
    2320:	8932                	mv	s2,a2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    2322:	effd8d9b          	addiw	s11,s11,-257 # fffffffffefefeff <_ZSt4cerr+0xfffffffffefe708f>
               goto schk1;
            if ((v - 0x01010101) & c)
               goto schk2;
            if (callback)
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    2326:	20000c13          	li	s8,512
    232a:	83be                	mv	t2,a5
         while (((stbsp__uintptr)f) & 3) {
    232c:	0034f793          	andi	a5,s1,3
    2330:	c7a9                	beqz	a5,237a <stbsp_vsprintfcb+0xac>
            if (f[0] == '%')
    2332:	0004c783          	lbu	a5,0(s1)
    2336:	02500713          	li	a4,37
    233a:	0ee78263          	beq	a5,a4,241e <stbsp_vsprintfcb+0x150>
            if (f[0] == 0)
    233e:	cbd9                	beqz	a5,23d4 <stbsp_vsprintfcb+0x106>
            stbsp__chk_cb_buf(1);
    2340:	02098663          	beqz	s3,236c <stbsp_vsprintfcb+0x9e>
    2344:	4124063b          	subw	a2,s0,s2
    2348:	1fe00713          	li	a4,510
    234c:	02c75063          	bge	a4,a2,236c <stbsp_vsprintfcb+0x9e>
    2350:	65a2                	ld	a1,8(sp)
    2352:	854a                	mv	a0,s2
    2354:	e81e                	sd	t2,16(sp)
    2356:	00cd0d3b          	addw	s10,s10,a2
    235a:	9982                	jalr	s3
    235c:	892a                	mv	s2,a0
    235e:	e119                	bnez	a0,2364 <stbsp_vsprintfcb+0x96>
    2360:	0200106f          	j	3380 <stbsp_vsprintfcb+0x10b2>
            *bf++ = f[0];
    2364:	0004c783          	lbu	a5,0(s1)
            stbsp__chk_cb_buf(1);
    2368:	63c2                	ld	t2,16(sp)
    236a:	842a                	mv	s0,a0
            ++f;
    236c:	0485                	addi	s1,s1,1
            *bf++ = f[0];
    236e:	00f40023          	sb	a5,0(s0)
         while (((stbsp__uintptr)f) & 3) {
    2372:	0034f793          	andi	a5,s1,3
            *bf++ = f[0];
    2376:	0405                	addi	s0,s0,1
         while (((stbsp__uintptr)f) & 3) {
    2378:	ffcd                	bnez	a5,2332 <stbsp_vsprintfcb+0x64>
            v = *(stbsp__uint32 *)f;
    237a:	4094                	lw	a3,0(s1)
            c = (~v) & 0x80808080;
    237c:	fff6c793          	not	a5,a3
            if (((v ^ 0x25252525) - 0x01010101) & c)
    2380:	0196c733          	xor	a4,a3,s9
            c = (~v) & 0x80808080;
    2384:	0077f7b3          	and	a5,a5,t2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    2388:	01b7073b          	addw	a4,a4,s11
    238c:	8f7d                	and	a4,a4,a5
    238e:	2701                	sext.w	a4,a4
    2390:	f34d                	bnez	a4,2332 <stbsp_vsprintfcb+0x64>
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    2392:	460d                	li	a2,3
    2394:	a805                	j	23c4 <stbsp_vsprintfcb+0xf6>
            if (callback)
    2396:	00098863          	beqz	s3,23a6 <stbsp_vsprintfcb+0xd8>
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    239a:	412407b3          	sub	a5,s0,s2
    239e:	40fc07bb          	subw	a5,s8,a5
    23a2:	f8f658e3          	bge	a2,a5,2332 <stbsp_vsprintfcb+0x64>
                    bf[2] = f[2];
                    bf[3] = f[3];
                } else
            #endif
            {
                *(stbsp__uint32 *)bf = v;
    23a6:	c014                	sw	a3,0(s0)
            v = *(stbsp__uint32 *)f;
    23a8:	40d4                	lw	a3,4(s1)
            }
            bf += 4;
    23aa:	0411                	addi	s0,s0,4
            f += 4;
    23ac:	0491                	addi	s1,s1,4
            c = (~v) & 0x80808080;
    23ae:	fff6c793          	not	a5,a3
            if (((v ^ 0x25252525) - 0x01010101) & c)
    23b2:	0196c733          	xor	a4,a3,s9
            c = (~v) & 0x80808080;
    23b6:	0077f7b3          	and	a5,a5,t2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    23ba:	01b7073b          	addw	a4,a4,s11
    23be:	8f7d                	and	a4,a4,a5
    23c0:	2701                	sext.w	a4,a4
    23c2:	fb25                	bnez	a4,2332 <stbsp_vsprintfcb+0x64>
            if ((v - 0x01010101) & c)
    23c4:	01b6873b          	addw	a4,a3,s11
    23c8:	8ff9                	and	a5,a5,a4
    23ca:	2781                	sext.w	a5,a5
    23cc:	d7e9                	beqz	a5,2396 <stbsp_vsprintfcb+0xc8>
            if (f[0] == 0)
    23ce:	0004c783          	lbu	a5,0(s1)
    23d2:	f7bd                	bnez	a5,2340 <stbsp_vsprintfcb+0x72>
endfmt:

   if (!callback)
      *bf = 0;
   else
      stbsp__flush_cb();
    23d4:	8cea                	mv	s9,s10
    23d6:	412404bb          	subw	s1,s0,s2
   if (!callback)
    23da:	70098563          	beqz	s3,2ae4 <stbsp_vsprintfcb+0x816>
      stbsp__flush_cb();
    23de:	00905663          	blez	s1,23ea <stbsp_vsprintfcb+0x11c>
    23e2:	65a2                	ld	a1,8(sp)
    23e4:	8626                	mv	a2,s1
    23e6:	854a                	mv	a0,s2
    23e8:	9982                	jalr	s3
    23ea:	009c8cbb          	addw	s9,s9,s1

done:
   return tlen + (int)(bf - buf);
}
    23ee:	2e813083          	ld	ra,744(sp)
    23f2:	2e013403          	ld	s0,736(sp)
    23f6:	2d813483          	ld	s1,728(sp)
    23fa:	2d013903          	ld	s2,720(sp)
    23fe:	2c813983          	ld	s3,712(sp)
    2402:	2a813b83          	ld	s7,680(sp)
    2406:	2a013c03          	ld	s8,672(sp)
    240a:	29013d03          	ld	s10,656(sp)
    240e:	28813d83          	ld	s11,648(sp)
    2412:	8566                	mv	a0,s9
    2414:	29813c83          	ld	s9,664(sp)
    2418:	2f010113          	addi	sp,sp,752
    241c:	8082                	ret
    241e:	2d413023          	sd	s4,704(sp)
    2422:	2b513c23          	sd	s5,696(sp)
    2426:	2b613823          	sd	s6,688(sp)
      tz = 0;
    242a:	00248693          	addi	a3,s1,2
      fl = 0;
    242e:	4e01                	li	t3,0
         switch (f[0]) {
    2430:	03f00593          	li	a1,63
    2434:	00004617          	auipc	a2,0x4
    2438:	e6460613          	addi	a2,a2,-412 # 6298 <_GLOBAL__sub_I__ZSt3cin+0x2a8>
    243c:	fff6c783          	lbu	a5,-1(a3)
    2440:	fff68493          	addi	s1,a3,-1
    2444:	fe07871b          	addiw	a4,a5,-32
    2448:	0ff77713          	zext.b	a4,a4
    244c:	00e5ec63          	bltu	a1,a4,2464 <stbsp_vsprintfcb+0x196>
    2450:	070a                	slli	a4,a4,0x2
    2452:	9732                	add	a4,a4,a2
    2454:	4318                	lw	a4,0(a4)
    2456:	9732                	add	a4,a4,a2
    2458:	8702                	jr	a4
      if (f[0] == '*') {
    245a:	0014c783          	lbu	a5,1(s1)
            fl |= STBSP__LEADINGZERO;
    245e:	010e6e13          	ori	t3,t3,16
            ++f;
    2462:	0485                	addi	s1,s1,1
      if (f[0] == '*') {
    2464:	02a00713          	li	a4,42
    2468:	0ce79163          	bne	a5,a4,252a <stbsp_vsprintfcb+0x25c>
         fw = va_arg(va, stbsp__uint32);
    246c:	000bab03          	lw	s6,0(s7)
         while ((f[0] >= '0') && (f[0] <= '9')) {
    2470:	0014c783          	lbu	a5,1(s1)
         fw = va_arg(va, stbsp__uint32);
    2474:	0ba1                	addi	s7,s7,8
         ++f;
    2476:	0485                	addi	s1,s1,1
      if (f[0] == '.') {
    2478:	02e00713          	li	a4,46
      pr = -1;
    247c:	58fd                	li	a7,-1
      if (f[0] == '.') {
    247e:	0ee78663          	beq	a5,a4,256a <stbsp_vsprintfcb+0x29c>
      switch (f[0]) {
    2482:	04900713          	li	a4,73
    2486:	10e78263          	beq	a5,a4,258a <stbsp_vsprintfcb+0x2bc>
    248a:	f987871b          	addiw	a4,a5,-104
    248e:	0ff77713          	zext.b	a4,a4
    2492:	46c9                	li	a3,18
    2494:	02e6e063          	bltu	a3,a4,24b4 <stbsp_vsprintfcb+0x1e6>
    2498:	00004697          	auipc	a3,0x4
    249c:	f0068693          	addi	a3,a3,-256 # 6398 <_GLOBAL__sub_I__ZSt3cin+0x3a8>
    24a0:	070a                	slli	a4,a4,0x2
    24a2:	9736                	add	a4,a4,a3
    24a4:	4318                	lw	a4,0(a4)
    24a6:	9736                	add	a4,a4,a3
    24a8:	8702                	jr	a4
         if (f[0] == 'h')
    24aa:	0014c783          	lbu	a5,1(s1)
         fl |= (sizeof(ptrdiff_t) == 8) ? STBSP__INTMAX : 0;
    24ae:	020e6e13          	ori	t3,t3,32
         ++f;
    24b2:	0485                	addi	s1,s1,1
      switch (f[0]) {
    24b4:	fbf7871b          	addiw	a4,a5,-65
    24b8:	0ff77713          	zext.b	a4,a4
    24bc:	03700693          	li	a3,55
    24c0:	0ee6ea63          	bltu	a3,a4,25b4 <stbsp_vsprintfcb+0x2e6>
    24c4:	00004697          	auipc	a3,0x4
    24c8:	f2068693          	addi	a3,a3,-224 # 63e4 <_GLOBAL__sub_I__ZSt3cin+0x3f4>
    24cc:	070a                	slli	a4,a4,0x2
    24ce:	9736                	add	a4,a4,a3
    24d0:	4318                	lw	a4,0(a4)
    24d2:	9736                	add	a4,a4,a3
    24d4:	8702                	jr	a4
            fl |= STBSP__METRIC_NOSPACE;
    24d6:	400e6e13          	ori	t3,t3,1024
            continue;
    24da:	0685                	addi	a3,a3,1
    24dc:	b785                	j	243c <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEFTJUST;
    24de:	001e6e13          	ori	t3,t3,1
            continue;
    24e2:	0685                	addi	a3,a3,1
    24e4:	bfa1                	j	243c <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADINGPLUS;
    24e6:	002e6e13          	ori	t3,t3,2
            continue;
    24ea:	0685                	addi	a3,a3,1
    24ec:	bf81                	j	243c <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__TRIPLET_COMMA;
    24ee:	040e6e13          	ori	t3,t3,64
            continue;
    24f2:	0685                	addi	a3,a3,1
    24f4:	b7a1                	j	243c <stbsp_vsprintfcb+0x16e>
            if (fl & STBSP__METRIC_SUFFIX) {
    24f6:	100e7793          	andi	a5,t3,256
    24fa:	8772                	mv	a4,t3
    24fc:	56078363          	beqz	a5,2a62 <stbsp_vsprintfcb+0x794>
               if (fl & STBSP__METRIC_1024) {
    2500:	6785                	lui	a5,0x1
    2502:	034e1513          	slli	a0,t3,0x34
    2506:	80078793          	addi	a5,a5,-2048 # 800 <_ZN6Parser10parse_pipeEPPcS0_+0xac>
    250a:	5c055863          	bgez	a0,2ada <stbsp_vsprintfcb+0x80c>
                  fl |= STBSP__METRIC_JEDEC;
    250e:	6785                	lui	a5,0x1
    2510:	8f5d                	or	a4,a4,a5
    2512:	00070e1b          	sext.w	t3,a4
    2516:	0685                	addi	a3,a3,1
    2518:	b715                	j	243c <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADING_0X;
    251a:	008e6e13          	ori	t3,t3,8
            continue;
    251e:	0685                	addi	a3,a3,1
    2520:	bf31                	j	243c <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADINGSPACE;
    2522:	004e6e13          	ori	t3,t3,4
            continue;
    2526:	0685                	addi	a3,a3,1
    2528:	bf11                	j	243c <stbsp_vsprintfcb+0x16e>
         while ((f[0] >= '0') && (f[0] <= '9')) {
    252a:	fd07871b          	addiw	a4,a5,-48 # fd0 <main+0x16e>
    252e:	0ff77713          	zext.b	a4,a4
    2532:	4625                	li	a2,9
      fw = 0;
    2534:	4b01                	li	s6,0
         while ((f[0] >= '0') && (f[0] <= '9')) {
    2536:	46a5                	li	a3,9
    2538:	f4e660e3          	bltu	a2,a4,2478 <stbsp_vsprintfcb+0x1aa>
            fw = fw * 10 + f[0] - '0';
    253c:	002b171b          	slliw	a4,s6,0x2
    2540:	0167073b          	addw	a4,a4,s6
    2544:	0017171b          	slliw	a4,a4,0x1
            f++;
    2548:	0485                	addi	s1,s1,1
            fw = fw * 10 + f[0] - '0';
    254a:	9f3d                	addw	a4,a4,a5
         while ((f[0] >= '0') && (f[0] <= '9')) {
    254c:	0004c783          	lbu	a5,0(s1)
            fw = fw * 10 + f[0] - '0';
    2550:	fd070b1b          	addiw	s6,a4,-48
         while ((f[0] >= '0') && (f[0] <= '9')) {
    2554:	fd07871b          	addiw	a4,a5,-48
    2558:	0ff77713          	zext.b	a4,a4
    255c:	fee6f0e3          	bgeu	a3,a4,253c <stbsp_vsprintfcb+0x26e>
      if (f[0] == '.') {
    2560:	02e00713          	li	a4,46
      pr = -1;
    2564:	58fd                	li	a7,-1
      if (f[0] == '.') {
    2566:	f0e79ee3          	bne	a5,a4,2482 <stbsp_vsprintfcb+0x1b4>
         if (f[0] == '*') {
    256a:	0014c783          	lbu	a5,1(s1)
    256e:	02a00713          	li	a4,42
    2572:	52e79763          	bne	a5,a4,2aa0 <stbsp_vsprintfcb+0x7d2>
            while ((f[0] >= '0') && (f[0] <= '9')) {
    2576:	0024c783          	lbu	a5,2(s1)
      switch (f[0]) {
    257a:	04900713          	li	a4,73
            pr = va_arg(va, stbsp__uint32);
    257e:	000ba883          	lw	a7,0(s7)
            ++f;
    2582:	0489                	addi	s1,s1,2
            pr = va_arg(va, stbsp__uint32);
    2584:	0ba1                	addi	s7,s7,8
      switch (f[0]) {
    2586:	f0e792e3          	bne	a5,a4,248a <stbsp_vsprintfcb+0x1bc>
         if ((f[1] == '6') && (f[2] == '4')) {
    258a:	0014c783          	lbu	a5,1(s1)
    258e:	03600713          	li	a4,54
    2592:	00e79463          	bne	a5,a4,259a <stbsp_vsprintfcb+0x2cc>
    2596:	1e60106f          	j	377c <stbsp_vsprintfcb+0x14ae>
         } else if ((f[1] == '3') && (f[2] == '2')) {
    259a:	03300713          	li	a4,51
    259e:	6ae796e3          	bne	a5,a4,344a <stbsp_vsprintfcb+0x117c>
    25a2:	0024c683          	lbu	a3,2(s1)
    25a6:	03200713          	li	a4,50
    25aa:	00e69463          	bne	a3,a4,25b2 <stbsp_vsprintfcb+0x2e4>
    25ae:	0ae0106f          	j	365c <stbsp_vsprintfcb+0x138e>
            ++f;
    25b2:	0485                	addi	s1,s1,1
         *s = f[0];
    25b4:	26f10fa3          	sb	a5,639(sp)
         l = 1;
    25b8:	4785                	li	a5,1
    25ba:	d0be                	sw	a5,96(sp)
         lead[0] = 0;
    25bc:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    25c0:	06010823          	sb	zero,112(sp)
         dp = 0;
    25c4:	d282                	sw	zero,100(sp)
    25c6:	e0de                	sd	s7,64(sp)
    25c8:	4701                	li	a4,0
    25ca:	4301                	li	t1,0
    25cc:	4f81                	li	t6,0
    25ce:	4685                	li	a3,1
    25d0:	4a01                	li	s4,0
         cs = 0;
    25d2:	4281                	li	t0,0
         s = num + STBSP__NUMSZ - 1;
    25d4:	27f10a93          	addi	s5,sp,639
         fw = fl = 0;
    25d8:	4e01                	li	t3,0
      tz = 0;
    25da:	4881                	li	a7,0
            if (fl & STBSP__LEADINGZERO) // if leading zeros, everything is in pr
    25dc:	010e7793          	andi	a5,t3,16
    25e0:	40078ee3          	beqz	a5,31fc <stbsp_vsprintfcb+0xf2e>
               pr = (fw > pr) ? fw : pr;
    25e4:	87ba                	mv	a5,a4
    25e6:	00675363          	bge	a4,t1,25ec <stbsp_vsprintfcb+0x31e>
    25ea:	879a                	mv	a5,t1
    25ec:	0007871b          	sext.w	a4,a5
               fw = 0;
    25f0:	4301                	li	t1,0
         if (fw + pr) {
    25f2:	62070563          	beqz	a4,2c1c <stbsp_vsprintfcb+0x94e>
            sn = lead + 1;
    25f6:	06910793          	addi	a5,sp,105
    25fa:	fcbe                	sd	a5,120(sp)
            while (lead[0]) {
    25fc:	0a0a0863          	beqz	s4,26ac <stbsp_vsprintfcb+0x3de>
               stbsp__cb_buf_clamp(i, lead[0]);
    2600:	f026                	sd	s1,32(sp)
    2602:	f436                	sd	a3,40(sp)
    2604:	854a                	mv	a0,s2
    2606:	86d2                	mv	a3,s4
    2608:	84ce                	mv	s1,s3
               stbsp__chk_cb_buf(1);
    260a:	1fe00b93          	li	s7,510
               stbsp__cb_buf_clamp(i, lead[0]);
    260e:	89be                	mv	s3,a5
    2610:	20000b13          	li	s6,512
    2614:	87a2                	mv	a5,s0
    2616:	e846                	sd	a7,16(sp)
    2618:	846a                	mv	s0,s10
    261a:	ec7e                	sd	t6,24(sp)
    261c:	8d6e                	mv	s10,s11
    261e:	f872                	sd	t3,48(sp)
    2620:	8de6                	mv	s11,s9
    2622:	8a3a                	mv	s4,a4
    2624:	e496                	sd	t0,72(sp)
    2626:	891a                	mv	s2,t1
    2628:	8c9e                	mv	s9,t2
    262a:	0006871b          	sext.w	a4,a3
    262e:	2e0482e3          	beqz	s1,3112 <stbsp_vsprintfcb+0xe44>
    2632:	40a7863b          	subw	a2,a5,a0
    2636:	40cb083b          	subw	a6,s6,a2
    263a:	85c2                	mv	a1,a6
    263c:	01075363          	bge	a4,a6,2642 <stbsp_vsprintfcb+0x374>
    2640:	85ba                	mv	a1,a4
               lead[0] -= (char)i;
    2642:	9e8d                	subw	a3,a3,a1
               stbsp__cb_buf_clamp(i, lead[0]);
    2644:	0005871b          	sext.w	a4,a1
               lead[0] -= (char)i;
    2648:	06d10423          	sb	a3,104(sp)
               while (i) {
    264c:	c70d                	beqz	a4,2676 <stbsp_vsprintfcb+0x3a8>
    264e:	7866                	ld	a6,120(sp)
    2650:	02071593          	slli	a1,a4,0x20
    2654:	9181                	srli	a1,a1,0x20
    2656:	00b78633          	add	a2,a5,a1
    265a:	8742                	mv	a4,a6
                  *bf++ = *sn++;
    265c:	00074683          	lbu	a3,0(a4)
    2660:	0785                	addi	a5,a5,1
               while (i) {
    2662:	0705                	addi	a4,a4,1
                  *bf++ = *sn++;
    2664:	fed78fa3          	sb	a3,-1(a5)
               while (i) {
    2668:	fec79ae3          	bne	a5,a2,265c <stbsp_vsprintfcb+0x38e>
    266c:	982e                	add	a6,a6,a1
    266e:	fcc2                	sd	a6,120(sp)
               stbsp__chk_cb_buf(1);
    2670:	c899                	beqz	s1,2686 <stbsp_vsprintfcb+0x3b8>
    2672:	40a7863b          	subw	a2,a5,a0
    2676:	00cbd863          	bge	s7,a2,2686 <stbsp_vsprintfcb+0x3b8>
    267a:	65a2                	ld	a1,8(sp)
    267c:	9c31                	addw	s0,s0,a2
    267e:	9482                	jalr	s1
    2680:	34050ee3          	beqz	a0,31dc <stbsp_vsprintfcb+0xf0e>
    2684:	87aa                	mv	a5,a0
            while (lead[0]) {
    2686:	06814683          	lbu	a3,104(sp)
    268a:	f2c5                	bnez	a3,262a <stbsp_vsprintfcb+0x35c>
    268c:	83e6                	mv	t2,s9
    268e:	68c2                	ld	a7,16(sp)
    2690:	8cee                	mv	s9,s11
    2692:	6fe2                	ld	t6,24(sp)
    2694:	8dea                	mv	s11,s10
    2696:	76a2                	ld	a3,40(sp)
    2698:	8d22                	mv	s10,s0
    269a:	7e42                	ld	t3,48(sp)
    269c:	843e                	mv	s0,a5
    269e:	62a6                	ld	t0,72(sp)
    26a0:	87ce                	mv	a5,s3
    26a2:	89a6                	mv	s3,s1
    26a4:	7482                	ld	s1,32(sp)
    26a6:	834a                	mv	t1,s2
    26a8:	8752                	mv	a4,s4
    26aa:	892a                	mv	s2,a0
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    26ac:	040e7b13          	andi	s6,t3,64
            c = cs >> 24;
    26b0:	0182d61b          	srliw	a2,t0,0x18
    26b4:	0182db9b          	srliw	s7,t0,0x18
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    26b8:	4a01                	li	s4,0
    26ba:	000b0e63          	beqz	s6,26d6 <stbsp_vsprintfcb+0x408>
            cs &= 0xffffff;
    26be:	02829a13          	slli	s4,t0,0x28
    26c2:	028a5a13          	srli	s4,s4,0x28
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    26c6:	00ea0a3b          	addw	s4,s4,a4
    26ca:	0016059b          	addiw	a1,a2,1
    26ce:	02ba7a3b          	remuw	s4,s4,a1
    26d2:	41460a3b          	subw	s4,a2,s4
            while (pr > 0) {
    26d6:	0ce05763          	blez	a4,27a4 <stbsp_vsprintfcb+0x4d6>
                     *(stbsp__uint32 *)bf = 0x30303030;
    26da:	30303837          	lui	a6,0x30303
    26de:	03080813          	addi	a6,a6,48 # 30303030 <_ZSt4cerr+0x302fa1c0>
    26e2:	f026                	sd	s1,32(sp)
    26e4:	854a                	mv	a0,s2
    26e6:	84da                	mv	s1,s6
    26e8:	895e                	mv	s2,s7
    26ea:	e4d6                	sd	s5,72(sp)
    26ec:	8b4e                	mv	s6,s3
    26ee:	8aea                	mv	s5,s10
               stbsp__chk_cb_buf(1);
    26f0:	1fe00293          	li	t0,510
    26f4:	8d6e                	mv	s10,s11
                     *bf++ = stbsp__comma;
    26f6:	00006f17          	auipc	t5,0x6
    26fa:	822f0f13          	addi	t5,t5,-2014 # 7f18 <stbsp__digitpair>
    26fe:	8de6                	mv	s11,s9
                     *bf++ = '0';
    2700:	03000e93          	li	t4,48
    2704:	e846                	sd	a7,16(sp)
    2706:	ec7e                	sd	t6,24(sp)
    2708:	f436                	sd	a3,40(sp)
    270a:	f872                	sd	t3,48(sp)
    270c:	e89a                	sd	t1,80(sp)
    270e:	89ba                	mv	s3,a4
    2710:	ecbe                	sd	a5,88(sp)
    2712:	8bc2                	mv	s7,a6
    2714:	8c9e                	mv	s9,t2
               stbsp__cb_buf_clamp(i, pr);
    2716:	240b0ee3          	beqz	s6,3172 <stbsp_vsprintfcb+0xea4>
    271a:	40a407b3          	sub	a5,s0,a0
    271e:	40fc063b          	subw	a2,s8,a5
    2722:	87b2                	mv	a5,a2
    2724:	00c9d363          	bge	s3,a2,272a <stbsp_vsprintfcb+0x45c>
    2728:	87ce                	mv	a5,s3
    272a:	0007859b          	sext.w	a1,a5
               pr -= i;
    272e:	40f989bb          	subw	s3,s3,a5
               if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    2732:	32048c63          	beqz	s1,2a6a <stbsp_vsprintfcb+0x79c>
               while (i) {
    2736:	34058a63          	beqz	a1,2a8a <stbsp_vsprintfcb+0x7bc>
    273a:	1582                	slli	a1,a1,0x20
                     *bf++ = stbsp__comma;
    273c:	0cdf4603          	lbu	a2,205(t5)
    2740:	9181                	srli	a1,a1,0x20
    2742:	95a2                	add	a1,a1,s0
    2744:	0405                	addi	s0,s0,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (cs++ == c)) {
    2746:	c481                	beqz	s1,274e <stbsp_vsprintfcb+0x480>
    2748:	1d4901e3          	beq	s2,s4,310a <stbsp_vsprintfcb+0xe3c>
    274c:	2a05                	addiw	s4,s4,1
                     *bf++ = '0';
    274e:	03000793          	li	a5,48
    2752:	fef40fa3          	sb	a5,-1(s0)
               while (i) {
    2756:	fe8597e3          	bne	a1,s0,2744 <stbsp_vsprintfcb+0x476>
               stbsp__chk_cb_buf(1);
    275a:	320b0b63          	beqz	s6,2a90 <stbsp_vsprintfcb+0x7c2>
    275e:	40a5863b          	subw	a2,a1,a0
    2762:	32c2d763          	bge	t0,a2,2a90 <stbsp_vsprintfcb+0x7c2>
    2766:	65a2                	ld	a1,8(sp)
    2768:	01560abb          	addw	s5,a2,s5
    276c:	9b02                	jalr	s6
    276e:	3a050ce3          	beqz	a0,3326 <stbsp_vsprintfcb+0x1058>
    2772:	842a                	mv	s0,a0
    2774:	1fe00293          	li	t0,510
    2778:	00005f17          	auipc	t5,0x5
    277c:	7a0f0f13          	addi	t5,t5,1952 # 7f18 <stbsp__digitpair>
    2780:	03000e93          	li	t4,48
            while (pr > 0) {
    2784:	f93049e3          	bgtz	s3,2716 <stbsp_vsprintfcb+0x448>
         while (lead[0]) {
    2788:	83e6                	mv	t2,s9
    278a:	68c2                	ld	a7,16(sp)
    278c:	8cee                	mv	s9,s11
    278e:	6fe2                	ld	t6,24(sp)
    2790:	8dea                	mv	s11,s10
    2792:	7482                	ld	s1,32(sp)
    2794:	8d56                	mv	s10,s5
    2796:	76a2                	ld	a3,40(sp)
    2798:	7e42                	ld	t3,48(sp)
    279a:	6346                	ld	t1,80(sp)
    279c:	67e6                	ld	a5,88(sp)
    279e:	6aa6                	ld	s5,72(sp)
    27a0:	892a                	mv	s2,a0
    27a2:	89da                	mv	s3,s6
    27a4:	06814a03          	lbu	s4,104(sp)
         sn = lead + 1;
    27a8:	fcbe                	sd	a5,120(sp)
         while (lead[0]) {
    27aa:	0a0a0263          	beqz	s4,284e <stbsp_vsprintfcb+0x580>
            stbsp__cb_buf_clamp(i, lead[0]);
    27ae:	ec26                	sd	s1,24(sp)
    27b0:	f036                	sd	a3,32(sp)
    27b2:	854a                	mv	a0,s2
    27b4:	86d2                	mv	a3,s4
    27b6:	84ce                	mv	s1,s3
    27b8:	87a2                	mv	a5,s0
            stbsp__chk_cb_buf(1);
    27ba:	1fe00b93          	li	s7,510
            stbsp__cb_buf_clamp(i, lead[0]);
    27be:	846a                	mv	s0,s10
    27c0:	20000b13          	li	s6,512
    27c4:	8d6e                	mv	s10,s11
    27c6:	e846                	sd	a7,16(sp)
    27c8:	8de6                	mv	s11,s9
    27ca:	8a7e                	mv	s4,t6
    27cc:	8972                	mv	s2,t3
    27ce:	899a                	mv	s3,t1
    27d0:	8c9e                	mv	s9,t2
    27d2:	0006871b          	sext.w	a4,a3
    27d6:	140482e3          	beqz	s1,311a <stbsp_vsprintfcb+0xe4c>
    27da:	40a7863b          	subw	a2,a5,a0
    27de:	40cb083b          	subw	a6,s6,a2
    27e2:	85c2                	mv	a1,a6
    27e4:	01075363          	bge	a4,a6,27ea <stbsp_vsprintfcb+0x51c>
    27e8:	85ba                	mv	a1,a4
            lead[0] -= (char)i;
    27ea:	9e8d                	subw	a3,a3,a1
            stbsp__cb_buf_clamp(i, lead[0]);
    27ec:	0005871b          	sext.w	a4,a1
            lead[0] -= (char)i;
    27f0:	06d10423          	sb	a3,104(sp)
            while (i) {
    27f4:	c70d                	beqz	a4,281e <stbsp_vsprintfcb+0x550>
    27f6:	7866                	ld	a6,120(sp)
    27f8:	02071593          	slli	a1,a4,0x20
    27fc:	9181                	srli	a1,a1,0x20
    27fe:	00b78633          	add	a2,a5,a1
    2802:	8742                	mv	a4,a6
               *bf++ = *sn++;
    2804:	00074683          	lbu	a3,0(a4)
    2808:	0785                	addi	a5,a5,1
            while (i) {
    280a:	0705                	addi	a4,a4,1
               *bf++ = *sn++;
    280c:	fed78fa3          	sb	a3,-1(a5)
            while (i) {
    2810:	fec79ae3          	bne	a5,a2,2804 <stbsp_vsprintfcb+0x536>
    2814:	982e                	add	a6,a6,a1
    2816:	fcc2                	sd	a6,120(sp)
            stbsp__chk_cb_buf(1);
    2818:	c899                	beqz	s1,282e <stbsp_vsprintfcb+0x560>
    281a:	40a7863b          	subw	a2,a5,a0
    281e:	00cbd863          	bge	s7,a2,282e <stbsp_vsprintfcb+0x560>
    2822:	65a2                	ld	a1,8(sp)
    2824:	9c31                	addw	s0,s0,a2
    2826:	9482                	jalr	s1
    2828:	1a050ae3          	beqz	a0,31dc <stbsp_vsprintfcb+0xf0e>
    282c:	87aa                	mv	a5,a0
         while (lead[0]) {
    282e:	06814683          	lbu	a3,104(sp)
    2832:	f2c5                	bnez	a3,27d2 <stbsp_vsprintfcb+0x504>
    2834:	834e                	mv	t1,s3
    2836:	68c2                	ld	a7,16(sp)
    2838:	89a6                	mv	s3,s1
    283a:	7682                	ld	a3,32(sp)
    283c:	64e2                	ld	s1,24(sp)
    283e:	8e4a                	mv	t3,s2
    2840:	83e6                	mv	t2,s9
    2842:	8fd2                	mv	t6,s4
    2844:	8cee                	mv	s9,s11
    2846:	892a                	mv	s2,a0
    2848:	8dea                	mv	s11,s10
    284a:	8d22                	mv	s10,s0
    284c:	843e                	mv	s0,a5
         while (n) {
    284e:	c6f9                	beqz	a3,291c <stbsp_vsprintfcb+0x64e>
            STBSP__UNALIGNED(while (i >= 4) {
    2850:	ec26                	sd	s1,24(sp)
    2852:	854a                	mv	a0,s2
    2854:	84d6                	mv	s1,s5
    2856:	896a                	mv	s2,s10
    2858:	87a2                	mv	a5,s0
    285a:	8d6e                	mv	s10,s11
            stbsp__chk_cb_buf(1);
    285c:	1fe00b93          	li	s7,510
            STBSP__UNALIGNED(while (i >= 4) {
    2860:	8de6                	mv	s11,s9
            stbsp__cb_buf_clamp(i, n);
    2862:	20000b13          	li	s6,512
            STBSP__UNALIGNED(while (i >= 4) {
    2866:	4a0d                	li	s4,3
    2868:	e87e                	sd	t6,16(sp)
    286a:	f072                	sd	t3,32(sp)
    286c:	8ac6                	mv	s5,a7
    286e:	f41a                	sd	t1,40(sp)
    2870:	8436                	mv	s0,a3
    2872:	8c9e                	mv	s9,t2
            stbsp__cb_buf_clamp(i, n);
    2874:	0004071b          	sext.w	a4,s0
    2878:	100982e3          	beqz	s3,317c <stbsp_vsprintfcb+0xeae>
    287c:	40a78633          	sub	a2,a5,a0
    2880:	40cb05bb          	subw	a1,s6,a2
    2884:	862e                	mv	a2,a1
    2886:	00b75363          	bge	a4,a1,288c <stbsp_vsprintfcb+0x5be>
    288a:	863a                	mv	a2,a4
    288c:	0006071b          	sext.w	a4,a2
            n -= i;
    2890:	9c11                	subw	s0,s0,a2
            STBSP__UNALIGNED(while (i >= 4) {
    2892:	14ea50e3          	bge	s4,a4,31d2 <stbsp_vsprintfcb+0xf04>
    2896:	ffc70f1b          	addiw	t5,a4,-4
    289a:	002f5e9b          	srliw	t4,t5,0x2
    289e:	001e8e1b          	addiw	t3,t4,1
    28a2:	0e0a                	slli	t3,t3,0x2
    28a4:	01c785b3          	add	a1,a5,t3
    28a8:	8626                	mv	a2,s1
    28aa:	4218                	lw	a4,0(a2)
    28ac:	0791                	addi	a5,a5,4
    28ae:	0611                	addi	a2,a2,4
    28b0:	2701                	sext.w	a4,a4
    28b2:	fee7ae23          	sw	a4,-4(a5)
    28b6:	feb79ae3          	bne	a5,a1,28aa <stbsp_vsprintfcb+0x5dc>
    28ba:	002e9e9b          	slliw	t4,t4,0x2
    28be:	41df073b          	subw	a4,t5,t4
            while (i) {
    28c2:	94f2                	add	s1,s1,t3
    28c4:	c31d                	beqz	a4,28ea <stbsp_vsprintfcb+0x61c>
    28c6:	8626                	mv	a2,s1
    28c8:	87ae                	mv	a5,a1
    28ca:	00e58f3b          	addw	t5,a1,a4
               *bf++ = *s++;
    28ce:	00064e83          	lbu	t4,0(a2)
    28d2:	0785                	addi	a5,a5,1
            while (i) {
    28d4:	00078e1b          	sext.w	t3,a5
               *bf++ = *s++;
    28d8:	ffd78fa3          	sb	t4,-1(a5)
    28dc:	0605                	addi	a2,a2,1
            while (i) {
    28de:	ffcf18e3          	bne	t5,t3,28ce <stbsp_vsprintfcb+0x600>
    28e2:	1702                	slli	a4,a4,0x20
    28e4:	9301                	srli	a4,a4,0x20
    28e6:	95ba                	add	a1,a1,a4
    28e8:	94ba                	add	s1,s1,a4
            stbsp__chk_cb_buf(1);
    28ea:	1a098763          	beqz	s3,2a98 <stbsp_vsprintfcb+0x7ca>
    28ee:	40a5863b          	subw	a2,a1,a0
    28f2:	1acbd363          	bge	s7,a2,2a98 <stbsp_vsprintfcb+0x7ca>
    28f6:	65a2                	ld	a1,8(sp)
    28f8:	0126093b          	addw	s2,a2,s2
    28fc:	9982                	jalr	s3
    28fe:	20050be3          	beqz	a0,3314 <stbsp_vsprintfcb+0x1046>
    2902:	87aa                	mv	a5,a0
         while (n) {
    2904:	f825                	bnez	s0,2874 <stbsp_vsprintfcb+0x5a6>
    2906:	6fc2                	ld	t6,16(sp)
    2908:	64e2                	ld	s1,24(sp)
    290a:	7e02                	ld	t3,32(sp)
    290c:	7322                	ld	t1,40(sp)
    290e:	83e6                	mv	t2,s9
    2910:	88d6                	mv	a7,s5
    2912:	8cee                	mv	s9,s11
    2914:	843e                	mv	s0,a5
    2916:	8dea                	mv	s11,s10
    2918:	8d4a                	mv	s10,s2
    291a:	892a                	mv	s2,a0
         while (tz) {
    291c:	08088863          	beqz	a7,29ac <stbsp_vsprintfcb+0x6de>
               *(stbsp__uint32 *)bf = 0x30303030;
    2920:	30303b37          	lui	s6,0x30303
               *bf++ = '0';
    2924:	03000a13          	li	s4,48
            while (i >= 4) {
    2928:	4a8d                	li	s5,3
            stbsp__chk_cb_buf(1);
    292a:	1fe00693          	li	a3,510
               *(stbsp__uint32 *)bf = 0x30303030;
    292e:	030b0b13          	addi	s6,s6,48 # 30303030 <_ZSt4cerr+0x302fa1c0>
            stbsp__cb_buf_clamp(i, tz);
    2932:	20000b93          	li	s7,512
    2936:	040989e3          	beqz	s3,3188 <stbsp_vsprintfcb+0xeba>
    293a:	41240633          	sub	a2,s0,s2
    293e:	40cb87bb          	subw	a5,s7,a2
    2942:	873e                	mv	a4,a5
    2944:	00f8d363          	bge	a7,a5,294a <stbsp_vsprintfcb+0x67c>
    2948:	8746                	mv	a4,a7
    294a:	0007079b          	sext.w	a5,a4
            tz -= i;
    294e:	40e888bb          	subw	a7,a7,a4
            while (i) {
    2952:	08078ee3          	beqz	a5,31ee <stbsp_vsprintfcb+0xf20>
               if ((((stbsp__uintptr)bf) & 3) == 0)
    2956:	00347713          	andi	a4,s0,3
    295a:	e719                	bnez	a4,2968 <stbsp_vsprintfcb+0x69a>
    295c:	0390006f          	j	3194 <stbsp_vsprintfcb+0xec6>
    2960:	00347713          	andi	a4,s0,3
    2964:	7a070f63          	beqz	a4,3122 <stbsp_vsprintfcb+0xe54>
               *bf++ = '0';
    2968:	01440023          	sb	s4,0(s0)
               --i;
    296c:	37fd                	addiw	a5,a5,-1
               *bf++ = '0';
    296e:	0405                	addi	s0,s0,1
            while (i) {
    2970:	fbe5                	bnez	a5,2960 <stbsp_vsprintfcb+0x692>
            stbsp__chk_cb_buf(1);
    2972:	02098b63          	beqz	s3,29a8 <stbsp_vsprintfcb+0x6da>
    2976:	4124063b          	subw	a2,s0,s2
    297a:	02c6d763          	bge	a3,a2,29a8 <stbsp_vsprintfcb+0x6da>
    297e:	65a2                	ld	a1,8(sp)
    2980:	854a                	mv	a0,s2
    2982:	f81e                	sd	t2,48(sp)
    2984:	f41a                	sd	t1,40(sp)
    2986:	f072                	sd	t3,32(sp)
    2988:	ec7e                	sd	t6,24(sp)
    298a:	e846                	sd	a7,16(sp)
    298c:	00cd0d3b          	addw	s10,s10,a2
    2990:	9982                	jalr	s3
    2992:	892a                	mv	s2,a0
    2994:	1a0502e3          	beqz	a0,3338 <stbsp_vsprintfcb+0x106a>
    2998:	73c2                	ld	t2,48(sp)
    299a:	7322                	ld	t1,40(sp)
    299c:	7e02                	ld	t3,32(sp)
    299e:	6fe2                	ld	t6,24(sp)
    29a0:	68c2                	ld	a7,16(sp)
    29a2:	842a                	mv	s0,a0
    29a4:	1fe00693          	li	a3,510
         while (tz) {
    29a8:	f80897e3          	bnez	a7,2936 <stbsp_vsprintfcb+0x668>
         sn = tail + 1;
    29ac:	07110793          	addi	a5,sp,113
    29b0:	fcbe                	sd	a5,120(sp)
         while (tail[0]) {
    29b2:	080f8763          	beqz	t6,2a40 <stbsp_vsprintfcb+0x772>
            stbsp__cb_buf_clamp(i, tail[0]);
    29b6:	854a                	mv	a0,s2
    29b8:	8b6a                	mv	s6,s10
            stbsp__chk_cb_buf(1);
    29ba:	1fe00a93          	li	s5,510
            stbsp__cb_buf_clamp(i, tail[0]);
    29be:	8d4e                	mv	s10,s3
    29c0:	20000a13          	li	s4,512
    29c4:	8bf2                	mv	s7,t3
    29c6:	891a                	mv	s2,t1
    29c8:	899e                	mv	s3,t2
    29ca:	000f879b          	sext.w	a5,t6
    29ce:	7c0d0863          	beqz	s10,319e <stbsp_vsprintfcb+0xed0>
    29d2:	40a4063b          	subw	a2,s0,a0
    29d6:	40ca06bb          	subw	a3,s4,a2
    29da:	8736                	mv	a4,a3
    29dc:	00d7d363          	bge	a5,a3,29e2 <stbsp_vsprintfcb+0x714>
    29e0:	873e                	mv	a4,a5
            tail[0] -= (char)i;
    29e2:	40ef8fbb          	subw	t6,t6,a4
            stbsp__cb_buf_clamp(i, tail[0]);
    29e6:	0007079b          	sext.w	a5,a4
            tail[0] -= (char)i;
    29ea:	07f10823          	sb	t6,112(sp)
            while (i) {
    29ee:	c795                	beqz	a5,2a1a <stbsp_vsprintfcb+0x74c>
    29f0:	75e6                	ld	a1,120(sp)
    29f2:	02079613          	slli	a2,a5,0x20
    29f6:	9201                	srli	a2,a2,0x20
    29f8:	00c406b3          	add	a3,s0,a2
    29fc:	87ae                	mv	a5,a1
               *bf++ = *sn++;
    29fe:	0007c703          	lbu	a4,0(a5)
    2a02:	0405                	addi	s0,s0,1
            while (i) {
    2a04:	0785                	addi	a5,a5,1
               *bf++ = *sn++;
    2a06:	fee40fa3          	sb	a4,-1(s0)
            while (i) {
    2a0a:	fed41ae3          	bne	s0,a3,29fe <stbsp_vsprintfcb+0x730>
    2a0e:	95b2                	add	a1,a1,a2
    2a10:	fcae                	sd	a1,120(sp)
            stbsp__chk_cb_buf(1);
    2a12:	000d0d63          	beqz	s10,2a2c <stbsp_vsprintfcb+0x75e>
    2a16:	40a4063b          	subw	a2,s0,a0
    2a1a:	00cad963          	bge	s5,a2,2a2c <stbsp_vsprintfcb+0x75e>
    2a1e:	65a2                	ld	a1,8(sp)
    2a20:	00cb0b3b          	addw	s6,s6,a2
    2a24:	9d02                	jalr	s10
    2a26:	200509e3          	beqz	a0,3438 <stbsp_vsprintfcb+0x116a>
    2a2a:	842a                	mv	s0,a0
         while (tail[0]) {
    2a2c:	07014f83          	lbu	t6,112(sp)
    2a30:	f80f9de3          	bnez	t6,29ca <stbsp_vsprintfcb+0x6fc>
    2a34:	834a                	mv	t1,s2
    2a36:	83ce                	mv	t2,s3
    2a38:	8e5e                	mv	t3,s7
    2a3a:	89ea                	mv	s3,s10
    2a3c:	892a                	mv	s2,a0
    2a3e:	8d5a                	mv	s10,s6
         if (fl & STBSP__LEFTJUST)
    2a40:	001e7e13          	andi	t3,t3,1
    2a44:	000e0663          	beqz	t3,2a50 <stbsp_vsprintfcb+0x782>
            if (fw > 0) {
    2a48:	00605463          	blez	t1,2a50 <stbsp_vsprintfcb+0x782>
    2a4c:	0300106f          	j	3a7c <stbsp_vsprintfcb+0x17ae>
   for (;;) {
    2a50:	6b86                	ld	s7,64(sp)
    2a52:	2c013a03          	ld	s4,704(sp)
    2a56:	2b813a83          	ld	s5,696(sp)
    2a5a:	2b013b03          	ld	s6,688(sp)
      ++f;
    2a5e:	0485                	addi	s1,s1,1
   for (;;) {
    2a60:	b0f1                	j	232c <stbsp_vsprintfcb+0x5e>
               fl |= STBSP__METRIC_SUFFIX;
    2a62:	100e6e13          	ori	t3,t3,256
            continue;
    2a66:	0685                	addi	a3,a3,1
    2a68:	bad1                	j	243c <stbsp_vsprintfcb+0x16e>
                  while (i) {
    2a6a:	0e0580e3          	beqz	a1,334a <stbsp_vsprintfcb+0x107c>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    2a6e:	00347793          	andi	a5,s0,3
    2a72:	e799                	bnez	a5,2a80 <stbsp_vsprintfcb+0x7b2>
    2a74:	0dd0006f          	j	3350 <stbsp_vsprintfcb+0x1082>
    2a78:	00347793          	andi	a5,s0,3
    2a7c:	72078463          	beqz	a5,31a4 <stbsp_vsprintfcb+0xed6>
                     *bf++ = '0';
    2a80:	01d40023          	sb	t4,0(s0)
                     --i;
    2a84:	35fd                	addiw	a1,a1,-1
                     *bf++ = '0';
    2a86:	0405                	addi	s0,s0,1
                  while (i) {
    2a88:	f9e5                	bnez	a1,2a78 <stbsp_vsprintfcb+0x7aa>
               while (i) {
    2a8a:	85a2                	mv	a1,s0
               stbsp__chk_cb_buf(1);
    2a8c:	cc0b19e3          	bnez	s6,275e <stbsp_vsprintfcb+0x490>
    2a90:	842e                	mv	s0,a1
            while (pr > 0) {
    2a92:	c93042e3          	bgtz	s3,2716 <stbsp_vsprintfcb+0x448>
    2a96:	b9cd                	j	2788 <stbsp_vsprintfcb+0x4ba>
            while (i) {
    2a98:	87ae                	mv	a5,a1
         while (n) {
    2a9a:	dc041de3          	bnez	s0,2874 <stbsp_vsprintfcb+0x5a6>
    2a9e:	b5a5                	j	2906 <stbsp_vsprintfcb+0x638>
            while ((f[0] >= '0') && (f[0] <= '9')) {
    2aa0:	fd07871b          	addiw	a4,a5,-48
    2aa4:	0ff77713          	zext.b	a4,a4
    2aa8:	4625                	li	a2,9
         ++f;
    2aaa:	0485                	addi	s1,s1,1
            pr = 0;
    2aac:	4881                	li	a7,0
            while ((f[0] >= '0') && (f[0] <= '9')) {
    2aae:	46a5                	li	a3,9
    2ab0:	9ce669e3          	bltu	a2,a4,2482 <stbsp_vsprintfcb+0x1b4>
               pr = pr * 10 + f[0] - '0';
    2ab4:	0028971b          	slliw	a4,a7,0x2
    2ab8:	0117073b          	addw	a4,a4,a7
    2abc:	0017171b          	slliw	a4,a4,0x1
               f++;
    2ac0:	0485                	addi	s1,s1,1
               pr = pr * 10 + f[0] - '0';
    2ac2:	9f3d                	addw	a4,a4,a5
            while ((f[0] >= '0') && (f[0] <= '9')) {
    2ac4:	0004c783          	lbu	a5,0(s1)
               pr = pr * 10 + f[0] - '0';
    2ac8:	fd07089b          	addiw	a7,a4,-48
            while ((f[0] >= '0') && (f[0] <= '9')) {
    2acc:	fd07871b          	addiw	a4,a5,-48
    2ad0:	0ff77713          	zext.b	a4,a4
    2ad4:	fee6f0e3          	bgeu	a3,a4,2ab4 <stbsp_vsprintfcb+0x7e6>
    2ad8:	b26d                	j	2482 <stbsp_vsprintfcb+0x1b4>
                  fl |= STBSP__METRIC_1024;
    2ada:	8f5d                	or	a4,a4,a5
    2adc:	00070e1b          	sext.w	t3,a4
    2ae0:	0685                	addi	a3,a3,1
    2ae2:	baa9                	j	243c <stbsp_vsprintfcb+0x16e>
      *bf = 0;
    2ae4:	00040023          	sb	zero,0(s0)
    2ae8:	b209                	j	23ea <stbsp_vsprintfcb+0x11c>
         if (f[0] == 'l') {
    2aea:	0014c783          	lbu	a5,1(s1)
    2aee:	06c00713          	li	a4,108
         fl |= ((sizeof(long) == 8) ? STBSP__INTMAX : 0);
    2af2:	020e6e13          	ori	t3,t3,32
         if (f[0] == 'l') {
    2af6:	00e78c63          	beq	a5,a4,2b0e <stbsp_vsprintfcb+0x840>
            ++f;
    2afa:	0485                	addi	s1,s1,1
    2afc:	ba65                	j	24b4 <stbsp_vsprintfcb+0x1e6>
         if (f[0] == 'h')
    2afe:	0014c783          	lbu	a5,1(s1)
    2b02:	06800713          	li	a4,104
         fl |= STBSP__HALFWIDTH;
    2b06:	200e6e13          	ori	t3,t3,512
         if (f[0] == 'h')
    2b0a:	fee798e3          	bne	a5,a4,2afa <stbsp_vsprintfcb+0x82c>
         if ((f[1] == '6') && (f[2] == '4')) {
    2b0e:	0024c783          	lbu	a5,2(s1)
            ++f;
    2b12:	0489                	addi	s1,s1,2
    2b14:	b245                	j	24b4 <stbsp_vsprintfcb+0x1e6>
         s = va_arg(va, char *);
    2b16:	008b8713          	addi	a4,s7,8
    2b1a:	e0ba                	sd	a4,64(sp)
         if (fl & STBSP__INTMAX) {
    2b1c:	020e7693          	andi	a3,t3,32
    2b20:	8772                	mv	a4,t3
    2b22:	24069ee3          	bnez	a3,357e <stbsp_vsprintfcb+0x12b0>
            stbsp__int32 i = va_arg(va, stbsp__int32);
    2b26:	000ba683          	lw	a3,0(s7)
            if ((f[0] != 'u') && (i < 0)) {
    2b2a:	07500613          	li	a2,117
            n64 = (stbsp__uint32)i;
    2b2e:	02069f13          	slli	t5,a3,0x20
    2b32:	020f5f13          	srli	t5,t5,0x20
            if ((f[0] != 'u') && (i < 0)) {
    2b36:	00c78a63          	beq	a5,a2,2b4a <stbsp_vsprintfcb+0x87c>
    2b3a:	0006d863          	bgez	a3,2b4a <stbsp_vsprintfcb+0x87c>
               fl |= STBSP__NEGATIVE;
    2b3e:	08076713          	ori	a4,a4,128
               n64 = (stbsp__uint32)-i;
    2b42:	40d00f3b          	negw	t5,a3
               fl |= STBSP__NEGATIVE;
    2b46:	00070e1b          	sext.w	t3,a4
         if (fl & STBSP__METRIC_SUFFIX) {
    2b4a:	100e7693          	andi	a3,t3,256
    2b4e:	5c0683e3          	beqz	a3,3914 <stbsp_vsprintfcb+0x1646>
            if (n64 < 1024)
    2b52:	3ff00793          	li	a5,1023
    2b56:	01e7e463          	bltu	a5,t5,2b5e <stbsp_vsprintfcb+0x890>
    2b5a:	0ea0106f          	j	3c44 <stbsp_vsprintfcb+0x1976>
            else if (pr == -1)
    2b5e:	57fd                	li	a5,-1
    2b60:	30f887e3          	beq	a7,a5,366e <stbsp_vsprintfcb+0x13a0>
            fv = (double)(stbsp__int64)n64;
    2b64:	d22f7553          	fcvt.d.l	fa0,t5
            if (fl & STBSP__METRIC_1024)
    2b68:	034e1793          	slli	a5,t3,0x34
    2b6c:	0007c463          	bltz	a5,2b74 <stbsp_vsprintfcb+0x8a6>
    2b70:	2300106f          	j	3da0 <stbsp_vsprintfcb+0x1ad2>
               divisor = 1024.0;
    2b74:	00004797          	auipc	a5,0x4
    2b78:	e147b787          	fld	fa5,-492(a5) # 6988 <STDIN_FD+0x20>
               if ((fv < divisor) && (fv > -divisor))
    2b7c:	22f79753          	fneg.d	fa4,fa5
               fl += 0x1000000;
    2b80:	010006b7          	lui	a3,0x1000
            while (fl < 0x4000000) {
    2b84:	04000737          	lui	a4,0x4000
               if ((fv < divisor) && (fv > -divisor))
    2b88:	a2f517d3          	flt.d	a5,fa0,fa5
    2b8c:	c789                	beqz	a5,2b96 <stbsp_vsprintfcb+0x8c8>
    2b8e:	a2a717d3          	flt.d	a5,fa4,fa0
    2b92:	3e079863          	bnez	a5,2f82 <stbsp_vsprintfcb+0xcb4>
               fl += 0x1000000;
    2b96:	01c68e3b          	addw	t3,a3,t3
               fv /= divisor;
    2b9a:	1af57553          	fdiv.d	fa0,fa0,fa5
            while (fl < 0x4000000) {
    2b9e:	feee65e3          	bltu	t3,a4,2b88 <stbsp_vsprintfcb+0x8ba>
    2ba2:	a6c5                	j	2f82 <stbsp_vsprintfcb+0xcb4>
         h = (f[0] == 'X') ? hexu : hex;
    2ba4:	05800693          	li	a3,88
         if (fl & STBSP__INTMAX) {
    2ba8:	020e7713          	andi	a4,t3,32
         h = (f[0] == 'X') ? hexu : hex;
    2bac:	00005817          	auipc	a6,0x5
    2bb0:	45480813          	addi	a6,a6,1108 # 8000 <hex.0>
    2bb4:	00d79663          	bne	a5,a3,2bc0 <stbsp_vsprintfcb+0x8f2>
    2bb8:	00005817          	auipc	a6,0x5
    2bbc:	43080813          	addi	a6,a6,1072 # 7fe8 <hexu.1>
         l = (4 << 4) | (4 << 8);
    2bc0:	44000793          	li	a5,1088
    2bc4:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__LEADING_0X) {
    2bc6:	008e7793          	andi	a5,t3,8
    2bca:	7a079263          	bnez	a5,336e <stbsp_vsprintfcb+0x10a0>
         lead[0] = 0;
    2bce:	06010423          	sb	zero,104(sp)
         s = va_arg(va, char *);
    2bd2:	008b8793          	addi	a5,s7,8
    2bd6:	e0be                	sd	a5,64(sp)
         if (fl & STBSP__INTMAX)
    2bd8:	72070b63          	beqz	a4,330e <stbsp_vsprintfcb+0x1040>
            n64 = va_arg(va, stbsp__uint64);
    2bdc:	000bb683          	ld	a3,0(s7)
         dp = 0;
    2be0:	d282                	sw	zero,100(sp)
         tail[0] = 0;
    2be2:	06010823          	sb	zero,112(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    2be6:	001e7513          	andi	a0,t3,1
         if (n64 == 0) {
    2bea:	380694e3          	bnez	a3,3772 <stbsp_vsprintfcb+0x14a4>
            lead[0] = 0;
    2bee:	06010423          	sb	zero,104(sp)
            if (pr == 0) {
    2bf2:	78089a63          	bnez	a7,3386 <stbsp_vsprintfcb+0x10b8>
         if (fw < (stbsp__int32)n)
    2bf6:	fffb4313          	not	t1,s6
    2bfa:	43f35313          	srai	t1,t1,0x3f
               l = 0;
    2bfe:	d082                	sw	zero,96(sp)
         if (fw < (stbsp__int32)n)
    2c00:	01637333          	and	t1,t1,s6
               goto scopy;
    2c04:	4701                	li	a4,0
    2c06:	4f81                	li	t6,0
    2c08:	4a01                	li	s4,0
               cs = 0;
    2c0a:	4281                	li	t0,0
         s = num + STBSP__NUMSZ;
    2c0c:	28010a93          	addi	s5,sp,640
         if ((fl & STBSP__LEFTJUST) == 0) {
    2c10:	9c0506e3          	beqz	a0,25dc <stbsp_vsprintfcb+0x30e>
         if (fw + pr) {
    2c14:	00e307bb          	addw	a5,t1,a4
    2c18:	9c079fe3          	bnez	a5,25f6 <stbsp_vsprintfcb+0x328>
    2c1c:	06910793          	addi	a5,sp,105
    2c20:	b661                	j	27a8 <stbsp_vsprintfcb+0x4da>
         h = (f[0] == 'E') ? hexu : hex;
    2c22:	04500713          	li	a4,69
    2c26:	00005317          	auipc	t1,0x5
    2c2a:	3da30313          	addi	t1,t1,986 # 8000 <hex.0>
    2c2e:	1ce78ae3          	beq	a5,a4,3602 <stbsp_vsprintfcb+0x1334>
         fv = va_arg(va, double);
    2c32:	008b8713          	addi	a4,s7,8
         if (pr == -1)
    2c36:	57fd                	li	a5,-1
         fv = va_arg(va, double);
    2c38:	e0ba                	sd	a4,64(sp)
    2c3a:	000bb507          	fld	fa0,0(s7)
         if (pr == -1)
    2c3e:	1af88ce3          	beq	a7,a5,35f6 <stbsp_vsprintfcb+0x1328>
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr | 0x80000000))
    2c42:	80000737          	lui	a4,0x80000
    2c46:	00e8e733          	or	a4,a7,a4
    2c4a:	2701                	sext.w	a4,a4
    2c4c:	10d4                	addi	a3,sp,100
    2c4e:	0110                	addi	a2,sp,128
    2c50:	108c                	addi	a1,sp,96
    2c52:	18a8                	addi	a0,sp,120
    2c54:	f41e                	sd	t2,40(sp)
    2c56:	f01a                	sd	t1,32(sp)
    2c58:	ec72                	sd	t3,24(sp)
    2c5a:	e846                	sd	a7,16(sp)
    2c5c:	d8efe0ef          	jal	11ea <stbsp__real_to_str>
    2c60:	68c2                	ld	a7,16(sp)
    2c62:	6e62                	ld	t3,24(sp)
    2c64:	7302                	ld	t1,32(sp)
    2c66:	73a2                	ld	t2,40(sp)
         if (dp == STBSP__SPECIAL) {
    2c68:	5796                	lw	a5,100(sp)
            s = (char *)sn;
    2c6a:	7ae6                	ld	s5,120(sp)
         if ((l - 1) > (stbsp__uint32)pr)
    2c6c:	5686                	lw	a3,96(sp)
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr | 0x80000000))
    2c6e:	3c0511e3          	bnez	a0,3830 <stbsp_vsprintfcb+0x1562>
         tail[0] = 0;
    2c72:	06010823          	sb	zero,112(sp)
   sign[0] = 0;
    2c76:	06010423          	sb	zero,104(sp)
   } else if (fl & STBSP__LEADINGSPACE) {
    2c7a:	004e7713          	andi	a4,t3,4
    2c7e:	6a070ee3          	beqz	a4,3b3a <stbsp_vsprintfcb+0x186c>
      sign[0] = 1;
    2c82:	6709                	lui	a4,0x2
    2c84:	0705                	addi	a4,a4,1 # 2001 <_vscanf_core.constprop.0+0x689>
    2c86:	06e11423          	sh	a4,104(sp)
         if (dp == STBSP__SPECIAL) {
    2c8a:	671d                	lui	a4,0x7
    2c8c:	1ee794e3          	bne	a5,a4,3674 <stbsp_vsprintfcb+0x13a6>
         if (pr < (stbsp__int32)l)
    2c90:	0006879b          	sext.w	a5,a3
         n = pr + lead[0] + tail[0] + tz;
    2c94:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    2c98:	fff7c793          	not	a5,a5
         n = pr + lead[0] + tail[0] + tz;
    2c9c:	07014f83          	lbu	t6,112(sp)
         if (pr < (stbsp__int32)l)
    2ca0:	97fd                	srai	a5,a5,0x3f
    2ca2:	8ff5                	and	a5,a5,a3
         n = pr + lead[0] + tail[0] + tz;
    2ca4:	00fa073b          	addw	a4,s4,a5
    2ca8:	01f7063b          	addw	a2,a4,t6
    2cac:	8732                	mv	a4,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    2cae:	001e7513          	andi	a0,t3,1
         if (pr < (stbsp__int32)l)
    2cb2:	2781                	sext.w	a5,a5
         if (fw < (stbsp__int32)n)
    2cb4:	835a                	mv	t1,s6
    2cb6:	00cb5363          	bge	s6,a2,2cbc <stbsp_vsprintfcb+0x9ee>
    2cba:	8332                	mv	t1,a2
         fw -= n;
    2cbc:	40e3033b          	subw	t1,t1,a4
            cs = 0;
    2cc0:	4281                	li	t0,0
         pr -= l;
    2cc2:	40d7873b          	subw	a4,a5,a3
      tz = 0;
    2cc6:	4881                	li	a7,0
            goto scopy;
    2cc8:	b7a1                	j	2c10 <stbsp_vsprintfcb+0x942>
         h = (f[0] == 'G') ? hexu : hex;
    2cca:	04700713          	li	a4,71
    2cce:	00005317          	auipc	t1,0x5
    2cd2:	33230313          	addi	t1,t1,818 # 8000 <hex.0>
    2cd6:	14e783e3          	beq	a5,a4,361c <stbsp_vsprintfcb+0x134e>
         fv = va_arg(va, double);
    2cda:	008b8713          	addi	a4,s7,8
         if (pr == -1)
    2cde:	57fd                	li	a5,-1
         fv = va_arg(va, double);
    2ce0:	e0ba                	sd	a4,64(sp)
    2ce2:	000bb507          	fld	fa0,0(s7)
         if (pr == -1)
    2ce6:	12f884e3          	beq	a7,a5,360e <stbsp_vsprintfcb+0x1340>
         else if (pr == 0)
    2cea:	6e0887e3          	beqz	a7,3bd8 <stbsp_vsprintfcb+0x190a>
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, (pr - 1) | 0x80000000))
    2cee:	fff8871b          	addiw	a4,a7,-1
    2cf2:	800007b7          	lui	a5,0x80000
    2cf6:	8f5d                	or	a4,a4,a5
    2cf8:	2701                	sext.w	a4,a4
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    2cfa:	00088a9b          	sext.w	s5,a7
    2cfe:	8a46                	mv	s4,a7
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, (pr - 1) | 0x80000000))
    2d00:	10d4                	addi	a3,sp,100
    2d02:	0110                	addi	a2,sp,128
    2d04:	108c                	addi	a1,sp,96
    2d06:	18a8                	addi	a0,sp,120
    2d08:	f01e                	sd	t2,32(sp)
    2d0a:	ec1a                	sd	t1,24(sp)
    2d0c:	e872                	sd	t3,16(sp)
    2d0e:	cdcfe0ef          	jal	11ea <stbsp__real_to_str>
    2d12:	6e42                	ld	t3,16(sp)
    2d14:	6362                	ld	t1,24(sp)
    2d16:	7382                	ld	t2,32(sp)
    2d18:	4281                	li	t0,0
    2d1a:	c509                	beqz	a0,2d24 <stbsp_vsprintfcb+0xa56>
            fl |= STBSP__NEGATIVE;
    2d1c:	080e6e13          	ori	t3,t3,128
    2d20:	08000293          	li	t0,128
         if (l > (stbsp__uint32)pr)
    2d24:	5806                	lw	a6,96(sp)
    2d26:	010af463          	bgeu	s5,a6,2d2e <stbsp_vsprintfcb+0xa60>
            l = pr;
    2d2a:	d0d6                	sw	s5,96(sp)
    2d2c:	8856                	mv	a6,s5
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2d2e:	4705                	li	a4,1
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    2d30:	5796                	lw	a5,100(sp)
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2d32:	01076463          	bltu	a4,a6,2d3a <stbsp_vsprintfcb+0xa6c>
    2d36:	1800106f          	j	3eb6 <stbsp_vsprintfcb+0x1be8>
    2d3a:	7be6                	ld	s7,120(sp)
    2d3c:	fff8071b          	addiw	a4,a6,-1
    2d40:	1702                	slli	a4,a4,0x20
    2d42:	9301                	srli	a4,a4,0x20
    2d44:	001a0e9b          	addiw	t4,s4,1
    2d48:	75e2                	ld	a1,56(sp)
    2d4a:	8ade                	mv	s5,s7
    2d4c:	975e                	add	a4,a4,s7
    2d4e:	410e8ebb          	subw	t4,t4,a6
    2d52:	88d2                	mv	a7,s4
    2d54:	86c2                	mv	a3,a6
    2d56:	4f01                	li	t5,0
    2d58:	03000f93          	li	t6,48
    2d5c:	e842                	sd	a6,16(sp)
    2d5e:	a809                	j	2d70 <stbsp_vsprintfcb+0xaa2>
            --pr;
    2d60:	38fd                	addiw	a7,a7,-1
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2d62:	211e80e3          	beq	t4,a7,3762 <stbsp_vsprintfcb+0x1494>
    2d66:	177d                	addi	a4,a4,-1 # 6fff <STDIN_FD+0x697>
    2d68:	4f05                	li	t5,1
    2d6a:	1e088ce3          	beqz	a7,3762 <stbsp_vsprintfcb+0x1494>
            --l;
    2d6e:	85b6                	mv	a1,a3
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2d70:	00074803          	lbu	a6,0(a4)
    2d74:	fff6861b          	addiw	a2,a3,-1 # ffffff <_ZSt4cerr+0xff718f>
    2d78:	0006851b          	sext.w	a0,a3
    2d7c:	2581                	sext.w	a1,a1
    2d7e:	0006069b          	sext.w	a3,a2
    2d82:	fdf80fe3          	beq	a6,t6,2d60 <stbsp_vsprintfcb+0xa92>
    2d86:	6842                	ld	a6,16(sp)
    2d88:	fc2e                	sd	a1,56(sp)
    2d8a:	86c2                	mv	a3,a6
    2d8c:	000f0463          	beqz	t5,2d94 <stbsp_vsprintfcb+0xac6>
    2d90:	d0ae                	sw	a1,96(sp)
    2d92:	86ae                	mv	a3,a1
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    2d94:	5775                	li	a4,-3
    2d96:	08e7cee3          	blt	a5,a4,3632 <stbsp_vsprintfcb+0x1364>
    2d9a:	08fa4be3          	blt	s4,a5,3630 <stbsp_vsprintfcb+0x1362>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    2d9e:	0005071b          	sext.w	a4,a0
         if (dp > 0) {
    2da2:	7ef057e3          	blez	a5,3d90 <stbsp_vsprintfcb+0x1ac2>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    2da6:	4881                	li	a7,0
    2da8:	00e7d463          	bge	a5,a4,2db0 <stbsp_vsprintfcb+0xae2>
    2dac:	40f508bb          	subw	a7,a0,a5
         tail[0] = 0;
    2db0:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    2db4:	20029463          	bnez	t0,2fbc <stbsp_vsprintfcb+0xcee>
   } else if (fl & STBSP__LEADINGSPACE) {
    2db8:	004e7713          	andi	a4,t3,4
    2dbc:	000715e3          	bnez	a4,35c6 <stbsp_vsprintfcb+0x12f8>
   } else if (fl & STBSP__LEADINGPLUS) {
    2dc0:	002e7713          	andi	a4,t3,2
    2dc4:	660719e3          	bnez	a4,3c36 <stbsp_vsprintfcb+0x1968>
   sign[0] = 0;
    2dc8:	06010423          	sb	zero,104(sp)
    2dcc:	aaed                	j	2fc6 <stbsp_vsprintfcb+0xcf8>
         h = (f[0] == 'A') ? hexu : hex;
    2dce:	04100713          	li	a4,65
    2dd2:	00005597          	auipc	a1,0x5
    2dd6:	22e58593          	addi	a1,a1,558 # 8000 <hex.0>
    2dda:	00e783e3          	beq	a5,a4,35e0 <stbsp_vsprintfcb+0x1312>
         fv = va_arg(va, double);
    2dde:	008b8693          	addi	a3,s7,8
         if (pr == -1)
    2de2:	577d                	li	a4,-1
         fv = va_arg(va, double);
    2de4:	e0b6                	sd	a3,64(sp)
    2de6:	000bb783          	ld	a5,0(s7)
         if (pr == -1)
    2dea:	7ee88963          	beq	a7,a4,35dc <stbsp_vsprintfcb+0x130e>
   d = value;

   STBSP__COPYFP(b, d);

   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    2dee:	4347d613          	srai	a2,a5,0x34
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    2df2:	00c79513          	slli	a0,a5,0xc
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    2df6:	7ff67613          	andi	a2,a2,2047
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    2dfa:	8131                	srli	a0,a0,0xc
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    2dfc:	c016061b          	addiw	a2,a2,-1023
         if (stbsp__real_to_parts((stbsp__int64 *)&n64, &dp, fv))
    2e00:	7a07c863          	bltz	a5,35b0 <stbsp_vsprintfcb+0x12e2>
   } else if (fl & STBSP__LEADINGSPACE) {
    2e04:	004e7793          	andi	a5,t3,4
    2e08:	60078ee3          	beqz	a5,3c24 <stbsp_vsprintfcb+0x1956>
    2e0c:	6789                	lui	a5,0x2
    2e0e:	2785                	addiw	a5,a5,1 # 2001 <_vscanf_core.constprop.0+0x689>
      sign[0] = 1;
    2e10:	06f11423          	sh	a5,104(sp)
    2e14:	468d                	li	a3,3
    2e16:	4a0d                	li	s4,3
    2e18:	4809                	li	a6,2
            n64 |= (((stbsp__uint64)1) << 52);
    2e1a:	4705                	li	a4,1
    2e1c:	1752                	slli	a4,a4,0x34
         if (dp == -1023)
    2e1e:	c0100793          	li	a5,-1023
            n64 |= (((stbsp__uint64)1) << 52);
    2e22:	8f49                	or	a4,a4,a0
         if (dp == -1023)
    2e24:	5cf600e3          	beq	a2,a5,3be4 <stbsp_vsprintfcb+0x1916>
         if (pr < 15)
    2e28:	4539                	li	a0,14
         n64 <<= (64 - 56);
    2e2a:	00871793          	slli	a5,a4,0x8
         if (pr < 15)
    2e2e:	251546e3          	blt	a0,a7,387a <stbsp_vsprintfcb+0x15ac>
            n64 += ((((stbsp__uint64)8) << 56) >> (pr * 4));
    2e32:	4705                	li	a4,1
    2e34:	0028951b          	slliw	a0,a7,0x2
    2e38:	176e                	slli	a4,a4,0x3b
    2e3a:	00a75733          	srl	a4,a4,a0
    2e3e:	973e                	add	a4,a4,a5
         *s++ = h[(n64 >> 60) & 15];
    2e40:	03c75793          	srli	a5,a4,0x3c
    2e44:	97ae                	add	a5,a5,a1
    2e46:	0007c503          	lbu	a0,0(a5)
         lead[1 + lead[0]] = '0';
    2e4a:	22080793          	addi	a5,a6,544
    2e4e:	06010813          	addi	a6,sp,96
    2e52:	97c2                	add	a5,a5,a6
    2e54:	03000813          	li	a6,48
    2e58:	df078423          	sb	a6,-536(a5)
         lead[2 + lead[0]] = 'x';
    2e5c:	22068793          	addi	a5,a3,544
    2e60:	1094                	addi	a3,sp,96
    2e62:	96be                	add	a3,a3,a5
    2e64:	07800793          	li	a5,120
    2e68:	def68423          	sb	a5,-536(a3)
         lead[0] += 2;
    2e6c:	07410423          	sb	s4,104(sp)
         *s++ = h[(n64 >> 60) & 15];
    2e70:	0ca10023          	sb	a0,192(sp)
         if (pr)
    2e74:	740893e3          	bnez	a7,3dba <stbsp_vsprintfcb+0x1aec>
         sn = s;
    2e78:	0c110793          	addi	a5,sp,193
    2e7c:	fcbe                	sd	a5,120(sp)
    2e7e:	4701                	li	a4,0
    2e80:	4501                	li	a0,0
    2e82:	4305                	li	t1,1
    2e84:	4685                	li	a3,1
         tail[1] = h[17];
    2e86:	0115c583          	lbu	a1,17(a1)
            tail[2] = '+';
    2e8a:	02b00793          	li	a5,43
         tail[1] = h[17];
    2e8e:	06b108a3          	sb	a1,113(sp)
         if (dp < 0) {
    2e92:	00065663          	bgez	a2,2e9e <stbsp_vsprintfcb+0xbd0>
            dp = -dp;
    2e96:	40c0063b          	negw	a2,a2
            tail[2] = '-';
    2e9a:	02d00793          	li	a5,45
            tail[n] = '0' + dp % 10;
    2e9e:	4829                	li	a6,10
    2ea0:	030665bb          	remw	a1,a2,a6
    2ea4:	06f10923          	sb	a5,114(sp)
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    2ea8:	3e700e93          	li	t4,999
            tail[n] = '0' + dp % 10;
    2eac:	0305859b          	addiw	a1,a1,48
    2eb0:	0ff5f593          	zext.b	a1,a1
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    2eb4:	18cec3e3          	blt	t4,a2,383a <stbsp_vsprintfcb+0x156c>
    2eb8:	06300e93          	li	t4,99
    2ebc:	54cec1e3          	blt	t4,a2,3bfe <stbsp_vsprintfcb+0x1930>
    2ec0:	4ea5                	li	t4,9
    2ec2:	72ced6e3          	bge	t4,a2,3dee <stbsp_vsprintfcb+0x1b20>
            dp /= 10;
    2ec6:	030647bb          	divw	a5,a2,a6
         tail[0] = (char)n;
    2eca:	4611                	li	a2,4
    2ecc:	06c10823          	sb	a2,112(sp)
            tail[n] = '0' + dp % 10;
    2ed0:	06b10a23          	sb	a1,116(sp)
    2ed4:	4811                	li	a6,4
    2ed6:	4f91                	li	t6,4
    2ed8:	0307879b          	addiw	a5,a5,48
    2edc:	06f109a3          	sb	a5,115(sp)
         n = pr + lead[0] + tail[0] + tz;
    2ee0:	006a07bb          	addw	a5,s4,t1
    2ee4:	010787bb          	addw	a5,a5,a6
    2ee8:	0117863b          	addw	a2,a5,a7
         dp = (int)(s - sn);
    2eec:	d2aa                	sw	a0,100(sp)
         l = (int)(s - (num + 64));
    2eee:	d0b6                	sw	a3,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    2ef0:	87b2                	mv	a5,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    2ef2:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    2ef6:	835a                	mv	t1,s6
    2ef8:	00cb5363          	bge	s6,a2,2efe <stbsp_vsprintfcb+0xc30>
    2efc:	8332                	mv	t1,a2
         cs = 1 + (3 << 24);
    2efe:	030002b7          	lui	t0,0x3000
         fw -= n;
    2f02:	40f3033b          	subw	t1,t1,a5
         cs = 1 + (3 << 24);
    2f06:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff7191>
         s = num + 64;
    2f08:	0c010a93          	addi	s5,sp,192
         goto scopy;
    2f0c:	b311                	j	2c10 <stbsp_vsprintfcb+0x942>
         h = (f[0] == 'B') ? hexu : hex;
    2f0e:	04200713          	li	a4,66
    2f12:	00005817          	auipc	a6,0x5
    2f16:	0ee80813          	addi	a6,a6,238 # 8000 <hex.0>
    2f1a:	6ce78963          	beq	a5,a4,35ec <stbsp_vsprintfcb+0x131e>
         if (fl & STBSP__LEADING_0X) {
    2f1e:	008e7793          	andi	a5,t3,8
    2f22:	66079e63          	bnez	a5,359e <stbsp_vsprintfcb+0x12d0>
         lead[0] = 0;
    2f26:	06010423          	sb	zero,104(sp)
         l = (8 << 4) | (1 << 8);
    2f2a:	18000793          	li	a5,384
    2f2e:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__INTMAX) {
    2f30:	020e7713          	andi	a4,t3,32
         goto radixnum;
    2f34:	b979                	j	2bd2 <stbsp_vsprintfcb+0x904>
         *s = (char)va_arg(va, int);
    2f36:	000ba783          	lw	a5,0(s7)
         l = 1;
    2f3a:	4705                	li	a4,1
    2f3c:	d0ba                	sw	a4,96(sp)
         *s = (char)va_arg(va, int);
    2f3e:	26f10fa3          	sb	a5,639(sp)
    2f42:	008b8793          	addi	a5,s7,8
         lead[0] = 0;
    2f46:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    2f4a:	06010823          	sb	zero,112(sp)
         dp = 0;
    2f4e:	d282                	sw	zero,100(sp)
         *s = (char)va_arg(va, int);
    2f50:	e0be                	sd	a5,64(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    2f52:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    2f56:	835a                	mv	t1,s6
    2f58:	69605063          	blez	s6,35d8 <stbsp_vsprintfcb+0x130a>
         fw -= n;
    2f5c:	337d                	addiw	t1,t1,-1
         goto scopy;
    2f5e:	4701                	li	a4,0
    2f60:	4f81                	li	t6,0
    2f62:	4685                	li	a3,1
    2f64:	4a01                	li	s4,0
         cs = 0;
    2f66:	4281                	li	t0,0
         s = num + STBSP__NUMSZ - 1;
    2f68:	27f10a93          	addi	s5,sp,639
      tz = 0;
    2f6c:	4881                	li	a7,0
         goto scopy;
    2f6e:	b14d                	j	2c10 <stbsp_vsprintfcb+0x942>
         fv = va_arg(va, double);
    2f70:	008b8713          	addi	a4,s7,8
         if (fl & STBSP__METRIC_SUFFIX) {
    2f74:	100e7793          	andi	a5,t3,256
         fv = va_arg(va, double);
    2f78:	e0ba                	sd	a4,64(sp)
    2f7a:	000bb507          	fld	fa0,0(s7)
         if (fl & STBSP__METRIC_SUFFIX) {
    2f7e:	be0795e3          	bnez	a5,2b68 <stbsp_vsprintfcb+0x89a>
         if (pr == -1)
    2f82:	57fd                	li	a5,-1
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    2f84:	0008871b          	sext.w	a4,a7
         if (pr == -1)
    2f88:	00f89463          	bne	a7,a5,2f90 <stbsp_vsprintfcb+0xcc2>
    2f8c:	4719                	li	a4,6
            pr = 6; // default is 6
    2f8e:	4899                	li	a7,6
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    2f90:	10d4                	addi	a3,sp,100
    2f92:	0110                	addi	a2,sp,128
    2f94:	108c                	addi	a1,sp,96
    2f96:	18a8                	addi	a0,sp,120
    2f98:	f01e                	sd	t2,32(sp)
    2f9a:	ec72                	sd	t3,24(sp)
    2f9c:	e846                	sd	a7,16(sp)
    2f9e:	a4cfe0ef          	jal	11ea <stbsp__real_to_str>
    2fa2:	6e62                	ld	t3,24(sp)
    2fa4:	68c2                	ld	a7,16(sp)
    2fa6:	7382                	ld	t2,32(sp)
         if (dp == STBSP__SPECIAL) {
    2fa8:	5796                	lw	a5,100(sp)
            if ((stbsp__int32)(l + n) > pr)
    2faa:	5686                	lw	a3,96(sp)
   if (fl & STBSP__NEGATIVE) {
    2fac:	080e7293          	andi	t0,t3,128
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    2fb0:	e00500e3          	beqz	a0,2db0 <stbsp_vsprintfcb+0xae2>
            fl |= STBSP__NEGATIVE;
    2fb4:	080e6e13          	ori	t3,t3,128
         tail[0] = 0;
    2fb8:	06010823          	sb	zero,112(sp)
      sign[0] = 1;
    2fbc:	670d                	lui	a4,0x3
    2fbe:	d0170713          	addi	a4,a4,-767 # 2d01 <stbsp_vsprintfcb+0xa33>
    2fc2:	06e11423          	sh	a4,104(sp)
         if (dp == STBSP__SPECIAL) {
    2fc6:	671d                	lui	a4,0x7
    2fc8:	7ce78963          	beq	a5,a4,379a <stbsp_vsprintfcb+0x14cc>
         if (dp <= 0) {
    2fcc:	46f05fe3          	blez	a5,3c4a <stbsp_vsprintfcb+0x197c>
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((600 - (stbsp__uint32)dp) % 3) : 0;
    2fd0:	040e7313          	andi	t1,t3,64
    2fd4:	00078e9b          	sext.w	t4,a5
    2fd8:	4581                	li	a1,0
    2fda:	00030963          	beqz	t1,2fec <stbsp_vsprintfcb+0xd1e>
    2fde:	25800593          	li	a1,600
    2fe2:	41d585bb          	subw	a1,a1,t4
    2fe6:	470d                	li	a4,3
    2fe8:	02e5f5bb          	remuw	a1,a1,a4
                     *s++ = stbsp__comma;
    2fec:	00005a17          	auipc	s4,0x5
    2ff0:	f2ca0a13          	addi	s4,s4,-212 # 7f18 <stbsp__digitpair>
            s = (char *)sn;
    2ff4:	7f66                	ld	t5,120(sp)
                     *s++ = stbsp__comma;
    2ff6:	0cda4283          	lbu	t0,205(s4)
         s = num + 64;
    2ffa:	0c010a93          	addi	s5,sp,192
            if ((stbsp__uint32)dp >= l) {
    2ffe:	44defb63          	bgeu	t4,a3,3454 <stbsp_vsprintfcb+0x1186>
               n = 0;
    3002:	4501                	li	a0,0
         s = num + 64;
    3004:	8756                	mv	a4,s5
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3006:	4b91                	li	s7,4
    3008:	a015                	j	302c <stbsp_vsprintfcb+0xd5e>
    300a:	8642                	mv	a2,a6
    300c:	883a                	mv	a6,a4
    300e:	8732                	mv	a4,a2
                     *s++ = sn[n];
    3010:	02051613          	slli	a2,a0,0x20
    3014:	9201                	srli	a2,a2,0x20
    3016:	967a                	add	a2,a2,t5
    3018:	00064f83          	lbu	t6,0(a2)
                     ++n;
    301c:	0015061b          	addiw	a2,a0,1
    3020:	0006051b          	sext.w	a0,a2
                     *s++ = sn[n];
    3024:	fff70fa3          	sb	t6,-1(a4) # 6fff <STDIN_FD+0x697>
                     if (n >= (stbsp__uint32)dp)
    3028:	7bd57563          	bgeu	a0,t4,37d2 <stbsp_vsprintfcb+0x1504>
                     *s++ = stbsp__comma;
    302c:	00170813          	addi	a6,a4,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3030:	fc030de3          	beqz	t1,300a <stbsp_vsprintfcb+0xd3c>
    3034:	2585                	addiw	a1,a1,1
    3036:	fd759ae3          	bne	a1,s7,300a <stbsp_vsprintfcb+0xd3c>
                     *s++ = stbsp__comma;
    303a:	fe580fa3          	sb	t0,-1(a6)
    303e:	0709                	addi	a4,a4,2
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3040:	4585                	li	a1,1
    3042:	b7f9                	j	3010 <stbsp_vsprintfcb+0xd42>
         *d = tlen + (int)(bf - buf);
    3044:	000bb703          	ld	a4,0(s7)
    3048:	412407b3          	sub	a5,s0,s2
    304c:	01a787bb          	addw	a5,a5,s10
         int *d = va_arg(va, int *);
    3050:	008b8693          	addi	a3,s7,8
    3054:	e0b6                	sd	a3,64(sp)
         *d = tlen + (int)(bf - buf);
    3056:	c31c                	sw	a5,0(a4)
      } break;
    3058:	bae5                	j	2a50 <stbsp_vsprintfcb+0x782>
         if (fl & STBSP__LEADING_0X) {
    305a:	008e7793          	andi	a5,t3,8
    305e:	50079b63          	bnez	a5,3574 <stbsp_vsprintfcb+0x12a6>
         lead[0] = 0;
    3062:	06010423          	sb	zero,104(sp)
         l = (3 << 4) | (3 << 8);
    3066:	33000793          	li	a5,816
    306a:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__INTMAX) {
    306c:	020e7713          	andi	a4,t3,32
         h = hexu;
    3070:	00005817          	auipc	a6,0x5
    3074:	f7880813          	addi	a6,a6,-136 # 7fe8 <hexu.1>
         goto radixnum;
    3078:	bea9                	j	2bd2 <stbsp_vsprintfcb+0x904>
         fl &= ~STBSP__LEADINGZERO; // 'p' only prints the pointer with zeros
    307a:	fefe7e13          	andi	t3,t3,-17
    307e:	020e6e13          	ori	t3,t3,32
    3082:	02000713          	li	a4,32
         pr = sizeof(void *) * 2;
    3086:	48c1                	li	a7,16
         h = (f[0] == 'X') ? hexu : hex;
    3088:	00005817          	auipc	a6,0x5
    308c:	f7880813          	addi	a6,a6,-136 # 8000 <hex.0>
    3090:	be05                	j	2bc0 <stbsp_vsprintfcb+0x8f2>
         s = va_arg(va, char *);
    3092:	000bba83          	ld	s5,0(s7)
    3096:	008b8793          	addi	a5,s7,8
    309a:	e0be                	sd	a5,64(sp)
         if (s == 0)
    309c:	360a8ee3          	beqz	s5,3c18 <stbsp_vsprintfcb+0x194a>
      if (((stbsp__uintptr)sn & 3) == 0)
    30a0:	003af793          	andi	a5,s5,3
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    30a4:	5208c663          	bltz	a7,35d0 <stbsp_vsprintfcb+0x1302>
    30a8:	0008869b          	sext.w	a3,a7
      if (((stbsp__uintptr)sn & 3) == 0)
    30ac:	2a0782e3          	beqz	a5,3b50 <stbsp_vsprintfcb+0x1882>
      if (!limit || *sn == 0)
    30b0:	5a068b63          	beqz	a3,3666 <stbsp_vsprintfcb+0x1398>
      if (((stbsp__uintptr)sn & 3) == 0)
    30b4:	87d6                	mv	a5,s5
    30b6:	a801                	j	30c6 <stbsp_vsprintfcb+0xdf8>
      ++sn;
    30b8:	0785                	addi	a5,a5,1
      if (((stbsp__uintptr)sn & 3) == 0)
    30ba:	0037f713          	andi	a4,a5,3
      --limit;
    30be:	36fd                	addiw	a3,a3,-1
      if (((stbsp__uintptr)sn & 3) == 0)
    30c0:	280709e3          	beqz	a4,3b52 <stbsp_vsprintfcb+0x1884>
      if (!limit || *sn == 0)
    30c4:	c681                	beqz	a3,30cc <stbsp_vsprintfcb+0xdfe>
    30c6:	0007c703          	lbu	a4,0(a5)
    30ca:	f77d                	bnez	a4,30b8 <stbsp_vsprintfcb+0xdea>
         return (stbsp__uint32)(sn - s);
    30cc:	415787b3          	sub	a5,a5,s5
    30d0:	0007869b          	sext.w	a3,a5
         if (pr < (stbsp__int32)l)
    30d4:	fff6c713          	not	a4,a3
    30d8:	977d                	srai	a4,a4,0x3f
    30da:	8f7d                	and	a4,a4,a5
    30dc:	0007079b          	sext.w	a5,a4
         n = pr + lead[0] + tail[0] + tz;
    30e0:	863e                	mv	a2,a5
         pr -= l;
    30e2:	9f15                	subw	a4,a4,a3
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    30e4:	d0b6                	sw	a3,96(sp)
         lead[0] = 0;
    30e6:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    30ea:	06010823          	sb	zero,112(sp)
         dp = 0;
    30ee:	d282                	sw	zero,100(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    30f0:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    30f4:	835a                	mv	t1,s6
    30f6:	00fb5363          	bge	s6,a5,30fc <stbsp_vsprintfcb+0xe2e>
    30fa:	833e                	mv	t1,a5
         fw -= n;
    30fc:	40c3033b          	subw	t1,t1,a2
         goto scopy;
    3100:	4f81                	li	t6,0
    3102:	4a01                	li	s4,0
         cs = 0;
    3104:	4281                	li	t0,0
      tz = 0;
    3106:	4881                	li	a7,0
         goto scopy;
    3108:	b621                	j	2c10 <stbsp_vsprintfcb+0x942>
                     *bf++ = stbsp__comma;
    310a:	87b2                	mv	a5,a2
                     cs = 0;
    310c:	4a01                	li	s4,0
    310e:	e44ff06f          	j	2752 <stbsp_vsprintfcb+0x484>
               lead[0] -= (char)i;
    3112:	06010423          	sb	zero,104(sp)
               while (i) {
    3116:	d38ff06f          	j	264e <stbsp_vsprintfcb+0x380>
            lead[0] -= (char)i;
    311a:	06010423          	sb	zero,104(sp)
            while (i) {
    311e:	ed8ff06f          	j	27f6 <stbsp_vsprintfcb+0x528>
            while (i >= 4) {
    3122:	06fadc63          	bge	s5,a5,319a <stbsp_vsprintfcb+0xecc>
            tz -= i;
    3126:	8722                	mv	a4,s0
    3128:	0007851b          	sext.w	a0,a5
            while (i >= 4) {
    312c:	008785bb          	addw	a1,a5,s0
               *(stbsp__uint32 *)bf = 0x30303030;
    3130:	01672023          	sw	s6,0(a4)
               bf += 4;
    3134:	0711                	addi	a4,a4,4
            while (i >= 4) {
    3136:	40e5863b          	subw	a2,a1,a4
    313a:	fecacbe3          	blt	s5,a2,3130 <stbsp_vsprintfcb+0xe62>
    313e:	ffc5061b          	addiw	a2,a0,-4
    3142:	0026561b          	srliw	a2,a2,0x2
    3146:	0016071b          	addiw	a4,a2,1
    314a:	37f1                	addiw	a5,a5,-4
    314c:	0026161b          	slliw	a2,a2,0x2
    3150:	070a                	slli	a4,a4,0x2
    3152:	9722                	add	a4,a4,s0
    3154:	9f91                	subw	a5,a5,a2
            while (i) {
    3156:	843a                	mv	s0,a4
    3158:	80078de3          	beqz	a5,2972 <stbsp_vsprintfcb+0x6a4>
    315c:	1782                	slli	a5,a5,0x20
    315e:	9381                	srli	a5,a5,0x20
    3160:	00f70433          	add	s0,a4,a5
               *bf++ = '0';
    3164:	0705                	addi	a4,a4,1
    3166:	ff470fa3          	sb	s4,-1(a4)
            while (i) {
    316a:	fe871de3          	bne	a4,s0,3164 <stbsp_vsprintfcb+0xe96>
    316e:	805ff06f          	j	2972 <stbsp_vsprintfcb+0x6a4>
               stbsp__cb_buf_clamp(i, pr);
    3172:	85ce                	mv	a1,s3
               if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    3174:	4981                	li	s3,0
    3176:	dc049263          	bnez	s1,273a <stbsp_vsprintfcb+0x46c>
    317a:	b8d5                	j	2a6e <stbsp_vsprintfcb+0x7a0>
            STBSP__UNALIGNED(while (i >= 4) {
    317c:	4401                	li	s0,0
    317e:	85be                	mv	a1,a5
    3180:	f0ea4b63          	blt	s4,a4,2896 <stbsp_vsprintfcb+0x5c8>
    3184:	f42ff06f          	j	28c6 <stbsp_vsprintfcb+0x5f8>
               if ((((stbsp__uintptr)bf) & 3) == 0)
    3188:	00347713          	andi	a4,s0,3
            stbsp__cb_buf_clamp(i, tz);
    318c:	87c6                	mv	a5,a7
            tz -= i;
    318e:	4881                	li	a7,0
               if ((((stbsp__uintptr)bf) & 3) == 0)
    3190:	fc071c63          	bnez	a4,2968 <stbsp_vsprintfcb+0x69a>
            while (i >= 4) {
    3194:	470d                	li	a4,3
    3196:	f8f748e3          	blt	a4,a5,3126 <stbsp_vsprintfcb+0xe58>
    319a:	8722                	mv	a4,s0
    319c:	b7c1                	j	315c <stbsp_vsprintfcb+0xe8e>
            tail[0] -= (char)i;
    319e:	06010823          	sb	zero,112(sp)
            while (i) {
    31a2:	b0b9                	j	29f0 <stbsp_vsprintfcb+0x722>
                  while (i >= 4) {
    31a4:	478d                	li	a5,3
    31a6:	8622                	mv	a2,s0
    31a8:	d8b7d963          	bge	a5,a1,273a <stbsp_vsprintfcb+0x46c>
    31ac:	ffc5839b          	addiw	t2,a1,-4
    31b0:	0023d79b          	srliw	a5,t2,0x2
    31b4:	0017859b          	addiw	a1,a5,1
    31b8:	058a                	slli	a1,a1,0x2
    31ba:	942e                	add	s0,s0,a1
                     *(stbsp__uint32 *)bf = 0x30303030;
    31bc:	01762023          	sw	s7,0(a2)
                     bf += 4;
    31c0:	0611                	addi	a2,a2,4
                  while (i >= 4) {
    31c2:	fe861de3          	bne	a2,s0,31bc <stbsp_vsprintfcb+0xeee>
    31c6:	0027979b          	slliw	a5,a5,0x2
    31ca:	40f385bb          	subw	a1,t2,a5
    31ce:	d68ff06f          	j	2736 <stbsp_vsprintfcb+0x468>
            while (i) {
    31d2:	85be                	mv	a1,a5
    31d4:	ee071963          	bnez	a4,28c6 <stbsp_vsprintfcb+0x5f8>
    31d8:	f16ff06f          	j	28ee <stbsp_vsprintfcb+0x620>
    31dc:	2c013a03          	ld	s4,704(sp)
    31e0:	2b813a83          	ld	s5,696(sp)
    31e4:	2b013b03          	ld	s6,688(sp)
    31e8:	8ca2                	mv	s9,s0
    31ea:	a04ff06f          	j	23ee <stbsp_vsprintfcb+0x120>
            stbsp__chk_cb_buf(1);
    31ee:	2601                	sext.w	a2,a2
    31f0:	1fe00793          	li	a5,510
    31f4:	f8c7c563          	blt	a5,a2,297e <stbsp_vsprintfcb+0x6b0>
    31f8:	f3eff06f          	j	2936 <stbsp_vsprintfcb+0x668>
               fl &= ~STBSP__TRIPLET_COMMA; // if no leading zeros, then no commas
    31fc:	fbfe7e13          	andi	t3,t3,-65
         if (fw + pr) {
    3200:	006707bb          	addw	a5,a4,t1
               fl &= ~STBSP__TRIPLET_COMMA; // if no leading zeros, then no commas
    3204:	2e01                	sext.w	t3,t3
         if (fw + pr) {
    3206:	a0078be3          	beqz	a5,2c1c <stbsp_vsprintfcb+0x94e>
               while (fw > 0) {
    320a:	be605663          	blez	t1,25f6 <stbsp_vsprintfcb+0x328>
                     *(stbsp__uint32 *)bf = 0x20202020;
    320e:	20202837          	lui	a6,0x20202
                  stbsp__cb_buf_clamp(i, fw);
    3212:	854a                	mv	a0,s2
    3214:	894e                	mv	s2,s3
    3216:	69a2                	ld	s3,8(sp)
                     *(stbsp__uint32 *)bf = 0x20202020;
    3218:	02080813          	addi	a6,a6,32 # 20202020 <_ZSt4cerr+0x201f91b0>
                  stbsp__cb_buf_clamp(i, fw);
    321c:	ec52                	sd	s4,24(sp)
    321e:	f426                	sd	s1,40(sp)
    3220:	87a2                	mv	a5,s0
    3222:	84ea                	mv	s1,s10
                  stbsp__chk_cb_buf(1);
    3224:	1fe00f13          	li	t5,510
                  stbsp__cb_buf_clamp(i, fw);
    3228:	8d6e                	mv	s10,s11
                     *bf++ = ' ';
    322a:	02000b13          	li	s6,32
                  stbsp__cb_buf_clamp(i, fw);
    322e:	8de6                	mv	s11,s9
                  while (i >= 4) {
    3230:	4b8d                	li	s7,3
                  stbsp__cb_buf_clamp(i, fw);
    3232:	20000e93          	li	t4,512
    3236:	e846                	sd	a7,16(sp)
    3238:	f07e                	sd	t6,32(sp)
    323a:	f836                	sd	a3,48(sp)
    323c:	e4f2                	sd	t3,72(sp)
    323e:	e8ba                	sd	a4,80(sp)
    3240:	ec96                	sd	t0,88(sp)
    3242:	841a                	mv	s0,t1
    3244:	8a42                	mv	s4,a6
    3246:	8c9e                	mv	s9,t2
    3248:	0c090063          	beqz	s2,3308 <stbsp_vsprintfcb+0x103a>
    324c:	40a78633          	sub	a2,a5,a0
    3250:	40ce873b          	subw	a4,t4,a2
    3254:	86ba                	mv	a3,a4
    3256:	00e45363          	bge	s0,a4,325c <stbsp_vsprintfcb+0xf8e>
    325a:	86a2                	mv	a3,s0
    325c:	0006871b          	sext.w	a4,a3
                  fw -= i;
    3260:	9c15                	subw	s0,s0,a3
                  while (i) {
    3262:	e719                	bnez	a4,3270 <stbsp_vsprintfcb+0xfa2>
    3264:	a095                	j	32c8 <stbsp_vsprintfcb+0xffa>
                     *bf++ = ' ';
    3266:	01678023          	sb	s6,0(a5)
                     --i;
    326a:	377d                	addiw	a4,a4,-1
                     *bf++ = ' ';
    326c:	0785                	addi	a5,a5,1
                  while (i) {
    326e:	cb29                	beqz	a4,32c0 <stbsp_vsprintfcb+0xff2>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    3270:	0037f693          	andi	a3,a5,3
    3274:	faed                	bnez	a3,3266 <stbsp_vsprintfcb+0xf98>
                  while (i >= 4) {
    3276:	86be                	mv	a3,a5
    3278:	00070f9b          	sext.w	t6,a4
    327c:	00f705bb          	addw	a1,a4,a5
    3280:	02ebd763          	bge	s7,a4,32ae <stbsp_vsprintfcb+0xfe0>
                     *(stbsp__uint32 *)bf = 0x20202020;
    3284:	0146a023          	sw	s4,0(a3)
                     bf += 4;
    3288:	0691                	addi	a3,a3,4
                  while (i >= 4) {
    328a:	40d5863b          	subw	a2,a1,a3
    328e:	fecbcbe3          	blt	s7,a2,3284 <stbsp_vsprintfcb+0xfb6>
    3292:	ffcf861b          	addiw	a2,t6,-4 # fffffffff7fffffc <_ZSt4cerr+0xfffffffff7ff718c>
    3296:	0026561b          	srliw	a2,a2,0x2
    329a:	0016069b          	addiw	a3,a2,1
    329e:	3771                	addiw	a4,a4,-4
    32a0:	0026161b          	slliw	a2,a2,0x2
    32a4:	068a                	slli	a3,a3,0x2
    32a6:	96be                	add	a3,a3,a5
    32a8:	9f11                	subw	a4,a4,a2
                  while (i) {
    32aa:	87b6                	mv	a5,a3
    32ac:	cb11                	beqz	a4,32c0 <stbsp_vsprintfcb+0xff2>
    32ae:	1702                	slli	a4,a4,0x20
    32b0:	9301                	srli	a4,a4,0x20
    32b2:	00e687b3          	add	a5,a3,a4
                     *bf++ = ' ';
    32b6:	0685                	addi	a3,a3,1
    32b8:	ff668fa3          	sb	s6,-1(a3)
                  while (i) {
    32bc:	fef69de3          	bne	a3,a5,32b6 <stbsp_vsprintfcb+0xfe8>
                  stbsp__chk_cb_buf(1);
    32c0:	40a78633          	sub	a2,a5,a0
    32c4:	00090e63          	beqz	s2,32e0 <stbsp_vsprintfcb+0x1012>
    32c8:	2601                	sext.w	a2,a2
    32ca:	00cf5b63          	bge	t5,a2,32e0 <stbsp_vsprintfcb+0x1012>
    32ce:	85ce                	mv	a1,s3
    32d0:	9cb1                	addw	s1,s1,a2
    32d2:	9902                	jalr	s2
    32d4:	c541                	beqz	a0,335c <stbsp_vsprintfcb+0x108e>
    32d6:	87aa                	mv	a5,a0
    32d8:	20000e93          	li	t4,512
    32dc:	1fe00f13          	li	t5,510
               while (fw > 0) {
    32e0:	f68044e3          	bgtz	s0,3248 <stbsp_vsprintfcb+0xf7a>
    32e4:	8322                	mv	t1,s0
    32e6:	89ca                	mv	s3,s2
    32e8:	83e6                	mv	t2,s9
    32ea:	68c2                	ld	a7,16(sp)
    32ec:	8cee                	mv	s9,s11
    32ee:	6a62                	ld	s4,24(sp)
    32f0:	8dea                	mv	s11,s10
    32f2:	7f82                	ld	t6,32(sp)
    32f4:	8d26                	mv	s10,s1
    32f6:	76c2                	ld	a3,48(sp)
    32f8:	6e26                	ld	t3,72(sp)
    32fa:	6746                	ld	a4,80(sp)
    32fc:	62e6                	ld	t0,88(sp)
    32fe:	74a2                	ld	s1,40(sp)
    3300:	892a                	mv	s2,a0
    3302:	843e                	mv	s0,a5
    3304:	af2ff06f          	j	25f6 <stbsp_vsprintfcb+0x328>
                  stbsp__cb_buf_clamp(i, fw);
    3308:	8722                	mv	a4,s0
    330a:	4401                	li	s0,0
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    330c:	b795                	j	3270 <stbsp_vsprintfcb+0xfa2>
            n64 = va_arg(va, stbsp__uint32);
    330e:	000be683          	lwu	a3,0(s7)
    3312:	b0f9                	j	2be0 <stbsp_vsprintfcb+0x912>
    3314:	2c013a03          	ld	s4,704(sp)
    3318:	2b813a83          	ld	s5,696(sp)
    331c:	2b013b03          	ld	s6,688(sp)
    3320:	8cca                	mv	s9,s2
    3322:	8ccff06f          	j	23ee <stbsp_vsprintfcb+0x120>
    3326:	8cd6                	mv	s9,s5
    3328:	2c013a03          	ld	s4,704(sp)
    332c:	2b813a83          	ld	s5,696(sp)
    3330:	2b013b03          	ld	s6,688(sp)
    3334:	8baff06f          	j	23ee <stbsp_vsprintfcb+0x120>
    3338:	2c013a03          	ld	s4,704(sp)
    333c:	2b813a83          	ld	s5,696(sp)
    3340:	2b013b03          	ld	s6,688(sp)
    3344:	8cea                	mv	s9,s10
    3346:	8a8ff06f          	j	23ee <stbsp_vsprintfcb+0x120>
                  while (i) {
    334a:	85a2                	mv	a1,s0
    334c:	c12ff06f          	j	275e <stbsp_vsprintfcb+0x490>
                  while (i >= 4) {
    3350:	478d                	li	a5,3
    3352:	8622                	mv	a2,s0
    3354:	e4b7cce3          	blt	a5,a1,31ac <stbsp_vsprintfcb+0xede>
    3358:	be2ff06f          	j	273a <stbsp_vsprintfcb+0x46c>
    335c:	2c013a03          	ld	s4,704(sp)
    3360:	2b813a83          	ld	s5,696(sp)
    3364:	2b013b03          	ld	s6,688(sp)
    3368:	8ca6                	mv	s9,s1
    336a:	884ff06f          	j	23ee <stbsp_vsprintfcb+0x120>
            lead[2] = h[16];
    336e:	01084683          	lbu	a3,16(a6)
            lead[0] = 2;
    3372:	678d                	lui	a5,0x3
    3374:	0789                	addi	a5,a5,2 # 3002 <stbsp_vsprintfcb+0xd34>
    3376:	06f11423          	sh	a5,104(sp)
            lead[2] = h[16];
    337a:	06d10523          	sb	a3,106(sp)
    337e:	b891                	j	2bd2 <stbsp_vsprintfcb+0x904>
    3380:	8cea                	mv	s9,s10
    3382:	86cff06f          	j	23ee <stbsp_vsprintfcb+0x120>
    3386:	4f81                	li	t6,0
    3388:	4a01                	li	s4,0
    338a:	5586                	lw	a1,96(sp)
                  *--s = stbsp__comma;
    338c:	00005f17          	auipc	t5,0x5
    3390:	c59f4f03          	lbu	t5,-935(t5) # 7fe5 <stbsp__comma>
    3394:	0510                	addi	a2,sp,640
    3396:	0085d71b          	srliw	a4,a1,0x8
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    339a:	4305                	li	t1,1
            if (fl & STBSP__TRIPLET_COMMA) {
    339c:	040e7e93          	andi	t4,t3,64
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    33a0:	0007029b          	sext.w	t0,a4
    33a4:	005317bb          	sllw	a5,t1,t0
    33a8:	37fd                	addiw	a5,a5,-1
    33aa:	8ff5                	and	a5,a5,a3
    33ac:	97c2                	add	a5,a5,a6
    33ae:	0007c783          	lbu	a5,0(a5)
            n64 >>= (l >> 8);
    33b2:	0056d6b3          	srl	a3,a3,t0
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    33b6:	fff60a93          	addi	s5,a2,-1
    33ba:	fef60fa3          	sb	a5,-1(a2)
            if (!((n64) || ((stbsp__int32)((num + STBSP__NUMSZ) - s) < pr)))
    33be:	e691                	bnez	a3,33ca <stbsp_vsprintfcb+0x10fc>
    33c0:	051c                	addi	a5,sp,640
    33c2:	415787bb          	subw	a5,a5,s5
    33c6:	0317dd63          	bge	a5,a7,3400 <stbsp_vsprintfcb+0x1132>
            if (fl & STBSP__TRIPLET_COMMA) {
    33ca:	020e8963          	beqz	t4,33fc <stbsp_vsprintfcb+0x112e>
               ++l;
    33ce:	0015879b          	addiw	a5,a1,1
               if ((l & 15) == ((l >> 4) & 15)) {
    33d2:	0047d29b          	srliw	t0,a5,0x4
    33d6:	00f2c2b3          	xor	t0,t0,a5
    33da:	00f2f293          	andi	t0,t0,15
               ++l;
    33de:	0007859b          	sext.w	a1,a5
               if ((l & 15) == ((l >> 4) & 15)) {
    33e2:	0087d71b          	srliw	a4,a5,0x8
    33e6:	00029b63          	bnez	t0,33fc <stbsp_vsprintfcb+0x112e>
                  l &= ~15;
    33ea:	9bc1                	andi	a5,a5,-16
    33ec:	0007859b          	sext.w	a1,a5
                  *--s = stbsp__comma;
    33f0:	ffe60a93          	addi	s5,a2,-2
    33f4:	ffe60f23          	sb	t5,-2(a2)
    33f8:	0087d71b          	srliw	a4,a5,0x8
    33fc:	8656                	mv	a2,s5
    33fe:	b74d                	j	33a0 <stbsp_vsprintfcb+0x10d2>
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    3400:	0045d29b          	srliw	t0,a1,0x4
    3404:	0f0006b7          	lui	a3,0xf000
         if (pr < (stbsp__int32)l)
    3408:	0007871b          	sext.w	a4,a5
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    340c:	0182929b          	slliw	t0,t0,0x18
    3410:	00d2f2b3          	and	t0,t0,a3
         n = pr + lead[0] + tail[0] + tz;
    3414:	00ef863b          	addw	a2,t6,a4
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    3418:	d0be                	sw	a5,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    341a:	8fb2                	mv	t6,a2
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    341c:	86be                	mv	a3,a5
    341e:	00f282bb          	addw	t0,t0,a5
         if (fw < (stbsp__int32)n)
    3422:	835a                	mv	t1,s6
    3424:	00cb5363          	bge	s6,a2,342a <stbsp_vsprintfcb+0x115c>
    3428:	8332                	mv	t1,a2
         fw -= n;
    342a:	41f3033b          	subw	t1,t1,t6
         pr -= l;
    342e:	9f1d                	subw	a4,a4,a5
         goto scopy;
    3430:	4f81                	li	t6,0
      tz = 0;
    3432:	4881                	li	a7,0
         goto scopy;
    3434:	fdcff06f          	j	2c10 <stbsp_vsprintfcb+0x942>
    3438:	8cda                	mv	s9,s6
    343a:	2c013a03          	ld	s4,704(sp)
    343e:	2b813a83          	ld	s5,696(sp)
    3442:	2b013b03          	ld	s6,688(sp)
    3446:	fa9fe06f          	j	23ee <stbsp_vsprintfcb+0x120>
            fl |= ((sizeof(void *) == 8) ? STBSP__INTMAX : 0);
    344a:	020e6e13          	ori	t3,t3,32
            ++f;
    344e:	0485                	addi	s1,s1,1
    3450:	864ff06f          	j	24b4 <stbsp_vsprintfcb+0x1e6>
               n = 0;
    3454:	4601                	li	a2,0
         s = num + 64;
    3456:	8756                	mv	a4,s5
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3458:	4511                	li	a0,4
                     *s++ = stbsp__comma;
    345a:	00170793          	addi	a5,a4,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    345e:	00030563          	beqz	t1,3468 <stbsp_vsprintfcb+0x119a>
    3462:	2585                	addiw	a1,a1,1
    3464:	10a58363          	beq	a1,a0,356a <stbsp_vsprintfcb+0x129c>
    3468:	873e                	mv	a4,a5
                     *s++ = sn[n];
    346a:	02061793          	slli	a5,a2,0x20
    346e:	9381                	srli	a5,a5,0x20
    3470:	97fa                	add	a5,a5,t5
    3472:	0007c803          	lbu	a6,0(a5)
                     ++n;
    3476:	2605                	addiw	a2,a2,1
                     *s++ = sn[n];
    3478:	ff070fa3          	sb	a6,-1(a4)
                     if (n >= l)
    347c:	fcd66fe3          	bltu	a2,a3,345a <stbsp_vsprintfcb+0x118c>
               if (n < (stbsp__uint32)dp) {
    3480:	0bd663e3          	bltu	a2,t4,3d26 <stbsp_vsprintfcb+0x1a58>
               cs = (int)(s - (num + 64)) + (3 << 24); // cs is how many tens
    3484:	415707b3          	sub	a5,a4,s5
    3488:	030002b7          	lui	t0,0x3000
    348c:	00f282bb          	addw	t0,t0,a5
               if (pr) {
    3490:	00088a63          	beqz	a7,34a4 <stbsp_vsprintfcb+0x11d6>
                  *s++ = stbsp__period;
    3494:	0cca4683          	lbu	a3,204(s4)
    3498:	00170793          	addi	a5,a4,1
         l = (stbsp__uint32)(s - (num + 64));
    349c:	415787b3          	sub	a5,a5,s5
                  *s++ = stbsp__period;
    34a0:	00d70023          	sb	a3,0(a4)
         if (fl & STBSP__METRIC_SUFFIX) {
    34a4:	100e7713          	andi	a4,t3,256
    34a8:	86f2                	mv	a3,t3
    34aa:	2c070163          	beqz	a4,376c <stbsp_vsprintfcb+0x149e>
            if (fl & STBSP__METRIC_NOSPACE)
    34ae:	40ae5f9b          	sraiw	t6,t3,0xa
    34b2:	001fcf93          	xori	t6,t6,1
    34b6:	001fff93          	andi	t6,t6,1
            tail[1] = ' ';
    34ba:	02000713          	li	a4,32
    34be:	06e108a3          	sb	a4,113(sp)
            tail[0] = idx;
    34c2:	07f10823          	sb	t6,112(sp)
               if (fl >> 24) { // SI kilo is 'k', JEDEC and SI kibits are 'K'.
    34c6:	018e561b          	srliw	a2,t3,0x18
    34ca:	018e571b          	srliw	a4,t3,0x18
         n = pr + lead[0] + tail[0] + tz;
    34ce:	000f859b          	sext.w	a1,t6
               if (fl >> 24) { // SI kilo is 'k', JEDEC and SI kibits are 'K'.
    34d2:	c225                	beqz	a2,3532 <stbsp_vsprintfcb+0x1264>
                  if (fl & STBSP__METRIC_1024)
    34d4:	001f859b          	addiw	a1,t6,1
    34d8:	0ff5f613          	zext.b	a2,a1
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    34dc:	1702                	slli	a4,a4,0x20
                  if (fl & STBSP__METRIC_1024)
    34de:	03469513          	slli	a0,a3,0x34
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    34e2:	85b2                	mv	a1,a2
    34e4:	9301                	srli	a4,a4,0x20
                  if (fl & STBSP__METRIC_1024)
    34e6:	06055ee3          	bgez	a0,3d62 <stbsp_vsprintfcb+0x1a94>
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    34ea:	00003517          	auipc	a0,0x3
    34ee:	cfe50513          	addi	a0,a0,-770 # 61e8 <_GLOBAL__sub_I__ZSt3cin+0x1f8>
    34f2:	972a                	add	a4,a4,a0
    34f4:	00074503          	lbu	a0,0(a4)
                  if (fl & STBSP__METRIC_1024 && !(fl & STBSP__METRIC_JEDEC)) {
    34f8:	6709                	lui	a4,0x2
    34fa:	80070713          	addi	a4,a4,-2048 # 1800 <stbsp__real_to_str+0x616>
    34fe:	8f75                	and	a4,a4,a3
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    3500:	06010813          	addi	a6,sp,96
    3504:	22060693          	addi	a3,a2,544
    3508:	96c2                	add	a3,a3,a6
    350a:	dea68823          	sb	a0,-528(a3) # efffdf0 <_ZSt4cerr+0xeff6f80>
                  if (fl & STBSP__METRIC_1024 && !(fl & STBSP__METRIC_JEDEC)) {
    350e:	8007071b          	addiw	a4,a4,-2048
    3512:	060715e3          	bnez	a4,3d7c <stbsp_vsprintfcb+0x1aae>
                     tail[idx + 1] = 'i';
    3516:	2f89                	addiw	t6,t6,2
    3518:	0ffff593          	zext.b	a1,t6
    351c:	1094                	addi	a3,sp,96
    351e:	22058713          	addi	a4,a1,544
    3522:	9736                	add	a4,a4,a3
    3524:	06900693          	li	a3,105
    3528:	8fae                	mv	t6,a1
    352a:	ded70823          	sb	a3,-528(a4)
                  tail[0] = idx;
    352e:	07f10823          	sb	t6,112(sp)
         l = (stbsp__uint32)(s - (num + 64));
    3532:	0007869b          	sext.w	a3,a5
         n = pr + lead[0] + tail[0] + tz;
    3536:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    353a:	fff6c713          	not	a4,a3
    353e:	977d                	srai	a4,a4,0x3f
    3540:	8ff9                	and	a5,a5,a4
         n = pr + lead[0] + tail[0] + tz;
    3542:	00fa073b          	addw	a4,s4,a5
    3546:	9f2d                	addw	a4,a4,a1
    3548:	0117063b          	addw	a2,a4,a7
         l = (stbsp__uint32)(s - (num + 64));
    354c:	d0b6                	sw	a3,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    354e:	8732                	mv	a4,a2
         if (pr < (stbsp__int32)l)
    3550:	2781                	sext.w	a5,a5
         if ((fl & STBSP__LEFTJUST) == 0) {
    3552:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    3556:	835a                	mv	t1,s6
    3558:	00cb5363          	bge	s6,a2,355e <stbsp_vsprintfcb+0x1290>
    355c:	8332                	mv	t1,a2
         fw -= n;
    355e:	40e3033b          	subw	t1,t1,a4
         pr -= l;
    3562:	40d7873b          	subw	a4,a5,a3
         goto scopy;
    3566:	eaaff06f          	j	2c10 <stbsp_vsprintfcb+0x942>
                     *s++ = stbsp__comma;
    356a:	fe578fa3          	sb	t0,-1(a5)
    356e:	0709                	addi	a4,a4,2
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3570:	4585                	li	a1,1
    3572:	bde5                	j	346a <stbsp_vsprintfcb+0x119c>
            lead[0] = 1;
    3574:	678d                	lui	a5,0x3
    3576:	0785                	addi	a5,a5,1 # 3001 <stbsp_vsprintfcb+0xd33>
    3578:	06f11423          	sh	a5,104(sp)
    357c:	b4ed                	j	3066 <stbsp_vsprintfcb+0xd98>
            if ((f[0] != 'u') && (i64 < 0)) {
    357e:	07500693          	li	a3,117
            stbsp__int64 i64 = va_arg(va, stbsp__int64);
    3582:	000bbf03          	ld	t5,0(s7)
            if ((f[0] != 'u') && (i64 < 0)) {
    3586:	dcd78263          	beq	a5,a3,2b4a <stbsp_vsprintfcb+0x87c>
    358a:	dc0f5063          	bgez	t5,2b4a <stbsp_vsprintfcb+0x87c>
               fl |= STBSP__NEGATIVE;
    358e:	08076713          	ori	a4,a4,128
               n64 = (stbsp__uint64)-i64;
    3592:	41e00f33          	neg	t5,t5
               fl |= STBSP__NEGATIVE;
    3596:	00070e1b          	sext.w	t3,a4
    359a:	db0ff06f          	j	2b4a <stbsp_vsprintfcb+0x87c>
            lead[2] = h[0xb];
    359e:	00b84703          	lbu	a4,11(a6)
            lead[0] = 2;
    35a2:	678d                	lui	a5,0x3
    35a4:	0789                	addi	a5,a5,2 # 3002 <stbsp_vsprintfcb+0xd34>
    35a6:	06f11423          	sh	a5,104(sp)
            lead[2] = h[0xb];
    35aa:	06e10523          	sb	a4,106(sp)
    35ae:	bab5                	j	2f2a <stbsp_vsprintfcb+0xc5c>
      sign[0] = 1;
    35b0:	678d                	lui	a5,0x3
    35b2:	d0178793          	addi	a5,a5,-767 # 2d01 <stbsp_vsprintfcb+0xa33>
            fl |= STBSP__NEGATIVE;
    35b6:	080e6e13          	ori	t3,t3,128
      sign[0] = 1;
    35ba:	06f11423          	sh	a5,104(sp)
    35be:	468d                	li	a3,3
    35c0:	4a0d                	li	s4,3
    35c2:	4809                	li	a6,2
    35c4:	b899                	j	2e1a <stbsp_vsprintfcb+0xb4c>
      sign[0] = 1;
    35c6:	6709                	lui	a4,0x2
    35c8:	0705                	addi	a4,a4,1 # 2001 <_vscanf_core.constprop.0+0x689>
    35ca:	06e11423          	sh	a4,104(sp)
    35ce:	bae5                	j	2fc6 <stbsp_vsprintfcb+0xcf8>
      if (((stbsp__uintptr)sn & 3) == 0)
    35d0:	0e0780e3          	beqz	a5,3eb0 <stbsp_vsprintfcb+0x1be2>
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    35d4:	56fd                	li	a3,-1
    35d6:	bcf9                	j	30b4 <stbsp_vsprintfcb+0xde6>
         if (fw < (stbsp__int32)n)
    35d8:	4305                	li	t1,1
    35da:	b249                	j	2f5c <stbsp_vsprintfcb+0xc8e>
            pr = 6; // default is 6
    35dc:	4899                	li	a7,6
    35de:	b801                	j	2dee <stbsp_vsprintfcb+0xb20>
         h = (f[0] == 'A') ? hexu : hex;
    35e0:	00005597          	auipc	a1,0x5
    35e4:	a0858593          	addi	a1,a1,-1528 # 7fe8 <hexu.1>
    35e8:	ff6ff06f          	j	2dde <stbsp_vsprintfcb+0xb10>
         h = (f[0] == 'B') ? hexu : hex;
    35ec:	00005817          	auipc	a6,0x5
    35f0:	9fc80813          	addi	a6,a6,-1540 # 7fe8 <hexu.1>
    35f4:	b22d                	j	2f1e <stbsp_vsprintfcb+0xc50>
    35f6:	80000737          	lui	a4,0x80000
    35fa:	0719                	addi	a4,a4,6 # ffffffff80000006 <_ZSt4cerr+0xffffffff7fff7196>
            pr = 6; // default is 6
    35fc:	4899                	li	a7,6
    35fe:	e4eff06f          	j	2c4c <stbsp_vsprintfcb+0x97e>
         h = (f[0] == 'E') ? hexu : hex;
    3602:	00005317          	auipc	t1,0x5
    3606:	9e630313          	addi	t1,t1,-1562 # 7fe8 <hexu.1>
    360a:	e28ff06f          	j	2c32 <stbsp_vsprintfcb+0x964>
    360e:	80000737          	lui	a4,0x80000
    3612:	4a99                	li	s5,6
    3614:	0715                	addi	a4,a4,5 # ffffffff80000005 <_ZSt4cerr+0xffffffff7fff7195>
            pr = 6;
    3616:	4a19                	li	s4,6
    3618:	ee8ff06f          	j	2d00 <stbsp_vsprintfcb+0xa32>
         h = (f[0] == 'G') ? hexu : hex;
    361c:	00005317          	auipc	t1,0x5
    3620:	9cc30313          	addi	t1,t1,-1588 # 7fe8 <hexu.1>
    3624:	eb6ff06f          	j	2cda <stbsp_vsprintfcb+0xa0c>
    3628:	7be6                	ld	s7,120(sp)
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    362a:	86c2                	mv	a3,a6
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    362c:	8542                	mv	a0,a6
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    362e:	88d2                	mv	a7,s4
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    3630:	8ade                	mv	s5,s7
            if (pr > (stbsp__int32)l)
    3632:	0005071b          	sext.w	a4,a0
    3636:	01175f63          	bge	a4,a7,3654 <stbsp_vsprintfcb+0x1386>
               pr = l - 1;
    363a:	fff5089b          	addiw	a7,a0,-1
         tail[0] = 0;
    363e:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    3642:	70028c63          	beqz	t0,3d5a <stbsp_vsprintfcb+0x1a8c>
      sign[0] = 1;
    3646:	670d                	lui	a4,0x3
    3648:	d0170713          	addi	a4,a4,-767 # 2d01 <stbsp_vsprintfcb+0xa33>
    364c:	06e11423          	sh	a4,104(sp)
    3650:	e3aff06f          	j	2c8a <stbsp_vsprintfcb+0x9bc>
            else if (pr)
    3654:	fe0885e3          	beqz	a7,363e <stbsp_vsprintfcb+0x1370>
               --pr; // when using %e, there is one digit before the decimal
    3658:	38fd                	addiw	a7,a7,-1
    365a:	b7d5                	j	363e <stbsp_vsprintfcb+0x1370>
      switch (f[0]) {
    365c:	0034c783          	lbu	a5,3(s1)
            f += 3;
    3660:	048d                	addi	s1,s1,3
    3662:	e53fe06f          	j	24b4 <stbsp_vsprintfcb+0x1e6>
      if (!limit || *sn == 0)
    3666:	4601                	li	a2,0
    3668:	4701                	li	a4,0
    366a:	4781                	li	a5,0
         return (stbsp__uint32)(sn - s);
    366c:	bca5                	j	30e4 <stbsp_vsprintfcb+0xe16>
               pr = 1;
    366e:	4885                	li	a7,1
    3670:	cf4ff06f          	j	2b64 <stbsp_vsprintfcb+0x896>
         *s++ = sn[0];
    3674:	000ac703          	lbu	a4,0(s5)
    3678:	0ce10023          	sb	a4,192(sp)
         if (pr)
    367c:	54088563          	beqz	a7,3bc6 <stbsp_vsprintfcb+0x18f8>
            *s++ = stbsp__period;
    3680:	00005617          	auipc	a2,0x5
    3684:	96464603          	lbu	a2,-1692(a2) # 7fe4 <stbsp__period>
         if ((l - 1) > (stbsp__uint32)pr)
    3688:	fff6871b          	addiw	a4,a3,-1
            *s++ = stbsp__period;
    368c:	0cc100a3          	sb	a2,193(sp)
         if ((l - 1) > (stbsp__uint32)pr)
    3690:	0008851b          	sext.w	a0,a7
    3694:	0007061b          	sext.w	a2,a4
    3698:	52c57163          	bgeu	a0,a2,3bba <stbsp_vsprintfcb+0x18ec>
            l = pr + 1;
    369c:	0018869b          	addiw	a3,a7,1
         for (n = 1; n < l; n++)
    36a0:	8746                	mv	a4,a7
    36a2:	02071613          	slli	a2,a4,0x20
    36a6:	9201                	srli	a2,a2,0x20
    36a8:	0c210713          	addi	a4,sp,194
    36ac:	0a85                	addi	s5,s5,1
    36ae:	963a                	add	a2,a2,a4
            *s++ = sn[n];
    36b0:	000ac583          	lbu	a1,0(s5)
    36b4:	0705                	addi	a4,a4,1
         for (n = 1; n < l; n++)
    36b6:	0a85                	addi	s5,s5,1
            *s++ = sn[n];
    36b8:	feb70fa3          	sb	a1,-1(a4)
         for (n = 1; n < l; n++)
    36bc:	fec71ae3          	bne	a4,a2,36b0 <stbsp_vsprintfcb+0x13e2>
         tail[1] = h[0xe];
    36c0:	00e34803          	lbu	a6,14(t1)
         dp -= 1;
    36c4:	fff7871b          	addiw	a4,a5,-1
            tail[2] = '+';
    36c8:	02b00593          	li	a1,43
         tail[1] = h[0xe];
    36cc:	070108a3          	sb	a6,113(sp)
         if (dp < 0) {
    36d0:	00075663          	bgez	a4,36dc <stbsp_vsprintfcb+0x140e>
            dp = -dp;
    36d4:	4705                	li	a4,1
    36d6:	9f1d                	subw	a4,a4,a5
            tail[2] = '-';
    36d8:	02d00593          	li	a1,45
    36dc:	06b10923          	sb	a1,114(sp)
         n = (dp >= 100) ? 5 : 4;
    36e0:	06300793          	li	a5,99
    36e4:	4ee7d663          	bge	a5,a4,3bd0 <stbsp_vsprintfcb+0x1902>
    36e8:	4595                	li	a1,5
    36ea:	4f95                	li	t6,5
    36ec:	4e95                	li	t4,5
            tail[n] = '0' + dp % 10;
    36ee:	47a9                	li	a5,10
            dp /= 10;
    36f0:	02f7433b          	divw	t1,a4,a5
            --n;
    36f4:	fffe8f1b          	addiw	t5,t4,-1
            tail[n] = '0' + dp % 10;
    36f8:	020f1293          	slli	t0,t5,0x20
    36fc:	220e8813          	addi	a6,t4,544
    3700:	06010893          	addi	a7,sp,96
    3704:	0202d293          	srli	t0,t0,0x20
    3708:	01180eb3          	add	t4,a6,a7
    370c:	22028813          	addi	a6,t0,544 # 3000220 <_ZSt4cerr+0x2ff73b0>
    3710:	011802b3          	add	t0,a6,a7
         tail[0] = (char)n;
    3714:	07f10823          	sb	t6,112(sp)
            if (n <= 3)
    3718:	4a0d                	li	s4,3
            tail[n] = '0' + dp % 10;
    371a:	02f7673b          	remw	a4,a4,a5
            dp /= 10;
    371e:	0003081b          	sext.w	a6,t1
            tail[n] = '0' + dp % 10;
    3722:	02f36abb          	remw	s5,t1,a5
    3726:	0307071b          	addiw	a4,a4,48
    372a:	deee8823          	sb	a4,-528(t4)
    372e:	030a871b          	addiw	a4,s5,48
    3732:	dee28823          	sb	a4,-528(t0)
            if (n <= 3)
    3736:	014f0a63          	beq	t5,s4,374a <stbsp_vsprintfcb+0x147c>
            dp /= 10;
    373a:	02f3483b          	divw	a6,t1,a5
            tail[n] = '0' + dp % 10;
    373e:	02f867bb          	remw	a5,a6,a5
    3742:	0307879b          	addiw	a5,a5,48
    3746:	06f109a3          	sb	a5,115(sp)
         tz = pr - (l - 1);
    374a:	2505                	addiw	a0,a0,1
         l = (stbsp__uint32)(s - (num + 64));
    374c:	0c010a93          	addi	s5,sp,192
         cs = 1 + (3 << 24); // how many tens
    3750:	030002b7          	lui	t0,0x3000
         tz = pr - (l - 1);
    3754:	40d508bb          	subw	a7,a0,a3
    3758:	d2c2                	sw	a6,100(sp)
         l = (stbsp__uint32)(s - (num + 64));
    375a:	415607b3          	sub	a5,a2,s5
         cs = 1 + (3 << 24); // how many tens
    375e:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff7191>
    3760:	bbc9                	j	3532 <stbsp_vsprintfcb+0x1264>
    3762:	fc2e                	sd	a1,56(sp)
    3764:	d0b2                	sw	a2,96(sp)
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    3766:	8536                	mv	a0,a3
    3768:	e2cff06f          	j	2d94 <stbsp_vsprintfcb+0xac6>
      flt_lead:
    376c:	4581                	li	a1,0
    376e:	4f81                	li	t6,0
    3770:	b3c9                	j	3532 <stbsp_vsprintfcb+0x1264>
         n = pr + lead[0] + tail[0] + tz;
    3772:	06814a03          	lbu	s4,104(sp)
    3776:	000a0f9b          	sext.w	t6,s4
    377a:	b901                	j	338a <stbsp_vsprintfcb+0x10bc>
         if ((f[1] == '6') && (f[2] == '4')) {
    377c:	0024c683          	lbu	a3,2(s1)
    3780:	03400713          	li	a4,52
    3784:	00e68463          	beq	a3,a4,378c <stbsp_vsprintfcb+0x14be>
    3788:	e2bfe06f          	j	25b2 <stbsp_vsprintfcb+0x2e4>
      switch (f[0]) {
    378c:	0034c783          	lbu	a5,3(s1)
         fl |= ((sizeof(long) == 8) ? STBSP__INTMAX : 0);
    3790:	020e6e13          	ori	t3,t3,32
            f += 3;
    3794:	048d                	addi	s1,s1,3
    3796:	d1ffe06f          	j	24b4 <stbsp_vsprintfcb+0x1e6>
         if (pr < (stbsp__int32)l)
    379a:	0006879b          	sext.w	a5,a3
         n = pr + lead[0] + tail[0] + tz;
    379e:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    37a2:	fff7c793          	not	a5,a5
    37a6:	97fd                	srai	a5,a5,0x3f
    37a8:	8ff5                	and	a5,a5,a3
         n = pr + lead[0] + tail[0] + tz;
    37aa:	00fa063b          	addw	a2,s4,a5
            s = (char *)sn;
    37ae:	7ae6                	ld	s5,120(sp)
         n = pr + lead[0] + tail[0] + tz;
    37b0:	8732                	mv	a4,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    37b2:	001e7513          	andi	a0,t3,1
         if (pr < (stbsp__int32)l)
    37b6:	2781                	sext.w	a5,a5
         if (fw < (stbsp__int32)n)
    37b8:	835a                	mv	t1,s6
    37ba:	00cb5363          	bge	s6,a2,37c0 <stbsp_vsprintfcb+0x14f2>
    37be:	8332                	mv	t1,a2
         fw -= n;
    37c0:	40e3033b          	subw	t1,t1,a4
            goto scopy;
    37c4:	4f81                	li	t6,0
         pr -= l;
    37c6:	40d7873b          	subw	a4,a5,a3
            cs = 0;
    37ca:	4281                	li	t0,0
      tz = 0;
    37cc:	4881                	li	a7,0
            goto scopy;
    37ce:	c42ff06f          	j	2c10 <stbsp_vsprintfcb+0x942>
               cs = (int)(s - (num + 64)) + (3 << 24); // cs is how many tens
    37d2:	415705b3          	sub	a1,a4,s5
    37d6:	030002b7          	lui	t0,0x3000
    37da:	00b282bb          	addw	t0,t0,a1
               l = pr - n;
    37de:	0008859b          	sext.w	a1,a7
               if (pr)
    37e2:	42088763          	beqz	a7,3c10 <stbsp_vsprintfcb+0x1942>
                  *s++ = stbsp__period;
    37e6:	0cca4f83          	lbu	t6,204(s4)
               if ((l - dp) > (stbsp__uint32)pr)
    37ea:	41d6833b          	subw	t1,a3,t4
                  *s++ = stbsp__period;
    37ee:	00280713          	addi	a4,a6,2
    37f2:	01f800a3          	sb	t6,1(a6)
               if ((l - dp) > (stbsp__uint32)pr)
    37f6:	4065ed63          	bltu	a1,t1,3c10 <stbsp_vsprintfcb+0x1942>
               while (n < l) {
    37fa:	5ed57863          	bgeu	a0,a3,3dea <stbsp_vsprintfcb+0x1b1c>
    37fe:	40c687bb          	subw	a5,a3,a2
    3802:	37fd                	addiw	a5,a5,-1
    3804:	1782                	slli	a5,a5,0x20
    3806:	9381                	srli	a5,a5,0x20
    3808:	1602                	slli	a2,a2,0x20
    380a:	9201                	srli	a2,a2,0x20
    380c:	0785                	addi	a5,a5,1
    380e:	967a                	add	a2,a2,t5
    3810:	97ba                	add	a5,a5,a4
                  *s++ = sn[n];
    3812:	00064503          	lbu	a0,0(a2)
    3816:	0705                	addi	a4,a4,1
               while (n < l) {
    3818:	0605                	addi	a2,a2,1
                  *s++ = sn[n];
    381a:	fea70fa3          	sb	a0,-1(a4)
               while (n < l) {
    381e:	fef71ae3          	bne	a4,a5,3812 <stbsp_vsprintfcb+0x1544>
               tz = pr - (l - dp);
    3822:	01d585bb          	addw	a1,a1,t4
    3826:	40d588bb          	subw	a7,a1,a3
         l = (stbsp__uint32)(s - (num + 64));
    382a:	415787b3          	sub	a5,a5,s5
    382e:	b99d                	j	34a4 <stbsp_vsprintfcb+0x11d6>
            fl |= STBSP__NEGATIVE;
    3830:	080e6e13          	ori	t3,t3,128
         tail[0] = 0;
    3834:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    3838:	b539                	j	3646 <stbsp_vsprintfcb+0x1378>
         tail[0] = (char)n;
    383a:	4799                	li	a5,6
            tail[n] = '0' + dp % 10;
    383c:	06b10b23          	sb	a1,118(sp)
         tail[0] = (char)n;
    3840:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    3844:	4819                	li	a6,6
    3846:	4f99                	li	t6,6
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    3848:	4599                	li	a1,6
            dp /= 10;
    384a:	4f29                	li	t5,10
            if (n <= 3)
    384c:	428d                	li	t0,3
    384e:	87b2                	mv	a5,a2
            dp /= 10;
    3850:	03e7c7bb          	divw	a5,a5,t5
            --n;
    3854:	35fd                	addiw	a1,a1,-1
            tail[n] = '0' + dp % 10;
    3856:	02059613          	slli	a2,a1,0x20
    385a:	9201                	srli	a2,a2,0x20
    385c:	06010e93          	addi	t4,sp,96
    3860:	22060613          	addi	a2,a2,544
    3864:	9676                	add	a2,a2,t4
    3866:	03e7eebb          	remw	t4,a5,t5
    386a:	030e8e9b          	addiw	t4,t4,48
    386e:	dfd60823          	sb	t4,-528(a2)
            if (n <= 3)
    3872:	fc559fe3          	bne	a1,t0,3850 <stbsp_vsprintfcb+0x1582>
    3876:	e6aff06f          	j	2ee0 <stbsp_vsprintfcb+0xc12>
         *s++ = h[(n64 >> 60) & 15];
    387a:	93f1                	srli	a5,a5,0x3c
    387c:	97ae                	add	a5,a5,a1
    387e:	0007c303          	lbu	t1,0(a5)
         lead[1 + lead[0]] = '0';
    3882:	1088                	addi	a0,sp,96
    3884:	22080793          	addi	a5,a6,544
    3888:	97aa                	add	a5,a5,a0
    388a:	03000513          	li	a0,48
    388e:	dea78423          	sb	a0,-536(a5)
         lead[2 + lead[0]] = 'x';
    3892:	22068793          	addi	a5,a3,544
    3896:	1094                	addi	a3,sp,96
    3898:	96be                	add	a3,a3,a5
            *s++ = stbsp__period;
    389a:	00004517          	auipc	a0,0x4
    389e:	74a54503          	lbu	a0,1866(a0) # 7fe4 <stbsp__period>
         lead[2 + lead[0]] = 'x';
    38a2:	07800813          	li	a6,120
         sn = s;
    38a6:	0c210793          	addi	a5,sp,194
         lead[2 + lead[0]] = 'x';
    38aa:	df068423          	sb	a6,-536(a3)
            *s++ = stbsp__period;
    38ae:	0ca100a3          	sb	a0,193(sp)
         lead[0] += 2;
    38b2:	07410423          	sb	s4,104(sp)
         *s++ = h[(n64 >> 60) & 15];
    38b6:	0c610023          	sb	t1,192(sp)
         n64 <<= 4;
    38ba:	0732                	slli	a4,a4,0xc
         sn = s;
    38bc:	fcbe                	sd	a5,120(sp)
         n = pr;
    38be:	0008869b          	sext.w	a3,a7
         while (n--) {
    38c2:	4831                	li	a6,12
         if (n > 13)
    38c4:	4535                	li	a0,13
            tz = pr - n;
    38c6:	40a688bb          	subw	a7,a3,a0
         while (n--) {
    38ca:	02081313          	slli	t1,a6,0x20
    38ce:	02035313          	srli	t1,t1,0x20
    38d2:	22030693          	addi	a3,t1,544
    38d6:	1088                	addi	a0,sp,96
    38d8:	9536                	add	a0,a0,a3
    38da:	e4350513          	addi	a0,a0,-445
            *s++ = h[(n64 >> 60) & 15];
    38de:	03c75693          	srli	a3,a4,0x3c
    38e2:	96ae                	add	a3,a3,a1
    38e4:	0006c683          	lbu	a3,0(a3)
    38e8:	0785                	addi	a5,a5,1
            n64 <<= 4;
    38ea:	0712                	slli	a4,a4,0x4
            *s++ = h[(n64 >> 60) & 15];
    38ec:	fed78fa3          	sb	a3,-1(a5)
         while (n--) {
    38f0:	fea797e3          	bne	a5,a0,38de <stbsp_vsprintfcb+0x1610>
         l = (int)(s - (num + 64));
    38f4:	280d                	addiw	a6,a6,3
    38f6:	0008069b          	sext.w	a3,a6
         if (pr < (stbsp__int32)l)
    38fa:	fff6c713          	not	a4,a3
    38fe:	977d                	srai	a4,a4,0x3f
    3900:	00e87733          	and	a4,a6,a4
         dp = (int)(s - sn);
    3904:	0013051b          	addiw	a0,t1,1
         if (pr < (stbsp__int32)l)
    3908:	0007031b          	sext.w	t1,a4
         pr -= l;
    390c:	4107073b          	subw	a4,a4,a6
    3910:	d76ff06f          	j	2e86 <stbsp_vsprintfcb+0xbb8>
                  *--s = stbsp__comma;
    3914:	00004a17          	auipc	s4,0x4
    3918:	604a0a13          	addi	s4,s4,1540 # 7f18 <stbsp__digitpair>
            if (n64 >= 100000000) {
    391c:	05f5e7b7          	lui	a5,0x5f5e
    3920:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f5528f>
               n = (stbsp__uint32)(n64 % 100000000);
    3924:	05f5e637          	lui	a2,0x5f5e
                  *--s = stbsp__comma;
    3928:	0cda4b83          	lbu	s7,205(s4)
            if (n64 >= 100000000) {
    392c:	e83e                	sd	a5,16(sp)
               n = (stbsp__uint32)(n64 % 100000000);
    392e:	10060793          	addi	a5,a2,256 # 5f5e100 <_ZSt4cerr+0x5f55290>
         l = 0;
    3932:	d082                	sw	zero,96(sp)
            if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    3934:	040e7813          	andi	a6,t3,64
    3938:	4701                	li	a4,0
    393a:	4281                	li	t0,0
         s = num + STBSP__NUMSZ;
    393c:	28010a93          	addi	s5,sp,640
               n = (stbsp__uint32)(n64 % 100000000);
    3940:	ec3e                	sd	a5,24(sp)
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    3942:	430d                	li	t1,3
                  n /= 10;
    3944:	45a9                	li	a1,10
            while (n) {
    3946:	4ea5                	li	t4,9
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    3948:	06400f93          	li	t6,100
            if (n64 >= 100000000) {
    394c:	67c2                	ld	a5,16(sp)
            char *o = s - 8;
    394e:	ff8a8513          	addi	a0,s5,-8
            if (n64 >= 100000000) {
    3952:	0fe7f763          	bgeu	a5,t5,3a40 <stbsp_vsprintfcb+0x1772>
               n = (stbsp__uint32)(n64 % 100000000);
    3956:	6662                	ld	a2,24(sp)
    3958:	02cf77b3          	remu	a5,t5,a2
               n64 /= 100000000;
    395c:	02cf5f33          	divu	t5,t5,a2
            if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    3960:	0e080463          	beqz	a6,3a48 <stbsp_vsprintfcb+0x177a>
            while (n) {
    3964:	cb85                	beqz	a5,3994 <stbsp_vsprintfcb+0x16c6>
                  *--s = stbsp__comma;
    3966:	1afd                	addi	s5,s5,-1
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    3968:	00671763          	bne	a4,t1,3976 <stbsp_vsprintfcb+0x16a8>
                  --o;
    396c:	017a8023          	sb	s7,0(s5)
    3970:	157d                	addi	a0,a0,-1
                  *--s = stbsp__comma;
    3972:	1afd                	addi	s5,s5,-1
                  l = 0;
    3974:	4701                	li	a4,0
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    3976:	2705                	addiw	a4,a4,1
                  *--s = (char)(n % 10) + '0';
    3978:	02b7f63b          	remuw	a2,a5,a1
    397c:	0306061b          	addiw	a2,a2,48
    3980:	00ca8023          	sb	a2,0(s5)
                  n /= 10;
    3984:	02b7d63b          	divuw	a2,a5,a1
            while (n) {
    3988:	00fef563          	bgeu	t4,a5,3992 <stbsp_vsprintfcb+0x16c4>
                  *--s = stbsp__comma;
    398c:	1afd                	addi	s5,s5,-1
    398e:	87b2                	mv	a5,a2
    3990:	bfe1                	j	3968 <stbsp_vsprintfcb+0x169a>
            while (n) {
    3992:	4285                	li	t0,1
            if (n64 == 0) {
    3994:	020f0063          	beqz	t5,39b4 <stbsp_vsprintfcb+0x16e6>
            while (s != o)
    3998:	fb550ae3          	beq	a0,s5,394c <stbsp_vsprintfcb+0x167e>
                  *--s = stbsp__comma;
    399c:	1afd                	addi	s5,s5,-1
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    399e:	00080663          	beqz	a6,39aa <stbsp_vsprintfcb+0x16dc>
    39a2:	08670863          	beq	a4,t1,3a32 <stbsp_vsprintfcb+0x1764>
    39a6:	2705                	addiw	a4,a4,1
    39a8:	4285                	li	t0,1
                  *--s = '0';
    39aa:	03000793          	li	a5,48
    39ae:	00fa8023          	sb	a5,0(s5)
    39b2:	b7dd                	j	3998 <stbsp_vsprintfcb+0x16ca>
    39b4:	00028363          	beqz	t0,39ba <stbsp_vsprintfcb+0x16ec>
    39b8:	d0ba                	sw	a4,96(sp)
               if ((s[0] == '0') && (s != (num + STBSP__NUMSZ)))
    39ba:	000ac703          	lbu	a4,0(s5)
    39be:	03000793          	li	a5,48
    39c2:	34f70b63          	beq	a4,a5,3d18 <stbsp_vsprintfcb+0x1a4a>
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    39c6:	051c                	addi	a5,sp,640
    39c8:	415786bb          	subw	a3,a5,s5
         tail[0] = 0;
    39cc:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    39d0:	080e7713          	andi	a4,t3,128
    39d4:	87f2                	mv	a5,t3
    39d6:	32070863          	beqz	a4,3d06 <stbsp_vsprintfcb+0x1a38>
    39da:	678d                	lui	a5,0x3
    39dc:	d017879b          	addiw	a5,a5,-767 # 2d01 <stbsp_vsprintfcb+0xa33>
      sign[0] = 1;
    39e0:	06f11423          	sh	a5,104(sp)
    39e4:	4705                	li	a4,1
    39e6:	4a05                	li	s4,1
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    39e8:	d0b6                	sw	a3,96(sp)
         if (l == 0) {
    39ea:	30068163          	beqz	a3,3cec <stbsp_vsprintfcb+0x1a1e>
         cs = l + (3 << 24);
    39ee:	030002b7          	lui	t0,0x3000
    39f2:	00d282bb          	addw	t0,t0,a3
         if (pr < (stbsp__int32)l)
    39f6:	0006861b          	sext.w	a2,a3
         if (pr < 0)
    39fa:	fff8c793          	not	a5,a7
    39fe:	97fd                	srai	a5,a5,0x3f
         if (pr < (stbsp__int32)l)
    3a00:	00f8f7b3          	and	a5,a7,a5
    3a04:	0007859b          	sext.w	a1,a5
    3a08:	00c5d363          	bge	a1,a2,3a0e <stbsp_vsprintfcb+0x1740>
    3a0c:	87b2                	mv	a5,a2
         n = pr + lead[0] + tail[0] + tz;
    3a0e:	00f7063b          	addw	a2,a4,a5
    3a12:	8732                	mv	a4,a2
         if (pr < (stbsp__int32)l)
    3a14:	2781                	sext.w	a5,a5
         if ((fl & STBSP__LEFTJUST) == 0) {
    3a16:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    3a1a:	835a                	mv	t1,s6
    3a1c:	00cb5363          	bge	s6,a2,3a22 <stbsp_vsprintfcb+0x1754>
    3a20:	8332                	mv	t1,a2
         fw -= n;
    3a22:	40e3033b          	subw	t1,t1,a4
      scopy:
    3a26:	4f81                	li	t6,0
         pr -= l;
    3a28:	40d7873b          	subw	a4,a5,a3
      tz = 0;
    3a2c:	4881                	li	a7,0
      scopy:
    3a2e:	9e2ff06f          	j	2c10 <stbsp_vsprintfcb+0x942>
                  *--s = stbsp__comma;
    3a32:	87de                	mv	a5,s7
                  --o;
    3a34:	157d                	addi	a0,a0,-1
                  l = 0;
    3a36:	4701                	li	a4,0
                  --o;
    3a38:	4285                	li	t0,1
    3a3a:	00fa8023          	sb	a5,0(s5)
    3a3e:	bfa9                	j	3998 <stbsp_vsprintfcb+0x16ca>
               n = (stbsp__uint32)n64;
    3a40:	000f079b          	sext.w	a5,t5
               n64 = 0;
    3a44:	4f01                	li	t5,0
    3a46:	bf29                	j	3960 <stbsp_vsprintfcb+0x1692>
    3a48:	f046                	sd	a7,32(sp)
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    3a4a:	03f7f63b          	remuw	a2,a5,t6
                  s -= 2;
    3a4e:	1af9                	addi	s5,s5,-2
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    3a50:	0007889b          	sext.w	a7,a5
    3a54:	2605                	addiw	a2,a2,1
    3a56:	0016161b          	slliw	a2,a2,0x1
    3a5a:	1602                	slli	a2,a2,0x20
    3a5c:	9201                	srli	a2,a2,0x20
    3a5e:	9652                	add	a2,a2,s4
    3a60:	00065603          	lhu	a2,0(a2)
                  n /= 100;
    3a64:	03f7d7bb          	divuw	a5,a5,t6
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    3a68:	00ca9023          	sh	a2,0(s5)
               } while (n);
    3a6c:	06300613          	li	a2,99
    3a70:	fd166de3          	bltu	a2,a7,3a4a <stbsp_vsprintfcb+0x177c>
    3a74:	7882                	ld	a7,32(sp)
            if (n64 == 0) {
    3a76:	f20f11e3          	bnez	t5,3998 <stbsp_vsprintfcb+0x16ca>
    3a7a:	bf2d                	j	39b4 <stbsp_vsprintfcb+0x16e6>
                     *(stbsp__uint32 *)bf = 0x20202020;
    3a7c:	20202b37          	lui	s6,0x20202
                  stbsp__cb_buf_clamp(i, fw);
    3a80:	854a                	mv	a0,s2
                     *bf++ = ' ';
    3a82:	02000a93          	li	s5,32
                     *(stbsp__uint32 *)bf = 0x20202020;
    3a86:	020b0b13          	addi	s6,s6,32 # 20202020 <_ZSt4cerr+0x201f91b0>
                  stbsp__chk_cb_buf(1);
    3a8a:	1fe00a13          	li	s4,510
                  stbsp__cb_buf_clamp(i, fw);
    3a8e:	20000b93          	li	s7,512
    3a92:	891a                	mv	s2,t1
    3a94:	0a098063          	beqz	s3,3b34 <stbsp_vsprintfcb+0x1866>
    3a98:	40a40633          	sub	a2,s0,a0
    3a9c:	40cb87bb          	subw	a5,s7,a2
    3aa0:	873e                	mv	a4,a5
    3aa2:	00f95363          	bge	s2,a5,3aa8 <stbsp_vsprintfcb+0x17da>
    3aa6:	874a                	mv	a4,s2
    3aa8:	0007079b          	sext.w	a5,a4
                  fw -= i;
    3aac:	40e9093b          	subw	s2,s2,a4
                  while (i) {
    3ab0:	e799                	bnez	a5,3abe <stbsp_vsprintfcb+0x17f0>
    3ab2:	a281                	j	3bf2 <stbsp_vsprintfcb+0x1924>
                     *bf++ = ' ';
    3ab4:	01540023          	sb	s5,0(s0)
                     --i;
    3ab8:	37fd                	addiw	a5,a5,-1
                     *bf++ = ' ';
    3aba:	0405                	addi	s0,s0,1
                  while (i) {
    3abc:	cba1                	beqz	a5,3b0c <stbsp_vsprintfcb+0x183e>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    3abe:	00347713          	andi	a4,s0,3
    3ac2:	fb6d                	bnez	a4,3ab4 <stbsp_vsprintfcb+0x17e6>
                  while (i >= 4) {
    3ac4:	470d                	li	a4,3
    3ac6:	40f75363          	bge	a4,a5,3ecc <stbsp_vsprintfcb+0x1bfe>
    3aca:	ffc7869b          	addiw	a3,a5,-4
    3ace:	0026d79b          	srliw	a5,a3,0x2
    3ad2:	0017871b          	addiw	a4,a5,1
    3ad6:	070a                	slli	a4,a4,0x2
    3ad8:	9722                	add	a4,a4,s0
                     *(stbsp__uint32 *)bf = 0x20202020;
    3ada:	01642023          	sw	s6,0(s0)
                     bf += 4;
    3ade:	0411                	addi	s0,s0,4
                  while (i >= 4) {
    3ae0:	fee41de3          	bne	s0,a4,3ada <stbsp_vsprintfcb+0x180c>
    3ae4:	0027979b          	slliw	a5,a5,0x2
    3ae8:	40f687bb          	subw	a5,a3,a5
                  while (i--)
    3aec:	fff7869b          	addiw	a3,a5,-1
    3af0:	cf91                	beqz	a5,3b0c <stbsp_vsprintfcb+0x183e>
    3af2:	9fa1                	addw	a5,a5,s0
                     *bf++ = ' ';
    3af4:	0705                	addi	a4,a4,1
                  while (i--)
    3af6:	0007061b          	sext.w	a2,a4
                     *bf++ = ' ';
    3afa:	ff570fa3          	sb	s5,-1(a4)
                  while (i--)
    3afe:	fec79be3          	bne	a5,a2,3af4 <stbsp_vsprintfcb+0x1826>
    3b02:	2685                	addiw	a3,a3,1
    3b04:	02069793          	slli	a5,a3,0x20
    3b08:	9381                	srli	a5,a5,0x20
    3b0a:	943e                	add	s0,s0,a5
                  stbsp__chk_cb_buf(1);
    3b0c:	00098f63          	beqz	s3,3b2a <stbsp_vsprintfcb+0x185c>
    3b10:	40a4063b          	subw	a2,s0,a0
    3b14:	00ca5b63          	bge	s4,a2,3b2a <stbsp_vsprintfcb+0x185c>
    3b18:	65a2                	ld	a1,8(sp)
    3b1a:	e81e                	sd	t2,16(sp)
    3b1c:	00cd0d3b          	addw	s10,s10,a2
    3b20:	9982                	jalr	s3
    3b22:	80050be3          	beqz	a0,3338 <stbsp_vsprintfcb+0x106a>
    3b26:	63c2                	ld	t2,16(sp)
    3b28:	842a                	mv	s0,a0
               while (fw) {
    3b2a:	f60915e3          	bnez	s2,3a94 <stbsp_vsprintfcb+0x17c6>
    3b2e:	892a                	mv	s2,a0
    3b30:	f21fe06f          	j	2a50 <stbsp_vsprintfcb+0x782>
                  stbsp__cb_buf_clamp(i, fw);
    3b34:	87ca                	mv	a5,s2
                  fw -= i;
    3b36:	4901                	li	s2,0
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    3b38:	b759                	j	3abe <stbsp_vsprintfcb+0x17f0>
   } else if (fl & STBSP__LEADINGPLUS) {
    3b3a:	002e7713          	andi	a4,t3,2
    3b3e:	94070663          	beqz	a4,2c8a <stbsp_vsprintfcb+0x9bc>
      sign[0] = 1;
    3b42:	670d                	lui	a4,0x3
    3b44:	b0170713          	addi	a4,a4,-1279 # 2b01 <stbsp_vsprintfcb+0x833>
    3b48:	06e11423          	sh	a4,104(sp)
    3b4c:	93eff06f          	j	2c8a <stbsp_vsprintfcb+0x9bc>
      if (((stbsp__uintptr)sn & 3) == 0)
    3b50:	87d6                	mv	a5,s5
   while (limit >= 4) {
    3b52:	470d                	li	a4,3
    3b54:	22d77763          	bgeu	a4,a3,3d82 <stbsp_vsprintfcb+0x1ab4>
      if ((v - 0x01010101) & (~v) & 0x80808080UL)
    3b58:	feff05b7          	lui	a1,0xfeff0
    3b5c:	80808637          	lui	a2,0x80808
    3b60:	eff5859b          	addiw	a1,a1,-257 # fffffffffefefeff <_ZSt4cerr+0xfffffffffefe708f>
    3b64:	08060613          	addi	a2,a2,128 # ffffffff80808080 <_ZSt4cerr+0xffffffff807ff210>
   while (limit >= 4) {
    3b68:	480d                	li	a6,3
    3b6a:	a029                	j	3b74 <stbsp_vsprintfcb+0x18a6>
      limit -= 4;
    3b6c:	36f1                	addiw	a3,a3,-4
      sn += 4;
    3b6e:	0791                	addi	a5,a5,4
   while (limit >= 4) {
    3b70:	20d87963          	bgeu	a6,a3,3d82 <stbsp_vsprintfcb+0x1ab4>
      stbsp__uint32 v = *(stbsp__uint32 *)sn;
    3b74:	4398                	lw	a4,0(a5)
      if ((v - 0x01010101) & (~v) & 0x80808080UL)
    3b76:	00b7053b          	addw	a0,a4,a1
    3b7a:	fff74713          	not	a4,a4
    3b7e:	8f69                	and	a4,a4,a0
    3b80:	8f71                	and	a4,a4,a2
    3b82:	2701                	sext.w	a4,a4
    3b84:	d765                	beqz	a4,3b6c <stbsp_vsprintfcb+0x189e>
    3b86:	02069713          	slli	a4,a3,0x20
    3b8a:	9301                	srli	a4,a4,0x20
    3b8c:	973e                	add	a4,a4,a5
    3b8e:	a021                	j	3b96 <stbsp_vsprintfcb+0x18c8>
      ++sn;
    3b90:	0785                	addi	a5,a5,1
   while (limit && *sn) {
    3b92:	00e78663          	beq	a5,a4,3b9e <stbsp_vsprintfcb+0x18d0>
    3b96:	0007c683          	lbu	a3,0(a5)
    3b9a:	fafd                	bnez	a3,3b90 <stbsp_vsprintfcb+0x18c2>
    3b9c:	873e                	mv	a4,a5
   return (stbsp__uint32)(sn - s);
    3b9e:	41570733          	sub	a4,a4,s5
    3ba2:	0007069b          	sext.w	a3,a4
         if (pr < (stbsp__int32)l)
    3ba6:	fff6c793          	not	a5,a3
    3baa:	97fd                	srai	a5,a5,0x3f
    3bac:	8f7d                	and	a4,a4,a5
    3bae:	0007079b          	sext.w	a5,a4
         n = pr + lead[0] + tail[0] + tz;
    3bb2:	863e                	mv	a2,a5
         pr -= l;
    3bb4:	9f15                	subw	a4,a4,a3
   return (stbsp__uint32)(sn - s);
    3bb6:	d2eff06f          	j	30e4 <stbsp_vsprintfcb+0xe16>
         for (n = 1; n < l; n++)
    3bba:	4605                	li	a2,1
    3bbc:	aed663e3          	bltu	a2,a3,36a2 <stbsp_vsprintfcb+0x13d4>
    3bc0:	0c210613          	addi	a2,sp,194
    3bc4:	bcf5                	j	36c0 <stbsp_vsprintfcb+0x13f2>
            l = pr + 1;
    3bc6:	4685                	li	a3,1
         if ((l - 1) > (stbsp__uint32)pr)
    3bc8:	4501                	li	a0,0
         *s++ = sn[0];
    3bca:	0c110613          	addi	a2,sp,193
    3bce:	bccd                	j	36c0 <stbsp_vsprintfcb+0x13f2>
    3bd0:	4591                	li	a1,4
    3bd2:	4f91                	li	t6,4
         n = (dp >= 100) ? 5 : 4;
    3bd4:	4e91                	li	t4,4
    3bd6:	be21                	j	36ee <stbsp_vsprintfcb+0x1420>
    3bd8:	4a85                	li	s5,1
    3bda:	80000737          	lui	a4,0x80000
            pr = 1; // default is 6
    3bde:	4a05                	li	s4,1
    3be0:	920ff06f          	j	2d00 <stbsp_vsprintfcb+0xa32>
            dp = (n64) ? -1022 : 0;
    3be4:	4601                	li	a2,0
    3be6:	c119                	beqz	a0,3bec <stbsp_vsprintfcb+0x191e>
    3be8:	c0200613          	li	a2,-1022
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    3bec:	872a                	mv	a4,a0
    3bee:	a3aff06f          	j	2e28 <stbsp_vsprintfcb+0xb5a>
                  stbsp__chk_cb_buf(1);
    3bf2:	2601                	sext.w	a2,a2
    3bf4:	1fe00793          	li	a5,510
    3bf8:	f2c7c0e3          	blt	a5,a2,3b18 <stbsp_vsprintfcb+0x184a>
    3bfc:	bd61                	j	3a94 <stbsp_vsprintfcb+0x17c6>
         tail[0] = (char)n;
    3bfe:	4795                	li	a5,5
            tail[n] = '0' + dp % 10;
    3c00:	06b10aa3          	sb	a1,117(sp)
         tail[0] = (char)n;
    3c04:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    3c08:	4815                	li	a6,5
    3c0a:	4f95                	li	t6,5
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    3c0c:	4595                	li	a1,5
    3c0e:	b935                	j	384a <stbsp_vsprintfcb+0x157c>
                  l = pr + dp;
    3c10:	011786bb          	addw	a3,a5,a7
    3c14:	d0b6                	sw	a3,96(sp)
    3c16:	b6d5                	j	37fa <stbsp_vsprintfcb+0x152c>
            s = (char *)"null";
    3c18:	00002a97          	auipc	s5,0x2
    3c1c:	5c8a8a93          	addi	s5,s5,1480 # 61e0 <_GLOBAL__sub_I__ZSt3cin+0x1f0>
    3c20:	c80ff06f          	j	30a0 <stbsp_vsprintfcb+0xdd2>
   } else if (fl & STBSP__LEADINGPLUS) {
    3c24:	002e7793          	andi	a5,t3,2
    3c28:	1c079c63          	bnez	a5,3e00 <stbsp_vsprintfcb+0x1b32>
   sign[0] = 0;
    3c2c:	4689                	li	a3,2
    3c2e:	4a09                	li	s4,2
    3c30:	4805                	li	a6,1
    3c32:	9e8ff06f          	j	2e1a <stbsp_vsprintfcb+0xb4c>
      sign[0] = 1;
    3c36:	670d                	lui	a4,0x3
    3c38:	b0170713          	addi	a4,a4,-1279 # 2b01 <stbsp_vsprintfcb+0x833>
    3c3c:	06e11423          	sh	a4,104(sp)
    3c40:	b86ff06f          	j	2fc6 <stbsp_vsprintfcb+0xcf8>
               pr = 0;
    3c44:	4881                	li	a7,0
    3c46:	f1ffe06f          	j	2b64 <stbsp_vsprintfcb+0x896>
            *s++ = '0';
    3c4a:	03000713          	li	a4,48
    3c4e:	0ce10023          	sb	a4,192(sp)
            if (pr)
    3c52:	1a088c63          	beqz	a7,3e0a <stbsp_vsprintfcb+0x1b3c>
               *s++ = stbsp__period;
    3c56:	00004717          	auipc	a4,0x4
    3c5a:	38e74703          	lbu	a4,910(a4) # 7fe4 <stbsp__period>
            n = -dp;
    3c5e:	40f007bb          	negw	a5,a5
               *s++ = stbsp__period;
    3c62:	0ce100a3          	sb	a4,193(sp)
            if ((stbsp__int32)n > pr)
    3c66:	0007871b          	sext.w	a4,a5
    3c6a:	00e8d363          	bge	a7,a4,3c70 <stbsp_vsprintfcb+0x19a2>
    3c6e:	87c6                	mv	a5,a7
    3c70:	0007871b          	sext.w	a4,a5
            if ((stbsp__int32)(l + n) > pr)
    3c74:	00d7833b          	addw	t1,a5,a3
    3c78:	883a                	mv	a6,a4
            while (i) {
    3c7a:	0c210793          	addi	a5,sp,194
               *s++ = '0';
    3c7e:	03000513          	li	a0,48
            while (i) {
    3c82:	e711                	bnez	a4,3c8e <stbsp_vsprintfcb+0x19c0>
    3c84:	a271                	j	3e10 <stbsp_vsprintfcb+0x1b42>
               if ((((stbsp__uintptr)s) & 3) == 0)
    3c86:	0037f613          	andi	a2,a5,3
    3c8a:	18060563          	beqz	a2,3e14 <stbsp_vsprintfcb+0x1b46>
               *s++ = '0';
    3c8e:	85ba                	mv	a1,a4
    3c90:	00a78023          	sb	a0,0(a5)
               --i;
    3c94:	377d                	addiw	a4,a4,-1
               *s++ = '0';
    3c96:	0785                	addi	a5,a5,1
            while (i) {
    3c98:	f77d                	bnez	a4,3c86 <stbsp_vsprintfcb+0x19b8>
            if ((stbsp__int32)(l + n) > pr)
    3c9a:	0003071b          	sext.w	a4,t1
    3c9e:	4108863b          	subw	a2,a7,a6
    3ca2:	00e8d563          	bge	a7,a4,3cac <stbsp_vsprintfcb+0x19de>
               l = pr - n;
    3ca6:	0006069b          	sext.w	a3,a2
    3caa:	d0b2                	sw	a2,96(sp)
            while (i) {
    3cac:	c68d                	beqz	a3,3cd6 <stbsp_vsprintfcb+0x1a08>
    3cae:	7566                	ld	a0,120(sp)
    3cb0:	02069813          	slli	a6,a3,0x20
    3cb4:	02085813          	srli	a6,a6,0x20
    3cb8:	01078eb3          	add	t4,a5,a6
    3cbc:	85aa                	mv	a1,a0
    3cbe:	873e                	mv	a4,a5
               *s++ = *sn++;
    3cc0:	0005c883          	lbu	a7,0(a1)
    3cc4:	0705                	addi	a4,a4,1
            while (i) {
    3cc6:	0585                	addi	a1,a1,1
               *s++ = *sn++;
    3cc8:	ff170fa3          	sb	a7,-1(a4)
            while (i) {
    3ccc:	ffd71ae3          	bne	a4,t4,3cc0 <stbsp_vsprintfcb+0x19f2>
    3cd0:	9542                	add	a0,a0,a6
    3cd2:	97c2                	add	a5,a5,a6
    3cd4:	fcaa                	sd	a0,120(sp)
         l = (stbsp__uint32)(s - (num + 64));
    3cd6:	0c010a93          	addi	s5,sp,192
            cs = 1 + (3 << 24); // how many tens did we write (for commas below)
    3cda:	030002b7          	lui	t0,0x3000
            tz = pr - (n + l);
    3cde:	40d608bb          	subw	a7,a2,a3
         l = (stbsp__uint32)(s - (num + 64));
    3ce2:	415787b3          	sub	a5,a5,s5
            cs = 1 + (3 << 24); // how many tens did we write (for commas below)
    3ce6:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff7191>
    3ce8:	fbcff06f          	j	34a4 <stbsp_vsprintfcb+0x11d6>
            *--s = '0';
    3cec:	03000793          	li	a5,48
    3cf0:	fefa8fa3          	sb	a5,-1(s5)
            l = 1;
    3cf4:	030002b7          	lui	t0,0x3000
    3cf8:	4785                	li	a5,1
    3cfa:	d0be                	sw	a5,96(sp)
            *--s = '0';
    3cfc:	1afd                	addi	s5,s5,-1
            l = 1;
    3cfe:	4605                	li	a2,1
    3d00:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff7191>
    3d02:	4685                	li	a3,1
    3d04:	b9dd                	j	39fa <stbsp_vsprintfcb+0x172c>
   } else if (fl & STBSP__LEADINGSPACE) {
    3d06:	004e7713          	andi	a4,t3,4
    3d0a:	e74d                	bnez	a4,3db4 <stbsp_vsprintfcb+0x1ae6>
   } else if (fl & STBSP__LEADINGPLUS) {
    3d0c:	8b89                	andi	a5,a5,2
    3d0e:	efd9                	bnez	a5,3dac <stbsp_vsprintfcb+0x1ade>
   sign[0] = 0;
    3d10:	06010423          	sb	zero,104(sp)
    3d14:	4a01                	li	s4,0
    3d16:	b9c9                	j	39e8 <stbsp_vsprintfcb+0x171a>
               if ((s[0] == '0') && (s != (num + STBSP__NUMSZ)))
    3d18:	051c                	addi	a5,sp,640
    3d1a:	cafa89e3          	beq	s5,a5,39cc <stbsp_vsprintfcb+0x16fe>
                  ++s;
    3d1e:	0a85                	addi	s5,s5,1
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    3d20:	415786bb          	subw	a3,a5,s5
    3d24:	b165                	j	39cc <stbsp_vsprintfcb+0x16fe>
                  n = dp - n;
    3d26:	40ce87bb          	subw	a5,t4,a2
                  if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    3d2a:	12030e63          	beqz	t1,3e66 <stbsp_vsprintfcb+0x1b98>
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3d2e:	4511                	li	a0,4
    3d30:	03000613          	li	a2,48
                        *s++ = stbsp__comma;
    3d34:	00170693          	addi	a3,a4,1
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3d38:	00030563          	beqz	t1,3d42 <stbsp_vsprintfcb+0x1a74>
    3d3c:	2585                	addiw	a1,a1,1
    3d3e:	00a58963          	beq	a1,a0,3d50 <stbsp_vsprintfcb+0x1a82>
    3d42:	8736                	mv	a4,a3
                        --n;
    3d44:	37fd                	addiw	a5,a5,-1
    3d46:	fec70fa3          	sb	a2,-1(a4)
                  while (n) {
    3d4a:	f7ed                	bnez	a5,3d34 <stbsp_vsprintfcb+0x1a66>
    3d4c:	f38ff06f          	j	3484 <stbsp_vsprintfcb+0x11b6>
    3d50:	fe568fa3          	sb	t0,-1(a3)
                        *s++ = stbsp__comma;
    3d54:	0709                	addi	a4,a4,2
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3d56:	4585                	li	a1,1
    3d58:	b7f5                	j	3d44 <stbsp_vsprintfcb+0x1a76>
   sign[0] = 0;
    3d5a:	06010423          	sb	zero,104(sp)
    3d5e:	f1dfe06f          	j	2c7a <stbsp_vsprintfcb+0x9ac>
                     tail[idx + 1] = "_kMGT"[fl >> 24];
    3d62:	00002697          	auipc	a3,0x2
    3d66:	48e68693          	addi	a3,a3,1166 # 61f0 <_GLOBAL__sub_I__ZSt3cin+0x200>
    3d6a:	9736                	add	a4,a4,a3
    3d6c:	00074683          	lbu	a3,0(a4)
    3d70:	1088                	addi	a0,sp,96
    3d72:	22060713          	addi	a4,a2,544
    3d76:	972a                	add	a4,a4,a0
    3d78:	ded70823          	sb	a3,-528(a4)
                  idx++;
    3d7c:	8fb2                	mv	t6,a2
    3d7e:	fb0ff06f          	j	352e <stbsp_vsprintfcb+0x1260>
   while (limit && *sn) {
    3d82:	e00692e3          	bnez	a3,3b86 <stbsp_vsprintfcb+0x18b8>
    3d86:	bd19                	j	3b9c <stbsp_vsprintfcb+0x18ce>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    3d88:	0008071b          	sext.w	a4,a6
    3d8c:	86c2                	mv	a3,a6
    3d8e:	88d2                	mv	a7,s4
            pr = -dp + ((pr > (stbsp__int32)l) ? (stbsp__int32) l : pr);
    3d90:	863a                	mv	a2,a4
    3d92:	00e8d363          	bge	a7,a4,3d98 <stbsp_vsprintfcb+0x1aca>
    3d96:	8646                	mv	a2,a7
    3d98:	40f608bb          	subw	a7,a2,a5
    3d9c:	814ff06f          	j	2db0 <stbsp_vsprintfcb+0xae2>
            divisor = 1000.0f;
    3da0:	00003797          	auipc	a5,0x3
    3da4:	bf07b787          	fld	fa5,-1040(a5) # 6990 <STDIN_FD+0x28>
    3da8:	dd5fe06f          	j	2b7c <stbsp_vsprintfcb+0x8ae>
    3dac:	678d                	lui	a5,0x3
    3dae:	b017879b          	addiw	a5,a5,-1279 # 2b01 <stbsp_vsprintfcb+0x833>
    3db2:	b13d                	j	39e0 <stbsp_vsprintfcb+0x1712>
    3db4:	6789                	lui	a5,0x2
    3db6:	2785                	addiw	a5,a5,1 # 2001 <_vscanf_core.constprop.0+0x689>
    3db8:	b125                	j	39e0 <stbsp_vsprintfcb+0x1712>
            *s++ = stbsp__period;
    3dba:	00004517          	auipc	a0,0x4
    3dbe:	22a54503          	lbu	a0,554(a0) # 7fe4 <stbsp__period>
         sn = s;
    3dc2:	0c210793          	addi	a5,sp,194
         n = pr;
    3dc6:	0008869b          	sext.w	a3,a7
            *s++ = stbsp__period;
    3dca:	0ca100a3          	sb	a0,193(sp)
         sn = s;
    3dce:	fcbe                	sd	a5,120(sp)
         if (n > 13)
    3dd0:	4535                	li	a0,13
         n64 <<= 4;
    3dd2:	0712                	slli	a4,a4,0x4
         if (n > 13)
    3dd4:	8836                	mv	a6,a3
    3dd6:	00d57363          	bgeu	a0,a3,3ddc <stbsp_vsprintfcb+0x1b0e>
    3dda:	4835                	li	a6,13
    3ddc:	0008051b          	sext.w	a0,a6
         while (n--) {
    3de0:	387d                	addiw	a6,a6,-1
         if (pr > (stbsp__int32)n)
    3de2:	af1542e3          	blt	a0,a7,38c6 <stbsp_vsprintfcb+0x15f8>
      tz = 0;
    3de6:	4881                	li	a7,0
    3de8:	b4cd                	j	38ca <stbsp_vsprintfcb+0x15fc>
               while (n < l) {
    3dea:	87ba                	mv	a5,a4
    3dec:	bc1d                	j	3822 <stbsp_vsprintfcb+0x1554>
         tail[0] = (char)n;
    3dee:	478d                	li	a5,3
    3df0:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    3df4:	06b109a3          	sb	a1,115(sp)
    3df8:	480d                	li	a6,3
    3dfa:	4f8d                	li	t6,3
    3dfc:	8e4ff06f          	j	2ee0 <stbsp_vsprintfcb+0xc12>
    3e00:	678d                	lui	a5,0x3
    3e02:	b017879b          	addiw	a5,a5,-1279 # 2b01 <stbsp_vsprintfcb+0x833>
    3e06:	80aff06f          	j	2e10 <stbsp_vsprintfcb+0xb42>
            if (pr)
    3e0a:	8336                	mv	t1,a3
            *s++ = '0';
    3e0c:	0c110793          	addi	a5,sp,193
            while (i) {
    3e10:	4801                	li	a6,0
    3e12:	b561                	j	3c9a <stbsp_vsprintfcb+0x19cc>
            while (i >= 4) {
    3e14:	460d                	li	a2,3
    3e16:	04e65663          	bge	a2,a4,3e62 <stbsp_vsprintfcb+0x1b94>
    3e1a:	ffb5871b          	addiw	a4,a1,-5
    3e1e:	0027559b          	srliw	a1,a4,0x2
    3e22:	0015861b          	addiw	a2,a1,1
    3e26:	060a                	slli	a2,a2,0x2
               *(stbsp__uint32 *)s = 0x30303030;
    3e28:	30303537          	lui	a0,0x30303
    3e2c:	963e                	add	a2,a2,a5
    3e2e:	03050513          	addi	a0,a0,48 # 30303030 <_ZSt4cerr+0x302fa1c0>
    3e32:	c388                	sw	a0,0(a5)
               s += 4;
    3e34:	0791                	addi	a5,a5,4
            while (i >= 4) {
    3e36:	fef61ee3          	bne	a2,a5,3e32 <stbsp_vsprintfcb+0x1b64>
    3e3a:	0025959b          	slliw	a1,a1,0x2
    3e3e:	9f0d                	subw	a4,a4,a1
            while (i) {
    3e40:	e4070de3          	beqz	a4,3c9a <stbsp_vsprintfcb+0x19cc>
               *s++ = '0';
    3e44:	03000513          	li	a0,48
            while (i) {
    3e48:	00f705bb          	addw	a1,a4,a5
               *s++ = '0';
    3e4c:	0605                	addi	a2,a2,1
            while (i) {
    3e4e:	00060e9b          	sext.w	t4,a2
               *s++ = '0';
    3e52:	fea60fa3          	sb	a0,-1(a2)
            while (i) {
    3e56:	ffd59be3          	bne	a1,t4,3e4c <stbsp_vsprintfcb+0x1b7e>
    3e5a:	1702                	slli	a4,a4,0x20
    3e5c:	9301                	srli	a4,a4,0x20
    3e5e:	97ba                	add	a5,a5,a4
    3e60:	bd2d                	j	3c9a <stbsp_vsprintfcb+0x19cc>
            while (i >= 4) {
    3e62:	863e                	mv	a2,a5
    3e64:	b7c5                	j	3e44 <stbsp_vsprintfcb+0x1b76>
                        if ((((stbsp__uintptr)s) & 3) == 0)
    3e66:	00377693          	andi	a3,a4,3
    3e6a:	ce81                	beqz	a3,3e82 <stbsp_vsprintfcb+0x1bb4>
                        *s++ = '0';
    3e6c:	03000693          	li	a3,48
    3e70:	00d70023          	sb	a3,0(a4)
                        --n;
    3e74:	37fd                	addiw	a5,a5,-1
                        *s++ = '0';
    3e76:	0705                	addi	a4,a4,1
                     while (n) {
    3e78:	e0078663          	beqz	a5,3484 <stbsp_vsprintfcb+0x11b6>
                        if ((((stbsp__uintptr)s) & 3) == 0)
    3e7c:	00377613          	andi	a2,a4,3
    3e80:	fa65                	bnez	a2,3e70 <stbsp_vsprintfcb+0x1ba2>
                     while (n >= 4) {
    3e82:	468d                	li	a3,3
    3e84:	eaf6f5e3          	bgeu	a3,a5,3d2e <stbsp_vsprintfcb+0x1a60>
    3e88:	ffc7869b          	addiw	a3,a5,-4
    3e8c:	0026d69b          	srliw	a3,a3,0x2
    3e90:	2685                	addiw	a3,a3,1
    3e92:	068a                	slli	a3,a3,0x2
                        *(stbsp__uint32 *)s = 0x30303030;
    3e94:	30303637          	lui	a2,0x30303
    3e98:	96ba                	add	a3,a3,a4
    3e9a:	03060613          	addi	a2,a2,48 # 30303030 <_ZSt4cerr+0x302fa1c0>
    3e9e:	c310                	sw	a2,0(a4)
                        s += 4;
    3ea0:	0711                	addi	a4,a4,4
                     while (n >= 4) {
    3ea2:	fed71ee3          	bne	a4,a3,3e9e <stbsp_vsprintfcb+0x1bd0>
    3ea6:	8b8d                	andi	a5,a5,3
                  while (n) {
    3ea8:	e80793e3          	bnez	a5,3d2e <stbsp_vsprintfcb+0x1a60>
    3eac:	dd8ff06f          	j	3484 <stbsp_vsprintfcb+0x11b6>
      if (((stbsp__uintptr)sn & 3) == 0)
    3eb0:	87d6                	mv	a5,s5
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    3eb2:	56fd                	li	a3,-1
    3eb4:	b155                	j	3b58 <stbsp_vsprintfcb+0x188a>
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    3eb6:	5775                	li	a4,-3
    3eb8:	00e7ce63          	blt	a5,a4,3ed4 <stbsp_vsprintfcb+0x1c06>
    3ebc:	f6fa4663          	blt	s4,a5,3628 <stbsp_vsprintfcb+0x135a>
         if (dp > 0) {
    3ec0:	ecf054e3          	blez	a5,3d88 <stbsp_vsprintfcb+0x1aba>
    3ec4:	86c2                	mv	a3,a6
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    3ec6:	4881                	li	a7,0
    3ec8:	ee9fe06f          	j	2db0 <stbsp_vsprintfcb+0xae2>
                  while (i--)
    3ecc:	fff7869b          	addiw	a3,a5,-1
    3ed0:	8722                	mv	a4,s0
    3ed2:	b105                	j	3af2 <stbsp_vsprintfcb+0x1824>
            if (pr > (stbsp__int32)l)
    3ed4:	0008071b          	sext.w	a4,a6
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    3ed8:	7ae6                	ld	s5,120(sp)
            if (pr > (stbsp__int32)l)
    3eda:	86c2                	mv	a3,a6
    3edc:	88d2                	mv	a7,s4
    3ede:	f7475d63          	bge	a4,s4,3658 <stbsp_vsprintfcb+0x138a>
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    3ee2:	8542                	mv	a0,a6
    3ee4:	f56ff06f          	j	363a <stbsp_vsprintfcb+0x136c>

0000000000003ee8 <stbsp_sprintf>:
{
    3ee8:	715d                	addi	sp,sp,-80
   va_start(va, fmt);
    3eea:	02010313          	addi	t1,sp,32
{
    3eee:	f032                	sd	a2,32(sp)
    3ef0:	f436                	sd	a3,40(sp)
    3ef2:	f83a                	sd	a4,48(sp)
   result = STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    3ef4:	86ae                	mv	a3,a1
    3ef6:	862a                	mv	a2,a0
    3ef8:	871a                	mv	a4,t1
    3efa:	4581                	li	a1,0
    3efc:	4501                	li	a0,0
{
    3efe:	ec06                	sd	ra,24(sp)
    3f00:	fc3e                	sd	a5,56(sp)
    3f02:	e0c2                	sd	a6,64(sp)
    3f04:	e4c6                	sd	a7,72(sp)
   va_start(va, fmt);
    3f06:	e41a                	sd	t1,8(sp)
   result = STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    3f08:	bc6fe0ef          	jal	22ce <stbsp_vsprintfcb>
}
    3f0c:	60e2                	ld	ra,24(sp)
    3f0e:	6161                	addi	sp,sp,80
    3f10:	8082                	ret

0000000000003f12 <stbsp_vsnprintf>:
{
    3f12:	dd010113          	addi	sp,sp,-560
    3f16:	22813023          	sd	s0,544(sp)
    3f1a:	20913c23          	sd	s1,536(sp)
    3f1e:	22113423          	sd	ra,552(sp)
    3f22:	84ae                	mv	s1,a1
    3f24:	842a                	mv	s0,a0
    3f26:	88b2                	mv	a7,a2
    3f28:	8736                	mv	a4,a3
   if ( (count == 0) && !buf )
    3f2a:	e591                	bnez	a1,3f36 <stbsp_vsnprintf+0x24>
    3f2c:	c141                	beqz	a0,3fac <stbsp_vsnprintf+0x9a>
      c.buf = buf;
    3f2e:	e02a                	sd	a0,0(sp)
      c.count = count;
    3f30:	e402                	sd	zero,8(sp)
   return (c->count >= STB_SPRINTF_MIN) ? c->buf : c->tmp; // go direct into buffer if you can
    3f32:	0810                	addi	a2,sp,16
    3f34:	a089                	j	3f76 <stbsp_vsnprintf+0x64>
   if (len > c->count)
    3f36:	0015a593          	slti	a1,a1,1
    3f3a:	40b005bb          	negw	a1,a1
    3f3e:	8de5                	and	a1,a1,s1
      c.buf = buf;
    3f40:	e02a                	sd	a0,0(sp)
      c.count = count;
    3f42:	c426                	sw	s1,8(sp)
      c.length = 0;
    3f44:	c602                	sw	zero,12(sp)
   if (len > c->count)
    3f46:	2581                	sext.w	a1,a1
   if (len) {
    3f48:	0804d663          	bgez	s1,3fd4 <stbsp_vsnprintf+0xc2>
         s = buf;
    3f4c:	4781                	li	a5,0
      if (buf != c->buf) {
    3f4e:	c911                	beqz	a0,3f62 <stbsp_vsnprintf+0x50>
            *d++ = *s++;
    3f50:	0007c803          	lbu	a6,0(a5)
    3f54:	0785                	addi	a5,a5,1
    3f56:	00f40533          	add	a0,s0,a5
    3f5a:	ff050fa3          	sb	a6,-1(a0)
         } while (s < se);
    3f5e:	feb7e9e3          	bltu	a5,a1,3f50 <stbsp_vsnprintf+0x3e>
      c->count -= len;
    3f62:	40b486bb          	subw	a3,s1,a1
      c->buf += len;
    3f66:	95a2                	add	a1,a1,s0
    3f68:	e02e                	sd	a1,0(sp)
      c->count -= len;
    3f6a:	c436                	sw	a3,8(sp)
   return (c->count >= STB_SPRINTF_MIN) ? c->buf : c->tmp; // go direct into buffer if you can
    3f6c:	1ff00793          	li	a5,511
    3f70:	fcd7d1e3          	bge	a5,a3,3f32 <stbsp_vsnprintf+0x20>
    3f74:	6602                	ld	a2,0(sp)
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__clamp_callback, &c, stbsp__clamp_callback(0,&c,0), fmt, va );
    3f76:	86c6                	mv	a3,a7
    3f78:	858a                	mv	a1,sp
    3f7a:	ffffd517          	auipc	a0,0xffffd
    3f7e:	21650513          	addi	a0,a0,534 # 1190 <stbsp__clamp_callback>
    3f82:	b4cfe0ef          	jal	22ce <stbsp_vsprintfcb>
      l = (int)( c.buf - buf );
    3f86:	6782                	ld	a5,0(sp)
    3f88:	9f81                	subw	a5,a5,s0
      if ( l >= count ) // should never be greater, only equal (or less) than count
    3f8a:	0097c463          	blt	a5,s1,3f92 <stbsp_vsnprintf+0x80>
         l = count - 1;
    3f8e:	fff4879b          	addiw	a5,s1,-1
      buf[l] = 0;
    3f92:	943e                	add	s0,s0,a5
    3f94:	00040023          	sb	zero,0(s0)
}
    3f98:	22813083          	ld	ra,552(sp)
    3f9c:	22013403          	ld	s0,544(sp)
    3fa0:	4532                	lw	a0,12(sp)
    3fa2:	21813483          	ld	s1,536(sp)
    3fa6:	23010113          	addi	sp,sp,560
    3faa:	8082                	ret
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__count_clamp_callback, &c, c.tmp, fmt, va );
    3fac:	86b2                	mv	a3,a2
    3fae:	858a                	mv	a1,sp
    3fb0:	0810                	addi	a2,sp,16
    3fb2:	ffffd517          	auipc	a0,0xffffd
    3fb6:	22c50513          	addi	a0,a0,556 # 11de <stbsp__count_clamp_callback>
      c.length = 0;
    3fba:	c602                	sw	zero,12(sp)
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__count_clamp_callback, &c, c.tmp, fmt, va );
    3fbc:	b12fe0ef          	jal	22ce <stbsp_vsprintfcb>
}
    3fc0:	22813083          	ld	ra,552(sp)
    3fc4:	22013403          	ld	s0,544(sp)
    3fc8:	4532                	lw	a0,12(sp)
    3fca:	21813483          	ld	s1,536(sp)
    3fce:	23010113          	addi	sp,sp,560
    3fd2:	8082                	ret
    3fd4:	86a6                	mv	a3,s1
    3fd6:	bf59                	j	3f6c <stbsp_vsnprintf+0x5a>

0000000000003fd8 <stbsp_snprintf>:
{
    3fd8:	715d                	addi	sp,sp,-80
   va_start(va, fmt);
    3fda:	02810313          	addi	t1,sp,40
{
    3fde:	f436                	sd	a3,40(sp)
   result = STB_SPRINTF_DECORATE(vsnprintf)(buf, count, fmt, va);
    3fe0:	869a                	mv	a3,t1
{
    3fe2:	ec06                	sd	ra,24(sp)
    3fe4:	f83a                	sd	a4,48(sp)
    3fe6:	fc3e                	sd	a5,56(sp)
    3fe8:	e0c2                	sd	a6,64(sp)
    3fea:	e4c6                	sd	a7,72(sp)
   va_start(va, fmt);
    3fec:	e41a                	sd	t1,8(sp)
   result = STB_SPRINTF_DECORATE(vsnprintf)(buf, count, fmt, va);
    3fee:	f25ff0ef          	jal	3f12 <stbsp_vsnprintf>
}
    3ff2:	60e2                	ld	ra,24(sp)
    3ff4:	6161                	addi	sp,sp,80
    3ff6:	8082                	ret

0000000000003ff8 <stbsp_vsprintf>:
{
    3ff8:	86ae                	mv	a3,a1
    3ffa:	8732                	mv	a4,a2
   return STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    3ffc:	4581                	li	a1,0
    3ffe:	862a                	mv	a2,a0
    4000:	4501                	li	a0,0
    4002:	accfe06f          	j	22ce <stbsp_vsprintfcb>

0000000000004006 <sprintf>:
{
    4006:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    4008:	05010313          	addi	t1,sp,80
{
    400c:	e0a2                	sd	s0,64(sp)
    400e:	fc26                	sd	s1,56(sp)
    4010:	842a                	mv	s0,a0
    4012:	e8b2                	sd	a2,80(sp)
    _vprintf_core(&ctx, format, ap);
    4014:	0808                	addi	a0,sp,16
    ctx.limit = size;
    4016:	54fd                	li	s1,-1
    _vprintf_core(&ctx, format, ap);
    4018:	861a                	mv	a2,t1
{
    401a:	e486                	sd	ra,72(sp)
    401c:	ecb6                	sd	a3,88(sp)
    401e:	f0ba                	sd	a4,96(sp)
    4020:	f4be                	sd	a5,104(sp)
    4022:	f8c2                	sd	a6,112(sp)
    4024:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    4026:	e41a                	sd	t1,8(sp)
    ctx.buf = str;
    4028:	e822                	sd	s0,16(sp)
    ctx.limit = size;
    402a:	ec26                	sd	s1,24(sp)
    ctx.written = 0;
    402c:	f002                	sd	zero,32(sp)
    ctx.stream = NULL;
    402e:	f402                	sd	zero,40(sp)
    _vprintf_core(&ctx, format, ap);
    4030:	02c000ef          	jal	405c <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    4034:	7502                	ld	a0,32(sp)
    4036:	00950b63          	beq	a0,s1,404c <sprintf+0x46>
            str[ctx.written] = '\0';
    403a:	942a                	add	s0,s0,a0
    403c:	00040023          	sb	zero,0(s0)
}
    4040:	60a6                	ld	ra,72(sp)
    4042:	6406                	ld	s0,64(sp)
    4044:	74e2                	ld	s1,56(sp)
    4046:	2501                	sext.w	a0,a0
    4048:	6109                	addi	sp,sp,128
    404a:	8082                	ret
            str[size - 1] = '\0';
    404c:	fe040f23          	sb	zero,-2(s0)
}
    4050:	60a6                	ld	ra,72(sp)
    4052:	6406                	ld	s0,64(sp)
    4054:	74e2                	ld	s1,56(sp)
    4056:	2501                	sext.w	a0,a0
    4058:	6109                	addi	sp,sp,128
    405a:	8082                	ret

000000000000405c <_vprintf_core.constprop.0.isra.0>:
static int _vprintf_core(_OutContext *ctx, const char *format, va_list ap)
    405c:	7129                	addi	sp,sp,-320
    405e:	edee                	sd	s11,216(sp)
    4060:	fe06                	sd	ra,312(sp)
    4062:	8dae                	mv	s11,a1
    while (*p)
    4064:	0005c583          	lbu	a1,0(a1)
    4068:	cde9                	beqz	a1,4142 <_vprintf_core.constprop.0.isra.0+0xe6>
    406a:	f626                	sd	s1,296(sp)
    406c:	f24a                	sd	s2,288(sp)
    406e:	ee4e                	sd	s3,280(sp)
    4070:	e656                	sd	s5,264(sp)
    4072:	f9e2                	sd	s8,240(sp)
    4074:	fa22                	sd	s0,304(sp)
    4076:	ea52                	sd	s4,272(sp)
    4078:	e25a                	sd	s6,256(sp)
    407a:	fdde                	sd	s7,248(sp)
    407c:	f5e6                	sd	s9,232(sp)
    407e:	f1ea                	sd	s10,224(sp)
    4080:	84aa                	mv	s1,a0
    4082:	8c32                	mv	s8,a2
        if (*p != '%')
    4084:	02500a93          	li	s5,37
    4088:	49c1                	li	s3,16
    408a:	00002917          	auipc	s2,0x2
    408e:	43a90913          	addi	s2,s2,1082 # 64c4 <_GLOBAL__sub_I__ZSt3cin+0x4d4>
    4092:	a039                	j	40a0 <_vprintf_core.constprop.0.isra.0+0x44>
                _out_char(ctx, spec);
    4094:	8526                	mv	a0,s1
    4096:	952fe0ef          	jal	21e8 <_out_char>
    while (*p)
    409a:	000dc583          	lbu	a1,0(s11)
    409e:	c5d9                	beqz	a1,412c <_vprintf_core.constprop.0.isra.0+0xd0>
            _out_char(ctx, *p++);
    40a0:	0d85                	addi	s11,s11,1
        if (*p != '%')
    40a2:	ff5599e3          	bne	a1,s5,4094 <_vprintf_core.constprop.0.isra.0+0x38>
        int flag_left = 0, flag_zero = 0, flag_plus = 0, flag_space = 0, flag_hash = 0;
    40a6:	4501                	li	a0,0
    40a8:	4881                	li	a7,0
    40aa:	4581                	li	a1,0
    40ac:	4b01                	li	s6,0
    40ae:	4a01                	li	s4,0
            if (*p == '-')
    40b0:	000dcc83          	lbu	s9,0(s11)
    40b4:	fe0c871b          	addiw	a4,s9,-32
    40b8:	0ff77713          	zext.b	a4,a4
    40bc:	00e9e763          	bltu	s3,a4,40ca <_vprintf_core.constprop.0.isra.0+0x6e>
    40c0:	070a                	slli	a4,a4,0x2
    40c2:	974a                	add	a4,a4,s2
    40c4:	4318                	lw	a4,0(a4)
    40c6:	974a                	add	a4,a4,s2
    40c8:	8702                	jr	a4
        if (*p == '*')
    40ca:	02a00793          	li	a5,42
    40ce:	16fc9c63          	bne	s9,a5,4246 <_vprintf_core.constprop.0.isra.0+0x1ea>
            width = va_arg(ap, int);
    40d2:	000c2403          	lw	s0,0(s8)
    40d6:	0c21                	addi	s8,s8,8
            if (width < 0)
    40d8:	00045563          	bgez	s0,40e2 <_vprintf_core.constprop.0.isra.0+0x86>
                width = -width;
    40dc:	4080043b          	negw	s0,s0
                flag_left = 1;
    40e0:	4a05                	li	s4,1
            while (*p >= '0' && *p <= '9')
    40e2:	001dcc83          	lbu	s9,1(s11)
            p++;
    40e6:	0d85                	addi	s11,s11,1
        if (*p == '.')
    40e8:	02e00793          	li	a5,46
        int precision = -1;
    40ec:	5bfd                	li	s7,-1
        if (*p == '.')
    40ee:	18fc8a63          	beq	s9,a5,4282 <_vprintf_core.constprop.0.isra.0+0x226>
        if (*p == 'l')
    40f2:	06c00693          	li	a3,108
    40f6:	8666                	mv	a2,s9
    40f8:	1adc8663          	beq	s9,a3,42a4 <_vprintf_core.constprop.0.isra.0+0x248>
        else if (*p == 'z')
    40fc:	07a00693          	li	a3,122
            p++;
    4100:	0d85                	addi	s11,s11,1
        else if (*p == 'z')
    4102:	24dc8163          	beq	s9,a3,4344 <_vprintf_core.constprop.0.isra.0+0x2e8>
        if (!spec)
    4106:	06400693          	li	a3,100
    410a:	4adc8163          	beq	s9,a3,45ac <_vprintf_core.constprop.0.isra.0+0x550>
    410e:	06400693          	li	a3,100
        int len_mod = 0;
    4112:	4e81                	li	t4,0
    4114:	1b96e663          	bltu	a3,s9,42c0 <_vprintf_core.constprop.0.isra.0+0x264>
    4118:	04700693          	li	a3,71
    411c:	2796e463          	bltu	a3,s9,4384 <_vprintf_core.constprop.0.isra.0+0x328>
    4120:	04400693          	li	a3,68
    4124:	0596e363          	bltu	a3,s9,416a <_vprintf_core.constprop.0.isra.0+0x10e>
    4128:	240c9363          	bnez	s9,436e <_vprintf_core.constprop.0.isra.0+0x312>
    412c:	7452                	ld	s0,304(sp)
    412e:	74b2                	ld	s1,296(sp)
    4130:	7912                	ld	s2,288(sp)
    4132:	69f2                	ld	s3,280(sp)
    4134:	6a52                	ld	s4,272(sp)
    4136:	6ab2                	ld	s5,264(sp)
    4138:	6b12                	ld	s6,256(sp)
    413a:	7bee                	ld	s7,248(sp)
    413c:	7c4e                	ld	s8,240(sp)
    413e:	7cae                	ld	s9,232(sp)
    4140:	7d0e                	ld	s10,224(sp)
}
    4142:	70f2                	ld	ra,312(sp)
    4144:	6dee                	ld	s11,216(sp)
    4146:	6131                	addi	sp,sp,320
    4148:	8082                	ret
            if (*p == '-')
    414a:	4585                	li	a1,1
            p++;
    414c:	0d85                	addi	s11,s11,1
            if (*p == '-')
    414e:	b78d                	j	40b0 <_vprintf_core.constprop.0.isra.0+0x54>
    4150:	4505                	li	a0,1
            p++;
    4152:	0d85                	addi	s11,s11,1
        while (1)
    4154:	bfb1                	j	40b0 <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    4156:	4885                	li	a7,1
            p++;
    4158:	0d85                	addi	s11,s11,1
        while (1)
    415a:	bf99                	j	40b0 <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    415c:	4b05                	li	s6,1
            p++;
    415e:	0d85                	addi	s11,s11,1
        while (1)
    4160:	bf81                	j	40b0 <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    4162:	4a05                	li	s4,1
            p++;
    4164:	0d85                	addi	s11,s11,1
        while (1)
    4166:	b7a9                	j	40b0 <_vprintf_core.constprop.0.isra.0+0x54>
        char spec = *p++;
    4168:	8dbe                	mv	s11,a5
            fmt_tmp[f_idx++] = '%';
    416a:	02500693          	li	a3,37
    416e:	02d10823          	sb	a3,48(sp)
    4172:	4d05                	li	s10,1
            if (flag_left)
    4174:	000a0763          	beqz	s4,4182 <_vprintf_core.constprop.0.isra.0+0x126>
                fmt_tmp[f_idx++] = '-';
    4178:	02d00693          	li	a3,45
    417c:	02d108a3          	sb	a3,49(sp)
    4180:	4d09                	li	s10,2
            if (flag_zero)
    4182:	000b0c63          	beqz	s6,419a <_vprintf_core.constprop.0.isra.0+0x13e>
                fmt_tmp[f_idx++] = '0';
    4186:	0c0d0793          	addi	a5,s10,192
    418a:	0818                	addi	a4,sp,16
    418c:	00e786b3          	add	a3,a5,a4
    4190:	03000613          	li	a2,48
    4194:	f6c68023          	sb	a2,-160(a3)
    4198:	2d05                	addiw	s10,s10,1
            if (flag_plus)
    419a:	c999                	beqz	a1,41b0 <_vprintf_core.constprop.0.isra.0+0x154>
                fmt_tmp[f_idx++] = '+';
    419c:	0c0d0793          	addi	a5,s10,192
    41a0:	0818                	addi	a4,sp,16
    41a2:	00e786b3          	add	a3,a5,a4
    41a6:	02b00613          	li	a2,43
    41aa:	f6c68023          	sb	a2,-160(a3)
    41ae:	2d05                	addiw	s10,s10,1
            if (flag_space)
    41b0:	00088c63          	beqz	a7,41c8 <_vprintf_core.constprop.0.isra.0+0x16c>
                fmt_tmp[f_idx++] = ' ';
    41b4:	0c0d0793          	addi	a5,s10,192
    41b8:	0818                	addi	a4,sp,16
    41ba:	00e786b3          	add	a3,a5,a4
    41be:	02000613          	li	a2,32
    41c2:	f6c68023          	sb	a2,-160(a3)
    41c6:	2d05                	addiw	s10,s10,1
            if (flag_hash)
    41c8:	c919                	beqz	a0,41de <_vprintf_core.constprop.0.isra.0+0x182>
                fmt_tmp[f_idx++] = '#';
    41ca:	0c0d0793          	addi	a5,s10,192
    41ce:	0818                	addi	a4,sp,16
    41d0:	00e786b3          	add	a3,a5,a4
    41d4:	02300613          	li	a2,35
    41d8:	f6c68023          	sb	a2,-160(a3)
    41dc:	2d05                	addiw	s10,s10,1
            if (width > 0)
    41de:	03010a13          	addi	s4,sp,48
    41e2:	28804563          	bgtz	s0,446c <_vprintf_core.constprop.0.isra.0+0x410>
            if (precision >= 0)
    41e6:	260bd763          	bgez	s7,4454 <_vprintf_core.constprop.0.isra.0+0x3f8>
            fmt_tmp[f_idx++] = spec;
    41ea:	0c0d0793          	addi	a5,s10,192
    41ee:	0818                	addi	a4,sp,16
    41f0:	00e78633          	add	a2,a5,a4
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    41f4:	000c3683          	ld	a3,0(s8)
            fmt_tmp[f_idx] = '\0';
    41f8:	001d071b          	addiw	a4,s10,1
    41fc:	0c070793          	addi	a5,a4,192
    4200:	0818                	addi	a4,sp,16
            fmt_tmp[f_idx++] = spec;
    4202:	f7960023          	sb	s9,-160(a2)
            fmt_tmp[f_idx] = '\0';
    4206:	973e                	add	a4,a4,a5
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    4208:	08000593          	li	a1,128
    420c:	8652                	mv	a2,s4
    420e:	0888                	addi	a0,sp,80
            fmt_tmp[f_idx] = '\0';
    4210:	f6070023          	sb	zero,-160(a4)
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    4214:	dc5ff0ef          	jal	3fd8 <stbsp_snprintf>
            for (int i = 0; f_buf[i] != '\0'; i++)
    4218:	05014583          	lbu	a1,80(sp)
            double f_val = va_arg(ap, double);
    421c:	0c21                	addi	s8,s8,8
            for (int i = 0; f_buf[i] != '\0'; i++)
    421e:	05110413          	addi	s0,sp,81
    4222:	e6058ce3          	beqz	a1,409a <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, f_buf[i]);
    4226:	8526                	mv	a0,s1
    4228:	fc1fd0ef          	jal	21e8 <_out_char>
            for (int i = 0; f_buf[i] != '\0'; i++)
    422c:	00044583          	lbu	a1,0(s0)
    4230:	0405                	addi	s0,s0,1
    4232:	e60584e3          	beqz	a1,409a <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, f_buf[i]);
    4236:	8526                	mv	a0,s1
    4238:	fb1fd0ef          	jal	21e8 <_out_char>
            for (int i = 0; f_buf[i] != '\0'; i++)
    423c:	00044583          	lbu	a1,0(s0)
    4240:	0405                	addi	s0,s0,1
    4242:	f1f5                	bnez	a1,4226 <_vprintf_core.constprop.0.isra.0+0x1ca>
    4244:	bd99                	j	409a <_vprintf_core.constprop.0.isra.0+0x3e>
            while (*p >= '0' && *p <= '9')
    4246:	fd0c869b          	addiw	a3,s9,-48
    424a:	0ff6f313          	zext.b	t1,a3
    424e:	4725                	li	a4,9
        int width = 0;
    4250:	4401                	li	s0,0
            while (*p >= '0' && *p <= '9')
    4252:	4625                	li	a2,9
    4254:	e8676ae3          	bltu	a4,t1,40e8 <_vprintf_core.constprop.0.isra.0+0x8c>
    4258:	001dcc83          	lbu	s9,1(s11)
                width = width * 10 + (*p - '0');
    425c:	0024171b          	slliw	a4,s0,0x2
    4260:	9f21                	addw	a4,a4,s0
    4262:	0017171b          	slliw	a4,a4,0x1
    4266:	00e6843b          	addw	s0,a3,a4
            while (*p >= '0' && *p <= '9')
    426a:	fd0c869b          	addiw	a3,s9,-48
    426e:	0ff6f713          	zext.b	a4,a3
                p++;
    4272:	0d85                	addi	s11,s11,1
            while (*p >= '0' && *p <= '9')
    4274:	fee672e3          	bgeu	a2,a4,4258 <_vprintf_core.constprop.0.isra.0+0x1fc>
        if (*p == '.')
    4278:	02e00793          	li	a5,46
        int precision = -1;
    427c:	5bfd                	li	s7,-1
        if (*p == '.')
    427e:	e6fc9ae3          	bne	s9,a5,40f2 <_vprintf_core.constprop.0.isra.0+0x96>
            if (*p == '*')
    4282:	001dcc83          	lbu	s9,1(s11)
    4286:	02a00793          	li	a5,42
    428a:	16fc9f63          	bne	s9,a5,4408 <_vprintf_core.constprop.0.isra.0+0x3ac>
                while (*p >= '0' && *p <= '9')
    428e:	002dcc83          	lbu	s9,2(s11)
        if (*p == 'l')
    4292:	06c00693          	li	a3,108
                precision = va_arg(ap, int);
    4296:	000c2b83          	lw	s7,0(s8)
                p++;
    429a:	0d89                	addi	s11,s11,2
                precision = va_arg(ap, int);
    429c:	0c21                	addi	s8,s8,8
        if (*p == 'l')
    429e:	8666                	mv	a2,s9
    42a0:	e4dc9ee3          	bne	s9,a3,40fc <_vprintf_core.constprop.0.isra.0+0xa0>
            if (*p == 'l')
    42a4:	001dcc83          	lbu	s9,1(s11)
    42a8:	08cc8d63          	beq	s9,a2,4342 <_vprintf_core.constprop.0.isra.0+0x2e6>
        char spec = *p++;
    42ac:	06400693          	li	a3,100
    42b0:	0d89                	addi	s11,s11,2
        if (!spec)
    42b2:	4cdc8c63          	beq	s9,a3,478a <_vprintf_core.constprop.0.isra.0+0x72e>
    42b6:	06400693          	li	a3,100
            len_mod = 1;
    42ba:	4e85                	li	t4,1
    42bc:	e596fee3          	bgeu	a3,s9,4118 <_vprintf_core.constprop.0.isra.0+0xbc>
    42c0:	f9bc869b          	addiw	a3,s9,-101
    42c4:	0ff6f693          	zext.b	a3,a3
    42c8:	464d                	li	a2,19
    42ca:	12d66863          	bltu	a2,a3,43fa <_vprintf_core.constprop.0.isra.0+0x39e>
    42ce:	4e05                	li	t3,1
    42d0:	00091637          	lui	a2,0x91
    42d4:	00de1333          	sll	t1,t3,a3
    42d8:	81060613          	addi	a2,a2,-2032 # 90810 <_ZSt4cerr+0x879a0>
    42dc:	00c37633          	and	a2,t1,a2
    42e0:	1a061463          	bnez	a2,4488 <_vprintf_core.constprop.0.isra.0+0x42c>
    42e4:	00737313          	andi	t1,t1,7
    42e8:	e80311e3          	bnez	t1,416a <_vprintf_core.constprop.0.isra.0+0x10e>
    42ec:	4639                	li	a2,14
    42ee:	10c69663          	bne	a3,a2,43fa <_vprintf_core.constprop.0.isra.0+0x39e>
            const char *s = va_arg(ap, char *);
    42f2:	000c3c83          	ld	s9,0(s8)
            if (!s)
    42f6:	420c8863          	beqz	s9,4726 <_vprintf_core.constprop.0.isra.0+0x6ca>
            while (*tmp && (precision < 0 || len < precision))
    42fa:	000cc683          	lbu	a3,0(s9)
    42fe:	38068863          	beqz	a3,468e <_vprintf_core.constprop.0.isra.0+0x632>
            const char *tmp = s;
    4302:	8666                	mv	a2,s9
            int len = 0;
    4304:	4681                	li	a3,0
            while (*tmp && (precision < 0 || len < precision))
    4306:	00db8863          	beq	s7,a3,4316 <_vprintf_core.constprop.0.isra.0+0x2ba>
    430a:	00164583          	lbu	a1,1(a2)
                len++;
    430e:	2685                	addiw	a3,a3,1
                tmp++;
    4310:	0605                	addi	a2,a2,1
            while (*tmp && (precision < 0 || len < precision))
    4312:	f9f5                	bnez	a1,4306 <_vprintf_core.constprop.0.isra.0+0x2aa>
    4314:	8bb6                	mv	s7,a3
            int padding = (width > len) ? width - len : 0;
    4316:	268bc563          	blt	s7,s0,4580 <_vprintf_core.constprop.0.isra.0+0x524>
            for (int i = 0; i < len; i++)
    431a:	4401                	li	s0,0
    431c:	020b8163          	beqz	s7,433e <_vprintf_core.constprop.0.isra.0+0x2e2>
    4320:	4d01                	li	s10,0
                _out_char(ctx, s[i]);
    4322:	01ac86b3          	add	a3,s9,s10
    4326:	0006c583          	lbu	a1,0(a3)
    432a:	8526                	mv	a0,s1
            for (int i = 0; i < len; i++)
    432c:	0d05                	addi	s10,s10,1
                _out_char(ctx, s[i]);
    432e:	ebbfd0ef          	jal	21e8 <_out_char>
            for (int i = 0; i < len; i++)
    4332:	000d069b          	sext.w	a3,s10
    4336:	ff76c6e3          	blt	a3,s7,4322 <_vprintf_core.constprop.0.isra.0+0x2c6>
            if (flag_left)
    433a:	260a1463          	bnez	s4,45a2 <_vprintf_core.constprop.0.isra.0+0x546>
            const char *s = va_arg(ap, char *);
    433e:	0c21                	addi	s8,s8,8
    4340:	bba9                	j	409a <_vprintf_core.constprop.0.isra.0+0x3e>
                p++;
    4342:	0d89                	addi	s11,s11,2
        char spec = *p++;
    4344:	000dcc83          	lbu	s9,0(s11)
    4348:	06400693          	li	a3,100
    434c:	001d8793          	addi	a5,s11,1
        if (!spec)
    4350:	3edc8063          	beq	s9,a3,4730 <_vprintf_core.constprop.0.isra.0+0x6d4>
    4354:	0796ea63          	bltu	a3,s9,43c8 <_vprintf_core.constprop.0.isra.0+0x36c>
    4358:	04700693          	li	a3,71
    435c:	0f96e263          	bltu	a3,s9,4440 <_vprintf_core.constprop.0.isra.0+0x3e4>
    4360:	04400693          	li	a3,68
    4364:	e196e2e3          	bltu	a3,s9,4168 <_vprintf_core.constprop.0.isra.0+0x10c>
    4368:	dc0c82e3          	beqz	s9,412c <_vprintf_core.constprop.0.isra.0+0xd0>
        char spec = *p++;
    436c:	8dbe                	mv	s11,a5
            _out_char(ctx, '%');
    436e:	02500593          	li	a1,37
    4372:	8526                	mv	a0,s1
    4374:	e75fd0ef          	jal	21e8 <_out_char>
            if (spec != '%')
    4378:	02500713          	li	a4,37
    437c:	d0ec8fe3          	beq	s9,a4,409a <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, spec);
    4380:	85e6                	mv	a1,s9
    4382:	bb09                	j	4094 <_vprintf_core.constprop.0.isra.0+0x38>
    4384:	05800693          	li	a3,88
    4388:	2edc8263          	beq	s9,a3,466c <_vprintf_core.constprop.0.isra.0+0x610>
    438c:	06300713          	li	a4,99
    4390:	06ec9563          	bne	s9,a4,43fa <_vprintf_core.constprop.0.isra.0+0x39e>
            char c = (char)va_arg(ap, int);
    4394:	000c4c83          	lbu	s9,0(s8)
            int padding = (width > 1) ? width - 1 : 0;
    4398:	8722                	mv	a4,s0
    439a:	00804363          	bgtz	s0,43a0 <_vprintf_core.constprop.0.isra.0+0x344>
    439e:	4705                	li	a4,1
    43a0:	fff7041b          	addiw	s0,a4,-1
            if (!flag_left)
    43a4:	3c0a0463          	beqz	s4,476c <_vprintf_core.constprop.0.isra.0+0x710>
            _out_char(ctx, c);
    43a8:	85e6                	mv	a1,s9
    43aa:	8526                	mv	a0,s1
    43ac:	e3dfd0ef          	jal	21e8 <_out_char>
                for (int i = 0; i < padding; i++)
    43b0:	4a01                	li	s4,0
    43b2:	d451                	beqz	s0,433e <_vprintf_core.constprop.0.isra.0+0x2e2>
                    _out_char(ctx, ' ');
    43b4:	02000593          	li	a1,32
    43b8:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    43ba:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    43bc:	e2dfd0ef          	jal	21e8 <_out_char>
                for (int i = 0; i < padding; i++)
    43c0:	ff441ae3          	bne	s0,s4,43b4 <_vprintf_core.constprop.0.isra.0+0x358>
            const char *s = va_arg(ap, char *);
    43c4:	0c21                	addi	s8,s8,8
    43c6:	b9d1                	j	409a <_vprintf_core.constprop.0.isra.0+0x3e>
    43c8:	f9bc861b          	addiw	a2,s9,-101
    43cc:	0ff67613          	zext.b	a2,a2
    43d0:	46cd                	li	a3,19
    43d2:	40c6e963          	bltu	a3,a2,47e4 <_vprintf_core.constprop.0.isra.0+0x788>
    43d6:	00091337          	lui	t1,0x91
    43da:	4685                	li	a3,1
    43dc:	00c696b3          	sll	a3,a3,a2
    43e0:	81030313          	addi	t1,t1,-2032 # 90810 <_ZSt4cerr+0x879a0>
    43e4:	0066f333          	and	t1,a3,t1
    43e8:	34031c63          	bnez	t1,4740 <_vprintf_core.constprop.0.isra.0+0x6e4>
    43ec:	8a9d                	andi	a3,a3,7
    43ee:	d6069de3          	bnez	a3,4168 <_vprintf_core.constprop.0.isra.0+0x10c>
    43f2:	46b9                	li	a3,14
        char spec = *p++;
    43f4:	8dbe                	mv	s11,a5
    43f6:	eed60ee3          	beq	a2,a3,42f2 <_vprintf_core.constprop.0.isra.0+0x296>
            _out_char(ctx, '%');
    43fa:	02500593          	li	a1,37
    43fe:	8526                	mv	a0,s1
    4400:	de9fd0ef          	jal	21e8 <_out_char>
                _out_char(ctx, spec);
    4404:	85e6                	mv	a1,s9
    4406:	b179                	j	4094 <_vprintf_core.constprop.0.isra.0+0x38>
                while (*p >= '0' && *p <= '9')
    4408:	fd0c869b          	addiw	a3,s9,-48
    440c:	0ff6fe13          	zext.b	t3,a3
    4410:	4625                	li	a2,9
            p++;
    4412:	0d85                	addi	s11,s11,1
                precision = 0;
    4414:	4b81                	li	s7,0
                while (*p >= '0' && *p <= '9')
    4416:	4325                	li	t1,9
    4418:	cdc66de3          	bltu	a2,t3,40f2 <_vprintf_core.constprop.0.isra.0+0x96>
                    precision = precision * 10 + (*p - '0');
    441c:	002b961b          	slliw	a2,s7,0x2
                while (*p >= '0' && *p <= '9')
    4420:	001dcc83          	lbu	s9,1(s11)
                    precision = precision * 10 + (*p - '0');
    4424:	0176073b          	addw	a4,a2,s7
    4428:	0017171b          	slliw	a4,a4,0x1
    442c:	00e68bbb          	addw	s7,a3,a4
                while (*p >= '0' && *p <= '9')
    4430:	fd0c869b          	addiw	a3,s9,-48
    4434:	0ff6f613          	zext.b	a2,a3
                    p++;
    4438:	0d85                	addi	s11,s11,1
                while (*p >= '0' && *p <= '9')
    443a:	fec371e3          	bgeu	t1,a2,441c <_vprintf_core.constprop.0.isra.0+0x3c0>
    443e:	b955                	j	40f2 <_vprintf_core.constprop.0.isra.0+0x96>
    4440:	05800693          	li	a3,88
    4444:	3cdc8d63          	beq	s9,a3,481e <_vprintf_core.constprop.0.isra.0+0x7c2>
    4448:	06300713          	li	a4,99
        char spec = *p++;
    444c:	8dbe                	mv	s11,a5
    444e:	f4ec83e3          	beq	s9,a4,4394 <_vprintf_core.constprop.0.isra.0+0x338>
    4452:	b765                	j	43fa <_vprintf_core.constprop.0.isra.0+0x39e>
                f_idx += sprintf(&fmt_tmp[f_idx], ".%d", precision);
    4454:	01aa0533          	add	a0,s4,s10
    4458:	865e                	mv	a2,s7
    445a:	00002597          	auipc	a1,0x2
    445e:	dee58593          	addi	a1,a1,-530 # 6248 <_GLOBAL__sub_I__ZSt3cin+0x258>
    4462:	ba5ff0ef          	jal	4006 <sprintf>
    4466:	00ad0d3b          	addw	s10,s10,a0
    446a:	b341                	j	41ea <_vprintf_core.constprop.0.isra.0+0x18e>
                f_idx += sprintf(&fmt_tmp[f_idx], "%d", width);
    446c:	01aa0533          	add	a0,s4,s10
    4470:	8622                	mv	a2,s0
    4472:	00002597          	auipc	a1,0x2
    4476:	dce58593          	addi	a1,a1,-562 # 6240 <_GLOBAL__sub_I__ZSt3cin+0x250>
    447a:	b8dff0ef          	jal	4006 <sprintf>
    447e:	00ad0d3b          	addw	s10,s10,a0
            if (precision >= 0)
    4482:	d60bc4e3          	bltz	s7,41ea <_vprintf_core.constprop.0.isra.0+0x18e>
    4486:	b7f9                	j	4454 <_vprintf_core.constprop.0.isra.0+0x3f8>
            int is_signed = (spec == 'd' || spec == 'i');
    4488:	06900693          	li	a3,105
    448c:	10dc8e63          	beq	s9,a3,45a8 <_vprintf_core.constprop.0.isra.0+0x54c>
                val = (uint64)va_arg(ap, void *);
    4490:	008c0793          	addi	a5,s8,8
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    4494:	07800693          	li	a3,120
                val = (uint64)va_arg(ap, void *);
    4498:	e43e                	sd	a5,8(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    449a:	38dc9d63          	bne	s9,a3,4834 <_vprintf_core.constprop.0.isra.0+0x7d8>
            else if (len_mod == 1)
    449e:	33ce8963          	beq	t4,t3,47d0 <_vprintf_core.constprop.0.isra.0+0x774>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    44a2:	000c6e03          	lwu	t3,0(s8)
    44a6:	85f6                	mv	a1,t4
    44a8:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    44aa:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    44ac:	00002f97          	auipc	t6,0x2
    44b0:	d64f8f93          	addi	t6,t6,-668 # 6210 <_GLOBAL__sub_I__ZSt3cin+0x220>
    if (val == 0)
    44b4:	120e0363          	beqz	t3,45da <_vprintf_core.constprop.0.isra.0+0x57e>
    44b8:	01010293          	addi	t0,sp,16
                    sign_char = '-';
    44bc:	8616                	mv	a2,t0
    44be:	86f2                	mv	a3,t3
        buf[i++] = digits[val % base];
    44c0:	0266f8b3          	remu	a7,a3,t1
    44c4:	8f32                	mv	t5,a2
    while (val != 0)
    44c6:	0605                	addi	a2,a2,1
    44c8:	8eb6                	mv	t4,a3
        buf[i++] = digits[val % base];
    44ca:	98fe                	add	a7,a7,t6
    44cc:	0008c883          	lbu	a7,0(a7)
        val /= base;
    44d0:	0266d6b3          	divu	a3,a3,t1
        buf[i++] = digits[val % base];
    44d4:	ff160fa3          	sb	a7,-1(a2)
    while (val != 0)
    44d8:	fe6ef4e3          	bgeu	t4,t1,44c0 <_vprintf_core.constprop.0.isra.0+0x464>
        buf[i++] = digits[val % base];
    44dc:	405f0f3b          	subw	t5,t5,t0
    44e0:	2f05                	addiw	t5,t5,1
            if (precision >= 0)
    44e2:	100bc363          	bltz	s7,45e8 <_vprintf_core.constprop.0.isra.0+0x58c>
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    44e6:	1d7f4d63          	blt	t5,s7,46c0 <_vprintf_core.constprop.0.isra.0+0x664>
            if (precision == 0 && val == 0)
    44ea:	340b9163          	bnez	s7,482c <_vprintf_core.constprop.0.isra.0+0x7d0>
    44ee:	200e0763          	beqz	t3,46fc <_vprintf_core.constprop.0.isra.0+0x6a0>
            for (int i = digit_len - 1; i >= 0; i--)
    44f2:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    44f6:	07000693          	li	a3,112
            for (int i = digit_len - 1; i >= 0; i--)
    44fa:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    44fc:	28dc8e63          	beq	s9,a3,4798 <_vprintf_core.constprop.0.isra.0+0x73c>
    4500:	2a051663          	bnez	a0,47ac <_vprintf_core.constprop.0.isra.0+0x750>
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    4504:	00bf05bb          	addw	a1,t5,a1
    4508:	8d52                	mv	s10,s4
    450a:	4b01                	li	s6,0
            char *prefix_str = NULL;
    450c:	4c81                	li	s9,0
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    450e:	1085d263          	bge	a1,s0,4612 <_vprintf_core.constprop.0.isra.0+0x5b6>
    4512:	9c0d                	subw	s0,s0,a1
            if (!flag_left && !flag_zero)
    4514:	100d0a63          	beqz	s10,4628 <_vprintf_core.constprop.0.isra.0+0x5cc>
            if (sign_char)
    4518:	6782                	ld	a5,0(sp)
    451a:	10079263          	bnez	a5,461e <_vprintf_core.constprop.0.isra.0+0x5c2>
            if (prefix_str)
    451e:	000c8c63          	beqz	s9,4536 <_vprintf_core.constprop.0.isra.0+0x4da>
                _out_char(ctx, prefix_str[0]);
    4522:	000cc583          	lbu	a1,0(s9)
    4526:	8526                	mv	a0,s1
    4528:	cc1fd0ef          	jal	21e8 <_out_char>
                _out_char(ctx, prefix_str[1]);
    452c:	001cc583          	lbu	a1,1(s9)
    4530:	8526                	mv	a0,s1
    4532:	cb7fd0ef          	jal	21e8 <_out_char>
            int total_zeros = prec_zeros + ((flag_zero && !flag_left) ? padding : 0);
    4536:	180b0263          	beqz	s6,46ba <_vprintf_core.constprop.0.isra.0+0x65e>
    453a:	100a1863          	bnez	s4,464a <_vprintf_core.constprop.0.isra.0+0x5ee>
    453e:	008b8bbb          	addw	s7,s7,s0
            for (int i = 0; i < total_zeros; i++)
    4542:	2a0b8363          	beqz	s7,47e8 <_vprintf_core.constprop.0.isra.0+0x78c>
    4546:	4c81                	li	s9,0
                _out_char(ctx, '0');
    4548:	03000593          	li	a1,48
    454c:	8526                	mv	a0,s1
            for (int i = 0; i < total_zeros; i++)
    454e:	2c85                	addiw	s9,s9,1
                _out_char(ctx, '0');
    4550:	c99fd0ef          	jal	21e8 <_out_char>
            for (int i = 0; i < total_zeros; i++)
    4554:	ff7c9ae3          	bne	s9,s7,4548 <_vprintf_core.constprop.0.isra.0+0x4ec>
            for (int i = digit_len - 1; i >= 0; i--)
    4558:	57fd                	li	a5,-1
    455a:	00fc0f63          	beq	s8,a5,4578 <_vprintf_core.constprop.0.isra.0+0x51c>
    455e:	01010c93          	addi	s9,sp,16
    4562:	9ce2                	add	s9,s9,s8
    4564:	00f10c13          	addi	s8,sp,15
                _out_char(ctx, num_buf[i]);
    4568:	000cc583          	lbu	a1,0(s9)
    456c:	8526                	mv	a0,s1
            for (int i = digit_len - 1; i >= 0; i--)
    456e:	1cfd                	addi	s9,s9,-1
                _out_char(ctx, num_buf[i]);
    4570:	c79fd0ef          	jal	21e8 <_out_char>
            for (int i = digit_len - 1; i >= 0; i--)
    4574:	ff9c1ae3          	bne	s8,s9,4568 <_vprintf_core.constprop.0.isra.0+0x50c>
            if (flag_left)
    4578:	0c0a1e63          	bnez	s4,4654 <_vprintf_core.constprop.0.isra.0+0x5f8>
        char spec = *p++;
    457c:	6c22                	ld	s8,8(sp)
    457e:	be31                	j	409a <_vprintf_core.constprop.0.isra.0+0x3e>
            int padding = (width > len) ? width - len : 0;
    4580:	4174043b          	subw	s0,s0,s7
            if (!flag_left)
    4584:	100a0a63          	beqz	s4,4698 <_vprintf_core.constprop.0.isra.0+0x63c>
            for (int i = 0; i < len; i++)
    4588:	d80b9ce3          	bnez	s7,4320 <_vprintf_core.constprop.0.isra.0+0x2c4>
                for (int i = 0; i < padding; i++)
    458c:	4a01                	li	s4,0
                    _out_char(ctx, ' ');
    458e:	02000593          	li	a1,32
    4592:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    4594:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    4596:	c53fd0ef          	jal	21e8 <_out_char>
                for (int i = 0; i < padding; i++)
    459a:	ff441ae3          	bne	s0,s4,458e <_vprintf_core.constprop.0.isra.0+0x532>
            const char *s = va_arg(ap, char *);
    459e:	0c21                	addi	s8,s8,8
    45a0:	bced                	j	409a <_vprintf_core.constprop.0.isra.0+0x3e>
                for (int i = 0; i < padding; i++)
    45a2:	f46d                	bnez	s0,458c <_vprintf_core.constprop.0.isra.0+0x530>
            const char *s = va_arg(ap, char *);
    45a4:	0c21                	addi	s8,s8,8
    45a6:	bcd5                	j	409a <_vprintf_core.constprop.0.isra.0+0x3e>
            else if (len_mod == 1)
    45a8:	1fce8163          	beq	t4,t3,478a <_vprintf_core.constprop.0.isra.0+0x72e>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    45ac:	000c2e03          	lw	t3,0(s8)
    45b0:	008c0793          	addi	a5,s8,8
    45b4:	e43e                	sd	a5,8(sp)
                int64 sval = (int64)val;
    45b6:	86f2                	mv	a3,t3
                if (sval < 0)
    45b8:	1406cb63          	bltz	a3,470e <_vprintf_core.constprop.0.isra.0+0x6b2>
                    sign_char = '+';
    45bc:	02b00793          	li	a5,43
    45c0:	e03e                	sd	a5,0(sp)
                else if (flag_plus)
    45c2:	e589                	bnez	a1,45cc <_vprintf_core.constprop.0.isra.0+0x570>
                else if (flag_space)
    45c4:	00589793          	slli	a5,a7,0x5
    45c8:	e03e                	sd	a5,0(sp)
    45ca:	85c6                	mv	a1,a7
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    45cc:	4329                	li	t1,10
    45ce:	00002f97          	auipc	t6,0x2
    45d2:	c42f8f93          	addi	t6,t6,-958 # 6210 <_GLOBAL__sub_I__ZSt3cin+0x220>
    if (val == 0)
    45d6:	ee0e11e3          	bnez	t3,44b8 <_vprintf_core.constprop.0.isra.0+0x45c>
        buf[i++] = '0';
    45da:	03000693          	li	a3,48
    45de:	00d10823          	sb	a3,16(sp)
        return i;
    45e2:	4f05                	li	t5,1
            if (precision >= 0)
    45e4:	f00bd1e3          	bgez	s7,44e6 <_vprintf_core.constprop.0.isra.0+0x48a>
            for (int i = digit_len - 1; i >= 0; i--)
    45e8:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    45ec:	07000893          	li	a7,112
            if (!flag_left && !flag_zero)
    45f0:	016a6d33          	or	s10,s4,s6
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    45f4:	4b81                	li	s7,0
            for (int i = digit_len - 1; i >= 0; i--)
    45f6:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    45f8:	0d1c9f63          	bne	s9,a7,46d6 <_vprintf_core.constprop.0.isra.0+0x67a>
                prefix_str = (spec == 'X') ? "0X" : "0x";
    45fc:	00002c97          	auipc	s9,0x2
    4600:	c2cc8c93          	addi	s9,s9,-980 # 6228 <_GLOBAL__sub_I__ZSt3cin+0x238>
                prefix_len += 2;
    4604:	2589                	addiw	a1,a1,2
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    4606:	017585bb          	addw	a1,a1,s7
    460a:	01e585bb          	addw	a1,a1,t5
    460e:	f085c2e3          	blt	a1,s0,4512 <_vprintf_core.constprop.0.isra.0+0x4b6>
            if (!flag_left && !flag_zero)
    4612:	080d0f63          	beqz	s10,46b0 <_vprintf_core.constprop.0.isra.0+0x654>
            if (sign_char)
    4616:	6782                	ld	a5,0(sp)
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    4618:	4401                	li	s0,0
            if (sign_char)
    461a:	f00782e3          	beqz	a5,451e <_vprintf_core.constprop.0.isra.0+0x4c2>
                _out_char(ctx, sign_char);
    461e:	6582                	ld	a1,0(sp)
    4620:	8526                	mv	a0,s1
    4622:	bc7fd0ef          	jal	21e8 <_out_char>
    4626:	bde5                	j	451e <_vprintf_core.constprop.0.isra.0+0x4c2>
                    _out_char(ctx, ' ');
    4628:	02000593          	li	a1,32
    462c:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    462e:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    4630:	bb9fd0ef          	jal	21e8 <_out_char>
                for (int i = 0; i < padding; i++)
    4634:	efa402e3          	beq	s0,s10,4518 <_vprintf_core.constprop.0.isra.0+0x4bc>
                    _out_char(ctx, ' ');
    4638:	02000593          	li	a1,32
    463c:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    463e:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    4640:	ba9fd0ef          	jal	21e8 <_out_char>
                for (int i = 0; i < padding; i++)
    4644:	ffa412e3          	bne	s0,s10,4628 <_vprintf_core.constprop.0.isra.0+0x5cc>
    4648:	bdc1                	j	4518 <_vprintf_core.constprop.0.isra.0+0x4bc>
            for (int i = 0; i < total_zeros; i++)
    464a:	ee0b9ee3          	bnez	s7,4546 <_vprintf_core.constprop.0.isra.0+0x4ea>
            for (int i = digit_len - 1; i >= 0; i--)
    464e:	577d                	li	a4,-1
    4650:	f0ec17e3          	bne	s8,a4,455e <_vprintf_core.constprop.0.isra.0+0x502>
                for (int i = 0; i < padding; i++)
    4654:	d405                	beqz	s0,457c <_vprintf_core.constprop.0.isra.0+0x520>
    4656:	4a01                	li	s4,0
                    _out_char(ctx, ' ');
    4658:	02000593          	li	a1,32
    465c:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    465e:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    4660:	b89fd0ef          	jal	21e8 <_out_char>
                for (int i = 0; i < padding; i++)
    4664:	fe8a1ae3          	bne	s4,s0,4658 <_vprintf_core.constprop.0.isra.0+0x5fc>
        char spec = *p++;
    4668:	6c22                	ld	s8,8(sp)
    466a:	bc05                	j	409a <_vprintf_core.constprop.0.isra.0+0x3e>
                val = (uint64)va_arg(ap, void *);
    466c:	008c0793          	addi	a5,s8,8
    4670:	e43e                	sd	a5,8(sp)
            else if (len_mod == 1)
    4672:	180e9163          	bnez	t4,47f4 <_vprintf_core.constprop.0.isra.0+0x798>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    4676:	000c6e03          	lwu	t3,0(s8)
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    467a:	4581                	li	a1,0
    467c:	05800c93          	li	s9,88
    4680:	e002                	sd	zero,0(sp)
    4682:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    4684:	00002f97          	auipc	t6,0x2
    4688:	b74f8f93          	addi	t6,t6,-1164 # 61f8 <_GLOBAL__sub_I__ZSt3cin+0x208>
    468c:	b525                	j	44b4 <_vprintf_core.constprop.0.isra.0+0x458>
            int padding = (width > len) ? width - len : 0;
    468e:	ca8058e3          	blez	s0,433e <_vprintf_core.constprop.0.isra.0+0x2e2>
            if (!flag_left)
    4692:	ee0a1de3          	bnez	s4,458c <_vprintf_core.constprop.0.isra.0+0x530>
            int len = 0;
    4696:	4b81                	li	s7,0
                for (int i = 0; i < padding; i++)
    4698:	4d01                	li	s10,0
                    _out_char(ctx, ' ');
    469a:	02000593          	li	a1,32
    469e:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    46a0:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    46a2:	b47fd0ef          	jal	21e8 <_out_char>
                for (int i = 0; i < padding; i++)
    46a6:	fe8d1ae3          	bne	s10,s0,469a <_vprintf_core.constprop.0.isra.0+0x63e>
            for (int i = 0; i < len; i++)
    46aa:	c60b9be3          	bnez	s7,4320 <_vprintf_core.constprop.0.isra.0+0x2c4>
    46ae:	b941                	j	433e <_vprintf_core.constprop.0.isra.0+0x2e2>
            if (sign_char)
    46b0:	6782                	ld	a5,0(sp)
    46b2:	4401                	li	s0,0
    46b4:	f7ad                	bnez	a5,461e <_vprintf_core.constprop.0.isra.0+0x5c2>
            if (prefix_str)
    46b6:	e60c96e3          	bnez	s9,4522 <_vprintf_core.constprop.0.isra.0+0x4c6>
            for (int i = 0; i < total_zeros; i++)
    46ba:	e80b96e3          	bnez	s7,4546 <_vprintf_core.constprop.0.isra.0+0x4ea>
    46be:	bd69                	j	4558 <_vprintf_core.constprop.0.isra.0+0x4fc>
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    46c0:	41eb8bbb          	subw	s7,s7,t5
    46c4:	8d52                	mv	s10,s4
    46c6:	4b01                	li	s6,0
            for (int i = digit_len - 1; i >= 0; i--)
    46c8:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    46cc:	07000893          	li	a7,112
            for (int i = digit_len - 1; i >= 0; i--)
    46d0:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    46d2:	f31c85e3          	beq	s9,a7,45fc <_vprintf_core.constprop.0.isra.0+0x5a0>
    46d6:	cd09                	beqz	a0,46f0 <_vprintf_core.constprop.0.isra.0+0x694>
    46d8:	000e0c63          	beqz	t3,46f0 <_vprintf_core.constprop.0.isra.0+0x694>
    46dc:	07800513          	li	a0,120
            for (int i = digit_len - 1; i >= 0; i--)
    46e0:	00060c1b          	sext.w	s8,a2
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    46e4:	f0ac8ce3          	beq	s9,a0,45fc <_vprintf_core.constprop.0.isra.0+0x5a0>
    46e8:	05800613          	li	a2,88
    46ec:	12cc8463          	beq	s9,a2,4814 <_vprintf_core.constprop.0.isra.0+0x7b8>
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    46f0:	00bb85bb          	addw	a1,s7,a1
    46f4:	01e585bb          	addw	a1,a1,t5
            char *prefix_str = NULL;
    46f8:	4c81                	li	s9,0
    46fa:	bd11                	j	450e <_vprintf_core.constprop.0.isra.0+0x4b2>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    46fc:	07000693          	li	a3,112
    4700:	8d52                	mv	s10,s4
    4702:	4b01                	li	s6,0
    4704:	08dc8d63          	beq	s9,a3,479e <_vprintf_core.constprop.0.isra.0+0x742>
    4708:	5c7d                	li	s8,-1
            char *prefix_str = NULL;
    470a:	4c81                	li	s9,0
    470c:	b509                	j	450e <_vprintf_core.constprop.0.isra.0+0x4b2>
                    sign_char = '-';
    470e:	02d00793          	li	a5,45
                    val = (uint64)(-sval);
    4712:	40d00e33          	neg	t3,a3
    4716:	4585                	li	a1,1
    4718:	4329                	li	t1,10
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    471a:	00002f97          	auipc	t6,0x2
    471e:	af6f8f93          	addi	t6,t6,-1290 # 6210 <_GLOBAL__sub_I__ZSt3cin+0x220>
                    sign_char = '-';
    4722:	e03e                	sd	a5,0(sp)
    4724:	bb51                	j	44b8 <_vprintf_core.constprop.0.isra.0+0x45c>
                s = "(null)";
    4726:	00002c97          	auipc	s9,0x2
    472a:	b12c8c93          	addi	s9,s9,-1262 # 6238 <_GLOBAL__sub_I__ZSt3cin+0x248>
    472e:	bed1                	j	4302 <_vprintf_core.constprop.0.isra.0+0x2a6>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    4730:	000c3683          	ld	a3,0(s8)
    4734:	008c0713          	addi	a4,s8,8
    4738:	e43a                	sd	a4,8(sp)
    473a:	8dbe                	mv	s11,a5
    473c:	8e36                	mv	t3,a3
            if (is_signed)
    473e:	bdad                	j	45b8 <_vprintf_core.constprop.0.isra.0+0x55c>
            int is_signed = (spec == 'd' || spec == 'i');
    4740:	06900693          	li	a3,105
    4744:	fedc86e3          	beq	s9,a3,4730 <_vprintf_core.constprop.0.isra.0+0x6d4>
                val = (uint64)va_arg(ap, void *);
    4748:	008c0713          	addi	a4,s8,8
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    474c:	07800693          	li	a3,120
                val = (uint64)va_arg(ap, void *);
    4750:	e43a                	sd	a4,8(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    4752:	06dc9063          	bne	s9,a3,47b2 <_vprintf_core.constprop.0.isra.0+0x756>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    4756:	000c3e03          	ld	t3,0(s8)
    475a:	8dbe                	mv	s11,a5
    475c:	4581                	li	a1,0
    475e:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    4760:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    4762:	00002f97          	auipc	t6,0x2
    4766:	aaef8f93          	addi	t6,t6,-1362 # 6210 <_GLOBAL__sub_I__ZSt3cin+0x220>
    476a:	b3a9                	j	44b4 <_vprintf_core.constprop.0.isra.0+0x458>
                for (int i = 0; i < padding; i++)
    476c:	c809                	beqz	s0,477e <_vprintf_core.constprop.0.isra.0+0x722>
                    _out_char(ctx, ' ');
    476e:	02000593          	li	a1,32
    4772:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    4774:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    4776:	a73fd0ef          	jal	21e8 <_out_char>
                for (int i = 0; i < padding; i++)
    477a:	ff441ae3          	bne	s0,s4,476e <_vprintf_core.constprop.0.isra.0+0x712>
            _out_char(ctx, c);
    477e:	85e6                	mv	a1,s9
    4780:	8526                	mv	a0,s1
    4782:	a67fd0ef          	jal	21e8 <_out_char>
            const char *s = va_arg(ap, char *);
    4786:	0c21                	addi	s8,s8,8
    4788:	ba09                	j	409a <_vprintf_core.constprop.0.isra.0+0x3e>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    478a:	000c3683          	ld	a3,0(s8)
    478e:	008c0793          	addi	a5,s8,8
    4792:	e43e                	sd	a5,8(sp)
    4794:	8e36                	mv	t3,a3
            if (is_signed)
    4796:	b50d                	j	45b8 <_vprintf_core.constprop.0.isra.0+0x55c>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    4798:	8d52                	mv	s10,s4
    479a:	4b01                	li	s6,0
    479c:	b585                	j	45fc <_vprintf_core.constprop.0.isra.0+0x5a0>
                digit_len = 0;
    479e:	4f01                	li	t5,0
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    47a0:	5c7d                	li	s8,-1
                prefix_str = (spec == 'X') ? "0X" : "0x";
    47a2:	00002c97          	auipc	s9,0x2
    47a6:	a86c8c93          	addi	s9,s9,-1402 # 6228 <_GLOBAL__sub_I__ZSt3cin+0x238>
    47aa:	bda9                	j	4604 <_vprintf_core.constprop.0.isra.0+0x5a8>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    47ac:	8d52                	mv	s10,s4
    47ae:	4b01                	li	s6,0
    47b0:	b735                	j	46dc <_vprintf_core.constprop.0.isra.0+0x680>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    47b2:	07000693          	li	a3,112
    47b6:	04dc8263          	beq	s9,a3,47fa <_vprintf_core.constprop.0.isra.0+0x79e>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    47ba:	000c3e03          	ld	t3,0(s8)
    47be:	8dbe                	mv	s11,a5
    47c0:	4581                	li	a1,0
    47c2:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    47c4:	4329                	li	t1,10
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    47c6:	00002f97          	auipc	t6,0x2
    47ca:	a4af8f93          	addi	t6,t6,-1462 # 6210 <_GLOBAL__sub_I__ZSt3cin+0x220>
    47ce:	b1dd                	j	44b4 <_vprintf_core.constprop.0.isra.0+0x458>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    47d0:	000c3e03          	ld	t3,0(s8)
    47d4:	4581                	li	a1,0
    47d6:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    47d8:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    47da:	00002f97          	auipc	t6,0x2
    47de:	a36f8f93          	addi	t6,t6,-1482 # 6210 <_GLOBAL__sub_I__ZSt3cin+0x220>
    47e2:	b9c9                	j	44b4 <_vprintf_core.constprop.0.isra.0+0x458>
        char spec = *p++;
    47e4:	8dbe                	mv	s11,a5
    47e6:	b911                	j	43fa <_vprintf_core.constprop.0.isra.0+0x39e>
            for (int i = digit_len - 1; i >= 0; i--)
    47e8:	577d                	li	a4,-1
    47ea:	4401                	li	s0,0
    47ec:	d6ec19e3          	bne	s8,a4,455e <_vprintf_core.constprop.0.isra.0+0x502>
        char spec = *p++;
    47f0:	6c22                	ld	s8,8(sp)
    47f2:	b065                	j	409a <_vprintf_core.constprop.0.isra.0+0x3e>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    47f4:	000c3e03          	ld	t3,0(s8)
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    47f8:	b549                	j	467a <_vprintf_core.constprop.0.isra.0+0x61e>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    47fa:	8dbe                	mv	s11,a5
                val = (uint64)va_arg(ap, void *);
    47fc:	000c3e03          	ld	t3,0(s8)
    4800:	4581                	li	a1,0
    4802:	07000c93          	li	s9,112
    4806:	e002                	sd	zero,0(sp)
    4808:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    480a:	00002f97          	auipc	t6,0x2
    480e:	a06f8f93          	addi	t6,t6,-1530 # 6210 <_GLOBAL__sub_I__ZSt3cin+0x220>
    4812:	b14d                	j	44b4 <_vprintf_core.constprop.0.isra.0+0x458>
                prefix_str = (spec == 'X') ? "0X" : "0x";
    4814:	00002c97          	auipc	s9,0x2
    4818:	a1cc8c93          	addi	s9,s9,-1508 # 6230 <_GLOBAL__sub_I__ZSt3cin+0x240>
    481c:	b3e5                	j	4604 <_vprintf_core.constprop.0.isra.0+0x5a8>
                val = (uint64)va_arg(ap, void *);
    481e:	008c0713          	addi	a4,s8,8
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    4822:	000c3e03          	ld	t3,0(s8)
                val = (uint64)va_arg(ap, void *);
    4826:	e43a                	sd	a4,8(sp)
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    4828:	8dbe                	mv	s11,a5
    482a:	bd81                	j	467a <_vprintf_core.constprop.0.isra.0+0x61e>
    482c:	8d52                	mv	s10,s4
    482e:	4b01                	li	s6,0
    4830:	4b81                	li	s7,0
    4832:	bd59                	j	46c8 <_vprintf_core.constprop.0.isra.0+0x66c>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    4834:	07000693          	li	a3,112
    4838:	fcdc82e3          	beq	s9,a3,47fc <_vprintf_core.constprop.0.isra.0+0x7a0>
            else if (len_mod == 1)
    483c:	01ce8c63          	beq	t4,t3,4854 <_vprintf_core.constprop.0.isra.0+0x7f8>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    4840:	000c6e03          	lwu	t3,0(s8)
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    4844:	4581                	li	a1,0
    4846:	e002                	sd	zero,0(sp)
    4848:	4329                	li	t1,10
    484a:	00002f97          	auipc	t6,0x2
    484e:	9c6f8f93          	addi	t6,t6,-1594 # 6210 <_GLOBAL__sub_I__ZSt3cin+0x220>
    4852:	b18d                	j	44b4 <_vprintf_core.constprop.0.isra.0+0x458>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    4854:	000c3e03          	ld	t3,0(s8)
            if (is_signed)
    4858:	b7f5                	j	4844 <_vprintf_core.constprop.0.isra.0+0x7e8>

000000000000485a <vsnprintf>:
{
    485a:	7139                	addi	sp,sp,-64
    485c:	f822                	sd	s0,48(sp)
    485e:	f426                	sd	s1,40(sp)
    4860:	842e                	mv	s0,a1
    4862:	84aa                	mv	s1,a0
    4864:	85b2                	mv	a1,a2
    _vprintf_core(&ctx, format, ap);
    4866:	850a                	mv	a0,sp
    4868:	8636                	mv	a2,a3
{
    486a:	fc06                	sd	ra,56(sp)
    ctx.buf = str;
    486c:	e026                	sd	s1,0(sp)
    ctx.limit = size;
    486e:	e422                	sd	s0,8(sp)
    ctx.written = 0;
    4870:	e802                	sd	zero,16(sp)
    ctx.stream = NULL;
    4872:	ec02                	sd	zero,24(sp)
    _vprintf_core(&ctx, format, ap);
    4874:	fe8ff0ef          	jal	405c <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    4878:	6542                	ld	a0,16(sp)
    if (size > 0)
    487a:	c411                	beqz	s0,4886 <vsnprintf+0x2c>
        if (ctx.written < size)
    487c:	00857b63          	bgeu	a0,s0,4892 <vsnprintf+0x38>
            str[ctx.written] = '\0';
    4880:	94aa                	add	s1,s1,a0
    4882:	00048023          	sb	zero,0(s1)
}
    4886:	70e2                	ld	ra,56(sp)
    4888:	7442                	ld	s0,48(sp)
    488a:	74a2                	ld	s1,40(sp)
    488c:	2501                	sext.w	a0,a0
    488e:	6121                	addi	sp,sp,64
    4890:	8082                	ret
            str[size - 1] = '\0';
    4892:	94a2                	add	s1,s1,s0
    4894:	fe048fa3          	sb	zero,-1(s1)
}
    4898:	70e2                	ld	ra,56(sp)
    489a:	7442                	ld	s0,48(sp)
    489c:	74a2                	ld	s1,40(sp)
    489e:	2501                	sext.w	a0,a0
    48a0:	6121                	addi	sp,sp,64
    48a2:	8082                	ret

00000000000048a4 <snprintf>:
{
    48a4:	7119                	addi	sp,sp,-128
    48a6:	e0a2                	sd	s0,64(sp)
    48a8:	fc26                	sd	s1,56(sp)
    48aa:	842e                	mv	s0,a1
    48ac:	84aa                	mv	s1,a0
    48ae:	85b2                	mv	a1,a2
    _vprintf_core(&ctx, format, ap);
    48b0:	0808                	addi	a0,sp,16
    va_start(ap, format);
    48b2:	08b0                	addi	a2,sp,88
{
    48b4:	e486                	sd	ra,72(sp)
    48b6:	ecb6                	sd	a3,88(sp)
    48b8:	f0ba                	sd	a4,96(sp)
    48ba:	f4be                	sd	a5,104(sp)
    48bc:	f8c2                	sd	a6,112(sp)
    48be:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    48c0:	e432                	sd	a2,8(sp)
    ctx.buf = str;
    48c2:	e826                	sd	s1,16(sp)
    ctx.limit = size;
    48c4:	ec22                	sd	s0,24(sp)
    ctx.written = 0;
    48c6:	f002                	sd	zero,32(sp)
    ctx.stream = NULL;
    48c8:	f402                	sd	zero,40(sp)
    _vprintf_core(&ctx, format, ap);
    48ca:	f92ff0ef          	jal	405c <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    48ce:	7502                	ld	a0,32(sp)
    if (size > 0)
    48d0:	c411                	beqz	s0,48dc <snprintf+0x38>
        if (ctx.written < size)
    48d2:	00857b63          	bgeu	a0,s0,48e8 <snprintf+0x44>
            str[ctx.written] = '\0';
    48d6:	94aa                	add	s1,s1,a0
    48d8:	00048023          	sb	zero,0(s1)
}
    48dc:	60a6                	ld	ra,72(sp)
    48de:	6406                	ld	s0,64(sp)
    48e0:	74e2                	ld	s1,56(sp)
    48e2:	2501                	sext.w	a0,a0
    48e4:	6109                	addi	sp,sp,128
    48e6:	8082                	ret
            str[size - 1] = '\0';
    48e8:	94a2                	add	s1,s1,s0
    48ea:	fe048fa3          	sb	zero,-1(s1)
}
    48ee:	60a6                	ld	ra,72(sp)
    48f0:	6406                	ld	s0,64(sp)
    48f2:	74e2                	ld	s1,56(sp)
    48f4:	2501                	sext.w	a0,a0
    48f6:	6109                	addi	sp,sp,128
    48f8:	8082                	ret

00000000000048fa <printf>:
{
    48fa:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    48fc:	04810313          	addi	t1,sp,72
{
    4900:	e4ae                	sd	a1,72(sp)
    4902:	e8b2                	sd	a2,80(sp)
    4904:	f4be                	sd	a5,104(sp)
    _vprintf_core(&ctx, format, ap);
    4906:	85aa                	mv	a1,a0
    ctx.stream = stdout;
    4908:	00004797          	auipc	a5,0x4
    490c:	3707b783          	ld	a5,880(a5) # 8c78 <stdout>
    _vprintf_core(&ctx, format, ap);
    4910:	0808                	addi	a0,sp,16
    4912:	861a                	mv	a2,t1
{
    4914:	fc06                	sd	ra,56(sp)
    4916:	ecb6                	sd	a3,88(sp)
    4918:	f0ba                	sd	a4,96(sp)
    491a:	f8c2                	sd	a6,112(sp)
    491c:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    491e:	e41a                	sd	t1,8(sp)
    ctx.buf = NULL;
    4920:	e802                	sd	zero,16(sp)
    ctx.limit = 0;
    4922:	ec02                	sd	zero,24(sp)
    ctx.written = 0;
    4924:	f002                	sd	zero,32(sp)
    ctx.stream = stdout;
    4926:	f43e                	sd	a5,40(sp)
    _vprintf_core(&ctx, format, ap);
    4928:	f34ff0ef          	jal	405c <_vprintf_core.constprop.0.isra.0>
}
    492c:	70e2                	ld	ra,56(sp)
    492e:	5502                	lw	a0,32(sp)
    4930:	6109                	addi	sp,sp,128
    4932:	8082                	ret

0000000000004934 <sscanf>:
{
    4934:	7159                	addi	sp,sp,-112
    va_start(ap, format);
    4936:	04010e13          	addi	t3,sp,64
{
    493a:	8eaa                	mv	t4,a0
    ctx.fd = -1;
    493c:	537d                	li	t1,-1
{
    493e:	e0b2                	sd	a2,64(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    4940:	0808                	addi	a0,sp,16
    4942:	8672                	mv	a2,t3
{
    4944:	fc06                	sd	ra,56(sp)
    4946:	e4b6                	sd	a3,72(sp)
    4948:	e8ba                	sd	a4,80(sp)
    494a:	ecbe                	sd	a5,88(sp)
    494c:	f0c2                	sd	a6,96(sp)
    494e:	f4c6                	sd	a7,104(sp)
    va_start(ap, format);
    4950:	e472                	sd	t3,8(sp)
    ctx.buf = str;
    4952:	e876                	sd	t4,16(sp)
    ctx.fd = -1;
    4954:	cc1a                	sw	t1,24(sp)
    ctx.pos = 0;
    4956:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    4958:	d41a                	sw	t1,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    495a:	81efd0ef          	jal	1978 <_vscanf_core.constprop.0>
}
    495e:	70e2                	ld	ra,56(sp)
    4960:	6165                	addi	sp,sp,112
    4962:	8082                	ret

0000000000004964 <scanf>:
{
    4964:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    4966:	04810313          	addi	t1,sp,72
{
    496a:	e4ae                	sd	a1,72(sp)
    496c:	e8b2                	sd	a2,80(sp)
    496e:	f4be                	sd	a5,104(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    4970:	85aa                	mv	a1,a0
    ctx.ungotten = -1;
    4972:	57fd                	li	a5,-1
    int ret = _vscanf_core(&ctx, format, ap);
    4974:	0808                	addi	a0,sp,16
    4976:	861a                	mv	a2,t1
{
    4978:	fc06                	sd	ra,56(sp)
    497a:	ecb6                	sd	a3,88(sp)
    497c:	f0ba                	sd	a4,96(sp)
    497e:	f8c2                	sd	a6,112(sp)
    4980:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    4982:	e41a                	sd	t1,8(sp)
    ctx.buf = NULL;
    4984:	e802                	sd	zero,16(sp)
    ctx.fd = STDIN_FD;
    4986:	cc02                	sw	zero,24(sp)
    ctx.pos = 0;
    4988:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    498a:	d43e                	sw	a5,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    498c:	fedfc0ef          	jal	1978 <_vscanf_core.constprop.0>
}
    4990:	70e2                	ld	ra,56(sp)
    4992:	6109                	addi	sp,sp,128
    4994:	8082                	ret

0000000000004996 <fopen>:
{
    4996:	1101                	addi	sp,sp,-32
    4998:	e426                	sd	s1,8(sp)
    499a:	84ae                	mv	s1,a1
    499c:	e04a                	sd	s2,0(sp)
    if (strcmp(mode, "r") == 0)
    499e:	00002597          	auipc	a1,0x2
    49a2:	8b258593          	addi	a1,a1,-1870 # 6250 <_GLOBAL__sub_I__ZSt3cin+0x260>
{
    49a6:	892a                	mv	s2,a0
    if (strcmp(mode, "r") == 0)
    49a8:	8526                	mv	a0,s1
{
    49aa:	e822                	sd	s0,16(sp)
    49ac:	ec06                	sd	ra,24(sp)
    if (strcmp(mode, "r") == 0)
    49ae:	298010ef          	jal	5c46 <strcmp>
    49b2:	842a                	mv	s0,a0
    49b4:	c919                	beqz	a0,49ca <fopen+0x34>
    else if (strcmp(mode, "w") == 0)
    49b6:	00002597          	auipc	a1,0x2
    49ba:	8a258593          	addi	a1,a1,-1886 # 6258 <_GLOBAL__sub_I__ZSt3cin+0x268>
    49be:	8526                	mv	a0,s1
    49c0:	286010ef          	jal	5c46 <strcmp>
        flags = O_WRONLY | O_CREAT | O_TRUNC;
    49c4:	24100413          	li	s0,577
    else if (strcmp(mode, "w") == 0)
    49c8:	ed39                	bnez	a0,4a26 <fopen+0x90>
    int64 fd = open(filename, flags);
    49ca:	85a2                	mv	a1,s0
    49cc:	854a                	mv	a0,s2
    49ce:	f42fc0ef          	jal	1110 <open>
    49d2:	84aa                	mv	s1,a0
    if (fd < 0)
    49d4:	06054c63          	bltz	a0,4a4c <fopen+0xb6>
    FILE *f = (FILE *)malloc(sizeof(FILE));
    49d8:	42000513          	li	a0,1056
    49dc:	2f3000ef          	jal	54ce <malloc>
    49e0:	892a                	mv	s2,a0
    if (!f)
    49e2:	c53d                	beqz	a0,4a50 <fopen+0xba>
    memset(f, 0, sizeof(FILE));
    49e4:	42000613          	li	a2,1056
    49e8:	4581                	li	a1,0
    49ea:	0ee010ef          	jal	5ad8 <memset>
    if (fd == 1)
    49ee:	4785                	li	a5,1
    f->fd = (int)fd;
    49f0:	00992023          	sw	s1,0(s2)
    f->flags = flags;
    49f4:	00892223          	sw	s0,4(s2)
    if (fd == 1)
    49f8:	00f48e63          	beq	s1,a5,4a14 <fopen+0x7e>
    else if (fd == 2)
    49fc:	4789                	li	a5,2
    49fe:	00f48b63          	beq	s1,a5,4a14 <fopen+0x7e>
        f->buf_mode = 0;
    4a02:	40092e23          	sw	zero,1052(s2)
}
    4a06:	60e2                	ld	ra,24(sp)
    4a08:	6442                	ld	s0,16(sp)
    4a0a:	64a2                	ld	s1,8(sp)
    4a0c:	854a                	mv	a0,s2
    4a0e:	6902                	ld	s2,0(sp)
    4a10:	6105                	addi	sp,sp,32
    4a12:	8082                	ret
    4a14:	60e2                	ld	ra,24(sp)
    4a16:	6442                	ld	s0,16(sp)
        f->buf_mode = 2;
    4a18:	40992e23          	sw	s1,1052(s2)
}
    4a1c:	854a                	mv	a0,s2
    4a1e:	64a2                	ld	s1,8(sp)
    4a20:	6902                	ld	s2,0(sp)
    4a22:	6105                	addi	sp,sp,32
    4a24:	8082                	ret
    else if (strcmp(mode, "a") == 0)
    4a26:	00002597          	auipc	a1,0x2
    4a2a:	83a58593          	addi	a1,a1,-1990 # 6260 <_GLOBAL__sub_I__ZSt3cin+0x270>
    4a2e:	8526                	mv	a0,s1
    4a30:	216010ef          	jal	5c46 <strcmp>
        flags = O_WRONLY | O_CREAT | O_APPEND;
    4a34:	44100413          	li	s0,1089
    else if (strcmp(mode, "a") == 0)
    4a38:	d949                	beqz	a0,49ca <fopen+0x34>
    else if (strcmp(mode, "r+") == 0)
    4a3a:	00002597          	auipc	a1,0x2
    4a3e:	82e58593          	addi	a1,a1,-2002 # 6268 <_GLOBAL__sub_I__ZSt3cin+0x278>
    4a42:	8526                	mv	a0,s1
    4a44:	202010ef          	jal	5c46 <strcmp>
        flags = O_RDWR;
    4a48:	4409                	li	s0,2
    else if (strcmp(mode, "r+") == 0)
    4a4a:	d141                	beqz	a0,49ca <fopen+0x34>
        return NULL;
    4a4c:	4901                	li	s2,0
    4a4e:	bf65                	j	4a06 <fopen+0x70>
        close(fd);
    4a50:	8526                	mv	a0,s1
    4a52:	ea6fc0ef          	jal	10f8 <close>
        return NULL;
    4a56:	4901                	li	s2,0
    4a58:	b77d                	j	4a06 <fopen+0x70>

0000000000004a5a <fclose>:
    if (!stream)
    4a5a:	cd29                	beqz	a0,4ab4 <fclose+0x5a>
    if (stream->buf_write_pos > 0)
    4a5c:	41052603          	lw	a2,1040(a0)
{
    4a60:	1141                	addi	sp,sp,-16
    4a62:	e022                	sd	s0,0(sp)
    4a64:	e406                	sd	ra,8(sp)
    4a66:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    4a68:	02c04a63          	bgtz	a2,4a9c <fclose+0x42>
    if (stream != stdin && stream != stdout && stream != stderr)
    4a6c:	00004797          	auipc	a5,0x4
    4a70:	20c78793          	addi	a5,a5,524 # 8c78 <stdout>
    4a74:	6798                	ld	a4,8(a5)
    4a76:	00870e63          	beq	a4,s0,4a92 <fclose+0x38>
    4a7a:	6398                	ld	a4,0(a5)
    4a7c:	00870b63          	beq	a4,s0,4a92 <fclose+0x38>
    4a80:	6b9c                	ld	a5,16(a5)
    4a82:	00878863          	beq	a5,s0,4a92 <fclose+0x38>
        close(stream->fd);
    4a86:	4008                	lw	a0,0(s0)
    4a88:	e70fc0ef          	jal	10f8 <close>
        free(stream);
    4a8c:	8522                	mv	a0,s0
    4a8e:	1cb000ef          	jal	5458 <free>
}
    4a92:	60a2                	ld	ra,8(sp)
    4a94:	6402                	ld	s0,0(sp)
    return 0;
    4a96:	4501                	li	a0,0
}
    4a98:	0141                	addi	sp,sp,16
    4a9a:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4a9c:	4108                	lw	a0,0(a0)
    4a9e:	01040593          	addi	a1,s0,16
    4aa2:	e4efc0ef          	jal	10f0 <write>
        if (ret < stream->buf_write_pos)
    4aa6:	41042783          	lw	a5,1040(s0)
    4aaa:	00f54763          	blt	a0,a5,4ab8 <fclose+0x5e>
        stream->buf_write_pos = 0;
    4aae:	40042823          	sw	zero,1040(s0)
    4ab2:	bf6d                	j	4a6c <fclose+0x12>
        return -1;
    4ab4:	557d                	li	a0,-1
}
    4ab6:	8082                	ret
            stream->error = 1;
    4ab8:	4785                	li	a5,1
    4aba:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4abc:	40042823          	sw	zero,1040(s0)
            return EOF;
    4ac0:	b775                	j	4a6c <fclose+0x12>

0000000000004ac2 <fflush>:
    if (!stream)
    4ac2:	c121                	beqz	a0,4b02 <fflush+0x40>
    if (stream->buf_write_pos > 0)
    4ac4:	41052603          	lw	a2,1040(a0)
{
    4ac8:	1141                	addi	sp,sp,-16
    4aca:	e022                	sd	s0,0(sp)
    4acc:	e406                	sd	ra,8(sp)
    4ace:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    4ad0:	00c04763          	bgtz	a2,4ade <fflush+0x1c>
    return 0;
    4ad4:	4501                	li	a0,0
}
    4ad6:	60a2                	ld	ra,8(sp)
    4ad8:	6402                	ld	s0,0(sp)
    4ada:	0141                	addi	sp,sp,16
    4adc:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4ade:	4108                	lw	a0,0(a0)
    4ae0:	01040593          	addi	a1,s0,16
    4ae4:	e0cfc0ef          	jal	10f0 <write>
        if (ret < stream->buf_write_pos)
    4ae8:	41042783          	lw	a5,1040(s0)
    4aec:	00f54563          	blt	a0,a5,4af6 <fflush+0x34>
        stream->buf_write_pos = 0;
    4af0:	40042823          	sw	zero,1040(s0)
    4af4:	b7c5                	j	4ad4 <fflush+0x12>
            stream->error = 1;
    4af6:	4785                	li	a5,1
    4af8:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4afa:	40042823          	sw	zero,1040(s0)
        return EOF;
    4afe:	557d                	li	a0,-1
    4b00:	bfd9                	j	4ad6 <fflush+0x14>
    4b02:	557d                	li	a0,-1
}
    4b04:	8082                	ret

0000000000004b06 <fprintf>:
{
    4b06:	7159                	addi	sp,sp,-112
    4b08:	fc06                	sd	ra,56(sp)
    4b0a:	e0b2                	sd	a2,64(sp)
    4b0c:	e4b6                	sd	a3,72(sp)
    4b0e:	e8ba                	sd	a4,80(sp)
    4b10:	ecbe                	sd	a5,88(sp)
    4b12:	f0c2                	sd	a6,96(sp)
    4b14:	f4c6                	sd	a7,104(sp)
    if (!stream)
    4b16:	cd19                	beqz	a0,4b34 <fprintf+0x2e>
    va_start(ap, format);
    4b18:	832a                	mv	t1,a0
    4b1a:	0090                	addi	a2,sp,64
    _vprintf_core(&ctx, format, ap);
    4b1c:	0808                	addi	a0,sp,16
    va_start(ap, format);
    4b1e:	e432                	sd	a2,8(sp)
    ctx.buf = NULL;
    4b20:	e802                	sd	zero,16(sp)
    ctx.limit = 0;
    4b22:	ec02                	sd	zero,24(sp)
    ctx.written = 0;
    4b24:	f002                	sd	zero,32(sp)
    ctx.stream  = stream;
    4b26:	f41a                	sd	t1,40(sp)
    _vprintf_core(&ctx, format, ap);
    4b28:	d34ff0ef          	jal	405c <_vprintf_core.constprop.0.isra.0>
    return (int)ctx.written;
    4b2c:	5502                	lw	a0,32(sp)
}
    4b2e:	70e2                	ld	ra,56(sp)
    4b30:	6165                	addi	sp,sp,112
    4b32:	8082                	ret
        return -1;
    4b34:	557d                	li	a0,-1
    4b36:	bfe5                	j	4b2e <fprintf+0x28>

0000000000004b38 <fscanf>:
{
    4b38:	7159                	addi	sp,sp,-112
    4b3a:	fc06                	sd	ra,56(sp)
    4b3c:	e0b2                	sd	a2,64(sp)
    4b3e:	e4b6                	sd	a3,72(sp)
    4b40:	e8ba                	sd	a4,80(sp)
    4b42:	ecbe                	sd	a5,88(sp)
    4b44:	f0c2                	sd	a6,96(sp)
    4b46:	f4c6                	sd	a7,104(sp)
    if (!stream)
    4b48:	cd19                	beqz	a0,4b66 <fscanf+0x2e>
    ctx.fd = stream->fd;
    4b4a:	411c                	lw	a5,0(a0)
    va_start(ap, format);
    4b4c:	0090                	addi	a2,sp,64
    int ret = _vscanf_core(&ctx, format, ap);
    4b4e:	0808                	addi	a0,sp,16
    ctx.fd = stream->fd;
    4b50:	cc3e                	sw	a5,24(sp)
    ctx.ungotten = -1;
    4b52:	57fd                	li	a5,-1
    va_start(ap, format);
    4b54:	e432                	sd	a2,8(sp)
    ctx.buf = NULL;
    4b56:	e802                	sd	zero,16(sp)
    ctx.pos = 0;
    4b58:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    4b5a:	d43e                	sw	a5,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    4b5c:	e1dfc0ef          	jal	1978 <_vscanf_core.constprop.0>
}
    4b60:	70e2                	ld	ra,56(sp)
    4b62:	6165                	addi	sp,sp,112
    4b64:	8082                	ret
        return -1;
    4b66:	557d                	li	a0,-1
    4b68:	bfe5                	j	4b60 <fscanf+0x28>

0000000000004b6a <fputc>:
    if (!stream)
    4b6a:	c1e1                	beqz	a1,4c2a <fputc+0xc0>
{
    4b6c:	7179                	addi	sp,sp,-48
    4b6e:	e84a                	sd	s2,16(sp)
    if (stream->buf_mode == 2)
    4b70:	41c5a903          	lw	s2,1052(a1)
{
    4b74:	f022                	sd	s0,32(sp)
    4b76:	ec26                	sd	s1,24(sp)
    4b78:	f406                	sd	ra,40(sp)
    if (stream->buf_mode == 2)
    4b7a:	4789                	li	a5,2
    4b7c:	842e                	mv	s0,a1
    4b7e:	84aa                	mv	s1,a0
        char ch = (char)c;
    4b80:	0ff57713          	zext.b	a4,a0
    if (stream->buf_mode == 2)
    4b84:	02f90963          	beq	s2,a5,4bb6 <fputc+0x4c>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    4b88:	4105a783          	lw	a5,1040(a1)
    if (stream->buf_write_pos >= BUFSIZ)
    4b8c:	3ff00693          	li	a3,1023
    stream->buffer[stream->buf_write_pos++] = (char)c;
    4b90:	0017861b          	addiw	a2,a5,1
    4b94:	40c5a823          	sw	a2,1040(a1)
    4b98:	97ae                	add	a5,a5,a1
    4b9a:	00e78823          	sb	a4,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    4b9e:	06c6c463          	blt	a3,a2,4c06 <fputc+0x9c>
    else if (stream->buf_mode == 1 && c == '\n')
    4ba2:	4785                	li	a5,1
    4ba4:	02f90e63          	beq	s2,a5,4be0 <fputc+0x76>
    return c;
    4ba8:	8526                	mv	a0,s1
}
    4baa:	70a2                	ld	ra,40(sp)
    4bac:	7402                	ld	s0,32(sp)
    4bae:	64e2                	ld	s1,24(sp)
    4bb0:	6942                	ld	s2,16(sp)
    4bb2:	6145                	addi	sp,sp,48
    4bb4:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    4bb6:	4188                	lw	a0,0(a1)
    4bb8:	4605                	li	a2,1
    4bba:	00f10593          	addi	a1,sp,15
        char ch = (char)c;
    4bbe:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    4bc2:	d2efc0ef          	jal	10f0 <write>
    4bc6:	872a                	mv	a4,a0
    4bc8:	4785                	li	a5,1
        return c;
    4bca:	8526                	mv	a0,s1
        if (write(stream->fd, &ch, 1) != 1)
    4bcc:	fcf70fe3          	beq	a4,a5,4baa <fputc+0x40>
}
    4bd0:	70a2                	ld	ra,40(sp)
            stream->error = 1;
    4bd2:	c41c                	sw	a5,8(s0)
}
    4bd4:	7402                	ld	s0,32(sp)
    4bd6:	64e2                	ld	s1,24(sp)
    4bd8:	6942                	ld	s2,16(sp)
            return EOF;
    4bda:	557d                	li	a0,-1
}
    4bdc:	6145                	addi	sp,sp,48
    4bde:	8082                	ret
    else if (stream->buf_mode == 1 && c == '\n')
    4be0:	47a9                	li	a5,10
    4be2:	fcf513e3          	bne	a0,a5,4ba8 <fputc+0x3e>
    if (stream->buf_write_pos > 0)
    4be6:	fcc051e3          	blez	a2,4ba8 <fputc+0x3e>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4bea:	4188                	lw	a0,0(a1)
    4bec:	05c1                	addi	a1,a1,16
    4bee:	d02fc0ef          	jal	10f0 <write>
        if (ret < stream->buf_write_pos)
    4bf2:	41042783          	lw	a5,1040(s0)
    4bf6:	02f55063          	bge	a0,a5,4c16 <fputc+0xac>
            stream->error = 1;
    4bfa:	01242423          	sw	s2,8(s0)
            stream->buf_write_pos = 0;
    4bfe:	40042823          	sw	zero,1040(s0)
    return c;
    4c02:	8526                	mv	a0,s1
    4c04:	b75d                	j	4baa <fputc+0x40>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4c06:	4188                	lw	a0,0(a1)
    4c08:	05c1                	addi	a1,a1,16
    4c0a:	ce6fc0ef          	jal	10f0 <write>
        if (ret < stream->buf_write_pos)
    4c0e:	41042783          	lw	a5,1040(s0)
    4c12:	00f54663          	blt	a0,a5,4c1e <fputc+0xb4>
        stream->buf_write_pos = 0;
    4c16:	40042823          	sw	zero,1040(s0)
    return c;
    4c1a:	8526                	mv	a0,s1
    4c1c:	b779                	j	4baa <fputc+0x40>
            stream->error = 1;
    4c1e:	4785                	li	a5,1
    4c20:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4c22:	40042823          	sw	zero,1040(s0)
    return c;
    4c26:	8526                	mv	a0,s1
    4c28:	b749                	j	4baa <fputc+0x40>
        return EOF;
    4c2a:	557d                	li	a0,-1
}
    4c2c:	8082                	ret

0000000000004c2e <fputs>:
    if (!stream)
    4c2e:	c1ed                	beqz	a1,4d10 <fputs+0xe2>
{
    4c30:	711d                	addi	sp,sp,-96
    4c32:	e4a6                	sd	s1,72(sp)
    4c34:	ec86                	sd	ra,88(sp)
    while (*s)
    4c36:	00054703          	lbu	a4,0(a0)
    4c3a:	84aa                	mv	s1,a0
    4c3c:	cf25                	beqz	a4,4cb4 <fputs+0x86>
    4c3e:	e8a2                	sd	s0,80(sp)
    4c40:	e0ca                	sd	s2,64(sp)
    4c42:	fc4e                	sd	s3,56(sp)
    4c44:	f852                	sd	s4,48(sp)
    4c46:	f456                	sd	s5,40(sp)
    4c48:	f05a                	sd	s6,32(sp)
    4c4a:	ec5e                	sd	s7,24(sp)
    4c4c:	842e                	mv	s0,a1
    if (stream->buf_mode == 2)
    4c4e:	4909                	li	s2,2
    if (stream->buf_write_pos >= BUFSIZ)
    4c50:	3ff00b13          	li	s6,1023
    else if (stream->buf_mode == 1 && c == '\n')
    4c54:	4985                	li	s3,1
    4c56:	4a29                	li	s4,10
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4c58:	01058a93          	addi	s5,a1,16
        if (write(stream->fd, &ch, 1) != 1)
    4c5c:	00f10b93          	addi	s7,sp,15
    4c60:	a031                	j	4c6c <fputs+0x3e>
    else if (stream->buf_mode == 1 && c == '\n')
    4c62:	09368563          	beq	a3,s3,4cec <fputs+0xbe>
    while (*s)
    4c66:	0004c703          	lbu	a4,0(s1)
    4c6a:	cf15                	beqz	a4,4ca6 <fputs+0x78>
    if (stream->buf_mode == 2)
    4c6c:	41c42683          	lw	a3,1052(s0)
        if (fputc(*s++, stream) == EOF)
    4c70:	0485                	addi	s1,s1,1
    if (stream->buf_mode == 2)
    4c72:	05268663          	beq	a3,s2,4cbe <fputs+0x90>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    4c76:	41042783          	lw	a5,1040(s0)
    4c7a:	0017861b          	addiw	a2,a5,1
    4c7e:	40c42823          	sw	a2,1040(s0)
    4c82:	97a2                	add	a5,a5,s0
    4c84:	00e78823          	sb	a4,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    4c88:	fccb5de3          	bge	s6,a2,4c62 <fputs+0x34>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4c8c:	4008                	lw	a0,0(s0)
    4c8e:	85d6                	mv	a1,s5
    4c90:	c60fc0ef          	jal	10f0 <write>
        if (ret < stream->buf_write_pos)
    4c94:	41042783          	lw	a5,1040(s0)
    4c98:	06f54763          	blt	a0,a5,4d06 <fputs+0xd8>
        stream->buf_write_pos = 0;
    4c9c:	40042823          	sw	zero,1040(s0)
    while (*s)
    4ca0:	0004c703          	lbu	a4,0(s1)
    4ca4:	f761                	bnez	a4,4c6c <fputs+0x3e>
    4ca6:	6446                	ld	s0,80(sp)
    4ca8:	6906                	ld	s2,64(sp)
    4caa:	79e2                	ld	s3,56(sp)
    4cac:	7a42                	ld	s4,48(sp)
    4cae:	7aa2                	ld	s5,40(sp)
    4cb0:	7b02                	ld	s6,32(sp)
    4cb2:	6be2                	ld	s7,24(sp)
}
    4cb4:	60e6                	ld	ra,88(sp)
    4cb6:	64a6                	ld	s1,72(sp)
    return 0;
    4cb8:	4501                	li	a0,0
}
    4cba:	6125                	addi	sp,sp,96
    4cbc:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    4cbe:	4008                	lw	a0,0(s0)
    4cc0:	4605                	li	a2,1
    4cc2:	85de                	mv	a1,s7
        char ch = (char)c;
    4cc4:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    4cc8:	c28fc0ef          	jal	10f0 <write>
    4ccc:	f9350de3          	beq	a0,s3,4c66 <fputs+0x38>
            stream->error = 1;
    4cd0:	01342423          	sw	s3,8(s0)
}
    4cd4:	60e6                	ld	ra,88(sp)
    4cd6:	6446                	ld	s0,80(sp)
    4cd8:	6906                	ld	s2,64(sp)
    4cda:	79e2                	ld	s3,56(sp)
    4cdc:	7a42                	ld	s4,48(sp)
    4cde:	7aa2                	ld	s5,40(sp)
    4ce0:	7b02                	ld	s6,32(sp)
    4ce2:	6be2                	ld	s7,24(sp)
    4ce4:	64a6                	ld	s1,72(sp)
        return -1;
    4ce6:	557d                	li	a0,-1
}
    4ce8:	6125                	addi	sp,sp,96
    4cea:	8082                	ret
    else if (stream->buf_mode == 1 && c == '\n')
    4cec:	f7471de3          	bne	a4,s4,4c66 <fputs+0x38>
    if (stream->buf_write_pos > 0)
    4cf0:	f6c05be3          	blez	a2,4c66 <fputs+0x38>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4cf4:	4008                	lw	a0,0(s0)
    4cf6:	01040593          	addi	a1,s0,16
    4cfa:	bf6fc0ef          	jal	10f0 <write>
        if (ret < stream->buf_write_pos)
    4cfe:	41042783          	lw	a5,1040(s0)
    4d02:	f8f55de3          	bge	a0,a5,4c9c <fputs+0x6e>
            stream->error = 1;
    4d06:	4785                	li	a5,1
    4d08:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4d0a:	40042823          	sw	zero,1040(s0)
            return EOF;
    4d0e:	bfa1                	j	4c66 <fputs+0x38>
        return -1;
    4d10:	557d                	li	a0,-1
}
    4d12:	8082                	ret

0000000000004d14 <fgetc>:
    if (!stream)
    4d14:	c949                	beqz	a0,4da6 <fgetc+0x92>
    if (stream->buf_write_pos > 0)
    4d16:	41052603          	lw	a2,1040(a0)
{
    4d1a:	1141                	addi	sp,sp,-16
    4d1c:	e022                	sd	s0,0(sp)
    4d1e:	e406                	sd	ra,8(sp)
    4d20:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    4d22:	04c04863          	bgtz	a2,4d72 <fgetc+0x5e>
    if (stream->buf_read_pos < stream->buf_read_cnt)
    4d26:	41442783          	lw	a5,1044(s0)
    4d2a:	41842703          	lw	a4,1048(s0)
    4d2e:	00e7dd63          	bge	a5,a4,4d48 <fgetc+0x34>
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4d32:	0017871b          	addiw	a4,a5,1
    4d36:	40e42a23          	sw	a4,1044(s0)
    4d3a:	943e                	add	s0,s0,a5
    4d3c:	01044503          	lbu	a0,16(s0)
}
    4d40:	60a2                	ld	ra,8(sp)
    4d42:	6402                	ld	s0,0(sp)
    4d44:	0141                	addi	sp,sp,16
    4d46:	8082                	ret
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    4d48:	4008                	lw	a0,0(s0)
    4d4a:	40000613          	li	a2,1024
    4d4e:	01040593          	addi	a1,s0,16
    4d52:	b96fc0ef          	jal	10e8 <read>
    4d56:	87aa                	mv	a5,a0
    if (ret <= 0)
    4d58:	02a05e63          	blez	a0,4d94 <fgetc+0x80>
    stream->buf_read_cnt = (int)ret;
    4d5c:	40f42c23          	sw	a5,1048(s0)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4d60:	4785                	li	a5,1
    4d62:	01044503          	lbu	a0,16(s0)
}
    4d66:	60a2                	ld	ra,8(sp)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4d68:	40f42a23          	sw	a5,1044(s0)
}
    4d6c:	6402                	ld	s0,0(sp)
    4d6e:	0141                	addi	sp,sp,16
    4d70:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4d72:	4108                	lw	a0,0(a0)
    4d74:	01040593          	addi	a1,s0,16
    4d78:	b78fc0ef          	jal	10f0 <write>
        if (ret < stream->buf_write_pos)
    4d7c:	41042783          	lw	a5,1040(s0)
    4d80:	00f54563          	blt	a0,a5,4d8a <fgetc+0x76>
        stream->buf_write_pos = 0;
    4d84:	40042823          	sw	zero,1040(s0)
    4d88:	bf79                	j	4d26 <fgetc+0x12>
            stream->error = 1;
    4d8a:	4785                	li	a5,1
    4d8c:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4d8e:	40042823          	sw	zero,1040(s0)
            return EOF;
    4d92:	bf51                	j	4d26 <fgetc+0x12>
        if (ret == 0)
    4d94:	e509                	bnez	a0,4d9e <fgetc+0x8a>
            stream->eof = 1;
    4d96:	4785                	li	a5,1
    4d98:	c45c                	sw	a5,12(s0)
        return EOF;
    4d9a:	557d                	li	a0,-1
    4d9c:	b755                	j	4d40 <fgetc+0x2c>
            stream->error = 1;
    4d9e:	4785                	li	a5,1
    4da0:	c41c                	sw	a5,8(s0)
        return EOF;
    4da2:	557d                	li	a0,-1
    4da4:	bf71                	j	4d40 <fgetc+0x2c>
    4da6:	557d                	li	a0,-1
}
    4da8:	8082                	ret

0000000000004daa <fgets>:
    if (!stream || n <= 0)
    4daa:	ce5d                	beqz	a2,4e68 <fgets+0xbe>
    4dac:	0ab05e63          	blez	a1,4e68 <fgets+0xbe>
{
    4db0:	715d                	addi	sp,sp,-80
    4db2:	e0a2                	sd	s0,64(sp)
    4db4:	fc26                	sd	s1,56(sp)
    4db6:	f84a                	sd	s2,48(sp)
    4db8:	f44e                	sd	s3,40(sp)
    4dba:	f052                	sd	s4,32(sp)
    4dbc:	ec56                	sd	s5,24(sp)
    4dbe:	e85a                	sd	s6,16(sp)
    4dc0:	e45e                	sd	s7,8(sp)
    4dc2:	e486                	sd	ra,72(sp)
    4dc4:	8432                	mv	s0,a2
    4dc6:	8aaa                	mv	s5,a0
    4dc8:	892a                	mv	s2,a0
    4dca:	fff58b9b          	addiw	s7,a1,-1
    int i = 0, c;
    4dce:	4481                	li	s1,0
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4dd0:	01060993          	addi	s3,a2,16
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4dd4:	4b05                	li	s6,1
        if (c == '\n')
    4dd6:	4a29                	li	s4,10
    while (i < n - 1)
    4dd8:	05748163          	beq	s1,s7,4e1a <fgets+0x70>
    if (stream->buf_write_pos > 0)
    4ddc:	41042603          	lw	a2,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4de0:	85ce                	mv	a1,s3
    if (stream->buf_write_pos > 0)
    4de2:	06c04963          	bgtz	a2,4e54 <fgets+0xaa>
    if (stream->buf_read_pos < stream->buf_read_cnt)
    4de6:	41442783          	lw	a5,1044(s0)
    4dea:	41842703          	lw	a4,1048(s0)
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    4dee:	40000613          	li	a2,1024
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4df2:	0017851b          	addiw	a0,a5,1
    4df6:	00f406b3          	add	a3,s0,a5
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    4dfa:	85ce                	mv	a1,s3
    if (stream->buf_read_pos < stream->buf_read_cnt)
    4dfc:	02e7de63          	bge	a5,a4,4e38 <fgets+0x8e>
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4e00:	40a42a23          	sw	a0,1044(s0)
    4e04:	0106c783          	lbu	a5,16(a3)
    4e08:	0007871b          	sext.w	a4,a5
        str[i++] = (char)c;
    4e0c:	00f90023          	sb	a5,0(s2)
    4e10:	2485                	addiw	s1,s1,1
        if (c == '\n')
    4e12:	0905                	addi	s2,s2,1
    4e14:	fd4712e3          	bne	a4,s4,4dd8 <fgets+0x2e>
        str[i++] = (char)c;
    4e18:	8ba6                	mv	s7,s1
    str[i] = '\0';
    4e1a:	9bd6                	add	s7,s7,s5
    4e1c:	000b8023          	sb	zero,0(s7)
    return str;
    4e20:	8556                	mv	a0,s5
}
    4e22:	60a6                	ld	ra,72(sp)
    4e24:	6406                	ld	s0,64(sp)
    4e26:	74e2                	ld	s1,56(sp)
    4e28:	7942                	ld	s2,48(sp)
    4e2a:	79a2                	ld	s3,40(sp)
    4e2c:	7a02                	ld	s4,32(sp)
    4e2e:	6ae2                	ld	s5,24(sp)
    4e30:	6b42                	ld	s6,16(sp)
    4e32:	6ba2                	ld	s7,8(sp)
    4e34:	6161                	addi	sp,sp,80
    4e36:	8082                	ret
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    4e38:	4008                	lw	a0,0(s0)
    4e3a:	aaefc0ef          	jal	10e8 <read>
    if (ret <= 0)
    4e3e:	02a05c63          	blez	a0,4e76 <fgets+0xcc>
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4e42:	01044783          	lbu	a5,16(s0)
    stream->buf_read_cnt = (int)ret;
    4e46:	40a42c23          	sw	a0,1048(s0)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4e4a:	41642a23          	sw	s6,1044(s0)
    4e4e:	0007871b          	sext.w	a4,a5
        if (c == -1)
    4e52:	bf6d                	j	4e0c <fgets+0x62>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4e54:	4008                	lw	a0,0(s0)
    4e56:	a9afc0ef          	jal	10f0 <write>
        if (ret < stream->buf_write_pos)
    4e5a:	41042783          	lw	a5,1040(s0)
    4e5e:	00f54763          	blt	a0,a5,4e6c <fgets+0xc2>
        stream->buf_write_pos = 0;
    4e62:	40042823          	sw	zero,1040(s0)
    4e66:	b741                	j	4de6 <fgets+0x3c>
        return NULL;
    4e68:	4501                	li	a0,0
}
    4e6a:	8082                	ret
            stream->error = 1;
    4e6c:	4785                	li	a5,1
    4e6e:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4e70:	40042823          	sw	zero,1040(s0)
            return EOF;
    4e74:	bf8d                	j	4de6 <fgets+0x3c>
            stream->eof = 1;
    4e76:	4785                	li	a5,1
        if (ret == 0)
    4e78:	e509                	bnez	a0,4e82 <fgets+0xd8>
            stream->eof = 1;
    4e7a:	c45c                	sw	a5,12(s0)
            if (i == 0)
    4e7c:	fcd1                	bnez	s1,4e18 <fgets+0x6e>
        return NULL;
    4e7e:	4501                	li	a0,0
    4e80:	b74d                	j	4e22 <fgets+0x78>
            stream->error = 1;
    4e82:	c41c                	sw	a5,8(s0)
        if (c == -1)
    4e84:	bfe5                	j	4e7c <fgets+0xd2>

0000000000004e86 <fread>:
{
    4e86:	715d                	addi	sp,sp,-80
    4e88:	e486                	sd	ra,72(sp)
    4e8a:	f44e                	sd	s3,40(sp)
    if (!stream || size == 0 || nmemb == 0)
    4e8c:	0e068963          	beqz	a3,4f7e <fread+0xf8>
    4e90:	ec56                	sd	s5,24(sp)
        return 0;
    4e92:	4981                	li	s3,0
    4e94:	8aae                	mv	s5,a1
    if (!stream || size == 0 || nmemb == 0)
    4e96:	c9bd                	beqz	a1,4f0c <fread+0x86>
    4e98:	ca35                	beqz	a2,4f0c <fread+0x86>
    if (stream->buf_write_pos > 0)
    4e9a:	4106a783          	lw	a5,1040(a3)
    4e9e:	e0a2                	sd	s0,64(sp)
    4ea0:	f052                	sd	s4,32(sp)
    uint64 total_bytes = size * nmemb;
    4ea2:	02c589b3          	mul	s3,a1,a2
    4ea6:	8436                	mv	s0,a3
    4ea8:	8a2a                	mv	s4,a0
    if (stream->buf_write_pos > 0)
    4eaa:	0af04d63          	bgtz	a5,4f64 <fread+0xde>
    while (bytes_read < total_bytes)
    4eae:	04098d63          	beqz	s3,4f08 <fread+0x82>
    4eb2:	fc26                	sd	s1,56(sp)
    4eb4:	e85a                	sd	s6,16(sp)
    4eb6:	e45e                	sd	s7,8(sp)
    4eb8:	f84a                	sd	s2,48(sp)
    4eba:	4481                	li	s1,0
            if (remaining >= BUFSIZ)
    4ebc:	3ff00b13          	li	s6,1023
                int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    4ec0:	01040b93          	addi	s7,s0,16
        if (stream->buf_read_pos < stream->buf_read_cnt)
    4ec4:	41442703          	lw	a4,1044(s0)
    4ec8:	41842783          	lw	a5,1048(s0)
            uint64 remaining = total_bytes - bytes_read;
    4ecc:	40998633          	sub	a2,s3,s1
        if (stream->buf_read_pos < stream->buf_read_cnt)
    4ed0:	06f74463          	blt	a4,a5,4f38 <fread+0xb2>
                int64 ret = read(stream->fd, dst + bytes_read, remaining);
    4ed4:	4008                	lw	a0,0(s0)
    4ed6:	009a05b3          	add	a1,s4,s1
            if (remaining >= BUFSIZ)
    4eda:	02cb7f63          	bgeu	s6,a2,4f18 <fread+0x92>
                int64 ret = read(stream->fd, dst + bytes_read, remaining);
    4ede:	a0afc0ef          	jal	10e8 <read>
                if (ret <= 0)
    4ee2:	0aa05463          	blez	a0,4f8a <fread+0x104>
                bytes_read += ret;
    4ee6:	94aa                	add	s1,s1,a0
    while (bytes_read < total_bytes)
    4ee8:	fd34eee3          	bltu	s1,s3,4ec4 <fread+0x3e>
    return bytes_read / size;
    4eec:	0354d9b3          	divu	s3,s1,s5
    4ef0:	6406                	ld	s0,64(sp)
}
    4ef2:	60a6                	ld	ra,72(sp)
    return bytes_read / size;
    4ef4:	74e2                	ld	s1,56(sp)
    4ef6:	7942                	ld	s2,48(sp)
    4ef8:	7a02                	ld	s4,32(sp)
    4efa:	6ae2                	ld	s5,24(sp)
    4efc:	6b42                	ld	s6,16(sp)
    4efe:	6ba2                	ld	s7,8(sp)
}
    4f00:	854e                	mv	a0,s3
    4f02:	79a2                	ld	s3,40(sp)
    4f04:	6161                	addi	sp,sp,80
    4f06:	8082                	ret
    4f08:	6406                	ld	s0,64(sp)
    4f0a:	7a02                	ld	s4,32(sp)
    4f0c:	60a6                	ld	ra,72(sp)
    4f0e:	6ae2                	ld	s5,24(sp)
    4f10:	854e                	mv	a0,s3
    4f12:	79a2                	ld	s3,40(sp)
    4f14:	6161                	addi	sp,sp,80
    4f16:	8082                	ret
                stream->buf_read_pos = 0;
    4f18:	40042a23          	sw	zero,1044(s0)
                stream->buf_read_cnt = 0;
    4f1c:	40042c23          	sw	zero,1048(s0)
                int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    4f20:	40000613          	li	a2,1024
    4f24:	85de                	mv	a1,s7
    4f26:	9c2fc0ef          	jal	10e8 <read>
                if (ret <= 0)
    4f2a:	06a05063          	blez	a0,4f8a <fread+0x104>
                stream->buf_read_cnt = (int)ret;
    4f2e:	40a42c23          	sw	a0,1048(s0)
    while (bytes_read < total_bytes)
    4f32:	f934e9e3          	bltu	s1,s3,4ec4 <fread+0x3e>
    4f36:	bf5d                	j	4eec <fread+0x66>
            uint64 available = stream->buf_read_cnt - stream->buf_read_pos;
    4f38:	40e7893b          	subw	s2,a5,a4
            memcpy(dst + bytes_read, stream->buffer + stream->buf_read_pos, to_copy);
    4f3c:	00eb85b3          	add	a1,s7,a4
    4f40:	009a0533          	add	a0,s4,s1
            uint64 to_copy = (available < remaining) ? available : remaining;
    4f44:	01267363          	bgeu	a2,s2,4f4a <fread+0xc4>
    4f48:	8932                	mv	s2,a2
            memcpy(dst + bytes_read, stream->buffer + stream->buf_read_pos, to_copy);
    4f4a:	864a                	mv	a2,s2
    4f4c:	3e1000ef          	jal	5b2c <memcpy>
            stream->buf_read_pos += to_copy;
    4f50:	41442783          	lw	a5,1044(s0)
            bytes_read += to_copy;
    4f54:	94ca                	add	s1,s1,s2
            stream->buf_read_pos += to_copy;
    4f56:	012787bb          	addw	a5,a5,s2
    4f5a:	40f42a23          	sw	a5,1044(s0)
    while (bytes_read < total_bytes)
    4f5e:	f734e3e3          	bltu	s1,s3,4ec4 <fread+0x3e>
    4f62:	b769                	j	4eec <fread+0x66>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4f64:	4288                	lw	a0,0(a3)
    4f66:	863e                	mv	a2,a5
    4f68:	01068593          	addi	a1,a3,16
    4f6c:	984fc0ef          	jal	10f0 <write>
        if (ret < stream->buf_write_pos)
    4f70:	41042783          	lw	a5,1040(s0)
    4f74:	02f54163          	blt	a0,a5,4f96 <fread+0x110>
        stream->buf_write_pos = 0;
    4f78:	40042823          	sw	zero,1040(s0)
    4f7c:	bf0d                	j	4eae <fread+0x28>
}
    4f7e:	60a6                	ld	ra,72(sp)
        return 0;
    4f80:	4981                	li	s3,0
}
    4f82:	854e                	mv	a0,s3
    4f84:	79a2                	ld	s3,40(sp)
    4f86:	6161                	addi	sp,sp,80
    4f88:	8082                	ret
                        stream->eof = 1;
    4f8a:	4785                	li	a5,1
                    if (ret == 0)
    4f8c:	e119                	bnez	a0,4f92 <fread+0x10c>
                        stream->eof = 1;
    4f8e:	c45c                	sw	a5,12(s0)
    4f90:	bfb1                	j	4eec <fread+0x66>
                        stream->error = 1;
    4f92:	c41c                	sw	a5,8(s0)
                    return bytes_read / size;
    4f94:	bfa1                	j	4eec <fread+0x66>
            stream->error = 1;
    4f96:	4785                	li	a5,1
    4f98:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4f9a:	40042823          	sw	zero,1040(s0)
            return EOF;
    4f9e:	bf01                	j	4eae <fread+0x28>

0000000000004fa0 <fwrite>:
{
    4fa0:	711d                	addi	sp,sp,-96
    4fa2:	ec86                	sd	ra,88(sp)
    4fa4:	e0ca                	sd	s2,64(sp)
    if (!stream || !ptr || size == 0 || nmemb == 0)
    4fa6:	10068063          	beqz	a3,50a6 <fwrite+0x106>
    4faa:	f456                	sd	s5,40(sp)
    4fac:	8aaa                	mv	s5,a0
    4fae:	10050263          	beqz	a0,50b2 <fwrite+0x112>
    4fb2:	f05a                	sd	s6,32(sp)
        return 0;
    4fb4:	4901                	li	s2,0
    4fb6:	8b2e                	mv	s6,a1
    if (!stream || !ptr || size == 0 || nmemb == 0)
    4fb8:	c1d9                	beqz	a1,503e <fwrite+0x9e>
    4fba:	c251                	beqz	a2,503e <fwrite+0x9e>
    if (stream->buf_mode == 2)
    4fbc:	41c6a703          	lw	a4,1052(a3)
    4fc0:	e8a2                	sd	s0,80(sp)
    4fc2:	4789                	li	a5,2
    uint64 total_bytes = size * nmemb;
    4fc4:	02c58933          	mul	s2,a1,a2
    if (stream->buf_mode == 2)
    4fc8:	8436                	mv	s0,a3
    4fca:	0ef70b63          	beq	a4,a5,50c0 <fwrite+0x120>
    4fce:	fc4e                	sd	s3,56(sp)
    4fd0:	ec5e                	sd	s7,24(sp)
    4fd2:	e862                	sd	s8,16(sp)
    uint64 bytes_written = 0;
    4fd4:	4981                	li	s3,0
    4fd6:	01068b93          	addi	s7,a3,16
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    4fda:	40000c13          	li	s8,1024
    while (bytes_written < total_bytes)
    4fde:	12090263          	beqz	s2,5102 <fwrite+0x162>
    4fe2:	e4a6                	sd	s1,72(sp)
    4fe4:	f852                	sd	s4,48(sp)
    4fe6:	e466                	sd	s9,8(sp)
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    4fe8:	41042783          	lw	a5,1040(s0)
        uint64 remaining = total_bytes - bytes_written;
    4fec:	41390cb3          	sub	s9,s2,s3
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, remaining);
    4ff0:	013a85b3          	add	a1,s5,s3
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    4ff4:	40fc0a3b          	subw	s4,s8,a5
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, space_left);
    4ff8:	00fb8533          	add	a0,s7,a5
    4ffc:	8652                	mv	a2,s4
        if (remaining <= space_left)
    4ffe:	059a6763          	bltu	s4,s9,504c <fwrite+0xac>
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, remaining);
    5002:	8666                	mv	a2,s9
    5004:	329000ef          	jal	5b2c <memcpy>
            stream->buf_write_pos += remaining;
    5008:	41042783          	lw	a5,1040(s0)
            if (stream->buf_write_pos == BUFSIZ)
    500c:	40000713          	li	a4,1024
            stream->buf_write_pos += remaining;
    5010:	019786bb          	addw	a3,a5,s9
    5014:	40d42823          	sw	a3,1040(s0)
            if (stream->buf_write_pos == BUFSIZ)
    5018:	06e68a63          	beq	a3,a4,508c <fwrite+0xec>
    return bytes_written / size;
    501c:	03695933          	divu	s2,s2,s6
    5020:	6446                	ld	s0,80(sp)
    5022:	64a6                	ld	s1,72(sp)
    5024:	79e2                	ld	s3,56(sp)
    5026:	7a42                	ld	s4,48(sp)
    5028:	7aa2                	ld	s5,40(sp)
    502a:	7b02                	ld	s6,32(sp)
    502c:	6be2                	ld	s7,24(sp)
    502e:	6c42                	ld	s8,16(sp)
    5030:	6ca2                	ld	s9,8(sp)
}
    5032:	60e6                	ld	ra,88(sp)
    5034:	854a                	mv	a0,s2
    5036:	6906                	ld	s2,64(sp)
    5038:	6125                	addi	sp,sp,96
    503a:	8082                	ret
    503c:	6446                	ld	s0,80(sp)
    503e:	60e6                	ld	ra,88(sp)
    5040:	7aa2                	ld	s5,40(sp)
    5042:	7b02                	ld	s6,32(sp)
    5044:	854a                	mv	a0,s2
    5046:	6906                	ld	s2,64(sp)
    5048:	6125                	addi	sp,sp,96
    504a:	8082                	ret
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, space_left);
    504c:	2e1000ef          	jal	5b2c <memcpy>
            stream->buf_write_pos += space_left;
    5050:	41042783          	lw	a5,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    5054:	85de                	mv	a1,s7
            bytes_written += space_left;
    5056:	99d2                	add	s3,s3,s4
            stream->buf_write_pos += space_left;
    5058:	00fa04bb          	addw	s1,s4,a5
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    505c:	02049613          	slli	a2,s1,0x20
            stream->buf_write_pos += space_left;
    5060:	40942823          	sw	s1,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    5064:	9201                	srli	a2,a2,0x20
    if (stream->buf_write_pos > 0)
    5066:	00904763          	bgtz	s1,5074 <fwrite+0xd4>
    while (bytes_written < total_bytes)
    506a:	f729efe3          	bltu	s3,s2,4fe8 <fwrite+0x48>
    return bytes_written / size;
    506e:	0369d933          	divu	s2,s3,s6
    5072:	b77d                	j	5020 <fwrite+0x80>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    5074:	4008                	lw	a0,0(s0)
    5076:	87afc0ef          	jal	10f0 <write>
        if (ret < stream->buf_write_pos)
    507a:	41042783          	lw	a5,1040(s0)
    507e:	08f54963          	blt	a0,a5,5110 <fwrite+0x170>
        stream->buf_write_pos = 0;
    5082:	40042823          	sw	zero,1040(s0)
    while (bytes_written < total_bytes)
    5086:	f729e1e3          	bltu	s3,s2,4fe8 <fwrite+0x48>
    508a:	b7d5                	j	506e <fwrite+0xce>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    508c:	4008                	lw	a0,0(s0)
    508e:	40000613          	li	a2,1024
    5092:	85de                	mv	a1,s7
    5094:	85cfc0ef          	jal	10f0 <write>
        if (ret < stream->buf_write_pos)
    5098:	41042783          	lw	a5,1040(s0)
    509c:	08f54163          	blt	a0,a5,511e <fwrite+0x17e>
        stream->buf_write_pos = 0;
    50a0:	40042823          	sw	zero,1040(s0)
    50a4:	bfa5                	j	501c <fwrite+0x7c>
}
    50a6:	60e6                	ld	ra,88(sp)
        return 0;
    50a8:	4901                	li	s2,0
}
    50aa:	854a                	mv	a0,s2
    50ac:	6906                	ld	s2,64(sp)
    50ae:	6125                	addi	sp,sp,96
    50b0:	8082                	ret
    50b2:	60e6                	ld	ra,88(sp)
        return 0;
    50b4:	4901                	li	s2,0
    50b6:	7aa2                	ld	s5,40(sp)
}
    50b8:	854a                	mv	a0,s2
    50ba:	6906                	ld	s2,64(sp)
    50bc:	6125                	addi	sp,sp,96
    50be:	8082                	ret
        while (bytes_written < total_bytes)
    50c0:	f6090ee3          	beqz	s2,503c <fwrite+0x9c>
    50c4:	e4a6                	sd	s1,72(sp)
    uint64 bytes_written = 0;
    50c6:	4481                	li	s1,0
    50c8:	a021                	j	50d0 <fwrite+0x130>
            bytes_written += ret;
    50ca:	94aa                	add	s1,s1,a0
        while (bytes_written < total_bytes)
    50cc:	0324f463          	bgeu	s1,s2,50f4 <fwrite+0x154>
            int64 ret = write(stream->fd, src + bytes_written, total_bytes - bytes_written);
    50d0:	4008                	lw	a0,0(s0)
    50d2:	40990633          	sub	a2,s2,s1
    50d6:	009a85b3          	add	a1,s5,s1
    50da:	816fc0ef          	jal	10f0 <write>
            if (ret <= 0)
    50de:	fea046e3          	bgtz	a0,50ca <fwrite+0x12a>
                stream->error = 1;
    50e2:	4785                	li	a5,1
        return bytes_written / size;
    50e4:	0364d933          	divu	s2,s1,s6
                stream->error = 1;
    50e8:	c41c                	sw	a5,8(s0)
                break;
    50ea:	64a6                	ld	s1,72(sp)
    50ec:	6446                	ld	s0,80(sp)
    50ee:	7aa2                	ld	s5,40(sp)
    50f0:	7b02                	ld	s6,32(sp)
    50f2:	b781                	j	5032 <fwrite+0x92>
        return bytes_written / size;
    50f4:	0364d933          	divu	s2,s1,s6
    50f8:	6446                	ld	s0,80(sp)
    50fa:	64a6                	ld	s1,72(sp)
    50fc:	7aa2                	ld	s5,40(sp)
    50fe:	7b02                	ld	s6,32(sp)
    5100:	bf0d                	j	5032 <fwrite+0x92>
    5102:	6446                	ld	s0,80(sp)
    5104:	79e2                	ld	s3,56(sp)
    5106:	7aa2                	ld	s5,40(sp)
    5108:	7b02                	ld	s6,32(sp)
    510a:	6be2                	ld	s7,24(sp)
    510c:	6c42                	ld	s8,16(sp)
    510e:	b715                	j	5032 <fwrite+0x92>
            stream->error = 1;
    5110:	4785                	li	a5,1
    5112:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    5114:	40042823          	sw	zero,1040(s0)
    while (bytes_written < total_bytes)
    5118:	ed29e8e3          	bltu	s3,s2,4fe8 <fwrite+0x48>
    511c:	bf89                	j	506e <fwrite+0xce>
            stream->error = 1;
    511e:	4785                	li	a5,1
    5120:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    5122:	40042823          	sw	zero,1040(s0)
            return EOF;
    5126:	bddd                	j	501c <fwrite+0x7c>

0000000000005128 <fseek>:
    if (!stream)
    5128:	c925                	beqz	a0,5198 <fseek+0x70>
{
    512a:	1101                	addi	sp,sp,-32
    512c:	e04a                	sd	s2,0(sp)
    512e:	8932                	mv	s2,a2
    if (stream->buf_write_pos > 0)
    5130:	41052603          	lw	a2,1040(a0)
{
    5134:	e822                	sd	s0,16(sp)
    5136:	e426                	sd	s1,8(sp)
    5138:	ec06                	sd	ra,24(sp)
    513a:	842a                	mv	s0,a0
    513c:	84ae                	mv	s1,a1
    if (stream->buf_write_pos > 0)
    513e:	02c04863          	bgtz	a2,516e <fseek+0x46>
    if (lseek(stream->fd, offset, whence) < 0)
    5142:	4008                	lw	a0,0(s0)
    stream->buf_read_pos = 0;
    5144:	40042a23          	sw	zero,1044(s0)
    stream->buf_read_cnt = 0;
    5148:	40042c23          	sw	zero,1048(s0)
    stream->eof = 0;
    514c:	00042623          	sw	zero,12(s0)
    if (lseek(stream->fd, offset, whence) < 0)
    5150:	864a                	mv	a2,s2
    5152:	0004859b          	sext.w	a1,s1
    5156:	82afc0ef          	jal	1180 <lseek>
    515a:	87aa                	mv	a5,a0
    return 0;
    515c:	4501                	li	a0,0
    if (lseek(stream->fd, offset, whence) < 0)
    515e:	0207c463          	bltz	a5,5186 <fseek+0x5e>
}
    5162:	60e2                	ld	ra,24(sp)
    5164:	6442                	ld	s0,16(sp)
    5166:	64a2                	ld	s1,8(sp)
    5168:	6902                	ld	s2,0(sp)
    516a:	6105                	addi	sp,sp,32
    516c:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    516e:	4108                	lw	a0,0(a0)
    5170:	01040593          	addi	a1,s0,16
    5174:	f7dfb0ef          	jal	10f0 <write>
        if (ret < stream->buf_write_pos)
    5178:	41042783          	lw	a5,1040(s0)
    517c:	00f54963          	blt	a0,a5,518e <fseek+0x66>
        stream->buf_write_pos = 0;
    5180:	40042823          	sw	zero,1040(s0)
    5184:	bf7d                	j	5142 <fseek+0x1a>
        stream->error = 1;
    5186:	4785                	li	a5,1
    5188:	c41c                	sw	a5,8(s0)
        return -1;
    518a:	557d                	li	a0,-1
    518c:	bfd9                	j	5162 <fseek+0x3a>
            stream->error = 1;
    518e:	4785                	li	a5,1
    5190:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    5192:	40042823          	sw	zero,1040(s0)
            return EOF;
    5196:	b775                	j	5142 <fseek+0x1a>
        return -1;
    5198:	557d                	li	a0,-1
}
    519a:	8082                	ret

000000000000519c <ftell>:
    if (!stream)
    519c:	c505                	beqz	a0,51c4 <ftell+0x28>
{
    519e:	1141                	addi	sp,sp,-16
    51a0:	e022                	sd	s0,0(sp)
    51a2:	842a                	mv	s0,a0
    int64 ret = lseek(stream->fd, 0, SEEK_CUR);
    51a4:	4108                	lw	a0,0(a0)
    51a6:	4605                	li	a2,1
    51a8:	4581                	li	a1,0
{
    51aa:	e406                	sd	ra,8(sp)
    int64 ret = lseek(stream->fd, 0, SEEK_CUR);
    51ac:	fd5fb0ef          	jal	1180 <lseek>
    if (ret < 0)
    51b0:	00054663          	bltz	a0,51bc <ftell+0x20>
}
    51b4:	60a2                	ld	ra,8(sp)
    51b6:	6402                	ld	s0,0(sp)
    51b8:	0141                	addi	sp,sp,16
    51ba:	8082                	ret
        stream->error = 1;
    51bc:	4785                	li	a5,1
    51be:	c41c                	sw	a5,8(s0)
        return -1L;
    51c0:	557d                	li	a0,-1
    51c2:	bfcd                	j	51b4 <ftell+0x18>
    51c4:	557d                	li	a0,-1
}
    51c6:	8082                	ret

00000000000051c8 <rewind>:
    if (stream)
    51c8:	c915                	beqz	a0,51fc <rewind+0x34>
    if (stream->buf_write_pos > 0)
    51ca:	41052603          	lw	a2,1040(a0)
{
    51ce:	1141                	addi	sp,sp,-16
    51d0:	e022                	sd	s0,0(sp)
    51d2:	e406                	sd	ra,8(sp)
    51d4:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    51d6:	02c04463          	bgtz	a2,51fe <rewind+0x36>
    if (lseek(stream->fd, offset, whence) < 0)
    51da:	4008                	lw	a0,0(s0)
    stream->buf_read_pos = 0;
    51dc:	40042a23          	sw	zero,1044(s0)
    stream->buf_read_cnt = 0;
    51e0:	40042c23          	sw	zero,1048(s0)
    stream->eof = 0;
    51e4:	00042623          	sw	zero,12(s0)
    if (lseek(stream->fd, offset, whence) < 0)
    51e8:	4601                	li	a2,0
    51ea:	4581                	li	a1,0
    51ec:	f95fb0ef          	jal	1180 <lseek>
}
    51f0:	60a2                	ld	ra,8(sp)
        stream->error = 0;
    51f2:	00042423          	sw	zero,8(s0)
}
    51f6:	6402                	ld	s0,0(sp)
    51f8:	0141                	addi	sp,sp,16
    51fa:	8082                	ret
    51fc:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    51fe:	4108                	lw	a0,0(a0)
    5200:	01040593          	addi	a1,s0,16
    5204:	eedfb0ef          	jal	10f0 <write>
        if (ret < stream->buf_write_pos)
    5208:	41042783          	lw	a5,1040(s0)
    520c:	00f54563          	blt	a0,a5,5216 <rewind+0x4e>
        stream->buf_write_pos = 0;
    5210:	40042823          	sw	zero,1040(s0)
    5214:	b7d9                	j	51da <rewind+0x12>
            stream->error = 1;
    5216:	4785                	li	a5,1
    5218:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    521a:	40042823          	sw	zero,1040(s0)
            return EOF;
    521e:	bf75                	j	51da <rewind+0x12>

0000000000005220 <feof>:
    return (stream) ? stream->eof : 1;
    5220:	c119                	beqz	a0,5226 <feof+0x6>
    5222:	4548                	lw	a0,12(a0)
    5224:	8082                	ret
    5226:	4505                	li	a0,1
}
    5228:	8082                	ret

000000000000522a <ferror>:
     return (stream) ? stream->error : 1;
    522a:	c119                	beqz	a0,5230 <ferror+0x6>
    522c:	4508                	lw	a0,8(a0)
    522e:	8082                	ret
    5230:	4505                	li	a0,1
}
    5232:	8082                	ret

0000000000005234 <clearerr>:
    if (stream)
    5234:	c509                	beqz	a0,523e <clearerr+0xa>
        stream->error = 0;
    5236:	00052423          	sw	zero,8(a0)
        stream->eof = 0;
    523a:	00052623          	sw	zero,12(a0)
}
    523e:	8082                	ret

0000000000005240 <ungetc>:
    if (!stream || c == EOF)
    5240:	c19d                	beqz	a1,5266 <ungetc+0x26>
    5242:	57fd                	li	a5,-1
    5244:	02f50163          	beq	a0,a5,5266 <ungetc+0x26>
    if (stream->buf_read_pos > 0)
    5248:	4145a783          	lw	a5,1044(a1)
    524c:	00f05d63          	blez	a5,5266 <ungetc+0x26>
        stream->buf_read_pos--;
    5250:	fff7871b          	addiw	a4,a5,-1
    5254:	40e5aa23          	sw	a4,1044(a1)
        stream->buffer[stream->buf_read_pos] = (char)c;
    5258:	00e587b3          	add	a5,a1,a4
    525c:	00a78823          	sb	a0,16(a5)
        stream->eof = 0;
    5260:	0005a623          	sw	zero,12(a1)
        return c;
    5264:	8082                	ret
        return EOF;
    5266:	557d                	li	a0,-1
    5268:	8082                	ret

000000000000526a <strtoull.part.0>:
    return new_ptr;
}

/* String Conversion*/

unsigned long long strtoull(const char *nptr, char **endptr, int base)
    526a:	1141                	addi	sp,sp,-16
    526c:	e422                	sd	s0,8(sp)
    526e:	8eaa                	mv	t4,a0
{
    const char *s = nptr;
    5270:	88aa                	mv	a7,a0
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    static inline int islower(int c) { return c >= 'a' && c <= 'z'; }
    static inline int isupper(int c) { return c >= 'A' && c <= 'Z'; }
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    static inline int isalnum(int c) { return isalpha(c) || isdigit(c); }
    static inline int isspace(int c) { return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r'; }
    5272:	02000313          	li	t1,32
    5276:	4e11                	li	t3,4
        return 0;
    }

    do
    {
        c = *s++;
    5278:	0008c783          	lbu	a5,0(a7)
    527c:	00188813          	addi	a6,a7,1
    5280:	ff77871b          	addiw	a4,a5,-9
    5284:	0ff77693          	zext.b	a3,a4
    5288:	0007871b          	sext.w	a4,a5
    528c:	04678363          	beq	a5,t1,52d2 <strtoull.part.0+0x68>
    5290:	04de7163          	bgeu	t3,a3,52d2 <strtoull.part.0+0x68>
    } while (isspace(c));

    if (c == '-')
    5294:	02d00793          	li	a5,45
    5298:	0ef70863          	beq	a4,a5,5388 <strtoull.part.0+0x11e>
    {
        neg = 1;
        c = *s++;
    }
    else if (c == '+')
    529c:	02b00793          	li	a5,43
    int neg = 0, any, cutlim;
    52a0:	4381                	li	t2,0
    else if (c == '+')
    52a2:	08f70c63          	beq	a4,a5,533a <strtoull.part.0+0xd0>
    {
        c = *s++;
    }

    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    52a6:	ea05                	bnez	a2,52d6 <strtoull.part.0+0x6c>
    52a8:	03000793          	li	a5,48
    52ac:	0ef70463          	beq	a4,a5,5394 <strtoull.part.0+0x12a>
    52b0:	00ccd8b7          	lui	a7,0xccd
    52b4:	ccd88893          	addi	a7,a7,-819 # cccccd <_ZSt4cerr+0xcc3e5d>
    52b8:	08b2                	slli	a7,a7,0xc
    52ba:	ccd88893          	addi	a7,a7,-819
    52be:	08b2                	slli	a7,a7,0xc
    52c0:	ccd88893          	addi	a7,a7,-819
    52c4:	08b6                	slli	a7,a7,0xd
    52c6:	4415                	li	s0,5
    52c8:	99988893          	addi	a7,a7,-1639
    52cc:	42a9                	li	t0,10
        c = s[1];
        s += 2;
        base = 16;
    }
    if (base == 0)
        base = (c == '0' ? 8 : 10);
    52ce:	4629                	li	a2,10
    52d0:	a829                	j	52ea <strtoull.part.0+0x80>
unsigned long long strtoull(const char *nptr, char **endptr, int base)
    52d2:	88c2                	mv	a7,a6
    52d4:	b755                	j	5278 <strtoull.part.0+0xe>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    52d6:	47c1                	li	a5,16
    52d8:	0cf60d63          	beq	a2,a5,53b2 <strtoull.part.0+0x148>

    cutoff = ULLONG_MAX / (unsigned long long)base;
    52dc:	58fd                	li	a7,-1
    cutlim = ULLONG_MAX % (unsigned long long)base;
    52de:	02c8f433          	remu	s0,a7,a2
    cutoff = ULLONG_MAX / (unsigned long long)base;
    52e2:	82b2                	mv	t0,a2
    52e4:	02c8d8b3          	divu	a7,a7,a2
    cutlim = ULLONG_MAX % (unsigned long long)base;
    52e8:	2401                	sext.w	s0,s0

    for (acc = 0, any = 0;; c = *s++)
    52ea:	4301                	li	t1,0
    52ec:	4501                	li	a0,0
    {
        if (isdigit(c))
    52ee:	4e25                	li	t3,9
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    52f0:	4fe5                	li	t6,25
            break;

        if (c >= base)
            break;

        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    52f2:	5f7d                	li	t5,-1
        if (isdigit(c))
    52f4:	fd07079b          	addiw	a5,a4,-48
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    52f8:	0007069b          	sext.w	a3,a4
    52fc:	00fe7e63          	bgeu	t3,a5,5318 <strtoull.part.0+0xae>
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    5300:	f9f6879b          	addiw	a5,a3,-97
    5304:	04fff063          	bgeu	t6,a5,5344 <strtoull.part.0+0xda>
    5308:	fbf6869b          	addiw	a3,a3,-65
    530c:	04dfe163          	bltu	t6,a3,534e <strtoull.part.0+0xe4>
            c -= isupper(c) ? 'A' - 10 : 'a' - 10;
    5310:	03700793          	li	a5,55
    5314:	40f707bb          	subw	a5,a4,a5
        if (c >= base)
    5318:	02c7db63          	bge	a5,a2,534e <strtoull.part.0+0xe4>
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    531c:	01e30b63          	beq	t1,t5,5332 <strtoull.part.0+0xc8>
            any = -1;
    5320:	537d                	li	t1,-1
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    5322:	00a8e863          	bltu	a7,a0,5332 <strtoull.part.0+0xc8>
    5326:	05150e63          	beq	a0,a7,5382 <strtoull.part.0+0x118>
        else
        {
            any = 1;
    532a:	4305                	li	t1,1
            acc *= base;
    532c:	02550533          	mul	a0,a0,t0
            acc += c;
    5330:	953e                	add	a0,a0,a5
    for (acc = 0, any = 0;; c = *s++)
    5332:	0805                	addi	a6,a6,1
    5334:	fff84703          	lbu	a4,-1(a6)
        if (isdigit(c))
    5338:	bf75                	j	52f4 <strtoull.part.0+0x8a>
        c = *s++;
    533a:	00084703          	lbu	a4,0(a6)
    533e:	00288813          	addi	a6,a7,2
    5342:	b795                	j	52a6 <strtoull.part.0+0x3c>
            c -= isupper(c) ? 'A' - 10 : 'a' - 10;
    5344:	05700793          	li	a5,87
    5348:	40f707bb          	subw	a5,a4,a5
    534c:	b7f1                	j	5318 <strtoull.part.0+0xae>
        }
    }

    if (any < 0)
    534e:	57fd                	li	a5,-1
    5350:	00f30e63          	beq	t1,a5,536c <strtoull.part.0+0x102>
    {
        acc = ULLONG_MAX;
        errno = ERANGE;
    }
    else if (neg)
    5354:	00038463          	beqz	t2,535c <strtoull.part.0+0xf2>
        acc = -acc;
    5358:	40a00533          	neg	a0,a0

    if (endptr != 0)
    535c:	c589                	beqz	a1,5366 <strtoull.part.0+0xfc>
        *endptr = (char *)(any ? s - 1 : nptr);
    535e:	00031f63          	bnez	t1,537c <strtoull.part.0+0x112>
    5362:	01d5b023          	sd	t4,0(a1)

    return acc;
}
    5366:	6422                	ld	s0,8(sp)
    5368:	0141                	addi	sp,sp,16
    536a:	8082                	ret
        errno = ERANGE;
    536c:	02200793          	li	a5,34
    5370:	00004717          	auipc	a4,0x4
    5374:	9cf72423          	sw	a5,-1592(a4) # 8d38 <errno>
        acc = ULLONG_MAX;
    5378:	557d                	li	a0,-1
    if (endptr != 0)
    537a:	d5f5                	beqz	a1,5366 <strtoull.part.0+0xfc>
        *endptr = (char *)(any ? s - 1 : nptr);
    537c:	fff80e93          	addi	t4,a6,-1
    5380:	b7cd                	j	5362 <strtoull.part.0+0xf8>
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    5382:	faf448e3          	blt	s0,a5,5332 <strtoull.part.0+0xc8>
    5386:	b755                	j	532a <strtoull.part.0+0xc0>
        c = *s++;
    5388:	00084703          	lbu	a4,0(a6)
        neg = 1;
    538c:	4385                	li	t2,1
        c = *s++;
    538e:	00288813          	addi	a6,a7,2
    5392:	bf11                	j	52a6 <strtoull.part.0+0x3c>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    5394:	00084783          	lbu	a5,0(a6)
    5398:	05800693          	li	a3,88
    539c:	0df7f793          	andi	a5,a5,223
    53a0:	02d78b63          	beq	a5,a3,53d6 <strtoull.part.0+0x16c>
    53a4:	58fd                	li	a7,-1
    53a6:	441d                	li	s0,7
    53a8:	0038d893          	srli	a7,a7,0x3
    53ac:	42a1                	li	t0,8
        base = (c == '0' ? 8 : 10);
    53ae:	4621                	li	a2,8
    53b0:	bf2d                	j	52ea <strtoull.part.0+0x80>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    53b2:	03000793          	li	a5,48
    53b6:	00f70863          	beq	a4,a5,53c6 <strtoull.part.0+0x15c>
    53ba:	58fd                	li	a7,-1
    53bc:	443d                	li	s0,15
    53be:	0048d893          	srli	a7,a7,0x4
    53c2:	42c1                	li	t0,16
    53c4:	b71d                	j	52ea <strtoull.part.0+0x80>
    53c6:	00084783          	lbu	a5,0(a6)
    53ca:	05800693          	li	a3,88
    53ce:	0df7f793          	andi	a5,a5,223
    53d2:	fed794e3          	bne	a5,a3,53ba <strtoull.part.0+0x150>
        s += 2;
    53d6:	58fd                	li	a7,-1
        c = s[1];
    53d8:	00184703          	lbu	a4,1(a6)
        s += 2;
    53dc:	443d                	li	s0,15
    53de:	0809                	addi	a6,a6,2
    53e0:	0048d893          	srli	a7,a7,0x4
    53e4:	42c1                	li	t0,16
        base = 16;
    53e6:	4641                	li	a2,16
    53e8:	b709                	j	52ea <strtoull.part.0+0x80>

00000000000053ea <atexit>:
    if (__atexit_func_count >= ATEXIT_MAX)
    53ea:	00004717          	auipc	a4,0x4
    53ee:	94e70713          	addi	a4,a4,-1714 # 8d38 <errno>
    53f2:	435c                	lw	a5,4(a4)
    53f4:	46fd                	li	a3,31
    53f6:	00f6ca63          	blt	a3,a5,540a <atexit+0x20>
    __atexit_funcs[__atexit_func_count++] = function;
    53fa:	00379693          	slli	a3,a5,0x3
    53fe:	96ba                	add	a3,a3,a4
    5400:	2785                	addiw	a5,a5,1
    5402:	e688                	sd	a0,8(a3)
    5404:	c35c                	sw	a5,4(a4)
    return 0;
    5406:	4501                	li	a0,0
    5408:	8082                	ret
        return -1;
    540a:	557d                	li	a0,-1
}
    540c:	8082                	ret

000000000000540e <exit>:
{
    540e:	1101                	addi	sp,sp,-32
    5410:	e822                	sd	s0,16(sp)
    while (__atexit_func_count > 0)
    5412:	00004417          	auipc	s0,0x4
    5416:	92640413          	addi	s0,s0,-1754 # 8d38 <errno>
    541a:	405c                	lw	a5,4(s0)
{
    541c:	e426                	sd	s1,8(sp)
    541e:	ec06                	sd	ra,24(sp)
    5420:	84aa                	mv	s1,a0
    while (__atexit_func_count > 0)
    5422:	00f05d63          	blez	a5,543c <exit+0x2e>
        (__atexit_funcs[--__atexit_func_count])();
    5426:	fff7871b          	addiw	a4,a5,-1
    542a:	87ba                	mv	a5,a4
    542c:	070e                	slli	a4,a4,0x3
    542e:	9722                	add	a4,a4,s0
    5430:	6718                	ld	a4,8(a4)
    5432:	c05c                	sw	a5,4(s0)
    5434:	9702                	jalr	a4
    while (__atexit_func_count > 0)
    5436:	405c                	lw	a5,4(s0)
    5438:	fef047e3          	bgtz	a5,5426 <exit+0x18>
    sys_exit(status);
    543c:	8526                	mv	a0,s1
    543e:	c8bfb0ef          	jal	10c8 <sys_exit>
    while (1)
    5442:	a001                	j	5442 <exit+0x34>

0000000000005444 <abort>:
{
    5444:	1141                	addi	sp,sp,-16
    exit(127);
    5446:	07f00513          	li	a0,127
{
    544a:	e406                	sd	ra,8(sp)
    exit(127);
    544c:	fc3ff0ef          	jal	540e <exit>

0000000000005450 <getenv>:
}
    5450:	4501                	li	a0,0
    5452:	8082                	ret

0000000000005454 <system>:
}
    5454:	557d                	li	a0,-1
    5456:	8082                	ret

0000000000005458 <free>:
    if (!ptr)
    5458:	c121                	beqz	a0,5498 <free+0x40>
    for (p = freep; !(bp > p && bp < p->next); p = p->next)
    545a:	00004617          	auipc	a2,0x4
    545e:	8de60613          	addi	a2,a2,-1826 # 8d38 <errno>
    5462:	10863783          	ld	a5,264(a2)
    bp = (header_t *)ptr - 1;
    5466:	ff050693          	addi	a3,a0,-16
        if (p >= p->next && (bp > p || bp < p->next))
    546a:	6798                	ld	a4,8(a5)
    for (p = freep; !(bp > p && bp < p->next); p = p->next)
    546c:	02d7f763          	bgeu	a5,a3,549a <free+0x42>
    5470:	00e6e463          	bltu	a3,a4,5478 <free+0x20>
        if (p >= p->next && (bp > p || bp < p->next))
    5474:	02e7e763          	bltu	a5,a4,54a2 <free+0x4a>
    if ((char *)bp + bp->size == (char *)p->next)
    5478:	ff053583          	ld	a1,-16(a0)
    547c:	00b68833          	add	a6,a3,a1
    5480:	03070363          	beq	a4,a6,54a6 <free+0x4e>
    if ((char *)p + p->size == (char *)bp)
    5484:	638c                	ld	a1,0(a5)
    5486:	fee53c23          	sd	a4,-8(a0)
    548a:	00b78833          	add	a6,a5,a1
    548e:	03068963          	beq	a3,a6,54c0 <free+0x68>
    5492:	e794                	sd	a3,8(a5)
    freep = p;
    5494:	10f63423          	sd	a5,264(a2)
}
    5498:	8082                	ret
        if (p >= p->next && (bp > p || bp < p->next))
    549a:	00e7e463          	bltu	a5,a4,54a2 <free+0x4a>
    549e:	fce6ede3          	bltu	a3,a4,5478 <free+0x20>
{
    54a2:	87ba                	mv	a5,a4
    54a4:	b7d9                	j	546a <free+0x12>
        bp->size += p->next->size;
    54a6:	00073803          	ld	a6,0(a4)
        bp->next = p->next->next;
    54aa:	6718                	ld	a4,8(a4)
        bp->size += p->next->size;
    54ac:	95c2                	add	a1,a1,a6
    54ae:	feb53823          	sd	a1,-16(a0)
    if ((char *)p + p->size == (char *)bp)
    54b2:	638c                	ld	a1,0(a5)
    54b4:	fee53c23          	sd	a4,-8(a0)
    54b8:	00b78833          	add	a6,a5,a1
    54bc:	fd069be3          	bne	a3,a6,5492 <free+0x3a>
        p->size += bp->size;
    54c0:	ff053503          	ld	a0,-16(a0)
        p->next = bp->next;
    54c4:	86ba                	mv	a3,a4
        p->size += bp->size;
    54c6:	00b50733          	add	a4,a0,a1
    54ca:	e398                	sd	a4,0(a5)
        p->next = bp->next;
    54cc:	b7d9                	j	5492 <free+0x3a>

00000000000054ce <malloc>:
    if (size == 0)
    54ce:	c169                	beqz	a0,5590 <malloc+0xc2>
{
    54d0:	7179                	addi	sp,sp,-48
    54d2:	ec26                	sd	s1,24(sp)
    if ((prevp = freep) == NULL)
    54d4:	00004497          	auipc	s1,0x4
    54d8:	86448493          	addi	s1,s1,-1948 # 8d38 <errno>
    54dc:	1084b783          	ld	a5,264(s1)
{
    54e0:	f022                	sd	s0,32(sp)
    size = ALIGN(size + sizeof(header_t));
    54e2:	057d                	addi	a0,a0,31
{
    54e4:	f406                	sd	ra,40(sp)
    size = ALIGN(size + sizeof(header_t));
    54e6:	ff057413          	andi	s0,a0,-16
    if ((prevp = freep) == NULL)
    54ea:	c3d1                	beqz	a5,556e <malloc+0xa0>
    for (p = prevp->next;; prevp = p, p = p->next)
    54ec:	6788                	ld	a0,8(a5)
        if (p->size >= size)
    54ee:	6118                	ld	a4,0(a0)
    54f0:	06877163          	bgeu	a4,s0,5552 <malloc+0x84>
    54f4:	e44e                	sd	s3,8(sp)
    54f6:	e052                	sd	s4,0(sp)
    54f8:	e84a                	sd	s2,16(sp)
    if (nu < 4096)
    54fa:	6a05                	lui	s4,0x1
    if (cp == (void *)-1)
    54fc:	59fd                	li	s3,-1
    54fe:	a029                	j	5508 <malloc+0x3a>
    for (p = prevp->next;; prevp = p, p = p->next)
    5500:	6788                	ld	a0,8(a5)
        if (p->size >= size)
    5502:	6118                	ld	a4,0(a0)
    5504:	04877463          	bgeu	a4,s0,554c <malloc+0x7e>
        if (p == freep)
    5508:	1084b703          	ld	a4,264(s1)
    550c:	87aa                	mv	a5,a0
    550e:	fee519e3          	bne	a0,a4,5500 <malloc+0x32>
    if (nu < 4096)
    5512:	8922                	mv	s2,s0
    5514:	01447363          	bgeu	s0,s4,551a <malloc+0x4c>
    5518:	6905                	lui	s2,0x1
    cp = (char *)sbrk(nu);
    551a:	854a                	mv	a0,s2
    551c:	c3dfb0ef          	jal	1158 <sbrk>
    5520:	87aa                	mv	a5,a0
    free((void *)(up + 1));
    5522:	0541                	addi	a0,a0,16
    if (cp == (void *)-1)
    5524:	01378963          	beq	a5,s3,5536 <malloc+0x68>
    up->size = nu;
    5528:	0127b023          	sd	s2,0(a5)
    free((void *)(up + 1));
    552c:	f2dff0ef          	jal	5458 <free>
    return freep;
    5530:	1084b783          	ld	a5,264(s1)
            if ((p = morecore(size)) == NULL)
    5534:	f7f1                	bnez	a5,5500 <malloc+0x32>
}
    5536:	70a2                	ld	ra,40(sp)
    5538:	7402                	ld	s0,32(sp)
                errno = ENOMEM;
    553a:	47b1                	li	a5,12
    553c:	c09c                	sw	a5,0(s1)
                return NULL;
    553e:	6942                	ld	s2,16(sp)
    5540:	69a2                	ld	s3,8(sp)
    5542:	6a02                	ld	s4,0(sp)
}
    5544:	64e2                	ld	s1,24(sp)
        return NULL;
    5546:	4501                	li	a0,0
}
    5548:	6145                	addi	sp,sp,48
    554a:	8082                	ret
    554c:	6942                	ld	s2,16(sp)
    554e:	69a2                	ld	s3,8(sp)
    5550:	6a02                	ld	s4,0(sp)
            if (p->size == size)
    5552:	02e40c63          	beq	s0,a4,558a <malloc+0xbc>
                p->size -= size;
    5556:	8f01                	sub	a4,a4,s0
    5558:	e118                	sd	a4,0(a0)
                p = (header_t *)((char *)p + p->size);
    555a:	953a                	add	a0,a0,a4
                p->size = size;
    555c:	e100                	sd	s0,0(a0)
}
    555e:	70a2                	ld	ra,40(sp)
    5560:	7402                	ld	s0,32(sp)
            freep = prevp;
    5562:	10f4b423          	sd	a5,264(s1)
            return (void *)(p + 1);
    5566:	0541                	addi	a0,a0,16
}
    5568:	64e2                	ld	s1,24(sp)
    556a:	6145                	addi	sp,sp,48
    556c:	8082                	ret
        base.next = freep = prevp = &base;
    556e:	00004517          	auipc	a0,0x4
    5572:	8da50513          	addi	a0,a0,-1830 # 8e48 <base>
    5576:	10a4b423          	sd	a0,264(s1)
    557a:	10a4bc23          	sd	a0,280(s1)
        base.size = 0;
    557e:	00004797          	auipc	a5,0x4
    5582:	8c07b523          	sd	zero,-1846(a5) # 8e48 <base>
        if (p->size >= size)
    5586:	f43d                	bnez	s0,54f4 <malloc+0x26>
        base.next = freep = prevp = &base;
    5588:	87aa                	mv	a5,a0
                prevp->next = p->next;
    558a:	6518                	ld	a4,8(a0)
    558c:	e798                	sd	a4,8(a5)
    558e:	bfc1                	j	555e <malloc+0x90>
        return NULL;
    5590:	4501                	li	a0,0
}
    5592:	8082                	ret

0000000000005594 <calloc>:
    if (__builtin_mul_overflow(nmemb, size, &total))
    5594:	02b537b3          	mulhu	a5,a0,a1
{
    5598:	1101                	addi	sp,sp,-32
    559a:	e822                	sd	s0,16(sp)
    559c:	ec06                	sd	ra,24(sp)
    559e:	e426                	sd	s1,8(sp)
    if (__builtin_mul_overflow(nmemb, size, &total))
    55a0:	02b50433          	mul	s0,a0,a1
    55a4:	e385                	bnez	a5,55c4 <calloc+0x30>
    void *p = malloc(total);
    55a6:	8522                	mv	a0,s0
    55a8:	f27ff0ef          	jal	54ce <malloc>
    55ac:	84aa                	mv	s1,a0
    if (p)
    55ae:	c509                	beqz	a0,55b8 <calloc+0x24>
        memset(p, 0, total);
    55b0:	8622                	mv	a2,s0
    55b2:	4581                	li	a1,0
    55b4:	524000ef          	jal	5ad8 <memset>
}
    55b8:	60e2                	ld	ra,24(sp)
    55ba:	6442                	ld	s0,16(sp)
    55bc:	8526                	mv	a0,s1
    55be:	64a2                	ld	s1,8(sp)
    55c0:	6105                	addi	sp,sp,32
    55c2:	8082                	ret
    55c4:	60e2                	ld	ra,24(sp)
    55c6:	6442                	ld	s0,16(sp)
        errno = ENOMEM;
    55c8:	47b1                	li	a5,12
        return NULL;
    55ca:	4481                	li	s1,0
        errno = ENOMEM;
    55cc:	00003717          	auipc	a4,0x3
    55d0:	76f72623          	sw	a5,1900(a4) # 8d38 <errno>
}
    55d4:	8526                	mv	a0,s1
    55d6:	64a2                	ld	s1,8(sp)
    55d8:	6105                	addi	sp,sp,32
    55da:	8082                	ret

00000000000055dc <realloc>:
    if (!ptr)
    55dc:	c929                	beqz	a0,562e <realloc+0x52>
{
    55de:	1101                	addi	sp,sp,-32
    55e0:	ec06                	sd	ra,24(sp)
    55e2:	e426                	sd	s1,8(sp)
    if (size == 0)
    55e4:	c5b9                	beqz	a1,5632 <realloc+0x56>
    if (bp->size >= new_size)
    55e6:	ff053703          	ld	a4,-16(a0)
    size_t new_size = ALIGN(size + sizeof(header_t));
    55ea:	01f58793          	addi	a5,a1,31
    55ee:	e822                	sd	s0,16(sp)
    55f0:	9bc1                	andi	a5,a5,-16
    55f2:	842a                	mv	s0,a0
        return ptr;
    55f4:	84aa                	mv	s1,a0
    if (bp->size >= new_size)
    55f6:	00f76863          	bltu	a4,a5,5606 <realloc+0x2a>
    55fa:	6442                	ld	s0,16(sp)
}
    55fc:	60e2                	ld	ra,24(sp)
    55fe:	8526                	mv	a0,s1
    5600:	64a2                	ld	s1,8(sp)
    5602:	6105                	addi	sp,sp,32
    5604:	8082                	ret
    void *new_ptr = malloc(size);
    5606:	852e                	mv	a0,a1
    5608:	ec7ff0ef          	jal	54ce <malloc>
    560c:	84aa                	mv	s1,a0
    if (!new_ptr)
    560e:	d575                	beqz	a0,55fa <realloc+0x1e>
    memcpy(new_ptr, ptr, bp->size - sizeof(header_t));
    5610:	ff043603          	ld	a2,-16(s0)
    5614:	85a2                	mv	a1,s0
    5616:	1641                	addi	a2,a2,-16
    5618:	514000ef          	jal	5b2c <memcpy>
    free(ptr);
    561c:	8522                	mv	a0,s0
    561e:	e3bff0ef          	jal	5458 <free>
}
    5622:	60e2                	ld	ra,24(sp)
    free(ptr);
    5624:	6442                	ld	s0,16(sp)
}
    5626:	8526                	mv	a0,s1
    5628:	64a2                	ld	s1,8(sp)
    562a:	6105                	addi	sp,sp,32
    562c:	8082                	ret
        return malloc(size);
    562e:	852e                	mv	a0,a1
    5630:	bd79                	j	54ce <malloc>
        free(ptr);
    5632:	e27ff0ef          	jal	5458 <free>
        return NULL;
    5636:	4481                	li	s1,0
    5638:	b7d1                	j	55fc <realloc+0x20>

000000000000563a <strtoull>:
    if (base < 0 || base == 1 || base > 36)
    563a:	02400813          	li	a6,36
{
    563e:	86aa                	mv	a3,a0
    5640:	872e                	mv	a4,a1
    if (base < 0 || base == 1 || base > 36)
    5642:	00c86663          	bltu	a6,a2,564e <strtoull+0x14>
    5646:	4805                	li	a6,1
    5648:	01060363          	beq	a2,a6,564e <strtoull+0x14>
    564c:	b939                	j	526a <strtoull.part.0>
        if (endptr)
    564e:	c311                	beqz	a4,5652 <strtoull+0x18>
            *endptr = (char *)nptr;
    5650:	e314                	sd	a3,0(a4)
        errno = 0; /* EINVAL */
    5652:	00003797          	auipc	a5,0x3
    5656:	6e07a323          	sw	zero,1766(a5) # 8d38 <errno>
}
    565a:	4501                	li	a0,0
    565c:	8082                	ret

000000000000565e <strtoll>:

long long strtoll(const char *nptr, char **endptr, int base)
{
    565e:	1141                	addi	sp,sp,-16
    5660:	e406                	sd	ra,8(sp)
    5662:	e022                	sd	s0,0(sp)
    const char *s = nptr;
    5664:	86aa                	mv	a3,a0
    static inline int isspace(int c) { return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r'; }
    5666:	02000813          	li	a6,32
    566a:	4891                	li	a7,4
    unsigned long long acc;
    int c, neg = 0;

    do
    {
        c = *s++;
    566c:	0006c783          	lbu	a5,0(a3)
    5670:	0685                	addi	a3,a3,1
    5672:	ff77871b          	addiw	a4,a5,-9
    5676:	0ff77713          	zext.b	a4,a4
    567a:	0007841b          	sext.w	s0,a5
    567e:	ff0787e3          	beq	a5,a6,566c <strtoll+0xe>
    5682:	fee8f5e3          	bgeu	a7,a4,566c <strtoll+0xe>
    if (base < 0 || base == 1 || base > 36)
    5686:	02400793          	li	a5,36
    568a:	02c7ec63          	bltu	a5,a2,56c2 <strtoll+0x64>
    568e:	4785                	li	a5,1
    5690:	02f60963          	beq	a2,a5,56c2 <strtoll+0x64>
    5694:	bd7ff0ef          	jal	526a <strtoull.part.0>
    if (c == '-')
        neg = 1;

    acc = strtoull(nptr, endptr, base);

    if (errno == ERANGE && acc == ULLONG_MAX)
    5698:	00003797          	auipc	a5,0x3
    569c:	6a078793          	addi	a5,a5,1696 # 8d38 <errno>
    56a0:	4394                	lw	a3,0(a5)
    56a2:	02200713          	li	a4,34
    56a6:	04e68363          	beq	a3,a4,56ec <strtoll+0x8e>
        return neg ? LLONG_MIN : LLONG_MAX;

    if (!neg && acc > (unsigned long long)LLONG_MAX)
    56aa:	02d00713          	li	a4,45
    56ae:	02e40563          	beq	s0,a4,56d8 <strtoll+0x7a>
    56b2:	00055f63          	bgez	a0,56d0 <strtoll+0x72>
    {
        errno = ERANGE;
    56b6:	02200713          	li	a4,34
    56ba:	c398                	sw	a4,0(a5)
        return neg ? LLONG_MIN : LLONG_MAX;
    56bc:	557d                	li	a0,-1
    56be:	8105                	srli	a0,a0,0x1
    56c0:	a801                	j	56d0 <strtoll+0x72>
        if (endptr)
    56c2:	c191                	beqz	a1,56c6 <strtoll+0x68>
            *endptr = (char *)nptr;
    56c4:	e188                	sd	a0,0(a1)
        errno = 0; /* EINVAL */
    56c6:	00003797          	auipc	a5,0x3
    56ca:	6607a923          	sw	zero,1650(a5) # 8d38 <errno>
    {
        errno = ERANGE;
        return LLONG_MIN;
    }

    return neg ? -(long long)acc : (long long)acc;
    56ce:	4501                	li	a0,0
}
    56d0:	60a2                	ld	ra,8(sp)
    56d2:	6402                	ld	s0,0(sp)
    56d4:	0141                	addi	sp,sp,16
    56d6:	8082                	ret
    if (neg && acc > (unsigned long long)LLONG_MAX + 1)
    56d8:	577d                	li	a4,-1
    56da:	177e                	slli	a4,a4,0x3f
    56dc:	02a76263          	bltu	a4,a0,5700 <strtoll+0xa2>
}
    56e0:	60a2                	ld	ra,8(sp)
    56e2:	6402                	ld	s0,0(sp)
    return neg ? -(long long)acc : (long long)acc;
    56e4:	40a00533          	neg	a0,a0
}
    56e8:	0141                	addi	sp,sp,16
    56ea:	8082                	ret
    if (errno == ERANGE && acc == ULLONG_MAX)
    56ec:	577d                	li	a4,-1
    56ee:	fae51ee3          	bne	a0,a4,56aa <strtoll+0x4c>
        return neg ? LLONG_MIN : LLONG_MAX;
    56f2:	02d00793          	li	a5,45
    56f6:	fcf413e3          	bne	s0,a5,56bc <strtoll+0x5e>
        return LLONG_MIN;
    56fa:	557d                	li	a0,-1
    56fc:	157e                	slli	a0,a0,0x3f
    56fe:	bfc9                	j	56d0 <strtoll+0x72>
        errno = ERANGE;
    5700:	02200713          	li	a4,34
    5704:	c398                	sw	a4,0(a5)
        return LLONG_MIN;
    5706:	bfd5                	j	56fa <strtoll+0x9c>

0000000000005708 <strtoul>:
    if (base < 0 || base == 1 || base > 36)
    5708:	02400813          	li	a6,36

unsigned long strtoul(const char *nptr, char **endptr, int base)
{
    570c:	86aa                	mv	a3,a0
    570e:	872e                	mv	a4,a1
    if (base < 0 || base == 1 || base > 36)
    5710:	00c86663          	bltu	a6,a2,571c <strtoul+0x14>
    5714:	4805                	li	a6,1
    5716:	01060363          	beq	a2,a6,571c <strtoul+0x14>
    571a:	be81                	j	526a <strtoull.part.0>
        if (endptr)
    571c:	c311                	beqz	a4,5720 <strtoul+0x18>
            *endptr = (char *)nptr;
    571e:	e314                	sd	a3,0(a4)
        errno = 0; /* EINVAL */
    5720:	00003797          	auipc	a5,0x3
    5724:	6007ac23          	sw	zero,1560(a5) # 8d38 <errno>
    {
        errno = ERANGE;
        return ULONG_MAX;
    }
    return (unsigned long)ret;
}
    5728:	4501                	li	a0,0
    572a:	8082                	ret

000000000000572c <strtol>:

long strtol(const char *nptr, char **endptr, int base)
{
    long long ret = strtoll(nptr, endptr, base);
    572c:	bf0d                	j	565e <strtoll>

000000000000572e <atoi>:
        return LONG_MIN;
    }
    return (long)ret;
}

int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    572e:	1141                	addi	sp,sp,-16
    long long ret = strtoll(nptr, endptr, base);
    5730:	4629                	li	a2,10
    5732:	4581                	li	a1,0
int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    5734:	e406                	sd	ra,8(sp)
    long long ret = strtoll(nptr, endptr, base);
    5736:	f29ff0ef          	jal	565e <strtoll>
int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    573a:	60a2                	ld	ra,8(sp)
    573c:	2501                	sext.w	a0,a0
    573e:	0141                	addi	sp,sp,16
    5740:	8082                	ret

0000000000005742 <atol>:
    long long ret = strtoll(nptr, endptr, base);
    5742:	4629                	li	a2,10
    5744:	4581                	li	a1,0
    5746:	bf21                	j	565e <strtoll>

0000000000005748 <atoll>:
long atol(const char *nptr) { return strtol(nptr, NULL, 10); }
long long atoll(const char *nptr) { return strtoll(nptr, NULL, 10); }
    5748:	4629                	li	a2,10
    574a:	4581                	li	a1,0
    574c:	bf09                	j	565e <strtoll>

000000000000574e <strtod>:
    574e:	02000693          	li	a3,32
    5752:	4611                	li	a2,4
{
    double val = 0.0;
    int sign = 1;
    const char *s = nptr;

    while (isspace(*s))
    5754:	00054783          	lbu	a5,0(a0)
    5758:	ff77871b          	addiw	a4,a5,-9
    575c:	0ff77713          	zext.b	a4,a4
    5760:	06d78263          	beq	a5,a3,57c4 <strtod+0x76>
    5764:	06e67063          	bgeu	a2,a4,57c4 <strtod+0x76>
        s++;
    if (*s == '-')
    5768:	02d00713          	li	a4,45
    576c:	08e78e63          	beq	a5,a4,5808 <strtod+0xba>
    {
        sign = -1;
        s++;
    }
    else if (*s == '+')
    5770:	02b00713          	li	a4,43
    5774:	0ae78263          	beq	a5,a4,5818 <strtod+0xca>
    5778:	00001717          	auipc	a4,0x1
    577c:	20073507          	fld	fa0,512(a4) # 6978 <STDIN_FD+0x10>
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    5780:	fd07861b          	addiw	a2,a5,-48
        s++;

    while (isdigit(*s))
    5784:	46a5                	li	a3,9
    5786:	f20007d3          	fmv.d.x	fa5,zero
    578a:	8732                	mv	a4,a2
    578c:	02c6e363          	bltu	a3,a2,57b2 <strtod+0x64>
    5790:	00001797          	auipc	a5,0x1
    5794:	1f07b687          	fld	fa3,496(a5) # 6980 <STDIN_FD+0x18>
    5798:	4625                	li	a2,9
    579a:	00154783          	lbu	a5,1(a0)
    {
        val = val * 10.0 + (*s - '0');
    579e:	d2070753          	fcvt.d.w	fa4,a4
        s++;
    57a2:	0505                	addi	a0,a0,1
    57a4:	fd07869b          	addiw	a3,a5,-48
        val = val * 10.0 + (*s - '0');
    57a8:	72d7f7c3          	fmadd.d	fa5,fa5,fa3,fa4
    57ac:	8736                	mv	a4,a3
    while (isdigit(*s))
    57ae:	fed676e3          	bgeu	a2,a3,579a <strtod+0x4c>
    }
    if (*s == '.')
    57b2:	02e00713          	li	a4,46
    57b6:	00e78963          	beq	a5,a4,57c8 <strtod+0x7a>
            val += (*s - '0') * factor;
            s++;
        }
    }

    if (endptr)
    57ba:	c191                	beqz	a1,57be <strtod+0x70>
        *endptr = (char *)s;
    57bc:	e188                	sd	a0,0(a1)
    return val * sign;
}
    57be:	12a7f553          	fmul.d	fa0,fa5,fa0
    57c2:	8082                	ret
        s++;
    57c4:	0505                	addi	a0,a0,1
    57c6:	b779                	j	5754 <strtod+0x6>
        while (isdigit(*s))
    57c8:	00154703          	lbu	a4,1(a0)
    57cc:	46a5                	li	a3,9
        s++;
    57ce:	0505                	addi	a0,a0,1
    57d0:	fd07071b          	addiw	a4,a4,-48
    57d4:	87ba                	mv	a5,a4
        while (isdigit(*s))
    57d6:	fee6e2e3          	bltu	a3,a4,57ba <strtod+0x6c>
        double factor = 1.0;
    57da:	00001717          	auipc	a4,0x1
    57de:	19e73707          	fld	fa4,414(a4) # 6978 <STDIN_FD+0x10>
    57e2:	00001717          	auipc	a4,0x1
    57e6:	1b673607          	fld	fa2,438(a4) # 6998 <STDIN_FD+0x30>
            factor *= 0.1;
    57ea:	12c77753          	fmul.d	fa4,fa4,fa2
        while (isdigit(*s))
    57ee:	00154703          	lbu	a4,1(a0)
            val += (*s - '0') * factor;
    57f2:	d20786d3          	fcvt.d.w	fa3,a5
            s++;
    57f6:	0505                	addi	a0,a0,1
    57f8:	fd07071b          	addiw	a4,a4,-48
    57fc:	87ba                	mv	a5,a4
            val += (*s - '0') * factor;
    57fe:	7ae6f7c3          	fmadd.d	fa5,fa3,fa4,fa5
        while (isdigit(*s))
    5802:	fee6f4e3          	bgeu	a3,a4,57ea <strtod+0x9c>
    5806:	bf55                	j	57ba <strtod+0x6c>
    while (isdigit(*s))
    5808:	00154783          	lbu	a5,1(a0)
    580c:	00001717          	auipc	a4,0x1
    5810:	16473507          	fld	fa0,356(a4) # 6970 <STDIN_FD+0x8>
        s++;
    5814:	0505                	addi	a0,a0,1
    5816:	b7ad                	j	5780 <strtod+0x32>
    while (isdigit(*s))
    5818:	00154783          	lbu	a5,1(a0)
    581c:	00001717          	auipc	a4,0x1
    5820:	15c73507          	fld	fa0,348(a4) # 6978 <STDIN_FD+0x10>
        s++;
    5824:	0505                	addi	a0,a0,1
    5826:	bfa9                	j	5780 <strtod+0x32>

0000000000005828 <atof>:

double atof(const char *nptr) { return strtod(nptr, NULL); }
    5828:	4581                	li	a1,0
    582a:	b715                	j	574e <strtod>

000000000000582c <strtof>:
float strtof(const char *nptr, char **endptr) { return (float)strtod(nptr, endptr); }
    582c:	1141                	addi	sp,sp,-16
    582e:	e406                	sd	ra,8(sp)
    5830:	f1fff0ef          	jal	574e <strtod>
    5834:	60a2                	ld	ra,8(sp)
    5836:	40157553          	fcvt.s.d	fa0,fa0
    583a:	0141                	addi	sp,sp,16
    583c:	8082                	ret

000000000000583e <qsort>:
    }
}

void qsort(void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *))
{
    if (nmemb < 2 || size == 0)
    583e:	4785                	li	a5,1
    5840:	0cb7fd63          	bgeu	a5,a1,591a <qsort+0xdc>
{
    5844:	715d                	addi	sp,sp,-80
    5846:	f44e                	sd	s3,40(sp)
    5848:	e486                	sd	ra,72(sp)
    584a:	89b2                	mv	s3,a2
    if (nmemb < 2 || size == 0)
    584c:	c279                	beqz	a2,5912 <qsort+0xd4>
    584e:	e85a                	sd	s6,16(sp)
    5850:	8b2e                	mv	s6,a1
        return;

    char *base_ptr = (char *)base;
    char *pivot = base_ptr + (nmemb - 1) * size;
    5852:	1b7d                	addi	s6,s6,-1
    5854:	fc26                	sd	s1,56(sp)
    5856:	033b04b3          	mul	s1,s6,s3
    585a:	ec56                	sd	s5,24(sp)
    585c:	8aaa                	mv	s5,a0
    585e:	f052                	sd	s4,32(sp)
    5860:	e45e                	sd	s7,8(sp)
    5862:	e0a2                	sd	s0,64(sp)
    5864:	f84a                	sd	s2,48(sp)
    5866:	8a36                	mv	s4,a3
    if (nmemb < 2 || size == 0)
    5868:	4b85                	li	s7,1
    char *pivot = base_ptr + (nmemb - 1) * size;
    586a:	94d6                	add	s1,s1,s5
    char *i = base_ptr;
    char *j = base_ptr;

    /* Partition */
    for (; j < pivot; j += size)
    586c:	069af763          	bgeu	s5,s1,58da <qsort+0x9c>
    char *j = base_ptr;
    5870:	8956                	mv	s2,s5
    char *i = base_ptr;
    5872:	8456                	mv	s0,s5
    5874:	a021                	j	587c <qsort+0x3e>
    for (; j < pivot; j += size)
    5876:	994e                	add	s2,s2,s3
    5878:	00997f63          	bgeu	s2,s1,5896 <qsort+0x58>
    {
        if (compar(j, pivot) < 0)
    587c:	85a6                	mv	a1,s1
    587e:	854a                	mv	a0,s2
    5880:	9a02                	jalr	s4
    5882:	fe055ae3          	bgez	a0,5876 <qsort+0x38>
        {
            if (i != j)
    5886:	05241d63          	bne	s0,s2,58e0 <qsort+0xa2>
    588a:	01390633          	add	a2,s2,s3
                swap_bytes(i, j, size);
            i += size;
    588e:	8432                	mv	s0,a2
    for (; j < pivot; j += size)
    5890:	994e                	add	s2,s2,s3
    5892:	fe9965e3          	bltu	s2,s1,587c <qsort+0x3e>
        }
    }
    swap_bytes(i, pivot, size);

    /* Recurse */
    size_t left_count = (i - base_ptr) / size;
    5896:	415405b3          	sub	a1,s0,s5
    589a:	0335d5b3          	divu	a1,a1,s3
    qsort(base, left_count, size, compar);
    qsort(i + size, nmemb - left_count - 1, size, compar);
    589e:	40bb0b33          	sub	s6,s6,a1
    while (size--)
    58a2:	013406b3          	add	a3,s0,s3
        *a++ = *b;
    58a6:	0004c703          	lbu	a4,0(s1)
        temp = *a;
    58aa:	00044783          	lbu	a5,0(s0)
        *b++ = temp;
    58ae:	0485                	addi	s1,s1,1
        *a++ = *b;
    58b0:	0405                	addi	s0,s0,1
    58b2:	fee40fa3          	sb	a4,-1(s0)
        *b++ = temp;
    58b6:	fef48fa3          	sb	a5,-1(s1)
    while (size--)
    58ba:	fed416e3          	bne	s0,a3,58a6 <qsort+0x68>
    qsort(base, left_count, size, compar);
    58be:	86d2                	mv	a3,s4
    58c0:	864e                	mv	a2,s3
    58c2:	8556                	mv	a0,s5
    58c4:	f7bff0ef          	jal	583e <qsort>
    if (nmemb < 2 || size == 0)
    58c8:	036bfe63          	bgeu	s7,s6,5904 <qsort+0xc6>
    char *pivot = base_ptr + (nmemb - 1) * size;
    58cc:	1b7d                	addi	s6,s6,-1
    58ce:	033b04b3          	mul	s1,s6,s3
    58d2:	8aa2                	mv	s5,s0
    58d4:	94d6                	add	s1,s1,s5
    for (; j < pivot; j += size)
    58d6:	f89aede3          	bltu	s5,s1,5870 <qsort+0x32>
    char *i = base_ptr;
    58da:	8456                	mv	s0,s5
    for (; j < pivot; j += size)
    58dc:	4581                	li	a1,0
    58de:	b7d1                	j	58a2 <qsort+0x64>
    58e0:	01340633          	add	a2,s0,s3
            if (i != j)
    58e4:	874a                	mv	a4,s2
    58e6:	87a2                	mv	a5,s0
        *a++ = *b;
    58e8:	00074683          	lbu	a3,0(a4)
        temp = *a;
    58ec:	0007c803          	lbu	a6,0(a5)
        *b++ = temp;
    58f0:	0705                	addi	a4,a4,1
        *a++ = *b;
    58f2:	0785                	addi	a5,a5,1
    58f4:	fed78fa3          	sb	a3,-1(a5)
        *b++ = temp;
    58f8:	ff070fa3          	sb	a6,-1(a4)
    while (size--)
    58fc:	fec796e3          	bne	a5,a2,58e8 <qsort+0xaa>
            i += size;
    5900:	8432                	mv	s0,a2
    5902:	b779                	j	5890 <qsort+0x52>
    5904:	6406                	ld	s0,64(sp)
    5906:	74e2                	ld	s1,56(sp)
    5908:	7942                	ld	s2,48(sp)
    590a:	7a02                	ld	s4,32(sp)
    590c:	6ae2                	ld	s5,24(sp)
    590e:	6b42                	ld	s6,16(sp)
    5910:	6ba2                	ld	s7,8(sp)
}
    5912:	60a6                	ld	ra,72(sp)
    5914:	79a2                	ld	s3,40(sp)
    5916:	6161                	addi	sp,sp,80
    5918:	8082                	ret
    591a:	8082                	ret

000000000000591c <bsearch>:

void *bsearch(const void *key, const void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *))
{
    591c:	715d                	addi	sp,sp,-80
    591e:	e486                	sd	ra,72(sp)
    5920:	fc26                	sd	s1,56(sp)
    size_t l = 0, u = nmemb;
    while (l < u)
    5922:	c629                	beqz	a2,596c <bsearch+0x50>
    5924:	f84a                	sd	s2,48(sp)
    5926:	f44e                	sd	s3,40(sp)
    5928:	f052                	sd	s4,32(sp)
    592a:	ec56                	sd	s5,24(sp)
    592c:	e85a                	sd	s6,16(sp)
    592e:	e45e                	sd	s7,8(sp)
    5930:	e0a2                	sd	s0,64(sp)
    5932:	8932                	mv	s2,a2
    5934:	8a2a                	mv	s4,a0
    5936:	8aae                	mv	s5,a1
    5938:	8b36                	mv	s6,a3
    593a:	8bba                	mv	s7,a4
    size_t l = 0, u = nmemb;
    593c:	4981                	li	s3,0
    {
        size_t idx = (l + u) / 2;
    593e:	01298433          	add	s0,s3,s2
    5942:	8005                	srli	s0,s0,0x1
        const void *p = (void *)((const char *)base + (idx * size));
    5944:	036404b3          	mul	s1,s0,s6
        int cmp = compar(key, p);
    5948:	8552                	mv	a0,s4
        const void *p = (void *)((const char *)base + (idx * size));
    594a:	94d6                	add	s1,s1,s5
        int cmp = compar(key, p);
    594c:	85a6                	mv	a1,s1
    594e:	9b82                	jalr	s7
        if (cmp < 0)
    5950:	02054463          	bltz	a0,5978 <bsearch+0x5c>
            u = idx;
        else if (cmp > 0)
    5954:	c515                	beqz	a0,5980 <bsearch+0x64>
            l = idx + 1;
    5956:	00140993          	addi	s3,s0,1
    while (l < u)
    595a:	ff29e2e3          	bltu	s3,s2,593e <bsearch+0x22>
    595e:	6406                	ld	s0,64(sp)
    5960:	7942                	ld	s2,48(sp)
    5962:	79a2                	ld	s3,40(sp)
    5964:	7a02                	ld	s4,32(sp)
    5966:	6ae2                	ld	s5,24(sp)
    5968:	6b42                	ld	s6,16(sp)
    596a:	6ba2                	ld	s7,8(sp)
        else
            return (void *)p;
    }
    return NULL;
}
    596c:	60a6                	ld	ra,72(sp)
    return NULL;
    596e:	4481                	li	s1,0
}
    5970:	8526                	mv	a0,s1
    5972:	74e2                	ld	s1,56(sp)
    5974:	6161                	addi	sp,sp,80
    5976:	8082                	ret
            u = idx;
    5978:	8922                	mv	s2,s0
    while (l < u)
    597a:	fd29e2e3          	bltu	s3,s2,593e <bsearch+0x22>
    597e:	b7c5                	j	595e <bsearch+0x42>
    5980:	6406                	ld	s0,64(sp)
}
    5982:	60a6                	ld	ra,72(sp)
    5984:	7942                	ld	s2,48(sp)
    5986:	79a2                	ld	s3,40(sp)
    5988:	7a02                	ld	s4,32(sp)
    598a:	6ae2                	ld	s5,24(sp)
    598c:	6b42                	ld	s6,16(sp)
    598e:	6ba2                	ld	s7,8(sp)
    5990:	8526                	mv	a0,s1
    5992:	74e2                	ld	s1,56(sp)
    5994:	6161                	addi	sp,sp,80
    5996:	8082                	ret

0000000000005998 <abs>:

/* Math & Mics */

int abs(int j) { return (j < 0) ? -j : j; }
    5998:	41f5579b          	sraiw	a5,a0,0x1f
    599c:	8d3d                	xor	a0,a0,a5
    599e:	9d1d                	subw	a0,a0,a5
    59a0:	8082                	ret

00000000000059a2 <labs>:
long labs(long j) { return (j < 0) ? -j : j; }
    59a2:	43f55793          	srai	a5,a0,0x3f
    59a6:	8d3d                	xor	a0,a0,a5
    59a8:	8d1d                	sub	a0,a0,a5
    59aa:	8082                	ret

00000000000059ac <llabs>:
long long llabs(long long j) { return (j < 0) ? -j : j; }
    59ac:	43f55793          	srai	a5,a0,0x3f
    59b0:	8d3d                	xor	a0,a0,a5
    59b2:	8d1d                	sub	a0,a0,a5
    59b4:	8082                	ret

00000000000059b6 <div>:

div_t div(int numer, int denom)
{
    div_t res = {numer / denom, numer % denom};
    59b6:	02b547bb          	divw	a5,a0,a1
{
    59ba:	1141                	addi	sp,sp,-16
    return res;
}
    59bc:	0141                	addi	sp,sp,16
    div_t res = {numer / denom, numer % denom};
    59be:	02b5653b          	remw	a0,a0,a1
    return res;
    59c2:	1782                	slli	a5,a5,0x20
    59c4:	9381                	srli	a5,a5,0x20
    59c6:	1502                	slli	a0,a0,0x20
}
    59c8:	8d5d                	or	a0,a0,a5
    59ca:	8082                	ret

00000000000059cc <ldiv>:
ldiv_t ldiv(long numer, long denom)
{
    59cc:	1141                	addi	sp,sp,-16
    59ce:	87aa                	mv	a5,a0
    ldiv_t res = {numer / denom, numer % denom};
    return res;
}
    59d0:	02b54533          	div	a0,a0,a1
    59d4:	0141                	addi	sp,sp,16
    59d6:	02b7e5b3          	rem	a1,a5,a1
    59da:	8082                	ret

00000000000059dc <lldiv>:
lldiv_t lldiv(long long numer, long long denom)
{
    59dc:	1141                	addi	sp,sp,-16
    59de:	87aa                	mv	a5,a0
    lldiv_t res = {numer / denom, numer % denom};
    return res;
}
    59e0:	02b54533          	div	a0,a0,a1
    59e4:	0141                	addi	sp,sp,16
    59e6:	02b7e5b3          	rem	a1,a5,a1
    59ea:	8082                	ret

00000000000059ec <rand>:

static unsigned long next = 1;
int rand(void)
{
    next = next * 1103515245 + 12345;
    59ec:	00003697          	auipc	a3,0x3
    59f0:	2a468693          	addi	a3,a3,676 # 8c90 <next>
    59f4:	629c                	ld	a5,0(a3)
    59f6:	41c65737          	lui	a4,0x41c65
    59fa:	e6d70713          	addi	a4,a4,-403 # 41c64e6d <_ZSt4cerr+0x41c5bffd>
    59fe:	02e787b3          	mul	a5,a5,a4
    5a02:	670d                	lui	a4,0x3
    5a04:	03970713          	addi	a4,a4,57 # 3039 <stbsp_vsprintfcb+0xd6b>
    5a08:	97ba                	add	a5,a5,a4
    return (unsigned int)(next / 65536) % 32768;
    5a0a:	02179513          	slli	a0,a5,0x21
    next = next * 1103515245 + 12345;
    5a0e:	e29c                	sd	a5,0(a3)
}
    5a10:	9145                	srli	a0,a0,0x31
    5a12:	8082                	ret

0000000000005a14 <srand>:
void srand(unsigned int seed) { next = seed; }
    5a14:	1502                	slli	a0,a0,0x20
    5a16:	9101                	srli	a0,a0,0x20
    5a18:	00003797          	auipc	a5,0x3
    5a1c:	26a7bc23          	sd	a0,632(a5) # 8c90 <next>
    5a20:	8082                	ret

0000000000005a22 <mblen>:

/* Stub */
int mblen(const char *s, size_t n) { return (s && *s && n) ? 1 : 0; }
    5a22:	c901                	beqz	a0,5a32 <mblen+0x10>
    5a24:	00054783          	lbu	a5,0(a0)
    5a28:	4501                	li	a0,0
    5a2a:	c789                	beqz	a5,5a34 <mblen+0x12>
    5a2c:	00b03533          	snez	a0,a1
    5a30:	8082                	ret
    5a32:	4501                	li	a0,0
    5a34:	8082                	ret

0000000000005a36 <mbtowc>:
int mbtowc(wchar_t *pwc, const char *s, size_t n)
{
    5a36:	87aa                	mv	a5,a0
    if (!s)
    5a38:	cd81                	beqz	a1,5a50 <mbtowc+0x1a>
        return 0;
    if (n == 0)
        return -1;
    5a3a:	557d                	li	a0,-1
    if (n == 0)
    5a3c:	ca19                	beqz	a2,5a52 <mbtowc+0x1c>
    if (pwc)
    5a3e:	c781                	beqz	a5,5a46 <mbtowc+0x10>
        *pwc = (wchar_t)*s;
    5a40:	0005c703          	lbu	a4,0(a1)
    5a44:	c398                	sw	a4,0(a5)
    return (*s != 0);
    5a46:	0005c503          	lbu	a0,0(a1)
    5a4a:	00a03533          	snez	a0,a0
    5a4e:	8082                	ret
        return 0;
    5a50:	4501                	li	a0,0
}
    5a52:	8082                	ret

0000000000005a54 <wctomb>:
int wctomb(char *s, wchar_t wchar)
{
    if (!s)
    5a54:	c509                	beqz	a0,5a5e <wctomb+0xa>
        return 0;
    *s = (char)wchar;
    5a56:	00b50023          	sb	a1,0(a0)
    return 1;
    5a5a:	4505                	li	a0,1
    5a5c:	8082                	ret
        return 0;
    5a5e:	4501                	li	a0,0
}
    5a60:	8082                	ret

0000000000005a62 <mbstowcs>:
size_t mbstowcs(wchar_t *dest, const char *src, size_t n)
{
    size_t i = 0;
    while (src[i] && i < n)
    5a62:	0005c703          	lbu	a4,0(a1)
    5a66:	cb0d                	beqz	a4,5a98 <mbstowcs+0x36>
    5a68:	ca15                	beqz	a2,5a9c <mbstowcs+0x3a>
    5a6a:	86aa                	mv	a3,a0
    size_t i = 0;
    5a6c:	4781                	li	a5,0
    5a6e:	a019                	j	5a74 <mbstowcs+0x12>
    while (src[i] && i < n)
    5a70:	02f60263          	beq	a2,a5,5a94 <mbstowcs+0x32>
    {
        dest[i] = (wchar_t)src[i];
        i++;
    5a74:	0785                	addi	a5,a5,1
        dest[i] = (wchar_t)src[i];
    5a76:	c298                	sw	a4,0(a3)
    while (src[i] && i < n)
    5a78:	00f58733          	add	a4,a1,a5
    5a7c:	00074703          	lbu	a4,0(a4)
    5a80:	0691                	addi	a3,a3,4
    5a82:	f77d                	bnez	a4,5a70 <mbstowcs+0xe>
    }
    if (i < n)
    5a84:	00c7f763          	bgeu	a5,a2,5a92 <mbstowcs+0x30>
        dest[i] = 0;
    5a88:	00279713          	slli	a4,a5,0x2
    5a8c:	953a                	add	a0,a0,a4
    5a8e:	00052023          	sw	zero,0(a0)
    size_t i = 0;
    5a92:	863e                	mv	a2,a5
    5a94:	8532                	mv	a0,a2
    5a96:	8082                	ret
    5a98:	4781                	li	a5,0
    5a9a:	b7ed                	j	5a84 <mbstowcs+0x22>
    5a9c:	4501                	li	a0,0
    return i;
}
    5a9e:	8082                	ret

0000000000005aa0 <wcstombs>:
size_t wcstombs(char *dest, const wchar_t *src, size_t n)
{
    size_t i = 0;
    while (src[i] && i < n)
    5aa0:	4198                	lw	a4,0(a1)
    5aa2:	c71d                	beqz	a4,5ad0 <wcstombs+0x30>
    5aa4:	ca05                	beqz	a2,5ad4 <wcstombs+0x34>
    5aa6:	0591                	addi	a1,a1,4
    size_t i = 0;
    5aa8:	4781                	li	a5,0
    5aaa:	a019                	j	5ab0 <wcstombs+0x10>
    while (src[i] && i < n)
    5aac:	02f60063          	beq	a2,a5,5acc <wcstombs+0x2c>
    {
        dest[i] = (char)src[i];
    5ab0:	00f506b3          	add	a3,a0,a5
    5ab4:	00e68023          	sb	a4,0(a3)
    while (src[i] && i < n)
    5ab8:	4198                	lw	a4,0(a1)
        i++;
    5aba:	0785                	addi	a5,a5,1
    while (src[i] && i < n)
    5abc:	0591                	addi	a1,a1,4
    5abe:	f77d                	bnez	a4,5aac <wcstombs+0xc>
    }
    if (i < n)
    5ac0:	00c7f563          	bgeu	a5,a2,5aca <wcstombs+0x2a>
        dest[i] = 0;
    5ac4:	953e                	add	a0,a0,a5
    5ac6:	00050023          	sb	zero,0(a0)
    size_t i = 0;
    5aca:	863e                	mv	a2,a5
    5acc:	8532                	mv	a0,a2
    5ace:	8082                	ret
    5ad0:	4781                	li	a5,0
    5ad2:	b7fd                	j	5ac0 <wcstombs+0x20>
    5ad4:	4501                	li	a0,0
    return i;
    5ad6:	8082                	ret

0000000000005ad8 <memset>:

void *memset(void *dst, int c, size_t n)
{
    char *cdst = (char *)dst;
    for (size_t i = 0; i < n; i++)
        cdst[i] = (char)c;
    5ad8:	0ff5f593          	zext.b	a1,a1
    5adc:	87aa                	mv	a5,a0
    5ade:	00a60733          	add	a4,a2,a0
    for (size_t i = 0; i < n; i++)
    5ae2:	c611                	beqz	a2,5aee <memset+0x16>
        cdst[i] = (char)c;
    5ae4:	00b78023          	sb	a1,0(a5)
    for (size_t i = 0; i < n; i++)
    5ae8:	0785                	addi	a5,a5,1
    5aea:	fee79de3          	bne	a5,a4,5ae4 <memset+0xc>
    return dst;
}
    5aee:	8082                	ret

0000000000005af0 <memmove>:

void *memmove(void *vdst, const void *vsrc, size_t n)
{
    char *dst = (char *)vdst;
    const char *src = (const char *)vsrc;
    if (dst == src)
    5af0:	02b50d63          	beq	a0,a1,5b2a <memmove+0x3a>
        return vdst;

    if (src > dst)
    5af4:	00b57e63          	bgeu	a0,a1,5b10 <memmove+0x20>
    {
        while (n--)
    5af8:	ca0d                	beqz	a2,5b2a <memmove+0x3a>
    5afa:	962a                	add	a2,a2,a0
    char *dst = (char *)vdst;
    5afc:	87aa                	mv	a5,a0
            *dst++ = *src++;
    5afe:	0005c703          	lbu	a4,0(a1)
    5b02:	0785                	addi	a5,a5,1
    5b04:	0585                	addi	a1,a1,1
    5b06:	fee78fa3          	sb	a4,-1(a5)
        while (n--)
    5b0a:	fec79ae3          	bne	a5,a2,5afe <memmove+0xe>
    5b0e:	8082                	ret
    }
    else
    {
        dst += n;
    5b10:	00c50733          	add	a4,a0,a2
        src += n;
    5b14:	00c587b3          	add	a5,a1,a2
        while (n-- > 0)
    5b18:	ca09                	beqz	a2,5b2a <memmove+0x3a>
            *--dst = *--src;
    5b1a:	fff7c683          	lbu	a3,-1(a5)
    5b1e:	17fd                	addi	a5,a5,-1
    5b20:	177d                	addi	a4,a4,-1
    5b22:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
    5b26:	fef59ae3          	bne	a1,a5,5b1a <memmove+0x2a>
    }
    return vdst;
}
    5b2a:	8082                	ret

0000000000005b2c <memcpy>:

void *memcpy(void *vdst, const void *vsrc, size_t n)
{
    return memmove(vdst, vsrc, n);
    5b2c:	b7d1                	j	5af0 <memmove>

0000000000005b2e <memcmp>:

int memcmp(const void *s1, const void *s2, size_t n)
{
    const unsigned char *p1 = (const unsigned char *)s1;
    const unsigned char *p2 = (const unsigned char *)s2;
    while (n--)
    5b2e:	c205                	beqz	a2,5b4e <memcmp+0x20>
    5b30:	962a                	add	a2,a2,a0
    5b32:	a019                	j	5b38 <memcmp+0xa>
    5b34:	00c50d63          	beq	a0,a2,5b4e <memcmp+0x20>
    {
        if (*p1 != *p2)
    5b38:	00054783          	lbu	a5,0(a0)
    5b3c:	0005c703          	lbu	a4,0(a1)
            return *p1 - *p2;
        p1++;
    5b40:	0505                	addi	a0,a0,1
        p2++;
    5b42:	0585                	addi	a1,a1,1
        if (*p1 != *p2)
    5b44:	fee788e3          	beq	a5,a4,5b34 <memcmp+0x6>
            return *p1 - *p2;
    5b48:	40e7853b          	subw	a0,a5,a4
    5b4c:	8082                	ret
    }
    return 0;
    5b4e:	4501                	li	a0,0
}
    5b50:	8082                	ret

0000000000005b52 <memchr>:

void *memchr(const void *s, int c, size_t n)
{
    const unsigned char *p = (const unsigned char *)s;
    while (n--)
    5b52:	ce09                	beqz	a2,5b6c <memchr+0x1a>
    {
        if (*p == (unsigned char)c)
    5b54:	0ff5f593          	zext.b	a1,a1
    5b58:	962a                	add	a2,a2,a0
    5b5a:	a021                	j	5b62 <memchr+0x10>
            return (void *)p;
        p++;
    5b5c:	0505                	addi	a0,a0,1
    while (n--)
    5b5e:	00a60763          	beq	a2,a0,5b6c <memchr+0x1a>
        if (*p == (unsigned char)c)
    5b62:	00054783          	lbu	a5,0(a0)
    5b66:	feb79be3          	bne	a5,a1,5b5c <memchr+0xa>
    }
    return NULL;
}
    5b6a:	8082                	ret
    return NULL;
    5b6c:	4501                	li	a0,0
}
    5b6e:	8082                	ret

0000000000005b70 <strlen>:
/* String Manipulation Functions  */

size_t strlen(const char *s)
{
    const char *p = s;
    while (*p)
    5b70:	00054783          	lbu	a5,0(a0)
    5b74:	cb89                	beqz	a5,5b86 <strlen+0x16>
    const char *p = s;
    5b76:	87aa                	mv	a5,a0
    while (*p)
    5b78:	0017c703          	lbu	a4,1(a5)
        p++;
    5b7c:	0785                	addi	a5,a5,1
    while (*p)
    5b7e:	ff6d                	bnez	a4,5b78 <strlen+0x8>
    return (size_t)(p - s);
    5b80:	40a78533          	sub	a0,a5,a0
    5b84:	8082                	ret
    while (*p)
    5b86:	4501                	li	a0,0
}
    5b88:	8082                	ret

0000000000005b8a <strcpy>:

char *strcpy(char *dst, const char *src)
{
    char *os = dst;
    while ((*dst++ = *src++) != 0)
    5b8a:	87aa                	mv	a5,a0
    5b8c:	0005c703          	lbu	a4,0(a1)
    5b90:	0785                	addi	a5,a5,1
    5b92:	0585                	addi	a1,a1,1
    5b94:	fee78fa3          	sb	a4,-1(a5)
    5b98:	fb75                	bnez	a4,5b8c <strcpy+0x2>
        ;
    return os;
}
    5b9a:	8082                	ret

0000000000005b9c <strncpy>:
char *strncpy(char *dst, const char *src, size_t n)
{
    char *os = dst;
    size_t i;

    for (i = 0; i < n && src[i] != '\0'; i++)
    5b9c:	4781                	li	a5,0
    5b9e:	e619                	bnez	a2,5bac <strncpy+0x10>
    5ba0:	8082                	ret
        dst[i] = src[i];
    5ba2:	00e68023          	sb	a4,0(a3)
    for (i = 0; i < n && src[i] != '\0'; i++)
    5ba6:	0785                	addi	a5,a5,1
    5ba8:	02f60263          	beq	a2,a5,5bcc <strncpy+0x30>
    5bac:	00f58733          	add	a4,a1,a5
    5bb0:	00074703          	lbu	a4,0(a4)
        dst[i] = src[i];
    5bb4:	00f506b3          	add	a3,a0,a5
    for (i = 0; i < n && src[i] != '\0'; i++)
    5bb8:	f76d                	bnez	a4,5ba2 <strncpy+0x6>

    for (; i < n; i++)
    5bba:	00c7f963          	bgeu	a5,a2,5bcc <strncpy+0x30>
    5bbe:	87b6                	mv	a5,a3
    5bc0:	962a                	add	a2,a2,a0
        dst[i] = '\0';
    5bc2:	00078023          	sb	zero,0(a5)
    for (; i < n; i++)
    5bc6:	0785                	addi	a5,a5,1
    5bc8:	fec79de3          	bne	a5,a2,5bc2 <strncpy+0x26>

    return os;
}
    5bcc:	8082                	ret

0000000000005bce <strcat>:

char *strcat(char *dst, const char *src)
{
    char *os = dst;
    while (*dst)
    5bce:	00054783          	lbu	a5,0(a0)
    5bd2:	cf91                	beqz	a5,5bee <strcat+0x20>
    5bd4:	87aa                	mv	a5,a0
    5bd6:	0017c703          	lbu	a4,1(a5)
        dst++;
    5bda:	0785                	addi	a5,a5,1
    while (*dst)
    5bdc:	ff6d                	bnez	a4,5bd6 <strcat+0x8>
    while ((*dst++ = *src++) != 0)
    5bde:	0005c703          	lbu	a4,0(a1)
    5be2:	0785                	addi	a5,a5,1
    5be4:	0585                	addi	a1,a1,1
    5be6:	fee78fa3          	sb	a4,-1(a5)
    5bea:	fb75                	bnez	a4,5bde <strcat+0x10>
        ;
    return os;
}
    5bec:	8082                	ret
    while ((*dst++ = *src++) != 0)
    5bee:	0005c703          	lbu	a4,0(a1)
    while (*dst)
    5bf2:	87aa                	mv	a5,a0
    while ((*dst++ = *src++) != 0)
    5bf4:	0785                	addi	a5,a5,1
    5bf6:	fee78fa3          	sb	a4,-1(a5)
    5bfa:	0585                	addi	a1,a1,1
    5bfc:	f36d                	bnez	a4,5bde <strcat+0x10>
    5bfe:	8082                	ret

0000000000005c00 <strncat>:
    while (*p)
    5c00:	00054783          	lbu	a5,0(a0)
    const char *p = s;
    5c04:	872a                	mv	a4,a0
    while (*p)
    5c06:	c789                	beqz	a5,5c10 <strncat+0x10>
    5c08:	00174783          	lbu	a5,1(a4)
        p++;
    5c0c:	0705                	addi	a4,a4,1
    while (*p)
    5c0e:	ffed                	bnez	a5,5c08 <strncat+0x8>
    size_t dest_len = strlen(dst);
    size_t i;

    dst += dest_len;

    for (i = 0; i < n && src[i] != '\0'; i++)
    5c10:	86ba                	mv	a3,a4
    5c12:	4781                	li	a5,0
    5c14:	88ba                	mv	a7,a4
    5c16:	ea01                	bnez	a2,5c26 <strncat+0x26>
    5c18:	a839                	j	5c36 <strncat+0x36>
        dst[i] = src[i];
    5c1a:	01068023          	sb	a6,0(a3)
    for (i = 0; i < n && src[i] != '\0'; i++)
    5c1e:	00188693          	addi	a3,a7,1
    5c22:	00f60d63          	beq	a2,a5,5c3c <strncat+0x3c>
    5c26:	00f58833          	add	a6,a1,a5
    5c2a:	00084803          	lbu	a6,0(a6)
    5c2e:	0785                	addi	a5,a5,1
        dst[i] = src[i];
    5c30:	88b6                	mv	a7,a3
    for (i = 0; i < n && src[i] != '\0'; i++)
    5c32:	fe0814e3          	bnez	a6,5c1a <strncat+0x1a>

    dst[i] = '\0';
    5c36:	00088023          	sb	zero,0(a7)

    return os;
}
    5c3a:	8082                	ret
    dst[i] = '\0';
    5c3c:	00c708b3          	add	a7,a4,a2
    5c40:	00088023          	sb	zero,0(a7)
}
    5c44:	8082                	ret

0000000000005c46 <strcmp>:

int strcmp(const char *p, const char *q)
{
    while (*p && *p == *q)
    5c46:	00054783          	lbu	a5,0(a0)
    5c4a:	e791                	bnez	a5,5c56 <strcmp+0x10>
    5c4c:	a02d                	j	5c76 <strcmp+0x30>
    5c4e:	00054783          	lbu	a5,0(a0)
    5c52:	cf89                	beqz	a5,5c6c <strcmp+0x26>
    5c54:	85b6                	mv	a1,a3
    5c56:	0005c703          	lbu	a4,0(a1)
    {
        p++;
    5c5a:	0505                	addi	a0,a0,1
        q++;
    5c5c:	00158693          	addi	a3,a1,1
    while (*p && *p == *q)
    5c60:	fef707e3          	beq	a4,a5,5c4e <strcmp+0x8>
    }
    return (int)((unsigned char)*p - (unsigned char)*q);
    5c64:	0007851b          	sext.w	a0,a5
}
    5c68:	9d19                	subw	a0,a0,a4
    5c6a:	8082                	ret
    return (int)((unsigned char)*p - (unsigned char)*q);
    5c6c:	0015c703          	lbu	a4,1(a1)
    5c70:	4501                	li	a0,0
}
    5c72:	9d19                	subw	a0,a0,a4
    5c74:	8082                	ret
    return (int)((unsigned char)*p - (unsigned char)*q);
    5c76:	0005c703          	lbu	a4,0(a1)
    5c7a:	4501                	li	a0,0
    5c7c:	b7f5                	j	5c68 <strcmp+0x22>

0000000000005c7e <strncmp>:

int strncmp(const char *s1, const char *s2, size_t n)
{
    if (n == 0)
    5c7e:	ca0d                	beqz	a2,5cb0 <strncmp+0x32>
        return 0;

    while (n-- > 0 && *s1 && *s1 == *s2)
    5c80:	00054783          	lbu	a5,0(a0)
    5c84:	167d                	addi	a2,a2,-1
    5c86:	00c506b3          	add	a3,a0,a2
    5c8a:	eb89                	bnez	a5,5c9c <strncmp+0x1e>
    5c8c:	a80d                	j	5cbe <strncmp+0x40>
    {
        if (n == 0 || *s1 == '\0')
    5c8e:	00d50d63          	beq	a0,a3,5ca8 <strncmp+0x2a>
    while (n-- > 0 && *s1 && *s1 == *s2)
    5c92:	00154783          	lbu	a5,1(a0)
            break;
        s1++;
    5c96:	0505                	addi	a0,a0,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    5c98:	cf91                	beqz	a5,5cb4 <strncmp+0x36>
    5c9a:	85b2                	mv	a1,a2
    5c9c:	0005c703          	lbu	a4,0(a1)
        s2++;
    5ca0:	00158613          	addi	a2,a1,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    5ca4:	fef705e3          	beq	a4,a5,5c8e <strncmp+0x10>
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    5ca8:	0007851b          	sext.w	a0,a5
    5cac:	9d19                	subw	a0,a0,a4
    5cae:	8082                	ret
        return 0;
    5cb0:	4501                	li	a0,0
}
    5cb2:	8082                	ret
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    5cb4:	0015c703          	lbu	a4,1(a1)
    5cb8:	4501                	li	a0,0
    5cba:	9d19                	subw	a0,a0,a4
    5cbc:	8082                	ret
    5cbe:	0005c703          	lbu	a4,0(a1)
    5cc2:	4501                	li	a0,0
    5cc4:	b7e5                	j	5cac <strncmp+0x2e>

0000000000005cc6 <strchr>:

char *strchr(const char *s, int c)
{
    while (*s != (char)c)
    5cc6:	0ff5f593          	zext.b	a1,a1
    5cca:	a019                	j	5cd0 <strchr+0xa>
    {
        if (!*s++)
    5ccc:	0505                	addi	a0,a0,1
    5cce:	c791                	beqz	a5,5cda <strchr+0x14>
    while (*s != (char)c)
    5cd0:	00054783          	lbu	a5,0(a0)
    5cd4:	feb79ce3          	bne	a5,a1,5ccc <strchr+0x6>
    5cd8:	8082                	ret
            return NULL;
    5cda:	4501                	li	a0,0
    }
    return (char *)s;
}
    5cdc:	8082                	ret

0000000000005cde <strrchr>:

char *strrchr(const char *s, int c)
{
    5cde:	87aa                	mv	a5,a0
    const char *last = NULL;
    do
    {
        if (*s == (char)c)
    5ce0:	0ff5f593          	zext.b	a1,a1
    const char *last = NULL;
    5ce4:	4501                	li	a0,0
        if (*s == (char)c)
    5ce6:	0007c703          	lbu	a4,0(a5)
    5cea:	00e59363          	bne	a1,a4,5cf0 <strrchr+0x12>
            last = s;
    5cee:	853e                	mv	a0,a5
    } while (*s++);
    5cf0:	0785                	addi	a5,a5,1
    5cf2:	fb75                	bnez	a4,5ce6 <strrchr+0x8>

    return (char *)last;
}
    5cf4:	8082                	ret

0000000000005cf6 <strstr>:
    while (*p)
    5cf6:	0005c883          	lbu	a7,0(a1)
    5cfa:	04088a63          	beqz	a7,5d4e <strstr+0x58>
    const char *p = s;
    5cfe:	87ae                	mv	a5,a1
    while (*p)
    5d00:	0017c703          	lbu	a4,1(a5)
        p++;
    5d04:	0785                	addi	a5,a5,1
    while (*p)
    5d06:	ff6d                	bnez	a4,5d00 <strstr+0xa>
    return (size_t)(p - s);
    5d08:	40b78833          	sub	a6,a5,a1


char *strstr(const char *haystack, const char *needle)
{
    size_t n_len = strlen(needle);
    if (n_len == 0)
    5d0c:	04b78163          	beq	a5,a1,5d4e <strstr+0x58>
        return (char *)haystack;

    for (; *haystack; haystack++)
    5d10:	00054783          	lbu	a5,0(a0)
    5d14:	cf85                	beqz	a5,5d4c <strstr+0x56>
    5d16:	187d                	addi	a6,a6,-1
    5d18:	982a                	add	a6,a6,a0
    {
        if (*haystack != *needle)
    5d1a:	02f89463          	bne	a7,a5,5d42 <strstr+0x4c>
    while (n-- > 0 && *s1 && *s1 == *s2)
    5d1e:	00054703          	lbu	a4,0(a0)
    5d22:	8646                	mv	a2,a7
    5d24:	86ae                	mv	a3,a1
    5d26:	87aa                	mv	a5,a0
    5d28:	eb11                	bnez	a4,5d3c <strstr+0x46>
    5d2a:	a821                	j	5d42 <strstr+0x4c>
        if (n == 0 || *s1 == '\0')
    5d2c:	03078163          	beq	a5,a6,5d4e <strstr+0x58>
    while (n-- > 0 && *s1 && *s1 == *s2)
    5d30:	0017c703          	lbu	a4,1(a5)
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    5d34:	0006c603          	lbu	a2,0(a3)
        s1++;
    5d38:	0785                	addi	a5,a5,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    5d3a:	cb19                	beqz	a4,5d50 <strstr+0x5a>
        s2++;
    5d3c:	0685                	addi	a3,a3,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    5d3e:	fee607e3          	beq	a2,a4,5d2c <strstr+0x36>
    for (; *haystack; haystack++)
    5d42:	00154783          	lbu	a5,1(a0)
    5d46:	0805                	addi	a6,a6,1
    5d48:	0505                	addi	a0,a0,1
    5d4a:	fbe1                	bnez	a5,5d1a <strstr+0x24>
            continue;

        if (strncmp(haystack, needle, n_len) == 0)
            return (char *)haystack;
    }
    return NULL;
    5d4c:	4501                	li	a0,0
}
    5d4e:	8082                	ret
        if (strncmp(haystack, needle, n_len) == 0)
    5d50:	de7d                	beqz	a2,5d4e <strstr+0x58>
    for (; *haystack; haystack++)
    5d52:	00154783          	lbu	a5,1(a0)
    5d56:	0805                	addi	a6,a6,1
    5d58:	0505                	addi	a0,a0,1
    5d5a:	f3e1                	bnez	a5,5d1a <strstr+0x24>
    5d5c:	bfc5                	j	5d4c <strstr+0x56>

0000000000005d5e <strdup>:

char *strdup(const char *s)
{
    5d5e:	1101                	addi	sp,sp,-32
    5d60:	e426                	sd	s1,8(sp)
    5d62:	ec06                	sd	ra,24(sp)
    5d64:	e822                	sd	s0,16(sp)
    while (*p)
    5d66:	00054783          	lbu	a5,0(a0)
{
    5d6a:	84aa                	mv	s1,a0
    while (*p)
    5d6c:	cb8d                	beqz	a5,5d9e <strdup+0x40>
    const char *p = s;
    5d6e:	862a                	mv	a2,a0
    while (*p)
    5d70:	00164783          	lbu	a5,1(a2)
        p++;
    5d74:	0605                	addi	a2,a2,1
    while (*p)
    5d76:	ffed                	bnez	a5,5d70 <strdup+0x12>
    return (size_t)(p - s);
    5d78:	8e05                	sub	a2,a2,s1
    size_t len = strlen(s) + 1;
    5d7a:	00160413          	addi	s0,a2,1
    char *new_str = (char *)malloc(len);
    5d7e:	8522                	mv	a0,s0
    5d80:	f4eff0ef          	jal	54ce <malloc>
    if (new_str == NULL)
    5d84:	c901                	beqz	a0,5d94 <strdup+0x36>
    return memmove(vdst, vsrc, n);
    5d86:	8622                	mv	a2,s0
        return NULL;

    return (char *)memcpy(new_str, s, len);
}
    5d88:	6442                	ld	s0,16(sp)
    5d8a:	60e2                	ld	ra,24(sp)
    return memmove(vdst, vsrc, n);
    5d8c:	85a6                	mv	a1,s1
}
    5d8e:	64a2                	ld	s1,8(sp)
    5d90:	6105                	addi	sp,sp,32
    return memmove(vdst, vsrc, n);
    5d92:	bbb9                	j	5af0 <memmove>
}
    5d94:	60e2                	ld	ra,24(sp)
    5d96:	6442                	ld	s0,16(sp)
    5d98:	64a2                	ld	s1,8(sp)
    5d9a:	6105                	addi	sp,sp,32
    5d9c:	8082                	ret
    while (*p)
    5d9e:	4405                	li	s0,1
    5da0:	bff9                	j	5d7e <strdup+0x20>

0000000000005da2 <strlcpy>:
    5da2:	0005c783          	lbu	a5,0(a1)

size_t strlcpy(char *dst, const char *src, size_t size)
{
    5da6:	1101                	addi	sp,sp,-32
    5da8:	ec06                	sd	ra,24(sp)
    5daa:	e822                	sd	s0,16(sp)
    5dac:	86b2                	mv	a3,a2
    while (*p)
    5dae:	cf8d                	beqz	a5,5de8 <strlcpy+0x46>
    const char *p = s;
    5db0:	87ae                	mv	a5,a1
    while (*p)
    5db2:	0017c703          	lbu	a4,1(a5)
        p++;
    5db6:	0785                	addi	a5,a5,1
    while (*p)
    5db8:	ff6d                	bnez	a4,5db2 <strlcpy+0x10>
    return (size_t)(p - s);
    5dba:	40b78433          	sub	s0,a5,a1
    size_t src_len = strlen(src);

    if (size > 0)
    5dbe:	c285                	beqz	a3,5dde <strlcpy+0x3c>
    5dc0:	e426                	sd	s1,8(sp)
    {
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    5dc2:	fff68613          	addi	a2,a3,-1
        memcpy(dst, src, copy_len);
        dst[copy_len] = '\0';
    5dc6:	00c504b3          	add	s1,a0,a2
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    5dca:	00d47563          	bgeu	s0,a3,5dd4 <strlcpy+0x32>
        dst[copy_len] = '\0';
    5dce:	008504b3          	add	s1,a0,s0
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    5dd2:	8622                	mv	a2,s0
    return memmove(vdst, vsrc, n);
    5dd4:	d1dff0ef          	jal	5af0 <memmove>
        dst[copy_len] = '\0';
    5dd8:	00048023          	sb	zero,0(s1)
    }

    return src_len;
    5ddc:	64a2                	ld	s1,8(sp)
}
    5dde:	60e2                	ld	ra,24(sp)
    5de0:	8522                	mv	a0,s0
    5de2:	6442                	ld	s0,16(sp)
    5de4:	6105                	addi	sp,sp,32
    5de6:	8082                	ret
    if (size > 0)
    5de8:	e219                	bnez	a2,5dee <strlcpy+0x4c>
    return (size_t)(p - s);
    5dea:	4401                	li	s0,0
    5dec:	bfcd                	j	5dde <strlcpy+0x3c>
    5dee:	e426                	sd	s1,8(sp)
    5df0:	4401                	li	s0,0
    if (size > 0)
    5df2:	84aa                	mv	s1,a0
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    5df4:	4601                	li	a2,0
    5df6:	bff9                	j	5dd4 <strlcpy+0x32>

0000000000005df8 <strlcat>:
    while (*p)
    5df8:	0005c783          	lbu	a5,0(a1)

size_t strlcat(char *dst, const char *src, size_t size)
{
    5dfc:	7179                	addi	sp,sp,-48
    5dfe:	e84a                	sd	s2,16(sp)
    5e00:	f406                	sd	ra,40(sp)
    5e02:	f022                	sd	s0,32(sp)
    5e04:	ec26                	sd	s1,24(sp)
    5e06:	892a                	mv	s2,a0
    while (*p)
    5e08:	c7b5                	beqz	a5,5e74 <strlcat+0x7c>
    const char *p = s;
    5e0a:	87ae                	mv	a5,a1
    while (*p)
    5e0c:	0017c703          	lbu	a4,1(a5)
        p++;
    5e10:	0785                	addi	a5,a5,1
    while (*p)
    5e12:	ff6d                	bnez	a4,5e0c <strlcat+0x14>
    return (size_t)(p - s);
    5e14:	40b784b3          	sub	s1,a5,a1
    size_t dst_len = 0;
    5e18:	4401                	li	s0,0
    size_t src_len = strlen(src);

    while (dst_len < size && dst[dst_len] != '\0')
    5e1a:	e609                	bnez	a2,5e24 <strlcat+0x2c>
    5e1c:	a0a1                	j	5e64 <strlcat+0x6c>
        dst_len++;
    5e1e:	0405                	addi	s0,s0,1
    while (dst_len < size && dst[dst_len] != '\0')
    5e20:	04860263          	beq	a2,s0,5e64 <strlcat+0x6c>
    5e24:	00890533          	add	a0,s2,s0
    5e28:	00054783          	lbu	a5,0(a0)
    5e2c:	fbed                	bnez	a5,5e1e <strlcat+0x26>

    if (dst_len == size)
    5e2e:	02860b63          	beq	a2,s0,5e64 <strlcat+0x6c>
    5e32:	e44e                	sd	s3,8(sp)
        return size + src_len;

    size_t space_left = size - dst_len;
    5e34:	408607b3          	sub	a5,a2,s0
    size_t copy_len = (src_len >= space_left) ? space_left - 1 : src_len;
    5e38:	89a6                	mv	s3,s1
    5e3a:	02f4f263          	bgeu	s1,a5,5e5e <strlcat+0x66>

    memcpy(dst + dst_len, src, copy_len);
    dst[dst_len + copy_len] = '\0';
    5e3e:	994e                	add	s2,s2,s3
    5e40:	9922                	add	s2,s2,s0
    return memmove(vdst, vsrc, n);
    5e42:	864e                	mv	a2,s3
    5e44:	cadff0ef          	jal	5af0 <memmove>
    dst[dst_len + copy_len] = '\0';
    5e48:	00090023          	sb	zero,0(s2) # 1000 <main+0x19e>

    return dst_len + src_len;
    5e4c:	00940533          	add	a0,s0,s1
}
    5e50:	70a2                	ld	ra,40(sp)
    5e52:	7402                	ld	s0,32(sp)
    return dst_len + src_len;
    5e54:	69a2                	ld	s3,8(sp)
}
    5e56:	64e2                	ld	s1,24(sp)
    5e58:	6942                	ld	s2,16(sp)
    5e5a:	6145                	addi	sp,sp,48
    5e5c:	8082                	ret
    size_t copy_len = (src_len >= space_left) ? space_left - 1 : src_len;
    5e5e:	fff78993          	addi	s3,a5,-1
    5e62:	bff1                	j	5e3e <strlcat+0x46>
}
    5e64:	70a2                	ld	ra,40(sp)
    5e66:	7402                	ld	s0,32(sp)
    5e68:	6942                	ld	s2,16(sp)
        return size + src_len;
    5e6a:	00960533          	add	a0,a2,s1
}
    5e6e:	64e2                	ld	s1,24(sp)
    5e70:	6145                	addi	sp,sp,48
    5e72:	8082                	ret
    while (*p)
    5e74:	4481                	li	s1,0
    5e76:	b74d                	j	5e18 <strlcat+0x20>

0000000000005e78 <strspn>:
size_t strspn(const char *s, const char *accept)
{
    const char *p = s;
    const char *a;

    while (*p)
    5e78:	00054683          	lbu	a3,0(a0)
    5e7c:	c695                	beqz	a3,5ea8 <strspn+0x30>
    {
        for (a = accept; *a; a++)
    5e7e:	0005c803          	lbu	a6,0(a1)
    5e82:	862a                	mv	a2,a0
    5e84:	00080f63          	beqz	a6,5ea2 <strspn+0x2a>
    5e88:	87ae                	mv	a5,a1
    5e8a:	8742                	mv	a4,a6
    5e8c:	a021                	j	5e94 <strspn+0x1c>
    5e8e:	0007c703          	lbu	a4,0(a5)
    5e92:	cb01                	beqz	a4,5ea2 <strspn+0x2a>
    5e94:	0785                	addi	a5,a5,1
        {
            if (*p == *a)
    5e96:	fee69ce3          	bne	a3,a4,5e8e <strspn+0x16>
    while (*p)
    5e9a:	00164683          	lbu	a3,1(a2)
                break;
        }
        if (*a == '\0')
            return (size_t)(p - s);
        p++;
    5e9e:	0605                	addi	a2,a2,1
    while (*p)
    5ea0:	f6e5                	bnez	a3,5e88 <strspn+0x10>
    }
    return (size_t)(p - s);
    5ea2:	40a60533          	sub	a0,a2,a0
    5ea6:	8082                	ret
    while (*p)
    5ea8:	4501                	li	a0,0
}
    5eaa:	8082                	ret

0000000000005eac <strcspn>:
size_t strcspn(const char *s, const char *reject)
{
    const char *p = s;
    const char *r;

    while (*p)
    5eac:	00054683          	lbu	a3,0(a0)
    5eb0:	ce85                	beqz	a3,5ee8 <strcspn+0x3c>
    {
        for (r = reject; *r; r++)
    5eb2:	0005c803          	lbu	a6,0(a1)
    const char *p = s;
    5eb6:	862a                	mv	a2,a0
        for (r = reject; *r; r++)
    5eb8:	02080363          	beqz	a6,5ede <strcspn+0x32>
    5ebc:	87ae                	mv	a5,a1
    5ebe:	8742                	mv	a4,a6
    5ec0:	a021                	j	5ec8 <strcspn+0x1c>
    5ec2:	0007c703          	lbu	a4,0(a5)
    5ec6:	c719                	beqz	a4,5ed4 <strcspn+0x28>
    5ec8:	0785                	addi	a5,a5,1
        {
            if (*p == *r)
    5eca:	fed71ce3          	bne	a4,a3,5ec2 <strcspn+0x16>
                return (size_t)(p - s);
        }
        p++;
    }
    return (size_t)(p - s);
    5ece:	40a60533          	sub	a0,a2,a0
    5ed2:	8082                	ret
    while (*p)
    5ed4:	00164683          	lbu	a3,1(a2)
        p++;
    5ed8:	0605                	addi	a2,a2,1
    while (*p)
    5eda:	f2ed                	bnez	a3,5ebc <strcspn+0x10>
    5edc:	bfcd                	j	5ece <strcspn+0x22>
    5ede:	00164683          	lbu	a3,1(a2)
        p++;
    5ee2:	0605                	addi	a2,a2,1
    while (*p)
    5ee4:	feed                	bnez	a3,5ede <strcspn+0x32>
    5ee6:	b7e5                	j	5ece <strcspn+0x22>
    5ee8:	4501                	li	a0,0
}
    5eea:	8082                	ret

0000000000005eec <strpbrk>:

char *strpbrk(const char *s, const char *accept)
{
    const char *a;
    while (*s)
    5eec:	00054683          	lbu	a3,0(a0)
    5ef0:	c295                	beqz	a3,5f14 <strpbrk+0x28>
    {
        for (a = accept; *a; a++)
    5ef2:	0005c603          	lbu	a2,0(a1)
    5ef6:	c20d                	beqz	a2,5f18 <strpbrk+0x2c>
    5ef8:	87ae                	mv	a5,a1
    5efa:	8732                	mv	a4,a2
    5efc:	a021                	j	5f04 <strpbrk+0x18>
    5efe:	0007c703          	lbu	a4,0(a5)
    5f02:	c709                	beqz	a4,5f0c <strpbrk+0x20>
    5f04:	0785                	addi	a5,a5,1
        {
            if (*s == *a)
    5f06:	fed71ce3          	bne	a4,a3,5efe <strpbrk+0x12>
                return (char *)s;
        }
        s++;
    }
    return NULL;
}
    5f0a:	8082                	ret
    while (*s)
    5f0c:	00154683          	lbu	a3,1(a0)
        s++;
    5f10:	0505                	addi	a0,a0,1
    while (*s)
    5f12:	f2fd                	bnez	a3,5ef8 <strpbrk+0xc>
    return NULL;
    5f14:	4501                	li	a0,0
}
    5f16:	8082                	ret
    while (*s)
    5f18:	00154683          	lbu	a3,1(a0)
        s++;
    5f1c:	0505                	addi	a0,a0,1
    while (*s)
    5f1e:	feed                	bnez	a3,5f18 <strpbrk+0x2c>
    5f20:	bfd5                	j	5f14 <strpbrk+0x28>

0000000000005f22 <strtok>:
char *strtok(char *str, const char *delim)
{
    static char *olds;
    char *token;

    if (str == NULL)
    5f22:	00003897          	auipc	a7,0x3
    5f26:	f3688893          	addi	a7,a7,-202 # 8e58 <olds.0>
    5f2a:	cd25                	beqz	a0,5fa2 <strtok+0x80>
    while (*p)
    5f2c:	00054683          	lbu	a3,0(a0)
    5f30:	c295                	beqz	a3,5f54 <strtok+0x32>
        for (a = accept; *a; a++)
    5f32:	0005c803          	lbu	a6,0(a1)
    5f36:	02080463          	beqz	a6,5f5e <strtok+0x3c>
    5f3a:	87ae                	mv	a5,a1
    5f3c:	8742                	mv	a4,a6
    5f3e:	a021                	j	5f46 <strtok+0x24>
    5f40:	0007c703          	lbu	a4,0(a5)
    5f44:	cf09                	beqz	a4,5f5e <strtok+0x3c>
    5f46:	0785                	addi	a5,a5,1
            if (*p == *a)
    5f48:	fee69ce3          	bne	a3,a4,5f40 <strtok+0x1e>
    while (*p)
    5f4c:	00154683          	lbu	a3,1(a0)
        p++;
    5f50:	0505                	addi	a0,a0,1
    while (*p)
    5f52:	f6e5                	bnez	a3,5f3a <strtok+0x18>
    5f54:	87aa                	mv	a5,a0
        str = olds;

    str += strspn(str, delim);
    if (*str == '\0')
    {
        olds = str;
    5f56:	00f8b023          	sd	a5,0(a7)
        return NULL;
    5f5a:	4501                	li	a0,0
        *str = '\0';
        olds = str + 1;
    }

    return token;
}
    5f5c:	8082                	ret
    if (*str == '\0')
    5f5e:	00054603          	lbu	a2,0(a0)
    5f62:	da6d                	beqz	a2,5f54 <strtok+0x32>
    5f64:	86aa                	mv	a3,a0
        for (a = accept; *a; a++)
    5f66:	04080163          	beqz	a6,5fa8 <strtok+0x86>
    5f6a:	8742                	mv	a4,a6
    5f6c:	87ae                	mv	a5,a1
    5f6e:	a021                	j	5f76 <strtok+0x54>
    5f70:	0007c703          	lbu	a4,0(a5)
    5f74:	cb19                	beqz	a4,5f8a <strtok+0x68>
    5f76:	0785                	addi	a5,a5,1
            if (*s == *a)
    5f78:	fee61ce3          	bne	a2,a4,5f70 <strtok+0x4e>
        olds = str + 1;
    5f7c:	00168793          	addi	a5,a3,1
        *str = '\0';
    5f80:	00068023          	sb	zero,0(a3)
        olds = str;
    5f84:	00f8b023          	sd	a5,0(a7)
}
    5f88:	8082                	ret
    while (*s)
    5f8a:	0016c603          	lbu	a2,1(a3)
        s++;
    5f8e:	0685                	addi	a3,a3,1
    while (*s)
    5f90:	fe69                	bnez	a2,5f6a <strtok+0x48>
    5f92:	87aa                	mv	a5,a0
    while (*s != (char)c)
    5f94:	0017c703          	lbu	a4,1(a5)
        if (!*s++)
    5f98:	0785                	addi	a5,a5,1
    while (*s != (char)c)
    5f9a:	ff6d                	bnez	a4,5f94 <strtok+0x72>
        olds = str;
    5f9c:	00f8b023          	sd	a5,0(a7)
}
    5fa0:	8082                	ret
        str = olds;
    5fa2:	0008b503          	ld	a0,0(a7)
    5fa6:	b759                	j	5f2c <strtok+0xa>
    while (*s)
    5fa8:	0016c603          	lbu	a2,1(a3)
        s++;
    5fac:	0685                	addi	a3,a3,1
    while (*s)
    5fae:	fe6d                	bnez	a2,5fa8 <strtok+0x86>
    5fb0:	b7cd                	j	5f92 <strtok+0x70>

0000000000005fb2 <strerror>:

char *strerror(int errnum)
{
    5fb2:	87aa                	mv	a5,a0
    
    switch (errnum)
    5fb4:	cd09                	beqz	a0,5fce <strerror+0x1c>
    5fb6:	4731                	li	a4,12
    5fb8:	00000517          	auipc	a0,0x0
    5fbc:	2c050513          	addi	a0,a0,704 # 6278 <_GLOBAL__sub_I__ZSt3cin+0x288>
    5fc0:	00e78b63          	beq	a5,a4,5fd6 <strerror+0x24>
        return "Success";
    // case EINVAL: return "Invalid argument";
    case ENOMEM: return "Out of memory";
    
    default:
        return "Unknown error";
    5fc4:	00000517          	auipc	a0,0x0
    5fc8:	2c450513          	addi	a0,a0,708 # 6288 <_GLOBAL__sub_I__ZSt3cin+0x298>
    5fcc:	8082                	ret
        return "Success";
    5fce:	00000517          	auipc	a0,0x0
    5fd2:	2a250513          	addi	a0,a0,674 # 6270 <_GLOBAL__sub_I__ZSt3cin+0x280>
    }
    5fd6:	8082                	ret

0000000000005fd8 <_Znwm>:
#include "ulib/stdlib.h"

void *operator new(unsigned long n)
{
    return malloc(n);
    5fd8:	cf6ff06f          	j	54ce <malloc>

0000000000005fdc <_Znam>:
}

void *operator new[](unsigned long n)
    5fdc:	cf2ff06f          	j	54ce <malloc>

0000000000005fe0 <_ZdlPv>:
    return malloc(n);
}

void operator delete(void *p)
{
    free(p);
    5fe0:	c78ff06f          	j	5458 <free>

0000000000005fe4 <_ZdaPv>:
}

void operator delete[](void *p)
    5fe4:	c74ff06f          	j	5458 <free>

0000000000005fe8 <_ZdlPvm>:
    free(p);
}

void operator delete(void *p, unsigned long)
{
    free(p);
    5fe8:	c70ff06f          	j	5458 <free>

0000000000005fec <_ZdaPvm>:
}

void operator delete[](void *p, unsigned long)
    5fec:	c6cff06f          	j	5458 <free>

0000000000005ff0 <_GLOBAL__sub_I__ZSt3cin>:
#include "ulib/iostream"

namespace std
{
    istream cin(stdin);
    5ff0:	00003797          	auipc	a5,0x3
    5ff4:	cb87b783          	ld	a5,-840(a5) # 8ca8 <_GLOBAL_OFFSET_TABLE_+0x10>
    5ff8:	6390                	ld	a2,0(a5)
    ostream cout(stdout);
    5ffa:	00003797          	auipc	a5,0x3
    5ffe:	ca67b783          	ld	a5,-858(a5) # 8ca0 <_GLOBAL_OFFSET_TABLE_+0x8>
    6002:	6394                	ld	a3,0(a5)
    ostream cerr(stderr);
    6004:	00003797          	auipc	a5,0x3
    6008:	cac7b783          	ld	a5,-852(a5) # 8cb0 <_GLOBAL_OFFSET_TABLE_+0x18>
    600c:	6398                	ld	a4,0(a5)

    class istream{
    private:
        FILE* _stream;
    public:
        istream(FILE *f) : _stream(f) {}
    600e:	00003797          	auipc	a5,0x3
    6012:	e5278793          	addi	a5,a5,-430 # 8e60 <_ZSt3cin>
    6016:	e390                	sd	a2,0(a5)
        ostream(FILE* f) : _stream(f) {}
    6018:	e794                	sd	a3,8(a5)
    601a:	eb98                	sd	a4,16(a5)
} // namespace std
    601c:	8082                	ret
