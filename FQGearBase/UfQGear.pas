unit UfQGear;

interface

uses
	System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, System.JSON,
    Generics.Collections, IniFiles, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
    Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.OleCtrls, Vcl.Menus, Vcl.ToolWin,
    IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
    Winapi.Windows, Winapi.Messages, SHDocVw, MSHTML,
	IdIOHandler, IdIOHandlerStream, IdIOHandlerSocket, IdIOHandlerStack, System.IOUtils,
    FQ, FQ.Flow, Vcl.ImgList, System.SyncObjs, FQ.GVar, SynEdit, SynEditHighlighter, SynHighlighterFQ, SynHighlighterPHP, SynMemo,
	SynEditOptionsDialog, SynEditMiscClasses, SynEditSearch, RTTI;

type
  TfP = class(TForm)
    Panel3: TPanel;
    TabMain: TTabControl;
    Panel14: TPanel;
    Panel1: TPanel;
    PanelConsole: TPanel;
    PanelScript: TPanel;
    Splitter3: TSplitter;
    Panel12: TPanel;
    MemoScript: TMemo;
    Panel9: TPanel;
    Panel13: TPanel;
    WebScript: TWebBrowser;
    Panel7: TPanel;
    TimerCreateDelay: TTimer;
    Panel8: TPanel;
    Panel15: TPanel;
    Button4: TButton;
    Panel17: TPanel;
    Panel18: TPanel;
    WebFQ: TWebBrowser;
    Splitter4: TSplitter;
    MemoFQ: TMemo;
    Panel19: TPanel;
    Panel20: TPanel;
    Panel2: TPanel;
    ComboPath: TComboBox;
    Panel21: TPanel;
    Panel6: TPanel;
    Panel16: TPanel;
    Splitter1: TSplitter;
    Panel5: TPanel;
    Panel11: TPanel;
    Panel22: TPanel;
    Panel23: TPanel;
    Panel24: TPanel;
    Button1: TButton;
    Panel25: TPanel;
    Panel26: TPanel;
    SParams: TComboBox;
    Panel27: TPanel;
    Splitter2: TSplitter;
    Panel28: TPanel;
    RSection: TComboBox;
    RParams: TComboBox;
    Button5: TButton;
    Splitter6: TSplitter;
    ListStack: TListView;
    Panel29: TPanel;
    ListVar: TListView;
    Splitter5: TSplitter;
    IdIOHandlerStack1: TIdIOHandlerStack;
    IdHTTP: TIdHTTP;
    Panel4: TPanel;
    RichConsole: TRichEdit;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ImageList1: TImageList;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolStop: TToolButton;
    Panel10: TPanel;
    ToolPlay: TToolButton;
    ToolButton2: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    fs: TFileSaveDialog;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    SynFQSyn1: TSynFQSyn;
    Memorun: TSynEdit;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    fo: TFileOpenDialog;
    MenuMain: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    N9: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    N7: TMenuItem;
    EncodeandSaveRAW1: TMenuItem;
    N8: TMenuItem;
    Exit1: TMenuItem;
    Edit1: TMenuItem;
    Console1: TMenuItem;
    CheckAutoscroll: TMenuItem;
    LogLevel1: TMenuItem;
    CheckLogLevel7: TMenuItem;
    N1: TMenuItem;
    CheckLogLevel0: TMenuItem;
    CheckLogLevel1: TMenuItem;
    CheckLogLevel2: TMenuItem;
    CheckLogLevel3: TMenuItem;
    CheckLogLevel4: TMenuItem;
    CheckLogLevel5: TMenuItem;
    CheckLogLevel6: TMenuItem;
    ClearBuffer1: TMenuItem;
    ClearCode1: TMenuItem;
    Script1: TMenuItem;
    AutoDownload: TMenuItem;
    AutoReload: TMenuItem;
    N5: TMenuItem;
    RunMode1: TMenuItem;
    SetHTTPUrl1: TMenuItem;
    N3: TMenuItem;
    ClearScript1: TMenuItem;
    ReloadScriptfromHTTP1: TMenuItem;
    LoadScriptfromHTTPNoreset1: TMenuItem;
    Window1: TMenuItem;
    ClerHTTPFolder1: TMenuItem;
    ClearParams1: TMenuItem;
    ClearScriptParams1: TMenuItem;
    N11: TMenuItem;
    ClearStackLog1: TMenuItem;
    ClearVarLog1: TMenuItem;
    ClearAllLog1: TMenuItem;
    N12: TMenuItem;
    CheckRun: TMenuItem;
    N13: TMenuItem;
    CheckReset: TMenuItem;
    Button2: TButton;
    N14: TMenuItem;
    N2: TMenuItem;
    CheckLeaks: TMenuItem;
    CheckOnLog: TMenuItem;
    CheckOnStack: TMenuItem;
    CheckOnVar: TMenuItem;
    CrazyTest: TTimer;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    CrazyTestInterval1: TMenuItem;
    N4: TMenuItem;
    ToolButton13: TToolButton;
    ToolPause: TToolButton;
    procedure WebScriptDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
    procedure MemoScriptChange(Sender: TObject);
    procedure MenuItemChangeCheck(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TabMainChange(Sender: TObject);
    procedure TimerCreateDelayTimer(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure WebFQDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
    procedure MemoFQChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ClearBuffer1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SetHTTPUrl1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ClerHTTPFolder1Click(Sender: TObject);
    procedure ClearParams1Click(Sender: TObject);
    procedure ClearCode1Click(Sender: TObject);
    procedure ClearScriptParams1Click(Sender: TObject);
    procedure MoveListViewItem(var ListView: TListView; const FromId, ToId: Integer);
    procedure ClearScript1Click(Sender: TObject);
    procedure FQLog(const Text: string; const Level: Integer);
    procedure LoadScriptfromHTTPNoreset1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolStopClick(Sender: TObject);
    procedure EncodeandSaveRAW1Click(Sender: TObject);
    procedure FQVarSet(const PID:String; const Name: string; const Value: String; const LineName:String);
    procedure FQStack(const PID:string; const Name: string; const Start: Boolean;
  const Result: String;
  const Env: String; const LineName:String);
    procedure ToolButton9Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SaveAs1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure ClearStackLog1Click(Sender: TObject);
    procedure ClearVarLog1Click(Sender: TObject);
    procedure ClearAllLog1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MemorunDropFiles(Sender: TObject; X, Y: Integer; AFiles: TStrings);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ReloadScriptfromHTTP1Click(Sender: TObject);
    procedure CrazyTestTimer(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure CrazyTestInterval1Click(Sender: TObject);
    procedure ToolPauseClick(Sender: TObject);
    procedure MemorunKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
	ConsoleLength : integer;
    ScriptUrl:string;
    PreSection,PreElement: string;
    CrazyTestDist:Integer;
    procedure GetScriptFlows();
    procedure WMHotKey(var Msg: TWMHotKey); message WM_HOTKEY;
  public
  	FQ: TFQ;
  	Gen_Res : variant;
    Gen_Sem: boolean;
    HotKey1 : Integer;
    HotKey2 : Integer;
  	function HTTP_Get(Url: string): string;
	procedure WebScriptLoad();
	procedure WebScriptApply(Browser:TWebBrowser; const Lines:String);
    procedure ChangeMainTab(TabIndex:integer);
    procedure SetFqRend();
    function OnEFQF(var Owned:Boolean; const Name:String; const Env:TDictionary<String, TGVar>): TValue;
  end;

var
  fP: TfP;

implementation

{$R *.dfm}


procedure TfP.SaveAs1Click(Sender: TObject);
begin
	if (fs.Execute) then
    	memorun.Lines.SaveToFile(fs.FileName);
end;

procedure TfP.SetFqRend();
begin
	if CheckOnLog.Checked then
		fq.OnLog := FQlog else  fq.OnLog := nil;

    if CheckOnStack.Checked then
    	fq.OnStack := FQStack else fq.onstack := nil;

    if CheckOnVar.Checked then
    	fq.OnVarSet := FQVarset else fq.OnVarSet := nil;
end;

procedure TfP.FormCreate(Sender: TObject);
var
	Stream:TMemoryStream;
    Ini : TIniFile;
    i:integer;
begin

	//Form elements
		FQ := TFQ.Create;

        FQ.OnEFQF := OnEFQF;

    //Ini File
    	Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));

        panel5.Height := Ini.ReadInteger('panel5','Height', panel5.Height);
        panel21.Width := Ini.ReadInteger('panel5','Height', panel21.Width);

        panel21.Width := Ini.ReadInteger('panel21','Width', panel21.Width);
        ListStack.Columns.Items[0].Width := Ini.ReadInteger('liststack0','Width', ListStack.Columns.Items[0].Width);
        ListStack.Columns.Items[1].Width := Ini.ReadInteger('liststack1','Width', ListStack.Columns.Items[1].Width);
        ListStack.Columns.Items[2].Width := Ini.ReadInteger('liststack2','Width', ListStack.Columns.Items[2].Width);
        ListStack.Columns.Items[3].Width := Ini.ReadInteger('liststack3','Width', ListStack.Columns.Items[3].Width);
        ListStack.Columns.Items[4].Width := Ini.ReadInteger('liststack4','Width', ListStack.Columns.Items[4].Width);
        ListStack.Columns.Items[5].Width := Ini.ReadInteger('liststack5','Width', ListStack.Columns.Items[5].Width);
        ListStack.Columns.Items[6].Width := Ini.ReadInteger('liststack6','Width', ListStack.Columns.Items[6].Width);

        ListVar.Columns.Items[0].Width := Ini.ReadInteger('listvar0','Width', ListVar.Columns.Items[0].Width);
        ListVar.Columns.Items[1].Width := Ini.ReadInteger('listvar1','Width', ListVar.Columns.Items[1].Width);
        ListVar.Columns.Items[2].Width := Ini.ReadInteger('listvar2','Width', ListVar.Columns.Items[2].Width);
        ListVar.Columns.Items[3].Width := Ini.ReadInteger('listvar3','Width', ListVar.Columns.Items[3].Width);
        ListVar.Columns.Items[4].Width := Ini.ReadInteger('listvar4','Width', ListVar.Columns.Items[4].Width);


        Panel21.Visible := Ini.ReadBool('splitter1','Visible', Splitter1.Visible);
        Splitter1.Visible := Ini.ReadBool('splitter1','Visible', Splitter1.Visible);
        CrazyTestDist := Ini.ReadInteger('conf', 'CrazyTestDist', 3000);

        ScriptUrl := Ini.ReadString('conf','ScriptUrl', 'http://sam.lagsoft.net/fq/get.php?file=');

        for I := 0 to 7 do TMenuItem(FindComponent('CheckLogLevel'+inttostr(i))).Checked := Ini.ReadBool('checkloglevel',inttostr(i), TMenuItem(FindComponent('CheckLogLevel'+inttostr(i))).Checked);

        AutoReload.Checked := Ini.ReadBool('menu','AutoReload', AutoReload.Checked);
        AutoDownload.Checked := Ini.ReadBool('menu','AutoDownload', AutoDownload.Checked);
        CheckRun.Checked := Ini.ReadBool('menu','CheckRun', CheckRun.Checked);
        CheckReset.Checked := Ini.ReadBool('menu','CheckReset', CheckReset.Checked);

        CheckLeaks.Checked := Ini.ReadBool('menu','CheckLeaks', CheckLeaks.Checked);

        ReportMemoryLeaksOnShutdown := CheckLeaks.Checked;

        CheckOnStack.Checked := Ini.ReadBool('menu','CheckOnStack', CheckOnStack.Checked);
        CheckOnLog.Checked := Ini.ReadBool('menu','CheckOnLog', CheckOnLog.Checked);
        CheckOnVar.Checked := Ini.ReadBool('menu','CheckOnVar', CheckOnVar.Checked);
        SetFqRend();

    	TabMain.TabIndex := Ini.ReadInteger('menu','TabMain', TabMain.TabIndex);


        if FileExists(ChangeFileExt(Application.ExeName, '.script')) then
        	Memorun.Lines.LoadFromFile(ChangeFileExt(Application.ExeName, '.script'));

        Stream := TMemoryStream.create();
        Ini.ReadBinaryStream('data','ComboPath', Stream);
        Stream.Position := 0;
        ComboPath.Items.LoadFromStream(Stream);
        Stream.Free;
        if (ComboPath.Items.Count = 0) then ComboPath.Items.Add('fq');
        ComboPath.ItemIndex := Ini.ReadInteger('data','ComboPathI', 0);


        PreSection := Ini.ReadString('conf', 'PreSection', '');
        PreElement := Ini.ReadString('conf', 'PreElement', '');
        Stream := TMemoryStream.create();
        Ini.ReadBinaryStream('data','RParams', Stream);
        Stream.Position := 0;
        RParams.Items.LoadFromStream(Stream);
        Stream.Free;
       // RParams.Text := Ini.ReadString('data','RParamsT', '');
       	if (Ini.ReadInteger('data','RParamsI', -1) < RParams.Items.Count) then
			RParams.ItemIndex := Ini.ReadInteger('data','RParamsI', -1);


        Stream := TMemoryStream.create();
        Ini.ReadBinaryStream('data','SParams', Stream);
        Stream.Position := 0;
        SParams.Items.LoadFromStream(Stream);
        Stream.Free;
        //SParams.Text := Ini.ReadString('data','SParamsT', '');
       	if (Ini.ReadInteger('data','SParamsI', -1) < SParams.Items.Count) then
			SParams.ItemIndex := Ini.ReadInteger('data','SParamsI', -1);

        Ini.Free;

    //Preparamos el WebScript
       	WebScriptLoad();

    //Y lanzaremos el delay Create
	  	TimerCreateDelay.Enabled := True;

    //Hokeys
   // 	RegisterHotKey(Handle, 0, 0, VK_F4);
    //    RegisterHotKey(Handle, 1, 0, VK_F3);
end;


procedure TfP.FormDestroy(Sender: TObject);
begin
	UnRegisterHotKey(Handle, 0);
    UnRegisterHotKey(Handle, 1);
    if ToolPause.Marked then ToolPause.Click;
    
    fq.Free;
end;

procedure TfP.Timer1Timer(Sender: TObject);
begin
button1.Click;
end;

procedure TfP.TimerCreateDelayTimer(Sender: TObject);
var
    Ini : TIniFile;
    needload:boolean;
begin

	//Prevenimos la re-ejecución
    	TimerCreateDelay.Enabled := False;

        ChangeMainTab(TabMain.TabIndex);

    //Cargamos el script en FQ
      	{MemoScript.WordWrap := False;
		MemoScript.Text := FQ.LoadScript(MemoScript.Text);
        MemoScript.WordWrap := True; }

    //Ini File
    	Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
        fp.Position := poDesigned;
        fP.Width := Ini.ReadInteger('pos','Width', fP.Width);
        fP.Height := Ini.ReadInteger('pos','Height', fP.Height);
        fP.Top := Ini.ReadInteger('pos','Top', fP.Top);
        fP.Left := Ini.ReadInteger('pos','Left', fP.Left);

        if Ini.ReadBool('pos','Maxi', false) then fp.WindowState := wsMaximized;
        Ini.Free;

    //Cargamos el script de HTTP
    	needload := false;
        if ((AutoReload.Checked) and (FileExists(ChangeFileExt(Application.ExeName, '.http.script')))) then begin
        	MemoScript.Lines.LoadFromFile(ChangeFileExt(Application.ExeName, '.http.script'));
            needload := true;
        end;
    	if (AutoDownload.Checked) then begin
			Button4.Click;
            needload := true;
        end;
        if (needload) then Button2.Click;





end;


procedure TfP.ToolButton11Click(Sender: TObject);
begin

CrazyTest.Interval := CrazyTestDist;
CrazyTest.Enabled := not CrazyTest.Enabled;
if not CrazyTest.Enabled then
ToolButton11.ImageIndex := 8 else ToolButton11.ImageIndex := 10;
end;

procedure TfP.ToolButton3Click(Sender: TObject);
begin
	memorun.Lines.SaveToFile(ChangeFileExt(Application.ExeName, '.script'));
end;

procedure TfP.ToolButton9Click(Sender: TObject);
begin
	if (Panel21.Width < 10) then Panel21.Visible := False;

    Splitter1.Visible := not panel21.Visible;
	Panel21.Visible := not panel21.Visible;
    if (Panel21.Visible) and (Panel21.Width < 10) then Panel21.Width := 300;

end;

procedure TfP.ToolPauseClick(Sender: TObject);
var
	i:integer;
begin
	ToolPause.Marked := not ToolPause.Marked;

    for I in fq.Threads.Keys do begin
		fq.Threads[i].Suspended := ToolPause.Marked;
    end;

end;

procedure TfP.ToolStopClick(Sender: TObject);
begin

	if (TToolButton(Sender).Name = 'ToolStop') then begin
        ToolPlay.Down := False;
        ToolStop.Down := True;
    end;
	if (TToolButton(Sender).Name = 'ToolPlay') then begin
        ToolPlay.Down := True;
        ToolStop.Down := False;

    end;

    if CrazyTest.Enabled then
        ToolButton11.Click;
	FQ.BreakStack := ToolStop.Down;
end;

procedure TfP.FormClose(Sender: TObject; var Action: TCloseAction);
var
    Ini : TIniFile;
	Stream:TMemoryStream;
    i:integer;
begin
	//Frees
	//Ini data
    	Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));

    	if (fp.WindowState = wsNormal) then begin
            Ini.WriteInteger('pos', 'Width', fP.Width);
            Ini.WriteInteger('pos', 'Height', fP.Height);
            Ini.WriteInteger('pos', 'Top', fP.Top);
            Ini.WriteInteger('pos', 'Left', fP.Left);
        end;
        Ini.WriteBool('pos','Maxi', (fp.WindowState = wsMaximized));

        Ini.WriteString('conf', 'ScriptUrl', ScriptUrl);

    	Ini.WriteInteger('panel5', 'Height', panel5.Height);


        Ini.WriteInteger('conf', 'CrazyTestDist', CrazyTestDist);

        Ini.WriteInteger('panel21', 'Width', panel21.Width);

        Ini.WriteBool('splitter1', 'Visible', Splitter1.Visible);
        if (panel21.Visible) then begin

            Ini.WriteInteger('liststack0', 'Width', ListStack.Columns.Items[0].Width);
            Ini.WriteInteger('liststack1', 'Width', ListStack.Columns.Items[1].Width);
            Ini.WriteInteger('liststack2', 'Width', ListStack.Columns.Items[2].Width);
            Ini.WriteInteger('liststack3', 'Width', ListStack.Columns.Items[3].Width);
            Ini.WriteInteger('liststack4', 'Width', ListStack.Columns.Items[4].Width);
            Ini.WriteInteger('liststack5', 'Width', ListStack.Columns.Items[5].Width);
            Ini.WriteInteger('liststack6', 'Width', ListStack.Columns.Items[6].Width);

            Ini.WriteInteger('listvar0', 'Width', listvar.Columns.Items[0].Width);
            Ini.WriteInteger('listvar1', 'Width', listvar.Columns.Items[1].Width);
            Ini.WriteInteger('listvar2', 'Width', listvar.Columns.Items[2].Width);
            Ini.WriteInteger('listvar3', 'Width', listvar.Columns.Items[3].Width);
            Ini.WriteInteger('listvar4', 'Width', listvar.Columns.Items[4].Width);
        end;



        for I := 0 to 7 do Ini.WriteBool('checkloglevel',inttostr(i), TMenuItem(FindComponent('CheckLogLevel'+inttostr(i))).Checked);

        Ini.WriteBool('menu','AutoReload', AutoReload.Checked);
        Ini.WriteBool('menu','AutoDownload', AutoDownload.Checked);

        Ini.WriteBool('menu','CheckRun', CheckRun.Checked);
        Ini.WriteBool('menu','CheckReset', CheckReset.Checked);
        Ini.WriteBool('menu','CheckLeaks', CheckLeaks.Checked);

        Ini.WriteBool('menu','CheckOnLog', CheckOnLog.Checked);
        Ini.WriteBool('menu','CheckOnStack', CheckOnStack.Checked);
        Ini.WriteBool('menu','CheckOnVar', CheckOnVar.Checked);

		Ini.WriteInteger('menu','TabMain', TabMain.TabIndex);


    	memorun.Lines.SaveToFile(ChangeFileExt(Application.ExeName, '.script'));

        Ini.WriteInteger('data','ComboPathI', ComboPath.ItemIndex);
        Stream := TMemoryStream.create();
        ComboPath.Items.SaveToStream(Stream);
        Stream.Position := 0;
        Ini.WriteBinaryStream('data','ComboPath', Stream);
        Stream.Free;


        Ini.WriteString('conf', 'PreSection', RSection.Text);
        Ini.WriteInteger('data','RParamsI', RParams.ItemIndex);
        //Ini.WriteString('data','RParamsT', RParams.Text);
        Stream := TMemoryStream.create();
        RParams.Items.SaveToStream(Stream);
        Stream.Position := 0;
        Ini.WriteBinaryStream('data','RParams', Stream);
        Stream.Free;

        //Ini.WriteString('data','SParamsT', SParams.Text);
        Ini.WriteInteger('data','SParamsI', SParams.ItemIndex);
        Stream := TMemoryStream.create();
        SParams.Items.SaveToStream(Stream);
        Stream.Position := 0;
        Ini.WriteBinaryStream('data','SParams', Stream);
        Stream.Free;

        Ini.free;
