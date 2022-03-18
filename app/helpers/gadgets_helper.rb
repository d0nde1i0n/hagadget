module GadgetsHelper

  # ガジェット一覧のソート機能の表示部分に関連するヘルパーメソッド

  # データの並び替え順を昇順に変更するリンクを表示するメソッド
  def sort_asc(column_to_be_sorted)
    link_to "昇順", {:column => column_to_be_sorted, :direction => "asc"},class: "btn btn-outline-primary btn-sm"
  end

  # データの並び替え順を降順に変更するリンクを表示するメソッド
  def sort_desc(column_to_be_sorted)
    link_to "降順", {:column => column_to_be_sorted, :direction => "desc"},class: "btn btn-outline-primary btn-sm"
  end

end
