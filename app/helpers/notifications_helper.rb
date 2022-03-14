module NotificationsHelper

  # 未読の通知が存在するかを確認するヘルパーメソッド
  def unchecked_notifications
    @notifications = current_user.passive_notication.where(checked: false)
  end

end
