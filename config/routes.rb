Onering::Application.routes.draw do
  resources :ip_blocks

  resources :worklogs

  resources :audits

  root :to => 'home#index'

  match 'search' => 'physical_hosts#search'
  
  resources :entity_schemas
  resources :dups, :only => :index
  resources :physical_racks
  resources :datacenters
  resources :physical_hosts do
    get :autocomplete_physical_host_name, :on => :collection
  end
end
