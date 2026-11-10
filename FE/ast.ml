
(*
builtins = INT_ADD, INT_SUB, INT_LT, INT_GT, INT_EQ, AND, OR, NOT, BNOT, BLS, BRS, BARS

Note:- NOT and BNOT are different all the “B*” builtins are bitwise

VAL_BINDING = [a-z][A-Za-z_0-9]* | [!@#$%^&*<>]*

INT_LIT = \-?[0-9]+

TOPLEVEL = EXPR+

BINDING_EXPR = INT_LIT | VAL_BINDING | “(“ BINDING_EXPR “)”

EXPR = VAL | BINDING_EXPR

VAL = “val” VAL_BINDING “:=” BINDING_EXPR

Note:- ik we have functions we will gradually develop it

*)


type name = Pname of string  * int ref | Sname of string * int ref

type expr = Val of {name:name; body:bexpr} | Bexpr of bexpr

and bexpr = Intlit of int | Bind of name | App of ap

and prim = Int_add  | Int_sub  | Int_lt  | Int_gt  | Int_eq  
            | And  | Or  | Not  | Bnot  | Bls  | Brs  | Bars

and ap = Pap of {prim:prim; args:bexpr list} | Apply of {fn:name; args:bexpr list}
