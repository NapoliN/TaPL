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

%token EOF

%start toplevel
%type < Syntax.command > toplevel
%%

toplevel : Command EOF { $1 }

Command :
    Term    { (Eval($1))}

Term :
      AppTerm                         { $1 }
    | IF Term THEN Term ELSE Term     {TmIf($2,$4,$6)}

AppTerm :
    ATerm   { $1 }

ATerm :
    LPAREN Term RPAREN  { $2 }
    | TRUE              { TmTrue }
    | FALSE             { TmFalse }