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
    sh 'git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle; true'
    sh 'vim +BundleInstall +qall'
  end

  task :ubuntu_server do
    packages = %w{
      putty-tools ctags build-essential openssl libreadline6 libreadline6-dev
      curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0
      libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev
      ncurses-dev automake libtool bison subversion
    }
    sh "sudo apt-get install #{packages * ' '}"
  end

  task :ubuntu => [:ubuntu_server] do
    packages = %w{
      vim-gnome chromium-browser firefox libnotify-bin ubuntu-restricted-extras
    }
    sh "sudo apt-get install #{packages * ' '}"
  end

  task :rvm do
    sh "curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer > /tmp/rvm-installer"
    sh "bash /tmp/rvm-installer"
    sh "rvm reload"
    sh "rvm install 1.9.3"
    sh "rvm use 1.9.3"
    sh "gem install bundler"
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
