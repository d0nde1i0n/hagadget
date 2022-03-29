class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user

  def index
    # インスタンス変数にカレントユーザに紐づく受信通知テーブルの情報を格納
    # N+1問題への対応
    @notifications = current_user.passive_notifications.includes(:visited,:visitor,:gadget,:gadget_comment)

    # 表示した全ての通知を確認済みにする
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
      # 「update_attribute()」:引数の値を使用して、データベースの該当するフィールドの値を更新するメソッド
      # 参考文献から「update_attributes()」メソッドを使用するつもりだったが、Rails6.1から非推奨となっていたため、
      # 「update()」メソッドに変更
    end
  end

  private

    def ensure_correct_user
      # ログインユーザとユーザ詳細画面のユーザが一致しない場合は、ログインユーザのページに遷移
      user = User.find(params[:user_id])
      unless user == current_user
        flash.now[:alert] = "不正な操作です。"
        redirect_to user_path(current_user)
      end
    end
end
