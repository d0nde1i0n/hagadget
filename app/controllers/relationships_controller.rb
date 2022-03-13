class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    # フォローするユーザ側から見た場合のパラメータは、
    # (follower_id,fllowed_id) = (ログインユーザid,フォロー対象のユーザid)
    relationship = current_user.relationships.new(followed_id: params[:user_id])
    relationship.save
    redirect_to request.referer
  end

  def destroy
    # relationshipsテーブルからfollower_id、followed_idが、それぞれ一致するレコードを検索する。
    relationship = current_user.relationships.find_by(followed_id: params[:user_id])
    relationship.destroy
    redirect_to request.referer
  end
end
