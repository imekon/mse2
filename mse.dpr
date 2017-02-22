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
  scene.light.spot in 'scene.light.spot.pas',
  helper.build.project.tree in 'helper.build.project.tree.pas',
  helper.build.cleanup.project in 'helper.build.cleanup.project.pas',
  helper.build.scene in 'helper.build.scene.pas',
  scene.cylinder in 'scene.cylinder.pas',
  scene.cone in 'scene.cone.pas',
  helper.json in 'helper.json.pas',
  form.about in 'form.about.pas' {AboutBox},
  scene.texture.manager in 'scene.texture.manager.pas',
  helper.build.textures in 'helper.build.textures.pas',
  scene.template in 'scene.template.pas',
  helper.configuration in 'helper.configuration.pas',
  scene.template.manager in 'scene.template.manager.pas',
  helper.strings in 'helper.strings.pas',
  helper.logger in 'helper.logger.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
