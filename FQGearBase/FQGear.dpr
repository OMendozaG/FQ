program FQGear;

uses
  Vcl.Forms,
  UfQGear in 'UfQGear.pas' {fP};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfP, fP);
  Application.Run;
end.
