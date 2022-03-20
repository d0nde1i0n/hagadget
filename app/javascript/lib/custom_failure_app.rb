# deviseのFailureAppクラスのオーバーライド（上書き）する。
class CustomFailureApp < Devise::FailureApp
  def redirect_url
    # リクエストがajaxどうかで処理を分岐させる。
    # 「request.xhr」：リクエストが XMLHttpRequest(ajax通信)かどうか判定するメソッド。
    if request.xhr?
      # リクエストがxhrであれば、js形式のログインページに遷移するように指定
      send(:"new_#{scope}_session_path", :format => :js)
    else
      # FailureAppクラスのredirect_urlメソッドを呼び出す。
      super
      # 「super」：子クラスのインスタンスに対して、同名の親クラスメソッドをそのまま呼び出せるメソッド
      # 親クラス（スーパークラス）：FailureApp
      # 子クラス：CustomFailureApp
    end
  end
end

# 補足(FailureAppクラスのredirect_urlメソッド)
# def redirect_url
#   if warden_message == :timeout
#     flash[:timedout] = true if is_flashing_format?

#     path = if request.get?
#       attempted_path
#     else
#       request.referrer
#     end

#     path || scope_url
#   else
#     scope_url
#   end
# end
