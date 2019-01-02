object fConnections: TfConnections
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Sql Server Connection Settings'
  ClientHeight = 197
  ClientWidth = 340
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 42
    Width = 32
    Height = 13
    Caption = 'Server'
  end
  object Label2: TLabel
    Left = 40
    Top = 69
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object Label3: TLabel
    Left = 40
    Top = 96
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object eServer: TEdit
    Left = 104
    Top = 39
    Width = 156
    Height = 21
    TabOrder = 0
  end
  object eUser: TEdit
    Left = 104
    Top = 66
    Width = 156
    Height = 21
    TabOrder = 1
  end
  object ePw: TEdit
    Left = 104
    Top = 93
    Width = 156
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
  end
  object BtnTest: TButton
    Left = 104
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 3
    OnClick = BtnTestClick
  end
  object BtnClose: TButton
    Left = 185
    Top = 128
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Close'
    TabOrder = 4
    OnClick = BtnCloseClick
  end
end
