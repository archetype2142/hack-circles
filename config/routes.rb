Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  get '/categories', to: 'category#index'
  resources :groups do 
  	resources :events
  	resources :posts
  	resources :categories
  end
  root 'groups#index', as: :authenticated_root
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
