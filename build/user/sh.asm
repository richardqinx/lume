
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
       8:	06450513          	addi	a0,a0,100 # 6068 <_GLOBAL__sub_I__ZSt3cin+0x64>
{
       c:	e406                	sd	ra,8(sp)
    printf("shell panic: %s\n", s);
       e:	101040ef          	jal	490e <printf>
    exit(1);
}
      12:	60a2                	ld	ra,8(sp)
    exit(1);
      14:	4505                	li	a0,1
}
      16:	0141                	addi	sp,sp,16
    exit(1);
      18:	40a0506f          	j	5422 <exit>

000000000000001c <_Z13fork_or_panicv>:

int fork_or_panic()
{
      1c:	1141                	addi	sp,sp,-16
      1e:	e022                	sd	s0,0(sp)
      20:	e406                	sd	ra,8(sp)
    int pid = fork();
      22:	0ca010ef          	jal	10ec <fork>
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
      3c:	02858593          	addi	a1,a1,40 # 6060 <_GLOBAL__sub_I__ZSt3cin+0x5c>
      40:	00006517          	auipc	a0,0x6
      44:	02850513          	addi	a0,a0,40 # 6068 <_GLOBAL__sub_I__ZSt3cin+0x64>
      48:	0c7040ef          	jal	490e <printf>
    exit(1);
      4c:	4505                	li	a0,1
      4e:	3d4050ef          	jal	5422 <exit>
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
      6c:	08058593          	addi	a1,a1,128 # 60e8 <_GLOBAL__sub_I__ZSt3cin+0xe4>
      70:	4505                	li	a0,1
{
      72:	f486                	sd	ra,104(sp)
    write(1, "$ ", 2);
      74:	098010ef          	jal	110c <write>
    memset(buf, 0, nbuf);
      78:	864a                	mv	a2,s2
      7a:	4581                	li	a1,0
      7c:	854e                	mv	a0,s3
      7e:	26f050ef          	jal	5aec <memset>

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
      a8:	04cb8b93          	addi	s7,s7,76 # 60f0 <_GLOBAL__sub_I__ZSt3cin+0xec>
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
      ba:	04a010ef          	jal	1104 <read>
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
      e2:	02a010ef          	jal	110c <write>
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
     11c:	7f1000ef          	jal	110c <write>
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
     148:	fb458593          	addi	a1,a1,-76 # 60f8 <_GLOBAL__sub_I__ZSt3cin+0xf4>
     14c:	4505                	li	a0,1
     14e:	7bf000ef          	jal	110c <write>
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
     162:	cea70713          	addi	a4,a4,-790 # 7e48 <_ZTV12RedirCommand+0x10>
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
     180:	cf478793          	addi	a5,a5,-780 # 7e70 <_ZTV11PipeCommand+0x10>
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
     1b4:	ce878793          	addi	a5,a5,-792 # 7e98 <_ZTV11ListCommand+0x10>
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
     1e2:	ce270713          	addi	a4,a4,-798 # 7ec0 <_ZTV11BackCommand+0x10>
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
     1fe:	717000ef          	jal	1114 <close>
        if (open(file, mode) < 0)
     202:	500c                	lw	a1,32(s0)
     204:	6808                	ld	a0,16(s0)
     206:	727000ef          	jal	112c <open>
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
     222:	e2250513          	addi	a0,a0,-478 # 6040 <_GLOBAL__sub_I__ZSt3cin+0x3c>
     226:	6e8040ef          	jal	490e <printf>
            exit(1);
     22a:	4505                	li	a0,1
     22c:	1f6050ef          	jal	5422 <exit>
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
     24e:	6d7000ef          	jal	1124 <exec>
        printf("exec %s failed\n", argv[0]);
     252:	640c                	ld	a1,8(s0)
     254:	00006517          	auipc	a0,0x6
     258:	dfc50513          	addi	a0,a0,-516 # 6050 <_GLOBAL__sub_I__ZSt3cin+0x4c>
     25c:	6b2040ef          	jal	490e <printf>
    }
     260:	6402                	ld	s0,0(sp)
     262:	60a2                	ld	ra,8(sp)
        exit(1);
     264:	4505                	li	a0,1
    }
     266:	0141                	addi	sp,sp,16
        exit(1);
     268:	1ba0506f          	j	5422 <exit>
            exit(1);
     26c:	4505                	li	a0,1
     26e:	1b4050ef          	jal	5422 <exit>
        exec(argv[0], argv);
     272:	6408                	ld	a0,8(s0)
     274:	bfd9                	j	24a <_ZN11ExecCommand3runEv+0xc>

0000000000000276 <_ZN11ExecCommandD0Ev>:
struct ExecCommand : public Command
     276:	05800593          	li	a1,88
     27a:	5830506f          	j	5ffc <_ZdlPvm>

000000000000027e <_ZN12RedirCommandD0Ev>:
    ~RedirCommand() { delete sub_cmd; }
     27e:	1141                	addi	sp,sp,-16
     280:	e022                	sd	s0,0(sp)
     282:	842a                	mv	s0,a0
     284:	6508                	ld	a0,8(a0)
     286:	e406                	sd	ra,8(sp)
     288:	00008797          	auipc	a5,0x8
     28c:	bc078793          	addi	a5,a5,-1088 # 7e48 <_ZTV12RedirCommand+0x10>
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
     2a6:	5570506f          	j	5ffc <_ZdlPvm>

00000000000002aa <_ZN11BackCommandD0Ev>:
    ~BackCommand() { delete sub_cmd; }
     2aa:	1141                	addi	sp,sp,-16
     2ac:	e022                	sd	s0,0(sp)
     2ae:	842a                	mv	s0,a0
     2b0:	6508                	ld	a0,8(a0)
     2b2:	e406                	sd	ra,8(sp)
     2b4:	00008797          	auipc	a5,0x8
     2b8:	c0c78793          	addi	a5,a5,-1012 # 7ec0 <_ZTV11BackCommand+0x10>
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
     2d0:	52d0506f          	j	5ffc <_ZdlPvm>

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
     2e2:	b9278793          	addi	a5,a5,-1134 # 7e70 <_ZTV11PipeCommand+0x10>
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
     304:	4f90506f          	j	5ffc <_ZdlPvm>

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
     316:	b8678793          	addi	a5,a5,-1146 # 7e98 <_ZTV11ListCommand+0x10>
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
     338:	4c50506f          	j	5ffc <_ZdlPvm>

000000000000033c <_ZN11BackCommand3runEv>:
    void run() override
     33c:	1141                	addi	sp,sp,-16
     33e:	e022                	sd	s0,0(sp)
     340:	e406                	sd	ra,8(sp)
     342:	842a                	mv	s0,a0
    int pid = fork();
     344:	5a9000ef          	jal	10ec <fork>
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
     360:	0c20506f          	j	5422 <exit>
    printf("shell panic: %s\n", s);
     364:	00006597          	auipc	a1,0x6
     368:	cfc58593          	addi	a1,a1,-772 # 6060 <_GLOBAL__sub_I__ZSt3cin+0x5c>
     36c:	00006517          	auipc	a0,0x6
     370:	cfc50513          	addi	a0,a0,-772 # 6068 <_GLOBAL__sub_I__ZSt3cin+0x64>
     374:	59a040ef          	jal	490e <printf>
    exit(1);
     378:	4505                	li	a0,1
     37a:	0a8050ef          	jal	5422 <exit>
    }
     37e:	6402                	ld	s0,0(sp)
     380:	60a2                	ld	ra,8(sp)
        exit(0);
     382:	4501                	li	a0,0
    }
     384:	0141                	addi	sp,sp,16
        exit(0);
     386:	09c0506f          	j	5422 <exit>

000000000000038a <_ZN11ListCommand3runEv>:
    void run() override
     38a:	1141                	addi	sp,sp,-16
     38c:	e022                	sd	s0,0(sp)
     38e:	e406                	sd	ra,8(sp)
     390:	842a                	mv	s0,a0
    int pid = fork();
     392:	55b000ef          	jal	10ec <fork>
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
     3a8:	54d000ef          	jal	10f4 <wait>
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
     3be:	ca658593          	addi	a1,a1,-858 # 6060 <_GLOBAL__sub_I__ZSt3cin+0x5c>
     3c2:	00006517          	auipc	a0,0x6
     3c6:	ca650513          	addi	a0,a0,-858 # 6068 <_GLOBAL__sub_I__ZSt3cin+0x64>
     3ca:	544040ef          	jal	490e <printf>
    exit(1);
     3ce:	4505                	li	a0,1
     3d0:	052050ef          	jal	5422 <exit>
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
     3e0:	51d000ef          	jal	10fc <pipe>
     3e4:	0a054463          	bltz	a0,48c <_ZN11PipeCommand3runEv+0xb6>
    int pid = fork();
     3e8:	505000ef          	jal	10ec <fork>
    if (pid == -1)
     3ec:	57fd                	li	a5,-1
     3ee:	0cf50163          	beq	a0,a5,4b0 <_ZN11PipeCommand3runEv+0xda>
        if (fork_or_panic() == 0)
     3f2:	c931                	beqz	a0,446 <_ZN11PipeCommand3runEv+0x70>
    int pid = fork();
     3f4:	4f9000ef          	jal	10ec <fork>
    if (pid == -1)
     3f8:	577d                	li	a4,-1
     3fa:	06e50b63          	beq	a0,a4,470 <_ZN11PipeCommand3runEv+0x9a>
        if (fork_or_panic() == 0)
     3fe:	c505                	beqz	a0,426 <_ZN11PipeCommand3runEv+0x50>
        close(p[0]);
     400:	4522                	lw	a0,8(sp)
     402:	513000ef          	jal	1114 <close>
        close(p[1]);
     406:	4532                	lw	a0,12(sp)
     408:	50d000ef          	jal	1114 <close>
        wait(0);
     40c:	4501                	li	a0,0
     40e:	4e7000ef          	jal	10f4 <wait>
        wait(0);
     412:	4501                	li	a0,0
     414:	4e1000ef          	jal	10f4 <wait>
        exit(0);
     418:	4501                	li	a0,0
     41a:	008050ef          	jal	5422 <exit>
    }
     41e:	60e2                	ld	ra,24(sp)
     420:	6442                	ld	s0,16(sp)
     422:	6105                	addi	sp,sp,32
     424:	8082                	ret
            close(0);  // close stdin
     426:	4ef000ef          	jal	1114 <close>
            dup(p[0]); // dup read-end to stdin
     42a:	4522                	lw	a0,8(sp)
     42c:	539000ef          	jal	1164 <dup>
            close(p[0]);
     430:	4522                	lw	a0,8(sp)
     432:	4e3000ef          	jal	1114 <close>
            close(p[1]);
     436:	4532                	lw	a0,12(sp)
     438:	4dd000ef          	jal	1114 <close>
            right->run();
     43c:	6808                	ld	a0,16(s0)
     43e:	611c                	ld	a5,0(a0)
     440:	6b9c                	ld	a5,16(a5)
     442:	9782                	jalr	a5
     444:	bf75                	j	400 <_ZN11PipeCommand3runEv+0x2a>
            close(1);  // close stdout
     446:	4505                	li	a0,1
     448:	4cd000ef          	jal	1114 <close>
            dup(p[1]); // dup write-end to stdout
     44c:	4532                	lw	a0,12(sp)
     44e:	517000ef          	jal	1164 <dup>
            close(p[0]);
     452:	4522                	lw	a0,8(sp)
     454:	4c1000ef          	jal	1114 <close>
            close(p[1]);
     458:	4532                	lw	a0,12(sp)
     45a:	4bb000ef          	jal	1114 <close>
            left->run();
     45e:	6408                	ld	a0,8(s0)
     460:	611c                	ld	a5,0(a0)
     462:	6b9c                	ld	a5,16(a5)
     464:	9782                	jalr	a5
    int pid = fork();
     466:	487000ef          	jal	10ec <fork>
    if (pid == -1)
     46a:	577d                	li	a4,-1
     46c:	f8e519e3          	bne	a0,a4,3fe <_ZN11PipeCommand3runEv+0x28>
    printf("shell panic: %s\n", s);
     470:	00006597          	auipc	a1,0x6
     474:	bf058593          	addi	a1,a1,-1040 # 6060 <_GLOBAL__sub_I__ZSt3cin+0x5c>
     478:	00006517          	auipc	a0,0x6
     47c:	bf050513          	addi	a0,a0,-1040 # 6068 <_GLOBAL__sub_I__ZSt3cin+0x64>
     480:	48e040ef          	jal	490e <printf>
    exit(1);
     484:	4505                	li	a0,1
     486:	79d040ef          	jal	5422 <exit>
    return pid;
     48a:	bf9d                	j	400 <_ZN11PipeCommand3runEv+0x2a>
    printf("shell panic: %s\n", s);
     48c:	00006597          	auipc	a1,0x6
     490:	bf458593          	addi	a1,a1,-1036 # 6080 <_GLOBAL__sub_I__ZSt3cin+0x7c>
     494:	00006517          	auipc	a0,0x6
     498:	bd450513          	addi	a0,a0,-1068 # 6068 <_GLOBAL__sub_I__ZSt3cin+0x64>
     49c:	472040ef          	jal	490e <printf>
    exit(1);
     4a0:	4505                	li	a0,1
     4a2:	781040ef          	jal	5422 <exit>
    int pid = fork();
     4a6:	447000ef          	jal	10ec <fork>
    if (pid == -1)
     4aa:	57fd                	li	a5,-1
     4ac:	f4f513e3          	bne	a0,a5,3f2 <_ZN11PipeCommand3runEv+0x1c>
    printf("shell panic: %s\n", s);
     4b0:	00006597          	auipc	a1,0x6
     4b4:	bb058593          	addi	a1,a1,-1104 # 6060 <_GLOBAL__sub_I__ZSt3cin+0x5c>
     4b8:	00006517          	auipc	a0,0x6
     4bc:	bb050513          	addi	a0,a0,-1104 # 6068 <_GLOBAL__sub_I__ZSt3cin+0x64>
     4c0:	44e040ef          	jal	490e <printf>
    exit(1);
     4c4:	4505                	li	a0,1
     4c6:	75d040ef          	jal	5422 <exit>
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
     4fa:	9e248493          	addi	s1,s1,-1566 # 7ed8 <WHITESPACE>
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
     51e:	7bc050ef          	jal	5cda <strchr>
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
     552:	b5a50513          	addi	a0,a0,-1190 # 60a8 <_GLOBAL__sub_I__ZSt3cin+0xa4>
     556:	784050ef          	jal	5cda <strchr>
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
     572:	768050ef          	jal	5cda <strchr>
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
     5b8:	722050ef          	jal	5cda <strchr>
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
     5d4:	706050ef          	jal	5cda <strchr>
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
     622:	6b8050ef          	jal	5cda <strchr>
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
     64c:	1a1050ef          	jal	5fec <_Znwm>
        : sub_cmd(c), file(f), efile(ef), mode(m), fd(fd_in) {}
     650:	4705                	li	a4,1
     652:	1702                	slli	a4,a4,0x20
     654:	20170713          	addi	a4,a4,513
     658:	00007797          	auipc	a5,0x7
     65c:	7f078793          	addi	a5,a5,2032 # 7e48 <_ZTV12RedirCommand+0x10>
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
     688:	652050ef          	jal	5cda <strchr>
     68c:	e911                	bnez	a0,6a0 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1d4>
                s++;
     68e:	0d85                	addi	s11,s11,1
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     690:	01b40b63          	beq	s0,s11,6a6 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x1da>
     694:	000dc583          	lbu	a1,0(s11)
     698:	6088                	ld	a0,0(s1)
     69a:	640050ef          	jal	5cda <strchr>
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
     6d4:	9b858593          	addi	a1,a1,-1608 # 6088 <_GLOBAL__sub_I__ZSt3cin+0x84>
     6d8:	00006517          	auipc	a0,0x6
     6dc:	99050513          	addi	a0,a0,-1648 # 6068 <_GLOBAL__sub_I__ZSt3cin+0x64>
     6e0:	22e040ef          	jal	490e <printf>
    exit(1);
     6e4:	4505                	li	a0,1
     6e6:	53d040ef          	jal	5422 <exit>
            *eq = 0; // Null terminate filename immediately
     6ea:	000d8023          	sb	zero,0(s11)
            switch (tok)
     6ee:	f56995e3          	bne	s3,s6,638 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x16c>
                cmd = new RedirCommand(cmd, q, eq, O_RDONLY, 0);
     6f2:	02800513          	li	a0,40
     6f6:	0f7050ef          	jal	5fec <_Znwm>
        : sub_cmd(c), file(f), efile(ef), mode(m), fd(fd_in) {}
     6fa:	00007797          	auipc	a5,0x7
     6fe:	74e78793          	addi	a5,a5,1870 # 7e48 <_ZTV12RedirCommand+0x10>
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
     758:	095050ef          	jal	5fec <_Znwm>
        : sub_cmd(c), file(f), efile(ef), mode(m), fd(fd_in) {}
     75c:	00007797          	auipc	a5,0x7
     760:	6ec78793          	addi	a5,a5,1772 # 7e48 <_ZTV12RedirCommand+0x10>
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
     790:	54a050ef          	jal	5cda <strchr>
     794:	e911                	bnez	a0,7a8 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x2dc>
                s++;
     796:	0d05                	addi	s10,s10,1
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     798:	05a40f63          	beq	s0,s10,7f6 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x32a>
     79c:	000d4583          	lbu	a1,0(s10)
     7a0:	6088                	ld	a0,0(s1)
     7a2:	538050ef          	jal	5cda <strchr>
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
     82a:	7c2050ef          	jal	5fec <_Znwm>
     82e:	84aa                	mv	s1,a0
    {
     830:	00007797          	auipc	a5,0x7
     834:	5f078793          	addi	a5,a5,1520 # 7e20 <_ZTV11ExecCommand+0x10>
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
     848:	2a4050ef          	jal	5aec <memset>
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
     862:	67a48493          	addi	s1,s1,1658 # 7ed8 <WHITESPACE>
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
     87e:	45c050ef          	jal	5cda <strchr>
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
     8a6:	434050ef          	jal	5cda <strchr>
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
     8f2:	3e8050ef          	jal	5cda <strchr>
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
     90c:	7a858593          	addi	a1,a1,1960 # 60b0 <_GLOBAL__sub_I__ZSt3cin+0xac>
     910:	00005517          	auipc	a0,0x5
     914:	75850513          	addi	a0,a0,1880 # 6068 <_GLOBAL__sub_I__ZSt3cin+0x64>
     918:	7f7030ef          	jal	490e <printf>
    exit(1);
     91c:	4505                	li	a0,1
     91e:	305040ef          	jal	5422 <exit>
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
     990:	73c50513          	addi	a0,a0,1852 # 60c8 <_GLOBAL__sub_I__ZSt3cin+0xc4>
     994:	346050ef          	jal	5cda <strchr>
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
     9b0:	52c98993          	addi	s3,s3,1324 # 7ed8 <WHITESPACE>
     9b4:	a021                	j	9bc <_ZN6Parser10parse_pipeEPPcS0_+0x1b6>
            s++;
     9b6:	0d85                	addi	s11,s11,1
        while (s < es && strchr(WHITESPACE, *s))
     9b8:	01b40963          	beq	s0,s11,9ca <_ZN6Parser10parse_pipeEPPcS0_+0x1c4>
     9bc:	000dc583          	lbu	a1,0(s11)
     9c0:	0009b503          	ld	a0,0(s3)
     9c4:	316050ef          	jal	5cda <strchr>
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
     9fa:	6c258593          	addi	a1,a1,1730 # 60b8 <_GLOBAL__sub_I__ZSt3cin+0xb4>
     9fe:	00005517          	auipc	a0,0x5
     a02:	66a50513          	addi	a0,a0,1642 # 6068 <_GLOBAL__sub_I__ZSt3cin+0x64>
     a06:	709030ef          	jal	490e <printf>
    exit(1);
     a0a:	4505                	li	a0,1
     a0c:	217040ef          	jal	5422 <exit>
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
     a76:	46698993          	addi	s3,s3,1126 # 7ed8 <WHITESPACE>
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
     aa4:	63050513          	addi	a0,a0,1584 # 60d0 <_GLOBAL__sub_I__ZSt3cin+0xcc>
     aa8:	232050ef          	jal	5cda <strchr>
     aac:	d505                	beqz	a0,9d4 <_ZN6Parser10parse_pipeEPPcS0_+0x1ce>
        s = *ps;
     aae:	000a3483          	ld	s1,0(s4)
        while (s < es && strchr(WHITESPACE, *s))
     ab2:	0284f163          	bgeu	s1,s0,ad4 <_ZN6Parser10parse_pipeEPPcS0_+0x2ce>
     ab6:	00007997          	auipc	s3,0x7
     aba:	42298993          	addi	s3,s3,1058 # 7ed8 <WHITESPACE>
     abe:	a021                	j	ac6 <_ZN6Parser10parse_pipeEPPcS0_+0x2c0>
            s++;
     ac0:	0485                	addi	s1,s1,1
        while (s < es && strchr(WHITESPACE, *s))
     ac2:	00940963          	beq	s0,s1,ad4 <_ZN6Parser10parse_pipeEPPcS0_+0x2ce>
     ac6:	0004c583          	lbu	a1,0(s1)
     aca:	0009b503          	ld	a0,0(s3)
     ace:	20c050ef          	jal	5cda <strchr>
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
     b06:	3d698993          	addi	s3,s3,982 # 7ed8 <WHITESPACE>
     b0a:	0084e663          	bltu	s1,s0,b16 <_ZN6Parser10parse_pipeEPPcS0_+0x310>
     b0e:	a819                	j	b24 <_ZN6Parser10parse_pipeEPPcS0_+0x31e>
            s++;
     b10:	0485                	addi	s1,s1,1
        while (s < es && strchr(WHITESPACE, *s))
     b12:	0e940463          	beq	s0,s1,bfa <_ZN6Parser10parse_pipeEPPcS0_+0x3f4>
     b16:	0004c583          	lbu	a1,0(s1)
     b1a:	0009b503          	ld	a0,0(s3)
     b1e:	1bc050ef          	jal	5cda <strchr>
     b22:	f57d                	bnez	a0,b10 <_ZN6Parser10parse_pipeEPPcS0_+0x30a>
        *ps = s;
     b24:	009a3023          	sd	s1,0(s4)
            cmd = new PipeCommand(cmd, parse_pipe(ps, es));
     b28:	4561                	li	a0,24
     b2a:	4c2050ef          	jal	5fec <_Znwm>
     b2e:	87aa                	mv	a5,a0
     b30:	85a2                	mv	a1,s0
     b32:	8552                	mv	a0,s4
     b34:	843e                	mv	s0,a5
     b36:	cd1ff0ef          	jal	806 <_ZN6Parser10parse_pipeEPPcS0_>
    PipeCommand(Command *l, Command *r) : left(l), right(r) {}
     b3a:	00007797          	auipc	a5,0x7
     b3e:	33678793          	addi	a5,a5,822 # 7e70 <_ZTV11PipeCommand+0x10>
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
     b68:	172050ef          	jal	5cda <strchr>
     b6c:	e911                	bnez	a0,b80 <_ZN6Parser10parse_pipeEPPcS0_+0x37a>
                s++;
     b6e:	0d85                	addi	s11,s11,1
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     b70:	03b40a63          	beq	s0,s11,ba4 <_ZN6Parser10parse_pipeEPPcS0_+0x39e>
     b74:	000dc583          	lbu	a1,0(s11)
     b78:	6088                	ld	a0,0(s1)
     b7a:	160050ef          	jal	5cda <strchr>
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
     bd2:	30a98993          	addi	s3,s3,778 # 7ed8 <WHITESPACE>
     bd6:	0004c583          	lbu	a1,0(s1)
     bda:	0009b503          	ld	a0,0(s3)
     bde:	0fc050ef          	jal	5cda <strchr>
     be2:	f105                	bnez	a0,b02 <_ZN6Parser10parse_pipeEPPcS0_+0x2fc>
     be4:	0004c583          	lbu	a1,0(s1)
     be8:	0089b503          	ld	a0,8(s3)
     bec:	0ee050ef          	jal	5cda <strchr>
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
     c60:	27c90913          	addi	s2,s2,636 # 7ed8 <WHITESPACE>
        return *s && strchr(toks, *s);
     c64:	00005c97          	auipc	s9,0x5
     c68:	474c8c93          	addi	s9,s9,1140 # 60d8 <_GLOBAL__sub_I__ZSt3cin+0xd4>
        switch (*s)
     c6c:	03c00b13          	li	s6,60
     c70:	03e00b93          	li	s7,62
     c74:	07c00d93          	li	s11,124
     c78:	03a00c13          	li	s8,58
     c7c:	02600d13          	li	s10,38
    BackCommand(Command *c) : sub_cmd(c) {}
     c80:	00007a97          	auipc	s5,0x7
     c84:	240a8a93          	addi	s5,s5,576 # 7ec0 <_ZTV11BackCommand+0x10>
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
     ca0:	03a050ef          	jal	5cda <strchr>
     ca4:	f57d                	bnez	a0,c92 <_ZN6Parser10parse_lineEPPcS0_+0x5c>
        *ps = s;
     ca6:	0089b023          	sd	s0,0(s3)
        return *s && strchr(toks, *s);
     caa:	00044583          	lbu	a1,0(s0)
     cae:	e9a9                	bnez	a1,d00 <_ZN6Parser10parse_lineEPPcS0_+0xca>
        while (s < es && strchr(WHITESPACE, *s))
     cb0:	02947163          	bgeu	s0,s1,cd2 <_ZN6Parser10parse_lineEPPcS0_+0x9c>
     cb4:	00007917          	auipc	s2,0x7
     cb8:	22490913          	addi	s2,s2,548 # 7ed8 <WHITESPACE>
     cbc:	a021                	j	cc4 <_ZN6Parser10parse_lineEPPcS0_+0x8e>
            s++;
     cbe:	0405                	addi	s0,s0,1
        while (s < es && strchr(WHITESPACE, *s))
     cc0:	00848963          	beq	s1,s0,cd2 <_ZN6Parser10parse_lineEPPcS0_+0x9c>
     cc4:	00044583          	lbu	a1,0(s0)
     cc8:	00093503          	ld	a0,0(s2)
     ccc:	00e050ef          	jal	5cda <strchr>
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
     d02:	7d9040ef          	jal	5cda <strchr>
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
     d20:	7bb040ef          	jal	5cda <strchr>
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
     d5c:	77f040ef          	jal	5cda <strchr>
     d60:	f57d                	bnez	a0,d4e <_ZN6Parser10parse_lineEPPcS0_+0x118>
        *ps = s;
     d62:	0089b023          	sd	s0,0(s3)
            cmd = new BackCommand(cmd);
     d66:	4541                	li	a0,16
     d68:	284050ef          	jal	5fec <_Znwm>
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
     d8a:	751040ef          	jal	5cda <strchr>
     d8e:	fd4d                	bnez	a0,d48 <_ZN6Parser10parse_lineEPPcS0_+0x112>
                s++;
     d90:	0405                	addi	s0,s0,1
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
     d92:	00848a63          	beq	s1,s0,da6 <_ZN6Parser10parse_lineEPPcS0_+0x170>
     d96:	00044583          	lbu	a1,0(s0)
     d9a:	00093503          	ld	a0,0(s2)
     d9e:	73d040ef          	jal	5cda <strchr>
     da2:	d165                	beqz	a0,d82 <_ZN6Parser10parse_lineEPPcS0_+0x14c>
     da4:	b755                	j	d48 <_ZN6Parser10parse_lineEPPcS0_+0x112>
     da6:	8426                	mv	s0,s1
        *ps = s;
     da8:	0089b023          	sd	s0,0(s3)
            cmd = new BackCommand(cmd);
     dac:	4541                	li	a0,16
     dae:	23e050ef          	jal	5fec <_Znwm>
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
     dd2:	31250513          	addi	a0,a0,786 # 60e0 <_GLOBAL__sub_I__ZSt3cin+0xdc>
     dd6:	705040ef          	jal	5cda <strchr>
     dda:	f00502e3          	beqz	a0,cde <_ZN6Parser10parse_lineEPPcS0_+0xa8>
        s = *ps;
     dde:	0009b403          	ld	s0,0(s3)
        ret = *s;
     de2:	00044783          	lbu	a5,0(s0)
        while (s < es && strchr(WHITESPACE, *s))
     de6:	0e947863          	bgeu	s0,s1,ed6 <_ZN6Parser10parse_lineEPPcS0_+0x2a0>
     dea:	00007917          	auipc	s2,0x7
     dee:	0ee90913          	addi	s2,s2,238 # 7ed8 <WHITESPACE>
     df2:	a021                	j	dfa <_ZN6Parser10parse_lineEPPcS0_+0x1c4>
            s++;
     df4:	0405                	addi	s0,s0,1
        while (s < es && strchr(WHITESPACE, *s))
     df6:	00848963          	beq	s1,s0,e08 <_ZN6Parser10parse_lineEPPcS0_+0x1d2>
     dfa:	00044583          	lbu	a1,0(s0)
     dfe:	00093503          	ld	a0,0(s2)
     e02:	6d9040ef          	jal	5cda <strchr>
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
     e22:	0ba90913          	addi	s2,s2,186 # 7ed8 <WHITESPACE>
     e26:	00946663          	bltu	s0,s1,e32 <_ZN6Parser10parse_lineEPPcS0_+0x1fc>
     e2a:	a819                	j	e40 <_ZN6Parser10parse_lineEPPcS0_+0x20a>
            s++;
     e2c:	0405                	addi	s0,s0,1
        while (s < es && strchr(WHITESPACE, *s))
     e2e:	06848c63          	beq	s1,s0,ea6 <_ZN6Parser10parse_lineEPPcS0_+0x270>
     e32:	00044583          	lbu	a1,0(s0)
     e36:	00093503          	ld	a0,0(s2)
     e3a:	6a1040ef          	jal	5cda <strchr>
     e3e:	f57d                	bnez	a0,e2c <_ZN6Parser10parse_lineEPPcS0_+0x1f6>
        *ps = s;
     e40:	0089b023          	sd	s0,0(s3)
            cmd = new ListCommand(cmd, parse_line(ps, es));
     e44:	4561                	li	a0,24
     e46:	1a6050ef          	jal	5fec <_Znwm>
     e4a:	842a                	mv	s0,a0
     e4c:	85a6                	mv	a1,s1
     e4e:	854e                	mv	a0,s3
     e50:	de7ff0ef          	jal	c36 <_ZN6Parser10parse_lineEPPcS0_>
    ListCommand(Command *l, Command *r) : left(l), right(r) {}
     e54:	00007797          	auipc	a5,0x7
     e58:	04478793          	addi	a5,a5,68 # 7e98 <_ZTV11ListCommand+0x10>
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
     e8c:	64f040ef          	jal	5cda <strchr>
     e90:	f559                	bnez	a0,e1e <_ZN6Parser10parse_lineEPPcS0_+0x1e8>
     e92:	00044583          	lbu	a1,0(s0)
     e96:	00893503          	ld	a0,8(s2)
     e9a:	641040ef          	jal	5cda <strchr>
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
     f1a:	1ea50513          	addi	a0,a0,490 # 6100 <_GLOBAL__sub_I__ZSt3cin+0xfc>
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
     f3a:	d6a90913          	addi	s2,s2,-662 # 8ca0 <_ZZ4mainE3buf>
    printf("\n[Lume Shell] Initialized! \n");
     f3e:	1d1030ef          	jal	490e <printf>

    while (getcmd(buf, sizeof(buf)) >= 0)
    {
        if (buf[0] == 'c' && buf[1] == 'd' && (buf[2] == ' ' || buf[2] == '\n' || buf[2] == 0))
     f42:	06300a13          	li	s4,99
    if (pid == -1)
     f46:	5afd                	li	s5,-1
        Command *cmd = parse_line(&s, es);
     f48:	00810b13          	addi	s6,sp,8
            printf("leftovers: %s\n", s);
     f4c:	00005c97          	auipc	s9,0x5
     f50:	1fcc8c93          	addi	s9,s9,508 # 6148 <_GLOBAL__sub_I__ZSt3cin+0x144>
     f54:	00007997          	auipc	s3,0x7
     f58:	f8498993          	addi	s3,s3,-124 # 7ed8 <WHITESPACE>
    printf("shell panic: %s\n", s);
     f5c:	00005c17          	auipc	s8,0x5
     f60:	104c0c13          	addi	s8,s8,260 # 6060 <_GLOBAL__sub_I__ZSt3cin+0x5c>
     f64:	00005b97          	auipc	s7,0x5
     f68:	104b8b93          	addi	s7,s7,260 # 6068 <_GLOBAL__sub_I__ZSt3cin+0x64>
    while (getcmd(buf, sizeof(buf)) >= 0)
     f6c:	a021                	j	f74 <main+0x60>
                cmd->run();
                delete cmd;
            }
            exit(0);
        }
        wait(0);
     f6e:	4501                	li	a0,0
     f70:	184000ef          	jal	10f4 <wait>
    while (getcmd(buf, sizeof(buf)) >= 0)
     f74:	06400593          	li	a1,100
     f78:	854a                	mv	a0,s2
     f7a:	8e2ff0ef          	jal	5c <_Z6getcmdPci>
     f7e:	0e054f63          	bltz	a0,107c <main+0x168>
        if (buf[0] == 'c' && buf[1] == 'd' && (buf[2] == ' ' || buf[2] == '\n' || buf[2] == 0))
     f82:	00094783          	lbu	a5,0(s2)
     f86:	01479863          	bne	a5,s4,f96 <main+0x82>
     f8a:	00194703          	lbu	a4,1(s2)
     f8e:	06400793          	li	a5,100
     f92:	08f70e63          	beq	a4,a5,102e <main+0x11a>
    int pid = fork();
     f96:	156000ef          	jal	10ec <fork>
    if (pid == -1)
     f9a:	09550263          	beq	a0,s5,101e <main+0x10a>
        if (fork_or_panic() == 0)
     f9e:	f961                	bnez	a0,f6e <main+0x5a>
        char *es = s + strlen(s);
     fa0:	854a                	mv	a0,s2
     fa2:	e44a                	sd	s2,8(sp)
     fa4:	3e1040ef          	jal	5b84 <strlen>
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
     fcc:	50f040ef          	jal	5cda <strchr>
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
     fe2:	12d030ef          	jal	490e <printf>
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
    1000:	422040ef          	jal	5422 <exit>
    1004:	b7ad                	j	f6e <main+0x5a>
        return *s && strchr(toks, *s);
    1006:	0004c583          	lbu	a1,0(s1)
        *ps = s;
    100a:	e426                	sd	s1,8(sp)
        return *s && strchr(toks, *s);
    100c:	dde9                	beqz	a1,fe6 <main+0xd2>
    100e:	00005517          	auipc	a0,0x5
    1012:	06a50513          	addi	a0,a0,106 # 6078 <_GLOBAL__sub_I__ZSt3cin+0x74>
    1016:	4c5040ef          	jal	5cda <strchr>
        if (s != es)
    101a:	6422                	ld	s0,8(sp)
    101c:	bf7d                	j	fda <main+0xc6>
    printf("shell panic: %s\n", s);
    101e:	85e2                	mv	a1,s8
    1020:	855e                	mv	a0,s7
    1022:	0ed030ef          	jal	490e <printf>
    exit(1);
    1026:	4505                	li	a0,1
    1028:	3fa040ef          	jal	5422 <exit>
    return pid;
    102c:	b789                	j	f6e <main+0x5a>
        if (buf[0] == 'c' && buf[1] == 'd' && (buf[2] == ' ' || buf[2] == '\n' || buf[2] == 0))
    102e:	00294703          	lbu	a4,2(s2)
    1032:	02000793          	li	a5,32
    1036:	f6e7e0e3          	bltu	a5,a4,f96 <main+0x82>
    103a:	4785                	li	a5,1
    103c:	1782                	slli	a5,a5,0x20
    103e:	40178793          	addi	a5,a5,1025
    1042:	00e7d7b3          	srl	a5,a5,a4
    1046:	8b85                	andi	a5,a5,1
    1048:	d7b9                	beqz	a5,f96 <main+0x82>
            if (buf[strlen(buf) - 1] == '\n')
    104a:	00008517          	auipc	a0,0x8
    104e:	c5650513          	addi	a0,a0,-938 # 8ca0 <_ZZ4mainE3buf>
    1052:	333040ef          	jal	5b84 <strlen>
    1056:	954a                	add	a0,a0,s2
    1058:	fff54703          	lbu	a4,-1(a0)
    105c:	47a9                	li	a5,10
    105e:	06f70163          	beq	a4,a5,10c0 <main+0x1ac>
            if (buf[2] == '\n' || buf[2] == 0)
    1062:	00294783          	lbu	a5,2(s2)
    1066:	4729                	li	a4,10
    1068:	00e78363          	beq	a5,a4,106e <main+0x15a>
    106c:	e79d                	bnez	a5,109a <main+0x186>
                printf("cd: argument missing\n");
    106e:	00005517          	auipc	a0,0x5
    1072:	0b250513          	addi	a0,a0,178 # 6120 <_GLOBAL__sub_I__ZSt3cin+0x11c>
    1076:	099030ef          	jal	490e <printf>
                continue;
    107a:	bded                	j	f74 <main+0x60>
    }
    return 0;
    107c:	70a6                	ld	ra,104(sp)
    107e:	7406                	ld	s0,96(sp)
    1080:	64e6                	ld	s1,88(sp)
    1082:	6946                	ld	s2,80(sp)
    1084:	69a6                	ld	s3,72(sp)
    1086:	6a06                	ld	s4,64(sp)
    1088:	7ae2                	ld	s5,56(sp)
    108a:	7b42                	ld	s6,48(sp)
    108c:	7ba2                	ld	s7,40(sp)
    108e:	7c02                	ld	s8,32(sp)
    1090:	6ce2                	ld	s9,24(sp)
    1092:	6d42                	ld	s10,16(sp)
    1094:	4501                	li	a0,0
    1096:	6165                	addi	sp,sp,112
    1098:	8082                	ret
            if (chdir(path) < 0)
    109a:	00008517          	auipc	a0,0x8
    109e:	c0950513          	addi	a0,a0,-1015 # 8ca3 <_ZZ4mainE3buf+0x3>
    10a2:	0ba000ef          	jal	115c <chdir>
    10a6:	ec0557e3          	bgez	a0,f74 <main+0x60>
                printf("cannot cd %s\n", path);
    10aa:	00008597          	auipc	a1,0x8
    10ae:	bf958593          	addi	a1,a1,-1031 # 8ca3 <_ZZ4mainE3buf+0x3>
    10b2:	00005517          	auipc	a0,0x5
    10b6:	08650513          	addi	a0,a0,134 # 6138 <_GLOBAL__sub_I__ZSt3cin+0x134>
    10ba:	055030ef          	jal	490e <printf>
    10be:	bd5d                	j	f74 <main+0x60>
                buf[strlen(buf) - 1] = 0;
    10c0:	00008517          	auipc	a0,0x8
    10c4:	be050513          	addi	a0,a0,-1056 # 8ca0 <_ZZ4mainE3buf>
    10c8:	2bd040ef          	jal	5b84 <strlen>
    10cc:	00a907b3          	add	a5,s2,a0
    10d0:	fe078fa3          	sb	zero,-1(a5)
    10d4:	b779                	j	1062 <main+0x14e>

00000000000010d6 <_start>:
.section .text
.global _start

_start:
    li a0, 0
    10d6:	4501                	li	a0,0
    li a1, 0
    10d8:	4581                	li	a1,0

    call main
    10da:	e3bff0ef          	jal	f14 <main>

    call exit
    10de:	344040ef          	jal	5422 <exit>

    10e2:	a001                	j	10e2 <_start+0xc>

00000000000010e4 <sys_exit>:
    name: \
        li a7, SYS_ ## sysname; \
        ecall; \
        ret

SYSCALL_NAME(sys_exit, exit) 
    10e4:	488d                	li	a7,3
    10e6:	00000073          	ecall
    10ea:	8082                	ret

00000000000010ec <fork>:

SYSCALL(fork)
    10ec:	4889                	li	a7,2
    10ee:	00000073          	ecall
    10f2:	8082                	ret

00000000000010f4 <wait>:
SYSCALL(wait)
    10f4:	4891                	li	a7,4
    10f6:	00000073          	ecall
    10fa:	8082                	ret

00000000000010fc <pipe>:
SYSCALL(pipe)
    10fc:	4895                	li	a7,5
    10fe:	00000073          	ecall
    1102:	8082                	ret

0000000000001104 <read>:
SYSCALL(read)
    1104:	4899                	li	a7,6
    1106:	00000073          	ecall
    110a:	8082                	ret

000000000000110c <write>:
SYSCALL(write)
    110c:	48c5                	li	a7,17
    110e:	00000073          	ecall
    1112:	8082                	ret

0000000000001114 <close>:
SYSCALL(close)
    1114:	48d9                	li	a7,22
    1116:	00000073          	ecall
    111a:	8082                	ret

000000000000111c <kill>:
SYSCALL(kill)
    111c:	489d                	li	a7,7
    111e:	00000073          	ecall
    1122:	8082                	ret

0000000000001124 <exec>:
SYSCALL(exec)
    1124:	48a1                	li	a7,8
    1126:	00000073          	ecall
    112a:	8082                	ret

000000000000112c <open>:
SYSCALL(open)
    112c:	48c1                	li	a7,16
    112e:	00000073          	ecall
    1132:	8082                	ret

0000000000001134 <mknod>:
SYSCALL(mknod)
    1134:	48c9                	li	a7,18
    1136:	00000073          	ecall
    113a:	8082                	ret

000000000000113c <unlink>:
SYSCALL(unlink)
    113c:	48cd                	li	a7,19
    113e:	00000073          	ecall
    1142:	8082                	ret

0000000000001144 <fstat>:
SYSCALL(fstat)
    1144:	48a5                	li	a7,9
    1146:	00000073          	ecall
    114a:	8082                	ret

000000000000114c <link>:
SYSCALL(link)
    114c:	48d1                	li	a7,20
    114e:	00000073          	ecall
    1152:	8082                	ret

0000000000001154 <mkdir>:
SYSCALL(mkdir)
    1154:	48d5                	li	a7,21
    1156:	00000073          	ecall
    115a:	8082                	ret

000000000000115c <chdir>:
SYSCALL(chdir)
    115c:	48a9                	li	a7,10
    115e:	00000073          	ecall
    1162:	8082                	ret

0000000000001164 <dup>:
SYSCALL(dup)
    1164:	48ad                	li	a7,11
    1166:	00000073          	ecall
    116a:	8082                	ret

000000000000116c <getpid>:
SYSCALL(getpid)
    116c:	48b1                	li	a7,12
    116e:	00000073          	ecall
    1172:	8082                	ret

0000000000001174 <sbrk>:
SYSCALL(sbrk)
    1174:	48b5                	li	a7,13
    1176:	00000073          	ecall
    117a:	8082                	ret

000000000000117c <sleep>:
SYSCALL(sleep)
    117c:	48b9                	li	a7,14
    117e:	00000073          	ecall
    1182:	8082                	ret

0000000000001184 <uptime>:
SYSCALL(uptime)
    1184:	48bd                	li	a7,15
    1186:	00000073          	ecall
    118a:	8082                	ret

000000000000118c <putc>:
SYSCALL(putc)
    118c:	4885                	li	a7,1
    118e:	00000073          	ecall
    1192:	8082                	ret

0000000000001194 <disk_test>:
SYSCALL(disk_test)
    1194:	48dd                	li	a7,23
    1196:	00000073          	ecall
    119a:	8082                	ret

000000000000119c <lseek>:
    119c:	48e1                	li	a7,24
    119e:	00000073          	ecall
    11a2:	8082                	ret

00000000000011a4 <stbsp__clamp_callback>:
    11a4:	45dc                	lw	a5,12(a1)
    11a6:	4598                	lw	a4,8(a1)
    11a8:	9fb1                	addw	a5,a5,a2
    11aa:	c5dc                	sw	a5,12(a1)
    11ac:	0007069b          	sext.w	a3,a4
    11b0:	00e65463          	bge	a2,a4,11b8 <stbsp__clamp_callback+0x14>
    11b4:	0006069b          	sext.w	a3,a2
    11b8:	c685                	beqz	a3,11e0 <stbsp__clamp_callback+0x3c>
    11ba:	619c                	ld	a5,0(a1)
    11bc:	00a78e63          	beq	a5,a0,11d8 <stbsp__clamp_callback+0x34>
    11c0:	00d50633          	add	a2,a0,a3
    11c4:	00054703          	lbu	a4,0(a0)
    11c8:	0505                	addi	a0,a0,1
    11ca:	0785                	addi	a5,a5,1
    11cc:	fee78fa3          	sb	a4,-1(a5)
    11d0:	fec56ae3          	bltu	a0,a2,11c4 <stbsp__clamp_callback+0x20>
    11d4:	6188                	ld	a0,0(a1)
    11d6:	4598                	lw	a4,8(a1)
    11d8:	9f15                	subw	a4,a4,a3
    11da:	9536                	add	a0,a0,a3
    11dc:	e188                	sd	a0,0(a1)
    11de:	c598                	sw	a4,8(a1)
    11e0:	1ff00793          	li	a5,511
    11e4:	00e7d463          	bge	a5,a4,11ec <stbsp__clamp_callback+0x48>
    11e8:	6188                	ld	a0,0(a1)
    11ea:	8082                	ret
    11ec:	01058513          	addi	a0,a1,16
    11f0:	8082                	ret

00000000000011f2 <stbsp__count_clamp_callback>:
    11f2:	45dc                	lw	a5,12(a1)
    11f4:	01058513          	addi	a0,a1,16
    11f8:	9fb1                	addw	a5,a5,a2
    11fa:	c5dc                	sw	a5,12(a1)
    11fc:	8082                	ret

00000000000011fe <stbsp__real_to_str>:
    11fe:	e20508d3          	fmv.x.d	a7,fa0
    1202:	82aa                	mv	t0,a0
    1204:	4348d813          	srai	a6,a7,0x34
    1208:	8ec6                	mv	t4,a7
    120a:	7ff87813          	andi	a6,a6,2047
    120e:	8346                	mv	t1,a7
    1210:	03f8d513          	srli	a0,a7,0x3f
    1214:	0008d663          	bgez	a7,1220 <stbsp__real_to_str+0x22>
    1218:	22a517d3          	fneg.d	fa5,fa0
    121c:	e20788d3          	fmv.x.d	a7,fa5
    1220:	7ff00e13          	li	t3,2047
    1224:	35c80663          	beq	a6,t3,1570 <stbsp__real_to_str+0x372>
    1228:	1101                	addi	sp,sp,-32
    122a:	14080363          	beqz	a6,1370 <stbsp__real_to_str+0x172>
    122e:	c018081b          	addiw	a6,a6,-1023
    1232:	ec22                	sd	s0,24(sp)
    1234:	02081313          	slli	t1,a6,0x20
    1238:	66034d63          	bltz	t1,18b2 <stbsp__real_to_str+0x6b4>
    123c:	4d100313          	li	t1,1233
    1240:	0303033b          	mulw	t1,t1,a6
    1244:	4849                	li	a6,18
    1246:	40c3531b          	sraiw	t1,t1,0xc
    124a:	0013039b          	addiw	t2,t1,1
    124e:	4078083b          	subw	a6,a6,t2
    1252:	4359                	li	t1,22
    1254:	17036163          	bltu	t1,a6,13b6 <stbsp__real_to_str+0x1b8>
    1258:	00005317          	auipc	t1,0x5
    125c:	24830313          	addi	t1,t1,584 # 64a0 <stbsp__bot>
    1260:	080e                	slli	a6,a6,0x3
    1262:	981a                	add	a6,a6,t1
    1264:	00083e03          	ld	t3,0(a6)
    1268:	00083607          	fld	fa2,0(a6)
    126c:	f20887d3          	fmv.d.x	fa5,a7
    1270:	f8000837          	lui	a6,0xf8000
    1274:	01187333          	and	t1,a6,a7
    1278:	01c87833          	and	a6,a6,t3
    127c:	12f676d3          	fmul.d	fa3,fa2,fa5
    1280:	f20807d3          	fmv.d.x	fa5,a6
    1284:	f2030753          	fmv.d.x	fa4,t1
    1288:	f20305d3          	fmv.d.x	fa1,t1
    128c:	0af67653          	fsub.d	fa2,fa2,fa5
    1290:	f20887d3          	fmv.d.x	fa5,a7
    1294:	0ae7f753          	fsub.d	fa4,fa5,fa4
    1298:	f20807d3          	fmv.d.x	fa5,a6
    129c:	6ab7f7c7          	fmsub.d	fa5,fa5,fa1,fa3
    12a0:	7ab677c3          	fmadd.d	fa5,fa2,fa1,fa5
    12a4:	f20805d3          	fmv.d.x	fa1,a6
    12a8:	7ab777c3          	fmadd.d	fa5,fa4,fa1,fa5
    12ac:	7ac77743          	fmadd.d	fa4,fa4,fa2,fa5
    12b0:	02d777d3          	fadd.d	fa5,fa4,fa3
    12b4:	3782e837          	lui	a6,0x3782e
    12b8:	acf80813          	addi	a6,a6,-1329 # 3782dacf <_ZSt4cerr+0x37824c8f>
    12bc:	0832                	slli	a6,a6,0xc
    12be:	9d980813          	addi	a6,a6,-1575
    12c2:	084a                	slli	a6,a6,0x12
    12c4:	187d                	addi	a6,a6,-1
    12c6:	c22798d3          	fcvt.l.d	a7,fa5,rtz
    12ca:	0ad7f6d3          	fsub.d	fa3,fa5,fa3
    12ce:	00070e1b          	sext.w	t3,a4
    12d2:	d228f653          	fcvt.d.l	fa2,a7
    12d6:	0ac7f5d3          	fsub.d	fa1,fa5,fa2
    12da:	0ad77753          	fsub.d	fa4,fa4,fa3
    12de:	0af5f6d3          	fsub.d	fa3,fa1,fa5
    12e2:	0ad5f553          	fsub.d	fa0,fa1,fa3
    12e6:	02d67653          	fadd.d	fa2,fa2,fa3
    12ea:	0aa7f7d3          	fsub.d	fa5,fa5,fa0
    12ee:	0ac7f7d3          	fsub.d	fa5,fa5,fa2
    12f2:	02b7f7d3          	fadd.d	fa5,fa5,fa1
    12f6:	02e7f7d3          	fadd.d	fa5,fa5,fa4
    12fa:	c2279fd3          	fcvt.l.d	t6,fa5,rtz
    12fe:	9fc6                	add	t6,t6,a7
    1300:	19f87063          	bgeu	a6,t6,1480 <stbsp__real_to_str+0x282>
    1304:	2385                	addiw	t2,t2,1
    1306:	300e4363          	bltz	t3,160c <stbsp__real_to_str+0x40e>
    130a:	00e3833b          	addw	t1,t2,a4
    130e:	475d                	li	a4,23
    1310:	30677663          	bgeu	a4,t1,161c <stbsp__real_to_str+0x41e>
    1314:	577d                	li	a4,-1
    1316:	9301                	srli	a4,a4,0x20
    1318:	43f75863          	bge	a4,t6,1748 <stbsp__real_to_str+0x54a>
    131c:	07d00313          	li	t1,125
    1320:	877e                	mv	a4,t6
    1322:	4e01                	li	t3,0
    1324:	3e800813          	li	a6,1000
    1328:	130e                	slli	t1,t1,0x23
    132a:	a039                	j	1338 <stbsp__real_to_str+0x13a>
    132c:	030747b3          	div	a5,a4,a6
    1330:	4e05                	li	t3,1
    1332:	40674c63          	blt	a4,t1,174a <stbsp__real_to_str+0x54c>
    1336:	873e                	mv	a4,a5
    1338:	030768b3          	rem	a7,a4,a6
    133c:	fe0888e3          	beqz	a7,132c <stbsp__real_to_str+0x12e>
    1340:	400e0163          	beqz	t3,1742 <stbsp__real_to_str+0x544>
    1344:	8fbe                	mv	t6,a5
    1346:	05f5e7b7          	lui	a5,0x5f5e
    134a:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f552bf>
    134e:	04060413          	addi	s0,a2,64
    1352:	03860613          	addi	a2,a2,56
    1356:	15f7c863          	blt	a5,t6,14a6 <stbsp__real_to_str+0x2a8>
    135a:	000f871b          	sext.w	a4,t6
    135e:	20070463          	beqz	a4,1566 <stbsp__real_to_str+0x368>
    1362:	4f01                	li	t5,0
    1364:	4f81                	li	t6,0
    1366:	00007e97          	auipc	t4,0x7
    136a:	b82e8e93          	addi	t4,t4,-1150 # 7ee8 <stbsp__digitpair>
    136e:	aaa9                	j	14c8 <stbsp__real_to_str+0x2ca>
    1370:	0306                	slli	t1,t1,0x1
    1372:	3e030e63          	beqz	t1,176e <stbsp__real_to_str+0x570>
    1376:	4305                	li	t1,1
    1378:	ec22                	sd	s0,24(sp)
    137a:	00ce9e13          	slli	t3,t4,0xc
    137e:	134e                	slli	t1,t1,0x33
    1380:	520e4063          	bltz	t3,18a0 <stbsp__real_to_str+0x6a2>
    1384:	40135313          	srai	t1,t1,0x1
    1388:	01d37e33          	and	t3,t1,t4
    138c:	8f42                	mv	t5,a6
    138e:	387d                	addiw	a6,a6,-1
    1390:	fe0e0ae3          	beqz	t3,1384 <stbsp__real_to_str+0x186>
    1394:	26900313          	li	t1,617
    1398:	c00f081b          	addiw	a6,t5,-1024
    139c:	0268083b          	mulw	a6,a6,t1
    13a0:	41f8531b          	sraiw	t1,a6,0x1f
    13a4:	0153531b          	srliw	t1,t1,0x15
    13a8:	0103033b          	addw	t1,t1,a6
    13ac:	40b3539b          	sraiw	t2,t1,0xb
    13b0:	4849                	li	a6,18
    13b2:	4078083b          	subw	a6,a6,t2
    13b6:	41f8531b          	sraiw	t1,a6,0x1f
    13ba:	00684eb3          	xor	t4,a6,t1
    13be:	406e8f3b          	subw	t5,t4,t1
    13c2:	2c900313          	li	t1,713
    13c6:	03e3033b          	mulw	t1,t1,t5
    13ca:	4e35                	li	t3,13
    13cc:	8efa                	mv	t4,t5
    13ce:	40e35f9b          	sraiw	t6,t1,0xe
    13d2:	837e                	mv	t1,t6
    13d4:	23fe4363          	blt	t3,t6,15fa <stbsp__real_to_str+0x3fc>
    13d8:	5e25                	li	t3,-23
    13da:	026e0e3b          	mulw	t3,t3,t1
    13de:	01de0ebb          	addw	t4,t3,t4
    13e2:	22084f63          	bltz	a6,1620 <stbsp__real_to_str+0x422>
    13e6:	f2000753          	fmv.d.x	fa4,zero
    13ea:	00005e17          	auipc	t3,0x5
    13ee:	0b6e0e13          	addi	t3,t3,182 # 64a0 <stbsp__bot>
    13f2:	380e9e63          	bnez	t4,178e <stbsp__real_to_str+0x590>
    13f6:	f20887d3          	fmv.d.x	fa5,a7
    13fa:	fff30f1b          	addiw	t5,t1,-1
    13fe:	0f0e                	slli	t5,t5,0x3
    1400:	02f777d3          	fadd.d	fa5,fa4,fa5
    1404:	030e                	slli	t1,t1,0x3
    1406:	9f72                	add	t5,t5,t3
    1408:	9e1a                	add	t3,t3,t1
    140a:	2e0e3e03          	ld	t3,736(t3)
    140e:	2e8f3587          	fld	fa1,744(t5)
    1412:	f8000837          	lui	a6,0xf8000
    1416:	e2078ed3          	fmv.x.d	t4,fa5
    141a:	12b7f6d3          	fmul.d	fa3,fa5,fa1
    141e:	f2088653          	fmv.d.x	fa2,a7
    1422:	01d87333          	and	t1,a6,t4
    1426:	01c87833          	and	a6,a6,t3
    142a:	f20807d3          	fmv.d.x	fa5,a6
    142e:	f2030053          	fmv.d.x	ft0,t1
    1432:	0af5f553          	fsub.d	fa0,fa1,fa5
    1436:	f20e87d3          	fmv.d.x	fa5,t4
    143a:	0ac7f0d3          	fsub.d	ft1,fa5,fa2
    143e:	f20807d3          	fmv.d.x	fa5,a6
    1442:	f2030653          	fmv.d.x	fa2,t1
    1446:	6ac7f647          	fmsub.d	fa2,fa5,fa2,fa3
    144a:	f20e87d3          	fmv.d.x	fa5,t4
    144e:	0a177753          	fsub.d	fa4,fa4,ft1
    1452:	f20300d3          	fmv.d.x	ft1,t1
    1456:	0a07f7d3          	fsub.d	fa5,fa5,ft0
    145a:	350f3007          	fld	ft0,848(t5)
    145e:	62157643          	fmadd.d	fa2,fa0,ft1,fa2
    1462:	12b77753          	fmul.d	fa4,fa4,fa1
    1466:	f20805d3          	fmv.d.x	fa1,a6
    146a:	62b7f643          	fmadd.d	fa2,fa5,fa1,fa2
    146e:	f20e85d3          	fmv.d.x	fa1,t4
    1472:	7205f743          	fmadd.d	fa4,fa1,ft0,fa4
    1476:	62a7f7c3          	fmadd.d	fa5,fa5,fa0,fa2
    147a:	02e7f753          	fadd.d	fa4,fa5,fa4
    147e:	bd0d                	j	12b0 <stbsp__real_to_str+0xb2>
    1480:	00e3833b          	addw	t1,t2,a4
    1484:	2a0e4663          	bltz	t3,1730 <stbsp__real_to_str+0x532>
    1488:	475d                	li	a4,23
    148a:	10677663          	bgeu	a4,t1,1596 <stbsp__real_to_str+0x398>
    148e:	e80f93e3          	bnez	t6,1314 <stbsp__real_to_str+0x116>
    1492:	05f5e7b7          	lui	a5,0x5f5e
    1496:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f552bf>
    149a:	04060413          	addi	s0,a2,64
    149e:	03860613          	addi	a2,a2,56
    14a2:	ebf7dce3          	bge	a5,t6,135a <stbsp__real_to_str+0x15c>
    14a6:	4f01                	li	t5,0
    14a8:	00007e97          	auipc	t4,0x7
    14ac:	a40e8e93          	addi	t4,t4,-1472 # 7ee8 <stbsp__digitpair>
    14b0:	05f5e7b7          	lui	a5,0x5f5e
    14b4:	10078793          	addi	a5,a5,256 # 5f5e100 <_ZSt4cerr+0x5f552c0>
    14b8:	02ffe833          	rem	a6,t6,a5
    14bc:	02ffcfb3          	div	t6,t6,a5
    14c0:	0008071b          	sext.w	a4,a6
    14c4:	0a080463          	beqz	a6,156c <stbsp__real_to_str+0x36e>
    14c8:	8822                	mv	a6,s0
    14ca:	06400893          	li	a7,100
    14ce:	06300e13          	li	t3,99
    14d2:	1879                	addi	a6,a6,-2 # fffffffff7fffffe <_ZSt4cerr+0xfffffffff7ff71be>
    14d4:	0007031b          	sext.w	t1,a4
    14d8:	031777bb          	remuw	a5,a4,a7
    14dc:	2785                	addiw	a5,a5,1
    14de:	0017979b          	slliw	a5,a5,0x1
    14e2:	1782                	slli	a5,a5,0x20
    14e4:	9381                	srli	a5,a5,0x20
    14e6:	97f6                	add	a5,a5,t4
    14e8:	0007d783          	lhu	a5,0(a5)
    14ec:	0317573b          	divuw	a4,a4,a7
    14f0:	00f81023          	sh	a5,0(a6)
    14f4:	fc6e6fe3          	bltu	t3,t1,14d2 <stbsp__real_to_str+0x2d4>
    14f8:	008f0f3b          	addw	t5,t5,s0
    14fc:	410f0f3b          	subw	t5,t5,a6
    1500:	020f8f63          	beqz	t6,153e <stbsp__real_to_str+0x340>
    1504:	87c2                	mv	a5,a6
    1506:	03000713          	li	a4,48
    150a:	04c80c63          	beq	a6,a2,1562 <stbsp__real_to_str+0x364>
    150e:	17fd                	addi	a5,a5,-1
    1510:	00e78023          	sb	a4,0(a5)
    1514:	fec79de3          	bne	a5,a2,150e <stbsp__real_to_str+0x310>
    1518:	408807b3          	sub	a5,a6,s0
    151c:	00ff07bb          	addw	a5,t5,a5
    1520:	1461                	addi	s0,s0,-8
    1522:	00878f1b          	addiw	t5,a5,8
    1526:	05f5e7b7          	lui	a5,0x5f5e
    152a:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f552bf>
    152e:	ff840613          	addi	a2,s0,-8
    1532:	f7f7cfe3          	blt	a5,t6,14b0 <stbsp__real_to_str+0x2b2>
    1536:	000f871b          	sext.w	a4,t6
    153a:	4f81                	li	t6,0
    153c:	b771                	j	14c8 <stbsp__real_to_str+0x2ca>
    153e:	020f0563          	beqz	t5,1568 <stbsp__real_to_str+0x36a>
    1542:	00084703          	lbu	a4,0(a6)
    1546:	03000793          	li	a5,48
    154a:	22f70f63          	beq	a4,a5,1788 <stbsp__real_to_str+0x58a>
    154e:	2f01                	sext.w	t5,t5
    1550:	0076a023          	sw	t2,0(a3)
    1554:	6462                	ld	s0,24(sp)
    1556:	0102b023          	sd	a6,0(t0)
    155a:	01e5a023          	sw	t5,0(a1)
    155e:	6105                	addi	sp,sp,32
    1560:	8082                	ret
    1562:	8442                	mv	s0,a6
    1564:	b7c9                	j	1526 <stbsp__real_to_str+0x328>
    1566:	8822                	mv	a6,s0
    1568:	4f01                	li	t5,0
    156a:	b7dd                	j	1550 <stbsp__real_to_str+0x352>
    156c:	8822                	mv	a6,s0
    156e:	bf59                	j	1504 <stbsp__real_to_str+0x306>
    1570:	0eb2                	slli	t4,t4,0xc
    1572:	00005797          	auipc	a5,0x5
    1576:	bfe78793          	addi	a5,a5,-1026 # 6170 <_GLOBAL__sub_I__ZSt3cin+0x16c>
    157a:	000e8663          	beqz	t4,1586 <stbsp__real_to_str+0x388>
    157e:	00005797          	auipc	a5,0x5
    1582:	bea78793          	addi	a5,a5,-1046 # 6168 <_GLOBAL__sub_I__ZSt3cin+0x164>
    1586:	00f2b023          	sd	a5,0(t0)
    158a:	679d                	lui	a5,0x7
    158c:	c29c                	sw	a5,0(a3)
    158e:	4f0d                	li	t5,3
    1590:	01e5a023          	sw	t5,0(a1)
    1594:	8082                	ret
    1596:	3b9ad737          	lui	a4,0x3b9ad
    159a:	9ff70713          	addi	a4,a4,-1537 # 3b9ac9ff <_ZSt4cerr+0x3b9a3bbf>
    159e:	07f76f63          	bltu	a4,t6,161c <stbsp__real_to_str+0x41e>
    15a2:	4805                	li	a6,1
    15a4:	02081713          	slli	a4,a6,0x20
    15a8:	01d75893          	srli	a7,a4,0x1d
    15ac:	00005717          	auipc	a4,0x5
    15b0:	2ac70713          	addi	a4,a4,684 # 6858 <stbsp__powten>
    15b4:	9746                	add	a4,a4,a7
    15b6:	4e51                	li	t3,20
    15b8:	a021                	j	15c0 <stbsp__real_to_str+0x3c2>
    15ba:	2805                	addiw	a6,a6,1
    15bc:	edc809e3          	beq	a6,t3,148e <stbsp__real_to_str+0x290>
    15c0:	00073883          	ld	a7,0(a4)
    15c4:	0721                	addi	a4,a4,8
    15c6:	ff1ffae3          	bgeu	t6,a7,15ba <stbsp__real_to_str+0x3bc>
    15ca:	ed0372e3          	bgeu	t1,a6,148e <stbsp__real_to_str+0x290>
    15ce:	4068083b          	subw	a6,a6,t1
    15d2:	475d                	li	a4,23
    15d4:	eb076de3          	bltu	a4,a6,148e <stbsp__real_to_str+0x290>
    15d8:	080e                	slli	a6,a6,0x3
    15da:	00005717          	auipc	a4,0x5
    15de:	ec670713          	addi	a4,a4,-314 # 64a0 <stbsp__bot>
    15e2:	9742                	add	a4,a4,a6
    15e4:	3b873803          	ld	a6,952(a4)
    15e8:	00185713          	srli	a4,a6,0x1
    15ec:	977e                	add	a4,a4,t6
    15ee:	01176363          	bltu	a4,a7,15f4 <stbsp__real_to_str+0x3f6>
    15f2:	2385                	addiw	t2,t2,1
    15f4:	03075fb3          	divu	t6,a4,a6
    15f8:	bd59                	j	148e <stbsp__real_to_str+0x290>
    15fa:	4335                	li	t1,13
    15fc:	5e25                	li	t3,-23
    15fe:	026e0e3b          	mulw	t3,t3,t1
    1602:	01de0ebb          	addw	t4,t3,t4
    1606:	de0850e3          	bgez	a6,13e6 <stbsp__real_to_str+0x1e8>
    160a:	a819                	j	1620 <stbsp__real_to_str+0x422>
    160c:	02571313          	slli	t1,a4,0x25
    1610:	02535313          	srli	t1,t1,0x25
    1614:	0305                	addi	t1,t1,1
    1616:	475d                	li	a4,23
    1618:	ce676ee3          	bltu	a4,t1,1314 <stbsp__real_to_str+0x116>
    161c:	4829                	li	a6,10
    161e:	b759                	j	15a4 <stbsp__real_to_str+0x3a6>
    1620:	260e8663          	beqz	t4,188c <stbsp__real_to_str+0x68e>
    1624:	00231e13          	slli	t3,t1,0x2
    1628:	41c30e33          	sub	t3,t1,t3
    162c:	0e0e                	slli	t3,t3,0x3
    162e:	9e1a                	add	t3,t3,t1
    1630:	fffe881b          	addiw	a6,t4,-1
    1634:	9e7a                	add	t3,t3,t5
    1636:	00005e97          	auipc	t4,0x5
    163a:	e6ae8e93          	addi	t4,t4,-406 # 64a0 <stbsp__bot>
    163e:	0e0e                	slli	t3,t3,0x3
    1640:	080e                	slli	a6,a6,0x3
    1642:	9876                	add	a6,a6,t4
    1644:	9ef2                	add	t4,t4,t3
    1646:	0b883607          	fld	fa2,184(a6)
    164a:	f20887d3          	fmv.d.x	fa5,a7
    164e:	0b0ebf03          	ld	t5,176(t4)
    1652:	f8000e37          	lui	t3,0xf8000
    1656:	011e7eb3          	and	t4,t3,a7
    165a:	12f676d3          	fmul.d	fa3,fa2,fa5
    165e:	01ee7e33          	and	t3,t3,t5
    1662:	f20e07d3          	fmv.d.x	fa5,t3
    1666:	f20e0753          	fmv.d.x	fa4,t3
    166a:	f20e8553          	fmv.d.x	fa0,t4
    166e:	0af67653          	fsub.d	fa2,fa2,fa5
    1672:	f20e87d3          	fmv.d.x	fa5,t4
    1676:	f20e85d3          	fmv.d.x	fa1,t4
    167a:	6ae7f7c7          	fmsub.d	fa5,fa5,fa4,fa3
    167e:	f2088753          	fmv.d.x	fa4,a7
    1682:	0ab775d3          	fsub.d	fa1,fa4,fa1
    1686:	16883707          	fld	fa4,360(a6)
    168a:	7aa677c3          	fmadd.d	fa5,fa2,fa0,fa5
    168e:	f20e0553          	fmv.d.x	fa0,t3
    1692:	7aa5f7c3          	fmadd.d	fa5,fa1,fa0,fa5
    1696:	7ac5f5c3          	fmadd.d	fa1,fa1,fa2,fa5
    169a:	f20887d3          	fmv.d.x	fa5,a7
    169e:	5af77743          	fmadd.d	fa4,fa4,fa5,fa1
    16a2:	c00f87e3          	beqz	t6,12b0 <stbsp__real_to_str+0xb2>
    16a6:	02d777d3          	fadd.d	fa5,fa4,fa3
    16aa:	fff3089b          	addiw	a7,t1,-1
    16ae:	00005817          	auipc	a6,0x5
    16b2:	df280813          	addi	a6,a6,-526 # 64a0 <stbsp__bot>
    16b6:	030e                	slli	t1,t1,0x3
    16b8:	088e                	slli	a7,a7,0x3
    16ba:	98c2                	add	a7,a7,a6
    16bc:	981a                	add	a6,a6,t1
    16be:	e2078e53          	fmv.x.d	t3,fa5
    16c2:	21083e83          	ld	t4,528(a6)
    16c6:	f8000837          	lui	a6,0xf8000
    16ca:	2188b507          	fld	fa0,536(a7)
    16ce:	01c87333          	and	t1,a6,t3
    16d2:	01d87833          	and	a6,a6,t4
    16d6:	f2080653          	fmv.d.x	fa2,a6
    16da:	12f577d3          	fmul.d	fa5,fa0,fa5
    16de:	2808b587          	fld	fa1,640(a7)
    16e2:	0ac57053          	fsub.d	ft0,fa0,fa2
    16e6:	f20e0653          	fmv.d.x	fa2,t3
    16ea:	0ad67153          	fsub.d	ft2,fa2,fa3
    16ee:	f20806d3          	fmv.d.x	fa3,a6
    16f2:	f2030653          	fmv.d.x	fa2,t1
    16f6:	7ac6f0c7          	fmsub.d	ft1,fa3,fa2,fa5
    16fa:	f20e06d3          	fmv.d.x	fa3,t3
    16fe:	0ac6f653          	fsub.d	fa2,fa3,fa2
    1702:	22f786d3          	fmv.d	fa3,fa5
    1706:	0a2777d3          	fsub.d	fa5,fa4,ft2
    170a:	f2030753          	fmv.d.x	fa4,t1
    170e:	0ae07743          	fmadd.d	fa4,ft0,fa4,ft1
    1712:	12a7f7d3          	fmul.d	fa5,fa5,fa0
    1716:	f2080553          	fmv.d.x	fa0,a6
    171a:	72a67743          	fmadd.d	fa4,fa2,fa0,fa4
    171e:	f20e0553          	fmv.d.x	fa0,t3
    1722:	7aa5f7c3          	fmadd.d	fa5,fa1,fa0,fa5
    1726:	72067643          	fmadd.d	fa2,fa2,ft0,fa4
    172a:	02f67753          	fadd.d	fa4,fa2,fa5
    172e:	b649                	j	12b0 <stbsp__real_to_str+0xb2>
    1730:	02571313          	slli	t1,a4,0x25
    1734:	02535313          	srli	t1,t1,0x25
    1738:	0305                	addi	t1,t1,1
    173a:	475d                	li	a4,23
    173c:	d46769e3          	bltu	a4,t1,148e <stbsp__real_to_str+0x290>
    1740:	bd99                	j	1596 <stbsp__real_to_str+0x398>
    1742:	87fe                	mv	a5,t6
    1744:	8fbe                	mv	t6,a5
    1746:	b101                	j	1346 <stbsp__real_to_str+0x148>
    1748:	87fe                	mv	a5,t6
    174a:	3e800713          	li	a4,1000
    174e:	02e7f73b          	remuw	a4,a5,a4
    1752:	2781                	sext.w	a5,a5
    1754:	eb01                	bnez	a4,1764 <stbsp__real_to_str+0x566>
    1756:	3e800813          	li	a6,1000
    175a:	0307d7bb          	divuw	a5,a5,a6
    175e:	0307f73b          	remuw	a4,a5,a6
    1762:	df65                	beqz	a4,175a <stbsp__real_to_str+0x55c>
    1764:	02079f93          	slli	t6,a5,0x20
    1768:	020fdf93          	srli	t6,t6,0x20
    176c:	b31d                	j	1492 <stbsp__real_to_str+0x294>
    176e:	4785                	li	a5,1
    1770:	c29c                	sw	a5,0(a3)
    1772:	00c2b023          	sd	a2,0(t0)
    1776:	03000793          	li	a5,48
    177a:	00f60023          	sb	a5,0(a2)
    177e:	4f05                	li	t5,1
    1780:	01e5a023          	sw	t5,0(a1)
    1784:	6105                	addi	sp,sp,32
    1786:	8082                	ret
    1788:	0805                	addi	a6,a6,1 # fffffffff8000001 <_ZSt4cerr+0xfffffffff7ff71c1>
    178a:	3f7d                	addiw	t5,t5,-1
    178c:	b3d1                	j	1550 <stbsp__real_to_str+0x352>
    178e:	e826                	sd	s1,16(sp)
    1790:	e44a                	sd	s2,8(sp)
    1792:	4859                	li	a6,22
    1794:	8976                	mv	s2,t4
    1796:	11d84363          	blt	a6,t4,189c <stbsp__real_to_str+0x69e>
    179a:	0009049b          	sext.w	s1,s2
    179e:	00005e17          	auipc	t3,0x5
    17a2:	d02e0e13          	addi	t3,t3,-766 # 64a0 <stbsp__bot>
    17a6:	00349813          	slli	a6,s1,0x3
    17aa:	9872                	add	a6,a6,t3
    17ac:	00083687          	fld	fa3,0(a6)
    17b0:	00083803          	ld	a6,0(a6)
    17b4:	f20887d3          	fmv.d.x	fa5,a7
    17b8:	f8000fb7          	lui	t6,0xf8000
    17bc:	010ff833          	and	a6,t6,a6
    17c0:	12f6f553          	fmul.d	fa0,fa3,fa5
    17c4:	f20807d3          	fmv.d.x	fa5,a6
    17c8:	011ff433          	and	s0,t6,a7
    17cc:	f2040753          	fmv.d.x	fa4,s0
    17d0:	0af6f6d3          	fsub.d	fa3,fa3,fa5
    17d4:	f20887d3          	fmv.d.x	fa5,a7
    17d8:	f2080653          	fmv.d.x	fa2,a6
    17dc:	412e8ebb          	subw	t4,t4,s2
    17e0:	0ae7f753          	fsub.d	fa4,fa5,fa4
    17e4:	f20407d3          	fmv.d.x	fa5,s0
    17e8:	e20508d3          	fmv.x.d	a7,fa0
    17ec:	52c7f7c7          	fmsub.d	fa5,fa5,fa2,fa0
    17f0:	f2040653          	fmv.d.x	fa2,s0
    17f4:	7ac6f7c3          	fmadd.d	fa5,fa3,fa2,fa5
    17f8:	f2080653          	fmv.d.x	fa2,a6
    17fc:	7ac777c3          	fmadd.d	fa5,fa4,fa2,fa5
    1800:	7ad77743          	fmadd.d	fa4,fa4,fa3,fa5
    1804:	080e8963          	beqz	t4,1896 <stbsp__real_to_str+0x698>
    1808:	02e577d3          	fadd.d	fa5,fa0,fa4
    180c:	0e8e                	slli	t4,t4,0x3
    180e:	01de0833          	add	a6,t3,t4
    1812:	00083587          	fld	fa1,0(a6)
    1816:	00231893          	slli	a7,t1,0x2
    181a:	411308b3          	sub	a7,t1,a7
    181e:	00389813          	slli	a6,a7,0x3
    1822:	e2078453          	fmv.x.d	s0,fa5
    1826:	12f5f7d3          	fmul.d	fa5,fa1,fa5
    182a:	981a                	add	a6,a6,t1
    182c:	987a                	add	a6,a6,t5
    182e:	40980833          	sub	a6,a6,s1
    1832:	080e                	slli	a6,a6,0x3
    1834:	9872                	add	a6,a6,t3
    1836:	00083e83          	ld	t4,0(a6)
    183a:	008ff833          	and	a6,t6,s0
    183e:	e20788d3          	fmv.x.d	a7,fa5
    1842:	f20806d3          	fmv.d.x	fa3,a6
    1846:	f20407d3          	fmv.d.x	fa5,s0
    184a:	01dfffb3          	and	t6,t6,t4
    184e:	f20880d3          	fmv.d.x	ft1,a7
    1852:	0ad7f653          	fsub.d	fa2,fa5,fa3
    1856:	f20f87d3          	fmv.d.x	fa5,t6
    185a:	64c2                	ld	s1,16(sp)
    185c:	6922                	ld	s2,8(sp)
    185e:	0af5f053          	fsub.d	ft0,fa1,fa5
    1862:	0ad7f6c7          	fmsub.d	fa3,fa5,fa3,ft1
    1866:	f20407d3          	fmv.d.x	fa5,s0
    186a:	0aa7f7d3          	fsub.d	fa5,fa5,fa0
    186e:	f2080553          	fmv.d.x	fa0,a6
    1872:	6aa076c3          	fmadd.d	fa3,ft0,fa0,fa3
    1876:	0af77753          	fsub.d	fa4,fa4,fa5
    187a:	f20f87d3          	fmv.d.x	fa5,t6
    187e:	6af677c3          	fmadd.d	fa5,fa2,fa5,fa3
    1882:	7a067643          	fmadd.d	fa2,fa2,ft0,fa5
    1886:	62e5f743          	fmadd.d	fa4,fa1,fa4,fa2
    188a:	b6b5                	j	13f6 <stbsp__real_to_str+0x1f8>
    188c:	f20886d3          	fmv.d.x	fa3,a7
    1890:	f2000753          	fmv.d.x	fa4,zero
    1894:	b539                	j	16a2 <stbsp__real_to_str+0x4a4>
    1896:	64c2                	ld	s1,16(sp)
    1898:	6922                	ld	s2,8(sp)
    189a:	beb1                	j	13f6 <stbsp__real_to_str+0x1f8>
    189c:	4959                	li	s2,22
    189e:	bdf5                	j	179a <stbsp__real_to_str+0x59c>
    18a0:	e826                	sd	s1,16(sp)
    18a2:	e44a                	sd	s2,8(sp)
    18a4:	ecc00393          	li	t2,-308
    18a8:	4eed                	li	t4,27
    18aa:	4335                	li	t1,13
    18ac:	14600f13          	li	t5,326
    18b0:	b5cd                	j	1792 <stbsp__real_to_str+0x594>
    18b2:	26900313          	li	t1,617
    18b6:	0303083b          	mulw	a6,t1,a6
    18ba:	41f8531b          	sraiw	t1,a6,0x1f
    18be:	0153531b          	srliw	t1,t1,0x15
    18c2:	0103033b          	addw	t1,t1,a6
    18c6:	40b3539b          	sraiw	t2,t1,0xb
    18ca:	4849                	li	a6,18
    18cc:	4078083b          	subw	a6,a6,t2
    18d0:	b249                	j	1252 <stbsp__real_to_str+0x54>

00000000000018d2 <_in_char.part.0>:
static int _in_char(_InContext *ctx)
    18d2:	87aa                	mv	a5,a0
    if (ctx->fd == -1)
    18d4:	4508                	lw	a0,8(a0)
    18d6:	577d                	li	a4,-1
    18d8:	00e51d63          	bne	a0,a4,18f2 <_in_char.part.0+0x20>
        if (ctx->buf[ctx->pos] == '\0')
    18dc:	6b94                	ld	a3,16(a5)
    18de:	6398                	ld	a4,0(a5)
    18e0:	9736                	add	a4,a4,a3
    18e2:	00074603          	lbu	a2,0(a4)
    18e6:	c60d                	beqz	a2,1910 <_in_char.part.0+0x3e>
        return (unsigned char)ctx->buf[ctx->pos++];
    18e8:	0685                	addi	a3,a3,1
    18ea:	eb94                	sd	a3,16(a5)
    18ec:	00074503          	lbu	a0,0(a4)
    18f0:	8082                	ret
static int _in_char(_InContext *ctx)
    18f2:	1101                	addi	sp,sp,-32
    if (read(ctx->fd, &c, 1) == 1)
    18f4:	4605                	li	a2,1
    18f6:	00f10593          	addi	a1,sp,15
static int _in_char(_InContext *ctx)
    18fa:	ec06                	sd	ra,24(sp)
    if (read(ctx->fd, &c, 1) == 1)
    18fc:	809ff0ef          	jal	1104 <read>
    1900:	4785                	li	a5,1
    1902:	00f51963          	bne	a0,a5,1914 <_in_char.part.0+0x42>
        return (unsigned char)c;
    1906:	00f14503          	lbu	a0,15(sp)
}
    190a:	60e2                	ld	ra,24(sp)
    190c:	6105                	addi	sp,sp,32
    190e:	8082                	ret
            return -1;
    1910:	557d                	li	a0,-1
}
    1912:	8082                	ret
            return -1;
    1914:	557d                	li	a0,-1
    1916:	bfd5                	j	190a <_in_char.part.0+0x38>

0000000000001918 <_skip_space>:
{
    1918:	7139                	addi	sp,sp,-64
    191a:	f822                	sd	s0,48(sp)
    191c:	f426                	sd	s1,40(sp)
    191e:	f04a                	sd	s2,32(sp)
    1920:	ec4e                	sd	s3,24(sp)
    1922:	e852                	sd	s4,16(sp)
    1924:	fc06                	sd	ra,56(sp)
    1926:	842a                	mv	s0,a0
        ctx->ungotten = -1;
    1928:	54fd                	li	s1,-1
    if (read(ctx->fd, &c, 1) == 1)
    192a:	00f10a13          	addi	s4,sp,15
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    192e:	02000913          	li	s2,32
    1932:	4991                	li	s3,4
    if (ctx->ungotten >= 0)
    1934:	4c1c                	lw	a5,24(s0)
    1936:	0407d163          	bgez	a5,1978 <_skip_space+0x60>
    if (ctx->fd == -1)
    193a:	4408                	lw	a0,8(s0)
    if (read(ctx->fd, &c, 1) == 1)
    193c:	4605                	li	a2,1
    193e:	85d2                	mv	a1,s4
    if (ctx->fd == -1)
    1940:	02951e63          	bne	a0,s1,197c <_skip_space+0x64>
        if (ctx->buf[ctx->pos] == '\0')
    1944:	6818                	ld	a4,16(s0)
    1946:	601c                	ld	a5,0(s0)
        return (unsigned char)ctx->buf[ctx->pos++];
    1948:	00170693          	addi	a3,a4,1
        if (ctx->buf[ctx->pos] == '\0')
    194c:	97ba                	add	a5,a5,a4
    194e:	0007c703          	lbu	a4,0(a5) # 7000 <STDIN_FD+0x700>
    1952:	cb19                	beqz	a4,1968 <_skip_space+0x50>
        return (unsigned char)ctx->buf[ctx->pos++];
    1954:	e814                	sd	a3,16(s0)
    1956:	0007c783          	lbu	a5,0(a5)
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    195a:	ff77871b          	addiw	a4,a5,-9
    195e:	fd278be3          	beq	a5,s2,1934 <_skip_space+0x1c>
    1962:	fce9f9e3          	bgeu	s3,a4,1934 <_skip_space+0x1c>
        ctx->ungotten = c;
    1966:	cc1c                	sw	a5,24(s0)
}
    1968:	70e2                	ld	ra,56(sp)
    196a:	7442                	ld	s0,48(sp)
    196c:	74a2                	ld	s1,40(sp)
    196e:	7902                	ld	s2,32(sp)
    1970:	69e2                	ld	s3,24(sp)
    1972:	6a42                	ld	s4,16(sp)
    1974:	6121                	addi	sp,sp,64
    1976:	8082                	ret
        ctx->ungotten = -1;
    1978:	cc04                	sw	s1,24(s0)
        return c;
    197a:	b7c5                	j	195a <_skip_space+0x42>
    if (read(ctx->fd, &c, 1) == 1)
    197c:	f88ff0ef          	jal	1104 <read>
    1980:	4785                	li	a5,1
    1982:	fef513e3          	bne	a0,a5,1968 <_skip_space+0x50>
        return (unsigned char)c;
    1986:	00f14783          	lbu	a5,15(sp)
    198a:	bfc1                	j	195a <_skip_space+0x42>

000000000000198c <_vscanf_core.constprop.0>:
static int _vscanf_core(_InContext *ctx, const char *format, va_list ap)
    198c:	7155                	addi	sp,sp,-208
    198e:	e586                	sd	ra,200(sp)
    1990:	e95a                	sd	s6,144(sp)
    while (*p)
    1992:	0005c783          	lbu	a5,0(a1)
static int _vscanf_core(_InContext *ctx, const char *format, va_list ap)
    1996:	e432                	sd	a2,8(sp)
    while (*p)
    1998:	68078b63          	beqz	a5,202e <_vscanf_core.constprop.0+0x6a2>
    199c:	e1a2                	sd	s0,192(sp)
    199e:	fd26                	sd	s1,184(sp)
    19a0:	f152                	sd	s4,160(sp)
    19a2:	ed56                	sd	s5,152(sp)
    19a4:	f4ee                	sd	s11,104(sp)
    19a6:	842e                	mv	s0,a1
    19a8:	8daa                	mv	s11,a0
    int assigned = 0;
    19aa:	4b01                	li	s6,0
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    19ac:	02000493          	li	s1,32
    19b0:	4a91                	li	s5,4
        if (*p != '%')
    19b2:	02500a13          	li	s4,37
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    19b6:	04978763          	beq	a5,s1,1a04 <_vscanf_core.constprop.0+0x78>
    19ba:	ff77869b          	addiw	a3,a5,-9
    19be:	0ff6f693          	zext.b	a3,a3
    19c2:	04daf163          	bgeu	s5,a3,1a04 <_vscanf_core.constprop.0+0x78>
        if (*p != '%')
    19c6:	07478d63          	beq	a5,s4,1a40 <_vscanf_core.constprop.0+0xb4>
            _skip_space(ctx);
    19ca:	856e                	mv	a0,s11
    19cc:	f4dff0ef          	jal	1918 <_skip_space>
    if (ctx->ungotten >= 0)
    19d0:	018da503          	lw	a0,24(s11)
    19d4:	04055a63          	bgez	a0,1a28 <_vscanf_core.constprop.0+0x9c>
    19d8:	856e                	mv	a0,s11
    19da:	ef9ff0ef          	jal	18d2 <_in_char.part.0>
            if (c != *p)
    19de:	00044783          	lbu	a5,0(s0)
    19e2:	04a78a63          	beq	a5,a0,1a36 <_vscanf_core.constprop.0+0xaa>
    if (c != -1)
    19e6:	57fd                	li	a5,-1
    19e8:	00f50463          	beq	a0,a5,19f0 <_vscanf_core.constprop.0+0x64>
        ctx->ungotten = c;
    19ec:	00adac23          	sw	a0,24(s11)
    19f0:	640e                	ld	s0,192(sp)
    19f2:	74ea                	ld	s1,184(sp)
    19f4:	7a0a                	ld	s4,160(sp)
    19f6:	6aea                	ld	s5,152(sp)
    19f8:	7da6                	ld	s11,104(sp)
}
    19fa:	60ae                	ld	ra,200(sp)
    19fc:	855a                	mv	a0,s6
    19fe:	6b4a                	ld	s6,144(sp)
    1a00:	6169                	addi	sp,sp,208
    1a02:	8082                	ret
            _skip_space(ctx);
    1a04:	856e                	mv	a0,s11
    1a06:	f13ff0ef          	jal	1918 <_skip_space>
            while (isspace(*p))
    1a0a:	00044783          	lbu	a5,0(s0)
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    1a0e:	4611                	li	a2,4
    1a10:	ff77869b          	addiw	a3,a5,-9
    1a14:	0ff6f693          	zext.b	a3,a3
    1a18:	00978663          	beq	a5,s1,1a24 <_vscanf_core.constprop.0+0x98>
    1a1c:	00d67463          	bgeu	a2,a3,1a24 <_vscanf_core.constprop.0+0x98>
    while (*p)
    1a20:	fbd9                	bnez	a5,19b6 <_vscanf_core.constprop.0+0x2a>
    1a22:	b7f9                	j	19f0 <_vscanf_core.constprop.0+0x64>
                p++;
    1a24:	0405                	addi	s0,s0,1
    1a26:	b7d5                	j	1a0a <_vscanf_core.constprop.0+0x7e>
        ctx->ungotten = -1;
    1a28:	57fd                	li	a5,-1
    1a2a:	00fdac23          	sw	a5,24(s11)
            if (c != *p)
    1a2e:	00044783          	lbu	a5,0(s0)
    1a32:	faa79ae3          	bne	a5,a0,19e6 <_vscanf_core.constprop.0+0x5a>
    while (*p)
    1a36:	00144783          	lbu	a5,1(s0)
            p++;
    1a3a:	0405                	addi	s0,s0,1
    while (*p)
    1a3c:	ffad                	bnez	a5,19b6 <_vscanf_core.constprop.0+0x2a>
    1a3e:	bf4d                	j	19f0 <_vscanf_core.constprop.0+0x64>
    1a40:	f94a                	sd	s2,176(sp)
    1a42:	f54e                	sd	s3,168(sp)
    1a44:	e55e                	sd	s7,136(sp)
    1a46:	e162                	sd	s8,128(sp)
        if (*p == '*')
    1a48:	00144583          	lbu	a1,1(s0)
    1a4c:	02a00793          	li	a5,42
    1a50:	22f58d63          	beq	a1,a5,1c8a <_vscanf_core.constprop.0+0x2fe>
        p++;
    1a54:	0405                	addi	s0,s0,1
        int suppress = 0;
    1a56:	4981                	li	s3,0
        while (*p >= '0' && *p <= '9')
    1a58:	fd05861b          	addiw	a2,a1,-48
    1a5c:	0ff67693          	zext.b	a3,a2
    1a60:	47a5                	li	a5,9
    1a62:	36d7e763          	bltu	a5,a3,1dd0 <_vscanf_core.constprop.0+0x444>
    1a66:	4781                	li	a5,0
    1a68:	4825                	li	a6,9
    1a6a:	a019                	j	1a70 <_vscanf_core.constprop.0+0xe4>
            width = width * 10 + (*p - '0');
    1a6c:	0016979b          	slliw	a5,a3,0x1
        while (*p >= '0' && *p <= '9')
    1a70:	00144583          	lbu	a1,1(s0)
            width = width * 10 + (*p - '0');
    1a74:	00f6093b          	addw	s2,a2,a5
    1a78:	0029169b          	slliw	a3,s2,0x2
        while (*p >= '0' && *p <= '9')
    1a7c:	fd05861b          	addiw	a2,a1,-48
    1a80:	0ff67513          	zext.b	a0,a2
            width = width * 10 + (*p - '0');
    1a84:	012686bb          	addw	a3,a3,s2
            p++;
    1a88:	0405                	addi	s0,s0,1
        while (*p >= '0' && *p <= '9')
    1a8a:	fea871e3          	bgeu	a6,a0,1a6c <_vscanf_core.constprop.0+0xe0>
        if (*p == 'l')
    1a8e:	06c00693          	li	a3,108
            p++;
    1a92:	00140b93          	addi	s7,s0,1
        if (*p == 'l')
    1a96:	1ed58f63          	beq	a1,a3,1c94 <_vscanf_core.constprop.0+0x308>
        else if (*p == 'h')
    1a9a:	06800693          	li	a3,104
    1a9e:	2ad58863          	beq	a1,a3,1d4e <_vscanf_core.constprop.0+0x3c2>
        char spec = *p++;
    1aa2:	00044c03          	lbu	s8,0(s0)
    1aa6:	8ba2                	mv	s7,s0
        int len_mod = 0;
    1aa8:	ec02                	sd	zero,24(sp)
        char spec = *p++;
    1aaa:	06300693          	li	a3,99
    1aae:	001b8413          	addi	s0,s7,1
        if (!spec)
    1ab2:	2adc0863          	beq	s8,a3,1d62 <_vscanf_core.constprop.0+0x3d6>
    1ab6:	1f86fc63          	bgeu	a3,s8,1cae <_vscanf_core.constprop.0+0x322>
    1aba:	f9cc069b          	addiw	a3,s8,-100
    1abe:	0ff6f693          	zext.b	a3,a3
    1ac2:	4651                	li	a2,20
    1ac4:	0cd66e63          	bltu	a2,a3,1ba0 <_vscanf_core.constprop.0+0x214>
    1ac8:	00120637          	lui	a2,0x120
    1acc:	4585                	li	a1,1
    1ace:	00d595b3          	sll	a1,a1,a3
    1ad2:	02160613          	addi	a2,a2,33 # 120021 <_ZSt4cerr+0x1171e1>
    1ad6:	8e6d                	and	a2,a2,a1
    1ad8:	ee69                	bnez	a2,1bb2 <_vscanf_core.constprop.0+0x226>
    1ada:	89b9                	andi	a1,a1,14
    1adc:	1e059263          	bnez	a1,1cc0 <_vscanf_core.constprop.0+0x334>
    1ae0:	463d                	li	a2,15
    1ae2:	0ac69f63          	bne	a3,a2,1ba0 <_vscanf_core.constprop.0+0x214>
            _skip_space(ctx);
    1ae6:	856e                	mv	a0,s11
    1ae8:	e31ff0ef          	jal	1918 <_skip_space>
            char *buf = suppress ? NULL : va_arg(ap, char *);
    1aec:	ec02                	sd	zero,24(sp)
    1aee:	00099763          	bnez	s3,1afc <_vscanf_core.constprop.0+0x170>
    1af2:	67a2                	ld	a5,8(sp)
    1af4:	6398                	ld	a4,0(a5)
    1af6:	07a1                	addi	a5,a5,8
    1af8:	e43e                	sd	a5,8(sp)
    1afa:	ec3a                	sd	a4,24(sp)
    if (ctx->ungotten >= 0)
    1afc:	018da503          	lw	a0,24(s11)
    1b00:	2e055b63          	bgez	a0,1df6 <_vscanf_core.constprop.0+0x46a>
    1b04:	856e                	mv	a0,s11
    1b06:	dcdff0ef          	jal	18d2 <_in_char.part.0>
            while (c != -1 && !isspace(c))
    1b0a:	56fd                	li	a3,-1
    1b0c:	6ad50363          	beq	a0,a3,21b2 <_vscanf_core.constprop.0+0x826>
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    1b10:	02000693          	li	a3,32
    1b14:	3ed50963          	beq	a0,a3,1f06 <_vscanf_core.constprop.0+0x57a>
    1b18:	46a5                	li	a3,9
    1b1a:	3ed50663          	beq	a0,a3,1f06 <_vscanf_core.constprop.0+0x57a>
    1b1e:	46a9                	li	a3,10
    1b20:	3ed50363          	beq	a0,a3,1f06 <_vscanf_core.constprop.0+0x57a>
    1b24:	46ad                	li	a3,11
    1b26:	3ed50063          	beq	a0,a3,1f06 <_vscanf_core.constprop.0+0x57a>
    1b2a:	46b1                	li	a3,12
    1b2c:	3cd50d63          	beq	a0,a3,1f06 <_vscanf_core.constprop.0+0x57a>
    1b30:	46b5                	li	a3,13
    1b32:	3cd50a63          	beq	a0,a3,1f06 <_vscanf_core.constprop.0+0x57a>
    1b36:	67e2                	ld	a5,24(sp)
    1b38:	fce6                	sd	s9,120(sp)
    1b3a:	f8ea                	sd	s10,112(sp)
    1b3c:	e83e                	sd	a5,16(sp)
    1b3e:	4d01                	li	s10,0
            while (c != -1 && !isspace(c))
    1b40:	5c7d                	li	s8,-1
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    1b42:	02000c93          	li	s9,32
                if (width > 0 && i >= width)
    1b46:	01205463          	blez	s2,1b4e <_vscanf_core.constprop.0+0x1c2>
    1b4a:	052d5563          	bge	s10,s2,1b94 <_vscanf_core.constprop.0+0x208>
                if (!suppress)
    1b4e:	00099563          	bnez	s3,1b58 <_vscanf_core.constprop.0+0x1cc>
                    buf[i] = (char)c;
    1b52:	67c2                	ld	a5,16(sp)
    1b54:	00a78023          	sb	a0,0(a5)
    if (ctx->ungotten >= 0)
    1b58:	018da503          	lw	a0,24(s11)
                i++;
    1b5c:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
    1b5e:	30055963          	bgez	a0,1e70 <_vscanf_core.constprop.0+0x4e4>
    1b62:	856e                	mv	a0,s11
    1b64:	d6fff0ef          	jal	18d2 <_in_char.part.0>
            while (c != -1 && !isspace(c))
    1b68:	27850663          	beq	a0,s8,1dd4 <_vscanf_core.constprop.0+0x448>
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
    1b6c:	03950463          	beq	a0,s9,1b94 <_vscanf_core.constprop.0+0x208>
    1b70:	47a5                	li	a5,9
    1b72:	02f50163          	beq	a0,a5,1b94 <_vscanf_core.constprop.0+0x208>
    1b76:	47a9                	li	a5,10
    1b78:	00f50e63          	beq	a0,a5,1b94 <_vscanf_core.constprop.0+0x208>
    1b7c:	47ad                	li	a5,11
    1b7e:	00f50b63          	beq	a0,a5,1b94 <_vscanf_core.constprop.0+0x208>
    1b82:	47b1                	li	a5,12
    1b84:	00f50863          	beq	a0,a5,1b94 <_vscanf_core.constprop.0+0x208>
    1b88:	67c2                	ld	a5,16(sp)
    1b8a:	0785                	addi	a5,a5,1
    1b8c:	e83e                	sd	a5,16(sp)
    1b8e:	47b5                	li	a5,13
    1b90:	faf51be3          	bne	a0,a5,1b46 <_vscanf_core.constprop.0+0x1ba>
            if (!suppress)
    1b94:	64098a63          	beqz	s3,21e8 <_vscanf_core.constprop.0+0x85c>
    1b98:	7ce6                	ld	s9,120(sp)
    1b9a:	7d46                	ld	s10,112(sp)
        ctx->ungotten = c;
    1b9c:	00adac23          	sw	a0,24(s11)
    while (*p)
    1ba0:	001bc783          	lbu	a5,1(s7)
    1ba4:	794a                	ld	s2,176(sp)
    1ba6:	79aa                	ld	s3,168(sp)
    1ba8:	6baa                	ld	s7,136(sp)
    1baa:	6c0a                	ld	s8,128(sp)
    1bac:	e00795e3          	bnez	a5,19b6 <_vscanf_core.constprop.0+0x2a>
    1bb0:	b581                	j	19f0 <_vscanf_core.constprop.0+0x64>
            _skip_space(ctx);
    1bb2:	856e                	mv	a0,s11
    1bb4:	f8ea                	sd	s10,112(sp)
    1bb6:	d63ff0ef          	jal	1918 <_skip_space>
    if (ctx->ungotten >= 0)
    1bba:	018da503          	lw	a0,24(s11)
    1bbe:	24055063          	bgez	a0,1dfe <_vscanf_core.constprop.0+0x472>
    1bc2:	856e                	mv	a0,s11
    1bc4:	d0fff0ef          	jal	18d2 <_in_char.part.0>
            if (c == '-' || c == '+')
    1bc8:	fd55069b          	addiw	a3,a0,-43
    1bcc:	9af5                	andi	a3,a3,-3
    1bce:	2681                	sext.w	a3,a3
            int i = 0, c = _in_char(ctx);
    1bd0:	4d01                	li	s10,0
            if (c == '-' || c == '+')
    1bd2:	3e068863          	beqz	a3,1fc2 <_vscanf_core.constprop.0+0x636>
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
    1bd6:	07800693          	li	a3,120
    1bda:	4641                	li	a2,16
    1bdc:	00dc0863          	beq	s8,a3,1bec <_vscanf_core.constprop.0+0x260>
    1be0:	06900693          	li	a3,105
    1be4:	4629                	li	a2,10
    1be6:	00dc1363          	bne	s8,a3,1bec <_vscanf_core.constprop.0+0x260>
    1bea:	4601                	li	a2,0
            while (c != -1 && i < 63)
    1bec:	56fd                	li	a3,-1
    1bee:	5cd50863          	beq	a0,a3,21be <_vscanf_core.constprop.0+0x832>
    1bf2:	fce6                	sd	s9,120(sp)
    1bf4:	02010893          	addi	a7,sp,32
    1bf8:	01a88c33          	add	s8,a7,s10
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
    1bfc:	4cc1                	li	s9,16
                int digit = (c >= '0' && c <= '9');
    1bfe:	fd05069b          	addiw	a3,a0,-48
    1c02:	0005031b          	sext.w	t1,a0
    1c06:	00a6b593          	sltiu	a1,a3,10
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
    1c0a:	27960a63          	beq	a2,s9,1e7e <_vscanf_core.constprop.0+0x4f2>
    1c0e:	2a060d63          	beqz	a2,1ec8 <_vscanf_core.constprop.0+0x53c>
                int x = (c == 'x' || c == 'X');
    1c12:	07800793          	li	a5,120
    1c16:	2ef50363          	beq	a0,a5,1efc <_vscanf_core.constprop.0+0x570>
    1c1a:	fa850693          	addi	a3,a0,-88
    1c1e:	0016b693          	seqz	a3,a3
    1c22:	4301                	li	t1,0
                if (width > 0 && i >= width)
    1c24:	01205463          	blez	s2,1c2c <_vscanf_core.constprop.0+0x2a0>
    1c28:	032d5a63          	bge	s10,s2,1c5c <_vscanf_core.constprop.0+0x2d0>
                if (digit || hex || x)
    1c2c:	0066e6b3          	or	a3,a3,t1
    1c30:	8ecd                	or	a3,a3,a1
    1c32:	c68d                	beqz	a3,1c5c <_vscanf_core.constprop.0+0x2d0>
                    num_buf[i++] = (char)c;
    1c34:	00ac0023          	sb	a0,0(s8)
    if (ctx->ungotten >= 0)
    1c38:	018da503          	lw	a0,24(s11)
                    num_buf[i++] = (char)c;
    1c3c:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
    1c3e:	22055c63          	bgez	a0,1e76 <_vscanf_core.constprop.0+0x4ea>
    1c42:	856e                	mv	a0,s11
    1c44:	e832                	sd	a2,16(sp)
    1c46:	c8dff0ef          	jal	18d2 <_in_char.part.0>
            while (c != -1 && i < 63)
    1c4a:	57fd                	li	a5,-1
    1c4c:	6642                	ld	a2,16(sp)
    1c4e:	3cf50263          	beq	a0,a5,2012 <_vscanf_core.constprop.0+0x686>
    1c52:	03f00693          	li	a3,63
    1c56:	0c05                	addi	s8,s8,1
    1c58:	fadd13e3          	bne	s10,a3,1bfe <_vscanf_core.constprop.0+0x272>
            num_buf[i] = '\0';
    1c5c:	040d0793          	addi	a5,s10,64
    1c60:	1018                	addi	a4,sp,32
    1c62:	97ba                	add	a5,a5,a4
    1c64:	fc078023          	sb	zero,-64(a5)
        ctx->ungotten = c;
    1c68:	00adac23          	sw	a0,24(s11)
    1c6c:	7ce6                	ld	s9,120(sp)
            if (i == 0)
    1c6e:	1e0d0663          	beqz	s10,1e5a <_vscanf_core.constprop.0+0x4ce>
            if (!suppress)
    1c72:	36098363          	beqz	s3,1fd8 <_vscanf_core.constprop.0+0x64c>
    while (*p)
    1c76:	001bc783          	lbu	a5,1(s7)
        {
    1c7a:	794a                	ld	s2,176(sp)
    1c7c:	79aa                	ld	s3,168(sp)
    1c7e:	6baa                	ld	s7,136(sp)
    1c80:	6c0a                	ld	s8,128(sp)
    1c82:	7d46                	ld	s10,112(sp)
    while (*p)
    1c84:	d20799e3          	bnez	a5,19b6 <_vscanf_core.constprop.0+0x2a>
    1c88:	b3a5                	j	19f0 <_vscanf_core.constprop.0+0x64>
        while (*p >= '0' && *p <= '9')
    1c8a:	00244583          	lbu	a1,2(s0)
            suppress = 1;
    1c8e:	4985                	li	s3,1
            p++;
    1c90:	0409                	addi	s0,s0,2
    1c92:	b3d9                	j	1a58 <_vscanf_core.constprop.0+0xcc>
            if (*p == 'l')
    1c94:	00144c03          	lbu	s8,1(s0)
            len_mod = 1;
    1c98:	4785                	li	a5,1
    1c9a:	ec3e                	sd	a5,24(sp)
            if (*p == 'l')
    1c9c:	e0bc17e3          	bne	s8,a1,1aaa <_vscanf_core.constprop.0+0x11e>
                len_mod = 2;
    1ca0:	4789                	li	a5,2
        char spec = *p++;
    1ca2:	00244c03          	lbu	s8,2(s0)
                p++;
    1ca6:	00240b93          	addi	s7,s0,2
                len_mod = 2;
    1caa:	ec3e                	sd	a5,24(sp)
    1cac:	bbfd                	j	1aaa <_vscanf_core.constprop.0+0x11e>
    1cae:	100c0763          	beqz	s8,1dbc <_vscanf_core.constprop.0+0x430>
    1cb2:	fbbc079b          	addiw	a5,s8,-69
    1cb6:	0ff7f793          	zext.b	a5,a5
    1cba:	4689                	li	a3,2
    1cbc:	eef6e2e3          	bltu	a3,a5,1ba0 <_vscanf_core.constprop.0+0x214>
            _skip_space(ctx);
    1cc0:	856e                	mv	a0,s11
    1cc2:	f8ea                	sd	s10,112(sp)
    1cc4:	c55ff0ef          	jal	1918 <_skip_space>
    if (ctx->ungotten >= 0)
    1cc8:	018da783          	lw	a5,24(s11)
    1ccc:	1207dd63          	bgez	a5,1e06 <_vscanf_core.constprop.0+0x47a>
    1cd0:	856e                	mv	a0,s11
    1cd2:	c01ff0ef          	jal	18d2 <_in_char.part.0>
            if (c == '-' || c == '+')
    1cd6:	fd55069b          	addiw	a3,a0,-43
    1cda:	ffd6f613          	andi	a2,a3,-3
    1cde:	2601                	sext.w	a2,a2
    1ce0:	87aa                	mv	a5,a0
    1ce2:	12060c63          	beqz	a2,1e1a <_vscanf_core.constprop.0+0x48e>
            while (c != -1 && i < 63)
    1ce6:	567d                	li	a2,-1
    1ce8:	16c50963          	beq	a0,a2,1e5a <_vscanf_core.constprop.0+0x4ce>
    1cec:	fce6                	sd	s9,120(sp)
            int i = 0, c = _in_char(ctx);
    1cee:	4d01                	li	s10,0
    1cf0:	80000937          	lui	s2,0x80000
    1cf4:	197d                	addi	s2,s2,-1 # ffffffff7fffffff <_ZSt4cerr+0xffffffff7fff71bf>
    1cf6:	0932                	slli	s2,s2,0xc
    1cf8:	80194913          	xori	s2,s2,-2047
    1cfc:	093e                	slli	s2,s2,0xf
    1cfe:	02010813          	addi	a6,sp,32
    1d02:	01a80cb3          	add	s9,a6,s10
    1d06:	03a00c13          	li	s8,58
    1d0a:	1935                	addi	s2,s2,-19
    1d0c:	a831                	j	1d28 <_vscanf_core.constprop.0+0x39c>
    1d0e:	bc5ff0ef          	jal	18d2 <_in_char.part.0>
            while (c != -1 && i < 63)
    1d12:	577d                	li	a4,-1
    1d14:	87aa                	mv	a5,a0
    1d16:	2ee50563          	beq	a0,a4,2000 <_vscanf_core.constprop.0+0x674>
    1d1a:	03f00713          	li	a4,63
    1d1e:	0c85                	addi	s9,s9,1
    1d20:	1eed0e63          	beq	s10,a4,1f1c <_vscanf_core.constprop.0+0x590>
    1d24:	fd57869b          	addiw	a3,a5,-43
        int c = ctx->ungotten;
    1d28:	00d95633          	srl	a2,s2,a3
    1d2c:	856e                	mv	a0,s11
    1d2e:	8a05                	andi	a2,a2,1
    1d30:	1edc6663          	bltu	s8,a3,1f1c <_vscanf_core.constprop.0+0x590>
    1d34:	1e060463          	beqz	a2,1f1c <_vscanf_core.constprop.0+0x590>
                    num_buf[i++] = (char)c;
    1d38:	00fc8023          	sb	a5,0(s9)
    if (ctx->ungotten >= 0)
    1d3c:	018da783          	lw	a5,24(s11)
                    num_buf[i++] = (char)c;
    1d40:	2d05                	addiw	s10,s10,1
    if (ctx->ungotten >= 0)
    1d42:	fc07c6e3          	bltz	a5,1d0e <_vscanf_core.constprop.0+0x382>
        ctx->ungotten = -1;
    1d46:	577d                	li	a4,-1
    1d48:	00edac23          	sw	a4,24(s11)
            while (c != -1 && i < 63)
    1d4c:	b7f9                	j	1d1a <_vscanf_core.constprop.0+0x38e>
            if (*p == 'h')
    1d4e:	00144c03          	lbu	s8,1(s0)
        int len_mod = 0;
    1d52:	ec02                	sd	zero,24(sp)
            if (*p == 'h')
    1d54:	d4bc1be3          	bne	s8,a1,1aaa <_vscanf_core.constprop.0+0x11e>
        char spec = *p++;
    1d58:	00244c03          	lbu	s8,2(s0)
                p++;
    1d5c:	00240b93          	addi	s7,s0,2
    1d60:	b3a9                	j	1aaa <_vscanf_core.constprop.0+0x11e>
    1d62:	fce6                	sd	s9,120(sp)
    1d64:	f8ea                	sd	s10,112(sp)
            int count = (width > 0) ? width : 1;
    1d66:	00090c1b          	sext.w	s8,s2
    1d6a:	0d205a63          	blez	s2,1e3e <_vscanf_core.constprop.0+0x4b2>
            char *buf = suppress ? NULL : va_arg(ap, char *);
    1d6e:	4d01                	li	s10,0
    1d70:	06098d63          	beqz	s3,1dea <_vscanf_core.constprop.0+0x45e>
            for (int i = 0; i < count; i++)
    1d74:	9c6a                	add	s8,s8,s10
                if (c == -1)
    1d76:	5cfd                	li	s9,-1
    if (ctx->ungotten >= 0)
    1d78:	018da783          	lw	a5,24(s11)
        ctx->ungotten = -1;
    1d7c:	856e                	mv	a0,s11
    if (ctx->ungotten >= 0)
    1d7e:	0207dc63          	bgez	a5,1db6 <_vscanf_core.constprop.0+0x42a>
    1d82:	b51ff0ef          	jal	18d2 <_in_char.part.0>
    1d86:	87aa                	mv	a5,a0
                if (c == -1)
    1d88:	0b950d63          	beq	a0,s9,1e42 <_vscanf_core.constprop.0+0x4b6>
                if (!suppress)
    1d8c:	00099463          	bnez	s3,1d94 <_vscanf_core.constprop.0+0x408>
                    buf[i] = (char)c;
    1d90:	00fd0023          	sb	a5,0(s10)
            for (int i = 0; i < count; i++)
    1d94:	0d05                	addi	s10,s10,1
    1d96:	ffac11e3          	bne	s8,s10,1d78 <_vscanf_core.constprop.0+0x3ec>
    while (*p)
    1d9a:	001bc783          	lbu	a5,1(s7)
            if (!suppress)
    1d9e:	00099363          	bnez	s3,1da4 <_vscanf_core.constprop.0+0x418>
                assigned++;
    1da2:	2b05                	addiw	s6,s6,1
    1da4:	794a                	ld	s2,176(sp)
    1da6:	79aa                	ld	s3,168(sp)
    1da8:	6baa                	ld	s7,136(sp)
    1daa:	6c0a                	ld	s8,128(sp)
    1dac:	7ce6                	ld	s9,120(sp)
    1dae:	7d46                	ld	s10,112(sp)
    while (*p)
    1db0:	c00793e3          	bnez	a5,19b6 <_vscanf_core.constprop.0+0x2a>
    1db4:	b935                	j	19f0 <_vscanf_core.constprop.0+0x64>
        ctx->ungotten = -1;
    1db6:	019dac23          	sw	s9,24(s11)
                if (c == -1)
    1dba:	bfc9                	j	1d8c <_vscanf_core.constprop.0+0x400>
    1dbc:	640e                	ld	s0,192(sp)
    1dbe:	74ea                	ld	s1,184(sp)
    1dc0:	794a                	ld	s2,176(sp)
    1dc2:	79aa                	ld	s3,168(sp)
    1dc4:	7a0a                	ld	s4,160(sp)
    1dc6:	6aea                	ld	s5,152(sp)
    1dc8:	6baa                	ld	s7,136(sp)
    1dca:	6c0a                	ld	s8,128(sp)
    1dcc:	7da6                	ld	s11,104(sp)
    1dce:	b135                	j	19fa <_vscanf_core.constprop.0+0x6e>
        int width = -1;
    1dd0:	597d                	li	s2,-1
    1dd2:	b975                	j	1a8e <_vscanf_core.constprop.0+0x102>
            if (!suppress)
    1dd4:	3c099c63          	bnez	s3,21ac <_vscanf_core.constprop.0+0x820>
                buf[i] = '\0';
    1dd8:	67e2                	ld	a5,24(sp)
    1dda:	01a786b3          	add	a3,a5,s10
    1dde:	00068023          	sb	zero,0(a3)
    while (*p)
    1de2:	001bc783          	lbu	a5,1(s7)
                assigned++;
    1de6:	2b05                	addiw	s6,s6,1
    1de8:	bf75                	j	1da4 <_vscanf_core.constprop.0+0x418>
            char *buf = suppress ? NULL : va_arg(ap, char *);
    1dea:	67a2                	ld	a5,8(sp)
    1dec:	0007bd03          	ld	s10,0(a5)
    1df0:	07a1                	addi	a5,a5,8
    1df2:	e43e                	sd	a5,8(sp)
    1df4:	b741                	j	1d74 <_vscanf_core.constprop.0+0x3e8>
        ctx->ungotten = -1;
    1df6:	56fd                	li	a3,-1
    1df8:	00ddac23          	sw	a3,24(s11)
            while (c != -1 && !isspace(c))
    1dfc:	bb11                	j	1b10 <_vscanf_core.constprop.0+0x184>
        ctx->ungotten = -1;
    1dfe:	56fd                	li	a3,-1
    1e00:	00ddac23          	sw	a3,24(s11)
        return c;
    1e04:	b3d1                	j	1bc8 <_vscanf_core.constprop.0+0x23c>
            if (c == '-' || c == '+')
    1e06:	fd57869b          	addiw	a3,a5,-43
    1e0a:	ffd6f613          	andi	a2,a3,-3
        ctx->ungotten = -1;
    1e0e:	55fd                	li	a1,-1
    1e10:	00bdac23          	sw	a1,24(s11)
            if (c == '-' || c == '+')
    1e14:	2601                	sext.w	a2,a2
    1e16:	ec061be3          	bnez	a2,1cec <_vscanf_core.constprop.0+0x360>
                num_buf[i++] = (char)c;
    1e1a:	02f10023          	sb	a5,32(sp)
    if (ctx->ungotten >= 0)
    1e1e:	018da783          	lw	a5,24(s11)
    1e22:	2207da63          	bgez	a5,2056 <_vscanf_core.constprop.0+0x6ca>
    1e26:	856e                	mv	a0,s11
    1e28:	aabff0ef          	jal	18d2 <_in_char.part.0>
            while (c != -1 && i < 63)
    1e2c:	567d                	li	a2,-1
    1e2e:	87aa                	mv	a5,a0
                num_buf[i++] = (char)c;
    1e30:	4d05                	li	s10,1
    1e32:	fd55069b          	addiw	a3,a0,-43
            while (c != -1 && i < 63)
    1e36:	3ac50163          	beq	a0,a2,21d8 <_vscanf_core.constprop.0+0x84c>
    1e3a:	fce6                	sd	s9,120(sp)
    1e3c:	bd55                	j	1cf0 <_vscanf_core.constprop.0+0x364>
            int count = (width > 0) ? width : 1;
    1e3e:	4c05                	li	s8,1
    1e40:	b73d                	j	1d6e <_vscanf_core.constprop.0+0x3e2>
    1e42:	640e                	ld	s0,192(sp)
    1e44:	74ea                	ld	s1,184(sp)
    1e46:	794a                	ld	s2,176(sp)
    1e48:	79aa                	ld	s3,168(sp)
    1e4a:	7a0a                	ld	s4,160(sp)
    1e4c:	6aea                	ld	s5,152(sp)
    1e4e:	6baa                	ld	s7,136(sp)
    1e50:	6c0a                	ld	s8,128(sp)
    1e52:	7ce6                	ld	s9,120(sp)
    1e54:	7d46                	ld	s10,112(sp)
    1e56:	7da6                	ld	s11,104(sp)
    1e58:	b64d                	j	19fa <_vscanf_core.constprop.0+0x6e>
    1e5a:	640e                	ld	s0,192(sp)
    1e5c:	74ea                	ld	s1,184(sp)
    1e5e:	794a                	ld	s2,176(sp)
    1e60:	79aa                	ld	s3,168(sp)
    1e62:	7a0a                	ld	s4,160(sp)
    1e64:	6aea                	ld	s5,152(sp)
    1e66:	6baa                	ld	s7,136(sp)
    1e68:	6c0a                	ld	s8,128(sp)
    1e6a:	7d46                	ld	s10,112(sp)
    1e6c:	7da6                	ld	s11,104(sp)
    1e6e:	b671                	j	19fa <_vscanf_core.constprop.0+0x6e>
        ctx->ungotten = -1;
    1e70:	018dac23          	sw	s8,24(s11)
            while (c != -1 && !isspace(c))
    1e74:	b9e5                	j	1b6c <_vscanf_core.constprop.0+0x1e0>
        ctx->ungotten = -1;
    1e76:	57fd                	li	a5,-1
    1e78:	00fdac23          	sw	a5,24(s11)
            while (c != -1 && i < 63)
    1e7c:	bbd9                	j	1c52 <_vscanf_core.constprop.0+0x2c6>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
    1e7e:	f9f3069b          	addiw	a3,t1,-97
    1e82:	4795                	li	a5,5
    1e84:	06d7f263          	bgeu	a5,a3,1ee8 <_vscanf_core.constprop.0+0x55c>
    1e88:	fbf3031b          	addiw	t1,t1,-65
    1e8c:	4795                	li	a5,5
    1e8e:	0467fd63          	bgeu	a5,t1,1ee8 <_vscanf_core.constprop.0+0x55c>
                int x = (c == 'x' || c == 'X');
    1e92:	07800693          	li	a3,120
    1e96:	18d50763          	beq	a0,a3,2024 <_vscanf_core.constprop.0+0x698>
    1e9a:	fa850693          	addi	a3,a0,-88
    1e9e:	0016b693          	seqz	a3,a3
                if (base == 0 && i == 1 && num_buf[0] == '0' && x)
    1ea2:	4301                	li	t1,0
    1ea4:	32061663          	bnez	a2,21d0 <_vscanf_core.constprop.0+0x844>
    1ea8:	4785                	li	a5,1
    1eaa:	4601                	li	a2,0
    1eac:	d6fd1ce3          	bne	s10,a5,1c24 <_vscanf_core.constprop.0+0x298>
    1eb0:	02014e03          	lbu	t3,32(sp)
    1eb4:	03000793          	li	a5,48
    1eb8:	d6fe16e3          	bne	t3,a5,1c24 <_vscanf_core.constprop.0+0x298>
    1ebc:	d60684e3          	beqz	a3,1c24 <_vscanf_core.constprop.0+0x298>
                    base = 16;
    1ec0:	4641                	li	a2,16
                if (width > 0 && i >= width)
    1ec2:	d7a919e3          	bne	s2,s10,1c34 <_vscanf_core.constprop.0+0x2a8>
    1ec6:	bb59                	j	1c5c <_vscanf_core.constprop.0+0x2d0>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
    1ec8:	f9f3069b          	addiw	a3,t1,-97
    1ecc:	4795                	li	a5,5
    1ece:	02d7f263          	bgeu	a5,a3,1ef2 <_vscanf_core.constprop.0+0x566>
    1ed2:	fbf3031b          	addiw	t1,t1,-65
    1ed6:	0467f063          	bgeu	a5,t1,1f16 <_vscanf_core.constprop.0+0x58a>
                int x = (c == 'x' || c == 'X');
    1eda:	07800693          	li	a3,120
    1ede:	fad51ee3          	bne	a0,a3,1e9a <_vscanf_core.constprop.0+0x50e>
    1ee2:	4301                	li	t1,0
    1ee4:	4685                	li	a3,1
    1ee6:	b7c9                	j	1ea8 <_vscanf_core.constprop.0+0x51c>
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
    1ee8:	4305                	li	t1,1
                int x = (c == 'x' || c == 'X');
    1eea:	4681                	li	a3,0
                if (width > 0 && i >= width)
    1eec:	d3204ee3          	bgtz	s2,1c28 <_vscanf_core.constprop.0+0x29c>
    1ef0:	bb35                	j	1c2c <_vscanf_core.constprop.0+0x2a0>
                int x = (c == 'x' || c == 'X');
    1ef2:	4681                	li	a3,0
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
    1ef4:	4305                	li	t1,1
                if (width > 0 && i >= width)
    1ef6:	d32049e3          	bgtz	s2,1c28 <_vscanf_core.constprop.0+0x29c>
    1efa:	bb0d                	j	1c2c <_vscanf_core.constprop.0+0x2a0>
    1efc:	4301                	li	t1,0
                int x = (c == 'x' || c == 'X');
    1efe:	4685                	li	a3,1
                if (width > 0 && i >= width)
    1f00:	d32044e3          	bgtz	s2,1c28 <_vscanf_core.constprop.0+0x29c>
    1f04:	bb05                	j	1c34 <_vscanf_core.constprop.0+0x2a8>
            if (!suppress)
    1f06:	c8099be3          	bnez	s3,1b9c <_vscanf_core.constprop.0+0x210>
                buf[i] = '\0';
    1f0a:	67e2                	ld	a5,24(sp)
    1f0c:	00078023          	sb	zero,0(a5)
        ctx->ungotten = c;
    1f10:	00adac23          	sw	a0,24(s11)
            if (i > 0 && !suppress)
    1f14:	b171                	j	1ba0 <_vscanf_core.constprop.0+0x214>
                int x = (c == 'x' || c == 'X');
    1f16:	4681                	li	a3,0
                int hex = (base == 16 || base == 0) && ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F'));
    1f18:	4305                	li	t1,1
    1f1a:	b779                	j	1ea8 <_vscanf_core.constprop.0+0x51c>
            num_buf[i] = '\0';
    1f1c:	040d0713          	addi	a4,s10,64
    1f20:	1014                	addi	a3,sp,32
    1f22:	96ba                	add	a3,a3,a4
    1f24:	fc068023          	sb	zero,-64(a3)
        ctx->ungotten = c;
    1f28:	00fdac23          	sw	a5,24(s11)
            if (i == 0)
    1f2c:	f00d0be3          	beqz	s10,1e42 <_vscanf_core.constprop.0+0x4b6>
    1f30:	7ce6                	ld	s9,120(sp)
            if (!suppress)
    1f32:	d40992e3          	bnez	s3,1c76 <_vscanf_core.constprop.0+0x2ea>
    if (*str == '-')
    1f36:	02014603          	lbu	a2,32(sp)
    1f3a:	02d00793          	li	a5,45
    1f3e:	1af60963          	beq	a2,a5,20f0 <_vscanf_core.constprop.0+0x764>
    else if (*str == '+')
    1f42:	02b00793          	li	a5,43
    1f46:	20f60a63          	beq	a2,a5,215a <_vscanf_core.constprop.0+0x7ce>
    1f4a:	00005797          	auipc	a5,0x5
    1f4e:	9c67b587          	fld	fa1,-1594(a5) # 6910 <STDIN_FD+0x10>
    1f52:	101c                	addi	a5,sp,32
    while (*str >= '0' && *str <= '9')
    1f54:	fd06069b          	addiw	a3,a2,-48
    1f58:	0ff6f513          	zext.b	a0,a3
    1f5c:	45a5                	li	a1,9
    1f5e:	f20007d3          	fmv.d.x	fa5,zero
    1f62:	02a5e463          	bltu	a1,a0,1f8a <_vscanf_core.constprop.0+0x5fe>
    1f66:	00005717          	auipc	a4,0x5
    1f6a:	9b273707          	fld	fa4,-1614(a4) # 6918 <STDIN_FD+0x18>
    1f6e:	4525                	li	a0,9
    1f70:	0017c603          	lbu	a2,1(a5)
        val = val * 10.0 + (*str - '0');
    1f74:	d20686d3          	fcvt.d.w	fa3,a3
        str++;
    1f78:	0785                	addi	a5,a5,1
    while (*str >= '0' && *str <= '9')
    1f7a:	fd06069b          	addiw	a3,a2,-48
    1f7e:	0ff6f593          	zext.b	a1,a3
        val = val * 10.0 + (*str - '0');
    1f82:	6ae7f7c3          	fmadd.d	fa5,fa5,fa4,fa3
    while (*str >= '0' && *str <= '9')
    1f86:	feb575e3          	bgeu	a0,a1,1f70 <_vscanf_core.constprop.0+0x5e4>
    if (*str == '.')
    1f8a:	02e00693          	li	a3,46
    1f8e:	16d60a63          	beq	a2,a3,2102 <_vscanf_core.constprop.0+0x776>
    if (*str == 'e' || *str == 'E')
    1f92:	0007c683          	lbu	a3,0(a5)
    1f96:	0df6f693          	andi	a3,a3,223
    1f9a:	04500613          	li	a2,69
    1f9e:	0cc68463          	beq	a3,a2,2066 <_vscanf_core.constprop.0+0x6da>
                    *va_arg(ap, double *) = val;
    1fa2:	6722                	ld	a4,8(sp)
                if (len_mod == 1)
    1fa4:	4685                	li	a3,1
    return sign * val;
    1fa6:	12b7f7d3          	fmul.d	fa5,fa5,fa1
                    *va_arg(ap, double *) = val;
    1faa:	631c                	ld	a5,0(a4)
                    *va_arg(ap, int64 *) = val;
    1fac:	0721                	addi	a4,a4,8
    1fae:	e43a                	sd	a4,8(sp)
                if (len_mod == 1)
    1fb0:	6762                	ld	a4,24(sp)
    1fb2:	18d70b63          	beq	a4,a3,2148 <_vscanf_core.constprop.0+0x7bc>
                    *va_arg(ap, float *) = (float)val;
    1fb6:	4017f7d3          	fcvt.s.d	fa5,fa5
                assigned++;
    1fba:	2b05                	addiw	s6,s6,1
                    *va_arg(ap, float *) = (float)val;
    1fbc:	00f7a027          	fsw	fa5,0(a5)
    1fc0:	b95d                	j	1c76 <_vscanf_core.constprop.0+0x2ea>
                num_buf[i++] = (char)c;
    1fc2:	02a10023          	sb	a0,32(sp)
    if (ctx->ungotten >= 0)
    1fc6:	018da503          	lw	a0,24(s11)
    1fca:	06055463          	bgez	a0,2032 <_vscanf_core.constprop.0+0x6a6>
    1fce:	856e                	mv	a0,s11
    1fd0:	903ff0ef          	jal	18d2 <_in_char.part.0>
                num_buf[i++] = (char)c;
    1fd4:	4d05                	li	s10,1
    1fd6:	b101                	j	1bd6 <_vscanf_core.constprop.0+0x24a>
                int64 val = strtoll(num_buf, NULL, base);
    1fd8:	4581                	li	a1,0
    1fda:	1008                	addi	a0,sp,32
    1fdc:	696030ef          	jal	5672 <strtoll>
                    *va_arg(ap, int64 *) = val;
    1fe0:	67a2                	ld	a5,8(sp)
                if (len_mod == 2)
    1fe2:	6762                	ld	a4,24(sp)
    1fe4:	4689                	li	a3,2
                    *va_arg(ap, int64 *) = val;
    1fe6:	07a1                	addi	a5,a5,8
                if (len_mod == 2)
    1fe8:	16d70363          	beq	a4,a3,214e <_vscanf_core.constprop.0+0x7c2>
                    *va_arg(ap, int64 *) = val;
    1fec:	6722                	ld	a4,8(sp)
                else if (len_mod == 1)
    1fee:	4605                	li	a2,1
                    *va_arg(ap, int64 *) = val;
    1ff0:	6314                	ld	a3,0(a4)
                else if (len_mod == 1)
    1ff2:	6762                	ld	a4,24(sp)
    1ff4:	16c70163          	beq	a4,a2,2156 <_vscanf_core.constprop.0+0x7ca>
                    *va_arg(ap, int *) = (int)val;
    1ff8:	c288                	sw	a0,0(a3)
                assigned++;
    1ffa:	2b05                	addiw	s6,s6,1
    1ffc:	e43e                	sd	a5,8(sp)
    1ffe:	b9a5                	j	1c76 <_vscanf_core.constprop.0+0x2ea>
            num_buf[i] = '\0';
    2000:	040d0793          	addi	a5,s10,64
    2004:	1018                	addi	a4,sp,32
    2006:	00e785b3          	add	a1,a5,a4
    200a:	fc058023          	sb	zero,-64(a1)
            if (i == 0)
    200e:	7ce6                	ld	s9,120(sp)
    2010:	b70d                	j	1f32 <_vscanf_core.constprop.0+0x5a6>
            num_buf[i] = '\0';
    2012:	040d0793          	addi	a5,s10,64
    2016:	1018                	addi	a4,sp,32
    2018:	00e78833          	add	a6,a5,a4
    201c:	fc080023          	sb	zero,-64(a6)
            if (i == 0)
    2020:	7ce6                	ld	s9,120(sp)
    2022:	b981                	j	1c72 <_vscanf_core.constprop.0+0x2e6>
                int x = (c == 'x' || c == 'X');
    2024:	4301                	li	t1,0
    2026:	4685                	li	a3,1
                if (width > 0 && i >= width)
    2028:	c12040e3          	bgtz	s2,1c28 <_vscanf_core.constprop.0+0x29c>
    202c:	b101                	j	1c2c <_vscanf_core.constprop.0+0x2a0>
    int assigned = 0;
    202e:	4b01                	li	s6,0
    2030:	b2e9                	j	19fa <_vscanf_core.constprop.0+0x6e>
        ctx->ungotten = -1;
    2032:	56fd                	li	a3,-1
    2034:	fce6                	sd	s9,120(sp)
    2036:	00ddac23          	sw	a3,24(s11)
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
    203a:	07800693          	li	a3,120
    203e:	4641                	li	a2,16
                num_buf[i++] = (char)c;
    2040:	4d05                	li	s10,1
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
    2042:	badc09e3          	beq	s8,a3,1bf4 <_vscanf_core.constprop.0+0x268>
    2046:	06900693          	li	a3,105
    204a:	4629                	li	a2,10
                num_buf[i++] = (char)c;
    204c:	4d05                	li	s10,1
            int base = (spec == 'x') ? 16 : (spec == 'i' ? 0 : 10);
    204e:	badc13e3          	bne	s8,a3,1bf4 <_vscanf_core.constprop.0+0x268>
    2052:	4601                	li	a2,0
    2054:	b645                	j	1bf4 <_vscanf_core.constprop.0+0x268>
        ctx->ungotten = -1;
    2056:	56fd                	li	a3,-1
    2058:	fce6                	sd	s9,120(sp)
    205a:	00ddac23          	sw	a3,24(s11)
                num_buf[i++] = (char)c;
    205e:	4d05                	li	s10,1
    2060:	fd57869b          	addiw	a3,a5,-43
    2064:	b171                	j	1cf0 <_vscanf_core.constprop.0+0x364>
        if (*str == '-')
    2066:	0017c583          	lbu	a1,1(a5)
    206a:	02d00693          	li	a3,45
    206e:	0ed58f63          	beq	a1,a3,216c <_vscanf_core.constprop.0+0x7e0>
        else if (*str == '+')
    2072:	02b00693          	li	a3,43
    2076:	10d58e63          	beq	a1,a3,2192 <_vscanf_core.constprop.0+0x806>
        while (*str >= '0' && *str <= '9')
    207a:	fd05861b          	addiw	a2,a1,-48
    207e:	0ff67513          	zext.b	a0,a2
    2082:	45a5                	li	a1,9
        str++;
    2084:	00178693          	addi	a3,a5,1
        int esign = 1;
    2088:	4805                	li	a6,1
        while (*str >= '0' && *str <= '9')
    208a:	04a5ec63          	bltu	a1,a0,20e2 <_vscanf_core.constprop.0+0x756>
    208e:	4525                	li	a0,9
    2090:	0016c583          	lbu	a1,1(a3)
            eval = eval * 10 + (*str - '0');
    2094:	0029979b          	slliw	a5,s3,0x2
    2098:	013787bb          	addw	a5,a5,s3
    209c:	0017979b          	slliw	a5,a5,0x1
    20a0:	00f609bb          	addw	s3,a2,a5
        while (*str >= '0' && *str <= '9')
    20a4:	fd05861b          	addiw	a2,a1,-48
    20a8:	0ff67593          	zext.b	a1,a2
            str++;
    20ac:	0685                	addi	a3,a3,1
        while (*str >= '0' && *str <= '9')
    20ae:	feb571e3          	bgeu	a0,a1,2090 <_vscanf_core.constprop.0+0x704>
        while (eval--)
    20b2:	fff9879b          	addiw	a5,s3,-1
    20b6:	12098463          	beqz	s3,21de <_vscanf_core.constprop.0+0x852>
        double p = 1.0;
    20ba:	00005717          	auipc	a4,0x5
    20be:	85673687          	fld	fa3,-1962(a4) # 6910 <STDIN_FD+0x10>
    20c2:	00005717          	auipc	a4,0x5
    20c6:	85673707          	fld	fa4,-1962(a4) # 6918 <STDIN_FD+0x18>
        while (eval--)
    20ca:	56fd                	li	a3,-1
    20cc:	37fd                	addiw	a5,a5,-1
            p *= 10.0;
    20ce:	12e6f6d3          	fmul.d	fa3,fa3,fa4
        while (eval--)
    20d2:	fed79de3          	bne	a5,a3,20cc <_vscanf_core.constprop.0+0x740>
        if (esign == 1)
    20d6:	4785                	li	a5,1
    20d8:	00f80963          	beq	a6,a5,20ea <_vscanf_core.constprop.0+0x75e>
            val /= p;
    20dc:	1ad7f7d3          	fdiv.d	fa5,fa5,fa3
    20e0:	b5c9                	j	1fa2 <_vscanf_core.constprop.0+0x616>
        double p = 1.0;
    20e2:	00005797          	auipc	a5,0x5
    20e6:	82e7b687          	fld	fa3,-2002(a5) # 6910 <STDIN_FD+0x10>
            val *= p;
    20ea:	12d7f7d3          	fmul.d	fa5,fa5,fa3
    20ee:	bd55                	j	1fa2 <_vscanf_core.constprop.0+0x616>
    while (*str >= '0' && *str <= '9')
    20f0:	00005797          	auipc	a5,0x5
    20f4:	8187b587          	fld	fa1,-2024(a5) # 6908 <STDIN_FD+0x8>
    20f8:	02114603          	lbu	a2,33(sp)
        str++;
    20fc:	02110793          	addi	a5,sp,33
    2100:	bd91                	j	1f54 <_vscanf_core.constprop.0+0x5c8>
        while (*str >= '0' && *str <= '9')
    2102:	0017c683          	lbu	a3,1(a5)
    2106:	45a5                	li	a1,9
        str++;
    2108:	0785                	addi	a5,a5,1
        while (*str >= '0' && *str <= '9')
    210a:	fd06861b          	addiw	a2,a3,-48
    210e:	0ff67513          	zext.b	a0,a2
    2112:	e8a5e2e3          	bltu	a1,a0,1f96 <_vscanf_core.constprop.0+0x60a>
        double div = 10.0;
    2116:	00005717          	auipc	a4,0x5
    211a:	80273707          	fld	fa4,-2046(a4) # 6918 <STDIN_FD+0x18>
    211e:	22e70653          	fmv.d	fa2,fa4
        while (*str >= '0' && *str <= '9')
    2122:	4525                	li	a0,9
            val += (*str - '0') / div;
    2124:	d20606d3          	fcvt.d.w	fa3,a2
        while (*str >= '0' && *str <= '9')
    2128:	0017c683          	lbu	a3,1(a5)
            str++;
    212c:	0785                	addi	a5,a5,1
            val += (*str - '0') / div;
    212e:	1ac6f6d3          	fdiv.d	fa3,fa3,fa2
        while (*str >= '0' && *str <= '9')
    2132:	fd06861b          	addiw	a2,a3,-48
    2136:	0ff67593          	zext.b	a1,a2
            div *= 10.0;
    213a:	12e67653          	fmul.d	fa2,fa2,fa4
            val += (*str - '0') / div;
    213e:	02d7f7d3          	fadd.d	fa5,fa5,fa3
        while (*str >= '0' && *str <= '9')
    2142:	feb571e3          	bgeu	a0,a1,2124 <_vscanf_core.constprop.0+0x798>
    2146:	bd81                	j	1f96 <_vscanf_core.constprop.0+0x60a>
                    *va_arg(ap, double *) = val;
    2148:	a39c                	fsd	fa5,0(a5)
                assigned++;
    214a:	2b05                	addiw	s6,s6,1
    214c:	b62d                	j	1c76 <_vscanf_core.constprop.0+0x2ea>
                    *va_arg(ap, int64 *) = val;
    214e:	6722                	ld	a4,8(sp)
    2150:	6314                	ld	a3,0(a4)
    2152:	e288                	sd	a0,0(a3)
    2154:	b55d                	j	1ffa <_vscanf_core.constprop.0+0x66e>
                    *va_arg(ap, long *) = (long)val;
    2156:	e288                	sd	a0,0(a3)
    2158:	b54d                	j	1ffa <_vscanf_core.constprop.0+0x66e>
    while (*str >= '0' && *str <= '9')
    215a:	00004797          	auipc	a5,0x4
    215e:	7b67b587          	fld	fa1,1974(a5) # 6910 <STDIN_FD+0x10>
    2162:	02114603          	lbu	a2,33(sp)
        str++;
    2166:	02110793          	addi	a5,sp,33
    216a:	b3ed                	j	1f54 <_vscanf_core.constprop.0+0x5c8>
        while (*str >= '0' && *str <= '9')
    216c:	0027c583          	lbu	a1,2(a5)
            str++;
    2170:	00278693          	addi	a3,a5,2
        while (*str >= '0' && *str <= '9')
    2174:	4525                	li	a0,9
    2176:	fd05861b          	addiw	a2,a1,-48
    217a:	0ff67793          	zext.b	a5,a2
            esign = -1;
    217e:	587d                	li	a6,-1
        while (*str >= '0' && *str <= '9')
    2180:	f0f577e3          	bgeu	a0,a5,208e <_vscanf_core.constprop.0+0x702>
        double p = 1.0;
    2184:	00004797          	auipc	a5,0x4
    2188:	78c7b687          	fld	fa3,1932(a5) # 6910 <STDIN_FD+0x10>
            val /= p;
    218c:	1ad7f7d3          	fdiv.d	fa5,fa5,fa3
    2190:	bd09                	j	1fa2 <_vscanf_core.constprop.0+0x616>
        while (*str >= '0' && *str <= '9')
    2192:	0027c583          	lbu	a1,2(a5)
            str++;
    2196:	00278693          	addi	a3,a5,2
        while (*str >= '0' && *str <= '9')
    219a:	4525                	li	a0,9
    219c:	fd05861b          	addiw	a2,a1,-48
    21a0:	0ff67793          	zext.b	a5,a2
    21a4:	f2f56fe3          	bltu	a0,a5,20e2 <_vscanf_core.constprop.0+0x756>
        int esign = 1;
    21a8:	4805                	li	a6,1
    21aa:	b5d5                	j	208e <_vscanf_core.constprop.0+0x702>
    while (*p)
    21ac:	001bc783          	lbu	a5,1(s7)
    21b0:	bed5                	j	1da4 <_vscanf_core.constprop.0+0x418>
            if (!suppress)
    21b2:	9e0997e3          	bnez	s3,1ba0 <_vscanf_core.constprop.0+0x214>
                buf[i] = '\0';
    21b6:	67e2                	ld	a5,24(sp)
    21b8:	00078023          	sb	zero,0(a5)
    21bc:	b2d5                	j	1ba0 <_vscanf_core.constprop.0+0x214>
            num_buf[i] = '\0';
    21be:	040d0793          	addi	a5,s10,64
    21c2:	1018                	addi	a4,sp,32
    21c4:	97ba                	add	a5,a5,a4
    21c6:	fc078023          	sb	zero,-64(a5)
            if (i == 0)
    21ca:	aa0d14e3          	bnez	s10,1c72 <_vscanf_core.constprop.0+0x2e6>
    21ce:	b171                	j	1e5a <_vscanf_core.constprop.0+0x4ce>
    21d0:	4641                	li	a2,16
                if (width > 0 && i >= width)
    21d2:	a5204be3          	bgtz	s2,1c28 <_vscanf_core.constprop.0+0x29c>
    21d6:	bc99                	j	1c2c <_vscanf_core.constprop.0+0x2a0>
            num_buf[i] = '\0';
    21d8:	020100a3          	sb	zero,33(sp)
            if (i == 0)
    21dc:	bb99                	j	1f32 <_vscanf_core.constprop.0+0x5a6>
        double p = 1.0;
    21de:	00004797          	auipc	a5,0x4
    21e2:	7327b687          	fld	fa3,1842(a5) # 6910 <STDIN_FD+0x10>
    21e6:	bdc5                	j	20d6 <_vscanf_core.constprop.0+0x74a>
                buf[i] = '\0';
    21e8:	67e2                	ld	a5,24(sp)
    21ea:	01a786b3          	add	a3,a5,s10
    21ee:	00068023          	sb	zero,0(a3)
        ctx->ungotten = c;
    21f2:	00adac23          	sw	a0,24(s11)
    while (*p)
    21f6:	001bc783          	lbu	a5,1(s7)
    21fa:	b6f5                	j	1de6 <_vscanf_core.constprop.0+0x45a>

00000000000021fc <_out_char>:
{
    21fc:	7179                	addi	sp,sp,-48
    21fe:	ec26                	sd	s1,24(sp)
    if (ctx->stream)
    2200:	6d04                	ld	s1,24(a0)
{
    2202:	f022                	sd	s0,32(sp)
    2204:	f406                	sd	ra,40(sp)
    2206:	842a                	mv	s0,a0
    2208:	872e                	mv	a4,a1
    if (ctx->stream)
    220a:	c0a1                	beqz	s1,224a <_out_char+0x4e>
    220c:	e84a                	sd	s2,16(sp)
    if (stream->buf_mode == 2)
    220e:	41c4a903          	lw	s2,1052(s1)
    2212:	4789                	li	a5,2
    2214:	04f90d63          	beq	s2,a5,226e <_out_char+0x72>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    2218:	4104a783          	lw	a5,1040(s1)
    if (stream->buf_write_pos >= BUFSIZ)
    221c:	3ff00693          	li	a3,1023
    stream->buffer[stream->buf_write_pos++] = (char)c;
    2220:	0017861b          	addiw	a2,a5,1
    2224:	40c4a823          	sw	a2,1040(s1)
    2228:	97a6                	add	a5,a5,s1
    222a:	00b78823          	sb	a1,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    222e:	08c6c063          	blt	a3,a2,22ae <_out_char+0xb2>
    else if (stream->buf_mode == 1 && c == '\n')
    2232:	4785                	li	a5,1
    2234:	04f90a63          	beq	s2,a5,2288 <_out_char+0x8c>
        ctx->written++;
    2238:	681c                	ld	a5,16(s0)
    223a:	6942                	ld	s2,16(sp)
}
    223c:	70a2                	ld	ra,40(sp)
        ctx->written++;
    223e:	0785                	addi	a5,a5,1
    2240:	e81c                	sd	a5,16(s0)
}
    2242:	7402                	ld	s0,32(sp)
    2244:	64e2                	ld	s1,24(sp)
    2246:	6145                	addi	sp,sp,48
    2248:	8082                	ret
        if (ctx->limit > 0 && ctx->written < ctx->limit - 1)
    224a:	6514                	ld	a3,8(a0)
    224c:	691c                	ld	a5,16(a0)
    224e:	ca89                	beqz	a3,2260 <_out_char+0x64>
    2250:	16fd                	addi	a3,a3,-1
    2252:	00d7f763          	bgeu	a5,a3,2260 <_out_char+0x64>
            ctx->buf[ctx->written] = c;
    2256:	6114                	ld	a3,0(a0)
    2258:	97b6                	add	a5,a5,a3
    225a:	00b78023          	sb	a1,0(a5)
        ctx->written++;
    225e:	691c                	ld	a5,16(a0)
    2260:	0785                	addi	a5,a5,1
}
    2262:	70a2                	ld	ra,40(sp)
        ctx->written++;
    2264:	e81c                	sd	a5,16(s0)
}
    2266:	7402                	ld	s0,32(sp)
    2268:	64e2                	ld	s1,24(sp)
    226a:	6145                	addi	sp,sp,48
    226c:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    226e:	4088                	lw	a0,0(s1)
    2270:	4605                	li	a2,1
    2272:	00f10593          	addi	a1,sp,15
        char ch = (char)c;
    2276:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    227a:	e93fe0ef          	jal	110c <write>
    227e:	4785                	li	a5,1
    2280:	faf50ce3          	beq	a0,a5,2238 <_out_char+0x3c>
            stream->error = 1;
    2284:	c49c                	sw	a5,8(s1)
            return EOF;
    2286:	bf4d                	j	2238 <_out_char+0x3c>
    else if (stream->buf_mode == 1 && c == '\n')
    2288:	47a9                	li	a5,10
    228a:	faf597e3          	bne	a1,a5,2238 <_out_char+0x3c>
    if (stream->buf_write_pos > 0)
    228e:	fac055e3          	blez	a2,2238 <_out_char+0x3c>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    2292:	4088                	lw	a0,0(s1)
    2294:	01048593          	addi	a1,s1,16
    2298:	e75fe0ef          	jal	110c <write>
        if (ret < stream->buf_write_pos)
    229c:	4104a783          	lw	a5,1040(s1)
    22a0:	02f55063          	bge	a0,a5,22c0 <_out_char+0xc4>
            stream->error = 1;
    22a4:	0124a423          	sw	s2,8(s1)
            stream->buf_write_pos = 0;
    22a8:	4004a823          	sw	zero,1040(s1)
            return EOF;
    22ac:	b771                	j	2238 <_out_char+0x3c>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    22ae:	4088                	lw	a0,0(s1)
    22b0:	01048593          	addi	a1,s1,16
    22b4:	e59fe0ef          	jal	110c <write>
        if (ret < stream->buf_write_pos)
    22b8:	4104a783          	lw	a5,1040(s1)
    22bc:	00f54563          	blt	a0,a5,22c6 <_out_char+0xca>
        stream->buf_write_pos = 0;
    22c0:	4004a823          	sw	zero,1040(s1)
    22c4:	bf95                	j	2238 <_out_char+0x3c>
            stream->error = 1;
    22c6:	4785                	li	a5,1
    22c8:	c49c                	sw	a5,8(s1)
            stream->buf_write_pos = 0;
    22ca:	4004a823          	sw	zero,1040(s1)
            return EOF;
    22ce:	b7ad                	j	2238 <_out_char+0x3c>

00000000000022d0 <stbsp_set_separators>:
   "75767778798081828384858687888990919293949596979899"
};

STBSP__PUBLICDEF void STB_SPRINTF_DECORATE(set_separators)(char pcomma, char pperiod)
{
   stbsp__period = pperiod;
    22d0:	00006797          	auipc	a5,0x6
    22d4:	c1878793          	addi	a5,a5,-1000 # 7ee8 <stbsp__digitpair>
    22d8:	0cb78623          	sb	a1,204(a5)
   stbsp__comma = pcomma;
    22dc:	0ca786a3          	sb	a0,205(a5)
}
    22e0:	8082                	ret

00000000000022e2 <stbsp_vsprintfcb>:

   return (stbsp__uint32)(sn - s);
}

STBSP__PUBLICDEF int STB_SPRINTF_DECORATE(vsprintfcb)(STBSP_SPRINTFCB *callback, void *user, char *buf, char const *fmt, va_list va)
{
    22e2:	d1010113          	addi	sp,sp,-752
            // Check if the next 4 bytes contain %(0x25) or end of string.
            // Using the 'hasless' trick:
            // https://graphics.stanford.edu/~seander/bithacks.html#HasLessInWord
            stbsp__uint32 v, c;
            v = *(stbsp__uint32 *)f;
            c = (~v) & 0x80808080;
    22e6:	808087b7          	lui	a5,0x80808
            if (((v ^ 0x25252525) - 0x01010101) & c)
    22ea:	252523b7          	lui	t2,0x25252
    22ee:	52538393          	addi	t2,t2,1317 # 25252525 <_ZSt4cerr+0x252496e5>
{
    22f2:	29913c23          	sd	s9,664(sp)
    22f6:	29b13423          	sd	s11,648(sp)
   int tlen = 0;
    22fa:	4c81                	li	s9,0
            if (((v ^ 0x25252525) - 0x01010101) & c)
    22fc:	feff0db7          	lui	s11,0xfeff0
            c = (~v) & 0x80808080;
    2300:	08078793          	addi	a5,a5,128 # ffffffff80808080 <_ZSt4cerr+0xffffffff807ff240>
{
    2304:	2e813023          	sd	s0,736(sp)
    2308:	2c913c23          	sd	s1,728(sp)
    230c:	2d213823          	sd	s2,720(sp)
    2310:	2d313423          	sd	s3,712(sp)
    2314:	2b713423          	sd	s7,680(sp)
    2318:	2b813023          	sd	s8,672(sp)
    231c:	29a13823          	sd	s10,656(sp)
    2320:	2e113423          	sd	ra,744(sp)
    2324:	8d66                	mv	s10,s9
    2326:	8432                	mv	s0,a2
    2328:	8c9e                	mv	s9,t2
    232a:	89aa                	mv	s3,a0
    232c:	e42e                	sd	a1,8(sp)
    232e:	84b6                	mv	s1,a3
    2330:	8bba                	mv	s7,a4
    2332:	fc02                	sd	zero,56(sp)
   for (;;) {
    2334:	8932                	mv	s2,a2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    2336:	effd8d9b          	addiw	s11,s11,-257 # fffffffffefefeff <_ZSt4cerr+0xfffffffffefe70bf>
               goto schk1;
            if ((v - 0x01010101) & c)
               goto schk2;
            if (callback)
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    233a:	20000c13          	li	s8,512
    233e:	83be                	mv	t2,a5
         while (((stbsp__uintptr)f) & 3) {
    2340:	0034f793          	andi	a5,s1,3
    2344:	c7a9                	beqz	a5,238e <stbsp_vsprintfcb+0xac>
            if (f[0] == '%')
    2346:	0004c783          	lbu	a5,0(s1)
    234a:	02500713          	li	a4,37
    234e:	0ee78263          	beq	a5,a4,2432 <stbsp_vsprintfcb+0x150>
            if (f[0] == 0)
    2352:	cbd9                	beqz	a5,23e8 <stbsp_vsprintfcb+0x106>
            stbsp__chk_cb_buf(1);
    2354:	02098663          	beqz	s3,2380 <stbsp_vsprintfcb+0x9e>
    2358:	4124063b          	subw	a2,s0,s2
    235c:	1fe00713          	li	a4,510
    2360:	02c75063          	bge	a4,a2,2380 <stbsp_vsprintfcb+0x9e>
    2364:	65a2                	ld	a1,8(sp)
    2366:	854a                	mv	a0,s2
    2368:	e81e                	sd	t2,16(sp)
    236a:	00cd0d3b          	addw	s10,s10,a2
    236e:	9982                	jalr	s3
    2370:	892a                	mv	s2,a0
    2372:	e119                	bnez	a0,2378 <stbsp_vsprintfcb+0x96>
    2374:	0200106f          	j	3394 <stbsp_vsprintfcb+0x10b2>
            *bf++ = f[0];
    2378:	0004c783          	lbu	a5,0(s1)
            stbsp__chk_cb_buf(1);
    237c:	63c2                	ld	t2,16(sp)
    237e:	842a                	mv	s0,a0
            ++f;
    2380:	0485                	addi	s1,s1,1
            *bf++ = f[0];
    2382:	00f40023          	sb	a5,0(s0)
         while (((stbsp__uintptr)f) & 3) {
    2386:	0034f793          	andi	a5,s1,3
            *bf++ = f[0];
    238a:	0405                	addi	s0,s0,1
         while (((stbsp__uintptr)f) & 3) {
    238c:	ffcd                	bnez	a5,2346 <stbsp_vsprintfcb+0x64>
            v = *(stbsp__uint32 *)f;
    238e:	4094                	lw	a3,0(s1)
            c = (~v) & 0x80808080;
    2390:	fff6c793          	not	a5,a3
            if (((v ^ 0x25252525) - 0x01010101) & c)
    2394:	0196c733          	xor	a4,a3,s9
            c = (~v) & 0x80808080;
    2398:	0077f7b3          	and	a5,a5,t2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    239c:	01b7073b          	addw	a4,a4,s11
    23a0:	8f7d                	and	a4,a4,a5
    23a2:	2701                	sext.w	a4,a4
    23a4:	f34d                	bnez	a4,2346 <stbsp_vsprintfcb+0x64>
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    23a6:	460d                	li	a2,3
    23a8:	a805                	j	23d8 <stbsp_vsprintfcb+0xf6>
            if (callback)
    23aa:	00098863          	beqz	s3,23ba <stbsp_vsprintfcb+0xd8>
               if ((STB_SPRINTF_MIN - (int)(bf - buf)) < 4)
    23ae:	412407b3          	sub	a5,s0,s2
    23b2:	40fc07bb          	subw	a5,s8,a5
    23b6:	f8f658e3          	bge	a2,a5,2346 <stbsp_vsprintfcb+0x64>
                    bf[2] = f[2];
                    bf[3] = f[3];
                } else
            #endif
            {
                *(stbsp__uint32 *)bf = v;
    23ba:	c014                	sw	a3,0(s0)
            v = *(stbsp__uint32 *)f;
    23bc:	40d4                	lw	a3,4(s1)
            }
            bf += 4;
    23be:	0411                	addi	s0,s0,4
            f += 4;
    23c0:	0491                	addi	s1,s1,4
            c = (~v) & 0x80808080;
    23c2:	fff6c793          	not	a5,a3
            if (((v ^ 0x25252525) - 0x01010101) & c)
    23c6:	0196c733          	xor	a4,a3,s9
            c = (~v) & 0x80808080;
    23ca:	0077f7b3          	and	a5,a5,t2
            if (((v ^ 0x25252525) - 0x01010101) & c)
    23ce:	01b7073b          	addw	a4,a4,s11
    23d2:	8f7d                	and	a4,a4,a5
    23d4:	2701                	sext.w	a4,a4
    23d6:	fb25                	bnez	a4,2346 <stbsp_vsprintfcb+0x64>
            if ((v - 0x01010101) & c)
    23d8:	01b6873b          	addw	a4,a3,s11
    23dc:	8ff9                	and	a5,a5,a4
    23de:	2781                	sext.w	a5,a5
    23e0:	d7e9                	beqz	a5,23aa <stbsp_vsprintfcb+0xc8>
            if (f[0] == 0)
    23e2:	0004c783          	lbu	a5,0(s1)
    23e6:	f7bd                	bnez	a5,2354 <stbsp_vsprintfcb+0x72>
endfmt:

   if (!callback)
      *bf = 0;
   else
      stbsp__flush_cb();
    23e8:	8cea                	mv	s9,s10
    23ea:	412404bb          	subw	s1,s0,s2
   if (!callback)
    23ee:	70098563          	beqz	s3,2af8 <stbsp_vsprintfcb+0x816>
      stbsp__flush_cb();
    23f2:	00905663          	blez	s1,23fe <stbsp_vsprintfcb+0x11c>
    23f6:	65a2                	ld	a1,8(sp)
    23f8:	8626                	mv	a2,s1
    23fa:	854a                	mv	a0,s2
    23fc:	9982                	jalr	s3
    23fe:	009c8cbb          	addw	s9,s9,s1

done:
   return tlen + (int)(bf - buf);
}
    2402:	2e813083          	ld	ra,744(sp)
    2406:	2e013403          	ld	s0,736(sp)
    240a:	2d813483          	ld	s1,728(sp)
    240e:	2d013903          	ld	s2,720(sp)
    2412:	2c813983          	ld	s3,712(sp)
    2416:	2a813b83          	ld	s7,680(sp)
    241a:	2a013c03          	ld	s8,672(sp)
    241e:	29013d03          	ld	s10,656(sp)
    2422:	28813d83          	ld	s11,648(sp)
    2426:	8566                	mv	a0,s9
    2428:	29813c83          	ld	s9,664(sp)
    242c:	2f010113          	addi	sp,sp,752
    2430:	8082                	ret
    2432:	2d413023          	sd	s4,704(sp)
    2436:	2b513c23          	sd	s5,696(sp)
    243a:	2b613823          	sd	s6,688(sp)
      tz = 0;
    243e:	00248693          	addi	a3,s1,2
      fl = 0;
    2442:	4e01                	li	t3,0
         switch (f[0]) {
    2444:	03f00593          	li	a1,63
    2448:	00004617          	auipc	a2,0x4
    244c:	de860613          	addi	a2,a2,-536 # 6230 <_GLOBAL__sub_I__ZSt3cin+0x22c>
    2450:	fff6c783          	lbu	a5,-1(a3)
    2454:	fff68493          	addi	s1,a3,-1
    2458:	fe07871b          	addiw	a4,a5,-32
    245c:	0ff77713          	zext.b	a4,a4
    2460:	00e5ec63          	bltu	a1,a4,2478 <stbsp_vsprintfcb+0x196>
    2464:	070a                	slli	a4,a4,0x2
    2466:	9732                	add	a4,a4,a2
    2468:	4318                	lw	a4,0(a4)
    246a:	9732                	add	a4,a4,a2
    246c:	8702                	jr	a4
      if (f[0] == '*') {
    246e:	0014c783          	lbu	a5,1(s1)
            fl |= STBSP__LEADINGZERO;
    2472:	010e6e13          	ori	t3,t3,16
            ++f;
    2476:	0485                	addi	s1,s1,1
      if (f[0] == '*') {
    2478:	02a00713          	li	a4,42
    247c:	0ce79163          	bne	a5,a4,253e <stbsp_vsprintfcb+0x25c>
         fw = va_arg(va, stbsp__uint32);
    2480:	000bab03          	lw	s6,0(s7)
         while ((f[0] >= '0') && (f[0] <= '9')) {
    2484:	0014c783          	lbu	a5,1(s1)
         fw = va_arg(va, stbsp__uint32);
    2488:	0ba1                	addi	s7,s7,8
         ++f;
    248a:	0485                	addi	s1,s1,1
      if (f[0] == '.') {
    248c:	02e00713          	li	a4,46
      pr = -1;
    2490:	58fd                	li	a7,-1
      if (f[0] == '.') {
    2492:	0ee78663          	beq	a5,a4,257e <stbsp_vsprintfcb+0x29c>
      switch (f[0]) {
    2496:	04900713          	li	a4,73
    249a:	10e78263          	beq	a5,a4,259e <stbsp_vsprintfcb+0x2bc>
    249e:	f987871b          	addiw	a4,a5,-104
    24a2:	0ff77713          	zext.b	a4,a4
    24a6:	46c9                	li	a3,18
    24a8:	02e6e063          	bltu	a3,a4,24c8 <stbsp_vsprintfcb+0x1e6>
    24ac:	00004697          	auipc	a3,0x4
    24b0:	e8468693          	addi	a3,a3,-380 # 6330 <_GLOBAL__sub_I__ZSt3cin+0x32c>
    24b4:	070a                	slli	a4,a4,0x2
    24b6:	9736                	add	a4,a4,a3
    24b8:	4318                	lw	a4,0(a4)
    24ba:	9736                	add	a4,a4,a3
    24bc:	8702                	jr	a4
         if (f[0] == 'h')
    24be:	0014c783          	lbu	a5,1(s1)
         fl |= (sizeof(ptrdiff_t) == 8) ? STBSP__INTMAX : 0;
    24c2:	020e6e13          	ori	t3,t3,32
         ++f;
    24c6:	0485                	addi	s1,s1,1
      switch (f[0]) {
    24c8:	fbf7871b          	addiw	a4,a5,-65
    24cc:	0ff77713          	zext.b	a4,a4
    24d0:	03700693          	li	a3,55
    24d4:	0ee6ea63          	bltu	a3,a4,25c8 <stbsp_vsprintfcb+0x2e6>
    24d8:	00004697          	auipc	a3,0x4
    24dc:	ea468693          	addi	a3,a3,-348 # 637c <_GLOBAL__sub_I__ZSt3cin+0x378>
    24e0:	070a                	slli	a4,a4,0x2
    24e2:	9736                	add	a4,a4,a3
    24e4:	4318                	lw	a4,0(a4)
    24e6:	9736                	add	a4,a4,a3
    24e8:	8702                	jr	a4
            fl |= STBSP__METRIC_NOSPACE;
    24ea:	400e6e13          	ori	t3,t3,1024
            continue;
    24ee:	0685                	addi	a3,a3,1
    24f0:	b785                	j	2450 <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEFTJUST;
    24f2:	001e6e13          	ori	t3,t3,1
            continue;
    24f6:	0685                	addi	a3,a3,1
    24f8:	bfa1                	j	2450 <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADINGPLUS;
    24fa:	002e6e13          	ori	t3,t3,2
            continue;
    24fe:	0685                	addi	a3,a3,1
    2500:	bf81                	j	2450 <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__TRIPLET_COMMA;
    2502:	040e6e13          	ori	t3,t3,64
            continue;
    2506:	0685                	addi	a3,a3,1
    2508:	b7a1                	j	2450 <stbsp_vsprintfcb+0x16e>
            if (fl & STBSP__METRIC_SUFFIX) {
    250a:	100e7793          	andi	a5,t3,256
    250e:	8772                	mv	a4,t3
    2510:	56078363          	beqz	a5,2a76 <stbsp_vsprintfcb+0x794>
               if (fl & STBSP__METRIC_1024) {
    2514:	6785                	lui	a5,0x1
    2516:	034e1513          	slli	a0,t3,0x34
    251a:	80078793          	addi	a5,a5,-2048 # 800 <_ZN6Parser12parse_redirsEP7CommandPPcS2_+0x334>
    251e:	5c055863          	bgez	a0,2aee <stbsp_vsprintfcb+0x80c>
                  fl |= STBSP__METRIC_JEDEC;
    2522:	6785                	lui	a5,0x1
    2524:	8f5d                	or	a4,a4,a5
    2526:	00070e1b          	sext.w	t3,a4
    252a:	0685                	addi	a3,a3,1
    252c:	b715                	j	2450 <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADING_0X;
    252e:	008e6e13          	ori	t3,t3,8
            continue;
    2532:	0685                	addi	a3,a3,1
    2534:	bf31                	j	2450 <stbsp_vsprintfcb+0x16e>
            fl |= STBSP__LEADINGSPACE;
    2536:	004e6e13          	ori	t3,t3,4
            continue;
    253a:	0685                	addi	a3,a3,1
    253c:	bf11                	j	2450 <stbsp_vsprintfcb+0x16e>
         while ((f[0] >= '0') && (f[0] <= '9')) {
    253e:	fd07871b          	addiw	a4,a5,-48 # fd0 <main+0xbc>
    2542:	0ff77713          	zext.b	a4,a4
    2546:	4625                	li	a2,9
      fw = 0;
    2548:	4b01                	li	s6,0
         while ((f[0] >= '0') && (f[0] <= '9')) {
    254a:	46a5                	li	a3,9
    254c:	f4e660e3          	bltu	a2,a4,248c <stbsp_vsprintfcb+0x1aa>
            fw = fw * 10 + f[0] - '0';
    2550:	002b171b          	slliw	a4,s6,0x2
    2554:	0167073b          	addw	a4,a4,s6
    2558:	0017171b          	slliw	a4,a4,0x1
            f++;
    255c:	0485                	addi	s1,s1,1
            fw = fw * 10 + f[0] - '0';
    255e:	9f3d                	addw	a4,a4,a5
         while ((f[0] >= '0') && (f[0] <= '9')) {
    2560:	0004c783          	lbu	a5,0(s1)
            fw = fw * 10 + f[0] - '0';
    2564:	fd070b1b          	addiw	s6,a4,-48
         while ((f[0] >= '0') && (f[0] <= '9')) {
    2568:	fd07871b          	addiw	a4,a5,-48
    256c:	0ff77713          	zext.b	a4,a4
    2570:	fee6f0e3          	bgeu	a3,a4,2550 <stbsp_vsprintfcb+0x26e>
      if (f[0] == '.') {
    2574:	02e00713          	li	a4,46
      pr = -1;
    2578:	58fd                	li	a7,-1
      if (f[0] == '.') {
    257a:	f0e79ee3          	bne	a5,a4,2496 <stbsp_vsprintfcb+0x1b4>
         if (f[0] == '*') {
    257e:	0014c783          	lbu	a5,1(s1)
    2582:	02a00713          	li	a4,42
    2586:	52e79763          	bne	a5,a4,2ab4 <stbsp_vsprintfcb+0x7d2>
            while ((f[0] >= '0') && (f[0] <= '9')) {
    258a:	0024c783          	lbu	a5,2(s1)
      switch (f[0]) {
    258e:	04900713          	li	a4,73
            pr = va_arg(va, stbsp__uint32);
    2592:	000ba883          	lw	a7,0(s7)
            ++f;
    2596:	0489                	addi	s1,s1,2
            pr = va_arg(va, stbsp__uint32);
    2598:	0ba1                	addi	s7,s7,8
      switch (f[0]) {
    259a:	f0e792e3          	bne	a5,a4,249e <stbsp_vsprintfcb+0x1bc>
         if ((f[1] == '6') && (f[2] == '4')) {
    259e:	0014c783          	lbu	a5,1(s1)
    25a2:	03600713          	li	a4,54
    25a6:	00e79463          	bne	a5,a4,25ae <stbsp_vsprintfcb+0x2cc>
    25aa:	1e60106f          	j	3790 <stbsp_vsprintfcb+0x14ae>
         } else if ((f[1] == '3') && (f[2] == '2')) {
    25ae:	03300713          	li	a4,51
    25b2:	6ae796e3          	bne	a5,a4,345e <stbsp_vsprintfcb+0x117c>
    25b6:	0024c683          	lbu	a3,2(s1)
    25ba:	03200713          	li	a4,50
    25be:	00e69463          	bne	a3,a4,25c6 <stbsp_vsprintfcb+0x2e4>
    25c2:	0ae0106f          	j	3670 <stbsp_vsprintfcb+0x138e>
            ++f;
    25c6:	0485                	addi	s1,s1,1
         *s = f[0];
    25c8:	26f10fa3          	sb	a5,639(sp)
         l = 1;
    25cc:	4785                	li	a5,1
    25ce:	d0be                	sw	a5,96(sp)
         lead[0] = 0;
    25d0:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    25d4:	06010823          	sb	zero,112(sp)
         dp = 0;
    25d8:	d282                	sw	zero,100(sp)
    25da:	e0de                	sd	s7,64(sp)
    25dc:	4701                	li	a4,0
    25de:	4301                	li	t1,0
    25e0:	4f81                	li	t6,0
    25e2:	4685                	li	a3,1
    25e4:	4a01                	li	s4,0
         cs = 0;
    25e6:	4281                	li	t0,0
         s = num + STBSP__NUMSZ - 1;
    25e8:	27f10a93          	addi	s5,sp,639
         fw = fl = 0;
    25ec:	4e01                	li	t3,0
      tz = 0;
    25ee:	4881                	li	a7,0
            if (fl & STBSP__LEADINGZERO) // if leading zeros, everything is in pr
    25f0:	010e7793          	andi	a5,t3,16
    25f4:	40078ee3          	beqz	a5,3210 <stbsp_vsprintfcb+0xf2e>
               pr = (fw > pr) ? fw : pr;
    25f8:	87ba                	mv	a5,a4
    25fa:	00675363          	bge	a4,t1,2600 <stbsp_vsprintfcb+0x31e>
    25fe:	879a                	mv	a5,t1
    2600:	0007871b          	sext.w	a4,a5
               fw = 0;
    2604:	4301                	li	t1,0
         if (fw + pr) {
    2606:	62070563          	beqz	a4,2c30 <stbsp_vsprintfcb+0x94e>
            sn = lead + 1;
    260a:	06910793          	addi	a5,sp,105
    260e:	fcbe                	sd	a5,120(sp)
            while (lead[0]) {
    2610:	0a0a0863          	beqz	s4,26c0 <stbsp_vsprintfcb+0x3de>
               stbsp__cb_buf_clamp(i, lead[0]);
    2614:	f026                	sd	s1,32(sp)
    2616:	f436                	sd	a3,40(sp)
    2618:	854a                	mv	a0,s2
    261a:	86d2                	mv	a3,s4
    261c:	84ce                	mv	s1,s3
               stbsp__chk_cb_buf(1);
    261e:	1fe00b93          	li	s7,510
               stbsp__cb_buf_clamp(i, lead[0]);
    2622:	89be                	mv	s3,a5
    2624:	20000b13          	li	s6,512
    2628:	87a2                	mv	a5,s0
    262a:	e846                	sd	a7,16(sp)
    262c:	846a                	mv	s0,s10
    262e:	ec7e                	sd	t6,24(sp)
    2630:	8d6e                	mv	s10,s11
    2632:	f872                	sd	t3,48(sp)
    2634:	8de6                	mv	s11,s9
    2636:	8a3a                	mv	s4,a4
    2638:	e496                	sd	t0,72(sp)
    263a:	891a                	mv	s2,t1
    263c:	8c9e                	mv	s9,t2
    263e:	0006871b          	sext.w	a4,a3
    2642:	2e0482e3          	beqz	s1,3126 <stbsp_vsprintfcb+0xe44>
    2646:	40a7863b          	subw	a2,a5,a0
    264a:	40cb083b          	subw	a6,s6,a2
    264e:	85c2                	mv	a1,a6
    2650:	01075363          	bge	a4,a6,2656 <stbsp_vsprintfcb+0x374>
    2654:	85ba                	mv	a1,a4
               lead[0] -= (char)i;
    2656:	9e8d                	subw	a3,a3,a1
               stbsp__cb_buf_clamp(i, lead[0]);
    2658:	0005871b          	sext.w	a4,a1
               lead[0] -= (char)i;
    265c:	06d10423          	sb	a3,104(sp)
               while (i) {
    2660:	c70d                	beqz	a4,268a <stbsp_vsprintfcb+0x3a8>
    2662:	7866                	ld	a6,120(sp)
    2664:	02071593          	slli	a1,a4,0x20
    2668:	9181                	srli	a1,a1,0x20
    266a:	00b78633          	add	a2,a5,a1
    266e:	8742                	mv	a4,a6
                  *bf++ = *sn++;
    2670:	00074683          	lbu	a3,0(a4)
    2674:	0785                	addi	a5,a5,1
               while (i) {
    2676:	0705                	addi	a4,a4,1
                  *bf++ = *sn++;
    2678:	fed78fa3          	sb	a3,-1(a5)
               while (i) {
    267c:	fec79ae3          	bne	a5,a2,2670 <stbsp_vsprintfcb+0x38e>
    2680:	982e                	add	a6,a6,a1
    2682:	fcc2                	sd	a6,120(sp)
               stbsp__chk_cb_buf(1);
    2684:	c899                	beqz	s1,269a <stbsp_vsprintfcb+0x3b8>
    2686:	40a7863b          	subw	a2,a5,a0
    268a:	00cbd863          	bge	s7,a2,269a <stbsp_vsprintfcb+0x3b8>
    268e:	65a2                	ld	a1,8(sp)
    2690:	9c31                	addw	s0,s0,a2
    2692:	9482                	jalr	s1
    2694:	34050ee3          	beqz	a0,31f0 <stbsp_vsprintfcb+0xf0e>
    2698:	87aa                	mv	a5,a0
            while (lead[0]) {
    269a:	06814683          	lbu	a3,104(sp)
    269e:	f2c5                	bnez	a3,263e <stbsp_vsprintfcb+0x35c>
    26a0:	83e6                	mv	t2,s9
    26a2:	68c2                	ld	a7,16(sp)
    26a4:	8cee                	mv	s9,s11
    26a6:	6fe2                	ld	t6,24(sp)
    26a8:	8dea                	mv	s11,s10
    26aa:	76a2                	ld	a3,40(sp)
    26ac:	8d22                	mv	s10,s0
    26ae:	7e42                	ld	t3,48(sp)
    26b0:	843e                	mv	s0,a5
    26b2:	62a6                	ld	t0,72(sp)
    26b4:	87ce                	mv	a5,s3
    26b6:	89a6                	mv	s3,s1
    26b8:	7482                	ld	s1,32(sp)
    26ba:	834a                	mv	t1,s2
    26bc:	8752                	mv	a4,s4
    26be:	892a                	mv	s2,a0
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    26c0:	040e7b13          	andi	s6,t3,64
            c = cs >> 24;
    26c4:	0182d61b          	srliw	a2,t0,0x18
    26c8:	0182db9b          	srliw	s7,t0,0x18
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    26cc:	4a01                	li	s4,0
    26ce:	000b0e63          	beqz	s6,26ea <stbsp_vsprintfcb+0x408>
            cs &= 0xffffff;
    26d2:	02829a13          	slli	s4,t0,0x28
    26d6:	028a5a13          	srli	s4,s4,0x28
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((stbsp__uint32)(c - ((pr + cs) % (c + 1)))) : 0;
    26da:	00ea0a3b          	addw	s4,s4,a4
    26de:	0016059b          	addiw	a1,a2,1
    26e2:	02ba7a3b          	remuw	s4,s4,a1
    26e6:	41460a3b          	subw	s4,a2,s4
            while (pr > 0) {
    26ea:	0ce05763          	blez	a4,27b8 <stbsp_vsprintfcb+0x4d6>
                     *(stbsp__uint32 *)bf = 0x30303030;
    26ee:	30303837          	lui	a6,0x30303
    26f2:	03080813          	addi	a6,a6,48 # 30303030 <_ZSt4cerr+0x302fa1f0>
    26f6:	f026                	sd	s1,32(sp)
    26f8:	854a                	mv	a0,s2
    26fa:	84da                	mv	s1,s6
    26fc:	895e                	mv	s2,s7
    26fe:	e4d6                	sd	s5,72(sp)
    2700:	8b4e                	mv	s6,s3
    2702:	8aea                	mv	s5,s10
               stbsp__chk_cb_buf(1);
    2704:	1fe00293          	li	t0,510
    2708:	8d6e                	mv	s10,s11
                     *bf++ = stbsp__comma;
    270a:	00005f17          	auipc	t5,0x5
    270e:	7def0f13          	addi	t5,t5,2014 # 7ee8 <stbsp__digitpair>
    2712:	8de6                	mv	s11,s9
                     *bf++ = '0';
    2714:	03000e93          	li	t4,48
    2718:	e846                	sd	a7,16(sp)
    271a:	ec7e                	sd	t6,24(sp)
    271c:	f436                	sd	a3,40(sp)
    271e:	f872                	sd	t3,48(sp)
    2720:	e89a                	sd	t1,80(sp)
    2722:	89ba                	mv	s3,a4
    2724:	ecbe                	sd	a5,88(sp)
    2726:	8bc2                	mv	s7,a6
    2728:	8c9e                	mv	s9,t2
               stbsp__cb_buf_clamp(i, pr);
    272a:	240b0ee3          	beqz	s6,3186 <stbsp_vsprintfcb+0xea4>
    272e:	40a407b3          	sub	a5,s0,a0
    2732:	40fc063b          	subw	a2,s8,a5
    2736:	87b2                	mv	a5,a2
    2738:	00c9d363          	bge	s3,a2,273e <stbsp_vsprintfcb+0x45c>
    273c:	87ce                	mv	a5,s3
    273e:	0007859b          	sext.w	a1,a5
               pr -= i;
    2742:	40f989bb          	subw	s3,s3,a5
               if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    2746:	32048c63          	beqz	s1,2a7e <stbsp_vsprintfcb+0x79c>
               while (i) {
    274a:	34058a63          	beqz	a1,2a9e <stbsp_vsprintfcb+0x7bc>
    274e:	1582                	slli	a1,a1,0x20
                     *bf++ = stbsp__comma;
    2750:	0cdf4603          	lbu	a2,205(t5)
    2754:	9181                	srli	a1,a1,0x20
    2756:	95a2                	add	a1,a1,s0
    2758:	0405                	addi	s0,s0,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (cs++ == c)) {
    275a:	c481                	beqz	s1,2762 <stbsp_vsprintfcb+0x480>
    275c:	1d4901e3          	beq	s2,s4,311e <stbsp_vsprintfcb+0xe3c>
    2760:	2a05                	addiw	s4,s4,1
                     *bf++ = '0';
    2762:	03000793          	li	a5,48
    2766:	fef40fa3          	sb	a5,-1(s0)
               while (i) {
    276a:	fe8597e3          	bne	a1,s0,2758 <stbsp_vsprintfcb+0x476>
               stbsp__chk_cb_buf(1);
    276e:	320b0b63          	beqz	s6,2aa4 <stbsp_vsprintfcb+0x7c2>
    2772:	40a5863b          	subw	a2,a1,a0
    2776:	32c2d763          	bge	t0,a2,2aa4 <stbsp_vsprintfcb+0x7c2>
    277a:	65a2                	ld	a1,8(sp)
    277c:	01560abb          	addw	s5,a2,s5
    2780:	9b02                	jalr	s6
    2782:	3a050ce3          	beqz	a0,333a <stbsp_vsprintfcb+0x1058>
    2786:	842a                	mv	s0,a0
    2788:	1fe00293          	li	t0,510
    278c:	00005f17          	auipc	t5,0x5
    2790:	75cf0f13          	addi	t5,t5,1884 # 7ee8 <stbsp__digitpair>
    2794:	03000e93          	li	t4,48
            while (pr > 0) {
    2798:	f93049e3          	bgtz	s3,272a <stbsp_vsprintfcb+0x448>
         while (lead[0]) {
    279c:	83e6                	mv	t2,s9
    279e:	68c2                	ld	a7,16(sp)
    27a0:	8cee                	mv	s9,s11
    27a2:	6fe2                	ld	t6,24(sp)
    27a4:	8dea                	mv	s11,s10
    27a6:	7482                	ld	s1,32(sp)
    27a8:	8d56                	mv	s10,s5
    27aa:	76a2                	ld	a3,40(sp)
    27ac:	7e42                	ld	t3,48(sp)
    27ae:	6346                	ld	t1,80(sp)
    27b0:	67e6                	ld	a5,88(sp)
    27b2:	6aa6                	ld	s5,72(sp)
    27b4:	892a                	mv	s2,a0
    27b6:	89da                	mv	s3,s6
    27b8:	06814a03          	lbu	s4,104(sp)
         sn = lead + 1;
    27bc:	fcbe                	sd	a5,120(sp)
         while (lead[0]) {
    27be:	0a0a0263          	beqz	s4,2862 <stbsp_vsprintfcb+0x580>
            stbsp__cb_buf_clamp(i, lead[0]);
    27c2:	ec26                	sd	s1,24(sp)
    27c4:	f036                	sd	a3,32(sp)
    27c6:	854a                	mv	a0,s2
    27c8:	86d2                	mv	a3,s4
    27ca:	84ce                	mv	s1,s3
    27cc:	87a2                	mv	a5,s0
            stbsp__chk_cb_buf(1);
    27ce:	1fe00b93          	li	s7,510
            stbsp__cb_buf_clamp(i, lead[0]);
    27d2:	846a                	mv	s0,s10
    27d4:	20000b13          	li	s6,512
    27d8:	8d6e                	mv	s10,s11
    27da:	e846                	sd	a7,16(sp)
    27dc:	8de6                	mv	s11,s9
    27de:	8a7e                	mv	s4,t6
    27e0:	8972                	mv	s2,t3
    27e2:	899a                	mv	s3,t1
    27e4:	8c9e                	mv	s9,t2
    27e6:	0006871b          	sext.w	a4,a3
    27ea:	140482e3          	beqz	s1,312e <stbsp_vsprintfcb+0xe4c>
    27ee:	40a7863b          	subw	a2,a5,a0
    27f2:	40cb083b          	subw	a6,s6,a2
    27f6:	85c2                	mv	a1,a6
    27f8:	01075363          	bge	a4,a6,27fe <stbsp_vsprintfcb+0x51c>
    27fc:	85ba                	mv	a1,a4
            lead[0] -= (char)i;
    27fe:	9e8d                	subw	a3,a3,a1
            stbsp__cb_buf_clamp(i, lead[0]);
    2800:	0005871b          	sext.w	a4,a1
            lead[0] -= (char)i;
    2804:	06d10423          	sb	a3,104(sp)
            while (i) {
    2808:	c70d                	beqz	a4,2832 <stbsp_vsprintfcb+0x550>
    280a:	7866                	ld	a6,120(sp)
    280c:	02071593          	slli	a1,a4,0x20
    2810:	9181                	srli	a1,a1,0x20
    2812:	00b78633          	add	a2,a5,a1
    2816:	8742                	mv	a4,a6
               *bf++ = *sn++;
    2818:	00074683          	lbu	a3,0(a4)
    281c:	0785                	addi	a5,a5,1
            while (i) {
    281e:	0705                	addi	a4,a4,1
               *bf++ = *sn++;
    2820:	fed78fa3          	sb	a3,-1(a5)
            while (i) {
    2824:	fec79ae3          	bne	a5,a2,2818 <stbsp_vsprintfcb+0x536>
    2828:	982e                	add	a6,a6,a1
    282a:	fcc2                	sd	a6,120(sp)
            stbsp__chk_cb_buf(1);
    282c:	c899                	beqz	s1,2842 <stbsp_vsprintfcb+0x560>
    282e:	40a7863b          	subw	a2,a5,a0
    2832:	00cbd863          	bge	s7,a2,2842 <stbsp_vsprintfcb+0x560>
    2836:	65a2                	ld	a1,8(sp)
    2838:	9c31                	addw	s0,s0,a2
    283a:	9482                	jalr	s1
    283c:	1a050ae3          	beqz	a0,31f0 <stbsp_vsprintfcb+0xf0e>
    2840:	87aa                	mv	a5,a0
         while (lead[0]) {
    2842:	06814683          	lbu	a3,104(sp)
    2846:	f2c5                	bnez	a3,27e6 <stbsp_vsprintfcb+0x504>
    2848:	834e                	mv	t1,s3
    284a:	68c2                	ld	a7,16(sp)
    284c:	89a6                	mv	s3,s1
    284e:	7682                	ld	a3,32(sp)
    2850:	64e2                	ld	s1,24(sp)
    2852:	8e4a                	mv	t3,s2
    2854:	83e6                	mv	t2,s9
    2856:	8fd2                	mv	t6,s4
    2858:	8cee                	mv	s9,s11
    285a:	892a                	mv	s2,a0
    285c:	8dea                	mv	s11,s10
    285e:	8d22                	mv	s10,s0
    2860:	843e                	mv	s0,a5
         while (n) {
    2862:	c6f9                	beqz	a3,2930 <stbsp_vsprintfcb+0x64e>
            STBSP__UNALIGNED(while (i >= 4) {
    2864:	ec26                	sd	s1,24(sp)
    2866:	854a                	mv	a0,s2
    2868:	84d6                	mv	s1,s5
    286a:	896a                	mv	s2,s10
    286c:	87a2                	mv	a5,s0
    286e:	8d6e                	mv	s10,s11
            stbsp__chk_cb_buf(1);
    2870:	1fe00b93          	li	s7,510
            STBSP__UNALIGNED(while (i >= 4) {
    2874:	8de6                	mv	s11,s9
            stbsp__cb_buf_clamp(i, n);
    2876:	20000b13          	li	s6,512
            STBSP__UNALIGNED(while (i >= 4) {
    287a:	4a0d                	li	s4,3
    287c:	e87e                	sd	t6,16(sp)
    287e:	f072                	sd	t3,32(sp)
    2880:	8ac6                	mv	s5,a7
    2882:	f41a                	sd	t1,40(sp)
    2884:	8436                	mv	s0,a3
    2886:	8c9e                	mv	s9,t2
            stbsp__cb_buf_clamp(i, n);
    2888:	0004071b          	sext.w	a4,s0
    288c:	100982e3          	beqz	s3,3190 <stbsp_vsprintfcb+0xeae>
    2890:	40a78633          	sub	a2,a5,a0
    2894:	40cb05bb          	subw	a1,s6,a2
    2898:	862e                	mv	a2,a1
    289a:	00b75363          	bge	a4,a1,28a0 <stbsp_vsprintfcb+0x5be>
    289e:	863a                	mv	a2,a4
    28a0:	0006071b          	sext.w	a4,a2
            n -= i;
    28a4:	9c11                	subw	s0,s0,a2
            STBSP__UNALIGNED(while (i >= 4) {
    28a6:	14ea50e3          	bge	s4,a4,31e6 <stbsp_vsprintfcb+0xf04>
    28aa:	ffc70f1b          	addiw	t5,a4,-4
    28ae:	002f5e9b          	srliw	t4,t5,0x2
    28b2:	001e8e1b          	addiw	t3,t4,1
    28b6:	0e0a                	slli	t3,t3,0x2
    28b8:	01c785b3          	add	a1,a5,t3
    28bc:	8626                	mv	a2,s1
    28be:	4218                	lw	a4,0(a2)
    28c0:	0791                	addi	a5,a5,4
    28c2:	0611                	addi	a2,a2,4
    28c4:	2701                	sext.w	a4,a4
    28c6:	fee7ae23          	sw	a4,-4(a5)
    28ca:	feb79ae3          	bne	a5,a1,28be <stbsp_vsprintfcb+0x5dc>
    28ce:	002e9e9b          	slliw	t4,t4,0x2
    28d2:	41df073b          	subw	a4,t5,t4
            while (i) {
    28d6:	94f2                	add	s1,s1,t3
    28d8:	c31d                	beqz	a4,28fe <stbsp_vsprintfcb+0x61c>
    28da:	8626                	mv	a2,s1
    28dc:	87ae                	mv	a5,a1
    28de:	00e58f3b          	addw	t5,a1,a4
               *bf++ = *s++;
    28e2:	00064e83          	lbu	t4,0(a2)
    28e6:	0785                	addi	a5,a5,1
            while (i) {
    28e8:	00078e1b          	sext.w	t3,a5
               *bf++ = *s++;
    28ec:	ffd78fa3          	sb	t4,-1(a5)
    28f0:	0605                	addi	a2,a2,1
            while (i) {
    28f2:	ffcf18e3          	bne	t5,t3,28e2 <stbsp_vsprintfcb+0x600>
    28f6:	1702                	slli	a4,a4,0x20
    28f8:	9301                	srli	a4,a4,0x20
    28fa:	95ba                	add	a1,a1,a4
    28fc:	94ba                	add	s1,s1,a4
            stbsp__chk_cb_buf(1);
    28fe:	1a098763          	beqz	s3,2aac <stbsp_vsprintfcb+0x7ca>
    2902:	40a5863b          	subw	a2,a1,a0
    2906:	1acbd363          	bge	s7,a2,2aac <stbsp_vsprintfcb+0x7ca>
    290a:	65a2                	ld	a1,8(sp)
    290c:	0126093b          	addw	s2,a2,s2
    2910:	9982                	jalr	s3
    2912:	20050be3          	beqz	a0,3328 <stbsp_vsprintfcb+0x1046>
    2916:	87aa                	mv	a5,a0
         while (n) {
    2918:	f825                	bnez	s0,2888 <stbsp_vsprintfcb+0x5a6>
    291a:	6fc2                	ld	t6,16(sp)
    291c:	64e2                	ld	s1,24(sp)
    291e:	7e02                	ld	t3,32(sp)
    2920:	7322                	ld	t1,40(sp)
    2922:	83e6                	mv	t2,s9
    2924:	88d6                	mv	a7,s5
    2926:	8cee                	mv	s9,s11
    2928:	843e                	mv	s0,a5
    292a:	8dea                	mv	s11,s10
    292c:	8d4a                	mv	s10,s2
    292e:	892a                	mv	s2,a0
         while (tz) {
    2930:	08088863          	beqz	a7,29c0 <stbsp_vsprintfcb+0x6de>
               *(stbsp__uint32 *)bf = 0x30303030;
    2934:	30303b37          	lui	s6,0x30303
               *bf++ = '0';
    2938:	03000a13          	li	s4,48
            while (i >= 4) {
    293c:	4a8d                	li	s5,3
            stbsp__chk_cb_buf(1);
    293e:	1fe00693          	li	a3,510
               *(stbsp__uint32 *)bf = 0x30303030;
    2942:	030b0b13          	addi	s6,s6,48 # 30303030 <_ZSt4cerr+0x302fa1f0>
            stbsp__cb_buf_clamp(i, tz);
    2946:	20000b93          	li	s7,512
    294a:	040989e3          	beqz	s3,319c <stbsp_vsprintfcb+0xeba>
    294e:	41240633          	sub	a2,s0,s2
    2952:	40cb87bb          	subw	a5,s7,a2
    2956:	873e                	mv	a4,a5
    2958:	00f8d363          	bge	a7,a5,295e <stbsp_vsprintfcb+0x67c>
    295c:	8746                	mv	a4,a7
    295e:	0007079b          	sext.w	a5,a4
            tz -= i;
    2962:	40e888bb          	subw	a7,a7,a4
            while (i) {
    2966:	08078ee3          	beqz	a5,3202 <stbsp_vsprintfcb+0xf20>
               if ((((stbsp__uintptr)bf) & 3) == 0)
    296a:	00347713          	andi	a4,s0,3
    296e:	e719                	bnez	a4,297c <stbsp_vsprintfcb+0x69a>
    2970:	0390006f          	j	31a8 <stbsp_vsprintfcb+0xec6>
    2974:	00347713          	andi	a4,s0,3
    2978:	7a070f63          	beqz	a4,3136 <stbsp_vsprintfcb+0xe54>
               *bf++ = '0';
    297c:	01440023          	sb	s4,0(s0)
               --i;
    2980:	37fd                	addiw	a5,a5,-1
               *bf++ = '0';
    2982:	0405                	addi	s0,s0,1
            while (i) {
    2984:	fbe5                	bnez	a5,2974 <stbsp_vsprintfcb+0x692>
            stbsp__chk_cb_buf(1);
    2986:	02098b63          	beqz	s3,29bc <stbsp_vsprintfcb+0x6da>
    298a:	4124063b          	subw	a2,s0,s2
    298e:	02c6d763          	bge	a3,a2,29bc <stbsp_vsprintfcb+0x6da>
    2992:	65a2                	ld	a1,8(sp)
    2994:	854a                	mv	a0,s2
    2996:	f81e                	sd	t2,48(sp)
    2998:	f41a                	sd	t1,40(sp)
    299a:	f072                	sd	t3,32(sp)
    299c:	ec7e                	sd	t6,24(sp)
    299e:	e846                	sd	a7,16(sp)
    29a0:	00cd0d3b          	addw	s10,s10,a2
    29a4:	9982                	jalr	s3
    29a6:	892a                	mv	s2,a0
    29a8:	1a0502e3          	beqz	a0,334c <stbsp_vsprintfcb+0x106a>
    29ac:	73c2                	ld	t2,48(sp)
    29ae:	7322                	ld	t1,40(sp)
    29b0:	7e02                	ld	t3,32(sp)
    29b2:	6fe2                	ld	t6,24(sp)
    29b4:	68c2                	ld	a7,16(sp)
    29b6:	842a                	mv	s0,a0
    29b8:	1fe00693          	li	a3,510
         while (tz) {
    29bc:	f80897e3          	bnez	a7,294a <stbsp_vsprintfcb+0x668>
         sn = tail + 1;
    29c0:	07110793          	addi	a5,sp,113
    29c4:	fcbe                	sd	a5,120(sp)
         while (tail[0]) {
    29c6:	080f8763          	beqz	t6,2a54 <stbsp_vsprintfcb+0x772>
            stbsp__cb_buf_clamp(i, tail[0]);
    29ca:	854a                	mv	a0,s2
    29cc:	8b6a                	mv	s6,s10
            stbsp__chk_cb_buf(1);
    29ce:	1fe00a93          	li	s5,510
            stbsp__cb_buf_clamp(i, tail[0]);
    29d2:	8d4e                	mv	s10,s3
    29d4:	20000a13          	li	s4,512
    29d8:	8bf2                	mv	s7,t3
    29da:	891a                	mv	s2,t1
    29dc:	899e                	mv	s3,t2
    29de:	000f879b          	sext.w	a5,t6
    29e2:	7c0d0863          	beqz	s10,31b2 <stbsp_vsprintfcb+0xed0>
    29e6:	40a4063b          	subw	a2,s0,a0
    29ea:	40ca06bb          	subw	a3,s4,a2
    29ee:	8736                	mv	a4,a3
    29f0:	00d7d363          	bge	a5,a3,29f6 <stbsp_vsprintfcb+0x714>
    29f4:	873e                	mv	a4,a5
            tail[0] -= (char)i;
    29f6:	40ef8fbb          	subw	t6,t6,a4
            stbsp__cb_buf_clamp(i, tail[0]);
    29fa:	0007079b          	sext.w	a5,a4
            tail[0] -= (char)i;
    29fe:	07f10823          	sb	t6,112(sp)
            while (i) {
    2a02:	c795                	beqz	a5,2a2e <stbsp_vsprintfcb+0x74c>
    2a04:	75e6                	ld	a1,120(sp)
    2a06:	02079613          	slli	a2,a5,0x20
    2a0a:	9201                	srli	a2,a2,0x20
    2a0c:	00c406b3          	add	a3,s0,a2
    2a10:	87ae                	mv	a5,a1
               *bf++ = *sn++;
    2a12:	0007c703          	lbu	a4,0(a5)
    2a16:	0405                	addi	s0,s0,1
            while (i) {
    2a18:	0785                	addi	a5,a5,1
               *bf++ = *sn++;
    2a1a:	fee40fa3          	sb	a4,-1(s0)
            while (i) {
    2a1e:	fed41ae3          	bne	s0,a3,2a12 <stbsp_vsprintfcb+0x730>
    2a22:	95b2                	add	a1,a1,a2
    2a24:	fcae                	sd	a1,120(sp)
            stbsp__chk_cb_buf(1);
    2a26:	000d0d63          	beqz	s10,2a40 <stbsp_vsprintfcb+0x75e>
    2a2a:	40a4063b          	subw	a2,s0,a0
    2a2e:	00cad963          	bge	s5,a2,2a40 <stbsp_vsprintfcb+0x75e>
    2a32:	65a2                	ld	a1,8(sp)
    2a34:	00cb0b3b          	addw	s6,s6,a2
    2a38:	9d02                	jalr	s10
    2a3a:	200509e3          	beqz	a0,344c <stbsp_vsprintfcb+0x116a>
    2a3e:	842a                	mv	s0,a0
         while (tail[0]) {
    2a40:	07014f83          	lbu	t6,112(sp)
    2a44:	f80f9de3          	bnez	t6,29de <stbsp_vsprintfcb+0x6fc>
    2a48:	834a                	mv	t1,s2
    2a4a:	83ce                	mv	t2,s3
    2a4c:	8e5e                	mv	t3,s7
    2a4e:	89ea                	mv	s3,s10
    2a50:	892a                	mv	s2,a0
    2a52:	8d5a                	mv	s10,s6
         if (fl & STBSP__LEFTJUST)
    2a54:	001e7e13          	andi	t3,t3,1
    2a58:	000e0663          	beqz	t3,2a64 <stbsp_vsprintfcb+0x782>
            if (fw > 0) {
    2a5c:	00605463          	blez	t1,2a64 <stbsp_vsprintfcb+0x782>
    2a60:	0300106f          	j	3a90 <stbsp_vsprintfcb+0x17ae>
   for (;;) {
    2a64:	6b86                	ld	s7,64(sp)
    2a66:	2c013a03          	ld	s4,704(sp)
    2a6a:	2b813a83          	ld	s5,696(sp)
    2a6e:	2b013b03          	ld	s6,688(sp)
      ++f;
    2a72:	0485                	addi	s1,s1,1
   for (;;) {
    2a74:	b0f1                	j	2340 <stbsp_vsprintfcb+0x5e>
               fl |= STBSP__METRIC_SUFFIX;
    2a76:	100e6e13          	ori	t3,t3,256
            continue;
    2a7a:	0685                	addi	a3,a3,1
    2a7c:	bad1                	j	2450 <stbsp_vsprintfcb+0x16e>
                  while (i) {
    2a7e:	0e0580e3          	beqz	a1,335e <stbsp_vsprintfcb+0x107c>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    2a82:	00347793          	andi	a5,s0,3
    2a86:	e799                	bnez	a5,2a94 <stbsp_vsprintfcb+0x7b2>
    2a88:	0dd0006f          	j	3364 <stbsp_vsprintfcb+0x1082>
    2a8c:	00347793          	andi	a5,s0,3
    2a90:	72078463          	beqz	a5,31b8 <stbsp_vsprintfcb+0xed6>
                     *bf++ = '0';
    2a94:	01d40023          	sb	t4,0(s0)
                     --i;
    2a98:	35fd                	addiw	a1,a1,-1
                     *bf++ = '0';
    2a9a:	0405                	addi	s0,s0,1
                  while (i) {
    2a9c:	f9e5                	bnez	a1,2a8c <stbsp_vsprintfcb+0x7aa>
               while (i) {
    2a9e:	85a2                	mv	a1,s0
               stbsp__chk_cb_buf(1);
    2aa0:	cc0b19e3          	bnez	s6,2772 <stbsp_vsprintfcb+0x490>
    2aa4:	842e                	mv	s0,a1
            while (pr > 0) {
    2aa6:	c93042e3          	bgtz	s3,272a <stbsp_vsprintfcb+0x448>
    2aaa:	b9cd                	j	279c <stbsp_vsprintfcb+0x4ba>
            while (i) {
    2aac:	87ae                	mv	a5,a1
         while (n) {
    2aae:	dc041de3          	bnez	s0,2888 <stbsp_vsprintfcb+0x5a6>
    2ab2:	b5a5                	j	291a <stbsp_vsprintfcb+0x638>
            while ((f[0] >= '0') && (f[0] <= '9')) {
    2ab4:	fd07871b          	addiw	a4,a5,-48
    2ab8:	0ff77713          	zext.b	a4,a4
    2abc:	4625                	li	a2,9
         ++f;
    2abe:	0485                	addi	s1,s1,1
            pr = 0;
    2ac0:	4881                	li	a7,0
            while ((f[0] >= '0') && (f[0] <= '9')) {
    2ac2:	46a5                	li	a3,9
    2ac4:	9ce669e3          	bltu	a2,a4,2496 <stbsp_vsprintfcb+0x1b4>
               pr = pr * 10 + f[0] - '0';
    2ac8:	0028971b          	slliw	a4,a7,0x2
    2acc:	0117073b          	addw	a4,a4,a7
    2ad0:	0017171b          	slliw	a4,a4,0x1
               f++;
    2ad4:	0485                	addi	s1,s1,1
               pr = pr * 10 + f[0] - '0';
    2ad6:	9f3d                	addw	a4,a4,a5
            while ((f[0] >= '0') && (f[0] <= '9')) {
    2ad8:	0004c783          	lbu	a5,0(s1)
               pr = pr * 10 + f[0] - '0';
    2adc:	fd07089b          	addiw	a7,a4,-48
            while ((f[0] >= '0') && (f[0] <= '9')) {
    2ae0:	fd07871b          	addiw	a4,a5,-48
    2ae4:	0ff77713          	zext.b	a4,a4
    2ae8:	fee6f0e3          	bgeu	a3,a4,2ac8 <stbsp_vsprintfcb+0x7e6>
    2aec:	b26d                	j	2496 <stbsp_vsprintfcb+0x1b4>
                  fl |= STBSP__METRIC_1024;
    2aee:	8f5d                	or	a4,a4,a5
    2af0:	00070e1b          	sext.w	t3,a4
    2af4:	0685                	addi	a3,a3,1
    2af6:	baa9                	j	2450 <stbsp_vsprintfcb+0x16e>
      *bf = 0;
    2af8:	00040023          	sb	zero,0(s0)
    2afc:	b209                	j	23fe <stbsp_vsprintfcb+0x11c>
         if (f[0] == 'l') {
    2afe:	0014c783          	lbu	a5,1(s1)
    2b02:	06c00713          	li	a4,108
         fl |= ((sizeof(long) == 8) ? STBSP__INTMAX : 0);
    2b06:	020e6e13          	ori	t3,t3,32
         if (f[0] == 'l') {
    2b0a:	00e78c63          	beq	a5,a4,2b22 <stbsp_vsprintfcb+0x840>
            ++f;
    2b0e:	0485                	addi	s1,s1,1
    2b10:	ba65                	j	24c8 <stbsp_vsprintfcb+0x1e6>
         if (f[0] == 'h')
    2b12:	0014c783          	lbu	a5,1(s1)
    2b16:	06800713          	li	a4,104
         fl |= STBSP__HALFWIDTH;
    2b1a:	200e6e13          	ori	t3,t3,512
         if (f[0] == 'h')
    2b1e:	fee798e3          	bne	a5,a4,2b0e <stbsp_vsprintfcb+0x82c>
         if ((f[1] == '6') && (f[2] == '4')) {
    2b22:	0024c783          	lbu	a5,2(s1)
            ++f;
    2b26:	0489                	addi	s1,s1,2
    2b28:	b245                	j	24c8 <stbsp_vsprintfcb+0x1e6>
         s = va_arg(va, char *);
    2b2a:	008b8713          	addi	a4,s7,8
    2b2e:	e0ba                	sd	a4,64(sp)
         if (fl & STBSP__INTMAX) {
    2b30:	020e7693          	andi	a3,t3,32
    2b34:	8772                	mv	a4,t3
    2b36:	24069ee3          	bnez	a3,3592 <stbsp_vsprintfcb+0x12b0>
            stbsp__int32 i = va_arg(va, stbsp__int32);
    2b3a:	000ba683          	lw	a3,0(s7)
            if ((f[0] != 'u') && (i < 0)) {
    2b3e:	07500613          	li	a2,117
            n64 = (stbsp__uint32)i;
    2b42:	02069f13          	slli	t5,a3,0x20
    2b46:	020f5f13          	srli	t5,t5,0x20
            if ((f[0] != 'u') && (i < 0)) {
    2b4a:	00c78a63          	beq	a5,a2,2b5e <stbsp_vsprintfcb+0x87c>
    2b4e:	0006d863          	bgez	a3,2b5e <stbsp_vsprintfcb+0x87c>
               fl |= STBSP__NEGATIVE;
    2b52:	08076713          	ori	a4,a4,128
               n64 = (stbsp__uint32)-i;
    2b56:	40d00f3b          	negw	t5,a3
               fl |= STBSP__NEGATIVE;
    2b5a:	00070e1b          	sext.w	t3,a4
         if (fl & STBSP__METRIC_SUFFIX) {
    2b5e:	100e7693          	andi	a3,t3,256
    2b62:	5c0683e3          	beqz	a3,3928 <stbsp_vsprintfcb+0x1646>
            if (n64 < 1024)
    2b66:	3ff00793          	li	a5,1023
    2b6a:	01e7e463          	bltu	a5,t5,2b72 <stbsp_vsprintfcb+0x890>
    2b6e:	0ea0106f          	j	3c58 <stbsp_vsprintfcb+0x1976>
            else if (pr == -1)
    2b72:	57fd                	li	a5,-1
    2b74:	30f887e3          	beq	a7,a5,3682 <stbsp_vsprintfcb+0x13a0>
            fv = (double)(stbsp__int64)n64;
    2b78:	d22f7553          	fcvt.d.l	fa0,t5
            if (fl & STBSP__METRIC_1024)
    2b7c:	034e1793          	slli	a5,t3,0x34
    2b80:	0007c463          	bltz	a5,2b88 <stbsp_vsprintfcb+0x8a6>
    2b84:	2300106f          	j	3db4 <stbsp_vsprintfcb+0x1ad2>
               divisor = 1024.0;
    2b88:	00004797          	auipc	a5,0x4
    2b8c:	d987b787          	fld	fa5,-616(a5) # 6920 <STDIN_FD+0x20>
               if ((fv < divisor) && (fv > -divisor))
    2b90:	22f79753          	fneg.d	fa4,fa5
               fl += 0x1000000;
    2b94:	010006b7          	lui	a3,0x1000
            while (fl < 0x4000000) {
    2b98:	04000737          	lui	a4,0x4000
               if ((fv < divisor) && (fv > -divisor))
    2b9c:	a2f517d3          	flt.d	a5,fa0,fa5
    2ba0:	c789                	beqz	a5,2baa <stbsp_vsprintfcb+0x8c8>
    2ba2:	a2a717d3          	flt.d	a5,fa4,fa0
    2ba6:	3e079863          	bnez	a5,2f96 <stbsp_vsprintfcb+0xcb4>
               fl += 0x1000000;
    2baa:	01c68e3b          	addw	t3,a3,t3
               fv /= divisor;
    2bae:	1af57553          	fdiv.d	fa0,fa0,fa5
            while (fl < 0x4000000) {
    2bb2:	feee65e3          	bltu	t3,a4,2b9c <stbsp_vsprintfcb+0x8ba>
    2bb6:	a6c5                	j	2f96 <stbsp_vsprintfcb+0xcb4>
         h = (f[0] == 'X') ? hexu : hex;
    2bb8:	05800693          	li	a3,88
         if (fl & STBSP__INTMAX) {
    2bbc:	020e7713          	andi	a4,t3,32
         h = (f[0] == 'X') ? hexu : hex;
    2bc0:	00005817          	auipc	a6,0x5
    2bc4:	41080813          	addi	a6,a6,1040 # 7fd0 <hex.0>
    2bc8:	00d79663          	bne	a5,a3,2bd4 <stbsp_vsprintfcb+0x8f2>
    2bcc:	00005817          	auipc	a6,0x5
    2bd0:	3ec80813          	addi	a6,a6,1004 # 7fb8 <hexu.1>
         l = (4 << 4) | (4 << 8);
    2bd4:	44000793          	li	a5,1088
    2bd8:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__LEADING_0X) {
    2bda:	008e7793          	andi	a5,t3,8
    2bde:	7a079263          	bnez	a5,3382 <stbsp_vsprintfcb+0x10a0>
         lead[0] = 0;
    2be2:	06010423          	sb	zero,104(sp)
         s = va_arg(va, char *);
    2be6:	008b8793          	addi	a5,s7,8
    2bea:	e0be                	sd	a5,64(sp)
         if (fl & STBSP__INTMAX)
    2bec:	72070b63          	beqz	a4,3322 <stbsp_vsprintfcb+0x1040>
            n64 = va_arg(va, stbsp__uint64);
    2bf0:	000bb683          	ld	a3,0(s7)
         dp = 0;
    2bf4:	d282                	sw	zero,100(sp)
         tail[0] = 0;
    2bf6:	06010823          	sb	zero,112(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    2bfa:	001e7513          	andi	a0,t3,1
         if (n64 == 0) {
    2bfe:	380694e3          	bnez	a3,3786 <stbsp_vsprintfcb+0x14a4>
            lead[0] = 0;
    2c02:	06010423          	sb	zero,104(sp)
            if (pr == 0) {
    2c06:	78089a63          	bnez	a7,339a <stbsp_vsprintfcb+0x10b8>
         if (fw < (stbsp__int32)n)
    2c0a:	fffb4313          	not	t1,s6
    2c0e:	43f35313          	srai	t1,t1,0x3f
               l = 0;
    2c12:	d082                	sw	zero,96(sp)
         if (fw < (stbsp__int32)n)
    2c14:	01637333          	and	t1,t1,s6
               goto scopy;
    2c18:	4701                	li	a4,0
    2c1a:	4f81                	li	t6,0
    2c1c:	4a01                	li	s4,0
               cs = 0;
    2c1e:	4281                	li	t0,0
         s = num + STBSP__NUMSZ;
    2c20:	28010a93          	addi	s5,sp,640
         if ((fl & STBSP__LEFTJUST) == 0) {
    2c24:	9c0506e3          	beqz	a0,25f0 <stbsp_vsprintfcb+0x30e>
         if (fw + pr) {
    2c28:	00e307bb          	addw	a5,t1,a4
    2c2c:	9c079fe3          	bnez	a5,260a <stbsp_vsprintfcb+0x328>
    2c30:	06910793          	addi	a5,sp,105
    2c34:	b661                	j	27bc <stbsp_vsprintfcb+0x4da>
         h = (f[0] == 'E') ? hexu : hex;
    2c36:	04500713          	li	a4,69
    2c3a:	00005317          	auipc	t1,0x5
    2c3e:	39630313          	addi	t1,t1,918 # 7fd0 <hex.0>
    2c42:	1ce78ae3          	beq	a5,a4,3616 <stbsp_vsprintfcb+0x1334>
         fv = va_arg(va, double);
    2c46:	008b8713          	addi	a4,s7,8
         if (pr == -1)
    2c4a:	57fd                	li	a5,-1
         fv = va_arg(va, double);
    2c4c:	e0ba                	sd	a4,64(sp)
    2c4e:	000bb507          	fld	fa0,0(s7)
         if (pr == -1)
    2c52:	1af88ce3          	beq	a7,a5,360a <stbsp_vsprintfcb+0x1328>
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr | 0x80000000))
    2c56:	80000737          	lui	a4,0x80000
    2c5a:	00e8e733          	or	a4,a7,a4
    2c5e:	2701                	sext.w	a4,a4
    2c60:	10d4                	addi	a3,sp,100
    2c62:	0110                	addi	a2,sp,128
    2c64:	108c                	addi	a1,sp,96
    2c66:	18a8                	addi	a0,sp,120
    2c68:	f41e                	sd	t2,40(sp)
    2c6a:	f01a                	sd	t1,32(sp)
    2c6c:	ec72                	sd	t3,24(sp)
    2c6e:	e846                	sd	a7,16(sp)
    2c70:	d8efe0ef          	jal	11fe <stbsp__real_to_str>
    2c74:	68c2                	ld	a7,16(sp)
    2c76:	6e62                	ld	t3,24(sp)
    2c78:	7302                	ld	t1,32(sp)
    2c7a:	73a2                	ld	t2,40(sp)
         if (dp == STBSP__SPECIAL) {
    2c7c:	5796                	lw	a5,100(sp)
            s = (char *)sn;
    2c7e:	7ae6                	ld	s5,120(sp)
         if ((l - 1) > (stbsp__uint32)pr)
    2c80:	5686                	lw	a3,96(sp)
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr | 0x80000000))
    2c82:	3c0511e3          	bnez	a0,3844 <stbsp_vsprintfcb+0x1562>
         tail[0] = 0;
    2c86:	06010823          	sb	zero,112(sp)
   sign[0] = 0;
    2c8a:	06010423          	sb	zero,104(sp)
   } else if (fl & STBSP__LEADINGSPACE) {
    2c8e:	004e7713          	andi	a4,t3,4
    2c92:	6a070ee3          	beqz	a4,3b4e <stbsp_vsprintfcb+0x186c>
      sign[0] = 1;
    2c96:	6709                	lui	a4,0x2
    2c98:	0705                	addi	a4,a4,1 # 2001 <_vscanf_core.constprop.0+0x675>
    2c9a:	06e11423          	sh	a4,104(sp)
         if (dp == STBSP__SPECIAL) {
    2c9e:	671d                	lui	a4,0x7
    2ca0:	1ee794e3          	bne	a5,a4,3688 <stbsp_vsprintfcb+0x13a6>
         if (pr < (stbsp__int32)l)
    2ca4:	0006879b          	sext.w	a5,a3
         n = pr + lead[0] + tail[0] + tz;
    2ca8:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    2cac:	fff7c793          	not	a5,a5
         n = pr + lead[0] + tail[0] + tz;
    2cb0:	07014f83          	lbu	t6,112(sp)
         if (pr < (stbsp__int32)l)
    2cb4:	97fd                	srai	a5,a5,0x3f
    2cb6:	8ff5                	and	a5,a5,a3
         n = pr + lead[0] + tail[0] + tz;
    2cb8:	00fa073b          	addw	a4,s4,a5
    2cbc:	01f7063b          	addw	a2,a4,t6
    2cc0:	8732                	mv	a4,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    2cc2:	001e7513          	andi	a0,t3,1
         if (pr < (stbsp__int32)l)
    2cc6:	2781                	sext.w	a5,a5
         if (fw < (stbsp__int32)n)
    2cc8:	835a                	mv	t1,s6
    2cca:	00cb5363          	bge	s6,a2,2cd0 <stbsp_vsprintfcb+0x9ee>
    2cce:	8332                	mv	t1,a2
         fw -= n;
    2cd0:	40e3033b          	subw	t1,t1,a4
            cs = 0;
    2cd4:	4281                	li	t0,0
         pr -= l;
    2cd6:	40d7873b          	subw	a4,a5,a3
      tz = 0;
    2cda:	4881                	li	a7,0
            goto scopy;
    2cdc:	b7a1                	j	2c24 <stbsp_vsprintfcb+0x942>
         h = (f[0] == 'G') ? hexu : hex;
    2cde:	04700713          	li	a4,71
    2ce2:	00005317          	auipc	t1,0x5
    2ce6:	2ee30313          	addi	t1,t1,750 # 7fd0 <hex.0>
    2cea:	14e783e3          	beq	a5,a4,3630 <stbsp_vsprintfcb+0x134e>
         fv = va_arg(va, double);
    2cee:	008b8713          	addi	a4,s7,8
         if (pr == -1)
    2cf2:	57fd                	li	a5,-1
         fv = va_arg(va, double);
    2cf4:	e0ba                	sd	a4,64(sp)
    2cf6:	000bb507          	fld	fa0,0(s7)
         if (pr == -1)
    2cfa:	12f884e3          	beq	a7,a5,3622 <stbsp_vsprintfcb+0x1340>
         else if (pr == 0)
    2cfe:	6e0887e3          	beqz	a7,3bec <stbsp_vsprintfcb+0x190a>
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, (pr - 1) | 0x80000000))
    2d02:	fff8871b          	addiw	a4,a7,-1
    2d06:	800007b7          	lui	a5,0x80000
    2d0a:	8f5d                	or	a4,a4,a5
    2d0c:	2701                	sext.w	a4,a4
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    2d0e:	00088a9b          	sext.w	s5,a7
    2d12:	8a46                	mv	s4,a7
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, (pr - 1) | 0x80000000))
    2d14:	10d4                	addi	a3,sp,100
    2d16:	0110                	addi	a2,sp,128
    2d18:	108c                	addi	a1,sp,96
    2d1a:	18a8                	addi	a0,sp,120
    2d1c:	f01e                	sd	t2,32(sp)
    2d1e:	ec1a                	sd	t1,24(sp)
    2d20:	e872                	sd	t3,16(sp)
    2d22:	cdcfe0ef          	jal	11fe <stbsp__real_to_str>
    2d26:	6e42                	ld	t3,16(sp)
    2d28:	6362                	ld	t1,24(sp)
    2d2a:	7382                	ld	t2,32(sp)
    2d2c:	4281                	li	t0,0
    2d2e:	c509                	beqz	a0,2d38 <stbsp_vsprintfcb+0xa56>
            fl |= STBSP__NEGATIVE;
    2d30:	080e6e13          	ori	t3,t3,128
    2d34:	08000293          	li	t0,128
         if (l > (stbsp__uint32)pr)
    2d38:	5806                	lw	a6,96(sp)
    2d3a:	010af463          	bgeu	s5,a6,2d42 <stbsp_vsprintfcb+0xa60>
            l = pr;
    2d3e:	d0d6                	sw	s5,96(sp)
    2d40:	8856                	mv	a6,s5
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2d42:	4705                	li	a4,1
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    2d44:	5796                	lw	a5,100(sp)
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2d46:	01076463          	bltu	a4,a6,2d4e <stbsp_vsprintfcb+0xa6c>
    2d4a:	1800106f          	j	3eca <stbsp_vsprintfcb+0x1be8>
    2d4e:	7be6                	ld	s7,120(sp)
    2d50:	fff8071b          	addiw	a4,a6,-1
    2d54:	1702                	slli	a4,a4,0x20
    2d56:	9301                	srli	a4,a4,0x20
    2d58:	001a0e9b          	addiw	t4,s4,1
    2d5c:	75e2                	ld	a1,56(sp)
    2d5e:	8ade                	mv	s5,s7
    2d60:	975e                	add	a4,a4,s7
    2d62:	410e8ebb          	subw	t4,t4,a6
    2d66:	88d2                	mv	a7,s4
    2d68:	86c2                	mv	a3,a6
    2d6a:	4f01                	li	t5,0
    2d6c:	03000f93          	li	t6,48
    2d70:	e842                	sd	a6,16(sp)
    2d72:	a809                	j	2d84 <stbsp_vsprintfcb+0xaa2>
            --pr;
    2d74:	38fd                	addiw	a7,a7,-1
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2d76:	211e80e3          	beq	t4,a7,3776 <stbsp_vsprintfcb+0x1494>
    2d7a:	177d                	addi	a4,a4,-1 # 6fff <STDIN_FD+0x6ff>
    2d7c:	4f05                	li	t5,1
    2d7e:	1e088ce3          	beqz	a7,3776 <stbsp_vsprintfcb+0x1494>
            --l;
    2d82:	85b6                	mv	a1,a3
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    2d84:	00074803          	lbu	a6,0(a4)
    2d88:	fff6861b          	addiw	a2,a3,-1 # ffffff <_ZSt4cerr+0xff71bf>
    2d8c:	0006851b          	sext.w	a0,a3
    2d90:	2581                	sext.w	a1,a1
    2d92:	0006069b          	sext.w	a3,a2
    2d96:	fdf80fe3          	beq	a6,t6,2d74 <stbsp_vsprintfcb+0xa92>
    2d9a:	6842                	ld	a6,16(sp)
    2d9c:	fc2e                	sd	a1,56(sp)
    2d9e:	86c2                	mv	a3,a6
    2da0:	000f0463          	beqz	t5,2da8 <stbsp_vsprintfcb+0xac6>
    2da4:	d0ae                	sw	a1,96(sp)
    2da6:	86ae                	mv	a3,a1
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    2da8:	5775                	li	a4,-3
    2daa:	08e7cee3          	blt	a5,a4,3646 <stbsp_vsprintfcb+0x1364>
    2dae:	08fa4be3          	blt	s4,a5,3644 <stbsp_vsprintfcb+0x1362>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    2db2:	0005071b          	sext.w	a4,a0
         if (dp > 0) {
    2db6:	7ef057e3          	blez	a5,3da4 <stbsp_vsprintfcb+0x1ac2>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    2dba:	4881                	li	a7,0
    2dbc:	00e7d463          	bge	a5,a4,2dc4 <stbsp_vsprintfcb+0xae2>
    2dc0:	40f508bb          	subw	a7,a0,a5
         tail[0] = 0;
    2dc4:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    2dc8:	20029463          	bnez	t0,2fd0 <stbsp_vsprintfcb+0xcee>
   } else if (fl & STBSP__LEADINGSPACE) {
    2dcc:	004e7713          	andi	a4,t3,4
    2dd0:	000715e3          	bnez	a4,35da <stbsp_vsprintfcb+0x12f8>
   } else if (fl & STBSP__LEADINGPLUS) {
    2dd4:	002e7713          	andi	a4,t3,2
    2dd8:	660719e3          	bnez	a4,3c4a <stbsp_vsprintfcb+0x1968>
   sign[0] = 0;
    2ddc:	06010423          	sb	zero,104(sp)
    2de0:	aaed                	j	2fda <stbsp_vsprintfcb+0xcf8>
         h = (f[0] == 'A') ? hexu : hex;
    2de2:	04100713          	li	a4,65
    2de6:	00005597          	auipc	a1,0x5
    2dea:	1ea58593          	addi	a1,a1,490 # 7fd0 <hex.0>
    2dee:	00e783e3          	beq	a5,a4,35f4 <stbsp_vsprintfcb+0x1312>
         fv = va_arg(va, double);
    2df2:	008b8693          	addi	a3,s7,8
         if (pr == -1)
    2df6:	577d                	li	a4,-1
         fv = va_arg(va, double);
    2df8:	e0b6                	sd	a3,64(sp)
    2dfa:	000bb783          	ld	a5,0(s7)
         if (pr == -1)
    2dfe:	7ee88963          	beq	a7,a4,35f0 <stbsp_vsprintfcb+0x130e>
   d = value;

   STBSP__COPYFP(b, d);

   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    2e02:	4347d613          	srai	a2,a5,0x34
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    2e06:	00c79513          	slli	a0,a5,0xc
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    2e0a:	7ff67613          	andi	a2,a2,2047
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    2e0e:	8131                	srli	a0,a0,0xc
   *expo = (stbsp__int32)(((b >> 52) & 2047) - 1023);
    2e10:	c016061b          	addiw	a2,a2,-1023
         if (stbsp__real_to_parts((stbsp__int64 *)&n64, &dp, fv))
    2e14:	7a07c863          	bltz	a5,35c4 <stbsp_vsprintfcb+0x12e2>
   } else if (fl & STBSP__LEADINGSPACE) {
    2e18:	004e7793          	andi	a5,t3,4
    2e1c:	60078ee3          	beqz	a5,3c38 <stbsp_vsprintfcb+0x1956>
    2e20:	6789                	lui	a5,0x2
    2e22:	2785                	addiw	a5,a5,1 # 2001 <_vscanf_core.constprop.0+0x675>
      sign[0] = 1;
    2e24:	06f11423          	sh	a5,104(sp)
    2e28:	468d                	li	a3,3
    2e2a:	4a0d                	li	s4,3
    2e2c:	4809                	li	a6,2
            n64 |= (((stbsp__uint64)1) << 52);
    2e2e:	4705                	li	a4,1
    2e30:	1752                	slli	a4,a4,0x34
         if (dp == -1023)
    2e32:	c0100793          	li	a5,-1023
            n64 |= (((stbsp__uint64)1) << 52);
    2e36:	8f49                	or	a4,a4,a0
         if (dp == -1023)
    2e38:	5cf600e3          	beq	a2,a5,3bf8 <stbsp_vsprintfcb+0x1916>
         if (pr < 15)
    2e3c:	4539                	li	a0,14
         n64 <<= (64 - 56);
    2e3e:	00871793          	slli	a5,a4,0x8
         if (pr < 15)
    2e42:	251546e3          	blt	a0,a7,388e <stbsp_vsprintfcb+0x15ac>
            n64 += ((((stbsp__uint64)8) << 56) >> (pr * 4));
    2e46:	4705                	li	a4,1
    2e48:	0028951b          	slliw	a0,a7,0x2
    2e4c:	176e                	slli	a4,a4,0x3b
    2e4e:	00a75733          	srl	a4,a4,a0
    2e52:	973e                	add	a4,a4,a5
         *s++ = h[(n64 >> 60) & 15];
    2e54:	03c75793          	srli	a5,a4,0x3c
    2e58:	97ae                	add	a5,a5,a1
    2e5a:	0007c503          	lbu	a0,0(a5)
         lead[1 + lead[0]] = '0';
    2e5e:	22080793          	addi	a5,a6,544
    2e62:	06010813          	addi	a6,sp,96
    2e66:	97c2                	add	a5,a5,a6
    2e68:	03000813          	li	a6,48
    2e6c:	df078423          	sb	a6,-536(a5)
         lead[2 + lead[0]] = 'x';
    2e70:	22068793          	addi	a5,a3,544
    2e74:	1094                	addi	a3,sp,96
    2e76:	96be                	add	a3,a3,a5
    2e78:	07800793          	li	a5,120
    2e7c:	def68423          	sb	a5,-536(a3)
         lead[0] += 2;
    2e80:	07410423          	sb	s4,104(sp)
         *s++ = h[(n64 >> 60) & 15];
    2e84:	0ca10023          	sb	a0,192(sp)
         if (pr)
    2e88:	740893e3          	bnez	a7,3dce <stbsp_vsprintfcb+0x1aec>
         sn = s;
    2e8c:	0c110793          	addi	a5,sp,193
    2e90:	fcbe                	sd	a5,120(sp)
    2e92:	4701                	li	a4,0
    2e94:	4501                	li	a0,0
    2e96:	4305                	li	t1,1
    2e98:	4685                	li	a3,1
         tail[1] = h[17];
    2e9a:	0115c583          	lbu	a1,17(a1)
            tail[2] = '+';
    2e9e:	02b00793          	li	a5,43
         tail[1] = h[17];
    2ea2:	06b108a3          	sb	a1,113(sp)
         if (dp < 0) {
    2ea6:	00065663          	bgez	a2,2eb2 <stbsp_vsprintfcb+0xbd0>
            dp = -dp;
    2eaa:	40c0063b          	negw	a2,a2
            tail[2] = '-';
    2eae:	02d00793          	li	a5,45
            tail[n] = '0' + dp % 10;
    2eb2:	4829                	li	a6,10
    2eb4:	030665bb          	remw	a1,a2,a6
    2eb8:	06f10923          	sb	a5,114(sp)
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    2ebc:	3e700e93          	li	t4,999
            tail[n] = '0' + dp % 10;
    2ec0:	0305859b          	addiw	a1,a1,48
    2ec4:	0ff5f593          	zext.b	a1,a1
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    2ec8:	18cec3e3          	blt	t4,a2,384e <stbsp_vsprintfcb+0x156c>
    2ecc:	06300e93          	li	t4,99
    2ed0:	54cec1e3          	blt	t4,a2,3c12 <stbsp_vsprintfcb+0x1930>
    2ed4:	4ea5                	li	t4,9
    2ed6:	72ced6e3          	bge	t4,a2,3e02 <stbsp_vsprintfcb+0x1b20>
            dp /= 10;
    2eda:	030647bb          	divw	a5,a2,a6
         tail[0] = (char)n;
    2ede:	4611                	li	a2,4
    2ee0:	06c10823          	sb	a2,112(sp)
            tail[n] = '0' + dp % 10;
    2ee4:	06b10a23          	sb	a1,116(sp)
    2ee8:	4811                	li	a6,4
    2eea:	4f91                	li	t6,4
    2eec:	0307879b          	addiw	a5,a5,48
    2ef0:	06f109a3          	sb	a5,115(sp)
         n = pr + lead[0] + tail[0] + tz;
    2ef4:	006a07bb          	addw	a5,s4,t1
    2ef8:	010787bb          	addw	a5,a5,a6
    2efc:	0117863b          	addw	a2,a5,a7
         dp = (int)(s - sn);
    2f00:	d2aa                	sw	a0,100(sp)
         l = (int)(s - (num + 64));
    2f02:	d0b6                	sw	a3,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    2f04:	87b2                	mv	a5,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    2f06:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    2f0a:	835a                	mv	t1,s6
    2f0c:	00cb5363          	bge	s6,a2,2f12 <stbsp_vsprintfcb+0xc30>
    2f10:	8332                	mv	t1,a2
         cs = 1 + (3 << 24);
    2f12:	030002b7          	lui	t0,0x3000
         fw -= n;
    2f16:	40f3033b          	subw	t1,t1,a5
         cs = 1 + (3 << 24);
    2f1a:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff71c1>
         s = num + 64;
    2f1c:	0c010a93          	addi	s5,sp,192
         goto scopy;
    2f20:	b311                	j	2c24 <stbsp_vsprintfcb+0x942>
         h = (f[0] == 'B') ? hexu : hex;
    2f22:	04200713          	li	a4,66
    2f26:	00005817          	auipc	a6,0x5
    2f2a:	0aa80813          	addi	a6,a6,170 # 7fd0 <hex.0>
    2f2e:	6ce78963          	beq	a5,a4,3600 <stbsp_vsprintfcb+0x131e>
         if (fl & STBSP__LEADING_0X) {
    2f32:	008e7793          	andi	a5,t3,8
    2f36:	66079e63          	bnez	a5,35b2 <stbsp_vsprintfcb+0x12d0>
         lead[0] = 0;
    2f3a:	06010423          	sb	zero,104(sp)
         l = (8 << 4) | (1 << 8);
    2f3e:	18000793          	li	a5,384
    2f42:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__INTMAX) {
    2f44:	020e7713          	andi	a4,t3,32
         goto radixnum;
    2f48:	b979                	j	2be6 <stbsp_vsprintfcb+0x904>
         *s = (char)va_arg(va, int);
    2f4a:	000ba783          	lw	a5,0(s7)
         l = 1;
    2f4e:	4705                	li	a4,1
    2f50:	d0ba                	sw	a4,96(sp)
         *s = (char)va_arg(va, int);
    2f52:	26f10fa3          	sb	a5,639(sp)
    2f56:	008b8793          	addi	a5,s7,8
         lead[0] = 0;
    2f5a:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    2f5e:	06010823          	sb	zero,112(sp)
         dp = 0;
    2f62:	d282                	sw	zero,100(sp)
         *s = (char)va_arg(va, int);
    2f64:	e0be                	sd	a5,64(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    2f66:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    2f6a:	835a                	mv	t1,s6
    2f6c:	69605063          	blez	s6,35ec <stbsp_vsprintfcb+0x130a>
         fw -= n;
    2f70:	337d                	addiw	t1,t1,-1
         goto scopy;
    2f72:	4701                	li	a4,0
    2f74:	4f81                	li	t6,0
    2f76:	4685                	li	a3,1
    2f78:	4a01                	li	s4,0
         cs = 0;
    2f7a:	4281                	li	t0,0
         s = num + STBSP__NUMSZ - 1;
    2f7c:	27f10a93          	addi	s5,sp,639
      tz = 0;
    2f80:	4881                	li	a7,0
         goto scopy;
    2f82:	b14d                	j	2c24 <stbsp_vsprintfcb+0x942>
         fv = va_arg(va, double);
    2f84:	008b8713          	addi	a4,s7,8
         if (fl & STBSP__METRIC_SUFFIX) {
    2f88:	100e7793          	andi	a5,t3,256
         fv = va_arg(va, double);
    2f8c:	e0ba                	sd	a4,64(sp)
    2f8e:	000bb507          	fld	fa0,0(s7)
         if (fl & STBSP__METRIC_SUFFIX) {
    2f92:	be0795e3          	bnez	a5,2b7c <stbsp_vsprintfcb+0x89a>
         if (pr == -1)
    2f96:	57fd                	li	a5,-1
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    2f98:	0008871b          	sext.w	a4,a7
         if (pr == -1)
    2f9c:	00f89463          	bne	a7,a5,2fa4 <stbsp_vsprintfcb+0xcc2>
    2fa0:	4719                	li	a4,6
            pr = 6; // default is 6
    2fa2:	4899                	li	a7,6
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    2fa4:	10d4                	addi	a3,sp,100
    2fa6:	0110                	addi	a2,sp,128
    2fa8:	108c                	addi	a1,sp,96
    2faa:	18a8                	addi	a0,sp,120
    2fac:	f01e                	sd	t2,32(sp)
    2fae:	ec72                	sd	t3,24(sp)
    2fb0:	e846                	sd	a7,16(sp)
    2fb2:	a4cfe0ef          	jal	11fe <stbsp__real_to_str>
    2fb6:	6e62                	ld	t3,24(sp)
    2fb8:	68c2                	ld	a7,16(sp)
    2fba:	7382                	ld	t2,32(sp)
         if (dp == STBSP__SPECIAL) {
    2fbc:	5796                	lw	a5,100(sp)
            if ((stbsp__int32)(l + n) > pr)
    2fbe:	5686                	lw	a3,96(sp)
   if (fl & STBSP__NEGATIVE) {
    2fc0:	080e7293          	andi	t0,t3,128
         if (stbsp__real_to_str(&sn, &l, num, &dp, fv, pr))
    2fc4:	e00500e3          	beqz	a0,2dc4 <stbsp_vsprintfcb+0xae2>
            fl |= STBSP__NEGATIVE;
    2fc8:	080e6e13          	ori	t3,t3,128
         tail[0] = 0;
    2fcc:	06010823          	sb	zero,112(sp)
      sign[0] = 1;
    2fd0:	670d                	lui	a4,0x3
    2fd2:	d0170713          	addi	a4,a4,-767 # 2d01 <stbsp_vsprintfcb+0xa1f>
    2fd6:	06e11423          	sh	a4,104(sp)
         if (dp == STBSP__SPECIAL) {
    2fda:	671d                	lui	a4,0x7
    2fdc:	7ce78963          	beq	a5,a4,37ae <stbsp_vsprintfcb+0x14cc>
         if (dp <= 0) {
    2fe0:	46f05fe3          	blez	a5,3c5e <stbsp_vsprintfcb+0x197c>
            cs = (fl & STBSP__TRIPLET_COMMA) ? ((600 - (stbsp__uint32)dp) % 3) : 0;
    2fe4:	040e7313          	andi	t1,t3,64
    2fe8:	00078e9b          	sext.w	t4,a5
    2fec:	4581                	li	a1,0
    2fee:	00030963          	beqz	t1,3000 <stbsp_vsprintfcb+0xd1e>
    2ff2:	25800593          	li	a1,600
    2ff6:	41d585bb          	subw	a1,a1,t4
    2ffa:	470d                	li	a4,3
    2ffc:	02e5f5bb          	remuw	a1,a1,a4
                     *s++ = stbsp__comma;
    3000:	00005a17          	auipc	s4,0x5
    3004:	ee8a0a13          	addi	s4,s4,-280 # 7ee8 <stbsp__digitpair>
            s = (char *)sn;
    3008:	7f66                	ld	t5,120(sp)
                     *s++ = stbsp__comma;
    300a:	0cda4283          	lbu	t0,205(s4)
         s = num + 64;
    300e:	0c010a93          	addi	s5,sp,192
            if ((stbsp__uint32)dp >= l) {
    3012:	44defb63          	bgeu	t4,a3,3468 <stbsp_vsprintfcb+0x1186>
               n = 0;
    3016:	4501                	li	a0,0
         s = num + 64;
    3018:	8756                	mv	a4,s5
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    301a:	4b91                	li	s7,4
    301c:	a015                	j	3040 <stbsp_vsprintfcb+0xd5e>
    301e:	8642                	mv	a2,a6
    3020:	883a                	mv	a6,a4
    3022:	8732                	mv	a4,a2
                     *s++ = sn[n];
    3024:	02051613          	slli	a2,a0,0x20
    3028:	9201                	srli	a2,a2,0x20
    302a:	967a                	add	a2,a2,t5
    302c:	00064f83          	lbu	t6,0(a2)
                     ++n;
    3030:	0015061b          	addiw	a2,a0,1
    3034:	0006051b          	sext.w	a0,a2
                     *s++ = sn[n];
    3038:	fff70fa3          	sb	t6,-1(a4) # 6fff <STDIN_FD+0x6ff>
                     if (n >= (stbsp__uint32)dp)
    303c:	7bd57563          	bgeu	a0,t4,37e6 <stbsp_vsprintfcb+0x1504>
                     *s++ = stbsp__comma;
    3040:	00170813          	addi	a6,a4,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3044:	fc030de3          	beqz	t1,301e <stbsp_vsprintfcb+0xd3c>
    3048:	2585                	addiw	a1,a1,1
    304a:	fd759ae3          	bne	a1,s7,301e <stbsp_vsprintfcb+0xd3c>
                     *s++ = stbsp__comma;
    304e:	fe580fa3          	sb	t0,-1(a6)
    3052:	0709                	addi	a4,a4,2
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3054:	4585                	li	a1,1
    3056:	b7f9                	j	3024 <stbsp_vsprintfcb+0xd42>
         *d = tlen + (int)(bf - buf);
    3058:	000bb703          	ld	a4,0(s7)
    305c:	412407b3          	sub	a5,s0,s2
    3060:	01a787bb          	addw	a5,a5,s10
         int *d = va_arg(va, int *);
    3064:	008b8693          	addi	a3,s7,8
    3068:	e0b6                	sd	a3,64(sp)
         *d = tlen + (int)(bf - buf);
    306a:	c31c                	sw	a5,0(a4)
      } break;
    306c:	bae5                	j	2a64 <stbsp_vsprintfcb+0x782>
         if (fl & STBSP__LEADING_0X) {
    306e:	008e7793          	andi	a5,t3,8
    3072:	50079b63          	bnez	a5,3588 <stbsp_vsprintfcb+0x12a6>
         lead[0] = 0;
    3076:	06010423          	sb	zero,104(sp)
         l = (3 << 4) | (3 << 8);
    307a:	33000793          	li	a5,816
    307e:	d0be                	sw	a5,96(sp)
         if (fl & STBSP__INTMAX) {
    3080:	020e7713          	andi	a4,t3,32
         h = hexu;
    3084:	00005817          	auipc	a6,0x5
    3088:	f3480813          	addi	a6,a6,-204 # 7fb8 <hexu.1>
         goto radixnum;
    308c:	bea9                	j	2be6 <stbsp_vsprintfcb+0x904>
         fl &= ~STBSP__LEADINGZERO; // 'p' only prints the pointer with zeros
    308e:	fefe7e13          	andi	t3,t3,-17
    3092:	020e6e13          	ori	t3,t3,32
    3096:	02000713          	li	a4,32
         pr = sizeof(void *) * 2;
    309a:	48c1                	li	a7,16
         h = (f[0] == 'X') ? hexu : hex;
    309c:	00005817          	auipc	a6,0x5
    30a0:	f3480813          	addi	a6,a6,-204 # 7fd0 <hex.0>
    30a4:	be05                	j	2bd4 <stbsp_vsprintfcb+0x8f2>
         s = va_arg(va, char *);
    30a6:	000bba83          	ld	s5,0(s7)
    30aa:	008b8793          	addi	a5,s7,8
    30ae:	e0be                	sd	a5,64(sp)
         if (s == 0)
    30b0:	360a8ee3          	beqz	s5,3c2c <stbsp_vsprintfcb+0x194a>
      if (((stbsp__uintptr)sn & 3) == 0)
    30b4:	003af793          	andi	a5,s5,3
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    30b8:	5208c663          	bltz	a7,35e4 <stbsp_vsprintfcb+0x1302>
    30bc:	0008869b          	sext.w	a3,a7
      if (((stbsp__uintptr)sn & 3) == 0)
    30c0:	2a0782e3          	beqz	a5,3b64 <stbsp_vsprintfcb+0x1882>
      if (!limit || *sn == 0)
    30c4:	5a068b63          	beqz	a3,367a <stbsp_vsprintfcb+0x1398>
      if (((stbsp__uintptr)sn & 3) == 0)
    30c8:	87d6                	mv	a5,s5
    30ca:	a801                	j	30da <stbsp_vsprintfcb+0xdf8>
      ++sn;
    30cc:	0785                	addi	a5,a5,1
      if (((stbsp__uintptr)sn & 3) == 0)
    30ce:	0037f713          	andi	a4,a5,3
      --limit;
    30d2:	36fd                	addiw	a3,a3,-1
      if (((stbsp__uintptr)sn & 3) == 0)
    30d4:	280709e3          	beqz	a4,3b66 <stbsp_vsprintfcb+0x1884>
      if (!limit || *sn == 0)
    30d8:	c681                	beqz	a3,30e0 <stbsp_vsprintfcb+0xdfe>
    30da:	0007c703          	lbu	a4,0(a5)
    30de:	f77d                	bnez	a4,30cc <stbsp_vsprintfcb+0xdea>
         return (stbsp__uint32)(sn - s);
    30e0:	415787b3          	sub	a5,a5,s5
    30e4:	0007869b          	sext.w	a3,a5
         if (pr < (stbsp__int32)l)
    30e8:	fff6c713          	not	a4,a3
    30ec:	977d                	srai	a4,a4,0x3f
    30ee:	8f7d                	and	a4,a4,a5
    30f0:	0007079b          	sext.w	a5,a4
         n = pr + lead[0] + tail[0] + tz;
    30f4:	863e                	mv	a2,a5
         pr -= l;
    30f6:	9f15                	subw	a4,a4,a3
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    30f8:	d0b6                	sw	a3,96(sp)
         lead[0] = 0;
    30fa:	06010423          	sb	zero,104(sp)
         tail[0] = 0;
    30fe:	06010823          	sb	zero,112(sp)
         dp = 0;
    3102:	d282                	sw	zero,100(sp)
         if ((fl & STBSP__LEFTJUST) == 0) {
    3104:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    3108:	835a                	mv	t1,s6
    310a:	00fb5363          	bge	s6,a5,3110 <stbsp_vsprintfcb+0xe2e>
    310e:	833e                	mv	t1,a5
         fw -= n;
    3110:	40c3033b          	subw	t1,t1,a2
         goto scopy;
    3114:	4f81                	li	t6,0
    3116:	4a01                	li	s4,0
         cs = 0;
    3118:	4281                	li	t0,0
      tz = 0;
    311a:	4881                	li	a7,0
         goto scopy;
    311c:	b621                	j	2c24 <stbsp_vsprintfcb+0x942>
                     *bf++ = stbsp__comma;
    311e:	87b2                	mv	a5,a2
                     cs = 0;
    3120:	4a01                	li	s4,0
    3122:	e44ff06f          	j	2766 <stbsp_vsprintfcb+0x484>
               lead[0] -= (char)i;
    3126:	06010423          	sb	zero,104(sp)
               while (i) {
    312a:	d38ff06f          	j	2662 <stbsp_vsprintfcb+0x380>
            lead[0] -= (char)i;
    312e:	06010423          	sb	zero,104(sp)
            while (i) {
    3132:	ed8ff06f          	j	280a <stbsp_vsprintfcb+0x528>
            while (i >= 4) {
    3136:	06fadc63          	bge	s5,a5,31ae <stbsp_vsprintfcb+0xecc>
            tz -= i;
    313a:	8722                	mv	a4,s0
    313c:	0007851b          	sext.w	a0,a5
            while (i >= 4) {
    3140:	008785bb          	addw	a1,a5,s0
               *(stbsp__uint32 *)bf = 0x30303030;
    3144:	01672023          	sw	s6,0(a4)
               bf += 4;
    3148:	0711                	addi	a4,a4,4
            while (i >= 4) {
    314a:	40e5863b          	subw	a2,a1,a4
    314e:	fecacbe3          	blt	s5,a2,3144 <stbsp_vsprintfcb+0xe62>
    3152:	ffc5061b          	addiw	a2,a0,-4
    3156:	0026561b          	srliw	a2,a2,0x2
    315a:	0016071b          	addiw	a4,a2,1
    315e:	37f1                	addiw	a5,a5,-4
    3160:	0026161b          	slliw	a2,a2,0x2
    3164:	070a                	slli	a4,a4,0x2
    3166:	9722                	add	a4,a4,s0
    3168:	9f91                	subw	a5,a5,a2
            while (i) {
    316a:	843a                	mv	s0,a4
    316c:	80078de3          	beqz	a5,2986 <stbsp_vsprintfcb+0x6a4>
    3170:	1782                	slli	a5,a5,0x20
    3172:	9381                	srli	a5,a5,0x20
    3174:	00f70433          	add	s0,a4,a5
               *bf++ = '0';
    3178:	0705                	addi	a4,a4,1
    317a:	ff470fa3          	sb	s4,-1(a4)
            while (i) {
    317e:	fe871de3          	bne	a4,s0,3178 <stbsp_vsprintfcb+0xe96>
    3182:	805ff06f          	j	2986 <stbsp_vsprintfcb+0x6a4>
               stbsp__cb_buf_clamp(i, pr);
    3186:	85ce                	mv	a1,s3
               if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    3188:	4981                	li	s3,0
    318a:	dc049263          	bnez	s1,274e <stbsp_vsprintfcb+0x46c>
    318e:	b8d5                	j	2a82 <stbsp_vsprintfcb+0x7a0>
            STBSP__UNALIGNED(while (i >= 4) {
    3190:	4401                	li	s0,0
    3192:	85be                	mv	a1,a5
    3194:	f0ea4b63          	blt	s4,a4,28aa <stbsp_vsprintfcb+0x5c8>
    3198:	f42ff06f          	j	28da <stbsp_vsprintfcb+0x5f8>
               if ((((stbsp__uintptr)bf) & 3) == 0)
    319c:	00347713          	andi	a4,s0,3
            stbsp__cb_buf_clamp(i, tz);
    31a0:	87c6                	mv	a5,a7
            tz -= i;
    31a2:	4881                	li	a7,0
               if ((((stbsp__uintptr)bf) & 3) == 0)
    31a4:	fc071c63          	bnez	a4,297c <stbsp_vsprintfcb+0x69a>
            while (i >= 4) {
    31a8:	470d                	li	a4,3
    31aa:	f8f748e3          	blt	a4,a5,313a <stbsp_vsprintfcb+0xe58>
    31ae:	8722                	mv	a4,s0
    31b0:	b7c1                	j	3170 <stbsp_vsprintfcb+0xe8e>
            tail[0] -= (char)i;
    31b2:	06010823          	sb	zero,112(sp)
            while (i) {
    31b6:	b0b9                	j	2a04 <stbsp_vsprintfcb+0x722>
                  while (i >= 4) {
    31b8:	478d                	li	a5,3
    31ba:	8622                	mv	a2,s0
    31bc:	d8b7d963          	bge	a5,a1,274e <stbsp_vsprintfcb+0x46c>
    31c0:	ffc5839b          	addiw	t2,a1,-4
    31c4:	0023d79b          	srliw	a5,t2,0x2
    31c8:	0017859b          	addiw	a1,a5,1
    31cc:	058a                	slli	a1,a1,0x2
    31ce:	942e                	add	s0,s0,a1
                     *(stbsp__uint32 *)bf = 0x30303030;
    31d0:	01762023          	sw	s7,0(a2)
                     bf += 4;
    31d4:	0611                	addi	a2,a2,4
                  while (i >= 4) {
    31d6:	fe861de3          	bne	a2,s0,31d0 <stbsp_vsprintfcb+0xeee>
    31da:	0027979b          	slliw	a5,a5,0x2
    31de:	40f385bb          	subw	a1,t2,a5
    31e2:	d68ff06f          	j	274a <stbsp_vsprintfcb+0x468>
            while (i) {
    31e6:	85be                	mv	a1,a5
    31e8:	ee071963          	bnez	a4,28da <stbsp_vsprintfcb+0x5f8>
    31ec:	f16ff06f          	j	2902 <stbsp_vsprintfcb+0x620>
    31f0:	2c013a03          	ld	s4,704(sp)
    31f4:	2b813a83          	ld	s5,696(sp)
    31f8:	2b013b03          	ld	s6,688(sp)
    31fc:	8ca2                	mv	s9,s0
    31fe:	a04ff06f          	j	2402 <stbsp_vsprintfcb+0x120>
            stbsp__chk_cb_buf(1);
    3202:	2601                	sext.w	a2,a2
    3204:	1fe00793          	li	a5,510
    3208:	f8c7c563          	blt	a5,a2,2992 <stbsp_vsprintfcb+0x6b0>
    320c:	f3eff06f          	j	294a <stbsp_vsprintfcb+0x668>
               fl &= ~STBSP__TRIPLET_COMMA; // if no leading zeros, then no commas
    3210:	fbfe7e13          	andi	t3,t3,-65
         if (fw + pr) {
    3214:	006707bb          	addw	a5,a4,t1
               fl &= ~STBSP__TRIPLET_COMMA; // if no leading zeros, then no commas
    3218:	2e01                	sext.w	t3,t3
         if (fw + pr) {
    321a:	a0078be3          	beqz	a5,2c30 <stbsp_vsprintfcb+0x94e>
               while (fw > 0) {
    321e:	be605663          	blez	t1,260a <stbsp_vsprintfcb+0x328>
                     *(stbsp__uint32 *)bf = 0x20202020;
    3222:	20202837          	lui	a6,0x20202
                  stbsp__cb_buf_clamp(i, fw);
    3226:	854a                	mv	a0,s2
    3228:	894e                	mv	s2,s3
    322a:	69a2                	ld	s3,8(sp)
                     *(stbsp__uint32 *)bf = 0x20202020;
    322c:	02080813          	addi	a6,a6,32 # 20202020 <_ZSt4cerr+0x201f91e0>
                  stbsp__cb_buf_clamp(i, fw);
    3230:	ec52                	sd	s4,24(sp)
    3232:	f426                	sd	s1,40(sp)
    3234:	87a2                	mv	a5,s0
    3236:	84ea                	mv	s1,s10
                  stbsp__chk_cb_buf(1);
    3238:	1fe00f13          	li	t5,510
                  stbsp__cb_buf_clamp(i, fw);
    323c:	8d6e                	mv	s10,s11
                     *bf++ = ' ';
    323e:	02000b13          	li	s6,32
                  stbsp__cb_buf_clamp(i, fw);
    3242:	8de6                	mv	s11,s9
                  while (i >= 4) {
    3244:	4b8d                	li	s7,3
                  stbsp__cb_buf_clamp(i, fw);
    3246:	20000e93          	li	t4,512
    324a:	e846                	sd	a7,16(sp)
    324c:	f07e                	sd	t6,32(sp)
    324e:	f836                	sd	a3,48(sp)
    3250:	e4f2                	sd	t3,72(sp)
    3252:	e8ba                	sd	a4,80(sp)
    3254:	ec96                	sd	t0,88(sp)
    3256:	841a                	mv	s0,t1
    3258:	8a42                	mv	s4,a6
    325a:	8c9e                	mv	s9,t2
    325c:	0c090063          	beqz	s2,331c <stbsp_vsprintfcb+0x103a>
    3260:	40a78633          	sub	a2,a5,a0
    3264:	40ce873b          	subw	a4,t4,a2
    3268:	86ba                	mv	a3,a4
    326a:	00e45363          	bge	s0,a4,3270 <stbsp_vsprintfcb+0xf8e>
    326e:	86a2                	mv	a3,s0
    3270:	0006871b          	sext.w	a4,a3
                  fw -= i;
    3274:	9c15                	subw	s0,s0,a3
                  while (i) {
    3276:	e719                	bnez	a4,3284 <stbsp_vsprintfcb+0xfa2>
    3278:	a095                	j	32dc <stbsp_vsprintfcb+0xffa>
                     *bf++ = ' ';
    327a:	01678023          	sb	s6,0(a5)
                     --i;
    327e:	377d                	addiw	a4,a4,-1
                     *bf++ = ' ';
    3280:	0785                	addi	a5,a5,1
                  while (i) {
    3282:	cb29                	beqz	a4,32d4 <stbsp_vsprintfcb+0xff2>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    3284:	0037f693          	andi	a3,a5,3
    3288:	faed                	bnez	a3,327a <stbsp_vsprintfcb+0xf98>
                  while (i >= 4) {
    328a:	86be                	mv	a3,a5
    328c:	00070f9b          	sext.w	t6,a4
    3290:	00f705bb          	addw	a1,a4,a5
    3294:	02ebd763          	bge	s7,a4,32c2 <stbsp_vsprintfcb+0xfe0>
                     *(stbsp__uint32 *)bf = 0x20202020;
    3298:	0146a023          	sw	s4,0(a3)
                     bf += 4;
    329c:	0691                	addi	a3,a3,4
                  while (i >= 4) {
    329e:	40d5863b          	subw	a2,a1,a3
    32a2:	fecbcbe3          	blt	s7,a2,3298 <stbsp_vsprintfcb+0xfb6>
    32a6:	ffcf861b          	addiw	a2,t6,-4 # fffffffff7fffffc <_ZSt4cerr+0xfffffffff7ff71bc>
    32aa:	0026561b          	srliw	a2,a2,0x2
    32ae:	0016069b          	addiw	a3,a2,1
    32b2:	3771                	addiw	a4,a4,-4
    32b4:	0026161b          	slliw	a2,a2,0x2
    32b8:	068a                	slli	a3,a3,0x2
    32ba:	96be                	add	a3,a3,a5
    32bc:	9f11                	subw	a4,a4,a2
                  while (i) {
    32be:	87b6                	mv	a5,a3
    32c0:	cb11                	beqz	a4,32d4 <stbsp_vsprintfcb+0xff2>
    32c2:	1702                	slli	a4,a4,0x20
    32c4:	9301                	srli	a4,a4,0x20
    32c6:	00e687b3          	add	a5,a3,a4
                     *bf++ = ' ';
    32ca:	0685                	addi	a3,a3,1
    32cc:	ff668fa3          	sb	s6,-1(a3)
                  while (i) {
    32d0:	fef69de3          	bne	a3,a5,32ca <stbsp_vsprintfcb+0xfe8>
                  stbsp__chk_cb_buf(1);
    32d4:	40a78633          	sub	a2,a5,a0
    32d8:	00090e63          	beqz	s2,32f4 <stbsp_vsprintfcb+0x1012>
    32dc:	2601                	sext.w	a2,a2
    32de:	00cf5b63          	bge	t5,a2,32f4 <stbsp_vsprintfcb+0x1012>
    32e2:	85ce                	mv	a1,s3
    32e4:	9cb1                	addw	s1,s1,a2
    32e6:	9902                	jalr	s2
    32e8:	c541                	beqz	a0,3370 <stbsp_vsprintfcb+0x108e>
    32ea:	87aa                	mv	a5,a0
    32ec:	20000e93          	li	t4,512
    32f0:	1fe00f13          	li	t5,510
               while (fw > 0) {
    32f4:	f68044e3          	bgtz	s0,325c <stbsp_vsprintfcb+0xf7a>
    32f8:	8322                	mv	t1,s0
    32fa:	89ca                	mv	s3,s2
    32fc:	83e6                	mv	t2,s9
    32fe:	68c2                	ld	a7,16(sp)
    3300:	8cee                	mv	s9,s11
    3302:	6a62                	ld	s4,24(sp)
    3304:	8dea                	mv	s11,s10
    3306:	7f82                	ld	t6,32(sp)
    3308:	8d26                	mv	s10,s1
    330a:	76c2                	ld	a3,48(sp)
    330c:	6e26                	ld	t3,72(sp)
    330e:	6746                	ld	a4,80(sp)
    3310:	62e6                	ld	t0,88(sp)
    3312:	74a2                	ld	s1,40(sp)
    3314:	892a                	mv	s2,a0
    3316:	843e                	mv	s0,a5
    3318:	af2ff06f          	j	260a <stbsp_vsprintfcb+0x328>
                  stbsp__cb_buf_clamp(i, fw);
    331c:	8722                	mv	a4,s0
    331e:	4401                	li	s0,0
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    3320:	b795                	j	3284 <stbsp_vsprintfcb+0xfa2>
            n64 = va_arg(va, stbsp__uint32);
    3322:	000be683          	lwu	a3,0(s7)
    3326:	b0f9                	j	2bf4 <stbsp_vsprintfcb+0x912>
    3328:	2c013a03          	ld	s4,704(sp)
    332c:	2b813a83          	ld	s5,696(sp)
    3330:	2b013b03          	ld	s6,688(sp)
    3334:	8cca                	mv	s9,s2
    3336:	8ccff06f          	j	2402 <stbsp_vsprintfcb+0x120>
    333a:	8cd6                	mv	s9,s5
    333c:	2c013a03          	ld	s4,704(sp)
    3340:	2b813a83          	ld	s5,696(sp)
    3344:	2b013b03          	ld	s6,688(sp)
    3348:	8baff06f          	j	2402 <stbsp_vsprintfcb+0x120>
    334c:	2c013a03          	ld	s4,704(sp)
    3350:	2b813a83          	ld	s5,696(sp)
    3354:	2b013b03          	ld	s6,688(sp)
    3358:	8cea                	mv	s9,s10
    335a:	8a8ff06f          	j	2402 <stbsp_vsprintfcb+0x120>
                  while (i) {
    335e:	85a2                	mv	a1,s0
    3360:	c12ff06f          	j	2772 <stbsp_vsprintfcb+0x490>
                  while (i >= 4) {
    3364:	478d                	li	a5,3
    3366:	8622                	mv	a2,s0
    3368:	e4b7cce3          	blt	a5,a1,31c0 <stbsp_vsprintfcb+0xede>
    336c:	be2ff06f          	j	274e <stbsp_vsprintfcb+0x46c>
    3370:	2c013a03          	ld	s4,704(sp)
    3374:	2b813a83          	ld	s5,696(sp)
    3378:	2b013b03          	ld	s6,688(sp)
    337c:	8ca6                	mv	s9,s1
    337e:	884ff06f          	j	2402 <stbsp_vsprintfcb+0x120>
            lead[2] = h[16];
    3382:	01084683          	lbu	a3,16(a6)
            lead[0] = 2;
    3386:	678d                	lui	a5,0x3
    3388:	0789                	addi	a5,a5,2 # 3002 <stbsp_vsprintfcb+0xd20>
    338a:	06f11423          	sh	a5,104(sp)
            lead[2] = h[16];
    338e:	06d10523          	sb	a3,106(sp)
    3392:	b891                	j	2be6 <stbsp_vsprintfcb+0x904>
    3394:	8cea                	mv	s9,s10
    3396:	86cff06f          	j	2402 <stbsp_vsprintfcb+0x120>
    339a:	4f81                	li	t6,0
    339c:	4a01                	li	s4,0
    339e:	5586                	lw	a1,96(sp)
                  *--s = stbsp__comma;
    33a0:	00005f17          	auipc	t5,0x5
    33a4:	c15f4f03          	lbu	t5,-1003(t5) # 7fb5 <stbsp__comma>
    33a8:	0510                	addi	a2,sp,640
    33aa:	0085d71b          	srliw	a4,a1,0x8
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    33ae:	4305                	li	t1,1
            if (fl & STBSP__TRIPLET_COMMA) {
    33b0:	040e7e93          	andi	t4,t3,64
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    33b4:	0007029b          	sext.w	t0,a4
    33b8:	005317bb          	sllw	a5,t1,t0
    33bc:	37fd                	addiw	a5,a5,-1
    33be:	8ff5                	and	a5,a5,a3
    33c0:	97c2                	add	a5,a5,a6
    33c2:	0007c783          	lbu	a5,0(a5)
            n64 >>= (l >> 8);
    33c6:	0056d6b3          	srl	a3,a3,t0
            *--s = h[n64 & ((1 << (l >> 8)) - 1)];
    33ca:	fff60a93          	addi	s5,a2,-1
    33ce:	fef60fa3          	sb	a5,-1(a2)
            if (!((n64) || ((stbsp__int32)((num + STBSP__NUMSZ) - s) < pr)))
    33d2:	e691                	bnez	a3,33de <stbsp_vsprintfcb+0x10fc>
    33d4:	051c                	addi	a5,sp,640
    33d6:	415787bb          	subw	a5,a5,s5
    33da:	0317dd63          	bge	a5,a7,3414 <stbsp_vsprintfcb+0x1132>
            if (fl & STBSP__TRIPLET_COMMA) {
    33de:	020e8963          	beqz	t4,3410 <stbsp_vsprintfcb+0x112e>
               ++l;
    33e2:	0015879b          	addiw	a5,a1,1
               if ((l & 15) == ((l >> 4) & 15)) {
    33e6:	0047d29b          	srliw	t0,a5,0x4
    33ea:	00f2c2b3          	xor	t0,t0,a5
    33ee:	00f2f293          	andi	t0,t0,15
               ++l;
    33f2:	0007859b          	sext.w	a1,a5
               if ((l & 15) == ((l >> 4) & 15)) {
    33f6:	0087d71b          	srliw	a4,a5,0x8
    33fa:	00029b63          	bnez	t0,3410 <stbsp_vsprintfcb+0x112e>
                  l &= ~15;
    33fe:	9bc1                	andi	a5,a5,-16
    3400:	0007859b          	sext.w	a1,a5
                  *--s = stbsp__comma;
    3404:	ffe60a93          	addi	s5,a2,-2
    3408:	ffe60f23          	sb	t5,-2(a2)
    340c:	0087d71b          	srliw	a4,a5,0x8
    3410:	8656                	mv	a2,s5
    3412:	b74d                	j	33b4 <stbsp_vsprintfcb+0x10d2>
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    3414:	0045d29b          	srliw	t0,a1,0x4
    3418:	0f0006b7          	lui	a3,0xf000
         if (pr < (stbsp__int32)l)
    341c:	0007871b          	sext.w	a4,a5
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    3420:	0182929b          	slliw	t0,t0,0x18
    3424:	00d2f2b3          	and	t0,t0,a3
         n = pr + lead[0] + tail[0] + tz;
    3428:	00ef863b          	addw	a2,t6,a4
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    342c:	d0be                	sw	a5,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    342e:	8fb2                	mv	t6,a2
         cs = (stbsp__uint32)((num + STBSP__NUMSZ) - s) + ((((l >> 4) & 15)) << 24);
    3430:	86be                	mv	a3,a5
    3432:	00f282bb          	addw	t0,t0,a5
         if (fw < (stbsp__int32)n)
    3436:	835a                	mv	t1,s6
    3438:	00cb5363          	bge	s6,a2,343e <stbsp_vsprintfcb+0x115c>
    343c:	8332                	mv	t1,a2
         fw -= n;
    343e:	41f3033b          	subw	t1,t1,t6
         pr -= l;
    3442:	9f1d                	subw	a4,a4,a5
         goto scopy;
    3444:	4f81                	li	t6,0
      tz = 0;
    3446:	4881                	li	a7,0
         goto scopy;
    3448:	fdcff06f          	j	2c24 <stbsp_vsprintfcb+0x942>
    344c:	8cda                	mv	s9,s6
    344e:	2c013a03          	ld	s4,704(sp)
    3452:	2b813a83          	ld	s5,696(sp)
    3456:	2b013b03          	ld	s6,688(sp)
    345a:	fa9fe06f          	j	2402 <stbsp_vsprintfcb+0x120>
            fl |= ((sizeof(void *) == 8) ? STBSP__INTMAX : 0);
    345e:	020e6e13          	ori	t3,t3,32
            ++f;
    3462:	0485                	addi	s1,s1,1
    3464:	864ff06f          	j	24c8 <stbsp_vsprintfcb+0x1e6>
               n = 0;
    3468:	4601                	li	a2,0
         s = num + 64;
    346a:	8756                	mv	a4,s5
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    346c:	4511                	li	a0,4
                     *s++ = stbsp__comma;
    346e:	00170793          	addi	a5,a4,1
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3472:	00030563          	beqz	t1,347c <stbsp_vsprintfcb+0x119a>
    3476:	2585                	addiw	a1,a1,1
    3478:	10a58363          	beq	a1,a0,357e <stbsp_vsprintfcb+0x129c>
    347c:	873e                	mv	a4,a5
                     *s++ = sn[n];
    347e:	02061793          	slli	a5,a2,0x20
    3482:	9381                	srli	a5,a5,0x20
    3484:	97fa                	add	a5,a5,t5
    3486:	0007c803          	lbu	a6,0(a5)
                     ++n;
    348a:	2605                	addiw	a2,a2,1
                     *s++ = sn[n];
    348c:	ff070fa3          	sb	a6,-1(a4)
                     if (n >= l)
    3490:	fcd66fe3          	bltu	a2,a3,346e <stbsp_vsprintfcb+0x118c>
               if (n < (stbsp__uint32)dp) {
    3494:	0bd663e3          	bltu	a2,t4,3d3a <stbsp_vsprintfcb+0x1a58>
               cs = (int)(s - (num + 64)) + (3 << 24); // cs is how many tens
    3498:	415707b3          	sub	a5,a4,s5
    349c:	030002b7          	lui	t0,0x3000
    34a0:	00f282bb          	addw	t0,t0,a5
               if (pr) {
    34a4:	00088a63          	beqz	a7,34b8 <stbsp_vsprintfcb+0x11d6>
                  *s++ = stbsp__period;
    34a8:	0cca4683          	lbu	a3,204(s4)
    34ac:	00170793          	addi	a5,a4,1
         l = (stbsp__uint32)(s - (num + 64));
    34b0:	415787b3          	sub	a5,a5,s5
                  *s++ = stbsp__period;
    34b4:	00d70023          	sb	a3,0(a4)
         if (fl & STBSP__METRIC_SUFFIX) {
    34b8:	100e7713          	andi	a4,t3,256
    34bc:	86f2                	mv	a3,t3
    34be:	2c070163          	beqz	a4,3780 <stbsp_vsprintfcb+0x149e>
            if (fl & STBSP__METRIC_NOSPACE)
    34c2:	40ae5f9b          	sraiw	t6,t3,0xa
    34c6:	001fcf93          	xori	t6,t6,1
    34ca:	001fff93          	andi	t6,t6,1
            tail[1] = ' ';
    34ce:	02000713          	li	a4,32
    34d2:	06e108a3          	sb	a4,113(sp)
            tail[0] = idx;
    34d6:	07f10823          	sb	t6,112(sp)
               if (fl >> 24) { // SI kilo is 'k', JEDEC and SI kibits are 'K'.
    34da:	018e561b          	srliw	a2,t3,0x18
    34de:	018e571b          	srliw	a4,t3,0x18
         n = pr + lead[0] + tail[0] + tz;
    34e2:	000f859b          	sext.w	a1,t6
               if (fl >> 24) { // SI kilo is 'k', JEDEC and SI kibits are 'K'.
    34e6:	c225                	beqz	a2,3546 <stbsp_vsprintfcb+0x1264>
                  if (fl & STBSP__METRIC_1024)
    34e8:	001f859b          	addiw	a1,t6,1
    34ec:	0ff5f613          	zext.b	a2,a1
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    34f0:	1702                	slli	a4,a4,0x20
                  if (fl & STBSP__METRIC_1024)
    34f2:	03469513          	slli	a0,a3,0x34
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    34f6:	85b2                	mv	a1,a2
    34f8:	9301                	srli	a4,a4,0x20
                  if (fl & STBSP__METRIC_1024)
    34fa:	06055ee3          	bgez	a0,3d76 <stbsp_vsprintfcb+0x1a94>
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    34fe:	00003517          	auipc	a0,0x3
    3502:	c8250513          	addi	a0,a0,-894 # 6180 <_GLOBAL__sub_I__ZSt3cin+0x17c>
    3506:	972a                	add	a4,a4,a0
    3508:	00074503          	lbu	a0,0(a4)
                  if (fl & STBSP__METRIC_1024 && !(fl & STBSP__METRIC_JEDEC)) {
    350c:	6709                	lui	a4,0x2
    350e:	80070713          	addi	a4,a4,-2048 # 1800 <stbsp__real_to_str+0x602>
    3512:	8f75                	and	a4,a4,a3
                     tail[idx + 1] = "_KMGT"[fl >> 24];
    3514:	06010813          	addi	a6,sp,96
    3518:	22060693          	addi	a3,a2,544
    351c:	96c2                	add	a3,a3,a6
    351e:	dea68823          	sb	a0,-528(a3) # efffdf0 <_ZSt4cerr+0xeff6fb0>
                  if (fl & STBSP__METRIC_1024 && !(fl & STBSP__METRIC_JEDEC)) {
    3522:	8007071b          	addiw	a4,a4,-2048
    3526:	060715e3          	bnez	a4,3d90 <stbsp_vsprintfcb+0x1aae>
                     tail[idx + 1] = 'i';
    352a:	2f89                	addiw	t6,t6,2
    352c:	0ffff593          	zext.b	a1,t6
    3530:	1094                	addi	a3,sp,96
    3532:	22058713          	addi	a4,a1,544
    3536:	9736                	add	a4,a4,a3
    3538:	06900693          	li	a3,105
    353c:	8fae                	mv	t6,a1
    353e:	ded70823          	sb	a3,-528(a4)
                  tail[0] = idx;
    3542:	07f10823          	sb	t6,112(sp)
         l = (stbsp__uint32)(s - (num + 64));
    3546:	0007869b          	sext.w	a3,a5
         n = pr + lead[0] + tail[0] + tz;
    354a:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    354e:	fff6c713          	not	a4,a3
    3552:	977d                	srai	a4,a4,0x3f
    3554:	8ff9                	and	a5,a5,a4
         n = pr + lead[0] + tail[0] + tz;
    3556:	00fa073b          	addw	a4,s4,a5
    355a:	9f2d                	addw	a4,a4,a1
    355c:	0117063b          	addw	a2,a4,a7
         l = (stbsp__uint32)(s - (num + 64));
    3560:	d0b6                	sw	a3,96(sp)
         n = pr + lead[0] + tail[0] + tz;
    3562:	8732                	mv	a4,a2
         if (pr < (stbsp__int32)l)
    3564:	2781                	sext.w	a5,a5
         if ((fl & STBSP__LEFTJUST) == 0) {
    3566:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    356a:	835a                	mv	t1,s6
    356c:	00cb5363          	bge	s6,a2,3572 <stbsp_vsprintfcb+0x1290>
    3570:	8332                	mv	t1,a2
         fw -= n;
    3572:	40e3033b          	subw	t1,t1,a4
         pr -= l;
    3576:	40d7873b          	subw	a4,a5,a3
         goto scopy;
    357a:	eaaff06f          	j	2c24 <stbsp_vsprintfcb+0x942>
                     *s++ = stbsp__comma;
    357e:	fe578fa3          	sb	t0,-1(a5)
    3582:	0709                	addi	a4,a4,2
                  if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3584:	4585                	li	a1,1
    3586:	bde5                	j	347e <stbsp_vsprintfcb+0x119c>
            lead[0] = 1;
    3588:	678d                	lui	a5,0x3
    358a:	0785                	addi	a5,a5,1 # 3001 <stbsp_vsprintfcb+0xd1f>
    358c:	06f11423          	sh	a5,104(sp)
    3590:	b4ed                	j	307a <stbsp_vsprintfcb+0xd98>
            if ((f[0] != 'u') && (i64 < 0)) {
    3592:	07500693          	li	a3,117
            stbsp__int64 i64 = va_arg(va, stbsp__int64);
    3596:	000bbf03          	ld	t5,0(s7)
            if ((f[0] != 'u') && (i64 < 0)) {
    359a:	dcd78263          	beq	a5,a3,2b5e <stbsp_vsprintfcb+0x87c>
    359e:	dc0f5063          	bgez	t5,2b5e <stbsp_vsprintfcb+0x87c>
               fl |= STBSP__NEGATIVE;
    35a2:	08076713          	ori	a4,a4,128
               n64 = (stbsp__uint64)-i64;
    35a6:	41e00f33          	neg	t5,t5
               fl |= STBSP__NEGATIVE;
    35aa:	00070e1b          	sext.w	t3,a4
    35ae:	db0ff06f          	j	2b5e <stbsp_vsprintfcb+0x87c>
            lead[2] = h[0xb];
    35b2:	00b84703          	lbu	a4,11(a6)
            lead[0] = 2;
    35b6:	678d                	lui	a5,0x3
    35b8:	0789                	addi	a5,a5,2 # 3002 <stbsp_vsprintfcb+0xd20>
    35ba:	06f11423          	sh	a5,104(sp)
            lead[2] = h[0xb];
    35be:	06e10523          	sb	a4,106(sp)
    35c2:	bab5                	j	2f3e <stbsp_vsprintfcb+0xc5c>
      sign[0] = 1;
    35c4:	678d                	lui	a5,0x3
    35c6:	d0178793          	addi	a5,a5,-767 # 2d01 <stbsp_vsprintfcb+0xa1f>
            fl |= STBSP__NEGATIVE;
    35ca:	080e6e13          	ori	t3,t3,128
      sign[0] = 1;
    35ce:	06f11423          	sh	a5,104(sp)
    35d2:	468d                	li	a3,3
    35d4:	4a0d                	li	s4,3
    35d6:	4809                	li	a6,2
    35d8:	b899                	j	2e2e <stbsp_vsprintfcb+0xb4c>
      sign[0] = 1;
    35da:	6709                	lui	a4,0x2
    35dc:	0705                	addi	a4,a4,1 # 2001 <_vscanf_core.constprop.0+0x675>
    35de:	06e11423          	sh	a4,104(sp)
    35e2:	bae5                	j	2fda <stbsp_vsprintfcb+0xcf8>
      if (((stbsp__uintptr)sn & 3) == 0)
    35e4:	0e0780e3          	beqz	a5,3ec4 <stbsp_vsprintfcb+0x1be2>
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    35e8:	56fd                	li	a3,-1
    35ea:	bcf9                	j	30c8 <stbsp_vsprintfcb+0xde6>
         if (fw < (stbsp__int32)n)
    35ec:	4305                	li	t1,1
    35ee:	b249                	j	2f70 <stbsp_vsprintfcb+0xc8e>
            pr = 6; // default is 6
    35f0:	4899                	li	a7,6
    35f2:	b801                	j	2e02 <stbsp_vsprintfcb+0xb20>
         h = (f[0] == 'A') ? hexu : hex;
    35f4:	00005597          	auipc	a1,0x5
    35f8:	9c458593          	addi	a1,a1,-1596 # 7fb8 <hexu.1>
    35fc:	ff6ff06f          	j	2df2 <stbsp_vsprintfcb+0xb10>
         h = (f[0] == 'B') ? hexu : hex;
    3600:	00005817          	auipc	a6,0x5
    3604:	9b880813          	addi	a6,a6,-1608 # 7fb8 <hexu.1>
    3608:	b22d                	j	2f32 <stbsp_vsprintfcb+0xc50>
    360a:	80000737          	lui	a4,0x80000
    360e:	0719                	addi	a4,a4,6 # ffffffff80000006 <_ZSt4cerr+0xffffffff7fff71c6>
            pr = 6; // default is 6
    3610:	4899                	li	a7,6
    3612:	e4eff06f          	j	2c60 <stbsp_vsprintfcb+0x97e>
         h = (f[0] == 'E') ? hexu : hex;
    3616:	00005317          	auipc	t1,0x5
    361a:	9a230313          	addi	t1,t1,-1630 # 7fb8 <hexu.1>
    361e:	e28ff06f          	j	2c46 <stbsp_vsprintfcb+0x964>
    3622:	80000737          	lui	a4,0x80000
    3626:	4a99                	li	s5,6
    3628:	0715                	addi	a4,a4,5 # ffffffff80000005 <_ZSt4cerr+0xffffffff7fff71c5>
            pr = 6;
    362a:	4a19                	li	s4,6
    362c:	ee8ff06f          	j	2d14 <stbsp_vsprintfcb+0xa32>
         h = (f[0] == 'G') ? hexu : hex;
    3630:	00005317          	auipc	t1,0x5
    3634:	98830313          	addi	t1,t1,-1656 # 7fb8 <hexu.1>
    3638:	eb6ff06f          	j	2cee <stbsp_vsprintfcb+0xa0c>
    363c:	7be6                	ld	s7,120(sp)
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    363e:	86c2                	mv	a3,a6
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    3640:	8542                	mv	a0,a6
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    3642:	88d2                	mv	a7,s4
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    3644:	8ade                	mv	s5,s7
            if (pr > (stbsp__int32)l)
    3646:	0005071b          	sext.w	a4,a0
    364a:	01175f63          	bge	a4,a7,3668 <stbsp_vsprintfcb+0x1386>
               pr = l - 1;
    364e:	fff5089b          	addiw	a7,a0,-1
         tail[0] = 0;
    3652:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    3656:	70028c63          	beqz	t0,3d6e <stbsp_vsprintfcb+0x1a8c>
      sign[0] = 1;
    365a:	670d                	lui	a4,0x3
    365c:	d0170713          	addi	a4,a4,-767 # 2d01 <stbsp_vsprintfcb+0xa1f>
    3660:	06e11423          	sh	a4,104(sp)
    3664:	e3aff06f          	j	2c9e <stbsp_vsprintfcb+0x9bc>
            else if (pr)
    3668:	fe0885e3          	beqz	a7,3652 <stbsp_vsprintfcb+0x1370>
               --pr; // when using %e, there is one digit before the decimal
    366c:	38fd                	addiw	a7,a7,-1
    366e:	b7d5                	j	3652 <stbsp_vsprintfcb+0x1370>
      switch (f[0]) {
    3670:	0034c783          	lbu	a5,3(s1)
            f += 3;
    3674:	048d                	addi	s1,s1,3
    3676:	e53fe06f          	j	24c8 <stbsp_vsprintfcb+0x1e6>
      if (!limit || *sn == 0)
    367a:	4601                	li	a2,0
    367c:	4701                	li	a4,0
    367e:	4781                	li	a5,0
         return (stbsp__uint32)(sn - s);
    3680:	bca5                	j	30f8 <stbsp_vsprintfcb+0xe16>
               pr = 1;
    3682:	4885                	li	a7,1
    3684:	cf4ff06f          	j	2b78 <stbsp_vsprintfcb+0x896>
         *s++ = sn[0];
    3688:	000ac703          	lbu	a4,0(s5)
    368c:	0ce10023          	sb	a4,192(sp)
         if (pr)
    3690:	54088563          	beqz	a7,3bda <stbsp_vsprintfcb+0x18f8>
            *s++ = stbsp__period;
    3694:	00005617          	auipc	a2,0x5
    3698:	92064603          	lbu	a2,-1760(a2) # 7fb4 <stbsp__period>
         if ((l - 1) > (stbsp__uint32)pr)
    369c:	fff6871b          	addiw	a4,a3,-1
            *s++ = stbsp__period;
    36a0:	0cc100a3          	sb	a2,193(sp)
         if ((l - 1) > (stbsp__uint32)pr)
    36a4:	0008851b          	sext.w	a0,a7
    36a8:	0007061b          	sext.w	a2,a4
    36ac:	52c57163          	bgeu	a0,a2,3bce <stbsp_vsprintfcb+0x18ec>
            l = pr + 1;
    36b0:	0018869b          	addiw	a3,a7,1
         for (n = 1; n < l; n++)
    36b4:	8746                	mv	a4,a7
    36b6:	02071613          	slli	a2,a4,0x20
    36ba:	9201                	srli	a2,a2,0x20
    36bc:	0c210713          	addi	a4,sp,194
    36c0:	0a85                	addi	s5,s5,1
    36c2:	963a                	add	a2,a2,a4
            *s++ = sn[n];
    36c4:	000ac583          	lbu	a1,0(s5)
    36c8:	0705                	addi	a4,a4,1
         for (n = 1; n < l; n++)
    36ca:	0a85                	addi	s5,s5,1
            *s++ = sn[n];
    36cc:	feb70fa3          	sb	a1,-1(a4)
         for (n = 1; n < l; n++)
    36d0:	fec71ae3          	bne	a4,a2,36c4 <stbsp_vsprintfcb+0x13e2>
         tail[1] = h[0xe];
    36d4:	00e34803          	lbu	a6,14(t1)
         dp -= 1;
    36d8:	fff7871b          	addiw	a4,a5,-1
            tail[2] = '+';
    36dc:	02b00593          	li	a1,43
         tail[1] = h[0xe];
    36e0:	070108a3          	sb	a6,113(sp)
         if (dp < 0) {
    36e4:	00075663          	bgez	a4,36f0 <stbsp_vsprintfcb+0x140e>
            dp = -dp;
    36e8:	4705                	li	a4,1
    36ea:	9f1d                	subw	a4,a4,a5
            tail[2] = '-';
    36ec:	02d00593          	li	a1,45
    36f0:	06b10923          	sb	a1,114(sp)
         n = (dp >= 100) ? 5 : 4;
    36f4:	06300793          	li	a5,99
    36f8:	4ee7d663          	bge	a5,a4,3be4 <stbsp_vsprintfcb+0x1902>
    36fc:	4595                	li	a1,5
    36fe:	4f95                	li	t6,5
    3700:	4e95                	li	t4,5
            tail[n] = '0' + dp % 10;
    3702:	47a9                	li	a5,10
            dp /= 10;
    3704:	02f7433b          	divw	t1,a4,a5
            --n;
    3708:	fffe8f1b          	addiw	t5,t4,-1
            tail[n] = '0' + dp % 10;
    370c:	020f1293          	slli	t0,t5,0x20
    3710:	220e8813          	addi	a6,t4,544
    3714:	06010893          	addi	a7,sp,96
    3718:	0202d293          	srli	t0,t0,0x20
    371c:	01180eb3          	add	t4,a6,a7
    3720:	22028813          	addi	a6,t0,544 # 3000220 <_ZSt4cerr+0x2ff73e0>
    3724:	011802b3          	add	t0,a6,a7
         tail[0] = (char)n;
    3728:	07f10823          	sb	t6,112(sp)
            if (n <= 3)
    372c:	4a0d                	li	s4,3
            tail[n] = '0' + dp % 10;
    372e:	02f7673b          	remw	a4,a4,a5
            dp /= 10;
    3732:	0003081b          	sext.w	a6,t1
            tail[n] = '0' + dp % 10;
    3736:	02f36abb          	remw	s5,t1,a5
    373a:	0307071b          	addiw	a4,a4,48
    373e:	deee8823          	sb	a4,-528(t4)
    3742:	030a871b          	addiw	a4,s5,48
    3746:	dee28823          	sb	a4,-528(t0)
            if (n <= 3)
    374a:	014f0a63          	beq	t5,s4,375e <stbsp_vsprintfcb+0x147c>
            dp /= 10;
    374e:	02f3483b          	divw	a6,t1,a5
            tail[n] = '0' + dp % 10;
    3752:	02f867bb          	remw	a5,a6,a5
    3756:	0307879b          	addiw	a5,a5,48
    375a:	06f109a3          	sb	a5,115(sp)
         tz = pr - (l - 1);
    375e:	2505                	addiw	a0,a0,1
         l = (stbsp__uint32)(s - (num + 64));
    3760:	0c010a93          	addi	s5,sp,192
         cs = 1 + (3 << 24); // how many tens
    3764:	030002b7          	lui	t0,0x3000
         tz = pr - (l - 1);
    3768:	40d508bb          	subw	a7,a0,a3
    376c:	d2c2                	sw	a6,100(sp)
         l = (stbsp__uint32)(s - (num + 64));
    376e:	415607b3          	sub	a5,a2,s5
         cs = 1 + (3 << 24); // how many tens
    3772:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff71c1>
    3774:	bbc9                	j	3546 <stbsp_vsprintfcb+0x1264>
    3776:	fc2e                	sd	a1,56(sp)
    3778:	d0b2                	sw	a2,96(sp)
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    377a:	8536                	mv	a0,a3
    377c:	e2cff06f          	j	2da8 <stbsp_vsprintfcb+0xac6>
      flt_lead:
    3780:	4581                	li	a1,0
    3782:	4f81                	li	t6,0
    3784:	b3c9                	j	3546 <stbsp_vsprintfcb+0x1264>
         n = pr + lead[0] + tail[0] + tz;
    3786:	06814a03          	lbu	s4,104(sp)
    378a:	000a0f9b          	sext.w	t6,s4
    378e:	b901                	j	339e <stbsp_vsprintfcb+0x10bc>
         if ((f[1] == '6') && (f[2] == '4')) {
    3790:	0024c683          	lbu	a3,2(s1)
    3794:	03400713          	li	a4,52
    3798:	00e68463          	beq	a3,a4,37a0 <stbsp_vsprintfcb+0x14be>
    379c:	e2bfe06f          	j	25c6 <stbsp_vsprintfcb+0x2e4>
      switch (f[0]) {
    37a0:	0034c783          	lbu	a5,3(s1)
         fl |= ((sizeof(long) == 8) ? STBSP__INTMAX : 0);
    37a4:	020e6e13          	ori	t3,t3,32
            f += 3;
    37a8:	048d                	addi	s1,s1,3
    37aa:	d1ffe06f          	j	24c8 <stbsp_vsprintfcb+0x1e6>
         if (pr < (stbsp__int32)l)
    37ae:	0006879b          	sext.w	a5,a3
         n = pr + lead[0] + tail[0] + tz;
    37b2:	06814a03          	lbu	s4,104(sp)
         if (pr < (stbsp__int32)l)
    37b6:	fff7c793          	not	a5,a5
    37ba:	97fd                	srai	a5,a5,0x3f
    37bc:	8ff5                	and	a5,a5,a3
         n = pr + lead[0] + tail[0] + tz;
    37be:	00fa063b          	addw	a2,s4,a5
            s = (char *)sn;
    37c2:	7ae6                	ld	s5,120(sp)
         n = pr + lead[0] + tail[0] + tz;
    37c4:	8732                	mv	a4,a2
         if ((fl & STBSP__LEFTJUST) == 0) {
    37c6:	001e7513          	andi	a0,t3,1
         if (pr < (stbsp__int32)l)
    37ca:	2781                	sext.w	a5,a5
         if (fw < (stbsp__int32)n)
    37cc:	835a                	mv	t1,s6
    37ce:	00cb5363          	bge	s6,a2,37d4 <stbsp_vsprintfcb+0x14f2>
    37d2:	8332                	mv	t1,a2
         fw -= n;
    37d4:	40e3033b          	subw	t1,t1,a4
            goto scopy;
    37d8:	4f81                	li	t6,0
         pr -= l;
    37da:	40d7873b          	subw	a4,a5,a3
            cs = 0;
    37de:	4281                	li	t0,0
      tz = 0;
    37e0:	4881                	li	a7,0
            goto scopy;
    37e2:	c42ff06f          	j	2c24 <stbsp_vsprintfcb+0x942>
               cs = (int)(s - (num + 64)) + (3 << 24); // cs is how many tens
    37e6:	415705b3          	sub	a1,a4,s5
    37ea:	030002b7          	lui	t0,0x3000
    37ee:	00b282bb          	addw	t0,t0,a1
               l = pr - n;
    37f2:	0008859b          	sext.w	a1,a7
               if (pr)
    37f6:	42088763          	beqz	a7,3c24 <stbsp_vsprintfcb+0x1942>
                  *s++ = stbsp__period;
    37fa:	0cca4f83          	lbu	t6,204(s4)
               if ((l - dp) > (stbsp__uint32)pr)
    37fe:	41d6833b          	subw	t1,a3,t4
                  *s++ = stbsp__period;
    3802:	00280713          	addi	a4,a6,2
    3806:	01f800a3          	sb	t6,1(a6)
               if ((l - dp) > (stbsp__uint32)pr)
    380a:	4065ed63          	bltu	a1,t1,3c24 <stbsp_vsprintfcb+0x1942>
               while (n < l) {
    380e:	5ed57863          	bgeu	a0,a3,3dfe <stbsp_vsprintfcb+0x1b1c>
    3812:	40c687bb          	subw	a5,a3,a2
    3816:	37fd                	addiw	a5,a5,-1
    3818:	1782                	slli	a5,a5,0x20
    381a:	9381                	srli	a5,a5,0x20
    381c:	1602                	slli	a2,a2,0x20
    381e:	9201                	srli	a2,a2,0x20
    3820:	0785                	addi	a5,a5,1
    3822:	967a                	add	a2,a2,t5
    3824:	97ba                	add	a5,a5,a4
                  *s++ = sn[n];
    3826:	00064503          	lbu	a0,0(a2)
    382a:	0705                	addi	a4,a4,1
               while (n < l) {
    382c:	0605                	addi	a2,a2,1
                  *s++ = sn[n];
    382e:	fea70fa3          	sb	a0,-1(a4)
               while (n < l) {
    3832:	fef71ae3          	bne	a4,a5,3826 <stbsp_vsprintfcb+0x1544>
               tz = pr - (l - dp);
    3836:	01d585bb          	addw	a1,a1,t4
    383a:	40d588bb          	subw	a7,a1,a3
         l = (stbsp__uint32)(s - (num + 64));
    383e:	415787b3          	sub	a5,a5,s5
    3842:	b99d                	j	34b8 <stbsp_vsprintfcb+0x11d6>
            fl |= STBSP__NEGATIVE;
    3844:	080e6e13          	ori	t3,t3,128
         tail[0] = 0;
    3848:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    384c:	b539                	j	365a <stbsp_vsprintfcb+0x1378>
         tail[0] = (char)n;
    384e:	4799                	li	a5,6
            tail[n] = '0' + dp % 10;
    3850:	06b10b23          	sb	a1,118(sp)
         tail[0] = (char)n;
    3854:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    3858:	4819                	li	a6,6
    385a:	4f99                	li	t6,6
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    385c:	4599                	li	a1,6
            dp /= 10;
    385e:	4f29                	li	t5,10
            if (n <= 3)
    3860:	428d                	li	t0,3
    3862:	87b2                	mv	a5,a2
            dp /= 10;
    3864:	03e7c7bb          	divw	a5,a5,t5
            --n;
    3868:	35fd                	addiw	a1,a1,-1
            tail[n] = '0' + dp % 10;
    386a:	02059613          	slli	a2,a1,0x20
    386e:	9201                	srli	a2,a2,0x20
    3870:	06010e93          	addi	t4,sp,96
    3874:	22060613          	addi	a2,a2,544
    3878:	9676                	add	a2,a2,t4
    387a:	03e7eebb          	remw	t4,a5,t5
    387e:	030e8e9b          	addiw	t4,t4,48
    3882:	dfd60823          	sb	t4,-528(a2)
            if (n <= 3)
    3886:	fc559fe3          	bne	a1,t0,3864 <stbsp_vsprintfcb+0x1582>
    388a:	e6aff06f          	j	2ef4 <stbsp_vsprintfcb+0xc12>
         *s++ = h[(n64 >> 60) & 15];
    388e:	93f1                	srli	a5,a5,0x3c
    3890:	97ae                	add	a5,a5,a1
    3892:	0007c303          	lbu	t1,0(a5)
         lead[1 + lead[0]] = '0';
    3896:	1088                	addi	a0,sp,96
    3898:	22080793          	addi	a5,a6,544
    389c:	97aa                	add	a5,a5,a0
    389e:	03000513          	li	a0,48
    38a2:	dea78423          	sb	a0,-536(a5)
         lead[2 + lead[0]] = 'x';
    38a6:	22068793          	addi	a5,a3,544
    38aa:	1094                	addi	a3,sp,96
    38ac:	96be                	add	a3,a3,a5
            *s++ = stbsp__period;
    38ae:	00004517          	auipc	a0,0x4
    38b2:	70654503          	lbu	a0,1798(a0) # 7fb4 <stbsp__period>
         lead[2 + lead[0]] = 'x';
    38b6:	07800813          	li	a6,120
         sn = s;
    38ba:	0c210793          	addi	a5,sp,194
         lead[2 + lead[0]] = 'x';
    38be:	df068423          	sb	a6,-536(a3)
            *s++ = stbsp__period;
    38c2:	0ca100a3          	sb	a0,193(sp)
         lead[0] += 2;
    38c6:	07410423          	sb	s4,104(sp)
         *s++ = h[(n64 >> 60) & 15];
    38ca:	0c610023          	sb	t1,192(sp)
         n64 <<= 4;
    38ce:	0732                	slli	a4,a4,0xc
         sn = s;
    38d0:	fcbe                	sd	a5,120(sp)
         n = pr;
    38d2:	0008869b          	sext.w	a3,a7
         while (n--) {
    38d6:	4831                	li	a6,12
         if (n > 13)
    38d8:	4535                	li	a0,13
            tz = pr - n;
    38da:	40a688bb          	subw	a7,a3,a0
         while (n--) {
    38de:	02081313          	slli	t1,a6,0x20
    38e2:	02035313          	srli	t1,t1,0x20
    38e6:	22030693          	addi	a3,t1,544
    38ea:	1088                	addi	a0,sp,96
    38ec:	9536                	add	a0,a0,a3
    38ee:	e4350513          	addi	a0,a0,-445
            *s++ = h[(n64 >> 60) & 15];
    38f2:	03c75693          	srli	a3,a4,0x3c
    38f6:	96ae                	add	a3,a3,a1
    38f8:	0006c683          	lbu	a3,0(a3)
    38fc:	0785                	addi	a5,a5,1
            n64 <<= 4;
    38fe:	0712                	slli	a4,a4,0x4
            *s++ = h[(n64 >> 60) & 15];
    3900:	fed78fa3          	sb	a3,-1(a5)
         while (n--) {
    3904:	fea797e3          	bne	a5,a0,38f2 <stbsp_vsprintfcb+0x1610>
         l = (int)(s - (num + 64));
    3908:	280d                	addiw	a6,a6,3
    390a:	0008069b          	sext.w	a3,a6
         if (pr < (stbsp__int32)l)
    390e:	fff6c713          	not	a4,a3
    3912:	977d                	srai	a4,a4,0x3f
    3914:	00e87733          	and	a4,a6,a4
         dp = (int)(s - sn);
    3918:	0013051b          	addiw	a0,t1,1
         if (pr < (stbsp__int32)l)
    391c:	0007031b          	sext.w	t1,a4
         pr -= l;
    3920:	4107073b          	subw	a4,a4,a6
    3924:	d76ff06f          	j	2e9a <stbsp_vsprintfcb+0xbb8>
                  *--s = stbsp__comma;
    3928:	00004a17          	auipc	s4,0x4
    392c:	5c0a0a13          	addi	s4,s4,1472 # 7ee8 <stbsp__digitpair>
            if (n64 >= 100000000) {
    3930:	05f5e7b7          	lui	a5,0x5f5e
    3934:	0ff78793          	addi	a5,a5,255 # 5f5e0ff <_ZSt4cerr+0x5f552bf>
               n = (stbsp__uint32)(n64 % 100000000);
    3938:	05f5e637          	lui	a2,0x5f5e
                  *--s = stbsp__comma;
    393c:	0cda4b83          	lbu	s7,205(s4)
            if (n64 >= 100000000) {
    3940:	e83e                	sd	a5,16(sp)
               n = (stbsp__uint32)(n64 % 100000000);
    3942:	10060793          	addi	a5,a2,256 # 5f5e100 <_ZSt4cerr+0x5f552c0>
         l = 0;
    3946:	d082                	sw	zero,96(sp)
            if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    3948:	040e7813          	andi	a6,t3,64
    394c:	4701                	li	a4,0
    394e:	4281                	li	t0,0
         s = num + STBSP__NUMSZ;
    3950:	28010a93          	addi	s5,sp,640
               n = (stbsp__uint32)(n64 % 100000000);
    3954:	ec3e                	sd	a5,24(sp)
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    3956:	430d                	li	t1,3
                  n /= 10;
    3958:	45a9                	li	a1,10
            while (n) {
    395a:	4ea5                	li	t4,9
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    395c:	06400f93          	li	t6,100
            if (n64 >= 100000000) {
    3960:	67c2                	ld	a5,16(sp)
            char *o = s - 8;
    3962:	ff8a8513          	addi	a0,s5,-8
            if (n64 >= 100000000) {
    3966:	0fe7f763          	bgeu	a5,t5,3a54 <stbsp_vsprintfcb+0x1772>
               n = (stbsp__uint32)(n64 % 100000000);
    396a:	6662                	ld	a2,24(sp)
    396c:	02cf77b3          	remu	a5,t5,a2
               n64 /= 100000000;
    3970:	02cf5f33          	divu	t5,t5,a2
            if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    3974:	0e080463          	beqz	a6,3a5c <stbsp_vsprintfcb+0x177a>
            while (n) {
    3978:	cb85                	beqz	a5,39a8 <stbsp_vsprintfcb+0x16c6>
                  *--s = stbsp__comma;
    397a:	1afd                	addi	s5,s5,-1
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    397c:	00671763          	bne	a4,t1,398a <stbsp_vsprintfcb+0x16a8>
                  --o;
    3980:	017a8023          	sb	s7,0(s5)
    3984:	157d                	addi	a0,a0,-1
                  *--s = stbsp__comma;
    3986:	1afd                	addi	s5,s5,-1
                  l = 0;
    3988:	4701                	li	a4,0
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    398a:	2705                	addiw	a4,a4,1
                  *--s = (char)(n % 10) + '0';
    398c:	02b7f63b          	remuw	a2,a5,a1
    3990:	0306061b          	addiw	a2,a2,48
    3994:	00ca8023          	sb	a2,0(s5)
                  n /= 10;
    3998:	02b7d63b          	divuw	a2,a5,a1
            while (n) {
    399c:	00fef563          	bgeu	t4,a5,39a6 <stbsp_vsprintfcb+0x16c4>
                  *--s = stbsp__comma;
    39a0:	1afd                	addi	s5,s5,-1
    39a2:	87b2                	mv	a5,a2
    39a4:	bfe1                	j	397c <stbsp_vsprintfcb+0x169a>
            while (n) {
    39a6:	4285                	li	t0,1
            if (n64 == 0) {
    39a8:	020f0063          	beqz	t5,39c8 <stbsp_vsprintfcb+0x16e6>
            while (s != o)
    39ac:	fb550ae3          	beq	a0,s5,3960 <stbsp_vsprintfcb+0x167e>
                  *--s = stbsp__comma;
    39b0:	1afd                	addi	s5,s5,-1
               if ((fl & STBSP__TRIPLET_COMMA) && (l++ == 3)) {
    39b2:	00080663          	beqz	a6,39be <stbsp_vsprintfcb+0x16dc>
    39b6:	08670863          	beq	a4,t1,3a46 <stbsp_vsprintfcb+0x1764>
    39ba:	2705                	addiw	a4,a4,1
    39bc:	4285                	li	t0,1
                  *--s = '0';
    39be:	03000793          	li	a5,48
    39c2:	00fa8023          	sb	a5,0(s5)
    39c6:	b7dd                	j	39ac <stbsp_vsprintfcb+0x16ca>
    39c8:	00028363          	beqz	t0,39ce <stbsp_vsprintfcb+0x16ec>
    39cc:	d0ba                	sw	a4,96(sp)
               if ((s[0] == '0') && (s != (num + STBSP__NUMSZ)))
    39ce:	000ac703          	lbu	a4,0(s5)
    39d2:	03000793          	li	a5,48
    39d6:	34f70b63          	beq	a4,a5,3d2c <stbsp_vsprintfcb+0x1a4a>
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    39da:	051c                	addi	a5,sp,640
    39dc:	415786bb          	subw	a3,a5,s5
         tail[0] = 0;
    39e0:	06010823          	sb	zero,112(sp)
   if (fl & STBSP__NEGATIVE) {
    39e4:	080e7713          	andi	a4,t3,128
    39e8:	87f2                	mv	a5,t3
    39ea:	32070863          	beqz	a4,3d1a <stbsp_vsprintfcb+0x1a38>
    39ee:	678d                	lui	a5,0x3
    39f0:	d017879b          	addiw	a5,a5,-767 # 2d01 <stbsp_vsprintfcb+0xa1f>
      sign[0] = 1;
    39f4:	06f11423          	sh	a5,104(sp)
    39f8:	4705                	li	a4,1
    39fa:	4a05                	li	s4,1
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    39fc:	d0b6                	sw	a3,96(sp)
         if (l == 0) {
    39fe:	30068163          	beqz	a3,3d00 <stbsp_vsprintfcb+0x1a1e>
         cs = l + (3 << 24);
    3a02:	030002b7          	lui	t0,0x3000
    3a06:	00d282bb          	addw	t0,t0,a3
         if (pr < (stbsp__int32)l)
    3a0a:	0006861b          	sext.w	a2,a3
         if (pr < 0)
    3a0e:	fff8c793          	not	a5,a7
    3a12:	97fd                	srai	a5,a5,0x3f
         if (pr < (stbsp__int32)l)
    3a14:	00f8f7b3          	and	a5,a7,a5
    3a18:	0007859b          	sext.w	a1,a5
    3a1c:	00c5d363          	bge	a1,a2,3a22 <stbsp_vsprintfcb+0x1740>
    3a20:	87b2                	mv	a5,a2
         n = pr + lead[0] + tail[0] + tz;
    3a22:	00f7063b          	addw	a2,a4,a5
    3a26:	8732                	mv	a4,a2
         if (pr < (stbsp__int32)l)
    3a28:	2781                	sext.w	a5,a5
         if ((fl & STBSP__LEFTJUST) == 0) {
    3a2a:	001e7513          	andi	a0,t3,1
         if (fw < (stbsp__int32)n)
    3a2e:	835a                	mv	t1,s6
    3a30:	00cb5363          	bge	s6,a2,3a36 <stbsp_vsprintfcb+0x1754>
    3a34:	8332                	mv	t1,a2
         fw -= n;
    3a36:	40e3033b          	subw	t1,t1,a4
      scopy:
    3a3a:	4f81                	li	t6,0
         pr -= l;
    3a3c:	40d7873b          	subw	a4,a5,a3
      tz = 0;
    3a40:	4881                	li	a7,0
      scopy:
    3a42:	9e2ff06f          	j	2c24 <stbsp_vsprintfcb+0x942>
                  *--s = stbsp__comma;
    3a46:	87de                	mv	a5,s7
                  --o;
    3a48:	157d                	addi	a0,a0,-1
                  l = 0;
    3a4a:	4701                	li	a4,0
                  --o;
    3a4c:	4285                	li	t0,1
    3a4e:	00fa8023          	sb	a5,0(s5)
    3a52:	bfa9                	j	39ac <stbsp_vsprintfcb+0x16ca>
               n = (stbsp__uint32)n64;
    3a54:	000f079b          	sext.w	a5,t5
               n64 = 0;
    3a58:	4f01                	li	t5,0
    3a5a:	bf29                	j	3974 <stbsp_vsprintfcb+0x1692>
    3a5c:	f046                	sd	a7,32(sp)
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    3a5e:	03f7f63b          	remuw	a2,a5,t6
                  s -= 2;
    3a62:	1af9                	addi	s5,s5,-2
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    3a64:	0007889b          	sext.w	a7,a5
    3a68:	2605                	addiw	a2,a2,1
    3a6a:	0016161b          	slliw	a2,a2,0x1
    3a6e:	1602                	slli	a2,a2,0x20
    3a70:	9201                	srli	a2,a2,0x20
    3a72:	9652                	add	a2,a2,s4
    3a74:	00065603          	lhu	a2,0(a2)
                  n /= 100;
    3a78:	03f7d7bb          	divuw	a5,a5,t6
                  *(stbsp__uint16 *)s = *(stbsp__uint16 *)&stbsp__digitpair.pair[(n % 100) * 2];
    3a7c:	00ca9023          	sh	a2,0(s5)
               } while (n);
    3a80:	06300613          	li	a2,99
    3a84:	fd166de3          	bltu	a2,a7,3a5e <stbsp_vsprintfcb+0x177c>
    3a88:	7882                	ld	a7,32(sp)
            if (n64 == 0) {
    3a8a:	f20f11e3          	bnez	t5,39ac <stbsp_vsprintfcb+0x16ca>
    3a8e:	bf2d                	j	39c8 <stbsp_vsprintfcb+0x16e6>
                     *(stbsp__uint32 *)bf = 0x20202020;
    3a90:	20202b37          	lui	s6,0x20202
                  stbsp__cb_buf_clamp(i, fw);
    3a94:	854a                	mv	a0,s2
                     *bf++ = ' ';
    3a96:	02000a93          	li	s5,32
                     *(stbsp__uint32 *)bf = 0x20202020;
    3a9a:	020b0b13          	addi	s6,s6,32 # 20202020 <_ZSt4cerr+0x201f91e0>
                  stbsp__chk_cb_buf(1);
    3a9e:	1fe00a13          	li	s4,510
                  stbsp__cb_buf_clamp(i, fw);
    3aa2:	20000b93          	li	s7,512
    3aa6:	891a                	mv	s2,t1
    3aa8:	0a098063          	beqz	s3,3b48 <stbsp_vsprintfcb+0x1866>
    3aac:	40a40633          	sub	a2,s0,a0
    3ab0:	40cb87bb          	subw	a5,s7,a2
    3ab4:	873e                	mv	a4,a5
    3ab6:	00f95363          	bge	s2,a5,3abc <stbsp_vsprintfcb+0x17da>
    3aba:	874a                	mv	a4,s2
    3abc:	0007079b          	sext.w	a5,a4
                  fw -= i;
    3ac0:	40e9093b          	subw	s2,s2,a4
                  while (i) {
    3ac4:	e799                	bnez	a5,3ad2 <stbsp_vsprintfcb+0x17f0>
    3ac6:	a281                	j	3c06 <stbsp_vsprintfcb+0x1924>
                     *bf++ = ' ';
    3ac8:	01540023          	sb	s5,0(s0)
                     --i;
    3acc:	37fd                	addiw	a5,a5,-1
                     *bf++ = ' ';
    3ace:	0405                	addi	s0,s0,1
                  while (i) {
    3ad0:	cba1                	beqz	a5,3b20 <stbsp_vsprintfcb+0x183e>
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    3ad2:	00347713          	andi	a4,s0,3
    3ad6:	fb6d                	bnez	a4,3ac8 <stbsp_vsprintfcb+0x17e6>
                  while (i >= 4) {
    3ad8:	470d                	li	a4,3
    3ada:	40f75363          	bge	a4,a5,3ee0 <stbsp_vsprintfcb+0x1bfe>
    3ade:	ffc7869b          	addiw	a3,a5,-4
    3ae2:	0026d79b          	srliw	a5,a3,0x2
    3ae6:	0017871b          	addiw	a4,a5,1
    3aea:	070a                	slli	a4,a4,0x2
    3aec:	9722                	add	a4,a4,s0
                     *(stbsp__uint32 *)bf = 0x20202020;
    3aee:	01642023          	sw	s6,0(s0)
                     bf += 4;
    3af2:	0411                	addi	s0,s0,4
                  while (i >= 4) {
    3af4:	fee41de3          	bne	s0,a4,3aee <stbsp_vsprintfcb+0x180c>
    3af8:	0027979b          	slliw	a5,a5,0x2
    3afc:	40f687bb          	subw	a5,a3,a5
                  while (i--)
    3b00:	fff7869b          	addiw	a3,a5,-1
    3b04:	cf91                	beqz	a5,3b20 <stbsp_vsprintfcb+0x183e>
    3b06:	9fa1                	addw	a5,a5,s0
                     *bf++ = ' ';
    3b08:	0705                	addi	a4,a4,1
                  while (i--)
    3b0a:	0007061b          	sext.w	a2,a4
                     *bf++ = ' ';
    3b0e:	ff570fa3          	sb	s5,-1(a4)
                  while (i--)
    3b12:	fec79be3          	bne	a5,a2,3b08 <stbsp_vsprintfcb+0x1826>
    3b16:	2685                	addiw	a3,a3,1
    3b18:	02069793          	slli	a5,a3,0x20
    3b1c:	9381                	srli	a5,a5,0x20
    3b1e:	943e                	add	s0,s0,a5
                  stbsp__chk_cb_buf(1);
    3b20:	00098f63          	beqz	s3,3b3e <stbsp_vsprintfcb+0x185c>
    3b24:	40a4063b          	subw	a2,s0,a0
    3b28:	00ca5b63          	bge	s4,a2,3b3e <stbsp_vsprintfcb+0x185c>
    3b2c:	65a2                	ld	a1,8(sp)
    3b2e:	e81e                	sd	t2,16(sp)
    3b30:	00cd0d3b          	addw	s10,s10,a2
    3b34:	9982                	jalr	s3
    3b36:	80050be3          	beqz	a0,334c <stbsp_vsprintfcb+0x106a>
    3b3a:	63c2                	ld	t2,16(sp)
    3b3c:	842a                	mv	s0,a0
               while (fw) {
    3b3e:	f60915e3          	bnez	s2,3aa8 <stbsp_vsprintfcb+0x17c6>
    3b42:	892a                	mv	s2,a0
    3b44:	f21fe06f          	j	2a64 <stbsp_vsprintfcb+0x782>
                  stbsp__cb_buf_clamp(i, fw);
    3b48:	87ca                	mv	a5,s2
                  fw -= i;
    3b4a:	4901                	li	s2,0
                     if ((((stbsp__uintptr)bf) & 3) == 0)
    3b4c:	b759                	j	3ad2 <stbsp_vsprintfcb+0x17f0>
   } else if (fl & STBSP__LEADINGPLUS) {
    3b4e:	002e7713          	andi	a4,t3,2
    3b52:	94070663          	beqz	a4,2c9e <stbsp_vsprintfcb+0x9bc>
      sign[0] = 1;
    3b56:	670d                	lui	a4,0x3
    3b58:	b0170713          	addi	a4,a4,-1279 # 2b01 <stbsp_vsprintfcb+0x81f>
    3b5c:	06e11423          	sh	a4,104(sp)
    3b60:	93eff06f          	j	2c9e <stbsp_vsprintfcb+0x9bc>
      if (((stbsp__uintptr)sn & 3) == 0)
    3b64:	87d6                	mv	a5,s5
   while (limit >= 4) {
    3b66:	470d                	li	a4,3
    3b68:	22d77763          	bgeu	a4,a3,3d96 <stbsp_vsprintfcb+0x1ab4>
      if ((v - 0x01010101) & (~v) & 0x80808080UL)
    3b6c:	feff05b7          	lui	a1,0xfeff0
    3b70:	80808637          	lui	a2,0x80808
    3b74:	eff5859b          	addiw	a1,a1,-257 # fffffffffefefeff <_ZSt4cerr+0xfffffffffefe70bf>
    3b78:	08060613          	addi	a2,a2,128 # ffffffff80808080 <_ZSt4cerr+0xffffffff807ff240>
   while (limit >= 4) {
    3b7c:	480d                	li	a6,3
    3b7e:	a029                	j	3b88 <stbsp_vsprintfcb+0x18a6>
      limit -= 4;
    3b80:	36f1                	addiw	a3,a3,-4
      sn += 4;
    3b82:	0791                	addi	a5,a5,4
   while (limit >= 4) {
    3b84:	20d87963          	bgeu	a6,a3,3d96 <stbsp_vsprintfcb+0x1ab4>
      stbsp__uint32 v = *(stbsp__uint32 *)sn;
    3b88:	4398                	lw	a4,0(a5)
      if ((v - 0x01010101) & (~v) & 0x80808080UL)
    3b8a:	00b7053b          	addw	a0,a4,a1
    3b8e:	fff74713          	not	a4,a4
    3b92:	8f69                	and	a4,a4,a0
    3b94:	8f71                	and	a4,a4,a2
    3b96:	2701                	sext.w	a4,a4
    3b98:	d765                	beqz	a4,3b80 <stbsp_vsprintfcb+0x189e>
    3b9a:	02069713          	slli	a4,a3,0x20
    3b9e:	9301                	srli	a4,a4,0x20
    3ba0:	973e                	add	a4,a4,a5
    3ba2:	a021                	j	3baa <stbsp_vsprintfcb+0x18c8>
      ++sn;
    3ba4:	0785                	addi	a5,a5,1
   while (limit && *sn) {
    3ba6:	00e78663          	beq	a5,a4,3bb2 <stbsp_vsprintfcb+0x18d0>
    3baa:	0007c683          	lbu	a3,0(a5)
    3bae:	fafd                	bnez	a3,3ba4 <stbsp_vsprintfcb+0x18c2>
    3bb0:	873e                	mv	a4,a5
   return (stbsp__uint32)(sn - s);
    3bb2:	41570733          	sub	a4,a4,s5
    3bb6:	0007069b          	sext.w	a3,a4
         if (pr < (stbsp__int32)l)
    3bba:	fff6c793          	not	a5,a3
    3bbe:	97fd                	srai	a5,a5,0x3f
    3bc0:	8f7d                	and	a4,a4,a5
    3bc2:	0007079b          	sext.w	a5,a4
         n = pr + lead[0] + tail[0] + tz;
    3bc6:	863e                	mv	a2,a5
         pr -= l;
    3bc8:	9f15                	subw	a4,a4,a3
   return (stbsp__uint32)(sn - s);
    3bca:	d2eff06f          	j	30f8 <stbsp_vsprintfcb+0xe16>
         for (n = 1; n < l; n++)
    3bce:	4605                	li	a2,1
    3bd0:	aed663e3          	bltu	a2,a3,36b6 <stbsp_vsprintfcb+0x13d4>
    3bd4:	0c210613          	addi	a2,sp,194
    3bd8:	bcf5                	j	36d4 <stbsp_vsprintfcb+0x13f2>
            l = pr + 1;
    3bda:	4685                	li	a3,1
         if ((l - 1) > (stbsp__uint32)pr)
    3bdc:	4501                	li	a0,0
         *s++ = sn[0];
    3bde:	0c110613          	addi	a2,sp,193
    3be2:	bccd                	j	36d4 <stbsp_vsprintfcb+0x13f2>
    3be4:	4591                	li	a1,4
    3be6:	4f91                	li	t6,4
         n = (dp >= 100) ? 5 : 4;
    3be8:	4e91                	li	t4,4
    3bea:	be21                	j	3702 <stbsp_vsprintfcb+0x1420>
    3bec:	4a85                	li	s5,1
    3bee:	80000737          	lui	a4,0x80000
            pr = 1; // default is 6
    3bf2:	4a05                	li	s4,1
    3bf4:	920ff06f          	j	2d14 <stbsp_vsprintfcb+0xa32>
            dp = (n64) ? -1022 : 0;
    3bf8:	4601                	li	a2,0
    3bfa:	c119                	beqz	a0,3c00 <stbsp_vsprintfcb+0x191e>
    3bfc:	c0200613          	li	a2,-1022
   *bits = b & ((((stbsp__uint64)1) << 52) - 1);
    3c00:	872a                	mv	a4,a0
    3c02:	a3aff06f          	j	2e3c <stbsp_vsprintfcb+0xb5a>
                  stbsp__chk_cb_buf(1);
    3c06:	2601                	sext.w	a2,a2
    3c08:	1fe00793          	li	a5,510
    3c0c:	f2c7c0e3          	blt	a5,a2,3b2c <stbsp_vsprintfcb+0x184a>
    3c10:	bd61                	j	3aa8 <stbsp_vsprintfcb+0x17c6>
         tail[0] = (char)n;
    3c12:	4795                	li	a5,5
            tail[n] = '0' + dp % 10;
    3c14:	06b10aa3          	sb	a1,117(sp)
         tail[0] = (char)n;
    3c18:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    3c1c:	4815                	li	a6,5
    3c1e:	4f95                	li	t6,5
         n = (dp >= 1000) ? 6 : ((dp >= 100) ? 5 : ((dp >= 10) ? 4 : 3));
    3c20:	4595                	li	a1,5
    3c22:	b935                	j	385e <stbsp_vsprintfcb+0x157c>
                  l = pr + dp;
    3c24:	011786bb          	addw	a3,a5,a7
    3c28:	d0b6                	sw	a3,96(sp)
    3c2a:	b6d5                	j	380e <stbsp_vsprintfcb+0x152c>
            s = (char *)"null";
    3c2c:	00002a97          	auipc	s5,0x2
    3c30:	54ca8a93          	addi	s5,s5,1356 # 6178 <_GLOBAL__sub_I__ZSt3cin+0x174>
    3c34:	c80ff06f          	j	30b4 <stbsp_vsprintfcb+0xdd2>
   } else if (fl & STBSP__LEADINGPLUS) {
    3c38:	002e7793          	andi	a5,t3,2
    3c3c:	1c079c63          	bnez	a5,3e14 <stbsp_vsprintfcb+0x1b32>
   sign[0] = 0;
    3c40:	4689                	li	a3,2
    3c42:	4a09                	li	s4,2
    3c44:	4805                	li	a6,1
    3c46:	9e8ff06f          	j	2e2e <stbsp_vsprintfcb+0xb4c>
      sign[0] = 1;
    3c4a:	670d                	lui	a4,0x3
    3c4c:	b0170713          	addi	a4,a4,-1279 # 2b01 <stbsp_vsprintfcb+0x81f>
    3c50:	06e11423          	sh	a4,104(sp)
    3c54:	b86ff06f          	j	2fda <stbsp_vsprintfcb+0xcf8>
               pr = 0;
    3c58:	4881                	li	a7,0
    3c5a:	f1ffe06f          	j	2b78 <stbsp_vsprintfcb+0x896>
            *s++ = '0';
    3c5e:	03000713          	li	a4,48
    3c62:	0ce10023          	sb	a4,192(sp)
            if (pr)
    3c66:	1a088c63          	beqz	a7,3e1e <stbsp_vsprintfcb+0x1b3c>
               *s++ = stbsp__period;
    3c6a:	00004717          	auipc	a4,0x4
    3c6e:	34a74703          	lbu	a4,842(a4) # 7fb4 <stbsp__period>
            n = -dp;
    3c72:	40f007bb          	negw	a5,a5
               *s++ = stbsp__period;
    3c76:	0ce100a3          	sb	a4,193(sp)
            if ((stbsp__int32)n > pr)
    3c7a:	0007871b          	sext.w	a4,a5
    3c7e:	00e8d363          	bge	a7,a4,3c84 <stbsp_vsprintfcb+0x19a2>
    3c82:	87c6                	mv	a5,a7
    3c84:	0007871b          	sext.w	a4,a5
            if ((stbsp__int32)(l + n) > pr)
    3c88:	00d7833b          	addw	t1,a5,a3
    3c8c:	883a                	mv	a6,a4
            while (i) {
    3c8e:	0c210793          	addi	a5,sp,194
               *s++ = '0';
    3c92:	03000513          	li	a0,48
            while (i) {
    3c96:	e711                	bnez	a4,3ca2 <stbsp_vsprintfcb+0x19c0>
    3c98:	a271                	j	3e24 <stbsp_vsprintfcb+0x1b42>
               if ((((stbsp__uintptr)s) & 3) == 0)
    3c9a:	0037f613          	andi	a2,a5,3
    3c9e:	18060563          	beqz	a2,3e28 <stbsp_vsprintfcb+0x1b46>
               *s++ = '0';
    3ca2:	85ba                	mv	a1,a4
    3ca4:	00a78023          	sb	a0,0(a5)
               --i;
    3ca8:	377d                	addiw	a4,a4,-1
               *s++ = '0';
    3caa:	0785                	addi	a5,a5,1
            while (i) {
    3cac:	f77d                	bnez	a4,3c9a <stbsp_vsprintfcb+0x19b8>
            if ((stbsp__int32)(l + n) > pr)
    3cae:	0003071b          	sext.w	a4,t1
    3cb2:	4108863b          	subw	a2,a7,a6
    3cb6:	00e8d563          	bge	a7,a4,3cc0 <stbsp_vsprintfcb+0x19de>
               l = pr - n;
    3cba:	0006069b          	sext.w	a3,a2
    3cbe:	d0b2                	sw	a2,96(sp)
            while (i) {
    3cc0:	c68d                	beqz	a3,3cea <stbsp_vsprintfcb+0x1a08>
    3cc2:	7566                	ld	a0,120(sp)
    3cc4:	02069813          	slli	a6,a3,0x20
    3cc8:	02085813          	srli	a6,a6,0x20
    3ccc:	01078eb3          	add	t4,a5,a6
    3cd0:	85aa                	mv	a1,a0
    3cd2:	873e                	mv	a4,a5
               *s++ = *sn++;
    3cd4:	0005c883          	lbu	a7,0(a1)
    3cd8:	0705                	addi	a4,a4,1
            while (i) {
    3cda:	0585                	addi	a1,a1,1
               *s++ = *sn++;
    3cdc:	ff170fa3          	sb	a7,-1(a4)
            while (i) {
    3ce0:	ffd71ae3          	bne	a4,t4,3cd4 <stbsp_vsprintfcb+0x19f2>
    3ce4:	9542                	add	a0,a0,a6
    3ce6:	97c2                	add	a5,a5,a6
    3ce8:	fcaa                	sd	a0,120(sp)
         l = (stbsp__uint32)(s - (num + 64));
    3cea:	0c010a93          	addi	s5,sp,192
            cs = 1 + (3 << 24); // how many tens did we write (for commas below)
    3cee:	030002b7          	lui	t0,0x3000
            tz = pr - (n + l);
    3cf2:	40d608bb          	subw	a7,a2,a3
         l = (stbsp__uint32)(s - (num + 64));
    3cf6:	415787b3          	sub	a5,a5,s5
            cs = 1 + (3 << 24); // how many tens did we write (for commas below)
    3cfa:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff71c1>
    3cfc:	fbcff06f          	j	34b8 <stbsp_vsprintfcb+0x11d6>
            *--s = '0';
    3d00:	03000793          	li	a5,48
    3d04:	fefa8fa3          	sb	a5,-1(s5)
            l = 1;
    3d08:	030002b7          	lui	t0,0x3000
    3d0c:	4785                	li	a5,1
    3d0e:	d0be                	sw	a5,96(sp)
            *--s = '0';
    3d10:	1afd                	addi	s5,s5,-1
            l = 1;
    3d12:	4605                	li	a2,1
    3d14:	0285                	addi	t0,t0,1 # 3000001 <_ZSt4cerr+0x2ff71c1>
    3d16:	4685                	li	a3,1
    3d18:	b9dd                	j	3a0e <stbsp_vsprintfcb+0x172c>
   } else if (fl & STBSP__LEADINGSPACE) {
    3d1a:	004e7713          	andi	a4,t3,4
    3d1e:	e74d                	bnez	a4,3dc8 <stbsp_vsprintfcb+0x1ae6>
   } else if (fl & STBSP__LEADINGPLUS) {
    3d20:	8b89                	andi	a5,a5,2
    3d22:	efd9                	bnez	a5,3dc0 <stbsp_vsprintfcb+0x1ade>
   sign[0] = 0;
    3d24:	06010423          	sb	zero,104(sp)
    3d28:	4a01                	li	s4,0
    3d2a:	b9c9                	j	39fc <stbsp_vsprintfcb+0x171a>
               if ((s[0] == '0') && (s != (num + STBSP__NUMSZ)))
    3d2c:	051c                	addi	a5,sp,640
    3d2e:	cafa89e3          	beq	s5,a5,39e0 <stbsp_vsprintfcb+0x16fe>
                  ++s;
    3d32:	0a85                	addi	s5,s5,1
         l = (stbsp__uint32)((num + STBSP__NUMSZ) - s);
    3d34:	415786bb          	subw	a3,a5,s5
    3d38:	b165                	j	39e0 <stbsp_vsprintfcb+0x16fe>
                  n = dp - n;
    3d3a:	40ce87bb          	subw	a5,t4,a2
                  if ((fl & STBSP__TRIPLET_COMMA) == 0) {
    3d3e:	12030e63          	beqz	t1,3e7a <stbsp_vsprintfcb+0x1b98>
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3d42:	4511                	li	a0,4
    3d44:	03000613          	li	a2,48
                        *s++ = stbsp__comma;
    3d48:	00170693          	addi	a3,a4,1
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3d4c:	00030563          	beqz	t1,3d56 <stbsp_vsprintfcb+0x1a74>
    3d50:	2585                	addiw	a1,a1,1
    3d52:	00a58963          	beq	a1,a0,3d64 <stbsp_vsprintfcb+0x1a82>
    3d56:	8736                	mv	a4,a3
                        --n;
    3d58:	37fd                	addiw	a5,a5,-1
    3d5a:	fec70fa3          	sb	a2,-1(a4)
                  while (n) {
    3d5e:	f7ed                	bnez	a5,3d48 <stbsp_vsprintfcb+0x1a66>
    3d60:	f38ff06f          	j	3498 <stbsp_vsprintfcb+0x11b6>
    3d64:	fe568fa3          	sb	t0,-1(a3)
                        *s++ = stbsp__comma;
    3d68:	0709                	addi	a4,a4,2
                     if ((fl & STBSP__TRIPLET_COMMA) && (++cs == 4)) {
    3d6a:	4585                	li	a1,1
    3d6c:	b7f5                	j	3d58 <stbsp_vsprintfcb+0x1a76>
   sign[0] = 0;
    3d6e:	06010423          	sb	zero,104(sp)
    3d72:	f1dfe06f          	j	2c8e <stbsp_vsprintfcb+0x9ac>
                     tail[idx + 1] = "_kMGT"[fl >> 24];
    3d76:	00002697          	auipc	a3,0x2
    3d7a:	41268693          	addi	a3,a3,1042 # 6188 <_GLOBAL__sub_I__ZSt3cin+0x184>
    3d7e:	9736                	add	a4,a4,a3
    3d80:	00074683          	lbu	a3,0(a4)
    3d84:	1088                	addi	a0,sp,96
    3d86:	22060713          	addi	a4,a2,544
    3d8a:	972a                	add	a4,a4,a0
    3d8c:	ded70823          	sb	a3,-528(a4)
                  idx++;
    3d90:	8fb2                	mv	t6,a2
    3d92:	fb0ff06f          	j	3542 <stbsp_vsprintfcb+0x1260>
   while (limit && *sn) {
    3d96:	e00692e3          	bnez	a3,3b9a <stbsp_vsprintfcb+0x18b8>
    3d9a:	bd19                	j	3bb0 <stbsp_vsprintfcb+0x18ce>
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    3d9c:	0008071b          	sext.w	a4,a6
    3da0:	86c2                	mv	a3,a6
    3da2:	88d2                	mv	a7,s4
            pr = -dp + ((pr > (stbsp__int32)l) ? (stbsp__int32) l : pr);
    3da4:	863a                	mv	a2,a4
    3da6:	00e8d363          	bge	a7,a4,3dac <stbsp_vsprintfcb+0x1aca>
    3daa:	8646                	mv	a2,a7
    3dac:	40f608bb          	subw	a7,a2,a5
    3db0:	814ff06f          	j	2dc4 <stbsp_vsprintfcb+0xae2>
            divisor = 1000.0f;
    3db4:	00003797          	auipc	a5,0x3
    3db8:	b747b787          	fld	fa5,-1164(a5) # 6928 <STDIN_FD+0x28>
    3dbc:	dd5fe06f          	j	2b90 <stbsp_vsprintfcb+0x8ae>
    3dc0:	678d                	lui	a5,0x3
    3dc2:	b017879b          	addiw	a5,a5,-1279 # 2b01 <stbsp_vsprintfcb+0x81f>
    3dc6:	b13d                	j	39f4 <stbsp_vsprintfcb+0x1712>
    3dc8:	6789                	lui	a5,0x2
    3dca:	2785                	addiw	a5,a5,1 # 2001 <_vscanf_core.constprop.0+0x675>
    3dcc:	b125                	j	39f4 <stbsp_vsprintfcb+0x1712>
            *s++ = stbsp__period;
    3dce:	00004517          	auipc	a0,0x4
    3dd2:	1e654503          	lbu	a0,486(a0) # 7fb4 <stbsp__period>
         sn = s;
    3dd6:	0c210793          	addi	a5,sp,194
         n = pr;
    3dda:	0008869b          	sext.w	a3,a7
            *s++ = stbsp__period;
    3dde:	0ca100a3          	sb	a0,193(sp)
         sn = s;
    3de2:	fcbe                	sd	a5,120(sp)
         if (n > 13)
    3de4:	4535                	li	a0,13
         n64 <<= 4;
    3de6:	0712                	slli	a4,a4,0x4
         if (n > 13)
    3de8:	8836                	mv	a6,a3
    3dea:	00d57363          	bgeu	a0,a3,3df0 <stbsp_vsprintfcb+0x1b0e>
    3dee:	4835                	li	a6,13
    3df0:	0008051b          	sext.w	a0,a6
         while (n--) {
    3df4:	387d                	addiw	a6,a6,-1
         if (pr > (stbsp__int32)n)
    3df6:	af1542e3          	blt	a0,a7,38da <stbsp_vsprintfcb+0x15f8>
      tz = 0;
    3dfa:	4881                	li	a7,0
    3dfc:	b4cd                	j	38de <stbsp_vsprintfcb+0x15fc>
               while (n < l) {
    3dfe:	87ba                	mv	a5,a4
    3e00:	bc1d                	j	3836 <stbsp_vsprintfcb+0x1554>
         tail[0] = (char)n;
    3e02:	478d                	li	a5,3
    3e04:	06f10823          	sb	a5,112(sp)
            tail[n] = '0' + dp % 10;
    3e08:	06b109a3          	sb	a1,115(sp)
    3e0c:	480d                	li	a6,3
    3e0e:	4f8d                	li	t6,3
    3e10:	8e4ff06f          	j	2ef4 <stbsp_vsprintfcb+0xc12>
    3e14:	678d                	lui	a5,0x3
    3e16:	b017879b          	addiw	a5,a5,-1279 # 2b01 <stbsp_vsprintfcb+0x81f>
    3e1a:	80aff06f          	j	2e24 <stbsp_vsprintfcb+0xb42>
            if (pr)
    3e1e:	8336                	mv	t1,a3
            *s++ = '0';
    3e20:	0c110793          	addi	a5,sp,193
            while (i) {
    3e24:	4801                	li	a6,0
    3e26:	b561                	j	3cae <stbsp_vsprintfcb+0x19cc>
            while (i >= 4) {
    3e28:	460d                	li	a2,3
    3e2a:	04e65663          	bge	a2,a4,3e76 <stbsp_vsprintfcb+0x1b94>
    3e2e:	ffb5871b          	addiw	a4,a1,-5
    3e32:	0027559b          	srliw	a1,a4,0x2
    3e36:	0015861b          	addiw	a2,a1,1
    3e3a:	060a                	slli	a2,a2,0x2
               *(stbsp__uint32 *)s = 0x30303030;
    3e3c:	30303537          	lui	a0,0x30303
    3e40:	963e                	add	a2,a2,a5
    3e42:	03050513          	addi	a0,a0,48 # 30303030 <_ZSt4cerr+0x302fa1f0>
    3e46:	c388                	sw	a0,0(a5)
               s += 4;
    3e48:	0791                	addi	a5,a5,4
            while (i >= 4) {
    3e4a:	fef61ee3          	bne	a2,a5,3e46 <stbsp_vsprintfcb+0x1b64>
    3e4e:	0025959b          	slliw	a1,a1,0x2
    3e52:	9f0d                	subw	a4,a4,a1
            while (i) {
    3e54:	e4070de3          	beqz	a4,3cae <stbsp_vsprintfcb+0x19cc>
               *s++ = '0';
    3e58:	03000513          	li	a0,48
            while (i) {
    3e5c:	00f705bb          	addw	a1,a4,a5
               *s++ = '0';
    3e60:	0605                	addi	a2,a2,1
            while (i) {
    3e62:	00060e9b          	sext.w	t4,a2
               *s++ = '0';
    3e66:	fea60fa3          	sb	a0,-1(a2)
            while (i) {
    3e6a:	ffd59be3          	bne	a1,t4,3e60 <stbsp_vsprintfcb+0x1b7e>
    3e6e:	1702                	slli	a4,a4,0x20
    3e70:	9301                	srli	a4,a4,0x20
    3e72:	97ba                	add	a5,a5,a4
    3e74:	bd2d                	j	3cae <stbsp_vsprintfcb+0x19cc>
            while (i >= 4) {
    3e76:	863e                	mv	a2,a5
    3e78:	b7c5                	j	3e58 <stbsp_vsprintfcb+0x1b76>
                        if ((((stbsp__uintptr)s) & 3) == 0)
    3e7a:	00377693          	andi	a3,a4,3
    3e7e:	ce81                	beqz	a3,3e96 <stbsp_vsprintfcb+0x1bb4>
                        *s++ = '0';
    3e80:	03000693          	li	a3,48
    3e84:	00d70023          	sb	a3,0(a4)
                        --n;
    3e88:	37fd                	addiw	a5,a5,-1
                        *s++ = '0';
    3e8a:	0705                	addi	a4,a4,1
                     while (n) {
    3e8c:	e0078663          	beqz	a5,3498 <stbsp_vsprintfcb+0x11b6>
                        if ((((stbsp__uintptr)s) & 3) == 0)
    3e90:	00377613          	andi	a2,a4,3
    3e94:	fa65                	bnez	a2,3e84 <stbsp_vsprintfcb+0x1ba2>
                     while (n >= 4) {
    3e96:	468d                	li	a3,3
    3e98:	eaf6f5e3          	bgeu	a3,a5,3d42 <stbsp_vsprintfcb+0x1a60>
    3e9c:	ffc7869b          	addiw	a3,a5,-4
    3ea0:	0026d69b          	srliw	a3,a3,0x2
    3ea4:	2685                	addiw	a3,a3,1
    3ea6:	068a                	slli	a3,a3,0x2
                        *(stbsp__uint32 *)s = 0x30303030;
    3ea8:	30303637          	lui	a2,0x30303
    3eac:	96ba                	add	a3,a3,a4
    3eae:	03060613          	addi	a2,a2,48 # 30303030 <_ZSt4cerr+0x302fa1f0>
    3eb2:	c310                	sw	a2,0(a4)
                        s += 4;
    3eb4:	0711                	addi	a4,a4,4
                     while (n >= 4) {
    3eb6:	fed71ee3          	bne	a4,a3,3eb2 <stbsp_vsprintfcb+0x1bd0>
    3eba:	8b8d                	andi	a5,a5,3
                  while (n) {
    3ebc:	e80793e3          	bnez	a5,3d42 <stbsp_vsprintfcb+0x1a60>
    3ec0:	dd8ff06f          	j	3498 <stbsp_vsprintfcb+0x11b6>
      if (((stbsp__uintptr)sn & 3) == 0)
    3ec4:	87d6                	mv	a5,s5
         l = stbsp__strlen_limited(s, (pr >= 0) ? pr : ~0u);
    3ec6:	56fd                	li	a3,-1
    3ec8:	b155                	j	3b6c <stbsp_vsprintfcb+0x188a>
         if ((dp <= -4) || (dp > (stbsp__int32)n)) {
    3eca:	5775                	li	a4,-3
    3ecc:	00e7ce63          	blt	a5,a4,3ee8 <stbsp_vsprintfcb+0x1c06>
    3ed0:	f6fa4663          	blt	s4,a5,363c <stbsp_vsprintfcb+0x135a>
         if (dp > 0) {
    3ed4:	ecf054e3          	blez	a5,3d9c <stbsp_vsprintfcb+0x1aba>
    3ed8:	86c2                	mv	a3,a6
            pr = (dp < (stbsp__int32)l) ? l - dp : 0;
    3eda:	4881                	li	a7,0
    3edc:	ee9fe06f          	j	2dc4 <stbsp_vsprintfcb+0xae2>
                  while (i--)
    3ee0:	fff7869b          	addiw	a3,a5,-1
    3ee4:	8722                	mv	a4,s0
    3ee6:	b105                	j	3b06 <stbsp_vsprintfcb+0x1824>
            if (pr > (stbsp__int32)l)
    3ee8:	0008071b          	sext.w	a4,a6
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    3eec:	7ae6                	ld	s5,120(sp)
            if (pr > (stbsp__int32)l)
    3eee:	86c2                	mv	a3,a6
    3ef0:	88d2                	mv	a7,s4
    3ef2:	f7475d63          	bge	a4,s4,366c <stbsp_vsprintfcb+0x138a>
         while ((l > 1) && (pr) && (sn[l - 1] == '0')) {
    3ef6:	8542                	mv	a0,a6
    3ef8:	f56ff06f          	j	364e <stbsp_vsprintfcb+0x136c>

0000000000003efc <stbsp_sprintf>:
{
    3efc:	715d                	addi	sp,sp,-80
   va_start(va, fmt);
    3efe:	02010313          	addi	t1,sp,32
{
    3f02:	f032                	sd	a2,32(sp)
    3f04:	f436                	sd	a3,40(sp)
    3f06:	f83a                	sd	a4,48(sp)
   result = STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    3f08:	86ae                	mv	a3,a1
    3f0a:	862a                	mv	a2,a0
    3f0c:	871a                	mv	a4,t1
    3f0e:	4581                	li	a1,0
    3f10:	4501                	li	a0,0
{
    3f12:	ec06                	sd	ra,24(sp)
    3f14:	fc3e                	sd	a5,56(sp)
    3f16:	e0c2                	sd	a6,64(sp)
    3f18:	e4c6                	sd	a7,72(sp)
   va_start(va, fmt);
    3f1a:	e41a                	sd	t1,8(sp)
   result = STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    3f1c:	bc6fe0ef          	jal	22e2 <stbsp_vsprintfcb>
}
    3f20:	60e2                	ld	ra,24(sp)
    3f22:	6161                	addi	sp,sp,80
    3f24:	8082                	ret

0000000000003f26 <stbsp_vsnprintf>:
{
    3f26:	dd010113          	addi	sp,sp,-560
    3f2a:	22813023          	sd	s0,544(sp)
    3f2e:	20913c23          	sd	s1,536(sp)
    3f32:	22113423          	sd	ra,552(sp)
    3f36:	84ae                	mv	s1,a1
    3f38:	842a                	mv	s0,a0
    3f3a:	88b2                	mv	a7,a2
    3f3c:	8736                	mv	a4,a3
   if ( (count == 0) && !buf )
    3f3e:	e591                	bnez	a1,3f4a <stbsp_vsnprintf+0x24>
    3f40:	c141                	beqz	a0,3fc0 <stbsp_vsnprintf+0x9a>
      c.buf = buf;
    3f42:	e02a                	sd	a0,0(sp)
      c.count = count;
    3f44:	e402                	sd	zero,8(sp)
   return (c->count >= STB_SPRINTF_MIN) ? c->buf : c->tmp; // go direct into buffer if you can
    3f46:	0810                	addi	a2,sp,16
    3f48:	a089                	j	3f8a <stbsp_vsnprintf+0x64>
   if (len > c->count)
    3f4a:	0015a593          	slti	a1,a1,1
    3f4e:	40b005bb          	negw	a1,a1
    3f52:	8de5                	and	a1,a1,s1
      c.buf = buf;
    3f54:	e02a                	sd	a0,0(sp)
      c.count = count;
    3f56:	c426                	sw	s1,8(sp)
      c.length = 0;
    3f58:	c602                	sw	zero,12(sp)
   if (len > c->count)
    3f5a:	2581                	sext.w	a1,a1
   if (len) {
    3f5c:	0804d663          	bgez	s1,3fe8 <stbsp_vsnprintf+0xc2>
         s = buf;
    3f60:	4781                	li	a5,0
      if (buf != c->buf) {
    3f62:	c911                	beqz	a0,3f76 <stbsp_vsnprintf+0x50>
            *d++ = *s++;
    3f64:	0007c803          	lbu	a6,0(a5)
    3f68:	0785                	addi	a5,a5,1
    3f6a:	00f40533          	add	a0,s0,a5
    3f6e:	ff050fa3          	sb	a6,-1(a0)
         } while (s < se);
    3f72:	feb7e9e3          	bltu	a5,a1,3f64 <stbsp_vsnprintf+0x3e>
      c->count -= len;
    3f76:	40b486bb          	subw	a3,s1,a1
      c->buf += len;
    3f7a:	95a2                	add	a1,a1,s0
    3f7c:	e02e                	sd	a1,0(sp)
      c->count -= len;
    3f7e:	c436                	sw	a3,8(sp)
   return (c->count >= STB_SPRINTF_MIN) ? c->buf : c->tmp; // go direct into buffer if you can
    3f80:	1ff00793          	li	a5,511
    3f84:	fcd7d1e3          	bge	a5,a3,3f46 <stbsp_vsnprintf+0x20>
    3f88:	6602                	ld	a2,0(sp)
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__clamp_callback, &c, stbsp__clamp_callback(0,&c,0), fmt, va );
    3f8a:	86c6                	mv	a3,a7
    3f8c:	858a                	mv	a1,sp
    3f8e:	ffffd517          	auipc	a0,0xffffd
    3f92:	21650513          	addi	a0,a0,534 # 11a4 <stbsp__clamp_callback>
    3f96:	b4cfe0ef          	jal	22e2 <stbsp_vsprintfcb>
      l = (int)( c.buf - buf );
    3f9a:	6782                	ld	a5,0(sp)
    3f9c:	9f81                	subw	a5,a5,s0
      if ( l >= count ) // should never be greater, only equal (or less) than count
    3f9e:	0097c463          	blt	a5,s1,3fa6 <stbsp_vsnprintf+0x80>
         l = count - 1;
    3fa2:	fff4879b          	addiw	a5,s1,-1
      buf[l] = 0;
    3fa6:	943e                	add	s0,s0,a5
    3fa8:	00040023          	sb	zero,0(s0)
}
    3fac:	22813083          	ld	ra,552(sp)
    3fb0:	22013403          	ld	s0,544(sp)
    3fb4:	4532                	lw	a0,12(sp)
    3fb6:	21813483          	ld	s1,536(sp)
    3fba:	23010113          	addi	sp,sp,560
    3fbe:	8082                	ret
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__count_clamp_callback, &c, c.tmp, fmt, va );
    3fc0:	86b2                	mv	a3,a2
    3fc2:	858a                	mv	a1,sp
    3fc4:	0810                	addi	a2,sp,16
    3fc6:	ffffd517          	auipc	a0,0xffffd
    3fca:	22c50513          	addi	a0,a0,556 # 11f2 <stbsp__count_clamp_callback>
      c.length = 0;
    3fce:	c602                	sw	zero,12(sp)
      STB_SPRINTF_DECORATE( vsprintfcb )( stbsp__count_clamp_callback, &c, c.tmp, fmt, va );
    3fd0:	b12fe0ef          	jal	22e2 <stbsp_vsprintfcb>
}
    3fd4:	22813083          	ld	ra,552(sp)
    3fd8:	22013403          	ld	s0,544(sp)
    3fdc:	4532                	lw	a0,12(sp)
    3fde:	21813483          	ld	s1,536(sp)
    3fe2:	23010113          	addi	sp,sp,560
    3fe6:	8082                	ret
    3fe8:	86a6                	mv	a3,s1
    3fea:	bf59                	j	3f80 <stbsp_vsnprintf+0x5a>

0000000000003fec <stbsp_snprintf>:
{
    3fec:	715d                	addi	sp,sp,-80
   va_start(va, fmt);
    3fee:	02810313          	addi	t1,sp,40
{
    3ff2:	f436                	sd	a3,40(sp)
   result = STB_SPRINTF_DECORATE(vsnprintf)(buf, count, fmt, va);
    3ff4:	869a                	mv	a3,t1
{
    3ff6:	ec06                	sd	ra,24(sp)
    3ff8:	f83a                	sd	a4,48(sp)
    3ffa:	fc3e                	sd	a5,56(sp)
    3ffc:	e0c2                	sd	a6,64(sp)
    3ffe:	e4c6                	sd	a7,72(sp)
   va_start(va, fmt);
    4000:	e41a                	sd	t1,8(sp)
   result = STB_SPRINTF_DECORATE(vsnprintf)(buf, count, fmt, va);
    4002:	f25ff0ef          	jal	3f26 <stbsp_vsnprintf>
}
    4006:	60e2                	ld	ra,24(sp)
    4008:	6161                	addi	sp,sp,80
    400a:	8082                	ret

000000000000400c <stbsp_vsprintf>:
{
    400c:	86ae                	mv	a3,a1
    400e:	8732                	mv	a4,a2
   return STB_SPRINTF_DECORATE(vsprintfcb)(0, 0, buf, fmt, va);
    4010:	4581                	li	a1,0
    4012:	862a                	mv	a2,a0
    4014:	4501                	li	a0,0
    4016:	accfe06f          	j	22e2 <stbsp_vsprintfcb>

000000000000401a <sprintf>:
{
    401a:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    401c:	05010313          	addi	t1,sp,80
{
    4020:	e0a2                	sd	s0,64(sp)
    4022:	fc26                	sd	s1,56(sp)
    4024:	842a                	mv	s0,a0
    4026:	e8b2                	sd	a2,80(sp)
    _vprintf_core(&ctx, format, ap);
    4028:	0808                	addi	a0,sp,16
    ctx.limit = size;
    402a:	54fd                	li	s1,-1
    _vprintf_core(&ctx, format, ap);
    402c:	861a                	mv	a2,t1
{
    402e:	e486                	sd	ra,72(sp)
    4030:	ecb6                	sd	a3,88(sp)
    4032:	f0ba                	sd	a4,96(sp)
    4034:	f4be                	sd	a5,104(sp)
    4036:	f8c2                	sd	a6,112(sp)
    4038:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    403a:	e41a                	sd	t1,8(sp)
    ctx.buf = str;
    403c:	e822                	sd	s0,16(sp)
    ctx.limit = size;
    403e:	ec26                	sd	s1,24(sp)
    ctx.written = 0;
    4040:	f002                	sd	zero,32(sp)
    ctx.stream = NULL;
    4042:	f402                	sd	zero,40(sp)
    _vprintf_core(&ctx, format, ap);
    4044:	02c000ef          	jal	4070 <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    4048:	7502                	ld	a0,32(sp)
    404a:	00950b63          	beq	a0,s1,4060 <sprintf+0x46>
            str[ctx.written] = '\0';
    404e:	942a                	add	s0,s0,a0
    4050:	00040023          	sb	zero,0(s0)
}
    4054:	60a6                	ld	ra,72(sp)
    4056:	6406                	ld	s0,64(sp)
    4058:	74e2                	ld	s1,56(sp)
    405a:	2501                	sext.w	a0,a0
    405c:	6109                	addi	sp,sp,128
    405e:	8082                	ret
            str[size - 1] = '\0';
    4060:	fe040f23          	sb	zero,-2(s0)
}
    4064:	60a6                	ld	ra,72(sp)
    4066:	6406                	ld	s0,64(sp)
    4068:	74e2                	ld	s1,56(sp)
    406a:	2501                	sext.w	a0,a0
    406c:	6109                	addi	sp,sp,128
    406e:	8082                	ret

0000000000004070 <_vprintf_core.constprop.0.isra.0>:
static int _vprintf_core(_OutContext *ctx, const char *format, va_list ap)
    4070:	7129                	addi	sp,sp,-320
    4072:	edee                	sd	s11,216(sp)
    4074:	fe06                	sd	ra,312(sp)
    4076:	8dae                	mv	s11,a1
    while (*p)
    4078:	0005c583          	lbu	a1,0(a1)
    407c:	cde9                	beqz	a1,4156 <_vprintf_core.constprop.0.isra.0+0xe6>
    407e:	f626                	sd	s1,296(sp)
    4080:	f24a                	sd	s2,288(sp)
    4082:	ee4e                	sd	s3,280(sp)
    4084:	e656                	sd	s5,264(sp)
    4086:	f9e2                	sd	s8,240(sp)
    4088:	fa22                	sd	s0,304(sp)
    408a:	ea52                	sd	s4,272(sp)
    408c:	e25a                	sd	s6,256(sp)
    408e:	fdde                	sd	s7,248(sp)
    4090:	f5e6                	sd	s9,232(sp)
    4092:	f1ea                	sd	s10,224(sp)
    4094:	84aa                	mv	s1,a0
    4096:	8c32                	mv	s8,a2
        if (*p != '%')
    4098:	02500a93          	li	s5,37
    409c:	49c1                	li	s3,16
    409e:	00002917          	auipc	s2,0x2
    40a2:	3be90913          	addi	s2,s2,958 # 645c <_GLOBAL__sub_I__ZSt3cin+0x458>
    40a6:	a039                	j	40b4 <_vprintf_core.constprop.0.isra.0+0x44>
                _out_char(ctx, spec);
    40a8:	8526                	mv	a0,s1
    40aa:	952fe0ef          	jal	21fc <_out_char>
    while (*p)
    40ae:	000dc583          	lbu	a1,0(s11)
    40b2:	c5d9                	beqz	a1,4140 <_vprintf_core.constprop.0.isra.0+0xd0>
            _out_char(ctx, *p++);
    40b4:	0d85                	addi	s11,s11,1
        if (*p != '%')
    40b6:	ff5599e3          	bne	a1,s5,40a8 <_vprintf_core.constprop.0.isra.0+0x38>
        int flag_left = 0, flag_zero = 0, flag_plus = 0, flag_space = 0, flag_hash = 0;
    40ba:	4501                	li	a0,0
    40bc:	4881                	li	a7,0
    40be:	4581                	li	a1,0
    40c0:	4b01                	li	s6,0
    40c2:	4a01                	li	s4,0
            if (*p == '-')
    40c4:	000dcc83          	lbu	s9,0(s11)
    40c8:	fe0c871b          	addiw	a4,s9,-32
    40cc:	0ff77713          	zext.b	a4,a4
    40d0:	00e9e763          	bltu	s3,a4,40de <_vprintf_core.constprop.0.isra.0+0x6e>
    40d4:	070a                	slli	a4,a4,0x2
    40d6:	974a                	add	a4,a4,s2
    40d8:	4318                	lw	a4,0(a4)
    40da:	974a                	add	a4,a4,s2
    40dc:	8702                	jr	a4
        if (*p == '*')
    40de:	02a00793          	li	a5,42
    40e2:	16fc9c63          	bne	s9,a5,425a <_vprintf_core.constprop.0.isra.0+0x1ea>
            width = va_arg(ap, int);
    40e6:	000c2403          	lw	s0,0(s8)
    40ea:	0c21                	addi	s8,s8,8
            if (width < 0)
    40ec:	00045563          	bgez	s0,40f6 <_vprintf_core.constprop.0.isra.0+0x86>
                width = -width;
    40f0:	4080043b          	negw	s0,s0
                flag_left = 1;
    40f4:	4a05                	li	s4,1
            while (*p >= '0' && *p <= '9')
    40f6:	001dcc83          	lbu	s9,1(s11)
            p++;
    40fa:	0d85                	addi	s11,s11,1
        if (*p == '.')
    40fc:	02e00793          	li	a5,46
        int precision = -1;
    4100:	5bfd                	li	s7,-1
        if (*p == '.')
    4102:	18fc8a63          	beq	s9,a5,4296 <_vprintf_core.constprop.0.isra.0+0x226>
        if (*p == 'l')
    4106:	06c00693          	li	a3,108
    410a:	8666                	mv	a2,s9
    410c:	1adc8663          	beq	s9,a3,42b8 <_vprintf_core.constprop.0.isra.0+0x248>
        else if (*p == 'z')
    4110:	07a00693          	li	a3,122
            p++;
    4114:	0d85                	addi	s11,s11,1
        else if (*p == 'z')
    4116:	24dc8163          	beq	s9,a3,4358 <_vprintf_core.constprop.0.isra.0+0x2e8>
        if (!spec)
    411a:	06400693          	li	a3,100
    411e:	4adc8163          	beq	s9,a3,45c0 <_vprintf_core.constprop.0.isra.0+0x550>
    4122:	06400693          	li	a3,100
        int len_mod = 0;
    4126:	4e81                	li	t4,0
    4128:	1b96e663          	bltu	a3,s9,42d4 <_vprintf_core.constprop.0.isra.0+0x264>
    412c:	04700693          	li	a3,71
    4130:	2796e463          	bltu	a3,s9,4398 <_vprintf_core.constprop.0.isra.0+0x328>
    4134:	04400693          	li	a3,68
    4138:	0596e363          	bltu	a3,s9,417e <_vprintf_core.constprop.0.isra.0+0x10e>
    413c:	240c9363          	bnez	s9,4382 <_vprintf_core.constprop.0.isra.0+0x312>
    4140:	7452                	ld	s0,304(sp)
    4142:	74b2                	ld	s1,296(sp)
    4144:	7912                	ld	s2,288(sp)
    4146:	69f2                	ld	s3,280(sp)
    4148:	6a52                	ld	s4,272(sp)
    414a:	6ab2                	ld	s5,264(sp)
    414c:	6b12                	ld	s6,256(sp)
    414e:	7bee                	ld	s7,248(sp)
    4150:	7c4e                	ld	s8,240(sp)
    4152:	7cae                	ld	s9,232(sp)
    4154:	7d0e                	ld	s10,224(sp)
}
    4156:	70f2                	ld	ra,312(sp)
    4158:	6dee                	ld	s11,216(sp)
    415a:	6131                	addi	sp,sp,320
    415c:	8082                	ret
            if (*p == '-')
    415e:	4585                	li	a1,1
            p++;
    4160:	0d85                	addi	s11,s11,1
            if (*p == '-')
    4162:	b78d                	j	40c4 <_vprintf_core.constprop.0.isra.0+0x54>
    4164:	4505                	li	a0,1
            p++;
    4166:	0d85                	addi	s11,s11,1
        while (1)
    4168:	bfb1                	j	40c4 <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    416a:	4885                	li	a7,1
            p++;
    416c:	0d85                	addi	s11,s11,1
        while (1)
    416e:	bf99                	j	40c4 <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    4170:	4b05                	li	s6,1
            p++;
    4172:	0d85                	addi	s11,s11,1
        while (1)
    4174:	bf81                	j	40c4 <_vprintf_core.constprop.0.isra.0+0x54>
            if (*p == '-')
    4176:	4a05                	li	s4,1
            p++;
    4178:	0d85                	addi	s11,s11,1
        while (1)
    417a:	b7a9                	j	40c4 <_vprintf_core.constprop.0.isra.0+0x54>
        char spec = *p++;
    417c:	8dbe                	mv	s11,a5
            fmt_tmp[f_idx++] = '%';
    417e:	02500693          	li	a3,37
    4182:	02d10823          	sb	a3,48(sp)
    4186:	4d05                	li	s10,1
            if (flag_left)
    4188:	000a0763          	beqz	s4,4196 <_vprintf_core.constprop.0.isra.0+0x126>
                fmt_tmp[f_idx++] = '-';
    418c:	02d00693          	li	a3,45
    4190:	02d108a3          	sb	a3,49(sp)
    4194:	4d09                	li	s10,2
            if (flag_zero)
    4196:	000b0c63          	beqz	s6,41ae <_vprintf_core.constprop.0.isra.0+0x13e>
                fmt_tmp[f_idx++] = '0';
    419a:	0c0d0793          	addi	a5,s10,192
    419e:	0818                	addi	a4,sp,16
    41a0:	00e786b3          	add	a3,a5,a4
    41a4:	03000613          	li	a2,48
    41a8:	f6c68023          	sb	a2,-160(a3)
    41ac:	2d05                	addiw	s10,s10,1
            if (flag_plus)
    41ae:	c999                	beqz	a1,41c4 <_vprintf_core.constprop.0.isra.0+0x154>
                fmt_tmp[f_idx++] = '+';
    41b0:	0c0d0793          	addi	a5,s10,192
    41b4:	0818                	addi	a4,sp,16
    41b6:	00e786b3          	add	a3,a5,a4
    41ba:	02b00613          	li	a2,43
    41be:	f6c68023          	sb	a2,-160(a3)
    41c2:	2d05                	addiw	s10,s10,1
            if (flag_space)
    41c4:	00088c63          	beqz	a7,41dc <_vprintf_core.constprop.0.isra.0+0x16c>
                fmt_tmp[f_idx++] = ' ';
    41c8:	0c0d0793          	addi	a5,s10,192
    41cc:	0818                	addi	a4,sp,16
    41ce:	00e786b3          	add	a3,a5,a4
    41d2:	02000613          	li	a2,32
    41d6:	f6c68023          	sb	a2,-160(a3)
    41da:	2d05                	addiw	s10,s10,1
            if (flag_hash)
    41dc:	c919                	beqz	a0,41f2 <_vprintf_core.constprop.0.isra.0+0x182>
                fmt_tmp[f_idx++] = '#';
    41de:	0c0d0793          	addi	a5,s10,192
    41e2:	0818                	addi	a4,sp,16
    41e4:	00e786b3          	add	a3,a5,a4
    41e8:	02300613          	li	a2,35
    41ec:	f6c68023          	sb	a2,-160(a3)
    41f0:	2d05                	addiw	s10,s10,1
            if (width > 0)
    41f2:	03010a13          	addi	s4,sp,48
    41f6:	28804563          	bgtz	s0,4480 <_vprintf_core.constprop.0.isra.0+0x410>
            if (precision >= 0)
    41fa:	260bd763          	bgez	s7,4468 <_vprintf_core.constprop.0.isra.0+0x3f8>
            fmt_tmp[f_idx++] = spec;
    41fe:	0c0d0793          	addi	a5,s10,192
    4202:	0818                	addi	a4,sp,16
    4204:	00e78633          	add	a2,a5,a4
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    4208:	000c3683          	ld	a3,0(s8)
            fmt_tmp[f_idx] = '\0';
    420c:	001d071b          	addiw	a4,s10,1
    4210:	0c070793          	addi	a5,a4,192
    4214:	0818                	addi	a4,sp,16
            fmt_tmp[f_idx++] = spec;
    4216:	f7960023          	sb	s9,-160(a2)
            fmt_tmp[f_idx] = '\0';
    421a:	973e                	add	a4,a4,a5
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    421c:	08000593          	li	a1,128
    4220:	8652                	mv	a2,s4
    4222:	0888                	addi	a0,sp,80
            fmt_tmp[f_idx] = '\0';
    4224:	f6070023          	sb	zero,-160(a4)
            stbsp_snprintf(f_buf, sizeof(f_buf), fmt_tmp, f_val);
    4228:	dc5ff0ef          	jal	3fec <stbsp_snprintf>
            for (int i = 0; f_buf[i] != '\0'; i++)
    422c:	05014583          	lbu	a1,80(sp)
            double f_val = va_arg(ap, double);
    4230:	0c21                	addi	s8,s8,8
            for (int i = 0; f_buf[i] != '\0'; i++)
    4232:	05110413          	addi	s0,sp,81
    4236:	e6058ce3          	beqz	a1,40ae <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, f_buf[i]);
    423a:	8526                	mv	a0,s1
    423c:	fc1fd0ef          	jal	21fc <_out_char>
            for (int i = 0; f_buf[i] != '\0'; i++)
    4240:	00044583          	lbu	a1,0(s0)
    4244:	0405                	addi	s0,s0,1
    4246:	e60584e3          	beqz	a1,40ae <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, f_buf[i]);
    424a:	8526                	mv	a0,s1
    424c:	fb1fd0ef          	jal	21fc <_out_char>
            for (int i = 0; f_buf[i] != '\0'; i++)
    4250:	00044583          	lbu	a1,0(s0)
    4254:	0405                	addi	s0,s0,1
    4256:	f1f5                	bnez	a1,423a <_vprintf_core.constprop.0.isra.0+0x1ca>
    4258:	bd99                	j	40ae <_vprintf_core.constprop.0.isra.0+0x3e>
            while (*p >= '0' && *p <= '9')
    425a:	fd0c869b          	addiw	a3,s9,-48
    425e:	0ff6f313          	zext.b	t1,a3
    4262:	4725                	li	a4,9
        int width = 0;
    4264:	4401                	li	s0,0
            while (*p >= '0' && *p <= '9')
    4266:	4625                	li	a2,9
    4268:	e8676ae3          	bltu	a4,t1,40fc <_vprintf_core.constprop.0.isra.0+0x8c>
    426c:	001dcc83          	lbu	s9,1(s11)
                width = width * 10 + (*p - '0');
    4270:	0024171b          	slliw	a4,s0,0x2
    4274:	9f21                	addw	a4,a4,s0
    4276:	0017171b          	slliw	a4,a4,0x1
    427a:	00e6843b          	addw	s0,a3,a4
            while (*p >= '0' && *p <= '9')
    427e:	fd0c869b          	addiw	a3,s9,-48
    4282:	0ff6f713          	zext.b	a4,a3
                p++;
    4286:	0d85                	addi	s11,s11,1
            while (*p >= '0' && *p <= '9')
    4288:	fee672e3          	bgeu	a2,a4,426c <_vprintf_core.constprop.0.isra.0+0x1fc>
        if (*p == '.')
    428c:	02e00793          	li	a5,46
        int precision = -1;
    4290:	5bfd                	li	s7,-1
        if (*p == '.')
    4292:	e6fc9ae3          	bne	s9,a5,4106 <_vprintf_core.constprop.0.isra.0+0x96>
            if (*p == '*')
    4296:	001dcc83          	lbu	s9,1(s11)
    429a:	02a00793          	li	a5,42
    429e:	16fc9f63          	bne	s9,a5,441c <_vprintf_core.constprop.0.isra.0+0x3ac>
                while (*p >= '0' && *p <= '9')
    42a2:	002dcc83          	lbu	s9,2(s11)
        if (*p == 'l')
    42a6:	06c00693          	li	a3,108
                precision = va_arg(ap, int);
    42aa:	000c2b83          	lw	s7,0(s8)
                p++;
    42ae:	0d89                	addi	s11,s11,2
                precision = va_arg(ap, int);
    42b0:	0c21                	addi	s8,s8,8
        if (*p == 'l')
    42b2:	8666                	mv	a2,s9
    42b4:	e4dc9ee3          	bne	s9,a3,4110 <_vprintf_core.constprop.0.isra.0+0xa0>
            if (*p == 'l')
    42b8:	001dcc83          	lbu	s9,1(s11)
    42bc:	08cc8d63          	beq	s9,a2,4356 <_vprintf_core.constprop.0.isra.0+0x2e6>
        char spec = *p++;
    42c0:	06400693          	li	a3,100
    42c4:	0d89                	addi	s11,s11,2
        if (!spec)
    42c6:	4cdc8c63          	beq	s9,a3,479e <_vprintf_core.constprop.0.isra.0+0x72e>
    42ca:	06400693          	li	a3,100
            len_mod = 1;
    42ce:	4e85                	li	t4,1
    42d0:	e596fee3          	bgeu	a3,s9,412c <_vprintf_core.constprop.0.isra.0+0xbc>
    42d4:	f9bc869b          	addiw	a3,s9,-101
    42d8:	0ff6f693          	zext.b	a3,a3
    42dc:	464d                	li	a2,19
    42de:	12d66863          	bltu	a2,a3,440e <_vprintf_core.constprop.0.isra.0+0x39e>
    42e2:	4e05                	li	t3,1
    42e4:	00091637          	lui	a2,0x91
    42e8:	00de1333          	sll	t1,t3,a3
    42ec:	81060613          	addi	a2,a2,-2032 # 90810 <_ZSt4cerr+0x879d0>
    42f0:	00c37633          	and	a2,t1,a2
    42f4:	1a061463          	bnez	a2,449c <_vprintf_core.constprop.0.isra.0+0x42c>
    42f8:	00737313          	andi	t1,t1,7
    42fc:	e80311e3          	bnez	t1,417e <_vprintf_core.constprop.0.isra.0+0x10e>
    4300:	4639                	li	a2,14
    4302:	10c69663          	bne	a3,a2,440e <_vprintf_core.constprop.0.isra.0+0x39e>
            const char *s = va_arg(ap, char *);
    4306:	000c3c83          	ld	s9,0(s8)
            if (!s)
    430a:	420c8863          	beqz	s9,473a <_vprintf_core.constprop.0.isra.0+0x6ca>
            while (*tmp && (precision < 0 || len < precision))
    430e:	000cc683          	lbu	a3,0(s9)
    4312:	38068863          	beqz	a3,46a2 <_vprintf_core.constprop.0.isra.0+0x632>
            const char *tmp = s;
    4316:	8666                	mv	a2,s9
            int len = 0;
    4318:	4681                	li	a3,0
            while (*tmp && (precision < 0 || len < precision))
    431a:	00db8863          	beq	s7,a3,432a <_vprintf_core.constprop.0.isra.0+0x2ba>
    431e:	00164583          	lbu	a1,1(a2)
                len++;
    4322:	2685                	addiw	a3,a3,1
                tmp++;
    4324:	0605                	addi	a2,a2,1
            while (*tmp && (precision < 0 || len < precision))
    4326:	f9f5                	bnez	a1,431a <_vprintf_core.constprop.0.isra.0+0x2aa>
    4328:	8bb6                	mv	s7,a3
            int padding = (width > len) ? width - len : 0;
    432a:	268bc563          	blt	s7,s0,4594 <_vprintf_core.constprop.0.isra.0+0x524>
            for (int i = 0; i < len; i++)
    432e:	4401                	li	s0,0
    4330:	020b8163          	beqz	s7,4352 <_vprintf_core.constprop.0.isra.0+0x2e2>
    4334:	4d01                	li	s10,0
                _out_char(ctx, s[i]);
    4336:	01ac86b3          	add	a3,s9,s10
    433a:	0006c583          	lbu	a1,0(a3)
    433e:	8526                	mv	a0,s1
            for (int i = 0; i < len; i++)
    4340:	0d05                	addi	s10,s10,1
                _out_char(ctx, s[i]);
    4342:	ebbfd0ef          	jal	21fc <_out_char>
            for (int i = 0; i < len; i++)
    4346:	000d069b          	sext.w	a3,s10
    434a:	ff76c6e3          	blt	a3,s7,4336 <_vprintf_core.constprop.0.isra.0+0x2c6>
            if (flag_left)
    434e:	260a1463          	bnez	s4,45b6 <_vprintf_core.constprop.0.isra.0+0x546>
            const char *s = va_arg(ap, char *);
    4352:	0c21                	addi	s8,s8,8
    4354:	bba9                	j	40ae <_vprintf_core.constprop.0.isra.0+0x3e>
                p++;
    4356:	0d89                	addi	s11,s11,2
        char spec = *p++;
    4358:	000dcc83          	lbu	s9,0(s11)
    435c:	06400693          	li	a3,100
    4360:	001d8793          	addi	a5,s11,1
        if (!spec)
    4364:	3edc8063          	beq	s9,a3,4744 <_vprintf_core.constprop.0.isra.0+0x6d4>
    4368:	0796ea63          	bltu	a3,s9,43dc <_vprintf_core.constprop.0.isra.0+0x36c>
    436c:	04700693          	li	a3,71
    4370:	0f96e263          	bltu	a3,s9,4454 <_vprintf_core.constprop.0.isra.0+0x3e4>
    4374:	04400693          	li	a3,68
    4378:	e196e2e3          	bltu	a3,s9,417c <_vprintf_core.constprop.0.isra.0+0x10c>
    437c:	dc0c82e3          	beqz	s9,4140 <_vprintf_core.constprop.0.isra.0+0xd0>
        char spec = *p++;
    4380:	8dbe                	mv	s11,a5
            _out_char(ctx, '%');
    4382:	02500593          	li	a1,37
    4386:	8526                	mv	a0,s1
    4388:	e75fd0ef          	jal	21fc <_out_char>
            if (spec != '%')
    438c:	02500713          	li	a4,37
    4390:	d0ec8fe3          	beq	s9,a4,40ae <_vprintf_core.constprop.0.isra.0+0x3e>
                _out_char(ctx, spec);
    4394:	85e6                	mv	a1,s9
    4396:	bb09                	j	40a8 <_vprintf_core.constprop.0.isra.0+0x38>
    4398:	05800693          	li	a3,88
    439c:	2edc8263          	beq	s9,a3,4680 <_vprintf_core.constprop.0.isra.0+0x610>
    43a0:	06300713          	li	a4,99
    43a4:	06ec9563          	bne	s9,a4,440e <_vprintf_core.constprop.0.isra.0+0x39e>
            char c = (char)va_arg(ap, int);
    43a8:	000c4c83          	lbu	s9,0(s8)
            int padding = (width > 1) ? width - 1 : 0;
    43ac:	8722                	mv	a4,s0
    43ae:	00804363          	bgtz	s0,43b4 <_vprintf_core.constprop.0.isra.0+0x344>
    43b2:	4705                	li	a4,1
    43b4:	fff7041b          	addiw	s0,a4,-1
            if (!flag_left)
    43b8:	3c0a0463          	beqz	s4,4780 <_vprintf_core.constprop.0.isra.0+0x710>
            _out_char(ctx, c);
    43bc:	85e6                	mv	a1,s9
    43be:	8526                	mv	a0,s1
    43c0:	e3dfd0ef          	jal	21fc <_out_char>
                for (int i = 0; i < padding; i++)
    43c4:	4a01                	li	s4,0
    43c6:	d451                	beqz	s0,4352 <_vprintf_core.constprop.0.isra.0+0x2e2>
                    _out_char(ctx, ' ');
    43c8:	02000593          	li	a1,32
    43cc:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    43ce:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    43d0:	e2dfd0ef          	jal	21fc <_out_char>
                for (int i = 0; i < padding; i++)
    43d4:	ff441ae3          	bne	s0,s4,43c8 <_vprintf_core.constprop.0.isra.0+0x358>
            const char *s = va_arg(ap, char *);
    43d8:	0c21                	addi	s8,s8,8
    43da:	b9d1                	j	40ae <_vprintf_core.constprop.0.isra.0+0x3e>
    43dc:	f9bc861b          	addiw	a2,s9,-101
    43e0:	0ff67613          	zext.b	a2,a2
    43e4:	46cd                	li	a3,19
    43e6:	40c6e963          	bltu	a3,a2,47f8 <_vprintf_core.constprop.0.isra.0+0x788>
    43ea:	00091337          	lui	t1,0x91
    43ee:	4685                	li	a3,1
    43f0:	00c696b3          	sll	a3,a3,a2
    43f4:	81030313          	addi	t1,t1,-2032 # 90810 <_ZSt4cerr+0x879d0>
    43f8:	0066f333          	and	t1,a3,t1
    43fc:	34031c63          	bnez	t1,4754 <_vprintf_core.constprop.0.isra.0+0x6e4>
    4400:	8a9d                	andi	a3,a3,7
    4402:	d6069de3          	bnez	a3,417c <_vprintf_core.constprop.0.isra.0+0x10c>
    4406:	46b9                	li	a3,14
        char spec = *p++;
    4408:	8dbe                	mv	s11,a5
    440a:	eed60ee3          	beq	a2,a3,4306 <_vprintf_core.constprop.0.isra.0+0x296>
            _out_char(ctx, '%');
    440e:	02500593          	li	a1,37
    4412:	8526                	mv	a0,s1
    4414:	de9fd0ef          	jal	21fc <_out_char>
                _out_char(ctx, spec);
    4418:	85e6                	mv	a1,s9
    441a:	b179                	j	40a8 <_vprintf_core.constprop.0.isra.0+0x38>
                while (*p >= '0' && *p <= '9')
    441c:	fd0c869b          	addiw	a3,s9,-48
    4420:	0ff6fe13          	zext.b	t3,a3
    4424:	4625                	li	a2,9
            p++;
    4426:	0d85                	addi	s11,s11,1
                precision = 0;
    4428:	4b81                	li	s7,0
                while (*p >= '0' && *p <= '9')
    442a:	4325                	li	t1,9
    442c:	cdc66de3          	bltu	a2,t3,4106 <_vprintf_core.constprop.0.isra.0+0x96>
                    precision = precision * 10 + (*p - '0');
    4430:	002b961b          	slliw	a2,s7,0x2
                while (*p >= '0' && *p <= '9')
    4434:	001dcc83          	lbu	s9,1(s11)
                    precision = precision * 10 + (*p - '0');
    4438:	0176073b          	addw	a4,a2,s7
    443c:	0017171b          	slliw	a4,a4,0x1
    4440:	00e68bbb          	addw	s7,a3,a4
                while (*p >= '0' && *p <= '9')
    4444:	fd0c869b          	addiw	a3,s9,-48
    4448:	0ff6f613          	zext.b	a2,a3
                    p++;
    444c:	0d85                	addi	s11,s11,1
                while (*p >= '0' && *p <= '9')
    444e:	fec371e3          	bgeu	t1,a2,4430 <_vprintf_core.constprop.0.isra.0+0x3c0>
    4452:	b955                	j	4106 <_vprintf_core.constprop.0.isra.0+0x96>
    4454:	05800693          	li	a3,88
    4458:	3cdc8d63          	beq	s9,a3,4832 <_vprintf_core.constprop.0.isra.0+0x7c2>
    445c:	06300713          	li	a4,99
        char spec = *p++;
    4460:	8dbe                	mv	s11,a5
    4462:	f4ec83e3          	beq	s9,a4,43a8 <_vprintf_core.constprop.0.isra.0+0x338>
    4466:	b765                	j	440e <_vprintf_core.constprop.0.isra.0+0x39e>
                f_idx += sprintf(&fmt_tmp[f_idx], ".%d", precision);
    4468:	01aa0533          	add	a0,s4,s10
    446c:	865e                	mv	a2,s7
    446e:	00002597          	auipc	a1,0x2
    4472:	d7258593          	addi	a1,a1,-654 # 61e0 <_GLOBAL__sub_I__ZSt3cin+0x1dc>
    4476:	ba5ff0ef          	jal	401a <sprintf>
    447a:	00ad0d3b          	addw	s10,s10,a0
    447e:	b341                	j	41fe <_vprintf_core.constprop.0.isra.0+0x18e>
                f_idx += sprintf(&fmt_tmp[f_idx], "%d", width);
    4480:	01aa0533          	add	a0,s4,s10
    4484:	8622                	mv	a2,s0
    4486:	00002597          	auipc	a1,0x2
    448a:	d5258593          	addi	a1,a1,-686 # 61d8 <_GLOBAL__sub_I__ZSt3cin+0x1d4>
    448e:	b8dff0ef          	jal	401a <sprintf>
    4492:	00ad0d3b          	addw	s10,s10,a0
            if (precision >= 0)
    4496:	d60bc4e3          	bltz	s7,41fe <_vprintf_core.constprop.0.isra.0+0x18e>
    449a:	b7f9                	j	4468 <_vprintf_core.constprop.0.isra.0+0x3f8>
            int is_signed = (spec == 'd' || spec == 'i');
    449c:	06900693          	li	a3,105
    44a0:	10dc8e63          	beq	s9,a3,45bc <_vprintf_core.constprop.0.isra.0+0x54c>
                val = (uint64)va_arg(ap, void *);
    44a4:	008c0793          	addi	a5,s8,8
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    44a8:	07800693          	li	a3,120
                val = (uint64)va_arg(ap, void *);
    44ac:	e43e                	sd	a5,8(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    44ae:	38dc9d63          	bne	s9,a3,4848 <_vprintf_core.constprop.0.isra.0+0x7d8>
            else if (len_mod == 1)
    44b2:	33ce8963          	beq	t4,t3,47e4 <_vprintf_core.constprop.0.isra.0+0x774>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    44b6:	000c6e03          	lwu	t3,0(s8)
    44ba:	85f6                	mv	a1,t4
    44bc:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    44be:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    44c0:	00002f97          	auipc	t6,0x2
    44c4:	ce8f8f93          	addi	t6,t6,-792 # 61a8 <_GLOBAL__sub_I__ZSt3cin+0x1a4>
    if (val == 0)
    44c8:	120e0363          	beqz	t3,45ee <_vprintf_core.constprop.0.isra.0+0x57e>
    44cc:	01010293          	addi	t0,sp,16
                    sign_char = '-';
    44d0:	8616                	mv	a2,t0
    44d2:	86f2                	mv	a3,t3
        buf[i++] = digits[val % base];
    44d4:	0266f8b3          	remu	a7,a3,t1
    44d8:	8f32                	mv	t5,a2
    while (val != 0)
    44da:	0605                	addi	a2,a2,1
    44dc:	8eb6                	mv	t4,a3
        buf[i++] = digits[val % base];
    44de:	98fe                	add	a7,a7,t6
    44e0:	0008c883          	lbu	a7,0(a7)
        val /= base;
    44e4:	0266d6b3          	divu	a3,a3,t1
        buf[i++] = digits[val % base];
    44e8:	ff160fa3          	sb	a7,-1(a2)
    while (val != 0)
    44ec:	fe6ef4e3          	bgeu	t4,t1,44d4 <_vprintf_core.constprop.0.isra.0+0x464>
        buf[i++] = digits[val % base];
    44f0:	405f0f3b          	subw	t5,t5,t0
    44f4:	2f05                	addiw	t5,t5,1
            if (precision >= 0)
    44f6:	100bc363          	bltz	s7,45fc <_vprintf_core.constprop.0.isra.0+0x58c>
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    44fa:	1d7f4d63          	blt	t5,s7,46d4 <_vprintf_core.constprop.0.isra.0+0x664>
            if (precision == 0 && val == 0)
    44fe:	340b9163          	bnez	s7,4840 <_vprintf_core.constprop.0.isra.0+0x7d0>
    4502:	200e0763          	beqz	t3,4710 <_vprintf_core.constprop.0.isra.0+0x6a0>
            for (int i = digit_len - 1; i >= 0; i--)
    4506:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    450a:	07000693          	li	a3,112
            for (int i = digit_len - 1; i >= 0; i--)
    450e:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    4510:	28dc8e63          	beq	s9,a3,47ac <_vprintf_core.constprop.0.isra.0+0x73c>
    4514:	2a051663          	bnez	a0,47c0 <_vprintf_core.constprop.0.isra.0+0x750>
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    4518:	00bf05bb          	addw	a1,t5,a1
    451c:	8d52                	mv	s10,s4
    451e:	4b01                	li	s6,0
            char *prefix_str = NULL;
    4520:	4c81                	li	s9,0
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    4522:	1085d263          	bge	a1,s0,4626 <_vprintf_core.constprop.0.isra.0+0x5b6>
    4526:	9c0d                	subw	s0,s0,a1
            if (!flag_left && !flag_zero)
    4528:	100d0a63          	beqz	s10,463c <_vprintf_core.constprop.0.isra.0+0x5cc>
            if (sign_char)
    452c:	6782                	ld	a5,0(sp)
    452e:	10079263          	bnez	a5,4632 <_vprintf_core.constprop.0.isra.0+0x5c2>
            if (prefix_str)
    4532:	000c8c63          	beqz	s9,454a <_vprintf_core.constprop.0.isra.0+0x4da>
                _out_char(ctx, prefix_str[0]);
    4536:	000cc583          	lbu	a1,0(s9)
    453a:	8526                	mv	a0,s1
    453c:	cc1fd0ef          	jal	21fc <_out_char>
                _out_char(ctx, prefix_str[1]);
    4540:	001cc583          	lbu	a1,1(s9)
    4544:	8526                	mv	a0,s1
    4546:	cb7fd0ef          	jal	21fc <_out_char>
            int total_zeros = prec_zeros + ((flag_zero && !flag_left) ? padding : 0);
    454a:	180b0263          	beqz	s6,46ce <_vprintf_core.constprop.0.isra.0+0x65e>
    454e:	100a1863          	bnez	s4,465e <_vprintf_core.constprop.0.isra.0+0x5ee>
    4552:	008b8bbb          	addw	s7,s7,s0
            for (int i = 0; i < total_zeros; i++)
    4556:	2a0b8363          	beqz	s7,47fc <_vprintf_core.constprop.0.isra.0+0x78c>
    455a:	4c81                	li	s9,0
                _out_char(ctx, '0');
    455c:	03000593          	li	a1,48
    4560:	8526                	mv	a0,s1
            for (int i = 0; i < total_zeros; i++)
    4562:	2c85                	addiw	s9,s9,1
                _out_char(ctx, '0');
    4564:	c99fd0ef          	jal	21fc <_out_char>
            for (int i = 0; i < total_zeros; i++)
    4568:	ff7c9ae3          	bne	s9,s7,455c <_vprintf_core.constprop.0.isra.0+0x4ec>
            for (int i = digit_len - 1; i >= 0; i--)
    456c:	57fd                	li	a5,-1
    456e:	00fc0f63          	beq	s8,a5,458c <_vprintf_core.constprop.0.isra.0+0x51c>
    4572:	01010c93          	addi	s9,sp,16
    4576:	9ce2                	add	s9,s9,s8
    4578:	00f10c13          	addi	s8,sp,15
                _out_char(ctx, num_buf[i]);
    457c:	000cc583          	lbu	a1,0(s9)
    4580:	8526                	mv	a0,s1
            for (int i = digit_len - 1; i >= 0; i--)
    4582:	1cfd                	addi	s9,s9,-1
                _out_char(ctx, num_buf[i]);
    4584:	c79fd0ef          	jal	21fc <_out_char>
            for (int i = digit_len - 1; i >= 0; i--)
    4588:	ff9c1ae3          	bne	s8,s9,457c <_vprintf_core.constprop.0.isra.0+0x50c>
            if (flag_left)
    458c:	0c0a1e63          	bnez	s4,4668 <_vprintf_core.constprop.0.isra.0+0x5f8>
        char spec = *p++;
    4590:	6c22                	ld	s8,8(sp)
    4592:	be31                	j	40ae <_vprintf_core.constprop.0.isra.0+0x3e>
            int padding = (width > len) ? width - len : 0;
    4594:	4174043b          	subw	s0,s0,s7
            if (!flag_left)
    4598:	100a0a63          	beqz	s4,46ac <_vprintf_core.constprop.0.isra.0+0x63c>
            for (int i = 0; i < len; i++)
    459c:	d80b9ce3          	bnez	s7,4334 <_vprintf_core.constprop.0.isra.0+0x2c4>
                for (int i = 0; i < padding; i++)
    45a0:	4a01                	li	s4,0
                    _out_char(ctx, ' ');
    45a2:	02000593          	li	a1,32
    45a6:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    45a8:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    45aa:	c53fd0ef          	jal	21fc <_out_char>
                for (int i = 0; i < padding; i++)
    45ae:	ff441ae3          	bne	s0,s4,45a2 <_vprintf_core.constprop.0.isra.0+0x532>
            const char *s = va_arg(ap, char *);
    45b2:	0c21                	addi	s8,s8,8
    45b4:	bced                	j	40ae <_vprintf_core.constprop.0.isra.0+0x3e>
                for (int i = 0; i < padding; i++)
    45b6:	f46d                	bnez	s0,45a0 <_vprintf_core.constprop.0.isra.0+0x530>
            const char *s = va_arg(ap, char *);
    45b8:	0c21                	addi	s8,s8,8
    45ba:	bcd5                	j	40ae <_vprintf_core.constprop.0.isra.0+0x3e>
            else if (len_mod == 1)
    45bc:	1fce8163          	beq	t4,t3,479e <_vprintf_core.constprop.0.isra.0+0x72e>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    45c0:	000c2e03          	lw	t3,0(s8)
    45c4:	008c0793          	addi	a5,s8,8
    45c8:	e43e                	sd	a5,8(sp)
                int64 sval = (int64)val;
    45ca:	86f2                	mv	a3,t3
                if (sval < 0)
    45cc:	1406cb63          	bltz	a3,4722 <_vprintf_core.constprop.0.isra.0+0x6b2>
                    sign_char = '+';
    45d0:	02b00793          	li	a5,43
    45d4:	e03e                	sd	a5,0(sp)
                else if (flag_plus)
    45d6:	e589                	bnez	a1,45e0 <_vprintf_core.constprop.0.isra.0+0x570>
                else if (flag_space)
    45d8:	00589793          	slli	a5,a7,0x5
    45dc:	e03e                	sd	a5,0(sp)
    45de:	85c6                	mv	a1,a7
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    45e0:	4329                	li	t1,10
    45e2:	00002f97          	auipc	t6,0x2
    45e6:	bc6f8f93          	addi	t6,t6,-1082 # 61a8 <_GLOBAL__sub_I__ZSt3cin+0x1a4>
    if (val == 0)
    45ea:	ee0e11e3          	bnez	t3,44cc <_vprintf_core.constprop.0.isra.0+0x45c>
        buf[i++] = '0';
    45ee:	03000693          	li	a3,48
    45f2:	00d10823          	sb	a3,16(sp)
        return i;
    45f6:	4f05                	li	t5,1
            if (precision >= 0)
    45f8:	f00bd1e3          	bgez	s7,44fa <_vprintf_core.constprop.0.isra.0+0x48a>
            for (int i = digit_len - 1; i >= 0; i--)
    45fc:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    4600:	07000893          	li	a7,112
            if (!flag_left && !flag_zero)
    4604:	016a6d33          	or	s10,s4,s6
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    4608:	4b81                	li	s7,0
            for (int i = digit_len - 1; i >= 0; i--)
    460a:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    460c:	0d1c9f63          	bne	s9,a7,46ea <_vprintf_core.constprop.0.isra.0+0x67a>
                prefix_str = (spec == 'X') ? "0X" : "0x";
    4610:	00002c97          	auipc	s9,0x2
    4614:	bb0c8c93          	addi	s9,s9,-1104 # 61c0 <_GLOBAL__sub_I__ZSt3cin+0x1bc>
                prefix_len += 2;
    4618:	2589                	addiw	a1,a1,2
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    461a:	017585bb          	addw	a1,a1,s7
    461e:	01e585bb          	addw	a1,a1,t5
    4622:	f085c2e3          	blt	a1,s0,4526 <_vprintf_core.constprop.0.isra.0+0x4b6>
            if (!flag_left && !flag_zero)
    4626:	080d0f63          	beqz	s10,46c4 <_vprintf_core.constprop.0.isra.0+0x654>
            if (sign_char)
    462a:	6782                	ld	a5,0(sp)
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    462c:	4401                	li	s0,0
            if (sign_char)
    462e:	f00782e3          	beqz	a5,4532 <_vprintf_core.constprop.0.isra.0+0x4c2>
                _out_char(ctx, sign_char);
    4632:	6582                	ld	a1,0(sp)
    4634:	8526                	mv	a0,s1
    4636:	bc7fd0ef          	jal	21fc <_out_char>
    463a:	bde5                	j	4532 <_vprintf_core.constprop.0.isra.0+0x4c2>
                    _out_char(ctx, ' ');
    463c:	02000593          	li	a1,32
    4640:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    4642:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    4644:	bb9fd0ef          	jal	21fc <_out_char>
                for (int i = 0; i < padding; i++)
    4648:	efa402e3          	beq	s0,s10,452c <_vprintf_core.constprop.0.isra.0+0x4bc>
                    _out_char(ctx, ' ');
    464c:	02000593          	li	a1,32
    4650:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    4652:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    4654:	ba9fd0ef          	jal	21fc <_out_char>
                for (int i = 0; i < padding; i++)
    4658:	ffa412e3          	bne	s0,s10,463c <_vprintf_core.constprop.0.isra.0+0x5cc>
    465c:	bdc1                	j	452c <_vprintf_core.constprop.0.isra.0+0x4bc>
            for (int i = 0; i < total_zeros; i++)
    465e:	ee0b9ee3          	bnez	s7,455a <_vprintf_core.constprop.0.isra.0+0x4ea>
            for (int i = digit_len - 1; i >= 0; i--)
    4662:	577d                	li	a4,-1
    4664:	f0ec17e3          	bne	s8,a4,4572 <_vprintf_core.constprop.0.isra.0+0x502>
                for (int i = 0; i < padding; i++)
    4668:	d405                	beqz	s0,4590 <_vprintf_core.constprop.0.isra.0+0x520>
    466a:	4a01                	li	s4,0
                    _out_char(ctx, ' ');
    466c:	02000593          	li	a1,32
    4670:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    4672:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    4674:	b89fd0ef          	jal	21fc <_out_char>
                for (int i = 0; i < padding; i++)
    4678:	fe8a1ae3          	bne	s4,s0,466c <_vprintf_core.constprop.0.isra.0+0x5fc>
        char spec = *p++;
    467c:	6c22                	ld	s8,8(sp)
    467e:	bc05                	j	40ae <_vprintf_core.constprop.0.isra.0+0x3e>
                val = (uint64)va_arg(ap, void *);
    4680:	008c0793          	addi	a5,s8,8
    4684:	e43e                	sd	a5,8(sp)
            else if (len_mod == 1)
    4686:	180e9163          	bnez	t4,4808 <_vprintf_core.constprop.0.isra.0+0x798>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    468a:	000c6e03          	lwu	t3,0(s8)
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    468e:	4581                	li	a1,0
    4690:	05800c93          	li	s9,88
    4694:	e002                	sd	zero,0(sp)
    4696:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    4698:	00002f97          	auipc	t6,0x2
    469c:	af8f8f93          	addi	t6,t6,-1288 # 6190 <_GLOBAL__sub_I__ZSt3cin+0x18c>
    46a0:	b525                	j	44c8 <_vprintf_core.constprop.0.isra.0+0x458>
            int padding = (width > len) ? width - len : 0;
    46a2:	ca8058e3          	blez	s0,4352 <_vprintf_core.constprop.0.isra.0+0x2e2>
            if (!flag_left)
    46a6:	ee0a1de3          	bnez	s4,45a0 <_vprintf_core.constprop.0.isra.0+0x530>
            int len = 0;
    46aa:	4b81                	li	s7,0
                for (int i = 0; i < padding; i++)
    46ac:	4d01                	li	s10,0
                    _out_char(ctx, ' ');
    46ae:	02000593          	li	a1,32
    46b2:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    46b4:	2d05                	addiw	s10,s10,1
                    _out_char(ctx, ' ');
    46b6:	b47fd0ef          	jal	21fc <_out_char>
                for (int i = 0; i < padding; i++)
    46ba:	fe8d1ae3          	bne	s10,s0,46ae <_vprintf_core.constprop.0.isra.0+0x63e>
            for (int i = 0; i < len; i++)
    46be:	c60b9be3          	bnez	s7,4334 <_vprintf_core.constprop.0.isra.0+0x2c4>
    46c2:	b941                	j	4352 <_vprintf_core.constprop.0.isra.0+0x2e2>
            if (sign_char)
    46c4:	6782                	ld	a5,0(sp)
    46c6:	4401                	li	s0,0
    46c8:	f7ad                	bnez	a5,4632 <_vprintf_core.constprop.0.isra.0+0x5c2>
            if (prefix_str)
    46ca:	e60c96e3          	bnez	s9,4536 <_vprintf_core.constprop.0.isra.0+0x4c6>
            for (int i = 0; i < total_zeros; i++)
    46ce:	e80b96e3          	bnez	s7,455a <_vprintf_core.constprop.0.isra.0+0x4ea>
    46d2:	bd69                	j	456c <_vprintf_core.constprop.0.isra.0+0x4fc>
            int prec_zeros = (precision > digit_len) ? precision - digit_len : 0;
    46d4:	41eb8bbb          	subw	s7,s7,t5
    46d8:	8d52                	mv	s10,s4
    46da:	4b01                	li	s6,0
            for (int i = digit_len - 1; i >= 0; i--)
    46dc:	ffff0c1b          	addiw	s8,t5,-1
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    46e0:	07000893          	li	a7,112
            for (int i = digit_len - 1; i >= 0; i--)
    46e4:	8662                	mv	a2,s8
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    46e6:	f31c85e3          	beq	s9,a7,4610 <_vprintf_core.constprop.0.isra.0+0x5a0>
    46ea:	cd09                	beqz	a0,4704 <_vprintf_core.constprop.0.isra.0+0x694>
    46ec:	000e0c63          	beqz	t3,4704 <_vprintf_core.constprop.0.isra.0+0x694>
    46f0:	07800513          	li	a0,120
            for (int i = digit_len - 1; i >= 0; i--)
    46f4:	00060c1b          	sext.w	s8,a2
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    46f8:	f0ac8ce3          	beq	s9,a0,4610 <_vprintf_core.constprop.0.isra.0+0x5a0>
    46fc:	05800613          	li	a2,88
    4700:	12cc8463          	beq	s9,a2,4828 <_vprintf_core.constprop.0.isra.0+0x7b8>
            int padding = (width > prefix_len + prec_zeros + digit_len) ? width - (prefix_len + prec_zeros + digit_len) : 0;
    4704:	00bb85bb          	addw	a1,s7,a1
    4708:	01e585bb          	addw	a1,a1,t5
            char *prefix_str = NULL;
    470c:	4c81                	li	s9,0
    470e:	bd11                	j	4522 <_vprintf_core.constprop.0.isra.0+0x4b2>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    4710:	07000693          	li	a3,112
    4714:	8d52                	mv	s10,s4
    4716:	4b01                	li	s6,0
    4718:	08dc8d63          	beq	s9,a3,47b2 <_vprintf_core.constprop.0.isra.0+0x742>
    471c:	5c7d                	li	s8,-1
            char *prefix_str = NULL;
    471e:	4c81                	li	s9,0
    4720:	b509                	j	4522 <_vprintf_core.constprop.0.isra.0+0x4b2>
                    sign_char = '-';
    4722:	02d00793          	li	a5,45
                    val = (uint64)(-sval);
    4726:	40d00e33          	neg	t3,a3
    472a:	4585                	li	a1,1
    472c:	4329                	li	t1,10
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    472e:	00002f97          	auipc	t6,0x2
    4732:	a7af8f93          	addi	t6,t6,-1414 # 61a8 <_GLOBAL__sub_I__ZSt3cin+0x1a4>
                    sign_char = '-';
    4736:	e03e                	sd	a5,0(sp)
    4738:	bb51                	j	44cc <_vprintf_core.constprop.0.isra.0+0x45c>
                s = "(null)";
    473a:	00002c97          	auipc	s9,0x2
    473e:	a96c8c93          	addi	s9,s9,-1386 # 61d0 <_GLOBAL__sub_I__ZSt3cin+0x1cc>
    4742:	bed1                	j	4316 <_vprintf_core.constprop.0.isra.0+0x2a6>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    4744:	000c3683          	ld	a3,0(s8)
    4748:	008c0713          	addi	a4,s8,8
    474c:	e43a                	sd	a4,8(sp)
    474e:	8dbe                	mv	s11,a5
    4750:	8e36                	mv	t3,a3
            if (is_signed)
    4752:	bdad                	j	45cc <_vprintf_core.constprop.0.isra.0+0x55c>
            int is_signed = (spec == 'd' || spec == 'i');
    4754:	06900693          	li	a3,105
    4758:	fedc86e3          	beq	s9,a3,4744 <_vprintf_core.constprop.0.isra.0+0x6d4>
                val = (uint64)va_arg(ap, void *);
    475c:	008c0713          	addi	a4,s8,8
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    4760:	07800693          	li	a3,120
                val = (uint64)va_arg(ap, void *);
    4764:	e43a                	sd	a4,8(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    4766:	06dc9063          	bne	s9,a3,47c6 <_vprintf_core.constprop.0.isra.0+0x756>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    476a:	000c3e03          	ld	t3,0(s8)
    476e:	8dbe                	mv	s11,a5
    4770:	4581                	li	a1,0
    4772:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    4774:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    4776:	00002f97          	auipc	t6,0x2
    477a:	a32f8f93          	addi	t6,t6,-1486 # 61a8 <_GLOBAL__sub_I__ZSt3cin+0x1a4>
    477e:	b3a9                	j	44c8 <_vprintf_core.constprop.0.isra.0+0x458>
                for (int i = 0; i < padding; i++)
    4780:	c809                	beqz	s0,4792 <_vprintf_core.constprop.0.isra.0+0x722>
                    _out_char(ctx, ' ');
    4782:	02000593          	li	a1,32
    4786:	8526                	mv	a0,s1
                for (int i = 0; i < padding; i++)
    4788:	2a05                	addiw	s4,s4,1
                    _out_char(ctx, ' ');
    478a:	a73fd0ef          	jal	21fc <_out_char>
                for (int i = 0; i < padding; i++)
    478e:	ff441ae3          	bne	s0,s4,4782 <_vprintf_core.constprop.0.isra.0+0x712>
            _out_char(ctx, c);
    4792:	85e6                	mv	a1,s9
    4794:	8526                	mv	a0,s1
    4796:	a67fd0ef          	jal	21fc <_out_char>
            const char *s = va_arg(ap, char *);
    479a:	0c21                	addi	s8,s8,8
    479c:	ba09                	j	40ae <_vprintf_core.constprop.0.isra.0+0x3e>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    479e:	000c3683          	ld	a3,0(s8)
    47a2:	008c0793          	addi	a5,s8,8
    47a6:	e43e                	sd	a5,8(sp)
    47a8:	8e36                	mv	t3,a3
            if (is_signed)
    47aa:	b50d                	j	45cc <_vprintf_core.constprop.0.isra.0+0x55c>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    47ac:	8d52                	mv	s10,s4
    47ae:	4b01                	li	s6,0
    47b0:	b585                	j	4610 <_vprintf_core.constprop.0.isra.0+0x5a0>
                digit_len = 0;
    47b2:	4f01                	li	t5,0
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    47b4:	5c7d                	li	s8,-1
                prefix_str = (spec == 'X') ? "0X" : "0x";
    47b6:	00002c97          	auipc	s9,0x2
    47ba:	a0ac8c93          	addi	s9,s9,-1526 # 61c0 <_GLOBAL__sub_I__ZSt3cin+0x1bc>
    47be:	bda9                	j	4618 <_vprintf_core.constprop.0.isra.0+0x5a8>
            if (spec == 'p' || (flag_hash && val != 0 && (spec == 'x' || spec == 'X')))
    47c0:	8d52                	mv	s10,s4
    47c2:	4b01                	li	s6,0
    47c4:	b735                	j	46f0 <_vprintf_core.constprop.0.isra.0+0x680>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    47c6:	07000693          	li	a3,112
    47ca:	04dc8263          	beq	s9,a3,480e <_vprintf_core.constprop.0.isra.0+0x79e>
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    47ce:	000c3e03          	ld	t3,0(s8)
    47d2:	8dbe                	mv	s11,a5
    47d4:	4581                	li	a1,0
    47d6:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    47d8:	4329                	li	t1,10
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    47da:	00002f97          	auipc	t6,0x2
    47de:	9cef8f93          	addi	t6,t6,-1586 # 61a8 <_GLOBAL__sub_I__ZSt3cin+0x1a4>
    47e2:	b1dd                	j	44c8 <_vprintf_core.constprop.0.isra.0+0x458>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    47e4:	000c3e03          	ld	t3,0(s8)
    47e8:	4581                	li	a1,0
    47ea:	e002                	sd	zero,0(sp)
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    47ec:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    47ee:	00002f97          	auipc	t6,0x2
    47f2:	9baf8f93          	addi	t6,t6,-1606 # 61a8 <_GLOBAL__sub_I__ZSt3cin+0x1a4>
    47f6:	b9c9                	j	44c8 <_vprintf_core.constprop.0.isra.0+0x458>
        char spec = *p++;
    47f8:	8dbe                	mv	s11,a5
    47fa:	b911                	j	440e <_vprintf_core.constprop.0.isra.0+0x39e>
            for (int i = digit_len - 1; i >= 0; i--)
    47fc:	577d                	li	a4,-1
    47fe:	4401                	li	s0,0
    4800:	d6ec19e3          	bne	s8,a4,4572 <_vprintf_core.constprop.0.isra.0+0x502>
        char spec = *p++;
    4804:	6c22                	ld	s8,8(sp)
    4806:	b065                	j	40ae <_vprintf_core.constprop.0.isra.0+0x3e>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    4808:	000c3e03          	ld	t3,0(s8)
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    480c:	b549                	j	468e <_vprintf_core.constprop.0.isra.0+0x61e>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    480e:	8dbe                	mv	s11,a5
                val = (uint64)va_arg(ap, void *);
    4810:	000c3e03          	ld	t3,0(s8)
    4814:	4581                	li	a1,0
    4816:	07000c93          	li	s9,112
    481a:	e002                	sd	zero,0(sp)
    481c:	4341                	li	t1,16
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    481e:	00002f97          	auipc	t6,0x2
    4822:	98af8f93          	addi	t6,t6,-1654 # 61a8 <_GLOBAL__sub_I__ZSt3cin+0x1a4>
    4826:	b14d                	j	44c8 <_vprintf_core.constprop.0.isra.0+0x458>
                prefix_str = (spec == 'X') ? "0X" : "0x";
    4828:	00002c97          	auipc	s9,0x2
    482c:	9a0c8c93          	addi	s9,s9,-1632 # 61c8 <_GLOBAL__sub_I__ZSt3cin+0x1c4>
    4830:	b3e5                	j	4618 <_vprintf_core.constprop.0.isra.0+0x5a8>
                val = (uint64)va_arg(ap, void *);
    4832:	008c0713          	addi	a4,s8,8
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    4836:	000c3e03          	ld	t3,0(s8)
                val = (uint64)va_arg(ap, void *);
    483a:	e43a                	sd	a4,8(sp)
                val = is_signed ? (uint64)va_arg(ap, int64) : va_arg(ap, uint64);
    483c:	8dbe                	mv	s11,a5
    483e:	bd81                	j	468e <_vprintf_core.constprop.0.isra.0+0x61e>
    4840:	8d52                	mv	s10,s4
    4842:	4b01                	li	s6,0
    4844:	4b81                	li	s7,0
    4846:	bd59                	j	46dc <_vprintf_core.constprop.0.isra.0+0x66c>
            int base = (spec == 'x' || spec == 'X' || spec == 'p') ? 16 : 10;
    4848:	07000693          	li	a3,112
    484c:	fcdc82e3          	beq	s9,a3,4810 <_vprintf_core.constprop.0.isra.0+0x7a0>
            else if (len_mod == 1)
    4850:	01ce8c63          	beq	t4,t3,4868 <_vprintf_core.constprop.0.isra.0+0x7f8>
                val = is_signed ? (uint64)((int64)va_arg(ap, int)) : (uint64)va_arg(ap, uint32);
    4854:	000c6e03          	lwu	t3,0(s8)
    const char *digits = uppercase ? "0123456789ABCDEF" : "0123456789abcdef";
    4858:	4581                	li	a1,0
    485a:	e002                	sd	zero,0(sp)
    485c:	4329                	li	t1,10
    485e:	00002f97          	auipc	t6,0x2
    4862:	94af8f93          	addi	t6,t6,-1718 # 61a8 <_GLOBAL__sub_I__ZSt3cin+0x1a4>
    4866:	b18d                	j	44c8 <_vprintf_core.constprop.0.isra.0+0x458>
                val = is_signed ? (uint64)va_arg(ap, long) : (uint64)va_arg(ap, unsigned long);
    4868:	000c3e03          	ld	t3,0(s8)
            if (is_signed)
    486c:	b7f5                	j	4858 <_vprintf_core.constprop.0.isra.0+0x7e8>

000000000000486e <vsnprintf>:
{
    486e:	7139                	addi	sp,sp,-64
    4870:	f822                	sd	s0,48(sp)
    4872:	f426                	sd	s1,40(sp)
    4874:	842e                	mv	s0,a1
    4876:	84aa                	mv	s1,a0
    4878:	85b2                	mv	a1,a2
    _vprintf_core(&ctx, format, ap);
    487a:	850a                	mv	a0,sp
    487c:	8636                	mv	a2,a3
{
    487e:	fc06                	sd	ra,56(sp)
    ctx.buf = str;
    4880:	e026                	sd	s1,0(sp)
    ctx.limit = size;
    4882:	e422                	sd	s0,8(sp)
    ctx.written = 0;
    4884:	e802                	sd	zero,16(sp)
    ctx.stream = NULL;
    4886:	ec02                	sd	zero,24(sp)
    _vprintf_core(&ctx, format, ap);
    4888:	fe8ff0ef          	jal	4070 <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    488c:	6542                	ld	a0,16(sp)
    if (size > 0)
    488e:	c411                	beqz	s0,489a <vsnprintf+0x2c>
        if (ctx.written < size)
    4890:	00857b63          	bgeu	a0,s0,48a6 <vsnprintf+0x38>
            str[ctx.written] = '\0';
    4894:	94aa                	add	s1,s1,a0
    4896:	00048023          	sb	zero,0(s1)
}
    489a:	70e2                	ld	ra,56(sp)
    489c:	7442                	ld	s0,48(sp)
    489e:	74a2                	ld	s1,40(sp)
    48a0:	2501                	sext.w	a0,a0
    48a2:	6121                	addi	sp,sp,64
    48a4:	8082                	ret
            str[size - 1] = '\0';
    48a6:	94a2                	add	s1,s1,s0
    48a8:	fe048fa3          	sb	zero,-1(s1)
}
    48ac:	70e2                	ld	ra,56(sp)
    48ae:	7442                	ld	s0,48(sp)
    48b0:	74a2                	ld	s1,40(sp)
    48b2:	2501                	sext.w	a0,a0
    48b4:	6121                	addi	sp,sp,64
    48b6:	8082                	ret

00000000000048b8 <snprintf>:
{
    48b8:	7119                	addi	sp,sp,-128
    48ba:	e0a2                	sd	s0,64(sp)
    48bc:	fc26                	sd	s1,56(sp)
    48be:	842e                	mv	s0,a1
    48c0:	84aa                	mv	s1,a0
    48c2:	85b2                	mv	a1,a2
    _vprintf_core(&ctx, format, ap);
    48c4:	0808                	addi	a0,sp,16
    va_start(ap, format);
    48c6:	08b0                	addi	a2,sp,88
{
    48c8:	e486                	sd	ra,72(sp)
    48ca:	ecb6                	sd	a3,88(sp)
    48cc:	f0ba                	sd	a4,96(sp)
    48ce:	f4be                	sd	a5,104(sp)
    48d0:	f8c2                	sd	a6,112(sp)
    48d2:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    48d4:	e432                	sd	a2,8(sp)
    ctx.buf = str;
    48d6:	e826                	sd	s1,16(sp)
    ctx.limit = size;
    48d8:	ec22                	sd	s0,24(sp)
    ctx.written = 0;
    48da:	f002                	sd	zero,32(sp)
    ctx.stream = NULL;
    48dc:	f402                	sd	zero,40(sp)
    _vprintf_core(&ctx, format, ap);
    48de:	f92ff0ef          	jal	4070 <_vprintf_core.constprop.0.isra.0>
        if (ctx.written < size)
    48e2:	7502                	ld	a0,32(sp)
    if (size > 0)
    48e4:	c411                	beqz	s0,48f0 <snprintf+0x38>
        if (ctx.written < size)
    48e6:	00857b63          	bgeu	a0,s0,48fc <snprintf+0x44>
            str[ctx.written] = '\0';
    48ea:	94aa                	add	s1,s1,a0
    48ec:	00048023          	sb	zero,0(s1)
}
    48f0:	60a6                	ld	ra,72(sp)
    48f2:	6406                	ld	s0,64(sp)
    48f4:	74e2                	ld	s1,56(sp)
    48f6:	2501                	sext.w	a0,a0
    48f8:	6109                	addi	sp,sp,128
    48fa:	8082                	ret
            str[size - 1] = '\0';
    48fc:	94a2                	add	s1,s1,s0
    48fe:	fe048fa3          	sb	zero,-1(s1)
}
    4902:	60a6                	ld	ra,72(sp)
    4904:	6406                	ld	s0,64(sp)
    4906:	74e2                	ld	s1,56(sp)
    4908:	2501                	sext.w	a0,a0
    490a:	6109                	addi	sp,sp,128
    490c:	8082                	ret

000000000000490e <printf>:
{
    490e:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    4910:	04810313          	addi	t1,sp,72
{
    4914:	e4ae                	sd	a1,72(sp)
    4916:	e8b2                	sd	a2,80(sp)
    4918:	f4be                	sd	a5,104(sp)
    _vprintf_core(&ctx, format, ap);
    491a:	85aa                	mv	a1,a0
    ctx.stream = stdout;
    491c:	00004797          	auipc	a5,0x4
    4920:	32c7b783          	ld	a5,812(a5) # 8c48 <stdout>
    _vprintf_core(&ctx, format, ap);
    4924:	0808                	addi	a0,sp,16
    4926:	861a                	mv	a2,t1
{
    4928:	fc06                	sd	ra,56(sp)
    492a:	ecb6                	sd	a3,88(sp)
    492c:	f0ba                	sd	a4,96(sp)
    492e:	f8c2                	sd	a6,112(sp)
    4930:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    4932:	e41a                	sd	t1,8(sp)
    ctx.buf = NULL;
    4934:	e802                	sd	zero,16(sp)
    ctx.limit = 0;
    4936:	ec02                	sd	zero,24(sp)
    ctx.written = 0;
    4938:	f002                	sd	zero,32(sp)
    ctx.stream = stdout;
    493a:	f43e                	sd	a5,40(sp)
    _vprintf_core(&ctx, format, ap);
    493c:	f34ff0ef          	jal	4070 <_vprintf_core.constprop.0.isra.0>
}
    4940:	70e2                	ld	ra,56(sp)
    4942:	5502                	lw	a0,32(sp)
    4944:	6109                	addi	sp,sp,128
    4946:	8082                	ret

0000000000004948 <sscanf>:
{
    4948:	7159                	addi	sp,sp,-112
    va_start(ap, format);
    494a:	04010e13          	addi	t3,sp,64
{
    494e:	8eaa                	mv	t4,a0
    ctx.fd = -1;
    4950:	537d                	li	t1,-1
{
    4952:	e0b2                	sd	a2,64(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    4954:	0808                	addi	a0,sp,16
    4956:	8672                	mv	a2,t3
{
    4958:	fc06                	sd	ra,56(sp)
    495a:	e4b6                	sd	a3,72(sp)
    495c:	e8ba                	sd	a4,80(sp)
    495e:	ecbe                	sd	a5,88(sp)
    4960:	f0c2                	sd	a6,96(sp)
    4962:	f4c6                	sd	a7,104(sp)
    va_start(ap, format);
    4964:	e472                	sd	t3,8(sp)
    ctx.buf = str;
    4966:	e876                	sd	t4,16(sp)
    ctx.fd = -1;
    4968:	cc1a                	sw	t1,24(sp)
    ctx.pos = 0;
    496a:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    496c:	d41a                	sw	t1,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    496e:	81efd0ef          	jal	198c <_vscanf_core.constprop.0>
}
    4972:	70e2                	ld	ra,56(sp)
    4974:	6165                	addi	sp,sp,112
    4976:	8082                	ret

0000000000004978 <scanf>:
{
    4978:	7119                	addi	sp,sp,-128
    va_start(ap, format);
    497a:	04810313          	addi	t1,sp,72
{
    497e:	e4ae                	sd	a1,72(sp)
    4980:	e8b2                	sd	a2,80(sp)
    4982:	f4be                	sd	a5,104(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    4984:	85aa                	mv	a1,a0
    ctx.ungotten = -1;
    4986:	57fd                	li	a5,-1
    int ret = _vscanf_core(&ctx, format, ap);
    4988:	0808                	addi	a0,sp,16
    498a:	861a                	mv	a2,t1
{
    498c:	fc06                	sd	ra,56(sp)
    498e:	ecb6                	sd	a3,88(sp)
    4990:	f0ba                	sd	a4,96(sp)
    4992:	f8c2                	sd	a6,112(sp)
    4994:	fcc6                	sd	a7,120(sp)
    va_start(ap, format);
    4996:	e41a                	sd	t1,8(sp)
    ctx.buf = NULL;
    4998:	e802                	sd	zero,16(sp)
    ctx.fd = STDIN_FD;
    499a:	cc02                	sw	zero,24(sp)
    ctx.pos = 0;
    499c:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    499e:	d43e                	sw	a5,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    49a0:	fedfc0ef          	jal	198c <_vscanf_core.constprop.0>
}
    49a4:	70e2                	ld	ra,56(sp)
    49a6:	6109                	addi	sp,sp,128
    49a8:	8082                	ret

00000000000049aa <fopen>:
{
    49aa:	1101                	addi	sp,sp,-32
    49ac:	e426                	sd	s1,8(sp)
    49ae:	84ae                	mv	s1,a1
    49b0:	e04a                	sd	s2,0(sp)
    if (strcmp(mode, "r") == 0)
    49b2:	00002597          	auipc	a1,0x2
    49b6:	83658593          	addi	a1,a1,-1994 # 61e8 <_GLOBAL__sub_I__ZSt3cin+0x1e4>
{
    49ba:	892a                	mv	s2,a0
    if (strcmp(mode, "r") == 0)
    49bc:	8526                	mv	a0,s1
{
    49be:	e822                	sd	s0,16(sp)
    49c0:	ec06                	sd	ra,24(sp)
    if (strcmp(mode, "r") == 0)
    49c2:	298010ef          	jal	5c5a <strcmp>
    49c6:	842a                	mv	s0,a0
    49c8:	c919                	beqz	a0,49de <fopen+0x34>
    else if (strcmp(mode, "w") == 0)
    49ca:	00002597          	auipc	a1,0x2
    49ce:	82658593          	addi	a1,a1,-2010 # 61f0 <_GLOBAL__sub_I__ZSt3cin+0x1ec>
    49d2:	8526                	mv	a0,s1
    49d4:	286010ef          	jal	5c5a <strcmp>
        flags = O_WRONLY | O_CREAT | O_TRUNC;
    49d8:	24100413          	li	s0,577
    else if (strcmp(mode, "w") == 0)
    49dc:	ed39                	bnez	a0,4a3a <fopen+0x90>
    int64 fd = open(filename, flags);
    49de:	85a2                	mv	a1,s0
    49e0:	854a                	mv	a0,s2
    49e2:	f4afc0ef          	jal	112c <open>
    49e6:	84aa                	mv	s1,a0
    if (fd < 0)
    49e8:	06054c63          	bltz	a0,4a60 <fopen+0xb6>
    FILE *f = (FILE *)malloc(sizeof(FILE));
    49ec:	42000513          	li	a0,1056
    49f0:	2f3000ef          	jal	54e2 <malloc>
    49f4:	892a                	mv	s2,a0
    if (!f)
    49f6:	c53d                	beqz	a0,4a64 <fopen+0xba>
    memset(f, 0, sizeof(FILE));
    49f8:	42000613          	li	a2,1056
    49fc:	4581                	li	a1,0
    49fe:	0ee010ef          	jal	5aec <memset>
    if (fd == 1)
    4a02:	4785                	li	a5,1
    f->fd = (int)fd;
    4a04:	00992023          	sw	s1,0(s2)
    f->flags = flags;
    4a08:	00892223          	sw	s0,4(s2)
    if (fd == 1)
    4a0c:	00f48e63          	beq	s1,a5,4a28 <fopen+0x7e>
    else if (fd == 2)
    4a10:	4789                	li	a5,2
    4a12:	00f48b63          	beq	s1,a5,4a28 <fopen+0x7e>
        f->buf_mode = 0;
    4a16:	40092e23          	sw	zero,1052(s2)
}
    4a1a:	60e2                	ld	ra,24(sp)
    4a1c:	6442                	ld	s0,16(sp)
    4a1e:	64a2                	ld	s1,8(sp)
    4a20:	854a                	mv	a0,s2
    4a22:	6902                	ld	s2,0(sp)
    4a24:	6105                	addi	sp,sp,32
    4a26:	8082                	ret
    4a28:	60e2                	ld	ra,24(sp)
    4a2a:	6442                	ld	s0,16(sp)
        f->buf_mode = 2;
    4a2c:	40992e23          	sw	s1,1052(s2)
}
    4a30:	854a                	mv	a0,s2
    4a32:	64a2                	ld	s1,8(sp)
    4a34:	6902                	ld	s2,0(sp)
    4a36:	6105                	addi	sp,sp,32
    4a38:	8082                	ret
    else if (strcmp(mode, "a") == 0)
    4a3a:	00001597          	auipc	a1,0x1
    4a3e:	7be58593          	addi	a1,a1,1982 # 61f8 <_GLOBAL__sub_I__ZSt3cin+0x1f4>
    4a42:	8526                	mv	a0,s1
    4a44:	216010ef          	jal	5c5a <strcmp>
        flags = O_WRONLY | O_CREAT | O_APPEND;
    4a48:	44100413          	li	s0,1089
    else if (strcmp(mode, "a") == 0)
    4a4c:	d949                	beqz	a0,49de <fopen+0x34>
    else if (strcmp(mode, "r+") == 0)
    4a4e:	00001597          	auipc	a1,0x1
    4a52:	7b258593          	addi	a1,a1,1970 # 6200 <_GLOBAL__sub_I__ZSt3cin+0x1fc>
    4a56:	8526                	mv	a0,s1
    4a58:	202010ef          	jal	5c5a <strcmp>
        flags = O_RDWR;
    4a5c:	4409                	li	s0,2
    else if (strcmp(mode, "r+") == 0)
    4a5e:	d141                	beqz	a0,49de <fopen+0x34>
        return NULL;
    4a60:	4901                	li	s2,0
    4a62:	bf65                	j	4a1a <fopen+0x70>
        close(fd);
    4a64:	8526                	mv	a0,s1
    4a66:	eaefc0ef          	jal	1114 <close>
        return NULL;
    4a6a:	4901                	li	s2,0
    4a6c:	b77d                	j	4a1a <fopen+0x70>

0000000000004a6e <fclose>:
    if (!stream)
    4a6e:	cd29                	beqz	a0,4ac8 <fclose+0x5a>
    if (stream->buf_write_pos > 0)
    4a70:	41052603          	lw	a2,1040(a0)
{
    4a74:	1141                	addi	sp,sp,-16
    4a76:	e022                	sd	s0,0(sp)
    4a78:	e406                	sd	ra,8(sp)
    4a7a:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    4a7c:	02c04a63          	bgtz	a2,4ab0 <fclose+0x42>
    if (stream != stdin && stream != stdout && stream != stderr)
    4a80:	00004797          	auipc	a5,0x4
    4a84:	1c878793          	addi	a5,a5,456 # 8c48 <stdout>
    4a88:	6798                	ld	a4,8(a5)
    4a8a:	00870e63          	beq	a4,s0,4aa6 <fclose+0x38>
    4a8e:	6398                	ld	a4,0(a5)
    4a90:	00870b63          	beq	a4,s0,4aa6 <fclose+0x38>
    4a94:	6b9c                	ld	a5,16(a5)
    4a96:	00878863          	beq	a5,s0,4aa6 <fclose+0x38>
        close(stream->fd);
    4a9a:	4008                	lw	a0,0(s0)
    4a9c:	e78fc0ef          	jal	1114 <close>
        free(stream);
    4aa0:	8522                	mv	a0,s0
    4aa2:	1cb000ef          	jal	546c <free>
}
    4aa6:	60a2                	ld	ra,8(sp)
    4aa8:	6402                	ld	s0,0(sp)
    return 0;
    4aaa:	4501                	li	a0,0
}
    4aac:	0141                	addi	sp,sp,16
    4aae:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4ab0:	4108                	lw	a0,0(a0)
    4ab2:	01040593          	addi	a1,s0,16
    4ab6:	e56fc0ef          	jal	110c <write>
        if (ret < stream->buf_write_pos)
    4aba:	41042783          	lw	a5,1040(s0)
    4abe:	00f54763          	blt	a0,a5,4acc <fclose+0x5e>
        stream->buf_write_pos = 0;
    4ac2:	40042823          	sw	zero,1040(s0)
    4ac6:	bf6d                	j	4a80 <fclose+0x12>
        return -1;
    4ac8:	557d                	li	a0,-1
}
    4aca:	8082                	ret
            stream->error = 1;
    4acc:	4785                	li	a5,1
    4ace:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4ad0:	40042823          	sw	zero,1040(s0)
            return EOF;
    4ad4:	b775                	j	4a80 <fclose+0x12>

0000000000004ad6 <fflush>:
    if (!stream)
    4ad6:	c121                	beqz	a0,4b16 <fflush+0x40>
    if (stream->buf_write_pos > 0)
    4ad8:	41052603          	lw	a2,1040(a0)
{
    4adc:	1141                	addi	sp,sp,-16
    4ade:	e022                	sd	s0,0(sp)
    4ae0:	e406                	sd	ra,8(sp)
    4ae2:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    4ae4:	00c04763          	bgtz	a2,4af2 <fflush+0x1c>
    return 0;
    4ae8:	4501                	li	a0,0
}
    4aea:	60a2                	ld	ra,8(sp)
    4aec:	6402                	ld	s0,0(sp)
    4aee:	0141                	addi	sp,sp,16
    4af0:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4af2:	4108                	lw	a0,0(a0)
    4af4:	01040593          	addi	a1,s0,16
    4af8:	e14fc0ef          	jal	110c <write>
        if (ret < stream->buf_write_pos)
    4afc:	41042783          	lw	a5,1040(s0)
    4b00:	00f54563          	blt	a0,a5,4b0a <fflush+0x34>
        stream->buf_write_pos = 0;
    4b04:	40042823          	sw	zero,1040(s0)
    4b08:	b7c5                	j	4ae8 <fflush+0x12>
            stream->error = 1;
    4b0a:	4785                	li	a5,1
    4b0c:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4b0e:	40042823          	sw	zero,1040(s0)
        return EOF;
    4b12:	557d                	li	a0,-1
    4b14:	bfd9                	j	4aea <fflush+0x14>
    4b16:	557d                	li	a0,-1
}
    4b18:	8082                	ret

0000000000004b1a <fprintf>:
{
    4b1a:	7159                	addi	sp,sp,-112
    4b1c:	fc06                	sd	ra,56(sp)
    4b1e:	e0b2                	sd	a2,64(sp)
    4b20:	e4b6                	sd	a3,72(sp)
    4b22:	e8ba                	sd	a4,80(sp)
    4b24:	ecbe                	sd	a5,88(sp)
    4b26:	f0c2                	sd	a6,96(sp)
    4b28:	f4c6                	sd	a7,104(sp)
    if (!stream)
    4b2a:	cd19                	beqz	a0,4b48 <fprintf+0x2e>
    va_start(ap, format);
    4b2c:	832a                	mv	t1,a0
    4b2e:	0090                	addi	a2,sp,64
    _vprintf_core(&ctx, format, ap);
    4b30:	0808                	addi	a0,sp,16
    va_start(ap, format);
    4b32:	e432                	sd	a2,8(sp)
    ctx.buf = NULL;
    4b34:	e802                	sd	zero,16(sp)
    ctx.limit = 0;
    4b36:	ec02                	sd	zero,24(sp)
    ctx.written = 0;
    4b38:	f002                	sd	zero,32(sp)
    ctx.stream  = stream;
    4b3a:	f41a                	sd	t1,40(sp)
    _vprintf_core(&ctx, format, ap);
    4b3c:	d34ff0ef          	jal	4070 <_vprintf_core.constprop.0.isra.0>
    return (int)ctx.written;
    4b40:	5502                	lw	a0,32(sp)
}
    4b42:	70e2                	ld	ra,56(sp)
    4b44:	6165                	addi	sp,sp,112
    4b46:	8082                	ret
        return -1;
    4b48:	557d                	li	a0,-1
    4b4a:	bfe5                	j	4b42 <fprintf+0x28>

0000000000004b4c <fscanf>:
{
    4b4c:	7159                	addi	sp,sp,-112
    4b4e:	fc06                	sd	ra,56(sp)
    4b50:	e0b2                	sd	a2,64(sp)
    4b52:	e4b6                	sd	a3,72(sp)
    4b54:	e8ba                	sd	a4,80(sp)
    4b56:	ecbe                	sd	a5,88(sp)
    4b58:	f0c2                	sd	a6,96(sp)
    4b5a:	f4c6                	sd	a7,104(sp)
    if (!stream)
    4b5c:	cd19                	beqz	a0,4b7a <fscanf+0x2e>
    ctx.fd = stream->fd;
    4b5e:	411c                	lw	a5,0(a0)
    va_start(ap, format);
    4b60:	0090                	addi	a2,sp,64
    int ret = _vscanf_core(&ctx, format, ap);
    4b62:	0808                	addi	a0,sp,16
    ctx.fd = stream->fd;
    4b64:	cc3e                	sw	a5,24(sp)
    ctx.ungotten = -1;
    4b66:	57fd                	li	a5,-1
    va_start(ap, format);
    4b68:	e432                	sd	a2,8(sp)
    ctx.buf = NULL;
    4b6a:	e802                	sd	zero,16(sp)
    ctx.pos = 0;
    4b6c:	f002                	sd	zero,32(sp)
    ctx.ungotten = -1;
    4b6e:	d43e                	sw	a5,40(sp)
    int ret = _vscanf_core(&ctx, format, ap);
    4b70:	e1dfc0ef          	jal	198c <_vscanf_core.constprop.0>
}
    4b74:	70e2                	ld	ra,56(sp)
    4b76:	6165                	addi	sp,sp,112
    4b78:	8082                	ret
        return -1;
    4b7a:	557d                	li	a0,-1
    4b7c:	bfe5                	j	4b74 <fscanf+0x28>

0000000000004b7e <fputc>:
    if (!stream)
    4b7e:	c1e1                	beqz	a1,4c3e <fputc+0xc0>
{
    4b80:	7179                	addi	sp,sp,-48
    4b82:	e84a                	sd	s2,16(sp)
    if (stream->buf_mode == 2)
    4b84:	41c5a903          	lw	s2,1052(a1)
{
    4b88:	f022                	sd	s0,32(sp)
    4b8a:	ec26                	sd	s1,24(sp)
    4b8c:	f406                	sd	ra,40(sp)
    if (stream->buf_mode == 2)
    4b8e:	4789                	li	a5,2
    4b90:	842e                	mv	s0,a1
    4b92:	84aa                	mv	s1,a0
        char ch = (char)c;
    4b94:	0ff57713          	zext.b	a4,a0
    if (stream->buf_mode == 2)
    4b98:	02f90963          	beq	s2,a5,4bca <fputc+0x4c>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    4b9c:	4105a783          	lw	a5,1040(a1)
    if (stream->buf_write_pos >= BUFSIZ)
    4ba0:	3ff00693          	li	a3,1023
    stream->buffer[stream->buf_write_pos++] = (char)c;
    4ba4:	0017861b          	addiw	a2,a5,1
    4ba8:	40c5a823          	sw	a2,1040(a1)
    4bac:	97ae                	add	a5,a5,a1
    4bae:	00e78823          	sb	a4,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    4bb2:	06c6c463          	blt	a3,a2,4c1a <fputc+0x9c>
    else if (stream->buf_mode == 1 && c == '\n')
    4bb6:	4785                	li	a5,1
    4bb8:	02f90e63          	beq	s2,a5,4bf4 <fputc+0x76>
    return c;
    4bbc:	8526                	mv	a0,s1
}
    4bbe:	70a2                	ld	ra,40(sp)
    4bc0:	7402                	ld	s0,32(sp)
    4bc2:	64e2                	ld	s1,24(sp)
    4bc4:	6942                	ld	s2,16(sp)
    4bc6:	6145                	addi	sp,sp,48
    4bc8:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    4bca:	4188                	lw	a0,0(a1)
    4bcc:	4605                	li	a2,1
    4bce:	00f10593          	addi	a1,sp,15
        char ch = (char)c;
    4bd2:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    4bd6:	d36fc0ef          	jal	110c <write>
    4bda:	872a                	mv	a4,a0
    4bdc:	4785                	li	a5,1
        return c;
    4bde:	8526                	mv	a0,s1
        if (write(stream->fd, &ch, 1) != 1)
    4be0:	fcf70fe3          	beq	a4,a5,4bbe <fputc+0x40>
}
    4be4:	70a2                	ld	ra,40(sp)
            stream->error = 1;
    4be6:	c41c                	sw	a5,8(s0)
}
    4be8:	7402                	ld	s0,32(sp)
    4bea:	64e2                	ld	s1,24(sp)
    4bec:	6942                	ld	s2,16(sp)
            return EOF;
    4bee:	557d                	li	a0,-1
}
    4bf0:	6145                	addi	sp,sp,48
    4bf2:	8082                	ret
    else if (stream->buf_mode == 1 && c == '\n')
    4bf4:	47a9                	li	a5,10
    4bf6:	fcf513e3          	bne	a0,a5,4bbc <fputc+0x3e>
    if (stream->buf_write_pos > 0)
    4bfa:	fcc051e3          	blez	a2,4bbc <fputc+0x3e>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4bfe:	4188                	lw	a0,0(a1)
    4c00:	05c1                	addi	a1,a1,16
    4c02:	d0afc0ef          	jal	110c <write>
        if (ret < stream->buf_write_pos)
    4c06:	41042783          	lw	a5,1040(s0)
    4c0a:	02f55063          	bge	a0,a5,4c2a <fputc+0xac>
            stream->error = 1;
    4c0e:	01242423          	sw	s2,8(s0)
            stream->buf_write_pos = 0;
    4c12:	40042823          	sw	zero,1040(s0)
    return c;
    4c16:	8526                	mv	a0,s1
    4c18:	b75d                	j	4bbe <fputc+0x40>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4c1a:	4188                	lw	a0,0(a1)
    4c1c:	05c1                	addi	a1,a1,16
    4c1e:	ceefc0ef          	jal	110c <write>
        if (ret < stream->buf_write_pos)
    4c22:	41042783          	lw	a5,1040(s0)
    4c26:	00f54663          	blt	a0,a5,4c32 <fputc+0xb4>
        stream->buf_write_pos = 0;
    4c2a:	40042823          	sw	zero,1040(s0)
    return c;
    4c2e:	8526                	mv	a0,s1
    4c30:	b779                	j	4bbe <fputc+0x40>
            stream->error = 1;
    4c32:	4785                	li	a5,1
    4c34:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4c36:	40042823          	sw	zero,1040(s0)
    return c;
    4c3a:	8526                	mv	a0,s1
    4c3c:	b749                	j	4bbe <fputc+0x40>
        return EOF;
    4c3e:	557d                	li	a0,-1
}
    4c40:	8082                	ret

0000000000004c42 <fputs>:
    if (!stream)
    4c42:	c1ed                	beqz	a1,4d24 <fputs+0xe2>
{
    4c44:	711d                	addi	sp,sp,-96
    4c46:	e4a6                	sd	s1,72(sp)
    4c48:	ec86                	sd	ra,88(sp)
    while (*s)
    4c4a:	00054703          	lbu	a4,0(a0)
    4c4e:	84aa                	mv	s1,a0
    4c50:	cf25                	beqz	a4,4cc8 <fputs+0x86>
    4c52:	e8a2                	sd	s0,80(sp)
    4c54:	e0ca                	sd	s2,64(sp)
    4c56:	fc4e                	sd	s3,56(sp)
    4c58:	f852                	sd	s4,48(sp)
    4c5a:	f456                	sd	s5,40(sp)
    4c5c:	f05a                	sd	s6,32(sp)
    4c5e:	ec5e                	sd	s7,24(sp)
    4c60:	842e                	mv	s0,a1
    if (stream->buf_mode == 2)
    4c62:	4909                	li	s2,2
    if (stream->buf_write_pos >= BUFSIZ)
    4c64:	3ff00b13          	li	s6,1023
    else if (stream->buf_mode == 1 && c == '\n')
    4c68:	4985                	li	s3,1
    4c6a:	4a29                	li	s4,10
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4c6c:	01058a93          	addi	s5,a1,16
        if (write(stream->fd, &ch, 1) != 1)
    4c70:	00f10b93          	addi	s7,sp,15
    4c74:	a031                	j	4c80 <fputs+0x3e>
    else if (stream->buf_mode == 1 && c == '\n')
    4c76:	09368563          	beq	a3,s3,4d00 <fputs+0xbe>
    while (*s)
    4c7a:	0004c703          	lbu	a4,0(s1)
    4c7e:	cf15                	beqz	a4,4cba <fputs+0x78>
    if (stream->buf_mode == 2)
    4c80:	41c42683          	lw	a3,1052(s0)
        if (fputc(*s++, stream) == EOF)
    4c84:	0485                	addi	s1,s1,1
    if (stream->buf_mode == 2)
    4c86:	05268663          	beq	a3,s2,4cd2 <fputs+0x90>
    stream->buffer[stream->buf_write_pos++] = (char)c;
    4c8a:	41042783          	lw	a5,1040(s0)
    4c8e:	0017861b          	addiw	a2,a5,1
    4c92:	40c42823          	sw	a2,1040(s0)
    4c96:	97a2                	add	a5,a5,s0
    4c98:	00e78823          	sb	a4,16(a5)
    if (stream->buf_write_pos >= BUFSIZ)
    4c9c:	fccb5de3          	bge	s6,a2,4c76 <fputs+0x34>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4ca0:	4008                	lw	a0,0(s0)
    4ca2:	85d6                	mv	a1,s5
    4ca4:	c68fc0ef          	jal	110c <write>
        if (ret < stream->buf_write_pos)
    4ca8:	41042783          	lw	a5,1040(s0)
    4cac:	06f54763          	blt	a0,a5,4d1a <fputs+0xd8>
        stream->buf_write_pos = 0;
    4cb0:	40042823          	sw	zero,1040(s0)
    while (*s)
    4cb4:	0004c703          	lbu	a4,0(s1)
    4cb8:	f761                	bnez	a4,4c80 <fputs+0x3e>
    4cba:	6446                	ld	s0,80(sp)
    4cbc:	6906                	ld	s2,64(sp)
    4cbe:	79e2                	ld	s3,56(sp)
    4cc0:	7a42                	ld	s4,48(sp)
    4cc2:	7aa2                	ld	s5,40(sp)
    4cc4:	7b02                	ld	s6,32(sp)
    4cc6:	6be2                	ld	s7,24(sp)
}
    4cc8:	60e6                	ld	ra,88(sp)
    4cca:	64a6                	ld	s1,72(sp)
    return 0;
    4ccc:	4501                	li	a0,0
}
    4cce:	6125                	addi	sp,sp,96
    4cd0:	8082                	ret
        if (write(stream->fd, &ch, 1) != 1)
    4cd2:	4008                	lw	a0,0(s0)
    4cd4:	4605                	li	a2,1
    4cd6:	85de                	mv	a1,s7
        char ch = (char)c;
    4cd8:	00e107a3          	sb	a4,15(sp)
        if (write(stream->fd, &ch, 1) != 1)
    4cdc:	c30fc0ef          	jal	110c <write>
    4ce0:	f9350de3          	beq	a0,s3,4c7a <fputs+0x38>
            stream->error = 1;
    4ce4:	01342423          	sw	s3,8(s0)
}
    4ce8:	60e6                	ld	ra,88(sp)
    4cea:	6446                	ld	s0,80(sp)
    4cec:	6906                	ld	s2,64(sp)
    4cee:	79e2                	ld	s3,56(sp)
    4cf0:	7a42                	ld	s4,48(sp)
    4cf2:	7aa2                	ld	s5,40(sp)
    4cf4:	7b02                	ld	s6,32(sp)
    4cf6:	6be2                	ld	s7,24(sp)
    4cf8:	64a6                	ld	s1,72(sp)
        return -1;
    4cfa:	557d                	li	a0,-1
}
    4cfc:	6125                	addi	sp,sp,96
    4cfe:	8082                	ret
    else if (stream->buf_mode == 1 && c == '\n')
    4d00:	f7471de3          	bne	a4,s4,4c7a <fputs+0x38>
    if (stream->buf_write_pos > 0)
    4d04:	f6c05be3          	blez	a2,4c7a <fputs+0x38>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4d08:	4008                	lw	a0,0(s0)
    4d0a:	01040593          	addi	a1,s0,16
    4d0e:	bfefc0ef          	jal	110c <write>
        if (ret < stream->buf_write_pos)
    4d12:	41042783          	lw	a5,1040(s0)
    4d16:	f8f55de3          	bge	a0,a5,4cb0 <fputs+0x6e>
            stream->error = 1;
    4d1a:	4785                	li	a5,1
    4d1c:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4d1e:	40042823          	sw	zero,1040(s0)
            return EOF;
    4d22:	bfa1                	j	4c7a <fputs+0x38>
        return -1;
    4d24:	557d                	li	a0,-1
}
    4d26:	8082                	ret

0000000000004d28 <fgetc>:
    if (!stream)
    4d28:	c949                	beqz	a0,4dba <fgetc+0x92>
    if (stream->buf_write_pos > 0)
    4d2a:	41052603          	lw	a2,1040(a0)
{
    4d2e:	1141                	addi	sp,sp,-16
    4d30:	e022                	sd	s0,0(sp)
    4d32:	e406                	sd	ra,8(sp)
    4d34:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    4d36:	04c04863          	bgtz	a2,4d86 <fgetc+0x5e>
    if (stream->buf_read_pos < stream->buf_read_cnt)
    4d3a:	41442783          	lw	a5,1044(s0)
    4d3e:	41842703          	lw	a4,1048(s0)
    4d42:	00e7dd63          	bge	a5,a4,4d5c <fgetc+0x34>
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4d46:	0017871b          	addiw	a4,a5,1
    4d4a:	40e42a23          	sw	a4,1044(s0)
    4d4e:	943e                	add	s0,s0,a5
    4d50:	01044503          	lbu	a0,16(s0)
}
    4d54:	60a2                	ld	ra,8(sp)
    4d56:	6402                	ld	s0,0(sp)
    4d58:	0141                	addi	sp,sp,16
    4d5a:	8082                	ret
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    4d5c:	4008                	lw	a0,0(s0)
    4d5e:	40000613          	li	a2,1024
    4d62:	01040593          	addi	a1,s0,16
    4d66:	b9efc0ef          	jal	1104 <read>
    4d6a:	87aa                	mv	a5,a0
    if (ret <= 0)
    4d6c:	02a05e63          	blez	a0,4da8 <fgetc+0x80>
    stream->buf_read_cnt = (int)ret;
    4d70:	40f42c23          	sw	a5,1048(s0)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4d74:	4785                	li	a5,1
    4d76:	01044503          	lbu	a0,16(s0)
}
    4d7a:	60a2                	ld	ra,8(sp)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4d7c:	40f42a23          	sw	a5,1044(s0)
}
    4d80:	6402                	ld	s0,0(sp)
    4d82:	0141                	addi	sp,sp,16
    4d84:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4d86:	4108                	lw	a0,0(a0)
    4d88:	01040593          	addi	a1,s0,16
    4d8c:	b80fc0ef          	jal	110c <write>
        if (ret < stream->buf_write_pos)
    4d90:	41042783          	lw	a5,1040(s0)
    4d94:	00f54563          	blt	a0,a5,4d9e <fgetc+0x76>
        stream->buf_write_pos = 0;
    4d98:	40042823          	sw	zero,1040(s0)
    4d9c:	bf79                	j	4d3a <fgetc+0x12>
            stream->error = 1;
    4d9e:	4785                	li	a5,1
    4da0:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4da2:	40042823          	sw	zero,1040(s0)
            return EOF;
    4da6:	bf51                	j	4d3a <fgetc+0x12>
        if (ret == 0)
    4da8:	e509                	bnez	a0,4db2 <fgetc+0x8a>
            stream->eof = 1;
    4daa:	4785                	li	a5,1
    4dac:	c45c                	sw	a5,12(s0)
        return EOF;
    4dae:	557d                	li	a0,-1
    4db0:	b755                	j	4d54 <fgetc+0x2c>
            stream->error = 1;
    4db2:	4785                	li	a5,1
    4db4:	c41c                	sw	a5,8(s0)
        return EOF;
    4db6:	557d                	li	a0,-1
    4db8:	bf71                	j	4d54 <fgetc+0x2c>
    4dba:	557d                	li	a0,-1
}
    4dbc:	8082                	ret

0000000000004dbe <fgets>:
    if (!stream || n <= 0)
    4dbe:	ce5d                	beqz	a2,4e7c <fgets+0xbe>
    4dc0:	0ab05e63          	blez	a1,4e7c <fgets+0xbe>
{
    4dc4:	715d                	addi	sp,sp,-80
    4dc6:	e0a2                	sd	s0,64(sp)
    4dc8:	fc26                	sd	s1,56(sp)
    4dca:	f84a                	sd	s2,48(sp)
    4dcc:	f44e                	sd	s3,40(sp)
    4dce:	f052                	sd	s4,32(sp)
    4dd0:	ec56                	sd	s5,24(sp)
    4dd2:	e85a                	sd	s6,16(sp)
    4dd4:	e45e                	sd	s7,8(sp)
    4dd6:	e486                	sd	ra,72(sp)
    4dd8:	8432                	mv	s0,a2
    4dda:	8aaa                	mv	s5,a0
    4ddc:	892a                	mv	s2,a0
    4dde:	fff58b9b          	addiw	s7,a1,-1
    int i = 0, c;
    4de2:	4481                	li	s1,0
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4de4:	01060993          	addi	s3,a2,16
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4de8:	4b05                	li	s6,1
        if (c == '\n')
    4dea:	4a29                	li	s4,10
    while (i < n - 1)
    4dec:	05748163          	beq	s1,s7,4e2e <fgets+0x70>
    if (stream->buf_write_pos > 0)
    4df0:	41042603          	lw	a2,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4df4:	85ce                	mv	a1,s3
    if (stream->buf_write_pos > 0)
    4df6:	06c04963          	bgtz	a2,4e68 <fgets+0xaa>
    if (stream->buf_read_pos < stream->buf_read_cnt)
    4dfa:	41442783          	lw	a5,1044(s0)
    4dfe:	41842703          	lw	a4,1048(s0)
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    4e02:	40000613          	li	a2,1024
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4e06:	0017851b          	addiw	a0,a5,1
    4e0a:	00f406b3          	add	a3,s0,a5
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    4e0e:	85ce                	mv	a1,s3
    if (stream->buf_read_pos < stream->buf_read_cnt)
    4e10:	02e7de63          	bge	a5,a4,4e4c <fgets+0x8e>
        return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4e14:	40a42a23          	sw	a0,1044(s0)
    4e18:	0106c783          	lbu	a5,16(a3)
    4e1c:	0007871b          	sext.w	a4,a5
        str[i++] = (char)c;
    4e20:	00f90023          	sb	a5,0(s2)
    4e24:	2485                	addiw	s1,s1,1
        if (c == '\n')
    4e26:	0905                	addi	s2,s2,1
    4e28:	fd4712e3          	bne	a4,s4,4dec <fgets+0x2e>
        str[i++] = (char)c;
    4e2c:	8ba6                	mv	s7,s1
    str[i] = '\0';
    4e2e:	9bd6                	add	s7,s7,s5
    4e30:	000b8023          	sb	zero,0(s7)
    return str;
    4e34:	8556                	mv	a0,s5
}
    4e36:	60a6                	ld	ra,72(sp)
    4e38:	6406                	ld	s0,64(sp)
    4e3a:	74e2                	ld	s1,56(sp)
    4e3c:	7942                	ld	s2,48(sp)
    4e3e:	79a2                	ld	s3,40(sp)
    4e40:	7a02                	ld	s4,32(sp)
    4e42:	6ae2                	ld	s5,24(sp)
    4e44:	6b42                	ld	s6,16(sp)
    4e46:	6ba2                	ld	s7,8(sp)
    4e48:	6161                	addi	sp,sp,80
    4e4a:	8082                	ret
    int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    4e4c:	4008                	lw	a0,0(s0)
    4e4e:	ab6fc0ef          	jal	1104 <read>
    if (ret <= 0)
    4e52:	02a05c63          	blez	a0,4e8a <fgets+0xcc>
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4e56:	01044783          	lbu	a5,16(s0)
    stream->buf_read_cnt = (int)ret;
    4e5a:	40a42c23          	sw	a0,1048(s0)
    return (unsigned char)stream->buffer[stream->buf_read_pos++];
    4e5e:	41642a23          	sw	s6,1044(s0)
    4e62:	0007871b          	sext.w	a4,a5
        if (c == -1)
    4e66:	bf6d                	j	4e20 <fgets+0x62>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4e68:	4008                	lw	a0,0(s0)
    4e6a:	aa2fc0ef          	jal	110c <write>
        if (ret < stream->buf_write_pos)
    4e6e:	41042783          	lw	a5,1040(s0)
    4e72:	00f54763          	blt	a0,a5,4e80 <fgets+0xc2>
        stream->buf_write_pos = 0;
    4e76:	40042823          	sw	zero,1040(s0)
    4e7a:	b741                	j	4dfa <fgets+0x3c>
        return NULL;
    4e7c:	4501                	li	a0,0
}
    4e7e:	8082                	ret
            stream->error = 1;
    4e80:	4785                	li	a5,1
    4e82:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4e84:	40042823          	sw	zero,1040(s0)
            return EOF;
    4e88:	bf8d                	j	4dfa <fgets+0x3c>
            stream->eof = 1;
    4e8a:	4785                	li	a5,1
        if (ret == 0)
    4e8c:	e509                	bnez	a0,4e96 <fgets+0xd8>
            stream->eof = 1;
    4e8e:	c45c                	sw	a5,12(s0)
            if (i == 0)
    4e90:	fcd1                	bnez	s1,4e2c <fgets+0x6e>
        return NULL;
    4e92:	4501                	li	a0,0
    4e94:	b74d                	j	4e36 <fgets+0x78>
            stream->error = 1;
    4e96:	c41c                	sw	a5,8(s0)
        if (c == -1)
    4e98:	bfe5                	j	4e90 <fgets+0xd2>

0000000000004e9a <fread>:
{
    4e9a:	715d                	addi	sp,sp,-80
    4e9c:	e486                	sd	ra,72(sp)
    4e9e:	f44e                	sd	s3,40(sp)
    if (!stream || size == 0 || nmemb == 0)
    4ea0:	0e068963          	beqz	a3,4f92 <fread+0xf8>
    4ea4:	ec56                	sd	s5,24(sp)
        return 0;
    4ea6:	4981                	li	s3,0
    4ea8:	8aae                	mv	s5,a1
    if (!stream || size == 0 || nmemb == 0)
    4eaa:	c9bd                	beqz	a1,4f20 <fread+0x86>
    4eac:	ca35                	beqz	a2,4f20 <fread+0x86>
    if (stream->buf_write_pos > 0)
    4eae:	4106a783          	lw	a5,1040(a3)
    4eb2:	e0a2                	sd	s0,64(sp)
    4eb4:	f052                	sd	s4,32(sp)
    uint64 total_bytes = size * nmemb;
    4eb6:	02c589b3          	mul	s3,a1,a2
    4eba:	8436                	mv	s0,a3
    4ebc:	8a2a                	mv	s4,a0
    if (stream->buf_write_pos > 0)
    4ebe:	0af04d63          	bgtz	a5,4f78 <fread+0xde>
    while (bytes_read < total_bytes)
    4ec2:	04098d63          	beqz	s3,4f1c <fread+0x82>
    4ec6:	fc26                	sd	s1,56(sp)
    4ec8:	e85a                	sd	s6,16(sp)
    4eca:	e45e                	sd	s7,8(sp)
    4ecc:	f84a                	sd	s2,48(sp)
    4ece:	4481                	li	s1,0
            if (remaining >= BUFSIZ)
    4ed0:	3ff00b13          	li	s6,1023
                int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    4ed4:	01040b93          	addi	s7,s0,16
        if (stream->buf_read_pos < stream->buf_read_cnt)
    4ed8:	41442703          	lw	a4,1044(s0)
    4edc:	41842783          	lw	a5,1048(s0)
            uint64 remaining = total_bytes - bytes_read;
    4ee0:	40998633          	sub	a2,s3,s1
        if (stream->buf_read_pos < stream->buf_read_cnt)
    4ee4:	06f74463          	blt	a4,a5,4f4c <fread+0xb2>
                int64 ret = read(stream->fd, dst + bytes_read, remaining);
    4ee8:	4008                	lw	a0,0(s0)
    4eea:	009a05b3          	add	a1,s4,s1
            if (remaining >= BUFSIZ)
    4eee:	02cb7f63          	bgeu	s6,a2,4f2c <fread+0x92>
                int64 ret = read(stream->fd, dst + bytes_read, remaining);
    4ef2:	a12fc0ef          	jal	1104 <read>
                if (ret <= 0)
    4ef6:	0aa05463          	blez	a0,4f9e <fread+0x104>
                bytes_read += ret;
    4efa:	94aa                	add	s1,s1,a0
    while (bytes_read < total_bytes)
    4efc:	fd34eee3          	bltu	s1,s3,4ed8 <fread+0x3e>
    return bytes_read / size;
    4f00:	0354d9b3          	divu	s3,s1,s5
    4f04:	6406                	ld	s0,64(sp)
}
    4f06:	60a6                	ld	ra,72(sp)
    return bytes_read / size;
    4f08:	74e2                	ld	s1,56(sp)
    4f0a:	7942                	ld	s2,48(sp)
    4f0c:	7a02                	ld	s4,32(sp)
    4f0e:	6ae2                	ld	s5,24(sp)
    4f10:	6b42                	ld	s6,16(sp)
    4f12:	6ba2                	ld	s7,8(sp)
}
    4f14:	854e                	mv	a0,s3
    4f16:	79a2                	ld	s3,40(sp)
    4f18:	6161                	addi	sp,sp,80
    4f1a:	8082                	ret
    4f1c:	6406                	ld	s0,64(sp)
    4f1e:	7a02                	ld	s4,32(sp)
    4f20:	60a6                	ld	ra,72(sp)
    4f22:	6ae2                	ld	s5,24(sp)
    4f24:	854e                	mv	a0,s3
    4f26:	79a2                	ld	s3,40(sp)
    4f28:	6161                	addi	sp,sp,80
    4f2a:	8082                	ret
                stream->buf_read_pos = 0;
    4f2c:	40042a23          	sw	zero,1044(s0)
                stream->buf_read_cnt = 0;
    4f30:	40042c23          	sw	zero,1048(s0)
                int64 ret = read(stream->fd, stream->buffer, BUFSIZ);
    4f34:	40000613          	li	a2,1024
    4f38:	85de                	mv	a1,s7
    4f3a:	9cafc0ef          	jal	1104 <read>
                if (ret <= 0)
    4f3e:	06a05063          	blez	a0,4f9e <fread+0x104>
                stream->buf_read_cnt = (int)ret;
    4f42:	40a42c23          	sw	a0,1048(s0)
    while (bytes_read < total_bytes)
    4f46:	f934e9e3          	bltu	s1,s3,4ed8 <fread+0x3e>
    4f4a:	bf5d                	j	4f00 <fread+0x66>
            uint64 available = stream->buf_read_cnt - stream->buf_read_pos;
    4f4c:	40e7893b          	subw	s2,a5,a4
            memcpy(dst + bytes_read, stream->buffer + stream->buf_read_pos, to_copy);
    4f50:	00eb85b3          	add	a1,s7,a4
    4f54:	009a0533          	add	a0,s4,s1
            uint64 to_copy = (available < remaining) ? available : remaining;
    4f58:	01267363          	bgeu	a2,s2,4f5e <fread+0xc4>
    4f5c:	8932                	mv	s2,a2
            memcpy(dst + bytes_read, stream->buffer + stream->buf_read_pos, to_copy);
    4f5e:	864a                	mv	a2,s2
    4f60:	3e1000ef          	jal	5b40 <memcpy>
            stream->buf_read_pos += to_copy;
    4f64:	41442783          	lw	a5,1044(s0)
            bytes_read += to_copy;
    4f68:	94ca                	add	s1,s1,s2
            stream->buf_read_pos += to_copy;
    4f6a:	012787bb          	addw	a5,a5,s2
    4f6e:	40f42a23          	sw	a5,1044(s0)
    while (bytes_read < total_bytes)
    4f72:	f734e3e3          	bltu	s1,s3,4ed8 <fread+0x3e>
    4f76:	b769                	j	4f00 <fread+0x66>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    4f78:	4288                	lw	a0,0(a3)
    4f7a:	863e                	mv	a2,a5
    4f7c:	01068593          	addi	a1,a3,16
    4f80:	98cfc0ef          	jal	110c <write>
        if (ret < stream->buf_write_pos)
    4f84:	41042783          	lw	a5,1040(s0)
    4f88:	02f54163          	blt	a0,a5,4faa <fread+0x110>
        stream->buf_write_pos = 0;
    4f8c:	40042823          	sw	zero,1040(s0)
    4f90:	bf0d                	j	4ec2 <fread+0x28>
}
    4f92:	60a6                	ld	ra,72(sp)
        return 0;
    4f94:	4981                	li	s3,0
}
    4f96:	854e                	mv	a0,s3
    4f98:	79a2                	ld	s3,40(sp)
    4f9a:	6161                	addi	sp,sp,80
    4f9c:	8082                	ret
                        stream->eof = 1;
    4f9e:	4785                	li	a5,1
                    if (ret == 0)
    4fa0:	e119                	bnez	a0,4fa6 <fread+0x10c>
                        stream->eof = 1;
    4fa2:	c45c                	sw	a5,12(s0)
    4fa4:	bfb1                	j	4f00 <fread+0x66>
                        stream->error = 1;
    4fa6:	c41c                	sw	a5,8(s0)
                    return bytes_read / size;
    4fa8:	bfa1                	j	4f00 <fread+0x66>
            stream->error = 1;
    4faa:	4785                	li	a5,1
    4fac:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    4fae:	40042823          	sw	zero,1040(s0)
            return EOF;
    4fb2:	bf01                	j	4ec2 <fread+0x28>

0000000000004fb4 <fwrite>:
{
    4fb4:	711d                	addi	sp,sp,-96
    4fb6:	ec86                	sd	ra,88(sp)
    4fb8:	e0ca                	sd	s2,64(sp)
    if (!stream || !ptr || size == 0 || nmemb == 0)
    4fba:	10068063          	beqz	a3,50ba <fwrite+0x106>
    4fbe:	f456                	sd	s5,40(sp)
    4fc0:	8aaa                	mv	s5,a0
    4fc2:	10050263          	beqz	a0,50c6 <fwrite+0x112>
    4fc6:	f05a                	sd	s6,32(sp)
        return 0;
    4fc8:	4901                	li	s2,0
    4fca:	8b2e                	mv	s6,a1
    if (!stream || !ptr || size == 0 || nmemb == 0)
    4fcc:	c1d9                	beqz	a1,5052 <fwrite+0x9e>
    4fce:	c251                	beqz	a2,5052 <fwrite+0x9e>
    if (stream->buf_mode == 2)
    4fd0:	41c6a703          	lw	a4,1052(a3)
    4fd4:	e8a2                	sd	s0,80(sp)
    4fd6:	4789                	li	a5,2
    uint64 total_bytes = size * nmemb;
    4fd8:	02c58933          	mul	s2,a1,a2
    if (stream->buf_mode == 2)
    4fdc:	8436                	mv	s0,a3
    4fde:	0ef70b63          	beq	a4,a5,50d4 <fwrite+0x120>
    4fe2:	fc4e                	sd	s3,56(sp)
    4fe4:	ec5e                	sd	s7,24(sp)
    4fe6:	e862                	sd	s8,16(sp)
    uint64 bytes_written = 0;
    4fe8:	4981                	li	s3,0
    4fea:	01068b93          	addi	s7,a3,16
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    4fee:	40000c13          	li	s8,1024
    while (bytes_written < total_bytes)
    4ff2:	12090263          	beqz	s2,5116 <fwrite+0x162>
    4ff6:	e4a6                	sd	s1,72(sp)
    4ff8:	f852                	sd	s4,48(sp)
    4ffa:	e466                	sd	s9,8(sp)
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    4ffc:	41042783          	lw	a5,1040(s0)
        uint64 remaining = total_bytes - bytes_written;
    5000:	41390cb3          	sub	s9,s2,s3
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, remaining);
    5004:	013a85b3          	add	a1,s5,s3
        uint64 space_left = BUFSIZ - stream->buf_write_pos;
    5008:	40fc0a3b          	subw	s4,s8,a5
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, space_left);
    500c:	00fb8533          	add	a0,s7,a5
    5010:	8652                	mv	a2,s4
        if (remaining <= space_left)
    5012:	059a6763          	bltu	s4,s9,5060 <fwrite+0xac>
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, remaining);
    5016:	8666                	mv	a2,s9
    5018:	329000ef          	jal	5b40 <memcpy>
            stream->buf_write_pos += remaining;
    501c:	41042783          	lw	a5,1040(s0)
            if (stream->buf_write_pos == BUFSIZ)
    5020:	40000713          	li	a4,1024
            stream->buf_write_pos += remaining;
    5024:	019786bb          	addw	a3,a5,s9
    5028:	40d42823          	sw	a3,1040(s0)
            if (stream->buf_write_pos == BUFSIZ)
    502c:	06e68a63          	beq	a3,a4,50a0 <fwrite+0xec>
    return bytes_written / size;
    5030:	03695933          	divu	s2,s2,s6
    5034:	6446                	ld	s0,80(sp)
    5036:	64a6                	ld	s1,72(sp)
    5038:	79e2                	ld	s3,56(sp)
    503a:	7a42                	ld	s4,48(sp)
    503c:	7aa2                	ld	s5,40(sp)
    503e:	7b02                	ld	s6,32(sp)
    5040:	6be2                	ld	s7,24(sp)
    5042:	6c42                	ld	s8,16(sp)
    5044:	6ca2                	ld	s9,8(sp)
}
    5046:	60e6                	ld	ra,88(sp)
    5048:	854a                	mv	a0,s2
    504a:	6906                	ld	s2,64(sp)
    504c:	6125                	addi	sp,sp,96
    504e:	8082                	ret
    5050:	6446                	ld	s0,80(sp)
    5052:	60e6                	ld	ra,88(sp)
    5054:	7aa2                	ld	s5,40(sp)
    5056:	7b02                	ld	s6,32(sp)
    5058:	854a                	mv	a0,s2
    505a:	6906                	ld	s2,64(sp)
    505c:	6125                	addi	sp,sp,96
    505e:	8082                	ret
            memcpy(stream->buffer + stream->buf_write_pos, src + bytes_written, space_left);
    5060:	2e1000ef          	jal	5b40 <memcpy>
            stream->buf_write_pos += space_left;
    5064:	41042783          	lw	a5,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    5068:	85de                	mv	a1,s7
            bytes_written += space_left;
    506a:	99d2                	add	s3,s3,s4
            stream->buf_write_pos += space_left;
    506c:	00fa04bb          	addw	s1,s4,a5
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    5070:	02049613          	slli	a2,s1,0x20
            stream->buf_write_pos += space_left;
    5074:	40942823          	sw	s1,1040(s0)
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    5078:	9201                	srli	a2,a2,0x20
    if (stream->buf_write_pos > 0)
    507a:	00904763          	bgtz	s1,5088 <fwrite+0xd4>
    while (bytes_written < total_bytes)
    507e:	f729efe3          	bltu	s3,s2,4ffc <fwrite+0x48>
    return bytes_written / size;
    5082:	0369d933          	divu	s2,s3,s6
    5086:	b77d                	j	5034 <fwrite+0x80>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    5088:	4008                	lw	a0,0(s0)
    508a:	882fc0ef          	jal	110c <write>
        if (ret < stream->buf_write_pos)
    508e:	41042783          	lw	a5,1040(s0)
    5092:	08f54963          	blt	a0,a5,5124 <fwrite+0x170>
        stream->buf_write_pos = 0;
    5096:	40042823          	sw	zero,1040(s0)
    while (bytes_written < total_bytes)
    509a:	f729e1e3          	bltu	s3,s2,4ffc <fwrite+0x48>
    509e:	b7d5                	j	5082 <fwrite+0xce>
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    50a0:	4008                	lw	a0,0(s0)
    50a2:	40000613          	li	a2,1024
    50a6:	85de                	mv	a1,s7
    50a8:	864fc0ef          	jal	110c <write>
        if (ret < stream->buf_write_pos)
    50ac:	41042783          	lw	a5,1040(s0)
    50b0:	08f54163          	blt	a0,a5,5132 <fwrite+0x17e>
        stream->buf_write_pos = 0;
    50b4:	40042823          	sw	zero,1040(s0)
    50b8:	bfa5                	j	5030 <fwrite+0x7c>
}
    50ba:	60e6                	ld	ra,88(sp)
        return 0;
    50bc:	4901                	li	s2,0
}
    50be:	854a                	mv	a0,s2
    50c0:	6906                	ld	s2,64(sp)
    50c2:	6125                	addi	sp,sp,96
    50c4:	8082                	ret
    50c6:	60e6                	ld	ra,88(sp)
        return 0;
    50c8:	4901                	li	s2,0
    50ca:	7aa2                	ld	s5,40(sp)
}
    50cc:	854a                	mv	a0,s2
    50ce:	6906                	ld	s2,64(sp)
    50d0:	6125                	addi	sp,sp,96
    50d2:	8082                	ret
        while (bytes_written < total_bytes)
    50d4:	f6090ee3          	beqz	s2,5050 <fwrite+0x9c>
    50d8:	e4a6                	sd	s1,72(sp)
    uint64 bytes_written = 0;
    50da:	4481                	li	s1,0
    50dc:	a021                	j	50e4 <fwrite+0x130>
            bytes_written += ret;
    50de:	94aa                	add	s1,s1,a0
        while (bytes_written < total_bytes)
    50e0:	0324f463          	bgeu	s1,s2,5108 <fwrite+0x154>
            int64 ret = write(stream->fd, src + bytes_written, total_bytes - bytes_written);
    50e4:	4008                	lw	a0,0(s0)
    50e6:	40990633          	sub	a2,s2,s1
    50ea:	009a85b3          	add	a1,s5,s1
    50ee:	81efc0ef          	jal	110c <write>
            if (ret <= 0)
    50f2:	fea046e3          	bgtz	a0,50de <fwrite+0x12a>
                stream->error = 1;
    50f6:	4785                	li	a5,1
        return bytes_written / size;
    50f8:	0364d933          	divu	s2,s1,s6
                stream->error = 1;
    50fc:	c41c                	sw	a5,8(s0)
                break;
    50fe:	64a6                	ld	s1,72(sp)
    5100:	6446                	ld	s0,80(sp)
    5102:	7aa2                	ld	s5,40(sp)
    5104:	7b02                	ld	s6,32(sp)
    5106:	b781                	j	5046 <fwrite+0x92>
        return bytes_written / size;
    5108:	0364d933          	divu	s2,s1,s6
    510c:	6446                	ld	s0,80(sp)
    510e:	64a6                	ld	s1,72(sp)
    5110:	7aa2                	ld	s5,40(sp)
    5112:	7b02                	ld	s6,32(sp)
    5114:	bf0d                	j	5046 <fwrite+0x92>
    5116:	6446                	ld	s0,80(sp)
    5118:	79e2                	ld	s3,56(sp)
    511a:	7aa2                	ld	s5,40(sp)
    511c:	7b02                	ld	s6,32(sp)
    511e:	6be2                	ld	s7,24(sp)
    5120:	6c42                	ld	s8,16(sp)
    5122:	b715                	j	5046 <fwrite+0x92>
            stream->error = 1;
    5124:	4785                	li	a5,1
    5126:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    5128:	40042823          	sw	zero,1040(s0)
    while (bytes_written < total_bytes)
    512c:	ed29e8e3          	bltu	s3,s2,4ffc <fwrite+0x48>
    5130:	bf89                	j	5082 <fwrite+0xce>
            stream->error = 1;
    5132:	4785                	li	a5,1
    5134:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    5136:	40042823          	sw	zero,1040(s0)
            return EOF;
    513a:	bddd                	j	5030 <fwrite+0x7c>

000000000000513c <fseek>:
    if (!stream)
    513c:	c925                	beqz	a0,51ac <fseek+0x70>
{
    513e:	1101                	addi	sp,sp,-32
    5140:	e04a                	sd	s2,0(sp)
    5142:	8932                	mv	s2,a2
    if (stream->buf_write_pos > 0)
    5144:	41052603          	lw	a2,1040(a0)
{
    5148:	e822                	sd	s0,16(sp)
    514a:	e426                	sd	s1,8(sp)
    514c:	ec06                	sd	ra,24(sp)
    514e:	842a                	mv	s0,a0
    5150:	84ae                	mv	s1,a1
    if (stream->buf_write_pos > 0)
    5152:	02c04863          	bgtz	a2,5182 <fseek+0x46>
    if (lseek(stream->fd, offset, whence) < 0)
    5156:	4008                	lw	a0,0(s0)
    stream->buf_read_pos = 0;
    5158:	40042a23          	sw	zero,1044(s0)
    stream->buf_read_cnt = 0;
    515c:	40042c23          	sw	zero,1048(s0)
    stream->eof = 0;
    5160:	00042623          	sw	zero,12(s0)
    if (lseek(stream->fd, offset, whence) < 0)
    5164:	864a                	mv	a2,s2
    5166:	0004859b          	sext.w	a1,s1
    516a:	832fc0ef          	jal	119c <lseek>
    516e:	87aa                	mv	a5,a0
    return 0;
    5170:	4501                	li	a0,0
    if (lseek(stream->fd, offset, whence) < 0)
    5172:	0207c463          	bltz	a5,519a <fseek+0x5e>
}
    5176:	60e2                	ld	ra,24(sp)
    5178:	6442                	ld	s0,16(sp)
    517a:	64a2                	ld	s1,8(sp)
    517c:	6902                	ld	s2,0(sp)
    517e:	6105                	addi	sp,sp,32
    5180:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    5182:	4108                	lw	a0,0(a0)
    5184:	01040593          	addi	a1,s0,16
    5188:	f85fb0ef          	jal	110c <write>
        if (ret < stream->buf_write_pos)
    518c:	41042783          	lw	a5,1040(s0)
    5190:	00f54963          	blt	a0,a5,51a2 <fseek+0x66>
        stream->buf_write_pos = 0;
    5194:	40042823          	sw	zero,1040(s0)
    5198:	bf7d                	j	5156 <fseek+0x1a>
        stream->error = 1;
    519a:	4785                	li	a5,1
    519c:	c41c                	sw	a5,8(s0)
        return -1;
    519e:	557d                	li	a0,-1
    51a0:	bfd9                	j	5176 <fseek+0x3a>
            stream->error = 1;
    51a2:	4785                	li	a5,1
    51a4:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    51a6:	40042823          	sw	zero,1040(s0)
            return EOF;
    51aa:	b775                	j	5156 <fseek+0x1a>
        return -1;
    51ac:	557d                	li	a0,-1
}
    51ae:	8082                	ret

00000000000051b0 <ftell>:
    if (!stream)
    51b0:	c505                	beqz	a0,51d8 <ftell+0x28>
{
    51b2:	1141                	addi	sp,sp,-16
    51b4:	e022                	sd	s0,0(sp)
    51b6:	842a                	mv	s0,a0
    int64 ret = lseek(stream->fd, 0, SEEK_CUR);
    51b8:	4108                	lw	a0,0(a0)
    51ba:	4605                	li	a2,1
    51bc:	4581                	li	a1,0
{
    51be:	e406                	sd	ra,8(sp)
    int64 ret = lseek(stream->fd, 0, SEEK_CUR);
    51c0:	fddfb0ef          	jal	119c <lseek>
    if (ret < 0)
    51c4:	00054663          	bltz	a0,51d0 <ftell+0x20>
}
    51c8:	60a2                	ld	ra,8(sp)
    51ca:	6402                	ld	s0,0(sp)
    51cc:	0141                	addi	sp,sp,16
    51ce:	8082                	ret
        stream->error = 1;
    51d0:	4785                	li	a5,1
    51d2:	c41c                	sw	a5,8(s0)
        return -1L;
    51d4:	557d                	li	a0,-1
    51d6:	bfcd                	j	51c8 <ftell+0x18>
    51d8:	557d                	li	a0,-1
}
    51da:	8082                	ret

00000000000051dc <rewind>:
    if (stream)
    51dc:	c915                	beqz	a0,5210 <rewind+0x34>
    if (stream->buf_write_pos > 0)
    51de:	41052603          	lw	a2,1040(a0)
{
    51e2:	1141                	addi	sp,sp,-16
    51e4:	e022                	sd	s0,0(sp)
    51e6:	e406                	sd	ra,8(sp)
    51e8:	842a                	mv	s0,a0
    if (stream->buf_write_pos > 0)
    51ea:	02c04463          	bgtz	a2,5212 <rewind+0x36>
    if (lseek(stream->fd, offset, whence) < 0)
    51ee:	4008                	lw	a0,0(s0)
    stream->buf_read_pos = 0;
    51f0:	40042a23          	sw	zero,1044(s0)
    stream->buf_read_cnt = 0;
    51f4:	40042c23          	sw	zero,1048(s0)
    stream->eof = 0;
    51f8:	00042623          	sw	zero,12(s0)
    if (lseek(stream->fd, offset, whence) < 0)
    51fc:	4601                	li	a2,0
    51fe:	4581                	li	a1,0
    5200:	f9dfb0ef          	jal	119c <lseek>
}
    5204:	60a2                	ld	ra,8(sp)
        stream->error = 0;
    5206:	00042423          	sw	zero,8(s0)
}
    520a:	6402                	ld	s0,0(sp)
    520c:	0141                	addi	sp,sp,16
    520e:	8082                	ret
    5210:	8082                	ret
        int64 ret = write(stream->fd, stream->buffer, stream->buf_write_pos);
    5212:	4108                	lw	a0,0(a0)
    5214:	01040593          	addi	a1,s0,16
    5218:	ef5fb0ef          	jal	110c <write>
        if (ret < stream->buf_write_pos)
    521c:	41042783          	lw	a5,1040(s0)
    5220:	00f54563          	blt	a0,a5,522a <rewind+0x4e>
        stream->buf_write_pos = 0;
    5224:	40042823          	sw	zero,1040(s0)
    5228:	b7d9                	j	51ee <rewind+0x12>
            stream->error = 1;
    522a:	4785                	li	a5,1
    522c:	c41c                	sw	a5,8(s0)
            stream->buf_write_pos = 0;
    522e:	40042823          	sw	zero,1040(s0)
            return EOF;
    5232:	bf75                	j	51ee <rewind+0x12>

0000000000005234 <feof>:
    return (stream) ? stream->eof : 1;
    5234:	c119                	beqz	a0,523a <feof+0x6>
    5236:	4548                	lw	a0,12(a0)
    5238:	8082                	ret
    523a:	4505                	li	a0,1
}
    523c:	8082                	ret

000000000000523e <ferror>:
     return (stream) ? stream->error : 1;
    523e:	c119                	beqz	a0,5244 <ferror+0x6>
    5240:	4508                	lw	a0,8(a0)
    5242:	8082                	ret
    5244:	4505                	li	a0,1
}
    5246:	8082                	ret

0000000000005248 <clearerr>:
    if (stream)
    5248:	c509                	beqz	a0,5252 <clearerr+0xa>
        stream->error = 0;
    524a:	00052423          	sw	zero,8(a0)
        stream->eof = 0;
    524e:	00052623          	sw	zero,12(a0)
}
    5252:	8082                	ret

0000000000005254 <ungetc>:
    if (!stream || c == EOF)
    5254:	c19d                	beqz	a1,527a <ungetc+0x26>
    5256:	57fd                	li	a5,-1
    5258:	02f50163          	beq	a0,a5,527a <ungetc+0x26>
    if (stream->buf_read_pos > 0)
    525c:	4145a783          	lw	a5,1044(a1)
    5260:	00f05d63          	blez	a5,527a <ungetc+0x26>
        stream->buf_read_pos--;
    5264:	fff7871b          	addiw	a4,a5,-1
    5268:	40e5aa23          	sw	a4,1044(a1)
        stream->buffer[stream->buf_read_pos] = (char)c;
    526c:	00e587b3          	add	a5,a1,a4
    5270:	00a78823          	sb	a0,16(a5)
        stream->eof = 0;
    5274:	0005a623          	sw	zero,12(a1)
        return c;
    5278:	8082                	ret
        return EOF;
    527a:	557d                	li	a0,-1
    527c:	8082                	ret

000000000000527e <strtoull.part.0>:
    return new_ptr;
}

/* String Conversion*/

unsigned long long strtoull(const char *nptr, char **endptr, int base)
    527e:	1141                	addi	sp,sp,-16
    5280:	e422                	sd	s0,8(sp)
    5282:	8eaa                	mv	t4,a0
{
    const char *s = nptr;
    5284:	88aa                	mv	a7,a0
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    static inline int islower(int c) { return c >= 'a' && c <= 'z'; }
    static inline int isupper(int c) { return c >= 'A' && c <= 'Z'; }
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    static inline int isalnum(int c) { return isalpha(c) || isdigit(c); }
    static inline int isspace(int c) { return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r'; }
    5286:	02000313          	li	t1,32
    528a:	4e11                	li	t3,4
        return 0;
    }

    do
    {
        c = *s++;
    528c:	0008c783          	lbu	a5,0(a7)
    5290:	00188813          	addi	a6,a7,1
    5294:	ff77871b          	addiw	a4,a5,-9
    5298:	0ff77693          	zext.b	a3,a4
    529c:	0007871b          	sext.w	a4,a5
    52a0:	04678363          	beq	a5,t1,52e6 <strtoull.part.0+0x68>
    52a4:	04de7163          	bgeu	t3,a3,52e6 <strtoull.part.0+0x68>
    } while (isspace(c));

    if (c == '-')
    52a8:	02d00793          	li	a5,45
    52ac:	0ef70863          	beq	a4,a5,539c <strtoull.part.0+0x11e>
    {
        neg = 1;
        c = *s++;
    }
    else if (c == '+')
    52b0:	02b00793          	li	a5,43
    int neg = 0, any, cutlim;
    52b4:	4381                	li	t2,0
    else if (c == '+')
    52b6:	08f70c63          	beq	a4,a5,534e <strtoull.part.0+0xd0>
    {
        c = *s++;
    }

    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    52ba:	ea05                	bnez	a2,52ea <strtoull.part.0+0x6c>
    52bc:	03000793          	li	a5,48
    52c0:	0ef70463          	beq	a4,a5,53a8 <strtoull.part.0+0x12a>
    52c4:	00ccd8b7          	lui	a7,0xccd
    52c8:	ccd88893          	addi	a7,a7,-819 # cccccd <_ZSt4cerr+0xcc3e8d>
    52cc:	08b2                	slli	a7,a7,0xc
    52ce:	ccd88893          	addi	a7,a7,-819
    52d2:	08b2                	slli	a7,a7,0xc
    52d4:	ccd88893          	addi	a7,a7,-819
    52d8:	08b6                	slli	a7,a7,0xd
    52da:	4415                	li	s0,5
    52dc:	99988893          	addi	a7,a7,-1639
    52e0:	42a9                	li	t0,10
        c = s[1];
        s += 2;
        base = 16;
    }
    if (base == 0)
        base = (c == '0' ? 8 : 10);
    52e2:	4629                	li	a2,10
    52e4:	a829                	j	52fe <strtoull.part.0+0x80>
unsigned long long strtoull(const char *nptr, char **endptr, int base)
    52e6:	88c2                	mv	a7,a6
    52e8:	b755                	j	528c <strtoull.part.0+0xe>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    52ea:	47c1                	li	a5,16
    52ec:	0cf60d63          	beq	a2,a5,53c6 <strtoull.part.0+0x148>

    cutoff = ULLONG_MAX / (unsigned long long)base;
    52f0:	58fd                	li	a7,-1
    cutlim = ULLONG_MAX % (unsigned long long)base;
    52f2:	02c8f433          	remu	s0,a7,a2
    cutoff = ULLONG_MAX / (unsigned long long)base;
    52f6:	82b2                	mv	t0,a2
    52f8:	02c8d8b3          	divu	a7,a7,a2
    cutlim = ULLONG_MAX % (unsigned long long)base;
    52fc:	2401                	sext.w	s0,s0

    for (acc = 0, any = 0;; c = *s++)
    52fe:	4301                	li	t1,0
    5300:	4501                	li	a0,0
    {
        if (isdigit(c))
    5302:	4e25                	li	t3,9
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    5304:	4fe5                	li	t6,25
            break;

        if (c >= base)
            break;

        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    5306:	5f7d                	li	t5,-1
        if (isdigit(c))
    5308:	fd07079b          	addiw	a5,a4,-48
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    530c:	0007069b          	sext.w	a3,a4
    5310:	00fe7e63          	bgeu	t3,a5,532c <strtoull.part.0+0xae>
    static inline int isalpha(int c) { return islower(c) || isupper(c); }
    5314:	f9f6879b          	addiw	a5,a3,-97
    5318:	04fff063          	bgeu	t6,a5,5358 <strtoull.part.0+0xda>
    531c:	fbf6869b          	addiw	a3,a3,-65
    5320:	04dfe163          	bltu	t6,a3,5362 <strtoull.part.0+0xe4>
            c -= isupper(c) ? 'A' - 10 : 'a' - 10;
    5324:	03700793          	li	a5,55
    5328:	40f707bb          	subw	a5,a4,a5
        if (c >= base)
    532c:	02c7db63          	bge	a5,a2,5362 <strtoull.part.0+0xe4>
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    5330:	01e30b63          	beq	t1,t5,5346 <strtoull.part.0+0xc8>
            any = -1;
    5334:	537d                	li	t1,-1
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    5336:	00a8e863          	bltu	a7,a0,5346 <strtoull.part.0+0xc8>
    533a:	05150e63          	beq	a0,a7,5396 <strtoull.part.0+0x118>
        else
        {
            any = 1;
    533e:	4305                	li	t1,1
            acc *= base;
    5340:	02550533          	mul	a0,a0,t0
            acc += c;
    5344:	953e                	add	a0,a0,a5
    for (acc = 0, any = 0;; c = *s++)
    5346:	0805                	addi	a6,a6,1
    5348:	fff84703          	lbu	a4,-1(a6)
        if (isdigit(c))
    534c:	bf75                	j	5308 <strtoull.part.0+0x8a>
        c = *s++;
    534e:	00084703          	lbu	a4,0(a6)
    5352:	00288813          	addi	a6,a7,2
    5356:	b795                	j	52ba <strtoull.part.0+0x3c>
            c -= isupper(c) ? 'A' - 10 : 'a' - 10;
    5358:	05700793          	li	a5,87
    535c:	40f707bb          	subw	a5,a4,a5
    5360:	b7f1                	j	532c <strtoull.part.0+0xae>
        }
    }

    if (any < 0)
    5362:	57fd                	li	a5,-1
    5364:	00f30e63          	beq	t1,a5,5380 <strtoull.part.0+0x102>
    {
        acc = ULLONG_MAX;
        errno = ERANGE;
    }
    else if (neg)
    5368:	00038463          	beqz	t2,5370 <strtoull.part.0+0xf2>
        acc = -acc;
    536c:	40a00533          	neg	a0,a0

    if (endptr != 0)
    5370:	c589                	beqz	a1,537a <strtoull.part.0+0xfc>
        *endptr = (char *)(any ? s - 1 : nptr);
    5372:	00031f63          	bnez	t1,5390 <strtoull.part.0+0x112>
    5376:	01d5b023          	sd	t4,0(a1)

    return acc;
}
    537a:	6422                	ld	s0,8(sp)
    537c:	0141                	addi	sp,sp,16
    537e:	8082                	ret
        errno = ERANGE;
    5380:	02200793          	li	a5,34
    5384:	00004717          	auipc	a4,0x4
    5388:	98f72223          	sw	a5,-1660(a4) # 8d08 <errno>
        acc = ULLONG_MAX;
    538c:	557d                	li	a0,-1
    if (endptr != 0)
    538e:	d5f5                	beqz	a1,537a <strtoull.part.0+0xfc>
        *endptr = (char *)(any ? s - 1 : nptr);
    5390:	fff80e93          	addi	t4,a6,-1
    5394:	b7cd                	j	5376 <strtoull.part.0+0xf8>
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
    5396:	faf448e3          	blt	s0,a5,5346 <strtoull.part.0+0xc8>
    539a:	b755                	j	533e <strtoull.part.0+0xc0>
        c = *s++;
    539c:	00084703          	lbu	a4,0(a6)
        neg = 1;
    53a0:	4385                	li	t2,1
        c = *s++;
    53a2:	00288813          	addi	a6,a7,2
    53a6:	bf11                	j	52ba <strtoull.part.0+0x3c>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    53a8:	00084783          	lbu	a5,0(a6)
    53ac:	05800693          	li	a3,88
    53b0:	0df7f793          	andi	a5,a5,223
    53b4:	02d78b63          	beq	a5,a3,53ea <strtoull.part.0+0x16c>
    53b8:	58fd                	li	a7,-1
    53ba:	441d                	li	s0,7
    53bc:	0038d893          	srli	a7,a7,0x3
    53c0:	42a1                	li	t0,8
        base = (c == '0' ? 8 : 10);
    53c2:	4621                	li	a2,8
    53c4:	bf2d                	j	52fe <strtoull.part.0+0x80>
    if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X'))
    53c6:	03000793          	li	a5,48
    53ca:	00f70863          	beq	a4,a5,53da <strtoull.part.0+0x15c>
    53ce:	58fd                	li	a7,-1
    53d0:	443d                	li	s0,15
    53d2:	0048d893          	srli	a7,a7,0x4
    53d6:	42c1                	li	t0,16
    53d8:	b71d                	j	52fe <strtoull.part.0+0x80>
    53da:	00084783          	lbu	a5,0(a6)
    53de:	05800693          	li	a3,88
    53e2:	0df7f793          	andi	a5,a5,223
    53e6:	fed794e3          	bne	a5,a3,53ce <strtoull.part.0+0x150>
        s += 2;
    53ea:	58fd                	li	a7,-1
        c = s[1];
    53ec:	00184703          	lbu	a4,1(a6)
        s += 2;
    53f0:	443d                	li	s0,15
    53f2:	0809                	addi	a6,a6,2
    53f4:	0048d893          	srli	a7,a7,0x4
    53f8:	42c1                	li	t0,16
        base = 16;
    53fa:	4641                	li	a2,16
    53fc:	b709                	j	52fe <strtoull.part.0+0x80>

00000000000053fe <atexit>:
    if (__atexit_func_count >= ATEXIT_MAX)
    53fe:	00004717          	auipc	a4,0x4
    5402:	90a70713          	addi	a4,a4,-1782 # 8d08 <errno>
    5406:	435c                	lw	a5,4(a4)
    5408:	46fd                	li	a3,31
    540a:	00f6ca63          	blt	a3,a5,541e <atexit+0x20>
    __atexit_funcs[__atexit_func_count++] = function;
    540e:	00379693          	slli	a3,a5,0x3
    5412:	96ba                	add	a3,a3,a4
    5414:	2785                	addiw	a5,a5,1
    5416:	e688                	sd	a0,8(a3)
    5418:	c35c                	sw	a5,4(a4)
    return 0;
    541a:	4501                	li	a0,0
    541c:	8082                	ret
        return -1;
    541e:	557d                	li	a0,-1
}
    5420:	8082                	ret

0000000000005422 <exit>:
{
    5422:	1101                	addi	sp,sp,-32
    5424:	e822                	sd	s0,16(sp)
    while (__atexit_func_count > 0)
    5426:	00004417          	auipc	s0,0x4
    542a:	8e240413          	addi	s0,s0,-1822 # 8d08 <errno>
    542e:	405c                	lw	a5,4(s0)
{
    5430:	e426                	sd	s1,8(sp)
    5432:	ec06                	sd	ra,24(sp)
    5434:	84aa                	mv	s1,a0
    while (__atexit_func_count > 0)
    5436:	00f05d63          	blez	a5,5450 <exit+0x2e>
        (__atexit_funcs[--__atexit_func_count])();
    543a:	fff7871b          	addiw	a4,a5,-1
    543e:	87ba                	mv	a5,a4
    5440:	070e                	slli	a4,a4,0x3
    5442:	9722                	add	a4,a4,s0
    5444:	6718                	ld	a4,8(a4)
    5446:	c05c                	sw	a5,4(s0)
    5448:	9702                	jalr	a4
    while (__atexit_func_count > 0)
    544a:	405c                	lw	a5,4(s0)
    544c:	fef047e3          	bgtz	a5,543a <exit+0x18>
    sys_exit(status);
    5450:	8526                	mv	a0,s1
    5452:	c93fb0ef          	jal	10e4 <sys_exit>
    while (1)
    5456:	a001                	j	5456 <exit+0x34>

0000000000005458 <abort>:
{
    5458:	1141                	addi	sp,sp,-16
    exit(127);
    545a:	07f00513          	li	a0,127
{
    545e:	e406                	sd	ra,8(sp)
    exit(127);
    5460:	fc3ff0ef          	jal	5422 <exit>

0000000000005464 <getenv>:
}
    5464:	4501                	li	a0,0
    5466:	8082                	ret

0000000000005468 <system>:
}
    5468:	557d                	li	a0,-1
    546a:	8082                	ret

000000000000546c <free>:
    if (!ptr)
    546c:	c121                	beqz	a0,54ac <free+0x40>
    for (p = freep; !(bp > p && bp < p->next); p = p->next)
    546e:	00004617          	auipc	a2,0x4
    5472:	89a60613          	addi	a2,a2,-1894 # 8d08 <errno>
    5476:	10863783          	ld	a5,264(a2)
    bp = (header_t *)ptr - 1;
    547a:	ff050693          	addi	a3,a0,-16
        if (p >= p->next && (bp > p || bp < p->next))
    547e:	6798                	ld	a4,8(a5)
    for (p = freep; !(bp > p && bp < p->next); p = p->next)
    5480:	02d7f763          	bgeu	a5,a3,54ae <free+0x42>
    5484:	00e6e463          	bltu	a3,a4,548c <free+0x20>
        if (p >= p->next && (bp > p || bp < p->next))
    5488:	02e7e763          	bltu	a5,a4,54b6 <free+0x4a>
    if ((char *)bp + bp->size == (char *)p->next)
    548c:	ff053583          	ld	a1,-16(a0)
    5490:	00b68833          	add	a6,a3,a1
    5494:	03070363          	beq	a4,a6,54ba <free+0x4e>
    if ((char *)p + p->size == (char *)bp)
    5498:	638c                	ld	a1,0(a5)
    549a:	fee53c23          	sd	a4,-8(a0)
    549e:	00b78833          	add	a6,a5,a1
    54a2:	03068963          	beq	a3,a6,54d4 <free+0x68>
    54a6:	e794                	sd	a3,8(a5)
    freep = p;
    54a8:	10f63423          	sd	a5,264(a2)
}
    54ac:	8082                	ret
        if (p >= p->next && (bp > p || bp < p->next))
    54ae:	00e7e463          	bltu	a5,a4,54b6 <free+0x4a>
    54b2:	fce6ede3          	bltu	a3,a4,548c <free+0x20>
{
    54b6:	87ba                	mv	a5,a4
    54b8:	b7d9                	j	547e <free+0x12>
        bp->size += p->next->size;
    54ba:	00073803          	ld	a6,0(a4)
        bp->next = p->next->next;
    54be:	6718                	ld	a4,8(a4)
        bp->size += p->next->size;
    54c0:	95c2                	add	a1,a1,a6
    54c2:	feb53823          	sd	a1,-16(a0)
    if ((char *)p + p->size == (char *)bp)
    54c6:	638c                	ld	a1,0(a5)
    54c8:	fee53c23          	sd	a4,-8(a0)
    54cc:	00b78833          	add	a6,a5,a1
    54d0:	fd069be3          	bne	a3,a6,54a6 <free+0x3a>
        p->size += bp->size;
    54d4:	ff053503          	ld	a0,-16(a0)
        p->next = bp->next;
    54d8:	86ba                	mv	a3,a4
        p->size += bp->size;
    54da:	00b50733          	add	a4,a0,a1
    54de:	e398                	sd	a4,0(a5)
        p->next = bp->next;
    54e0:	b7d9                	j	54a6 <free+0x3a>

00000000000054e2 <malloc>:
    if (size == 0)
    54e2:	c169                	beqz	a0,55a4 <malloc+0xc2>
{
    54e4:	7179                	addi	sp,sp,-48
    54e6:	ec26                	sd	s1,24(sp)
    if ((prevp = freep) == NULL)
    54e8:	00004497          	auipc	s1,0x4
    54ec:	82048493          	addi	s1,s1,-2016 # 8d08 <errno>
    54f0:	1084b783          	ld	a5,264(s1)
{
    54f4:	f022                	sd	s0,32(sp)
    size = ALIGN(size + sizeof(header_t));
    54f6:	057d                	addi	a0,a0,31
{
    54f8:	f406                	sd	ra,40(sp)
    size = ALIGN(size + sizeof(header_t));
    54fa:	ff057413          	andi	s0,a0,-16
    if ((prevp = freep) == NULL)
    54fe:	c3d1                	beqz	a5,5582 <malloc+0xa0>
    for (p = prevp->next;; prevp = p, p = p->next)
    5500:	6788                	ld	a0,8(a5)
        if (p->size >= size)
    5502:	6118                	ld	a4,0(a0)
    5504:	06877163          	bgeu	a4,s0,5566 <malloc+0x84>
    5508:	e44e                	sd	s3,8(sp)
    550a:	e052                	sd	s4,0(sp)
    550c:	e84a                	sd	s2,16(sp)
    if (nu < 4096)
    550e:	6a05                	lui	s4,0x1
    if (cp == (void *)-1)
    5510:	59fd                	li	s3,-1
    5512:	a029                	j	551c <malloc+0x3a>
    for (p = prevp->next;; prevp = p, p = p->next)
    5514:	6788                	ld	a0,8(a5)
        if (p->size >= size)
    5516:	6118                	ld	a4,0(a0)
    5518:	04877463          	bgeu	a4,s0,5560 <malloc+0x7e>
        if (p == freep)
    551c:	1084b703          	ld	a4,264(s1)
    5520:	87aa                	mv	a5,a0
    5522:	fee519e3          	bne	a0,a4,5514 <malloc+0x32>
    if (nu < 4096)
    5526:	8922                	mv	s2,s0
    5528:	01447363          	bgeu	s0,s4,552e <malloc+0x4c>
    552c:	6905                	lui	s2,0x1
    cp = (char *)sbrk(nu);
    552e:	854a                	mv	a0,s2
    5530:	c45fb0ef          	jal	1174 <sbrk>
    5534:	87aa                	mv	a5,a0
    free((void *)(up + 1));
    5536:	0541                	addi	a0,a0,16
    if (cp == (void *)-1)
    5538:	01378963          	beq	a5,s3,554a <malloc+0x68>
    up->size = nu;
    553c:	0127b023          	sd	s2,0(a5)
    free((void *)(up + 1));
    5540:	f2dff0ef          	jal	546c <free>
    return freep;
    5544:	1084b783          	ld	a5,264(s1)
            if ((p = morecore(size)) == NULL)
    5548:	f7f1                	bnez	a5,5514 <malloc+0x32>
}
    554a:	70a2                	ld	ra,40(sp)
    554c:	7402                	ld	s0,32(sp)
                errno = ENOMEM;
    554e:	47b1                	li	a5,12
    5550:	c09c                	sw	a5,0(s1)
                return NULL;
    5552:	6942                	ld	s2,16(sp)
    5554:	69a2                	ld	s3,8(sp)
    5556:	6a02                	ld	s4,0(sp)
}
    5558:	64e2                	ld	s1,24(sp)
        return NULL;
    555a:	4501                	li	a0,0
}
    555c:	6145                	addi	sp,sp,48
    555e:	8082                	ret
    5560:	6942                	ld	s2,16(sp)
    5562:	69a2                	ld	s3,8(sp)
    5564:	6a02                	ld	s4,0(sp)
            if (p->size == size)
    5566:	02e40c63          	beq	s0,a4,559e <malloc+0xbc>
                p->size -= size;
    556a:	8f01                	sub	a4,a4,s0
    556c:	e118                	sd	a4,0(a0)
                p = (header_t *)((char *)p + p->size);
    556e:	953a                	add	a0,a0,a4
                p->size = size;
    5570:	e100                	sd	s0,0(a0)
}
    5572:	70a2                	ld	ra,40(sp)
    5574:	7402                	ld	s0,32(sp)
            freep = prevp;
    5576:	10f4b423          	sd	a5,264(s1)
            return (void *)(p + 1);
    557a:	0541                	addi	a0,a0,16
}
    557c:	64e2                	ld	s1,24(sp)
    557e:	6145                	addi	sp,sp,48
    5580:	8082                	ret
        base.next = freep = prevp = &base;
    5582:	00004517          	auipc	a0,0x4
    5586:	89650513          	addi	a0,a0,-1898 # 8e18 <base>
    558a:	10a4b423          	sd	a0,264(s1)
    558e:	10a4bc23          	sd	a0,280(s1)
        base.size = 0;
    5592:	00004797          	auipc	a5,0x4
    5596:	8807b323          	sd	zero,-1914(a5) # 8e18 <base>
        if (p->size >= size)
    559a:	f43d                	bnez	s0,5508 <malloc+0x26>
        base.next = freep = prevp = &base;
    559c:	87aa                	mv	a5,a0
                prevp->next = p->next;
    559e:	6518                	ld	a4,8(a0)
    55a0:	e798                	sd	a4,8(a5)
    55a2:	bfc1                	j	5572 <malloc+0x90>
        return NULL;
    55a4:	4501                	li	a0,0
}
    55a6:	8082                	ret

00000000000055a8 <calloc>:
    if (__builtin_mul_overflow(nmemb, size, &total))
    55a8:	02b537b3          	mulhu	a5,a0,a1
{
    55ac:	1101                	addi	sp,sp,-32
    55ae:	e822                	sd	s0,16(sp)
    55b0:	ec06                	sd	ra,24(sp)
    55b2:	e426                	sd	s1,8(sp)
    if (__builtin_mul_overflow(nmemb, size, &total))
    55b4:	02b50433          	mul	s0,a0,a1
    55b8:	e385                	bnez	a5,55d8 <calloc+0x30>
    void *p = malloc(total);
    55ba:	8522                	mv	a0,s0
    55bc:	f27ff0ef          	jal	54e2 <malloc>
    55c0:	84aa                	mv	s1,a0
    if (p)
    55c2:	c509                	beqz	a0,55cc <calloc+0x24>
        memset(p, 0, total);
    55c4:	8622                	mv	a2,s0
    55c6:	4581                	li	a1,0
    55c8:	524000ef          	jal	5aec <memset>
}
    55cc:	60e2                	ld	ra,24(sp)
    55ce:	6442                	ld	s0,16(sp)
    55d0:	8526                	mv	a0,s1
    55d2:	64a2                	ld	s1,8(sp)
    55d4:	6105                	addi	sp,sp,32
    55d6:	8082                	ret
    55d8:	60e2                	ld	ra,24(sp)
    55da:	6442                	ld	s0,16(sp)
        errno = ENOMEM;
    55dc:	47b1                	li	a5,12
        return NULL;
    55de:	4481                	li	s1,0
        errno = ENOMEM;
    55e0:	00003717          	auipc	a4,0x3
    55e4:	72f72423          	sw	a5,1832(a4) # 8d08 <errno>
}
    55e8:	8526                	mv	a0,s1
    55ea:	64a2                	ld	s1,8(sp)
    55ec:	6105                	addi	sp,sp,32
    55ee:	8082                	ret

00000000000055f0 <realloc>:
    if (!ptr)
    55f0:	c929                	beqz	a0,5642 <realloc+0x52>
{
    55f2:	1101                	addi	sp,sp,-32
    55f4:	ec06                	sd	ra,24(sp)
    55f6:	e426                	sd	s1,8(sp)
    if (size == 0)
    55f8:	c5b9                	beqz	a1,5646 <realloc+0x56>
    if (bp->size >= new_size)
    55fa:	ff053703          	ld	a4,-16(a0)
    size_t new_size = ALIGN(size + sizeof(header_t));
    55fe:	01f58793          	addi	a5,a1,31
    5602:	e822                	sd	s0,16(sp)
    5604:	9bc1                	andi	a5,a5,-16
    5606:	842a                	mv	s0,a0
        return ptr;
    5608:	84aa                	mv	s1,a0
    if (bp->size >= new_size)
    560a:	00f76863          	bltu	a4,a5,561a <realloc+0x2a>
    560e:	6442                	ld	s0,16(sp)
}
    5610:	60e2                	ld	ra,24(sp)
    5612:	8526                	mv	a0,s1
    5614:	64a2                	ld	s1,8(sp)
    5616:	6105                	addi	sp,sp,32
    5618:	8082                	ret
    void *new_ptr = malloc(size);
    561a:	852e                	mv	a0,a1
    561c:	ec7ff0ef          	jal	54e2 <malloc>
    5620:	84aa                	mv	s1,a0
    if (!new_ptr)
    5622:	d575                	beqz	a0,560e <realloc+0x1e>
    memcpy(new_ptr, ptr, bp->size - sizeof(header_t));
    5624:	ff043603          	ld	a2,-16(s0)
    5628:	85a2                	mv	a1,s0
    562a:	1641                	addi	a2,a2,-16
    562c:	514000ef          	jal	5b40 <memcpy>
    free(ptr);
    5630:	8522                	mv	a0,s0
    5632:	e3bff0ef          	jal	546c <free>
}
    5636:	60e2                	ld	ra,24(sp)
    free(ptr);
    5638:	6442                	ld	s0,16(sp)
}
    563a:	8526                	mv	a0,s1
    563c:	64a2                	ld	s1,8(sp)
    563e:	6105                	addi	sp,sp,32
    5640:	8082                	ret
        return malloc(size);
    5642:	852e                	mv	a0,a1
    5644:	bd79                	j	54e2 <malloc>
        free(ptr);
    5646:	e27ff0ef          	jal	546c <free>
        return NULL;
    564a:	4481                	li	s1,0
    564c:	b7d1                	j	5610 <realloc+0x20>

000000000000564e <strtoull>:
    if (base < 0 || base == 1 || base > 36)
    564e:	02400813          	li	a6,36
{
    5652:	86aa                	mv	a3,a0
    5654:	872e                	mv	a4,a1
    if (base < 0 || base == 1 || base > 36)
    5656:	00c86663          	bltu	a6,a2,5662 <strtoull+0x14>
    565a:	4805                	li	a6,1
    565c:	01060363          	beq	a2,a6,5662 <strtoull+0x14>
    5660:	b939                	j	527e <strtoull.part.0>
        if (endptr)
    5662:	c311                	beqz	a4,5666 <strtoull+0x18>
            *endptr = (char *)nptr;
    5664:	e314                	sd	a3,0(a4)
        errno = 0; /* EINVAL */
    5666:	00003797          	auipc	a5,0x3
    566a:	6a07a123          	sw	zero,1698(a5) # 8d08 <errno>
}
    566e:	4501                	li	a0,0
    5670:	8082                	ret

0000000000005672 <strtoll>:

long long strtoll(const char *nptr, char **endptr, int base)
{
    5672:	1141                	addi	sp,sp,-16
    5674:	e406                	sd	ra,8(sp)
    5676:	e022                	sd	s0,0(sp)
    const char *s = nptr;
    5678:	86aa                	mv	a3,a0
    static inline int isspace(int c) { return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r'; }
    567a:	02000813          	li	a6,32
    567e:	4891                	li	a7,4
    unsigned long long acc;
    int c, neg = 0;

    do
    {
        c = *s++;
    5680:	0006c783          	lbu	a5,0(a3)
    5684:	0685                	addi	a3,a3,1
    5686:	ff77871b          	addiw	a4,a5,-9
    568a:	0ff77713          	zext.b	a4,a4
    568e:	0007841b          	sext.w	s0,a5
    5692:	ff0787e3          	beq	a5,a6,5680 <strtoll+0xe>
    5696:	fee8f5e3          	bgeu	a7,a4,5680 <strtoll+0xe>
    if (base < 0 || base == 1 || base > 36)
    569a:	02400793          	li	a5,36
    569e:	02c7ec63          	bltu	a5,a2,56d6 <strtoll+0x64>
    56a2:	4785                	li	a5,1
    56a4:	02f60963          	beq	a2,a5,56d6 <strtoll+0x64>
    56a8:	bd7ff0ef          	jal	527e <strtoull.part.0>
    if (c == '-')
        neg = 1;

    acc = strtoull(nptr, endptr, base);

    if (errno == ERANGE && acc == ULLONG_MAX)
    56ac:	00003797          	auipc	a5,0x3
    56b0:	65c78793          	addi	a5,a5,1628 # 8d08 <errno>
    56b4:	4394                	lw	a3,0(a5)
    56b6:	02200713          	li	a4,34
    56ba:	04e68363          	beq	a3,a4,5700 <strtoll+0x8e>
        return neg ? LLONG_MIN : LLONG_MAX;

    if (!neg && acc > (unsigned long long)LLONG_MAX)
    56be:	02d00713          	li	a4,45
    56c2:	02e40563          	beq	s0,a4,56ec <strtoll+0x7a>
    56c6:	00055f63          	bgez	a0,56e4 <strtoll+0x72>
    {
        errno = ERANGE;
    56ca:	02200713          	li	a4,34
    56ce:	c398                	sw	a4,0(a5)
        return neg ? LLONG_MIN : LLONG_MAX;
    56d0:	557d                	li	a0,-1
    56d2:	8105                	srli	a0,a0,0x1
    56d4:	a801                	j	56e4 <strtoll+0x72>
        if (endptr)
    56d6:	c191                	beqz	a1,56da <strtoll+0x68>
            *endptr = (char *)nptr;
    56d8:	e188                	sd	a0,0(a1)
        errno = 0; /* EINVAL */
    56da:	00003797          	auipc	a5,0x3
    56de:	6207a723          	sw	zero,1582(a5) # 8d08 <errno>
    {
        errno = ERANGE;
        return LLONG_MIN;
    }

    return neg ? -(long long)acc : (long long)acc;
    56e2:	4501                	li	a0,0
}
    56e4:	60a2                	ld	ra,8(sp)
    56e6:	6402                	ld	s0,0(sp)
    56e8:	0141                	addi	sp,sp,16
    56ea:	8082                	ret
    if (neg && acc > (unsigned long long)LLONG_MAX + 1)
    56ec:	577d                	li	a4,-1
    56ee:	177e                	slli	a4,a4,0x3f
    56f0:	02a76263          	bltu	a4,a0,5714 <strtoll+0xa2>
}
    56f4:	60a2                	ld	ra,8(sp)
    56f6:	6402                	ld	s0,0(sp)
    return neg ? -(long long)acc : (long long)acc;
    56f8:	40a00533          	neg	a0,a0
}
    56fc:	0141                	addi	sp,sp,16
    56fe:	8082                	ret
    if (errno == ERANGE && acc == ULLONG_MAX)
    5700:	577d                	li	a4,-1
    5702:	fae51ee3          	bne	a0,a4,56be <strtoll+0x4c>
        return neg ? LLONG_MIN : LLONG_MAX;
    5706:	02d00793          	li	a5,45
    570a:	fcf413e3          	bne	s0,a5,56d0 <strtoll+0x5e>
        return LLONG_MIN;
    570e:	557d                	li	a0,-1
    5710:	157e                	slli	a0,a0,0x3f
    5712:	bfc9                	j	56e4 <strtoll+0x72>
        errno = ERANGE;
    5714:	02200713          	li	a4,34
    5718:	c398                	sw	a4,0(a5)
        return LLONG_MIN;
    571a:	bfd5                	j	570e <strtoll+0x9c>

000000000000571c <strtoul>:
    if (base < 0 || base == 1 || base > 36)
    571c:	02400813          	li	a6,36

unsigned long strtoul(const char *nptr, char **endptr, int base)
{
    5720:	86aa                	mv	a3,a0
    5722:	872e                	mv	a4,a1
    if (base < 0 || base == 1 || base > 36)
    5724:	00c86663          	bltu	a6,a2,5730 <strtoul+0x14>
    5728:	4805                	li	a6,1
    572a:	01060363          	beq	a2,a6,5730 <strtoul+0x14>
    572e:	be81                	j	527e <strtoull.part.0>
        if (endptr)
    5730:	c311                	beqz	a4,5734 <strtoul+0x18>
            *endptr = (char *)nptr;
    5732:	e314                	sd	a3,0(a4)
        errno = 0; /* EINVAL */
    5734:	00003797          	auipc	a5,0x3
    5738:	5c07aa23          	sw	zero,1492(a5) # 8d08 <errno>
    {
        errno = ERANGE;
        return ULONG_MAX;
    }
    return (unsigned long)ret;
}
    573c:	4501                	li	a0,0
    573e:	8082                	ret

0000000000005740 <strtol>:

long strtol(const char *nptr, char **endptr, int base)
{
    long long ret = strtoll(nptr, endptr, base);
    5740:	bf0d                	j	5672 <strtoll>

0000000000005742 <atoi>:
        return LONG_MIN;
    }
    return (long)ret;
}

int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    5742:	1141                	addi	sp,sp,-16
    long long ret = strtoll(nptr, endptr, base);
    5744:	4629                	li	a2,10
    5746:	4581                	li	a1,0
int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    5748:	e406                	sd	ra,8(sp)
    long long ret = strtoll(nptr, endptr, base);
    574a:	f29ff0ef          	jal	5672 <strtoll>
int atoi(const char *nptr) { return (int)strtol(nptr, NULL, 10); }
    574e:	60a2                	ld	ra,8(sp)
    5750:	2501                	sext.w	a0,a0
    5752:	0141                	addi	sp,sp,16
    5754:	8082                	ret

0000000000005756 <atol>:
    long long ret = strtoll(nptr, endptr, base);
    5756:	4629                	li	a2,10
    5758:	4581                	li	a1,0
    575a:	bf21                	j	5672 <strtoll>

000000000000575c <atoll>:
long atol(const char *nptr) { return strtol(nptr, NULL, 10); }
long long atoll(const char *nptr) { return strtoll(nptr, NULL, 10); }
    575c:	4629                	li	a2,10
    575e:	4581                	li	a1,0
    5760:	bf09                	j	5672 <strtoll>

0000000000005762 <strtod>:
    5762:	02000693          	li	a3,32
    5766:	4611                	li	a2,4
{
    double val = 0.0;
    int sign = 1;
    const char *s = nptr;

    while (isspace(*s))
    5768:	00054783          	lbu	a5,0(a0)
    576c:	ff77871b          	addiw	a4,a5,-9
    5770:	0ff77713          	zext.b	a4,a4
    5774:	06d78263          	beq	a5,a3,57d8 <strtod+0x76>
    5778:	06e67063          	bgeu	a2,a4,57d8 <strtod+0x76>
        s++;
    if (*s == '-')
    577c:	02d00713          	li	a4,45
    5780:	08e78e63          	beq	a5,a4,581c <strtod+0xba>
    {
        sign = -1;
        s++;
    }
    else if (*s == '+')
    5784:	02b00713          	li	a4,43
    5788:	0ae78263          	beq	a5,a4,582c <strtod+0xca>
    578c:	00001717          	auipc	a4,0x1
    5790:	18473507          	fld	fa0,388(a4) # 6910 <STDIN_FD+0x10>
    static inline int isdigit(int c) { return c >= '0' && c <= '9'; }
    5794:	fd07861b          	addiw	a2,a5,-48
        s++;

    while (isdigit(*s))
    5798:	46a5                	li	a3,9
    579a:	f20007d3          	fmv.d.x	fa5,zero
    579e:	8732                	mv	a4,a2
    57a0:	02c6e363          	bltu	a3,a2,57c6 <strtod+0x64>
    57a4:	00001797          	auipc	a5,0x1
    57a8:	1747b687          	fld	fa3,372(a5) # 6918 <STDIN_FD+0x18>
    57ac:	4625                	li	a2,9
    57ae:	00154783          	lbu	a5,1(a0)
    {
        val = val * 10.0 + (*s - '0');
    57b2:	d2070753          	fcvt.d.w	fa4,a4
        s++;
    57b6:	0505                	addi	a0,a0,1
    57b8:	fd07869b          	addiw	a3,a5,-48
        val = val * 10.0 + (*s - '0');
    57bc:	72d7f7c3          	fmadd.d	fa5,fa5,fa3,fa4
    57c0:	8736                	mv	a4,a3
    while (isdigit(*s))
    57c2:	fed676e3          	bgeu	a2,a3,57ae <strtod+0x4c>
    }
    if (*s == '.')
    57c6:	02e00713          	li	a4,46
    57ca:	00e78963          	beq	a5,a4,57dc <strtod+0x7a>
            val += (*s - '0') * factor;
            s++;
        }
    }

    if (endptr)
    57ce:	c191                	beqz	a1,57d2 <strtod+0x70>
        *endptr = (char *)s;
    57d0:	e188                	sd	a0,0(a1)
    return val * sign;
}
    57d2:	12a7f553          	fmul.d	fa0,fa5,fa0
    57d6:	8082                	ret
        s++;
    57d8:	0505                	addi	a0,a0,1
    57da:	b779                	j	5768 <strtod+0x6>
        while (isdigit(*s))
    57dc:	00154703          	lbu	a4,1(a0)
    57e0:	46a5                	li	a3,9
        s++;
    57e2:	0505                	addi	a0,a0,1
    57e4:	fd07071b          	addiw	a4,a4,-48
    57e8:	87ba                	mv	a5,a4
        while (isdigit(*s))
    57ea:	fee6e2e3          	bltu	a3,a4,57ce <strtod+0x6c>
        double factor = 1.0;
    57ee:	00001717          	auipc	a4,0x1
    57f2:	12273707          	fld	fa4,290(a4) # 6910 <STDIN_FD+0x10>
    57f6:	00001717          	auipc	a4,0x1
    57fa:	13a73607          	fld	fa2,314(a4) # 6930 <STDIN_FD+0x30>
            factor *= 0.1;
    57fe:	12c77753          	fmul.d	fa4,fa4,fa2
        while (isdigit(*s))
    5802:	00154703          	lbu	a4,1(a0)
            val += (*s - '0') * factor;
    5806:	d20786d3          	fcvt.d.w	fa3,a5
            s++;
    580a:	0505                	addi	a0,a0,1
    580c:	fd07071b          	addiw	a4,a4,-48
    5810:	87ba                	mv	a5,a4
            val += (*s - '0') * factor;
    5812:	7ae6f7c3          	fmadd.d	fa5,fa3,fa4,fa5
        while (isdigit(*s))
    5816:	fee6f4e3          	bgeu	a3,a4,57fe <strtod+0x9c>
    581a:	bf55                	j	57ce <strtod+0x6c>
    while (isdigit(*s))
    581c:	00154783          	lbu	a5,1(a0)
    5820:	00001717          	auipc	a4,0x1
    5824:	0e873507          	fld	fa0,232(a4) # 6908 <STDIN_FD+0x8>
        s++;
    5828:	0505                	addi	a0,a0,1
    582a:	b7ad                	j	5794 <strtod+0x32>
    while (isdigit(*s))
    582c:	00154783          	lbu	a5,1(a0)
    5830:	00001717          	auipc	a4,0x1
    5834:	0e073507          	fld	fa0,224(a4) # 6910 <STDIN_FD+0x10>
        s++;
    5838:	0505                	addi	a0,a0,1
    583a:	bfa9                	j	5794 <strtod+0x32>

000000000000583c <atof>:

double atof(const char *nptr) { return strtod(nptr, NULL); }
    583c:	4581                	li	a1,0
    583e:	b715                	j	5762 <strtod>

0000000000005840 <strtof>:
float strtof(const char *nptr, char **endptr) { return (float)strtod(nptr, endptr); }
    5840:	1141                	addi	sp,sp,-16
    5842:	e406                	sd	ra,8(sp)
    5844:	f1fff0ef          	jal	5762 <strtod>
    5848:	60a2                	ld	ra,8(sp)
    584a:	40157553          	fcvt.s.d	fa0,fa0
    584e:	0141                	addi	sp,sp,16
    5850:	8082                	ret

0000000000005852 <qsort>:
    }
}

void qsort(void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *))
{
    if (nmemb < 2 || size == 0)
    5852:	4785                	li	a5,1
    5854:	0cb7fd63          	bgeu	a5,a1,592e <qsort+0xdc>
{
    5858:	715d                	addi	sp,sp,-80
    585a:	f44e                	sd	s3,40(sp)
    585c:	e486                	sd	ra,72(sp)
    585e:	89b2                	mv	s3,a2
    if (nmemb < 2 || size == 0)
    5860:	c279                	beqz	a2,5926 <qsort+0xd4>
    5862:	e85a                	sd	s6,16(sp)
    5864:	8b2e                	mv	s6,a1
        return;

    char *base_ptr = (char *)base;
    char *pivot = base_ptr + (nmemb - 1) * size;
    5866:	1b7d                	addi	s6,s6,-1
    5868:	fc26                	sd	s1,56(sp)
    586a:	033b04b3          	mul	s1,s6,s3
    586e:	ec56                	sd	s5,24(sp)
    5870:	8aaa                	mv	s5,a0
    5872:	f052                	sd	s4,32(sp)
    5874:	e45e                	sd	s7,8(sp)
    5876:	e0a2                	sd	s0,64(sp)
    5878:	f84a                	sd	s2,48(sp)
    587a:	8a36                	mv	s4,a3
    if (nmemb < 2 || size == 0)
    587c:	4b85                	li	s7,1
    char *pivot = base_ptr + (nmemb - 1) * size;
    587e:	94d6                	add	s1,s1,s5
    char *i = base_ptr;
    char *j = base_ptr;

    /* Partition */
    for (; j < pivot; j += size)
    5880:	069af763          	bgeu	s5,s1,58ee <qsort+0x9c>
    char *j = base_ptr;
    5884:	8956                	mv	s2,s5
    char *i = base_ptr;
    5886:	8456                	mv	s0,s5
    5888:	a021                	j	5890 <qsort+0x3e>
    for (; j < pivot; j += size)
    588a:	994e                	add	s2,s2,s3
    588c:	00997f63          	bgeu	s2,s1,58aa <qsort+0x58>
    {
        if (compar(j, pivot) < 0)
    5890:	85a6                	mv	a1,s1
    5892:	854a                	mv	a0,s2
    5894:	9a02                	jalr	s4
    5896:	fe055ae3          	bgez	a0,588a <qsort+0x38>
        {
            if (i != j)
    589a:	05241d63          	bne	s0,s2,58f4 <qsort+0xa2>
    589e:	01390633          	add	a2,s2,s3
                swap_bytes(i, j, size);
            i += size;
    58a2:	8432                	mv	s0,a2
    for (; j < pivot; j += size)
    58a4:	994e                	add	s2,s2,s3
    58a6:	fe9965e3          	bltu	s2,s1,5890 <qsort+0x3e>
        }
    }
    swap_bytes(i, pivot, size);

    /* Recurse */
    size_t left_count = (i - base_ptr) / size;
    58aa:	415405b3          	sub	a1,s0,s5
    58ae:	0335d5b3          	divu	a1,a1,s3
    qsort(base, left_count, size, compar);
    qsort(i + size, nmemb - left_count - 1, size, compar);
    58b2:	40bb0b33          	sub	s6,s6,a1
    while (size--)
    58b6:	013406b3          	add	a3,s0,s3
        *a++ = *b;
    58ba:	0004c703          	lbu	a4,0(s1)
        temp = *a;
    58be:	00044783          	lbu	a5,0(s0)
        *b++ = temp;
    58c2:	0485                	addi	s1,s1,1
        *a++ = *b;
    58c4:	0405                	addi	s0,s0,1
    58c6:	fee40fa3          	sb	a4,-1(s0)
        *b++ = temp;
    58ca:	fef48fa3          	sb	a5,-1(s1)
    while (size--)
    58ce:	fed416e3          	bne	s0,a3,58ba <qsort+0x68>
    qsort(base, left_count, size, compar);
    58d2:	86d2                	mv	a3,s4
    58d4:	864e                	mv	a2,s3
    58d6:	8556                	mv	a0,s5
    58d8:	f7bff0ef          	jal	5852 <qsort>
    if (nmemb < 2 || size == 0)
    58dc:	036bfe63          	bgeu	s7,s6,5918 <qsort+0xc6>
    char *pivot = base_ptr + (nmemb - 1) * size;
    58e0:	1b7d                	addi	s6,s6,-1
    58e2:	033b04b3          	mul	s1,s6,s3
    58e6:	8aa2                	mv	s5,s0
    58e8:	94d6                	add	s1,s1,s5
    for (; j < pivot; j += size)
    58ea:	f89aede3          	bltu	s5,s1,5884 <qsort+0x32>
    char *i = base_ptr;
    58ee:	8456                	mv	s0,s5
    for (; j < pivot; j += size)
    58f0:	4581                	li	a1,0
    58f2:	b7d1                	j	58b6 <qsort+0x64>
    58f4:	01340633          	add	a2,s0,s3
            if (i != j)
    58f8:	874a                	mv	a4,s2
    58fa:	87a2                	mv	a5,s0
        *a++ = *b;
    58fc:	00074683          	lbu	a3,0(a4)
        temp = *a;
    5900:	0007c803          	lbu	a6,0(a5)
        *b++ = temp;
    5904:	0705                	addi	a4,a4,1
        *a++ = *b;
    5906:	0785                	addi	a5,a5,1
    5908:	fed78fa3          	sb	a3,-1(a5)
        *b++ = temp;
    590c:	ff070fa3          	sb	a6,-1(a4)
    while (size--)
    5910:	fec796e3          	bne	a5,a2,58fc <qsort+0xaa>
            i += size;
    5914:	8432                	mv	s0,a2
    5916:	b779                	j	58a4 <qsort+0x52>
    5918:	6406                	ld	s0,64(sp)
    591a:	74e2                	ld	s1,56(sp)
    591c:	7942                	ld	s2,48(sp)
    591e:	7a02                	ld	s4,32(sp)
    5920:	6ae2                	ld	s5,24(sp)
    5922:	6b42                	ld	s6,16(sp)
    5924:	6ba2                	ld	s7,8(sp)
}
    5926:	60a6                	ld	ra,72(sp)
    5928:	79a2                	ld	s3,40(sp)
    592a:	6161                	addi	sp,sp,80
    592c:	8082                	ret
    592e:	8082                	ret

0000000000005930 <bsearch>:

void *bsearch(const void *key, const void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *))
{
    5930:	715d                	addi	sp,sp,-80
    5932:	e486                	sd	ra,72(sp)
    5934:	fc26                	sd	s1,56(sp)
    size_t l = 0, u = nmemb;
    while (l < u)
    5936:	c629                	beqz	a2,5980 <bsearch+0x50>
    5938:	f84a                	sd	s2,48(sp)
    593a:	f44e                	sd	s3,40(sp)
    593c:	f052                	sd	s4,32(sp)
    593e:	ec56                	sd	s5,24(sp)
    5940:	e85a                	sd	s6,16(sp)
    5942:	e45e                	sd	s7,8(sp)
    5944:	e0a2                	sd	s0,64(sp)
    5946:	8932                	mv	s2,a2
    5948:	8a2a                	mv	s4,a0
    594a:	8aae                	mv	s5,a1
    594c:	8b36                	mv	s6,a3
    594e:	8bba                	mv	s7,a4
    size_t l = 0, u = nmemb;
    5950:	4981                	li	s3,0
    {
        size_t idx = (l + u) / 2;
    5952:	01298433          	add	s0,s3,s2
    5956:	8005                	srli	s0,s0,0x1
        const void *p = (void *)((const char *)base + (idx * size));
    5958:	036404b3          	mul	s1,s0,s6
        int cmp = compar(key, p);
    595c:	8552                	mv	a0,s4
        const void *p = (void *)((const char *)base + (idx * size));
    595e:	94d6                	add	s1,s1,s5
        int cmp = compar(key, p);
    5960:	85a6                	mv	a1,s1
    5962:	9b82                	jalr	s7
        if (cmp < 0)
    5964:	02054463          	bltz	a0,598c <bsearch+0x5c>
            u = idx;
        else if (cmp > 0)
    5968:	c515                	beqz	a0,5994 <bsearch+0x64>
            l = idx + 1;
    596a:	00140993          	addi	s3,s0,1
    while (l < u)
    596e:	ff29e2e3          	bltu	s3,s2,5952 <bsearch+0x22>
    5972:	6406                	ld	s0,64(sp)
    5974:	7942                	ld	s2,48(sp)
    5976:	79a2                	ld	s3,40(sp)
    5978:	7a02                	ld	s4,32(sp)
    597a:	6ae2                	ld	s5,24(sp)
    597c:	6b42                	ld	s6,16(sp)
    597e:	6ba2                	ld	s7,8(sp)
        else
            return (void *)p;
    }
    return NULL;
}
    5980:	60a6                	ld	ra,72(sp)
    return NULL;
    5982:	4481                	li	s1,0
}
    5984:	8526                	mv	a0,s1
    5986:	74e2                	ld	s1,56(sp)
    5988:	6161                	addi	sp,sp,80
    598a:	8082                	ret
            u = idx;
    598c:	8922                	mv	s2,s0
    while (l < u)
    598e:	fd29e2e3          	bltu	s3,s2,5952 <bsearch+0x22>
    5992:	b7c5                	j	5972 <bsearch+0x42>
    5994:	6406                	ld	s0,64(sp)
}
    5996:	60a6                	ld	ra,72(sp)
    5998:	7942                	ld	s2,48(sp)
    599a:	79a2                	ld	s3,40(sp)
    599c:	7a02                	ld	s4,32(sp)
    599e:	6ae2                	ld	s5,24(sp)
    59a0:	6b42                	ld	s6,16(sp)
    59a2:	6ba2                	ld	s7,8(sp)
    59a4:	8526                	mv	a0,s1
    59a6:	74e2                	ld	s1,56(sp)
    59a8:	6161                	addi	sp,sp,80
    59aa:	8082                	ret

00000000000059ac <abs>:

/* Math & Mics */

int abs(int j) { return (j < 0) ? -j : j; }
    59ac:	41f5579b          	sraiw	a5,a0,0x1f
    59b0:	8d3d                	xor	a0,a0,a5
    59b2:	9d1d                	subw	a0,a0,a5
    59b4:	8082                	ret

00000000000059b6 <labs>:
long labs(long j) { return (j < 0) ? -j : j; }
    59b6:	43f55793          	srai	a5,a0,0x3f
    59ba:	8d3d                	xor	a0,a0,a5
    59bc:	8d1d                	sub	a0,a0,a5
    59be:	8082                	ret

00000000000059c0 <llabs>:
long long llabs(long long j) { return (j < 0) ? -j : j; }
    59c0:	43f55793          	srai	a5,a0,0x3f
    59c4:	8d3d                	xor	a0,a0,a5
    59c6:	8d1d                	sub	a0,a0,a5
    59c8:	8082                	ret

00000000000059ca <div>:

div_t div(int numer, int denom)
{
    div_t res = {numer / denom, numer % denom};
    59ca:	02b547bb          	divw	a5,a0,a1
{
    59ce:	1141                	addi	sp,sp,-16
    return res;
}
    59d0:	0141                	addi	sp,sp,16
    div_t res = {numer / denom, numer % denom};
    59d2:	02b5653b          	remw	a0,a0,a1
    return res;
    59d6:	1782                	slli	a5,a5,0x20
    59d8:	9381                	srli	a5,a5,0x20
    59da:	1502                	slli	a0,a0,0x20
}
    59dc:	8d5d                	or	a0,a0,a5
    59de:	8082                	ret

00000000000059e0 <ldiv>:
ldiv_t ldiv(long numer, long denom)
{
    59e0:	1141                	addi	sp,sp,-16
    59e2:	87aa                	mv	a5,a0
    ldiv_t res = {numer / denom, numer % denom};
    return res;
}
    59e4:	02b54533          	div	a0,a0,a1
    59e8:	0141                	addi	sp,sp,16
    59ea:	02b7e5b3          	rem	a1,a5,a1
    59ee:	8082                	ret

00000000000059f0 <lldiv>:
lldiv_t lldiv(long long numer, long long denom)
{
    59f0:	1141                	addi	sp,sp,-16
    59f2:	87aa                	mv	a5,a0
    lldiv_t res = {numer / denom, numer % denom};
    return res;
}
    59f4:	02b54533          	div	a0,a0,a1
    59f8:	0141                	addi	sp,sp,16
    59fa:	02b7e5b3          	rem	a1,a5,a1
    59fe:	8082                	ret

0000000000005a00 <rand>:

static unsigned long next = 1;
int rand(void)
{
    next = next * 1103515245 + 12345;
    5a00:	00003697          	auipc	a3,0x3
    5a04:	26068693          	addi	a3,a3,608 # 8c60 <next>
    5a08:	629c                	ld	a5,0(a3)
    5a0a:	41c65737          	lui	a4,0x41c65
    5a0e:	e6d70713          	addi	a4,a4,-403 # 41c64e6d <_ZSt4cerr+0x41c5c02d>
    5a12:	02e787b3          	mul	a5,a5,a4
    5a16:	670d                	lui	a4,0x3
    5a18:	03970713          	addi	a4,a4,57 # 3039 <stbsp_vsprintfcb+0xd57>
    5a1c:	97ba                	add	a5,a5,a4
    return (unsigned int)(next / 65536) % 32768;
    5a1e:	02179513          	slli	a0,a5,0x21
    next = next * 1103515245 + 12345;
    5a22:	e29c                	sd	a5,0(a3)
}
    5a24:	9145                	srli	a0,a0,0x31
    5a26:	8082                	ret

0000000000005a28 <srand>:
void srand(unsigned int seed) { next = seed; }
    5a28:	1502                	slli	a0,a0,0x20
    5a2a:	9101                	srli	a0,a0,0x20
    5a2c:	00003797          	auipc	a5,0x3
    5a30:	22a7ba23          	sd	a0,564(a5) # 8c60 <next>
    5a34:	8082                	ret

0000000000005a36 <mblen>:

/* Stub */
int mblen(const char *s, size_t n) { return (s && *s && n) ? 1 : 0; }
    5a36:	c901                	beqz	a0,5a46 <mblen+0x10>
    5a38:	00054783          	lbu	a5,0(a0)
    5a3c:	4501                	li	a0,0
    5a3e:	c789                	beqz	a5,5a48 <mblen+0x12>
    5a40:	00b03533          	snez	a0,a1
    5a44:	8082                	ret
    5a46:	4501                	li	a0,0
    5a48:	8082                	ret

0000000000005a4a <mbtowc>:
int mbtowc(wchar_t *pwc, const char *s, size_t n)
{
    5a4a:	87aa                	mv	a5,a0
    if (!s)
    5a4c:	cd81                	beqz	a1,5a64 <mbtowc+0x1a>
        return 0;
    if (n == 0)
        return -1;
    5a4e:	557d                	li	a0,-1
    if (n == 0)
    5a50:	ca19                	beqz	a2,5a66 <mbtowc+0x1c>
    if (pwc)
    5a52:	c781                	beqz	a5,5a5a <mbtowc+0x10>
        *pwc = (wchar_t)*s;
    5a54:	0005c703          	lbu	a4,0(a1)
    5a58:	c398                	sw	a4,0(a5)
    return (*s != 0);
    5a5a:	0005c503          	lbu	a0,0(a1)
    5a5e:	00a03533          	snez	a0,a0
    5a62:	8082                	ret
        return 0;
    5a64:	4501                	li	a0,0
}
    5a66:	8082                	ret

0000000000005a68 <wctomb>:
int wctomb(char *s, wchar_t wchar)
{
    if (!s)
    5a68:	c509                	beqz	a0,5a72 <wctomb+0xa>
        return 0;
    *s = (char)wchar;
    5a6a:	00b50023          	sb	a1,0(a0)
    return 1;
    5a6e:	4505                	li	a0,1
    5a70:	8082                	ret
        return 0;
    5a72:	4501                	li	a0,0
}
    5a74:	8082                	ret

0000000000005a76 <mbstowcs>:
size_t mbstowcs(wchar_t *dest, const char *src, size_t n)
{
    size_t i = 0;
    while (src[i] && i < n)
    5a76:	0005c703          	lbu	a4,0(a1)
    5a7a:	cb0d                	beqz	a4,5aac <mbstowcs+0x36>
    5a7c:	ca15                	beqz	a2,5ab0 <mbstowcs+0x3a>
    5a7e:	86aa                	mv	a3,a0
    size_t i = 0;
    5a80:	4781                	li	a5,0
    5a82:	a019                	j	5a88 <mbstowcs+0x12>
    while (src[i] && i < n)
    5a84:	02f60263          	beq	a2,a5,5aa8 <mbstowcs+0x32>
    {
        dest[i] = (wchar_t)src[i];
        i++;
    5a88:	0785                	addi	a5,a5,1
        dest[i] = (wchar_t)src[i];
    5a8a:	c298                	sw	a4,0(a3)
    while (src[i] && i < n)
    5a8c:	00f58733          	add	a4,a1,a5
    5a90:	00074703          	lbu	a4,0(a4)
    5a94:	0691                	addi	a3,a3,4
    5a96:	f77d                	bnez	a4,5a84 <mbstowcs+0xe>
    }
    if (i < n)
    5a98:	00c7f763          	bgeu	a5,a2,5aa6 <mbstowcs+0x30>
        dest[i] = 0;
    5a9c:	00279713          	slli	a4,a5,0x2
    5aa0:	953a                	add	a0,a0,a4
    5aa2:	00052023          	sw	zero,0(a0)
    size_t i = 0;
    5aa6:	863e                	mv	a2,a5
    5aa8:	8532                	mv	a0,a2
    5aaa:	8082                	ret
    5aac:	4781                	li	a5,0
    5aae:	b7ed                	j	5a98 <mbstowcs+0x22>
    5ab0:	4501                	li	a0,0
    return i;
}
    5ab2:	8082                	ret

0000000000005ab4 <wcstombs>:
size_t wcstombs(char *dest, const wchar_t *src, size_t n)
{
    size_t i = 0;
    while (src[i] && i < n)
    5ab4:	4198                	lw	a4,0(a1)
    5ab6:	c71d                	beqz	a4,5ae4 <wcstombs+0x30>
    5ab8:	ca05                	beqz	a2,5ae8 <wcstombs+0x34>
    5aba:	0591                	addi	a1,a1,4
    size_t i = 0;
    5abc:	4781                	li	a5,0
    5abe:	a019                	j	5ac4 <wcstombs+0x10>
    while (src[i] && i < n)
    5ac0:	02f60063          	beq	a2,a5,5ae0 <wcstombs+0x2c>
    {
        dest[i] = (char)src[i];
    5ac4:	00f506b3          	add	a3,a0,a5
    5ac8:	00e68023          	sb	a4,0(a3)
    while (src[i] && i < n)
    5acc:	4198                	lw	a4,0(a1)
        i++;
    5ace:	0785                	addi	a5,a5,1
    while (src[i] && i < n)
    5ad0:	0591                	addi	a1,a1,4
    5ad2:	f77d                	bnez	a4,5ac0 <wcstombs+0xc>
    }
    if (i < n)
    5ad4:	00c7f563          	bgeu	a5,a2,5ade <wcstombs+0x2a>
        dest[i] = 0;
    5ad8:	953e                	add	a0,a0,a5
    5ada:	00050023          	sb	zero,0(a0)
    size_t i = 0;
    5ade:	863e                	mv	a2,a5
    5ae0:	8532                	mv	a0,a2
    5ae2:	8082                	ret
    5ae4:	4781                	li	a5,0
    5ae6:	b7fd                	j	5ad4 <wcstombs+0x20>
    5ae8:	4501                	li	a0,0
    return i;
    5aea:	8082                	ret

0000000000005aec <memset>:

void *memset(void *dst, int c, size_t n)
{
    char *cdst = (char *)dst;
    for (size_t i = 0; i < n; i++)
        cdst[i] = (char)c;
    5aec:	0ff5f593          	zext.b	a1,a1
    5af0:	87aa                	mv	a5,a0
    5af2:	00a60733          	add	a4,a2,a0
    for (size_t i = 0; i < n; i++)
    5af6:	c611                	beqz	a2,5b02 <memset+0x16>
        cdst[i] = (char)c;
    5af8:	00b78023          	sb	a1,0(a5)
    for (size_t i = 0; i < n; i++)
    5afc:	0785                	addi	a5,a5,1
    5afe:	fee79de3          	bne	a5,a4,5af8 <memset+0xc>
    return dst;
}
    5b02:	8082                	ret

0000000000005b04 <memmove>:

void *memmove(void *vdst, const void *vsrc, size_t n)
{
    char *dst = (char *)vdst;
    const char *src = (const char *)vsrc;
    if (dst == src)
    5b04:	02b50d63          	beq	a0,a1,5b3e <memmove+0x3a>
        return vdst;

    if (src > dst)
    5b08:	00b57e63          	bgeu	a0,a1,5b24 <memmove+0x20>
    {
        while (n--)
    5b0c:	ca0d                	beqz	a2,5b3e <memmove+0x3a>
    5b0e:	962a                	add	a2,a2,a0
    char *dst = (char *)vdst;
    5b10:	87aa                	mv	a5,a0
            *dst++ = *src++;
    5b12:	0005c703          	lbu	a4,0(a1)
    5b16:	0785                	addi	a5,a5,1
    5b18:	0585                	addi	a1,a1,1
    5b1a:	fee78fa3          	sb	a4,-1(a5)
        while (n--)
    5b1e:	fec79ae3          	bne	a5,a2,5b12 <memmove+0xe>
    5b22:	8082                	ret
    }
    else
    {
        dst += n;
    5b24:	00c50733          	add	a4,a0,a2
        src += n;
    5b28:	00c587b3          	add	a5,a1,a2
        while (n-- > 0)
    5b2c:	ca09                	beqz	a2,5b3e <memmove+0x3a>
            *--dst = *--src;
    5b2e:	fff7c683          	lbu	a3,-1(a5)
    5b32:	17fd                	addi	a5,a5,-1
    5b34:	177d                	addi	a4,a4,-1
    5b36:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
    5b3a:	fef59ae3          	bne	a1,a5,5b2e <memmove+0x2a>
    }
    return vdst;
}
    5b3e:	8082                	ret

0000000000005b40 <memcpy>:

void *memcpy(void *vdst, const void *vsrc, size_t n)
{
    return memmove(vdst, vsrc, n);
    5b40:	b7d1                	j	5b04 <memmove>

0000000000005b42 <memcmp>:

int memcmp(const void *s1, const void *s2, size_t n)
{
    const unsigned char *p1 = (const unsigned char *)s1;
    const unsigned char *p2 = (const unsigned char *)s2;
    while (n--)
    5b42:	c205                	beqz	a2,5b62 <memcmp+0x20>
    5b44:	962a                	add	a2,a2,a0
    5b46:	a019                	j	5b4c <memcmp+0xa>
    5b48:	00c50d63          	beq	a0,a2,5b62 <memcmp+0x20>
    {
        if (*p1 != *p2)
    5b4c:	00054783          	lbu	a5,0(a0)
    5b50:	0005c703          	lbu	a4,0(a1)
            return *p1 - *p2;
        p1++;
    5b54:	0505                	addi	a0,a0,1
        p2++;
    5b56:	0585                	addi	a1,a1,1
        if (*p1 != *p2)
    5b58:	fee788e3          	beq	a5,a4,5b48 <memcmp+0x6>
            return *p1 - *p2;
    5b5c:	40e7853b          	subw	a0,a5,a4
    5b60:	8082                	ret
    }
    return 0;
    5b62:	4501                	li	a0,0
}
    5b64:	8082                	ret

0000000000005b66 <memchr>:

void *memchr(const void *s, int c, size_t n)
{
    const unsigned char *p = (const unsigned char *)s;
    while (n--)
    5b66:	ce09                	beqz	a2,5b80 <memchr+0x1a>
    {
        if (*p == (unsigned char)c)
    5b68:	0ff5f593          	zext.b	a1,a1
    5b6c:	962a                	add	a2,a2,a0
    5b6e:	a021                	j	5b76 <memchr+0x10>
            return (void *)p;
        p++;
    5b70:	0505                	addi	a0,a0,1
    while (n--)
    5b72:	00a60763          	beq	a2,a0,5b80 <memchr+0x1a>
        if (*p == (unsigned char)c)
    5b76:	00054783          	lbu	a5,0(a0)
    5b7a:	feb79be3          	bne	a5,a1,5b70 <memchr+0xa>
    }
    return NULL;
}
    5b7e:	8082                	ret
    return NULL;
    5b80:	4501                	li	a0,0
}
    5b82:	8082                	ret

0000000000005b84 <strlen>:
/* String Manipulation Functions  */

size_t strlen(const char *s)
{
    const char *p = s;
    while (*p)
    5b84:	00054783          	lbu	a5,0(a0)
    5b88:	cb89                	beqz	a5,5b9a <strlen+0x16>
    const char *p = s;
    5b8a:	87aa                	mv	a5,a0
    while (*p)
    5b8c:	0017c703          	lbu	a4,1(a5)
        p++;
    5b90:	0785                	addi	a5,a5,1
    while (*p)
    5b92:	ff6d                	bnez	a4,5b8c <strlen+0x8>
    return (size_t)(p - s);
    5b94:	40a78533          	sub	a0,a5,a0
    5b98:	8082                	ret
    while (*p)
    5b9a:	4501                	li	a0,0
}
    5b9c:	8082                	ret

0000000000005b9e <strcpy>:

char *strcpy(char *dst, const char *src)
{
    char *os = dst;
    while ((*dst++ = *src++) != 0)
    5b9e:	87aa                	mv	a5,a0
    5ba0:	0005c703          	lbu	a4,0(a1)
    5ba4:	0785                	addi	a5,a5,1
    5ba6:	0585                	addi	a1,a1,1
    5ba8:	fee78fa3          	sb	a4,-1(a5)
    5bac:	fb75                	bnez	a4,5ba0 <strcpy+0x2>
        ;
    return os;
}
    5bae:	8082                	ret

0000000000005bb0 <strncpy>:
char *strncpy(char *dst, const char *src, size_t n)
{
    char *os = dst;
    size_t i;

    for (i = 0; i < n && src[i] != '\0'; i++)
    5bb0:	4781                	li	a5,0
    5bb2:	e619                	bnez	a2,5bc0 <strncpy+0x10>
    5bb4:	8082                	ret
        dst[i] = src[i];
    5bb6:	00e68023          	sb	a4,0(a3)
    for (i = 0; i < n && src[i] != '\0'; i++)
    5bba:	0785                	addi	a5,a5,1
    5bbc:	02f60263          	beq	a2,a5,5be0 <strncpy+0x30>
    5bc0:	00f58733          	add	a4,a1,a5
    5bc4:	00074703          	lbu	a4,0(a4)
        dst[i] = src[i];
    5bc8:	00f506b3          	add	a3,a0,a5
    for (i = 0; i < n && src[i] != '\0'; i++)
    5bcc:	f76d                	bnez	a4,5bb6 <strncpy+0x6>

    for (; i < n; i++)
    5bce:	00c7f963          	bgeu	a5,a2,5be0 <strncpy+0x30>
    5bd2:	87b6                	mv	a5,a3
    5bd4:	962a                	add	a2,a2,a0
        dst[i] = '\0';
    5bd6:	00078023          	sb	zero,0(a5)
    for (; i < n; i++)
    5bda:	0785                	addi	a5,a5,1
    5bdc:	fec79de3          	bne	a5,a2,5bd6 <strncpy+0x26>

    return os;
}
    5be0:	8082                	ret

0000000000005be2 <strcat>:

char *strcat(char *dst, const char *src)
{
    char *os = dst;
    while (*dst)
    5be2:	00054783          	lbu	a5,0(a0)
    5be6:	cf91                	beqz	a5,5c02 <strcat+0x20>
    5be8:	87aa                	mv	a5,a0
    5bea:	0017c703          	lbu	a4,1(a5)
        dst++;
    5bee:	0785                	addi	a5,a5,1
    while (*dst)
    5bf0:	ff6d                	bnez	a4,5bea <strcat+0x8>
    while ((*dst++ = *src++) != 0)
    5bf2:	0005c703          	lbu	a4,0(a1)
    5bf6:	0785                	addi	a5,a5,1
    5bf8:	0585                	addi	a1,a1,1
    5bfa:	fee78fa3          	sb	a4,-1(a5)
    5bfe:	fb75                	bnez	a4,5bf2 <strcat+0x10>
        ;
    return os;
}
    5c00:	8082                	ret
    while ((*dst++ = *src++) != 0)
    5c02:	0005c703          	lbu	a4,0(a1)
    while (*dst)
    5c06:	87aa                	mv	a5,a0
    while ((*dst++ = *src++) != 0)
    5c08:	0785                	addi	a5,a5,1
    5c0a:	fee78fa3          	sb	a4,-1(a5)
    5c0e:	0585                	addi	a1,a1,1
    5c10:	f36d                	bnez	a4,5bf2 <strcat+0x10>
    5c12:	8082                	ret

0000000000005c14 <strncat>:
    while (*p)
    5c14:	00054783          	lbu	a5,0(a0)
    const char *p = s;
    5c18:	872a                	mv	a4,a0
    while (*p)
    5c1a:	c789                	beqz	a5,5c24 <strncat+0x10>
    5c1c:	00174783          	lbu	a5,1(a4)
        p++;
    5c20:	0705                	addi	a4,a4,1
    while (*p)
    5c22:	ffed                	bnez	a5,5c1c <strncat+0x8>
    size_t dest_len = strlen(dst);
    size_t i;

    dst += dest_len;

    for (i = 0; i < n && src[i] != '\0'; i++)
    5c24:	86ba                	mv	a3,a4
    5c26:	4781                	li	a5,0
    5c28:	88ba                	mv	a7,a4
    5c2a:	ea01                	bnez	a2,5c3a <strncat+0x26>
    5c2c:	a839                	j	5c4a <strncat+0x36>
        dst[i] = src[i];
    5c2e:	01068023          	sb	a6,0(a3)
    for (i = 0; i < n && src[i] != '\0'; i++)
    5c32:	00188693          	addi	a3,a7,1
    5c36:	00f60d63          	beq	a2,a5,5c50 <strncat+0x3c>
    5c3a:	00f58833          	add	a6,a1,a5
    5c3e:	00084803          	lbu	a6,0(a6)
    5c42:	0785                	addi	a5,a5,1
        dst[i] = src[i];
    5c44:	88b6                	mv	a7,a3
    for (i = 0; i < n && src[i] != '\0'; i++)
    5c46:	fe0814e3          	bnez	a6,5c2e <strncat+0x1a>

    dst[i] = '\0';
    5c4a:	00088023          	sb	zero,0(a7)

    return os;
}
    5c4e:	8082                	ret
    dst[i] = '\0';
    5c50:	00c708b3          	add	a7,a4,a2
    5c54:	00088023          	sb	zero,0(a7)
}
    5c58:	8082                	ret

0000000000005c5a <strcmp>:

int strcmp(const char *p, const char *q)
{
    while (*p && *p == *q)
    5c5a:	00054783          	lbu	a5,0(a0)
    5c5e:	e791                	bnez	a5,5c6a <strcmp+0x10>
    5c60:	a02d                	j	5c8a <strcmp+0x30>
    5c62:	00054783          	lbu	a5,0(a0)
    5c66:	cf89                	beqz	a5,5c80 <strcmp+0x26>
    5c68:	85b6                	mv	a1,a3
    5c6a:	0005c703          	lbu	a4,0(a1)
    {
        p++;
    5c6e:	0505                	addi	a0,a0,1
        q++;
    5c70:	00158693          	addi	a3,a1,1
    while (*p && *p == *q)
    5c74:	fef707e3          	beq	a4,a5,5c62 <strcmp+0x8>
    }
    return (int)((unsigned char)*p - (unsigned char)*q);
    5c78:	0007851b          	sext.w	a0,a5
}
    5c7c:	9d19                	subw	a0,a0,a4
    5c7e:	8082                	ret
    return (int)((unsigned char)*p - (unsigned char)*q);
    5c80:	0015c703          	lbu	a4,1(a1)
    5c84:	4501                	li	a0,0
}
    5c86:	9d19                	subw	a0,a0,a4
    5c88:	8082                	ret
    return (int)((unsigned char)*p - (unsigned char)*q);
    5c8a:	0005c703          	lbu	a4,0(a1)
    5c8e:	4501                	li	a0,0
    5c90:	b7f5                	j	5c7c <strcmp+0x22>

0000000000005c92 <strncmp>:

int strncmp(const char *s1, const char *s2, size_t n)
{
    if (n == 0)
    5c92:	ca0d                	beqz	a2,5cc4 <strncmp+0x32>
        return 0;

    while (n-- > 0 && *s1 && *s1 == *s2)
    5c94:	00054783          	lbu	a5,0(a0)
    5c98:	167d                	addi	a2,a2,-1
    5c9a:	00c506b3          	add	a3,a0,a2
    5c9e:	eb89                	bnez	a5,5cb0 <strncmp+0x1e>
    5ca0:	a80d                	j	5cd2 <strncmp+0x40>
    {
        if (n == 0 || *s1 == '\0')
    5ca2:	00d50d63          	beq	a0,a3,5cbc <strncmp+0x2a>
    while (n-- > 0 && *s1 && *s1 == *s2)
    5ca6:	00154783          	lbu	a5,1(a0)
            break;
        s1++;
    5caa:	0505                	addi	a0,a0,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    5cac:	cf91                	beqz	a5,5cc8 <strncmp+0x36>
    5cae:	85b2                	mv	a1,a2
    5cb0:	0005c703          	lbu	a4,0(a1)
        s2++;
    5cb4:	00158613          	addi	a2,a1,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    5cb8:	fef705e3          	beq	a4,a5,5ca2 <strncmp+0x10>
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    5cbc:	0007851b          	sext.w	a0,a5
    5cc0:	9d19                	subw	a0,a0,a4
    5cc2:	8082                	ret
        return 0;
    5cc4:	4501                	li	a0,0
}
    5cc6:	8082                	ret
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    5cc8:	0015c703          	lbu	a4,1(a1)
    5ccc:	4501                	li	a0,0
    5cce:	9d19                	subw	a0,a0,a4
    5cd0:	8082                	ret
    5cd2:	0005c703          	lbu	a4,0(a1)
    5cd6:	4501                	li	a0,0
    5cd8:	b7e5                	j	5cc0 <strncmp+0x2e>

0000000000005cda <strchr>:

char *strchr(const char *s, int c)
{
    while (*s != (char)c)
    5cda:	0ff5f593          	zext.b	a1,a1
    5cde:	a019                	j	5ce4 <strchr+0xa>
    {
        if (!*s++)
    5ce0:	0505                	addi	a0,a0,1
    5ce2:	c791                	beqz	a5,5cee <strchr+0x14>
    while (*s != (char)c)
    5ce4:	00054783          	lbu	a5,0(a0)
    5ce8:	feb79ce3          	bne	a5,a1,5ce0 <strchr+0x6>
    5cec:	8082                	ret
            return NULL;
    5cee:	4501                	li	a0,0
    }
    return (char *)s;
}
    5cf0:	8082                	ret

0000000000005cf2 <strrchr>:

char *strrchr(const char *s, int c)
{
    5cf2:	87aa                	mv	a5,a0
    const char *last = NULL;
    do
    {
        if (*s == (char)c)
    5cf4:	0ff5f593          	zext.b	a1,a1
    const char *last = NULL;
    5cf8:	4501                	li	a0,0
        if (*s == (char)c)
    5cfa:	0007c703          	lbu	a4,0(a5)
    5cfe:	00e59363          	bne	a1,a4,5d04 <strrchr+0x12>
            last = s;
    5d02:	853e                	mv	a0,a5
    } while (*s++);
    5d04:	0785                	addi	a5,a5,1
    5d06:	fb75                	bnez	a4,5cfa <strrchr+0x8>

    return (char *)last;
}
    5d08:	8082                	ret

0000000000005d0a <strstr>:
    while (*p)
    5d0a:	0005c883          	lbu	a7,0(a1)
    5d0e:	04088a63          	beqz	a7,5d62 <strstr+0x58>
    const char *p = s;
    5d12:	87ae                	mv	a5,a1
    while (*p)
    5d14:	0017c703          	lbu	a4,1(a5)
        p++;
    5d18:	0785                	addi	a5,a5,1
    while (*p)
    5d1a:	ff6d                	bnez	a4,5d14 <strstr+0xa>
    return (size_t)(p - s);
    5d1c:	40b78833          	sub	a6,a5,a1


char *strstr(const char *haystack, const char *needle)
{
    size_t n_len = strlen(needle);
    if (n_len == 0)
    5d20:	04b78163          	beq	a5,a1,5d62 <strstr+0x58>
        return (char *)haystack;

    for (; *haystack; haystack++)
    5d24:	00054783          	lbu	a5,0(a0)
    5d28:	cf85                	beqz	a5,5d60 <strstr+0x56>
    5d2a:	187d                	addi	a6,a6,-1
    5d2c:	982a                	add	a6,a6,a0
    {
        if (*haystack != *needle)
    5d2e:	02f89463          	bne	a7,a5,5d56 <strstr+0x4c>
    while (n-- > 0 && *s1 && *s1 == *s2)
    5d32:	00054703          	lbu	a4,0(a0)
    5d36:	8646                	mv	a2,a7
    5d38:	86ae                	mv	a3,a1
    5d3a:	87aa                	mv	a5,a0
    5d3c:	eb11                	bnez	a4,5d50 <strstr+0x46>
    5d3e:	a821                	j	5d56 <strstr+0x4c>
        if (n == 0 || *s1 == '\0')
    5d40:	03078163          	beq	a5,a6,5d62 <strstr+0x58>
    while (n-- > 0 && *s1 && *s1 == *s2)
    5d44:	0017c703          	lbu	a4,1(a5)
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
    5d48:	0006c603          	lbu	a2,0(a3)
        s1++;
    5d4c:	0785                	addi	a5,a5,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    5d4e:	cb19                	beqz	a4,5d64 <strstr+0x5a>
        s2++;
    5d50:	0685                	addi	a3,a3,1
    while (n-- > 0 && *s1 && *s1 == *s2)
    5d52:	fee607e3          	beq	a2,a4,5d40 <strstr+0x36>
    for (; *haystack; haystack++)
    5d56:	00154783          	lbu	a5,1(a0)
    5d5a:	0805                	addi	a6,a6,1
    5d5c:	0505                	addi	a0,a0,1
    5d5e:	fbe1                	bnez	a5,5d2e <strstr+0x24>
            continue;

        if (strncmp(haystack, needle, n_len) == 0)
            return (char *)haystack;
    }
    return NULL;
    5d60:	4501                	li	a0,0
}
    5d62:	8082                	ret
        if (strncmp(haystack, needle, n_len) == 0)
    5d64:	de7d                	beqz	a2,5d62 <strstr+0x58>
    for (; *haystack; haystack++)
    5d66:	00154783          	lbu	a5,1(a0)
    5d6a:	0805                	addi	a6,a6,1
    5d6c:	0505                	addi	a0,a0,1
    5d6e:	f3e1                	bnez	a5,5d2e <strstr+0x24>
    5d70:	bfc5                	j	5d60 <strstr+0x56>

0000000000005d72 <strdup>:

char *strdup(const char *s)
{
    5d72:	1101                	addi	sp,sp,-32
    5d74:	e426                	sd	s1,8(sp)
    5d76:	ec06                	sd	ra,24(sp)
    5d78:	e822                	sd	s0,16(sp)
    while (*p)
    5d7a:	00054783          	lbu	a5,0(a0)
{
    5d7e:	84aa                	mv	s1,a0
    while (*p)
    5d80:	cb8d                	beqz	a5,5db2 <strdup+0x40>
    const char *p = s;
    5d82:	862a                	mv	a2,a0
    while (*p)
    5d84:	00164783          	lbu	a5,1(a2)
        p++;
    5d88:	0605                	addi	a2,a2,1
    while (*p)
    5d8a:	ffed                	bnez	a5,5d84 <strdup+0x12>
    return (size_t)(p - s);
    5d8c:	8e05                	sub	a2,a2,s1
    size_t len = strlen(s) + 1;
    5d8e:	00160413          	addi	s0,a2,1
    char *new_str = (char *)malloc(len);
    5d92:	8522                	mv	a0,s0
    5d94:	f4eff0ef          	jal	54e2 <malloc>
    if (new_str == NULL)
    5d98:	c901                	beqz	a0,5da8 <strdup+0x36>
    return memmove(vdst, vsrc, n);
    5d9a:	8622                	mv	a2,s0
        return NULL;

    return (char *)memcpy(new_str, s, len);
}
    5d9c:	6442                	ld	s0,16(sp)
    5d9e:	60e2                	ld	ra,24(sp)
    return memmove(vdst, vsrc, n);
    5da0:	85a6                	mv	a1,s1
}
    5da2:	64a2                	ld	s1,8(sp)
    5da4:	6105                	addi	sp,sp,32
    return memmove(vdst, vsrc, n);
    5da6:	bbb9                	j	5b04 <memmove>
}
    5da8:	60e2                	ld	ra,24(sp)
    5daa:	6442                	ld	s0,16(sp)
    5dac:	64a2                	ld	s1,8(sp)
    5dae:	6105                	addi	sp,sp,32
    5db0:	8082                	ret
    while (*p)
    5db2:	4405                	li	s0,1
    5db4:	bff9                	j	5d92 <strdup+0x20>

0000000000005db6 <strlcpy>:
    5db6:	0005c783          	lbu	a5,0(a1)

size_t strlcpy(char *dst, const char *src, size_t size)
{
    5dba:	1101                	addi	sp,sp,-32
    5dbc:	ec06                	sd	ra,24(sp)
    5dbe:	e822                	sd	s0,16(sp)
    5dc0:	86b2                	mv	a3,a2
    while (*p)
    5dc2:	cf8d                	beqz	a5,5dfc <strlcpy+0x46>
    const char *p = s;
    5dc4:	87ae                	mv	a5,a1
    while (*p)
    5dc6:	0017c703          	lbu	a4,1(a5)
        p++;
    5dca:	0785                	addi	a5,a5,1
    while (*p)
    5dcc:	ff6d                	bnez	a4,5dc6 <strlcpy+0x10>
    return (size_t)(p - s);
    5dce:	40b78433          	sub	s0,a5,a1
    size_t src_len = strlen(src);

    if (size > 0)
    5dd2:	c285                	beqz	a3,5df2 <strlcpy+0x3c>
    5dd4:	e426                	sd	s1,8(sp)
    {
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    5dd6:	fff68613          	addi	a2,a3,-1
        memcpy(dst, src, copy_len);
        dst[copy_len] = '\0';
    5dda:	00c504b3          	add	s1,a0,a2
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    5dde:	00d47563          	bgeu	s0,a3,5de8 <strlcpy+0x32>
        dst[copy_len] = '\0';
    5de2:	008504b3          	add	s1,a0,s0
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    5de6:	8622                	mv	a2,s0
    return memmove(vdst, vsrc, n);
    5de8:	d1dff0ef          	jal	5b04 <memmove>
        dst[copy_len] = '\0';
    5dec:	00048023          	sb	zero,0(s1)
    }

    return src_len;
    5df0:	64a2                	ld	s1,8(sp)
}
    5df2:	60e2                	ld	ra,24(sp)
    5df4:	8522                	mv	a0,s0
    5df6:	6442                	ld	s0,16(sp)
    5df8:	6105                	addi	sp,sp,32
    5dfa:	8082                	ret
    if (size > 0)
    5dfc:	e219                	bnez	a2,5e02 <strlcpy+0x4c>
    return (size_t)(p - s);
    5dfe:	4401                	li	s0,0
    5e00:	bfcd                	j	5df2 <strlcpy+0x3c>
    5e02:	e426                	sd	s1,8(sp)
    5e04:	4401                	li	s0,0
    if (size > 0)
    5e06:	84aa                	mv	s1,a0
        size_t copy_len = (src_len >= size) ? size - 1 : src_len;
    5e08:	4601                	li	a2,0
    5e0a:	bff9                	j	5de8 <strlcpy+0x32>

0000000000005e0c <strlcat>:
    while (*p)
    5e0c:	0005c783          	lbu	a5,0(a1)

size_t strlcat(char *dst, const char *src, size_t size)
{
    5e10:	7179                	addi	sp,sp,-48
    5e12:	e84a                	sd	s2,16(sp)
    5e14:	f406                	sd	ra,40(sp)
    5e16:	f022                	sd	s0,32(sp)
    5e18:	ec26                	sd	s1,24(sp)
    5e1a:	892a                	mv	s2,a0
    while (*p)
    5e1c:	c7b5                	beqz	a5,5e88 <strlcat+0x7c>
    const char *p = s;
    5e1e:	87ae                	mv	a5,a1
    while (*p)
    5e20:	0017c703          	lbu	a4,1(a5)
        p++;
    5e24:	0785                	addi	a5,a5,1
    while (*p)
    5e26:	ff6d                	bnez	a4,5e20 <strlcat+0x14>
    return (size_t)(p - s);
    5e28:	40b784b3          	sub	s1,a5,a1
    size_t dst_len = 0;
    5e2c:	4401                	li	s0,0
    size_t src_len = strlen(src);

    while (dst_len < size && dst[dst_len] != '\0')
    5e2e:	e609                	bnez	a2,5e38 <strlcat+0x2c>
    5e30:	a0a1                	j	5e78 <strlcat+0x6c>
        dst_len++;
    5e32:	0405                	addi	s0,s0,1
    while (dst_len < size && dst[dst_len] != '\0')
    5e34:	04860263          	beq	a2,s0,5e78 <strlcat+0x6c>
    5e38:	00890533          	add	a0,s2,s0
    5e3c:	00054783          	lbu	a5,0(a0)
    5e40:	fbed                	bnez	a5,5e32 <strlcat+0x26>

    if (dst_len == size)
    5e42:	02860b63          	beq	a2,s0,5e78 <strlcat+0x6c>
    5e46:	e44e                	sd	s3,8(sp)
        return size + src_len;

    size_t space_left = size - dst_len;
    5e48:	408607b3          	sub	a5,a2,s0
    size_t copy_len = (src_len >= space_left) ? space_left - 1 : src_len;
    5e4c:	89a6                	mv	s3,s1
    5e4e:	02f4f263          	bgeu	s1,a5,5e72 <strlcat+0x66>

    memcpy(dst + dst_len, src, copy_len);
    dst[dst_len + copy_len] = '\0';
    5e52:	994e                	add	s2,s2,s3
    5e54:	9922                	add	s2,s2,s0
    return memmove(vdst, vsrc, n);
    5e56:	864e                	mv	a2,s3
    5e58:	cadff0ef          	jal	5b04 <memmove>
    dst[dst_len + copy_len] = '\0';
    5e5c:	00090023          	sb	zero,0(s2) # 1000 <main+0xec>

    return dst_len + src_len;
    5e60:	00940533          	add	a0,s0,s1
}
    5e64:	70a2                	ld	ra,40(sp)
    5e66:	7402                	ld	s0,32(sp)
    return dst_len + src_len;
    5e68:	69a2                	ld	s3,8(sp)
}
    5e6a:	64e2                	ld	s1,24(sp)
    5e6c:	6942                	ld	s2,16(sp)
    5e6e:	6145                	addi	sp,sp,48
    5e70:	8082                	ret
    size_t copy_len = (src_len >= space_left) ? space_left - 1 : src_len;
    5e72:	fff78993          	addi	s3,a5,-1
    5e76:	bff1                	j	5e52 <strlcat+0x46>
}
    5e78:	70a2                	ld	ra,40(sp)
    5e7a:	7402                	ld	s0,32(sp)
    5e7c:	6942                	ld	s2,16(sp)
        return size + src_len;
    5e7e:	00960533          	add	a0,a2,s1
}
    5e82:	64e2                	ld	s1,24(sp)
    5e84:	6145                	addi	sp,sp,48
    5e86:	8082                	ret
    while (*p)
    5e88:	4481                	li	s1,0
    5e8a:	b74d                	j	5e2c <strlcat+0x20>

0000000000005e8c <strspn>:
size_t strspn(const char *s, const char *accept)
{
    const char *p = s;
    const char *a;

    while (*p)
    5e8c:	00054683          	lbu	a3,0(a0)
    5e90:	c695                	beqz	a3,5ebc <strspn+0x30>
    {
        for (a = accept; *a; a++)
    5e92:	0005c803          	lbu	a6,0(a1)
    5e96:	862a                	mv	a2,a0
    5e98:	00080f63          	beqz	a6,5eb6 <strspn+0x2a>
    5e9c:	87ae                	mv	a5,a1
    5e9e:	8742                	mv	a4,a6
    5ea0:	a021                	j	5ea8 <strspn+0x1c>
    5ea2:	0007c703          	lbu	a4,0(a5)
    5ea6:	cb01                	beqz	a4,5eb6 <strspn+0x2a>
    5ea8:	0785                	addi	a5,a5,1
        {
            if (*p == *a)
    5eaa:	fee69ce3          	bne	a3,a4,5ea2 <strspn+0x16>
    while (*p)
    5eae:	00164683          	lbu	a3,1(a2)
                break;
        }
        if (*a == '\0')
            return (size_t)(p - s);
        p++;
    5eb2:	0605                	addi	a2,a2,1
    while (*p)
    5eb4:	f6e5                	bnez	a3,5e9c <strspn+0x10>
    }
    return (size_t)(p - s);
    5eb6:	40a60533          	sub	a0,a2,a0
    5eba:	8082                	ret
    while (*p)
    5ebc:	4501                	li	a0,0
}
    5ebe:	8082                	ret

0000000000005ec0 <strcspn>:
size_t strcspn(const char *s, const char *reject)
{
    const char *p = s;
    const char *r;

    while (*p)
    5ec0:	00054683          	lbu	a3,0(a0)
    5ec4:	ce85                	beqz	a3,5efc <strcspn+0x3c>
    {
        for (r = reject; *r; r++)
    5ec6:	0005c803          	lbu	a6,0(a1)
    const char *p = s;
    5eca:	862a                	mv	a2,a0
        for (r = reject; *r; r++)
    5ecc:	02080363          	beqz	a6,5ef2 <strcspn+0x32>
    5ed0:	87ae                	mv	a5,a1
    5ed2:	8742                	mv	a4,a6
    5ed4:	a021                	j	5edc <strcspn+0x1c>
    5ed6:	0007c703          	lbu	a4,0(a5)
    5eda:	c719                	beqz	a4,5ee8 <strcspn+0x28>
    5edc:	0785                	addi	a5,a5,1
        {
            if (*p == *r)
    5ede:	fed71ce3          	bne	a4,a3,5ed6 <strcspn+0x16>
                return (size_t)(p - s);
        }
        p++;
    }
    return (size_t)(p - s);
    5ee2:	40a60533          	sub	a0,a2,a0
    5ee6:	8082                	ret
    while (*p)
    5ee8:	00164683          	lbu	a3,1(a2)
        p++;
    5eec:	0605                	addi	a2,a2,1
    while (*p)
    5eee:	f2ed                	bnez	a3,5ed0 <strcspn+0x10>
    5ef0:	bfcd                	j	5ee2 <strcspn+0x22>
    5ef2:	00164683          	lbu	a3,1(a2)
        p++;
    5ef6:	0605                	addi	a2,a2,1
    while (*p)
    5ef8:	feed                	bnez	a3,5ef2 <strcspn+0x32>
    5efa:	b7e5                	j	5ee2 <strcspn+0x22>
    5efc:	4501                	li	a0,0
}
    5efe:	8082                	ret

0000000000005f00 <strpbrk>:

char *strpbrk(const char *s, const char *accept)
{
    const char *a;
    while (*s)
    5f00:	00054683          	lbu	a3,0(a0)
    5f04:	c295                	beqz	a3,5f28 <strpbrk+0x28>
    {
        for (a = accept; *a; a++)
    5f06:	0005c603          	lbu	a2,0(a1)
    5f0a:	c20d                	beqz	a2,5f2c <strpbrk+0x2c>
    5f0c:	87ae                	mv	a5,a1
    5f0e:	8732                	mv	a4,a2
    5f10:	a021                	j	5f18 <strpbrk+0x18>
    5f12:	0007c703          	lbu	a4,0(a5)
    5f16:	c709                	beqz	a4,5f20 <strpbrk+0x20>
    5f18:	0785                	addi	a5,a5,1
        {
            if (*s == *a)
    5f1a:	fed71ce3          	bne	a4,a3,5f12 <strpbrk+0x12>
                return (char *)s;
        }
        s++;
    }
    return NULL;
}
    5f1e:	8082                	ret
    while (*s)
    5f20:	00154683          	lbu	a3,1(a0)
        s++;
    5f24:	0505                	addi	a0,a0,1
    while (*s)
    5f26:	f2fd                	bnez	a3,5f0c <strpbrk+0xc>
    return NULL;
    5f28:	4501                	li	a0,0
}
    5f2a:	8082                	ret
    while (*s)
    5f2c:	00154683          	lbu	a3,1(a0)
        s++;
    5f30:	0505                	addi	a0,a0,1
    while (*s)
    5f32:	feed                	bnez	a3,5f2c <strpbrk+0x2c>
    5f34:	bfd5                	j	5f28 <strpbrk+0x28>

0000000000005f36 <strtok>:
char *strtok(char *str, const char *delim)
{
    static char *olds;
    char *token;

    if (str == NULL)
    5f36:	00003897          	auipc	a7,0x3
    5f3a:	ef288893          	addi	a7,a7,-270 # 8e28 <olds.0>
    5f3e:	cd25                	beqz	a0,5fb6 <strtok+0x80>
    while (*p)
    5f40:	00054683          	lbu	a3,0(a0)
    5f44:	c295                	beqz	a3,5f68 <strtok+0x32>
        for (a = accept; *a; a++)
    5f46:	0005c803          	lbu	a6,0(a1)
    5f4a:	02080463          	beqz	a6,5f72 <strtok+0x3c>
    5f4e:	87ae                	mv	a5,a1
    5f50:	8742                	mv	a4,a6
    5f52:	a021                	j	5f5a <strtok+0x24>
    5f54:	0007c703          	lbu	a4,0(a5)
    5f58:	cf09                	beqz	a4,5f72 <strtok+0x3c>
    5f5a:	0785                	addi	a5,a5,1
            if (*p == *a)
    5f5c:	fee69ce3          	bne	a3,a4,5f54 <strtok+0x1e>
    while (*p)
    5f60:	00154683          	lbu	a3,1(a0)
        p++;
    5f64:	0505                	addi	a0,a0,1
    while (*p)
    5f66:	f6e5                	bnez	a3,5f4e <strtok+0x18>
    5f68:	87aa                	mv	a5,a0
        str = olds;

    str += strspn(str, delim);
    if (*str == '\0')
    {
        olds = str;
    5f6a:	00f8b023          	sd	a5,0(a7)
        return NULL;
    5f6e:	4501                	li	a0,0
        *str = '\0';
        olds = str + 1;
    }

    return token;
}
    5f70:	8082                	ret
    if (*str == '\0')
    5f72:	00054603          	lbu	a2,0(a0)
    5f76:	da6d                	beqz	a2,5f68 <strtok+0x32>
    5f78:	86aa                	mv	a3,a0
        for (a = accept; *a; a++)
    5f7a:	04080163          	beqz	a6,5fbc <strtok+0x86>
    5f7e:	8742                	mv	a4,a6
    5f80:	87ae                	mv	a5,a1
    5f82:	a021                	j	5f8a <strtok+0x54>
    5f84:	0007c703          	lbu	a4,0(a5)
    5f88:	cb19                	beqz	a4,5f9e <strtok+0x68>
    5f8a:	0785                	addi	a5,a5,1
            if (*s == *a)
    5f8c:	fee61ce3          	bne	a2,a4,5f84 <strtok+0x4e>
        olds = str + 1;
    5f90:	00168793          	addi	a5,a3,1
        *str = '\0';
    5f94:	00068023          	sb	zero,0(a3)
        olds = str;
    5f98:	00f8b023          	sd	a5,0(a7)
}
    5f9c:	8082                	ret
    while (*s)
    5f9e:	0016c603          	lbu	a2,1(a3)
        s++;
    5fa2:	0685                	addi	a3,a3,1
    while (*s)
    5fa4:	fe69                	bnez	a2,5f7e <strtok+0x48>
    5fa6:	87aa                	mv	a5,a0
    while (*s != (char)c)
    5fa8:	0017c703          	lbu	a4,1(a5)
        if (!*s++)
    5fac:	0785                	addi	a5,a5,1
    while (*s != (char)c)
    5fae:	ff6d                	bnez	a4,5fa8 <strtok+0x72>
        olds = str;
    5fb0:	00f8b023          	sd	a5,0(a7)
}
    5fb4:	8082                	ret
        str = olds;
    5fb6:	0008b503          	ld	a0,0(a7)
    5fba:	b759                	j	5f40 <strtok+0xa>
    while (*s)
    5fbc:	0016c603          	lbu	a2,1(a3)
        s++;
    5fc0:	0685                	addi	a3,a3,1
    while (*s)
    5fc2:	fe6d                	bnez	a2,5fbc <strtok+0x86>
    5fc4:	b7cd                	j	5fa6 <strtok+0x70>

0000000000005fc6 <strerror>:

char *strerror(int errnum)
{
    5fc6:	87aa                	mv	a5,a0
    
    switch (errnum)
    5fc8:	cd09                	beqz	a0,5fe2 <strerror+0x1c>
    5fca:	4731                	li	a4,12
    5fcc:	00000517          	auipc	a0,0x0
    5fd0:	24450513          	addi	a0,a0,580 # 6210 <_GLOBAL__sub_I__ZSt3cin+0x20c>
    5fd4:	00e78b63          	beq	a5,a4,5fea <strerror+0x24>
        return "Success";
    // case EINVAL: return "Invalid argument";
    case ENOMEM: return "Out of memory";
    
    default:
        return "Unknown error";
    5fd8:	00000517          	auipc	a0,0x0
    5fdc:	24850513          	addi	a0,a0,584 # 6220 <_GLOBAL__sub_I__ZSt3cin+0x21c>
    5fe0:	8082                	ret
        return "Success";
    5fe2:	00000517          	auipc	a0,0x0
    5fe6:	22650513          	addi	a0,a0,550 # 6208 <_GLOBAL__sub_I__ZSt3cin+0x204>
    }
    5fea:	8082                	ret

0000000000005fec <_Znwm>:
#include "ulib/stdlib.h"

void *operator new(unsigned long n)
{
    return malloc(n);
    5fec:	cf6ff06f          	j	54e2 <malloc>

0000000000005ff0 <_Znam>:
}

void *operator new[](unsigned long n)
    5ff0:	cf2ff06f          	j	54e2 <malloc>

0000000000005ff4 <_ZdlPv>:
    return malloc(n);
}

void operator delete(void *p)
{
    free(p);
    5ff4:	c78ff06f          	j	546c <free>

0000000000005ff8 <_ZdaPv>:
}

void operator delete[](void *p)
    5ff8:	c74ff06f          	j	546c <free>

0000000000005ffc <_ZdlPvm>:
    free(p);
}

void operator delete(void *p, unsigned long)
{
    free(p);
    5ffc:	c70ff06f          	j	546c <free>

0000000000006000 <_ZdaPvm>:
}

void operator delete[](void *p, unsigned long)
    6000:	c6cff06f          	j	546c <free>

0000000000006004 <_GLOBAL__sub_I__ZSt3cin>:
#include "ulib/iostream"

namespace std
{
    istream cin(stdin);
    6004:	00003797          	auipc	a5,0x3
    6008:	c747b783          	ld	a5,-908(a5) # 8c78 <_GLOBAL_OFFSET_TABLE_+0x10>
    600c:	6390                	ld	a2,0(a5)
    ostream cout(stdout);
    600e:	00003797          	auipc	a5,0x3
    6012:	c627b783          	ld	a5,-926(a5) # 8c70 <_GLOBAL_OFFSET_TABLE_+0x8>
    6016:	6394                	ld	a3,0(a5)
    ostream cerr(stderr);
    6018:	00003797          	auipc	a5,0x3
    601c:	c687b783          	ld	a5,-920(a5) # 8c80 <_GLOBAL_OFFSET_TABLE_+0x18>
    6020:	6398                	ld	a4,0(a5)

    class istream{
    private:
        FILE* _stream;
    public:
        istream(FILE *f) : _stream(f) {}
    6022:	00003797          	auipc	a5,0x3
    6026:	e0e78793          	addi	a5,a5,-498 # 8e30 <_ZSt3cin>
    602a:	e390                	sd	a2,0(a5)
        ostream(FILE* f) : _stream(f) {}
    602c:	e794                	sd	a3,8(a5)
    602e:	eb98                	sd	a4,16(a5)
} // namespace std
    6030:	8082                	ret
