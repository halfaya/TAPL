-- Arithmetic

inductive Term where
| true : Term
| false : Term
| if : Term → Term → Term → Term
| zero : Term
| succ : Term → Term
| pred : Term → Term
| isZero : Term → Term
deriving Repr

def isNumericVal : Term → Bool
| Term.zero => true
| Term.succ t => isNumericVal t
| Term.pred t => isNumericVal t  -- strangely Pierce omits this
| _ => false

def isVal : Term → Bool
| Term.true => true
| Term.false => true
| t => isNumericVal t

-- small step evaluation
-- note that we handle values as a no-op, unlike Pierce
def eval1 : Term → Term
| Term.true => Term.true
| Term.false => Term.false
| Term.if Term.true t _ => t
| Term.if Term.false _ u => u
| Term.if b t u => Term.if (eval1 b) t u
| Term.zero => Term.zero
| Term.succ t => Term.succ (eval1 t)
| Term.pred (Term.zero) => Term.zero
| Term.pred t => Term.pred (eval1 t)
| Term.isZero (Term.zero) => Term.true
| Term.isZero (Term.succ _) => Term.false
| Term.isZero t => Term.isZero (eval1 t)

#eval eval1 (Term.if Term.true Term.zero Term.false)
