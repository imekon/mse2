unit helper.build.value.editor;

interface

uses
  Vcl.ValEdit;

type
  TBuildValueEditorHelper = class
  private
    _editor: TValueListEditor;
  public
    constructor Create(editor: TValueListEditor);
    procedure Build;
  end;

implementation

{ TBuildValueEditorHelper }

procedure TBuildValueEditorHelper.Build;
begin
  _editor.Strings.Clear;
end;

constructor TBuildValueEditorHelper.Create(editor: TValueListEditor);
begin
  _editor := editor;
end;

end.
