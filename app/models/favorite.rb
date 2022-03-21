class Favorite < ApplicationRecord

  # アソシエーション（関連付け）
  belongs_to :user
  belongs_to :gadget

  # バリデーション(検証)

  # validates_uniqueness_of：値が重複していないかを検証
  # scope:一意性チェックの範囲を限定する別の属性を指定
  validates_uniqueness_of :gadget_id, scope: :user_id
end
