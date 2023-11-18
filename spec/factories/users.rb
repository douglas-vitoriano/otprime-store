FactoryBot.define do
  factory :user do
    transient do
      random_name { Faker::Name.name }
    end

    email { "#{random_name.parameterize}@#{Faker::Internet.domain_name}" }
    password { Faker::Alphanumeric.alpha(number: 10) }
    password_confirmation { password }
    name { random_name }
    phone_number { Faker::PhoneNumber.cell_phone }
  end
end
