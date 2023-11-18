FactoryBot.define do
  factory :user do
    transient do
      name { Faker::Name.name }
    end

    email { "#{name.parameterize}@#{Faker::Internet.domain_name}" }
    password { Faker::Alphanumeric.alpha(number: 10) }
    password_confirmation { password }
    name { name }
    phone { Faker::PhoneNumber.cell_phone }
  end
end
