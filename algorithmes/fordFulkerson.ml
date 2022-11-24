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

let update_residual_graph actual_res_gr path =
  let min_flow = List.fold_left (fun x (_,label) -> min x label) max_int path in
  let e_p = e_path (List.map (fun (id,_) -> id) path) in
  let temp_gr = List.fold_left (fun gr (id1,id2) -> add_arc gr id2 id1 min_flow) actual_res_gr e_p in
  List.fold_left (fun gr (id1,id2) -> add_arc gr id1 id2 (-min_flow)) temp_gr e_p