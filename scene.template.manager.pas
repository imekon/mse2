unit scene.template.manager;

interface

uses
  System.Types, System.Generics.Collections, System.IOUtils,
  scene.template;

type
  TSceneTemplateManager = class
  private
    _templates: TObjectList<TSceneTemplate>;
  public
    constructor Create(const path: string);
    destructor Destroy; override;
  end;

implementation

{ TSceneTemplateManager }

constructor TSceneTemplateManager.Create(const path: string);
var
  files: TStringDynArray;
  templatePath, filename: string;
  template: TSceneTemplate;

begin
  _templates := TObjectList<TSceneTemplate>.Create;
  templatePath := TPath.Combine(path, 'templates');
  files := TDirectory.GetFiles(templatePath, '*.export');
  for filename in files do
  begin
    template := TSceneTemplate.Create;
    template.Load(filename);
    _templates.Add(template);
  end;
end;

destructor TSceneTemplateManager.Destroy;
begin
  _templates.Free;
  inherited;
end;

end.
