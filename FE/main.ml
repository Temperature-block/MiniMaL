open Ast

(*

type name = Pname of string | Sname of string

type expr = Val of {name:name; body:bexpr} | Bexpr of bexpr
and bexpr = Intlit of int | Bind of name

*)

let get_name (e : expr) =
  match e with
  | Val { name = Pname r; _ } | Val { name = Sname r; _ } -> fst r
  | Bexpr _ -> None

let update_count (_,x) count =  x := count


let read_whole_file filename =
  try
    In_channel.with_open_text filename In_channel.input_all
  with
  | Sys_error msg -> failwith ("Failed to read file: " ^ msg)

let value_cache = Hashtbl.create 16

let cache_vals = function
		 | Val x -> (let name = get_name x in
                             match Hashtbl.find_opt value_cache name with
                             | Some count -> Hashtbl.replace value_cache name (count+1);
                             | None -> Hashtbl.add value_cache name 0)

                 | Bexpr _ -> ();
                                                                              
let parse s =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.prog Lexer.read lexbuf in
  ast

let rec check_unbound = function
                    | Val {  _ ;  body = Bexpr x } -> check_unbound x
                    | Bexpr y -> check_unbound y
                    | Intlit _ -> ()
                    | Bind z -> ( match Hashtbl.find_opt value_cache z with
                                  | Some count -> ()
                                  | None -> raise (Invalid_input "placeholder: unbound error at xyz")
                                  )
let rec update_ref = function
                    | Val {  _ ;  body = Bexpr x } -> check_unbound x
                    | Bexpr y -> check_unbound y
                    | Intlit _ -> ()
                    | Bind z -> ( match Hashtbl.find_opt value_cache z with
                                  | Some count -> update_count z count
                                  | None -> raise (Invalid_input "placeholder: unbound error at xyz")
                                  )

let rec check_semantics = function
                  | [] -> ()
                  | x::xs -> cache_vals x; check_unbound x; update_ref x; check_semantics xs

let compile = if argc > 1 then 
              let tree = parse (read_whole_file Sys.argv.(1)) in
              let semantics = check_semantics tree
              else ()


