unit uPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  IBX.IBCustomDataSet, IBX.IBQuery, IBX.IBDatabase, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ExtCtrls;

type
  TFrmPedido = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EdtCliente: TEdit;
    Panel2: TPanel;
    bt_cadastrarpedido: TSpeedButton;
    pnlItemPedido: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    EdtProduto: TEdit;
    DBGrid1: TDBGrid;
    SpeedButton1: TSpeedButton;
    bt_salvaritem: TSpeedButton;
    btnsalvapedido: TSpeedButton;
    btcadastraitem: TSpeedButton;
    dbCodCliente: TEdit;
    Label4: TLabel;
    dbData: TMaskEdit;
    dbCodProduto: TEdit;
    dbQtde: TEdit;
    dbVlrTotal: TEdit;
    dbVlrUnitario: TEdit;
    bt_cancelar: TSpeedButton;
    EdtPedido: TEdit;
    edtTotalPedido: TEdit;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bt_salvaritemClick(Sender: TObject);
    procedure dbCodProdutoExit(Sender: TObject);
    procedure dbCodClienteExit(Sender: TObject);
    procedure bt_cadastrarpedidoClick(Sender: TObject);
    procedure btcadastraitemClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbVlrUnitarioExit(Sender: TObject);
    procedure bt_cancelarClick(Sender: TObject);
    procedure EdtPedidoExit(Sender: TObject);
    procedure btnsalvapedidoClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    GravaPedidos : Boolean;
    AchouPedido : Boolean;
    Procedure LimpaComponentes;
    procedure CadastraPedidosBanco;
    procedure cadastrapedido;
    procedure atualizapedido;
    procedure buscaitempedido;
    procedure carregatabelas;

  public
    { Public declarations }
  end;

var
  FrmPedido: TFrmPedido;

implementation

uses
  udm;

{$R *.dfm}

procedure TFrmPedido.bt_cadastrarpedidoClick(Sender: TObject);
begin
   dbData.Enabled := True;
   dbCodCliente.Enabled := True ;
   dbData.Text := DateToStr(Date);
   dbData.SetFocus;
   LimpaComponentes;
   dm.cds_Pedido_Item.Close;
   dm.cds_Pedido_Item.CreateDataSet;
   edtTotalPedido.Text := FormatFloat('###,##0.00',0);
   pnlItemPedido.Enabled := False;
end;

procedure TFrmPedido.bt_cancelarClick(Sender: TObject);
begin
  dm.cds_Pedido_Item.Cancel;

  dbCodProduto.Clear;
  EdtProduto.Clear;
  dbQtde.Clear;
  dbVlrUnitario.Clear;
  dbVlrTotal.Clear;

  dbCodProduto.Enabled := True;
  dbQtde.Enabled := True;
  dbVlrUnitario.Enabled := True;

  GravaPedidos := False;

  btcadastraitem.Enabled := True;
end;

procedure TFrmPedido.bt_salvaritemClick(Sender: TObject);
var iitem : Integer;
    dValorTotal : Real;
begin
  if EdtProduto.Text = '' then
  begin
    ShowMessage('Deverá ser informado um produto');
    Abort;
  end;

  if dbVlrUnitario.Text = '' then
  begin
    ShowMessage('Deverá ser informado um produto');
    Abort;
  end;

  try
    dm.cds_Pedido_Item.FieldByName('NUMERO_PEDIDO').AsInteger  := 0;
    dm.cds_Pedido_Item.FieldByName('CODIGO_PRODUTO').AsInteger := StrToInt(dbCodProduto.Text);
    dm.cds_Pedido_Item.FieldByName('QUANTIDADE').AsFloat       := StrToFloat(dbQtde.Text);
    dm.cds_Pedido_Item.FieldByName('VLR_UNITARIO').AsFloat     := StrToFloat(dbVlrUnitario.Text);
    dm.cds_Pedido_Item.FieldByName('VLR_TOTAL').AsFloat        := StrToFloat(dbQtde.Text) * StrToFloat(dbVlrUnitario.Text);//StrToFloat(dbVlrTotal.Text);
    dm.cds_Pedido_Item.Post;
  except
   on e : exception do
   begin
     ShowMessage('Erro ao Gravar'+ e.message);
   end;
  end;

  iitem := 0;
  dm.cds_Pedido_Item.DisableControls;
  dm.cds_Pedido_Item.First;

  if dm.cds_Pedido_Item.ReCordCount = 0 then
     iitem := 1
  else
  begin
    while not dm.cds_Pedido_Item.eof do
    begin
      iitem := iitem + 1;
      dValorTotal := dValorTotal + dm.cds_Pedido_Item.FieldByName('VLR_TOTAL').AsFloat;
      dm.cds_Pedido_Item.Next;
    end;
  end;

  dm.cds_Pedido_Item.First;
  dm.cds_Pedido_Item.EnableControls;


