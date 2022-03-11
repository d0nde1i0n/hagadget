class Gadget < ApplicationRecord

  # アソシエーション（関連付け）
  belongs_to :user
  has_one_attached :gadgets_image

  # バリデーション（検証）
  validates :name,:manufacture_name,:price,:score, presence: true
  validates :description,length: {maximum: 300}

  # メソッド
  # ファイルが添付されているかを確認し、添付されていない場合には指定のファイルを添付するメソッド
  def get_gadget_image
    (gadgets_image.attached?) ? gadgets_image : 'no_image'
  end

end
