Infocoop::Application.routes.draw do

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  root 'visitors#index'
  devise_for :users, path: '', path_names: {sign_up: 'register', sign_in: 'login', sign_out: 'logout'},
             controllers: {registrations: 'registrations'}
  devise_scope :user do
    get "/change_password" => "registrations#change_password"
  end

  get 'channels/admin',           to: 'channels#admin',            as: :admin_channels
  get 'channels/choose_manager',  to: 'channels#choose_manager',   as: :choose_manager
  get 'channels/remove_manager',  to: 'channels#remove_manager',   as: :remove_manager
  get 'channels/update_display',  to: 'channels#update_display',   as: :update_display
  get 'channels/unset_display',   to: 'channels#unset_display',    as: :unset_display

  resources :users
  resources :posts
  resources :channels do
    collection do
      post :set_manager
    end
  end

  get 'about',                to: 'visitors#about',            as: :about
  get 'editing_posts',        to: 'visitors#editing_posts',    as: :editing_posts
  get 'faq',                  to: 'visitors#faq',              as: :faq
  get 'feed',                 to: 'posts#feed',                as: :feed
  get 'privacy',              to: 'visitors#privacy',          as: :privacy
  get 'terms',                to: 'visitors#terms',            as: :terms

end
