# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'instabot'

Gem::Specification.new do |spec|
  spec.name          = 'instabot'
  spec.version       = Instabot::VERSION
  spec.authors       = ['eVanilla']
  spec.email         = ['']

  spec.summary       = 'Ruby instagram bot'
  spec.description   = 'A instagram bot works without instagram api, only needs your username and password'
  spec.homepage      = 'https://github.com/eVanilla/instabot.rb'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*.rb']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake',    '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.51.0'

  spec.add_dependency 'activesupport', '~> 5.1', '>= 5.1.4'
  spec.add_dependency 'colorize', '~> 0.8.1'
  spec.add_dependency 'hashie', '~> 3.5', '>= 3.5.6'
  spec.add_dependency 'mechanize', '~> 2.7', '>= 2.7.5'
end
