unit Process;

interface

uses
  Windows;

type
  TProcess = class
  strict private
    lpApplicationName: PChar;
    lpCommandLine: PChar;
    lpProcessAttributes: PSecurityAttributes;
    lpThreadAttributes: PSecurityAttributes;
    bInheritHandles: boolean;
    dwCreationFlags: cardinal;
    lpEnvironment: PChar;
    lpCurrentDirectory: PChar;
    lpStartupInfo: TStartupInfo;
    lpProcessInformation: TProcessInformation;
    function GetApplication: string;
    function GetDirectory: string;
    function GetParameters: string;
    procedure SetApplication(const Value: string);
    procedure SetDirectory(const Value: string);
    procedure SetParameters(const Value: string);
  public
    constructor Create;
    property Application: string read GetApplication write SetApplication;
    property Directory: string read GetDirectory write SetDirectory;
    property Parameters: string read GetParameters write SetParameters;
    procedure Start;
  end;

implementation

constructor TProcess.Create;
begin
  bInheritHandles := true;
  lpStartupInfo.cb := SizeOf(TStartupInfo);
end;

function TProcess.GetApplication: string;
begin
  Result := lpApplicationName;
end;

function TProcess.GetDirectory: string;
begin
  Result := lpCurrentDirectory;
end;

function TProcess.GetParameters: string;
begin
  Result := lpCommandLine;
end;

procedure TProcess.SetApplication(const Value: string);
begin
  lpApplicationName := PChar(Value);
end;

procedure TProcess.SetDirectory(const Value: string);
begin
  lpCurrentDirectory := PChar(Value);
end;

procedure TProcess.SetParameters(const Value: string);
begin
  lpCommandLine := PChar(Value);
end;

procedure TProcess.Start;
begin
  CreateProcess(lpApplicationName, lpCommandLine, lpProcessAttributes, lpThreadAttributes, bInheritHandles, dwCreationFlags, lpEnvironment, lpCurrentDirectory, lpStartupInfo, lpProcessInformation);
end;

end.
