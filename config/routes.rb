Rails.application.routes.draw do

  # devise関連のルーティング
  devise_for :users,controllers: {
    # sessionsコントローラをオーバーライドしたいため、設定ファイルが記載されたパスを指定
    sessions: 'customized/sessions'
  }

  # ゲストユーザ関連のルーティング
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  # トップページへのルーティング
  root :to => 'homes#top'
  # 検索結果ページのルーティング
  get "/search" => "searches#search"

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

end
