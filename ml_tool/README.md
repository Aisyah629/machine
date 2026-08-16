## ml_tool

### Overview
The `ml_tool` is a functional data transformation and analysis engine built strictly using the ML programming language. It provides a high-performance pipeline for processing, analyzing, and transforming structured data using functional programming principles.

### Features
- **Functional Data Pipeline**: A composable pipeline architecture for data transformation.
- **Pattern Matching**: Leverages ML's pattern matching for efficient data handling.
- **Immutable Data Structures**: Ensures data integrity and thread safety.
- **Type Safety**: Strong static typing to catch errors at compile time.

### Usage
1. **Data Definition**: Define your data structures using ML's algebraic data types.
2. **Transformation Functions**: Create pure functions to transform data.
3. **Pipeline Composition**: Compose transformation functions into a pipeline.
4. **Execution**: Run the pipeline on your input data.

### Example
```ml
(* Define data type *)
type Person = { name : string; age : int; score : float };

(* Define transformation functions *)
let filterAdulthood people =
  List.filter (fun p -> p.age >= 18) people;

let calculateAverageScore people =
  let total = List.fold_left (fun acc p -> acc +. p.score) 0.0 people in
  total /. (float_of_int (List.length people));

(* Compose pipeline *)
let process_data people =
  let adults = filterAdulthood people in
  let avg_score = calculateAverageScore adults in
  avg_score;

(* Usage *)
let sample_data = [
  { name = "Alice"; age = 25; score = 85.5 };
  { name = "Bob"; age = 17; score = 90.0 };
  { name = "Charlie"; age = 30; score = 78.2 };
];

let result = process_data sample_data;
printf "Average score of adults: %f\n" result;
```

### Building
To build the tool, ensure you have an ML compiler installed (e.g., Standard ML of New Jersey, OCaml, or SML/NJ). Run:
```bash
mlc main.ml -o ml_tool
```

### Testing
Run the included tests to verify functionality:
```bash
mlc test.ml -o ml_tool_test
./ml_tool_test
```

### License
This project is licensed under the MIT License.
