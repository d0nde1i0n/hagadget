class GadgetsController < ApplicationController
  before_action :authenticate_user!,except: [:index]

  def new
    @gadget = Gadget.new
  end

  def create
    @gadget = current_user.gadgets.new(gadget_params)

    if @gadget.save
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
  end

  def edit
  end

  private

  def gadget_params
    params.require(:gadget).permit(:name,:manufacture_name,:price,:score,:description,:gadget_image)
  end
end
