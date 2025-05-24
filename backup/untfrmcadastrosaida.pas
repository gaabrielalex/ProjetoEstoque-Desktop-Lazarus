unit untFrmCadastroSaida;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  DBGrids, ZDataset, ZSqlUpdate, AnchorDockPanel;

type

  { TfrmCadastroSaida }

  TfrmCadastroSaida = class(TForm)
    AnchorDockPanel1: TAnchorDockPanel;
    btnPesquisarItem: TButton;
    btnPesquisarProduto: TButton;
    btnPesquisarSaida: TButton;
    btnPesquisarTransportadora: TButton;
    btnPesquisarLoja: TButton;
    dsItemSaida: TDataSource;
    dbEdtCodigo: TDBEdit;
    dbEdtCodigoProduto: TDBEdit;
    dbEdtCodigoSaida: TDBEdit;
    dbEdtCodigoTransportadora: TDBEdit;
    dbEdtCodigoLoja: TDBEdit;
    dbEdtLote: TDBEdit;
    dbEdtProduto: TDBEdit;
    dbEdtQtde: TDBEdit;
    dbEdtTransportadora: TDBEdit;
    dbEdtLoja: TDBEdit;
    dbEdtValor: TDBEdit;
    dbEdtValorFrete: TDBEdit;
    dbEdtValorImposto: TDBEdit;
    dbEdtValorTotal: TDBEdit;
    dbGrdItem: TDBGrid;
    dbGrdSaida: TDBGrid;
    dbNvItem: TDBNavigator;
    dbNvSaida: TDBNavigator;
    dsSaida: TDataSource;
    edtCodigoItem: TEdit;
    edtCodigoSaida: TEdit;
    edtProduto: TEdit;
    edtTransportadora: TEdit;
    edtLoja: TEdit;
    grpBxItem: TGroupBox;
    grpBxSaida: TGroupBox;
    lblCodigoItem: TLabel;
    lblCodigoItemFiltro: TLabel;
    lblCodigoProduto: TLabel;
    lblCodigoSaida: TLabel;
    lblCodigoSaidaFiltro: TLabel;
    lblCodigoTransportadora: TLabel;
    lblCodigoLoja: TLabel;
    lblLote: TLabel;
    lblProduto: TLabel;
    lblProdutoFiltro: TLabel;
    lblQtde: TLabel;
    lblTituloSaida: TLabel;
    lblTituloItem: TLabel;
    lblTransportadora: TLabel;
    lblLoja: TLabel;
    lblTransportadoraFiltro: TLabel;
    lblLojaFiltro: TLabel;
    lblValorFrete: TLabel;
    lblValorImposto: TLabel;
    lblValorItem: TLabel;
    lblValorTotalSaida: TLabel;
    qrySaida: TZQuery;
    uqrySaida: TZUpdateSQL;
    qryItemSaida: TZQuery;
    uqryItemSaida: TZUpdateSQL;
    procedure btnPesquisarItemClick(Sender: TObject);
    procedure btnPesquisarLojaClick(Sender: TObject);
    procedure btnPesquisarProdutoClick(Sender: TObject);
    procedure btnPesquisarSaidaClick(Sender: TObject);
    procedure btnPesquisarTransportadoraClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CarregarItensSaida(DataSet: TDataSet);
  private

  public

  end;

var
  frmCadastroSaida: TfrmCadastroSaida;

implementation

uses untFrmCadastroTransportadora, untFrmCadastroLoja, untFrmCadastroProduto;

{$R *.lfm}

{ TfrmCadastroSaida }


//CÓDIGOS DA PARTE "SAÍDA"
procedure TfrmCadastroSaida.btnPesquisarSaidaClick(Sender: TObject);
begin
  qrySaida.Close;
  qrySaida.SQL.Clear;
  qrySaida.SQL.add('select s.*, t.transportadora, l.nome ');
  qrySaida.SQL.add('from saida s, transportadora t, loja l');
  qrySaida.SQL.add('where s.transportadora_codtransportadora = t.codtransportadora ');
  qrySaida.SQL.add('and s.loja_codloja = l.codloja');

  if edtCodigoSaida.text <> '' then
    begin
        qrySaida.SQL.add('and s.codsaida = :codsaida');
        qrySaida.ParamByName('codsaida').AsInteger := StrToInt(edtCodigoSaida.text);
    end;
  if edtLoja.text <> '' then
    begin
        qrySaida.SQL.add('and l.nome like :nome_loja');
        qrySaida.ParamByName('nome_loja').AsString := '%' + edtLoja.text + '%';
    end;
  if edtTransportadora.text <> '' then
    begin
        qrySaida.SQL.add('and t.transportadora like :transportadora');
        qrySaida.ParamByName('transportadora').AsString := '%' + edtTransportadora.text + '%';
    end;

   qrySaida.Open;
