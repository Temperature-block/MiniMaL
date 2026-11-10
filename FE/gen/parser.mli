
(* The type of tokens. *)

type token = 
  | VAL
  | SYMBOL of (string)
  | RP
  | LP
  | INT_LIT of (int)
  | IDENT of (string)
  | EOF
  | ASSIGN

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val prog: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.expr list)
