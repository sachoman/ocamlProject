open Graph
open Printf
open Gfile
open Tools
open Betterparser
open Gfile

let better_generateGraph pathcsv1 pathcsv2 pathoutput = 
  let _, _, tnodes,tcapa,larcs = better_import pathcsv1 pathcsv2 in 
  let nbnodes, nbhosts = List.length tnodes, List.length tcapa in
  let ff = open_out pathoutput in
  (* Write in this file. *)
  let _ = fprintf ff "%% Graph du better problème hosts hackers.\n\n" in

  (* Write all nodes (with fake coordinates) *)
  let _ = List.iter (fun (i,_) -> fprintf ff "n %d %d %d\n" i i i) tnodes in
  let _ = fprintf ff "n %d %d %d\n" 0 0 nbnodes in (*départ*)
  let _ = fprintf ff "n %d %d %d\n" 0 0 (nbnodes+1) in (*arrivée*)
  fprintf ff "\n" ;

  (* Write all arcs *)
  let _ = List.iter (fun ((x,y),_) -> fprintf ff "e %d %d %d %d\n" x y 1 1) larcs in
  let _ = List.iter (fun (x,_) -> if x >= nbhosts then fprintf ff "e %d %d %d %d\n" (nbnodes) x 1 1) tnodes in
  let _ = List.iter (fun (x,c) -> fprintf ff "e %d %d %s %s\n" x (nbnodes+1) c c) tcapa in

  fprintf ff "\n%% End of graph\n" ;

  close_out ff;
  ()
