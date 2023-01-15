type 'a priorityQueue = (int * 'a) list

let vide : 'a priorityQueue = [ ]

let inserer x clef (q:'a priorityQueue) : 'a priorityQueue =
  if List.exists (fun (_, v) -> x = v) q
  then failwith "l'element est déjà dans la file"
  else (clef,x) :: q
;;


let est_vide (q:'a priorityQueue) : bool = (q = [ ]);;

(* [trouve_min_aux min_val min_clef q] renvoie un couple de clef minimale
     dans (min_val,min_clef)::q *)
let rec trouve_min_aux (min_val:'a) (min_clef:int) (q:'a priorityQueue) : int * 'a =
  match q with
  | [ ] -> (min_clef, min_val)
  | (clef, _) :: q when clef > min_clef -> trouve_min_aux min_val min_clef q
  | (clef, v) :: q -> trouve_min_aux v clef q
;;

(* [trouve_min q] renvoie un élément de clef minimale la file [q].
   Lance une exception si la liste est vide *)
let trouve_min (q:'a priorityQueue) : 'a =
  match q with
  | [ ] -> failwith "trouve_min: la file est vide"
  | (clef, v) :: q -> snd (trouve_min_aux v clef q)
;;

(* [supprime v q] renvoie une file contenant les éléments de [q], sauf [x].
   [x] doit apparaitre une et une seule fois dans la file. *)
let rec supprime (x:'a) (q:'a priorityQueue) : 'a priorityQueue =
  match q with
  | [ ] -> [ ]
  | (_, v) :: q when v=x -> q
  | (clef, v) :: q -> (clef, v) :: (supprime x q)
;;

let extraire_min (q:'a priorityQueue) : 'a * 'a priorityQueue =
  if q = [ ] then
    failwith "extraire_min: file vide"
  else
    let min = trouve_min q in
    (min, supprime min q)
;;

let rec diminuer_clef (x:'a) (clef:int) (q:'a priorityQueue) : 'a priorityQueue =
  match q with
  | [ ] -> Printf.printf "on rajoute dans la file car diminution\n%!";[(clef, x)]
  | (_, v) :: q when v=x -> (clef, x) :: q
  | (c, v) :: q -> (c, v) :: diminuer_clef x clef q
;;