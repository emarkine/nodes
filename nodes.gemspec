$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require 'nodes/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'nodes'
  s.version     = Nodes::VERSION
  s.authors     = ['Eugene Markine']
  s.email       = ['emarkine@gmail.com']
  s.homepage    = 'http://eugenelab.com'
  s.summary     = 'Nodes Editor'
  s.description = 'Nodes is lightweight editor of text nodes'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.0.1'

  s.add_development_dependency 'sqlite3'
end
