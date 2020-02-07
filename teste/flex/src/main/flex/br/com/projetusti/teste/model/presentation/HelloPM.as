package br.com.projetusti.teste.model.presentation {
import br.com.projetusti.teste.events.HelloEvent;
import br.com.projetusti.teste.model.vo.Message;

import flash.events.Event;

import mx.rpc.events.ResultEvent;

/**
 * Modelo responsável pela lógica e controle das views de Message
 * @author Diego Ramalho de Oliveira
 * @since 01/09/2010
 * @version 1.0.0
 */
public class HelloPM {

    /**
     * @private
     */
    private var _example:Object;

    /**
     * @private
     */
    private var _valueObject:Object;

    /**
     * Disparadorde Mensagens.
     */
    [MessageDispatcher]
    public var dispatcher:Function;

    [Bindable]
    public var currentState:String;

    [Init]
    public function init():void {
        currentState = "search";
    }

    /**
     * @inheritDoc
     */
    [Bindable]
    public function get valueObject():Object {
        return _valueObject;
    }

    /**
     * @inheritDoc
     */
    [Inject(id="messageVO")]
    public function set valueObject(value:Object):void {
        _valueObject = value;
    }

    /**
     * @inheritDoc
     */
    [Bindable]
    public function get example():Object {
        return _example;
    }

    /**
     * @inheritDoc
     */
    [Inject(id="messageExample")]
    public function set example(value:Object):void {
        _example = value;
    }

    /**
     * Solicita a criação da mensagem para ser exibida na view.
     */
    public function createMessage(event:Event):void {
        dispatcher(new HelloEvent(HelloEvent.CREATE))
    }

    /**
     * Ouve a resposta do back-end à solicitação
     * da criação da mensagem
     */
    [CommandResult(selector="createMessage")]
    public function loginHandler(event:ResultEvent):void {
        currentState = "view";
        if (event.result) {
            valueObject = event.result as Message;
        }
    }
}
}