//  dm.cdsPedido.Edit;
//  dm.cdsPedidoVALOR_TOTAL.AsFloat := dValorTotal;
//  dm.cdsPedido.Post;

  edtTotalPedido.Text := FormatFloat('###,##0.00',dValorTotal);

  dbCodProduto.Clear;
  EdtProduto.Clear;
  dbQtde.Clear;
  dbVlrUnitario.Clear;
  dbVlrTotal.Clear;

  dbCodProduto.Enabled := True;
  dbQtde.Enabled := True;
  dbVlrUnitario.Enabled := True;

  GravaPedidos := False;

  btcadastraitem.Enabled := True;

  DBGrid1.SetFocus;


end;

procedure TFrmPedido.cadastrapedido;
begin
  dm.cdsPedido.Insert;
  dm.cdsPedidoDATA_EMISSAO.Value   := StrToDate(dbData.Text);
  dm.cdsPedidoCODIGO_CLIENTE.Value := StrToInt(dbCodCliente.Text);
  dm.cdsPedido.Post;
end;

procedure TFrmPedido.atualizapedido;
begin
  dm.cdsPedido.Edit;
  dm.cdsPedidoDATA_EMISSAO.Value   := StrToDate(dbData.Text);
  dm.cdsPedidoCODIGO_CLIENTE.Value := StrToInt(dbCodCliente.Text);
  dm.cdsPedido.Post;
end;

procedure TFrmPedido.dbCodClienteExit(Sender: TObject);
begin
  if dm.QryCliente.Active = false then
    dm.QryCliente.Active := True;


  if dbCodCliente.Text = '' then
  begin
    ShowMessage('Favor informar um Cliente');
    pnlItemPedido.Enabled := False;
    Abort;
  end;

  if not dm.QryCliente.Locate('CODIGO_CLIENTE', dbCodCliente.Text, [loCaseInsensitive, loPartialKey]) then
  begin
    ShowMessage('Cliente não encontrado');
    pnlItemPedido.Enabled := False;
    Abort;
  end
  else
  begin
    EdtCliente.Text := dm.QryCliente.FieldByName('NOME').AsString;
    pnlItemPedido.Enabled := True;

    if EdtPedido.Text = '' then
    begin
      cadastrapedido;
    end
    else
    begin
      atualizapedido;
    end;

  end;
end;

procedure TFrmPedido.dbCodProdutoExit(Sender: TObject);
begin
  if dm.QryProduto.Active = false then
    dm.QryProduto.Active := True;

  if dbCodProduto.Text = '' then
  Exit;

  if not dm.QryProduto.Locate('CODIGO_PRODUTO', dbCodProduto.Text, [loCaseInsensitive, loPartialKey]) then
  begin
    ShowMessage('Produto não encontrado');
    Abort;
  end
  else
  begin
    EdtProduto.Text := dm.QryProduto.FieldByName('DESCRICAO').AsString;
    dbVlrUnitario.Text := FormatFloat('###,##0.00',dm.QryProduto.FieldByName('PRECO_VENDA').AsFloat);
    btcadastraitem.Enabled := False;
  end;
end;

procedure TFrmPedido.DBGrid1DblClick(Sender: TObject);
begin
  dbCodProduto.Text   := dm.cds_Pedido_Item.FieldByName('CODIGO_PRODUTO').AsString;
  dbQtde.Text         := dm.cds_Pedido_Item.FieldByName('QUANTIDADE').AsString;
  dbVlrUnitario.Text  := FormatFloat('###,##0.00',dm.cds_Pedido_Item.FieldByName('VLR_UNITARIO').AsFloat);
  dbVlrTotal.Text     := FormatFloat('###,##0.00',dm.cds_Pedido_Item.FieldByName('VLR_TOTAL').AsFloat);

  dbCodProdutoExit(Sender);
end;

