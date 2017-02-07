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
  _parameterManager.AddParameter<TSceneVector>('position', TSceneVector.Create, TSceneParameterGroup.Camera);
  _parameterManager.AddParameter<TSceneVector>('lookat', TSceneVector.Create, TSceneParameterGroup.Camera);
end;

end.
