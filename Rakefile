require 'fileutils'

task :default => :test

task :clean do
  files=Dir["**/*~"]
  puts "Removing #{files.size} Emacs temp file#{(files.size==1?'':'s')}"
  files.each do |tmp|
    FileUtils.rm tmp
  end

  puts "Removing built gem"
  `rm -f toast-*.gem`
end

task :test do
  exec "spec --color test/*.rb"
end

task :gem do
  `rm -f toast-*.gem`
  `gem build toast.gemspec`
end

task :install=>:gem do
  `gem install --force toast-*.gem`
end