procedure TFrmPedido.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DELETE) then
  begin
    Key := 0;
    if MessageDlg('tem certeza que deseja excluir a informacao?',mtConfirmation,[mbYes,mbNo],0)= mrYes then
    begin
      dm.cds_Pedido_Item.Delete;
      ShowMessage('Registro deletado com sucesso');
    end;
  end;
end;

procedure TFrmPedido.dbVlrUnitarioExit(Sender: TObject);
begin
  if dbQtde.Text <> '' then
  begin
    dbVlrTotal.Text :=  FormatFloat('###,##0.00',StrToFloat(dbQtde.Text) * StrToFloat(dbVlrUnitario.Text));
  end;
end;

procedure TFrmPedido.EdtPedidoExit(Sender: TObject);
begin
  if EdtPedido.Text = '' then
  Exit;

  AchouPedido := False;

  dm.QryPedido.Close;
  dm.QryPedido.SQL.Clear;
  dm.QryPedido.SQL.Text := 'select * '+
                           'from cliente '+
                           '   inner join pedido on (cliente.codigo_cliente = pedido.codigo_cliente) '+
                           '   inner join pedido_item on (pedido.numero_pedido = pedido_item.numero_pedido) '+
                           '   inner join produto on (pedido_item.codigo_produto = produto.codigo_produto) '+
                           'where pedido.numero_pedido='+QuotedStr(EdtPedido.Text);
  dm.QryPedido.Open;

  if dm.QryPedido.RecordCount = 0 then
  begin
    ShowMessage('Pedido não encontrado');
    pnlItemPedido.Enabled := False;
    AchouPedido := True;
    Abort;
  end
  else
  begin
    dm.cdsPedido.Cancel;

    EdtPedido.Text    := dm.QryPedido.FieldByName('NUMERO_PEDIDO').AsString;
    dbData.Text       := dm.QryPedido.FieldByName('DATA_EMISSAO').AsString;
    dbCodCliente.Text := dm.QryPedido.FieldByName('CODIGO_CLIENTE').AsString;
    //dbCodClienteExit(Sender);

    if not dm.QryCliente.Locate('CODIGO_CLIENTE', dbCodCliente.Text, [loCaseInsensitive, loPartialKey]) then
    begin
      ShowMessage('Cliente não encontrado');
      pnlItemPedido.Enabled := False;
      Abort;
    end
    else
    begin
      EdtCliente.Text := dm.QryCliente.FieldByName('NOME').AsString;
      pnlItemPedido.Enabled := True;
    end;


    buscaitempedido;

    pnlItemPedido.Enabled := True;
    AchouPedido := False;
  end;
end;

procedure TFrmPedido.buscaitempedido;
var TotalPedido : Double;
begin
    TotalPedido := 0;

    dm.cds_Pedido_Item.Close;
    dm.cds_Pedido_Item.CreateDataSet;

    dm.QryPedido.First;

    while not dm.QryPedido.eof do
    begin
      dm.cds_Pedido_Item.Insert;
      dm.cds_Pedido_ItemPEDIDO_ITEM.AsString    := dm.QryPedido.FieldByName('ID_ITEM').AsString;
      dm.cds_Pedido_ItemNUMERO_PEDIDO.AsString  := dm.QryPedido.FieldByName('NUMERO_PEDIDO').AsString;
      dm.cds_Pedido_ItemCODIGO_PRODUTO.AsString := dm.QryPedido.FieldByName('CODIGO_PRODUTO').AsString;
      dm.cds_Pedido_ItemPROD.AsString           := dm.QryPedido.FieldByName('DESCRICAO').AsString;
      dm.cds_Pedido_ItemQUANTIDADE.AsString     := dm.QryPedido.FieldByName('QUANTIDADE').AsString;
      dm.cds_Pedido_ItemVLR_UNITARIO.AsString   := dm.QryPedido.FieldByName('VLR_UNITARIO').AsString;
      dm.cds_Pedido_ItemVLR_TOTAL.AsString      := dm.QryPedido.FieldByName('VLR_TOTAL').AsString;
      dm.cds_Pedido_Item.Post;
      TotalPedido := TotalPedido + dm.QryPedido.FieldByName('VLR_TOTAL').Value;
      dm.QryPedido.Next;
    end;
    edtTotalPedido.Text := FormatFloat('###,##0.00',TotalPedido);
end;


