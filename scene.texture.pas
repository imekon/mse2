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

unit scene.texture;

interface

uses
  scene.parameter, scene.parameter.manager, scene.colour;

type
  TSceneTexture = class
  protected
    _parameters: TSceneParameterManager;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  end;

implementation

{ TSceneTexture }

constructor TSceneTexture.Create;
begin
  _parameters := TSceneParameterManager.Create;

  _parameters.AddParameter<TStringValue>('name', TStringValue.Create('untitled'), TSceneParameterGroup.Basic);
  _parameters.AddParameter<TSceneColourAlpha>('colour', TSceneColourAlpha.Create(1.0, 0.0, 0.0, 1.0), TSceneParameterGroup.Colour);
end;

destructor TSceneTexture.Destroy;
begin
  _parameters.Free;
  inherited;
end;

end.
