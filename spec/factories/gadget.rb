FactoryBot.define do

  factory :gadget do
    name {Faker::Device.model_name}
    manufacture_name {Faker::Device.manufacturer}
    price {Faker::Number.number(digits: 7)}
    # scoreに0〜5(0.5刻み）の数値を格納する処理開始
    ones_place = Faker::Number.between(from: 0, to: 4)
    about_a_tenth = Faker::Number.between(from: 0.0, to: 0.9)
    if about_a_tenth < 0.3
      score = ones_place
    elsif 0.3 <= about_a_tenth && about_a_tenth < 0.6
      score = ones_place + 0.5
    elsif 0.6 <= about_a_tenth
      score = ones_place + 1
    end
    # 処理おわり
    score { score }
    description {Faker::Lorem.characters(number: 50)}

  end
end