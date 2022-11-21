open Graph
open Tools
open Array
open Stack

let bfs gres s t= 
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
    assert False
  )


let ford_fulkerson g s t = 
  let n = nbr_nodes g in
  let c = Array.make_matrix n n 0 in
  (
    assert False
  )
