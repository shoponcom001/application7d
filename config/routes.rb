Rails.application.routes.draw do

 devise_for :users

  root to: "homes#top"
  get "home/about" => "homes#about"
  
  post "like/:id" => "likes#create", as: "create_like"
  delete "like/:id" => "likes#destroy", as: "destroy_like"
  
  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resources :comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:index, :show, :edit, :update] do
  	resource :relationships, only: [:create, :destroy]
  	get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'
  end
end