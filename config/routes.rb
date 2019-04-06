Rails.application.routes.draw do
  resources :groups
  devise_for :users
  root 'groups#index', as: :authenticated_root
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
