program Main;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  System.Classes,
  System.IOUtils;

var
  DataFile: string;
begin
  try
    // Check for command line arguments
    if ParamCount < 1 then
    begin
      Writeln('Usage: Main.exe <data_file>');
      exit;
    end;

    DataFile := ParamStr(1);

    if not FileExists(DataFile) then
    begin
      Writeln('Error: File not found - ', DataFile);
      exit;
    end;

    // Simulate data processing
    Writeln('Processing data file: ', DataFile);
    ProcessData(DataFile);
    Writeln('Data processing complete.');
  except
    on E: Exception do
      Writeln('Exception: ', E.ClassName, ': ', E.Message);
  end;
end;

procedure ProcessData(const FileName: string);
var
  Lines: TStrings;
  I: Integer;
begin
  Lines := TStringList.Create;
  try
    Lines.LoadFromFile(FileName);
    for I := 0 to Lines.Count - 1 do
    begin
      // Process each line
      Writeln('Processing line ', I + 1, ': ', Lines[I]);
      // Add custom processing logic here
    end;
  finally
    Lines.Free;
  end;
end;
