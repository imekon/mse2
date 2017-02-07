unit scene;

interface

uses
  System.Generics.Collections,
  scene.shape;

type
  TScene = class
  private
    _shapes: TObjectList<TShape>;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TScene }

constructor TScene.Create;
begin
  _shapes := TObjectList<TShape>.Create;
end;

destructor TScene.Destroy;
begin
  _shapes.Free;
  inherited;
end;

end.
