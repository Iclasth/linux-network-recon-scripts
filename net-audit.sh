#!/bin/sh

# Diretorio de saida para relatorios locais
REPORT_DIR="reports"
mkdir -p "$REPORT_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUT_FILE="$REPORT_DIR/net-audit-${TIMESTAMP}.txt"

# Cabecalho inicial do relatorio (sobrescreve se o arquivo ja existir)
{
  echo "=========================================="
  echo "RELATORIO DE AUDITORIA DE REDE (SOMENTE LEITURA)"
  echo "Data/Hora: $(date)"
  echo "Host: $(hostname)"
  echo "=========================================="
  echo ""
} > "$OUT_FILE"

# Funcao auxiliar para registrar cada comando e sua saida
run_section() {
  TITLE="$1"
  CMD="$2"

  {
    echo "--- $TITLE ($CMD) ---"
    sh -c "$CMD" 2>&1
    echo ""
  } >> "$OUT_FILE"
}

run_section "Interfaces e IPs" "ip -br addr"
run_section "Camada de Enlace" "ip link show"
run_section "Rotas e Gateway" "ip route show"
run_section "Tabela ARP/Vizinhos" "ip neigh show"
run_section "Status DNS" "resolvectl status"
run_section "Consulta DNS" "resolvectl query google.com"
run_section "Portas e Sockets" "ss -tulnp"

echo "Relatorio salvo em: $OUT_FILE"