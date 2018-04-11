unit UDMCadPessoa;

interface

uses
  System.SysUtils,
  System.Classes,
  UDMPaiCadastro,
  Data.DB,
  Datasnap.DBClient,
  Datasnap.DSConnect,
  //------//
  ClassPessoa,
  ClassPessoa_Endereco,
  ClassDataSet;

type
  TDMCadPessoa = class(TDMPaiCadastro)
    CDSPessoa_Endereco: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure CDSCadastroAfterOpen(DataSet: TDataSet);
    procedure CDSPessoa_EnderecoBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    FCodigoAtualPessoa_Endereco: Integer;
    FClassPessoa_Endereco: TClassPessoa_Endereco;
  public
    { Public declarations }
  end;

var
  DMCadPessoa: TDMCadPessoa;

implementation

uses
  UDMConexao;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMCadPessoa.CDSCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CDSPessoa_Endereco.DataSetField := TDataSetField(CDSCadastro.FieldByName('SQLDSPessoa_Endereco'));
  FClassPessoa_Endereco.ConfigurarPropriedadesDoCampo(CDSPessoa_Endereco);
  //Abre os DataSetsDetalhe
  AbreFilhos;
end;

procedure TDMCadPessoa.CDSPessoa_EnderecoBeforePost(DataSet: TDataSet);
begin
  inherited;
  with DataSet, TClassPessoa_Endereco do
  begin
    if (UpdateStatus = usInserted) and
        ((FieldByName(CampoChave).IsNull)) then
      FieldByName(CampoChave).AsInteger := DMConexao.ProximoCodigo(TabelaPrincipal);
  end;
end;

procedure TDMCadPessoa.DataModuleCreate(Sender: TObject);
begin
  FClasseFilha := TClassPessoa;

  FClassPessoa_Endereco := TClassPessoa_Endereco.Create;

  DSPCCadastro.ServerClassName := 'TSMCadPessoa';
  CDSCadastro.ProviderName := 'DSPCCadastro';

  inherited;
end;

procedure TDMCadPessoa.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FClassPessoa_Endereco.Free;
  CDSPessoa_Endereco.Close;
end;

end.
