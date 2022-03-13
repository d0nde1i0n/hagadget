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

  # 被フォロー側のアソシエーション
  # UserテーブルとRelationshipテーブルのアソシエーションだが、与フォロー側のアソシエーションと
  # 区別するために名称「reverse_of_relationship」を新たに付与している。
  has_many :reverse_of_relationship,class_name: 'Relationship',foregin_key: :followed_id,dependent: :destroy
  # 与フォロー側のアソシエーション
  has_many :relationships,foregin_key: :follower_id,dependent: :destroy
  # 被フォロー関係を通じて、自分をフォローする人を参照するためのアソシエーション
  has_many :follwers,through: :reverse_of_relationship, source: :follower
  # 与フォロー関係を通じて、自分がフォローする人を参照するためのアソシエーション
  has_many :followings,through: :relationship, source: :followed


  # バリデーション（検証）
  validates :last_name,:first_name,:nickname,length: {minimum: 1, maximum: 10}
  validates :introduction,length: {maximum: 200}

  # メソッド
  # ファイルが添付されているかを確認し、添付されていない場合には指定のファイルを添付するメソッド
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_profile_image'
  end

end
