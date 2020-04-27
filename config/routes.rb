Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'main#index'
  get 'index', to: 'main#index'
  get 'notice', to: 'article#list', category: 'notice'
  get 'notice/:id', to: 'article#view', category: 'notice'
  get 'sign_in', to: 'user#sign_in_page'
  post 'sign_in', to: 'user#sign_in'
  get 'sign_up', to: 'user#sign_up_page'
  post 'sign_up', to: 'user#sign_up'
  get 'sign_out', to: 'user#sign_out'
  get 'profile', to: 'user#profile'
  get 'admin', to: 'admin#index'
  get 'about', to: 'pages#show', page: 'about'
  get 'donation', to: 'pages#show', page: 'donation'
  get 'terms-of-service', to: 'pages#show', page: 'terms_of_service'
  get 'minecraft', to: 'pages#show', page: 'minecraft_about'
  get 'minecraft/about', to: 'pages#show', page: 'minecraft_about'
  get 'minecraft/rules', to: 'pages#show', page: 'minecraft_rules'
  get 'minecraft/connect', to: 'pages#show', page: 'minecraft_connect'
  get 'minecraft/maps', to: 'pages#show', page: 'minecraft_maps'
  get 'minecraft/help', to: 'pages#show', page: 'minecraft_help'
  get 'multiplay/about', to: 'pages#show', page: 'multiplay_about'
  get 'multiplay/ottd', to: 'pages#show', page: 'openttd_about'
  get 'multiplay/orct', to: 'pages#show', page: 'openrct_about'
end
