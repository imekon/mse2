unit scene.colour;

interface

uses
  System.SysUtils,
  scene.parameter;

type
  TSceneColour = class(TSceneValue)
  protected
    _red, _green, _blue: single;
  public
    constructor Create(r, g, b: single);
    function ToString: string; override;
    property Red: single read _red write _red;
    property Green: single read _green write _green;
    property Blue: single read _blue write _blue;
  end;

  TSceneColourAlpha = class(TSceneColour)
  protected
    _alpha: single;
  public
    constructor Create(r, g, b, a: single);
    function ToString: string; override;
    property Red;
    property Green;
    property Blue;
    property Alpha: single read _alpha write _alpha;
  end;

implementation

{ TSceneColourAlpha }

constructor TSceneColourAlpha.Create(r, g, b, a: single);
begin
  inherited Create(r, g, b);
  _alpha := a;
end;

function TSceneColourAlpha.ToString: string;
begin
  result := Format('%1.2f, %1.2f, %1.2f, %1.2f',
    [_red, _green, _blue, _alpha]);
end;

{ TSceneColour }

constructor TSceneColour.Create(r, g, b: single);
begin
  _red := r;
  _green := g;
  _blue := b;
end;

function TSceneColour.ToString: string;
begin
  result := Format('%1.2f, %1.2f, %1.2f',
    [_red, _green, _blue]);
end;

end.
