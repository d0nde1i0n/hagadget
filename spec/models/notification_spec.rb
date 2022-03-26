# frozen_string_literal: true

require 'rails_helper'

describe 'Notificationモデルのテスト' do

  it "有効な通知内容（コメント投稿）の場合は保存されるか" do
    occupation = create(:occupation)
    userA = create(:user,occupation_id: occupation.id)
    userB = create(:user,occupation_id: occupation.id)
    gadget = create(:gadget,user_id: userA.id)
    gadget_comment = create(:gadget_comment,gadget_id: gadget.id,user_id: userB.id)
    expect(FactoryBot.build(
      :notification,visitor_id: gadget_comment.user_id,visited_id: gadget.user_id,
      gadget_comment_id: gadget_comment.id,action: 0
      )).to be_valid
  end

  it "有効な通知内容（お気に入り登録）の場合は保存されるか" do
    occupation = create(:occupation)
    userA = create(:user,occupation_id: occupation.id)
    userB = create(:user,occupation_id: occupation.id)
    gadget = create(:gadget,user_id: userA.id)
    favorite = create(:favorite,user_id: userB.id,gadget_id: gadget.id)
    expect(FactoryBot.build(
      :notification,visitor_id: favorite.user_id,visited_id: gadget.user_id,
      gadget_id: gadget.id,action: 1
      )).to be_valid
  end

  it "有効な通知内容（フォロー）の場合は保存されるか" do
    occupation = create(:occupation)
    userA = create(:user,occupation_id: occupation.id)
    userB = create(:user,occupation_id: occupation.id)
    relationship = create(:relationship,follower_id: userB.id,followed_id: userA.id)
    expect(FactoryBot.build(
      :notification,visitor_id: relationship.follower_id,visited_id: relationship.followed_id,action: 2
      )).to be_valid
  end
end