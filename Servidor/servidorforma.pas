unit servidorforma;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ScktComp, ComCtrls, StdCtrls, Numerador;

type
  TfrmServidor = class(TForm)
    mmClientes: TMemo;
    StatusBar1: TStatusBar;
    ServerSocket1: TServerSocket;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1Listen(Sender: TObject;
      Socket: TCustomWinSocket);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmServidor: TfrmServidor;
  iTurno: integer;

implementation

uses Protocolo;

{$R *.DFM}

procedure TfrmServidor.FormCreate(Sender: TObject);
begin

  iTurno := 0;
  Label1.Caption := IntToStr(iTurno);
  ServerSocket1.Active := True;

end;

procedure TfrmServidor.FormDestroy(Sender: TObject);
begin

  ServerSocket1.Active := False;

end;

procedure TfrmServidor.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  paquete : TPaquete;
  Ptr: ^TPaquete;
  iResult, iCount, i : Integer;
begin
  Ptr := nil; //@paquete;
  iResult := Socket.ReceiveBuf (Ptr, SizeOf(paquete));
  if (iResult <> SizeOf(paquete)) then
    mmClientes.Lines.Add('Error de comunicaci�n con '+Socket.RemoteAddress)
  else
    begin
   //   paquete.Comando := Ptr^.Comando;
   //   paquete.Mostrador := Ptr^.Mostrador;
      iTurno := iTurno +1;
      mmClientes.Lines.Add('Mostrador:'+paquete.Mostrador+' Turno: '+IntToStr(iTurno));
      Label1.Caption := IntToStr(iTurno);
   //   Socket.SendText(IntToStr(iTurno));
    end;

end;

procedure TfrmServidor.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  mmClientes.Lines.Add('Conexi�n desde '+ Socket.RemoteAddress);
end;

procedure TfrmServidor.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  mmClientes.Lines.Add('Desconexi�n de '+Socket.RemoteAddress);
end;

procedure TfrmServidor.ServerSocket1Listen(Sender: TObject;
  Socket: TCustomWinSocket);
begin

  StatusBar1.Panels.Items[0].Text := 'Escuchando...';

end;

end.
