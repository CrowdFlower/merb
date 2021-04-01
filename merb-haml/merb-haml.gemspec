#!/usr/bin/env gem build
# -*- encoding: utf-8 -*-

# Assume a typical dev checkout to fetch the current merb-core version
require File.expand_path('../../merb-core/lib/merb-core/version', __FILE__)

# Load this library's version information
require File.expand_path('../lib/merb-haml/version', __FILE__)

require 'date'

Gem::Specification.new do |gem|
  gem.name        = 'merb-haml'
  gem.version     = Merb::Haml::VERSION.dup
  gem.date        = Date.today.to_s
  gem.authors     = ['Yehuda Katz']
  gem.email       = 'ykatz@engineyard.com'
  gem.homepage    = 'http://merbivore.com/'
  gem.description = 'Merb plugin for HAML support'
  gem.summary     = 'Merb plugin that provides support for writing view template with HAML'

  gem.require_paths = ['lib']
  gem.extra_rdoc_files = ['README', 'LICENSE', 'TODO']
  gem.files = Dir['Generators', 'Rakefile', '{lib,spec}/**/*', 'README*', 'LICENSE*', 'TODO*'] & `git ls-files -z`.split("\0")

  # Runtime dependencies
  gem.add_dependency 'merb-core', "~> #{Merb::VERSION}"
  gem.add_dependency 'haml',      '>= 2.0.3'

  # Development dependencies
  gem.add_development_dependency 'rspec', '>= 1.2.9'
end
