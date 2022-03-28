# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveStorage::AnalyzeJob.queue_adapter = :inline
ActiveStorage::PurgeJob.queue_adapter = :inline

# 職種情報の設定
Occupation.create!([
  {name: 'IT・Web'},
  {name: '医療'},
  {name: '福祉'},
  {name: '美容・ファッション'},
  {name: '観光'},
  {name: '教育・保育'},
  {name: '学生'},
  {name: 'その他'}
  ])

# ユーザ情報の設定
[
  ['田中','太郎','タロウ座右衛門',rand(1..8),'よろしくおねがいします','tarou@hoge.hoge','hogehoge',
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-profile1.jpg"),
    filename: 'sample-profile1.jpg')
  ],
  ['田中','次郎','ガジェット大好き！',rand(1..8),'よろしくおねがいします','jirou@hoge.hoge','hogehoge',
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-profile2.jpg"),
    filename: 'sample-profile2.jpg')
  ],
  ['原田','影慧','ニュークリン',rand(1..8),'よろしくおねがいします','kagetoshi@hoge.hoge','hogehoge',
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-profile3.jpg"),
    filename: 'sample-profile3.jpg')
  ],
  ['岡','陸翔','かめらまん',rand(1..8),'よろしくおねがいします','rikuto@hoge.hoge','hogehoge',
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-profile4.jpg"),
    filename: 'sample-profile4.jpg')
  ],
  ['大迫','大志','はんぱねぇ',rand(1..8),'よろしくおねがいします','taishi@hoge.hoge','hogehoge',
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-profile5.jpg"),
    filename: 'sample-profile5.jpg')
  ],
  ['倉知','智美','メガネザル',rand(1..8),'よろしくおねがいします','tomomi@hoge.hoge','hogehoge',
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-profile6.jpg"),
    filename: 'sample-profile6.jpg')
  ],
  ['中島','愛','アナーキー',rand(1..8),'よろしくおねがいします','ai@hoge.hoge','hogehoge',
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-profile7.jpg"),
    filename: 'sample-profile7.jpg')
  ],
  ['吉川','真実','ボーダーマリン',rand(1..8),'よろしくおねがいします','manami@hoge.hoge','hogehoge',
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-profile8.jpg"),
    filename: 'sample-profile8.jpg')
  ],
  ['関口','美加子','いちご大好き',rand(1..8),'よろしくおねがいします','mikako@hoge.hoge','hogehoge',
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-profile9.jpg"),
    filename: 'sample-profile9.jpg')
  ],
  ['真野','久美','タラコマーカー',rand(1..8),'よろしくおねがいします','kumi@hoge.hoge','hogehoge',
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-profile10.jpg"),
    filename: 'sample-profile10.jpg')
  ]
].each do |last_name,first_name,nickname,occupation_id,introduction,email,password,image|
  User.create!({
      last_name: last_name,first_name: first_name,nickname: nickname,
      occupation_id: occupation_id,introduction: introduction,email: email,password: password,
      profile_image: image
    })
  end


