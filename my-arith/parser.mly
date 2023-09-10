%{
    open Syntax
%}

/* keyword */
/* booleans */
%token IF
%token THEN
%token ELSE
%token TRUE
%token FALSE

/* numbers */
%token SUCC
%token PRED
%token ISZERO
%token<int> INTV

/* support symbols */
%token LPAREN
%token RPAREN
%token SEMI

%token EOF

%start toplevel
%type < Syntax.command list> toplevel
%%

toplevel : 
    EOF {[]}
    | Command SEMI toplevel
        { $1 :: $3}

Command :
    Term    { (Eval($1))}

Term :
      AppTerm                         { $1 }
    | IF Term THEN Term ELSE Term     {TmIf($2,$4,$6)}

/* applying terms */
AppTerm :
    ATerm   { $1 }
    | SUCC ATerm    {TmSucc($2)}
    | PRED ATerm    {TmPred($2)}
    | ISZERO ATerm  {TmIsZero($2)}

/* atomic terms */
ATerm :
    LPAREN Term RPAREN  { $2 }
    | TRUE              { TmTrue }
    | FALSE             { TmFalse }
    | INTV              { let rec f n = match n with
                                            0 -> TmZero
                                        |   n -> TmSucc(f (n-1))
                                        in f $1 }