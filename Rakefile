# require "bundler/gem_tasks"
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
    # t.verbose = true
end

desc "编译TB"
task :tb do 
    require_relative "./lib/axi_tdl.rb"
    puts AxiTdl::VERSION
    require_relative "./lib/axi/techbench/tb_axi_stream_split_channel.rb"
end
