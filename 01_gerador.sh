#!/usr/bin/env bash
set -euo pipefail

# p/ modo debug se DEBUG=1
[[ "${DEBUG:-0}" == "1" ]] && set -x

mkdir -p data/train
fc-cache -fv fonts/

shopt -s nullglob
fonts=(fonts/*.ttf)
if (( ${#fonts[@]} == 0 )); then
  echo "ERRO: nenhuma fonte .ttf encontrada em fonts/" >&2
  exit 1
fi

for cmd in fc-query text2image; do
  command -v "$cmd" >/dev/null 2>&1 || { echo "ERRO: comando $cmd nao encontrado" >&2; exit 1; }
done

for f in "${fonts[@]}"; do
  fullname=$(fc-query --format='%{fullname}\n' "$f" | head -n1)
  safe_name=${fullname// /_}
  echo ">> Gerando com fonte: $fullname"
  text2image \
    --fonts_dir=fonts \
    --font="$fullname" \
    --text=corpus.txt \
    --outputbase="data/train/${safe_name}_printed"
done




