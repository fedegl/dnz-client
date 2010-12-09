# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{dnz-client}
  s.version = "0.2.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeremy Wells", "Paul Flewelling"]
  s.date = %q{2010-11-29}
  s.description = %q{Ruby library for accessing Digital New Zealand's search API (digitalnz.org)}
  s.email = %q{jeremy@boost.co.nz}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "History.txt",
     "License.txt",
     "PostInstall.txt",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "dnz-client.gemspec",
     "lib/dnz.rb",
     "lib/dnz/attributes.rb",
     "lib/dnz/client.rb",
     "lib/dnz/custom_search.rb",
     "lib/dnz/error/invalid_api_key.rb",
     "lib/dnz/facet.rb",
     "lib/dnz/facet_array.rb",
     "lib/dnz/memoizable.rb",
     "lib/dnz/namespace_array.rb",
     "lib/dnz/record.rb",
     "lib/dnz/resource.rb",
     "lib/dnz/result.rb",
     "lib/dnz/results.rb",
     "lib/dnz/search.rb",
     "lib/dnz/user.rb",
     "spec/dnz/client_spec.rb",
     "spec/dnz/custom_search_spec.rb",
     "spec/dnz/facet_array_spec.rb",
     "spec/dnz/facet_spec.rb",
     "spec/dnz/record_spec.rb",
     "spec/dnz/resource_spec.rb",
     "spec/dnz/result_spec.rb",
     "spec/dnz/results_spec.rb",
     "spec/dnz/search_spec.rb",
     "spec/dnz/user_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "spec/support/hash.rb",
     "tasks/rspec.rake"
  ]
  s.homepage = %q{http://github.com/boost/dnz-client}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Ruby library for accessing Digital New Zealand's search API (digitalnz.org)}
  s.test_files = [
    "spec/dnz/client_spec.rb",
     "spec/dnz/custom_search_spec.rb",
     "spec/dnz/facet_array_spec.rb",
     "spec/dnz/facet_spec.rb",
     "spec/dnz/record_spec.rb",
     "spec/dnz/resource_spec.rb",
     "spec/dnz/result_spec.rb",
     "spec/dnz/results_spec.rb",
     "spec/dnz/search_spec.rb",
     "spec/dnz/user_spec.rb",
     "spec/spec_helper.rb",
     "spec/support/hash.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.0.2"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.2.3"])
      s.add_runtime_dependency(%q<oauth>, [">= 0.4.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.0.2"])
      s.add_dependency(%q<nokogiri>, [">= 1.2.3"])
      s.add_dependency(%q<oauth>, [">= 0.4.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.0.2"])
    s.add_dependency(%q<nokogiri>, [">= 1.2.3"])
    s.add_dependency(%q<oauth>, [">= 0.4.0"])
  end
end

