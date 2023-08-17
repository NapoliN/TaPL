
module Error : sig
    exception Exit of int

    val errf : (unit->unit) -> 'a
  
    (* Convenient wrappers for the above, for the common case where the
       action to be performed is just to print a given string. *)
    val err : string -> 'a

end