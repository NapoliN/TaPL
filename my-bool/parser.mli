type token =
  | IF
  | THEN
  | ELSE
  | TRUE
  | FALSE
  | LPAREN
  | RPAREN
  | SEMI
  | EOF

val toplevel :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf ->  Syntax.command list
