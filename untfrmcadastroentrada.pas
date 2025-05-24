unit untFrmCadastroEntrada;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBGrids, DBCtrls, ZDataset, ZSqlUpdate, AnchorDockPanel, DBDateTimePicker,
  DateTimePicker;

type

  { TfrmCadastroEntrada }

  TfrmCadastroEntrada = class(TForm)
    AnchorDockPanel1: TAnchorDockPanel;
    btnLimparDataEntrada: TButton;
    btnPesquisarEntrada: TButton;
    btnPesquisarItem: TButton;
    btnPesquisarProduto: TButton;
    btnPesquisarTransportadora: TButton;
    btnLimparDataPedido: TButton;
    dbGrdItem: TDBGrid;
    dsEntrada: TDataSource;
    dsItemEntrada: TDataSource;
    dtTmDtPedido: TDateTimePicker;
    dtTmDtEntrada: TDateTimePicker;
    dbDtTmDtPedido: TDBDateTimePicker;
    dbDtTmDtEntrada: TDBDateTimePicker;
    dbEdtCodigoEntrada: TDBEdit;
    dbEdtCodigoTransportadora: TDBEdit;
    dbEdtNumNF: TDBEdit;
    dbEdtValorTotalEntrada: TDBEdit;
    dbEdtValorFrete: TDBEdit;
    dbEdtValorImposto: TDBEdit;
    dbEdtProduto: TDBEdit;
    dbEdtCodigo: TDBEdit;
    dbEdtCodigoProduto: TDBEdit;
    dbEdtLote: TDBEdit;
    dbEdtTransportadora: TDBEdit;
    dbEdtValor: TDBEdit;
    dbEdtQtde: TDBEdit;
    dbGrdEntrada: TDBGrid;
    dbNvItem: TDBNavigator;
    dbNvEntrada: TDBNavigator;
    edtCodigoItem: TEdit;
    edtProduto: TEdit;
    edtCodigoEntrada: TEdit;
    edtNumNF: TEdit;
    edtTransportadora: TEdit;
    grpBxItem: TGroupBox;
    grpBxEntrada: TGroupBox;
    lblCodigoEntradaFiltro: TLabel;
    lblCodigoItemFiltro: TLabel;
    lblDtEntradaFiltro: TLabel;
    lblDtPedido: TLabel;
    lblDtEntrada: TLabel;
    lblCodigoEntrada: TLabel;
    lblCodigoTransportadora: TLabel;
    lblDtPedidoFiltro: TLabel;
    lblLote: TLabel;
    lblNumNF: TLabel;
    lblNumNFFiltro: TLabel;
    lblProduto: TLabel;
    lblCodigoItem: TLabel;
    lblCodigoProduto: TLabel;
    lblProdutoFiltro: TLabel;
    lblTransportadora: TLabel;
    lblTransportadoraFiltro: TLabel;
    lblValorTotalEntrada: TLabel;
    lblValorFrete: TLabel;
    lblValorImposto: TLabel;
    lblValorItem: TLabel;
    lblQtde: TLabel;
    lblTituloItem: TLabel;
    lblTituloEntrada: TLabel;
    qryEntrada: TZQuery;
    qryItemEntrada: TZQuery;
    uqryEntrada: TZUpdateSQL;
    uqryItemEntrada: TZUpdateSQL;
    procedure btnLimparDataEntradaClick(Sender: TObject);
    procedure btnLimparDataPedidoClick(Sender: TObject);
    procedure btnPesquisarEntradaClick(Sender: TObject);
    procedure btnPesquisarItemClick(Sender: TObject);
    procedure btnPesquisarProdutoClick(Sender: TObject);
    procedure btnPesquisarTransportadoraClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CarregarItensEntrada(DataSet: TDataSet);
  private

  public

  end;

var
  frmCadastroEntrada: TfrmCadastroEntrada;

implementation

uses untFrmCadastroTransportadora, untFrmCadastroProduto;

{$R *.lfm}

{ TfrmCadastroEntrada }

