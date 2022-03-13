class Relationship < ApplicationRecord

  # アソシエーション（関連付け）
  # フォローする側のUserテーブルとのアソシエーション
  belongs_to :follower,class_name: 'User'
  # フォローする側のUserテーブルとのアソシエーション
  belongs_to :followed,class_name: 'User'
end
