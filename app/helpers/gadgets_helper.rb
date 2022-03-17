module GadgetsHelper

  # ガジェット一覧のソート機能に関連するヘルパーメソッド
  def sort_order(db_column, view_column)
    # データの並べ替え方法を決める
    #　昇順の場合は降順に、逆の場合は昇順になるような値を変数「direction」に格納
    # （DB上のカラム名とソート対象となるカラム名が一致していることが前提）
    direction = (db_column == sort_column && sort_direction == 'asc') ? 'desc' : 'asc'
    # データの並べ替え方法を変更するリンクの表示
    # パラメータとして引き渡す値に対応するキーとして「sort」と「direction」を設定
    link_to title,{ sort: db_column, direction: direction}
  end
end
