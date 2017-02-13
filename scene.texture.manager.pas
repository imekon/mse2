unit scene.texture.manager;

interface

uses
  System.Generics.Collections,
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

end.
