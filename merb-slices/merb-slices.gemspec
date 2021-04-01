#!/usr/bin/env gem build
# -*- encoding: utf-8 -*-

# Assume a typical dev checkout to fetch the current merb-core version
require File.expand_path('../../merb-core/lib/merb-core/version', __FILE__)

# Load this library's version information
require File.expand_path('../lib/merb-slices/version', __FILE__)

require 'date'

Gem::Specification.new do |gem|
  gem.name        = 'merb-slices'
  gem.version     = Merb::Slices::VERSION.dup
  gem.date        = Date.today.to_s
  gem.authors     = ['Fabien Franzen']
  gem.email       = 'info@fabien.be'
  gem.homepage    = 'http://merbivore.com/'
  gem.description = "Merb plugin that supports reusable application 'slices'."
  gem.summary     = "Merb plugin for using and creating application 'slices' which help you modularize your application."

  gem.require_paths = ['lib']
  gem.extra_rdoc_files = ['README', 'LICENSE', 'TODO']
  gem.files = Dir['Generators', 'Rakefile', '{bin,lib,spec}/**/*', 'README*', 'LICENSE*', 'TODO*'] & `git ls-files -z`.split("\0")

  # Runtime dependencies
  gem.add_dependency 'merb-core', "~> #{Merb::VERSION}"

  # Development dependencies
  gem.add_development_dependency 'rspec', '>= 1.2.9'

  # Executable files
  gem.executables = 'slice'
end
