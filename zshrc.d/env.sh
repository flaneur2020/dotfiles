export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export EDITOR=vim
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color

export PATH=/usr/local/bin:/opt/homebrew/bin:$PATH
export PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH
export PATH=$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH
export PATH=$HOME/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"

export GOPATH=$HOME/go
export GOROOT_BOOTSTRAP=$GOROOT
export PATH=$GOPATH/bin:/usr/local/opt/go/libexec/bin:$PATH

# alias sudo="sudo env PATH=$PATH"
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/
export WASMER_DIR="$HOME/.wasmer"
export JAVA_HOME=$(/usr/libexec/java_home)
export GOPROXY=https://goproxy.io,direct
export GOPRIVATE=*.zhenguanyu.com
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

# eval "$(rbenv init - zsh)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PYENV_VERSION='3.13.3'
export RBENV_VERSION=2.3.0
export PIPENV_VENV_IN_PROJECT=1
export HOMEBREW_NO_AUTO_UPDATE=1
export GOPROXY=https://goproxy.cn,direct
export VCPKG_ROOT="$HOME/vcpkg"
