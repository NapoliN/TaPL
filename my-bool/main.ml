open Support.Error
open Syntax
open Format
open Core

let searchpath = ref [""]

let argDefs = []

(* parse argstring *)
let parseArgs () =
  let inFile = ref (None : string option) in
  Arg.parse argDefs
     (fun s ->
       match !inFile with
         Some(_) -> err "You must specify exactly one input file"
       | None -> inFile := Some(s))
     "";
  match !inFile with
      None -> err "You must specify an input file"
    | Some(s) -> s

let openfile infile = 
  let rec trynext l = match l with
        [] -> err ("Could not find " ^ infile)
      | (d::rest) -> 
          let name = if d = "" then infile else (d ^ "/" ^ infile) in
          try open_in name
            with Sys_error m -> trynext rest
  in trynext !searchpath

let parseFile inFile =
  let pi = openfile inFile
  in let lexbuf = Lexer.create pi
  in let result =
    try Parser.toplevel Lexer.main lexbuf
    with Parsing.Parse_error -> err "Parse Error"
  in Parsing.clear_parser(); close_in pi; result


let rec process_file f =
  let cmd = parseFile f in
  let g c =
    open_hvbox 0;
    let result = process_command c in
    result
  in g cmd; print_newline()
and process_command cmd = match cmd with
  | Eval(t) -> 
    let t' = eval t in Syntax.printtm t'

let main () =
  let inFile = parseArgs() in
  let _ = process_file inFile in ()

let res = 
  Printexc.print (fun unit -> main();0) ()

let () = exit res