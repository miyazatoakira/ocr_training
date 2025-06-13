.PHONY: all setup generate fin buildlist train eval test

all: generate fin buildlist train eval

setup:
	./setup.sh

generate:
	./01_gerador.sh

fin:
	./02_fin.sh

buildlist:
	./03_buildlist.sh

train:
	./04_treino.sh

eval:
	./05_eval.sh

# Para testar OCR em uma imagem: make test IMG=imagem.png

test:
	@if [ -z "$(IMG)" ]; then \
		echo "ERRO: defina IMG=/caminho/imagem.png" >&2; exit 1; \
	fi
	./06_test_model.sh $(IMG)
