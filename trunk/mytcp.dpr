program mytcp;

uses
  forms,
  windows,
  core in 'core.pas',
  app in 'app.pas',
  tray in 'tray.pas',
  trayicon in 'trayicon.pas';

{$R *.res}

var
  h:thandle;

function check:boolean;
begin
  h:=openmutex(MUTEX_ALL_ACCESS,false,'mytcp');
  result:=(h<>0);
  if h=0 then h:=createmutex(nil,false,'mytcp');
end;

begin
  if check then exit;
  application.initialize;
  application.createform(tmain,main);
  app.daemon.create(false);
  with tray.init.create(false) do handle:=main.handle;
  tray.daemon.create(false);
  tray.daemon.create(false);
  application.run;
end.
