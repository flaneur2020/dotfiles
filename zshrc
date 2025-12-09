
#### FIG ENV VARIABLES ####
# Please make sure this block is at the start of this file.
[ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh
#### END FIG ENV VARIABLES ####
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
export ZSH="$HOME/.oh-my-zsh"

DISABLE_AUTO_UPDATE=true

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="fletcherm"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git golang gnu-utils zsh-z)

source $ZSH/oh-my-zsh.sh

[[ -s $HOME/.zshrc.d/env.sh ]] && source ~/.zshrc.d/env.sh
[[ -s $HOME/.zshrc.d/aliases.sh ]] && source ~/.zshrc.d/aliases.sh
[[ -s $HOME/.bash_profile.local ]] && source $HOME/.bash_profile.local

# eval "$(starship init zsh)"

# make tab more bash-like: https://serverfault.com/questions/109207/how-do-i-make-zsh-completion-act-more-like-bash-completion
setopt noautomenu
setopt nomenucomplete

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# make ctrl-left/right mv words back & forth
#bindkey '^[[1;5C' forward-word
# bindkey '^[[1;5D' backward-word

. "$HOME/.cargo/env"
. "$HOME/.local/bin/env"