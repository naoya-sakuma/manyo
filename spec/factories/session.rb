FactoryBot.define do
  factory :session do
    id { 1 }
    name { 'テスト' }
    email { 'test@test.com' }
    password_digest { 'test@test.com' }
  end
end
