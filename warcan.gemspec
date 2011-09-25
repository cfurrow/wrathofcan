Gem::Specification.new do |s|
  s.name        = "warcan"
  s.version     = WarCan::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Carl Furrow"]
  s.email       = ["me@carlfurrow.com"]
  s.homepage    = "https://github.com/cfurrow/warcan"
  s.summary     = "CanCan like authorization platform for Warden/Sinatra"

  s.add_development_dependency("pry")
  s.add_development_dependency("rspec")
  s.add_development_dependency("rake")
end
