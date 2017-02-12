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

unit helper.build.value.editor;

interface

uses
  Vcl.ValEdit,
  scene.parameter, scene.parameter.manager;

type
  TBuildValueEditorHelper = class
  private
    _editor: TValueListEditor;
  public
    constructor Create(editor: TValueListEditor);
    procedure Build(parameters: TSceneParameterManager);
  end;

implementation

{ TBuildValueEditorHelper }

procedure TBuildValueEditorHelper.Build(parameters: TSceneParameterManager);
var
  i: integer;
  parameter: TSceneParameter;

begin
  _editor.Strings.Clear;
  for i := 0 to parameters.ParameterCount - 1 do
  begin
    parameter := parameters.Parameter[i];
    _editor.InsertRow(parameter.Name, parameter.ToString, true);
  end;
end;

constructor TBuildValueEditorHelper.Create(editor: TValueListEditor);
begin
  _editor := editor;
end;

end.
