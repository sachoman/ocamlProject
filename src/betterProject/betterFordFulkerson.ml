open Graph
open Gfile
open Tools
open Array
open Betterparser
open Fordfulkerson
open PriorityQueueTools

let better_find_path g s d l=
  let q = ref vide in
  let n = nb_nodes g in
  let dist = Array.make n max_int in
  dist.(s)<-0;
  let prev = Array.make n (-1) in
  for i=0 to n - 1 do (* initialisation de la file *)
    q := inserer i dist.(i) !q
  done;
  while not(est_vide !q) do
    let (x, q') = extraire_min !q in
    q := q';
    (* on met à jour la distance pour tous les arcs sortants *)
    let bb = ref true in
    List.iter (fun (y,label) ->
        if !bb then(
          (*On vérifie que l'arrête peut bien être parcourue dans un sens ou l'autre*)
          if label <> 0 then
            (*cas ou le sommet de départ de l'arrête est notre sommet initial*)
            if x=s then (dist.(y) <- dist.(x);
                         (*Printf.printf "on améliore %d\n%!" dist.(y);*)
                         prev.(y) <- x;
                         q := diminuer_clef y dist.(y) !q)
            else
              (*cas ou le sommet d'arrivée de l'arrête est notre sommet final*)
            if dist.(x)<> max_int then(
              if y=d then (dist.(y) <- dist.(x);
                           (*"on améliore %d et on vide !!!!!!\n%!" dist.(y);*)
                           prev.(y) <- x;
                           q := vide;
                           bb := false) else
                (*cas général, on regarde le cout de l'arrête dans la liste issue du parsing de notre tableau d'appariements*)
                match List.assoc_opt (x,y) l with
                |Some c ->  
                  if dist.(y) > dist.(x) + c
                  then (
                    dist.(y) <- dist.(x) + c;
                    prev.(y) <- x;
                    (*"on améliore %d\n%!" dist.(y);*)
                    q := diminuer_clef y (dist.(y)) !q
                  )
                |None ->
                  (*La liste fournit seulement les arrêtes positives, dans ce cas on regarde le cout en inversant le sens de l'arrête et on inverse son signe*)
                  (match List.assoc_opt (y,x) l with
                   |None -> ()
                   |Some c ->  if dist.(y) > dist.(x) - c
                     then (
                       dist.(y) <- dist.(x) - c;
                       prev.(y) <- x;
                       (*"on améliore %d\n%!" dist.(y); *)
                       q := diminuer_clef y (dist.(y)) !q
                     )
                  )
            )
        )
      ) (out_arcs g x)
  done;
  (*on reconstruit le chemin à partir du tableau prev*)
  let rec aux path x = 
    match prev.(x) with
    |(-1) -> (x::path)
    |y -> aux (x::path) y  
  in aux [] d   

let better_update_residual_graph actual_res_gr e_p id_start min_flow=
  (* removes flow in forward edges *)
  let temp_gr = List.fold_left (fun gr (id1,id2) -> add_arc gr id2 id1 min_flow) actual_res_gr e_p in
  (* removes flow in backward edges *)
  List.fold_left (fun gr (id1,id2) -> add_arc gr id1 id2 (-min_flow)) temp_gr e_p

let better_ford_fulkerson g s d path1 path2=
  let _,_,_,_,l = better_import path1 path2 in
  (* On appelle notre fonction sur le graphe tant que nous trouvons des chemins augmentant le flot *)
  let rec aux gres i= 
    let path = better_find_path gres s d l in
    match path with
    (* plus de chemins améliorant on renvoie le graphe résiduel final *)
    |[a] -> gres  
    (* on a un chemion, on construit le graphge résiduel et on rappelle notre algo sur ce nouveau graphe *)
    |_ -> 
      (
        let e_new_path = e_path path in
        (*Permet d'afficher les chemins pris successivement par notre algorithme *)
        (*List.iter (fun x -> if x = d then Printf.printf "%d\n%!" x else Printf.printf "%d->%!" x) path;*)
        let min_flow = ref max_int in
        let _ = List.iter (fun (x,y) -> match find_arc g x y with | None -> ()|Some e -> if e< !min_flow then min_flow := e ) e_new_path in
        if (!min_flow  = 0) then gres
        else(
          let gres_new = better_update_residual_graph gres e_new_path s !min_flow in
          if i < 10 then aux gres_new (i+1) else gres_new
        )
      )
  in 
  let gres_final = aux g 0 in
  (* via le graphe résiduel final et le graphe initial, on construit et renvoie le graphe de flot *)
  make_flow_graph g gres_final

