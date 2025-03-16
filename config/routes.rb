Rails.application.routes.draw do
  devise_for :users
  get 'homepage/index' 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'homepage#index'
  get 'users/account', to: 'users#account', as: 'account_user'
  get 'users/profile', to: 'users#profile', as: 'profile_user'
  get 'users/pofile/edit', to: 'users#edit', as: 'edit_profile_user'
  patch 'users/pofile', to: 'users#update', as: 'update_profile_user'
end
