program mytcp;

uses
  Forms,
  Windows,
  mytc in 'mytc.pas' {Main};

{$R *.res}
var
  HM: THandle;

function Check: boolean;
begin
  HM := OpenMutex(MUTEX_ALL_ACCESS, false, 'MyOwnMutex');
  Result := (HM <> 0);
  if HM = 0 then
    HM := CreateMutex(nil, false, 'MyOwnMutex');
end;

begin
  if Check then Exit;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
