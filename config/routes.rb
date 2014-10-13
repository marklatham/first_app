Infocoop::Application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  get '/faq', :to => 'pages#faq', :as => :faq
end
