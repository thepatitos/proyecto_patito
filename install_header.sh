#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_SRC="$SCRIPT_DIR/patito_header.vim"

if [ ! -f "$PLUGIN_SRC" ]; then
    echo "[ERROR] No se encuentra patito_header.vim en $SCRIPT_DIR"
    exit 1
fi

INSTALLED=0

if command -v vim >/dev/null 2>&1; then
    mkdir -p "$HOME/.vim/plugin"
    cp "$PLUGIN_SRC" "$HOME/.vim/plugin/patito_header.vim"
    echo "[OK] Cabecera Patito instalada para Vim en ~/.vim/plugin/patito_header.vim"
    INSTALLED=1
fi

if command -v nvim >/dev/null 2>&1; then
    mkdir -p "$HOME/.config/nvim/plugin"
    cp "$PLUGIN_SRC" "$HOME/.config/nvim/plugin/patito_header.vim"
    echo "[OK] Cabecera Patito instalada para Neovim en ~/.config/nvim/plugin/patito_header.vim"
    INSTALLED=1
fi

if [ "$INSTALLED" -eq 0 ]; then
    mkdir -p "$HOME/.vim/plugin"
    cp "$PLUGIN_SRC" "$HOME/.vim/plugin/patito_header.vim"
    echo "[AVISO] No se detecto vim ni nvim instalados; copiado por defecto en ~/.vim/plugin/"
fi

echo "Listo: abre cualquier archivo .c y pulsa F1 o ejecuta :Stdheader"
