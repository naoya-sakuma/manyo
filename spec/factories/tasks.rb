FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    title { 'タイトル1' }
    content { 'コンテント1' }
  end
  factory :second_task, class: Task do
    title { 'タイトル2' }
    content { 'コンテント２' }
  end
end
