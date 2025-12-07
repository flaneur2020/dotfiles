# dotfiles

Personal dotfiles and bootstrap script.

I just realized that all i need is simply neovim, zsh, git, and nothing else in my dotfiles 🤔.

## Usage

```bash
./bootstrap.sh
```

This will:

- Link the dotfiles for zsh, git, neovim.
- Install packages (zsh, neovim, git, tig, etc.)
- Setup Neovim with plugins
- Setup zsh with oh-my-zsh

## Files

- `zshrc` → `~/.zshrc`
- `env.sh` → `~/.env.sh`
- `aliases.sh` → `~/.aliases.sh`
- `vimrc` → `~/.vimrc` and `~/.config/nvim/init.lua`
- `gitconfig` → `~/.gitconfig`
- `gitignore` → `~/.gitignore`
