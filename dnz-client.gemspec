# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dnz/version"

Gem::Specification.new do |s|
  s.name        = "dnz-client"
  s.version     = DNZ::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jeremy Wells", "Paul Flewelling"]
  s.email       = ["paul@boost.co.nz"]
  s.homepage    = ""
  s.summary     = %q{Ruby library for accessing Digital New Zealand's search API (digitalnz.org)}
  s.description = %q{Ruby library for accessing Digital New Zealand's search API (digitalnz.org)}

  s.rubyforge_project = "dnz-client"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency('activesupport', '>= 3.0.0')
  s.add_dependency('i18n', '>= 0.4.0')
  s.add_dependency('nokogiri', '>= 1.2.3')
  s.add_dependency('oauth', '>= 0.4.0')
  s.add_development_dependency('rspec', '>= 2.5.0')
end