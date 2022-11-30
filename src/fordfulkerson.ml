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
        let (x,y) = List.find (fun e -> (not(List.mem (fst(e)) deja_vu) && not(snd(e)=0))) larc in
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
    (_,_,false) -> []
    |(_,path,true) -> path



let make_flow_graph init_graph last_residual_graph =
  let flow_graph = clone_nodes init_graph in
  e_fold init_graph (
    fun g id1 id2 label -> let label = find_arc last_residual_graph id2 id1 in
      (
        match label with
        | Some x -> new_arc g id1 id2 x
        | None -> new_arc g id1 id2 0
      )

  ) flow_graph

let update_residual_graph actual_res_gr path id_start=
  let min_flow = List.fold_left (fun x (_,label) -> min x label) max_int path in
  let e_p = e_path (List.map (fun (id,_) -> id) ((id_start,0)::(List.rev path))) in
  (* removes flow in forward edges *)
  let temp_gr = List.fold_left (fun gr (id1,id2) -> add_arc gr id2 id1 min_flow) actual_res_gr e_p in
  (* removes flow in backward edges *)
  List.fold_left (fun gr (id1,id2) -> add_arc gr id1 id2 (-min_flow)) temp_gr e_p

let ford_fulkerson g s t=
  (*
  let n = nbr_nodes g in
  let c = Array.make_matrix n n 0 in
  *)
  let rec aux gres = 
    let path = find_path gres s t in
    if path =[] then gres
    else(
      let min_flow = List.fold_left (fun x (_,label) -> min x label) max_int path in
      if (min_flow  = 0) then gres
      else(
        let gres_new = update_residual_graph gres path s in
        aux gres_new
      )
    )
  in 
  let gres_final = aux g in
  make_flow_graph g gres_final

