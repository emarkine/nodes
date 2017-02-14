$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nodes/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nodes"
  s.version     = Nodes::VERSION
  s.authors     = ["Eugene Markine"]
  s.email       = ["emarkine@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Nodes."
  s.description = "TODO: Description of Nodes."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.1"

  s.add_development_dependency "sqlite3"
end
