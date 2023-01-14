open Graph
open Printf
open Gfile

val read_csv: string -> string list list

(* From two files, returns the number of hosts, the number of hackers,
   the name of the hosts and the hackers, the number of beds available of each host
   and the the matching between hacker-host *)
val better_import: string -> string -> int * int * (int * string) list * (int * string) list * ((int * int) * int) list