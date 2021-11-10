FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Tea.type }
    temperature { Faker::Number.within(range: 50..220) }
    brew_time { Faker::Number.within(range: 60..360) }
  end
end
