#!/usr/bin/env bash
set -euo pipefail

echo ">> 1/2 – Normalizando ground-truth"
for gt in data/train/*.gt.txt; do
  echo "   $gt"

  sed -i '1s/^\xEF\xBB\xBF//' "$gt"
  iconv -f utf-8 -t utf-8 "$gt" -o "$gt.tmp" && mv "$gt.tmp" "$gt"

  sed -i "
    s/[‘’]/'/g;
    s/[“”]/\"/g;
    s/[–—]/-/g;
    s/⅓/1\\/3/g;
    s/⅔/2\\/3/g;
    s/🚀//g;
    s/\xC2\xA0/ /g;
    s/\xE2\x80\xAF/ /g
  " "$gt"
done

echo ">> 2/2 – Gerando .lstmf"
find data/train -name '*.tif' | while read img; do
  tesseract "$img" "${img%.*}" --psm 6 lstm.train
done

echo "✅ .lstmf atualizados."



