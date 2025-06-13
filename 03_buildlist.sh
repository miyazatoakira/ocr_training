# Builds training and evaluation lists for Tesseract
#!/usr/bin/env bash
set -euo pipefail

# Ativa modo debug se DEBUG=1
[[ "${DEBUG:-0}" == "1" ]] && set -x

mkdir -p models
train_list=models/list.train
eval_list=models/list.eval
:> "$train_list"
:> "$eval_list"

if [[ ! -d data/train ]]; then
  echo "ERRO: diretorio data/train inexistente" >&2
  exit 1
fi


shopt -s nullglob
files=(data/train/*.lstmf)
total=${#files[@]}

if (( total == 0 )); then
  echo "ERRO: nenhum .lstmf em data/train" >&2
  exit 1
fi


eval_count=$(( total / 5 ))
(( eval_count == 0 && total > 1 )) && eval_count=1
(( eval_count >= total )) && eval_count=$(( total - 1 ))

echo ">> Selecionando $eval_count de $total para validação..."
for ((i=0; i<total; i++)); do
  if (( i < eval_count )); then
    echo "${files[i]}" >> "$eval_list"
  else
    echo "${files[i]}" >> "$train_list"
  fi
done


if [[ ! -s "$eval_list" ]]; then
  echo "(!) Nenhuma página para avaliação – copiando treino."
  cp "$train_list" "$eval_list"
fi

echo "✔ list.train: $(wc -l < "$train_list") linhas"
echo "✔ list.eval : $(wc -l < "$eval_list") linhas"

