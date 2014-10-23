Infocoop::Application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  get '/about',           :to => 'visitors#about',           :as => :about
  get '/faq',             :to => 'visitors#faq',             :as => :faq
  get '/privacy',         :to => 'visitors#privacy',         :as => :privacy
  get '/terms',           :to => 'visitors#terms',           :as => :terms
end
