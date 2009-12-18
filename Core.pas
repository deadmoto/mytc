unit Core;

interface

uses
  Messages,
  ShellAPI,
  SysUtils,
  Windows;

const
  URL = 'http://code.google.com/p/mytc/';

function SelectMenuItem(WPARAM: WPARAM): LRESULT; stdcall;
procedure Launch;

implementation

uses
  Dialogs,
  NagScreen,
  TrayIcon,
  TrayMenu;
{$I build\Version.inc}

procedure LaunchThread;
var
  Path: string;
  SI: TStartupInfo;
  PI: TProcessInformation;
begin
  Path := ExtractFilePath(ParamStr(0));
  SI := default(TStartupInfo);
  SI.cb := SizeOf(TStartupInfo);
  CreateProcess(PChar(Path + 'bin\totalcmd.exe'), PChar('/O /i="' + Path + 'bin\wincmd.ini" /f="' + Path + 'bin\wcx_ftp.ini"'), nil, nil,
    false, NORMAL_PRIORITY_CLASS, nil, PChar(Path), SI, PI);
end;

procedure Launch;
var
  lpThreadId: DWORD;
begin
  CreateThread(nil, 0, @LaunchThread, nil, 0, lpThreadId);
end;

procedure SetNoAutostart;
var
  Key: HKEY;
begin
  RegOpenKeyEx(HKEY_LOCAL_MACHINE, 'Software\\Microsoft\\Windows\\CurrentVersion\\Run', 0, KEY_ALL_ACCESS, Key);
  RegDeleteValue(Key, 'mytc');
  RegCloseKey(Key);
  RegOpenKeyEx(HKEY_CURRENT_USER, 'Software\\Microsoft\\Windows\\CurrentVersion\\Run', 0, KEY_ALL_ACCESS, Key);
  RegDeleteValue(Key, 'mytc');
  RegCloseKey(Key);
end;

procedure SetHKCUAutostart;
var
  Key: HKEY;
begin
  RegOpenKeyEx(HKEY_CURRENT_USER, 'Software\\Microsoft\\Windows\\CurrentVersion\\Run', 0, KEY_ALL_ACCESS, Key);
  RegSetValueEx(Key, 'mytc', 0, REG_SZ, GetCommandLine, Length(GetCommandLine) * SizeOf(PChar));
  RegCloseKey(Key);
end;

procedure SetHKLMAutostart;
var
  Key: HKEY;
begin
  RegOpenKeyEx(HKEY_LOCAL_MACHINE, 'Software\\Microsoft\\Windows\\CurrentVersion\\Run', 0, KEY_ALL_ACCESS, Key);
  RegSetValueEx(Key, 'mytc', 0, REG_SZ, GetCommandLine, Length(GetCommandLine) * SizeOf(PChar));
  RegCloseKey(Key);
end;

procedure Exit;
begin
  TrayIcon.Destroy;
  PostQuitMessage(0);
end;

function SelectMenuItem(WPARAM: WPARAM): LRESULT; stdcall;
begin
  case WPARAM of
    ID_LAUNCH:
      Launch;
    ID_NONE:
      SetNoAutostart;
    ID_HKCU:
      SetHKCUAutostart;
    ID_HKLM:
      SetHKLMAutostart;
    ID_HOME:
      ShellExecute(0, nil, URL, nil, nil, SW_SHOWNORMAL);
    ID_EXIT:
      Exit;
  end;
  Result := 0;
end;

end.
