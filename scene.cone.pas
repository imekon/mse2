unit scene.cone;

interface

uses
  GLScene, GLGeomObjects,
  scene.shape;

type
  TSceneCone = class(TShape)
  public
    constructor Create; override;
    function BuildGLSceneObject(owner: TGLBaseSceneObject): TGLBaseSceneObject; override;
    procedure UpdateGLSceneObject; override;
  end;

implementation

{ TSceneCone }

function TSceneCone.BuildGLSceneObject(
  owner: TGLBaseSceneObject): TGLBaseSceneObject;
var
  cone: TGLCone;

begin
  cone := owner.AddNewChild(TGLCone) as TGLCone;
  result := cone;
end;

constructor TSceneCone.Create;
begin
  inherited;
  AddStandardParameters;
end;

procedure TSceneCone.UpdateGLSceneObject;
begin
  UpdateStandardParameters;
end;

end.
