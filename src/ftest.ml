open Gfile
open Tools
open Fordfulkerson
open CreateCustomGraph
open Parser
open BetterFordFulkerson

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf "\nUsage: %s infile source sink outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)

  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in

  (* Tests des fonctions *)

  (* Test clone_nodes *)
  (* let output_graph = clone_nodes graphin *)

  (* Test gmap *)
  (* let output_graph = gmap graph (fun x-> string_of_int (2*int_of_string x)) in *)

  (* Test add_arc *)
  (* let output_graph = gmap (add_arc (gmap graph int_of_string) 2 5 98) string_of_int in *)

  (*
  let graph2 = gmap graph int_of_string in
  let path = find_path graph2 0 5 in
  let l_double = List.map (fun (a,_)->a) path in
  let output_graph_with_path = gmap graph2 string_of_int in
  let () = export outfile output_graph_with_path l_double in
  let residual_graph = update_residual_graph graph2 path 0 in

  let outfile_res = String.concat "_" [outfile;"residual"] in
  let output_residual_graph = gmap residual_graph string_of_int in
  let () = export outfile_res output_residual_graph [] in
  *)
  let graph_int = gmap graph int_of_string in
  let flow_graph_int = ford_fulkerson graph_int 0 10 in
  (*let flow_graph_int = graph_int in*)
  let flow_graph_string = gmap flow_graph_int string_of_int in
  let () = export outfile flow_graph_string [0;10] in

  ()

