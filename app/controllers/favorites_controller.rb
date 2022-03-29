class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    # viewから受け渡された「gadget_id」をキーとして、対象となるガジェット投稿記事を格納
    @gadget= Gadget.find(params[:gadget_id])
    # ログインユーザに紐づくfavoriteテーブルのレコードを作成、対象となるガジェット記事は
    # 1行上で取得した情報に基づく。
    favorite = current_user.favorites.new(gadget_id: @gadget.id)
    unless current_user.id == @gadget.user_id
      favorite.save
      @gadget.create_notification_favorite!(current_user)
    else
      # 非同期処理エラー時の動作を設定したjsファイルを指定
      flash.now[:alert] = "自身の投稿をお気に入り登録することはできません。"
      render 'favorites/error'
    end
  end

  def destroy
    # viewから受け渡された「gadget_id」をキーとして、対象となるガジェット投稿記事を格納
    @gadget= Gadget.find(params[:gadget_id])
    # 1行上取得した情報をキーとして、ログインユーザに紐づくfavoriteテーブルから対象となる
    # レコードを検索する
    favorite = current_user.favorites.find_by(gadget_id: @gadget.id)

    unless current_user.id == @gadget.user_id
      favorite.destroy
    else
      # 非同期処理エラー時の動作を設定したjsファイルを指定
      flash.now[:alert] = "不正な操作です。"
      render 'favorites/error'
    end

  end
end
