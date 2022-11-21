open Graph
open Tools
open Array

let ford_fulkerson g s t = 
  let n = nbr_nodes g in
  let c = Array.make_matrix n n 0 in
  