<<<<<<< HEAD

val find_min_flow_of_path: int graph -> int list -> int graph
val make_residual_graph: int graph -> int graph
val bfs : int graph -> int -> int -> int list
val edmund_karp : int  graph -> int -> int
val ford_fulkerson : int graph -> int  -> int
val bfs: int graph -> int -> int -> int list

(* Edmund-Karp algorithm *)
val edmond_karp: int  graph -> int -> int

(* Ford-Fulkerson algorithm *)
val ford_fulkerson: int graph -> int  -> int

(* Creates the residual graph from the  *)
val update_residual_graph: int graph -> (int * 'a) list -> int graph