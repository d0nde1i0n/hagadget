class FavoritesController < ApplicationController

  def create
    # viewから受け渡された「gadget_id」をキーとして、対象となるガジェット投稿記事を格納
    @gadget= Gadget.find(params[:gadget_id])
    # ログインユーザに紐づくfavoriteテーブルのレコードを作成、対象となるガジェット記事は
    # 1行上で取得した情報に基づく。
    favorite = current_user.favorites.new(gadget_id: @gadget.id)
    favorite.save
    @adget.create_notification_favorite!(current_user)

  end

  def destroy
    # viewから受け渡された「gadget_id」をキーとして、対象となるガジェット投稿記事を格納
    @gadget= Gadget.find(params[:gadget_id])
    # 1行上取得した情報をキーとして、ログインユーザに紐づくfavoriteテーブルから対象となる
    # レコードを検索する
    favorite = current_user.favorites.find_by(gadget_id: @gadget.id)
    favorite.destroy

  end
end
