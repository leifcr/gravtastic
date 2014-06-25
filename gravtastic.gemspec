require './lib/gravtastic/version'

@spec = Gem::Specification.new do |s|
  s.name    = 'leifcr-gravtastic'
  s.version = Gravtastic.version
  s.date    = '2014-06-25'

  s.author   = 'Leif Ringstad'
  s.email    = 'leifcr@gmail.com'
  s.homepage = 'http://github.com/leifcr/gravtastic'

  s.summary     = 'A Ruby wrapper for Gravatar URLs'
  s.description = s.summary

  s.rubyforge_project = 'gravtastic'

  s.has_rdoc = false

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 3.0.0'
  s.add_development_dependency 'rr', '~> 1.0'

  s.require_path = 'lib'
  s.files        = %w(README.md Rakefile Gemfile) + Dir['{lib,spec,vendor}/**/*']
end
