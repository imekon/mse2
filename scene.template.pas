unit scene.template;

interface

uses
  System.Types, System.Generics.Collections, System.IOUTils, System.StrUtils,
  System.SysUtils;

type
  TSceneTemplateSection = class
  private
    _section: string;
    _start: integer;
    _finish: integer;
    _data: TStringBuilder;
    function GetData: string;
  public
    constructor Create(const section: string);
    destructor Destroy; override;
    procedure AddLine(line: string);

    property Section: string read _section;
    property Data: string read GetData;
    property Start: integer read _start write _start;
    property Finish: integer read _finish write _finish;
  end;

  TSceneTemplate = class
  private
    _name: string;
    _description: string;
    _sections: TObjectList<TSceneTemplateSection>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Load(const filename: string);
  end;

implementation

{ TSceneTemplateSection }

procedure TSceneTemplateSection.AddLine(line: string);
begin
  _data.AppendLine(line);
end;

constructor TSceneTemplateSection.Create(const section: string);
begin
  _data := TStringBuilder.Create;
  _section := MidStr(section, 3, Length(section) - 3);
end;

destructor TSceneTemplateSection.Destroy;
begin
  _data.Free;
  inherited;
end;

function TSceneTemplateSection.GetData: string;
begin
  result := _data.ToString;
end;

{ TSceneTemplate }

constructor TSceneTemplate.Create;
begin
  _sections := TObjectList<TSceneTemplateSection>.Create;
end;

destructor TSceneTemplate.Destroy;
begin
  _sections.Free;
  inherited;
end;

procedure TSceneTemplate.Load(const filename: string);
var
  lines: TStringDynArray;
  line: string;
  i, counter: integer;
  section: TSceneTemplateSection;

begin
  section := nil;

  lines := TFile.ReadAllLines(filename);

  counter := 0;
  for line in lines do
  begin
    if StartsText('$[', line) then
    begin
      if assigned(section) then
        section.Finish := counter - 1;

      section := TSceneTemplateSection.Create(line);
      section.Start := counter + 1;
      _sections.Add(section);
    end;

    inc(counter);
  end;
  section.Finish := counter;

  for section in _sections do
    for i := section.Start to section.Finish do
      section.AddLine(lines[i]);

  for section in _sections do
    if section.Section = 'name' then
      _name := Trim(section.Data)
    else if section.Section = 'description' then
      _description := Trim(section.Data);
end;

end.
