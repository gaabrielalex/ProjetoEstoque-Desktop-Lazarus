unit untFrmCadastroProduto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  DBGrids, ZDataset, ZSqlUpdate;

type

  { TfrmCadastroProduto }

  TfrmCadastroProduto = class(TForm)
    btnPesquisar: TButton;
    btnPesquisarCategoria: TButton;
    btnPesquisarFornecedor: TButton;
    dsProduto: TDataSource;
    DBCheckBox: TDBCheckBox;
    dbEdtDescricao: TDBEdit;
    dbEdtCategoria: TDBEdit;
    dbEdtFornecedor: TDBEdit;
    dbEdtQtdeMin: TDBEdit;
    dbEdtCodigo: TDBEdit;
    dbEdtCodigoCategoria: TDBEdit;
    dbEdtCodigoFornecedor: TDBEdit;
    dbEdtPeso: TDBEdit;
    DBGrid1: TDBGrid;
    DBNavigator2: TDBNavigator;
    edtDescricaoFiltro: TEdit;
    edtCodigoFiltro: TEdit;
    edtFornecedorFiltro: TEdit;
    edtCategoriaFiltro: TEdit;
    GroupBox1: TGroupBox;
    lblDescricao: TLabel;
    lblCategoria: TLabel;
    lblFornecedor: TLabel;
    lblQtdeMin: TLabel;
    lblPeso: TLabel;
    lblCategoriaFiltro: TLabel;
    lblFornecedorFiltro: TLabel;
    lblDescricaoFiltro: TLabel;
    lblCodigo: TLabel;
    lblCodigoCategoria: TLabel;
    lblCodigoFornecedor: TLabel;
    lblCodigoFiltro: TLabel;
    qryProduto: TZQuery;
    uqryProduto: TZUpdateSQL;
    procedure btnPesquisarCategoriaClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnPesquisarFornecedorClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmCadastroProduto: TfrmCadastroProduto;

implementation

uses untFrmCadastroCategoria, untFrmCadastroFornecedor;

{$R *.lfm}

{ TfrmCadastroProduto }

procedure TfrmCadastroProduto.btnPesquisarClick(Sender: TObject);
begin
    qryProduto.Active := false;
    qryProduto.SQL.Clear;
    qryProduto.SQL.add('select p.*, f.fornecedor, c.categoria');
    qryProduto.SQL.add('from produto p, fornecedor f, categoria c');
    qryProduto.SQL.add('where  p.fornecedor_codfornecedor = f.codfornecedor');
    qryProduto.SQL.add('and p.categoria_codcategoria = c.codcategoria');
    if edtDescricaoFiltro.text <> '' then
       begin
            qryProduto.SQL.add('and p.descricao like :descricao');
            qryProduto.ParamByName('descricao').AsString := '%' + edtDescricaoFiltro.text + '%' ;
       end;
    if edtCategoriaFiltro.text <> '' then
       begin
            qryProduto.SQL.add('and c.categoria like :nome_categoria');
            qryProduto.ParamByName('nome_categoria').AsString := '%' + edtCategoriaFiltro.text + '%' ;
       end;
    if edtFornecedorFiltro.text <> '' then
       begin
            qryProduto.SQL.add('and f.fornecedor like :nome_fornecedor');
            qryProduto.ParamByName('nome_fornecedor').AsString := '%' + edtFornecedorFiltro.text + '%' ;
       end;
    if edtCodigoFiltro.text <> '' then
       begin
            qryProduto.SQL.add('and p.codproduto = :codproduto');
            qryProduto.ParamByName('codproduto').AsInteger := StrToInt(edtCodigoFiltro.text);
       end;
    qryProduto.Active := true;

end;

procedure TfrmCadastroProduto.btnPesquisarCategoriaClick(Sender: TObject);
begin
  try
    frmCadastroCategoria := TfrmCadastroCategoria.create(self);
    frmCadastroCategoria.ShowModal();

    qryProduto.Edit; //Caso o usuário não tenha selecionado para editar
    qryProduto.FieldByName('categoria').AsString := frmCadastroCategoria.qryCategoria.FieldByName('categoria').AsString;
    qryProduto.FieldByName('categoria_codcategoria').AsInteger := frmCadastroCategoria.qryCategoria.FieldByName('codcategoria').AsInteger;
  finally
     frmCadastroCategoria.free;
  end;
end;

procedure TfrmCadastroProduto.btnPesquisarFornecedorClick(Sender: TObject);
begin
  try
      frmCadastroFornecedor := TfrmCadastroFornecedor.create(self);
      frmCadastroFornecedor.ShowModal();

      qryProduto.Edit; //Caso o usuário não tenha selecionado para editar
      qryProduto.FieldByName('fornecedor').AsString := frmCadastroFornecedor.qryFornecedor.FieldByName('fornecedor').AsString;
      qryProduto.FieldByName('fornecedor_codfornecedor').AsInteger := frmCadastroFornecedor.qryFornecedor.FieldByName('codfornecedor').AsInteger;
  finally
      frmCadastroFornecedor.free;
  end;
end;

procedure TfrmCadastroProduto.FormShow(Sender: TObject);
begin
  self.Width := 850;
  self.Height := 725;
  if qryProduto.Active = false then
     begin
          qryProduto.Active := true;
     end;
end;

end.

