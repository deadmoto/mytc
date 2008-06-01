unit tray;

interface

uses Classes,Windows,Messages,Dialogs,ShellAPI,SysUtils,tc,mytc;

const WM_ICONTRAY = WM_USER + 100;

type
  daemon = class(TThread)
    procedure Execute; override;
end;

type
  init = class(TThread)
    procedure Execute; override;
end;

type
  free = class(TThread)
    procedure Execute; override;
end;

var
  mywnd:hwnd;
  isrunning, quit:boolean;
  TrayIconData:TNotifyIconData;

implementation

function TrayIconAdd(Icon:PAnsiChar): boolean;
begin
  with TrayIconData do
    begin
      cbSize := SizeOf(TrayIconData);
      Wnd := main.Handle;
      uID := 1;
      uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
      uCallbackMessage := WM_ICONTRAY;
      hIcon := ExtractIcon(hIcon,Icon,0);
      StrPCopy(szTip,'Double-click to run TC');
    end;
  result:=Shell_NotifyIcon(NIM_ADD, @TrayIconData);
end;

function TrayIconMod(Icon:PAnsiChar): boolean;
begin
  TrayIconData.hIcon:=ExtractIcon(TrayIconData.hIcon,Icon,0);
  result:=Shell_NotifyIcon(NIM_MODIFY, @TrayIconData);
end;

function TrayIconDel: boolean;
begin
  result:=Shell_NotifyIcon(NIM_DELETE, @TrayIconData);
end; 

procedure daemon.Execute;
begin
  while not quit do
    begin
      if tc.isrunning then TrayIconMod('0x0001.ico') else TrayIconMod('0x0000.ico');
      sleepex(50,false);
    end;
end;

procedure init.Execute;
begin
  TrayIconAdd('0x0000.ico');
end;

procedure free.Execute;
begin
  TrayIconDel;
end;

end.

