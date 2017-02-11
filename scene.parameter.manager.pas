unit scene.parameter.manager;

interface

uses
  System.Generics.Collections,
  scene.parameter;

type
  TSceneParameterManager = class
  private
    _parameters: TList<TSceneParameter>;
    function FindParameter(const name: string): TSceneParameter;
    function GetParameterByIndex(index: integer): TSceneParameter;
    function GetParameterCount: integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddParameter<TType: TSceneValue>(const name: string; value: TType; group: TSceneParameterGroup);
    function GetParameter<TType: TSceneValue>(const name: string): TType;
    procedure SetParameter<TType: TSceneValue>(const name: string; const value: TType);

    property ParameterCount: integer read GetParameterCount;
    property Parameter[index: integer]: TSceneParameter read GetParameterByIndex;
  end;

implementation

{ TSceneParameterManager }

procedure TSceneParameterManager.AddParameter<TType>(const name: string;
  value: TType; group: TSceneParameterGroup);
var
  parameter: TSceneParameter<TType>;

begin
  parameter := TSceneParameter<TType>.Create(name, group);
  parameter.Value := value;
  _parameters.Add(parameter);
end;

constructor TSceneParameterManager.Create;
begin
  _parameters := TList<TSceneParameter>.Create;
end;

destructor TSceneParameterManager.Destroy;
begin
  _parameters.Free;
  inherited;
end;

function TSceneParameterManager.FindParameter(
  const name: string): TSceneParameter;
var
  parameter: TSceneParameter;

begin
  result := nil;
  for parameter in _parameters do
  begin
    if parameter.Name = name then
    begin
      result := parameter;
      break;
    end;
  end;
end;

function TSceneParameterManager.GetParameter<TType>(const name: string): TType;
var
  parameter: TSceneParameter;

begin
  result := nil;
  parameter := FindParameter(name);
  if assigned(parameter) then
    result := (parameter as TSceneParameter<TType>).Value;
end;

function TSceneParameterManager.GetParameterByIndex(
  index: integer): TSceneParameter;
begin
  result := _parameters[index];
end;

function TSceneParameterManager.GetParameterCount: integer;
begin
  result := _parameters.Count;
end;

procedure TSceneParameterManager.SetParameter<TType>(const name: string;
  const value: TType);
var
  parameter: TSceneParameter;

begin
  parameter := FindParameter(name);
  if assigned(parameter) then
    (parameter as TSceneParameter<TType>).Value := value;
end;

end.
