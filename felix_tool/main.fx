// main.fx - Felix Functional Data Transformation Library
// Implements a composable, type-safe data transformation pipeline

module DataTransform

import System.IO
import System.Console

// Define core transformation types
record TransformState 'a 'b =
  inputs: list 'a
  outputs: list 'b
  errors: list String

// Pure mapping function with error tracking
fun map_with_err 'a 'b (f: 'a -> option 'b) (xs: list 'a) -> list 'b =
  let rec go = fun acc -> match xs with
    | [] -> reverse acc
    | x :: rest ->
      match f x with
      | some v -> go (v :: acc) rest
      | none -> go acc rest
  in go [] xs

// Higher-order composition for chaining transformations
fun compose 'a 'b 'c (f: 'b -> 'c) (g: 'a -> 'b) (x: 'a) -> 'c =
  f (g x)

// Lazy stream processing using Felix's lazy lists
fun stream_map 'a 'b (f: 'a -> 'b) (s: lazy list 'a) -> lazy list 'b =
  lazy (match s with
    | lazy_nil -> lazy_nil
    | lazy_cons x xs -> lazy_cons (f x) (stream_map f xs)
  )

// Fold with early termination support
fun fold_until 'a 'b (initial: 'b) (f: 'b -> 'a -> option 'b) (xs: list 'a) -> 'b =
  let rec go acc = match xs with
    | [] -> acc
    | x :: rest ->
      match f acc x with
      | some next_acc -> go next_acc rest
      | none -> acc
  in go initial

// Main execution module
module Main

  // Sample transformation pipeline
  fun process_data (raw_data: list String) -> list int =
    let parse_int = fun s ->
      try
        some (int_of_string s)
      with
        | _ -> none
    in
    let filter_valid = fun compose (parse_int >> filter some)
    in
    stream_map (fun x -> x * 2 + 1) (filter_valid raw_data)
    |> lazy_list_to_list

  // Entry point
  fun main () -> unit =
    let test_input = ["42", "invalid", "7", "3", "-1"]
    let result = process_data test_input
    println "Transformation Pipeline Result:"
    println (string_of_list int_of_string result)

// Export public API
export map_with_err
export compose
export stream_map
export fold_until
export Main.process_data
export Main.main
