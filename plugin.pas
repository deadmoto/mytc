unit plugin;

interface

uses
  windows,
  messages;

procedure plug;

implementation

procedure plug;
var
  h,n,p,l,t,b:hwnd;
  s:string;
begin
  h:=0;n:=0;p:=0;l:=0;t:=0;b:=0;
  while h=0 do
    begin
      h:=findwindow(PChar('TNASTYNAGSCREEN'),'Total Commander');
      sleepex(1,false);
    end;
    while n=0 do
    begin
      n:=findwindowex(h,0,PChar('TNotebook'),'');
      sleepex(1,false);
    end;
    while p=0 do
    begin
      p:=findwindowex(n,0,PChar('TPage'),'NagPage');
      sleepex(1,false);
    end;
    while l=0 do
    begin
      l:=findwindowex(p,0,'TPanel','');
      sleepex(1,false);
    end;
    while t=0 do
    begin
      if findwindowex(l,0,'TPanel','1')<>0 then t:=findwindowex(l,0,'TPanel','1');
      if findwindowex(l,0,'TPanel','2')<>0 then t:=findwindowex(l,0,'TPanel','2');
      if findwindowex(l,0,'TPanel','3')<>0 then t:=findwindowex(l,0,'TPanel','3');
      sleepex(1,false);
    end;
    setlength(s,sendmessage(t,WM_GETTEXTLENGTH,0,0)+1);
    setlength(s,sendmessage(t,WM_GETTEXT,Length(s),LPARAM(s)));
    while b=0 do
    begin
      b:=findwindowex(l,0,'TButton',pchar('&'+s));
      sleepex(1,false);
    end;
  sendmessage(b,BM_CLICK,0,0);
end;

end.
