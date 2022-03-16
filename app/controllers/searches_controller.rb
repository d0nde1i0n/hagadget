class SearchesController < ApplicationController

  def search
    @model = params[:model] #検索対象のモデルを格納
    @content = params[:content] #検索対象の文字列を格納
    # 「search_for()メソッドで取得したレコードを全て格納
    @records = search_for(@model,@content).page(params[:page])
  end

  private

  # テーブルから検索条件に一致するレコードを収集するインスタンスメソッド
  def search_for(model,content)
    # モデル別に処理を分岐、あいまい検索(LIKE)条件は「部分一致」のみとしている。

    # ユーザの場合
    if model == 'user'
      User.where('nickname LIKE ?','%'+content+'%')
    # ガジェット（ガジェット名）の場合
    elsif model == 'gadget'
      Gadget.where('name LIKE ?','%'+content+'%')
    # ガジェット（タグ名）の場合
    elsif model == 'tag'
      tags = Tag.where('name LIKE ?','%'+content+'%')
      # 検索条件のタグ名に紐づくガジェット記事を、配列「gadget_articles」に格納
      # 「ingect」：たたみ込み演算を行うメソッド（eachメソッドよりもコードが短くなる）
      gadget_articles = tags.inject(init = []) {|result, tag| result + tag.gadgets}
      # 「page」メソッドで配列扱えるように「Kaminari.pagenate_array」を付加して返す
      return Kaminari.paginate_array(gadget_articles)
    end
  end

end
