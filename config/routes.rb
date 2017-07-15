Nodes::Engine.routes.draw do
  resources :nodes
  # root to: 'nodes#index'
  # mount Nodes::Engine => '/'
  get '/node/sort/:field' => 'nodes#sort'
end
