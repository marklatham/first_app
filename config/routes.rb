Infocoop::Application.routes.draw do
  root 'home#index'
  devise_for :users
  get '/faq', :to => 'pages#faq', :as => :faq
end
