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
  private
    { Private declarations }
    _scene: TScene;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
var
  row: integer;

begin
  _scene := TScene.Create;

  ValueListEditor.InsertRow('Name', 'untitled', true);
  row := ValueListEditor.InsertRow('Translate', '0.0, 0.0, 0.0', true);

  row := ValueListEditor.InsertRow('Scale', '1.0, 1.0, 1.0', true);
  row := ValueListEditor.InsertRow('Rotate', '0.0, 0.0, 0.0', true);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  _scene.Free;
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
