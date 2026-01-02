#include "ulib/stdio.h"
#include "ulib/stdlib.h"
#include "ulib/string.h"
#include "user/user.h"
#include "common/fcntl.h"

constexpr int MAX_ARGS = 10;
const char *WHITESPACE = " \t\r\n\v";
const char *SYMBOLS = "<|>&;()";

void panic(const char *s)
{
    printf("shell panic: %s\n", s);
    exit(1);
}

int fork_or_panic()
{
    int pid = fork();
    if (pid == -1)
        panic("fork");
    return pid;
}

struct Command
{
    virtual ~Command() = default;

    virtual void run() = 0;
};

struct ExecCommand : public Command
{
    char *argv[MAX_ARGS];

    ExecCommand()
    {
        memset(argv, 0, sizeof(argv));
    }

    void run() override
    {
        if (argv[0] == nullptr)
            exit(1);

        exec(argv[0], argv);

        printf("exec %s failed\n", argv[0]);
        exit(1);
    }
};

struct RedirCommand : public Command
{
    Command *sub_cmd;
    char *file;
    char *efile; // file name end pointer (used by parser)
    int mode;
    int fd;

    RedirCommand(Command *c, char *f, char *ef, int m, int fd_in)
        : sub_cmd(c), file(f), efile(ef), mode(m), fd(fd_in) {}

    ~RedirCommand() { delete sub_cmd; }

    void run() override
    {
        close(fd);
        if (open(file, mode) < 0)
        {
            printf("open %s failed\n", file);
            exit(1);
        }
        sub_cmd->run();
    }
};

struct PipeCommand : public Command
{
    Command *left;
    Command *right;

    PipeCommand(Command *l, Command *r) : left(l), right(r) {}
    ~PipeCommand()
    {
        delete left;
        delete right;
    }

    void run() override
    {
        int p[2];
        if (pipe(p) < 0)
            panic("pipe");

        if (fork_or_panic() == 0)
        {
            // Left child: write to pipe
            close(1);  // close stdout
            dup(p[1]); // dup write-end to stdout
            close(p[0]);
            close(p[1]);
            left->run();
        }

        if (fork_or_panic() == 0)
        {
            // Right child: read from pipe
            close(0);  // close stdin
            dup(p[0]); // dup read-end to stdin
            close(p[0]);
            close(p[1]);
            right->run();
        }

        close(p[0]);
        close(p[1]);
        wait(0);
        wait(0);
        exit(0);
    }
};

struct ListCommand : public Command
{
    Command *left;
    Command *right;

    ListCommand(Command *l, Command *r) : left(l), right(r) {}
    ~ListCommand()
    {
        delete left;
        delete right;
    }

    void run() override
    {
        if (fork_or_panic() == 0)
        {
            left->run();
        }
        wait(0);
        right->run();
    }
};

struct BackCommand : public Command
{
    Command *sub_cmd;

    BackCommand(Command *c) : sub_cmd(c) {}
    ~BackCommand() { delete sub_cmd; }

    void run() override
    {
        if (fork_or_panic() == 0)
        {
            sub_cmd->run();
        }
        // Parent doesn't wait
        exit(0);
    }
};

class Parser
{
public:
    static Command *parse(char *s)
    {
        char *es = s + strlen(s);
        Command *cmd = parse_line(&s, es);
        peek(&s, es, "");
        if (s != es)
        {
            printf("leftovers: %s\n", s);
            // panic("syntax"); // strict syntax check
        }
        terminate_strings(cmd);
        return cmd;
    }

private:
    // Helper: NUL-terminate strings found during parsing
    static void terminate_strings(Command *cmd)
    {
        if (!cmd)
            return;
    }

    static char get_token(char **ps, char *es, char **q, char **eq)
    {
        char *s;
        int ret;

        s = *ps;
        while (s < es && strchr(WHITESPACE, *s))
            s++;
        if (q)
            *q = s;
        ret = *s;
        switch (*s)
        {
        case 0:
            break;
        case '|':
        case '(':
        case ')':
        case ';':
        case '&':
        case '<':
            s++;
            break;
        case '>':
            s++;
            if (*s == '>')
            {
                ret = '+';
                s++;
            }
            break;
        default:
            ret = 'a';
            while (s < es && !strchr(WHITESPACE, *s) && !strchr(SYMBOLS, *s))
                s++;
            break;
        }
        if (eq)
            *eq = s;

        while (s < es && strchr(WHITESPACE, *s))
            s++;
        *ps = s;
        return ret;
    }

