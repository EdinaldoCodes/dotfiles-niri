#!/bin/bash

# --- 1. Detectar Helper do AUR (CachyOS traz paru ou yay) ---
if command -v paru &> /dev/null; then
    AUR_HELPER="paru"
elif command -v yay &> /dev/null; then
    AUR_HELPER="yay"
else
    echo "Instalando yay..."
    sudo pacman -S --needed --noconfirm yay
    AUR_HELPER="yay"
fi

# --- 2. Pacotes Essenciais (Nativo) ---
# Inclui Nerd Fonts para ícones funcionarem na Waybar
PKGS_NATIVE="niri waybar wofi mako xwaylandvideobridge polkit-gnome alacritty starship git bat ttf-jetbrains-mono-nerd"

# --- 3. Pacotes AUR ---
PKGS_AUR="wlogout-git nwg-look"

echo "=== 🚀 Iniciando Setup Automatizado Niri ==="

# Instala Nativos
echo "📦 Verificando pacotes nativos..."
sudo pacman -Syu --needed --noconfirm $PKGS_NATIVE

# Instala AUR
if [ -n "$PKGS_AUR" ]; then
    echo "📦 Verificando pacotes AUR..."
    $AUR_HELPER -S --needed --noconfirm $PKGS_AUR
fi

# --- 4. Troca de Shell (Opcional) ---
CURRENT_SHELL=$(basename "$SHELL")
if [ "$CURRENT_SHELL" != "zsh" ] && command -v zsh &> /dev/null; then
    echo "🐚 Mudando shell para Zsh..."
    chsh -s $(which zsh)
fi

echo "✅ Setup concluído!"
