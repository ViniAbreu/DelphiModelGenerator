object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  ClientHeight = 421
  ClientWidth = 966
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
    Width = 966
    Height = 421
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnl1: TPanel
      Left = 0
      Top = 0
      Width = 305
      Height = 421
      Align = alLeft
      Caption = 'pnl1'
      TabOrder = 0
      object pgc1: TPageControl
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 297
        Height = 413
        ActivePage = tsSettings
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 254
        object tsSettings: TTabSheet
          Caption = 'Settings'
          ExplicitWidth = 246
          object grp1: TGroupBox
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 283
            Height = 230
            Align = alTop
            Caption = ' DataBase '
            TabOrder = 0
            ExplicitWidth = 240
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
              Left = 76
              Top = 46
              Width = 197
              Height = 23
              TabOrder = 0
              Text = '127.0.0.1'
            end
            object edtPort: TEdit
              Left = 76
              Top = 75
              Width = 197
              Height = 23
              TabOrder = 1
              Text = '3050'
            end
            object edtUserName: TEdit
              Left = 76
              Top = 133
              Width = 197
              Height = 23
              TabOrder = 2
              Text = 'SYSDBA'
            end
            object edtDataBase: TEdit
              Left = 76
              Top = 104
              Width = 168
              Height = 23
              TabOrder = 3
            end
            object edtPassword: TEdit
              Left = 76
              Top = 162
              Width = 197
              Height = 23
              TabOrder = 4
              Text = 'masterkey'
            end
            object btnLoadIni: TButton
              Left = 11
              Top = 191
              Width = 94
              Height = 25
              Caption = 'Load Ini'
              TabOrder = 5
              OnClick = btnLoadIniClick
            end
            object btnTestCon: TButton
              Left = 159
              Top = 191
              Width = 114
              Height = 25
              Caption = 'Test Connection'
              TabOrder = 6
              OnClick = btnTestConClick
            end
            object edtDriver: TEdit
              Left = 76
              Top = 17
              Width = 197
              Height = 23
              TabOrder = 7
              Text = 'FB'
            end
            object btnLoadDB: TButton
              Left = 250
              Top = 104
              Width = 23
              Height = 23
              Caption = '...'
              TabOrder = 8
              OnClick = btnLoadDBClick
            end
          end
          object grp2: TGroupBox
            AlignWithMargins = True
            Left = 3
            Top = 239
            Width = 283
            Height = 141
            Align = alClient
            Caption = ' General '
            TabOrder = 1
            ExplicitWidth = 240
            object lbl8: TLabel
              Left = 11
              Top = 73
              Width = 50
              Height = 15
              Caption = 'Save Dir'
            end
            object rb2: TRadioButton
              Left = 133
              Top = 24
              Width = 140
              Height = 17
              Caption = 'Generate Model ORM'
              TabOrder = 0
            end
            object rb1: TRadioButton
              Left = 11
              Top = 24
              Width = 113
              Height = 17
              Caption = 'Generate Class'
              TabOrder = 1
            end
            object edtDirSave: TEdit
              Left = 76
              Top = 70
              Width = 168
              Height = 23
              TabOrder = 2
            end
            object btnLoadDB1: TButton
              Left = 250
              Top = 70
              Width = 23
              Height = 23
              Caption = '...'
              TabOrder = 3
            end
            object chk1: TCheckBox
              Left = 11
              Top = 47
              Width = 150
              Height = 17
              Caption = 'Generate for all tables'
              TabOrder = 4
            end
          end
        end
      end
    end
    object pnl2: TPanel
      Left = 305
      Top = 0
      Width = 661
      Height = 421
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 265
      ExplicitWidth = 701
      object pnl3: TPanel
        Left = 1
        Top = 1
        Width = 659
        Height = 29
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitWidth = 699
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
          Left = 582
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
          ExplicitLeft = 622
        end
        object cbb1: TComboBox
          AlignWithMargins = True
          Left = 80
          Top = 3
          Width = 497
          Height = 23
          Align = alClient
          TabOrder = 1
          Text = 'cbb1'
          ExplicitWidth = 537
        end
      end
      object dbgrd1: TDBGrid
        AlignWithMargins = True
        Left = 4
        Top = 33
        Width = 653
        Height = 384
        Align = alClient
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Reference Sans Serif'
        TitleFont.Style = []
      end
    end
  end
  object FDCon1: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    LoginPrompt = False
    BeforeConnect = FDCon1BeforeConnect
    Left = 208
    Top = 72
  end
end
