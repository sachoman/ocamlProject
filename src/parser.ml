open Graph
open Printf

type path = string

let from_file path1 path2 =
  let infile1 = open_in path1 in
  let n = int_of_string (List.hd (String.split_on_char ',' (input_line infile1))) in
  let infile2 = open_in path2 in
  let m = int_of_string (List.hd (String.split_on_char ',' (input_line infile1))) in
  let names = [] in
  let places_by_host = [] in
  let correspondence = [] in
  let rec loop =
    try
      let line = String.split_on_char ',' (input_line infile1) in
      names = (List.hd line)::names;
      places_by_host = (List.hd (List.tl line))::places_by_host;
      ()
    with End_of_file -> ()
  in
  let () = loop in
