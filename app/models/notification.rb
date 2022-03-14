class Notification < ApplicationRecord

  # 通知が作成日の降順に並ぶようにデフォルト設定を変更
  default_scope -> {order(created_at: :desc)}

  # アソシエーション（関連付け）
  belongs_to :visitor,class_name: 'User'
  belongs_to :visited,class_name: 'User'
   # 「optional: true」：格納される値にnullを許可する。
  # （通常外部キーとなるカラムの値にnullが許可されていないため）
  belongs_to :gadget,optional: true
  belongs_to :gadget_comment,optional: true

  # バリデーション検証
  validates :action,presence: true
  # 「inclusion: {in: 〇〇}」：保存できる値を〇〇に制限する。
  validates :checked, inclusion: {in: [true,false]}
end
