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

unit scene.camera;

interface

uses
  System.Classes, System.SysUtils, System.JSON,
  GLScene,
  helper.JSON,
  scene.vector, scene.shape, scene.parameter;

type
  TSceneCamera = class(TShape)
  public
    constructor Create; override;
    function GetType: string; override;
    procedure Load(obj: TJSONObject); override;
    procedure Save(obj: TJSONObject); override;
    function BuildGLSceneObject(owner: TGLBaseSceneObject): TGLBaseSceneObject; override;
    procedure UpdateGLSceneObject; override;
  end;

implementation

{ TSceneCamera }

function TSceneCamera.BuildGLSceneObject(owner: TGLBaseSceneObject): TGLBaseSceneObject;
begin
  result := nil;
end;

constructor TSceneCamera.Create;
begin
  inherited;
  _parameterManager.AddParameter<TVectorValue>('position', TVectorValue.Create(0.0, 0.0, 5.0), TSceneParameterGroup.Camera, false);
  _parameterManager.AddParameter<TVectorValue>('lookat', TVectorValue.Create(0.0, 0.0, 0.0), TSceneParameterGroup.Camera, false);
end;

function TSceneCamera.GetType: string;
begin
  result := 'camera';
end;

procedure TSceneCamera.Load(obj: TJSONObject);
begin
  inherited;
end;

procedure TSceneCamera.Save(obj: TJSONObject);
begin
  obj.AddPair('shape', 'camera');
  inherited;
end;

procedure TSceneCamera.UpdateGLSceneObject;
begin
  raise Exception.Create('Not Implemented Yet');
end;

end.
