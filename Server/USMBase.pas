unit USMBase;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth;

type
  TSMBase = class(TDSServerModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation


{$R *.dfm}


end.

