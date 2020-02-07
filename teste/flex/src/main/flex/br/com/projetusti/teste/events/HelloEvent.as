package br.com.projetusti.teste.events {
import flash.events.Event;

/**
 * Evento responsável pela solicitação de Mensagens.
 * @author Diego Ramalho de Oliveira
 * @since 10/09/2014
 * @version 1.0.0
 */
public class HelloEvent extends Event {
    /**
     * A constante <code>MessageEvent.CREATE</code> define o valor da
     * propriedade <code>type</code> do evento
     * @eventType createMessage
     */
    public static const CREATE:String = "createMessage";

    /**
     * @private
     */
    private var _args:Array;

    /**
     * Argumentos genéricos.
     * @return array de argumentos.
     */
    public function get args():Array {
        return _args;
    }

    /**
     * Construtor
     * @param type
     * @param usuario
     */
    public function HelloEvent(type:String, ...args) {
        _args = args;
        super(type);
    }

    /**
     * @inheritDoc
     */
    override public function clone():Event {
        return new HelloEvent(type);
    }
}
}