class UsersController < ApplicationController
  before_action :authenticate_user!,except: [:show,:followers,:followings]
  before_action :set_user_info,only:[:show,:edit,:update,:followers,:followings,:ensure_correct_user,:ensure_guest_user]
  before_action :ensure_correct_user,only: [:edit,:update]
  before_action :ensure_guest_user,only: [:edit]

  def show
    # before_action :set_user_infoで「@user」を取得
    @gadgets = @user.gadgets.includes(:tags,gadget_image_attachment: :blob).order(created_at: :DESC).page(params[:page])
  end

  def edit
    # before_action :set_user_infoで「@user」を取得
  end

  def update
    # occupation_idを取得
    @user.occupation_id = params[:user][:occupation_id]
    if @user.update(user_params)
      flash.now[:notice] = "ユーザ情報を更新しました。"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "ユーザ情報の更新に失敗しました。"
      render 'edit'
    end
  end

  def followers
    # before_action :set_user_infoで「@user」を取得
    # 「@userに紐づくユーザをフォローしているユーザ達(fllowers)」＝「@userに紐づくユーザのフォロワー」
    @users = @user.followers.includes(profile_image_attachment: :blob).page(params[:page])
  end

  def followings
    # before_action :set_user_infoで「@user」を取得
    # 「@userに紐づくユーザにフォローされているユーザ達(fllowings)」
    #   ＝「@userに紐づくユーザがフォロー中」
    @users = @user.followings.includes(profile_image_attachment: :blob).page(params[:page])
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
      flash.now[:alert] = "不正な操作です。"
      redirect_to user_path(current_user)
    end
  end

  def ensure_guest_user
    # before_actionで「@user」を取得
    if @user.nickname == "guestuser"
      flash.now[:alert] = 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
      redirect_to user_path(current_user)
    end
  end
end
