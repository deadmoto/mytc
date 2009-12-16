program mytc;

uses
  forms,
  app in 'app.pas',
  tray in 'tray.pas',
  ticon in 'ticon.pas',
  def in 'def.pas',
  core in 'core.pas' {main},
  plugin in 'plugin.pas',
  mutex in 'mutex.pas';

{$R *.res}

const
{$ifdef debug}
  mutex='mytc';
{$else}
  mutex='mytcd';
{$endif}

//var
//  osversioninfoex:tosversioninfoex;
//  build:cardinal;

function isfirst:boolean;
begin
  if openmutex(mutex_all_access,false,mutex)=0 then
    result:=createmutex(nil,integer(false),mutex)<>0;
end;

begin
//  osversioninfoex.getversion;
  if isfirst then
    begin
      application.initialize;
      apphandle:=application.handle;
      tray.init.create(false);
      tray.daemon.create(false);
      app.daemon.create(false);
      application.showmainform:=false;
      Application.CreateForm(Tmain, main);
  application.run;
    end;
end.
