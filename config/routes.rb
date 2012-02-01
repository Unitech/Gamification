Gamification::Application.routes.draw do

  devise_for :users

  scope :controller => :home, :as => :home, :path => '/misc' do 
    
  end
  
  scope :controller => :mission, :as => :mission, :path => '/mission/' do
    get '/waiting_missions' => :waiting_missions, :as => :waiting
    get '/available_missions' => :available_missions, :as => :available
    get '/finished_missions' => :finished_missions, :as => :finished
    get '/details/:mission_id' => :mission_detail, :as => :detail
    post '/comment' => :submit_comment, :as => :submit_comment
    post '/apply_for_mission/:mission_id' => :apply_for_mission, :as => :apply
  end

  scope :controller => :user, :as => :user, :path => '/user/' do
    get '/private_profile' => :private_profile, :as => :private_profile
    get '/account_historic' => :account_historic, :as => :account_historic
  end
  # scope :controller => :home, :as => :home, :path => '/' do
  #   post '/mission/comment' => :submit_comment, :as => :submit_comment
  #   get '/mission/:mission_id' => :mission_detail, :as => :mission_detail
  # end

  scope :controller => :dashboard, :as => :dashboard, :path => '/' do
    get '/' => :home, :as => :home
  end

  root :to => 'dashboard#home'

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
  # match ':controller(/:action(/:id(.:format)))'
end
