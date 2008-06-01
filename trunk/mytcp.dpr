program mytcp;

uses
  forms,
  windows,
  mytc in 'mytc.pas',
  tc in 'tc.pas',
  tray in 'tray.pas';

{$R *.res}

var
  h: thandle;

function check: boolean;
begin
  h:=openmutex(MUTEX_ALL_ACCESS,false,'MyMutex');
  result:=(h<>0);
  if h=0 then h:=createmutex(nil,false,'MyMutex');
end;

begin
  if check then exit;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  tc.daemon.create(false);
  tray.init.create(false);
  tray.daemon.create(false);
  tray.daemon.create(false);
  Application.Run;
  tray.quit:=true;
  sleepex(500,false);
end.
