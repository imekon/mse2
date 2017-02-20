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

unit scene.vector;

interface

uses
  System.SysUtils, System.JSON,
  helper.json,
  scene.parameter, helper.strings;

type
  TVectorValue = class(TSceneValue)
  private
    _x, _y, _z: single;
  protected
    function GetHasSubParameter: boolean; override;
  public
    constructor Create(x, y, z: single);
    function ToString: string; override;
    procedure Save(const name: string; obj: TJSONObject); override;
    procedure Load(const name: string; obj: TJSONObject); override;
    procedure Parse(const text: string); override;
    function GetField(const field: string; negate: boolean): string; override;

    property X: single read _x write _x;
    property Y: single read _y write _y;
    property Z: single read _z write _z;
  end;

implementation

uses
  System.Classes, helper.utilities;

{ TSceneVector }

constructor TVectorValue.Create(x, y, z: single);
begin
  _x := x;
  _y := y;
  _z := z;
end;

function TVectorValue.GetHasSubParameter: boolean;
begin
  result := true;
end;

function TVectorValue.GetField(const field: string; negate: boolean): string;
var
  value: single;

begin
  value := 0.0;

  if field.ToUpper = 'X' then
    value := _x
  else if field.ToUpper = 'Y' then
    value := _y
  else if field.ToUpper = 'Z' then
    value := _z;

  if negate then
    value := -value;

  result := FloatToStr(value);
end;

procedure TVectorValue.Load(const name: string; obj: TJSONObject);
var
  value: string;

begin
  value := obj.GetValue(name).Value;
  Parse(value);
end;

procedure TVectorValue.Parse(const text: string);
var
  tokens: TStringList;

begin
  tokens := TStringList.Create;
  Split(text, ',', tokens);
  _x := StrToFloat(tokens[0]);
  _y := StrToFloat(tokens[1]);
  _z := StrToFloat(tokens[2]);
  tokens.Free;
end;

procedure TVectorValue.Save(const name: string; obj: TJSONObject);
var
  value: string;

begin
  value := ToString;
  obj.AddPair(name, value);
end;

function TVectorValue.ToString: string;
begin
  result := Format('%1.6f, %1.6f, %1.6f',
    [_x, _y, _z]);
end;

end.
