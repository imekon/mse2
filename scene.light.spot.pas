unit scene.light.spot;

interface

uses
  GLScene, GLObjects,
  scene.vector, scene.shape, scene.colour, scene.parameter;

type
  TSceneSpotLight = class(TShape)
  public
    constructor Create; override;
    function BuildGLSceneObject(owner: TGLBaseSceneObject): TGLBaseSceneObject; override;
  end;

implementation

{ TSceneSpotLight }

function TSceneSpotLight.BuildGLSceneObject(owner: TGLBaseSceneObject): TGLBaseSceneObject;
begin
  result := nil;
end;

constructor TSceneSpotLight.Create;
begin
  inherited;
  _parameterManager.AddParameter<TSceneVector>('position', TSceneVector.Create(2.0, 2.0, 2.0), TSceneParameterGroup.Transform);
  _parameterManager.AddParameter<TSceneColour>('colour', TSceneColour.Create(1.0, 1.0, 1.0), TSceneParameterGroup.Colour);
end;

end.
