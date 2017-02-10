unit scene.shape;

interface

uses
  scene.vector, scene.parameter, scene.parameter.manager;

type
  TShapeState = (Add, Edit, Delete);
  TShapeStatus = set of TShapeState;

  TShape = class
  private
    _status: TShapeStatus;
    function GetName: string;
    procedure SetName(const Value: string);
    function GetIsAdded: boolean;
    function GetIsDeleted: boolean;
    function GetIsEdited: boolean;
  protected
    _parameterManager: TSceneParameterManager;

    procedure AddStandardParameters;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure ResetStatus;
    function GetParameter<TType: TSceneValue>(const name: string): TType;
    procedure SetParameter<TType: TSceneValue>(const name: string; value: TType);

    property Name: string read GetName write SetName;
    property Status: TShapeStatus read _status;
    property IsAdded: boolean read GetIsAdded;
    property IsEdited: boolean read GetIsEdited;
    property IsDelete: boolean read GetIsDeleted;
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
  _status := [TShapeState.Add];
  _parameterManager := TSceneParameterManager.Create;
  _parameterManager.AddParameter<TStringValue>('name',
    TStringValue.Create('untitled'), TSceneParameterGroup.Basic);
end;

destructor TShape.Destroy;
begin
  _parameterManager.Free;
  inherited;
end;

function TShape.GetIsAdded: boolean;
begin
  result := TShapeState.Add in _status;
end;

function TShape.GetIsDeleted: boolean;
begin
  result := TShapeState.Delete in _status;
end;

function TShape.GetIsEdited: boolean;
begin
  result := TShapeState.Edit in _status;
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

procedure TShape.ResetStatus;
begin
  _status := [];
end;

procedure TShape.SetName(const Value: string);
begin
  SetParameter('name', TStringValue.Create(value));
end;

procedure TShape.SetParameter<TType>(const name: string; value: TType);
begin
  _parameterManager.SetParameter<TType>(name, value);
  _status := _status + [TShapeState.Edit];
end;

end.
