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
    procedure AddShape(shape: TShape);
    procedure RemoveShape(shape: TShape);
  end;

implementation

{ TScene }

procedure TScene.AddShape(shape: TShape);
begin
  _shapes.Add(shape);
end;

constructor TScene.Create;
begin
  _shapes := TObjectList<TShape>.Create;
end;

destructor TScene.Destroy;
begin
  _shapes.Free;
  inherited;
end;

procedure TScene.RemoveShape(shape: TShape);
begin
  _shapes.Remove(shape);
end;

end.
