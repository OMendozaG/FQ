unit UfP;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox, FMX.Layouts, FMX.Memo, FMX.StdCtrls, UfQ, USAM,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, FMX.Edit, System.JSON;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Panel3: TPanel;
    RSection: TComboBox;
    RElement: TComboBox;
    Button2: TButton;
    SAM: TSAM;
    FQ: TFQ;
    Memo1: TMemo;
    id: TIdHTTP;
    Edit1: TEdit;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure RSectionChange(Sender: TObject);
    procedure FQLogEvent(const Text: string; const Level: Integer);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
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
    s:string;
begin

    Mem := TStringStream.Create('', TEncoding.UTF8);

    mem.Position := 0;
	id.Get('http://sam.lagsoft.net/fq/get.php?file=' + edit1.Text, mem);

    mem.Position := 0;

    s := mem.DataString;

   FQ.LoadScript(s);

    GetScriptFlows();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
	FQ.RunFlow();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
Timer1.Enabled := true;
end;

procedure TForm1.FQLogEvent(const Text: string; const Level: Integer);
begin
	memo1.Lines.Add('[' + FormatDateTime('hh:nn:ss', GetTime()) + '] ['+IntToStr(Level)+'] '+Text);
end;

procedure TForm1.GetScriptFlows();
var
    Enum:TJSONPairEnumerator;
begin

    RSection.Items.Clear;
   	RElement.Items.Clear;


	Enum := TJSONObject(fq.Script).GetEnumerator;

	while (Enum.MoveNext) do begin
        if (not SAM.Data.IsNumeric(Enum.Current.JSONString.Value)) then begin
        	if (Enum.Current.JSONString.Value = 'flow') or (Enum.Current.JSONString.Value = 'env') or (Enum.Current.JSONString.Value = 'anon') or (Enum.Current.JSONString.Value = 'obj') then continue;

        	RSection.Items.Add(Enum.Current.JSONString.Value);
        end;
    end;

end;

procedure TForm1.GetScriptSubFlows();
var
	PreSection,PreElement:string;
    Enum:TJSONPairEnumerator;
begin
	if (RSection.ItemIndex < 0) then exit;

   	RElement.Items.Clear;
	Enum := TJSONObject(fq.Script.GetValue(RSection.Items.Strings[RSection.ItemIndex])).GetEnumerator;

	while (Enum.MoveNext) do begin
        if (not SAM.Data.IsNumeric(Enum.Current.JSONString.Value)) then begin
        	if (Enum.Current.JSONString.Value = 'flow') or (Enum.Current.JSONString.Value = 'env') or (Enum.Current.JSONString.Value = 'anon') or (Enum.Current.JSONString.Value = 'obj') then continue;
        	RElement.Items.Add(Enum.Current.JSONString.Value);
        end;
    end;
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
