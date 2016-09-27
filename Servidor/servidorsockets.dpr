program servidorsockets;

uses
  Forms,
  servidorforma in 'servidorforma.pas' {frmServidor},
  Numerador in 'Numerador.pas' {Frame1: TFrame},
  Protocolo in '..\Cliente\Protocolo.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmServidor, frmServidor);
  Application.Run;
end.
