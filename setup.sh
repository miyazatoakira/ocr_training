#!/usr/bin/env bash

set -euo pipefail

install_package() {
  if ! dpkg -s "$1" >/dev/null 2>&1; then
    apt-get install -y "$1"
  fi
}

apt-get update

install_package tesseract-ocr
install_package tesseract-ocr-por
install_package tesseract-ocr-script-latin
install_package tesseract-ocr-dev
install_package libleptonica-dev
install_package make
install_package build-essential
install_package fontconfig
install_package imagemagick


fc-cache -fv fonts/ || true

echo "Setup concluido."
