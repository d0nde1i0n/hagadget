class GadgetCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_gadget_info

  def create
    # before_action :set_gadget_infoで「@gadget」を取得
    # ログインユーザに紐づくコメントを変数に格納
    @comment = current_user.gadget_comments.new(gadget_comment_params)
    # ガジェット記事のidを変数に格納
    @comment.gadget_id = @gadget.id
    @comment.save
    redirect_to request.referer
  end

  def destroy
    # before_action :set_gadget_infoで「@gadget」を取得
    # ガジェットコメントid、ガジェット記事idに両方の条件を満たすレコードを検索し、
    # 一致するレコードを削除
    GadgetComment.find_by(id: params[:id],gadget_id: @gadget.id).destroy
    redirect_to request.referer
  end

  private

  def gadget_comment_params
    params.require(:gadget_comment).permit(:comment)
  end

  def set_gadget_info
    @gadget = Gadget.find(params[:gadget_id])
  end
end
