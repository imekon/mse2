unit scene.sphere;

interface

uses
  GLScene, GLObjects,
  scene.vector, scene.shape;

type
  TSceneSphere = class(TShape)
  public
    constructor Create; override;
    function BuildGLSceneObject(owner: TGLBaseSceneObject): TGLBaseSceneObject; override;
    procedure UpdateGLSceneObject; override;
  end;

implementation

{ TSceneSphere }

function TSceneSphere.BuildGLSceneObject(
  owner: TGLBaseSceneObject): TGLBaseSceneObject;
var
  sphere: TGLSphere;

begin
  sphere := owner.AddNewChild(TGLSphere) as TGLSphere;
  result := sphere;
end;

constructor TSceneSphere.Create;
begin
  inherited;
  AddStandardParameters;
end;

procedure TSceneSphere.UpdateGLSceneObject;
begin
  UpdateStandardParameters;
end;

end.
