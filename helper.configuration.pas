unit helper.configuration;

interface

uses
  System.Win.Registry, Winapi.Windows;

type
  THelperConfiguration = class
  private
    _path: string;
  public
    constructor Create;
    property Path: string read _path;
  end;

implementation

{ THelperConfiguration }

constructor THelperConfiguration.Create;
var
  reg: TRegistry;

begin
  reg := TRegistry.Create(KEY_READ);
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    if reg.OpenKey('SOFTWARE\GNU\Model Scene Editor 2\Setup', false) then
      _path := reg.ReadString('Path');
  finally
    reg.Free;
  end;
end;

end.
