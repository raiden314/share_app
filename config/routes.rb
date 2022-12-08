Rails.application.routes.draw do
  get 'posts/index'
  get "login" => "users#login_form"
  post "login" => "users#login"
  get "logout" => "users#logout"
  post "users/:id/update" =>"users#update"
  get "users/:id/edit" => "users#edit"
  post "users/create" => "users#create"
  get "signup" => "users#new"
  get 'users/index'
  get "/" => "home#top"
  get "users/:id" => "users#show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
