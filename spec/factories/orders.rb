FactoryBot.define do
  factory :order do
    user { nil }
    cart { nil }
    status { "MyString" }
  end
end
