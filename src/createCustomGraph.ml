open Graph
open Tools
open Array
open Stack

let generateGraphe pathcsv pathoutput = 
  let _, _, tnodes,tcapa,larcs = from_file pathcsv in 
  let nbnodes, nbhosts = Array.length tnodes, Array.length tcapa in
  let ff = open_out pathoutput in
    (* Write in this file. *)
    fprintf ff "%% Graph du problème hosts hackers.\n\n" ;

    (* Write all nodes (with fake coordinates) *)
    for (int i=0; i<nbnodes; i++){
      let _ = fprintf ff "n %d %d %d\n" (compute_x i) (compute_y i) i ;
    }
    let _ = fprintf ff "n %d %d %d\n" (compute_x -1) (compute_y -1) -1 ; (*départ*)
    let _ = fprintf ff "n %d %d %d\n" (compute_x -1) (compute_y -1) -2 ; (*arrivée*)
    fprintf ff "\n" ;

    (* Write all arcs *)
    let _ = List.iter (fun (x,y) -> fprintf ff "e %d %d %d %s\n" x y 0 1) larcs;
    for (int i=0; i<nbhosts; i++){
      let _ = fprintf ff "e %d %d %d %s\n" i -2 0 tcapa[i];
    }
    for (int i=nbhosts; i<nbnodes;i++){
      let _ = fprintf ff "e %d %d %d %s\n" -1 i 0 1;
    }

    fprintf ff "\n%% End of graph\n" ;

    close_out ff ;
  ()
