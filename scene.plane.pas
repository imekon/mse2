unit scene.plane;

interface

uses
  scene.shape;

type
  TScenePlane = class(TShape)
  public
    constructor Create; override;
  end;

implementation

{ TScenePlane }

constructor TScenePlane.Create;
begin
  inherited;
  AddStandardParameters;
end;

end.
