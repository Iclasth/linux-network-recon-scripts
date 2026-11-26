#!/bin/sh

# Script de laboratorio (alteracao temporaria de estado na pilha de rede).
# Execute apenas em VM ou ambiente isolado.

REPORT_DIR="reports"
mkdir -p "$REPORT_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUT_FILE="$REPORT_DIR/lab-vm-tests-${TIMESTAMP}.txt"

{
  echo "=========================================="
  echo "RELATORIO DE LABORATORIO DE REDE (VM)"
  echo "Data/Hora: $(date)"
  echo "Host: $(hostname)"
  echo "=========================================="
  echo ""
} > "$OUT_FILE"

# Executa um comando e registra no arquivo .txt
log_cmd() {
  DESC="$1"
  CMD="$2"

  {
    echo ">>> $DESC"
    echo "$ $CMD"
    sh -c "$CMD" 2>&1
    echo ""
  } >> "$OUT_FILE"
}

# --- 1. Endereco IP (add -> show -> del) ---
log_cmd "Adicionando IP secundario de teste" "ip addr add 192.168.50.5/24 dev eth1"
log_cmd "Conferindo IP aplicado" "ip addr show dev eth1"
log_cmd "Removendo IP secundario de teste" "ip addr del 192.168.50.5/24 dev eth1"

# --- 2. Estado da interface (up -> show -> down) ---
log_cmd "Habilitando interface eth1" "ip link set eth1 up"
log_cmd "Conferindo estado da interface" "ip link show dev eth1"
log_cmd "Desabilitando interface eth1" "ip link set eth1 down"

# --- 3. Rota estatica (add -> show -> del) ---
log_cmd "Adicionando rota estatica" "ip route add 10.10.20.0/24 via 172.19.1.10 dev eth1"
log_cmd "Conferindo tabela de rotas" "ip route show"
log_cmd "Removendo rota estatica" "ip route del 10.10.20.0/24 via 172.19.1.10 dev eth1"

# --- 4. Rota padrao / gateway (add -> show -> del) ---
log_cmd "Adicionando rota padrao temporaria" "ip route add default via 192.168.50.100"
log_cmd "Conferindo rota padrao" "ip route show default"
log_cmd "Removendo rota padrao temporaria" "ip route del default via 192.168.50.100"

# --- 5. Tabela ARP / vizinhos (add -> show -> del) ---
log_cmd "Adicionando entrada ARP estatica" "ip neigh add 192.168.1.80 lladdr 02:11:22:33:44:66 dev wlo1 nud permanent"
log_cmd "Conferindo tabela ARP" "ip neigh show dev wlo1"
log_cmd "Removendo entrada ARP de teste" "ip neigh del 192.168.1.80 dev wlo1"

# --- 6. Cache DNS (query -> flush -> statistics) ---
log_cmd "Consultando dominio antes da limpeza" "resolvectl query google.com"
log_cmd "Limpando cache DNS local" "resolvectl flush-caches"
log_cmd "Conferindo estatisticas de cache" "resolvectl statistics"

echo "Log do laboratorio salvo em: $OUT_FILE"