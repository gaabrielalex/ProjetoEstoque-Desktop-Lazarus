program SistemaControleEstoque;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, anchordockpkg, datetimectrls, zcomponent, untFrmPrincipal,
  untDmConexao, untFrmCadastroCategoria, untFrmCadastroCidade,
  untFrmCadastroLoja, untFrmCadastroTransportadora, untFrmCadastroFornecedor,
  untFrmCadastroProduto, untFrmCadastroEntrada, untFrmCadastroSaida
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.Run;
end.

