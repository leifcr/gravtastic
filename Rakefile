require "bundler/gem_tasks"
require 'rake/clean'
require 'rspec/core/rake_task'

def name
  @name ||= File.basename(Dir['*.gemspec'].first, '.gemspec')
end

def gemspec_file
  "#{name}.gemspec"
end

load(gemspec_file)

RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ['--color', '--require ./spec/helper']
end

task :default => :spec

