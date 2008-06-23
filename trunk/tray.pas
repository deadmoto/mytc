unit tray;

interface

uses
  classes,
  windows,
  trayicon,
  shellapi,
  sysutils,
  core,
  app;

type
  daemon=class(tthread)
    procedure execute; override;
end;

type
  init=class(tthread)
    handle:thandle;
    procedure execute; override;
end;

type
  free=class(tthread)
    procedure execute; override;
end;

var
  quit:boolean;
  trayicondata:tnotifyicondata;
  icon0,icon1:hicon;

implementation

procedure daemon.execute;
begin
  while not quit do
    begin
      if app.changed then
        begin
          if app.isrunning then trayicon.modicon(icon1,settings.hint) else trayicon.modicon(icon0,settings.hint);
          app.changed:=false;
        end;
      sleepex(100,false);
    end;
end;

procedure init.execute;
begin
  icon0:=extracticon(icon0,'0x0000.ico',0);
  icon1:=extracticon(icon1,'0x0001.ico',0);
  trayicon.addicon(icon0,handle,settings.hint);
end;

procedure free.execute;
begin
  trayicon.remicon;
end;

end.

