unit def;

interface

uses
  windows,
  forms;

//function exename:string;
function GetStartPath: string;
function GetTrayIconHint: string;

const
  appname     ='mytc';
  appclassname='string';
  appver      ='version 0.4.3';
  appurl      ='http://code.google.com/p/mytc/';
  binary      ='bin\totalcmd.exe';
  about       ='Author:deadmoto'+#13+
               'E-mail:deadmoto@gmail.com'+#13+
               '2007-2009'+#13+
               'Would you like to visit projects homepage?';
  lpsubkey    ='Software\Microsoft\Windows\CurrentVersion\Run';

var
  appath:string='%COMMANDER_PATH%';
  apphandle:hwnd;
  canclose:tcloseaction=canone;

implementation

{$I build\Version.inc}

function path:pchar;
begin
  result:=pchar(GetStartPath);
end;

function GetStartPath: string;
begin
  Result := ParamStr(0);
end;

function GetTrayIconHint: string;
begin
  Result := 'mytc: ' + Version + #13 + 'path: ' + GetStartPath;
end;

end.
