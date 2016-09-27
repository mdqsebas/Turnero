program clientesockets;

uses
  Forms,
  clienteforma in 'clienteforma.pas' {Form1},
  Protocolo in 'Protocolo.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
