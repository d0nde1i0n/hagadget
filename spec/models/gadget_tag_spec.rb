require 'rails_helper'

describe 'GadgetTagモデルのテスト' do

  it "有効な登録内容の場合は保存されるか" do
    occupation = create(:occupation)
    user = create(:user,occupation_id: occupation.id)
    gadget = create(:gadget,user_id: user.id)
    tag = create(:tag)
    expect(FactoryBot.build(:gadget_tag,gadget_id: gadget.id,tag_id: tag.id)).to be_valid
  end

end