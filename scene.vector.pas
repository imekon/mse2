unit scene.vector;

interface

uses
  System.SysUtils,
  scene.parameter;

type
  TSceneVector = class(TSceneValue)
  private
    _x, _y, _z: single;
  public
    constructor Create(x, y, z: single);
    function ToString: string; override;
    property X: single read _x write _x;
    property Y: single read _y write _y;
    property Z: single read _z write _z;
  end;

implementation

{ TSceneVector }

constructor TSceneVector.Create(x, y, z: single);
begin
  _x := x;
  _y := y;
  _z := z;
end;

function TSceneVector.ToString: string;
begin
  result := Format('%1.2f, %1.2f, %1.2f',
    [_x, _y, _z]);
end;

end.
