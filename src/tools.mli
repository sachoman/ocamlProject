open Graph

(* clone_nodes gr returns a new graph having the same nodes than gr, but no arc *)
val clone_nodes: 'a graph -> 'b graph

(* gmap gr f maps all arcs of gr by function f *)
val gmap: 'a graph -> ('a -> 'b) -> 'b graph

(* add_arc g id1 id2 n adds n to the value of the arc between id1 and id2. If the arc does not exist, it is created *)
val add_arc: int graph -> id -> id -> int -> int graph

(* nb_nodes gr returns the number of nodes of the graph gr *)
val nb_nodes: 'a graph -> int

(* path_e path_n returns the list of edges of a path from the list of nodes *)
val e_path: 'a list -> ('a * 'a) list