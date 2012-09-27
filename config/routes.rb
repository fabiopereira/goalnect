Goalnect::Application.routes.draw do

  resources :goal_supports

  resources :goal_comments
  resources :goal

  get "achiever/view"
  devise_for :users
  match '/search' => 'achiever#search'
  match '/search/:q' => 'achiever#search'
  match '/:user_username' => 'achiever#view'
  
  match '/:user_username/goals' => 'goals#index'
  match '/:user_username/goals/new' => 'goals#new'
  match '/:user_username/goals/create' => 'goals#create'
  match '/:user_username/goals/show/:goal_id' => 'goals#show'
  match '/:user_username/goals/add_comment/:goal_id' => 'goals#add_comment'
  match '/:user_username/goals/support/:goal_id' => 'goals#support'
  match '/:user_username/goals/edit/:id' => 'goals#edit'
  
  match '/achiever/edit' => 'achiever#edit'
  match '/achiever/update' => 'achiever#update'
  
  match '/auth/:provider/callback' => 'authentications#create'
  
  authenticated :user do
    root to: 'achiever#view'
  end

  root to: 'home#index'

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