    static int peek(char **ps, char *es, const char *toks)
    {
        char *s = *ps;
        while (s < es && strchr(WHITESPACE, *s))
            s++;
        *ps = s;
        return *s && strchr(toks, *s);
    }

    // Recursive Descent Parsers

    static Command *parse_line(char **ps, char *es)
    {
        Command *cmd = parse_pipe(ps, es);
        while (peek(ps, es, "&"))
        {
            get_token(ps, es, 0, 0);
            cmd = new BackCommand(cmd);
        }
        if (peek(ps, es, ";"))
        {
            get_token(ps, es, 0, 0);
            cmd = new ListCommand(cmd, parse_line(ps, es));
        }
        return cmd;
    }

    static Command *parse_pipe(char **ps, char *es)
    {
        Command *cmd = parse_exec(ps, es);
        if (peek(ps, es, "|"))
        {
            get_token(ps, es, 0, 0);
            cmd = new PipeCommand(cmd, parse_pipe(ps, es));
        }
        return cmd;
    }

    static Command *parse_exec(char **ps, char *es)
    {
        char *q, *eq;
        int tok, argc;
        ExecCommand *cmd = new ExecCommand();
        Command *ret = cmd;

        argc = 0;
        ret = parse_redirs(ret, ps, es);
        while (!peek(ps, es, "|)&;"))
        {
            if ((tok = get_token(ps, es, &q, &eq)) == 0)
                break;
            if (tok != 'a')
                panic("syntax");

            cmd->argv[argc] = q;
            *eq = 0; // Temp

            argc++;
            if (argc >= MAX_ARGS)
                panic("too many args");
            ret = parse_redirs(ret, ps, es);
        }
        cmd->argv[argc] = 0;
        return ret;
    }

    static Command *parse_redirs(Command *cmd, char **ps, char *es)
    {
        int tok;
        char *q, *eq;

        while (peek(ps, es, "<>"))
        {
            tok = get_token(ps, es, 0, 0);
            if (get_token(ps, es, &q, &eq) != 'a')
                panic("missing file for redirection");

            *eq = 0; // Null terminate filename immediately

            switch (tok)
            {
            case '<':
                cmd = new RedirCommand(cmd, q, eq, O_RDONLY, 0);
                break;
            case '>':
                cmd = new RedirCommand(cmd, q, eq, O_WRONLY | O_CREATE | O_TRUNC, 1);
                break;
            case '+':                                                       // >>
                cmd = new RedirCommand(cmd, q, eq, O_WRONLY | O_CREATE, 1); // Append not fully supported in simple OS yet?
                break;
            }
        }
        return cmd;
    }
};

int getcmd(char *buf, int nbuf)
{
    write(1, "$ ", 2);
    memset(buf, 0, nbuf);

    int i = 0;
    while (i < nbuf - 1)
    {
        char c;
        int n = read(0, &c, 1);
        if (n <= 0)
            return -1;

        if (c == '\b' || c == 127)
        {
            if (i > 0)
            {
                write(1, "\b \b", 3);
                i--;
            }
        }
        else if (c == '\n' || c == '\r')
        {
            write(1, "\n", 1);
            buf[i] = 0;
            return 0;
        }
        else
        {
            write(1, &c, 1);
            buf[i++] = c;
        }
    }
    return -1;
}

int main()
{
    static char buf[100];

    // int fd;
    // while ((fd = open("console", O_RDWR)) >= 0)
    // {
    //     if (fd >= 3)
    //     {
    //         close(fd);
    //         break;
    //     }
    // }

    printf("\n[Lume Shell] Initialized! \n");

    while (getcmd(buf, sizeof(buf)) >= 0)
    {
        if (buf[0] == 'c' && buf[1] == 'd' && (buf[2] == ' ' || buf[2] == '\n' || buf[2] == 0))
        {
            if (buf[strlen(buf) - 1] == '\n')
                buf[strlen(buf) - 1] = 0;

            char *path = buf + 3;
            if (buf[2] == '\n' || buf[2] == 0)
            {
                printf("cd: argument missing\n");
                continue;
            }

            if (chdir(path) < 0)
            {
                printf("cannot cd %s\n", path);
            }
            continue;
        }

        if (fork_or_panic() == 0)
        {
            Command *cmd = Parser::parse(buf);
            if (cmd)
            {
                cmd->run();
                delete cmd;
            }
            exit(0);
        }
        wait(0);
    }
    return 0;
}