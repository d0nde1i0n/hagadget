class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters,if: :devise_controller?
  before_action :select_language_for_devise

  # サインアウト（ログアウト）後の遷移先を指定
  def after_sign_in_path_for(resourse)
    user_path(current_user) #ログインユーザのユーザ詳細画面
  end

  # サインアウト（ログアウト）後の遷移先を指定
  def after_sign_out_path_for(resourse)
    root_path #トップページ
  end

  protected

  # メールアドレス、パスワード以外のカラムも扱えるようにストロングパラメータを設定
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:last_name,:first_name,:nickname,:occupation_id])
  end

   # device関連メッセージの日本語化
  def select_language_for_devise
    I18n.locale = :ja # 〇〇.ja.ymlを指定している？
  end
end
