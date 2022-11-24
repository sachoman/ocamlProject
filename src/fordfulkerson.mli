open Graph
open List

(* Breadth-first search algorithm, returns an augmentation path *)
val find_path: 'a graph -> int -> int -> (int *'a) list

(* Edmund-Karp algorithm *)
val edmond_karp: int  graph -> int -> int

(* Ford-Fulkerson algorithm *)
val ford_fulkerson: int graph -> int  -> int

(* Creates the residual graph from the  *)
val make_residual_graph: int graph -> int graph -> int list -> int graph
