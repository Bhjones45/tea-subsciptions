FactoryBot.define do
  factory :subscription do
    title { Faker::Tea.variety(type: 'Green') }
    price { Faker::Number.decimal(l_digits: 2) }
    status { ['active', 'inactive'].sample }
    frequency { ['monthly', 'yearly'].sample }
  end
end
