#!/bin/bash

# --- 1. Detectar Helper do AUR ---
if command -v paru &> /dev/null; then
    AUR_HELPER="paru"
elif command -v yay &> /dev/null; then
    AUR_HELPER="yay"
else
    echo "Instalando yay..."
    sudo pacman -S --needed --noconfirm yay
    AUR_HELPER="yay"
fi

# --- 2. Pacotes Nativos (Pacman) ---
PKGS_NATIVE="niri waybar wofi mako polkit-gnome alacritty starship git bat ttf-jetbrains-mono-nerd"

# --- 3. Pacotes AUR ---
PKGS_AUR="wlogout nwg-look xwaylandvideobridge"

echo "=== 🚀 Iniciando Setup Automatizado Niri (Corrigido) ==="

echo "📦 Verificando pacotes nativos..."
sudo pacman -Syu --needed --noconfirm $PKGS_NATIVE

if [ -n "$PKGS_AUR" ]; then
    echo "📦 Verificando pacotes AUR..."
    # O yay/paru resolvem dependências do AUR e oficiais misturadas
    $AUR_HELPER -S --needed --noconfirm $PKGS_AUR
fi

# --- 4. Configuração Final ---
CURRENT_SHELL=$(basename "$SHELL")
if [ "$CURRENT_SHELL" != "zsh" ] && command -v zsh &> /dev/null; then
    echo "🐚 Mudando shell para Zsh..."
    chsh -s $(which zsh)
fi

echo "✅ Setup Finalizado!"