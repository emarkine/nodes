Rails.application.routes.draw do
  mount Nodes::Engine => '/nodes'
end
