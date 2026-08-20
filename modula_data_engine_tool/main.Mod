MODULE Main;

IMPORT IO, InOut, Strings, Math;

(* Data structures for processing *)
TYPE
  Record = RECORD
    id: INTEGER;
    value: REAL;
    tag: ARRAY 16 OF CHAR;
  END;

  DataStream = ARRAY 1024 OF Record;

(* Global variables *)
VAR
  data: DataStream;
  count: INTEGER;
  sum: REAL;

(* Procedure to initialize data *)
PROCEDURE InitData(VAR stream: DataStream); VAR
  i: INTEGER;
BEGIN
  FOR i := 0 TO HIGH(stream) DO
    stream[i].id := i;
    stream[i].value := 0.0;
    Strings.Init(stream[i].tag, 'EMPTY');
  END;
  count := 0;
  sum := 0.0;
END InitData;

(* Procedure to process a single record *)
PROCEDURE ProcessRecord(VAR rec: Record);
BEGIN
  (* Transform value: square it *)
  rec.value := Math.Pow(rec.value, 2.0);
  (* Update tag if value > 10 *)
  IF rec.value > 10.0 THEN
    Strings.FromInt(rec.id, rec.tag, 16, '0');
  END;
END ProcessRecord;

(* Procedure to aggregate results *)
PROCEDURE AggregateData();
VAR
  i: INTEGER;
BEGIN
  sum := 0.0;
  FOR i := 0 TO count - 1 DO
    sum := sum + data[i].value;
  END;
END AggregateData;

(* Procedure to print results *)
PROCEDURE PrintResults();
VAR
  i: INTEGER;
BEGIN
  InOut.WriteString('Processed Records:');
  InOut.Ln;
  FOR i := 0 TO count - 1 DO
    InOut.WriteInt(data[i].id, 4);
    InOut.WriteReal(data[i].value, 10, 2);
    InOut.WriteString(' [');
    InOut.WriteString(data[i].tag);
    InOut.WriteString(']');
    InOut.Ln;
  END;
  InOut.Ln;
  InOut.WriteReal('Sum: ');
  InOut.WriteReal(sum, 10, 2);
  InOut.Ln;
END PrintResults;

(* Main execution *)
BEGIN
  InitData(data);
  
  (* Simulate data input *)
  data[0].value := 2.0;
  count := 1;
  
  data[1].value := 5.0;
  INC(count);
  
  data[2].value := 3.5;
  INC(count);
  
  (* Process data *)
  FOR i := 0 TO count - 1 DO
    ProcessRecord(data[i]);
  END;
  
  (* Aggregate *)
  AggregateData();
  
  (* Output *)
  PrintResults();
  
END Main.
