{
open Parser
}

let white   = [' ' '\t' '\n']+
let digit   = ['0'-'9']
let int_lit = '-'? digit+
let ident   = ['a'-'z'] ['A'-'Z' 'a'-'z' '_' '0'-'9']+
let symbol  = ['!' '@' '#' '$' '%' '^' '&' '*' '<' '>']+

rule read = 
  parse
 |white { read lexbuf }
 |"val" { VAL }
 |":=" { ASSIGN }
 |int_lit { INT_LIT (int_of_string(Lexing.lexeme lexbuf))} 
 |ident { IDENT (Lexing.lexeme lexbuf) }
 |symbol { SYMBOL (Lexing.lexeme lexbuf) }
 |"(" { LP }
 |")" { RP }
 | eof { EOF }
