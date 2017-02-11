unit helper.build.project.tree;

interface

uses
  Vcl.ComCtrls,
  scene, scene.shape;

type
  THelperBuildProjectTree = class
  private
    _projectTree: TTreeView;
    _root: TTreeNode;
  public
    constructor Create(projectTree: TTreeView);
    procedure Build(scene: TScene);
  end;

implementation

{ THelperBuildProjectTree }

procedure THelperBuildProjectTree.Build(scene: TScene);
var
  i: integer;
  shape: TShape;
  node: TTreeNode;

begin
  for i := 0 to scene.ShapeCount - 1 do
  begin
    shape := scene.Shapes[i];
    if shape.IsAdded then
    begin
      node := _projectTree.Items.AddChildObject(_root, shape.Name, shape);
      shape.TreeNode := node;
    end
    else if shape.IsEdited then
      shape.TreeNode.Text := shape.Name;
  end;
end;

constructor THelperBuildProjectTree.Create(projectTree: TTreeView);
begin
  _projectTree := projectTree;

  _root := _projectTree.Items.Add(nil, 'Project');
end;

end.
