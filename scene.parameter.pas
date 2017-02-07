unit scene.parameter;

interface

type
  TSceneParameterGroup = (Basic, Camera, Transform, Colour, Texture);

  TSceneParameter = class
  protected
    _name: string;
    _group: TSceneParameterGroup;
  public
    constructor Create(const name: string; group: TSceneParameterGroup); virtual;
    property Name: string read _name;
  end;

  TSceneParameter<TType> = class(TSceneParameter)
  protected
    _value: TType;
    procedure SetValue(const Value: TType);
  public
    constructor Create(const name: string; group: TSceneParameterGroup); override;
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

{ TSceneParameter }

constructor TSceneParameter.Create(const name: string; group: TSceneParameterGroup);
begin
  _name := name;
  _group := group;
end;

end.
