require 'subdomain'

Programkina::Application.routes.draw do
  
  get "dashboard" => "dashboard#index", :as => :dashboard
  post "set_notification" => "dashboard#set_notification"
  get "clear_notification" => "dashboard#clear_notification"
  
  get "settings" => "account#edit", :as => :edit_settings
  put "settings" => "account#update", :as => :update_settings
  
  get "scripts(/:subaction)" => "scripts#index", :as => :scripts

  devise_for :users do
    get "/sign_in" => "devise/sessions#new", :as => :sign_in
    get "/sign_out" => "devise/sessions#destroy", :as => :sign_out
    get "/sign_up" => "devise/registrations#new", :as => :sign_up
  end

  resources :stages do
    resources :events
  end

  resources :events
  
  scope "(:context)", :context => /embed/ do
    constraints(Subdomain) do
    
      match '/' => "jqm#index", :as => :jqm_root
      match 'stage/:id' => "jqm#stage", :as => :jqm_stage
      get 'day/:date(/:stage)' => "jqm#day", :as => :jqm_day
      get 'event/:id' => "jqm#detail", :as => :jqm_event
      match 'search' => "jqm#search", :as => :jqm_search
    
    end
  end
  # public pages:
  get '/contact' => "public#contact", :as => :public_contact
 
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
  
  root :to => "public#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
