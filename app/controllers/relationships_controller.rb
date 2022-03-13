class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    # フォローするユーザ側から見た場合のパラメータは、
    # (follower_id,fllowed_id) = (ログインユーザid,フォロー対象のユーザid)
    @user = User.find(params[:user_id])
    relationship = current_user.relationships.new(followed_id: @user.id)
    relationship.save

  end

  def destroy
    # relationshipsテーブルからfollower_id、followed_idが、それぞれ一致するレコードを検索する
    @user = User.find(params[:user_id])
    relationship = current_user.relationships.find_by(followed_id: @user.id)
    relationship.destroy

  end
end
