class Gadget < ApplicationRecord

  # アソシエーション（関連付け）
  belongs_to :user
  has_one_attached :gadget_image
  has_many :favorites,dependent: :destroy
  has_many :gadget_comments,dependent: :destroy
  has_many :notifications,dependent: :destroy
  has_many :gadget_tags,dependent: :destroy
  has_many :tags,through: :gadget_tags

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

  # お気に入り登録後に通知レコードを登録するメソッド
  def create_notification_favorite!(temp_current_user)

    # notificationsテーブルからwhere内の条件に一致するレコードを検索し、tempに格納
    temp = Notification.where(
      ["visitor_id = ? and visited_id = ? and gadget_id = ? and action = ?",
      temp_current_user.id, user_id, id, Notification.action_types[:favorited_to_own_post]
      ])

    # notificationsテーブルに該当するレコードがない場合のみ、通知レコードを作成
    if temp.blank?
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

  # コメント後に通知レコードを登録するメソッド
  def create_notification_comment!(temp_current_user,temp_gadget_comment_id)

    # コメントテーブルから。投稿ガジェット記事に対してコメントしているユーザ（自分以外）のレコードを取得
    # 「distnct」:重複のない値を取得するメソッド
    temp_ids = GadgetComment.select(:user_id).where(gadget_id: id).where.not(user_id: temp_current_user.id).distinct
    # 投稿ガジェット記事にコメントしたユーザ全員に通知を送る
    temp_ids.each do |temp_id|
      save_notification_comment!(temp_current_user,temp_gadget_comment_id,temp_id['user_id'])
    end

    # 投稿ガジェットに対して初めてコメントされた場合、投稿者に通知を送る
    save_notification_comment!(temp_current_user.temp_gadget_comment_id,user_id) if temp_ids.blank?
  end

   # コメント後に通知レコードを保存するメソッド
  def save_notification_comment!(temp_current_user,temp_gadget_comment_id,temp_visited_id)
    notification = temp_current_user.active_notifications.new(
      gadget_id: id,
      gadget_comment_id: temp_gadget_comment_id,
      visited_id: temp_visited_id,
      action: Notification.action_types[:commented_to_own_post]
      )

    # ユーザAが投稿したガジェット記事に対して、ユーザA自身がコメント投稿した場合、通知済みとする
    # (上記の場合に、通知が送信されるのを防止するため)
    notification.checked = true if notification.visitor_id == notification.visited_id

    # バリデーションエラーがない場合のみ、データベースに通知レコードを登録する。
    notification.save if notification.valid?
  end

  # 作成されたタグを登録するためのインスタンスメソッド
  def save_tag(sent_tags)
    # tagsテーブルに現在登録されているタグの要素をcurrent_tagsに配列情報として格納
    # 「self.〇〇」：クラスメソッド。このファイルで言うと「self」は「Gadget」を指す。
    # 「pluck」：引数に指定したカラムの値を配列として返すメソッド
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    #「現在登録されているタグ情報」から「ユーザが記載したタグ情報」を引いたときに
    # 残った要素を「古いタグ情報：old_tags」として格納
    old_tags = current_tags - sent_tags
    #「ユーザが記載したタグ情報」から「現在登録されているタグ情報」を引いたときに
    # 残った要素を「新しいタグ情報：new_tags」として格納
    new_tags = sent_tags - current_tags

    # 古いタグ情報を全て削除
    old_tags.each do |old_name|
      # old_nameをキーとしてタグテーブルから対象レコードを検索し、そのレコードを削除
      self.tags.delete Tag.find_by(name:old_name)
    end

    # 新しいタグ情報を全て登録
    new_tags.each do |new_name|
      # new_nameをキーとしてタグテーブルから対象レコードが存在するか検索した後、
      #存在しない場合は新規作成、存在する場合はそのままの情報を変数に格納してそれぞれ保存。
      gadget_tag = Tag.find_or_create_by(name:new_name)
      self.tags << gadget_tag
      # 「find_or_create_by」：条件を指定して初めの1件を取得し1件もなければクラスインスタンスを作成するメソッド
    end
  end

end
