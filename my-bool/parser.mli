type token =
  | IF
  | THEN
  | ELSE
  | TRUE
  | FALSE
  | LPAREN
  | RPAREN
  | EOF

val toplevel :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf ->  Syntax.command 
