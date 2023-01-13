open Graph
open Printf
open Gfile

type idp = int

val read_csv: string -> string list list

(* From two files, returns the number of hosts, the number of hackers,
   the name of the hosts and the hackers, the number of beds available of each host
   and the the matching between hacker-host *)
val import: string -> string -> int * int * (idp * string) list * (idp * int) list * (idp * idp) list
