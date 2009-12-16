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
  inifiles,
  app;

type
  tmain=class(tform)
    menu:tpopupmenu;
    run:tmenuitem;
    delim1:tmenuitem;
    asnon:tmenuitem;
    ascur:tmenuitem;
    asall:tmenuitem;
    delim2:tmenuitem;
    about:tmenuitem;
    exit:tmenuitem;
    procedure formcreate(sender:tobject);
    procedure runclick(sender:tobject);
    procedure ascurclick(sender:tobject);
    procedure asnonclick(sender:tobject);
    procedure asallclick(sender:tobject);
    procedure aboutclick(sender:tobject);
    procedure exitclick(sender:tobject);
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

procedure tmain.formcreate;
var
  key:hkey;
  lptype,lpsize:dword;
  lpdata:pwidechar;
begin
  caption:=appname;
  appath:=extractfilepath(GetStartPath);
  ascur.enabled:=regopenkeyex(hkey_current_user,lpsubkey,0,key_all_access,key)=error_success;
  if regopenkeyex(hkey_current_user,lpsubkey,0,key_read,key)=error_success then
    if regqueryvalueex(key,appname,nil,@lptype,nil,@lpsize)=error_success then
      begin
        lpdata:=allocmem(lpsize);
        regqueryvalueex(key,appname,nil,@lptype,pbyte(@lpdata[0]),@lpsize);
        if GetStartPath=lpdata then
          ascur.checked:=true;
      end;
  asall.enabled:=regopenkeyex(hkey_local_machine,lpsubkey,0,key_all_access,key)=error_success;
  if regopenkeyex(hkey_local_machine,lpsubkey,0,key_read,key)=error_success then
    if regqueryvalueex(key,appname,nil,@lptype,nil,@lpsize)=error_success then
      begin
        lpdata:=allocmem(lpsize);
        regqueryvalueex(key,appname,nil,@lptype,pbyte(@lpdata[0]),@lpsize);
        if GetStartPath=lpdata then
          asall.checked:=true;
      end;
  asnon.enabled:=(ascur.enabled and ascur.checked) or (asall.enabled and asall.checked);
  regclosekey(key);
end;

procedure tmain.aboutclick;
begin
  if messagebox(0,pchar(def.about),pwidechar(appname+' '+appver),mb_yesno)=idyes then
    shellexecute(0,nil,appurl,nil,nil,sw_shownormal);
end;

procedure tmain.asnonclick;
var
  key:hkey;
begin
  if ascur.checked and ascur.enabled then
    if regopenkeyex(hkey_current_user,lpsubkey,0,key_all_access,key)=error_success then
      asnon.checked:=regdeletevalue(key,appname)=error_success;
  if asall.checked and asall.enabled then
    if regopenkeyex(hkey_local_machine,lpsubkey,0,key_all_access,key)=error_success then
      asnon.checked:=regdeletevalue(key,appname)=error_success;
end;

procedure tmain.ascurclick;
var
  key:hkey;
  lpsize:dword;
  lpdata:pchar;
begin
  if asall.checked and asall.enabled then
    if regopenkeyex(hkey_local_machine,lpsubkey,0,key_all_access,key)=error_success then
      asnon.checked:=regdeletevalue(key,appname)=error_success;
  lpdata:=pchar(GetStartPath);
  lpsize:=length(lpdata)*sizeof(pchar);
  if regopenkeyex(hkey_current_user,lpsubkey,0,key_all_access,key)=error_success then
    if regcreatekey(hkey_current_user,lpsubkey,key)=error_success then
      if regsetvalueex(key,appname,0,reg_sz,lpdata,lpsize)=error_success then
        begin
          ascur.checked:=true;
          asnon.enabled:=true;
        end;
end;

procedure tmain.asallclick;
var
  key:hkey;
  lpsize:dword;
  lpdata:pchar;
begin
  if ascur.checked and ascur.enabled then
    if regopenkeyex(hkey_current_user,lpsubkey,0,key_all_access,key)=error_success then
      asnon.checked:=regdeletevalue(key,appname)=error_success;
  lpdata:=pchar(GetStartPath);
  lpsize:=length(lpdata)*sizeof(pchar);
  if regopenkeyex(hkey_local_machine,lpsubkey,0,key_all_access,key)=error_success then
    if regcreatekey(hkey_local_machine,lpsubkey,key)=error_success then
      if regsetvalueex(key,appname,0,reg_sz,lpdata,lpsize)=error_success then
        begin
          asall.checked:=true;
          asnon.enabled:=true;
        end;
end;

procedure tmain.exitclick;
begin
  remicon;
  close;
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


procedure tmain.runclick;
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

end.
