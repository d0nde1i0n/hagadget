Rails.application.routes.draw do

  devise_for :users
  # トップページへのルーティング
  root :to => 'homes#top'

  # ユーザ関連のルーティング
  resources :users, only: [:show,:edit,:update]
  # ガジェット記事関連のルーティング
  resources :gadgets, only: [:new,:create,:index,:show,:edit,:update,:destroy] do
    resource :favorites,only: [:create,:destroy]
    resources :gadget_comments,only: [:create,:destroy]
  end
end
