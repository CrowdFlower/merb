#!/usr/bin/env gem build
# -*- encoding: utf-8 -*-

# Assume a typical dev checkout to fetch the current merb-core version
require File.expand_path('../../merb-core/lib/merb-core/version', __FILE__)

# Load this library's version information
require File.expand_path('../lib/merb-helpers/version', __FILE__)

require 'date'

Gem::Specification.new do |gem|
  gem.name        = 'merb-helpers'
  gem.version     = Merb::Helpers::VERSION.dup
  gem.date        = Date.today.to_s
  gem.authors     = ['Michael D. Ivey']
  gem.email       = 'ivey@gweezlebur.com'
  gem.homepage    = 'http://merbivore.com/'
  gem.description = 'Merb plugin containing view helpers'
  gem.summary     = 'Merb plugin that provides helpers for writing HTML templates'

  gem.require_paths = ['lib']
  gem.extra_rdoc_files = ['README', 'LICENSE', 'TODO']
  gem.files = Dir['Rakefile', '{lib,spec}/**/*', 'README*', 'LICENSE*', 'TODO*'] & `git ls-files -z`.split("\0")

  # Runtime dependencies
  gem.add_dependency 'merb-core', "~> #{Merb::VERSION}"

  # Development dependencies
  gem.add_development_dependency 'rspec', '>= 1.2.9'
end
