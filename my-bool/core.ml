open Syntax
exception NoRuleApplies

let rec eval1 t = match t with
   TmIf(TmTrue, t2, t3)   -> t2
  |TmIf(TmFalse, t2, t3)  -> t3
  |TmIf(t1, t2, t3) -> let t1' = eval1 t1 in TmIf(t1', t2, t3)
  |_                        -> raise NoRuleApplies

let rec eval t = 
  try let t' = eval1 t
    in eval t'
  with NoRuleApplies -> t