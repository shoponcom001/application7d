Rails.application.routes.draw do

 root to: "homes#top"
 get "/home/about" => "homes#about"
 devise_for :users
 resources :books
 resources :users, only: [:show, :edit, :update, :index]
 
 resources :users do
   member do
     get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]


end