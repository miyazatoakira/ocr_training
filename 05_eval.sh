#!/usr/bin/env bash
set -euo pipefail

# Ativa modo debug se DEBUG=1
[[ "${DEBUG:-0}" == "1" ]] && set -x

MODEL=models/por_custom.traineddata
EVAL_LIST=models/list.eval

for f in "$MODEL" "$EVAL_LIST"; do
  [[ -e "$f" ]] || { echo "ERRO: arquivo $f inexistente" >&2; exit 1; }
done

LOG_DIR=models
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/eval_$(date +%Y%m%d_%H%M%S).log"

echo ">> Avaliando modelo customizado… (log: $LOG_FILE)"
lstmeval \
  --traineddata "$MODEL" \
  --model        "$MODEL" \
  --eval_listfile "$EVAL_LIST" | tee "$LOG_FILE"


