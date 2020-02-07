package br.com.projetusti.teste.model.presentation {
import br.com.projetusti.teste.controller.MenuController;
import br.com.projetusti.teste.events.MenuItemEvent;

import flash.events.Event;

import mx.core.FlexGlobals;
import mx.events.MenuEvent;

import org.spicefactory.parsley.core.context.Context;

/**
 * Principal Presentation Model da aplicação.
 * @author Diego Ramalho de Oliveira
 * @since 10/09/2014
 * @version 1.0.0
 */
public class ApplicationPM {

    [MessageDispatcher]
    public var dispatcher:Function;

    private var _application:Main;

    [Inject]
    public var context:Context;

    /**
     * Controlador para os menus do sistema.
     */
    [Inject]
    [Bindable]
    public var menuController:MenuController;

    [Init]
    public function init():void {
        _application = FlexGlobals.topLevelApplication as Main;

        /**
         * Evento usado para setar o framerate para previnir o travamento do flex
         */
        _application.addEventListener(Event.ENTER_FRAME, onEnterFrame);

        if (_application.stage.hasOwnProperty("nativeWindow"))  {
            _application.stage.nativeWindow.addEventListener(Event.CLOSING, application_closingHandler);
            //_application.stage.nativeWindow.maximize();
        }
    }

    /**
     * Ouve o momento de fechamento da aplicação para dar ao usuário a oportunidade de confirmar ou não
     * o desejo de fechar a aplicação.
     * @param event Evento que marca o momento de fechamento da aplicação.
     */
    protected function application_closingHandler(event:Event):void {
        event.preventDefault();
        if (_application.stage.hasOwnProperty("nativeWindow"))
            _application.stage.nativeWindow.close();
    }

    /**
     * Previne que o sistema congele após mais ou menso 20 minutos sem interação
     * @param e
     */
    public function onEnterFrame(e:Event):void {
        e.target.stage.frameRate = 30
    }

    /**
     * Solicita que seja realizada a ação correspondente ao item de menu selecionado.
     * @param event
     */
    public function mainMenu_itemClickHandler(event:MenuEvent):void {
        event.target.callLater(dispatcher, [new MenuItemEvent(MenuItemEvent.INVOKE, event.item)]);
    }

    /**
     * Ouve a criação dos Menus do Menubar ajustando a altura e tornando
     * os mesmos "dragáveis".
     * @param event
     */
    public function mainMenu_menuShowHandler(event:MenuEvent):void {
        event.menu.variableRowHeight = true;
        event.menu.dragEnabled = true;
    }
}
}