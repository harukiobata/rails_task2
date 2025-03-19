Rails.application.routes.draw do
  devise_for :users
  get 'homepage/index' 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :rooms
  root 'homepage#index'
  get 'users/account', to: 'users#account', as: 'account_user'
  get 'users/profile', to: 'users#profile', as: 'profile_user'
  get 'users/profile/edit', to: 'users#edit', as: 'edit_profile_user'
  patch 'users/profile', to: 'users#update', as: 'update_profile_user'
  get 'rooms/own', to: 'rooms#own', as: 'own_room'
end
