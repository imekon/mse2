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

unit scene.cone;

interface

uses
  GLScene, GLGeomObjects,
  scene.parameter, scene.shape;

type
  TSceneCone = class(TShape)
  public
    constructor Create; override;
    function BuildGLSceneObject(owner: TGLBaseSceneObject): TGLBaseSceneObject; override;
    procedure UpdateGLSceneObject; override;
  end;

implementation

{ TSceneCone }

function TSceneCone.BuildGLSceneObject(
  owner: TGLBaseSceneObject): TGLBaseSceneObject;
var
  cylinder: TGLCylinder;

begin
  // Cylinder, because it has Top and Bottom radius, whereas Cone doesn't
  cylinder := owner.AddNewChild(TGLCylinder) as TGLCylinder;
  result := cylinder;
end;

constructor TSceneCone.Create;
begin
  inherited;
  AddStandardParameters;
  _parameterManager.AddParameter<TSingleValue>('top',
    TSingleValue.Create(0.0),
    TSceneParameterGroup.Details);
  _parameterManager.AddParameter<TSingleValue>('bottom',
    TSingleValue.Create(1.0),
    TSceneParameterGroup.Details);
end;

procedure TSceneCone.UpdateGLSceneObject;
var
  top, bottom: TSingleValue;
  cylinder: TGLCylinder;

begin
  UpdateStandardParameters;
  top := GetParameter<TSingleValue>('top');
  bottom := GetParameter<TSingleValue>('bottom');
  cylinder := _object as TGLCylinder;
  cylinder.TopRadius := top.Value;
  cylinder.BottomRadius := bottom.Value;
end;

end.
