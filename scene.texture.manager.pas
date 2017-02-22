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
  helper.logger,
  scene.texture;

type
  TSceneTextureManager = class
  private
    _logger: TLogger;
    _textures: TObjectList<TSceneTexture>;
    _registration: TDictionary<string, TSceneTextureType>;
    function GetTexture(index: integer): TSceneTexture;
    function GetTextureCount: integer;
    procedure RegisterTexture(const name: string; textureType: TSceneTextureType);
  public
    constructor Create(logger: TLogger);
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
  System.Classes;

{ TSceneTextureManager }

constructor TSceneTextureManager.Create(logger: TLogger);
begin
  _logger := logger;
  _textures := TObjectList<TSceneTexture>.Create;
  _registration := TDictionary<string, TSceneTextureType>.Create;

  RegisterTexture('colour', TSceneTexture);
end;

function TSceneTextureManager.CreateTexture(const name: string): TSceneTexture;
var
  textureType: TSceneTextureType;

begin
  textureType := _registration[name];
  result := textureType.Create;
end;

destructor TSceneTextureManager.Destroy;
begin
  _textures.Free;
  _registration.Free;
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
  tokens: TArray<string>;

begin
  try
    AssignFile(input, filename);
    try
      Reset(input);
      while not eof(input) do
      begin
        ReadLn(input, line);
        tokens := line.Split([' ']);
        texture := CreateTexture('colour');
        texture.Name := tokens[0];
        texture.Colour := tokens[1] + ', ' + tokens[2] + ', ' + tokens[3];
        _textures.Add(texture);
      end;
    except
      _logger.Log(TLoggerSeverity.Error, 'Failed to import colours from %s', [filename]);
    end;
  finally
    CloseFile(input);
  end;
end;

procedure TSceneTextureManager.Load(const filename: string);
var
  data, t: string;
  root, obj: TJSONObject;
  texturesArray: TJSONArray;
  i, n: integer;
  texture: TSceneTexture;

begin
  try
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
      _textures.Add(texture);
    end;
    root.Free;
  except
    _logger.Log(TLoggerSeverity.Error, 'Failed to load textures from %s', [filename]);
  end;
end;

procedure TSceneTextureManager.RegisterTexture(const name: string;
  textureType: TSceneTextureType);
begin
  _registration.Add(name, textureType);
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
  root.Free;
end;

end.
