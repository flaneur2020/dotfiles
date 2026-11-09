#!/usr/bin/env bash

set -e  # Exit on error

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ============================================================================
# Utility Functions
# ============================================================================

info() {
    echo -e "${GREEN}==>${NC} $1"
}

warn() {
    echo -e "${YELLOW}Warning:${NC} $1"
}

# ============================================================================
# Core Functions
# ============================================================================

link_dotfiles() {
    info "Linking dotfiles..."

    # Explicit list of dotfiles to link
    local files=(
        "gitconfig"
        "gitignore"
        "vimrc"
        "zshrc"
        "zshrc.d"
    )

    # Link each dotfile
    for file in "${files[@]}"; do
        ln -nfs "${DOTFILES_DIR}/${file}" "$HOME/.${file}"
        info "Linked: ${DOTFILES_DIR}/${file} -> ~/.${file}"
    done

    # Link dotfiles directory itself
    ln -nfs "$DOTFILES_DIR" "$HOME/.dotfiles"
    info "Linked: $(basename $DOTFILES_DIR) -> ~/.dotfiles"
}

bootstrap_vim() {
    info "Bootstrapping vim/neovim..."

    # Create neovim config directory
    mkdir -p "$HOME/.config/nvim"

    # Link vimrc to init.lua
    ln -sf "${DOTFILES_DIR}/vimrc" "$HOME/.config/nvim/init.lua"
    info "Linked: vimrc -> ~/.config/nvim/init.lua"

    # Check if neovim is installed
    if ! command -v nvim &> /dev/null; then
        warn "Neovim not installed, skipping plugin initialization"
        return
    fi

    # Initialize neovim to install lazy.nvim and plugins
    info "Initializing Neovim plugins (this may take a while)..."
    nvim --headless "+Lazy! sync" +qa
    info "Neovim plugins initialized"
}

bootstrap_ghostty() {
    info "Bootstrapping ghostty..."

    # Create ghostty config directory
    mkdir -p "$HOME/.config/ghostty"

    # Link ghosttyrc to config
    ln -sf "${DOTFILES_DIR}/ghosttyrc" "$HOME/.config/ghostty/config"
    info "Linked: ghosttyrc -> ~/.config/ghostty/config"
}

bootstrap_zed() {
    info "Bootstrapping Zed editor..."

    # Create zed config directory
    mkdir -p "$HOME/.config/zed"

    # Link keymap
    ln -nfs "${DOTFILES_DIR}/zedkeymap.json" "$HOME/.config/zed/keymap.json"
    info "Linked: zedkeymap.json -> ~/.config/zed/keymap.json"
}

bootstrap_rime() {
    info "Bootstrapping Rime input method..."

    # Rime user data dir differs by platform:
    #   macOS  (Squirrel):  ~/Library/Rime
    #   Linux  (fcitx5):    ~/.local/share/fcitx5/rime
    if [[ "$OSTYPE" == "darwin"* ]]; then
        local rime_dir="$HOME/Library/Rime"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        local rime_dir="$HOME/.local/share/fcitx5/rime"
    else
        warn "Unsupported OS for Rime: $OSTYPE, skipping"
        return
    fi

    # Create rime config directory
    mkdir -p "$rime_dir"

    # Link managed config files common to all platforms
    local rime_files=(
        "custom_phrase.txt"
        "default.custom.yaml"
        "luna_pinyin.custom.yaml"
        "rime.lua"
    )
    for file in "${rime_files[@]}"; do
        ln -sf "${DOTFILES_DIR}/rime/${file}" "${rime_dir}/${file}"
        info "Linked: rime/${file} -> ${rime_dir}/${file}"
    done

    # Squirrel (macOS) appearance/app-level options; not portable to other platforms
    if [[ "$OSTYPE" == "darwin"* ]]; then
        ln -sf "${DOTFILES_DIR}/rime/squirrel.custom.yaml" "${rime_dir}/squirrel.custom.yaml"
        info "Linked: rime/squirrel.custom.yaml -> ${rime_dir}/squirrel.custom.yaml"
    fi
}

bootstrap_zsh() {
    info "Bootstrapping zsh with oh-my-zsh..."

    # Install oh-my-zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        info "Installing oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
        info "oh-my-zsh installed"
    else
        warn "oh-my-zsh already installed, skipping"
    fi

    # Install zsh-z plugin
    if [ ! -d "$HOME/.oh-my-zsh/plugins/zsh-z" ]; then
        info "Installing zsh-z plugin..."
        git clone https://github.com/agkozak/zsh-z "$HOME/.oh-my-zsh/plugins/zsh-z"
        info "zsh-z plugin installed"
    else
        warn "zsh-z plugin already installed, skipping"
    fi
}

# ============================================================================
# OS-Specific Package Installation Functions
# ============================================================================

install_packages_ubuntu() {
    info "Installing Ubuntu/Debian packages..."

    sudo apt-get update
    sudo apt-get install -y \
        build-essential \
        openssl \
        curl \
        git-core \
        tig \
        zsh

    sudo snap install neovim --classic

    info "Ubuntu packages installed"
}

install_packages_macos() {
    info "Installing macOS packages via Homebrew..."

    if ! command -v brew &> /dev/null; then
        warn "Homebrew not found, skipping package installation"
        warn "Install Homebrew from: https://brew.sh"
        return
    fi

    packages=(
        openssl
        curl
        git
        tig
        zsh
        neovim
    )

    brew install "${packages[@]}"
    info "Homebrew packages installed"
}

# ============================================================================
# OS Detection and Dispatch
# ============================================================================

install_packages() {
    info "Detecting operating system..."

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        info "Detected: Linux"

        if command -v apt-get &> /dev/null; then
            install_packages_ubuntu
        else
            warn "Unsupported Linux distribution (only Ubuntu/Debian supported)"
        fi

    elif [[ "$OSTYPE" == "darwin"* ]]; then
        info "Detected: macOS"
        install_packages_macos

    else
        warn "Unsupported operating system: $OSTYPE"
        warn "Only macOS and Ubuntu/Debian are supported"
    fi
}

# ============================================================================
# Main Execution
# ============================================================================

main() {
    info "Starting dotfiles bootstrap..."

    # OS-specific package installation
    install_packages

    # Core setup
    link_dotfiles

    # Shell and editor setup
    bootstrap_vim
    bootstrap_ghostty
    bootstrap_zed
    bootstrap_rime
    bootstrap_zsh

    info "Bootstrap completed!"
}

# Run main function
main
