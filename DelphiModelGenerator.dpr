program DelphiModelGenerator;

uses
  Vcl.Forms,
  U_Main in 'U_Main.pas' {F_Main},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TF_Main, F_Main);
  Application.Run;
end.
