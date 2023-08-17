(* Header *)
{
exception LexError

(*reserved word*)
let reservedWords = [
    ("if", fun unit -> Parser.IF);
    ("then", fun unit -> Parser.THEN);
    ("else", fun unit -> Parser.ELSE);
    ("true", fun unit -> Parser.TRUE);
    ("false", fun unit -> Parser.FALSE);
    
    ("(", fun unit -> Parser.LPAREN);
    (")", fun unit -> Parser.RPAREN);
    (";", fun unit -> Parser.SEMI)
]

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

let create stream = 
    Lexing.from_channel stream

let text = Lexing.lexeme
}

rule main = parse
      [' ' '\t']+
        {main lexbuf}    (* skip space *)
    | [ '\n'] | eof
        { Parser.EOF }
    | ['a'-'z']+
        { createID (text lexbuf) } (* reserved keyword *)

    | ['(' ')' ';']
        { createID (text lexbuf) } (* *)
    
