object dm: Tdm
  OldCreateOrder = False
  Height = 513
  Width = 940
  object IBDatabase1: TIBDatabase
    Connected = True
    DatabaseName = 'C:\WK_Teste\WK.FDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    ServerType = 'IBServer'
    Left = 32
    Top = 64
  end
  object IBTransaction1: TIBTransaction
    Active = True
    DefaultDatabase = IBDatabase1
    Left = 64
    Top = 64
  end
  object QryCliente1: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '    CODIGO_CLIENTE,'
      '    NOME,'
      '    CIDADE,'
      '    UF  '
      'FROM  CLIENTE '
      'ORDER BY NOME')
    Left = 31
    Top = 112
    object QryCliente1CODIGO_CLIENTE: TIntegerField
      FieldName = 'CODIGO_CLIENTE'
      Origin = '"CLIENTE"."CODIGO_CLIENTE"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryCliente1NOME: TIBStringField
      FieldName = 'NOME'
      Origin = '"CLIENTE"."NOME"'
      Required = True
      Size = 100
    end
    object QryCliente1CIDADE: TIBStringField
      FieldName = 'CIDADE'
      Origin = '"CLIENTE"."CIDADE"'
      Size = 100
    end
    object QryCliente1UF: TIBStringField
      FieldName = 'UF'
      Origin = '"CLIENTE"."UF"'
      Size = 2
    end
  end
  object QryProduto1: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select CODIGO_PRODUTO, '
      'DESCRICAO, '
      'PRECO_VENDA '
      'from PRODUTO'
      'ORDER BY DESCRICAO')
    Left = 63
    Top = 112
    object QryProduto1CODIGO_PRODUTO: TIntegerField
      FieldName = 'CODIGO_PRODUTO'
      Origin = '"PRODUTO"."CODIGO_PRODUTO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryProduto1DESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      Origin = '"PRODUTO"."DESCRICAO"'
      Required = True
      Size = 100
    end
    object QryProduto1PRECO_VENDA: TIBBCDField
      FieldName = 'PRECO_VENDA'
      Origin = '"PRODUTO"."PRECO_VENDA"'
      Required = True
      Precision = 18
      Size = 2
    end
  end
  object dsProduto: TDataSource
    DataSet = QryProduto
    Left = 64
    Top = 160
  end
  object cds_Pedido_Item: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 120
    object cds_Pedido_ItemPEDIDO_ITEM: TIntegerField
      DisplayLabel = 'Cod.'
      FieldName = 'PEDIDO_ITEM'
    end
    object cds_Pedido_ItemNUMERO_PEDIDO: TIntegerField
      DisplayLabel = 'N'#250'mero do Pedido'
      FieldName = 'NUMERO_PEDIDO'
    end
    object cds_Pedido_ItemCODIGO_PRODUTO: TIntegerField
      DisplayLabel = 'Cod.Produto'
      FieldName = 'CODIGO_PRODUTO'
    end
    object cds_Pedido_ItemPROD: TStringField
      FieldKind = fkLookup
      FieldName = 'PROD'
      LookupDataSet = QryProduto1
      LookupKeyFields = 'CODIGO_PRODUTO'
      LookupResultField = 'DESCRICAO'
      KeyFields = 'CODIGO_PRODUTO'
      Size = 100
      Lookup = True
    end
    object cds_Pedido_ItemQUANTIDADE: TIntegerField
      DisplayLabel = 'Quantidade'
      FieldName = 'QUANTIDADE'
    end
    object cds_Pedido_ItemVLR_UNITARIO: TCurrencyField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'VLR_UNITARIO'
      DisplayFormat = '#,##0.00'
    end
    object cds_Pedido_ItemVLR_TOTAL: TCurrencyField
      DisplayLabel = 'Valor Total'
      FieldName = 'VLR_TOTAL'
      DisplayFormat = '#,##0.00'
    end
    object cds_Pedido_ItemTOTAL_GERAL: TAggregateField
      FieldName = 'TOTAL_GERAL'
      DisplayName = ''
      Expression = 'sum(VLR_TOTAL)'
    end
  end
  object dsItemPedido: TDataSource
    DataSet = cds_Pedido_Item
    Left = 224
    Top = 120
  end
  object dsPedido: TDataSource
    DataSet = cdsPedido
    Left = 222
    Top = 64
  end
  object cdsPedido: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 64
    object cdsPedidoNUMERO_PEDIDO: TIntegerField
      DisplayLabel = 'N'#250'mero do Pedido'
      FieldName = 'NUMERO_PEDIDO'
    end
    object cdsPedidoDATA_EMISSAO: TDateField
      DisplayLabel = 'Data Emiss'#227'o'
      FieldName = 'DATA_EMISSAO'
      EditMask = '99/99/9999'
    end
    object cdsPedidoCODIGO_CLIENTE: TIntegerField
      DisplayLabel = 'Cod.'
      FieldName = 'CODIGO_CLIENTE'
    end
    object cdsPedidoVALOR_TOTAL: TCurrencyField
      DisplayLabel = 'Valor Total Pedido'
      FieldName = 'VALOR_TOTAL'
      DisplayFormat = '#,##0.00'
    end
  end
  object QryPedido1: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select '
      '    pedido.numero_pedido,'
      '    pedido.data_emissao,'
      '    pedido.codigo_cliente,'
      '    pedido.valor_total,'
      '    pedido_item.pedido_item,'
      '    pedido_item.numero_pedido,'
      '    pedido_item.codigo_produto,'
      '    pedido_item.quantidade,'
      '    pedido_item.vlr_unitario,'
      '    pedido_item.vlr_total,'
      '    cliente.nome,'
      '    cliente.cidade,'
      '    cliente.uf,'
      '    produto.descricao,'
      '    produto.preco_venda'
      'from cliente'
      
        '   inner join pedido on (cliente.codigo_cliente = pedido.codigo_' +
        'cliente)'
      
        '   inner join pedido_item on (pedido.numero_pedido = pedido_item' +
        '.numero_pedido)'
      
        '   inner join produto on (pedido_item.codigo_produto = produto.c' +
        'odigo_produto)'
      '')
    Left = 55
    Top = 240
    object QryPedido1NUMERO_PEDIDO: TIntegerField
      FieldName = 'NUMERO_PEDIDO'
      Origin = '"PEDIDO"."NUMERO_PEDIDO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryPedido1DATA_EMISSAO: TDateField
      FieldName = 'DATA_EMISSAO'
      Origin = '"PEDIDO"."DATA_EMISSAO"'
    end
    object QryPedido1CODIGO_CLIENTE: TIntegerField
      FieldName = 'CODIGO_CLIENTE'
      Origin = '"PEDIDO"."CODIGO_CLIENTE"'
    end
    object QryPedido1VALOR_TOTAL: TIBBCDField
      FieldName = 'VALOR_TOTAL'
      Origin = '"PEDIDO"."VALOR_TOTAL"'
      Precision = 18
      Size = 2
    end
    object QryPedido1PEDIDO_ITEM: TIntegerField
      FieldName = 'PEDIDO_ITEM'
      Origin = '"PEDIDO_ITEM"."PEDIDO_ITEM"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryPedido1CODIGO_PRODUTO: TIntegerField
      FieldName = 'CODIGO_PRODUTO'
      Origin = '"PEDIDO_ITEM"."CODIGO_PRODUTO"'
    end
    object QryPedido1QUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
      Origin = '"PEDIDO_ITEM"."QUANTIDADE"'
    end
    object QryPedido1VLR_UNITARIO: TIBBCDField
      FieldName = 'VLR_UNITARIO'
      Origin = '"PEDIDO_ITEM"."VLR_UNITARIO"'
      Precision = 18
      Size = 2
    end
    object QryPedido1VLR_TOTAL: TIBBCDField
      FieldName = 'VLR_TOTAL'
      Origin = '"PEDIDO_ITEM"."VLR_TOTAL"'
      Precision = 18
      Size = 2
    end
    object QryPedido1NOME: TIBStringField
      FieldName = 'NOME'
      Origin = '"CLIENTE"."NOME"'
      Required = True
      Size = 100
    end
    object QryPedido1CIDADE: TIBStringField
      FieldName = 'CIDADE'
      Origin = '"CLIENTE"."CIDADE"'
      Size = 100
    end
    object QryPedido1UF: TIBStringField
      FieldName = 'UF'
      Origin = '"CLIENTE"."UF"'
      Size = 2
    end
    object QryPedido1DESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      Origin = '"PRODUTO"."DESCRICAO"'
      Required = True
      Size = 100
    end
    object QryPedido1PRECO_VENDA: TIBBCDField
      FieldName = 'PRECO_VENDA'
      Origin = '"PRODUTO"."PRECO_VENDA"'
      Required = True
      Precision = 18
      Size = 2
    end
  end
  object QryAux1: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT'
      '    CODIGO_CLIENTE,'
      '    NOME,'
      '    CIDADE,'
      '    UF  '
      'FROM  CLIENTE '
      'ORDER BY NOME')
    Left = 55
    Top = 328
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection2
    Left = 640
    Top = 104
  end
  object FDGUIxErrorDialog1: TFDGUIxErrorDialog
    Provider = 'Forms'
    Left = 800
    Top = 48
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\WK_Teste\Win32\Debug\libmysql.dll'
    Left = 640
    Top = 176
  end
  object FDConnection2: TFDConnection
    Params.Strings = (
      'Database=wk_Teste'
      'User_Name=root'
      'Password=root'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Transaction = FDTransaction1
    UpdateTransaction = FDTransaction1
    Left = 640
    Top = 40
  end
  object QryCliente: TFDQuery
    Connection = FDConnection2
    Transaction = FDTransaction1
    UpdateTransaction = FDTransaction1
    SQL.Strings = (
      'SELECT'
      '    CODIGO_CLIENTE,'
      '    NOME,'
      '    CIDADE,'
      '    UF  '
      'FROM  CLIENTE '
      'ORDER BY NOME')
    Left = 640
    Top = 240
    object QryClienteCODIGO_CLIENTE: TIntegerField
      FieldName = 'CODIGO_CLIENTE'
      Origin = 'CODIGO_CLIENTE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryClienteNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 100
    end
    object QryClienteCIDADE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 100
    end
    object QryClienteUF: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'UF'
      Origin = 'UF'
      Size = 2
    end
  end
  object QryPedido: TFDQuery
    Connection = FDConnection2
    Transaction = FDTransaction1
    UpdateTransaction = FDTransaction1
    SQL.Strings = (
      'select '
      '*'
      'from cliente'
      
        '   inner join pedido on (cliente.codigo_cliente = pedido.codigo_' +
        'cliente)'
      
        '   inner join pedido_item on (pedido.numero_pedido = pedido_item' +
        '.numero_pedido)'
      
        '   inner join produto on (pedido_item.codigo_produto = produto.c' +
        'odigo_produto)')
    Left = 640
    Top = 304
  end
  object QryAux: TFDQuery
    Connection = FDConnection2
    Transaction = FDTransaction1
    UpdateTransaction = FDTransaction1
    Left = 768
    Top = 304
  end
  object QryProduto: TFDQuery
    Connection = FDConnection2
    Transaction = FDTransaction1
    UpdateTransaction = FDTransaction1
    SQL.Strings = (
      'select CODIGO_PRODUTO, '
      'DESCRICAO, '
      'PRECO_VENDA '
      'from PRODUTO'
      'ORDER BY DESCRICAO')
    Left = 768
    Top = 240
    object QryProdutoCODIGO_PRODUTO: TFDAutoIncField
      FieldName = 'CODIGO_PRODUTO'
      Origin = 'CODIGO_PRODUTO'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object QryProdutoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 100
    end
    object QryProdutoPRECO_VENDA: TBCDField
      FieldName = 'PRECO_VENDA'
      Origin = 'PRECO_VENDA'
      Required = True
      Precision = 15
      Size = 2
    end
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 800
    Top = 104
  end
  object QryInsereItemPedido: TFDQuery
    Active = True
    Connection = FDConnection2
    Transaction = FDTransaction1
    UpdateTransaction = FDTransaction1
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateObject = FDUpdateSQL1
    SQL.Strings = (
      'select *'
      'from PEDIDO_ITEM')
    Left = 640
    Top = 376
  end
  object FDUpdateSQL1: TFDUpdateSQL
    Connection = FDConnection2
    InsertSQL.Strings = (
      'INSERT INTO wk_teste.pedido_item'
      '(numero_pedido, codigo_produto, quantidade, vlr_unitario, '
      '  vlr_total)'
      
        'VALUES (:new_numero_pedido, :new_codigo_produto, :new_quantidade' +
        ', :new_vlr_unitario, '
      '  :new_vlr_total)')
    ModifySQL.Strings = (
      'UPDATE wk_teste.pedido_item'
      
        'SET numero_pedido = :new_numero_pedido, codigo_produto = :new_co' +
        'digo_produto, '
      
        '  quantidade = :new_quantidade, vlr_unitario = :new_vlr_unitario' +
        ', '
      '  vlr_total = :new_vlr_total'
      'WHERE numero_pedido = :old_numero_pedido')
    DeleteSQL.Strings = (
      'DELETE FROM wk_teste.pedido_item'
      'WHERE numero_pedido = :old_numero_pedido')
    FetchRowSQL.Strings = (
      
        'SELECT numero_pedido, codigo_produto, quantidade, vlr_unitario, ' +
        'vlr_total'
      'FROM wk_teste.pedido_item'
      'WHERE numero_pedido = :numero_pedido')
    Left = 640
    Top = 424
  end
  object FDCommand1: TFDCommand
    Connection = FDConnection2
    Transaction = FDTransaction1
    Left = 328
    Top = 272
  end
end
