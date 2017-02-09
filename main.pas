unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, System.ImageList,
  Vcl.ImgList, Vcl.ToolWin, System.Actions, Vcl.ActnList, Vcl.Menus,
  GLCrossPlatform, GLBaseClasses, GLScene, GLWin32Viewer, Vcl.Grids,
  Vcl.ValEdit, Vcl.ExtCtrls,
  scene;

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
    Splitter1: TSplitter;
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
  private
    { Private declarations }
    _scene: TScene;
    procedure Build3DScene;
    procedure BuildProjectTree;
    procedure Build;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses scene.camera, scene.cube, scene.plane, scene.sphere, scene.light.spot;

procedure TMainForm.Build;
begin
  Build3DScene;
  BuildProjectTree;
end;

procedure TMainForm.Build3DScene;
begin

end;

procedure TMainForm.BuildProjectTree;
begin

end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  _scene := TScene.Create;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  _scene.Free;
end;

procedure TMainForm.OnCreateCamera(Sender: TObject);
var
  camera: TSceneCamera;

begin
  camera := TSceneCamera.Create;
  _scene.AddShape(camera);
  Build;
end;

procedure TMainForm.OnCreateCube(Sender: TObject);
var
  cube: TSceneCube;

begin
  cube := TSceneCube.Create;
  _scene.AddShape(cube);
  Build;
end;

procedure TMainForm.OnCreatePlane(Sender: TObject);
var
  plane: TScenePlane;

begin
  plane := TScenePlane.Create;
  _scene.AddShape(plane);
  Build;
end;

procedure TMainForm.OnCreateSphere(Sender: TObject);
var
  sphere: TSceneSphere;

begin
  sphere := TSceneSphere.Create;
  _scene.AddShape(sphere);
  Build;
end;

procedure TMainForm.OnCreateSpotLight(Sender: TObject);
var
  light: TSceneSpotLight;

begin
  light := TSceneSpotLight.Create;
  _scene.AddShape(light);
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

procedure TMainForm.OnFileNew(Sender: TObject);
begin
  //
end;

procedure TMainForm.OnFileOpen(Sender: TObject);
begin
  //
end;

procedure TMainForm.OnFileSave(Sender: TObject);
begin
  //
end;

procedure TMainForm.OnFileSaveAs(Sender: TObject);
begin
  //
end;

procedure TMainForm.OnHelpAbout(Sender: TObject);
begin
  //
end;

end.
