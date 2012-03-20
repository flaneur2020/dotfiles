

task :link do
  Dir['_*'].each do |fn|
    dot_fn = fn.gsub(/^_/, '~/.')
    sh "ln -f #{fn} #{dot_fn}"
  end
end
