open Graph
open Tools
open Array
open Stack

(* s = start, d = destination *)
let find_path gres s d = 
  (* a : noeud intermédiare du chemin, 
     deja_vu : tous les sommets déjà vus par l'algorithme pour trouver un chemin
     path_to_a : chemin de (d_noeuds * label) pour aller de s à a *)
  let rec aux a deja_vu path_to_a = 
    (*on est arrivéé à destination *)
    if (a=d) then ([],Some path_to_a)
    else
      let larc = out_arcs gres a in
      (* trouve un arc sortant de a dont la destination n'a pas déà été vue par l'algo *)
      match List.find_opt (fun e -> (not(List.mem (fst(e)) deja_vu) && not(snd(e)=0))) larc with
      |None -> (deja_vu,None)
      |Some(i,label_i) ->(
          (* teste si on a un chemin de i vers la destination d *)
          match aux i (i::deja_vu) ((i,label_i)::path_to_a) with
          (* Si pas de chemin depuis i, on rappelle l'algo sur a avec une liste de déjà vu plus importante *)
          |(res_deja_vu, None) -> aux a (res_deja_vu@deja_vu) path_to_a
          |(_,Some path) -> ([],Some path)
        )
  in let res = aux s [s] [] in
  snd(res)



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

let ford_fulkerson g s d=
  (* On appelle notre fonction sur le graphe tant que nous trouvons des chemins augmentant le flot *)
  let rec aux gres = 
    let path = find_path gres s d in
    match path with
    (* plus de chemins améliorant on renvoie le graphe résiduel final *)
    |None -> gres
    (* on a un chemion, on construit le graphge résiduel et on rappelle notre algo sur ce nouveau graphe *)
    |Some path -> 
      (
        let min_flow = List.fold_left (fun x (_,label) -> min x label) max_int path in
        if (min_flow  = 0) then gres
        else(
          let gres_new = update_residual_graph gres path s in
          aux gres_new
        )
      )
  in 
  let gres_final = aux g in
  (* via le graphe résiduel final et le graphe initial, on construit et renvoie le graphe de flot *)
  make_flow_graph g gres_final

