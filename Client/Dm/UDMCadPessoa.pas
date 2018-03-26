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
  ClassPessoa_Endereco;

type
  TDMCadPessoa = class(TDMPaiCadastro)
    CDSPessoa_Endereco: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
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

procedure TDMCadPessoa.DataModuleCreate(Sender: TObject);
begin
  FClasseFilha := TClassPessoa;

  FClassPessoa_Endereco := TClassPessoa_Endereco.Create;

  DSPCCadastro.ServerClassName := 'TSMCadPessoa';
  CDSCadastro.ProviderName := 'DSPCCadastro';
  //CDSPessoa_Endereco.ProviderName := 'DSPCCadastro';

  CDSPessoa_Endereco.DataSetField := TDataSetField(CDSCadastro.FieldByName('SQLDSPessoa_Endereco'));
  with TClassPessoa_Endereco do
  begin
    //CDSPessoa_Endereco.AdicionaCampos;
  end;


  inherited;
end;

procedure TDMCadPessoa.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FClassPessoa_Endereco.Free;
  CDSPessoa_Endereco.Close;
end;

end.