procedure TFrmPedido.Button1Click(Sender: TObject);
begin
  if EdtPedido.Text = '' then
  Exit;


  dm.QryAux.Close;
  dm.QryAux.SQL.Clear;
  dm.QryAux.SQL.Add('delete from PEDIDO where NUMERO_PEDIDO ='+QuotedStr(EdtPedido.Text));
  dm.QryAux.ExecSQL;
  dm.IBTransaction1.Commit;

  dm.QryAux.Close;
  dm.QryAux.SQL.Clear;
  dm.QryAux.SQL.Add('delete from PEDIDO_ITEM where NUMERO_PEDIDO ='+QuotedStr(EdtPedido.Text));
  dm.QryAux.ExecSQL;
  dm.IBTransaction1.Commit;

  dbData.Enabled := True;
  dbCodCliente.Enabled := True ;
  dbData.Text := DateToStr(Date);
  dbData.SetFocus;
  LimpaComponentes;
  dm.cds_Pedido_Item.Close;
  dm.cds_Pedido_Item.CreateDataSet;
  edtTotalPedido.Text := FormatFloat('###,##0.00',0);
  pnlItemPedido.Enabled := False;

  carregatabelas;

end;

procedure TFrmPedido.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    keybd_event(vk_tab, 0, 0, 0)
  else
    if (Key = VK_ESCAPE) then
      Close;
end;

procedure TFrmPedido.FormShow(Sender: TObject);
begin
  DBGrid1.SetFocus;

  carregatabelas;

  dbData.Enabled := False;
  dbCodCliente.Enabled := False;

  pnlItemPedido.Enabled := False;

end;

procedure TFrmPedido.carregatabelas;
begin
  dm.cdsPedido.Close;
  dm.cds_Pedido_Item.Close;

  dm.cdsPedido.CreateDataSet;
  dm.cds_Pedido_Item.CreateDataSet;

  dm.QryProduto.Close;
  dm.QryProduto.Open;

  dm.QryCliente.Close;
  dm.QryCliente.Open;

  dm.QryPedido.Close;
  dm.QryPedido.Open;
end;


procedure TFrmPedido.btcadastraitemClick(Sender: TObject);
begin
  if GravaPedidos  = True then
  begin
    ShowMessage('Favor Preencher todos campos para gravar ou cancele o cadastro');
    Exit;
  end;

  dbCodProduto.Enabled := True;
  dbQtde.Enabled := True;
  dbVlrUnitario.Enabled := True;
  dbCodProduto.SetFocus;
  dm.cds_Pedido_Item.Insert;
  GravaPedidos := True;
end;

procedure TFrmPedido.btnsalvapedidoClick(Sender: TObject);
begin
  CadastraPedidosBanco;
end;

Procedure TFrmPedido.LimpaComponentes;
var
  I : Integer;
begin

   for I := 0 to ComponentCount-1 do
   begin
     if (Components[I] is TEdit) then
        TEdit(Components[I]).Text := '';
   end;
end;

