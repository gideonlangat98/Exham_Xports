Rails.application.routes.draw do
  resources :buyer_foams
  resources :supplies
  resources :suppliers
  resources :brokers
  resources :buyers

  resources :buyers do
    member do 
      get 'buyer_foams', to: 'buyers#buyer_foams'
   end
  end

  resources :suppliers do
    member do 
      get 'supplies', to: 'suppliers#supplies'
   end
  end

  post "/suppliers", to: "suppliers#create"
  post "/buyers", to: "buyers#create"
  post "/brokers", to: "brokers#create"
  post "/login", to: "sessions#create"

  
    post "/signup/supplier", to: "suppliers#create"
    post "/signup/buyer", to: "buyers#create"
    post "/signup/broker", to: "brokers#create"

  delete "/logout", to: "sessions#destroy"

  get "/me", to: "suppliers#show"
  get "/mi", to: "buyers#show"
  get "/mu", to: "brokers#show"


 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
