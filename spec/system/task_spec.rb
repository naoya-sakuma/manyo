require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'タスク名', with: 'タスク1'
        fill_in 'タスク詳細', with: 'タスク1の詳細'
        click_on '登録'
        expect(page).to have_content 'タスク1'
        expect(page).to have_content 'タスク1の詳細'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task)
        visit tasks_path
        expect(page).to have_content 'タイトル1'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task = FactoryBot.create(:task)
        task = FactoryBot.create(:second_task)
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'タイトル2'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         # テストで使用するためのタスクを作成
         task = FactoryBot.create(:task, id: 1, title: 'task')
         # タスク詳細ページに遷移
         visit task_path(1)
         # 遷移したページでtaskがhave_contentされているかexpect(確認)する
         expect(page).to have_content 'task'
       end
     end
  end
end
