# dotfiles

Personal dotfiles and bootstrap script.

I just realized that all i need is simply neovim, zsh, git, and nothing else in my dotfiles 🤔.

## Usage

```bash
./bootstrap.sh
```

This will:

- Link the dotfiles for zsh, git, neovim.
- Install packages (zsh, neovim, git, etc.)
- Setup Neovim with plugins
- Setup zsh with oh-my-zsh

## Files

- `_zshrc` → `~/.zshrc`
- `_zsh_env.sh` → `~/.zsh_env.sh`
- `_zsh_aliases.sh` → `~/.zsh_aliases.sh`
- `_vimrc` → `.vimrc` and `~/.config/nvim/init.lua`
- `_gitconfig` → `~/.gitconfig`
- `_gitignore` → `~/.gitignore`
