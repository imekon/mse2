unit scene.colour;

interface

uses
  System.SysUtils,
  scene.parameter;

type
  TSceneColour = class(TSceneValue)
  private
    _red, _green, _blue, _alpha: single;
  public
    constructor Create;
    function ToString: string; override;
    property Red: single read _red write _red;
    property Green: single read _green write _green;
    property Blue: single read _blue write _blue;
    property Alpha: single read _alpha write _alpha;
  end;

implementation

{ TSceneColour }

constructor TSceneColour.Create;
begin
  _red := 0.0;
  _green := 0.0;
  _blue := 0.0;
  _alpha := 1.0;
end;

function TSceneColour.ToString: string;
begin
  result := Format('%1.2f, %1.2f, %1.2f, %1.2f',
    [_red, _green, _blue, _alpha]);
end;

end.
