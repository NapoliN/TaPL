open Syntax
exception NoRuleApplies
exception WrongValue

let rec isnumericalval t = match t with
    TmZero      -> true
  | TmSucc(t1)  -> isnumericalval t1
  | _           -> false

let rec isval t = match t with
    TmTrue      -> true
  | TmFalse     -> true
  | t when isnumericalval t -> true
  | _           -> false

let rec eval1 t = match t with
  (* Rules for branch *)
   TmIf(TmTrue, t2, t3)   -> t2
  |TmIf(TmFalse, t2, t3)  -> t3
  |TmIf(t1, t2, t3) -> let t1' = eval1 t1 in TmIf(t1', t2, t3)
  (* Rules for numbers *)
  |TmSucc(t) -> let t' = eval1 t in TmSucc(t')
  |TmPred(TmZero) -> TmZero
  |TmPred(TmSucc(nv)) when isnumericalval nv -> nv 
  (* Rules for numerical decision *)
  |TmIsZero(TmZero) -> TmTrue
  |TmIsZero(TmSucc(t)) when isnumericalval t -> TmFalse
  |TmIsZero(t) -> let t' = eval1 t in TmIsZero(t')
  |_                        -> raise NoRuleApplies

let rec eval t = 
  try let t' = eval1 t
    in eval t'
  with NoRuleApplies when isval t -> t
  | NoRuleApplies -> raise WrongValue