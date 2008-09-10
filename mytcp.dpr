program mytcp;

uses
  forms,
  windows,
  app in 'app.pas',
  tray in 'tray.pas',
  ticon in 'ticon.pas',
  def in 'def.pas',
  core in 'core.pas' {Main},
  plugin in 'plugin.pas';

{$R *.res}

var
  h: thandle;

function isrunning: boolean;
begin
  h:=openmutex(MUTEX_ALL_ACCESS,false,'mymutex');
  result:=(h<>0);
  if h=0 then h:=createmutex(nil,false,'mymutex');
end;

begin
  if isrunning then exit;
  def.apphandle:=application.handle;
  application.initialize;
  tray.init.create(false);
  tray.daemon.create(false);
//  tray.daemon.create(false);
  app.daemon.create(false);
  application.showmainform:=false;
  application.createform(tmain,main);
  application.run;
end.
