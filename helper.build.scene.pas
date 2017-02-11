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
    _glScene: TGLScene;
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
    constructor Create(GLScene: TGLSCene; root: TGLSceneRootObject;
      camera: TGLCamera; scene: TScene);
    procedure Build;
  end;

implementation

{ THelperBuildScene }

uses scene.camera;

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
  if assigned(obj) then
  begin
    shape.GLSceneObject := obj;
    obj.Name := shape.Name;
    shape.UpdateGLSceneObject;
  end;
end;

procedure THelperBuildScene.Build;
begin
  UpdateCamera;
  UpdateObjects;
end;

constructor THelperBuildScene.Create(GLScene: TGLSCene; root: TGLSceneRootObject;
  camera: TGLCamera; scene: TScene);
begin
  _glScene := GLScene;
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
var
  AbsoluteCenter: TVector4f;
  UpVector: TVector4f;

begin
  SetVectorAbsoluteCenter(AbsoluteCenter);
  SetVector(UpVector, 0.0, 1.0, 0.0);

  _camera.CameraStyle := TGLCameraStyle.csPerspective;
  _camera.Position.X := 0.0;
  _camera.Position.Y := 0.0;
  _camera.Position.Z := 5.0;
  _camera.PointTo(AbsoluteCenter, UpVector);
end;

procedure THelperBuildScene.SetCameraToBack;
var
  AbsoluteCenter: TVector4f;
  UpVector: TVector4f;

begin
  SetVectorAbsoluteCenter(AbsoluteCenter);
  SetVector(UpVector, 0.0, 1.0, 0.0);

  _camera.CameraStyle := TGLCameraStyle.csOrthogonal;
  _camera.Position.X := 0.0;
  _camera.Position.Y := 0.0;
  _camera.Position.Z := -5.0;
  _camera.PointTo(AbsoluteCenter, UpVector);
end;

procedure THelperBuildScene.SetCameraToBottom;
var
  AbsoluteCenter: TVector4f;
  UpVector: TVector4f;

begin
  SetVectorAbsoluteCenter(AbsoluteCenter);
  SetVector(UpVector, 0.0, 0.0, 1.0);

  _camera.CameraStyle := TGLCameraStyle.csOrthogonal;
  _camera.Position.X := 0.0;
  _camera.Position.Y := -5.0;
  _camera.Position.Z := 0.0;
  _camera.PointTo(AbsoluteCenter, UpVector);
end;

procedure THelperBuildScene.SetCameraToFront;
var
  AbsoluteCenter: TVector4f;
  UpVector: TVector4f;

begin
  SetVectorAbsoluteCenter(AbsoluteCenter);
  SetVector(UpVector, 0.0, 1.0, 0.0);

  _camera.CameraStyle := TGLCameraStyle.csOrthogonal;
  _camera.Position.X := 0.0;
  _camera.Position.Y := 0.0;
  _camera.Position.Z := 5.0;
  _camera.PointTo(AbsoluteCenter, UpVector);
end;

procedure THelperBuildScene.SetCameraToLeft;
var
  AbsoluteCenter: TVector4f;
  UpVector: TVector4f;

begin
  SetVectorAbsoluteCenter(AbsoluteCenter);
  SetVector(UpVector, 0.0, 1.0, 0.0);

  _camera.CameraStyle := TGLCameraStyle.csOrthogonal;
  _camera.Position.X := -5.0;
  _camera.Position.Y := 0.0;
  _camera.Position.Z := 0.0;
  _camera.PointTo(AbsoluteCenter, UpVector);
end;

procedure THelperBuildScene.SetCameraToNone;
begin
  raise(EInvalidCamera.Create('View set to none'));
end;

procedure THelperBuildScene.SetCameraToRight;
var
  AbsoluteCenter: TVector4f;
  UpVector: TVector4f;

begin
  SetVectorAbsoluteCenter(AbsoluteCenter);
  SetVector(UpVector, 0.0, 1.0, 0.0);

  _camera.CameraStyle := TGLCameraStyle.csOrthogonal;
  _camera.Position.X := 5.0;
  _camera.Position.Y := 0.0;
  _camera.Position.Z := 0.0;
  _camera.PointTo(AbsoluteCenter, UpVector);
end;

procedure THelperBuildScene.SetCameraToTop;
var
  AbsoluteCenter: TVector4f;
  UpVector: TVector4f;

begin
  SetVectorAbsoluteCenter(AbsoluteCenter);
  SetVector(UpVector, 0.0, 0.0, -1.0);

  _camera.CameraStyle := TGLCameraStyle.csOrthogonal;
  _camera.Position.X := 0.0;
  _camera.Position.Y := 5.0;
  _camera.Position.Z := 0.0;
  _camera.PointTo(AbsoluteCenter, UpVector);
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
    if not (shape is TSceneCamera) then
    begin
      if shape.IsAdded then
        AddShape(shape)
      else if shape.IsEdited then
        EditShape(shape)
      else if shape.IsDelete then
        DeleteShape(shape);
    end;
  end;
end;

end.
