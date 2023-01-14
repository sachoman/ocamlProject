open Gfile
open Tools
open Fordfulkerson
open CreateCustomGraph
open Parser

let () =
  let pathCapa = "datas/SheetsOCAMLcapacites.csv" in
  let pathAppariements = "datas/SheetsOCAMLappariement.csv" in
  let _ = generateGraph pathCapa pathAppariements"resultGraph" in
  ()