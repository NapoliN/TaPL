open Support.Error
open Syntax
open Format
open Core

let parse_line lexbuf = 
  let result = try Parser.toplevel Lexer.main lexbuf
  with Parsing.Parse_error -> err "Parse Error"
  in Parsing.clear_parser(); result

let process_command cmd = match cmd with
  | Eval(t) -> 
    let t' = eval t in Syntax.printtm t'

let process_interpret () =
  let lexbuf = Lexer.create stdin in
  let rec process_line () = 
    let cmds = parse_line lexbuf in
    let g cmd = 
      print_string "> ";
      process_command cmd;
      print_newline()
    in List.iter g cmds; process_line();
  in process_line ()

let () =
  process_interpret()