end;


procedure TfP.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
	FQ.BreakStack := ToolStop.Down;
end;

function TfP.HTTP_Get(Url: string): string;
begin
    try
		Result := IdHTTP.Get(Url);

    finally
        IdHTTP.Disconnect;
    end;
end;

procedure TfP.LoadScriptfromHTTPNoreset1Click(Sender: TObject);
begin
	Button4.Click;

        MemoScript.WordWrap := False;
        FQ.ScriptAddSectionsAsJSON(MemoScript.Text, False, CheckRun.Checked, '');
        MemoScript.WordWrap := True;

        MemoFQ.Text := FQ.ScriptGetAsJSON;

        GetScriptFlows();
end;

procedure TfP.Button1Click(Sender: TObject);
var
    Result:Variant;
    Flow:TFlow;
begin
	ToolButton3.Click;

	FQ.ScriptAddSection('Anonymous', MemoRun.Lines.Text);
    MemoFQ.Text := FQ.ScriptGetAsJSON;

    FQ.RunSectionOnThread(FQ, 'Anonymous', fq.ClearParamsLine(SParams.Text));

	if (SParams.Items.IndexOf(SParams.Text) < 0) then begin
    	SParams.Items.Add(SParams.Text);
        SParams.ItemIndex := SPARAMS.Items.Count-1;
    end;
