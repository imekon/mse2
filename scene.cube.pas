unit scene.cube;

interface

uses
  System.Classes, GLScene, GLObjects, scene.shape;

type
  TSceneCube = class(TShape)
  public
    constructor Create; override;
    function BuildGLSceneObject(owner: TGLBaseSceneObject): TGLBaseSceneObject; override;
    procedure UpdateGLSceneObject; override;
  end;

implementation

{ TSceneCube }

function TSceneCube.BuildGLSceneObject(owner: TGLBaseSceneObject): TGLBaseSceneObject;
var
  cube: TGLCube;

begin
  cube := owner.AddNewChild(TGLCube) as TGLCube;
  result := cube;
end;

constructor TSceneCube.Create;
begin
  inherited;
  AddStandardParameters;
end;

procedure TSceneCube.UpdateGLSceneObject;
begin
  UpdateStandardParameters;
end;

end.
