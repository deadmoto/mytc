program mytcp;

uses
  forms,
  windows,
  app in 'app.pas',
  tray in 'tray.pas',
  ticon in 'ticon.pas',
  def in 'def.pas',
  core in 'core.pas' {main},
  plugin in 'plugin.pas',
  version in 'version.pas';

{$R *.res}

var
  h: thandle;
  osversioninfoex:tosversioninfoex;
  build:cardinal;


function isrunning: boolean;
begin
  h:=openmutex(MUTEX_ALL_ACCESS,false,'mymutex');
  result:=(h<>0);
  if h=0 then h:=createmutex(nil,false,'mymutex');
end;

begin
//  osversioninfoex.getversion;
  if isrunning then exit;
  apphandle:=application.handle;
  application.initialize;
  tray.init.create(false);
  tray.daemon.create(false);
  app.daemon.create(false);
  application.showmainform:=false;
  Application.CreateForm(Tmain, main);
  application.run;
end.
