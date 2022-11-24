open Graph
open Tools
open Array
open Stack

let edmond_karp gr = assert false

let find_path gres s t = 
  let rec aux gres a c deja_vu path= 
  if (a==c) then ([],path, true)
  else
    let larc = out_arcs gres a in
    match larc with 
    [] -> ([], [], false)
    |(b,label)::q when (not (List.mem a deja_vu)) -> 
      let res = aux gres b c (b::deja_vu) ((b,label)::path) in
      (
        match res with
        (res_deja_vu, _ , false) -> aux gres a c (res_deja_vu@deja_vu) path
        |(_,path, true ) -> ([],path, true)
      )
    |(b,_)::q -> aux gres a c (b::deja_vu) path
    in let res = aux gres s t [s] [] in
    match res with
    (_,path,_) -> path


   
    


let ford_fulkerson g s t =
  (*
  let n = nbr_nodes g in
  let c = Array.make_matrix n n 0 in
  *)
  assert false


let make_residual_graph actual_res_gr flow_graph path =
  let rec find_min_of_path p m = match p with
    | [] -> m
    | [_] -> raise Graph_error "Pb"
    | id1::id2 -> match (find_arc id1 id2) with
      | Some v -> min v m
      | None -> raise Graph_error "No edge"
      | id1::id2::q -> match (find_arc id1 id2) with
        | Some v -> min v (find_min_of_path id2::q m)
        | None -> raise Graph_error "No edge"
  in find_min_of_path path max_int in
assert false
