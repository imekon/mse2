program mse;

uses
  Vcl.Forms,
  main in 'main.pas' {MainForm},
  scene in 'scene.pas',
  scene.shape in 'scene.shape.pas',
  scene.parameter in 'scene.parameter.pas',
  scene.parameter.manager in 'scene.parameter.manager.pas',
  scene.camera in 'scene.camera.pas',
  scene.vector in 'scene.vector.pas',
  scene.sphere in 'scene.sphere.pas',
  scene.cube in 'scene.cube.pas',
  scene.plane in 'scene.plane.pas',
  scene.texture in 'scene.texture.pas',
  scene.colour in 'scene.colour.pas',
  helper.build.value.editor in 'helper.build.value.editor.pas',
  scene.light.spot in 'scene.light.spot.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
