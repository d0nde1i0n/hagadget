class GadgetsController < ApplicationController
  before_action :authenticate_user!,except: [:index]
  before_action :set_gadget_info,only:[:show,:edit,:update,:destroy]
  before_action :ensure_correct_user,only: [:edit,:update,:destroy]
  before_action :set_tag_list,only: [:create,:update]

  def new
    @gadget = Gadget.new
  end

  def create
    @gadget = current_user.gadgets.new(gadget_params)

    # before_action :set_tag_listで「tag_list」を取得
    if @gadget.save
      # お気に入り登録に関連する通知レコードをデータベースに登録
      @gadget.save_tag(@tag_list)
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
    # before_action :set_tag_listで「tag_list」を取得
    if @gadget.update(gadget_params)
      # タグ情報の更新処理
      @gadget.save_tag(@tag_list)
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

  def set_tag_list
    @tag_list = params[:gadget][:tag_name].split(nil)
  end

end
