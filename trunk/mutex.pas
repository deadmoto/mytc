unit mutex;

interface
const
  mutex_all_access=$001F0001;

type
  bool=longbool;
  dword=cardinal;

function createmutex(lpmutexattributes:pointer{psecurityattributes};binitialowner:integer;lpname:pwidechar):thandle;stdcall;
function openmutex(dwdesiredaccess:dword;binherithandle:bool;lpname:pwidechar):thandle;stdcall;

implementation

function createmutex;external 'kernel32.dll' name 'CreateMutexW';
function openmutex;external 'kernel32.dll' name 'OpenMutexW';

end.
