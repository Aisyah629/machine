PROGRAM CompatibilityLayerTool;

USES
  TextIO,
  Files;

CONST
  ConfigFileName = 'legacy.cfg';
  BufferSize = 256;

TYPE
  RecordTag = INTEGER;
  StringType = PACKED ARRAY[1..64] OF CHAR;
  ConfigRecord = RECORD
    Tag       : RecordTag;
    Name      : StringType;
    Value     : StringType;
    IsNumeric : BOOLEAN;
  END;

VAR
  ConfigFile : FILES.TEXTFILE;
  LineBuffer : ARRAY[1..Buffer_size] OF CHAR;
  CurrentRec : ConfigRecord;
  ValidCount : INTEGER;
  ErrorCount : INTEGER;

PROCEDURE InitializeRecord(VAR Rec : ConfigRecord);
BEGIN
  Rec.Tag := 0;
  Rec.Name := '';
  Rec.Value := '';
  Rec.IsNumeric := FALSE;
END;

FUNCTION IsNumericString(const S : StringType) : BOOLEAN;
VAR
  I       : INTEGER;
  IsDigit : BOOLEAN;
BEGIN
  IsNumericString := FALSE;
  IsDigit := TRUE;
  FOR I := 1 TO 64 DO
  BEGIN
    IF S[I] = #0 THEN
    BEGIN
      IsNumericString := IsDigit;
      EXIT;
    END;
    IF S[I] < '0' OR S[I] > '9' THEN
    BEGIN
      IsDigit := FALSE;
    END;
  END;
END;

PROCEDURE ValidateRecord(VAR Rec : ConfigRecord);
BEGIN
  InitializeRecord(Rec);
  
  { Simulate parsing logic }
  Rec.Tag := 1001;
  Rec.Name := 'DatabaseHost';
  Rec.Value := '192.168.1.50';
  
  IF IsNumericString(Rec.Value) THEN
  BEGIN
    Rec.IsNumeric := TRUE;
  END
  ELSE
  BEGIN
    Rec.IsNumeric := FALSE;
  END;
  
  IF Rec.Name = '' THEN
  BEGIN
    ErrorCount := ErrorCount + 1;
  END
  ELSE
  BEGIN
    ValidCount := ValidCount + 1;
  END;
END;

BEGIN
  ValidCount := 0;
  ErrorCount := 0;
  
  WriteLn('UCSD Pascal Compatibility Layer Initializing...');
  
  { Try to open the legacy config file } 
  ASSIGN(ConfigFile, ConfigFileName);
  RESET(ConfigFile);
  
  IF IOStat = 0 THEN
  BEGIN
    WriteLn('Legacy configuration file opened successfully.');
    
    WHILE NOT EOF(ConfigFile) DO
    BEGIN
      VALIDATE_RECORD(CurrentRec);
    END;
    
    Close(ConfigFile);
  END
  ELSE
  BEGIN
    WriteLn('Warning: Legacy configuration file not found or unreadable.');
    WriteLn('Proceeding with default validation simulation.');
    
    { Perform default validation if file is missing } 
    ValidateRecord(CurrentRec);
  END;
  
  WriteLn('Validation Complete.');
  WriteLn('Valid Records : ', ValidCount);
  WriteLn('Error Records : ', ErrorCount);
END.
