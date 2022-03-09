Rails.application.routes.draw do
  devise_for :users
  # トップページへのルーティング
  root :to => 'homes#top'

end
