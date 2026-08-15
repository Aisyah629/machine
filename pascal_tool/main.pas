program TextFormatter;

{
  This program implements a text formatting and beautification utility.
  It reads input from standard input or a file, performs basic formatting,
  and outputs the result to standard output.
  Built strictly using the Pascal programming language.
}

uses
  SysUtils, Classes;

var
  InputLines: TStringList;
  OutputLines: TStringList;
  i, j: Integer;
  CurrentLine: string;
  IndentLevel: Integer;
  TempChar: Char;
begin
  InputLines := TStringList.Create;
  OutputLines := TStringList.Create;
  IndentLevel := 0;

  try
    {
      Read all lines from stdin or a specified file.
      For simplicity in this standalone utility, we read from stdin.
    }
    while not Eof do
    begin
      ReadLn(CurrentLine);
      InputLines.Add(CurrentLine);
    end;

    {
      Process each line to format it.
      We'll demonstrate basic indentation and line joining.
    }
    for i := 0 to InputLines.Count - 1 do
    begin
      CurrentLine := Trim(InputLines[i]);

      {
        Simple heuristic formatting: handle indentation tokens.
        This is a basic demonstration of Pascal string manipulation.
      }
      if Pos('begin', LowerCase(CurrentLine)) > 0 then
      begin
        IndentLevel := IndentLevel + 1;
        CurrentLine := StringOfChar(' ', IndentLevel * 2) + CurrentLine;
        OutputLines.Add(CurrentLine);
        Continue;
      end;

      if Pos('end', LowerCase(CurrentLine)) > 0 then
      begin
        if IndentLevel > 0 then
          IndentLevel := IndentLevel - 1;
        CurrentLine := StringOfChar(' ', IndentLevel * 2) + CurrentLine;
        OutputLines.Add(CurrentLine);
        Continue;
      end;

      {
        Standard line: just apply current indentation.
      }
      CurrentLine := StringOfChar(' ', IndentLevel * 2) + CurrentLine;
      OutputLines.Add(CurrentLine);
    end;

    {
      Write the formatted output to stdout.
    }
    for i := 0 to OutputLines.Count - 1 do
    begin
      Writeln(OutputLines[i]);
    end;

  finally
    InputLines.Free;
    OutputLines.Free;
  end;
end.
