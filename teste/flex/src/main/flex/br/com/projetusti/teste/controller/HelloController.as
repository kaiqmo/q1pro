package br.com.projetusti.teste.controller {
import br.com.projetusti.teste.events.HelloEvent;

import mx.rpc.AbstractService;
import mx.rpc.AsyncToken;

/**
 * Conjunto de métodos de controle para a Entidade Usuário.
 * @author Daniel R C Frank
 * @since 01/09/2010
 * @version 1.0.1
 */
public class HelloController{
    /**
     * @private
     */
    private var _service:AbstractService;

    /**
     * Disparador de Mensagens.
     */
    [MessageDispatcher]
    public var dispatcher:Function;

    /**
     * @inheritDoc
     */
    [Inject(id="helloService")]
    public function set service(value:AbstractService):void {
        _service = value;
    }

    /**
     * Solicita ao service uma chamada remota
     * com base no evento recebido.
     */
    [Command(selector="createMessage")]
    public function send(event:HelloEvent):AsyncToken {
        return _service["invoke"](event.type, event.args);
    }

}
}