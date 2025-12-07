#!/usr/bin/env bash

set -e  # Exit on error

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
        info "Linked: ${file} -> ~/.${file}"
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

    packages=(
        build-essential
        openssl
        curl
        git-core
        tig
        zsh
        neovim
    )

    sudo apt-get update
    sudo apt-get install -y "${packages[@]}"
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

detect_and_install_packages() {
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
    detect_and_install_packages

    # Core setup
    link_dotfiles

    # Shell and editor setup
    bootstrap_vim
    bootstrap_zsh


    info "Bootstrap completed!"
}

# Run main function
main
