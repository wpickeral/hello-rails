Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "articles#index" # Defines the root path route ("/")
  # get "/articles", to: "articles#index"
  # get "/articles/:id", to: "articles#show"

  resources :articles

end
