package br.com.projetusti.teste.util {
    import flash.system.Capabilities;

/**
 * Verifica se a aplicação está rodando
 * via AIR ou ADL.
 * @return true caso a aplicação esteja em modo desktop.
 */
public function isDesktop():Boolean {
    return Capabilities.playerType == "Desktop";
}
}