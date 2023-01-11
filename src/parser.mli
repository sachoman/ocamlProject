open Graph
open Printf

type path = string

(* From two files, returns the number of hosts, the number of hackers,
   the name of the hosts and the hackers, the number of beds available of each host
   and the the matching between hacker-host *)
val from_file: path -> path -> int * int * string list * int list * (id * id) list
