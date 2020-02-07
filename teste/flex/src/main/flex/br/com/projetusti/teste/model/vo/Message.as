package br.com.projetusti.teste.model.vo {

/**
 * Classe com as informações das Mensagens
 * @author Diego Ramalho de Oliveira
 * @since 10/09/2014
 * @version 1.0.0
 */
[Bindable]
[RemoteClass(alias="br.com.projetusti.teste.model.vo.Message")]
public class Message{
    private var _id:Number;
    private var _text:String;

    /**
     * Get id
     * @return id Number
     */
    public function get id():Number {
        return _id;
    }

    /**
     * Set id
     * @param value Number
     */
    public function set id(value:Number):void {
        _id = value;
    }

    /**
     * Get text
     * @return text String
     */
    public function get text():String {
        return _text;
    }

    /**
     * Set text
     * @param value String
     */
    public function set text(value:String):void {
        _text = value;
    }


}
}
