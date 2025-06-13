 # ocr_training
Scripts para treinamento de modelos OCR com Tesseract.

## Requisitos
Execute `./setup.sh` para instalar automaticamente as dependências necessárias (Tesseract com ferramentas de treino, fontconfig, ImageMagick etc.).

## Uso
As principais etapas podem ser executadas via `make`:

```
make setup      # instala dependências
make generate   # gera imagens a partir das fontes
make fin        # normaliza e gera arquivos lstmf
make buildlist  # cria listas de treino/validação
make train      # realiza o fine-tuning
make eval       # avalia o modelo e salva log em models/
```

Para testar o OCR em uma imagem específica:

```
make test IMG=/caminho/da_imagem.png
```

Defina `DEBUG=1` para ativar modo verboso em qualquer script.
