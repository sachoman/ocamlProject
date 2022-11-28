open Graph
open Tools
open Array
open Stack

let edmond_karp gr = assert false

let find_path gres s t = 
  let rec aux a c deja_vu path= 
    if (a==c) then ([],path, true)
    else
      let larc = out_arcs gres a in
      try (
              let (x,y) = List.find (fun e -> not(List.mem (fst(e)) deja_vu)) larc in
              let res = aux x c (x::deja_vu) ((x,y)::path) in
              (
                match res with
                |(res_deja_vu, _ , false) -> aux a c (res_deja_vu@deja_vu) path
                |(_,path, true ) -> ([],path, true)
              )
            )
          with
          Not_found -> (deja_vu,[],false)
  in let res = aux s t [s] [] in
  match res with
    (_,path,_) -> path


   
    


let ford_fulkerson g s =
  (*
  let n = nbr_nodes g in
  let c = Array.make_matrix n n 0 in
  *)
  assert false

let update_residual_graph actual_res_gr path =
  let min_flow = List.fold_left (fun x (_,label) -> min x label) max_int path in
  let e_p = e_path (List.map (fun (id,_) -> id) path) in
  let temp_gr = List.fold_left (fun gr (id1,id2) -> add_arc gr id2 id1 min_flow) actual_res_gr e_p in
  List.fold_left (fun gr (id1,id2) -> add_arc gr id1 id2 (-min_flow)) temp_gr e_p
