unit scene.light.spot;

interface

uses
  scene.shape;

type
  TSceneSpotLight = class(TShape)
  public
    constructor Create; override;
  end;

implementation

{ TSceneSpotLight }

constructor TSceneSpotLight.Create;
begin
  inherited;

end;

end.
