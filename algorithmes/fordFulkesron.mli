<<<<<<< HEAD

val find_min_flow_of_path: int graph -> int list -> int graph
val make_residual_graph: int graph -> int graph
val bfs : int graph -> int -> int -> int list
val edmund_karp : int  graph -> int -> int
val ford_fulkerson : int graph -> int  -> int
=======
(* Breadth-first search algorithm, returns an augmentation path *)
val bfs: int graph -> int -> int -> int list

(* Edmund-Karp algorithm *)
val edmond_karp: int  graph -> int -> int

(* Ford-Fulkerson algorithm *)
val ford_fulkerson: int graph -> int  -> int

(* Creates the residual graph from the  *)
val make_residual_graph: int graph -> int graph -> int list -> int graph
>>>>>>> 8546d7aa7c8b0e2b8e622eabd1f5d805c5fe3dcb
