unit TrayMenu;

interface

uses
  Messages,
  Windows;

function ShowMenu: LRESULT; stdcall;

const
  ID_LAUNCH = 101;
  ID_NONE = 102;
  ID_HKCU = 103;
  ID_HKLM = 104;
  ID_HOME = 105;
  ID_EXIT = 106;

var
  PopupMenu: HMenu;
  NONEFlags: cardinal;
  HKCUFlags: cardinal;
  HKLMFlags: cardinal;

implementation

uses
  Core,
  Window;

procedure SetTrayMenuFlags;
var
  Key: HKEY;
  lpType, lpSize: DWORD;
  lpData: PChar;
begin
  HKCUFlags := MF_DISABLED;
  if RegOpenKeyEx(HKEY_CURRENT_USER, RUN, 0, KEY_ALL_ACCESS, Key) = ERROR_SUCCESS then
    HKCUFlags := MF_ENABLED;
  RegCloseKey(Key);
  if RegOpenKeyEx(HKEY_CURRENT_USER, RUN, 0, KEY_READ, Key) = ERROR_SUCCESS then
    if RegQueryValueEx(Key, 'mytc', nil, @lpType, nil, @lpSize) = ERROR_SUCCESS then
    begin
      lpData := AllocMem(lpSize);
      RegQueryValueEx(Key, 'mytc', nil, @lpType, @lpData[0], @lpSize);
      if GetCommandLine^ = lpData^ then
        HKCUFlags := HKCUFlags or MF_CHECKED;
    end;
  RegCloseKey(Key);
  HKLMFlags := MF_DISABLED;
  if RegOpenKeyEx(HKEY_LOCAL_MACHINE, RUN, 0, KEY_ALL_ACCESS, Key) = ERROR_SUCCESS then
    HKLMFlags := MF_ENABLED;
  RegCloseKey(Key);
  if RegOpenKeyEx(HKEY_LOCAL_MACHINE, RUN, 0, KEY_READ, Key) = ERROR_SUCCESS then
    if RegQueryValueEx(Key, 'mytc', nil, @lpType, nil, @lpSize) = ERROR_SUCCESS then
    begin
      lpData := AllocMem(lpSize);
      RegQueryValueEx(Key, 'mytc', nil, @lpType, @lpData[0], @lpSize);
      if GetCommandLine^ = lpData^ then
        HKLMFlags := HKLMFlags or MF_CHECKED;
    end;
  RegCloseKey(Key);
end;

function ShowMenu: LRESULT; stdcall;
var
  Point: TPoint;
begin
  PopupMenu := CreatePopupMenu;
  SetTrayMenuFlags;
  AppendMenu(PopupMenu, MF_STRING, ID_LAUNCH, 'run');
  AppendMenu(PopupMenu, MF_SEPARATOR, 0, nil);
  AppendMenu(PopupMenu, MF_STRING or NONEFlags, ID_NONE, 'no autostart');
  AppendMenu(PopupMenu, MF_STRING or HKCUFlags, ID_HKCU, 'current user');
  AppendMenu(PopupMenu, MF_STRING or HKLMFlags, ID_HKLM, 'all users');
  AppendMenu(PopupMenu, MF_SEPARATOR, 0, nil);
  AppendMenu(PopupMenu, MF_STRING, ID_HOME, 'homepage');
  AppendMenu(PopupMenu, MF_STRING, ID_EXIT, 'exit');
  GetCursorPos(Point);
  SetForegroundWindow(WndHandle);
  TrackPopupMenu(PopupMenu, 0, Point.X, Point.Y, 0, WndHandle, nil);
  Result := 0;
  DestroyMenu(PopupMenu);
end;

end.
