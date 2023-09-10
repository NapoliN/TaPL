type term = 
    (* booleans *)
        TmTrue
    |   TmFalse
    |   TmIf of term * term * term
    (* numbers *)
    |   TmZero
    |   TmSucc of term
    |   TmPred of term
    |   TmIsZero of term

type command = 
    Eval of term

val printtm: term -> unit