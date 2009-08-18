unit version;

interface

type
  bool=longbool;
  dword=cardinal;

type
  posversioninfoex=^tosversioninfoex;
  tosversioninfoex=packed record
  private
    dwosversioninfosize:dword;
    dwmajorversion:dword;
    dwminorversion:dword;
    dwbuildnumber:dword;
    dwplatformid:dword;
    szcsdversion:array[0..127] of widechar;
    wservicepackmajor:word;
    wservicepackminor:word;
    wsuitemask:word;
    wproducttype:byte;
    wreserved:byte;
  public
    property majorversion:dword read dwmajorversion;
    property minorversion:dword read dwminorversion;
    property buildnumber:dword read dwbuildnumber;
    procedure getversion;
  end;

function getversionex(var lpversioninformation:tosversioninfoex):bool;stdcall;

implementation

function getversionex;external 'kernel32.dll' name 'GetVersionExW';

{ tosversioninfoex }

procedure tosversioninfoex.getversion;
begin
  dwosversioninfosize:=sizeof(tosversioninfoex);
  getversionex(self);
end;

end.
