Infocoop::Application.routes.draw do
  root 'visitors#index'
  devise_for :users, path: '', path_names: {sign_up: 'register', sign_in: 'login', sign_out: 'logout'},
             controllers: {registrations: 'registrations'}
  devise_scope :user do
    get "/change_password" => "registrations#change_password"
  end
  resources :users
  resources :posts
  get '/about',           to: 'visitors#about',                as: :about
  get '/faq',             to: 'visitors#faq',                  as: :faq
  get '/feed',            to: 'posts#feed',                    as: :feed
  get '/privacy',         to: 'visitors#privacy',              as: :privacy
  get '/terms',           to: 'visitors#terms',                as: :terms
end
