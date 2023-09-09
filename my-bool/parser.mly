%{
    open Syntax
%}

/* keyword */
%token IF
%token THEN
%token ELSE
%token TRUE
%token FALSE

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
    Term    { (Eval($1)) }

Term :
      TRUE              { TmTrue }
    | FALSE             { TmFalse }
    | IF Term THEN Term ELSE Term     {TmIf($2,$4,$6)}
    | LPAREN Term RPAREN  { $2 }