program PascalInteractiveDiagnostic;

{$mode objfpc}{$H+}

uses
  SysUtils, Classes, StrUtils;

type
  TToken = record
    Case Kind: TTokenType Of
      tokKeyword: (Name: String);
      tokIdentifier: (Name: String);
      tokNumber: (Value: Double);
      tokString: (Value: String);
      tokSymbol: (Symbol: Char);
  end;

  TDiagnosticResult = record
    Severity: TSeverity;
    Message: String;
    Line: Integer;
  end;

var
  Results: TList<TDiagnosticResult>;

procedure AnalyzeInput(const Input: String);
var
  Tokens: TStringList;
  i: Integer;
  Result: TDiagnosticResult;
begin
  Results := TList<TDiagnosticResult>.Create;
  Tokens := TStringList.Create;
  try
    Tokens.Delimiter := ' ';
    Tokens.DelimitedText := Input;
    
    for i := 0 to Tokens.Count - 1 do
    begin
      if Length(Tokens[i]) = 0 then Continue;
      
      // Simple syntax checks
      if Tokens[i] = 'end.' then
      begin
        if (i <> Tokens.Count - 1) then
        begin
          Result.Severity := sevError;
          Result.Message := 'Unexpected tokens after ''end.''';
          Result.Line := i + 1;
          Results.Add(Result);
        end
      end
      else if Tokens[i][1] = ''' then
        if (Tokens[i][Length(Tokens[i])] <> '''') and (Length(Tokens[i]) > 1) then
        begin
          Result.Severity := sevWarning;
          Result.Message := 'Unterminated string literal';
          Result.Line := i + 1;
          Results.Add(Result);
        end;
    end;
    
    // Add dummy results if nothing was found
    if Results.Count = 0 then
    begin
      Result.Severity := sevInfo;
      Result.Message := 'Analysis complete. No syntax errors found.';
      Result.Line := 0;
      Results.Add(Result);
    end;
    
    PrintResults;
  finally
    Tokens.Free;
  end;
end;

procedure PrintResults;
var
  R: TDiagnosticResult;
  i: Integer;
begin
  WritelnLn('--- Diagnostic Results ---');
  for i := 0 to Results.Count - 1 do
  begin
    R := Results[i];
    Writeln(SeverityToString(R.Severity), ': ', R.Message, ' (Line ', IntToStr(R.Line), ')');
  end;
  WritelnLn('--------------------------');
end;

function SeverityToString(Severity: TSeverity): String;
begin
  Case Severity Of
    sevInfo: Result := '[INFO]';
    sevWarning: Result := '[WARNING]';
    sevError: Result := '[ERROR]';
  End;
end;

procedure RunInteractive;
var
  Input: String;
begin
  WritelnLn('Pascal Interactive Diagnostic Tool v1.0');
  WritelnLn('Type code snippets or "exit" to quit.');
  WritelnLn;
  
  Repeat
    WriteLn('Pascal > ');
    ReadLn(Input);
    Input := Trim(Input);
    if LowerCase(Input) = 'exit' then Break;
    if Input <> '' then
    begin
      AnalyzeInput(Input);
    end;
  Until False;
  
  Results.Free;
end;

begin
  RunInteractive;
end.
