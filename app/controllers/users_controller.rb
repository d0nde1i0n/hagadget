class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  private

  def user_params
    params.require(:user).permit(:last_name,:first_name,:nickname,:profile_image,:introduction,:email)
  end

end
