unit udm;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  IBX.IBCustomDataSet, IBX.IBQuery, IBX.IBDatabase, FireDAC.UI.Intf,
  FireDAC.VCLUI.Error, FireDAC.Stan.Error, FireDAC.Phys.MySQLDef,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.VCLUI.Wait;

type
  Tdm = class(TDataModule)
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    QryCliente1: TIBQuery;
    QryCliente1CODIGO_CLIENTE: TIntegerField;
    QryCliente1NOME: TIBStringField;
    QryCliente1CIDADE: TIBStringField;
    QryCliente1UF: TIBStringField;
    QryProduto1: TIBQuery;
    QryProduto1CODIGO_PRODUTO: TIntegerField;
    QryProduto1DESCRICAO: TIBStringField;
    QryProduto1PRECO_VENDA: TIBBCDField;
    dsProduto: TDataSource;
    cds_Pedido_Item: TClientDataSet;
    cds_Pedido_ItemPEDIDO_ITEM: TIntegerField;
    cds_Pedido_ItemNUMERO_PEDIDO: TIntegerField;
    cds_Pedido_ItemCODIGO_PRODUTO: TIntegerField;
    cds_Pedido_ItemPROD: TStringField;
    cds_Pedido_ItemQUANTIDADE: TIntegerField;
    cds_Pedido_ItemVLR_UNITARIO: TCurrencyField;
    cds_Pedido_ItemVLR_TOTAL: TCurrencyField;
    cds_Pedido_ItemTOTAL_GERAL: TAggregateField;
    dsItemPedido: TDataSource;
    dsPedido: TDataSource;
    cdsPedido: TClientDataSet;
    cdsPedidoNUMERO_PEDIDO: TIntegerField;
    cdsPedidoDATA_EMISSAO: TDateField;
    cdsPedidoCODIGO_CLIENTE: TIntegerField;
    cdsPedidoVALOR_TOTAL: TCurrencyField;
    QryPedido1: TIBQuery;
    QryPedido1NUMERO_PEDIDO: TIntegerField;
    QryPedido1DATA_EMISSAO: TDateField;
    QryPedido1CODIGO_CLIENTE: TIntegerField;
    QryPedido1VALOR_TOTAL: TIBBCDField;
    QryPedido1PEDIDO_ITEM: TIntegerField;
    QryPedido1CODIGO_PRODUTO: TIntegerField;
    QryPedido1QUANTIDADE: TIntegerField;
    QryPedido1VLR_UNITARIO: TIBBCDField;
    QryPedido1VLR_TOTAL: TIBBCDField;
    QryPedido1NOME: TIBStringField;
    QryPedido1CIDADE: TIBStringField;
    QryPedido1UF: TIBStringField;
    QryPedido1DESCRICAO: TIBStringField;
    QryPedido1PRECO_VENDA: TIBBCDField;
    QryAux1: TIBQuery;
    FDTransaction1: TFDTransaction;
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDConnection2: TFDConnection;
    QryCliente: TFDQuery;
    QryPedido: TFDQuery;
    QryAux: TFDQuery;
    QryProduto: TFDQuery;
    QryClienteCODIGO_CLIENTE: TIntegerField;
    QryClienteNOME: TStringField;
    QryClienteCIDADE: TStringField;
    QryClienteUF: TStringField;
    QryProdutoCODIGO_PRODUTO: TFDAutoIncField;
    QryProdutoDESCRICAO: TStringField;
    QryProdutoPRECO_VENDA: TBCDField;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    QryInsereItemPedido: TFDQuery;
    FDUpdateSQL1: TFDUpdateSQL;
    FDCommand1: TFDCommand;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
