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

unit scene.sphere;

interface

uses
  GLScene, GLObjects,
  scene.vector, scene.shape;

type
  TSceneSphere = class(TShape)
  public
    constructor Create; override;
    function BuildGLSceneObject(owner: TGLBaseSceneObject): TGLBaseSceneObject; override;
    procedure UpdateGLSceneObject; override;
  end;

implementation

{ TSceneSphere }

function TSceneSphere.BuildGLSceneObject(
  owner: TGLBaseSceneObject): TGLBaseSceneObject;
var
  sphere: TGLSphere;

begin
  sphere := owner.AddNewChild(TGLSphere) as TGLSphere;
  result := sphere;
end;

constructor TSceneSphere.Create;
begin
  inherited;
  AddStandardParameters;
end;

procedure TSceneSphere.UpdateGLSceneObject;
begin
  UpdateStandardParameters;
end;

end.
