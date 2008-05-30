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
var h:hwnd;
begin
h:=0;
if FindWindow(PChar('TTOTAL_CMD'),nil)=0 then ShellExecute(Handle,'open',PChar(AppPath+'totalcmd\totalcmd.exe'),PChar('/O /i="'+AppPath+'totalcmd\wincmd.ini" /f="'+AppPath+'totalcmd\wcx_ftp.ini"'),nil,SW_SHOWNORMAL);
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
