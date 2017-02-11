unit scene.parameter;

interface

uses
  System.SysUtils;

type
  TSceneParameterGroup = (Basic, Camera, Transform, Colour, Texture);

  TSceneValue = class
  public
    constructor Create;
    function ToString: string; override;
    procedure Parse(const text: string);
  end;

  TIntegerValue = class(TSceneValue)
  private
    _value: integer;
  public
    constructor Create(const value: integer);
    function ToString: string; override;
    property Value: integer read _value write _value;
  end;

  TSingleValue = class(TSceneValue)
  private
    _value: single;
  public
    constructor Create(const value: single);
    function ToString: string; override;
    property Value: single read _value write _value;
  end;

  TStringValue = class(TSceneValue)
  private
    _value: string;
  public
    constructor Create(const value: string);
    function ToString: string; override;
    property Value: string read _value write _value;
  end;

  TSceneParameter = class
  protected
    _name: string;
    _group: TSceneParameterGroup;
  public
    constructor Create(const name: string; group: TSceneParameterGroup); virtual;
    property Name: string read _name;
  end;

  TSceneParameter<TType: TSceneValue> = class(TSceneParameter)
  protected
    _value: TType;
    procedure SetValue(const Value: TType);
  public
    constructor Create(const name: string; group: TSceneParameterGroup); override;
    function ToString: string; override;
    property Value: TType read _value write SetValue;
  end;

implementation

{ TSceneParameter<TType> }

constructor TSceneParameter<TType>.Create(const name: string; group: TSceneParameterGroup);
begin
  inherited Create(name, group);
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

procedure TSceneValue.Parse(const text: string);
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

function TStringValue.ToString: string;
begin
  result := _value;
end;

{ TSingleValue }

constructor TSingleValue.Create(const value: single);
begin
  _value := value;
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

function TIntegerValue.ToString: string;
begin
  result := IntToStr(_value);
end;

end.
