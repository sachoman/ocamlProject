open Graph

(* clone_nodes gr returns a new graph having the same nodes than gr, but no arc *)
let clone_nodes gr = List.map (fun (a, _) -> (a, [])) gr

(* gmap gr f maps all arcs of gr by function f *)
let gmap gr f = List.map (fun (id, outa) -> (id,(List.map f outa)))

(* add_arc g id1 id2 n adds n to the value of the arc between id1 and id2.
 * If the arc does not exist, it is created. *)
let add_arc gr id1 id2 lbl =
  if not (node_exists gr id1 && node_exists gr id2)
  then raise (Graph_error ("One or both nodes does not exist."))
  else
    match (find_arc gr id1 id2) with
    | None -> new_arc gr id1 id2 lbl
    | Some l -> new_arc gr id1 id2 (l + lbl)