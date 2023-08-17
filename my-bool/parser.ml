type token =
  | IF
  | THEN
  | ELSE
  | TRUE
  | FALSE
  | LPAREN
  | RPAREN
  | EOF

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
    open Syntax
# 16 "parser.ml"
let yytransl_const = [|
  257 (* IF *);
  258 (* THEN *);
  259 (* ELSE *);
  260 (* TRUE *);
  261 (* FALSE *);
  262 (* LPAREN *);
  263 (* RPAREN *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
    0|]

let yylhs = "\255\255\
\001\000\002\000\003\000\003\000\004\000\005\000\005\000\005\000\
\000\000"

let yylen = "\002\000\
\002\000\001\000\001\000\006\000\001\000\003\000\001\000\001\000\
\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\007\000\008\000\000\000\009\000\000\000\
\002\000\003\000\005\000\000\000\000\000\001\000\000\000\006\000\
\000\000\000\000\004\000"

let yydgoto = "\002\000\
\007\000\008\000\009\000\010\000\011\000"

let yysindex = "\001\000\
\000\255\000\000\000\255\000\000\000\000\000\255\000\000\007\000\
\000\000\000\000\000\000\006\255\002\255\000\000\000\255\000\000\
\007\255\000\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\253\255\000\000\000\000"

let yytablesize = 15
let yytable = "\012\000\
\003\000\001\000\013\000\004\000\005\000\006\000\014\000\015\000\
\016\000\018\000\000\000\017\000\000\000\000\000\019\000"

let yycheck = "\003\000\
\001\001\001\000\006\000\004\001\005\001\006\001\000\000\002\001\
\007\001\003\001\255\255\015\000\255\255\255\255\018\000"

let yynames_const = "\
  IF\000\
  THEN\000\
  ELSE\000\
  TRUE\000\
  FALSE\000\
  LPAREN\000\
  RPAREN\000\
  EOF\000\
  "

let yynames_block = "\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'Command) in
    Obj.repr(
# 21 "parser.mly"
                       ( _1 )
# 90 "parser.ml"
               :  Syntax.command ))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Term) in
    Obj.repr(
# 24 "parser.mly"
            ( (Eval(_1)))
# 97 "parser.ml"
               : 'Command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'AppTerm) in
    Obj.repr(
# 27 "parser.mly"
                                      ( _1 )
# 104 "parser.ml"
               : 'Term))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'Term) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'Term) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'Term) in
    Obj.repr(
# 28 "parser.mly"
                                      (TmIf(_2,_4,_6))
# 113 "parser.ml"
               : 'Term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'ATerm) in
    Obj.repr(
# 31 "parser.mly"
            ( _1 )
# 120 "parser.ml"
               : 'AppTerm))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'Term) in
    Obj.repr(
# 34 "parser.mly"
                        ( _2 )
# 127 "parser.ml"
               : 'ATerm))
; (fun __caml_parser_env ->
    Obj.repr(
# 35 "parser.mly"
                        ( TmTrue() )
# 133 "parser.ml"
               : 'ATerm))
; (fun __caml_parser_env ->
    Obj.repr(
# 36 "parser.mly"
                        ( TmFalse() )
# 139 "parser.ml"
               : 'ATerm))
(* Entry toplevel *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let toplevel (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf :  Syntax.command )
