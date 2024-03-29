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
(*n colonne*)
(*satrt offset pour la ligne ligne*)
let get_nths_id list_of_lists n start =
  let rec aux l i acc = match l with
    | [] -> acc
    | t::q -> match (List.nth_opt t n) with
      | Some x -> aux q (i+1) ((i, x)::acc)
      | None -> aux q (i+1) acc
  in List.rev (aux list_of_lists start [])


(* Récupère la liste des tupes (i,j) quand le j ème élément de la i ème liste vaut 1, avec un offset n *)
(* string list list -> int -> (int * int) list *)
let better_recup_couples list_of_lists n =
  let result = ref [] in
  let i = ref 0 in
  List.iter (fun sublist ->
      let j = ref 0 in
      List.iter (fun x ->
          if (int_of_char (String.get x (String.length x-1))>=48) && (int_of_char (String.get x (String.length x-1))<=57)
          then (
            result := ((!i+n, !j), (100 - int_of_string x)):: !result;
            incr j
          )
          else (
            result := ((!i+n, !j), (100 - int_of_string (String.sub x 0 (String.length x -1 ) ))):: !result;
            incr j
          )
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
(* change un strign qui veut pas se transformer en itn via int_of_string*) 
let int_of_fucking_string s=
  let c = int_of_char (s.[0]) in
  c-48



(* Renvoie les informations nécessaires (cf. .mli) *)
let better_import path1 path2 =
  let capacites_hosts = read_csv path1 in
  let n = List.length capacites_hosts - 1 in
  let preferences = read_csv path2 in
  let m = List.length preferences - 1 in
  let names = (get_nths_id (get_tl_or_empty capacites_hosts) 0 0)
              @ (get_nths_id (get_tl_or_empty preferences) 0 n) in
  let l = (get_nths_id (get_tl_or_empty capacites_hosts) 1 0) in
  (*
  let beds_availables = List.map (fun (a,b) -> (a, (int_of_fucking_string b))) l in
  let _ = Printf.printf "taiulle liste :%d\n%!"  (List.length beds_availables) in *)
  (n, m, names, l, (better_recup_couples (suppr_fst_col_and_row preferences) n))
