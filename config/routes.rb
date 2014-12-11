Infocoop::Application.routes.draw do
  root to: 'visitors#index'
  devise_for :users, :path => '', :path_names => {:sign_up => 'register', :sign_in => 'login', :sign_out => 'logout'},
             :controllers => { registrations: 'registrations' }
  resources :users
  resources :posts
  get '/about',           :to => 'visitors#about',           :as => :about
  get '/faq',             :to => 'visitors#faq',             :as => :faq
  get '/privacy',         :to => 'visitors#privacy',         :as => :privacy
  get '/terms',           :to => 'visitors#terms',           :as => :terms
  get '/feed',            :to => 'posts#feed',               :as => :feed
end
