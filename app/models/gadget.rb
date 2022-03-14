class Gadget < ApplicationRecord

  # アソシエーション（関連付け）
  belongs_to :user
  has_one_attached :gadget_image
  has_many :favorites,dependent: :destroy
  has_many :gadget_comments,dependent: :destroy
  has_many :notifications,dependent: :destroy

  # バリデーション（検証）
  validates :name,:manufacture_name,:price,:score, presence: true
  validates :description,length: {minimum: 1,maximum: 300}

  # メソッド
  # ファイルが添付されているかを確認し、添付されていない場合には指定のファイルを添付するメソッド
  def get_gadget_image
    (gadget_image.attached?) ? gadget_image : 'no_image'
  end

  # DBから取得した投稿日を整形するためのメソッド
  def date_conversion(post_date)
    dw = ["日", "月", "火", "水", "木", "金", "土"]
    # strftime:引数で指定された書式文字列に従い、日付を表現する文字列を返す。
    # wday:曜日に対応する数値（0~6)を返す（例）日：0、土：6
    date_after_conversion = post_date.strftime("%Y/%m/%d (#{dw[post_date.wday]})")
    return date_after_conversion
  end

  # favoritesテーブルのカラムuser_idにuser.idが存在するかを確認するメソッド
  def favorited_by?(user)
    # where:指定した条件に一致するレコードを全て取得する
    # exit?:指定した条件が存在するか"true"or"false"で返す
    favorites.where(user_id: user.id).exists?
  end

  # お気に入り登録された後に通知を作成するメソッド
  def create_notification_favorite!(temp_current_user)

    # notificationsテーブルからwhere内の条件に一致するレコードを検索し、tempに格納
    temp = Notification.where(
      ["visitor_id = ? and visited_id = ? and gadget_id = ? and action = ?",
      temp_current_user.id, user_id, id, Notification.action_types[:favorited_to_own_post]
      ])

    # notificationsテーブルに該当するレコードがない場合のみ、通知レコードを作成
    if temp.blank
      # 「.blank?」：対象オブジェクトが空白の場合にtrueを返すメソッド
      # ここでいう「空白」とは、「空文字」、「空白」、「false」、「nil」を指す。

      # Notificationクラスの空のインスタンスを作成後、各カラムに値を追加
      notification = temp_current_user.active_notifications.new(
        gadget_id: id,visited_id: user_id, action: Notification.action_types[:favorited_to_own_post]
        )

      # ユーザAが投稿したガジェット記事に対して、ユーザA自身がお気に入り登録した場合、通知済みとする
      # (上記の場合に、通知が送信されるのを防止するため)
      notification.checked = true if notification.visitor_id == notification.visited_id

      # バリデーションエラーがない場合のみ、データベースに通知レコードを登録する。
      notification.save if notification.valid?

    end
  end

end
