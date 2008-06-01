program mytcp;

uses
  Messages,
  Dialogs,
  ShellAPI,
  SysUtils,
  Forms,
  Windows,
  mytc in 'mytc.pas' {Main},
  tc in 'tc.pas',
  tray in 'tray.pas';

{$R *.res}

var
  HM: THandle;

function Check: boolean;
begin
  HM := OpenMutex(MUTEX_ALL_ACCESS, false, 'MyOwnMutex');
  Result := (HM <> 0);
  if HM = 0 then
    HM := CreateMutex(nil, false, 'MyOwnMutex');
end;

begin
  if check then exit;
  tc.daemon.create(false);
  tray.init.create(false);
  tray.daemon.create(false);
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  tray.daemon.create(false);
  Application.Run;
  tray.quit:=true;
end.
