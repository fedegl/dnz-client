require File.expand_path(File.dirname(__FILE__) + '/../lib/dnz')
require 'spec/matchers'
require 'rubygems'

include Spec::Matchers

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

Spec::Runner.configure do |config|
   
end