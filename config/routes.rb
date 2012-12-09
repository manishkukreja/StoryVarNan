Bookshelf::Application.routes.draw do
  
  resources :terminologies

  resources :languages

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
  #match "login" => "users#login", :as => "login"
  #match "logout" => "users#logout", :as => "logout"
  match "feedback" => "feedback_messages#new", :as => "feedback"
  #match "episodes/archive" => redirect("/?view=list")
  #match 'unsubscribe/:token' => 'users#unsubscribe', :as => "unsubscribe"
  #post "versions/:id/revert" => "versions#revert", :as => "revert_version"
  
  
  
  
  resources :tags
  
  

  resources :books do
    member do
      get 'bittu'
    end
  end
  
  
  resources :user_sessions
  
  get "login" => "user_sessions#new", :as => "login"
  get "logout" => "user_sessions#destroy", :as => "logout"
  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
