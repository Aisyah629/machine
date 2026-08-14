MODULE OrcaDataManipulator;

IMPORT InOut, Math;

CONST
  MaxSize = 100;

VAR
  Data: ARRAY [0..MaxSize-1] OF INTEGER;
  Count: INTEGER;

PROCEDURE InitData(VAR arr: ARRAY OF INTEGER; VAR cnt: INTEGER);
BEGIN
  cnt := 0;
  (* Initialize with some sample data *)
  arr[0] := 42;
  arr[1] := 7;
  arr[2] := 91;
  arr[3] := 3;
  arr[4] := 15;
  cnt := 5;
END InitData;

PROCEDURE PrintData(arr: ARRAY OF INTEGER; cnt: INTEGER);
VAR
  i: INTEGER;
BEGIN
  InOut.WriteString("Data: ");
  FOR i := 0 TO cnt - 1 DO
    InOut.WriteInt(arr[i], 4);
    IF i < cnt - 1 THEN
      InOut.WriteString(", ");
    END;
  END;
  InOut.WriteString("\n");
END PrintData;

PROCEDURE BubbleSort(VAR arr: ARRAY OF INTEGER; cnt: INTEGER);
VAR
  i, j, temp: INTEGER;
  swapped: BOOLEAN;
BEGIN
  FOR i := 0 TO cnt - 2 DO
    swapped := FALSE;
    FOR j := 0 TO cnt - 2 - i DO
      IF arr[j] > arr[j+1] THEN
        temp := arr[j];
        arr[j] := arr[j+1];
        arr[j+1] := temp;
        swapped := TRUE;
      END;
    END;
    IF NOT swapped THEN
      EXIT;
    END;
  END;
END BubbleSort;

PROCEDURE FindMax(arr: ARRAY OF INTEGER; cnt: INTEGER): INTEGER;
VAR
  i, max: INTEGER;
BEGIN
  IF cnt = 0 THEN
    RETURN 0;
  END;
  max := arr[0];
  FOR i := 1 TO cnt - 1 DO
    IF arr[i] > max THEN
      max := arr[i];
    END;
  END;
  RETURN max;
END FindMax;

PROCEDURE FilterEven(arr: ARRAY OF INTEGER; cnt: INTEGER; VAR res: ARRAY OF INTEGER; VAR resCnt: INTEGER);
VAR
  i, j: INTEGER;
BEGIN
  resCnt := 0;
  FOR i := 0 TO cnt - 1 DO
    IF arr[i] MOD 2 = 0 THEN
      res[resCnt] := arr[i];
      INC(resCnt);
    END;
  END;
END FilterEven;

BEGIN
  InitData(Data, Count);
  InOut.WriteString("Original Data:\n");
  PrintData(Data, Count);

  BubbleSort(Data, Count);
  InOut.WriteString("Sorted Data:\n");
  PrintData(Data, Count);

  InOut.WriteInt("Max: ", 0);
  InOut.WriteInt(FindMax(Data, Count), 0);
  InOut.WriteString("\n");

  VAR EvenData: ARRAY [0..MaxSize-1] OF INTEGER;
  VAR EvenCount: INTEGER;
  FilterEven(Data, Count, EvenData, EvenCount);
  InOut.WriteString("Even Numbers:\n");
  PrintData(EvenData, EvenCount);

END OrcaDataManipulator.
