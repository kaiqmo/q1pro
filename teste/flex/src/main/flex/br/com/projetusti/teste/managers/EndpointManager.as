package br.com.projetusti.teste.managers {

import br.com.projetusti.teste.util.isDesktop;

import flash.net.SharedObject;

import mx.messaging.ChannelSet;
import mx.messaging.channels.AMFChannel;

/**
 * Gerenciador dos endpoints do sistema.
 * @author Daniel R C Frank
 * @since 16/07/12
 * @version 1.0.0
 */
public class EndpointManager {
    private static const CHANNEL_ID:String = "my-amf";
    private static const POLLING_CHANNEL_ID:String = "my-polling-amf";
    private var CHANNEL_URI:String = "spring/messagebroker/amf";
    private var POLLING_CHANNEL_URI:String = "spring/messagebroker/amfpolling";
    public static var CHANNEL_SET:ChannelSet;
    public static var POLLING_CHANNEL_SET:ChannelSet;
    public static var DEFAULT_URI:String;

    /**
     * Disparador de Mensagens.
     */
    [MessageDispatcher]
    public var dispatcher:Function;

    /**
     * Solicita que os channels sejam criados.
     */
    [Init]
    public function init():void {
        var so:SharedObject = SharedObject.getLocal("server-config");

        DEFAULT_URI = so.data["serverConfig"] ? so.data["serverConfig"] + "/" : "";
        setEndpoint(DEFAULT_URI);
    }

    /**
     * Re-cria os channels com base no nova url de
     * acesso.
     * @param url Nova URL.
     */
    private function setEndpoint(url:String):void {
        if (isDesktop()) {
            if (!url) {
                DEFAULT_URI = "http://localhost:8080/teste/";
            }
            else {
                DEFAULT_URI = url;
            }
            CHANNEL_URI = DEFAULT_URI + CHANNEL_URI;
            POLLING_CHANNEL_URI = DEFAULT_URI + POLLING_CHANNEL_URI;
        }

        CHANNEL_SET = new ChannelSet();
        var channel:AMFChannel = new AMFChannel(CHANNEL_ID, CHANNEL_URI);

        if (channel.netConnection.hasOwnProperty("httpIdleTimeout"))
            channel.netConnection.httpIdleTimeout = (1000 * 60 * 60 * 24);//1 dia

        CHANNEL_SET.addChannel(channel);

        POLLING_CHANNEL_SET = new ChannelSet();
        var pollingChannel:AMFChannel = new AMFChannel(POLLING_CHANNEL_ID, POLLING_CHANNEL_URI);

        POLLING_CHANNEL_SET.addChannel(pollingChannel);
    }
}
}