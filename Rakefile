require "bundler/gem_tasks"
require "rake/clean"
require "rake/testtask"
require "fileutils"
task :default => :spec

Rake::TestTask.new(:test) do |t| 
    t.libs << "test"
    t.libs << "lib/tdl/examples"
    t.libs << "lib/tdl"
    t.pattern = "test/*_test.rb"
    # t.ruby_opts = ["-c"]
    t.verbose = true
end

task :old do 
    exec 'ruby -I"lib:test" -I"/home/wmy367/.rvm/gems/ruby-2.6.3/gems/rake-10.5.0/lib" "/home/wmy367/.rvm/gems/ruby-2.6.3/gems/rake-10.5.0/lib/rake/rake_test_loader.rb" "test/*_test.rb" '
end