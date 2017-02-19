unit helper.configuration;

interface

uses
  System.SysUtils, System.IOUtils,
  System.Win.Registry, Winapi.Windows,
  helper.logger;

type
  THelperConfiguration = class
  private
    _path: string;
  public
    constructor Create(logger: TLogger);
    property Path: string read _path;
  end;

implementation

{ THelperConfiguration }

constructor THelperConfiguration.Create(logger: TLogger);
var
  reg: TRegistry;

begin
  reg := TRegistry.Create(KEY_READ);
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    if reg.OpenKey('SOFTWARE\GNU\Model Scene Editor 2\Setup', false) then
      _path := reg.ReadString('Path')
    else
      _path := TDirectory.GetCurrentDirectory;

    logger.Log(TLoggerSeverity.Information, 'Configuration path: %s', [_path]);
  finally
    reg.Free;
  end;
end;

end.