//CÓDIGOS DA PARTE "ENTRADA"
procedure TfrmCadastroEntrada.btnPesquisarEntradaClick(Sender: TObject);
begin
  qryEntrada.Close;
  qryEntrada.SQL.Clear;
  qryEntrada.SQL.add('select e.*, t.transportadora ');
  qryEntrada.SQL.add('from entrada e, transportadora t');
  qryEntrada.SQL.add('where e.transportadora_codtransportadora = t.codtransportadora');
  if edtCodigoEntrada.text <> '' then
    begin
        qryEntrada.SQL.add('and e.codentrada = :codentrada');
        qryEntrada.ParamByName('codentrada').AsInteger := StrToInt(edtCodigoEntrada.text);
    end;
  if edtNumNF.text <> '' then
    begin
        qryEntrada.SQL.add('and e.numnf = :numnf');
        qryEntrada.ParamByName('numnf').AsInteger := StrToInt(edtNumNF.text);
    end;
  if edtTransportadora.text <> '' then
    begin
        qryEntrada.SQL.add('and t.transportadora like :transportadora');
        qryEntrada.ParamByName('transportadora').AsString := '%' + edtTransportadora.text + '%';
    end;
  if (not IsNullDate(dtTmDtPedido.date))then
    begin
         qryEntrada.SQL.add('and e.dataped = :dataped');
         qryEntrada.ParamByName('dataped').AsDate := dtTmDtPedido.date;
    end;
  if (not IsNullDate(dtTmDtEntrada.date))then
    begin
         qryEntrada.SQL.add('and e.dataentr = :dataentr');
         qryEntrada.ParamByName('dataentr').AsDate := dtTmDtEntrada.date;
    end;

    qryEntrada.Open;
end;

procedure TfrmCadastroEntrada.btnLimparDataPedidoClick(Sender: TObject);
begin
  dtTmDtPedido.date := NullDate;
end;

procedure TfrmCadastroEntrada.btnLimparDataEntradaClick(Sender: TObject);
begin
   dtTmDtEntrada.date := NullDate;
end;

procedure TfrmCadastroEntrada.btnPesquisarTransportadoraClick(Sender: TObject);
begin
  try
      frmCadastroTransportadora := TfrmCadastroTransportadora.create(self);
      frmCadastroTransportadora.ShowModal();

      qryEntrada.Edit; //Caso o usuário não tenha selecionado para editar
      qryEntrada.FieldByName('transportadora').AsString := frmCadastroTransportadora.qryTransportadora.FieldByName('transportadora').AsString;
      qryEntrada.FieldByName('transportadora_codtransportadora').AsInteger := frmCadastroTransportadora.qryTransportadora.FieldByName('codtransportadora').AsInteger;
  finally
      frmCadastroTransportadora.free;
  end;

end;


//CÓDIGOS DA PARTE "ITEM DE ENTRADA"
procedure TfrmCadastroEntrada.btnPesquisarItemClick(Sender: TObject);
begin
  qryItemEntrada.Close;
  qryItemEntrada.SQL.Clear;
  qryItemEntrada.SQL.add('select i.*, p.descricao');
  qryItemEntrada.SQL.add('from itementrada i, produto p ');
  qryItemEntrada.SQL.add('where i.produto_codproduto = p.codproduto');
  qryItemEntrada.SQL.add('and entrada_codentrada = :codentrada ');

  if edtCodigoItem.text <> '' then
    begin
        qryItemEntrada.SQL.add('and i.coditementrada = :coditementrada');
        qryItemEntrada.ParamByName('coditementrada').AsInteger := StrToInt(edtCodigoItem.text);
    end;
  if edtProduto.text <> '' then
    begin
        qryItemEntrada.SQL.add('and p.descricao like :descricaoproduto');
        qryItemEntrada.ParamByName('descricaoproduto').AsString := '%' + edtProduto.text + '%';
    end;

  if qryEntrada.Active then
    begin
         qryItemEntrada.ParamByName('codentrada').AsInteger := qryEntrada.FieldByName('codentrada').AsInteger;
         qryItemEntrada.Open;
    end;
end;

procedure TfrmCadastroEntrada.btnPesquisarProdutoClick(Sender: TObject);
begin
  try
      frmCadastroProduto := TfrmCadastroProduto.create(self);
      frmCadastroProduto.ShowModal();

      qryItemEntrada.Edit; //Caso o usuário não tenha selecionado para editar
      qryItemEntrada.FieldByName('descricao').AsString := frmCadastroProduto.qryProduto.FieldByName('descricao').AsString;
      qryItemEntrada.FieldByName('produto_codproduto').AsInteger := frmCadastroProduto.qryProduto.FieldByName('codproduto').AsInteger;
  finally
      frmCadastroProduto.free;
  end;
end;


//----------
procedure TfrmCadastroEntrada.FormShow(Sender: TObject);
begin
  self.Width := 1600;
  self.Height := 780;

  qryEntrada.open;
  qryItemEntrada.open;
end;


//CÓDIGOS DAS QUERYS
{*Procedure usada nos eventos AfterScroll e AfterRefresh do qryEntrada*}
procedure TfrmCadastroEntrada.CarregarItensEntrada(DataSet: TDataSet);
begin
   if qryEntrada.Active then
    begin
         qryItemEntrada.Close;
         qryItemEntrada.ParamByName('codentrada').AsInteger := qryEntrada.FieldByName('codentrada').AsInteger;
         qryItemEntrada.Open;
    end;
end;

end.

