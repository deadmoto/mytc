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
  isrunning:boolean;
  wnd:hwnd;

implementation

procedure daemon.Execute;
begin
  while true do
    begin
      wnd:=FindWindow(PChar('TTOTAL_CMD'),nil);
      if wnd<>0 then isrunning:=true else isrunning:=false;
      sleepex(50,true);
    end
end;

end.
