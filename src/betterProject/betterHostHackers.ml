open Graph
open Printf
open Gfile
open Tools
open Betterparser
open BetterFordFulkerson
open BetterCreateCustomGraph

let () =
  let ff = open_out "outfile.txt" in
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
                          |[] -> if bol then (Printf.printf "%s n'a pas de logement\n%!" xs; fprintf ff "%s n'a pas de logement\n%!" xs)
                          |(y,l)::q -> if l != 0 then let host = (match List.assoc_opt y tnodes with Some a -> a | None -> "none") in
                              ((Printf.printf "%s loge chez %s\n%!" xs host; fprintf ff "%s loge chez %s\n%!" xs host); aux q false) else aux q bol 
                        in aux larcs true
                    ) tnodes in
  let flow_graph_string = gmap flow_graph_int string_of_int in
  let () = export "flowGraph" flow_graph_string [n+m;n+m+1] in
  ()