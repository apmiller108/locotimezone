# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'locotimezone/version'

Gem::Specification.new do |spec|
  spec.name          = 'locotimezone'
  spec.version       = Locotimezone::VERSION
  spec.authors       = ['Alex Miller']
  spec.email         = ['apmiller108@yahoo.com']

  spec.summary       = %q{Get timezone and gelocation data for a street address.}
  spec.description   = %q{Transform a street address into geoloction and timezone data.}
  spec.homepage      = 'https://github.com/apmiller108/locotimezone'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.2.1'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = ['locotimezone']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_development_dependency 'pry', '~> 0.10.4'
end
