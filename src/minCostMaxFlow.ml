open Graph
open List
open Gfile

let out_arcsCost = assert false

let dijkstra graph start goal =
  let n = n_count graph in
  let dist = Array.make n max_int in
  let prev = Array.make n (-1) in
  let visited = Array.make n false in

  dist.(start) <- 0;

  (* Create a priority queue with all nodes *)
  let q = PriorityQueue.create n (fun i j -> dist.(i) <= dist.(j)) in
  for i = 0 to n - 1 do
    PriorityQueue.add q i
  done;

  (* Iterate until the priority queue is empty or we reach the goal node *)
  while not (PriorityQueue.is_empty q) && not visited.(goal) do
    let u = PriorityQueue.pop_top q in
    visited.(u) <- true;

    (* Relax all edges from node u *)
    let outs= out_arcsCost graph u in
    List.iter (fun (v, w) ->
      if dist.(u) + w < dist.(v) then begin
        dist.(v) <- dist.(u) + w;
        prev.(v) <- u;
        PriorityQueue.remove q v;
        PriorityQueue.add q v;
      end
    ) outs;
  done;

  (* If we reached the goal node, construct the shortest path *)
  if visited.(goal) then begin
    let path = ref [] in
    let node = ref goal in
    while !node <> start do
      path := !node :: !path;
      node := prev.(!node);
    done;
    path := start :: !path;
    Some !path
  end else None