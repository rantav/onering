Onering::Application.routes.draw do

  match 'search' => 'physical_hosts#search'
  
  resources :physical_racks
  resources :datacenters
  resources :physical_hosts do
    get :autocomplete_physical_host_name, :on => :collection
  end

  root :to => 'high_voltage/pages#show', :id => 'home'

end
