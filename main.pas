//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 1, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
//

// Author: Pete Goodwin (mse@imekon.org)

unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.IOUtils,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, System.ImageList,
  Vcl.ImgList, Vcl.ToolWin, System.Actions, Vcl.ActnList, Vcl.Menus, Vcl.Grids,
  Vcl.ValEdit, Vcl.ExtCtrls,
  GLCrossPlatform, GLBaseClasses, GLScene, GLWin32Viewer, GLCoordinates,
  helper.build.project.tree, helper.build.cleanup.project, helper.configuration,
  helper.build.value.editor, helper.build.scene, helper.build.textures, helper.logger,
  scene, scene.texture.manager, scene.template.manager;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    Exit1: TMenuItem;
    Edit1: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Object1: TMenuItem;
    Create1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    ActionList: TActionList;
    FileNewAction: TAction;
    FileOpenAction: TAction;
    FileSaveAction: TAction;
    FileSaveAsAction: TAction;
    FileExitAction: TAction;
    EditCutAction: TAction;
    EditCopyAction: TAction;
    EditPasteAction: TAction;
    HelpAboutAction: TAction;
    ToolBar: TToolBar;
    ImageList: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    PropertyPanel: TPanel;
    Splitter: TSplitter;
    ProjectTree: TTreeView;
    StatusBar1: TStatusBar;
    ValueListEditor: TValueListEditor;
    SceneViewer: TGLSceneViewer;
    Scene: TGLScene;
    Camera1: TMenuItem;
    Light1: TMenuItem;
    Sphere1: TMenuItem;
    Plane1: TMenuItem;
    Cube1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Spot1: TMenuItem;
    CameraAction: TAction;
    SpotLightAction: TAction;
    PlaneAction: TAction;
    SphereAction: TAction;
    CubeAction: TAction;
    view1: TMenuItem;
    Camera2: TMenuItem;
    N3: TMenuItem;
    Front1: TMenuItem;
    Back1: TMenuItem;
    Left1: TMenuItem;
    Right1: TMenuItem;
    op1: TMenuItem;
    Bottom1: TMenuItem;
    ViewCameraAction: TAction;
    ViewFrontAction: TAction;
    ViewBackAction: TAction;
    ViewLeftAction: TAction;
    ViewRightAction: TAction;
    ViewTopAction: TAction;
    ViewBottomAction: TAction;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    Camera: TGLCamera;
    Cylinder1: TMenuItem;
    Cone1: TMenuItem;
    N4: TMenuItem;
    CylinderAction: TAction;
    ConeAction: TAction;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    N5: TMenuItem;
    ImportColours1: TMenuItem;
    N6: TMenuItem;
    FileImportColoursAction: TAction;
    ImportColoursDialog: TOpenDialog;
    TextureList: TListView;
    TopSplitter: TSplitter;
    BottomSplitter: TSplitter;
    LoadTextures1: TMenuItem;
    SaveTextures1: TMenuItem;
    LoadTexturesAction: TAction;
    SaveTexturesAction: TAction;
    LoadTexturesDialog: TOpenDialog;
    SaveTexturesDialog: TSaveDialog;
    N7: TMenuItem;
    Export1: TMenuItem;
    N8: TMenuItem;
    FileExportAction: TAction;
    ExportDialog: TSaveDialog;
    procedure OnFileNew(Sender: TObject);
    procedure OnFileOpen(Sender: TObject);
    procedure OnFileSave(Sender: TObject);
    procedure OnFileSaveAs(Sender: TObject);
    procedure OnFileExit(Sender: TObject);
    procedure OnEditCut(Sender: TObject);
    procedure OnEditCopy(Sender: TObject);
    procedure OnEditPaste(Sender: TObject);
    procedure OnHelpAbout(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OnCreateCamera(Sender: TObject);
    procedure OnCreateSpotLight(Sender: TObject);
    procedure OnCreatePlane(Sender: TObject);
    procedure OnCreateSphere(Sender: TObject);
    procedure OnCreateCube(Sender: TObject);
    procedure OnProjectTreeChange(Sender: TObject; Node: TTreeNode);
    procedure OnViewCamera(Sender: TObject);
    procedure OnUpdateViewCamera(Sender: TObject);
    procedure OnViewFront(Sender: TObject);
    procedure OnViewBack(Sender: TObject);
    procedure OnViewLeft(Sender: TObject);
    procedure OnViewRight(Sender: TObject);
    procedure OnViewTop(Sender: TObject);
    procedure OnViewBottom(Sender: TObject);
    procedure OnCreateCylinder(Sender: TObject);
    procedure OnCreateCone(Sender: TObject);
    procedure OnFileImportColours(Sender: TObject);
    procedure OnLoadTextures(Sender: TObject);
    procedure OnSaveTextures(Sender: TObject);
    procedure OnFileExport(Sender: TObject);
  private
    { Private declarations }
    _logger: TFileLogger;
    _configuration: THelperConfiguration;
    _sceneTemplateManager: TSceneTemplateManager;
    _textureManager: TSceneTextureManager;
    _scene: TScene;
    _projectCleanup: THelperBuildCleanupProject;
    _projectTreeHelper: THelperBuildProjectTree;
    _valueEditor: TBuildValueEditorHelper;
    _sceneBuilder: THelperBuildScene;
    _textureBuilder: THelperBuildTextures;
    _filename: string;
    procedure Build3DScene;
    procedure BuildProjectTree;
    procedure BuildCleanup;
    procedure BuildTextures;
    procedure Build;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses scene.shape, form.about;

procedure TMainForm.Build;
begin
  Build3DScene;
  BuildProjectTree;
  BuildCleanup;
end;

procedure TMainForm.Build3DScene;
begin
  _sceneBuilder.Build;
end;

procedure TMainForm.BuildCleanup;
begin
  _projectCleanup.Cleanup;
end;

procedure TMainForm.BuildProjectTree;
begin
  _projectTreeHelper.Build(_scene);
end;

procedure TMainForm.BuildTextures;
begin
  _textureBuilder.Build;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  textureFilename: string;

begin
  _logger := TFileLogger.Create('mse2.log');
  _configuration := THelperConfiguration.Create(_logger);
  _sceneTemplateManager := TSceneTemplateManager.Create(_logger, _configuration.Path);
  _textureManager := TSceneTextureManager.Create(_logger);
  textureFilename := TPath.Combine(_configuration.Path, 'textures\textures.mst');
  _textureManager.Load(textureFilename);
  _scene := TScene.Create;
  _projectTreeHelper := THelperBuildProjectTree.Create(ProjectTree);
  _projectCleanup := THelperBuildCleanupProject.Create(_scene);
  _valueEditor := TBuildValueEditorHelper.Create(ValueListEditor);
  _sceneBuilder := THelperBuildScene.Create(Scene, Scene.Objects, Camera, _scene);
  _textureBuilder := THelperBuildTextures.Create(TextureList, _textureManager);

  _scene.View := TSceneView.Front;

  Build3DScene;
  BuildTextures;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  _configuration.Free;
  _sceneTemplateManager.Free;
  _sceneBuilder.Free;
  _valueEditor.Free;
  _projectCleanup.Free;
  _projectTreeHelper.Free;
  _scene.Free;
  _textureManager.Free;
  _logger.Free;
end;

procedure TMainForm.OnCreateCamera(Sender: TObject);
begin
  _scene.CreateShape('camera');
  Build;
end;

procedure TMainForm.OnCreateCone(Sender: TObject);
begin
  _scene.CreateShape('cone');
  Build;
end;

procedure TMainForm.OnCreateCube(Sender: TObject);
begin
  _scene.CreateShape('cube');
  Build;
end;

procedure TMainForm.OnCreateCylinder(Sender: TObject);
begin
  _scene.CreateShape('cylinder');
  Build;
end;

procedure TMainForm.OnCreatePlane(Sender: TObject);
begin
  _scene.CreateShape('plane');
  Build;
end;

procedure TMainForm.OnCreateSphere(Sender: TObject);
begin
  _scene.CreateShape('sphere');
  Build;
end;

procedure TMainForm.OnCreateSpotLight(Sender: TObject);
begin
  _scene.CreateShape('pointlight');
  Build;
end;

procedure TMainForm.OnEditCopy(Sender: TObject);
begin
  //
end;

procedure TMainForm.OnEditCut(Sender: TObject);
begin
  //
end;

procedure TMainForm.OnEditPaste(Sender: TObject);
begin
  //
end;

procedure TMainForm.OnFileExit(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.OnFileExport(Sender: TObject);
begin
  if ExportDialog.Execute then
    _scene.GenerateScene(_sceneTemplateManager, 'POVray', ExportDialog.FileName);
end;

procedure TMainForm.OnFileImportColours(Sender: TObject);
begin
  if ImportColoursDialog.Execute then
  begin
    _textureManager.ImportColours(ImportColoursDialog.FileName);
    BuildTextures;
  end;
end;

procedure TMainForm.OnFileNew(Sender: TObject);
begin
  _scene.Clear;
  Build;
end;

procedure TMainForm.OnFileOpen(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    _scene.Load(OpenDialog.FileName);
    _filename := OpenDialog.FileName;
    Build;
  end;
end;

procedure TMainForm.OnFileSave(Sender: TObject);
begin
  if Length(_filename) > 0 then
    _scene.Save(_filename)
  else
    OnFileSaveAs(sender);
end;

procedure TMainForm.OnFileSaveAs(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    _scene.Save(SaveDialog.FileName);
    _filename := SaveDialog.FileName;
  end;
end;

procedure TMainForm.OnHelpAbout(Sender: TObject);
var
  dialog: TAboutBox;

begin
  dialog := TAboutBox.Create(self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TMainForm.OnLoadTextures(Sender: TObject);
begin
  if LoadTexturesDialog.Execute then
  begin
    _textureManager.Load(LoadTexturesDialog.FileName);
    BuildTextures;
  end;
end;

procedure TMainForm.OnProjectTreeChange(Sender: TObject; Node: TTreeNode);
var
  shape: TShape;

begin
  shape := Node.Data;
  if assigned(shape) then
    _valueEditor.Build(shape.ParameterManager);
end;

procedure TMainForm.OnSaveTextures(Sender: TObject);
begin
  if SaveTexturesDialog.Execute then
    _textureManager.Save(SaveTexturesDialog.FileName);
end;

procedure TMainForm.OnUpdateViewCamera(Sender: TObject);
begin
  ViewCameraAction.Enabled := Assigned(_scene.Camera);
end;

procedure TMainForm.OnViewBack(Sender: TObject);
begin
  _scene.View := TSceneView.Back;
  Build3DScene;
end;

procedure TMainForm.OnViewBottom(Sender: TObject);
begin
  _scene.View := TSceneView.Bottom;
  Build3DScene;
end;

procedure TMainForm.OnViewCamera(Sender: TObject);
begin
  _scene.View := TSceneView.Camera;
  Build3DScene;
end;

procedure TMainForm.OnViewFront(Sender: TObject);
begin
  _scene.View := TSceneView.Front;
  Build3DScene;
end;

procedure TMainForm.OnViewLeft(Sender: TObject);
begin
  _scene.View := TSceneView.Left;
  Build3DScene;
end;

procedure TMainForm.OnViewRight(Sender: TObject);
begin
  _scene.View := TSceneView.Right;
  Build3DScene;
end;

procedure TMainForm.OnViewTop(Sender: TObject);
begin
  _scene.View := TSceneView.Top;
  Build3DScene;
end;

end.
