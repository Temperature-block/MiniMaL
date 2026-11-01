builtins = INT_ADD, INT_SUB, INT_LT, INT_GT, INT_EQ, AND, OR, NOT, BNOT, BLS, BRS, BARS

Note:- NOT and BNOT are different all the “B*” builtins are bitwise

VAL_BINDING = [a-z][A-Za-z_0-9]* | [!@#$%^&*<>]*

INT_LIT = \-?[0-9]+

TOPLEVEL = EXPR+

BINDING_EXPR = INT_LIT | “(“ BINDING_EXPR “)”

EXPR = VAL 

VAL = “val” VAL_BINDING “:=” BINDING_EXPR

Note:- ik we have functions we will gradually develop it
