Bookshelf::Application.routes.draw do
  
  resources :social_authentications


  match '/rate' => 'rater#create', :as => 'rate'

  resources :line_items

  resources :reading_lists

  resources :terminologies

  resources :languages
  
  resources :info

  resources :taggings
  
resources :password_resets

  get "taggings/index"

  get "taggings/edit"

  get "taggings/show"

  get "taggings/new"

  get "taggings/destroy"

  resources :feedback_messages

  resources :comments
  
  resources :user_sessions
  
  

  resources :users do
    member do
      get 'r_list'
    end
  end    

  root :to => "books#index"
  
  
  # Routes for navigation pane
  match "auth/:provider/callback" => "social_authentications#create"
  match "about" => "info#about", :as => "about"
  match "give_back" => "info#give_back", :as => "give_back"
  match "moderators" => "info#moderators", :as => "moderators"
  match "feedback" => "feedback_messages#new", :as => "feedback"
  
  
  
  
  
  resources :tags
  
  

  resources :books do
    collection do
      get :reading_list_pane
    end
    member do
      get :invite_friends
      get :file_download
      get :interactive_video
      get :video_download
    end  
  end    
    
  
  
  
  
  resources :user_sessions
  
  get "login" => "user_sessions#new", :as => "login"
  get "logout" => "user_sessions#destroy", :as => "logout"
  

 
end
