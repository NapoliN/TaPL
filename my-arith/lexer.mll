{
open Support.Error
exception LexError

let lineno   = ref 1
and start    = ref 0

and filename = ref ""

(*reserved word*)
let reservedWords = [
    (* booleans *)
    ("if", fun unit -> Parser.IF);
    ("then", fun unit -> Parser.THEN);
    ("else", fun unit -> Parser.ELSE);
    ("true", fun unit -> Parser.TRUE);
    ("false", fun unit -> Parser.FALSE);

    (* numbers *)
    ("succ", fun unit -> Parser.SUCC);
    ("pred", fun unit -> Parser.PRED);
    ("iszero", fun unit -> Parser.ISZERO);
    
    (* support tokens *)
    ("(", fun unit -> Parser.LPAREN);
    (")", fun unit -> Parser.RPAREN);
    (";", fun unit -> Parser.SEMI)
]

let info lexbuf =
  createInfo (!filename) (!lineno) (Lexing.lexeme_start lexbuf - !start)

(*Support functions*)
type buildfun = unit -> Parser.token
let (symbolTable : (string, buildfun) Hashtbl.t) = Hashtbl.create 1024
let _ = 
    List.iter (fun (str,f) -> Hashtbl.add symbolTable str f) reservedWords

let createID str = 
    try (
        Hashtbl.find symbolTable str
        ) ()
    with Not_found -> raise LexError

(* renaming *)
let create inFile stream = 
    if not (Filename.is_implicit inFile) then filename := inFile
            else filename := Filename.concat (Sys.getcwd()) inFile;
    Lexing.from_channel stream

let create_nofile stream = 
    filename := "INTP"; Lexing.from_channel stream

let text = Lexing.lexeme
let lexerr = print_err_info
}

(* Rules *)
rule main = parse
      [' ' '\t']+
        { main lexbuf }    (* skip space *)
    | [ '\n'] | eof
        { Parser.EOF }
    | ['a'-'z']+
        { createID (text lexbuf) } (* reserved keywords *)
    
    | ['0'-'9']+
        { Parser.INTV(int_of_string (text lexbuf)) } (* numbers *)

    | ['(' ')' ';']
        { createID (text lexbuf) } (* reserved keywords*)
    
