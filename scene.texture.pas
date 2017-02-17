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
  System.JSON,
  helper.JSON,
  scene.parameter, scene.parameter.manager, scene.colour;

type
  TSceneTexture = class
  private
    function GetColour: string;
    function GetName: string;
    procedure SetColour(const Value: string);
    procedure SetName(const Value: string);
  protected
    _parameters: TSceneParameterManager;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Load(obj: TJSONObject); virtual;
    procedure Save(obj: TJSONObject); virtual;
    property Name: string read GetName write SetName;
    property Colour: string read GetColour write SetColour;
  end;

  TSceneTextureType = class of TSceneTexture;

implementation

{ TSceneTexture }

constructor TSceneTexture.Create;
begin
  _parameters := TSceneParameterManager.Create;

  _parameters.AddParameter<TStringValue>('name', TStringValue.Create('untitled'), TSceneParameterGroup.Basic, false);
  _parameters.AddParameter<TSceneColourAlpha>('colour', TSceneColourAlpha.Create(1.0, 0.0, 0.0, 1.0), TSceneParameterGroup.Colour, false);
  _parameters.AddParameter<TSingleValue>('diffuse', TSingleValue.Create(0.7), TSceneParameterGroup.Texture, false);
  _parameters.AddParameter<TSingleValue>('brilliance', TSingleValue.Create(1.0), TSceneParameterGroup.Texture, false);
  _parameters.AddParameter<TSingleValue>('crand', TSingleValue.Create(0.0), TSceneParameterGroup.Texture, false);
  _parameters.AddParameter<TSingleValue>('ambient', TSingleValue.Create(0.1), TSceneParameterGroup.Texture, false);
  _parameters.AddParameter<TSingleValue>('reflection', TSingleValue.Create(0.0), TSceneParameterGroup.Texture, false);
  _parameters.AddParameter<TSingleValue>('phong', TSingleValue.Create(0.0), TSceneParameterGroup.Texture, false);
  _parameters.AddParameter<TSingleValue>('phongsize', TSingleValue.Create(0.0), TSceneParameterGroup.Texture, false);
  _parameters.AddParameter<TSingleValue>('specular', TSingleValue.Create(0.0), TSceneParameterGroup.Texture, false);
  _parameters.AddParameter<TSingleValue>('roughness', TSingleValue.Create(0.05), TSceneParameterGroup.Texture, false);
  _parameters.AddParameter<TSingleValue>('refraction', TSingleValue.Create(0.0), TSceneParameterGroup.Texture, false);
  _parameters.AddParameter<TSingleValue>('ior', TSingleValue.Create(0.0), TSceneParameterGroup.Texture, false);
end;

destructor TSceneTexture.Destroy;
begin
  _parameters.Free;
  inherited;
end;

function TSceneTexture.GetColour: string;
begin
  result := _parameters.GetParameter<TSceneColourAlpha>('colour').ToString;
end;

function TSceneTexture.GetName: string;
begin
  result := _parameters.GetParameter<TStringValue>('name').Value;
end;

procedure TSceneTexture.Load(obj: TJSONObject);
begin
  _parameters.Load(obj);
end;

procedure TSceneTexture.Save(obj: TJSONObject);
begin
  obj.AddPair('texture', 'colour');
  _parameters.Save(obj);
end;

procedure TSceneTexture.SetColour(const Value: string);
var
  colour: TSceneColourAlpha;

begin
  colour := TSceneColourAlpha.Create(0.0, 0.0, 0.0, 1.0);
  colour.Parse(value);
  _parameters.SetParameter<TSceneColourAlpha>('colour', colour);
end;

procedure TSceneTexture.SetName(const Value: string);
begin
  _parameters.SetParameter<TStringValue>('name', TStringValue.Create(value));
end;

end.
