(* Breadth-first search algorithm, returns an augmentation path *)
val bfs: int graph -> int -> int -> int list

(* Edmund-Karp algorithm *)
val edmond_karp: int  graph -> int -> int

(* Ford-Fulkerson algorithm *)
val ford_fulkerson: int graph -> int  -> int

(* Creates the residual graph from the  *)
val make_residual_graph: int graph -> int graph