object Main: TMain
  Left = 0
  Top = 0
  HorzScrollBar.Increment = 31
  AlphaBlend = True
  AlphaBlendValue = 0
  BorderStyle = bsDialog
  Caption = 'Main'
  ClientHeight = 206
  ClientWidth = 156
  Color = clCream
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  Icon.Data = {
    0000010001002020100001000000E80200001600000028000000200000004000
    0000010004000000000000000000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000077
    7777777777777777777777777777077777777777777777777777777777770000
    0000000000000000000000000077000001818881881881111111100000770000
    0111111111111111111110000077007001818881888811111111100700770070
    0111111111111111111110070077000008888888888888888888800000770000
    0888888888888888888880000077000001111111111111111111100000770000
    0888888888888888888880000077000008888888888888888888800000770000
    0111111111111111111110000077000008888888888888888888800000770000
    0888888888888888888880000077000001111111111111111111100000770000
    0888888888888888888880000077000008888888888888888888800000770000
    0000000000000000000000000077000000000000000000000000000000770000
    0000000000000000000000000077000000000000000000000000000000770000
    0000008888888888800000000077000000000888888888888800000000770000
    0000088888880008880000000077000000000888888800088808088000770080
    0000088888880008880888080077008000000888888800088808088000770888
    0000088888880008880000000077008000000888888800088800000000700000
    000008888888888888000000000000000000088888888888880000000000C000
    0000800000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    00000000000000000000000000000000000000000001000000070000000F}
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Autostart: TRadioGroup
    Left = 0
    Top = 0
    Width = 153
    Height = 89
    Caption = 'Autostart'
    ItemIndex = 0
    Items.Strings = (
      'None'
      'Registry'
      'Autostart')
    TabOrder = 0
    OnClick = AutostartClick
  end
  object About: TGroupBox
    Left = 0
    Top = 95
    Width = 153
    Height = 106
    Caption = 'About'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 40
      Width = 130
      Height = 13
      Caption = 'mail: deadmoto@gmail.com'
    end
    object Label2: TLabel
      Left = 8
      Top = 59
      Width = 98
      Height = 13
      Caption = 'homepage=>>www'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = Label2Click
    end
    object Label3: TLabel
      Left = 8
      Top = 21
      Width = 54
      Height = 13
      Caption = 'version 0.4'
    end
    object Label4: TLabel
      Left = 8
      Top = 78
      Width = 91
      Height = 13
      Caption = 'deadmoto (c) 2007'
    end
  end
  object Menu: TPopupMenu
    Left = 168
    Top = 280
    object Run: TMenuItem
      Caption = #1047#1072#1087#1091#1089#1082
      OnClick = RunClick
    end
    object Options: TMenuItem
      Caption = #1054#1087#1094#1080#1080
      OnClick = OptionsClick
    end
    object Exit: TMenuItem
      Caption = #1042#1099#1093#1086#1076
      OnClick = ExitClick
    end
  end
end
