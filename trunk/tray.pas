unit tray;

interface

uses
  Classes,
  Windows,
  Messages,
  ShellAPI,
  SysUtils,
  tc,
  mytc;

const WM_ICONTRAY=WM_USER + 100;

type
  daemon=class(TThread)
    procedure Execute; override;
end;

type
  init=class(TThread)
    procedure Execute; override;
end;

type
  free=class(TThread)
    procedure Execute; override;
end;

var
  mywnd:hwnd;
  isrunning,statechanged,quit:boolean;
  trayicondata:tnotifyicondata;

implementation

function trayiconadd(icon:pansichar): boolean;
begin
  with trayicondata do
    begin
      cbSize:=sizeof(trayicondata);
      wnd:=main.handle;
      uid:=1;
      uflags:=NIF_MESSAGE+NIF_ICON+ NIF_TIP;
      ucallbackmessage:=WM_ICONTRAY;
      hicon:=extracticon(hicon,icon,0);
      strpcopy(sztip,'Double-click to run TC');
    end;
  result:=shell_notifyicon(NIM_ADD,@trayicondata);
end;

function trayiconmod(icon:pansichar):boolean;
begin
  trayicondata.hicon:=extracticon(trayicondata.hicon,icon,0);
  result:=shell_notifyicon(NIM_MODIFY,@trayicondata);
end;

function trayicondel:boolean;
begin
  result:=shell_notifyicon(NIM_DELETE,@trayicondata);
end; 

procedure daemon.Execute;
begin
  while not quit do
    begin
      if tc.statechanged then if tc.isrunning then TrayIconMod('0x0001.ico') else TrayIconMod('0x0000.ico');
      sleepex(500,false);
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

