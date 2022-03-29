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
  has_many :reverse_of_relationships,class_name: 'Relationship',foreign_key: :followed_id,dependent: :destroy
  # 与フォロー側のアソシエーション
  has_many :relationships,foreign_key: :follower_id,dependent: :destroy
  # 被フォロー関係を通じて、自分をフォローする人を参照するためのアソシエーション
  has_many :followers,through: :reverse_of_relationships, source: :follower
  # 与フォロー関係を通じて、自分がフォローする人を参照するためのアソシエーション
  has_many :followings,through: :relationships, source: :followed

  # 通知を送信する側とのアソシエーション
  has_many :active_notifications,class_name: 'Notification',foreign_key: :visitor_id,dependent: :destroy
  # 通知を受信する側とのアソシエーション
  has_many :passive_notifications,class_name: 'Notification',foreign_key: :visited_id,dependent: :destroy

  # バリデーション（検証）
  validates :last_name,:first_name,:nickname,length: {minimum: 1, maximum: 10}
  validates :introduction,length: {maximum: 200}

  # メソッド
  # ファイルが添付されているかを確認し、添付されていない場合には指定のファイルを添付するメソッド
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_profile_image.png'
  end

  # reverse_of_relationshipsテーブルのカラムfollower_idにuser.idが存在するかを確認するメソッド
  def is_follower_by?(user)
    # フォローするユーザから見た中間テーブルのため、reverse_of_relationshipを指定。
    reverse_of_relationships.where(follower_id: user.id).exists? unless user.nil?
  end

  # フォローされた後に通知を作成するメソッド
  def create_notification_follow!(temp_current_user)

    # notificationsテーブルからwhere内の条件に一致するレコードを検索し、tempに格納
    temp = Notification.where(
      ["visitor_id = ? and visited_id = ? and action = ?",
        temp_current_user.id,id,Notification.action_types[:followed_me]
      ])

    # notificationsテーブルに該当するレコードがない場合のみ、通知レコードを作成
    if temp.blank?
      # 「.blank?」：対象オブジェクトが空白の場合にtrueを返すメソッド
      # ここでいう「空白」とは、「空文字」、「空白」、「false」、「nil」を指す。

      # Notificationクラスの空のインスタンスを作成後、各カラムに値を追加
      notification = temp_current_user.active_notifications.new(
        visited_id: id, action: Notification.action_types[:followed_me]
      )

      # バリデーションエラーがない場合のみ、データベースに通知レコードを登録する。
      notification.save if notification.valid?
    end
  end

  # ゲストユーザログイン時にユーザ情報を作成するメソッド
  def self.guest
    find_or_create_by!(nickname: 'guestuser' ,email: 'guest@example.com') do |user|
      # バリデーションに引っかかるカラムに値をセット
      user.password = SecureRandom.urlsafe_base64
      user.last_name = "guest"
      user.first_name = "user"
      user.nickname = "guestuser"
      user.occupation_id = 1
    end
  end

end
