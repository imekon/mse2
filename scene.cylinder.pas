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

unit scene.cylinder;

interface

uses
  System.JSON,
  GLScene, GLGeomObjects,
  helper.JSON,
  scene.parameter, scene.shape;

type
  TSceneCylinder = class(TShape)
  public
    constructor Create; override;
    function GetType: string; override;
    procedure Load(obj: TJSONObject); override;
    procedure Save(obj: TJSONObject); override;
    function BuildGLSceneObject(owner: TGLBaseSceneObject): TGLBaseSceneObject; override;
    procedure UpdateGLSceneObject; override;
  end;

implementation

{ TSceneCylinder }

function TSceneCylinder.BuildGLSceneObject(
  owner: TGLBaseSceneObject): TGLBaseSceneObject;
var
  cylinder: TGLCylinder;

begin
  cylinder := owner.AddNewChild(TGLCylinder) as TGLCylinder;
  result := cylinder;
end;

constructor TSceneCylinder.Create;
begin
  inherited;
  AddStandardParameters;
  _parameterManager.AddParameter<TSingleValue>('radius',
    TSingleValue.Create(0.5),
    TSceneParameterGroup.Details, false);
end;

function TSceneCylinder.GetType: string;
begin
  result := 'cylinder';
end;

procedure TSceneCylinder.Load(obj: TJSONObject);
begin
  inherited;
end;

procedure TSceneCylinder.Save(obj: TJSONObject);
begin
  obj.AddPair('shape', 'cylinder');
  inherited;
end;

procedure TSceneCylinder.UpdateGLSceneObject;
var
  radius: TSingleValue;
  cylinder: TGLCylinder;

begin
  UpdateStandardParameters;
  radius := GetParameter<TSingleValue>('radius');
  cylinder := _object as TGLCylinder;
  cylinder.TopRadius := radius.Value;
  cylinder.BottomRadius := radius.Value;
end;

end.
