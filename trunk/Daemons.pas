unit Daemons;

interface

uses
  Messages,
  Windows;

procedure ProcessWatcher;

implementation

uses
  Window;

procedure ProcessWatcher;
var
  LastHandle: THandle;
  LastState: boolean;
begin
  while true do
  begin
    LastHandle := FindWindow(PChar('TTOTAL_CMD'), nil);
    case LastHandle <> 0 of
      true:
        case LastState of
          true:
            Sleep(100);
          false:
            begin
              LastState := not LastState;
              PostMessage(WndHandle, WM_USER, LastHandle, WM_NOTIFY);
            end;
        end;
      false:
        case LastState of
          true:
            begin
              LastState := not LastState;
              PostMessage(WndHandle, WM_USER, LastHandle, WM_NOTIFY);
            end;
          false:
            Sleep(100);
        end;
    end;
  end;
end;

end.
