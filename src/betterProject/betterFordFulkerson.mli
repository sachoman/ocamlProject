open Graph
open Gfile
open Tools

val better_find_path : int graph -> int -> int -> ((int*int)*int) list -> int list
val better_ford_fulkerson : int graph -> int -> int -> string -> string -> int graph