unit app;

interface

uses
  classes,
  windows;

type
  daemon = class(TThread)
    procedure execute; override;
end;

var
  isrunning,changed:boolean;
  wnd:hwnd;

implementation

uses
  tray;

procedure daemon.execute;
begin
  while true do
    begin
      wnd:=findwindow(PChar('TTOTAL_CMD'),nil);
      if findwindow('shell_traywnd',nil)=0 then init.create(false);      
      if not changed then
        begin
          if wnd<>0 then
            begin
              isrunning:=true;
              changed:=true;
            end
          else
            begin
              isrunning:=false;
              changed:=true;
            end;
        end;
      sleep(50);
    end
end;

end.
