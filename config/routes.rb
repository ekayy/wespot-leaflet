Wespot::Application.routes.draw do
  # authenticated :user do
  #   root :to => 'home#index'
  # end
  root :to => "home#index"
  devise_for :users, :path => 'accounts', path_names: {sign_in: "login", sign_out: "logout"}, controllers: {omniauth_callbacks: "omniauth_callbacks", path: "accounts"}

  namespace :admin do
  	get '', to: 'dashboard#index', as: '/'
  	resources :users
	end

	resources :places do
    member { post :vote }
    collection do
      get :feed
    end
		resources :comments
	end


end