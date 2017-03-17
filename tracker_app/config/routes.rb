Rails.application.routes.draw do
  resources :sightings do
    get :get_events, on: :collection
  end
  root 'animals#index'
  resources :animals
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
