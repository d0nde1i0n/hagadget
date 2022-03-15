class GadgetComment < ApplicationRecord

  # アソシエーション（関連付け）
  belongs_to :user
  belongs_to :gadget
  has_many :notifications,dependent: :destroy

  # バリデーション
  validates :comment,length: {minimum: 1,maximum: 150}
end
