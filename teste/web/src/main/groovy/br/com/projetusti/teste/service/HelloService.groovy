package br.com.projetusti.teste.service

import br.com.projetusti.teste.controller.HelloController
import br.com.projetusti.teste.model.vo.Message
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.flex.remoting.RemotingDestination
import org.springframework.stereotype.Service

/**
 * Expõe o controlador das Mensagens
 * @author Diego Ramalho de Oliveira
 * @since 01/09/2010
 * @version 1.0.0
 */
@RemotingDestination
@Service('HelloService')
class HelloService {

    /**
     * Controlador das mensagens
     */
    @Autowired
    private HelloController controller

    /**
     * Cria uma nova mensagem
     * @return Message
     * @throws Exception
     */
    Message createMessage() {
        return controller.create()
    }
}