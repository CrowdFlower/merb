#!/usr/bin/env gem build
# -*- encoding: utf-8 -*-

# Assume a typical dev checkout to fetch the current merb-core version
require File.expand_path('../../merb-core/lib/merb-core/version', __FILE__)

# Load this library's version information
require File.expand_path('../lib/merb-mailer/version', __FILE__)

require 'date'

Gem::Specification.new do |gem|
  gem.name        = 'merb-mailer'
  gem.version     = Merb::Mailer::VERSION.dup
  gem.date        = Date.today.to_s
  gem.authors     = ['Yehuda Katz']
  gem.email       = 'ykatz@engineyard.com'
  gem.homepage    = 'http://merbivore.com/'
  gem.description = 'Merb plugin for mailer support'
  gem.summary     = 'Merb plugin that provides mailer functionality to Merb'

  gem.require_paths = ['lib']
  gem.extra_rdoc_files = ['README.textile', 'LICENSE', 'TODO']
  gem.files = Dir['Generators', 'Rakefile', '{lib,spec}/**/*', 'README*', 'LICENSE*', 'TODO*'] & `git ls-files -z`.split("\0")

  # Runtime dependencies
  gem.add_dependency 'merb-core', "~> #{Merb::VERSION}"
  gem.add_dependency('mailfactory', '>= 1.2.3')

  # Development dependencies
  gem.add_development_dependency 'rspec', '>= 1.2.9'
end
