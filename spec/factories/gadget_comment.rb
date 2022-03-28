FactoryBot.define do

  factory :gadget_comment do

    comment {Faker::Lorem.characters(number:50)}

  end

end