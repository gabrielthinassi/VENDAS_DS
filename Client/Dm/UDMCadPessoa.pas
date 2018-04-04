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

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMCadPessoa.CDSCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CDSPessoa_Endereco.DataSetField := TDataSetField(CDSCadastro.FieldByName('SQLDSPessoa_Endereco'));
  FClassPessoa_Endereco.ConfigurarPropriedadesDoCampo(CDSPessoa_Endereco);

  with TClassPessoa_Endereco do
  begin
    CDSPessoa_Endereco.AdicionarCampos;
    CDSPessoa_Endereco.ProviderName := 'DSPCCadastro';
    //Inicio da viagem
    CDSPessoa_Endereco.Close;
    //CDSPessoa_Endereco.FieldByName('CODIGO_PESSOA').AsInteger := CDSCadastro.FieldByName('CODIGO_PESSOA').AsInteger;
    CDSPessoa_Endereco.FetchParams;
    CDSPessoa_Endereco.Open;
    //Fim da viagem
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
