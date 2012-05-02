require 'date'

task :link do
  # link the dot files and the files which under dot directories
  Dir['{_*/**/*,_*}'].each do |fn|
    next if File.directory? fn
    dot_fn = fn.gsub(/(^_|\/_)/, '/.')
    sh "mkdir -p ~/#{File.dirname(dot_fn)}"
    sh "ln -f #{fn} ~/#{dot_fn}"
  end
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

  task :ubuntu do
    tools = %w{ 
      vim-gnome chromium-browser firefox putty-tools
      build-essential openssl libreadline6 libreadline6-dev 
      curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev 
      libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev 
      libxslt-dev autoconf libc6-dev ncurses-dev automake 
      libtool bison subversion
    }
    sh "sudo apt-get install #{tools * ' '}"
  end

  task :ruby do
    sh "curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer > /tmp/rvm-installer"
    sh "bash /tmp/rvm-installer"
    sh "rvm reload"
    sh "rvm install 1.9.2"
    sh "rvm use 1.9.2"
    sh "gem install bundler"
  end
end
