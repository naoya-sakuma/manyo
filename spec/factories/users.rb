FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { 'test@test.com' }
    password { 'test@test.com' }
    admin { 'true' }
  end
  factory :second_user, class: User do
    name { 'テストユーザー2' }
    email { 'test2@test.com' }
    password { 'test2@test.com' }
    admin { 'false' }
  end
end
