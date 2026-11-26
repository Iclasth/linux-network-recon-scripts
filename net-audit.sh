#!/bin/sh

# Script de diagnostico somente-leitura (nao altera configuracoes de rede).
# Substitui utilitarios antigos do pacote net-tools (ifconfig, route, arp, netstat).

# --- Interfaces, IPs, rotas e tabela ARP ---
ip -br addr
# Lista interfaces, estado e enderecos IP/MAC de forma resumida.

ip link show
# Exibe detalhes da camada de enlace: estado (UP/DOWN), MAC e broadcast.

ip route show
# Mostra a tabela de rotas, sub-redes locais e o gateway padrao (substitui "route").

ip neigh show
# Exibe a tabela ARP/vizinhos (mapeamento IP -> MAC na rede local; substitui "arp").

# --- Resolucao de nomes (DNS) ---
resolvectl status
# Mostra servidores DNS ativos, protocolos e dominios configurados por interface.

resolvectl query google.com
# Testa a resolucao DNS de um dominio e mostra o IP retornado.

# --- Sockets e portas em escuta ---
ss -tulnp
# Lista sockets TCP/UDP em escuta e processos associados para auditar portas abertas (substitui "netstat").