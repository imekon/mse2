unit scene;

interface

uses
  System.SysUtils, System.Generics.Collections,
  scene.shape, scene.camera;

type
  ESceneBadShape = class(Exception)
  end;

  TSceneView = (Camera, Front, Back, Top, Bottom, Left, Right, None);

  TScene = class
  private
    _counter: integer;
    _camera: TSceneCamera;
    _shapes: TObjectList<TShape>;
    _view: TSceneView;
    _registration: TDictionary<string, TShapeType>;
    procedure RegisterShape(const name: string; shapeType: TShapeType);
    function GetShape(index: integer): TShape;
    function GetShapeCount: integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure CreateShape(const name: string);
    procedure AddShape(shape: TShape);
    procedure RemoveShape(shape: TShape);

    property Camera: TSceneCamera read _camera;
    property View: TSceneView read _view write _view;
    property ShapeCount: integer read GetShapeCount;
    property Shapes[index: integer]: TShape read GetShape;
  end;

implementation

{ TScene }

uses scene.light.spot, scene.plane, scene.cube, scene.sphere;

procedure TScene.AddShape(shape: TShape);
begin
  _shapes.Add(shape);
end;

constructor TScene.Create;
begin
  _counter := 1;

  _shapes := TObjectList<TShape>.Create;
  _registration := TDictionary<string, TShapeType>.Create;

  _camera := nil;
  _view := TSceneView.Front;

  RegisterShape('camera', TSceneCamera);
  RegisterShape('pointlight', TSceneSpotLight);
  RegisterShape('plane', TScenePlane);
  RegisterShape('cube', TSceneCube);
  RegisterShape('sphere', TSceneSphere);
end;

procedure TScene.CreateShape(const name: string);
var
  shapeType: TShapeType;
  shape: TShape;

begin
  if _registration.ContainsKey(name) then
  begin
    shapeType := _registration[name];
    shape := shapeType.Create;
    shape.Name := name + IntToStr(_counter);
    inc(_counter);

    if shape is TSceneCamera then
      _camera := shape as TSceneCamera;

    AddShape(shape);
  end
  else
    raise ESceneBadShape.Create('Failed to create shape: ' + name);
end;

destructor TScene.Destroy;
begin
  _registration.Free;
  _shapes.Free;
  inherited;
end;

function TScene.GetShape(index: integer): TShape;
begin
  result := _shapes[index];
end;

function TScene.GetShapeCount: integer;
begin
  result := _shapes.Count;
end;

procedure TScene.RegisterShape(const name: string; shapeType: TShapeType);
begin
  _registration.Add(name, shapeType);
end;

procedure TScene.RemoveShape(shape: TShape);
begin
  _shapes.Remove(shape);
end;

end.
