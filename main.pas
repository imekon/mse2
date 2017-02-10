unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics,
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

uses scene.shape;

procedure TMainForm.Build;
begin
  Build3DScene;
  BuildProjectTree;
end;

procedure TMainForm.Build3DScene;
begin

end;

procedure TMainForm.BuildProjectTree;
var
  i: integer;
  shape: TShape;
  child, node: TTreeNode;

begin
  ProjectTree.Items.Clear;

  node := ProjectTree.Items.Add(nil, 'Project');

  for i := 0 to _scene.ShapeCount - 1 do
  begin
    shape := _scene.Shapes[i];
    child := ProjectTree.Items.AddChildObject(node, shape.Name, shape);
  end;
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
begin
  _scene.CreateShape('camera');
  Build;
end;

procedure TMainForm.OnCreateCube(Sender: TObject);
begin
  _scene.CreateShape('cube');
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

procedure TMainForm.OnProjectTreeChange(Sender: TObject; Node: TTreeNode);
var
  shape: TShape;

begin
  shape := Node.Data;
end;

end.
