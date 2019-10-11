program MFQGear;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  UMfQGear in 'UMfQGear.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
