%{
open Ast

(*
type name = Pname of string | Sname of string

type expr = Val of {name:name; body:bexpr} | Bexpr of bexpr
and bexpr = Intlit of int | Bind of name
*)

%}

%token  VAL 
%token  ASSIGN 
%token <int>  INT_LIT 
%token <string> IDENT 
%token  <string> SYMBOL 
%token  LP 
%token  RP 
%token EOF

%start <Ast.expr list> prog

%%

prog:
	| e = nonempty_list(expr); EOF { e }
	;

name:
	| i = IDENT { Pname(i) }
	| i = SYMBOL { Sname(i) }
	;

expr:
	| VAL; n = name; ASSIGN; e = bexpr; { Val( {name = n; body = e}) }
	| e = bexpr; { Bexpr ( e ) } 
	;


bexpr:
	| i = INT_LIT { Intlit ( i ) }
	| LP; e = bexpr; RP; { e }
	| n = name { Bind ( n ) }
	;