# ガジェット記事情報の設定
[
  [ 1,'a phone 31','ENItaro-1',130000,4.0,'デザイン・操作感は文句なしです！ ただ、値段が高すぎるかも・・・',
    "2022-03-10 07:20:29.915042000 +0000",
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-gadget1.jpg"),
    filename: 'sample-gadget1.jpg')
  ],
  [ 1,'a phone 30 sm','ENItaro-1',50000,5.0,'デザイン・操作感・値段の全てで文句なしです！',
    "2022-03-10 07:20:29.915042000 +0000",
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-gadget2.jpg"),
    filename: 'sample-gadget2.jpg')
  ],
  [ 1,'a watch 3','ENItaro-1',80000,4.5,'デザインが最高です！',
    "2022-03-12 07:20:29.915042000 +0000",
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-gadget3.jpg"),
    filename: 'sample-gadget3.jpg')
  ],
  [ 1,'earphone ex','gajekome',100000,3.0,'デザイン・操作感は文句なしです！ ただ、値段が高すぎるかも・・・',
    "2022-03-12 07:20:29.915042000 +0000",
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-gadget4.jpg"),
    filename: 'sample-gadget4.jpg')
  ],
  [ 1,'mt-1 ','gajekome',50000,5.0,'デザイン・操作感・値段の全てで文句なしです！',
    "2022-03-13 07:20:29.915042000 +0000",
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-gadget5.jpg"),
    filename: 'sample-gadget5.jpg')
  ],
  [ 1,'tarsan gam','gajekome',80000,4.5,'デザインが最高です！',
    "2022-03-17 07:20:29.915042000 +0000",
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-gadget6.jpg"),
    filename: 'sample-gadget6.jpg')
  ],
  [ 2,'hanson','ENItaro-1',80000,4.5,'デザインが最高です！',
    "2022-03-15 07:20:29.915042000 +0000",
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-gadget7.jpg"),
    filename: 'sample-gadget7.jpg')
  ],
  [ 3,'denson','gajekome',10000,4.0,'デザイン・操作感は文句なしです！ ただ、値段が高すぎるかも・・・',
    "2022-03-20 07:20:29.915042000 +0000",
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-gadget8.jpg"),
    filename: 'sample-gadget8.jpg')
  ],
  [ 4,'camera 8x8','gajekome',50000,5.0,'デザイン・操作感・値段の全てで文句なしです！',
    "2022-03-22 07:20:29.915042000 +0000",
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-gadget9.jpg"),
    filename: 'sample-gadget9.jpg')
  ],
  [ 5,'a phone 31 XL','gajekome',80000,4.5,'デザインが最高です！',
    "2022-03-22 07:20:29.915042000 +0000",
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-gadget10.jpg"),
    filename: 'sample-gadget10.jpg')
  ],
  [ 6,'gatun','gajekome',80000,4.5,'デザインが最高です！',
    "2022-03-16 07:20:29.915042000 +0000",
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-gadget1.jpg"),
    filename: 'sample-gadget1.jpg')
  ],
  [ 7,'x fan','ENItaro-1',80000,4.5,'デザインが最高です！',
    "2022-03-17 07:20:29.915042000 +0000",
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-gadget2.jpg"),
    filename: 'sample-gadget2.jpg')
  ],
  [ 8,'karton','gajekome',130000,4.0,'デザイン・操作感は文句なしです！ ただ、値段が高すぎるかも・・・',
    "2022-03-18 07:20:29.915042000 +0000",
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-gadget3.jpg"),
    filename: 'sample-gadget3.jpg')
  ],
  [ 9,'terupon','gajekome',50000,5.0,'デザイン・操作感・値段の全てで文句なしです！',
    "2022-03-24 07:20:29.915042000 +0000",
    ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-gadget4.jpg"),
    filename: 'sample-gadget4.jpg')
  ],
  [ 10,'mt-2','gajekome',80000,4.5,'デザインが最高です！',"2022-03-27 07:20:29.915042000 +0000"]

].each do |user_id,name,manufacture_name,price,score,description,created_at,image|
  Gadget.create!({
      user_id: user_id,name: name,manufacture_name: manufacture_name,price: price,
      score: score,description: description,created_at: created_at,gadget_image: image
    })
  end


# タグ情報の設定
[
  'デジタル','スマートフォン','時計','イヤホン', 'ヘッドセット',
  'スピーカー','手のひらサイズ','カメラ','なにこれ？'
].each do |name|
  Tag.create!({
    name: name
  })
end


# ガジェットタグ情報の設定
[
  [1,1],[1,2],#a phone 31
  [2,1],[2,2],#a phone 3
  [3,1],[3,3],#a watch 3
  [4,4],#earphone ex
  [5,5],#mt-1
  [6,1],[6,6],[6,7],#tarsan gam
  [7,1],[7,4],[7,7],#hanson
  [8,9],#denson
  [9,8],#camera 8x8
  [10,2],[10,9],#a phone 31 XL
  [11,1],[11,2],#gatun
  [12,1],[12,2],#x fan
  [13,1],[13,3],#kartun
  [14,4],#terupon
  [15,5],#mt-2

].each do |gadget_id,tag_id|
  GadgetTag.create!({
    gadget_id: gadget_id,tag_id: tag_id
  })
end


# フォロー情報の設定
[
  [2,1],[3,1],#タロウ座右衛門
  [1,2]#ガジェット大好き！

].each do |follower_id,followed_id|
  Relationship.create!({
    follower_id: follower_id,followed_id: followed_id
  })
end

# コメント情報の設定
[
  [2,1,"私には高すぎます・・・"]#a phone 31

].each do |user_id,gadget_id,comment|
  GadgetComment.create!({
    user_id: user_id,gadget_id: gadget_id,comment: comment
  })
end

# お気に入り情報の設定
[
  [2,1]#a phone 31

].each do |user_id,gadget_id|
  Favorite.create!({
    user_id: user_id,gadget_id: gadget_id
  })
end

# 通知情報の設定
[
  [2,1,nil,1,0],#コメント関連の通知
  [2,1,nil,nil,2],[3,1,nil,nil,2],[1,2,nil,nil,2],#フォロー関連の通知
  [2,1,1,nil,1]#お気に入り関連の通知
].each do |visitor_id,visited_id,gadget_id,gadget_comment_id,action|
  Notification.create!({
    visitor_id: visitor_id,visited_id: visited_id,gadget_id: gadget_id,
    gadget_comment_id: gadget_comment_id,action: action
  })
end

