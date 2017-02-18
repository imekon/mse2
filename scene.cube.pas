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

unit scene.cube;

interface

uses
  System.Classes, System.JSON,
  GLScene, GLObjects,
  helper.JSON,
  scene.shape;

type
  TSceneCube = class(TShape)
  public
    constructor Create; override;
    function GetType: string; override;
    procedure Load(obj: TJSONObject); override;
    procedure Save(obj: TJSONObject); override;
    function BuildGLSceneObject(owner: TGLBaseSceneObject): TGLBaseSceneObject; override;
    procedure UpdateGLSceneObject; override;
  end;

implementation

{ TSceneCube }

function TSceneCube.BuildGLSceneObject(owner: TGLBaseSceneObject): TGLBaseSceneObject;
var
  cube: TGLCube;

begin
  cube := owner.AddNewChild(TGLCube) as TGLCube;
  result := cube;
end;

constructor TSceneCube.Create;
begin
  inherited;
  AddStandardParameters;
end;

function TSceneCube.GetType: string;
begin
  result := 'cube';
end;

procedure TSceneCube.Load(obj: TJSONObject);
begin
  inherited;
end;

procedure TSceneCube.Save(obj: TJSONObject);
begin
  obj.AddPair('shape', 'cube');
  inherited;
end;

procedure TSceneCube.UpdateGLSceneObject;
begin
  UpdateStandardParameters;
end;

end.
