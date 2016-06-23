# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fias_reader/version'

Gem::Specification.new do |spec|
  spec.name          = 'fias_reader'
  spec.version       = FiasReader::VERSION
  spec.authors       = ["Андрей Большов"]
  spec.email         = ['asnow.dev@gmail.ru']

  spec.summary       = 'FIAS reader'
  spec.description   = 'FIAS reader'
  spec.homepage      = 'http://www.thefurnish.ru/'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'ox', '~> 2.4.1'
  spec.add_dependency 'activesupport', '~> 4.2.6'
  spec.add_dependency 'data_mapper'
  spec.add_dependency 'dm-sqlite-adapter'
  spec.add_dependency 'sqlite3'
  spec.add_dependency 'fias'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'ruby-prof'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'pry-stack_explorer'
end
