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
  cube: TGLBaseSceneObject;

begin
  cube := owner.AddNewChild(TGLCube);
  result := cube;
end;

constructor TSceneCube.Create;
begin
  inherited;
  AddStandardParameters;
end;

procedure TSceneCube.UpdateGLSceneObject;
begin

end;

end.