end;


function TfP.OnEFQF(var Owned:Boolean; const Name:String; const Env:TDictionary<String, TGVar>): TValue;
begin
    //Start FQF sete
    if (Name = 'fqgear') then begin Owned := True;
    	Result := 'Me envias:'+Env['0'].GetValue;
    end;
end;


procedure TfP.Button2Click(Sender: TObject);
begin
	MemoScript.WordWrap := False;
	FQ.ScriptAddSectionsAsJSON(MemoScript.Text, CheckReset.Checked, CheckRun.Checked, '');
	MemoScript.WordWrap := True;

	MemoFQ.Text := FQ.ScriptGetAsJSON;

	GetScriptFlows();
end;

procedure TfP.Button4Click(Sender: TObject);
var
	Result:Variant;
begin
	//Cargamos el script bajo petición
    	MemoScript.WordWrap := False;
        if (ComboPath.Items.IndexOf(ComboPath.Text) < 0) then ComboPath.Items.Add(ComboPath.Text);
        MemoScript.Text := HTTP_Get(ScriptUrl+ComboPath.Text);

        MemoScript.Lines.SaveToFile(ChangeFileExt(Application.ExeName, '.http.script'));
end;

procedure TfP.Button5Click(Sender: TObject);
begin
 	if (RParams.Items.IndexOf(RParams.Text) < 0) then begin
    	RParams.Items.Add(RParams.Text);
        RParams.ItemIndex := RParams.Items.Count-1;
    end;

    FQ.RunSectionOnThread(FQ, RSection.Text, FQ.ClearParamsLine(RParams.Text));
