program mytc;

uses
  Windows,
  Window in 'Window.pas',
  TrayIcon in 'TrayIcon.pas',
  TrayMenu in 'TrayMenu.pas',
  Core in 'Core.pas',
  NagScreen in 'NagScreen.pas',
  Threads in 'Threads.pas',
  Daemons in 'Daemons.pas',
  Process in 'Process.pas';

var
  Msg: TMsg;

begin
  Window.Create;
  TrayIcon.Create;
  Thread.Start(CloseNagScreen);
  Thread.Start(ProcessWatcher);
  while GetMessage(Msg, 0, 0, 0) do
  begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  end;
end.
