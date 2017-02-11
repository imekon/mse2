unit scene.cylinder;

interface

uses
  GLScene, GLGeomObjects,
  scene.shape;

type
  TSceneCylinder = class(TShape)
  public
    constructor Create; override;
    function BuildGLSceneObject(owner: TGLBaseSceneObject): TGLBaseSceneObject; override;
    procedure UpdateGLSceneObject; override;
  end;

implementation

{ TSceneCylinder }

function TSceneCylinder.BuildGLSceneObject(
  owner: TGLBaseSceneObject): TGLBaseSceneObject;
var
  cylinder: TGLCylinder;

begin
  cylinder := owner.AddNewChild(TGLCylinder) as TGLCylinder;
  result := cylinder;
end;

constructor TSceneCylinder.Create;
begin
  inherited;
  AddStandardParameters;
end;

procedure TSceneCylinder.UpdateGLSceneObject;
begin
  UpdateStandardParameters;
end;

end.
