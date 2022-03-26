# frozen_string_literal: true

require 'rails_helper'

describe 'Relationshipモデルのテスト' do
  it "有効なフォロー登録内容の場合は保存されるか" do
    occupation = create(:occupation)
    userA = create(:user,occupation_id: occupation.id)
    userB = create(:user,occupation_id: occupation.id)
    expect(FactoryBot.build(:relationship,follower_id: userA.id,followed_id: userB.id)).to be_valid
  end
end