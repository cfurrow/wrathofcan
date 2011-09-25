# -*- encoding: utf-8 -*-
$:.push File.expand_path("lib", __FILE__)
require "warcan/version"

Gem::Specification.new do |s|
  s.name        = "warcan"
  s.version     = WarCan::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Carl Furrow"]
  s.email       = ["me@carlfurrow.com"]
  s.homepage    = "https://github.com/cfurrow/warcan"
  s.summary     = "CanCan like authorization platform for Warden/Sinatra"

  #s.rubyforge_project = "warcan"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency("pry")
  s.add_development_dependency("rspec")
  s.add_development_dependency("rake")
end

