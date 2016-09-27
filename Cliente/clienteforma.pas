unit clienteforma;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, StdCtrls, ScktComp, ComCtrls, Protocolo;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    sbConectar: TSpeedButton;
    StatusBar1: TStatusBar;
    reUsuario: TRichEdit;
    ClientSocket1: TClientSocket;
    edtComputadora: TEdit;
    Label1: TLabel;
    mmResultados: TMemo;
    btSiguiente: TButton;
    btAnterior: TButton;
    btReiniciar: TButton;
    lbPort: TLabel;
    edtPort: TEdit;
    edtMostrador: TEdit;
    lbMostrador: TLabel;
    procedure ClientSocket1Connect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Disconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure sbConectarClick(Sender: TObject);
    procedure reUsuarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure btSiguienteClick(Sender: TObject);
    procedure btAnteriorClick(Sender: TObject);
    procedure btReiniciarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Statusbar1.Panels[0].Text := 'Conectado a ' + ClientSocket1.Host;
end;

procedure TForm1.ClientSocket1Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Statusbar1.Panels[0].Text := 'Desconectado';
end;

procedure TForm1.ClientSocket1Error(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  mmResultados.Lines.Add('Error al conectar a ' + ClientSocket1.Host);
  ErrorCode := 0;
end;

procedure TForm1.sbConectarClick(Sender: TObject);
begin

  if ClientSocket1.Active then ClientSocket1.Active := False
   else begin
      ClientSocket1.Host := edtComputadora.Text;
      ClientSocket1.Active := True;
   end;

end;

procedure TForm1.reUsuarioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  // Si el usuario presionó [Enter], enviamos
  // la línea anterior.
  if Key = VK_Return then
      ClientSocket1.Socket.SendText(reUsuario.Lines[reUsuario.Lines.Count - 1]);

end;

procedure TForm1.ClientSocket1Read(Sender: TObject;
  Socket: TCustomWinSocket);
begin

  // Cada vez que el socket recibe datos,
  // un evento OnRead es generado.
  // Simplemente escribimos los datos que
  // hemos recibido en el Memo.
  mmResultados.Lines.Add(Socket.ReceiveText);

end;

procedure TForm1.btSiguienteClick(Sender: TObject);
var
  paquete: TPaquete;
  Ptr: pointer; //^TPaquete;
  iResult: Integer;
begin
        paquete.Comando := Siguiente;
        paquete.Mostrador := edtMostrador.Text;
        Ptr := @paquete;
  //      ClientSocket1.Socket.SendText('Siguiente');
        iResult := ClientSocket1.Socket.SendBuf( Ptr, SizeOf(paquete));
        reUsuario.Lines.Add('Envio de bytes '+IntToStr(iResult));

end;

procedure TForm1.btAnteriorClick(Sender: TObject);
begin
        ClientSocket1.Socket.SendText('Anterior');
end;

procedure TForm1.btReiniciarClick(Sender: TObject);
begin
        ClientSocket1.Socket.SendText('Reiniciar');
end;

end.
