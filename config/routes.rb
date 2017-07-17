Nodes::Engine.routes.draw do
  resources :nodes
  root :to => 'nodes#index'
  get '/node/sort/:field' => 'nodes#sort'
end
