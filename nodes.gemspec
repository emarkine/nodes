$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nodes/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'nodes'
  s.version     = Nodes::VERSION
  s.authors     = ['Eugene Markine']
  s.email       = ['emarkine@gmail.com']
  s.homepage    = 'https://github.com/emarkine/db-model'
  s.summary     = 'Nodes Editor'
  s.description = 'Lightweight editor of text nodes'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.1.1'
  s.add_dependency 'sass-rails'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'haml-rails'
  s.add_dependency 'therubyracer'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'faker'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'watir-rspec'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'sqlite3'

  s.add_dependency 'db-model', '~> 0.1.6'

  s.test_files = Dir['spec/**/*']
end
