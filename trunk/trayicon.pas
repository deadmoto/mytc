unit trayicon;

interface

uses
  windows,
  messages,
  shellapi,
  sysutils;

const WM_ICONTRAY=WM_USER+1;

function addicon(icon:hicon;handle:thandle;tip:string):boolean; overload;
function modicon(icon:hicon;tip:string):boolean; overload;
function remicon:boolean; overload;

var
  mywnd:hwnd=0;
  trayicondata:tnotifyicondata;

implementation

function addicon(icon:hicon;handle:thandle;tip:string):boolean; overload;
begin
  with trayicondata do
    begin
      cbSize:=sizeof(trayicondata);
      wnd:=handle;
      uid:=1;
      uflags:=NIF_MESSAGE+NIF_ICON+NIF_TIP;
      ucallbackmessage:=WM_ICONTRAY;
      hicon:=icon;
      strpcopy(sztip,tip);
    end;
  result:=shell_notifyicon(NIM_ADD,@trayicondata);
end;

function modicon(icon:hicon;tip:string):boolean; overload;
begin
  with trayicondata do
    begin
      uflags:=NIF_ICON;
      hicon:=icon;
      strpcopy(sztip,tip);
    end;
  result:=shell_notifyicon(NIM_MODIFY,@trayicondata);
end;

function remicon:boolean; overload;
begin
  result:=shell_notifyicon(NIM_DELETE,@trayicondata);
end;

end.
