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

unit scene.colour;

interface

uses
  System.SysUtils,
  scene.parameter;

type
  TSceneColour = class(TSceneValue)
  protected
    _red, _green, _blue: single;
  public
    constructor Create(r, g, b: single);
    function ToString: string; override;
    property Red: single read _red write _red;
    property Green: single read _green write _green;
    property Blue: single read _blue write _blue;
  end;

  TSceneColourAlpha = class(TSceneColour)
  protected
    _alpha: single;
  public
    constructor Create(r, g, b, a: single);
    function ToString: string; override;
    property Red;
    property Green;
    property Blue;
    property Alpha: single read _alpha write _alpha;
  end;

implementation

{ TSceneColourAlpha }

constructor TSceneColourAlpha.Create(r, g, b, a: single);
begin
  inherited Create(r, g, b);
  _alpha := a;
end;

function TSceneColourAlpha.ToString: string;
begin
  result := Format('%1.2f, %1.2f, %1.2f, %1.2f',
    [_red, _green, _blue, _alpha]);
end;

{ TSceneColour }

constructor TSceneColour.Create(r, g, b: single);
begin
  _red := r;
  _green := g;
  _blue := b;
end;

function TSceneColour.ToString: string;
begin
  result := Format('%1.2f, %1.2f, %1.2f',
    [_red, _green, _blue]);
end;

end.
