class Gadget < ApplicationRecord

  # アソシエーション（関連付け）
  belongs_to :user
  has_one_attached :gadget_image

  # バリデーション（検証）
  validates :name,:manufacture_name,:price,:score, presence: true
  validates :description,length: {maximum: 300}

  # メソッド
  # ファイルが添付されているかを確認し、添付されていない場合には指定のファイルを添付するメソッド
  def get_gadget_image
    (gadget_image.attached?) ? gadget_image : 'no_image'
  end
  
  # DBから取得した投稿日を整形するためのメソッド
  def date_conversion(post_date)
    dw = ["日", "月", "火", "水", "木", "金", "土"]
    date_after_conversion = post_date.strftime("%Y/%m/%d (%a)")
    return date_after_conversion
  end

end
