(* ml_tool/main.ml *)
(* Functional Data Transformation and Analysis Engine *)

(* Define data types *)
type Person = { name : string; age : int; score : float };

(* Define transformation functions *)
let filterAdulthood people =
  List.filter (fun p -> p.age >= 18) people;

let calculateAverageScore people =
  let total = List.fold_left (fun acc p -> acc +. p.score) 0.0 people in
  total /. (float_of_int (List.length people));

let filterByScore people threshold =
  List.filter (fun p -> p.score >= threshold) people;

let transformPersonName p = { p with name = String.uppercase_ascii p.name };

(* Compose pipeline *)
let process_data people =
  let adults = filterAdulthood people in
  let highScorers = filterByScore adults 80.0 in
  let transformed = List.map transformPersonName highScorers in
  let avg_score = calculateAverageScore transformed in
  {
    adults_count = List.length adults;
    high_scoring_count = List.length highScorers;
    transformed_data = transformed;
    average_score = avg_score;
  };

(* Main execution *)
let () =
  let sample_data = [
    { name = "Alice"; age = 25; score = 85.5 };
    { name = "Bob"; age = 17; score = 90.0 };
    { name = "Charlie"; age = 30; score = 78.2 };
    { name = "David"; age = 22; score = 88.0 };
    { name = "Eve"; age = 35; score = 95.3 };
  ] in
  
  let result = process_data sample_data in
  
  Printf.printf "=== Data Processing Results ===\n";
  Printf.printf "Adults Count: %d\n" result.adults_count;
  Printf.printf "High Scorers Count: %d\n" result.high_scoring_count;
  Printf.printf "Average Score: %.2f\n" result.average_score;
  
  Printf.printf "\n=== Transformed Data ===\n";
  List.iter (fun p ->
    Printf.printf "Name: %s, Age: %d, Score: %.2f\n" p.name p.age p.score
  ) result.transformed_data;
  
  Printf.printf "\n=== Pipeline Execution Complete ===\n";
