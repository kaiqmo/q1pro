package br.com.projetusti.teste.managers
{
    import flash.display.DisplayObject;
    import flash.events.EventDispatcher;

    import mx.collections.ArrayCollection;
    import mx.core.FlexGlobals;
    import mx.core.UIComponent;
    import mx.events.CloseEvent;
    import mx.managers.PopUpManager;

    import org.spicefactory.parsley.core.context.Context;

import spark.components.TitleWindow;

/**
	 * Gerenciador de janelas.
	 * @author Daniel R C Frank
	 * @since 19/07/2010
	 * @version 1.0.6
	 */
	[ManagedEvents("windowClose")]
	public class WindowManager extends EventDispatcher
	{
		/**
		 * Injeção do contexto
		 * (O contexto será utilizado para adicionar
		 * a view ao conexto do parsley)
		 */
		[Inject]
		public var _context:Context;

		/**
		 * @private
		 */
		private var _openedWindows:ArrayCollection;
		
		/**
		 * A constante <code>CloseEvent.WINDOW_CLOSE</code> define o valor da
		 * propriedade <code>type</code> do evento para um valor <code>windowClose</code>.
		 * @eventType windowClose
		 */
		public static const WINDOW_CLOSE:String = "windowClose";
		
		/**
         * Lista das janelas abertas.
		 * @return 
		 */
        [Bindable("__NoChangeEvent__")]
		public function get openedWindows():ArrayCollection
		{
			_openedWindows ||= new ArrayCollection();
			return _openedWindows;
		}

		/**
		 * Cria uma janela e adiciona
		 * o container passado como parâmetro
		 * como elemento dessa janela.
		 * @param container
		 * @param parent
		 * @param modal
		 */
		public function open(container:UIComponent, context:Context=null,
							 parent:DisplayObject=null, modal:Boolean=true):TitleWindow
		{
			if (context)
				currentContext = context;
			else
				currentContext = _context;

			var window:TitleWindow = new TitleWindow();
			var currentContext:Context;
			
			parent ||= FlexGlobals.topLevelApplication as DisplayObject;
			currentContext.viewManager.addViewRoot(DisplayObject(window));
			window.addEventListener(CloseEvent.CLOSE, window_closeHandler);
			window.addElement(container);
			
			if (container.hasOwnProperty("title"))
				window.title = container["title"];

            PopUpManager.addPopUp(window, parent, modal);

			var xPosition:Number = (parent.stage.stageWidth - window.width) / 2;
			var yPosition:Number = (parent.stage.stageHeight - window.height) / 2;
			
			window.move(xPosition, yPosition);
			
			//A re-centralização deve ser feita pelo método abaixo para eliminar "fantasmas" e artefatos
			parent["callLater"](function ():void
			{
				PopUpManager.centerPopUp(window);
			});
			
			openedWindows.addItem(window);
			
			return window;
		}
		
		/**
		 * Ouve o fechamento das janelas removendo as mesmas
		 * da lista de controle e propagando o evento de
		 * fechamento, se aplivável. 
		 * @param event
		 */		
		protected function window_closeHandler(event:CloseEvent):void
		{
			var window:TitleWindow = event.target as TitleWindow;
			
			var index:int = openedWindows.getItemIndex(window);
			
			if (index >= 0)
				openedWindows.removeItemAt(index);

            PopUpManager.removePopUp(window);
		}
		
		/**
		 * Fecha todas as janelas abertas. 
		 */		
		public function closeAll():void
		{
			var ac:ArrayCollection = new ArrayCollection();
			ac.addAll(openedWindows);
			
			if (ac && ac.length > 0)
			{
				for each (var window:TitleWindow in ac)
					window.dispatchEvent(new CloseEvent(CloseEvent.CLOSE));
			}
		}
		
		/**
		 * Fecha a última janela aberta. 
		 */		
		public function popWindow():void
		{
			if (openedWindows.length > 0)
			{
				var window:TitleWindow = openedWindows.getItemAt(openedWindows.length -1) as TitleWindow;
				window.dispatchEvent(new CloseEvent(CloseEvent.CLOSE));
			}
		}
	}
}