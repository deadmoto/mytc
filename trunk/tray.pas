unit tray;

interface

uses
  classes,
  windows,
  messages,
  shellapi,
  sysutils;

const WM_ICONTRAY=WM_USER+1;

type
  daemon=class(TThread)
    procedure execute; override;
end;

type
  init=class(TThread)
    procedure execute; override;
end;

type
  free=class(TThread)
    procedure execute; override;
end;

var
  mywnd:hwnd;
  quit:boolean;
  trayicondata:tnotifyicondata;
  icon0,icon1:hicon;

implementation

uses
  core,
  app,
  ticon;

procedure daemon.execute;
begin
  while not quit do
    begin
      if app.changed then
        begin
          if app.isrunning then ticon.modicon(icon1) else ticon.modicon(icon0);
          app.changed:=false;
        end;
      sleepex(100,false);
    end;
end;

procedure init.execute;
begin
  icon0:=extracticon(icon0,'0x0000.ico',0);
  icon1:=extracticon(icon1,'0x0001.ico',0);
  ticon.addicon(icon0);
end;

procedure free.execute;
begin
  ticon.remicon;
end;

end.

