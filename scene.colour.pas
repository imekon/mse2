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
  System.SysUtils, System.JSON,
  helper.JSON,
  scene.parameter, helper.strings;

type
  TSceneColour = class(TSceneValue)
  protected
    _red, _green, _blue: single;
    function GetHasSubParameter: boolean; override;
  public
    constructor Create(r, g, b: single);
    function ToString: string; override;
    procedure Parse(const text: string); override;
    procedure Load(const name: string; obj: TJSONObject); override;
    procedure Save(const name: string; obj: TJSONObject); override;
    function GetField(const field: string; negate: boolean): string; override;
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
    procedure Parse(const text: string); override;
    procedure Load(const name: string; obj: TJSONObject); override;
    procedure Save(const name: string; obj: TJSONObject); override;
    function GetField(const field: string; negate: boolean): string; override;
    property Red;
    property Green;
    property Blue;
    property Alpha: single read _alpha write _alpha;
  end;

implementation

uses
  System.Classes;

{ TSceneColourAlpha }

constructor TSceneColourAlpha.Create(r, g, b, a: single);
begin
  inherited Create(r, g, b);
  _alpha := a;
end;

function TSceneColourAlpha.GetField(const field: string; negate: boolean): string;
var
  value: single;

begin
  value := 0.0;

  if field.ToUpper = 'RED' then
    value := _red
  else if field.ToUpper = 'GREEN' then
    value := _green
  else if field.ToUpper = 'BLUE' then
    value := _blue
  else if field.ToUpper = 'ALPHA' then
    value := _alpha;

  if negate then
    value := -value;

  result := FloatToStr(value);
end;

procedure TSceneColourAlpha.Load(const name: string; obj: TJSONObject);
var
  text: string;

begin
  text := obj.GetValue(name).Value;
  Parse(text);
end;

procedure TSceneColourAlpha.Parse(const text: string);
var
  tokens: TArray<string>;

begin
  tokens := text.Split([',']);
  _red := StrToFloat(tokens[0]);
  _green := StrToFloat(tokens[1]);
  _blue := StrToFloat(tokens[2]);

  if Length(tokens) = 4 then
    _alpha := StrToFloat(tokens[3])
  else
    _alpha := 1.0;
end;

procedure TSceneColourAlpha.Save(const name: string; obj: TJSONObject);
begin
  obj.AddPair(name, ToString);
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

function TSceneColour.GetHasSubParameter: boolean;
begin
  result := true;
end;

function TSceneColour.GetField(const field: string; negate: boolean): string;
var
  value: single;

begin
  value := 0.0;

  if field.ToUpper = 'RED' then
    value := _red
  else if field.ToUpper = 'GREEN' then
    value := _green
  else if field.ToUpper = 'BLUE' then
    value := _blue;

  if negate then
    value := -value;

  result := FloatToStr(value);
end;

procedure TSceneColour.Load(const name: string; obj: TJSONObject);
var
  text: string;

begin
  text := obj.GetValue(name).Value;
  Parse(text);
end;

procedure TSceneColour.Parse(const text: string);
var
  tokens: TArray<string>;

begin
  tokens := text.Split([',']);
  _red := StrToFloat(tokens[0]);
  _green := StrToFloat(tokens[1]);
  _blue := StrToFloat(tokens[2]);
end;

procedure TSceneColour.Save(const name: string; obj: TJSONObject);
begin
  obj.AddPair(name, ToString);
end;

function TSceneColour.ToString: string;
begin
  result := Format('%1.2f, %1.2f, %1.2f',
    [_red, _green, _blue]);
end;

end.
