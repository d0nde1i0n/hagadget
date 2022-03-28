# frozen_string_literal: true

require 'rails_helper'

describe 'Favoriteモデルのテスト' do
  it "有効なお気に入り登録内容の場合は保存されるか" do
    occupation = create(:occupation)
    user = create(:user,occupation_id: occupation.id)
    gadget = create(:gadget,user_id: user.id)
    expect(FactoryBot.build(:favorite,user_id: user.id,gadget_id: gadget.id)).to be_valid
  end
end