end;

procedure TfP.ChangeMainTab(TabIndex:integer);
begin
    //Ocultamos todos los paneles
    	PanelScript.Visible := False;
		PanelConsole.Visible := False;
    	PanelScript.Align := alClient;
		PanelConsole.Align := alClient;

    //Y mostramos el que se solicita
		case TabIndex of
			0 : PanelScript.Visible := True;
			1 : PanelConsole.Visible := True;
       		else PanelScript.Visible := True;
		end;
end;

procedure TfP.ClearAllLog1Click(Sender: TObject);
begin
ClearBuffer1.Click;
ClearStackLog1.Click;
ClearVarLog1.Click;
end;

procedure TfP.ClearBuffer1Click(Sender: TObject);
begin
	Update;
    fq.ThreadLock_OnLog.Acquire;
	RichConsole.Lines.Clear;
    ConsoleLength := 0;
    fq.ThreadLock_OnLog.Release;
end;

procedure TfP.ClearCode1Click(Sender: TObject);
begin
	if (MessageDlg('Are you sure want to clear handwritten script text?',mtCustom, [mbYes,mbCancel], 0) = mrYes) then
		MemoRun.Lines.Clear;
end;

procedure TfP.ClearParams1Click(Sender: TObject);
begin
	RParams.Items.Clear;
