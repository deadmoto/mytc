unit def;

interface

uses
  windows,
  forms;

const
  appname     ='mytc';
  appclassname='string';
  appver      ='version 0.4.1';
  binary      ='bin\totalcmd.exe';

var
  appath:string;
  apphandle:hwnd;
  canclose:tcloseaction=canone;

function exename:string;

implementation

function exename:string;
begin
  result:=application.exename;
end;

end.
