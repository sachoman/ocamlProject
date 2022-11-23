open Graph
open Tools
open Array
open Stack

let edmond_karp gr = assert false

let bfs gres s t= 
  (*
  let n = nbr_nodes g in
  let color = Array.make n 0 in
  let pred = Array.make n 0 in
  let queue = Stack.create in
  let u = ref s in
  let v = ref t in
  (
    pred.(s) <- -1;
    Stack.push s queue;
    while (!Stack.is_empty queue){
        u := Stack.pop queue in
for (v = 0)
}
)
*)
  assert false



let ford_fulkerson g s t =
  (*
  let n = nbr_nodes g in
  let c = Array.make_matrix n n 0 in
  *)
  assert false

let make_residual_graph actual_res_gr flow_graph path =
  let rec find_min_of_path p m = match p with
    | [] -> m
    | [_] -> raise Graph_error "Pb"
    | id1::id2 -> match (find_arc id1 id2) with
      | Some v -> min v m
      | None -> raise Graph_error "No edge"
      | id1::id2::q -> match (find_arc id1 id2) with
        | Some v -> min v (find_min_of_path id2::q m)
        | None -> raise Graph_error "No edge"
  in find_min_of_path path max_int in
assert false