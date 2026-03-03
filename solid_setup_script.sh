#!/usr/bin/env bash
set -euo pipefail

LOG_FILE="$HOME/bootstrap.log"

exec > >(tee -a "$LOG_FILE") 2>&1

echo "=== Starting Ubuntu bootstrap ==="

# ------------------------------------------------------------------
# Safety: Prevent running as root
# ------------------------------------------------------------------
if [ "$EUID" -eq 0 ]; then
  echo "❌ Do NOT run this script with sudo."
  exit 1
fi

# ------------------------------------------------------------------
# Remove unwanted default packages
# ------------------------------------------------------------------
echo "Removing unwanted packages..."

sudo apt remove --purge -y \
  thunderbird \
  rhythmbox \
  libreoffice-core \
  shotwell \
  cheese \
  remmina \
  aisleriot \
  gnome-mahjongg \
  gnome-mines \
  gnome-calendar || true

sudo apt autoremove -y

# ------------------------------------------------------------------
# Update system
# ------------------------------------------------------------------
echo "Updating system..."
sudo apt update
sudo apt upgrade -y

# ------------------------------------------------------------------
# Install system dependencies
# ------------------------------------------------------------------
echo "Installing system packages..."

sudo apt install -y \
  git \
  curl \
  npm \
  nodejs \
  zsh \
  python3 \
  python3-pip \
  python3-pynvim \
  ninja-build \
  gettext \
  libtool \
  libtool-bin \
  autoconf \
  automake \
  cmake \
  g++ \
  pkg-config \
  unzip \
  build-essential

# ------------------------------------------------------------------
# Install Nerd Fonts (system-wide)
# ------------------------------------------------------------------
echo "Installing Nerd Fonts..."

TMP_FONT_DIR="$HOME/.tmp_fonts"
mkdir -p "$TMP_FONT_DIR"
cd "$TMP_FONT_DIR"

FONT_URL_BASE="https://github.com/ryanoasis/nerd-fonts/releases/latest/download"

for font in SourceCodePro Hack NerdFontsSymbolsOnly UbuntuMono; do
  if [ ! -f "${font}.zip" ]; then
    curl -LO "$FONT_URL_BASE/${font}.zip"
  fi
  sudo unzip -o "${font}.zip" -d /usr/share/fonts/
done

sudo fc-cache -f -v

cd "$HOME"
rm -rf "$TMP_FONT_DIR"

# ------------------------------------------------------------------
# Build and Install Neovim (from source)
# ------------------------------------------------------------------
echo "Installing Neovim..."

if [ ! -d "$HOME/neovim" ]; then
  git clone https://github.com/neovim/neovim "$HOME/neovim"
fi

cd "$HOME/neovim"
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd "$HOME"

# ------------------------------------------------------------------
# Clone Dotfiles
# ------------------------------------------------------------------
echo "Cloning dotfiles..."

if [ ! -d "$HOME/dot-files" ]; then
  git clone https://github.com/unfirthman/dot-files "$HOME/dot-files"
fi

# ------------------------------------------------------------------
# Install Oh My Zsh (user-level)
# ------------------------------------------------------------------
echo "Installing Oh My Zsh..."

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# ------------------------------------------------------------------
# Final Cleanup
# ------------------------------------------------------------------
sudo apt autoremove -y
sudo apt update

echo "=== Bootstrap Complete ==="
