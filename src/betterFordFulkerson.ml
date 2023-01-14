open Graph
open Gfile
open Tools
open Array
open Stack
open Betterparser
open Fordfulkerson


(* s = start, d = destination *)

let better_find_path graph start_node end_node l=
  let n = nb_nodes graph in
  let dist = Array.make n max_int in
  let prev = Array.make n (-1) in
  let deja_vu = Array.make n false in
  (* Initialize distance of starting node to 0 *)
  dist.(start_node) <- 0;
  for i = 1 to n - 1 do
    (*Printf.printf "iteration %d\n%!" i;*)
    e_iter graph (fun u v _ ->
        let cout = ref 0 in
        if not(deja_vu.(v))&&(deja_vu.(u)) then (
          (*Printf.printf "%d %d\n%!" u v;*)
          match (u,v) with
          |(a,_) when a = u -> cout :=1
          |(_,b) when b = v -> cout :=1
          |_ ->  (match List.assoc_opt (u,v) l 
                  with 
                  |Some x -> cout :=x 
                  |None -> (match List.assoc_opt (v,u) l with
                      |None -> failwith "erreur chemin" 
                      |Some x -> cout := -x 
                    )
                 )
        );
        let alt = dist.(u) + !cout in
        if alt < dist.(v) then (
          (*Printf.printf "deja vu %d\n%!" v;*)
          deja_vu.(v) <- true;
          dist.(v) <- alt;
          prev.(v) <- u
        )
      )
  done;
  (* Check for negative cycles *)
  (*
  let negative_cycle = ref false in
  e_iter graph (fun u v w ->
      if dist.(u) + w < dist.(v) then
        negative_cycle := true
    );
  if !negative_cycle then
    raise (Graph_error "Negative cycle detected")
  else
  *)
  let rec construct_path path u =
    if prev.(u) <> -1 then
      construct_path (u::path) prev.(u)
    else
      u::path
  in
  Some (construct_path [] end_node)

let better_update_residual_graph actual_res_gr e_p id_start min_flow=
  (* removes flow in forward edges *)
  let temp_gr = List.fold_left (fun gr (id1,id2) -> add_arc gr id2 id1 min_flow) actual_res_gr e_p in
  (* removes flow in backward edges *)
  List.fold_left (fun gr (id1,id2) -> add_arc gr id1 id2 (-min_flow)) temp_gr e_p

let better_ford_fulkerson g s d path1 path2=
  let _,_,_,_,l = better_import path1 path2 in
  (* On appelle notre fonction sur le graphe tant que nous trouvons des chemins augmentant le flot *)
  let rec aux gres = 
    (*Printf.printf "vanat better find ath\n%!";*)
    let path = better_find_path gres s d l in
    (*Printf.printf "apres better find ath\n%!";*)
    match path with
    (* plus de chemins améliorant on renvoie le graphe résiduel final *)
    |None -> Printf.printf "none\n%!"; gres
    |Some [] -> Printf.printf "some[]"; gres  
    (* on a un chemion, on construit le graphge résiduel et on rappelle notre algo sur ce nouveau graphe *)
    |Some path -> 
      (
        (*List.iter (fun x -> Printf.printf "chemin compsoé de %d\n%!" x) path;*)
        let e_new_path = e_path path in
        List.iter (fun (x,y) -> if y = 12 then Printf.printf "%d %d\n%!" x y else Printf.printf "%d %d%!" x y) e_new_path;
        let min_flow = ref max_int in
        let _ = List.iter (fun (x,y) -> match find_arc g x y with | None -> ()|Some e -> if e< !min_flow then min_flow := e ) e_new_path in
        if (!min_flow  = 0) then gres
        else(

          let gres_new = better_update_residual_graph gres e_new_path s !min_flow in gres_new
          (*aux gres_new*)
        )
      )
  in 
  let gres_final = aux g in
  (* via le graphe résiduel final et le graphe initial, on construit et renvoie le graphe de flot *)
  make_flow_graph g gres_final

