class SearchesController < ApplicationController

  def search
    @model = params["model"] #検索対象のモデルを格納
    @content = params["content"] #検索対象の文字列を格納
    # 「search_for()メソッドで取得したレコードを全て格納
    @records = search_for(@model,@content)
  end

  private

  def search_for(model,content)

    # 受信したモデル情報別に処理を分岐
    # 今回の曖昧検索では、部分一致のみとしている。
    if model == 'User'
      User.where('name LIKE ?','%'+content+'%')

    elsif model == 'Gadget'
      Gadget.where('name LIKE ?','%'+content+'%')

    elsif model == 'Tag'
      Tag.where('name LIKE ?','%'+content+'%')
    end

  end

end
