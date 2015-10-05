# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'packet/version'

Gem::Specification.new do |spec|
  spec.name          = 'packet'
  spec.version       = Packet::VERSION
  spec.authors       = ['Jake Bell', 'Emiliano Jankowski']
  spec.email         = %w(jake@theunraveler.com emiliano@packet.net)

  spec.summary       = %q{Ruby client for the Packet API}
  spec.description   = %q{Ruby client for the Packet API}
  spec.homepage      = 'https://github.com/packethost/packet-rb'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = %w(lib)
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }

  spec.add_dependency 'activesupport', '~> 4.2'
  spec.add_dependency 'faraday', '>= 0.9.0'
  spec.add_dependency 'her'
  spec.add_dependency 'faraday_middleware', '>= 0.9.0'
  spec.add_dependency 'globalid'

  spec.add_development_dependency 'rake', '~> 0'
  spec.add_development_dependency 'rspec', '~> 3'
  spec.add_development_dependency 'webmock', '~> 1.20'
  spec.add_development_dependency 'rdoc', '~> 4'
  spec.add_development_dependency 'bundler', '~> 1.0'
  spec.add_development_dependency 'jeweler', '~> 2.0.1'
  spec.add_development_dependency 'simplecov', '~> 0'
  spec.add_development_dependency 'rubocop', '~> 0'
  spec.add_development_dependency 'sinatra', '~> 1.4'
  spec.add_development_dependency 'activesupport', '~> 4.2'
end
