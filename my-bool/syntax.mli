type term = 
        TmTrue of unit
    |   TmFalse of unit
    |   TmIf of term * term * term

type command = 
    Eval of term

val printtm: term -> unit