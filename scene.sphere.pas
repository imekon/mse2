unit scene.sphere;

interface

uses
  scene.vector, scene.shape;

type
  TSceneSphere = class(TShape)
  public
    constructor Create; override;
  end;

implementation

{ TSceneSphere }

constructor TSceneSphere.Create;
begin
  inherited;
  AddStandardParameters;
end;

end.
