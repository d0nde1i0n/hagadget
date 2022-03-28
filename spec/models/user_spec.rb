# frozen_string_literal: true

require 'rails_helper'

describe 'Userモデルのテスト' do
  it "有効なユーザ内容の場合は保存されるか" do
    # usersテーブルの外部キーとして設定されているoccupationデータを作成
    # （上記を先に作成しないと、永遠にエラーが出る・・・）
    occupation = create(:occupation)
    expect(FactoryBot.build(:user,occupation_id: occupation.id)).to be_valid
  end
end