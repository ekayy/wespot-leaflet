Wespot::Application.routes.draw do
  get "places/index"

  get "places/show"

  get "comments/index"

  get "comments/new"

  # authenticated :user do
  #   root :to => 'home#index'
  # end
  root :to => "home#index"
  devise_for :users, :path => 'accounts', path_names: {sign_in: "login", sign_out: "logout"}
  resources :users

  namespace :admin do
  	get '', to: 'dashboard#index', as: '/'
  	resources :users
	end

	resources :places do
		resources :comments
	end

end