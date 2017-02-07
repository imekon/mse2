unit scene.colour;

interface

type
  TSceneColour = class
  private
    _red, _green, _blue, _alpha: single;
  public
    constructor Create;
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

end.
