# frozen_string_literal: true

require 'rails_helper'

describe 'Occupationモデルのテスト' do
  it "有効なタグの場合は保存されるか" do
    expect(FactoryBot.build(:occupation)).to be_valid
  end
end