Goalnect::Application.routes.draw do

  
  resources :charities
  #resources :goal_donations
  resources :goal_supports
  resources :goal_comments
  resources :goal


#admin routes
  devise_for :admins,  :skip => [ :registrations ]                        
  get "achiever/view"
  Togg.le(:feature_login) do
    devise_for :users
    
    match '/auth/:provider/callback' => 'authentications#create'
    match '/auth/facebook/logout' => 'authentications#facebook_logout', :as => :facebook_logout
    
    authenticated :user do
      root to: 'achiever#view'
    end
    
    devise_scope :user do 
      match '/auth/facebook/logout_callback' => 'devise/sessions#destroy', :as => :facebook_logout_callback
    end 
  end
  
  match '/search' => 'achiever#search'
  match '/search/:q' => 'achiever#search'
  
  match '/goal_donations/new/:goal_id' => 'goal_donations#new'
  match '/goal_donations/create' => 'goal_donations#create', :as => :goal_donations_create

  
  match '/goal_donation_payment_notifications/confirm' => 'goal_donation_payment_notifications#confirm'
  match '/goal_donations/show/:id' => 'goal_donations#show'
  
  post '/pagseguro_developer' => "goalnect_pagseguro_developer#create"
  
  match '/achiever/edit' => 'achiever#edit'
  match '/achiever/edit_profile_photo' => 'achiever#edit_profile_photo'
  match '/achiever/update' => 'achiever#update'

  root to: 'home#index'

  match '/:user_username' => 'achiever#view'
  
  match '/:user_username/goals' => 'goals#index'
  match '/:user_username/goals/new' => 'goals#new'
  match '/:user_username/goals/create' => 'goals#create'
  
  match '/:user_username/goals/show/:goal_id' => 'goals#show'
  match '/:user_username/goals/add_comment/:goal_id' => 'goals#add_comment'
  match '/:user_username/goals/add_support/:goal_id' => 'goals#add_support'
  match '/:user_username/goals/support_info/:goal_id' => 'goals#support_info'
  match '/:user_username/goals/change_stage/:goal_id' => 'goals#change_stage'
  
#root :to => "home#index"

#get "home/index"
#get 'users', :to => 'home#index', :as => :user_root # Rails 3

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
# root :to => 'welcome#index'

# See how all your routes lay out with "rake routes"

# This is a legacy wild controller route that's not recommended for RESTful applications.
# Note: This route will make all actions in every controller accessible via GET requests.
# match ':controller(/:action(/:id))(.:format)'
end
