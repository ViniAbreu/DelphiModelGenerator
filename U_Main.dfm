object F_Main: TF_Main
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  ClientHeight = 359
  ClientWidth = 1055
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Reference Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object pnlBody: TPanel
    Left = 0
    Top = 0
    Width = 1055
    Height = 359
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 1084
    ExplicitHeight = 421
    object pnl1: TPanel
      Left = 0
      Top = 0
      Width = 321
      Height = 359
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitHeight = 421
      object pgc1: TPageControl
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 315
        Height = 353
        ActivePage = tsSettings
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 4
        ExplicitTop = 4
        ExplicitWidth = 313
        ExplicitHeight = 413
        object tsSettings: TTabSheet
          Caption = 'Settings'
          ExplicitWidth = 305
          ExplicitHeight = 383
          object grp1: TGroupBox
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 301
            Height = 230
            Align = alTop
            Caption = ' DataBase '
            TabOrder = 0
            ExplicitWidth = 299
            object lbl2: TLabel
              Left = 11
              Top = 20
              Width = 36
              Height = 15
              Caption = 'Driver'
            end
            object lbl3: TLabel
              Left = 11
              Top = 107
              Width = 55
              Height = 15
              Caption = 'DataBase'
            end
            object lbl4: TLabel
              Left = 11
              Top = 136
              Width = 58
              Height = 15
              Caption = 'Username'
            end
            object lbl5: TLabel
              Left = 11
              Top = 165
              Width = 54
              Height = 15
              Caption = 'Password'
            end
            object lbl6: TLabel
              Left = 11
              Top = 49
              Width = 39
              Height = 15
              Caption = 'Server'
            end
            object lbl7: TLabel
              Left = 11
              Top = 78
              Width = 23
              Height = 15
              Caption = 'Port'
            end
            object edtServer: TEdit
              Left = 80
              Top = 46
              Width = 209
              Height = 23
              TabOrder = 0
              Text = '127.0.0.1'
            end
            object edtPort: TEdit
              Left = 80
              Top = 75
              Width = 209
              Height = 23
              TabOrder = 1
              Text = '3050'
            end
            object edtUserName: TEdit
              Left = 80
              Top = 133
              Width = 209
              Height = 23
              TabOrder = 2
              Text = 'SYSDBA'
            end
            object edtDataBase: TEdit
              Left = 80
              Top = 104
              Width = 180
              Height = 23
              TabOrder = 3
            end
            object edtPassword: TEdit
              Left = 80
              Top = 162
              Width = 209
              Height = 23
              TabOrder = 4
              Text = 'masterkey'
            end
            object btnLoadIni: TButton
              Left = 11
              Top = 191
              Width = 65
              Height = 25
              Caption = 'Load Ini'
              TabOrder = 5
              OnClick = btnLoadIniClick
            end
            object btnTestCon: TButton
              Left = 90
              Top = 191
              Width = 110
              Height = 25
              Caption = 'Test Connection'
              TabOrder = 6
              OnClick = btnTestConClick
            end
            object edtDriver: TEdit
              Left = 80
              Top = 17
              Width = 209
              Height = 23
              TabOrder = 7
              Text = 'FB'
            end
            object btnLoadDB: TButton
              Left = 266
              Top = 104
              Width = 23
              Height = 23
              Caption = '...'
              TabOrder = 8
              OnClick = btnLoadDBClick
            end
            object btnConect: TButton
              Left = 214
              Top = 191
              Width = 75
              Height = 25
              Caption = 'Conect'
              TabOrder = 9
              OnClick = btnConectClick
            end
          end
          object grp2: TGroupBox
            AlignWithMargins = True
            Left = 3
            Top = 239
            Width = 301
            Height = 82
            Align = alTop
            Caption = ' General '
            TabOrder = 1
            ExplicitWidth = 299
            object lbl8: TLabel
              Left = 11
              Top = 50
              Width = 50
              Height = 15
              Caption = 'Save Dir'
            end
            object Label1: TLabel
              Left = 11
              Top = 21
              Width = 63
              Height = 15
              Caption = 'Type Class'
            end
            object edtDirSave: TEdit
              Left = 80
              Top = 47
              Width = 180
              Height = 23
              TabOrder = 0
            end
            object btnLoadDB1: TButton
              Left = 266
              Top = 47
              Width = 23
              Height = 23
              Caption = '...'
              TabOrder = 1
              OnClick = btnLoadDB1Click
            end
            object cbbClassType: TComboBox
              Left = 80
              Top = 18
              Width = 209
              Height = 23
              TabOrder = 2
              Items.Strings = (
                'Class Default'
                'Class Model ORM')
            end
          end
        end
      end
    end
    object pnl2: TPanel
      Left = 321
      Top = 0
      Width = 734
      Height = 359
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitWidth = 763
      ExplicitHeight = 421
      object pnl3: TPanel
        Left = 0
        Top = 0
        Width = 734
        Height = 29
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitLeft = 1
        ExplicitTop = 1
        ExplicitWidth = 761
        object lbl1: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 71
          Height = 23
          Align = alLeft
          Caption = 'Chose Table'
          Layout = tlCenter
          ExplicitHeight = 15
        end
        object btn1: TButton
          AlignWithMargins = True
          Left = 657
          Top = 1
          Width = 75
          Height = 27
          Margins.Left = 2
          Margins.Top = 1
          Margins.Right = 2
          Margins.Bottom = 1
          Align = alRight
          Caption = 'Generate'
          TabOrder = 0
          OnClick = btn1Click
          ExplicitLeft = 684
        end
        object cbbTables: TComboBox
          AlignWithMargins = True
          Left = 80
          Top = 3
          Width = 416
          Height = 23
          Align = alClient
          TabOrder = 1
          OnChange = cbbTablesChange
          ExplicitWidth = 443
        end
        object chkGenAllTables: TCheckBox
          AlignWithMargins = True
          Left = 502
          Top = 3
          Width = 150
          Height = 23
          Align = alRight
          Caption = 'Generate for all tables'
          TabOrder = 2
          OnClick = chkGenAllTablesClick
          ExplicitLeft = 529
        end
      end
      object dbgrd1: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 32
        Width = 728
        Height = 303
        Align = alClient
        DataSource = dsFields
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Reference Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'FIELD_NAME'
            Title.Alignment = taCenter
            Title.Caption = 'Name'
            Width = 180
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FIELD_TYPE'
            Title.Alignment = taCenter
            Title.Caption = 'Type'
            Width = 125
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FIELD_LENGTH'
            Title.Alignment = taCenter
            Title.Caption = 'Length'
            Width = 65
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FIELD_IS_PK'
            Title.Alignment = taCenter
            Title.Caption = 'PrimaryKey'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FIELD_IS_FK'
            Title.Alignment = taCenter
            Title.Caption = 'ForeignKey'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'REFERENCES_TABLE'
            Title.Alignment = taCenter
            Title.Caption = 'Reference Table'
            Width = 160
            Visible = True
          end>
      end
      object pnl4: TPanel
        Left = 0
        Top = 338
        Width = 734
        Height = 21
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        Visible = False
        ExplicitTop = 369
        ExplicitWidth = 763
        object pbGenProcess: TProgressBar
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 728
          Height = 15
          Align = alClient
          TabOrder = 0
          ExplicitLeft = 28
          ExplicitWidth = 525
        end
      end
    end
  end
  object FDCon1: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Server=127.0.0.1'
      'DriverID=FB')
    LoginPrompt = False
    BeforeConnect = FDCon1BeforeConnect
    Left = 416
    Top = 240
  end
  object qryTables: TFDQuery
    Connection = FDCon1
    SQL.Strings = (
      'select rts.rdb$relation_name as rts_table_name'
      'from rdb$relations rts'
      'where rts.rdb$system_flag = 0 ')
    Left = 480
    Top = 216
    object qryTablesRTS_TABLE_NAME: TWideStringField
      FieldName = 'RTS_TABLE_NAME'
      Origin = 'RDB$RELATION_NAME'
      FixedChar = True
      Size = 31
    end
  end
  object qryFieldsRelation: TFDQuery
    Connection = FDCon1
    SQL.Strings = (
      'with'
      'fk as ('
      '    select i.rdb$relation_name as table_name,'
      '           s.rdb$field_name as field_name,'
      '           i2.rdb$relation_name as references_table,'
      '           s2.rdb$field_name as references_field'
      '    from rdb$index_segments s'
      '    left join rdb$indices i on'
      '    i.rdb$index_name = s.rdb$index_name'
      '    left join rdb$relation_constraints rc on'
      '    rc.rdb$index_name = s.rdb$index_name'
      '    left join rdb$ref_constraints refc on'
      '    rc.rdb$constraint_name = refc.rdb$constraint_name'
      '    left join rdb$relation_constraints rc2 on'
      '    rc2.rdb$constraint_name = refc.rdb$const_name_uq'
      '    left join rdb$indices i2 on'
      '    i2.rdb$index_name = rc2.rdb$index_name'
      '    left join rdb$index_segments s2 on'
      '    i2.rdb$index_name = s2.rdb$index_name'
      '    where rc.rdb$constraint_type = '#39'FOREIGN KEY'#39
      '    order by s.rdb$field_position  '
      ')'
      'select rf.rdb$relation_name as table_name,'
      '       rf.rdb$field_name as field_name,'
      '       case f.rdb$field_type'
      '           when 7 then '#39'SMALLINT'#39
      '           when 8 then '#39'INTEGER'#39
      '           when 10 then '#39'FLOAT'#39
      '           when 12 then '#39'DATE'#39
      '           when 13 then '#39'TIME'#39
      '           when 14 then '#39'CHAR'#39
      '           when 16 then '#39'BIGINT'#39
      '           when 27 then '#39'DOUBLE PRECISION'#39
      '           when 35 then '#39'TIMESTAMP'#39
      '           when 37 then '#39'VARCHAR'#39
      
        '           when 261 then '#39'BLOB'#39' || iif(f.rdb$field_sub_type = 0,' +
        ' '#39' BINARY'#39', '#39'TEXT'#39')'
      '           else '#39#39
      '       end as field_type,'
      
        '       iif(f.rdb$field_type in (14, 37), (trunc(f.rdb$field_leng' +
        'th / ch.rdb$bytes_per_character)), 0) as field_length,'
      '       iif(ix.rdb$index_name <> '#39#39', '#39'Yes'#39', '#39#39') as field_is_pk,'
      '       iif(fk.table_name is null, '#39#39', '#39'Yes'#39') as field_is_fk,'
      '       fk.references_table'
      'from rdb$relation_fields rf '
      'inner join rdb$fields f on'
      'f.rdb$field_name = rf.rdb$field_source'
      'left join rdb$indices ix on'
      'ix.rdb$relation_name = rf.rdb$relation_name and'
      'ix.rdb$index_id = rf.rdb$field_position +1 and'
      'ix.rdb$foreign_key is null                '
      'left outer join rdb$character_sets ch on'
      'ch.rdb$character_set_id = f.rdb$character_set_id'
      'left join fk on'
      'fk.table_name = rf.rdb$relation_name and'
      'fk.field_name = rf.rdb$field_name'
      'where rf.rdb$relation_name = Upper(:table_name)'
      'order by rf.rdb$field_position')
    Left = 480
    Top = 272
    ParamData = <
      item
        Name = 'TABLE_NAME'
        DataType = ftString
        ParamType = ptInput
      end>
    object qryFieldsRelationTABLE_NAME: TWideStringField
      FieldName = 'TABLE_NAME'
      Origin = 'RDB$RELATION_NAME'
      FixedChar = True
      Size = 31
    end
    object qryFieldsRelationFIELD_NAME: TWideStringField
      FieldName = 'FIELD_NAME'
      Origin = 'RDB$FIELD_NAME'
      FixedChar = True
      Size = 31
    end
    object qryFieldsRelationFIELD_TYPE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'FIELD_TYPE'
      Origin = 'FIELD_TYPE'
      ProviderFlags = []
      ReadOnly = True
      Size = 16
    end
    object qryFieldsRelationFIELD_LENGTH: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'FIELD_LENGTH'
      Origin = 'FIELD_LENGTH'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryFieldsRelationFIELD_IS_PK: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'FIELD_IS_PK'
      Origin = 'FIELD_IS_PK'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 3
    end
    object qryFieldsRelationFIELD_IS_FK: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'FIELD_IS_FK'
      Origin = 'FIELD_IS_FK'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 3
    end
    object qryFieldsRelationREFERENCES_TABLE: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'REFERENCES_TABLE'
      Origin = 'RDB$RELATION_NAME'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 31
    end
  end
  object dsFields: TDataSource
    DataSet = qryFieldsRelation
    Left = 544
    Top = 240
  end
end
