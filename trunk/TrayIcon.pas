unit TrayIcon;

interface

uses
  Messages,
  ShellAPI,
  SysUtils,
  Windows;

function TrayIconProc(Wnd: HWND; Msg: Integer; WPARAM: WPARAM; LPARAM: LPARAM): LRESULT; stdcall;

var
  TrayIconData: TNotifyIconData;
  Icon0: HIcon;
  Icon1: HIcon;

procedure Create;
procedure Destroy;

implementation

uses
  Core,
  TrayMenu,
  Window;
{$I build\Version.inc}

function TrayIconProc(Wnd: HWND; Msg: Integer; WPARAM: WPARAM; LPARAM: LPARAM): LRESULT; stdcall;
begin
  case LPARAM of
    WM_LBUTTONDBLCLK:
      Launch;
    WM_RBUTTONUP:
      ShowMenu;
    WM_NOTIFY:
      begin
        if WPARAM = 0 then
          TrayIconData.HIcon := Icon0
        else
          TrayIconData.HIcon := Icon1;
        Shell_NotifyIcon(NIM_MODIFY, @TrayIconData);
      end;
  end;
  Result := DefWindowProc(Wnd, Msg, WPARAM, LPARAM);
end;

procedure Create;
begin
  Icon0 := ExtractIcon(Icon0, '0x0000.ico', 0);
  Icon1 := ExtractIcon(Icon1, '0x0001.ico', 0);
  TrayIconData.cbSize := SizeOf(TNotifyIconData);
  TrayIconData.Wnd := WndHandle;
  TrayIconData.uID := 1;
  TrayIconData.uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
  TrayIconData.uCallbackMessage := WM_USER;
  TrayIconData.HIcon := Icon0;
  StrPCopy(TrayIconData.szTip, PChar('mytc 0.5.' + Version + #13 + ParamStr(0)));
  Shell_NotifyIcon(NIM_ADD, @TrayIconData);
end;

procedure Destroy;
begin
  Shell_NotifyIcon(NIM_DELETE, @TrayIconData);
end;

end.
