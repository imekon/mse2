unit scene.cube;

interface

uses
  scene.shape;

type
  TSceneCube = class(TShape)
  public
    constructor Create; override;
  end;

implementation

{ TSceneCube }

constructor TSceneCube.Create;
begin
  inherited;
  AddStandardParameters;
end;

end.
