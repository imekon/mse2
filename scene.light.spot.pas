unit scene.light.spot;

interface

uses
  scene.vector, scene.shape, scene.colour, scene.parameter;

type
  TSceneSpotLight = class(TShape)
  public
    constructor Create; override;
  end;

implementation

{ TSceneSpotLight }

constructor TSceneSpotLight.Create;
begin
  inherited;
  _parameterManager.AddParameter<TSceneVector>('position', TSceneVector.Create(2.0, 2.0, 2.0), TSceneParameterGroup.Transform);
  _parameterManager.AddParameter<TSceneColour>('colour', TSceneColour.Create(1.0, 1.0, 1.0), TSceneParameterGroup.Colour);
end;

end.
