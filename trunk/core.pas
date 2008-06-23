unit core;

interface

uses
  classes,
  windows,
  forms,
  controls,
  stdctrls,
  extctrls,
  menus,
  messages,
  shellapi,
  sysutils,
  registry,
  inifiles,
  app;

type
  TMain = class(TForm)
    Menu: TPopupMenu;
    Options: TMenuItem;
    Exit: TMenuItem;
    Run: TMenuItem;
    Autostart: TRadioGroup;
    About: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure ExitClick(Sender: TObject);
    procedure OptionsClick(Sender: TObject);
    procedure FormClose(Sender: TObject;var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure RunClick(Sender: TObject);
    procedure AutostartClick(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure TrayActivity(var Msg : TMessage );message WM_USER+1;
  end;
type
  tcscan=class(TThread)
    procedure Execute; override;
  end;
type
  tsettings=packed record
    apppath:string;
    appexepath:string;
    binary:string;
    runparam:string;
    hint:string;
    canclose:tcloseaction;
    store:tmeminifile;
  end;

var
  main:tmain;
  interval:cardinal;
  settings:tsettings;
implementation

{$R *.dfm}

uses trayicon;

procedure tmain.formcreate(sender: tobject);
var reg:tregistry;
begin
  if fileexists(extractfilepath(paramstr(0))+'settings.ini') then
  begin
    with settings do
    begin
      store:=tmeminifile.create(settings.apppath+'settings.ini');
      canclose:=canone;
      apppath:=store.readstring('settings','path',extractfilepath(paramstr(0)));
      appexepath:='"'+paramstr(0)+'"';
      binary:=store.readstring('settings','executable','');
      runparam:=store.readstring('settings','parameters','');
      hint:=store.readstring('settings','tray tip','');
    end;
    reg:=tregistry.create;
    with reg do
    begin
      rootkey:=HKEY_LOCAL_MACHINE;
      openkeyreadonly('\Software\Microsoft\Windows\CurrentVersion\Run');
      if settings.appexepath=readstring('myTC') then autostart.itemindex:=1;
      closekey;
      free;
    end;
  end
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
        WriteString('myTC',settings.appexepath);;
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
        Free;
      end;
    end;
end;

procedure tmain.exitclick(sender:tobject);
begin
  settings.canclose:=caminimize;
  trayicon.remicon;
  main.close;
end;

procedure tcscan.execute();
begin
  if app.isrunning then
  begin
    setforegroundwindow(app.wnd);
    showwindow(app.wnd,SW_MAXIMIZE);
  end
  else
  begin
    shellexecute(handle,'open',pchar(settings.apppath+settings.binary),pchar(settings.runparam),nil,SW_SHOWNORMAL);
    setforegroundwindow(app.wnd);
  end;
end;


procedure tmain.runclick(sender:tobject);
begin
  tcscan.create(false);
end;

procedure tmain.trayactivity(var msg:tmessage);
begin
  case msg.lparam of
    WM_LBUTTONDBLCLK:tcscan.create(false);
    WM_RBUTTONDOWN:menu.popup(mouse.cursorpos.x,mouse.cursorpos.y);
  end;
end;

procedure tmain.formclose(sender:tobject;var action:tcloseaction);
begin
  action:=settings.canclose;
  main.alphablend:=true;
end;

end.