end;

procedure TfP.ClearScript1Click(Sender: TObject);
begin
	//FQ.Script_Reset;
end;

procedure TfP.ClearScriptParams1Click(Sender: TObject);
begin
	SParams.Items.Clear;
end;

procedure TfP.ClearStackLog1Click(Sender: TObject);
begin
    Update;
    fq.ThreadLock_OnStack.Acquire;
	ListStack.items.Clear;
    fq.ThreadLock_OnStack.Release;
end;

procedure TfP.ClearVarLog1Click(Sender: TObject);
begin
    Update;
    fq.ThreadLock_OnVarSet.Acquire;
	ListVar.items.Clear;
    fq.ThreadLock_OnVarSet.Release;
end;

procedure TfP.ClerHTTPFolder1Click(Sender: TObject);
begin
	ComboPath.Items.Clear;
    ComboPath.Items.Add('fq');
    ComboPath.ItemIndex := 0;
end;

procedure TfP.CrazyTestInterval1Click(Sender: TObject);
var
	Value:string;
begin
	Value := InputBox('Interval', 'Miliseconds:', inttostr(CrazyTestDist));
	if (Value <> '' ) then CrazyTestDist := StrToInt(Value);
end;

procedure TfP.CrazyTestTimer(Sender: TObject);
begin
button1.Click;
end;

