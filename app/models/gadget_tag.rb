class GadgetTag < ApplicationRecord
  
  # アソシエーション（関連付け）
  belongs_to :gadget
  belongs_to :tag
end
