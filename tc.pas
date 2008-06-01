unit tc;

interface

uses
  Classes,
  Windows;

type
  daemon = class(TThread)
    procedure Execute; override;
end;

var
  isrunning,changed:boolean;
  wnd:hwnd;

implementation

procedure daemon.Execute;
begin
  while true do
    begin
      wnd:=FindWindow(PChar('TTOTAL_CMD'),nil);
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
