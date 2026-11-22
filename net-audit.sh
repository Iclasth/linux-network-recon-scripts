#!/bin/sh

# IP
# Responsável por configurar interfaces de rede, endereços IP/MAC, Rotas e ARP.
# Ele comprime e substitui o uso dos comandos: "ipconfig", "route" e "arp" do pacote "Net-Tools"
ip -br addr
# Mostra as informações atribuidas ao comando de maneira resumida

ip link show
# Exibe as informações acerca das configurações da interface de rede, incluindo endereço MAC, Broadcast e status (up, down)


ip route show
# Exibe as informações acerca das rotas de rede, incluindo endereço IP, máscara de rede

