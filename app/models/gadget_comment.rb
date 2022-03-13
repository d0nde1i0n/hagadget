class GadgetComment < ApplicationRecord

  # アソシエーション（関連付け）
  belongs_to :user
  belongs_to :gadget

  # バリデーション
  validates :comment,length: {minimum: 1,maximum: 150}
end
