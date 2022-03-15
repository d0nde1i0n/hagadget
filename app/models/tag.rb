class Tag < ApplicationRecord

  # アソシエーション（関連付け）
  has_many :gadget_tags,destroy: :destroy
  has_many :gadgets,through: :gadget_tags

  # バリデーション（検証）
  validates :name,length: {minimum: 1,maximum: 15}

end
