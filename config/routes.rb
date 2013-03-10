Bookshelf::Application.routes.draw do
  
  resources :terminologies

  resources :languages
  
  resources :info

  resources :taggings
  
  get "taggings/index"

  get "taggings/edit"

  get "taggings/show"

  get "taggings/new"

  get "taggings/destroy"

  resources :feedback_messages

  resources :comments
  
  resources :user_sessions
  
  

  resources :users

  root :to => "books#index"
  
  
  # Routes for navigation pane
  match "auth/:provider/callback" => "users#create"
  match "about" => "info#about", :as => "about"
  match "give_back" => "info#give_back", :as => "give_back"
  match "moderators" => "info#moderators", :as => "moderators"
  match "feedback" => "feedback_messages#new", :as => "feedback"
  
  
  
  
  
  resources :tags
  
  

  resources :books
    
  
  
  
  
  resources :user_sessions
  
  get "login" => "user_sessions#new", :as => "login"
  get "logout" => "user_sessions#destroy", :as => "logout"
  

 
end
