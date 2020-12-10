FactoryBot.define do
  factory :user do
    id { 1 }
    name { 'テストユーザー' }
    email { 'test@test.com' }
    password_digest { 'test@test.com' }
  end
end
