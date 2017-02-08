unit scene.parameter;

interface

type
  TSceneParameterGroup = (Basic, Camera, Transform, Colour, Texture);

  TSceneValue = class
  public
    constructor Create;
    function ToString: string; override;
    procedure Parse(const text: string);
  end;

  TStringValue = class(TSceneValue)
  private
    _value: string;
  public
    constructor Create(const value: string);
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
  result := '';

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

end.
