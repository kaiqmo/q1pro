package br.com.projetusti.teste.controller

import br.com.projetusti.teste.model.vo.Message
import org.springframework.stereotype.Component

/**
 *  Coleção de métodos relacionados às funções de exibição de mensagens
 * @author Diego Ramalho de Oliveira
 * @since 01/09/2010
 * @version 1.0.0
 */
@Component
class HelloController {

    /**
     * Cria uma nova mensagem
     * @return Message
     * @throws Exception
     */
    Message create() {
        return new Message(id: 1,text: "Hello World");
    }
}
