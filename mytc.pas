unit mytc;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  Dialogs, ExtCtrls, Menus, ShellApi, ImgList, StdCtrls, Registry;

type
  TMain = class(TForm)
    Tray: TTrayIcon;
    Menu: TPopupMenu;
    Options: TMenuItem;
    Exit: TMenuItem;
    Run: TMenuItem;
    Icons: TImageList;
    Autostart: TRadioGroup;
    About: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure ExitClick(Sender: TObject);
    procedure OptionsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure RunClick(Sender: TObject);
    procedure AutostartClick(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  end;
  type
  tcscan = class(TThread)
    procedure Execute; override;
  end;

var
  AppPath,AppExePath: string;
  Main: TMain;
  CanClose: TCloseAction;
  Interval: Cardinal;

implementation

{$R *.dfm}

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=CanClose;
  Main.AlphaBlend:=true;
end;

procedure TMain.FormCreate(Sender: TObject);
var HR: TRegistry;
begin
  CanClose:=caNone;
  AppPath:=ExtractFilePath(ParamStr(0));
  AppExePath:='"'+AppPath+'mytcp.exe"';
  HR:=TRegistry.Create;
  with HR do
    begin
      RootKey:=HKEY_LOCAL_MACHINE;
      OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Run');
      if AppExePath=ReadString('myTC') then Autostart.ItemIndex:=1;
      CloseKey;
      Free;
    end;
end;

procedure TMain.Label2Click(Sender: TObject);
begin
  ShellExecute(Handle,nil,'http://deadmoto.googlepages.com/mytc',nil,nil,SW_SHOW);
end;

procedure TMain.OptionsClick(Sender: TObject);
begin
  Main.AlphaBlend:=false;
end;

procedure TMain.AutostartClick(Sender: TObject);
var HR: TRegistry;
begin
  if Autostart.ItemIndex=1 then
    begin
      HR:=TRegistry.Create;
      with HR do
        begin
        RootKey:=HKEY_LOCAL_MACHINE;
        OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run',True);
        WriteString('myTC',AppExePath);;
        CloseKey;
        Free;
      end;
    end;
  if Autostart.ItemIndex<>1 then
    begin
      HR:=TRegistry.Create;
      with HR do
        begin
        RootKey:=HKEY_LOCAL_MACHINE;
        OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run',True);
        DeleteValue('myTC');
//        CloseKey;
        Free;
      end;
    end;
end;

procedure TMain.ExitClick(Sender: TObject);
begin
  CanClose:=caMinimize;
  Main.Close;
end;

procedure tcscan.Execute();
var h,n,p,l,t,b:hwnd;c:pansichar;i:integer;s:string;
begin
h:=0;n:=0;p:=0;l:=0;t:=0;b:=0;
if FindWindow(PChar('TTOTAL_CMD'),nil)=0 then ShellExecute(Handle,'open',PChar(AppPath+'totalcmd\totalcmd.exe'),PChar('/O /i="'+AppPath+'totalcmd\wincmd.ini" /f="'+AppPath+'totalcmd\wcx_ftp.ini"'),nil,SW_SHOWNORMAL);
while h=0 do
  begin
  h:=findwindow(PChar('TNASTYNAGSCREEN'),'Total Commander');
  sleepex(1,false);
  end;
while n=0 do
  begin
  n:=FindWindowEx(h,0,PChar('TNotebook'),'');
  sleepex(1,false);
  end;
while p=0 do
  begin
  p:=FindWindowEx(n,0,PChar('TPage'),'NagPage');
  sleepex(1,false);
  end;
while l=0 do
  begin
  l:=FindWindowEx(p,0,'TPanel','');
  sleepex(1,false);
  end;
while t=0 do
  begin
  if FindWindowEx(l,0,'TPanel','1')<>0 then t:=FindWindowEx(l,0,'TPanel','1');
  if FindWindowEx(l,0,'TPanel','2')<>0 then t:=FindWindowEx(l,0,'TPanel','2');
  if FindWindowEx(l,0,'TPanel','3')<>0 then t:=FindWindowEx(l,0,'TPanel','3');
  sleepex(1,false);
  end;
SetLength(s,SendMessage(t,WM_GETTEXTLENGTH,0,0)+1);
SetLength(s,SendMessage(t,WM_GETTEXT,Length(s),LPARAM(s)));
while b=0 do
  begin
  b:=FindWindowEx(l,0,'TButton',pchar('&'+s));
  sleepex(1,false);
  end;
SendMessage(b, BM_CLICK,0,0);
h:=0;
while h=0 do
  begin
  h:=FindWindow(PChar('TTOTAL_CMD'),nil);
  sleepex(50,false);
  if h<>0 then
    begin
    main.tray.IconIndex:=1;
    while h=FindWindow(PChar('TTOTAL_CMD'),nil) do sleepex(50,false);
    end;
  end;
main.tray.IconIndex:=0;
end;


procedure TMain.RunClick(Sender: TObject);
begin
tcscan.Create(false);
end;

end.
