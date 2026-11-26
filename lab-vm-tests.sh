#!/bin/sh

# Comandos que alteram temporariamente a pilha de rede.
# Rode em VM ou ambiente isolado para não derrubar sua conexao.

# --- Endereco IP (add -> show -> del) ---
ip addr add 192.168.50.5/24 dev eth1
# Adiciona um IP na interface eth1 ("addr" e "dev" sao nomes completos/padrao).

ip addr show dev eth1
# Mostra o IP aplicado na interface.

ip addr del 192.168.50.5/24 dev eth1
# Remove o IP adicionado acima.

# --- Estado da interface (up -> show -> down) ---
ip link set eth1 up
# Ativa a interface eth1.

ip link show dev eth1
# Exibe o estado atual e o MAC da interface.

ip link set eth1 down
# Desativa a interface eth1.

# --- Rota estatica (add -> show -> del) ---
ip route add 10.10.20.0/24 via 172.19.1.10 dev eth1
# Adiciona rota para a rede 10.10.20.0/24 via gateway 172.19.1.10.

ip route show
# Exibe a tabela de rotas atualizada.

ip route del 10.10.20.0/24 via 172.19.1.10 dev eth1
# Remove a rota estatica adicionada.

# --- Rota padrao / gateway (add -> show -> del) ---
ip route add default via 192.168.50.100
# Define uma rota padrao (gateway) temporaria.

ip route show default
# Mostra a rota padrao ativa.

ip route del default via 192.168.50.100
# Remove a rota padrao adicionada.

# --- Tabela ARP / vizinhos (add -> show -> del) ---
ip neigh add 192.168.1.80 lladdr 02:11:22:33:44:66 dev wlo1 nud permanent
# Registra um mapeamento IP -> MAC fixo na tabela ARP.

ip neigh show dev wlo1
# Exibe as entradas ARP da interface.

ip neigh del 192.168.1.80 dev wlo1
# Remove a entrada ARP de teste.

# --- Cache DNS (query -> flush -> statistics) ---
resolvectl query google.com
# Faz uma consulta DNS para popular ou testar o cache.

resolvectl flush-caches
# Limpa o cache DNS local para comparar respostas antes e depois.

resolvectl statistics
# Mostra metricas de cache, consultas e respostas do DNS.