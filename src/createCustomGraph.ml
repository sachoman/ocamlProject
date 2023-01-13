open Graph
open Printf
open Gfile
open Tools
open Array
open Stack
open Parser
open Gfile

let generateGraph pathcsv1 pathcsv2 pathoutput = 
  let _, _, tnodes,tcapa,larcs = import pathcsv1 pathcsv2 in 
  let nbnodes, nbhosts = List.length tnodes, List.length tcapa in
  let ff = open_out pathoutput in
  (* Write in this file. *)
  let _ = fprintf ff "%% Graph du problème hosts hackers.\n\n" in

  (* Write all nodes (with fake coordinates) *)
  let _ = List.iter (fun (i,_) -> fprintf ff "n %d %d %d\n" i i i) tnodes in
  let _ = fprintf ff "n %d %d %d\n" 0 0 (-1) in (*départ*)
  let _ = fprintf ff "n %d %d %d\n" 0 0 (-2) in (*arrivée*)
  fprintf ff "\n" ;

  (* Write all arcs *)
  let _ = List.iter (fun (x,y) -> fprintf ff "e %d %d %d %d\n" x y 0 1) larcs in
  let _ = List.iter (fun (x,_) -> if x >= nbhosts then fprintf ff "e %d %d %d %d\n" (-1) x 0 1) tnodes in
  let _ = List.iter (fun (x,c) -> fprintf ff "e %d %d %d %d\n" x (-2) 0 c ) tcapa in

  fprintf ff "\n%% End of graph\n" ;

  close_out ff;
  ()
;;