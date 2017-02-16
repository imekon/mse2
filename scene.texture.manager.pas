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

unit scene.texture.manager;

interface

uses
  System.Generics.Collections, System.IOUtils, System.SysUtils, System.JSON,
  scene.texture;

type
  TSceneTextureManager = class
  private
    _textures: TObjectList<TSceneTexture>;
    function GetTexture(index: integer): TSceneTexture;
    function GetTextureCount: integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ImportColours(const filename: string);
    procedure Load(const filename: string);
    procedure Save(const filename: string);
    function CreateTexture(const name: string): TSceneTexture;

    property TextureCount: integer read GetTextureCount;
    property Textures[index: integer]: TSceneTexture read GetTexture;
  end;

implementation

uses
  System.Classes, helper.Utilities;

{ TSceneTextureManager }

constructor TSceneTextureManager.Create;
begin
  _textures := TObjectList<TSceneTexture>.Create;
end;

function TSceneTextureManager.CreateTexture(const name: string): TSceneTexture;
begin
  result := nil;
end;

destructor TSceneTextureManager.Destroy;
begin
  _textures.Free;
  inherited;
end;

function TSceneTextureManager.GetTexture(index: integer): TSceneTexture;
begin
  result := _textures[index];
end;

function TSceneTextureManager.GetTextureCount: integer;
begin
  result := _textures.Count;
end;

procedure TSceneTextureManager.ImportColours(const filename: string);
var
  input: TextFile;
  line: string;
  texture: TSceneTexture;
  tokens: TStringList;

begin
  tokens := TStringList.Create;
  AssignFile(input, filename);
  Reset(input);
  while not eof(input) do
  begin
    ReadLn(input, line);
    Split(line, ' ', tokens);
    texture := TSceneTexture.Create;
    texture.Name := tokens[0];
    texture.Colour := tokens[1] + ', ' + tokens[2] + ', ' + tokens[3];
    _textures.Add(texture);
  end;

  CloseFile(input);
  tokens.Free;
end;

procedure TSceneTextureManager.Load(const filename: string);
var
  data, t: string;
  root, obj: TJSONObject;
  texturesArray: TJSONArray;
  i, n: integer;
  texture: TSceneTexture;

begin
  data := TFile.ReadAllText(filename);
  root := TJSONObject.ParseJSONValue(data, true) as TJSONObject;
  texturesArray := root.Get('textures').JsonValue as TJSONArray;
  n := texturesArray.Count;
  for i := 0 to n - 1 do
  begin
    obj := texturesArray.Items[i] as TJSONObject;
    t := obj.GetValue('texture').Value;
    texture := CreateTexture(t);
    texture.Load(obj);
  end;
end;

procedure TSceneTextureManager.Save(const filename: string);
var
  data: string;
  root, obj: TJSONObject;
  texturesArray: TJSONArray;
  texture: TSceneTexture;

begin
  root := TJSONObject.Create;
  texturesArray := TJSONArray.Create;
  for texture in _textures do
  begin
    obj := TJSONObject.Create;
    texture.Save(obj);
    texturesArray.Add(obj);
  end;
  root.AddPair('textures', texturesArray);
  data := root.ToJSON;
  TFile.WriteAllText(filename, data);
end;

end.
