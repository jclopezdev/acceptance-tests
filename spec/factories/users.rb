FactoryBot.define do
  factory :user do
    sequence(:email) { "email#{n}@email.com" }
    password 'secretsecret'
  end
end
