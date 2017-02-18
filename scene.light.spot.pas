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

unit scene.light.spot;

interface

uses
  System.JSON,
  GLScene, GLObjects,
  helper.JSON,
  scene.vector, scene.shape, scene.colour, scene.parameter;

type
  TSceneSpotLight = class(TShape)
  public
    constructor Create; override;
    function GetType: string; override;
    procedure Load(obj: TJSONObject); override;
    procedure Save(obj: TJSONObject); override;
    function BuildGLSceneObject(owner: TGLBaseSceneObject): TGLBaseSceneObject; override;
    procedure UpdateGLSceneObject; override;
  end;

implementation

{ TSceneSpotLight }

function TSceneSpotLight.BuildGLSceneObject(owner: TGLBaseSceneObject): TGLBaseSceneObject;
var
  light: TGLLightSource;

begin
  light := owner.AddNewChild(TGLLightSource) as TGLLightSource;
  result := light;
end;

constructor TSceneSpotLight.Create;
begin
  inherited;
  _parameterManager.AddParameter<TVectorValue>('position', TVectorValue.Create(2.0, 2.0, 2.0), TSceneParameterGroup.Transform, false);
  _parameterManager.AddParameter<TSceneColour>('colour', TSceneColour.Create(1.0, 1.0, 1.0), TSceneParameterGroup.Colour, false);
end;

function TSceneSpotLight.GetType: string;
begin
  result := 'spotlight';
end;

procedure TSceneSpotLight.Load(obj: TJSONObject);
begin
  inherited;
end;

procedure TSceneSpotLight.Save(obj: TJSONObject);
begin
  obj.AddPair('shape', 'pointlight');
  inherited;
end;

procedure TSceneSpotLight.UpdateGLSceneObject;
var
  light: TGLLightSource;
  vector: TVectorValue;
  colour: TSceneColour;

begin
  light := _object as TGLLightSource;

  vector := GetParameter<TVectorValue>('position');
  colour := GetParameter<TSceneColour>('colour');

  light.Position.X := vector.X;
  light.Position.Y := vector.Y;
  light.Position.Z := vector.Z;

  light.Ambient.Red := colour.Red;
  light.Ambient.Green := colour.Green;
  light.Ambient.Blue := colour.Blue;
end;

end.
