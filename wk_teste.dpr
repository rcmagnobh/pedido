program wk_teste;

uses
  Vcl.Forms,
  uPedido in 'uPedido.pas' {FrmPedido},
  udm in 'udm.pas' {dm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPedido, FrmPedido);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
