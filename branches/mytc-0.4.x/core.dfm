object main: Tmain
  Left = 0
  Top = 0
  HorzScrollBar.Increment = 31
  AlphaBlendValue = 0
  BorderStyle = bsDialog
  Caption = 'main'
  ClientHeight = 105
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Menu: TPopupMenu
    Left = 168
    Top = 280
    object run: TMenuItem
      Caption = 'run'
      OnClick = runClick
    end
    object delim1: TMenuItem
      Caption = '-'
    end
    object asnon: TMenuItem
      Caption = 'no autostart'
      Checked = True
      RadioItem = True
      OnClick = asnonClick
    end
    object ascur: TMenuItem
      Caption = 'current user'
      RadioItem = True
      OnClick = ascurClick
    end
    object asall: TMenuItem
      Caption = 'all users'
      RadioItem = True
      OnClick = asallClick
    end
    object delim2: TMenuItem
      Caption = '-'
    end
    object about: TMenuItem
      Caption = 'about'
      Hint = 'About this program'
      OnClick = aboutClick
    end
    object exit: TMenuItem
      Caption = 'exit'
      OnClick = exitClick
    end
  end
end
