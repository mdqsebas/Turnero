unit Protocolo;

interface

type

        TComandos = (Siguiente, Anterior, Reiniciar);
        TPaquete = record
          Comando: TComandos;
          Mostrador: string;
        end;

implementation


end.
 