Onering::Application.routes.draw do
  devise_for :admin_users
  root :to => 'home#index'
  resources :admin_users
  resources :settings do
    post :run_glu, :on => :collection
    post :run_chef, :on => :collection
  end
  resources :ip_blocks
  resources :worklogs
  resources :audits
  resources :entity_schemas
  resources :dups, :only => :index
  resources :physical_racks
  resources :datacenters
  match 'search' => 'physical_hosts#search'
  resources :physical_hosts do
    get :autocomplete_physical_host_name, :on => :collection
  end
end
