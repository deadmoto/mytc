unit mytc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, ShellApi, ImgList, StdCtrls, Registry;

type
  TMain = class(TForm)
    Tray: TTrayIcon;
    Menu: TPopupMenu;
    Options: TMenuItem;
    Exit: TMenuItem;
    Run: TMenuItem;
    Icons: TImageList;
    Timer: TTimer;
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
    procedure TimerTimer(Sender: TObject);
    procedure AutostartClick(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
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

procedure TMain.RunClick(Sender: TObject);
begin
  Timer.Interval:=5000;
  ShellExecute(Handle,'open',PChar(AppPath+'totalcmd\totalcmd.exe'),PChar('/O /i="'+AppPath+'totalcmd\wincmd.ini" /f="'+AppPath+'totalcmd\wcx_ftp.ini"'),nil,SW_SHOWNORMAL);
  tray.IconIndex:=1;
  Timer.Enabled:=False;
  Timer.Enabled:=True;
end;

procedure TMain.TimerTimer(Sender: TObject);
var h:HWND;
begin
  Timer.Interval:=100;
  h:=FindWindow(PChar('TTOTAL_CMD'),nil);
  if h=0 then tray.IconIndex:=0;
  Timer.Enabled:=false;
  Timer.Enabled:=true;
end;

end.
