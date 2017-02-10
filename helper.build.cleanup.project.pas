unit helper.build.cleanup.project;

interface

uses
  System.Generics.Collections,
  scene, scene.shape;

type
  THelperBuildCleanupProject = class
  private
    _scene: TScene;
  public
    constructor Create(scene: TScene);
    procedure Cleanup;
  end;

implementation

{ THelperBuildCleanupProject }

procedure THelperBuildCleanupProject.Cleanup;
var
  i: integer;
  shape: TShape;
  deleted: TList<TShape>;

begin
  deleted := TList<TShape>.Create;
  for i := 0 to _scene.ShapeCount - 1 do
  begin
    shape := _scene.Shapes[i];
    if shape.IsDelete then
      deleted.Add(shape)
    else
      shape.ResetStatus;
  end;

  for shape in deleted do
    _scene.RemoveShape(shape);

  deleted.Free;
end;

constructor THelperBuildCleanupProject.Create(scene: TScene);
begin
  _scene := scene;
end;

end.
