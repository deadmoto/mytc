unit NagScreen;

interface

uses
  Messages,
  Windows;

procedure CloseNagScreen;

implementation

procedure CloseNagScreen;
var
  NastyNagScreen: HWND;
  Notebook: HWND;
  Page: HWND;
  Panel: HWND;
  NumPanel: HWND;
  NumButton: HWND;
  NumText: string;
  RepeatCount: integer;
begin
  while True do
  begin
    NastyNagScreen := 0;
    Notebook := 0;
    Page := 0;
    Panel := 0;
    NumPanel := 0;
    NumButton := 0;
    NumText := '';
    RepeatCount := 0;
    while (NastyNagScreen = 0) do
    begin
      NastyNagScreen := FindWindow('TNASTYNAGSCREEN', nil);
      Sleep(1);
    end;
    while (Notebook = 0) and (RepeatCount < 100) do
    begin
      Notebook := FindWindowEx(NastyNagScreen, 0, 'TNotebook', nil);
      Inc(RepeatCount);
    end;
    while (Page = 0) and (RepeatCount < 100) do
    begin
      Page := FindWindowEx(Notebook, 0, 'TPage', nil);
      Inc(RepeatCount);
    end;
    while (Panel = 0) and (RepeatCount < 100) do
    begin
      Panel := FindWindowEx(Page, 0, 'TPanel', nil);
      Inc(RepeatCount);
    end;
    while (NumPanel = 0) and (RepeatCount < 100) do
    begin
      NumPanel := FindWindowEx(Panel, 0, 'TPanel', nil);
      Inc(RepeatCount);
    end;
    while (NumButton = 0) and (RepeatCount < 100) do
    begin
      SetLength(NumText, SendMessage(NumPanel, WM_GETTEXTLENGTH, 0, 0));
      SendMessage(NumPanel, WM_GETTEXT, Length(NumText) + 1, LPARAM(NumText));
      NumButton := FindWindowEx(Panel, 0, 'TButton', PChar('&' + NumText));
      Inc(RepeatCount);
    end;
    SendMessage(NumButton, BM_CLICK, 0, 0);
  end;
end;

end.
