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
