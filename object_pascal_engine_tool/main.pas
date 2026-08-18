program ObjectPascalEngine;

{$MODE OBJFPC}
{$H+}

{
  Object Pascal Engine: A strict type-checking engine for legacy Pascal applications.
  This tool performs static analysis on Object Pascal source code to enforce type safety.
}

uses
  SysUtils,
  Classes,
  StrUtils;

type
  TTypeCheckResult = (tcrSuccess, tcrWarning, tcrError);

  TTypeIssue = class
  private
    FLineNumber: Integer;
    FMessage: String;
    FSeverity: TTypeCheckResult;
  public
    constructor Create(LineNumber: Integer; const Message: String; Severity: TTypeCheckResult);
    property LineNumber: Integer read FLineNumber;
    property Message: String read FMessage;
    property Severity: TTypeCheckResult read FSeverity;
  end;

  TObjectPascalEngine = class
  private
    FIssues: TObjectList<TTypeIssue>;
    procedure AnalyzeFile(const FileName: String);
    procedure ParseTypeDeclaration(const Line: String; LineNum: Integer);
    procedure ParseVariableDeclaration(const Line: String; LineNum: Integer);
    procedure ParseAssignment(const Line: String; LineNum: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Run(const FileName: String);
    procedure Report;
  end;

constructor TTypeIssue.Create(LineNumber: Integer; const Message: String; Severity: TTypeCheckResult);
begin
  inherited Create;
  FLineNumber := LineNumber;
  FMessage := Message;
  FSeverity := Severity;
end;

constructor TObjectPascalEngine.Create;
begin
  inherited Create;
  FIssues := TObjectList<TTypeIssue>.Create(True); { Owns objects }
end;

destructor TObjectPascalEngine.Destroy;
begin
  FIssues.Free;
  inherited Destroy;
end;

procedure TObjectPascalEngine.AnalyzeFile(const FileName: String);
var
  SourceFile: TStringList;
  I: Integer;
  Line: String;
begin
  if not FileExists(FileName) then
  begin
    Writeln('Error: File not found: ', FileName);
    Exit;
  end;

  SourceFile := TStringList.Create;
  try
    SourceFile.LoadFromFile(FileName);
    for I := 0 to SourceFile.Count - 1 do
    begin
      Line := Trim(SourceFile[I]);
      // Simple heuristic-based parsing for demonstration
      if Pos('Type ', Line) > 0 then
        ParseTypeDeclaration(Line, I + 1);
      if Pos(':', Line) > 0 then
        ParseVariableDeclaration(Line, I + 1);
      if Pos(':=', Line) > 0 then
        ParseAssignment(Line, I + 1);
    end;
  finally
    SourceFile.Free;
  end;
end;

procedure TObjectPascalEngine.ParseTypeDeclaration(const Line: String; LineNum: Integer);
begin
  // Example: Type TMyRecord = Record ... End;
  // This is a simplified check. Real parsing requires a full lexer/parser.
  Writeln('[INFO] Found type declaration at line ', LineNum);
end;

procedure TObjectPascalEngine.ParseVariableDeclaration(const Line: String; LineNum: Integer);
var
  Parts: TArray<String>;
  I: Integer;
begin
  // Example: var x: Integer; y: String;
  Parts := SplitString(Line, ':');
  if Length(Parts) >= 2 then
  begin
    Writeln('[INFO] Found variable declaration at line ', LineNum, ': ', Parts[1]);
    // In a real engine, we would check if the type is valid, etc.
  end;
end;

procedure TObjectPascalEngine.ParseAssignment(const Line: String; LineNum: Integer);
var
  Parts: TArray<String>;
begin
  // Example: x := 5;
  Parts := SplitString(Line, ':=');
  if Length(Parts) >= 2 then
  begin
    Writeln('[INFO] Found assignment at line ', LineNum);
    // In a real engine, we would check type compatibility between LHS and RHS
  end;
end;

procedure TObjectPascalEngine.Run(const FileName: String);
begin
  FIssues.Clear;
  Writeln('Starting type check on: ', FileName);
  AnalyzeFile(FileName);
end;

procedure TObjectPascalEngine.Report;
var
  Issue: TTypeIssue;
  S: String;
begin
  Writeln('--- Type Check Report ---');
  for Issue in FIssues do
  begin
    case Issue.Severity of
      tcrSuccess: S := 'OK';
      tcrWarning: S := 'Warning';
      tcrError: S := 'Error';
    end;
    Writeln(Format('[%s] Line %d: %s', [S, Issue.LineNumber, Issue.Message]));
  end;
  Writeln('Total Issues: ', FIssues.Count);
end;

var
  Engine: TObjectPascalEngine;
  FileName: String;
begin
  if ParamCount < 1 then
  begin
    Writeln('Usage: ObjectPascalEngineTool <filename.pas>');
    Halt(1);
  end;

  FileName := ParamStr(1);
  Engine := TObjectPascalEngine.Create;
  try
    Engine.Run(FileName);
    Engine.Report;
  finally
    Engine.Free;
  end;
end.
