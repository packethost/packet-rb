# encoding: utf-8

require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end

require 'rake'
require 'jeweler'
require './lib/packet/version.rb'
Jeweler::Tasks.new do |gem|
  gem.name = 'packethost'
  gem.homepage = 'http://github.com/packethost/packet-rb'
  gem.license = 'GPL-2.0'
  gem.summary = 'Ruby client for the Packet API'
  gem.description = 'Ruby client for the Packet API'
  gem.email = %w(jake@packet.net emiliano@packet.net andy@packet.net)
  gem.authors = ['Jake Bell', 'Emiliano Jankowski', 'Andrew Hodges']
  gem.version = Packet::VERSION
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new

desc 'Run the CI suite'
task ci: [:spec, :rubocop]

task default: :ci

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ''

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "packet #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
