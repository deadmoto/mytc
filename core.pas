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
    appver: TLabel;
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

var
  main:tmain;
  interval:cardinal;

procedure tcscan;

implementation

{$R *.dfm}

uses
  plugin,
  def,
  ticon;

procedure tmain.formcreate(sender: tobject);
var reg:tregistry;
begin
  main.caption:=def.appname;
  main.appver.caption:=def.appver;
  def.appath:=extractfilepath(paramstr(0));
  reg:=tregistry.create;
  with reg do
  begin
    rootkey:=HKEY_LOCAL_MACHINE;
    openkeyreadonly('\Software\Microsoft\Windows\CurrentVersion\Run');
    if def.exename=readstring(def.appname) then autostart.itemindex:=1;
    closekey;
    free;
  end;
end;

procedure TMain.Label2Click(Sender: TObject);
begin
  ShellExecute(Handle,nil,'http://deadmoto.googlepages.com/mytc',nil,nil,SW_SHOW);
end;

procedure tmain.optionsclick(sender:tobject);
begin
  main.show;
end;

procedure TMain.AutostartClick(Sender: TObject);
var HR: TRegistry;
begin
  if Autostart.ItemIndex=1 then
    begin
      HR:=TRegistry.Create;
      with HR do
        begin
        rootkey:=HKEY_LOCAL_MACHINE;
        openkey('\Software\Microsoft\Windows\CurrentVersion\Run',True);
        writestring(def.appname,def.exename);;
        closekey;
        free;
      end;
    end;
  if autostart.itemindex<>1 then
    begin
      hr:=tregistry.create;
      with hr do
        begin
        rootkey:=HKEY_LOCAL_MACHINE;
        openkey('\Software\Microsoft\Windows\CurrentVersion\Run',true);
        deletevalue(def.appname);
        closekey;
        free;
      end;
    end;
end;

procedure tmain.exitclick(sender:tobject);
begin
  def.canclose:=caminimize;
  ticon.remicon;
  main.close;
end;

procedure tcscan;
begin
  if app.isrunning then
  begin
    setforegroundwindow(app.wnd);
    showwindow(app.wnd,SW_MAXIMIZE);
  end
  else
  begin
    shellexecute(def.apphandle,'open',pchar(def.appath+def.binary),pchar('/O /i="'+def.appath+'bin\wincmd.ini" /f="'+def.appath+'bin\wcx_ftp.ini"'),nil,SW_SHOWNORMAL);
    plugin.plug;
    setforegroundwindow(app.wnd);
  end;
end;


procedure tmain.runclick(sender:tobject);
begin
  tcscan;
end;

procedure tmain.trayactivity(var msg:tmessage);
begin
  case msg.lparam of
    WM_LBUTTONDBLCLK:tcscan;
    WM_RBUTTONDOWN:menu.popup(mouse.cursorpos.x,mouse.cursorpos.y);
  end;
end;

procedure tmain.formclose(sender:tobject;var action:tcloseaction);
begin
  action:=def.canclose;
  main.hide;
end;

end.