end;

procedure TfrmCadastroSaida.btnPesquisarTransportadoraClick(Sender: TObject);
begin
  try
      frmCadastroTransportadora := TfrmCadastroTransportadora.create(self);
      frmCadastroTransportadora.ShowModal();

      qrySaida.Edit; //Caso o usuário não tenha selecionado para editar
      qrySaida.FieldByName('transportadora').AsString := frmCadastroTransportadora.qryTransportadora.FieldByName('transportadora').AsString;
      qrySaida.FieldByName('transportadora_codtransportadora').AsInteger := frmCadastroTransportadora.qryTransportadora.FieldByName('codtransportadora').AsInteger;
  finally
      frmCadastroTransportadora.free;
  end;
end;

procedure TfrmCadastroSaida.btnPesquisarLojaClick(Sender: TObject);
begin
  try
     frmCadastroLoja := TfrmCadastroLoja.create(self);
     frmCadastroLoja.ShowModal();

     qrySaida.Edit; //Caso o usuário não tenha selecionado para editar
     qrySaida.FieldByName('nome').AsString := frmCadastroLoja.qryLoja.FieldByName('nome').AsString;
     qrySaida.FieldByName('loja_codloja').AsInteger := frmCadastroLoja.qryLoja.FieldByName('codloja').AsInteger;
   finally
     frmCadastroLoja.free;
   end;
end;


//CÓDIGOS DA PARTE "ITEM DE ENTRADA"
procedure TfrmCadastroSaida.btnPesquisarItemClick(Sender: TObject);
begin
  qryItemSaida.Close;
  qryItemSaida.SQL.Clear;
  qryItemSaida.SQL.add('select i.*, p.descricao');
  qryItemSaida.SQL.add('from itemsaida i, produto p');
  qryItemSaida.SQL.add('where i.produto_codproduto = p.codproduto');
  qryItemSaida.SQL.add('and i.saida_codsaida = :codsaida');

  if edtCodigoItem.text <> '' then
    begin
        qryItemSaida.SQL.add('and i.coditemsaida = :coditemsaida');
        qryItemSaida.ParamByName('coditemsaida').AsInteger := StrToInt(edtCodigoItem.text);
    end;
  if edtProduto.text <> '' then
    begin
        qryItemSaida.SQL.add('and p.descricao like :descricaoproduto');
        qryItemSaida.ParamByName('descricaoproduto').AsString := '%' + edtProduto.text + '%';
    end;

  if qrySaida.Active then
   begin
        qryItemSaida.ParamByName('codsaida').AsInteger := qrySaida.FieldByName('codsaida').AsInteger;
        qryItemSaida.Open;
   end;
end;

procedure TfrmCadastroSaida.btnPesquisarProdutoClick(Sender: TObject);
begin
  try
      frmCadastroProduto := TfrmCadastroProduto.create(self);
      frmCadastroProduto.ShowModal();

      qryItemSaida.Edit; //Caso o usuário não tenha selecionado para editar
      qryItemSaida.FieldByName('descricao').AsString := frmCadastroProduto.qryProduto.FieldByName('descricao').AsString;
      qryItemSaida.FieldByName('produto_codproduto').AsInteger := frmCadastroProduto.qryProduto.FieldByName('codproduto').AsInteger;
  finally
      frmCadastroProduto.free;
  end;
end;


//----------
procedure TfrmCadastroSaida.FormShow(Sender: TObject);
begin
  self.Width := 1600;
  self.Height := 780;

  qrySaida.Open;
  qryItemSaida.Open;
end;


//CÓDIGOS DAS QUERYS
{*Procedure usada nos eventos AfterScroll e AfterRefresh do qrySaida*}
procedure TfrmCadastroSaida.CarregarItensSaida(DataSet: TDataSet);
begin
   if qrySaida.Active then
    begin
         qryItemSaida.Close;
         qryItemSaida.ParamByName('codsaida').AsInteger := qrySaida.FieldByName('codsaida').AsInteger;
         qryItemSaida.Open;
    end;
end;

end.

