FactoryBot.define do
  factory :user do
    last_name {Faker::Name.last_name}
    first_name {Faker::Name.first_name}
    nickname {Faker::Name.name}
    introduction {Faker::Lorem.characters(number:50)}
    email {Faker::Internet.safe_email}
    password {Faker::Internet.password(min_length: 6)}
    occupation {Faker::Job.title}
  end
end