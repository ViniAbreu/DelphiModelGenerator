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
  FireDAC.Comp.DataSet, FileCtrl, System.Types, Vcl.Mask, Vcl.DBCtrls, System.Diagnostics,
  System.TimeSpan;

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
    dsFields: TDataSource;
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
    pnl4: TPanel;
    pbGenProcess: TProgressBar;
    qryTablesRTS_TABLE_NAME: TWideStringField;
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
    procedure GenPasFile(typeClass: Integer; sTableName: string);
    function FirstCharUpperCasse(str: string): string;
    function GetFieldType(fieldType: string): string;
  public
    { Public declarations }
  end;

var
  F_Main: TF_Main;

implementation

{$R *.dfm}

procedure TF_Main.btn1Click(Sender: TObject);
var
  Stopwatch: TStopwatch;
  Elapsed: TTimeSpan;
  Seconds: Double;
begin
  if not (FDCon1.Connected) then
  begin
    ShowMessage('Connection falied');
    Abort;
  end;

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

  qryFieldsRelation.DisableControls;
  if chkGenAllTables.Checked then
  begin
    qryTables.First;

    pbGenProcess.Position := 0;
    pbGenProcess.Max      := qryTables.RecordCount;
    pnl4.Visible := True;

    Stopwatch := TStopwatch.StartNew;
    while not qryTables.Eof do
    begin
      GenPasFile(cbbClassType.ItemIndex,
        FirstCharUpperCasse(qryTables.FieldByName('rts_table_name').AsString));
      qryTables.Next;
      pbGenProcess.Position := pbGenProcess.Position + 1;
    end;
    Elapsed := Stopwatch.Elapsed;
    Seconds := Elapsed.TotalSeconds;
    ShowMessage(Format('Generating %s pas files in %n seconds.',
        [IntToStr(qryTables.RecordCount),  Seconds]));
  end
  else
    GenPasFile(cbbClassType.ItemIndex, FirstCharUpperCasse(cbbTables.Text));
  qryFieldsRelation.EnableControls;
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

function TF_Main.FirstCharUpperCasse(str: string): string;
var
  field_names: TStringDynArray;
  i: Integer;
  strAux:string;
begin
  if ((str <> '') and (ContainsStr(str, '_'))) then
  begin
    field_names := SplitString(str, '_');
    for i := 0 to Length(field_names) - 1 do
    begin
      strAux := strAux + UpperCase(Copy(field_names[i], 1, 1)) +
                         LowerCase(Copy(field_names[i], 2, Length(field_names[i])));
    end;
    Result := strAux;
  end
  else
    Result := UpperCase(Copy(str,1,1)) + LowerCase(Copy(str,2,Length(str)));
end;

procedure TF_Main.GenPasFile(typeClass: Integer; sTableName: string);
var
  pasEditor: TMemo;
  sOldFilter, sTColumnLine, sPropertyLine,
  sFieldName, sSaveDir, sIsPk_Fk: String;
