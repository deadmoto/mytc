unit app;

interface

uses
  classes,
  windows;

type
  daemon = class(tthread)
    procedure execute; override;
end;

var
  isrunning,changed:boolean;
  wnd:hwnd;

implementation

procedure daemon.execute;
begin
  while true do
    begin
      wnd:=findwindow(pchar('TTOTAL_CMD'),nil);
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
      sleepex(50,true);
    end
end;

end.
