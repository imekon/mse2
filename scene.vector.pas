unit scene.vector;

interface

type
  TSceneVector = class
  private
    _x, _y, _z: single;
  public
    constructor Create; overload;
    constructor Create(x, y, z: single); overload;
    property X: single read _x write _x;
    property Y: single read _y write _y;
    property Z: single read _z write _z;
  end;

implementation

{ TSceneVector }

constructor TSceneVector.Create;
begin
  _x := 0.0;
  _y := 0.0;
  _z := 0.0;
end;

constructor TSceneVector.Create(x, y, z: single);
begin
  _x := x;
  _y := y;
  _z := z;
end;

end.
