# frozen_string_literal: true

require 'rails_helper'

describe 'Tagモデルのテスト' do
  it "有効なタグの場合は保存されるか" do
    expect(FactoryBot.build(:tag)).to be_valid
  end
end