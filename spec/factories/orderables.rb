FactoryBot.define do
  factory :orders do
    product { nil }
    cart { nil }
    quantity { 1 }
  end
end
