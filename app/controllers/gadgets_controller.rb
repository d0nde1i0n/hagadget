class GadgetsController < ApplicationController
  before_action :authenticate_user!,except: [:index]
  before_action :set_gadget_info,only:[:show,:edit,:update,:destroy]
  before_action :ensure_correct_user,only: [:edit,:update,:destroy]

  def new
    @gadget = Gadget.new
  end

  def create
    @gadget = current_user.gadgets.new(gadget_params)

    if @gadget.save
      # お気に入り登録に関連する通知レコードをデータベースに登録
      gadget.create_notification_like!(current_user)
      flash[:notice] = "ガジェット記事を投稿しました。"
      redirect_to gadgets_path
    else
      flash[:alert] = "ガジェット記事の投稿ができませんでした。"
      render new_gadget_path
    end
  end

  def index
    # order(order(created_at: :DESC)):作成日をキーとして降順に並び替えている
    # page(params[:page]):ページネーションする際に必要な機能
    @gadgets = Gadget.order(created_at: :DESC).page(params[:page])
  end

  def show
    # before_action :set_gadget_infoで「@gadget」を取得
    @gadget_comments = @gadget.gadget_comments.all
    @gadget_comment = GadgetComment.new
  end

  def edit
    # before_action :set_gadget_infoで「@gadget」を取得
  end

  def update
    # before_action :set_gadget_infoで「@gadget」を取得
    if @gadget.update(gadget_params)
      flash[:notice] = "対象の投稿記事情報を更新しました。"
      redirect_to gadget_path(@gadget)
    else
      flash[:alert] = "対象の投稿記事情報を更新できませんでした。"
      render "edit"
    end
  end

  def destroy
    # before_action :set_gadget_infoで「@gadget」を取得
    @gadget.destroy
    flash[:notice] = "対象の投稿記事を削除しました。"
    redirect_to user_path(@gadget.user)
  end


  private

  def gadget_params
    params.require(:gadget).permit(:name,:manufacture_name,:price,:score,:description,:gadget_image)
  end

  def set_gadget_info
    @gadget = Gadget.find(params[:id])
  end

  def ensure_correct_user
    # before_actionで「@user」を取得
    # ログインユーザとユーザ詳細画面のユーザが一致しない場合は、ログインユーザのページに遷移
    unless @gadget.user == current_user
      flash[:alert] = "不正な操作です。"
      redirect_to user_path(current_user)
    end
  end

   # お気に入り登録された後に通知を作成するメソッド
  def create_notification_like!(temp_current_user)

    # notificationsテーブルからwhere内の条件に一致するレコードを検索し、tempに格納
    temp = Notification.where(
      ["visitor_id = ? and visited_id = ? and gadget_id = ? and action = ?",
      temp_current_user.id, user_id, id, Notification.action_types[:liked_to_own_post]
      ])

    # notificationsテーブルに該当するレコードがない場合のみ、通知レコードを作成
    if temp.blank
      # 「.blank?」：対象オブジェクトが空白の場合にtrueを返すメソッド
      # ここでいう「空白」とは、「空文字」、「空白」、「false」、「nil」を指す。

      # Notificationクラスの空のインスタンスを作成後、各カラムに値を追加
      notification = temp_current_user.active_notifications.new(
        gadget_id: id,visited_id: user_id, action: Notification.action_types[:liked_to_own_post]
        )

      # ユーザAが投稿したガジェット記事に対して、ユーザA自身がお気に入り登録した場合、通知済みとする
      # (上記の場合に、通知が送信されるのを防止するため)
      notification.checked = true if notification.visitor_id == notification.visited_id

      # バリデーションエラーがない場合のみ、データベースに通知レコードを登録する。
      notification.save if notification.valid?

    end
  end
end
