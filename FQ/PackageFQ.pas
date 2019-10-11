unit PackageFQ;

interface

uses
  System.SysUtils, System.Classes;

type
  TFQ = class(TComponent)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('LST', [TFQ]);
end;

end.
