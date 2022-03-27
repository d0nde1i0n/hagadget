class GadgetsController < ApplicationController
  before_action :authenticate_user!,except: [:index,:show]
  before_action :set_gadget_info,only:[:show,:edit,:update,:destroy]
  before_action :ensure_correct_user,only: [:edit,:update,:destroy]
  before_action :set_tag_list,only: [:create,:update]
  helper_method :sort_column,:sort_direction


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
      redirect_to gadget_path(@gadget)
    else
      flash[:alert] = "ガジェット記事の投稿ができませんでした。"
      render new_gadget_path
    end
  end

  def index
    # order(order(#{sort_column} #{sort_direction}):カラム名、データの並べ替え手段をもとにデータを並び替える
    # page(params[:page]):ページネーションする際に必要な機能
    @gadgets = Gadget.order("#{sort_column} #{sort_direction}").page(params[:page])
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

  # データ並べ替え手段の指定値を確認するメソッド
  def sort_direction
    # 受け取った値が指定する値かを判定する
    # （「asc」、「desc」であればそのまま、その他の値を受け取った場合は「asc」を返す）
    # 「%w」:文字列からなる配列を作成したいときに「[ ]」,「" "」を省略して記述するためのRubyの構文。
    # 「include(指定値)」: 配列の要素に”指定値”が含まれているばTrueを返す。
    %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
  end

  # データ並べ替え手段の対象となるカラム名を確認するメソッド
  def sort_column
    # 受け取った値がGadgetテーブルのカラム名と一致するかを判定する
    # （一致するカラム名があればそのまま、その他の値を受け取った場合は: 'id'を返す）
    Gadget.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end
end
