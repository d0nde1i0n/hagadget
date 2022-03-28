# frozen_string_literal: true

require 'rails_helper'

describe 'Gadgetモデルのテスト' do
  it "有効なガジェット記事内容の場合は保存されるか" do
    # usersテーブルの外部キーとして設定されているoccupationデータを作成
    # （上記を先に作成しないと、永遠にエラーが出る・・・）
    occupation = create(:occupation)
    user = create(:user,occupation_id: occupation.id)
    expect(FactoryBot.build(:gadget,user_id: user.id)).to be_valid
  end
end