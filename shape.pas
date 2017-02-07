unit shape;

interface

uses
  scene.parameter.manager;

type
  TShape = class
  protected
    _parameterManager: TSceneParameterManager;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  end;

implementation

{ TShape }

constructor TShape.Create;
begin
  _parameterManager := TSceneParameterManager.Create;
end;

destructor TShape.Destroy;
begin
  _parameterManager.Free;
  inherited;
end;

end.
