unit scene.shape;

interface

uses
  scene.vector, scene.parameter, scene.parameter.manager;

type
  TShape = class
  protected
    _parameterManager: TSceneParameterManager;

    procedure AddStandardParameters;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function GetParameter<TType>(const name: string): TType;
    procedure SetParameter<TType>(const name: string; value: TType);
  end;

implementation

{ TShape }

procedure TShape.AddStandardParameters;
begin
  _parameterManager.AddParameter<TSceneVector>('translate', TSceneVector.Create,
    TSceneParameterGroup.Transform);
  _parameterManager.AddParameter<TSceneVector>('scale',
    TSceneVector.Create(1.0, 1.0, 1.0), TSceneParameterGroup.Transform);
  _parameterManager.AddParameter<TSceneVector>('rotate', TSceneVector.Create,
    TSceneParameterGroup.Transform);
  _parameterManager.AddParameter<string>('texture', 'unknown', TSceneParameterGroup.Texture);
end;

constructor TShape.Create;
begin
  _parameterManager := TSceneParameterManager.Create;
  _parameterManager.AddParameter<string>('name', 'untitled', TSceneParameterGroup.Basic);
end;

destructor TShape.Destroy;
begin
  _parameterManager.Free;
  inherited;
end;

function TShape.GetParameter<TType>(const name: string): TType;
begin
  result := _parameterManager.GetParameter<TType>(name);
end;

procedure TShape.SetParameter<TType>(const name: string; value: TType);
begin
  _parameterManager.SetParameter<TType>(name, value);
end;

end.
