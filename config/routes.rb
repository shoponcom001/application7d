Rails.application.routes.draw do

  get 'chats/show'
 devise_for :users

  root to: "homes#top"
  get "home/about" => "homes#about"
  
  post "like/:id" => "likes#create", as: "create_like"
  delete "like/:id" => "likes#destroy", as: "destroy_like"
  
  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resources :comments, only: [:create, :destroy]
  end
  
  resources :chats, only: [:create, :show]
  
  resources :groups do
    get "join" => "groups#join"
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end
  
  resources :users, only: [:index, :show, :edit, :update] do
  	resource :relationships, only: [:create, :destroy]
  	get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'
  end
end