#!/usr/bin/env bash
set -euo pipefail

# Ativa modo debug se DEBUG=1
[[ "${DEBUG:-0}" == "1" ]] && set -x

BASE_MODEL=tessdata_best/por.traineddata
CHECKPOINT=models/por_custom_checkpoint
OUTPUT=models/por_custom

for f in "$BASE_MODEL" models/list.train models/list.eval "$CHECKPOINT"; do
  [[ -e "$f" ]] || { echo "ERRO: arquivo $f inexistente" >&2; exit 1; }
done

echo ">> Fine-tuning (10 iterações)…"
lstmtraining \
  --model_output "$CHECKPOINT" \
  --traineddata "$BASE_MODEL" \
  --continue_from "$CHECKPOINT" \
  --train_listfile models/list.train \
  --eval_listfile  models/list.eval \
  --max_iterations 10

echo ">> Parando treinamento e gerando modelo final…"
lstmtraining \
  --stop_training \
  --continue_from "$CHECKPOINT" \
  --traineddata "$BASE_MODEL" \
  --model_output "$OUTPUT"


echo "✅ Fine-tuning concluído, modelo em models/por_custom.traineddata"


