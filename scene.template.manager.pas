unit scene.template.manager;

interface

uses
  System.Types, System.Generics.Collections, System.IOUtils,
  helper.logger,
  scene.template;

type
  TSceneTemplateManager = class
  private
    _logger: TLogger;
    _templates: TObjectList<TSceneTemplate>;
  public
    constructor Create(logger: TLogger; const path: string);
    destructor Destroy; override;
    function FindTemplate(const name: string): TSceneTemplate;
  end;

implementation

{ TSceneTemplateManager }

constructor TSceneTemplateManager.Create(logger: TLogger; const path: string);
var
  files: TStringDynArray;
  templatePath, filename: string;
  template: TSceneTemplate;

begin
  _logger := logger;
  _templates := TObjectList<TSceneTemplate>.Create;
  try
    templatePath := TPath.Combine(path, 'templates');
    try
      files := TDirectory.GetFiles(templatePath, '*.export');
    except
      logger.Log(TLoggerSeverity.Error, 'Failed to load templates from: %s', [path]);
    end;
    for filename in files do
    begin
      template := TSceneTemplate.Create;
      template.Load(filename);
      _templates.Add(template);
    end;
  finally
    logger.Log(TLoggerSeverity.Information, 'Loaded templates from: %s', [path]);
  end;
end;

destructor TSceneTemplateManager.Destroy;
begin
  _templates.Free;
  inherited;
end;

function TSceneTemplateManager.FindTemplate(const name: string): TSceneTemplate;
var
  template: TSceneTemplate;

begin
  result := nil;
  for template in _templates do
  begin
    if template.Name = name then
    begin
      result := template;
      break;
    end;
  end;
end;

end.