procedure TfP.EncodeandSaveRAW1Click(Sender: TObject);
var
	Key:string;
    S:string;
    B:TBytes;
    FStream:TFileStream;
begin
	Key := InputBox('Script Password', 'Key:', '');
	if (Key <> '') then begin
        if (fs.Execute) then begin
            S := FQ.Crypt(Key, MemoFQ.Lines.Text);

            B := TEncoding.UTF8.GetBytes(S);
            FStream := TFileStream.Create(fs.FileName, fmCreate);
            FStream.WriteBuffer(S, Length(S));
            FStream.Free;
        end;

    end;
end;

procedure TfP.Exit1Click(Sender: TObject);
begin
	Application.Terminate;
end;

procedure TfP.WebScriptLoad();
begin
	WebScript.Navigate('http://json.parser.online.fr/beta/');
	WebFQ.Navigate('http://json.parser.online.fr/beta/');
end;


procedure TfP.WebScriptApply(Browser:TWebBrowser; const Lines:String);
   procedure WebScriptRunJS(Script: string);
	var
		Doc: IHTMLDocument2;
		HTMLWindow: IHTMLWindow2;
	begin
	  	Doc := Browser.Document as IHTMLDocument2;
		if (not Assigned(Doc)) then  Exit();
		HTMLWindow := Doc.parentWindow;
		if (not Assigned(HTMLWindow)) then Exit();

		try HTMLWindow.execScript(Script, 'JavaScript'); except end;

	end;

var
	TempS: String;
