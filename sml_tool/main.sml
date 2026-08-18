(* Standard ML (SML) Tool - Main Entry Point *)

(* A simple demonstration of SML functionality *)

fun factorial n =
    if n <= 0 then 1
    else n * factorial (n - 1);

fun main () =
    let
        val test_num = 5;
        val result = factorial test_num;
    in
        print ("Result of factorial(" ^ Int.toString test_num ^ ") is: " ^ Int.toString result ^ "\n");
        print ("SML Tool initialized successfully.\n")
    end;

(* Execute main logic *)
main ();
