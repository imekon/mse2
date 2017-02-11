unit scene.camera;

interface

uses
  System.Classes, System.SysUtils, GLScene, scene.vector, scene.shape, scene.parameter;

type
  TSceneCamera = class(TShape)
  public
    constructor Create; override;
    function BuildGLSceneObject(owner: TGLBaseSceneObject): TGLBaseSceneObject; override;
    procedure UpdateGLSceneObject; override;
  end;

implementation

{ TSceneCamera }

function TSceneCamera.BuildGLSceneObject(owner: TGLBaseSceneObject): TGLBaseSceneObject;
begin
  raise Exception.Create('Not Implemented Yet');
end;

constructor TSceneCamera.Create;
begin
  inherited;
  _parameterManager.AddParameter<TSceneVector>('position', TSceneVector.Create(0.0, 0.0, 5.0), TSceneParameterGroup.Camera);
  _parameterManager.AddParameter<TSceneVector>('lookat', TSceneVector.Create(0.0, 0.0, 0.0), TSceneParameterGroup.Camera);
end;

procedure TSceneCamera.UpdateGLSceneObject;
begin
  raise Exception.Create('Not Implemented Yet');
end;

end.
