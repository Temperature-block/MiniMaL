%{
open Ast

(*
type name = Pname of string | Sname of string

type expr = Val of {name:name; body:bexpr} | Bexpr of bexpr
and bexpr = Intlit of int | Bind of name
*)

%}

%token VAL 
%token ASSIGN 
%token <int>  INT_LIT 
%token <string> IDENT 
%token <string> SYMBOL 
%token LP 
%token RP 
%token EOF
%token SEND
%token INT_ADD
%token INT_SUB
%token INT_LT
%token INT_GT
%token INT_EQ
%token AND
%token OR
%token NOT
%token BNOT
%token BLS
%token BRS
%token BARS
%start <Ast.expr list> prog

%%

prog:
	| e = nonempty_list(expr); EOF { e }
	;

name:
	| i = IDENT { Pname(i,ref 0) }
	| i = SYMBOL { Sname(i,ref 0) }
	;

expr:
	| VAL; n = name; ASSIGN; e = bexpr; SEND; { Val( {name = n; body = e}) }
	| e = bexpr; SEND;{ Bexpr ( e ) }
	;

atom:
        | i = INT_LIT { Intlit ( i ) }
        | n = name { Bind ( n ) }
        | LP; e = bexpr; RP { e }
        ;

ap:
        | p = prim; args = list(atom) { Pap ( {prim = p; args} ) }
        | p = name; args = nonempty_list(atom) { Apply ( {fn = p; args} ) }
        ;

prim:
	| INT_ADD { Int_add }
	| INT_SUB { Int_sub }
	| INT_LT  { Int_lt }
	| INT_GT  { Int_gt }
	| INT_EQ  { Int_eq }
	| AND     { And }
	| OR      { Or }
	| NOT     { Not }
	| BNOT    { Bnot }
	| BLS     { Bls }
	| BRS     { Brs }
	| BARS    { Bars }
	;

bexpr:
        | a = atom { a }
        | a = ap { App ( a ) }
        ;
