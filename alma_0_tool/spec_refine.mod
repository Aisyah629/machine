MODULE spec_refine;

(* Specification Refinement Module for Alma-0 *)
(* This module demonstrates formal specification and algorithmic construction principles *)

FROM IO IMPORT writeln;

PROCEDURE verifySpecification(input : Integer) : Boolean;
(* Formal specification: input must be a non-negative integer *)
VAR isValid : Boolean;
BEGIN
    isValid := input >= 0;
    IF NOT isValid THEN
        writeln("Specification Violation: Input " , input , " is negative.");
    ELSE
        writeln("Specification Satisfied: Input is valid.");
    END;
    RETURN isValid;
END verifySpecification;

PROCEDURE refineAlgorithm(input : Integer) : Integer;
(* Algorithmic construction based on refined specifications *)
VAR output : Integer;
BEGIN
    IF verifySpecification(input) THEN
        output := input * input;
        writeln("Algorithm refined successfully. Output: ", output);
    ELSE
        output := 0;
        writeln("Algorithm construction halted due to specification failure.");
    END;
    RETURN output;
END refineAlgorithm;

END spec_refine.
