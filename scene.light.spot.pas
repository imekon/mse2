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
    procedure UpdateGLSceneObject; override;
  end;

implementation

{ TSceneSpotLight }

function TSceneSpotLight.BuildGLSceneObject(owner: TGLBaseSceneObject): TGLBaseSceneObject;
var
  light: TGLLightSource;

begin
  light := owner.AddNewChild(TGLLightSource) as TGLLightSource;
  result := light;
end;

constructor TSceneSpotLight.Create;
begin
  inherited;
  _parameterManager.AddParameter<TSceneVector>('position', TSceneVector.Create(2.0, 2.0, 2.0), TSceneParameterGroup.Transform);
  _parameterManager.AddParameter<TSceneColour>('colour', TSceneColour.Create(1.0, 1.0, 1.0), TSceneParameterGroup.Colour);
end;

procedure TSceneSpotLight.UpdateGLSceneObject;
var
  light: TGLLightSource;
  vector: TSceneVector;
  colour: TSceneColour;

begin
  light := _object as TGLLightSource;

  vector := GetParameter<TSceneVector>('position');
  colour := GetParameter<TSceneColour>('colour');

  light.Position.X := vector.X;
  light.Position.Y := vector.Y;
  light.Position.Z := vector.Z;

  light.Ambient.Red := colour.Red;
  light.Ambient.Green := colour.Green;
  light.Ambient.Blue := colour.Blue;
end;

end.
