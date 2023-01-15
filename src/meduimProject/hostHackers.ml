open Gfile
open Tools
open Graph
open Printf
open Parser
open Fordfulkerson
open CreateCustomGraph

let () =
  let pathCapa = "datas/SheetsOCAMLcapacites.csv" in
  let pathAppariements = "datas/SheetsOCAMLappariement.csv" in
  let _ = generateGraph pathCapa pathAppariements "GraphInit" in
  let graph = from_file "GraphInit" in
  let graph_int = gmap graph int_of_string in
  let flow_graph_int = ford_fulkerson graph_int (-1) (-2) in
  let n, m, tnodes,tcapa,larcs = import pathCapa pathAppariements in 
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