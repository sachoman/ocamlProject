open Graph
open Tools
open Array
open Stack

let bfs g s t= 
  let n = nbr_nodes g in
  let color = Array.make n 0 in
  let pred = Array.make n 0 in
  let queue = Stack.create in
  (
    pred.(s) <- -1;
    Stack.push s queue
    assert False
  )


let ford_fulkerson g s t = 
  let n = nbr_nodes g in
  let c = Array.make_matrix n n 0 in
  (
    assert False
  )
