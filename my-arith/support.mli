
module Error : sig
    exception Exit of int

    (* information for debug *)
    type info
    (* create from filename, lineno, column *)
    val createInfo : string -> int -> int -> info
    val printInfo : info -> unit

    val errf : (unit->unit) -> 'a
    (* wrapper for errf. print error message to stderr *)
    val err : string -> 'a
    val print_err_info : info -> string -> 'a

end