begin
  sTColumnLine  := '    [TColumn(''%s'', ''%s'', %d, %s)]';
  sPropertyLine := '    property %s: %s read F%s write F%s;';

  pasEditor := TMemo.Create(nil);
  pasEditor.Parent := Application.MainForm;
  pasEditor.Visible := False;

  qryFieldsRelation.Close;
  qryFieldsRelation.ParamByName('table_name').AsString :=
    qryTables.FieldByName('rts_table_name').AsString;
  qryFieldsRelation.Open;

  if typeClass = 1 then
  begin
    pasEditor.Lines.Add(Format('unit Model.%s;' + #13#10, [sTableName]));
    pasEditor.Lines.Add('interface' + #13#10 + #13#10 + 'uses ORM;' + #13#10 + #13#10 + 'type');
    pasEditor.Lines.Add(Format('  [TTable(''%s'')]', [sTableName]));

    sOldFilter := qryTables.Filter;
    qryFieldsRelation.Filtered := True;
    qryFieldsRelation.Filter   := ' FIELD_IS_PK = ''Yes''';

    if qryFieldsRelation.RecordCount >= 1 then
    begin
      qryFieldsRelation.First;
      while not qryFieldsRelation.Eof do
      begin
        pasEditor.Lines.Add(Format('  [TPrimaryKey(''%s'', ''%s'', ''%d'', True)]',
          [LowerCase(qryFieldsRelation.FieldByName('field_name').AsString),
           LowerCase(qryFieldsRelation.FieldByName('field_type').AsString),
           qryFieldsRelation.FieldByName('field_length').AsInteger]));

        qryFieldsRelation.Next;
      end;
    end;

    qryFieldsRelation.Filter := sOldFilter;
    pasEditor.Lines.Add(Format('  T%s = class(TORMObject<T%s>', [sTableName, sTableName]));
  end
  else
  begin
    pasEditor.Lines.Add(Format('unit %s;' + #13#10, [sTableName]));
    pasEditor.Lines.Add('interface' + #13#10 + #13#10 + 'type');
    pasEditor.Lines.Add(Format('  T%s = class', [sTableName]))
  end;

  pasEditor.Lines.Add('  private' + #13#10 + '    { Private Declarations }');

  qryFieldsRelation.First;
  while not qryFieldsRelation.Eof do
  begin
    if qryFieldsRelation.FieldByName('field_is_fk').AsString = 'Yes' then
    begin
      pasEditor.Lines.Add(Format('    F%s: %s;',
        [FirstCharUpperCasse(qryFieldsRelation.FieldByName('field_name').AsString),
         'T' + FirstCharUpperCasse(qryFieldsRelation.FieldByName('references_table').AsString)]));
    end
    else
    begin
      pasEditor.Lines.Add(Format('    F%s: %s;',
        [FirstCharUpperCasse(qryFieldsRelation.FieldByName('field_name').AsString),
         GetFieldType(qryFieldsRelation.FieldByName('field_type').AsString)]));
    end;
    qryFieldsRelation.Next;
  end;

  pasEditor.Lines.Add('  public' + #13#10 + '    { Public Declarations }');

  qryFieldsRelation.First;
  while not qryFieldsRelation.Eof do
  begin
    sFieldName := FirstCharUpperCasse(qryFieldsRelation.FieldByName('field_name').AsString);

    if typeClass = 1 then
    begin
      sIsPk_Fk := '';
      if qryFieldsRelation.FieldByName('field_is_pk').AsString = 'Yes' then
        sIsPk_Fk := 'True'
      else if qryFieldsRelation.FieldByName('field_is_fk').AsString = 'Yes' then
        sIsPk_Fk := 'True';

      pasEditor.Lines.Add(Format(sTColumnLine,
          [LowerCase(sFieldName),
           LowerCase(GetFieldType(qryFieldsRelation.FieldByName('field_type').AsString)),
           qryFieldsRelation.FieldByName('field_length').AsInteger, sIsPk_Fk]));

      if sIsPk_Fk = '' then
      begin
        pasEditor.Lines[pasEditor.Lines.Count-1] :=
            StringReplace(pasEditor.Lines[pasEditor.Lines.Count-1], ', )]', ')]', [rfReplaceAll]);
      end;
    end;

    pasEditor.Lines.Add(Format(sPropertyLine,
      [sFieldName, GetFieldType(qryFieldsRelation.FieldByName('field_type').AsString),
       sFieldName, sFieldName]));
    qryFieldsRelation.Next;
  end;
  pasEditor.Lines.Add('  end;' + #13#10);
  pasEditor.Lines.Add(Format('implementation' + #13#10 + #13#10 + '{ T%s }' + #13#10, [sTableName]));
  pasEditor.Lines.Add('end.');

  if typeClass = 1 then
    sSaveDir := Format('%s\%s.%s.pas', [edtDirSave.Text, 'Model', sTableName])
  else
    sSaveDir := Format('%s\%s.pas', [edtDirSave.Text, sTableName]);

  pasEditor.Lines.SaveToFile(sSaveDir);
end;

function TF_Main.GetFieldType(fieldType: string): string;
begin
  FieldType := UpperCase(FieldType);

  if MatchStr(FieldType, ['INTEGER','SMALLINT','BIGINT']) then
    Result := 'Integer'
  else if MatchStr(FieldType, ['FLOAT','DOUBLE PRECISION','NUMERIC','DECIMAL']) then
    Result := 'Double'
  else if MatchStr(FieldType, ['DATE','TIME','TIMESTAMP']) then
    Result := 'TDateTime'
  else if MatchStr(FieldType, ['CHAR','VARCHAR']) then
    Result := 'String'
  else if FieldType = 'BLOB' then
    Result := 'BlobStream';
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
