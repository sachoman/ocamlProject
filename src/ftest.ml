open Gfile
open Tools
open Fordfulkerson

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
  let graph2 = gmap graph int_of_string in
  let path = find_path graph2 1 2 in
  let output_graph = update_residual_graph graph2 path in

  (* Rewrite the graph that has been read. *)
  (* let () = write_file outfile output_graph in *)
  let output_graph2 = gmap output_graph string_of_int in
  let () = export outfile output_graph2 in

  ()

