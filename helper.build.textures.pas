unit helper.build.textures;

interface

uses
  Vcl.ComCtrls,
  scene.texture.manager, scene.texture;

type
  THelperBuildTextures = class
  private
    _view: TListView;
    _textureManager: TSceneTextureManager;
  public
    constructor Create(view: TListView; textureManager: TSceneTextureManager);
    procedure Build;
  end;

implementation

{ THelperBuildTextures }

procedure THelperBuildTextures.Build;
var
  i: integer;
  texture: TSceneTexture;
  item: TListItem;

begin
  _view.Items.Clear;

  for i := 0 to _textureManager.TextureCount - 1 do
  begin  
    texture := _textureManager.Textures[i];
    item := _view.Items.Add;
    item.Caption := texture.Name;
    item.Data := texture;
    item.SubItems.Add('Texture')
  end;
end;

constructor THelperBuildTextures.Create(view: TListView;
  textureManager: TSceneTextureManager);
begin
  _view := view;
  _textureManager := textureManager;
end;

end.
