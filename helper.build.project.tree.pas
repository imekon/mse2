//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 1, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
//

// Author: Pete Goodwin (mse@imekon.org)

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
