Gamification::Application.routes.draw do

  devise_for :users
  
  scope :controller => :home, :as => :home, :path => '/misc' do    
  end
  
  scope :controller => :mission, :as => :mission, :path => '/mission/' do
    get '/waiting_missions' => :waiting_missions, :as => :waiting
    get '/available_missions' => :available_missions, :as => :available
    get '/finished_missions' => :finished_missions, :as => :finished
    get '/processing_missions' => :processing_mission, :as => :processing
    get '/details/:mission_id' => :mission_detail, :as => :detail
    post '/comment' => :submit_comment, :as => :submit_comment
    post '/apply_for_mission/:mission_id' => :apply_for_mission, :as => :apply
  end

  scope :controller => :user, :as => :user, :path => '/user/' do
    get '/private_profile' => :private_profile, :as => :private_profile
    get '/account_historic' => :account_historic, :as => :account_historic
    get '/actions_historic' => :actions_historic, :as => :actions_historic
    get '/:username' => :public_profile, :as => :public_profile
  end

  scope :controller => :dashboard, :as => :dashboard, :path => '/' do
    get '/' => :home, :as => :home
  end

  root :to => 'dashboard#home'

end
