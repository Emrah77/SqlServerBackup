object fMainBackup: TfMainBackup
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Sql Server Backup Tool'
  ClientHeight = 579
  ClientWidth = 641
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 641
    Height = 128
    Align = alTop
    TabOrder = 0
    object mLog: TMemo
      Left = 1
      Top = 1
      Width = 639
      Height = 126
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      TabOrder = 0
    end
  end
  object GroupBox1: TGroupBox
    Left = 318
    Top = 128
    Width = 323
    Height = 391
    Align = alRight
    Caption = 'Selected Databases'
    TabOrder = 1
    object lSelected: TListBox
      Left = 2
      Top = 15
      Width = 319
      Height = 374
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
      OnDblClick = lSelectedDblClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 128
    Width = 318
    Height = 391
    Align = alClient
    Caption = 'Current Databases'
    TabOrder = 2
    object lCurrent: TListBox
      Left = 2
      Top = 15
      Width = 314
      Height = 374
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
      OnDblClick = lCurrentDblClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 519
    Width = 641
    Height = 41
    Align = alBottom
    TabOrder = 3
    object Label1: TLabel
      Left = 5
      Top = 12
      Width = 59
      Height = 13
      Caption = 'Backup Path'
    end
    object BtnClose: TButton
      Left = 565
      Top = 1
      Width = 75
      Height = 39
      Align = alRight
      Caption = 'Close'
      TabOrder = 0
      OnClick = BtnCloseClick
    end
    object BtnBackup: TButton
      Left = 490
      Top = 1
      Width = 75
      Height = 39
      Align = alRight
      Caption = 'Backup'
      TabOrder = 1
      OnClick = BtnBackupClick
    end
    object ePath: TEdit
      Left = 68
      Top = 9
      Width = 298
      Height = 21
      TabOrder = 2
    end
    object BtnSelectPath: TBitBtn
      Left = 368
      Top = 9
      Width = 33
      Height = 21
      Caption = '...'
      TabOrder = 3
      OnClick = BtnSelectPathClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 560
    Width = 641
    Height = 19
    Panels = <>
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    AfterConnect = ADOConnection1AfterConnect
    Left = 344
    Top = 264
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      
        'SELECT name FROM master.dbo.sysdatabases WHERE name NOT IN ('#39'mas' +
        'ter'#39', '#39'tempdb'#39', '#39'model'#39', '#39'msdb'#39');')
    Left = 320
    Top = 312
  end
  object ADOQuery2: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      
        'SELECT name FROM master.dbo.sysdatabases WHERE name NOT IN ('#39'mas' +
        'ter'#39', '#39'tempdb'#39', '#39'model'#39', '#39'msdb'#39');')
    Left = 392
    Top = 328
  end
  object MainMenu1: TMainMenu
    Left = 584
    Top = 232
    object lemler1: TMenuItem
      Caption = 'Settings'
      object MnConnect: TMenuItem
        Caption = 'Sql Server Connection Settings'
        OnClick = MnConnectClick
      end
    end
  end
end
