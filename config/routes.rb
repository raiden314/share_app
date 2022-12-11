Rails.application.routes.draw do
  get "/posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"
  get "login" => "users#login_form"
  post "login" => "users#login"
  get "logout" => "users#logout"
  get "users/:id/gid/destroy" => "users#g_destroy"
  post "users/:id/update" =>"users#update"
  get "users/:id/edit" => "users#edit"
  get "users/:id/gnew" => "users#gnew"
  post "users/:id/gcreate" => "users#gcreate"
  post "users/create" => "users#create"
  get "signup" => "users#new"
  get 'users/index'
  post "users/:id/destroy" => "users#destroy"
  get "/" => "home#top"
  get "users/:id" => "users#show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
