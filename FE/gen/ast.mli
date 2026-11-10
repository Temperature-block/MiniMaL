type name = Pname of string | Sname of string
type expr = Val of { name : name; body : bexpr; } | Bexpr of bexpr
and bexpr = Intlit of int | Bind of name
