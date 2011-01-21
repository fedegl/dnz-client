require 'rubygems'
require './lib/dnz'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "dnz-client"
    gemspec.summary = "Ruby library for accessing Digital New Zealand's search API (digitalnz.org)"
    gemspec.description = "Ruby library for accessing Digital New Zealand's search API (digitalnz.org)"
    gemspec.email = "jeremy@boost.co.nz"
    gemspec.homepage = "http://github.com/boost/dnz-client"
    gemspec.authors = ["Jeremy Wells", "Paul Flewelling"]
    gemspec.extra_rdoc_files << 'README.rdoc'

    gemspec.add_dependency('activesupport', '>= 2.0.2')
    gemspec.add_dependency('nokogiri', '>= 1.2.3')
    gemspec.add_dependency('oauth', '>= 0.4.0')
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

Dir['tasks/**/*.rake'].each { |t| load t }