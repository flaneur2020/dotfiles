#!/bin/bash

# System & Locale
export EDITOR=vim
export TERM=xterm-256color
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# PATH
export PATH=$HOME/.local/bin:/usr/local/bin:/opt/homebrew/bin:$PATH
export PATH=$HOME/bin:$PATH

# Go
export GOPATH=$HOME/go
export GOROOT=/opt/homebrew/opt/go/libexec
export GOROOT_BOOTSTRAP=$GOROOT
export GOPROXY=https://goproxy.cn,direct
export GOPRIVATE=*.siliconflow.com,github.com/siliconflow/*
export PATH=$GOPATH/bin:$GOROOT/bin:/opt/homebrew/bin:$PATH

# Python
export PYENV_VERSION='3.13.3'
export PIPENV_VENV_IN_PROJECT=1
export PATH=$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH
[[ $(command -v pyenv) ]] && eval "$(pyenv init -)"
[[ $(command -v pyenv) ]] && eval "$(pyenv virtualenv-init -)"

# Ruby
export RBENV_VERSION=2.3.0
export PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH
# eval "$(rbenv init - zsh)"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Java
# export JAVA_HOME=$(/usr/libexec/java_home)

# C/C++ Build
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/
export VCPKG_ROOT="$HOME/vcpkg"

# Windsurf
export PATH="$HOME/.codeium/windsurf/bin:$PATH"

# Other Tools
export WASMER_DIR="$HOME/.wasmer"
export HOMEBREW_NO_AUTO_UPDATE=1
