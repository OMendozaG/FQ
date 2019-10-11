unit UMfQGear;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,  Generics.Collections,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox, FMX.Layouts, FMX.Memo, FMX.StdCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, FMX.Edit, System.JSON,
  IdIOHandler, IdIOHandlerStream, IdIOHandlerSocket, IdIOHandlerStack, FQ, fq.FQF;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Panel3: TPanel;
    RSection: TComboBox;
    RElement: TComboBox;
    Button2: TButton;
    Memo1: TMemo;
    Edit1: TEdit;
    Timer1: TTimer;
    loglevel: TComboBox;
    RParams: TEdit;
    id: TIdHTTP;
    procedure Button1Click(Sender: TObject);
    procedure RSectionChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FQLog(const Text: string; const Level: Integer);
  private
    { Private declarations }
  public
  	fq:tfq;
    procedure GetScriptFlows();
    procedure GetScriptSubFlows();
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
	Mem:TStringStream;
begin

	memo1.Lines.Clear;
    Mem := TStringStream.Create('', TEncoding.UTF8);

    mem.Position := 0;
	id.Get('http://sam.lagsoft.net/fq/get.php?file=' + edit1.Text, mem);

    mem.Position := 0;

    fq.ScriptAddSectionsAsJSON(mem.DataString);
	//FQ.Script_AddSections(mem.DataString, True);

	GetScriptFlows();
end;

procedure TForm1.Button2Click(Sender: TObject);
var
    s,e:string;
    Result:variant;
   // Clear:TSectionProcess;
begin

    if (RSection.ItemIndex >= 0) then s := rsection.Items.Strings[RSection.ItemIndex];
    if (RElement.ItemIndex >= 0) then e := RElement.Items.Strings[RElement.ItemIndex];

    FQ.RunSectionOnThread(FQ, s, fq.ClearParamsLine(RParams.Text));

    //Clear := TSectionProcess.Create();

   //Result := TFLow.Create(s, Form1.FQ, Clear.LineClear(RParams.Text), True).Result;


end;

procedure TForm1.FormCreate(Sender: TObject);
begin
	Timer1.Enabled := true;
	FQ := tfq.Create;
    FQ.FQF := TFQF.Create(FQ);

    fq.OnLog := FQLog;
    fq.OnStack := nil;
    fq.OnVarSet := nil;
end;

{function TForm1.FQFQFExecute(const Name: string; var Owned: Boolean; const FuncEnv: TDictionary<System.string,System.Variant>;
  var Flow: TFlow): Variant;
begin
    if (Name = 'funciondeappconreturn') then begin Owned := True;
    	Result := 'Vale!!! Funciona que no es poco';
    end;
end;    }

procedure TForm1.FQLog(const Text: string; const Level: Integer);
begin
	if (loglevel.ItemIndex >= Level) or (Level = 7) then
    	memo1.Lines.Add('[' + FormatDateTime('hh:nn:ss', GetTime()) + '] ['+IntToStr(Level)+'] '+Text);
end;

procedure TForm1.GetScriptFlows();
var
	Key : string;
    L:TstringList;
begin

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

    //GetScriptSubFlows();
end;

procedure TForm1.GetScriptSubFlows();
begin
	//
end;

procedure TForm1.RSectionChange(Sender: TObject);
begin
	GetScriptSubFlows();
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
	Timer1.Enabled := false;
    Button1.OnClick(Button1);
end;

end.
