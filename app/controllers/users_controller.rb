class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_info,only:[:show,:edit,:update,:followers,:followings,:ensure_correct_user]
  before_action :ensure_correct_user,only: [:edit,:update]


  def show
    # before_action :set_user_infoで「@user」を取得
    @gadgets = @user.gadgets.order(created_at: :DESC).page(params[:page])
  end

  def edit
    # before_action :set_user_infoで「@user」を取得
  end

  def update
    # occupation_idを取得
    @user.occupation_id = params[:user][:occupation_id]
    if @user.update(user_params)
      flash[:notice] = "ユーザ情報を更新しました。"
      redirect_to user_path(@user)
    else
      flash[:alert] = "ユーザ情報の更新に失敗しました。"
    end
  end

  def followers
    # before_action :set_user_infoで「@user」を取得
    # 「@userに紐づくユーザをフォローしているユーザ達(fllowers)」＝「@userに紐づくユーザのフォロワー」
    @users = @user.followers.page(params[:page])
  end

  def followings
    # before_action :set_user_infoで「@user」を取得
    # 「@userに紐づくユーザにフォローされているユーザ達(fllowings)」
    #   ＝「@userに紐づくユーザがフォロー中」
    @users = @user.followings.page(params[:page])
  end


  private

  def user_params
    params.require(:user).permit(:last_name,:first_name,:nickname,:profile_image,:introduction,:email)
  end

  def set_user_info
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    # before_actionで「@user」を取得
    # ログインユーザとユーザ詳細画面のユーザが一致しない場合は、ログインユーザのページに遷移
    unless @user == current_user
      flash[:alert] = "不正な操作です。"
      redirect_to user_path(current_user)
    end
  end
end
