//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 1, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
//

// Author: Pete Goodwin (mse@imekon.org)

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

uses
  scene.light.spot, scene.plane, scene.cube, scene.sphere, scene.cylinder,
  scene.cone;

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
  RegisterShape('cylinder', TSceneCylinder);
  RegisterShape('cone', TSceneCone);
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
