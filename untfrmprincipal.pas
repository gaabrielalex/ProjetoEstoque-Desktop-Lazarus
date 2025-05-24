unit untFrmPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus;

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
    mnItemSaida: TMenuItem;
    mnItemEntrada: TMenuItem;
    mnItemProduto: TMenuItem;
    mnItemFornecedor: TMenuItem;
    mnItemTransportadora: TMenuItem;
    mnItemLoja: TMenuItem;
    mnItemCidade: TMenuItem;
    mnItemCategoria: TMenuItem;
    menuRelatorios: TMenuItem;
    menuSair: TMenuItem;
    menuMovimentacao: TMenuItem;
    menuPrincipal: TMainMenu;
    menuCadastro: TMenuItem;
    procedure mnItemEntradaClick(Sender: TObject);
    procedure mnItemFornecedorClick(Sender: TObject);
    procedure mnItemProdutoClick(Sender: TObject);
    procedure mnItemSaidaClick(Sender: TObject);
    procedure mnItemTransportadoraClick(Sender: TObject);
    procedure mnItemLojaClick(Sender: TObject);
    procedure menuSairClick(Sender: TObject);
    procedure mnItemCategoriaClick(Sender: TObject);
    procedure mnItemCidadeClick(Sender: TObject);
  private

  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses untFrmCadastroCategoria, untFrmCadastroCidade, untFrmCadastroLoja,
     untFrmCadastroTransportadora, untFrmCadastroFornecedor,
     untFrmCadastroProduto, untFrmCadastroEntrada, untFrmCadastroSaida;

{$R *.lfm}

{ TfrmPrincipal }

procedure TfrmPrincipal.menuSairClick(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmPrincipal.mnItemLojaClick(Sender: TObject);
begin
   try
     frmCadastroLoja := TfrmCadastroLoja.create(self);
     frmCadastroLoja.ShowModal();
   finally
     frmCadastroLoja.free;
   end;
end;

procedure TfrmPrincipal.mnItemCategoriaClick(Sender: TObject);
begin
  try
    frmCadastroCategoria := TfrmCadastroCategoria.create(self);
    frmCadastroCategoria.ShowModal();
  finally
     frmCadastroCategoria.free;
  end;

end;

procedure TfrmPrincipal.mnItemCidadeClick(Sender: TObject);
begin
  try
    frmCadastroCidade := TfrmCadastroCidade.create(self);
    frmCadastroCidade.ShowModal();
  finally
    frmCadastroCidade.free;
  end;

end;

procedure TfrmPrincipal.mnItemTransportadoraClick(Sender: TObject);
begin
  try
    frmCadastroTransportadora := TfrmCadastroTransportadora.create(self);
    frmCadastroTransportadora.ShowModal();
  finally
    frmCadastroTransportadora.free;
  end;
end;

procedure TfrmPrincipal.mnItemFornecedorClick(Sender: TObject);
begin
  try
      frmCadastroFornecedor := TfrmCadastroFornecedor.create(self);
      frmCadastroFornecedor.ShowModal();
  finally
      frmCadastroFornecedor.free;
  end;
end;

procedure TfrmPrincipal.mnItemProdutoClick(Sender: TObject);
begin
  try
      frmCadastroProduto := TfrmCadastroProduto.create(self);
      frmCadastroProduto.ShowModal();
  finally
      frmCadastroProduto.free;
  end;
end;

procedure TfrmPrincipal.mnItemEntradaClick(Sender: TObject);
begin
  try
      frmCadastroEntrada := TfrmCadastroEntrada.create(self);
      frmCadastroEntrada.ShowMOdal();
  finally
      frmCadastroEntrada.free;
  end;

end;

procedure TfrmPrincipal.mnItemSaidaClick(Sender: TObject);
begin
  try
      frmCadastroSaida := TfrmCadastroSaida.create(self);
      frmCadastroSaida.ShowMOdal();
  finally
      frmCadastroSaida.free;
  end;
end;

end.

