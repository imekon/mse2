unit scene.camera;

interface

uses
  scene.vector, scene.shape, scene.parameter;

type
  TSceneCamera = class(TShape)
  public
    constructor Create; override;
  end;

implementation

{ TSceneCamera }

constructor TSceneCamera.Create;
begin
  inherited;
  _parameterManager.AddParameter<TSceneVector>('position', TSceneVector.Create(0.0, 0.0, 5.0), TSceneParameterGroup.Camera);
  _parameterManager.AddParameter<TSceneVector>('lookat', TSceneVector.Create(0.0, 0.0, 0.0), TSceneParameterGroup.Camera);
end;

end.
