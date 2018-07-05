unit UFrmCadPedido;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  UFrmPaiCadastro,
  Vcl.Menus,
  Data.DB,
  Vcl.ComCtrls,
  Vcl.Buttons,
  Vcl.StdCtrls,
  Vcl.Mask,
  JvExMask,
  JvToolEdit,
  JvBaseEdits,
  Vcl.DBCtrls,
  Vcl.ExtCtrls,
  JvDBControls,
  JvExControls,
  JvDBLookup,
  Vcl.DBCGrids,
  Vcl.Grids,
  Vcl.DBGrids,
  //---//
  UFrmPaiConsulta,
  ClassPedido,
  ClassPedido_Item,
  ClassPedido_Prazos,
  UDMCadPedido,
  ClassPessoa,
  UDMCadPessoa,
  Constantes, JvComponentBase, JvEnterTab, JvExDBGrids, JvDBGrid, ClassSituacao;

type
  TFrmCadPedido = class(TFrmPaiCadastro)
    groupCliente: TGroupBox;
    lblClienteCodigo: TLabel;
    edtClienteRazao: TDBEdit;
    edtEmissao: TJvDBDateEdit;
    lblEmissao: TLabel;
    groupEndereco: TGroupBox;
    lblRuaEndereco: TLabel;
    cbbEnderecoEntrega: TJvDBLookupCombo;
    lblBairroEndereco: TLabel;
    edtBairroEndereco: TDBEdit;
    edtCepEndereco: TDBEdit;
    lblCepEndereco: TLabel;
    edtNumeroEndereco: TDBEdit;
    lblNumeroEndereco: TLabel;
    lblCidadeEndereco: TLabel;
    edtCidadeEndereco: TDBEdit;
    lblTipoEndereco: TLabel;
    edtTipoEndereco: TDBEdit;
    edtUfEndereco: TDBEdit;
    lblUfEndereco: TLabel;
    groupNegociacao: TGroupBox;
    ctrlgrdPrazos: TDBCtrlGrid;
    rdgrpCondicaoPagamento: TDBRadioGroup;
    lblPedidoConsultor: TLabel;
    lblPrazoPedido: TLabel;
    lblDescontoPercentual: TLabel;
    lblDescontoValor: TLabel;
    edtDescontoValor: TDBEdit;
    edtPedidoConsultor: TDBEdit;
    edtDescontoPercentual: TDBEdit;
    rdgrpTipoPedido: TDBRadioGroup;
    DSPedido_Prazos: TDataSource;
    DSPedido_Item: TDataSource;
    DSPessoa_Endereco: TDataSource;
    edtClienteCodigo: TJvDBCalcEdit;
    lblFormaPagamento: TLabel;
    lblTotalBruto: TStaticText;
    lblDesconto: TStaticText;
    lblTotalLiquido: TStaticText;
    gridPedido_Item: TJvDBGrid;
    edtTotalBruto: TJvDBCalcEdit;
    edtDesconto: TJvDBCalcEdit;
    edtTotalLiquido: TJvDBCalcEdit;
    edtPrazo: TJvDBCalcEdit;
    edtSituacaoCodigo: TJvDBCalcEdit;
    edtSituacaoDescricao: TDBEdit;
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtClienteCodigoButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure gridPedido_ItemExit(Sender: TObject);
    procedure gridPedido_ItemDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DSCadastroStateChange(Sender: TObject);
    procedure edtPrazoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ctrlgrdPrazosEnter(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtSituacaoCodigoButtonClick(Sender: TObject);
  private
    { Private declarations }
    //FDMPessoa: TDMCadPessoa;
    ExecutandoKeyDown: Boolean;
    FFieldOrigem: string;
    FPrazos: Boolean;
  public
    { Public declarations }
    //property DMPessoa: TDMCadPessoa read FDMPessoa write FDMPessoa;
  end;

var
  FrmCadPedido: TFrmCadPedido;

implementation

uses
  ClassHelper;

{$R *.dfm}

procedure TFrmCadPedido.btnGravarClick(Sender: TObject);
begin
  if not DSPedido_Item.DataSet.IsEmpty then
    inherited
  else
    ShowMessage('Não ha Itens no Pedido!');
end;

procedure TFrmCadPedido.btnIncluirClick(Sender: TObject);
begin
  inherited;
  if edtClienteCodigo.CanFocus then
    edtClienteCodigo.SetFocus;
end;

procedure TFrmCadPedido.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  FrmPaiConsulta := TFrmPaiConsulta.Create(Self);
  FrmPaiConsulta.Classe := TClassPedido;
  try
    FrmPaiConsulta.ShowModal;
    edtCodigo.AsInteger := FrmPaiConsulta.Codigo;
    DMCadastro.AbreCasdastro(edtCodigo.AsInteger);
  finally
    FreeAndNil(FrmPaiConsulta);
  end;
end;

procedure TFrmCadPedido.ctrlgrdPrazosEnter(Sender: TObject);
begin
  inherited;
  ExecutandoKeyDown := False;
end;

procedure TFrmCadPedido.DSCadastroStateChange(Sender: TObject);
begin
  inherited;
  if DSCadastro.DataSet.State in [dsInsert, dsEdit] then
  begin
    DSPedido_Item.DataSet.Edit;
  end;
end;

procedure TFrmCadPedido.edtClienteCodigoButtonClick(Sender: TObject);
begin
  inherited;
  if not (DMCadastro.CDSCadastro.State in [dsEdit, dsInsert]) then
    DMCadastro.CDSCadastro.Edit;

  FrmPaiConsulta := TFrmPaiConsulta.Create(Self);
  FrmPaiConsulta.Classe := TClassPessoa;
  try
    FrmPaiConsulta.ShowModal;
    DMCadastro.CDSCadastro.FieldByName('CODIGO_PESSOA').AsInteger := FrmPaiConsulta.Codigo;
    //TJvDBCalcEdit(Sender).DataSource.DataSet.FieldByName(TJvDBCalcEdit(Sender).DataField).AsInteger := FrmPaiConsulta.Codigo;
  finally
    FreeAndNil(FrmPaiConsulta);
    Abort;
  end;
end;

procedure TFrmCadPedido.edtPrazoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if ExecutandoKeyDown then
    Exit;

  ExecutandoKeyDown := True;
  try
    if Shift = [] then
    begin
      with DSPedido_Prazos.DataSet do
        case Key of
          VK_RETURN: //13: // tecla enter
            begin
              Perform(WM_KEYDOWN, VK_TAB, 0);
            end;
          VK_UP: //38: // seta para cima
            begin
              if not Bof then //BeginOfFile
              begin
                if State in [dsEdit, dsINsert] then
                  Post;
                Prior;
                abort;
              end;
            end;
          VK_DOWN: //40: // seta para baixo
            begin
              if not Eof then //EndOfFile
              begin
                Next;
                abort;
              end;
            end;
          VK_TAB: edtDescontoPercentual.SetFocus;
        end;
    end
    else if (Shift = [ssShift]) then // Voltando o controle
      if Key = VK_TAB then
        edtPedidoConsultor.SetFocus;
  finally
    ExecutandoKeyDown := False;
    Key := 0;
  end;
end;

procedure TFrmCadPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(DMCadPedido);
end;

procedure TFrmCadPedido.FormCreate(Sender: TObject);
begin
  DMCadastro := TDMCadPedido.Create(Self);
  //DMPessoa   := TDMCadPessoa.Create(Self);     //Estava causando problema de Midas.dll

  DSPedido_Prazos.DataSet   := TDMCadPedido(DMCadastro).CDSPedido_Prazos;
  DSPedido_Item.DataSet     := TDMCadPedido(DMCadastro).CDSPedido_Item;
  DSPessoa_Endereco.DataSet := TDMCadPedido(DMCadastro).CDSPedido_PessoaEndereco;
  inherited;
end;

procedure TFrmCadPedido.FormDestroy(Sender: TObject);
begin
  inherited;
  FrmCadPedido := nil;
end;

procedure TFrmCadPedido.FormShow(Sender: TObject);
begin
  inherited;

  with gridPedido_Item do
  begin
    CriarColuna(['CODIGO_ITEM'], cbsEllipsis);
    CriarColuna(['REFERENCIA_ITEM',
                 'DESCRICAO_ITEM',
                 'UNIDADE_ITEM',
                 'QTD_PEDITEM',
                 'VLRUNITBRUTO_PEDITEM',
                 'VLRUNITLIQUIDO_PEDITEM',
                 'VLRTOTBRUTO_PEDITEM',
                 'VLRTOTLIQUIDO_PEDITEM']);
  end;
end;

procedure TFrmCadPedido.gridPedido_ItemDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
 if Column.Field <> nil then
 if Column.Field.Tag in [CampoNaoEditavel, CampoNaoEditavelENaoAtualizavel] then
  begin
    gridPedido_Item.Canvas.Brush.Color := clGradeSomenteLeitura;
    gridPedido_Item.Canvas.FillRect(rect);
    Column.ReadOnly := True;

    gridPedido_Item.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TFrmCadPedido.gridPedido_ItemExit(Sender: TObject);
begin
  inherited;
  if TDBGrid(sender).DataSource.DataSet.State in [dsEdit, dsInsert] then
    TDBGrid(sender).DataSource.DataSet.Post;
end;

procedure TFrmCadPedido.edtSituacaoCodigoButtonClick(Sender: TObject);
begin
  inherited;
  if not (DMCadastro.CDSCadastro.State in [dsEdit, dsInsert]) then
    DMCadastro.CDSCadastro.Edit;

  FrmPaiConsulta := TFrmPaiConsulta.Create(Self);
  FrmPaiConsulta.Classe := TClassSituacao;
  try
    FrmPaiConsulta.ShowModal;
    if FrmPaiConsulta.Codigo <> 0 then
      DMCadastro.CDSCadastro.FieldByName('SITUACAO_PEDIDO').AsInteger := FrmPaiConsulta.Codigo;
  finally
    FreeAndNil(FrmPaiConsulta);
    Abort;
  end;
end;

end.
