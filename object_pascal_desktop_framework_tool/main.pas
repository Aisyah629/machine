program ObjectPascalDesktopFramework;

{$mode objfpc}{$H+}

uses
  Classes, SysUtils, Forms, Dialogs, Controls, StdCtrls, Buttons;

{
  Simple Button class
}

TMyButton = class(TButton)
  constructor Create(AParent: TWinControl);
end;

constructor TMyButton.Create(AParent: TWinControl);
begin
  inherited Create(AParent);
  Caption := 'Click Me';
  Parent := AParent;
 OnClick := @OnClickHandler;
end;

{
  Simple Label class
}

TMyLabel = class(TLabel)
  constructor Create(AParent: TWinControl);
end;

constructor TMyLabel.Create(AParent: TWinControl);
begin
  inherited Create(AParent);
  Caption := 'Hello from Object Pascal!';
  Parent := AParent;
  Top := 10;
  Left := 10;
end;

{
  Main form with event handling
}

type
  TMainForm = class(TForm)
    Label1: TMyLabel;
    Button1: TMyButton;
    procedure Button1Click(Sender: TObject);
  end;

var
  MainForm: TMainForm;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  Label1.Caption := 'Button Clicked!';
end;

{
  Application entry point
}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
