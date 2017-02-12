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

unit scene.parameter;

interface

uses
  System.SysUtils, System.JSON, helper.json;

type
  TSceneParameterGroup = (Basic, Camera, Transform, Details, Colour, Texture);

  TSceneValue = class
  public
    constructor Create;
    function ToString: string; override;
    procedure Parse(const text: string); virtual; abstract;
    procedure Save(const name: string; obj: TJSONObject); virtual; abstract;
    procedure Load(const name: string; obj: TJSONObject); virtual; abstract;
  end;

  TIntegerValue = class(TSceneValue)
  private
    _value: integer;
  public
    constructor Create(const value: integer);
    function ToString: string; override;
    procedure Save(const name: string; obj: TJSONObject); override;
    procedure Load(const name: string; obj: TJSONObject); override;
    property Value: integer read _value write _value;
  end;

  TSingleValue = class(TSceneValue)
  private
    _value: single;
  public
    constructor Create(const value: single);
    function ToString: string; override;
    procedure Save(const name: string; obj: TJSONObject); override;
    procedure Load(const name: string; obj: TJSONObject); override;
    property Value: single read _value write _value;
  end;

  TStringValue = class(TSceneValue)
  private
    _value: string;
  public
    constructor Create(const value: string);
    function ToString: string; override;
    procedure Save(const name: string; obj: TJSONObject); override;
    procedure Load(const name: string; obj: TJSONObject); override;
    property Value: string read _value write _value;
  end;

  TSceneParameter = class
  protected
    _name: string;
    _group: TSceneParameterGroup;
  public
    constructor Create(const name: string; group: TSceneParameterGroup); virtual;
    procedure Save(obj: TJSONObject); virtual; abstract;
    procedure Load(obj: TJSONObject); virtual; abstract;
    property Name: string read _name;
  end;

  TSceneParameter<TType: TSceneValue> = class(TSceneParameter)
  protected
    _value: TType;
    procedure SetValue(const Value: TType);
  public
    constructor Create(const name: string; group: TSceneParameterGroup); override;
    function ToString: string; override;
    procedure Save(obj: TJSONObject); override;
    procedure Load(obj: TJSONObject); override;
    property Value: TType read _value write SetValue;
  end;

implementation

{ TSceneParameter<TType> }

constructor TSceneParameter<TType>.Create(const name: string; group: TSceneParameterGroup);
begin
  inherited Create(name, group);
end;

procedure TSceneParameter<TType>.Load(obj: TJSONObject);
begin
  _value.Load(_name, obj);
end;

procedure TSceneParameter<TType>.Save(obj: TJSONObject);
begin
  _value.Save(_name, obj);
end;

procedure TSceneParameter<TType>.SetValue(const Value: TType);
begin
  _value := value;
end;

function TSceneParameter<TType>.ToString: string;
begin
  if assigned(_value) then
    result := _value.ToString
  else
    result := 'parameter value is nil';
end;

{ TSceneParameter }

constructor TSceneParameter.Create(const name: string; group: TSceneParameterGroup);
begin
  _name := name;
  _group := group;
end;

{ TSceneValue }

constructor TSceneValue.Create;
begin

end;

function TSceneValue.ToString: string;
begin
  result := '';
end;

{ TStringValue }

constructor TStringValue.Create(const value: string);
begin
  _value := value;
end;

procedure TStringValue.Load(const name: string; obj: TJSONObject);
begin
  _value := obj.GetValue(name).Value;
end;

procedure TStringValue.Save(const name: string; obj: TJSONObject);
begin
  obj.AddPair(name, _value);
end;

function TStringValue.ToString: string;
begin
  result := _value;
end;

{ TSingleValue }

constructor TSingleValue.Create(const value: single);
begin
  _value := value;
end;

procedure TSingleValue.Load(const name: string; obj: TJSONObject);
begin
  _value := obj.GetValue(name).GetValue<single>;
end;

procedure TSingleValue.Save(const name: string; obj: TJSONObject);
begin
  obj.AddPair(name, _value);
end;

function TSingleValue.ToString: string;
begin
  result := FloatToStr(_value);
end;

{ TIntegerValue }

constructor TIntegerValue.Create(const value: integer);
begin
  _value := value;
end;

procedure TIntegerValue.Load(const name: string; obj: TJSONObject);
begin
  _value := obj.GetValue(name).GetValue<integer>;
end;

procedure TIntegerValue.Save(const name: string; obj: TJSONObject);
begin
  obj.AddPair(name, _value);
end;

function TIntegerValue.ToString: string;
begin
  result := IntToStr(_value);
end;

end.
