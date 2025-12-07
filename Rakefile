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
  # link this dir to ~/.dotfiles
  sh "ln -nfs #{pwd} ~/.dotfiles"
end

task :chmod => :link do
  sh "chmod 755 ~/.dotfiles/scripts/*"
end

namespace :bs do
  task :vim do
    sh 'ln -s ~/.vimrc ~/.config/nvim/init.lua'
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
end
