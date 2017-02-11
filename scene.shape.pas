unit scene.shape;

interface

uses
  System.Classes,
  Vcl.ComCtrls,
  GLScene,
  scene.vector, scene.parameter, scene.parameter.manager;

type
  TShapeState = (Add, Edit, Delete);
  TShapeStatus = set of TShapeState;

  TShape = class
  private
    _status: TShapeStatus;
    _treeNode: TTreeNode;
    function GetName: string;
    procedure SetName(const Value: string);
    function GetIsAdded: boolean;
    function GetIsDeleted: boolean;
    function GetIsEdited: boolean;
  protected
    _object: TGLBaseSceneObject;
    _parameterManager: TSceneParameterManager;

    procedure AddStandardParameters;
    procedure UpdateStandardParameters;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure ResetStatus;
    function GetParameter<TType: TSceneValue>(const name: string): TType;
    procedure SetParameter<TType: TSceneValue>(const name: string; value: TType);
    function BuildGLSceneObject(owner: TGLBaseSceneObject): TGLBaseSceneObject; virtual; abstract;
    procedure UpdateGLSceneObject; virtual; abstract;

    property Name: string read GetName write SetName;
    property Status: TShapeStatus read _status;
    property IsAdded: boolean read GetIsAdded;
    property IsEdited: boolean read GetIsEdited;
    property IsDelete: boolean read GetIsDeleted;
    property TreeNode: TTreeNode read _treeNode write _treeNode;
    property GLSceneObject: TGLBaseSceneObject read _object write _object;
    property ParameterManager: TSceneParameterManager read _parameterManager;
  end;

  TShapeType = class of TShape;

implementation

{ TShape }

procedure TShape.AddStandardParameters;
begin
  _parameterManager.AddParameter<TSceneVector>('translate',
    TSceneVector.Create(0.0, 0.0, 0.0),
    TSceneParameterGroup.Transform);
  _parameterManager.AddParameter<TSceneVector>('scale',
    TSceneVector.Create(1.0, 1.0, 1.0), TSceneParameterGroup.Transform);
  _parameterManager.AddParameter<TSceneVector>('rotate',
    TSceneVector.Create(0.0, 0.0, 0.0),
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
  _treeNode := nil;
  _object := nil;
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

procedure TShape.UpdateStandardParameters;
var
  position, scale, rotate: TSceneVector;

begin
  position := GetParameter<TSceneVector>('translate');
  scale := GetParameter<TSceneVector>('scale');
  rotate := GetParameter<TSceneVector>('rotate');

  _object.Position.X := position.X;
  _object.Position.Y := position.Y;
  _object.Position.Z := position.Z;

  _object.Scale.X := scale.X;
  _object.Scale.Y := scale.Y;
  _object.Scale.Z := scale.Z;

  // TODO: These are probably wrong!
  _object.Turn(rotate.X);
  _object.Roll(rotate.Y);
  _object.Pitch(rotate.Z);
end;

end.
