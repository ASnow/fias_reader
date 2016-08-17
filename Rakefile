require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
spec = Gem::Specification.find_by_name 'fias'
load "#{spec.gem_dir}/tasks/build.rake"

task default: :spec
