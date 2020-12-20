FactoryBot.define do
  factory :task do
    title { 'タイトル1' }
    content { 'コンテント1' }
    expired_at { '2020-12-03' }
    status {'未着手'}
    priority { '高' }

    after(:build) do |task|
      label = create(:label)
      task.labellings << build(:labelling, task: task, label: label)
    end
    user
  end

  factory :second_task, class: Task do
    title { 'タイトル2' }
    content { 'コンテント２' }
    expired_at { '2020-12-02' }
    status {'着手中'}
    priority { '中' }
    user
  end

  factory :third_task, class: Task do
    title { 'タイトル3' }
    content { 'コンテント3' }
    expired_at { '2020-12-01' }
    status {'完了'}
    priority { '低' }
    user
  end
end
