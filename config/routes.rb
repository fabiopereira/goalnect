Goalnect::Application.routes.draw do
  resources :charity_updates

  ActiveAdmin.routes(self)

  resources :charities
  resources :goal_supports
  resources :redemption_point_transactions

#admin routes
  # devise_for :users,  :skip => [ :registrations ]                        
  get "achiever/view"
  
  Togg.le(:feature_sign_in) do
    devise_for :users,  :skip => [ :registrations ]                        
    # match '/users/sign_in(.:format)' => 'devise/sessions#new'
    # post '/users/sign_in(.:format)' => 'devise/sessions#create', :as => :user_session
  end
                      
  Togg.le(:feature_authentication) do
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
  
  match '/events' => 'goal_templates#events'
  match '/events/:event_id' => 'goal_templates#show_event'
  
  match '/search' => 'search#search'
  match '/search/:q' => 'search#search'
  
  match '/goal_donations/new/:goal_id' => 'goal_donations#new'
  match '/goal_donations/create' => 'goal_donations#create', :as => :goal_donations_create

  
  match '/goal_donation_payment_notifications/confirm' => 'goal_donation_payment_notifications#confirm'
  match '/goal_donations/show/:id' => 'goal_donations#show'
  
  post '/pagseguro_developer' => "goalnect_pagseguro_developer#create"
  
  match '/achiever/edit' => 'achiever#edit'
  match '/achiever/edit_profile_photo' => 'achiever#edit_profile_photo'
  match '/achiever/update' => 'achiever#update'
  match '/achiever/crop' => 'achiever#crop'
  
  match '/charities/:id/change_logo' => 'charities#change_logo'
  match '/charities/crop/:id' => 'charities#crop'
  match '/charities/:id/donations' => 'charities#donations'
  match '/charities/:id/previous_month_donations_pdf' => 'charities#previous_month_donations_pdf'
  match '/charities/:id/current_month_donations_pdf' => 'charities#current_month_donations_pdf'
  match '/charities/:charity_id/show_goals' => 'charities#show_goals'
  
  
  match '/vantagens_files/show_last_10' => 'vantagens_files#show_last_10'
  match '/vantagens_files/process_file' => 'vantagens_files#process_file'
  
  
  root to: 'home#index'    
  match '/home' => 'home#index'
  
  Togg.le(:feature_goal_template) do
    match '/goal_template/i_commit' => 'goal_templates#i_commit'
    match '/goal_template/goal_template_by_title' => 'goal_templates#goal_template_by_title'
  end
  
  match 'static/:action' => 'static#:action'
  match '/faq' => "static#faq"
  match '/s/:static_content' => 'static#static_content'

  match '/jc/:static_content' => 'static#jc'
  
  match '/goal_donations/populate_pagseguro_fee' => 'goal_donations#populate_pagseguro_fee'
  match '/explore/goals' => 'explore#goals'
  match '/explore/goals/:goal_query' => 'explore#goals'
  
  match '/send_emails' => 'email_sender#send_mail_page'
  match '/send_emails/for_donation_received' => 'email_sender#for_donation_received'
  match '/send_emails/for_goal_without_donations' => 'email_sender#for_goal_without_donations'
  
  
  match '/:user_username' => 'achiever#view'

  match '/:user_username/points_statement' => 'points#points_statement'
  match '/:user_username/goals' => 'goals#index'
  match '/:user_username/goals/new' => 'goals#new'
  match '/goals/new' => 'goals#new'
  match '/:user_username/goals/create' => 'goals#create'
  
  match '/:user_username/goals/show/:goal_id' => 'goals#show'
  match '/:user_username/goals/add_feedback/:goal_id' => 'goals#add_feedback'
  match '/:user_username/goals/add_support/:goal_id' => 'goals#add_support'
  match '/:user_username/goals/i_support/:goal_id' => 'goals#i_support'
  match '/:user_username/goals/i_dont_support/:goal_id' => 'goals#i_dont_support'
  match '/:user_username/goals/support_info/:goal_id' => 'goals#support_info'
  match '/:user_username/goals/change_stage/:goal_id' => 'goals#change_stage'
  match '/:user_username/goals/accept_challenge/:goal_id' => 'goals#accept_challenge'
  match '/:user_username/goals/reject_challenge/:goal_id' => 'goals#reject_challenge'
  match '/:user_username/goals/report_abuse/:goal_id' => 'goals#report_abuse'
  match '/goals/add_comment/:goal_id' => 'goals#add_comment'
  match '/goals/goal_done/:goal_id' => 'goals#goal_done'
  match '/goals/goal_abandoned/:goal_id' => 'goals#goal_abandoned'
  match '/:user_username/:goal_id' => 'goals#show'
  match '/goals/edit/:goal_id' => 'goals#edit'
  match '/goals/update/:goal_id' => 'goals#update'

  
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
