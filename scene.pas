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
  scene.shape, scene.camera, scene.template.manager, scene.template;

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
    function GenerateShapes(template: TSceneTemplate): string;
    function ProcessFormat(format: string; shape: TShape): string;
  public
    constructor Create;
    destructor Destroy; override;
    function CreateShape(const name: string): TShape;
    procedure Clear;
    procedure AddShape(shape: TShape);
    procedure RemoveShape(shape: TShape);
    procedure Save(const filename: string);
    procedure Load(const filename: string);
    procedure GenerateScene(sceneTemplateManager: TSceneTemplateManager;
      const name, filename: string);

    property Camera: TSceneCamera read _camera;
    property View: TSceneView read _view write _view;
    property ShapeCount: integer read GetShapeCount;
    property Shapes[index: integer]: TShape read GetShape;
  end;

implementation

{ TScene }

uses
  scene.light.spot, scene.plane, scene.cube, scene.sphere, scene.cylinder,
  scene.cone, helper.strings, scene.parameter;

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

procedure TScene.GenerateScene(sceneTemplateManager: TSceneTemplateManager;
  const name, filename: string);
var
  data: TStringBuilder;
  sceneTemplate: TSceneTemplate;

begin
  data := TStringBuilder.Create;
  sceneTemplate := sceneTemplateManager.FindTemplate(name);
  if assigned(sceneTemplate) then
    data.AppendLine(GenerateShapes(sceneTemplate));
  TFile.WriteAllText(filename, data.ToString);
  data.Free;
end;

function TScene.GenerateShapes(template: TSceneTemplate): string;
var
  data: TStringBuilder;
  format, text: string;
  shape: TShape;
  section, obj: TSceneTemplateSection;

begin
  data := TStringBuilder.Create;
  obj := template.FindSection('object');
  for shape in _shapes do
  begin
    section := template.FindSection(shape.GetType);
    if assigned(section) then
    begin
      format := StringReplace(section.Data, '${object}', obj.Data, []);
      text := ProcessFormat(format, shape);
      data.AppendLine(text);
    end;
  end;
  result := data.ToString;
  data.Free;
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

function TScene.ProcessFormat(format: string; shape: TShape): string;
var
  escape, negate: boolean;
  i: integer;
  ch, chNext: char;
  parameter, paramName, arg: string;
  data, token: TStringBuilder;
  paramObj: TSceneParameter;

begin
  escape := false;

  data := TStringBuilder.Create;
  token := TStringBuilder.Create;

  for i := 1 to Length(format) do
  begin
    ch := format[i];
    if i < Length(format) then
      chNext := format[i + 1]
    else
      chNext := chr(0);

    if escape then
    begin
      if (ch <> '{') and (ch <> '}') then
        token.Append(ch);

      if ch = '}' then
      begin
        parameter := token.ToString;

        if THelperStrings.IsSubParameter(parameter) then
        begin
          THelperStrings.SplitSubParameter(parameter, negate, paramName, arg);
          paramObj := shape.FindParameterObject(paramName);
          data.Append(paramObj.GetField(arg, negate));
        end
        else
          data.Append(shape.FindParameter(parameter));

        escape := false;
      end;
    end
    else
    begin
      if (ch = '$') and (chNext = '{') then
      begin
        token.Clear;
        escape := true;
      end
      else
        data.Append(ch);
    end;
  end;

  result := data.ToString;

  token.Free;
  data.Free;
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
