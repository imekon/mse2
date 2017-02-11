unit scene.texture;

interface

uses
  scene.parameter, scene.parameter.manager, scene.colour;

type
  TSceneTexture = class
  protected
    _parameters: TSceneParameterManager;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  end;

implementation

{ TSceneTexture }

constructor TSceneTexture.Create;
begin
  _parameters := TSceneParameterManager.Create;

  _parameters.AddParameter<TStringValue>('name', TStringValue.Create('untitled'), TSceneParameterGroup.Basic);
  _parameters.AddParameter<TSceneColourAlpha>('colour', TSceneColourAlpha.Create(1.0, 0.0, 0.0, 1.0), TSceneParameterGroup.Colour);
end;

destructor TSceneTexture.Destroy;
begin
  _parameters.Free;
  inherited;
end;

end.
