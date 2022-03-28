FactoryBot.define do
  factory :occupation do
    name {Faker::Job.title}
  end
end