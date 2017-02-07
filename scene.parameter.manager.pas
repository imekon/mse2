unit scene.parameter.manager;

interface

uses
  System.Generics.Collections,
  scene.parameter;

type
  TSceneParameterManager = class
  private
    _parameters: TDictionary<string, TSceneParameter>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddParameter<TType>(const name: string; value: TType; group: TSceneParameterGroup);
    function GetParameter<TType>(const name: string): TType;
    procedure SetParameter<TType>(const name: string; const value: TType);
    procedure GetParameterNames(list: TList<string>);
    function GetParameters: TArray<TPair<string, TSceneParameter>>;
  end;

implementation

{ TSceneParameterManager }

procedure TSceneParameterManager.AddParameter<TType>(const name: string;
  value: TType; group: TSceneParameterGroup);
var
  parameter: TSceneParameter<TType>;

begin
  parameter := TSceneParameter<TType>.Create(name, group);
  _parameters.Add(name, parameter);
end;

constructor TSceneParameterManager.Create;
begin
  _parameters := TDictionary<string, TSceneParameter>.Create;
end;

destructor TSceneParameterManager.Destroy;
begin
  _parameters.Free;
  inherited;
end;

function TSceneParameterManager.GetParameter<TType>(const name: string): TType;
var
  parameter: TSceneParameter;

begin
  parameter := _parameters[name];
  result := (parameter as TSceneParameter<TType>).Value;
end;

function TSceneParameterManager.GetParameters: TArray<TPair<string, TSceneParameter>>;
begin
  result := _parameters.ToArray;
end;

procedure TSceneParameterManager.GetParameterNames(list: TList<string>);
var
  name: string;

begin
  for name in _parameters.Keys do
    list.Add(name);
end;

procedure TSceneParameterManager.SetParameter<TType>(const name: string;
  const value: TType);
var
  parameter: TSceneParameter;

begin
  parameter := _parameters[name];
  (parameter as TSceneParameter<TType>).Value := value;
end;

end.
