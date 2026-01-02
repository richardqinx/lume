
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
       8:	00450513          	addi	a0,a0,4 # 6008 <_GLOBAL__sub_I__ZSt3cin+0x60>
{
       c:	e406                	sd	ra,8(sp)
    printf("shell panic: %s\n", s);
       e:	0bd040ef          	jal	48ca <printf>
    exit(1);
}
      12:	60a2                	ld	ra,8(sp)
    exit(1);
      14:	4505                	li	a0,1
}
      16:	0141                	addi	sp,sp,16
    exit(1);
      18:	3c60506f          	j	53de <exit>

000000000000001c <_Z13fork_or_panicv>:

int fork_or_panic()
{
      1c:	1141                	addi	sp,sp,-16
      1e:	e022                	sd	s0,0(sp)
      20:	e406                	sd	ra,8(sp)
    int pid = fork();
      22:	086010ef          	jal	10a8 <fork>
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
      3c:	fc858593          	addi	a1,a1,-56 # 6000 <_GLOBAL__sub_I__ZSt3cin+0x58>
      40:	00006517          	auipc	a0,0x6
      44:	fc850513          	addi	a0,a0,-56 # 6008 <_GLOBAL__sub_I__ZSt3cin+0x60>
      48:	083040ef          	jal	48ca <printf>
    exit(1);
      4c:	4505                	li	a0,1
      4e:	390050ef          	jal	53de <exit>
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
      5c:	7159                	addi	sp,sp,-112
      5e:	e8ca                	sd	s2,80(sp)
      60:	e4ce                	sd	s3,72(sp)
      62:	892e                	mv	s2,a1
      64:	89aa                	mv	s3,a0
    write(1, "$ ", 2);
      66:	4609                	li	a2,2
      68:	00006597          	auipc	a1,0x6
      6c:	02058593          	addi	a1,a1,32 # 6088 <_GLOBAL__sub_I__ZSt3cin+0xe0>
      70:	4505                	li	a0,1
{
      72:	f486                	sd	ra,104(sp)
    write(1, "$ ", 2);
      74:	054010ef          	jal	10c8 <write>
    memset(buf, 0, nbuf);
      78:	864a                	mv	a2,s2
      7a:	4581                	li	a1,0
      7c:	854e                	mv	a0,s3
      7e:	213050ef          	jal	5a90 <memset>

    int i = 0;
    while (i < nbuf - 1)
      82:	4785                	li	a5,1
      84:	0927d063          	bge	a5,s2,104 <_Z6getcmdPci+0xa8>
      88:	f0a2                	sd	s0,96(sp)
      8a:	eca6                	sd	s1,88(sp)
      8c:	e0d2                	sd	s4,64(sp)
      8e:	fc56                	sd	s5,56(sp)
      90:	f85a                	sd	s6,48(sp)
      92:	f45e                	sd	s7,40(sp)
      94:	f062                	sd	s8,32(sp)
      96:	ec66                	sd	s9,24(sp)
      98:	fff90b1b          	addiw	s6,s2,-1
      9c:	4401                	li	s0,0
      9e:	00f10493          	addi	s1,sp,15
        char c;
        int n = read(0, &c, 1);
        if (n <= 0)
            return -1;

        if (c == '\b' || c == 127)
      a2:	4a21                	li	s4,8
        {
            if (i > 0)
            {
                write(1, "\b \b", 3);
      a4:	00006b97          	auipc	s7,0x6
      a8:	fecb8b93          	addi	s7,s7,-20 # 6090 <_GLOBAL__sub_I__ZSt3cin+0xe8>
        if (c == '\b' || c == 127)
      ac:	07f00a93          	li	s5,127
                i--;
            }
        }
        else if (c == '\n' || c == '\r')
      b0:	4c29                	li	s8,10
      b2:	4cb5                	li	s9,13
        int n = read(0, &c, 1);
      b4:	4605                	li	a2,1
      b6:	85a6                	mv	a1,s1
      b8:	4501                	li	a0,0
      ba:	006010ef          	jal	10c0 <read>
      be:	87aa                	mv	a5,a0
            buf[i] = 0;
            return 0;
        }
        else
        {
            write(1, &c, 1);
      c0:	4605                	li	a2,1
      c2:	85a6                	mv	a1,s1
      c4:	4505                	li	a0,1
        if (n <= 0)
      c6:	06f05063          	blez	a5,126 <_Z6getcmdPci+0xca>
        if (c == '\b' || c == 127)
      ca:	00f14783          	lbu	a5,15(sp)
            buf[i++] = c;
      ce:	00898933          	add	s2,s3,s0
        if (c == '\b' || c == 127)
      d2:	03478f63          	beq	a5,s4,110 <_Z6getcmdPci+0xb4>
      d6:	03578d63          	beq	a5,s5,110 <_Z6getcmdPci+0xb4>
        else if (c == '\n' || c == '\r')
      da:	07878463          	beq	a5,s8,142 <_Z6getcmdPci+0xe6>
      de:	07978263          	beq	a5,s9,142 <_Z6getcmdPci+0xe6>
            write(1, &c, 1);
      e2:	7e7000ef          	jal	10c8 <write>
            buf[i++] = c;
      e6:	00f14783          	lbu	a5,15(sp)
      ea:	2405                	addiw	s0,s0,1
      ec:	00f90023          	sb	a5,0(s2)
    while (i < nbuf - 1)
      f0:	fd6442e3          	blt	s0,s6,b4 <_Z6getcmdPci+0x58>
      f4:	7406                	ld	s0,96(sp)
      f6:	64e6                	ld	s1,88(sp)
      f8:	6a06                	ld	s4,64(sp)
      fa:	7ae2                	ld	s5,56(sp)
      fc:	7b42                	ld	s6,48(sp)
      fe:	7ba2                	ld	s7,40(sp)
     100:	7c02                	ld	s8,32(sp)
     102:	6ce2                	ld	s9,24(sp)
        }
    }
    return -1;
}
     104:	70a6                	ld	ra,104(sp)
     106:	6946                	ld	s2,80(sp)
     108:	69a6                	ld	s3,72(sp)
    return -1;
     10a:	557d                	li	a0,-1
}
     10c:	6165                	addi	sp,sp,112
     10e:	8082                	ret
                write(1, "\b \b", 3);
     110:	460d                	li	a2,3
     112:	85de                	mv	a1,s7
     114:	4505                	li	a0,1
            if (i > 0)
     116:	f8805fe3          	blez	s0,b4 <_Z6getcmdPci+0x58>
                i--;
     11a:	347d                	addiw	s0,s0,-1
                write(1, "\b \b", 3);
     11c:	7ad000ef          	jal	10c8 <write>
    while (i < nbuf - 1)
     120:	f9644ae3          	blt	s0,s6,b4 <_Z6getcmdPci+0x58>
     124:	bfc1                	j	f4 <_Z6getcmdPci+0x98>
            return -1;
     126:	557d                	li	a0,-1
     128:	7406                	ld	s0,96(sp)
}
     12a:	70a6                	ld	ra,104(sp)
            return -1;
     12c:	64e6                	ld	s1,88(sp)
     12e:	6a06                	ld	s4,64(sp)
     130:	7ae2                	ld	s5,56(sp)
     132:	7b42                	ld	s6,48(sp)
     134:	7ba2                	ld	s7,40(sp)
     136:	7c02                	ld	s8,32(sp)
     138:	6ce2                	ld	s9,24(sp)
}
     13a:	6946                	ld	s2,80(sp)
     13c:	69a6                	ld	s3,72(sp)
     13e:	6165                	addi	sp,sp,112
     140:	8082                	ret
            write(1, "\n", 1);
     142:	4605                	li	a2,1
     144:	00006597          	auipc	a1,0x6
     148:	f5458593          	addi	a1,a1,-172 # 6098 <_GLOBAL__sub_I__ZSt3cin+0xf0>
     14c:	4505                	li	a0,1
     14e:	77b000ef          	jal	10c8 <write>
            return 0;
     152:	4501                	li	a0,0
            buf[i] = 0;
     154:	00090023          	sb	zero,0(s2)
            return 0;
     158:	bfc1                	j	128 <_Z6getcmdPci+0xcc>

000000000000015a <_ZN12RedirCommandD1Ev>:
    ~RedirCommand() { delete sub_cmd; }
     15a:	87aa                	mv	a5,a0
     15c:	6508                	ld	a0,8(a0)
     15e:	00008717          	auipc	a4,0x8
     162:	c6a70713          	addi	a4,a4,-918 # 7dc8 <_ZTV12RedirCommand+0x10>
     166:	e398                	sd	a4,0(a5)
     168:	c501                	beqz	a0,170 <_ZN12RedirCommandD1Ev+0x16>
     16a:	611c                	ld	a5,0(a0)
     16c:	679c                	ld	a5,8(a5)
     16e:	8782                	jr	a5
     170:	8082                	ret

0000000000000172 <_ZN11PipeCommandD1Ev>:
    ~PipeCommand()
     172:	1141                	addi	sp,sp,-16
     174:	e022                	sd	s0,0(sp)
     176:	842a                	mv	s0,a0
        delete left;
     178:	6508                	ld	a0,8(a0)
    ~PipeCommand()
     17a:	e406                	sd	ra,8(sp)
    {
     17c:	00008797          	auipc	a5,0x8
     180:	c7478793          	addi	a5,a5,-908 # 7df0 <_ZTV11PipeCommand+0x10>
     184:	e01c                	sd	a5,0(s0)
        delete left;
     186:	c501                	beqz	a0,18e <_ZN11PipeCommandD1Ev+0x1c>
     188:	611c                	ld	a5,0(a0)
     18a:	679c                	ld	a5,8(a5)
     18c:	9782                	jalr	a5
        delete right;
     18e:	6808                	ld	a0,16(s0)
     190:	c519                	beqz	a0,19e <_ZN11PipeCommandD1Ev+0x2c>
     192:	611c                	ld	a5,0(a0)
    }
     194:	6402                	ld	s0,0(sp)
     196:	60a2                	ld	ra,8(sp)
        delete right;
     198:	679c                	ld	a5,8(a5)
    }
     19a:	0141                	addi	sp,sp,16
        delete right;
     19c:	8782                	jr	a5
    }
     19e:	60a2                	ld	ra,8(sp)
     1a0:	6402                	ld	s0,0(sp)
     1a2:	0141                	addi	sp,sp,16
     1a4:	8082                	ret

00000000000001a6 <_ZN11ListCommandD1Ev>:
    ~ListCommand()
     1a6:	1141                	addi	sp,sp,-16
     1a8:	e022                	sd	s0,0(sp)
     1aa:	842a                	mv	s0,a0
        delete left;
     1ac:	6508                	ld	a0,8(a0)
    ~ListCommand()
     1ae:	e406                	sd	ra,8(sp)
    {
     1b0:	00008797          	auipc	a5,0x8
     1b4:	c6878793          	addi	a5,a5,-920 # 7e18 <_ZTV11ListCommand+0x10>
     1b8:	e01c                	sd	a5,0(s0)
        delete left;
     1ba:	c501                	beqz	a0,1c2 <_ZN11ListCommandD1Ev+0x1c>
     1bc:	611c                	ld	a5,0(a0)
     1be:	679c                	ld	a5,8(a5)
     1c0:	9782                	jalr	a5
        delete right;
     1c2:	6808                	ld	a0,16(s0)
     1c4:	c519                	beqz	a0,1d2 <_ZN11ListCommandD1Ev+0x2c>
     1c6:	611c                	ld	a5,0(a0)
    }
     1c8:	6402                	ld	s0,0(sp)
     1ca:	60a2                	ld	ra,8(sp)
        delete right;
     1cc:	679c                	ld	a5,8(a5)
    }
     1ce:	0141                	addi	sp,sp,16
        delete right;
     1d0:	8782                	jr	a5
    }
     1d2:	60a2                	ld	ra,8(sp)
     1d4:	6402                	ld	s0,0(sp)
     1d6:	0141                	addi	sp,sp,16
     1d8:	8082                	ret

00000000000001da <_ZN11BackCommandD1Ev>:
    ~BackCommand() { delete sub_cmd; }
     1da:	87aa                	mv	a5,a0
     1dc:	6508                	ld	a0,8(a0)
     1de:	00008717          	auipc	a4,0x8
     1e2:	c6270713          	addi	a4,a4,-926 # 7e40 <_ZTV11BackCommand+0x10>
     1e6:	e398                	sd	a4,0(a5)
     1e8:	c501                	beqz	a0,1f0 <_ZN11BackCommandD1Ev+0x16>
     1ea:	611c                	ld	a5,0(a0)
     1ec:	679c                	ld	a5,8(a5)
     1ee:	8782                	jr	a5
     1f0:	8082                	ret

00000000000001f2 <_ZN11ExecCommandD1Ev>:
struct ExecCommand : public Command
     1f2:	8082                	ret

00000000000001f4 <_ZN12RedirCommand3runEv>:
    void run() override
     1f4:	1141                	addi	sp,sp,-16
     1f6:	e022                	sd	s0,0(sp)
     1f8:	842a                	mv	s0,a0
        close(fd);
     1fa:	5148                	lw	a0,36(a0)
    void run() override
     1fc:	e406                	sd	ra,8(sp)
        close(fd);
     1fe:	6d3000ef          	jal	10d0 <close>
        if (open(file, mode) < 0)
     202:	500c                	lw	a1,32(s0)
     204:	6808                	ld	a0,16(s0)
     206:	6e3000ef          	jal	10e8 <open>
     20a:	00054963          	bltz	a0,21c <_ZN12RedirCommand3runEv+0x28>
        sub_cmd->run();
     20e:	6408                	ld	a0,8(s0)
    }
     210:	6402                	ld	s0,0(sp)
     212:	60a2                	ld	ra,8(sp)
        sub_cmd->run();
     214:	611c                	ld	a5,0(a0)
     216:	6b9c                	ld	a5,16(a5)
    }
     218:	0141                	addi	sp,sp,16
        sub_cmd->run();
     21a:	8782                	jr	a5
            printf("open %s failed\n", file);
     21c:	680c                	ld	a1,16(s0)
     21e:	00006517          	auipc	a0,0x6
     222:	dc250513          	addi	a0,a0,-574 # 5fe0 <_GLOBAL__sub_I__ZSt3cin+0x38>
     226:	6a4040ef          	jal	48ca <printf>
            exit(1);
     22a:	4505                	li	a0,1
     22c:	1b2050ef          	jal	53de <exit>
        sub_cmd->run();
     230:	6408                	ld	a0,8(s0)
    }
     232:	6402                	ld	s0,0(sp)
     234:	60a2                	ld	ra,8(sp)
        sub_cmd->run();
     236:	611c                	ld	a5,0(a0)
     238:	6b9c                	ld	a5,16(a5)
    }
     23a:	0141                	addi	sp,sp,16
        sub_cmd->run();
     23c:	8782                	jr	a5

000000000000023e <_ZN11ExecCommand3runEv>:
    void run() override
     23e:	1141                	addi	sp,sp,-16
     240:	e022                	sd	s0,0(sp)
     242:	842a                	mv	s0,a0
        if (argv[0] == nullptr)
     244:	6508                	ld	a0,8(a0)
    void run() override
     246:	e406                	sd	ra,8(sp)
        if (argv[0] == nullptr)
     248:	c115                	beqz	a0,26c <_ZN11ExecCommand3runEv+0x2e>
        exec(argv[0], argv);
     24a:	00840593          	addi	a1,s0,8
     24e:	693000ef          	jal	10e0 <exec>
        printf("exec %s failed\n", argv[0]);
     252:	640c                	ld	a1,8(s0)
     254:	00006517          	auipc	a0,0x6
     258:	d9c50513          	addi	a0,a0,-612 # 5ff0 <_GLOBAL__sub_I__ZSt3cin+0x48>
     25c:	66e040ef          	jal	48ca <printf>
    }
     260:	6402                	ld	s0,0(sp)
     262:	60a2                	ld	ra,8(sp)
        exit(1);
     264:	4505                	li	a0,1
    }
     266:	0141                	addi	sp,sp,16
        exit(1);
     268:	1760506f          	j	53de <exit>
            exit(1);
     26c:	4505                	li	a0,1
     26e:	170050ef          	jal	53de <exit>
        exec(argv[0], argv);
     272:	6408                	ld	a0,8(s0)
     274:	bfd9                	j	24a <_ZN11ExecCommand3runEv+0xc>

0000000000000276 <_ZN11ExecCommandD0Ev>:
struct ExecCommand : public Command
     276:	05800593          	li	a1,88
     27a:	5270506f          	j	5fa0 <_ZdlPvm>

000000000000027e <_ZN12RedirCommandD0Ev>:
    ~RedirCommand() { delete sub_cmd; }
     27e:	1141                	addi	sp,sp,-16
     280:	e022                	sd	s0,0(sp)
     282:	842a                	mv	s0,a0
     284:	6508                	ld	a0,8(a0)
     286:	e406                	sd	ra,8(sp)
     288:	00008797          	auipc	a5,0x8
     28c:	b4078793          	addi	a5,a5,-1216 # 7dc8 <_ZTV12RedirCommand+0x10>
     290:	e01c                	sd	a5,0(s0)
     292:	c501                	beqz	a0,29a <_ZN12RedirCommandD0Ev+0x1c>
     294:	611c                	ld	a5,0(a0)
     296:	679c                	ld	a5,8(a5)
     298:	9782                	jalr	a5
     29a:	8522                	mv	a0,s0
     29c:	6402                	ld	s0,0(sp)
     29e:	60a2                	ld	ra,8(sp)
     2a0:	02800593          	li	a1,40
     2a4:	0141                	addi	sp,sp,16
     2a6:	4fb0506f          	j	5fa0 <_ZdlPvm>

00000000000002aa <_ZN11BackCommandD0Ev>:
    ~BackCommand() { delete sub_cmd; }
     2aa:	1141                	addi	sp,sp,-16
     2ac:	e022                	sd	s0,0(sp)
     2ae:	842a                	mv	s0,a0
     2b0:	6508                	ld	a0,8(a0)
     2b2:	e406                	sd	ra,8(sp)
     2b4:	00008797          	auipc	a5,0x8
     2b8:	b8c78793          	addi	a5,a5,-1140 # 7e40 <_ZTV11BackCommand+0x10>
     2bc:	e01c                	sd	a5,0(s0)
     2be:	c501                	beqz	a0,2c6 <_ZN11BackCommandD0Ev+0x1c>
     2c0:	611c                	ld	a5,0(a0)
     2c2:	679c                	ld	a5,8(a5)
     2c4:	9782                	jalr	a5
     2c6:	8522                	mv	a0,s0
     2c8:	6402                	ld	s0,0(sp)
     2ca:	60a2                	ld	ra,8(sp)
     2cc:	45c1                	li	a1,16
     2ce:	0141                	addi	sp,sp,16
     2d0:	4d10506f          	j	5fa0 <_ZdlPvm>

00000000000002d4 <_ZN11PipeCommandD0Ev>:
    ~PipeCommand()
     2d4:	1141                	addi	sp,sp,-16
     2d6:	e022                	sd	s0,0(sp)
     2d8:	842a                	mv	s0,a0
        delete left;
     2da:	6508                	ld	a0,8(a0)
    ~PipeCommand()
     2dc:	e406                	sd	ra,8(sp)
    {
     2de:	00008797          	auipc	a5,0x8
     2e2:	b1278793          	addi	a5,a5,-1262 # 7df0 <_ZTV11PipeCommand+0x10>
     2e6:	e01c                	sd	a5,0(s0)
        delete left;
     2e8:	c501                	beqz	a0,2f0 <_ZN11PipeCommandD0Ev+0x1c>
     2ea:	611c                	ld	a5,0(a0)
     2ec:	679c                	ld	a5,8(a5)
     2ee:	9782                	jalr	a5
        delete right;
     2f0:	6808                	ld	a0,16(s0)
     2f2:	c501                	beqz	a0,2fa <_ZN11PipeCommandD0Ev+0x26>
     2f4:	611c                	ld	a5,0(a0)
     2f6:	679c                	ld	a5,8(a5)
     2f8:	9782                	jalr	a5
    }
     2fa:	8522                	mv	a0,s0
     2fc:	6402                	ld	s0,0(sp)
     2fe:	60a2                	ld	ra,8(sp)
     300:	45e1                	li	a1,24
     302:	0141                	addi	sp,sp,16
     304:	49d0506f          	j	5fa0 <_ZdlPvm>

0000000000000308 <_ZN11ListCommandD0Ev>:
    ~ListCommand()
     308:	1141                	addi	sp,sp,-16
     30a:	e022                	sd	s0,0(sp)
     30c:	842a                	mv	s0,a0
        delete left;
     30e:	6508                	ld	a0,8(a0)
    ~ListCommand()
     310:	e406                	sd	ra,8(sp)
    {
     312:	00008797          	auipc	a5,0x8
     316:	b0678793          	addi	a5,a5,-1274 # 7e18 <_ZTV11ListCommand+0x10>
     31a:	e01c                	sd	a5,0(s0)
        delete left;
     31c:	c501                	beqz	a0,324 <_ZN11ListCommandD0Ev+0x1c>
     31e:	611c                	ld	a5,0(a0)
     320:	679c                	ld	a5,8(a5)
     322:	9782                	jalr	a5
        delete right;
     324:	6808                	ld	a0,16(s0)
     326:	c501                	beqz	a0,32e <_ZN11ListCommandD0Ev+0x26>
     328:	611c                	ld	a5,0(a0)
     32a:	679c                	ld	a5,8(a5)
     32c:	9782                	jalr	a5
    }
     32e:	8522                	mv	a0,s0
     330:	6402                	ld	s0,0(sp)
     332:	60a2                	ld	ra,8(sp)
     334:	45e1                	li	a1,24
     336:	0141                	addi	sp,sp,16
     338:	4690506f          	j	5fa0 <_ZdlPvm>

000000000000033c <_ZN11BackCommand3runEv>:
    void run() override
     33c:	1141                	addi	sp,sp,-16
     33e:	e022                	sd	s0,0(sp)
     340:	e406                	sd	ra,8(sp)
     342:	842a                	mv	s0,a0
    int pid = fork();
     344:	565000ef          	jal	10a8 <fork>
    if (pid == -1)
     348:	57fd                	li	a5,-1
     34a:	00f50d63          	beq	a0,a5,364 <_ZN11BackCommand3runEv+0x28>
        if (fork_or_panic() == 0)
     34e:	e509                	bnez	a0,358 <_ZN11BackCommand3runEv+0x1c>
            sub_cmd->run();
     350:	6408                	ld	a0,8(s0)
     352:	611c                	ld	a5,0(a0)
     354:	6b9c                	ld	a5,16(a5)
     356:	9782                	jalr	a5
    }
     358:	6402                	ld	s0,0(sp)
     35a:	60a2                	ld	ra,8(sp)
        exit(0);
     35c:	4501                	li	a0,0
    }
     35e:	0141                	addi	sp,sp,16
        exit(0);
     360:	07e0506f          	j	53de <exit>
    printf("shell panic: %s\n", s);
     364:	00006597          	auipc	a1,0x6
     368:	c9c58593          	addi	a1,a1,-868 # 6000 <_GLOBAL__sub_I__ZSt3cin+0x58>
     36c:	00006517          	auipc	a0,0x6
     370:	c9c50513          	addi	a0,a0,-868 # 6008 <_GLOBAL__sub_I__ZSt3cin+0x60>
     374:	556040ef          	jal	48ca <printf>
    exit(1);
     378:	4505                	li	a0,1
     37a:	064050ef          	jal	53de <exit>
    }
     37e:	6402                	ld	s0,0(sp)
     380:	60a2                	ld	ra,8(sp)
        exit(0);
     382:	4501                	li	a0,0
    }
     384:	0141                	addi	sp,sp,16
        exit(0);
     386:	0580506f          	j	53de <exit>

000000000000038a <_ZN11ListCommand3runEv>:
    void run() override
     38a:	1141                	addi	sp,sp,-16
     38c:	e022                	sd	s0,0(sp)
     38e:	e406                	sd	ra,8(sp)
     390:	842a                	mv	s0,a0
    int pid = fork();
     392:	517000ef          	jal	10a8 <fork>
    if (pid == -1)
     396:	57fd                	li	a5,-1
     398:	02f50163          	beq	a0,a5,3ba <_ZN11ListCommand3runEv+0x30>
        if (fork_or_panic() == 0)
     39c:	e509                	bnez	a0,3a6 <_ZN11ListCommand3runEv+0x1c>
            left->run();
     39e:	6408                	ld	a0,8(s0)
     3a0:	611c                	ld	a5,0(a0)
     3a2:	6b9c                	ld	a5,16(a5)
     3a4:	9782                	jalr	a5
        wait(0);
     3a6:	4501                	li	a0,0
     3a8:	509000ef          	jal	10b0 <wait>
        right->run();
     3ac:	6808                	ld	a0,16(s0)
    }
     3ae:	6402                	ld	s0,0(sp)
     3b0:	60a2                	ld	ra,8(sp)
        right->run();
     3b2:	611c                	ld	a5,0(a0)
     3b4:	6b9c                	ld	a5,16(a5)
    }
     3b6:	0141                	addi	sp,sp,16
        right->run();
     3b8:	8782                	jr	a5
    printf("shell panic: %s\n", s);
     3ba:	00006597          	auipc	a1,0x6
     3be:	c4658593          	addi	a1,a1,-954 # 6000 <_GLOBAL__sub_I__ZSt3cin+0x58>
     3c2:	00006517          	auipc	a0,0x6
     3c6:	c4650513          	addi	a0,a0,-954 # 6008 <_GLOBAL__sub_I__ZSt3cin+0x60>
     3ca:	500040ef          	jal	48ca <printf>
    exit(1);
     3ce:	4505                	li	a0,1
     3d0:	00e050ef          	jal	53de <exit>
    return pid;
     3d4:	bfc9                	j	3a6 <_ZN11ListCommand3runEv+0x1c>

00000000000003d6 <_ZN11PipeCommand3runEv>:
    void run() override
     3d6:	1101                	addi	sp,sp,-32
     3d8:	e822                	sd	s0,16(sp)
     3da:	842a                	mv	s0,a0
        if (pipe(p) < 0)
     3dc:	0028                	addi	a0,sp,8
    void run() override
     3de:	ec06                	sd	ra,24(sp)
        if (pipe(p) < 0)
     3e0:	4d9000ef          	jal	10b8 <pipe>
     3e4:	0a054463          	bltz	a0,48c <_ZN11PipeCommand3runEv+0xb6>
    int pid = fork();
     3e8:	4c1000ef          	jal	10a8 <fork>
    if (pid == -1)
     3ec:	57fd                	li	a5,-1
     3ee:	0cf50163          	beq	a0,a5,4b0 <_ZN11PipeCommand3runEv+0xda>
        if (fork_or_panic() == 0)
     3f2:	c931                	beqz	a0,446 <_ZN11PipeCommand3runEv+0x70>
    int pid = fork();
     3f4:	4b5000ef          	jal	10a8 <fork>
    if (pid == -1)
     3f8:	577d                	li	a4,-1
     3fa:	06e50b63          	beq	a0,a4,470 <_ZN11PipeCommand3runEv+0x9a>
        if (fork_or_panic() == 0)
     3fe:	c505                	beqz	a0,426 <_ZN11PipeCommand3runEv+0x50>
        close(p[0]);
     400:	4522                	lw	a0,8(sp)
     402:	4cf000ef          	jal	10d0 <close>
        close(p[1]);
     406:	4532                	lw	a0,12(sp)
     408:	4c9000ef          	jal	10d0 <close>
        wait(0);
     40c:	4501                	li	a0,0
     40e:	4a3000ef          	jal	10b0 <wait>
        wait(0);
     412:	4501                	li	a0,0
     414:	49d000ef          	jal	10b0 <wait>
        exit(0);
     418:	4501                	li	a0,0
     41a:	7c5040ef          	jal	53de <exit>
    }
     41e:	60e2                	ld	ra,24(sp)
     420:	6442                	ld	s0,16(sp)
     422:	6105                	addi	sp,sp,32
     424:	8082                	ret
            close(0);  // close stdin
     426:	4ab000ef          	jal	10d0 <close>
            dup(p[0]); // dup read-end to stdin
     42a:	4522                	lw	a0,8(sp)
     42c:	4f5000ef          	jal	1120 <dup>
            close(p[0]);
     430:	4522                	lw	a0,8(sp)
     432:	49f000ef          	jal	10d0 <close>
            close(p[1]);
     436:	4532                	lw	a0,12(sp)
     438:	499000ef          	jal	10d0 <close>
            right->run();
     43c:	6808                	ld	a0,16(s0)
     43e:	611c                	ld	a5,0(a0)
     440:	6b9c                	ld	a5,16(a5)
     442:	9782                	jalr	a5
     444:	bf75                	j	400 <_ZN11PipeCommand3runEv+0x2a>
            close(1);  // close stdout
     446:	4505                	li	a0,1
     448:	489000ef          	jal	10d0 <close>
            dup(p[1]); // dup write-end to stdout
     44c:	4532                	lw	a0,12(sp)
     44e:	4d3000ef          	jal	1120 <dup>
            close(p[0]);
     452:	4522                	lw	a0,8(sp)
     454:	47d000ef          	jal	10d0 <close>
            close(p[1]);
     458:	4532                	lw	a0,12(sp)
     45a:	477000ef          	jal	10d0 <close>
            left->run();
     45e:	6408                	ld	a0,8(s0)
     460:	611c                	ld	a5,0(a0)
     462:	6b9c                	ld	a5,16(a5)
     464:	9782                	jalr	a5
    int pid = fork();
     466:	443000ef          	jal	10a8 <fork>
    if (pid == -1)
     46a:	577d                	li	a4,-1
     46c:	f8e519e3          	bne	a0,a4,3fe <_ZN11PipeCommand3runEv+0x28>
    printf("shell panic: %s\n", s);
     470:	00006597          	auipc	a1,0x6
     474:	b9058593          	addi	a1,a1,-1136 # 6000 <_GLOBAL__sub_I__ZSt3cin+0x58>
     478:	00006517          	auipc	a0,0x6
     47c:	b9050513          	addi	a0,a0,-1136 # 6008 <_GLOBAL__sub_I__ZSt3cin+0x60>
     480:	44a040ef          	jal	48ca <printf>
    exit(1);
     484:	4505                	li	a0,1
     486:	759040ef          	jal	53de <exit>
    return pid;
     48a:	bf9d                	j	400 <_ZN11PipeCommand3runEv+0x2a>
    printf("shell panic: %s\n", s);
     48c:	00006597          	auipc	a1,0x6
     490:	b9458593          	addi	a1,a1,-1132 # 6020 <_GLOBAL__sub_I__ZSt3cin+0x78>
     494:	00006517          	auipc	a0,0x6
     498:	b7450513          	addi	a0,a0,-1164 # 6008 <_GLOBAL__sub_I__ZSt3cin+0x60>
     49c:	42e040ef          	jal	48ca <printf>
    exit(1);
     4a0:	4505                	li	a0,1
     4a2:	73d040ef          	jal	53de <exit>
    int pid = fork();
     4a6:	403000ef          	jal	10a8 <fork>
    if (pid == -1)
     4aa:	57fd                	li	a5,-1
     4ac:	f4f513e3          	bne	a0,a5,3f2 <_ZN11PipeCommand3runEv+0x1c>
    printf("shell panic: %s\n", s);
     4b0:	00006597          	auipc	a1,0x6
     4b4:	b5058593          	addi	a1,a1,-1200 # 6000 <_GLOBAL__sub_I__ZSt3cin+0x58>
     4b8:	00006517          	auipc	a0,0x6
     4bc:	b5050513          	addi	a0,a0,-1200 # 6008 <_GLOBAL__sub_I__ZSt3cin+0x60>
     4c0:	40a040ef          	jal	48ca <printf>
    exit(1);
     4c4:	4505                	li	a0,1
     4c6:	719040ef          	jal	53de <exit>
    return pid;
     4ca:	b72d                	j	3f4 <_ZN11PipeCommand3runEv+0x1e>

00000000000004cc <_ZN6Parser12parse_redirsEP7CommandPPcS2_>:
        : sub_cmd(c), file(f), efile(ef), mode(m), fd(fd_in) {}
     4cc:	4785                	li	a5,1
     4ce:	1782                	slli	a5,a5,0x20
    static Command *parse_redirs(Command *cmd, char **ps, char *es)
     4d0:	7119                	addi	sp,sp,-128
        : sub_cmd(c), file(f), efile(ef), mode(m), fd(fd_in) {}
     4d2:	60178793          	addi	a5,a5,1537
    static Command *parse_redirs(Command *cmd, char **ps, char *es)
     4d6:	f8a2                	sd	s0,112(sp)
     4d8:	f4a6                	sd	s1,104(sp)
     4da:	e4d6                	sd	s5,72(sp)
     4dc:	e0da                	sd	s6,64(sp)
     4de:	f862                	sd	s8,48(sp)
     4e0:	f466                	sd	s9,40(sp)
     4e2:	fc86                	sd	ra,120(sp)
     4e4:	f0ca                	sd	s2,96(sp)
     4e6:	ecce                	sd	s3,88(sp)
     4e8:	e8d2                	sd	s4,80(sp)
     4ea:	fc5e                	sd	s7,56(sp)
     4ec:	f06a                	sd	s10,32(sp)
     4ee:	ec6e                	sd	s11,24(sp)
     4f0:	8aae                	mv	s5,a1
     4f2:	8432                	mv	s0,a2
        while (peek(ps, es, "<>"))
     4f4:	8c2a                	mv	s8,a0
     4f6:	00008497          	auipc	s1,0x8
     4fa:	96248493          	addi	s1,s1,-1694 # 7e58 <WHITESPACE>
        switch (*s)
     4fe:	03c00b13          	li	s6,60
            if (get_token(ps, es, &q, &eq) != 'a')
     502:	06100c93          	li	s9,97
        : sub_cmd(c), file(f), efile(ef), mode(m), fd(fd_in) {}
     506:	e43e                	sd	a5,8(sp)
        char *s = *ps;
     508:	000ab903          	ld	s2,0(s5)
        while (s < es && strchr(WHITESPACE, *s))
     50c:	00896663          	bltu	s2,s0,518 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x4c>
     510:	a811                	j	524 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x58>
            s++;
     512:	0905                	addi	s2,s2,1
        while (s < es && strchr(WHITESPACE, *s))
     514:	01240863          	beq	s0,s2,524 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x58>
     518:	00094583          	lbu	a1,0(s2)
     51c:	6088                	ld	a0,0(s1)
     51e:	760050ef          	jal	5c7e <strchr>
     522:	f965                	bnez	a0,512 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x46>
        *ps = s;
     524:	012ab023          	sd	s2,0(s5)
        return *s && strchr(toks, *s);
     528:	00094583          	lbu	a1,0(s2)
     52c:	e18d                	bnez	a1,54e <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x82>
    }
     52e:	70e6                	ld	ra,120(sp)
     530:	7446                	ld	s0,112(sp)
     532:	74a6                	ld	s1,104(sp)
     534:	7906                	ld	s2,96(sp)
     536:	69e6                	ld	s3,88(sp)
     538:	6a46                	ld	s4,80(sp)
     53a:	6aa6                	ld	s5,72(sp)
     53c:	6b06                	ld	s6,64(sp)
     53e:	7be2                	ld	s7,56(sp)
     540:	7ca2                	ld	s9,40(sp)
     542:	7d02                	ld	s10,32(sp)
     544:	6de2                	ld	s11,24(sp)
     546:	8562                	mv	a0,s8
     548:	7c42                	ld	s8,48(sp)
     54a:	6109                	addi	sp,sp,128
     54c:	8082                	ret
        return *s && strchr(toks, *s);
     54e:	00006517          	auipc	a0,0x6
     552:	afa50513          	addi	a0,a0,-1286 # 6048 <_GLOBAL__sub_I__ZSt3cin+0xa0>
     556:	728050ef          	jal	5c7e <strchr>
     55a:	d971                	beqz	a0,52e <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x62>
        s = *ps;
     55c:	000abd83          	ld	s11,0(s5)
        while (s < es && strchr(WHITESPACE, *s))
     560:	008de663          	bltu	s11,s0,56c <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xa0>
     564:	a811                	j	578 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xac>
            s++;
     566:	0d85                	addi	s11,s11,1
        while (s < es && strchr(WHITESPACE, *s))
     568:	01b40863          	beq	s0,s11,578 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xac>
     56c:	000dc583          	lbu	a1,0(s11)
     570:	6088                	ld	a0,0(s1)
     572:	70c050ef          	jal	5c7e <strchr>
     576:	f965                	bnez	a0,566 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x9a>
        ret = *s;
     578:	000dc983          	lbu	s3,0(s11)
        switch (*s)
     57c:	193b6e63          	bltu	s6,s3,718 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x24c>
     580:	03a00713          	li	a4,58
     584:	01376f63          	bltu	a4,s3,5a2 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xd6>
     588:	00098e63          	beqz	s3,5a4 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xd8>
     58c:	02600713          	li	a4,38
     590:	00e98963          	beq	s3,a4,5a2 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xd6>
     594:	fd89871b          	addiw	a4,s3,-40
     598:	0ff77713          	zext.b	a4,a4
     59c:	4685                	li	a3,1
     59e:	0ce6ef63          	bltu	a3,a4,67c <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1b0>
            s++;
     5a2:	0d85                	addi	s11,s11,1
        while (s < es && strchr(WHITESPACE, *s))
     5a4:	108df363          	bgeu	s11,s0,6aa <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1de>
     5a8:	8926                	mv	s2,s1
     5aa:	a021                	j	5b2 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xe6>
            s++;
     5ac:	0d85                	addi	s11,s11,1
        while (s < es && strchr(WHITESPACE, *s))
     5ae:	25b40963          	beq	s0,s11,800 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x334>
     5b2:	000dc583          	lbu	a1,0(s11)
     5b6:	6088                	ld	a0,0(s1)
     5b8:	6c6050ef          	jal	5c7e <strchr>
     5bc:	f965                	bnez	a0,5ac <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xe0>
        *ps = s;
     5be:	01bab023          	sd	s11,0(s5)
        while (s < es && strchr(WHITESPACE, *s))
     5c2:	008de663          	bltu	s11,s0,5ce <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x102>
     5c6:	a0e5                	j	6ae <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1e2>
            s++;
     5c8:	0d85                	addi	s11,s11,1
        while (s < es && strchr(WHITESPACE, *s))
     5ca:	01b40863          	beq	s0,s11,5da <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x10e>
     5ce:	000dc583          	lbu	a1,0(s11)
     5d2:	6088                	ld	a0,0(s1)
     5d4:	6aa050ef          	jal	5c7e <strchr>
     5d8:	f965                	bnez	a0,5c8 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xfc>
        ret = *s;
     5da:	000dca03          	lbu	s4,0(s11)
        switch (*s)
     5de:	154b6963          	bltu	s6,s4,730 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x264>
     5e2:	03a00713          	li	a4,58
     5e6:	01476f63          	bltu	a4,s4,604 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x138>
     5ea:	0c0a0c63          	beqz	s4,6c2 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1f6>
     5ee:	02600713          	li	a4,38
     5f2:	00ea0963          	beq	s4,a4,604 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x138>
     5f6:	fd8a071b          	addiw	a4,s4,-40
     5fa:	0ff77713          	zext.b	a4,a4
     5fe:	4685                	li	a3,1
     600:	18e6e163          	bltu	a3,a4,782 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x2b6>
        ret = *s;
     604:	8bee                	mv	s7,s11
            s++;
     606:	0d85                	addi	s11,s11,1
        ret = *s;
     608:	2a01                	sext.w	s4,s4
        while (s < es && strchr(WHITESPACE, *s))
     60a:	8926                	mv	s2,s1
     60c:	0c8df063          	bgeu	s11,s0,6cc <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x200>
        ret = *s;
     610:	8d6e                	mv	s10,s11
     612:	a021                	j	61a <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x14e>
            s++;
     614:	0d05                	addi	s10,s10,1
        while (s < es && strchr(WHITESPACE, *s))
     616:	008d7963          	bgeu	s10,s0,628 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x15c>
     61a:	000d4583          	lbu	a1,0(s10)
     61e:	00093503          	ld	a0,0(s2)
     622:	65c050ef          	jal	5c7e <strchr>
     626:	f57d                	bnez	a0,614 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x148>
        *ps = s;
     628:	01aab023          	sd	s10,0(s5)
            if (get_token(ps, es, &q, &eq) != 'a')
     62c:	0b9a1263          	bne	s4,s9,6d0 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x204>
            *eq = 0; // Null terminate filename immediately
     630:	000d8023          	sb	zero,0(s11)
            switch (tok)
     634:	0b698f63          	beq	s3,s6,6f2 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x226>
     638:	03e00713          	li	a4,62
     63c:	10e98c63          	beq	s3,a4,754 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x288>
     640:	02b00713          	li	a4,43
     644:	ece992e3          	bne	s3,a4,508 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x3c>
                cmd = new RedirCommand(cmd, q, eq, O_WRONLY | O_CREATE, 1); // Append not fully supported in simple OS yet?
     648:	02800513          	li	a0,40
     64c:	145050ef          	jal	5f90 <_Znwm>
        : sub_cmd(c), file(f), efile(ef), mode(m), fd(fd_in) {}
     650:	4705                	li	a4,1
     652:	1702                	slli	a4,a4,0x20
     654:	20170713          	addi	a4,a4,513
     658:	00007797          	auipc	a5,0x7
     65c:	77078793          	addi	a5,a5,1904 # 7dc8 <_ZTV12RedirCommand+0x10>
     660:	01853423          	sd	s8,8(a0)
     664:	e11c                	sd	a5,0(a0)
     666:	01753823          	sd	s7,16(a0)
     66a:	01b53c23          	sd	s11,24(a0)
     66e:	f118                	sd	a4,32(a0)
                cmd = new RedirCommand(cmd, q, eq, O_WRONLY | O_CREATE, 1); // Append not fully supported in simple OS yet?
     670:	8c2a                	mv	s8,a0
                break;
     672:	bd59                	j	508 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x3c>
        switch (*s)
     674:	07c00713          	li	a4,124
     678:	f2e985e3          	beq	s3,a4,5a2 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xd6>
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     67c:	008dec63          	bltu	s11,s0,694 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1c8>
     680:	a01d                	j	6a6 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1da>
     682:	000dc583          	lbu	a1,0(s11)
     686:	6488                	ld	a0,8(s1)
     688:	5f6050ef          	jal	5c7e <strchr>
     68c:	e911                	bnez	a0,6a0 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1d4>
                s++;
     68e:	0d85                	addi	s11,s11,1
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     690:	01b40b63          	beq	s0,s11,6a6 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1da>
     694:	000dc583          	lbu	a1,0(s11)
     698:	6088                	ld	a0,0(s1)
     69a:	5e4050ef          	jal	5c7e <strchr>
     69e:	d175                	beqz	a0,682 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1b6>
     6a0:	06100993          	li	s3,97
     6a4:	b701                	j	5a4 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xd8>
     6a6:	06100993          	li	s3,97
        *ps = s;
     6aa:	01bab023          	sd	s11,0(s5)
        ret = *s;
     6ae:	000dca03          	lbu	s4,0(s11)
        switch (*s)
     6b2:	114b6963          	bltu	s6,s4,7c4 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x2f8>
     6b6:	03a00713          	li	a4,58
     6ba:	f54765e3          	bltu	a4,s4,604 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x138>
     6be:	120a1063          	bnez	s4,7de <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x312>
        while (s < es && strchr(WHITESPACE, *s))
     6c2:	8bee                	mv	s7,s11
        ret = *s;
     6c4:	4a01                	li	s4,0
     6c6:	8926                	mv	s2,s1
        while (s < es && strchr(WHITESPACE, *s))
     6c8:	f48de4e3          	bltu	s11,s0,610 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x144>
        *ps = s;
     6cc:	01bab023          	sd	s11,0(s5)
    printf("shell panic: %s\n", s);
     6d0:	00006597          	auipc	a1,0x6
     6d4:	95858593          	addi	a1,a1,-1704 # 6028 <_GLOBAL__sub_I__ZSt3cin+0x80>
     6d8:	00006517          	auipc	a0,0x6
     6dc:	93050513          	addi	a0,a0,-1744 # 6008 <_GLOBAL__sub_I__ZSt3cin+0x60>
     6e0:	1ea040ef          	jal	48ca <printf>
    exit(1);
     6e4:	4505                	li	a0,1
     6e6:	4f9040ef          	jal	53de <exit>
            *eq = 0; // Null terminate filename immediately
     6ea:	000d8023          	sb	zero,0(s11)
            switch (tok)
     6ee:	f56995e3          	bne	s3,s6,638 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x16c>
                cmd = new RedirCommand(cmd, q, eq, O_RDONLY, 0);
     6f2:	02800513          	li	a0,40
     6f6:	09b050ef          	jal	5f90 <_Znwm>
        : sub_cmd(c), file(f), efile(ef), mode(m), fd(fd_in) {}
     6fa:	00007797          	auipc	a5,0x7
     6fe:	6ce78793          	addi	a5,a5,1742 # 7dc8 <_ZTV12RedirCommand+0x10>
     702:	01853423          	sd	s8,8(a0)
     706:	e11c                	sd	a5,0(a0)
     708:	01753823          	sd	s7,16(a0)
     70c:	01b53c23          	sd	s11,24(a0)
     710:	02053023          	sd	zero,32(a0)
                cmd = new RedirCommand(cmd, q, eq, O_RDONLY, 0);
     714:	8c2a                	mv	s8,a0
                break;
     716:	bbcd                	j	508 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x3c>
        switch (*s)
     718:	03e00713          	li	a4,62
     71c:	f4e99ce3          	bne	s3,a4,674 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1a8>
            if (*s == '>')
     720:	001dc703          	lbu	a4,1(s11)
     724:	e7371fe3          	bne	a4,s3,5a2 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xd6>
                s++;
     728:	0d89                	addi	s11,s11,2
     72a:	02b00993          	li	s3,43
     72e:	bd9d                	j	5a4 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0xd8>
        switch (*s)
     730:	03e00713          	li	a4,62
     734:	8bee                	mv	s7,s11
     736:	04ea1263          	bne	s4,a4,77a <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x2ae>
            if (*s == '>')
     73a:	001dc683          	lbu	a3,1(s11)
     73e:	03e00713          	li	a4,62
     742:	06e68a63          	beq	a3,a4,7b6 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x2ea>
            s++;
     746:	0d85                	addi	s11,s11,1
        ret = *s;
     748:	03e00a13          	li	s4,62
     74c:	8926                	mv	s2,s1
        while (s < es && strchr(WHITESPACE, *s))
     74e:	ec8de1e3          	bltu	s11,s0,610 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x144>
     752:	bfad                	j	6cc <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x200>
                cmd = new RedirCommand(cmd, q, eq, O_WRONLY | O_CREATE | O_TRUNC, 1);
     754:	02800513          	li	a0,40
     758:	039050ef          	jal	5f90 <_Znwm>
        : sub_cmd(c), file(f), efile(ef), mode(m), fd(fd_in) {}
     75c:	00007797          	auipc	a5,0x7
     760:	66c78793          	addi	a5,a5,1644 # 7dc8 <_ZTV12RedirCommand+0x10>
     764:	e11c                	sd	a5,0(a0)
     766:	67a2                	ld	a5,8(sp)
     768:	01853423          	sd	s8,8(a0)
     76c:	01753823          	sd	s7,16(a0)
     770:	01b53c23          	sd	s11,24(a0)
     774:	f11c                	sd	a5,32(a0)
                cmd = new RedirCommand(cmd, q, eq, O_WRONLY | O_CREATE | O_TRUNC, 1);
     776:	8c2a                	mv	s8,a0
                break;
     778:	bb41                	j	508 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x3c>
        switch (*s)
     77a:	07c00713          	li	a4,124
     77e:	e8ea03e3          	beq	s4,a4,604 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x138>
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     782:	048dfa63          	bgeu	s11,s0,7d6 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x30a>
     786:	8d6e                	mv	s10,s11
     788:	a811                	j	79c <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x2d0>
     78a:	000d4583          	lbu	a1,0(s10)
     78e:	6488                	ld	a0,8(s1)
     790:	4ee050ef          	jal	5c7e <strchr>
     794:	e911                	bnez	a0,7a8 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x2dc>
                s++;
     796:	0d05                	addi	s10,s10,1
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     798:	05a40f63          	beq	s0,s10,7f6 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x32a>
     79c:	000d4583          	lbu	a1,0(s10)
     7a0:	6088                	ld	a0,0(s1)
     7a2:	4dc050ef          	jal	5c7e <strchr>
     7a6:	d175                	beqz	a0,78a <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x2be>
        while (s < es && strchr(WHITESPACE, *s))
     7a8:	048d7763          	bgeu	s10,s0,7f6 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x32a>
     7ac:	8bee                	mv	s7,s11
     7ae:	06100a13          	li	s4,97
     7b2:	8dea                	mv	s11,s10
     7b4:	bdb1                	j	610 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x144>
                s++;
     7b6:	0d89                	addi	s11,s11,2
                ret = '+';
     7b8:	02b00a13          	li	s4,43
     7bc:	8926                	mv	s2,s1
        while (s < es && strchr(WHITESPACE, *s))
     7be:	e48de9e3          	bltu	s11,s0,610 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x144>
     7c2:	b729                	j	6cc <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x200>
        switch (*s)
     7c4:	03e00713          	li	a4,62
     7c8:	8bee                	mv	s7,s11
     7ca:	f6ea08e3          	beq	s4,a4,73a <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x26e>
     7ce:	07c00713          	li	a4,124
     7d2:	e2ea09e3          	beq	s4,a4,604 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x138>
        *ps = s;
     7d6:	01bab023          	sd	s11,0(s5)
     7da:	8bee                	mv	s7,s11
     7dc:	bd91                	j	630 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x164>
        switch (*s)
     7de:	02600713          	li	a4,38
     7e2:	e2ea01e3          	beq	s4,a4,604 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x138>
     7e6:	fd8a071b          	addiw	a4,s4,-40
     7ea:	0ff77713          	zext.b	a4,a4
     7ee:	4685                	li	a3,1
     7f0:	e0e6fae3          	bgeu	a3,a4,604 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x138>
     7f4:	b7cd                	j	7d6 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x30a>
        *ps = s;
     7f6:	8bee                	mv	s7,s11
     7f8:	01aab023          	sd	s10,0(s5)
     7fc:	8dea                	mv	s11,s10
     7fe:	bd0d                	j	630 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x164>
     800:	008ab023          	sd	s0,0(s5)
        while (s < es && strchr(WHITESPACE, *s))
     804:	b56d                	j	6ae <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1e2>

0000000000000806 <_ZN6Parser10parse_pipeEPPcS0_>:
    static Command *parse_pipe(char **ps, char *es)
     806:	7119                	addi	sp,sp,-128
     808:	e8d2                	sd	s4,80(sp)
     80a:	8a2a                	mv	s4,a0
        ExecCommand *cmd = new ExecCommand();
     80c:	05800513          	li	a0,88
    static Command *parse_pipe(char **ps, char *es)
     810:	fc86                	sd	ra,120(sp)
     812:	f8a2                	sd	s0,112(sp)
     814:	f4a6                	sd	s1,104(sp)
     816:	842e                	mv	s0,a1
     818:	e4d6                	sd	s5,72(sp)
     81a:	e0da                	sd	s6,64(sp)
     81c:	fc5e                	sd	s7,56(sp)
     81e:	f466                	sd	s9,40(sp)
     820:	f06a                	sd	s10,32(sp)
     822:	f0ca                	sd	s2,96(sp)
     824:	ecce                	sd	s3,88(sp)
     826:	f862                	sd	s8,48(sp)
     828:	ec6e                	sd	s11,24(sp)
        ExecCommand *cmd = new ExecCommand();
     82a:	766050ef          	jal	5f90 <_Znwm>
     82e:	84aa                	mv	s1,a0
    {
     830:	00007797          	auipc	a5,0x7
     834:	57078793          	addi	a5,a5,1392 # 7da0 <_ZTV11ExecCommand+0x10>
        memset(argv, 0, sizeof(argv));
     838:	00850b93          	addi	s7,a0,8
    {
     83c:	e09c                	sd	a5,0(s1)
        ExecCommand *cmd = new ExecCommand();
     83e:	e42a                	sd	a0,8(sp)
        memset(argv, 0, sizeof(argv));
     840:	05000613          	li	a2,80
     844:	4581                	li	a1,0
     846:	855e                	mv	a0,s7
     848:	248050ef          	jal	5a90 <memset>
        ret = parse_redirs(ret, ps, es);
     84c:	8526                	mv	a0,s1
     84e:	8622                	mv	a2,s0
     850:	85d2                	mv	a1,s4
     852:	c7bff0ef          	jal	4cc <_ZN6Parser12parse_redirsEP7CommandPPcS2_>
        char *s = *ps;
     856:	000a3d03          	ld	s10,0(s4)
        ret = parse_redirs(ret, ps, es);
     85a:	8aaa                	mv	s5,a0
        argc = 0;
     85c:	4b01                	li	s6,0
        while (s < es && strchr(WHITESPACE, *s))
     85e:	00007497          	auipc	s1,0x7
     862:	5fa48493          	addi	s1,s1,1530 # 7e58 <WHITESPACE>
            if (*s == '>')
     866:	03e00c93          	li	s9,62
        while (s < es && strchr(WHITESPACE, *s))
     86a:	0c8d7f63          	bgeu	s10,s0,948 <_ZN6Parser10parse_pipeEPPcS0_+0x142>
     86e:	89a6                	mv	s3,s1
     870:	a021                	j	878 <_ZN6Parser10parse_pipeEPPcS0_+0x72>
            s++;
     872:	0d05                	addi	s10,s10,1
        while (s < es && strchr(WHITESPACE, *s))
     874:	01a40863          	beq	s0,s10,884 <_ZN6Parser10parse_pipeEPPcS0_+0x7e>
     878:	000d4583          	lbu	a1,0(s10)
     87c:	6088                	ld	a0,0(s1)
     87e:	400050ef          	jal	5c7e <strchr>
     882:	f965                	bnez	a0,872 <_ZN6Parser10parse_pipeEPPcS0_+0x6c>
        *ps = s;
     884:	01aa3023          	sd	s10,0(s4)
        return *s && strchr(toks, *s);
     888:	000d4583          	lbu	a1,0(s10)
     88c:	10059063          	bnez	a1,98c <_ZN6Parser10parse_pipeEPPcS0_+0x186>
        while (s < es && strchr(WHITESPACE, *s))
     890:	008d6863          	bltu	s10,s0,8a0 <_ZN6Parser10parse_pipeEPPcS0_+0x9a>
     894:	a6ad                	j	bfe <_ZN6Parser10parse_pipeEPPcS0_+0x3f8>
            s++;
     896:	0d05                	addi	s10,s10,1
        ret = *s;
     898:	000d4903          	lbu	s2,0(s10)
        while (s < es && strchr(WHITESPACE, *s))
     89c:	0ba40f63          	beq	s0,s10,95a <_ZN6Parser10parse_pipeEPPcS0_+0x154>
     8a0:	000d4583          	lbu	a1,0(s10)
     8a4:	6088                	ld	a0,0(s1)
     8a6:	3d8050ef          	jal	5c7e <strchr>
     8aa:	f575                	bnez	a0,896 <_ZN6Parser10parse_pipeEPPcS0_+0x90>
        ret = *s;
     8ac:	000d4903          	lbu	s2,0(s10)
        switch (*s)
     8b0:	08090f63          	beqz	s2,94e <_ZN6Parser10parse_pipeEPPcS0_+0x148>
     8b4:	1b990663          	beq	s2,s9,a60 <_ZN6Parser10parse_pipeEPPcS0_+0x25a>
     8b8:	2d2ceb63          	bltu	s9,s2,b8e <_ZN6Parser10parse_pipeEPPcS0_+0x388>
     8bc:	02900713          	li	a4,41
     8c0:	29276663          	bltu	a4,s2,b4c <_ZN6Parser10parse_pipeEPPcS0_+0x346>
     8c4:	02700713          	li	a4,39
     8c8:	01276663          	bltu	a4,s2,8d4 <_ZN6Parser10parse_pipeEPPcS0_+0xce>
     8cc:	02600713          	li	a4,38
     8d0:	28e91563          	bne	s2,a4,b5a <_ZN6Parser10parse_pipeEPPcS0_+0x354>
        ret = *s;
     8d4:	8c6a                	mv	s8,s10
            s++;
     8d6:	0d05                	addi	s10,s10,1
        ret = *s;
     8d8:	2901                	sext.w	s2,s2
     8da:	89a6                	mv	s3,s1
        while (s < es && strchr(WHITESPACE, *s))
     8dc:	168d7f63          	bgeu	s10,s0,a5a <_ZN6Parser10parse_pipeEPPcS0_+0x254>
        ret = *s;
     8e0:	8dea                	mv	s11,s10
     8e2:	a021                	j	8ea <_ZN6Parser10parse_pipeEPPcS0_+0xe4>
            s++;
     8e4:	0d85                	addi	s11,s11,1
        while (s < es && strchr(WHITESPACE, *s))
     8e6:	008df963          	bgeu	s11,s0,8f8 <_ZN6Parser10parse_pipeEPPcS0_+0xf2>
     8ea:	000dc583          	lbu	a1,0(s11)
     8ee:	0009b503          	ld	a0,0(s3)
     8f2:	38c050ef          	jal	5c7e <strchr>
     8f6:	f57d                	bnez	a0,8e4 <_ZN6Parser10parse_pipeEPPcS0_+0xde>
        *ps = s;
     8f8:	01ba3023          	sd	s11,0(s4)
            if ((tok = get_token(ps, es, &q, &eq)) == 0)
     8fc:	0a090163          	beqz	s2,99e <_ZN6Parser10parse_pipeEPPcS0_+0x198>
            if (tok != 'a')
     900:	06100793          	li	a5,97
     904:	00f90f63          	beq	s2,a5,922 <_ZN6Parser10parse_pipeEPPcS0_+0x11c>
    printf("shell panic: %s\n", s);
     908:	00005597          	auipc	a1,0x5
     90c:	74858593          	addi	a1,a1,1864 # 6050 <_GLOBAL__sub_I__ZSt3cin+0xa8>
     910:	00005517          	auipc	a0,0x5
     914:	6f850513          	addi	a0,a0,1784 # 6008 <_GLOBAL__sub_I__ZSt3cin+0x60>
     918:	7b3030ef          	jal	48ca <printf>
    exit(1);
     91c:	4505                	li	a0,1
     91e:	2c1040ef          	jal	53de <exit>
            cmd->argv[argc] = q;
     922:	018bb023          	sd	s8,0(s7)
            *eq = 0; // Temp
     926:	000d0023          	sb	zero,0(s10)
            argc++;
     92a:	2b05                	addiw	s6,s6,1
            if (argc >= MAX_ARGS)
     92c:	47a5                	li	a5,9
     92e:	0d67c463          	blt	a5,s6,9f6 <_ZN6Parser10parse_pipeEPPcS0_+0x1f0>
            ret = parse_redirs(ret, ps, es);
     932:	8556                	mv	a0,s5
     934:	8622                	mv	a2,s0
     936:	85d2                	mv	a1,s4
     938:	b95ff0ef          	jal	4cc <_ZN6Parser12parse_redirsEP7CommandPPcS2_>
        char *s = *ps;
     93c:	000a3d03          	ld	s10,0(s4)
            ret = parse_redirs(ret, ps, es);
     940:	8aaa                	mv	s5,a0
     942:	0ba1                	addi	s7,s7,8
        while (s < es && strchr(WHITESPACE, *s))
     944:	f28d65e3          	bltu	s10,s0,86e <_ZN6Parser10parse_pipeEPPcS0_+0x68>
        return *s && strchr(toks, *s);
     948:	000d4583          	lbu	a1,0(s10)
     94c:	e1a1                	bnez	a1,98c <_ZN6Parser10parse_pipeEPPcS0_+0x186>
        while (s < es && strchr(WHITESPACE, *s))
     94e:	2a8d7863          	bgeu	s10,s0,bfe <_ZN6Parser10parse_pipeEPPcS0_+0x3f8>
     952:	8c6a                	mv	s8,s10
        ret = *s;
     954:	4901                	li	s2,0
     956:	89a6                	mv	s3,s1
     958:	b761                	j	8e0 <_ZN6Parser10parse_pipeEPPcS0_+0xda>
        switch (*s)
     95a:	0f990463          	beq	s2,s9,a42 <_ZN6Parser10parse_pipeEPPcS0_+0x23c>
     95e:	0d2cea63          	bltu	s9,s2,a32 <_ZN6Parser10parse_pipeEPPcS0_+0x22c>
     962:	02900793          	li	a5,41
     966:	1127ef63          	bltu	a5,s2,a84 <_ZN6Parser10parse_pipeEPPcS0_+0x27e>
     96a:	02700713          	li	a4,39
     96e:	f72763e3          	bltu	a4,s2,8d4 <_ZN6Parser10parse_pipeEPPcS0_+0xce>
     972:	28090663          	beqz	s2,bfe <_ZN6Parser10parse_pipeEPPcS0_+0x3f8>
     976:	02600713          	li	a4,38
     97a:	0ce91063          	bne	s2,a4,a3a <_ZN6Parser10parse_pipeEPPcS0_+0x234>
        ret = *s;
     97e:	8c6a                	mv	s8,s10
            s++;
     980:	0d05                	addi	s10,s10,1
        ret = *s;
     982:	2901                	sext.w	s2,s2
     984:	89a6                	mv	s3,s1
        while (s < es && strchr(WHITESPACE, *s))
     986:	f48d6de3          	bltu	s10,s0,8e0 <_ZN6Parser10parse_pipeEPPcS0_+0xda>
     98a:	a8c1                	j	a5a <_ZN6Parser10parse_pipeEPPcS0_+0x254>
        return *s && strchr(toks, *s);
     98c:	00005517          	auipc	a0,0x5
     990:	6dc50513          	addi	a0,a0,1756 # 6068 <_GLOBAL__sub_I__ZSt3cin+0xc0>
     994:	2ea050ef          	jal	5c7e <strchr>
     998:	cd2d                	beqz	a0,a12 <_ZN6Parser10parse_pipeEPPcS0_+0x20c>
        char *s = *ps;
     99a:	000a3d83          	ld	s11,0(s4)
        cmd->argv[argc] = 0;
     99e:	67a2                	ld	a5,8(sp)
     9a0:	0b0e                	slli	s6,s6,0x3
     9a2:	97da                	add	a5,a5,s6
     9a4:	0007b423          	sd	zero,8(a5)
        while (s < es && strchr(WHITESPACE, *s))
     9a8:	028df163          	bgeu	s11,s0,9ca <_ZN6Parser10parse_pipeEPPcS0_+0x1c4>
     9ac:	00007997          	auipc	s3,0x7
     9b0:	4ac98993          	addi	s3,s3,1196 # 7e58 <WHITESPACE>
     9b4:	a021                	j	9bc <_ZN6Parser10parse_pipeEPPcS0_+0x1b6>
            s++;
     9b6:	0d85                	addi	s11,s11,1
        while (s < es && strchr(WHITESPACE, *s))
     9b8:	01b40963          	beq	s0,s11,9ca <_ZN6Parser10parse_pipeEPPcS0_+0x1c4>
     9bc:	000dc583          	lbu	a1,0(s11)
     9c0:	0009b503          	ld	a0,0(s3)
     9c4:	2ba050ef          	jal	5c7e <strchr>
     9c8:	f57d                	bnez	a0,9b6 <_ZN6Parser10parse_pipeEPPcS0_+0x1b0>
        *ps = s;
     9ca:	01ba3023          	sd	s11,0(s4)
        return *s && strchr(toks, *s);
     9ce:	000dc583          	lbu	a1,0(s11)
     9d2:	e5f9                	bnez	a1,aa0 <_ZN6Parser10parse_pipeEPPcS0_+0x29a>
        Command *cmd = parse_exec(ps, es);
     9d4:	8456                	mv	s0,s5
    }
     9d6:	70e6                	ld	ra,120(sp)
     9d8:	8522                	mv	a0,s0
     9da:	7446                	ld	s0,112(sp)
     9dc:	74a6                	ld	s1,104(sp)
     9de:	7906                	ld	s2,96(sp)
     9e0:	69e6                	ld	s3,88(sp)
     9e2:	6a46                	ld	s4,80(sp)
     9e4:	6aa6                	ld	s5,72(sp)
     9e6:	6b06                	ld	s6,64(sp)
     9e8:	7be2                	ld	s7,56(sp)
     9ea:	7c42                	ld	s8,48(sp)
     9ec:	7ca2                	ld	s9,40(sp)
     9ee:	7d02                	ld	s10,32(sp)
     9f0:	6de2                	ld	s11,24(sp)
     9f2:	6109                	addi	sp,sp,128
     9f4:	8082                	ret
    printf("shell panic: %s\n", s);
     9f6:	00005597          	auipc	a1,0x5
     9fa:	66258593          	addi	a1,a1,1634 # 6058 <_GLOBAL__sub_I__ZSt3cin+0xb0>
     9fe:	00005517          	auipc	a0,0x5
     a02:	60a50513          	addi	a0,a0,1546 # 6008 <_GLOBAL__sub_I__ZSt3cin+0x60>
     a06:	6c5030ef          	jal	48ca <printf>
    exit(1);
     a0a:	4505                	li	a0,1
     a0c:	1d3040ef          	jal	53de <exit>
}
     a10:	b70d                	j	932 <_ZN6Parser10parse_pipeEPPcS0_+0x12c>
        char *s = *ps;
     a12:	000a3d03          	ld	s10,0(s4)
     a16:	89a6                	mv	s3,s1
        ret = *s;
     a18:	000d4903          	lbu	s2,0(s10)
        while (s < es && strchr(WHITESPACE, *s))
     a1c:	e88d62e3          	bltu	s10,s0,8a0 <_ZN6Parser10parse_pipeEPPcS0_+0x9a>
        switch (*s)
     a20:	03c00713          	li	a4,60
     a24:	1f277163          	bgeu	a4,s2,c06 <_ZN6Parser10parse_pipeEPPcS0_+0x400>
     a28:	03e00713          	li	a4,62
     a2c:	8c6a                	mv	s8,s10
     a2e:	00e90b63          	beq	s2,a4,a44 <_ZN6Parser10parse_pipeEPPcS0_+0x23e>
     a32:	07c00713          	li	a4,124
     a36:	e8e90fe3          	beq	s2,a4,8d4 <_ZN6Parser10parse_pipeEPPcS0_+0xce>
        *ps = s;
     a3a:	01aa3023          	sd	s10,0(s4)
     a3e:	8c6a                	mv	s8,s10
     a40:	b5cd                	j	922 <_ZN6Parser10parse_pipeEPPcS0_+0x11c>
        switch (*s)
     a42:	8c22                	mv	s8,s0
            if (*s == '>')
     a44:	001c4783          	lbu	a5,1(s8)
     a48:	03978163          	beq	a5,s9,a6a <_ZN6Parser10parse_pipeEPPcS0_+0x264>
            s++;
     a4c:	001c0d13          	addi	s10,s8,1
        ret = *s;
     a50:	03e00913          	li	s2,62
     a54:	89a6                	mv	s3,s1
        while (s < es && strchr(WHITESPACE, *s))
     a56:	e88d65e3          	bltu	s10,s0,8e0 <_ZN6Parser10parse_pipeEPPcS0_+0xda>
        *ps = s;
     a5a:	01aa3023          	sd	s10,0(s4)
            if (tok != 'a')
     a5e:	b56d                	j	908 <_ZN6Parser10parse_pipeEPPcS0_+0x102>
        switch (*s)
     a60:	8c6a                	mv	s8,s10
            if (*s == '>')
     a62:	001c4783          	lbu	a5,1(s8)
     a66:	ff9793e3          	bne	a5,s9,a4c <_ZN6Parser10parse_pipeEPPcS0_+0x246>
                s++;
     a6a:	002c0d13          	addi	s10,s8,2
                ret = '+';
     a6e:	02b00913          	li	s2,43
     a72:	00007997          	auipc	s3,0x7
     a76:	3e698993          	addi	s3,s3,998 # 7e58 <WHITESPACE>
        while (s < es && strchr(WHITESPACE, *s))
     a7a:	e68d63e3          	bltu	s10,s0,8e0 <_ZN6Parser10parse_pipeEPPcS0_+0xda>
        *ps = s;
     a7e:	01aa3023          	sd	s10,0(s4)
            if (tok != 'a')
     a82:	b559                	j	908 <_ZN6Parser10parse_pipeEPPcS0_+0x102>
        switch (*s)
     a84:	fc59071b          	addiw	a4,s2,-59
     a88:	0ff77713          	zext.b	a4,a4
     a8c:	4685                	li	a3,1
     a8e:	fae6e6e3          	bltu	a3,a4,a3a <_ZN6Parser10parse_pipeEPPcS0_+0x234>
        ret = *s;
     a92:	8c6a                	mv	s8,s10
            s++;
     a94:	0d05                	addi	s10,s10,1
        ret = *s;
     a96:	2901                	sext.w	s2,s2
     a98:	89a6                	mv	s3,s1
        while (s < es && strchr(WHITESPACE, *s))
     a9a:	e48d63e3          	bltu	s10,s0,8e0 <_ZN6Parser10parse_pipeEPPcS0_+0xda>
     a9e:	bf75                	j	a5a <_ZN6Parser10parse_pipeEPPcS0_+0x254>
        return *s && strchr(toks, *s);
     aa0:	00005517          	auipc	a0,0x5
     aa4:	5d050513          	addi	a0,a0,1488 # 6070 <_GLOBAL__sub_I__ZSt3cin+0xc8>
     aa8:	1d6050ef          	jal	5c7e <strchr>
     aac:	d505                	beqz	a0,9d4 <_ZN6Parser10parse_pipeEPPcS0_+0x1ce>
        s = *ps;
     aae:	000a3483          	ld	s1,0(s4)
        while (s < es && strchr(WHITESPACE, *s))
     ab2:	0284f163          	bgeu	s1,s0,ad4 <_ZN6Parser10parse_pipeEPPcS0_+0x2ce>
     ab6:	00007997          	auipc	s3,0x7
     aba:	3a298993          	addi	s3,s3,930 # 7e58 <WHITESPACE>
     abe:	a021                	j	ac6 <_ZN6Parser10parse_pipeEPPcS0_+0x2c0>
            s++;
     ac0:	0485                	addi	s1,s1,1
        while (s < es && strchr(WHITESPACE, *s))
     ac2:	00940963          	beq	s0,s1,ad4 <_ZN6Parser10parse_pipeEPPcS0_+0x2ce>
     ac6:	0004c583          	lbu	a1,0(s1)
     aca:	0009b503          	ld	a0,0(s3)
     ace:	1b0050ef          	jal	5c7e <strchr>
     ad2:	f57d                	bnez	a0,ac0 <_ZN6Parser10parse_pipeEPPcS0_+0x2ba>
        ret = *s;
     ad4:	0004c783          	lbu	a5,0(s1)
        switch (*s)
     ad8:	03c00713          	li	a4,60
     adc:	0cf76963          	bltu	a4,a5,bae <_ZN6Parser10parse_pipeEPPcS0_+0x3a8>
     ae0:	03a00713          	li	a4,58
     ae4:	00f76e63          	bltu	a4,a5,b00 <_ZN6Parser10parse_pipeEPPcS0_+0x2fa>
     ae8:	cf89                	beqz	a5,b02 <_ZN6Parser10parse_pipeEPPcS0_+0x2fc>
     aea:	02600713          	li	a4,38
     aee:	00e78963          	beq	a5,a4,b00 <_ZN6Parser10parse_pipeEPPcS0_+0x2fa>
     af2:	fd87879b          	addiw	a5,a5,-40
     af6:	0ff7f793          	zext.b	a5,a5
     afa:	4705                	li	a4,1
     afc:	0cf76763          	bltu	a4,a5,bca <_ZN6Parser10parse_pipeEPPcS0_+0x3c4>
            s++;
     b00:	0485                	addi	s1,s1,1
        while (s < es && strchr(WHITESPACE, *s))
     b02:	00007997          	auipc	s3,0x7
     b06:	35698993          	addi	s3,s3,854 # 7e58 <WHITESPACE>
     b0a:	0084e663          	bltu	s1,s0,b16 <_ZN6Parser10parse_pipeEPPcS0_+0x310>
     b0e:	a819                	j	b24 <_ZN6Parser10parse_pipeEPPcS0_+0x31e>
            s++;
     b10:	0485                	addi	s1,s1,1
        while (s < es && strchr(WHITESPACE, *s))
     b12:	0e940463          	beq	s0,s1,bfa <_ZN6Parser10parse_pipeEPPcS0_+0x3f4>
     b16:	0004c583          	lbu	a1,0(s1)
     b1a:	0009b503          	ld	a0,0(s3)
     b1e:	160050ef          	jal	5c7e <strchr>
     b22:	f57d                	bnez	a0,b10 <_ZN6Parser10parse_pipeEPPcS0_+0x30a>
        *ps = s;
     b24:	009a3023          	sd	s1,0(s4)
            cmd = new PipeCommand(cmd, parse_pipe(ps, es));
     b28:	4561                	li	a0,24
     b2a:	466050ef          	jal	5f90 <_Znwm>
     b2e:	87aa                	mv	a5,a0
     b30:	85a2                	mv	a1,s0
     b32:	8552                	mv	a0,s4
     b34:	843e                	mv	s0,a5
     b36:	cd1ff0ef          	jal	806 <_ZN6Parser10parse_pipeEPPcS0_>
    PipeCommand(Command *l, Command *r) : left(l), right(r) {}
     b3a:	00007797          	auipc	a5,0x7
     b3e:	2b678793          	addi	a5,a5,694 # 7df0 <_ZTV11PipeCommand+0x10>
     b42:	e01c                	sd	a5,0(s0)
     b44:	01543423          	sd	s5,8(s0)
     b48:	e808                	sd	a0,16(s0)
     b4a:	b571                	j	9d6 <_ZN6Parser10parse_pipeEPPcS0_+0x1d0>
        switch (*s)
     b4c:	fc59071b          	addiw	a4,s2,-59
     b50:	0ff77713          	zext.b	a4,a4
     b54:	4685                	li	a3,1
     b56:	d6e6ffe3          	bgeu	a3,a4,8d4 <_ZN6Parser10parse_pipeEPPcS0_+0xce>
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     b5a:	ee8d70e3          	bgeu	s10,s0,a3a <_ZN6Parser10parse_pipeEPPcS0_+0x234>
     b5e:	8dea                	mv	s11,s10
     b60:	a811                	j	b74 <_ZN6Parser10parse_pipeEPPcS0_+0x36e>
     b62:	000dc583          	lbu	a1,0(s11)
     b66:	6488                	ld	a0,8(s1)
     b68:	116050ef          	jal	5c7e <strchr>
     b6c:	e911                	bnez	a0,b80 <_ZN6Parser10parse_pipeEPPcS0_+0x37a>
                s++;
     b6e:	0d85                	addi	s11,s11,1
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     b70:	03b40a63          	beq	s0,s11,ba4 <_ZN6Parser10parse_pipeEPPcS0_+0x39e>
     b74:	000dc583          	lbu	a1,0(s11)
     b78:	6088                	ld	a0,0(s1)
     b7a:	104050ef          	jal	5c7e <strchr>
     b7e:	d175                	beqz	a0,b62 <_ZN6Parser10parse_pipeEPPcS0_+0x35c>
        while (s < es && strchr(WHITESPACE, *s))
     b80:	8c6a                	mv	s8,s10
     b82:	0a8df463          	bgeu	s11,s0,c2a <_ZN6Parser10parse_pipeEPPcS0_+0x424>
     b86:	06100913          	li	s2,97
     b8a:	8d6e                	mv	s10,s11
     b8c:	bb91                	j	8e0 <_ZN6Parser10parse_pipeEPPcS0_+0xda>
        switch (*s)
     b8e:	07c00713          	li	a4,124
     b92:	fce914e3          	bne	s2,a4,b5a <_ZN6Parser10parse_pipeEPPcS0_+0x354>
        ret = *s;
     b96:	8c6a                	mv	s8,s10
            s++;
     b98:	0d05                	addi	s10,s10,1
        ret = *s;
     b9a:	2901                	sext.w	s2,s2
     b9c:	89a6                	mv	s3,s1
        while (s < es && strchr(WHITESPACE, *s))
     b9e:	d48d61e3          	bltu	s10,s0,8e0 <_ZN6Parser10parse_pipeEPPcS0_+0xda>
     ba2:	bd65                	j	a5a <_ZN6Parser10parse_pipeEPPcS0_+0x254>
        *ps = s;
     ba4:	8c6a                	mv	s8,s10
     ba6:	008a3023          	sd	s0,0(s4)
     baa:	8d22                	mv	s10,s0
     bac:	bb9d                	j	922 <_ZN6Parser10parse_pipeEPPcS0_+0x11c>
        switch (*s)
     bae:	03e00713          	li	a4,62
     bb2:	00e79863          	bne	a5,a4,bc2 <_ZN6Parser10parse_pipeEPPcS0_+0x3bc>
            if (*s == '>')
     bb6:	0014c703          	lbu	a4,1(s1)
     bba:	f4f713e3          	bne	a4,a5,b00 <_ZN6Parser10parse_pipeEPPcS0_+0x2fa>
                s++;
     bbe:	0489                	addi	s1,s1,2
     bc0:	b789                	j	b02 <_ZN6Parser10parse_pipeEPPcS0_+0x2fc>
        switch (*s)
     bc2:	07c00713          	li	a4,124
     bc6:	f2e78de3          	beq	a5,a4,b00 <_ZN6Parser10parse_pipeEPPcS0_+0x2fa>
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     bca:	f484fde3          	bgeu	s1,s0,b24 <_ZN6Parser10parse_pipeEPPcS0_+0x31e>
     bce:	00007997          	auipc	s3,0x7
     bd2:	28a98993          	addi	s3,s3,650 # 7e58 <WHITESPACE>
     bd6:	0004c583          	lbu	a1,0(s1)
     bda:	0009b503          	ld	a0,0(s3)
     bde:	0a0050ef          	jal	5c7e <strchr>
     be2:	f105                	bnez	a0,b02 <_ZN6Parser10parse_pipeEPPcS0_+0x2fc>
     be4:	0004c583          	lbu	a1,0(s1)
     be8:	0089b503          	ld	a0,8(s3)
     bec:	092050ef          	jal	5c7e <strchr>
     bf0:	f00519e3          	bnez	a0,b02 <_ZN6Parser10parse_pipeEPPcS0_+0x2fc>
                s++;
     bf4:	0485                	addi	s1,s1,1
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     bf6:	fe9410e3          	bne	s0,s1,bd6 <_ZN6Parser10parse_pipeEPPcS0_+0x3d0>
     bfa:	84a2                	mv	s1,s0
     bfc:	b725                	j	b24 <_ZN6Parser10parse_pipeEPPcS0_+0x31e>
        *ps = s;
     bfe:	01aa3023          	sd	s10,0(s4)
     c02:	8dea                	mv	s11,s10
     c04:	bb69                	j	99e <_ZN6Parser10parse_pipeEPPcS0_+0x198>
        switch (*s)
     c06:	03a00713          	li	a4,58
     c0a:	cd2765e3          	bltu	a4,s2,8d4 <_ZN6Parser10parse_pipeEPPcS0_+0xce>
     c0e:	fe0908e3          	beqz	s2,bfe <_ZN6Parser10parse_pipeEPPcS0_+0x3f8>
     c12:	02600713          	li	a4,38
     c16:	cae90fe3          	beq	s2,a4,8d4 <_ZN6Parser10parse_pipeEPPcS0_+0xce>
     c1a:	fd89071b          	addiw	a4,s2,-40
     c1e:	0ff77713          	zext.b	a4,a4
     c22:	4685                	li	a3,1
     c24:	cae6f8e3          	bgeu	a3,a4,8d4 <_ZN6Parser10parse_pipeEPPcS0_+0xce>
     c28:	bd09                	j	a3a <_ZN6Parser10parse_pipeEPPcS0_+0x234>
        *ps = s;
     c2a:	01ba3023          	sd	s11,0(s4)
     c2e:	8d6e                	mv	s10,s11
     c30:	06100913          	li	s2,97
     c34:	b1f1                	j	900 <_ZN6Parser10parse_pipeEPPcS0_+0xfa>

0000000000000c36 <_ZN6Parser10parse_lineEPPcS0_>:
    static Command *parse_line(char **ps, char *es)
     c36:	7159                	addi	sp,sp,-112
     c38:	eca6                	sd	s1,88(sp)
     c3a:	e8ca                	sd	s2,80(sp)
     c3c:	e4ce                	sd	s3,72(sp)
     c3e:	e0d2                	sd	s4,64(sp)
     c40:	fc56                	sd	s5,56(sp)
     c42:	f85a                	sd	s6,48(sp)
     c44:	f45e                	sd	s7,40(sp)
     c46:	f062                	sd	s8,32(sp)
     c48:	ec66                	sd	s9,24(sp)
     c4a:	e86a                	sd	s10,16(sp)
     c4c:	e46e                	sd	s11,8(sp)
     c4e:	f486                	sd	ra,104(sp)
     c50:	f0a2                	sd	s0,96(sp)
     c52:	89aa                	mv	s3,a0
     c54:	84ae                	mv	s1,a1
        Command *cmd = parse_pipe(ps, es);
     c56:	bb1ff0ef          	jal	806 <_ZN6Parser10parse_pipeEPPcS0_>
     c5a:	8a2a                	mv	s4,a0
        while (peek(ps, es, "&"))
     c5c:	00007917          	auipc	s2,0x7
     c60:	1fc90913          	addi	s2,s2,508 # 7e58 <WHITESPACE>
        return *s && strchr(toks, *s);
     c64:	00005c97          	auipc	s9,0x5
     c68:	414c8c93          	addi	s9,s9,1044 # 6078 <_GLOBAL__sub_I__ZSt3cin+0xd0>
        switch (*s)
     c6c:	03c00b13          	li	s6,60
     c70:	03e00b93          	li	s7,62
     c74:	07c00d93          	li	s11,124
     c78:	03a00c13          	li	s8,58
     c7c:	02600d13          	li	s10,38
    BackCommand(Command *c) : sub_cmd(c) {}
     c80:	00007a97          	auipc	s5,0x7
     c84:	1c0a8a93          	addi	s5,s5,448 # 7e40 <_ZTV11BackCommand+0x10>
        char *s = *ps;
     c88:	0009b403          	ld	s0,0(s3)
        while (s < es && strchr(WHITESPACE, *s))
     c8c:	00946663          	bltu	s0,s1,c98 <_ZN6Parser10parse_lineEPPcS0_+0x62>
     c90:	a819                	j	ca6 <_ZN6Parser10parse_lineEPPcS0_+0x70>
            s++;
     c92:	0405                	addi	s0,s0,1
        while (s < es && strchr(WHITESPACE, *s))
     c94:	00848963          	beq	s1,s0,ca6 <_ZN6Parser10parse_lineEPPcS0_+0x70>
     c98:	00044583          	lbu	a1,0(s0)
     c9c:	00093503          	ld	a0,0(s2)
     ca0:	7df040ef          	jal	5c7e <strchr>
     ca4:	f57d                	bnez	a0,c92 <_ZN6Parser10parse_lineEPPcS0_+0x5c>
        *ps = s;
     ca6:	0089b023          	sd	s0,0(s3)
        return *s && strchr(toks, *s);
     caa:	00044583          	lbu	a1,0(s0)
     cae:	e9a9                	bnez	a1,d00 <_ZN6Parser10parse_lineEPPcS0_+0xca>
        while (s < es && strchr(WHITESPACE, *s))
     cb0:	02947163          	bgeu	s0,s1,cd2 <_ZN6Parser10parse_lineEPPcS0_+0x9c>
     cb4:	00007917          	auipc	s2,0x7
     cb8:	1a490913          	addi	s2,s2,420 # 7e58 <WHITESPACE>
     cbc:	a021                	j	cc4 <_ZN6Parser10parse_lineEPPcS0_+0x8e>
            s++;
     cbe:	0405                	addi	s0,s0,1
        while (s < es && strchr(WHITESPACE, *s))
     cc0:	00848963          	beq	s1,s0,cd2 <_ZN6Parser10parse_lineEPPcS0_+0x9c>
     cc4:	00044583          	lbu	a1,0(s0)
     cc8:	00093503          	ld	a0,0(s2)
     ccc:	7b3040ef          	jal	5c7e <strchr>
     cd0:	f57d                	bnez	a0,cbe <_ZN6Parser10parse_lineEPPcS0_+0x88>
        *ps = s;
     cd2:	0089b023          	sd	s0,0(s3)
        return *s && strchr(toks, *s);
     cd6:	00044583          	lbu	a1,0(s0)
     cda:	0e059a63          	bnez	a1,dce <_ZN6Parser10parse_lineEPPcS0_+0x198>
     cde:	8452                	mv	s0,s4
    }
     ce0:	70a6                	ld	ra,104(sp)
     ce2:	8522                	mv	a0,s0
     ce4:	7406                	ld	s0,96(sp)
     ce6:	64e6                	ld	s1,88(sp)
     ce8:	6946                	ld	s2,80(sp)
     cea:	69a6                	ld	s3,72(sp)
     cec:	6a06                	ld	s4,64(sp)
     cee:	7ae2                	ld	s5,56(sp)
     cf0:	7b42                	ld	s6,48(sp)
     cf2:	7ba2                	ld	s7,40(sp)
     cf4:	7c02                	ld	s8,32(sp)
     cf6:	6ce2                	ld	s9,24(sp)
     cf8:	6d42                	ld	s10,16(sp)
     cfa:	6da2                	ld	s11,8(sp)
     cfc:	6165                	addi	sp,sp,112
     cfe:	8082                	ret
        return *s && strchr(toks, *s);
     d00:	8566                	mv	a0,s9
     d02:	77d040ef          	jal	5c7e <strchr>
        s = *ps;
     d06:	0009b403          	ld	s0,0(s3)
        return *s && strchr(toks, *s);
     d0a:	d15d                	beqz	a0,cb0 <_ZN6Parser10parse_lineEPPcS0_+0x7a>
        while (s < es && strchr(WHITESPACE, *s))
     d0c:	00946663          	bltu	s0,s1,d18 <_ZN6Parser10parse_lineEPPcS0_+0xe2>
     d10:	a819                	j	d26 <_ZN6Parser10parse_lineEPPcS0_+0xf0>
            s++;
     d12:	0405                	addi	s0,s0,1
        while (s < es && strchr(WHITESPACE, *s))
     d14:	00848963          	beq	s1,s0,d26 <_ZN6Parser10parse_lineEPPcS0_+0xf0>
     d18:	00044583          	lbu	a1,0(s0)
     d1c:	00093503          	ld	a0,0(s2)
     d20:	75f040ef          	jal	5c7e <strchr>
     d24:	f57d                	bnez	a0,d12 <_ZN6Parser10parse_lineEPPcS0_+0xdc>
        ret = *s;
     d26:	00044783          	lbu	a5,0(s0)
        switch (*s)
     d2a:	08fb6a63          	bltu	s6,a5,dbe <_ZN6Parser10parse_lineEPPcS0_+0x188>
     d2e:	00fc6c63          	bltu	s8,a5,d46 <_ZN6Parser10parse_lineEPPcS0_+0x110>
     d32:	cb99                	beqz	a5,d48 <_ZN6Parser10parse_lineEPPcS0_+0x112>
     d34:	01a78963          	beq	a5,s10,d46 <_ZN6Parser10parse_lineEPPcS0_+0x110>
     d38:	fd87879b          	addiw	a5,a5,-40
     d3c:	0ff7f793          	zext.b	a5,a5
     d40:	4705                	li	a4,1
     d42:	02f76d63          	bltu	a4,a5,d7c <_ZN6Parser10parse_lineEPPcS0_+0x146>
            s++;
     d46:	0405                	addi	s0,s0,1
        while (s < es && strchr(WHITESPACE, *s))
     d48:	00946663          	bltu	s0,s1,d54 <_ZN6Parser10parse_lineEPPcS0_+0x11e>
     d4c:	a819                	j	d62 <_ZN6Parser10parse_lineEPPcS0_+0x12c>
            s++;
     d4e:	0405                	addi	s0,s0,1
        while (s < es && strchr(WHITESPACE, *s))
     d50:	04848b63          	beq	s1,s0,da6 <_ZN6Parser10parse_lineEPPcS0_+0x170>
     d54:	00044583          	lbu	a1,0(s0)
     d58:	00093503          	ld	a0,0(s2)
     d5c:	723040ef          	jal	5c7e <strchr>
     d60:	f57d                	bnez	a0,d4e <_ZN6Parser10parse_lineEPPcS0_+0x118>
        *ps = s;
     d62:	0089b023          	sd	s0,0(s3)
            cmd = new BackCommand(cmd);
     d66:	4541                	li	a0,16
     d68:	228050ef          	jal	5f90 <_Znwm>
    BackCommand(Command *c) : sub_cmd(c) {}
     d6c:	01453423          	sd	s4,8(a0)
     d70:	01553023          	sd	s5,0(a0)
            cmd = new BackCommand(cmd);
     d74:	8a2a                	mv	s4,a0
     d76:	bf09                	j	c88 <_ZN6Parser10parse_lineEPPcS0_+0x52>
        switch (*s)
     d78:	fdb787e3          	beq	a5,s11,d46 <_ZN6Parser10parse_lineEPPcS0_+0x110>
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     d7c:	00946d63          	bltu	s0,s1,d96 <_ZN6Parser10parse_lineEPPcS0_+0x160>
     d80:	b7cd                	j	d62 <_ZN6Parser10parse_lineEPPcS0_+0x12c>
     d82:	00044583          	lbu	a1,0(s0)
     d86:	00893503          	ld	a0,8(s2)
     d8a:	6f5040ef          	jal	5c7e <strchr>
     d8e:	fd4d                	bnez	a0,d48 <_ZN6Parser10parse_lineEPPcS0_+0x112>
                s++;
     d90:	0405                	addi	s0,s0,1
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     d92:	00848a63          	beq	s1,s0,da6 <_ZN6Parser10parse_lineEPPcS0_+0x170>
     d96:	00044583          	lbu	a1,0(s0)
     d9a:	00093503          	ld	a0,0(s2)
     d9e:	6e1040ef          	jal	5c7e <strchr>
     da2:	d165                	beqz	a0,d82 <_ZN6Parser10parse_lineEPPcS0_+0x14c>
     da4:	b755                	j	d48 <_ZN6Parser10parse_lineEPPcS0_+0x112>
     da6:	8426                	mv	s0,s1
        *ps = s;
     da8:	0089b023          	sd	s0,0(s3)
            cmd = new BackCommand(cmd);
     dac:	4541                	li	a0,16
     dae:	1e2050ef          	jal	5f90 <_Znwm>
    BackCommand(Command *c) : sub_cmd(c) {}
     db2:	01453423          	sd	s4,8(a0)
     db6:	01553023          	sd	s5,0(a0)
            cmd = new BackCommand(cmd);
     dba:	8a2a                	mv	s4,a0
     dbc:	b5f1                	j	c88 <_ZN6Parser10parse_lineEPPcS0_+0x52>
        switch (*s)
     dbe:	fb779de3          	bne	a5,s7,d78 <_ZN6Parser10parse_lineEPPcS0_+0x142>
            if (*s == '>')
     dc2:	00144783          	lbu	a5,1(s0)
     dc6:	f97790e3          	bne	a5,s7,d46 <_ZN6Parser10parse_lineEPPcS0_+0x110>
                s++;
     dca:	0409                	addi	s0,s0,2
     dcc:	bfb5                	j	d48 <_ZN6Parser10parse_lineEPPcS0_+0x112>
        return *s && strchr(toks, *s);
     dce:	00005517          	auipc	a0,0x5
     dd2:	2b250513          	addi	a0,a0,690 # 6080 <_GLOBAL__sub_I__ZSt3cin+0xd8>
     dd6:	6a9040ef          	jal	5c7e <strchr>
     dda:	f00502e3          	beqz	a0,cde <_ZN6Parser10parse_lineEPPcS0_+0xa8>
        s = *ps;
     dde:	0009b403          	ld	s0,0(s3)
        ret = *s;
     de2:	00044783          	lbu	a5,0(s0)
        while (s < es && strchr(WHITESPACE, *s))
     de6:	0e947863          	bgeu	s0,s1,ed6 <_ZN6Parser10parse_lineEPPcS0_+0x2a0>
     dea:	00007917          	auipc	s2,0x7
     dee:	06e90913          	addi	s2,s2,110 # 7e58 <WHITESPACE>
     df2:	a021                	j	dfa <_ZN6Parser10parse_lineEPPcS0_+0x1c4>
            s++;
     df4:	0405                	addi	s0,s0,1
        while (s < es && strchr(WHITESPACE, *s))
     df6:	00848963          	beq	s1,s0,e08 <_ZN6Parser10parse_lineEPPcS0_+0x1d2>
     dfa:	00044583          	lbu	a1,0(s0)
     dfe:	00093503          	ld	a0,0(s2)
     e02:	67d040ef          	jal	5c7e <strchr>
     e06:	f57d                	bnez	a0,df4 <_ZN6Parser10parse_lineEPPcS0_+0x1be>
        ret = *s;
     e08:	00044783          	lbu	a5,0(s0)
        switch (*s)
     e0c:	02900713          	li	a4,41
     e10:	04f76b63          	bltu	a4,a5,e66 <_ZN6Parser10parse_lineEPPcS0_+0x230>
     e14:	02700713          	li	a4,39
     e18:	08f76f63          	bltu	a4,a5,eb6 <_ZN6Parser10parse_lineEPPcS0_+0x280>
     e1c:	efd9                	bnez	a5,eba <_ZN6Parser10parse_lineEPPcS0_+0x284>
        while (s < es && strchr(WHITESPACE, *s))
     e1e:	00007917          	auipc	s2,0x7
     e22:	03a90913          	addi	s2,s2,58 # 7e58 <WHITESPACE>
     e26:	00946663          	bltu	s0,s1,e32 <_ZN6Parser10parse_lineEPPcS0_+0x1fc>
     e2a:	a819                	j	e40 <_ZN6Parser10parse_lineEPPcS0_+0x20a>
            s++;
     e2c:	0405                	addi	s0,s0,1
        while (s < es && strchr(WHITESPACE, *s))
     e2e:	06848c63          	beq	s1,s0,ea6 <_ZN6Parser10parse_lineEPPcS0_+0x270>
     e32:	00044583          	lbu	a1,0(s0)
     e36:	00093503          	ld	a0,0(s2)
     e3a:	645040ef          	jal	5c7e <strchr>
     e3e:	f57d                	bnez	a0,e2c <_ZN6Parser10parse_lineEPPcS0_+0x1f6>
        *ps = s;
     e40:	0089b023          	sd	s0,0(s3)
            cmd = new ListCommand(cmd, parse_line(ps, es));
     e44:	4561                	li	a0,24
     e46:	14a050ef          	jal	5f90 <_Znwm>
     e4a:	842a                	mv	s0,a0
     e4c:	85a6                	mv	a1,s1
     e4e:	854e                	mv	a0,s3
     e50:	de7ff0ef          	jal	c36 <_ZN6Parser10parse_lineEPPcS0_>
    ListCommand(Command *l, Command *r) : left(l), right(r) {}
     e54:	00007797          	auipc	a5,0x7
     e58:	fc478793          	addi	a5,a5,-60 # 7e18 <_ZTV11ListCommand+0x10>
     e5c:	e01c                	sd	a5,0(s0)
     e5e:	01443423          	sd	s4,8(s0)
     e62:	e808                	sd	a0,16(s0)
     e64:	bdb5                	j	ce0 <_ZN6Parser10parse_lineEPPcS0_+0xaa>
        switch (*s)
     e66:	03e00713          	li	a4,62
     e6a:	04e78063          	beq	a5,a4,eaa <_ZN6Parser10parse_lineEPPcS0_+0x274>
     e6e:	04f76c63          	bltu	a4,a5,ec6 <_ZN6Parser10parse_lineEPPcS0_+0x290>
     e72:	fc57879b          	addiw	a5,a5,-59
     e76:	0ff7f793          	zext.b	a5,a5
     e7a:	4705                	li	a4,1
     e7c:	02f77d63          	bgeu	a4,a5,eb6 <_ZN6Parser10parse_lineEPPcS0_+0x280>
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     e80:	fc9470e3          	bgeu	s0,s1,e40 <_ZN6Parser10parse_lineEPPcS0_+0x20a>
     e84:	00044583          	lbu	a1,0(s0)
     e88:	00093503          	ld	a0,0(s2)
     e8c:	5f3040ef          	jal	5c7e <strchr>
     e90:	f559                	bnez	a0,e1e <_ZN6Parser10parse_lineEPPcS0_+0x1e8>
     e92:	00044583          	lbu	a1,0(s0)
     e96:	00893503          	ld	a0,8(s2)
     e9a:	5e5040ef          	jal	5c7e <strchr>
     e9e:	f141                	bnez	a0,e1e <_ZN6Parser10parse_lineEPPcS0_+0x1e8>
                s++;
     ea0:	0405                	addi	s0,s0,1
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     ea2:	fe8491e3          	bne	s1,s0,e84 <_ZN6Parser10parse_lineEPPcS0_+0x24e>
     ea6:	8426                	mv	s0,s1
     ea8:	bf61                	j	e40 <_ZN6Parser10parse_lineEPPcS0_+0x20a>
            if (*s == '>')
     eaa:	00144703          	lbu	a4,1(s0)
     eae:	03e00793          	li	a5,62
     eb2:	02f70063          	beq	a4,a5,ed2 <_ZN6Parser10parse_lineEPPcS0_+0x29c>
            s++;
     eb6:	0405                	addi	s0,s0,1
     eb8:	b79d                	j	e1e <_ZN6Parser10parse_lineEPPcS0_+0x1e8>
        switch (*s)
     eba:	02600713          	li	a4,38
     ebe:	fce791e3          	bne	a5,a4,e80 <_ZN6Parser10parse_lineEPPcS0_+0x24a>
            s++;
     ec2:	0405                	addi	s0,s0,1
     ec4:	bfa9                	j	e1e <_ZN6Parser10parse_lineEPPcS0_+0x1e8>
        switch (*s)
     ec6:	07c00713          	li	a4,124
     eca:	fae79be3          	bne	a5,a4,e80 <_ZN6Parser10parse_lineEPPcS0_+0x24a>
            s++;
     ece:	0405                	addi	s0,s0,1
     ed0:	b7b9                	j	e1e <_ZN6Parser10parse_lineEPPcS0_+0x1e8>
                s++;
     ed2:	0409                	addi	s0,s0,2
     ed4:	b7a9                	j	e1e <_ZN6Parser10parse_lineEPPcS0_+0x1e8>
        switch (*s)
     ed6:	03c00713          	li	a4,60
     eda:	02f76463          	bltu	a4,a5,f02 <_ZN6Parser10parse_lineEPPcS0_+0x2cc>
     ede:	03a00713          	li	a4,58
     ee2:	fcf76ae3          	bltu	a4,a5,eb6 <_ZN6Parser10parse_lineEPPcS0_+0x280>
     ee6:	dfa9                	beqz	a5,e40 <_ZN6Parser10parse_lineEPPcS0_+0x20a>
     ee8:	02600713          	li	a4,38
     eec:	fce785e3          	beq	a5,a4,eb6 <_ZN6Parser10parse_lineEPPcS0_+0x280>
     ef0:	fd87879b          	addiw	a5,a5,-40
     ef4:	0ff7f793          	zext.b	a5,a5
     ef8:	4705                	li	a4,1
     efa:	f4f763e3          	bltu	a4,a5,e40 <_ZN6Parser10parse_lineEPPcS0_+0x20a>
            s++;
     efe:	0405                	addi	s0,s0,1
     f00:	bf39                	j	e1e <_ZN6Parser10parse_lineEPPcS0_+0x1e8>
        switch (*s)
     f02:	03e00713          	li	a4,62
     f06:	fae782e3          	beq	a5,a4,eaa <_ZN6Parser10parse_lineEPPcS0_+0x274>
     f0a:	07c00713          	li	a4,124
     f0e:	f2e799e3          	bne	a5,a4,e40 <_ZN6Parser10parse_lineEPPcS0_+0x20a>
     f12:	b755                	j	eb6 <_ZN6Parser10parse_lineEPPcS0_+0x280>

0000000000000f14 <main>:

int main()
{
     f14:	7159                	addi	sp,sp,-112
    //         close(fd);
    //         break;
    //     }
    // }

    printf("\n[Lume Shell] Initialized! \n");
     f16:	00005517          	auipc	a0,0x5
     f1a:	18a50513          	addi	a0,a0,394 # 60a0 <_GLOBAL__sub_I__ZSt3cin+0xf8>
{
     f1e:	e8ca                	sd	s2,80(sp)
     f20:	e4ce                	sd	s3,72(sp)
     f22:	e0d2                	sd	s4,64(sp)
     f24:	fc56                	sd	s5,56(sp)
     f26:	f85a                	sd	s6,48(sp)
     f28:	f45e                	sd	s7,40(sp)
     f2a:	f062                	sd	s8,32(sp)
     f2c:	ec66                	sd	s9,24(sp)
     f2e:	f486                	sd	ra,104(sp)
     f30:	f0a2                	sd	s0,96(sp)
     f32:	eca6                	sd	s1,88(sp)
     f34:	e86a                	sd	s10,16(sp)
     f36:	00008917          	auipc	s2,0x8
     f3a:	cea90913          	addi	s2,s2,-790 # 8c20 <_ZZ4mainE3buf>
    printf("\n[Lume Shell] Initialized! \n");
     f3e:	18d030ef          	jal	48ca <printf>

    while (getcmd(buf, sizeof(buf)) >= 0)
    {
        if (buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' ')
     f42:	06300a13          	li	s4,99
    if (pid == -1)
     f46:	5afd                	li	s5,-1
        Command *cmd = parse_line(&s, es);
     f48:	00810b13          	addi	s6,sp,8
            printf("leftovers: %s\n", s);
     f4c:	00005c97          	auipc	s9,0x5
     f50:	184c8c93          	addi	s9,s9,388 # 60d0 <_GLOBAL__sub_I__ZSt3cin+0x128>
     f54:	00007997          	auipc	s3,0x7
     f58:	f0498993          	addi	s3,s3,-252 # 7e58 <WHITESPACE>
    printf("shell panic: %s\n", s);
     f5c:	00005c17          	auipc	s8,0x5
     f60:	0a4c0c13          	addi	s8,s8,164 # 6000 <_GLOBAL__sub_I__ZSt3cin+0x58>
     f64:	00005b97          	auipc	s7,0x5
     f68:	0a4b8b93          	addi	s7,s7,164 # 6008 <_GLOBAL__sub_I__ZSt3cin+0x60>
    while (getcmd(buf, sizeof(buf)) >= 0)
     f6c:	a021                	j	f74 <main+0x60>
                cmd->run();
                delete cmd;
            }
            exit(0);
        }
        wait(0);
     f6e:	4501                	li	a0,0
     f70:	140000ef          	jal	10b0 <wait>
    while (getcmd(buf, sizeof(buf)) >= 0)
     f74:	06400593          	li	a1,100
     f78:	854a                	mv	a0,s2
     f7a:	8e2ff0ef          	jal	5c <_Z6getcmdPci>
     f7e:	0e054b63          	bltz	a0,1074 <main+0x160>
        if (buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' ')
     f82:	00094783          	lbu	a5,0(s2)
     f86:	01479863          	bne	a5,s4,f96 <main+0x82>
     f8a:	00194703          	lbu	a4,1(s2)
     f8e:	06400793          	li	a5,100
     f92:	08f70e63          	beq	a4,a5,102e <main+0x11a>
    int pid = fork();
     f96:	112000ef          	jal	10a8 <fork>
    if (pid == -1)
     f9a:	09550263          	beq	a0,s5,101e <main+0x10a>
        if (fork_or_panic() == 0)
     f9e:	f961                	bnez	a0,f6e <main+0x5a>
        char *es = s + strlen(s);
     fa0:	854a                	mv	a0,s2
     fa2:	e44a                	sd	s2,8(sp)
     fa4:	385040ef          	jal	5b28 <strlen>
     fa8:	00a904b3          	add	s1,s2,a0
        Command *cmd = parse_line(&s, es);
     fac:	85a6                	mv	a1,s1
     fae:	855a                	mv	a0,s6
     fb0:	c87ff0ef          	jal	c36 <_ZN6Parser10parse_lineEPPcS0_>
        char *s = *ps;
     fb4:	6422                	ld	s0,8(sp)
        Command *cmd = parse_line(&s, es);
     fb6:	8d2a                	mv	s10,a0
        while (s < es && strchr(WHITESPACE, *s))
     fb8:	00946663          	bltu	s0,s1,fc4 <main+0xb0>
     fbc:	a819                	j	fd2 <main+0xbe>
            s++;
     fbe:	0405                	addi	s0,s0,1
        while (s < es && strchr(WHITESPACE, *s))
     fc0:	04848363          	beq	s1,s0,1006 <main+0xf2>
     fc4:	00044583          	lbu	a1,0(s0)
     fc8:	0009b503          	ld	a0,0(s3)
     fcc:	4b3040ef          	jal	5c7e <strchr>
     fd0:	f57d                	bnez	a0,fbe <main+0xaa>
        *ps = s;
     fd2:	e422                	sd	s0,8(sp)
        return *s && strchr(toks, *s);
     fd4:	00044583          	lbu	a1,0(s0)
     fd8:	e99d                	bnez	a1,100e <main+0xfa>
        if (s != es)
     fda:	00848663          	beq	s1,s0,fe6 <main+0xd2>
            printf("leftovers: %s\n", s);
     fde:	85a2                	mv	a1,s0
     fe0:	8566                	mv	a0,s9
     fe2:	0e9030ef          	jal	48ca <printf>
            if (cmd)
     fe6:	000d0c63          	beqz	s10,ffe <main+0xea>
                cmd->run();
     fea:	000d3783          	ld	a5,0(s10)
     fee:	856a                	mv	a0,s10
     ff0:	6b9c                	ld	a5,16(a5)
     ff2:	9782                	jalr	a5
                delete cmd;
     ff4:	000d3783          	ld	a5,0(s10)
     ff8:	856a                	mv	a0,s10
     ffa:	679c                	ld	a5,8(a5)
     ffc:	9782                	jalr	a5
            exit(0);
     ffe:	4501                	li	a0,0
    1000:	3de040ef          	jal	53de <exit>
    1004:	b7ad                	j	f6e <main+0x5a>
        return *s && strchr(toks, *s);
    1006:	0004c583          	lbu	a1,0(s1)
        *ps = s;
    100a:	e426                	sd	s1,8(sp)
        return *s && strchr(toks, *s);
    100c:	dde9                	beqz	a1,fe6 <main+0xd2>
    100e:	00005517          	auipc	a0,0x5
    1012:	00a50513          	addi	a0,a0,10 # 6018 <_GLOBAL__sub_I__ZSt3cin+0x70>
    1016:	469040ef          	jal	5c7e <strchr>
        if (s != es)
    101a:	6422                	ld	s0,8(sp)
    101c:	bf7d                	j	fda <main+0xc6>
    printf("shell panic: %s\n", s);
    101e:	85e2                	mv	a1,s8
    1020:	855e                	mv	a0,s7
    1022:	0a9030ef          	jal	48ca <printf>
    exit(1);
    1026:	4505                	li	a0,1
    1028:	3b6040ef          	jal	53de <exit>
    return pid;
    102c:	b789                	j	f6e <main+0x5a>
        if (buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' ')
    102e:	00294703          	lbu	a4,2(s2)
    1032:	02000793          	li	a5,32
    1036:	f6f710e3          	bne	a4,a5,f96 <main+0x82>
            buf[strlen(buf) - 1] = 0; // chop \n
    103a:	00008517          	auipc	a0,0x8
    103e:	be650513          	addi	a0,a0,-1050 # 8c20 <_ZZ4mainE3buf>
    1042:	2e7040ef          	jal	5b28 <strlen>
    1046:	00a907b3          	add	a5,s2,a0
            if (chdir(buf + 3) < 0)
    104a:	00008517          	auipc	a0,0x8
    104e:	bd950513          	addi	a0,a0,-1063 # 8c23 <_ZZ4mainE3buf+0x3>
            buf[strlen(buf) - 1] = 0; // chop \n
    1052:	fe078fa3          	sb	zero,-1(a5)
            if (chdir(buf + 3) < 0)
    1056:	0c2000ef          	jal	1118 <chdir>
    105a:	f0055de3          	bgez	a0,f74 <main+0x60>
                printf("cannot cd %s\n", buf + 3);
    105e:	00008597          	auipc	a1,0x8
    1062:	bc558593          	addi	a1,a1,-1083 # 8c23 <_ZZ4mainE3buf+0x3>
    1066:	00005517          	auipc	a0,0x5
    106a:	05a50513          	addi	a0,a0,90 # 60c0 <_GLOBAL__sub_I__ZSt3cin+0x118>
    106e:	05d030ef          	jal	48ca <printf>
    1072:	b709                	j	f74 <main+0x60>
    }
    return 0;
    1074:	70a6                	ld	ra,104(sp)
    1076:	7406                	ld	s0,96(sp)
    1078:	64e6                	ld	s1,88(sp)
    107a:	6946                	ld	s2,80(sp)
    107c:	69a6                	ld	s3,72(sp)
    107e:	6a06                	ld	s4,64(sp)
    1080:	7ae2                	ld	s5,56(sp)
    1082:	7b42                	ld	s6,48(sp)
    1084:	7ba2                	ld	s7,40(sp)
    1086:	7c02                	ld	s8,32(sp)
    1088:	6ce2                	ld	s9,24(sp)
    108a:	6d42                	ld	s10,16(sp)
    108c:	4501                	li	a0,0
    108e:	6165                	addi	sp,sp,112
    1090:	8082                	ret

0000000000001092 <_start>:
.section .text
.global _start

_start:
    li a0, 0
    1092:	4501                	li	a0,0
    li a1, 0
    1094:	4581                	li	a1,0

    call main
    1096:	e7fff0ef          	jal	f14 <main>

    call exit
    109a:	344040ef          	jal	53de <exit>

    109e:	a001                	j	109e <_start+0xc>

00000000000010a0 <sys_exit>:
    name: \
        li a7, SYS_ ## sysname; \
        ecall; \
        ret

SYSCALL_NAME(sys_exit, exit) 
    10a0:	488d                	li	a7,3
    10a2:	00000073          	ecall
    10a6:	8082                	ret

00000000000010a8 <fork>:

SYSCALL(fork)
    10a8:	4889                	li	a7,2
    10aa:	00000073          	ecall
    10ae:	8082                	ret

00000000000010b0 <wait>:
SYSCALL(wait)
    10b0:	4891                	li	a7,4
    10b2:	00000073          	ecall
    10b6:	8082                	ret

00000000000010b8 <pipe>:
SYSCALL(pipe)
    10b8:	4895                	li	a7,5
    10ba:	00000073          	ecall
    10be:	8082                	ret

00000000000010c0 <read>:
SYSCALL(read)
    10c0:	4899                	li	a7,6
    10c2:	00000073          	ecall
    10c6:	8082                	ret

00000000000010c8 <write>:
SYSCALL(write)
    10c8:	48c5                	li	a7,17
    10ca:	00000073          	ecall
    10ce:	8082                	ret

00000000000010d0 <close>:
SYSCALL(close)
    10d0:	48d9                	li	a7,22
    10d2:	00000073          	ecall
    10d6:	8082                	ret

00000000000010d8 <kill>:
SYSCALL(kill)
    10d8:	489d                	li	a7,7
    10da:	00000073          	ecall
    10de:	8082                	ret

00000000000010e0 <exec>:
SYSCALL(exec)
    10e0:	48a1                	li	a7,8
    10e2:	00000073          	ecall
    10e6:	8082                	ret

00000000000010e8 <open>:
SYSCALL(open)
    10e8:	48c1                	li	a7,16
    10ea:	00000073          	ecall
    10ee:	8082                	ret

00000000000010f0 <mknod>:
SYSCALL(mknod)
    10f0:	48c9                	li	a7,18
    10f2:	00000073          	ecall
    10f6:	8082                	ret

00000000000010f8 <unlink>:
SYSCALL(unlink)
    10f8:	48cd                	li	a7,19
    10fa:	00000073          	ecall
    10fe:	8082                	ret

0000000000001100 <fstat>:
SYSCALL(fstat)
    1100:	48a5                	li	a7,9
    1102:	00000073          	ecall
    1106:	8082                	ret

0000000000001108 <link>:
SYSCALL(link)
    1108:	48d1                	li	a7,20
    110a:	00000073          	ecall
    110e:	8082                	ret

0000000000001110 <mkdir>:
SYSCALL(mkdir)
    1110:	48d5                	li	a7,21
    1112:	00000073          	ecall
    1116:	8082                	ret

0000000000001118 <chdir>:
SYSCALL(chdir)
    1118:	48a9                	li	a7,10
    111a:	00000073          	ecall
    111e:	8082                	ret

0000000000001120 <dup>:
SYSCALL(dup)
    1120:	48ad                	li	a7,11
    1122:	00000073          	ecall
    1126:	8082                	ret

0000000000001128 <getpid>:
SYSCALL(getpid)
    1128:	48b1                	li	a7,12
    112a:	00000073          	ecall
    112e:	8082                	ret

0000000000001130 <sbrk>:
SYSCALL(sbrk)
    1130:	48b5                	li	a7,13
    1132:	00000073          	ecall
    1136:	8082                	ret

0000000000001138 <sleep>:
SYSCALL(sleep)
    1138:	48b9                	li	a7,14
    113a:	00000073          	ecall
    113e:	8082                	ret

0000000000001140 <uptime>:
SYSCALL(uptime)
    1140:	48bd                	li	a7,15
    1142:	00000073          	ecall
    1146:	8082                	ret

0000000000001148 <putc>:
SYSCALL(putc)
    1148:	4885                	li	a7,1
    114a:	00000073          	ecall
    114e:	8082                	ret

0000000000001150 <disk_test>:
SYSCALL(disk_test)
    1150:	48dd                	li	a7,23
    1152:	00000073          	ecall
    1156:	8082                	ret

0000000000001158 <lseek>:
    1158:	48e1                	li	a7,24
    115a:	00000073          	ecall
    115e:	8082                	ret

0000000000001160 <stbsp__clamp_callback>:
    1160:	45dc                	lw	a5,12(a1)
    1162:	4598                	lw	a4,8(a1)
    1164:	9fb1                	addw	a5,a5,a2
    1166:	c5dc                	sw	a5,12(a1)
    1168:	0007069b          	sext.w	a3,a4
    116c:	00e65463          	bge	a2,a4,1174 <stbsp__clamp_callback+0x14>
    1170:	0006069b          	sext.w	a3,a2
    1174:	c685                	beqz	a3,119c <stbsp__clamp_callback+0x3c>
    1176:	619c                	ld	a5,0(a1)
    1178:	00a78e63          	beq	a5,a0,1194 <stbsp__clamp_callback+0x34>
    117c:	00d50633          	add	a2,a0,a3
    1180:	00054703          	lbu	a4,0(a0)
    1184:	0505                	addi	a0,a0,1
    1186:	0785                	addi	a5,a5,1
    1188:	fee78fa3          	sb	a4,-1(a5)
    118c:	fec56ae3          	bltu	a0,a2,1180 <stbsp__clamp_callback+0x20>
    1190:	6188                	ld	a0,0(a1)
    1192:	4598                	lw	a4,8(a1)
    1194:	9f15                	subw	a4,a4,a3
    1196:	9536                	add	a0,a0,a3
    1198:	e188                	sd	a0,0(a1)
    119a:	c598                	sw	a4,8(a1)
    119c:	1ff00793          	li	a5,511
    11a0:	00e7d463          	bge	a5,a4,11a8 <stbsp__clamp_callback+0x48>
    11a4:	6188                	ld	a0,0(a1)
    11a6:	8082                	ret
    11a8:	01058513          	addi	a0,a1,16
    11ac:	8082                	ret

00000000000011ae <stbsp__count_clamp_callback>:
    11ae:	45dc                	lw	a5,12(a1)
    11b0:	01058513          	addi	a0,a1,16
    11b4:	9fb1                	addw	a5,a5,a2
    11b6:	c5dc                	sw	a5,12(a1)
    11b8:	8082                	ret

00000000000011ba <stbsp__real_to_str>:
    11ba:	e20508d3          	fmv.x.d	a7,fa0
    11be:	82aa                	mv	t0,a0
    11c0:	4348d813          	srai	a6,a7,0x34
    11c4:	8ec6                	mv	t4,a7
    11c6:	7ff87813          	andi	a6,a6,2047
    11ca:	8346                	mv	t1,a7
    11cc:	03f8d513          	srli	a0,a7,0x3f
    11d0:	0008d663          	bgez	a7,11dc <stbsp__real_to_str+0x22>
    11d4:	22a517d3          	fneg.d	fa5,fa0
    11d8:	e20788d3          	fmv.x.d	a7,fa5
    11dc:	7ff00e13          	li	t3,2047
    11e0:	35c80663          	beq	a6,t3,152c <stbsp__real_to_str+0x372>
    11e4:	1101                	addi	sp,sp,-32
    11e6:	14080363          	beqz	a6,132c <stbsp__real_to_str+0x172>
    11ea:	c018081b          	addiw	a6,a6,-1023
    11ee:	ec22                	sd	s0,24(sp)
    11f0:	02081313          	slli	t1,a6,0x20
    11f4:	66034d63          	bltz	t1,186e <stbsp__real_to_str+0x6b4>
    11f8:	4d100313          	li	t1,1233
    11fc:	0303033b          	mulw	t1,t1,a6
    1200:	4849                	li	a6,18
    1202:	40c3531b          	sraiw	t1,t1,0xc
    1206:	0013039b          	addiw	t2,t1,1
    120a:	4078083b          	subw	a6,a6,t2
    120e:	4359                	li	t1,22
    1210:	17036163          	bltu	t1,a6,1372 <stbsp__real_to_str+0x1b8>
    1214:	00005317          	auipc	t1,0x5
    1218:	21430313          	addi	t1,t1,532 # 6428 <stbsp__bot>
    121c:	080e                	slli	a6,a6,0x3
    121e:	981a                	add	a6,a6,t1
    1220:	00083e03          	ld	t3,0(a6)
    1224:	00083607          	fld	fa2,0(a6)
    1228:	f20887d3          	fmv.d.x	fa5,a7
    122c:	f8000837          	lui	a6,0xf8000
    1230:	01187333          	and	t1,a6,a7
    1234:	01c87833          	and	a6,a6,t3
    1238:	12f676d3          	fmul.d	fa3,fa2,fa5
    123c:	f20807d3          	fmv.d.x	fa5,a6
    1240:	f2030753          	fmv.d.x	fa4,t1
    1244:	f20305d3          	fmv.d.x	fa1,t1
    1248:	0af67653          	fsub.d	fa2,fa2,fa5
    124c:	f20887d3          	fmv.d.x	fa5,a7
    1250:	0ae7f753          	fsub.d	fa4,fa5,fa4
    1254:	f20807d3          	fmv.d.x	fa5,a6
    1258:	6ab7f7c7          	fmsub.d	fa5,fa5,fa1,fa3
    125c:	7ab677c3          	fmadd.d	fa5,fa2,fa1,fa5
    1260:	f20805d3          	fmv.d.x	fa1,a6
    1264:	7ab777c3          	fmadd.d	fa5,fa4,fa1,fa5
    1268:	7ac77743          	fmadd.d	fa4,fa4,fa2,fa5
    126c:	02d777d3          	fadd.d	fa5,fa4,fa3
    1270:	3782e837          	lui	a6,0x3782e
    1274:	acf80813          	addi	a6,a6,-1329 # 3782dacf <_ZSt4cerr+0x37824d0f>
    1278:	0832                	slli	a6,a6,0xc
    127a:	9d980813          	addi	a6,a6,-1575
    127e:	084a                	slli	a6,a6,0x12
    1280:	187d                	addi	a6,a6,-1
    1282:	c22798d3          	fcvt.l.d	a7,fa5,rtz
    1286:	0ad7f6d3          	fsub.d	fa3,fa5,fa3
    128a:	00070e1b          	sext.w	t3,a4
    128e:	d228f653          	fcvt.d.l	fa2,a7
    1292:	0ac7f5d3          	fsub.d	fa1,fa5,fa2
    1296:	0ad77753          	fsub.d	fa4,fa4,fa3
    129a:	0af5f6d3          	fsub.d	fa3,fa1,fa5
    129e:	0ad5f553          	fsub.d	fa0,fa1,fa3
    12a2:	02d67653          	fadd.d	fa2,fa2,fa3
    12a6:	0aa7f7d3          	fsub.d	fa5,fa5,fa0
    12aa:	0ac7f7d3          	fsub.d	fa5,fa5,fa2
    12ae:	02b7f7d3          	fadd.d	fa5,fa5,fa1
    12b2:	02e7f7d3          	fadd.d	fa5,fa5,fa4
    12b6:	c2279fd3          	fcvt.l.d	t6,fa5,rtz
    12ba:	9fc6                	add	t6,t6,a7
    12bc:	19f87063          	bgeu	a6,t6,143c <stbsp__real_to_str+0x282>
    12c0:	2385                	addiw	t2,t2,1
    12c2:	300e4363          	bltz	t3,15c8 <stbsp__real_to_str+0x40e>
    12c6:	00e3833b          	addw	t1,t2,a4
    12ca:	475d                	li	a4,23
    12cc:	30677663          	bgeu	a4,t1,15d8 <stbsp__real_to_str+0x41e>
    12d0:	577d                	li	a4,-1
    12d2:	9301                	srli	a4,a4,0x20
    12d4:	43f75863          	bge	a4,t6,1704 <stbsp__real_to_str+0x54a>
    12d8:	07d00313          	li	t1,125
    12dc:	877e                	mv	a4,t6
    12de:	4e01                	li	t3,0
    12e0:	3e800813          	li	a6,1000
    12e4:	130e                	slli	t1,t1,0x23
    12e6:	a039                	j	12f4 <stbsp__real_to_str+0x13a>
    12e8:	030747b3          	div	a5,a4,a6
    12ec:	4e05                	li	t3,1
    12ee:	40674c63          	blt	a4,t1,1706 <stbsp__real_to_str+0x54c>
    12f2:	873e                	mv	a4,a5
    12f4:	030768b3          	rem	a7,a4,a6
    12f8:	fe0888e3          	beqz	a7,12e8 <stbsp__real_to_str+0x12e>
    12fc:	400e0163          	beqz	t3,16fe <stbsp__real_to_str+0x544>
    1300:	8fbe                	mv	t6,a5
    1302:	05f5e7b7          	lui	a5,0x5f5e
    1306:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f5533f>
    130a:	04060413          	addi	s0,a2,64
    130e:	03860613          	addi	a2,a2,56
    1312:	15f7c863          	blt	a5,t6,1462 <stbsp__real_to_str+0x2a8>
    1316:	000f871b          	sext.w	a4,t6
    131a:	20070463          	beqz	a4,1522 <stbsp__real_to_str+0x368>
    131e:	4f01                	li	t5,0
    1320:	4f81                	li	t6,0
    1322:	00007e97          	auipc	t4,0x7
    1326:	b46e8e93          	addi	t4,t4,-1210 # 7e68 <stbsp__digitpair>
    132a:	aaa9                	j	1484 <stbsp__real_to_str+0x2ca>
    132c:	0306                	slli	t1,t1,0x1
    132e:	3e030e63          	beqz	t1,172a <stbsp__real_to_str+0x570>
    1332:	4305                	li	t1,1
    1334:	ec22                	sd	s0,24(sp)
    1336:	00ce9e13          	slli	t3,t4,0xc
    133a:	134e                	slli	t1,t1,0x33
    133c:	520e4063          	bltz	t3,185c <stbsp__real_to_str+0x6a2>
    1340:	40135313          	srai	t1,t1,0x1
    1344:	01d37e33          	and	t3,t1,t4
    1348:	8f42                	mv	t5,a6
    134a:	387d                	addiw	a6,a6,-1
    134c:	fe0e0ae3          	beqz	t3,1340 <stbsp__real_to_str+0x186>
    1350:	26900313          	li	t1,617
    1354:	c00f081b          	addiw	a6,t5,-1024
    1358:	0268083b          	mulw	a6,a6,t1
    135c:	41f8531b          	sraiw	t1,a6,0x1f
    1360:	0153531b          	srliw	t1,t1,0x15
    1364:	0103033b          	addw	t1,t1,a6
    1368:	40b3539b          	sraiw	t2,t1,0xb
    136c:	4849                	li	a6,18
    136e:	4078083b          	subw	a6,a6,t2
    1372:	41f8531b          	sraiw	t1,a6,0x1f
    1376:	00684eb3          	xor	t4,a6,t1
    137a:	406e8f3b          	subw	t5,t4,t1
    137e:	2c900313          	li	t1,713
    1382:	03e3033b          	mulw	t1,t1,t5
    1386:	4e35                	li	t3,13
    1388:	8efa                	mv	t4,t5
    138a:	40e35f9b          	sraiw	t6,t1,0xe
    138e:	837e                	mv	t1,t6
    1390:	23fe4363          	blt	t3,t6,15b6 <stbsp__real_to_str+0x3fc>
    1394:	5e25                	li	t3,-23
    1396:	026e0e3b          	mulw	t3,t3,t1
    139a:	01de0ebb          	addw	t4,t3,t4
    139e:	22084f63          	bltz	a6,15dc <stbsp__real_to_str+0x422>
    13a2:	f2000753          	fmv.d.x	fa4,zero
    13a6:	00005e17          	auipc	t3,0x5
    13aa:	082e0e13          	addi	t3,t3,130 # 6428 <stbsp__bot>
    13ae:	380e9e63          	bnez	t4,174a <stbsp__real_to_str+0x590>
    13b2:	f20887d3          	fmv.d.x	fa5,a7
    13b6:	fff30f1b          	addiw	t5,t1,-1
    13ba:	0f0e                	slli	t5,t5,0x3
    13bc:	02f777d3          	fadd.d	fa5,fa4,fa5
    13c0:	030e                	slli	t1,t1,0x3
    13c2:	9f72                	add	t5,t5,t3
    13c4:	9e1a                	add	t3,t3,t1
    13c6:	2e0e3e03          	ld	t3,736(t3)
    13ca:	2e8f3587          	fld	fa1,744(t5)
    13ce:	f8000837          	lui	a6,0xf8000
    13d2:	e2078ed3          	fmv.x.d	t4,fa5
    13d6:	12b7f6d3          	fmul.d	fa3,fa5,fa1
    13da:	f2088653          	fmv.d.x	fa2,a7
    13de:	01d87333          	and	t1,a6,t4
    13e2:	01c87833          	and	a6,a6,t3
    13e6:	f20807d3          	fmv.d.x	fa5,a6
    13ea:	f2030053          	fmv.d.x	ft0,t1
    13ee:	0af5f553          	fsub.d	fa0,fa1,fa5
    13f2:	f20e87d3          	fmv.d.x	fa5,t4
    13f6:	0ac7f0d3          	fsub.d	ft1,fa5,fa2
    13fa:	f20807d3          	fmv.d.x	fa5,a6
    13fe:	f2030653          	fmv.d.x	fa2,t1
    1402:	6ac7f647          	fmsub.d	fa2,fa5,fa2,fa3
    1406:	f20e87d3          	fmv.d.x	fa5,t4
    140a:	0a177753          	fsub.d	fa4,fa4,ft1
    140e:	f20300d3          	fmv.d.x	ft1,t1
    1412:	0a07f7d3          	fsub.d	fa5,fa5,ft0
    1416:	350f3007          	fld	ft0,848(t5)
    141a:	62157643          	fmadd.d	fa2,fa0,ft1,fa2
    141e:	12b77753          	fmul.d	fa4,fa4,fa1
    1422:	f20805d3          	fmv.d.x	fa1,a6
    1426:	62b7f643          	fmadd.d	fa2,fa5,fa1,fa2
    142a:	f20e85d3          	fmv.d.x	fa1,t4
    142e:	7205f743          	fmadd.d	fa4,fa1,ft0,fa4
    1432:	62a7f7c3          	fmadd.d	fa5,fa5,fa0,fa2
    1436:	02e7f753          	fadd.d	fa4,fa5,fa4
    143a:	bd0d                	j	126c <stbsp__real_to_str+0xb2>
    143c:	00e3833b          	addw	t1,t2,a4
    1440:	2a0e4663          	bltz	t3,16ec <stbsp__real_to_str+0x532>
    1444:	475d                	li	a4,23
    1446:	10677663          	bgeu	a4,t1,1552 <stbsp__real_to_str+0x398>
    144a:	e80f93e3          	bnez	t6,12d0 <stbsp__real_to_str+0x116>
    144e:	05f5e7b7          	lui	a5,0x5f5e
    1452:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f5533f>
    1456:	04060413          	addi	s0,a2,64
    145a:	03860613          	addi	a2,a2,56
    145e:	ebf7dce3          	bge	a5,t6,1316 <stbsp__real_to_str+0x15c>
    1462:	4f01                	li	t5,0
    1464:	00007e97          	auipc	t4,0x7
    1468:	a04e8e93          	addi	t4,t4,-1532 # 7e68 <stbsp__digitpair>
    146c:	05f5e7b7          	lui	a5,0x5f5e
    1470:	10078793          	addi	a5,a5,256 # 5f5e100 <_ZSt4cerr+0x5f55340>
    1474:	02ffe833          	rem	a6,t6,a5
    1478:	02ffcfb3          	div	t6,t6,a5
    147c:	0008071b          	sext.w	a4,a6
    1480:	0a080463          	beqz	a6,1528 <stbsp__real_to_str+0x36e>
    1484:	8822                	mv	a6,s0
    1486:	06400893          	li	a7,100
    148a:	06300e13          	li	t3,99
    148e:	1879                	addi	a6,a6,-2 # fffffffff7fffffe <_ZSt4cerr+0xfffffffff7ff723e>
    1490:	0007031b          	sext.w	t1,a4
    1494:	031777bb          	remuw	a5,a4,a7
    1498:	2785                	addiw	a5,a5,1
    149a:	0017979b          	slliw	a5,a5,0x1
    149e:	1782                	slli	a5,a5,0x20
    14a0:	9381                	srli	a5,a5,0x20
    14a2:	97f6                	add	a5,a5,t4
    14a4:	0007d783          	lhu	a5,0(a5)
    14a8:	0317573b          	divuw	a4,a4,a7
    14ac:	00f81023          	sh	a5,0(a6)
    14b0:	fc6e6fe3          	bltu	t3,t1,148e <stbsp__real_to_str+0x2d4>
    14b4:	008f0f3b          	addw	t5,t5,s0
    14b8:	410f0f3b          	subw	t5,t5,a6
    14bc:	020f8f63          	beqz	t6,14fa <stbsp__real_to_str+0x340>
    14c0:	87c2                	mv	a5,a6
    14c2:	03000713          	li	a4,48
    14c6:	04c80c63          	beq	a6,a2,151e <stbsp__real_to_str+0x364>
    14ca:	17fd                	addi	a5,a5,-1
    14cc:	00e78023          	sb	a4,0(a5)
    14d0:	fec79de3          	bne	a5,a2,14ca <stbsp__real_to_str+0x310>
    14d4:	408807b3          	sub	a5,a6,s0
    14d8:	00ff07bb          	addw	a5,t5,a5
    14dc:	1461                	addi	s0,s0,-8
    14de:	00878f1b          	addiw	t5,a5,8
    14e2:	05f5e7b7          	lui	a5,0x5f5e
    14e6:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f5533f>
    14ea:	ff840613          	addi	a2,s0,-8
    14ee:	f7f7cfe3          	blt	a5,t6,146c <stbsp__real_to_str+0x2b2>
    14f2:	000f871b          	sext.w	a4,t6
    14f6:	4f81                	li	t6,0
    14f8:	b771                	j	1484 <stbsp__real_to_str+0x2ca>
    14fa:	020f0563          	beqz	t5,1524 <stbsp__real_to_str+0x36a>
    14fe:	00084703          	lbu	a4,0(a6)
    1502:	03000793          	li	a5,48
    1506:	22f70f63          	beq	a4,a5,1744 <stbsp__real_to_str+0x58a>
    150a:	2f01                	sext.w	t5,t5
    150c:	0076a023          	sw	t2,0(a3)
    1510:	6462                	ld	s0,24(sp)
    1512:	0102b023          	sd	a6,0(t0)
    1516:	01e5a023          	sw	t5,0(a1)
    151a:	6105                	addi	sp,sp,32
    151c:	8082                	ret
    151e:	8442                	mv	s0,a6
    1520:	b7c9                	j	14e2 <stbsp__real_to_str+0x328>
    1522:	8822                	mv	a6,s0
    1524:	4f01                	li	t5,0
    1526:	b7dd                	j	150c <stbsp__real_to_str+0x352>
    1528:	8822                	mv	a6,s0
    152a:	bf59                	j	14c0 <stbsp__real_to_str+0x306>
    152c:	0eb2                	slli	t4,t4,0xc
    152e:	00005797          	auipc	a5,0x5
    1532:	bca78793          	addi	a5,a5,-1078 # 60f8 <_GLOBAL__sub_I__ZSt3cin+0x150>
    1536:	000e8663          	beqz	t4,1542 <stbsp__real_to_str+0x388>
    153a:	00005797          	auipc	a5,0x5
    153e:	bb678793          	addi	a5,a5,-1098 # 60f0 <_GLOBAL__sub_I__ZSt3cin+0x148>
    1542:	00f2b023          	sd	a5,0(t0)
    1546:	679d                	lui	a5,0x7
    1548:	c29c                	sw	a5,0(a3)
    154a:	4f0d                	li	t5,3
    154c:	01e5a023          	sw	t5,0(a1)
    1550:	8082                	ret
    1552:	3b9ad737          	lui	a4,0x3b9ad
    1556:	9ff70713          	addi	a4,a4,-1537 # 3b9ac9ff <_ZSt4cerr+0x3b9a3c3f>
    155a:	07f76f63          	bltu	a4,t6,15d8 <stbsp__real_to_str+0x41e>
    155e:	4805                	li	a6,1
    1560:	02081713          	slli	a4,a6,0x20
    1564:	01d75893          	srli	a7,a4,0x1d
    1568:	00005717          	auipc	a4,0x5
    156c:	27870713          	addi	a4,a4,632 # 67e0 <stbsp__powten>
    1570:	9746                	add	a4,a4,a7
    1572:	4e51                	li	t3,20
    1574:	a021                	j	157c <stbsp__real_to_str+0x3c2>
    1576:	2805                	addiw	a6,a6,1
    1578:	edc809e3          	beq	a6,t3,144a <stbsp__real_to_str+0x290>
    157c:	00073883          	ld	a7,0(a4)
    1580:	0721                	addi	a4,a4,8
    1582:	ff1ffae3          	bgeu	t6,a7,1576 <stbsp__real_to_str+0x3bc>
    1586:	ed0372e3          	bgeu	t1,a6,144a <stbsp__real_to_str+0x290>
    158a:	4068083b          	subw	a6,a6,t1
    158e:	475d                	li	a4,23
    1590:	eb076de3          	bltu	a4,a6,144a <stbsp__real_to_str+0x290>
    1594:	080e                	slli	a6,a6,0x3
    1596:	00005717          	auipc	a4,0x5
    159a:	e9270713          	addi	a4,a4,-366 # 6428 <stbsp__bot>
    159e:	9742                	add	a4,a4,a6
    15a0:	3b873803          	ld	a6,952(a4)
    15a4:	00185713          	srli	a4,a6,0x1
    15a8:	977e                	add	a4,a4,t6
    15aa:	01176363          	bltu	a4,a7,15b0 <stbsp__real_to_str+0x3f6>
    15ae:	2385                	addiw	t2,t2,1
    15b0:	03075fb3          	divu	t6,a4,a6
    15b4:	bd59                	j	144a <stbsp__real_to_str+0x290>
    15b6:	4335                	li	t1,13
    15b8:	5e25                	li	t3,-23
    15ba:	026e0e3b          	mulw	t3,t3,t1
    15be:	01de0ebb          	addw	t4,t3,t4
    15c2:	de0850e3          	bgez	a6,13a2 <stbsp__real_to_str+0x1e8>
    15c6:	a819                	j	15dc <stbsp__real_to_str+0x422>
    15c8:	02571313          	slli	t1,a4,0x25
    15cc:	02535313          	srli	t1,t1,0x25
    15d0:	0305                	addi	t1,t1,1
    15d2:	475d                	li	a4,23
    15d4:	ce676ee3          	bltu	a4,t1,12d0 <stbsp__real_to_str+0x116>
    15d8:	4829                	li	a6,10
    15da:	b759                	j	1560 <stbsp__real_to_str+0x3a6>
    15dc:	260e8663          	beqz	t4,1848 <stbsp__real_to_str+0x68e>
    15e0:	00231e13          	slli	t3,t1,0x2
    15e4:	41c30e33          	sub	t3,t1,t3
    15e8:	0e0e                	slli	t3,t3,0x3
    15ea:	9e1a                	add	t3,t3,t1
    15ec:	fffe881b          	addiw	a6,t4,-1
    15f0:	9e7a                	add	t3,t3,t5
    15f2:	00005e97          	auipc	t4,0x5
    15f6:	e36e8e93          	addi	t4,t4,-458 # 6428 <stbsp__bot>
    15fa:	0e0e                	slli	t3,t3,0x3
    15fc:	080e                	slli	a6,a6,0x3
    15fe:	9876                	add	a6,a6,t4
    1600:	9ef2                	add	t4,t4,t3
    1602:	0b883607          	fld	fa2,184(a6)
    1606:	f20887d3          	fmv.d.x	fa5,a7
    160a:	0b0ebf03          	ld	t5,176(t4)
    160e:	f8000e37          	lui	t3,0xf8000
    1612:	011e7eb3          	and	t4,t3,a7
    1616:	12f676d3          	fmul.d	fa3,fa2,fa5
    161a:	01ee7e33          	and	t3,t3,t5
    161e:	f20e07d3          	fmv.d.x	fa5,t3
    1622:	f20e0753          	fmv.d.x	fa4,t3
    1626:	f20e8553          	fmv.d.x	fa0,t4
    162a:	0af67653          	fsub.d	fa2,fa2,fa5
    162e:	f20e87d3          	fmv.d.x	fa5,t4
    1632:	f20e85d3          	fmv.d.x	fa1,t4
    1636:	6ae7f7c7          	fmsub.d	fa5,fa5,fa4,fa3
    163a:	f2088753          	fmv.d.x	fa4,a7
    163e:	0ab775d3          	fsub.d	fa1,fa4,fa1
    1642:	16883707          	fld	fa4,360(a6)
    1646:	7aa677c3          	fmadd.d	fa5,fa2,fa0,fa5
    164a:	f20e0553          	fmv.d.x	fa0,t3
    164e:	7aa5f7c3          	fmadd.d	fa5,fa1,fa0,fa5
    1652:	7ac5f5c3          	fmadd.d	fa1,fa1,fa2,fa5
    1656:	f20887d3          	fmv.d.x	fa5,a7
    165a:	5af77743          	fmadd.d	fa4,fa4,fa5,fa1
    165e:	c00f87e3          	beqz	t6,126c <stbsp__real_to_str+0xb2>
    1662:	02d777d3          	fadd.d	fa5,fa4,fa3
    1666:	fff3089b          	addiw	a7,t1,-1
    166a:	00005817          	auipc	a6,0x5
    166e:	dbe80813          	addi	a6,a6,-578 # 6428 <stbsp__bot>
    1672:	030e                	slli	t1,t1,0x3
    1674:	088e                	slli	a7,a7,0x3
    1676:	98c2                	add	a7,a7,a6
    1678:	981a                	add	a6,a6,t1
    167a:	e2078e53          	fmv.x.d	t3,fa5
    167e:	21083e83          	ld	t4,528(a6)
    1682:	f8000837          	lui	a6,0xf8000
    1686:	2188b507          	fld	fa0,536(a7)
    168a:	01c87333          	and	t1,a6,t3
    168e:	01d87833          	and	a6,a6,t4
    1692:	f2080653          	fmv.d.x	fa2,a6
    1696:	12f577d3          	fmul.d	fa5,fa0,fa5
    169a:	2808b587          	fld	fa1,640(a7)
    169e:	0ac57053          	fsub.d	ft0,fa0,fa2
    16a2:	f20e0653          	fmv.d.x	fa2,t3
    16a6:	0ad67153          	fsub.d	ft2,fa2,fa3
    16aa:	f20806d3          	fmv.d.x	fa3,a6
    16ae:	f2030653          	fmv.d.x	fa2,t1
    16b2:	7ac6f0c7          	fmsub.d	ft1,fa3,fa2,fa5
    16b6:	f20e06d3          	fmv.d.x	fa3,t3
    16ba:	0ac6f653          	fsub.d	fa2,fa3,fa2
    16be:	22f786d3          	fmv.d	fa3,fa5
    16c2:	0a2777d3          	fsub.d	fa5,fa4,ft2
    16c6:	f2030753          	fmv.d.x	fa4,t1
    16ca:	0ae07743          	fmadd.d	fa4,ft0,fa4,ft1
    16ce:	12a7f7d3          	fmul.d	fa5,fa5,fa0
    16d2:	f2080553          	fmv.d.x	fa0,a6
    16d6:	72a67743          	fmadd.d	fa4,fa2,fa0,fa4
    16da:	f20e0553          	fmv.d.x	fa0,t3
    16de:	7aa5f7c3          	fmadd.d	fa5,fa1,fa0,fa5
    16e2:	72067643          	fmadd.d	fa2,fa2,ft0,fa4
    16e6:	02f67753          	fadd.d	fa4,fa2,fa5
    16ea:	b649                	j	126c <stbsp__real_to_str+0xb2>
    16ec:	02571313          	slli	t1,a4,0x25
    16f0:	02535313          	srli	t1,t1,0x25
    16f4:	0305                	addi	t1,t1,1
    16f6:	475d                	li	a4,23
    16f8:	d46769e3          	bltu	a4,t1,144a <stbsp__real_to_str+0x290>
    16fc:	bd99                	j	1552 <stbsp__real_to_str+0x398>
    16fe:	87fe                	mv	a5,t6
    1700:	8fbe                	mv	t6,a5
    1702:	b101                	j	1302 <stbsp__real_to_str+0x148>
    1704:	87fe                	mv	a5,t6
    1706:	3e800713          	li	a4,1000
    170a:	02e7f73b          	remuw	a4,a5,a4
    170e:	2781                	sext.w	a5,a5
    1710:	eb01                	bnez	a4,1720 <stbsp__real_to_str+0x566>
    1712:	3e800813          	li	a6,1000
    1716:	0307d7bb          	divuw	a5,a5,a6
    171a:	0307f73b          	remuw	a4,a5,a6
    171e:	df65                	beqz	a4,1716 <stbsp__real_to_str+0x55c>
    1720:	02079f93          	slli	t6,a5,0x20
    1724:	020fdf93          	srli	t6,t6,0x20
    1728:	b31d                	j	144e <stbsp__real_to_str+0x294>
    172a:	4785                	li	a5,1
    172c:	c29c                	sw	a5,0(a3)
    172e:	00c2b023          	sd	a2,0(t0)
    1732:	03000793          	li	a5,48
    1736:	00f60023          	sb	a5,0(a2)
    173a:	4f05                	li	t5,1
    173c:	01e5a023          	sw	t5,0(a1)
    1740:	6105                	addi	sp,sp,32
    1742:	8082                	ret
    1744:	0805                	addi	a6,a6,1 # fffffffff8000001 <_ZSt4cerr+0xfffffffff7ff7241>
    1746:	3f7d                	addiw	t5,t5,-1
    1748:	b3d1                	j	150c <stbsp__real_to_str+0x352>
    174a:	e826                	sd	s1,16(sp)
    174c:	e44a                	sd	s2,8(sp)
    174e:	4859                	li	a6,22
    1750:	8976                	mv	s2,t4
    1752:	11d84363          	blt	a6,t4,1858 <stbsp__real_to_str+0x69e>
    1756:	0009049b          	sext.w	s1,s2
    175a:	00005e17          	auipc	t3,0x5
    175e:	ccee0e13          	addi	t3,t3,-818 # 6428 <stbsp__bot>
    1762:	00349813          	slli	a6,s1,0x3
    1766:	9872                	add	a6,a6,t3
    1768:	00083687          	fld	fa3,0(a6)
    176c:	00083803          	ld	a6,0(a6)
    1770:	f20887d3          	fmv.d.x	fa5,a7
    1774:	f8000fb7          	lui	t6,0xf8000
    1778:	010ff833          	and	a6,t6,a6
    177c:	12f6f553          	fmul.d	fa0,fa3,fa5
    1780:	f20807d3          	fmv.d.x	fa5,a6
    1784:	011ff433          	and	s0,t6,a7
    1788:	f2040753          	fmv.d.x	fa4,s0
    178c:	0af6f6d3          	fsub.d	fa3,fa3,fa5
    1790:	f20887d3          	fmv.d.x	fa5,a7
    1794:	f2080653          	fmv.d.x	fa2,a6
    1798:	412e8ebb          	subw	t4,t4,s2
    179c:	0ae7f753          	fsub.d	fa4,fa5,fa4
    17a0:	f20407d3          	fmv.d.x	fa5,s0
    17a4:	e20508d3          	fmv.x.d	a7,fa0
    17a8:	52c7f7c7          	fmsub.d	fa5,fa5,fa2,fa0
    17ac:	f2040653          	fmv.d.x	fa2,s0
    17b0:	7ac6f7c3          	fmadd.d	fa5,fa3,fa2,fa5
    17b4:	f2080653          	fmv.d.x	fa2,a6
    17b8:	7ac777c3          	fmadd.d	fa5,fa4,fa2,fa5
    17bc:	7ad77743          	fmadd.d	fa4,fa4,fa3,fa5
    17c0:	080e8963          	beqz	t4,1852 <stbsp__real_to_str+0x698>
    17c4:	02e577d3          	fadd.d	fa5,fa0,fa4
    17c8:	0e8e                	slli	t4,t4,0x3
    17ca:	01de0833          	add	a6,t3,t4
    17ce:	00083587          	fld	fa1,0(a6)
    17d2:	00231893          	slli	a7,t1,0x2
    17d6:	411308b3          	sub	a7,t1,a7
    17da:	00389813          	slli	a6,a7,0x3
    17de:	e2078453          	fmv.x.d	s0,fa5
    17e2:	12f5f7d3          	fmul.d	fa5,fa1,fa5
    17e6:	981a                	add	a6,a6,t1
    17e8:	987a                	add	a6,a6,t5
    17ea:	40980833          	sub	a6,a6,s1
    17ee:	080e                	slli	a6,a6,0x3
    17f0:	9872                	add	a6,a6,t3
    17f2:	00083e83          	ld	t4,0(a6)
    17f6:	008ff833          	and	a6,t6,s0
    17fa:	e20788d3          	fmv.x.d	a7,fa5
    17fe:	f20806d3          	fmv.d.x	fa3,a6
    1802:	f20407d3          	fmv.d.x	fa5,s0
    1806:	01dfffb3          	and	t6,t6,t4
    180a:	f20880d3          	fmv.d.x	ft1,a7
    180e:	0ad7f653          	fsub.d	fa2,fa5,fa3
    1812:	f20f87d3          	fmv.d.x	fa5,t6
    1816:	64c2                	ld	s1,16(sp)
    1818:	6922                	ld	s2,8(sp)
    181a:	0af5f053          	fsub.d	ft0,fa1,fa5
    181e:	0ad7f6c7          	fmsub.d	fa3,fa5,fa3,ft1
    1822:	f20407d3          	fmv.d.x	fa5,s0
    1826:	0aa7f7d3          	fsub.d	fa5,fa5,fa0
    182a:	f2080553          	fmv.d.x	fa0,a6
    182e:	6aa076c3          	fmadd.d	fa3,ft0,fa0,fa3
    1832:	0af77753          	fsub.d	fa4,fa4,fa5
    1836:	f20f87d3          	fmv.d.x	fa5,t6
    183a:	6af677c3          	fmadd.d	fa5,fa2,fa5,fa3
    183e:	7a067643          	fmadd.d	fa2,fa2,ft0,fa5
    1842:	62e5f743          	fmadd.d	fa4,fa1,fa4,fa2
    1846:	b6b5                	j	13b2 <stbsp__real_to_str+0x1f8>
    1848:	f20886d3          	fmv.d.x	fa3,a7
    184c:	f2000753          	fmv.d.x	fa4,zero
    1850:	b539                	j	165e <stbsp__real_to_str+0x4a4>
    1852:	64c2                	ld	s1,16(sp)
    1854:	6922                	ld	s2,8(sp)
    1856:	beb1                	j	13b2 <stbsp__real_to_str+0x1f8>
    1858:	4959                	li	s2,22
    185a:	bdf5                	j	1756 <stbsp__real_to_str+0x59c>
    185c:	e826                	sd	s1,16(sp)
    185e:	e44a                	sd	s2,8(sp)
    1860:	ecc00393          	li	t2,-308
    1864:	4eed                	li	t4,27
    1866:	4335                	li	t1,13
    1868:	14600f13          	li	t5,326
    186c:	b5cd                	j	174e <stbsp__real_to_str+0x594>
    186e:	26900313          	li	t1,617
    1872:	0303083b          	mulw	a6,t1,a6
    1876:	41f8531b          	sraiw	t1,a6,0x1f
    187a:	0153531b          	srliw	t1,t1,0x15
    187e:	0103033b          	addw	t1,t1,a6
    1882:	40b3539b          	sraiw	t2,t1,0xb
    1886:	4849                	li	a6,18
    1888:	4078083b          	subw	a6,a6,t2
    188c:	b249                	j	120e <stbsp__real_to_str+0x54>

000000000000188e <_in_char.part.0>:
static int _in_char(_InContext *ctx)
    188e:	87aa                	mv	a5,a0
    if (ctx->fd == -1)
    1890:	4508                	lw	a0,8(a0)
    1892:	577d                	li	a4,-1
    1894:	00e51d63          	bne	a0,a4,18ae <_in_char.part.0+0x20>
        if (ctx->buf[ctx->pos] == '\0')
    1898:	6b94                	ld	a3,16(a5)
    189a:	6398                	ld	a4,0(a5)
    189c:	9736                	add	a4,a4,a3
    189e:	00074603          	lbu	a2,0(a4)
    18a2:	c60d                	beqz	a2,18cc <_in_char.part.0+0x3e>
        return (unsigned char)ctx->buf[ctx->pos++];
    18a4:	0685                	addi	a3,a3,1
    18a6:	eb94                	sd	a3,16(a5)
    18a8:	00074503          	lbu	a0,0(a4)
    18ac:	8082                	ret
static int _in_char(_InContext *ctx)
    18ae:	1101                	addi	sp,sp,-32
    if (read(ctx->fd, &c, 1) == 1)
    18b0:	4605                	li	a2,1
    18b2:	00f10593          	addi	a1,sp,15
static int _in_char(_InContext *ctx)
    18b6:	ec06                	sd	ra,24(sp)
    if (read(ctx->fd, &c, 1) == 1)
    18b8:	809ff0ef          	jal	10c0 <read>
    18bc:	4785                	li	a5,1
    18be:	00f51963          	bne	a0,a5,18d0 <_in_char.part.0+0x42>
        return (unsigned char)c;
    18c2:	00f14503          	lbu	a0,15(sp)
}
    18c6:	60e2                	ld	ra,24(sp)
    18c8:	6105                	addi	sp,sp,32
    18ca:	8082                	ret
            return -1;
    18cc:	557d                	li	a0,-1
}
    18ce:	8082                	ret
            return -1;
    18d0:	557d                	li	a0,-1
    18d2:	bfd5                	j	18c6 <_in_char.part.0+0x38>

00000000000018d4 <_skip_space>:
{
    18d4:	7139                	addi	sp,sp,-64
    18d6:	f822                	sd	s0,48(sp)
    18d8:	f426                	sd	s1,40(sp)
    18da:	f04a                	sd	s2,32(sp)
    18dc:	ec4e                	sd	s3,24(sp)
    18de:	e852                	sd	s4,16(sp)
    18e0:	fc06                	sd	ra,56(sp)
    18e2:	842a                	mv	s0,a0
        ctx->ungotten = -1;
    18e4:	54fd                	li	s1,-1
    if (read(ctx->fd, &c, 1) == 1)
    18e6:	00f10a13          	addi	s4,sp,15
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    18ea:	02000913          	li	s2,32
    18ee:	4991                	li	s3,4
    if (ctx->ungotten >= 0)
    18f0:	4c1c                	lw	a5,24(s0)
    18f2:	0407d163          	bgez	a5,1934 <_skip_space+0x60>
    if (ctx->fd == -1)
    18f6:	4408                	lw	a0,8(s0)
    if (read(ctx->fd, &c, 1) == 1)
    18f8:	4605                	li	a2,1
    18fa:	85d2                	mv	a1,s4
    if (ctx->fd == -1)
    18fc:	02951e63          	bne	a0,s1,1938 <_skip_space+0x64>
        if (ctx->buf[ctx->pos] == '\0')
    1900:	6818                	ld	a4,16(s0)
    1902:	601c                	ld	a5,0(s0)
        return (unsigned char)ctx->buf[ctx->pos++];
    1904:	00170693          	addi	a3,a4,1
        if (ctx->buf[ctx->pos] == '\0')
    1908:	97ba                	add	a5,a5,a4
    190a:	0007c703          	lbu	a4,0(a5) # 7000 <STDIN_FD+0x778>
    190e:	cb19                	beqz	a4,1924 <_skip_space+0x50>
        return (unsigned char)ctx->buf[ctx->pos++];
    1910:	e814                	sd	a3,16(s0)
    1912:	0007c783          	lbu	a5,0(a5)
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    1916:	ff77871b          	addiw	a4,a5,-9
    191a:	fd278be3          	beq	a5,s2,18f0 <_skip_space+0x1c>
    191e:	fce9f9e3          	bgeu	s3,a4,18f0 <_skip_space+0x1c>
        ctx->ungotten = c;
    1922:	cc1c                	sw	a5,24(s0)
}
    1924:	70e2                	ld	ra,56(sp)
    1926:	7442                	ld	s0,48(sp)
    1928:	74a2                	ld	s1,40(sp)
    192a:	7902                	ld	s2,32(sp)
    192c:	69e2                	ld	s3,24(sp)
    192e:	6a42                	ld	s4,16(sp)
    1930:	6121                	addi	sp,sp,64
    1932:	8082                	ret
        ctx->ungotten = -1;
    1934:	cc04                	sw	s1,24(s0)
        return c;
    1936:	b7c5                	j	1916 <_skip_space+0x42>
    if (read(ctx->fd, &c, 1) == 1)
    1938:	f88ff0ef          	jal	10c0 <read>
    193c:	4785                	li	a5,1
    193e:	fef513e3          	bne	a0,a5,1924 <_skip_space+0x50>
        return (unsigned char)c;
    1942:	00f14783          	lbu	a5,15(sp)
    1946:	bfc1                	j	1916 <_skip_space+0x42>

0000000000001948 <_vscanf_core.constprop.0>:
static int _vscanf_core(_InContext *ctx, const char *format, va_list ap)
    1948:	7155                	addi	sp,sp,-208
    194a:	e586                	sd	ra,200(sp)
    194c:	e95a                	sd	s6,144(sp)
    while (*p)
    194e:	0005c783          	lbu	a5,0(a1)
static int _vscanf_core(_InContext *ctx, const char *format, va_list ap)
    1952:	e432                	sd	a2,8(sp)
    while (*p)
    1954:	68078b63          	beqz	a5,1fea <_vscanf_core.constprop.0+0x6a2>
    1958:	e1a2                	sd	s0,192(sp)
    195a:	fd26                	sd	s1,184(sp)
    195c:	f152                	sd	s4,160(sp)
    195e:	ed56                	sd	s5,152(sp)
    1960:	f4ee                	sd	s11,104(sp)
    1962:	842e                	mv	s0,a1
    1964:	8daa                	mv	s11,a0
    int assigned = 0;
    1966:	4b01                	li	s6,0
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    1968:	02000493          	li	s1,32
    196c:	4a91                	li	s5,4
        if (*p != '%')
    196e:	02500a13          	li	s4,37
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    1972:	04978763          	beq	a5,s1,19c0 <_vscanf_core.constprop.0+0x78>
    1976:	ff77869b          	addiw	a3,a5,-9
    197a:	0ff6f693          	zext.b	a3,a3
    197e:	04daf163          	bgeu	s5,a3,19c0 <_vscanf_core.constprop.0+0x78>
        if (*p != '%')
    1982:	07478d63          	beq	a5,s4,19fc <_vscanf_core.constprop.0+0xb4>
            _skip_space(ctx);
    1986:	856e                	mv	a0,s11
    1988:	f4dff0ef          	jal	18d4 <_skip_space>
    if (ctx->ungotten >= 0)
    198c:	018da503          	lw	a0,24(s11)
    1990:	04055a63          	bgez	a0,19e4 <_vscanf_core.constprop.0+0x9c>
    1994:	856e                	mv	a0,s11
    1996:	ef9ff0ef          	jal	188e <_in_char.part.0>
            if (c != *p)
    199a:	00044783          	lbu	a5,0(s0)
    199e:	04a78a63          	beq	a5,a0,19f2 <_vscanf_core.constprop.0+0xaa>
    if (c != -1)
    19a2:	57fd                	li	a5,-1
    19a4:	00f50463          	beq	a0,a5,19ac <_vscanf_core.constprop.0+0x64>
        ctx->ungotten = c;
    19a8:	00adac23          	sw	a0,24(s11)
    19ac:	640e                	ld	s0,192(sp)
    19ae:	74ea                	ld	s1,184(sp)
    19b0:	7a0a                	ld	s4,160(sp)
    19b2:	6aea                	ld	s5,152(sp)
    19b4:	7da6                	ld	s11,104(sp)
}
    19b6:	60ae                	ld	ra,200(sp)
    19b8:	855a                	mv	a0,s6
    19ba:	6b4a                	ld	s6,144(sp)
    19bc:	6169                	addi	sp,sp,208
    19be:	8082                	ret
            _skip_space(ctx);
    19c0:	856e                	mv	a0,s11
    19c2:	f13ff0ef          	jal	18d4 <_skip_space>
            while (isspace(*p))
    19c6:	00044783          	lbu	a5,0(s0)
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    19ca:	4611                	li	a2,4
    19cc:	ff77869b          	addiw	a3,a5,-9
    19d0:	0ff6f693          	zext.b	a3,a3
    19d4:	00978663          	beq	a5,s1,19e0 <_vscanf_core.constprop.0+0x98>
    19d8:	00d67463          	bgeu	a2,a3,19e0 <_vscanf_core.constprop.0+0x98>
    while (*p)
    19dc:	fbd9                	bnez	a5,1972 <_vscanf_core.constprop.0+0x2a>
    19de:	b7f9                	j	19ac <_vscanf_core.constprop.0+0x64>
                p++;
    19e0:	0405                	addi	s0,s0,1
    19e2:	b7d5                	j	19c6 <_vscanf_core.constprop.0+0x7e>
        ctx->ungotten = -1;
    19e4:	57fd                	li	a5,-1
    19e6:	00fdac23          	sw	a5,24(s11)
            if (c != *p)
    19ea:	00044783          	lbu	a5,0(s0)
    19ee:	faa79ae3          	bne	a5,a0,19a2 <_vscanf_core.constprop.0+0x5a>
    while (*p)
    19f2:	00144783          	lbu	a5,1(s0)
            p++;
    19f6:	0405                	addi	s0,s0,1
    while (*p)
    19f8:	ffad                	bnez	a5,1972 <_vscanf_core.constprop.0+0x2a>
    19fa:	bf4d                	j	19ac <_vscanf_core.constprop.0+0x64>
    19fc:	f94a                	sd	s2,176(sp)
    19fe:	f54e                	sd	s3,168(sp)
    1a00:	e55e                	sd	s7,136(sp)
    1a02:	e162                	sd	s8,128(sp)
        if (*p == '*')
    1a04:	00144583          	lbu	a1,1(s0)
    1a08:	02a00793          	li	a5,42
    1a0c:	22f58d63          	beq	a1,a5,1c46 <_vscanf_core.constprop.0+0x2fe>
        p++;
    1a10:	0405                	addi	s0,s0,1
        int suppress = 0;
    1a12:	4981                	li	s3,0
        while (*p >= '0' && *p <= '9')
    1a14:	fd05861b          	addiw	a2,a1,-48
    1a18:	0ff67693          	zext.b	a3,a2
    1a1c:	47a5                	li	a5,9
    1a1e:	36d7e763          	bltu	a5,a3,1d8c <_vscanf_core.constprop.0+0x444>
    1a22:	4781                	li	a5,0
    1a24:	4825                	li	a6,9
    1a26:	a019                	j	1a2c <_vscanf_core.constprop.0+0xe4>
            width = width * 10 + (*p - '0');
    1a28:	0016979b          	slliw	a5,a3,0x1
        while (*p >= '0' && *p <= '9')
    1a2c:	00144583          	lbu	a1,1(s0)
            width = width * 10 + (*p - '0');
    1a30:	00f6093b          	addw	s2,a2,a5
    1a34:	0029169b          	slliw	a3,s2,0x2
        while (*p >= '0' && *p <= '9')
    1a38:	fd05861b          	addiw	a2,a1,-48
    1a3c:	0ff67513          	zext.b	a0,a2
            width = width * 10 + (*p - '0');
    1a40:	012686bb          	addw	a3,a3,s2
            p++;
    1a44:	0405                	addi	s0,s0,1
        while (*p >= '0' && *p <= '9')
    1a46:	fea871e3          	bgeu	a6,a0,1a28 <_vscanf_core.constprop.0+0xe0>
        if (*p == 'l')
    1a4a:	06c00693          	li	a3,108
            p++;
    1a4e:	00140b93          	addi	s7,s0,1
        if (*p == 'l')
    1a52:	1ed58f63          	beq	a1,a3,1c50 <_vscanf_core.constprop.0+0x308>
        else if (*p == 'h')
    1a56:	06800693          	li	a3,104
    1a5a:	2ad58863          	beq	a1,a3,1d0a <_vscanf_core.constprop.0+0x3c2>
        char spec = *p++;
    1a5e:	00044c03          	lbu	s8,0(s0)
    1a62:	8ba2                	mv	s7,s0
        int len_mod = 0;
    1a64:	ec02                	sd	zero,24(sp)
        char spec = *p++;
    1a66:	06300693          	li	a3,99
    1a6a:	001b8413          	addi	s0,s7,1
        if (!spec)
    1a6e:	2adc0863          	beq	s8,a3,1d1e <_vscanf_core.constprop.0+0x3d6>
    1a72:	1f86fc63          	bgeu	a3,s8,1c6a <_vscanf_core.constprop.0+0x322>
    1a76:	f9cc069b          	addiw	a3,s8,-100
    1a7a:	0ff6f693          	zext.b	a3,a3
    1a7e:	4651                	li	a2,20
    1a80:	0cd66e63          	bltu	a2,a3,1b5c <_vscanf_core.constprop.0+0x214>
    1a84:	00120637          	lui	a2,0x120
    1a88:	4585                	li	a1,1
    1a8a:	00d595b3          	sll	a1,a1,a3
    1a8e:	02160613          	addi	a2,a2,33 # 120021 <_ZSt4cerr+0x117261>
    1a92:	8e6d                	and	a2,a2,a1
    1a94:	ee69                	bnez	a2,1b6e <_vscanf_core.constprop.0+0x226>
    1a96:	89b9                	andi	a1,a1,14
    1a98:	1e059263          	bnez	a1,1c7c <_vscanf_core.constprop.0+0x334>
    1a9c:	463d                	li	a2,15
    1a9e:	0ac69f63          	bne	a3,a2,1b5c <_vscanf_core.constprop.0+0x214>
            _skip_space(ctx);
    1aa2:	856e                	mv	a0,s11
    1aa4:	e31ff0ef          	jal	18d4 <_skip_space>
            char *buf = suppress ? NULL : va_arg(ap, char *);
    1aa8:	ec02                	sd	zero,24(sp)
    1aaa:	00099763          	bnez	s3,1ab8 <_vscanf_core.constprop.0+0x170>
    1aae:	67a2                	ld	a5,8(sp)
    1ab0:	6398                	ld	a4,0(a5)
    1ab2:	07a1                	addi	a5,a5,8
    1ab4:	e43e                	sd	a5,8(sp)
    1ab6:	ec3a                	sd	a4,24(sp)
    if (ctx->ungotten >= 0)
    1ab8:	018da503          	lw	a0,24(s11)
    1abc:	2e055b63          	bgez	a0,1db2 <_vscanf_core.constprop.0+0x46a>
    1ac0:	856e                	mv	a0,s11
    1ac2:	dcdff0ef          	jal	188e <_in_char.part.0>
            while (c != -1 && !isspace(c))
    1ac6:	56fd                	li	a3,-1
    1ac8:	6ad50363          	beq	a0,a3,216e <_vscanf_core.constprop.0+0x826>
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    1acc:	02000693          	li	a3,32
    1ad0:	3ed50963          	beq	a0,a3,1ec2 <_vscanf_core.constprop.0+0x57a>
    1ad4:	46a5                	li	a3,9
    1ad6:	3ed50663          	beq	a0,a3,1ec2 <_vscanf_core.constprop.0+0x57a>
    1ada:	46a9                	li	a3,10
    1adc:	3ed50363          	beq	a0,a3,1ec2 <_vscanf_core.constprop.0+0x57a>
    1ae0:	46ad                	li	a3,11
    1ae2:	3ed50063          	beq	a0,a3,1ec2 <_vscanf_core.constprop.0+0x57a>
    1ae6:	46b1                	li	a3,12
    1ae8:	3cd50d63          	beq	a0,a3,1ec2 <_vscanf_core.constprop.0+0x57a>
    1aec:	46b5                	li	a3,13
    1aee:	3cd50a63          	beq	a0,a3,1ec2 <_vscanf_core.constprop.0+0x57a>
    1af2:	67e2                	ld	a5,24(sp)
    1af4:	fce6                	sd	s9,120(sp)
    1af6:	f8ea                	sd	s10,112(sp)
    1af8:	e83e                	sd	a5,16(sp)
    1afa:	4d01                	li	s10,0
            while (c != -1 && !isspace(c))
    1afc:	5c7d                	li	s8,-1
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    1afe:	02000c93          	li	s9,32
                if (width > 0 && i >= width)
    1b02:	01205463          	blez	s2,1b0a <_vscanf_core.constprop.0+0x1c2>
    1b06:	052d5563          	bge	s10,s2,1b50 <_vscanf_core.constprop.0+0x208>
                if (!suppress)
    1b0a:	00099563          	bnez	s3,1b14 <_vscanf_core.constprop.0+0x1cc>
                    buf[i] = (char)c;
    1b0e:	67c2                	ld	a5,16(sp)
    1b10:	00a78023          	sb	a0,0(a5)
    if (ctx->ungotten >= 0)
    1b14:	018da503          	lw	a0,24(s11)
                i++;
    1b18:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
    1b1a:	30055963          	bgez	a0,1e2c <_vscanf_core.constprop.0+0x4e4>
    1b1e:	856e                	mv	a0,s11
    1b20:	d6fff0ef          	jal	188e <_in_char.part.0>
            while (c != -1 && !isspace(c))
    1b24:	27850663          	beq	a0,s8,1d90 <_vscanf_core.constprop.0+0x448>
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    1b28:	03950463          	beq	a0,s9,1b50 <_vscanf_core.constprop.0+0x208>
    1b2c:	47a5                	li	a5,9
    1b2e:	02f50163          	beq	a0,a5,1b50 <_vscanf_core.constprop.0+0x208>
    1b32:	47a9                	li	a5,10
    1b34:	00f50e63          	beq	a0,a5,1b50 <_vscanf_core.constprop.0+0x208>
    1b38:	47ad                	li	a5,11
    1b3a:	00f50b63          	beq	a0,a5,1b50 <_vscanf_core.constprop.0+0x208>
    1b3e:	47b1                	li	a5,12
    1b40:	00f50863          	beq	a0,a5,1b50 <_vscanf_core.constprop.0+0x208>
    1b44:	67c2                	ld	a5,16(sp)
    1b46:	0785                	addi	a5,a5,1
    1b48:	e83e                	sd	a5,16(sp)
    1b4a:	47b5                	li	a5,13
    1b4c:	faf51be3          	bne	a0,a5,1b02 <_vscanf_core.constprop.0+0x1ba>
            if (!suppress)
    1b50:	64098a63          	beqz	s3,21a4 <_vscanf_core.constprop.0+0x85c>
    1b54:	7ce6                	ld	s9,120(sp)
    1b56:	7d46                	ld	s10,112(sp)
        ctx->ungotten = c;
    1b58:	00adac23          	sw	a0,24(s11)
    while (*p)
    1b5c:	001bc783          	lbu	a5,1(s7)
    1b60:	794a                	ld	s2,176(sp)
    1b62:	79aa                	ld	s3,168(sp)
    1b64:	6baa                	ld	s7,136(sp)
    1b66:	6c0a                	ld	s8,128(sp)
    1b68:	e00795e3          	bnez	a5,1972 <_vscanf_core.constprop.0+0x2a>
    1b6c:	b581                	j	19ac <_vscanf_core.constprop.0+0x64>
            _skip_space(ctx);
    1b6e:	856e                	mv	a0,s11
    1b70:	f8ea                	sd	s10,112(sp)
    1b72:	d63ff0ef          	jal	18d4 <_skip_space>
    if (ctx->ungotten >= 0)
    1b76:	018da503          	lw	a0,24(s11)
    1b7a:	24055063          	bgez	a0,1dba <_vscanf_core.constprop.0+0x472>
    1b7e:	856e                	mv	a0,s11
    1b80:	d0fff0ef          	jal	188e <_in_char.part.0>
            if (c == '-' || c == '+')
    1b84:	fd55069b          	addiw	a3,a0,-43
    1b88:	9af5                	andi	a3,a3,-3
    1b8a:	2681                	sext.w	a3,a3
            int i = 0, c = _in_char(ctx);
    1b8c:	4d01                	li	s10,0
            if (c == '-' || c == '+')
    1b8e:	3e068863          	beqz	a3,1f7e <_vscanf_core.constprop.0+0x636>
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
    1b92:	07800693          	li	a3,120
    1b96:	4641                	li	a2,16
    1b98:	00dc0863          	beq	s8,a3,1ba8 <_vscanf_core.constprop.0+0x260>
    1b9c:	06900693          	li	a3,105
    1ba0:	4629                	li	a2,10
    1ba2:	00dc1363          	bne	s8,a3,1ba8 <_vscanf_core.constprop.0+0x260>
    1ba6:	4601                	li	a2,0
            while (c != -1 && i < 63)
    1ba8:	56fd                	li	a3,-1
    1baa:	5cd50863          	beq	a0,a3,217a <_vscanf_core.constprop.0+0x832>
    1bae:	fce6                	sd	s9,120(sp)
    1bb0:	02010893          	addi	a7,sp,32
    1bb4:	01a88c33          	add	s8,a7,s10
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
    1bb8:	4cc1                	li	s9,16
                int digit = (c >= '0' && c <= '9');
    1bba:	fd05069b          	addiw	a3,a0,-48
    1bbe:	0005031b          	sext.w	t1,a0
    1bc2:	00a6b593          	sltiu	a1,a3,10
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
    1bc6:	27960a63          	beq	a2,s9,1e3a <_vscanf_core.constprop.0+0x4f2>
    1bca:	2a060d63          	beqz	a2,1e84 <_vscanf_core.constprop.0+0x53c>
                int x = (c == 'x' || c == 'X');
    1bce:	07800793          	li	a5,120
    1bd2:	2ef50363          	beq	a0,a5,1eb8 <_vscanf_core.constprop.0+0x570>
    1bd6:	fa850693          	addi	a3,a0,-88
    1bda:	0016b693          	seqz	a3,a3
    1bde:	4301                	li	t1,0
                if (width > 0 && i >= width)
    1be0:	01205463          	blez	s2,1be8 <_vscanf_core.constprop.0+0x2a0>
    1be4:	032d5a63          	bge	s10,s2,1c18 <_vscanf_core.constprop.0+0x2d0>
                if (digit || hex || x)
    1be8:	0066e6b3          	or	a3,a3,t1
    1bec:	8ecd                	or	a3,a3,a1
    1bee:	c68d                	beqz	a3,1c18 <_vscanf_core.constprop.0+0x2d0>
                    num_buf[i++] = (char)c;
    1bf0:	00ac0023          	sb	a0,0(s8)
    if (ctx->ungotten >= 0)
    1bf4:	018da503          	lw	a0,24(s11)
                    num_buf[i++] = (char)c;
    1bf8:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
    1bfa:	22055c63          	bgez	a0,1e32 <_vscanf_core.constprop.0+0x4ea>
    1bfe:	856e                	mv	a0,s11
    1c00:	e832                	sd	a2,16(sp)
    1c02:	c8dff0ef          	jal	188e <_in_char.part.0>
            while (c != -1 && i < 63)
    1c06:	57fd                	li	a5,-1
    1c08:	6642                	ld	a2,16(sp)
    1c0a:	3cf50263          	beq	a0,a5,1fce <_vscanf_core.constprop.0+0x686>
    1c0e:	03f00693          	li	a3,63
    1c12:	0c05                	addi	s8,s8,1
    1c14:	fadd13e3          	bne	s10,a3,1bba <_vscanf_core.constprop.0+0x272>
            num_buf[i] = '\0';
    1c18:	040d0793          	addi	a5,s10,64
    1c1c:	1018                	addi	a4,sp,32
    1c1e:	97ba                	add	a5,a5,a4
    1c20:	fc078023          	sb	zero,-64(a5)
        ctx->ungotten = c;
    1c24:	00adac23          	sw	a0,24(s11)
    1c28:	7ce6                	ld	s9,120(sp)
            if (i == 0)
    1c2a:	1e0d0663          	beqz	s10,1e16 <_vscanf_core.constprop.0+0x4ce>
            if (!suppress)
    1c2e:	36098363          	beqz	s3,1f94 <_vscanf_core.constprop.0+0x64c>
    while (*p)
    1c32:	001bc783          	lbu	a5,1(s7)
        {
    1c36:	794a                	ld	s2,176(sp)
    1c38:	79aa                	ld	s3,168(sp)
    1c3a:	6baa                	ld	s7,136(sp)
    1c3c:	6c0a                	ld	s8,128(sp)
    1c3e:	7d46                	ld	s10,112(sp)
    while (*p)
    1c40:	d20799e3          	bnez	a5,1972 <_vscanf_core.constprop.0+0x2a>
    1c44:	b3a5                	j	19ac <_vscanf_core.constprop.0+0x64>
        while (*p >= '0' && *p <= '9')
    1c46:	00244583          	lbu	a1,2(s0)
            suppress = 1;
    1c4a:	4985                	li	s3,1
            p++;
    1c4c:	0409                	addi	s0,s0,2
    1c4e:	b3d9                	j	1a14 <_vscanf_core.constprop.0+0xcc>
            if (*p == 'l')
    1c50:	00144c03          	lbu	s8,1(s0)
            len_mod = 1;
    1c54:	4785                	li	a5,1
    1c56:	ec3e                	sd	a5,24(sp)
            if (*p == 'l')
    1c58:	e0bc17e3          	bne	s8,a1,1a66 <_vscanf_core.constprop.0+0x11e>
                len_mod = 2;
    1c5c:	4789                	li	a5,2
        char spec = *p++;
    1c5e:	00244c03          	lbu	s8,2(s0)
                p++;
    1c62:	00240b93          	addi	s7,s0,2
                len_mod = 2;
    1c66:	ec3e                	sd	a5,24(sp)
    1c68:	bbfd                	j	1a66 <_vscanf_core.constprop.0+0x11e>
    1c6a:	100c0763          	beqz	s8,1d78 <_vscanf_core.constprop.0+0x430>
    1c6e:	fbbc079b          	addiw	a5,s8,-69
    1c72:	0ff7f793          	zext.b	a5,a5
    1c76:	4689                	li	a3,2
    1c78:	eef6e2e3          	bltu	a3,a5,1b5c <_vscanf_core.constprop.0+0x214>
            _skip_space(ctx);
    1c7c:	856e                	mv	a0,s11
    1c7e:	f8ea                	sd	s10,112(sp)
    1c80:	c55ff0ef          	jal	18d4 <_skip_space>
    if (ctx->ungotten >= 0)
    1c84:	018da783          	lw	a5,24(s11)
    1c88:	1207dd63          	bgez	a5,1dc2 <_vscanf_core.constprop.0+0x47a>
    1c8c:	856e                	mv	a0,s11
    1c8e:	c01ff0ef          	jal	188e <_in_char.part.0>
            if (c == '-' || c == '+')
    1c92:	fd55069b          	addiw	a3,a0,-43
    1c96:	ffd6f613          	andi	a2,a3,-3
    1c9a:	2601                	sext.w	a2,a2
    1c9c:	87aa                	mv	a5,a0
    1c9e:	12060c63          	beqz	a2,1dd6 <_vscanf_core.constprop.0+0x48e>
            while (c != -1 && i < 63)
    1ca2:	567d                	li	a2,-1
    1ca4:	16c50963          	beq	a0,a2,1e16 <_vscanf_core.constprop.0+0x4ce>
    1ca8:	fce6                	sd	s9,120(sp)
            int i = 0, c = _in_char(ctx);
    1caa:	4d01                	li	s10,0
    1cac:	80000937          	lui	s2,0x80000
    1cb0:	197d                	addi	s2,s2,-1 # ffffffff7fffffff <_ZSt4cerr+0xffffffff7fff723f>
    1cb2:	0932                	slli	s2,s2,0xc
    1cb4:	80194913          	xori	s2,s2,-2047
    1cb8:	093e                	slli	s2,s2,0xf
    1cba:	02010813          	addi	a6,sp,32
    1cbe:	01a80cb3          	add	s9,a6,s10
    1cc2:	03a00c13          	li	s8,58
    1cc6:	1935                	addi	s2,s2,-19
    1cc8:	a831                	j	1ce4 <_vscanf_core.constprop.0+0x39c>
    1cca:	bc5ff0ef          	jal	188e <_in_char.part.0>
            while (c != -1 && i < 63)
    1cce:	577d                	li	a4,-1
    1cd0:	87aa                	mv	a5,a0
    1cd2:	2ee50563          	beq	a0,a4,1fbc <_vscanf_core.constprop.0+0x674>
    1cd6:	03f00713          	li	a4,63
    1cda:	0c85                	addi	s9,s9,1
    1cdc:	1eed0e63          	beq	s10,a4,1ed8 <_vscanf_core.constprop.0+0x590>
    1ce0:	fd57869b          	addiw	a3,a5,-43
        int c = ctx->ungotten;
    1ce4:	00d95633          	srl	a2,s2,a3
    1ce8:	856e                	mv	a0,s11
    1cea:	8a05                	andi	a2,a2,1
    1cec:	1edc6663          	bltu	s8,a3,1ed8 <_vscanf_core.constprop.0+0x590>
    1cf0:	1e060463          	beqz	a2,1ed8 <_vscanf_core.constprop.0+0x590>
                    num_buf[i++] = (char)c;
    1cf4:	00fc8023          	sb	a5,0(s9)
    if (ctx->ungotten >= 0)
    1cf8:	018da783          	lw	a5,24(s11)
                    num_buf[i++] = (char)c;
    1cfc:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
    1cfe:	fc07c6e3          	bltz	a5,1cca <_vscanf_core.constprop.0+0x382>
        ctx->ungotten = -1;
    1d02:	577d                	li	a4,-1
    1d04:	00edac23          	sw	a4,24(s11)
            while (c != -1 && i < 63)
    1d08:	b7f9                	j	1cd6 <_vscanf_core.constprop.0+0x38e>
            if (*p == 'h')
    1d0a:	00144c03          	lbu	s8,1(s0)
        int len_mod = 0;
    1d0e:	ec02                	sd	zero,24(sp)
            if (*p == 'h')
    1d10:	d4bc1be3          	bne	s8,a1,1a66 <_vscanf_core.constprop.0+0x11e>
        char spec = *p++;
    1d14:	00244c03          	lbu	s8,2(s0)
                p++;
    1d18:	00240b93          	addi	s7,s0,2
    1d1c:	b3a9                	j	1a66 <_vscanf_core.constprop.0+0x11e>
    1d1e:	fce6                	sd	s9,120(sp)
    1d20:	f8ea                	sd	s10,112(sp)
            int count = (width > 0) ? width : 1;
    1d22:	00090c1b          	sext.w	s8,s2
    1d26:	0d205a63          	blez	s2,1dfa <_vscanf_core.constprop.0+0x4b2>
            char *buf = suppress ? NULL : va_arg(ap, char *);
    1d2a:	4d01                	li	s10,0
    1d2c:	06098d63          	beqz	s3,1da6 <_vscanf_core.constprop.0+0x45e>
            for (int i = 0; i < count; i++)
    1d30:	9c6a                	add	s8,s8,s10
                if (c == -1)
    1d32:	5cfd                	li	s9,-1
    if (ctx->ungotten >= 0)
    1d34:	018da783          	lw	a5,24(s11)
        ctx->ungotten = -1;
    1d38:	856e                	mv	a0,s11
    if (ctx->ungotten >= 0)
    1d3a:	0207dc63          	bgez	a5,1d72 <_vscanf_core.constprop.0+0x42a>
    1d3e:	b51ff0ef          	jal	188e <_in_char.part.0>
    1d42:	87aa                	mv	a5,a0
                if (c == -1)
    1d44:	0b950d63          	beq	a0,s9,1dfe <_vscanf_core.constprop.0+0x4b6>
                if (!suppress)
    1d48:	00099463          	bnez	s3,1d50 <_vscanf_core.constprop.0+0x408>
                    buf[i] = (char)c;
    1d4c:	00fd0023          	sb	a5,0(s10)
            for (int i = 0; i < count; i++)
    1d50:	0d05                	addi	s10,s10,1
    1d52:	ffac11e3          	bne	s8,s10,1d34 <_vscanf_core.constprop.0+0x3ec>
    while (*p)
    1d56:	001bc783          	lbu	a5,1(s7)
            if (!suppress)
    1d5a:	00099363          	bnez	s3,1d60 <_vscanf_core.constprop.0+0x418>
                assigned++;
    1d5e:	2b05                	addiw	s6,s6,1
    1d60:	794a                	ld	s2,176(sp)
    1d62:	79aa                	ld	s3,168(sp)
    1d64:	6baa                	ld	s7,136(sp)
    1d66:	6c0a                	ld	s8,128(sp)
    1d68:	7ce6                	ld	s9,120(sp)
    1d6a:	7d46                	ld	s10,112(sp)
    while (*p)
    1d6c:	c00793e3          	bnez	a5,1972 <_vscanf_core.constprop.0+0x2a>
    1d70:	b935                	j	19ac <_vscanf_core.constprop.0+0x64>
        ctx->ungotten = -1;
    1d72:	019dac23          	sw	s9,24(s11)
                if (c == -1)
    1d76:	bfc9                	j	1d48 <_vscanf_core.constprop.0+0x400>
    1d78:	640e                	ld	s0,192(sp)
    1d7a:	74ea                	ld	s1,184(sp)
    1d7c:	794a                	ld	s2,176(sp)
    1d7e:	79aa                	ld	s3,168(sp)
    1d80:	7a0a                	ld	s4,160(sp)
    1d82:	6aea                	ld	s5,152(sp)
    1d84:	6baa                	ld	s7,136(sp)
    1d86:	6c0a                	ld	s8,128(sp)
    1d88:	7da6                	ld	s11,104(sp)
    1d8a:	b135                	j	19b6 <_vscanf_core.constprop.0+0x6e>
        int width = -1;
    1d8c:	597d                	li	s2,-1
    1d8e:	b975                	j	1a4a <_vscanf_core.constprop.0+0x102>
            if (!suppress)
    1d90:	3c099c63          	bnez	s3,2168 <_vscanf_core.constprop.0+0x820>
                buf[i] = '\0';
    1d94:	67e2                	ld	a5,24(sp)
    1d96:	01a786b3          	add	a3,a5,s10
    1d9a:	00068023          	sb	zero,0(a3)
    while (*p)
    1d9e:	001bc783          	lbu	a5,1(s7)
                assigned++;
    1da2:	2b05                	addiw	s6,s6,1
    1da4:	bf75                	j	1d60 <_vscanf_core.constprop.0+0x418>
            char *buf = suppress ? NULL : va_arg(ap, char *);
    1da6:	67a2                	ld	a5,8(sp)
    1da8:	0007bd03          	ld	s10,0(a5)
    1dac:	07a1                	addi	a5,a5,8
    1dae:	e43e                	sd	a5,8(sp)
    1db0:	b741                	j	1d30 <_vscanf_core.constprop.0+0x3e8>
        ctx->ungotten = -1;
    1db2:	56fd                	li	a3,-1
    1db4:	00ddac23          	sw	a3,24(s11)
            while (c != -1 && !isspace(c))
    1db8:	bb11                	j	1acc <_vscanf_core.constprop.0+0x184>
        ctx->ungotten = -1;
    1dba:	56fd                	li	a3,-1
    1dbc:	00ddac23          	sw	a3,24(s11)
        return c;
    1dc0:	b3d1                	j	1b84 <_vscanf_core.constprop.0+0x23c>
            if (c == '-' || c == '+')
    1dc2:	fd57869b          	addiw	a3,a5,-43
    1dc6:	ffd6f613          	andi	a2,a3,-3
        ctx->ungotten = -1;
    1dca:	55fd                	li	a1,-1
    1dcc:	00bdac23          	sw	a1,24(s11)
            if (c == '-' || c == '+')
    1dd0:	2601                	sext.w	a2,a2
    1dd2:	ec061be3          	bnez	a2,1ca8 <_vscanf_core.constprop.0+0x360>
                num_buf[i++] = (char)c;
    1dd6:	02f10023          	sb	a5,32(sp)
    if (ctx->ungotten >= 0)
    1dda:	018da783          	lw	a5,24(s11)
    1dde:	2207da63          	bgez	a5,2012 <_vscanf_core.constprop.0+0x6ca>
    1de2:	856e                	mv	a0,s11
    1de4:	aabff0ef          	jal	188e <_in_char.part.0>
            while (c != -1 && i < 63)
    1de8:	567d                	li	a2,-1
    1dea:	87aa                	mv	a5,a0
                num_buf[i++] = (char)c;
    1dec:	4d05                	li	s10,1
    1dee:	fd55069b          	addiw	a3,a0,-43
            while (c != -1 && i < 63)
    1df2:	3ac50163          	beq	a0,a2,2194 <_vscanf_core.constprop.0+0x84c>
    1df6:	fce6                	sd	s9,120(sp)
    1df8:	bd55                	j	1cac <_vscanf_core.constprop.0+0x364>
            int count = (width > 0) ? width : 1;
    1dfa:	4c05                	li	s8,1
    1dfc:	b73d                	j	1d2a <_vscanf_core.constprop.0+0x3e2>
    1dfe:	640e                	ld	s0,192(sp)
    1e00:	74ea                	ld	s1,184(sp)
    1e02:	794a                	ld	s2,176(sp)
    1e04:	79aa                	ld	s3,168(sp)
    1e06:	7a0a                	ld	s4,160(sp)
    1e08:	6aea                	ld	s5,152(sp)
    1e0a:	6baa                	ld	s7,136(sp)
    1e0c:	6c0a                	ld	s8,128(sp)
    1e0e:	7ce6                	ld	s9,120(sp)
    1e10:	7d46                	ld	s10,112(sp)
    1e12:	7da6                	ld	s11,104(sp)
    1e14:	b64d                	j	19b6 <_vscanf_core.constprop.0+0x6e>
    1e16:	640e                	ld	s0,192(sp)
    1e18:	74ea                	ld	s1,184(sp)
    1e1a:	794a                	ld	s2,176(sp)
    1e1c:	79aa                	ld	s3,168(sp)
    1e1e:	7a0a                	ld	s4,160(sp)
    1e20:	6aea                	ld	s5,152(sp)
    1e22:	6baa                	ld	s7,136(sp)
    1e24:	6c0a                	ld	s8,128(sp)
    1e26:	7d46                	ld	s10,112(sp)
    1e28:	7da6                	ld	s11,104(sp)
    1e2a:	b671                	j	19b6 <_vscanf_core.constprop.0+0x6e>
        ctx->ungotten = -1;
    1e2c:	018dac23          	sw	s8,24(s11)
            while (c != -1 && !isspace(c))
    1e30:	b9e5                	j	1b28 <_vscanf_core.constprop.0+0x1e0>
        ctx->ungotten = -1;
    1e32:	57fd                	li	a5,-1
    1e34:	00fdac23          	sw	a5,24(s11)
            while (c != -1 && i < 63)
    1e38:	bbd9                	j	1c0e <_vscanf_core.constprop.0+0x2c6>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
    1e3a:	f9f3069b          	addiw	a3,t1,-97
    1e3e:	4795                	li	a5,5
    1e40:	06d7f263          	bgeu	a5,a3,1ea4 <_vscanf_core.constprop.0+0x55c>
    1e44:	fbf3031b          	addiw	t1,t1,-65
    1e48:	4795                	li	a5,5
    1e4a:	0467fd63          	bgeu	a5,t1,1ea4 <_vscanf_core.constprop.0+0x55c>
                int x = (c == 'x' || c == 'X');
    1e4e:	07800693          	li	a3,120
    1e52:	18d50763          	beq	a0,a3,1fe0 <_vscanf_core.constprop.0+0x698>
    1e56:	fa850693          	addi	a3,a0,-88
    1e5a:	0016b693          	seqz	a3,a3
                if (base == 0 && i == 1 && num_buf[0] == '0' && x)
    1e5e:	4301                	li	t1,0
    1e60:	32061663          	bnez	a2,218c <_vscanf_core.constprop.0+0x844>
    1e64:	4785                	li	a5,1
    1e66:	4601                	li	a2,0
    1e68:	d6fd1ce3          	bne	s10,a5,1be0 <_vscanf_core.constprop.0+0x298>
    1e6c:	02014e03          	lbu	t3,32(sp)
    1e70:	03000793          	li	a5,48
    1e74:	d6fe16e3          	bne	t3,a5,1be0 <_vscanf_core.constprop.0+0x298>
    1e78:	d60684e3          	beqz	a3,1be0 <_vscanf_core.constprop.0+0x298>
                    base = 16;
    1e7c:	4641                	li	a2,16
                if (width > 0 && i >= width)
    1e7e:	d7a919e3          	bne	s2,s10,1bf0 <_vscanf_core.constprop.0+0x2a8>
    1e82:	bb59                	j	1c18 <_vscanf_core.constprop.0+0x2d0>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
    1e84:	f9f3069b          	addiw	a3,t1,-97
    1e88:	4795                	li	a5,5
    1e8a:	02d7f263          	bgeu	a5,a3,1eae <_vscanf_core.constprop.0+0x566>
    1e8e:	fbf3031b          	addiw	t1,t1,-65
    1e92:	0467f063          	bgeu	a5,t1,1ed2 <_vscanf_core.constprop.0+0x58a>
                int x = (c == 'x' || c == 'X');
    1e96:	07800693          	li	a3,120
    1e9a:	fad51ee3          	bne	a0,a3,1e56 <_vscanf_core.constprop.0+0x50e>
    1e9e:	4301                	li	t1,0
    1ea0:	4685                	li	a3,1
    1ea2:	b7c9                	j	1e64 <_vscanf_core.constprop.0+0x51c>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
    1ea4:	4305                	li	t1,1
                int x = (c == 'x' || c == 'X');
    1ea6:	4681                	li	a3,0
                if (width > 0 && i >= width)
    1ea8:	d3204ee3          	bgtz	s2,1be4 <_vscanf_core.constprop.0+0x29c>
    1eac:	bb35                	j	1be8 <_vscanf_core.constprop.0+0x2a0>
                int x = (c == 'x' || c == 'X');
    1eae:	4681                	li	a3,0
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
    1eb0:	4305                	li	t1,1
                if (width > 0 && i >= width)
    1eb2:	d32049e3          	bgtz	s2,1be4 <_vscanf_core.constprop.0+0x29c>
    1eb6:	bb0d                	j	1be8 <_vscanf_core.constprop.0+0x2a0>
    1eb8:	4301                	li	t1,0
                int x = (c == 'x' || c == 'X');
    1eba:	4685                	li	a3,1
                if (width > 0 && i >= width)
    1ebc:	d32044e3          	bgtz	s2,1be4 <_vscanf_core.constprop.0+0x29c>
    1ec0:	bb05                	j	1bf0 <_vscanf_core.constprop.0+0x2a8>
            if (!suppress)
    1ec2:	c8099be3          	bnez	s3,1b58 <_vscanf_core.constprop.0+0x210>
                buf[i] = '\0';
    1ec6:	67e2                	ld	a5,24(sp)
    1ec8:	00078023          	sb	zero,0(a5)
        ctx->ungotten = c;
    1ecc:	00adac23          	sw	a0,24(s11)
            if (i > 0 && !suppress)
    1ed0:	b171                	j	1b5c <_vscanf_core.constprop.0+0x214>
                int x = (c == 'x' || c == 'X');
    1ed2:	4681                	li	a3,0
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
    1ed4:	4305                	li	t1,1
    1ed6:	b779                	j	1e64 <_vscanf_core.constprop.0+0x51c>
            num_buf[i] = '\0';
    1ed8:	040d0713          	addi	a4,s10,64
    1edc:	1014                	addi	a3,sp,32
    1ede:	96ba                	add	a3,a3,a4
    1ee0:	fc068023          	sb	zero,-64(a3)
        ctx->ungotten = c;
    1ee4:	00fdac23          	sw	a5,24(s11)
            if (i == 0)
    1ee8:	f00d0be3          	beqz	s10,1dfe <_vscanf_core.constprop.0+0x4b6>
    1eec:	7ce6                	ld	s9,120(sp)
            if (!suppress)
    1eee:	d40992e3          	bnez	s3,1c32 <_vscanf_core.constprop.0+0x2ea>
    if (*str == '-')
    1ef2:	02014603          	lbu	a2,32(sp)
    1ef6:	02d00793          	li	a5,45
    1efa:	1af60963          	beq	a2,a5,20ac <_vscanf_core.constprop.0+0x764>
    else if (*str == '+')
    1efe:	02b00793          	li	a5,43
    1f02:	20f60a63          	beq	a2,a5,2116 <_vscanf_core.constprop.0+0x7ce>
    1f06:	00005797          	auipc	a5,0x5
    1f0a:	9927b587          	fld	fa1,-1646(a5) # 6898 <STDIN_FD+0x10>
    1f0e:	101c                	addi	a5,sp,32
    while (*str >= '0' && *str <= '9')
    1f10:	fd06069b          	addiw	a3,a2,-48
    1f14:	0ff6f513          	zext.b	a0,a3
    1f18:	45a5                	li	a1,9
    1f1a:	f20007d3          	fmv.d.x	fa5,zero
    1f1e:	02a5e463          	bltu	a1,a0,1f46 <_vscanf_core.constprop.0+0x5fe>
    1f22:	00005717          	auipc	a4,0x5
    1f26:	97e73707          	fld	fa4,-1666(a4) # 68a0 <STDIN_FD+0x18>
    1f2a:	4525                	li	a0,9
    1f2c:	0017c603          	lbu	a2,1(a5)
        val = val * 10.0 + (*str - '0');
    1f30:	d20686d3          	fcvt.d.w	fa3,a3
        str++;
    1f34:	0785                	addi	a5,a5,1
    while (*str >= '0' && *str <= '9')
    1f36:	fd06069b          	addiw	a3,a2,-48
    1f3a:	0ff6f593          	zext.b	a1,a3
        val = val * 10.0 + (*str - '0');
    1f3e:	6ae7f7c3          	fmadd.d	fa5,fa5,fa4,fa3
    while (*str >= '0' && *str <= '9')
    1f42:	feb575e3          	bgeu	a0,a1,1f2c <_vscanf_core.constprop.0+0x5e4>
    if (*str == '.')
    1f46:	02e00693          	li	a3,46
    1f4a:	16d60a63          	beq	a2,a3,20be <_vscanf_core.constprop.0+0x776>
    if (*str == 'e' || *str == 'E')
    1f4e:	0007c683          	lbu	a3,0(a5)
    1f52:	0df6f693          	andi	a3,a3,223
    1f56:	04500613          	li	a2,69
    1f5a:	0cc68463          	beq	a3,a2,2022 <_vscanf_core.constprop.0+0x6da>
                    *va_arg(ap, double *) = val;
    1f5e:	6722                	ld	a4,8(sp)
                if (len_mod == 1)
    1f60:	4685                	li	a3,1
    return sign * val;
    1f62:	12b7f7d3          	fmul.d	fa5,fa5,fa1
                    *va_arg(ap, double *) = val;
    1f66:	631c                	ld	a5,0(a4)
                    *va_arg(ap, int64 *) = val;
    1f68:	0721                	addi	a4,a4,8
    1f6a:	e43a                	sd	a4,8(sp)
                if (len_mod == 1)
    1f6c:	6762                	ld	a4,24(sp)
    1f6e:	18d70b63          	beq	a4,a3,2104 <_vscanf_core.constprop.0+0x7bc>
                    *va_arg(ap, float *) = (float)val;
    1f72:	4017f7d3          	fcvt.s.d	fa5,fa5
                assigned++;
    1f76:	2b05                	addiw	s6,s6,1
                    *va_arg(ap, float *) = (float)val;
    1f78:	00f7a027          	fsw	fa5,0(a5)
    1f7c:	b95d                	j	1c32 <_vscanf_core.constprop.0+0x2ea>
                num_buf[i++] = (char)c;
    1f7e:	02a10023          	sb	a0,32(sp)
    if (ctx->ungotten >= 0)
    1f82:	018da503          	lw	a0,24(s11)
    1f86:	06055463          	bgez	a0,1fee <_vscanf_core.constprop.0+0x6a6>
    1f8a:	856e                	mv	a0,s11
    1f8c:	903ff0ef          	jal	188e <_in_char.part.0>
                num_buf[i++] = (char)c;
    1f90:	4d05                	li	s10,1
    1f92:	b101                	j	1b92 <_vscanf_core.constprop.0+0x24a>
                int64 val = strtoll(num_buf, NULL, base);
    1f94:	4581                	li	a1,0
    1f96:	1008                	addi	a0,sp,32
    1f98:	67e030ef          	jal	5616 <strtoll>
                    *va_arg(ap, int64 *) = val;
    1f9c:	67a2                	ld	a5,8(sp)
                if (len_mod == 2)
    1f9e:	6762                	ld	a4,24(sp)
    1fa0:	4689                	li	a3,2
                    *va_arg(ap, int64 *) = val;
    1fa2:	07a1                	addi	a5,a5,8
                if (len_mod == 2)
    1fa4:	16d70363          	beq	a4,a3,210a <_vscanf_core.constprop.0+0x7c2>
                    *va_arg(ap, int64 *) = val;
    1fa8:	6722                	ld	a4,8(sp)
                else if (len_mod == 1)
    1faa:	4605                	li	a2,1
                    *va_arg(ap, int64 *) = val;
    1fac:	6314                	ld	a3,0(a4)
                else if (len_mod == 1)
    1fae:	6762                	ld	a4,24(sp)
    1fb0:	16c70163          	beq	a4,a2,2112 <_vscanf_core.constprop.0+0x7ca>
                    *va_arg(ap, int *) = (int)val;
    1fb4:	c288                	sw	a0,0(a3)
                assigned++;
    1fb6:	2b05                	addiw	s6,s6,1
    1fb8:	e43e                	sd	a5,8(sp)
    1fba:	b9a5                	j	1c32 <_vscanf_core.constprop.0+0x2ea>
            num_buf[i] = '\0';
    1fbc:	040d0793          	addi	a5,s10,64
    1fc0:	1018                	addi	a4,sp,32
    1fc2:	00e785b3          	add	a1,a5,a4
    1fc6:	fc058023          	sb	zero,-64(a1)
            if (i == 0)
    1fca:	7ce6                	ld	s9,120(sp)
    1fcc:	b70d                	j	1eee <_vscanf_core.constprop.0+0x5a6>
            num_buf[i] = '\0';
    1fce:	040d0793          	addi	a5,s10,64
    1fd2:	1018                	addi	a4,sp,32
    1fd4:	00e78833          	add	a6,a5,a4
    1fd8:	fc080023          	sb	zero,-64(a6)
            if (i == 0)
    1fdc:	7ce6                	ld	s9,120(sp)
    1fde:	b981                	j	1c2e <_vscanf_core.constprop.0+0x2e6>
                int x = (c == 'x' || c == 'X');
    1fe0:	4301                	li	t1,0
    1fe2:	4685                	li	a3,1
                if (width > 0 && i >= width)
    1fe4:	c12040e3          	bgtz	s2,1be4 <_vscanf_core.constprop.0+0x29c>
    1fe8:	b101                	j	1be8 <_vscanf_core.constprop.0+0x2a0>
    int assigned = 0;
    1fea:	4b01                	li	s6,0
    1fec:	b2e9                	j	19b6 <_vscanf_core.constprop.0+0x6e>
        ctx->ungotten = -1;
    1fee:	56fd                	li	a3,-1
    1ff0:	fce6                	sd	s9,120(sp)
    1ff2:	00ddac23          	sw	a3,24(s11)
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
    1ff6:	07800693          	li	a3,120
    1ffa:	4641                	li	a2,16
                num_buf[i++] = (char)c;
    1ffc:	4d05                	li	s10,1
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
    1ffe:	badc09e3          	beq	s8,a3,1bb0 <_vscanf_core.constprop.0+0x268>
    2002:	06900693          	li	a3,105
    2006:	4629                	li	a2,10
                num_buf[i++] = (char)c;
    2008:	4d05                	li	s10,1
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
    200a:	badc13e3          	bne	s8,a3,1bb0 <_vscanf_core.constprop.0+0x268>
    200e:	4601                	li	a2,0
    2010:	b645                	j	1bb0 <_vscanf_core.constprop.0+0x268>
        ctx->ungotten = -1;
    2012:	56fd                	li	a3,-1
    2014:	fce6                	sd	s9,120(sp)
    2016:	00ddac23          	sw	a3,24(s11)
                num_buf[i++] = (char)c;
    201a:	4d05                	li	s10,1
    201c:	fd57869b          	addiw	a3,a5,-43
    2020:	b171                	j	1cac <_vscanf_core.constprop.0+0x364>
        if (*str == '-')
    2022:	0017c583          	lbu	a1,1(a5)
    2026:	02d00693          	li	a3,45
    202a:	0ed58f63          	beq	a1,a3,2128 <_vscanf_core.constprop.0+0x7e0>
        else if (*str == '+')
    202e:	02b00693          	li	a3,43
    2032:	10d58e63          	beq	a1,a3,214e <_vscanf_core.constprop.0+0x806>
        while (*str >= '0' && *str <= '9')
    2036:	fd05861b          	addiw	a2,a1,-48
    203a:	0ff67513          	zext.b	a0,a2
    203e:	45a5                	li	a1,9
        str++;
    2040:	00178693          	addi	a3,a5,1
        int esign = 1;
    2044:	4805                	li	a6,1
        while (*str >= '0' && *str <= '9')
    2046:	04a5ec63          	bltu	a1,a0,209e <_vscanf_core.constprop.0+0x756>
    204a:	4525                	li	a0,9
    204c:	0016c583          	lbu	a1,1(a3)
            eval = eval * 10 + (*str - '0');
    2050:	0029979b          	slliw	a5,s3,0x2
    2054:	013787bb          	addw	a5,a5,s3
    2058:	0017979b          	slliw	a5,a5,0x1
    205c:	00f609bb          	addw	s3,a2,a5
        while (*str >= '0' && *str <= '9')
    2060:	fd05861b          	addiw	a2,a1,-48
    2064:	0ff67593          	zext.b	a1,a2
            str++;
    2068:	0685                	addi	a3,a3,1
        while (*str >= '0' && *str <= '9')
    206a:	feb571e3          	bgeu	a0,a1,204c <_vscanf_core.constprop.0+0x704>
        while (eval--)
    206e:	fff9879b          	addiw	a5,s3,-1
    2072:	12098463          	beqz	s3,219a <_vscanf_core.constprop.0+0x852>
        double p = 1.0;
    2076:	00005717          	auipc	a4,0x5
    207a:	82273687          	fld	fa3,-2014(a4) # 6898 <STDIN_FD+0x10>
    207e:	00005717          	auipc	a4,0x5
    2082:	82273707          	fld	fa4,-2014(a4) # 68a0 <STDIN_FD+0x18>
        while (eval--)
    2086:	56fd                	li	a3,-1
    2088:	37fd                	addiw	a5,a5,-1
            p *= 10.0;
    208a:	12e6f6d3          	fmul.d	fa3,fa3,fa4
        while (eval--)
    208e:	fed79de3          	bne	a5,a3,2088 <_vscanf_core.constprop.0+0x740>
        if (esign == 1)
    2092:	4785                	li	a5,1
    2094:	00f80963          	beq	a6,a5,20a6 <_vscanf_core.constprop.0+0x75e>
            val /= p;
    2098:	1ad7f7d3          	fdiv.d	fa5,fa5,fa3
    209c:	b5c9                	j	1f5e <_vscanf_core.constprop.0+0x616>
        double p = 1.0;
    209e:	00004797          	auipc	a5,0x4
    20a2:	7fa7b687          	fld	fa3,2042(a5) # 6898 <STDIN_FD+0x10>
            val *= p;
    20a6:	12d7f7d3          	fmul.d	fa5,fa5,fa3
    20aa:	bd55                	j	1f5e <_vscanf_core.constprop.0+0x616>
    while (*str >= '0' && *str <= '9')
    20ac:	00004797          	auipc	a5,0x4
    20b0:	7e47b587          	fld	fa1,2020(a5) # 6890 <STDIN_FD+0x8>
    20b4:	02114603          	lbu	a2,33(sp)
        str++;
    20b8:	02110793          	addi	a5,sp,33
    20bc:	bd91                	j	1f10 <_vscanf_core.constprop.0+0x5c8>
        while (*str >= '0' && *str <= '9')
    20be:	0017c683          	lbu	a3,1(a5)
    20c2:	45a5                	li	a1,9
        str++;
    20c4:	0785                	addi	a5,a5,1
        while (*str >= '0' && *str <= '9')
    20c6:	fd06861b          	addiw	a2,a3,-48
    20ca:	0ff67513          	zext.b	a0,a2
    20ce:	e8a5e2e3          	bltu	a1,a0,1f52 <_vscanf_core.constprop.0+0x60a>
        double div = 10.0;
    20d2:	00004717          	auipc	a4,0x4
    20d6:	7ce73707          	fld	fa4,1998(a4) # 68a0 <STDIN_FD+0x18>
    20da:	22e70653          	fmv.d	fa2,fa4
        while (*str >= '0' && *str <= '9')
    20de:	4525                	li	a0,9
            val += (*str - '0') / div;
    20e0:	d20606d3          	fcvt.d.w	fa3,a2
        while (*str >= '0' && *str <= '9')
    20e4:	0017c683          	lbu	a3,1(a5)
            str++;
    20e8:	0785                	addi	a5,a5,1
            val += (*str - '0') / div;
    20ea:	1ac6f6d3          	fdiv.d	fa3,fa3,fa2
        while (*str >= '0' && *str <= '9')
    20ee:	fd06861b          	addiw	a2,a3,-48
    20f2:	0ff67593          	zext.b	a1,a2
            div *= 10.0;
    20f6:	12e67653          	fmul.d	fa2,fa2,fa4
            val += (*str - '0') / div;
    20fa:	02d7f7d3          	fadd.d	fa5,fa5,fa3
        while (*str >= '0' && *str <= '9')
    20fe:	feb571e3          	bgeu	a0,a1,20e0 <_vscanf_core.constprop.0+0x798>
    2102:	bd81                	j	1f52 <_vscanf_core.constprop.0+0x60a>
                    *va_arg(ap, double *) = val;
    2104:	a39c                	fsd	fa5,0(a5)
                assigned++;
    2106:	2b05                	addiw	s6,s6,1
    2108:	b62d                	j	1c32 <_vscanf_core.constprop.0+0x2ea>
                    *va_arg(ap, int64 *) = val;
    210a:	6722                	ld	a4,8(sp)
    210c:	6314                	ld	a3,0(a4)
    210e:	e288                	sd	a0,0(a3)
    2110:	b55d                	j	1fb6 <_vscanf_core.constprop.0+0x66e>
                    *va_arg(ap, long *) = (long)val;
    2112:	e288                	sd	a0,0(a3)
    2114:	b54d                	j	1fb6 <_vscanf_core.constprop.0+0x66e>
    while (*str >= '0' && *str <= '9')
    2116:	00004797          	auipc	a5,0x4
    211a:	7827b587          	fld	fa1,1922(a5) # 6898 <STDIN_FD+0x10>
    211e:	02114603          	lbu	a2,33(sp)
        str++;
    2122:	02110793          	addi	a5,sp,33
    2126:	b3ed                	j	1f10 <_vscanf_core.constprop.0+0x5c8>
        while (*str >= '0' && *str <= '9')
    2128:	0027c583          	lbu	a1,2(a5)
            str++;
    212c:	00278693          	addi	a3,a5,2
        while (*str >= '0' && *str <= '9')
    2130:	4525                	li	a0,9
    2132:	fd05861b          	addiw	a2,a1,-48
    2136:	0ff67793          	zext.b	a5,a2
            esign = -1;
    213a:	587d                	li	a6,-1
        while (*str >= '0' && *str <= '9')
    213c:	f0f577e3          	bgeu	a0,a5,204a <_vscanf_core.constprop.0+0x702>
        double p = 1.0;
    2140:	00004797          	auipc	a5,0x4
    2144:	7587b687          	fld	fa3,1880(a5) # 6898 <STDIN_FD+0x10>
            val /= p;
    2148:	1ad7f7d3          	fdiv.d	fa5,fa5,fa3
    214c:	bd09                	j	1f5e <_vscanf_core.constprop.0+0x616>
        while (*str >= '0' && *str <= '9')
    214e:	0027c583          	lbu	a1,2(a5)
            str++;
    2152:	00278693          	addi	a3,a5,2
        while (*str >= '0' && *str <= '9')
    2156:	4525                	li	a0,9
    2158:	fd05861b          	addiw	a2,a1,-48
    215c:	0ff67793          	zext.b	a5,a2
    2160:	f2f56fe3          	bltu	a0,a5,209e <_vscanf_core.constprop.0+0x756>
        int esign = 1;
    2164:	4805                	li	a6,1
    2166:	b5d5                	j	204a <_vscanf_core.constprop.0+0x702>
    while (*p)
    2168:	001bc783          	lbu	a5,1(s7)
    216c:	bed5                	j	1d60 <_vscanf_core.constprop.0+0x418>
            if (!suppress)
    216e:	9e0997e3          	bnez	s3,1b5c <_vscanf_core.constprop.0+0x214>
                buf[i] = '\0';
    2172:	67e2                	ld	a5,24(sp)
    2174:	00078023          	sb	zero,0(a5)
    2178:	b2d5                	j	1b5c <_vscanf_core.constprop.0+0x214>
            num_buf[i] = '\0';
    217a:	040d0793          	addi	a5,s10,64
    217e:	1018                	addi	a4,sp,32
    2180:	97ba                	add	a5,a5,a4
    2182:	fc078023          	sb	zero,-64(a5)
            if (i == 0)
    2186:	aa0d14e3          	bnez	s10,1c2e <_vscanf_core.constprop.0+0x2e6>
    218a:	b171                	j	1e16 <_vscanf_core.constprop.0+0x4ce>
    218c:	4641                	li	a2,16
                if (width > 0 && i >= width)
    218e:	a5204be3          	bgtz	s2,1be4 <_vscanf_core.constprop.0+0x29c>
    2192:	bc99                	j	1be8 <_vscanf_core.constprop.0+0x2a0>
            num_buf[i] = '\0';
    2194:	020100a3          	sb	zero,33(sp)
            if (i == 0)
    2198:	bb99                	j	1eee <_vscanf_core.constprop.0+0x5a6>
        double p = 1.0;
    219a:	00004797          	auipc	a5,0x4
    219e:	6fe7b687          	fld	fa3,1790(a5) # 6898 <STDIN_FD+0x10>
    21a2:	bdc5                	j	2092 <_vscanf_core.constprop.0+0x74a>
                buf[i] = '\0';
    21a4:	67e2                	ld	a5,24(sp)
    21a6:	01a786b3          	add	a3,a5,s10
    21aa:	00068023          	sb	zero,0(a3)
        ctx->ungotten = c;
    21ae:	00adac23          	sw	a0,24(s11)
    while (*p)
    21b2:	001bc783          	lbu	a5,1(s7)
    21b6:	b6f5                	j	1da2 <_vscanf_core.constprop.0+0x45a>

00000000000021b8 <_out_char>:
{
    21b8:	7179                	addi	sp,sp,-48
    21ba:	ec26                	sd	s1,24(sp)
    if (ctx->stream)
    21bc:	6d04                	ld	s1,24(a0)
{
    21be:	f022                	sd	s0,32(sp)
    21c0:	f406                	sd	ra,40(sp)
    21c2:	842a                	mv	s0,a0
    21c4:	872e                	mv	a4,a1
    if (ctx->stream)
    21c6:	c0a1                	beqz	s1,2206 <_out_char+0x4e>
    21c8:	e84a                	sd	s2,16(sp)
    if (stream->buf_mode == 2)
    21ca:	41c4a903          	lw	s2,1052(s1)
    21ce:	4789                	li	a5,2
    21d0:	04f90d63          	beq	s2,a5,222a <_out_char+0x72>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    21d4:	4104a783          	lw	a5,1040(s1)
    if (stream->buf_write_pos >= BUFSIZ)
    21d8:	3ff00693          	li	a3,1023
    stream->buffer[stream->buf_write_pos++] = (char)c;
    21dc:	0017861b          	addiw	a2,a5,1
    21e0:	40c4a823          	sw	a2,1040(s1)
    21e4:	97a6                	add	a5,a5,s1
    21e6:	00b78823          	sb	a1,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    21ea:	08c6c063          	blt	a3,a2,226a <_out_char+0xb2>
    else if (stream->buf_mode == 1 && c == '\n')
    21ee:	4785                	li	a5,1
    21f0:	04f90a63          	beq	s2,a5,2244 <_out_char+0x8c>
        ctx->written++;
    21f4:	681c                	ld	a5,16(s0)
    21f6:	6942                	ld	s2,16(sp)
}
    21f8:	70a2                	ld	ra,40(sp)
        ctx->written++;
    21fa:	0785                	addi	a5,a5,1
    21fc:	e81c                	sd	a5,16(s0)
}
    21fe:	7402                	ld	s0,32(sp)
    2200:	64e2                	ld	s1,24(sp)
    2202:	6145                	addi	sp,sp,48
    2204:	8082                	ret
        if (ctx->limit > 0 && ctx->written < ctx->limit - 1)
    2206:	6514                	ld	a3,8(a0)
    2208:	691c                	ld	a5,16(a0)
    220a:	ca89                	beqz	a3,221c <_out_char+0x64>
    220c:	16fd                	addi	a3,a3,-1
    220e:	00d7f763          	bgeu	a5,a3,221c <_out_char+0x64>
            ctx->buf[ctx->written] = c;
    2212:	6114                	ld	a3,0(a0)
    2214:	97b6                	add	a5,a5,a3
    2216:	00b78023          	sb	a1,0(a5)
        ctx->written++;
    221a:	691c                	ld	a5,16(a0)
    221c:	0785                	addi	a5,a5,1
}
    221e:	70a2                	ld	ra,40(sp)
        ctx->written++;
    2220:	e81c                	sd	a5,16(s0)
}
    2222:	7402                	ld	s0,32(sp)
    2224:	64e2                	ld	s1,24(sp)
    2226:	6145                	addi	sp,sp,48
    2228:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    222a:	4088                	lw	a0,0(s1)
    222c:	4605                	li	a2,1
    222e:	00f10593          	addi	a1,sp,15
        char ch = (char)c;
    2232:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    2236:	e93fe0ef          	jal	10c8 <write>
    223a:	4785                	li	a5,1
    223c:	faf50ce3          	beq	a0,a5,21f4 <_out_char+0x3c>
            stream->error = 1;
    2240:	c49c                	sw	a5,8(s1)
            return EOF;
    2242:	bf4d                	j	21f4 <_out_char+0x3c>
    else if (stream->buf_mode == 1 && c == '\n')
    2244:	47a9                	li	a5,10
    2246:	faf597e3          	bne	a1,a5,21f4 <_out_char+0x3c>
    if (stream->buf_write_pos > 0)
    224a:	fac055e3          	blez	a2,21f4 <_out_char+0x3c>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    224e:	4088                	lw	a0,0(s1)
    2250:	01048593          	addi	a1,s1,16
    2254:	e75fe0ef          	jal	10c8 <write>
        if (ret < stream->buf_write_pos)
    2258:	4104a783          	lw	a5,1040(s1)
    225c:	02f55063          	bge	a0,a5,227c <_out_char+0xc4>
            stream->error = 1;
    2260:	0124a423          	sw	s2,8(s1)
            stream->buf_write_pos = 0;
    2264:	4004a823          	sw	zero,1040(s1)
            return EOF;
    2268:	b771                	j	21f4 <_out_char+0x3c>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    226a:	4088                	lw	a0,0(s1)
    226c:	01048593          	addi	a1,s1,16
    2270:	e59fe0ef          	jal	10c8 <write>
        if (ret < stream->buf_write_pos)
    2274:	4104a783          	lw	a5,1040(s1)
    2278:	00f54563          	blt	a0,a5,2282 <_out_char+0xca>
        stream->buf_write_pos = 0;
    227c:	4004a823          	sw	zero,1040(s1)
    2280:	bf95                	j	21f4 <_out_char+0x3c>
            stream->error = 1;
    2282:	4785                	li	a5,1
    2284:	c49c                	sw	a5,8(s1)
            stream->buf_write_pos = 0;
    2286:	4004a823          	sw	zero,1040(s1)
            return EOF;
    228a:	b7ad                	j	21f4 <_out_char+0x3c>

000000000000228c <stbsp_set_separators>:
   "75767778798081828384858687888990919293949596979899"
};

STBSP__PUBLICDEF void STB_SPRINTF_DECORATE(set_separators)(char pcomma, char pperiod)
{
   stbsp__period = pperiod;
    228c:	00006797          	auipc	a5,0x6
    2290:	bdc78793          	addi	a5,a5,-1060 # 7e68 <stbsp__digitpair>
    2294:	0cb78623          	sb	a1,204(a5)
   stbsp__comma = pcomma;
    2298:	0ca786a3          	sb	a0,205(a5)
}
    229c:	8082                	ret

000000000000229e <stbsp_vsprintfcb>:

   return (stbsp__uint32)(sn - s);
}

STBSP__PUBLICDEF int STB_SPRINTF_DECORATE(vsprintfcb)(STBSP_SPRINTFCB *callback, void *user, char *buf, char const *fmt, va_list va)
{
    229e:	d1010113          	addi	sp,sp,-752
            // Check if the next 4 bytes contain %(0x25) or end of string.
            // Using the 'hasless' trick:
            // https://graphics.stanford.edu/~seander/bithacks.html#HasLessInWord
            stbsp__uint32 v, c;
            v = *(stbsp__uint32 *)f;
            c = (~v) & 0x80808080;
    22a2:	808087b7          	lui	a5,0x80808
            if (((v ^ 0x25252525) - 0x01010101) & c)
    22a6:	252523b7          	lui	t2,0x25252
    22aa:	52538393          	addi	t2,t2,1317 # 25252525 <_ZSt4cerr+0x25249765>
{
    22ae:	29913c23          	sd	s9,664(sp)
    22b2:	29b13423          	sd	s11,648(sp)
   int tlen = 0;
    22b6:	4c81                	li	s9,0
            if (((v ^ 0x25252525) - 0x01010101) & c)
    22b8:	feff0db7          	lui	s11,0xfeff0
            c = (~v) & 0x80808080;
    22bc:	08078793          	addi	a5,a5,128 # ffffffff80808080 <_ZSt4cerr+0xffffffff807ff2c0>
{
    22c0:	2e813023          	sd	s0,736(sp)
    22c4:	2c913c23          	sd	s1,728(sp)
    22c8:	2d213823          	sd	s2,720(sp)
    22cc:	2d313423          	sd	s3,712(sp)
    22d0:	2b713423          	sd	s7,680(sp)
    22d4:	2b813023          	sd	s8,672(sp)
    22d8:	29a13823          	sd	s10,656(sp)
    22dc:	2e113423          	sd	ra,744(sp)
    22e0:	8d66                	mv	s10,s9
    22e2:	8432                	mv	s0,a2
    22e4:	8c9e                	mv	s9,t2
    22e6:	89aa                	mv	s3,a0
    22e8:	e42e                	sd	a1,8(sp)
    22ea:	84b6                	mv	s1,a3
    22ec:	8bba                	mv	s7,a4
    22ee:	fc02                	sd	zero,56(sp)
   for (;;) {
    22f0:	8932                	mv	s2,a2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    22f2:	effd8d9b          	addiw	s11,s11,-257 # fffffffffefefeff <_ZSt4cerr+0xfffffffffefe713f>
               goto schk1;
            if ((v - 0x01010101) & c)
               goto schk2;
            if (callback)
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    22f6:	20000c13          	li	s8,512
    22fa:	83be                	mv	t2,a5
         while (((stbsp__uintptr)f) & 3) {
    22fc:	0034f793          	andi	a5,s1,3
    2300:	c7a9                	beqz	a5,234a <stbsp_vsprintfcb+0xac>
            if (f[0] == '%')
    2302:	0004c783          	lbu	a5,0(s1)
    2306:	02500713          	li	a4,37
    230a:	0ee78263          	beq	a5,a4,23ee <stbsp_vsprintfcb+0x150>
            if (f[0] == 0)
    230e:	cbd9                	beqz	a5,23a4 <stbsp_vsprintfcb+0x106>
            stbsp__chk_cb_buf(1);
    2310:	02098663          	beqz	s3,233c <stbsp_vsprintfcb+0x9e>
    2314:	4124063b          	subw	a2,s0,s2
    2318:	1fe00713          	li	a4,510
    231c:	02c75063          	bge	a4,a2,233c <stbsp_vsprintfcb+0x9e>
    2320:	65a2                	ld	a1,8(sp)
    2322:	854a                	mv	a0,s2
    2324:	e81e                	sd	t2,16(sp)
    2326:	00cd0d3b          	addw	s10,s10,a2
    232a:	9982                	jalr	s3
    232c:	892a                	mv	s2,a0
    232e:	e119                	bnez	a0,2334 <stbsp_vsprintfcb+0x96>
    2330:	0200106f          	j	3350 <stbsp_vsprintfcb+0x10b2>
            *bf++ = f[0];
    2334:	0004c783          	lbu	a5,0(s1)
            stbsp__chk_cb_buf(1);
    2338:	63c2                	ld	t2,16(sp)
    233a:	842a                	mv	s0,a0
            ++f;
    233c:	0485                	addi	s1,s1,1
            *bf++ = f[0];
    233e:	00f40023          	sb	a5,0(s0)
         while (((stbsp__uintptr)f) & 3) {
    2342:	0034f793          	andi	a5,s1,3
            *bf++ = f[0];
    2346:	0405                	addi	s0,s0,1
         while (((stbsp__uintptr)f) & 3) {
    2348:	ffcd                	bnez	a5,2302 <stbsp_vsprintfcb+0x64>
            v = *(stbsp__uint32 *)f;
    234a:	4094                	lw	a3,0(s1)
            c = (~v) & 0x80808080;
    234c:	fff6c793          	not	a5,a3
            if (((v ^ 0x25252525) - 0x01010101) & c)
    2350:	0196c733          	xor	a4,a3,s9
            c = (~v) & 0x80808080;
    2354:	0077f7b3          	and	a5,a5,t2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    2358:	01b7073b          	addw	a4,a4,s11
    235c:	8f7d                	and	a4,a4,a5
    235e:	2701                	sext.w	a4,a4
    2360:	f34d                	bnez	a4,2302 <stbsp_vsprintfcb+0x64>
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    2362:	460d                	li	a2,3
    2364:	a805                	j	2394 <stbsp_vsprintfcb+0xf6>
            if (callback)
    2366:	00098863          	beqz	s3,2376 <stbsp_vsprintfcb+0xd8>
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    236a:	412407b3          	sub	a5,s0,s2
    236e:	40fc07bb          	subw	a5,s8,a5
    2372:	f8f658e3          	bge	a2,a5,2302 <stbsp_vsprintfcb+0x64>
                    bf[2] = f[2];
                    bf[3] = f[3];
                } else
            #endif
            {
                *(stbsp__uint32 *)bf = v;
    2376:	c014                	sw	a3,0(s0)
            v = *(stbsp__uint32 *)f;
    2378:	40d4                	lw	a3,4(s1)
            }
            bf += 4;
    237a:	0411                	addi	s0,s0,4
            f += 4;
    237c:	0491                	addi	s1,s1,4
            c = (~v) & 0x80808080;
    237e:	fff6c793          	not	a5,a3
            if (((v ^ 0x25252525) - 0x01010101) & c)
    2382:	0196c733          	xor	a4,a3,s9
            c = (~v) & 0x80808080;
    2386:	0077f7b3          	and	a5,a5,t2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    238a:	01b7073b          	addw	a4,a4,s11
    238e:	8f7d                	and	a4,a4,a5
    2390:	2701                	sext.w	a4,a4
    2392:	fb25                	bnez	a4,2302 <stbsp_vsprintfcb+0x64>
            if ((v - 0x01010101) & c)
    2394:	01b6873b          	addw	a4,a3,s11
    2398:	8ff9                	and	a5,a5,a4
    239a:	2781                	sext.w	a5,a5
    239c:	d7e9                	beqz	a5,2366 <stbsp_vsprintfcb+0xc8>
            if (f[0] == 0)
    239e:	0004c783          	lbu	a5,0(s1)
    23a2:	f7bd                	bnez	a5,2310 <stbsp_vsprintfcb+0x72>
endfmt:

   if (!callback)
      *bf = 0;
   else
      stbsp__flush_cb();
    23a4:	8cea                	mv	s9,s10
    23a6:	412404bb          	subw	s1,s0,s2
   if (!callback)
    23aa:	70098563          	beqz	s3,2ab4 <stbsp_vsprintfcb+0x816>
      stbsp__flush_cb();
    23ae:	00905663          	blez	s1,23ba <stbsp_vsprintfcb+0x11c>
    23b2:	65a2                	ld	a1,8(sp)
    23b4:	8626                	mv	a2,s1
    23b6:	854a                	mv	a0,s2
    23b8:	9982                	jalr	s3
    23ba:	009c8cbb          	addw	s9,s9,s1

done:
   return tlen + (int)(bf - buf);
}
    23be:	2e813083          	ld	ra,744(sp)
    23c2:	2e013403          	ld	s0,736(sp)
    23c6:	2d813483          	ld	s1,728(sp)
    23ca:	2d013903          	ld	s2,720(sp)
    23ce:	2c813983          	ld	s3,712(sp)
    23d2:	2a813b83          	ld	s7,680(sp)
    23d6:	2a013c03          	ld	s8,672(sp)
    23da:	29013d03          	ld	s10,656(sp)
    23de:	28813d83          	ld	s11,648(sp)
    23e2:	8566                	mv	a0,s9
    23e4:	29813c83          	ld	s9,664(sp)
    23e8:	2f010113          	addi	sp,sp,752
    23ec:	8082                	ret
    23ee:	2d413023          	sd	s4,704(sp)
    23f2:	2b513c23          	sd	s5,696(sp)
    23f6:	2b613823          	sd	s6,688(sp)
      tz = 0;
    23fa:	00248693          	addi	a3,s1,2
      fl = 0;
    23fe:	4e01                	li	t3,0
         switch (f[0]) {
    2400:	03f00593          	li	a1,63
    2404:	00004617          	auipc	a2,0x4
    2408:	db460613          	addi	a2,a2,-588 # 61b8 <_GLOBAL__sub_I__ZSt3cin+0x210>
    240c:	fff6c783          	lbu	a5,-1(a3)
    2410:	fff68493          	addi	s1,a3,-1
    2414:	fe07871b          	addiw	a4,a5,-32
    2418:	0ff77713          	zext.b	a4,a4
    241c:	00e5ec63          	bltu	a1,a4,2434 <stbsp_vsprintfcb+0x196>
    2420:	070a                	slli	a4,a4,0x2
    2422:	9732                	add	a4,a4,a2
    2424:	4318                	lw	a4,0(a4)
    2426:	9732                	add	a4,a4,a2
    2428:	8702                	jr	a4
      if (f[0] == '*') {
    242a:	0014c783          	lbu	a5,1(s1)
            fl |= STBSP__LEADINGZERO;
    242e:	010e6e13          	ori	t3,t3,16
            ++f;
    2432:	0485                	addi	s1,s1,1
      if (f[0] == '*') {
    2434:	02a00713          	li	a4,42
    2438:	0ce79163          	bne	a5,a4,24fa <stbsp_vsprintfcb+0x25c>
         fw = va_arg(va, stbsp__uint32);
    243c:	000bab03          	lw	s6,0(s7)
         while ((f[0] >= '0') && (f[0] <= '9')) {
    2440:	0014c783          	lbu	a5,1(s1)
         fw = va_arg(va, stbsp__uint32);
    2444:	0ba1                	addi	s7,s7,8
         ++f;
    2446:	0485                	addi	s1,s1,1
      if (f[0] == '.') {
    2448:	02e00713          	li	a4,46
      pr = -1;
    244c:	58fd                	li	a7,-1
      if (f[0] == '.') {
    244e:	0ee78663          	beq	a5,a4,253a <stbsp_vsprintfcb+0x29c>
      switch (f[0]) {
    2452:	04900713          	li	a4,73
    2456:	10e78263          	beq	a5,a4,255a <stbsp_vsprintfcb+0x2bc>
    245a:	f987871b          	addiw	a4,a5,-104
    245e:	0ff77713          	zext.b	a4,a4
    2462:	46c9                	li	a3,18
    2464:	02e6e063          	bltu	a3,a4,2484 <stbsp_vsprintfcb+0x1e6>
    2468:	00004697          	auipc	a3,0x4
    246c:	e5068693          	addi	a3,a3,-432 # 62b8 <_GLOBAL__sub_I__ZSt3cin+0x310>
    2470:	070a                	slli	a4,a4,0x2
    2472:	9736                	add	a4,a4,a3
    2474:	4318                	lw	a4,0(a4)
    2476:	9736                	add	a4,a4,a3
    2478:	8702                	jr	a4
         if (f[0] == 'h')
    247a:	0014c783          	lbu	a5,1(s1)
         fl |= (sizeof(ptrdiff_t) == 8) ? STBSP__INTMAX : 0;
    247e:	020e6e13          	ori	t3,t3,32
         ++f;
    2482:	0485                	addi	s1,s1,1
      switch (f[0]) {
    2484:	fbf7871b          	addiw	a4,a5,-65
    2488:	0ff77713          	zext.b	a4,a4
    248c:	03700693          	li	a3,55
    2490:	0ee6ea63          	bltu	a3,a4,2584 <stbsp_vsprintfcb+0x2e6>
    2494:	00004697          	auipc	a3,0x4
    2498:	e7068693          	addi	a3,a3,-400 # 6304 <_GLOBAL__sub_I__ZSt3cin+0x35c>
    249c:	070a                	slli	a4,a4,0x2
    249e:	9736                	add	a4,a4,a3
    24a0:	4318                	lw	a4,0(a4)
    24a2:	9736                	add	a4,a4,a3
    24a4:	8702                	jr	a4
            fl |= STBSP__METRIC_NOSPACE;
    24a6:	400e6e13          	ori	t3,t3,1024
            continue;
    24aa:	0685                	addi	a3,a3,1
    24ac:	b785                	j	240c <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEFTJUST;
    24ae:	001e6e13          	ori	t3,t3,1
            continue;
    24b2:	0685                	addi	a3,a3,1
    24b4:	bfa1                	j	240c <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADINGPLUS;
    24b6:	002e6e13          	ori	t3,t3,2
            continue;
    24ba:	0685                	addi	a3,a3,1
    24bc:	bf81                	j	240c <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__TRIPLET_COMMA;
    24be:	040e6e13          	ori	t3,t3,64
            continue;
    24c2:	0685                	addi	a3,a3,1
    24c4:	b7a1                	j	240c <stbsp_vsprintfcb+0x16e>
            if (fl & STBSP__METRIC_SUFFIX) {
    24c6:	100e7793          	andi	a5,t3,256
    24ca:	8772                	mv	a4,t3
    24cc:	56078363          	beqz	a5,2a32 <stbsp_vsprintfcb+0x794>
               if (fl & STBSP__METRIC_1024) {
    24d0:	6785                	lui	a5,0x1
    24d2:	034e1513          	slli	a0,t3,0x34
    24d6:	80078793          	addi	a5,a5,-2048 # 800 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x334>
    24da:	5c055863          	bgez	a0,2aaa <stbsp_vsprintfcb+0x80c>
                  fl |= STBSP__METRIC_JEDEC;
    24de:	6785                	lui	a5,0x1
    24e0:	8f5d                	or	a4,a4,a5
    24e2:	00070e1b          	sext.w	t3,a4
    24e6:	0685                	addi	a3,a3,1
    24e8:	b715                	j	240c <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADING_0X;
    24ea:	008e6e13          	ori	t3,t3,8
            continue;
    24ee:	0685                	addi	a3,a3,1
    24f0:	bf31                	j	240c <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADINGSPACE;
    24f2:	004e6e13          	ori	t3,t3,4
            continue;
    24f6:	0685                	addi	a3,a3,1
    24f8:	bf11                	j	240c <stbsp_vsprintfcb+0x16e>
         while ((f[0] >= '0') && (f[0] <= '9')) {
    24fa:	fd07871b          	addiw	a4,a5,-48 # fd0 <main+0xbc>
    24fe:	0ff77713          	zext.b	a4,a4
    2502:	4625                	li	a2,9
      fw = 0;
    2504:	4b01                	li	s6,0
         while ((f[0] >= '0') && (f[0] <= '9')) {
    2506:	46a5                	li	a3,9
    2508:	f4e660e3          	bltu	a2,a4,2448 <stbsp_vsprintfcb+0x1aa>
            fw = fw * 10 + f[0] - '0';
    250c:	002b171b          	slliw	a4,s6,0x2
    2510:	0167073b          	addw	a4,a4,s6
    2514:	0017171b          	slliw	a4,a4,0x1
            f++;
    2518:	0485                	addi	s1,s1,1
            fw = fw * 10 + f[0] - '0';
    251a:	9f3d                	addw	a4,a4,a5
         while ((f[0] >= '0') && (f[0] <= '9')) {
    251c:	0004c783          	lbu	a5,0(s1)
            fw = fw * 10 + f[0] - '0';
    2520:	fd070b1b          	addiw	s6,a4,-48
         while ((f[0] >= '0') && (f[0] <= '9')) {
    2524:	fd07871b          	addiw	a4,a5,-48
    2528:	0ff77713          	zext.b	a4,a4
    252c:	fee6f0e3          	bgeu	a3,a4,250c <stbsp_vsprintfcb+0x26e>
      if (f[0] == '.') {
    2530:	02e00713          	li	a4,46
      pr = -1;
    2534:	58fd                	li	a7,-1
      if (f[0] == '.') {
    2536:	f0e79ee3          	bne	a5,a4,2452 <stbsp_vsprintfcb+0x1b4>
         if (f[0] == '*') {
    253a:	0014c783          	lbu	a5,1(s1)
    253e:	02a00713          	li	a4,42
    2542:	52e79763          	bne	a5,a4,2a70 <stbsp_vsprintfcb+0x7d2>
            while ((f[0] >= '0') && (f[0] <= '9')) {
    2546:	0024c783          	lbu	a5,2(s1)
      switch (f[0]) {
    254a:	04900713          	li	a4,73
            pr = va_arg(va, stbsp__uint32);
    254e:	000ba883          	lw	a7,0(s7)
            ++f;
    2552:	0489                	addi	s1,s1,2
            pr = va_arg(va, stbsp__uint32);
    2554:	0ba1                	addi	s7,s7,8
      switch (f[0]) {
    2556:	f0e792e3          	bne	a5,a4,245a <stbsp_vsprintfcb+0x1bc>
         if ((f[1] == '6') && (f[2] == '4')) {
    255a:	0014c783          	lbu	a5,1(s1)
    255e:	03600713          	li	a4,54
    2562:	00e79463          	bne	a5,a4,256a <stbsp_vsprintfcb+0x2cc>
    2566:	1e60106f          	j	374c <stbsp_vsprintfcb+0x14ae>
         } else if ((f[1] == '3') && (f[2] == '2')) {
    256a:	03300713          	li	a4,51
    256e:	6ae796e3          	bne	a5,a4,341a <stbsp_vsprintfcb+0x117c>
    2572:	0024c683          	lbu	a3,2(s1)
    2576:	03200713          	li	a4,50
    257a:	00e69463          	bne	a3,a4,2582 <stbsp_vsprintfcb+0x2e4>
    257e:	0ae0106f          	j	362c <stbsp_vsprintfcb+0x138e>
            ++f;
    2582:	0485                	addi	s1,s1,1
         *s = f[0];
    2584:	26f10fa3          	sb	a5,639(sp)
         l = 1;
    2588:	4785                	li	a5,1
    258a:	d0be                	sw	a5,96(sp)
         lead[0] = 0;
    258c:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    2590:	06010823          	sb	zero,112(sp)
         dp = 0;
    2594:	d282                	sw	zero,100(sp)
    2596:	e0de                	sd	s7,64(sp)
    2598:	4701                	li	a4,0
    259a:	4301                	li	t1,0
    259c:	4f81                	li	t6,0
    259e:	4685                	li	a3,1
    25a0:	4a01                	li	s4,0
         cs = 0;
    25a2:	4281                	li	t0,0
         s = num + STBSP__NUMSZ - 1;
    25a4:	27f10a93          	addi	s5,sp,639
         fw = fl = 0;
    25a8:	4e01                	li	t3,0
      tz = 0;
    25aa:	4881                	li	a7,0
            if (fl & STBSP__LEADINGZERO) // if leading zeros, everything is in pr
    25ac:	010e7793          	andi	a5,t3,16
    25b0:	40078ee3          	beqz	a5,31cc <stbsp_vsprintfcb+0xf2e>
               pr = (fw > pr) ? fw : pr;
    25b4:	87ba                	mv	a5,a4
    25b6:	00675363          	bge	a4,t1,25bc <stbsp_vsprintfcb+0x31e>
    25ba:	879a                	mv	a5,t1
    25bc:	0007871b          	sext.w	a4,a5
               fw = 0;
    25c0:	4301                	li	t1,0
         if (fw + pr) {
    25c2:	62070563          	beqz	a4,2bec <stbsp_vsprintfcb+0x94e>
            sn = lead + 1;
    25c6:	06910793          	addi	a5,sp,105
    25ca:	fcbe                	sd	a5,120(sp)
            while (lead[0]) {
    25cc:	0a0a0863          	beqz	s4,267c <stbsp_vsprintfcb+0x3de>
               stbsp__cb_buf_clamp(i, lead[0]);
    25d0:	f026                	sd	s1,32(sp)
    25d2:	f436                	sd	a3,40(sp)
    25d4:	854a                	mv	a0,s2
    25d6:	86d2                	mv	a3,s4
    25d8:	84ce                	mv	s1,s3
               stbsp__chk_cb_buf(1);
    25da:	1fe00b93          	li	s7,510
               stbsp__cb_buf_clamp(i, lead[0]);
    25de:	89be                	mv	s3,a5
    25e0:	20000b13          	li	s6,512
    25e4:	87a2                	mv	a5,s0
    25e6:	e846                	sd	a7,16(sp)
    25e8:	846a                	mv	s0,s10
    25ea:	ec7e                	sd	t6,24(sp)
    25ec:	8d6e                	mv	s10,s11
    25ee:	f872                	sd	t3,48(sp)
    25f0:	8de6                	mv	s11,s9
    25f2:	8a3a                	mv	s4,a4
    25f4:	e496                	sd	t0,72(sp)
    25f6:	891a                	mv	s2,t1
    25f8:	8c9e                	mv	s9,t2
    25fa:	0006871b          	sext.w	a4,a3
    25fe:	2e0482e3          	beqz	s1,30e2 <stbsp_vsprintfcb+0xe44>
    2602:	40a7863b          	subw	a2,a5,a0
    2606:	40cb083b          	subw	a6,s6,a2
    260a:	85c2                	mv	a1,a6
    260c:	01075363          	bge	a4,a6,2612 <stbsp_vsprintfcb+0x374>
    2610:	85ba                	mv	a1,a4
               lead[0] -= (char)i;
    2612:	9e8d                	subw	a3,a3,a1
               stbsp__cb_buf_clamp(i, lead[0]);
    2614:	0005871b          	sext.w	a4,a1
               lead[0] -= (char)i;
    2618:	06d10423          	sb	a3,104(sp)
               while (i) {
    261c:	c70d                	beqz	a4,2646 <stbsp_vsprintfcb+0x3a8>
    261e:	7866                	ld	a6,120(sp)
    2620:	02071593          	slli	a1,a4,0x20
    2624:	9181                	srli	a1,a1,0x20
    2626:	00b78633          	add	a2,a5,a1
    262a:	8742                	mv	a4,a6
                  *bf++ = *sn++;
    262c:	00074683          	lbu	a3,0(a4)
    2630:	0785                	addi	a5,a5,1
               while (i) {
    2632:	0705                	addi	a4,a4,1
                  *bf++ = *sn++;
    2634:	fed78fa3          	sb	a3,-1(a5)
               while (i) {
    2638:	fec79ae3          	bne	a5,a2,262c <stbsp_vsprintfcb+0x38e>
    263c:	982e                	add	a6,a6,a1
    263e:	fcc2                	sd	a6,120(sp)
               stbsp__chk_cb_buf(1);
    2640:	c899                	beqz	s1,2656 <stbsp_vsprintfcb+0x3b8>
    2642:	40a7863b          	subw	a2,a5,a0
    2646:	00cbd863          	bge	s7,a2,2656 <stbsp_vsprintfcb+0x3b8>
    264a:	65a2                	ld	a1,8(sp)
    264c:	9c31                	addw	s0,s0,a2
    264e:	9482                	jalr	s1
    2650:	34050ee3          	beqz	a0,31ac <stbsp_vsprintfcb+0xf0e>
    2654:	87aa                	mv	a5,a0
            while (lead[0]) {
    2656:	06814683          	lbu	a3,104(sp)
    265a:	f2c5                	bnez	a3,25fa <stbsp_vsprintfcb+0x35c>
    265c:	83e6                	mv	t2,s9
    265e:	68c2                	ld	a7,16(sp)
    2660:	8cee                	mv	s9,s11
    2662:	6fe2                	ld	t6,24(sp)
    2664:	8dea                	mv	s11,s10
    2666:	76a2                	ld	a3,40(sp)
    2668:	8d22                	mv	s10,s0
    266a:	7e42                	ld	t3,48(sp)
    266c:	843e                	mv	s0,a5
    266e:	62a6                	ld	t0,72(sp)
    2670:	87ce                	mv	a5,s3
    2672:	89a6                	mv	s3,s1
    2674:	7482                	ld	s1,32(sp)
    2676:	834a                	mv	t1,s2
    2678:	8752                	mv	a4,s4
    267a:	892a                	mv	s2,a0
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    267c:	040e7b13          	andi	s6,t3,64
            c = cs >> 24;
    2680:	0182d61b          	srliw	a2,t0,0x18
    2684:	0182db9b          	srliw	s7,t0,0x18
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    2688:	4a01                	li	s4,0
    268a:	000b0e63          	beqz	s6,26a6 <stbsp_vsprintfcb+0x408>
            cs &= 0xffffff;
    268e:	02829a13          	slli	s4,t0,0x28
    2692:	028a5a13          	srli	s4,s4,0x28
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    2696:	00ea0a3b          	addw	s4,s4,a4
    269a:	0016059b          	addiw	a1,a2,1
    269e:	02ba7a3b          	remuw	s4,s4,a1
    26a2:	41460a3b          	subw	s4,a2,s4
            while (pr > 0) {
    26a6:	0ce05763          	blez	a4,2774 <stbsp_vsprintfcb+0x4d6>
                     *(stbsp__uint32 *)bf = 0x30303030;
    26aa:	30303837          	lui	a6,0x30303
    26ae:	03080813          	addi	a6,a6,48 # 30303030 <_ZSt4cerr+0x302fa270>
    26b2:	f026                	sd	s1,32(sp)
    26b4:	854a                	mv	a0,s2
    26b6:	84da                	mv	s1,s6
    26b8:	895e                	mv	s2,s7
    26ba:	e4d6                	sd	s5,72(sp)
    26bc:	8b4e                	mv	s6,s3
    26be:	8aea                	mv	s5,s10
               stbsp__chk_cb_buf(1);
    26c0:	1fe00293          	li	t0,510
    26c4:	8d6e                	mv	s10,s11
                     *bf++ = stbsp__comma;
    26c6:	00005f17          	auipc	t5,0x5
    26ca:	7a2f0f13          	addi	t5,t5,1954 # 7e68 <stbsp__digitpair>
    26ce:	8de6                	mv	s11,s9
                     *bf++ = '0';
    26d0:	03000e93          	li	t4,48
    26d4:	e846                	sd	a7,16(sp)
    26d6:	ec7e                	sd	t6,24(sp)
    26d8:	f436                	sd	a3,40(sp)
    26da:	f872                	sd	t3,48(sp)
    26dc:	e89a                	sd	t1,80(sp)
    26de:	89ba                	mv	s3,a4
    26e0:	ecbe                	sd	a5,88(sp)
    26e2:	8bc2                	mv	s7,a6
    26e4:	8c9e                	mv	s9,t2
               stbsp__cb_buf_clamp(i, pr);
    26e6:	240b0ee3          	beqz	s6,3142 <stbsp_vsprintfcb+0xea4>
    26ea:	40a407b3          	sub	a5,s0,a0
    26ee:	40fc063b          	subw	a2,s8,a5
    26f2:	87b2                	mv	a5,a2
    26f4:	00c9d363          	bge	s3,a2,26fa <stbsp_vsprintfcb+0x45c>
    26f8:	87ce                	mv	a5,s3
    26fa:	0007859b          	sext.w	a1,a5
               pr -= i;
    26fe:	40f989bb          	subw	s3,s3,a5
               if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    2702:	32048c63          	beqz	s1,2a3a <stbsp_vsprintfcb+0x79c>
               while (i) {
    2706:	34058a63          	beqz	a1,2a5a <stbsp_vsprintfcb+0x7bc>
    270a:	1582                	slli	a1,a1,0x20
                     *bf++ = stbsp__comma;
    270c:	0cdf4603          	lbu	a2,205(t5)
    2710:	9181                	srli	a1,a1,0x20
    2712:	95a2                	add	a1,a1,s0
    2714:	0405                	addi	s0,s0,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (cs++ == c)) {
    2716:	c481                	beqz	s1,271e <stbsp_vsprintfcb+0x480>
    2718:	1d4901e3          	beq	s2,s4,30da <stbsp_vsprintfcb+0xe3c>
    271c:	2a05                	addiw	s4,s4,1
                     *bf++ = '0';
    271e:	03000793          	li	a5,48
    2722:	fef40fa3          	sb	a5,-1(s0)
               while (i) {
    2726:	fe8597e3          	bne	a1,s0,2714 <stbsp_vsprintfcb+0x476>
               stbsp__chk_cb_buf(1);
    272a:	320b0b63          	beqz	s6,2a60 <stbsp_vsprintfcb+0x7c2>
    272e:	40a5863b          	subw	a2,a1,a0
    2732:	32c2d763          	bge	t0,a2,2a60 <stbsp_vsprintfcb+0x7c2>
    2736:	65a2                	ld	a1,8(sp)
    2738:	01560abb          	addw	s5,a2,s5
    273c:	9b02                	jalr	s6
    273e:	3a050ce3          	beqz	a0,32f6 <stbsp_vsprintfcb+0x1058>
    2742:	842a                	mv	s0,a0
    2744:	1fe00293          	li	t0,510
    2748:	00005f17          	auipc	t5,0x5
    274c:	720f0f13          	addi	t5,t5,1824 # 7e68 <stbsp__digitpair>
    2750:	03000e93          	li	t4,48
            while (pr > 0) {
    2754:	f93049e3          	bgtz	s3,26e6 <stbsp_vsprintfcb+0x448>
         while (lead[0]) {
    2758:	83e6                	mv	t2,s9
    275a:	68c2                	ld	a7,16(sp)
    275c:	8cee                	mv	s9,s11
    275e:	6fe2                	ld	t6,24(sp)
    2760:	8dea                	mv	s11,s10
    2762:	7482                	ld	s1,32(sp)
    2764:	8d56                	mv	s10,s5
    2766:	76a2                	ld	a3,40(sp)
    2768:	7e42                	ld	t3,48(sp)
    276a:	6346                	ld	t1,80(sp)
    276c:	67e6                	ld	a5,88(sp)
    276e:	6aa6                	ld	s5,72(sp)
    2770:	892a                	mv	s2,a0
    2772:	89da                	mv	s3,s6
    2774:	06814a03          	lbu	s4,104(sp)
         sn = lead + 1;
    2778:	fcbe                	sd	a5,120(sp)
         while (lead[0]) {
    277a:	0a0a0263          	beqz	s4,281e <stbsp_vsprintfcb+0x580>
            stbsp__cb_buf_clamp(i, lead[0]);
    277e:	ec26                	sd	s1,24(sp)
    2780:	f036                	sd	a3,32(sp)
    2782:	854a                	mv	a0,s2
    2784:	86d2                	mv	a3,s4
    2786:	84ce                	mv	s1,s3
    2788:	87a2                	mv	a5,s0
            stbsp__chk_cb_buf(1);
    278a:	1fe00b93          	li	s7,510
            stbsp__cb_buf_clamp(i, lead[0]);
    278e:	846a                	mv	s0,s10
    2790:	20000b13          	li	s6,512
    2794:	8d6e                	mv	s10,s11
    2796:	e846                	sd	a7,16(sp)
    2798:	8de6                	mv	s11,s9
    279a:	8a7e                	mv	s4,t6
    279c:	8972                	mv	s2,t3
    279e:	899a                	mv	s3,t1
    27a0:	8c9e                	mv	s9,t2
    27a2:	0006871b          	sext.w	a4,a3
    27a6:	140482e3          	beqz	s1,30ea <stbsp_vsprintfcb+0xe4c>
    27aa:	40a7863b          	subw	a2,a5,a0
    27ae:	40cb083b          	subw	a6,s6,a2
    27b2:	85c2                	mv	a1,a6
    27b4:	01075363          	bge	a4,a6,27ba <stbsp_vsprintfcb+0x51c>
    27b8:	85ba                	mv	a1,a4
            lead[0] -= (char)i;
    27ba:	9e8d                	subw	a3,a3,a1
            stbsp__cb_buf_clamp(i, lead[0]);
    27bc:	0005871b          	sext.w	a4,a1
            lead[0] -= (char)i;
    27c0:	06d10423          	sb	a3,104(sp)
            while (i) {
    27c4:	c70d                	beqz	a4,27ee <stbsp_vsprintfcb+0x550>
    27c6:	7866                	ld	a6,120(sp)
    27c8:	02071593          	slli	a1,a4,0x20
    27cc:	9181                	srli	a1,a1,0x20
    27ce:	00b78633          	add	a2,a5,a1
    27d2:	8742                	mv	a4,a6
               *bf++ = *sn++;
    27d4:	00074683          	lbu	a3,0(a4)
    27d8:	0785                	addi	a5,a5,1
            while (i) {
    27da:	0705                	addi	a4,a4,1
               *bf++ = *sn++;
    27dc:	fed78fa3          	sb	a3,-1(a5)
            while (i) {
    27e0:	fec79ae3          	bne	a5,a2,27d4 <stbsp_vsprintfcb+0x536>
    27e4:	982e                	add	a6,a6,a1
    27e6:	fcc2                	sd	a6,120(sp)
            stbsp__chk_cb_buf(1);
    27e8:	c899                	beqz	s1,27fe <stbsp_vsprintfcb+0x560>
    27ea:	40a7863b          	subw	a2,a5,a0
    27ee:	00cbd863          	bge	s7,a2,27fe <stbsp_vsprintfcb+0x560>
    27f2:	65a2                	ld	a1,8(sp)
    27f4:	9c31                	addw	s0,s0,a2
    27f6:	9482                	jalr	s1
    27f8:	1a050ae3          	beqz	a0,31ac <stbsp_vsprintfcb+0xf0e>
    27fc:	87aa                	mv	a5,a0
         while (lead[0]) {
    27fe:	06814683          	lbu	a3,104(sp)
    2802:	f2c5                	bnez	a3,27a2 <stbsp_vsprintfcb+0x504>
    2804:	834e                	mv	t1,s3
    2806:	68c2                	ld	a7,16(sp)
    2808:	89a6                	mv	s3,s1
    280a:	7682                	ld	a3,32(sp)
    280c:	64e2                	ld	s1,24(sp)
    280e:	8e4a                	mv	t3,s2
    2810:	83e6                	mv	t2,s9
    2812:	8fd2                	mv	t6,s4
    2814:	8cee                	mv	s9,s11
    2816:	892a                	mv	s2,a0
    2818:	8dea                	mv	s11,s10
    281a:	8d22                	mv	s10,s0
    281c:	843e                	mv	s0,a5
         while (n) {
    281e:	c6f9                	beqz	a3,28ec <stbsp_vsprintfcb+0x64e>
            STBSP__UNALIGNED(while (i >= 4) {
    2820:	ec26                	sd	s1,24(sp)
    2822:	854a                	mv	a0,s2
    2824:	84d6                	mv	s1,s5
    2826:	896a                	mv	s2,s10
    2828:	87a2                	mv	a5,s0
    282a:	8d6e                	mv	s10,s11
            stbsp__chk_cb_buf(1);
    282c:	1fe00b93          	li	s7,510
            STBSP__UNALIGNED(while (i >= 4) {
    2830:	8de6                	mv	s11,s9
            stbsp__cb_buf_clamp(i, n);
    2832:	20000b13          	li	s6,512
            STBSP__UNALIGNED(while (i >= 4) {
    2836:	4a0d                	li	s4,3
    2838:	e87e                	sd	t6,16(sp)
    283a:	f072                	sd	t3,32(sp)
    283c:	8ac6                	mv	s5,a7
    283e:	f41a                	sd	t1,40(sp)
    2840:	8436                	mv	s0,a3
    2842:	8c9e                	mv	s9,t2
            stbsp__cb_buf_clamp(i, n);
    2844:	0004071b          	sext.w	a4,s0
    2848:	100982e3          	beqz	s3,314c <stbsp_vsprintfcb+0xeae>
    284c:	40a78633          	sub	a2,a5,a0
    2850:	40cb05bb          	subw	a1,s6,a2
    2854:	862e                	mv	a2,a1
    2856:	00b75363          	bge	a4,a1,285c <stbsp_vsprintfcb+0x5be>
    285a:	863a                	mv	a2,a4
    285c:	0006071b          	sext.w	a4,a2
            n -= i;
    2860:	9c11                	subw	s0,s0,a2
            STBSP__UNALIGNED(while (i >= 4) {
    2862:	14ea50e3          	bge	s4,a4,31a2 <stbsp_vsprintfcb+0xf04>
    2866:	ffc70f1b          	addiw	t5,a4,-4
    286a:	002f5e9b          	srliw	t4,t5,0x2
    286e:	001e8e1b          	addiw	t3,t4,1
    2872:	0e0a                	slli	t3,t3,0x2
    2874:	01c785b3          	add	a1,a5,t3
    2878:	8626                	mv	a2,s1
    287a:	4218                	lw	a4,0(a2)
    287c:	0791                	addi	a5,a5,4
    287e:	0611                	addi	a2,a2,4
    2880:	2701                	sext.w	a4,a4
    2882:	fee7ae23          	sw	a4,-4(a5)
    2886:	feb79ae3          	bne	a5,a1,287a <stbsp_vsprintfcb+0x5dc>
    288a:	002e9e9b          	slliw	t4,t4,0x2
    288e:	41df073b          	subw	a4,t5,t4
            while (i) {
    2892:	94f2                	add	s1,s1,t3
    2894:	c31d                	beqz	a4,28ba <stbsp_vsprintfcb+0x61c>
    2896:	8626                	mv	a2,s1
    2898:	87ae                	mv	a5,a1
    289a:	00e58f3b          	addw	t5,a1,a4
               *bf++ = *s++;
    289e:	00064e83          	lbu	t4,0(a2)
    28a2:	0785                	addi	a5,a5,1
            while (i) {
    28a4:	00078e1b          	sext.w	t3,a5
               *bf++ = *s++;
    28a8:	ffd78fa3          	sb	t4,-1(a5)
    28ac:	0605                	addi	a2,a2,1
            while (i) {
    28ae:	ffcf18e3          	bne	t5,t3,289e <stbsp_vsprintfcb+0x600>
    28b2:	1702                	slli	a4,a4,0x20
    28b4:	9301                	srli	a4,a4,0x20
    28b6:	95ba                	add	a1,a1,a4
    28b8:	94ba                	add	s1,s1,a4
            stbsp__chk_cb_buf(1);
    28ba:	1a098763          	beqz	s3,2a68 <stbsp_vsprintfcb+0x7ca>
    28be:	40a5863b          	subw	a2,a1,a0
    28c2:	1acbd363          	bge	s7,a2,2a68 <stbsp_vsprintfcb+0x7ca>
    28c6:	65a2                	ld	a1,8(sp)
    28c8:	0126093b          	addw	s2,a2,s2
    28cc:	9982                	jalr	s3
    28ce:	20050be3          	beqz	a0,32e4 <stbsp_vsprintfcb+0x1046>
    28d2:	87aa                	mv	a5,a0
         while (n) {
    28d4:	f825                	bnez	s0,2844 <stbsp_vsprintfcb+0x5a6>
    28d6:	6fc2                	ld	t6,16(sp)
    28d8:	64e2                	ld	s1,24(sp)
    28da:	7e02                	ld	t3,32(sp)
    28dc:	7322                	ld	t1,40(sp)
    28de:	83e6                	mv	t2,s9
    28e0:	88d6                	mv	a7,s5
    28e2:	8cee                	mv	s9,s11
    28e4:	843e                	mv	s0,a5
    28e6:	8dea                	mv	s11,s10
    28e8:	8d4a                	mv	s10,s2
    28ea:	892a                	mv	s2,a0
         while (tz) {
    28ec:	08088863          	beqz	a7,297c <stbsp_vsprintfcb+0x6de>
               *(stbsp__uint32 *)bf = 0x30303030;
    28f0:	30303b37          	lui	s6,0x30303
               *bf++ = '0';
    28f4:	03000a13          	li	s4,48
            while (i >= 4) {
    28f8:	4a8d                	li	s5,3
            stbsp__chk_cb_buf(1);
    28fa:	1fe00693          	li	a3,510
               *(stbsp__uint32 *)bf = 0x30303030;
    28fe:	030b0b13          	addi	s6,s6,48 # 30303030 <_ZSt4cerr+0x302fa270>
            stbsp__cb_buf_clamp(i, tz);
    2902:	20000b93          	li	s7,512
    2906:	040989e3          	beqz	s3,3158 <stbsp_vsprintfcb+0xeba>
    290a:	41240633          	sub	a2,s0,s2
    290e:	40cb87bb          	subw	a5,s7,a2
    2912:	873e                	mv	a4,a5
    2914:	00f8d363          	bge	a7,a5,291a <stbsp_vsprintfcb+0x67c>
    2918:	8746                	mv	a4,a7
    291a:	0007079b          	sext.w	a5,a4
            tz -= i;
    291e:	40e888bb          	subw	a7,a7,a4
            while (i) {
    2922:	08078ee3          	beqz	a5,31be <stbsp_vsprintfcb+0xf20>
               if ((((stbsp__uintptr)bf) & 3) == 0)
    2926:	00347713          	andi	a4,s0,3
    292a:	e719                	bnez	a4,2938 <stbsp_vsprintfcb+0x69a>
    292c:	0390006f          	j	3164 <stbsp_vsprintfcb+0xec6>
    2930:	00347713          	andi	a4,s0,3
    2934:	7a070f63          	beqz	a4,30f2 <stbsp_vsprintfcb+0xe54>
               *bf++ = '0';
    2938:	01440023          	sb	s4,0(s0)
               --i;
    293c:	37fd                	addiw	a5,a5,-1
               *bf++ = '0';
    293e:	0405                	addi	s0,s0,1
            while (i) {
    2940:	fbe5                	bnez	a5,2930 <stbsp_vsprintfcb+0x692>
            stbsp__chk_cb_buf(1);
    2942:	02098b63          	beqz	s3,2978 <stbsp_vsprintfcb+0x6da>
    2946:	4124063b          	subw	a2,s0,s2
    294a:	02c6d763          	bge	a3,a2,2978 <stbsp_vsprintfcb+0x6da>
    294e:	65a2                	ld	a1,8(sp)
    2950:	854a                	mv	a0,s2
    2952:	f81e                	sd	t2,48(sp)
    2954:	f41a                	sd	t1,40(sp)
    2956:	f072                	sd	t3,32(sp)
    2958:	ec7e                	sd	t6,24(sp)
    295a:	e846                	sd	a7,16(sp)
    295c:	00cd0d3b          	addw	s10,s10,a2
    2960:	9982                	jalr	s3
    2962:	892a                	mv	s2,a0
    2964:	1a0502e3          	beqz	a0,3308 <stbsp_vsprintfcb+0x106a>
    2968:	73c2                	ld	t2,48(sp)
    296a:	7322                	ld	t1,40(sp)
    296c:	7e02                	ld	t3,32(sp)
    296e:	6fe2                	ld	t6,24(sp)
    2970:	68c2                	ld	a7,16(sp)
    2972:	842a                	mv	s0,a0
    2974:	1fe00693          	li	a3,510
         while (tz) {
    2978:	f80897e3          	bnez	a7,2906 <stbsp_vsprintfcb+0x668>
         sn = tail + 1;
    297c:	07110793          	addi	a5,sp,113
    2980:	fcbe                	sd	a5,120(sp)
         while (tail[0]) {
    2982:	080f8763          	beqz	t6,2a10 <stbsp_vsprintfcb+0x772>
            stbsp__cb_buf_clamp(i, tail[0]);
    2986:	854a                	mv	a0,s2
    2988:	8b6a                	mv	s6,s10
            stbsp__chk_cb_buf(1);
    298a:	1fe00a93          	li	s5,510
            stbsp__cb_buf_clamp(i, tail[0]);
    298e:	8d4e                	mv	s10,s3
    2990:	20000a13          	li	s4,512
    2994:	8bf2                	mv	s7,t3
    2996:	891a                	mv	s2,t1
    2998:	899e                	mv	s3,t2
    299a:	000f879b          	sext.w	a5,t6
    299e:	7c0d0863          	beqz	s10,316e <stbsp_vsprintfcb+0xed0>
    29a2:	40a4063b          	subw	a2,s0,a0
    29a6:	40ca06bb          	subw	a3,s4,a2
    29aa:	8736                	mv	a4,a3
    29ac:	00d7d363          	bge	a5,a3,29b2 <stbsp_vsprintfcb+0x714>
    29b0:	873e                	mv	a4,a5
            tail[0] -= (char)i;
    29b2:	40ef8fbb          	subw	t6,t6,a4
            stbsp__cb_buf_clamp(i, tail[0]);
    29b6:	0007079b          	sext.w	a5,a4
            tail[0] -= (char)i;
    29ba:	07f10823          	sb	t6,112(sp)
            while (i) {
    29be:	c795                	beqz	a5,29ea <stbsp_vsprintfcb+0x74c>
    29c0:	75e6                	ld	a1,120(sp)
    29c2:	02079613          	slli	a2,a5,0x20
    29c6:	9201                	srli	a2,a2,0x20
    29c8:	00c406b3          	add	a3,s0,a2
    29cc:	87ae                	mv	a5,a1
               *bf++ = *sn++;
    29ce:	0007c703          	lbu	a4,0(a5)
    29d2:	0405                	addi	s0,s0,1
            while (i) {
    29d4:	0785                	addi	a5,a5,1
               *bf++ = *sn++;
    29d6:	fee40fa3          	sb	a4,-1(s0)
            while (i) {
    29da:	fed41ae3          	bne	s0,a3,29ce <stbsp_vsprintfcb+0x730>
    29de:	95b2                	add	a1,a1,a2
    29e0:	fcae                	sd	a1,120(sp)
            stbsp__chk_cb_buf(1);
    29e2:	000d0d63          	beqz	s10,29fc <stbsp_vsprintfcb+0x75e>
    29e6:	40a4063b          	subw	a2,s0,a0
    29ea:	00cad963          	bge	s5,a2,29fc <stbsp_vsprintfcb+0x75e>
    29ee:	65a2                	ld	a1,8(sp)
    29f0:	00cb0b3b          	addw	s6,s6,a2
    29f4:	9d02                	jalr	s10
    29f6:	200509e3          	beqz	a0,3408 <stbsp_vsprintfcb+0x116a>
    29fa:	842a                	mv	s0,a0
         while (tail[0]) {
    29fc:	07014f83          	lbu	t6,112(sp)
    2a00:	f80f9de3          	bnez	t6,299a <stbsp_vsprintfcb+0x6fc>
    2a04:	834a                	mv	t1,s2
    2a06:	83ce                	mv	t2,s3
    2a08:	8e5e                	mv	t3,s7
    2a0a:	89ea                	mv	s3,s10
    2a0c:	892a                	mv	s2,a0
    2a0e:	8d5a                	mv	s10,s6
         if (fl & STBSP__LEFTJUST)
    2a10:	001e7e13          	andi	t3,t3,1
    2a14:	000e0663          	beqz	t3,2a20 <stbsp_vsprintfcb+0x782>
            if (fw > 0) {
    2a18:	00605463          	blez	t1,2a20 <stbsp_vsprintfcb+0x782>
    2a1c:	0300106f          	j	3a4c <stbsp_vsprintfcb+0x17ae>
   for (;;) {
    2a20:	6b86                	ld	s7,64(sp)
    2a22:	2c013a03          	ld	s4,704(sp)
    2a26:	2b813a83          	ld	s5,696(sp)
    2a2a:	2b013b03          	ld	s6,688(sp)
      ++f;
    2a2e:	0485                	addi	s1,s1,1
   for (;;) {
    2a30:	b0f1                	j	22fc <stbsp_vsprintfcb+0x5e>
               fl |= STBSP__METRIC_SUFFIX;
    2a32:	100e6e13          	ori	t3,t3,256
            continue;
    2a36:	0685                	addi	a3,a3,1
    2a38:	bad1                	j	240c <stbsp_vsprintfcb+0x16e>
                  while (i) {
    2a3a:	0e0580e3          	beqz	a1,331a <stbsp_vsprintfcb+0x107c>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    2a3e:	00347793          	andi	a5,s0,3
    2a42:	e799                	bnez	a5,2a50 <stbsp_vsprintfcb+0x7b2>
    2a44:	0dd0006f          	j	3320 <stbsp_vsprintfcb+0x1082>
    2a48:	00347793          	andi	a5,s0,3
    2a4c:	72078463          	beqz	a5,3174 <stbsp_vsprintfcb+0xed6>
                     *bf++ = '0';
    2a50:	01d40023          	sb	t4,0(s0)
                     --i;
    2a54:	35fd                	addiw	a1,a1,-1
                     *bf++ = '0';
    2a56:	0405                	addi	s0,s0,1
                  while (i) {
    2a58:	f9e5                	bnez	a1,2a48 <stbsp_vsprintfcb+0x7aa>
               while (i) {
    2a5a:	85a2                	mv	a1,s0
               stbsp__chk_cb_buf(1);
    2a5c:	cc0b19e3          	bnez	s6,272e <stbsp_vsprintfcb+0x490>
    2a60:	842e                	mv	s0,a1
            while (pr > 0) {
    2a62:	c93042e3          	bgtz	s3,26e6 <stbsp_vsprintfcb+0x448>
    2a66:	b9cd                	j	2758 <stbsp_vsprintfcb+0x4ba>
            while (i) {
    2a68:	87ae                	mv	a5,a1
         while (n) {
    2a6a:	dc041de3          	bnez	s0,2844 <stbsp_vsprintfcb+0x5a6>
    2a6e:	b5a5                	j	28d6 <stbsp_vsprintfcb+0x638>
            while ((f[0] >= '0') && (f[0] <= '9')) {
    2a70:	fd07871b          	addiw	a4,a5,-48
    2a74:	0ff77713          	zext.b	a4,a4
    2a78:	4625                	li	a2,9
         ++f;
    2a7a:	0485                	addi	s1,s1,1
            pr = 0;
    2a7c:	4881                	li	a7,0
            while ((f[0] >= '0') && (f[0] <= '9')) {
    2a7e:	46a5                	li	a3,9
    2a80:	9ce669e3          	bltu	a2,a4,2452 <stbsp_vsprintfcb+0x1b4>
               pr = pr * 10 + f[0] - '0';
    2a84:	0028971b          	slliw	a4,a7,0x2
    2a88:	0117073b          	addw	a4,a4,a7
    2a8c:	0017171b          	slliw	a4,a4,0x1
               f++;
    2a90:	0485                	addi	s1,s1,1
               pr = pr * 10 + f[0] - '0';
    2a92:	9f3d                	addw	a4,a4,a5
            while ((f[0] >= '0') && (f[0] <= '9')) {
    2a94:	0004c783          	lbu	a5,0(s1)
               pr = pr * 10 + f[0] - '0';
    2a98:	fd07089b          	addiw	a7,a4,-48
            while ((f[0] >= '0') && (f[0] <= '9')) {
    2a9c:	fd07871b          	addiw	a4,a5,-48
    2aa0:	0ff77713          	zext.b	a4,a4
    2aa4:	fee6f0e3          	bgeu	a3,a4,2a84 <stbsp_vsprintfcb+0x7e6>
    2aa8:	b26d                	j	2452 <stbsp_vsprintfcb+0x1b4>
                  fl |= STBSP__METRIC_1024;
    2aaa:	8f5d                	or	a4,a4,a5
    2aac:	00070e1b          	sext.w	t3,a4
    2ab0:	0685                	addi	a3,a3,1
    2ab2:	baa9                	j	240c <stbsp_vsprintfcb+0x16e>
      *bf = 0;
    2ab4:	00040023          	sb	zero,0(s0)
    2ab8:	b209                	j	23ba <stbsp_vsprintfcb+0x11c>
         if (f[0] == 'l') {
    2aba:	0014c783          	lbu	a5,1(s1)
    2abe:	06c00713          	li	a4,108
         fl |= ((sizeof(long) == 8) ? STBSP__INTMAX : 0);
    2ac2:	020e6e13          	ori	t3,t3,32
         if (f[0] == 'l') {
    2ac6:	00e78c63          	beq	a5,a4,2ade <stbsp_vsprintfcb+0x840>
            ++f;
    2aca:	0485                	addi	s1,s1,1
    2acc:	ba65                	j	2484 <stbsp_vsprintfcb+0x1e6>
         if (f[0] == 'h')
    2ace:	0014c783          	lbu	a5,1(s1)
    2ad2:	06800713          	li	a4,104
         fl |= STBSP__HALFWIDTH;
    2ad6:	200e6e13          	ori	t3,t3,512
         if (f[0] == 'h')
    2ada:	fee798e3          	bne	a5,a4,2aca <stbsp_vsprintfcb+0x82c>
         if ((f[1] == '6') && (f[2] == '4')) {
    2ade:	0024c783          	lbu	a5,2(s1)
            ++f;
    2ae2:	0489                	addi	s1,s1,2
    2ae4:	b245                	j	2484 <stbsp_vsprintfcb+0x1e6>
         s = va_arg(va, char *);
    2ae6:	008b8713          	addi	a4,s7,8
    2aea:	e0ba                	sd	a4,64(sp)
         if (fl & STBSP__INTMAX) {
    2aec:	020e7693          	andi	a3,t3,32
    2af0:	8772                	mv	a4,t3
    2af2:	24069ee3          	bnez	a3,354e <stbsp_vsprintfcb+0x12b0>
            stbsp__int32 i = va_arg(va, stbsp__int32);
    2af6:	000ba683          	lw	a3,0(s7)
            if ((f[0] != 'u') && (i < 0)) {
    2afa:	07500613          	li	a2,117
            n64 = (stbsp__uint32)i;
    2afe:	02069f13          	slli	t5,a3,0x20
    2b02:	020f5f13          	srli	t5,t5,0x20
            if ((f[0] != 'u') && (i < 0)) {
    2b06:	00c78a63          	beq	a5,a2,2b1a <stbsp_vsprintfcb+0x87c>
    2b0a:	0006d863          	bgez	a3,2b1a <stbsp_vsprintfcb+0x87c>
               fl |= STBSP__NEGATIVE;
    2b0e:	08076713          	ori	a4,a4,128
               n64 = (stbsp__uint32)-i;
    2b12:	40d00f3b          	negw	t5,a3
               fl |= STBSP__NEGATIVE;
    2b16:	00070e1b          	sext.w	t3,a4
         if (fl & STBSP__METRIC_SUFFIX) {
    2b1a:	100e7693          	andi	a3,t3,256
    2b1e:	5c0683e3          	beqz	a3,38e4 <stbsp_vsprintfcb+0x1646>
            if (n64 < 1024)
    2b22:	3ff00793          	li	a5,1023
    2b26:	01e7e463          	bltu	a5,t5,2b2e <stbsp_vsprintfcb+0x890>
    2b2a:	0ea0106f          	j	3c14 <stbsp_vsprintfcb+0x1976>
            else if (pr == -1)
    2b2e:	57fd                	li	a5,-1
    2b30:	30f887e3          	beq	a7,a5,363e <stbsp_vsprintfcb+0x13a0>
            fv = (double)(stbsp__int64)n64;
    2b34:	d22f7553          	fcvt.d.l	fa0,t5
            if (fl & STBSP__METRIC_1024)
    2b38:	034e1793          	slli	a5,t3,0x34
    2b3c:	0007c463          	bltz	a5,2b44 <stbsp_vsprintfcb+0x8a6>
    2b40:	2300106f          	j	3d70 <stbsp_vsprintfcb+0x1ad2>
               divisor = 1024.0;
    2b44:	00004797          	auipc	a5,0x4
    2b48:	d647b787          	fld	fa5,-668(a5) # 68a8 <STDIN_FD+0x20>
               if ((fv < divisor) && (fv > -divisor))
    2b4c:	22f79753          	fneg.d	fa4,fa5
               fl += 0x1000000;
    2b50:	010006b7          	lui	a3,0x1000
            while (fl < 0x4000000) {
    2b54:	04000737          	lui	a4,0x4000
               if ((fv < divisor) && (fv > -divisor))
    2b58:	a2f517d3          	flt.d	a5,fa0,fa5
    2b5c:	c789                	beqz	a5,2b66 <stbsp_vsprintfcb+0x8c8>
    2b5e:	a2a717d3          	flt.d	a5,fa4,fa0
    2b62:	3e079863          	bnez	a5,2f52 <stbsp_vsprintfcb+0xcb4>
               fl += 0x1000000;
    2b66:	01c68e3b          	addw	t3,a3,t3
               fv /= divisor;
    2b6a:	1af57553          	fdiv.d	fa0,fa0,fa5
            while (fl < 0x4000000) {
    2b6e:	feee65e3          	bltu	t3,a4,2b58 <stbsp_vsprintfcb+0x8ba>
    2b72:	a6c5                	j	2f52 <stbsp_vsprintfcb+0xcb4>
         h = (f[0] == 'X') ? hexu : hex;
    2b74:	05800693          	li	a3,88
         if (fl & STBSP__INTMAX) {
    2b78:	020e7713          	andi	a4,t3,32
         h = (f[0] == 'X') ? hexu : hex;
    2b7c:	00005817          	auipc	a6,0x5
    2b80:	3d480813          	addi	a6,a6,980 # 7f50 <hex.0>
    2b84:	00d79663          	bne	a5,a3,2b90 <stbsp_vsprintfcb+0x8f2>
    2b88:	00005817          	auipc	a6,0x5
    2b8c:	3b080813          	addi	a6,a6,944 # 7f38 <hexu.1>
         l = (4 << 4) | (4 << 8);
    2b90:	44000793          	li	a5,1088
    2b94:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__LEADING_0X) {
    2b96:	008e7793          	andi	a5,t3,8
    2b9a:	7a079263          	bnez	a5,333e <stbsp_vsprintfcb+0x10a0>
         lead[0] = 0;
    2b9e:	06010423          	sb	zero,104(sp)
         s = va_arg(va, char *);
    2ba2:	008b8793          	addi	a5,s7,8
    2ba6:	e0be                	sd	a5,64(sp)
         if (fl & STBSP__INTMAX)
    2ba8:	72070b63          	beqz	a4,32de <stbsp_vsprintfcb+0x1040>
            n64 = va_arg(va, stbsp__uint64);
    2bac:	000bb683          	ld	a3,0(s7)
         dp = 0;
    2bb0:	d282                	sw	zero,100(sp)
         tail[0] = 0;
    2bb2:	06010823          	sb	zero,112(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    2bb6:	001e7513          	andi	a0,t3,1
         if (n64 == 0) {
    2bba:	380694e3          	bnez	a3,3742 <stbsp_vsprintfcb+0x14a4>
            lead[0] = 0;
    2bbe:	06010423          	sb	zero,104(sp)
            if (pr == 0) {
    2bc2:	78089a63          	bnez	a7,3356 <stbsp_vsprintfcb+0x10b8>
         if (fw < (stbsp__int32)n)
    2bc6:	fffb4313          	not	t1,s6
    2bca:	43f35313          	srai	t1,t1,0x3f
               l = 0;
    2bce:	d082                	sw	zero,96(sp)
         if (fw < (stbsp__int32)n)
    2bd0:	01637333          	and	t1,t1,s6
               goto scopy;
    2bd4:	4701                	li	a4,0
    2bd6:	4f81                	li	t6,0
    2bd8:	4a01                	li	s4,0
               cs = 0;
    2bda:	4281                	li	t0,0
         s = num + STBSP__NUMSZ;
    2bdc:	28010a93          	addi	s5,sp,640
         if ((fl & STBSP__LEFTJUST) == 0) {
    2be0:	9c0506e3          	beqz	a0,25ac <stbsp_vsprintfcb+0x30e>
         if (fw + pr) {
    2be4:	00e307bb          	addw	a5,t1,a4
    2be8:	9c079fe3          	bnez	a5,25c6 <stbsp_vsprintfcb+0x328>
    2bec:	06910793          	addi	a5,sp,105
    2bf0:	b661                	j	2778 <stbsp_vsprintfcb+0x4da>
         h = (f[0] == 'E') ? hexu : hex;
    2bf2:	04500713          	li	a4,69
    2bf6:	00005317          	auipc	t1,0x5
    2bfa:	35a30313          	addi	t1,t1,858 # 7f50 <hex.0>
    2bfe:	1ce78ae3          	beq	a5,a4,35d2 <stbsp_vsprintfcb+0x1334>
         fv = va_arg(va, double);
    2c02:	008b8713          	addi	a4,s7,8
         if (pr == -1)
    2c06:	57fd                	li	a5,-1
         fv = va_arg(va, double);
    2c08:	e0ba                	sd	a4,64(sp)
    2c0a:	000bb507          	fld	fa0,0(s7)
         if (pr == -1)
    2c0e:	1af88ce3          	beq	a7,a5,35c6 <stbsp_vsprintfcb+0x1328>
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr | 0x80000000))
    2c12:	80000737          	lui	a4,0x80000
    2c16:	00e8e733          	or	a4,a7,a4
    2c1a:	2701                	sext.w	a4,a4
    2c1c:	10d4                	addi	a3,sp,100
    2c1e:	0110                	addi	a2,sp,128
    2c20:	108c                	addi	a1,sp,96
    2c22:	18a8                	addi	a0,sp,120
    2c24:	f41e                	sd	t2,40(sp)
    2c26:	f01a                	sd	t1,32(sp)
    2c28:	ec72                	sd	t3,24(sp)
    2c2a:	e846                	sd	a7,16(sp)
    2c2c:	d8efe0ef          	jal	11ba <stbsp__real_to_str>
    2c30:	68c2                	ld	a7,16(sp)
    2c32:	6e62                	ld	t3,24(sp)
    2c34:	7302                	ld	t1,32(sp)
    2c36:	73a2                	ld	t2,40(sp)
         if (dp == STBSP__SPECIAL) {
    2c38:	5796                	lw	a5,100(sp)
            s = (char *)sn;
    2c3a:	7ae6                	ld	s5,120(sp)
         if ((l - 1) > (stbsp__uint32)pr)
    2c3c:	5686                	lw	a3,96(sp)
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr | 0x80000000))
    2c3e:	3c0511e3          	bnez	a0,3800 <stbsp_vsprintfcb+0x1562>
         tail[0] = 0;
    2c42:	06010823          	sb	zero,112(sp)
   sign[0] = 0;
    2c46:	06010423          	sb	zero,104(sp)
   } else if (fl & STBSP__LEADINGSPACE) {
    2c4a:	004e7713          	andi	a4,t3,4
    2c4e:	6a070ee3          	beqz	a4,3b0a <stbsp_vsprintfcb+0x186c>
      sign[0] = 1;
    2c52:	6709                	lui	a4,0x2
    2c54:	0705                	addi	a4,a4,1 # 2001 <_vscanf_core.constprop.0+0x6b9>
    2c56:	06e11423          	sh	a4,104(sp)
         if (dp == STBSP__SPECIAL) {
    2c5a:	671d                	lui	a4,0x7
    2c5c:	1ee794e3          	bne	a5,a4,3644 <stbsp_vsprintfcb+0x13a6>
         if (pr < (stbsp__int32)l)
    2c60:	0006879b          	sext.w	a5,a3
         n = pr + lead[0] + tail[0] + tz;
    2c64:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    2c68:	fff7c793          	not	a5,a5
         n = pr + lead[0] + tail[0] + tz;
    2c6c:	07014f83          	lbu	t6,112(sp)
         if (pr < (stbsp__int32)l)
    2c70:	97fd                	srai	a5,a5,0x3f
    2c72:	8ff5                	and	a5,a5,a3
         n = pr + lead[0] + tail[0] + tz;
    2c74:	00fa073b          	addw	a4,s4,a5
    2c78:	01f7063b          	addw	a2,a4,t6
    2c7c:	8732                	mv	a4,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    2c7e:	001e7513          	andi	a0,t3,1
         if (pr < (stbsp__int32)l)
    2c82:	2781                	sext.w	a5,a5
         if (fw < (stbsp__int32)n)
    2c84:	835a                	mv	t1,s6
    2c86:	00cb5363          	bge	s6,a2,2c8c <stbsp_vsprintfcb+0x9ee>
    2c8a:	8332                	mv	t1,a2
         fw -= n;
    2c8c:	40e3033b          	subw	t1,t1,a4
            cs = 0;
    2c90:	4281                	li	t0,0
         pr -= l;
    2c92:	40d7873b          	subw	a4,a5,a3
      tz = 0;
    2c96:	4881                	li	a7,0
            goto scopy;
    2c98:	b7a1                	j	2be0 <stbsp_vsprintfcb+0x942>
         h = (f[0] == 'G') ? hexu : hex;
    2c9a:	04700713          	li	a4,71
    2c9e:	00005317          	auipc	t1,0x5
    2ca2:	2b230313          	addi	t1,t1,690 # 7f50 <hex.0>
    2ca6:	14e783e3          	beq	a5,a4,35ec <stbsp_vsprintfcb+0x134e>
         fv = va_arg(va, double);
    2caa:	008b8713          	addi	a4,s7,8
         if (pr == -1)
    2cae:	57fd                	li	a5,-1
         fv = va_arg(va, double);
    2cb0:	e0ba                	sd	a4,64(sp)
    2cb2:	000bb507          	fld	fa0,0(s7)
         if (pr == -1)
    2cb6:	12f884e3          	beq	a7,a5,35de <stbsp_vsprintfcb+0x1340>
         else if (pr == 0)
    2cba:	6e0887e3          	beqz	a7,3ba8 <stbsp_vsprintfcb+0x190a>
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, (pr - 1) | 0x80000000))
    2cbe:	fff8871b          	addiw	a4,a7,-1
    2cc2:	800007b7          	lui	a5,0x80000
    2cc6:	8f5d                	or	a4,a4,a5
    2cc8:	2701                	sext.w	a4,a4
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    2cca:	00088a9b          	sext.w	s5,a7
    2cce:	8a46                	mv	s4,a7
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, (pr - 1) | 0x80000000))
    2cd0:	10d4                	addi	a3,sp,100
    2cd2:	0110                	addi	a2,sp,128
    2cd4:	108c                	addi	a1,sp,96
    2cd6:	18a8                	addi	a0,sp,120
    2cd8:	f01e                	sd	t2,32(sp)
    2cda:	ec1a                	sd	t1,24(sp)
    2cdc:	e872                	sd	t3,16(sp)
    2cde:	cdcfe0ef          	jal	11ba <stbsp__real_to_str>
    2ce2:	6e42                	ld	t3,16(sp)
    2ce4:	6362                	ld	t1,24(sp)
    2ce6:	7382                	ld	t2,32(sp)
    2ce8:	4281                	li	t0,0
    2cea:	c509                	beqz	a0,2cf4 <stbsp_vsprintfcb+0xa56>
            fl |= STBSP__NEGATIVE;
    2cec:	080e6e13          	ori	t3,t3,128
    2cf0:	08000293          	li	t0,128
         if (l > (stbsp__uint32)pr)
    2cf4:	5806                	lw	a6,96(sp)
    2cf6:	010af463          	bgeu	s5,a6,2cfe <stbsp_vsprintfcb+0xa60>
            l = pr;
    2cfa:	d0d6                	sw	s5,96(sp)
    2cfc:	8856                	mv	a6,s5
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2cfe:	4705                	li	a4,1
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    2d00:	5796                	lw	a5,100(sp)
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2d02:	01076463          	bltu	a4,a6,2d0a <stbsp_vsprintfcb+0xa6c>
    2d06:	1800106f          	j	3e86 <stbsp_vsprintfcb+0x1be8>
    2d0a:	7be6                	ld	s7,120(sp)
    2d0c:	fff8071b          	addiw	a4,a6,-1
    2d10:	1702                	slli	a4,a4,0x20
    2d12:	9301                	srli	a4,a4,0x20
    2d14:	001a0e9b          	addiw	t4,s4,1
    2d18:	75e2                	ld	a1,56(sp)
    2d1a:	8ade                	mv	s5,s7
    2d1c:	975e                	add	a4,a4,s7
    2d1e:	410e8ebb          	subw	t4,t4,a6
    2d22:	88d2                	mv	a7,s4
    2d24:	86c2                	mv	a3,a6
    2d26:	4f01                	li	t5,0
    2d28:	03000f93          	li	t6,48
    2d2c:	e842                	sd	a6,16(sp)
    2d2e:	a809                	j	2d40 <stbsp_vsprintfcb+0xaa2>
            --pr;
    2d30:	38fd                	addiw	a7,a7,-1
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2d32:	211e80e3          	beq	t4,a7,3732 <stbsp_vsprintfcb+0x1494>
    2d36:	177d                	addi	a4,a4,-1 # 6fff <STDIN_FD+0x777>
    2d38:	4f05                	li	t5,1
    2d3a:	1e088ce3          	beqz	a7,3732 <stbsp_vsprintfcb+0x1494>
            --l;
    2d3e:	85b6                	mv	a1,a3
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2d40:	00074803          	lbu	a6,0(a4)
    2d44:	fff6861b          	addiw	a2,a3,-1 # ffffff <_ZSt4cerr+0xff723f>
    2d48:	0006851b          	sext.w	a0,a3
    2d4c:	2581                	sext.w	a1,a1
    2d4e:	0006069b          	sext.w	a3,a2
    2d52:	fdf80fe3          	beq	a6,t6,2d30 <stbsp_vsprintfcb+0xa92>
    2d56:	6842                	ld	a6,16(sp)
    2d58:	fc2e                	sd	a1,56(sp)
    2d5a:	86c2                	mv	a3,a6
    2d5c:	000f0463          	beqz	t5,2d64 <stbsp_vsprintfcb+0xac6>
    2d60:	d0ae                	sw	a1,96(sp)
    2d62:	86ae                	mv	a3,a1
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    2d64:	5775                	li	a4,-3
    2d66:	08e7cee3          	blt	a5,a4,3602 <stbsp_vsprintfcb+0x1364>
    2d6a:	08fa4be3          	blt	s4,a5,3600 <stbsp_vsprintfcb+0x1362>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    2d6e:	0005071b          	sext.w	a4,a0
         if (dp > 0) {
    2d72:	7ef057e3          	blez	a5,3d60 <stbsp_vsprintfcb+0x1ac2>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    2d76:	4881                	li	a7,0
    2d78:	00e7d463          	bge	a5,a4,2d80 <stbsp_vsprintfcb+0xae2>
    2d7c:	40f508bb          	subw	a7,a0,a5
         tail[0] = 0;
    2d80:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    2d84:	20029463          	bnez	t0,2f8c <stbsp_vsprintfcb+0xcee>
   } else if (fl & STBSP__LEADINGSPACE) {
    2d88:	004e7713          	andi	a4,t3,4
    2d8c:	000715e3          	bnez	a4,3596 <stbsp_vsprintfcb+0x12f8>
   } else if (fl & STBSP__LEADINGPLUS) {
    2d90:	002e7713          	andi	a4,t3,2
    2d94:	660719e3          	bnez	a4,3c06 <stbsp_vsprintfcb+0x1968>
   sign[0] = 0;
    2d98:	06010423          	sb	zero,104(sp)
    2d9c:	aaed                	j	2f96 <stbsp_vsprintfcb+0xcf8>
         h = (f[0] == 'A') ? hexu : hex;
    2d9e:	04100713          	li	a4,65
    2da2:	00005597          	auipc	a1,0x5
    2da6:	1ae58593          	addi	a1,a1,430 # 7f50 <hex.0>
    2daa:	00e783e3          	beq	a5,a4,35b0 <stbsp_vsprintfcb+0x1312>
         fv = va_arg(va, double);
    2dae:	008b8693          	addi	a3,s7,8
         if (pr == -1)
    2db2:	577d                	li	a4,-1
         fv = va_arg(va, double);
    2db4:	e0b6                	sd	a3,64(sp)
    2db6:	000bb783          	ld	a5,0(s7)
         if (pr == -1)
    2dba:	7ee88963          	beq	a7,a4,35ac <stbsp_vsprintfcb+0x130e>
   d = value;

   STBSP__COPYFP(b, d);

   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    2dbe:	4347d613          	srai	a2,a5,0x34
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    2dc2:	00c79513          	slli	a0,a5,0xc
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    2dc6:	7ff67613          	andi	a2,a2,2047
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    2dca:	8131                	srli	a0,a0,0xc
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    2dcc:	c016061b          	addiw	a2,a2,-1023
         if (stbsp__real_to_parts((stbsp__int64 *)&n64, &dp, fv))
    2dd0:	7a07c863          	bltz	a5,3580 <stbsp_vsprintfcb+0x12e2>
   } else if (fl & STBSP__LEADINGSPACE) {
    2dd4:	004e7793          	andi	a5,t3,4
    2dd8:	60078ee3          	beqz	a5,3bf4 <stbsp_vsprintfcb+0x1956>
    2ddc:	6789                	lui	a5,0x2
    2dde:	2785                	addiw	a5,a5,1 # 2001 <_vscanf_core.constprop.0+0x6b9>
      sign[0] = 1;
    2de0:	06f11423          	sh	a5,104(sp)
    2de4:	468d                	li	a3,3
    2de6:	4a0d                	li	s4,3
    2de8:	4809                	li	a6,2
            n64 |= (((stbsp__uint64)1) << 52);
    2dea:	4705                	li	a4,1
    2dec:	1752                	slli	a4,a4,0x34
         if (dp == -1023)
    2dee:	c0100793          	li	a5,-1023
            n64 |= (((stbsp__uint64)1) << 52);
    2df2:	8f49                	or	a4,a4,a0
         if (dp == -1023)
    2df4:	5cf600e3          	beq	a2,a5,3bb4 <stbsp_vsprintfcb+0x1916>
         if (pr < 15)
    2df8:	4539                	li	a0,14
         n64 <<= (64 - 56);
    2dfa:	00871793          	slli	a5,a4,0x8
         if (pr < 15)
    2dfe:	251546e3          	blt	a0,a7,384a <stbsp_vsprintfcb+0x15ac>
            n64 += ((((stbsp__uint64)8) << 56) >> (pr * 4));
    2e02:	4705                	li	a4,1
    2e04:	0028951b          	slliw	a0,a7,0x2
    2e08:	176e                	slli	a4,a4,0x3b
    2e0a:	00a75733          	srl	a4,a4,a0
    2e0e:	973e                	add	a4,a4,a5
         *s++ = h[(n64 >> 60) & 15];
    2e10:	03c75793          	srli	a5,a4,0x3c
    2e14:	97ae                	add	a5,a5,a1
    2e16:	0007c503          	lbu	a0,0(a5)
         lead[1 + lead[0]] = '0';
    2e1a:	22080793          	addi	a5,a6,544
    2e1e:	06010813          	addi	a6,sp,96
    2e22:	97c2                	add	a5,a5,a6
    2e24:	03000813          	li	a6,48
    2e28:	df078423          	sb	a6,-536(a5)
         lead[2 + lead[0]] = 'x';
    2e2c:	22068793          	addi	a5,a3,544
    2e30:	1094                	addi	a3,sp,96
    2e32:	96be                	add	a3,a3,a5
    2e34:	07800793          	li	a5,120
    2e38:	def68423          	sb	a5,-536(a3)
         lead[0] += 2;
    2e3c:	07410423          	sb	s4,104(sp)
         *s++ = h[(n64 >> 60) & 15];
    2e40:	0ca10023          	sb	a0,192(sp)
         if (pr)
    2e44:	740893e3          	bnez	a7,3d8a <stbsp_vsprintfcb+0x1aec>
         sn = s;
    2e48:	0c110793          	addi	a5,sp,193
    2e4c:	fcbe                	sd	a5,120(sp)
    2e4e:	4701                	li	a4,0
    2e50:	4501                	li	a0,0
    2e52:	4305                	li	t1,1
    2e54:	4685                	li	a3,1
         tail[1] = h[17];
    2e56:	0115c583          	lbu	a1,17(a1)
            tail[2] = '+';
    2e5a:	02b00793          	li	a5,43
         tail[1] = h[17];
    2e5e:	06b108a3          	sb	a1,113(sp)
         if (dp < 0) {
    2e62:	00065663          	bgez	a2,2e6e <stbsp_vsprintfcb+0xbd0>
            dp = -dp;
    2e66:	40c0063b          	negw	a2,a2
            tail[2] = '-';
    2e6a:	02d00793          	li	a5,45
            tail[n] = '0' + dp % 10;
    2e6e:	4829                	li	a6,10
    2e70:	030665bb          	remw	a1,a2,a6
    2e74:	06f10923          	sb	a5,114(sp)
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    2e78:	3e700e93          	li	t4,999
            tail[n] = '0' + dp % 10;
    2e7c:	0305859b          	addiw	a1,a1,48
    2e80:	0ff5f593          	zext.b	a1,a1
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    2e84:	18cec3e3          	blt	t4,a2,380a <stbsp_vsprintfcb+0x156c>
    2e88:	06300e93          	li	t4,99
    2e8c:	54cec1e3          	blt	t4,a2,3bce <stbsp_vsprintfcb+0x1930>
    2e90:	4ea5                	li	t4,9
    2e92:	72ced6e3          	bge	t4,a2,3dbe <stbsp_vsprintfcb+0x1b20>
            dp /= 10;
    2e96:	030647bb          	divw	a5,a2,a6
         tail[0] = (char)n;
    2e9a:	4611                	li	a2,4
    2e9c:	06c10823          	sb	a2,112(sp)
            tail[n] = '0' + dp % 10;
    2ea0:	06b10a23          	sb	a1,116(sp)
    2ea4:	4811                	li	a6,4
    2ea6:	4f91                	li	t6,4
    2ea8:	0307879b          	addiw	a5,a5,48
    2eac:	06f109a3          	sb	a5,115(sp)
         n = pr + lead[0] + tail[0] + tz;
    2eb0:	006a07bb          	addw	a5,s4,t1
    2eb4:	010787bb          	addw	a5,a5,a6
    2eb8:	0117863b          	addw	a2,a5,a7
         dp = (int)(s - sn);
    2ebc:	d2aa                	sw	a0,100(sp)
         l = (int)(s - (num + 64));
    2ebe:	d0b6                	sw	a3,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    2ec0:	87b2                	mv	a5,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    2ec2:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    2ec6:	835a                	mv	t1,s6
    2ec8:	00cb5363          	bge	s6,a2,2ece <stbsp_vsprintfcb+0xc30>
    2ecc:	8332                	mv	t1,a2
         cs = 1 + (3 << 24);
    2ece:	030002b7          	lui	t0,0x3000
         fw -= n;
    2ed2:	40f3033b          	subw	t1,t1,a5
         cs = 1 + (3 << 24);
    2ed6:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff7241>
         s = num + 64;
    2ed8:	0c010a93          	addi	s5,sp,192
         goto scopy;
    2edc:	b311                	j	2be0 <stbsp_vsprintfcb+0x942>
         h = (f[0] == 'B') ? hexu : hex;
    2ede:	04200713          	li	a4,66
    2ee2:	00005817          	auipc	a6,0x5
    2ee6:	06e80813          	addi	a6,a6,110 # 7f50 <hex.0>
    2eea:	6ce78963          	beq	a5,a4,35bc <stbsp_vsprintfcb+0x131e>
         if (fl & STBSP__LEADING_0X) {
    2eee:	008e7793          	andi	a5,t3,8
    2ef2:	66079e63          	bnez	a5,356e <stbsp_vsprintfcb+0x12d0>
         lead[0] = 0;
    2ef6:	06010423          	sb	zero,104(sp)
         l = (8 << 4) | (1 << 8);
    2efa:	18000793          	li	a5,384
    2efe:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__INTMAX) {
    2f00:	020e7713          	andi	a4,t3,32
         goto radixnum;
    2f04:	b979                	j	2ba2 <stbsp_vsprintfcb+0x904>
         *s = (char)va_arg(va, int);
    2f06:	000ba783          	lw	a5,0(s7)
         l = 1;
    2f0a:	4705                	li	a4,1
    2f0c:	d0ba                	sw	a4,96(sp)
         *s = (char)va_arg(va, int);
    2f0e:	26f10fa3          	sb	a5,639(sp)
    2f12:	008b8793          	addi	a5,s7,8
         lead[0] = 0;
    2f16:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    2f1a:	06010823          	sb	zero,112(sp)
         dp = 0;
    2f1e:	d282                	sw	zero,100(sp)
         *s = (char)va_arg(va, int);
    2f20:	e0be                	sd	a5,64(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    2f22:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    2f26:	835a                	mv	t1,s6
    2f28:	69605063          	blez	s6,35a8 <stbsp_vsprintfcb+0x130a>
         fw -= n;
    2f2c:	337d                	addiw	t1,t1,-1
         goto scopy;
    2f2e:	4701                	li	a4,0
    2f30:	4f81                	li	t6,0
    2f32:	4685                	li	a3,1
    2f34:	4a01                	li	s4,0
         cs = 0;
    2f36:	4281                	li	t0,0
         s = num + STBSP__NUMSZ - 1;
    2f38:	27f10a93          	addi	s5,sp,639
      tz = 0;
    2f3c:	4881                	li	a7,0
         goto scopy;
    2f3e:	b14d                	j	2be0 <stbsp_vsprintfcb+0x942>
         fv = va_arg(va, double);
    2f40:	008b8713          	addi	a4,s7,8
         if (fl & STBSP__METRIC_SUFFIX) {
    2f44:	100e7793          	andi	a5,t3,256
         fv = va_arg(va, double);
    2f48:	e0ba                	sd	a4,64(sp)
    2f4a:	000bb507          	fld	fa0,0(s7)
         if (fl & STBSP__METRIC_SUFFIX) {
    2f4e:	be0795e3          	bnez	a5,2b38 <stbsp_vsprintfcb+0x89a>
         if (pr == -1)
    2f52:	57fd                	li	a5,-1
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    2f54:	0008871b          	sext.w	a4,a7
         if (pr == -1)
    2f58:	00f89463          	bne	a7,a5,2f60 <stbsp_vsprintfcb+0xcc2>
    2f5c:	4719                	li	a4,6
            pr = 6; // default is 6
    2f5e:	4899                	li	a7,6
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    2f60:	10d4                	addi	a3,sp,100
    2f62:	0110                	addi	a2,sp,128
    2f64:	108c                	addi	a1,sp,96
    2f66:	18a8                	addi	a0,sp,120
    2f68:	f01e                	sd	t2,32(sp)
    2f6a:	ec72                	sd	t3,24(sp)
    2f6c:	e846                	sd	a7,16(sp)
    2f6e:	a4cfe0ef          	jal	11ba <stbsp__real_to_str>
    2f72:	6e62                	ld	t3,24(sp)
    2f74:	68c2                	ld	a7,16(sp)
    2f76:	7382                	ld	t2,32(sp)
         if (dp == STBSP__SPECIAL) {
    2f78:	5796                	lw	a5,100(sp)
            if ((stbsp__int32)(l + n) > pr)
    2f7a:	5686                	lw	a3,96(sp)
   if (fl & STBSP__NEGATIVE) {
    2f7c:	080e7293          	andi	t0,t3,128
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    2f80:	e00500e3          	beqz	a0,2d80 <stbsp_vsprintfcb+0xae2>
            fl |= STBSP__NEGATIVE;
    2f84:	080e6e13          	ori	t3,t3,128
         tail[0] = 0;
    2f88:	06010823          	sb	zero,112(sp)
      sign[0] = 1;
    2f8c:	670d                	lui	a4,0x3
    2f8e:	d0170713          	addi	a4,a4,-767 # 2d01 <stbsp_vsprintfcb+0xa63>
    2f92:	06e11423          	sh	a4,104(sp)
         if (dp == STBSP__SPECIAL) {
    2f96:	671d                	lui	a4,0x7
    2f98:	7ce78963          	beq	a5,a4,376a <stbsp_vsprintfcb+0x14cc>
         if (dp <= 0) {
    2f9c:	46f05fe3          	blez	a5,3c1a <stbsp_vsprintfcb+0x197c>
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((600 - (stbsp__uint32)dp) % 3) : 0;
    2fa0:	040e7313          	andi	t1,t3,64
    2fa4:	00078e9b          	sext.w	t4,a5
    2fa8:	4581                	li	a1,0
    2faa:	00030963          	beqz	t1,2fbc <stbsp_vsprintfcb+0xd1e>
    2fae:	25800593          	li	a1,600
    2fb2:	41d585bb          	subw	a1,a1,t4
    2fb6:	470d                	li	a4,3
    2fb8:	02e5f5bb          	remuw	a1,a1,a4
                     *s++ = stbsp__comma;
    2fbc:	00005a17          	auipc	s4,0x5
    2fc0:	eaca0a13          	addi	s4,s4,-340 # 7e68 <stbsp__digitpair>
            s = (char *)sn;
    2fc4:	7f66                	ld	t5,120(sp)
                     *s++ = stbsp__comma;
    2fc6:	0cda4283          	lbu	t0,205(s4)
         s = num + 64;
    2fca:	0c010a93          	addi	s5,sp,192
            if ((stbsp__uint32)dp >= l) {
    2fce:	44defb63          	bgeu	t4,a3,3424 <stbsp_vsprintfcb+0x1186>
               n = 0;
    2fd2:	4501                	li	a0,0
         s = num + 64;
    2fd4:	8756                	mv	a4,s5
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    2fd6:	4b91                	li	s7,4
    2fd8:	a015                	j	2ffc <stbsp_vsprintfcb+0xd5e>
    2fda:	8642                	mv	a2,a6
    2fdc:	883a                	mv	a6,a4
    2fde:	8732                	mv	a4,a2
                     *s++ = sn[n];
    2fe0:	02051613          	slli	a2,a0,0x20
    2fe4:	9201                	srli	a2,a2,0x20
    2fe6:	967a                	add	a2,a2,t5
    2fe8:	00064f83          	lbu	t6,0(a2)
                     ++n;
    2fec:	0015061b          	addiw	a2,a0,1
    2ff0:	0006051b          	sext.w	a0,a2
                     *s++ = sn[n];
    2ff4:	fff70fa3          	sb	t6,-1(a4) # 6fff <STDIN_FD+0x777>
                     if (n >= (stbsp__uint32)dp)
    2ff8:	7bd57563          	bgeu	a0,t4,37a2 <stbsp_vsprintfcb+0x1504>
                     *s++ = stbsp__comma;
    2ffc:	00170813          	addi	a6,a4,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3000:	fc030de3          	beqz	t1,2fda <stbsp_vsprintfcb+0xd3c>
    3004:	2585                	addiw	a1,a1,1
    3006:	fd759ae3          	bne	a1,s7,2fda <stbsp_vsprintfcb+0xd3c>
                     *s++ = stbsp__comma;
    300a:	fe580fa3          	sb	t0,-1(a6)
    300e:	0709                	addi	a4,a4,2
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3010:	4585                	li	a1,1
    3012:	b7f9                	j	2fe0 <stbsp_vsprintfcb+0xd42>
         *d = tlen + (int)(bf - buf);
    3014:	000bb703          	ld	a4,0(s7)
    3018:	412407b3          	sub	a5,s0,s2
    301c:	01a787bb          	addw	a5,a5,s10
         int *d = va_arg(va, int *);
    3020:	008b8693          	addi	a3,s7,8
    3024:	e0b6                	sd	a3,64(sp)
         *d = tlen + (int)(bf - buf);
    3026:	c31c                	sw	a5,0(a4)
      } break;
    3028:	bae5                	j	2a20 <stbsp_vsprintfcb+0x782>
         if (fl & STBSP__LEADING_0X) {
    302a:	008e7793          	andi	a5,t3,8
    302e:	50079b63          	bnez	a5,3544 <stbsp_vsprintfcb+0x12a6>
         lead[0] = 0;
    3032:	06010423          	sb	zero,104(sp)
         l = (3 << 4) | (3 << 8);
    3036:	33000793          	li	a5,816
    303a:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__INTMAX) {
    303c:	020e7713          	andi	a4,t3,32
         h = hexu;
    3040:	00005817          	auipc	a6,0x5
    3044:	ef880813          	addi	a6,a6,-264 # 7f38 <hexu.1>
         goto radixnum;
    3048:	bea9                	j	2ba2 <stbsp_vsprintfcb+0x904>
         fl &= ~STBSP__LEADINGZERO; // 'p' only prints the pointer with zeros
    304a:	fefe7e13          	andi	t3,t3,-17
    304e:	020e6e13          	ori	t3,t3,32
    3052:	02000713          	li	a4,32
         pr = sizeof(void *) * 2;
    3056:	48c1                	li	a7,16
         h = (f[0] == 'X') ? hexu : hex;
    3058:	00005817          	auipc	a6,0x5
    305c:	ef880813          	addi	a6,a6,-264 # 7f50 <hex.0>
    3060:	be05                	j	2b90 <stbsp_vsprintfcb+0x8f2>
         s = va_arg(va, char *);
    3062:	000bba83          	ld	s5,0(s7)
    3066:	008b8793          	addi	a5,s7,8
    306a:	e0be                	sd	a5,64(sp)
         if (s == 0)
    306c:	360a8ee3          	beqz	s5,3be8 <stbsp_vsprintfcb+0x194a>
      if (((stbsp__uintptr)sn & 3) == 0)
    3070:	003af793          	andi	a5,s5,3
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    3074:	5208c663          	bltz	a7,35a0 <stbsp_vsprintfcb+0x1302>
    3078:	0008869b          	sext.w	a3,a7
      if (((stbsp__uintptr)sn & 3) == 0)
    307c:	2a0782e3          	beqz	a5,3b20 <stbsp_vsprintfcb+0x1882>
      if (!limit || *sn == 0)
    3080:	5a068b63          	beqz	a3,3636 <stbsp_vsprintfcb+0x1398>
      if (((stbsp__uintptr)sn & 3) == 0)
    3084:	87d6                	mv	a5,s5
    3086:	a801                	j	3096 <stbsp_vsprintfcb+0xdf8>
      ++sn;
    3088:	0785                	addi	a5,a5,1
      if (((stbsp__uintptr)sn & 3) == 0)
    308a:	0037f713          	andi	a4,a5,3
      --limit;
    308e:	36fd                	addiw	a3,a3,-1
      if (((stbsp__uintptr)sn & 3) == 0)
    3090:	280709e3          	beqz	a4,3b22 <stbsp_vsprintfcb+0x1884>
      if (!limit || *sn == 0)
    3094:	c681                	beqz	a3,309c <stbsp_vsprintfcb+0xdfe>
    3096:	0007c703          	lbu	a4,0(a5)
    309a:	f77d                	bnez	a4,3088 <stbsp_vsprintfcb+0xdea>
         return (stbsp__uint32)(sn - s);
    309c:	415787b3          	sub	a5,a5,s5
    30a0:	0007869b          	sext.w	a3,a5
         if (pr < (stbsp__int32)l)
    30a4:	fff6c713          	not	a4,a3
    30a8:	977d                	srai	a4,a4,0x3f
    30aa:	8f7d                	and	a4,a4,a5
    30ac:	0007079b          	sext.w	a5,a4
         n = pr + lead[0] + tail[0] + tz;
    30b0:	863e                	mv	a2,a5
         pr -= l;
    30b2:	9f15                	subw	a4,a4,a3
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    30b4:	d0b6                	sw	a3,96(sp)
         lead[0] = 0;
    30b6:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    30ba:	06010823          	sb	zero,112(sp)
         dp = 0;
    30be:	d282                	sw	zero,100(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    30c0:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    30c4:	835a                	mv	t1,s6
    30c6:	00fb5363          	bge	s6,a5,30cc <stbsp_vsprintfcb+0xe2e>
    30ca:	833e                	mv	t1,a5
         fw -= n;
    30cc:	40c3033b          	subw	t1,t1,a2
         goto scopy;
    30d0:	4f81                	li	t6,0
    30d2:	4a01                	li	s4,0
         cs = 0;
    30d4:	4281                	li	t0,0
      tz = 0;
    30d6:	4881                	li	a7,0
         goto scopy;
    30d8:	b621                	j	2be0 <stbsp_vsprintfcb+0x942>
                     *bf++ = stbsp__comma;
    30da:	87b2                	mv	a5,a2
                     cs = 0;
    30dc:	4a01                	li	s4,0
    30de:	e44ff06f          	j	2722 <stbsp_vsprintfcb+0x484>
               lead[0] -= (char)i;
    30e2:	06010423          	sb	zero,104(sp)
               while (i) {
    30e6:	d38ff06f          	j	261e <stbsp_vsprintfcb+0x380>
            lead[0] -= (char)i;
    30ea:	06010423          	sb	zero,104(sp)
            while (i) {
    30ee:	ed8ff06f          	j	27c6 <stbsp_vsprintfcb+0x528>
            while (i >= 4) {
    30f2:	06fadc63          	bge	s5,a5,316a <stbsp_vsprintfcb+0xecc>
            tz -= i;
    30f6:	8722                	mv	a4,s0
    30f8:	0007851b          	sext.w	a0,a5
            while (i >= 4) {
    30fc:	008785bb          	addw	a1,a5,s0
               *(stbsp__uint32 *)bf = 0x30303030;
    3100:	01672023          	sw	s6,0(a4)
               bf += 4;
    3104:	0711                	addi	a4,a4,4
            while (i >= 4) {
    3106:	40e5863b          	subw	a2,a1,a4
    310a:	fecacbe3          	blt	s5,a2,3100 <stbsp_vsprintfcb+0xe62>
    310e:	ffc5061b          	addiw	a2,a0,-4
    3112:	0026561b          	srliw	a2,a2,0x2
    3116:	0016071b          	addiw	a4,a2,1
    311a:	37f1                	addiw	a5,a5,-4
    311c:	0026161b          	slliw	a2,a2,0x2
    3120:	070a                	slli	a4,a4,0x2
    3122:	9722                	add	a4,a4,s0
    3124:	9f91                	subw	a5,a5,a2
            while (i) {
    3126:	843a                	mv	s0,a4
    3128:	80078de3          	beqz	a5,2942 <stbsp_vsprintfcb+0x6a4>
    312c:	1782                	slli	a5,a5,0x20
    312e:	9381                	srli	a5,a5,0x20
    3130:	00f70433          	add	s0,a4,a5
               *bf++ = '0';
    3134:	0705                	addi	a4,a4,1
    3136:	ff470fa3          	sb	s4,-1(a4)
            while (i) {
    313a:	fe871de3          	bne	a4,s0,3134 <stbsp_vsprintfcb+0xe96>
    313e:	805ff06f          	j	2942 <stbsp_vsprintfcb+0x6a4>
               stbsp__cb_buf_clamp(i, pr);
    3142:	85ce                	mv	a1,s3
               if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    3144:	4981                	li	s3,0
    3146:	dc049263          	bnez	s1,270a <stbsp_vsprintfcb+0x46c>
    314a:	b8d5                	j	2a3e <stbsp_vsprintfcb+0x7a0>
            STBSP__UNALIGNED(while (i >= 4) {
    314c:	4401                	li	s0,0
    314e:	85be                	mv	a1,a5
    3150:	f0ea4b63          	blt	s4,a4,2866 <stbsp_vsprintfcb+0x5c8>
    3154:	f42ff06f          	j	2896 <stbsp_vsprintfcb+0x5f8>
               if ((((stbsp__uintptr)bf) & 3) == 0)
    3158:	00347713          	andi	a4,s0,3
            stbsp__cb_buf_clamp(i, tz);
    315c:	87c6                	mv	a5,a7
            tz -= i;
    315e:	4881                	li	a7,0
               if ((((stbsp__uintptr)bf) & 3) == 0)
    3160:	fc071c63          	bnez	a4,2938 <stbsp_vsprintfcb+0x69a>
            while (i >= 4) {
    3164:	470d                	li	a4,3
    3166:	f8f748e3          	blt	a4,a5,30f6 <stbsp_vsprintfcb+0xe58>
    316a:	8722                	mv	a4,s0
    316c:	b7c1                	j	312c <stbsp_vsprintfcb+0xe8e>
            tail[0] -= (char)i;
    316e:	06010823          	sb	zero,112(sp)
            while (i) {
    3172:	b0b9                	j	29c0 <stbsp_vsprintfcb+0x722>
                  while (i >= 4) {
    3174:	478d                	li	a5,3
    3176:	8622                	mv	a2,s0
    3178:	d8b7d963          	bge	a5,a1,270a <stbsp_vsprintfcb+0x46c>
    317c:	ffc5839b          	addiw	t2,a1,-4
    3180:	0023d79b          	srliw	a5,t2,0x2
    3184:	0017859b          	addiw	a1,a5,1
    3188:	058a                	slli	a1,a1,0x2
    318a:	942e                	add	s0,s0,a1
                     *(stbsp__uint32 *)bf = 0x30303030;
    318c:	01762023          	sw	s7,0(a2)
                     bf += 4;
    3190:	0611                	addi	a2,a2,4
                  while (i >= 4) {
    3192:	fe861de3          	bne	a2,s0,318c <stbsp_vsprintfcb+0xeee>
    3196:	0027979b          	slliw	a5,a5,0x2
    319a:	40f385bb          	subw	a1,t2,a5
    319e:	d68ff06f          	j	2706 <stbsp_vsprintfcb+0x468>
            while (i) {
    31a2:	85be                	mv	a1,a5
    31a4:	ee071963          	bnez	a4,2896 <stbsp_vsprintfcb+0x5f8>
    31a8:	f16ff06f          	j	28be <stbsp_vsprintfcb+0x620>
    31ac:	2c013a03          	ld	s4,704(sp)
    31b0:	2b813a83          	ld	s5,696(sp)
    31b4:	2b013b03          	ld	s6,688(sp)
    31b8:	8ca2                	mv	s9,s0
    31ba:	a04ff06f          	j	23be <stbsp_vsprintfcb+0x120>
            stbsp__chk_cb_buf(1);
    31be:	2601                	sext.w	a2,a2
    31c0:	1fe00793          	li	a5,510
    31c4:	f8c7c563          	blt	a5,a2,294e <stbsp_vsprintfcb+0x6b0>
    31c8:	f3eff06f          	j	2906 <stbsp_vsprintfcb+0x668>
               fl &= ~STBSP__TRIPLET_COMMA; // if no leading zeros, then no commas
    31cc:	fbfe7e13          	andi	t3,t3,-65
         if (fw + pr) {
    31d0:	006707bb          	addw	a5,a4,t1
               fl &= ~STBSP__TRIPLET_COMMA; // if no leading zeros, then no commas
    31d4:	2e01                	sext.w	t3,t3
         if (fw + pr) {
    31d6:	a0078be3          	beqz	a5,2bec <stbsp_vsprintfcb+0x94e>
               while (fw > 0) {
    31da:	be605663          	blez	t1,25c6 <stbsp_vsprintfcb+0x328>
                     *(stbsp__uint32 *)bf = 0x20202020;
    31de:	20202837          	lui	a6,0x20202
                  stbsp__cb_buf_clamp(i, fw);
    31e2:	854a                	mv	a0,s2
    31e4:	894e                	mv	s2,s3
    31e6:	69a2                	ld	s3,8(sp)
                     *(stbsp__uint32 *)bf = 0x20202020;
    31e8:	02080813          	addi	a6,a6,32 # 20202020 <_ZSt4cerr+0x201f9260>
                  stbsp__cb_buf_clamp(i, fw);
    31ec:	ec52                	sd	s4,24(sp)
    31ee:	f426                	sd	s1,40(sp)
    31f0:	87a2                	mv	a5,s0
    31f2:	84ea                	mv	s1,s10
                  stbsp__chk_cb_buf(1);
    31f4:	1fe00f13          	li	t5,510
                  stbsp__cb_buf_clamp(i, fw);
    31f8:	8d6e                	mv	s10,s11
                     *bf++ = ' ';
    31fa:	02000b13          	li	s6,32
                  stbsp__cb_buf_clamp(i, fw);
    31fe:	8de6                	mv	s11,s9
                  while (i >= 4) {
    3200:	4b8d                	li	s7,3
                  stbsp__cb_buf_clamp(i, fw);
    3202:	20000e93          	li	t4,512
    3206:	e846                	sd	a7,16(sp)
    3208:	f07e                	sd	t6,32(sp)
    320a:	f836                	sd	a3,48(sp)
    320c:	e4f2                	sd	t3,72(sp)
    320e:	e8ba                	sd	a4,80(sp)
    3210:	ec96                	sd	t0,88(sp)
    3212:	841a                	mv	s0,t1
    3214:	8a42                	mv	s4,a6
    3216:	8c9e                	mv	s9,t2
    3218:	0c090063          	beqz	s2,32d8 <stbsp_vsprintfcb+0x103a>
    321c:	40a78633          	sub	a2,a5,a0
    3220:	40ce873b          	subw	a4,t4,a2
    3224:	86ba                	mv	a3,a4
    3226:	00e45363          	bge	s0,a4,322c <stbsp_vsprintfcb+0xf8e>
    322a:	86a2                	mv	a3,s0
    322c:	0006871b          	sext.w	a4,a3
                  fw -= i;
    3230:	9c15                	subw	s0,s0,a3
                  while (i) {
    3232:	e719                	bnez	a4,3240 <stbsp_vsprintfcb+0xfa2>
    3234:	a095                	j	3298 <stbsp_vsprintfcb+0xffa>
                     *bf++ = ' ';
    3236:	01678023          	sb	s6,0(a5)
                     --i;
    323a:	377d                	addiw	a4,a4,-1
                     *bf++ = ' ';
    323c:	0785                	addi	a5,a5,1
                  while (i) {
    323e:	cb29                	beqz	a4,3290 <stbsp_vsprintfcb+0xff2>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    3240:	0037f693          	andi	a3,a5,3
    3244:	faed                	bnez	a3,3236 <stbsp_vsprintfcb+0xf98>
                  while (i >= 4) {
    3246:	86be                	mv	a3,a5
    3248:	00070f9b          	sext.w	t6,a4
    324c:	00f705bb          	addw	a1,a4,a5
    3250:	02ebd763          	bge	s7,a4,327e <stbsp_vsprintfcb+0xfe0>
                     *(stbsp__uint32 *)bf = 0x20202020;
    3254:	0146a023          	sw	s4,0(a3)
                     bf += 4;
    3258:	0691                	addi	a3,a3,4
                  while (i >= 4) {
    325a:	40d5863b          	subw	a2,a1,a3
    325e:	fecbcbe3          	blt	s7,a2,3254 <stbsp_vsprintfcb+0xfb6>
    3262:	ffcf861b          	addiw	a2,t6,-4 # fffffffff7fffffc <_ZSt4cerr+0xfffffffff7ff723c>
    3266:	0026561b          	srliw	a2,a2,0x2
    326a:	0016069b          	addiw	a3,a2,1
    326e:	3771                	addiw	a4,a4,-4
    3270:	0026161b          	slliw	a2,a2,0x2
    3274:	068a                	slli	a3,a3,0x2
    3276:	96be                	add	a3,a3,a5
    3278:	9f11                	subw	a4,a4,a2
                  while (i) {
    327a:	87b6                	mv	a5,a3
    327c:	cb11                	beqz	a4,3290 <stbsp_vsprintfcb+0xff2>
    327e:	1702                	slli	a4,a4,0x20
    3280:	9301                	srli	a4,a4,0x20
    3282:	00e687b3          	add	a5,a3,a4
                     *bf++ = ' ';
    3286:	0685                	addi	a3,a3,1
    3288:	ff668fa3          	sb	s6,-1(a3)
                  while (i) {
    328c:	fef69de3          	bne	a3,a5,3286 <stbsp_vsprintfcb+0xfe8>
                  stbsp__chk_cb_buf(1);
    3290:	40a78633          	sub	a2,a5,a0
    3294:	00090e63          	beqz	s2,32b0 <stbsp_vsprintfcb+0x1012>
    3298:	2601                	sext.w	a2,a2
    329a:	00cf5b63          	bge	t5,a2,32b0 <stbsp_vsprintfcb+0x1012>
    329e:	85ce                	mv	a1,s3
    32a0:	9cb1                	addw	s1,s1,a2
    32a2:	9902                	jalr	s2
    32a4:	c541                	beqz	a0,332c <stbsp_vsprintfcb+0x108e>
    32a6:	87aa                	mv	a5,a0
    32a8:	20000e93          	li	t4,512
    32ac:	1fe00f13          	li	t5,510
               while (fw > 0) {
    32b0:	f68044e3          	bgtz	s0,3218 <stbsp_vsprintfcb+0xf7a>
    32b4:	8322                	mv	t1,s0
    32b6:	89ca                	mv	s3,s2
    32b8:	83e6                	mv	t2,s9
    32ba:	68c2                	ld	a7,16(sp)
    32bc:	8cee                	mv	s9,s11
    32be:	6a62                	ld	s4,24(sp)
    32c0:	8dea                	mv	s11,s10
    32c2:	7f82                	ld	t6,32(sp)
    32c4:	8d26                	mv	s10,s1
    32c6:	76c2                	ld	a3,48(sp)
    32c8:	6e26                	ld	t3,72(sp)
    32ca:	6746                	ld	a4,80(sp)
    32cc:	62e6                	ld	t0,88(sp)
    32ce:	74a2                	ld	s1,40(sp)
    32d0:	892a                	mv	s2,a0
    32d2:	843e                	mv	s0,a5
    32d4:	af2ff06f          	j	25c6 <stbsp_vsprintfcb+0x328>
                  stbsp__cb_buf_clamp(i, fw);
    32d8:	8722                	mv	a4,s0
    32da:	4401                	li	s0,0
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    32dc:	b795                	j	3240 <stbsp_vsprintfcb+0xfa2>
            n64 = va_arg(va, stbsp__uint32);
    32de:	000be683          	lwu	a3,0(s7)
    32e2:	b0f9                	j	2bb0 <stbsp_vsprintfcb+0x912>
    32e4:	2c013a03          	ld	s4,704(sp)
    32e8:	2b813a83          	ld	s5,696(sp)
    32ec:	2b013b03          	ld	s6,688(sp)
    32f0:	8cca                	mv	s9,s2
    32f2:	8ccff06f          	j	23be <stbsp_vsprintfcb+0x120>
    32f6:	8cd6                	mv	s9,s5
    32f8:	2c013a03          	ld	s4,704(sp)
    32fc:	2b813a83          	ld	s5,696(sp)
    3300:	2b013b03          	ld	s6,688(sp)
    3304:	8baff06f          	j	23be <stbsp_vsprintfcb+0x120>
    3308:	2c013a03          	ld	s4,704(sp)
    330c:	2b813a83          	ld	s5,696(sp)
    3310:	2b013b03          	ld	s6,688(sp)
    3314:	8cea                	mv	s9,s10
    3316:	8a8ff06f          	j	23be <stbsp_vsprintfcb+0x120>
                  while (i) {
    331a:	85a2                	mv	a1,s0
    331c:	c12ff06f          	j	272e <stbsp_vsprintfcb+0x490>
                  while (i >= 4) {
    3320:	478d                	li	a5,3
    3322:	8622                	mv	a2,s0
    3324:	e4b7cce3          	blt	a5,a1,317c <stbsp_vsprintfcb+0xede>
    3328:	be2ff06f          	j	270a <stbsp_vsprintfcb+0x46c>
    332c:	2c013a03          	ld	s4,704(sp)
    3330:	2b813a83          	ld	s5,696(sp)
    3334:	2b013b03          	ld	s6,688(sp)
    3338:	8ca6                	mv	s9,s1
    333a:	884ff06f          	j	23be <stbsp_vsprintfcb+0x120>
            lead[2] = h[16];
    333e:	01084683          	lbu	a3,16(a6)
            lead[0] = 2;
    3342:	678d                	lui	a5,0x3
    3344:	0789                	addi	a5,a5,2 # 3002 <stbsp_vsprintfcb+0xd64>
    3346:	06f11423          	sh	a5,104(sp)
            lead[2] = h[16];
    334a:	06d10523          	sb	a3,106(sp)
    334e:	b891                	j	2ba2 <stbsp_vsprintfcb+0x904>
    3350:	8cea                	mv	s9,s10
    3352:	86cff06f          	j	23be <stbsp_vsprintfcb+0x120>
    3356:	4f81                	li	t6,0
    3358:	4a01                	li	s4,0
    335a:	5586                	lw	a1,96(sp)
                  *--s = stbsp__comma;
    335c:	00005f17          	auipc	t5,0x5
    3360:	bd9f4f03          	lbu	t5,-1063(t5) # 7f35 <stbsp__comma>
    3364:	0510                	addi	a2,sp,640
    3366:	0085d71b          	srliw	a4,a1,0x8
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    336a:	4305                	li	t1,1
            if (fl & STBSP__TRIPLET_COMMA) {
    336c:	040e7e93          	andi	t4,t3,64
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    3370:	0007029b          	sext.w	t0,a4
    3374:	005317bb          	sllw	a5,t1,t0
    3378:	37fd                	addiw	a5,a5,-1
    337a:	8ff5                	and	a5,a5,a3
    337c:	97c2                	add	a5,a5,a6
    337e:	0007c783          	lbu	a5,0(a5)
            n64 >>= (l >> 8);
    3382:	0056d6b3          	srl	a3,a3,t0
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    3386:	fff60a93          	addi	s5,a2,-1
    338a:	fef60fa3          	sb	a5,-1(a2)
            if (!((n64) || ((stbsp__int32)((num + STBSP__NUMSZ) - s) < pr)))
    338e:	e691                	bnez	a3,339a <stbsp_vsprintfcb+0x10fc>
    3390:	051c                	addi	a5,sp,640
    3392:	415787bb          	subw	a5,a5,s5
    3396:	0317dd63          	bge	a5,a7,33d0 <stbsp_vsprintfcb+0x1132>
            if (fl & STBSP__TRIPLET_COMMA) {
    339a:	020e8963          	beqz	t4,33cc <stbsp_vsprintfcb+0x112e>
               ++l;
    339e:	0015879b          	addiw	a5,a1,1
               if ((l & 15) == ((l >> 4) & 15)) {
    33a2:	0047d29b          	srliw	t0,a5,0x4
    33a6:	00f2c2b3          	xor	t0,t0,a5
    33aa:	00f2f293          	andi	t0,t0,15
               ++l;
    33ae:	0007859b          	sext.w	a1,a5
               if ((l & 15) == ((l >> 4) & 15)) {
    33b2:	0087d71b          	srliw	a4,a5,0x8
    33b6:	00029b63          	bnez	t0,33cc <stbsp_vsprintfcb+0x112e>
                  l &= ~15;
    33ba:	9bc1                	andi	a5,a5,-16
    33bc:	0007859b          	sext.w	a1,a5
                  *--s = stbsp__comma;
    33c0:	ffe60a93          	addi	s5,a2,-2
    33c4:	ffe60f23          	sb	t5,-2(a2)
    33c8:	0087d71b          	srliw	a4,a5,0x8
    33cc:	8656                	mv	a2,s5
    33ce:	b74d                	j	3370 <stbsp_vsprintfcb+0x10d2>
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    33d0:	0045d29b          	srliw	t0,a1,0x4
    33d4:	0f0006b7          	lui	a3,0xf000
         if (pr < (stbsp__int32)l)
    33d8:	0007871b          	sext.w	a4,a5
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    33dc:	0182929b          	slliw	t0,t0,0x18
    33e0:	00d2f2b3          	and	t0,t0,a3
         n = pr + lead[0] + tail[0] + tz;
    33e4:	00ef863b          	addw	a2,t6,a4
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    33e8:	d0be                	sw	a5,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    33ea:	8fb2                	mv	t6,a2
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    33ec:	86be                	mv	a3,a5
    33ee:	00f282bb          	addw	t0,t0,a5
         if (fw < (stbsp__int32)n)
    33f2:	835a                	mv	t1,s6
    33f4:	00cb5363          	bge	s6,a2,33fa <stbsp_vsprintfcb+0x115c>
    33f8:	8332                	mv	t1,a2
         fw -= n;
    33fa:	41f3033b          	subw	t1,t1,t6
         pr -= l;
    33fe:	9f1d                	subw	a4,a4,a5
         goto scopy;
    3400:	4f81                	li	t6,0
      tz = 0;
    3402:	4881                	li	a7,0
         goto scopy;
    3404:	fdcff06f          	j	2be0 <stbsp_vsprintfcb+0x942>
    3408:	8cda                	mv	s9,s6
    340a:	2c013a03          	ld	s4,704(sp)
    340e:	2b813a83          	ld	s5,696(sp)
    3412:	2b013b03          	ld	s6,688(sp)
    3416:	fa9fe06f          	j	23be <stbsp_vsprintfcb+0x120>
            fl |= ((sizeof(void *) == 8) ? STBSP__INTMAX : 0);
    341a:	020e6e13          	ori	t3,t3,32
            ++f;
    341e:	0485                	addi	s1,s1,1
    3420:	864ff06f          	j	2484 <stbsp_vsprintfcb+0x1e6>
               n = 0;
    3424:	4601                	li	a2,0
         s = num + 64;
    3426:	8756                	mv	a4,s5
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3428:	4511                	li	a0,4
                     *s++ = stbsp__comma;
    342a:	00170793          	addi	a5,a4,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    342e:	00030563          	beqz	t1,3438 <stbsp_vsprintfcb+0x119a>
    3432:	2585                	addiw	a1,a1,1
    3434:	10a58363          	beq	a1,a0,353a <stbsp_vsprintfcb+0x129c>
    3438:	873e                	mv	a4,a5
                     *s++ = sn[n];
    343a:	02061793          	slli	a5,a2,0x20
    343e:	9381                	srli	a5,a5,0x20
    3440:	97fa                	add	a5,a5,t5
    3442:	0007c803          	lbu	a6,0(a5)
                     ++n;
    3446:	2605                	addiw	a2,a2,1
                     *s++ = sn[n];
    3448:	ff070fa3          	sb	a6,-1(a4)
                     if (n >= l)
    344c:	fcd66fe3          	bltu	a2,a3,342a <stbsp_vsprintfcb+0x118c>
               if (n < (stbsp__uint32)dp) {
    3450:	0bd663e3          	bltu	a2,t4,3cf6 <stbsp_vsprintfcb+0x1a58>
               cs = (int)(s - (num + 64)) + (3 << 24); // cs is how many tens
    3454:	415707b3          	sub	a5,a4,s5
    3458:	030002b7          	lui	t0,0x3000
    345c:	00f282bb          	addw	t0,t0,a5
               if (pr) {
    3460:	00088a63          	beqz	a7,3474 <stbsp_vsprintfcb+0x11d6>
                  *s++ = stbsp__period;
    3464:	0cca4683          	lbu	a3,204(s4)
    3468:	00170793          	addi	a5,a4,1
         l = (stbsp__uint32)(s - (num + 64));
    346c:	415787b3          	sub	a5,a5,s5
                  *s++ = stbsp__period;
    3470:	00d70023          	sb	a3,0(a4)
         if (fl & STBSP__METRIC_SUFFIX) {
    3474:	100e7713          	andi	a4,t3,256
    3478:	86f2                	mv	a3,t3
    347a:	2c070163          	beqz	a4,373c <stbsp_vsprintfcb+0x149e>
            if (fl & STBSP__METRIC_NOSPACE)
    347e:	40ae5f9b          	sraiw	t6,t3,0xa
    3482:	001fcf93          	xori	t6,t6,1
    3486:	001fff93          	andi	t6,t6,1
            tail[1] = ' ';
    348a:	02000713          	li	a4,32
    348e:	06e108a3          	sb	a4,113(sp)
            tail[0] = idx;
    3492:	07f10823          	sb	t6,112(sp)
               if (fl >> 24) { // SI kilo is 'k', JEDEC and SI kibits are 'K'.
    3496:	018e561b          	srliw	a2,t3,0x18
    349a:	018e571b          	srliw	a4,t3,0x18
         n = pr + lead[0] + tail[0] + tz;
    349e:	000f859b          	sext.w	a1,t6
               if (fl >> 24) { // SI kilo is 'k', JEDEC and SI kibits are 'K'.
    34a2:	c225                	beqz	a2,3502 <stbsp_vsprintfcb+0x1264>
                  if (fl & STBSP__METRIC_1024)
    34a4:	001f859b          	addiw	a1,t6,1
    34a8:	0ff5f613          	zext.b	a2,a1
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    34ac:	1702                	slli	a4,a4,0x20
                  if (fl & STBSP__METRIC_1024)
    34ae:	03469513          	slli	a0,a3,0x34
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    34b2:	85b2                	mv	a1,a2
    34b4:	9301                	srli	a4,a4,0x20
                  if (fl & STBSP__METRIC_1024)
    34b6:	06055ee3          	bgez	a0,3d32 <stbsp_vsprintfcb+0x1a94>
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    34ba:	00003517          	auipc	a0,0x3
    34be:	c4e50513          	addi	a0,a0,-946 # 6108 <_GLOBAL__sub_I__ZSt3cin+0x160>
    34c2:	972a                	add	a4,a4,a0
    34c4:	00074503          	lbu	a0,0(a4)
                  if (fl & STBSP__METRIC_1024 && !(fl & STBSP__METRIC_JEDEC)) {
    34c8:	6709                	lui	a4,0x2
    34ca:	80070713          	addi	a4,a4,-2048 # 1800 <stbsp__real_to_str+0x646>
    34ce:	8f75                	and	a4,a4,a3
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    34d0:	06010813          	addi	a6,sp,96
    34d4:	22060693          	addi	a3,a2,544
    34d8:	96c2                	add	a3,a3,a6
    34da:	dea68823          	sb	a0,-528(a3) # efffdf0 <_ZSt4cerr+0xeff7030>
                  if (fl & STBSP__METRIC_1024 && !(fl & STBSP__METRIC_JEDEC)) {
    34de:	8007071b          	addiw	a4,a4,-2048
    34e2:	060715e3          	bnez	a4,3d4c <stbsp_vsprintfcb+0x1aae>
                     tail[idx + 1] = 'i';
    34e6:	2f89                	addiw	t6,t6,2
    34e8:	0ffff593          	zext.b	a1,t6
    34ec:	1094                	addi	a3,sp,96
    34ee:	22058713          	addi	a4,a1,544
    34f2:	9736                	add	a4,a4,a3
    34f4:	06900693          	li	a3,105
    34f8:	8fae                	mv	t6,a1
    34fa:	ded70823          	sb	a3,-528(a4)
                  tail[0] = idx;
    34fe:	07f10823          	sb	t6,112(sp)
         l = (stbsp__uint32)(s - (num + 64));
    3502:	0007869b          	sext.w	a3,a5
         n = pr + lead[0] + tail[0] + tz;
    3506:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    350a:	fff6c713          	not	a4,a3
    350e:	977d                	srai	a4,a4,0x3f
    3510:	8ff9                	and	a5,a5,a4
         n = pr + lead[0] + tail[0] + tz;
    3512:	00fa073b          	addw	a4,s4,a5
    3516:	9f2d                	addw	a4,a4,a1
    3518:	0117063b          	addw	a2,a4,a7
         l = (stbsp__uint32)(s - (num + 64));
    351c:	d0b6                	sw	a3,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    351e:	8732                	mv	a4,a2
         if (pr < (stbsp__int32)l)
    3520:	2781                	sext.w	a5,a5
         if ((fl & STBSP__LEFTJUST) == 0) {
    3522:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    3526:	835a                	mv	t1,s6
    3528:	00cb5363          	bge	s6,a2,352e <stbsp_vsprintfcb+0x1290>
    352c:	8332                	mv	t1,a2
         fw -= n;
    352e:	40e3033b          	subw	t1,t1,a4
         pr -= l;
    3532:	40d7873b          	subw	a4,a5,a3
         goto scopy;
    3536:	eaaff06f          	j	2be0 <stbsp_vsprintfcb+0x942>
                     *s++ = stbsp__comma;
    353a:	fe578fa3          	sb	t0,-1(a5)
    353e:	0709                	addi	a4,a4,2
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3540:	4585                	li	a1,1
    3542:	bde5                	j	343a <stbsp_vsprintfcb+0x119c>
            lead[0] = 1;
    3544:	678d                	lui	a5,0x3
    3546:	0785                	addi	a5,a5,1 # 3001 <stbsp_vsprintfcb+0xd63>
    3548:	06f11423          	sh	a5,104(sp)
    354c:	b4ed                	j	3036 <stbsp_vsprintfcb+0xd98>
            if ((f[0] != 'u') && (i64 < 0)) {
    354e:	07500693          	li	a3,117
            stbsp__int64 i64 = va_arg(va, stbsp__int64);
    3552:	000bbf03          	ld	t5,0(s7)
            if ((f[0] != 'u') && (i64 < 0)) {
    3556:	dcd78263          	beq	a5,a3,2b1a <stbsp_vsprintfcb+0x87c>
    355a:	dc0f5063          	bgez	t5,2b1a <stbsp_vsprintfcb+0x87c>
               fl |= STBSP__NEGATIVE;
    355e:	08076713          	ori	a4,a4,128
               n64 = (stbsp__uint64)-i64;
    3562:	41e00f33          	neg	t5,t5
               fl |= STBSP__NEGATIVE;
    3566:	00070e1b          	sext.w	t3,a4
    356a:	db0ff06f          	j	2b1a <stbsp_vsprintfcb+0x87c>
            lead[2] = h[0xb];
    356e:	00b84703          	lbu	a4,11(a6)
            lead[0] = 2;
    3572:	678d                	lui	a5,0x3
    3574:	0789                	addi	a5,a5,2 # 3002 <stbsp_vsprintfcb+0xd64>
    3576:	06f11423          	sh	a5,104(sp)
            lead[2] = h[0xb];
    357a:	06e10523          	sb	a4,106(sp)
    357e:	bab5                	j	2efa <stbsp_vsprintfcb+0xc5c>
      sign[0] = 1;
    3580:	678d                	lui	a5,0x3
    3582:	d0178793          	addi	a5,a5,-767 # 2d01 <stbsp_vsprintfcb+0xa63>
            fl |= STBSP__NEGATIVE;
    3586:	080e6e13          	ori	t3,t3,128
      sign[0] = 1;
    358a:	06f11423          	sh	a5,104(sp)
    358e:	468d                	li	a3,3
    3590:	4a0d                	li	s4,3
    3592:	4809                	li	a6,2
    3594:	b899                	j	2dea <stbsp_vsprintfcb+0xb4c>
      sign[0] = 1;
    3596:	6709                	lui	a4,0x2
    3598:	0705                	addi	a4,a4,1 # 2001 <_vscanf_core.constprop.0+0x6b9>
    359a:	06e11423          	sh	a4,104(sp)
    359e:	bae5                	j	2f96 <stbsp_vsprintfcb+0xcf8>
      if (((stbsp__uintptr)sn & 3) == 0)
    35a0:	0e0780e3          	beqz	a5,3e80 <stbsp_vsprintfcb+0x1be2>
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    35a4:	56fd                	li	a3,-1
    35a6:	bcf9                	j	3084 <stbsp_vsprintfcb+0xde6>
         if (fw < (stbsp__int32)n)
    35a8:	4305                	li	t1,1
    35aa:	b249                	j	2f2c <stbsp_vsprintfcb+0xc8e>
            pr = 6; // default is 6
    35ac:	4899                	li	a7,6
    35ae:	b801                	j	2dbe <stbsp_vsprintfcb+0xb20>
         h = (f[0] == 'A') ? hexu : hex;
    35b0:	00005597          	auipc	a1,0x5
    35b4:	98858593          	addi	a1,a1,-1656 # 7f38 <hexu.1>
    35b8:	ff6ff06f          	j	2dae <stbsp_vsprintfcb+0xb10>
         h = (f[0] == 'B') ? hexu : hex;
    35bc:	00005817          	auipc	a6,0x5
    35c0:	97c80813          	addi	a6,a6,-1668 # 7f38 <hexu.1>
    35c4:	b22d                	j	2eee <stbsp_vsprintfcb+0xc50>
    35c6:	80000737          	lui	a4,0x80000
    35ca:	0719                	addi	a4,a4,6 # ffffffff80000006 <_ZSt4cerr+0xffffffff7fff7246>
            pr = 6; // default is 6
    35cc:	4899                	li	a7,6
    35ce:	e4eff06f          	j	2c1c <stbsp_vsprintfcb+0x97e>
         h = (f[0] == 'E') ? hexu : hex;
    35d2:	00005317          	auipc	t1,0x5
    35d6:	96630313          	addi	t1,t1,-1690 # 7f38 <hexu.1>
    35da:	e28ff06f          	j	2c02 <stbsp_vsprintfcb+0x964>
    35de:	80000737          	lui	a4,0x80000
    35e2:	4a99                	li	s5,6
    35e4:	0715                	addi	a4,a4,5 # ffffffff80000005 <_ZSt4cerr+0xffffffff7fff7245>
            pr = 6;
    35e6:	4a19                	li	s4,6
    35e8:	ee8ff06f          	j	2cd0 <stbsp_vsprintfcb+0xa32>
         h = (f[0] == 'G') ? hexu : hex;
    35ec:	00005317          	auipc	t1,0x5
    35f0:	94c30313          	addi	t1,t1,-1716 # 7f38 <hexu.1>
    35f4:	eb6ff06f          	j	2caa <stbsp_vsprintfcb+0xa0c>
    35f8:	7be6                	ld	s7,120(sp)
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    35fa:	86c2                	mv	a3,a6
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    35fc:	8542                	mv	a0,a6
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    35fe:	88d2                	mv	a7,s4
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    3600:	8ade                	mv	s5,s7
            if (pr > (stbsp__int32)l)
    3602:	0005071b          	sext.w	a4,a0
    3606:	01175f63          	bge	a4,a7,3624 <stbsp_vsprintfcb+0x1386>
               pr = l - 1;
    360a:	fff5089b          	addiw	a7,a0,-1
         tail[0] = 0;
    360e:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    3612:	70028c63          	beqz	t0,3d2a <stbsp_vsprintfcb+0x1a8c>
      sign[0] = 1;
    3616:	670d                	lui	a4,0x3
    3618:	d0170713          	addi	a4,a4,-767 # 2d01 <stbsp_vsprintfcb+0xa63>
    361c:	06e11423          	sh	a4,104(sp)
    3620:	e3aff06f          	j	2c5a <stbsp_vsprintfcb+0x9bc>
            else if (pr)
    3624:	fe0885e3          	beqz	a7,360e <stbsp_vsprintfcb+0x1370>
               --pr; // when using %e, there is one digit before the decimal
    3628:	38fd                	addiw	a7,a7,-1
    362a:	b7d5                	j	360e <stbsp_vsprintfcb+0x1370>
      switch (f[0]) {
    362c:	0034c783          	lbu	a5,3(s1)
            f += 3;
    3630:	048d                	addi	s1,s1,3
    3632:	e53fe06f          	j	2484 <stbsp_vsprintfcb+0x1e6>
      if (!limit || *sn == 0)
    3636:	4601                	li	a2,0
    3638:	4701                	li	a4,0
    363a:	4781                	li	a5,0
         return (stbsp__uint32)(sn - s);
    363c:	bca5                	j	30b4 <stbsp_vsprintfcb+0xe16>
               pr = 1;
    363e:	4885                	li	a7,1
    3640:	cf4ff06f          	j	2b34 <stbsp_vsprintfcb+0x896>
         *s++ = sn[0];
    3644:	000ac703          	lbu	a4,0(s5)
    3648:	0ce10023          	sb	a4,192(sp)
         if (pr)
    364c:	54088563          	beqz	a7,3b96 <stbsp_vsprintfcb+0x18f8>
            *s++ = stbsp__period;
    3650:	00005617          	auipc	a2,0x5
    3654:	8e464603          	lbu	a2,-1820(a2) # 7f34 <stbsp__period>
         if ((l - 1) > (stbsp__uint32)pr)
    3658:	fff6871b          	addiw	a4,a3,-1
            *s++ = stbsp__period;
    365c:	0cc100a3          	sb	a2,193(sp)
         if ((l - 1) > (stbsp__uint32)pr)
    3660:	0008851b          	sext.w	a0,a7
    3664:	0007061b          	sext.w	a2,a4
    3668:	52c57163          	bgeu	a0,a2,3b8a <stbsp_vsprintfcb+0x18ec>
            l = pr + 1;
    366c:	0018869b          	addiw	a3,a7,1
         for (n = 1; n < l; n++)
    3670:	8746                	mv	a4,a7
    3672:	02071613          	slli	a2,a4,0x20
    3676:	9201                	srli	a2,a2,0x20
    3678:	0c210713          	addi	a4,sp,194
    367c:	0a85                	addi	s5,s5,1
    367e:	963a                	add	a2,a2,a4
            *s++ = sn[n];
    3680:	000ac583          	lbu	a1,0(s5)
    3684:	0705                	addi	a4,a4,1
         for (n = 1; n < l; n++)
    3686:	0a85                	addi	s5,s5,1
            *s++ = sn[n];
    3688:	feb70fa3          	sb	a1,-1(a4)
         for (n = 1; n < l; n++)
    368c:	fec71ae3          	bne	a4,a2,3680 <stbsp_vsprintfcb+0x13e2>
         tail[1] = h[0xe];
    3690:	00e34803          	lbu	a6,14(t1)
         dp -= 1;
    3694:	fff7871b          	addiw	a4,a5,-1
            tail[2] = '+';
    3698:	02b00593          	li	a1,43
         tail[1] = h[0xe];
    369c:	070108a3          	sb	a6,113(sp)
         if (dp < 0) {
    36a0:	00075663          	bgez	a4,36ac <stbsp_vsprintfcb+0x140e>
            dp = -dp;
    36a4:	4705                	li	a4,1
    36a6:	9f1d                	subw	a4,a4,a5
            tail[2] = '-';
    36a8:	02d00593          	li	a1,45
    36ac:	06b10923          	sb	a1,114(sp)
         n = (dp >= 100) ? 5 : 4;
    36b0:	06300793          	li	a5,99
    36b4:	4ee7d663          	bge	a5,a4,3ba0 <stbsp_vsprintfcb+0x1902>
    36b8:	4595                	li	a1,5
    36ba:	4f95                	li	t6,5
    36bc:	4e95                	li	t4,5
            tail[n] = '0' + dp % 10;
    36be:	47a9                	li	a5,10
            dp /= 10;
    36c0:	02f7433b          	divw	t1,a4,a5
            --n;
    36c4:	fffe8f1b          	addiw	t5,t4,-1
            tail[n] = '0' + dp % 10;
    36c8:	020f1293          	slli	t0,t5,0x20
    36cc:	220e8813          	addi	a6,t4,544
    36d0:	06010893          	addi	a7,sp,96
    36d4:	0202d293          	srli	t0,t0,0x20
    36d8:	01180eb3          	add	t4,a6,a7
    36dc:	22028813          	addi	a6,t0,544 # 3000220 <_ZSt4cerr+0x2ff7460>
    36e0:	011802b3          	add	t0,a6,a7
         tail[0] = (char)n;
    36e4:	07f10823          	sb	t6,112(sp)
            if (n <= 3)
    36e8:	4a0d                	li	s4,3
            tail[n] = '0' + dp % 10;
    36ea:	02f7673b          	remw	a4,a4,a5
            dp /= 10;
    36ee:	0003081b          	sext.w	a6,t1
            tail[n] = '0' + dp % 10;
    36f2:	02f36abb          	remw	s5,t1,a5
    36f6:	0307071b          	addiw	a4,a4,48
    36fa:	deee8823          	sb	a4,-528(t4)
    36fe:	030a871b          	addiw	a4,s5,48
    3702:	dee28823          	sb	a4,-528(t0)
            if (n <= 3)
    3706:	014f0a63          	beq	t5,s4,371a <stbsp_vsprintfcb+0x147c>
            dp /= 10;
    370a:	02f3483b          	divw	a6,t1,a5
            tail[n] = '0' + dp % 10;
    370e:	02f867bb          	remw	a5,a6,a5
    3712:	0307879b          	addiw	a5,a5,48
    3716:	06f109a3          	sb	a5,115(sp)
         tz = pr - (l - 1);
    371a:	2505                	addiw	a0,a0,1
         l = (stbsp__uint32)(s - (num + 64));
    371c:	0c010a93          	addi	s5,sp,192
         cs = 1 + (3 << 24); // how many tens
    3720:	030002b7          	lui	t0,0x3000
         tz = pr - (l - 1);
    3724:	40d508bb          	subw	a7,a0,a3
    3728:	d2c2                	sw	a6,100(sp)
         l = (stbsp__uint32)(s - (num + 64));
    372a:	415607b3          	sub	a5,a2,s5
         cs = 1 + (3 << 24); // how many tens
    372e:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff7241>
    3730:	bbc9                	j	3502 <stbsp_vsprintfcb+0x1264>
    3732:	fc2e                	sd	a1,56(sp)
    3734:	d0b2                	sw	a2,96(sp)
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    3736:	8536                	mv	a0,a3
    3738:	e2cff06f          	j	2d64 <stbsp_vsprintfcb+0xac6>
      flt_lead:
    373c:	4581                	li	a1,0
    373e:	4f81                	li	t6,0
    3740:	b3c9                	j	3502 <stbsp_vsprintfcb+0x1264>
         n = pr + lead[0] + tail[0] + tz;
    3742:	06814a03          	lbu	s4,104(sp)
    3746:	000a0f9b          	sext.w	t6,s4
    374a:	b901                	j	335a <stbsp_vsprintfcb+0x10bc>
         if ((f[1] == '6') && (f[2] == '4')) {
    374c:	0024c683          	lbu	a3,2(s1)
    3750:	03400713          	li	a4,52
    3754:	00e68463          	beq	a3,a4,375c <stbsp_vsprintfcb+0x14be>
    3758:	e2bfe06f          	j	2582 <stbsp_vsprintfcb+0x2e4>
      switch (f[0]) {
    375c:	0034c783          	lbu	a5,3(s1)
         fl |= ((sizeof(long) == 8) ? STBSP__INTMAX : 0);
    3760:	020e6e13          	ori	t3,t3,32
            f += 3;
    3764:	048d                	addi	s1,s1,3
    3766:	d1ffe06f          	j	2484 <stbsp_vsprintfcb+0x1e6>
         if (pr < (stbsp__int32)l)
    376a:	0006879b          	sext.w	a5,a3
         n = pr + lead[0] + tail[0] + tz;
    376e:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    3772:	fff7c793          	not	a5,a5
    3776:	97fd                	srai	a5,a5,0x3f
    3778:	8ff5                	and	a5,a5,a3
         n = pr + lead[0] + tail[0] + tz;
    377a:	00fa063b          	addw	a2,s4,a5
            s = (char *)sn;
    377e:	7ae6                	ld	s5,120(sp)
         n = pr + lead[0] + tail[0] + tz;
    3780:	8732                	mv	a4,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    3782:	001e7513          	andi	a0,t3,1
         if (pr < (stbsp__int32)l)
    3786:	2781                	sext.w	a5,a5
         if (fw < (stbsp__int32)n)
    3788:	835a                	mv	t1,s6
    378a:	00cb5363          	bge	s6,a2,3790 <stbsp_vsprintfcb+0x14f2>
    378e:	8332                	mv	t1,a2
         fw -= n;
    3790:	40e3033b          	subw	t1,t1,a4
            goto scopy;
    3794:	4f81                	li	t6,0
         pr -= l;
    3796:	40d7873b          	subw	a4,a5,a3
            cs = 0;
    379a:	4281                	li	t0,0
      tz = 0;
    379c:	4881                	li	a7,0
            goto scopy;
    379e:	c42ff06f          	j	2be0 <stbsp_vsprintfcb+0x942>
               cs = (int)(s - (num + 64)) + (3 << 24); // cs is how many tens
    37a2:	415705b3          	sub	a1,a4,s5
    37a6:	030002b7          	lui	t0,0x3000
    37aa:	00b282bb          	addw	t0,t0,a1
               l = pr - n;
    37ae:	0008859b          	sext.w	a1,a7
               if (pr)
    37b2:	42088763          	beqz	a7,3be0 <stbsp_vsprintfcb+0x1942>
                  *s++ = stbsp__period;
    37b6:	0cca4f83          	lbu	t6,204(s4)
               if ((l - dp) > (stbsp__uint32)pr)
    37ba:	41d6833b          	subw	t1,a3,t4
                  *s++ = stbsp__period;
    37be:	00280713          	addi	a4,a6,2
    37c2:	01f800a3          	sb	t6,1(a6)
               if ((l - dp) > (stbsp__uint32)pr)
    37c6:	4065ed63          	bltu	a1,t1,3be0 <stbsp_vsprintfcb+0x1942>
               while (n < l) {
    37ca:	5ed57863          	bgeu	a0,a3,3dba <stbsp_vsprintfcb+0x1b1c>
    37ce:	40c687bb          	subw	a5,a3,a2
    37d2:	37fd                	addiw	a5,a5,-1
    37d4:	1782                	slli	a5,a5,0x20
    37d6:	9381                	srli	a5,a5,0x20
    37d8:	1602                	slli	a2,a2,0x20
    37da:	9201                	srli	a2,a2,0x20
    37dc:	0785                	addi	a5,a5,1
    37de:	967a                	add	a2,a2,t5
    37e0:	97ba                	add	a5,a5,a4
                  *s++ = sn[n];
    37e2:	00064503          	lbu	a0,0(a2)
    37e6:	0705                	addi	a4,a4,1
               while (n < l) {
    37e8:	0605                	addi	a2,a2,1
                  *s++ = sn[n];
    37ea:	fea70fa3          	sb	a0,-1(a4)
               while (n < l) {
    37ee:	fef71ae3          	bne	a4,a5,37e2 <stbsp_vsprintfcb+0x1544>
               tz = pr - (l - dp);
    37f2:	01d585bb          	addw	a1,a1,t4
    37f6:	40d588bb          	subw	a7,a1,a3
         l = (stbsp__uint32)(s - (num + 64));
    37fa:	415787b3          	sub	a5,a5,s5
    37fe:	b99d                	j	3474 <stbsp_vsprintfcb+0x11d6>
            fl |= STBSP__NEGATIVE;
    3800:	080e6e13          	ori	t3,t3,128
         tail[0] = 0;
    3804:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    3808:	b539                	j	3616 <stbsp_vsprintfcb+0x1378>
         tail[0] = (char)n;
    380a:	4799                	li	a5,6
            tail[n] = '0' + dp % 10;
    380c:	06b10b23          	sb	a1,118(sp)
         tail[0] = (char)n;
    3810:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    3814:	4819                	li	a6,6
    3816:	4f99                	li	t6,6
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    3818:	4599                	li	a1,6
            dp /= 10;
    381a:	4f29                	li	t5,10
            if (n <= 3)
    381c:	428d                	li	t0,3
    381e:	87b2                	mv	a5,a2
            dp /= 10;
    3820:	03e7c7bb          	divw	a5,a5,t5
            --n;
    3824:	35fd                	addiw	a1,a1,-1
            tail[n] = '0' + dp % 10;
    3826:	02059613          	slli	a2,a1,0x20
    382a:	9201                	srli	a2,a2,0x20
    382c:	06010e93          	addi	t4,sp,96
    3830:	22060613          	addi	a2,a2,544
    3834:	9676                	add	a2,a2,t4
    3836:	03e7eebb          	remw	t4,a5,t5
    383a:	030e8e9b          	addiw	t4,t4,48
    383e:	dfd60823          	sb	t4,-528(a2)
            if (n <= 3)
    3842:	fc559fe3          	bne	a1,t0,3820 <stbsp_vsprintfcb+0x1582>
    3846:	e6aff06f          	j	2eb0 <stbsp_vsprintfcb+0xc12>
         *s++ = h[(n64 >> 60) & 15];
    384a:	93f1                	srli	a5,a5,0x3c
    384c:	97ae                	add	a5,a5,a1
    384e:	0007c303          	lbu	t1,0(a5)
         lead[1 + lead[0]] = '0';
    3852:	1088                	addi	a0,sp,96
    3854:	22080793          	addi	a5,a6,544
    3858:	97aa                	add	a5,a5,a0
    385a:	03000513          	li	a0,48
    385e:	dea78423          	sb	a0,-536(a5)
         lead[2 + lead[0]] = 'x';
    3862:	22068793          	addi	a5,a3,544
    3866:	1094                	addi	a3,sp,96
    3868:	96be                	add	a3,a3,a5
            *s++ = stbsp__period;
    386a:	00004517          	auipc	a0,0x4
    386e:	6ca54503          	lbu	a0,1738(a0) # 7f34 <stbsp__period>
         lead[2 + lead[0]] = 'x';
    3872:	07800813          	li	a6,120
         sn = s;
    3876:	0c210793          	addi	a5,sp,194
         lead[2 + lead[0]] = 'x';
    387a:	df068423          	sb	a6,-536(a3)
            *s++ = stbsp__period;
    387e:	0ca100a3          	sb	a0,193(sp)
         lead[0] += 2;
    3882:	07410423          	sb	s4,104(sp)
         *s++ = h[(n64 >> 60) & 15];
    3886:	0c610023          	sb	t1,192(sp)
         n64 <<= 4;
    388a:	0732                	slli	a4,a4,0xc
         sn = s;
    388c:	fcbe                	sd	a5,120(sp)
         n = pr;
    388e:	0008869b          	sext.w	a3,a7
         while (n--) {
    3892:	4831                	li	a6,12
         if (n > 13)
    3894:	4535                	li	a0,13
            tz = pr - n;
    3896:	40a688bb          	subw	a7,a3,a0
         while (n--) {
    389a:	02081313          	slli	t1,a6,0x20
    389e:	02035313          	srli	t1,t1,0x20
    38a2:	22030693          	addi	a3,t1,544
    38a6:	1088                	addi	a0,sp,96
    38a8:	9536                	add	a0,a0,a3
    38aa:	e4350513          	addi	a0,a0,-445
            *s++ = h[(n64 >> 60) & 15];
    38ae:	03c75693          	srli	a3,a4,0x3c
    38b2:	96ae                	add	a3,a3,a1
    38b4:	0006c683          	lbu	a3,0(a3)
    38b8:	0785                	addi	a5,a5,1
            n64 <<= 4;
    38ba:	0712                	slli	a4,a4,0x4
            *s++ = h[(n64 >> 60) & 15];
    38bc:	fed78fa3          	sb	a3,-1(a5)
         while (n--) {
    38c0:	fea797e3          	bne	a5,a0,38ae <stbsp_vsprintfcb+0x1610>
         l = (int)(s - (num + 64));
    38c4:	280d                	addiw	a6,a6,3
    38c6:	0008069b          	sext.w	a3,a6
         if (pr < (stbsp__int32)l)
    38ca:	fff6c713          	not	a4,a3
    38ce:	977d                	srai	a4,a4,0x3f
    38d0:	00e87733          	and	a4,a6,a4
         dp = (int)(s - sn);
    38d4:	0013051b          	addiw	a0,t1,1
         if (pr < (stbsp__int32)l)
    38d8:	0007031b          	sext.w	t1,a4
         pr -= l;
    38dc:	4107073b          	subw	a4,a4,a6
    38e0:	d76ff06f          	j	2e56 <stbsp_vsprintfcb+0xbb8>
                  *--s = stbsp__comma;
    38e4:	00004a17          	auipc	s4,0x4
    38e8:	584a0a13          	addi	s4,s4,1412 # 7e68 <stbsp__digitpair>
            if (n64 >= 100000000) {
    38ec:	05f5e7b7          	lui	a5,0x5f5e
    38f0:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f5533f>
               n = (stbsp__uint32)(n64 % 100000000);
    38f4:	05f5e637          	lui	a2,0x5f5e
                  *--s = stbsp__comma;
    38f8:	0cda4b83          	lbu	s7,205(s4)
            if (n64 >= 100000000) {
    38fc:	e83e                	sd	a5,16(sp)
               n = (stbsp__uint32)(n64 % 100000000);
    38fe:	10060793          	addi	a5,a2,256 # 5f5e100 <_ZSt4cerr+0x5f55340>
         l = 0;
    3902:	d082                	sw	zero,96(sp)
            if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    3904:	040e7813          	andi	a6,t3,64
    3908:	4701                	li	a4,0
    390a:	4281                	li	t0,0
         s = num + STBSP__NUMSZ;
    390c:	28010a93          	addi	s5,sp,640
               n = (stbsp__uint32)(n64 % 100000000);
    3910:	ec3e                	sd	a5,24(sp)
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    3912:	430d                	li	t1,3
                  n /= 10;
    3914:	45a9                	li	a1,10
            while (n) {
    3916:	4ea5                	li	t4,9
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    3918:	06400f93          	li	t6,100
            if (n64 >= 100000000) {
    391c:	67c2                	ld	a5,16(sp)
            char *o = s - 8;
    391e:	ff8a8513          	addi	a0,s5,-8
            if (n64 >= 100000000) {
    3922:	0fe7f763          	bgeu	a5,t5,3a10 <stbsp_vsprintfcb+0x1772>
               n = (stbsp__uint32)(n64 % 100000000);
    3926:	6662                	ld	a2,24(sp)
    3928:	02cf77b3          	remu	a5,t5,a2
               n64 /= 100000000;
    392c:	02cf5f33          	divu	t5,t5,a2
            if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    3930:	0e080463          	beqz	a6,3a18 <stbsp_vsprintfcb+0x177a>
            while (n) {
    3934:	cb85                	beqz	a5,3964 <stbsp_vsprintfcb+0x16c6>
                  *--s = stbsp__comma;
    3936:	1afd                	addi	s5,s5,-1
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    3938:	00671763          	bne	a4,t1,3946 <stbsp_vsprintfcb+0x16a8>
                  --o;
    393c:	017a8023          	sb	s7,0(s5)
    3940:	157d                	addi	a0,a0,-1
                  *--s = stbsp__comma;
    3942:	1afd                	addi	s5,s5,-1
                  l = 0;
    3944:	4701                	li	a4,0
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    3946:	2705                	addiw	a4,a4,1
                  *--s = (char)(n % 10) + '0';
    3948:	02b7f63b          	remuw	a2,a5,a1
    394c:	0306061b          	addiw	a2,a2,48
    3950:	00ca8023          	sb	a2,0(s5)
                  n /= 10;
    3954:	02b7d63b          	divuw	a2,a5,a1
            while (n) {
    3958:	00fef563          	bgeu	t4,a5,3962 <stbsp_vsprintfcb+0x16c4>
                  *--s = stbsp__comma;
    395c:	1afd                	addi	s5,s5,-1
    395e:	87b2                	mv	a5,a2
    3960:	bfe1                	j	3938 <stbsp_vsprintfcb+0x169a>
            while (n) {
    3962:	4285                	li	t0,1
            if (n64 == 0) {
    3964:	020f0063          	beqz	t5,3984 <stbsp_vsprintfcb+0x16e6>
            while (s != o)
    3968:	fb550ae3          	beq	a0,s5,391c <stbsp_vsprintfcb+0x167e>
                  *--s = stbsp__comma;
    396c:	1afd                	addi	s5,s5,-1
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    396e:	00080663          	beqz	a6,397a <stbsp_vsprintfcb+0x16dc>
    3972:	08670863          	beq	a4,t1,3a02 <stbsp_vsprintfcb+0x1764>
    3976:	2705                	addiw	a4,a4,1
    3978:	4285                	li	t0,1
                  *--s = '0';
    397a:	03000793          	li	a5,48
    397e:	00fa8023          	sb	a5,0(s5)
    3982:	b7dd                	j	3968 <stbsp_vsprintfcb+0x16ca>
    3984:	00028363          	beqz	t0,398a <stbsp_vsprintfcb+0x16ec>
    3988:	d0ba                	sw	a4,96(sp)
               if ((s[0] == '0') && (s != (num + STBSP__NUMSZ)))
    398a:	000ac703          	lbu	a4,0(s5)
    398e:	03000793          	li	a5,48
    3992:	34f70b63          	beq	a4,a5,3ce8 <stbsp_vsprintfcb+0x1a4a>
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    3996:	051c                	addi	a5,sp,640
    3998:	415786bb          	subw	a3,a5,s5
         tail[0] = 0;
    399c:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    39a0:	080e7713          	andi	a4,t3,128
    39a4:	87f2                	mv	a5,t3
    39a6:	32070863          	beqz	a4,3cd6 <stbsp_vsprintfcb+0x1a38>
    39aa:	678d                	lui	a5,0x3
    39ac:	d017879b          	addiw	a5,a5,-767 # 2d01 <stbsp_vsprintfcb+0xa63>
      sign[0] = 1;
    39b0:	06f11423          	sh	a5,104(sp)
    39b4:	4705                	li	a4,1
    39b6:	4a05                	li	s4,1
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    39b8:	d0b6                	sw	a3,96(sp)
         if (l == 0) {
    39ba:	30068163          	beqz	a3,3cbc <stbsp_vsprintfcb+0x1a1e>
         cs = l + (3 << 24);
    39be:	030002b7          	lui	t0,0x3000
    39c2:	00d282bb          	addw	t0,t0,a3
         if (pr < (stbsp__int32)l)
    39c6:	0006861b          	sext.w	a2,a3
         if (pr < 0)
    39ca:	fff8c793          	not	a5,a7
    39ce:	97fd                	srai	a5,a5,0x3f
         if (pr < (stbsp__int32)l)
    39d0:	00f8f7b3          	and	a5,a7,a5
    39d4:	0007859b          	sext.w	a1,a5
    39d8:	00c5d363          	bge	a1,a2,39de <stbsp_vsprintfcb+0x1740>
    39dc:	87b2                	mv	a5,a2
         n = pr + lead[0] + tail[0] + tz;
    39de:	00f7063b          	addw	a2,a4,a5
    39e2:	8732                	mv	a4,a2
         if (pr < (stbsp__int32)l)
    39e4:	2781                	sext.w	a5,a5
         if ((fl & STBSP__LEFTJUST) == 0) {
    39e6:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    39ea:	835a                	mv	t1,s6
    39ec:	00cb5363          	bge	s6,a2,39f2 <stbsp_vsprintfcb+0x1754>
    39f0:	8332                	mv	t1,a2
         fw -= n;
    39f2:	40e3033b          	subw	t1,t1,a4
      scopy:
    39f6:	4f81                	li	t6,0
         pr -= l;
    39f8:	40d7873b          	subw	a4,a5,a3
      tz = 0;
    39fc:	4881                	li	a7,0
      scopy:
    39fe:	9e2ff06f          	j	2be0 <stbsp_vsprintfcb+0x942>
                  *--s = stbsp__comma;
    3a02:	87de                	mv	a5,s7
                  --o;
    3a04:	157d                	addi	a0,a0,-1
                  l = 0;
    3a06:	4701                	li	a4,0
                  --o;
    3a08:	4285                	li	t0,1
    3a0a:	00fa8023          	sb	a5,0(s5)
    3a0e:	bfa9                	j	3968 <stbsp_vsprintfcb+0x16ca>
               n = (stbsp__uint32)n64;
    3a10:	000f079b          	sext.w	a5,t5
               n64 = 0;
    3a14:	4f01                	li	t5,0
    3a16:	bf29                	j	3930 <stbsp_vsprintfcb+0x1692>
    3a18:	f046                	sd	a7,32(sp)
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    3a1a:	03f7f63b          	remuw	a2,a5,t6
                  s -= 2;
    3a1e:	1af9                	addi	s5,s5,-2
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    3a20:	0007889b          	sext.w	a7,a5
    3a24:	2605                	addiw	a2,a2,1
    3a26:	0016161b          	slliw	a2,a2,0x1
    3a2a:	1602                	slli	a2,a2,0x20
    3a2c:	9201                	srli	a2,a2,0x20
    3a2e:	9652                	add	a2,a2,s4
    3a30:	00065603          	lhu	a2,0(a2)
                  n /= 100;
    3a34:	03f7d7bb          	divuw	a5,a5,t6
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    3a38:	00ca9023          	sh	a2,0(s5)
               } while (n);
    3a3c:	06300613          	li	a2,99
    3a40:	fd166de3          	bltu	a2,a7,3a1a <stbsp_vsprintfcb+0x177c>
    3a44:	7882                	ld	a7,32(sp)
            if (n64 == 0) {
    3a46:	f20f11e3          	bnez	t5,3968 <stbsp_vsprintfcb+0x16ca>
    3a4a:	bf2d                	j	3984 <stbsp_vsprintfcb+0x16e6>
                     *(stbsp__uint32 *)bf = 0x20202020;
    3a4c:	20202b37          	lui	s6,0x20202
                  stbsp__cb_buf_clamp(i, fw);
    3a50:	854a                	mv	a0,s2
                     *bf++ = ' ';
    3a52:	02000a93          	li	s5,32
                     *(stbsp__uint32 *)bf = 0x20202020;
    3a56:	020b0b13          	addi	s6,s6,32 # 20202020 <_ZSt4cerr+0x201f9260>
                  stbsp__chk_cb_buf(1);
    3a5a:	1fe00a13          	li	s4,510
                  stbsp__cb_buf_clamp(i, fw);
    3a5e:	20000b93          	li	s7,512
    3a62:	891a                	mv	s2,t1
    3a64:	0a098063          	beqz	s3,3b04 <stbsp_vsprintfcb+0x1866>
    3a68:	40a40633          	sub	a2,s0,a0
    3a6c:	40cb87bb          	subw	a5,s7,a2
    3a70:	873e                	mv	a4,a5
    3a72:	00f95363          	bge	s2,a5,3a78 <stbsp_vsprintfcb+0x17da>
    3a76:	874a                	mv	a4,s2
    3a78:	0007079b          	sext.w	a5,a4
                  fw -= i;
    3a7c:	40e9093b          	subw	s2,s2,a4
                  while (i) {
    3a80:	e799                	bnez	a5,3a8e <stbsp_vsprintfcb+0x17f0>
    3a82:	a281                	j	3bc2 <stbsp_vsprintfcb+0x1924>
                     *bf++ = ' ';
    3a84:	01540023          	sb	s5,0(s0)
                     --i;
    3a88:	37fd                	addiw	a5,a5,-1
                     *bf++ = ' ';
    3a8a:	0405                	addi	s0,s0,1
                  while (i) {
    3a8c:	cba1                	beqz	a5,3adc <stbsp_vsprintfcb+0x183e>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    3a8e:	00347713          	andi	a4,s0,3
    3a92:	fb6d                	bnez	a4,3a84 <stbsp_vsprintfcb+0x17e6>
                  while (i >= 4) {
    3a94:	470d                	li	a4,3
    3a96:	40f75363          	bge	a4,a5,3e9c <stbsp_vsprintfcb+0x1bfe>
    3a9a:	ffc7869b          	addiw	a3,a5,-4
    3a9e:	0026d79b          	srliw	a5,a3,0x2
    3aa2:	0017871b          	addiw	a4,a5,1
    3aa6:	070a                	slli	a4,a4,0x2
    3aa8:	9722                	add	a4,a4,s0
                     *(stbsp__uint32 *)bf = 0x20202020;
    3aaa:	01642023          	sw	s6,0(s0)
                     bf += 4;
    3aae:	0411                	addi	s0,s0,4
                  while (i >= 4) {
    3ab0:	fee41de3          	bne	s0,a4,3aaa <stbsp_vsprintfcb+0x180c>
    3ab4:	0027979b          	slliw	a5,a5,0x2
    3ab8:	40f687bb          	subw	a5,a3,a5
                  while (i--)
    3abc:	fff7869b          	addiw	a3,a5,-1
    3ac0:	cf91                	beqz	a5,3adc <stbsp_vsprintfcb+0x183e>
    3ac2:	9fa1                	addw	a5,a5,s0
                     *bf++ = ' ';
    3ac4:	0705                	addi	a4,a4,1
                  while (i--)
    3ac6:	0007061b          	sext.w	a2,a4
                     *bf++ = ' ';
    3aca:	ff570fa3          	sb	s5,-1(a4)
                  while (i--)
    3ace:	fec79be3          	bne	a5,a2,3ac4 <stbsp_vsprintfcb+0x1826>
    3ad2:	2685                	addiw	a3,a3,1
    3ad4:	02069793          	slli	a5,a3,0x20
    3ad8:	9381                	srli	a5,a5,0x20
    3ada:	943e                	add	s0,s0,a5
                  stbsp__chk_cb_buf(1);
    3adc:	00098f63          	beqz	s3,3afa <stbsp_vsprintfcb+0x185c>
    3ae0:	40a4063b          	subw	a2,s0,a0
    3ae4:	00ca5b63          	bge	s4,a2,3afa <stbsp_vsprintfcb+0x185c>
    3ae8:	65a2                	ld	a1,8(sp)
    3aea:	e81e                	sd	t2,16(sp)
    3aec:	00cd0d3b          	addw	s10,s10,a2
    3af0:	9982                	jalr	s3
    3af2:	80050be3          	beqz	a0,3308 <stbsp_vsprintfcb+0x106a>
    3af6:	63c2                	ld	t2,16(sp)
    3af8:	842a                	mv	s0,a0
               while (fw) {
    3afa:	f60915e3          	bnez	s2,3a64 <stbsp_vsprintfcb+0x17c6>
    3afe:	892a                	mv	s2,a0
    3b00:	f21fe06f          	j	2a20 <stbsp_vsprintfcb+0x782>
                  stbsp__cb_buf_clamp(i, fw);
    3b04:	87ca                	mv	a5,s2
                  fw -= i;
    3b06:	4901                	li	s2,0
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    3b08:	b759                	j	3a8e <stbsp_vsprintfcb+0x17f0>
   } else if (fl & STBSP__LEADINGPLUS) {
    3b0a:	002e7713          	andi	a4,t3,2
    3b0e:	94070663          	beqz	a4,2c5a <stbsp_vsprintfcb+0x9bc>
      sign[0] = 1;
    3b12:	670d                	lui	a4,0x3
    3b14:	b0170713          	addi	a4,a4,-1279 # 2b01 <stbsp_vsprintfcb+0x863>
    3b18:	06e11423          	sh	a4,104(sp)
    3b1c:	93eff06f          	j	2c5a <stbsp_vsprintfcb+0x9bc>
      if (((stbsp__uintptr)sn & 3) == 0)
    3b20:	87d6                	mv	a5,s5
   while (limit >= 4) {
    3b22:	470d                	li	a4,3
    3b24:	22d77763          	bgeu	a4,a3,3d52 <stbsp_vsprintfcb+0x1ab4>
      if ((v - 0x01010101) & (~v) & 0x80808080UL)
    3b28:	feff05b7          	lui	a1,0xfeff0
    3b2c:	80808637          	lui	a2,0x80808
    3b30:	eff5859b          	addiw	a1,a1,-257 # fffffffffefefeff <_ZSt4cerr+0xfffffffffefe713f>
    3b34:	08060613          	addi	a2,a2,128 # ffffffff80808080 <_ZSt4cerr+0xffffffff807ff2c0>
   while (limit >= 4) {
    3b38:	480d                	li	a6,3
    3b3a:	a029                	j	3b44 <stbsp_vsprintfcb+0x18a6>
      limit -= 4;
    3b3c:	36f1                	addiw	a3,a3,-4
      sn += 4;
    3b3e:	0791                	addi	a5,a5,4
   while (limit >= 4) {
    3b40:	20d87963          	bgeu	a6,a3,3d52 <stbsp_vsprintfcb+0x1ab4>
      stbsp__uint32 v = *(stbsp__uint32 *)sn;
    3b44:	4398                	lw	a4,0(a5)
      if ((v - 0x01010101) & (~v) & 0x80808080UL)
    3b46:	00b7053b          	addw	a0,a4,a1
    3b4a:	fff74713          	not	a4,a4
    3b4e:	8f69                	and	a4,a4,a0
    3b50:	8f71                	and	a4,a4,a2
    3b52:	2701                	sext.w	a4,a4
    3b54:	d765                	beqz	a4,3b3c <stbsp_vsprintfcb+0x189e>
    3b56:	02069713          	slli	a4,a3,0x20
    3b5a:	9301                	srli	a4,a4,0x20
    3b5c:	973e                	add	a4,a4,a5
    3b5e:	a021                	j	3b66 <stbsp_vsprintfcb+0x18c8>
      ++sn;
    3b60:	0785                	addi	a5,a5,1
   while (limit && *sn) {
    3b62:	00e78663          	beq	a5,a4,3b6e <stbsp_vsprintfcb+0x18d0>
    3b66:	0007c683          	lbu	a3,0(a5)
    3b6a:	fafd                	bnez	a3,3b60 <stbsp_vsprintfcb+0x18c2>
    3b6c:	873e                	mv	a4,a5
   return (stbsp__uint32)(sn - s);
    3b6e:	41570733          	sub	a4,a4,s5
    3b72:	0007069b          	sext.w	a3,a4
         if (pr < (stbsp__int32)l)
    3b76:	fff6c793          	not	a5,a3
    3b7a:	97fd                	srai	a5,a5,0x3f
    3b7c:	8f7d                	and	a4,a4,a5
    3b7e:	0007079b          	sext.w	a5,a4
         n = pr + lead[0] + tail[0] + tz;
    3b82:	863e                	mv	a2,a5
         pr -= l;
    3b84:	9f15                	subw	a4,a4,a3
   return (stbsp__uint32)(sn - s);
    3b86:	d2eff06f          	j	30b4 <stbsp_vsprintfcb+0xe16>
         for (n = 1; n < l; n++)
    3b8a:	4605                	li	a2,1
    3b8c:	aed663e3          	bltu	a2,a3,3672 <stbsp_vsprintfcb+0x13d4>
    3b90:	0c210613          	addi	a2,sp,194
    3b94:	bcf5                	j	3690 <stbsp_vsprintfcb+0x13f2>
            l = pr + 1;
    3b96:	4685                	li	a3,1
         if ((l - 1) > (stbsp__uint32)pr)
    3b98:	4501                	li	a0,0
         *s++ = sn[0];
    3b9a:	0c110613          	addi	a2,sp,193
    3b9e:	bccd                	j	3690 <stbsp_vsprintfcb+0x13f2>
    3ba0:	4591                	li	a1,4
    3ba2:	4f91                	li	t6,4
         n = (dp >= 100) ? 5 : 4;
    3ba4:	4e91                	li	t4,4
    3ba6:	be21                	j	36be <stbsp_vsprintfcb+0x1420>
    3ba8:	4a85                	li	s5,1
    3baa:	80000737          	lui	a4,0x80000
            pr = 1; // default is 6
    3bae:	4a05                	li	s4,1
    3bb0:	920ff06f          	j	2cd0 <stbsp_vsprintfcb+0xa32>
            dp = (n64) ? -1022 : 0;
    3bb4:	4601                	li	a2,0
    3bb6:	c119                	beqz	a0,3bbc <stbsp_vsprintfcb+0x191e>
    3bb8:	c0200613          	li	a2,-1022
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    3bbc:	872a                	mv	a4,a0
    3bbe:	a3aff06f          	j	2df8 <stbsp_vsprintfcb+0xb5a>
                  stbsp__chk_cb_buf(1);
    3bc2:	2601                	sext.w	a2,a2
    3bc4:	1fe00793          	li	a5,510
    3bc8:	f2c7c0e3          	blt	a5,a2,3ae8 <stbsp_vsprintfcb+0x184a>
    3bcc:	bd61                	j	3a64 <stbsp_vsprintfcb+0x17c6>
         tail[0] = (char)n;
    3bce:	4795                	li	a5,5
            tail[n] = '0' + dp % 10;
    3bd0:	06b10aa3          	sb	a1,117(sp)
         tail[0] = (char)n;
    3bd4:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    3bd8:	4815                	li	a6,5
    3bda:	4f95                	li	t6,5
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    3bdc:	4595                	li	a1,5
    3bde:	b935                	j	381a <stbsp_vsprintfcb+0x157c>
                  l = pr + dp;
    3be0:	011786bb          	addw	a3,a5,a7
    3be4:	d0b6                	sw	a3,96(sp)
    3be6:	b6d5                	j	37ca <stbsp_vsprintfcb+0x152c>
            s = (char *)"null";
    3be8:	00002a97          	auipc	s5,0x2
    3bec:	518a8a93          	addi	s5,s5,1304 # 6100 <_GLOBAL__sub_I__ZSt3cin+0x158>
    3bf0:	c80ff06f          	j	3070 <stbsp_vsprintfcb+0xdd2>
   } else if (fl & STBSP__LEADINGPLUS) {
    3bf4:	002e7793          	andi	a5,t3,2
    3bf8:	1c079c63          	bnez	a5,3dd0 <stbsp_vsprintfcb+0x1b32>
   sign[0] = 0;
    3bfc:	4689                	li	a3,2
    3bfe:	4a09                	li	s4,2
    3c00:	4805                	li	a6,1
    3c02:	9e8ff06f          	j	2dea <stbsp_vsprintfcb+0xb4c>
      sign[0] = 1;
    3c06:	670d                	lui	a4,0x3
    3c08:	b0170713          	addi	a4,a4,-1279 # 2b01 <stbsp_vsprintfcb+0x863>
    3c0c:	06e11423          	sh	a4,104(sp)
    3c10:	b86ff06f          	j	2f96 <stbsp_vsprintfcb+0xcf8>
               pr = 0;
    3c14:	4881                	li	a7,0
    3c16:	f1ffe06f          	j	2b34 <stbsp_vsprintfcb+0x896>
            *s++ = '0';
    3c1a:	03000713          	li	a4,48
    3c1e:	0ce10023          	sb	a4,192(sp)
            if (pr)
    3c22:	1a088c63          	beqz	a7,3dda <stbsp_vsprintfcb+0x1b3c>
               *s++ = stbsp__period;
    3c26:	00004717          	auipc	a4,0x4
    3c2a:	30e74703          	lbu	a4,782(a4) # 7f34 <stbsp__period>
            n = -dp;
    3c2e:	40f007bb          	negw	a5,a5
               *s++ = stbsp__period;
    3c32:	0ce100a3          	sb	a4,193(sp)
            if ((stbsp__int32)n > pr)
    3c36:	0007871b          	sext.w	a4,a5
    3c3a:	00e8d363          	bge	a7,a4,3c40 <stbsp_vsprintfcb+0x19a2>
    3c3e:	87c6                	mv	a5,a7
    3c40:	0007871b          	sext.w	a4,a5
            if ((stbsp__int32)(l + n) > pr)
    3c44:	00d7833b          	addw	t1,a5,a3
    3c48:	883a                	mv	a6,a4
            while (i) {
    3c4a:	0c210793          	addi	a5,sp,194
               *s++ = '0';
    3c4e:	03000513          	li	a0,48
            while (i) {
    3c52:	e711                	bnez	a4,3c5e <stbsp_vsprintfcb+0x19c0>
    3c54:	a271                	j	3de0 <stbsp_vsprintfcb+0x1b42>
               if ((((stbsp__uintptr)s) & 3) == 0)
    3c56:	0037f613          	andi	a2,a5,3
    3c5a:	18060563          	beqz	a2,3de4 <stbsp_vsprintfcb+0x1b46>
               *s++ = '0';
    3c5e:	85ba                	mv	a1,a4
    3c60:	00a78023          	sb	a0,0(a5)
               --i;
    3c64:	377d                	addiw	a4,a4,-1
               *s++ = '0';
    3c66:	0785                	addi	a5,a5,1
            while (i) {
    3c68:	f77d                	bnez	a4,3c56 <stbsp_vsprintfcb+0x19b8>
            if ((stbsp__int32)(l + n) > pr)
    3c6a:	0003071b          	sext.w	a4,t1
    3c6e:	4108863b          	subw	a2,a7,a6
    3c72:	00e8d563          	bge	a7,a4,3c7c <stbsp_vsprintfcb+0x19de>
               l = pr - n;
    3c76:	0006069b          	sext.w	a3,a2
    3c7a:	d0b2                	sw	a2,96(sp)
            while (i) {
    3c7c:	c68d                	beqz	a3,3ca6 <stbsp_vsprintfcb+0x1a08>
    3c7e:	7566                	ld	a0,120(sp)
    3c80:	02069813          	slli	a6,a3,0x20
    3c84:	02085813          	srli	a6,a6,0x20
    3c88:	01078eb3          	add	t4,a5,a6
    3c8c:	85aa                	mv	a1,a0
    3c8e:	873e                	mv	a4,a5
               *s++ = *sn++;
    3c90:	0005c883          	lbu	a7,0(a1)
    3c94:	0705                	addi	a4,a4,1
            while (i) {
    3c96:	0585                	addi	a1,a1,1
               *s++ = *sn++;
    3c98:	ff170fa3          	sb	a7,-1(a4)
            while (i) {
    3c9c:	ffd71ae3          	bne	a4,t4,3c90 <stbsp_vsprintfcb+0x19f2>
    3ca0:	9542                	add	a0,a0,a6
    3ca2:	97c2                	add	a5,a5,a6
    3ca4:	fcaa                	sd	a0,120(sp)
         l = (stbsp__uint32)(s - (num + 64));
    3ca6:	0c010a93          	addi	s5,sp,192
            cs = 1 + (3 << 24); // how many tens did we write (for commas below)
    3caa:	030002b7          	lui	t0,0x3000
            tz = pr - (n + l);
    3cae:	40d608bb          	subw	a7,a2,a3
         l = (stbsp__uint32)(s - (num + 64));
    3cb2:	415787b3          	sub	a5,a5,s5
            cs = 1 + (3 << 24); // how many tens did we write (for commas below)
    3cb6:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff7241>
    3cb8:	fbcff06f          	j	3474 <stbsp_vsprintfcb+0x11d6>
            *--s = '0';
    3cbc:	03000793          	li	a5,48
    3cc0:	fefa8fa3          	sb	a5,-1(s5)
            l = 1;
    3cc4:	030002b7          	lui	t0,0x3000
    3cc8:	4785                	li	a5,1
    3cca:	d0be                	sw	a5,96(sp)
            *--s = '0';
    3ccc:	1afd                	addi	s5,s5,-1
            l = 1;
    3cce:	4605                	li	a2,1
    3cd0:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff7241>
    3cd2:	4685                	li	a3,1
    3cd4:	b9dd                	j	39ca <stbsp_vsprintfcb+0x172c>
   } else if (fl & STBSP__LEADINGSPACE) {
    3cd6:	004e7713          	andi	a4,t3,4
    3cda:	e74d                	bnez	a4,3d84 <stbsp_vsprintfcb+0x1ae6>
   } else if (fl & STBSP__LEADINGPLUS) {
    3cdc:	8b89                	andi	a5,a5,2
    3cde:	efd9                	bnez	a5,3d7c <stbsp_vsprintfcb+0x1ade>
   sign[0] = 0;
    3ce0:	06010423          	sb	zero,104(sp)
    3ce4:	4a01                	li	s4,0
    3ce6:	b9c9                	j	39b8 <stbsp_vsprintfcb+0x171a>
               if ((s[0] == '0') && (s != (num + STBSP__NUMSZ)))
    3ce8:	051c                	addi	a5,sp,640
    3cea:	cafa89e3          	beq	s5,a5,399c <stbsp_vsprintfcb+0x16fe>
                  ++s;
    3cee:	0a85                	addi	s5,s5,1
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    3cf0:	415786bb          	subw	a3,a5,s5
    3cf4:	b165                	j	399c <stbsp_vsprintfcb+0x16fe>
                  n = dp - n;
    3cf6:	40ce87bb          	subw	a5,t4,a2
                  if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    3cfa:	12030e63          	beqz	t1,3e36 <stbsp_vsprintfcb+0x1b98>
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3cfe:	4511                	li	a0,4
    3d00:	03000613          	li	a2,48
                        *s++ = stbsp__comma;
    3d04:	00170693          	addi	a3,a4,1
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3d08:	00030563          	beqz	t1,3d12 <stbsp_vsprintfcb+0x1a74>
    3d0c:	2585                	addiw	a1,a1,1
    3d0e:	00a58963          	beq	a1,a0,3d20 <stbsp_vsprintfcb+0x1a82>
    3d12:	8736                	mv	a4,a3
                        --n;
    3d14:	37fd                	addiw	a5,a5,-1
    3d16:	fec70fa3          	sb	a2,-1(a4)
                  while (n) {
    3d1a:	f7ed                	bnez	a5,3d04 <stbsp_vsprintfcb+0x1a66>
    3d1c:	f38ff06f          	j	3454 <stbsp_vsprintfcb+0x11b6>
    3d20:	fe568fa3          	sb	t0,-1(a3)
                        *s++ = stbsp__comma;
    3d24:	0709                	addi	a4,a4,2
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3d26:	4585                	li	a1,1
    3d28:	b7f5                	j	3d14 <stbsp_vsprintfcb+0x1a76>
   sign[0] = 0;
    3d2a:	06010423          	sb	zero,104(sp)
    3d2e:	f1dfe06f          	j	2c4a <stbsp_vsprintfcb+0x9ac>
                     tail[idx + 1] = "_kMGT"[fl >> 24];
    3d32:	00002697          	auipc	a3,0x2
    3d36:	3de68693          	addi	a3,a3,990 # 6110 <_GLOBAL__sub_I__ZSt3cin+0x168>
    3d3a:	9736                	add	a4,a4,a3
    3d3c:	00074683          	lbu	a3,0(a4)
    3d40:	1088                	addi	a0,sp,96
    3d42:	22060713          	addi	a4,a2,544
    3d46:	972a                	add	a4,a4,a0
    3d48:	ded70823          	sb	a3,-528(a4)
                  idx++;
    3d4c:	8fb2                	mv	t6,a2
    3d4e:	fb0ff06f          	j	34fe <stbsp_vsprintfcb+0x1260>
   while (limit && *sn) {
    3d52:	e00692e3          	bnez	a3,3b56 <stbsp_vsprintfcb+0x18b8>
    3d56:	bd19                	j	3b6c <stbsp_vsprintfcb+0x18ce>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    3d58:	0008071b          	sext.w	a4,a6
    3d5c:	86c2                	mv	a3,a6
    3d5e:	88d2                	mv	a7,s4
            pr = -dp + ((pr > (stbsp__int32)l) ? (stbsp__int32) l : pr);
    3d60:	863a                	mv	a2,a4
    3d62:	00e8d363          	bge	a7,a4,3d68 <stbsp_vsprintfcb+0x1aca>
    3d66:	8646                	mv	a2,a7
    3d68:	40f608bb          	subw	a7,a2,a5
    3d6c:	814ff06f          	j	2d80 <stbsp_vsprintfcb+0xae2>
            divisor = 1000.0f;
    3d70:	00003797          	auipc	a5,0x3
    3d74:	b407b787          	fld	fa5,-1216(a5) # 68b0 <STDIN_FD+0x28>
    3d78:	dd5fe06f          	j	2b4c <stbsp_vsprintfcb+0x8ae>
    3d7c:	678d                	lui	a5,0x3
    3d7e:	b017879b          	addiw	a5,a5,-1279 # 2b01 <stbsp_vsprintfcb+0x863>
    3d82:	b13d                	j	39b0 <stbsp_vsprintfcb+0x1712>
    3d84:	6789                	lui	a5,0x2
    3d86:	2785                	addiw	a5,a5,1 # 2001 <_vscanf_core.constprop.0+0x6b9>
    3d88:	b125                	j	39b0 <stbsp_vsprintfcb+0x1712>
            *s++ = stbsp__period;
    3d8a:	00004517          	auipc	a0,0x4
    3d8e:	1aa54503          	lbu	a0,426(a0) # 7f34 <stbsp__period>
         sn = s;
    3d92:	0c210793          	addi	a5,sp,194
         n = pr;
    3d96:	0008869b          	sext.w	a3,a7
            *s++ = stbsp__period;
    3d9a:	0ca100a3          	sb	a0,193(sp)
         sn = s;
    3d9e:	fcbe                	sd	a5,120(sp)
         if (n > 13)
    3da0:	4535                	li	a0,13
         n64 <<= 4;
    3da2:	0712                	slli	a4,a4,0x4
         if (n > 13)
    3da4:	8836                	mv	a6,a3
    3da6:	00d57363          	bgeu	a0,a3,3dac <stbsp_vsprintfcb+0x1b0e>
    3daa:	4835                	li	a6,13
    3dac:	0008051b          	sext.w	a0,a6
         while (n--) {
    3db0:	387d                	addiw	a6,a6,-1
         if (pr > (stbsp__int32)n)
    3db2:	af1542e3          	blt	a0,a7,3896 <stbsp_vsprintfcb+0x15f8>
      tz = 0;
    3db6:	4881                	li	a7,0
    3db8:	b4cd                	j	389a <stbsp_vsprintfcb+0x15fc>
               while (n < l) {
    3dba:	87ba                	mv	a5,a4
    3dbc:	bc1d                	j	37f2 <stbsp_vsprintfcb+0x1554>
         tail[0] = (char)n;
    3dbe:	478d                	li	a5,3
    3dc0:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    3dc4:	06b109a3          	sb	a1,115(sp)
    3dc8:	480d                	li	a6,3
    3dca:	4f8d                	li	t6,3
    3dcc:	8e4ff06f          	j	2eb0 <stbsp_vsprintfcb+0xc12>
    3dd0:	678d                	lui	a5,0x3
    3dd2:	b017879b          	addiw	a5,a5,-1279 # 2b01 <stbsp_vsprintfcb+0x863>
    3dd6:	80aff06f          	j	2de0 <stbsp_vsprintfcb+0xb42>
            if (pr)
    3dda:	8336                	mv	t1,a3
            *s++ = '0';
    3ddc:	0c110793          	addi	a5,sp,193
            while (i) {
    3de0:	4801                	li	a6,0
    3de2:	b561                	j	3c6a <stbsp_vsprintfcb+0x19cc>
            while (i >= 4) {
    3de4:	460d                	li	a2,3
    3de6:	04e65663          	bge	a2,a4,3e32 <stbsp_vsprintfcb+0x1b94>
    3dea:	ffb5871b          	addiw	a4,a1,-5
    3dee:	0027559b          	srliw	a1,a4,0x2
    3df2:	0015861b          	addiw	a2,a1,1
    3df6:	060a                	slli	a2,a2,0x2
               *(stbsp__uint32 *)s = 0x30303030;
    3df8:	30303537          	lui	a0,0x30303
    3dfc:	963e                	add	a2,a2,a5
    3dfe:	03050513          	addi	a0,a0,48 # 30303030 <_ZSt4cerr+0x302fa270>
    3e02:	c388                	sw	a0,0(a5)
               s += 4;
    3e04:	0791                	addi	a5,a5,4
            while (i >= 4) {
    3e06:	fef61ee3          	bne	a2,a5,3e02 <stbsp_vsprintfcb+0x1b64>
    3e0a:	0025959b          	slliw	a1,a1,0x2
    3e0e:	9f0d                	subw	a4,a4,a1
            while (i) {
    3e10:	e4070de3          	beqz	a4,3c6a <stbsp_vsprintfcb+0x19cc>
               *s++ = '0';
    3e14:	03000513          	li	a0,48
            while (i) {
    3e18:	00f705bb          	addw	a1,a4,a5
               *s++ = '0';
    3e1c:	0605                	addi	a2,a2,1
            while (i) {
    3e1e:	00060e9b          	sext.w	t4,a2
               *s++ = '0';
    3e22:	fea60fa3          	sb	a0,-1(a2)
            while (i) {
    3e26:	ffd59be3          	bne	a1,t4,3e1c <stbsp_vsprintfcb+0x1b7e>
    3e2a:	1702                	slli	a4,a4,0x20
    3e2c:	9301                	srli	a4,a4,0x20
    3e2e:	97ba                	add	a5,a5,a4
    3e30:	bd2d                	j	3c6a <stbsp_vsprintfcb+0x19cc>
            while (i >= 4) {
    3e32:	863e                	mv	a2,a5
    3e34:	b7c5                	j	3e14 <stbsp_vsprintfcb+0x1b76>
                        if ((((stbsp__uintptr)s) & 3) == 0)
    3e36:	00377693          	andi	a3,a4,3
    3e3a:	ce81                	beqz	a3,3e52 <stbsp_vsprintfcb+0x1bb4>
                        *s++ = '0';
    3e3c:	03000693          	li	a3,48
    3e40:	00d70023          	sb	a3,0(a4)
                        --n;
    3e44:	37fd                	addiw	a5,a5,-1
                        *s++ = '0';
    3e46:	0705                	addi	a4,a4,1
                     while (n) {
    3e48:	e0078663          	beqz	a5,3454 <stbsp_vsprintfcb+0x11b6>
                        if ((((stbsp__uintptr)s) & 3) == 0)
    3e4c:	00377613          	andi	a2,a4,3
    3e50:	fa65                	bnez	a2,3e40 <stbsp_vsprintfcb+0x1ba2>
                     while (n >= 4) {
    3e52:	468d                	li	a3,3
    3e54:	eaf6f5e3          	bgeu	a3,a5,3cfe <stbsp_vsprintfcb+0x1a60>
    3e58:	ffc7869b          	addiw	a3,a5,-4
    3e5c:	0026d69b          	srliw	a3,a3,0x2
    3e60:	2685                	addiw	a3,a3,1
    3e62:	068a                	slli	a3,a3,0x2
                        *(stbsp__uint32 *)s = 0x30303030;
    3e64:	30303637          	lui	a2,0x30303
    3e68:	96ba                	add	a3,a3,a4
    3e6a:	03060613          	addi	a2,a2,48 # 30303030 <_ZSt4cerr+0x302fa270>
    3e6e:	c310                	sw	a2,0(a4)
                        s += 4;
    3e70:	0711                	addi	a4,a4,4
                     while (n >= 4) {
    3e72:	fed71ee3          	bne	a4,a3,3e6e <stbsp_vsprintfcb+0x1bd0>
    3e76:	8b8d                	andi	a5,a5,3
                  while (n) {
    3e78:	e80793e3          	bnez	a5,3cfe <stbsp_vsprintfcb+0x1a60>
    3e7c:	dd8ff06f          	j	3454 <stbsp_vsprintfcb+0x11b6>
      if (((stbsp__uintptr)sn & 3) == 0)
    3e80:	87d6                	mv	a5,s5
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    3e82:	56fd                	li	a3,-1
    3e84:	b155                	j	3b28 <stbsp_vsprintfcb+0x188a>
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    3e86:	5775                	li	a4,-3
    3e88:	00e7ce63          	blt	a5,a4,3ea4 <stbsp_vsprintfcb+0x1c06>
    3e8c:	f6fa4663          	blt	s4,a5,35f8 <stbsp_vsprintfcb+0x135a>
         if (dp > 0) {
    3e90:	ecf054e3          	blez	a5,3d58 <stbsp_vsprintfcb+0x1aba>
    3e94:	86c2                	mv	a3,a6
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    3e96:	4881                	li	a7,0
    3e98:	ee9fe06f          	j	2d80 <stbsp_vsprintfcb+0xae2>
                  while (i--)
    3e9c:	fff7869b          	addiw	a3,a5,-1
    3ea0:	8722                	mv	a4,s0
    3ea2:	b105                	j	3ac2 <stbsp_vsprintfcb+0x1824>
            if (pr > (stbsp__int32)l)
    3ea4:	0008071b          	sext.w	a4,a6
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    3ea8:	7ae6                	ld	s5,120(sp)
            if (pr > (stbsp__int32)l)
    3eaa:	86c2                	mv	a3,a6
    3eac:	88d2                	mv	a7,s4
    3eae:	f7475d63          	bge	a4,s4,3628 <stbsp_vsprintfcb+0x138a>
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    3eb2:	8542                	mv	a0,a6
    3eb4:	f56ff06f          	j	360a <stbsp_vsprintfcb+0x136c>

0000000000003eb8 <stbsp_sprintf>:
{
    3eb8:	715d                	addi	sp,sp,-80
   va_start(va, fmt);
    3eba:	02010313          	addi	t1,sp,32
{
    3ebe:	f032                	sd	a2,32(sp)
    3ec0:	f436                	sd	a3,40(sp)
    3ec2:	f83a                	sd	a4,48(sp)
   result = STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    3ec4:	86ae                	mv	a3,a1
    3ec6:	862a                	mv	a2,a0
    3ec8:	871a                	mv	a4,t1
    3eca:	4581                	li	a1,0
    3ecc:	4501                	li	a0,0
{
    3ece:	ec06                	sd	ra,24(sp)
    3ed0:	fc3e                	sd	a5,56(sp)
    3ed2:	e0c2                	sd	a6,64(sp)
    3ed4:	e4c6                	sd	a7,72(sp)
   va_start(va, fmt);
    3ed6:	e41a                	sd	t1,8(sp)
   result = STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    3ed8:	bc6fe0ef          	jal	229e <stbsp_vsprintfcb>
}
    3edc:	60e2                	ld	ra,24(sp)
    3ede:	6161                	addi	sp,sp,80
    3ee0:	8082                	ret

0000000000003ee2 <stbsp_vsnprintf>:
{
    3ee2:	dd010113          	addi	sp,sp,-560
    3ee6:	22813023          	sd	s0,544(sp)
    3eea:	20913c23          	sd	s1,536(sp)
    3eee:	22113423          	sd	ra,552(sp)
    3ef2:	84ae                	mv	s1,a1
    3ef4:	842a                	mv	s0,a0
    3ef6:	88b2                	mv	a7,a2
    3ef8:	8736                	mv	a4,a3
   if ( (count == 0) && !buf )
    3efa:	e591                	bnez	a1,3f06 <stbsp_vsnprintf+0x24>
    3efc:	c141                	beqz	a0,3f7c <stbsp_vsnprintf+0x9a>
      c.buf = buf;
    3efe:	e02a                	sd	a0,0(sp)
      c.count = count;
    3f00:	e402                	sd	zero,8(sp)
   return (c->count >= STB_SPRINTF_MIN) ? c->buf : c->tmp; // go direct into buffer if you can
    3f02:	0810                	addi	a2,sp,16
    3f04:	a089                	j	3f46 <stbsp_vsnprintf+0x64>
   if (len > c->count)
    3f06:	0015a593          	slti	a1,a1,1
    3f0a:	40b005bb          	negw	a1,a1
    3f0e:	8de5                	and	a1,a1,s1
      c.buf = buf;
    3f10:	e02a                	sd	a0,0(sp)
      c.count = count;
    3f12:	c426                	sw	s1,8(sp)
      c.length = 0;
    3f14:	c602                	sw	zero,12(sp)
   if (len > c->count)
    3f16:	2581                	sext.w	a1,a1
   if (len) {
    3f18:	0804d663          	bgez	s1,3fa4 <stbsp_vsnprintf+0xc2>
         s = buf;
    3f1c:	4781                	li	a5,0
      if (buf != c->buf) {
    3f1e:	c911                	beqz	a0,3f32 <stbsp_vsnprintf+0x50>
            *d++ = *s++;
    3f20:	0007c803          	lbu	a6,0(a5)
    3f24:	0785                	addi	a5,a5,1
    3f26:	00f40533          	add	a0,s0,a5
    3f2a:	ff050fa3          	sb	a6,-1(a0)
         } while (s < se);
    3f2e:	feb7e9e3          	bltu	a5,a1,3f20 <stbsp_vsnprintf+0x3e>
      c->count -= len;
    3f32:	40b486bb          	subw	a3,s1,a1
      c->buf += len;
    3f36:	95a2                	add	a1,a1,s0
    3f38:	e02e                	sd	a1,0(sp)
      c->count -= len;
    3f3a:	c436                	sw	a3,8(sp)
   return (c->count >= STB_SPRINTF_MIN) ? c->buf : c->tmp; // go direct into buffer if you can
    3f3c:	1ff00793          	li	a5,511
    3f40:	fcd7d1e3          	bge	a5,a3,3f02 <stbsp_vsnprintf+0x20>
    3f44:	6602                	ld	a2,0(sp)
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__clamp_callback, &c, stbsp__clamp_callback(0,&c,0), fmt, va );
    3f46:	86c6                	mv	a3,a7
    3f48:	858a                	mv	a1,sp
    3f4a:	ffffd517          	auipc	a0,0xffffd
    3f4e:	21650513          	addi	a0,a0,534 # 1160 <stbsp__clamp_callback>
    3f52:	b4cfe0ef          	jal	229e <stbsp_vsprintfcb>
      l = (int)( c.buf - buf );
    3f56:	6782                	ld	a5,0(sp)
    3f58:	9f81                	subw	a5,a5,s0
      if ( l >= count ) // should never be greater, only equal (or less) than count
    3f5a:	0097c463          	blt	a5,s1,3f62 <stbsp_vsnprintf+0x80>
         l = count - 1;
    3f5e:	fff4879b          	addiw	a5,s1,-1
      buf[l] = 0;
    3f62:	943e                	add	s0,s0,a5
    3f64:	00040023          	sb	zero,0(s0)
}
    3f68:	22813083          	ld	ra,552(sp)
    3f6c:	22013403          	ld	s0,544(sp)
    3f70:	4532                	lw	a0,12(sp)
    3f72:	21813483          	ld	s1,536(sp)
    3f76:	23010113          	addi	sp,sp,560
    3f7a:	8082                	ret
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__count_clamp_callback, &c, c.tmp, fmt, va );
    3f7c:	86b2                	mv	a3,a2
    3f7e:	858a                	mv	a1,sp
    3f80:	0810                	addi	a2,sp,16
    3f82:	ffffd517          	auipc	a0,0xffffd
    3f86:	22c50513          	addi	a0,a0,556 # 11ae <stbsp__count_clamp_callback>
      c.length = 0;
    3f8a:	c602                	sw	zero,12(sp)
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__count_clamp_callback, &c, c.tmp, fmt, va );
    3f8c:	b12fe0ef          	jal	229e <stbsp_vsprintfcb>
}
    3f90:	22813083          	ld	ra,552(sp)
    3f94:	22013403          	ld	s0,544(sp)
    3f98:	4532                	lw	a0,12(sp)
    3f9a:	21813483          	ld	s1,536(sp)
    3f9e:	23010113          	addi	sp,sp,560
    3fa2:	8082                	ret
    3fa4:	86a6                	mv	a3,s1
    3fa6:	bf59                	j	3f3c <stbsp_vsnprintf+0x5a>

0000000000003fa8 <stbsp_snprintf>:
{
    3fa8:	715d                	addi	sp,sp,-80
   va_start(va, fmt);
    3faa:	02810313          	addi	t1,sp,40
{
    3fae:	f436                	sd	a3,40(sp)
   result = STB_SPRINTF_DECORATE(vsnprintf)(buf, count, fmt, va);
    3fb0:	869a                	mv	a3,t1
{
    3fb2:	ec06                	sd	ra,24(sp)
    3fb4:	f83a                	sd	a4,48(sp)
    3fb6:	fc3e                	sd	a5,56(sp)
    3fb8:	e0c2                	sd	a6,64(sp)
    3fba:	e4c6                	sd	a7,72(sp)
   va_start(va, fmt);
    3fbc:	e41a                	sd	t1,8(sp)
   result = STB_SPRINTF_DECORATE(vsnprintf)(buf, count, fmt, va);
    3fbe:	f25ff0ef          	jal	3ee2 <stbsp_vsnprintf>
}
    3fc2:	60e2                	ld	ra,24(sp)
    3fc4:	6161                	addi	sp,sp,80
    3fc6:	8082                	ret

0000000000003fc8 <stbsp_vsprintf>:
{
    3fc8:	86ae                	mv	a3,a1
    3fca:	8732                	mv	a4,a2
   return STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    3fcc:	4581                	li	a1,0
    3fce:	862a                	mv	a2,a0
    3fd0:	4501                	li	a0,0
    3fd2:	accfe06f          	j	229e <stbsp_vsprintfcb>

0000000000003fd6 <sprintf>:
{
    3fd6:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    3fd8:	05010313          	addi	t1,sp,80
{
    3fdc:	e0a2                	sd	s0,64(sp)
    3fde:	fc26                	sd	s1,56(sp)
    3fe0:	842a                	mv	s0,a0
    3fe2:	e8b2                	sd	a2,80(sp)
    _vprintf_core(&ctx, format, ap);
    3fe4:	0808                	addi	a0,sp,16
    ctx.limit = size;
    3fe6:	54fd                	li	s1,-1
    _vprintf_core(&ctx, format, ap);
    3fe8:	861a                	mv	a2,t1
{
    3fea:	e486                	sd	ra,72(sp)
    3fec:	ecb6                	sd	a3,88(sp)
    3fee:	f0ba                	sd	a4,96(sp)
    3ff0:	f4be                	sd	a5,104(sp)
    3ff2:	f8c2                	sd	a6,112(sp)
    3ff4:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    3ff6:	e41a                	sd	t1,8(sp)
    ctx.buf = str;
    3ff8:	e822                	sd	s0,16(sp)
    ctx.limit = size;
    3ffa:	ec26                	sd	s1,24(sp)
    ctx.written = 0;
    3ffc:	f002                	sd	zero,32(sp)
    ctx.stream = NULL;
    3ffe:	f402                	sd	zero,40(sp)
    _vprintf_core(&ctx, format, ap);
    4000:	02c000ef          	jal	402c <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    4004:	7502                	ld	a0,32(sp)
    4006:	00950b63          	beq	a0,s1,401c <sprintf+0x46>
            str[ctx.written] = '\0';
    400a:	942a                	add	s0,s0,a0
    400c:	00040023          	sb	zero,0(s0)
}
    4010:	60a6                	ld	ra,72(sp)
    4012:	6406                	ld	s0,64(sp)
    4014:	74e2                	ld	s1,56(sp)
    4016:	2501                	sext.w	a0,a0
    4018:	6109                	addi	sp,sp,128
    401a:	8082                	ret
            str[size - 1] = '\0';
    401c:	fe040f23          	sb	zero,-2(s0)
}
    4020:	60a6                	ld	ra,72(sp)
    4022:	6406                	ld	s0,64(sp)
    4024:	74e2                	ld	s1,56(sp)
    4026:	2501                	sext.w	a0,a0
    4028:	6109                	addi	sp,sp,128
    402a:	8082                	ret

000000000000402c <_vprintf_core.constprop.0.isra.0>:
static int _vprintf_core(_OutContext *ctx, const char *format, va_list ap)
    402c:	7129                	addi	sp,sp,-320
    402e:	edee                	sd	s11,216(sp)
    4030:	fe06                	sd	ra,312(sp)
    4032:	8dae                	mv	s11,a1
    while (*p)
    4034:	0005c583          	lbu	a1,0(a1)
    4038:	cde9                	beqz	a1,4112 <_vprintf_core.constprop.0.isra.0+0xe6>
    403a:	f626                	sd	s1,296(sp)
    403c:	f24a                	sd	s2,288(sp)
    403e:	ee4e                	sd	s3,280(sp)
    4040:	e656                	sd	s5,264(sp)
    4042:	f9e2                	sd	s8,240(sp)
    4044:	fa22                	sd	s0,304(sp)
    4046:	ea52                	sd	s4,272(sp)
    4048:	e25a                	sd	s6,256(sp)
    404a:	fdde                	sd	s7,248(sp)
    404c:	f5e6                	sd	s9,232(sp)
    404e:	f1ea                	sd	s10,224(sp)
    4050:	84aa                	mv	s1,a0
    4052:	8c32                	mv	s8,a2
        if (*p != '%')
    4054:	02500a93          	li	s5,37
    4058:	49c1                	li	s3,16
    405a:	00002917          	auipc	s2,0x2
    405e:	38a90913          	addi	s2,s2,906 # 63e4 <_GLOBAL__sub_I__ZSt3cin+0x43c>
    4062:	a039                	j	4070 <_vprintf_core.constprop.0.isra.0+0x44>
                _out_char(ctx, spec);
    4064:	8526                	mv	a0,s1
    4066:	952fe0ef          	jal	21b8 <_out_char>
    while (*p)
    406a:	000dc583          	lbu	a1,0(s11)
    406e:	c5d9                	beqz	a1,40fc <_vprintf_core.constprop.0.isra.0+0xd0>
            _out_char(ctx, *p++);
    4070:	0d85                	addi	s11,s11,1
        if (*p != '%')
    4072:	ff5599e3          	bne	a1,s5,4064 <_vprintf_core.constprop.0.isra.0+0x38>
        int flag_left = 0, flag_zero = 0, flag_plus = 0, flag_space = 0, flag_hash = 0;
    4076:	4501                	li	a0,0
    4078:	4881                	li	a7,0
    407a:	4581                	li	a1,0
    407c:	4b01                	li	s6,0
    407e:	4a01                	li	s4,0
            if (*p == '-')
    4080:	000dcc83          	lbu	s9,0(s11)
    4084:	fe0c871b          	addiw	a4,s9,-32
    4088:	0ff77713          	zext.b	a4,a4
    408c:	00e9e763          	bltu	s3,a4,409a <_vprintf_core.constprop.0.isra.0+0x6e>
    4090:	070a                	slli	a4,a4,0x2
    4092:	974a                	add	a4,a4,s2
    4094:	4318                	lw	a4,0(a4)
    4096:	974a                	add	a4,a4,s2
    4098:	8702                	jr	a4
        if (*p == '*')
    409a:	02a00793          	li	a5,42
    409e:	16fc9c63          	bne	s9,a5,4216 <_vprintf_core.constprop.0.isra.0+0x1ea>
            width = va_arg(ap, int);
    40a2:	000c2403          	lw	s0,0(s8)
    40a6:	0c21                	addi	s8,s8,8
            if (width < 0)
    40a8:	00045563          	bgez	s0,40b2 <_vprintf_core.constprop.0.isra.0+0x86>
                width = -width;
    40ac:	4080043b          	negw	s0,s0
                flag_left = 1;
    40b0:	4a05                	li	s4,1
            while (*p >= '0' && *p <= '9')
    40b2:	001dcc83          	lbu	s9,1(s11)
            p++;
    40b6:	0d85                	addi	s11,s11,1
        if (*p == '.')
    40b8:	02e00793          	li	a5,46
        int precision = -1;
    40bc:	5bfd                	li	s7,-1
        if (*p == '.')
    40be:	18fc8a63          	beq	s9,a5,4252 <_vprintf_core.constprop.0.isra.0+0x226>
        if (*p == 'l')
    40c2:	06c00693          	li	a3,108
    40c6:	8666                	mv	a2,s9
    40c8:	1adc8663          	beq	s9,a3,4274 <_vprintf_core.constprop.0.isra.0+0x248>
        else if (*p == 'z')
    40cc:	07a00693          	li	a3,122
            p++;
    40d0:	0d85                	addi	s11,s11,1
        else if (*p == 'z')
    40d2:	24dc8163          	beq	s9,a3,4314 <_vprintf_core.constprop.0.isra.0+0x2e8>
        if (!spec)
    40d6:	06400693          	li	a3,100
    40da:	4adc8163          	beq	s9,a3,457c <_vprintf_core.constprop.0.isra.0+0x550>
    40de:	06400693          	li	a3,100
        int len_mod = 0;
    40e2:	4e81                	li	t4,0
    40e4:	1b96e663          	bltu	a3,s9,4290 <_vprintf_core.constprop.0.isra.0+0x264>
    40e8:	04700693          	li	a3,71
    40ec:	2796e463          	bltu	a3,s9,4354 <_vprintf_core.constprop.0.isra.0+0x328>
    40f0:	04400693          	li	a3,68
    40f4:	0596e363          	bltu	a3,s9,413a <_vprintf_core.constprop.0.isra.0+0x10e>
    40f8:	240c9363          	bnez	s9,433e <_vprintf_core.constprop.0.isra.0+0x312>
    40fc:	7452                	ld	s0,304(sp)
    40fe:	74b2                	ld	s1,296(sp)
    4100:	7912                	ld	s2,288(sp)
    4102:	69f2                	ld	s3,280(sp)
    4104:	6a52                	ld	s4,272(sp)
    4106:	6ab2                	ld	s5,264(sp)
    4108:	6b12                	ld	s6,256(sp)
    410a:	7bee                	ld	s7,248(sp)
    410c:	7c4e                	ld	s8,240(sp)
    410e:	7cae                	ld	s9,232(sp)
    4110:	7d0e                	ld	s10,224(sp)
}
    4112:	70f2                	ld	ra,312(sp)
    4114:	6dee                	ld	s11,216(sp)
    4116:	6131                	addi	sp,sp,320
    4118:	8082                	ret
            if (*p == '-')
    411a:	4585                	li	a1,1
            p++;
    411c:	0d85                	addi	s11,s11,1
            if (*p == '-')
    411e:	b78d                	j	4080 <_vprintf_core.constprop.0.isra.0+0x54>
    4120:	4505                	li	a0,1
            p++;
    4122:	0d85                	addi	s11,s11,1
        while (1)
    4124:	bfb1                	j	4080 <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    4126:	4885                	li	a7,1
            p++;
    4128:	0d85                	addi	s11,s11,1
        while (1)
    412a:	bf99                	j	4080 <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    412c:	4b05                	li	s6,1
            p++;
    412e:	0d85                	addi	s11,s11,1
        while (1)
    4130:	bf81                	j	4080 <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    4132:	4a05                	li	s4,1
            p++;
    4134:	0d85                	addi	s11,s11,1
        while (1)
    4136:	b7a9                	j	4080 <_vprintf_core.constprop.0.isra.0+0x54>
        char spec = *p++;
    4138:	8dbe                	mv	s11,a5
            fmt_tmp[f_idx++] = '%';
    413a:	02500693          	li	a3,37
    413e:	02d10823          	sb	a3,48(sp)
    4142:	4d05                	li	s10,1
            if (flag_left)
    4144:	000a0763          	beqz	s4,4152 <_vprintf_core.constprop.0.isra.0+0x126>
                fmt_tmp[f_idx++] = '-';
    4148:	02d00693          	li	a3,45
    414c:	02d108a3          	sb	a3,49(sp)
    4150:	4d09                	li	s10,2
            if (flag_zero)
    4152:	000b0c63          	beqz	s6,416a <_vprintf_core.constprop.0.isra.0+0x13e>
                fmt_tmp[f_idx++] = '0';
    4156:	0c0d0793          	addi	a5,s10,192
    415a:	0818                	addi	a4,sp,16
    415c:	00e786b3          	add	a3,a5,a4
    4160:	03000613          	li	a2,48
    4164:	f6c68023          	sb	a2,-160(a3)
    4168:	2d05                	addiw	s10,s10,1
            if (flag_plus)
    416a:	c999                	beqz	a1,4180 <_vprintf_core.constprop.0.isra.0+0x154>
                fmt_tmp[f_idx++] = '+';
    416c:	0c0d0793          	addi	a5,s10,192
    4170:	0818                	addi	a4,sp,16
    4172:	00e786b3          	add	a3,a5,a4
    4176:	02b00613          	li	a2,43
    417a:	f6c68023          	sb	a2,-160(a3)
    417e:	2d05                	addiw	s10,s10,1
            if (flag_space)
    4180:	00088c63          	beqz	a7,4198 <_vprintf_core.constprop.0.isra.0+0x16c>
                fmt_tmp[f_idx++] = ' ';
    4184:	0c0d0793          	addi	a5,s10,192
    4188:	0818                	addi	a4,sp,16
    418a:	00e786b3          	add	a3,a5,a4
    418e:	02000613          	li	a2,32
    4192:	f6c68023          	sb	a2,-160(a3)
    4196:	2d05                	addiw	s10,s10,1
            if (flag_hash)
    4198:	c919                	beqz	a0,41ae <_vprintf_core.constprop.0.isra.0+0x182>
                fmt_tmp[f_idx++] = '#';
    419a:	0c0d0793          	addi	a5,s10,192
    419e:	0818                	addi	a4,sp,16
    41a0:	00e786b3          	add	a3,a5,a4
    41a4:	02300613          	li	a2,35
    41a8:	f6c68023          	sb	a2,-160(a3)
    41ac:	2d05                	addiw	s10,s10,1
            if (width > 0)
    41ae:	03010a13          	addi	s4,sp,48
    41b2:	28804563          	bgtz	s0,443c <_vprintf_core.constprop.0.isra.0+0x410>
            if (precision >= 0)
    41b6:	260bd763          	bgez	s7,4424 <_vprintf_core.constprop.0.isra.0+0x3f8>
            fmt_tmp[f_idx++] = spec;
    41ba:	0c0d0793          	addi	a5,s10,192
    41be:	0818                	addi	a4,sp,16
    41c0:	00e78633          	add	a2,a5,a4
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    41c4:	000c3683          	ld	a3,0(s8)
            fmt_tmp[f_idx] = '\0';
    41c8:	001d071b          	addiw	a4,s10,1
    41cc:	0c070793          	addi	a5,a4,192
    41d0:	0818                	addi	a4,sp,16
            fmt_tmp[f_idx++] = spec;
    41d2:	f7960023          	sb	s9,-160(a2)
            fmt_tmp[f_idx] = '\0';
    41d6:	973e                	add	a4,a4,a5
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    41d8:	08000593          	li	a1,128
    41dc:	8652                	mv	a2,s4
    41de:	0888                	addi	a0,sp,80
            fmt_tmp[f_idx] = '\0';
    41e0:	f6070023          	sb	zero,-160(a4)
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    41e4:	dc5ff0ef          	jal	3fa8 <stbsp_snprintf>
            for (int i = 0; f_buf[i] != '\0'; i++)
    41e8:	05014583          	lbu	a1,80(sp)
            double f_val = va_arg(ap, double);
    41ec:	0c21                	addi	s8,s8,8
            for (int i = 0; f_buf[i] != '\0'; i++)
    41ee:	05110413          	addi	s0,sp,81
    41f2:	e6058ce3          	beqz	a1,406a <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, f_buf[i]);
    41f6:	8526                	mv	a0,s1
    41f8:	fc1fd0ef          	jal	21b8 <_out_char>
            for (int i = 0; f_buf[i] != '\0'; i++)
    41fc:	00044583          	lbu	a1,0(s0)
    4200:	0405                	addi	s0,s0,1
    4202:	e60584e3          	beqz	a1,406a <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, f_buf[i]);
    4206:	8526                	mv	a0,s1
    4208:	fb1fd0ef          	jal	21b8 <_out_char>
            for (int i = 0; f_buf[i] != '\0'; i++)
    420c:	00044583          	lbu	a1,0(s0)
    4210:	0405                	addi	s0,s0,1
    4212:	f1f5                	bnez	a1,41f6 <_vprintf_core.constprop.0.isra.0+0x1ca>
    4214:	bd99                	j	406a <_vprintf_core.constprop.0.isra.0+0x3e>
            while (*p >= '0' && *p <= '9')
    4216:	fd0c869b          	addiw	a3,s9,-48
    421a:	0ff6f313          	zext.b	t1,a3
    421e:	4725                	li	a4,9
        int width = 0;
    4220:	4401                	li	s0,0
            while (*p >= '0' && *p <= '9')
    4222:	4625                	li	a2,9
    4224:	e8676ae3          	bltu	a4,t1,40b8 <_vprintf_core.constprop.0.isra.0+0x8c>
    4228:	001dcc83          	lbu	s9,1(s11)
                width = width * 10 + (*p - '0');
    422c:	0024171b          	slliw	a4,s0,0x2
    4230:	9f21                	addw	a4,a4,s0
    4232:	0017171b          	slliw	a4,a4,0x1
    4236:	00e6843b          	addw	s0,a3,a4
            while (*p >= '0' && *p <= '9')
    423a:	fd0c869b          	addiw	a3,s9,-48
    423e:	0ff6f713          	zext.b	a4,a3
                p++;
    4242:	0d85                	addi	s11,s11,1
            while (*p >= '0' && *p <= '9')
    4244:	fee672e3          	bgeu	a2,a4,4228 <_vprintf_core.constprop.0.isra.0+0x1fc>
        if (*p == '.')
    4248:	02e00793          	li	a5,46
        int precision = -1;
    424c:	5bfd                	li	s7,-1
        if (*p == '.')
    424e:	e6fc9ae3          	bne	s9,a5,40c2 <_vprintf_core.constprop.0.isra.0+0x96>
            if (*p == '*')
    4252:	001dcc83          	lbu	s9,1(s11)
    4256:	02a00793          	li	a5,42
    425a:	16fc9f63          	bne	s9,a5,43d8 <_vprintf_core.constprop.0.isra.0+0x3ac>
                while (*p >= '0' && *p <= '9')
    425e:	002dcc83          	lbu	s9,2(s11)
        if (*p == 'l')
    4262:	06c00693          	li	a3,108
                precision = va_arg(ap, int);
    4266:	000c2b83          	lw	s7,0(s8)
                p++;
    426a:	0d89                	addi	s11,s11,2
                precision = va_arg(ap, int);
    426c:	0c21                	addi	s8,s8,8
        if (*p == 'l')
    426e:	8666                	mv	a2,s9
    4270:	e4dc9ee3          	bne	s9,a3,40cc <_vprintf_core.constprop.0.isra.0+0xa0>
            if (*p == 'l')
    4274:	001dcc83          	lbu	s9,1(s11)
    4278:	08cc8d63          	beq	s9,a2,4312 <_vprintf_core.constprop.0.isra.0+0x2e6>
        char spec = *p++;
    427c:	06400693          	li	a3,100
    4280:	0d89                	addi	s11,s11,2
        if (!spec)
    4282:	4cdc8c63          	beq	s9,a3,475a <_vprintf_core.constprop.0.isra.0+0x72e>
    4286:	06400693          	li	a3,100
            len_mod = 1;
    428a:	4e85                	li	t4,1
    428c:	e596fee3          	bgeu	a3,s9,40e8 <_vprintf_core.constprop.0.isra.0+0xbc>
    4290:	f9bc869b          	addiw	a3,s9,-101
    4294:	0ff6f693          	zext.b	a3,a3
    4298:	464d                	li	a2,19
    429a:	12d66863          	bltu	a2,a3,43ca <_vprintf_core.constprop.0.isra.0+0x39e>
    429e:	4e05                	li	t3,1
    42a0:	00091637          	lui	a2,0x91
    42a4:	00de1333          	sll	t1,t3,a3
    42a8:	81060613          	addi	a2,a2,-2032 # 90810 <_ZSt4cerr+0x87a50>
    42ac:	00c37633          	and	a2,t1,a2
    42b0:	1a061463          	bnez	a2,4458 <_vprintf_core.constprop.0.isra.0+0x42c>
    42b4:	00737313          	andi	t1,t1,7
    42b8:	e80311e3          	bnez	t1,413a <_vprintf_core.constprop.0.isra.0+0x10e>
    42bc:	4639                	li	a2,14
    42be:	10c69663          	bne	a3,a2,43ca <_vprintf_core.constprop.0.isra.0+0x39e>
            const char *s = va_arg(ap, char *);
    42c2:	000c3c83          	ld	s9,0(s8)
            if (!s)
    42c6:	420c8863          	beqz	s9,46f6 <_vprintf_core.constprop.0.isra.0+0x6ca>
            while (*tmp && (precision < 0 || len < precision))
    42ca:	000cc683          	lbu	a3,0(s9)
    42ce:	38068863          	beqz	a3,465e <_vprintf_core.constprop.0.isra.0+0x632>
            const char *tmp = s;
    42d2:	8666                	mv	a2,s9
            int len = 0;
    42d4:	4681                	li	a3,0
            while (*tmp && (precision < 0 || len < precision))
    42d6:	00db8863          	beq	s7,a3,42e6 <_vprintf_core.constprop.0.isra.0+0x2ba>
    42da:	00164583          	lbu	a1,1(a2)
                len++;
    42de:	2685                	addiw	a3,a3,1
                tmp++;
    42e0:	0605                	addi	a2,a2,1
            while (*tmp && (precision < 0 || len < precision))
    42e2:	f9f5                	bnez	a1,42d6 <_vprintf_core.constprop.0.isra.0+0x2aa>
    42e4:	8bb6                	mv	s7,a3
            int padding = (width > len) ? width - len : 0;
    42e6:	268bc563          	blt	s7,s0,4550 <_vprintf_core.constprop.0.isra.0+0x524>
            for (int i = 0; i < len; i++)
    42ea:	4401                	li	s0,0
    42ec:	020b8163          	beqz	s7,430e <_vprintf_core.constprop.0.isra.0+0x2e2>
    42f0:	4d01                	li	s10,0
                _out_char(ctx, s[i]);
    42f2:	01ac86b3          	add	a3,s9,s10
    42f6:	0006c583          	lbu	a1,0(a3)
    42fa:	8526                	mv	a0,s1
            for (int i = 0; i < len; i++)
    42fc:	0d05                	addi	s10,s10,1
                _out_char(ctx, s[i]);
    42fe:	ebbfd0ef          	jal	21b8 <_out_char>
            for (int i = 0; i < len; i++)
    4302:	000d069b          	sext.w	a3,s10
    4306:	ff76c6e3          	blt	a3,s7,42f2 <_vprintf_core.constprop.0.isra.0+0x2c6>
            if (flag_left)
    430a:	260a1463          	bnez	s4,4572 <_vprintf_core.constprop.0.isra.0+0x546>
            const char *s = va_arg(ap, char *);
    430e:	0c21                	addi	s8,s8,8
    4310:	bba9                	j	406a <_vprintf_core.constprop.0.isra.0+0x3e>
                p++;
    4312:	0d89                	addi	s11,s11,2
        char spec = *p++;
    4314:	000dcc83          	lbu	s9,0(s11)
    4318:	06400693          	li	a3,100
    431c:	001d8793          	addi	a5,s11,1
        if (!spec)
    4320:	3edc8063          	beq	s9,a3,4700 <_vprintf_core.constprop.0.isra.0+0x6d4>
    4324:	0796ea63          	bltu	a3,s9,4398 <_vprintf_core.constprop.0.isra.0+0x36c>
    4328:	04700693          	li	a3,71
    432c:	0f96e263          	bltu	a3,s9,4410 <_vprintf_core.constprop.0.isra.0+0x3e4>
    4330:	04400693          	li	a3,68
    4334:	e196e2e3          	bltu	a3,s9,4138 <_vprintf_core.constprop.0.isra.0+0x10c>
    4338:	dc0c82e3          	beqz	s9,40fc <_vprintf_core.constprop.0.isra.0+0xd0>
        char spec = *p++;
    433c:	8dbe                	mv	s11,a5
            _out_char(ctx, '%');
    433e:	02500593          	li	a1,37
    4342:	8526                	mv	a0,s1
    4344:	e75fd0ef          	jal	21b8 <_out_char>
            if (spec != '%')
    4348:	02500713          	li	a4,37
    434c:	d0ec8fe3          	beq	s9,a4,406a <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, spec);
    4350:	85e6                	mv	a1,s9
    4352:	bb09                	j	4064 <_vprintf_core.constprop.0.isra.0+0x38>
    4354:	05800693          	li	a3,88
    4358:	2edc8263          	beq	s9,a3,463c <_vprintf_core.constprop.0.isra.0+0x610>
    435c:	06300713          	li	a4,99
    4360:	06ec9563          	bne	s9,a4,43ca <_vprintf_core.constprop.0.isra.0+0x39e>
            char c = (char)va_arg(ap, int);
    4364:	000c4c83          	lbu	s9,0(s8)
            int padding = (width > 1) ? width - 1 : 0;
    4368:	8722                	mv	a4,s0
    436a:	00804363          	bgtz	s0,4370 <_vprintf_core.constprop.0.isra.0+0x344>
    436e:	4705                	li	a4,1
    4370:	fff7041b          	addiw	s0,a4,-1
            if (!flag_left)
    4374:	3c0a0463          	beqz	s4,473c <_vprintf_core.constprop.0.isra.0+0x710>
            _out_char(ctx, c);
    4378:	85e6                	mv	a1,s9
    437a:	8526                	mv	a0,s1
    437c:	e3dfd0ef          	jal	21b8 <_out_char>
                for (int i = 0; i < padding; i++)
    4380:	4a01                	li	s4,0
    4382:	d451                	beqz	s0,430e <_vprintf_core.constprop.0.isra.0+0x2e2>
                    _out_char(ctx, ' ');
    4384:	02000593          	li	a1,32
    4388:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    438a:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    438c:	e2dfd0ef          	jal	21b8 <_out_char>
                for (int i = 0; i < padding; i++)
    4390:	ff441ae3          	bne	s0,s4,4384 <_vprintf_core.constprop.0.isra.0+0x358>
            const char *s = va_arg(ap, char *);
    4394:	0c21                	addi	s8,s8,8
    4396:	b9d1                	j	406a <_vprintf_core.constprop.0.isra.0+0x3e>
    4398:	f9bc861b          	addiw	a2,s9,-101
    439c:	0ff67613          	zext.b	a2,a2
    43a0:	46cd                	li	a3,19
    43a2:	40c6e963          	bltu	a3,a2,47b4 <_vprintf_core.constprop.0.isra.0+0x788>
    43a6:	00091337          	lui	t1,0x91
    43aa:	4685                	li	a3,1
    43ac:	00c696b3          	sll	a3,a3,a2
    43b0:	81030313          	addi	t1,t1,-2032 # 90810 <_ZSt4cerr+0x87a50>
    43b4:	0066f333          	and	t1,a3,t1
    43b8:	34031c63          	bnez	t1,4710 <_vprintf_core.constprop.0.isra.0+0x6e4>
    43bc:	8a9d                	andi	a3,a3,7
    43be:	d6069de3          	bnez	a3,4138 <_vprintf_core.constprop.0.isra.0+0x10c>
    43c2:	46b9                	li	a3,14
        char spec = *p++;
    43c4:	8dbe                	mv	s11,a5
    43c6:	eed60ee3          	beq	a2,a3,42c2 <_vprintf_core.constprop.0.isra.0+0x296>
            _out_char(ctx, '%');
    43ca:	02500593          	li	a1,37
    43ce:	8526                	mv	a0,s1
    43d0:	de9fd0ef          	jal	21b8 <_out_char>
                _out_char(ctx, spec);
    43d4:	85e6                	mv	a1,s9
    43d6:	b179                	j	4064 <_vprintf_core.constprop.0.isra.0+0x38>
                while (*p >= '0' && *p <= '9')
    43d8:	fd0c869b          	addiw	a3,s9,-48
    43dc:	0ff6fe13          	zext.b	t3,a3
    43e0:	4625                	li	a2,9
            p++;
    43e2:	0d85                	addi	s11,s11,1
                precision = 0;
    43e4:	4b81                	li	s7,0
                while (*p >= '0' && *p <= '9')
    43e6:	4325                	li	t1,9
    43e8:	cdc66de3          	bltu	a2,t3,40c2 <_vprintf_core.constprop.0.isra.0+0x96>
                    precision = precision * 10 + (*p - '0');
    43ec:	002b961b          	slliw	a2,s7,0x2
                while (*p >= '0' && *p <= '9')
    43f0:	001dcc83          	lbu	s9,1(s11)
                    precision = precision * 10 + (*p - '0');
    43f4:	0176073b          	addw	a4,a2,s7
    43f8:	0017171b          	slliw	a4,a4,0x1
    43fc:	00e68bbb          	addw	s7,a3,a4
                while (*p >= '0' && *p <= '9')
    4400:	fd0c869b          	addiw	a3,s9,-48
    4404:	0ff6f613          	zext.b	a2,a3
                    p++;
    4408:	0d85                	addi	s11,s11,1
                while (*p >= '0' && *p <= '9')
    440a:	fec371e3          	bgeu	t1,a2,43ec <_vprintf_core.constprop.0.isra.0+0x3c0>
    440e:	b955                	j	40c2 <_vprintf_core.constprop.0.isra.0+0x96>
    4410:	05800693          	li	a3,88
    4414:	3cdc8d63          	beq	s9,a3,47ee <_vprintf_core.constprop.0.isra.0+0x7c2>
    4418:	06300713          	li	a4,99
        char spec = *p++;
    441c:	8dbe                	mv	s11,a5
    441e:	f4ec83e3          	beq	s9,a4,4364 <_vprintf_core.constprop.0.isra.0+0x338>
    4422:	b765                	j	43ca <_vprintf_core.constprop.0.isra.0+0x39e>
                f_idx += sprintf(&fmt_tmp[f_idx], ".%d", precision);
    4424:	01aa0533          	add	a0,s4,s10
    4428:	865e                	mv	a2,s7
    442a:	00002597          	auipc	a1,0x2
    442e:	d3e58593          	addi	a1,a1,-706 # 6168 <_GLOBAL__sub_I__ZSt3cin+0x1c0>
    4432:	ba5ff0ef          	jal	3fd6 <sprintf>
    4436:	00ad0d3b          	addw	s10,s10,a0
    443a:	b341                	j	41ba <_vprintf_core.constprop.0.isra.0+0x18e>
                f_idx += sprintf(&fmt_tmp[f_idx], "%d", width);
    443c:	01aa0533          	add	a0,s4,s10
    4440:	8622                	mv	a2,s0
    4442:	00002597          	auipc	a1,0x2
    4446:	d1e58593          	addi	a1,a1,-738 # 6160 <_GLOBAL__sub_I__ZSt3cin+0x1b8>
    444a:	b8dff0ef          	jal	3fd6 <sprintf>
    444e:	00ad0d3b          	addw	s10,s10,a0
            if (precision >= 0)
    4452:	d60bc4e3          	bltz	s7,41ba <_vprintf_core.constprop.0.isra.0+0x18e>
    4456:	b7f9                	j	4424 <_vprintf_core.constprop.0.isra.0+0x3f8>
            int is_signed = (spec == 'd' || spec == 'i');
    4458:	06900693          	li	a3,105
    445c:	10dc8e63          	beq	s9,a3,4578 <_vprintf_core.constprop.0.isra.0+0x54c>
                val = (uint64)va_arg(ap, void *);
    4460:	008c0793          	addi	a5,s8,8
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    4464:	07800693          	li	a3,120
                val = (uint64)va_arg(ap, void *);
    4468:	e43e                	sd	a5,8(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    446a:	38dc9d63          	bne	s9,a3,4804 <_vprintf_core.constprop.0.isra.0+0x7d8>
            else if (len_mod == 1)
    446e:	33ce8963          	beq	t4,t3,47a0 <_vprintf_core.constprop.0.isra.0+0x774>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    4472:	000c6e03          	lwu	t3,0(s8)
    4476:	85f6                	mv	a1,t4
    4478:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    447a:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    447c:	00002f97          	auipc	t6,0x2
    4480:	cb4f8f93          	addi	t6,t6,-844 # 6130 <_GLOBAL__sub_I__ZSt3cin+0x188>
    if (val == 0)
    4484:	120e0363          	beqz	t3,45aa <_vprintf_core.constprop.0.isra.0+0x57e>
    4488:	01010293          	addi	t0,sp,16
                    sign_char = '-';
    448c:	8616                	mv	a2,t0
    448e:	86f2                	mv	a3,t3
        buf[i++] = digits[val % base];
    4490:	0266f8b3          	remu	a7,a3,t1
    4494:	8f32                	mv	t5,a2
    while (val != 0)
    4496:	0605                	addi	a2,a2,1
    4498:	8eb6                	mv	t4,a3
        buf[i++] = digits[val % base];
    449a:	98fe                	add	a7,a7,t6
    449c:	0008c883          	lbu	a7,0(a7)
        val /= base;
    44a0:	0266d6b3          	divu	a3,a3,t1
        buf[i++] = digits[val % base];
    44a4:	ff160fa3          	sb	a7,-1(a2)
    while (val != 0)
    44a8:	fe6ef4e3          	bgeu	t4,t1,4490 <_vprintf_core.constprop.0.isra.0+0x464>
        buf[i++] = digits[val % base];
    44ac:	405f0f3b          	subw	t5,t5,t0
    44b0:	2f05                	addiw	t5,t5,1
            if (precision >= 0)
    44b2:	100bc363          	bltz	s7,45b8 <_vprintf_core.constprop.0.isra.0+0x58c>
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    44b6:	1d7f4d63          	blt	t5,s7,4690 <_vprintf_core.constprop.0.isra.0+0x664>
            if (precision == 0 && val == 0)
    44ba:	340b9163          	bnez	s7,47fc <_vprintf_core.constprop.0.isra.0+0x7d0>
    44be:	200e0763          	beqz	t3,46cc <_vprintf_core.constprop.0.isra.0+0x6a0>
            for (int i = digit_len - 1; i >= 0; i--)
    44c2:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    44c6:	07000693          	li	a3,112
            for (int i = digit_len - 1; i >= 0; i--)
    44ca:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    44cc:	28dc8e63          	beq	s9,a3,4768 <_vprintf_core.constprop.0.isra.0+0x73c>
    44d0:	2a051663          	bnez	a0,477c <_vprintf_core.constprop.0.isra.0+0x750>
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    44d4:	00bf05bb          	addw	a1,t5,a1
    44d8:	8d52                	mv	s10,s4
    44da:	4b01                	li	s6,0
            char *prefix_str = NULL;
    44dc:	4c81                	li	s9,0
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    44de:	1085d263          	bge	a1,s0,45e2 <_vprintf_core.constprop.0.isra.0+0x5b6>
    44e2:	9c0d                	subw	s0,s0,a1
            if (!flag_left && !flag_zero)
    44e4:	100d0a63          	beqz	s10,45f8 <_vprintf_core.constprop.0.isra.0+0x5cc>
            if (sign_char)
    44e8:	6782                	ld	a5,0(sp)
    44ea:	10079263          	bnez	a5,45ee <_vprintf_core.constprop.0.isra.0+0x5c2>
            if (prefix_str)
    44ee:	000c8c63          	beqz	s9,4506 <_vprintf_core.constprop.0.isra.0+0x4da>
                _out_char(ctx, prefix_str[0]);
    44f2:	000cc583          	lbu	a1,0(s9)
    44f6:	8526                	mv	a0,s1
    44f8:	cc1fd0ef          	jal	21b8 <_out_char>
                _out_char(ctx, prefix_str[1]);
    44fc:	001cc583          	lbu	a1,1(s9)
    4500:	8526                	mv	a0,s1
    4502:	cb7fd0ef          	jal	21b8 <_out_char>
            int total_zeros = prec_zeros + ((flag_zero && !flag_left) ? padding : 0);
    4506:	180b0263          	beqz	s6,468a <_vprintf_core.constprop.0.isra.0+0x65e>
    450a:	100a1863          	bnez	s4,461a <_vprintf_core.constprop.0.isra.0+0x5ee>
    450e:	008b8bbb          	addw	s7,s7,s0
            for (int i = 0; i < total_zeros; i++)
    4512:	2a0b8363          	beqz	s7,47b8 <_vprintf_core.constprop.0.isra.0+0x78c>
    4516:	4c81                	li	s9,0
                _out_char(ctx, '0');
    4518:	03000593          	li	a1,48
    451c:	8526                	mv	a0,s1
            for (int i = 0; i < total_zeros; i++)
    451e:	2c85                	addiw	s9,s9,1
                _out_char(ctx, '0');
    4520:	c99fd0ef          	jal	21b8 <_out_char>
            for (int i = 0; i < total_zeros; i++)
    4524:	ff7c9ae3          	bne	s9,s7,4518 <_vprintf_core.constprop.0.isra.0+0x4ec>
            for (int i = digit_len - 1; i >= 0; i--)
    4528:	57fd                	li	a5,-1
    452a:	00fc0f63          	beq	s8,a5,4548 <_vprintf_core.constprop.0.isra.0+0x51c>
    452e:	01010c93          	addi	s9,sp,16
    4532:	9ce2                	add	s9,s9,s8
    4534:	00f10c13          	addi	s8,sp,15
                _out_char(ctx, num_buf[i]);
    4538:	000cc583          	lbu	a1,0(s9)
    453c:	8526                	mv	a0,s1
            for (int i = digit_len - 1; i >= 0; i--)
    453e:	1cfd                	addi	s9,s9,-1
                _out_char(ctx, num_buf[i]);
    4540:	c79fd0ef          	jal	21b8 <_out_char>
            for (int i = digit_len - 1; i >= 0; i--)
    4544:	ff9c1ae3          	bne	s8,s9,4538 <_vprintf_core.constprop.0.isra.0+0x50c>
            if (flag_left)
    4548:	0c0a1e63          	bnez	s4,4624 <_vprintf_core.constprop.0.isra.0+0x5f8>
        char spec = *p++;
    454c:	6c22                	ld	s8,8(sp)
    454e:	be31                	j	406a <_vprintf_core.constprop.0.isra.0+0x3e>
            int padding = (width > len) ? width - len : 0;
    4550:	4174043b          	subw	s0,s0,s7
            if (!flag_left)
    4554:	100a0a63          	beqz	s4,4668 <_vprintf_core.constprop.0.isra.0+0x63c>
            for (int i = 0; i < len; i++)
    4558:	d80b9ce3          	bnez	s7,42f0 <_vprintf_core.constprop.0.isra.0+0x2c4>
                for (int i = 0; i < padding; i++)
    455c:	4a01                	li	s4,0
                    _out_char(ctx, ' ');
    455e:	02000593          	li	a1,32
    4562:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    4564:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    4566:	c53fd0ef          	jal	21b8 <_out_char>
                for (int i = 0; i < padding; i++)
    456a:	ff441ae3          	bne	s0,s4,455e <_vprintf_core.constprop.0.isra.0+0x532>
            const char *s = va_arg(ap, char *);
    456e:	0c21                	addi	s8,s8,8
    4570:	bced                	j	406a <_vprintf_core.constprop.0.isra.0+0x3e>
                for (int i = 0; i < padding; i++)
    4572:	f46d                	bnez	s0,455c <_vprintf_core.constprop.0.isra.0+0x530>
            const char *s = va_arg(ap, char *);
    4574:	0c21                	addi	s8,s8,8
    4576:	bcd5                	j	406a <_vprintf_core.constprop.0.isra.0+0x3e>
            else if (len_mod == 1)
    4578:	1fce8163          	beq	t4,t3,475a <_vprintf_core.constprop.0.isra.0+0x72e>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    457c:	000c2e03          	lw	t3,0(s8)
    4580:	008c0793          	addi	a5,s8,8
    4584:	e43e                	sd	a5,8(sp)
                int64 sval = (int64)val;
    4586:	86f2                	mv	a3,t3
                if (sval < 0)
    4588:	1406cb63          	bltz	a3,46de <_vprintf_core.constprop.0.isra.0+0x6b2>
                    sign_char = '+';
    458c:	02b00793          	li	a5,43
    4590:	e03e                	sd	a5,0(sp)
                else if (flag_plus)
    4592:	e589                	bnez	a1,459c <_vprintf_core.constprop.0.isra.0+0x570>
                else if (flag_space)
    4594:	00589793          	slli	a5,a7,0x5
    4598:	e03e                	sd	a5,0(sp)
    459a:	85c6                	mv	a1,a7
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    459c:	4329                	li	t1,10
    459e:	00002f97          	auipc	t6,0x2
    45a2:	b92f8f93          	addi	t6,t6,-1134 # 6130 <_GLOBAL__sub_I__ZSt3cin+0x188>
    if (val == 0)
    45a6:	ee0e11e3          	bnez	t3,4488 <_vprintf_core.constprop.0.isra.0+0x45c>
        buf[i++] = '0';
    45aa:	03000693          	li	a3,48
    45ae:	00d10823          	sb	a3,16(sp)
        return i;
    45b2:	4f05                	li	t5,1
            if (precision >= 0)
    45b4:	f00bd1e3          	bgez	s7,44b6 <_vprintf_core.constprop.0.isra.0+0x48a>
            for (int i = digit_len - 1; i >= 0; i--)
    45b8:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    45bc:	07000893          	li	a7,112
            if (!flag_left && !flag_zero)
    45c0:	016a6d33          	or	s10,s4,s6
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    45c4:	4b81                	li	s7,0
            for (int i = digit_len - 1; i >= 0; i--)
    45c6:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    45c8:	0d1c9f63          	bne	s9,a7,46a6 <_vprintf_core.constprop.0.isra.0+0x67a>
                prefix_str = (spec == 'X') ? "0X" : "0x";
    45cc:	00002c97          	auipc	s9,0x2
    45d0:	b7cc8c93          	addi	s9,s9,-1156 # 6148 <_GLOBAL__sub_I__ZSt3cin+0x1a0>
                prefix_len += 2;
    45d4:	2589                	addiw	a1,a1,2
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    45d6:	017585bb          	addw	a1,a1,s7
    45da:	01e585bb          	addw	a1,a1,t5
    45de:	f085c2e3          	blt	a1,s0,44e2 <_vprintf_core.constprop.0.isra.0+0x4b6>
            if (!flag_left && !flag_zero)
    45e2:	080d0f63          	beqz	s10,4680 <_vprintf_core.constprop.0.isra.0+0x654>
            if (sign_char)
    45e6:	6782                	ld	a5,0(sp)
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    45e8:	4401                	li	s0,0
            if (sign_char)
    45ea:	f00782e3          	beqz	a5,44ee <_vprintf_core.constprop.0.isra.0+0x4c2>
                _out_char(ctx, sign_char);
    45ee:	6582                	ld	a1,0(sp)
    45f0:	8526                	mv	a0,s1
    45f2:	bc7fd0ef          	jal	21b8 <_out_char>
    45f6:	bde5                	j	44ee <_vprintf_core.constprop.0.isra.0+0x4c2>
                    _out_char(ctx, ' ');
    45f8:	02000593          	li	a1,32
    45fc:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    45fe:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    4600:	bb9fd0ef          	jal	21b8 <_out_char>
                for (int i = 0; i < padding; i++)
    4604:	efa402e3          	beq	s0,s10,44e8 <_vprintf_core.constprop.0.isra.0+0x4bc>
                    _out_char(ctx, ' ');
    4608:	02000593          	li	a1,32
    460c:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    460e:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    4610:	ba9fd0ef          	jal	21b8 <_out_char>
                for (int i = 0; i < padding; i++)
    4614:	ffa412e3          	bne	s0,s10,45f8 <_vprintf_core.constprop.0.isra.0+0x5cc>
    4618:	bdc1                	j	44e8 <_vprintf_core.constprop.0.isra.0+0x4bc>
            for (int i = 0; i < total_zeros; i++)
    461a:	ee0b9ee3          	bnez	s7,4516 <_vprintf_core.constprop.0.isra.0+0x4ea>
            for (int i = digit_len - 1; i >= 0; i--)
    461e:	577d                	li	a4,-1
    4620:	f0ec17e3          	bne	s8,a4,452e <_vprintf_core.constprop.0.isra.0+0x502>
                for (int i = 0; i < padding; i++)
    4624:	d405                	beqz	s0,454c <_vprintf_core.constprop.0.isra.0+0x520>
    4626:	4a01                	li	s4,0
                    _out_char(ctx, ' ');
    4628:	02000593          	li	a1,32
    462c:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    462e:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    4630:	b89fd0ef          	jal	21b8 <_out_char>
                for (int i = 0; i < padding; i++)
    4634:	fe8a1ae3          	bne	s4,s0,4628 <_vprintf_core.constprop.0.isra.0+0x5fc>
        char spec = *p++;
    4638:	6c22                	ld	s8,8(sp)
    463a:	bc05                	j	406a <_vprintf_core.constprop.0.isra.0+0x3e>
                val = (uint64)va_arg(ap, void *);
    463c:	008c0793          	addi	a5,s8,8
    4640:	e43e                	sd	a5,8(sp)
            else if (len_mod == 1)
    4642:	180e9163          	bnez	t4,47c4 <_vprintf_core.constprop.0.isra.0+0x798>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    4646:	000c6e03          	lwu	t3,0(s8)
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    464a:	4581                	li	a1,0
    464c:	05800c93          	li	s9,88
    4650:	e002                	sd	zero,0(sp)
    4652:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    4654:	00002f97          	auipc	t6,0x2
    4658:	ac4f8f93          	addi	t6,t6,-1340 # 6118 <_GLOBAL__sub_I__ZSt3cin+0x170>
    465c:	b525                	j	4484 <_vprintf_core.constprop.0.isra.0+0x458>
            int padding = (width > len) ? width - len : 0;
    465e:	ca8058e3          	blez	s0,430e <_vprintf_core.constprop.0.isra.0+0x2e2>
            if (!flag_left)
    4662:	ee0a1de3          	bnez	s4,455c <_vprintf_core.constprop.0.isra.0+0x530>
            int len = 0;
    4666:	4b81                	li	s7,0
                for (int i = 0; i < padding; i++)
    4668:	4d01                	li	s10,0
                    _out_char(ctx, ' ');
    466a:	02000593          	li	a1,32
    466e:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    4670:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    4672:	b47fd0ef          	jal	21b8 <_out_char>
                for (int i = 0; i < padding; i++)
    4676:	fe8d1ae3          	bne	s10,s0,466a <_vprintf_core.constprop.0.isra.0+0x63e>
            for (int i = 0; i < len; i++)
    467a:	c60b9be3          	bnez	s7,42f0 <_vprintf_core.constprop.0.isra.0+0x2c4>
    467e:	b941                	j	430e <_vprintf_core.constprop.0.isra.0+0x2e2>
            if (sign_char)
    4680:	6782                	ld	a5,0(sp)
    4682:	4401                	li	s0,0
    4684:	f7ad                	bnez	a5,45ee <_vprintf_core.constprop.0.isra.0+0x5c2>
            if (prefix_str)
    4686:	e60c96e3          	bnez	s9,44f2 <_vprintf_core.constprop.0.isra.0+0x4c6>
            for (int i = 0; i < total_zeros; i++)
    468a:	e80b96e3          	bnez	s7,4516 <_vprintf_core.constprop.0.isra.0+0x4ea>
    468e:	bd69                	j	4528 <_vprintf_core.constprop.0.isra.0+0x4fc>
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    4690:	41eb8bbb          	subw	s7,s7,t5
    4694:	8d52                	mv	s10,s4
    4696:	4b01                	li	s6,0
            for (int i = digit_len - 1; i >= 0; i--)
    4698:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    469c:	07000893          	li	a7,112
            for (int i = digit_len - 1; i >= 0; i--)
    46a0:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    46a2:	f31c85e3          	beq	s9,a7,45cc <_vprintf_core.constprop.0.isra.0+0x5a0>
    46a6:	cd09                	beqz	a0,46c0 <_vprintf_core.constprop.0.isra.0+0x694>
    46a8:	000e0c63          	beqz	t3,46c0 <_vprintf_core.constprop.0.isra.0+0x694>
    46ac:	07800513          	li	a0,120
            for (int i = digit_len - 1; i >= 0; i--)
    46b0:	00060c1b          	sext.w	s8,a2
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    46b4:	f0ac8ce3          	beq	s9,a0,45cc <_vprintf_core.constprop.0.isra.0+0x5a0>
    46b8:	05800613          	li	a2,88
    46bc:	12cc8463          	beq	s9,a2,47e4 <_vprintf_core.constprop.0.isra.0+0x7b8>
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    46c0:	00bb85bb          	addw	a1,s7,a1
    46c4:	01e585bb          	addw	a1,a1,t5
            char *prefix_str = NULL;
    46c8:	4c81                	li	s9,0
    46ca:	bd11                	j	44de <_vprintf_core.constprop.0.isra.0+0x4b2>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    46cc:	07000693          	li	a3,112
    46d0:	8d52                	mv	s10,s4
    46d2:	4b01                	li	s6,0
    46d4:	08dc8d63          	beq	s9,a3,476e <_vprintf_core.constprop.0.isra.0+0x742>
    46d8:	5c7d                	li	s8,-1
            char *prefix_str = NULL;
    46da:	4c81                	li	s9,0
    46dc:	b509                	j	44de <_vprintf_core.constprop.0.isra.0+0x4b2>
                    sign_char = '-';
    46de:	02d00793          	li	a5,45
                    val = (uint64)(-sval);
    46e2:	40d00e33          	neg	t3,a3
    46e6:	4585                	li	a1,1
    46e8:	4329                	li	t1,10
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    46ea:	00002f97          	auipc	t6,0x2
    46ee:	a46f8f93          	addi	t6,t6,-1466 # 6130 <_GLOBAL__sub_I__ZSt3cin+0x188>
                    sign_char = '-';
    46f2:	e03e                	sd	a5,0(sp)
    46f4:	bb51                	j	4488 <_vprintf_core.constprop.0.isra.0+0x45c>
                s = "(null)";
    46f6:	00002c97          	auipc	s9,0x2
    46fa:	a62c8c93          	addi	s9,s9,-1438 # 6158 <_GLOBAL__sub_I__ZSt3cin+0x1b0>
    46fe:	bed1                	j	42d2 <_vprintf_core.constprop.0.isra.0+0x2a6>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    4700:	000c3683          	ld	a3,0(s8)
    4704:	008c0713          	addi	a4,s8,8
    4708:	e43a                	sd	a4,8(sp)
    470a:	8dbe                	mv	s11,a5
    470c:	8e36                	mv	t3,a3
            if (is_signed)
    470e:	bdad                	j	4588 <_vprintf_core.constprop.0.isra.0+0x55c>
            int is_signed = (spec == 'd' || spec == 'i');
    4710:	06900693          	li	a3,105
    4714:	fedc86e3          	beq	s9,a3,4700 <_vprintf_core.constprop.0.isra.0+0x6d4>
                val = (uint64)va_arg(ap, void *);
    4718:	008c0713          	addi	a4,s8,8
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    471c:	07800693          	li	a3,120
                val = (uint64)va_arg(ap, void *);
    4720:	e43a                	sd	a4,8(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    4722:	06dc9063          	bne	s9,a3,4782 <_vprintf_core.constprop.0.isra.0+0x756>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    4726:	000c3e03          	ld	t3,0(s8)
    472a:	8dbe                	mv	s11,a5
    472c:	4581                	li	a1,0
    472e:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    4730:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    4732:	00002f97          	auipc	t6,0x2
    4736:	9fef8f93          	addi	t6,t6,-1538 # 6130 <_GLOBAL__sub_I__ZSt3cin+0x188>
    473a:	b3a9                	j	4484 <_vprintf_core.constprop.0.isra.0+0x458>
                for (int i = 0; i < padding; i++)
    473c:	c809                	beqz	s0,474e <_vprintf_core.constprop.0.isra.0+0x722>
                    _out_char(ctx, ' ');
    473e:	02000593          	li	a1,32
    4742:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    4744:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    4746:	a73fd0ef          	jal	21b8 <_out_char>
                for (int i = 0; i < padding; i++)
    474a:	ff441ae3          	bne	s0,s4,473e <_vprintf_core.constprop.0.isra.0+0x712>
            _out_char(ctx, c);
    474e:	85e6                	mv	a1,s9
    4750:	8526                	mv	a0,s1
    4752:	a67fd0ef          	jal	21b8 <_out_char>
            const char *s = va_arg(ap, char *);
    4756:	0c21                	addi	s8,s8,8
    4758:	ba09                	j	406a <_vprintf_core.constprop.0.isra.0+0x3e>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    475a:	000c3683          	ld	a3,0(s8)
    475e:	008c0793          	addi	a5,s8,8
    4762:	e43e                	sd	a5,8(sp)
    4764:	8e36                	mv	t3,a3
            if (is_signed)
    4766:	b50d                	j	4588 <_vprintf_core.constprop.0.isra.0+0x55c>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    4768:	8d52                	mv	s10,s4
    476a:	4b01                	li	s6,0
    476c:	b585                	j	45cc <_vprintf_core.constprop.0.isra.0+0x5a0>
                digit_len = 0;
    476e:	4f01                	li	t5,0
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    4770:	5c7d                	li	s8,-1
                prefix_str = (spec == 'X') ? "0X" : "0x";
    4772:	00002c97          	auipc	s9,0x2
    4776:	9d6c8c93          	addi	s9,s9,-1578 # 6148 <_GLOBAL__sub_I__ZSt3cin+0x1a0>
    477a:	bda9                	j	45d4 <_vprintf_core.constprop.0.isra.0+0x5a8>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    477c:	8d52                	mv	s10,s4
    477e:	4b01                	li	s6,0
    4780:	b735                	j	46ac <_vprintf_core.constprop.0.isra.0+0x680>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    4782:	07000693          	li	a3,112
    4786:	04dc8263          	beq	s9,a3,47ca <_vprintf_core.constprop.0.isra.0+0x79e>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    478a:	000c3e03          	ld	t3,0(s8)
    478e:	8dbe                	mv	s11,a5
    4790:	4581                	li	a1,0
    4792:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    4794:	4329                	li	t1,10
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    4796:	00002f97          	auipc	t6,0x2
    479a:	99af8f93          	addi	t6,t6,-1638 # 6130 <_GLOBAL__sub_I__ZSt3cin+0x188>
    479e:	b1dd                	j	4484 <_vprintf_core.constprop.0.isra.0+0x458>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    47a0:	000c3e03          	ld	t3,0(s8)
    47a4:	4581                	li	a1,0
    47a6:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    47a8:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    47aa:	00002f97          	auipc	t6,0x2
    47ae:	986f8f93          	addi	t6,t6,-1658 # 6130 <_GLOBAL__sub_I__ZSt3cin+0x188>
    47b2:	b9c9                	j	4484 <_vprintf_core.constprop.0.isra.0+0x458>
        char spec = *p++;
    47b4:	8dbe                	mv	s11,a5
    47b6:	b911                	j	43ca <_vprintf_core.constprop.0.isra.0+0x39e>
            for (int i = digit_len - 1; i >= 0; i--)
    47b8:	577d                	li	a4,-1
    47ba:	4401                	li	s0,0
    47bc:	d6ec19e3          	bne	s8,a4,452e <_vprintf_core.constprop.0.isra.0+0x502>
        char spec = *p++;
    47c0:	6c22                	ld	s8,8(sp)
    47c2:	b065                	j	406a <_vprintf_core.constprop.0.isra.0+0x3e>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    47c4:	000c3e03          	ld	t3,0(s8)
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    47c8:	b549                	j	464a <_vprintf_core.constprop.0.isra.0+0x61e>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    47ca:	8dbe                	mv	s11,a5
                val = (uint64)va_arg(ap, void *);
    47cc:	000c3e03          	ld	t3,0(s8)
    47d0:	4581                	li	a1,0
    47d2:	07000c93          	li	s9,112
    47d6:	e002                	sd	zero,0(sp)
    47d8:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    47da:	00002f97          	auipc	t6,0x2
    47de:	956f8f93          	addi	t6,t6,-1706 # 6130 <_GLOBAL__sub_I__ZSt3cin+0x188>
    47e2:	b14d                	j	4484 <_vprintf_core.constprop.0.isra.0+0x458>
                prefix_str = (spec == 'X') ? "0X" : "0x";
    47e4:	00002c97          	auipc	s9,0x2
    47e8:	96cc8c93          	addi	s9,s9,-1684 # 6150 <_GLOBAL__sub_I__ZSt3cin+0x1a8>
    47ec:	b3e5                	j	45d4 <_vprintf_core.constprop.0.isra.0+0x5a8>
                val = (uint64)va_arg(ap, void *);
    47ee:	008c0713          	addi	a4,s8,8
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    47f2:	000c3e03          	ld	t3,0(s8)
                val = (uint64)va_arg(ap, void *);
    47f6:	e43a                	sd	a4,8(sp)
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    47f8:	8dbe                	mv	s11,a5
    47fa:	bd81                	j	464a <_vprintf_core.constprop.0.isra.0+0x61e>
    47fc:	8d52                	mv	s10,s4
    47fe:	4b01                	li	s6,0
    4800:	4b81                	li	s7,0
    4802:	bd59                	j	4698 <_vprintf_core.constprop.0.isra.0+0x66c>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    4804:	07000693          	li	a3,112
    4808:	fcdc82e3          	beq	s9,a3,47cc <_vprintf_core.constprop.0.isra.0+0x7a0>
            else if (len_mod == 1)
    480c:	01ce8c63          	beq	t4,t3,4824 <_vprintf_core.constprop.0.isra.0+0x7f8>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    4810:	000c6e03          	lwu	t3,0(s8)
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    4814:	4581                	li	a1,0
    4816:	e002                	sd	zero,0(sp)
    4818:	4329                	li	t1,10
    481a:	00002f97          	auipc	t6,0x2
    481e:	916f8f93          	addi	t6,t6,-1770 # 6130 <_GLOBAL__sub_I__ZSt3cin+0x188>
    4822:	b18d                	j	4484 <_vprintf_core.constprop.0.isra.0+0x458>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    4824:	000c3e03          	ld	t3,0(s8)
            if (is_signed)
    4828:	b7f5                	j	4814 <_vprintf_core.constprop.0.isra.0+0x7e8>

000000000000482a <vsnprintf>:
{
    482a:	7139                	addi	sp,sp,-64
    482c:	f822                	sd	s0,48(sp)
    482e:	f426                	sd	s1,40(sp)
    4830:	842e                	mv	s0,a1
    4832:	84aa                	mv	s1,a0
    4834:	85b2                	mv	a1,a2
    _vprintf_core(&ctx, format, ap);
    4836:	850a                	mv	a0,sp
    4838:	8636                	mv	a2,a3
{
    483a:	fc06                	sd	ra,56(sp)
    ctx.buf = str;
    483c:	e026                	sd	s1,0(sp)
    ctx.limit = size;
    483e:	e422                	sd	s0,8(sp)
    ctx.written = 0;
    4840:	e802                	sd	zero,16(sp)
    ctx.stream = NULL;
    4842:	ec02                	sd	zero,24(sp)
    _vprintf_core(&ctx, format, ap);
    4844:	fe8ff0ef          	jal	402c <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    4848:	6542                	ld	a0,16(sp)
    if (size > 0)
    484a:	c411                	beqz	s0,4856 <vsnprintf+0x2c>
        if (ctx.written < size)
    484c:	00857b63          	bgeu	a0,s0,4862 <vsnprintf+0x38>
            str[ctx.written] = '\0';
    4850:	94aa                	add	s1,s1,a0
    4852:	00048023          	sb	zero,0(s1)
}
    4856:	70e2                	ld	ra,56(sp)
    4858:	7442                	ld	s0,48(sp)
    485a:	74a2                	ld	s1,40(sp)
    485c:	2501                	sext.w	a0,a0
    485e:	6121                	addi	sp,sp,64
    4860:	8082                	ret
            str[size - 1] = '\0';
    4862:	94a2                	add	s1,s1,s0
    4864:	fe048fa3          	sb	zero,-1(s1)
}
    4868:	70e2                	ld	ra,56(sp)
    486a:	7442                	ld	s0,48(sp)
    486c:	74a2                	ld	s1,40(sp)
    486e:	2501                	sext.w	a0,a0
    4870:	6121                	addi	sp,sp,64
    4872:	8082                	ret

0000000000004874 <snprintf>:
{
    4874:	7119                	addi	sp,sp,-128
    4876:	e0a2                	sd	s0,64(sp)
    4878:	fc26                	sd	s1,56(sp)
    487a:	842e                	mv	s0,a1
    487c:	84aa                	mv	s1,a0
    487e:	85b2                	mv	a1,a2
    _vprintf_core(&ctx, format, ap);
    4880:	0808                	addi	a0,sp,16
    va_start(ap, format);
    4882:	08b0                	addi	a2,sp,88
{
    4884:	e486                	sd	ra,72(sp)
    4886:	ecb6                	sd	a3,88(sp)
    4888:	f0ba                	sd	a4,96(sp)
    488a:	f4be                	sd	a5,104(sp)
    488c:	f8c2                	sd	a6,112(sp)
    488e:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    4890:	e432                	sd	a2,8(sp)
    ctx.buf = str;
    4892:	e826                	sd	s1,16(sp)
    ctx.limit = size;
    4894:	ec22                	sd	s0,24(sp)
    ctx.written = 0;
    4896:	f002                	sd	zero,32(sp)
    ctx.stream = NULL;
    4898:	f402                	sd	zero,40(sp)
    _vprintf_core(&ctx, format, ap);
    489a:	f92ff0ef          	jal	402c <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    489e:	7502                	ld	a0,32(sp)
    if (size > 0)
    48a0:	c411                	beqz	s0,48ac <snprintf+0x38>
        if (ctx.written < size)
    48a2:	00857b63          	bgeu	a0,s0,48b8 <snprintf+0x44>
            str[ctx.written] = '\0';
    48a6:	94aa                	add	s1,s1,a0
    48a8:	00048023          	sb	zero,0(s1)
}
    48ac:	60a6                	ld	ra,72(sp)
    48ae:	6406                	ld	s0,64(sp)
    48b0:	74e2                	ld	s1,56(sp)
    48b2:	2501                	sext.w	a0,a0
    48b4:	6109                	addi	sp,sp,128
    48b6:	8082                	ret
            str[size - 1] = '\0';
    48b8:	94a2                	add	s1,s1,s0
    48ba:	fe048fa3          	sb	zero,-1(s1)
}
    48be:	60a6                	ld	ra,72(sp)
    48c0:	6406                	ld	s0,64(sp)
    48c2:	74e2                	ld	s1,56(sp)
    48c4:	2501                	sext.w	a0,a0
    48c6:	6109                	addi	sp,sp,128
    48c8:	8082                	ret

00000000000048ca <printf>:
{
    48ca:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    48cc:	04810313          	addi	t1,sp,72
{
    48d0:	e4ae                	sd	a1,72(sp)
    48d2:	e8b2                	sd	a2,80(sp)
    48d4:	f4be                	sd	a5,104(sp)
    _vprintf_core(&ctx, format, ap);
    48d6:	85aa                	mv	a1,a0
    ctx.stream = stdout;
    48d8:	00004797          	auipc	a5,0x4
    48dc:	2f07b783          	ld	a5,752(a5) # 8bc8 <stdout>
    _vprintf_core(&ctx, format, ap);
    48e0:	0808                	addi	a0,sp,16
    48e2:	861a                	mv	a2,t1
{
    48e4:	fc06                	sd	ra,56(sp)
    48e6:	ecb6                	sd	a3,88(sp)
    48e8:	f0ba                	sd	a4,96(sp)
    48ea:	f8c2                	sd	a6,112(sp)
    48ec:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    48ee:	e41a                	sd	t1,8(sp)
    ctx.buf = NULL;
    48f0:	e802                	sd	zero,16(sp)
    ctx.limit = 0;
    48f2:	ec02                	sd	zero,24(sp)
    ctx.written = 0;
    48f4:	f002                	sd	zero,32(sp)
    ctx.stream = stdout;
    48f6:	f43e                	sd	a5,40(sp)
    _vprintf_core(&ctx, format, ap);
    48f8:	f34ff0ef          	jal	402c <_vprintf_core.constprop.0.isra.0>
}
    48fc:	70e2                	ld	ra,56(sp)
    48fe:	5502                	lw	a0,32(sp)
    4900:	6109                	addi	sp,sp,128
    4902:	8082                	ret

0000000000004904 <sscanf>:
{
    4904:	7159                	addi	sp,sp,-112
    va_start(ap, format);
    4906:	04010e13          	addi	t3,sp,64
{
    490a:	8eaa                	mv	t4,a0
    ctx.fd = -1;
    490c:	537d                	li	t1,-1
{
    490e:	e0b2                	sd	a2,64(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    4910:	0808                	addi	a0,sp,16
    4912:	8672                	mv	a2,t3
{
    4914:	fc06                	sd	ra,56(sp)
    4916:	e4b6                	sd	a3,72(sp)
    4918:	e8ba                	sd	a4,80(sp)
    491a:	ecbe                	sd	a5,88(sp)
    491c:	f0c2                	sd	a6,96(sp)
    491e:	f4c6                	sd	a7,104(sp)
    va_start(ap, format);
    4920:	e472                	sd	t3,8(sp)
    ctx.buf = str;
    4922:	e876                	sd	t4,16(sp)
    ctx.fd = -1;
    4924:	cc1a                	sw	t1,24(sp)
    ctx.pos = 0;
    4926:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    4928:	d41a                	sw	t1,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    492a:	81efd0ef          	jal	1948 <_vscanf_core.constprop.0>
}
    492e:	70e2                	ld	ra,56(sp)
    4930:	6165                	addi	sp,sp,112
    4932:	8082                	ret

0000000000004934 <scanf>:
{
    4934:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    4936:	04810313          	addi	t1,sp,72
{
    493a:	e4ae                	sd	a1,72(sp)
    493c:	e8b2                	sd	a2,80(sp)
    493e:	f4be                	sd	a5,104(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    4940:	85aa                	mv	a1,a0
    ctx.ungotten = -1;
    4942:	57fd                	li	a5,-1
    int ret = _vscanf_core(&ctx, format, ap);
    4944:	0808                	addi	a0,sp,16
    4946:	861a                	mv	a2,t1
{
    4948:	fc06                	sd	ra,56(sp)
    494a:	ecb6                	sd	a3,88(sp)
    494c:	f0ba                	sd	a4,96(sp)
    494e:	f8c2                	sd	a6,112(sp)
    4950:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    4952:	e41a                	sd	t1,8(sp)
    ctx.buf = NULL;
    4954:	e802                	sd	zero,16(sp)
    ctx.fd = STDIN_FD;
    4956:	cc02                	sw	zero,24(sp)
    ctx.pos = 0;
    4958:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    495a:	d43e                	sw	a5,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    495c:	fedfc0ef          	jal	1948 <_vscanf_core.constprop.0>
}
    4960:	70e2                	ld	ra,56(sp)
    4962:	6109                	addi	sp,sp,128
    4964:	8082                	ret

0000000000004966 <fopen>:
{
    4966:	1101                	addi	sp,sp,-32
    4968:	e426                	sd	s1,8(sp)
    496a:	84ae                	mv	s1,a1
    496c:	e04a                	sd	s2,0(sp)
    if (strcmp(mode, "r") == 0)
    496e:	00002597          	auipc	a1,0x2
    4972:	80258593          	addi	a1,a1,-2046 # 6170 <_GLOBAL__sub_I__ZSt3cin+0x1c8>
{
    4976:	892a                	mv	s2,a0
    if (strcmp(mode, "r") == 0)
    4978:	8526                	mv	a0,s1
{
    497a:	e822                	sd	s0,16(sp)
    497c:	ec06                	sd	ra,24(sp)
    if (strcmp(mode, "r") == 0)
    497e:	280010ef          	jal	5bfe <strcmp>
    4982:	842a                	mv	s0,a0
    4984:	c919                	beqz	a0,499a <fopen+0x34>
    else if (strcmp(mode, "w") == 0)
    4986:	00001597          	auipc	a1,0x1
    498a:	7f258593          	addi	a1,a1,2034 # 6178 <_GLOBAL__sub_I__ZSt3cin+0x1d0>
    498e:	8526                	mv	a0,s1
    4990:	26e010ef          	jal	5bfe <strcmp>
        flags = O_WRONLY | O_CREAT | O_TRUNC;
    4994:	24100413          	li	s0,577
    else if (strcmp(mode, "w") == 0)
    4998:	ed39                	bnez	a0,49f6 <fopen+0x90>
    int64 fd = open(filename, flags);
    499a:	85a2                	mv	a1,s0
    499c:	854a                	mv	a0,s2
    499e:	f4afc0ef          	jal	10e8 <open>
    49a2:	84aa                	mv	s1,a0
    if (fd < 0)
    49a4:	06054c63          	bltz	a0,4a1c <fopen+0xb6>
    FILE *f = (FILE *)malloc(sizeof(FILE));
    49a8:	42000513          	li	a0,1056
    49ac:	2f3000ef          	jal	549e <malloc>
    49b0:	892a                	mv	s2,a0
    if (!f)
    49b2:	c53d                	beqz	a0,4a20 <fopen+0xba>
    memset(f, 0, sizeof(FILE));
    49b4:	42000613          	li	a2,1056
    49b8:	4581                	li	a1,0
    49ba:	0d6010ef          	jal	5a90 <memset>
    if (fd == 1)
    49be:	4785                	li	a5,1
    f->fd = (int)fd;
    49c0:	00992023          	sw	s1,0(s2)
    f->flags = flags;
    49c4:	00892223          	sw	s0,4(s2)
    if (fd == 1)
    49c8:	00f48e63          	beq	s1,a5,49e4 <fopen+0x7e>
    else if (fd == 2)
    49cc:	4789                	li	a5,2
    49ce:	00f48b63          	beq	s1,a5,49e4 <fopen+0x7e>
        f->buf_mode = 0;
    49d2:	40092e23          	sw	zero,1052(s2)
}
    49d6:	60e2                	ld	ra,24(sp)
    49d8:	6442                	ld	s0,16(sp)
    49da:	64a2                	ld	s1,8(sp)
    49dc:	854a                	mv	a0,s2
    49de:	6902                	ld	s2,0(sp)
    49e0:	6105                	addi	sp,sp,32
    49e2:	8082                	ret
    49e4:	60e2                	ld	ra,24(sp)
    49e6:	6442                	ld	s0,16(sp)
        f->buf_mode = 2;
    49e8:	40992e23          	sw	s1,1052(s2)
}
    49ec:	854a                	mv	a0,s2
    49ee:	64a2                	ld	s1,8(sp)
    49f0:	6902                	ld	s2,0(sp)
    49f2:	6105                	addi	sp,sp,32
    49f4:	8082                	ret
    else if (strcmp(mode, "a") == 0)
    49f6:	00001597          	auipc	a1,0x1
    49fa:	78a58593          	addi	a1,a1,1930 # 6180 <_GLOBAL__sub_I__ZSt3cin+0x1d8>
    49fe:	8526                	mv	a0,s1
    4a00:	1fe010ef          	jal	5bfe <strcmp>
        flags = O_WRONLY | O_CREAT | O_APPEND;
    4a04:	44100413          	li	s0,1089
    else if (strcmp(mode, "a") == 0)
    4a08:	d949                	beqz	a0,499a <fopen+0x34>
    else if (strcmp(mode, "r+") == 0)
    4a0a:	00001597          	auipc	a1,0x1
    4a0e:	77e58593          	addi	a1,a1,1918 # 6188 <_GLOBAL__sub_I__ZSt3cin+0x1e0>
    4a12:	8526                	mv	a0,s1
    4a14:	1ea010ef          	jal	5bfe <strcmp>
        flags = O_RDWR;
    4a18:	4409                	li	s0,2
    else if (strcmp(mode, "r+") == 0)
    4a1a:	d141                	beqz	a0,499a <fopen+0x34>
        return NULL;
    4a1c:	4901                	li	s2,0
    4a1e:	bf65                	j	49d6 <fopen+0x70>
        close(fd);
    4a20:	8526                	mv	a0,s1
    4a22:	eaefc0ef          	jal	10d0 <close>
        return NULL;
    4a26:	4901                	li	s2,0
    4a28:	b77d                	j	49d6 <fopen+0x70>

0000000000004a2a <fclose>:
    if (!stream)
    4a2a:	cd29                	beqz	a0,4a84 <fclose+0x5a>
    if (stream->buf_write_pos > 0)
    4a2c:	41052603          	lw	a2,1040(a0)
{
    4a30:	1141                	addi	sp,sp,-16
    4a32:	e022                	sd	s0,0(sp)
    4a34:	e406                	sd	ra,8(sp)
    4a36:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    4a38:	02c04a63          	bgtz	a2,4a6c <fclose+0x42>
    if (stream != stdin && stream != stdout && stream != stderr)
    4a3c:	00004797          	auipc	a5,0x4
    4a40:	18c78793          	addi	a5,a5,396 # 8bc8 <stdout>
    4a44:	6798                	ld	a4,8(a5)
    4a46:	00870e63          	beq	a4,s0,4a62 <fclose+0x38>
    4a4a:	6398                	ld	a4,0(a5)
    4a4c:	00870b63          	beq	a4,s0,4a62 <fclose+0x38>
    4a50:	6b9c                	ld	a5,16(a5)
    4a52:	00878863          	beq	a5,s0,4a62 <fclose+0x38>
        close(stream->fd);
    4a56:	4008                	lw	a0,0(s0)
    4a58:	e78fc0ef          	jal	10d0 <close>
        free(stream);
    4a5c:	8522                	mv	a0,s0
    4a5e:	1cb000ef          	jal	5428 <free>
}
    4a62:	60a2                	ld	ra,8(sp)
    4a64:	6402                	ld	s0,0(sp)
    return 0;
    4a66:	4501                	li	a0,0
}
    4a68:	0141                	addi	sp,sp,16
    4a6a:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4a6c:	4108                	lw	a0,0(a0)
    4a6e:	01040593          	addi	a1,s0,16
    4a72:	e56fc0ef          	jal	10c8 <write>
        if (ret < stream->buf_write_pos)
    4a76:	41042783          	lw	a5,1040(s0)
    4a7a:	00f54763          	blt	a0,a5,4a88 <fclose+0x5e>
        stream->buf_write_pos = 0;
    4a7e:	40042823          	sw	zero,1040(s0)
    4a82:	bf6d                	j	4a3c <fclose+0x12>
        return -1;
    4a84:	557d                	li	a0,-1
}
    4a86:	8082                	ret
            stream->error = 1;
    4a88:	4785                	li	a5,1
    4a8a:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4a8c:	40042823          	sw	zero,1040(s0)
            return EOF;
    4a90:	b775                	j	4a3c <fclose+0x12>

0000000000004a92 <fflush>:
    if (!stream)
    4a92:	c121                	beqz	a0,4ad2 <fflush+0x40>
    if (stream->buf_write_pos > 0)
    4a94:	41052603          	lw	a2,1040(a0)
{
    4a98:	1141                	addi	sp,sp,-16
    4a9a:	e022                	sd	s0,0(sp)
    4a9c:	e406                	sd	ra,8(sp)
    4a9e:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    4aa0:	00c04763          	bgtz	a2,4aae <fflush+0x1c>
    return 0;
    4aa4:	4501                	li	a0,0
}
    4aa6:	60a2                	ld	ra,8(sp)
    4aa8:	6402                	ld	s0,0(sp)
    4aaa:	0141                	addi	sp,sp,16
    4aac:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4aae:	4108                	lw	a0,0(a0)
    4ab0:	01040593          	addi	a1,s0,16
    4ab4:	e14fc0ef          	jal	10c8 <write>
        if (ret < stream->buf_write_pos)
    4ab8:	41042783          	lw	a5,1040(s0)
    4abc:	00f54563          	blt	a0,a5,4ac6 <fflush+0x34>
        stream->buf_write_pos = 0;
    4ac0:	40042823          	sw	zero,1040(s0)
    4ac4:	b7c5                	j	4aa4 <fflush+0x12>
            stream->error = 1;
    4ac6:	4785                	li	a5,1
    4ac8:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4aca:	40042823          	sw	zero,1040(s0)
        return EOF;
    4ace:	557d                	li	a0,-1
    4ad0:	bfd9                	j	4aa6 <fflush+0x14>
    4ad2:	557d                	li	a0,-1
}
    4ad4:	8082                	ret

0000000000004ad6 <fprintf>:
{
    4ad6:	7159                	addi	sp,sp,-112
    4ad8:	fc06                	sd	ra,56(sp)
    4ada:	e0b2                	sd	a2,64(sp)
    4adc:	e4b6                	sd	a3,72(sp)
    4ade:	e8ba                	sd	a4,80(sp)
    4ae0:	ecbe                	sd	a5,88(sp)
    4ae2:	f0c2                	sd	a6,96(sp)
    4ae4:	f4c6                	sd	a7,104(sp)
    if (!stream)
    4ae6:	cd19                	beqz	a0,4b04 <fprintf+0x2e>
    va_start(ap, format);
    4ae8:	832a                	mv	t1,a0
    4aea:	0090                	addi	a2,sp,64
    _vprintf_core(&ctx, format, ap);
    4aec:	0808                	addi	a0,sp,16
    va_start(ap, format);
    4aee:	e432                	sd	a2,8(sp)
    ctx.buf = NULL;
    4af0:	e802                	sd	zero,16(sp)
    ctx.limit = 0;
    4af2:	ec02                	sd	zero,24(sp)
    ctx.written = 0;
    4af4:	f002                	sd	zero,32(sp)
    ctx.stream  = stream;
    4af6:	f41a                	sd	t1,40(sp)
    _vprintf_core(&ctx, format, ap);
    4af8:	d34ff0ef          	jal	402c <_vprintf_core.constprop.0.isra.0>
    return (int)ctx.written;
    4afc:	5502                	lw	a0,32(sp)
}
    4afe:	70e2                	ld	ra,56(sp)
    4b00:	6165                	addi	sp,sp,112
    4b02:	8082                	ret
        return -1;
    4b04:	557d                	li	a0,-1
    4b06:	bfe5                	j	4afe <fprintf+0x28>

0000000000004b08 <fscanf>:
{
    4b08:	7159                	addi	sp,sp,-112
    4b0a:	fc06                	sd	ra,56(sp)
    4b0c:	e0b2                	sd	a2,64(sp)
    4b0e:	e4b6                	sd	a3,72(sp)
    4b10:	e8ba                	sd	a4,80(sp)
    4b12:	ecbe                	sd	a5,88(sp)
    4b14:	f0c2                	sd	a6,96(sp)
    4b16:	f4c6                	sd	a7,104(sp)
    if (!stream)
    4b18:	cd19                	beqz	a0,4b36 <fscanf+0x2e>
    ctx.fd = stream->fd;
    4b1a:	411c                	lw	a5,0(a0)
    va_start(ap, format);
    4b1c:	0090                	addi	a2,sp,64
    int ret = _vscanf_core(&ctx, format, ap);
    4b1e:	0808                	addi	a0,sp,16
    ctx.fd = stream->fd;
    4b20:	cc3e                	sw	a5,24(sp)
    ctx.ungotten = -1;
    4b22:	57fd                	li	a5,-1
    va_start(ap, format);
    4b24:	e432                	sd	a2,8(sp)
    ctx.buf = NULL;
    4b26:	e802                	sd	zero,16(sp)
    ctx.pos = 0;
    4b28:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    4b2a:	d43e                	sw	a5,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    4b2c:	e1dfc0ef          	jal	1948 <_vscanf_core.constprop.0>
}
    4b30:	70e2                	ld	ra,56(sp)
    4b32:	6165                	addi	sp,sp,112
    4b34:	8082                	ret
        return -1;
    4b36:	557d                	li	a0,-1
    4b38:	bfe5                	j	4b30 <fscanf+0x28>

0000000000004b3a <fputc>:
    if (!stream)
    4b3a:	c1e1                	beqz	a1,4bfa <fputc+0xc0>
{
    4b3c:	7179                	addi	sp,sp,-48
    4b3e:	e84a                	sd	s2,16(sp)
    if (stream->buf_mode == 2)
    4b40:	41c5a903          	lw	s2,1052(a1)
{
    4b44:	f022                	sd	s0,32(sp)
    4b46:	ec26                	sd	s1,24(sp)
    4b48:	f406                	sd	ra,40(sp)
    if (stream->buf_mode == 2)
    4b4a:	4789                	li	a5,2
    4b4c:	842e                	mv	s0,a1
    4b4e:	84aa                	mv	s1,a0
        char ch = (char)c;
    4b50:	0ff57713          	zext.b	a4,a0
    if (stream->buf_mode == 2)
    4b54:	02f90963          	beq	s2,a5,4b86 <fputc+0x4c>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    4b58:	4105a783          	lw	a5,1040(a1)
    if (stream->buf_write_pos >= BUFSIZ)
    4b5c:	3ff00693          	li	a3,1023
    stream->buffer[stream->buf_write_pos++] = (char)c;
    4b60:	0017861b          	addiw	a2,a5,1
    4b64:	40c5a823          	sw	a2,1040(a1)
    4b68:	97ae                	add	a5,a5,a1
    4b6a:	00e78823          	sb	a4,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    4b6e:	06c6c463          	blt	a3,a2,4bd6 <fputc+0x9c>
    else if (stream->buf_mode == 1 && c == '\n')
    4b72:	4785                	li	a5,1
    4b74:	02f90e63          	beq	s2,a5,4bb0 <fputc+0x76>
    return c;
    4b78:	8526                	mv	a0,s1
}
    4b7a:	70a2                	ld	ra,40(sp)
    4b7c:	7402                	ld	s0,32(sp)
    4b7e:	64e2                	ld	s1,24(sp)
    4b80:	6942                	ld	s2,16(sp)
    4b82:	6145                	addi	sp,sp,48
    4b84:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    4b86:	4188                	lw	a0,0(a1)
    4b88:	4605                	li	a2,1
    4b8a:	00f10593          	addi	a1,sp,15
        char ch = (char)c;
    4b8e:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    4b92:	d36fc0ef          	jal	10c8 <write>
    4b96:	872a                	mv	a4,a0
    4b98:	4785                	li	a5,1
        return c;
    4b9a:	8526                	mv	a0,s1
        if (write(stream->fd, &ch, 1) != 1)
    4b9c:	fcf70fe3          	beq	a4,a5,4b7a <fputc+0x40>
}
    4ba0:	70a2                	ld	ra,40(sp)
            stream->error = 1;
    4ba2:	c41c                	sw	a5,8(s0)
}
    4ba4:	7402                	ld	s0,32(sp)
    4ba6:	64e2                	ld	s1,24(sp)
    4ba8:	6942                	ld	s2,16(sp)
            return EOF;
    4baa:	557d                	li	a0,-1
}
    4bac:	6145                	addi	sp,sp,48
    4bae:	8082                	ret
    else if (stream->buf_mode == 1 && c == '\n')
    4bb0:	47a9                	li	a5,10
    4bb2:	fcf513e3          	bne	a0,a5,4b78 <fputc+0x3e>
    if (stream->buf_write_pos > 0)
    4bb6:	fcc051e3          	blez	a2,4b78 <fputc+0x3e>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4bba:	4188                	lw	a0,0(a1)
    4bbc:	05c1                	addi	a1,a1,16
    4bbe:	d0afc0ef          	jal	10c8 <write>
        if (ret < stream->buf_write_pos)
    4bc2:	41042783          	lw	a5,1040(s0)
    4bc6:	02f55063          	bge	a0,a5,4be6 <fputc+0xac>
            stream->error = 1;
    4bca:	01242423          	sw	s2,8(s0)
            stream->buf_write_pos = 0;
    4bce:	40042823          	sw	zero,1040(s0)
    return c;
    4bd2:	8526                	mv	a0,s1
    4bd4:	b75d                	j	4b7a <fputc+0x40>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4bd6:	4188                	lw	a0,0(a1)
    4bd8:	05c1                	addi	a1,a1,16
    4bda:	ceefc0ef          	jal	10c8 <write>
        if (ret < stream->buf_write_pos)
    4bde:	41042783          	lw	a5,1040(s0)
    4be2:	00f54663          	blt	a0,a5,4bee <fputc+0xb4>
        stream->buf_write_pos = 0;
    4be6:	40042823          	sw	zero,1040(s0)
    return c;
    4bea:	8526                	mv	a0,s1
    4bec:	b779                	j	4b7a <fputc+0x40>
            stream->error = 1;
    4bee:	4785                	li	a5,1
    4bf0:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4bf2:	40042823          	sw	zero,1040(s0)
    return c;
    4bf6:	8526                	mv	a0,s1
    4bf8:	b749                	j	4b7a <fputc+0x40>
        return EOF;
    4bfa:	557d                	li	a0,-1
}
    4bfc:	8082                	ret

0000000000004bfe <fputs>:
    if (!stream)
    4bfe:	c1ed                	beqz	a1,4ce0 <fputs+0xe2>
{
    4c00:	711d                	addi	sp,sp,-96
    4c02:	e4a6                	sd	s1,72(sp)
    4c04:	ec86                	sd	ra,88(sp)
    while (*s)
    4c06:	00054703          	lbu	a4,0(a0)
    4c0a:	84aa                	mv	s1,a0
    4c0c:	cf25                	beqz	a4,4c84 <fputs+0x86>
    4c0e:	e8a2                	sd	s0,80(sp)
    4c10:	e0ca                	sd	s2,64(sp)
    4c12:	fc4e                	sd	s3,56(sp)
    4c14:	f852                	sd	s4,48(sp)
    4c16:	f456                	sd	s5,40(sp)
    4c18:	f05a                	sd	s6,32(sp)
    4c1a:	ec5e                	sd	s7,24(sp)
    4c1c:	842e                	mv	s0,a1
    if (stream->buf_mode == 2)
    4c1e:	4909                	li	s2,2
    if (stream->buf_write_pos >= BUFSIZ)
    4c20:	3ff00b13          	li	s6,1023
    else if (stream->buf_mode == 1 && c == '\n')
    4c24:	4985                	li	s3,1
    4c26:	4a29                	li	s4,10
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4c28:	01058a93          	addi	s5,a1,16
        if (write(stream->fd, &ch, 1) != 1)
    4c2c:	00f10b93          	addi	s7,sp,15
    4c30:	a031                	j	4c3c <fputs+0x3e>
    else if (stream->buf_mode == 1 && c == '\n')
    4c32:	09368563          	beq	a3,s3,4cbc <fputs+0xbe>
    while (*s)
    4c36:	0004c703          	lbu	a4,0(s1)
    4c3a:	cf15                	beqz	a4,4c76 <fputs+0x78>
    if (stream->buf_mode == 2)
    4c3c:	41c42683          	lw	a3,1052(s0)
        if (fputc(*s++, stream) == EOF)
    4c40:	0485                	addi	s1,s1,1
    if (stream->buf_mode == 2)
    4c42:	05268663          	beq	a3,s2,4c8e <fputs+0x90>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    4c46:	41042783          	lw	a5,1040(s0)
    4c4a:	0017861b          	addiw	a2,a5,1
    4c4e:	40c42823          	sw	a2,1040(s0)
    4c52:	97a2                	add	a5,a5,s0
    4c54:	00e78823          	sb	a4,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    4c58:	fccb5de3          	bge	s6,a2,4c32 <fputs+0x34>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4c5c:	4008                	lw	a0,0(s0)
    4c5e:	85d6                	mv	a1,s5
    4c60:	c68fc0ef          	jal	10c8 <write>
        if (ret < stream->buf_write_pos)
    4c64:	41042783          	lw	a5,1040(s0)
    4c68:	06f54763          	blt	a0,a5,4cd6 <fputs+0xd8>
        stream->buf_write_pos = 0;
    4c6c:	40042823          	sw	zero,1040(s0)
    while (*s)
    4c70:	0004c703          	lbu	a4,0(s1)
    4c74:	f761                	bnez	a4,4c3c <fputs+0x3e>
    4c76:	6446                	ld	s0,80(sp)
    4c78:	6906                	ld	s2,64(sp)
    4c7a:	79e2                	ld	s3,56(sp)
    4c7c:	7a42                	ld	s4,48(sp)
    4c7e:	7aa2                	ld	s5,40(sp)
    4c80:	7b02                	ld	s6,32(sp)
    4c82:	6be2                	ld	s7,24(sp)
}
    4c84:	60e6                	ld	ra,88(sp)
    4c86:	64a6                	ld	s1,72(sp)
    return 0;
    4c88:	4501                	li	a0,0
}
    4c8a:	6125                	addi	sp,sp,96
    4c8c:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    4c8e:	4008                	lw	a0,0(s0)
    4c90:	4605                	li	a2,1
    4c92:	85de                	mv	a1,s7
        char ch = (char)c;
    4c94:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    4c98:	c30fc0ef          	jal	10c8 <write>
    4c9c:	f9350de3          	beq	a0,s3,4c36 <fputs+0x38>
            stream->error = 1;
    4ca0:	01342423          	sw	s3,8(s0)
}
    4ca4:	60e6                	ld	ra,88(sp)
    4ca6:	6446                	ld	s0,80(sp)
    4ca8:	6906                	ld	s2,64(sp)
    4caa:	79e2                	ld	s3,56(sp)
    4cac:	7a42                	ld	s4,48(sp)
    4cae:	7aa2                	ld	s5,40(sp)
    4cb0:	7b02                	ld	s6,32(sp)
    4cb2:	6be2                	ld	s7,24(sp)
    4cb4:	64a6                	ld	s1,72(sp)
        return -1;
    4cb6:	557d                	li	a0,-1
}
    4cb8:	6125                	addi	sp,sp,96
    4cba:	8082                	ret
    else if (stream->buf_mode == 1 && c == '\n')
    4cbc:	f7471de3          	bne	a4,s4,4c36 <fputs+0x38>
    if (stream->buf_write_pos > 0)
    4cc0:	f6c05be3          	blez	a2,4c36 <fputs+0x38>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4cc4:	4008                	lw	a0,0(s0)
    4cc6:	01040593          	addi	a1,s0,16
    4cca:	bfefc0ef          	jal	10c8 <write>
        if (ret < stream->buf_write_pos)
    4cce:	41042783          	lw	a5,1040(s0)
    4cd2:	f8f55de3          	bge	a0,a5,4c6c <fputs+0x6e>
            stream->error = 1;
    4cd6:	4785                	li	a5,1
    4cd8:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4cda:	40042823          	sw	zero,1040(s0)
            return EOF;
    4cde:	bfa1                	j	4c36 <fputs+0x38>
        return -1;
    4ce0:	557d                	li	a0,-1
}
    4ce2:	8082                	ret

0000000000004ce4 <fgetc>:
    if (!stream)
    4ce4:	c949                	beqz	a0,4d76 <fgetc+0x92>
    if (stream->buf_write_pos > 0)
    4ce6:	41052603          	lw	a2,1040(a0)
{
    4cea:	1141                	addi	sp,sp,-16
    4cec:	e022                	sd	s0,0(sp)
    4cee:	e406                	sd	ra,8(sp)
    4cf0:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    4cf2:	04c04863          	bgtz	a2,4d42 <fgetc+0x5e>
    if (stream->buf_read_pos < stream->buf_read_cnt)
    4cf6:	41442783          	lw	a5,1044(s0)
    4cfa:	41842703          	lw	a4,1048(s0)
    4cfe:	00e7dd63          	bge	a5,a4,4d18 <fgetc+0x34>
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4d02:	0017871b          	addiw	a4,a5,1
    4d06:	40e42a23          	sw	a4,1044(s0)
    4d0a:	943e                	add	s0,s0,a5
    4d0c:	01044503          	lbu	a0,16(s0)
}
    4d10:	60a2                	ld	ra,8(sp)
    4d12:	6402                	ld	s0,0(sp)
    4d14:	0141                	addi	sp,sp,16
    4d16:	8082                	ret
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    4d18:	4008                	lw	a0,0(s0)
    4d1a:	40000613          	li	a2,1024
    4d1e:	01040593          	addi	a1,s0,16
    4d22:	b9efc0ef          	jal	10c0 <read>
    4d26:	87aa                	mv	a5,a0
    if (ret <= 0)
    4d28:	02a05e63          	blez	a0,4d64 <fgetc+0x80>
    stream->buf_read_cnt = (int)ret;
    4d2c:	40f42c23          	sw	a5,1048(s0)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4d30:	4785                	li	a5,1
    4d32:	01044503          	lbu	a0,16(s0)
}
    4d36:	60a2                	ld	ra,8(sp)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4d38:	40f42a23          	sw	a5,1044(s0)
}
    4d3c:	6402                	ld	s0,0(sp)
    4d3e:	0141                	addi	sp,sp,16
    4d40:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4d42:	4108                	lw	a0,0(a0)
    4d44:	01040593          	addi	a1,s0,16
    4d48:	b80fc0ef          	jal	10c8 <write>
        if (ret < stream->buf_write_pos)
    4d4c:	41042783          	lw	a5,1040(s0)
    4d50:	00f54563          	blt	a0,a5,4d5a <fgetc+0x76>
        stream->buf_write_pos = 0;
    4d54:	40042823          	sw	zero,1040(s0)
    4d58:	bf79                	j	4cf6 <fgetc+0x12>
            stream->error = 1;
    4d5a:	4785                	li	a5,1
    4d5c:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4d5e:	40042823          	sw	zero,1040(s0)
            return EOF;
    4d62:	bf51                	j	4cf6 <fgetc+0x12>
        if (ret == 0)
    4d64:	e509                	bnez	a0,4d6e <fgetc+0x8a>
            stream->eof = 1;
    4d66:	4785                	li	a5,1
    4d68:	c45c                	sw	a5,12(s0)
        return EOF;
    4d6a:	557d                	li	a0,-1
    4d6c:	b755                	j	4d10 <fgetc+0x2c>
            stream->error = 1;
    4d6e:	4785                	li	a5,1
    4d70:	c41c                	sw	a5,8(s0)
        return EOF;
    4d72:	557d                	li	a0,-1
    4d74:	bf71                	j	4d10 <fgetc+0x2c>
    4d76:	557d                	li	a0,-1
}
    4d78:	8082                	ret

0000000000004d7a <fgets>:
    if (!stream || n <= 0)
    4d7a:	ce5d                	beqz	a2,4e38 <fgets+0xbe>
    4d7c:	0ab05e63          	blez	a1,4e38 <fgets+0xbe>
{
    4d80:	715d                	addi	sp,sp,-80
    4d82:	e0a2                	sd	s0,64(sp)
    4d84:	fc26                	sd	s1,56(sp)
    4d86:	f84a                	sd	s2,48(sp)
    4d88:	f44e                	sd	s3,40(sp)
    4d8a:	f052                	sd	s4,32(sp)
    4d8c:	ec56                	sd	s5,24(sp)
    4d8e:	e85a                	sd	s6,16(sp)
    4d90:	e45e                	sd	s7,8(sp)
    4d92:	e486                	sd	ra,72(sp)
    4d94:	8432                	mv	s0,a2
    4d96:	8aaa                	mv	s5,a0
    4d98:	892a                	mv	s2,a0
    4d9a:	fff58b9b          	addiw	s7,a1,-1
    int i = 0, c;
    4d9e:	4481                	li	s1,0
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4da0:	01060993          	addi	s3,a2,16
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4da4:	4b05                	li	s6,1
        if (c == '\n')
    4da6:	4a29                	li	s4,10
    while (i < n - 1)
    4da8:	05748163          	beq	s1,s7,4dea <fgets+0x70>
    if (stream->buf_write_pos > 0)
    4dac:	41042603          	lw	a2,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4db0:	85ce                	mv	a1,s3
    if (stream->buf_write_pos > 0)
    4db2:	06c04963          	bgtz	a2,4e24 <fgets+0xaa>
    if (stream->buf_read_pos < stream->buf_read_cnt)
    4db6:	41442783          	lw	a5,1044(s0)
    4dba:	41842703          	lw	a4,1048(s0)
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    4dbe:	40000613          	li	a2,1024
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4dc2:	0017851b          	addiw	a0,a5,1
    4dc6:	00f406b3          	add	a3,s0,a5
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    4dca:	85ce                	mv	a1,s3
    if (stream->buf_read_pos < stream->buf_read_cnt)
    4dcc:	02e7de63          	bge	a5,a4,4e08 <fgets+0x8e>
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4dd0:	40a42a23          	sw	a0,1044(s0)
    4dd4:	0106c783          	lbu	a5,16(a3)
    4dd8:	0007871b          	sext.w	a4,a5
        str[i++] = (char)c;
    4ddc:	00f90023          	sb	a5,0(s2)
    4de0:	2485                	addiw	s1,s1,1
        if (c == '\n')
    4de2:	0905                	addi	s2,s2,1
    4de4:	fd4712e3          	bne	a4,s4,4da8 <fgets+0x2e>
        str[i++] = (char)c;
    4de8:	8ba6                	mv	s7,s1
    str[i] = '\0';
    4dea:	9bd6                	add	s7,s7,s5
    4dec:	000b8023          	sb	zero,0(s7)
    return str;
    4df0:	8556                	mv	a0,s5
}
    4df2:	60a6                	ld	ra,72(sp)
    4df4:	6406                	ld	s0,64(sp)
    4df6:	74e2                	ld	s1,56(sp)
    4df8:	7942                	ld	s2,48(sp)
    4dfa:	79a2                	ld	s3,40(sp)
    4dfc:	7a02                	ld	s4,32(sp)
    4dfe:	6ae2                	ld	s5,24(sp)
    4e00:	6b42                	ld	s6,16(sp)
    4e02:	6ba2                	ld	s7,8(sp)
    4e04:	6161                	addi	sp,sp,80
    4e06:	8082                	ret
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    4e08:	4008                	lw	a0,0(s0)
    4e0a:	ab6fc0ef          	jal	10c0 <read>
    if (ret <= 0)
    4e0e:	02a05c63          	blez	a0,4e46 <fgets+0xcc>
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4e12:	01044783          	lbu	a5,16(s0)
    stream->buf_read_cnt = (int)ret;
    4e16:	40a42c23          	sw	a0,1048(s0)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4e1a:	41642a23          	sw	s6,1044(s0)
    4e1e:	0007871b          	sext.w	a4,a5
        if (c == -1)
    4e22:	bf6d                	j	4ddc <fgets+0x62>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4e24:	4008                	lw	a0,0(s0)
    4e26:	aa2fc0ef          	jal	10c8 <write>
        if (ret < stream->buf_write_pos)
    4e2a:	41042783          	lw	a5,1040(s0)
    4e2e:	00f54763          	blt	a0,a5,4e3c <fgets+0xc2>
        stream->buf_write_pos = 0;
    4e32:	40042823          	sw	zero,1040(s0)
    4e36:	b741                	j	4db6 <fgets+0x3c>
        return NULL;
    4e38:	4501                	li	a0,0
}
    4e3a:	8082                	ret
            stream->error = 1;
    4e3c:	4785                	li	a5,1
    4e3e:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4e40:	40042823          	sw	zero,1040(s0)
            return EOF;
    4e44:	bf8d                	j	4db6 <fgets+0x3c>
            stream->eof = 1;
    4e46:	4785                	li	a5,1
        if (ret == 0)
    4e48:	e509                	bnez	a0,4e52 <fgets+0xd8>
            stream->eof = 1;
    4e4a:	c45c                	sw	a5,12(s0)
            if (i == 0)
    4e4c:	fcd1                	bnez	s1,4de8 <fgets+0x6e>
        return NULL;
    4e4e:	4501                	li	a0,0
    4e50:	b74d                	j	4df2 <fgets+0x78>
            stream->error = 1;
    4e52:	c41c                	sw	a5,8(s0)
        if (c == -1)
    4e54:	bfe5                	j	4e4c <fgets+0xd2>

0000000000004e56 <fread>:
{
    4e56:	715d                	addi	sp,sp,-80
    4e58:	e486                	sd	ra,72(sp)
    4e5a:	f44e                	sd	s3,40(sp)
    if (!stream || size == 0 || nmemb == 0)
    4e5c:	0e068963          	beqz	a3,4f4e <fread+0xf8>
    4e60:	ec56                	sd	s5,24(sp)
        return 0;
    4e62:	4981                	li	s3,0
    4e64:	8aae                	mv	s5,a1
    if (!stream || size == 0 || nmemb == 0)
    4e66:	c9bd                	beqz	a1,4edc <fread+0x86>
    4e68:	ca35                	beqz	a2,4edc <fread+0x86>
    if (stream->buf_write_pos > 0)
    4e6a:	4106a783          	lw	a5,1040(a3)
    4e6e:	e0a2                	sd	s0,64(sp)
    4e70:	f052                	sd	s4,32(sp)
    uint64 total_bytes = size * nmemb;
    4e72:	02c589b3          	mul	s3,a1,a2
    4e76:	8436                	mv	s0,a3
    4e78:	8a2a                	mv	s4,a0
    if (stream->buf_write_pos > 0)
    4e7a:	0af04d63          	bgtz	a5,4f34 <fread+0xde>
    while (bytes_read < total_bytes)
    4e7e:	04098d63          	beqz	s3,4ed8 <fread+0x82>
    4e82:	fc26                	sd	s1,56(sp)
    4e84:	e85a                	sd	s6,16(sp)
    4e86:	e45e                	sd	s7,8(sp)
    4e88:	f84a                	sd	s2,48(sp)
    4e8a:	4481                	li	s1,0
            if (remaining >= BUFSIZ)
    4e8c:	3ff00b13          	li	s6,1023
                int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    4e90:	01040b93          	addi	s7,s0,16
        if (stream->buf_read_pos < stream->buf_read_cnt)
    4e94:	41442703          	lw	a4,1044(s0)
    4e98:	41842783          	lw	a5,1048(s0)
            uint64 remaining = total_bytes - bytes_read;
    4e9c:	40998633          	sub	a2,s3,s1
        if (stream->buf_read_pos < stream->buf_read_cnt)
    4ea0:	06f74463          	blt	a4,a5,4f08 <fread+0xb2>
                int64 ret = read(stream->fd, dst + bytes_read, remaining);
    4ea4:	4008                	lw	a0,0(s0)
    4ea6:	009a05b3          	add	a1,s4,s1
            if (remaining >= BUFSIZ)
    4eaa:	02cb7f63          	bgeu	s6,a2,4ee8 <fread+0x92>
                int64 ret = read(stream->fd, dst + bytes_read, remaining);
    4eae:	a12fc0ef          	jal	10c0 <read>
                if (ret <= 0)
    4eb2:	0aa05463          	blez	a0,4f5a <fread+0x104>
                bytes_read += ret;
    4eb6:	94aa                	add	s1,s1,a0
    while (bytes_read < total_bytes)
    4eb8:	fd34eee3          	bltu	s1,s3,4e94 <fread+0x3e>
    return bytes_read / size;
    4ebc:	0354d9b3          	divu	s3,s1,s5
    4ec0:	6406                	ld	s0,64(sp)
}
    4ec2:	60a6                	ld	ra,72(sp)
    return bytes_read / size;
    4ec4:	74e2                	ld	s1,56(sp)
    4ec6:	7942                	ld	s2,48(sp)
    4ec8:	7a02                	ld	s4,32(sp)
    4eca:	6ae2                	ld	s5,24(sp)
    4ecc:	6b42                	ld	s6,16(sp)
    4ece:	6ba2                	ld	s7,8(sp)
}
    4ed0:	854e                	mv	a0,s3
    4ed2:	79a2                	ld	s3,40(sp)
    4ed4:	6161                	addi	sp,sp,80
    4ed6:	8082                	ret
    4ed8:	6406                	ld	s0,64(sp)
    4eda:	7a02                	ld	s4,32(sp)
    4edc:	60a6                	ld	ra,72(sp)
    4ede:	6ae2                	ld	s5,24(sp)
    4ee0:	854e                	mv	a0,s3
    4ee2:	79a2                	ld	s3,40(sp)
    4ee4:	6161                	addi	sp,sp,80
    4ee6:	8082                	ret
                stream->buf_read_pos = 0;
    4ee8:	40042a23          	sw	zero,1044(s0)
                stream->buf_read_cnt = 0;
    4eec:	40042c23          	sw	zero,1048(s0)
                int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    4ef0:	40000613          	li	a2,1024
    4ef4:	85de                	mv	a1,s7
    4ef6:	9cafc0ef          	jal	10c0 <read>
                if (ret <= 0)
    4efa:	06a05063          	blez	a0,4f5a <fread+0x104>
                stream->buf_read_cnt = (int)ret;
    4efe:	40a42c23          	sw	a0,1048(s0)
    while (bytes_read < total_bytes)
    4f02:	f934e9e3          	bltu	s1,s3,4e94 <fread+0x3e>
    4f06:	bf5d                	j	4ebc <fread+0x66>
            uint64 available = stream->buf_read_cnt - stream->buf_read_pos;
    4f08:	40e7893b          	subw	s2,a5,a4
            memcpy(dst + bytes_read, stream->buffer + stream->buf_read_pos, to_copy);
    4f0c:	00eb85b3          	add	a1,s7,a4
    4f10:	009a0533          	add	a0,s4,s1
            uint64 to_copy = (available < remaining) ? available : remaining;
    4f14:	01267363          	bgeu	a2,s2,4f1a <fread+0xc4>
    4f18:	8932                	mv	s2,a2
            memcpy(dst + bytes_read, stream->buffer + stream->buf_read_pos, to_copy);
    4f1a:	864a                	mv	a2,s2
    4f1c:	3c9000ef          	jal	5ae4 <memcpy>
            stream->buf_read_pos += to_copy;
    4f20:	41442783          	lw	a5,1044(s0)
            bytes_read += to_copy;
    4f24:	94ca                	add	s1,s1,s2
            stream->buf_read_pos += to_copy;
    4f26:	012787bb          	addw	a5,a5,s2
    4f2a:	40f42a23          	sw	a5,1044(s0)
    while (bytes_read < total_bytes)
    4f2e:	f734e3e3          	bltu	s1,s3,4e94 <fread+0x3e>
    4f32:	b769                	j	4ebc <fread+0x66>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4f34:	4288                	lw	a0,0(a3)
    4f36:	863e                	mv	a2,a5
    4f38:	01068593          	addi	a1,a3,16
    4f3c:	98cfc0ef          	jal	10c8 <write>
        if (ret < stream->buf_write_pos)
    4f40:	41042783          	lw	a5,1040(s0)
    4f44:	02f54163          	blt	a0,a5,4f66 <fread+0x110>
        stream->buf_write_pos = 0;
    4f48:	40042823          	sw	zero,1040(s0)
    4f4c:	bf0d                	j	4e7e <fread+0x28>
}
    4f4e:	60a6                	ld	ra,72(sp)
        return 0;
    4f50:	4981                	li	s3,0
}
    4f52:	854e                	mv	a0,s3
    4f54:	79a2                	ld	s3,40(sp)
    4f56:	6161                	addi	sp,sp,80
    4f58:	8082                	ret
                        stream->eof = 1;
    4f5a:	4785                	li	a5,1
                    if (ret == 0)
    4f5c:	e119                	bnez	a0,4f62 <fread+0x10c>
                        stream->eof = 1;
    4f5e:	c45c                	sw	a5,12(s0)
    4f60:	bfb1                	j	4ebc <fread+0x66>
                        stream->error = 1;
    4f62:	c41c                	sw	a5,8(s0)
                    return bytes_read / size;
    4f64:	bfa1                	j	4ebc <fread+0x66>
            stream->error = 1;
    4f66:	4785                	li	a5,1
    4f68:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4f6a:	40042823          	sw	zero,1040(s0)
            return EOF;
    4f6e:	bf01                	j	4e7e <fread+0x28>

0000000000004f70 <fwrite>:
{
    4f70:	711d                	addi	sp,sp,-96
    4f72:	ec86                	sd	ra,88(sp)
    4f74:	e0ca                	sd	s2,64(sp)
    if (!stream || !ptr || size == 0 || nmemb == 0)
    4f76:	10068063          	beqz	a3,5076 <fwrite+0x106>
    4f7a:	f456                	sd	s5,40(sp)
    4f7c:	8aaa                	mv	s5,a0
    4f7e:	10050263          	beqz	a0,5082 <fwrite+0x112>
    4f82:	f05a                	sd	s6,32(sp)
        return 0;
    4f84:	4901                	li	s2,0
    4f86:	8b2e                	mv	s6,a1
    if (!stream || !ptr || size == 0 || nmemb == 0)
    4f88:	c1d9                	beqz	a1,500e <fwrite+0x9e>
    4f8a:	c251                	beqz	a2,500e <fwrite+0x9e>
    if (stream->buf_mode == 2)
    4f8c:	41c6a703          	lw	a4,1052(a3)
    4f90:	e8a2                	sd	s0,80(sp)
    4f92:	4789                	li	a5,2
    uint64 total_bytes = size * nmemb;
    4f94:	02c58933          	mul	s2,a1,a2
    if (stream->buf_mode == 2)
    4f98:	8436                	mv	s0,a3
    4f9a:	0ef70b63          	beq	a4,a5,5090 <fwrite+0x120>
    4f9e:	fc4e                	sd	s3,56(sp)
    4fa0:	ec5e                	sd	s7,24(sp)
    4fa2:	e862                	sd	s8,16(sp)
    uint64 bytes_written = 0;
    4fa4:	4981                	li	s3,0
    4fa6:	01068b93          	addi	s7,a3,16
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    4faa:	40000c13          	li	s8,1024
    while (bytes_written < total_bytes)
    4fae:	12090263          	beqz	s2,50d2 <fwrite+0x162>
    4fb2:	e4a6                	sd	s1,72(sp)
    4fb4:	f852                	sd	s4,48(sp)
    4fb6:	e466                	sd	s9,8(sp)
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    4fb8:	41042783          	lw	a5,1040(s0)
        uint64 remaining = total_bytes - bytes_written;
    4fbc:	41390cb3          	sub	s9,s2,s3
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, remaining);
    4fc0:	013a85b3          	add	a1,s5,s3
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    4fc4:	40fc0a3b          	subw	s4,s8,a5
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, space_left);
    4fc8:	00fb8533          	add	a0,s7,a5
    4fcc:	8652                	mv	a2,s4
        if (remaining <= space_left)
    4fce:	059a6763          	bltu	s4,s9,501c <fwrite+0xac>
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, remaining);
    4fd2:	8666                	mv	a2,s9
    4fd4:	311000ef          	jal	5ae4 <memcpy>
            stream->buf_write_pos += remaining;
    4fd8:	41042783          	lw	a5,1040(s0)
            if (stream->buf_write_pos == BUFSIZ)
    4fdc:	40000713          	li	a4,1024
            stream->buf_write_pos += remaining;
    4fe0:	019786bb          	addw	a3,a5,s9
    4fe4:	40d42823          	sw	a3,1040(s0)
            if (stream->buf_write_pos == BUFSIZ)
    4fe8:	06e68a63          	beq	a3,a4,505c <fwrite+0xec>
    return bytes_written / size;
    4fec:	03695933          	divu	s2,s2,s6
    4ff0:	6446                	ld	s0,80(sp)
    4ff2:	64a6                	ld	s1,72(sp)
    4ff4:	79e2                	ld	s3,56(sp)
    4ff6:	7a42                	ld	s4,48(sp)
    4ff8:	7aa2                	ld	s5,40(sp)
    4ffa:	7b02                	ld	s6,32(sp)
    4ffc:	6be2                	ld	s7,24(sp)
    4ffe:	6c42                	ld	s8,16(sp)
    5000:	6ca2                	ld	s9,8(sp)
}
    5002:	60e6                	ld	ra,88(sp)
    5004:	854a                	mv	a0,s2
    5006:	6906                	ld	s2,64(sp)
    5008:	6125                	addi	sp,sp,96
    500a:	8082                	ret
    500c:	6446                	ld	s0,80(sp)
    500e:	60e6                	ld	ra,88(sp)
    5010:	7aa2                	ld	s5,40(sp)
    5012:	7b02                	ld	s6,32(sp)
    5014:	854a                	mv	a0,s2
    5016:	6906                	ld	s2,64(sp)
    5018:	6125                	addi	sp,sp,96
    501a:	8082                	ret
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, space_left);
    501c:	2c9000ef          	jal	5ae4 <memcpy>
            stream->buf_write_pos += space_left;
    5020:	41042783          	lw	a5,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    5024:	85de                	mv	a1,s7
            bytes_written += space_left;
    5026:	99d2                	add	s3,s3,s4
            stream->buf_write_pos += space_left;
    5028:	00fa04bb          	addw	s1,s4,a5
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    502c:	02049613          	slli	a2,s1,0x20
            stream->buf_write_pos += space_left;
    5030:	40942823          	sw	s1,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    5034:	9201                	srli	a2,a2,0x20
    if (stream->buf_write_pos > 0)
    5036:	00904763          	bgtz	s1,5044 <fwrite+0xd4>
    while (bytes_written < total_bytes)
    503a:	f729efe3          	bltu	s3,s2,4fb8 <fwrite+0x48>
    return bytes_written / size;
    503e:	0369d933          	divu	s2,s3,s6
    5042:	b77d                	j	4ff0 <fwrite+0x80>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    5044:	4008                	lw	a0,0(s0)
    5046:	882fc0ef          	jal	10c8 <write>
        if (ret < stream->buf_write_pos)
    504a:	41042783          	lw	a5,1040(s0)
    504e:	08f54963          	blt	a0,a5,50e0 <fwrite+0x170>
        stream->buf_write_pos = 0;
    5052:	40042823          	sw	zero,1040(s0)
    while (bytes_written < total_bytes)
    5056:	f729e1e3          	bltu	s3,s2,4fb8 <fwrite+0x48>
    505a:	b7d5                	j	503e <fwrite+0xce>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    505c:	4008                	lw	a0,0(s0)
    505e:	40000613          	li	a2,1024
    5062:	85de                	mv	a1,s7
    5064:	864fc0ef          	jal	10c8 <write>
        if (ret < stream->buf_write_pos)
    5068:	41042783          	lw	a5,1040(s0)
    506c:	08f54163          	blt	a0,a5,50ee <fwrite+0x17e>
        stream->buf_write_pos = 0;
    5070:	40042823          	sw	zero,1040(s0)
    5074:	bfa5                	j	4fec <fwrite+0x7c>
}
    5076:	60e6                	ld	ra,88(sp)
        return 0;
    5078:	4901                	li	s2,0
}
    507a:	854a                	mv	a0,s2
    507c:	6906                	ld	s2,64(sp)
    507e:	6125                	addi	sp,sp,96
    5080:	8082                	ret
    5082:	60e6                	ld	ra,88(sp)
        return 0;
    5084:	4901                	li	s2,0
    5086:	7aa2                	ld	s5,40(sp)
}
    5088:	854a                	mv	a0,s2
    508a:	6906                	ld	s2,64(sp)
    508c:	6125                	addi	sp,sp,96
    508e:	8082                	ret
        while (bytes_written < total_bytes)
    5090:	f6090ee3          	beqz	s2,500c <fwrite+0x9c>
    5094:	e4a6                	sd	s1,72(sp)
    uint64 bytes_written = 0;
    5096:	4481                	li	s1,0
    5098:	a021                	j	50a0 <fwrite+0x130>
            bytes_written += ret;
    509a:	94aa                	add	s1,s1,a0
        while (bytes_written < total_bytes)
    509c:	0324f463          	bgeu	s1,s2,50c4 <fwrite+0x154>
            int64 ret = write(stream->fd, src + bytes_written, total_bytes - bytes_written);
    50a0:	4008                	lw	a0,0(s0)
    50a2:	40990633          	sub	a2,s2,s1
    50a6:	009a85b3          	add	a1,s5,s1
    50aa:	81efc0ef          	jal	10c8 <write>
            if (ret <= 0)
    50ae:	fea046e3          	bgtz	a0,509a <fwrite+0x12a>
                stream->error = 1;
    50b2:	4785                	li	a5,1
        return bytes_written / size;
    50b4:	0364d933          	divu	s2,s1,s6
                stream->error = 1;
    50b8:	c41c                	sw	a5,8(s0)
                break;
    50ba:	64a6                	ld	s1,72(sp)
    50bc:	6446                	ld	s0,80(sp)
    50be:	7aa2                	ld	s5,40(sp)
    50c0:	7b02                	ld	s6,32(sp)
    50c2:	b781                	j	5002 <fwrite+0x92>
        return bytes_written / size;
    50c4:	0364d933          	divu	s2,s1,s6
    50c8:	6446                	ld	s0,80(sp)
    50ca:	64a6                	ld	s1,72(sp)
    50cc:	7aa2                	ld	s5,40(sp)
    50ce:	7b02                	ld	s6,32(sp)
    50d0:	bf0d                	j	5002 <fwrite+0x92>
    50d2:	6446                	ld	s0,80(sp)
    50d4:	79e2                	ld	s3,56(sp)
    50d6:	7aa2                	ld	s5,40(sp)
    50d8:	7b02                	ld	s6,32(sp)
    50da:	6be2                	ld	s7,24(sp)
    50dc:	6c42                	ld	s8,16(sp)
    50de:	b715                	j	5002 <fwrite+0x92>
            stream->error = 1;
    50e0:	4785                	li	a5,1
    50e2:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    50e4:	40042823          	sw	zero,1040(s0)
    while (bytes_written < total_bytes)
    50e8:	ed29e8e3          	bltu	s3,s2,4fb8 <fwrite+0x48>
    50ec:	bf89                	j	503e <fwrite+0xce>
            stream->error = 1;
    50ee:	4785                	li	a5,1
    50f0:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    50f2:	40042823          	sw	zero,1040(s0)
            return EOF;
    50f6:	bddd                	j	4fec <fwrite+0x7c>

00000000000050f8 <fseek>:
    if (!stream)
    50f8:	c925                	beqz	a0,5168 <fseek+0x70>
{
    50fa:	1101                	addi	sp,sp,-32
    50fc:	e04a                	sd	s2,0(sp)
    50fe:	8932                	mv	s2,a2
    if (stream->buf_write_pos > 0)
    5100:	41052603          	lw	a2,1040(a0)
{
    5104:	e822                	sd	s0,16(sp)
    5106:	e426                	sd	s1,8(sp)
    5108:	ec06                	sd	ra,24(sp)
    510a:	842a                	mv	s0,a0
    510c:	84ae                	mv	s1,a1
    if (stream->buf_write_pos > 0)
    510e:	02c04863          	bgtz	a2,513e <fseek+0x46>
    if (lseek(stream->fd, offset, whence) < 0)
    5112:	4008                	lw	a0,0(s0)
    stream->buf_read_pos = 0;
    5114:	40042a23          	sw	zero,1044(s0)
    stream->buf_read_cnt = 0;
    5118:	40042c23          	sw	zero,1048(s0)
    stream->eof = 0;
    511c:	00042623          	sw	zero,12(s0)
    if (lseek(stream->fd, offset, whence) < 0)
    5120:	864a                	mv	a2,s2
    5122:	0004859b          	sext.w	a1,s1
    5126:	832fc0ef          	jal	1158 <lseek>
    512a:	87aa                	mv	a5,a0
    return 0;
    512c:	4501                	li	a0,0
    if (lseek(stream->fd, offset, whence) < 0)
    512e:	0207c463          	bltz	a5,5156 <fseek+0x5e>
}
    5132:	60e2                	ld	ra,24(sp)
    5134:	6442                	ld	s0,16(sp)
    5136:	64a2                	ld	s1,8(sp)
    5138:	6902                	ld	s2,0(sp)
    513a:	6105                	addi	sp,sp,32
    513c:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    513e:	4108                	lw	a0,0(a0)
    5140:	01040593          	addi	a1,s0,16
    5144:	f85fb0ef          	jal	10c8 <write>
        if (ret < stream->buf_write_pos)
    5148:	41042783          	lw	a5,1040(s0)
    514c:	00f54963          	blt	a0,a5,515e <fseek+0x66>
        stream->buf_write_pos = 0;
    5150:	40042823          	sw	zero,1040(s0)
    5154:	bf7d                	j	5112 <fseek+0x1a>
        stream->error = 1;
    5156:	4785                	li	a5,1
    5158:	c41c                	sw	a5,8(s0)
        return -1;
    515a:	557d                	li	a0,-1
    515c:	bfd9                	j	5132 <fseek+0x3a>
            stream->error = 1;
    515e:	4785                	li	a5,1
    5160:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    5162:	40042823          	sw	zero,1040(s0)
            return EOF;
    5166:	b775                	j	5112 <fseek+0x1a>
        return -1;
    5168:	557d                	li	a0,-1
}
    516a:	8082                	ret

000000000000516c <ftell>:
    if (!stream)
    516c:	c505                	beqz	a0,5194 <ftell+0x28>
{
    516e:	1141                	addi	sp,sp,-16
    5170:	e022                	sd	s0,0(sp)
    5172:	842a                	mv	s0,a0
    int64 ret = lseek(stream->fd, 0, SEEK_CUR);
    5174:	4108                	lw	a0,0(a0)
    5176:	4605                	li	a2,1
    5178:	4581                	li	a1,0
{
    517a:	e406                	sd	ra,8(sp)
    int64 ret = lseek(stream->fd, 0, SEEK_CUR);
    517c:	fddfb0ef          	jal	1158 <lseek>
    if (ret < 0)
    5180:	00054663          	bltz	a0,518c <ftell+0x20>
}
    5184:	60a2                	ld	ra,8(sp)
    5186:	6402                	ld	s0,0(sp)
    5188:	0141                	addi	sp,sp,16
    518a:	8082                	ret
        stream->error = 1;
    518c:	4785                	li	a5,1
    518e:	c41c                	sw	a5,8(s0)
        return -1L;
    5190:	557d                	li	a0,-1
    5192:	bfcd                	j	5184 <ftell+0x18>
    5194:	557d                	li	a0,-1
}
    5196:	8082                	ret

0000000000005198 <rewind>:
    if (stream)
    5198:	c915                	beqz	a0,51cc <rewind+0x34>
    if (stream->buf_write_pos > 0)
    519a:	41052603          	lw	a2,1040(a0)
{
    519e:	1141                	addi	sp,sp,-16
    51a0:	e022                	sd	s0,0(sp)
    51a2:	e406                	sd	ra,8(sp)
    51a4:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    51a6:	02c04463          	bgtz	a2,51ce <rewind+0x36>
    if (lseek(stream->fd, offset, whence) < 0)
    51aa:	4008                	lw	a0,0(s0)
    stream->buf_read_pos = 0;
    51ac:	40042a23          	sw	zero,1044(s0)
    stream->buf_read_cnt = 0;
    51b0:	40042c23          	sw	zero,1048(s0)
    stream->eof = 0;
    51b4:	00042623          	sw	zero,12(s0)
    if (lseek(stream->fd, offset, whence) < 0)
    51b8:	4601                	li	a2,0
    51ba:	4581                	li	a1,0
    51bc:	f9dfb0ef          	jal	1158 <lseek>
}
    51c0:	60a2                	ld	ra,8(sp)
        stream->error = 0;
    51c2:	00042423          	sw	zero,8(s0)
}
    51c6:	6402                	ld	s0,0(sp)
    51c8:	0141                	addi	sp,sp,16
    51ca:	8082                	ret
    51cc:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    51ce:	4108                	lw	a0,0(a0)
    51d0:	01040593          	addi	a1,s0,16
    51d4:	ef5fb0ef          	jal	10c8 <write>
        if (ret < stream->buf_write_pos)
    51d8:	41042783          	lw	a5,1040(s0)
    51dc:	00f54563          	blt	a0,a5,51e6 <rewind+0x4e>
        stream->buf_write_pos = 0;
    51e0:	40042823          	sw	zero,1040(s0)
    51e4:	b7d9                	j	51aa <rewind+0x12>
            stream->error = 1;
    51e6:	4785                	li	a5,1
    51e8:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    51ea:	40042823          	sw	zero,1040(s0)
            return EOF;
    51ee:	bf75                	j	51aa <rewind+0x12>

00000000000051f0 <feof>:
    return (stream) ? stream->eof : 1;
    51f0:	c119                	beqz	a0,51f6 <feof+0x6>
    51f2:	4548                	lw	a0,12(a0)
    51f4:	8082                	ret
    51f6:	4505                	li	a0,1
}
    51f8:	8082                	ret

00000000000051fa <ferror>:
     return (stream) ? stream->error : 1;
    51fa:	c119                	beqz	a0,5200 <ferror+0x6>
    51fc:	4508                	lw	a0,8(a0)
    51fe:	8082                	ret
    5200:	4505                	li	a0,1
}
    5202:	8082                	ret

0000000000005204 <clearerr>:
    if (stream)
    5204:	c509                	beqz	a0,520e <clearerr+0xa>
        stream->error = 0;
    5206:	00052423          	sw	zero,8(a0)
        stream->eof = 0;
    520a:	00052623          	sw	zero,12(a0)
}
    520e:	8082                	ret

0000000000005210 <ungetc>:
    if (!stream || c == EOF)
    5210:	c19d                	beqz	a1,5236 <ungetc+0x26>
    5212:	57fd                	li	a5,-1
    5214:	02f50163          	beq	a0,a5,5236 <ungetc+0x26>
    if (stream->buf_read_pos > 0)
    5218:	4145a783          	lw	a5,1044(a1)
    521c:	00f05d63          	blez	a5,5236 <ungetc+0x26>
        stream->buf_read_pos--;
    5220:	fff7871b          	addiw	a4,a5,-1
    5224:	40e5aa23          	sw	a4,1044(a1)
        stream->buffer[stream->buf_read_pos] = (char)c;
    5228:	00e587b3          	add	a5,a1,a4
    522c:	00a78823          	sb	a0,16(a5)
        stream->eof = 0;
    5230:	0005a623          	sw	zero,12(a1)
        return c;
    5234:	8082                	ret
        return EOF;
    5236:	557d                	li	a0,-1
    5238:	8082                	ret

000000000000523a <strtoull.part.0>:
    return new_ptr;
}

/* String Conversion*/

unsigned long long strtoull(const char *nptr, char **endptr, int base)
    523a:	1141                	addi	sp,sp,-16
    523c:	e422                	sd	s0,8(sp)
    523e:	8eaa                	mv	t4,a0
{
    const char *s = nptr;
    5240:	88aa                	mv	a7,a0
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    static inline int islower(int c) { return c >= 'a' && c <= 'z'; }
    static inline int isupper(int c) { return c >= 'A' && c <= 'Z'; }
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    static inline int isalnum(int c) { return isalpha(c) || isdigit(c); }
    static inline int isspace(int c) { return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r'; }
    5242:	02000313          	li	t1,32
    5246:	4e11                	li	t3,4
        return 0;
    }

    do
    {
        c = *s++;
    5248:	0008c783          	lbu	a5,0(a7)
    524c:	00188813          	addi	a6,a7,1
    5250:	ff77871b          	addiw	a4,a5,-9
    5254:	0ff77693          	zext.b	a3,a4
    5258:	0007871b          	sext.w	a4,a5
    525c:	04678363          	beq	a5,t1,52a2 <strtoull.part.0+0x68>
    5260:	04de7163          	bgeu	t3,a3,52a2 <strtoull.part.0+0x68>
    } while (isspace(c));

    if (c == '-')
    5264:	02d00793          	li	a5,45
    5268:	0ef70863          	beq	a4,a5,5358 <strtoull.part.0+0x11e>
    {
        neg = 1;
        c = *s++;
    }
    else if (c == '+')
    526c:	02b00793          	li	a5,43
    int neg = 0, any, cutlim;
    5270:	4381                	li	t2,0
    else if (c == '+')
    5272:	08f70c63          	beq	a4,a5,530a <strtoull.part.0+0xd0>
    {
        c = *s++;
    }

    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    5276:	ea05                	bnez	a2,52a6 <strtoull.part.0+0x6c>
    5278:	03000793          	li	a5,48
    527c:	0ef70463          	beq	a4,a5,5364 <strtoull.part.0+0x12a>
    5280:	00ccd8b7          	lui	a7,0xccd
    5284:	ccd88893          	addi	a7,a7,-819 # cccccd <_ZSt4cerr+0xcc3f0d>
    5288:	08b2                	slli	a7,a7,0xc
    528a:	ccd88893          	addi	a7,a7,-819
    528e:	08b2                	slli	a7,a7,0xc
    5290:	ccd88893          	addi	a7,a7,-819
    5294:	08b6                	slli	a7,a7,0xd
    5296:	4415                	li	s0,5
    5298:	99988893          	addi	a7,a7,-1639
    529c:	42a9                	li	t0,10
        c = s[1];
        s += 2;
        base = 16;
    }
    if (base == 0)
        base = (c == '0' ? 8 : 10);
    529e:	4629                	li	a2,10
    52a0:	a829                	j	52ba <strtoull.part.0+0x80>
unsigned long long strtoull(const char *nptr, char **endptr, int base)
    52a2:	88c2                	mv	a7,a6
    52a4:	b755                	j	5248 <strtoull.part.0+0xe>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    52a6:	47c1                	li	a5,16
    52a8:	0cf60d63          	beq	a2,a5,5382 <strtoull.part.0+0x148>

    cutoff = ULLONG_MAX / (unsigned long long)base;
    52ac:	58fd                	li	a7,-1
    cutlim = ULLONG_MAX % (unsigned long long)base;
    52ae:	02c8f433          	remu	s0,a7,a2
    cutoff = ULLONG_MAX / (unsigned long long)base;
    52b2:	82b2                	mv	t0,a2
    52b4:	02c8d8b3          	divu	a7,a7,a2
    cutlim = ULLONG_MAX % (unsigned long long)base;
    52b8:	2401                	sext.w	s0,s0

    for (acc = 0, any = 0;; c = *s++)
    52ba:	4301                	li	t1,0
    52bc:	4501                	li	a0,0
    {
        if (isdigit(c))
    52be:	4e25                	li	t3,9
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    52c0:	4fe5                	li	t6,25
            break;

        if (c >= base)
            break;

        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    52c2:	5f7d                	li	t5,-1
        if (isdigit(c))
    52c4:	fd07079b          	addiw	a5,a4,-48
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    52c8:	0007069b          	sext.w	a3,a4
    52cc:	00fe7e63          	bgeu	t3,a5,52e8 <strtoull.part.0+0xae>
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    52d0:	f9f6879b          	addiw	a5,a3,-97
    52d4:	04fff063          	bgeu	t6,a5,5314 <strtoull.part.0+0xda>
    52d8:	fbf6869b          	addiw	a3,a3,-65
    52dc:	04dfe163          	bltu	t6,a3,531e <strtoull.part.0+0xe4>
            c -= isupper(c) ? 'A' - 10 : 'a' - 10;
    52e0:	03700793          	li	a5,55
    52e4:	40f707bb          	subw	a5,a4,a5
        if (c >= base)
    52e8:	02c7db63          	bge	a5,a2,531e <strtoull.part.0+0xe4>
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    52ec:	01e30b63          	beq	t1,t5,5302 <strtoull.part.0+0xc8>
            any = -1;
    52f0:	537d                	li	t1,-1
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    52f2:	00a8e863          	bltu	a7,a0,5302 <strtoull.part.0+0xc8>
    52f6:	05150e63          	beq	a0,a7,5352 <strtoull.part.0+0x118>
        else
        {
            any = 1;
    52fa:	4305                	li	t1,1
            acc *= base;
    52fc:	02550533          	mul	a0,a0,t0
            acc += c;
    5300:	953e                	add	a0,a0,a5
    for (acc = 0, any = 0;; c = *s++)
    5302:	0805                	addi	a6,a6,1
    5304:	fff84703          	lbu	a4,-1(a6)
        if (isdigit(c))
    5308:	bf75                	j	52c4 <strtoull.part.0+0x8a>
        c = *s++;
    530a:	00084703          	lbu	a4,0(a6)
    530e:	00288813          	addi	a6,a7,2
    5312:	b795                	j	5276 <strtoull.part.0+0x3c>
            c -= isupper(c) ? 'A' - 10 : 'a' - 10;
    5314:	05700793          	li	a5,87
    5318:	40f707bb          	subw	a5,a4,a5
    531c:	b7f1                	j	52e8 <strtoull.part.0+0xae>
        }
    }

    if (any < 0)
    531e:	57fd                	li	a5,-1
    5320:	00f30e63          	beq	t1,a5,533c <strtoull.part.0+0x102>
    {
        acc = ULLONG_MAX;
        errno = ERANGE;
    }
    else if (neg)
    5324:	00038463          	beqz	t2,532c <strtoull.part.0+0xf2>
        acc = -acc;
    5328:	40a00533          	neg	a0,a0

    if (endptr != 0)
    532c:	c589                	beqz	a1,5336 <strtoull.part.0+0xfc>
        *endptr = (char *)(any ? s - 1 : nptr);
    532e:	00031f63          	bnez	t1,534c <strtoull.part.0+0x112>
    5332:	01d5b023          	sd	t4,0(a1)

    return acc;
}
    5336:	6422                	ld	s0,8(sp)
    5338:	0141                	addi	sp,sp,16
    533a:	8082                	ret
        errno = ERANGE;
    533c:	02200793          	li	a5,34
    5340:	00004717          	auipc	a4,0x4
    5344:	94f72423          	sw	a5,-1720(a4) # 8c88 <errno>
        acc = ULLONG_MAX;
    5348:	557d                	li	a0,-1
    if (endptr != 0)
    534a:	d5f5                	beqz	a1,5336 <strtoull.part.0+0xfc>
        *endptr = (char *)(any ? s - 1 : nptr);
    534c:	fff80e93          	addi	t4,a6,-1
    5350:	b7cd                	j	5332 <strtoull.part.0+0xf8>
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    5352:	faf448e3          	blt	s0,a5,5302 <strtoull.part.0+0xc8>
    5356:	b755                	j	52fa <strtoull.part.0+0xc0>
        c = *s++;
    5358:	00084703          	lbu	a4,0(a6)
        neg = 1;
    535c:	4385                	li	t2,1
        c = *s++;
    535e:	00288813          	addi	a6,a7,2
    5362:	bf11                	j	5276 <strtoull.part.0+0x3c>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    5364:	00084783          	lbu	a5,0(a6)
    5368:	05800693          	li	a3,88
    536c:	0df7f793          	andi	a5,a5,223
    5370:	02d78b63          	beq	a5,a3,53a6 <strtoull.part.0+0x16c>
    5374:	58fd                	li	a7,-1
    5376:	441d                	li	s0,7
    5378:	0038d893          	srli	a7,a7,0x3
    537c:	42a1                	li	t0,8
        base = (c == '0' ? 8 : 10);
    537e:	4621                	li	a2,8
    5380:	bf2d                	j	52ba <strtoull.part.0+0x80>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    5382:	03000793          	li	a5,48
    5386:	00f70863          	beq	a4,a5,5396 <strtoull.part.0+0x15c>
    538a:	58fd                	li	a7,-1
    538c:	443d                	li	s0,15
    538e:	0048d893          	srli	a7,a7,0x4
    5392:	42c1                	li	t0,16
    5394:	b71d                	j	52ba <strtoull.part.0+0x80>
    5396:	00084783          	lbu	a5,0(a6)
    539a:	05800693          	li	a3,88
    539e:	0df7f793          	andi	a5,a5,223
    53a2:	fed794e3          	bne	a5,a3,538a <strtoull.part.0+0x150>
        s += 2;
    53a6:	58fd                	li	a7,-1
        c = s[1];
    53a8:	00184703          	lbu	a4,1(a6)
        s += 2;
    53ac:	443d                	li	s0,15
    53ae:	0809                	addi	a6,a6,2
    53b0:	0048d893          	srli	a7,a7,0x4
    53b4:	42c1                	li	t0,16
        base = 16;
    53b6:	4641                	li	a2,16
    53b8:	b709                	j	52ba <strtoull.part.0+0x80>

00000000000053ba <atexit>:
    if (__atexit_func_count >= ATEXIT_MAX)
    53ba:	00004717          	auipc	a4,0x4
    53be:	8ce70713          	addi	a4,a4,-1842 # 8c88 <errno>
    53c2:	435c                	lw	a5,4(a4)
    53c4:	46fd                	li	a3,31
    53c6:	00f6ca63          	blt	a3,a5,53da <atexit+0x20>
    __atexit_funcs[__atexit_func_count++] = function;
    53ca:	00379693          	slli	a3,a5,0x3
    53ce:	96ba                	add	a3,a3,a4
    53d0:	2785                	addiw	a5,a5,1
    53d2:	e688                	sd	a0,8(a3)
    53d4:	c35c                	sw	a5,4(a4)
    return 0;
    53d6:	4501                	li	a0,0
    53d8:	8082                	ret
        return -1;
    53da:	557d                	li	a0,-1
}
    53dc:	8082                	ret

00000000000053de <exit>:
{
    53de:	1101                	addi	sp,sp,-32
    53e0:	e822                	sd	s0,16(sp)
    while (__atexit_func_count > 0)
    53e2:	00004417          	auipc	s0,0x4
    53e6:	8a640413          	addi	s0,s0,-1882 # 8c88 <errno>
    53ea:	405c                	lw	a5,4(s0)
{
    53ec:	e426                	sd	s1,8(sp)
    53ee:	ec06                	sd	ra,24(sp)
    53f0:	84aa                	mv	s1,a0
    while (__atexit_func_count > 0)
    53f2:	00f05d63          	blez	a5,540c <exit+0x2e>
        (__atexit_funcs[--__atexit_func_count])();
    53f6:	fff7871b          	addiw	a4,a5,-1
    53fa:	87ba                	mv	a5,a4
    53fc:	070e                	slli	a4,a4,0x3
    53fe:	9722                	add	a4,a4,s0
    5400:	6718                	ld	a4,8(a4)
    5402:	c05c                	sw	a5,4(s0)
    5404:	9702                	jalr	a4
    while (__atexit_func_count > 0)
    5406:	405c                	lw	a5,4(s0)
    5408:	fef047e3          	bgtz	a5,53f6 <exit+0x18>
    sys_exit(status);
    540c:	8526                	mv	a0,s1
    540e:	c93fb0ef          	jal	10a0 <sys_exit>
    while (1)
    5412:	a001                	j	5412 <exit+0x34>

0000000000005414 <abort>:
{
    5414:	1141                	addi	sp,sp,-16
    exit(127);
    5416:	07f00513          	li	a0,127
{
    541a:	e406                	sd	ra,8(sp)
    exit(127);
    541c:	fc3ff0ef          	jal	53de <exit>

0000000000005420 <getenv>:
}
    5420:	4501                	li	a0,0
    5422:	8082                	ret

0000000000005424 <system>:
}
    5424:	557d                	li	a0,-1
    5426:	8082                	ret

0000000000005428 <free>:
    if (!ptr)
    5428:	c121                	beqz	a0,5468 <free+0x40>
    for (p = freep; !(bp > p && bp < p->next); p = p->next)
    542a:	00004617          	auipc	a2,0x4
    542e:	85e60613          	addi	a2,a2,-1954 # 8c88 <errno>
    5432:	10863783          	ld	a5,264(a2)
    bp = (header_t *)ptr - 1;
    5436:	ff050693          	addi	a3,a0,-16
        if (p >= p->next && (bp > p || bp < p->next))
    543a:	6798                	ld	a4,8(a5)
    for (p = freep; !(bp > p && bp < p->next); p = p->next)
    543c:	02d7f763          	bgeu	a5,a3,546a <free+0x42>
    5440:	00e6e463          	bltu	a3,a4,5448 <free+0x20>
        if (p >= p->next && (bp > p || bp < p->next))
    5444:	02e7e763          	bltu	a5,a4,5472 <free+0x4a>
    if ((char *)bp + bp->size == (char *)p->next)
    5448:	ff053583          	ld	a1,-16(a0)
    544c:	00b68833          	add	a6,a3,a1
    5450:	03070363          	beq	a4,a6,5476 <free+0x4e>
    if ((char *)p + p->size == (char *)bp)
    5454:	638c                	ld	a1,0(a5)
    5456:	fee53c23          	sd	a4,-8(a0)
    545a:	00b78833          	add	a6,a5,a1
    545e:	03068963          	beq	a3,a6,5490 <free+0x68>
    5462:	e794                	sd	a3,8(a5)
    freep = p;
    5464:	10f63423          	sd	a5,264(a2)
}
    5468:	8082                	ret
        if (p >= p->next && (bp > p || bp < p->next))
    546a:	00e7e463          	bltu	a5,a4,5472 <free+0x4a>
    546e:	fce6ede3          	bltu	a3,a4,5448 <free+0x20>
{
    5472:	87ba                	mv	a5,a4
    5474:	b7d9                	j	543a <free+0x12>
        bp->size += p->next->size;
    5476:	00073803          	ld	a6,0(a4)
        bp->next = p->next->next;
    547a:	6718                	ld	a4,8(a4)
        bp->size += p->next->size;
    547c:	95c2                	add	a1,a1,a6
    547e:	feb53823          	sd	a1,-16(a0)
    if ((char *)p + p->size == (char *)bp)
    5482:	638c                	ld	a1,0(a5)
    5484:	fee53c23          	sd	a4,-8(a0)
    5488:	00b78833          	add	a6,a5,a1
    548c:	fd069be3          	bne	a3,a6,5462 <free+0x3a>
        p->size += bp->size;
    5490:	ff053503          	ld	a0,-16(a0)
        p->next = bp->next;
    5494:	86ba                	mv	a3,a4
        p->size += bp->size;
    5496:	00b50733          	add	a4,a0,a1
    549a:	e398                	sd	a4,0(a5)
        p->next = bp->next;
    549c:	b7d9                	j	5462 <free+0x3a>

000000000000549e <malloc>:
    if (size == 0)
    549e:	c54d                	beqz	a0,5548 <malloc+0xaa>
{
    54a0:	1101                	addi	sp,sp,-32
    54a2:	e426                	sd	s1,8(sp)
    if ((prevp = freep) == NULL)
    54a4:	00003497          	auipc	s1,0x3
    54a8:	7e448493          	addi	s1,s1,2020 # 8c88 <errno>
    54ac:	1084b783          	ld	a5,264(s1)
{
    54b0:	e822                	sd	s0,16(sp)
    size = ALIGN(size + sizeof(header_t));
    54b2:	057d                	addi	a0,a0,31
{
    54b4:	ec06                	sd	ra,24(sp)
    size = ALIGN(size + sizeof(header_t));
    54b6:	ff057413          	andi	s0,a0,-16
    if ((prevp = freep) == NULL)
    54ba:	c7b5                	beqz	a5,5526 <malloc+0x88>
    for (p = prevp->next;; prevp = p, p = p->next)
    54bc:	6788                	ld	a0,8(a5)
        if (p->size >= size)
    54be:	6118                	ld	a4,0(a0)
    54c0:	04877663          	bgeu	a4,s0,550c <malloc+0x6e>
    54c4:	e04a                	sd	s2,0(sp)
    if (cp == (void *)-1)
    54c6:	597d                	li	s2,-1
    54c8:	a029                	j	54d2 <malloc+0x34>
    for (p = prevp->next;; prevp = p, p = p->next)
    54ca:	6788                	ld	a0,8(a5)
        if (p->size >= size)
    54cc:	6118                	ld	a4,0(a0)
    54ce:	02877e63          	bgeu	a4,s0,550a <malloc+0x6c>
        if (p == freep)
    54d2:	1084b703          	ld	a4,264(s1)
    54d6:	87aa                	mv	a5,a0
    54d8:	fea719e3          	bne	a4,a0,54ca <malloc+0x2c>
    cp = (char *)sbrk(nu);
    54dc:	6505                	lui	a0,0x1
    54de:	c53fb0ef          	jal	1130 <sbrk>
    54e2:	87aa                	mv	a5,a0
    free((void *)(up + 1));
    54e4:	0541                	addi	a0,a0,16 # 1010 <main+0xfc>
    if (cp == (void *)-1)
    54e6:	01278963          	beq	a5,s2,54f8 <malloc+0x5a>
    up->size = nu;
    54ea:	6705                	lui	a4,0x1
    54ec:	e398                	sd	a4,0(a5)
    free((void *)(up + 1));
    54ee:	f3bff0ef          	jal	5428 <free>
    return freep;
    54f2:	1084b783          	ld	a5,264(s1)
            if ((p = morecore(nunits * sizeof(header_t))) == NULL)
    54f6:	fbf1                	bnez	a5,54ca <malloc+0x2c>
}
    54f8:	60e2                	ld	ra,24(sp)
    54fa:	6442                	ld	s0,16(sp)
                errno = ENOMEM;
    54fc:	47b1                	li	a5,12
    54fe:	c09c                	sw	a5,0(s1)
                return NULL;
    5500:	6902                	ld	s2,0(sp)
}
    5502:	64a2                	ld	s1,8(sp)
        return NULL;
    5504:	4501                	li	a0,0
}
    5506:	6105                	addi	sp,sp,32
    5508:	8082                	ret
    550a:	6902                	ld	s2,0(sp)
            if (p->size == size)
    550c:	02e40b63          	beq	s0,a4,5542 <malloc+0xa4>
                p = (header_t *)((char *)p + p->size);
    5510:	953a                	add	a0,a0,a4
                p->size = (nunits * sizeof(header_t));
    5512:	00053023          	sd	zero,0(a0)
}
    5516:	60e2                	ld	ra,24(sp)
    5518:	6442                	ld	s0,16(sp)
            freep = prevp;
    551a:	10f4b423          	sd	a5,264(s1)
            return (void *)(p + 1);
    551e:	0541                	addi	a0,a0,16
}
    5520:	64a2                	ld	s1,8(sp)
    5522:	6105                	addi	sp,sp,32
    5524:	8082                	ret
        base.next = freep = prevp = &base;
    5526:	00004517          	auipc	a0,0x4
    552a:	87250513          	addi	a0,a0,-1934 # 8d98 <base>
    552e:	10a4b423          	sd	a0,264(s1)
    5532:	10a4bc23          	sd	a0,280(s1)
        base.size = 0;
    5536:	00004797          	auipc	a5,0x4
    553a:	8607b123          	sd	zero,-1950(a5) # 8d98 <base>
        if (p->size >= size)
    553e:	f059                	bnez	s0,54c4 <malloc+0x26>
        base.next = freep = prevp = &base;
    5540:	87aa                	mv	a5,a0
                prevp->next = p->next;
    5542:	6518                	ld	a4,8(a0)
    5544:	e798                	sd	a4,8(a5)
    5546:	bfc1                	j	5516 <malloc+0x78>
        return NULL;
    5548:	4501                	li	a0,0
}
    554a:	8082                	ret

000000000000554c <calloc>:
    if (__builtin_mul_overflow(nmemb, size, &total))
    554c:	02b537b3          	mulhu	a5,a0,a1
{
    5550:	1101                	addi	sp,sp,-32
    5552:	e822                	sd	s0,16(sp)
    5554:	ec06                	sd	ra,24(sp)
    5556:	e426                	sd	s1,8(sp)
    if (__builtin_mul_overflow(nmemb, size, &total))
    5558:	02b50433          	mul	s0,a0,a1
    555c:	e385                	bnez	a5,557c <calloc+0x30>
    void *p = malloc(total);
    555e:	8522                	mv	a0,s0
    5560:	f3fff0ef          	jal	549e <malloc>
    5564:	84aa                	mv	s1,a0
    if (p)
    5566:	c509                	beqz	a0,5570 <calloc+0x24>
        memset(p, 0, total);
    5568:	8622                	mv	a2,s0
    556a:	4581                	li	a1,0
    556c:	524000ef          	jal	5a90 <memset>
}
    5570:	60e2                	ld	ra,24(sp)
    5572:	6442                	ld	s0,16(sp)
    5574:	8526                	mv	a0,s1
    5576:	64a2                	ld	s1,8(sp)
    5578:	6105                	addi	sp,sp,32
    557a:	8082                	ret
    557c:	60e2                	ld	ra,24(sp)
    557e:	6442                	ld	s0,16(sp)
        errno = ENOMEM;
    5580:	47b1                	li	a5,12
        return NULL;
    5582:	4481                	li	s1,0
        errno = ENOMEM;
    5584:	00003717          	auipc	a4,0x3
    5588:	70f72223          	sw	a5,1796(a4) # 8c88 <errno>
}
    558c:	8526                	mv	a0,s1
    558e:	64a2                	ld	s1,8(sp)
    5590:	6105                	addi	sp,sp,32
    5592:	8082                	ret

0000000000005594 <realloc>:
    if (!ptr)
    5594:	c929                	beqz	a0,55e6 <realloc+0x52>
{
    5596:	1101                	addi	sp,sp,-32
    5598:	ec06                	sd	ra,24(sp)
    559a:	e426                	sd	s1,8(sp)
    if (size == 0)
    559c:	c5b9                	beqz	a1,55ea <realloc+0x56>
    if (bp->size >= new_size)
    559e:	ff053703          	ld	a4,-16(a0)
    size_t new_size = ALIGN(size + sizeof(header_t));
    55a2:	01f58793          	addi	a5,a1,31
    55a6:	e822                	sd	s0,16(sp)
    55a8:	9bc1                	andi	a5,a5,-16
    55aa:	842a                	mv	s0,a0
        return ptr;
    55ac:	84aa                	mv	s1,a0
    if (bp->size >= new_size)
    55ae:	00f76863          	bltu	a4,a5,55be <realloc+0x2a>
    55b2:	6442                	ld	s0,16(sp)
}
    55b4:	60e2                	ld	ra,24(sp)
    55b6:	8526                	mv	a0,s1
    55b8:	64a2                	ld	s1,8(sp)
    55ba:	6105                	addi	sp,sp,32
    55bc:	8082                	ret
    void *new_ptr = malloc(size);
    55be:	852e                	mv	a0,a1
    55c0:	edfff0ef          	jal	549e <malloc>
    55c4:	84aa                	mv	s1,a0
    if (!new_ptr)
    55c6:	d575                	beqz	a0,55b2 <realloc+0x1e>
    memcpy(new_ptr, ptr, bp->size - sizeof(header_t));
    55c8:	ff043603          	ld	a2,-16(s0)
    55cc:	85a2                	mv	a1,s0
    55ce:	1641                	addi	a2,a2,-16
    55d0:	514000ef          	jal	5ae4 <memcpy>
    free(ptr);
    55d4:	8522                	mv	a0,s0
    55d6:	e53ff0ef          	jal	5428 <free>
}
    55da:	60e2                	ld	ra,24(sp)
    free(ptr);
    55dc:	6442                	ld	s0,16(sp)
}
    55de:	8526                	mv	a0,s1
    55e0:	64a2                	ld	s1,8(sp)
    55e2:	6105                	addi	sp,sp,32
    55e4:	8082                	ret
        return malloc(size);
    55e6:	852e                	mv	a0,a1
    55e8:	bd5d                	j	549e <malloc>
        free(ptr);
    55ea:	e3fff0ef          	jal	5428 <free>
        return NULL;
    55ee:	4481                	li	s1,0
    55f0:	b7d1                	j	55b4 <realloc+0x20>

00000000000055f2 <strtoull>:
    if (base < 0 || base == 1 || base > 36)
    55f2:	02400813          	li	a6,36
{
    55f6:	86aa                	mv	a3,a0
    55f8:	872e                	mv	a4,a1
    if (base < 0 || base == 1 || base > 36)
    55fa:	00c86663          	bltu	a6,a2,5606 <strtoull+0x14>
    55fe:	4805                	li	a6,1
    5600:	01060363          	beq	a2,a6,5606 <strtoull+0x14>
    5604:	b91d                	j	523a <strtoull.part.0>
        if (endptr)
    5606:	c311                	beqz	a4,560a <strtoull+0x18>
            *endptr = (char *)nptr;
    5608:	e314                	sd	a3,0(a4)
        errno = 0; /* EINVAL */
    560a:	00003797          	auipc	a5,0x3
    560e:	6607af23          	sw	zero,1662(a5) # 8c88 <errno>
}
    5612:	4501                	li	a0,0
    5614:	8082                	ret

0000000000005616 <strtoll>:

long long strtoll(const char *nptr, char **endptr, int base)
{
    5616:	1141                	addi	sp,sp,-16
    5618:	e406                	sd	ra,8(sp)
    561a:	e022                	sd	s0,0(sp)
    const char *s = nptr;
    561c:	86aa                	mv	a3,a0
    static inline int isspace(int c) { return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r'; }
    561e:	02000813          	li	a6,32
    5622:	4891                	li	a7,4
    unsigned long long acc;
    int c, neg = 0;

    do
    {
        c = *s++;
    5624:	0006c783          	lbu	a5,0(a3)
    5628:	0685                	addi	a3,a3,1
    562a:	ff77871b          	addiw	a4,a5,-9
    562e:	0ff77713          	zext.b	a4,a4
    5632:	0007841b          	sext.w	s0,a5
    5636:	ff0787e3          	beq	a5,a6,5624 <strtoll+0xe>
    563a:	fee8f5e3          	bgeu	a7,a4,5624 <strtoll+0xe>
    if (base < 0 || base == 1 || base > 36)
    563e:	02400793          	li	a5,36
    5642:	02c7ec63          	bltu	a5,a2,567a <strtoll+0x64>
    5646:	4785                	li	a5,1
    5648:	02f60963          	beq	a2,a5,567a <strtoll+0x64>
    564c:	befff0ef          	jal	523a <strtoull.part.0>
    if (c == '-')
        neg = 1;

    acc = strtoull(nptr, endptr, base);

    if (errno == ERANGE && acc == ULLONG_MAX)
    5650:	00003797          	auipc	a5,0x3
    5654:	63878793          	addi	a5,a5,1592 # 8c88 <errno>
    5658:	4394                	lw	a3,0(a5)
    565a:	02200713          	li	a4,34
    565e:	04e68363          	beq	a3,a4,56a4 <strtoll+0x8e>
        return neg ? LLONG_MIN : LLONG_MAX;

    if (!neg && acc > (unsigned long long)LLONG_MAX)
    5662:	02d00713          	li	a4,45
    5666:	02e40563          	beq	s0,a4,5690 <strtoll+0x7a>
    566a:	00055f63          	bgez	a0,5688 <strtoll+0x72>
    {
        errno = ERANGE;
    566e:	02200713          	li	a4,34
    5672:	c398                	sw	a4,0(a5)
        return neg ? LLONG_MIN : LLONG_MAX;
    5674:	557d                	li	a0,-1
    5676:	8105                	srli	a0,a0,0x1
    5678:	a801                	j	5688 <strtoll+0x72>
        if (endptr)
    567a:	c191                	beqz	a1,567e <strtoll+0x68>
            *endptr = (char *)nptr;
    567c:	e188                	sd	a0,0(a1)
        errno = 0; /* EINVAL */
    567e:	00003797          	auipc	a5,0x3
    5682:	6007a523          	sw	zero,1546(a5) # 8c88 <errno>
    {
        errno = ERANGE;
        return LLONG_MIN;
    }

    return neg ? -(long long)acc : (long long)acc;
    5686:	4501                	li	a0,0
}
    5688:	60a2                	ld	ra,8(sp)
    568a:	6402                	ld	s0,0(sp)
    568c:	0141                	addi	sp,sp,16
    568e:	8082                	ret
    if (neg && acc > (unsigned long long)LLONG_MAX + 1)
    5690:	577d                	li	a4,-1
    5692:	177e                	slli	a4,a4,0x3f
    5694:	02a76263          	bltu	a4,a0,56b8 <strtoll+0xa2>
}
    5698:	60a2                	ld	ra,8(sp)
    569a:	6402                	ld	s0,0(sp)
    return neg ? -(long long)acc : (long long)acc;
    569c:	40a00533          	neg	a0,a0
}
    56a0:	0141                	addi	sp,sp,16
    56a2:	8082                	ret
    if (errno == ERANGE && acc == ULLONG_MAX)
    56a4:	577d                	li	a4,-1
    56a6:	fae51ee3          	bne	a0,a4,5662 <strtoll+0x4c>
        return neg ? LLONG_MIN : LLONG_MAX;
    56aa:	02d00793          	li	a5,45
    56ae:	fcf413e3          	bne	s0,a5,5674 <strtoll+0x5e>
        return LLONG_MIN;
    56b2:	557d                	li	a0,-1
    56b4:	157e                	slli	a0,a0,0x3f
    56b6:	bfc9                	j	5688 <strtoll+0x72>
        errno = ERANGE;
    56b8:	02200713          	li	a4,34
    56bc:	c398                	sw	a4,0(a5)
        return LLONG_MIN;
    56be:	bfd5                	j	56b2 <strtoll+0x9c>

00000000000056c0 <strtoul>:
    if (base < 0 || base == 1 || base > 36)
    56c0:	02400813          	li	a6,36

unsigned long strtoul(const char *nptr, char **endptr, int base)
{
    56c4:	86aa                	mv	a3,a0
    56c6:	872e                	mv	a4,a1
    if (base < 0 || base == 1 || base > 36)
    56c8:	00c86663          	bltu	a6,a2,56d4 <strtoul+0x14>
    56cc:	4805                	li	a6,1
    56ce:	01060363          	beq	a2,a6,56d4 <strtoul+0x14>
    56d2:	b6a5                	j	523a <strtoull.part.0>
        if (endptr)
    56d4:	c311                	beqz	a4,56d8 <strtoul+0x18>
            *endptr = (char *)nptr;
    56d6:	e314                	sd	a3,0(a4)
        errno = 0; /* EINVAL */
    56d8:	00003797          	auipc	a5,0x3
    56dc:	5a07a823          	sw	zero,1456(a5) # 8c88 <errno>
    {
        errno = ERANGE;
        return ULONG_MAX;
    }
    return (unsigned long)ret;
}
    56e0:	4501                	li	a0,0
    56e2:	8082                	ret

00000000000056e4 <strtol>:

long strtol(const char *nptr, char **endptr, int base)
{
    long long ret = strtoll(nptr, endptr, base);
    56e4:	bf0d                	j	5616 <strtoll>

00000000000056e6 <atoi>:
        return LONG_MIN;
    }
    return (long)ret;
}

int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    56e6:	1141                	addi	sp,sp,-16
    long long ret = strtoll(nptr, endptr, base);
    56e8:	4629                	li	a2,10
    56ea:	4581                	li	a1,0
int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    56ec:	e406                	sd	ra,8(sp)
    long long ret = strtoll(nptr, endptr, base);
    56ee:	f29ff0ef          	jal	5616 <strtoll>
int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    56f2:	60a2                	ld	ra,8(sp)
    56f4:	2501                	sext.w	a0,a0
    56f6:	0141                	addi	sp,sp,16
    56f8:	8082                	ret

00000000000056fa <atol>:
    long long ret = strtoll(nptr, endptr, base);
    56fa:	4629                	li	a2,10
    56fc:	4581                	li	a1,0
    56fe:	bf21                	j	5616 <strtoll>

0000000000005700 <atoll>:
long atol(const char *nptr) { return strtol(nptr, NULL, 10); }
long long atoll(const char *nptr) { return strtoll(nptr, NULL, 10); }
    5700:	4629                	li	a2,10
    5702:	4581                	li	a1,0
    5704:	bf09                	j	5616 <strtoll>

0000000000005706 <strtod>:
    5706:	02000693          	li	a3,32
    570a:	4611                	li	a2,4
{
    double val = 0.0;
    int sign = 1;
    const char *s = nptr;

    while (isspace(*s))
    570c:	00054783          	lbu	a5,0(a0)
    5710:	ff77871b          	addiw	a4,a5,-9
    5714:	0ff77713          	zext.b	a4,a4
    5718:	06d78263          	beq	a5,a3,577c <strtod+0x76>
    571c:	06e67063          	bgeu	a2,a4,577c <strtod+0x76>
        s++;
    if (*s == '-')
    5720:	02d00713          	li	a4,45
    5724:	08e78e63          	beq	a5,a4,57c0 <strtod+0xba>
    {
        sign = -1;
        s++;
    }
    else if (*s == '+')
    5728:	02b00713          	li	a4,43
    572c:	0ae78263          	beq	a5,a4,57d0 <strtod+0xca>
    5730:	00001717          	auipc	a4,0x1
    5734:	16873507          	fld	fa0,360(a4) # 6898 <STDIN_FD+0x10>
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    5738:	fd07861b          	addiw	a2,a5,-48
        s++;

    while (isdigit(*s))
    573c:	46a5                	li	a3,9
    573e:	f20007d3          	fmv.d.x	fa5,zero
    5742:	8732                	mv	a4,a2
    5744:	02c6e363          	bltu	a3,a2,576a <strtod+0x64>
    5748:	00001797          	auipc	a5,0x1
    574c:	1587b687          	fld	fa3,344(a5) # 68a0 <STDIN_FD+0x18>
    5750:	4625                	li	a2,9
    5752:	00154783          	lbu	a5,1(a0)
    {
        val = val * 10.0 + (*s - '0');
    5756:	d2070753          	fcvt.d.w	fa4,a4
        s++;
    575a:	0505                	addi	a0,a0,1
    575c:	fd07869b          	addiw	a3,a5,-48
        val = val * 10.0 + (*s - '0');
    5760:	72d7f7c3          	fmadd.d	fa5,fa5,fa3,fa4
    5764:	8736                	mv	a4,a3
    while (isdigit(*s))
    5766:	fed676e3          	bgeu	a2,a3,5752 <strtod+0x4c>
    }
    if (*s == '.')
    576a:	02e00713          	li	a4,46
    576e:	00e78963          	beq	a5,a4,5780 <strtod+0x7a>
            val += (*s - '0') * factor;
            s++;
        }
    }

    if (endptr)
    5772:	c191                	beqz	a1,5776 <strtod+0x70>
        *endptr = (char *)s;
    5774:	e188                	sd	a0,0(a1)
    return val * sign;
}
    5776:	12a7f553          	fmul.d	fa0,fa5,fa0
    577a:	8082                	ret
        s++;
    577c:	0505                	addi	a0,a0,1
    577e:	b779                	j	570c <strtod+0x6>
        while (isdigit(*s))
    5780:	00154703          	lbu	a4,1(a0)
    5784:	46a5                	li	a3,9
        s++;
    5786:	0505                	addi	a0,a0,1
    5788:	fd07071b          	addiw	a4,a4,-48
    578c:	87ba                	mv	a5,a4
        while (isdigit(*s))
    578e:	fee6e2e3          	bltu	a3,a4,5772 <strtod+0x6c>
        double factor = 1.0;
    5792:	00001717          	auipc	a4,0x1
    5796:	10673707          	fld	fa4,262(a4) # 6898 <STDIN_FD+0x10>
    579a:	00001717          	auipc	a4,0x1
    579e:	11e73607          	fld	fa2,286(a4) # 68b8 <STDIN_FD+0x30>
            factor *= 0.1;
    57a2:	12c77753          	fmul.d	fa4,fa4,fa2
        while (isdigit(*s))
    57a6:	00154703          	lbu	a4,1(a0)
            val += (*s - '0') * factor;
    57aa:	d20786d3          	fcvt.d.w	fa3,a5
            s++;
    57ae:	0505                	addi	a0,a0,1
    57b0:	fd07071b          	addiw	a4,a4,-48
    57b4:	87ba                	mv	a5,a4
            val += (*s - '0') * factor;
    57b6:	7ae6f7c3          	fmadd.d	fa5,fa3,fa4,fa5
        while (isdigit(*s))
    57ba:	fee6f4e3          	bgeu	a3,a4,57a2 <strtod+0x9c>
    57be:	bf55                	j	5772 <strtod+0x6c>
    while (isdigit(*s))
    57c0:	00154783          	lbu	a5,1(a0)
    57c4:	00001717          	auipc	a4,0x1
    57c8:	0cc73507          	fld	fa0,204(a4) # 6890 <STDIN_FD+0x8>
        s++;
    57cc:	0505                	addi	a0,a0,1
    57ce:	b7ad                	j	5738 <strtod+0x32>
    while (isdigit(*s))
    57d0:	00154783          	lbu	a5,1(a0)
    57d4:	00001717          	auipc	a4,0x1
    57d8:	0c473507          	fld	fa0,196(a4) # 6898 <STDIN_FD+0x10>
        s++;
    57dc:	0505                	addi	a0,a0,1
    57de:	bfa9                	j	5738 <strtod+0x32>

00000000000057e0 <atof>:

double atof(const char *nptr) { return strtod(nptr, NULL); }
    57e0:	4581                	li	a1,0
    57e2:	b715                	j	5706 <strtod>

00000000000057e4 <strtof>:
float strtof(const char *nptr, char **endptr) { return (float)strtod(nptr, endptr); }
    57e4:	1141                	addi	sp,sp,-16
    57e6:	e406                	sd	ra,8(sp)
    57e8:	f1fff0ef          	jal	5706 <strtod>
    57ec:	60a2                	ld	ra,8(sp)
    57ee:	40157553          	fcvt.s.d	fa0,fa0
    57f2:	0141                	addi	sp,sp,16
    57f4:	8082                	ret

00000000000057f6 <qsort>:
    }
}

void qsort(void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *))
{
    if (nmemb < 2 || size == 0)
    57f6:	4785                	li	a5,1
    57f8:	0cb7fd63          	bgeu	a5,a1,58d2 <qsort+0xdc>
{
    57fc:	715d                	addi	sp,sp,-80
    57fe:	f44e                	sd	s3,40(sp)
    5800:	e486                	sd	ra,72(sp)
    5802:	89b2                	mv	s3,a2
    if (nmemb < 2 || size == 0)
    5804:	c279                	beqz	a2,58ca <qsort+0xd4>
    5806:	e85a                	sd	s6,16(sp)
    5808:	8b2e                	mv	s6,a1
        return;

    char *base_ptr = (char *)base;
    char *pivot = base_ptr + (nmemb - 1) * size;
    580a:	1b7d                	addi	s6,s6,-1
    580c:	fc26                	sd	s1,56(sp)
    580e:	033b04b3          	mul	s1,s6,s3
    5812:	ec56                	sd	s5,24(sp)
    5814:	8aaa                	mv	s5,a0
    5816:	f052                	sd	s4,32(sp)
    5818:	e45e                	sd	s7,8(sp)
    581a:	e0a2                	sd	s0,64(sp)
    581c:	f84a                	sd	s2,48(sp)
    581e:	8a36                	mv	s4,a3
    if (nmemb < 2 || size == 0)
    5820:	4b85                	li	s7,1
    char *pivot = base_ptr + (nmemb - 1) * size;
    5822:	94d6                	add	s1,s1,s5
    char *i = base_ptr;
    char *j = base_ptr;

    /* Partition */
    for (; j < pivot; j += size)
    5824:	069af763          	bgeu	s5,s1,5892 <qsort+0x9c>
    char *j = base_ptr;
    5828:	8956                	mv	s2,s5
    char *i = base_ptr;
    582a:	8456                	mv	s0,s5
    582c:	a021                	j	5834 <qsort+0x3e>
    for (; j < pivot; j += size)
    582e:	994e                	add	s2,s2,s3
    5830:	00997f63          	bgeu	s2,s1,584e <qsort+0x58>
    {
        if (compar(j, pivot) < 0)
    5834:	85a6                	mv	a1,s1
    5836:	854a                	mv	a0,s2
    5838:	9a02                	jalr	s4
    583a:	fe055ae3          	bgez	a0,582e <qsort+0x38>
        {
            if (i != j)
    583e:	05241d63          	bne	s0,s2,5898 <qsort+0xa2>
    5842:	01390633          	add	a2,s2,s3
                swap_bytes(i, j, size);
            i += size;
    5846:	8432                	mv	s0,a2
    for (; j < pivot; j += size)
    5848:	994e                	add	s2,s2,s3
    584a:	fe9965e3          	bltu	s2,s1,5834 <qsort+0x3e>
        }
    }
    swap_bytes(i, pivot, size);

    /* Recurse */
    size_t left_count = (i - base_ptr) / size;
    584e:	415405b3          	sub	a1,s0,s5
    5852:	0335d5b3          	divu	a1,a1,s3
    qsort(base, left_count, size, compar);
    qsort(i + size, nmemb - left_count - 1, size, compar);
    5856:	40bb0b33          	sub	s6,s6,a1
    while (size--)
    585a:	013406b3          	add	a3,s0,s3
        *a++ = *b;
    585e:	0004c703          	lbu	a4,0(s1)
        temp = *a;
    5862:	00044783          	lbu	a5,0(s0)
        *b++ = temp;
    5866:	0485                	addi	s1,s1,1
        *a++ = *b;
    5868:	0405                	addi	s0,s0,1
    586a:	fee40fa3          	sb	a4,-1(s0)
        *b++ = temp;
    586e:	fef48fa3          	sb	a5,-1(s1)
    while (size--)
    5872:	fed416e3          	bne	s0,a3,585e <qsort+0x68>
    qsort(base, left_count, size, compar);
    5876:	86d2                	mv	a3,s4
    5878:	864e                	mv	a2,s3
    587a:	8556                	mv	a0,s5
    587c:	f7bff0ef          	jal	57f6 <qsort>
    if (nmemb < 2 || size == 0)
    5880:	036bfe63          	bgeu	s7,s6,58bc <qsort+0xc6>
    char *pivot = base_ptr + (nmemb - 1) * size;
    5884:	1b7d                	addi	s6,s6,-1
    5886:	033b04b3          	mul	s1,s6,s3
    588a:	8aa2                	mv	s5,s0
    588c:	94d6                	add	s1,s1,s5
    for (; j < pivot; j += size)
    588e:	f89aede3          	bltu	s5,s1,5828 <qsort+0x32>
    char *i = base_ptr;
    5892:	8456                	mv	s0,s5
    for (; j < pivot; j += size)
    5894:	4581                	li	a1,0
    5896:	b7d1                	j	585a <qsort+0x64>
    5898:	01340633          	add	a2,s0,s3
            if (i != j)
    589c:	874a                	mv	a4,s2
    589e:	87a2                	mv	a5,s0
        *a++ = *b;
    58a0:	00074683          	lbu	a3,0(a4)
        temp = *a;
    58a4:	0007c803          	lbu	a6,0(a5)
        *b++ = temp;
    58a8:	0705                	addi	a4,a4,1
        *a++ = *b;
    58aa:	0785                	addi	a5,a5,1
    58ac:	fed78fa3          	sb	a3,-1(a5)
        *b++ = temp;
    58b0:	ff070fa3          	sb	a6,-1(a4)
    while (size--)
    58b4:	fec796e3          	bne	a5,a2,58a0 <qsort+0xaa>
            i += size;
    58b8:	8432                	mv	s0,a2
    58ba:	b779                	j	5848 <qsort+0x52>
    58bc:	6406                	ld	s0,64(sp)
    58be:	74e2                	ld	s1,56(sp)
    58c0:	7942                	ld	s2,48(sp)
    58c2:	7a02                	ld	s4,32(sp)
    58c4:	6ae2                	ld	s5,24(sp)
    58c6:	6b42                	ld	s6,16(sp)
    58c8:	6ba2                	ld	s7,8(sp)
}
    58ca:	60a6                	ld	ra,72(sp)
    58cc:	79a2                	ld	s3,40(sp)
    58ce:	6161                	addi	sp,sp,80
    58d0:	8082                	ret
    58d2:	8082                	ret

00000000000058d4 <bsearch>:

void *bsearch(const void *key, const void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *))
{
    58d4:	715d                	addi	sp,sp,-80
    58d6:	e486                	sd	ra,72(sp)
    58d8:	fc26                	sd	s1,56(sp)
    size_t l = 0, u = nmemb;
    while (l < u)
    58da:	c629                	beqz	a2,5924 <bsearch+0x50>
    58dc:	f84a                	sd	s2,48(sp)
    58de:	f44e                	sd	s3,40(sp)
    58e0:	f052                	sd	s4,32(sp)
    58e2:	ec56                	sd	s5,24(sp)
    58e4:	e85a                	sd	s6,16(sp)
    58e6:	e45e                	sd	s7,8(sp)
    58e8:	e0a2                	sd	s0,64(sp)
    58ea:	8932                	mv	s2,a2
    58ec:	8a2a                	mv	s4,a0
    58ee:	8aae                	mv	s5,a1
    58f0:	8b36                	mv	s6,a3
    58f2:	8bba                	mv	s7,a4
    size_t l = 0, u = nmemb;
    58f4:	4981                	li	s3,0
    {
        size_t idx = (l + u) / 2;
    58f6:	01298433          	add	s0,s3,s2
    58fa:	8005                	srli	s0,s0,0x1
        const void *p = (void *)((const char *)base + (idx * size));
    58fc:	036404b3          	mul	s1,s0,s6
        int cmp = compar(key, p);
    5900:	8552                	mv	a0,s4
        const void *p = (void *)((const char *)base + (idx * size));
    5902:	94d6                	add	s1,s1,s5
        int cmp = compar(key, p);
    5904:	85a6                	mv	a1,s1
    5906:	9b82                	jalr	s7
        if (cmp < 0)
    5908:	02054463          	bltz	a0,5930 <bsearch+0x5c>
            u = idx;
        else if (cmp > 0)
    590c:	c515                	beqz	a0,5938 <bsearch+0x64>
            l = idx + 1;
    590e:	00140993          	addi	s3,s0,1
    while (l < u)
    5912:	ff29e2e3          	bltu	s3,s2,58f6 <bsearch+0x22>
    5916:	6406                	ld	s0,64(sp)
    5918:	7942                	ld	s2,48(sp)
    591a:	79a2                	ld	s3,40(sp)
    591c:	7a02                	ld	s4,32(sp)
    591e:	6ae2                	ld	s5,24(sp)
    5920:	6b42                	ld	s6,16(sp)
    5922:	6ba2                	ld	s7,8(sp)
        else
            return (void *)p;
    }
    return NULL;
}
    5924:	60a6                	ld	ra,72(sp)
    return NULL;
    5926:	4481                	li	s1,0
}
    5928:	8526                	mv	a0,s1
    592a:	74e2                	ld	s1,56(sp)
    592c:	6161                	addi	sp,sp,80
    592e:	8082                	ret
            u = idx;
    5930:	8922                	mv	s2,s0
    while (l < u)
    5932:	fd29e2e3          	bltu	s3,s2,58f6 <bsearch+0x22>
    5936:	b7c5                	j	5916 <bsearch+0x42>
    5938:	6406                	ld	s0,64(sp)
}
    593a:	60a6                	ld	ra,72(sp)
    593c:	7942                	ld	s2,48(sp)
    593e:	79a2                	ld	s3,40(sp)
    5940:	7a02                	ld	s4,32(sp)
    5942:	6ae2                	ld	s5,24(sp)
    5944:	6b42                	ld	s6,16(sp)
    5946:	6ba2                	ld	s7,8(sp)
    5948:	8526                	mv	a0,s1
    594a:	74e2                	ld	s1,56(sp)
    594c:	6161                	addi	sp,sp,80
    594e:	8082                	ret

0000000000005950 <abs>:

/* Math & Mics */

int abs(int j) { return (j < 0) ? -j : j; }
    5950:	41f5579b          	sraiw	a5,a0,0x1f
    5954:	8d3d                	xor	a0,a0,a5
    5956:	9d1d                	subw	a0,a0,a5
    5958:	8082                	ret

000000000000595a <labs>:
long labs(long j) { return (j < 0) ? -j : j; }
    595a:	43f55793          	srai	a5,a0,0x3f
    595e:	8d3d                	xor	a0,a0,a5
    5960:	8d1d                	sub	a0,a0,a5
    5962:	8082                	ret

0000000000005964 <llabs>:
long long llabs(long long j) { return (j < 0) ? -j : j; }
    5964:	43f55793          	srai	a5,a0,0x3f
    5968:	8d3d                	xor	a0,a0,a5
    596a:	8d1d                	sub	a0,a0,a5
    596c:	8082                	ret

000000000000596e <div>:

div_t div(int numer, int denom)
{
    div_t res = {numer / denom, numer % denom};
    596e:	02b547bb          	divw	a5,a0,a1
{
    5972:	1141                	addi	sp,sp,-16
    return res;
}
    5974:	0141                	addi	sp,sp,16
    div_t res = {numer / denom, numer % denom};
    5976:	02b5653b          	remw	a0,a0,a1
    return res;
    597a:	1782                	slli	a5,a5,0x20
    597c:	9381                	srli	a5,a5,0x20
    597e:	1502                	slli	a0,a0,0x20
}
    5980:	8d5d                	or	a0,a0,a5
    5982:	8082                	ret

0000000000005984 <ldiv>:
ldiv_t ldiv(long numer, long denom)
{
    5984:	1141                	addi	sp,sp,-16
    5986:	87aa                	mv	a5,a0
    ldiv_t res = {numer / denom, numer % denom};
    return res;
}
    5988:	02b54533          	div	a0,a0,a1
    598c:	0141                	addi	sp,sp,16
    598e:	02b7e5b3          	rem	a1,a5,a1
    5992:	8082                	ret

0000000000005994 <lldiv>:
lldiv_t lldiv(long long numer, long long denom)
{
    5994:	1141                	addi	sp,sp,-16
    5996:	87aa                	mv	a5,a0
    lldiv_t res = {numer / denom, numer % denom};
    return res;
}
    5998:	02b54533          	div	a0,a0,a1
    599c:	0141                	addi	sp,sp,16
    599e:	02b7e5b3          	rem	a1,a5,a1
    59a2:	8082                	ret

00000000000059a4 <rand>:

static unsigned long next = 1;
int rand(void)
{
    next = next * 1103515245 + 12345;
    59a4:	00003697          	auipc	a3,0x3
    59a8:	23c68693          	addi	a3,a3,572 # 8be0 <next>
    59ac:	629c                	ld	a5,0(a3)
    59ae:	41c65737          	lui	a4,0x41c65
    59b2:	e6d70713          	addi	a4,a4,-403 # 41c64e6d <_ZSt4cerr+0x41c5c0ad>
    59b6:	02e787b3          	mul	a5,a5,a4
    59ba:	670d                	lui	a4,0x3
    59bc:	03970713          	addi	a4,a4,57 # 3039 <stbsp_vsprintfcb+0xd9b>
    59c0:	97ba                	add	a5,a5,a4
    return (unsigned int)(next / 65536) % 32768;
    59c2:	02179513          	slli	a0,a5,0x21
    next = next * 1103515245 + 12345;
    59c6:	e29c                	sd	a5,0(a3)
}
    59c8:	9145                	srli	a0,a0,0x31
    59ca:	8082                	ret

00000000000059cc <srand>:
void srand(unsigned int seed) { next = seed; }
    59cc:	1502                	slli	a0,a0,0x20
    59ce:	9101                	srli	a0,a0,0x20
    59d0:	00003797          	auipc	a5,0x3
    59d4:	20a7b823          	sd	a0,528(a5) # 8be0 <next>
    59d8:	8082                	ret

00000000000059da <mblen>:

/* Stub */
int mblen(const char *s, size_t n) { return (s && *s && n) ? 1 : 0; }
    59da:	c901                	beqz	a0,59ea <mblen+0x10>
    59dc:	00054783          	lbu	a5,0(a0)
    59e0:	4501                	li	a0,0
    59e2:	c789                	beqz	a5,59ec <mblen+0x12>
    59e4:	00b03533          	snez	a0,a1
    59e8:	8082                	ret
    59ea:	4501                	li	a0,0
    59ec:	8082                	ret

00000000000059ee <mbtowc>:
int mbtowc(wchar_t *pwc, const char *s, size_t n)
{
    59ee:	87aa                	mv	a5,a0
    if (!s)
    59f0:	cd81                	beqz	a1,5a08 <mbtowc+0x1a>
        return 0;
    if (n == 0)
        return -1;
    59f2:	557d                	li	a0,-1
    if (n == 0)
    59f4:	ca19                	beqz	a2,5a0a <mbtowc+0x1c>
    if (pwc)
    59f6:	c781                	beqz	a5,59fe <mbtowc+0x10>
        *pwc = (wchar_t)*s;
    59f8:	0005c703          	lbu	a4,0(a1)
    59fc:	c398                	sw	a4,0(a5)
    return (*s != 0);
    59fe:	0005c503          	lbu	a0,0(a1)
    5a02:	00a03533          	snez	a0,a0
    5a06:	8082                	ret
        return 0;
    5a08:	4501                	li	a0,0
}
    5a0a:	8082                	ret

0000000000005a0c <wctomb>:
int wctomb(char *s, wchar_t wchar)
{
    if (!s)
    5a0c:	c509                	beqz	a0,5a16 <wctomb+0xa>
        return 0;
    *s = (char)wchar;
    5a0e:	00b50023          	sb	a1,0(a0)
    return 1;
    5a12:	4505                	li	a0,1
    5a14:	8082                	ret
        return 0;
    5a16:	4501                	li	a0,0
}
    5a18:	8082                	ret

0000000000005a1a <mbstowcs>:
size_t mbstowcs(wchar_t *dest, const char *src, size_t n)
{
    size_t i = 0;
    while (src[i] && i < n)
    5a1a:	0005c703          	lbu	a4,0(a1)
    5a1e:	cb0d                	beqz	a4,5a50 <mbstowcs+0x36>
    5a20:	ca15                	beqz	a2,5a54 <mbstowcs+0x3a>
    5a22:	86aa                	mv	a3,a0
    size_t i = 0;
    5a24:	4781                	li	a5,0
    5a26:	a019                	j	5a2c <mbstowcs+0x12>
    while (src[i] && i < n)
    5a28:	02f60263          	beq	a2,a5,5a4c <mbstowcs+0x32>
    {
        dest[i] = (wchar_t)src[i];
        i++;
    5a2c:	0785                	addi	a5,a5,1
        dest[i] = (wchar_t)src[i];
    5a2e:	c298                	sw	a4,0(a3)
    while (src[i] && i < n)
    5a30:	00f58733          	add	a4,a1,a5
    5a34:	00074703          	lbu	a4,0(a4)
    5a38:	0691                	addi	a3,a3,4
    5a3a:	f77d                	bnez	a4,5a28 <mbstowcs+0xe>
    }
    if (i < n)
    5a3c:	00c7f763          	bgeu	a5,a2,5a4a <mbstowcs+0x30>
        dest[i] = 0;
    5a40:	00279713          	slli	a4,a5,0x2
    5a44:	953a                	add	a0,a0,a4
    5a46:	00052023          	sw	zero,0(a0)
    size_t i = 0;
    5a4a:	863e                	mv	a2,a5
    5a4c:	8532                	mv	a0,a2
    5a4e:	8082                	ret
    5a50:	4781                	li	a5,0
    5a52:	b7ed                	j	5a3c <mbstowcs+0x22>
    5a54:	4501                	li	a0,0
    return i;
}
    5a56:	8082                	ret

0000000000005a58 <wcstombs>:
size_t wcstombs(char *dest, const wchar_t *src, size_t n)
{
    size_t i = 0;
    while (src[i] && i < n)
    5a58:	4198                	lw	a4,0(a1)
    5a5a:	c71d                	beqz	a4,5a88 <wcstombs+0x30>
    5a5c:	ca05                	beqz	a2,5a8c <wcstombs+0x34>
    5a5e:	0591                	addi	a1,a1,4
    size_t i = 0;
    5a60:	4781                	li	a5,0
    5a62:	a019                	j	5a68 <wcstombs+0x10>
    while (src[i] && i < n)
    5a64:	02f60063          	beq	a2,a5,5a84 <wcstombs+0x2c>
    {
        dest[i] = (char)src[i];
    5a68:	00f506b3          	add	a3,a0,a5
    5a6c:	00e68023          	sb	a4,0(a3)
    while (src[i] && i < n)
    5a70:	4198                	lw	a4,0(a1)
        i++;
    5a72:	0785                	addi	a5,a5,1
    while (src[i] && i < n)
    5a74:	0591                	addi	a1,a1,4
    5a76:	f77d                	bnez	a4,5a64 <wcstombs+0xc>
    }
    if (i < n)
    5a78:	00c7f563          	bgeu	a5,a2,5a82 <wcstombs+0x2a>
        dest[i] = 0;
    5a7c:	953e                	add	a0,a0,a5
    5a7e:	00050023          	sb	zero,0(a0)
    size_t i = 0;
    5a82:	863e                	mv	a2,a5
    5a84:	8532                	mv	a0,a2
    5a86:	8082                	ret
    5a88:	4781                	li	a5,0
    5a8a:	b7fd                	j	5a78 <wcstombs+0x20>
    5a8c:	4501                	li	a0,0
    return i;
    5a8e:	8082                	ret

0000000000005a90 <memset>:

void *memset(void *dst, int c, size_t n)
{
    char *cdst = (char *)dst;
    for (size_t i = 0; i < n; i++)
        cdst[i] = (char)c;
    5a90:	0ff5f593          	zext.b	a1,a1
    5a94:	87aa                	mv	a5,a0
    5a96:	00a60733          	add	a4,a2,a0
    for (size_t i = 0; i < n; i++)
    5a9a:	c611                	beqz	a2,5aa6 <memset+0x16>
        cdst[i] = (char)c;
    5a9c:	00b78023          	sb	a1,0(a5)
    for (size_t i = 0; i < n; i++)
    5aa0:	0785                	addi	a5,a5,1
    5aa2:	fee79de3          	bne	a5,a4,5a9c <memset+0xc>
    return dst;
}
    5aa6:	8082                	ret

0000000000005aa8 <memmove>:

void *memmove(void *vdst, const void *vsrc, size_t n)
{
    char *dst = (char *)vdst;
    const char *src = (const char *)vsrc;
    if (dst == src)
    5aa8:	02b50d63          	beq	a0,a1,5ae2 <memmove+0x3a>
        return vdst;

    if (src > dst)
    5aac:	00b57e63          	bgeu	a0,a1,5ac8 <memmove+0x20>
    {
        while (n--)
    5ab0:	ca0d                	beqz	a2,5ae2 <memmove+0x3a>
    5ab2:	962a                	add	a2,a2,a0
    char *dst = (char *)vdst;
    5ab4:	87aa                	mv	a5,a0
            *dst++ = *src++;
    5ab6:	0005c703          	lbu	a4,0(a1)
    5aba:	0785                	addi	a5,a5,1
    5abc:	0585                	addi	a1,a1,1
    5abe:	fee78fa3          	sb	a4,-1(a5)
        while (n--)
    5ac2:	fec79ae3          	bne	a5,a2,5ab6 <memmove+0xe>
    5ac6:	8082                	ret
    }
    else
    {
        dst += n;
    5ac8:	00c50733          	add	a4,a0,a2
        src += n;
    5acc:	00c587b3          	add	a5,a1,a2
        while (n-- > 0)
    5ad0:	ca09                	beqz	a2,5ae2 <memmove+0x3a>
            *--dst = *--src;
    5ad2:	fff7c683          	lbu	a3,-1(a5)
    5ad6:	17fd                	addi	a5,a5,-1
    5ad8:	177d                	addi	a4,a4,-1
    5ada:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
    5ade:	fef59ae3          	bne	a1,a5,5ad2 <memmove+0x2a>
    }
    return vdst;
}
    5ae2:	8082                	ret

0000000000005ae4 <memcpy>:

void *memcpy(void *vdst, const void *vsrc, size_t n)
{
    return memmove(vdst, vsrc, n);
    5ae4:	b7d1                	j	5aa8 <memmove>

0000000000005ae6 <memcmp>:

int memcmp(const void *s1, const void *s2, size_t n)
{
    const unsigned char *p1 = (const unsigned char *)s1;
    const unsigned char *p2 = (const unsigned char *)s2;
    while (n--)
    5ae6:	c205                	beqz	a2,5b06 <memcmp+0x20>
    5ae8:	962a                	add	a2,a2,a0
    5aea:	a019                	j	5af0 <memcmp+0xa>
    5aec:	00c50d63          	beq	a0,a2,5b06 <memcmp+0x20>
    {
        if (*p1 != *p2)
    5af0:	00054783          	lbu	a5,0(a0)
    5af4:	0005c703          	lbu	a4,0(a1)
            return *p1 - *p2;
        p1++;
    5af8:	0505                	addi	a0,a0,1
        p2++;
    5afa:	0585                	addi	a1,a1,1
        if (*p1 != *p2)
    5afc:	fee788e3          	beq	a5,a4,5aec <memcmp+0x6>
            return *p1 - *p2;
    5b00:	40e7853b          	subw	a0,a5,a4
    5b04:	8082                	ret
    }
    return 0;
    5b06:	4501                	li	a0,0
}
    5b08:	8082                	ret

0000000000005b0a <memchr>:

void *memchr(const void *s, int c, size_t n)
{
    const unsigned char *p = (const unsigned char *)s;
    while (n--)
    5b0a:	ce09                	beqz	a2,5b24 <memchr+0x1a>
    {
        if (*p == (unsigned char)c)
    5b0c:	0ff5f593          	zext.b	a1,a1
    5b10:	962a                	add	a2,a2,a0
    5b12:	a021                	j	5b1a <memchr+0x10>
            return (void *)p;
        p++;
    5b14:	0505                	addi	a0,a0,1
    while (n--)
    5b16:	00a60763          	beq	a2,a0,5b24 <memchr+0x1a>
        if (*p == (unsigned char)c)
    5b1a:	00054783          	lbu	a5,0(a0)
    5b1e:	feb79be3          	bne	a5,a1,5b14 <memchr+0xa>
    }
    return NULL;
}
    5b22:	8082                	ret
    return NULL;
    5b24:	4501                	li	a0,0
}
    5b26:	8082                	ret

0000000000005b28 <strlen>:
/* String Manipulation Functions  */

size_t strlen(const char *s)
{
    const char *p = s;
    while (*p)
    5b28:	00054783          	lbu	a5,0(a0)
    5b2c:	cb89                	beqz	a5,5b3e <strlen+0x16>
    const char *p = s;
    5b2e:	87aa                	mv	a5,a0
    while (*p)
    5b30:	0017c703          	lbu	a4,1(a5)
        p++;
    5b34:	0785                	addi	a5,a5,1
    while (*p)
    5b36:	ff6d                	bnez	a4,5b30 <strlen+0x8>
    return (size_t)(p - s);
    5b38:	40a78533          	sub	a0,a5,a0
    5b3c:	8082                	ret
    while (*p)
    5b3e:	4501                	li	a0,0
}
    5b40:	8082                	ret

0000000000005b42 <strcpy>:

char *strcpy(char *dst, const char *src)
{
    char *os = dst;
    while ((*dst++ = *src++) != 0)
    5b42:	87aa                	mv	a5,a0
    5b44:	0005c703          	lbu	a4,0(a1)
    5b48:	0785                	addi	a5,a5,1
    5b4a:	0585                	addi	a1,a1,1
    5b4c:	fee78fa3          	sb	a4,-1(a5)
    5b50:	fb75                	bnez	a4,5b44 <strcpy+0x2>
        ;
    return os;
}
    5b52:	8082                	ret

0000000000005b54 <strncpy>:
char *strncpy(char *dst, const char *src, size_t n)
{
    char *os = dst;
    size_t i;

    for (i = 0; i < n && src[i] != '\0'; i++)
    5b54:	4781                	li	a5,0
    5b56:	e619                	bnez	a2,5b64 <strncpy+0x10>
    5b58:	8082                	ret
        dst[i] = src[i];
    5b5a:	00e68023          	sb	a4,0(a3)
    for (i = 0; i < n && src[i] != '\0'; i++)
    5b5e:	0785                	addi	a5,a5,1
    5b60:	02f60263          	beq	a2,a5,5b84 <strncpy+0x30>
    5b64:	00f58733          	add	a4,a1,a5
    5b68:	00074703          	lbu	a4,0(a4)
        dst[i] = src[i];
    5b6c:	00f506b3          	add	a3,a0,a5
    for (i = 0; i < n && src[i] != '\0'; i++)
    5b70:	f76d                	bnez	a4,5b5a <strncpy+0x6>

    for (; i < n; i++)
    5b72:	00c7f963          	bgeu	a5,a2,5b84 <strncpy+0x30>
    5b76:	87b6                	mv	a5,a3
    5b78:	962a                	add	a2,a2,a0
        dst[i] = '\0';
    5b7a:	00078023          	sb	zero,0(a5)
    for (; i < n; i++)
    5b7e:	0785                	addi	a5,a5,1
    5b80:	fec79de3          	bne	a5,a2,5b7a <strncpy+0x26>

    return os;
}
    5b84:	8082                	ret

0000000000005b86 <strcat>:

char *strcat(char *dst, const char *src)
{
    char *os = dst;
    while (*dst)
    5b86:	00054783          	lbu	a5,0(a0)
    5b8a:	cf91                	beqz	a5,5ba6 <strcat+0x20>
    5b8c:	87aa                	mv	a5,a0
    5b8e:	0017c703          	lbu	a4,1(a5)
        dst++;
    5b92:	0785                	addi	a5,a5,1
    while (*dst)
    5b94:	ff6d                	bnez	a4,5b8e <strcat+0x8>
    while ((*dst++ = *src++) != 0)
    5b96:	0005c703          	lbu	a4,0(a1)
    5b9a:	0785                	addi	a5,a5,1
    5b9c:	0585                	addi	a1,a1,1
    5b9e:	fee78fa3          	sb	a4,-1(a5)
    5ba2:	fb75                	bnez	a4,5b96 <strcat+0x10>
        ;
    return os;
}
    5ba4:	8082                	ret
    while ((*dst++ = *src++) != 0)
    5ba6:	0005c703          	lbu	a4,0(a1)
    while (*dst)
    5baa:	87aa                	mv	a5,a0
    while ((*dst++ = *src++) != 0)
    5bac:	0785                	addi	a5,a5,1
    5bae:	fee78fa3          	sb	a4,-1(a5)
    5bb2:	0585                	addi	a1,a1,1
    5bb4:	f36d                	bnez	a4,5b96 <strcat+0x10>
    5bb6:	8082                	ret

0000000000005bb8 <strncat>:
    while (*p)
    5bb8:	00054783          	lbu	a5,0(a0)
    const char *p = s;
    5bbc:	872a                	mv	a4,a0
    while (*p)
    5bbe:	c789                	beqz	a5,5bc8 <strncat+0x10>
    5bc0:	00174783          	lbu	a5,1(a4)
        p++;
    5bc4:	0705                	addi	a4,a4,1
    while (*p)
    5bc6:	ffed                	bnez	a5,5bc0 <strncat+0x8>
    size_t dest_len = strlen(dst);
    size_t i;

    dst += dest_len;

    for (i = 0; i < n && src[i] != '\0'; i++)
    5bc8:	86ba                	mv	a3,a4
    5bca:	4781                	li	a5,0
    5bcc:	88ba                	mv	a7,a4
    5bce:	ea01                	bnez	a2,5bde <strncat+0x26>
    5bd0:	a839                	j	5bee <strncat+0x36>
        dst[i] = src[i];
    5bd2:	01068023          	sb	a6,0(a3)
    for (i = 0; i < n && src[i] != '\0'; i++)
    5bd6:	00188693          	addi	a3,a7,1
    5bda:	00f60d63          	beq	a2,a5,5bf4 <strncat+0x3c>
    5bde:	00f58833          	add	a6,a1,a5
    5be2:	00084803          	lbu	a6,0(a6)
    5be6:	0785                	addi	a5,a5,1
        dst[i] = src[i];
    5be8:	88b6                	mv	a7,a3
    for (i = 0; i < n && src[i] != '\0'; i++)
    5bea:	fe0814e3          	bnez	a6,5bd2 <strncat+0x1a>

    dst[i] = '\0';
    5bee:	00088023          	sb	zero,0(a7)

    return os;
}
    5bf2:	8082                	ret
    dst[i] = '\0';
    5bf4:	00c708b3          	add	a7,a4,a2
    5bf8:	00088023          	sb	zero,0(a7)
}
    5bfc:	8082                	ret

0000000000005bfe <strcmp>:

int strcmp(const char *p, const char *q)
{
    while (*p && *p == *q)
    5bfe:	00054783          	lbu	a5,0(a0)
    5c02:	e791                	bnez	a5,5c0e <strcmp+0x10>
    5c04:	a02d                	j	5c2e <strcmp+0x30>
    5c06:	00054783          	lbu	a5,0(a0)
    5c0a:	cf89                	beqz	a5,5c24 <strcmp+0x26>
    5c0c:	85b6                	mv	a1,a3
    5c0e:	0005c703          	lbu	a4,0(a1)
    {
        p++;
    5c12:	0505                	addi	a0,a0,1
        q++;
    5c14:	00158693          	addi	a3,a1,1
    while (*p && *p == *q)
    5c18:	fef707e3          	beq	a4,a5,5c06 <strcmp+0x8>
    }
    return (int)((unsigned char)*p - (unsigned char)*q);
    5c1c:	0007851b          	sext.w	a0,a5
}
    5c20:	9d19                	subw	a0,a0,a4
    5c22:	8082                	ret
    return (int)((unsigned char)*p - (unsigned char)*q);
    5c24:	0015c703          	lbu	a4,1(a1)
    5c28:	4501                	li	a0,0
}
    5c2a:	9d19                	subw	a0,a0,a4
    5c2c:	8082                	ret
    return (int)((unsigned char)*p - (unsigned char)*q);
    5c2e:	0005c703          	lbu	a4,0(a1)
    5c32:	4501                	li	a0,0
    5c34:	b7f5                	j	5c20 <strcmp+0x22>

0000000000005c36 <strncmp>:

int strncmp(const char *s1, const char *s2, size_t n)
{
    if (n == 0)
    5c36:	ca0d                	beqz	a2,5c68 <strncmp+0x32>
        return 0;

    while (n-- > 0 && *s1 && *s1 == *s2)
    5c38:	00054783          	lbu	a5,0(a0)
    5c3c:	167d                	addi	a2,a2,-1
    5c3e:	00c506b3          	add	a3,a0,a2
    5c42:	eb89                	bnez	a5,5c54 <strncmp+0x1e>
    5c44:	a80d                	j	5c76 <strncmp+0x40>
    {
        if (n == 0 || *s1 == '\0')
    5c46:	00d50d63          	beq	a0,a3,5c60 <strncmp+0x2a>
    while (n-- > 0 && *s1 && *s1 == *s2)
    5c4a:	00154783          	lbu	a5,1(a0)
            break;
        s1++;
    5c4e:	0505                	addi	a0,a0,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    5c50:	cf91                	beqz	a5,5c6c <strncmp+0x36>
    5c52:	85b2                	mv	a1,a2
    5c54:	0005c703          	lbu	a4,0(a1)
        s2++;
    5c58:	00158613          	addi	a2,a1,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    5c5c:	fef705e3          	beq	a4,a5,5c46 <strncmp+0x10>
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    5c60:	0007851b          	sext.w	a0,a5
    5c64:	9d19                	subw	a0,a0,a4
    5c66:	8082                	ret
        return 0;
    5c68:	4501                	li	a0,0
}
    5c6a:	8082                	ret
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    5c6c:	0015c703          	lbu	a4,1(a1)
    5c70:	4501                	li	a0,0
    5c72:	9d19                	subw	a0,a0,a4
    5c74:	8082                	ret
    5c76:	0005c703          	lbu	a4,0(a1)
    5c7a:	4501                	li	a0,0
    5c7c:	b7e5                	j	5c64 <strncmp+0x2e>

0000000000005c7e <strchr>:

char *strchr(const char *s, int c)
{
    while (*s != (char)c)
    5c7e:	0ff5f593          	zext.b	a1,a1
    5c82:	a019                	j	5c88 <strchr+0xa>
    {
        if (!*s++)
    5c84:	0505                	addi	a0,a0,1
    5c86:	c791                	beqz	a5,5c92 <strchr+0x14>
    while (*s != (char)c)
    5c88:	00054783          	lbu	a5,0(a0)
    5c8c:	feb79ce3          	bne	a5,a1,5c84 <strchr+0x6>
    5c90:	8082                	ret
            return NULL;
    5c92:	4501                	li	a0,0
    }
    return (char *)s;
}
    5c94:	8082                	ret

0000000000005c96 <strrchr>:

char *strrchr(const char *s, int c)
{
    5c96:	87aa                	mv	a5,a0
    const char *last = NULL;
    do
    {
        if (*s == (char)c)
    5c98:	0ff5f593          	zext.b	a1,a1
    const char *last = NULL;
    5c9c:	4501                	li	a0,0
        if (*s == (char)c)
    5c9e:	0007c703          	lbu	a4,0(a5)
    5ca2:	00e59363          	bne	a1,a4,5ca8 <strrchr+0x12>
            last = s;
    5ca6:	853e                	mv	a0,a5
    } while (*s++);
    5ca8:	0785                	addi	a5,a5,1
    5caa:	fb75                	bnez	a4,5c9e <strrchr+0x8>

    return (char *)last;
}
    5cac:	8082                	ret

0000000000005cae <strstr>:
    while (*p)
    5cae:	0005c883          	lbu	a7,0(a1)
    5cb2:	04088a63          	beqz	a7,5d06 <strstr+0x58>
    const char *p = s;
    5cb6:	87ae                	mv	a5,a1
    while (*p)
    5cb8:	0017c703          	lbu	a4,1(a5)
        p++;
    5cbc:	0785                	addi	a5,a5,1
    while (*p)
    5cbe:	ff6d                	bnez	a4,5cb8 <strstr+0xa>
    return (size_t)(p - s);
    5cc0:	40b78833          	sub	a6,a5,a1


char *strstr(const char *haystack, const char *needle)
{
    size_t n_len = strlen(needle);
    if (n_len == 0)
    5cc4:	04b78163          	beq	a5,a1,5d06 <strstr+0x58>
        return (char *)haystack;

    for (; *haystack; haystack++)
    5cc8:	00054783          	lbu	a5,0(a0)
    5ccc:	cf85                	beqz	a5,5d04 <strstr+0x56>
    5cce:	187d                	addi	a6,a6,-1
    5cd0:	982a                	add	a6,a6,a0
    {
        if (*haystack != *needle)
    5cd2:	02f89463          	bne	a7,a5,5cfa <strstr+0x4c>
    while (n-- > 0 && *s1 && *s1 == *s2)
    5cd6:	00054703          	lbu	a4,0(a0)
    5cda:	8646                	mv	a2,a7
    5cdc:	86ae                	mv	a3,a1
    5cde:	87aa                	mv	a5,a0
    5ce0:	eb11                	bnez	a4,5cf4 <strstr+0x46>
    5ce2:	a821                	j	5cfa <strstr+0x4c>
        if (n == 0 || *s1 == '\0')
    5ce4:	03078163          	beq	a5,a6,5d06 <strstr+0x58>
    while (n-- > 0 && *s1 && *s1 == *s2)
    5ce8:	0017c703          	lbu	a4,1(a5)
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    5cec:	0006c603          	lbu	a2,0(a3)
        s1++;
    5cf0:	0785                	addi	a5,a5,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    5cf2:	cb19                	beqz	a4,5d08 <strstr+0x5a>
        s2++;
    5cf4:	0685                	addi	a3,a3,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    5cf6:	fee607e3          	beq	a2,a4,5ce4 <strstr+0x36>
    for (; *haystack; haystack++)
    5cfa:	00154783          	lbu	a5,1(a0)
    5cfe:	0805                	addi	a6,a6,1
    5d00:	0505                	addi	a0,a0,1
    5d02:	fbe1                	bnez	a5,5cd2 <strstr+0x24>
            continue;

        if (strncmp(haystack, needle, n_len) == 0)
            return (char *)haystack;
    }
    return NULL;
    5d04:	4501                	li	a0,0
}
    5d06:	8082                	ret
        if (strncmp(haystack, needle, n_len) == 0)
    5d08:	de7d                	beqz	a2,5d06 <strstr+0x58>
    for (; *haystack; haystack++)
    5d0a:	00154783          	lbu	a5,1(a0)
    5d0e:	0805                	addi	a6,a6,1
    5d10:	0505                	addi	a0,a0,1
    5d12:	f3e1                	bnez	a5,5cd2 <strstr+0x24>
    5d14:	bfc5                	j	5d04 <strstr+0x56>

0000000000005d16 <strdup>:

char *strdup(const char *s)
{
    5d16:	1101                	addi	sp,sp,-32
    5d18:	e426                	sd	s1,8(sp)
    5d1a:	ec06                	sd	ra,24(sp)
    5d1c:	e822                	sd	s0,16(sp)
    while (*p)
    5d1e:	00054783          	lbu	a5,0(a0)
{
    5d22:	84aa                	mv	s1,a0
    while (*p)
    5d24:	cb8d                	beqz	a5,5d56 <strdup+0x40>
    const char *p = s;
    5d26:	862a                	mv	a2,a0
    while (*p)
    5d28:	00164783          	lbu	a5,1(a2)
        p++;
    5d2c:	0605                	addi	a2,a2,1
    while (*p)
    5d2e:	ffed                	bnez	a5,5d28 <strdup+0x12>
    return (size_t)(p - s);
    5d30:	8e05                	sub	a2,a2,s1
    size_t len = strlen(s) + 1;
    5d32:	00160413          	addi	s0,a2,1
    char *new_str = (char *)malloc(len);
    5d36:	8522                	mv	a0,s0
    5d38:	f66ff0ef          	jal	549e <malloc>
    if (new_str == NULL)
    5d3c:	c901                	beqz	a0,5d4c <strdup+0x36>
    return memmove(vdst, vsrc, n);
    5d3e:	8622                	mv	a2,s0
        return NULL;

    return (char *)memcpy(new_str, s, len);
}
    5d40:	6442                	ld	s0,16(sp)
    5d42:	60e2                	ld	ra,24(sp)
    return memmove(vdst, vsrc, n);
    5d44:	85a6                	mv	a1,s1
}
    5d46:	64a2                	ld	s1,8(sp)
    5d48:	6105                	addi	sp,sp,32
    return memmove(vdst, vsrc, n);
    5d4a:	bbb9                	j	5aa8 <memmove>
}
    5d4c:	60e2                	ld	ra,24(sp)
    5d4e:	6442                	ld	s0,16(sp)
    5d50:	64a2                	ld	s1,8(sp)
    5d52:	6105                	addi	sp,sp,32
    5d54:	8082                	ret
    while (*p)
    5d56:	4405                	li	s0,1
    5d58:	bff9                	j	5d36 <strdup+0x20>

0000000000005d5a <strlcpy>:
    5d5a:	0005c783          	lbu	a5,0(a1)

size_t strlcpy(char *dst, const char *src, size_t size)
{
    5d5e:	1101                	addi	sp,sp,-32
    5d60:	ec06                	sd	ra,24(sp)
    5d62:	e822                	sd	s0,16(sp)
    5d64:	86b2                	mv	a3,a2
    while (*p)
    5d66:	cf8d                	beqz	a5,5da0 <strlcpy+0x46>
    const char *p = s;
    5d68:	87ae                	mv	a5,a1
    while (*p)
    5d6a:	0017c703          	lbu	a4,1(a5)
        p++;
    5d6e:	0785                	addi	a5,a5,1
    while (*p)
    5d70:	ff6d                	bnez	a4,5d6a <strlcpy+0x10>
    return (size_t)(p - s);
    5d72:	40b78433          	sub	s0,a5,a1
    size_t src_len = strlen(src);

    if (size > 0)
    5d76:	c285                	beqz	a3,5d96 <strlcpy+0x3c>
    5d78:	e426                	sd	s1,8(sp)
    {
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    5d7a:	fff68613          	addi	a2,a3,-1
        memcpy(dst, src, copy_len);
        dst[copy_len] = '\0';
    5d7e:	00c504b3          	add	s1,a0,a2
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    5d82:	00d47563          	bgeu	s0,a3,5d8c <strlcpy+0x32>
        dst[copy_len] = '\0';
    5d86:	008504b3          	add	s1,a0,s0
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    5d8a:	8622                	mv	a2,s0
    return memmove(vdst, vsrc, n);
    5d8c:	d1dff0ef          	jal	5aa8 <memmove>
        dst[copy_len] = '\0';
    5d90:	00048023          	sb	zero,0(s1)
    }

    return src_len;
    5d94:	64a2                	ld	s1,8(sp)
}
    5d96:	60e2                	ld	ra,24(sp)
    5d98:	8522                	mv	a0,s0
    5d9a:	6442                	ld	s0,16(sp)
    5d9c:	6105                	addi	sp,sp,32
    5d9e:	8082                	ret
    if (size > 0)
    5da0:	e219                	bnez	a2,5da6 <strlcpy+0x4c>
    return (size_t)(p - s);
    5da2:	4401                	li	s0,0
    5da4:	bfcd                	j	5d96 <strlcpy+0x3c>
    5da6:	e426                	sd	s1,8(sp)
    5da8:	4401                	li	s0,0
    if (size > 0)
    5daa:	84aa                	mv	s1,a0
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    5dac:	4601                	li	a2,0
    5dae:	bff9                	j	5d8c <strlcpy+0x32>

0000000000005db0 <strlcat>:
    while (*p)
    5db0:	0005c783          	lbu	a5,0(a1)

size_t strlcat(char *dst, const char *src, size_t size)
{
    5db4:	7179                	addi	sp,sp,-48
    5db6:	e84a                	sd	s2,16(sp)
    5db8:	f406                	sd	ra,40(sp)
    5dba:	f022                	sd	s0,32(sp)
    5dbc:	ec26                	sd	s1,24(sp)
    5dbe:	892a                	mv	s2,a0
    while (*p)
    5dc0:	c7b5                	beqz	a5,5e2c <strlcat+0x7c>
    const char *p = s;
    5dc2:	87ae                	mv	a5,a1
    while (*p)
    5dc4:	0017c703          	lbu	a4,1(a5)
        p++;
    5dc8:	0785                	addi	a5,a5,1
    while (*p)
    5dca:	ff6d                	bnez	a4,5dc4 <strlcat+0x14>
    return (size_t)(p - s);
    5dcc:	40b784b3          	sub	s1,a5,a1
    size_t dst_len = 0;
    5dd0:	4401                	li	s0,0
    size_t src_len = strlen(src);

    while (dst_len < size && dst[dst_len] != '\0')
    5dd2:	e609                	bnez	a2,5ddc <strlcat+0x2c>
    5dd4:	a0a1                	j	5e1c <strlcat+0x6c>
        dst_len++;
    5dd6:	0405                	addi	s0,s0,1
    while (dst_len < size && dst[dst_len] != '\0')
    5dd8:	04860263          	beq	a2,s0,5e1c <strlcat+0x6c>
    5ddc:	00890533          	add	a0,s2,s0
    5de0:	00054783          	lbu	a5,0(a0)
    5de4:	fbed                	bnez	a5,5dd6 <strlcat+0x26>

    if (dst_len == size)
    5de6:	02860b63          	beq	a2,s0,5e1c <strlcat+0x6c>
    5dea:	e44e                	sd	s3,8(sp)
        return size + src_len;

    size_t space_left = size - dst_len;
    5dec:	408607b3          	sub	a5,a2,s0
    size_t copy_len = (src_len >= space_left) ? space_left - 1 : src_len;
    5df0:	89a6                	mv	s3,s1
    5df2:	02f4f263          	bgeu	s1,a5,5e16 <strlcat+0x66>

    memcpy(dst + dst_len, src, copy_len);
    dst[dst_len + copy_len] = '\0';
    5df6:	994e                	add	s2,s2,s3
    5df8:	9922                	add	s2,s2,s0
    return memmove(vdst, vsrc, n);
    5dfa:	864e                	mv	a2,s3
    5dfc:	cadff0ef          	jal	5aa8 <memmove>
    dst[dst_len + copy_len] = '\0';
    5e00:	00090023          	sb	zero,0(s2)

    return dst_len + src_len;
    5e04:	00940533          	add	a0,s0,s1
}
    5e08:	70a2                	ld	ra,40(sp)
    5e0a:	7402                	ld	s0,32(sp)
    return dst_len + src_len;
    5e0c:	69a2                	ld	s3,8(sp)
}
    5e0e:	64e2                	ld	s1,24(sp)
    5e10:	6942                	ld	s2,16(sp)
    5e12:	6145                	addi	sp,sp,48
    5e14:	8082                	ret
    size_t copy_len = (src_len >= space_left) ? space_left - 1 : src_len;
    5e16:	fff78993          	addi	s3,a5,-1
    5e1a:	bff1                	j	5df6 <strlcat+0x46>
}
    5e1c:	70a2                	ld	ra,40(sp)
    5e1e:	7402                	ld	s0,32(sp)
    5e20:	6942                	ld	s2,16(sp)
        return size + src_len;
    5e22:	00960533          	add	a0,a2,s1
}
    5e26:	64e2                	ld	s1,24(sp)
    5e28:	6145                	addi	sp,sp,48
    5e2a:	8082                	ret
    while (*p)
    5e2c:	4481                	li	s1,0
    5e2e:	b74d                	j	5dd0 <strlcat+0x20>

0000000000005e30 <strspn>:
size_t strspn(const char *s, const char *accept)
{
    const char *p = s;
    const char *a;

    while (*p)
    5e30:	00054683          	lbu	a3,0(a0)
    5e34:	c695                	beqz	a3,5e60 <strspn+0x30>
    {
        for (a = accept; *a; a++)
    5e36:	0005c803          	lbu	a6,0(a1)
    5e3a:	862a                	mv	a2,a0
    5e3c:	00080f63          	beqz	a6,5e5a <strspn+0x2a>
    5e40:	87ae                	mv	a5,a1
    5e42:	8742                	mv	a4,a6
    5e44:	a021                	j	5e4c <strspn+0x1c>
    5e46:	0007c703          	lbu	a4,0(a5)
    5e4a:	cb01                	beqz	a4,5e5a <strspn+0x2a>
    5e4c:	0785                	addi	a5,a5,1
        {
            if (*p == *a)
    5e4e:	fee69ce3          	bne	a3,a4,5e46 <strspn+0x16>
    while (*p)
    5e52:	00164683          	lbu	a3,1(a2)
                break;
        }
        if (*a == '\0')
            return (size_t)(p - s);
        p++;
    5e56:	0605                	addi	a2,a2,1
    while (*p)
    5e58:	f6e5                	bnez	a3,5e40 <strspn+0x10>
    }
    return (size_t)(p - s);
    5e5a:	40a60533          	sub	a0,a2,a0
    5e5e:	8082                	ret
    while (*p)
    5e60:	4501                	li	a0,0
}
    5e62:	8082                	ret

0000000000005e64 <strcspn>:
size_t strcspn(const char *s, const char *reject)
{
    const char *p = s;
    const char *r;

    while (*p)
    5e64:	00054683          	lbu	a3,0(a0)
    5e68:	ce85                	beqz	a3,5ea0 <strcspn+0x3c>
    {
        for (r = reject; *r; r++)
    5e6a:	0005c803          	lbu	a6,0(a1)
    const char *p = s;
    5e6e:	862a                	mv	a2,a0
        for (r = reject; *r; r++)
    5e70:	02080363          	beqz	a6,5e96 <strcspn+0x32>
    5e74:	87ae                	mv	a5,a1
    5e76:	8742                	mv	a4,a6
    5e78:	a021                	j	5e80 <strcspn+0x1c>
    5e7a:	0007c703          	lbu	a4,0(a5)
    5e7e:	c719                	beqz	a4,5e8c <strcspn+0x28>
    5e80:	0785                	addi	a5,a5,1
        {
            if (*p == *r)
    5e82:	fed71ce3          	bne	a4,a3,5e7a <strcspn+0x16>
                return (size_t)(p - s);
        }
        p++;
    }
    return (size_t)(p - s);
    5e86:	40a60533          	sub	a0,a2,a0
    5e8a:	8082                	ret
    while (*p)
    5e8c:	00164683          	lbu	a3,1(a2)
        p++;
    5e90:	0605                	addi	a2,a2,1
    while (*p)
    5e92:	f2ed                	bnez	a3,5e74 <strcspn+0x10>
    5e94:	bfcd                	j	5e86 <strcspn+0x22>
    5e96:	00164683          	lbu	a3,1(a2)
        p++;
    5e9a:	0605                	addi	a2,a2,1
    while (*p)
    5e9c:	feed                	bnez	a3,5e96 <strcspn+0x32>
    5e9e:	b7e5                	j	5e86 <strcspn+0x22>
    5ea0:	4501                	li	a0,0
}
    5ea2:	8082                	ret

0000000000005ea4 <strpbrk>:

char *strpbrk(const char *s, const char *accept)
{
    const char *a;
    while (*s)
    5ea4:	00054683          	lbu	a3,0(a0)
    5ea8:	c295                	beqz	a3,5ecc <strpbrk+0x28>
    {
        for (a = accept; *a; a++)
    5eaa:	0005c603          	lbu	a2,0(a1)
    5eae:	c20d                	beqz	a2,5ed0 <strpbrk+0x2c>
    5eb0:	87ae                	mv	a5,a1
    5eb2:	8732                	mv	a4,a2
    5eb4:	a021                	j	5ebc <strpbrk+0x18>
    5eb6:	0007c703          	lbu	a4,0(a5)
    5eba:	c709                	beqz	a4,5ec4 <strpbrk+0x20>
    5ebc:	0785                	addi	a5,a5,1
        {
            if (*s == *a)
    5ebe:	fed71ce3          	bne	a4,a3,5eb6 <strpbrk+0x12>
                return (char *)s;
        }
        s++;
    }
    return NULL;
}
    5ec2:	8082                	ret
    while (*s)
    5ec4:	00154683          	lbu	a3,1(a0)
        s++;
    5ec8:	0505                	addi	a0,a0,1
    while (*s)
    5eca:	f2fd                	bnez	a3,5eb0 <strpbrk+0xc>
    return NULL;
    5ecc:	4501                	li	a0,0
}
    5ece:	8082                	ret
    while (*s)
    5ed0:	00154683          	lbu	a3,1(a0)
        s++;
    5ed4:	0505                	addi	a0,a0,1
    while (*s)
    5ed6:	feed                	bnez	a3,5ed0 <strpbrk+0x2c>
    5ed8:	bfd5                	j	5ecc <strpbrk+0x28>

0000000000005eda <strtok>:
char *strtok(char *str, const char *delim)
{
    static char *olds;
    char *token;

    if (str == NULL)
    5eda:	00003897          	auipc	a7,0x3
    5ede:	ece88893          	addi	a7,a7,-306 # 8da8 <olds.0>
    5ee2:	cd25                	beqz	a0,5f5a <strtok+0x80>
    while (*p)
    5ee4:	00054683          	lbu	a3,0(a0)
    5ee8:	c295                	beqz	a3,5f0c <strtok+0x32>
        for (a = accept; *a; a++)
    5eea:	0005c803          	lbu	a6,0(a1)
    5eee:	02080463          	beqz	a6,5f16 <strtok+0x3c>
    5ef2:	87ae                	mv	a5,a1
    5ef4:	8742                	mv	a4,a6
    5ef6:	a021                	j	5efe <strtok+0x24>
    5ef8:	0007c703          	lbu	a4,0(a5)
    5efc:	cf09                	beqz	a4,5f16 <strtok+0x3c>
    5efe:	0785                	addi	a5,a5,1
            if (*p == *a)
    5f00:	fee69ce3          	bne	a3,a4,5ef8 <strtok+0x1e>
    while (*p)
    5f04:	00154683          	lbu	a3,1(a0)
        p++;
    5f08:	0505                	addi	a0,a0,1
    while (*p)
    5f0a:	f6e5                	bnez	a3,5ef2 <strtok+0x18>
    5f0c:	87aa                	mv	a5,a0
        str = olds;

    str += strspn(str, delim);
    if (*str == '\0')
    {
        olds = str;
    5f0e:	00f8b023          	sd	a5,0(a7)
        return NULL;
    5f12:	4501                	li	a0,0
        *str = '\0';
        olds = str + 1;
    }

    return token;
}
    5f14:	8082                	ret
    if (*str == '\0')
    5f16:	00054603          	lbu	a2,0(a0)
    5f1a:	da6d                	beqz	a2,5f0c <strtok+0x32>
    5f1c:	86aa                	mv	a3,a0
        for (a = accept; *a; a++)
    5f1e:	04080163          	beqz	a6,5f60 <strtok+0x86>
    5f22:	8742                	mv	a4,a6
    5f24:	87ae                	mv	a5,a1
    5f26:	a021                	j	5f2e <strtok+0x54>
    5f28:	0007c703          	lbu	a4,0(a5)
    5f2c:	cb19                	beqz	a4,5f42 <strtok+0x68>
    5f2e:	0785                	addi	a5,a5,1
            if (*s == *a)
    5f30:	fee61ce3          	bne	a2,a4,5f28 <strtok+0x4e>
        olds = str + 1;
    5f34:	00168793          	addi	a5,a3,1
        *str = '\0';
    5f38:	00068023          	sb	zero,0(a3)
        olds = str;
    5f3c:	00f8b023          	sd	a5,0(a7)
}
    5f40:	8082                	ret
    while (*s)
    5f42:	0016c603          	lbu	a2,1(a3)
        s++;
    5f46:	0685                	addi	a3,a3,1
    while (*s)
    5f48:	fe69                	bnez	a2,5f22 <strtok+0x48>
    5f4a:	87aa                	mv	a5,a0
    while (*s != (char)c)
    5f4c:	0017c703          	lbu	a4,1(a5)
        if (!*s++)
    5f50:	0785                	addi	a5,a5,1
    while (*s != (char)c)
    5f52:	ff6d                	bnez	a4,5f4c <strtok+0x72>
        olds = str;
    5f54:	00f8b023          	sd	a5,0(a7)
}
    5f58:	8082                	ret
        str = olds;
    5f5a:	0008b503          	ld	a0,0(a7)
    5f5e:	b759                	j	5ee4 <strtok+0xa>
    while (*s)
    5f60:	0016c603          	lbu	a2,1(a3)
        s++;
    5f64:	0685                	addi	a3,a3,1
    while (*s)
    5f66:	fe6d                	bnez	a2,5f60 <strtok+0x86>
    5f68:	b7cd                	j	5f4a <strtok+0x70>

0000000000005f6a <strerror>:

char *strerror(int errnum)
{
    5f6a:	87aa                	mv	a5,a0
    
    switch (errnum)
    5f6c:	cd09                	beqz	a0,5f86 <strerror+0x1c>
    5f6e:	4731                	li	a4,12
    5f70:	00000517          	auipc	a0,0x0
    5f74:	22850513          	addi	a0,a0,552 # 6198 <_GLOBAL__sub_I__ZSt3cin+0x1f0>
    5f78:	00e78b63          	beq	a5,a4,5f8e <strerror+0x24>
        return "Success";
    // case EINVAL: return "Invalid argument";
    case ENOMEM: return "Out of memory";
    
    default:
        return "Unknown error";
    5f7c:	00000517          	auipc	a0,0x0
    5f80:	22c50513          	addi	a0,a0,556 # 61a8 <_GLOBAL__sub_I__ZSt3cin+0x200>
    5f84:	8082                	ret
        return "Success";
    5f86:	00000517          	auipc	a0,0x0
    5f8a:	20a50513          	addi	a0,a0,522 # 6190 <_GLOBAL__sub_I__ZSt3cin+0x1e8>
    }
    5f8e:	8082                	ret

0000000000005f90 <_Znwm>:
#include "ulib/stdlib.h"

void *operator new(unsigned long n)
{
    return malloc(n);
    5f90:	d0eff06f          	j	549e <malloc>

0000000000005f94 <_Znam>:
}

void *operator new[](unsigned long n)
    5f94:	d0aff06f          	j	549e <malloc>

0000000000005f98 <_ZdlPv>:
    return malloc(n);
}

void operator delete(void *p)
{
    free(p);
    5f98:	c90ff06f          	j	5428 <free>

0000000000005f9c <_ZdaPv>:
}

void operator delete[](void *p)
    5f9c:	c8cff06f          	j	5428 <free>

0000000000005fa0 <_ZdlPvm>:
    free(p);
}

void operator delete(void *p, unsigned long)
{
    free(p);
    5fa0:	c88ff06f          	j	5428 <free>

0000000000005fa4 <_ZdaPvm>:
}

void operator delete[](void *p, unsigned long)
    5fa4:	c84ff06f          	j	5428 <free>

0000000000005fa8 <_GLOBAL__sub_I__ZSt3cin>:
#include "ulib/iostream"

namespace std
{
    istream cin(stdin);
    5fa8:	00003797          	auipc	a5,0x3
    5fac:	c507b783          	ld	a5,-944(a5) # 8bf8 <_GLOBAL_OFFSET_TABLE_+0x10>
    5fb0:	6390                	ld	a2,0(a5)
    ostream cout(stdout);
    5fb2:	00003797          	auipc	a5,0x3
    5fb6:	c3e7b783          	ld	a5,-962(a5) # 8bf0 <_GLOBAL_OFFSET_TABLE_+0x8>
    5fba:	6394                	ld	a3,0(a5)
    ostream cerr(stderr);
    5fbc:	00003797          	auipc	a5,0x3
    5fc0:	c447b783          	ld	a5,-956(a5) # 8c00 <_GLOBAL_OFFSET_TABLE_+0x18>
    5fc4:	6398                	ld	a4,0(a5)

    class istream{
    private:
        FILE* _stream;
    public:
        istream(FILE *f) : _stream(f) {}
    5fc6:	00003797          	auipc	a5,0x3
    5fca:	dea78793          	addi	a5,a5,-534 # 8db0 <_ZSt3cin>
    5fce:	e390                	sd	a2,0(a5)
        ostream(FILE* f) : _stream(f) {}
    5fd0:	e794                	sd	a3,8(a5)
    5fd2:	eb98                	sd	a4,16(a5)
} // namespace std
    5fd4:	8082                	ret
