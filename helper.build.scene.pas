unit helper.build.scene;

interface

uses
  System.SysUtils, GLScene, GLVectorTypes,
  scene, scene.shape;

type
  EInvalidCamera = class(Exception)
  end;

  THelperBuildScene = class
  private
    _root: TGLSceneRootObject;
    _camera: TGLCamera;
    _scene: TScene;
    _view: TSceneView;

    procedure UpdateCamera;
    procedure UpdateObjects;

    procedure SetCamera;
    procedure SetCameraToFront;
    procedure SetCameraToBack;
    procedure SetCameraToTop;
    procedure SetCameraToBottom;
    procedure SetCameraToLeft;
    procedure SetCameraToRight;
    procedure SetCameraToNone;

    procedure AddShape(shape: TShape);
    procedure EditShape(shape: TShape);
    procedure DeleteShape(shape: TShape);
  public
    constructor Create(root: TGLSceneRootObject; camera: TGLCamera; scene: TScene);
    procedure Build;
  end;

implementation

{ THelperBuildScene }

procedure SetVector(var vector: TVector4f; x, y, z: single; w: single = 1.0);
begin
  vector.X := x;
  vector.Y := y;
  vector.Z := z;
  vector.W := w;
end;

procedure SetVectorAbsoluteCenter(var vector: TVector4f);
begin
  SetVector(vector, 0.0, 0.0, 0.0);
end;

procedure SetVectorUp(var vector: TVector4f);
begin
  SetVector(vector, 0.0, 1.0, 0.0);
end;

procedure THelperBuildScene.AddShape(shape: TShape);
var
  obj: TGLBaseSceneObject;

begin
  obj := shape.BuildGLSceneObject(_root);
  obj.Name := shape.Name;
end;

procedure THelperBuildScene.Build;
begin
  UpdateCamera;
  UpdateObjects;
end;

constructor THelperBuildScene.Create(root: TGLSceneRootObject;
  camera: TGLCamera; scene: TScene);
begin
  _root := root;
  _camera := camera;
  _scene := scene;
  _view := TSceneView.None;
end;

procedure THelperBuildScene.DeleteShape(shape: TShape);
begin

end;

procedure THelperBuildScene.EditShape(shape: TShape);
begin

end;

procedure THelperBuildScene.SetCamera;
begin
  //
end;

procedure THelperBuildScene.SetCameraToBack;
var
  AbsoluteCenter: TVector4f;
  UpVector: TVector4f;

begin
  SetVectorAbsoluteCenter(AbsoluteCenter);
  SetVector(UpVector, 0.0, 1.0, 0.0);

  _camera.CameraStyle := TGLCameraStyle.csOrtho2D;
  _camera.Position.X := 0.0;
  _camera.Position.Y := 0.0;
  _camera.Position.Z := -1000.0;
  _camera.PointTo(AbsoluteCenter, UpVector);
end;

procedure THelperBuildScene.SetCameraToBottom;
begin

end;

procedure THelperBuildScene.SetCameraToFront;
var
  AbsoluteCenter: TVector4f;
  UpVector: TVector4f;

begin
  SetVectorAbsoluteCenter(AbsoluteCenter);
  SetVector(UpVector, 0.0, 1.0, 0.0);

  _camera.CameraStyle := TGLCameraStyle.csOrtho2D;
  _camera.Position.X := 0.0;
  _camera.Position.Y := 0.0;
  _camera.Position.Z := 1000.0;
  _camera.PointTo(AbsoluteCenter, UpVector);
end;

procedure THelperBuildScene.SetCameraToLeft;
begin

end;

procedure THelperBuildScene.SetCameraToNone;
begin
  raise(EInvalidCamera.Create('View set to none'));
end;

procedure THelperBuildScene.SetCameraToRight;
begin

end;

procedure THelperBuildScene.SetCameraToTop;
begin

end;

procedure THelperBuildScene.UpdateCamera;
begin
  if _scene.View <> _view then
  begin
    _view := _scene.View;

    case _view of
      Camera:   SetCamera;
      Front:    SetCameraToFront;
      Back:     SetCameraToBack;
      Top:      SetCameraToTop;
      Bottom:   SetCameraToBottom;
      Left:     SetCameraToLeft;
      Right:    SetCameraToRight;
      None:     SetCameraToNone;
    end;
  end;
end;

procedure THelperBuildScene.UpdateObjects;
var
  i: integer;
  shape: TShape;

begin
  for i := 0 to _scene.ShapeCount - 1 do
  begin
    shape := _scene.Shapes[i];
    if shape.IsAdded then
      AddShape(shape)
    else if shape.IsEdited then
      EditShape(shape)
    else if shape.IsDelete then
      DeleteShape(shape);
  end;
end;

end.