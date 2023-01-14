open Graph
open Printf

(* =============== DEFINITION DE FONCTIONS UTILES =============== *)

(* Renvoie la queue d'une liste si elle existe, la liste vide défaut *)
(* 'a list -> 'a list *)
let get_tl_or_empty = function
  | [] -> []
  | _::q -> q

let suppr_fst_col_and_row li =
  let rec aux l acc = match l with
    | [] -> acc
    | t::q -> match t with
      | [] -> aux q acc
      | _::q2 -> aux q (q2::acc)
  in List.rev(aux (get_tl_or_empty li) [])  

(* Renvoie la liste des nièmes éléments accompagnés d'un id d'une liste de listes (si les éléments existent) *)
(* 'a list list -> int -> (int * 'a) list *)
let get_nths_id list_of_lists n start =
  let rec aux l i acc = match l with
    | [] -> acc
    | t::q -> match (List.nth_opt t n) with
      | Some x -> aux q (i+1) ((i, x)::acc)
      | None -> aux q (i+1) acc
  in List.rev (aux list_of_lists start [])


(* Récupère la liste des tupes (i,j) quand le j ème élément de la i ème liste vaut 1, avec un offset n *)
(* string list list -> int -> (int * int) list *)
let recup_couples list_of_lists n =
  let result = ref [] in
  let i = ref 0 in
  List.iter (fun sublist ->
      let j = ref 0 in
      List.iter (fun x ->
          if x = "1" then begin
            result := (!i+n, !j) :: !result;
          end;
          incr j
        ) sublist;
      incr i;
    ) list_of_lists;
  List.rev !result

(* =============== PARTIE EXPLOITATION DES DONNEES =============== *)

(* Renvoie une liste de listes à partir d'un fichier csv *)
(* string -> string list list *)
let read_csv file_name = 
  let file = open_in file_name in
  let rec read_lines acc = 
    try 
      let line = input_line file in
      let fields = String.split_on_char ',' line in
      read_lines (fields::acc)
    with End_of_file -> close_in file; List.rev acc
  in
  read_lines []

(* Renvoie les informations nécessaires (cf. .mli) *)
let import path1 path2 =
  let capacites_hosts = read_csv path1 in
  let n =
    match capacites_hosts with
    | [] -> failwith "Fichier vide"
    | l::_ -> match l with
      | [] -> failwith "Pb fichier"
      | x::_ -> int_of_string x
  in
  let preferences = read_csv path2 in
  let m =
    match preferences with
    | [] -> failwith "Fichier vide"
    | l::_ -> match l with
      | [] -> failwith "Pb fichier"
      | x::_ -> int_of_string x
  in
  let names = (get_nths_id (get_tl_or_empty capacites_hosts) 0 0)
              @ (get_nths_id (get_tl_or_empty preferences) 0 n) in
  let l = (get_nths_id (get_tl_or_empty capacites_hosts) 1 0) in
  let _ = Printf.printf("liste  créée \n %!") in
  let _ = List.iter (fun (x, y) -> Printf.printf "(%d, %s)\n%!" x y) l  in
  let beds_availables = List.map (fun (a,b) -> let _ = Printf.printf "\n%!" in (a, (int_of_string b))) l in
  let _ = Printf.printf("beds available ok \n %!") in
  (n, m, names, beds_availables, (recup_couples (suppr_fst_col_and_row preferences) n))
