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
  System.IOUtils, System.SysUtils, System.JSON, System.Generics.Collections,
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
    function CreateShape(const name: string): TShape;
    procedure Clear;
    procedure AddShape(shape: TShape);
    procedure RemoveShape(shape: TShape);
    procedure Save(const filename: string);
    procedure Load(const filename: string);
    procedure GenerateScene(const path, name, filename: string);

    property Camera: TSceneCamera read _camera;
    property View: TSceneView read _view write _view;
    property ShapeCount: integer read GetShapeCount;
    property Shapes[index: integer]: TShape read GetShape;
  end;

implementation

{ TScene }

uses
  scene.light.spot, scene.plane, scene.cube, scene.sphere, scene.cylinder,
  scene.cone, scene.template;

procedure TScene.AddShape(shape: TShape);
begin
  _shapes.Add(shape);
end;

procedure TScene.Clear;
begin
  _shapes.Clear;
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

function TScene.CreateShape(const name: string): TShape;
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

    result := shape;
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

procedure TScene.GenerateScene(const path, name, filename: string);
var
  templateFilename: string;
  sceneTemplate: TSceneTemplate;

begin
  sceneTemplate := TSceneTemplate.Create;
  templateFilename := TPath.Combine(path, 'templates\povray.export');
  sceneTemplate.Load(templateFilename);
  sceneTemplate.Free;
end;

function TScene.GetShape(index: integer): TShape;
begin
  result := _shapes[index];
end;

function TScene.GetShapeCount: integer;
begin
  result := _shapes.Count;
end;

procedure TScene.Load(const filename: string);
var
  i, n: integer;
  data, t: string;
  shape: TShape;
  root: TJSONObject;
  shapesArray: TJSONArray;
  obj: TJSONObject;

begin
  Clear;

  data := TFile.ReadAllText(filename);
  root := TJSONObject.ParseJSONValue(data, true) as TJSONObject;
  shapesArray := root.Get('shapes').JsonValue as TJSONArray;
  n := shapesArray.Count;
  for i := 0 to n - 1 do
  begin
    obj := shapesArray.Items[i] as TJSONObject;
    t := obj.GetValue('shape').Value;
    shape := CreateShape(t);
    shape.Load(obj);
  end;
end;

procedure TScene.RegisterShape(const name: string; shapeType: TShapeType);
begin
  _registration.Add(name, shapeType);
end;

procedure TScene.RemoveShape(shape: TShape);
begin
  _shapes.Remove(shape);
end;

procedure TScene.Save(const filename: string);
var
  text: string;
  root: TJSONObject;
  shapesArray: TJSONArray;
  child: TJSONObject;
  shape: TShape;

begin
  root := TJSONObject.Create;
  shapesArray := TJSONArray.Create;

  for shape in _shapes do
  begin
    child := TJSONObject.Create;
    shape.Save(child);
    shapesArray.Add(child);
  end;

  root.AddPair('shapes', shapesArray);
  text := root.ToJSON;
  TFile.WriteAllText(filename, text);
end;

end.
