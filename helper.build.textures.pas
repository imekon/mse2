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
