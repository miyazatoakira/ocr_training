
#!/usr/bin/env bash
set -euo pipefail

[[ "${DEBUG:-0}" == "1" ]] && set -x

# Testa OCR em uma imagem usando o novo modelo.
if [[ $# -ne 1 ]]; then
  echo "Uso: $0 caminho/da_imagem.png" >&2
  exit 1
fi

IMG="$1"
if [[ ! -f "$IMG" ]]; then
  echo "ERRO: imagem '$IMG' nao encontrada" >&2
  exit 1
fi

command -v tesseract >/dev/null 2>&1 || { echo "ERRO: tesseract nao encontrado" >&2; exit 1; }

echo ">> OCR de $IMG usando por_custom:"
tesseract "$IMG" stdout -l por_custom --psm 6
