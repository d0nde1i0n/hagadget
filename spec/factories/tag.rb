FactoryBot.define do

  factory :tag do
    name {Faker::JapaneseMedia::Naruto.character}
  end

end