type term = 
        TmTrue
    |   TmFalse
    |   TmIf of term * term * term

type command = 
    Eval of term

val printtm: term -> unit