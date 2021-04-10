require 'pp'
require 'yaml'
require 'date'

task :default => [:link, :chmod]

task :link do
  pwd = File.dirname(__FILE__)
  # link the dot files and the files which under dot directories
  Dir['_*'].each do |fn|
    dot_fn = fn.gsub(/^_/, '.')
    sh "ln -nfs #{pwd}/#{fn} ~/#{dot_fn}"
  end
  # link the misc files, according to the map.yml file
  map_fn = 'misc/map.yml'
  YAML::load_file(map_fn).each do |fn, target|
    sh "mkdir -p #{File.dirname(target)}"
    sh "ln -nfs #{pwd}/misc/#{fn} #{target}"
  end
  #
  sh "ln -nfs #{pwd} ~/.dotfiles"
end

task :chmod => :link do
  sh "chmod 755 ~/.dotfiles/scripts/*"
end

task :push do
  sh "git commit -am ':trollface: updated at #{DateTime.now}'; true"
  sh "git push origin master"
end

namespace :bs do
  task :vim do
    sh 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    sh 'ln -s ~/.vimrc .config/nvim/init.vim'
    sh 'vim +PlugInstall +qall'
  end

  task :zsh do
    sh 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'
    sh 'git clone https://github.com/agkozak/zsh-z ~/.oh-my-zsh/plugins/zsh-z'
  end

  task :ubuntu do
    packages = %w{
      build-essential openssl curl git-core
    }
    sh "sudo apt-get install #{packages * ' '}"
  end

  task :rbenv do
    sh "git clone https://github.com/sstephenson/rbenv.git ~/.rbenv || true"
    sh "git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build || true"
    sh "git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash || true"
    sh "rbenv install 2.1.0"
    sh "rbenv rehash"
  end

  task :py do
    sh "curl -kL http://xrl.us/pythonbrewinstall | bash"
    sh "pyvm install 3.2"
    sh "pyvm use 3.2"
  end
end
