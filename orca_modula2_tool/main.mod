MODULE Main;

(* ORCA/Modula-2 Main Program *)

FROM STextIO IMPORT WriteString, WriteLn, ReadCard, ReadChar;

VAR
  name: ARRAY [0..49] OF CHAR;
  age: CARDINAL;

BEGIN
  WriteString("Hello! Welcome to the ORCA/Modula-2 Tool.");
  WriteLn;
  WriteString("Please enter your name: ");
  ReadLn(name);
  WriteString("Please enter your age: ");
  ReadCard(age);
  WriteLn;
  WriteString("Hello, ");
  WriteString(name);
  WriteString("! You are ");
  WriteCARD(age);
  WriteString(" years old.");
  WriteLn;
END Main.
