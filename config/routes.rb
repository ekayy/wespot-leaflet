Wespot::Application.routes.draw do

  authenticated :user do
    root :to => "admin/users#index"
  end

  resources :relationships, only: [:create, :destroy]

  resources :places do
    member do
      get :lightbox
      get :following, :followers
    end
    member { post :vote }
    collection do
      get :feed
      get :map
    end
    resources :comments
  end

  root :to => "places#index"
  devise_for :users, :path => 'accounts', path_names: {sign_in: "login", sign_out: "logout"}, controllers: {omniauth_callbacks: "omniauth_callbacks", path: "accounts"}
  resources :users

  namespace :admin do
  	get '', to: 'dashboard#index', as: '/'
  	resources :users
	end




end