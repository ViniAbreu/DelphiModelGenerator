unit U_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Util, FireDAC.Phys.FB, FireDAC.Phys.FBDef, System.StrUtils,
  IniFiles;

type
  TForm1 = class(TForm)
    pnlBody: TPanel;
    pnl1: TPanel;
    pgc1: TPageControl;
    tsSettings: TTabSheet;
    pnl2: TPanel;
    pnl3: TPanel;
    btn1: TButton;
    lbl1: TLabel;
    cbb1: TComboBox;
    grp1: TGroupBox;
    grp2: TGroupBox;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    edtServer: TEdit;
    edtPort: TEdit;
    edtUserName: TEdit;
    edtDataBase: TEdit;
    edtPassword: TEdit;
    btnLoadIni: TButton;
    btnTestCon: TButton;
    dbgrd1: TDBGrid;
    edtDriver: TEdit;
    rb2: TRadioButton;
    rb1: TRadioButton;
    lbl8: TLabel;
    edtDirSave: TEdit;
    btnLoadDB1: TButton;
    chk1: TCheckBox;
    btnLoadDB: TButton;
    FDCon1: TFDConnection;
    procedure btnTestConClick(Sender: TObject);
    procedure FDCon1BeforeConnect(Sender: TObject);
    procedure btnLoadDBClick(Sender: TObject);
    procedure btnLoadIniClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnLoadDBClick(Sender: TObject);
var
  GetDirDB: TOpenDialog;
begin
  GetDirDB := TOpenDialog.Create(nil);
  GetDirDB.Filter := 'Firebird Database | *.fdb;*.fb';
  GetDirDB.Execute; 

  if GetDirDB.FileName <> '' then
    edtDataBase.Text := GetDirDB.FileName;
    
  GetDirDB.Free;
end;

procedure TForm1.btnLoadIniClick(Sender: TObject);
var
  ConfigIni: TIniFile;
  GetFileIni: TOpenDialog;
begin
  GetFileIni := TOpenDialog.Create(nil);
  GetFileIni.Filter := '';
  GetFileIni.Execute;

  if FileExists(GetFileIni.FileName) then
  begin
    
  end;  
end;

procedure TForm1.btnTestConClick(Sender: TObject);
begin
  if MatchText('', [edtDriver.Text, edtServer.Text, edtPort.Text,
    edtDataBase.Text, edtUserName.Text, edtPassword.Text]) then
  begin
    ShowMessage('It is necessary to fill in all connection settings');
    Abort;
  end;
  
  FDCon1.Connected := False;
  FDCon1.Connected := True;
  if FDCon1.Connected then
    ShowMessage('Connected successfully')
  else
    ShowMessage('Connection falied');
end;

procedure TForm1.FDCon1BeforeConnect(Sender: TObject);
begin
  with FDCon1 do
  begin
    Params.Clear;
    Params.Values['DriverID']  := edtDriver.Text;
    Params.Values['Server']    := edtServer.Text;
    Params.Values['Port']      := edtPort.Text;
    Params.Values['Database']  := edtDataBase.Text;
    Params.Values['User_name'] := edtUserName.Text;
    Params.Values['Password']  := edtPassword.Text;
  end;
end;

end.
