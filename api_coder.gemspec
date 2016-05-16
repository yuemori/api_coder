# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'api_coder/version'

Gem::Specification.new do |spec|
  spec.name          = 'api_coder'
  spec.version       = APICoder::VERSION
  spec.authors       = ['yuemori']
  spec.email         = ['yuemori@aiming-inc.com']

  spec.summary       = 'API Coder'
  spec.description   = 'API definition by code'
  spec.homepage      = 'https://github.com/yuemori/api_coder'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_development_dependency 'bundler', '>= 1.11.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'shoulda-matchers'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-rubocop'
end
