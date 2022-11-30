open Graph
open List

(* TRouve un chemin augmentant le flot entre le noeud start et le noeud destination *)
val find_path: int graph -> int -> int -> (int *int) list option

(* Ford-Fulkerson algorithm *)
val ford_fulkerson: int graph -> int  -> int -> int graph

(* Creates the residual graph from the  *)
val update_residual_graph: int graph -> (int * int) list -> int -> int graph

(*crée le graphe de flot final à partir du graphe résiduel final obtenu*)
val make_flow_graph: int graph -> int graph -> int graph