begin
	//Aplicamos los JS necesarios para mostrar el visor de JSON correctamente en el espacio
        TempS := Lines;

        TempS := StringReplace(TempS, '\', '\\', [rfReplaceAll, rfIgnoreCase]);
        TempS := StringReplace(TempS, '''', '\''', [rfReplaceAll, rfIgnoreCase]);
        TempS := StringReplace(TempS, char(13), ''' + "\n" + ''', [rfReplaceAll, rfIgnoreCase]);
        TempS := StringReplace(TempS, char(10), '', [rfReplaceAll, rfIgnoreCase]);
        TempS := StringReplace(TempS, char(11), '', [rfReplaceAll, rfIgnoreCase]);

		WebScriptRunJS('document.getElementById(''editor'').value = ''' + TempS + ''';');
        WebScriptRunJS('document.getElementById(''editor'').click();');

	   	WebScriptRunJS('resizeThin = function() {'
			+ ' ' + 'document.getElementById(''editor'').parentNode.style.width = ''0px'';'
            + ' ' + 'document.getElementById(''editor'').parentNode.style.height = ''0px'';'
            + ' ' + 'document.getElementById(''editor'').parentNode.style.display = ''none'';'
            + ' ' + 'document.getElementById(''result'').parentNode.style.width = ''100%'';'
            + ' ' + 'document.getElementById(''result'').parentNode.style.height =  ''100%'';'
            + ' ' + 'document.getElementById(''result'').style.height =  ''100%'';'
            + ' ' + 'document.getElementById(''result'').style.padding = ''0px'';'
            + ' ' + 'document.getElementById(''result'').style.fontSize = ''12px'';'

            + ' ' + 'setTimeout(function () { resizeThin(); }, 200);'
        + ' };');

        WebScriptRunJS('resizeThin();');
        WebScriptRunJS('window.onresize = resizeThin;');
end;


procedure TfP.FQLog(const Text: string; const Level: Integer);
var
	TempI, MaxLevelToShow:integer;
begin
    if (not RichConsole.HandleAllocated) then Exit;

	MaxLevelToShow := 0;

	for TempI := 0 to 6 do begin
		if (Assigned(FindComponent('CheckLogLevel' + IntToStr(TempI)))) then begin
        	if (TMenuItem(FindComponent('CheckLogLevel' + IntToStr(TempI))).Checked) then begin
				MaxLevelToShow := TempI;
            end;
		end;
    end;

    if ((Level <= MaxLevelToShow) or ((Level = 7) and (CheckLogLevel7.Checked))) then begin
    	ConsoleLength := ConsoleLength + Text.Length + 20;
    	RichConsole.SelLength := 0;
        RichConsole.SelStart := ConsoleLength;
    	RichConsole.SelAttributes.Color := clGray;
  		RichConsole.SelText := '[' + FormatDateTime('hh:nn:ss', GetTime()) + '] ';

        Case Level of
     		0 : RichConsole.SelAttributes.Color := $00F1A374;
			1 : begin RichConsole.SelAttributes.Color := $006262FF; RichConsole.SelAttributes.Style := [fsBold] end;
            2 : begin RichConsole.SelAttributes.Color := $0004A8D0; RichConsole.SelAttributes.Style := [fsBold] end;
            3 : RichConsole.SelAttributes.Color := $001ACEFB;
            4 : RichConsole.SelAttributes.Color := $00A8A800;
            5 : RichConsole.SelAttributes.Color := $00D5D500;
            6 : RichConsole.SelAttributes.Color := $00E6E600;
            7 : RichConsole.SelAttributes.Color := $00009797;
       		else RichConsole.SelAttributes.Color := clBlack;
		end;


  		RichConsole.SelText := Text + char(13) + char(10);

        if (RichConsole.Lines.Count > 5000) then begin

            ConsoleLength := ConsoleLength - RichConsole.Lines.Strings[0].Length;
            RichConsole.Lines.Delete(0);
        end;

        if (CheckAutoscroll.Checked) then
            SendMessage(RichConsole.Handle, WM_VSCROLL, SB_BOTTOM, 0);
    end;
end;

{function TfP.FQFQFExecute(const Name: string; var Owned: Boolean; const FuncEnv: TDictionary<System.string,System.Variant>;
  var Flow: TFlow): Variant;
begin
	Result := '';

    //Funciones cacheadas a FQ
    if (Name = 'funciondeappconreturn') then begin Owned := True;
    	Result := 'Vale!!! Funciona que no es poco';
    end;

end; }

procedure TfP.MoveListViewItem(var ListView: TListView; const FromId, ToId: Integer);
var
  tempLI, OldLi: TListItem;
begin
  if ((FromId < ListView.Items.Count) and (ToId >= 0) and (ToId < ListView.Items.Count)) then begin
    ListView.Items.BeginUpdate;
		tempLI := TListItem.Create(ListView.Items);

		OldLi := ListView.Items.Item[FromId];
		tempLi.SubItems := OldLi.SubItems;
        ListView.Items.AddItem(tempLi, ToId);
		tempLI.Caption := OldLi.Caption;
		listview.Items.Delete(OldLi.Index);

  end;
end;


procedure TfP.Open1Click(Sender: TObject);
begin
	if (fo.Execute) then
    	if FileExists(fo.FileName) then
        	memorun.Lines.LoadFromFile(fo.FileName);
end;

procedure TfP.ReloadScriptfromHTTP1Click(Sender: TObject);
begin
	Button4.Click;
        MemoScript.WordWrap := False;
        FQ.ScriptAddSectionsAsJSON(MemoScript.Text, True, CheckRun.Checked, '');
        MemoScript.WordWrap := True;

        MemoFQ.Text := FQ.ScriptGetAsJSON;

        GetScriptFlows();
end;

procedure TfP.FQStack(const PID:string; const Name: string; const Start: Boolean;
  const Result: String;
  const Env: String; const LineName:String);
var
	Item:TListItem;
    Key: string;
    i:integer;
begin
	//Añadimos a la pila de elementos

   // ThreadLock_OnStack.Acquire;
    if (not ListStack.HandleAllocated) then exit;

        // showmessage('Start: '+Pid) else showmessage('End: '+Pid);

    Item := nil;
    for i := 0 to ListStack.items.Count-1 do
  		if (ListStack.items.item[i].Caption = PID) then begin
        	Item := listStack.items.item[i];
        	break;
        end;

     if (Item <> nil) then begin
        if Start then begin
        	item.SubItems.Strings[0] := 'Run';
            item.SubItems.Strings[2] := Env;

        end else begin
        	item.SubItems.Strings[0] := 'End';
            item.SubItems.Strings[3] := Result;
            item.SubItems.Strings[4] := item.SubItems.Strings[4] + ' - ' +FormatDateTime('hh:nn:ss', GetTime());
        end;

    end else begin

    	Item := ListStack.Items.Insert(0);
        Item.Caption := PID;

        if Start then
        	Item.SubItems.Add('Runing')
        else Item.SubItems.Add('End');

        Item.SubItems.Add(Name);

        Item.SubItems.Add(Env);
        Item.SubItems.Add(Result);

        Item.SubItems.Add(FormatDateTime('hh:nn:ss', GetTime()));

        Item.SubItems.Add(LineName);

    end;


    if (ListStack.Items.Count > 1000) then begin
		ListStack.Items.Item[ListStack.Items.Count-1].Delete;
    end;

   // ThreadLock_OnStack.Release;
end;

procedure TfP.FQVarSet(const PID:String; const Name: string; const Value: String; const LineName:String);
	function SearchItem(Name:String; Pid:String):TListItem;
    var
    	Found:bool;
        Last:integer;
    begin
     Result := nil;
      	if (Name.Chars[0] = '@') then Pid := '0';

    	Found:=false;
        Last := 0;
        while ((not Found) and (Last < ListVar.Items.Count)) do begin
            Result := ListVar.FindCaption(Last, Name, True, True, False);
            if (Result = nil) then break;
            if ((Result.SubItems.count >= 3) and (Result.SubItems.Strings[1] = Pid)) then begin
            	Found := True; break;
            end else Last := Result.Index + 1;
        end;
        if (not Found) then Result := nil;
    end;
var
	Item:TListItem;
begin

	  if (not ListVar.HandleAllocated) then exit;

	//Añadimos a la pila de elementos
{    Item := SearchItem(Name, PID);
    if (Item <> nil) then begin

        Item.SubItems.Strings[0] := Value;

        Item.SubItems.Strings[1] := PID;
        if (Name.Chars[0] = '@') then Item.SubItems.Strings[1] := '0';

        Item.SubItems.Strings[2] := FormatDateTime('hh:nn:ss', GetTime());

        Item.SubItems.Strings[3] := LineName;

    	MoveListViewItem(ListVar, item.Index, 0);

    end else begin                      }
    	Item := ListVar.Items.Insert(0);
        Item.Caption := Name;

        Item.SubItems.Add(Value);


        Item.SubItems.Add(PID);
        //if (Name.Chars[0] = '@') then Item.SubItems.Strings[1] := '0';

        Item.SubItems.Add(FormatDateTime('hh:nn:ss', GetTime()));

        Item.SubItems.Add(LineName);
  //  end;

    if (ListVar.Items.Count > 200) then begin
		ListVar.Items.Item[ListVar.Items.Count-1].Delete;
    end;

end;

procedure TfP.MemoFQChange(Sender: TObject);
begin
	WebScriptApply(WebFQ, MemoFQ.Text);
end;

procedure TfP.MemorunDropFiles(Sender: TObject; X, Y: Integer; AFiles: TStrings);
begin
	memorun.Lines.LoadFromFile(AFiles.Strings[0]);
end;

procedure TfP.MemorunKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((Shift = [ssCtrl]) and (Key = 13)) then button1.Click;
end;

procedure TfP.MemoScriptChange(Sender: TObject);
begin
	WebScriptApply(WebScript, MemoScript.Text);
end;

procedure TfP.MenuItemChangeCheck(Sender: TObject);
begin
	TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
    SetFqRend();
    ReportMemoryLeaksOnShutdown := CheckLeaks.Checked;
end;

procedure TfP.SetHTTPUrl1Click(Sender: TObject);
var
	Value:string;
begin
	Value := InputBox('Script URL', 'Url:', ScriptUrl);
	if (Value <> '' ) then ScriptUrl := Value;
end;

procedure TfP.TabMainChange(Sender: TObject);
begin
	ChangeMainTab(TTabControl(Sender).TabIndex);
end;

procedure TfP.WebScriptDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
begin
	WebScriptApply(WebScript, MemoScript.Text);
end;

procedure TfP.WebFQDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
begin
	WebScriptApply(WebFQ, MemoFQ.Text);
end;

procedure TfP.GetScriptFlows();
var
	Key : string;
    L:TstringList;
begin
 	if (RSection.Text <> '') then PreSection := RSection.Text;

    RSection.Items.Clear;

    RSection.Items.Add('');
    L := TStringList.Create;
  	for Key in FQ.Script.Keys do begin
		L.Add(Key);
    end;
    L.Sort;
  	for Key in L do begin
		RSection.Items.Add(Key);
    end;
    l.Free;


    if (RSection.Items.IndexOf(PreSection) >= 0) then RSection.ItemIndex := RSection.Items.IndexOf(PreSection);
end;

procedure TfP.WMHotKey(var Msg: TWMHotKey);
begin

	if (not Fp.Active) then exit;
    
   inherited;



   case Msg.HotKey of
       0: ReloadScriptfromHTTP1.Click;
       1: LoadScriptfromHTTPNoreset1.Click;
   end;

end;


end.
