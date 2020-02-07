package br.com.projetusti.teste.events {
import flash.events.Event;

/**
 * Evento de controle dos itens de menu.
 * @author Daniel R C Frank
 * @since 26/07/11
 * @version 1.0.0
 */
public class MenuItemEvent extends Event {
    /**
     * A constante <code>MenuItemEvent.INVOKE</code> define o valor da
     * propriedade <code>type</code> do evento para um valor <code>invokeItem</code>.
     * @eventType invokeItem
     */
    public static const INVOKE:String = "invokeItem";

    /**
     * @private
     */
    private var _item:*;

    /**
     * Item que será utilizado apra invocar a ação.
     * Normalmente um item de menu ou seu respectivo ID.
     */
    public function get item():* {
        return _item;
    }

    /**
     * Contrutor
     * @param type
     * @param item
     */
    public function MenuItemEvent(type:String, item:*) {
        _item = item;

        super(type);
    }

    /**
     * @inheritDoc
     */
    override public function clone():Event {
        return new MenuItemEvent(type, item);
    }
}
}