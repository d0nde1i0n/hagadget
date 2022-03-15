Rails.application.routes.draw do

  devise_for :users
  # トップページへのルーティング
  root :to => 'homes#top'
  # 検索結果ページのルーティング

  # ユーザ関連のルーティング
  resources :users, only: [:show,:edit,:update] do
    resources :relationships,only: [:create,:destroy]
    resources :notifications,only: [:index]

    # 「on: :member」を使用することで「users/:id/followers」というルーティングが使用可能
    # 「on: :collection」を使用すると「users/followers」というルーティングになる
    # ユーザがフォローしているユーザを全てを取得
    get :followers,on: :member
    # ユーザをフォローしているユーザを全てを取得
    get :followings,on: :member
  end

  # ガジェット記事関連のルーティング
  resources :gadgets, only: [:new,:create,:index,:show,:edit,:update,:destroy] do
    resource :favorites,only: [:create,:destroy]
    resources :gadget_comments,only: [:create,:destroy]
  end

  get "/search" => "searches#search"

end
