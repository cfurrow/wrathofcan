# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "warcan/version"

Gem::Specification.new do |s|
  s.name        = "warcan"
  s.version     = WarCan::VERSION
  s.authors     = ["Carl Furrow"]
  s.email       = ["me@carlfurrow.com"]
  s.homepage    = "http://github.com/cfurrow/warcan"
  s.summary     = %q{CanCan like clone for Warden/Sinatra}

  s.rubyforge_project = "warcan"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_development_dependency "pry"
  # s.add_runtime_dependency "rest-client"
end
