# ocr_training
 (cd "$(git rev-parse --show-toplevel)" && git apply --3way <<'EOF' 
diff --git a/README.md b/README.md
index 1f8e5171193814dd22440f8b21980f9e9c80efb6..bcff780f64c2ed397d1839a086f313fa739e0d93 100644
--- a/README.md
+++ b/README.md
@@ -1 +1,27 @@
 # ocr_training
+
+Scripts para treinamento de modelos OCR com Tesseract.
+
+## Requisitos
+Execute `./setup.sh` para instalar automaticamente as dependências necessárias (Tesseract com ferramentas de treino, fontconfig, ImageMagick etc.).
+
+## Uso
+As principais etapas podem ser executadas via `make`:
+
+```
+make setup      # instala dependências
+make generate   # gera imagens a partir das fontes
+make fin        # normaliza e gera arquivos lstmf
+make buildlist  # cria listas de treino/validação
+make train      # realiza o fine-tuning
+make eval       # avalia o modelo e salva log em models/
+```
+
+Para testar o OCR em uma imagem específica:
+
+```
+make test IMG=/caminho/da_imagem.png
+```
+
+Defina `DEBUG=1` para ativar modo verboso em qualquer script.
+
 
EOF
)
