Infocoop::Application.routes.draw do

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  root 'visitors#index'
  devise_for :users, path: '', path_names: {sign_up: 'register', sign_in: 'login', sign_out: 'logout'},
             controllers: {registrations: 'registrations'}
  devise_scope :user do
    get "/change_password" => "registrations#change_password"
  end

  get 'channels/admin',           to: 'channels#admin',            as: :admin_channels
  get 'channels/update_display',  to: 'channels#update_display',   as: :update_display

  resources :users
  resources :posts
  resources :channels

  get 'about',                to: 'visitors#about',            as: :about
  get 'editing_posts',        to: 'visitors#editing_posts',    as: :editing_posts
  get 'faq',                  to: 'visitors#faq',              as: :faq
  get 'feed',                 to: 'posts#feed',                as: :feed
  get 'privacy',              to: 'visitors#privacy',          as: :privacy
  get 'terms',                to: 'visitors#terms',            as: :terms

end
