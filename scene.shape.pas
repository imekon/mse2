unit scene.shape;

interface

uses
  scene.vector, scene.parameter, scene.parameter.manager;

type
  TShape = class
  private
    function GetName: string;
    procedure SetName(const Value: string);
  protected
    _parameterManager: TSceneParameterManager;

    procedure AddStandardParameters;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function GetParameter<TType: TSceneValue>(const name: string): TType;
    procedure SetParameter<TType: TSceneValue>(const name: string; value: TType);

    property Name: string read GetName write SetName;
  end;

  TShapeType = class of TShape;

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
  _parameterManager.AddParameter<TStringValue>('texture',
    TStringValue.Create('unknown'), TSceneParameterGroup.Texture);
end;

constructor TShape.Create;
begin
  _parameterManager := TSceneParameterManager.Create;
  _parameterManager.AddParameter<TStringValue>('name',
    TStringValue.Create('untitled'), TSceneParameterGroup.Basic);
end;

destructor TShape.Destroy;
begin
  _parameterManager.Free;
  inherited;
end;

function TShape.GetName: string;
var
  name: TStringValue;

begin
  name := GetParameter<TStringValue>('name');
  result := name.Value;
end;

function TShape.GetParameter<TType>(const name: string): TType;
begin
  result := _parameterManager.GetParameter<TType>(name);
end;

procedure TShape.SetName(const Value: string);
begin
  SetParameter('name', TStringValue.Create(value));
end;

procedure TShape.SetParameter<TType>(const name: string; value: TType);
begin
  _parameterManager.SetParameter<TType>(name, value);
end;

end.
