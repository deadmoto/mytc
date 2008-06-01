unit tray;

interface

uses
  trayicon,
  Classes,
  Windows,
  Messages,
  ShellAPI,
  SysUtils,
  tc,
  mytc;

const WM_ICONTRAY=WM_USER+1;

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
  quit:boolean;
  trayicondata:tnotifyicondata;
  icon0,icon1:hicon;

implementation

procedure daemon.Execute;
begin
  while not quit do
    begin
      if tc.changed then
        begin
          if tc.isrunning then trayicon.modicon(icon1) else trayicon.modicon(icon0);
          tc.changed:=false;
        end;
      sleepex(100,false);
    end;
end;

procedure init.Execute;
begin
  icon0:=extracticon(icon0,'0x0000.ico',0);
  icon1:=extracticon(icon1,'0x0001.ico',0);
  trayicon.addicon(icon0);
end;

procedure free.Execute;
begin
  trayicon.remicon;
end;

end.

