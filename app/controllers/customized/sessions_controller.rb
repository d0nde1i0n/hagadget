class Customized::SessionsController < Devise::SessionsController

  # sessionsコントローラのオーバーライド

  # GET /resource/sign_in (resource = User)
  def new
    # インスタンスメソッドの「resouse」にuserクラスのインスタンスメソッドを初期化した情報を格納
    self.resource = resource_class.new(sign_in_params)

    # 「clean_up_passwords」：「password」と「password_confirmation」の値をnilにする
    # deviseで用意されているメソッド。
    clean_up_passwords(resource)

    # ブロックが渡されていれば、ブロック引数「resource」を受け取りブロックの処理を実行
    # 「block_given?」：ブロックが渡されていれば、「true」を返すメソッド
    # 「ブロック」：メソッド呼び出しの際に引数と一緒に渡すことのできる処理のかたまり。
    yield resource if block_given?

    # newアクションが呼び出された時、format.〇〇によって処理を定義する
    # 「respond_to」：リクエストの形式(HTMLやJSONなど)によって処理・レンダリングを変えるメソッド
    respond_to do |format|
      # 今回は処理・レンダリングの変更は不要（devise.rbで設定変更しているため）
      format.js
      format.html
    end

  end
end
