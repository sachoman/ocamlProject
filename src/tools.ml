open Graph

(* clone_nodes gr returns a new graph having the same nodes than gr, but no arc *)
let clone_nodes gr = n_fold gr new_node empty_graph

(* gmap gr f maps all arcs of gr by function f *)
let gmap gr f = let new_gr = clone_nodes gr in
  e_fold gr (fun g id1 id2 label -> new_arc g id1 id2 (f label)) new_gr

(* add_arc g id1 id2 n adds n to the value of the arc between id1 and id2.
 * If the arc does not exist, it is created. *)
let add_arc gr id1 id2 lbl =
  if not (node_exists gr id1 && node_exists gr id2)
  then raise (Graph_error ("One or both nodes does not exist."))
  else
    match (find_arc gr id1 id2) with
    | None -> new_arc gr id1 id2 lbl
    | Some l -> new_arc gr id1 id2 (l + lbl)