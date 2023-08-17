open Format

type term = 
        TmTrue of unit
    |   TmFalse of unit
    |   TmIf of term * term * term

type command = 
    Eval of term

let obox0() = open_hvbox 0
let obox() = open_hvbox 2
let cbox() = close_box()
let break() = print_break 0 0

let rec printtm_Term outer t = 
  match t with
  TmIf(t1,t2,t3) ->
    obox0();
    print_string "TmIf(";
    printtm_Term false t1;
    print_space();
    print_string ", ";
    printtm_Term false t2;
    print_space();
    print_string "else ";
    printtm_Term false t3;
    cbox();
  | t -> printtm_AppTerm outer t
and printtm_AppTerm outer t = match t with
  t -> printtm_ATerm outer t
and printtm_ATerm outer t = match t with
    TmTrue(_) -> print_string "true"
  | TmFalse(_) -> print_string "false"
  | t -> 
    print_string "(";
    printtm_Term outer t;
    print_string ")"

let printtm t = printtm_Term true t
