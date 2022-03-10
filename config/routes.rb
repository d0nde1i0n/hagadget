Rails.application.routes.draw do

  devise_for :users
  # トップページへのルーティング
  root :to => 'homes#top'

  resources :users, only: [:show,:edit,:update]
end
