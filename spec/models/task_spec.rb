require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: '失敗タスク詳細')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗タスク', content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        user = FactoryBot.create(:user)
        task = FactoryBot.create(:task, user: user)
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    before do
      user = FactoryBot.create(:user)
      @task = FactoryBot.create(:task, user: user)
      @second_task = FactoryBot.create(:second_task, user: user)
      @third_task = FactoryBot.create(:third_task, user: user)
    end
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.only_title('タイトル')).to include(@task)
        expect(Task.only_title('タスク')).not_to include(@task)
        expect(Task.only_title('タイトル').count).to eq 3
        expect(Task.only_title('タスク').count).to eq 0
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.only_status('未着手')).to include(@task)
        expect(Task.only_status('着手中')).to include(@second_task)
        expect(Task.only_status('着手中')).not_to include(@third_task)
        expect(Task.only_status('完了')).to include(@third_task)
        expect(Task.only_status('完了').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.both_title_status('タイトル', '未着手')).to include(@task)
        expect(Task.both_title_status('タイトル', '着手中')).to include(@second_task)
        expect(Task.both_title_status('タイトル', '着手中')).not_to include(@third_task)
        expect(Task.both_title_status('タイトル', '完了').count).to eq 1
      end
    end
  end
end
