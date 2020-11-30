require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: '失敗タスク詳細')
        expect(task).not_to be_valid
      end
    end
  end
  context 'タスクの詳細が空の場合' do
    it 'バリデーションにひっかかる' do
      # ここに内容を記載する
      task = Task.new(title: '失敗タスク', content: '')
      expect(task).not_to be_valid
    end
  end
  context 'タスクのタイトルと詳細に内容が記載されている場合' do
    it 'バリデーションが通る' do
      # ここに内容を記載する
      task = Task.new(title: '失敗タスク', content: '失敗タスク')
      expect(task).to be_valid
    end
  end
end
