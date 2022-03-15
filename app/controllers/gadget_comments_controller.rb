class GadgetCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_gadget_info, only: [:create,:destroy,:set_gadget_comments_info]
  before_action :set_gadget_comments_info, only: [:create,:destroy]

  def create
    # before_action :set_gadget_infoで「@gadget」を取得
    # before_action :set_gadget_infoで「@gadget_comments」を取得
    # ログインユーザに紐づくコメントを変数に格納
    @gadget_comment = current_user.gadget_comments.new(gadget_comment_params)
    # ガジェット記事のidを変数に格納
    @gadget_comment.gadget_id = @gadget.id
    @gadget_comment.save
    # コメント投稿の通知レコードを作成
    @gadget_comment.gadget.create_notification_comment!(current_user,@gadget_comment.id)

  end

  def destroy
    # before_action :set_gadget_infoで「@gadget」を取得
    # before_action :set_gadget_infoで「@gadget_comments」を取得
    # ガジェットコメントid、ガジェット記事idに両方の条件を満たすレコードを検索し、
    # 一致するレコードを削除
    @gadget_comment = GadgetComment.find_by(id: params[:id],gadget_id: @gadget.id).destroy
    @gadget_comment.destroy
  end

  private

  # ストロングパラメータ
  def gadget_comment_params
    params.require(:gadget_comment).permit(:comment)
  end

  # ガジェット記事を取得するメソッド
  def set_gadget_info
    @gadget = Gadget.find(params[:gadget_id])
  end

  # ガジェット記事に紐づく、全てのコメントを取得するためのメソッド
  def set_gadget_comments_info
    @gadget_comments = @gadget.gadget_comments.all
  end
end
