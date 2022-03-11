Rails.application.routes.draw do

  get 'gadgets/new'
  get 'gadgets/index'
  get 'gadgets/show'
  get 'gadgets/edit'
  devise_for :users
  # トップページへのルーティング
  root :to => 'homes#top'

  resources :users, only: [:show,:edit,:update]
end
