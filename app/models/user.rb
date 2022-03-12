class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション(関連付け)
  belongs_to :occupation
  has_one_attached :profile_image
  has_many :gadgets,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :gadget_comments,dependent: :destroy

  # バリデーション（検証）
  validates :last_name,:first_name,:nickname,length: {minimum: 1, maximum: 10}
  validates :introduction,length: {maximum: 200}

  # メソッド
  # ファイルが添付されているかを確認し、添付されていない場合には指定のファイルを添付するメソッド
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_profile_image'
  end

end
