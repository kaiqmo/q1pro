package br.com.projetusti.teste.controller {
import br.com.projetusti.teste.events.MenuItemEvent;
import br.com.projetusti.teste.managers.WindowManager;
import br.com.projetusti.teste.view.menu.Menu;

import flash.events.Event;

import org.spicefactory.lib.reflect.ClassInfo;
import org.spicefactory.parsley.core.context.Context;

/**
 * Controllador responsável pelo MENU
 * @author Daniel R C Frank
 * @since 31/08/11
 * @version 1.0.0
 */
public class MenuController {
    /**
     * Menu do módulo Principal.
     */
    [Inject]
    [Bindable]
    public var menu:Menu;

    [MessageDispatcher]
    public var dispatcher:Function;

    [Inject]
    public var context:Context;

    /**
     * Gerenciador de Janelas.
     */
    [Inject]
    public var windowManager:WindowManager;

    /**
     * Junção de todos os menus. Utilizado para buscas por ID.
     */
    private var completeMenu:XML;

    /**
     * Cria a junção de todos os menus para facilitar as buscas por ID.
     */
    [Init]
    public function init():void {
        var menus:Array = [menu.mainMenu];
        completeMenu = new XML("<node></node>");

        for each (var menu:* in menus)
            completeMenu.appendChild(menu);
    }

    [MessageHandler(selector="invokeItem")]
    public function invokeMenuItemHandler(event:MenuItemEvent):void {
        var item:* = event.item;

        if (item.@viewClass.length() > 0) {
            // Adicionando a View Instanciada ao contexto!
            var container:* = ClassInfo.forName(item.@viewClass).newInstance([]);

            context.viewManager.addViewRoot(container);

            try {
                //Validaçao do tipo de container para manter compatibilidade com o Novelty
                windowManager.open(container, null, null, false);
            }
            catch (e:Error) {
                trace(e);
            }
        }
        else if (item.@event.length()) {
            dispatcher(new Event(item.@event));
        }
    }
}
}