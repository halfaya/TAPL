inductive Term where
| var : Int → Term
| abs : Term → Term
| app : Term → Term → Term
