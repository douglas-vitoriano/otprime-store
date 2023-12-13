FactoryBot.define do
  factory :orderable do
    product { nil }
    cart { nil }
    quantity { 1 }
  end
end
