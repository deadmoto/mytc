program mytcp;

uses
  Messages,
  ShellAPI,
  SysUtils,
  Forms,
  Windows,
  mytc in 'mytc.pas' {Main};

{$R *.res}
const WM_ICONTRAY = WM_USER + 1;

var
  HM: THandle;
  TrayIconData: TNotifyIconData;

function Check: boolean;
begin
  HM := OpenMutex(MUTEX_ALL_ACCESS, false, 'MyOwnMutex');
  Result := (HM <> 0);
  if HM = 0 then
    HM := CreateMutex(nil, false, 'MyOwnMutex');
end;



function TrayIconAdd: boolean;
begin
with TrayIconData do
  begin
  cbSize := SizeOf(TrayIconData);
  Wnd := Application.Handle;
  uID := 0;
  uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
  uCallbackMessage := WM_ICONTRAY;
  hIcon := Application.Icon.Handle;
  StrPCopy(szTip, Application.Title);
end;
Shell_NotifyIcon(NIM_ADD, @TrayIconData);
end;

function TrayIconMod: boolean;
begin
Shell_NotifyIcon(NIM_MODIFY, @TrayIconData);
end;

function TrayIconDel: boolean;
begin
Shell_NotifyIcon(NIM_DELETE, @TrayIconData);
end;


begin
  if Check then Exit;
  if TrayIconAdd then
  
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
