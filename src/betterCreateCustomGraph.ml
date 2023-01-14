open Graph
open Printf
open Gfile
open Tools
open Array
open Stack
open Betterparser
open Gfile
open BetterFordFulkerson

let better_generateGraph pathcsv1 pathcsv2 pathoutput = 
  let _, _, tnodes,tcapa,larcs = better_import pathcsv1 pathcsv2 in 
  let nbnodes, nbhosts = List.length tnodes, List.length tcapa in
  let ff = open_out pathoutput in
  (* Write in this file. *)
  let _ = fprintf ff "%% Graph du problème hosts hackers.\n\n" in

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

let better_resolveProbleme () = 
  let pathCapa = "datas/SheetsOCAMLcapacites.csv" in
  let pathAppariements = "datas/SheetsOCAMLbetterappariement.csv" in
  let _ = better_generateGraph pathCapa pathAppariements "GraphInit" in
  let graph = from_file "GraphInit" in
  let graph_int = gmap graph int_of_string in
  let n, m, tnodes,tcapa,larcs = better_import pathCapa pathAppariements in 
  let flow_graph_int = better_ford_fulkerson graph_int (n+m) (n+m+1) pathCapa pathAppariements in
  let _ = List.iter (fun (x,xs) -> if x >= n then let larcs = out_arcs flow_graph_int x in
                        let rec aux l bol = 
                          match l with 
                          |[] -> if bol then Printf.printf "%s n'a pas de logement\n%!" xs
                          |(y,l)::q -> if l != 0 then (Printf.printf "%s loge chez %s\n%!" xs (match List.assoc_opt y tnodes with Some a -> a | None -> "none") ; aux q false) else aux q bol 
                        in aux larcs true
                    ) tnodes in
  let flow_graph_string = gmap flow_graph_int string_of_int in
  let () = export "flowGraph" flow_graph_string [0;10] in
  ()