unit helper.logger;

interface

uses
  System.SysUtils;

type
  TLoggerSeverity = (Information, Warning, Error, Fatal);

  TLogger = class
  public
    procedure Log(severity: TLoggerSeverity; const fmt: string; const args: array of const); virtual; abstract;
  end;

  TFileLogger = class(TLogger)
  private
    _output: TextFile;
  public
    constructor Create(const filename: string);
    procedure Log(severity: TLoggerSeverity; const fmt: string; const args: array of const); override;
    destructor Destroy; override;
  end;

implementation

{ TFileLogger }

constructor TFileLogger.Create(const filename: string);
begin
  AssignFile(_output, filename);
  Rewrite(_output);
end;

destructor TFileLogger.Destroy;
begin
  CloseFile(_output);
  inherited;
end;

procedure TFileLogger.Log(severity: TLoggerSeverity; const fmt: string; const args: array of const);
var
  text: string;

begin
  text := Format(fmt, args);

  case severity of
    Information:  WriteLn(_output, 'INFO:  ' + text);
    Warning:      WriteLn(_output, 'WARN:  ' + text);
    Error:        WriteLn(_output, 'ERROR: ' + text);
    Fatal:        WriteLn(_output, 'FATAL: ' + text);
  end;
end;

end.
