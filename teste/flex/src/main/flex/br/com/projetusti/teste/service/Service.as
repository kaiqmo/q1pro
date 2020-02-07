package br.com.projetusti.teste.service {
import br.com.projetusti.teste.managers.EndpointManager;

import mx.rpc.AbstractOperation;
import mx.rpc.AsyncToken;
import mx.rpc.Fault;
import mx.rpc.events.FaultEvent;
import mx.rpc.remoting.mxml.RemoteObject;

/**
 * Classe responsável pelas chamadas remotas.
 * @author Daniel R C Frank
 * @since 07/02/2010
 * @version 1.0.4
 */
public class Service extends RemoteObject {
    /**
     * Disparador de Mensagens.
     */
    [MessageDispatcher]
    public var dispatcher:Function;

    /**
     * Construtor
     */
    public function Service() {
        showBusyCursor = true;
    }

    [Inject]
    public var dummy:EndpointManager;

    /**
     * Configuração básica do serviço, criação dinâmica
     * do acesso ao canal adição do ouvidor padrão de falhas.
     */
    [Init]
    public function init():void {
        channelSet = EndpointManager.CHANNEL_SET;
        addEventListener(FaultEvent.FAULT, faultHandler);
    }

    /**
     * Envia a requisição ao back-end.
     * @param method
     * @param args
     * @return chamada assíncrona
     */
    public function invoke(method:String, args:Array):AsyncToken {
        var operation:AbstractOperation = getOperation(method);
        operation.arguments = args;

        return operation.send();
    }

    /**
     * Ouvidor genérico para exceções.
     * @param event
     */
    protected function faultHandler(event:FaultEvent):void {
        if (event.fault.faultCode == "Channel.Call.Failed" ||
                event.fault.faultCode == "Client.Error.MessageSend") {
            var fault:Fault = new Fault(event.fault.faultCode,
                    "Não foi possível conectar-se ao servidor.", event.fault.faultDetail);

            event = new FaultEvent(FaultEvent.FAULT, false, true, fault);
        }
        else if (event.fault.rootCause) {
            dispatcher(new FaultEvent(event.fault.faultCode,
                    false, true, event.fault, event.token));
            return;
        }
    }
}
}