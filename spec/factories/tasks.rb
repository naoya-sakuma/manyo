FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    title { 'タイトル1' }
    content { 'コンテント1' }
    expired_at { '2020-12-03' }
  end
  factory :second_task, class: Task do
    title { 'タイトル2' }
    content { 'コンテント２' }
    expired_at { '2020-12-02' }
  end
  factory :third_task, class: Task do
    title { 'タイトル3' }
    content { 'コンテント3' }
    expired_at { '2020-12-01' }
  end
end
