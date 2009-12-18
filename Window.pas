unit Window;

interface

uses
  Messages,
  Windows;

var
  WndClass: TWndClassEx;
  WndHandle: THandle;

procedure Create;

implementation

uses
  Core,
  TrayIcon;

function WindowProc(Wnd: HWND; Msg: Integer; WPARAM: WPARAM; LPARAM: LPARAM): LRESULT; stdcall;
begin
  case Msg of
    WM_COMMAND:
      SelectMenuItem(WPARAM);
    WM_DESTROY:
      Exit;
    WM_USER:
      TrayIconProc(Wnd, Msg, WPARAM, LPARAM);
  end;
  Result := DefWindowProc(Wnd, Msg, WPARAM, LPARAM);
end;

procedure Create;
begin
  // create and register message window
  FillChar(WndClass, SizeOf(WndClass), #0);
  WndClass.cbSize := SizeOf(TWndClassEx);
  WndClass.style := CS_GLOBALCLASS;
  WndClass.lpfnWndProc := @WindowProc;
  WndClass.HInstance := HInstance;
  WndClass.lpszClassName := 'mytc';
  RegisterClassEx(WndClass);
  WndHandle := CreateWindow(WndClass.lpszClassName, 'main', 0, 0, 0, 0, 0, HWND_MESSAGE, 0, HInstance, nil);
end;

end.
