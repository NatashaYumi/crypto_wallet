Rails.application.routes.draw do
  resources :mining_types
  
  get 'welcome/index'
  get '/inicio', to: 'welcome#index'
  
  resources :coins

  root "welcome#index"
  # se quiser definir as rotas específicas para uma operação get
  #get '/coins', to: 'coins#index'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
