#!/bin/sh

# Esse arquivo contém comandos que alteram diretamente informações e configurações temporárias acerca da pilha de rede.
# Se não deseja ter problemas de conexão enquanto executa os comandos, utilize uma VM (máquina virtual) para testes.

ip a add 192.168.50.5 dev eth1
# Adiciona um endereço de IP a uma interface de rede específica (host/eth1)
# "a" é a abreviação de "addr(address)" e "dev" é a abreviação de "device"

ip a del 192.168.50.5 dev eth1
# Remove o endereço de IP atribuido acima (host/eth1)

ip link set eth1 up
# Responsável por habilitar a interface de rede (host/eth1)

ip link set eth1 down
# Responsável por desabilitar a interface de rede (host/eth1)

ip route add 10.10.20.0/24 via 172.19.1.10 dev eth1
# Utilizado para modificar a rota de rede padrão, incluindo o gateway utilizado

ip route del 10.10.20.0/24
# Segue a mesma linha de raciocício do comando anterior, mas diferentemente, ele remove uma rota

ip route add default via 192.168.50.100
# Adiciona uma nova rota padrão a tabela de rotas