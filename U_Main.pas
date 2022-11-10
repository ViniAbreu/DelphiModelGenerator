unit U_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Util, FireDAC.Phys.FB, FireDAC.Phys.FBDef, System.StrUtils,
  IniFiles, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FileCtrl;

type
  TF_Main = class(TForm)
    pnlBody: TPanel;
    pnl1: TPanel;
    pgc1: TPageControl;
    tsSettings: TTabSheet;
    pnl2: TPanel;
    pnl3: TPanel;
    btn1: TButton;
    lbl1: TLabel;
    cbbTables: TComboBox;
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
    lbl8: TLabel;
    edtDirSave: TEdit;
    btnLoadDB1: TButton;
    btnLoadDB: TButton;
    FDCon1: TFDConnection;
    qryTables: TFDQuery;
    qryFieldsRelation: TFDQuery;
    dsGrid: TDataSource;
    btnConect: TButton;
    qryFieldsRelationTABLE_NAME: TWideStringField;
    qryFieldsRelationFIELD_NAME: TWideStringField;
    qryFieldsRelationFIELD_TYPE: TStringField;
    qryFieldsRelationFIELD_LENGTH: TLargeintField;
    qryFieldsRelationFIELD_IS_PK: TStringField;
    qryFieldsRelationFIELD_IS_FK: TStringField;
    qryFieldsRelationREFERENCES_TABLE: TWideStringField;
    chkGenAllTables: TCheckBox;
    cbbClassType: TComboBox;
    Label1: TLabel;
    procedure btnTestConClick(Sender: TObject);
    procedure FDCon1BeforeConnect(Sender: TObject);
    procedure btnLoadDBClick(Sender: TObject);
    procedure btnLoadIniClick(Sender: TObject);
    procedure btnLoadDB1Click(Sender: TObject);
    procedure btnConectClick(Sender: TObject);
    procedure cbbTablesChange(Sender: TObject);
    procedure chkGenAllTablesClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
    procedure SetParams(DriverId, Server, Port, Database, Username, Password: String);
    procedure LoadData;
    procedure GenPasFile(typeClass: Integer);

  public
    { Public declarations }
  end;

var
  F_Main: TF_Main;

implementation

{$R *.dfm}

procedure TF_Main.btn1Click(Sender: TObject);
begin
  if (cbbClassType.Text = '') then
  begin
    ShowMessage('Choose a method of generate.');
    Abort;
  end;

  if edtDirSave.Text = '' then
  begin
    ShowMessage('A directory is needed to save .pas files.');
    Abort;
  end;

end;

procedure TF_Main.btnConectClick(Sender: TObject);
begin
  if btnConect.Caption = 'Conect' then
  begin
    FDCon1.Connected  := True;
    btnConect.Caption := 'Disconect';
    LoadData;
  end
  else
  begin
    FDCon1.Connected  := False;
    btnConect.Caption := 'Conect';

    cbbTables.Items.Clear;
    cbbTables.Text := '';
  end;
end;

procedure TF_Main.btnLoadDB1Click(Sender: TObject);
var
  sDir: String;
begin
  if SelectDirectory('Select a folder', 'C:\', sDir) then
    edtDirSave.Text := sDir;
end;

procedure TF_Main.btnLoadDBClick(Sender: TObject);
var
  GetDirDB: TOpenDialog;
begin
  GetDirDB := TOpenDialog.Create(nil);
  GetDirDB.Filter := 'Firebird Database | *.fdb;*.fb';
  GetDirDB.Execute; 

  if GetDirDB.FileName <> '' then
    edtDataBase.Text := GetDirDB.FileName;
end;

procedure TF_Main.btnLoadIniClick(Sender: TObject);
var
  ConfigIni: TIniFile;
  GetFileIni: TOpenDialog;
begin
  GetFileIni := TOpenDialog.Create(nil);
  GetFileIni.Filter := 'Ini Files (*.ini)|*.ini';
  GetFileIni.Execute;

  if FileExists(GetFileIni.FileName) then
  begin
    ConfigIni := TIniFile.Create(GetFileIni.FileName);

    edtDriver.Text   := ConfigIni.ReadString('DATABASE', 'DRIVERID', '');
    edtServer.Text   := ConfigIni.ReadString('DATABASE', 'SERVER', '');
    edtPort.Text     := ConfigIni.ReadString('DATABASE', 'PORT', '');
    edtDataBase.Text := ConfigIni.ReadString('DATABASE', 'DATABASE', '');
    edtUserName.Text := ConfigIni.ReadString('DATABASE', 'USERNAME', '');
    edtPassword.Text := ConfigIni.ReadString('DATABASE', 'PASSWORD', '');

    ConfigIni.Free;
  end;
end;

procedure TF_Main.btnTestConClick(Sender: TObject);
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

procedure TF_Main.cbbTablesChange(Sender: TObject);
begin
  qryFieldsRelation.Close;
  qryFieldsRelation.ParamByName('table_name').AsString := cbbTables.Text;
  qryFieldsRelation.Open;
end;

procedure TF_Main.chkGenAllTablesClick(Sender: TObject);
begin
  if chkGenAllTables.Checked then
    cbbTables.Enabled := False
  else
    cbbTables.Enabled := True;
end;

procedure TF_Main.FDCon1BeforeConnect(Sender: TObject);
begin
  SetParams(edtDriver.Text, edtServer.Text, edtPort.Text,
            edtDataBase.Text, edtUserName.Text, edtPassword.Text);
end;

procedure TF_Main.GenPasFile(typeClass: Integer);
begin
  //
end;

procedure TF_Main.LoadData;
begin
  qryTables.Close;
  qryTables.Open;

  cbbTables.Items.Clear;
  cbbTables.Items.Add('');

  while not qryTables.Eof do
  begin
    cbbTables.Items.Add(qryTables.FieldByName('rts_table_name').AsString);
    qryTables.Next;
  end;

  cbbTables.Sorted := True;
  cbbTables.ItemIndex := 1;
  cbbTablesChange(Self);
end;

procedure TF_Main.SetParams(DriverId, Server, Port, Database, Username,
  Password: String);
begin
  with FDCon1 do
  begin
    Params.Clear;
    Params.Values['DriverID']  := DriverId;
    Params.Values['Server']    := Server;
    Params.Values['Port']      := Port;
    Params.Values['Database']  := Database;
    Params.Values['User_name'] := Username;
    Params.Values['Password']  := Password;
  end;
end;

end.
