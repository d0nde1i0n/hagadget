class ApplicationController < ActionController::Base
  # デバイスコントローラが使用される前の処理を追記
  before_action :configure_permitted_parameters,if: :devise_controller?

  # サインアウト（ログアウト）後の遷移先を指定
  def after_sign_out_path_for(resourse)
    root_path #トップページ
  end

  protected

  # メールアドレス、パスワード以外のカラムも扱えるようにストロングパラメータを設定
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:last_name,:first_name,:nickname,:occupation_id])
  end

end
