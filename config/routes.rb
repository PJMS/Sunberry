Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'main#index'
  get 'index', to: 'main#index'
  # board
  get 'notice', to: 'article#list', category: 'notice'
  get 'notice/write', to: 'article#write_page', category: 'notice'
  get 'notice/:id/edit', to: 'article#modify_page', category: 'notice'
  get 'notice/:id', to: 'article#view'
  # get 'board', to: 'article#list', category: 'general'
  # get 'board/write', to: 'article#write_page', category: 'general'
  # get 'board/:id/edit', to: 'article#modify_page', category: 'general'
  # get 'board/:id', to: 'article#view'
  post 'notice/write', to: 'article#write', category: 'notice'
  # post 'board/write', to: 'article#write', category: 'general'
  post 'notice/:id/edit', to: 'article#modify', category: 'notice'
  # post 'board/:id/edit', to: 'article#modify', category: 'general'
  post 'notice/:id', to: 'reply#write', category: 'notice'
  # post 'board/:id', to: 'reply#write', category: 'board'
  # oneline
  get 'oneline', to: 'oneline#get'
  post 'oneline', to: 'oneline#create'
  delete 'oneline', to: 'oneline#delete'
  # users
  get 'sign-in', to: 'user#sign_in_page'
  post 'sign-in', to: 'user#sign_in'
  get 'sign-up', to: 'user#sign_up_page'
  post 'sign-up', to: 'user#sign_up'
  get 'sign-out', to: 'user#sign_out'
  get 'profile', to: 'user#profile_page'
  post 'profile-photo', to: 'user#profile_image'
  get 'verify-email', to: 'user#verify_email'
  post 'password-reset', to: 'user#request_password_reset'
  get 'password-reset', to: 'user#password_reset_page'
  post 'password-reset-confirm', to: 'user#password_reset'
  post 'modify-password', to: 'user#modify_password'
  post 'modify-minecraft', to: 'user#modify_minecraft'
  post 'drop-out', to: 'user#drop_out'
  # admin
  get 'admin', to: 'admin#index'
  get 'admin/users', to: 'admin#users'
  get 'admin/toolbox', to: 'admin#toolbox'
  post 'admin/mail-test', to: 'admin#mail_test'
  # api
  get 'api/nachtbeere/users/uuid/:uuid', to: 'user#minecraft_uuid_duplicate_check'
  get 'api/nachtbeere/users/verified/:uuid', to: 'user#minecraft_uuid_verified_check'
  get 'api/minecraft/:server/server/health', to: 'api_minecraft#server_health'
  get 'api/minecraft/:server/server/info', to: 'api_minecraft#server_info'
  get 'api/minecraft/:server/server/system-info', to: 'api_minecraft#server_system_info'
  get 'api/minecraft/:server/users/username/:uuid', to: 'api_minecraft#name_from_uuid'
  get 'api/minecraft/:server/users/uuid/:username', to: 'api_minecraft#uuid_from_name'
  # statics
  get 'about', to: 'pages#show', page: 'about'
  get 'donation', to: 'pages#show', page: 'donation'
  get 'develop', to: 'pages#show', page: 'develop'
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
