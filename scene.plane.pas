unit scene.plane;

interface

uses
  GLScene, GLObjects, scene.shape;

type
  TScenePlane = class(TShape)
  public
    constructor Create; override;
    function BuildGLSceneObject(owner: TGLBaseSceneObject): TGLBaseSceneObject; override;
    procedure UpdateGLSceneObject; override;
  end;

implementation

{ TScenePlane }

function TScenePlane.BuildGLSceneObject(
  owner: TGLBaseSceneObject): TGLBaseSceneObject;
var
  plane: TGLPlane;

begin
  plane := owner.AddNewChild(TGLPlane) as TGLPlane;
  result := plane;
end;

constructor TScenePlane.Create;
begin
  inherited;
  AddStandardParameters;
end;

procedure TScenePlane.UpdateGLSceneObject;
begin
  UpdateStandardParameters;
end;

end.
