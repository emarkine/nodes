module Nodes
  class Engine < ::Rails::Engine
    isolate_namespace Nodes
    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end
    initializer 'nodes.assets.precompile' do |app|
      app.config.assets.precompile +=
          %w( nodes/nodes.coffee nodes/nodes.scss nodes/favicon.ico
            nodes/create.png nodes/save.png)
    end
  end
end
