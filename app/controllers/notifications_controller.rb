class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    # インスタンス変数にカレントユーザに紐づく受信通知テーブルの情報を格納
    @notifications = current_user.passive_notifications

    # 表示した全ての通知を確認済みにする
    @notifications.where(checked: false).each do |notifications|
      notifications.update_attributes(checked: true)
      # 「update_attributes()」:引数の値を使用して、データベースの該当するフィールドの値を更新するメソッド
    end
  end

end