procedure TFrmPedido.CadastraPedidosBanco;
var num_pedido, item : Integer;
begin
  num_pedido := 0;
  item       := 0;

  if EdtPedido.Text = '' then
  begin
    dm.QryAux.Close;
    dm.QryAux.SQL.Clear;
    dm.QryAux.SQL.Add('select max(numero_pedido) as pedido from pedido ');
    dm.QryAux.Open;

    if dm.QryAux.RecordCount = 0 then
    begin
      num_pedido := 0;
    end
    else
    begin
      num_pedido := dm.QryAux.FieldByName('pedido').AsInteger + 1;
    end;

    Try
      dm.FDTransaction1.StartTransaction;
      dm.QryAux.Close;
      dm.QryAux.SQL.Clear;
      dm.QryAux.SQL.Add(' insert into PEDIDO (NUMERO_PEDIDO, DATA_EMISSAO, CODIGO_CLIENTE, VALOR_TOTAL) ');
      dm.QryAux.SQL.Add('      values (:NUMERO_PEDIDO, :DATA_EMISSAO, :CODIGO_CLIENTE, :VALOR_TOTAL) ');
      dm.QryAux.ParamByName('NUMERO_PEDIDO').AsInteger  := num_pedido;
      dm.QryAux.ParamByName('DATA_EMISSAO').AsDate      := dm.cdsPedidoDATA_EMISSAO.Value;
      dm.QryAux.ParamByName('CODIGO_CLIENTE').AsInteger := dm.cdsPedidoCODIGO_CLIENTE.Value;
      dm.QryAux.ParamByName('VALOR_TOTAL').AsFloat      := StrToFloat(edtTotalPedido.Text);
      dm.QryAux.ExecSQL;
      dm.FDTransaction1.Commit;
    except
     on e : exception do
     begin
       ShowMessage('Erro ao Gravar'+ e.message);
       dm.FDTransaction1.RollBack;
     end;

    end;

  end
  else
  begin
    num_pedido :=  StrToInt(EdtPedido.Text);

    Try
      dm.FDTransaction1.StartTransaction;
      dm.QryAux.Close;
      dm.QryAux.SQL.Clear;
      dm.QryAux.SQL.Add(' update PEDIDO ');
      dm.QryAux.SQL.Add('set DATA_EMISSAO = :DATA_EMISSAO, ');
      dm.QryAux.SQL.Add('    CODIGO_CLIENTE = :CODIGO_CLIENTE, ');
      dm.QryAux.SQL.Add('    VALOR_TOTAL = :VALOR_TOTAL ');
      dm.QryAux.SQL.Add('where (NUMERO_PEDIDO = :NUMERO_PEDIDO) ');
      dm.QryAux.ParamByName('NUMERO_PEDIDO').AsInteger  := dm.cdsPedidoNUMERO_PEDIDO.Value;
      dm.QryAux.ParamByName('DATA_EMISSAO').AsDate      := dm.cdsPedidoDATA_EMISSAO.Value;
      dm.QryAux.ParamByName('CODIGO_CLIENTE').AsInteger := dm.cdsPedidoCODIGO_CLIENTE.Value;
      dm.QryAux.ParamByName('VALOR_TOTAL').AsFloat      := StrToFloat(edtTotalPedido.Text);
      dm.QryAux.ExecSQL;
      dm.FDTransaction1.Commit;
    except
     on e : exception do
     begin
       ShowMessage('Erro ao Gravar'+ e.message);
       dm.FDTransaction1.RollBack;
     end;

    end;
  end;

  Try
    dm.FDTransaction1.StartTransaction;
    dm.QryAux.Close;
    dm.QryAux.SQL.Clear;
    dm.QryAux.SQL.Add('delete from PEDIDO_ITEM where NUMERO_PEDIDO ='+QuotedStr(IntToStr(num_pedido)));
    dm.QryAux.ExecSQL;
    dm.FDTransaction1.Commit;
  except
   on e : exception do
   begin
     ShowMessage('Erro ao Gravar'+ e.message);
     dm.FDTransaction1.RollBack;
   end;
  end;

  dm.cds_Pedido_Item.First;
  item := 1;

  dm.QryInsereItemPedido.Close;
  dm.QryInsereItemPedido.Open;

  while not dm.cds_Pedido_Item.Eof do
  begin

  Try
    dm.FDTransaction1.StartTransaction;
    dm.QryAux.Close;
    dm.QryAux.SQL.Clear;
    dm.QryAux.SQL.Add(' insert into PEDIDO_ITEM (NUMERO_PEDIDO, CODIGO_PRODUTO, QUANTIDADE, VLR_UNITARIO, VLR_TOTAL) ');
    dm.QryAux.SQL.Add('       values (:NUMERO_PEDIDO, :CODIGO_PRODUTO, :QUANTIDADE, :VLR_UNITARIO, :VLR_TOTAL) ');
    dm.QryAux.ParamByName('NUMERO_PEDIDO').AsInteger   := num_pedido;
    dm.QryAux.ParamByName('CODIGO_PRODUTO').AsInteger  := dm.cds_Pedido_ItemCODIGO_PRODUTO.Value;
    dm.QryAux.ParamByName('QUANTIDADE').AsInteger      := dm.cds_Pedido_ItemQUANTIDADE.Value;
    dm.QryAux.ParamByName('VLR_UNITARIO').AsFloat    := dm.cds_Pedido_ItemVLR_UNITARIO.Value;
    dm.QryAux.ParamByName('VLR_TOTAL').AsFloat       := dm.cds_Pedido_ItemVLR_TOTAL.Value;
    dm.QryAux.ExecSQL;
    dm.FDTransaction1.Commit;
    item := item + 1;
  except
   on e : exception do
   begin
     ShowMessage('Erro ao Gravar'+ e.message);
     dm.FDTransaction1.RollBack;
   end;
  end;
    dm.cds_Pedido_Item.Next;
  end;
end;



end.
