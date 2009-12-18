unit Threads;

interface

uses
  Windows;

type
  TProcedure = procedure;

type
  Thread = packed record
  public
    class procedure Start(ThreadProc: TProcedure); static;
  end;

implementation

class procedure Thread.Start(ThreadProc: TProcedure);
var
  lpThreadId: DWORD;
begin
  CreateThread(nil, 0, @ThreadProc, nil, 0, lpThreadId);
end;

end.
