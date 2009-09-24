ActionController::Routing::Routes.draw do |map|
  map.resources :pieces
  map.resources :members

  map.root :controller => "pieces", :action => "index"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
