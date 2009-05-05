unit def;

interface

uses
  windows,
  forms;

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
  appath:string;
  apphandle:hwnd;
  canclose:tcloseaction=canone;

function exename:string;

implementation

function exename;
var
  buffer:array[0..260] of char;
begin
  setstring(result,buffer,getmodulefilename(0,buffer,length(buffer)));
end;

end.
